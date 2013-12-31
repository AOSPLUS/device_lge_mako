#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Live Wallpapers
PRODUCT_PACKAGES += \
        LiveWallpapers \
        LiveWallpapersPicker \
        VisualizationWallpapers 

# AOSPLUS apps
PRODUCT_PACKAGES += \
        UpdateCenter \


# Get the long list of APNs
PRODUCT_COPY_FILES := device/lge/mako/apns-full-conf.xml:system/etc/apns-conf.xml

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_NAME := full_mako
PRODUCT_DEVICE := mako
PRODUCT_BRAND := Android
PRODUCT_MODEL := Nexus 4
PRODUCT_MANUFACTURER := LGE
PRODUCT_RESTRICT_VENDOR_FILES := true


# AOSPLUS 4.4 beta releases
PRODUCT_VERSION_MAJOR = 4.4.2
PRODUCT_VERSION_MINOR = stable
PRODUCT_VERSION_MAINTENANCE = 1.0
ifdef AOSPLUS_BUILD_EXTRA
    AOSPLUS_POSTFIX := -$(AOSPLUS_BUILD_EXTRA)
endif
ifndef AOSPLUS_BUILD_TYPE
    AOSPLUS_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
    AOSPLUS_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
AOSPLUS_VERSION := aosplus-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPLUS_BUILD_TYPE)$(AOSPLUS_POSTFIX)
AOSPLUS_MOD_VERSION := aosplus-$(PRODUCT_DEVICE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPLUS_BUILD_TYPE)$(AOSPLUS_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    Javierd.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.Javierd.version=$(AOSPLUS_VERSION) \
    ro.modversion=$(AOSPLUS_MOD_VERSION)

# Bootanimation and apps
PRODUCT_COPY_FILES := vendor/AOSPLUS/prebuilt/commom/bootanimation/bootanimation.zip:system/media/

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/lge/mako/device.mk)
$(call inherit-product-if-exists, vendor/lge/mako/device-vendor.mk)
