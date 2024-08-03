Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE9BC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CA488C9D;
	Sat,  3 Aug 2024 13:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYRu8hTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0619E88C42; Sat,  3 Aug 2024 13:10:49 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024BA88BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso4635232f8f.1
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683446; x=1723288246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KtQzhJjiroNt4FjNOBjTmr7/KpvNOnlt6GMBCEIY71c=;
 b=DYRu8hToiYXbPQHTak3DvHwm1Av+SVIdTMz9p9M3HwHjusNT4C9v5Y8JzxzCAYgojZ
 zGCRU5HcSHQtaPfPE1WSgbYxbR78AVsUU42B6RmvIUexUgP4Hx6Fb8lbK2U5OkU/ysjl
 fjTJKamwHsy/iY7Gcy1WogVYNizIOX5XGfTRpB8lm15jjGxYfK0SXWKieBXNPmjyQgMp
 a2bhOZnO2NCUcKFgLxFf+i0xa5RTiVewrmOkDpebz1tZhp+RsDDEgR0WCsSBoECcT+Th
 0Bj93ex+VjQVcjZ7Jt4dpVSIiy1xS4UqOkkZcP2+uHo9jhH+qhsAIB4lnAAfF4j+ZjkW
 HQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683446; x=1723288246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtQzhJjiroNt4FjNOBjTmr7/KpvNOnlt6GMBCEIY71c=;
 b=p3cYQQR9o1ctEdUYBjuY8lBEbulReTAatjpyk2cWqm/PyvD2Vf92rFaj4L+8R5SYJw
 laLIrxMoIedpb1k2Cw2Nwk4dBvDRSkhIvul3VvA4D3ARGsR81H7BRRckwa+1W4jn3FdS
 khjsZZeqIJRSMy5ls46dwhc+9po+3miRhhnrBmU3hqVGURmd6aQ82ZPlTBWnwzZ0O/ya
 CEMfzD5KErPt2pY12H9FdduACQKPTzgKIrYUR1/1rP9DH1KB86KXpQcHN6qXQdEClvv1
 xiVNU+qQIAr151T17Xi43hafoiNX1getPS7cc5yGyXILfar35Q/t3uVKwrxBd7Rptth3
 ssbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULHbnWKqLNtMGcg8KIaL0K158afnIzV0WrYzum1/AdN5n5FnxzOq5+zP1BCelisvaaSL0NE810ti7bElM6GAYLf19GeA==
X-Gm-Message-State: AOJu0Yz9iSX1BMroakpQurSCCtvKjkzaoOy25EvHbzgAg3thCHnwO1Se
 xmLM3Q73OKGmaDbFVshb6bp94r7m+B65rfDlvYERB2ZxPKsmV3gNTpHWYA==
X-Google-Smtp-Source: AGHT+IHbleonVfXij5wDozg7aV6FrB5wDIkyukPTcfUWQfOdknw+tCpbC/OMIMFK/dDydlzdcjzeiQ==
X-Received: by 2002:a05:6000:1569:b0:36b:bb61:f576 with SMTP id
 ffacd0b85a97d-36bbc170d40mr4056720f8f.44.1722683446252; 
 Sat, 03 Aug 2024 04:10:46 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 09/15] clk: mediatek: mt7986: reorder TOPCKGEN factor ID
Date: Sat,  3 Aug 2024 10:40:42 +0200
Message-ID: <20240803084050.449-10-ansuelsmth@gmail.com>
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

