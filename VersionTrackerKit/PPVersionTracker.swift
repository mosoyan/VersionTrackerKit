//
//  PPVersionTracker.swift
//  VersionTrackerKit
//
//  Created by KEROPIAN OVSEP on 2/14/17.
//  Copyright © 2017 Pic Pen LLC. All rights reserved.
//

import Foundation

fileprivate let userDefaultsVersionTrailKey = "__PPVersionTracking_VersionTrail__"
fileprivate let versionKey = "__PPVersionTracking_Version__"
fileprivate let buildKey = "__PPVersionTracking_Build__"



public class AppVersion : NSObject {
    static let _defaultTracker : AppVersion = AppVersion()
    
    @objc(defaultTracker)
    final class public func `default`() -> AppVersion {
        return _defaultTracker 
    }
    
    fileprivate override init() {
        super.init()
    }
    
    fileprivate var versionTrail : [String: Array<String>] = [versionKey: Array<String>(), buildKey: Array<String>()]
    
    @objc public private(set) var isFirstLaunchEver = false
    @objc public private(set) var isFirstLaunchForVersion = false
    @objc public private(set) var isFirstLaunchForBuild = false
    @objc public var previousVersion : String? {
        get {
            guard let versions = versionTrail[versionKey] else {
                return nil
            }
            let count = versions.count
            if count > 2 {
                return versions[count - 2]
            }
            return nil
        }
    }
    
    @objc public var firstInstalledVersion : String? {
        return versionTrail[versionKey]?.first
    }
    
    @objc public private(set) var currentVersion : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    
    @objc public private(set) var currentBuild : String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""

    
    @objc final class public func start () {
        _defaultTracker.startVersionTracker();
    }
    
    fileprivate func startVersionTracker() {
        var needsSync = false;
        let oldVersionTrail : [String: Array<String>]? = UserDefaults.standard.object(forKey: userDefaultsVersionTrailKey) as? [String : Array<String>]
        
        if oldVersionTrail == nil {
            isFirstLaunchEver = true
        }else {
            isFirstLaunchEver = false
            versionTrail[versionKey] = oldVersionTrail?[versionKey]
            versionTrail[buildKey] = oldVersionTrail?[buildKey]
            needsSync = true
        }
        
        if (versionTrail[versionKey]?.contains(currentVersion))! {
            isFirstLaunchForVersion = false
        }else {
            isFirstLaunchForVersion = true
            versionTrail[versionKey]?.append(currentVersion)
            needsSync = true
        }
        
        if (versionTrail[buildKey]?.contains(currentBuild))! {
            isFirstLaunchForVersion = false
        }else {
            isFirstLaunchForVersion = true
            versionTrail[buildKey]?.append(currentBuild)
            needsSync = true
        }
        
        if needsSync {
            UserDefaults.standard.set(versionTrail, forKey: userDefaultsVersionTrailKey)
            UserDefaults.standard.synchronize()
        }
    }
}







