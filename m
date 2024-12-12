Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168AE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1995F8029E;
	Thu, 12 Dec 2024 23:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zHMhBht1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B65802F4; Thu, 12 Dec 2024 23:10:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8E7801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041448; bh=euv7CmqocsrmHx9TG20ufGfUPIzl1mQW58ZA5zdJ1ZE=;
 b=zHMhBht1/Zrz8lTBYXBZFYo9oOsWvvPBZO8kVH2MqOqHq2uLsXJcDFVB8HNnAZBNUEEmpBEyo
 SeVRYZJG+2LH1SQm7aDqUxKITFGYlkp7vtgIHd94AB043NJNIvvZ2X3H/h5o98U4eYL2SFECah3
 MukRFtKu+iUipDl7qrNaMCcaByFXyiyMCLeko4J6lt+6CrtSw468/aR/NxN6adUaMHYg7gICGYT
 jfS6CzAISmInZDFipLljPiQIzFNX6afrV1YCTGzpyszWtVPUbmGF/hjHihYHieZVXd6r0xlmNPV
 Xymg+v4elXyGc5huhubIEVOV9xPl2ViNH1Sa/nFtP02w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 09/11] rockchip: rk3288-firefly: Migrate to OF_UPSTREAM
Date: Thu, 12 Dec 2024 22:09:42 +0000
Message-ID: <20241212221000.94501-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 675b5f65a511ed8f0b3fc8a9
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

The device tree for Firefly-RK3288 in dts/upstream can be used as-is by
U-Boot, migrate board to use OF_UPSTREAM.

Add chosen stdout-path prop to board u-boot.dtsi as it is missing in DT
from dts/upstream. Also change to use the upstream power_led symbol.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/rk3288-firefly-u-boot.dtsi  |  10 +-
 arch/arm/dts/rk3288-firefly.dts          |  43 --
 arch/arm/dts/rk3288-firefly.dtsi         | 491 -----------------------
 board/firefly/firefly-rk3288/MAINTAINERS |   1 +
 configs/firefly-rk3288_defconfig         |   6 +-
 6 files changed, 11 insertions(+), 541 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-firefly.dts
 delete mode 100644 arch/arm/dts/rk3288-firefly.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7f945d90d753..aea9e6acbf33 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -69,7 +69,6 @@ dtb-$(CONFIG_ROCKCHIP_RK322X) += \
 
 dtb-$(CONFIG_ROCKCHIP_RK3288) += \
 	rk3288-evb.dtb \
-	rk3288-firefly.dtb \
 	rk3288-popmetal.dtb \
 	rk3288-rock2-square.dtb \
 	rk3288-rock-pi-n8.dtb \
diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index f953f6821326..13f5be27a969 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -6,10 +6,8 @@
 #include "rk3288-u-boot.dtsi"
 
 / {
-	leds {
-		power {
-			default-state = "on";
-		};
+	chosen {
+		stdout-path = "serial2:115200n8";
 	};
 };
 
@@ -73,6 +71,10 @@
 	bootph-some-ram;
 };
 
