Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DE0C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E41B40B8C;
	Thu, 10 Sep 2026 20:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLxEwEZKyXju; Thu, 10 Sep 2026 20:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE65E40B85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789072052;
	b=qVOnCmWocE3bR1VGx8h5xXJl9Ysa0RAccL0NoCn324dV6qxJ+hNlpPMAihzKSsj+7kC/
	 DM9HnLjXco78wif3p8qgM88HoxWQABA2HG+qkIjDKAFQGePqkXEc7LnCs35Y7EunpGYJX
	 5YQn5i0VRxSonTgeM27dXXHH/aF33pTbenho+fK6SpKgEHN6faRyq3z4MNI4zaVBH6Ou0
	 jhls7U8dROvl8AavX7Gq+/hOAZXJBzPQydX0FowRj9l8issGeC1TU69FKtUrbRvK8LOYO
	 2gLoBBpIIPiJdt98RLakv6s3f1FCPxv+g9KMIemIE/qK2JdnUCZyXa0eHip+HkFXT0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789072052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BBolIP7wLUGiXg1Sf4mR20UDy3/uSaahgWrXjcp4FfY=;
	b=dTnO2xeMYiDUwEFVob21uJ7FFvCJEmIo+ucfhwNOoXnYvvMFKr+br/jX+A6ls94viuq5
	 YfAfQoBwUolhFsblLYwTpuJYoAIlvoOuUyeaRdrGRmOfJdo/vDhSUrmqyVAPJmIhy1eqC
	 xioGaetOc7Zy9z4v0b9vw/gmF5HA/751E1XhHcpEqDWAvJeA2FuT8jSORYhAWX/vnMTH9
	 2mIV+QRJUtBUo8mY2BPdw7ReGOKvU0RaNhUx2Ed5qPyFVyfbtiN+Sj95mUGolU+a42i5Z
	 Siv7oc7t5ef/w1y/Xp4r1QSc8FD5bLOUtWnZo4gfR9hOXxkRDHhQZYV0RsUA9vDX2Mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=beims.me;
	dkim=pass header.d=beims.me header.i=@beims.me header.a=rsa-sha256 header.s=protonmail2 header.b="fZTN/qBz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789072052;
	bh=BBolIP7wLUGiXg1Sf4mR20UDy3/uSaahgWrXjcp4FfY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kE+VqOZ+kF3ylDUqb/Tv+YWXxgTZvMCcPXXpl03rKAnuSfYSib2PGGSvkuZtSJR0D
	 hV9E2OgnAFMy9/xSe/dqjC8aRigsN0WYLv7JYsNF276XoZ0i90dxXbWPWU0uYYMLJV
	 8jvJOAzp0BU/NdU5hukcrcyKn9krPJiXHFAfAxp8dpNEH1DPfDYVhHijyEWTAoF+pH
	 uJUSr9tPdhQyFKY62QeboelyQwOh+FGpE12fKae/bO33Z6INtFcUsChoVKtJwRtLqs
	 y90/QaLOXVoG1KENdfdLxUt6+dGYRzEiGXX3NHclKFID8vIVFFfOGu8A/yg+mPTE7y
	 yN41KF9htUHyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE65E40B85;
	Thu, 10 Sep 2026 20:27:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98EC1769
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A83C40839
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_gNCOgs1sYa for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 19:25:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DBECC4083B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789068350;
 b=FFHt2hWlwpunHC9ZDu24FYI9jdlCEN6dXO+o5UK++BdyLcEJ1pQOG9ZCVbGFNCOysKf4
 RiSGvw603dfaKYGnuGuPlJYBAq2ymvckv7URkCMOQceOmYZJw6EBfwYWclPAHjNH9vBf8
 fvHH0osNEXVXX4WlQgLfESWDzuMGxrp0ar1VP2rNwLv8GjyY3b/gTuPFPlR5T/DZCWdzJ
 ECj4KP9dPUfUChap1T/RoHSkxxljL9o0ZxfjB4/PEpRQc1AHsgloH2uSYDb4W/wlWgyiW
 vMqlab6N719lEiv9s37u8Gn6mIhdQVi6QBtBg/8u5erV0OdO7XrHVcX20rFTuiVllHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789068350;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=BBolIP7wLUGiXg1Sf4mR20UDy3/uSaahgWrXjcp4FfY=;
 b=JmU/JXmMT5rHVkBA4fEpzB3p32m3abHSRpgUyq357rH8UnnUZ+RpxqNxNRNdxthOkREP
 bTpjQHYgGoZ+pCi/upCBcXnFGbJQCKkJofzrSshN1VWdeG1YqTmxHvEulGvV0kmMmvDSA
 GrNa1F7lVndybX4ZkcehCjBbIC4snvM7SQP+Q3KND1vdnyjQok5FiOC8ZiUdk2G4/4yFn
 zMSduzSEWmQMcm8fqwpfDGuOLEFWYHbxnvUBsLt7JCCVUqx/1LeJxaRb65uWprgi3Ewst
 bUTxp4YrUGSNxSXJOyGdoLmadp+lfjdQnL9ay07Q9N6p9rsmMOIyu5+Hq5ZYqcZOfOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=beims.me; 
 dkim=pass header.d=beims.me header.i=@beims.me header.a=rsa-sha256
 header.s=protonmail2 header.b="fZTN/qBz"; 
 arc=none smtp.remote-ip=185.70.43.27
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=rafael@beims.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=beims.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=beims.me header.i=@beims.me header.a=rsa-sha256
 header.s=protonmail2 header.b=fZTN/qBz
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBECC4083B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me;
 s=protonmail2; t=1789068183; x=1789327383;
 bh=BBolIP7wLUGiXg1Sf4mR20UDy3/uSaahgWrXjcp4FfY=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fZTN/qBzJDTp+FQCx8i75eCYSdjaAFL+lvqON5PhBDgBWT58OT0AX42wfosc7ZnA+
 5ou94dEZzGYk6Qrnue3LrQRLe2GmW31osG2xKriTPQ6gzYiY4PY9qauCT1XcTnEEt0
 G16qOfe0KFDfCzilNEL0m4bSQpaqhJQlsvsHexJ6w88Q3vkrkSmQ9oxW22+OMXrvmt
 SYMg2eo+/oh+7xOzUQQWcqJq30kFc/h2Z5ipoxeL55PvCCC74i61HZN3SuEzDZ5N4v
 P+KpZkTchiXd1ExVlF6cfBuJSg/TNhBiWrLW11l5v/rWQkVNp1zdK+8Gp2qnt6BmBI
 k/vVBHi2rPGcQ==
