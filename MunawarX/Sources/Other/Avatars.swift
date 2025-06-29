//
// Copyright 2022-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import Foundation
import SwiftUI

enum Avatars {
    enum Size {
        case user(on: UserAvatarSizeOnScreen)
        case room(on: RoomAvatarSizeOnScreen)
        //  custom
        case custom(CGFloat)

        /// Value in UIKit points
        var value: CGFloat {
            switch self {
            case .user(let screen):
                return screen.value
            case .room(let screen):
                return screen.value
            case .custom(let val):
                return val
            }
        }

        /// Value in pixels by using the scale of the main screen
        var scaledValue: CGFloat {
            value * UIScreen.main.scale
        }
        
        var scaledSize: CGSize {
            CGSize(width: scaledValue, height: scaledValue)
        }
    }
    
    @MainActor
    static func generatePlaceholderAvatarImageData(name: String, id: String, size: CGSize) -> Data? {
        let image = PlaceholderAvatarImage(name: name, contentID: id)
            .clipShape(Circle())
            .frame(width: size.width, height: size.height)
        
        let renderer = ImageRenderer(content: image)
        
        // Specify the scale so the image is rendered correctly. We don't have access to the screen
        // here so a hardcoded 3.0 will have to do
        renderer.scale = 3.0
        
        guard let image = renderer.uiImage else {
            MXLog.info("Generating notification icon placeholder failed")
            return nil
        }
        
        return image.pngData()
    }
}

enum UserAvatarSizeOnScreen {
    case timeline
    case home
    case settings
    case roomDetails
    case dmDetails
    case startChat
    case memberDetails
    case inviteUsers
    case readReceipt
    case readReceiptSheet
    case editUserDetails
    case completionSuggestions
    case blockedUsers
    case knockingUsersBannerStack
    case knockingUserBanner
    case knockingUserList
    case mediaPreviewDetails
    case sendInviteConfirmation
    case sessionVerification
    case threadSummary

    var value: CGFloat {
        switch self {
        case .readReceipt:
            return 16
        case .readReceiptSheet:
            return 32
        case .timeline:
            return 32
        case .home:
            return 32
        case .completionSuggestions:
            return 32
        case .blockedUsers:
            return 32
        case .settings:
            return 52
        case .roomDetails:
            return 44
        case .startChat:
            return 36
        case .memberDetails:
            return 96
        case .inviteUsers:
            return 56
        case .editUserDetails:
            return 96
        case .dmDetails:
            return 75
        case .knockingUsersBannerStack:
            return 28
        case .knockingUserBanner:
            return 32
        case .knockingUserList:
            return 52
        case .mediaPreviewDetails:
            return 32
        case .sendInviteConfirmation:
            return 64
        case .sessionVerification:
            return 52
        case .threadSummary:
            return 24
        }
    }
}

enum RoomAvatarSizeOnScreen {
    case timeline
    case home
    case messageForwarding
    case globalSearch
    case roomSelection
    case details
    case notificationSettings
    case roomDirectorySearch
    case joinRoom
    case completionSuggestions

    var value: CGFloat {
        switch self {
        case .notificationSettings:
            return 30
        case .timeline:
            return 32
        case .roomDirectorySearch:
            return 32
        case .completionSuggestions:
            return 32
        case .messageForwarding:
            return 36
        case .globalSearch:
            return 36
        case .roomSelection:
            return 36
        case .home:
            return 52
        case .details:
            return 96
        case .joinRoom:
            return 96
        }
    }
}
