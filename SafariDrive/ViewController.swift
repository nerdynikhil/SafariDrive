//
//  ViewController.swift
//  SafariDrive
//
//  Created by Nikhil Barik on 15/03/25.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    let urlTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupUI()
        loadHomePage()
    }
    
    func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupUI() {
        // URL Bar
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "Enter URL"
        urlTextField.keyboardType = .URL
        urlTextField.autocapitalizationType = .none
        urlTextField.returnKeyType = .go
        urlTextField.delegate = self
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(urlTextField)
        
        NSLayoutConstraint.activate([
            urlTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            urlTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func loadHomePage() {
        let homeURL = URL(string: "https://www.apple.com")!
        let request = URLRequest(url: homeURL)
        webView.load(request)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if var urlString = textField.text {
            // Add https:// if no scheme is specified
            if !urlString.contains("://") {
                urlString = "https://" + urlString
            }
            
            // Clean up the URL string
            if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encodedString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        textField.resignFirstResponder()
        return true
    }
}

