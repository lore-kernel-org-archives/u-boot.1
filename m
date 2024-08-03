Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8FC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023A288CA1;
	Sat,  3 Aug 2024 13:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XvUbH713";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71C588C88; Sat,  3 Aug 2024 13:10:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D4B88C73
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so80752515e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683448; x=1723288248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LCzvvtzsW4VEtyhhqsvmtDpg2XhI40XsS3wmIGIHcWQ=;
 b=XvUbH713+iK9Ci3J4NYisLSy6+X/mQHaP3o6bWuDaJU8fkksAgekWKkPRORa1xq/+E
 JTnyqwJLTWMO1k4lY84zjfZ+1+0XGi/v9AOSEIERaJtCVVNY8rxndFud9H0R7C1Cq0Y0
 efgFj56rAbhxDvrWWb6fkyIy24vapz5P+paQAb5k8sry6cM01VwlPJobn4bk60rjL7FR
 QU8bqWyxiaPjRtcNZEPifU/AcXQbNpygo7CPcNWJlsYdZU4MuutuTfJyI5FBQvycfCpC
 elY5BSt+e2HV0EZv8Zlcmv3ih71ndEDS+ux7OUwHCTe7djVqrMPTyGhW5WYXoXryxT1E
 Sw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683448; x=1723288248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCzvvtzsW4VEtyhhqsvmtDpg2XhI40XsS3wmIGIHcWQ=;
 b=SNqjyO3zyVCIAn84NJkl6j9/vyXAT+GKhwG6e56fV7HNOM/yW+RKIEd2eZ+x0GRAaS
 plw2/9wvhk3eQq8UXDPMt5L2YLjtrBm5GxSvRJ0R1hVHYtFPYaqRAtPHLlh73f6evSSl
 KL+7YudprnzKFLWxrptHN76rmZwUb0Vji/+4AQAPRPofznhyhm2qXA13sLxenAN1H2l+
 n31Pbab45iUrFriKb8IMH57MilOAAJ533JRptlwbq8/OQASRipMYDPvvOevw+E3VFYSE
 R9kF8jJHyfkrRtm3QdBPG9qfBV94nDyZUPreJ1jPBfMuKNlWwRIgY8nvSmHqWLNVpGYU
 iOUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF1kSjZulJlxbRO8TM0h614T/6PGVngB6tEYJkYXfwB9yc+ibnAXjctY7+sjQeKlZ4AX+muVhZ81UuByMKxpbIxrUoeg==
X-Gm-Message-State: AOJu0Yyn+imkkbc5zfjYE7A2qwSQ5prTRVKsrHnirHfh16VW9RO+aW1T
 tl3BWnt8Ov9lpCmjjVhnw1b31FFGVucDstx2LziUAZDnyaKQnotg
X-Google-Smtp-Source: AGHT+IGsoNqPP9/e9P3hFbH9Cq351Lw7MgN3/0tC/b9ghFjbTPQ7cxNXE7Vc08EB0LxnKy4/7iKP+w==
X-Received: by 2002:a05:600c:4ec6:b0:426:5c81:2538 with SMTP id
 5b1f17b1804b1-428e6b03d8cmr48167865e9.14.1722683447607; 
 Sat, 03 Aug 2024 04:10:47 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 10/15] clk: mediatek: mt7986: drop 1/1 spurious factor for
 topckgen
Date: Sat,  3 Aug 2024 10:40:43 +0200
Message-ID: <20240803084050.449-11-ansuelsmth@gmail.com>
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

Now that we can have advanced parent handling for mux, we can drop
spurious topckgen 1/1 factor. This is in preparation to make the clk
ID match the ID in upstream include for mt7986.

