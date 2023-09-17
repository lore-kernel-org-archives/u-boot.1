Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BFECD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587A686B56;
	Sun, 17 Sep 2023 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hUabWEif";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jCMEscdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54AF686B05; Sun, 17 Sep 2023 16:14:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE1386B34
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVKN1FcZz9sWQ
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+mpNKkvkzxzAz0HK2fNLVgOhCt2oaIIILdKMBBW34I=;
 b=hUabWEifM07HdyiiM/DrFghtOJFzLqW58TKmEVuI1960LfljtKaYVnTOdPZRxLrnvLrjmP
 d9yAJxXggbPBqddsviV+Py6XQNgKAzmgjunbrdBYROvZM5vq/RobwnDIlHuO2z6/MDQ86y
 hrdQ+JSweBUzPi8bHpEKcMKGKdzZZT1XskNucAb9ExM3gsLpyCeVpSuJ0jE/lF9cRmXIN6
 VlbdjhaLeAI4IkuO8ZzqUudnuWxyxVYdfR1gFwL+mhUcBFhHf8PGVK1MLWGBkHqiVUwuEH
 IedZ3BBrO+Clb/WLc6DzqMELPI/lCR3Y41Vs9wfGyuyySIutMzuDCUXI8Bu2Cw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+mpNKkvkzxzAz0HK2fNLVgOhCt2oaIIILdKMBBW34I=;
 b=jCMEscdzy1SYGMp43YHVqbvnOlts6wq83Bxj3PQolj2M6mIG+R++OOyOcrS1bbn0yObBkc
 fIANA1xf5wKQ/3Q85ePcrgmCOAmnqqKFlw+ok8i2W6qDfb/6e5uHSTh5lQhBTBJjjeyhpN
 E5Z4hejiopNCDAkfZAywYJ8ln4Zbpp0r/4zckxoQmE7AgtAQWoM31Z94UIOYvt7Q7Jfizx
 74jneNENfb3bgaDiJqPKYC4lek7apcDvF1p/VRDKIzWIWefwOnY7uxtxnX9kKu6Urg1ZyW
 pVijdQhP28jhqWOpIViNwt9dS4Mq5oyV+/jDMWVpm8kvGa/Pmf7GR6yC+p8vcQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/19] ARM: dts: renesas: Synchronize RZ R8A774A1 RZ/G2M DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:15 +0200
Message-Id: <20230917141319.379939-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dbcf90282ffdb69f15b
X-MBO-RS-META: r3r8wmmmdexghqt5mpemqsmskk7u6p6x
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

Synchronize RZ R8A774A1 RZ/G2M DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/beacon-renesom-baseboard.dtsi | 45 ++++++++++++++--------
 arch/arm/dts/beacon-renesom-som.dtsi       |  2 +-
 arch/arm/dts/hihope-common.dtsi            | 21 ++++++++--
 arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts | 21 ----------
 arch/arm/dts/r8a774a1-u-boot.dtsi          |  1 -
 arch/arm/dts/r8a774a1.dtsi                 | 14 ++++---
 6 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/arch/arm/dts/beacon-renesom-baseboard.dtsi b/arch/arm/dts/beacon-renesom-baseboard.dtsi
index 8166e3c1ff4..2e9927b9773 100644
--- a/arch/arm/dts/beacon-renesom-baseboard.dtsi
+++ b/arch/arm/dts/beacon-renesom-baseboard.dtsi
@@ -367,7 +367,7 @@
 
 		assigned-clocks = <&versaclock6_bb 1>, <&versaclock6_bb 2>,
 				  <&versaclock6_bb 3>, <&versaclock6_bb 4>;
-		assigned-clock-rates = <24000000>, <24000000>, <24000000>,
+		assigned-clock-rates = <24000000>, <24000000>, <24576000>,
 				       <24576000>;
 
 		OUT1 {
@@ -437,20 +437,6 @@
 		};
 	};
 
-	/* 0 - lcd_reset */
-	/* 1 - lcd_pwr */
-	/* 2 - lcd_select */
-	/* 3 - backlight-enable */
-	/* 4 - Touch_shdwn */
-	/* 5 - LCD_H_pol */
-	/* 6 - lcd_V_pol */
-	gpio_exp1: gpio@20 {
-		compatible = "onnn,pca9654";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	touchscreen@26 {
 		compatible = "ilitek,ili2117";
 		reg = <0x26>;
@@ -482,6 +468,16 @@
 			};
 		};
 	};
