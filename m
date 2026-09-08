Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3A2C79FAE
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ABA0405B3;
	Tue,  8 Sep 2026 14:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBnjfX713Cs1; Tue,  8 Sep 2026 14:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1EB5A40540
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879366;
	b=PDj1zxZKNLL3bVWTR+ErrFWwlPhESnk+2yWAwB6iGXQBP3tSL6XObkXrczkvIxqpxjYx
	 8QydsoTV2lReNkBE9+zAqnvWIjFSamLbxOZ/EitJO77Eo1dy/YTn7UjmdxmkrjluBoWFu
	 7CLZXkVvwDmw1LQjDBoK4AWKS0h2ewVHVmtO0rpIxMc1klGKOWpU6a4VNPMzHXkqJf6s8
	 XQlFFszuXsHn/tL3mgjpz/B8YkCZxAwW9Y+Wl7qrV4lHApSHVTlnSiwvo7eN1xwzc7hCh
	 0ayiwnaA5UBTwJLVzMLaiAWtdzdRnZSqisrkxupnHXjZO7ZCtS9a4Ns0wUK5QnL2zrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PotXzxAIVP0uUS8OhItlaVTiTlebBizWSRfLZeSo3+U=;
	b=gooFnVOJsGCa3UoYH0xq1+FN1Ryq1TH4pHHldZxS21U3x2q48f9tYpwap4JAPj+IizsX
	 xj65+ExeC1ani3JaofW+KwIZIuJhdspYD4jWwQHR2Md4T4ZMo/h473tFE8amlhbHz1Jns
	 6xbHZh6+QEMUgpWj/8BadhquyBSumGBrfDCnONaApR1k9KAucPYSa9/jDrIw+PdnQEm4s
	 2qxuABEZpiXi9BLUosoXd5ekljLcbe/o9w8EDhrhGwH56msAMS22EF8sGSNF3vIkol6zj
	 uil14XYp/itOh/Ndiexhde/qujZ6xIJMRtbIebh5nXv7JMyAvc//R4RR3fE16kI4wlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=beims.me;
	dkim=pass header.d=beims.me header.i=@beims.me header.a=rsa-sha256 header.s=protonmail2 header.b=EGeQj9qt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879366;
	bh=PotXzxAIVP0uUS8OhItlaVTiTlebBizWSRfLZeSo3+U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SLBaK7hRBfs6SFwL0C9YVD9tc3HqyfV/t85Ku26dWZnxib34LDh4kKrdZCLC/L0tc
	 7GKMeZ6OFlrS1mM59licbdN/gaBjVaUbDdWuRi8W2O7Za7e27wGT/YQxM+XzjZoWEe
	 Am7hiScVPZnH1GHfMt1tvH2Q4UDfDLoQFbVlydaTPEfXuSfR+fsmvp+y00Lm5gHPyX
	 rfF/wfBV5egy4jGvy7H0xb4ovmx2Vw7+M50iwuH3XxtlMz11xaWQfIKefq8A7Zunsy
	 oXqmYhLD+F++loZNJexZ0bbbB1J2MqruG2SgDMV1/4zd58gsGLXHxwEqYCIw/mRY1X
	 GX5SuNy1J+/Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EB5A40540;
	Tue,  8 Sep 2026 14:56:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C846A48
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E2874040C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKvYpKAdc0VW for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9F407403D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788861603;
 b=m1KNkhMIgCuu0b1NIhf4cLXzX9DiTGSRUpXFc+b05VmArdq07XWZBq8IwqifAE/pyfzy
 QYxKhVqX4ZqtaJeodOQbI6FZBxRzOjb/K/0M0mEjBKgs/2DMNeTTxS/cDFjb7vF1SYmI5
 zqk9aDVOby8AyQMAuIoK/bS3iQ8zAHa2I0NJ6brxZw9lCXHykNepfLO/0DU/LINOK63sT
 t6IuVTw+WyON7Vxuuw/cYGeN/cq8tAWayATROBTAVbRwVtF8u5/ZWB8p75QcwMBWtZC+J
 gLUxb83xRt7AfPaQgheukEo6zaaehSykLNrNPVyYcWuSbS7Z2BAlblzgqWmDwJOk41A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788861603;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=PotXzxAIVP0uUS8OhItlaVTiTlebBizWSRfLZeSo3+U=;
 b=KBrGJiqF9jpyESNKzq6f+fx6q+U1sz6DmMVswotxNZZwgaRPNWJb4buQ43vnpdjYKPZk
 Fq6L81FIEBqMHBBLg5kwn2EyVV3pkrFMtC+9yXAtHrbj2BMkgihWYFmxdfPReiJmXgT4b
 k4jr3Nbcbu4zRcdFRYittcHM2bv98mRsL2L10CMhK380mIYHYety13JmbGut2fKP1hMCp
 T5Am2BQU4wqWA1L4vza5rTu1HJnt1slIzaFw1b+202xVMYXT2w7trz+sHOO9nR/Aq3T7k
 ITAeYYWH/ls1HL29SveFc8S4/IeXQQlyerjfYlrIa2KHxgz5VfL1vvDm3uAMOuXOHUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=beims.me; 
 dkim=pass header.d=beims.me header.i=@beims.me header.a=rsa-sha256
 header.s=protonmail2 header.b=EGeQj9qt; 
 arc=none smtp.remote-ip=185.70.43.27
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=rafael@beims.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=beims.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=beims.me header.i=@beims.me header.a=rsa-sha256
 header.s=protonmail2 header.b=EGeQj9qt
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F407403D8
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me;
 s=protonmail2; t=1788861580; x=1789120780;
 bh=PotXzxAIVP0uUS8OhItlaVTiTlebBizWSRfLZeSo3+U=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EGeQj9qtzmkd+DejzT09f8WR1JILq72O3IIFCK6N2xIJ4bYu6oSpOHgSq+Y674Q6G
 ZjgpwXyGseBYEizO5qAPyLJdab0FEiVHkTZOwqa7nlO5LTqRHblA3kYjgli02kiA3D
 HPPwUe703np/qD0xJcH31S7nf2tMpwcYwoyTUHbo/Rt91Ui9oaFI067hMaJR/K8B0H
 6cbSVau3XNod3dp3UzXlk7BsZazXPEdHLcE3B27A+IK/fMjDOkk0njoaCo3sIAbsFZ
 yXG+hMnmbKC+quMvWSiWZsbbXnHtBAHa0pka7SWICapL0UK94H5vnKiClZSJpMacMY
 LgPaSJAMzA9Gg==
