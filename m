Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724AFCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799B784A36;
	Mon,  1 Jun 2026 14:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="lwgLIfHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2CB84837; Mon,  1 Jun 2026 11:32:46 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D53E84859
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso1631364f8f.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306363; x=1780911163; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VNbzYAG/3ZZYra4xK/5siBwJa9f36rT1PDgyMWAceQ8=;
 b=lwgLIfHCbAwxeG1bFTCBHEcD3kk9HCg4grXASXdc23I9Im0yJ0l9YgcbqJqmhJlA3K
 iwIhAv5H2NvTnN/dxBUz6Vd4Mt55wGid+/DeG+BW9tg0KIRhrXOMAhmyO/IqkZN/lvdQ
 NUFU4QDRA78wLvjlNnTW7anSMUx4WYRwDzgzF/Tm91wwLBdLkc4rVtQKNGaXfOazde1N
 mvqAbpkBwHJMjIxXor/N4isADffRvNbJU0z1J85eW7CkbvogvbeDG4+iRJdH7BBzbazP
 H2TG/8BvCXBfl5/H0HCGBNzT4y1Bnahy4N7g7gD5uD4gUlZiJwxDDCN6MzlG3eP8PYgm
 o2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306363; x=1780911163;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VNbzYAG/3ZZYra4xK/5siBwJa9f36rT1PDgyMWAceQ8=;
 b=aJfnIbTb+nLpQ/7QhT0PlRQHJuQ5+BOEOX17U4SkVG7o9eDGvEJArWRqltbownyJ8X
 3XAMQMDQBtgZ8lAm35DQP4yrSqTTfR60lavTBtyzJQQa03/J8WSpQKC/RP9aEijCJQ9r
 XrSXwsmARisrKtioGnUHpCjd2vl/oYy7bU44Oj3/TqVl+zd60Q1tJqOQp1BGEIn+vBD5
 6qG0IO6a5NVMqCUdV4czQnEwwdxKaf6aZNqECNm0ZhgXMX4dNSuVesGev0KNwtsK7B70
 Q6I1UtqEE2J29lfraE6e05OA/VWMoznhnazyHAqzPYk1APGXtdsi2GjUt6nIaxL7wTsf
 xJmw==
X-Gm-Message-State: AOJu0YwsIl8TDlC0Ulhjt2GlGePnPzh6BIOfh4Hs4dZE3SgfeOWAcb1r
 4iN/pGwsc65xcQhQVZDSw2vrHwIa8LX+cQho99tUnKAWbuPMqNKXlSiVoXvF45scM9M=
X-Gm-Gg: Acq92OE8ZLb0lbnwygkiB6TM5hY6jCLnlvmU+6rGW3hznOahzPNNsBiClZvqdgPdF74
 yD5FUOfyl8FRiCyW0wqP1/m3LYQLww4EjGUndtSnXOT17w6+xAhCOUqWQtW+Vqs65rTKg+hDTSf
 RtvHH6iEQSHwSrg0d0ex63nXIX1lKTEHxoJObTH5IVhR2ajY4op8uJb3atFVNvNqmv3kZsKMrZv
 k9gaA98p7WpZg7rADaXn3RzZrjzSVFZbkZjIY8nNT1dMe3iADmyCnL1rUch6A3IroLlt47/NE8l
 rQzkkXl3J4rXs7M6pBeqpBJFAbdIzkH2woin0KYwEEyHhLt2flkGvEYdOBz6JiLkhaNwxVts9Bw
 MBj3cdEw3+Bl17BkWpvJvIVd7c41TzhjVV4LMzgZZMjo0gOnj5CuYj0Dq2wAYjKpT6mWOTTHnNW
 Da1pMoUy5iMbD3c2zRfr2ijHVBbxlmgwo=
