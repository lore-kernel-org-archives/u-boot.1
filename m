Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B90C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1497388C73;
	Sat,  3 Aug 2024 13:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JdXBg7uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099358827D; Sat,  3 Aug 2024 13:10:59 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0765088CB8
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36bcc168cdaso540280f8f.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683454; x=1723288254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HUtaR3mXcEsU5lLgzrKJVQid0SNbPSoeFdjYkI6mP7Q=;
 b=JdXBg7uhxPGHOrPcZi7lBoiJcnRO+3b9tJJ0GCc7omd2zKGTEtrQ2kDnuG70cZ/TRc
 to225qrsKHAFCkfNh4sdZS1OoNDaTB9J6OI/O2k1brriRN3GJWUW6Us0pcv+jChHxdig
 KTtB+/4ZGg5dlGO6PP694tdgzIUqhUkQEqboVQ1SzQi3bHnEzfN4H2dZv9WevqzChmGr
 HFx9m7iVUoV5lMZQpi/Nl+S3GPHReOWoOVNQfUFDBkYUGn1VJZl89nuXwa6DnEe4jxKT
 zmm78q4E8tEAFZstJl3nw3SFZ0gC9yEdCvKpJTn+l1zZuXiWDK1V0i981FrVA6Kef4eE
 r8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683454; x=1723288254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUtaR3mXcEsU5lLgzrKJVQid0SNbPSoeFdjYkI6mP7Q=;
 b=XC5lSBjW+6eEH/Pkh3GlUzoxj5Yx5wBhWTR4ABnZEXFYzkWjy4xCHn56HMpMpFT7m0
 n4WxWOuuDmlxRurg8BM65Cy31SN7boQLLjwMQAnJRQCjRob+N/dCzRHF3OiQAVgZtaiX
 4R/rVQZKLfC8Q9aVmZxlxjH0Pxiq4+L+fR9z+3G1UKb9PN4C5eJ7FJDg7Z68HPmku7nn
 N1FWkWcdCgJbLef1r0RF+8G2KzWOu55bACPVfICe7fzUQJAHTkIkTkyYX2mzHcHoXQcJ
 GMRedzzwf4erBC8fLD5zEjLHhP8TiEtF4iRZejOQFyUXVS5LyF/wC1Y4oLfQp9KfEY9E
 ajLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYVuYHL6xNUW6HsCFkUx3D1+nBECXx1Wf/lb+MIRAQdzwEBHNZLNIfaWgXTwUwpqqeEHtEPuUM21kKTCt2M1Ao3mPW8A==
X-Gm-Message-State: AOJu0YwNMlpJVCrfWEwwaP0Vl10QrXEFDnkJz5++oHi4yo90HSJnB8VJ
 0lmAz2jD0WKsxI8xbTYT58POk4fwI6y9YVhT05Jfi1wbu+sAgXxp
X-Google-Smtp-Source: AGHT+IFE5YKW/eXXVil3hqZAxKvZmS1evUIfH+oz7s8IchW+NKO62cmPBQ2bULsqQdBkpnQJL5PRfg==
X-Received: by 2002:adf:fa0d:0:b0:366:f50a:2061 with SMTP id
 ffacd0b85a97d-36bbc1a52abmr4057926f8f.50.1722683454140; 
 Sat, 03 Aug 2024 04:10:54 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 15/15] clk: mediatek: mt7986: rename CK to CLK
Date: Sat,  3 Aug 2024 10:40:48 +0200
Message-ID: <20240803084050.449-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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

Rename each entry from CK to CLK to match the include in upstream kernel
linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi               |  88 +++---
 drivers/clk/mediatek/clk-mt7986.c      | 404 ++++++++++++-------------
 include/dt-bindings/clock/mt7986-clk.h | 284 ++++++++---------
 3 files changed, 388 insertions(+), 388 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index a44f5386390..f871f2394c5 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -78,7 +78,7 @@
 		compatible = "mediatek,mt7986-timer";
 		reg = <0x10008000 0x1000>;
 		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&topckgen CK_TOP_F26M_SEL>;
+		clocks = <&topckgen CLK_TOP_F26M_SEL>;
 		clock-names = "gpt-clk";
 		bootph-all;
 	};
@@ -147,18 +147,18 @@
 		#clock-cells = <1>;
 		#pwm-cells = <2>;
 		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&topckgen CK_TOP_PWM_SEL>,
-			 <&infracfg CK_INFRA_PWM_BSEL>,
-			 <&infracfg CK_INFRA_PWM1_CK>,
-			 <&infracfg CK_INFRA_PWM2_CK>;
-		assigned-clocks = <&topckgen CK_TOP_PWM_SEL>,
-				  <&infracfg CK_INFRA_PWM_BSEL>,
-				  <&infracfg CK_INFRA_PWM1_SEL>,
-				  <&infracfg CK_INFRA_PWM2_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D4>,
-					 <&topckgen CK_TOP_PWM_SEL>,
-					 <&topckgen CK_TOP_PWM_SEL>,
-					 <&topckgen CK_TOP_PWM_SEL>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&infracfg CLK_INFRA_PWM_BSEL>,
+			 <&infracfg CLK_INFRA_PWM1_CK>,
+			 <&infracfg CLK_INFRA_PWM2_CK>;
+		assigned-clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				  <&infracfg CLK_INFRA_PWM_BSEL>,
+				  <&infracfg CLK_INFRA_PWM1_SEL>,
+				  <&infracfg CLK_INFRA_PWM2_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_MPLL_D4>,
+					 <&topckgen CLK_TOP_PWM_SEL>,
+					 <&topckgen CLK_TOP_PWM_SEL>,
+					 <&topckgen CLK_TOP_PWM_SEL>;
 		clock-names = "top", "main", "pwm1", "pwm2";
 		status = "disabled";
 		bootph-all;
@@ -168,11 +168,11 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11002000 0x400>;
 		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_UART0_CK>;
-		assigned-clocks = <&topckgen CK_TOP_UART_SEL>,
-				  <&infracfg CK_INFRA_UART0_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_XTAL>,
-					 <&topckgen CK_TOP_UART_SEL>;
+		clocks = <&infracfg CLK_INFRA_UART0_CK>;
+		assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
+				  <&infracfg CLK_INFRA_UART0_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_XTAL>,
+					 <&topckgen CLK_TOP_UART_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 		bootph-all;
@@ -182,9 +182,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11003000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_UART1_CK>;
-		assigned-clocks = <&infracfg CK_INFRA_UART1_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
+		clocks = <&infracfg CLK_INFRA_UART1_CK>;
+		assigned-clocks = <&infracfg CLK_INFRA_UART1_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -193,9 +193,9 @@
 		compatible = "mediatek,hsuart";
 		reg = <0x11004000 0x400>;
 		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&infracfg CK_INFRA_UART2_CK>;
-		assigned-clocks = <&infracfg CK_INFRA_UART2_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_F26M_SEL>;
+		clocks = <&infracfg CLK_INFRA_UART2_CK>;
+		assigned-clocks = <&infracfg CLK_INFRA_UART2_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
 		mediatek,force-highspeed;
 		status = "disabled";
 	};
@@ -205,14 +205,14 @@
 		reg = <0x11005000 0x1000>,
 		      <0x11006000 0x1000>;
 		reg-names = "nfi", "ecc";
-		clocks = <&infracfg CK_INFRA_SPINFI1_CK>,
-			 <&infracfg CK_INFRA_NFI1_CK>,
-			 <&infracfg CK_INFRA_NFI_HCK_CK>;
+		clocks = <&infracfg CLK_INFRA_SPINFI1_CK>,
+			 <&infracfg CLK_INFRA_NFI1_CK>,
+			 <&infracfg CLK_INFRA_NFI_HCK_CK>;
 		clock-names = "pad_clk", "nfi_clk", "nfi_hclk";
-		assigned-clocks = <&topckgen CK_TOP_SPINFI_SEL>,
-				  <&topckgen CK_TOP_NFI1X_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D8>,
-					 <&topckgen CK_TOP_MPLL_D8>;
+		assigned-clocks = <&topckgen CLK_TOP_SPINFI_SEL>,
+				  <&topckgen CLK_TOP_NFI1X_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_MPLL_D8>,
+					 <&topckgen CLK_TOP_MPLL_D8>;
 		status = "disabled";
 	};
 