X-Pm-Submission-Id: 4hfKD83x7Dz1Dg7K
From: Rafael Beims <rafael@beims.me>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.u-boot-project.org, Rafael Beims <rafael.beims@toradex.com>
Subject: [PATCH] arm: dts: imx95-verdin: migrate to OF_UPSTREAM
Date: Tue,  8 Sep 2026 06:58:59 -0300
Message-ID: <20260908095900.1842496-1-rafael@beims.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 14:56:03 +0000
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
the Toradex Verdin iMX95.

Remove the now obsolete device tree files:
- imx95-verdin.dtsi
- imx95-verdin-dev.dtsi
- imx95-verdin-wifi.dtsi
- imx95-verdin-wifi-dev.dts

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
 arch/arm/dts/imx95-verdin-dev.dtsi     |  239 -----
 arch/arm/dts/imx95-verdin-wifi-dev.dts |   21 -
 arch/arm/dts/imx95-verdin-wifi.dtsi    |   50 -
 arch/arm/dts/imx95-verdin.dtsi         | 1172 ------------------------
 arch/arm/mach-imx/imx9/Kconfig         |    1 +
 board/toradex/verdin-imx95/MAINTAINERS |    4 -
 configs/verdin-imx95_defconfig         |    2 +-
 7 files changed, 2 insertions(+), 1487 deletions(-)
 delete mode 100644 arch/arm/dts/imx95-verdin-dev.dtsi
 delete mode 100644 arch/arm/dts/imx95-verdin-wifi-dev.dts
 delete mode 100644 arch/arm/dts/imx95-verdin-wifi.dtsi
 delete mode 100644 arch/arm/dts/imx95-verdin.dtsi

