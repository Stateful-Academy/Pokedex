//
//  Pokemon.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import Foundation

class Pokemon {
    enum Keys: String {
        case name = "name"
        case id = "id"
        case moves = "moves"
        case sprites = "sprites"
        case frontShiny = "front_shiny"
        case move = "move"
    }
    
    let name: String
    let id: Int
    let moves: [String]
    let spritePath: String
    let height: Int
    let abilities: [String]
   
    init(name:String, id:Int, moves:[String], spritePosterPath: String, height: Int, abilities: [String]){
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePosterPath
        self.height = height
        self.abilities = abilities
    }
}

extension Pokemon {
    convenience init?(dictionary:[String:Any]) {
        guard let name = dictionary[Keys.name.rawValue] as? String,
              let id = dictionary[Keys.id.rawValue] as? Int,
              let spriteDict = dictionary[Keys.sprites.rawValue] as? [String:Any],
              let spritePosterPath = spriteDict[Keys.frontShiny.rawValue] as? String,
              let height = dictionary["height"] as? Int,
              let abilitiesArray = dictionary["abilities"] as? [[String:Any]],
              let movesArray = dictionary[Keys.moves.rawValue] as? [[String:Any]] else {return nil}
        
        var abilities: [String] = []
        
        for abilityDict in abilitiesArray {
            guard let secondAbilityDict = abilityDict["ability"] as? [String:Any], let name = secondAbilityDict["name"] as? String else {return nil}
            
            abilities.append(name)
        }
        
        var moves: [String] = []
        
        for dict in movesArray {
            guard let moveDict = dict[Keys.move.rawValue] as? [String:Any],
                  let moveName = moveDict[Keys.name.rawValue] as? String else {return nil}
            
            moves.append(moveName)
        }
        self.init(name: name, id: id, moves:moves, spritePosterPath: spritePosterPath, height: height,abilities: abilities)
    }
}
