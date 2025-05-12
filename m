Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE9C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 17:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC26382AD2;
	Mon, 12 May 2025 19:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MkkRcYma";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fk6A24bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5533B82AB1; Mon, 12 May 2025 19:22:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4539B82A55
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 19:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zx5yZ71zBz9smH;
 Mon, 12 May 2025 19:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeXd+WlBnri4ZTOv82UditI3xm6q0kQ4rGwC4nDMjW0=;
 b=MkkRcYmaaqWaLWGmZbavADpP/HfJi2/eguKhJnJBet/XaW0rXkbbUZth0z5g8Y6eyPxCLG
 N2BLykns9u2kNW0XA6Kgn36RLiQUzelSPecBG2c+V89sO3HQ+RTztCfgJi+uYpOpN+huCp
 Gtq5sHGglUKhf3v+QqRppheEPPBc0sfWKh3kWpUHzAOJzCt3xiEXmLSU04ynGc2UyIuG/1
 gdMb/UpLW8+hum8A2iuLFCsCYIWiF8TUpWIyeFRZbDjYdzCdCquNtYJUe4LUwDm9lqQuiX
 NeODl+eXNgNs1VJW+CxZhiuo77nkK9ITAQ90APDAZ2M3KgwNnfTXkFJeL2aAaA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747070549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeXd+WlBnri4ZTOv82UditI3xm6q0kQ4rGwC4nDMjW0=;
 b=fk6A24bcTvPtfmhk59JgXXraGKwVa0R/PcpKcDgK86nM8GG0QBUEUtPxl+OhrlN8fB0Uuu
 eS0anecCBSR+ikgJpKIGcZ44Mg+9/hY8pp4Jh8WPz8pfvagMEBcC9LIUyeAuDC5Q0F/xVR
 gcZ40pAV0r+Ndbozg9JOpkCWGcQ7QvgaBfzTMw8AZXGC+0voahozvDbOMNYCLfMOk5HbhC
 CPupD8lRj5uya6NZsqPDJZIJR/R4eACBdVFzR3iT9M58fbUc0GCKB0dQnNsFCoRRA/iyaV
 pGNPcX9+KxXyl3MNQQwZZ17bgHf5PrGZY2wGZHaKIDkrI5347E/oo/qo9xt9oQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/10] ARM: dts: stm32: Add SPL specifics for DH STM32MP13xx
 DHCOR DHSBC
Date: Mon, 12 May 2025 19:21:36 +0200
Message-ID: <20250512172149.150214-10-marek.vasut@mailbox.org>
In-Reply-To: <20250512172149.150214-1-marek.vasut@mailbox.org>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ffc786f15216d8c3ffb
X-MBO-RS-META: mqd6i64zazdogngcrtycn8soau69biob
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

Add SPL specific DT additions to DH STM32MP13xx DHCOR DHSBC . These
include I2C3 configuration which is required to access the PMIC,
PMIC regulator and QSPI NOR bootph-all properties to allow SPL to
configure PMIC buck regulators and load from QSPI NOR respectively,
etzpc bus switch to simple-bus to prevent interference from TFABOOT
specific configuration, and RCC configuration to define clock tree
configuration used by this platform.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Cheick Traore <cheick.traore@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi | 155 ++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
index 6117da10bbf..b5952637442 100644
--- a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Marek Vasut <marex@denx.de>
  */
 
+#include <dt-bindings/clock/stm32mp13-clksrc.h>
 #include "stm32mp13-u-boot.dtsi"
 #include "stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi"
 
@@ -19,8 +20,12 @@
 	};
 };
 
