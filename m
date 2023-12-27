Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A4CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 12:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3139877D9;
	Wed, 27 Dec 2023 13:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BzrS/tSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC65987895; Wed, 27 Dec 2023 13:06:53 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA89877D7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5554f268c6cso612733a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703678810; x=1704283610; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb6TGeWgIwNkepl7391FM4nDJwMIAllFpBWqFPVZ904=;
 b=BzrS/tSsc/RsWRa9TNfthss3qwR4X8mOW4qoe78yWj/Q/LF3Y9x0dsofrhyR/s3dSB
 1Zhn9XDZbVvcDF2QT/xL+IzBarh72L9HUlBRAN1AzuLm6XCchVDwuR+lN9an/ICEzvjZ
 9HK+Vtn+OUuZt5lL0KQwpL5u9f5W35cyqw0/1/75yAUmpqOaVp0FwaFThQgphSAXej3Y
 jEk0tIRaLNxH6aJQV8C3mQTL9wX/kQhFIEGjF8suIv3m1KlRJUSvV++kJF6Ndp0vBw/D
 nVwx/JhjxV8gB6Z9QamYTnoy7zgkAFYARqzhRyvFfEULp4qI1+CE1FvWTibfyuqUMqLd
 9VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703678810; x=1704283610;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rb6TGeWgIwNkepl7391FM4nDJwMIAllFpBWqFPVZ904=;
 b=YcjM0TYTqhjD0yubYhlvsS0X30E+bTyPRa+LJVw+yXRUO/FIqxy1f7bhG6kXB4zkoI
 suVA1crMg0cneEk7tup/4nAjz0ZLFpx14gJeWYG3F5fmT+6pG7FntkDL33tIyfmrgeJb
 kviPnZgCiHnQF0rP5V1jOxX5tFQOPzdxrg4eCtm2SrC3qTV2IdryyfFW3g3/wF8Jj8bp
 og5zEWxbdL0CKBOIOG/n17+hEhFd2cmK9IszXozo/egr99QrWtpZ6wkFYBjJNIgvh8iD
 z7XlzPYRQFmtAChYQ4E1pPJ6VtpEQurThqAE0SGUB5nKeKUjeZS4IAmKMw7bD0XyC458
 Ll/A==
X-Gm-Message-State: AOJu0Yz+MUsYDtFnCU+jQUTJZ49KjpILgzHEBogbFFtweB4b0GJd2/hB
 z9mEDxv0RCYmn+nYaUvQ3Mc=
X-Google-Smtp-Source: AGHT+IGz6mpvSffz8yktEjDxgqnTg/snHmm4mEwt/VYxgGj1ikY8/IQeCpK3H+KSekj/CfcN1ofvLA==
X-Received: by 2002:a50:d79b:0:b0:554:2359:51b2 with SMTP id
 w27-20020a50d79b000000b00554235951b2mr5320627edi.66.1703678810033; 
 Wed, 27 Dec 2023 04:06:50 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 j21-20020aa7de95000000b0055289f60e3bsm8515783edv.79.2023.12.27.04.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 04:06:49 -0800 (PST)
Message-ID: <d46f0092-160b-143a-60bb-6e2842fef017@gmail.com>
Date: Wed, 27 Dec 2023 13:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm: dts: rockchip: rk3288: move to 64 bit reg size
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, hl@rock-chips.com,
 jernej.skrabec@gmail.com, w.egorov@phytec.de, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

To make automatic Rockchip DT syncing possible from Linux to U-boot prepare
rk3288.dtsi by moving to 64 bit reg size.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/rk3288-evb.dtsi         |   2 +-
 arch/arm/dts/rk3288-firefly.dtsi     |   2 +-
 arch/arm/dts/rk3288-miqi.dtsi        |   2 +-
 arch/arm/dts/rk3288-phycore-som.dtsi |   2 +-
 arch/arm/dts/rk3288-popmetal.dtsi    |   2 +-
 arch/arm/dts/rk3288-rock2-som.dtsi   |   2 +-
 arch/arm/dts/rk3288-tinker.dtsi      |   2 +-
 arch/arm/dts/rk3288-u-boot.dtsi      |  14 +-
 arch/arm/dts/rk3288-veyron.dtsi      |   2 +-
 arch/arm/dts/rk3288.dtsi             | 259 +++++++++++++++------------
 arch/arm/mach-rockchip/Kconfig       |   1 +
 11 files changed, 165 insertions(+), 125 deletions(-)

