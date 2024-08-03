Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0AC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABCB88CB7;
	Sat,  3 Aug 2024 13:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5mNACTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D008827D; Sat,  3 Aug 2024 13:10:52 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDA388C73
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367963ea053so5786793f8f.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683450; x=1723288250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SLAKyIH2/UxSplY1qmngc18IUKKTFQj3NHuf5nTNFJo=;
 b=G5mNACTrsyK8WZvG/7hKILlAdq9feMhA5AKie7svpYfMEpj5mZ33ZUCUh1Ux8Fgvhj
 1OAyC4u/QlvRHS5c0HyZQy17D68s9yW8CdSmu1S6A+1+eff9XCEDQqnHQptj/zaZypcL
 jpubWg6omUPLFzMqAZADgFkBvFHk+VkXV2lyerbiTH6C+2nxbh8AOOxx8OuAtV03U+Tw
 I1gFNX8JP7XWS6+St2/ECcFgLoGotY2HcxO0+5YTnnuEJqcBA+uVP7q5h/SDfuNn1HuG
 F5w4sy+P3hY1zikNIIjcMcN2wqHMrPDw9bTuieWC9qqNNCNpfir9JGIU/LkcItaGZJb4
 1CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683450; x=1723288250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLAKyIH2/UxSplY1qmngc18IUKKTFQj3NHuf5nTNFJo=;
 b=AY0q4rzF4+u6CAI/bEbifSOuy7hLw6BW543XpBlbw2WHfrhuZb3rBsjapCIXPOMTZ7
 yVtL5rhSOHNhbEo3Nf2oQe4qq5VicDAhYRQEUANFxzNYYati14/2DS3G2KYUXAd41cHt
 iplUV1oCBt+HRcVAZirJFUkBCemt74+Cnqv0A+nPkRSIBw6hkWDH1Dp27ZdWUcpCmNNO
 G6jibo6fqlpZduJm3i9LdmfYUReLRpRl84R0sRouedHrBYO8LKXlAMhybEo5X034GoJ7
 68Z2OTCKfw9JGSu557lGzN/4NqDMhytQZ1WijSVcsf+5TBU2CBiTq4IqEJ1LgjYE/s31
 D3yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdFXaz2IzaXgASsicOCdBeplXaGz+tAiTw8bWFt+ECLmHDFBiG/5uW0ioKxHXCj25+kj/jT6xuAeTFTkBqoI+gm07B4w==
X-Gm-Message-State: AOJu0YzW6L1XZN2uBZxFr9P1zspuRDX/ATG6eXZvbEda43/Gy055YdDC
 1/TeSEpKawP4+y6B2IQb7p68C1ZxcszJT5oyIF9Ddg8El28BYn2E
X-Google-Smtp-Source: AGHT+IFbrvfUxuw2OzWURshvWsvf4d0X6QIcbNEyY/FX43eAccsQsxeg2fgh+74w5eN4sZ6x/2alMQ==
X-Received: by 2002:adf:f1c8:0:b0:368:5042:25f3 with SMTP id
 ffacd0b85a97d-36bbc11b54amr4666532f8f.34.1722683450212; 
 Sat, 03 Aug 2024 04:10:50 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 12/15] clk: mediatek: mt7986: move INFRA_TRNG_CK to the bottom
 of the list
Date: Sat,  3 Aug 2024 10:40:45 +0200
Message-ID: <20240803084050.449-13-ansuelsmth@gmail.com>
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

Move INFRA_TRNG_CK to the bottom of the list to have a 1:1 match with
upstream linux clock ID.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      |  3 +-
 include/dt-bindings/clock/mt7986-clk.h | 54 +++++++++++++-------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 08b7ab8a81e..7476024f584 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -470,7 +470,6 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA0_INFRA(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_SYSAXI_D2, 16),
 	GATE_INFRA0_INFRA(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_SYSAXI_D2, 24),
 	GATE_INFRA0_TOP(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_TOP_F26M_SEL, 25),
