//
//  ViewController.swift
//  GoogleLogin
//
//  Created by Shantaram K on 21/03/19.
//  Copyright © 2019 Shantaram K. All rights reserved.
//

import UIKit
import GoogleSignIn


class ViewController: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var signInButton: GIDSignInButton!

    fileprivate let googleSignInButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //showGoogleLoginView()
        
        //Programmatically
      //  prepareGoogleButton()
       // prepareGIDSignIn()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().delegate = self
        
        //GIDSignIn.sharedInstance()?.signIn()
        
        
        signInButton.colorScheme = .dark
        signInButton.style = .wide
        signInButton.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    private func showGoogleLoginView() {
        
        GoogleLoginInteractor.instance.prepareGIDSignIn()
        
     }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        /*
        GoogleLoginInteractor.instance.showLoginPage()
        GoogleLoginInteractor.instance.userDidLogin = { (user, error) in
            if error == nil {
                print(user)
            }
        } */
      //  GIDSignIn.sharedInstance().uiDelegate = self
        
      //  GIDSignIn.sharedInstance().delegate = self
        
         GIDSignIn.sharedInstance()?.signIn()
    }
    
    fileprivate func prepareGoogleButton() {
        view.addSubview(googleSignInButton)
        googleSignInButton.style = .wide
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        googleSignInButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        googleSignInButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        googleSignInButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true

    }
    
    fileprivate func prepareGIDSignIn() {
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().delegate = self
    }
    
        
}

    //MARK: - Google Login Delegate
extension ViewController: GIDSignInDelegate {
        
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                  withError error: Error!) {
            
            if let error = error {
                
                print("\(error.localizedDescription)")
                
            } else {
                
                // Perform any operations on signed in user here.
                let userId = user.userID
                let idToken = user.authentication.idToken
                print(idToken)
                print(userId)
                let fullName = user.profile.name
                
                let givenName = user.profile.givenName
                
                let familyName = user.profile.familyName
                
                let email = user.profile.email
                
                // ...
            }
        }
        
        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
                  withError error: Error!) {
        }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
        
}
extension ViewController: GIDSignInUIDelegate {
    
}

