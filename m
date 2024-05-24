Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE4CC25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881D6884EA;
	Fri, 24 May 2024 11:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CDD8866A; Fri, 24 May 2024 11:24:03 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D218857B
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm03N0f6gzrFT;
 Fri, 24 May 2024 11:24:00 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm03M3WJlzwvx; Fri, 24 May 2024 11:23:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 24 May 2024 11:23:33 +0200
Subject: [PATCH next v2 8/8] rockchip: px30/rk3326: migrate to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240524-px30-of_upstream-v2-8-fdc7887097a2@cherry.de>
References: <20240524-px30-of_upstream-v2-0-fdc7887097a2@cherry.de>
In-Reply-To: <20240524-px30-of_upstream-v2-0-fdc7887097a2@cherry.de>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

Migrate PX30/RK3326 boards that exists in Linux v6.8 to use OF_UPSTREAM.

firefly-px30 is not migrated to OF_UPSTREAM because there's no Device
Tree in the Linux kernel.

Differences between U-Boot's Odroid-Go2 and Linux's are now moved to the
-u-boot.dtsi, though I have a gut feeling that the existing cru
overrides aren't necessary (anymore?).

The U-Boot GPIO led-0 is on GPIO0_C1 but such is the pin of PWM3 which
is used for Linux's PWM led-2 so keep Linux's.

I also doubt vcc_cam is actually used, though the Odroid-Go2 Black
Edition uses this dcdc regulator for WiFi, so let's just move it to the
-u-boot.dtsi to play it safe.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/Makefile                              |   8 -
 arch/arm/dts/px30-engicam-common.dtsi              | 129 -----
 arch/arm/dts/px30-engicam-ctouch2.dtsi             |  30 -
 arch/arm/dts/px30-engicam-edimm2.2.dtsi            |  66 ---
 .../dts/px30-engicam-px30-core-ctouch2-of10.dts    |  77 ---
 arch/arm/dts/px30-engicam-px30-core-ctouch2.dts    |  22 -
 arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts   |  43 --
 arch/arm/dts/px30-engicam-px30-core.dtsi           | 241 --------
 arch/arm/dts/px30-evb.dts                          | 634 --------------------
 arch/arm/dts/px30-ringneck-haikou.dts              | 232 --------
 arch/arm/dts/px30-ringneck.dtsi                    | 382 ------------
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi         |  15 +
 arch/arm/dts/rk3326-odroid-go2.dts                 | 642 ---------------------
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 configs/evb-px30_defconfig                         |   2 +-
 configs/firefly-px30_defconfig                     |   1 +
 configs/odroid-go2_defconfig                       |   2 +-
 configs/px30-core-ctouch2-of10-px30_defconfig      |   2 +-
 configs/px30-core-ctouch2-px30_defconfig           |   2 +-
 configs/px30-core-edimm2.2-px30_defconfig          |   2 +-
 configs/ringneck-px30_defconfig                    |   2 +-
 21 files changed, 23 insertions(+), 2512 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index f7032f1e175..198bc41223d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -53,14 +53,6 @@ dtb-$(CONFIG_MACH_S900) += \
 dtb-$(CONFIG_MACH_S700) += \
 	s700-cubieboard7.dtb
 
-dtb-$(CONFIG_ROCKCHIP_PX30) += \
-	px30-evb.dtb \
-	px30-firefly.dtb \
-	px30-engicam-px30-core-ctouch2.dtb \
-	px30-engicam-px30-core-ctouch2-of10.dtb \
-	px30-engicam-px30-core-edimm2.2.dtb \
-	rk3326-odroid-go2.dtb
-
 dtb-$(CONFIG_ROCKCHIP_RK3036) += \
 	rk3036-sdk.dtb
 