-	GATE_INFRA0_TOP(CK_INFRA_TRNG_CK, "infra_trng", CK_TOP_SYSAXI_SEL, 26),
 	/* INFRA1 */
 	GATE_INFRA1_TOP(CK_INFRA_THERM_CK, "infra_therm", CK_TOP_F26M_SEL, 0),
 	GATE_INFRA1_TOP(CK_INFRA_I2C0_CK, "infra_i2co", CK_TOP_I2C_SEL, 1),
@@ -511,6 +510,8 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA2_TOP(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_XTAL, 13),
 	GATE_INFRA2_TOP(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_TOP_F26M_SEL, 14),
 	GATE_INFRA2_TOP(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_TOP_SYSAXI_SEL, 15),
+	/* upstream linux unordered */
+	GATE_INFRA0_TOP(CK_INFRA_TRNG_CK, "infra_trng", CK_TOP_SYSAXI_SEL, 26),
 };
 
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 7df13665900..39939f8e028 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -115,33 +115,33 @@
 #define CK_INFRA_SEJ_13M_CK		16
 #define CK_INFRA_THERM_CK		17
 #define CK_INFRA_I2C0_CK		18
-#define CK_INFRA_TRNG_CK		19
-#define CK_INFRA_UART0_CK		20
-#define CK_INFRA_UART1_CK		21
-#define CK_INFRA_UART2_CK		22
-#define CK_INFRA_NFI1_CK		23
-#define CK_INFRA_SPINFI1_CK		24
-#define CK_INFRA_NFI_HCK_CK		25
-#define CK_INFRA_SPI0_CK		26
-#define CK_INFRA_SPI1_CK		27
-#define CK_INFRA_SPI0_HCK_CK		28
-#define CK_INFRA_SPI1_HCK_CK		29
-#define CK_INFRA_FRTC_CK		30
-#define CK_INFRA_MSDC_CK		31
-#define CK_INFRA_MSDC_HCK_CK		32
-#define CK_INFRA_MSDC_133M_CK		33
-#define CK_INFRA_MSDC_66M_CK		34
-#define CK_INFRA_ADC_26M_CK		35
-#define CK_INFRA_ADC_FRC_CK		36
-#define CK_INFRA_FBIST2FPC_CK		37
-#define CK_INFRA_IUSB_133_CK		38
-#define CK_INFRA_IUSB_66M_CK		39
-#define CK_INFRA_IUSB_SYS_CK		40
-#define CK_INFRA_IUSB_CK		41
-#define CK_INFRA_IPCIE_CK		42
-#define CK_INFRA_IPCIE_PIPE_CK		43
-#define CK_INFRA_IPCIER_CK		44
-#define CK_INFRA_IPCIEB_CK		45
+#define CK_INFRA_UART0_CK		19
+#define CK_INFRA_UART1_CK		20
+#define CK_INFRA_UART2_CK		21
+#define CK_INFRA_NFI1_CK		22
+#define CK_INFRA_SPINFI1_CK		23
+#define CK_INFRA_NFI_HCK_CK		24
+#define CK_INFRA_SPI0_CK		25
+#define CK_INFRA_SPI1_CK		26
+#define CK_INFRA_SPI0_HCK_CK		27
+#define CK_INFRA_SPI1_HCK_CK		28
+#define CK_INFRA_FRTC_CK		29
+#define CK_INFRA_MSDC_CK		30
+#define CK_INFRA_MSDC_HCK_CK		31
+#define CK_INFRA_MSDC_133M_CK		32
+#define CK_INFRA_MSDC_66M_CK		33
+#define CK_INFRA_ADC_26M_CK		34
+#define CK_INFRA_ADC_FRC_CK		35
+#define CK_INFRA_FBIST2FPC_CK		36
+#define CK_INFRA_IUSB_133_CK		37
+#define CK_INFRA_IUSB_66M_CK		38
+#define CK_INFRA_IUSB_SYS_CK		39
+#define CK_INFRA_IUSB_CK		40
+#define CK_INFRA_IPCIE_CK		41
+#define CK_INFRA_IPCIE_PIPE_CK		42
+#define CK_INFRA_IPCIER_CK		43
+#define CK_INFRA_IPCIEB_CK		44
+#define CK_INFRA_TRNG_CK		45
 #define CLK_INFRA_AO_NR_CLK		46
 
 /* APMIXEDSYS */
-- 
2.45.2