X-Received: by 2002:a05:6000:4685:b0:43d:2be:e54 with SMTP id
 ffacd0b85a97d-45ef6bad806mr10549882f8f.39.1780306362587; 
 Mon, 01 Jun 2026 02:32:42 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef357635fsm22917649f8f.33.2026.06.01.02.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:42 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:52 +0200
Subject: [PATCH v8 17/17] arm: dts: Move remaining am335x-bone* to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-17-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=29926; i=msp@baylibre.com;
 h=from:subject:message-id; bh=27H59BHsgfMuNJgx3pSxpit6NvX+GusXeKCfB3zh7Z4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwJkebcwB7lbP/mXa+AiwuahEFP/LOBHanHrQcsm/z
 W8T3y7qKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgImcmMvI0F94eRqT+tK6xKf2
 39Y+zT2+Suote93Wt9vX+gd1cbcm8zL80/l2hs1187Pg7a92RxZoG+Ts/7G/Yk177nSDhMSVwWv
 3cgEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

These boards are not yet in the CONFIG_OF_LIST of the defconfigs, add
them and remove the local devicetrees.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/Makefile                      |   3 -
 arch/arm/dts/am335x-boneblack-wireless.dts | 111 ------
 arch/arm/dts/am335x-boneblue.dts           | 617 -----------------------------
 arch/arm/dts/am335x-bonegreen-wireless.dts | 127 ------
 configs/am335x_evm_defconfig               |   2 +-
 configs/am335x_evm_spiboot_defconfig       |   2 +-
 configs/am335x_hs_evm.config               |   2 +-
 7 files changed, 3 insertions(+), 861 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2f295680748e1afe7bdacf6c2ced9e9542d47e09..416103d7d59c1883201bf9f3be0d7ba83a934a67 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -396,13 +396,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP_R5) += \
 	zynqmp-r5.dtb
 dtb-$(CONFIG_AM33XX) += \
 	am335x-baltos.dtb \
-	am335x-boneblack-wireless.dtb \
-	am335x-boneblue.dtb \
 	am335x-brppt1-mmc.dtb \
 	am335x-brxre1.dtb \
 	am335x-brsmarc1.dtb \
 	am335x-draco.dtb \
-	am335x-bonegreen-wireless.dtb \
 	am335x-pxm50.dtb \
 	am335x-rut.dtb \
 	am335x-shc.dtb \
