Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C65C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA41688C87;
	Sat,  3 Aug 2024 10:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xa6OazYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B179688C87; Sat,  3 Aug 2024 10:33:35 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE42388792
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso8106105e9.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674012; x=1723278812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5b46Jki8r7GdhhaBXdWr4jTO2FIjDX3m44PUZVGmV7M=;
 b=Xa6OazYulrY5tV6mYCgBmEhPWEXo72VsmKjw/Rb82hlKsi2Pfz62JeHue4hfSev/nM
 d2NnhQgIvaWggseQpKB2DIUqiJKyseg5JHsJBW/ss7VzY2vJPKz0YHzj9GCXW5pkilJt
 FyYmThFWBVlOdNBorQncyw1IaeKI4Wr5+do1PF0ABszi5Y9amQY0kJFUSjmlu6d1h5DF
 bOZPGcoS/UxZU1g1gbqYPUhKWVIMaSxfmzDTcqRNttcINrxeDLDsiAR+MwIhM8QogHnt
 Y2l3wOmuvJRGzSOmP724+PN1vO7BSw3haaO6YS5MjJrU6R2xXxeJBNAkRy8SxnwZDP/I
 33sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674012; x=1723278812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5b46Jki8r7GdhhaBXdWr4jTO2FIjDX3m44PUZVGmV7M=;
 b=m7adg2L//KKGbjT3SNlvqJCAv4YVMhyYufmBFuHwFH1PY6CJfsByqchMA+nCH/Jr73
 plGmd3+5g65Sn5D0tir4MtlMw/93TNzCDQ/hh56gZfAK5mQhg5NrM80mzSz+gAmwyLuN
 VarbfoJzcZkcMA3f5KqM7WTt+1Vl2JCHvTX9KTFHwFc+GCsEMOga3W4nlOj7fuCfrdPJ
 ESlOJqlNg2MDYAyZySl6mt2XE3q+iFcaTcX8nwzomOl4X40z/cVmmwvX18gFwNDwKQXj
 EdOPowH0H1zY6Z+En4jG1GpV3xsUiOzwlBzwSsPtgK+EwLeH6SGIFBA8aZ8CcI/TlVEh
 lrlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBZsYXUYJMVOgC7Z/kzdlrjADUFW9bQ1gsDQDWIAs52y4IJUg4ThndH7k5jDcsTHOsTHV8QlKzAGIvkB6KQw2xVh17A==
X-Gm-Message-State: AOJu0YzS2GHahZUwRkPTJHFzbL5XRyuOmfOHQx7+RxN1l3swCSth2zgs
 +THlGp8zZmvl7LlxOEOjuS2+12MdqyZUDAK5Xv7Js7Wm24CWLdz0
X-Google-Smtp-Source: AGHT+IFfWvbVM2bvSNeHwd2S0OL6jf5L+3AbpSahRJ/GTf6q3lt0J9weyfOrwFV1CgtXF1VheOa7pg==
X-Received: by 2002:a05:600c:3c82:b0:426:6220:cb57 with SMTP id
 5b1f17b1804b1-428e6b7c53bmr33993765e9.25.1722674012047; 
 Sat, 03 Aug 2024 01:33:32 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 09/13] clk: mediatek: mt7988: drop 1/1 spurious factor for
 topckgen
Date: Sat,  3 Aug 2024 10:32:58 +0200
Message-ID: <20240803083305.30697-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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
ID match the ID in upstream include for mt7988.

Drop the factor entry from mt7988-clk.h and reference to them in
mt7988.dtsi. Muxes and gates are updated to reference the apmixed clk
following how it's done in upstream kernel linux. Add relevant clk type
flag in clk_tree for apmixed and topckgen.

Also move TOP_XTAL to the fixed clock table following how it's done in
upstream linux kernel.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      | 412 +++++++++++++------------
 include/dt-bindings/clock/mt7988-clk.h | 244 +++++++--------
 2 files changed, 321 insertions(+), 335 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 24dc3299e11..4c94cda2b23 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -49,63 +49,28 @@ static const struct mtk_fixed_clk apmixedsys_mtk_plls[] = {
 	FIXED_CLK(CK_APMIXED_MSDCPLL, CLK_XTAL, 400000000),
 };
 
+/* TOPCKGEN FIXED CLK */
+static const struct mtk_fixed_clk topckgen_mtk_fixed_clks[] = {
+	FIXED_CLK(CK_TOP_XTAL, CLK_XTAL, 40000000),
+};
+
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
-	XTAL_FACTOR(CK_TOP_XTAL, "xtal", CLK_XTAL, 1, 1),
 	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL, 1, 2),
 	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
 		   1250),
 	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
-	TOP_FACTOR(CK_TOP_INFRA_F32K, "csw_infra_f32k", CK_TOP_RTC_32P7K, 1,
-		   1),
-	XTAL_FACTOR(CK_TOP_CKSQ_SRC, "cksq_src", CLK_XTAL, 1, 1),
-	TOP_FACTOR(CK_TOP_NETSYS_2X, "netsys_2x", CK_TOP_NETSYS_2X_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_NETSYS_GSW, "netsys_gsw", CK_TOP_NETSYS_GSW_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_NETSYS_WED_MCU, "netsys_wed_mcu",
-		   CK_TOP_NETSYS_MCU_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EIP197, "eip197", CK_TOP_EIP197_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EMMC_250M, "emmc_250m", CK_TOP_EMMC_250M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_EMMC_400M, "emmc_400m", CK_TOP_EMMC_400M_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_SPI, "spi", CK_TOP_SPI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_SPIM_MST, "spim_mst", CK_TOP_SPIM_MST_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_SPINFI_BCK, "spinfi_bck", CK_TOP_SPINFI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_I2C_BCK, "i2c_bck", CK_TOP_I2C_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_SYS, "usb_sys", CK_TOP_USB_SYS_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_SYS_P1, "usb_sys_p1", CK_TOP_USB_SYS_P1_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_USB_XHCI, "usb_xhci", CK_TOP_USB_XHCI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_XHCI_P1, "usb_xhci_p1", CK_TOP_USB_XHCI_P1_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_USB_FRMCNT, "usb_frmcnt", CK_TOP_USB_FRMCNT_SEL, 1,
-		   1),
-	TOP_FACTOR(CK_TOP_USB_FRMCNT_P1, "usb_frmcnt_p1",
-		   CK_TOP_USB_FRMCNT_P1_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_AUD, "aud", CK_TOP_AUD_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_A1SYS, "a1sys", CK_TOP_A1SYS_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_AUD_L, "aud_l", CK_TOP_AUD_L_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_SYSAXI, "sysaxi", CK_TOP_SYSAXI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_INFRA_F26M, "csw_infra_f26m", CK_TOP_INFRA_F26M_SEL,
-		   1, 1),
-	TOP_FACTOR(CK_TOP_USB_REF, "usb_ref", CK_TOP_CKSQ_SRC, 1, 1),
-	TOP_FACTOR(CK_TOP_USB_CK_P1, "usb_ck_p1", CK_TOP_CKSQ_SRC, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
 	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
 	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
-	PLL_FACTOR(CK_TOP_CB_MMPLL_720M, "cb_mmpll_720m", CK_APMIXED_MMPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", CK_APMIXED_MMPLL, 1, 15),
 	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
 	PLL_FACTOR(CK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", CK_APMIXED_MMPLL, 1, 12),
 	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_APLL2_196M, "cb_apll2_196m", CK_APMIXED_APLL2, 1,
-		   1),
 	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
 	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
 	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
@@ -117,143 +82,196 @@ static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] = {
 	PLL_FACTOR(CK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", CK_APMIXED_NET1PLL, 1, 64),
 	PLL_FACTOR(CK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", CK_APMIXED_NET1PLL, 1,
 		   128),
-	PLL_FACTOR(CK_TOP_NET2PLL_800M, "cb_net2pll_800m", CK_APMIXED_NET2PLL, 1,
-		   1),
 	PLL_FACTOR(CK_TOP_NET2PLL_D2, "net2pll_d2", CK_APMIXED_NET2PLL, 1, 2),
 	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
 	PLL_FACTOR(CK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CK_APMIXED_NET2PLL, 1, 16),
 	PLL_FACTOR(CK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CK_APMIXED_NET2PLL, 1, 32),
 	PLL_FACTOR(CK_TOP_NET2PLL_D6, "net2pll_d6", CK_APMIXED_NET2PLL, 1, 6),
 	PLL_FACTOR(CK_TOP_NET2PLL_D8, "net2pll_d8", CK_APMIXED_NET2PLL, 1, 8),
-	PLL_FACTOR(CK_TOP_CB_WEDMCUPLL_208M, "cb_wedmcupll_208m",
-		   CK_APMIXED_WEDMCUPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_SGM_325M, "cb_sgm_325m", CK_APMIXED_SGMPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_NETSYSPLL_850M, "cb_netsyspll_850m",
-		   CK_APMIXED_NETSYSPLL, 1, 1),
-	PLL_FACTOR(CK_TOP_CB_MSDCPLL_400M, "cb_msdcpll_400m", CK_APMIXED_MSDCPLL, 1,
-		   1),
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int netsys_parents[] = { CK_TOP_XTAL, CK_TOP_NET2PLL_D2,
-				      CK_TOP_MMPLL_D2 };
+#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
+#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
 
-static const int netsys_500m_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET1PLL_D5,
-					   CK_TOP_NET1PLL_D5_D2 };
+static const struct mtk_parent netsys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D2),
+};
 
