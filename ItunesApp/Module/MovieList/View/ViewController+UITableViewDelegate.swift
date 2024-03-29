//
//  ViewController+TabbleDelegate.swift
//  ItunesApp
//
//  Created by Muhammad Tafani Rabbani on 05/01/24.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favoriteCollectionView{
            if self.viewmodel.numberOfRows(isFavorite: collectionView == favoriteCollectionView) == 0{
                self.titleLabel.text = "no favorites yet"
                
            }else{
                self.titleLabel.text = "My Favorite:"
            }
        }
        return self.viewmodel.numberOfRows(isFavorite: collectionView == favoriteCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favoriteCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Favorite", for: indexPath) as? FavCollectionViewCell else {return UICollectionViewCell()}
            
            guard let movie = self.viewmodel.cellForRowAt(indexPath.row,isFavorite: true) else{
                return cell
            }
            cell.configure(with: movie)

            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.viewmodel.cellSize().1, for: indexPath) as? BaseCell else {return UICollectionViewCell()}
            
            guard let movie = self.viewmodel.cellForRowAt(indexPath.row,isFavorite: false) else{
                return cell
            }
            
            cell.favoriteButtonTap = {
                self.viewmodel.favoriteForRowAt(movie)
            }
            cell.configure(with: movie)

            return cell
        }
        
    }
    
    //size cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.favoriteCollectionView{
            let itemWidth = 160.0
            let itemHeight = 160.0
            return CGSize(width: itemWidth, height: itemHeight) 
        }else{
            //MARK: -update the size of cell based on choosen layout style
            //there are 2 options, table layout, or 2 column layout
            let itemWidth = self.viewmodel.cellSize().0
            let itemHeight = self.viewmodel.cellSize().1 == "Small" ? 60.0 : 200.0
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    //MARK: - to setup the header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LastVisitReusableView.reuseIdentifier, for: indexPath) as! LastVisitReusableView
            headerView.titleLabel.isHidden = true
            return headerView
        }
        return UICollectionReusableView()
    }
    
    // Add this method to set the size for the header view
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           if collectionView == favoriteCollectionView{
               return .zero
           }else{
               return CGSize(width: self.view.bounds.width, height: 20)
           }
           
       }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.reloadData()
    }
    
    //MARK: - use coordinator to show detail, and observer to viewmodel from detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == favoriteCollectionView{
            guard let movie = self.viewmodel.cellForRowAt(indexPath.row, isFavorite: true) else {return}
            self.coordinator?.showDetail(movie: movie){ [weak self] m in
                guard let self else {return}
                self.viewmodel.changeListMovie(by: m)
            }
        }else{
            guard let movie = self.viewmodel.cellForRowAt(indexPath.row, isFavorite: false) else {return}
            self.coordinator?.showDetail(movie: movie){ [weak self] m in
                guard let self else {return}
                self.viewmodel.changeListMovie(by: m)
            }
        }
    }
}