+
+	gpio_exp1: gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "lcd_reset", "lcd_pwr", "lcd_select",
+				  "backlight-enable", "Touch_shdwn",
+				  "LCD_H_pol", "lcd_V_pol";
+	};
 };
 
 &lvds0 {
@@ -638,6 +634,25 @@
 	#clock-cells = <1>;
 	clock-frequency = <11289600>;
 
+	/* Reference versaclock instead of audio_clk_a */
+	clocks = <&cpg CPG_MOD 1005>,
+		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&versaclock6_bb 4>, <&audio_clk_b>,
+		 <&audio_clk_c>,
+		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
+
 	status = "okay";
 
 	ports {
diff --git a/arch/arm/dts/beacon-renesom-som.dtsi b/arch/arm/dts/beacon-renesom-som.dtsi
index d3fc8ffd5b4..68b04e56ae5 100644
--- a/arch/arm/dts/beacon-renesom-som.dtsi
+++ b/arch/arm/dts/beacon-renesom-som.dtsi
@@ -59,7 +59,7 @@
 	status = "okay";
 
 	phy0: ethernet-phy@0 {
-		compatible = "ethernet-phy-id004d.d074",
+		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
diff --git a/arch/arm/dts/hihope-common.dtsi b/arch/arm/dts/hihope-common.dtsi
index b1eb6a08029..83104af2813 100644
--- a/arch/arm/dts/hihope-common.dtsi
+++ b/arch/arm/dts/hihope-common.dtsi
@@ -3,15 +3,26 @@
  * Device Tree Source for the HiHope RZ/G2H Rev.4.0 and
  * HiHope RZ/G2[MN] Rev.[2.0/3.0/4.0] main board common parts
  *
- * Copyright (C) 2021 Renesas Electronics Corp.
+ * Copyright (C) 2019 Renesas Electronics Corp.
  */
 
 #include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &iic_pmic;
 		serial0 = &scif2;
 		serial1 = &hscif0;
+		mmc0 = &sdhi3;
+		mmc1 = &sdhi0;
+		mmc2 = &sdhi2;
 	};
 
 	chosen {
@@ -50,7 +61,7 @@
 		};
 	};
 
-	reg_1p8v: regulator0 {
+	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -59,7 +70,7 @@
 		regulator-always-on;
 	};
 
-	reg_3p3v: regulator1 {
+	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -137,7 +148,7 @@
 };
 
 &gpio6 {
-	usb1-reset {
+	usb1-reset-hog {
 		gpio-hog;
 		gpios = <10 GPIO_ACTIVE_LOW>;
 		output-low;
@@ -328,6 +339,8 @@
 	vqmmc-supply = <&reg_1p8v>;
 	bus-width = <8>;
 	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
 	non-removable;
 	fixed-emmc-driver-type = <1>;
 	status = "okay";
diff --git a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts b/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
index 9ae67263c0d..24da6ee6ecc 100644
--- a/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
+++ b/arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
@@ -58,24 +58,3 @@
 	clock-names = "du.0", "du.1", "du.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
-
-/* Reference versaclock instead of audio_clk_a */
-&rcar_sound {
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A774A1_CLK_S0D4>;
-};
diff --git a/arch/arm/dts/r8a774a1-u-boot.dtsi b/arch/arm/dts/r8a774a1-u-boot.dtsi
index cddffe87645..38f5bfe85fc 100644
--- a/arch/arm/dts/r8a774a1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774a1-u-boot.dtsi
@@ -28,7 +28,6 @@
 /delete-node/ &hdmi0;
 /delete-node/ &lvds0;
 /delete-node/ &rcar_sound;
-/delete-node/ &sdhi2;
 /delete-node/ &sound_card;
 /delete-node/ &vin0;
 /delete-node/ &vin1;
diff --git a/arch/arm/dts/r8a774a1.dtsi b/arch/arm/dts/r8a774a1.dtsi
index 7e643243c3b..9065dc24342 100644
--- a/arch/arm/dts/r8a774a1.dtsi
+++ b/arch/arm/dts/r8a774a1.dtsi
@@ -1678,7 +1678,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -2359,8 +2359,8 @@
 				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
 				 <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
 				 <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
@@ -2371,6 +2371,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
@@ -2386,8 +2388,8 @@
 				 <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
 				 <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
 				 <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
@@ -2398,6 +2400,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 318>;
+			iommu-map = <0 &ipmmu_hc 1 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

