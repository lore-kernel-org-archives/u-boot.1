Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5596D3E79D
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819AE83D0C;
	Thu, 11 Dec 2025 09:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRQ8gh/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59567830E4; Thu, 11 Dec 2025 09:06:01 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5142083C08
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6446704997cso558065d50.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440357; x=1766045157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qpXajNj9DIxuf8gi2bS+sUi8rOXdXXxhXCyCkSzYI0=;
 b=NRQ8gh/yhD2MrmWzYpw50u1Voy3WgnmHMruLQ7wsVXzLkxZbGFjJRFyp0QDjKptjO9
 o6YmYP+X7ouwyt4eR1tEcbXVsF6XkYc3IOkHprQOiOduNlPSgraxp4hv4amPmPPMiM0m
 PEgpBsRfZD1c7f0JbPHHekffQXXeuXaA2+HAL9SYQJPW8DJgkEupgrPfqNSxjnFuMjlZ
 JjULyyx8t06sRJIaZtdLPAOHqGisgrRdpnN9ABzTwgfHAq03j4Rhp9/CsdyvhpV0uIVM
 cGhvvofhkn4I/L0NLTEGxDZ1URDi4QzpKMbjWFiYgJDovpdZ/ghjqqHPMfNLD4b38tgz
 zKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440357; x=1766045157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+qpXajNj9DIxuf8gi2bS+sUi8rOXdXXxhXCyCkSzYI0=;
 b=g1FLPZx10p/It0uWJA7HJku7d4FAFttw0AFysfLgf9l8v5gd80yZyTT9aR4Sz96dyb
 1l+2Nk/7NhIQyW4njYw+71iVEytgA7gao1FTGgziiHziZ9SxNkJwhdJdZ6SbDWLBgd0n
 UaEKBpasYtTWiCqM4crUWBDIkznOmZfVP31E4vQWsXP8edSvcCCnqsq7KaMj2dBJnbfj
 LOruVJSpSAh5+OIJAjpuw2d10y65I/TC3Kaj6DDSlssmySkN7+/hGWuY0MZfyZyVWWw0
 YV9ctKBZ0wQLOOEyUjDSLKG/68927shmbs0Gadu6Wmg1PjJMqqmnfDVexKt6L/OK4j1N
 t1Hw==
X-Gm-Message-State: AOJu0YwoebpogT5FGrbeeL5ZS8mTqk0CLnUfa5NSkxng2oDws0m//bns
 ClNsw5if70t2GxYwGAq/DllLRkzFiJz71ljk3YDJB0AwFz+KIcVVaa+CajP0
X-Gm-Gg: AY/fxX6oZPJYJ1ZCgq+r94fBs8jU5zbHcsH+lF5Q+MM+hV3IR2W9t3r2Q80yv45cYgh
 ljZM2BsbNdFoOF4ZR30wfq+7PvOuCYf6CxICJGYAU5g06eAN4A/GF6rz8FfJ3G0UO7fHYompK13
 VxEAWEjLebg2vPVJSmrEpopxQf79UenEBAByelGXZ7Ag83bvau0CEuER48oyBwpBz4DKBPMYPWB
 a1UwfVeNEI0LyzzWA0V2pejavMIV/CBG4TzwETucVSaPWbLf1nL4+wEG8L0CTRFfRB7rP4Vdjr4
 z1+etHC6/vD7Xyn0QzuGlLzsMrLKlxKaX74mq/9Xap08ZT+wWrr/NO+ZPsDb3cI49k1BQWob+at
 fey2mV+BK1U4KItPnMebIZnsd5bgt59IGQferHq0daSMlGD9LMM83pneClKN++3tDI4RZwru2hw
 dzzi1O1imGwImgPFbUBBvdvYjaOQ==
X-Google-Smtp-Source: AGHT+IHRUrtHykntA5X1SOgzdT6Qh/qhV6K2KqkExKmDkMTZxz6CY9/YEEKGOoEOCgGtvjkafZgIoQ==
X-Received: by 2002:a05:690e:1589:20b0:63f:b6a4:bd24 with SMTP id
 956f58d0204a3-6446eaffa9bmr3297105d50.48.1765440356695; 
 Thu, 11 Dec 2025 00:05:56 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:56 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/12] board: adi: Add support for SC589 boards
Date: Thu, 11 Dec 2025 03:03:59 -0500
Message-ID: <20251211080414.5363-9-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

