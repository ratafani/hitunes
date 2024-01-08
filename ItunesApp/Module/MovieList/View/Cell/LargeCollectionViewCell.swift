//
//  LargeCollectionViewCell.swift
//  ItunesApp
//
//  Created by Muhammad Tafani Rabbani on 05/01/24.
//

import UIKit

protocol BaseCell: UICollectionViewCell{
    var rowImage: UIImageView { get set }
    var nameLabel : UILabel { get set }
    var favorite : UIButton { get set }
    var favoriteButtonTap : ()->Void { get set }
    func addViews()
    func setFavoriteImagge(isFavorite : Bool)
}

class LargeCollectionViewCell: UICollectionViewCell,BaseCell {
    
    
    var rowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.text = "Bob Lee"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var favorite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var favoriteButtonTap : ()->Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        
        addSubview(rowImage)
        addSubview(nameLabel)
        addSubview(favorite)
        
        rowImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        rowImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rowImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rowImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        favorite.rightAnchor.constraint(equalTo: rightAnchor,constant: -16).isActive = true
        favorite.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8).isActive = true
        favorite.heightAnchor.constraint(equalToConstant: 25).isActive = true
        favorite.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: favorite.leftAnchor, constant: 16).isActive = true
        
        favorite.addTarget(self, action: #selector(pressedAction(_:)), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedAction(_ sender: UIButton) {
       // do your stuff here
      favoriteButtonTap()
    }
    
    func setFavoriteImagge(isFavorite : Bool){
        if isFavorite{
            favorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            favorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
