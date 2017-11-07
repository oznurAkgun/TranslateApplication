//
//  CustomAnimatable.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/15.
//
//

public protocol CustomAnimatable: EasingAnimatable, UIAppearanceAnimatable {

    /// The Scale in 3-Dimensional vector.
    /// The default value is (x: 1, y: 1, z: 1).
    /// The range 0.0 to 1.0.
    @discardableResult func scale(x: CGFloat) -> CustomAnimatable
    @discardableResult func scale(y: CGFloat) -> CustomAnimatable
    @discardableResult func scale(z: CGFloat) -> CustomAnimatable
    @discardableResult func scale(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable

    /// The Angre of rotation in 3-Dimensional vector.
    /// The default value is (x: 0, y: 0, z: 0).
    /// The range 0.0 to 90.0.
    @discardableResult func rotationAngle(x: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(y: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(z: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    /// The translation in 3-Dimensional vector.
    /// The default value is (x: 0, y: 0, z: 0).
    @discardableResult func translation(x: CGFloat) -> CustomAnimatable
    @discardableResult func translation(y: CGFloat) -> CustomAnimatable
    @discardableResult func translation(z: CGFloat) -> CustomAnimatable
    @discardableResult func translation(x: CGFloat, y: CGFloat) -> CustomAnimatable
    @discardableResult func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    /// The anchor point of the layer's bounds rectangle.
    /// The default value is (x: 0.5, y: 0.5).
    /// - SeeAlso: [anchorPoint on Apple Developer Documentation](https://developer.apple.com/documentation/quartzcore/calayer/1410817-anchorpoint)
    @discardableResult func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable
}

extension GeminiAnimationModel: CustomAnimatable {
    /// Scale
    @discardableResult
    public func scale(x: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        return self
    }
    @discardableResult
    public func scale(y: CGFloat) -> CustomAnimatable {
        scaleStore.y = y
        return self
    }
    @discardableResult
    public func scale(z: CGFloat) -> CustomAnimatable {
        scaleStore.z = z
        return self
    }
    @discardableResult
    public func scale(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        scaleStore.y = y
        return self
    }
    @discardableResult
    public func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        scaleStore.x = x
        scaleStore.y = y
        scaleStore.z = z
        return self
    }
    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable {
        scaleEffect = effect
        return self
    }

    /// Rotation
    @discardableResult
    public func rotationAngle(x: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        return self
    }
    @discardableResult
    public func rotationAngle(y: CGFloat) -> CustomAnimatable {
        rotationStore.y = y
        return self
    }
    @discardableResult
    public func rotationAngle(z: CGFloat) -> CustomAnimatable {
        rotationStore.z = z
        return self
    }
    @discardableResult
    public func rotationAngle(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        rotationStore.y = y
        return self
    }
    @discardableResult
    public func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        rotationStore.x = x
        rotationStore.y = y
        rotationStore.z = z
        return self
    }

    /// Translation
    @discardableResult
    public func translation(x: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        return self
    }
    @discardableResult
    public func translation(y: CGFloat) -> CustomAnimatable {
        translationStore.y = y
        return self
    }
    @discardableResult
    public func translation(z: CGFloat) -> CustomAnimatable {
        translationStore.z = z
        return self
    }
    @discardableResult
    public func translation(x: CGFloat, y: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        translationStore.y = y
        return self
    }
    @discardableResult
    public func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable {
        translationStore.x = x
        translationStore.y = y
        translationStore.z = z
        return self
    }

    @discardableResult
    public func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable {
        self.anchorPoint = anchorPoint
        return self
    }
}

/// Custom animation properties
extension GeminiAnimationModel {
    struct ScaleStore {
        var x: CGFloat = 1
        var y: CGFloat = 1
        var z: CGFloat = 1
    }
    struct RotationStore {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
    struct TranslationStore {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var z: CGFloat = 0
    }
}
