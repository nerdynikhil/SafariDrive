//
//  SceneDelegate.swift
//  SafariDrive
//
//  Created by Nikhil Barik on 15/03/25.
//

import UIKit
import CarPlay

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CPTemplateApplicationSceneDelegate {
    
    var window: UIWindow?
    var interfaceController: CPInterfaceController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
    
    // Updated CarPlay support
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
        // Create a template for CarPlay interface
        let template = CPListTemplate(title: "SafariDrive", sections: [])
        interfaceController.setRootTemplate(template, animated: true)
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                didDisconnectInterfaceController interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}
