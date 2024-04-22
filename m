Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E53C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94820886CF;
	Mon, 22 Apr 2024 18:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56B288860; Mon, 22 Apr 2024 18:42:02 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987188889D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VNWHT2qp8zZgW;
 Mon, 22 Apr 2024 18:41:57 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VNWHS5n9mzmCD; Mon, 22 Apr 2024 18:41:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 22 Apr 2024 18:41:42 +0200
Subject: [PATCH 2/2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-tiger-v1-2-8816b070d748@theobroma-systems.com>
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
In-Reply-To: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
connector) system-on-module from Theobroma Systems, featuring the
Rockchip RK3588.

It provides the following feature set:
 * up to 16GB LPDDR4x
 * on-module eMMC
 * SD card (on a baseboard) via edge connector
 * Gigabit Ethernet with on-module GbE PHY
 * HDMI/eDP
 * MIPI-DSI
 * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
 * HDMI input over FPC connector
 * CAN
 * USB
   - 1x USB 3.0 dual-role (direct connection)
   - 2x USB 3.0 host + 1x USB 2.0 host
 * PCIe
   - 1x PCIe 2.1 Gen3, 4 lanes
   - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
 * on-module ATtiny816 companion controller, implementing:
   - low-power RTC functionality (ISL1208 emulation)
   - fan controller (AMC6821 emulation)
  * on-module Secure Element with Global Platform 2.2.1 compliant
    JavaCard environment

The support is added for Tiger on Haikou devkit, similarly to RK3399
Puma and PX30 Ringneck.

The DTS and DTSI are taken from upstream Linux kernel v6.9-rc4.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  54 ++
 arch/arm/dts/rk3588-tiger-haikou.dts               | 266 ++++++++
 arch/arm/dts/rk3588-tiger.dtsi                     | 690 +++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  31 +
 board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +
 board/theobroma-systems/tiger_rk3588/Makefile      |  10 +
 .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++
 configs/tiger-rk3588_defconfig                     | 114 ++++
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |   1 +
 doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++
 include/configs/tiger_rk3588.h                     |  15 +
 14 files changed, 1367 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b1c9c6222e5..ef901642a0a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -180,6 +180,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-quartzpro64.dtb \
 	rk3588s-rock-5a.dtb \
 	rk3588-rock-5b.dtb \
+	rk3588-tiger-haikou.dtb \
 	rk3588-turing-rk1.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
