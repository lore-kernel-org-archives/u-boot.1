Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF7C79FBD
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F1A83F36;
	Mon,  5 Jan 2026 20:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ktq6MgzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EDB83EF2; Mon,  5 Jan 2026 20:47:42 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A1283E7A
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=Bjj2SmYN6BVFHHhHa5hLVRb0XH43g5T5KAdbtk3bNNg=; b=ktq6MgzQfiPq5KBqutb5nXBou3
 yCNwBNp9HuSYpWDjTRwjyRiigKMCE/tVMRKN0i7ZgUAF7ceBBP6nEVhf3mcxNktUIvcb6Biw5RF1f
 1Uzq7pYtXl6tl0zVQ/Zl+egw7TD7r5u+REOPYYK7e7pzLWXDdDey2g5wEjXfM5bXOQaiWTrRZG7ks
 TjtFQlHWPXpr8IYWy7SF15xQ5zR13nq6AYtJfgkkuAA75w1w3D2vez4c1uPow0yNt8z2SW5S1SRaO
 VyE+frQDKNrwDNaKGvhFs4R2U6lgJGUOJPaaYM01Q8GIbl5jzNMH4VKgxaOcnbvWNYZ3K6LPlT+lR
 onGwhxYw==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqYA-001AcR-AF; Mon, 05 Jan 2026 20:47:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 09/12] arm64: dts: rockchip: move common qnap tsx33 parts to
 dtsi
Date: Mon,  5 Jan 2026 20:47:20 +0100
Message-ID: <20260105194723.2928608-10-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The NAS series based around the rk3568 contains a number of models with
1-4 drives, that reuse most of the board structure.

Therefore move the shared parts to a dtsi, to be included by the devices.

As the smallest device is the 1-bay TS133, keep everything > slot1 in
the individual devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20251112214206.423244-4-heiko@sntech.de

[ upstream commit: 35202606ea08b9ec2b1386ac937a729e25d5beb0 ]

(cherry picked from commit 8cf4cbd14444705137b5129a2acba303eb975fd1)
---
 .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 666 +-----------------
 .../src/arm64/rockchip/rk3568-qnap-tsx33.dtsi | 608 ++++++++++++++++
 2 files changed, 645 insertions(+), 629 deletions(-)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3568-qnap-tsx33.dtsi

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 224db87973b..d1e3b7e7a28 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -6,10 +6,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/gpio/gpio.h>
-#include "rk3568.dtsi"
+#include "rk3568-qnap-tsx33.dtsi"
 
 / {
 	model = "Qnap TS-433-4G NAS System 4-Bay";
@@ -17,83 +14,6 @@
 
 	aliases {
 		ethernet0 = &gmac0;
-		mmc0 = &sdhci;
-		rtc0 = &rtc_rv8263;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	keys {
-		compatible = "gpio-keys";
-		pinctrl-0 = <&copy_button_pin>, <&reset_button_pin>;
-		pinctrl-names = "default";
-
-		key-copy {
-			label = "copy";
-			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_COPY>;
-		};
-
-		key-reset {
-			label = "reset";
-			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_RESTART>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
-			label = "hdd1:green:disk";
-			linux,default-trigger = "disk-activity";
-			pinctrl-names = "default";
-			pinctrl-0 = <&hdd1_led_pin>;
-		};
-
-		led-1 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
-			label = "hdd2:green:disk";
-			linux,default-trigger = "disk-activity";
-			pinctrl-names = "default";
-			pinctrl-0 = <&hdd2_led_pin>;
-		};
-
-		led-2 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
-			label = "hdd3:green:disk";
-			linux,default-trigger = "disk-activity";
-			pinctrl-names = "default";
-			pinctrl-0 = <&hdd3_led_pin>;
-		};
-
-		led-3 {
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
-			label = "hdd4:green:disk";
-			linux,default-trigger = "disk-activity";
-			pinctrl-names = "default";
-			pinctrl-0 = <&hdd4_led_pin>;
-		};
-	};
-
-	dc_12v: regulator-dc-12v {
-		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
 	};
 
 	vcc3v3_pcie: regulator-vcc3v3-pcie {
@@ -105,74 +25,6 @@
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
 		vin-supply = <&dc_12v>;
 	};