@@ -251,12 +251,12 @@
 	spi0: spi@1100a000 {
 		compatible = "mediatek,ipm-spi";
 		reg = <0x1100a000 0x100>;
-		clocks = <&infracfg CK_INFRA_SPI0_CK>,
-			 <&topckgen CK_TOP_SPI_SEL>;
-		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
-				  <&infracfg CK_INFRA_SPI0_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D2>,
-					 <&topckgen CK_TOP_SPI_SEL>;
+		clocks = <&infracfg CLK_INFRA_SPI0_CK>,
+			 <&topckgen CLK_TOP_SPI_SEL>;
+		assigned-clocks = <&topckgen CLK_TOP_SPI_SEL>,
+				  <&infracfg CLK_INFRA_SPI0_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_MPLL_D2>,
+					 <&topckgen CLK_TOP_SPI_SEL>;
 		clock-names = "sel-clk", "spi-clk";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -274,13 +274,13 @@
 		reg = <0x11230000 0x1000>,
 		      <0x11C20000 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
-			<&topckgen CK_TOP_EMMC_250M_SEL>,
-			<&infracfg CK_INFRA_MSDC_CK>;
-		assigned-clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
-				  <&topckgen CK_TOP_EMMC_250M_SEL>;
-		assigned-clock-parents = <&fixed_plls CK_APMIXED_MPLL>,
-					 <&topckgen CK_TOP_NET1PLL_D5_D2>;
+		clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
+			<&topckgen CLK_TOP_EMMC_250M_SEL>,
+			<&infracfg CLK_INFRA_MSDC_CK>;
+		assigned-clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
+				  <&topckgen CLK_TOP_EMMC_250M_SEL>;
+		assigned-clock-parents = <&fixed_plls CLK_APMIXED_MPLL>,
+					 <&topckgen CLK_TOP_NET1PLL_D5_D2>;
 		clock-names = "source", "hclk", "source_cg";
 		status = "disabled";
 	};
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index b163ffc9f1a..c5cc77243d0 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -34,194 +34,194 @@
 
 /* FIXED PLLS */
 static const struct mtk_fixed_clk fixed_pll_clks[] = {
-	FIXED_CLK(CK_APMIXED_ARMPLL, CLK_XTAL, 2000000000),
-	FIXED_CLK(CK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
-	FIXED_CLK(CK_APMIXED_MMPLL, CLK_XTAL, 1440000000),
-	FIXED_CLK(CK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
-	FIXED_CLK(CK_APMIXED_WEDMCUPLL, CLK_XTAL, 760000000),
-	FIXED_CLK(CK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
-	FIXED_CLK(CK_APMIXED_MPLL, CLK_XTAL, 416000000),
-	FIXED_CLK(CK_APMIXED_APLL2, CLK_XTAL, 196608000),
+	FIXED_CLK(CLK_APMIXED_ARMPLL, CLK_XTAL, 2000000000),
+	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
+	FIXED_CLK(CLK_APMIXED_MMPLL, CLK_XTAL, 1440000000),
+	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
+	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 760000000),
+	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
+	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
+	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
 };
 
 /* TOPCKGEN FIXED CLK */
 static const struct mtk_fixed_clk top_fixed_clks[] = {
-	FIXED_CLK(CK_TOP_XTAL, CLK_XTAL, 40000000),
+	FIXED_CLK(CLK_TOP_XTAL, CLK_XTAL, 40000000),
 };
 
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor top_fixed_divs[] = {
 	/* TOP Factors */
-	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL,
+	TOP_FACTOR(CLK_TOP_XTAL_D2, "xtal_d2", CLK_TOP_XTAL,
 		   1, 2),
-	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CLK_TOP_RTC_32K, "rtc_32k", CLK_TOP_XTAL, 1,
 		   1250),
-	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CLK_TOP_RTC_32P7K, "rtc_32p7k", CLK_TOP_XTAL, 1,
 		   1220),
 	/* Not defined upstream and not used */
-	/* TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1), */
+	/* TOP_FACTOR(CLK_TOP_A_TUNER, "a_tuner", CLK_TOP_A_TUNER_SEL, 2, 1), */
 	/* MPLL */
-	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
+	PLL_FACTOR(CLK_TOP_MPLL_D2, "mpll_d2", CLK_APMIXED_MPLL, 1, 2),
+	PLL_FACTOR(CLK_TOP_MPLL_D4, "mpll_d4", CLK_APMIXED_MPLL, 1, 4),
+	PLL_FACTOR(CLK_TOP_MPLL_D8, "mpll_d8", CLK_APMIXED_MPLL, 1, 8),
+	PLL_FACTOR(CLK_TOP_MPLL_D8_D2, "mpll_d8_d2", CLK_APMIXED_MPLL, 1, 16),
+	PLL_FACTOR(CLK_TOP_MPLL_D3_D2, "mpll_d3_d2", CLK_APMIXED_MPLL, 1, 2),
 	/* MMPLL */
-	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_MMPLL_D8_D2, "mmpll_d8_d2", CK_APMIXED_MMPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_MMPLL_D3_D8, "mmpll_d3_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_MMPLL_U2PHYD, "mmpll_u2phy", CK_APMIXED_MMPLL, 1, 30),
+	PLL_FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", CLK_APMIXED_MMPLL, 1, 2),
+	PLL_FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", CLK_APMIXED_MMPLL, 1, 4),
+	PLL_FACTOR(CLK_TOP_MMPLL_D8, "mmpll_d8", CLK_APMIXED_MMPLL, 1, 8),
+	PLL_FACTOR(CLK_TOP_MMPLL_D8_D2, "mmpll_d8_d2", CLK_APMIXED_MMPLL, 1, 16),
+	PLL_FACTOR(CLK_TOP_MMPLL_D3_D8, "mmpll_d3_d8", CLK_APMIXED_MMPLL, 1, 8),
+	PLL_FACTOR(CLK_TOP_MMPLL_U2PHYD, "mmpll_u2phy", CLK_APMIXED_MMPLL, 1, 30),
 	/* APLL2 */
-	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
+	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
 	/* NET1PLL */
-	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
-	PLL_FACTOR(CK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D4, "net1pll_d4", CLK_APMIXED_NET1PLL, 1, 4),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D5, "net1pll_d5", CLK_APMIXED_NET1PLL, 1, 5),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CLK_APMIXED_NET1PLL, 1, 10),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CLK_APMIXED_NET1PLL, 1, 20),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CLK_APMIXED_NET1PLL, 1, 16),
+	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CLK_APMIXED_NET1PLL, 1, 32),
 	/* NET2PLL */
-	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET2PLL_D4_D2, "net2pll_d4_d2", CK_APMIXED_NET2PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_NET2PLL_D3_D2, "net2pll_d3_d2", CK_APMIXED_NET2PLL, 1, 2),
+	PLL_FACTOR(CLK_TOP_NET2PLL_D4, "net2pll_d4", CLK_APMIXED_NET2PLL, 1, 4),
+	PLL_FACTOR(CLK_TOP_NET2PLL_D4_D2, "net2pll_d4_d2", CLK_APMIXED_NET2PLL, 1, 8),
+	PLL_FACTOR(CLK_TOP_NET2PLL_D3_D2, "net2pll_d3_d2", CLK_APMIXED_NET2PLL, 1, 2),
 	/* WEDMCUPLL */
-	PLL_FACTOR(CK_TOP_WEDMCUPLL_D5_D2, "wedmcupll_d5_d2", CK_APMIXED_WEDMCUPLL, 1,
+	PLL_FACTOR(CLK_TOP_WEDMCUPLL_D5_D2, "wedmcupll_d5_d2", CLK_APMIXED_WEDMCUPLL, 1,
 		   10),
 };
 
 /* TOPCKGEN MUX PARENTS */
 static const struct mtk_parent nfi1x_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D8),
-	TOP_PARENT(CK_TOP_NET1PLL_D8_D2), TOP_PARENT(CK_TOP_NET2PLL_D3_D2),
-	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_MMPLL_D8_D2),
-	TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2), TOP_PARENT(CK_TOP_MPLL_D8),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_D8),
+	TOP_PARENT(CLK_TOP_NET1PLL_D8_D2), TOP_PARENT(CLK_TOP_NET2PLL_D3_D2),
+	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_MMPLL_D8_D2),
+	TOP_PARENT(CLK_TOP_WEDMCUPLL_D5_D2), TOP_PARENT(CLK_TOP_MPLL_D8),
 };
 
 static const struct mtk_parent spinfi_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_XTAL),
-	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
-	TOP_PARENT(CK_TOP_MMPLL_D8_D2), TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2),
-	TOP_PARENT(CK_TOP_MMPLL_D3_D8), TOP_PARENT(CK_TOP_MPLL_D8),
+	TOP_PARENT(CLK_TOP_XTAL_D2), TOP_PARENT(CLK_TOP_XTAL),
+	TOP_PARENT(CLK_TOP_NET1PLL_D5_D4), TOP_PARENT(CLK_TOP_MPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D8_D2), TOP_PARENT(CLK_TOP_WEDMCUPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D3_D8), TOP_PARENT(CLK_TOP_MPLL_D8),
 };
 
 static const struct mtk_parent spi_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
