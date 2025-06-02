Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD621C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C73B82B27;
	Mon,  2 Jun 2025 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LozwRKtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2260828BC; Mon,  2 Jun 2025 21:47:17 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC1582A76
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e302191a3so41234157b3.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893633; x=1749498433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phrZpe2Ge6LFKux1DjD+HssJ4obzdv/ez8OJtG4c3AQ=;
 b=LozwRKtnEPdIcMaZnji/UpUJemRqVrzJXQYgtCZXG7pb4GAaqcaVYiGqjNg2xmBvoB
 iiEtI3t5Cautp6rgM3flVOEqKBeuo00c5rthXOmVcNccmu+RJVp9wrdumUecLEsDH/YY
 4tQYkCZfPXAPItjaIMiS4SwHAhQBkSast86InttVf0+GU6V7UYTjkl/cmt/dpf7Lm/kU
 2+l4mgGICtLFBXykWlLkQlmxJ6aHgjZJgzojke1MCGg6IlRq+NdWk+T63vDSVBIDNoxs
 j28hja0CdBilfstOPtrfHPKGv3OS8SgoBhlSJQy0tXKC/TD9XCjmrN0x4DhW85DrjQV5
 /X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893633; x=1749498433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phrZpe2Ge6LFKux1DjD+HssJ4obzdv/ez8OJtG4c3AQ=;
 b=EQjnpO/9QFlrwu3IOIAOizFrhsblybCvupbms6bgFOrD9NvszjIHpYXSuXpNsAZ+Df
 T79VvrrDfUer+1NOWCEeXrdVtEWYtsC9hITgrTl9r9n/TIyEJapi1LkJOBILL0FvXDjV
 PPlS6Pjohl1E5deDchbuyNhxj6lB/qpw4CxBDyK8Q2Ih0OR0r2JjaVTUm/c+h0KYaX5q
 IURZyKiM13tlOTrzpq+5i4Js6hROSWcF2STgA/G4QvQBShISPpIZCC5zsMmgd4fSYnBH
 Vew/sO/RtN48J2ONCsOAVkPKqJ58tZArpT572VdKHBZKU0K4R1S4nemBW2ncz0IeZOJy
 LvxA==
X-Gm-Message-State: AOJu0YwehKo/M5dqjDqu+TrNMXffFxHn8VZAe1Y4A+ghe3w7L0YDsKdf
 RM3Ug/Ee9H4StVcl6rGEizwJX+yjJwVMJHKCZYVCkevyKo3eixywnFOiUbqe
X-Gm-Gg: ASbGncsB0d0rYmPgYf13bPhbjsg/uXXRdOhpzcFpUWhuMz14LOWef1qGEbDRCa4gIMu
 IaQf2AuzkZTf/hFNFqZT2iTLpSNdYI/RTs16vpaOrL9+JSIofmiv+mZtsuXAQ7GyFRz+X8pJ3X9
 x4W6wSPMmOcuxDq7R6uDEvNHk5DzVLzX71WJWC6V7WXayjjlH86geR/iGrr9DcE2C1qEQmLZ0wJ
 8TuADfgM5nWn4tC7BsohjYzGqZz4Z7GE5cs/GjzwMnWjWpN83LrkeWk3SDCnbwDd29Czfq7O0pF
 zBysHsrfz7WVOYvkCh+ESihHoY858QtOuEQQgCduj3NS4goI0sMumGCG1+hvrItOK+c=
X-Google-Smtp-Source: AGHT+IHIuYc4Lcu8+sDia2VeETzRkZfDdmByp+mNJAYGUSNBsV6ZsfgJ10wbk8tJ7RyW276LUmqhHg==
X-Received: by 2002:a05:690c:4a08:b0:70e:73ae:76a2 with SMTP id
 00721157ae682-70f97f5153bmr203389547b3.34.1748893633353; 
 Mon, 02 Jun 2025 12:47:13 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:12 -0700 (PDT)
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
Subject: [PATCH 09/10] board: adi: Add support for SC594
Date: Mon,  2 Jun 2025 15:44:47 -0400
Message-ID: <20250602194507.15159-10-malysagreg@gmail.com>
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

