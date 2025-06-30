Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA8EC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 00:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB958303B;
	Mon, 30 Jun 2025 02:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NfmEjBli";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sLuI+CyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C8783037; Mon, 30 Jun 2025 02:11:32 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD1B83010
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bVmmB0PbDz9sWs;
 Mon, 30 Jun 2025 02:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN3FLz7ePs8SGb72juhXIbHiLbXSjrDqQtFs0Rea0N8=;
 b=NfmEjBli71f6J6erCnaoSAVlr2LYPom3DSS3Kvjbl9JSFVHCLhpX2lgx9v0E0z6xUCTNJU
 p3Hxi0MfjyvA34Tc7xku3S3sYLHTeD9uo5hMjPp1XgVPgQogOot/MdR2JVlGsKPCkHg001
 UW9NHGkUMa9bLiS6q1u0aVdYRPzKLDeSt90k1nyy7KDlkKhgwvZwNYjwnkGUMIfCGQhd3i
 XeDKTPZBh77PV/oZLnJlelg7vaV2WPyvDpgYx9RxzQuvqwbP+L2AVJuQFeQuu0WbZ0RvYj
 pj1+PYNRU7JEKDw+GNniZZJWT+x3bIfjA2pCJKMK9KnxwzhuVZ8duGGOcVvk3A==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN3FLz7ePs8SGb72juhXIbHiLbXSjrDqQtFs0Rea0N8=;
 b=sLuI+CyM/j0kqhOxxWR8f4azQGiMe9+aH3D8VmiJpsNmb6lRSg3v6LZrV+1zU74mw53dAv
 IMO2YbLNSIJFpzAt1VzFcP+XIJQzkqtAG9RD1HvObeujajiyQ7bJCX2hp8Tx9X9ULYDpcc
 nrw/sg6m6veNGqTBc32pDDMkCXLusVWvTSORBZHvbw0TSy8oTQaV967N7/yP9vhALeRkv3
 QrztPfEjF+7CBK9m2cbTaPCfTwjDERtyJ0GuYzK8ibXHZeNiFmGboRZBUingYzTKipfE8o
 46U9JFVuMc5YQb9tlz0SSGYyNoihJxmGWZn3JLB/MqNtcEW7ptvN5nC8j0p62g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 09/10] ARM: dts: stm32: Add SPL specifics for DH
 STM32MP13xx DHCOR DHSBC
Date: Mon, 30 Jun 2025 02:10:35 +0200
Message-ID: <20250630001053.952342-9-marek.vasut@mailbox.org>
In-Reply-To: <20250630001053.952342-1-marek.vasut@mailbox.org>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mp4ztix95g93tjq83gortu5wientnqi6
X-MBO-RS-ID: 2ac241b0a7c92d0e5be
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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
V2: - Add RB from Patrice
    - Wrap the RCC node in if !TFABOOT
---
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi | 159 ++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
index 6117da10bbf..f76fe63281b 100644
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
@@ -49,6 +54,138 @@
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
+#if !defined(CONFIG_TFABOOT)
+&rcc {
+	#address-cells = <1>;
+	#size-cells = <0>;
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
+#endif
+
 &sdmmc1 {
 	status = "disabled";
 };
@@ -56,3 +193,23 @@
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

