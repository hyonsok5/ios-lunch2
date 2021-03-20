//
//  ViewController.swift
//  lunch2gether
//
//  Created by Hyonsok Shin on 2020/10/11.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate,
    WKUIDelegate{
    
    var webView: WKWebView!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            view = webView
          
            view.addSubview(spinner)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let myURL =   URL(string: 
            "https://appsvc-dev-flunch2-aztech-kc.azurewebsites.net"
            )  
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))

        present(alertController, animated: true, completion: nil)
    }


    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))

        present(alertController, animated: true, completion: nil)
    }

      func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo,
                   completionHandler: @escaping (String?) -> Void) {
          
          let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
          
          alertController.addTextField { (textField) in
              textField.text = defaultText
          }
          
          alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
              if let text = alertController.textFields?.first?.text {
                  completionHandler(text)
              } else {
                  completionHandler(defaultText)
              }
          }))
          
          alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
              completionHandler(nil)
          }))
          
          present(alertController, animated: true, completion: nil)
      }
   
}