+&etzpc {
+	compatible = "simple-bus";
+};
+
 &flash0 {
-	bootph-pre-ram;
+	bootph-all;
 
 	partitions {
 		compatible = "fixed-partitions";
@@ -49,6 +54,134 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_a>;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&qspi_clk_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
+&qspi_bk1_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
+&qspi_cs1_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
+&pinctrl {
+	bootph-all;
+	i2c3_pins_a: i2c3-0 {
+	        bootph-all;
+		pins {
+			bootph-all;
+			pinmux = <STM32_PINMUX('B', 8, AF5)>, /* I2C3_SCL */
+				 <STM32_PINMUX('H', 14, AF4)>; /* I2C3_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&rcc {
+	clocks = <&clk_hse>, <&clk_hsi>, <&clk_csi>, <&clk_lse>, <&clk_lsi>;
+
+	st,clksrc = <
+		CLK_MPU_PLL1P
+		CLK_AXI_PLL2P
+		CLK_MLAHBS_PLL3
+		CLK_PLL12_HSE
+		CLK_PLL3_HSE
+		CLK_PLL4_HSE
+		CLK_CKPER_HSE
+		CLK_RTC_LSE
+		CLK_MCO1_LSI
+		CLK_MCO2_HSI
+	>;
+
+	st,clkdiv = <
+		0 /*AXI*/
+		0 /*MLHAB*/
+		1 /*APB1*/
+		1 /*APB2*/
+		1 /*APB3*/
+		1 /*APB4*/
+		2 /*APB5*/
+		1 /*APB6*/
+		0 /*RTC*/
+	>;
+
+	st,pkcs = <
+		CLK_I2C12_HSI
+		CLK_I2C3_HSI
+		CLK_QSPI_PLL3R
+		CLK_SAES_AXI
+		CLK_SDMMC1_PLL3R
+		CLK_SDMMC2_PLL3R
+		CLK_STGEN_HSE
+		CLK_UART2_HSI
+		CLK_UART4_HSI
+		CLK_USBO_USBPHY
+		CLK_USBPHY_HSE
+	>;
+
+	/*
+	 * cfg = < DIVM1 DIVN P Q R PQR(p,q,r) >;
+	 * frac = < f >;
+	 *
+	 * PRQ(p,q,r) ... for p,q,r: 0-output disabled / 1-output enabled
+	 * DIVN ... actually multiplier, but RCC_PLL1CFGR1 calls the field DIVN
+	 * m ... for PLL1,2: m=2 ; for PLL3,4: m=1
+	 * XTAL = 24 MHz
+	 *
+	 * VCO = ( XTAL / (DIVM1 + 1) ) * m * ( DIVN + 1 + ( f / 8192 ) )
+	 *   P = VCO / (P + 1)
+	 *   Q = VCO / (Q + 1)
+	 *   R = VCO / (R + 1)
+	 */
+
+	/* VCO = 1066.0 MHz => P = 266 (AXI), Q = 266, R = 533 (DDR) */
+	pll2: st,pll@1 {
+		compatible = "st,stm32mp1-pll";
+		reg = <1>;
+		cfg = < 2 65 1 1 0 PQR(1,1,1) >;
+		frac = < 0x1400 >;
+		bootph-all;
+	};
+
+	/* VCO = 600 MHz => P = 200, Q = 150, R = 200 */
+	pll3: st,pll@2 {
+		compatible = "st,stm32mp1-pll";
+		reg = <2>;
+		cfg = < 2 74 2 3 2 PQR(1,1,1) >;
+		bootph-all;
+	};
+
+	/* VCO = 750.0 MHz => P = 125, Q = 83, R = 75 */
+	pll4: st,pll@3 {
+		compatible = "st,stm32mp1-pll";
+		reg = <3>;
+		cfg = < 3 124 5 8 9 PQR(1,1,1) >;
+		bootph-all;
+	};
+};
+
 &sdmmc1 {
 	status = "disabled";
 };
@@ -56,3 +189,23 @@
 &usbotg_hs {
 	u-boot,force-b-session-valid;
 };
+
+&vddcpu {
+	bootph-all;
+};
+
+&vdd_ddr {
+	bootph-all;
+};
+
+&vdd {
+	bootph-all;
+};
+
+&vddcore {
+	bootph-all;
+};
+
+&vref_ddr {
+	bootph-all;
+};
-- 
2.47.2

