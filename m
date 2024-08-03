Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC9BC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AEE88C08;
	Sat,  3 Aug 2024 13:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5a9ZmUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0743C88C88; Sat,  3 Aug 2024 13:10:48 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B890088C67
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so19347945e9.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683445; x=1723288245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UogaNJ2MetcrpoXg5JQv8fJftz8ZuvCPnKSLg9qeTak=;
 b=N5a9ZmUu6bjAu0krHlWwm83pwnN34TFXbXb/WKxFlWY1IDKgMCiwIFq6ra1yo1Oc8F
 6hlXhP3MmCfoOPRrFxJW86PXECaZOCzmUVU6p5b/YSDwpbjaQr9rk9gzJg6Ote+wQJ0/
 PzIl0mJIFZ9NM1MCMXsAl60EgUn1sLjS70wQqDIEE2VkZJ0YJU5+SDXO8UDqtBEBCPaK
 o8Z2SLQIB+ztYZfcjNhjb9LNRludTngYU9v2ih1ngt2ASR6D0jH6ffJRA9XxPxZklewJ
 iGf/yBkpgfvBUS1mYilpXR8hUydzBXYnl2jj/NCJe5yAVSGr12BE0y0SYeaW/fmeDCIm
 Bmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683445; x=1723288245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UogaNJ2MetcrpoXg5JQv8fJftz8ZuvCPnKSLg9qeTak=;
 b=b0Bn0s9tSk07NL0bLs13IwLWm5K054w9eqLVJGk3eyQw3AnR4CZmlNYKeRG0UosE2i
 9RU0qGG3n1W8PFU5HpBoma6PDI1sS7jFvtFEeCiIo+qJ6FsAGHbm0DtysW4tbJyiUB0D
 eEdNzlvyiySZ19LcJSzgeTX7i7y2XUQTR4G3u6UVjRWsqZHURMlrhnImIQU+b1wr01xv
 75j0pkaDgM6CY2C6Vz897tTPK2ZZbXzQ2AIAxSnmk9XNHlXYKkeyInb4CDemz1V7+Q0x
 Ss9RpOdVrThDwn/G5qIPaSr8smof1vL5QQNxIG/ndvLamma831X0v8WO79f5dQpb2PIX
 5kfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZVD3GiUaEHRawfHHOMqi20bnadYH8Ayx0bN9OqHnHzrfkBaw7IilkKMYUnHFQ6GpLlOmrkUJ55SgSyNVD7ri2+4iEEQ==
X-Gm-Message-State: AOJu0YzfhHgDaInkSHmX6As+ESZoplvu1tOz98LKUVmmswYW2WfxCUXT
 cm4A6H5RU4jKm0KPf2yB4+ikE5VkBsu/nf8ekj3KMINvNKwtny9U
X-Google-Smtp-Source: AGHT+IFCuf+/TP43GasA9waPYx5nSchyLbshNDdyS6X+TvVuJX7bdkm87wT2rX4fkTw+ZPhHrtAgQw==
X-Received: by 2002:a05:600c:4f53:b0:426:5416:67d7 with SMTP id
 5b1f17b1804b1-428e6b7f149mr38690845e9.27.1722683444883; 
 Sat, 03 Aug 2024 04:10:44 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 08/15] clk: mediatek: mt7986: rename TOPCKGEN factor clock to
 upstream naming
Date: Sat,  3 Aug 2024 10:40:41 +0200
Message-ID: <20240803084050.449-9-ansuelsmth@gmail.com>
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

Rename TOPCKGEN factor clock to upstream neaming.
Upstream kernel linux reference the factor clock for apmixedpll with the
"pll" suffix. Align the naming to the upstream naming format in
preparation for OF_UPSTREAM support.

Also rename rtc clock to drop the CB_ as upstream doesn't have that.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi               |   2 +-
 drivers/clk/mediatek/clk-mt7986.c      | 152 +++++++++++++------------
 include/dt-bindings/clock/mt7986-clk.h |  54 ++++-----
 3 files changed, 108 insertions(+), 100 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index e26b85b8266..31119640d23 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -287,7 +287,7 @@
 		assigned-clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
 				  <&topckgen CK_TOP_EMMC_250M_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_416M>,
