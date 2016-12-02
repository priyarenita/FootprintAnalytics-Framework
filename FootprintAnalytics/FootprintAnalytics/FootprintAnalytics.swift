//
//  FootprintAnalytics.swift
//  Listmania
//
//  Created by Renita Priya on 11/20/16.
//  Copyright © 2016 Renita Priya. All rights reserved.
//

import Foundation

public class FootprintAnalytics {
    let viewScreen:String
    var applicationName:String
    
    public init(appName: String, view:String){
        viewScreen = view
        applicationName = appName
    }
    
    public func addApp(){
        print ("request_______________________________")
        let request = NSMutableURLRequest(url: URL(string: "URL FOR YOUR INDEX.PHP FILE")!)
        request.httpMethod = "POST"
        let postString = "appName=\(applicationName)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        })
        task.resume()
        
    }
    
    public func addTracking(name: String, type: String, time: Date){
        
        let timestamp = time.iso8601
        print ("request_______________________________")
        let request = NSMutableURLRequest(url: URL(string: "URL FOR YOUR INDEX.PHP FILE")!)
        request.httpMethod = "POST"
        
        
        let postString = "applicationName=\(applicationName)&name=\(name)&type=\(type)&view=\(viewScreen)&time=\(timestamp)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        })
        task.resume()
        
    }


    
    
}

extension Date {
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "PST")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
    }
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}


extension String {
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
}