-static const int netsys_2x_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_NET2PLL_800M,
-					 CK_TOP_CB_MMPLL_720M };
+static const struct mtk_parent netsys_500m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
+	TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
+};
 
-static const int netsys_gsw_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D4,
-					  CK_TOP_NET1PLL_D5 };
+static const struct mtk_parent netsys_2x_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
+	APMIXED_PARENT(CK_APMIXED_MMPLL),
+};
 
-static const int eth_gmii_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4 };
+static const struct mtk_parent netsys_gsw_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D4),
+	TOP_PARENT(CK_TOP_NET1PLL_D5),
+};
 
-static const int netsys_mcu_parents[] = {
-	CK_TOP_XTAL, CK_TOP_NET2PLL_800M, CK_TOP_CB_MMPLL_720M,
-	CK_TOP_NET1PLL_D4,  CK_TOP_NET1PLL_D5,   CK_TOP_CB_MPLL_416M
+static const struct mtk_parent eth_gmii_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
 };
 
-static const int eip197_parents[] = {
-	CK_TOP_XTAL, CK_TOP_CB_NETSYSPLL_850M, CK_TOP_NET2PLL_800M,
-	CK_TOP_CB_MMPLL_720M,  CK_TOP_NET1PLL_D4,     CK_TOP_NET1PLL_D5
+static const struct mtk_parent netsys_mcu_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
+	APMIXED_PARENT(CK_APMIXED_MMPLL), TOP_PARENT(CK_TOP_NET1PLL_D4),
+	TOP_PARENT(CK_TOP_NET1PLL_D5), APMIXED_PARENT(CK_APMIXED_MPLL),
 };
 
-static const int axi_infra_parents[] = { CK_TOP_XTAL,
-					 CK_TOP_NET1PLL_D8_D2 };
+static const struct mtk_parent eip197_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NETSYSPLL),
+	APMIXED_PARENT(CK_APMIXED_NET2PLL), APMIXED_PARENT(CK_APMIXED_MMPLL),
+	TOP_PARENT(CK_TOP_NET1PLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D5),
+};
 
-static const int uart_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D8,
-				    CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent axi_infra_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+};
 
-static const int emmc_250m_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D2,
-					 CK_TOP_MMPLL_D4 };
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int emmc_400m_parents[] = {
-	CK_TOP_XTAL, CK_TOP_CB_MSDCPLL_400M, CK_TOP_MMPLL_D2,
-	CK_TOP_MPLL_D2,     CK_TOP_MMPLL_D4,     CK_TOP_NET1PLL_D8_D2
+static const struct mtk_parent emmc_250m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D4),
 };
 
-static const int spi_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
-				   CK_TOP_MMPLL_D4,    CK_TOP_NET1PLL_D8_D2,
-				   CK_TOP_NET2PLL_D6,  CK_TOP_NET1PLL_D5_D4,
-				   CK_TOP_MPLL_D4,     CK_TOP_NET1PLL_D8_D4 };
+static const struct mtk_parent emmc_400m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_MSDCPLL),
+	TOP_PARENT(CK_TOP_MMPLL_D2), TOP_PARENT(CK_TOP_MPLL_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+};
 
-static const int nfi1x_parents[] = { CK_TOP_XTAL, CK_TOP_MMPLL_D4,
-				     CK_TOP_NET1PLL_D8_D2,  CK_TOP_NET2PLL_D6,
-				     CK_TOP_MPLL_D4,     CK_TOP_MMPLL_D8,
-				     CK_TOP_NET1PLL_D8_D4,  CK_TOP_MPLL_D8 };
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
+	TOP_PARENT(CK_TOP_MMPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CK_TOP_NET2PLL_D6), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+};
 
-static const int spinfi_parents[] = { CK_TOP_XTAL_D2, CK_TOP_XTAL,
-				      CK_TOP_NET1PLL_D5_D4,  CK_TOP_MPLL_D4,
-				      CK_TOP_MMPLL_D8,    CK_TOP_NET1PLL_D8_D4,
-				      CK_TOP_MMPLL_D6_D2,    CK_TOP_MPLL_D8 };
+static const struct mtk_parent nfi1x_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D4),
+	TOP_PARENT(CK_TOP_NET1PLL_D8_D2), TOP_PARENT(CK_TOP_NET2PLL_D6),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_MMPLL_D8),
+	TOP_PARENT(CK_TOP_NET1PLL_D8_D4), TOP_PARENT(CK_TOP_MPLL_D8),
+};
 
-static const int pwm_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D8_D2,
-				   CK_TOP_NET1PLL_D5_D4,  CK_TOP_MPLL_D4,
-				   CK_TOP_MPLL_D8_D2,     CK_TOP_RTC_32K };
+static const struct mtk_parent spinfi_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_XTAL),
+	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
+	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+	TOP_PARENT(CK_TOP_MMPLL_D6_D2), TOP_PARENT(CK_TOP_MPLL_D8),
+};
 
-static const int i2c_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5_D4,
-				   CK_TOP_MPLL_D4, CK_TOP_NET1PLL_D8_D4 };
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
+	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2), TOP_PARENT(CK_TOP_RTC_32K),
+};
 
-static const int pcie_mbist_250m_parents[] = { CK_TOP_XTAL,
-					       CK_TOP_NET1PLL_D5_D2 };
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
+	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+};
 
-static const int pextp_tl_ck_parents[] = { CK_TOP_XTAL,
-					   CK_TOP_NET2PLL_D6, CK_TOP_MMPLL_D8,
-					   CK_TOP_MPLL_D8_D2, CK_TOP_RTC_32K };
+static const struct mtk_parent pcie_mbist_250m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
+};
+
+static const struct mtk_parent pextp_tl_ck_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D6),
+	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_MPLL_D8_D2),
+	TOP_PARENT(CK_TOP_RTC_32K),
+};
 
