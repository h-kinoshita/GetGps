//
//  ViewController.swift
//  GetGPS
//
//  Created by h.kinoshita on 2016/04/06.
//  Copyright © 2016年 mebro Inc. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Global Vars
    
    // 現在地の位置情報取得にはCLLocationManagerを使用
    var locationManager: CLLocationManager!
    
    // 取得した緯度を保存するインスタンス
    var latitude: CLLocationDegrees!
    
    // 取得した経度を保持するインスタンス
    var longitude: CLLocationDegrees!
    
    // 取得した高度を保持するインスタンス
    var altitude: CLLocationDegrees!
    
    // 取得した速度を保持するインスタンス
    var speed: CLLocationDegrees!
    
    // 取得した時間を保持するインスタンス
    var time: NSDate!
    
    // 取得した方角を保持するインスタンス
    var compassPoint: CLLocationDegrees!
    
    // 取得した精度を保持するインスタンス
    var horizontalAccuracy: CLLocationDegrees!
    
    // MARK: - Outlets
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLable: UILabel!
    @IBOutlet weak var compassPointLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var horizontalAccuracyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // フィールドの初期化
        locationManager = CLLocationManager()
        longitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        
        // CLLocationManagerをDelegateに指定する
        locationManager.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示：必須項目
        locationManager.requestAlwaysAuthorization()
        
        // GPSの使用を開始する
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 位置情報取得成功時に実行される関数
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        // 取得した緯度がnewLocation.coordinate.latitudeに格納されている
        latitude = newLocation.coordinate.latitude
        
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        longitude = newLocation.coordinate.longitude
        
        // 取得した高度がnewLocation.altitudeに格納されている
        altitude = newLocation.altitude
        
        // 取得した速度がnewLocation.speedに格納されている
        speed = newLocation.speed
        
        // 取得した時間がnewLocation.timestapmに格納されている
        time = newLocation.timestamp
        
        // 取得した精度がnewLocation.horizontalAccuracyに格納されている
        horizontalAccuracy = newLocation.horizontalAccuracy
        
        
        // 取得した緯度・経度をLogに表示する。
        NSLog("latitude: \(latitude), longitude:\(longitude) ")
        
        // GPSの使用を停止する。(停止しない限りGPSは実行され、私的感覚で更新され続ける。)
//        locationManager.stopUpdatingLocation()
        
        self.settingLabelText()
    }
    
    // 位置情報取得失敗時に実行される関数
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("Error!!!")
    }
    
    // コンパスの値を受信
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        compassPoint = newHeading.magneticHeading
    }
    
    func settingLabelText() {
        
        latitudeLabel.text = String(latitude)
        longitudeLabel.text = String(longitude)
        altitudeLable.text = String(altitude)
        speedLabel.text = String(speed)
        timeLabel.text = String(time)
        compassPointLabel.text = String(compassPoint)
        horizontalAccuracyLabel.text = String(horizontalAccuracy)
        
    }
}