This adds support for the Analog Devices SC594 SOM and configurations
for using it with both the SOMCRR-EZKIT and SOMCRR-EZLITE.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 arch/arm/dts/sc594-som-ezkit.dts              | 126 ++++++++++++
 arch/arm/dts/sc594-som-ezlite.dts             |  83 ++++++++
 arch/arm/dts/sc594-som.dtsi                   | 184 +++++++++++++++++-
 board/adi/common-sc594-som/sc594-som.c        |  34 ++++
 board/adi/sc594-som-ezkit/Makefile            |   8 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  18 +-
 board/adi/sc594-som-ezlite/Makefile           |   8 +
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  18 +-
 configs/sc594-som-ezkit-spl_defconfig         |  90 +++++++++
 configs/sc594-som-ezlite-spl_defconfig        |  98 ++++++++++
 10 files changed, 652 insertions(+), 15 deletions(-)
 create mode 100644 board/adi/common-sc594-som/sc594-som.c
 create mode 100644 board/adi/sc594-som-ezkit/Makefile
 create mode 100644 board/adi/sc594-som-ezlite/Makefile
 create mode 100644 configs/sc594-som-ezkit-spl_defconfig
 create mode 100644 configs/sc594-som-ezlite-spl_defconfig

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index e744a3a4edb..bf03789876b 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -11,3 +11,129 @@
 	model = "ADI SC594-SOM-EZKIT";
 	compatible = "adi,sc594-som-ezkit", "adi,sc59x";
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
+		adau-reset {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "adau-reset";
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
diff --git a/arch/arm/dts/sc594-som-ezlite.dts b/arch/arm/dts/sc594-som-ezlite.dts
index 7d81b40fe8a..018b28a7d09 100644
--- a/arch/arm/dts/sc594-som-ezlite.dts
+++ b/arch/arm/dts/sc594-som-ezlite.dts
@@ -11,3 +11,86 @@
 	model = "ADI SC594-SOM-EZLITE";
 	compatible = "adi,sc594-som-ezlite", "adi,sc59x";
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
+
+	};
+};
diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
index e15473f8e8f..9514b622098 100644
--- a/arch/arm/dts/sc594-som.dtsi
+++ b/arch/arm/dts/sc594-som.dtsi
@@ -6,14 +6,192 @@
 /dts-v1/;
 
 #include "sc5xx.dtsi"
+#include "sc59x.dtsi"
+
+/{
+	gic: interrupt-controller@310B2000 {
+		compatible = "arm,cortex-a5-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x310B2000 0x1000>,
+		      <0x310B4000 0x100>;
+	};
+};
 
 &timer0 {
 	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
 };
 
