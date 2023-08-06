//
//  UploadViewController.swift
//  ImageShared
//
//  Created by İbrahim Halid Bayrak on 5.08.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    @objc func gorselSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButtonTiklandi(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediraFolder = storageReferance.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let imageReferance = mediraFolder.child("image.jpg")
            imageReferance.putData(data) { (storagemetadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                }
            }
        }
        
    }
    
}
