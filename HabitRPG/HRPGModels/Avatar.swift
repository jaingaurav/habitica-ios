//
//  Avatar.swift
//  Habitica
//
//  Created by Phillip Thelen on 07.02.18.
//  Copyright © 2018 HabitRPG Inc. All rights reserved.
//

import Foundation
import Habitica_Models

@objc
protocol Avatar {

    var background: String? { get }
    var chair: String? { get }
    var back: String? { get }
    var skin: String? { get }
    var shirt: String? { get }
    var armor: String? { get }
    var body: String? { get }
    var hairColor: String? { get }
    var hairBase: String? { get }
    var hairBangs: String? { get }
    var hairMustache: String? { get }
    var hairBeard: String? { get }
    var eyewear: String? { get }
    var head: String? { get }
    var headAccessory: String? { get }
    var hairFlower: String? { get }
    var shield: String? { get }
    var weapon: String? { get }
    var visualBuff: String? { get }
    var mount: String? { get }
    var knockout: String? { get }
    var pet: String? { get }

    var isSleep: Bool { get }
    var size: String? { get }
}

extension Avatar {
    
    private func isValid(_ value: String?) -> Bool {
        return value?.count ?? 0 > 0
    }
    
    private func isAvailableGear(_ value: String?) -> Bool {
        return value?.contains("base_0") != true
    }
    
    func getViewDictionary(showsBackground: Bool, showsMount: Bool, showsPet: Bool, isFainted: Bool) -> [String: Bool] {
        return [
            "background": showsBackground && isValid(background),
            "mount-body": showsMount && isValid(mount),
            "chair": isValid(chair) && chair != "none",
            "back": isValid(back) && isAvailableGear(back),
            "skin": isValid(skin),
            "shirt": isValid(shirt),
            "armor": isValid(armor) && isAvailableGear(armor),
            "body": isValid(body) && isAvailableGear(body),
            "head_0": true,
            "hair-base": isValid(hairBase) && hairBase != "0",
            "hair-bangs": isValid(hairBangs) && hairBangs != "0" ,
            "hair-mustache": isValid(hairMustache) && hairMustache != "0",
            "hair-beard": isValid(hairBeard) && hairBeard != "0",
            "eyewear": isValid(eyewear) && isAvailableGear(eyewear),
            "head": isValid(head) && isAvailableGear(head),
            "head-accessory": isValid(headAccessory) && isAvailableGear(headAccessory),
            "hair-flower": isValid(hairFlower) && hairFlower != "0",
            "shield": isValid(shield) && isAvailableGear(shield),
            "weapon": isValid(weapon) && isAvailableGear(weapon),
            "visual-buff": isValid(visualBuff),
            "mount-head": showsMount && isValid(mount),
            "zzz": isSleep && !isFainted,
            "knockout": isFainted,
            "pet": showsPet && isValid(pet)
        ]
    }
    
    func getFilenameDictionary() -> [String: String?] {
        return [
            "background": "background_\(background ?? "")",
            "mount-body": "Mount_Body_\(mount ?? "")",
            "chair": "chair_\(chair ?? "")",
            "back": back,
            "skin": isSleep ? "skin_\(skin ?? "")_sleep" : "skin_\(skin ?? "")",
            "shirt": "\(size ?? "slim")_shirt_\( shirt ?? "")",
            "armor": "\(size ?? "slim")_\(armor ?? "")",
            "body": body,
            "head_0": "head_0",
            "hair-base": "hair_base_\(hairBase ?? "")_\(hairColor ?? "")",
            "hair-bangs": "hair_bangs_\(hairBangs ?? "")_\(hairColor ?? "")",
            "hair-mustache": "hair_mustache_\(hairMustache ?? "")_\(hairColor ?? "")",
            "hair-beard": "hair_beard_\(hairBeard ?? "")_\(hairColor ?? "")",
            "eyewear": eyewear,
            "head": head,
            "head-accessory": headAccessory ?? "",
            "hair-flower": "hair_flower_\(hairFlower ?? "")",
            "shield": shield,
            "weapon": weapon,
            "visual-buff": visualBuff,
            "mount-head": "Mount_Head_\(mount ?? "")",
            "zzz": "zzz",
            "knockout": "knockout",
            "pet": "Pet-\(pet ?? "")"
        ]
    }
}

class AvatarViewModel: Avatar {
    weak var avatar: AvatarProtocol?
    
    init() {}
    
    init(avatar: AvatarProtocol) {
        self.avatar = avatar
    }
    
    private var displayedOutfit: OutfitProtocol? {
        if avatar?.preferences?.useCostume == true {
            return avatar?.items?.gear?.costume
        } else {
            return avatar?.items?.gear?.equipped
        }
    }
    
    var background: String? {
        return avatar?.preferences?.background
    }
    var chair: String? {
        return avatar?.preferences?.chair
    }
    
    var back: String? {
        return displayedOutfit?.back
    }
    
    var skin: String? {
        return avatar?.preferences?.skin
    }
    
    var shirt: String? {
        return avatar?.preferences?.shirt
    }
    
    var armor: String? {
        return displayedOutfit?.armor
    }
    
    var body: String? {
        return displayedOutfit?.body
    }
    
    var hairColor: String? {
        return avatar?.preferences?.hair?.color
    }
    
    var hairBase: String? {
        if let base = avatar?.preferences?.hair?.base {
            return String(base)
        }
        return nil
        
    }
    
    var hairBangs: String? {
        if let bangs = avatar?.preferences?.hair?.bangs {
            return String(bangs)
        }
        return nil
        
    }
    
    var hairMustache: String? {
        if let mustache = avatar?.preferences?.hair?.mustache {
            return String(mustache)
        }
        return nil
        
    }
    
    var hairBeard: String? {
        if let beard = avatar?.preferences?.hair?.beard {
            return String(beard)
        }
        return nil    }
    
    var eyewear: String? {
        return displayedOutfit?.eyewear
    }
    
    var head: String? {
        return displayedOutfit?.head
    }
    
    var headAccessory: String? {
        return displayedOutfit?.headAccessory
    }
    
    var hairFlower: String? {
        if let flower = avatar?.preferences?.hair?.flower {
            return String(flower)
        }
        return nil
    }
    
    var shield: String? {
        return displayedOutfit?.shield
    }
    
    var weapon: String? {
        return displayedOutfit?.weapon
    }
    
    var visualBuff: String? {
        return nil
    }
    
    var mount: String? {
        return avatar?.items?.currentMount
    }
    
    var knockout: String? {
        return nil
    }
    
    var pet: String? {
        return avatar?.items?.currentPet
    }
    
    var isSleep: Bool {
        return avatar?.preferences?.sleep ?? false
    }
    
    var size: String? {
        return avatar?.preferences?.size
    }
    
}
