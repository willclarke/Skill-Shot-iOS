//
//  Location.swift
//  Skill Shot
//
//  Created by Will Clarke on 12/21/15.
//
//

import Foundation
import Alamofire

class Location {
    var identifier: String
    var name: String
    var address: String?
    var city: String?
    var postalCode: String?
    var latitude: Float?
    var longitude: Float?
    var phone: String?
    var URL: String?
    var allAges: Bool
    var numGames: Int
    var machines: [Machine]?
    
    required init(identifier: String, name: String, allAges: Bool = false, numGames: Int = 0) {
        self.identifier = identifier
        self.name = name
        self.allAges = allAges
        self.numGames = numGames
    }
    
    func loadDetails(serverData: [String: AnyObject]) {
        if let validAddress = serverData["address"] as? String {
            self.address = validAddress
        }
        if let validPostalCode = serverData["postal_code"] as? String {
            self.postalCode = validPostalCode
        }
        if let validLat = serverData["latitude"] as? Float {
            self.latitude = validLat
        }
        if let validLon = serverData["longitude"] as? Float {
            self.longitude = validLon
        }
        if let validPhone = serverData["phone"] as? String {
            self.phone = validPhone
        }
        if let validURL = serverData["url"] as? String {
            self.URL = validURL
        }
        if let validAllAges = serverData["all_ages"] as? Bool {
            self.allAges = validAllAges
        }
        if let validGames = serverData["num_games"] as? Int {
            self.numGames = validGames
        }
        if let validMachines = serverData["machines"] as? [[String : AnyObject]] {
            var machineList = [Machine]()
            for machineData in validMachines {
                if let validMachineIdentifier = machineData["id"] as? Int, validTitleData = machineData["title"] as? [String : AnyObject] {
                    if let validTitleIdentifier = validTitleData["id"] as? Int, validTitleName = validTitleData["name"] as? String {
                        let newMachine = Machine(identifier: validMachineIdentifier, titleIdentifier: validTitleIdentifier, titleName: validTitleName)
                        machineList.append(newMachine)
                    }
                }
            }
            self.machines = machineList
        }
    }
}

class LocationList {
    var locations = [Location]()
    
    func loadList() {
        Alamofire.request(.GET, "\(baseAPI)locations.json").responseJSON { response in
            guard response.result.isSuccess else {
                return
            }
            if let validLocationData = response.result.value as? [[String : AnyObject]] {
                for locationData in validLocationData {
                    if let validIdentifier = locationData["id"] as? String, validName = locationData["name"] as? String {
                        let newLocation = Location(identifier: validIdentifier, name: validName)
                        newLocation.loadDetails(locationData)
                    }
                }
            }
        }
    }
}