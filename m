Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15F0C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0979E828BC;
	Mon,  2 Jun 2025 21:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDaSwxLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1710C82B19; Mon,  2 Jun 2025 21:47:17 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C00828BC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e7c5d4709caso4677106276.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893632; x=1749498432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKuPuQ2vyne6iQJEOMiCCYVcgOJlzAyOeUrLJZUAInw=;
 b=RDaSwxLbyn+3aIkodf/hC5Engr37+9dwvmDV6sJwwDYX+nX2zdvaz0p56yhPbN7V+I
 r+SHvdHP2ValV4GSyKeoIuxU9tZ+zgCOmFc0F/nUNnpAYgrmDbNPg2NNHhcsQNHUKtn1
 6bj+N2bVSCJ8qygGpbnY7P2TrIqbB3ZkUpqcth86MzVx2//5vDl53zN6FTCfpH9c8adz
 quMlJlaghnqdUIfzyw287rn8TTY4oyMxRYC8Nw1VAuA507UJakOXT+I662rFk6OFrMe+
 OM427/yltuq3UzZsU4YgdpLdJjxvUv+sSi/Ghlf2DBp4hGpe3m8lsX2+Ev7VvNnwgJ9E
 ponA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893632; x=1749498432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKuPuQ2vyne6iQJEOMiCCYVcgOJlzAyOeUrLJZUAInw=;
 b=vbQ8hHzkEa1RdUdAMop5JmqugC9l5GsogV6QctvkHnI64c2Afjd3Du+spOHtJ6EncM
 X8gRuqAihjeRr9pLjsLenVZizpVa3kgMF/xqQd0IIrj85TNgCIMvUQbrYSsofuN+/Dtf
 tKfWoqNsaclGiIQiKlHHBHmiWNBAacdvP2Xs4dMzupPdapMce0uSlQ6TPt+6uEEWnoIt
 m4vnLZOSRcLgfnGPwWkb+XCnPENc7TCkBFg08UKgM+DvPeyR8aN4GbBUJbHTLXfvv7DE
 hO3g3ncqo2Mz8sCi+ZjWB7mqIcFAdZVGsw0/KQOTr/aujc5IwXiz4iKhXS8b9Dd9piTA
 uTDg==
X-Gm-Message-State: AOJu0YxMC5pvppFmMlLEf80vlaFtD2g0H5mUzPeXTL/VoXUehXBlZIYg
 ZsF/hfd6SoCXalSyjj6nHXxqc1JyxKUZfliwDd4lf/EQclAa4w+DesB9Xu94
X-Gm-Gg: ASbGncvnvg9OTDBmt4J+wHue4SnZTju5NrjQadoC4T7n+5N9FJ+K20+KduZEQKNpfoZ
 gVHp5Gv4nGpqmmre8p37n2jgtykUaqQf121jgDHRdX8wrJoc/JQcBS6oPZ0ajP2g1mjLsljxF22
 1XvO8gTnfF6VDuaHNZ/MGJZHj6HevxvARP6XAdx3VBcicK8mgxqVKHo9x5Di0tiSo6G+5Ea7JdV
 eeFpRAQmG0hNRUarQDcPMbahJMjmGllkyQr5Lr0O73P6XfWrFMboF/yglFG8832LcT9DDeobT7m
 YeKknlYW3SxRWS6ef8xqHLTSmD7soWNSf9j/dwUYyydsDFzizNabMO6yLr0nZcCUNR0=
X-Google-Smtp-Source: AGHT+IHOI1O6jjIo0dcNaOnum9uWVsVI0hcRC4GQ0P43xO84UNSEuoXH7Y5b85QMDgEbm418a3S2qA==
X-Received: by 2002:a05:690c:fd5:b0:70e:1bd8:a9c8 with SMTP id
 00721157ae682-71057cd463dmr182834907b3.23.1748893632073; 
 Mon, 02 Jun 2025 12:47:12 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:11 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 08/10] board: adi: Add support for SC598
Date: Mon,  2 Jun 2025 15:44:46 -0400
Message-ID: <20250602194507.15159-9-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