-static const int usb_frmcnt_parents[] = { CK_TOP_XTAL,
-					  CK_TOP_MMPLL_D3_D5 };
+static const struct mtk_parent usb_frmcnt_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D3_D5),
+};
 
-static const int aud_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M };
+static const struct mtk_parent aud_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
+};
 
-static const int a1sys_parents[] = { CK_TOP_XTAL, CK_TOP_APLL2_D4 };
+static const struct mtk_parent a1sys_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
+};
 
-static const int aud_l_parents[] = { CK_TOP_XTAL, CK_TOP_CB_APLL2_196M,
-				     CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent aud_l_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
+	TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int sspxtp_parents[] = { CK_TOP_XTAL_D2, CK_TOP_MPLL_D8_D2 };
+static const struct mtk_parent sspxtp_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_MPLL_D8_D2),
+};
 
-static const int usxgmii_sbus_0_parents[] = { CK_TOP_XTAL,
-					      CK_TOP_NET1PLL_D8_D4 };
+static const struct mtk_parent usxgmii_sbus_0_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
+};
 
-static const int sgm_0_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M };
+static const struct mtk_parent sgm_0_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
+};
 
-static const int sysapb_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D3_D2 };
+static const struct mtk_parent sysapb_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D3_D2),
+};
 
-static const int eth_refck_50m_parents[] = { CK_TOP_XTAL,
-					     CK_TOP_NET2PLL_D4_D4 };
+static const struct mtk_parent eth_refck_50m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D4_D4),
+};
 
-static const int eth_sys_200m_parents[] = { CK_TOP_XTAL,
-					    CK_TOP_NET2PLL_D4 };
+static const struct mtk_parent eth_sys_200m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D4),
+};
 
-static const int eth_xgmii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET1PLL_D8_D8,
-					 CK_TOP_NET1PLL_D8_D16 };
+static const struct mtk_parent eth_xgmii_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_NET1PLL_D8_D8),
+	TOP_PARENT(CK_TOP_NET1PLL_D8_D16),
+};
 
-static const int bus_tops_parents[] = { CK_TOP_XTAL, CK_TOP_NET1PLL_D5,
-					CK_TOP_NET2PLL_D2 };
+static const struct mtk_parent bus_tops_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
+	TOP_PARENT(CK_TOP_NET2PLL_D2),
+};
 
-static const int npu_tops_parents[] = { CK_TOP_XTAL,
-					CK_TOP_NET2PLL_800M };
+static const struct mtk_parent npu_tops_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
+};
 
-static const int dramc_md32_parents[] = { CK_TOP_XTAL, CK_TOP_MPLL_D2,
-					  CK_TOP_CB_WEDMCUPLL_208M };
+static const struct mtk_parent dramc_md32_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
+	APMIXED_PARENT(CK_APMIXED_WEDMCUPLL),
+};
 
-static const int da_xtp_glb_p0_parents[] = { CK_TOP_XTAL,
-					     CK_TOP_NET2PLL_D8 };
+static const struct mtk_parent da_xtp_glb_p0_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D8),
+};
 
-static const int mcusys_backup_625m_parents[] = { CK_TOP_XTAL,
-						  CK_TOP_NET1PLL_D4 };
+static const struct mtk_parent mcusys_backup_625m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D4),
+};
 
-static const int macsec_parents[] = { CK_TOP_XTAL, CK_TOP_CB_SGM_325M,
-				      CK_TOP_NET1PLL_D8 };
+static const struct mtk_parent macsec_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
+	TOP_PARENT(CK_TOP_NET1PLL_D8),
+};
 
-static const int netsys_tops_400m_parents[] = { CK_TOP_XTAL,
-						CK_TOP_NET2PLL_D2 };
+static const struct mtk_parent netsys_tops_400m_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D2),
+};
 
-static const int eth_mii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET2PLL_D4_D8 };
+static const struct mtk_parent eth_mii_parents[] = {
+	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_NET2PLL_D4_D8),
+};
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -262,9 +280,9 @@ static const int eth_mii_parents[] = { CK_TOP_XTAL_D2, CK_TOP_NET2PLL_D4_D8 };
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
@@ -434,31 +452,31 @@ static const int infra_mux_uart1_parents[] = { CK_TOP_INFRA_F26M_SEL,
 static const int infra_mux_uart2_parents[] = { CK_TOP_INFRA_F26M_SEL,
 					       CK_TOP_UART_SEL };
 
-static const int infra_mux_spi0_parents[] = { CK_TOP_I2C_BCK, CK_TOP_SPI };
+static const int infra_mux_spi0_parents[] = { CK_TOP_I2C_SEL, CK_TOP_SPI_SEL };
 
-static const int infra_mux_spi1_parents[] = { CK_TOP_I2C_BCK, CK_TOP_SPIM_MST };
+static const int infra_mux_spi1_parents[] = { CK_TOP_I2C_SEL, CK_TOP_SPIM_MST_SEL };
 
-static const int infra_pwm_bck_parents[] = { CK_TOP_INFRA_F32K,
-					     CK_TOP_INFRA_F26M_SEL, CK_TOP_SYSAXI,
+static const int infra_pwm_bck_parents[] = { CK_TOP_RTC_32P7K,
+					     CK_TOP_INFRA_F26M_SEL, CK_TOP_SYSAXI_SEL,
 					     CK_TOP_PWM_SEL };
 
 static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
-	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
 	CK_TOP_PEXTP_TL_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
-	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
 	CK_TOP_PEXTP_TL_P1_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p2_parents[] = {
-	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
 	CK_TOP_PEXTP_TL_P2_SEL
 };
 
 static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
-	CK_TOP_INFRA_F32K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
+	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
 	CK_TOP_PEXTP_TL_P3_SEL
 };
 
@@ -590,17 +608,17 @@ static const struct mtk_gate_regs infra_3_cg_regs = {
 /* INFRA GATE */
 static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P0,
-			"infra_pcie_peri_ck_26m_ck_p0", CK_TOP_INFRA_F26M, 7),
+			"infra_pcie_peri_ck_26m_ck_p0", CK_TOP_INFRA_F26M_SEL, 7),
 	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P1,
-			"infra_pcie_peri_ck_26m_ck_p1", CK_TOP_INFRA_F26M, 8),
+			"infra_pcie_peri_ck_26m_ck_p1", CK_TOP_INFRA_F26M_SEL, 8),
 	GATE_INFRA0_INFRA(CK_INFRA_PCIE_PERI_26M_CK_P2,
 			  "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_PCIE_PERI_26M_CK_P3, 9),
 	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P3,
-			"infra_pcie_peri_ck_26m_ck_p3", CK_TOP_INFRA_F26M, 10),
+			"infra_pcie_peri_ck_26m_ck_p3", CK_TOP_INFRA_F26M_SEL, 10),
 	GATE_INFRA1_TOP(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
-			CK_TOP_SYSAXI, 0),
+			CK_TOP_SYSAXI_SEL, 0),
 	GATE_INFRA1_TOP(CK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
-			CK_TOP_SYSAXI, 1),
+			CK_TOP_SYSAXI_SEL, 1),
 	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_BCK, "infra_hf_66m_pwm_bck",
 			  CK_INFRA_PWM_SEL, 2),
 	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK1, "infra_hf_66m_pwm_ck1",
