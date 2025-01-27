Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B8C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B4D8141A;
	Mon, 27 Jan 2025 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NDZvutL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1458129B; Mon, 27 Jan 2025 14:41:17 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E70681265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso34466955e9.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985274; x=1738590074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ft1jUex3OX1rjN4NzcaLRGcDbORy+tvfnlr1PviY/04=;
 b=NDZvutL1wzb2wQxN7TcoEh+OqgLSDE37v4bQB1DCu7F2rRl3v8ZGfz4nXIwdbG2BOo
 jxxklT4+weFawKdUfCVEqnAfTbuyN/1td78feoc70uUrAmcUJLQAuDql1+4ZBrzpHQJm
 XXKVY9/MSoLeNNMlcLvmTgwduEdVbzDiaIEVcmCy2ufbHSjVe6yfxLZl2w7m5mcO0hlz
 3/OhxFuwwgZx8KiR2n1kNGMJk6hvpslj/ErH6Sb0TN8kvkyFAukio9sPvx9IbwqT8cSL
 SZVLEs7GpJVTbHaLHvrOrrr3IdjZmdZF+yxHv0y2UxrLD6ytqZygZT4NclWwkA0TJAM1
 SNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985274; x=1738590074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ft1jUex3OX1rjN4NzcaLRGcDbORy+tvfnlr1PviY/04=;
 b=q01nTVFY26BBqIN6ikg+aKXdZiy2oVHV0EnVCfcUYpbNTmUuezBQCJ/hqaH5ApRGCH
 WBGLtFYyFbjxTtK9vG+q0Hio16T+v/b5RwEUhzRQxJYbZ7G7tvsP7FvUCNbY+XmyyPfR
 Sxjhm792aB2OR2uSJySeUBroBCpHQPwQfh2UfIcEkMTVm3HpJnTzeVLMbudYuGdDHjy0
 p9+mXe40AhgMx9U+/0oeYlhOaoX1kBLEvzRNbqRjyBUfWNZzcJnjqZyYhrrpkIH7iMO7
 MEIUJH4sNgiXbob8oZQBKMXMpKMqARfDU3ePxWRd7/Hc9S+mG0NAFErFZ484yVjC8DFd
 V/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUztpk946dIPjxT326FiYcyIJ4wVhC2CWMzlL+l4ouCymybyY4RIAvu2UnXIyKXGsPuom+fcLc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1fDLky3gbcSUjwurMFfy8huWZq1bJRJhYnMqfGj2lFiqw4cY9
 ERg6IEvEPQAOi9/kTXq4GwFuGlTaZ9pxRdPcgjAyMS/WRMXh4qyf
X-Gm-Gg: ASbGnctrogjbrz/MLaif8UzclkyNBvPbVGoM9AjZjvGTixdq02DJWi6W9MRNTh8mtUb
 ZpioaaKiCsU2Q3LdlJEpttNyVtZQPfgSPL0aLYHjuvGi5my17pG73fTjzC9/i0pTFnb+KC6D2+f
 496NFZ53Sl7Gtl1r9Ig8etz+bubT5mVmGkZnEgUbP1ePA6/WdUPMvg2DgUgOcFg2bEn79ng9hIU
 QBdljWFYECzj8ZUDwMmBCD21fMDRHsS6043YUWEZdKYF3Tqaa0dwH/ma8Q+PC5GGGWGtvjycn03
 DGm19pcurtCwGs0YGWytzAJe05XFpd8I9nnxYbwxubs30IcI4w==
X-Google-Smtp-Source: AGHT+IFlcdrn7P1MAqElbF//Yz0MSCx3J9252DdTuOvtY31iQ5bqVie5ZOu1fn99TniSW9Eq+k7/8A==
X-Received: by 2002:a5d:48cc:0:b0:38a:9ffb:ff02 with SMTP id
 ffacd0b85a97d-38c2226c2b7mr13329287f8f.12.1737985274533; 
 Mon, 27 Jan 2025 05:41:14 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:14 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 3/8] mediatek: mt7986: move gpio-controller up and rename
 pinctrl to pio
