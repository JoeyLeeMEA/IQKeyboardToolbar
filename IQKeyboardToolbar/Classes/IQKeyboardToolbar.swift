//
//  IQKeyboardToolbar.swift
//  https://github.com/hackiftekhar/IQKeyboardToolbar
//  Copyright (c) 2013-24 Iftekhar Qurashi.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

/** @abstract IQKeyboardToolbar.    */
@available(iOSApplicationExtension, unavailable)
@MainActor
@objcMembers open class IQKeyboardToolbar: UIToolbar {

    override public init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {

        sizeToFit()

        autoresizingMask = .flexibleWidth
        self.isTranslucent = true
        self.barTintColor = nil

        let positions: [UIBarPosition] = [.any, .bottom, .top, .topAttached]

        for position in positions {

            self.setBackgroundImage(nil, forToolbarPosition: position, barMetrics: .default)
            self.setShadowImage(nil, forToolbarPosition: .any)
        }

        // Background color
        self.backgroundColor = nil
    }

    /**
     Additional bar buttons to show at the leading side.
     */
    open var additionalLeadingItems: [UIBarButtonItem] = []

    /**
     Additional bar buttons to show at the trailing side.
     */
    open var additionalTrailingItems: [UIBarButtonItem] = []

    /**
     Previous bar button of toolbar.
     */
    private var privatePreviousBarButton: IQBarButtonItem?
    open var previousBarButton: IQBarButtonItem {
        get {
            if privatePreviousBarButton == nil {
                privatePreviousBarButton = IQBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
            }
            return privatePreviousBarButton!
        }

        set (newValue) {
            privatePreviousBarButton = newValue
        }
    }

    /**
     Next bar button of toolbar.
     */
    private var privateNextBarButton: IQBarButtonItem?
    open var nextBarButton: IQBarButtonItem {
        get {
            if privateNextBarButton == nil {
                privateNextBarButton = IQBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
            }
            return privateNextBarButton!
        }

        set (newValue) {
            privateNextBarButton = newValue
        }
    }

    /**
     Title bar button of toolbar.
     */
    private var privateTitleBarButton: IQTitleBarButtonItem?
    open var titleBarButton: IQTitleBarButtonItem {
        get {
            if privateTitleBarButton == nil {
                privateTitleBarButton = IQTitleBarButtonItem(title: nil)
            }
            return privateTitleBarButton!
        }

        set (newValue) {
            privateTitleBarButton = newValue
        }
    }

    /**
     Done bar button of toolbar.
     */
    private var privateDoneBarButton: IQBarButtonItem?
    open var doneBarButton: IQBarButtonItem {
        get {
            if privateDoneBarButton == nil {
                privateDoneBarButton = IQBarButtonItem(title: nil, style: .done, target: nil, action: nil)
            }
            return privateDoneBarButton!
        }

        set (newValue) {
            privateDoneBarButton = newValue
        }
    }

    /**
     Fixed space bar button of toolbar.
     */
    private var privateFixedSpaceBarButton: IQBarButtonItem?
    open var fixedSpaceBarButton: IQBarButtonItem {
        get {
            if privateFixedSpaceBarButton == nil {
                privateFixedSpaceBarButton = IQBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            }
            privateFixedSpaceBarButton?.isSystemItem = true
            privateFixedSpaceBarButton?.width = 6

            return privateFixedSpaceBarButton!
        }

        set (newValue) {
            privateFixedSpaceBarButton = newValue
        }
    }

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFit: CGSize = super.sizeThatFits(size)
        if #available(iOS 26.0, *) {
            sizeThatFit.height = 48        
        } else {
            sizeThatFit.height = 44
        }        
        return sizeThatFit
    }

    override open var tintColor: UIColor! {

        didSet {
            guard let items: [UIBarButtonItem] = items else { return }
            for item in items {
                item.tintColor = tintColor
            }
        }
    }
}

@available(iOSApplicationExtension, unavailable)
@MainActor
@objc extension IQKeyboardToolbar: UIInputViewAudioFeedback {

    open var enableInputClicksWhenVisible: Bool {
        return true
    }
}