@@ -620,46 +638,46 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK8, "infra_hf_66m_pwm_ck8",
 			  CK_INFRA_PWM_CK8_SEL, 10),
 	GATE_INFRA1_TOP(CK_INFRA_133M_CQDMA_BCK, "infra_hf_133m_cqdma_bck",
-			CK_TOP_SYSAXI, 12),
+			CK_TOP_SYSAXI_SEL, 12),
 	GATE_INFRA1_TOP(CK_INFRA_66M_AUD_SLV_BCK, "infra_66m_aud_slv_bck",
-			CK_TOP_SYSAXI, 13),
+			CK_TOP_SYSAXI_SEL, 13),
 	GATE_INFRA1_TOP(CK_INFRA_AUD_26M, "infra_f_faud_26m", CK_TOP_INFRA_F26M_SEL, 14),
-	GATE_INFRA1_TOP(CK_INFRA_AUD_L, "infra_f_faud_l", CK_TOP_AUD_L, 15),
-	GATE_INFRA1_TOP(CK_INFRA_AUD_AUD, "infra_f_aud_aud", CK_TOP_A1SYS,
+	GATE_INFRA1_TOP(CK_INFRA_AUD_L, "infra_f_faud_l", CK_TOP_AUD_L_SEL, 15),
+	GATE_INFRA1_TOP(CK_INFRA_AUD_AUD, "infra_f_aud_aud", CK_TOP_A1SYS_SEL,
 			16),
-	GATE_INFRA1_TOP(CK_INFRA_AUD_EG2, "infra_f_faud_eg2", CK_TOP_A_TUNER,
+	GATE_INFRA1_TOP(CK_INFRA_AUD_EG2, "infra_f_faud_eg2", CK_TOP_A_TUNER_SEL,
 			18),
 	GATE_INFRA1_TOP(CK_INFRA_DRAMC_F26M, "infra_dramc_f26m", CK_TOP_INFRA_F26M_SEL,
 			19),
 	GATE_INFRA1_TOP(CK_INFRA_133M_DBG_ACKM, "infra_hf_133m_dbg_ackm",
-			CK_TOP_SYSAXI, 20),
+			CK_TOP_SYSAXI_SEL, 20),
 	GATE_INFRA1_TOP(CK_INFRA_66M_AP_DMA_BCK, "infra_66m_ap_dma_bck",
-			CK_TOP_SYSAXI, 21),
+			CK_TOP_SYSAXI_SEL, 21),
 	GATE_INFRA1_TOP(CK_INFRA_66M_SEJ_BCK, "infra_hf_66m_sej_bck",
-			CK_TOP_SYSAXI, 29),
+			CK_TOP_SYSAXI_SEL, 29),
 	GATE_INFRA1_TOP(CK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
 			CK_TOP_INFRA_F26M_SEL, 30),
-	GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSAXI,
+	GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSAXI_SEL,
 			31),
 	GATE_INFRA2_TOP(CK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system",
 			CK_TOP_INFRA_F26M_SEL, 0),
-	GATE_INFRA2_TOP(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_TOP_I2C_BCK, 1),
+	GATE_INFRA2_TOP(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_TOP_I2C_SEL, 1),
 	GATE_INFRA2_TOP(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
-			CK_TOP_SYSAXI, 3),
+			CK_TOP_SYSAXI_SEL, 3),
 	GATE_INFRA2_TOP(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
-			CK_TOP_SYSAXI, 4),
+			CK_TOP_SYSAXI_SEL, 4),
 	GATE_INFRA2_TOP(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
-			CK_TOP_SYSAXI, 5),
+			CK_TOP_SYSAXI_SEL, 5),
 	GATE_INFRA2_INFRA(CK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
 			  CK_INFRA_MUX_UART0_SEL, 3),
 	GATE_INFRA2_INFRA(CK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
 			  CK_INFRA_MUX_UART1_SEL, 4),
 	GATE_INFRA2_INFRA(CK_INFRA_52M_UART2_CK, "infra_f_52m_uart2",
 			  CK_INFRA_MUX_UART2_SEL, 5),
-	GATE_INFRA2_TOP(CK_INFRA_NFI, "infra_f_fnfi", CK_TOP_NFI1X, 9),
-	GATE_INFRA2_TOP(CK_INFRA_SPINFI, "infra_f_fspinfi", CK_TOP_SPINFI_BCK, 10),
+	GATE_INFRA2_TOP(CK_INFRA_NFI, "infra_f_fnfi", CK_TOP_NFI1X_SEL, 9),
+	GATE_INFRA2_TOP(CK_INFRA_SPINFI, "infra_f_fspinfi", CK_TOP_SPINFI_SEL, 10),
 	GATE_INFRA2_TOP(CK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck",
-			CK_TOP_SYSAXI, 11),
+			CK_TOP_SYSAXI_SEL, 11),
 	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI0, "infra_hf_104m_spi0",
 			  CK_INFRA_MUX_SPI0_SEL, 12),
 	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI1, "infra_hf_104m_spi1",
@@ -667,52 +685,52 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck",
 			  CK_INFRA_MUX_SPI2_SEL, 14),
 	GATE_INFRA2_TOP(CK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck",
-			CK_TOP_SYSAXI, 15),
+			CK_TOP_SYSAXI_SEL, 15),
 	GATE_INFRA2_TOP(CK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck",
-			CK_TOP_SYSAXI, 16),
+			CK_TOP_SYSAXI_SEL, 16),
 	GATE_INFRA2_TOP(CK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck",
-			CK_TOP_SYSAXI, 17),
+			CK_TOP_SYSAXI_SEL, 17),
 	GATE_INFRA2_TOP(CK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
-			CK_TOP_SYSAXI, 18),
+			CK_TOP_SYSAXI_SEL, 18),
 	GATE_INFRA2_TOP(CK_INFRA_RTC, "infra_f_frtc", CK_TOP_RTC_32K, 19),
 	GATE_INFRA2_TOP(CK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
-			CK_TOP_INFRA_F26M, 20),
+			CK_TOP_INFRA_F26M_SEL, 20),
 	GATE_INFRA2_INFRA(CK_INFRA_RC_ADC, "infra_f_frc_adc", CK_INFRA_26M_ADC_BCK,
 			  21),
-	GATE_INFRA2_TOP(CK_INFRA_MSDC400, "infra_f_fmsdc400", CK_TOP_EMMC_400M,
+	GATE_INFRA2_TOP(CK_INFRA_MSDC400, "infra_f_fmsdc400", CK_TOP_EMMC_400M_SEL,
 			22),
 	GATE_INFRA2_TOP(CK_INFRA_MSDC2_HCK, "infra_f_fmsdc2_hck",
-			CK_TOP_EMMC_250M, 23),
+			CK_TOP_EMMC_250M_SEL, 23),
 	GATE_INFRA2_TOP(CK_INFRA_133M_MSDC_0_HCK, "infra_hf_133m_msdc_0_hck",
-			CK_TOP_SYSAXI, 24),
+			CK_TOP_SYSAXI_SEL, 24),
 	GATE_INFRA2_TOP(CK_INFRA_66M_MSDC_0_HCK, "infra_66m_msdc_0_hck",
-			CK_TOP_SYSAXI, 25),
+			CK_TOP_SYSAXI_SEL, 25),
 	GATE_INFRA2_TOP(CK_INFRA_133M_CPUM_BCK, "infra_hf_133m_cpum_bck",
-			CK_TOP_SYSAXI, 26),
-	GATE_INFRA2_TOP(CK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CK_TOP_NFI1X,
+			CK_TOP_SYSAXI_SEL, 26),
+	GATE_INFRA2_TOP(CK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CK_TOP_NFI1X_SEL,
 			27),
 	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_MCK_CK_P1, "infra_hf_i2c_x16w_mck_ck_p1",
