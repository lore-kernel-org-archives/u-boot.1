Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12402C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D733B86954;
	Sun,  3 Sep 2023 22:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KyPoZxo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558258693D; Sun,  3 Sep 2023 22:49:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D8A86901
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so1162071a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774145; x=1694378945;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oU/q22HAug8UzsnmuC0vhco1L9LOpbnUW7H8vuRFmVk=;
 b=KyPoZxo4Xcgd/pX9tnDrO0UuOJArnJg4ISIoUj3l84QRwjusrE+E5ep/hAd6VDmhhm
 QObIzdgbPEdrM2DpjLQcgRfg5vy4Eb2B6xf3g0fte+qP1+cdspzI0ymLrmWqZHCrHWvf
 DILWN1ffIOCqvx+SEQzQyaKj+ZiCBtYqL8SOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774145; x=1694378945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU/q22HAug8UzsnmuC0vhco1L9LOpbnUW7H8vuRFmVk=;
 b=YlPWFj9UNZ8KNA8/wAqpbMMTDcjsOyvuBC3EFemGFOF5H9Sx19iXTvVNXZnwVCoIBk
 N3sxv1ae9gGGJ7oNsEOdmWJR6LocQql9pnoW1XRApe+iapGAlf/JpAZh4DNwXZRnagnc
 jKPsbL6doY07CWxoCBL2EG4BjdtVfoFFrNywMxVgCkZ/zexAQsJSMqk9hnSqz8udHz1X
 FRhJSIbCUoe/AthAosi048cYlnZZGMPg1YjWwYt20yVp1zNq+fctTlyfGa9ainuwzk6K
 +KSU/pEHiZmkI1r6+uJ9tsU5c8N0/xswS6zh01GlpdFbjT8V1lQ4hg+io3J9WSWc4rjk
 qUNQ==
X-Gm-Message-State: AOJu0YzJEDZm2g4VMlqcIQk3qWNF+qCo0RUOtNa1EBwFg+Xb90e0Dr/U
 0HVLfNVjNNAeuzYJ3vMHvtomcdTfb+B+uiTXSkUAxg==
X-Google-Smtp-Source: AGHT+IGlY+8nKiSRsyM1BgA1H4VgnlW6bGKVNGvAsqdRq4IfNuiv5Qb3NzW/kDlSMfdxvm1KuJCXNg==
X-Received: by 2002:a17:906:2210:b0:994:1eb4:6898 with SMTP id
 s16-20020a170906221000b009941eb46898mr6619562ejs.9.1693774144766; 
 Sun, 03 Sep 2023 13:49:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:49:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 10/10] ARM: dts: stm32: support display on stm32f746-disco
 board
Date: Sun,  3 Sep 2023 22:48:49 +0200
Message-Id: <20230903204849.660722-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
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

The patch applies the changes from Linux commit 10a970bc3ebfa ("ARM: dts:
stm32: support display on stm32f746-disco board") and removes the same
settings from stm32f746-disco-u-boot.dtsi.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/dts/stm32f746-disco-u-boot.dtsi | 89 ++++++------------------
 arch/arm/dts/stm32f746-disco.dts         | 44 ++++++++++++
 2 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/arch/arm/dts/stm32f746-disco-u-boot.dtsi b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
index 3c2b9fc59512..1b42d6cbbc19 100644
--- a/arch/arm/dts/stm32f746-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f746-disco-u-boot.dtsi
@@ -23,12 +23,6 @@
 		spi0 = &qspi;
 	};
 
-	backlight: backlight {
-		compatible = "gpio-backlight";
-		gpios = <&gpiok 3 0>;
-		status = "okay";
-	};
-
 	button1 {
 		compatible = "st,button1";
 		button-gpio = <&gpioi 11 0>;
@@ -38,37 +32,10 @@
 		compatible = "st,led1";
 		led-gpio = <&gpioi 1 0>;
 	};
