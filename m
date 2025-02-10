Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C584C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E9680C5A;
	Mon, 10 Feb 2025 07:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="aXCQN0U8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90B180BAE; Mon, 10 Feb 2025 07:52:25 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E96C80C69
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170343; x=1770706343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x4+L/t1U86musoYg5SV4v7UuR2lEo/cDryr+DQxKxtQ=;
 b=aXCQN0U8YowCvoAOxRJnYXExm6rFSsJOXrPQM2BqYIXMsIxFqufgdeV0
 YJl2whnaTfz2WmH4/EQxBKkukB61icd2JNTQFNpX4D5L4khi1aD4LGgg4
 4+tUlZs/bIt/XOVsd9in65eVfKoBGKXfiBG1ZNw8KrZoV7R65NQCFL9so
 1mIgficoh27xgzvarKIqbygWLebwuzv92EnIs0dQI4GHW6mfRRioCdXgO
 xFAVIJ1EpEISfxpPQkJxrphnz/L5Av6dAyp3L8tZzQtdg4kNq1jTzWv98
 rpivHmoPDfYiidc5+C19OR9MgOHr6eVFzp4QeVAWY88yHMRW1eYCb2PoB A==;
X-CSE-ConnectionGUID: l7eC6ISbRG2IhJavUmxzKw==
X-CSE-MsgGUID: 6mntJM2NQfWjGTJCwTo3zQ==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072176"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:51:58 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:51:56 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 3/7] ARM: dts: at91: sam9x60: Move pinmux node to board DTS
Date: Mon, 10 Feb 2025 12:21:39 +0530
Message-ID: <20250210065143.313553-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Move pinmux nodes defined under the pinctrl node from sam9x60 SoC
DT to its board specific DTS files.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 71 +++++++++++++++++++++++++
 arch/arm/dts/sam9x60.dtsi               | 63 ----------------------
 arch/arm/dts/sam9x60ek.dts              | 71 +++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 63 deletions(-)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 99867d2bf8e..7f00014f13c 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -82,6 +82,11 @@
 	};
 };
 
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu>;
+};
+
 &ebi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_0_7>;
