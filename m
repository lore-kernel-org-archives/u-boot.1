Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D99C5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D734881E25;
	Mon,  2 Jun 2025 21:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JN+84J5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CAA82ADA; Mon,  2 Jun 2025 21:47:12 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF6581D6A
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e803de44766so2934908276.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893628; x=1749498428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsClkZ0wM9cHhXAjZ5dA+HNm972ONtXssxbNb4UJH3U=;
 b=JN+84J5nIHfd6ArDmC3hV/+RMipLqX2zUNfig1THyoMdEiiWKaDJhwR+WP2ci/Gex4
 5alWT6MDepIQk/fpKM2e4+TaEV4sTXYmJhAPylfl23oAOOdkKe1BXeQokuJZSMwxqf5r
 1t5L29j180fdYxoMs1VPGCehPR7xyY4myp0+HFK7el4MMvkKFmzsb5zasErTopF3gvqT
 UQI+4Vyeuu3lLcZRZPI2QDC+0sluv6LuGoce2y+iGNoQdM150XV3ElSW8ECk9qT2of8z
 JIzTMCvOaOLX5Usr+WxqI17TbYhzRRhSWde1Kwc/fW/hPq/e96KRrCJcamL01Rm8z8cI
 Iefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893628; x=1749498428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsClkZ0wM9cHhXAjZ5dA+HNm972ONtXssxbNb4UJH3U=;
 b=A7IygNeMZPs36VyIsxuUwkhj+KAjxhtzy4ZubiHj5Lj18u/Uo4YhYJHkLcWiTczx41
 oPPzGIj92O2fJTu4SSlW7b++84mrznTP0OAm6VG7vjC/ErrpH4ZNWVfKwxDosf2Mm7ix
 tVqqNOULzbRQ1o8uRBwxmZY1FB59bz5KUmJ8MGP/5Vh2lfPmlkhuMblWQFnztVaUL4Zm
 c1YsVH/tYVDxN7fnYY/fRE5OP+NyJMAjF4WDa/oqd4EkhhhhqvTeJGbY8xfUMPbtw1XS
 ejc0c9X5Uj/4L7ZNnjN0g/jmVXgjd44UeeudiG75cpzwpvAN5aDJhf7v7MLrL4wXMbAL
 k8TA==
X-Gm-Message-State: AOJu0YwnH6U9h3ynIdq1u+GSD3RZD6TQgX2HWSy4jSmXC6U9qZR32mfr
 83jgWDqNOgjgfp3TWLCEDrd3sA/bb5KaVmJIKZGGviUBo1iKWEPxKGEOnvFc
X-Gm-Gg: ASbGnctxvA3Qp1CkRlwqxUOYYhLhjVobSTpQm0N7rnXrrsd+my5p+czM+R32arFEbdc
 nlLcox32D3BgKNUHV1PZs06XXDscM7PVy8WuXYcvglrV0e50q1HJEG+QGaJGxDLB4LZxZ4Sv0T3
 lv3ssqabOloLuY2K1huGqFeZEdqYhvkfCsX9vvxC6WTOOK6j23Y+d7i2Iduj+ChzgwK++MjWY++
 y2VHlnYXvB5tj+7S3Nep0mOCV7dO8HZPwld2rMWr03rQMZTs+2OEMscuesROeno2ruMp/lBXfoC
 w4BpGlBb47rpgTjd+HXoUuZWARxNKKCRkt5eK77aGA0maJe5i0VFjerDhDWU0ThDsrWAhdv+his
 j/w==
X-Google-Smtp-Source: AGHT+IGZu3BZcbR+uViUMv5KdM9NVssp+tN5HS6Bhlk/p2D8b3zKVT7gT1Z7y+0Ja4+e0ey98HGnsQ==
X-Received: by 2002:a81:ff0a:0:b0:710:a3d4:ed39 with SMTP id
 00721157ae682-710a3d4ee44mr81026977b3.35.1748893628310; 
 Mon, 02 Jun 2025 12:47:08 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:07 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] board: adi: Add support for SC573-ezkit
Date: Mon,  2 Jun 2025 15:44:43 -0400
Message-ID: <20250602194507.15159-6-malysagreg@gmail.com>
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

This adds support for the Analog Devices SC573 EZKIT.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 arch/arm/dts/sc573-ezkit.dts          | 227 ++++++++++++++++++++++++++
 arch/arm/dts/sc57x.dtsi               | 123 +++++++++++++-
 board/adi/sc573-ezkit/Makefile        |   6 +
 board/adi/sc573-ezkit/sc573-ezkit.c   |  21 +++
 board/adi/sc573-ezkit/sc573-ezkit.env |  17 +-
 configs/sc573-ezkit_defconfig         | 102 ++++++++++++
 6 files changed, 486 insertions(+), 10 deletions(-)
 create mode 100644 board/adi/sc573-ezkit/Makefile
 create mode 100644 board/adi/sc573-ezkit/sc573-ezkit.c
 create mode 100644 configs/sc573-ezkit_defconfig

diff --git a/arch/arm/dts/sc573-ezkit.dts b/arch/arm/dts/sc573-ezkit.dts
index 0dc2962618c..d6374f919f2 100644
--- a/arch/arm/dts/sc573-ezkit.dts
+++ b/arch/arm/dts/sc573-ezkit.dts
@@ -5,9 +5,236 @@
 
 /dts-v1/;
 
+#include "sc5xx.dtsi"
 #include "sc57x.dtsi"
 
 / {
 	model = "ADI SC573-EZKIT";
 	compatible = "adi,sc573-ezkit", "adi,sc57x";
 };
