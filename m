Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1671ACD3429
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F3E83D0B;
	Wed, 12 Nov 2025 18:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4F583D6C; Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF8483CEB
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qx160wz6y0;
 Wed, 12 Nov 2025 18:48:45 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qw296Zzsjd; Wed, 12 Nov 2025 18:48:44 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:09 +0100
Subject: [PATCH 04/11] doc: dt-bindings: remove duplicates with
 dts/upstream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-4-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Quentin Schulz <quentin.schulz@cherry.de>

doc/device-tree-bindings/leds/leds-bcm6328.txt can be found at
dts/upstream/Bindings/leds/leds-bcm6328.yaml.

doc/device-tree-bindings/leds/leds-bcm6358.txt can be found at
dts/upstream/Bindings/leds/leds-bcm6358.txt.

doc/device-tree-bindings/leds/leds-gpio.txt can be found at
dts/upstream/Bindings/leds/leds-gpio.yaml.

doc/device-tree-bindings/leds/leds-lp5562.txt can be found at
dts/upstream/Bindings/leds/leds-lp55xx.yaml.

Only two LED dt-bindings are left in U-Boot: leds-bcm6858.txt and
leds-pwm.txt. The former is partially supported by
dts/upstream/Bindings/leds/leds-bcm63138.yaml but is lacking all
optional properties we have listed in "downstream" dt-binding in U-Boot.
However, there doesn't seem to exist any user of that compatible.
The latter is partially supported by
dts/upstream/Bindings/leds/leds-pwm.yaml but is missing the
u-boot,default-brightness property, which is used by
arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi at the moment. The
default-brightness property is probably not what we want here as it
defaults to max-brightness if missing. I'm assuming we want a different
value for U-Boot (127) and the kernel (255 via max-brightness as a
default), which would prevent us from upstreaming this property, which
doesn't change the status quo, so let it be for now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/device-tree-bindings/leds/leds-bcm6328.txt | 106 -------------------
 doc/device-tree-bindings/leds/leds-bcm6358.txt | 141 -------------------------
 doc/device-tree-bindings/leds/leds-gpio.txt    |  52 ---------
 doc/device-tree-bindings/leds/leds-lp5562.txt  |  63 -----------
 4 files changed, 362 deletions(-)

