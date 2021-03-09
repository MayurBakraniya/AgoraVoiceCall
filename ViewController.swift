//
//  ViewController.swift
//  AgoraVoiceCall
//
//  Created by MAC on 09/03/21.
//

import UIKit
import AgoraRtcKit

class ViewController: UIViewController {
    
    var agoraKit: AgoraRtcEngineKit?
    
    @IBOutlet weak var controlButtonsView: UIView!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeAgoraEngine()
        controlButtonsView.isHidden = true
    }
    
    @IBAction func joinChannel(_ sender: UIButton) {
        joinChannel()
        joinButton.isHidden = true
        controlButtonsView.isHidden = false
    }
    
    func initializeAgoraEngine() {
        // Initializes the Agora engine with your app ID.
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: nil)
    }
    
    
    func joinChannel() {
        // Allows a user to join a channel.
        agoraKit?.joinChannel(byToken: Token, channelId: "test", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
            //if channel != nil{
                self.agoraKit!.setEnableSpeakerphone(true)
                UIApplication.shared.isIdleTimerDisabled = true
          //  }else{
           //     print("error")
           // }
        })                // Joined channel "demoChannel"
        
    }
    
    @IBAction func didClickHangUpButton(_ sender: UIButton) {
        leaveChannel()
    }
    
    func leaveChannel() {
        agoraKit!.leaveChannel(nil)
        hideControlButtons()
        
        UIApplication.shared.isIdleTimerDisabled = false
        joinButton.isHidden = false
    }
    
    func hideControlButtons() {
        controlButtonsView.isHidden = true
    }
    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        // Stops/Resumes sending the local audio stream.
        agoraKit!.muteLocalAudioStream(sender.isSelected)
    }
    
    @IBAction func didClickSwitchSpeakerButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        // Enables/Disables the audio playback route to the speakerphone.
        //
        // This method sets whether the audio is routed to the speakerphone or earpiece. After calling this method, the SDK returns the onAudioRouteChanged callback to indicate the changes.
        agoraKit!.setEnableSpeakerphone(sender.isSelected)
    }
    
}
