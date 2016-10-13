//
//  PuzzleCollectionViewController.swift
//  CollectionViewCatPicPuzzle
//
//  Created by Joel Bell on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var imageSlices: [UIImage] = []
    var headerReusableView: HeaderReusableView!
    var footerReusableView: FooterReusableView!
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!

    
    override func viewDidLoad() {
        configureLayout()
        super.viewDidLoad()
        self.collectionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView?.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        generateImageSlicesArray()
        randomize(imageArray: imageSlices)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSlices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = imageSlices[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            headerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)) as! HeaderReusableView
            
            return headerReusableView
            
        } else {
            
            footerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)) as! FooterReusableView
            
            return footerReusableView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func generateImageSlicesArray() {
        var selectedImage: UIImage?
        for i in 1...12 {
            if let fileImage = UIImage(named: "\(i)") {
                selectedImage = fileImage
            }
            imageSlices.append(selectedImage!)
            print(imageSlices.count)
        }
    }
    
    func configureLayout() {
        let bounds: CGRect = UIScreen.main.bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        numberOfRows = 4
        numberOfColumns = 3
        spacing = 2
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        referenceSize = CGSize(width: screenWidth, height: 60)
        
        let width = (screenWidth / numberOfColumns) - ((spacing / 2) + spacing)
        let height = (screenHeight / numberOfRows) - spacing - spacing - spacing
        
//        let width = (screenWidth/3) - (spacing * 0.5
//            + sectionInsets.left + sectionInsets.right)
//        let height = (screenHeight/4) - (spacing + sectionInsets.top + sectionInsets.bottom)
        itemSize = CGSize(width: width, height: height)
    }
    
    func randomize(imageArray: [UIImage]) {
        var mutableArray = imageArray
        for _ in mutableArray {
            let poppedValue = mutableArray.removeFirst()
            mutableArray.insert(poppedValue, at: Int(arc4random_uniform(UInt32(imageArray.count - 1))))
        }
        imageSlices = mutableArray
    }

    
    
}