This adds support for the Analog Devices SC598-SOM and configurations
for using it with both the SOMCRR-EZKIT and SOMCRR-EZLITE.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 arch/arm/dts/sc598-som-ezkit.dts              | 166 ++++++++++++
 arch/arm/dts/sc598-som-ezlite.dts             |  82 ++++++
 arch/arm/dts/sc598-som.dtsi                   | 237 +++++++++++++++++-
 arch/arm/dts/sc59x.dtsi                       | 183 ++++++++++++++
 arch/arm/dts/sc5xx.dtsi                       | 137 +++++++++-
 board/adi/common-sc598-som/sc598-som.c        |  34 +++
 board/adi/sc598-som-ezkit/Makefile            |   8 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  18 +-
 board/adi/sc598-som-ezlite/Makefile           |   8 +
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  12 +-
 configs/sc598-som-ezkit-spl_defconfig         | 123 +++++++++
 configs/sc598-som-ezlite-spl_defconfig        | 123 +++++++++
 12 files changed, 1105 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/dts/sc59x.dtsi
 create mode 100644 board/adi/common-sc598-som/sc598-som.c
 create mode 100644 board/adi/sc598-som-ezkit/Makefile
 create mode 100644 board/adi/sc598-som-ezlite/Makefile
 create mode 100644 configs/sc598-som-ezkit-spl_defconfig
 create mode 100644 configs/sc598-som-ezlite-spl_defconfig

diff --git a/arch/arm/dts/sc598-som-ezkit.dts b/arch/arm/dts/sc598-som-ezkit.dts
index 7289e4d1d54..5177d49a60b 100644
--- a/arch/arm/dts/sc598-som-ezkit.dts
+++ b/arch/arm/dts/sc598-som-ezkit.dts
@@ -11,3 +11,169 @@
 	model = "ADI SC598-SOM-EZKIT";
 	compatible = "adi,sc598-som-ezkit", "adi,sc59x-64";
 };