Drop the factor entry from mt7986-clk.h and reference to them in
mt7981.dtsi. Muxes and gates are updated to reference the apmixed clk
following how it's done in upstream kernel linux. Add relevant clk type
flag in clk_tree for apmixed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7986.dtsi               |  14 +-
 drivers/clk/mediatek/clk-mt7986.c      | 223 +++++++++++++------------
 include/dt-bindings/clock/mt7986-clk.h | 150 +++++++----------
 3 files changed, 186 insertions(+), 201 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index 31119640d23..187e1298fae 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -162,7 +162,7 @@
 				  <&infracfg CK_INFRA_PWM_BSEL>,
 				  <&infracfg CK_INFRA_PWM1_SEL>,
 				  <&infracfg CK_INFRA_PWM2_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D4>,
+		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D4>,
 					 <&topckgen CK_TOP_PWM_SEL>,
 					 <&topckgen CK_TOP_PWM_SEL>,
 					 <&topckgen CK_TOP_PWM_SEL>;
@@ -218,8 +218,8 @@
 		clock-names = "pad_clk", "nfi_clk", "nfi_hclk";
 		assigned-clocks = <&topckgen CK_TOP_SPINFI_SEL>,
 				  <&topckgen CK_TOP_NFI1X_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D8>,
-					 <&topckgen CK_TOP_CB_M_D8>;
+		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D8>,
+					 <&topckgen CK_TOP_MPLL_D8>;
 		status = "disabled";
 	};
 
@@ -262,7 +262,7 @@
 			 <&topckgen CK_TOP_SPI_SEL>;
 		assigned-clocks = <&topckgen CK_TOP_SPI_SEL>,
 				  <&infracfg CK_INFRA_SPI0_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
+		assigned-clock-parents = <&topckgen CK_TOP_MPLL_D2>,
 					 <&topckgen CK_TOP_SPI_SEL>;
 		clock-names = "sel-clk", "spi-clk";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
@@ -281,12 +281,12 @@
 		reg = <0x11230000 0x1000>,
 		      <0x11C20000 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&topckgen CK_TOP_EMMC_416M>,
-			<&topckgen CK_TOP_EMMC_250M>,
+		clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
+			<&topckgen CK_TOP_EMMC_250M_SEL>,
 			<&infracfg_ao CK_INFRA_MSDC_CK>;
 		assigned-clocks = <&topckgen CK_TOP_EMMC_416M_SEL>,
 				  <&topckgen CK_TOP_EMMC_250M_SEL>;
-		assigned-clock-parents = <&topckgen CK_TOP_CB_M_416M>,
+		assigned-clock-parents = <&fixed_plls CK_APMIXED_MPLL>,
 					 <&topckgen CK_TOP_NET1PLL_D5_D2>;
 		clock-names = "source", "hclk", "source_cg";
 		status = "disabled";
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 34b8eba5398..d8e0a5790e3 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -18,6 +18,11 @@
 #define MT7986_CLK_PDN 0x250
 #define MT7986_CLK_PDN_EN_WRITE BIT(31)
 
+#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
+#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
+#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
+#define VOID_PARENT PARENT(-1, 0)
+
 #define PLL_FACTOR(_id, _name, _parent, _mult, _div)                           \
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
 
@@ -53,36 +58,8 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 		   1250),
 	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
-	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_XTAL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_USB_TX250M, "usb_tx250m", CK_TOP_XTAL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_LN0_CK, "usb_ln0", CK_TOP_XTAL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_CDR_CK, "usb_cdr", CK_TOP_XTAL, 1, 1),
-	TOP_FACTOR(CK_TOP_SPINFI_BCK, "spinfi_bck", CK_TOP_SPINFI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_I2C_BCK, "i2c_bck", CK_TOP_I2C_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_PEXTP_TL, "pextp_tl", CK_TOP_PEXTP_TL_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EMMC_250M, "emmc_250m", CK_TOP_EMMC_250M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EMMC_416M, "emmc_416m", CK_TOP_EMMC_416M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_F_26M_ADC_CK, "f_26m_adc", CK_TOP_F_26M_ADC_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_SYSAXI, "sysaxi", CK_TOP_SYSAXI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_NETSYS_WED_MCU, "netsys_wed_mcu",
-		   CK_TOP_NETSYS_MCU_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_NETSYS_2X, "netsys_2x", CK_TOP_NETSYS_2X_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_SGM_325M, "sgm_325m", CK_TOP_SGM_325M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_A1SYS, "a1sys", CK_TOP_A1SYS_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EIP_B, "eip_b", CK_TOP_EIP_B_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_F26M, "csw_f26m", CK_TOP_F26M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_AUD_L, "aud_l", CK_TOP_AUD_L_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1),
-	TOP_FACTOR(CK_TOP_U2U3_REF, "u2u3_ref", CK_TOP_U2U3_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_U2U3_SYS, "u2u3_sys", CK_TOP_U2U3_SYS_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_U2U3_XHCI, "u2u3_xhci", CK_TOP_U2U3_XHCI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_AP2CNN_HOST, "ap2cnn_host", CK_TOP_AP2CNN_HOST_SEL, 1,
-		   1),
 	/* MPLL */