diff --git a/doc/device-tree-bindings/leds/leds-bcm6328.txt b/doc/device-tree-bindings/leds/leds-bcm6328.txt
deleted file mode 100644
index 7f5597b7373..00000000000
--- a/doc/device-tree-bindings/leds/leds-bcm6328.txt
+++ /dev/null
@@ -1,106 +0,0 @@
-LEDs connected to Broadcom BCM6328 controller
-
-This controller is present on BCM6318, BCM6328, BCM6362 and BCM63268.
-In these SoCs it's possible to control LEDs both as GPIOs or by hardware.
-However, on some devices there are Serial LEDs (LEDs connected to a 74x164
-controller), which can either be controlled by software (exporting the 74x164
-as spi-gpio. See Documentation/devicetree/bindings/gpio/gpio-74x164.txt), or
-by hardware using this driver.
-Some of these Serial LEDs are hardware controlled (e.g. ethernet LEDs) and
-exporting the 74x164 as spi-gpio prevents those LEDs to be hardware
-controlled, so the only chance to keep them working is by using this driver.
-
-Required properties:
-  - compatible : should be "brcm,bcm6328-leds".
-  - #address-cells : must be 1.
-  - #size-cells : must be 0.
-  - reg : BCM6328 LED controller address and size.
-
-Optional properties:
-  - brcm,serial-leds : Boolean, enables Serial LEDs.
-    Default : false
-  - brcm,serial-mux : Boolean, enables Serial LEDs multiplexing.
-    Default : false
-  - brcm,serial-clk-low : Boolean, makes clock signal active low.
-    Default : false
-  - brcm,serial-dat-low : Boolean, makes data signal active low.
-    Default : false
-  - brcm,serial-shift-inv : Boolean, inverts Serial LEDs shift direction.
-    Default : false
-
-Each LED is represented as a sub-node of the brcm,bcm6328-leds device.
-
-LED sub-node required properties:
-  - reg : LED pin number (only LEDs 0 to 23 are valid).
-
-LED sub-node optional properties:
-  - label : see Documentation/devicetree/bindings/leds/common.txt
-  - active-low : Boolean, makes LED active low.
-    Default : false
-
-Examples:
-Scenario 1 : BCM6328 with 4 GPIO LEDs
-	leds0: led-controller@10000800 {
-		compatible = "brcm,bcm6328-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x10000800 0x24>;
-
-		alarm_red@2 {
-			reg = <2>;
-			active-low;
-			label = "red:alarm";
-		};
-		inet_green@3 {
-			reg = <3>;
-			active-low;
-			label = "green:inet";
-		};
-		power_green@4 {
-			reg = <4>;
-			active-low;
-			label = "green:power";
-		};
-	};
-
-Scenario 2 : BCM63268 with Serial LEDs
-	leds0: led-controller@10001900 {
-		compatible = "brcm,bcm6328-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x10001900 0x24>;
-		brcm,serial-leds;
-		brcm,serial-dat-low;
-		brcm,serial-shift-inv;
-
-		inet_red@2 {
-			reg = <2>;
-			active-low;
-			label = "red:inet";
-		};
-		dsl_green@3 {
-			reg = <3>;
-			active-low;
-			label = "green:dsl";
-		};
-		usb_green@4 {
-			reg = <4>;
-			active-low;
-			label = "green:usb";
-		};
-		wps_green@7 {
-			reg = <7>;
-			active-low;
-			label = "green:wps";
-		};
-		inet_green@8 {
-			reg = <8>;
-			active-low;
-			label = "green:inet";
-		};
-		power_green@20 {
-			reg = <20>;
-			active-low;
-			label = "green:power";
-		};
-	};
diff --git a/doc/device-tree-bindings/leds/leds-bcm6358.txt b/doc/device-tree-bindings/leds/leds-bcm6358.txt
deleted file mode 100644
index e394d9ebb40..00000000000
--- a/doc/device-tree-bindings/leds/leds-bcm6358.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-LEDs connected to Broadcom BCM6358 controller
-
-This controller is present on BCM6358 and BCM6368.
-In these SoCs there are Serial LEDs (LEDs connected to a 74x164 controller),
-which can either be controlled by software (exporting the 74x164 as spi-gpio.
-See Documentation/devicetree/bindings/gpio/gpio-74x164.txt), or
-by hardware using this driver.
-
-Required properties:
-  - compatible : should be "brcm,bcm6358-leds".
-  - #address-cells : must be 1.
-  - #size-cells : must be 0.
-  - reg : BCM6358 LED controller address and size.
-
-Optional properties:
-  - brcm,clk-div : SCK signal divider. Possible values are 1, 2, 4 and 8.
-    Default : 1
-  - brcm,clk-dat-low : Boolean, makes clock and data signals active low.
-    Default : false
-
-Each LED is represented as a sub-node of the brcm,bcm6358-leds device.
-
-LED sub-node required properties:
-  - reg : LED pin number (only LEDs 0 to 31 are valid).
-
-LED sub-node optional properties:
-  - label : see Documentation/devicetree/bindings/leds/common.txt
-  - active-low : Boolean, makes LED active low.
-    Default : false
-
-Examples:
-Scenario 1 : BCM6358
-	leds0: led-controller@fffe00d0 {
-		compatible = "brcm,bcm6358-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfffe00d0 0x8>;
-
-		alarm_white {
-			reg = <0>;
-			active-low;
-			label = "white:alarm";
-		};
-		tv_white {
-			reg = <2>;
-			active-low;
-			label = "white:tv";
-		};
-		tel_white {
-			reg = <3>;
-			active-low;
-			label = "white:tel";
-		};
-		adsl_white {
-			reg = <4>;
-			active-low;
-			label = "white:adsl";
-		};
-	};
-
-Scenario 2 : BCM6368
-	leds0: led-controller@100000d0 {
-		compatible = "brcm,bcm6358-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x100000d0 0x8>;
-		brcm,pol-low;
-		brcm,clk-div = <4>;
-
-		power_red {
-			reg = <0>;
-			active-low;
-			label = "red:power";
-		};
-		power_green {
-			reg = <1>;
-			active-low;
-			label = "green:power";
-			default-state = "on";
-		};
-		power_blue {
-			reg = <2>;
-			label = "blue:power";
-		};
-		broadband_red {
-			reg = <3>;
-			active-low;
-			label = "red:broadband";
-		};
-		broadband_green {
-			reg = <4>;
-			label = "green:broadband";
-		};
-		broadband_blue {
-			reg = <5>;
-			active-low;
-			label = "blue:broadband";
-		};
-		wireless_red {
-			reg = <6>;
-			active-low;
-			label = "red:wireless";
-		};
-		wireless_green {
-			reg = <7>;
-			active-low;
-			label = "green:wireless";
-		};
-		wireless_blue {
-			reg = <8>;
-			label = "blue:wireless";
-		};
-		phone_red {
-			reg = <9>;
-			active-low;
-			label = "red:phone";
-		};
-		phone_green {
-			reg = <10>;
-			active-low;
-			label = "green:phone";
-		};
-		phone_blue {
-			reg = <11>;
-			label = "blue:phone";
-		};
-		upgrading_red {
-			reg = <12>;
-			active-low;
-			label = "red:upgrading";
-		};
-		upgrading_green {
-			reg = <13>;
-			active-low;
-			label = "green:upgrading";
-		};
-		upgrading_blue {
-			reg = <14>;
-			label = "blue:upgrading";
-		};
-	};
diff --git a/doc/device-tree-bindings/leds/leds-gpio.txt b/doc/device-tree-bindings/leds/leds-gpio.txt
deleted file mode 100644
index df1b3080f6b..00000000000
--- a/doc/device-tree-bindings/leds/leds-gpio.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-LEDs connected to GPIO lines
-
-Required properties:
-- compatible : should be "gpio-leds".
-
-Each LED is represented as a sub-node of the gpio-leds device.  Each
-node's name represents the name of the corresponding LED.
-
-LED sub-node properties:
-- gpios :  Should specify the LED's GPIO, see "gpios property" in
-  Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs should be
-  indicated using flags in the GPIO specifier.
-- label :  (optional)
-  see Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger :  (optional)
-  see Documentation/devicetree/bindings/leds/common.txt
-- default-state:  (optional) The initial state of the LED.  Valid
-  values are "on", "off", and "keep".  If the LED is already on or off
-  and the default-state property is set the to same value, then no
-  glitch should be produced where the LED momentarily turns off (or
-  on).  The "keep" setting will keep the LED at whatever its current
-  state is, without producing a glitch.  The default is off if this
-  property is not present.
-
-Examples:
-
-leds {
-	compatible = "gpio-leds";
-	hdd {
-		label = "IDE Activity";
-		gpios = <&mcu_pio 0 1>; /* Active low */
-		linux,default-trigger = "ide-disk";
-	};
-
-	fault {
-		gpios = <&mcu_pio 1 0>;
-		/* Keep LED on if BIOS detected hardware fault */
-		default-state = "keep";
-	};
-};
-
-run-control {
-	compatible = "gpio-leds";
-	red {
-		gpios = <&mpc8572 6 0>;
-		default-state = "off";
-	};
-	green {
-		gpios = <&mpc8572 7 0>;
-		default-state = "on";
-	};
-};
diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt b/doc/device-tree-bindings/leds/leds-lp5562.txt
deleted file mode 100644
index 4e0c742959a..00000000000
--- a/doc/device-tree-bindings/leds/leds-lp5562.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-LEDs connected to TI LP5562 controller
-
-This driver works with a TI LP5562 4-channel LED controller.
-CONFIG_LED_BLINK is supported using the controller engines.  However
-there are only 3 engines available for the 4 channels.  This means
-that the blue and white channels share the same engine.  When both
-blue and white LEDs are set to blink, they will share the same blink
-rate.  Changing the blink rate of the blue LED will affect the white
-LED and vice-versa.  Manual on/off is handled independently for all 4
-channels.
-
-Required properties:
-  - compatible : should be "ti,lp5562".
-  - #address-cells : must be 1.
-  - #size-cells : must be 0.
-  - reg : LP5562 LED controller I2C address.
-
-Optional properties:
-  - enable-gpios : Enable GPIO
-  - clock-mode : u8, configures the clock mode:
-      - 0 # automode
-      - 1 # internal
-      - 2 # external
-
-Each LED is represented as a sub-node of the ti,lp5562 device.
-
-LED sub-node required properties:
-  - reg : Zero-based channel identifier:
-    - 0 red
-    - 1 green
-    - 2 blue
-    - 3 white
-
-LED sub-node optional properties:
-  - chan-name : name of LED
-  - max-cur : LED current at max brightness in 100uA steps (0x00 - 0xFF)
-    Default : 100 (10 mA)
-
-Example:
-        leds0: lp5562@30 {
-                compatible = "ti,lp5562";
-                #address-cells = <1>;
-                #size-cells = <0>;
-                enable-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
-                reg = <0x30>;
-		clock-mode = /bits/8 <1>;
-
-                led@0 {
-                        reg = <0>;
-                        chan-name = "red";
-                        max-cur = /bits/ 8 <200>; /* 20mA */
-                };
-                led@1 {
-                        reg = <1>;
-                        chan-name = "green";
-                        max-cur = /bits/ 8 <200>; /* 20mA */
-                };
-                led@2 {
-                        reg = <2>;
-                        chan-name = "blue";
-                        max-cur = /bits/ 8 <200>; /* 20mA */
-                };
-        };

-- 
2.51.1

