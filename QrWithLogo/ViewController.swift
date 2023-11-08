//
//  ViewController.swift
//  QrWithLogo
//
//  Created by Hüseyin BAKAR on 8.11.2023.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var qrImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: .utf8)

        if let qrFilter = CIFilter(name: "CIQRCodeGenerator") {
            qrFilter.setValue(data, forKey: "inputMessage")
            if let outputImage = qrFilter.outputImage {
                let transform = CGAffineTransform(scaleX: 10, y: 10) // İhtiyaca göre ölçek faktörünü ayarlayın
                let scaledImage = outputImage.transformed(by: transform)

               let img = UIImage(ciImage: scaledImage)
                
                return img
            }
        }

        return nil
    }
    
    func overlayLogo(onQRCode qrCode: UIImage, with logo: UIImage) -> UIImage? {
        let qrCodeRect = CGRect(origin: .zero, size: qrCode.size)

        UIGraphicsBeginImageContext(qrCode.size)

        qrCode.draw(in: qrCodeRect)

        let logoSize = CGSize(width: qrCode.size.width * 0.25, height: qrCode.size.height * 0.25) // Logonun boyutunu ihtiyaca göre ayarlayın
        let logoRect = CGRect(x: (qrCode.size.width - logoSize.width) / 2, y: (qrCode.size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height)

        logo.draw(in: logoRect)

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return finalImage
    }
    
    @IBAction func buttonClickQE(_ sender: Any) {
       let d = 0
        
        // https://rb.gy/adpqpa
        //
        if let qrCode = generateQRCode(from: "https://docs.google.com/forms/d/e/1FAIpQLSdYJg_pJZnJ4Ii-UXZZPMECEysFCUt1FBbLwSHz5kQVSgy-CA/viewform") {
            if let logoImage = UIImage(named: "star") { // Logonuzun adıyla değiştirin
                if let finalQRCode = overlayLogo(onQRCode: qrCode, with: logoImage) {
                    
                    qrImage.image = finalQRCode
                }
            }
        }
    }
}