-	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
 	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
@@ -96,8 +73,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	PLL_FACTOR(CK_TOP_MMPLL_D3_D8, "mmpll_d3_d8", CK_APMIXED_MMPLL, 1, 8),
 	PLL_FACTOR(CK_TOP_MMPLL_U2PHYD, "mmpll_u2phy", CK_APMIXED_MMPLL, 1, 30),
 	/* APLL2 */
-	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
-		   1),
 	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
 	/* NET1PLL */
 	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
@@ -107,107 +82,146 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, 1, 16),
 	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, 1, 32),
 	/* NET2PLL */
-	PLL_FACTOR(CK_TOP_CB_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
-		   1),
 	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
 	PLL_FACTOR(CK_TOP_NET2PLL_D4_D2, "net2pll_d4_d2", CK_APMIXED_NET2PLL, 1, 8),
 	PLL_FACTOR(CK_TOP_NET2PLL_D3_D2, "net2pll_d3_d2", CK_APMIXED_NET2PLL, 1, 2),
 	/* WEDMCUPLL */
-	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_760M, "cb_wedmcupll_760m",
-		   CK_APMIXED_WEDMCUPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_WEDMCUPLL_D5_D2, "wedmcupll_d5_d2", CK_APMIXED_WEDMCUPLL, 1,
 		   10),
-	/* SGMPLL */
-	PLL_FACTOR(CK_TOP_CB_SGMPLL_325M, "cb_sgmpll_325m", CK_APMIXED_SGMPLL, 1, 1),
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int nfi1x_parents[] = { CK_TOP_XTAL,  CK_TOP_MMPLL_D8,
-				     CK_TOP_NET1PLL_D8_D2,   CK_TOP_NET2PLL_D3_D2,
-				     CK_TOP_MPLL_D4,      CK_TOP_MMPLL_D8_D2,
-				     CK_TOP_WEDMCUPLL_D5_D2, CK_TOP_MPLL_D8 };
+static const struct mtk_parent nfi1x_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D8),
+	TOP_PARENT(CK_TOP_NET1PLL_D8_D2), TOP_PARENT(CK_TOP_NET2PLL_D3_D2),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_MMPLL_D8_D2),
+	TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2), TOP_PARENT(CK_TOP_MPLL_D8),
+};
 
-static const int spinfi_parents[] = {
-	CK_TOP_XTAL_D2, CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
-	CK_TOP_MPLL_D4,	CK_TOP_MMPLL_D8_D2,    CK_TOP_WEDMCUPLL_D5_D2,
-	CK_TOP_MMPLL_D3_D8,       CK_TOP_MPLL_D8
+static const struct mtk_parent spinfi_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_XTAL),
+	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
+	TOP_PARENT(CK_TOP_MMPLL_D8_D2), TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D3_D8), TOP_PARENT(CK_TOP_MPLL_D8),
 };
 
-static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
-				   CK_TOP_MMPLL_D8,    CK_TOP_NET1PLL_D8_D2,
-				   CK_TOP_NET2PLL_D3_D2,  CK_TOP_NET1PLL_D5_D4,
-				   CK_TOP_MPLL_D4,     CK_TOP_WEDMCUPLL_D5_D2 };
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CK_TOP_NET2PLL_D3_D2), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_WEDMCUPLL_D5_D2),
+};
 