Reorder TOPCKGEN factor ID to put TOP_FACTOR first and then PLL. This is
to match how it's done in upstream kernel linux and in preparation for
OF_UPSTREAM support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      |  70 ++++++++--------
 include/dt-bindings/clock/mt7986-clk.h | 108 ++++++++++++-------------
 2 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index c1f63ecc3b2..34b8eba5398 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -46,6 +46,41 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 
 /* TOPCKGEN FIXED DIV */
 static const struct mtk_fixed_factor top_fixed_divs[] = {
+	/* TOP Factors */
+	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL,
+		   1, 2),
+	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
+		   1250),
+	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
+		   1220),
+	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_XTAL, 1,
+		   1),
+	TOP_FACTOR(CK_TOP_USB_TX250M, "usb_tx250m", CK_TOP_XTAL, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_LN0_CK, "usb_ln0", CK_TOP_XTAL, 1, 1),
+	TOP_FACTOR(CK_TOP_USB_CDR_CK, "usb_cdr", CK_TOP_XTAL, 1, 1),
+	TOP_FACTOR(CK_TOP_SPINFI_BCK, "spinfi_bck", CK_TOP_SPINFI_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_I2C_BCK, "i2c_bck", CK_TOP_I2C_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_PEXTP_TL, "pextp_tl", CK_TOP_PEXTP_TL_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_EMMC_250M, "emmc_250m", CK_TOP_EMMC_250M_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_EMMC_416M, "emmc_416m", CK_TOP_EMMC_416M_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_F_26M_ADC_CK, "f_26m_adc", CK_TOP_F_26M_ADC_SEL, 1,
+		   1),
+	TOP_FACTOR(CK_TOP_SYSAXI, "sysaxi", CK_TOP_SYSAXI_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_NETSYS_WED_MCU, "netsys_wed_mcu",
+		   CK_TOP_NETSYS_MCU_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_NETSYS_2X, "netsys_2x", CK_TOP_NETSYS_2X_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_SGM_325M, "sgm_325m", CK_TOP_SGM_325M_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_A1SYS, "a1sys", CK_TOP_A1SYS_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_EIP_B, "eip_b", CK_TOP_EIP_B_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_F26M, "csw_f26m", CK_TOP_F26M_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_AUD_L, "aud_l", CK_TOP_AUD_L_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1),
+	TOP_FACTOR(CK_TOP_U2U3_REF, "u2u3_ref", CK_TOP_U2U3_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_U2U3_SYS, "u2u3_sys", CK_TOP_U2U3_SYS_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_U2U3_XHCI, "u2u3_xhci", CK_TOP_U2U3_XHCI_SEL, 1, 1),
+	TOP_FACTOR(CK_TOP_AP2CNN_HOST, "ap2cnn_host", CK_TOP_AP2CNN_HOST_SEL, 1,
+		   1),
 	/* MPLL */
 	PLL_FACTOR(CK_TOP_CB_MPLL_416M, "cb_mpll_416m", CK_APMIXED_MPLL, 1, 1),
 	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
@@ -84,41 +119,6 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 		   10),
 	/* SGMPLL */
 	PLL_FACTOR(CK_TOP_CB_SGMPLL_325M, "cb_sgmpll_325m", CK_APMIXED_SGMPLL, 1, 1),
-	/* TOPCKGEN and XTAL */
-	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL,
-		   1, 2),
-	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
-		   1250),
-	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
-		   1220),
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
-	TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1),
-	TOP_FACTOR(CK_TOP_U2U3_REF, "u2u3_ref", CK_TOP_U2U3_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_U2U3_SYS, "u2u3_sys", CK_TOP_U2U3_SYS_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_U2U3_XHCI, "u2u3_xhci", CK_TOP_U2U3_XHCI_SEL, 1, 1),
-	TOP_FACTOR(CK_TOP_AP2CNN_HOST, "ap2cnn_host", CK_TOP_AP2CNN_HOST_SEL, 1,
-		   1),
 };
 
 /* TOPCKGEN MUX PARENTS */
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index f19948cca16..0048d183389 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -16,60 +16,60 @@
 /* TOPCKGEN */
 
 #define CK_TOP_XTAL			0
