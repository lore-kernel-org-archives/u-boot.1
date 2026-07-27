Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7736C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED7EE80E0D;
	Mon, 27 Jul 2026 12:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUN2xXhQbx39; Mon, 27 Jul 2026 12:06:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C30E080DFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153989;
	bh=rG7eEcwFvrhWMbSlZxkuFeWwV3eGrafRA5ecKLWx2PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sqJxapU4iRW4DxFdpcY8mKDxUIcvjDYlIreWSo5sw2p9ZQtTwjO0rfhtWbmomyBrn
	 6jpdhG+5N57x+l0Fo8q4VZJX4epRDjxMnRfxkq09pee6taTr9aVagRRkMimOK8CIie
	 zMnjxD0D9LrWGf68Sg9Yn7oSTs/9QwrFH6MsAiQkfQy0ibR7ZcbmxX4SEKRwHWpoGO
	 r/bd26VJoFWfi9ws/l/tMSJdgAwXsxUGnZYAD68u9+Wfli+Bbhy0bRNxnGrrAUvmd6
	 QtQoLP44S4dcK5fHi0h38ZIiTJEwvOGWOHm0UNyFXJQ3or8dXlfzqP9PZ7GX7ZORQg
	 8ZUZTOaPzwd7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C30E080DFE;
	Mon, 27 Jul 2026 12:06:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E56EA69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CADB240073
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-GBpk2296IT for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55DBA40065
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55DBA40065
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55DBA40065
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK65-000JMP-2w; Mon, 27 Jul 2026 14:06:17 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK65-000I7f-1y; Mon, 27 Jul 2026 14:06:17 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:17 +0200
Subject: [PATCH RESEND 3/6] dts: tqma6: mba6: remove old device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-3-27673934830f@ew.tq-group.com>
References: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
In-Reply-To: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rG7eEcwFvrhWMbSlZxkuFeWwV3eGrafRA5ecKLWx2PI=; b=qQJvvIWB0Fdevw+A7J78qewKch
 ABfCePsM+pePrf+KTb0GJMC8GTuGAVeTIuqKkAnTMbqngAY1tnMdBKxuNZOimqJDkNyAFMMa4DbYN
 MRnzSx4wK8JJ5ZMSdLM/f0ezbZkrZp0XpzzfUioA+H8PChS/qJ7qExXu9uMSnat/m+3keZgqyEk0c
 DpKucAF/khm1isSZRV1iD12Ees1c1LakG7Gu9GwCZwQCljpJRCAeQo88DKYu79KpiCjcVODiA/q64
 Hiok+fy6UvuFK/oD736bdYtkl+KfWOnrvt7Ud6fwRcxs1zdB82u5alA9ValMF24rzPj7xyPx2fGbN
 xQFr+IAQ==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qQJvvIWB
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

No longer required due to the use of upstream device trees.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6dl-mba6.dtsi   |  22 --
 arch/arm/dts/imx6dl-mba6a.dts   |  21 --
 arch/arm/dts/imx6q-mba6.dtsi    |  44 ----
 arch/arm/dts/imx6q-mba6a.dts    |  20 --
 arch/arm/dts/imx6qdl-mba6.dtsi  | 535 ----------------------------------------
 arch/arm/dts/imx6qdl-mba6a.dtsi |  30 ---
 arch/arm/dts/imx6qdl-mba6b.dtsi |  49 ----
 7 files changed, 721 deletions(-)