-static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8,
-				    CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
-				   CK_TOP_NET1PLL_D5_D4, CK_TOP_MPLL_D4 };
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
+};
 
-static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
-				   CK_TOP_MPLL_D4, CK_TOP_NET1PLL_D8_D4 };
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+};
 
-static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET1PLL_D5_D4, CK_TOP_NET2PLL_D4_D2,
-					   CK_TOP_RTC_32K };
+static const struct mtk_parent pextp_tl_ck_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CK_TOP_NET2PLL_D4_D2), TOP_PARENT(CK_TOP_RTC_32K),
+};
 
-static const int emmc_250m_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_NET1PLL_D5_D2 };
+static const struct mtk_parent emmc_250m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
+};
 
-static const int emmc_416m_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_416M };
+static const struct mtk_parent emmc_416m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_MPLL),
+};
 
-static const int f_26m_adc_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent f_26m_adc_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2 };
+static const struct mtk_parent dramc_md32_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
+};
 
-static const int sysaxi_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
-				      CK_TOP_NET2PLL_D4 };
+static const struct mtk_parent sysaxi_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CK_TOP_NET2PLL_D4),
+};
 
-static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D3_D2,
-				      CK_TOP_NET2PLL_D4_D2 };
+static const struct mtk_parent sysapb_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D3_D2),
+	TOP_PARENT(CK_TOP_NET2PLL_D4_D2),
+};
 
-static const int arm_db_main_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET2PLL_D3_D2 };
+static const struct mtk_parent arm_db_main_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D3_D2),
+};
 
-static const int arm_db_jtsel_parents[] = { -1, CK_TOP_XTAL };
+static const struct mtk_parent arm_db_jtsel_parents[] = {
+	VOID_PARENT, TOP_PARENT(CK_TOP_XTAL),
+};
 
-static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_MMPLL_D4 };
+static const struct mtk_parent netsys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D4),
+};
 
-static const int netsys_500m_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET1PLL_D5 };
+static const struct mtk_parent netsys_500m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
+};
 
-static const int netsys_mcu_parents[] = { CK_TOP_XTAL,
-					  CK_TOP_CB_WEDMCU_760M,
-					  CK_TOP_MMPLL_D2, CK_TOP_NET1PLL_D4,
-					  CK_TOP_NET1PLL_D5 };
+static const struct mtk_parent netsys_mcu_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_WEDMCUPLL),
+	TOP_PARENT(CK_TOP_MMPLL_D2), TOP_PARENT(CK_TOP_NET1PLL_D4),
+	TOP_PARENT(CK_TOP_NET1PLL_D5),
+};
 
-static const int netsys_2x_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_CB_NET2PLL_800M,
-					 CK_TOP_CB_WEDMCU_760M,
-					 CK_TOP_MMPLL_D2 };
+static const struct mtk_parent netsys_2x_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_APMIXED_NET2PLL),
+	APMIXED_PARENT(CK_APMIXED_WEDMCUPLL), TOP_PARENT(CK_TOP_MMPLL_D2),
+};
 
-static const int sgm_325m_parents[] = { CK_TOP_XTAL,
-					CK_TOP_CB_SGM_325M };
+static const struct mtk_parent sgm_325m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
+};
 
-static const int sgm_reg_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D4 };
+static const struct mtk_parent sgm_reg_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+};
 
-static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4 };
+static const struct mtk_parent a1sys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
+};
 
-static const int conn_mcusys_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_MMPLL_D2 };
+static const struct mtk_parent conn_mcusys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D2),
+};
 
-static const int eip_b_parents[] = { CK_TOP_XTAL, CK_TOP_CB_NET2PLL_800M };
+static const struct mtk_parent eip_b_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
+};
 
-static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
-				     CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent aud_l_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int a_tuner_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4,
-				       CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent a_tuner_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int u2u3_sys_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4 };
+static const struct mtk_parent u2u3_sys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+};
 