This adds support for the Analog Devices SC589-EZKIT and SC589-mini.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
Signed-off-by: Philip Molloy <philip.molloy@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v3:
- Add one more GPIO that was named incorrectly
- Removed whitespace in .env

Changes in v2:
- GPIO names and polarities adjusted to match logical usage

 arch/arm/dts/sc589-ezkit.dts          | 198 ++++++++++++++++++++++++++
 arch/arm/dts/sc589-mini.dts           |  18 ++-
 arch/arm/dts/sc58x.dtsi               | 164 ++++++++++++++++++++-
 board/adi/sc589-ezkit/Makefile        |   6 +
 board/adi/sc589-ezkit/sc589-ezkit.c   |  21 +++
 board/adi/sc589-ezkit/sc589-ezkit.env |  18 ++-
 board/adi/sc589-mini/Makefile         |   6 +
 board/adi/sc589-mini/sc589-mini.c     |  21 +++
 board/adi/sc589-mini/sc589-mini.env   |  18 ++-
 configs/sc589-ezkit_defconfig         | 101 +++++++++++++
 configs/sc589-mini_defconfig          |  97 +++++++++++++
 11 files changed, 650 insertions(+), 18 deletions(-)
 create mode 100644 board/adi/sc589-ezkit/Makefile
 create mode 100644 board/adi/sc589-ezkit/sc589-ezkit.c
 create mode 100644 board/adi/sc589-mini/Makefile
 create mode 100644 board/adi/sc589-mini/sc589-mini.c
 create mode 100644 configs/sc589-ezkit_defconfig
 create mode 100644 configs/sc589-mini_defconfig