Date: Mon, 27 Jan 2025 14:40:40 +0100
Message-ID: <20250127134046.26345-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Move gpio-controller up to pinctrl node and rename label to "pio" to
match the label used in upstream kernel linux.

Update any DTS that reference the pinctrl to follow the new naming and
structure.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi           |  8 +++-----
 arch/arm/dts/mt7986a-bpi-r3-sd.dts | 12 ++++++------
 arch/arm/dts/mt7986a-rfb.dts       |  4 ++--
 arch/arm/dts/mt7986a-sd-rfb.dts    |  4 ++--
 arch/arm/dts/mt7986b-rfb.dts       |  4 ++--
 arch/arm/dts/mt7986b-sd-rfb.dts    |  4 ++--
 6 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index 64ce45a6530..b2c57098a5e 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -122,7 +122,7 @@
 		#clock-cells = <1>;
 	};
 
-	pinctrl: pinctrl@1001f000 {
+	pio: pinctrl@1001f000 {
 		compatible = "mediatek,mt7986-pinctrl";
 		reg = <0x1001f000 0x1000>,
 		      <0x11c30000 0x1000>,
@@ -135,10 +135,8 @@
 		reg-names = "gpio", "iocfg_rt", "iocfg_rb",
 			    "iocfg_lt", "iocfg_lb", "iocfg_tr",
 			    "iocfg_tl", "eint";
-		gpio: gpio-controller {
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	pwm: pwm@10048000 {
diff --git a/arch/arm/dts/mt7986a-bpi-r3-sd.dts b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
index c156a813634..e01ae4c3dc7 100644
--- a/arch/arm/dts/mt7986a-bpi-r3-sd.dts
+++ b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
@@ -38,12 +38,12 @@
 
 		factory {
 			label = "reset";
-			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
+			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
 		};
 
 		wps {
 			label = "wps";
-			gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -52,12 +52,12 @@
 
 		led_status_green: green {
 			label = "green:status";
-			gpios = <&gpio 69 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
 		};
 
 		led_status_blue: blue {
 			label = "blue:status";
-			gpios = <&gpio 86 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio 86 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -78,7 +78,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -86,7 +86,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spic_pins: spi1-pins-func-1 {
 		mux {
 			function = "spi";
diff --git a/arch/arm/dts/mt7986a-rfb.dts b/arch/arm/dts/mt7986a-rfb.dts
index 67d14a99dae..d4bbb23204a 100644
--- a/arch/arm/dts/mt7986a-rfb.dts
+++ b/arch/arm/dts/mt7986a-rfb.dts
@@ -57,7 +57,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -65,7 +65,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spi_flash_pins: spi0-pins-func-1 {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7986a-sd-rfb.dts b/arch/arm/dts/mt7986a-sd-rfb.dts
index 4f8fa70ec99..11823e05bda 100644
--- a/arch/arm/dts/mt7986a-sd-rfb.dts
+++ b/arch/arm/dts/mt7986a-sd-rfb.dts
@@ -49,7 +49,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -57,7 +57,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spi_flash_pins: spi0-pins-func-1 {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7986b-rfb.dts b/arch/arm/dts/mt7986b-rfb.dts
index f98b04ab140..0a731fe87fd 100644
--- a/arch/arm/dts/mt7986b-rfb.dts
+++ b/arch/arm/dts/mt7986b-rfb.dts
@@ -48,7 +48,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -56,7 +56,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spi_flash_pins: spi0-pins-func-1 {
 		mux {
 			function = "flash";
diff --git a/arch/arm/dts/mt7986b-sd-rfb.dts b/arch/arm/dts/mt7986b-sd-rfb.dts
index ec80a2fb710..e5fb4d73e70 100644
--- a/arch/arm/dts/mt7986b-sd-rfb.dts
+++ b/arch/arm/dts/mt7986b-sd-rfb.dts
@@ -49,7 +49,7 @@
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
 	mediatek,switch = "mt7531";
-	reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
 		speed = <2500>;
@@ -57,7 +57,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	spi_flash_pins: spi0-pins-func-1 {
 		mux {
 			function = "flash";
-- 
2.47.1