+&power_led {
+	default-state = "on";
+};
+
 &sdmmc {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/arch/arm/dts/rk3288-firefly.dts b/arch/arm/dts/rk3288-firefly.dts
deleted file mode 100644
index 72982efdf6df..000000000000
--- a/arch/arm/dts/rk3288-firefly.dts
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * Copyright (c) 2014, 2015 FUKAUMI Naoki <naobsd@gmail.com>
- */
-
-/dts-v1/;
-#include "rk3288-firefly.dtsi"
-
-/ {
-	model = "Firefly-RK3288";
-	compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&ir {
-	gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
-};
-
-&pinctrl {
-	act8846 {
-		pmic_vsel: pmic-vsel {
-			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-	};
-
-	ir {
-		ir_int: ir-int {
-			rockchip,pins = <7 0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-firefly.dtsi b/arch/arm/dts/rk3288-firefly.dtsi
deleted file mode 100644
index 0824b19ee642..000000000000
--- a/arch/arm/dts/rk3288-firefly.dtsi
+++ /dev/null
@@ -1,491 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * Copyright (c) 2014, 2015 FUKAUMI Naoki <naobsd@gmail.com>
- */
-
-#include "rk3288.dtsi"
-
-/ {
-	memory {
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-
-	ir: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		pinctrl-names = "default";
-		pinctrl-0 = <&ir_int>;
-	};
-
-	keys: gpio-keys {
-		compatible = "gpio-keys";
-
-		button@0 {
-			gpio-key,wakeup = <1>;
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			label = "GPIO Power";
-			linux,code = <116>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pwr_key>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		work {
-			gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
-			label = "firefly:blue:user";
-			linux,default-trigger = "rc-feedback";
-			pinctrl-names = "default";
-			pinctrl-0 = <&work_led>;
-		};
-
-		power {
-			gpios = <&gpio8 2 GPIO_ACTIVE_LOW>;
-			label = "firefly:green:power";
-			linux,default-trigger = "default-on";
-			pinctrl-names = "default";
-			pinctrl-0 = <&power_led>;
-		};
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_sd: sdmmc-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr>;
-		regulator-name = "vcc_sd";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <100000>;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc_flash: flash-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_flash";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc_5v: usb-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vcc_host_5v: usb-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc_host_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_5v>;
-	};
-
-	vcc_otg_5v: usb-otg-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
-		regulator-name = "vcc_otg_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_5v>;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	broken-cd;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_pwr>, <&emmc_bus8>;
-	vmmc-supply = <&vcc_io>;
-	vqmmc-supply = <&vcc_flash>;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	clock_in_out = "input";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
-	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	vdd_cpu: syr827@40 {
-		compatible = "silergy,syr827";
-		fcs,suspend-voltage-selector = <1>;
-		reg = <0x40>;
-		regulator-name = "vdd_cpu";
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vdd_gpu: syr828@41 {
-		compatible = "silergy,syr828";
-		fcs,suspend-voltage-selector = <1>;
-		reg = <0x41>;
-		regulator-name = "vdd_gpu";
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-		interrupt-parent = <&gpio7>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_int>;
-	};
-
-	act8846: act8846@5a {
-		compatible = "active-semi,act8846";
-		reg = <0x5a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_vsel>, <&pwr_hold>;
-		system-power-controller;
-
-		regulators {
-			vcc_ddr: REG1 {
-				regulator-name = "vcc_ddr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-			};
-
-			vcc_io: REG2 {
-				regulator-name = "vcc_io";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_log: REG3 {
-				regulator-name = "vdd_log";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			vcc_20: REG4 {
-				regulator-name = "vcc_20";
-				regulator-min-microvolt = <2000000>;
-				regulator-max-microvolt = <2000000>;
-				regulator-always-on;
-			};
-
-			vccio_sd: REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd10_lcd: REG6 {
-				regulator-name = "vdd10_lcd";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcca_18: REG7 {
-				regulator-name = "vcca_18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vcca_33: REG8 {
-				regulator-name = "vcca_33";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vcc_lan: REG9 {
-				regulator-name = "vcc_lan";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vdd_10: REG10 {
-				regulator-name = "vdd_10";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcc_18: REG11 {
-				regulator-name = "vcc_18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vcc18_lcd: REG12 {
-				regulator-name = "vcc18_lcd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	pcfg_output_low: pcfg-output-low {
-		output-low;
-	};
-
-	pcfg_pull_up_drv_12ma: pcfg-pull-up-drv-12ma {
-		bias-pull-up;
-		drive-strength = <12>;
-	};
-
-	act8846 {
-		pwr_hold: pwr-hold {
-			rockchip,pins = <0 1 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	gmac {
-		phy_int: phy-int {
-			rockchip,pins = <0 9 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_pmeb: phy-pmeb {
-			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_rst: phy-rst {
-			rockchip,pins = <4 8 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	hym8563 {
-		rtc_int: rtc-int {
-			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	keys {
-		pwr_key: pwr-key {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	leds {
-		power_led: power-led {
-			rockchip,pins = <8 2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		work_led: work-led {
-			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdmmc {
-		/*
-		 * Default drive strength isn't enough to achieve even
-		 * high-speed mode on firefly board so bump up to 12ma.
-		 */
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins = <6 RK_PC0 1 &pcfg_pull_up_drv_12ma>,
-					<6 RK_PC1 1 &pcfg_pull_up_drv_12ma>,
-					<6 RK_PC2 1 &pcfg_pull_up_drv_12ma>,
-					<6 RK_PC3 1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 RK_PC4 1 &pcfg_pull_none_12ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins = <6 RK_PC5 1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		usbhub_rst: usbhub-rst {
-			rockchip,pins = <8 3 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	usb_otg {
-		otg_vbus_drv: otg-vbus-drv {
-			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&saradc {
-	vref-supply = <&vcc_18>;
-	status = "okay";
-};
-
-&sdio0 {
-	broken-cd;
-	bus-width = <4>;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
-	vmmc-supply = <&vcc_18>;
-	status = "disabled";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
-	vmmc-supply = <&vcc_sd>;
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_clk>, <&spi0_cs0>, <&spi0_tx>, <&spi0_rx>, <&spi0_cs1>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&usb_host1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usbhub_rst>;
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/board/firefly/firefly-rk3288/MAINTAINERS b/board/firefly/firefly-rk3288/MAINTAINERS
index 42db0bd5e1f4..174027e770bf 100644
--- a/board/firefly/firefly-rk3288/MAINTAINERS
+++ b/board/firefly/firefly-rk3288/MAINTAINERS
@@ -1,6 +1,7 @@
 FIREFLY
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
+F:	arch/arm/dts/rk3288-firefly-u-boot.dtsi
 F:	board/firefly/firefly-rk3288
 F:	include/configs/firefly-rk3288.h
 F:	configs/firefly-rk3288_defconfig
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 661ac065ce39..a79e217c7adf 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x01000000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-firefly"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-firefly"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_FIREFLY_RK3288=y
@@ -18,7 +18,7 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_DEFAULT_FDT_FILE="rk3288-firefly.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-firefly.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
@@ -36,6 +36,8 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.47.1

