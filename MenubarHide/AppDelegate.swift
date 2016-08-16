//
//  AppDelegate.swift
//  MenubarHide
//
//  Created by Theo WU on 22/05/2016.
//  Copyright © 2016 Theo WU. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let openedIcon = NSImage(named: "statusIcon_open")
    let closedIcon = NSImage(named: "statusIcon_close")

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        openedIcon?.template = true
        closedIcon?.template = true
        
        statusItem.image = closedIcon
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func menuItemClicked(sender: NSMenuItem) {
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        
        if(sender.state == NSOnState) {
            sender.state = NSOffState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
            statusItem.image = closedIcon
        } else {
            sender.state = NSOnState
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
            statusItem.image = openedIcon
        }
        
        task.launch()
        task.waitUntilExit()
        
        let killtask = NSTask()
        killtask.launchPath = "/usr/bin/killall"
        killtask.arguments = ["Finder"]
        killtask.launch()
        
    }
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
}

