//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Alex Paz on 19/01/2022.
//

import Foundation

extension Bundle {
//    func decode(_ file: String) -> [String: Astronaut] {
    func decode<T: Codable>(_ file: String) -> T { // use of generics
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd" // attention to M capitalization
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        return loaded
    }
}
