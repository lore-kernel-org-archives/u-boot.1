Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF586C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 17:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8458718A;
	Tue, 13 Feb 2024 18:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="xmtDlgfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F5987D9E; Tue, 13 Feb 2024 18:23:03 +0100 (CET)
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7420287D66
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 18:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9F8EFBFC41; Tue, 13 Feb 2024 18:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1707844973; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=4sRQnfG5pmf+7kVt9vc9yM1nmNKRiQ4NK5wuSzYXlbE=;
 b=xmtDlgfSEPEOh0NIxQtY+5nggjCI7VbRFly+j19K50W/l3c/uJZLWH4sl90L4g4WOgb15g
 AAvNPcv2d70cemGp3TD2Yc8pNPnkeu+78UzGFRIbv7uOMiyxnRJYe7zfwdQs09ejVYO1V7
 RsowGfCDzzDyYzZvEiD1CmkTR+AzGpQFWqMQHh5GzLCG33qz9OxcmNdYb3TvPD7gjPsAsN
 Jzo6pAdBJN+pWdfnW674DcVKKWo90ORJQYDHFJ4vb5GGTeC14yHQPyL77+dtv54Ic6BPhQ
 42wmFsAp3AtuX1602bd5X+miH2g9zBfMSS2JsTak+58mw5cV/VZC4p1WrUvPmQ==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>
Subject: [PATCH v2 2/3] board: Add support for Sielaff i.MX6 Solo board
Date: Tue, 13 Feb 2024 18:22:19 +0100
Message-ID: <20240213172226.151181-2-frieder@fris.de>
In-Reply-To: <20240213172226.151181-1-frieder@fris.de>
References: <20240213172226.151181-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Sielaff i.MX6 Solo board is a control and HMI board for vending
machines. Add support for this board.

The devicetree files are taken from pending changes in the Linux
kernel that are available from linux-next and will likely be
part of Linux v6.9.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* Implement changes suggested by Fabio (Thanks!)
  * Fix system reset and remove unneeded cpu_reset()
  * Add 'static const' to nfc_pads[]
  * Remove hostname from env
  * Remove options to disable caches
* Enable watchdog and wdt command
* Enable LTO
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/imx6dl-sielaff-u-boot.dtsi       |  38 ++
 arch/arm/dts/imx6dl-sielaff.dts               | 533 ++++++++++++++++++
 arch/arm/mach-imx/mx6/Kconfig                 |  10 +
 board/sielaff/imx6dl-sielaff/Kconfig          |  15 +
 board/sielaff/imx6dl-sielaff/Makefile         |   8 +
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c | 111 ++++
 .../sielaff/imx6dl-sielaff/imx6dl-sielaff.env | 114 ++++
 board/sielaff/imx6dl-sielaff/spl.c            | 273 +++++++++
 configs/imx6dl_sielaff_defconfig              | 120 ++++
 include/configs/imx6dl-sielaff.h              |  25 +
 11 files changed, 1248 insertions(+)
 create mode 100644 arch/arm/dts/imx6dl-sielaff-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6dl-sielaff.dts
 create mode 100644 board/sielaff/imx6dl-sielaff/Kconfig
 create mode 100644 board/sielaff/imx6dl-sielaff/Makefile
 create mode 100644 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
 create mode 100644 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
 create mode 100644 board/sielaff/imx6dl-sielaff/spl.c
 create mode 100644 configs/imx6dl_sielaff_defconfig
 create mode 100644 include/configs/imx6dl-sielaff.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0fcae77cefe..d60fa1179af 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -930,6 +930,7 @@ dtb-y += \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
+	imx6dl-sielaff.dtb \
 	imx6dl-wandboard-revd1.dtb \
 	imx6s-dhcom-drc02.dtb
 