-static const int da_u2_refsel_parents[] = { CK_TOP_XTAL,
-					    CK_TOP_MMPLL_U2PHYD };
+static const struct mtk_parent da_u2_refsel_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_U2PHYD),
+};
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -216,9 +230,9 @@ static const int da_u2_refsel_parents[] = { CK_TOP_XTAL,
 		.mux_clr_reg = _mux_clr_ofs, .upd_reg = _upd_ofs,              \
 		.upd_shift = _upd, .mux_shift = _shift,                        \
 		.mux_mask = BIT(_width) - 1, .gate_reg = _mux_ofs,             \
-		.gate_shift = _gate, .parent = _parents,                       \
+		.gate_shift = _gate, .parent_flags = _parents,                 \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD,                                   \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
 	}
 
 /* TOPCKGEN MUX_GATE */
@@ -315,9 +329,7 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 };
 
 /* INFRASYS MUX PARENTS */
-#define INFRA_PARENT(_id) PARENT(_id, CLK_PARENT_INFRASYS)
-#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
-#define VOID_PARENT PARENT(-1, 0)
+
 
 static const struct mtk_parent infra_uart0_parents[] = {
 	TOP_PARENT(CK_TOP_F26M_SEL),
@@ -504,10 +516,11 @@ static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.fdivs_offs = CLK_APMIXED_NR_CLK,
 	.xtal_rate = 40 * MHZ,
 	.fclks = fixed_pll_clks,
+	.flags = CLK_APMIXED,
 };
 
 static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
-	.fdivs_offs = CK_TOP_MPLL_416M,
+	.fdivs_offs = CK_TOP_XTAL_D2,
 	.muxes_offs = CK_TOP_NFI1X_SEL,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
@@ -623,11 +636,11 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	}
 
 static const struct mtk_gate eth_cgs[] = {
-	GATE_ETH(CK_ETH_FE_EN, "eth_fe_en", CK_TOP_NETSYS_2X, 7),
-	GATE_ETH(CK_ETH_GP2_EN, "eth_gp2_en", CK_TOP_SGM_325M, 8),
-	GATE_ETH(CK_ETH_GP1_EN, "eth_gp1_en", CK_TOP_SGM_325M, 8),
-	GATE_ETH(CK_ETH_WOCPU1_EN, "eth_wocpu1_en", CK_TOP_NETSYS_WED_MCU, 14),
-	GATE_ETH(CK_ETH_WOCPU0_EN, "eth_wocpu0_en", CK_TOP_NETSYS_WED_MCU, 15),
+	GATE_ETH(CK_ETH_FE_EN, "eth_fe_en", CK_TOP_NETSYS_2X_SEL, 7),
+	GATE_ETH(CK_ETH_GP2_EN, "eth_gp2_en", CK_TOP_SGM_325M_SEL, 8),
+	GATE_ETH(CK_ETH_GP1_EN, "eth_gp1_en", CK_TOP_SGM_325M_SEL, 8),
+	GATE_ETH(CK_ETH_WOCPU1_EN, "eth_wocpu1_en", CK_TOP_NETSYS_MCU_SEL, 14),
+	GATE_ETH(CK_ETH_WOCPU0_EN, "eth_wocpu0_en", CK_TOP_NETSYS_MCU_SEL, 15),
 };
 
 static int mt7986_ethsys_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 0048d183389..478538d7cce 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -19,95 +19,67 @@
 #define CK_TOP_XTAL_D2			1
 #define CK_TOP_RTC_32K			2
 #define CK_TOP_RTC_32P7K		3
