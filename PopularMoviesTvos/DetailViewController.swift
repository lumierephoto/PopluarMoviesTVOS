//
//  DetailViewController.swift
//  PopularMoviesTvos
//
//  Created by HAL9000 on 12/11/15.
//  Copyright © 2015 PrismStudiosLLC. All rights reserved.
//



import Foundation
import UIKit
import AVKit

  class DetailViewController: UIViewController {
//class DetailViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailLabel: UILabel!
        
        let TRAILER_URL = "http://api.themoviedb.org/3/movie/popular?api_key=5e1251123a0304bbe35fcb58bd074868"
        var trailer = [Movie]()
    
         override func viewDidLoad() {
            super.viewDidLoad()
            
            //downloadTrailer()
         }
    
    
    
    func configureMovieDetails(movieDetail: Movie) {
        
        if let title = movieDetail.title {
            movieDetailLabel.text = title
        }
        
        if let path = movieDetail.posterPath {
            
            let url = NSURL(string: path)!
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let data = NSData(contentsOfURL: url)!
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let img = UIImage(data: data)
                    self.movieDetailImage.image = img
                }
                
            }
            
        }

    }
    
    
//     func downloadTrailer() {
//        
//        let url = NSURL(string: TRAILER_URL)!
//        let request = NSURLRequest(URL: url)
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { (data, response, error) ->
//            
//            Void in
//            
//            if error != nil {
//                
//                print(error.debugDescription)
//            }
//                
//            else {
//                do {
//                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
//                    
//                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>] {
//                        
//                        for obj in results {
//                            let movie = Movie(movieDict: obj)
//                            self.trailer.append(movie)
//                        }
//                        dispatch_async(dispatch_get_main_queue()) {
//                            
//                            //self.reloadData()
//                        }
//                    }
//                }
//                catch {
//                    
//                }
//            }
//        }
//        task.resume()
//    }
    
//    func configureDetailCell (movie: Movie) {
//        
//        if let title = movie.title {
//            movieDetailLabel.text = title
//        }
//        
//        if let path = movie.posterPath {
//            
//            let url = NSURL(string: path)!
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                
//                let data = NSData(contentsOfURL: url)!
//                
//                dispatch_async(dispatch_get_main_queue()) {
//                    
//                    let img = UIImage(data: data)
//                    self.movieDetailImage.image = img
//                }
//                
//            }
//        }
//    }
    
    
    
//    func playVideo() {
//            
//            //player = AVPlayer(URL: NSURL(string: TRAILER_URL)!)
//            //player?.play()
//            print("Video is playing")
//        }
    
}