diff --git a/arch/arm/dts/imx6dl-sielaff-u-boot.dtsi b/arch/arm/dts/imx6dl-sielaff-u-boot.dtsi
new file mode 100644
index 00000000000..8f5a70ccb85
--- /dev/null
+++ b/arch/arm/dts/imx6dl-sielaff-u-boot.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+#include "imx6qdl-u-boot.dtsi"
+
+/ {
+	binman: binman {
+		filename = "flash.bin";
+		pad-byte = <0x00>;
+
+		spl: blob-ext@1 {
+			offset = <0x0>;
+			filename = "SPL";
+		};
+
+		uboot: blob-ext@2 {
+			offset = <0x11000>;
+			filename = "u-boot.img";
+		};
+	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+	};
+};
+
+&fec {
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <100>;
+};
+
+&gpmi {
+	fsl,legacy-bch-geometry;
+};
diff --git a/arch/arm/dts/imx6dl-sielaff.dts b/arch/arm/dts/imx6dl-sielaff.dts
new file mode 100644
index 00000000000..7de8d5f2651
--- /dev/null
+++ b/arch/arm/dts/imx6dl-sielaff.dts
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Sielaff i.MX6 Solo";
+	compatible = "sielaff,imx6dl-board", "fsl,imx6dl";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	backlight: pwm-backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm3 0 50000 0>;
+		brightness-levels = <0 0 64 88 112 136 184 232 255>;
+		default-brightness-level = <4>;
+		enable-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_backlight>;
+	};
+
+	cec {
+		compatible = "cec-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hdmi_cec>;
+		cec-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		hdmi-phandle = <&hdmi>;
+	};
+
+	enet_ref: clock-enet-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "enet-ref";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		key-0 {
+			gpios = <&gpio2 16 0>;
+			debounce-interval = <10>;
+			linux,code = <1>;
+		};
+
+		key-1 {
+			gpios = <&gpio3 27 0>;
+			debounce-interval = <10>;
+			linux,code = <2>;
+		};
+
+		key-2 {
+			gpios = <&gpio5 4 0>;
+			debounce-interval = <10>;
+			linux,code = <3>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-debug {
+			label = "debug-led";
+			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+		device_type = "memory";
+	};
+
+	osc_eth_phy: clock-osc-eth-phy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "osc-eth-phy";
+	};
+
+	panel {
+		compatible = "lg,lb070wv8";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in_lvds: endpoint {
+				remote-endpoint = <&lvds_out>;
+			};
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_backlight: regulator-backlight {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_backlight>;
+		enable-active-high;
+		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+		regulator-name = "backlight";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
+		enable-active-high;
+		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&fec {
+	/*
+	 * Set PTP clock to external instead of internal reference, as the
+	 * REF_CLK from the PHY is fed back into the i.MX6 and the GPR
+	 * register needs to be set accordingly (see mach-imx6q.c).
+	 */
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&enet_ref>,
+		 <&clks IMX6QDL_CLK_ENET_REF>;
+	clock-names = "ipg", "ahb", "ptp", "enet_out";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-connection-type = "rmii";
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			reg = <1>;
+			clocks = <&osc_eth_phy>;
+			clock-names = "rmii-ref";
+			micrel,led-mode = <1>;
+			reset-assert-us = <500>;
+			reset-deassert-us = <100>;
+			reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "key-out", "key-in",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"lan9500a-rst", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c4>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	touchscreen@55 {
+		compatible = "sitronix,st1633";
+		reg = <0x55>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio5>;
+		gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+	};
+
+	touchscreen@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio5>;
+		irq-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&ldb {
+	status = "okay";
+
+	lvds: lvds-channel@0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		port@4 {
+			reg = <4>;
+
+			lvds_out: endpoint {
+				remote-endpoint = <&panel_in_lvds>;
+			};
+		};
+	};
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	disable-over-current;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usb1@1 {
+		compatible = "usb4b4,6570";
+		reg = <1>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+
+		assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
+				  <&clks IMX6QDL_CLK_CKO2_SEL>;
+		assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
+					 <&clks IMX6QDL_CLK_OSC>;
+		assigned-clock-rates = <12000000 0>;
+	};
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "host";
+	over-current-active-low;
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3v3>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RD0__GPIO6_IO25	0x1b0b0	/* PMIC_IRQ */
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x1b0b0
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14		0x1b0b0
+			MX6QDL_PAD_SD2_DAT0__GPIO1_IO15		0x1b0b0
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08		0x1b0b0
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0
+		>;
+	};
+
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x100b1
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__ECSPI2_MISO	0x100b1
+			MX6QDL_PAD_CSI0_DAT9__ECSPI2_MOSI	0x100b1
+			MX6QDL_PAD_CSI0_DAT8__ECSPI2_SCLK	0x100b1
+			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29	0x100b1
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x100b1
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x1b080
+			MX6QDL_PAD_EIM_D27__GPIO3_IO27		0x1b080
+			MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x1b080
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1b0b0
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+		>;
+	};
+
+	pinctrl_hdmi_cec: hdmicecgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A21__GPIO2_IO17		0x1b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001f8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__I2C4_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_8__I2C4_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+		>;
+	};
+
+	pinctrl_reg_backlight: regbacklightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23	0x1b0b1
+		>;
+	};
+
+	pinctrl_reg_usbotg_vbus: regusbotgvbusgrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b1
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x1b0b0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA 	0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA 	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b0
+		>;
+	};
+
+	pinctrl_usbh1: usbh1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__USB_H1_OC		0x1b0b1
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1		0x1b0b0
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x100b1
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__WDOG1_B		0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 114cce4d9b9..15ee2b933f6 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -356,6 +356,15 @@ config TARGET_MX6Q_ACC
 	select DM_THERMAL
 	select SUPPORT_SPL
 