+&pinctrl0 {
+	soc_defaults: soc_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('A', 14) ADI_ADSP_PINFUNC_ALT0>, /* i2c */
+		       <ADI_ADSP_PIN('A', 15) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 2) ADI_ADSP_PINFUNC_ALT0>, /* emmc */
+		       <ADI_ADSP_PIN('F', 3) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 4) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 5) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 6) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 7) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 8) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 9) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 10) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 11) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('F', 12) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	ospi_default: ospi_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('C', 8) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 9) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 10) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 11) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 12) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 13) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 14) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('C', 15) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('D', 0) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('D', 1) ADI_ADSP_PINFUNC_ALT0>,
+		       <ADI_ADSP_PIN('D', 4) ADI_ADSP_PINFUNC_ALT2>;
+	};
+};
+
 &clk {
 	compatible = "adi,sc594-clocks";
-	reg = <0x3108d000 0x1000>,
-	      <0x3108e000 0x1000>,
-	      <0x3108f000 0x1000>;
+};
+
+&uart0{
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&wdog{
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&i2c0{
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&i2c1{
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+};
+
+&i2c2{
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+
+	gpio_expander1: mcp23017@21 {
+		compatible = "microchip,mcp23017";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		led1 {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "led1-en";
+			bootph-pre-ram;
+		};
+
+		led2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "led2-en";
+			bootph-pre-ram;
+		};
+
+		led3 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "led3-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		spi2d2-d3 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2d2-d3-en";
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
+		ospiflash-cs {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~ospiflash-cs";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&ospi {
+	status = "okay";
+
+	clocks = <&clk ADSP_SC594_CLK_OSPI>;
+
+	flash0: is25lx256@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor", "is25lx256";
+		reg = <0>;
+
+		spi-max-frequency = <100000000>;
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
+		cdns,phy;
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	clocks = <&clk ADSP_SC594_CLK_SPI>;
+};
+
+&usb0_phy {
+	status = "okay";
+	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+	clock-names = "sclk0";
+};
+
+&usb0 {
+	status = "okay";
 };
diff --git a/board/adi/common-sc594-som/sc594-som.c b/board/adi/common-sc594-som/sc594-som.c
new file mode 100644
index 00000000000..aab729fc761
--- /dev/null
+++ b/board/adi/common-sc594-som/sc594-som.c
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
+
+#include "../carriers/somcrr.h"
+
+int board_phy_config(struct phy_device *phydev)
+{
+	if (IS_ENABLED(CONFIG_ADI_CARRIER_SOMCRR_EZKIT))
+		fixup_dp83867_phy(phydev);
+
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
diff --git a/board/adi/sc594-som-ezkit/Makefile b/board/adi/sc594-som-ezkit/Makefile
new file mode 100644
index 00000000000..6a74b509f1b
--- /dev/null
+++ b/board/adi/sc594-som-ezkit/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= ../common-sc594-som/sc594-som.o
+
+obj-y += ../carriers/
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 83d6b457a08..6113df11736 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,10 +4,16 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x40000
-adi_image_offset=0x0120000
-adi_rfs_offset=0x1020000
-loadaddr=0xA2000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_SPI
+#define USE_OSPI
+#define USE_RAM
+#define USE_MMC
+
+#include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezlite/Makefile b/board/adi/sc594-som-ezlite/Makefile
new file mode 100644
index 00000000000..6a74b509f1b
--- /dev/null
+++ b/board/adi/sc594-som-ezlite/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= ../common-sc594-som/sc594-som.o
+
+obj-y += ../carriers/
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 152e1f14fdf..e591027eace 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,10 +4,16 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x40000
-adi_image_offset=0x0120000
-adi_rfs_offset=0x1020000
-loadaddr=0xA2000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_SPI
+#define USE_OSPI
+#define USE_RAM
+#define USE_MMC
+
+#include <env/adi/adi_boot.env>
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
new file mode 100644
index 00000000000..ec8d8a9eccb
--- /dev/null
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8203f000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SC59X=y
+CONFIG_TARGET_SC594_SOM_EZKIT=y
+CONFIG_ADI_IMAGE="minimal"
+CONFIG_SC_BOOT_MODE=2
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_EMBED=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc59x"
+CONFIG_NET_RETRY_COUNT=20
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
+CONFIG_DM_DMA=y
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
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_STORAGE=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
new file mode 100644
index 00000000000..69dfa447f16
--- /dev/null
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -0,0 +1,98 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x200E4000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SC59X=y
+CONFIG_SC_BOOT_MODE=2
+CONFIG_CGU1_DIV_S1SELEX=16
+CONFIG_CDU0_CLKO10=5
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_CS=0
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ospiboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+# CONFIG_DOS_PARTITION is not set
+CONFIG_OF_EMBED=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc59x"
+CONFIG_NET_RETRY_COUNT=20
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
+CONFIG_DM_DMA=y
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_ADI_DMA=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_MCP230XX_GPIO=y
+CONFIG_ADP5588_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
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

