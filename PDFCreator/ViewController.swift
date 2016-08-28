//
//  ViewController.swift
//  PDFCreator
//
//  Created by Chris Stromberg on 8/26/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
   @IBInspectable let pdfRenderer = PDFRenderer()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        var fileName = pdfRenderer.getPDFFIleName()
        
        pdfRenderer.drawPDF(fileName)
       
        pdfRenderer.loadPDF("pdffilename", view: self.view)
        
        //loadPDF("pdffilename")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        
        var fileName = pdfRenderer.getPDFFIleName()
        
        pdfRenderer.drawPDF(fileName)
        
        pdfRenderer.loadPDF("pdffilename", view: self.view)
    }

    /*
    func drawText() {
        
        var pdfFileName = "Invoice.PDF"
        
        var arrayPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        var path =  "\(arrayPaths)/\(pdfFileName).pdf"
        
        
        let file = "file.txt" //this is the file. we will write to and read from it
        
        let text = "some text" //just a text
        
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
            
            //writing
            do {
                try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
            }
            catch {/* error handling here */}
        }
        
        // Core Text Frame setter
        let textString :NSString = "Hello World Test"
        */
        // Create CGRect that defines the frame where the text will be drawn.
   
    
    
    
    func loadPDF(filename: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = "\(documentsPath)/\(filename).pdf"
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(URL: url)
        let webView = UIWebView.init(frame: CGRectMake(20, 40, 320, 480))
        webView.loadRequest(urlRequest)
        self.view.addSubview(webView)
    }
//
//    
//    func drawImage(image: UIImage, inRect: CGRect){
//        image.drawInRect(inRect)
//    }
//    
    
    
    
    
    
}