+
+&i2c2{
+	gpio_expander2: mcp23017@22 {
+		compatible = "microchip,mcp23017";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		eeprom {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "eeprom-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "pushbutton-en";
+			bootph-pre-ram;
+		};
+
+		microsd {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~microsd-spi";
+			bootph-pre-ram;
+		};
+
+		ftdi {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~ftdi-usb-en";
+			bootph-pre-ram;
+		};
+
+		can {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~can-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "adau1979-en";
+			bootph-pre-ram;
+		};
+
+		octal {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "octal-spi-cs-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-digital-en";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		audio-jack {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "audio-jack-sel";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~mlb-en";
+			bootph-pre-ram;
+		};
+
+		eth1 {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~eth1-en";
+			bootph-pre-ram;
+		};
+
+		eth1-reset {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			/*
+			 * USB0 lines are shared with Eth1 so  Eth PHY must be held in reset
+			 * when using the USB
+			 */
+			output-low;
+			line-name = "~eth1-reset";
+			bootph-pre-ram;
+		};
+
+		gige-reset {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~gige-reset";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&ospi {
+	status = "okay";
+
+	clocks = <&clk ADSP_SC598_CLK_OSPI_REFCLK>;
+
+	flash0: mx66lm1g45@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor", "mx66lm1g45";
+		reg = <0>;
+
+		/*
+		 * This is board dependent to some extent.  We've been able to
+		 *set it higher on some boards
+		 */
+		spi-max-frequency = <66666666>;
+		cdns,spi-calib-frequency = <10000000>;
+
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+
+		tshsl-ns = <50>;
+		tsd2d-ns = <50>;
+		tchsh-ns = <4>;
+		tslch-ns = <4>;
+		bootph-pre-ram;
+
+		cdns,dqs;
+		cdns,phy;
+	};
+};
diff --git a/arch/arm/dts/sc598-som-ezlite.dts b/arch/arm/dts/sc598-som-ezlite.dts
index fa23b30f86e..4b4e1f847a4 100644
--- a/arch/arm/dts/sc598-som-ezlite.dts
+++ b/arch/arm/dts/sc598-som-ezlite.dts
@@ -11,3 +11,85 @@
 	model = "ADI SC598-SOM-EZLITE";
 	compatible = "adi,sc598-som-ezlite", "adi,sc59x-64";
 };
+
+&i2c2{
+	gpio_expander: adp5588@30 {
+		compatible = "adi,adp5588";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		usb-spi0 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb_spi0_en";
+			bootph-pre-ram;
+		};
+
+		usb-spi1 {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb_spi1_en";
+			bootph-pre-ram;
+		};
+
+		usb-qspi-en {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb_qspi_en";
+			bootph-pre-ram;
+		};
+
+		usb-qspi-reset {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "usb_qspi_reset";
+			bootph-pre-ram;
+		};
+
+		eth0-reset {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~eth0-reset";
+			bootph-pre-ram;
+		};
+
+		adau1372-pwrdwn {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "adau1372_pwrdwn";
+			bootph-pre-ram;
+		};
+
+		led1 {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led1-en";
+			bootph-pre-ram;
+		};
+
+		led2 {
+			gpio-hog;
+			gpios = <16 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led2-en";
+			bootph-pre-ram;
+		};
+
+		led3 {
+			gpio-hog;
+			gpios = <17 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led3-en";
+			bootph-pre-ram;
+		};
+	};
+};
diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
index 8bcc8bb8f1c..5ff6f5005d0 100644
--- a/arch/arm/dts/sc598-som.dtsi
+++ b/arch/arm/dts/sc598-som.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sc5xx.dtsi"
+#include "sc59x.dtsi"
 
 / {
 	gic: interrupt-controller@31200000 {
@@ -15,17 +16,247 @@
 		reg = <0x31200000 0x40000>, /* GIC Dist */
 		      <0x31240000 0x40000>; /* GICR */
 	};
+
+	soc {
+		sharc1: sharc@0x28240000 {
+			compatible = "adi,sc5xx-rproc";
+			reg = <0x28240000 0x100>;
+			coreid = <1>;
+			adi,rcu = <&rcu>;
+			status = "okay";
+		};
+
+		sharc2: sharc@0x28a40000 {
+			compatible = "adi,sc5xx-rproc";
+			reg = <0x28a40000 0x100>;
+			coreid = <2>;
+			adi,rcu = <&rcu>;
+			status = "okay";
+		};
+
+		clocks {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			bootph-pre-ram;
+
+			emmcclk: emmcclk@0 {
+				compatible = "fixed-clock";
+				reg = <0>;
+				#clock-cells = <0>;
+				clock-frequency = <50000000>; /* 50 MHz */
+				bootph-pre-ram;
+			};
+		};
+
+		mmc0: mmc@310C7000 {
+			compatible = "adi,dwc-sdhci";
+			reg = <0x310C7000 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc_defaults>;
+			clocks = <&emmcclk>;
+			clock-names = "core";
+			max-frequency = <50000000>;
+			bus-width = <8>;
+			bootph-pre-ram;
+		};
+	};
+};
+
+&pinctrl0 {
+	soc_defaults: soc_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('A', 14) ADI_ADSP_PINFUNC_ALT0>, /* i2c */
+					<ADI_ADSP_PIN('A', 15) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	mmc_defaults: mmc_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('D', 15) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('B', 15) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('C', 4) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('C', 6) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('E', 1) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('E', 6) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('E', 8) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('E', 9) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('G', 1) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('G', 2) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('G', 8) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('G', 9) ADI_ADSP_PINFUNC_ALT3>,
+					<ADI_ADSP_PIN('G', 10) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('I', 6) ADI_ADSP_PINFUNC_ALT1>;
+	};
+
+	ospi_default: ospi_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('A', 0) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 1) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 2) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 3) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 4) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 5) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 6) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('A', 7) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('A', 8) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('A', 9) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('D', 4) ADI_ADSP_PINFUNC_ALT2>;
+	};
 };
 
 &clk {
 	compatible = "adi,sc598-clocks";
 	reg = <0x3108d000 0x1000>,
-	      <0x3108e000 0x1000>,
-	      <0x3108f000 0x1000>,
-	      <0x310a9000 0x1000>;
+			<0x3108e000 0x1000>,
+			<0x3108f000 0x1000>,
+			<0x310a9000 0x1000>;
 	reg-names = "cgu0", "cgu1", "cdu", "pll3";
 };
 
