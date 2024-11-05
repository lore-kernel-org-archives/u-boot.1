Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8735CD3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89121891EA;
	Tue,  5 Nov 2024 22:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RZmd+HoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C258917B; Tue,  5 Nov 2024 22:53:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97B989204
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843573; bh=wEYYib8jensrQnEGOe8rHXhhhujwu7Baz2nMyZmY0hQ=;
 b=RZmd+HoINcrs5cJ+m1xcbu4gTwXcxmSIn54XzhlGTsT6yUBUJy8OeuZrUbq6xBYYqRPym8DtC
 bsMuCG3ea9i2NFitEwEnaeVXALv+saL06QWcivnmcUH9kuZVOiakJ/BJ/sgJMvjnnPoL7muYWr6
 CAvri4XcI4ZUqp9JdQ+p+SrKY/YV7zhmp77ESWZipbKNtj0M1k9D2/T9JjGw3ndDyecxwbPbf1d
 8dYip5Br83h0MBw6sFHAotqGYB02C0RGW7Scrfeg74FdN0DmF5MA43lP21WqrUomd4URFjYYGh/
 24wRvXL5V/KmxxbxiCyRojU/Y9rAcjPp1VDWiKhKxK9w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 09/11] rockchip: rk3288-miqi: Migrate to OF_UPSTREAM
Date: Tue,  5 Nov 2024 21:51:45 +0000
Message-ID: <20241105215202.1491441-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105215202.1491441-1-jonas@kwiboo.se>
References: <20241105215202.1491441-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a93b1059db14dd83d7b9c
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

The device tree for mqmaker MiQi in dts/upstream can be used as-is by
U-Boot, migrate board to OF_UPSTREAM.

The change to use DT from dts/upstream will include minor changes and
fixes related to work led and usb otg.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile                 |   1 -
 arch/arm/dts/rk3288-miqi.dts          |  16 -
 arch/arm/dts/rk3288-miqi.dtsi         | 417 --------------------------
 board/mqmaker/miqi_rk3288/MAINTAINERS |   1 -
 configs/miqi-rk3288_defconfig         |   6 +-
 5 files changed, 4 insertions(+), 437 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-miqi.dts
 delete mode 100644 arch/arm/dts/rk3288-miqi.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 40f2f768fc69..b38f35bf248a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -70,7 +70,6 @@ dtb-$(CONFIG_ROCKCHIP_RK322X) += \
 dtb-$(CONFIG_ROCKCHIP_RK3288) += \
 	rk3288-evb.dtb \
 	rk3288-firefly.dtb \
-	rk3288-miqi.dtb \
 	rk3288-popmetal.dtb \
 	rk3288-rock2-square.dtb \
 	rk3288-rock-pi-n8.dtb \
diff --git a/arch/arm/dts/rk3288-miqi.dts b/arch/arm/dts/rk3288-miqi.dts
deleted file mode 100644
index 4a2f249e1b1f..000000000000
--- a/arch/arm/dts/rk3288-miqi.dts
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-#include "rk3288-miqi.dtsi"
-
-/ {
-	model = "mqmaker MiQi";
-	compatible = "mqmaker,miqi", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-};
diff --git a/arch/arm/dts/rk3288-miqi.dtsi b/arch/arm/dts/rk3288-miqi.dtsi
deleted file mode 100644
index c56e1109e3ac..000000000000
--- a/arch/arm/dts/rk3288-miqi.dtsi
+++ /dev/null
@@ -1,417 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * Copyright (c) 2016 Heiko Stuebner <heiko@sntech.de>
- */
-
-#include "rk3288.dtsi"
-
-/ {
-	memory {
-		device_type = "memory";
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
-	leds {
-		compatible = "gpio-leds";
-
-		work {
-			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
-			label = "miqi:green:user";
-			linux,default-trigger = "default-on";
-			pinctrl-names = "default";
-			pinctrl-0 = <&led_ctl>;
-		};
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
-	vcc_host: usb-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc_host";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
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
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
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
-		regulator-enable-ramp-delay = <300>;
-		regulator-ramp-delay = <8000>;
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
-	};
-
-	act8846: act8846@5a {
-		compatible = "active-semi,act8846";
-		reg = <0x5a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_vsel>;
-		system-power-controller;
-
-		vp1-supply = <&vcc_sys>;
-		vp2-supply = <&vcc_sys>;
-		vp3-supply = <&vcc_sys>;
-		vp4-supply = <&vcc_sys>;
-		inl1-supply = <&vcc_sys>;
-		inl2-supply = <&vcc_sys>;
-		inl3-supply = <&vcc_20>;
-
-		regulators {
-			vcc_ddr: REG1 {
-				regulator-name = "vcc_ddr";
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
-&io_domains {
-	audio-supply = <&vcca_33>;
-	flash0-supply = <&vcc_flash>;
-	flash1-supply = <&vcc_lan>;
-	gpio30-supply = <&vcc_io>;
-	gpio1830-supply = <&vcc_io>;
-	lcdc-supply = <&vcc_io>;
-	sdcard-supply = <&vccio_sd>;
-	wifi-supply = <&vcc_18>;
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
-		pmic_int: pmic-int {
-			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		pmic_sleep: pmic-sleep {
-			rockchip,pins = <0 0 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		pmic_vsel: pmic-vsel {
-			rockchip,pins = <7 1 RK_FUNC_GPIO &pcfg_output_low>;
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
-	leds {
-		led_ctl: led-ctl {
-			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdmmc {
-		/*
-		 * Default drive strength isn't enough to achieve even
-		 * high-speed mode on firefly board so bump up to 12ma.
-		 */
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 17 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 18 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 19 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_12ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&saradc {
-	vref-supply = <&vcc_18>;
-	status = "okay";
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
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <0>;
-	rockchip,hw-tshut-polarity = <0>;
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
-&usbphy {
-	status = "okay";
-};
-
-&usb_host1 {
-	vbus-supply = <&vcc_host>;
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
diff --git a/board/mqmaker/miqi_rk3288/MAINTAINERS b/board/mqmaker/miqi_rk3288/MAINTAINERS
index 1cb5f790fe78..d7e55b02fe30 100644
--- a/board/mqmaker/miqi_rk3288/MAINTAINERS
+++ b/board/mqmaker/miqi_rk3288/MAINTAINERS
@@ -1,7 +1,6 @@
 MIQI
 M:	Jernej Skrabec <jernej.skrabec@siol.net>
 S:	Maintained
-F:	arch/arm/dts/rk3288-miqi.dts
 F:	arch/arm/dts/rk3288-miqi-u-boot.dtsi
 F:	board/mqmaker/miqi_rk3288
 F:	include/configs/miqi_rk3288.h
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 1643f2776801..ee9917149734 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x01000000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-miqi"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-miqi"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_MIQI_RK3288=y
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-miqi.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
@@ -35,6 +35,8 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.46.2

