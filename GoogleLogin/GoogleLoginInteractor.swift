//
//  GoogleLoginInteractor.swift
//  GoogleLogin
//
//  Created by Shantaram K on 21/03/19.
//  Copyright © 2019 Shantaram K. All rights reserved.
//

import UIKit
import GoogleSignIn


//https://developers.google.com/identity/sign-in/ios/start?ver=swift

protocol GoogleLoginProtocol: class {
    
    var userDidLogin: ((GIDGoogleUser?, Error?) -> Void)? { get set }
}

class GoogleLoginInteractor: NSObject, GoogleLoginProtocol {
    
    //MARK: - Internal Properties
    
    static let instance = GoogleLoginInteractor()
    
    var userDidLogin: ((GIDGoogleUser?, Error?) -> Void)?

    //MARK: Private Methods
    
    func showLoginPage() {
        
       prepareGIDSignIn()

    }
    
    func prepareGIDSignIn() {
        
        GIDSignIn.sharedInstance().clientID = clientId
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
}

//MARK: - Google Login Delegate

extension GoogleLoginInteractor: GIDSignInDelegate {
    
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        if let error = error {
            
            print("\(error.localizedDescription)")
            
            self.userDidLogin!(nil, error)
            
        } else {
            
            self.userDidLogin!(user, error)
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        self.userDidLogin!(user, error)
    }
    
}
extension GoogleLoginInteractor: GIDSignInUIDelegate {
    
}

var clientId: String {
    let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
    let googleService = NSDictionary(contentsOfFile: path!)!
    if let client = googleService.object(forKey: "CLIENT_ID") as? String {
        return client
    }
    return ""
}