+&rcu {
+	status = "okay";
+};
+
+&uart0{
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&wdog{
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&i2c0{
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&i2c1{
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+};
+
+&i2c2{
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+
+	gpio_expander1: mcp23018@20 {
+		compatible = "microchip,mcp23018";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+		drive-pullups;
+
+		led1 {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led1-en";
+			bootph-pre-ram;
+		};
+
+		led2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led2-en";
+			bootph-pre-ram;
+		};
+
+		led3 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "led3-en";
+			bootph-pre-ram;
+		};
+
+		spi2d2-d3 {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2d2-d3-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		uart0 {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~uart0-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		emmc {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "emmc-en";
+			bootph-pre-ram;
+		};
+
+		emmc-som-en {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "emmc-som-en";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	clocks = <&clk ADSP_SC598_CLK_SPI>;
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+	clock-names = "sclk0";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&eth0 {
+	compatible = "adi,sc59x-dwmac-eqos";
+	reg = <0x31040000 0x10000>;
+	phy-handle = <&dp83867>;
+	phy-mode = "rgmii-id";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dp83867: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
+
 &timer0 {
 	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
 };
diff --git a/arch/arm/dts/sc59x.dtsi b/arch/arm/dts/sc59x.dtsi
new file mode 100644
index 00000000000..ff279cca2d1
--- /dev/null
+++ b/arch/arm/dts/sc59x.dtsi
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/ {
+
+	aliases {
+		spi0 = "/ospi";
+	};
+
+	soc {
+		rcu: rcu@0x3108C000 {
+			compatible = "adi,reset-controller";
+			reg = <0x3108C000 0x1000>;
+			adi,sharc-min = <1>;
+			adi,sharc-max = <2>;
+			status = "disabled";
+		};
+
+		mdma: dma@0x310A7000 {
+			compatible = "adi,mdma-controller";
+			reg = <0x310A7000 0x1000>;
+			status = "okay";
+			#dma-cells = <1>;
+
+			sdma0: channel@8 {
+				adi,id = <8>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "complete", "error", "complete2", "error2";
+				adi,src-offset = <0>;
+				adi,dest-offset = <0x80>;
+			};
+		};
+
+		ospi: ospi {
+			compatible = "adi,sc59x-ospi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x31027000 0x1000>,
+			      <0x60000000 0x20000000>;
+			interrupts = <0 151 4>;
+			dmas = <&mdma 8>, <&mdma 9>;
+			dma-names = "src", "dst";
+			/*clocks = <&ospi_clk>;*/
+			ext-decoder = <0>;	/* external decoder */
+			num-cs = <1>;
+			fifo-depth = <128>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ospi_default>;
+			bus-num = <0>;
+			clock-names = "ospi";
+			cdns,max-read-delay = <9>;
+			status = "disabled";
+			bootph-pre-ram;
+		};
+
+		eth1: eth1 {
+			compatible = "snps,arc-dwmac-3.70a";
+			reg = <0x31042000 0x1000>;
+			phy-mode = "mii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth1_default>;
+		};
+
+		usb0_phy: usbphy {
+			compatible = "usb-nop-xceiv";
+			#phy-cells = <0>;
+			reset = <&gpio0 ADI_ADSP_PIN('G', 11) GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_default>;
+			status = "disabled";
+		};
+
+		usb0: usb@310c5000 {
+			compatible = "snps,dwc2";
+			dr_mode = "host";
+			reg = <0x310c5000 0x2000>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy>;
+			phy-names = "usb2-phy";
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb0_default>;
+			status = "disabled";
+		};
+	};
+};
+
+&pinctrl0 {
+	adi,npins = <135>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&soc_defaults>;
+
+	eth0_default: eth0_pins {
+		adi,pins = <ADI_ADSP_PIN('H', 3) ADI_ADSP_PINFUNC_ALT0>, /* eth0 */
+					<ADI_ADSP_PIN('H', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 5) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 6) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 7) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 8) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 9) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 10) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 11) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 14) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('H', 15) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('I', 0) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	eth1_default: eth1_pins {
+		adi,pins = <ADI_ADSP_PIN('E', 11) ADI_ADSP_PINFUNC_ALT0>, /* eth1 */
+					<ADI_ADSP_PIN('E', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 14) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 15) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 0) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 1) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 3) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	uart0_default: uart0_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('A', 6) ADI_ADSP_PINFUNC_ALT1>,
+					<ADI_ADSP_PIN('A', 7) ADI_ADSP_PINFUNC_ALT1>;
+	};
+
+	spi2_default: spi2_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('A', 0) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 1) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 3) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 5) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	usb0_default: usb0_pins {
+		adi,pins = <ADI_ADSP_PIN('F', 3) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 4) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 5) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 6) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 7) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 8) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 9) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 10) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 11) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 12) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 13) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('F', 14) ADI_ADSP_PINFUNC_ALT2>;
+	};
+};
+
+&gpio0 {
+	adi,ngpios = <135>;
+
+	pushbutton0 {
+		gpio-hog;
+		input;
+		gpios = <ADI_ADSP_PIN('D', 0) GPIO_ACTIVE_HIGH>;
+		bootph-pre-ram;
+	};
+
+	pushbutton1 {
+		gpio-hog;
+		input;
+		gpios = <ADI_ADSP_PIN('H', 0) GPIO_ACTIVE_HIGH>;
+		bootph-pre-ram;
+	};
+};
+
+&spi2 {
+	reg = <0x31030000 0x1000>;
+};
+
+&eth0 {
+	reg = <0x31040000 0x1000>;
+};
diff --git a/arch/arm/dts/sc5xx.dtsi b/arch/arm/dts/sc5xx.dtsi
index b4de1b51bb9..21803d84716 100644
--- a/arch/arm/dts/sc5xx.dtsi
+++ b/arch/arm/dts/sc5xx.dtsi
@@ -3,10 +3,14 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/adi-adsp.h>
 #include <dt-bindings/clock/adi-sc5xx-clock.h>
 
 / {
+	interrupt-parent = <&gic>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -63,18 +67,25 @@
 #endif
 
 	clocks {
+		dummy: dummy {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			bootph-pre-ram;
+		};
+
 		sys_clkin0: sys_clkin0 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
-			bootph-all;
+			bootph-pre-ram;
 		};
 
 		sys_clkin1: sys_clkin1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
-			bootph-all;
+			bootph-pre-ram;
 		};
 	};
 
