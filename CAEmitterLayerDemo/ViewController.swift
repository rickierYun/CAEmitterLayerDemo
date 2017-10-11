 //
//  ViewController.swift
//  CAEmitterLayerDemo
//
//  Created by 欧阳云慧 on 2017/9/27.
//  Copyright © 2017年 欧阳云慧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backgroundImage = UIImageView()
    var fireWorks = [CAEmitterCell]()
    let snowEmitter = CAEmitterLayer()
    let fogEmitter = CAEmitterLayer()
    let rainEmitter = CAEmitterLayer()
    let fireWorkEmitter = CAEmitterLayer()

    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.frame = self.view.bounds
        self.contentView.addSubview(backgroundImage)
        snowWeather()
//        fireworks()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedClick(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            self.rainEmitter.removeFromSuperlayer()
            self.fogEmitter.removeFromSuperlayer()
            snowWeather()
        case 1:
            self.snowEmitter.removeFromSuperlayer()
            self.fogEmitter.removeFromSuperlayer()
            rainWeather()
        case 2:
            self.rainEmitter.removeFromSuperlayer()
            self.snowEmitter.removeFromSuperlayer()
            fogWeather()
        case 3:
            self.rainEmitter.removeFromSuperlayer()
            self.snowEmitter.removeFromSuperlayer()
            fireworks()
            boom()
        default:
            self.rainEmitter.removeFromSuperlayer()
            self.fogEmitter.removeFromSuperlayer()
            snowWeather()
        }
    }

    func snowWeather() {

        backgroundImage.image = UIImage(named: "snowBackground")

        snowEmitter.emitterPosition = CGPoint(x: self.view.bounds.size.width / 2.0, y: -30)         // 发射源位置
        snowEmitter.emitterSize = CGSize(width: self.view.bounds.size.width * 2.0, height: 0.0)     // 发射源大小
        snowEmitter.emitterShape = kCAEmitterLayerLine                                              // 发射出的形状
        snowEmitter.emitterMode = kCAEmitterLayerOutline                                            // 发射模式

        let snowflake = CAEmitterCell()
        snowflake.birthRate = 1.0                                                                   // 每秒生成的粒子数
        snowflake.lifetime  = 100                                                                   // 粒子的生命周期
        snowflake.velocity  = -10                                                                   // 粒子的初始速度，正数为垂直向上，负数为垂直向下
        snowflake.velocityRange = 10                                                                // 保证范围，不会出现有反方向动画出现
        snowflake.yAcceleration = 2                                                                 // xAcceleration,yAcceleration,zAcceleration表示在某个方向加速
        snowflake.emissionRange = 0.5 * .pi                                                         // 以锥形分布开的发射角度,角度用弧度制,粒子均匀分布在这个锥形范围内
        snowflake.spinRange = 0.25 * .pi                                                            // 粒子的平均旋转速度，弧度制
        snowflake.contents  = UIImage(named:"snow")?.cgImage                                        // cell中的内容
        snowflake.color = UIColor(red: 0.6, green: 0.658, blue: 0.743, alpha: 1).cgColor            // cell渲染颜色

        snowEmitter.shadowOpacity = 1.0
        snowEmitter.shadowRadius  = 0
        snowEmitter.shadowOffset  = CGSize(width: 0, height: 1.0)
        snowEmitter.shadowColor   = UIColor.white.cgColor
        snowEmitter.emitterCells  = [snowflake]
        self.contentView.layer.addSublayer(snowEmitter)
        

    }

    func fogWeather() {

        backgroundImage.image = UIImage(named:"fogBackground")
        fogEmitter.emitterPosition = CGPoint(x: 0, y: self.view.bounds.size.height / 2)
        fogEmitter.emitterSize = CGSize(width: 1, height: 20)
        fogEmitter.emitterShape = kCAEmitterLayerLine
        fogEmitter.emitterMode = kCAEmitterLayerAdditive
        fogEmitter.renderMode = kCAEmitterLayerOldestFirst

        let fogflake = CAEmitterCell()

        fogflake.birthRate = 10
        fogflake.lifetime  = 50
        fogflake.velocity  = -10
        fogflake.velocityRange = 10
        fogflake.xAcceleration = 2.6
        fogflake.emissionRange = 0.2 * .pi
        fogflake.contents  = UIImage(named:"fog")?.cgImage


        fogEmitter.emitterCells = [fogflake]
        self.contentView.layer.addSublayer(fogEmitter)
    }

    func rainWeather() {
        backgroundImage.image = UIImage(named:"rainBackground")

        rainEmitter.emitterPosition = CGPoint(x: self.view.bounds.size.width / 2.0, y: -30)
        rainEmitter.emitterSize = CGSize(width: self.view.bounds.width * 2.0, height: 0)
        rainEmitter.emitterShape = kCAEmitterLayerLine
        rainEmitter.emitterMode = kCAEmitterLayerOutline

        let rainflake = CAEmitterCell()
        rainflake.birthRate = 100.0
        rainflake.lifetime  = 100
        rainflake.velocity  = -20
        rainflake.velocityRange = 20
        rainflake.yAcceleration = 5
        rainflake.emissionRange = 0.01 * .pi        //散射角度小，约等于一个直线
        rainflake.spinRange = 0
        rainflake.contents = UIImage(named:"rain")?.cgImage

        rainEmitter.emitterCells = [rainflake]
        self.contentView.layer.addSublayer(rainEmitter)
    }

    func fireworks() {
        backgroundImage.image = nil
        fireWorkEmitter.name = "fireWorkEmitterLayer"
        fireWorkEmitter.emitterShape = kCAEmitterLayerCircle
        fireWorkEmitter.emitterMode = kCAEmitterLayerOutline
        fireWorkEmitter.emitterPosition = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        fireWorkEmitter.emitterSize = CGSize(width: 30, height: 0)

        let fireWorkFlake = CAEmitterCell()
        fireWorkFlake.name = "fireWorkCell"
        fireWorkFlake.alphaRange = 2.0
        fireWorkFlake.alphaSpeed = -1.0
        fireWorkFlake.lifetime   = 0.7
        fireWorkFlake.lifetimeRange = 0.3
        fireWorkFlake.birthRate = 0
        fireWorkFlake.velocity = 40
        fireWorkFlake.velocityRange = 10
        fireWorkFlake.emissionRange = .pi / 4
        fireWorkFlake.scale = 0.05
        fireWorkFlake.scaleRange = 0.02
        fireWorkFlake.contents = UIImage(named:"red")?.cgImage
        self.fireWorks = [fireWorkFlake]

        fireWorkEmitter.emitterCells = [fireWorkFlake]
        fireWorkEmitter.renderMode = kCAEmitterLayerOldestFirst
        fireWorkEmitter.masksToBounds = false

        self.contentView.layer.addSublayer(fireWorkEmitter)

    }

    func boom() {
        // oc 只要用kvo就能解决fireWorks[0]的丑陋写法
        self.fireWorkEmitter.beginTime = CACurrentMediaTime()
        self.fireWorkEmitter.lifetime = 0.7
        self.fireWorks[0].birthRate = 500

        let delay = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.stop()
        }

    }

    @objc func stop() {
        self.fireWorkEmitter.lifetime = 0
        fireWorks[0].lifetime = 0
    }
}

