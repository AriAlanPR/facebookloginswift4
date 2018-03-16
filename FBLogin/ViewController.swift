//
//  ViewController.swift
//  FBLogin
//
//  Created by LeadOneMx on 12/24/1396 AP.
//  Copyright © 1396 LeadOneMx. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    

    //dictionary to retrieve fb user data
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //code for facebook login
        if (FBSDKAccessToken.current() != nil)
        {
            //if it gets here means that the user already logged in with its facebook so we'll already have an access token
            print("User is actually logged with acess token \(FBSDKAccessToken.current())")
            //we retrieve the data we asked permission for to the user
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email,gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    let dictresult = result as! [String:Any]
                    let id = dictresult["id"]!
                    let fbphoto = "https://graph.facebook.com/\(id)/picture?width=500&height=500"
                    print(fbphoto)
                }
            })
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            //creating button
            let loginButton = FBSDKLoginButton()
            loginButton.center = self.view.center
            loginButton.readPermissions = ["public_profile", "email", "user_photos"]
            loginButton.delegate = self
            self.view.addSubview(loginButton)
        }
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result:
        
        FBSDKLoginManagerLoginResult!, error: Error!) {
        if(error != nil){
            FBSDKLoginManager().logOut()
            print("Fb error ocurred \(error!)")
        }else if(result.isCancelled){
            FBSDKLoginManager().logOut()
            print("Fb result cancelled")
        }else{
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email,gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    let dictresult = result as! [String:Any]
                    let id = dictresult["id"]!
                    let fbphoto = "https://graph.facebook.com/\(id)/picture?width=500&height=500"
                    print(fbphoto)
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

