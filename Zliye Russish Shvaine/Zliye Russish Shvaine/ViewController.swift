//
//  ViewController.swift
//  Zliye Russish Shvaine
//
//  Created by Гость on 21.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
 
 
    
    @IBOutlet weak var weatherDescriptionView: UIImageView!
    @IBOutlet weak var citynameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
    }
    
    func startLocationManager() {
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
    }
}
}
func updateView() {
    cityNameLabel.text = weatherDate.name
    weatherDescriptionLabel.text = DataSource.weatherIDs[weatherData.weather[0], id]
    temperIconImageView.image = weatherData.main.temp.description + "."
    weatherIconImageView.image = UIImage(named: weatherData.weather[0].Icon)
}

func updateWeatherInfo(latitude: Double, longtitude: Double) {
    let session = URLSession.shared
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=57&lon=-2.15&appid=a291d50204ace4b77423b0fd990597bd")!
    let task = session.dateTask(with: url) { (data, response, error) in
        guard error == nil else {
            print("DataTask error: \(error!.localizedDescription)")
            return
        }
        do {
            self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
            DispatchQueue.main.async {
                self.updateView()
            }
        } catch {
            print(error.localizedDescription)
        }
        }
    task.resume()
}
}
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
    }
    }
}