-#define CK_TOP_NFI1X			4
-#define CK_TOP_USB_EQ_RX250M		5
-#define CK_TOP_USB_TX250M		6
-#define CK_TOP_USB_LN0_CK		7
-#define CK_TOP_USB_CDR_CK		8
-#define CK_TOP_SPINFI_BCK		9
-#define CK_TOP_I2C_BCK			10
-#define CK_TOP_PEXTP_TL			11
-#define CK_TOP_EMMC_250M		12
-#define CK_TOP_EMMC_416M		13
-#define CK_TOP_F_26M_ADC_CK		14
-#define CK_TOP_SYSAXI			15
-#define CK_TOP_NETSYS_WED_MCU		16
-#define CK_TOP_NETSYS_2X		17
-#define CK_TOP_SGM_325M			18
-#define CK_TOP_A1SYS			19
-#define CK_TOP_EIP_B			20
-#define CK_TOP_F26M			21
-#define CK_TOP_AUD_L			22
-#define CK_TOP_A_TUNER			23
-#define CK_TOP_U2U3_REF			24
-#define CK_TOP_U2U3_SYS			25
-#define CK_TOP_U2U3_XHCI		26
-#define CK_TOP_AP2CNN_HOST		27
-#define CK_TOP_CB_MPLL_416M		28
-#define CK_TOP_MPLL_D2			29
-#define CK_TOP_MPLL_D4			30
-#define CK_TOP_MPLL_D8			31
-#define CK_TOP_MPLL_D8_D2		32
-#define CK_TOP_MPLL_D3_D2		33
-#define CK_TOP_MMPLL_D2			34
-#define CK_TOP_MMPLL_D4			35
-#define CK_TOP_MMPLL_D8			36
-#define CK_TOP_MMPLL_D8_D2		37
-#define CK_TOP_MMPLL_D3_D8		38
-#define CK_TOP_MMPLL_U2PHYD		39
-#define CK_TOP_CB_APLL2_196M		40
-#define CK_TOP_APLL2_D4			41
-#define CK_TOP_NET1PLL_D4		42
-#define CK_TOP_NET1PLL_D5		43
-#define CK_TOP_NET1PLL_D5_D2		44
-#define CK_TOP_NET1PLL_D5_D4		45
-#define CK_TOP_NET1PLL_D8_D2		46
-#define CK_TOP_NET1PLL_D8_D4		47
-#define CK_TOP_CB_NET2PLL_800M		48
-#define CK_TOP_NET2PLL_D4		49
-#define CK_TOP_NET2PLL_D4_D2		50
-#define CK_TOP_NET2PLL_D3_D2		51
-#define CK_TOP_CB_WEDMCUPLL_760M	52
-#define CK_TOP_WEDMCUPLL_D5_D2		53
-#define CK_TOP_CB_SGMPLL_325M		54
-#define CK_TOP_NFI1X_SEL		55
-#define CK_TOP_SPINFI_SEL		56
-#define CK_TOP_SPI_SEL			57
-#define CK_TOP_SPIM_MST_SEL		58
-#define CK_TOP_UART_SEL			59
-#define CK_TOP_PWM_SEL			60
-#define CK_TOP_I2C_SEL			61
-#define CK_TOP_PEXTP_TL_SEL		62
-#define CK_TOP_EMMC_250M_SEL		63
-#define CK_TOP_EMMC_416M_SEL		64
-#define CK_TOP_F_26M_ADC_SEL		65
-#define CK_TOP_DRAMC_SEL		66
-#define CK_TOP_DRAMC_MD32_SEL		67
-#define CK_TOP_SYSAXI_SEL		68
-#define CK_TOP_SYSAPB_SEL		69
-#define CK_TOP_ARM_DB_MAIN_SEL		70
-#define CK_TOP_ARM_DB_JTSEL		71
-#define CK_TOP_NETSYS_SEL		72
-#define CK_TOP_NETSYS_500M_SEL		73
-#define CK_TOP_NETSYS_MCU_SEL		74
-#define CK_TOP_NETSYS_2X_SEL		75
-#define CK_TOP_SGM_325M_SEL		76
-#define CK_TOP_SGM_REG_SEL		77
-#define CK_TOP_A1SYS_SEL		78
-#define CK_TOP_CONN_MCUSYS_SEL		79
-#define CK_TOP_EIP_B_SEL		80
-#define CK_TOP_PCIE_PHY_SEL		81
-#define CK_TOP_USB3_PHY_SEL		82
-#define CK_TOP_F26M_SEL			83
-#define CK_TOP_AUD_L_SEL		84
-#define CK_TOP_A_TUNER_SEL		85
-#define CK_TOP_U2U3_SEL			86
-#define CK_TOP_U2U3_SYS_SEL		87
-#define CK_TOP_U2U3_XHCI_SEL		88
-#define CK_TOP_DA_U2_REFSEL		89
-#define CK_TOP_DA_U2_CK_1P_SEL		90
-#define CK_TOP_AP2CNN_HOST_SEL		91
-#define CLK_TOP_NR_CLK			92
+#define CK_TOP_A_TUNER			4
+#define CK_TOP_MPLL_D2			5
+#define CK_TOP_MPLL_D4			6
+#define CK_TOP_MPLL_D8			7
+#define CK_TOP_MPLL_D8_D2		8
+#define CK_TOP_MPLL_D3_D2		9
+#define CK_TOP_MMPLL_D2			10
+#define CK_TOP_MMPLL_D4			11
+#define CK_TOP_MMPLL_D8			12
+#define CK_TOP_MMPLL_D8_D2		13
+#define CK_TOP_MMPLL_D3_D8		14
+#define CK_TOP_MMPLL_U2PHYD		15
+#define CK_TOP_APLL2_D4			16
+#define CK_TOP_NET1PLL_D4		17
+#define CK_TOP_NET1PLL_D5		18
+#define CK_TOP_NET1PLL_D5_D2		19
+#define CK_TOP_NET1PLL_D5_D4		20
+#define CK_TOP_NET1PLL_D8_D2		21
+#define CK_TOP_NET1PLL_D8_D4		22
+#define CK_TOP_NET2PLL_D4		23
+#define CK_TOP_NET2PLL_D4_D2		24
+#define CK_TOP_NET2PLL_D3_D2		25
+#define CK_TOP_WEDMCUPLL_D5_D2		26
+#define CK_TOP_NFI1X_SEL		27
+#define CK_TOP_SPINFI_SEL		28
+#define CK_TOP_SPI_SEL			29
+#define CK_TOP_SPIM_MST_SEL		30
+#define CK_TOP_UART_SEL			31
+#define CK_TOP_PWM_SEL			32
+#define CK_TOP_I2C_SEL			33
+#define CK_TOP_PEXTP_TL_SEL		34
+#define CK_TOP_EMMC_250M_SEL		35
+#define CK_TOP_EMMC_416M_SEL		36
+#define CK_TOP_F_26M_ADC_SEL		37
+#define CK_TOP_DRAMC_SEL		38
+#define CK_TOP_DRAMC_MD32_SEL		39
+#define CK_TOP_SYSAXI_SEL		40
+#define CK_TOP_SYSAPB_SEL		41
+#define CK_TOP_ARM_DB_MAIN_SEL		42
+#define CK_TOP_ARM_DB_JTSEL		43
+#define CK_TOP_NETSYS_SEL		44
+#define CK_TOP_NETSYS_500M_SEL		45
+#define CK_TOP_NETSYS_MCU_SEL		46
+#define CK_TOP_NETSYS_2X_SEL		47
+#define CK_TOP_SGM_325M_SEL		48
+#define CK_TOP_SGM_REG_SEL		49
+#define CK_TOP_A1SYS_SEL		50
+#define CK_TOP_CONN_MCUSYS_SEL		51
+#define CK_TOP_EIP_B_SEL		52
+#define CK_TOP_PCIE_PHY_SEL		53
+#define CK_TOP_USB3_PHY_SEL		54
+#define CK_TOP_F26M_SEL			55
+#define CK_TOP_AUD_L_SEL		56
+#define CK_TOP_A_TUNER_SEL		57
+#define CK_TOP_U2U3_SEL			58
+#define CK_TOP_U2U3_SYS_SEL		59
+#define CK_TOP_U2U3_XHCI_SEL		60
+#define CK_TOP_DA_U2_REFSEL		61
+#define CK_TOP_DA_U2_CK_1P_SEL		62
+#define CK_TOP_AP2CNN_HOST_SEL		63
+#define CLK_TOP_NR_CLK			64
 
 /*
  * INFRACFG_AO
-- 
2.45.2

