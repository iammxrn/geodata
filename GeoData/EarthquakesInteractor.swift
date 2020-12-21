//
//  Interactor.swift
//  GeoData
//
//  Created by Roman Mogutnov on 21.12.2020.
//

import Foundation


enum EarthquakesInteractorBuilder {
    
    static func build() -> EarthquakesInteractor {
        let networkProvider = NetworkProvider()
        
        let earthquakesService = EarthquakesService(networkProviderProtocol: networkProvider)
        
        let interactor = EarthquakesInteractor(earthquakesService: earthquakesService)
        
        return interactor
    }
}

final class EarthquakesInteractor {
    
    
    // MARK: - Private Properties
    
    private let earthquakesService: EarthquakesServiceProtocol
    
    private let queue = DispatchQueue(label: "com.geodata.earthquakes-interactor-queue",
                                      qos: .utility,
                                      attributes: .concurrent)
    
    
    // MARK: - Init
    
    init(earthquakesService: EarthquakesServiceProtocol) {
        self.earthquakesService = earthquakesService
    }
    
    
    // MARK: - Public Methods
    
    func loadData() {
        queue.async {
            self.earthquakesService.fetchEarthquakesData { earthquake, error in
                if let error = error {
                    print(error)
                }
                
                if let earthquake = earthquake {
                    print(earthquake)
                }
            }
        }
    }
    
}