-					 <&topckgen CK_TOP_NET1_D5_D2>;
+					 <&topckgen CK_TOP_NET1PLL_D5_D2>;
 		clock-names = "source", "hclk", "source_cg";
 		status = "disabled";
 	};
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 303d959d750..c1f63ecc3b2 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -46,42 +46,50 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor top_fixed_divs[] = {
-	PLL_FACTOR(CK_TOP_CB_M_416M, "cb_m_416m", CK_APMIXED_MPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_M_D2, "cb_m_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_M_D4, "cb_m_d4", CK_APMIXED_MPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_M_D8, "cb_m_d8", CK_APMIXED_MPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_M_D8_D2, "m_d8_d2", CK_APMIXED_MPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_M_D3_D2, "m_d3_d2", CK_APMIXED_MPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_MM_D2, "cb_mm_d2", CK_APMIXED_MMPLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_MM_D4, "cb_mm_d4", CK_APMIXED_MMPLL, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_MM_D8, "cb_mm_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_MM_D8_D2, "mm_d8_d2", CK_APMIXED_MMPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_MM_D3_D8, "mm_d3_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_U2_PHYD_CK, "cb_u2_phyd", CK_APMIXED_MMPLL, 1, 30),
+	/* MPLL */
+	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
+	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
+	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
+	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
+	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
+	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
+	/* MMPLL */
+	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
+	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
+	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
+	PLL_FACTOR(CK_TOP_MMPLL_D8_D2, "mmpll_d8_d2", CK_APMIXED_MMPLL, 1, 16),
+	PLL_FACTOR(CK_TOP_MMPLL_D3_D8, "mmpll_d3_d8", CK_APMIXED_MMPLL, 1, 8),
+	PLL_FACTOR(CK_TOP_MMPLL_U2PHYD, "mmpll_u2phy", CK_APMIXED_MMPLL, 1, 30),
+	/* APLL2 */
 	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
 		   1),
 	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_NET1_D4, "cb_net1_d4", CK_APMIXED_NET1PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_CB_NET1_D5, "cb_net1_d5", CK_APMIXED_NET1PLL, 1, 5),
