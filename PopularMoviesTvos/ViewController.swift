//
//  ViewController.swift
//  PopularMoviesTvos
//
//  Created by HAL9000 on 12/10/15.
//  Copyright © 2015 PrismStudiosLLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let URL_BASE = "http://api.themoviedb.org/3/movie/popular?api_key=5e1251123a0304bbe35fcb58bd074868"
    
    let defaultSize = CGSizeMake(306, 451)
    let focusSize = CGSizeMake(336, 496)
    var movies = [Movie]()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadData()
    }
    
    func downloadData() {
        
        let url = NSURL(string: URL_BASE)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) ->
         
             Void in
            
            if error != nil {
                
                print(error.debugDescription)
            }
           
            else {
               do {
                  let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>] {
                        
                        for obj in results {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                    }
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.collectionView.reloadData()
                        }
                  }
                }
                catch {
                    
                }
            }
        }
          task.resume()
    }

  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            
            let movie = movies[indexPath.row]
            cell.configureCell(movie)
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            return cell
        }
        else {
            return MovieCell()
        }
    }
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        if let cell = gesture.view as? MovieCell {
            // Load the next view controller and pass in the movie
            
//            let detailVC = DetailViewController()
//            detailVC.playVideo()
//            [self.presentViewController(detailVC, animated: true, completion: nil)]
            
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailView") as! DetailViewController
            self.presentViewController(vc, animated: true, completion: nil)
           
            print("Tap detected")
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let detailVC = DetailViewController()
//        detailVC.playVideo()
//        [self.presentViewController(detailVC, animated: true, completion: nil)]
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSizeMake(343, 535)
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
//        if let prev = context.previouslyFocusedView as? MovieCell {
//            
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                prev.movieImage.frame.size = self.defaultSize
//            })
//        }
//        
//        if let next = context.nextFocusedView as? MovieCell {
//            
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                next.movieImage.frame.size = self.focusSize
//            })
//        }
    }

}