-
-	vcc3v3_sys: regulator-vcc3v3-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vcc5v0_host: regulator-vcc5v0-host {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
-		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
-		regulator-name = "vcc5v0_host";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
-	};
-
-	vcc5v0_otg: regulator-vcc5v0-otg {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_otg_en>;
-		regulator-name = "vcc5v0_otg";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usb>;
-	};
-
-	vcc5v0_sys: regulator-vcc5v0-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vcc5v0_usb: regulator-vcc5v0-usb {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
-	};
-};
-
-/* connected to usb_host0_xhci */
-&combphy0 {
-	status = "okay";
-};
-
-/* connected to sata1 */
-&combphy1 {
-	status = "okay";
 };
 
 /* connected to sata2 */
@@ -180,70 +32,6 @@
 	status = "okay";
 };
 
-&cpu0 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-/*
- * The MCU can provide system temperature too, but only by polling and of
- * course also cannot set trip points. So attach to the cpu thermal-zone
- * instead to control the fan.
- */
-&cpu_thermal {
-	trips {
-		case_fan0: case-fan0 {
-			hysteresis = <2000>;
-			temperature = <35000>;
-			type = "active";
-		};
-
-		case_fan1: case-fan1 {
-			hysteresis = <2000>;
-			temperature = <45000>;
-			type = "active";
-		};
-
-		case_fan2: case-fan2 {
-			hysteresis = <2000>;
-			temperature = <65000>;
-			type = "active";
-		};
-	};
-
-	cooling-maps {
-		/*
-		 * Always provide some air movement, due to small case
-		 * full of harddrives.
-		 */
-		map1 {
-			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
-			trip = <&case_fan0>;
-		};
-
-		map2 {
-			cooling-device = <&fan 2 3>;
-			trip = <&case_fan1>;
-		};
-
-		map3 {
-			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
-			trip = <&case_fan2>;
-		};
-	};
-};
-
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -260,263 +48,7 @@
 	status = "okay";
 };
 