diff --git a/arch/arm/dts/imx6dl-mba6.dtsi b/arch/arm/dts/imx6dl-mba6.dtsi
deleted file mode 100644
index b749b424bbd..00000000000
--- a/arch/arm/dts/imx6dl-mba6.dtsi
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-&ethphy {
-	rxdv-skew-ps = <180>;
-	txen-skew-ps = <0>;
-	rxd3-skew-ps = <180>;
-	rxd2-skew-ps = <180>;
-	rxd1-skew-ps = <180>;
-	rxd0-skew-ps = <180>;
-	txd3-skew-ps = <120>;
-	txd2-skew-ps = <0>;
-	txd1-skew-ps = <300>;
-	txd0-skew-ps = <120>;
-	txc-skew-ps = <1860>;
-	rxc-skew-ps = <1860>;
-};
diff --git a/arch/arm/dts/imx6dl-mba6a.dts b/arch/arm/dts/imx6dl-mba6a.dts
deleted file mode 100644
index df0a96b28af..00000000000
--- a/arch/arm/dts/imx6dl-mba6a.dts
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include "imx6dl-tqma6a.dtsi"
-#include "imx6qdl-mba6.dtsi"
-#include "imx6qdl-mba6a.dtsi"
-#include "imx6dl-mba6.dtsi"
-
-/ {
-	model = "TQ TQMa6S/DL on MBa6x";
-	compatible = "tq,imx6dl-mba6x-a", "tq,mba6a",
-		     "tq,imx6dl-tqma6dl-a", "fsl,imx6dl";
-};
diff --git a/arch/arm/dts/imx6q-mba6.dtsi b/arch/arm/dts/imx6q-mba6.dtsi
deleted file mode 100644
index 0d7be456729..00000000000
--- a/arch/arm/dts/imx6q-mba6.dtsi
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-&ecspi5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi5_mba6x>;
-	cs-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
-};
-
-&ethphy {
-	rxdv-skew-ps = <180>;
-	txen-skew-ps = <120>;
-	rxd3-skew-ps = <180>;
-	rxd2-skew-ps = <180>;
-	rxd1-skew-ps = <180>;
-	rxd0-skew-ps = <180>;
-	txd3-skew-ps = <120>;
-	txd2-skew-ps = <0>;
-	txd1-skew-ps = <180>;
-	txd0-skew-ps = <360>;
-	txc-skew-ps = <1860>;
-	rxc-skew-ps = <1860>;
-};
-
-&sata {
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_ecspi5_mba6x: ecspi5grp-mba6x {
-		fsl,pins = <
-			/* HYS, SPEED = MED, 100k up, DSE = 011, SRE_FAST */
-			MX6QDL_PAD_SD1_DAT0__ECSPI5_MISO 0x1b099
-			MX6QDL_PAD_SD1_CMD__ECSPI5_MOSI 0xb099
-			MX6QDL_PAD_SD1_CLK__ECSPI5_SCLK 0xb099
-			MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 0xb099 /* eCSPI5 SS0 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6q-mba6a.dts b/arch/arm/dts/imx6q-mba6a.dts
deleted file mode 100644
index 349a08605a5..00000000000
--- a/arch/arm/dts/imx6q-mba6a.dts
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-/dts-v1/;
-
-#include "imx6q-tqma6a.dtsi"
-#include "imx6qdl-mba6.dtsi"
-#include "imx6qdl-mba6a.dtsi"
-#include "imx6q-mba6.dtsi"
-
-/ {
-	model = "TQ TQMa6Q on MBa6x";
-	compatible = "tq,imx6q-mba6x-a", "tq,mba6a",
-		     "tq,imx6q-tqma6q-a", "fsl,imx6q";
-};
diff --git a/arch/arm/dts/imx6qdl-mba6.dtsi b/arch/arm/dts/imx6qdl-mba6.dtsi
deleted file mode 100644
index 78555a61885..00000000000
--- a/arch/arm/dts/imx6qdl-mba6.dtsi
+++ /dev/null
@@ -1,535 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include <dt-bindings/clock/imx6qdl-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/sound/fsl-imx-audmux.h>
-
-/ {
-	aliases {
-		mmc0 = &usdhc3;
-		mmc1 = &usdhc2;
-		/delete-property/ mmc2;
-		/delete-property/ mmc3;
-		rtc0 = &rtc0;
-	};
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	beeper: gpio-beeper {
-		compatible = "gpio-beeper";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiobeeper>;
-		gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
-	};
-
-	gpio_buttons: gpio-buttons {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiobuttons>;
-
-		button1 {
-			label = "s6";
-			linux,code = <KEY_F6>;
-			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-		};
-
-		button2 {
-			label = "s7";
-			linux,code = <KEY_F7>;
-			gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-		};
-
-		button3 {
-			label = "s8";
-			linux,code = <KEY_F8>;
-			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-		};
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpioled>;
-
-		led1 {
-			label = "led1";
-			gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
-		};
-
-		led2 {
-			label = "led2";
-			gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	reg_mba6_3p3v: regulator-mba6-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "supply-mba6-3p3v";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	reg_pcie: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_regpcie>;
-		regulator-name = "supply-pcie";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		/* PCIE.PWR_EN */
-		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&reg_mba6_3p3v>;
-	};
-
-	reg_vcc3v3_audio: regulator-vcc3v3-audio {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3-audio";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_mba6_3p3v>;
-	};
-
-	sound {
-		compatible = "fsl,imx-audio-tlv320aic32x4";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_audmux>;
-		model = "imx-audio-tlv320aic32x4";
-		ssi-controller = <&ssi1>;
-		audio-codec = <&tlv320aic32x4>;
-		audio-asrc = <&asrc>;
-		audio-routing =
-			"IN3_L", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"IN1_L", "Line In Jack",
-			"IN1_R", "Line In Jack",
-			"Line Out Jack", "LOL",
-			"Line Out Jack", "LOR";
-		mux-int-port = <1>;
-		mux-ext-port = <3>;
-	};
-};
-
-&audmux {
-	status = "okay";
-
-	ssi0 {
-		fsl,audmux-port = <MX31_AUDMUX_PORT1_SSI0>;
-		fsl,port-config = <
-			(IMX_AUDMUX_V2_PTCR_SYN |
-				IMX_AUDMUX_V2_PTCR_TFSDIR |
-				IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT3_SSI_PINS_3) |
-				IMX_AUDMUX_V2_PTCR_TCLKDIR |
-				IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT3_SSI_PINS_3))
-			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT3_SSI_PINS_3)
-		>;
-	};
-
-	aud3 {
-		fsl,audmux-port = <MX31_AUDMUX_PORT3_SSI_PINS_3>;
-		fsl,port-config = <
-			IMX_AUDMUX_V2_PTCR_SYN
-			IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0)
-		>;
-	};
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can1>;
-	status = "okay";
-};
-
-&can2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can2>;
-	status = "okay";
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>, <&pinctrl_ecspi1_mba6>;
-	cs-gpios = <&gpio3 19 0>, <&gpio3 24 0>;
-};
-
-&fec {
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy>;
-	mac-address = [00 00 00 00 00 00];
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-			interrupt-parent = <&gpio1>;
-			interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <100000>;
-			micrel,force-master;
-			max-speed = <1000>;
-		};
-	};
-};
-
-&i2c1 {
-	tlv320aic32x4: audio-codec@18 {
-		compatible = "ti,tlv320aic32x4";
-		reg = <0x18>;
-		clocks = <&clks IMX6QDL_CLK_CKO>;
-		clock-names = "mclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_codec>;
-		ldoin-supply = <&reg_vcc3v3_audio>;
-		iov-supply = <&reg_mba6_3p3v>;
-	};
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio6 7 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3>;
-	status = "okay";
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
-
-&snvs_poweroff {
-	status = "okay";
-};
-
-&ssi1 {
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
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
-	uart-has-rtscts;
-	linux,rs485-enabled-at-boot-time;
-	rs485-rts-active-low;
-	rs485-rx-during-tx;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbh1 {
-	disable-over-current;
-	status = "okay";
-};
-
-&usbotg {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	power-active-high;
-	over-current-active-low;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-/* SD card slot */
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	vmmc-supply = <&reg_mba6_3p3v>;
-	bus-width = <4>;
-	no-1-8-v;
-	no-mmc;
-	no-sdio;
-	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog1>;
-	/* does not work on unmodified starter kit */
-	/* fsl,ext-reset-output; */
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	pinctrl_audmux: audmuxgrp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
-		>;
-	};
-
-	pinctrl_can1: can1grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0xb099
-			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0xb099
-		>;
-	};
-
-	pinctrl_can2: can2grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0xb099
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0xb099
-		>;
-	};
-
-	pinctrl_codec: codecgrp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1 0xb0 /* CLK */
-		>;
-	};
-
-	pinctrl_ecspi1_mba6: ecspimba6grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D24__GPIO3_IO24 0xb099 /* eCSPI1 SS2 */
-		>;
-	};
-
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			/* FEC phy IRQ */
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28     0x00011008
-			/* FEC phy reset */
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25   0x1b099
-			/* DSE = 100, 100k up, SPEED = MED */
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0xb0a0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC         0xb0a0
-			/* DSE = 111, pull 100k up */
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0xb038
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0xb038
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0xb038
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0xb038
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0xb038
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0xb038
-			/* DSE = 111, pull external */
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x0038
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x0038
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x0038
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x0038
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x0038
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x0038
-			/* HYS = 1, DSE = 111, 100k up, SPEED = HIGH */
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0f0
-		>;
-	};
-
-	pinctrl_gpiobeeper: gpiobeepergrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT3__GPIO1_IO21 0xb099
-		>;
-	};
-
-	pinctrl_gpiobuttons: gpiobuttongrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x0001b099
-			MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x0001b099
-			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x0001b099
-		>;
-	};
-
-	pinctrl_gpioled: gpioledgrp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 0xb099 /* LED V15 */
-			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31 0xb099 /* LED V16 */
-		>;
-	};
-
-	pinctrl_hog: hoggrp {
-		fsl,pins = <
-			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x0001b099
-
-			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b099
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x0001b099
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b099
-
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x0001b099
-			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x0001b099
-			MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x0001b099
-			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08 0x0001b099
-			MX6QDL_PAD_EIM_CS0__GPIO2_IO23 0x0001b099
-			MX6QDL_PAD_EIM_CS1__GPIO2_IO24 0x0001b099
-			MX6QDL_PAD_EIM_OE__GPIO2_IO25 0x0001b099
-
-			MX6QDL_PAD_EIM_D20__GPIO3_IO20 0x0001b099
-			MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x0001b099
-			MX6QDL_PAD_EIM_D27__GPIO3_IO27 0x0001b099
-			MX6QDL_PAD_EIM_D28__GPIO3_IO28 0x0001b099
-			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x0001b099
-
-			MX6QDL_PAD_KEY_COL0__GPIO4_IO06 0x0001b099
-			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07 0x0001b099
-			MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x0001b099
-			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x0001b099
-
-			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18 0x0001b099
-			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20 0x0001b099
-			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21 0x0001b099
-
-			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08 0x0001b099
-			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x0001b099
-		>;
-	};
-
-	pinctrl_pcie: pciegrp {
-		fsl,pins = <
-			/* HYS = 1, DSE = 110, 100k up, SPEED = HIGH (11)*/
-			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x001b0f0 /* #PCIE.WAKE */
-			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x001b0f0 /* #PCIE.RST */
-			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x001b0f0 /* #PCIE.DIS */
-		>;
-	};
-
-	pinctrl_pwm1: pwm1grp {
-		fsl,pins = <
-			/* 100 k PD, DSE 120 OHM, SPPEED LO */
-			MX6QDL_PAD_GPIO_9__PWM1_OUT 0x00003050
-		>;
-	};
-
-	pinctrl_pwm3: pwm3grp {
-		fsl,pins = <
-			/* 100 k PD, DSE 120 OHM, SPPEED LO */
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x00003050
-		>;
-	};
-
-	pinctrl_pwm4: pwm4grp {
-		fsl,pins = <
-			/* 100 k PD, DSE 120 OHM, SPPEED LO */
-			MX6QDL_PAD_SD4_DAT2__PWM4_OUT 0x00003050
-		>;
-	};
-
-	pinctrl_regpcie: regpciegrp {
-		fsl,pins = <
-			/* HYS = 1, DSE = 110, PUE+PKE, SPEED = HIGH (11)*/
-			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x00130f0 /* PCIE.PWR_EN */
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA 0x1b099
-			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA 0x1b099
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
-			MX6QDL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
-			MX6QDL_PAD_EIM_D31__UART3_RTS_B   0x1b0b1
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT18__UART5_RTS_B 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B 0x1b0b1
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			/* CLK: 47k Pup SPD_LOW DSE 40Ohm SRE_FAST HYS */
-			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x00017071
-			/* SD2: 47k Pup SPD_LOW DSE 80Ohm SRE_FAST HYS */
-			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x00017059
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x00017059
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x00017059
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x00017059
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x00017059
-
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x0001b099 /* usdhc2 CD */
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02  0x0001b099 /* usdhc2 WP */
-		>;
-	};
-
-	pinctrl_usbotg: usbotggrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__USB_OTG_OC  0x0001b0b0
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID   0x00017059
-			MX6QDL_PAD_EIM_D22__USB_OTG_PWR 0x0001b099
-		>;
-	};
-
-	pinctrl_wdog1: wdog1grp {
-		fsl,pins = <
-			 /* Watchdog out */
-			MX6QDL_PAD_SD1_DAT2__WDOG1_B 0x0000b099
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-mba6a.dtsi b/arch/arm/dts/imx6qdl-mba6a.dtsi
deleted file mode 100644
index df8fa169e9f..00000000000
--- a/arch/arm/dts/imx6qdl-mba6a.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>, <&pinctrl_enet_fix>;
-};
-
-&i2c1 {
-	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
-		reg = <0x49>;
-	};
-
-	m24c64_57: eeprom@57 {
-		compatible = "atmel,24c64";
-		reg = <0x57>;
-		pagesize = <32>;
-	};
-
-	rtc0: rtc@68 {
-		compatible = "dallas,ds1339";
-		reg = <0x68>;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-mba6b.dtsi b/arch/arm/dts/imx6qdl-mba6b.dtsi
deleted file mode 100644
index 7d1cd7454c7..00000000000
--- a/arch/arm/dts/imx6qdl-mba6b.dtsi
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_recovery>;
-	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&i2c3 {
-	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
-		reg = <0x49>;
-	};
-
-	m24c64_57: eeprom@57 {
-		compatible = "atmel,24c64";
-		reg = <0x57>;
-		pagesize = <32>;
-	};
-
-	rtc0: rtc@68 {
-		compatible = "dallas,ds1339";
-		reg = <0x68>;
-	};
-};
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b899
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b899
-		>;
-	};
-};

-- 
2.43.0