-			CK_TOP_SYSAXI, 29),
+			CK_TOP_SYSAXI_SEL, 29),
 	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_PCK_CK_P1, "infra_hf_i2c_x16w_pck_ck_p1",
-			CK_TOP_SYSAXI, 31),
+			CK_TOP_SYSAXI_SEL, 31),
 	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK, "infra_133m_usb_hck",
-			CK_TOP_SYSAXI, 0),
+			CK_TOP_SYSAXI_SEL, 0),
 	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK_CK_P1, "infra_133m_usb_hck_ck_p1",
-			CK_TOP_SYSAXI, 1),
+			CK_TOP_SYSAXI_SEL, 1),
 	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK, "infra_66m_usb_hck",
-			CK_TOP_SYSAXI, 2),
+			CK_TOP_SYSAXI_SEL, 2),
 	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK_CK_P1, "infra_66m_usb_hck_ck_p1",
-			CK_TOP_SYSAXI, 3),
-	GATE_INFRA3_TOP(CK_INFRA_USB_SYS, "infra_usb_sys", CK_TOP_USB_SYS, 4),
+			CK_TOP_SYSAXI_SEL, 3),
+	GATE_INFRA3_TOP(CK_INFRA_USB_SYS, "infra_usb_sys", CK_TOP_USB_SYS_SEL, 4),
 	GATE_INFRA3_TOP(CK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
-			CK_TOP_USB_SYS_P1, 5),
-	GATE_INFRA3_TOP(CK_INFRA_USB_REF, "infra_usb_ref", CK_TOP_USB_REF, 6),
-	GATE_INFRA3_TOP(CK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CK_TOP_USB_CK_P1,
-			7),
+			CK_TOP_USB_SYS_P1_SEL, 5),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_REF, "infra_usb_ref", CLK_XTAL, 6),
+	GATE_INFRA3_XTAL(CK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CLK_XTAL,
+			 7),
 	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
-			CK_TOP_USB_FRMCNT, 8),
+			CK_TOP_USB_FRMCNT_SEL, 8),
 	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
-			CK_TOP_USB_FRMCNT_P1, 9),
+			CK_TOP_USB_FRMCNT_P1_SEL, 9),
 	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_XTAL,
 			 10),
 	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
@@ -721,10 +739,10 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 			 12),
 	GATE_INFRA3_XTAL(CK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
 			 CLK_XTAL, 13),
-	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI, "infra_usb_xhci", CK_TOP_USB_XHCI,
+	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI, "infra_usb_xhci", CK_TOP_USB_XHCI_SEL,
 			14),
 	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
-			CK_TOP_USB_XHCI_P1, 15),
+			CK_TOP_USB_XHCI_P1_SEL, 15),
 	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P0, "infra_pcie_gfmux_tl_ck_p0",
 			  CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
 	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P1, "infra_pcie_gfmux_tl_ck_p1",
@@ -742,27 +760,29 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
 			 CLK_XTAL, 27),
 	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
-			CK_TOP_SYSAXI, 28),
+			CK_TOP_SYSAXI_SEL, 28),
 	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
-			CK_TOP_SYSAXI, 29),
+			CK_TOP_SYSAXI_SEL, 29),
 	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P2, "infra_133m_pcie_ck_p2",
-			CK_TOP_SYSAXI, 30),
+			CK_TOP_SYSAXI_SEL, 30),
 	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
-			CK_TOP_SYSAXI, 31),
+			CK_TOP_SYSAXI_SEL, 31),
 };
 
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
 	.fdivs_offs = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.fclks = apmixedsys_mtk_plls,
+	.flags = CLK_APMIXED,
 	.xtal_rate = 40 * MHZ,
 };
 
 static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
-	.fdivs_offs = CK_TOP_XTAL,
+	.fdivs_offs = CK_TOP_XTAL_D2,
 	.muxes_offs = CK_TOP_NETSYS_SEL,
+	.fclks = topckgen_mtk_fixed_clks,
 	.fdivs = topckgen_mtk_fixed_factors,
 	.muxes = topckgen_mtk_muxes,
-	.flags = CLK_BYPASS_XTAL,
+	.flags = CLK_BYPASS_XTAL | CLK_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -878,7 +898,7 @@ static const struct mtk_gate_regs ethdma_cg_regs = {
 	}
 
 static const struct mtk_gate ethdma_mtk_gate[] = {
-	GATE_ETHDMA(CK_ETHDMA_FE_EN, "ethdma_fe_en", CK_TOP_NETSYS_2X, 6),
+	GATE_ETHDMA(CK_ETHDMA_FE_EN, "ethdma_fe_en", CK_TOP_NETSYS_2X_SEL, 6),
 };
 
 static int mt7988_ethdma_probe(struct udevice *dev)
@@ -1022,11 +1042,11 @@ static const struct mtk_gate_regs ethwarp_cg_regs = {
 
 static const struct mtk_gate ethwarp_mtk_gate[] = {
 	GATE_ETHWARP(CK_ETHWARP_WOCPU2_EN, "ethwarp_wocpu2_en",
-		     CK_TOP_NETSYS_WED_MCU, 13),
+		     CK_TOP_NETSYS_MCU_SEL, 13),
 	GATE_ETHWARP(CK_ETHWARP_WOCPU1_EN, "ethwarp_wocpu1_en",
-		     CK_TOP_NETSYS_WED_MCU, 14),
+		     CK_TOP_NETSYS_MCU_SEL, 14),
 	GATE_ETHWARP(CK_ETHWARP_WOCPU0_EN, "ethwarp_wocpu0_en",
-		     CK_TOP_NETSYS_WED_MCU, 15),
+		     CK_TOP_NETSYS_MCU_SEL, 15),
 };
 
 static int mt7988_ethwarp_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 47ea13c04b8..b4b95a04087 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -120,147 +120,113 @@
 #define CK_INFRA_133M_PCIE_CK_P3     (148 - GATE_OFFSET) /* Linux CLK ID (98) */
 
 /* TOPCKGEN */
+/* mtk_fixed_clk */
+#define CK_TOP_XTAL		      0 /* Linux CLK ID (109) */
 /* mtk_fixed_factor */