-	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
-	TOP_PARENT(CK_TOP_NET2PLL_D3_D2), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
-	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D8), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CLK_TOP_NET2PLL_D3_D2), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_WEDMCUPLL_D5_D2),
 };
 
 static const struct mtk_parent uart_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8),
-	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D8),
+	TOP_PARENT(CLK_TOP_MPLL_D8_D2),
 };
 
 static const struct mtk_parent pwm_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
-	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CLK_TOP_NET1PLL_D5_D4), TOP_PARENT(CLK_TOP_MPLL_D4),
 };
 
 static const struct mtk_parent i2c_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
-	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
 };
 
 static const struct mtk_parent pextp_tl_ck_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
-	TOP_PARENT(CK_TOP_NET2PLL_D4_D2), TOP_PARENT(CK_TOP_RTC_32K),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CLK_TOP_NET2PLL_D4_D2), TOP_PARENT(CLK_TOP_RTC_32K),
 };
 
 static const struct mtk_parent emmc_250m_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D2),
 };
 
 static const struct mtk_parent emmc_416m_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_MPLL),
+	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_MPLL),
 };
 
 static const struct mtk_parent f_26m_adc_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D8_D2),
 };
 
 static const struct mtk_parent dramc_md32_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D2),
 };
 
 static const struct mtk_parent sysaxi_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
-	TOP_PARENT(CK_TOP_NET2PLL_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CLK_TOP_NET2PLL_D4),
 };
 
 static const struct mtk_parent sysapb_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D3_D2),
-	TOP_PARENT(CK_TOP_NET2PLL_D4_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_NET2PLL_D4_D2),
 };
 
 static const struct mtk_parent arm_db_main_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D3_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D3_D2),
 };
 
 static const struct mtk_parent arm_db_jtsel_parents[] = {
-	VOID_PARENT, TOP_PARENT(CK_TOP_XTAL),
+	VOID_PARENT, TOP_PARENT(CLK_TOP_XTAL),
 };
 
 static const struct mtk_parent netsys_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_D4),
 };
 
 static const struct mtk_parent netsys_500m_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5),
 };
 
 static const struct mtk_parent netsys_mcu_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_WEDMCUPLL),
-	TOP_PARENT(CK_TOP_MMPLL_D2), TOP_PARENT(CK_TOP_NET1PLL_D4),
-	TOP_PARENT(CK_TOP_NET1PLL_D5),
+	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_WEDMCUPLL),
+	TOP_PARENT(CLK_TOP_MMPLL_D2), TOP_PARENT(CLK_TOP_NET1PLL_D4),
+	TOP_PARENT(CLK_TOP_NET1PLL_D5),
 };
 
 static const struct mtk_parent netsys_2x_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_APMIXED_NET2PLL),
-	APMIXED_PARENT(CK_APMIXED_WEDMCUPLL), TOP_PARENT(CK_TOP_MMPLL_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_APMIXED_NET2PLL),
+	APMIXED_PARENT(CLK_APMIXED_WEDMCUPLL), TOP_PARENT(CLK_TOP_MMPLL_D2),
 };
 
 static const struct mtk_parent sgm_325m_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
+	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_SGMPLL),
 };
 
 static const struct mtk_parent sgm_reg_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
 };
 
 static const struct mtk_parent a1sys_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_APLL2_D4),
 };
 
 static const struct mtk_parent conn_mcusys_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_D2),
 };
 
 static const struct mtk_parent eip_b_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
+	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_NET2PLL),
 };
 
 static const struct mtk_parent aud_l_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
-	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_APLL2),
+	TOP_PARENT(CLK_TOP_MPLL_D8_D2),
 };
 
 static const struct mtk_parent a_tuner_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