diff --git a/arch/arm/dts/px30-engicam-common.dtsi b/arch/arm/dts/px30-engicam-common.dtsi
deleted file mode 100644
index 3429e124d95..00000000000
--- a/arch/arm/dts/px30-engicam-common.dtsi
+++ /dev/null
@@ -1,129 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/ {
-	aliases {
-		mmc1 = &sdmmc;
-		mmc2 = &sdio;
-	};
-
-	vcc5v0_sys: vcc5v0-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";	/* +5V */
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		clocks = <&xin32k>;
-		clock-names = "ext_clock";
-		post-power-on-delay-ms = <80>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_enable_h>;
-	};
-
-	vcc3v3_btreg: vcc3v3-btreg {
-		compatible = "regulator-gpio";
-		enable-active-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_enable_h>;
-		regulator-name = "btreg-gpio-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		states = <3300000 0x0>;
-	};
-
-	vcc3v3_rf_aux_mod: vcc3v3-rf-aux-mod {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_rf_aux_mod";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	xin32k: xin32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-	};
-};
-
-&sdio {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	bus-width = <4>;
-	clock-frequency = <50000000>;
-	cap-sdio-irq;
-	cap-sd-highspeed;
-	keep-power-in-suspend;
-	mmc-pwrseq = <&sdio_pwrseq>;
-	non-removable;
-	sd-uhs-sdr104;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-	};
-};
-
-&gmac {
-	clock_in_out = "output";
-	phy-supply = <&vcc_3v3>;	/* +3V3_SOM */
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 50000 50000>;
-	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&sdmmc {
-	cap-sd-highspeed;
-	card-detect-delay = <800>;
-	vmmc-supply = <&vcc_3v3>;	/* +3V3_SOM */
-	vqmmc-supply = <&vcc_3v3>;
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-
-	u2phy_host: host-port {
-		status = "okay";
-	};
-
-	u2phy_otg: otg-port {
-		status = "okay";
-	};
-};
-
-&uart2 {
-	pinctrl-0 = <&uart2m1_xfer>;
-	status = "okay";
-};
-
-&usb20_otg {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
diff --git a/arch/arm/dts/px30-engicam-ctouch2.dtsi b/arch/arm/dts/px30-engicam-ctouch2.dtsi
deleted file mode 100644
index bf10a3d29fc..00000000000
--- a/arch/arm/dts/px30-engicam-ctouch2.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-#include "px30-engicam-common.dtsi"
-
-&pinctrl {
-	bt {
-		bt_enable_h: bt-enable-h {
-			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdio-pwrseq {
-		wifi_enable_h: wifi-enable-h {
-			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&sdio_pwrseq {
-	reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
-};
-
-&vcc3v3_btreg {
-	enable-gpio = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
-};
diff --git a/arch/arm/dts/px30-engicam-edimm2.2.dtsi b/arch/arm/dts/px30-engicam-edimm2.2.dtsi
deleted file mode 100644
index 449b8eb6454..00000000000
--- a/arch/arm/dts/px30-engicam-edimm2.2.dtsi
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-#include "px30-engicam-common.dtsi"
-
-/ {
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 25000 0>;
-	};
-
-	panel {
-		compatible = "yes-optoelectronics,ytc700tlag-05-201c";
-		backlight = <&backlight>;
-		data-mapping = "vesa-24";
-		power-supply = <&vcc3v3_lcd>;
-
-		port {
-			panel_in_lvds: endpoint {
-				remote-endpoint = <&lvds_out_panel>;
-			};
-		};
-	};
-};
-
-&display_subsystem {
-	status = "okay";
-};
-
-&dsi_dphy {
-	status = "okay";
-};
-
-/* LVDS_B(secondary) */
-&lvds {
-	status = "okay";
-
-	ports {
-		port@1 {
-			reg = <1>;
-
-			lvds_out_panel: endpoint {
-				remote-endpoint = <&panel_in_lvds>;
-			};
-		};
-	};
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
diff --git a/arch/arm/dts/px30-engicam-px30-core-ctouch2-of10.dts b/arch/arm/dts/px30-engicam-px30-core-ctouch2-of10.dts
deleted file mode 100644
index 47aa30505a4..00000000000
--- a/arch/arm/dts/px30-engicam-px30-core-ctouch2-of10.dts
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "px30.dtsi"
-#include "px30-engicam-ctouch2.dtsi"
-#include "px30-engicam-px30-core.dtsi"
-
-/ {
-	model = "Engicam PX30.Core C.TOUCH 2.0 10.1\" Open Frame";
-	compatible = "engicam,px30-core-ctouch2-of10", "engicam,px30-core",
-		     "rockchip,px30";
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 25000 0>;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	panel {
-		compatible = "ampire,am-1280800n3tzqw-t00h";
-		backlight = <&backlight>;
-		power-supply = <&vcc3v3_lcd>;
-		data-mapping = "vesa-24";
-
-		port {
-			panel_in_lvds: endpoint {
-				remote-endpoint = <&lvds_out_panel>;
-			};
-		};
-	};
-};
-
-&display_subsystem {
-	status = "okay";
-};
-
-&dsi_dphy {
-	status = "okay";
-};
-
-&lvds {
-	status = "okay";
-
-	ports {
-		port@1 {
-			reg = <1>;
-
-			lvds_out_panel: endpoint {
-				remote-endpoint = <&panel_in_lvds>;
-			};
-		};
-	};
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
diff --git a/arch/arm/dts/px30-engicam-px30-core-ctouch2.dts b/arch/arm/dts/px30-engicam-px30-core-ctouch2.dts
deleted file mode 100644
index 5a0ecb8faec..00000000000
--- a/arch/arm/dts/px30-engicam-px30-core-ctouch2.dts
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "px30.dtsi"
-#include "px30-engicam-ctouch2.dtsi"
-#include "px30-engicam-px30-core.dtsi"
-
-/ {
-	model = "Engicam PX30.Core C.TOUCH 2.0";
-	compatible = "engicam,px30-core-ctouch2", "engicam,px30-core",
-		     "rockchip,px30";
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-};
diff --git a/arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts b/arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts
deleted file mode 100644
index d759478e1c8..00000000000
--- a/arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "px30.dtsi"
-#include "px30-engicam-edimm2.2.dtsi"
-#include "px30-engicam-px30-core.dtsi"
-
-/ {
-	model = "Engicam PX30.Core EDIMM2.2 Starter Kit";
-	compatible = "engicam,px30-core-edimm2.2", "engicam,px30-core",
-		     "rockchip,px30";
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-};
-
-&pinctrl {
-	bt {
-		bt_enable_h: bt-enable-h {
-			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdio-pwrseq {
-		wifi_enable_h: wifi-enable-h {
-			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&sdio_pwrseq {
-	reset-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_LOW>;
-};
-
-&vcc3v3_btreg {
-	enable-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
-};
diff --git a/arch/arm/dts/px30-engicam-px30-core.dtsi b/arch/arm/dts/px30-engicam-px30-core.dtsi
deleted file mode 100644
index 7249871530a..00000000000
--- a/arch/arm/dts/px30-engicam-px30-core.dtsi
+++ /dev/null
@@ -1,241 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2020 Engicam srl
- * Copyright (c) 2020 Amarula Solutons
- * Copyright (c) 2020 Amarula Solutons(India)
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-
-/ {
-	compatible = "engicam,px30-core", "rockchip,px30";
-
-	aliases {
-		mmc0 = &emmc;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&emmc {
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	non-removable;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	rk809: pmic@20 {
-		compatible = "rockchip,rk809";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-		clock-output-names = "rk808-clkout1", "rk808-clkout2";
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc5-supply = <&vcc3v3_sys>;
-		vcc6-supply = <&vcc3v3_sys>;
-		vcc7-supply = <&vcc3v3_sys>;
-		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc5v0_sys>;
-
-		regulators {
-			vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vdd_arm: DCDC_REG2 {
-				regulator-name = "vdd_arm";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_3v3: DCDC_REG4 {
-				regulator-name = "vcc_3v3";
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
-			vcc3v3_sys: DCDC_REG5 {
-				regulator-name = "vcc3v3_sys";
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
-			vcc_1v0: LDO_REG1 {
-				regulator-name = "vcc_1v0";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_1v8: LDO_REG2 {
-				regulator-name = "vcc_1v8";
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
-			vdd_1v0: LDO_REG3 {
-				regulator-name = "vdd_1v0";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc3v0_pmu: LDO_REG4 {
-				regulator-name = "vcc3v0_pmu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc3v3_lcd: SWITCH_REG1 {
-				regulator-boot-on;
-				regulator-name = "vcc3v3_lcd";
-			};
-
-			vcc5v0_host: SWITCH_REG2 {
-				regulator-name = "vcc5v0_host";
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&io_domains {
-	vccio1-supply = <&vcc_3v3>;
-	vccio2-supply = <&vcc_3v3>;
-	vccio3-supply = <&vcc_3v3>;
-	vccio4-supply = <&vcc_3v3>;
-	vccio5-supply = <&vcc_3v3>;
-	vccio6-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&pinctrl {
-	pmic {
-		pmic_int: pmic_int {
-			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
-
-&pmu_io_domains {
-	pmuio1-supply = <&vcc_3v3>;
-	pmuio2-supply = <&vcc_3v3>;
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <1>;
-	rockchip,hw-tshut-polarity = <1>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/px30-evb.dts b/arch/arm/dts/px30-evb.dts
deleted file mode 100644
index 848bc39cf86..00000000000
--- a/arch/arm/dts/px30-evb.dts
+++ /dev/null
@@ -1,634 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-#include "px30.dtsi"
-
-/ {
-	model = "Rockchip PX30 EVB";
-	compatible = "rockchip,px30-evb", "rockchip,px30";
-
-	aliases {
-		mmc0 = &sdmmc;
-		mmc1 = &sdio;
-		mmc2 = &emmc;
-	};
-
-	chosen {
-		stdout-path = "serial5:115200n8";
-	};
-
-	adc-keys {
-		compatible = "adc-keys";
-		io-channels = <&saradc 2>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <1800000>;
-		poll-interval = <100>;
-
-		esc-key {
-			label = "esc";
-			linux,code = <KEY_ESC>;
-			press-threshold-microvolt = <1310000>;
-		};
-
-		home-key {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			press-threshold-microvolt = <624000>;
-		};
-
-		menu-key {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			press-threshold-microvolt = <987000>;
-		};
-
-		vol-down-key {
-			label = "volume down";
-			linux,code = <KEY_VOLUMEDOWN>;
-			press-threshold-microvolt = <300000>;
-		};
-
-		vol-up-key {
-			label = "volume up";
-			linux,code = <KEY_VOLUMEUP>;
-			press-threshold-microvolt = <17000>;
-		};
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 25000 0>;
-		power-supply = <&vcc3v3_lcd>;
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		pinctrl-0 = <&emmc_reset>;
-		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
-	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_enable_h>;
-
-		/*
-		 * On the module itself this is one of these (depending
-		 * on the actual card populated):
-		 * - SDIO_RESET_L_WL_REG_ON
-		 * - PDN (power down when low)
-		 */
-		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
-	};
-
-	vcc5v0_sys: vccsys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&csi_dphy {
-	status = "okay";
-};
-
-&display_subsystem {
-	status = "okay";
-};
-
-&dsi {
-	status = "okay";
-
-	ports {
-		mipi_out: port@1 {
-			reg = <1>;
-
-			mipi_out_panel: endpoint {
-				remote-endpoint = <&mipi_in_panel>;
-			};
-		};
-	};
-
-	panel@0 {
-		compatible = "xinpeng,xpp055c272";
-		reg = <0>;
-		backlight = <&backlight>;
-		iovcc-supply = <&vcc_1v8>;
-		vci-supply = <&vcc3v3_lcd>;
-
-		port {
-			mipi_in_panel: endpoint {
-				remote-endpoint = <&mipi_out_panel>;
-			};
-		};
-	};
-};
-
-&dsi_dphy {
-	status = "okay";
-};
-
-&emmc {
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	non-removable;
-	mmc-pwrseq = <&emmc_pwrseq>;
-	vmmc-supply = <&vcc_3v0>;
-	vqmmc-supply = <&vccio_flash>;
-	status = "okay";
-};
-
-&gmac {
-	clock_in_out = "output";
-	phy-supply = <&vcc_rmii>;
-	snps,reset-gpio = <&gpio2 13 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 50000 50000>;
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_log>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	rk809: pmic@20 {
-		compatible = "rockchip,rk809";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <0>;
-		clock-output-names = "xin32k";
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc5-supply = <&vcc3v3_sys>;
-		vcc6-supply = <&vcc3v3_sys>;
-		vcc7-supply = <&vcc3v3_sys>;
-		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc5v0_sys>;
-
-		regulators {
-			vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vdd_arm: DCDC_REG2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_3v0: vcc_rmii: DCDC_REG4 {
-				regulator-name = "vcc_3v0";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			vcc3v3_sys: DCDC_REG5 {
-				regulator-name = "vcc3v3_sys";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_1v0: LDO_REG1 {
-				regulator-name = "vcc_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_1v8: vccio_flash: vccio_sdio: LDO_REG2 {
-				regulator-name = "vcc_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vdd_1v0: LDO_REG3 {
-				regulator-name = "vdd_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc3v0_pmu: LDO_REG4 {
-				regulator-name = "vcc3v0_pmu";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_sd: LDO_REG6 {
-				regulator-name = "vcc_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc2v8_dvp: LDO_REG7 {
-				regulator-name = "vcc2v8_dvp";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <2800000>;
-				};
-			};
-
-			vcc1v8_dvp: LDO_REG8 {
-				regulator-name = "vcc1v8_dvp";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc1v5_dvp: LDO_REG9 {
-				regulator-name = "vcc1v5_dvp";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1500000>;
-				};
-			};
-
-			vcc3v3_lcd: SWITCH_REG1 {
-				regulator-name = "vcc3v3_lcd";
-				regulator-boot-on;
-			};
-
-			vcc5v0_host: SWITCH_REG2 {
-				regulator-name = "vcc5v0_host";
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	sensor@d {
-		compatible = "asahi-kasei,ak8963";
-		reg = <0x0d>;
-		gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-		vdd-supply = <&vcc3v0_pmu>;
-		mount-matrix = "1", /* x0 */
-			       "0", /* y0 */
-			       "0", /* z0 */
-			       "0", /* x1 */
-			       "1", /* y1 */
-			       "0", /* z1 */
-			       "0", /* x2 */
-			       "0", /* y2 */
-			       "1"; /* z2 */
-	};
-
-	touchscreen@14 {
-		compatible = "goodix,gt1151";
-		reg = <0x14>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
-		irq-gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
-		VDDIO-supply = <&vcc3v3_lcd>;
-	};
-
-	sensor@4c {
-		compatible = "fsl,mma7660";
-		reg = <0x4c>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PB7 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	clock-frequency = <100000>;
-
-	/* These are relatively safe rise/fall times; TODO: measure */
-	i2c-scl-falling-time-ns = <50>;
-	i2c-scl-rising-time-ns = <300>;
-
-	ov5695: ov5695@36 {
-		compatible = "ovti,ov5695";
-		reg = <0x36>;
-		avdd-supply = <&vcc2v8_dvp>;
-		clocks = <&cru SCLK_CIF_OUT>;
-		clock-names = "xvclk";
-		dvdd-supply = <&vcc1v5_dvp>;
-		dovdd-supply = <&vcc1v8_dvp>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cif_clkout_m0>;
-		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
-
-		port {
-			ucam_out: endpoint {
-				remote-endpoint = <&mipi_in_ucam>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
-
-&i2s1_2ch {
-	status = "okay";
-};
-
-&io_domains {
-	status = "okay";
-
-	vccio1-supply = <&vccio_sdio>;
-	vccio2-supply = <&vccio_sd>;
-	vccio3-supply = <&vcc_3v0>;
-	vccio4-supply = <&vcc3v0_pmu>;
-	vccio5-supply = <&vcc_3v0>;
-	vccio6-supply = <&vccio_flash>;
-};
-
-&isp {
-	status = "okay";
-
-	ports {
-		port@0 {
-			mipi_in_ucam: endpoint@0 {
-				reg = <0>;
-				data-lanes = <1 2>;
-				remote-endpoint = <&ucam_out>;
-			};
-		};
-	};
-};
-
-&isp_mmu {
-	status = "okay";
-};
-
-&pinctrl {
-	headphone {
-		hp_det: hp-det {
-			rockchip,pins =
-				<2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
-	emmc {
-		emmc_reset: emmc-reset {
-			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic_int {
-			rockchip,pins =
-				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		soc_slppin_gpio: soc_slppin_gpio {
-			rockchip,pins =
-				<0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		soc_slppin_slp: soc_slppin_slp {
-			rockchip,pins =
-				<0 RK_PA4 1 &pcfg_pull_none>;
-		};
-
-		soc_slppin_rst: soc_slppin_rst {
-			rockchip,pins =
-				<0 RK_PA4 2 &pcfg_pull_none>;
-		};
-	};
-
-	sdio-pwrseq {
-		wifi_enable_h: wifi-enable-h {
-			rockchip,pins =
-				<0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pmu_io_domains {
-	status = "okay";
-
-	pmuio1-supply = <&vcc3v0_pmu>;
-	pmuio2-supply = <&vcc3v0_pmu>;
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdmmc {
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <800>;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&sdio {
-	cap-sd-highspeed;
-	keep-power-in-suspend;
-	non-removable;
-	mmc-pwrseq = <&sdio_pwrseq>;
-	sd-uhs-sdr104;
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <1>;
-	rockchip,hw-tshut-polarity = <1>;
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-
-	u2phy_host: host-port {
-		status = "okay";
-	};
-
-	u2phy_otg: otg-port {
-		status = "okay";
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_xfer &uart1_cts>;
-	status = "okay";
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&usb20_otg {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
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
diff --git a/arch/arm/dts/px30-ringneck-haikou.dts b/arch/arm/dts/px30-ringneck-haikou.dts
deleted file mode 100644
index 08a3ad3e7ae..00000000000
--- a/arch/arm/dts/px30-ringneck-haikou.dts
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
- */
-
-/dts-v1/;
-#include "px30-ringneck.dtsi"
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-
-/ {
-	model = "Theobroma Systems PX30-uQ7 SoM on Haikou devkit";
-	compatible = "tsd,px30-ringneck-haikou", "rockchip,px30";
-
-	aliases {
-		mmc2 = &sdmmc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-0 = <&haikou_keys_pin>;
-		pinctrl-names = "default";
-
-		button-batlow-n {
-			label = "BATLOW#";
-			linux,code = <KEY_BATTERY>;
-			gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
-		};
-
-		button-slp-btn-n {
-			label = "SLP_BTN#";
-			linux,code = <KEY_SLEEP>;
-			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
-		};
-
-		button-wake-n {
-			label = "WAKE#";
-			linux,code = <KEY_WAKEUP>;
-			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-		};
-
-		switch-lid-btn-n {
-			label = "LID_BTN#";
-			linux,code = <SW_LID>;
-			linux,input-type = <EV_SW>;
-			gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	leds {
-		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
-
-		sd_card_led: led-1 {
-			gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc2";
-			function = LED_FUNCTION_SD;
-			color = <LED_COLOR_ID_BLUE>;
-		};
-	};
-
-	i2s0-sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,name = "Haikou,I2S-codec";
-		simple-audio-card,mclk-fs = <512>;
-
-		simple-audio-card,codec {
-			clocks = <&sgtl5000_clk>;
-			sound-dai = <&sgtl5000>;
-		};
-
-		simple-audio-card,cpu {
-			bitclock-master;
-			frame-master;
-			sound-dai = <&i2s0_8ch>;
-		};
-	};
-
-	sgtl5000_clk: sgtl5000-oscillator {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency  = <24576000>;
-	};
-
-	dc_12v: dc-12v-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
-	vcc3v3_baseboard: vcc3v3-baseboard-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_baseboard";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_baseboard";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
-	};
-
-	vdda_codec: vdda-codec-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vdda_codec";
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc5v0_baseboard>;
-	};
-
-	vddd_codec: vddd-codec-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vddd_codec";
-		regulator-boot-on;
-		regulator-min-microvolt = <1600000>;
-		regulator-max-microvolt = <1600000>;
-		vin-supply = <&vcc5v0_baseboard>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	sgtl5000: codec@a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-		clocks = <&sgtl5000_clk>;
-		#sound-dai-cells = <0>;
-		VDDA-supply = <&vdda_codec>;
-		VDDIO-supply = <&vcc3v3_baseboard>;
-		VDDD-supply = <&vddd_codec>;
-	};
-};
-
-&i2c3 {
-	eeprom@50 {
-		reg = <0x50>;
-		compatible = "atmel,24c01";
-		pagesize = <8>;
-		size = <128>;
-		vcc-supply = <&vcc3v3_baseboard>;
-	};
-};
-
-&i2s0_8ch {
-	status = "okay";
-};
-
-&gmac {
-	status = "okay";
-};
-
-&pinctrl {
-	haikou {
-		haikou_keys_pin: haikou-keys-pin {
-			rockchip,pins =
-			  /* WAKE# */
-			  <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
-			  /* SLP_BTN# */
-			  <1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
-			  /* LID_BTN */
-			  <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
-			  /* BATLOW# */
-			  <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
-			  /* BIOS_DISABLE# */
-			  <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	leds {
-		sd_card_led_pin: sd-card-led-pin {
-			rockchip,pins =
-			  <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&sdmmc {
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	vmmc-supply = <&vcc3v3_baseboard>;
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-};
-
-&u2phy_otg {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-0 = <&uart5_xfer>;
-	status = "okay";
-};
-
-&usb20_otg {
-	status = "okay";
-};
diff --git a/arch/arm/dts/px30-ringneck.dtsi b/arch/arm/dts/px30-ringneck.dtsi
deleted file mode 100644
index 12397755830..00000000000
--- a/arch/arm/dts/px30-ringneck.dtsi
+++ /dev/null
@@ -1,382 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2022 Theobroma Systems Design und Consulting GmbH
- */
-
-/dts-v1/;
-#include "px30.dtsi"
-#include <dt-bindings/leds/common.h>
-
-/ {
-	aliases {
-		mmc0 = &emmc;
-		mmc1 = &sdio;
-		rtc0 = &rtc_twi;
-		rtc1 = &rk809;
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		pinctrl-0 = <&emmc_reset>;
-		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&module_led_pin>;
-		status = "okay";
-
-		module_led: led-0 {
-			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
-			function = LED_FUNCTION_HEARTBEAT;
-			linux,default-trigger = "heartbeat";
-			color = <LED_COLOR_ID_AMBER>;
-		};
-	};
-
-	vcc5v0_sys: vccsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	supports-emmc;
-	mmc-pwrseq = <&emmc_pwrseq>;
-	non-removable;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vcc_emmc>;
-
-	status = "okay";
-};
-
-/* On-module TI DP83825I PHY but no connector, enable in carrierboard */
-&gmac {
-	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 50000 50000>;
-	phy-supply = <&vcc_3v3>;
-	clock_in_out = "output";
-};
-
-&gpio2 {
-	/*
-	 * The Qseven BIOS_DISABLE signal on the PX30-µQ7 keeps the on-module
-	 * eMMC powered-down initially (in fact it keeps the reset signal
-	 * asserted). BIOS_DISABLE_OVERRIDE pin allows to re-enable eMMC after
-	 * the SPL has been booted from SD Card.
-	 */
-	bios-disable-override-hog {
-		gpios = <RK_PB5 GPIO_ACTIVE_LOW>;
-		output-high;
-		line-name = "bios_disable_override";
-		gpio-hog;
-	};
-
-	/*
-	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
-	 * signal, ignoring the BIOS_DISABLE_OVERRIDE logic. This usually
-	 * represents the state of a switch on the baseboard.
-	 */
-	bios-disable-n-hog {
-		gpios = <RK_PC2 GPIO_ACTIVE_LOW>;
-		line-name = "bios_disable";
-		input;
-		gpio-hog;
-	};
-};
-
-&gpu {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	rk809: pmic@20 {
-		compatible = "rockchip,rk809";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-0 = <&pmic_int>;
-		pinctrl-names = "default";
-		#clock-cells = <0>;
-		clock-output-names = "xin32k";
-		rockchip,system-power-controller;
-		wakeup-source;
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc5-supply = <&vcc_3v3>;
-		vcc6-supply = <&vcc_3v3>;
-		vcc7-supply = <&vcc_3v3>;
-		vcc9-supply = <&vcc5v0_sys>;
-
-		regulators {
-			vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vdd_arm: DCDC_REG2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_3v0_1v8: vcc_emmc: DCDC_REG4 {
-				regulator-name = "vcc_3v0_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			vcc_3v3: DCDC_REG5 {
-				regulator-name = "vcc_3v3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_1v8: LDO_REG2 {
-				regulator-name = "vcc_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc_1v0: LDO_REG3 {
-				regulator-name = "vcc_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_lcd: LDO_REG7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vcc_lcd";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_1v8_lcd: LDO_REG8 {
-				regulator-name = "vcc_1v8_lcd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcca_1v8: LDO_REG9 {
-				regulator-name = "vcca_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	/* SE05x is limited to Fast Mode */
-	clock-frequency = <400000>;
-
-	fan: fan@18 {
-		compatible = "ti,amc6821";
-		reg = <0x18>;
-		#cooling-cells = <2>;
-	};
-
-	rtc_twi: rtc@6f {
-		compatible = "isil,isl1208";
-		reg = <0x6f>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2s0_8ch {
-	rockchip,trcm-sync-tx-only;
-
-	pinctrl-0 = <&i2s0_8ch_sclktx &i2s0_8ch_lrcktx
-		     &i2s0_8ch_sdo0 &i2s0_8ch_sdi0>;
-};
-
-&io_domains {
-	vccio1-supply = <&vcc_3v3>;
-	vccio2-supply = <&vccio_sd>;
-	vccio3-supply = <&vcc_3v3>;
-	vccio4-supply = <&vcc_3v3>;
-	vccio5-supply = <&vcc_3v3>;
-	vccio6-supply = <&vcc_emmc>;
-	vccio-oscgpi-supply = <&vcc_3v3>;
-
-	status = "okay";
-};
-
-&pinctrl {
-	emmc {
-		emmc_reset: emmc-reset {
-			rockchip,pins = <1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	leds {
-		module_led_pin: module-led-pin {
-			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins =
-				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
-
-&saradc {
-	vref-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdmmc {
-	vqmmc-supply = <&vccio_sd>;
-};
-
-&tsadc {
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-};
-
-&u2phy_host {
-	status = "okay";
-};
-
-/* Mule UCAN */
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 04028bf649f..a31dea8db3e 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -74,6 +74,21 @@
 	bootph-all;
 };
 
+&rk817 {
+	regulators {
+		vcc_cam: LDO_REG9 {
+			regulator-name = "vcc_cam";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-suspend-microvolt = <3000000>;
+			};
+		};
+	};
+};
+
 &saradc {
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm/dts/rk3326-odroid-go2.dts b/arch/arm/dts/rk3326-odroid-go2.dts
deleted file mode 100644
index ea0695b51ec..00000000000
--- a/arch/arm/dts/rk3326-odroid-go2.dts
+++ /dev/null
@@ -1,642 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Hardkernel Co., Ltd
- * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
- */
-
-/dts-v1/;
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-#include "rk3326.dtsi"
-
-/ {
-	model = "ODROID-GO Advance";
-	compatible = "hardkernel,rk3326-odroid-go2", "rockchip,rk3326";
-
-	aliases {
-		mmc0 = &sdmmc;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	adc-joystick {
-		compatible = "adc-joystick";
-		io-channels = <&saradc 1>,
-			      <&saradc 2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		axis@0 {
-			reg = <0>;
-			abs-flat = <10>;
-			abs-fuzz = <10>;
-			abs-range = <172 772>;
-			linux,code = <ABS_X>;
-		};
-
-		axis@1 {
-			reg = <1>;
-			abs-flat = <10>;
-			abs-fuzz = <10>;
-			abs-range = <278 815>;
-			linux,code = <ABS_Y>;
-		};
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		power-supply = <&vcc_bl>;
-		pwms = <&pwm1 0 25000 0>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&btn_pins>;
-
-		/*
-		 *      *** ODROIDGO2-Advance Switch layout ***
-		 * |------------------------------------------------|
-		 * | sw15                                      sw16 |
-		 * |------------------------------------------------|
-		 * |     sw1      |-------------------|      sw8    |
-		 * |  sw3   sw4   |                   |   sw7   sw5 |
-		 * |     sw2      |    LCD Display    |      sw6    |
-		 * |              |                   |             |
-		 * |              |-------------------|             |
-		 * |         sw9 sw10   sw11 sw12   sw13 sw14       |
-		 * |------------------------------------------------|
-		 */
-
-		sw1 {
-			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
-			label = "DPAD-UP";
-			linux,code = <BTN_DPAD_UP>;
-		};
-		sw2 {
-			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
-			label = "DPAD-DOWN";
-			linux,code = <BTN_DPAD_DOWN>;
-		};
-		sw3 {
-			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
-			label = "DPAD-LEFT";
-			linux,code = <BTN_DPAD_LEFT>;
-		};
-		sw4 {
-			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
-			label = "DPAD-RIGHT";
-			linux,code = <BTN_DPAD_RIGHT>;
-		};
-		sw5 {
-			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
-			label = "BTN-A";
-			linux,code = <BTN_EAST>;
-		};
-		sw6 {
-			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
-			label = "BTN-B";
-			linux,code = <BTN_SOUTH>;
-		};
-		sw7 {
-			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
-			label = "BTN-Y";
-			linux,code = <BTN_WEST>;
-		};
-		sw8 {
-			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
-			label = "BTN-X";
-			linux,code = <BTN_NORTH>;
-		};
-		sw9 {
-			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
-			label = "F1";
-			linux,code = <BTN_TRIGGER_HAPPY1>;
-		};
-		sw10 {
-			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
-			label = "F2";
-			linux,code = <BTN_TRIGGER_HAPPY2>;
-		};
-		sw11 {
-			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
-			label = "F3";
-			linux,code = <BTN_TRIGGER_HAPPY3>;
-		};
-		sw12 {
-			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
-			label = "F4";
-			linux,code = <BTN_TRIGGER_HAPPY4>;
-		};
-		sw13 {
-			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
-			label = "F5";
-			linux,code = <BTN_TRIGGER_HAPPY5>;
-		};
-		sw14 {
-			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
-			label = "F6";
-			linux,code = <BTN_TRIGGER_HAPPY6>;
-		};
-		sw15 {
-			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
-			label = "TOP-LEFT";
-			linux,code = <BTN_TL>;
-		};
-		sw16 {
-			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
-			label = "TOP-RIGHT";
-			linux,code = <BTN_TR>;
-		};
-	};
-
-	leds: gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&blue_led_pin>;
-
-		blue_led: led-0 {
-			label = "blue:heartbeat";
-			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	rk817-sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "Analog";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,hp-det-gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
-		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,widgets =
-			"Microphone", "Mic Jack",
-			"Headphone", "Headphones",
-			"Speaker", "Speaker";
-		simple-audio-card,routing =
-			"MICL", "Mic Jack",
-			"Headphones", "HPOL",
-			"Headphones", "HPOR",
-			"Speaker", "SPKO";
-
-		simple-audio-card,codec {
-			sound-dai = <&rk817>;
-		};
-
-		simple-audio-card,cpu {
-			sound-dai = <&i2s1_2ch>;
-		};
-	};
-
-	vccsys: vccsys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v8_sys";
-		regulator-always-on;
-		regulator-min-microvolt = <3800000>;
-		regulator-max-microvolt = <3800000>;
-	};
-
-	vcc_host: vcc_host {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_host";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-
-		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&usb_midu>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cru {
-	assigned-clocks = <&cru PLL_NPLL>,
-		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
-		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
-		<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>,
-		<&cru PLL_CPLL>;
-
-	assigned-clock-rates = <1188000000>,
-		<200000000>, <200000000>,
-		<150000000>, <150000000>,
-		<100000000>, <200000000>,
-		<17000000>;
-};
-
-&display_subsystem {
-	status = "okay";
-};
-
-&dsi {
-	status = "okay";
-
-	ports {
-		mipi_out: port@1 {
-			reg = <1>;
-
-			mipi_out_panel: endpoint {
-				remote-endpoint = <&mipi_in_panel>;
-			};
-		};
-	};
-
-	panel@0 {
-		compatible = "elida,kd35t133";
-		reg = <0>;
-		backlight = <&backlight>;
-		iovcc-supply = <&vcc_lcd>;
-		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
-		rotation = <270>;
-		vdd-supply = <&vcc_lcd>;
-
-		port {
-			mipi_in_panel: endpoint {
-				remote-endpoint = <&mipi_out_panel>;
-			};
-		};
-	};
-};
-
-&dsi_dphy {
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_logic>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <16>;
-	i2c-scl-rising-time-ns = <280>;
-	status = "okay";
-
-	rk817: pmic@20 {
-		compatible = "rockchip,rk817";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
-		clock-output-names = "rk808-clkout1", "xin32k";
-		clock-names = "mclk";
-		clocks = <&cru SCLK_I2S1_OUT>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>, <&i2s1_2ch_mclk>;
-		wakeup-source;
-		#clock-cells = <1>;
-		#sound-dai-cells = <0>;
-
-		vcc1-supply = <&vccsys>;
-		vcc2-supply = <&vccsys>;
-		vcc3-supply = <&vccsys>;
-		vcc4-supply = <&vccsys>;
-		vcc5-supply = <&vccsys>;
-		vcc6-supply = <&vccsys>;
-		vcc7-supply = <&vccsys>;
-		vcc8-supply = <&vccsys>;
-
-		regulators {
-			vdd_logic: DCDC_REG1 {
-				regulator-name = "vdd_logic";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vdd_arm: DCDC_REG2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_3v3: DCDC_REG4 {
-				regulator-name = "vcc_3v3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_1v8: LDO_REG2 {
-				regulator-name = "vcc_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vdd_1v0: LDO_REG3 {
-				regulator-name = "vdd_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc3v3_pmu: LDO_REG4 {
-				regulator-name = "vcc3v3_pmu";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_sd: LDO_REG6 {
-				regulator-name = "vcc_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_bl: LDO_REG7 {
-				regulator-name = "vcc_bl";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_lcd: LDO_REG8 {
-				regulator-name = "vcc_lcd";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <2800000>;
-				};
-			};
-
-			vcc_cam: LDO_REG9 {
-				regulator-name = "vcc_cam";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			usb_midu: BOOST {
-				regulator-name = "usb_midu";
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5400000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-
-		rk817_codec: codec {
-			rockchip,mic-in-differential;
-		};
-	};
-};
-
-/* EXT Header(P2): 7(SCL:GPIO0.C2), 8(SDA:GPIO0.C3) */
-&i2c1 {
-	clock-frequency = <400000>;
-	status = "okay";
-};
-
-/* I2S 1 Channel Used */
-&i2s1_2ch {
-	status = "okay";
-};
-
-&io_domains {
-	vccio1-supply = <&vcc_3v3>;
-	vccio2-supply = <&vccio_sd>;
-	vccio3-supply = <&vcc_3v3>;
-	vccio4-supply = <&vcc_3v3>;
-	vccio5-supply = <&vcc_3v3>;
-	vccio6-supply = <&vcc_3v3>;
-	status = "okay";
-};
-
-&pmu_io_domains {
-	pmuio1-supply = <&vcc3v3_pmu>;
-	pmuio2-supply = <&vcc3v3_pmu>;
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdmmc {
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&sfc {
-	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
-	pinctrl-names = "default";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <108000000>;
-		spi-rx-bus-width = <2>;
-		spi-tx-bus-width = <1>;
-	};
-};
-
-&tsadc {
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-
-	u2phy_host: host-port {
-		status = "okay";
-	};
-
-	u2phy_otg: otg-port {
-		status = "disabled";
-	};
-};
-
-&usb20_otg {
-	status = "okay";
-};
-
-/* EXT Header(P2): 2(RXD:GPIO1.C0),3(TXD:.C1),4(CTS:.C2),5(RTS:.C3) */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_xfer &uart1_cts>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2m1_xfer>;
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
-&pinctrl {
-	btns {
-		btn_pins: btn-pins {
-			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	headphone {
-		hp_det: hp-det {
-			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
-	leds {
-		blue_led_pin: blue-led-pin {
-			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dc_det: dc-det {
-			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		soc_slppin_gpio: soc_slppin_gpio {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		soc_slppin_rst: soc_slppin_rst {
-			rockchip,pins = <0 RK_PA4 2 &pcfg_pull_none>;
-		};
-
-		soc_slppin_slp: soc_slppin_slp {
-			rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
-		};
-	};
-};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ec3697f3582..5399c9ad417 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -3,6 +3,7 @@ if ARCH_ROCKCHIP
 config ROCKCHIP_PX30
 	bool "Support Rockchip PX30"
 	select ARM64
+	imply OF_UPSTREAM
 	select SUPPORT_SPL
 	select SUPPORT_TPL
 	select SPL
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index abe545625a5..488a259e268 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="px30-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 063e4211fb7..3fe1dc3ab10 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index f4c9b02e12f..a9af4151014 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x4000
-CONFIG_DEFAULT_DEVICE_TREE="rk3326-odroid-go2"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index dd005f20ff8..fdcbd8a0fc0 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-ctouch2-of10"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-ctouch2-of10"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index f6559fbae3a..343fd0bf516 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-ctouch2"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-ctouch2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index a099e9378c9..aa0bff4667d 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-edimm2.2"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-engicam-px30-core-edimm2.2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 94179dca3ae..dedf35d4347 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_DEFAULT_DEVICE_TREE="px30-ringneck-haikou"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/px30-ringneck-haikou"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 # CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set

-- 
2.45.1