-	PLL_FACTOR(CK_TOP_NET1_D5_D2, "net1_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
-	PLL_FACTOR(CK_TOP_NET1_D5_D4, "net1_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
-	PLL_FACTOR(CK_TOP_NET1_D8_D2, "net1_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
-	PLL_FACTOR(CK_TOP_NET1_D8_D4, "net1_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
-	PLL_FACTOR(CK_TOP_CB_NET2_800M, "cb_net2_800m", CK_APMIXED_NET2PLL, 1,
+	/* NET1PLL */
+	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CK_APMIXED_NET1PLL, 1, 10),
+	PLL_FACTOR(CK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CK_APMIXED_NET1PLL, 1, 20),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
+	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
+	/* NET2PLL */
+	PLL_FACTOR(CK_TOP_CB_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
 		   1),
-	PLL_FACTOR(CK_TOP_CB_NET2_D4, "cb_net2_d4", CK_APMIXED_NET2PLL, 1, 4),
-	PLL_FACTOR(CK_TOP_NET2_D4_D2, "net2_d4_d2", CK_APMIXED_NET2PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_NET2_D3_D2, "net2_d3_d2", CK_APMIXED_NET2PLL, 1, 2),
-	PLL_FACTOR(CK_TOP_CB_WEDMCU_760M, "cb_wedmcu_760m",
+	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
+	PLL_FACTOR(CK_TOP_NET2PLL_D4_D2, "net2pll_d4_d2", CK_APMIXED_NET2PLL, 1, 8),
+	PLL_FACTOR(CK_TOP_NET2PLL_D3_D2, "net2pll_d3_d2", CK_APMIXED_NET2PLL, 1, 2),
+	/* WEDMCUPLL */
+	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_760M, "cb_wedmcupll_760m",
 		   CK_APMIXED_WEDMCUPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_WEDMCU_D5_D2, "wedmcu_d5_d2", CK_APMIXED_WEDMCUPLL, 1,
+	PLL_FACTOR(CK_TOP_WEDMCUPLL_D5_D2, "wedmcupll_d5_d2", CK_APMIXED_WEDMCUPLL, 1,
 		   10),
-	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
+	/* SGMPLL */
+	PLL_FACTOR(CK_TOP_CB_SGMPLL_325M, "cb_sgmpll_325m", CK_APMIXED_SGMPLL, 1, 1),
+	/* TOPCKGEN and XTAL */
 	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL,
 		   1, 2),
-	TOP_FACTOR(CK_TOP_CB_RTC_32K, "cb_rtc_32k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
-	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_XTAL, 1,
+	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
 	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_XTAL, 1,
@@ -114,92 +122,92 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int nfi1x_parents[] = { CK_TOP_XTAL,  CK_TOP_CB_MM_D8,
-				     CK_TOP_NET1_D8_D2,   CK_TOP_NET2_D3_D2,
-				     CK_TOP_CB_M_D4,      CK_TOP_MM_D8_D2,
-				     CK_TOP_WEDMCU_D5_D2, CK_TOP_CB_M_D8 };
+static const int nfi1x_parents[] = { CK_TOP_XTAL,  CK_TOP_MMPLL_D8,
+				     CK_TOP_NET1PLL_D8_D2,   CK_TOP_NET2PLL_D3_D2,
+				     CK_TOP_MPLL_D4,      CK_TOP_MMPLL_D8_D2,
+				     CK_TOP_WEDMCUPLL_D5_D2, CK_TOP_MPLL_D8 };
 
 static const int spinfi_parents[] = {
-	CK_TOP_XTAL_D2, CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
-	CK_TOP_CB_M_D4,	CK_TOP_MM_D8_D2,    CK_TOP_WEDMCU_D5_D2,
-	CK_TOP_MM_D3_D8,       CK_TOP_CB_M_D8
+	CK_TOP_XTAL_D2, CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
+	CK_TOP_MPLL_D4,	CK_TOP_MMPLL_D8_D2,    CK_TOP_WEDMCUPLL_D5_D2,
+	CK_TOP_MMPLL_D3_D8,       CK_TOP_MPLL_D8
 };
 
-static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2,
-				   CK_TOP_CB_MM_D8,    CK_TOP_NET1_D8_D2,
-				   CK_TOP_NET2_D3_D2,  CK_TOP_NET1_D5_D4,
-				   CK_TOP_CB_M_D4,     CK_TOP_WEDMCU_D5_D2 };
+static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
+				   CK_TOP_MMPLL_D8,    CK_TOP_NET1PLL_D8_D2,
+				   CK_TOP_NET2PLL_D3_D2,  CK_TOP_NET1PLL_D5_D4,
+				   CK_TOP_MPLL_D4,     CK_TOP_WEDMCUPLL_D5_D2 };
 
-static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D8,
-				    CK_TOP_M_D8_D2 };
+static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8,
+				    CK_TOP_MPLL_D8_D2 };
 
-static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
-				   CK_TOP_NET1_D5_D4, CK_TOP_CB_M_D4 };
+static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
+				   CK_TOP_NET1PLL_D5_D4, CK_TOP_MPLL_D4 };
 
-static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4,
-				   CK_TOP_CB_M_D4, CK_TOP_NET1_D8_D4 };
+static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
+				   CK_TOP_MPLL_D4, CK_TOP_NET1PLL_D8_D4 };
 
 static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET1_D5_D4, CK_TOP_NET2_D4_D2,
-					   CK_TOP_CB_RTC_32K };
+					   CK_TOP_NET1PLL_D5_D4, CK_TOP_NET2PLL_D4_D2,
+					   CK_TOP_RTC_32K };
 
 static const int emmc_250m_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_NET1_D5_D2 };
+					 CK_TOP_NET1PLL_D5_D2 };
 
-static const int emmc_416m_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_416M };
+static const int emmc_416m_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_416M };
 
