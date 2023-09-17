Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F21CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0690986AD0;
	Sun, 17 Sep 2023 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MP81P4wr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pcTuWjZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866E186B10; Sun, 17 Sep 2023 16:14:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF2686B2E
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVKM4wc2z9spF
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdF7x3Ev+xyMcnpoRXJLI9GuFugyDN33No8eiBOLUjs=;
 b=MP81P4wr/GUPR6aDpvEoniOSc3CLQc34sXXnCgZDBqzOKd+KUjjXePwbznmaPvNMaZGx/q
 P31HWTVTChOZvibSXZzJzdVyI56zN2DfVWOz1V2Sxm5SaiiFwGtndexn0NdJE0ohJ7f/B/
 moxbM2E5IKyQe3tRzxTe/8c9CYS4Xb047+d1nU3jYpj1W9jxT4HNksHPaF8rwI5AGequaC
 56zo5fLFGiAjWSsC3AecOJgNKtaklWm96bBAWrMuH98vy2CMG1+vAwamG/TKF/qL8+Rirl
 ka5mOyX9MXYZpWhN7KdKKm9QWTf4P40vaj8rGopt2D67wgY041EwjeJUr8lK8Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdF7x3Ev+xyMcnpoRXJLI9GuFugyDN33No8eiBOLUjs=;
 b=pcTuWjZgJ+936tuh6d59s7kW4sFTe8LEhhTB+lcZoDkEgbvAxl8AGNFVeEEb1ZrCOcmnwM
 e2F3WdHkoosz8AX2yeSidAW21XFtMMSrl7z7emSPBtv14Q0bUkdLT4JtvP85G/COdORIy5
 ziBJGnDO84mPt2GWEdoWoXNYoI7Bmm0xNqNssBCXdLDnXM60rvGnOFgD+jcTzC6Z8G70p1
 sIo1t9Kg21GS4YvgZgf1XmzMXS7HRFOHNpLeu8KzBuqWN9JaTPrP7UskORAc7R9KMRng4l
 zKfPVakYUiLdF79AbsvUyRhOCtJ2UH2LHr3TzW9vbCulzBFLKC1qFeA0+exP7g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/19] ARM: dts: renesas: Synchronize RZ R7S72100 RZ/A1 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:14 +0200
Message-Id: <20230917141319.379939-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2f5450b3aa574f43fcd
X-MBO-RS-META: 1zsywuodg4uh5eqs6zqddz4imbb73o1n
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

Synchronize RZ R7S72100 RZ/A1 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r7s72100-gr-peach.dts |  3 ++
 arch/arm/dts/r7s72100.dtsi         | 56 ++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/r7s72100-gr-peach.dts b/arch/arm/dts/r7s72100-gr-peach.dts
index 70d034c26dd..105f9c71f9f 100644
--- a/arch/arm/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/dts/r7s72100-gr-peach.dts
@@ -41,6 +41,9 @@
 		bank-width = <4>;
 		device-width = <1>;
 
+		clocks = <&mstp9_clks R7S72100_CLK_SPIBSC0>;
+		power-domains = <&cpg_clocks>;
+
 		#address-cells = <1>;
 		#size-cells = <1>;
 
diff --git a/arch/arm/dts/r7s72100.dtsi b/arch/arm/dts/r7s72100.dtsi
index 2211f88ede2..b07b71307f2 100644
--- a/arch/arm/dts/r7s72100.dtsi
+++ b/arch/arm/dts/r7s72100.dtsi
@@ -313,9 +313,9 @@
 		mmcif: mmc@e804c800 {
 			compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
 			reg = <0xe804c800 0x80>;
-			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
 			power-domains = <&cpg_clocks>;
 			reg-io-width = <4>;
@@ -323,12 +323,12 @@
 			status = "disabled";
 		};
 
-		sdhi0: sd@e804e000 {
+		sdhi0: mmc@e804e000 {
 			compatible = "renesas,sdhi-r7s72100";
 			reg = <0xe804e000 0x100>;
-			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
 				 <&mstp12_clks R7S72100_CLK_SDHI01>;
@@ -339,12 +339,12 @@
 			status = "disabled";
 		};
 
-		sdhi1: sd@e804e800 {
+		sdhi1: mmc@e804e800 {
 			compatible = "renesas,sdhi-r7s72100";
 			reg = <0xe804e800 0x100>;
-			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
 				 <&mstp12_clks R7S72100_CLK_SDHI11>;
@@ -467,11 +467,12 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0438 4>;
-			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
+			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>, <&b_clk>, <&b_clk>;
 			clock-indices = <
 				R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
+				R7S72100_CLK_SPIBSC0 R7S72100_CLK_SPIBSC1
 			>;
-			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
+			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "spibsc0", "spibsc1";
 		};
 
 		mstp10_clks: mstp10_clks@fcfe043c {
@@ -498,7 +499,7 @@
 			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
 		};
 
-		pinctrl: pin-controller@fcfe3000 {
+		pinctrl: pinctrl@fcfe3000 {
 			compatible = "renesas,r7s72100-ports";
 
 			reg = <0xfcfe3000 0x4230>;
@@ -607,6 +608,8 @@
 				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
 			clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
 			clock-frequency = <100000>;
 			power-domains = <&cpg_clocks>;
@@ -626,6 +629,8 @@
 				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
 			clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
 			clock-frequency = <100000>;
 			power-domains = <&cpg_clocks>;
@@ -645,6 +650,8 @@
 				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
 			clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
 			clock-frequency = <100000>;
 			power-domains = <&cpg_clocks>;
@@ -664,12 +671,33 @@
 				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
 			clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
 			clock-frequency = <100000>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
 
+		irqc: interrupt-controller@fcfef800 {
+			compatible = "renesas,r7s72100-irqc",
+				     "renesas,rza1-irqc";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0xfcfef800 0x6>;
+			interrupt-map =
+				<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <7 0>;
+		};
+
 		mtu2: timer@fcff0000 {
 			compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
 			reg = <0xfcff0000 0x400>;
-- 
2.40.1