X-Pm-Submission-Id: 4hgndF2rl9z2SdHS
From: Rafael Beims <rafael@beims.me>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.u-boot-project.org, Rafael Beims <rafael.beims@toradex.com>
Subject: [PATCH] arm: dts: imx95-aquila: migrate to OF_UPSTREAM
Date: Thu, 10 Sep 2026 16:22:16 -0300
Message-ID: <20260910192216.518123-1-rafael@beims.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 20:27:30 +0000
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

From: Rafael Beims <rafael.beims@toradex.com>

Allow CONFIG_OF_UPSTREAM to receive automatic device tree updates for
the Toradex Aquila iMX95.

Remove the now obsolete device tree files:
- imx95-aquila.dtsi
- imx95-aquila-dev.dts

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
 arch/arm/dts/imx95-aquila-dev.dts      |  389 --------
 arch/arm/dts/imx95-aquila.dtsi         | 1160 ------------------------
 arch/arm/mach-imx/imx9/Kconfig         |    1 +
 board/toradex/aquila-imx95/MAINTAINERS |    2 -
 configs/aquila-imx95_defconfig         |    2 +-
 5 files changed, 2 insertions(+), 1552 deletions(-)
 delete mode 100644 arch/arm/dts/imx95-aquila-dev.dts
 delete mode 100644 arch/arm/dts/imx95-aquila.dtsi