diff --git a/arch/arm/dts/rk3288-evb.dtsi b/arch/arm/dts/rk3288-evb.dtsi
index 72da8847344c..0e347beb154d 100644
--- a/arch/arm/dts/rk3288-evb.dtsi
+++ b/arch/arm/dts/rk3288-evb.dtsi
@@ -7,7 +7,7 @@

 / {
 	memory {
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/dts/rk3288-firefly.dtsi b/arch/arm/dts/rk3288-firefly.dtsi
index 1117d3913ed7..0824b19ee642 100644
--- a/arch/arm/dts/rk3288-firefly.dtsi
+++ b/arch/arm/dts/rk3288-firefly.dtsi
@@ -7,7 +7,7 @@

 / {
 	memory {
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/dts/rk3288-miqi.dtsi b/arch/arm/dts/rk3288-miqi.dtsi
index 00c8613d6d73..c56e1109e3ac 100644
--- a/arch/arm/dts/rk3288-miqi.dtsi
+++ b/arch/arm/dts/rk3288-miqi.dtsi
@@ -8,7 +8,7 @@
 / {
 	memory {
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/dts/rk3288-phycore-som.dtsi b/arch/arm/dts/rk3288-phycore-som.dtsi
index 70c00308d736..bde5910ff625 100644
--- a/arch/arm/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/dts/rk3288-phycore-som.dtsi
@@ -55,7 +55,7 @@
 	 */
 	memory {
 		device_type = "memory";
-		reg = <0 0x8000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	aliases {
diff --git a/arch/arm/dts/rk3288-popmetal.dtsi b/arch/arm/dts/rk3288-popmetal.dtsi
index d732a70678ba..ecff641b1099 100644
--- a/arch/arm/dts/rk3288-popmetal.dtsi
+++ b/arch/arm/dts/rk3288-popmetal.dtsi
@@ -44,7 +44,7 @@
 / {
 	memory{
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/dts/rk3288-rock2-som.dtsi b/arch/arm/dts/rk3288-rock2-som.dtsi
index 1ece66f3e162..58e32fbb80f6 100644
--- a/arch/arm/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/dts/rk3288-rock2-som.dtsi
@@ -43,7 +43,7 @@

 / {
 	memory {
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};

diff --git a/arch/arm/dts/rk3288-tinker.dtsi b/arch/arm/dts/rk3288-tinker.dtsi
index 46460ae455e2..62b4beb25100 100644
--- a/arch/arm/dts/rk3288-tinker.dtsi
+++ b/arch/arm/dts/rk3288-tinker.dtsi
@@ -44,7 +44,7 @@
 / {
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index c4c5a2d225c4..a43d320ade7b 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -29,10 +29,10 @@

 	dmc: dmc@ff610000 {
 		compatible = "rockchip,rk3288-dmc", "syscon";
-		reg = <0xff610000 0x3fc
-		       0xff620000 0x294
-		       0xff630000 0x3fc
-		       0xff640000 0x294>;
+		reg = <0x0 0xff610000 0x0 0x3fc
+		       0x0 0xff620000 0x0 0x294
+		       0x0 0xff630000 0x0 0x3fc
+		       0x0 0xff640000 0x0 0x294>;
 		clocks = <&cru PCLK_DDRUPCTL0>, <&cru PCLK_PUBL0>,
 			 <&cru PCLK_DDRUPCTL1>, <&cru PCLK_PUBL1>,
 			 <&cru ARMCLK>;
@@ -50,7 +50,7 @@

 	noc: syscon@ffac0000 {
 		compatible = "rockchip,rk3288-noc", "syscon";
-		reg = <0xffac0000 0x2000>;
+		reg = <0x0 0xffac0000 0x0 0x2000>;
 		bootph-all;
 	};
 };
@@ -134,3 +134,7 @@
 &vopl {
 	bootph-all;
 };
+
+&xin24m {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3288-veyron.dtsi b/arch/arm/dts/rk3288-veyron.dtsi
index 434b0d494e5e..99406151bf59 100644
--- a/arch/arm/dts/rk3288-veyron.dtsi
+++ b/arch/arm/dts/rk3288-veyron.dtsi
@@ -11,7 +11,7 @@

 / {
 	memory {
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};

 	chosen {
diff --git a/arch/arm/dts/rk3288.dtsi b/arch/arm/dts/rk3288.dtsi
index dd1d989793fd..ead343dc3df1 100644
--- a/arch/arm/dts/rk3288.dtsi
+++ b/arch/arm/dts/rk3288.dtsi
@@ -10,8 +10,8 @@
 #include <dt-bindings/soc/rockchip,boot-mode.h>

 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;

 	compatible = "rockchip,rk3288";

@@ -19,6 +19,15 @@

 	aliases {
 		ethernet0 = &gmac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+		gpio5 = &gpio5;
+		gpio6 = &gpio6;
+		gpio7 = &gpio7;
+		gpio8 = &gpio8;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -155,8 +164,8 @@
 	};

 	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;

 		/*
@@ -170,7 +179,7 @@
 		 * is found.
 		 */
 		dma-unusable@fe000000 {
-			reg = <0xfe000000 0x1000000>;
+			reg = <0x0 0xfe000000 0x0 0x1000000>;
 		};
 	};

@@ -213,7 +222,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0c0000 0x4000>;
+		reg = <0x0 0xff0c0000 0x0 0x4000>;
 		resets = <&cru SRST_MMC0>;
 		reset-names = "reset";
 		status = "disabled";
@@ -227,7 +236,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0d0000 0x4000>;
+		reg = <0x0 0xff0d0000 0x0 0x4000>;
 		resets = <&cru SRST_SDIO0>;
 		reset-names = "reset";
 		status = "disabled";
@@ -241,7 +250,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0e0000 0x4000>;
+		reg = <0x0 0xff0e0000 0x0 0x4000>;
 		resets = <&cru SRST_SDIO1>;
 		reset-names = "reset";
 		status = "disabled";
@@ -255,7 +264,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0f0000 0x4000>;
+		reg = <0x0 0xff0f0000 0x0 0x4000>;
 		resets = <&cru SRST_EMMC>;
 		reset-names = "reset";
 		status = "disabled";
@@ -263,7 +272,7 @@

 	saradc: saradc@ff100000 {
 		compatible = "rockchip,saradc";
-		reg = <0xff100000 0x100>;
+		reg = <0x0 0xff100000 0x0 0x100>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
@@ -282,7 +291,7 @@
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
-		reg = <0xff110000 0x1000>;
+		reg = <0x0 0xff110000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -297,7 +306,7 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
-		reg = <0xff120000 0x1000>;
+		reg = <0x0 0xff120000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -312,7 +321,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
-		reg = <0xff130000 0x1000>;
+		reg = <0x0 0xff130000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -320,7 +329,7 @@

 	i2c1: i2c@ff140000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff140000 0x1000>;
+		reg = <0x0 0xff140000 0x0 0x1000>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -333,7 +342,7 @@

 	i2c3: i2c@ff150000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff150000 0x1000>;
+		reg = <0x0 0xff150000 0x0 0x1000>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -346,7 +355,7 @@

 	i2c4: i2c@ff160000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff160000 0x1000>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -359,7 +368,7 @@

 	i2c5: i2c@ff170000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff170000 0x1000>;
+		reg = <0x0 0xff170000 0x0 0x1000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -372,7 +381,7 @@

 	uart0: serial@ff180000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff180000 0x100>;
+		reg = <0x0 0xff180000 0x0 0x100>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -387,7 +396,7 @@

 	uart1: serial@ff190000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff190000 0x100>;
+		reg = <0x0 0xff190000 0x0 0x100>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -402,7 +411,7 @@

 	uart2: serial@ff690000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff690000 0x100>;
+		reg = <0x0 0xff690000 0x0 0x100>;
 		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -415,7 +424,7 @@

 	uart3: serial@ff1b0000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff1b0000 0x100>;
+		reg = <0x0 0xff1b0000 0x0 0x100>;
 		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -430,7 +439,7 @@

 	uart4: serial@ff1c0000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff1c0000 0x100>;
+		reg = <0x0 0xff1c0000 0x0 0x100>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -445,7 +454,7 @@

 	dmac_peri: dma-controller@ff250000 {
 		compatible = "arm,pl330", "arm,primecell";
-		reg = <0xff250000 0x4000>;
+		reg = <0x0 0xff250000 0x0 0x4000>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		#dma-cells = <1>;
@@ -455,7 +464,7 @@
 		clock-names = "apb_pclk";
 	};

-	thermal: thermal-zones {
+	thermal-zones {
 		reserve_thermal: reserve-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
@@ -538,24 +547,28 @@

 	tsadc: tsadc@ff280000 {
 		compatible = "rockchip,rk3288-tsadc";
-		reg = <0xff280000 0x100>;
+		reg = <0x0 0xff280000 0x0 0x100>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
 		resets = <&cru SRST_TSADC>;
 		reset-names = "tsadc-apb";
-		pinctrl-names = "otp_out";
-		pinctrl-0 = <&otp_out>;
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_pin>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_pin>;
 		#thermal-sensor-cells = <1>;
-		hw-shut-temp = <125000>;
+		rockchip,grf = <&grf>;
+		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
 	};

 	gmac: ethernet@ff290000 {
 		compatible = "rockchip,rk3288-gmac";
-		reg = <0xff290000 0x10000>;
-		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "macirq";
+		reg = <0x0 0xff290000 0x0 0x10000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
 		rockchip,grf = <&grf>;
 		clocks = <&cru SCLK_MAC>,
 			<&cru SCLK_MAC_RX>, <&cru SCLK_MAC_TX>,
@@ -567,14 +580,14 @@
 			"aclk_mac", "pclk_mac";
 		resets = <&cru SRST_MAC>;
 		reset-names = "stmmaceth";
+		status = "disabled";
 	};

 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
-		reg = <0xff500000 0x100>;
+		reg = <0x0 0xff500000 0x0 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
-		clock-names = "usbhost";
 		phys = <&usbphy1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -594,7 +607,7 @@
 	usb_host1: usb@ff540000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
-		reg = <0xff540000 0x40000>;
+		reg = <0x0 0xff540000 0x0 0x40000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
@@ -608,7 +621,7 @@
 	usb_otg: usb@ff580000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
-		reg = <0xff580000 0x40000>;
+		reg = <0x0 0xff580000 0x0 0x40000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
@@ -623,16 +636,15 @@

 	usb_hsic: usb@ff5c0000 {
 		compatible = "generic-ehci";
-		reg = <0xff5c0000 0x100>;
+		reg = <0x0 0xff5c0000 0x0 0x100>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HSIC>;
-		clock-names = "usbhost";
 		status = "disabled";
 	};

 	dmac_bus_ns: dma-controller@ff600000 {
 		compatible = "arm,pl330", "arm,primecell";
-		reg = <0xff600000 0x4000>;
+		reg = <0x0 0xff600000 0x0 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		#dma-cells = <1>;
@@ -645,7 +657,7 @@

 	i2c0: i2c@ff650000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff650000 0x1000>;
+		reg = <0x0 0xff650000 0x0 0x1000>;
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -658,7 +670,7 @@

 	i2c2: i2c@ff660000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff660000 0x1000>;
+		reg = <0x0 0xff660000 0x0 0x1000>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -671,7 +683,7 @@

 	pwm0: pwm@ff680000 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680000 0x10>;
+		reg = <0x0 0xff680000 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
@@ -681,7 +693,7 @@

 	pwm1: pwm@ff680010 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680010 0x10>;
+		reg = <0x0 0xff680010 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
@@ -691,7 +703,7 @@

 	pwm2: pwm@ff680020 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680020 0x10>;
+		reg = <0x0 0xff680020 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
@@ -701,7 +713,7 @@

 	pwm3: pwm@ff680030 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680030 0x10>;
+		reg = <0x0 0xff680030 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
@@ -711,10 +723,10 @@

 	bus_intmem: sram@ff700000 {
 		compatible = "mmio-sram";
-		reg = <0xff700000 0x18000>;
+		reg = <0x0 0xff700000 0x0 0x18000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0xff700000 0x18000>;
+		ranges = <0 0x0 0xff700000 0x18000>;
 		smp-sram@0 {
 			compatible = "rockchip,rk3066-smp-sram";
 			reg = <0x00 0x10>;
@@ -723,12 +735,12 @@

 	pmu_sram: sram@ff720000 {
 		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
-		reg = <0xff720000 0x1000>;
+		reg = <0x0 0xff720000 0x0 0x1000>;
 	};

 	pmu: power-management@ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon", "simple-mfd";
-		reg = <0xff730000 0x100>;
+		reg = <0x0 0xff730000 0x0 0x100>;

 		power: power-controller {
 			compatible = "rockchip,rk3288-power-controller";
@@ -853,12 +865,14 @@

 	sgrf: syscon@ff740000 {
 		compatible = "rockchip,rk3288-sgrf", "syscon";
-		reg = <0xff740000 0x1000>;
+		reg = <0x0 0xff740000 0x0 0x1000>;
 	};

 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3288-cru";
-		reg = <0xff760000 0x1000>;
+		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -876,7 +890,7 @@

 	grf: syscon@ff770000 {
 		compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
-		reg = <0xff770000 0x1000>;
+		reg = <0x0 0xff770000 0x0 0x1000>;

 		edp_phy: edp-phy {
 			compatible = "rockchip,rk3288-dp-phy";
@@ -931,15 +945,15 @@

 	wdt: watchdog@ff800000 {
 		compatible = "rockchip,rk3288-wdt", "snps,dw-wdt";
-		reg = <0xff800000 0x100>;
+		reg = <0x0 0xff800000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};

-	spdif: sound@ff88b0000 {
+	spdif: sound@ff8b0000 {
 		compatible = "rockchip,rk3288-spdif", "rockchip,rk3066-spdif";
-		reg = <0xff8b0000 0x10000>;
+		reg = <0x0 0xff8b0000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
 		clocks = <&cru SCLK_SPDIF8CH>, <&cru HCLK_SPDIF8CH>;
 		clock-names = "mclk", "hclk";
@@ -954,7 +968,7 @@

 	i2s: i2s@ff890000 {
 		compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
-		reg = <0xff890000 0x10000>;
+		reg = <0x0 0xff890000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
@@ -970,7 +984,7 @@

 	crypto: crypto@ff8a0000 {
 		compatible = "rockchip,rk3288-crypto";
-		reg = <0xff8a0000 0x4000>;
+		reg = <0x0 0xff8a0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
 			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
@@ -981,7 +995,7 @@

 	iep_mmu: iommu@ff900800 {
 		compatible = "rockchip,iommu";
-		reg = <0xff900800 0x40>;
+		reg = <0x0 0xff900800 0x0 0x40>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
@@ -991,7 +1005,7 @@

 	isp_mmu: iommu@ff914000 {
 		compatible = "rockchip,iommu";
-		reg = <0xff914000 0x100>, <0xff915000 0x100>;
+		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
 		clock-names = "aclk", "iface";
@@ -1002,7 +1016,7 @@

 	rga: rga@ff920000 {
 		compatible = "rockchip,rk3288-rga";
-		reg = <0xff920000 0x180>;
+		reg = <0x0 0xff920000 0x0 0x180>;
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
 		clock-names = "aclk", "hclk", "sclk";
@@ -1013,7 +1027,7 @@

 	vopb: vop@ff930000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0xff930000 0x19c>, <0xff931000 0x1000>;
+		reg = <0x0 0xff930000 0x0 0x19c>, <0x0 0xff931000 0x0 0x1000>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
@@ -1051,7 +1065,7 @@

 	vopb_mmu: iommu@ff930300 {
 		compatible = "rockchip,iommu";
-		reg = <0xff930300 0x100>;
+		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk", "iface";
@@ -1062,7 +1076,7 @@

 	vopl: vop@ff940000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0xff940000 0x19c>, <0xff941000 0x1000>;
+		reg = <0x0 0xff940000 0x0 0x19c>, <0x0 0xff941000 0x0 0x1000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
@@ -1100,7 +1114,7 @@

 	vopl_mmu: iommu@ff940300 {
 		compatible = "rockchip,iommu";
-		reg = <0xff940300 0x100>;
+		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk", "iface";
@@ -1109,9 +1123,9 @@
 		status = "disabled";
 	};

-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
-		reg = <0xff960000 0x4000>;
+		reg = <0x0 0xff960000 0x0 0x4000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
 		clock-names = "ref", "pclk";
@@ -1120,24 +1134,34 @@
 		status = "disabled";

 		ports {
-			mipi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				mipi_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_mipi>;
 				};
+
 				mipi_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_mipi>;
 				};
 			};
+
+			mipi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

 	lvds: lvds@ff96c000 {
 		compatible = "rockchip,rk3288-lvds";
-		reg = <0xff96c000 0x4000>;
+		reg = <0x0 0xff96c000 0x0 0x4000>;
 		clocks = <&cru PCLK_LVDS_PHY>;
 		clock-names = "pclk_lvds";
 		pinctrl-names = "lcdc";
@@ -1152,7 +1176,6 @@

 			lvds_in: port@0 {
 				reg = <0>;
-
 				#address-cells = <1>;
 				#size-cells = <0>;

@@ -1160,17 +1183,22 @@
 					reg = <0>;
 					remote-endpoint = <&vopb_out_lvds>;
 				};
+
 				lvds_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_lvds>;
 				};
 			};
+
+			lvds_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

 	edp: dp@ff970000 {
 		compatible = "rockchip,rk3288-dp";
-		reg = <0xff970000 0x4000>;
+		reg = <0x0 0xff970000 0x0 0x4000>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
 		clock-names = "dp", "pclk";
@@ -1185,25 +1213,32 @@
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
 			edp_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				edp_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_edp>;
 				};
+
 				edp_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_edp>;
 				};
 			};
+
+			edp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

 	hdmi: hdmi@ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
-		reg = <0xff980000 0x20000>;
+		reg = <0x0 0xff980000 0x0 0x20000>;
 		reg-io-width = <4>;
 		#sound-dai-cells = <0>;
 		rockchip,grf = <&grf>;
@@ -1231,7 +1266,7 @@

 	vpu: video-codec@ff9a0000 {
 		compatible = "rockchip,rk3288-vpu";
-		reg = <0xff9a0000 0x800>;
+		reg = <0x0 0xff9a0000 0x0 0x800>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vepu", "vdpu";
@@ -1243,7 +1278,7 @@

 	vpu_mmu: iommu@ff9a0800 {
 		compatible = "rockchip,iommu";
-		reg = <0xff9a0800 0x100>;
+		reg = <0x0 0xff9a0800 0x0 0x100>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "iface";
@@ -1253,7 +1288,7 @@

 	hevc_mmu: iommu@ff9c0440 {
 		compatible = "rockchip,iommu";
-		reg = <0xff9c0440 0x40>, <0xff9c0480 0x40>;
+		reg = <0x0 0xff9c0440 0x0 0x40>, <0x0 0xff9c0480 0x0 0x40>;
 		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>;
 		clock-names = "aclk", "iface";
@@ -1263,7 +1298,7 @@

 	gpu: gpu@ffa30000 {
 		compatible = "rockchip,rk3288-mali", "arm,mali-t760";
-		reg = <0xffa30000 0x10000>;
+		reg = <0x0 0xffa30000 0x0 0x10000>;
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -1302,22 +1337,22 @@

 	qos_gpu_r: qos@ffaa0000 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffaa0000 0x20>;
+		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};

 	qos_gpu_w: qos@ffaa0080 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffaa0080 0x20>;
+		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};

 	qos_vio1_vop: qos@ffad0000 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0000 0x20>;
+		reg = <0x0 0xffad0000 0x0 0x20>;
 	};

 	qos_vio1_isp_w0: qos@ffad0100 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0100 0x20>;
+		reg = <0x0 0xffad0100 0x0 0x20>;
 	};

 	qos_vio1_isp_w1: qos@ffad0180 {
@@ -1332,47 +1367,47 @@

 	qos_vio0_vip: qos@ffad0480 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0480 0x20>;
+		reg = <0x0 0xffad0480 0x0 0x20>;
 	};

 	qos_vio0_iep: qos@ffad0500 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0500 0x20>;
+		reg = <0x0 0xffad0500 0x0 0x20>;
 	};

 	qos_vio2_rga_r: qos@ffad0800 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0800 0x20>;
+		reg = <0x0 0xffad0800 0x0 0x20>;
 	};

 	qos_vio2_rga_w: qos@ffad0880 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0880 0x20>;
+		reg = <0x0 0xffad0880 0x0 0x20>;
 	};

 	qos_vio1_isp_r: qos@ffad0900 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffad0900 0x20>;
+		reg = <0x0 0xffad0900 0x0 0x20>;
 	};

 	qos_video: qos@ffae0000 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffae0000 0x20>;
+		reg = <0x0 0xffae0000 0x0 0x20>;
 	};

 	qos_hevc_r: qos@ffaf0000 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffaf0000 0x20>;
+		reg = <0x0 0xffaf0000 0x0 0x20>;
 	};

 	qos_hevc_w: qos@ffaf0080 {
 		compatible = "rockchip,rk3288-qos", "syscon";
-		reg = <0xffaf0080 0x20>;
+		reg = <0x0 0xffaf0080 0x0 0x20>;
 	};

 	dmac_bus_s: dma-controller@ffb20000 {
 		compatible = "arm,pl330", "arm,primecell";
-		reg = <0xffb20000 0x4000>;
+		reg = <0x0 0xffb20000 0x0 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		#dma-cells = <1>;
@@ -1384,7 +1419,7 @@

 	efuse: efuse@ffb40000 {
 		compatible = "rockchip,rk3288-efuse";
-		reg = <0xffb40000 0x10000>;
+		reg = <0x0 0xffb40000 0x0 0x20>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		clocks = <&cru PCLK_EFUSE256>;
@@ -1404,10 +1439,10 @@
 		#interrupt-cells = <3>;
 		#address-cells = <0>;

-		reg = <0xffc01000 0x1000>,
-		      <0xffc02000 0x1000>,
-		      <0xffc04000 0x2000>,
-		      <0xffc06000 0x2000>;
+		reg = <0x0 0xffc01000 0x0 0x1000>,
+		      <0x0 0xffc02000 0x0 0x2000>,
+		      <0x0 0xffc04000 0x0 0x2000>,
+		      <0x0 0xffc06000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 0xf04>;
 	};

@@ -1415,13 +1450,13 @@
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
 		rockchip,pmu = <&pmu>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;

-		gpio0: gpio0@ff750000 {
+		gpio0: gpio@ff750000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff750000 0x100>;
+			reg = <0x0 0xff750000 0x0 0x100>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;

@@ -1432,9 +1467,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio1: gpio1@ff780000 {
+		gpio1: gpio@ff780000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff780000 0x100>;
+			reg = <0x0 0xff780000 0x0 0x100>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;

@@ -1445,9 +1480,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio2: gpio2@ff790000 {
+		gpio2: gpio@ff790000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff790000 0x100>;
+			reg = <0x0 0xff790000 0x0 0x100>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;

@@ -1458,9 +1493,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio3: gpio3@ff7a0000 {
+		gpio3: gpio@ff7a0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7a0000 0x100>;
+			reg = <0x0 0xff7a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;

@@ -1471,9 +1506,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio4: gpio4@ff7b0000 {
+		gpio4: gpio@ff7b0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7b0000 0x100>;
+			reg = <0x0 0xff7b0000 0x0 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;

@@ -1484,9 +1519,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio5: gpio5@ff7c0000 {
+		gpio5: gpio@ff7c0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7c0000 0x100>;
+			reg = <0x0 0xff7c0000 0x0 0x100>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO5>;

@@ -1497,9 +1532,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio6: gpio6@ff7d0000 {
+		gpio6: gpio@ff7d0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7d0000 0x100>;
+			reg = <0x0 0xff7d0000 0x0 0x100>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;

@@ -1510,9 +1545,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio7: gpio7@ff7e0000 {
+		gpio7: gpio@ff7e0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7e0000 0x100>;
+			reg = <0x0 0xff7e0000 0x0 0x100>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO7>;

@@ -1523,9 +1558,9 @@
 			#interrupt-cells = <2>;
 		};

-		gpio8: gpio8@ff7f0000 {
+		gpio8: gpio@ff7f0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7f0000 0x100>;
+			reg = <0x0 0xff7f0000 0x0 0x100>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO8>;

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b577a911e789..6ff0aa6911e2 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -125,6 +125,7 @@ config ROCKCHIP_RK3288
 	select SUPPORT_SPL
 	select SPL
 	select SUPPORT_TPL
+	select FDT_64BIT
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
--
2.39.2