diff --git a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
new file mode 100644
index 00000000000..4259399193a
--- /dev/null
+++ b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
+	};
+};
+
+&emmc_pwrseq {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_reset {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	/* U-Boot currently cannot handle anything below HS200 for eMMC on RK3588 */
+	/delete-property/ mmc-ddr-1_8v;
+	/delete-property/ cap-mmc-highspeed;
+};
+
+/* Q7 USB P0 */
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usbdp_phy1_u3 {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-tiger-haikou.dts b/arch/arm/dts/rk3588-tiger-haikou.dts
new file mode 100644
index 00000000000..d672198c6b6
--- /dev/null
+++ b/arch/arm/dts/rk3588-tiger-haikou.dts
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "rk3588-tiger.dtsi"
+
+/ {
+	model = "Theobroma Systems RK3588-Q7 SoM on Haikou devkit";
+	compatible = "tsd,rk3588-tiger-haikou", "tsd,rk3588-tiger", "rockchip,rk3588";
+
+	aliases {
+		ethernet0 = &gmac0;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&haikou_keys_pin>;
+
+		button-batlow-n {
+			label = "BATLOW#";
+			linux,code = <KEY_BATTERY>;
+			gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_LOW>;
+		};
+
+		button-slp-btn-n {
+			label = "SLP_BTN#";
+			linux,code = <KEY_SLEEP>;
+			gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
+		};
+
+		button-wake-n {
+			label = "WAKE#";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpio3 RK_PC6 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		switch-lid-btn-n {
+			label = "LID_BTN#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	i2s3-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Haikou,I2S-codec";
+		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
+
+		sgtl5000_codec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s3_2ch>;
+		};
+	};
+
+	sgtl5000_clk: sgtl5000-oscillator  {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	vcc3v3_baseboard: vcc3v3-baseboard-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc3v3_low_noise: vcc3v3-low-noise-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_low_noise";
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
+	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vddd_audio_1v6: vddd-audio-1v6-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vddd_audio_1v6";
+		regulator-boot-on;
+		regulator-min-microvolt = <1600000>;
+		regulator-max-microvolt = <1600000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&gmac0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	eeprom@50 {
+		reg = <0x50>;
+		compatible = "atmel,24c01";
+		pagesize = <8>;
+		size = <128>;
+		vcc-supply = <&vcc3v3_baseboard>;
+	};
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&sgtl5000_clk>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&vcc3v3_low_noise>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+		VDDD-supply = <&vddd_audio_1v6>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2s3_2ch {
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	vpcie3v3-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&pinctrl {
+	haikou {
+		haikou_keys_pin: haikou-keys-pin {
+			rockchip,pins =
+				/* BATLOW# */
+				<3 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* SLP_BTN# */
+				<4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* WAKE# */
+				<3 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* LID_BTN */
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdmmc {
+	/* while the same pin, sdmmc_det does not detect card changes */
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cmd &sdmmc_clk>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_baseboard>;
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
+	status = "okay";
+};
+
+&uart5 {
+	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+/* host0 on Q7_USB_P2, lower usb3 port */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+/* host0 on Q7_USB_P2, lower usb3 port */
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* host1 on Q7_USB_P3, usb2 port */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+/* host1 on Q7_USB_P3, usb2 port */
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* host2 on Q7_USB_P2, lower usb3 port */
+&usb_host2_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-tiger.dtsi b/arch/arm/dts/rk3588-tiger.dtsi
new file mode 100644
index 00000000000..1eb2543a5fd
--- /dev/null
+++ b/arch/arm/dts/rk3588-tiger.dtsi
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3588.dtsi"
+
+/ {
+	compatible = "tsd,rk3588-tiger", "rockchip,rk3588";
+
+	aliases {
+		mmc0 = &sdhci;
+		rtc0 = &rtc_twi;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&module_led_pin>;
+
+		/* Named LED1 on the board */
+		led-1 {
+			gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+			color = <LED_COLOR_ID_AMBER>;
+		};
+	};
+
+	/*
+	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
+	 * clock generator.
+	 * The clock output is gated via the OE pin on the clock generator.
+	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
+	 */
+	pcie_refclk_gen: pcie-refclk-gen-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000000>;
+	};
+
+	pcie_refclk: pcie-refclk-clock {
+		compatible = "gpio-gate-clock";
+		clocks = <&pcie_refclk_gen>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>; /* PCIE30X4_CLKREQN_M1_L */
+	};
+
+	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v2_s3: vcc-1v2-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v2_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc_1v2_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_rx_bus2
+		     &gmac0_tx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus
+		     &eth0_pins
+		     &eth_reset>;
+	tx_delay = <0x10>;
+	rx_delay = <0x10>;
+	snps,reset-gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 100000>;
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1m0_xfer>;
+};
+
+&i2c1m0_xfer {
+	rockchip,pins =
+		/* i2c1_scl_m0 */
+		<0 RK_PB5 9 &pcfg_pull_none_drv_level_0>,
+		/* i2c1_sda_m0 */
+		<0 RK_PB6 9 &pcfg_pull_none_drv_level_0>;
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2m3_xfer>;
+	status = "okay";
+};
+
+&i2c2m3_xfer {
+	rockchip,pins =
+		/* i2c2_scl_m3 */
+		<1 RK_PC5 9 &pcfg_pull_none_drv_level_0>,
+		/* i2c2_sda_m3 */
+		<1 RK_PC4 9 &pcfg_pull_none_drv_level_0>;
+};
+
+&i2c3 {
+	pinctrl-0 = <&i2c3m0_xfer>;
+};
+
+&i2c4 {
+	pinctrl-0 = <&i2c4m4_xfer>;
+	status = "okay";
+
+	vdd_npu_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <950000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c5 {
+	pinctrl-0 = <&i2c5m1_xfer>;
+};
+
+&i2c5m1_xfer {
+	rockchip,pins =
+		/* i2c5_scl_m1 */
+		<4 RK_PB6 9 &pcfg_pull_none_drv_level_0>,
+		/* i2c5_sda_m1 */
+		<4 RK_PB7 9 &pcfg_pull_none_drv_level_0>;
+};
+
+&i2c6 {
+	/*
+	 * Mule-ATtiny can handle up to Fast mode Plus (1MHz) on I2C bus,
+	 * but SOC can handle only up to (400kHz).
+	 */
+	clock-frequency = <400000>;
+	status = "okay";
+
+	fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	rtc_twi: rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c6m0_xfer {
+	rockchip,pins =
+		/* i2c6_scl_m0 */
+		<0 RK_PD0 9 &pcfg_pull_none_drv_level_0>,
+		/* i2c6_sda_m0 */
+		<0 RK_PC7 9 &pcfg_pull_none_drv_level_0>;
+};
+
+&i2c7 {
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c7m0_xfer {
+	rockchip,pins =
+		/* i2c7_scl_m0 */
+		<1 RK_PD0 9 &pcfg_pull_none_drv_level_0>,
+		/* i2c7_sda_m0 */
+		<1 RK_PD1 9 &pcfg_pull_none_drv_level_0>;
+};
+
+&i2c8 {
+	pinctrl-0 = <&i2c8m2_xfer>;
+};
+
+&mdio0 {
+	rgmii_phy: ethernet-phy@6 {
+		/* KSZ9031 or KSZ9131 */
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x6>;
+		clocks = <&cru REFCLKO25M_ETH0_OUT>;
+	};
+};
+
+&pcie3x4 {
+	/*
+	 * The board has a gpio-controlled "pcie_refclk" generator,
+	 * so add it to the list of clocks.
+	 */
+	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
+		 <&pcie_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
+	reset-gpios = <&gpio3 RK_PB6 GPIO_ACTIVE_HIGH>;
+};
+
+&pinctrl {
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins = <2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	ethernet {
+		eth_reset: eth-reset {
+			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		module_led_pin: module-led-pin {
+			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8_s0>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
+	supports-cqe;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <150000000>;
+	vqmmc-supply = <&vccio_sd_s0>;
+};
+
+&spi0 {
+	pinctrl-0 = <&spi0m1_cs0 &spi0m1_cs1 &spi0m3_pins>;
+};
+
+&spi2 {
+	assigned-clocks = <&cru CLK_SPI2>;
+	assigned-clock-rates = <200000000>;
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
+	status = "okay";
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		reg = <0x0>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+		spi-max-frequency = <1000000>;
+		system-power-controller;
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc5v0_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc5v0_sys>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		regulators {
+			vdd_gpu_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: dcdc-reg2 {
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log_s0: dcdc-reg3 {
+				regulator-name = "vdd_log_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <750000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: dcdc-reg4 {
+				regulator-name = "vdd_vdenc_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-name = "vdd_ddr_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-name = "vdd2_ddr_s3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-name = "vcc_2v0_pldo_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-name = "vcc_3v3_s3";
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
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-name = "vddq_ddr_s0";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-name = "vcc_1v8_s3";
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
+			vcca_1v8_s0: pldo-reg1 {
+				regulator-name = "vcca_1v8_s0";
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
+			vcc_1v8_s0: pldo-reg2 {
+				regulator-name = "vcc_1v8_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-name = "vdda_1v2_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-name = "vcca_3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-name = "vccio_sd_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pldo6_s3: pldo-reg6 {
+				regulator-name = "pldo6_s3";
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
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-name = "vdd_0v75_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdda_ddr_pll_s0: nldo-reg2 {
+				regulator-name = "vdda_ddr_pll_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdda_0v75_s0: nldo-reg3 {
+				regulator-name = "vdda_0v75_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v85_s0: nldo-reg4 {
+				regulator-name = "vdda_0v85_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v75_s0: nldo-reg5 {
+				regulator-name = "vdd_0v75_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&tsadc {
+	status = "okay";
+};
+
+/* Mule-ATtiny UPDI */
+&uart4 {
+	pinctrl-0 = <&uart4m2_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index cacdb0459c9..35868d73dd5 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -159,6 +159,36 @@ config TARGET_QUARTZPRO64_RK3588
 	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
 	  Computer) by Pine64.
 
+config TARGET_TIGER_RK3588
+	bool "Theobroma Systems SOM-RK3588-Q7 (Tiger)"
+	select BOARD_LATE_INIT
+	help
+	  The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
+	  connector) system-on-module from Theobroma Systems, featuring the
+	  Rockchip RK3588.
+
+	  It provides the following feature set:
+	   * up to 16GB LPDDR4x
+	   * on-module eMMC
+	   * SD card (on a baseboard) via edge connector
+	   * Gigabit Ethernet with on-module GbE PHY
+	   * HDMI/eDP
+	   * MIPI-DSI
+	   * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
+	   * HDMI input over FPC connector
+	   * CAN
+	   * USB
+	     - 1x USB 3.0 dual-role (direct connection)
+	     - 2x USB 3.0 host + 1x USB 2.0 host
+	   * PCIe
+	     - 1x PCIe 2.1 Gen3, 4 lanes
+	     - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
+	   * on-module ATtiny816 companion controller, implementing:
+	     - low-power RTC functionality (ISL1208 emulation)
+	     - fan controller (AMC6821 emulation)
+	   * on-module Secure Element with Global Platform 2.2.1 compliant
+	     JavaCard environment
+
 config TARGET_TURINGRK1_RK3588
 	bool "Turing Machines RK1 RK3588 board"
 	select BOARD_LATE_INIT
@@ -240,5 +270,6 @@ source board/radxa/rock5b-rk3588/Kconfig
 source board/rockchip/evb_rk3588/Kconfig
 source board/rockchip/toybrick_rk3588/Kconfig
 source board/theobroma-systems/jaguar_rk3588/Kconfig
+source board/theobroma-systems/tiger_rk3588/Kconfig
 
 endif
diff --git a/board/theobroma-systems/tiger_rk3588/Kconfig b/board/theobroma-systems/tiger_rk3588/Kconfig
new file mode 100644
index 00000000000..2c6ac6a9a83
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_TIGER_RK3588
+
+config SYS_BOARD
+	default "tiger_rk3588"
+
+config SYS_VENDOR
+	default "theobroma-systems"
+
+config SYS_CONFIG_NAME
+	default "tiger_rk3588"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ENV_IS_NOWHERE
+
+endif
diff --git a/board/theobroma-systems/tiger_rk3588/MAINTAINERS b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
new file mode 100644
index 00000000000..02a2d09fe69
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
@@ -0,0 +1,13 @@
+TIGER-RK3588 (SOM-RK3588-Q7)
+M:	Klaus Goger <klaus.goger@theobroma-systems.com>
+M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
+M:	Heiko Stuebner <heiko.stuebner@cherry.de>
+S:	Maintained
+F:	board/theobroma-systems/tiger_rk3588
+F:	board/theobroma-systems/common
+F:	doc/board/theobroma-systems/
+F:	include/configs/tiger_rk3588.h
+F:	arch/arm/dts/rk3588-tiger*
+F:	configs/tiger-rk3588_defconfig
+W:	https://theobroma-systems.com/product/tiger-som-rk3588-q7/
+T:	git git://git.theobroma-systems.com/tiger-u-boot.git
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
new file mode 100644
index 00000000000..5c4c484657a
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -0,0 +1,10 @@
+#
+# Copyright (c) 2024 Theobroma Systems Design und Consulting GmbH
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+obj-y += tiger_rk3588.o
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y	+= ../common/common.o
+endif
diff --git a/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
new file mode 100644
index 00000000000..a6d44f10db3
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <phy.h>
+#include <eth_phy.h>
+
+#include <asm/types.h>
+#include <asm/arch-rockchip/cru_rk3588.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/arch-rockchip/ioc_rk3588.h>
+#include <asm-generic/u-boot.h>
+#include <dm/device.h>
+#include <dm/uclass-id.h>
+#include <linux/bitfield.h>
+
+#include "../common/common.h"
+
+#define GPIO2C3_SEL_MASK		GENMASK(15, 12)
+#define GPIO2C3_ETH0_REFCLKO_25M	FIELD_PREP(GPIO2C3_SEL_MASK, 1)
+
+#define REFCLKO25M_ETH0_OUT_SEL_MASK	BIT(15)
+#define REFCLKO25M_ETH0_OUT_SEL_CPLL	FIELD_PREP(REFCLKO25M_ETH0_OUT_SEL_MASK, 1)
+#define REFCLKO25M_ETH0_OUT_DIV_MASK	GENMASK(14, 8)
+#define REFCLKO25M_ETH0_OUT_DIV(x)	FIELD_PREP(REFCLKO25M_ETH0_OUT_DIV_MASK, (x) - 1)
+
+#define REFCLKO25M_ETH0_OUT_EN		BIT(4)
+
+void setup_eth0refclko(void)
+{
+	/* Configure and enable ETH0_REFCLKO_25MHz */
+	static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
+	static struct rk3588_cru * const cru = (void *)CRU_BASE;
+
+	/* 1. Pinmux */
+	rk_clrsetreg(&bus_ioc->gpio2c_iomux_sel_l, GPIO2C3_SEL_MASK, GPIO2C3_ETH0_REFCLKO_25M);
+	/* 2. Parent clock selection + divider => CPLL (1.5GHz) / 60 => 25MHz */
+	rk_clrsetreg(&cru->clksel_con[15],
+		     REFCLKO25M_ETH0_OUT_SEL_MASK | REFCLKO25M_ETH0_OUT_DIV_MASK,
+		     REFCLKO25M_ETH0_OUT_SEL_CPLL | REFCLKO25M_ETH0_OUT_DIV(60));
+	/* 3. Enable clock */
+	rk_clrreg(&cru->clkgate_con[5], REFCLKO25M_ETH0_OUT_EN);
+}
+
+int rockchip_early_misc_init_r(void)
+{
+	setup_boottargets();
+
+	setup_eth0refclko();
+
+	return 0;
+}
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
new file mode 100644
index 00000000000..6545445bba1
--- /dev/null
+++ b/configs/tiger-rk3588_defconfig
@@ -0,0 +1,114 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_ENV_SIZE=0x1f000
+CONFIG_DEFAULT_DEVICE_TREE="rk3588-tiger-haikou"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
+CONFIG_SPL_SERIAL=y
+CONFIG_DEBUG_UART_CHANNEL=2
+CONFIG_TARGET_TIGER_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xfeb50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-tiger-haikou.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CYCLIC=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SF is not set
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_MII is not set
+# CONFIG_CMD_BLOCK_CACHE is not set
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EROFS=y
+CONFIG_CMD_SQUASHFS=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_GPIO=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5dd5ea7f1e2..f5a05596f57 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -128,6 +128,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 5B (rock5b-rk3588)
      - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
      - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
+     - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
index b4da2616c37..73e07f7ebfa 100644
--- a/doc/board/theobroma-systems/index.rst
+++ b/doc/board/theobroma-systems/index.rst
@@ -9,3 +9,4 @@ Theobroma Systems
    jaguar_rk3588
    puma_rk3399
    ringneck_px30
+   tiger_rk3588
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
new file mode 100644
index 00000000000..a73eec7fb9b
--- /dev/null
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+SOM-RK3588-Q7 Tiger
+===================
+
+The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
+connector) system-on-module from Theobroma Systems, featuring the
+Rockchip RK3588.
+
+It provides the following feature set:
+ * up to 16GB LPDDR4x
+ * on-module eMMC
+ * SD card (on a baseboard) via edge connector
+ * Gigabit Ethernet with on-module GbE PHY
+ * HDMI/eDP
+ * MIPI-DSI
+ * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
+ * HDMI input over FPC connector
+ * CAN
+ * USB
+   - 1x USB 3.0 dual-role (direct connection)
+   - 2x USB 3.0 host + 1x USB 2.0 host
+ * PCIe
+   - 1x PCIe 2.1 Gen3, 4 lanes
+   - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
+ * on-module ATtiny816 companion controller, implementing:
+   - low-power RTC functionality (ISL1208 emulation)
+   - fan controller (AMC6821 emulation)
+ * on-module Secure Element with Global Platform 2.2.1 compliant
+   JavaCard environment
+
+Here is the step-by-step to boot to U-Boot on SOM-RK3588-Q7 Tiger from Theobroma
+Systems.
+
+Get the TF-A and DDR init (TPL) binaries
+----------------------------------------
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkbin
+   cd rkbin
+   export RKBIN=$(pwd)
+   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.38.elf
+   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.11.bin
+   sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
+   sed -i 's/^uart iomux=.*$/uart iomux=2/' tools/ddrbin_param.txt
+   ./tools/ddrbin_tool tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
+   export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
+
+This will setup all required external dependencies for compiling U-Boot. This will
+be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
+gains support for open-source DRAM initialization in TPL.
+
+Build U-Boot
+------------
+
+.. prompt:: bash
+
+   cd ../u-boot
+   make CROSS_COMPILE=aarch64-linux-gnu- tiger-rk3588_defconfig all
+
+This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
+(eMMC or SD card).
+
+Flash the image
+---------------
+
+Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
+
+SD-Card
+~~~~~~~
+
+.. prompt:: bash
+
+   dd if=u-boot-rockchip.bin of=/dev/sdX seek=64
+
+.. note::
+
+   Replace ``/dev/sdX`` to match your SD card kernel device.
+
+eMMC
+~~~~
+
+``rkdeveloptool`` allows to flash the on-board eMMC via the USB OTG interface
+with help of the Rockchip loader binary.
+
+To enter the USB flashing mode on Haikou baseboard, remove any SD card, insert a
+micro-USB cable in the ``Q7 USB P1`` connector (P8), move ``SW5`` switch into
+``BIOS Disable`` mode, power cycle or reset the board and move ``SW5`` switch
+back to ``Normal Boot`` mode. A new USB device should have appeared on your PC
+(check with ``lsusb -d 2207:350b``).
+
+To flash U-Boot on the eMMC with ``rkdeveloptool``:
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkdeveloptool
+   cd rkdeveloptool
+   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
+   ./rkdeveloptool db "$RKDB"
+   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
diff --git a/include/configs/tiger_rk3588.h b/include/configs/tiger_rk3588.h
new file mode 100644
index 00000000000..7a32adfaf2a
--- /dev/null
+++ b/include/configs/tiger_rk3588.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#ifndef __TIGER_RK3588_H
+#define __TIGER_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __TIGER_RK3588_H */

-- 
2.44.0

