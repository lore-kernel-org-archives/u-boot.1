Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717C3CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13B183093;
	Mon, 25 Aug 2025 15:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="XyP5DeNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1327D8320C; Mon, 25 Aug 2025 15:55:55 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B743D830B4
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D55C3C994A; Mon, 25 Aug 2025 15:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130152; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=uFGTmP6IJSqdiy7qHgrz7rU+rV4yVbl0Y61xnwImo6Q=;
 b=XyP5DeNYkpmkhUvREWBdf288BH44CPuIGMeeLmkZsJ00bLfx42fEeFi4Of5FYVQl5pqQHr
 A2COMiD6PROBU0hIUPf9K3hRFJGAnryQjicVxkL3Q8D2Ykawk6rLkivWpoWwlNwKZcXVO4
 UlrZwU8H20AEAPUUb85qDRANpUnewwEfxCq/N0oKcUfrZCMQTVKiAwRYtCGAZgdktgpqkj
 5UqKbYePGOTh77nvSGGv80xc8tUUsiTVcf0YmWqo5jOiyg6QkGx7TjYcuMScpphFxxWhe2
 3wSFxXxSS0t2opFEiXLGsnAE2HdQsQNlRN/yrJy3KzDMY5ufDLAhj4bqpfpzLA==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 11/11] imx: kontron-sl-mx6ul: Switch to OF_UPSTREAM
Date: Mon, 25 Aug 2025 15:54:35 +0200
Message-ID: <20250825135504.193004-12-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
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

Use the upstream devicetrees instead of the local ones.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/dts/imx6ul-kontron-bl-43.dts      | 103 ------
 arch/arm/dts/imx6ul-kontron-bl-common.dtsi | 406 ---------------------
 arch/arm/dts/imx6ul-kontron-bl.dts         |  16 -
 arch/arm/dts/imx6ul-kontron-sl-common.dtsi | 137 -------
 arch/arm/dts/imx6ul-kontron-sl.dtsi        |  14 -
 arch/arm/dts/imx6ull-kontron-bl.dts        |  15 -
 arch/arm/dts/imx6ull-kontron-sl.dtsi       |  13 -
 configs/kontron-sl-mx6ul_defconfig         |   5 +-
 8 files changed, 3 insertions(+), 706 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-43.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl-common.dtsi
 delete mode 100644 arch/arm/dts/imx6ul-kontron-sl.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-kontron-bl.dts
 delete mode 100644 arch/arm/dts/imx6ull-kontron-sl.dtsi