diff --git a/arch/arm/dts/imx95-verdin-dev.dtsi b/arch/arm/dts/imx95-verdin-dev.dtsi
deleted file mode 100644
index 803480eef476..000000000000
--- a/arch/arm/dts/imx95-verdin-dev.dtsi
+++ /dev/null
@@ -1,239 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * Common dtsi for Verdin iMX95 SoM on development carrier board
- *
- * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
- * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
- */
-
-/ {
-	aliases {
-		eeprom1 = &carrier_eeprom;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,bitclock-master = <&codec_dai>;
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&codec_dai>;
-		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,name = "verdin-nau8822";
-		simple-audio-card,routing =
-			"Headphones", "LHP",
-			"Headphones", "RHP",
-			"Speaker", "LSPK",
-			"Speaker", "RSPK",
-			"Line Out", "AUXOUT1",
-			"Line Out", "AUXOUT2",
-			"LAUX", "Line In",
-			"RAUX", "Line In",
-			"LMICP", "Mic In",
-			"RMICP", "Mic In";
-		simple-audio-card,widgets =
-			"Headphones", "Headphones",
-			"Line Out", "Line Out",
-			"Speaker", "Speaker",
-			"Microphone", "Mic In",
-			"Line", "Line In";
-
-		codec_dai: simple-audio-card,codec {
-			clocks = <&scmi_clk IMX95_CLK_SAI3>;
-			sound-dai = <&nau8822_1a>;
-		};
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai3>;
-		};
-	};
-};
-
-/* Verdin ADC_1, ADC_2, ADC_3 and ADC_4 */
-&adc1 {
-	status = "okay";
-};
-
-/* Verdin ETH_1 (On-module PHY) */
-&enetc_port0 {
-	status = "okay";
-};
-
-/* Verdin ETH_2_RGMII */
-&enetc_port1 {
-	phy-handle = <&ethphy2>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
-
-/* Verdin QSPI_1 */
-&flexspi1 {
-	status = "okay";
-};
-
-&gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
-};
-
-&gpio2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio1>,
-		    <&pinctrl_gpio2>,
-		    <&pinctrl_gpio3>;
-};
-
-&gpio3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio6>;
-};
-
-&gpio4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio5>;
-};
-
-&gpio5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio4>;
-};
-
-/* Verdin I2C_3_HDMI */
-&i3c2 {
-	status = "okay";
-};
-
-/* Verdin I2C_2_DSI */
-&lpi2c3 {
-	status = "okay";
-};
-
-/* Verdin I2C_1 */
-&lpi2c4 {
-	status = "okay";
-
-	nau8822_1a: audio-codec@1a {
-		compatible = "nuvoton,nau8822";
-		reg = <0x1a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_sai3_mclk>;
-		#sound-dai-cells = <0>;
-	};
-
-	carrier_gpio_expander: gpio@21 {
-		compatible = "nxp,pcal6416";
-		reg = <0x21>;
-		#gpio-cells = <2>;
-		gpio-controller;
-	};
-
-	/* Current measurement into module VCC */
-	hwmon@40 {
-		compatible = "ti,ina219";
-		reg = <0x40>;
-		shunt-resistor = <10000>;
-	};
-
-	temperature-sensor@4f {
-		compatible = "ti,tmp75c";
-		reg = <0x4f>;
-	};
-
-	carrier_eeprom: eeprom@57 {
-		compatible = "st,24c02", "atmel,24c02";
-		reg = <0x57>;
-		pagesize = <16>;
-	};
-};
-
-/* Verdin I2C_4_CSI */
-&lpi2c5 {
-	status = "okay";
-};
-
-/* Verdin UART_3, used as the Linux console */
-&lpuart1 {
-	status = "okay";
-};
-
-/* Verdin UART_4 */
-&lpuart2 {
-	status = "okay";
-};
-
-/* Verdin UART_1, connector X50 through RS485 transceiver */
-&lpuart7 {
-	rs485-rts-active-low;
-	rs485-rx-during-tx;
-	linux,rs485-enabled-at-boot-time;
-
-	status = "okay";
-};
-
-/* Verdin UART_2 */
-&lpuart8 {
-	status = "okay";
-};
-
-&netc_emdio {
-	ethphy2: ethernet-phy@7 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <7>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eth2_rgmii_int>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
-		micrel,led-mode = <0>;
-	};
-};
-
-/* Verdin PCIE_1 */
-&pcie0 {
-	status = "okay";
-};
-
-/* Verdin I2S_1 */
-&sai3 {
-	status = "okay";
-};
-
-/* Verdin PWM_1 */
-&tpm4 {
-	status = "okay";
-};
-
-/* Verdin PWM_2 */
-&tpm5 {
-	status = "okay";
-};
-
-/* Verdin PWM_3_DSI */
-&tpm6 {
-	status = "okay";
-};
-
-/* Verdin USB_1 */
-&usb2 {
-	status = "okay";
-};
-
-/* Verdin USB_2 */
-&usb3 {
-	fsl,permanently-attached;
-
-	status = "okay";
-};
-
-&usb3_phy {
-	status = "okay";
-};
-
-/* Verdin SD_1 */
-&usdhc2 {
-	status = "okay";
-};
-
-/* Verdin CTRL_WAKE1_MICO# */
-&verdin_gpio_keys {
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx95-verdin-wifi-dev.dts b/arch/arm/dts/imx95-verdin-wifi-dev.dts
deleted file mode 100644
index 345d37247025..000000000000
--- a/arch/arm/dts/imx95-verdin-wifi-dev.dts
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
- * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
- */
-
-/dts-v1/;
-
-#include "imx95-verdin.dtsi"
-#include "imx95-verdin-wifi.dtsi"
-#include "imx95-verdin-dev.dtsi"
-
-/ {
-	model = "Toradex Verdin iMX95 WB on Verdin Development Board";
-	compatible = "toradex,verdin-imx95-wifi-dev",
-		     "toradex,verdin-imx95-wifi",
-		     "toradex,verdin-imx95",
-		     "fsl,imx95";
-};
diff --git a/arch/arm/dts/imx95-verdin-wifi.dtsi b/arch/arm/dts/imx95-verdin-wifi.dtsi
deleted file mode 100644
index 256c9ed04605..000000000000
--- a/arch/arm/dts/imx95-verdin-wifi.dtsi
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * Common dtsi for Verdin iMX95 SoM WB variant
- *
- * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
- */
-
-/ {
-	reg_wifi_en: regulator-wifi-en {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_wifi_pwr_en>;
-		/* PMIC_EN_WIFI */
-		gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "PDn_MAYA-W260";
-		startup-delay-us = <2000>;
-	};
-};
-
-/* On-module Bluetooth */
-&lpuart6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_bt_uart>;
-	uart-has-rtscts;
-
-	status = "okay";
-
-	som_bt: bluetooth {
-		compatible = "nxp,88w8987-bt";
-		fw-init-baudrate = <3000000>;
-	};
-};
-
-/* On-module Wi-Fi */
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	keep-power-in-suspend;
-	non-removable;
-	vmmc-supply = <&reg_wifi_en>;
-
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx95-verdin.dtsi b/arch/arm/dts/imx95-verdin.dtsi
deleted file mode 100644
index 29cd4b91a16c..000000000000
--- a/arch/arm/dts/imx95-verdin.dtsi
+++ /dev/null
@@ -1,1172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (c) Toradex
- *
- * Common dtsi for Verdin iMX95 SoM
- *
- * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
- */
-
-#include <dt-bindings/net/ti-dp83867.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx95.dtsi"
-#include "imx95-u-boot.dtsi"
-
-/ {
-	aliases {
-		can0 = &flexcan1;
-		can1 = &flexcan2;
-		eeprom0 = &som_eeprom;
-		ethernet0 = &enetc_port0;
-		ethernet1 = &enetc_port1;
-		i2c0 = &lpi2c2;
-		i2c1 = &lpi2c4;
-		i2c2 = &lpi2c3;
-		i2c3 = &i3c2;
-		i2c4 = &lpi2c5;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		rtc0 = &rtc_i2c;
-		rtc1 = &scmi_bbm;
-		serial0 = &lpuart7;
-		serial1 = &lpuart8;
-		serial2 = &lpuart1;
-		serial3 = &lpuart2;
-		serial4 = &lpuart6;
-		usb0 = &usb2;
-		usb1 = &usb3;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	connector {
-		compatible = "gpio-usb-b-connector", "usb-b-connector";
-		/* Verdin USB_1_ID (SODIMM 161) */
-		id-gpios = <&som_gpio_expander 5 GPIO_ACTIVE_HIGH>;
-		label = "USB_1";
-		self-powered;
-		vbus-supply = <&reg_usb1_vbus>;
-
-		port {
-			usb_dr_connector: endpoint {
-				remote-endpoint = <&usb1_id>;
-			};
-		};
-	};
-
-	verdin_gpio_keys: gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
-
-		status = "disabled";
-
-		verdin_key_wakeup: key-wakeup {
-			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
-			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
-			label = "Wake-Up";
-			linux,code = <KEY_WAKEUP>;
-			wakeup-source;
-		};
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <1800000>;
-		regulator-min-microvolt = <1800000>;
-		regulator-name = "On-module +V1.8";
-	};
-
-	/*
-	 * By default we enable CTRL_SLEEP_MOCI#, this is required to have
-	 * peripherals on the carrier board powered.
-	 * If more granularity or power saving is required this can be disabled
-	 * in the carrier board device tree files.
-	 */
-	reg_force_sleep_moci: regulator-force-sleep-moci {
-		compatible = "regulator-fixed";
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "CTRL_SLEEP_MOCI#";
-	};
-
-	reg_usb1_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		/* Verdin USB_1_EN (SODIMM 155) */
-		gpios = <&som_gpio_expander 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-name = "USB_1_EN";
-	};
-
-	reg_usb2_vbus: regulator-usb2-vbus {
-		compatible = "regulator-fixed";
-		/* Verdin USB_2_EN (SODIMM 185) */
-		gpios = <&som_gpio_expander 8 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-name = "USB_2_EN";
-	};
-
-	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
-		compatible = "regulator-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
-		gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <1800000>;
-		states = <1800000 0x1>,
-			 <3300000 0x0>;
-		regulator-name = "PMIC_SD2_VSEL";
-	};
-
-	reg_usdhc2_vmmc: regulator-vmmc-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
-		/* Verdin SD_1_PWR_EN (SODIMM 76) */
-		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		off-on-delay-us = <100000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "SD_1_PWR_EN";
-		startup-delay-us = <20000>;
-	};
-
-	cm7: remoteproc-cm7 {
-		compatible = "fsl,imx95-cm7";
-		mbox-names = "tx", "rx", "rxdb";
-		mboxes = <&mu7 0 1
-			  &mu7 1 1
-			  &mu7 3 1>;
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
-			alloc-ranges = <0 0x80000000 0 0x7F000000>;
-			linux,cma-default;
-		};
-
-		m7_reserved: memory@80000000 {
-			reg = <0 0x80000000 0 0x1000000>;
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
-
-		rsc_table: rsc-table@88220000 {
-			reg = <0 0x88220000 0 0x1000>;
-			no-map;
-		};
-	};
-};
-
-/* Verdin ADC_1, ADC_2, ADC_3 and ADC_4 */
-&adc1 {
-	vref-supply = <&reg_1p8v>;
-};
-
-/* Verdin ETH_1 (On-module PHY) */
-&enetc_port0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enetc0>;
-	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-id";
-};
-
-/* Verdin ETH_2_RGMII */
-&enetc_port1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enetc1>;
-};
-
-/* Verdin CAN_1 */
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-};
-
-/* Verdin CAN_2 */
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-};
-
-/* Verdin QSPI_1 */
-&flexspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi1>;
-};
-
-&gpio1 {
-	gpio-line-names =
-		"", /* 0 */
-		"",
-		"",
-		"",
-		"SODIMM_147",
-		"SODIMM_149",
-		"SODIMM_151",
-		"SODIMM_153",
-		"SODIMM_20",
-		"SODIMM_22",
-		"SODIMM_252", /* 10 */
-		"",
-		"SODIMM_189",
-		"IO_EXP_INT",
-		"SODIMM_256",
-		"";
-
-	status = "okay";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"SODIMM_206", /* 0 */
-		"SODIMM_198",
-		"SODIMM_200",
-		"SODIMM_196",
-		"",
-		"SODIMM_15",
-		"SODIMM_16",
-		"",
-		"SODIMM_131",
-		"SODIMM_129",
-		"SODIMM_135", /* 10 */
-		"SODIMM_133",
-		"SODIMM_139",
-		"SODIMM_137",
-		"SODIMM_143",
-		"SODIMM_141",
-		"SODIMM_30",
-		"SODIMM_38",
-		"SODIMM_208",
-		"SODIMM_19",
-		"SODIMM_36", /* 20 */
-		"SODIMM_34",
-		"SODIMM_93",
-		"SODIMM_95",
-		"SODIMM_210",
-		"SODIMM_24",
-		"SODIMM_32",
-		"SODIMM_26",
-		"SODIMM_53",
-		"SODIMM_55",
-		"SODIMM_12", /* 30 */
-		"SODIMM_14";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"SODIMM_84", /* 0 */
-		"SODIMM_78",
-		"SODIMM_74",
-		"SODIMM_80",
-		"SODIMM_82",
-		"SODIMM_70",
-		"SODIMM_72",
-		"SODIMM_76",
-		"",
-		"",
-		"", /* 10 */
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"PMIC_SD2_VSEL",
-		"", /* 20 */
-		"",
-		"",
-		"",
-		"",
-		"",
-		"SODIMM_91",
-		"SODIMM_218",
-		"",
-		"",
-		"", /* 30 */
-		"";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"SODIMM_59", /* 0 */
-		"SODIMM_57",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"",
-		"", /* 10 */
-		"",
-		"",
-		"",
-		"SODIMM_193",
-		"SODIMM_191",
-		"SODIMM_215",
-		"SODIMM_217",
-		"SODIMM_219",
-		"SODIMM_221",
-		"SODIMM_211", /* 20 */
-		"SODIMM_213",
-		"SODIMM_199",
-		"SODIMM_197",
-		"SODIMM_201",
-		"SODIMM_203",
-		"SODIMM_205",
-		"SODIMM_207",
-		"SODIMM_216",
-		"SODIMM_202";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"SODIMM_56", /* 0 */
-		"SODIMM_58",
-		"SODIMM_60",
-		"SODIMM_62",
-		"SODIMM_46",
-		"SODIMM_44",
-		"SODIMM_42",
-		"SODIMM_48",
-		"SODIMM_66",
-		"SODIMM_52",
-		"SODIMM_54", /* 10 */
-		"SODIMM_64",
-		"SODIMM_212",
-		"",
-		"",
-		"",
-		"",
-		"";
-};
-
-/* Verdin I2C_3_HDMI */
-&i3c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i3c2>;
-	i2c-scl-hz = <400000>;
-};
-
-/* CTRL_I2C (On-module I2C) */
-&lpi2c2 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c2>, <&pinctrl_io_exp_int>;
-	pinctrl-1 = <&pinctrl_lpi2c2_gpio>, <&pinctrl_io_exp_int>;
-	clock-frequency = <400000>;
-	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	single-master;
-
-	status = "okay";
-
-	som_gpio_expander: gpio@20 {
-		compatible = "nxp,pcal6416";
-		reg = <0x20>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupt-parent = <&gpio1>;
-		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
-		#gpio-cells = <2>;
-		gpio-controller;
-
-		gpio-line-names =
-			"SODIMM_220", /* 0 */
-			"SODIMM_222",
-			"SODIMM_17",
-			"SODIMM_21",
-			"SODIMM_244",
-			"SODIMM_161",
-			"SODIMM_157",
-			"SODIMM_155",
-			"SODIMM_185",
-			"SODIMM_187",
-			"USB_RECOV_CTRL#", /* 10 */
-			"ENET1_INT#",
-			"TPM_INT#",
-			"TPM_CS#",
-			"",
-			"";
-
-		/*
-		 * Switch USB to default position:
-		 *   - SoC USB2 -> Verdin USB_1
-		 *   - SoC USB1 -> Verdin USB_2
-		 * Reset configuration:
-		 *   - SoC USB1 -> Verdin USB_1 (USB recovery)
-		 *   - SoC USB2 not connected
-		 */
-		usb_recov_ctrl: usb-recov-ctrl-hog {
-			gpio-hog;
-			gpios = <10 GPIO_ACTIVE_HIGH>;
-			line-name = "USB_RECOV_CTRL#";
-			output-high;
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
-/* Verdin I2C_2_DSI */
-&lpi2c3 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	single-master;
-};
-
-/* Verdin I2C_1 */
-&lpi2c4 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c4>;
-	pinctrl-1 = <&pinctrl_lpi2c4_gpio>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	single-master;
-};
-
-/* Verdin I2C_4_CSI */
-&lpi2c5 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c5>;
-	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
-	clock-frequency = <100000>;
-	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	single-master;
-};
-
-/* Verdin SPI_1 */
-&lpspi6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi6>, <&pinctrl_spi1_cs>;
-	cs-gpios = <&gpio4 29 GPIO_ACTIVE_LOW>,
-		   <&som_gpio_expander 13 GPIO_ACTIVE_LOW>;
-
-	status = "okay";
-
-	som_tpm: tpm@1 {
-		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-		reg = <0x1>;
-		interrupt-parent = <&som_gpio_expander>;
-		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
-		/*
-		 * Maximum TPM-supported speed is 18.5 MHz, limited to 12 MHz
-		 * here as lpspi6's per-clock (twice the max speed) is 24 MHz
-		 */
-		spi-max-frequency = <12000000>;
-	};
-};
-
-/* Verdin UART_3, used as the Linux console */
-&lpuart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-};
-
-/* Verdin UART_4 */
-&lpuart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-};
-
-/* Verdin UART_1 */
-&lpuart7 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart7>;
-	uart-has-rtscts;
-};
-
-/* Verdin UART_2 */
-&lpuart8 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart8>, <&pinctrl_uart8_cts>, <&pinctrl_uart8_rts>;
-	uart-has-rtscts;
-};
-
-&mu7 {
-	status = "okay";
-};
-
-&netc_blk_ctrl {
-	status = "okay";
-};
-
-&netc_bus0 {
-	msi-map = <0x0 &its 0x60 0x1>,	//ENETC0 PF
-		  <0x10 &its 0x61 0x1>, //ENETC0 VF0
-		  <0x20 &its 0x62 0x1>, //ENETC0 VF1
-		  <0x40 &its 0x63 0x1>, //ENETC1 PF
-		  <0x50 &its 0x65 0x1>, //ENETC1 VF0
-		  <0x60 &its 0x66 0x1>, //ENETC1 VF1
-		  <0x80 &its 0x64 0x1>, //ENETC2 PF
-		  <0xc0 &its 0x67 0x1>; //NETC Timer
-	iommu-map = <0x0 &smmu 0x20 0x1>,
-		    <0x10 &smmu 0x21 0x1>,
-		    <0x20 &smmu 0x22 0x1>,
-		    <0x40 &smmu 0x23 0x1>,
-		    <0x50 &smmu 0x25 0x1>,
-		    <0x60 &smmu 0x26 0x1>,
-		    <0x80 &smmu 0x24 0x1>,
-		    <0xc0 &smmu 0x27 0x1>;
-};
-
-/* Verdin ETH_2_RGMII_MDIO, shared between all ethernet ports */
-&netc_emdio {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_emdio>;
-
-	status = "okay";
-
-	ethphy1: ethernet-phy@0 {
-		reg = <0>;
-		interrupt-parent = <&som_gpio_expander>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-	};
-};
-
-&netc_timer {
-	status = "okay";
-};
-
-&netcmix_blk_ctrl {
-	status = "okay";
-};
-
-/* Verdin PCIE_1 */
-&pcie0 {
-	/* PCIE_1_RESET# (SODIMM 244) */
-	reset-gpios = <&som_gpio_expander 4 GPIO_ACTIVE_LOW>;
-};
-
-/* Verdin I2S_1 */
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
-			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
-			  <&scmi_clk IMX95_CLK_SAI3>;
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
-/* Verdin PWM_1 */
-&tpm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_tpm4>;
-};
-
-/* Verdin PWM_2 */
-&tpm5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_tpm5>;
-};
-
-/* Verdin PWM_3_DSI */
-&tpm6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_tpm6>;
-};
-
-/* Verdin USB_1 */
-&usb2 {
-	dr_mode = "otg";
-	adp-disable;
-	hnp-disable;
-	srp-disable;
-	usb-role-switch;
-	vbus-supply = <&reg_usb1_vbus>;
-
-	port {
-		usb1_id: endpoint {
-			remote-endpoint = <&usb_dr_connector>;
-		};
-	};
-};
-
-/* Verdin USB_2 */
-&usb3 {
-	fsl,disable-port-power-control;
-};
-
-&usb3_dwc3 {
-	dr_mode = "host";
-};
-
-&usb3_phy {
-	vbus-supply = <&reg_usb2_vbus>;
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
-/* Verdin SD_1 */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_usdhc2_cd>;
-	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd>;
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
-	/* On-module Bluetooth on WB SKUs, module-specific UART otherwise */
-	pinctrl_bt_uart: btuartgrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO04__LPUART6_TX	0x31e>, /* WiFi_UART_SoC_TXD */
-			   <IMX95_PAD_GPIO_IO33__LPUART6_RX	0x31e>, /* WiFi_UART_SoC_RXD */
-			   <IMX95_PAD_GPIO_IO34__LPUART6_CTS_B	0x31e>, /* WiFi_UART_SoC_CTS */
-			   <IMX95_PAD_GPIO_IO07__LPUART6_RTS_B	0x31e>; /* WiFi_UART_SoC_RTS */
-	};
-
-	/* Verdin CSI_1_MCLK */
-	pinctrl_csi1_mclk: csi1mclkgrp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1	0x51e>; /* SODIMM 91 */
-	};
-
-	/* Verdin CTRL_SLEEP_MOCI# */
-	pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
-		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14	0x51e>; /* SODIMM 256 */
-	};
-
-	/* Verdin CTRL_WAKE1_MICO# */
-	pinctrl_ctrl_wake1_mico: ctrlwake1micogrp {
-		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10	0x31e>; /* SODIMM 252 */
-	};
-
-	/* Verdin ETH_2_RGMII_MDIO, shared between all ethernet ports */
-	pinctrl_emdio: emdiogrp {
-		fsl,pins = <IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC	0x50e>, /* ENET2_MDC, SODIMM 193 */
-			   <IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO	0x90e>; /* ENET2_MDIO, SODIMM 191 */
-	};
-
-	/* Verdin ETH_1 (On-module PHY) */
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
-	/* Verdin ETH_2_RGMII */
-	pinctrl_enetc1: enetc1grp {
-		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e>, /* ENET2_TX_CTL */
-			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK		0x58e>, /* ENET2_TXC    */
-			   <IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x50e>, /* ENET2_TD0    */
-			   <IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x50e>, /* ENET2_TD1    */
-			   <IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x50e>, /* ENET2_TD2    */
-			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x50e>, /* ENET2_TD3    */
-			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e>, /* ENET2_RX_CTL */
-			   <IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK		0x58e>, /* ENET2_RXC    */
-			   <IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e>, /* ENET2_RD0    */
-			   <IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e>, /* ENET2_RD1    */
-			   <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e>, /* ENET2_RD2    */
-			   <IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e>; /* ENET2_RD3    */
-	};
-
-	/* Verdin ETH_2_RGMII_INT#  */
-	pinctrl_eth2_rgmii_int: eth2rgmiiintgrp {
-		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_BIT12	0x31e>; /* SODIMM 189 */
-	};
-
-	/* Verdin CAN_1 */
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* SODIMM 20 */
-			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* SODIMM 22 */
-	};
-
-	/* Verdin CAN_2 */
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* SODIMM 24 */
-			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* SODIMM 26 */
-	};
-
-	/* Verdin QSPI_1 */
-	pinctrl_flexspi1: flexspi1grp {
-		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B	0x3fe>, /* SODIMM 54 */
-			   <IMX95_PAD_XSPI1_SS1_B__FLEXSPI1_A_SS1_B	0x3fe>, /* SODIMM 64 */
-			   <IMX95_PAD_XSPI1_SCLK__XSPI_CLK		0x3fe>, /* SODIMM 52 */
-			   <IMX95_PAD_XSPI1_DATA0__XSPI_DATA_BIT0	0x3fe>, /* SODIMM 56 */
-			   <IMX95_PAD_XSPI1_DATA1__XSPI_DATA_BIT1	0x3fe>, /* SODIMM 58 */
-			   <IMX95_PAD_XSPI1_DATA2__XSPI_DATA_BIT2	0x3fe>, /* SODIMM 60 */
-			   <IMX95_PAD_XSPI1_DATA3__XSPI_DATA_BIT3	0x3fe>, /* SODIMM 62 */
-			   <IMX95_PAD_XSPI1_DQS__XSPI_DQS		0x3fe>; /* SODIMM 66 */
-	};
-
-	/* Verdin GPIO_1 */
-	pinctrl_gpio1: gpio1grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0	0x51e>; /* SODIMM 206 */
-	};
-
-	/* Verdin GPIO_2 */
-	pinctrl_gpio2: gpio2grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18	0x51e>; /* SODIMM 208 */
-	};
-
-	/* Verdin GPIO_3 */
-	pinctrl_gpio3: gpio3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO24__GPIO2_IO_BIT24	0x51e>; /* SODIMM 210 */
-	};
-
-	/* Verdin GPIO_4 */
-	pinctrl_gpio4: gpio4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO32__GPIO5_IO_BIT12	0x51e>; /* SODIMM 212 */
-	};
-
-	/* Verdin GPIO_5_CSI */
-	pinctrl_gpio5: gpio5grp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28	0x51e>; /* SODIMM 216 */
-	};
-
-	/* Verdin GPIO_6_CSI */
-	pinctrl_gpio6: gpio6grp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27	0x51e>; /* SODIMM 218 */
-	};
-
-	/* Verdin I2S_2_BCLK as GPIO (conflict with Verdin I2S_2) */
-	pinctrl_i2s_2_bclk_gpio: i2s2bclkgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA6__GPIO5_IO_BIT6	0x51e>; /* SODIMM 42 */
-	};
-
-	/* Verdin I2S_2_D_IN as GPIO (conflict with Verdin I2S_2) */
-	pinctrl_i2s_2_d_in_gpio: i2s2dingpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA7__GPIO5_IO_BIT7	0x31e>; /* SODIMM 48 */
-	};
-
-	/* Verdin I2S_2_D_OUT as GPIO (conflict with Verdin I2S_2) */
-	pinctrl_i2s_2_d_out_gpio: i2s2doutgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA4__GPIO5_IO_BIT4	0x51e>; /* SODIMM 46 */
-	};
-
-	/* Verdin I2S_2_SYNC as GPIO (conflict with Verdin I2S_2) */
-	pinctrl_i2s_2_sync_gpio: i2s2syncgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA5__GPIO5_IO_BIT5	0x51e>; /* SODIMM 44 */
-	};
-
-	/* Verdin I2C_3_HDMI */
-	pinctrl_i3c2: i3c2cgrp {
-		fsl,pins = <IMX95_PAD_ENET1_MDC__I3C2_SCL	0x40001186>, /* SODIMM 59 */
-			   <IMX95_PAD_ENET1_MDIO__I3C2_SDA	0x40001186>; /* SODIMM 57 */
-	};
-
-	pinctrl_io_exp_int: ioexpintgrp {
-		fsl,pins = <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_BIT13	0x31e>; /* IO_EXP_INT */
-	};
-
-	/* CTRL_I2C (On-module I2C) */
-	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
-		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* CTRL_I2C_SCL */
-			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* CTRL_I2C_SDA */
-	};
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* CTRL_I2C_SCL */
-			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* CTRL_I2C_SDA */
-	};
-
-	/* Verdin I2C_2_DSI */
-	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* SODIMM 53 */
-			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* SODIMM 55 */
-	};
-
-	pinctrl_lpi2c3: lpi2c3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* SODIMM 53 */
-			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* SODIMM 55 */
-	};
-
-	/* Verdin I2C_1 */
-	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>, /* SODIMM 14 */
-			   <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>; /* SODIMM 12 */
-	};
-
-	pinctrl_lpi2c4: lpi2c4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>, /* SODIMM 14 */
-			   <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>; /* SODIMM 12 */
-	};
-
-	/* Verdin I2C_4_CSI */
-	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* SODIMM 93 */
-			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* SODIMM 95 */
-	};
-
-	pinctrl_lpi2c5: lpi2c5grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* SODIMM 93 */
-			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* SODIMM 95 */
-	};
-
-	/* Verdin SPI_1 */
-	pinctrl_lpspi6: lpspi6grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO01__LPSPI6_SIN	0x3fe>, /* SODIMM 198 */
-			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT	0x3fe>, /* SODIMM 200 */
-			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK	0x3fe>; /* SODIMM 196 */
-	};
-
-	/* Verdin QSPI_1_CLK as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_clk_gpio: qspi1clkgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9		0x11e>; /* SODIMM 52 */
-	};
-
-	/* Verdin QSPI_1_CS2# as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_cs2_gpio: qspi1cs2gpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x11e>; /* SODIMM 64 */
-	};
-
-	/* Verdin QSPI_1_CS# as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_cs_gpio: qspi1csgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10	0x11e>; /* SODIMM 54 */
-	};
-
-	/* Verdin QSPI_1_DQS as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_dqs_gpio: qspi1dqsgpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8		0x11e>; /* SODIMM 66 */
-	};
-
-	/* Verdin QSPI_1_IO0 as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_io0_gpio: qspi1io0gpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0	0x119e>; /* SODIMM 56 */
-	};
-
-	/* Verdin QSPI_1_IO1 as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_io1_gpio: qspi1io1gpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1	0x119e>; /* SODIMM 58 */
-	};
-
-	/* Verdin QSPI_1_IO2 as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_io2_gpio: qspi1io2gpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2	0x11e>; /* SODIMM 60 */
-	};
-
-	/* Verdin QSPI_1_IO3 as GPIO (conflict with Verdin QSPI_1 interface) */
-	pinctrl_qspi1_io3_gpio: qspi1io3gpiogrp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3	0x11e>; /* SODIMM 62 */
-	};
-
-	/* Verdin I2S_1 */
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x11e>, /* SODIMM 30 */
-			   <IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0	0x11e>, /* SODIMM 36 */
-			   <IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0	0x11e>, /* SODIMM 34 */
-			   <IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x11e>; /* SODIMM 32 */
-	};
-
-	/* Verdin I2S_1_MCLK */
-	pinctrl_sai3_mclk: sai3mclkgrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO17__SAI3_MCLK	0x31e>; /* SODIMM 38 */
-	};
-
-	/* Verdin I2S_2 */
-	pinctrl_sai5: sai5grp {
-		fsl,pins = <IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0	0x11e>, /* SODIMM 46 */
-			   <IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC		0x11e>, /* SODIMM 44 */
-			   <IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK		0x11e>, /* SODIMM 42 */
-			   <IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0	0x11e>; /* SODIMM 48 */
-	};
-
-	/* Verdin SPI_1_CS */
-	pinctrl_spi1_cs: spi1csgrp {
-		fsl,pins = <IMX95_PAD_CCM_CLKO4__GPIO4_IO_BIT29	0x3fe>; /* SODIMM 202 */
-	};
-
-	/* Verdin PWM_1 */
-	pinctrl_tpm4: tpm4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO05__TPM4_CH0	0x11e>; /* SODIMM 15 */
-	};
-
-	/* Verdin PWM_2 */
-	pinctrl_tpm5: tpm5grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* SODIMM 16 */
-	};
-
-	/* Verdin PWM_3_DSI as GPIO */
-	pinctrl_tpm6_gpio: tpm6gpiogrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO19__GPIO2_IO_BIT19	0x51e>; /* SODIMM 19 */
-	};
-
-	/* Verdin PWM_3_DSI */
-	pinctrl_tpm6: tpm6grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO19__TPM6_CH2	0x11e>; /* SODIMM 19 */
-	};
-
-	/* Verdin UART_3, used as the Linux Console */
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>, /* SODIMM 147 */
-			   <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>; /* SODIMM 149 */
-	};
-
-	/* Verdin UART_4 */
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX	0x31e>, /* SODIMM 151 */
-			   <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX	0x31e>; /* SODIMM 153 */
-	};
-
-	/* Verdin UART_1 */
-	pinctrl_uart7: uart7grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO08__LPUART7_TX	0x31e>, /* SODIMM 131 */
-			   <IMX95_PAD_GPIO_IO09__LPUART7_RX	0x31e>, /* SODIMM 129 */
-			   <IMX95_PAD_GPIO_IO10__LPUART7_CTS_B	0x31e>, /* SODIMM 135 */
-			   <IMX95_PAD_GPIO_IO11__LPUART7_RTS_B	0x31e>; /* SODIMM 133 */
-	};
-
-	/* Verdin UART_2 CTS */
-	pinctrl_uart8_cts: uart8ctsgrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART8_CTS_B	0x31e>; /* SODIMM 143 */
-	};
-
-	/* Verdin UART_2 RTS */
-	pinctrl_uart8_rts: uart8rtsgrp {
-		fsl,pins = <IMX95_PAD_GPIO_IO15__LPUART8_RTS_B	0x31e>; /* SODIMM 141 */
-	};
-
-	/* Verdin UART_2 RX/TX */
-	pinctrl_uart8: uart8grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO12__LPUART8_TX	0x31e>, /* SODIMM 139 */
-			   <IMX95_PAD_GPIO_IO13__LPUART8_RX	0x31e>; /* SODIMM 137 */
-	};
-
-	/* On-module eMMC */
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* SD1_CLK    */
-			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* SD1_CMD    */
-			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* SD1_DATA0  */
-			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* SD1_DATA1  */
-			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* SD1_DATA2  */
-			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* SD1_DATA3  */
-			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* SD1_DATA4  */
-			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* SD1_DATA5  */
-			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* SD1_DATA6  */
-			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* SD1_DATA7  */
-			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* SD1_STROBE */
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* SD1_CLK    */
-			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* SD1_CMD    */
-			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* SD1_DATA0  */
-			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* SD1_DATA1  */
-			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* SD1_DATA2  */
-			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* SD1_DATA3  */
-			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* SD1_DATA4  */
-			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* SD1_DATA5  */
-			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* SD1_DATA6  */
-			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* SD1_DATA7  */
-			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* SD1_STROBE */
-	};
-
-	/* Verdin SD_1 */
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x158e>, /* SODIMM 78 */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x138e>, /* SODIMM 74 */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x138e>, /* SODIMM 80 */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x138e>, /* SODIMM 82 */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x138e>, /* SODIMM 70 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x138e>; /* SODIMM 72 */
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x15fe>, /* SODIMM 78 */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x13fe>, /* SODIMM 74 */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe>, /* SODIMM 80 */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe>, /* SODIMM 82 */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe>, /* SODIMM 70 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe>; /* SODIMM 72 */
-	};
-
-	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
-		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x400>, /* SODIMM 78 */
-			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x400>, /* SODIMM 74 */
-			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x400>, /* SODIMM 80 */
-			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x400>, /* SODIMM 82 */
-			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x400>, /* SODIMM 70 */
-			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x400>; /* SODIMM 72 */
-	};
-
-	/* Verdin SD_1_CD# */
-	pinctrl_usdhc2_cd: usdhc2-cdgrp {
-		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* SODIMM 84 */
-	};
-
-	/* Verdin SD_1_PWR_EN */
-	pinctrl_usdhc2_pwr_en: usdhc2-pwrengrp {
-		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* SODIMM 76 */
-	};
-
-	pinctrl_usdhc2_vsel: usdhc2-vselgrp {
-		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x4>; /* PMIC_SD2_VSEL */
-	};
-
-	/* On-module Wi-Fi on WB SKUs, module-specific SDIO otherwise */
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x158e>, /* SD3_CLK   */
-			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x138e>, /* SD3_CMD   */
-			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x138e>, /* SD3_DATA0 */
-			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x138e>, /* SD3_DATA1 */
-			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x138e>, /* SD3_DATA2 */
-			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x138e>; /* SD3_DATA3 */
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x15fe>, /* SD3_CLK   */
-			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x13fe>, /* SD3_CMD   */
-			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe>, /* SD3_DATA1 */
-			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe>, /* SD3_DATA2 */
-			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe>, /* SD3_DATA3 */
-			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe>; /* SD3_DATA4 */
-	};
-
-	pinctrl_wifi_pwr_en: wifipwrengrp {
-		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x51e>; /* PMIC_EN_WIFI */
-	};
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 1271a3e88e6f..838588be1f63 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -193,6 +193,7 @@ config TARGET_TORADEX_SMARC_IMX95
 config TARGET_VERDIN_IMX95
 	bool "Support Toradex Verdin iMX95 module"
 	select IMX95
+	imply OF_UPSTREAM
 
 config TARGET_IMX952_EVK
 	bool "imx952_evk"
diff --git a/board/toradex/verdin-imx95/MAINTAINERS b/board/toradex/verdin-imx95/MAINTAINERS
index d19ee3ebfe5d..cb7bf125c223 100644
--- a/board/toradex/verdin-imx95/MAINTAINERS
+++ b/board/toradex/verdin-imx95/MAINTAINERS
@@ -1,8 +1,4 @@
 Verdin iMX95
-F:	arch/arm/dts/imx95-verdin.dtsi
-F:	arch/arm/dts/imx95-verdin-dev.dtsi
-F:	arch/arm/dts/imx95-verdin-wifi.dtsi
-F:	arch/arm/dts/imx95-verdin-wifi-dev.dts
 F:	arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
 F:	board/toradex/verdin-imx95/
 F:	configs/verdin-imx95_defconfig
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index d7076231bbe9..bb8d26c6525f 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx95-verdin-wifi-dev"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-verdin-wifi-dev"
 CONFIG_TARGET_VERDIN_IMX95=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288

base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
-- 
2.53.0