-#define CK_TOP_XTAL_D2        0 /* Linux CLK ID (109) */
-#define CK_TOP_RTC_32K        1 /* Linux CLK ID (110) */
-#define CK_TOP_RTC_32P7K      2 /* Linux CLK ID (111) */
-#define CK_TOP_INFRA_F32K     3 /* Linux CLK ID (112) */
-#define CK_TOP_CKSQ_SRC	      4 /* Linux CLK ID (113) */
-#define CK_TOP_NETSYS_2X      5 /* Linux CLK ID (114) */
-#define CK_TOP_NETSYS_GSW     6 /* Linux CLK ID (115) */
-#define CK_TOP_NETSYS_WED_MCU 7 /* Linux CLK ID (116) */
-#define CK_TOP_EIP197	      8 /* Linux CLK ID (117) */
-#define CK_TOP_EMMC_250M      9 /* Linux CLK ID (118) */
-#define CK_TOP_EMMC_400M      10 /* Linux CLK ID (119) */
-#define CK_TOP_SPI	      11 /* Linux CLK ID (120) */
-#define CK_TOP_SPIM_MST	      12 /* Linux CLK ID (121) */
-#define CK_TOP_NFI1X	      13 /* Linux CLK ID (122) */
-#define CK_TOP_SPINFI_BCK     14 /* Linux CLK ID (123) */
-#define CK_TOP_I2C_BCK	      15 /* Linux CLK ID (124) */
-#define CK_TOP_USB_SYS	      16 /* Linux CLK ID (125) */
-#define CK_TOP_USB_SYS_P1     17 /* Linux CLK ID (126) */
-#define CK_TOP_USB_XHCI	      18 /* Linux CLK ID (127) */
-#define CK_TOP_USB_XHCI_P1    19 /* Linux CLK ID (128) */
-#define CK_TOP_USB_FRMCNT     20 /* Linux CLK ID (129) */
-#define CK_TOP_USB_FRMCNT_P1  21 /* Linux CLK ID (130) */
-#define CK_TOP_AUD	      22 /* Linux CLK ID (131) */
-#define CK_TOP_A1SYS	      23 /* Linux CLK ID (132) */
-#define CK_TOP_AUD_L	      24 /* Linux CLK ID (133) */
-#define CK_TOP_A_TUNER	      25 /* Linux CLK ID (134) */
-#define CK_TOP_SYSAXI	      26 /* Linux CLK ID (135) */
-#define CK_TOP_INFRA_F26M     27 /* Linux CLK ID (136) */
-#define CK_TOP_USB_REF	      28 /* Linux CLK ID (137) */
-#define CK_TOP_USB_CK_P1      29 /* Linux CLK ID (138) */
-#define CK_TOP_XTAL           30 /* Linux CLK ID (74) */
-#define CK_TOP_CB_MPLL_416M   31 /* Linux CLK ID (75) */
-#define CK_TOP_MPLL_D2	      32 /* Linux CLK ID (76) */
-#define CK_TOP_MPLL_D3_D2     33 /* Linux CLK ID (77) */
-#define CK_TOP_MPLL_D4	      35 /* Linux CLK ID (78) */
-#define CK_TOP_MPLL_D8	      34 /* Linux CLK ID (79) */
-#define CK_TOP_MPLL_D8_D2     36 /* Linux CLK ID (80) */
-#define CK_TOP_CB_MMPLL_720M  37 /* Linux CLK ID (81) */
-#define CK_TOP_MMPLL_D2	      38 /* Linux CLK ID (82) */
-#define CK_TOP_MMPLL_D3_D5    39 /* Linux CLK ID (83) */
-#define CK_TOP_MMPLL_D4	      40 /* Linux CLK ID (84) */
-#define CK_TOP_MMPLL_D6_D2    41 /* Linux CLK ID (85) */
-#define CK_TOP_MMPLL_D8	      42 /* Linux CLK ID (86) */
-#define CK_TOP_CB_APLL2_196M  43 /* Linux CLK ID (87) */
-#define CK_TOP_APLL2_D4       44 /* Linux CLK ID (88) */
-#define CK_TOP_NET1PLL_D4     45 /* Linux CLK ID (89) */
-#define CK_TOP_NET1PLL_D5     46 /* Linux CLK ID (90) */
-#define CK_TOP_NET1PLL_D5_D2  47 /* Linux CLK ID (91) */
-#define CK_TOP_NET1PLL_D5_D4  48 /* Linux CLK ID (92) */
-#define CK_TOP_NET1PLL_D8     49 /* Linux CLK ID (93) */
-#define CK_TOP_NET1PLL_D8_D2  50 /* Linux CLK ID (94) */
-#define CK_TOP_NET1PLL_D8_D4  51 /* Linux CLK ID (95) */
-#define CK_TOP_NET1PLL_D8_D8  52 /* Linux CLK ID (96) */
-#define CK_TOP_NET1PLL_D8_D16 53 /* Linux CLK ID (97) */
-#define CK_TOP_CB_NET2PLL_800M 54 /* Linux CLK ID (98) */
-#define CK_TOP_NET2PLL_D2     55 /* Linux CLK ID (99) */
-#define CK_TOP_NET2PLL_D4     56 /* Linux CLK ID (100) */
-#define CK_TOP_NET2PLL_D4_D4  57 /* Linux CLK ID (101) */
-#define CK_TOP_NET2PLL_D4_D8  58 /* Linux CLK ID (102) */
-#define CK_TOP_NET2PLL_D6     59 /* Linux CLK ID (103) */
-#define CK_TOP_NET2PLL_D8     60 /* Linux CLK ID (104) */
-#define CK_TOP_CB_WEDMCUPLL_208M 61 /* Linux CLK ID (105) */
-#define CK_TOP_CB_SGMPLL_325M 62 /* Linux CLK ID (106) */
-#define CK_TOP_CB_NETSYSPLL_850M 63 /* Linux CLK ID (107) */
-#define CK_TOP_CB_MSDCPLL_400M 64 /* Linux CLK ID (108) */
+#define CK_TOP_XTAL_D2		      1 /* Linux CLK ID (109) */
+#define CK_TOP_RTC_32K		      2 /* Linux CLK ID (110) */
+#define CK_TOP_RTC_32P7K	      3 /* Linux CLK ID (111) */
+#define CK_TOP_MPLL_D2		      4 /* Linux CLK ID (76) */
+#define CK_TOP_MPLL_D3_D2	      5 /* Linux CLK ID (77) */
+#define CK_TOP_MPLL_D4		      6 /* Linux CLK ID (78) */
+#define CK_TOP_MPLL_D8		      7 /* Linux CLK ID (79) */
+#define CK_TOP_MPLL_D8_D2	      8 /* Linux CLK ID (80) */
+#define CK_TOP_MMPLL_D2		      9 /* Linux CLK ID (82) */
+#define CK_TOP_MMPLL_D3_D5	      10 /* Linux CLK ID (83) */
+#define CK_TOP_MMPLL_D4		      11 /* Linux CLK ID (84) */
+#define CK_TOP_MMPLL_D6_D2	      12 /* Linux CLK ID (85) */
+#define CK_TOP_MMPLL_D8		      13 /* Linux CLK ID (86) */
+#define CK_TOP_APLL2_D4		      14 /* Linux CLK ID (88) */
+#define CK_TOP_NET1PLL_D4	      15 /* Linux CLK ID (89) */
+#define CK_TOP_NET1PLL_D5	      16 /* Linux CLK ID (90) */
+#define CK_TOP_NET1PLL_D5_D2	      17 /* Linux CLK ID (91) */
+#define CK_TOP_NET1PLL_D5_D4	      18 /* Linux CLK ID (92) */
+#define CK_TOP_NET1PLL_D8	      19 /* Linux CLK ID (93) */
+#define CK_TOP_NET1PLL_D8_D2	      20 /* Linux CLK ID (94) */
+#define CK_TOP_NET1PLL_D8_D4	      21 /* Linux CLK ID (95) */
+#define CK_TOP_NET1PLL_D8_D8	      22 /* Linux CLK ID (96) */
+#define CK_TOP_NET1PLL_D8_D16	      23 /* Linux CLK ID (97) */
+#define CK_TOP_NET2PLL_D2	      24 /* Linux CLK ID (99) */
+#define CK_TOP_NET2PLL_D4	      25 /* Linux CLK ID (100) */
+#define CK_TOP_NET2PLL_D4_D4	      26 /* Linux CLK ID (101) */
+#define CK_TOP_NET2PLL_D4_D8	      27 /* Linux CLK ID (102) */
+#define CK_TOP_NET2PLL_D6	      28 /* Linux CLK ID (103) */
+#define CK_TOP_NET2PLL_D8	      29 /* Linux CLK ID (104) */
 /* mtk_mux */