@@ -84,23 +95,127 @@
 		compatible = "simple-bus";
 		device_type = "soc";
 		ranges;
-		bootph-all;
+		bootph-pre-ram;
 
-		timer0: timer@31018000 {
+		timer0: timer@0x31018000 {
 			compatible = "adi,sc5xx-gptimer";
 			reg = <0x31018004 0x100>,
-			      <0x31018060 0x100>;
+					<0x31018060 0x100>;
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		pinctrl0: pinctrl@0x31004000 {
+			compatible = "adi,adsp-pinctrl";
+			reg = <0x31004000 0x500>;
 			status = "okay";
-			bootph-all;
+			bootph-pre-ram;
 		};
 
-		clk: clocks@3108d000 {
-			reg = <0x3108d000 0x1000>;
+		gpio0: gpio@0x31004000 {
+			compatible = "adi,adsp-gpio";
+			reg = <0x31004000 0x500>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		clk: clocks@0x3108d000 {
+			reg = <0x3108d000 0x1000>,
+				<0x3108e000 0x1000>,
+				<0x3108f000 0x1000>;
+			reg-names = "cgu0", "cgu1", "cdu";
 			#clock-cells = <1>;
-			clocks = <&sys_clkin0>, <&sys_clkin1>;
-			clock-names = "sys_clkin0", "sys_clkin1";
+			clocks = <&dummy>, <&sys_clkin0>, <&sys_clkin1>;
+			clock-names = "dummy", "sys_clkin0", "sys_clkin1";
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		uart0: serial@0x31003000 {
+			compatible = "adi,uart4";
+			reg = <0x31003000 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_default>;
+			clock-names = "sclk0";
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		spi2: spi2 {
+			compatible = "adi,spi3";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_default>;
+			bus-num = <2>;
+			spi-max-frequency = <10000000>;
+			clock-names = "spi";
+			status = "okay";
+			bootph-pre-ram;
+
+			flash1: is25lp512@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "jedec,spi-nor", "is25lp512";
+				reg = <1>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+				spi-max-frequency = <10000000>;
+				bootph-pre-ram;
+			};
+		};
+
+		wdog: watchdog@31008000 {
+			compatible = "adi,wdt";
+			reg = <0x3108b000 0x1000>,
+					<0x31089000 0x1000>,
+					<0x31008000 0x1000>;
+			reg-names = "rcu", "sec", "wdt";
+			clock-names = "sclk0";
+			status = "disabled";
+			bootph-pre-ram;
+		};
+
+		eth0: eth0 {
+			compatible = "snps,arc-dwmac-3.70a";
+			phy-mode = "rgmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth0_default>;
+			snps,reset-active-low;
+			snps,reset-delays-us = <1000 1000 1000>;
+			status = "okay";
+		};
+
+		i2c0: i2c0@31001400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001400 0x1000>;
+			clock-names = "i2c";
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		i2c1: i2c1@31001500 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001500 0x1000>;
+			clock-names = "i2c";
+			status = "okay";
+			bootph-pre-ram;
+		};
+
+		i2c2: i2c2@31001600 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "adi-i2c";
+			reg = <0x31001600 0x1000>;
+			clock-names = "i2c";
 			status = "okay";
-			bootph-all;
+			bootph-pre-ram;
 		};
 	};
 };
diff --git a/board/adi/common-sc598-som/sc598-som.c b/board/adi/common-sc598-som/sc598-som.c
new file mode 100644
index 00000000000..96b73520e66
--- /dev/null
+++ b/board/adi/common-sc598-som/sc598-som.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <config.h>
+#include <phy.h>
+#include <asm/u-boot.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/soc.h>
+#include <asm/armv8/mmu.h>
+
+#include "../carriers/somcrr.h"
+
+int board_phy_config(struct phy_device *phydev)
+{
+	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZKIT))
+		fixup_dp83867_phy(phydev);
+	return 0;
+}
+
+int board_init(void)
+{
+	sc59x_remap_ospi();
+
+	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZKIT) ||
+	    IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZLITE)) {
+		adi_somcrr_init_ethernet();
+	}
+
+	sc5xx_enable_rgmii();
+
+	return 0;
+}
diff --git a/board/adi/sc598-som-ezkit/Makefile b/board/adi/sc598-som-ezkit/Makefile
new file mode 100644
index 00000000000..b22c4f5ccf5
--- /dev/null
+++ b/board/adi/sc598-som-ezkit/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= ../common-sc598-som/sc598-som.o
+
+obj-y += ../carriers/
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 242436c1600..a07fb9edc45 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,10 +4,16 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x40000
-adi_image_offset=0x01a0000
-adi_rfs_offset=0x1020000
-loadaddr=0x90000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_SPI
+#define USE_OSPI
+#define USE_RAM
+#define USE_MMC
+
+#include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezlite/Makefile b/board/adi/sc598-som-ezlite/Makefile
new file mode 100644
index 00000000000..b22c4f5ccf5
--- /dev/null
+++ b/board/adi/sc598-som-ezlite/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= ../common-sc598-som/sc598-som.o
+
+obj-y += ../carriers/
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 036c9ae7590..64eff88df5e 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -4,10 +4,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x40000
-adi_image_offset=0x01a0000
-adi_rfs_offset=0x1020000
-loadaddr=0x90000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
+loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
+
+#include <env/adi/adi_boot.env>
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
new file mode 100644
index 00000000000..e218e8746f4
--- /dev/null
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -0,0 +1,123 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=31250000
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x180000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SC59X_64=y
+CONFIG_TARGET_SC598_SOM_EZKIT=y
+# CONFIG_PACK_FITIMAGE is not set
+# CONFIG_PACK_ROOTFS is not set
+CONFIG_SC_BOOT_MODE=2
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_CGU1_PLL3_DDRCLK=y
+CONFIG_CGU1_PLL3_VCO_MSEL=64
+CONFIG_CGU1_PLL3_DCLK_DIV=2
+CONFIG_CGU1_DIV_S1SELEX=27
+CONFIG_CDU0_CLKO0=1
+CONFIG_CDU0_CLKO1=1
+CONFIG_CDU0_CLKO2=7
+CONFIG_CDU0_CLKO3=1
+CONFIG_CDU0_CLKO4=3
+CONFIG_CDU0_CLKO5=1
+CONFIG_CDU0_CLKO6=1
+CONFIG_CDU0_CLKO7=1
+CONFIG_CDU0_CLKO8=3
+CONFIG_CDU0_CLKO9=1
+CONFIG_CDU0_CLKO10=5
+CONFIG_CDU0_CLKO12=1
+CONFIG_CDU0_CLKO13=3
+CONFIG_CDU0_CLKO14=3
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_SPI=y
+CONFIG_DEFAULT_SPI_BUS=2
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_EMBED=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc59x"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_NETCONSOLE=y
+CONFIG_IP_DEFRAG=y
+CONFIG_USE_GATEWAYIP=y
+CONFIG_GATEWAYIP="192.168.0.1"
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.0.15"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/romfs"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.0.2"
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_ADI_DMA=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_MCP230XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MMC_BROKEN_CD=y
+CONFIG_MMC_SDHCI_ADI=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ADI=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_REMOTEPROC_ADI_SC5XX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_STORAGE=y
+# CONFIG_SPL_CRC8 is not set
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
new file mode 100644
index 00000000000..d7693ea2772
--- /dev/null
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -0,0 +1,123 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=31250000
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x180000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x200E4000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SC59X_64=y
+# CONFIG_PACK_FITIMAGE is not set
+# CONFIG_PACK_ROOTFS is not set
+CONFIG_SC_BOOT_MODE=2
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_CGU1_PLL3_DDRCLK=y
+CONFIG_CGU1_PLL3_VCO_MSEL=64
+CONFIG_CGU1_PLL3_DCLK_DIV=2
+CONFIG_CGU1_DIV_S1SELEX=27
+CONFIG_CDU0_CLKO0=1
+CONFIG_CDU0_CLKO1=1
+CONFIG_CDU0_CLKO2=7
+CONFIG_CDU0_CLKO3=1
+CONFIG_CDU0_CLKO4=3
+CONFIG_CDU0_CLKO5=1
+CONFIG_CDU0_CLKO6=1
+CONFIG_CDU0_CLKO7=1
+CONFIG_CDU0_CLKO8=3
+CONFIG_CDU0_CLKO9=1
+CONFIG_CDU0_CLKO10=5
+CONFIG_CDU0_CLKO12=1
+CONFIG_CDU0_CLKO13=3
+CONFIG_CDU0_CLKO14=3
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_SPI=y
+CONFIG_DEFAULT_SPI_BUS=2
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_EMBED=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc59x"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_NETCONSOLE=y
+CONFIG_IP_DEFRAG=y
+CONFIG_USE_GATEWAYIP=y
+CONFIG_GATEWAYIP="192.168.0.1"
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.0.15"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/romfs"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.0.2"
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_ADI_DMA=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_ADP5588_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MMC_BROKEN_CD=y
+CONFIG_MMC_SDHCI_ADI=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ADI=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_REMOTEPROC_ADI_SC5XX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_STORAGE=y
+# CONFIG_SPL_CRC8 is not set
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.45.2

