//
//  TapCardInputView.swift
//  TapCardCheckOutKit
//
//  Created by Osama Rabie on 21/03/2022.
//

import UIKit
import TapCardInputKit_iOS
import TapCardVlidatorKit_iOS
import CommonDataModelsKit_iOS
import TapThemeManager2020

/// Represents the on the shelf card forum entry view
@objc public class TapCardInputView : UIView {
    /// Represents the main holding view
    @IBOutlet var contentView: UIView!
    /// Represents the UI part of the embedded card entry forum
    @IBOutlet weak var tapCardInput: TapCardInput!
    
    
    /// Represents the mode of the sdk . Whether sandbox or production
    public var sdkMode:SDKMode = .sandbox
    /// The ISO 639-1 Code language identefier, please note if the passed locale is wrong or not found in the localisation files, we will show the keys instead of the values
    public var localeIdentifier:String = "en"
    /// The secret keys providede to your business from TAP.
    public var secretKey:SecretKey = .init(sandbox: "", production: "")
    
    /// Holds the latest card info provided by the user
    private var currentTapCard:TapCard?
    
    // Mark:- Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    
    // MARK:- Public functions
    
    /**
     Handles initializing the card forum engine with the required data to be able to tokenize on demand. It calls the Init api
     - Parameter dataConfig: The data configured by you as a merchant (e.g. secret key, locale, etc.)
     */
    @objc public func initCardForm(with dataConfig:TapCardDataConfiguration) {
        // Store the configueation data for further access
        NetworkManager.shared.dataConfig = dataConfig
        // Infotm the network manager to init itself from the init api
        NetworkManager.shared.initialiseSDKFromAPI()
    }
    
    
    // MARK:- Private functions
    /// Used as a consolidated method to do all the needed steps upon creating the view
    private func commonInit() {
        self.contentView = setupXIB()
        initUI()
    }
    
    /// Does the needed pre logic to shape the card input UI forum
    private func initUI() {
        // Let it go with the UI constraints
        tapCardInput.translatesAutoresizingMaskIntoConstraints = false
        // No saving card and no scanning option for the card kit
        tapCardInput.showSaveCardOption = false
        tapCardInput.showScanningOption = false
        // Let us configure the theming and the internal variabls of the card input forum
        configureCardInputUI()
    }
    
    
    ///  Initiates the card input forum by adjusting the UI and defining the card brands
    private func configureCardInputUI() {
        // Set the default
        TapThemeManager.setDefaultTapTheme()
        // As per the requirement, the card forum kit will not care about allowed card brands,
        // Hence we declare it to accept all cards.
        tapCardInput.setup(for: .InlineCardInput, allowedCardBrands: CardBrand.allCases.map{ $0.rawValue })
        // Let us listen to the card input ui callbacks if needed
        tapCardInput.delegate = self
    }
}

extension TapCardInputView : TapCardInputProtocol {
    public func cardDataChanged(tapCard: TapCard) {
        currentTapCard = tapCard
    }
    
    public func brandDetected(for cardBrand: CardBrand, with validation: CrardInputTextFieldStatusEnum) {
        
    }
    
    public func scanCardClicked() {
        
    }
    
    public func saveCardChanged(enabled: Bool) {
        
    }
    
    public func dataChanged(tapCard: TapCard) {
        currentTapCard = tapCard
    }
    
    public func shouldAllowChange(with cardNumber: String) -> Bool {
        return true
    }
}