-
-	panel-rgb@0 {
-		compatible = "simple-panel";
-		backlight = <&backlight>;
-		enable-gpios = <&gpioi 12 0>;
-		status = "okay";
-
-		display-timings {
-			timing@0 {
-				clock-frequency = <9000000>;
-				hactive = <480>;
-				vactive = <272>;
-				hfront-porch = <2>;
-				hback-porch = <2>;
-				hsync-len = <41>;
-				vfront-porch = <2>;
-				vback-porch = <2>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
 };
 
 &ltdc {
 	clocks = <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>;
-	pinctrl-0 = <&ltdc_pins>;
-	status = "okay";
 	bootph-all;
 };
 
@@ -96,6 +63,28 @@
 	};
 };
 
+&panel_rgb {
+	compatible = "simple-panel";
+
+	display-timings {
+		timing@0 {
+			clock-frequency = <9000000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <2>;
+			hback-porch = <2>;
+			hsync-len = <41>;
+			vfront-porch = <2>;
+			vback-porch = <2>;
+			vsync-len = <10>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
+
 &pinctrl {
 	ethernet_mii: mii@0 {
 		pins {
@@ -160,40 +149,6 @@
 		};
 	};
 
-	ltdc_pins: ltdc@0 {
-		pins {
-			pinmux = <STM32_PINMUX('E', 4, AF14)>, /* B0 */
-				 <STM32_PINMUX('G',12, AF9)>,  /* B4 */
-				 <STM32_PINMUX('I', 9, AF14)>, /* VSYNC */
-				 <STM32_PINMUX('I',10, AF14)>, /* HSYNC */
-				 <STM32_PINMUX('I',14, AF14)>, /* CLK */
-				 <STM32_PINMUX('I',15, AF14)>, /* R0 */
-				 <STM32_PINMUX('J', 0, AF14)>, /* R1 */
-				 <STM32_PINMUX('J', 1, AF14)>, /* R2 */
-				 <STM32_PINMUX('J', 2, AF14)>, /* R3 */
-				 <STM32_PINMUX('J', 3, AF14)>, /* R4 */
-				 <STM32_PINMUX('J', 4, AF14)>, /* R5 */
-				 <STM32_PINMUX('J', 5, AF14)>, /* R6 */
-				 <STM32_PINMUX('J', 6, AF14)>, /* R7 */
-				 <STM32_PINMUX('J', 7, AF14)>, /* G0 */
-				 <STM32_PINMUX('J', 8, AF14)>, /* G1 */
-				 <STM32_PINMUX('J', 9, AF14)>, /* G2 */
-				 <STM32_PINMUX('J',10, AF14)>, /* G3 */
-				 <STM32_PINMUX('J',11, AF14)>, /* G4 */
-				 <STM32_PINMUX('J',13, AF14)>, /* B1 */
-				 <STM32_PINMUX('J',14, AF14)>, /* B2 */
-				 <STM32_PINMUX('J',15, AF14)>, /* B3 */
-				 <STM32_PINMUX('K', 0, AF14)>, /* G5 */
-				 <STM32_PINMUX('K', 1, AF14)>, /* G6 */
-				 <STM32_PINMUX('K', 2, AF14)>, /* G7 */
-				 <STM32_PINMUX('K', 4, AF14)>, /* B5 */
-				 <STM32_PINMUX('K', 5, AF14)>, /* B6 */
-				 <STM32_PINMUX('K', 6, AF14)>, /* B7 */
-				 <STM32_PINMUX('K', 7, AF14)>; /* DE */
-			slew-rate = <2>;
-		};
-	};
-
 	qspi_pins: qspi@0 {
 		pins {
 			pinmux = <STM32_PINMUX('B', 2, AF9)>, /* CLK */
diff --git a/arch/arm/dts/stm32f746-disco.dts b/arch/arm/dts/stm32f746-disco.dts
index e1564d69f9f6..431275134033 100644
--- a/arch/arm/dts/stm32f746-disco.dts
+++ b/arch/arm/dts/stm32f746-disco.dts
@@ -25,6 +25,19 @@
 		reg = <0xC0000000 0x800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x80000>;
+			linux,dma-default;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
@@ -50,6 +63,25 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		power-supply = <&vcc_3v3>;
+		backlight = <&backlight>;
+		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
 };
 
 &clk_hse {
@@ -80,6 +112,18 @@
 	};
 };
 
+&ltdc {
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&vcc_3v3>;
-- 
2.34.1