-#define CK_TOP_NETSYS_SEL	      65 /* Linux CLK ID (0) */
-#define CK_TOP_NETSYS_500M_SEL	      66 /* Linux CLK ID (1) */
-#define CK_TOP_NETSYS_2X_SEL	      67 /* Linux CLK ID (2) */
-#define CK_TOP_NETSYS_GSW_SEL	      68 /* Linux CLK ID (3) */
-#define CK_TOP_ETH_GMII_SEL	      69 /* Linux CLK ID (4) */
-#define CK_TOP_NETSYS_MCU_SEL	      70 /* Linux CLK ID (5) */
-#define CK_TOP_NETSYS_PAO_2X_SEL      71 /* Linux CLK ID (6) */
-#define CK_TOP_EIP197_SEL	      72 /* Linux CLK ID (7) */
-#define CK_TOP_AXI_INFRA_SEL	      73 /* Linux CLK ID (8) */
-#define CK_TOP_UART_SEL		      74 /* Linux CLK ID (9) */
-#define CK_TOP_EMMC_250M_SEL	      75 /* Linux CLK ID (10) */
-#define CK_TOP_EMMC_400M_SEL	      76 /* Linux CLK ID (11) */
-#define CK_TOP_SPI_SEL		      77 /* Linux CLK ID (12) */
-#define CK_TOP_SPIM_MST_SEL	      78 /* Linux CLK ID (13) */
-#define CK_TOP_NFI1X_SEL	      79 /* Linux CLK ID (14) */
-#define CK_TOP_SPINFI_SEL	      80 /* Linux CLK ID (15) */
-#define CK_TOP_PWM_SEL		      81 /* Linux CLK ID (16) */
-#define CK_TOP_I2C_SEL		      82 /* Linux CLK ID (17) */
-#define CK_TOP_PCIE_MBIST_250M_SEL    83 /* Linux CLK ID (18) */
-#define CK_TOP_PEXTP_TL_SEL	      84 /* Linux CLK ID (19) */
-#define CK_TOP_PEXTP_TL_P1_SEL	      85 /* Linux CLK ID (20) */
-#define CK_TOP_PEXTP_TL_P2_SEL	      86 /* Linux CLK ID (21) */
-#define CK_TOP_PEXTP_TL_P3_SEL	      87 /* Linux CLK ID (22) */
-#define CK_TOP_USB_SYS_SEL	      88 /* Linux CLK ID (23) */
-#define CK_TOP_USB_SYS_P1_SEL	      89 /* Linux CLK ID (24) */
-#define CK_TOP_USB_XHCI_SEL	      90 /* Linux CLK ID (25) */
-#define CK_TOP_USB_XHCI_P1_SEL	      91 /* Linux CLK ID (26) */
-#define CK_TOP_USB_FRMCNT_SEL	      92 /* Linux CLK ID (27) */
-#define CK_TOP_USB_FRMCNT_P1_SEL      93 /* Linux CLK ID (28) */
-#define CK_TOP_AUD_SEL		      94 /* Linux CLK ID (29) */
-#define CK_TOP_A1SYS_SEL	      95 /* Linux CLK ID (30) */
-#define CK_TOP_AUD_L_SEL	      96 /* Linux CLK ID (31) */
-#define CK_TOP_A_TUNER_SEL	      97 /* Linux CLK ID (32) */
-#define CK_TOP_SSPXTP_SEL	      98 /* Linux CLK ID (33) */
-#define CK_TOP_USB_PHY_SEL	      99 /* Linux CLK ID (34) */
-#define CK_TOP_USXGMII_SBUS_0_SEL     100 /* Linux CLK ID (35) */
-#define CK_TOP_USXGMII_SBUS_1_SEL     101 /* Linux CLK ID (36) */
-#define CK_TOP_SGM_0_SEL	      102 /* Linux CLK ID (37) */
-#define CK_TOP_SGM_SBUS_0_SEL	      103 /* Linux CLK ID (38) */
-#define CK_TOP_SGM_1_SEL	      104 /* Linux CLK ID (39) */
-#define CK_TOP_SGM_SBUS_1_SEL	      105 /* Linux CLK ID (40) */
-#define CK_TOP_XFI_PHY_0_XTAL_SEL     106 /* Linux CLK ID (41) */
-#define CK_TOP_XFI_PHY_1_XTAL_SEL     107 /* Linux CLK ID (42) */
-#define CK_TOP_SYSAXI_SEL	      108 /* Linux CLK ID (43) */
-#define CK_TOP_SYSAPB_SEL	      109 /* Linux CLK ID (44) */
-#define CK_TOP_ETH_REFCK_50M_SEL      110 /* Linux CLK ID (45) */
-#define CK_TOP_ETH_SYS_200M_SEL	      111 /* Linux CLK ID (46) */
-#define CK_TOP_ETH_SYS_SEL	      112 /* Linux CLK ID (47) */
-#define CK_TOP_ETH_XGMII_SEL	      113 /* Linux CLK ID (48) */
-#define CK_TOP_BUS_TOPS_SEL	      114 /* Linux CLK ID (49) */
-#define CK_TOP_NPU_TOPS_SEL	      115 /* Linux CLK ID (50) */
-#define CK_TOP_DRAMC_SEL	      116 /* Linux CLK ID (51) */
-#define CK_TOP_DRAMC_MD32_SEL	      117 /* Linux CLK ID (52) */
-#define CK_TOP_INFRA_F26M_SEL	      118 /* Linux CLK ID (53) */
-#define CK_TOP_PEXTP_P0_SEL	      119 /* Linux CLK ID (54) */
-#define CK_TOP_PEXTP_P1_SEL	      120 /* Linux CLK ID (55) */
-#define CK_TOP_PEXTP_P2_SEL	      121 /* Linux CLK ID (56) */
-#define CK_TOP_PEXTP_P3_SEL	      122 /* Linux CLK ID (57) */
-#define CK_TOP_DA_XTP_GLB_P0_SEL      123 /* Linux CLK ID (58) */
-#define CK_TOP_DA_XTP_GLB_P1_SEL      124 /* Linux CLK ID (59) */
-#define CK_TOP_DA_XTP_GLB_P2_SEL      125 /* Linux CLK ID (60) */
-#define CK_TOP_DA_XTP_GLB_P3_SEL      126 /* Linux CLK ID (61) */
-#define CK_TOP_CKM_SEL		      127 /* Linux CLK ID (62) */
-#define CK_TOP_DA_SEL		      128 /* Linux CLK ID (63) */
-#define CK_TOP_PEXTP_SEL	      129 /* Linux CLK ID (64) */
-#define CK_TOP_TOPS_P2_26M_SEL	      130 /* Linux CLK ID (65) */
-#define CK_TOP_MCUSYS_BACKUP_625M_SEL 131 /* Linux CLK ID (66) */
-#define CK_TOP_NETSYS_SYNC_250M_SEL   132 /* Linux CLK ID (67) */
-#define CK_TOP_MACSEC_SEL	      133 /* Linux CLK ID (68) */
-#define CK_TOP_NETSYS_TOPS_400M_SEL   134 /* Linux CLK ID (69) */
-#define CK_TOP_NETSYS_PPEFB_250M_SEL  135 /* Linux CLK ID (70) */
-#define CK_TOP_NETSYS_WARP_SEL	      136 /* Linux CLK ID (71) */
-#define CK_TOP_ETH_MII_SEL	      137 /* Linux CLK ID (72) */
-#define CK_TOP_NPU_SEL		      138 /* Linux CLK ID (73) */
+#define CK_TOP_NETSYS_SEL	      30 /* Linux CLK ID (0) */
+#define CK_TOP_NETSYS_500M_SEL	      31 /* Linux CLK ID (1) */
+#define CK_TOP_NETSYS_2X_SEL	      32 /* Linux CLK ID (2) */
+#define CK_TOP_NETSYS_GSW_SEL	      33 /* Linux CLK ID (3) */
+#define CK_TOP_ETH_GMII_SEL	      34 /* Linux CLK ID (4) */
+#define CK_TOP_NETSYS_MCU_SEL	      35 /* Linux CLK ID (5) */
+#define CK_TOP_NETSYS_PAO_2X_SEL      36 /* Linux CLK ID (6) */
+#define CK_TOP_EIP197_SEL	      37 /* Linux CLK ID (7) */
+#define CK_TOP_AXI_INFRA_SEL	      38 /* Linux CLK ID (8) */
+#define CK_TOP_UART_SEL		      39 /* Linux CLK ID (9) */
+#define CK_TOP_EMMC_250M_SEL	      40 /* Linux CLK ID (10) */
+#define CK_TOP_EMMC_400M_SEL	      41 /* Linux CLK ID (11) */
+#define CK_TOP_SPI_SEL		      42 /* Linux CLK ID (12) */
+#define CK_TOP_SPIM_MST_SEL	      43 /* Linux CLK ID (13) */
+#define CK_TOP_NFI1X_SEL	      44 /* Linux CLK ID (14) */
+#define CK_TOP_SPINFI_SEL	      45 /* Linux CLK ID (15) */
+#define CK_TOP_PWM_SEL		      46 /* Linux CLK ID (16) */
+#define CK_TOP_I2C_SEL		      47 /* Linux CLK ID (17) */
+#define CK_TOP_PCIE_MBIST_250M_SEL    48 /* Linux CLK ID (18) */
+#define CK_TOP_PEXTP_TL_SEL	      49 /* Linux CLK ID (19) */
+#define CK_TOP_PEXTP_TL_P1_SEL	      50 /* Linux CLK ID (20) */
+#define CK_TOP_PEXTP_TL_P2_SEL	      51 /* Linux CLK ID (21) */
+#define CK_TOP_PEXTP_TL_P3_SEL	      52 /* Linux CLK ID (22) */
+#define CK_TOP_USB_SYS_SEL	      53 /* Linux CLK ID (23) */
+#define CK_TOP_USB_SYS_P1_SEL	      54 /* Linux CLK ID (24) */
+#define CK_TOP_USB_XHCI_SEL	      55 /* Linux CLK ID (25) */
+#define CK_TOP_USB_XHCI_P1_SEL	      56 /* Linux CLK ID (26) */
+#define CK_TOP_USB_FRMCNT_SEL	      57 /* Linux CLK ID (27) */
+#define CK_TOP_USB_FRMCNT_P1_SEL      58 /* Linux CLK ID (28) */
+#define CK_TOP_AUD_SEL		      59 /* Linux CLK ID (29) */
+#define CK_TOP_A1SYS_SEL	      60 /* Linux CLK ID (30) */
+#define CK_TOP_AUD_L_SEL	      61 /* Linux CLK ID (31) */
+#define CK_TOP_A_TUNER_SEL	      62 /* Linux CLK ID (32) */
+#define CK_TOP_SSPXTP_SEL	      63 /* Linux CLK ID (33) */
+#define CK_TOP_USB_PHY_SEL	      64 /* Linux CLK ID (34) */
+#define CK_TOP_USXGMII_SBUS_0_SEL     65 /* Linux CLK ID (35) */
+#define CK_TOP_USXGMII_SBUS_1_SEL     66 /* Linux CLK ID (36) */
+#define CK_TOP_SGM_0_SEL	      67 /* Linux CLK ID (37) */
+#define CK_TOP_SGM_SBUS_0_SEL	      68 /* Linux CLK ID (38) */
+#define CK_TOP_SGM_1_SEL	      69 /* Linux CLK ID (39) */
+#define CK_TOP_SGM_SBUS_1_SEL	      70 /* Linux CLK ID (40) */
+#define CK_TOP_XFI_PHY_0_XTAL_SEL     71 /* Linux CLK ID (41) */
+#define CK_TOP_XFI_PHY_1_XTAL_SEL     72 /* Linux CLK ID (42) */
+#define CK_TOP_SYSAXI_SEL	      73 /* Linux CLK ID (43) */
+#define CK_TOP_SYSAPB_SEL	      74 /* Linux CLK ID (44) */
+#define CK_TOP_ETH_REFCK_50M_SEL      75 /* Linux CLK ID (45) */
+#define CK_TOP_ETH_SYS_200M_SEL	      76 /* Linux CLK ID (46) */
+#define CK_TOP_ETH_SYS_SEL	      77 /* Linux CLK ID (47) */
+#define CK_TOP_ETH_XGMII_SEL	      78 /* Linux CLK ID (48) */
+#define CK_TOP_BUS_TOPS_SEL	      79 /* Linux CLK ID (49) */
+#define CK_TOP_NPU_TOPS_SEL	      80 /* Linux CLK ID (50) */
+#define CK_TOP_DRAMC_SEL	      81 /* Linux CLK ID (51) */
+#define CK_TOP_DRAMC_MD32_SEL	      82 /* Linux CLK ID (52) */
+#define CK_TOP_INFRA_F26M_SEL	      83 /* Linux CLK ID (53) */
+#define CK_TOP_PEXTP_P0_SEL	      84 /* Linux CLK ID (54) */
+#define CK_TOP_PEXTP_P1_SEL	      85 /* Linux CLK ID (55) */
+#define CK_TOP_PEXTP_P2_SEL	      86 /* Linux CLK ID (56) */
+#define CK_TOP_PEXTP_P3_SEL	      87 /* Linux CLK ID (57) */
+#define CK_TOP_DA_XTP_GLB_P0_SEL      88 /* Linux CLK ID (58) */
+#define CK_TOP_DA_XTP_GLB_P1_SEL      89 /* Linux CLK ID (59) */
+#define CK_TOP_DA_XTP_GLB_P2_SEL      90 /* Linux CLK ID (60) */
+#define CK_TOP_DA_XTP_GLB_P3_SEL      91 /* Linux CLK ID (61) */
+#define CK_TOP_CKM_SEL		      92 /* Linux CLK ID (62) */
+#define CK_TOP_DA_SEL		      93 /* Linux CLK ID (63) */
+#define CK_TOP_PEXTP_SEL	      94 /* Linux CLK ID (64) */
+#define CK_TOP_TOPS_P2_26M_SEL	      95 /* Linux CLK ID (65) */
+#define CK_TOP_MCUSYS_BACKUP_625M_SEL 96 /* Linux CLK ID (66) */
+#define CK_TOP_NETSYS_SYNC_250M_SEL   97 /* Linux CLK ID (67) */
+#define CK_TOP_MACSEC_SEL	      98 /* Linux CLK ID (68) */
+#define CK_TOP_NETSYS_TOPS_400M_SEL   99 /* Linux CLK ID (69) */
+#define CK_TOP_NETSYS_PPEFB_250M_SEL  100 /* Linux CLK ID (70) */
+#define CK_TOP_NETSYS_WARP_SEL	      101 /* Linux CLK ID (71) */
+#define CK_TOP_ETH_MII_SEL	      102 /* Linux CLK ID (72) */
+#define CK_TOP_NPU_SEL		      103 /* Linux CLK ID (73) */
 
 /* APMIXEDSYS */
 /* mtk_pll_data */
-- 
2.45.2