-static const int f_26m_adc_parents[] = { CK_TOP_XTAL, CK_TOP_M_D8_D2 };
+static const int f_26m_adc_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8_D2 };
 
-static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_CB_M_D2 };
+static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2 };
 
-static const int sysaxi_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D2,
-				      CK_TOP_CB_NET2_D4 };
+static const int sysaxi_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
+				      CK_TOP_NET2PLL_D4 };
 
-static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_M_D3_D2,
-				      CK_TOP_NET2_D4_D2 };
+static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D3_D2,
+				      CK_TOP_NET2PLL_D4_D2 };
 
 static const int arm_db_main_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET2_D3_D2 };
+					   CK_TOP_NET2PLL_D3_D2 };
 
 static const int arm_db_jtsel_parents[] = { -1, CK_TOP_XTAL };
 
-static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_CB_MM_D4 };
+static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_MMPLL_D4 };
 
 static const int netsys_500m_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_CB_NET1_D5 };
+					   CK_TOP_NET1PLL_D5 };
 
 static const int netsys_mcu_parents[] = { CK_TOP_XTAL,
 					  CK_TOP_CB_WEDMCU_760M,
-					  CK_TOP_CB_MM_D2, CK_TOP_CB_NET1_D4,
-					  CK_TOP_CB_NET1_D5 };
+					  CK_TOP_MMPLL_D2, CK_TOP_NET1PLL_D4,
+					  CK_TOP_NET1PLL_D5 };
 
 static const int netsys_2x_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_CB_NET2_800M,
+					 CK_TOP_CB_NET2PLL_800M,
 					 CK_TOP_CB_WEDMCU_760M,
-					 CK_TOP_CB_MM_D2 };
+					 CK_TOP_MMPLL_D2 };
 
 static const int sgm_325m_parents[] = { CK_TOP_XTAL,
 					CK_TOP_CB_SGM_325M };
 
-static const int sgm_reg_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D8_D4 };
+static const int sgm_reg_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D4 };
 
 static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4 };
 
 static const int conn_mcusys_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_CB_MM_D2 };
+					   CK_TOP_MMPLL_D2 };
 
-static const int eip_b_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2_800M };
+static const int eip_b_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2PLL_800M };
 
 static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
-				     CK_TOP_M_D8_D2 };
+				     CK_TOP_MPLL_D8_D2 };
 
 static const int a_tuner_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4,
-				       CK_TOP_M_D8_D2 };
+				       CK_TOP_MPLL_D8_D2 };
 
-static const int u2u3_sys_parents[] = { CK_TOP_XTAL, CK_TOP_NET1_D5_D4 };
+static const int u2u3_sys_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4 };
 
 static const int da_u2_refsel_parents[] = { CK_TOP_XTAL,
-					    CK_TOP_CB_U2_PHYD_CK };
+					    CK_TOP_MMPLL_U2PHYD };
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -327,14 +335,14 @@ static const struct mtk_parent infra_spi1_parents[] = {
 };
 
 static const struct mtk_parent infra_pwm_bsel_parents[] = {
-	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_RTC_32P7K),
 	TOP_PARENT(CK_TOP_F26M_SEL),
 	INFRA_PARENT(CK_INFRA_SYSAXI_D2),
 	TOP_PARENT(CK_TOP_PWM_SEL)
 };
 
 static const struct mtk_parent infra_pcie_parents[] = {
-	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CK_TOP_RTC_32P7K),
 	TOP_PARENT(CK_TOP_F26M_SEL),
 	TOP_PARENT(CK_TOP_XTAL),
 	TOP_PARENT(CK_TOP_PEXTP_TL_SEL)
@@ -466,7 +474,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 			  13),
 	GATE_INFRA1_INFRA(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_SYSAXI_D2,
 			  14),
-	GATE_INFRA1_TOP(CK_INFRA_FRTC_CK, "infra_frtc", CK_TOP_CB_RTC_32K, 15),
+	GATE_INFRA1_TOP(CK_INFRA_FRTC_CK, "infra_frtc", CK_TOP_RTC_32K, 15),
 	GATE_INFRA1_TOP(CK_INFRA_MSDC_CK, "infra_msdc", CK_TOP_EMMC_416M_SEL, 16),
 	GATE_INFRA1_TOP(CK_INFRA_MSDC_HCK_CK, "infra_msdc_hck",
 			CK_TOP_EMMC_250M_SEL, 17),