-&gpu {
-	mali-supply = <&vdd_gpu>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	pmic@20 {
-		compatible = "rockchip,rk809";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
-		#clock-cells = <1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
-		system-power-controller;
-		vcc1-supply = <&vcc3v3_sys>;
-		vcc2-supply = <&vcc3v3_sys>;
-		vcc3-supply = <&vcc3v3_sys>;
-		vcc4-supply = <&vcc3v3_sys>;
-		vcc5-supply = <&vcc3v3_sys>;
-		vcc6-supply = <&vcc3v3_sys>;
-		vcc7-supply = <&vcc3v3_sys>;
-		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc3v3_sys>;
-		wakeup-source;
-
-		regulators {
-			vdd_logic: DCDC_REG1 {
-				regulator-name = "vdd_logic";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
-				regulator-always-on;
-				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-initial-mode = <0x2>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vdd_npu: DCDC_REG4 {
-				regulator-name = "vdd_npu";
-				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_1v8: DCDC_REG5 {
-				regulator-name = "vcc_1v8";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdda0v9_image: LDO_REG1 {
-				regulator-name = "vdda0v9_image";
-				regulator-always-on;
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdda_0v9: LDO_REG2 {
-				regulator-name = "vdda_0v9";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdda0v9_pmu: LDO_REG3 {
-				regulator-name = "vdda0v9_pmu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <900000>;
-				};
-			};
-
-			vccio_acodec: LDO_REG4 {
-				regulator-name = "vccio_acodec";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc3v3_pmu: LDO_REG6 {
-				regulator-name = "vcc3v3_pmu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcca_1v8: LDO_REG7 {
-				regulator-name = "vcca_1v8";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcca1v8_pmu: LDO_REG8 {
-				regulator-name = "vcca1v8_pmu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcca1v8_image: LDO_REG9 {
-				regulator-name = "vcca1v8_image";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_3v3: SWITCH_REG1 {
-				regulator-name = "vcc_3v3";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc3v3_sd: SWITCH_REG2 {
-				regulator-name = "vcc3v3_sd";
-				/*
-				 * turning this off, breaks access to both
-				 * PCIe controllers, refclk generator perhaps
-				 */
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-		};
-	};
-
-	vdd_cpu: regulator@40 {
-		compatible = "silergy,syr827";
-		reg = <0x40>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <712500>;
-		regulator-max-microvolt = <1390000>;
-		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-};
-
 &i2c1 {
-	status = "okay";
-
-	rtc_rv8263: rtc@51 {
-		compatible = "microcrystal,rv8263";
-		reg = <0x51>;
-		wakeup-source;
-	};
-
-	/* eeprom for vital-product-data on the mainboard */
-	eeprom@54 {
-		compatible = "giantec,gt24c04a", "atmel,24c04";
-		reg = <0x54>;
-		label = "VPD_MB";
-		num-addresses = <2>;
-		pagesize = <16>;
-		read-only;
-	};
-
 	/* eeprom for vital-product-data on the backplane */
 	eeprom@56 {
 		compatible = "giantec,gt24c04a", "atmel,24c04";
@@ -528,6 +60,42 @@
 	};
 };
 
+&leds {
+	led-1 {
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_DISK;
+		gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
+		label = "hdd2:green:disk";
+		linux,default-trigger = "disk-activity";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdd2_led_pin>;
+	};
+
+	led-2 {
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_DISK;
+		gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
+		label = "hdd3:green:disk";
+		linux,default-trigger = "disk-activity";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdd3_led_pin>;
+	};
+
+	led-3 {
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_DISK;
+		gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
+		label = "hdd4:green:disk";
+		linux,default-trigger = "disk-activity";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdd4_led_pin>;
+	};
+};
+
+&mcu {
+	compatible = "qnap,ts433-mcu";
+};
+
 &mdio0 {
 	rgmii_phy0: ethernet-phy@3 {
 		/* Motorcomm YT8521 phy */
@@ -567,21 +135,7 @@
 		};
 	};
 
-	keys {
-		copy_button_pin: copy-button-pin {
-			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		reset_button_pin: reset-button-pin {
-			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
 	leds {
-		hdd1_led_pin: hdd1-led-pin {
-			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
 		hdd2_led_pin: hdd2-led-pin {
 			rockchip,pins = <1 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
@@ -594,152 +148,12 @@
 			rockchip,pins = <2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
-
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb {
-		vcc5v0_host_en: vcc5v0-host-en {
-			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		vcc5v0_otg_en: vcc5v0-otg-en {
-			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pmu_io_domains {
-	vccio4-supply = <&vcc_1v8>;
-	vccio6-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sata1 {
-	status = "okay";
 };
 
 &sata2 {
 	status = "okay";
 };
 
-&sdhci {
-	bus-width = <8>;
-	max-frequency = <200000000>;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <1>;
-	rockchip,hw-tshut-polarity = <0>;
-	status = "okay";
-};
-
-/*
- * Connected to an MCU, that provides access to more LEDs,
- * buzzer, fan control and more.
- */
-&uart0 {
-	status = "okay";
-
-	mcu {
-		compatible = "qnap,ts433-mcu";
-
-		fan: fan-0 {
-			#cooling-cells = <2>;
-			cooling-levels = <0 64 89 128 166 204 221 238>;
-		};
-
-		nvmem-layout {
-			compatible = "fixed-layout";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			serial-number@0 {
-				reg = <0x0 0x13>;
-			};
-
-			ext-port@22 {
-				reg = <0x22 0x2>;
-			};
-
-			mac0: mac@24 {
-				compatible = "mac-base";
-				reg = <0x24 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac1: mac@35 {
-				compatible = "mac-base";
-				reg = <0x35 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac2: mac@46 {
-				compatible = "mac-base";
-				reg = <0x46 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac3: mac@57 {
-				compatible = "mac-base";
-				reg = <0x57 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac4: mac@68 {
-				compatible = "mac-base";
-				reg = <0x68 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac5: mac@79 {
-				compatible = "mac-base";
-				reg = <0x79 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac6: mac@8a {
-				compatible = "mac-base";
-				reg = <0x8a 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-
-			mac7: mac@9b {
-				compatible = "mac-base";
-				reg = <0x9b 0x11>;
-				#nvmem-cell-cells = <1>;
-			};
-		};
-	};
-};
-
-/*
- * Pins available on CN3 connector at TTL voltage level (3V3).
- * ,_  _.
- * |1234|  1=TX 2=VCC
- * `----'  3=RX 4=GND
- */
-&uart2 {
-	status = "okay";
-};
-
-&usb2phy0 {
-	status = "okay";
-};
-
-/* connected to usb_host0_xhci */
-&usb2phy0_otg {
-	phy-supply = <&vcc5v0_otg>;
-	status = "okay";
-};
-
 &usb2phy1 {
 	status = "okay";
 };
@@ -765,12 +179,6 @@
 	status = "okay";
 };
 
-/* front port */
-&usb_host0_xhci {
-	dr_mode = "host";
-	status = "okay";
-};
-
 /* left port backside */
 &usb_host1_ehci {
 	status = "okay";
diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-tsx33.dtsi b/dts/upstream/src/arm64/rockchip/rk3568-qnap-tsx33.dtsi
new file mode 100644
index 00000000000..f009275c72c
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-tsx33.dtsi
@@ -0,0 +1,608 @@
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "rk3568.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &sdhci;
+		rtc0 = &rtc_rv8263;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&copy_button_pin>, <&reset_button_pin>;
+		pinctrl-names = "default";
+
+		key-copy {
+			label = "copy";
+			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_COPY>;
+		};
+
+		key-reset {
+			label = "reset";
+			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+			label = "hdd1:green:disk";
+			linux,default-trigger = "disk-activity";
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdd1_led_pin>;
+		};
+	};
+
+	dc_12v: regulator-dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc3v3_sys: regulator-vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_host: regulator-vcc5v0-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_otg: regulator-vcc5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_otg_en>;
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_sys: regulator-vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb: regulator-vcc5v0-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+};
+
+/* connected to usb_host0_xhci */
+&combphy0 {
+	status = "okay";
+};
+
+/* connected to sata1 */
+&combphy1 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+/*
+ * The MCU can provide system temperature too, but only by polling and of
+ * course also cannot set trip points. So attach to the cpu thermal-zone
+ * instead to control the fan.
+ */
+&cpu_thermal {
+	trips {
+		case_fan0: case-fan0 {
+			hysteresis = <2000>;
+			temperature = <35000>;
+			type = "active";
+		};
+
+		case_fan1: case-fan1 {
+			hysteresis = <2000>;
+			temperature = <45000>;
+			type = "active";
+		};
+
+		case_fan2: case-fan2 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		/*
+		 * Always provide some air movement, due to small case
+		 * full of harddrives.
+		 */
+		map1 {
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+			trip = <&case_fan0>;
+		};
+
+		map2 {
+			cooling-device = <&fan 2 3>;
+			trip = <&case_fan1>;
+		};
+
+		map3 {
+			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
+			trip = <&case_fan2>;
+		};
+	};
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		system-power-controller;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+				/*
+				 * turning this off, breaks access to both
+				 * PCIe controllers, refclk generator perhaps
+				 */
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+
+	vdd_cpu: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1390000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	rtc_rv8263: rtc@51 {
+		compatible = "microcrystal,rv8263";
+		reg = <0x51>;
+		wakeup-source;
+	};
+
+	/* eeprom for vital-product-data on the mainboard */
+	eeprom@54 {
+		compatible = "giantec,gt24c04a", "atmel,24c04";
+		reg = <0x54>;
+		label = "VPD_MB";
+		num-addresses = <2>;
+		pagesize = <16>;
+		read-only;
+	};
+};
+
+&pinctrl {
+	keys {
+		copy_button_pin: copy-button-pin {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		hdd1_led_pin: hdd1-led-pin {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc5v0_otg_en: vcc5v0-otg-en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	vccio4-supply = <&vcc_1v8>;
+	vccio6-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+/*
+ * Connected to an MCU, that provides access to more LEDs,
+ * buzzer, fan control and more.
+ */
+&uart0 {
+	status = "okay";
+
+	mcu: mcu {
+		fan: fan-0 {
+			#cooling-cells = <2>;
+			cooling-levels = <0 64 89 128 166 204 221 238>;
+		};
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			serial-number@0 {
+				reg = <0x0 0x13>;
+			};
+
+			ext-port@22 {
+				reg = <0x22 0x2>;
+			};
+
+			mac0: mac@24 {
+				compatible = "mac-base";
+				reg = <0x24 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac1: mac@35 {
+				compatible = "mac-base";
+				reg = <0x35 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac2: mac@46 {
+				compatible = "mac-base";
+				reg = <0x46 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac3: mac@57 {
+				compatible = "mac-base";
+				reg = <0x57 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac4: mac@68 {
+				compatible = "mac-base";
+				reg = <0x68 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac5: mac@79 {
+				compatible = "mac-base";
+				reg = <0x79 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac6: mac@8a {
+				compatible = "mac-base";
+				reg = <0x8a 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac7: mac@9b {
+				compatible = "mac-base";
+				reg = <0x9b 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
+};
+
+/*
+ * Pins available on CN3 connector at TTL voltage level (3V3).
+ * ,_  _.
+ * |1234|  1=TX 2=VCC
+ * `----'  3=RX 4=GND
+ */
+&uart2 {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+/* connected to usb_host0_xhci */
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+	status = "okay";
+};
+
+/* front port */
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.47.2

