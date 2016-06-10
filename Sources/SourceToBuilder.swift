//
//  JSONToSwift.swift
//  Jenerator
//
//  Created by Romain Menke on 04/06/16.
//  Copyright © 2016 menke-dev. All rights reserved.
//

import Foundation


extension ModelBuilder {

    /**
     Constructer for a remote JSON source

     - parameter url:         Url that will return the JSON
     - parameter classPrefix: Class Prefix for the Types

     - returns: an initialised ModelBuilder if the url returned valid JSON data
     */
    public static func fromSource(url:NSURL, classPrefix:String, completion:((builder:ModelBuilder?) -> Void)) {
        #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
            guard let data = NSData(contentsOfURL: url) else {
                completion(builder: nil)
            }

            if let json = JSONCoder.decode(data) {
                completion(builder: ModelBuilder(rootName: "Container", classPrefix: classPrefix, source: url.absoluteString).buildModel(json))
            } else {
                completion(builder: nil)
            }
        #elseif os(Linux)

          NSData.contents(ofUrl:url.absoluteString) { data in
            if let data = data, json = JSONCoder.decode(data) {
              completion(builder: ModelBuilder(rootName: "Container", classPrefix: classPrefix, source: url.absoluteString).buildModel(json))
            } else {
              completion(builder: nil)
            }
          }
        #endif
    }

    /**
     Constructer for a local JSON source

     - parameter path:        Path to a .json file as a string
     - parameter classPrefix: Class Prefix for the Types

     - returns: an initialised ModelBuilder if the file contained valid JSON data
     */
    public static func fromFile(path:String, classPrefix:String) -> ModelBuilder? {
        #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
            guard let data = NSData(contentsOfFile: path) else {
                return nil
            }

            if let json = JSONCoder.decode(data) {
                return ModelBuilder(rootName: "Container", classPrefix: classPrefix).buildModel(json)
            }
            return nil
        #elseif os(Linux)
            return nil
        #endif
    }
}