diff --git a/arch/arm/dts/imx95-aquila-dev.dts b/arch/arm/dts/imx95-aquila-dev.dts
deleted file mode 100644
index 3df17700b632..000000000000
--- a/arch/arm/dts/imx95-aquila-dev.dts
+++ /dev/null
@@ -1,389 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
- * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
- */
-
-/dts-v1/;
-
-#include <dt-bindings/pwm/pwm.h>
-#include <dt-bindings/usb/pd.h>
-#include "imx95-aquila.dtsi"
-
-/ {
-	model = "Aquila iMX95 on Aquila Development Board";
-	compatible = "toradex,aquila-imx95-dev",
-		     "toradex,aquila-imx95",
-		     "fsl,imx95";
-
-	aliases {
-		eeprom1 = &carrier_eeprom;
-	};
-
-	dp_1_connector: dp0-connector {
-		compatible = "dp-connector";
-		dp-pwr-supply = <&reg_dp_3p3v>;
-		type = "full-size";
-
-		port {
-			dp_1_connector_in: endpoint {
-				remote-endpoint = <&dsi2dp_out>;
-			};
-		};
-	};
-
-	reg_carrier_1p8v: regulator-carrier-1p8v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <1800000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "On-carrier 1V8";
-	};
-
-	reg_dp_3p3v: regulator-dp-3p3v {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_21_dp>;
-		/* Aquila GPIO_21_DP */
-		gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "DP_3V3";
-		startup-delay-us = <10000>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,bitclock-master = <&codec_dai>;
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&codec_dai>;
-		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "aquila-wm8904";
-		simple-audio-card,routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"IN2L", "Line In Jack",
-			"IN2R", "Line In Jack",
-			"Microphone Jack", "MICBIAS",
-			"IN1L", "Microphone Jack",
-			"IN1R", "Digital Mic";
-		simple-audio-card,widgets =
-			"Microphone", "Microphone Jack",
-			"Microphone", "Digital Mic",
-			"Headphone", "Headphone Jack",
-			"Line", "Line In Jack";
-
-		codec_dai: simple-audio-card,codec {
-			sound-dai = <&wm8904_1a>;
-		};
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-		};
-	};
-};
-
-/* Aquila ADC_[1-4] */
-&adc1 {
-	status = "okay";
-};
-
-/* Aquila CTRL_WAKE1_MICO# */
-&aquila_key_wake {
-	status = "okay";
-};
-
-&dsi2dp_out {
-	remote-endpoint = <&dp_1_connector_in>;
-};
-
-/* Aquila ETH_1 */
-&enetc_port0 {
-	status = "okay";
-};
-
-/* Aquila CAN_1 */
-&flexcan1 {
-	status = "okay";
-};
-
-/* Aquila CAN_2 */
-&flexcan2 {
-	status = "okay";
-};
-
-/* Aquila CAN_3 */
-&flexcan3 {
-	status = "okay";
-};
-
-/* Aquila CAN_4 */
-&flexcan4 {
-	status = "okay";
-};
-
-/* Aquila QSPI_1 */
-&flexspi1 {
-	pinctrl-0 = <&pinctrl_flexspi1_4bit>,
-		    <&pinctrl_qspi_cs1>;
-
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-max-frequency = <66000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-	};
-};
-
-&gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio_8>;
-};
-
-&gpio4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio_1>,
-		    <&pinctrl_gpio_2>,
-		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>,
-		    <&pinctrl_gpio_5>,
-		    <&pinctrl_gpio_6>,
-		    <&pinctrl_gpio_7>;
-};
-
-/* Aquila I2C_1 */
-&lpi2c2 {
-	status = "okay";
-
-	fan_controller: fan@18 {
-		compatible = "ti,amc6821";
-		reg = <0x18>;
-		#pwm-cells = <2>;
-
-		fan {
-			cooling-levels = <255>;
-			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
-		};
-	};
-
-	wm8904_1a: audio-codec@1a {
-		compatible = "wlf,wm8904";
-		reg = <0x1a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sai2_mclk>;
-		clocks = <&scmi_clk IMX95_CLK_SAI2>;
-		clock-names = "mclk";
-		#sound-dai-cells = <0>;
-		AVDD-supply = <&reg_carrier_1p8v>;
-		CPVDD-supply = <&reg_carrier_1p8v>;
-		DBVDD-supply = <&reg_carrier_1p8v>;
-		DCVDD-supply = <&reg_carrier_1p8v>;
-		MICVDD-supply = <&reg_carrier_1p8v>;
-		wlf,drc-cfg-names = "default", "peaklimiter";
-		/*
-		 * Config registers per name, respectively:
-		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
-		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
-		 */
-		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
-				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>;
-		/* GPIO1 = DMIC_CLK, don't touch others */
-		wlf,gpio-cfg = <0x0018>, <0xffff>, <0xffff>, <0xffff>;
-		wlf,in1r-as-dmicdat2;
-	};
-
-	/* Current measurement into module VCC */
-	hwmon@41 {
-		compatible = "ti,ina226";
-		reg = <0x41>;
-		shunt-resistor = <5000>;
-	};
-
-	temperature-sensor@4f {
-		compatible = "ti,tmp1075";
-		reg = <0x4f>;
-	};
-
-	/* USB-C OTG (TCPC USB PD PHY) */
-	tcpc@52 {
-		compatible = "nxp,ptn5110", "tcpci";
-		reg = <0x52>;
-		interrupt-parent = <&som_gpio_expander_1>;
-		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-
-		connector {
-			compatible = "usb-c-connector";
-			data-role = "dual";
-			op-sink-microwatt = <0>;
-			power-role = "dual";
-			self-powered;
-			sink-pdos = <PDO_FIXED(5000, 0, PDO_FIXED_USB_COMM)>;
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			try-power-role = "sink";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					typec_con_hs: endpoint {
-						remote-endpoint = <&usb1_con_hs>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-
-					typec_con_ss: endpoint {
-						remote-endpoint = <&usb1_con_ss>;
-					};
-				};
-			};
-		};
-	};
-
-	carrier_eeprom: eeprom@57 {
-		compatible = "st,24c02", "atmel,24c02";
-		reg = <0x57>;
-		pagesize = <16>;
-	};
-};
-
-/* Aquila I2C_2 */
-&i3c2 {
-	status = "okay";
-};
-
-/* Aquila I2C_4_CSI1 */
-&lpi2c4 {
-	status = "okay";
-};
-
-/* Aquila I2C_6 */
-&lpi2c5 {
-	status = "okay";
-};
-
-/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
-&lpi2c8 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9543";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* I2C on DSI Connector Pin #4 and #6 */
-		i2c_dsi_0: i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		/* I2C on DSI Connector Pin #52 and #54 */
-		i2c_dsi_1: i2c@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-/* Aquila SPI_1 */
-&lpspi6 {
-	status = "okay";
-};
-
-/* Aquila UART_3, used as the Linux Console */
-&lpuart1 {
-	status = "okay";
-};
-
-/* Aquila UART_4 */
-&lpuart2 {
-	status = "okay";
-};
-
-/* Aquila UART_1 */
-&lpuart3 {
-	status = "okay";
-};
-
-/* Aquila UART_2 as RS485 */
-&lpuart7 {
-	linux,rs485-enabled-at-boot-time;
-	rs485-rts-active-low;
-	rs485-rx-during-tx;
-
-	status = "okay";
-};
-
-/* Aquila PCIE_1 */
-&pcie0 {
-	status = "okay";
-};
-
-/* Aquila I2S_1 */
-&sai2 {
-	status = "okay";
-};
-
-/* Aquila PWM_1 */
-&tpm3 {
-	status = "okay";
-};
-
-/* Aquila PWM_2 */
-&tpm6 {
-	status = "okay";
-};
-
-/* Aquila PWM_3_DSI and PWM_4_DP */
-&tpm5 {
-	status = "okay";
-};
-
-/* Aquila USB_2, optional Bluetooth USB */
-&usb2 {
-	status = "okay";
-};
-
-/* Aquila USB_1 */
-&usb3 {
-	status = "okay";
-};
-
-&usb3_dwc3 {
-	status = "okay";
-
-	port {
-		usb1_con_hs: endpoint {
-			remote-endpoint = <&typec_con_hs>;
-		};
-	};
-};
-
-&usb3_phy {
-	orientation-switch;
-
-	status = "okay";
-
-	port {
-		usb1_con_ss: endpoint {
-			remote-endpoint = <&typec_con_ss>;
-		};
-	};
-};
-
-/* Aquila SD_1 */
-&usdhc2 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx95-aquila.dtsi b/arch/arm/dts/imx95-aquila.dtsi
deleted file mode 100644
index 69dc962a24a1..000000000000
--- a/arch/arm/dts/imx95-aquila.dtsi
+++ /dev/null
@@ -1,1160 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * https://www.toradex.com/computer-on-modules/aquila-arm-family/nxp-imx95
- */
-
-#include <dt-bindings/net/ti-dp83867.h>
-#include "imx95.dtsi"
-
-/ {
-	aliases {
-		can0 = &flexcan1;
-		can1 = &flexcan2;
-		can2 = &flexcan3;
-		can3 = &flexcan4;
-		eeprom0 = &som_eeprom;
-		ethernet0 = &enetc_port0;
-		i2c0 = &lpi2c3;
-		i2c1 = &lpi2c2;
-		i2c2 = &i3c2;
-		i2c3 = &lpi2c8;
-		i2c4 = &lpi2c4;
-		i2c6 = &lpi2c5;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		rtc0 = &rtc_i2c;
-		rtc1 = &scmi_bbm;
-		serial0 = &lpuart3;
-		serial1 = &lpuart7;
-		serial2 = &lpuart1;
-		serial3 = &lpuart2;
-		usb0 = &usb3;
-		usb1 = &usb2;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	aquila_key_wake: gpio-key-wakeup {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
-
-		status = "disabled";
-
-		key-wakeup {
-			/* Aquila CTRL_WAKE1_MICO# */
-			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
-			label = "Wake Up";
-			wakeup-source;
-			linux,code = <KEY_WAKEUP>;
-		};
-	};
-
-	clk_dsi2dp_refclk: clock-dsi2dp-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <27000000>;
-	};
-
-	clk_dsi2dp_refclk_en: clock-dsi2dp-refclk-en {
-		compatible = "gpio-gate-clock";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_dp_clk_en>;
-		clocks = <&clk_dsi2dp_refclk>;
-		#clock-cells = <0>;
-		/* CTRL_DP_CLK_EN */
-		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-	};
-
-	clk_serdes_eth_ref: clock-serdes-eth-ref {
-		compatible = "gpio-gate-clock";
-		#clock-cells = <0>;
-		/* CTRL_ETH_REF_CLK_STBY */
-		enable-gpios = <&som_gpio_expander_0 6 GPIO_ACTIVE_LOW>;
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <1800000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "On-module +V1.8";
-	};
-
-	reg_dp_1p2v: regulator-dp-1p2v {
-		compatible = "regulator-fixed";
-		/* CTRL_DP_BRIDGE_EN */
-		gpios = <&som_gpio_expander_0 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-max-microvolt = <1200000>;
-		regulator-min-microvolt = <1200000>;
-		regulator-name = "On-module +V1.2_DP";
-		vin-supply = <&reg_1p8v>;
-	};
-
-	reg_usb1_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		/* Aquila USB_1_EN */
-		gpios = <&som_gpio_expander_0 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-name = "USB_1_EN";
-	};
-
-	reg_usb2_vbus: regulator-usb2-vbus {
-		compatible = "regulator-fixed";
-		/* Aquila USB_2_EN */
-		gpios = <&som_gpio_expander_0 3 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-name = "USB_2_H_EN";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sd1_pwr_en>;
-		/* Aquila SD_1_PWR_EN */
-		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		off-on-delay-us = <100000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "SD_1_PWR_EN";
-		startup-delay-us = <20000>;
-	};
-
-	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
-		compatible = "regulator-gpio";
-		/* PMIC_SD_1_VSEL */
-		gpios = <&som_gpio_expander_1 9 GPIO_ACTIVE_HIGH>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "PMIC_SD_1_VSEL";
-		states = <1800000 0x1>,
-			 <3300000 0x0>;
-	};
-
-	remoteproc-cm7 {
-		compatible = "fsl,imx95-cm7";
-		mboxes = <&mu7 0 1 &mu7 1 1 &mu7 3 1>;
-		mbox-names = "tx", "rx", "rxdb";
-		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
-				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		linux_cma: linux,cma {
-			compatible = "shared-dma-pool";
-			reusable;
-			size = <0 0x3c000000>;
-			alloc-ranges = <0 0x80000000 0 0x7f000000>;
-			linux,cma-default;
-		};
-
-		m7_reserved: memory@80000000 {
-			reg = <0 0x80000000 0 0x1000000>;
-			no-map;
-		};
-
-		rsc_table: rsc-table@88220000 {
-			reg = <0 0x88220000 0 0x1000>;
-			no-map;
-		};
-
-		vdev0vring0: vdev0vring0@88000000 {
-			reg = <0 0x88000000 0 0x8000>;
-			no-map;
-		};
-
-		vdev0vring1: vdev0vring1@88008000 {
-			reg = <0 0x88008000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring0: vdev1vring0@88010000 {
-			reg = <0 0x88010000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring1: vdev1vring1@88018000 {
-			reg = <0 0x88018000 0 0x8000>;
-			no-map;
-		};
-
-		vdevbuffer: vdevbuffer@88020000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0x88020000 0 0x100000>;
-			no-map;
-		};
-	};
-};
-
-/* Aquila ADC_[1-4] */
-&adc1 {
-	vref-supply = <&reg_1p8v>;
-};
-
-/* Aquila ETH_1 */
-&enetc_port0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enetc0>;
-	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-id";
-};
-
-/* Aquila CAN_1 */
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-};
-
-/* Aquila CAN_2 */
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-};
-
-/* Aquila CAN_3 */
-&flexcan3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan3>;
-};
-
-/* Aquila CAN_4 */
-&flexcan4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan4>;
-};
-
-/* Aquila QSPI_1 */
-&flexspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi1_8bit>,
-		    <&pinctrl_qspi_cs1>;
-};
-
-&gpio1 {
-	gpio-line-names = "", /* 0 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "AQUILA_C24", /* 10 */
-			  "",
-			  "AQUILA_B17",
-			  "CTRL_GPIO_EXP_INT#",
-			  "AQUILA_B18";
-
-	status = "okay";
-};
-
-&gpio2 {
-	gpio-line-names = "", /* 0 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "AQUILA_B42",
-			  "",
-			  "AQUILA_B43";
-};
-
-&gpio3 {
-	gpio-line-names = "", /* 0 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "", /* 10 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "AQUILA_A11",
-			  "", /* 20 */
-			  "AQUILA_B57",
-			  "AQUILA_B19";
-};
-
-&gpio4 {
-	gpio-line-names = "", /* 0 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "", /* 10 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "AQUILA_C22",
-			  "AQUILA_C21",
-			  "AQUILA_C20",
-			  "", /* 20 */
-			  "",
-			  "",
-			  "AQUILA_C23",
-			  "AQUILA_D23",
-			  "AQUILA_D24",
-			  "",
-			  "AQUILA_D25";
-};
-
-&gpio5 {
-	gpio-line-names = "", /* 0 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "", /* 10 */
-			  "",
-			  "",
-			  "AQUILA_B44",
-			  "AQUILA_B45";
-};
-
-/* Aquila I2C_2 */
-&i3c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i3c2>;
-	i2c-scl-hz = <100000>;
-};
-
-/* Aquila I2C_1 */
-&lpi2c2 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-};
-
-/* On-module I2C - I2C_SOM */
-&lpi2c3 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c3>, <&pinctrl_ctrl_gpio_exp_int>;
-	pinctrl-1 = <&pinctrl_lpi2c3_gpio>, <&pinctrl_ctrl_gpio_exp_int>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	status = "okay";
-
-	som_gpio_expander_0: gpio@20 {
-		compatible = "nxp,pcal6408";
-		reg = <0x20>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"AQUILA_C38", /* 0 */
-			"PCIE_2_RESET#",
-			"AQUILA_B77",
-			"USB_2_H_EN",
-			"BT_DISABLE#",
-			"WIFI_DISABLE#",
-			"CTRL_ETH_REF_CLK_STBY",
-			"CTRL_DP_BRIDGE_EN";
-	};
-
-	som_gpio_expander_1: gpio@21 {
-		compatible = "nxp,pcal6416";
-		reg = <0x21>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupt-parent = <&gpio1>;
-		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"AQUILA_C1", /* 0 */
-			"AQUILA_C2",
-			"AQUILA_C3",
-			"AQUILA_C4",
-			"AQUILA_C36",
-			"AQUILA_B74",
-			"AQUILA_B75",
-			"USB_2_H_OC#",
-			"AQUILA_B81",
-			"PMIC_SD_1_VSEL",
-			"ETH_1_INT#", /* 10 */
-			"CTRL_TPM_INT#",
-			"SPI_2_CS2_TPM",
-			"PCIE_WAKE_WIFI#",
-			"WIFI_WAKE_BT",
-			"WIFI_WAKEUP_HOST";
-	};
-
-	som_dsi2dp_bridge: bridge@2c {
-		compatible = "ti,sn65dsi86";
-		reg = <0x2c>;
-		clocks = <&clk_dsi2dp_refclk_en>;
-		clock-names = "refclk";
-		vcc-supply = <&reg_dp_1p2v>;
-		vcca-supply = <&reg_dp_1p2v>;
-		vccio-supply = <&reg_1p8v>;
-		vpll-supply = <&reg_1p8v>;
-
-		status = "disabled";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				dsi2dp_in: endpoint {
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				dsi2dp_out: endpoint {
-					data-lanes = <3 2 1 0>;
-				};
-			};
-		};
-	};
-
-	rtc_i2c: rtc@32 {
-		compatible = "epson,rx8130";
-		reg = <0x32>;
-	};
-
-	temperature-sensor@48 {
-		compatible = "ti,tmp1075";
-		reg = <0x48>;
-	};
-
-	som_eeprom: eeprom@50 {
-		compatible = "st,24c02", "atmel,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-/* Aquila I2C_4_CSI1 */
-&lpi2c4 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c4>;
-	pinctrl-1 = <&pinctrl_lpi2c4_gpio>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-};
-
-/* Aquila I2C_6 */
-&lpi2c5 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c5>;
-	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-};
-
-/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
-&lpi2c8 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c8>;
-	pinctrl-1 = <&pinctrl_lpi2c8_gpio>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-};
-
-/* Aquila SPI_2 */
-&lpspi4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi4>;
-	cs-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>,
-		   <&som_gpio_expander_1 12 GPIO_ACTIVE_LOW>;
-
-	status = "okay";
-
-	som_tpm: tpm@1 {
-		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-		reg = <0x1>;
-		interrupt-parent = <&som_gpio_expander_1>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		/*
-		 * Maximum TPM-supported speed is 18.5 MHz, limited to 12 MHz
-		 * here as lpspi4's per-clock (2x the max speed) is 24 MHz.
-		 */
-		spi-max-frequency = <12000000>;
-	};
-};
-
-/* Aquila SPI_1 */
-&lpspi6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi6>;
-	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
-};
-
-/* Aquila UART_3, used as the Linux Console */
-&lpuart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-};
-
-/* Aquila UART_4 */
-&lpuart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-};
-
-/* Aquila UART_1 */
-&lpuart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-};
-
-/* Aquila UART_2 */
-&lpuart7 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart7>;
-	uart-has-rtscts;
-};
-
-&mu7 {
-	status = "okay";
-};
-
-/* Aquila ETH_2_XGMII_MDIO, shared between all ethernet ports */
-&netc_emdio {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_emdio>;
-
-	status = "okay";
-
-	ethphy1: ethernet-phy@1 {
-		reg = <1>;
-		interrupt-parent = <&som_gpio_expander_1>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-	};
-};
-
-&netcmix_blk_ctrl {
-	status = "okay";
-};
-
-&netc_blk_ctrl {
-	status = "okay";
-};
-
-&netc_timer {
-	status = "okay";
-};
-
-/* Aquila PCIE_1 */
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpios = <&som_gpio_expander_0 0 GPIO_ACTIVE_LOW>;
-};
-
-/* On-module Wi-Fi or Aquila PCIE_2 */
-&pcie1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie1>;
-	reset-gpios = <&som_gpio_expander_0 1 GPIO_ACTIVE_LOW>;
-
-	status = "okay";
-};
-
-/* Aquila I2S_1 */
-&sai2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
-			  <&scmi_clk IMX95_CLK_SAI2>;
-	assigned-clock-parents = <0>, <0>, <0>, <0>,
-				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
-	assigned-clock-rates = <3932160000>,
-			       <3612672000>, <393216000>,
-			       <361267200>, <12288000>;
-	#sound-dai-cells = <0>;
-	fsl,sai-mclk-direction-output;
-};
-
-&scmi_bbm {
-	linux,code = <KEY_POWER>;
-};
-
-&thermal_zones {
-	/* PF09 Main PMIC */
-	pf09-thermal {
-		polling-delay = <2000>;
-		polling-delay-passive = <250>;
-		thermal-sensors = <&scmi_sensor 2>;
-
-		trips {
-			trip0 {
-				hysteresis = <2000>;
-				temperature = <155000>;
-				type = "critical";
-			};
-		};
-	};
-
-	/* PF53 VDD_ARM PMIC */
-	pf53-arm-thermal {
-		polling-delay = <2000>;
-		polling-delay-passive = <250>;
-		thermal-sensors = <&scmi_sensor 4>;
-
-		trips {
-			trip0 {
-				hysteresis = <2000>;
-				temperature = <155000>;
-				type = "critical";
-			};
-		};
-	};
-
-	/* PF53 VDD_SOC PMIC */
-	pf53-soc-thermal {
-		polling-delay = <2000>;
-		polling-delay-passive = <250>;
-		thermal-sensors = <&scmi_sensor 3>;
-
-		trips {
-			trip0 {
-				hysteresis = <2000>;
-				temperature = <155000>;
-				type = "critical";
-			};
-		};
-	};
-};
-
-/* Aquila PWM_1 */
-&tpm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-};
-
-/* Aquila PWM_2 */
-&tpm6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm2>;
-};
-
-/* Aquila PWM_3_DSI and PWM_4_DP */
-&tpm5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3_dsi>, <&pinctrl_pwm4_dp>;
-};
-
-/* Aquila USB_2, optional Bluetooth USB */
-&usb2 {
-	dr_mode = "host";
-	vbus-supply = <&reg_usb2_vbus>;
-};
-
-/* Aquila USB_1 */
-&usb3 {
-	fsl,disable-port-power-control;
-};
-
-&usb3_dwc3 {
-	dr_mode = "otg";
-	adp-disable;
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-};
-
-&usb3_phy {
-	vbus-supply = <&reg_usb1_vbus>;
-};
-
-/* On-module eMMC */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	no-sdio;
-	no-sd;
-
-	status = "okay";
-};
-
-/* Aquila SD_1 */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_sd1_cd_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_sd1_cd_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_sd1_cd_gpio>;
-	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_sd1_cd_gpio>;
-	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	vqmmc-supply = <&reg_usdhc2_vqmmc>;
-};
-
-&wdog3 {
-	fsl,ext-reset-output;
-
-	status = "okay";
-};
-
-&scmi_iomuxc {
-	/* Aquila CTRL_WAKE1_MICO# */
-	pinctrl_ctrl_wake1_mico: ctrlwake1micogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x31e>; /* Aquila D6 */
-	};
-
-	pinctrl_ctrl_dp_clk_en: dpclkengrp {
-		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x11e>; /* CTRL_DP_CLK_EN */
-	};
-
-	/* Aquila ETH_2_XGMII_MDIO */
-	pinctrl_emdio: emdiogrp {
-		fsl,pins = <IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC	0x57e>, /* Aquila B90 */
-			   <IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO	0x97e>; /* Aquila B89 */
-	};
-
-	/* Aquila ETH_1 */
-	pinctrl_enetc0: enetc0grp {
-		fsl,pins = <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>, /* ENET1_TX_CTL */
-			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>, /* ENET1_TXC    */
-			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e>, /* ENET1_TDO    */
-			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e>, /* ENET1_TD1    */
-			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e>, /* ENET1_TD2    */
-			   <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e>, /* ENET1_TD3    */
-			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>, /* ENET1_RX_CTL */
-			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>, /* ENET1_RXC    */
-			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>, /* ENET1_RD0    */
-			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>, /* ENET1_RD1    */
-			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>, /* ENET1_RD2    */
-			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>; /* ENET1_RD3    */
-	};
-
-	/* Aquila CAN_1 */
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* Aquila B48 */
-			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* Aquila B49 */
-	};
-
-	/* Aquila CAN_2 */
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* Aquila B50 */
-			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* Aquila B51 */
-	};
-
-	/* Aquila CAN_3 */
-	pinctrl_flexcan3: flexcan3grp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO3__CAN3_TX	0x39e>, /* Aquila B53 */
-			   <IMX95_PAD_CCM_CLKO4__CAN3_RX	0x39e>; /* Aquila B54 */
-	};
-
-	/* Aquila CAN_4 */
-	pinctrl_flexcan4: flexcan4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO04__CAN4_TX	0x39e>, /* Aquila B55 */
-			   <IMX95_PAD_GPIO_IO05__CAN4_RX	0x39e>; /* Aquila B56 */
-	};
-
-	/* Aquila QSPI_1 (4 bit) */
-	pinctrl_flexspi1_4bit: flexspi14bitgrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK	0x3fe>, /* Aquila B65 */
-			   <IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0	0x3fe>, /* Aquila B68 */
-			   <IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1	0x3fe>, /* Aquila B67 */
-			   <IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2	0x3fe>, /* Aquila B61 */
-			   <IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3	0x3fe>, /* Aquila B60 */
-			   <IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS		0x3fe>; /* Aquila B63 */
-	};
-
-	/* Aquila QSPI_1 (8 bit) */
-	pinctrl_flexspi1_8bit: flexspi18bitgrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK	0x3fe>, /* Aquila B65 */
-			   <IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0	0x3fe>, /* Aquila B68 */
-			   <IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1	0x3fe>, /* Aquila B67 */
-			   <IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2	0x3fe>, /* Aquila B61 */
-			   <IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3	0x3fe>, /* Aquila B60 */
-			   <IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4	0x3fe>, /* Aquila B70 */
-			   <IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5	0x3fe>, /* Aquila B71 */
-			   <IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6	0x3fe>, /* Aquila B72 */
-			   <IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7	0x3fe>, /* Aquila B73 */
-			   <IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS		0x3fe>; /* Aquila B63 */
-	};
-
-	/* Aquila GPIO_01 */
-	pinctrl_gpio_1: gpio1grp {
-		fsl,pins = <IMX95_PAD_ENET2_RD0__GPIO4_IO_BIT24	0x31e>; /* Aquila D23 */
-	};
-
-	/* Aquila GPIO_02 */
-	pinctrl_gpio_2: gpio2grp {
-		fsl,pins = <IMX95_PAD_ENET2_RD1__GPIO4_IO_BIT25	0x31e>; /* Aquila D24 */
-	};
-
-	/* Aquila GPIO_03 */
-	pinctrl_gpio_3: gpio3grp {
-		fsl,pins = <IMX95_PAD_ENET2_RD3__GPIO4_IO_BIT27	0x31e>; /* Aquila D25 */
-	};
-
-	/* Aquila GPIO_04 */
-	pinctrl_gpio_4: gpio4grp {
-		fsl,pins = <IMX95_PAD_ENET2_TD0__GPIO4_IO_BIT19	0x31e>; /* Aquila C20 */
-	};
-
-	/* Aquila GPIO_05 */
-	pinctrl_gpio_5: gpio5grp {
-		fsl,pins = <IMX95_PAD_ENET2_TD1__GPIO4_IO_BIT18	0x31e>; /* Aquila C21 */
-	};
-
-	/* Aquila GPIO_06 */
-	pinctrl_gpio_6: gpio6grp {
-		fsl,pins = <IMX95_PAD_ENET2_TD2__GPIO4_IO_BIT17	0x31e>; /* Aquila C22 */
-	};
-
-	/* Aquila GPIO_07 */
-	pinctrl_gpio_7: gpio7grp {
-		fsl,pins = <IMX95_PAD_ENET2_RXC__GPIO4_IO_BIT23	0x31e>; /* Aquila C23 */
-	};
-
-	/* Aquila GPIO_08 */
-	pinctrl_gpio_8: gpio8grp {
-		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10	0x31e>; /* Aquila C24 */
-	};
-
-	/* Aquila GPIO_09_CSI_1 */
-	pinctrl_gpio_9_csi_1: gpio9csi1grp {
-		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_BIT12	0x31e>; /* Aquila B17 */
-	};
-
-	/* Aquila GPIO_10_CSI_1 */
-	pinctrl_gpio_10_csi_1: gpio10csi1grp {
-		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14	0x31e>; /* Aquila B18 */
-	};
-
-	/* Aquila GPIO_11_CSI_1 */
-	pinctrl_gpio_11_csi_1: gpio11csi1grp {
-		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x31e>; /* Aquila A11*/
-	};
-
-	/* Aquila GPIO_12_CSI_1 */
-	pinctrl_gpio_12_csi_1: gpio12csi1grp {
-		fsl,pins = <IMX95_PAD_SD3_DATA0__GPIO3_IO_BIT22	0x31e>; /* Aquila B19 */
-	};
-
-	/* Aquila GPIO_17_DSI_1 */
-	pinctrl_gpio_17_dsi_1: gpio17dsi1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO07__GPIO2_IO_BIT7	0x31e>; /* Aquila B42 */
-	};
-
-	/* Aquila GPIO_18_DSI_1 */
-	pinctrl_gpio_18_dsi_1: gpio18dsi1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO09__GPIO2_IO_BIT9	0x31e>; /* Aquila B43 */
-	};
-
-	/* Aquila GPIO_19_DSI_1 */
-	pinctrl_gpio_19_dsi_1: gpio19dsi1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13	0x31e>; /* Aquila B44 */
-	};
-
-	/* Aquila GPIO_20_DSI_1 */
-	pinctrl_gpio_20_dsi_1: gpio20dsi1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14	0x31e>; /* Aquila B45 */
-	};
-
-	/* Aquila GPIO_21_DP */
-	pinctrl_gpio_21_dp: gpio21dpgrp {
-		fsl,pins = <IMX95_PAD_SD3_CMD__GPIO3_IO_BIT21	0x31e>; /* Aquila B57 */
-	};
-
-	pinctrl_ctrl_gpio_exp_int: gpioexpintgrp {
-		fsl,pins = <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_BIT13	0x31e>; /* CTRL_GPIO_EXP_INT# */
-	};
-
-	/* Aquila I2C_2 */
-	pinctrl_i3c2: i3c2cgrp {
-		fsl,pins = <IMX95_PAD_ENET1_MDC__I3C2_SCL	0x40001186>, /* Aquila C17 */
-			   <IMX95_PAD_ENET1_MDIO__I3C2_SDA	0x40001186>; /* Aquila C16 */
-	};
-
-	/* Aquila I2C_1 as GPIOs */
-	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
-		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* Aquila D8 */
-			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* Aquila D7 */
-	};
-
-	/* Aquila I2C_1 */
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* Aquila D8 */
-			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* Aquila D7 */
-	};
-
-	/* On-module I2C as GPIOs */
-	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* I2C_SOM_SDA */
-			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* I2C_SOM_SCL */
-	};
-
-	/* On-module I2C */
-	pinctrl_lpi2c3: lpi2c3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* I2C_SOM_SDA */
-			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* I2C_SOM_SCL */
-	};
-
-	/* Aquila I2C_4_CSI1 as GPIO */
-	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>, /* Aquila A12 */
-			   <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>; /* Aquila A13 */
-	};
-
-	/* Aquila I2C_4_CSI1 */
-	pinctrl_lpi2c4: lpi2c4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>, /* Aquila A12 */
-			   <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>; /* Aquila A13 */
-	};
-
-	/* Aquila I2C_6 as GPIO */
-	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* Aquila C18 */
-			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* Aquila C19 */
-	};
-
-	/* Aquila I2C_6 */
-	pinctrl_lpi2c5: lpi2c5grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* Aquila C18 */
-			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* Aquila C19 */
-	};
-
-	/* Aquila I2C_3_DSI1/I2C_5_CSI2 as GPIO */
-	pinctrl_lpi2c8_gpio: lpi2c8gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO12__GPIO2_IO_BIT12	0x40001b9e>, /* Aquila C5/B40 */
-			   <IMX95_PAD_GPIO_IO13__GPIO2_IO_BIT13	0x40001b9e>; /* Aquila C6/B41 */
-	};
-
-	/* Aquila I2C_3_DSI1/I2C_5_CSI2 */
-	pinctrl_lpi2c8: lpi2c8grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO12__LPI2C8_SDA	0x40001b9e>, /* Aquila C5/B40 */
-			   <IMX95_PAD_GPIO_IO13__LPI2C8_SCL	0x40001b9e>; /* Aquila C6/B41 */
-	};
-
-	/* Aquila SPI_2 */
-	pinctrl_lpspi4: lpspi4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18	0x3fe>, /* Aquila D16 */
-			   <IMX95_PAD_GPIO_IO19__LPSPI4_SIN	0x3fe>, /* Aquila D15 */
-			   <IMX95_PAD_GPIO_IO20__LPSPI4_SOUT	0x3fe>, /* Aquila D17 */
-			   <IMX95_PAD_GPIO_IO21__LPSPI4_SCK	0x3fe>; /* Aquila D14 */
-	};
-
-	/* Aquila SPI_1 */
-	pinctrl_lpspi6: lpspi6grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0	0x3fe>, /* Aquila D9 */
-			   <IMX95_PAD_GPIO_IO01__LPSPI6_SIN	0x3fe>, /* Aquila D10 */
-			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT	0x3fe>, /* Aquila D11 */
-			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK	0x3fe>; /* Aquila D12 */
-	};
-
-	/* Aquila PCIE_1 */
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B	0x40001b1e>; /* Aquila C37 */
-	};
-
-	/* Aquila PCIE_2 */
-	pinctrl_pcie1: pcie1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B	0x40001b1e>; /* Aquila C34 */
-	};
-
-	/* Aquila QSPI_1_CS1# */
-	pinctrl_qspi_cs1: qspics1grp {
-		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B	0x3fe>; /* Aquila B66 */
-	};
-
-	/* Aquila QSPI_1_CS2# as GPIO */
-	pinctrl_qspi_cs2_gpio: qspics2gpiogrp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27	0x3fe>; /* Aquila B62 */
-	};
-
-	/* Aquila I2S_1 */
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC		0x11e>, /* Aquila B21 */
-			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK		0x11e>, /* Aquila B20 */
-			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0		0x11e>, /* Aquila B23 */
-			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0	0x11e>; /* Aquila B22 */
-	};
-
-	pinctrl_sai2_mclk: sai2mclkgrp {
-		fsl,pins = <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK	0x31e>; /* Aquila B24 */
-	};
-
-	/* Aquila SD_1_CD# as GPIO */
-	pinctrl_sd1_cd_gpio: sd1cdgpiogrp {
-		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* Aquila A1 */
-	};
-
-	/* Aquila SD_1_PWR_EN */
-	pinctrl_sd1_pwr_en: sd1pwrengpiogrp {
-		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* Aquila A6 */
-	};
-
-	/* Aquila PWM_1 */
-	pinctrl_pwm1: tpm3ch3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO24__TPM3_CH3	0x11e>; /* Aquila C25 */
-	};
-
-	/* Aquila PWM_3_DSI as GPIO */
-	pinctrl_pwm3_dsi_gpio: tpm5ch0gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO06__GPIO2_IO_BIT6	0x11e>; /* Aquila B46 */
-	};
-
-	/* Aquila PWM_3_DSI */
-	pinctrl_pwm3_dsi: tpm5ch0grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* Aquila B46 */
-	};
-
-	/* Aquila PWM_4_DP */
-	pinctrl_pwm4_dp: tpm5ch3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO26__TPM5_CH3	0x11e>; /* Aquila B58 */
-	};
-
-	/* Aquila PWM_2 */
-	pinctrl_pwm2: tpm6ch0grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO08__TPM6_CH0	0x11e>; /* Aquila C26 */
-	};
-
-	/* Aquila UART_3 */
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>, /* Aquila D20 */
-			   <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>; /* Aquila D19 */
-	};
-
-	/* Aquila UART_4 */
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX	0x31e>, /* Aquila D22 */
-			   <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX	0x31e>; /* Aquila D21 */
-	};
-
-	/* Aquila UART_1 */
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART3_TX	0x31e>, /* Aquila B37 */
-			   <IMX95_PAD_GPIO_IO15__LPUART3_RX	0x31e>, /* Aquila B35 */
-			   <IMX95_PAD_GPIO_IO16__LPUART3_CTS_B	0x31e>, /* Aquila B36 */
-			   <IMX95_PAD_GPIO_IO17__LPUART3_RTS_B	0x31e>; /* Aquila B38 */
-	};
-
-	/* Aquila UART_2 */
-	pinctrl_uart7: uart7grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO36__LPUART7_TX	0x31e>, /* Aquila B33 */
-			   <IMX95_PAD_GPIO_IO37__LPUART7_RX	0x31e>, /* Aquila B31 */
-			   <IMX95_PAD_GPIO_IO10__LPUART7_CTS_B	0x31e>, /* Aquila B32 */
-			   <IMX95_PAD_GPIO_IO11__LPUART7_RTS_B	0x31e>; /* Aquila B34 */
-	};
-
-	/* On-module eMMC */
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* eMMC_CLK    */
-			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* eMMC_CMD    */
-			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* eMMC_DATA0  */
-			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* eMMC_DATA1  */
-			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* eMMC_DATA2  */
-			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* eMMC_DATA3  */
-			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* eMMC_DATA4  */
-			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* eMMC_DATA5  */
-			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* eMMC_DATA6  */
-			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* eMMC_DATA7  */
-			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* eMMC_STROBE */
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* eMMC_CLK    */
-			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* eMMC_CMD    */
-			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* eMMC_DATA0  */
-			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* eMMC_DATA1  */
-			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* eMMC_DATA2  */
-			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* eMMC_DATA3  */
-			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* eMMC_DATA4  */
-			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* eMMC_DATA5  */
-			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* eMMC_DATA6  */
-			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* eMMC_DATA7  */
-			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* eMMC_STROBE */
-	};
-
-	/* Aquila SD_1 */
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x158e>, /* Aquila A5  */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x138e>, /* Aquila A7  */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x138e>, /* Aquila A3  */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x138e>, /* Aquila A2  */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x138e>, /* Aquila A10 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x138e>; /* Aquila A8  */
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x15fe>, /* Aquila A5  */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x13fe>, /* Aquila A7  */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe>, /* Aquila A3  */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe>, /* Aquila A2  */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe>, /* Aquila A10 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe>; /* Aquila A8  */
-	};
-
-	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x400>, /* Aquila A5  */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x400>, /* Aquila A7  */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x400>, /* Aquila A3  */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x400>, /* Aquila A2  */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x400>, /* Aquila A10 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x400>; /* Aquila A8  */
-	};
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index ad1a425e6522..2c4e512d6996 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -196,6 +196,7 @@ config TARGET_IMX943_EVK
 config TARGET_AQUILA_IMX95
 	bool "Support Toradex Aquila iMX95"
 	select IMX95
+	imply OF_UPSTREAM
 
 config TARGET_TORADEX_SMARC_IMX95
 	bool "Support Toradex SMARC iMX95"
diff --git a/board/toradex/aquila-imx95/MAINTAINERS b/board/toradex/aquila-imx95/MAINTAINERS
index d2a74a53f5e1..5916ecaf8ea8 100644
--- a/board/toradex/aquila-imx95/MAINTAINERS
+++ b/board/toradex/aquila-imx95/MAINTAINERS
@@ -1,6 +1,4 @@
 Aquila iMX95
-F:	arch/arm/dts/imx95-aquila.dtsi
-F:	arch/arm/dts/imx95-aquila-dev.dts
 F:	arch/arm/dts/imx95-aquila-dev-u-boot.dtsi
 F:	board/toradex/aquila-imx95/
 F:	configs/aquila-imx95_defconfig
diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
index 52b6ae9e1d10..afe21a82c189 100644
--- a/configs/aquila-imx95_defconfig
+++ b/configs/aquila-imx95_defconfig
@@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx95-aquila-dev"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-aquila-dev"
 CONFIG_TARGET_AQUILA_IMX95=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288

base-commit: d4152edb50356338af994d1c0483f65b717b4c15
-- 
2.53.0