@@ -171,10 +176,20 @@
 
 &macb0 {
 	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_rmii>;
 	status = "okay";
 };
 
 &pinctrl {
+	dbgu {
+		pinctrl_dbgu: dbgu-0 {
+			atmel,pins =
+				<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
 	ebi {
 		pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
 			atmel,pins =
@@ -217,6 +232,22 @@
 		};
 	};
 
+	macb0 {
+		pinctrl_macb0_rmii: macb0_rmii-0 {
+			atmel,pins =
+				<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB0 periph A */
+				 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
+				 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
+				 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
+				 AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
+				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
+				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
+				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
+				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
+		};
+	};
+
 	nand {
 		pinctrl_nand_oe_we: nand-oe-we-0 {
 			atmel,pins =
@@ -240,6 +271,36 @@
 			<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 	};
 
+	sdhci0 {
+		pinctrl_sdhci0: sdhci0 {
+			atmel,pins =
+				<AT91_PIOA 17 AT91_PERIPH_A
+				 (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA17 CK  periph A with pullup */
+				 AT91_PIOA 16 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA16 CMD periph A with pullup */
+				 AT91_PIOA 15 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA15 DAT0 periph A */
+				 AT91_PIOA 18 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA18 DAT1 periph A with pullup */
+				 AT91_PIOA 19 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA19 DAT2 periph A with pullup */
+				 AT91_PIOA 20 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;	/* PA20 DAT3 periph A with pullup */
+		};
+	};
+
+	sdhci1 {
+		pinctrl_sdhci1: sdhci1 {
+			atmel,pins =
+				<AT91_PIOA 13 AT91_PERIPH_B (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA13 CK periph B */
+				 AT91_PIOA 12 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA12 CMD periph B with pullup */
+				 AT91_PIOA 11 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA11 DAT0 periph B with pullup */
+				 AT91_PIOA 2 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA2 DAT1 periph B with pullup */
+				 AT91_PIOA 3 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA3 DAT2 periph B with pullup */
+				 AT91_PIOA 4 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA4 DAT3 periph B with pullup */
+		};
+	};
+
 	usb1 {
 		pinctrl_usb_default: usb_default {
 			atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
@@ -248,6 +309,16 @@
 	};
 };
 
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0>;
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1>;
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 4ff10857a09..97d9c5cefc3 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -123,8 +123,6 @@
 			assigned-clock-rates = <100000000>;
 			assigned-clock-parents = <&pmc PMC_TYPE_CORE 10>; /* ID_PLL_A_DIV */
 			bus-width = <4>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_sdhci0>;
 		};
 
 		sdhci1: sdhci-host@90000000 {
@@ -136,8 +134,6 @@
 			assigned-clock-rates = <100000000>;
 			assigned-clock-parents = <&pmc PMC_TYPE_CORE 10>; /* ID_PLL_A_DIV */
 			bus-width = <4>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_sdhci1>;
 		};
 
 		apb {
@@ -177,8 +173,6 @@
 			macb0: ethernet@f802c000 {
 				compatible = "cdns,sam9x60-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_macb0_rmii>;
 				clock-names = "hclk", "pclk";
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_PERIPHERAL 24>;
 				status = "disabled";
@@ -211,8 +205,6 @@
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
 				clock-names = "usart";
 			};
@@ -226,61 +218,6 @@
 				       0xfffff600 0x200		/* pioB */
 				       0xfffff800 0x200		/* pioC */
 				       0xfffffa00 0x200>;	/* pioD */
-
-				/* shared pinctrl settings */
-				dbgu {
-					pinctrl_dbgu: dbgu-0 {
-						atmel,pins =
-							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
-							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
-					};
-				};
-
-				macb0 {
-					pinctrl_macb0_rmii: macb0_rmii-0 {
-						atmel,pins =
-							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB0 periph A */
-							 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
-							 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
-							 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
-							 AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
-							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
-							 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
-							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
-							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
-							 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
-					};
-				};
-
-				sdhci0 {
-					pinctrl_sdhci0: sdhci0 {
-						atmel,pins =
-							<AT91_PIOA 17 AT91_PERIPH_A
-							 (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA17 CK  periph A with pullup */
-							 AT91_PIOA 16 AT91_PERIPH_A
-							 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA16 CMD periph A with pullup */
-							 AT91_PIOA 15 AT91_PERIPH_A
-							 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA15 DAT0 periph A */
-							 AT91_PIOA 18 AT91_PERIPH_A
-							 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA18 DAT1 periph A with pullup */
-							 AT91_PIOA 19 AT91_PERIPH_A
-							 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA19 DAT2 periph A with pullup */
-							 AT91_PIOA 20 AT91_PERIPH_A
-							 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;	/* PA20 DAT3 periph A with pullup */
-					};
-				};
-
-				sdhci1 {
-					pinctrl_sdhci1: sdhci1 {
-						atmel,pins =
-							<AT91_PIOA 13 AT91_PERIPH_B (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA13 CK periph B */
-							 AT91_PIOA 12 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA12 CMD periph B with pullup */
-							 AT91_PIOA 11 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA11 DAT0 periph B with pullup */
-							 AT91_PIOA  2 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA2 DAT1 periph B with pullup */
-							 AT91_PIOA  3 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA3 DAT2 periph B with pullup */
-							 AT91_PIOA  4 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA4 DAT3 periph B with pullup */
-					};
-				};
 			};
 
 			pioA: gpio@fffff400 {
diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
index 3bf45c14e42..6521585ee9c 100644
--- a/arch/arm/dts/sam9x60ek.dts
+++ b/arch/arm/dts/sam9x60ek.dts
@@ -82,6 +82,11 @@
 	};
 };
 
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu>;
+};
+
 &ebi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_0_7>;
@@ -149,11 +154,21 @@
 
 &macb0 {
 	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_rmii>;
 	status = "okay";
 };
 
 &pinctrl {
 	/* shared pinctrl settings */
+	dbgu {
+		pinctrl_dbgu: dbgu-0 {
+			atmel,pins =
+				<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
 	qspi {
 		pinctrl_qspi: qspi {
 			atmel,pins =
@@ -212,11 +227,57 @@
 		};
 	};
 
+	macb0 {
+		pinctrl_macb0_rmii: macb0_rmii-0 {
+			atmel,pins =
+				<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB0 periph A */
+				 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
+				 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
+				 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
+				 AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
+				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
+				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
+				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
+				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
+		};
+	};
+
 	pinctrl_onewire_tm_default: onewire_tm_default {
 		atmel,pins =
 			<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
 	};
 
+	sdhci0 {
+		pinctrl_sdhci0: sdhci0 {
+			atmel,pins =
+				<AT91_PIOA 17 AT91_PERIPH_A
+				 (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA17 CK  periph A with pullup */
+				 AT91_PIOA 16 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA16 CMD periph A with pullup */
+				 AT91_PIOA 15 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA15 DAT0 periph A */
+				 AT91_PIOA 18 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA18 DAT1 periph A with pullup */
+				 AT91_PIOA 19 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)	/* PA19 DAT2 periph A with pullup */
+				 AT91_PIOA 20 AT91_PERIPH_A
+				 (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;	/* PA20 DAT3 periph A with pullup */
+		};
+	};
+
+	sdhci1 {
+		pinctrl_sdhci1: sdhci1 {
+			atmel,pins =
+				<AT91_PIOA 13 AT91_PERIPH_B (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA13 CK periph B */
+				 AT91_PIOA 12 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA12 CMD periph B with pullup */
+				 AT91_PIOA 11 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA11 DAT0 periph B with pullup */
+				 AT91_PIOA 2 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA2 DAT1 periph B with pullup */
+				 AT91_PIOA 3 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA3 DAT2 periph B with pullup */
+				 AT91_PIOA 4 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA4 DAT3 periph B with pullup */
+		};
+	};
+
 	usb1 {
 		pinctrl_usb_default: usb_default {
 			atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
@@ -225,6 +286,16 @@
 	};
 };
 
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0>;
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1>;
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
-- 
2.25.1