+config TARGET_MX6S_SIELAFF
+	bool "Sielaff i.MX6 Solo Board"
+	depends on MX6S
+	select BINMAN
+	select DM
+	select DM_THERMAL
+	select SUPPORT_SPL
+	imply CMD_DM
+
 config TARGET_MX6SABREAUTO
 	bool "mx6sabreauto"
 	depends on MX6QDL
@@ -708,6 +717,7 @@ source "board/softing/vining_2000/Kconfig"
 source "board/liebherr/display5/Kconfig"
 source "board/liebherr/mccmon6/Kconfig"
 source "board/logicpd/imx6/Kconfig"
+source "board/sielaff/imx6dl-sielaff/Kconfig"
 source "board/solidrun/mx6cuboxi/Kconfig"
 source "board/somlabs/visionsom-6ull/Kconfig"
 source "board/technexion/pico-imx6/Kconfig"
diff --git a/board/sielaff/imx6dl-sielaff/Kconfig b/board/sielaff/imx6dl-sielaff/Kconfig
new file mode 100644
index 00000000000..1b74a7d90ee
--- /dev/null
+++ b/board/sielaff/imx6dl-sielaff/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_MX6S_SIELAFF
+
+config SYS_BOARD
+	string
+	default "imx6dl-sielaff"
+
+config SYS_VENDOR
+	string
+	default "sielaff"
+
+config SYS_CONFIG_NAME
+	string
+	default "imx6dl-sielaff"
+
+endif
diff --git a/board/sielaff/imx6dl-sielaff/Makefile b/board/sielaff/imx6dl-sielaff/Makefile
new file mode 100644
index 00000000000..65cecfe6f6c
--- /dev/null
+++ b/board/sielaff/imx6dl-sielaff/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2022 Kontron Electronics GmbH
+
+ifdef CONFIG_SPL_BUILD
+obj-y := spl.o
+else
+obj-y := imx6dl-sielaff.o
+endif
diff --git a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
new file mode 100644
index 00000000000..4da084ed91c
--- /dev/null
+++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+#include <compiler.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/io.h>
+#include <init.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const iomux_v3_cfg_t nfc_pads[] = {
+	MX6_PAD_NANDF_CLE__NAND_CLE		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_ALE__NAND_ALE		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_WP_B__NAND_WP_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_RB0__NAND_READY_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_CS0__NAND_CE0_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_CS1__NAND_CE1_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_CS2__NAND_CE2_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_CS3__NAND_CE3_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_CMD__NAND_RE_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_CLK__NAND_WE_B		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D0__NAND_DATA00		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D1__NAND_DATA01		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D2__NAND_DATA02		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D3__NAND_DATA03		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D4__NAND_DATA04		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D5__NAND_DATA05		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D6__NAND_DATA06		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_NANDF_D7__NAND_DATA07		| MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_DAT0__NAND_DQS		| MUX_PAD_CTRL(NO_PAD_CTRL),
+};
+
+int dram_init(void)
+{
+	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
+	return 0;
+}
+
+static void setup_gpmi_nand(void)
+{
+	struct mxc_ccm_reg *mxc_ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	/* config gpmi nand iomux */
+	imx_iomux_v3_setup_multiple_pads(nfc_pads,
+					 ARRAY_SIZE(nfc_pads));
+
+	/* gate ENFC_CLK_ROOT clock first,before clk source switch */
+	clrbits_le32(&mxc_ccm->CCGR2, MXC_CCM_CCGR2_IOMUX_IPT_CLK_IO_MASK);
+
+	/* config gpmi and bch clock to 100 MHz */
+	clrsetbits_le32(&mxc_ccm->cs2cdr,
+			MXC_CCM_CS2CDR_ENFC_CLK_PODF_MASK |
+			MXC_CCM_CS2CDR_ENFC_CLK_PRED_MASK |
+			MXC_CCM_CS2CDR_ENFC_CLK_SEL_MASK,
+			MXC_CCM_CS2CDR_ENFC_CLK_PODF(0) |
+			MXC_CCM_CS2CDR_ENFC_CLK_PRED(3) |
+			MXC_CCM_CS2CDR_ENFC_CLK_SEL(3));
+
+	/* enable ENFC_CLK_ROOT clock */
+	setbits_le32(&mxc_ccm->CCGR2, MXC_CCM_CCGR2_IOMUX_IPT_CLK_IO_MASK);
+
+	/* enable gpmi and bch clock gating */
+	setbits_le32(&mxc_ccm->CCGR4,
+		     MXC_CCM_CCGR4_RAWNAND_U_BCH_INPUT_APB_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_BCH_INPUT_BCH_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_BCH_INPUT_GPMI_IO_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_INPUT_APB_MASK |
+		     MXC_CCM_CCGR4_PL301_MX6QPER1_BCH_OFFSET);
+
+	/* enable apbh clock gating */
+	setbits_le32(&mxc_ccm->CCGR0, MXC_CCM_CCGR0_APBHDMA_MASK);
+}
+
+int board_init(void)
+{
+	struct mxc_ccm_reg *mxc_ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+	u32 reg;
+
+	setup_gpmi_nand();
+
+	/* Enable SPI2 clock */
+	enable_spi_clk(true, 1);
+
+	/*
+	 * Configure clock output for USB hub
+	 * 1. Disabling CLK01 and CLK02
+	 */
+	clrbits_le32(&mxc_ccm->ccosr, MXC_CCM_CCOSR_CKOL_EN);
+	clrbits_le32(&mxc_ccm->ccosr, MXC_CCM_CCOSR_CKO2_EN_OFFSET);
+
+	/*
+	 * 2. Setting ccm timer - osc_clk (24 MHz) divide by 2 -> 12 Mhz
+	 * CLK02_DIV: 001b CLK02_SEL: 01110b -> 0010 1110b -> 0x2e
+	 */
+	reg = readl(&mxc_ccm->ccosr);
+	reg &= ~MXC_CCM_CCOSR_CKO2_SEL_MASK;
+	reg &= ~MXC_CCM_CCOSR_CKO2_DIV_MASK;
+	reg |= (0x2e << MXC_CCM_CCOSR_CKO2_SEL_OFFSET);
+	writel(reg, &mxc_ccm->ccosr);
+
+	/* 3. Enabling CLK02 on output CCM_CLK01 */
+	setbits_le32(&mxc_ccm->ccosr, MXC_CCM_CCOSR_CLK_OUT_SEL);
+	setbits_le32(&mxc_ccm->ccosr, MXC_CCM_CCOSR_CKO2_EN_OFFSET);
+
+	return 0;
+}
diff --git a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
new file mode 100644
index 00000000000..9aafa3c9984
--- /dev/null
+++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
@@ -0,0 +1,114 @@
+blkloadfdt=fatload ${device} ${devnum}:${partnum} ${fdt_addr} ${load_fdt_file}
+blkloadimage=fatload ${device} ${devnum}:${partnum} ${loadaddr} ${load_image}
+boot_devices=usb mmc ubi
+bootargs_base=vt.global_cursor_default=0 consoleblank=0 cma=200M fbcon=rotate:1
+bootdelay=3
+bootdir=
+console=ttymxc1,115200
+ethact=FEC0
+fdt_addr=0x18000000
+fdt_file_legacy=imx6dl_sielaff.dtb
+fdt_file=imx6dl-sielaff.dtb
+fdt_high=0xffffffff
+image_legacy=zImage
+image=fitImage
+initrd_high=0xffffffff
+ip_dyn=no
+loadaddr=0x12000000
+mmcargs=setenv bootargs ${bootargs_base} console=${console} root=${mmcroot}
+mmcroot=/dev/mmcblk2p2 rootwait rw
+ramdisk_addr=0x18C00000
+script=boot.scr
+touch_rst_gpio=2
+touch_irq_gpio=146
+ubiargs=setenv bootargs ${bootargs_base} console=${console} rootfstype=ubifs ubi.mtd=0 root=ubi0_0 rw
+ubiloadfdt=ubifsload ${fdt_addr} /boot/${load_fdt_file}
+ubiloadimage=ubifsload ${loadaddr} /boot/${load_image}
+usb_pgood_delay=2000
+usbargs=setenv bootargs ${bootargs_base} console=${console} root=${usbroot}
+usbroot=/dev/sda2 rootwait rw
+
+bootcmd=
+	for b in ${boot_devices}; do
+		if test ${b} = mmc; then
+			run mmcboot;
+		fi;
+		if test ${b} = net; then
+			run netboot;
+		fi;
+		if test ${b} = ubi; then
+			run ubiboot;
+		fi;
+		if test ${b} = usb; then
+			run usbboot;
+		fi;
+	done;
+
+boot=
+	load_image=${image};
+	run loadimagecmd;
+	if test $? = 0; then
+		imxtract ${loadaddr} fdt-${fdt_file} ${fdt_addr};
+		run detect_touch;
+		bootm ${loadaddr} - ${fdt_addr};
+	else
+		load_image=${image_legacy};
+		load_fdt_file=${fdt_file_legacy};
+		run loadimagecmd;
+		run loadfdtcmd;
+		if test $? = 0; then
+			run detect_touch;
+			bootz ${loadaddr} - ${fdt_addr};
+		fi;
+	fi;
+
+detect_touch=
+	gpio clear ${touch_irq_gpio};
+	gpio clear ${touch_rst_gpio};
+	sleep 0.02;
+	gpio set ${touch_rst_gpio};
+	sleep 0.1;
+	gpio input ${touch_irq_gpio};
+	i2c dev 2;
+	fdt addr ${fdt_addr};
+	if i2c probe 0x55; then
+		echo 'Detected Sitronix Touch';
+		fdt set /soc/bus@2100000/i2c@21a8000/touchscreen@55 status okay;
+	else
+		if i2c probe 0x5d; then
+			echo 'Detected Goodix Touch';
+			fdt set /soc/bus@2100000/i2c@21a8000/touchscreen@5d status okay;
+		fi;
+	fi;
+	gpio clear ${touch_rst_gpio};
+
+mmcboot=
+	echo Booting from MMC ...;
+	run mmcargs;
+	device=mmc;
+	devnum=2;
+	partnum=1;
+	setenv loadimagecmd ${blkloadimage};
+	setenv loadfdtcmd ${blkloadfdt};
+	run boot;
+
+ubiboot=
+	echo Booting from NAND (UBI);
+	run ubiargs;
+	ubi part rootfs;
+	ubifsmount ubi0;
+	setenv loadimagecmd ${ubiloadimage};
+	setenv loadfdtcmd ${ubiloadfdt};
+	load_image=${image};
+	run boot;
+
+usbboot=
+	echo Booting from USB Storage ...;
+	run usbargs;
+	usb start;
+	device=usb;
+	devnum=0;
+	partnum=1;
+	setenv loadimagecmd ${blkloadimage};
+	setenv loadfdtcmd ${blkloadfdt};
+	run boot;
diff --git a/board/sielaff/imx6dl-sielaff/spl.c b/board/sielaff/imx6dl-sielaff/spl.c
new file mode 100644
index 00000000000..64a84fd5122
--- /dev/null
+++ b/board/sielaff/imx6dl-sielaff/spl.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/sections.h>
+#include <init.h>
+#include <spl.h>
+#include <fsl_esdhc_imx.h>
+#include <mmc.h>
+
+#define SPI_PAD_CTRL (PAD_CTL_HYS | PAD_CTL_SPEED_MED | 	\
+	PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST)
+
+#define UART_PAD_CTRL  (PAD_CTL_PUS_100K_UP |			\
+	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm |			\
+	PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+
+#define USDHC_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
+	PAD_CTL_PUS_22K_UP | PAD_CTL_SPEED_LOW |		\
+	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+
+#define GPIO_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
+	PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_LOW |		\
+	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+
+static const iomux_v3_cfg_t ecspi2_pads[] = {
+	MX6_PAD_CSI0_DAT10__ECSPI2_MISO | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_CSI0_DAT9__ECSPI2_MOSI | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_CSI0_DAT8__ECSPI2_SCLK | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_CSI0_DAT11__GPIO5_IO29  | MUX_PAD_CTRL(NO_PAD_CTRL),
+};
+
+static const iomux_v3_cfg_t uart2_pads[] = {
+	MX6_PAD_SD4_DAT7__UART2_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+	MX6_PAD_SD4_DAT4__UART2_RX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+};
+
+static const iomux_v3_cfg_t usdhc3_pads[] = {
+	MX6_PAD_SD3_CLK__SD3_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_CMD__SD3_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT0__SD3_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT1__SD3_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT2__SD3_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT3__SD3_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
+
+	/* CD */
+	MX6_PAD_GPIO_4__GPIO1_IO04 | MUX_PAD_CTRL(GPIO_PAD_CTRL),
+};
+
+#define USDHC3_CD_GPIO	IMX_GPIO_NR(1, 4)
+#define SPI2_CS_GPIO	IMX_GPIO_NR(5, 29)
+
+static struct fsl_esdhc_cfg usdhc_cfg[1] = {
+	{USDHC3_BASE_ADDR, 0, 4},
+};
+
+int board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	switch (cfg->esdhc_base) {
+	case USDHC3_BASE_ADDR:
+		ret = !gpio_get_value(USDHC3_CD_GPIO);
+		break;
+	}
+
+	return ret;
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	int i, ret;
+
+	/*
+	 * According to the board_mmc_init() the following map is done:
+	 * (U-boot device node)    (Physical Port)
+	 * mmc0                    USDHC1
+	 * mmc1                    USDHC2
+	 */
+	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
+		switch (i) {
+		case 0:
+			imx_iomux_v3_setup_multiple_pads(usdhc3_pads,
+							 ARRAY_SIZE(usdhc3_pads));
+			gpio_direction_input(USDHC3_CD_GPIO);
+			usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+			break;
+		default:
+			printf("Warning: you configured more USDHC controllers \
+				(%d) than supported by the board\n", i + 1);
+			return -EINVAL;
+		}
+
+		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[i]);
+		if (ret) {
+			printf("Warning: failed to initialize mmc dev %d\n", i);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static void ccgr_init(void)
+{
+	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	writel(0x00C03F3F, &ccm->CCGR0);
+	writel(0x0030FC03, &ccm->CCGR1);
+	writel(0x0FFFC000, &ccm->CCGR2);
+	writel(0x3FF00000, &ccm->CCGR3);
+	writel(0x00FFF300, &ccm->CCGR4);
+	writel(0x0F0000C3, &ccm->CCGR5);
+	writel(0x000003FF, &ccm->CCGR6);
+}
+
+static int mx6ssielaff_dcd_table[] = {
+	0x020e0774, 0x000C0000,
+	0x020e0754, 0x00000000,
+	0x020e04ac, 0x00000030,
+	0x020e04b0, 0x00000030,
+	0x020e0464, 0x00000030,
+	0x020e0490, 0x00000030,
+	0x020e074c, 0x00000030,
+	0x020e0494, 0x00000030,
+	0x020e04a0, 0x00000000,
+	0x020e04b4, 0x00000030,
+	0x020e04b8, 0x00000030,
+	0x020e076c, 0x00000030,
+	0x020e0750, 0x00020000,
+	0x020e04bc, 0x00000030,
+	0x020e04c0, 0x00000030,
+	0x020e04c4, 0x00000030,
+	0x020e04c8, 0x00000030,
+	0x020e0760, 0x00020000,
+	0x020e0764, 0x00000030,
+	0x020e0770, 0x00000030,
+	0x020e0778, 0x00000030,
+	0x020e077c, 0x00000030,
+	0x020e0470, 0x00000030,
+	0x020e0474, 0x00000030,
+	0x020e0478, 0x00000030,
+	0x020e047c, 0x00000030,
+	0x021b001c, 0x00008000,
+	0x021b0800, 0xA1390003,
+	0x021b080c, 0x00350035,
+	0x021b0810, 0x002A0032,
+	0x021b083c, 0x02340234,
+	0x021b0840, 0x02200220,
+	0x021b0848, 0x4650504E,
+	0x021b0850, 0x3A342E34,
+	0x021b081c, 0x33333333,
+	0x021b0820, 0x33333333,
+	0x021b0824, 0x33333333,
+	0x021b0828, 0x33333333,
+	0x021b08b8, 0x00000800,
+	0x021b0004, 0x0002002D,
+	0x021b0008, 0x00333040,
+	0x021b000c, 0x676B52F3,
+	0x021b0010, 0xB66D8B63,
+	0x021b0014, 0x01FF00DB,
+	0x021b0018, 0x00011740,
+	0x021b001c, 0x00008000,
+	0x021b002c, 0x000026D2,
+	0x021b0030, 0x006B1023,
+	0x021b0040, 0x00000027,
+	0x021b0000, 0x84190000,
+	0x021b001c, 0x02008032,
+	0x021b001c, 0x00008033,
+	0x021b001c, 0x00048031,
+	0x021b001c, 0x15208030,
+	0x021b001c, 0x04008040,
+	0x021b0020, 0x00007800,
+	0x021b0818, 0x00022227,
+	0x021b0004, 0x0002556D,
+	0x021b0404, 0x00011006,
+	0x021b001c, 0x00000000,
+	0x020c4068, 0x00C03F3F,
+	0x020c406c, 0x0030FC03,
+	0x020c4070, 0x0FFFC000,
+	0x020c4074, 0x3FF00000,
+	0x020c4078, 0xFFFFF300,
+	0x020c407c, 0x0F0000C3,
+	0x020c4080, 0x000003FF,
+	0x020e0010, 0xF00000CF,
+	0x020e0018, 0x007F007F,
+	0x020e001c, 0x007F007F,
+};
+
+static void ddr_init(int *table, int size)
+{
+	int i;
+
+	for (i = 0; i < size / 2 ; i++)
+		writel(table[2 * i + 1], table[2 * i]);
+}
+
+static void spl_dram_init(void)
+{
+	ddr_init(mx6ssielaff_dcd_table, ARRAY_SIZE(mx6ssielaff_dcd_table));
+}
+
+int board_spi_cs_gpio(unsigned int bus, unsigned int cs)
+{
+	return (bus == CONFIG_SF_DEFAULT_BUS && cs == CONFIG_SF_DEFAULT_CS)
+		? SPI2_CS_GPIO : -1;
+}
+
+static void setup_spi(void)
+{
+	imx_iomux_v3_setup_multiple_pads(ecspi2_pads, ARRAY_SIZE(ecspi2_pads));
+	gpio_request(SPI2_CS_GPIO, "spi2_cs0");
+	gpio_direction_output(SPI2_CS_GPIO, 1);
+	enable_spi_clk(true, 1);
+}
+
+void board_init_f(ulong dummy)
+{
+	/* setup AIPS and disable watchdog */
+	arch_cpu_init();
+
+	ccgr_init();
+	gpr_init();
+
+	/* IOMUX UART */
+	imx_iomux_v3_setup_multiple_pads(uart2_pads, ARRAY_SIZE(uart2_pads));
+
+	/* setup GP timer */
+	timer_init();
+
+	/* UART clocks enabled and gd valid - init serial console */
+	preloader_console_init();
+
+	/* DDR initialization */
+	spl_dram_init();
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	/* SPI */
+	setup_spi();
+
+	/* load/boot image from boot device */
+	board_init_r(NULL, 0);
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	u32 bootdev = spl_boot_device();
+
+	/*
+	 * The default boot fuse settings use the SD card (MMC1) as primary
+	 * boot device, but allow SPI NOR as a fallback boot device.
+	 * We can't detect the fallback case and spl_boot_device() will return
+	 * BOOT_DEVICE_MMC1 despite the actual boot device being SPI NOR.
+	 * Therefore we try to load U-Boot proper vom SPI NOR after loading
+	 * from MMC has failed.
+	 */
+	spl_boot_list[0] = bootdev;
+
+	switch (bootdev) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+		spl_boot_list[1] = BOOT_DEVICE_SPI;
+		break;
+	}
+}
diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
new file mode 100644
index 00000000000..41574a41af1
--- /dev/null
+++ b/configs/imx6dl_sielaff_defconfig
@@ -0,0 +1,120 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_TEXT_BASE=0x17800000
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SOURCE_FILE="imx6dl-sielaff"
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xF0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_MX6S=y
+CONFIG_TARGET_MX6S_SIELAFF=y
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx6dl-sielaff"
+CONFIG_SPL_TEXT_BASE=0x00908000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_LTO=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_PRINT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SPI_BOOT=y
+CONFIG_SPL_RAW_IMAGE_SUPPORT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x8A
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_SPL=y
+CONFIG_CMD_SPL_WRITE_SIZE=0x20000
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:-@0x0(rootfs)"
+CONFIG_CMD_UBI=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x12000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MXC=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_MXS=y
+CONFIG_NAND_MXS_DT=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ8XXX=y
+CONFIG_DM_MDIO=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_CONS_INDEX=2
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_IMX_THERMAL=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/include/configs/imx6dl-sielaff.h b/include/configs/imx6dl-sielaff.h
new file mode 100644
index 00000000000..df074135079
--- /dev/null
+++ b/include/configs/imx6dl-sielaff.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2022 Kontron Electronics GmbH
+ */
+#ifndef __MX6SSIELAFF_CONFIG_H
+#define __MX6SSIELAFF_CONFIG_H
+
+#include <asm/arch/imx-regs.h>
+#include <linux/sizes.h>
+#include "mx6_common.h"
+
+#define CFG_MXC_UART_BASE		UART2_BASE
+
+#define PHYS_SDRAM_SIZE			SZ_512M
+#define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
+#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_ADDR		IRAM_BASE_ADDR
+#define CFG_SYS_INIT_RAM_SIZE		IRAM_SIZE
+
+#define CFG_SYS_FSL_ESDHC_ADDR		USDHC3_BASE_ADDR
+#define CFG_SYS_FSL_USDHC_NUM		1
+
+#define CFG_SYS_NAND_BASE		0x40000000
+
+#endif /* __MX6SSIELAFF_CONFIG_H */
-- 
2.43.0