-#define CK_TOP_CB_MPLL_416M		1
-#define CK_TOP_MPLL_D2			2
-#define CK_TOP_MPLL_D4			3
-#define CK_TOP_MPLL_D8			4
-#define CK_TOP_MPLL_D8_D2		5
-#define CK_TOP_MPLL_D3_D2		6
-#define CK_TOP_MMPLL_D2			7
-#define CK_TOP_MMPLL_D4			8
-#define CK_TOP_MMPLL_D8			9
-#define CK_TOP_MMPLL_D8_D2		10
-#define CK_TOP_MMPLL_D3_D8		11
-#define CK_TOP_MMPLL_U2PHYD		12
-#define CK_TOP_CB_APLL2_196M		13
-#define CK_TOP_APLL2_D4			14
-#define CK_TOP_NET1PLL_D4		15
-#define CK_TOP_NET1PLL_D5		16
-#define CK_TOP_NET1PLL_D5_D2		17
-#define CK_TOP_NET1PLL_D5_D4		18
-#define CK_TOP_NET1PLL_D8_D2		19
-#define CK_TOP_NET1PLL_D8_D4		20
-#define CK_TOP_CB_NET2PLL_800M		21
-#define CK_TOP_NET2PLL_D4		22
-#define CK_TOP_NET2PLL_D4_D2		23
-#define CK_TOP_NET2PLL_D3_D2		24
-#define CK_TOP_CB_WEDMCUPLL_760M	25
-#define CK_TOP_WEDMCUPLL_D5_D2		26
-#define CK_TOP_CB_SGMPLL_325M		27
-#define CK_TOP_XTAL_D2			28
-#define CK_TOP_RTC_32K			29
-#define CK_TOP_RTC_32P7K		30
-#define CK_TOP_NFI1X			31
-#define CK_TOP_USB_EQ_RX250M		32
-#define CK_TOP_USB_TX250M		33
-#define CK_TOP_USB_LN0_CK		34
-#define CK_TOP_USB_CDR_CK		35
-#define CK_TOP_SPINFI_BCK		36
-#define CK_TOP_I2C_BCK			37
-#define CK_TOP_PEXTP_TL			38
-#define CK_TOP_EMMC_250M		39
-#define CK_TOP_EMMC_416M		40
-#define CK_TOP_F_26M_ADC_CK		41
-#define CK_TOP_SYSAXI			42
-#define CK_TOP_NETSYS_WED_MCU		43
-#define CK_TOP_NETSYS_2X		44
-#define CK_TOP_SGM_325M			45
-#define CK_TOP_A1SYS			46
-#define CK_TOP_EIP_B			47
-#define CK_TOP_F26M			48
-#define CK_TOP_AUD_L			49
-#define CK_TOP_A_TUNER			50
-#define CK_TOP_U2U3_REF			51
-#define CK_TOP_U2U3_SYS			52
-#define CK_TOP_U2U3_XHCI		53
-#define CK_TOP_AP2CNN_HOST		54
+#define CK_TOP_XTAL_D2			1
+#define CK_TOP_RTC_32K			2
+#define CK_TOP_RTC_32P7K		3
+#define CK_TOP_NFI1X			4
+#define CK_TOP_USB_EQ_RX250M		5
+#define CK_TOP_USB_TX250M		6
+#define CK_TOP_USB_LN0_CK		7
+#define CK_TOP_USB_CDR_CK		8
+#define CK_TOP_SPINFI_BCK		9
+#define CK_TOP_I2C_BCK			10
+#define CK_TOP_PEXTP_TL			11
+#define CK_TOP_EMMC_250M		12
+#define CK_TOP_EMMC_416M		13
+#define CK_TOP_F_26M_ADC_CK		14
+#define CK_TOP_SYSAXI			15
+#define CK_TOP_NETSYS_WED_MCU		16
+#define CK_TOP_NETSYS_2X		17
+#define CK_TOP_SGM_325M			18
+#define CK_TOP_A1SYS			19
+#define CK_TOP_EIP_B			20
+#define CK_TOP_F26M			21
+#define CK_TOP_AUD_L			22
+#define CK_TOP_A_TUNER			23
+#define CK_TOP_U2U3_REF			24
+#define CK_TOP_U2U3_SYS			25
+#define CK_TOP_U2U3_XHCI		26
+#define CK_TOP_AP2CNN_HOST		27
+#define CK_TOP_CB_MPLL_416M		28
+#define CK_TOP_MPLL_D2			29
+#define CK_TOP_MPLL_D4			30
+#define CK_TOP_MPLL_D8			31
+#define CK_TOP_MPLL_D8_D2		32
+#define CK_TOP_MPLL_D3_D2		33
+#define CK_TOP_MMPLL_D2			34
+#define CK_TOP_MMPLL_D4			35
+#define CK_TOP_MMPLL_D8			36
+#define CK_TOP_MMPLL_D8_D2		37
+#define CK_TOP_MMPLL_D3_D8		38
+#define CK_TOP_MMPLL_U2PHYD		39
+#define CK_TOP_CB_APLL2_196M		40
+#define CK_TOP_APLL2_D4			41
+#define CK_TOP_NET1PLL_D4		42
+#define CK_TOP_NET1PLL_D5		43
+#define CK_TOP_NET1PLL_D5_D2		44
+#define CK_TOP_NET1PLL_D5_D4		45
+#define CK_TOP_NET1PLL_D8_D2		46
+#define CK_TOP_NET1PLL_D8_D4		47
+#define CK_TOP_CB_NET2PLL_800M		48
+#define CK_TOP_NET2PLL_D4		49
+#define CK_TOP_NET2PLL_D4_D2		50
+#define CK_TOP_NET2PLL_D3_D2		51
+#define CK_TOP_CB_WEDMCUPLL_760M	52
+#define CK_TOP_WEDMCUPLL_D5_D2		53
+#define CK_TOP_CB_SGMPLL_325M		54
 #define CK_TOP_NFI1X_SEL		55
 #define CK_TOP_SPINFI_SEL		56
 #define CK_TOP_SPI_SEL			57
-- 
2.45.2