diff --git a/arch/arm/dts/imx6ul-kontron-bl-43.dts b/arch/arm/dts/imx6ul-kontron-bl-43.dts
deleted file mode 100644
index 0c643706a15..00000000000
--- a/arch/arm/dts/imx6ul-kontron-bl-43.dts
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include "imx6ul-kontron-bl.dts"
-
-/ {
-	model = "Kontron BL i.MX6UL 43 (N631X S 43)";
-	compatible = "kontron,bl-imx6ul-43", "kontron,bl-imx6ul",
-		     "kontron,sl-imx6ul", "fsl,imx6ul";
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm7 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-		status = "okay";
-	};
-};
-
-&i2c4 {
-	touchscreen@5d {
-		compatible = "goodix,gt928";
-		reg = <0x5d>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_cap_touch>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
-		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
-		irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat &pinctrl_lcdif_ctrl>;
-	/* Leave status disabled because of missing display panel node */
-};
-
-&pwm7 {
-	#pwm-cells = <2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm7>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_cap_touch: captouchgrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0 /* Touch Interrupt */
-			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0 /* Touch Reset */
-			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x1b0b0 /* Touch Wake */
-		>;
-	};
-
-	pinctrl_lcdif_ctrl: lcdifctrlgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
-			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
-			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
-			MX6UL_PAD_LCD_RESET__LCDIF_RESET	0x79
-		>;
-	};
-
-	pinctrl_lcdif_dat: lcdifdatgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
-			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
-			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08	0x79
-			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09	0x79
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
-			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16	0x79
-			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
-			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
-			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
-			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
-			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
-			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
-			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
-		>;
-	};
-
-	pinctrl_pwm7: pwm7grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_VSYNC__PWM7_OUT		0x110b0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6ul-kontron-bl-common.dtsi b/arch/arm/dts/imx6ul-kontron-bl-common.dtsi
deleted file mode 100644
index a6cf0f21c66..00000000000
--- a/arch/arm/dts/imx6ul-kontron-bl-common.dtsi
+++ /dev/null
@@ -1,406 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_leds>;
-
-		led1 {
-			label = "debug-led1";
-			gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-			linux,default-trigger = "heartbeat";
-		};
-
-		led2 {
-			label = "debug-led2";
-			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-
-		led3 {
-			label = "debug-led3";
-			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-			default-state = "off";
-		};
-	};
-
-	pwm-beeper {
-		compatible = "pwm-beeper";
-		pwms = <&pwm8 0 5000>;
-	};
-
-	reg_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_5v: regulator-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_vref_adc: regulator-vref-adc {
-		compatible = "regulator-fixed";
-		regulator-name = "vref-adc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&adc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc1>;
-	num-channels = <3>;
-	vref-supply = <&reg_vref_adc>;
-	status = "okay";
-};
-
-&can2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	status = "okay";
-};
-
-&ecspi1 {
-	cs-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	status = "okay";
-
-	eeprom@0 {
-		compatible = "anvo,anv32e61w", "atmel,at25";
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-		spi-cpha;
-		spi-cpol;
-		pagesize = <1>;
-		size = <8192>;
-		address-width = <16>;
-	};
-};
-
-&fec1 {
-	pinctrl-0 = <&pinctrl_enet1>;
-	/delete-node/ mdio;
-};
-
-&fec2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy2>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			micrel,led-mode = <0>;
-			clocks = <&clks IMX6UL_CLK_ENET_REF>;
-			clock-names = "rmii-ref";
-		};
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			micrel,led-mode = <0>;
-			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
-			clock-names = "rmii-ref";
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	rtc@32 {
-		compatible = "epson,rx8900";
-		reg = <0x32>;
-	};
-};
-
-&pwm8 {
-	#pwm-cells = <2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm8>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	linux,rs485-enabled-at-boot-time;
-	rs485-rx-during-tx;
-	rs485-rts-active-low;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg1>;
-	dr_mode = "otg";
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	over-current-active-low;
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	disable-over-current;
-	vbus-supply = <&reg_5v>;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&reg_3v3>;
-	voltage-ranges = <3300 3300>;
-	no-1-8-v;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	non-removable;
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&reg_3v3>;
-	voltage-ranges = <3300 3300>;
-	no-1-8-v;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-0 = <&pinctrl_reset_out &pinctrl_gpio>;
-
-	pinctrl_adc1: adc1grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
-			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
-			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0xb0
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO	0x100b1
-			MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI	0x100b1
-			MX6UL_PAD_CSI_DATA04__ECSPI1_SCLK	0x100b1
-			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x100b1	/* ECSPI1-CS1 */
-		>;
-	};
-
-	pinctrl_enet2: enet2grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b009
-		>;
-	};
-
-	pinctrl_enet2_mdio: enet2mdiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp{
-		fsl,pins = <
-			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
-			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
-		>;
-	};
-
-	pinctrl_gpio: gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0	/* DOUT1 */
-			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* DIN1 */
-			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0	/* DOUT2 */
-			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0	/* DIN2 */
-		>;
-	};
-
-	pinctrl_gpio_leds: gpioledsgrp {
-		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x1b0b0	/* LED H14 */
-			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0	/* LED H15 */
-			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* LED H16 */
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
-			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX6UL_PAD_UART2_TX_DATA__I2C4_SCL	0x4001f8b0
-			MX6UL_PAD_UART2_RX_DATA__I2C4_SDA	0x4001f8b0
-		>;
-	};
-
-	pinctrl_pwm8: pwm8grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_HSYNC__PWM8_OUT		0x110b0
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_DATA04__UART2_DCE_TX	0x1b0b1
-			MX6UL_PAD_NAND_DATA05__UART2_DCE_RX	0x1b0b1
-			MX6UL_PAD_NAND_DATA06__UART2_DCE_CTS	0x1b0b1
-			/*
-			 * mux unused RTS to make sure it doesn't cause
-			 * any interrupts when it is undefined
-			 */
-			MX6UL_PAD_NAND_DATA07__UART2_DCE_RTS	0x1b0b1
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
-			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
-			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
-		>;
-	};
-
-	pinctrl_usbotg1: usbotg1 {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1b0b0
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
-			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x100b1	/* SD1_CD */
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10059
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6ul-kontron-bl.dts b/arch/arm/dts/imx6ul-kontron-bl.dts
deleted file mode 100644
index dadf6d3d5f5..00000000000
--- a/arch/arm/dts/imx6ul-kontron-bl.dts
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-/dts-v1/;
-
-#include "imx6ul-kontron-sl.dtsi"
-#include "imx6ul-kontron-bl-common.dtsi"
-
-/ {
-	model = "Kontron BL i.MX6UL (N631X S)";
-	compatible = "kontron,bl-imx6ul", "kontron,sl-imx6ul", "fsl,imx6ul";
-};
diff --git a/arch/arm/dts/imx6ul-kontron-sl-common.dtsi b/arch/arm/dts/imx6ul-kontron-sl-common.dtsi
deleted file mode 100644
index dcf88f61034..00000000000
--- a/arch/arm/dts/imx6ul-kontron-sl-common.dtsi
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	memory@80000000 {
-		reg = <0x80000000 0x10000000>;
-		device_type = "memory";
-	};
-};
-
-&ecspi2 {
-	cs-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			micrel,led-mode = <0>;
-			clocks = <&clks IMX6UL_CLK_ENET_REF>;
-			clock-names = "rmii-ref";
-		};
-	};
-};
-
-&fec2 {
-	phy-mode = "rmii";
-	status = "disabled";
-};
-
-&qspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi>;
-	status = "okay";
-
-	spi-flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <104000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-	};
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_out>;
-
-	pinctrl_ecspi2: ecspi2grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA03__ECSPI2_MISO      0x100b1
-			MX6UL_PAD_CSI_DATA02__ECSPI2_MOSI      0x100b1
-			MX6UL_PAD_CSI_DATA00__ECSPI2_SCLK      0x100b1
-			MX6UL_PAD_CSI_DATA01__GPIO4_IO22       0x100b1
-		>;
-	};
-
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN      0x1b0b0
-			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER      0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00 0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01 0x1b0b0
-			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN      0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00 0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01 0x1b0b0
-			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1  0x4001b009
-		>;
-	};
-
-	pinctrl_enet1_mdio: enet1mdiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET1_MDC         0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO        0x1b0b0
-		>;
-	};
-
-	pinctrl_qspi: qspigrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK        0x70a1
-			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00   0x70a1
-			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01     0x70a1
-			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02     0x70a1
-			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03       0x70a1
-			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B        0x70a1
-		>;
-	};
-
-	pinctrl_reset_out: rstoutgrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x1b0b0
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO09__WDOG1_WDOG_ANY    0x18b0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6ul-kontron-sl.dtsi b/arch/arm/dts/imx6ul-kontron-sl.dtsi
deleted file mode 100644
index 0580d043e5a..00000000000
--- a/arch/arm/dts/imx6ul-kontron-sl.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include "imx6ul.dtsi"
-#include "imx6ul-kontron-sl-common.dtsi"
-
-/ {
-	model = "Kontron SL i.MX6UL (N631X SOM)";
-	compatible = "kontron,sl-imx6ul", "fsl,imx6ul";
-};
diff --git a/arch/arm/dts/imx6ull-kontron-bl.dts b/arch/arm/dts/imx6ull-kontron-bl.dts
deleted file mode 100644
index fa016465cdb..00000000000
--- a/arch/arm/dts/imx6ull-kontron-bl.dts
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2019 Kontron Electronics GmbH
- */
-
-/dts-v1/;
-
-#include "imx6ull-kontron-sl.dtsi"
-#include "imx6ul-kontron-bl-common.dtsi"
-
-/ {
-	model = "Kontron BL i.MX6ULL (N641X S)";
-	compatible = "kontron,bl-imx6ull", "kontron,sl-imx6ull", "fsl,imx6ull";
-};
diff --git a/arch/arm/dts/imx6ull-kontron-sl.dtsi b/arch/arm/dts/imx6ull-kontron-sl.dtsi
deleted file mode 100644
index 93f10eb3494..00000000000
--- a/arch/arm/dts/imx6ull-kontron-sl.dtsi
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-#include "imx6ull.dtsi"
-#include "imx6ul-kontron-sl-common.dtsi"
-
-/ {
-	model = "Kontron SL i.MX6ULL (N641X SOM)";
-	compatible = "kontron,sl-imx6ull", "fsl,imx6ull";
-};
diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 052d7a76610..8e35d894dae 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -13,7 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_MX6UL=y
 CONFIG_TARGET_KONTRON_MX6UL=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6ul-kontron-bl"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-kontron-bl"
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
@@ -62,7 +62,8 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi1.0:960k(u-boot),32k(env),32k(env_redundant
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="imx6ul-kontron-bl imx6ull-kontron-bl"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="nxp/imx/imx6ul-kontron-bl nxp/imx/imx6ull-kontron-bl"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
-- 
2.50.1

