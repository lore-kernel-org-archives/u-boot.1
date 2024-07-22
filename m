Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19B5C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 01:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E9A88001;
	Mon, 22 Jul 2024 03:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YnyrWF9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0254187919; Mon, 22 Jul 2024 03:33:55 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349C68808B
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2cb5eafd585so587888a91.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721612031; x=1722216831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQH2y6TI1uKcvidv8bU6nB1iJ6YtcqiGCCnrwupKeB0=;
 b=YnyrWF9aoh3p2JD7jKrwmSR0YNbn1/PrM2vJRY9mkNF3xsmuw/AssLP+nKXjPhrufR
 HpcwWfTJfqiDnj1Tunxwo0rv8UghjdsFvVr7UhsFirJNeJ6Cxu40mx0EtZ4ANog+Kisz
 1ucxuyVYHY0fcCrqEu0ddSARYd9JYhUbt6MrdGdeCuLihkKj5YP71OssRnC2l45nSGUH
 zXHxC6aWLXL1zBVXAUGBRN6N9DFE1L9Ga4Tz2iDd5KisKg8b1UeQQfNRw9dwlPbSzkbW
 jpyFtawfdA3TnaPd0c7ra0J1AAzExeWEiU4nTp5zELkdQDV37LebLmjjFTpmrPo+pkmc
 Symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721612031; x=1722216831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQH2y6TI1uKcvidv8bU6nB1iJ6YtcqiGCCnrwupKeB0=;
 b=KEOUfKtt9u29ufu2i04K2MHQeQuRK1YAj8teBbEOswsb1ApQF2JM8MXQtOyMxkmQVn
 BoJe0tsH9P49p1jJ5gobEsgrf25gKSV1xEkbOsMYHaNVTSmAfGXcTP9zzP3o5Pdz0YGR
 fUc6PWi7cUUV5pVOkXlrjvYe3UF2WoRVt3BmYjI+uUY+dadk0dW2jvCG2KXvF+uf0rnf
 iD/eTKlLiBiFQjqXV/DI8c3JHbsvqwbwjih64bN8zzWD5akKDyv2c0V7Un7VBnHTfar3
 G3uKxtGjzWpIkaJiKkKZuHoyjySMVtz/qzFVZJxoTOrYxD38Cf7/UY+6dDOSYjZi0v9g
 hXwA==
X-Gm-Message-State: AOJu0YxWA2kbu+2iU4Z8ksCR5StE5zDH3ItkPi5EqRWfvAedvTUND6PQ
 5NhrY6CKQCI8k1O+lIm2VjUSCN8dqGbL1VD8k6Grmbh8p5xk4U54/FMTQg==
X-Google-Smtp-Source: AGHT+IHJ3+cD1OOzREJmzyglMU3ZxlDuooi6h+7OryQKmfL4k+gKRxG5nwrQBA2vH45L2h82NQcztA==
X-Received: by 2002:a17:902:d2cc:b0:1fa:ab25:f634 with SMTP id
 d9443c01a7336-1fd745601a8mr54928225ad.3.1721612030498; 
 Sun, 21 Jul 2024 18:33:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2ff7:142d:3c92:ec97])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f430b01sm42579765ad.187.2024.07.21.18.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 18:33:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: u-boot@lists.denx.de,
	boot-imx@nxp.com
Subject: [PATCH] warp7: Convert to OF_UPSTREAM
Date: Sun, 21 Jul 2024 22:33:34 -0300
Message-Id: <20240722013334.1940598-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Instead of using the local imx7s-warp devicetree copies from U-Boot,
convert the imx7s-warp board to OF_UPSTREAM so that the upstream
kernel devicetree can be used instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/Makefile         |   1 -
 arch/arm/dts/imx7s-warp.dts   | 500 ----------------------------------
 arch/arm/mach-imx/mx7/Kconfig |   1 +
 configs/warp7_defconfig       |   2 +-
 4 files changed, 2 insertions(+), 502 deletions(-)
 delete mode 100644 arch/arm/dts/imx7s-warp.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7265e5542574..7e17edf21889 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -886,7 +886,6 @@ dtb-$(CONFIG_MX7) += imx7d-sdb.dtb \
 	imx7-cm.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