+
+&i2c0 {
+	gpio_expander1: mcp23017@21 {
+		compatible = "microchip,mcp23017";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		eeprom {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~eeprom-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~mlb-en";
+			bootph-pre-ram;
+		};
+
+		can0 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~can0-en";
+			bootph-pre-ram;
+		};
+
+		can1 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~can1-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~adau1979-en";
+			bootph-pre-ram;
+		};
+
+		sd-wp-en {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~sd-wp-en";
+			bootph-pre-ram;
+		};
+
+		spi2flash-cs {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2flash-cs";
+			bootph-pre-ram;
+		};
+
+		spi2d2-d3 {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "~spi2d2-d3-en";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~spdif-digital-en";
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
+		pushbutton3 {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~pushbutton3-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton2 {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~pushbutton2-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton1 {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~pushbutton1-en";
+			bootph-pre-ram;
+		};
+
+		leds {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~leds-en";
+			bootph-pre-ram;
+		};
+
+		flg0 {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~flg0_loop";
+			bootph-pre-ram;
+		};
+
+		flg1 {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~flg1_loop";
+			bootph-pre-ram;
+		};
+
+		flg2 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~flg2_loop";
+			bootph-pre-ram;
+		};
+
+		flg3 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~flg3_loop";
+			bootph-pre-ram;
+		};
+
+		adau1977 {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~adau1977_en";
+			bootph-pre-ram;
+		};
+
+		adau1977_fault_rst {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~adau1977_fault_rst_en";
+			bootph-pre-ram;
+		};
+
+		thumbwheel {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~thumbwheel_oe";
+			bootph-pre-ram;
+		};
+
+		engine_rpm {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~engine_rpm_oe";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&eth0 {
+	snps,reset-gpio = <&gpio0 ADI_ADSP_PIN('A', 5) GPIO_ACTIVE_LOW>;
+};
+
+&gpio0 {
+	emac0_phy_pwdn {
+		gpio-hog;
+		output-high;
+		gpios = <ADI_ADSP_PIN('A', 4) GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&mmc {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
index ddfcae8d190..030769b9621 100644
--- a/arch/arm/dts/sc57x.dtsi
+++ b/arch/arm/dts/sc57x.dtsi
@@ -3,19 +3,134 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include "sc5xx.dtsi"
-
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
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+						 <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc", "dma";
+			status = "okay";
+		};
+
+	};
 };
 
 &timer0 {
 	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
 };
+
+&pinctrl0 {
+	mmc_default: mmc_pins {
+		adi,pins = <ADI_ADSP_PIN('E', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 14) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('E', 15) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 0) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 1) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 3) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 7) ADI_ADSP_PINFUNC_ALT2>,
+					<ADI_ADSP_PIN('C', 12) ADI_ADSP_PINFUNC_ALT1>;
+	};
+
+	eth0_default: eth0_pins {
+		adi,pins = <ADI_ADSP_PIN('B', 7) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 8) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 6) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 5) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 14) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 15) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 9) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 4) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 0) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 2) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 10) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('A', 11) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	uart0_default: uart0_pins {
+		bootph-pre-ram;
+		adi,pins = <ADI_ADSP_PIN('F', 8) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('F', 9) ADI_ADSP_PINFUNC_ALT0>;
+	};
+
+	spi2_default: spi2_pins {
+		adi,pins = <ADI_ADSP_PIN('B', 14) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 10) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 11) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 12) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 13) ADI_ADSP_PINFUNC_ALT0>,
+					<ADI_ADSP_PIN('B', 15) ADI_ADSP_PINFUNC_ALT0>;
+	};
+};
+
+&pinctrl0 {
+	adi,npins = <92>;
+};
+
+&gpio0 {
+	adi,ngpios = <92>;
+};
+
+&clk{
+	compatible = "adi,sc57x-clocks";
+};
+
+&uart0{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
+
+&spi2{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK1>;
+	reg = <0x31044000 0x1000>;
+};
+
+&wdog{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
+
+&eth0{
+	reg = <0x3100C000 0x1000>;
+};
+
+&mmc{
+	clocks = <&dummy>, <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
+
+&i2c0{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
+
+&i2c1{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
+
+&i2c2{
+	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+};
diff --git a/board/adi/sc573-ezkit/Makefile b/board/adi/sc573-ezkit/Makefile
new file mode 100644
index 00000000000..0ea725b992b
--- /dev/null
+++ b/board/adi/sc573-ezkit/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2025 - Analog Devices, Inc.
+#
+
+obj-y	+= sc573-ezkit.o
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.c b/board/adi/sc573-ezkit/sc573-ezkit.c
new file mode 100644
index 00000000000..288c2670761
--- /dev/null
+++ b/board/adi/sc573-ezkit/sc573-ezkit.c
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
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 26f7b6cb799..d53a72dca57 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -4,10 +4,15 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#include <env/adi/adi_boot.env>
-
-adi_stage2_offset=0x20000
-adi_image_offset=0xE0000
-adi_rfs_offset=0x6E0000
-loadaddr=0x83000000
+adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
+adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
+loadaddr=CONFIG_SC5XX_LOADADDR
+
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+
+#include <env/adi/adi_boot.env>
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
new file mode 100644
index 00000000000..e1e59b359aa
--- /dev/null
+++ b/configs/sc573-ezkit_defconfig
@@ -0,0 +1,102 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
+CONFIG_ARCH_SC5XX=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_GPIO=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0xD0000
+CONFIG_ENV_SECT_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SC5XX_UBOOT_OFFSET=0x20000
+CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
+CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
+CONFIG_SC5XX_LOADADDR=0x83000000
+# CONFIG_PACK_FITIMAGE is not set
+# CONFIG_PACK_ROOTFS is not set
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_CGU0_CLKOUTSEL=7
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
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="sc57x"
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
-- 
2.45.2