-	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_MPLL_D8_D2),
 };
 
 static const struct mtk_parent u2u3_sys_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
 };
 
 static const struct mtk_parent da_u2_refsel_parents[] = {
-	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_U2PHYD),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_U2PHYD),
 };
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
@@ -239,126 +239,126 @@ static const struct mtk_parent da_u2_refsel_parents[] = {
 /* TOPCKGEN MUX_GATE */
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	TOP_MUX(CK_TOP_NFI1X_SEL, "nfi1x_sel", nfi1x_parents, 0x000, 0x004,
+	TOP_MUX(CLK_TOP_NFI1X_SEL, "nfi1x_sel", nfi1x_parents, 0x000, 0x004,
 		0x008, 0, 3, 7, 0x1C0, 0),
-	TOP_MUX(CK_TOP_SPINFI_SEL, "spinfi_sel", spinfi_parents, 0x000, 0x004,
+	TOP_MUX(CLK_TOP_SPINFI_SEL, "spinfi_sel", spinfi_parents, 0x000, 0x004,
 		0x008, 8, 3, 15, 0x1C0, 1),
-	TOP_MUX(CK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x000, 0x004, 0x008, 16,
+	TOP_MUX(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x000, 0x004, 0x008, 16,
 		3, 23, 0x1C0, 2),
-	TOP_MUX(CK_TOP_SPIM_MST_SEL, "spim_mst_sel", spi_parents, 0x000, 0x004,
+	TOP_MUX(CLK_TOP_SPIM_MST_SEL, "spim_mst_sel", spi_parents, 0x000, 0x004,
 		0x008, 24, 3, 31, 0x1C0, 3),
 	/* CLK_CFG_1 */
-	TOP_MUX(CK_TOP_UART_SEL, "uart_sel", uart_parents, 0x010, 0x014, 0x018,
+	TOP_MUX(CLK_TOP_UART_SEL, "uart_sel", uart_parents, 0x010, 0x014, 0x018,
 		0, 2, 7, 0x1C0, 4),
-	TOP_MUX(CK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x010, 0x014, 0x018, 8,
+	TOP_MUX(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x010, 0x014, 0x018, 8,
 		2, 15, 0x1C0, 5),
-	TOP_MUX(CK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x010, 0x014, 0x018, 16,
+	TOP_MUX(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x010, 0x014, 0x018, 16,
 		2, 23, 0x1C0, 6),
-	TOP_MUX(CK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel", pextp_tl_ck_parents,
+	TOP_MUX(CLK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel", pextp_tl_ck_parents,
 		0x010, 0x014, 0x018, 24, 2, 31, 0x1C0, 7),
 	/* CLK_CFG_2 */
-	TOP_MUX(CK_TOP_EMMC_250M_SEL, "emmc_250m_sel", emmc_250m_parents, 0x020,
+	TOP_MUX(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel", emmc_250m_parents, 0x020,
 		0x024, 0x028, 0, 1, 7, 0x1C0, 8),
-	TOP_MUX(CK_TOP_EMMC_416M_SEL, "emmc_416m_sel", emmc_416m_parents, 0x020,
+	TOP_MUX(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel", emmc_416m_parents, 0x020,
 		0x024, 0x028, 8, 1, 15, 0x1C0, 9),
-	TOP_MUX(CK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel", f_26m_adc_parents, 0x020,
+	TOP_MUX(CLK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel", f_26m_adc_parents, 0x020,
 		0x024, 0x028, 16, 1, 23, 0x1C0, 10),
-	TOP_MUX(CK_TOP_DRAMC_SEL, "dramc_sel", f_26m_adc_parents, 0x020, 0x024,
+	TOP_MUX(CLK_TOP_DRAMC_SEL, "dramc_sel", f_26m_adc_parents, 0x020, 0x024,
 		0x028, 24, 1, 31, 0x1C0, 11),
 	/* CLK_CFG_3 */
-	TOP_MUX(CK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel", dramc_md32_parents,
+	TOP_MUX(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel", dramc_md32_parents,
 		0x030, 0x034, 0x038, 0, 1, 7, 0x1C0, 12),
-	TOP_MUX(CK_TOP_SYSAXI_SEL, "sysaxi_sel", sysaxi_parents, 0x030, 0x034,
+	TOP_MUX(CLK_TOP_SYSAXI_SEL, "sysaxi_sel", sysaxi_parents, 0x030, 0x034,
 		0x038, 8, 2, 15, 0x1C0, 13),
-	TOP_MUX(CK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents, 0x030, 0x034,
+	TOP_MUX(CLK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents, 0x030, 0x034,
 		0x038, 16, 2, 23, 0x1C0, 14),
-	TOP_MUX(CK_TOP_ARM_DB_MAIN_SEL, "arm_db_main_sel", arm_db_main_parents,
+	TOP_MUX(CLK_TOP_ARM_DB_MAIN_SEL, "arm_db_main_sel", arm_db_main_parents,
 		0x030, 0x034, 0x038, 24, 1, 31, 0x1C0, 15),
 	/* CLK_CFG_4 */
-	TOP_MUX(CK_TOP_ARM_DB_JTSEL, "arm_db_jtsel", arm_db_jtsel_parents,
+	TOP_MUX(CLK_TOP_ARM_DB_JTSEL, "arm_db_jtsel", arm_db_jtsel_parents,
 		0x040, 0x044, 0x048, 0, 1, 7, 0x1C0, 16),
-	TOP_MUX(CK_TOP_NETSYS_SEL, "netsys_sel", netsys_parents, 0x040, 0x044,
+	TOP_MUX(CLK_TOP_NETSYS_SEL, "netsys_sel", netsys_parents, 0x040, 0x044,
 		0x048, 8, 1, 15, 0x1C0, 17),
-	TOP_MUX(CK_TOP_NETSYS_500M_SEL, "netsys_500m_sel", netsys_500m_parents,
+	TOP_MUX(CLK_TOP_NETSYS_500M_SEL, "netsys_500m_sel", netsys_500m_parents,
 		0x040, 0x044, 0x048, 16, 1, 23, 0x1C0, 18),
-	TOP_MUX(CK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel", netsys_mcu_parents,
+	TOP_MUX(CLK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel", netsys_mcu_parents,
 		0x040, 0x044, 0x048, 24, 3, 31, 0x1C0, 19),
 	/* CLK_CFG_5 */
-	TOP_MUX(CK_TOP_NETSYS_2X_SEL, "netsys_2x_sel", netsys_2x_parents, 0x050,
+	TOP_MUX(CLK_TOP_NETSYS_2X_SEL, "netsys_2x_sel", netsys_2x_parents, 0x050,
 		0x054, 0x058, 0, 2, 7, 0x1C0, 20),
-	TOP_MUX(CK_TOP_SGM_325M_SEL, "sgm_325m_sel", sgm_325m_parents, 0x050,
+	TOP_MUX(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel", sgm_325m_parents, 0x050,
 		0x054, 0x058, 8, 1, 15, 0x1C0, 21),
-	TOP_MUX(CK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents, 0x050,
+	TOP_MUX(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents, 0x050,
 		0x054, 0x058, 16, 1, 23, 0x1C0, 22),
-	TOP_MUX(CK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents, 0x050, 0x054,
+	TOP_MUX(CLK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents, 0x050, 0x054,
 		0x058, 24, 1, 31, 0x1C0, 23),
 	/* CLK_CFG_6 */
-	TOP_MUX(CK_TOP_CONN_MCUSYS_SEL, "conn_mcusys_sel", conn_mcusys_parents,
+	TOP_MUX(CLK_TOP_CONN_MCUSYS_SEL, "conn_mcusys_sel", conn_mcusys_parents,
 		0x060, 0x064, 0x068, 0, 1, 7, 0x1C0, 24),
-	TOP_MUX(CK_TOP_EIP_B_SEL, "eip_b_sel", eip_b_parents, 0x060, 0x064,
+	TOP_MUX(CLK_TOP_EIP_B_SEL, "eip_b_sel", eip_b_parents, 0x060, 0x064,
 		0x068, 8, 1, 15, 0x1C0, 25),
-	TOP_MUX(CK_TOP_PCIE_PHY_SEL, "pcie_phy_sel", f_26m_adc_parents, 0x060,
+	TOP_MUX(CLK_TOP_PCIE_PHY_SEL, "pcie_phy_sel", f_26m_adc_parents, 0x060,
 		0x064, 0x068, 16, 1, 23, 0x1C0, 26),
-	TOP_MUX(CK_TOP_USB3_PHY_SEL, "usb3_phy_sel", f_26m_adc_parents, 0x060,
+	TOP_MUX(CLK_TOP_USB3_PHY_SEL, "usb3_phy_sel", f_26m_adc_parents, 0x060,
 		0x064, 0x068, 24, 1, 31, 0x1C0, 27),
 	/* CLK_CFG_7 */
-	TOP_MUX(CK_TOP_F26M_SEL, "csw_f26m_sel", f_26m_adc_parents, 0x070,
+	TOP_MUX(CLK_TOP_F26M_SEL, "csw_f26m_sel", f_26m_adc_parents, 0x070,
 		0x074, 0x078, 0, 1, 7, 0x1C0, 28),
-	TOP_MUX(CK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents, 0x070, 0x074,
+	TOP_MUX(CLK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents, 0x070, 0x074,
 		0x078, 8, 2, 15, 0x1C0, 29),
-	TOP_MUX(CK_TOP_A_TUNER_SEL, "a_tuner_sel", a_tuner_parents, 0x070,
+	TOP_MUX(CLK_TOP_A_TUNER_SEL, "a_tuner_sel", a_tuner_parents, 0x070,
 		0x074, 0x078, 16, 2, 23, 0x1C0, 30),
-	TOP_MUX(CK_TOP_U2U3_SEL, "u2u3_sel", f_26m_adc_parents, 0x070, 0x074,
+	TOP_MUX(CLK_TOP_U2U3_SEL, "u2u3_sel", f_26m_adc_parents, 0x070, 0x074,
 		0x078, 24, 1, 31, 0x1C4, 0),
 	/* CLK_CFG_8 */
-	TOP_MUX(CK_TOP_U2U3_SYS_SEL, "u2u3_sys_sel", u2u3_sys_parents, 0x080,
+	TOP_MUX(CLK_TOP_U2U3_SYS_SEL, "u2u3_sys_sel", u2u3_sys_parents, 0x080,
 		0x084, 0x088, 0, 1, 7, 0x1C4, 1),
-	TOP_MUX(CK_TOP_U2U3_XHCI_SEL, "u2u3_xhci_sel", u2u3_sys_parents, 0x080,
+	TOP_MUX(CLK_TOP_U2U3_XHCI_SEL, "u2u3_xhci_sel", u2u3_sys_parents, 0x080,
 		0x084, 0x088, 8, 1, 15, 0x1C4, 2),
-	TOP_MUX(CK_TOP_DA_U2_REFSEL, "da_u2_refsel", da_u2_refsel_parents,
+	TOP_MUX(CLK_TOP_DA_U2_REFSEL, "da_u2_refsel", da_u2_refsel_parents,
 		0x080, 0x084, 0x088, 16, 1, 23, 0x1C4, 3),
-	TOP_MUX(CK_TOP_DA_U2_CK_1P_SEL, "da_u2_ck_1p_sel", da_u2_refsel_parents,
+	TOP_MUX(CLK_TOP_DA_U2_CK_1P_SEL, "da_u2_ck_1p_sel", da_u2_refsel_parents,
 		0x080, 0x084, 0x088, 24, 1, 31, 0x1C4, 4),
 	/* CLK_CFG_9 */
-	TOP_MUX(CK_TOP_AP2CNN_HOST_SEL, "ap2cnn_host_sel", sgm_reg_parents,
+	TOP_MUX(CLK_TOP_AP2CNN_HOST_SEL, "ap2cnn_host_sel", sgm_reg_parents,
 		0x090, 0x094, 0x098, 0, 1, 7, 0x1C4, 5),
 };
 
 /* INFRA FIXED DIV */
 static const struct mtk_fixed_factor infra_fixed_divs[] = {
-	TOP_FACTOR(CK_INFRA_SYSAXI_D2, "infra_sysaxi_d2", CK_TOP_SYSAXI_SEL, 1, 2),
+	TOP_FACTOR(CLK_INFRA_SYSAXI_D2, "infra_sysaxi_d2", CLK_TOP_SYSAXI_SEL, 1, 2),
 };
 
 /* INFRASYS MUX PARENTS */
 
 
 static const struct mtk_parent infra_uart0_parents[] = {
-	TOP_PARENT(CK_TOP_F26M_SEL),
-	TOP_PARENT(CK_TOP_UART_SEL)
+	TOP_PARENT(CLK_TOP_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL)
 };
 
 static const struct mtk_parent infra_spi0_parents[] = {
-	TOP_PARENT(CK_TOP_I2C_SEL),
-	TOP_PARENT(CK_TOP_SPI_SEL)
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL)
 };
 
 static const struct mtk_parent infra_spi1_parents[] = {
-	TOP_PARENT(CK_TOP_I2C_SEL),
-	TOP_PARENT(CK_TOP_SPINFI_SEL)
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPINFI_SEL)
 };
 
 static const struct mtk_parent infra_pwm_bsel_parents[] = {
-	TOP_PARENT(CK_TOP_RTC_32P7K),
-	TOP_PARENT(CK_TOP_F26M_SEL),
-	INFRA_PARENT(CK_INFRA_SYSAXI_D2),
-	TOP_PARENT(CK_TOP_PWM_SEL)
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_F26M_SEL),
+	INFRA_PARENT(CLK_INFRA_SYSAXI_D2),
+	TOP_PARENT(CLK_TOP_PWM_SEL)
 };
 
 static const struct mtk_parent infra_pcie_parents[] = {
-	TOP_PARENT(CK_TOP_RTC_32P7K),
-	TOP_PARENT(CK_TOP_F26M_SEL),
-	TOP_PARENT(CK_TOP_XTAL),
-	TOP_PARENT(CK_TOP_PEXTP_TL_SEL)
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_F26M_SEL),
+	TOP_PARENT(CLK_TOP_XTAL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_SEL)
 };
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
@@ -374,24 +374,24 @@ static const struct mtk_parent infra_pcie_parents[] = {
 
 static const struct mtk_composite infra_muxes[] = {
 	/* MODULE_CLK_SEL_0 */
-	INFRA_MUX(CK_INFRA_UART0_SEL, "infra_uart0_sel", infra_uart0_parents,
+	INFRA_MUX(CLK_INFRA_UART0_SEL, "infra_uart0_sel", infra_uart0_parents,
 		  0x10, 0, 1),
-	INFRA_MUX(CK_INFRA_UART1_SEL, "infra_uart1_sel", infra_uart0_parents,
+	INFRA_MUX(CLK_INFRA_UART1_SEL, "infra_uart1_sel", infra_uart0_parents,
 		  0x10, 1, 1),
-	INFRA_MUX(CK_INFRA_UART2_SEL, "infra_uart2_sel", infra_uart0_parents,
+	INFRA_MUX(CLK_INFRA_UART2_SEL, "infra_uart2_sel", infra_uart0_parents,
 		  0x10, 2, 1),
-	INFRA_MUX(CK_INFRA_SPI0_SEL, "infra_spi0_sel", infra_spi0_parents, 0x10,
+	INFRA_MUX(CLK_INFRA_SPI0_SEL, "infra_spi0_sel", infra_spi0_parents, 0x10,
 		  4, 1),
-	INFRA_MUX(CK_INFRA_SPI1_SEL, "infra_spi1_sel", infra_spi1_parents, 0x10,
+	INFRA_MUX(CLK_INFRA_SPI1_SEL, "infra_spi1_sel", infra_spi1_parents, 0x10,
 		  5, 1),
-	INFRA_MUX(CK_INFRA_PWM1_SEL, "infra_pwm1_sel", infra_pwm_bsel_parents,
+	INFRA_MUX(CLK_INFRA_PWM1_SEL, "infra_pwm1_sel", infra_pwm_bsel_parents,
 		  0x10, 9, 2),
-	INFRA_MUX(CK_INFRA_PWM2_SEL, "infra_pwm2_sel", infra_pwm_bsel_parents,
+	INFRA_MUX(CLK_INFRA_PWM2_SEL, "infra_pwm2_sel", infra_pwm_bsel_parents,
 		  0x10, 11, 2),
-	INFRA_MUX(CK_INFRA_PWM_BSEL, "infra_pwm_bsel", infra_pwm_bsel_parents,
+	INFRA_MUX(CLK_INFRA_PWM_BSEL, "infra_pwm_bsel", infra_pwm_bsel_parents,
 		  0x10, 13, 2),
 	/* MODULE_CLK_SEL_1 */
-	INFRA_MUX(CK_INFRA_PCIE_SEL, "infra_pcie_sel", infra_pcie_parents, 0x20,
+	INFRA_MUX(CLK_INFRA_PCIE_SEL, "infra_pcie_sel", infra_pcie_parents, 0x20,
 		  0, 2),
 };
 
@@ -450,68 +450,68 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
 
 static const struct mtk_gate infracfg_gates[] = {
 	/* INFRA0 */
-	GATE_INFRA0_INFRA(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_SYSAXI_D2, 0),
-	GATE_INFRA0_INFRA(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_SYSAXI_D2, 1),
-	GATE_INFRA0_INFRA(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BSEL, 2),
-	GATE_INFRA0_INFRA(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM1_SEL, 3),
-	GATE_INFRA0_INFRA(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM2_SEL, 4),
-	GATE_INFRA0_TOP(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_TOP_SYSAXI_SEL, 6),
-	GATE_INFRA0_TOP(CK_INFRA_EIP97_CK, "infra_eip97", CK_TOP_EIP_B_SEL, 7),
-	GATE_INFRA0_TOP(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_TOP_SYSAXI_SEL, 8),
-	GATE_INFRA0_TOP(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_TOP_F26M_SEL, 9),
-	GATE_INFRA0_TOP(CK_INFRA_AUD_L_CK, "infra_aud_l", CK_TOP_AUD_L_SEL, 10),
-	GATE_INFRA0_TOP(CK_INFRA_AUD_AUD_CK, "infra_aud_aud", CK_TOP_A1SYS_SEL,
+	GATE_INFRA0_INFRA(CLK_INFRA_GPT_STA, "infra_gpt_sta", CLK_INFRA_SYSAXI_D2, 0),
+	GATE_INFRA0_INFRA(CLK_INFRA_PWM_HCK, "infra_pwm_hck", CLK_INFRA_SYSAXI_D2, 1),
+	GATE_INFRA0_INFRA(CLK_INFRA_PWM_STA, "infra_pwm_sta", CLK_INFRA_PWM_BSEL, 2),
+	GATE_INFRA0_INFRA(CLK_INFRA_PWM1_CK, "infra_pwm1", CLK_INFRA_PWM1_SEL, 3),
+	GATE_INFRA0_INFRA(CLK_INFRA_PWM2_CK, "infra_pwm2", CLK_INFRA_PWM2_SEL, 4),
+	GATE_INFRA0_TOP(CLK_INFRA_CQ_DMA_CK, "infra_cq_dma", CLK_TOP_SYSAXI_SEL, 6),
+	GATE_INFRA0_TOP(CLK_INFRA_EIP97_CK, "infra_eip97", CLK_TOP_EIP_B_SEL, 7),
+	GATE_INFRA0_TOP(CLK_INFRA_AUD_BUS_CK, "infra_aud_bus", CLK_TOP_SYSAXI_SEL, 8),
+	GATE_INFRA0_TOP(CLK_INFRA_AUD_26M_CK, "infra_aud_26m", CLK_TOP_F26M_SEL, 9),
+	GATE_INFRA0_TOP(CLK_INFRA_AUD_L_CK, "infra_aud_l", CLK_TOP_AUD_L_SEL, 10),
+	GATE_INFRA0_TOP(CLK_INFRA_AUD_AUD_CK, "infra_aud_aud", CLK_TOP_A1SYS_SEL,
 			11),
-	GATE_INFRA0_TOP(CK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CK_TOP_A_TUNER_SEL,
+	GATE_INFRA0_TOP(CLK_INFRA_AUD_EG2_CK, "infra_aud_eg2", CLK_TOP_A_TUNER_SEL,
 			13),
-	GATE_INFRA0_TOP(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_TOP_F26M_SEL,
+	GATE_INFRA0_TOP(CLK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CLK_TOP_F26M_SEL,
 			14),
-	GATE_INFRA0_INFRA(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_SYSAXI_D2, 15),
-	GATE_INFRA0_INFRA(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_SYSAXI_D2, 16),
-	GATE_INFRA0_INFRA(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_SYSAXI_D2, 24),
-	GATE_INFRA0_TOP(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_TOP_F26M_SEL, 25),
+	GATE_INFRA0_INFRA(CLK_INFRA_DBG_CK, "infra_dbg", CLK_INFRA_SYSAXI_D2, 15),
+	GATE_INFRA0_INFRA(CLK_INFRA_AP_DMA_CK, "infra_ap_dma", CLK_INFRA_SYSAXI_D2, 16),
+	GATE_INFRA0_INFRA(CLK_INFRA_SEJ_CK, "infra_sej", CLK_INFRA_SYSAXI_D2, 24),
+	GATE_INFRA0_TOP(CLK_INFRA_SEJ_13M_CK, "infra_sej_13m", CLK_TOP_F26M_SEL, 25),
 	/* INFRA1 */
-	GATE_INFRA1_TOP(CK_INFRA_THERM_CK, "infra_therm", CK_TOP_F26M_SEL, 0),
-	GATE_INFRA1_TOP(CK_INFRA_I2C0_CK, "infra_i2co", CK_TOP_I2C_SEL, 1),
-	GATE_INFRA1_INFRA(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_UART0_SEL, 2),
-	GATE_INFRA1_INFRA(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_UART1_SEL, 3),
-	GATE_INFRA1_INFRA(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_UART2_SEL, 4),
-	GATE_INFRA1_TOP(CK_INFRA_NFI1_CK, "infra_nfi1", CK_TOP_NFI1X_SEL, 8),
-	GATE_INFRA1_TOP(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_TOP_SPINFI_SEL,
+	GATE_INFRA1_TOP(CLK_INFRA_THERM_CK, "infra_therm", CLK_TOP_F26M_SEL, 0),
+	GATE_INFRA1_TOP(CLK_INFRA_I2C0_CK, "infra_i2co", CLK_TOP_I2C_SEL, 1),
+	GATE_INFRA1_INFRA(CLK_INFRA_UART0_CK, "infra_uart0", CLK_INFRA_UART0_SEL, 2),
+	GATE_INFRA1_INFRA(CLK_INFRA_UART1_CK, "infra_uart1", CLK_INFRA_UART1_SEL, 3),
+	GATE_INFRA1_INFRA(CLK_INFRA_UART2_CK, "infra_uart2", CLK_INFRA_UART2_SEL, 4),
+	GATE_INFRA1_TOP(CLK_INFRA_NFI1_CK, "infra_nfi1", CLK_TOP_NFI1X_SEL, 8),
+	GATE_INFRA1_TOP(CLK_INFRA_SPINFI1_CK, "infra_spinfi1", CLK_TOP_SPINFI_SEL,
 			9),
-	GATE_INFRA1_INFRA(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_SYSAXI_D2, 10),
-	GATE_INFRA1_INFRA(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_SPI0_SEL, 11),
-	GATE_INFRA1_INFRA(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_SPI1_SEL, 12),
-	GATE_INFRA1_INFRA(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_SYSAXI_D2,
+	GATE_INFRA1_INFRA(CLK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CLK_INFRA_SYSAXI_D2, 10),
+	GATE_INFRA1_INFRA(CLK_INFRA_SPI0_CK, "infra_spi0", CLK_INFRA_SPI0_SEL, 11),
+	GATE_INFRA1_INFRA(CLK_INFRA_SPI1_CK, "infra_spi1", CLK_INFRA_SPI1_SEL, 12),
+	GATE_INFRA1_INFRA(CLK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CLK_INFRA_SYSAXI_D2,
 			  13),
-	GATE_INFRA1_INFRA(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_SYSAXI_D2,
+	GATE_INFRA1_INFRA(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CLK_INFRA_SYSAXI_D2,
 			  14),
-	GATE_INFRA1_TOP(CK_INFRA_FRTC_CK, "infra_frtc", CK_TOP_RTC_32K, 15),
-	GATE_INFRA1_TOP(CK_INFRA_MSDC_CK, "infra_msdc", CK_TOP_EMMC_416M_SEL, 16),
-	GATE_INFRA1_TOP(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
-			CK_TOP_EMMC_250M_SEL, 17),
-	GATE_INFRA1_TOP(CK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
-			CK_TOP_SYSAXI_SEL, 18),
-	GATE_INFRA1_INFRA(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_INFRA_SYSAXI_D2,
+	GATE_INFRA1_TOP(CLK_INFRA_FRTC_CK, "infra_frtc", CLK_TOP_RTC_32K, 15),
+	GATE_INFRA1_TOP(CLK_INFRA_MSDC_CK, "infra_msdc", CLK_TOP_EMMC_416M_SEL, 16),
+	GATE_INFRA1_TOP(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
+			CLK_TOP_EMMC_250M_SEL, 17),
+	GATE_INFRA1_TOP(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m",
+			CLK_TOP_SYSAXI_SEL, 18),
+	GATE_INFRA1_INFRA(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CLK_INFRA_SYSAXI_D2,
 			  19),
-	GATE_INFRA1_INFRA(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_ADC_FRC_CK, 20),
-	GATE_INFRA1_TOP(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_TOP_F26M_SEL, 21),
-	GATE_INFRA1_TOP(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_TOP_NFI1X_SEL,
+	GATE_INFRA1_INFRA(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", CLK_INFRA_ADC_FRC_CK, 20),
+	GATE_INFRA1_TOP(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", CLK_TOP_F26M_SEL, 21),
+	GATE_INFRA1_TOP(CLK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CLK_TOP_NFI1X_SEL,
 			23),
 	/* INFRA2 */
-	GATE_INFRA2_TOP(CK_INFRA_IUSB_133_CK, "infra_iusb_133", CK_TOP_SYSAXI_SEL,
+	GATE_INFRA2_TOP(CLK_INFRA_IUSB_133_CK, "infra_iusb_133", CLK_TOP_SYSAXI_SEL,
 			0),
-	GATE_INFRA2_INFRA(CK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CK_INFRA_SYSAXI_D2,
+	GATE_INFRA2_INFRA(CLK_INFRA_IUSB_66M_CK, "infra_iusb_66m", CLK_INFRA_SYSAXI_D2,
 			  1),
-	GATE_INFRA2_TOP(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_TOP_U2U3_SYS_SEL,
+	GATE_INFRA2_TOP(CLK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CLK_TOP_U2U3_SYS_SEL,
 			2),
-	GATE_INFRA2_TOP(CK_INFRA_IUSB_CK, "infra_iusb", CK_TOP_U2U3_SEL, 3),
-	GATE_INFRA2_TOP(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_TOP_PEXTP_TL_SEL, 12),
-	GATE_INFRA2_TOP(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_XTAL, 13),
-	GATE_INFRA2_TOP(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_TOP_F26M_SEL, 14),
-	GATE_INFRA2_TOP(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_TOP_SYSAXI_SEL, 15),
+	GATE_INFRA2_TOP(CLK_INFRA_IUSB_CK, "infra_iusb", CLK_TOP_U2U3_SEL, 3),
+	GATE_INFRA2_TOP(CLK_INFRA_IPCIE_CK, "infra_ipcie", CLK_TOP_PEXTP_TL_SEL, 12),
+	GATE_INFRA2_TOP(CLK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CLK_TOP_XTAL, 13),
+	GATE_INFRA2_TOP(CLK_INFRA_IPCIER_CK, "infra_ipcier", CLK_TOP_F26M_SEL, 14),
+	GATE_INFRA2_TOP(CLK_INFRA_IPCIEB_CK, "infra_ipcieb", CLK_TOP_SYSAXI_SEL, 15),
 	/* upstream linux unordered */
-	GATE_INFRA0_TOP(CK_INFRA_TRNG_CK, "infra_trng", CK_TOP_SYSAXI_SEL, 26),
+	GATE_INFRA0_TOP(CLK_INFRA_TRNG_CK, "infra_trng", CLK_TOP_SYSAXI_SEL, 26),
 };
 
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
@@ -522,8 +522,8 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
-	.fdivs_offs = CK_TOP_XTAL_D2,
-	.muxes_offs = CK_TOP_NFI1X_SEL,
+	.fdivs_offs = CLK_TOP_XTAL_D2,
+	.muxes_offs = CLK_TOP_NFI1X_SEL,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
@@ -531,9 +531,9 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
-	.fdivs_offs = CK_INFRA_SYSAXI_D2,
-	.muxes_offs = CK_INFRA_UART0_SEL,
-	.gates_offs = CK_INFRA_GPT_STA,
+	.fdivs_offs = CLK_INFRA_SYSAXI_D2,
+	.muxes_offs = CLK_INFRA_UART0_SEL,
+	.gates_offs = CLK_INFRA_GPT_STA,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.gates = infracfg_gates,
@@ -619,11 +619,11 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	}
 
 static const struct mtk_gate eth_cgs[] = {
-	GATE_ETH(CK_ETH_FE_EN, "eth_fe_en", CK_TOP_NETSYS_2X_SEL, 7),
-	GATE_ETH(CK_ETH_GP2_EN, "eth_gp2_en", CK_TOP_SGM_325M_SEL, 8),
-	GATE_ETH(CK_ETH_GP1_EN, "eth_gp1_en", CK_TOP_SGM_325M_SEL, 8),
-	GATE_ETH(CK_ETH_WOCPU1_EN, "eth_wocpu1_en", CK_TOP_NETSYS_MCU_SEL, 14),
-	GATE_ETH(CK_ETH_WOCPU0_EN, "eth_wocpu0_en", CK_TOP_NETSYS_MCU_SEL, 15),
+	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", CLK_TOP_NETSYS_2X_SEL, 7),
+	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", CLK_TOP_SGM_325M_SEL, 8),
+	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", CLK_TOP_SGM_325M_SEL, 8),
+	GATE_ETH(CLK_ETH_WOCPU1_EN, "eth_wocpu1_en", CLK_TOP_NETSYS_MCU_SEL, 14),
+	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", CLK_TOP_NETSYS_MCU_SEL, 15),
 };
 
 static int mt7986_ethsys_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 1c28ab34dcf..5da260386fd 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -10,167 +10,167 @@
 
 /* TOPCKGEN */
 
-#define CK_TOP_XTAL			0
-#define CK_TOP_XTAL_D2			1
-#define CK_TOP_RTC_32K			2
-#define CK_TOP_RTC_32P7K		3
-/* #define CK_TOP_A_TUNER		4 */
-#define CK_TOP_MPLL_D2			4
-#define CK_TOP_MPLL_D4			5
-#define CK_TOP_MPLL_D8			6
-#define CK_TOP_MPLL_D8_D2		7
-#define CK_TOP_MPLL_D3_D2		8
-#define CK_TOP_MMPLL_D2			9
-#define CK_TOP_MMPLL_D4			10
-#define CK_TOP_MMPLL_D8			11
-#define CK_TOP_MMPLL_D8_D2		12
-#define CK_TOP_MMPLL_D3_D8		13
-#define CK_TOP_MMPLL_U2PHYD		14
-#define CK_TOP_APLL2_D4			15
-#define CK_TOP_NET1PLL_D4		16
-#define CK_TOP_NET1PLL_D5		17
-#define CK_TOP_NET1PLL_D5_D2		18
-#define CK_TOP_NET1PLL_D5_D4		19
-#define CK_TOP_NET1PLL_D8_D2		20
-#define CK_TOP_NET1PLL_D8_D4		21
-#define CK_TOP_NET2PLL_D4		22
-#define CK_TOP_NET2PLL_D4_D2		23
-#define CK_TOP_NET2PLL_D3_D2		24
-#define CK_TOP_WEDMCUPLL_D5_D2		25
-#define CK_TOP_NFI1X_SEL		26
-#define CK_TOP_SPINFI_SEL		27
-#define CK_TOP_SPI_SEL			28
-#define CK_TOP_SPIM_MST_SEL		29
-#define CK_TOP_UART_SEL			30
-#define CK_TOP_PWM_SEL			31
-#define CK_TOP_I2C_SEL			32
-#define CK_TOP_PEXTP_TL_SEL		33
-#define CK_TOP_EMMC_250M_SEL		34
-#define CK_TOP_EMMC_416M_SEL		35
-#define CK_TOP_F_26M_ADC_SEL		36
-#define CK_TOP_DRAMC_SEL		37
-#define CK_TOP_DRAMC_MD32_SEL		38
-#define CK_TOP_SYSAXI_SEL		39
-#define CK_TOP_SYSAPB_SEL		40
-#define CK_TOP_ARM_DB_MAIN_SEL		41
-#define CK_TOP_ARM_DB_JTSEL		42
-#define CK_TOP_NETSYS_SEL		43
-#define CK_TOP_NETSYS_500M_SEL		44
-#define CK_TOP_NETSYS_MCU_SEL		45
-#define CK_TOP_NETSYS_2X_SEL		46
-#define CK_TOP_SGM_325M_SEL		47
-#define CK_TOP_SGM_REG_SEL		48
-#define CK_TOP_A1SYS_SEL		49
-#define CK_TOP_CONN_MCUSYS_SEL		50
-#define CK_TOP_EIP_B_SEL		51
-#define CK_TOP_PCIE_PHY_SEL		52
-#define CK_TOP_USB3_PHY_SEL		53
-#define CK_TOP_F26M_SEL			54
-#define CK_TOP_AUD_L_SEL		55
-#define CK_TOP_A_TUNER_SEL		56
-#define CK_TOP_U2U3_SEL			57
-#define CK_TOP_U2U3_SYS_SEL		58
-#define CK_TOP_U2U3_XHCI_SEL		59
-#define CK_TOP_DA_U2_REFSEL		60
-#define CK_TOP_DA_U2_CK_1P_SEL		61
-#define CK_TOP_AP2CNN_HOST_SEL		62
+#define CLK_TOP_XTAL			0
+#define CLK_TOP_XTAL_D2			1
+#define CLK_TOP_RTC_32K			2
+#define CLK_TOP_RTC_32P7K		3
+/* #define CLK_TOP_A_TUNER		4 */
+#define CLK_TOP_MPLL_D2			4
+#define CLK_TOP_MPLL_D4			5
+#define CLK_TOP_MPLL_D8			6
+#define CLK_TOP_MPLL_D8_D2		7
+#define CLK_TOP_MPLL_D3_D2		8
+#define CLK_TOP_MMPLL_D2			9
+#define CLK_TOP_MMPLL_D4			10
+#define CLK_TOP_MMPLL_D8			11
+#define CLK_TOP_MMPLL_D8_D2		12
+#define CLK_TOP_MMPLL_D3_D8		13
+#define CLK_TOP_MMPLL_U2PHYD		14
+#define CLK_TOP_APLL2_D4			15
+#define CLK_TOP_NET1PLL_D4		16
+#define CLK_TOP_NET1PLL_D5		17
+#define CLK_TOP_NET1PLL_D5_D2		18
+#define CLK_TOP_NET1PLL_D5_D4		19
+#define CLK_TOP_NET1PLL_D8_D2		20
+#define CLK_TOP_NET1PLL_D8_D4		21
+#define CLK_TOP_NET2PLL_D4		22
+#define CLK_TOP_NET2PLL_D4_D2		23
+#define CLK_TOP_NET2PLL_D3_D2		24
+#define CLK_TOP_WEDMCUPLL_D5_D2		25
+#define CLK_TOP_NFI1X_SEL		26
+#define CLK_TOP_SPINFI_SEL		27
+#define CLK_TOP_SPI_SEL			28
+#define CLK_TOP_SPIM_MST_SEL		29
+#define CLK_TOP_UART_SEL			30
+#define CLK_TOP_PWM_SEL			31
+#define CLK_TOP_I2C_SEL			32
+#define CLK_TOP_PEXTP_TL_SEL		33
+#define CLK_TOP_EMMC_250M_SEL		34
+#define CLK_TOP_EMMC_416M_SEL		35
+#define CLK_TOP_F_26M_ADC_SEL		36
+#define CLK_TOP_DRAMC_SEL		37
+#define CLK_TOP_DRAMC_MD32_SEL		38
+#define CLK_TOP_SYSAXI_SEL		39
+#define CLK_TOP_SYSAPB_SEL		40
+#define CLK_TOP_ARM_DB_MAIN_SEL		41
+#define CLK_TOP_ARM_DB_JTSEL		42
+#define CLK_TOP_NETSYS_SEL		43
+#define CLK_TOP_NETSYS_500M_SEL		44
+#define CLK_TOP_NETSYS_MCU_SEL		45
+#define CLK_TOP_NETSYS_2X_SEL		46
+#define CLK_TOP_SGM_325M_SEL		47
+#define CLK_TOP_SGM_REG_SEL		48
+#define CLK_TOP_A1SYS_SEL		49
+#define CLK_TOP_CONN_MCUSYS_SEL		50
+#define CLK_TOP_EIP_B_SEL		51
+#define CLK_TOP_PCIE_PHY_SEL		52
+#define CLK_TOP_USB3_PHY_SEL		53
+#define CLK_TOP_F26M_SEL			54
+#define CLK_TOP_AUD_L_SEL		55
+#define CLK_TOP_A_TUNER_SEL		56
+#define CLK_TOP_U2U3_SEL			57
+#define CLK_TOP_U2U3_SYS_SEL		58
+#define CLK_TOP_U2U3_XHCI_SEL		59
+#define CLK_TOP_DA_U2_REFSEL		60
+#define CLK_TOP_DA_U2_CK_1P_SEL		61
+#define CLK_TOP_AP2CNN_HOST_SEL		62
 #define CLK_TOP_NR_CLK			63
 
 /* INFRACFG */
 
-#define CK_INFRA_SYSAXI_D2		0
-#define CK_INFRA_UART0_SEL		1
-#define CK_INFRA_UART1_SEL		2
-#define CK_INFRA_UART2_SEL		3
-#define CK_INFRA_SPI0_SEL		4
-#define CK_INFRA_SPI1_SEL		5
-#define CK_INFRA_PWM1_SEL		6
-#define CK_INFRA_PWM2_SEL		7
-#define CK_INFRA_PWM_BSEL		8
-#define CK_INFRA_PCIE_SEL		9
-#define CK_INFRA_GPT_STA		10
-#define CK_INFRA_PWM_HCK		11
-#define CK_INFRA_PWM_STA		12
-#define CK_INFRA_PWM1_CK		13
-#define CK_INFRA_PWM2_CK		14
-#define CK_INFRA_CQ_DMA_CK		15
-#define CK_INFRA_EIP97_CK		16
-#define CK_INFRA_AUD_BUS_CK		17
-#define CK_INFRA_AUD_26M_CK		18
-#define CK_INFRA_AUD_L_CK		19
-#define CK_INFRA_AUD_AUD_CK		20
-#define CK_INFRA_AUD_EG2_CK		21
-#define CK_INFRA_DRAMC_26M_CK		22
-#define CK_INFRA_DBG_CK		23
-#define CK_INFRA_AP_DMA_CK		24
-#define CK_INFRA_SEJ_CK		25
-#define CK_INFRA_SEJ_13M_CK		26
-#define CK_INFRA_THERM_CK		27
-#define CK_INFRA_I2C0_CK		28
-#define CK_INFRA_UART0_CK		29
-#define CK_INFRA_UART1_CK		30
-#define CK_INFRA_UART2_CK		31
-#define CK_INFRA_NFI1_CK		32
-#define CK_INFRA_SPINFI1_CK		33
-#define CK_INFRA_NFI_HCK_CK		34
-#define CK_INFRA_SPI0_CK		35
-#define CK_INFRA_SPI1_CK		36
-#define CK_INFRA_SPI0_HCK_CK		37
-#define CK_INFRA_SPI1_HCK_CK		38
-#define CK_INFRA_FRTC_CK		39
-#define CK_INFRA_MSDC_CK		40
-#define CK_INFRA_MSDC_HCK_CK		41
-#define CK_INFRA_MSDC_133M_CK		42
-#define CK_INFRA_MSDC_66M_CK		43
-#define CK_INFRA_ADC_26M_CK		44
-#define CK_INFRA_ADC_FRC_CK		45
-#define CK_INFRA_FBIST2FPC_CK		46
-#define CK_INFRA_IUSB_133_CK		47
-#define CK_INFRA_IUSB_66M_CK		48
-#define CK_INFRA_IUSB_SYS_CK		49
-#define CK_INFRA_IUSB_CK		50
-#define CK_INFRA_IPCIE_CK		51
-#define CK_INFRA_IPCIE_PIPE_CK		52
-#define CK_INFRA_IPCIER_CK		53
-#define CK_INFRA_IPCIEB_CK		54
-#define CK_INFRA_TRNG_CK		55
-#define CK_INFRA_AO_NR_CLK		46
+#define CLK_INFRA_SYSAXI_D2		0
+#define CLK_INFRA_UART0_SEL		1
+#define CLK_INFRA_UART1_SEL		2
+#define CLK_INFRA_UART2_SEL		3
+#define CLK_INFRA_SPI0_SEL		4
+#define CLK_INFRA_SPI1_SEL		5
+#define CLK_INFRA_PWM1_SEL		6
+#define CLK_INFRA_PWM2_SEL		7
+#define CLK_INFRA_PWM_BSEL		8
+#define CLK_INFRA_PCIE_SEL		9
+#define CLK_INFRA_GPT_STA		10
+#define CLK_INFRA_PWM_HCK		11
+#define CLK_INFRA_PWM_STA		12
+#define CLK_INFRA_PWM1_CK		13
+#define CLK_INFRA_PWM2_CK		14
+#define CLK_INFRA_CQ_DMA_CK		15
+#define CLK_INFRA_EIP97_CK		16
+#define CLK_INFRA_AUD_BUS_CK		17
+#define CLK_INFRA_AUD_26M_CK		18
+#define CLK_INFRA_AUD_L_CK		19
+#define CLK_INFRA_AUD_AUD_CK		20
+#define CLK_INFRA_AUD_EG2_CK		21
+#define CLK_INFRA_DRAMC_26M_CK		22
+#define CLK_INFRA_DBG_CK		23
+#define CLK_INFRA_AP_DMA_CK		24
+#define CLK_INFRA_SEJ_CK		25
+#define CLK_INFRA_SEJ_13M_CK		26
+#define CLK_INFRA_THERM_CK		27
+#define CLK_INFRA_I2C0_CK		28
+#define CLK_INFRA_UART0_CK		29
+#define CLK_INFRA_UART1_CK		30
+#define CLK_INFRA_UART2_CK		31
+#define CLK_INFRA_NFI1_CK		32
+#define CLK_INFRA_SPINFI1_CK		33
+#define CLK_INFRA_NFI_HCK_CK		34
+#define CLK_INFRA_SPI0_CK		35
+#define CLK_INFRA_SPI1_CK		36
+#define CLK_INFRA_SPI0_HCK_CK		37
+#define CLK_INFRA_SPI1_HCK_CK		38
+#define CLK_INFRA_FRTC_CK		39
+#define CLK_INFRA_MSDC_CK		40
+#define CLK_INFRA_MSDC_HCK_CK		41
+#define CLK_INFRA_MSDC_133M_CK		42
+#define CLK_INFRA_MSDC_66M_CK		43
+#define CLK_INFRA_ADC_26M_CK		44
+#define CLK_INFRA_ADC_FRC_CK		45
+#define CLK_INFRA_FBIST2FPC_CK		46
+#define CLK_INFRA_IUSB_133_CK		47
+#define CLK_INFRA_IUSB_66M_CK		48
+#define CLK_INFRA_IUSB_SYS_CK		49
+#define CLK_INFRA_IUSB_CK		50
+#define CLK_INFRA_IPCIE_CK		51
+#define CLK_INFRA_IPCIE_PIPE_CK		52
+#define CLK_INFRA_IPCIER_CK		53
+#define CLK_INFRA_IPCIEB_CK		54
+#define CLK_INFRA_TRNG_CK		55
+#define CLK_INFRA_AO_NR_CLK		46
 
 /* APMIXEDSYS */
 
-#define CK_APMIXED_ARMPLL		0
-#define CK_APMIXED_NET2PLL		1
-#define CK_APMIXED_MMPLL		2
-#define CK_APMIXED_SGMPLL		3
-#define CK_APMIXED_WEDMCUPLL		4
-#define CK_APMIXED_NET1PLL		5
-#define CK_APMIXED_MPLL			6
-#define CK_APMIXED_APLL2		7
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_NET2PLL		1
+#define CLK_APMIXED_MMPLL		2
+#define CLK_APMIXED_SGMPLL		3
+#define CLK_APMIXED_WEDMCUPLL		4
+#define CLK_APMIXED_NET1PLL		5
+#define CLK_APMIXED_MPLL			6
+#define CLK_APMIXED_APLL2		7
 #define CLK_APMIXED_NR_CLK		8
 
 /* SGMIISYS_0 */
 
-#define CK_SGM0_TX_EN			0
-#define CK_SGM0_RX_EN			1
-#define CK_SGM0_CK0_EN			2
-#define CK_SGM0_CDR_CK0_EN		3
+#define CLK_SGM0_TX_EN			0
+#define CLK_SGM0_RX_EN			1
+#define CLK_SGM0_CK0_EN			2
+#define CLK_SGM0_CDR_CK0_EN		3
 #define CLK_SGMII0_NR_CLK		4
 
 /* SGMIISYS_1 */
 
-#define CK_SGM1_TX_EN			0
-#define CK_SGM1_RX_EN			1
-#define CK_SGM1_CK1_EN			2
-#define CK_SGM1_CDR_CK1_EN		3
+#define CLK_SGM1_TX_EN			0
+#define CLK_SGM1_RX_EN			1
+#define CLK_SGM1_CK1_EN			2
+#define CLK_SGM1_CDR_CK1_EN		3
 #define CLK_SGMII1_NR_CLK		4
 
 /* ETHSYS */
 
-#define CK_ETH_FE_EN			0
-#define CK_ETH_GP2_EN			1
-#define CK_ETH_GP1_EN			2
-#define CK_ETH_WOCPU1_EN		3
-#define CK_ETH_WOCPU0_EN		4
+#define CLK_ETH_FE_EN			0
+#define CLK_ETH_GP2_EN			1
+#define CLK_ETH_GP1_EN			2
+#define CLK_ETH_WOCPU1_EN		3
+#define CLK_ETH_WOCPU0_EN		4
 #define CLK_ETH_NR_CLK			5
 
 #endif
-- 
2.45.2