diff --git a/arch/arm/dts/am335x-boneblack-wireless.dts b/arch/arm/dts/am335x-boneblack-wireless.dts
deleted file mode 100644
index afa4fdc5dd2fdd3c8bcb61caad4eb96f9e9a48b0..0000000000000000000000000000000000000000
--- a/arch/arm/dts/am335x-boneblack-wireless.dts
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "am33xx.dtsi"
-#include "am335x-bone-common.dtsi"
-#include "am335x-boneblack-common.dtsi"
-#include "am335x-boneblack-hdmi.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "TI AM335x BeagleBone Black Wireless";
-	compatible = "ti,am335x-bone-black-wireless", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
-
-	wlan_en_reg: fixedregulator@2 {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		startup-delay-us = <70000>;
-
-		/* WL_EN */
-		gpio = <&gpio3 9 0>;
-		enable-active-high;
-	};
-};
-
-&am33xx_pinmux {
-	bt_pins: pinmux_bt_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gmii1_txd0.gpio0_28 - BT_EN */
-		>;
-	};
-
-	mmc3_pins: pinmux_mmc3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE6 ) /* (L15) gmii1_rxd1.mmc2_clk */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLUP, MUX_MODE6 ) /* (J16) gmii1_txen.mmc2_cmd */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (J17) gmii1_rxdv.mmc2_dat0 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (J18) gmii1_txd3.mmc2_dat1 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (K15) gmii1_txd2.mmc2_dat2 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE5 ) /* (H16) gmii1_col.mmc2_dat3 */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
-		>;
-	};
-
-	wl18xx_pins: pinmux_wl18xx_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gmii1_txclk.gpio3_9 WL_EN */
-			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* rmii1_refclk.gpio0_29 WL_IRQ */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gmii1_rxclk.gpio3_10 LS_BUF_EN */
-		>;
-	};
-};
-
-&mac {
-	status = "disabled";
-};
-
-&mmc3 {
-	dmas = <&edma_xbar 12 0 1
-		&edma_xbar 13 0 2>;
-	dma-names = "tx", "rx";
-	status = "okay";
-	vmmc-supply = <&wlan_en_reg>;
-	bus-width = <4>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1835";
-		reg = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <29 IRQ_TYPE_EDGE_RISING>;
-	};
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins &bt_pins>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "ti,wl1835-st";
-		enable-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&gpio3 {
-	ls-buf-en-hog {
-		gpio-hog;
-		gpios = <10 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "LS_BUF_EN";
-	};
-};
diff --git a/arch/arm/dts/am335x-boneblue.dts b/arch/arm/dts/am335x-boneblue.dts
deleted file mode 100644
index f04f46d6e5e5dbe1f45a2cfa8e6edb7b73325320..0000000000000000000000000000000000000000
--- a/arch/arm/dts/am335x-boneblue.dts
+++ /dev/null
@@ -1,617 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "am33xx.dtsi"
-#include "am335x-osd335x-common.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "TI AM335x BeagleBone Blue";
-	compatible = "ti,am335x-bone-blue", "ti,am33xx";
-
-	chosen {
-		stdout-path = &uart0;
-		tick-timer = &timer2;
-	};
-
-	leds {
-		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
-
-		compatible = "gpio-leds";
-
-		usr_0_led {
-			label = "beaglebone:green:usr0";
-			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			default-state = "off";
-		};
-
-		usr_1_led {
-			label = "beaglebone:green:usr1";
-			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-			default-state = "off";
-		};
-
-		usr_2_led {
-			label = "beaglebone:green:usr2";
-			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "cpu0";
-			default-state = "off";
-		};
-
-		usr_3_led {
-			label = "beaglebone:green:usr3";
-			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-			default-state = "off";
-		};
-
-		wifi_led {
-			label = "wifi";
-			gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "phy0assoc";
-		};
-
-		red_led {
-			label = "red";
-			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		green_led {
-			label = "green";
-			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		batt_1_led {
-			label = "bat25";
-			gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		batt_2_led {
-			label = "bat50";
-			gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		batt_3_led {
-			label = "bat75";
-			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		batt_4_led {
-			label = "bat100";
-			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-	};
-
-	vmmcsd_fixed: fixedregulator0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmcsd_fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	wlan_en_reg: fixedregulator@2 {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		startup-delay-us = <70000>;
-
-		/* WL_EN */
-		gpio = <&gpio3 9 0>;
-		enable-active-high;
-	};
-};
-
-&am33xx_pinmux {
-	user_leds_s0: user_leds_s0 {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] - USR_LED_0 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_OUTPUT, MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] - USR_LED_1 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_OUTPUT, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] - USR_LED_2 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_OUTPUT, MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] - USR_LED_3 */
-			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] - WIFI_LED */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] - P8.7, LED_RED, GP1_PIN_5 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] - P8.8, LED_GREEN, GP1_PIN_6 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] - P8.17, BATT_LED_1 */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE7) /* (T5) lcd_data15.gpio0[11] - P8.32, BATT_LED_2 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] - P8.26, BATT_LED_3 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] - P8.14, BATT_LED_4 */
-
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D18) uart1_ctsn.I2C2_SDA */
-			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* (D17) uart1_rtsn.I2C2_SCL */
-		>;
-	};
-
-	/* UT0 */
-	uart0_pins: pinmux_uart0_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
-			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
-		>;
-	};
-
-	/* UT1 */
-	uart1_pins: pinmux_uart1_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
-			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
-		>;
-	};
-
-	/* GPS */
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE1)	/* (A17) spi0_sclk.uart2_rxd */
-			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (B17) spi0_d0.uart2_txd */
-		>;
-	};
-
-	/* DSM2 */
-	uart4_pins: pinmux_uart4_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)	/* (T17) gpmc_wait0.uart4_rxd */
-		>;
-	};
-
-	/* UT5 */
-	uart5_pins: pinmux_uart5_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_INPUT_PULLUP, MUX_MODE4)	/* (U2) lcd_data9.uart5_rxd */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT_PULLDOWN, MUX_MODE4)	/* (U1) lcd_data8.uart5_txd */
-		>;
-	};
-
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
-		>;
-	};
-
-	mmc2_pins: pinmux_mmc2_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* (U9) gpmc_csn1.mmc1_clk */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* (V9) gpmc_csn2.mmc1_cmd */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U7) gpmc_ad0.mmc1_dat0 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V7) gpmc_ad1.mmc1_dat1 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R8) gpmc_ad2.mmc1_dat2 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T8) gpmc_ad3.mmc1_dat3 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* (U8) gpmc_ad4.mmc1_dat4 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* (V8) gpmc_ad5.mmc1_dat5 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* (R9) gpmc_ad6.mmc1_dat6 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* (T9) gpmc_ad7.mmc1_dat7 */
-		>;
-	};
-
-	mmc3_pins: pinmux_mmc3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE6)	/* (L15) gmii1_rxd1.mmc2_clk */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLUP, MUX_MODE6)	/* (J16) gmii1_txen.mmc2_cmd */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J17) gmii1_rxdv.mmc2_dat0 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLUP, MUX_MODE5)	/* (J18) gmii1_txd3.mmc2_dat1 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLUP, MUX_MODE5)	/* (K15) gmii1_txd2.mmc2_dat2 */
-			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE5)	/* (H16) gmii1_col.mmc2_dat3 */
-		>;
-	};
-
-	bt_pins: pinmux_bt_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (K17) gmii1_txd0.gpio0[28] - BT_EN */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
-			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* (M17) mdio_data.uart3_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* (M18) mdio_clk.uart3_rtsn */
-		>;
-	};
-
-	wl18xx_pins: pinmux_wl18xx_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
-			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
-		>;
-	};
-
-	/* DCAN */
-	dcan1_pins: pinmux_dcan1_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT, MUX_MODE2)		/* (E17) uart0_rtsn.dcan1_rx */
-			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT, MUX_MODE2)		/* (E18) uart0_ctsn.dcan1_tx */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_OUTPUT, MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
-		>;
-	};
-
-	/* E1 */
-	eqep0_pins: pinmux_eqep0_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT, MUX_MODE1)		/* (B12) mcasp0_aclkr.eQEP0A_in */
-			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_INPUT, MUX_MODE1)		/* (C13) mcasp0_fsr.eQEP0B_in */
-		>;
-	};
-
-	/* E2 */
-	eqep1_pins: pinmux_eqep1_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT, MUX_MODE2)		/* (V2) lcd_data12.eQEP1A_in */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_INPUT, MUX_MODE2)		/* (V3) lcd_data13.eQEP1B_in */
-		>;
-	};
-
-	/* E3 */
-	eqep2_pins: pinmux_eqep2_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT, MUX_MODE4)		/* (T12) gpmc_ad12.eQEP2A_in */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT, MUX_MODE4)		/* (R12) gpmc_ad13.eQEP2B_in */
-		>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
-
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart4_pins>;
-
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart5_pins>;
-
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "peripheral";
-	interrupts-extended = <&intc 18 &tps 0>;
-	interrupt-names = "mc", "vbus";
-};
-
-&usb1 {
-	dr_mode = "host";
-};
-
-&i2c0 {
-	baseboard_eeprom: baseboard_eeprom@50 {
-		compatible = "atmel,24c256";
-		reg = <0x50>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		baseboard_data: baseboard_data@0 {
-			reg = <0 0x100>;
-		};
-	};
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	mpu9250@68 {
-		compatible = "invensense,mpu9250";
-		reg = <0x68>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
-		i2c-gate {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			ax8975@c {
-				compatible = "asahi-kasei,ak8975";
-				reg = <0x0c>;
-			};
-		};
-	};
-
-	pressure@76 {
-		compatible = "bosch,bmp280";
-		reg = <0x76>;
-	};
-};
-
-/include/ "tps65217.dtsi"
-
-&tps {
-	/delete-property/ ti,pmic-shutdown-controller;
-
-	charger {
-		interrupts = <0>, <1>;
-		interrupt-names = "USB", "AC";
-		status = "okay";
-	};
-};
-
-&mmc1 {
-	status = "okay";
-	vmmc-supply = <&vmmcsd_fixed>;
-	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-};
-
-&mmc2 {
-	status = "okay";
-	vmmc-supply = <&vmmcsd_fixed>;
-	bus-width = <8>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
-};
-
-&mmc3 {
-	dmas = <&edma_xbar 12 0 1
-		&edma_xbar 13 0 2>;
-	dma-names = "tx", "rx";
-	status = "okay";
-	vmmc-supply = <&wlan_en_reg>;
-	bus-width = <4>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1835";
-		reg = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
-	};
-};
-
-&tscadc {
-	status = "okay";
-	adc {
-		ti,adc-channels = <0 1 2 3 4 5 6 7>;
-	};
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins &bt_pins>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "ti,wl1835-st";
-		enable-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&rtc {
-	system-power-controller;
-	clocks = <&clk_32768_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
-	clock-names = "ext-clk", "int-clk";
-};
-
-&dcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&dcan1_pins>;
-	status = "okay";
-};
-
-&gpio0 {
-	gpio-line-names =
-		"UART3_CTS", /* M17 */
-		"UART3_RTS", /* M18 */
-		"UART2_RX", /* A17 */
-		"UART2_TX", /* B17 */
-		"I2C1_SDA", /* B16 */
-		"I2C1_SCL", /* A16 */
-		"MMC0_CD", /* C15 */
-		"SPI1_SS2", /* C18 */
-		"EQEP_1A", /* V2 */
-		"EQEP_1B", /* V3 */
-		"MDIR_2B", /* V4 */
-		"BATT_LED_2", /* T5 */
-		"I2C2_SDA", /* D18 */
-		"I2C2_SCL", /* D17 */
-		"UART1_RX", /* D16 */
-		"UART1_TX", /* D15 */
-		"MMC2_DAT1", /* J18 */
-		"MMC2_DAT2", /* K15 */
-		"NC", /* F16 */
-		"WIFI_LED", /* A15 */
-		"MOT_STBY", /* D14 */
-		"WLAN_IRQ", /* K16 */
-		"PWM_2A", /* U10 */
-		"PWM_2B", /* T10 */
-		"",
-		"",
-		"BATT_LED_4", /* T11 */
-		"BATT_LED_1", /* U12 */
-		"BT_EN", /* K17 */
-		"SPI1_SS1", /* H18 */
-		"UART4_RX", /* T17 */
-		"MDIR_1B"; /* U17 */
-};
-
-&gpio1 {
-	gpio-line-names =
-		"MMC1_DAT0", /* U7 */
-		"MMC1_DAT1", /* V7 */
-		"MMC1_DAT2", /* R8 */
-		"MMC1_DAT3", /* T8 */
-		"MMC1_DAT4", /* U8 */
-		"MMC1_DAT5", /* V8 */
-		"MMC1_DAT6", /* R9 */
-		"MMC1_DAT7", /* T9 */
-		"DCAN1_TX", /* E18 */
-		"DCAN1_RX", /* E17 */
-		"UART0_RX", /* E15 */
-		"UART0_TX", /* E16 */
-		"EQEP_2A", /* T12 */
-		"EQEP_2B", /* R12 */
-		"PRU_E_A", /* V13 */
-		"PRU_E_B", /* U13 */
-		"MDIR_2A", /* R13 */
-		"GPIO1_17", /* V14 */
-		"PWM_1A", /* U14 */
-		"PWM_1B", /* T14 */
-		"EMMC_RST", /* R14 */
-		"USR_LED_0", /* V15 */
-		"USR_LED_1", /* U15 */
-		"USR_LED_2", /* T15 */
-		"USR_LED_3", /* V16 */
-		"GPIO1_25", /* U16 */
-		"MCASP0_AXR0", /* T16 */
-		"MCASP0_AXR1", /* V17 */
-		"MCASP0_ACLKR", /* U18 */
-		"BATT_LED_3", /* V6 */
-		"MMC1_CLK", /* U9 */
-		"MMC1_CMD"; /* V9 */
-};
-
-&gpio2 {
-	gpio-line-names =
-		"MDIR_1A", /* T13 */
-		"MCASP0_FSR", /* V12 */
-		"LED_RED", /* R7 */
-		"LED_GREEN", /* T7 */
-		"MODE_BTN", /* U6 */
-		"PAUSE_BTN", /* T6 */
-		"MDIR_4A", /* R1 */
-		"MDIR_4B", /* R2 */
-		"MDIR_3B", /* R3 */
-		"MDIR_3A", /* R4 */
-		"SVO7", /* T1 */
-		"SVO8", /* T2 */
-		"SVO5", /* T3 */
-		"SVO6", /* T4 */
-		"UART5_TX", /* U1 */
-		"UART5_RX", /* U2 */
-		"SERVO_EN", /* U3 */
-		"NC", /* U4 */
-		"UART3_RX", /* L17 */
-		"UART3_TX", /* L16 */
-		"MMC2_CLK", /* L15 */
-		"DCAN1_SILENT", /* M16 */
-		"SVO1", /* U5 */
-		"SVO3", /* R5 */
-		"SVO2", /* V5 */
-		"SVO4", /* R6 */
-		"MMC0_DAT3", /* F17 */
-		"MMC0_DAT2", /* F18 */
-		"MMC0_DAT1", /* G15 */
-		"MMC0_DAT0", /* G16 */
-		"MMC0_CLK", /* G17 */
-		"MMC0_CMD"; /* G18 */
-};
-
-&gpio3 {
-	gpio-line-names =
-		"MMC2_DAT3", /* H16 */
-		"GPIO3_1", /* H17 */
-		"GPIO3_2", /* J15 */
-		"MMC2_CMD", /* J16 */
-		"MMC2_DAT0", /* J17 */
-		"I2C0_SDA", /* C17 */
-		"I2C0_SCL", /* C16 */
-		"EMU1", /* C14 */
-		"EMU0", /* B14 */
-		"WL_EN", /* K18 */
-		"WL_BT_OE", /* L18 */
-		"",
-		"",
-		"NC", /* F15 */
-		"SPI1_SCK", /* A13 */
-		"SPI1_MISO", /* B13 */
-		"SPI1_MOSI", /* D12 */
-		"GPIO3_17", /* C12 */
-		"EQEP_0A", /* B12 */
-		"EQEP_0B", /* C13 */
-		"GPIO3_20", /* D13 */
-		"IMU_INT", /* A14 */
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"";
-
-	ls-buf-en-hog {
-		gpio-hog;
-		gpios = <10 GPIO_ACTIVE_HIGH>;
-		output-high;
-	};
-};
-
-&epwmss0 {
-	status = "okay";
-};
-
-&eqep0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&eqep0_pins>;
-	status = "okay";
-};
-
-&epwmss1 {
-	status = "okay";
-};
-
-&eqep1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&eqep1_pins>;
-	status = "okay";
-};
-
-&epwmss2 {
-	status = "okay";
-};
-
-&eqep2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&eqep2_pins>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/am335x-bonegreen-wireless.dts b/arch/arm/dts/am335x-bonegreen-wireless.dts
deleted file mode 100644
index b363d0324418f734d528fd83da7e6633f9be57b2..0000000000000000000000000000000000000000
--- a/arch/arm/dts/am335x-bonegreen-wireless.dts
+++ /dev/null
@@ -1,127 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "am33xx.dtsi"
-#include "am335x-bone-common.dtsi"
-#include "am335x-bonegreen-common.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "TI AM335x BeagleBone Green Wireless";
-	compatible = "ti,am335x-bone-green-wireless", "ti,am335x-bone-green", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
-
-	wlan_en_reg: fixedregulator@2 {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		startup-delay-us = <70000>;
-
-		/* WL_EN */
-		gpio = <&gpio0 26 0>;
-		enable-active-high;
-	};
-};
-
-&am33xx_pinmux {
-	bt_pins: pinmux_bt_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
-		>;
-	};
-
-	mmc3_pins: pinmux_mmc3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
-		>;
-	};
-
-	wl18xx_pins: pinmux_wl18xx_pins {
-		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
-			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
-		>;
-	};
-};
-
-&mac {
-	status = "disabled";
-};
-
-&mmc3 {
-	dmas = <&edma_xbar 12 0 1
-		&edma_xbar 13 0 2>;
-	dma-names = "tx", "rx";
-	status = "okay";
-	vmmc-supply = <&wlan_en_reg>;
-	bus-width = <4>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1835";
-		reg = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <27 IRQ_TYPE_EDGE_RISING>;
-	};
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins &bt_pins>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "ti,wl1835-st";
-		enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&gpio1 {
-	ls-buf-en-hog {
-		gpio-hog;
-		gpios = <29 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "LS_BUF_EN";
-	};
-};
-
-/* BT_AUD_OUT from wl1835 has to be pulled low when WL_EN is activated.*/
-/* in case it isn't, wilink8 ends up in one of the test modes that     */
-/* intruces various issues (elp wkaeup timeouts etc.)                  */
-/* On the BBGW this pin is routed through the level shifter (U21) that */
-/* introduces a pullup on the line and wilink8 ends up in a bad state. */
-/* use a gpio hog to force this pin low. An alternative may be adding  */
-/* an external pulldown on U21 pin 4.                                  */
-
-&gpio3 {
-	bt-aud-in-hog {
-		gpio-hog;
-		gpios = <16 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "MCASP0_AHCLKR";
-	};
-};
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 9281178f914085b199e3d35e95d0ce1f3c0faaa5..39bb17ed34dbfa6d7dd96ebdb6271f4c575941e0 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_SPL_NAND_OFS=0x00080000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-boneblack-wireless ti/omap/am335x-bonegreen ti/omap/am335x-bonegreen-wireless ti/omap/am335x-bonegreen-eco ti/omap/am335x-boneblue ti/omap/am335x-evmsk ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi"
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index bbaca6c8800baf19377a457e49db446159e338a8..e4866d74b3e16bf6a51d261d6ed99b0b03702b1e 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -12,7 +12,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-boneblack-wireless ti/omap/am335x-bonegreen ti/omap/am335x-bonegreen-wireless ti/omap/am335x-bonegreen-eco ti/omap/am335x-boneblue ti/omap/am335x-evmsk ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle"
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
index 0bc8556b1d4b18a413ecd6879ab85be54f2730ef..397040a83fc065a51e82af65b5a5e6c74f6e7de1 100644
--- a/configs/am335x_hs_evm.config
+++ b/configs/am335x_hs_evm.config
@@ -8,7 +8,7 @@ CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-boneblack-wireless ti/omap/am335x-bonegreen ti/omap/am335x-bonegreen-wireless ti/omap/am335x-bonegreen-eco ti/omap/am335x-boneblue ti/omap/am335x-evmsk ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle"
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_RSA=y

-- 
2.53.0

