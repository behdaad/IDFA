//
//  ViewController.swift
//  IDFA
//
//  Created by Behdad Keynejad on 11/20/1399 AP.
//

import UIKit
import AdSupport
import Adjust
import AppTrackingTransparency

class ViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        let url = URL(string: UIApplication.openSettingsURLString)!
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: {_ in })
//        } else {
//            // Fallback on earlier versions
//        }
        
        let iOSVersion = UIDevice.current.systemVersion
        addLabel(text: "iOS Version: \(iOSVersion)")
        
        let adTrackingEnabled = ASIdentifierManager.shared().isAdvertisingTrackingEnabled
        addLabel(text: "Ad tracking enabled: \(adTrackingEnabled)")
        
        if #available(iOS 14, *) {
            let trackingStatus = ATTrackingManager.trackingAuthorizationStatus
//            print(trackingStatus)
            addLabel(text: "App tracking status on iOS 14: \(trackingEnumName(enumCase: trackingStatus))")
        } else {
            addLabel(text: "App Tracking is not available before iOS 14")
        }
        
        let sharedASIdentifierManager = ASIdentifierManager.shared()
        let adID = sharedASIdentifierManager.advertisingIdentifier
        addLabel(text: "iOS Ad ID: \(adID.uuidString)\n")
        
        let adjustAdID = Adjust.adid() ?? "nil"
        addLabel(text: "Adjust Ad ID: \(adjustAdID)")
    }
    
    private func addLabel(text: String) {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }
    
    @available(iOS 14, *)
    private func trackingEnumName(enumCase: ATTrackingManager.AuthorizationStatus) -> String {
        switch enumCase {
        case .notDetermined:
            return "Not determined"
        case .restricted:
            return "Restricted"
        case .denied:
            return "Denied"
        case .authorized:
            return "Authorized"
        @unknown default:
            return "Unknown"
        }
    }
}