-	imx7s-warp.dtb \
 	imx7d-meerkat96.dtb \
 	imx7d-pico-pi.dtb \
 	imx7d-pico-hobbit.dtb \
diff --git a/arch/arm/dts/imx7s-warp.dts b/arch/arm/dts/imx7s-warp.dts
deleted file mode 100644
index e8734d218b9d..000000000000
--- a/arch/arm/dts/imx7s-warp.dts
+++ /dev/null
@@ -1,500 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2016 NXP Semiconductors.
- * Author: Fabio Estevam <fabio.estevam@nxp.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/input/input.h>
-#include "imx7s.dtsi"
-
-/ {
-	model = "Element14 Warp i.MX7 Board";
-	compatible = "element14,imx7s-warp", "fsl,imx7s";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-0 = <&pinctrl_gpio>;
-		autorepeat;
-
-		back {
-			label = "Back";
-			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_BACK>;
-			wakeup-source;
-		};
-	};
-
-	reg_brcm: regulator-brcm {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_brcm_reg>;
-		regulator-name = "brcm_reg";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <200000>;
-	};
-
-	reg_bt: regulator-bt {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bt_reg>;
-		enable-active-high;
-		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
-		regulator-name = "bt_reg";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	reg_peri_3p15v: regulator-peri-3p15v {
-		compatible = "regulator-fixed";
-		regulator-name = "peri_3p15v_reg";
-		regulator-min-microvolt = <3150000>;
-		regulator-max-microvolt = <3150000>;
-		regulator-always-on;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "imx7-sgtl5000";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&dailink_master>;
-		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,cpu {
-			sound-dai = <&sai1>;
-		};
-
-		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
-		};
-	};
-};
-
-&clks {
-	assigned-clocks = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
-	assigned-clock-rates = <884736000>;
-};
-
-&csi {
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic: pfuze3000@8 {
-		compatible = "fsl,pfuze3000";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1a {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			/* use sw1c_reg to align with pfuze100/pfuze200 */
-			sw1c_reg: sw1b {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1850000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1650000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vldo1 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen2_reg: vldo2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vccsd {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: v33 {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	ov2680: camera@36 {
-		compatible = "ovti,ov2680";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ov2680>;
-		reg = <0x36>;
-		clocks = <&osc>;
-		clock-names = "xvclk";
-		reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
-		DOVDD-supply = <&sw2_reg>;
-		DVDD-supply = <&sw2_reg>;
-		AVDD-supply = <&reg_peri_3p15v>;
-
-		port {
-			ov2680_to_mipi: endpoint {
-				remote-endpoint = <&mipi_from_sensor>;
-				clock-lanes = <0>;
-				data-lanes = <1>;
-			};
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	codec: sgtl5000@a {
-		#sound-dai-cells = <0>;
-		reg = <0x0a>;
-		compatible = "fsl,sgtl5000";
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sai1_mclk>;
-		VDDA-supply = <&vgen4_reg>;
-		VDDIO-supply = <&vgen4_reg>;
-		VDDD-supply = <&vgen2_reg>;
-	};
-
-	mpl3115@60 {
-		compatible = "fsl,mpl3115";
-		reg = <0x60>;
-	};
-};
-
-&mipi_csi {
-	clock-frequency = <166000000>;
-	status = "okay";
-
-	ports {
-		port@0 {
-			reg = <0>;
-
-			mipi_from_sensor: endpoint {
-				remote-endpoint = <&ov2680_to_mipi>;
-				data-lanes = <1>;
-			};
-		};
-	};
-};
-
-&sai1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai1>;
-	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
-			  <&clks IMX7D_SAI1_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
-	assigned-clock-rates = <0>, <36864000>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	status = "okay";
-};
-
-&uart3  {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart6>;
-	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	fsl,dte-mode;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	bus-width = <4>;
-	keep-power-in-suspend;
-	no-1-8-v;
-	non-removable;
-	vmmc-supply = <&reg_brcm>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
-	assigned-clock-rates = <400000000>;
-	bus-width = <8>;
-	no-1-8-v;
-	fsl,tuning-step = <2>;
-	non-removable;
-	status = "okay";
-};
-
-&video_mux {
-	status = "okay";
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
-	pinctrl_brcm_reg: brcmreggrp {
-		fsl,pins = <
-			MX7D_PAD_SD2_WP__GPIO5_IO10	0x14 /* WL_REG_ON */
-		>;
-	};
-
-	pinctrl_bt_reg: btreggrp {
-		fsl,pins = <
-			MX7D_PAD_SD2_DATA3__GPIO5_IO17	0x14 /* BT_REG_ON */
-		>;
-	};
-
-	pinctrl_gpio: gpiogrp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1	0x14
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
-			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__I2C2_SDA	0x4000007f
-			MX7D_PAD_I2C2_SCL__I2C2_SCL	0x4000007f
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX7D_PAD_I2C3_SDA__I2C3_SDA	0x4000007f
-			MX7D_PAD_I2C3_SCL__I2C3_SCL	0x4000007f
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
-			MX7D_PAD_I2C4_SDA__I2C4_SDA	0x4000007f
-		>;
-	};
-
-	pinctrl_ov2680: ov2660grp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x14
-		>;
-	};
-
-	pinctrl_sai1: sai1grp {
-		fsl,pins = <
-			MX7D_PAD_SAI1_RX_DATA__SAI1_RX_DATA0	0x1f
-			MX7D_PAD_SAI1_TX_BCLK__SAI1_TX_BCLK	0x1f
-			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
-			MX7D_PAD_SAI1_TX_DATA__SAI1_TX_DATA0	0x30
-		>;
-	};
-
-	pinctrl_sai1_mclk: sai1mclkgrp {
-		fsl,pins = <
-			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-			MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX	0x79
-			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX	0x79
-			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS	0x79
-			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS	0x79
-		>;
-	};
-
-	pinctrl_uart6: uart6grp {
-		fsl,pins = <
-			MX7D_PAD_ECSPI1_MOSI__UART6_DTE_RX	0x79
-			MX7D_PAD_ECSPI1_SCLK__UART6_DTE_TX	0x79
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
-			MX7D_PAD_SD1_CLK__SD1_CLK	0x19
-			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
-			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
-			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
-			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
-			MX7D_PAD_SD2_RESET_B__GPIO5_IO11 0x14 /* WL_HOST_WAKE */
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
-			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
-			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
-			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
-			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
-			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
-			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
-			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
-			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
-			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x19
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
-		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
-			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
-			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
-			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
-			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
-			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
-			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
-			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
-			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
-			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
-			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x1a
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
-		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
-			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
-			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
-			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
-			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
-			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
-			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
-			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
-			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
-			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
-			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x1b
-		>;
-	};
-};
-
-&iomuxc_lpsr {
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/mx7/Kconfig b/arch/arm/mach-imx/mx7/Kconfig
index 3c0208e13dda..2e68557d6a90 100644
--- a/arch/arm/mach-imx/mx7/Kconfig
+++ b/arch/arm/mach-imx/mx7/Kconfig
@@ -87,6 +87,7 @@ config TARGET_WARP7
 	select DM_THERMAL
 	select MX7D
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 config TARGET_COLIBRI_IMX7
 	bool "Support Colibri iMX7S/iMX7D modules"
diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig
index 48042b702c22..679b6e8997ee 100644
--- a/configs/warp7_defconfig
+++ b/configs/warp7_defconfig
@@ -5,7 +5,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx7s-warp"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7s-warp"
 CONFIG_TARGET_WARP7=y
 CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 # CONFIG_ARMV7_VIRT is not set
-- 
2.34.1