@@ -499,7 +507,7 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
-	.fdivs_offs = CK_TOP_CB_M_416M,
+	.fdivs_offs = CK_TOP_MPLL_416M,
 	.muxes_offs = CK_TOP_NFI1X_SEL,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index a48d57512d1..f19948cca16 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -16,36 +16,36 @@
 /* TOPCKGEN */
 
 #define CK_TOP_XTAL			0
-#define CK_TOP_CB_M_416M		1
-#define CK_TOP_CB_M_D2			2
-#define CK_TOP_CB_M_D4			3
-#define CK_TOP_CB_M_D8			4
-#define CK_TOP_M_D8_D2			5
-#define CK_TOP_M_D3_D2			6
-#define CK_TOP_CB_MM_D2			7
-#define CK_TOP_CB_MM_D4			8
-#define CK_TOP_CB_MM_D8			9
-#define CK_TOP_MM_D8_D2			10
-#define CK_TOP_MM_D3_D8			11
-#define CK_TOP_CB_U2_PHYD_CK		12
+#define CK_TOP_CB_MPLL_416M		1
+#define CK_TOP_MPLL_D2			2
+#define CK_TOP_MPLL_D4			3
+#define CK_TOP_MPLL_D8			4
+#define CK_TOP_MPLL_D8_D2		5
+#define CK_TOP_MPLL_D3_D2		6
+#define CK_TOP_MMPLL_D2			7
+#define CK_TOP_MMPLL_D4			8
+#define CK_TOP_MMPLL_D8			9
+#define CK_TOP_MMPLL_D8_D2		10
+#define CK_TOP_MMPLL_D3_D8		11
+#define CK_TOP_MMPLL_U2PHYD		12
 #define CK_TOP_CB_APLL2_196M		13
 #define CK_TOP_APLL2_D4			14
-#define CK_TOP_CB_NET1_D4		15
-#define CK_TOP_CB_NET1_D5		16
-#define CK_TOP_NET1_D5_D2		17
-#define CK_TOP_NET1_D5_D4		18
-#define CK_TOP_NET1_D8_D2		19
-#define CK_TOP_NET1_D8_D4		20
-#define CK_TOP_CB_NET2_800M		21
-#define CK_TOP_CB_NET2_D4		22
-#define CK_TOP_NET2_D4_D2		23
-#define CK_TOP_NET2_D3_D2		24
-#define CK_TOP_CB_WEDMCU_760M		25
-#define CK_TOP_WEDMCU_D5_D2		26
-#define CK_TOP_CB_SGM_325M		27
+#define CK_TOP_NET1PLL_D4		15
+#define CK_TOP_NET1PLL_D5		16
+#define CK_TOP_NET1PLL_D5_D2		17
+#define CK_TOP_NET1PLL_D5_D4		18
+#define CK_TOP_NET1PLL_D8_D2		19
+#define CK_TOP_NET1PLL_D8_D4		20
+#define CK_TOP_CB_NET2PLL_800M		21
+#define CK_TOP_NET2PLL_D4		22
+#define CK_TOP_NET2PLL_D4_D2		23
+#define CK_TOP_NET2PLL_D3_D2		24
+#define CK_TOP_CB_WEDMCUPLL_760M	25
+#define CK_TOP_WEDMCUPLL_D5_D2		26
+#define CK_TOP_CB_SGMPLL_325M		27
 #define CK_TOP_XTAL_D2			28
-#define CK_TOP_CB_RTC_32K		29
-#define CK_TOP_CB_RTC_32P7K		30
+#define CK_TOP_RTC_32K			29
+#define CK_TOP_RTC_32P7K		30
 #define CK_TOP_NFI1X			31
 #define CK_TOP_USB_EQ_RX250M		32
 #define CK_TOP_USB_TX250M		33
-- 
2.45.2

