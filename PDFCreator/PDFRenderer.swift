//
//  PDFRenderer.swift
//  PDFCreator
//
//  Created by Chris Stromberg on 8/27/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@IBDesignable
class PDFRenderer {
    
    func drawPDF(pdfFileName : NSString) {
        // Removed and added to getPDFFile name function.
//        let fileName = "pdffilename.pdf"
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        let documentsDirectory = paths[0] as NSString
//        let pathForPDF = documentsDirectory.stringByAppendingString("/" + fileName)

        
        // Create the PDF context using the default page size of 612 x 792.
        UIGraphicsBeginPDFContextToFile(pdfFileName as String, CGRectZero, nil)
        
        // Mark the beginning of a new page
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil)
        
        drawTemplateText("Hello World", inFrame: CGRectMake(0, 0, 300, 50))
        drawLabels()
        
        
        
        // draws horizontal bars on page
        
        let xOrigin = 30 as CGFloat
        let yOrigin = 100 as CGFloat
        
        let rowHeight = 20
        let columnWidth = 140
        
        let numberOfRows = 7
        let numberOfColumns = 3
        
        drawTableAt(CGPointMake(xOrigin, yOrigin), withRowHeight: rowHeight, andColumnWidth: columnWidth, andRowCount: numberOfRows, andColumnCount: numberOfColumns)
        
        
//        let font = UIFont(name: "Helvetica Bold", size: 14.0)
//        
//        let textRect = CGRectMake(5, 3, 125, 18)
//        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
//        paragraphStyle.alignment = NSTextAlignment.Left
//        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        
//        let textColor = UIColor.blackColor()
//        
//        let textFontAttributes = [
//            NSFontAttributeName: font!,
//            NSForegroundColorAttributeName: textColor,
//            NSParagraphStyleAttributeName: paragraphStyle
//        ]
//        
//        let textStringPDF:NSString = "Hello world"
//        
//        // Draw the actual frame with the text.
//        textStringPDF.drawInRect(textRect, withAttributes: textFontAttributes)
//        
//        
//        
//        
//        // Add Image
//        let logo = UIImage.init(named: "chessBanner.jpg")
//        
//        let horizontalHalf : CGFloat = 612/2
//        
//        let frame = CGRectMake(horizontalHalf, 100, 300, 60)
//        drawImage(logo!, inRect: frame)
//        
        
        // Close the PDF context and write the contents out.
        UIGraphicsEndPDFContext()
        
    }
    
    func getPDFFIleName()->NSString {
        
        let fileName = "pdffilename.pdf"
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        let pathForPDF = documentsDirectory.stringByAppendingString("/" + fileName)
        
        return pathForPDF
    
    }
    
    func drawImage(image: UIImage, inRect: CGRect){
        image.drawInRect(inRect)
    }
    
    
    
    func drawTemplateText(textToDraw: NSString, inFrame: CGRect) {
        
        let stringRef = textToDraw as CFStringRef
        
        //Prepare the text using a Core Text Framesetter
        let currentText = CFAttributedStringCreate(nil, stringRef, nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(currentText)
        
        let framePath = CGPathCreateMutable()
        CGPathAddRect(framePath, nil, inFrame)
        
        // Get the frame that will do the rendering.
        let currentRange = CFRangeMake(0, 0)
        let frameRef = CTFramesetterCreateFrame(frameSetter, currentRange, framePath, nil)
        //CGPathRelease(framePath)
        
        // Get the graphics context
        let currentContext = UIGraphicsGetCurrentContext()
        
        // Put the text matrix into a known state. This ensures that no old scaling factors are left in place.
        CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity)
        
        // Core Text draws from the bottom left corner up, so flip the current transform prior to drawing.
        CGContextTranslateCTM(currentContext, 0, inFrame.origin.y*2)
        CGContextScaleCTM(currentContext, 1.0, -1.0)
        
        // Draw the frame
        CTFrameDraw(frameRef, currentContext!)
        
        // Add this to reverse the earlier transformation.
        CGContextScaleCTM(currentContext,1.0, -1.0)
        CGContextTranslateCTM(currentContext, 0, (-1)*inFrame.origin.y*2)
        
  
    }
    
    
    // Use with drawTemplateFunction
    // Loads the labels from the templateViewPDF, loops thru all the labels and calls the drawTemplateText method.
    func drawLabels() {
        //let objects = NSBundle.mainBundle().loadNibNamed("templateViewPDF", owner: nil, options: nil)[0]
        
        let objects = NSBundle.mainBundle().loadNibNamed("templateViewPDF", owner: nil, options: nil)
        let mainView = objects[0]
        
        for view in mainView.subviews {
            if view is UILabel {
                let label : UILabel = view as! UILabel
                
                drawTemplateText(label.text!, inFrame: label.frame)
            }
        }
        
//        for view in mainView.subviews {
//            if view.isKindOfClass(UILabel) {
//                var label =
//                drawTemplateText(label, inFrame: label.frame)
//            }
        
    }
    
    
    // Creates the view that the generated PDF goes in.
    
    func loadPDF(filename: String, view: UIView) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = "\(documentsPath)/\(filename).pdf"
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(URL: url)
        let webView = UIWebView.init(frame: CGRectMake(40, 80, 320, 480))
        webView.loadRequest(urlRequest)
        view.addSubview(webView)
    }
    
        func drawLineFromPoint(from: CGPoint, toPoint to: CGPoint){
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.2, 0.2, 0.2, 0.3]
        let color = CGColorCreate(colorspace, components)
        
        CGContextSetStrokeColorWithColor(context, color)
        
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        
        CGContextStrokePath(context)
        
        
        
        
    }
    func drawTableAt(origin: CGPoint,
                     withRowHeight rowHeight: Int,
                     andColumnWidth columnWidth: Int,
                     andRowCount numberOfRows: Int,
                     andColumnCount numberOfColumns: Int) {
        
        
        // Draws the horizontal lines based on number of rows.
        for i in 0...numberOfRows {
            let newOrigin: Int = Int(origin.y) + (rowHeight*i)
            
            let from = CGPointMake(origin.x, CGFloat(newOrigin))
            let to = CGPointMake(origin.x + CGFloat(numberOfColumns*columnWidth), CGFloat(newOrigin))
            
            drawLineFromPoint(from, toPoint: to)
        
        }
        
        // Draw the vertical lines based on the columns
        for i in 0...numberOfColumns {
            let newOrigin: Int = Int(origin.x) + (columnWidth * i)
            
            let from = CGPointMake(CGFloat(newOrigin), origin.y)
            let to = CGPointMake(CGFloat(newOrigin), origin.y + (CGFloat(numberOfRows) * CGFloat(rowHeight)))
            
            drawLineFromPoint(from, toPoint: to)
        }
        
        
        
    }


}