diff --git a/arch/arm/dts/sc589-ezkit.dts b/arch/arm/dts/sc589-ezkit.dts
index 8a1c0ce0862..39ac7a4fd6e 100644
--- a/arch/arm/dts/sc589-ezkit.dts
+++ b/arch/arm/dts/sc589-ezkit.dts
@@ -8,6 +8,204 @@
 #include "sc58x.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
 	model = "ADI SC589-EZKIT";
 	compatible = "adi,sc589-ezkit", "adi,sc58x";
 };
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gpio_expander1: mcp23017@21 {
+		compatible = "microchip,mcp23017";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		eeprom {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "eeprom-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		uart0-en {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "uart0-en";
+			bootph-pre-ram;
+		};
+
+		eth0 {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "eth0-en";
+			bootph-pre-ram;
+		};
+
+		eth1 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "eth1-en";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "mlb-en";
+			bootph-pre-ram;
+		};
+
+		can0 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "can0-en";
+			bootph-pre-ram;
+		};
+
+		can1 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "can1-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1979-en";
+			bootph-pre-ram;
+		};
+
+		sd_wp {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "sd-wp-en";
+			bootph-pre-ram;
+		};
+
+		spi2d2-d3 {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "spi2d2-d3-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-digital-en";
+			bootph-pre-ram;
+		};
+	};
+
+	gpio_expander2: mcp23017@22 {
+		compatible = "microchip,mcp23017";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		pushbutton1 {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton1-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton2-en";
+			bootph-pre-ram;
+		};
+
+		led10 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "led10-en";
+			bootph-pre-ram;
+		};
+
+		led11 {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "led11-en";
+			bootph-pre-ram;
+		};
+
+		led12 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "led12-en";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&eth0 {
+	snps,reset-gpio = <&gpio0 ADI_ADSP_PIN('B', 14) GPIO_ACTIVE_LOW>;
+};
+
+&gpio0 {
+	emac0_phy_pwdn {
+		gpio-hog;
+		output-high;
+		gpios = <ADI_ADSP_PIN('C', 15) GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mmc {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sc589-mini.dts b/arch/arm/dts/sc589-mini.dts
index 605f7a17bfc..a7650bae12c 100644
--- a/arch/arm/dts/sc589-mini.dts
+++ b/arch/arm/dts/sc589-mini.dts
@@ -8,6 +8,22 @@
 #include "sc58x.dtsi"
 
 / {
-	model = "ADI SC598-MINI";
+	model = "ADI SC589-MINI";
 	compatible = "adi,sc589-mini", "adi,sc58x";
 };
+
+&eth0 {
+	snps,reset-gpio = <&gpio0 ADI_ADSP_PIN('B', 7) GPIO_ACTIVE_LOW>;
+};
+
+&gpio0 {
+	emac0_phy_pwdn {
+		gpio-hog;
+		output-high;
+		gpios = <ADI_ADSP_PIN('F', 6) GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mmc {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
index 66145315ab7..7b07589de47 100644
--- a/arch/arm/dts/sc58x.dtsi
+++ b/arch/arm/dts/sc58x.dtsi
@@ -6,18 +6,176 @@
 #include "sc5xx.dtsi"
 
 / {
-	gic: interrupt-controller@310b2000 {
-		compatible = "arm,cortex-a5-gic";
+	gic: interrupt-controller@310B2000 {
+		compatible = "arm,cortex-a5-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0x310B2000 0x1000>,
 		      <0x310B4000 0x100>;
 	};
+
+	soc {
+		rcu: rcu@0x3108B000 {
+			compatible = "adi,reset-controller";
+			reg = <0x3108B000 0x1000>;
+			adi,sharc-min = <1>;
+			adi,sharc-max = <2>;
+			adi,enable-reboot;
+			status = "disabled";
+		};
+
+		mmc: mmc0@31010000 {
+			compatible = "snps,dw-mshc";
+			reg = <0x31010000 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc_default>;
+			bus-width = <4>;
+			fifo-depth = <128>;
+			clock-names = "biu", "ciu";
+			max-frequency = <52000000>;
+			status = "disabled";
+		};
+
+		usb0: musb@310c1000 {
+			compatible = "adi,sc5xx-musb";
+			reg = <0x310c1000 0x390>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+						 <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc", "dma";
+			status = "okay";
+		};
+
+		usb1: musb@310c2000 {
+			compatible = "adi,sc5xx-musb";
+			reg = <0x310c2000 0x390>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+						 <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc", "dma";
+			status = "disabled";
+		};
+
+		sharc1: sharc@0x28240000 {
+			compatible = "adi,sc5xx-rproc";
+			reg = <0x28240000 0x100>;
+			coreid = <1>;
+			adi,rcu = <&rcu>;
+			status = "disabled";
+		};
+
+		sharc2: sharc@0x28a40000 {
+			compatible = "adi,sc5xx-rproc";
+			reg = <0x28a40000 0x100>;
+			coreid = <2>;
+			adi,rcu = <&rcu>;
+			status = "disabled";
+		};
+	};
 };
 
 &timer0 {
 	reg = <0x31001004 0x100>,
-	      <0x31001060 0x100>;
+			<0x31001060 0x100>;
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&pinctrl0 {
+	mmc_default: mmc_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('F', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 3) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 5) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 10) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 11) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 12) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	eth0_default: eth0_pins {
+		adi,pins = <ADI_ADSP_PIN('A', 0) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 1) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 3) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 5) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 6) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 7) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 8) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 9) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 10) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 11) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 13) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	uart0_default: uart0_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('C', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 14) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	spi2_default: spi2_pins {
+		adi,pins = <ADI_ADSP_PIN('C', 1) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 3) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 5) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('C', 6) ADI_ADSP_PINFUNC_ALT0>;
+	};
+};
+
+&pinctrl0 {
+	adi,npins = <102>;
+};
+
+&gpio0 {
+	adi,ngpios = <102>;
+};
+
+&clk {
+	compatible = "adi,sc58x-clocks";
+};
+
+&uart0 {
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&spi2 {
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK1>;
+	reg = <0x31044000 0x1000>;
+
+	flash1: is25lp512@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor", "is25lp512";
+		reg = <1>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+		bootph-pre-ram;
+	};
+};
+
+&wdog {
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&eth0 {
+	reg = <0x3100C000 0x1000>;
+};
+
+&mmc {
+	clocks = <&dummy>, <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&i2c0 {
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&i2c1 {
+	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+};
+
+&i2c2 {
 	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
 };
diff --git a/board/adi/sc589-ezkit/Makefile b/board/adi/sc589-ezkit/Makefile
new file mode 100644
index 00000000000..0450aa373bd
--- /dev/null
+++ b/board/adi/sc589-ezkit/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= sc589-ezkit.o
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.c b/board/adi/sc589-ezkit/sc589-ezkit.c
new file mode 100644
index 00000000000..288c2670761
--- /dev/null
+++ b/board/adi/sc589-ezkit/sc589-ezkit.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <phy.h>
+#include <asm/u-boot.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/soc.h>
+
+int board_phy_config(struct phy_device *phydev)
+{
+	fixup_dp83867_phy(phydev);
+	return 0;
+}
+
+int board_init(void)
+{
+	sc5xx_enable_rgmii();
+	return 0;
+}
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 34b924992ac..b8206e85179 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -1,13 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later+ */
-
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x20000
-adi_image_offset=0xE0000
-adi_rfs_offset=0x6E0000
-loadaddr=0xC3000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_RAM
+#define USE_MMC
+#define USE_SPI
+
+#include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/Makefile b/board/adi/sc589-mini/Makefile
new file mode 100644
index 00000000000..b2712e8e488
--- /dev/null
+++ b/board/adi/sc589-mini/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	:= sc589-mini.o
diff --git a/board/adi/sc589-mini/sc589-mini.c b/board/adi/sc589-mini/sc589-mini.c
new file mode 100644
index 00000000000..288c2670761
--- /dev/null
+++ b/board/adi/sc589-mini/sc589-mini.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2025 - Analog Devices, Inc.
+ */
+
+#include <phy.h>
+#include <asm/u-boot.h>
+#include <asm/arch-adi/sc5xx/sc5xx.h>
+#include <asm/arch-adi/sc5xx/soc.h>
+
+int board_phy_config(struct phy_device *phydev)
+{
+	fixup_dp83867_phy(phydev);
+	return 0;
+}
+
+int board_init(void)
+{
+	sc5xx_enable_rgmii();
+	return 0;
+}
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 0f3f0bd28e9..f7628b0b335 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -1,13 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later+ */
-
 /*
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x20000
-adi_image_offset=0xE0000
-adi_rfs_offset=0x8E0000
-loadaddr=0xC3000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_RAM
+#define USE_SPI
+#define USE_MMC
+
+#include <env/adi/adi_boot.env>
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
new file mode 100644
index 00000000000..37f9199623e
--- /dev/null
+++ b/configs/sc589-ezkit_defconfig
@@ -0,0 +1,101 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
+CONFIG_SF_DEFAULT_SPEED=1000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0xD0000
+CONFIG_ENV_SECT_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x200C0000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_BSS_START_ADDR=0x200A0000
+CONFIG_SPL_BSS_MAX_SIZE=0x8000
+CONFIG_SC58X=y
+CONFIG_TARGET_SC589_EZKIT=y
+CONFIG_SC5XX_UBOOT_OFFSET=0x20000
+CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
+CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
+CONFIG_SC5XX_LOADADDR=0xC3000000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_ADI_USE_DMC1=y
+CONFIG_CGU0_CLKOUTSEL=7
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_SYS_CBSIZE=512
+CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_EMBED=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SPI_MAX_HZ=10000000
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc589-ezkit"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_IP_DEFRAG=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_MCP230XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_SNPS=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_SC5XX=y
+CONFIG_USB_MUSB_PIO_ONLY=y
+CONFIG_USB_STORAGE=y
+CONFIG_FAT_WRITE=y
+# CONFIG_REGEX is not set
+# CONFIG_SPL_CRC8 is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
new file mode 100644
index 00000000000..c8dd28fa2da
--- /dev/null
+++ b/configs/sc589-mini_defconfig
@@ -0,0 +1,97 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xD0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK=0x200C0000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_BSS_START_ADDR=0x200A0000
+CONFIG_SPL_BSS_MAX_SIZE=0x8000
+CONFIG_SC58X=y
+CONFIG_TARGET_SC589_MINI=y
+CONFIG_SC5XX_UBOOT_OFFSET=0x20000
+CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
+CONFIG_SC5XX_ROOTFS_OFFSET=0x8E0000
+CONFIG_SC5XX_LOADADDR=0xC3000000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_ADI_USE_DMC1=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_SYS_CBSIZE=512
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_PINMUX is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+# CONFIG_CMD_MDIO is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_EMBED=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SPI_MAX_HZ=10000000
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc589-mini"
+CONFIG_NET_RETRY_COUNT=20
+CONFIG_IP_DEFRAG=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_ADI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_SNPS=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ADI_SPI3=y
+CONFIG_SPL_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_SC5XX=y
+CONFIG_USB_MUSB_PIO_ONLY=y
+CONFIG_USB_STORAGE=y
+CONFIG_FAT_WRITE=y
+# CONFIG_REGEX is not set
-- 
2.49.1

