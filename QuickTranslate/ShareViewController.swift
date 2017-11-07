//
//  ShareViewController.swift
//  QuickTranslate
//
//  Created by Oznur Akgun on 03/08/2017.
//  Copyright © 2017 Oznur Akgun. All rights reserved.
//

import UIKit
import Social
import AnimatedCollectionViewLayout

class ShareViewController: UIViewController {
    
    @IBOutlet var text: UILabel!
    var sharedUserDefaults: UserDefaults? = nil
    var inputItem: NSExtensionItem? = nil
    @IBOutlet var textView: UITextView!
    @IBOutlet var popupView: UIView!
    var effect:UIVisualEffect!
    var imageView = AImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIn()
        popupView.layer.cornerRadius = 5
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = item.attachments?.first as? NSItemProvider {
                if itemProvider.hasItemConformingToTypeIdentifier("public.text") {
                    itemProvider.loadItem(forTypeIdentifier: "public.text", options: nil, completionHandler: { (text, error) -> Void in
                        if let shareURL = text as? String {
                            self.getDataFromJson(text: shareURL, completion: { response in
                                DispatchQueue.main.async {
                                    self.imageView.removeFromSuperview()
                                    self.popupView.isHidden = false
                                    self.text.text =  response[0] as? String
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func animateIn() {
        popupView.center = self.view.center
        popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
        self.popupView.isHidden = true
        let image = AImage(url: Bundle.main.url(forResource: "load2", withExtension: "gif")!)
        self.view.addSubview(self.imageView);
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true

        self.imageView.add(image: image!)
        self.imageView.play = true
        
        text.center = self.view.center
        text.adjustsFontSizeToFitWidth = true;
        text.numberOfLines = 0;
        text.accessibilityScroll(UIAccessibilityScrollDirection.down)
    }
    
    @IBAction func dismissPopUp(_ sender: AnyObject) {
        animateOut()
    }
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popupView.alpha = 0
            
        }) { (success:Bool) in
            self.popupView.removeFromSuperview()
            self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
        }
    }
    
    func getDataFromJson(text: String, completion: @escaping (_ success: NSArray) -> Void) {
        var request = URLRequest(url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20170702T105450Z.2ed9104f24591409.713ff4ffa4889dec8af341952d9eeb21a58c53b1&lang=tr&format=plain")!)
        request.httpMethod = "POST"
        let postString = String(format: "text=%@", text)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { Data, response, error in
            guard let data = Data, error == nil else {
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                return
            }
            let responseString  = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
            completion(responseString["text"] as! NSArray)
        }
        task.resume()
    }
}




