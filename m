Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B48C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878F188792;
	Sat,  3 Aug 2024 10:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BIeoMBSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD3F88C98; Sat,  3 Aug 2024 10:33:38 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C1C888FA
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f035ae0fd1so100516351fa.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674015; x=1723278815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3O5s/lQmqv9e1E1pSkAPWd9fap5iLVVp61xW6Pe3Vjg=;
 b=BIeoMBSfNQpQ5xMOodzC9sC8JZqTQD1k9lI9XSfCOoo0pnmUAWs95kc3+M0qmGsg2N
 9GXCPlCf7+axNuLUIEzyaS47KRe0ewbIOvnxkZvwubdaLgSQ92EMnnxIhO2zkkA8GuDU
 /Ssbl28lf0nZAgaH8wu1a9RbedjymnxNZV20KW2+GuNLx3MQMf1AiefLBLOlgn+cSw7O
 eh7hRFevqa8w2n+n2NO598kQyZhm4l9uokcWSYj2eP6SuoiyvAJVJsEXoEGZh0DvgIuc
 gPUgcN9osPjZ4WcDrQ19pSk56VHD0knf20qLlOy5wY4gT+wTRj3dGeZWg9uP3SzxmMFs
 8mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674015; x=1723278815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3O5s/lQmqv9e1E1pSkAPWd9fap5iLVVp61xW6Pe3Vjg=;
 b=j2hPy8rTOMULGO73GQ9FQap+Moti+24pBMHG29xJ4R3bHxWKIZfLIJR7Pq2o/6090R
 jdAO02RPmXcXGkdvi3ETZ36JsejnVieo4JWB6oXDjOLmWxBiMeT4mKynnm9m3btX0NIK
 Q5vPrp8vCwGuYg5BM255wrg14/n/sryk4GAED2kWG6zN2mMh7lecv2YDDomndSEZWF46
 u0v5e7jZQA+FfaIjSbYnZddFWRKumpBYU9G1to37KVW5cSP+5SqF7Sg7RgSBnIHjLaBt
 l6yEc+ASD8cZucDmmjsDsCup0iu1kVQWs7cB4SK/ResyCIq4aOV82tpuI8LQ2+XHmW6n
 vrqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjE9ytNuDWd2+ZVgLlA2pt99vT71GtdH53hWZEyYQ4SuFj2wH70GfubTtgBoE8mucYSdo1F3fjaU1Qz38vnvJVJiwmhA==
X-Gm-Message-State: AOJu0Ywd6B1KALM9ET/yMz33mVsHUjUKlUhGtl2eyFWPW9NiU4Ku0Ub+
 h8ZuCbruKtNUEGjXN+XwqDOvWqm0o7uOr1jN9BCVD+c6IwVFGiLb
X-Google-Smtp-Source: AGHT+IEq7jIzRzPs6XBkXvnuE1FTKN/I0VS6/0h7/e9Z7PnAfvnzwUyW4jG1HAn+vb5wWveIpSW7ow==
X-Received: by 2002:a2e:a9a4:0:b0:2f1:5c73:f215 with SMTP id
 38308e7fff4ca-2f15c73f368mr39270301fa.46.1722674014969; 
 Sat, 03 Aug 2024 01:33:34 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 11/13] clk: mediatek: mt7988: replace clock ID with upstream
 linux
Date: Sat,  3 Aug 2024 10:33:00 +0200
Message-ID: <20240803083305.30697-12-ansuelsmth@gmail.com>
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

Replace infracfg clk ID with upstream linux version.

The same format is used here with the factor first, then mux and then
gates.

To correctly reference the gates in clk_gate function, define the
gates_offs value in clk_tree now that they are at an offset from mux and
factor.

Drop any comment that reference the clock ID as we now have a 1:1 match
with upstream kernel linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      |   1 +
 include/dt-bindings/clock/mt7988-clk.h | 420 ++++++++++++-------------
 2 files changed, 210 insertions(+), 211 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index b46ca9f4601..7ef03941e24 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -788,6 +788,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 
 static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.muxes_offs = CK_INFRA_MUX_UART0_SEL,
+	.gates_offs = CK_INFRA_PCIE_PERI_26M_CK_P0,
 	.muxes = infracfg_mtk_mux,
 	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 653fd8f6d29..7c64f5f3d03 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -9,224 +9,222 @@
 #define _DT_BINDINGS_CLK_MT7988_H
 
 /* INFRACFG_AO */
-#define GATE_OFFSET 65
 /* mtk_mux */
-#define CK_INFRA_MUX_UART0_SEL		0 /* Linux CLK ID (0) */
-#define CK_INFRA_MUX_UART1_SEL		1 /* Linux CLK ID (1) */
-#define CK_INFRA_MUX_UART2_SEL		2 /* Linux CLK ID (2) */
-#define CK_INFRA_MUX_SPI0_SEL		3 /* Linux CLK ID (3) */
-#define CK_INFRA_MUX_SPI1_SEL		4 /* Linux CLK ID (4) */
-#define CK_INFRA_MUX_SPI2_SEL		5 /* Linux CLK ID (5) */
-#define CK_INFRA_PWM_SEL		6 /* Linux CLK ID (6) */
-#define CK_INFRA_PWM_CK1_SEL		7 /* Linux CLK ID (7) */
-#define CK_INFRA_PWM_CK2_SEL		8 /* Linux CLK ID (8) */
-#define CK_INFRA_PWM_CK3_SEL		9 /* Linux CLK ID (9) */
-#define CK_INFRA_PWM_CK4_SEL		10 /* Linux CLK ID (10) */
-#define CK_INFRA_PWM_CK5_SEL		11 /* Linux CLK ID (11) */
-#define CK_INFRA_PWM_CK6_SEL		12 /* Linux CLK ID (12) */
-#define CK_INFRA_PWM_CK7_SEL		13 /* Linux CLK ID (13) */
-#define CK_INFRA_PWM_CK8_SEL		14 /* Linux CLK ID (14) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL 15 /* Linux CLK ID (15) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL 16 /* Linux CLK ID (16) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL 17 /* Linux CLK ID (17) */
-#define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL 18 /* Linux CLK ID (18) */
+#define CK_INFRA_MUX_UART0_SEL			0
+#define CK_INFRA_MUX_UART1_SEL			1
+#define CK_INFRA_MUX_UART2_SEL			2
+#define CK_INFRA_MUX_SPI0_SEL			3
+#define CK_INFRA_MUX_SPI1_SEL			4
+#define CK_INFRA_MUX_SPI2_SEL			5
+#define CK_INFRA_PWM_SEL			6
+#define CK_INFRA_PWM_CK1_SEL			7
+#define CK_INFRA_PWM_CK2_SEL			8
+#define CK_INFRA_PWM_CK3_SEL			9
+#define CK_INFRA_PWM_CK4_SEL			10
+#define CK_INFRA_PWM_CK5_SEL			11
+#define CK_INFRA_PWM_CK6_SEL			12
+#define CK_INFRA_PWM_CK7_SEL			13
+#define CK_INFRA_PWM_CK8_SEL			14
+#define CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL		15
+#define CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL		16
+#define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL		17
+#define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL		18
+
+/* INFRACFG */
 /* mtk_gate */
-#define CK_INFRA_PCIE_PERI_26M_CK_P0 (65 - GATE_OFFSET) /* Linux CLK ID (99) */
-#define CK_INFRA_PCIE_PERI_26M_CK_P1                                           \
-	(66 - GATE_OFFSET) /* Linux CLK ID (100) */
-#define CK_INFRA_PCIE_PERI_26M_CK_P2                                           \
-	(67 - GATE_OFFSET) /* Linux CLK ID (101) */
-#define CK_INFRA_PCIE_PERI_26M_CK_P3                                           \
-	(68 - GATE_OFFSET) /* Linux CLK ID (102) */
-#define CK_INFRA_66M_GPT_BCK	     (69 - GATE_OFFSET) /* Linux CLK ID (19) */
-#define CK_INFRA_66M_PWM_HCK	     (70 - GATE_OFFSET) /* Linux CLK ID (20) */
-#define CK_INFRA_66M_PWM_BCK	     (71 - GATE_OFFSET) /* Linux CLK ID (21) */
-#define CK_INFRA_66M_PWM_CK1	     (72 - GATE_OFFSET) /* Linux CLK ID (22) */
-#define CK_INFRA_66M_PWM_CK2	     (73 - GATE_OFFSET) /* Linux CLK ID (23) */
-#define CK_INFRA_66M_PWM_CK3	     (74 - GATE_OFFSET) /* Linux CLK ID (24) */
-#define CK_INFRA_66M_PWM_CK4	     (75 - GATE_OFFSET) /* Linux CLK ID (25) */
-#define CK_INFRA_66M_PWM_CK5	     (76 - GATE_OFFSET) /* Linux CLK ID (26) */
-#define CK_INFRA_66M_PWM_CK6	     (77 - GATE_OFFSET) /* Linux CLK ID (27) */
-#define CK_INFRA_66M_PWM_CK7	     (78 - GATE_OFFSET) /* Linux CLK ID (28) */
-#define CK_INFRA_66M_PWM_CK8	     (79 - GATE_OFFSET) /* Linux CLK ID (29) */
-#define CK_INFRA_133M_CQDMA_BCK	     (80 - GATE_OFFSET) /* Linux CLK ID (30) */
-#define CK_INFRA_66M_AUD_SLV_BCK     (81 - GATE_OFFSET) /* Linux CLK ID (31) */
-#define CK_INFRA_AUD_26M	     (82 - GATE_OFFSET) /* Linux CLK ID (32) */
-#define CK_INFRA_AUD_L		     (83 - GATE_OFFSET) /* Linux CLK ID (33) */
-#define CK_INFRA_AUD_AUD	     (84 - GATE_OFFSET) /* Linux CLK ID (34) */
-#define CK_INFRA_AUD_EG2	     (85 - GATE_OFFSET) /* Linux CLK ID (35) */
-#define CK_INFRA_DRAMC_F26M	     (86 - GATE_OFFSET) /* Linux CLK ID (36) */
-#define CK_INFRA_133M_DBG_ACKM	     (87 - GATE_OFFSET) /* Linux CLK ID (37) */
-#define CK_INFRA_66M_AP_DMA_BCK	     (88 - GATE_OFFSET) /* Linux CLK ID (38) */
-#define CK_INFRA_66M_SEJ_BCK	     (89 - GATE_OFFSET) /* Linux CLK ID (39) */
-#define CK_INFRA_PRE_CK_SEJ_F13M     (90 - GATE_OFFSET) /* Linux CLK ID (40) */
-/* #define CK_INFRA_66M_TRNG	     (91 - GATE_OFFSET)    NOT DEFINED */
-#define CK_INFRA_26M_THERM_SYSTEM    (91 - GATE_OFFSET) /* Linux CLK ID (42) */
-#define CK_INFRA_I2C_BCK	     (92 - GATE_OFFSET) /* Linux CLK ID (43) */
-/* #define CK_INFRA_66M_UART0_PCK    (94 - GATE_OFFSET)    NOT DEFINED */
-/* #define CK_INFRA_66M_UART1_PCK    (95 - GATE_OFFSET)    NOT DEFINED */
-/* #define CK_INFRA_66M_UART2_PCK    (96 - GATE_OFFSET)    NOT DEFINED */
-#define CK_INFRA_52M_UART0_CK	     (93 - GATE_OFFSET) /* Linux CLK ID (47) */
-#define CK_INFRA_52M_UART1_CK	     (94 - GATE_OFFSET) /* Linux CLK ID (48) */
-#define CK_INFRA_52M_UART2_CK	     (95 - GATE_OFFSET) /* Linux CLK ID (49) */
-#define CK_INFRA_NFI		     (96 - GATE_OFFSET) /* Linux CLK ID (50) */
-#define CK_INFRA_SPINFI		     (97 - GATE_OFFSET) /* Linux CLK ID (51) */
-#define CK_INFRA_66M_NFI_HCK	     (98 - GATE_OFFSET) /* Linux CLK ID (52) */
-#define CK_INFRA_104M_SPI0	     (99 - GATE_OFFSET) /* Linux CLK ID (53) */
-#define CK_INFRA_104M_SPI1	     (100 - GATE_OFFSET) /* Linux CLK ID (54) */
-#define CK_INFRA_104M_SPI2_BCK	     (101 - GATE_OFFSET) /* Linux CLK ID (55) */
-#define CK_INFRA_66M_SPI0_HCK	     (102 - GATE_OFFSET) /* Linux CLK ID (56) */
-#define CK_INFRA_66M_SPI1_HCK	     (103 - GATE_OFFSET) /* Linux CLK ID (57) */
-#define CK_INFRA_66M_SPI2_HCK	     (104 - GATE_OFFSET) /* Linux CLK ID (58) */
-#define CK_INFRA_66M_FLASHIF_AXI     (105 - GATE_OFFSET) /* Linux CLK ID (59) */
-#define CK_INFRA_RTC		     (106 - GATE_OFFSET) /* Linux CLK ID (60) */
-#define CK_INFRA_26M_ADC_BCK	     (107 - GATE_OFFSET) /* Linux CLK ID (61) */
-#define CK_INFRA_RC_ADC		     (108 - GATE_OFFSET) /* Linux CLK ID (62) */
-#define CK_INFRA_MSDC400	     (109 - GATE_OFFSET) /* Linux CLK ID (63) */
-#define CK_INFRA_MSDC2_HCK	     (110 - GATE_OFFSET) /* Linux CLK ID (64) */
-#define CK_INFRA_133M_MSDC_0_HCK     (111 - GATE_OFFSET) /* Linux CLK ID (65) */
-#define CK_INFRA_66M_MSDC_0_HCK	     (112 - GATE_OFFSET) /* Linux CLK ID (66) */
-#define CK_INFRA_133M_CPUM_BCK	     (113 - GATE_OFFSET) /* Linux CLK ID (67) */
-#define CK_INFRA_BIST2FPC	     (114 - GATE_OFFSET) /* Linux CLK ID (68) */
-#define CK_INFRA_I2C_X16W_MCK_CK_P1  (115 - GATE_OFFSET) /* Linux CLK ID (69) */
-#define CK_INFRA_I2C_X16W_PCK_CK_P1  (116 - GATE_OFFSET) /* Linux CLK ID (70) */
-#define CK_INFRA_133M_USB_HCK	     (117 - GATE_OFFSET) /* Linux CLK ID (71) */
-#define CK_INFRA_133M_USB_HCK_CK_P1  (118 - GATE_OFFSET) /* Linux CLK ID (72) */
-#define CK_INFRA_66M_USB_HCK	     (119 - GATE_OFFSET) /* Linux CLK ID (73) */
-#define CK_INFRA_66M_USB_HCK_CK_P1   (120 - GATE_OFFSET) /* Linux CLK ID (74) */
-#define CK_INFRA_USB_SYS	     (121 - GATE_OFFSET) /* Linux CLK ID (75) */
-#define CK_INFRA_USB_SYS_CK_P1	     (122 - GATE_OFFSET) /* Linux CLK ID (76) */
-#define CK_INFRA_USB_REF	     (123 - GATE_OFFSET) /* Linux CLK ID (77) */
-#define CK_INFRA_USB_CK_P1	     (124 - GATE_OFFSET) /* Linux CLK ID (78) */
-#define CK_INFRA_USB_FRMCNT	     (125 - GATE_OFFSET) /* Linux CLK ID (79) */
-#define CK_INFRA_USB_FRMCNT_CK_P1    (126 - GATE_OFFSET) /* Linux CLK ID (80) */
-#define CK_INFRA_USB_PIPE	     (127 - GATE_OFFSET) /* Linux CLK ID (81) */
-#define CK_INFRA_USB_PIPE_CK_P1	     (128 - GATE_OFFSET) /* Linux CLK ID (82) */
-#define CK_INFRA_USB_UTMI	     (129 - GATE_OFFSET) /* Linux CLK ID (83) */
-#define CK_INFRA_USB_UTMI_CK_P1	     (130 - GATE_OFFSET) /* Linux CLK ID (84) */
-#define CK_INFRA_USB_XHCI	     (131 - GATE_OFFSET) /* Linux CLK ID (85) */
-#define CK_INFRA_USB_XHCI_CK_P1	     (132 - GATE_OFFSET) /* Linux CLK ID (86) */
-#define CK_INFRA_PCIE_GFMUX_TL_P0    (133 - GATE_OFFSET) /* Linux CLK ID (87) */
-#define CK_INFRA_PCIE_GFMUX_TL_P1    (134 - GATE_OFFSET) /* Linux CLK ID (88) */
-#define CK_INFRA_PCIE_GFMUX_TL_P2    (135 - GATE_OFFSET) /* Linux CLK ID (89) */
-#define CK_INFRA_PCIE_GFMUX_TL_P3    (136 - GATE_OFFSET) /* Linux CLK ID (90) */
-#define CK_INFRA_PCIE_PIPE_P0	     (137 - GATE_OFFSET) /* Linux CLK ID (91) */
-#define CK_INFRA_PCIE_PIPE_P1	     (138 - GATE_OFFSET) /* Linux CLK ID (92) */
-#define CK_INFRA_PCIE_PIPE_P2	     (139 - GATE_OFFSET) /* Linux CLK ID (93) */
-#define CK_INFRA_PCIE_PIPE_P3	     (140 - GATE_OFFSET) /* Linux CLK ID (94) */
-#define CK_INFRA_133M_PCIE_CK_P0     (141 - GATE_OFFSET) /* Linux CLK ID (95) */
-#define CK_INFRA_133M_PCIE_CK_P1     (142 - GATE_OFFSET) /* Linux CLK ID (96) */
-#define CK_INFRA_133M_PCIE_CK_P2     (143 - GATE_OFFSET) /* Linux CLK ID (97) */
-#define CK_INFRA_133M_PCIE_CK_P3     (144 - GATE_OFFSET) /* Linux CLK ID (98) */
+#define CK_INFRA_PCIE_PERI_26M_CK_P0		19
+#define CK_INFRA_PCIE_PERI_26M_CK_P1		20
+#define CK_INFRA_PCIE_PERI_26M_CK_P2		21
+#define CK_INFRA_PCIE_PERI_26M_CK_P3		22
+#define CK_INFRA_66M_GPT_BCK			23
+#define CK_INFRA_66M_PWM_HCK			24
+#define CK_INFRA_66M_PWM_BCK			25
+#define CK_INFRA_66M_PWM_CK1			26
+#define CK_INFRA_66M_PWM_CK2			27
+#define CK_INFRA_66M_PWM_CK3			28
+#define CK_INFRA_66M_PWM_CK4			29
+#define CK_INFRA_66M_PWM_CK5			30
+#define CK_INFRA_66M_PWM_CK6			31
+#define CK_INFRA_66M_PWM_CK7			32
+#define CK_INFRA_66M_PWM_CK8			33
+#define CK_INFRA_133M_CQDMA_BCK			34
+#define CK_INFRA_66M_AUD_SLV_BCK		35
+#define CK_INFRA_AUD_26M			36
+#define CK_INFRA_AUD_L				37
+#define CK_INFRA_AUD_AUD			38
+#define CK_INFRA_AUD_EG2			39
+#define CK_INFRA_DRAMC_F26M			40
+#define CK_INFRA_133M_DBG_ACKM			41
+#define CK_INFRA_66M_AP_DMA_BCK			42
+#define CK_INFRA_66M_SEJ_BCK			43
+#define CK_INFRA_PRE_CK_SEJ_F13M		44
+/* #define CK_INFRA_66M_TRNG			44 */
+#define CLK_INFRA_26M_THERM_SYSTEM		45
+#define CLK_INFRA_I2C_BCK			46
+/* #define CK_INFRA_66M_UART0_PCK		46 */
+/* #define CK_INFRA_66M_UART1_PCK		47 */
+/* #define CK_INFRA_66M_UART2_PCK		48 */
+#define CK_INFRA_52M_UART0_CK			47
+#define CK_INFRA_52M_UART1_CK			48
+#define CK_INFRA_52M_UART2_CK			49
+#define CK_INFRA_NFI				50
+#define CK_INFRA_SPINFI				51
+#define CK_INFRA_66M_NFI_HCK			52
+#define CK_INFRA_104M_SPI0			53
+#define CK_INFRA_104M_SPI1			54
+#define CK_INFRA_104M_SPI2_BCK			55
+#define CK_INFRA_66M_SPI0_HCK			56
+#define CK_INFRA_66M_SPI1_HCK			57
+#define CK_INFRA_66M_SPI2_HCK			58
+#define CK_INFRA_66M_FLASHIF_AXI		59
+#define CK_INFRA_RTC				60
+#define CK_INFRA_26M_ADC_BCK			61
+#define CK_INFRA_RC_ADC				62
+#define CK_INFRA_MSDC400			63
+#define CK_INFRA_MSDC2_HCK			64
+#define CK_INFRA_133M_MSDC_0_HCK		65
+#define CK_INFRA_66M_MSDC_0_HCK			66
+#define CK_INFRA_133M_CPUM_BCK			67
+#define CK_INFRA_BIST2FPC			68
+#define CK_INFRA_I2C_X16W_MCK_CK_P1		69
+#define CK_INFRA_I2C_X16W_PCK_CK_P1		70
+#define CK_INFRA_133M_USB_HCK			71
+#define CK_INFRA_133M_USB_HCK_CK_P1		72
+#define CK_INFRA_66M_USB_HCK			73
+#define CK_INFRA_66M_USB_HCK_CK_P1		74
+#define CK_INFRA_USB_SYS			75
+#define CK_INFRA_USB_SYS_CK_P1			76
+#define CK_INFRA_USB_REF			77
+#define CK_INFRA_USB_CK_P1			78
+#define CK_INFRA_USB_FRMCNT			79
+#define CK_INFRA_USB_FRMCNT_CK_P1		80
+#define CK_INFRA_USB_PIPE			81
+#define CK_INFRA_USB_PIPE_CK_P1			82
+#define CK_INFRA_USB_UTMI			83
+#define CK_INFRA_USB_UTMI_CK_P1			84
+#define CK_INFRA_USB_XHCI			85
+#define CK_INFRA_USB_XHCI_CK_P1			86
+#define CK_INFRA_PCIE_GFMUX_TL_P0		87
+#define CK_INFRA_PCIE_GFMUX_TL_P1		88
+#define CK_INFRA_PCIE_GFMUX_TL_P2		89
+#define CK_INFRA_PCIE_GFMUX_TL_P3		90
+#define CK_INFRA_PCIE_PIPE_P0			91
+#define CK_INFRA_PCIE_PIPE_P1			92
+#define CK_INFRA_PCIE_PIPE_P2			93
+#define CK_INFRA_PCIE_PIPE_P3			94
+#define CK_INFRA_133M_PCIE_CK_P0		95
+#define CK_INFRA_133M_PCIE_CK_P1		96
+#define CK_INFRA_133M_PCIE_CK_P2		97
+#define CK_INFRA_133M_PCIE_CK_P3		98
 
 /* TOPCKGEN */
 /* mtk_fixed_clk */
-#define CK_TOP_XTAL		      0 /* Linux CLK ID (109) */
+#define CK_TOP_XTAL				0
 /* mtk_fixed_factor */
-#define CK_TOP_XTAL_D2		      1 /* Linux CLK ID (109) */
-#define CK_TOP_RTC_32K		      2 /* Linux CLK ID (110) */
-#define CK_TOP_RTC_32P7K	      3 /* Linux CLK ID (111) */
-#define CK_TOP_MPLL_D2		      4 /* Linux CLK ID (76) */
-#define CK_TOP_MPLL_D3_D2	      5 /* Linux CLK ID (77) */
-#define CK_TOP_MPLL_D4		      6 /* Linux CLK ID (78) */
-#define CK_TOP_MPLL_D8		      7 /* Linux CLK ID (79) */
-#define CK_TOP_MPLL_D8_D2	      8 /* Linux CLK ID (80) */
-#define CK_TOP_MMPLL_D2		      9 /* Linux CLK ID (82) */
-#define CK_TOP_MMPLL_D3_D5	      10 /* Linux CLK ID (83) */
-#define CK_TOP_MMPLL_D4		      11 /* Linux CLK ID (84) */
-#define CK_TOP_MMPLL_D6_D2	      12 /* Linux CLK ID (85) */
-#define CK_TOP_MMPLL_D8		      13 /* Linux CLK ID (86) */
-#define CK_TOP_APLL2_D4		      14 /* Linux CLK ID (88) */
-#define CK_TOP_NET1PLL_D4	      15 /* Linux CLK ID (89) */
-#define CK_TOP_NET1PLL_D5	      16 /* Linux CLK ID (90) */
-#define CK_TOP_NET1PLL_D5_D2	      17 /* Linux CLK ID (91) */
-#define CK_TOP_NET1PLL_D5_D4	      18 /* Linux CLK ID (92) */
-#define CK_TOP_NET1PLL_D8	      19 /* Linux CLK ID (93) */
-#define CK_TOP_NET1PLL_D8_D2	      20 /* Linux CLK ID (94) */
-#define CK_TOP_NET1PLL_D8_D4	      21 /* Linux CLK ID (95) */
-#define CK_TOP_NET1PLL_D8_D8	      22 /* Linux CLK ID (96) */
-#define CK_TOP_NET1PLL_D8_D16	      23 /* Linux CLK ID (97) */
-#define CK_TOP_NET2PLL_D2	      24 /* Linux CLK ID (99) */
-#define CK_TOP_NET2PLL_D4	      25 /* Linux CLK ID (100) */
-#define CK_TOP_NET2PLL_D4_D4	      26 /* Linux CLK ID (101) */
-#define CK_TOP_NET2PLL_D4_D8	      27 /* Linux CLK ID (102) */
-#define CK_TOP_NET2PLL_D6	      28 /* Linux CLK ID (103) */
-#define CK_TOP_NET2PLL_D8	      29 /* Linux CLK ID (104) */
+#define CK_TOP_XTAL_D2				1
+#define CK_TOP_RTC_32K				2
+#define CK_TOP_RTC_32P7K			3
+#define CK_TOP_MPLL_D2				4
+#define CK_TOP_MPLL_D3_D2			5
+#define CK_TOP_MPLL_D4				6
+#define CK_TOP_MPLL_D8				7
+#define CK_TOP_MPLL_D8_D2			8
+#define CK_TOP_MMPLL_D2				9
+#define CK_TOP_MMPLL_D3_D5			10
+#define CK_TOP_MMPLL_D4				11
+#define CK_TOP_MMPLL_D6_D2			12
+#define CK_TOP_MMPLL_D8				13
+#define CK_TOP_APLL2_D4				14
+#define CK_TOP_NET1PLL_D4			15
+#define CK_TOP_NET1PLL_D5			16
+#define CK_TOP_NET1PLL_D5_D2			17
+#define CK_TOP_NET1PLL_D5_D4			18
+#define CK_TOP_NET1PLL_D8			19
+#define CK_TOP_NET1PLL_D8_D2			20
+#define CK_TOP_NET1PLL_D8_D4			21
+#define CK_TOP_NET1PLL_D8_D8			22
+#define CK_TOP_NET1PLL_D8_D16			23
+#define CK_TOP_NET2PLL_D2			24
+#define CK_TOP_NET2PLL_D4			25
+#define CK_TOP_NET2PLL_D4_D4			26
+#define CK_TOP_NET2PLL_D4_D8			27
+#define CK_TOP_NET2PLL_D6			28
+#define CK_TOP_NET2PLL_D8			29
 /* mtk_mux */
-#define CK_TOP_NETSYS_SEL	      30 /* Linux CLK ID (0) */
-#define CK_TOP_NETSYS_500M_SEL	      31 /* Linux CLK ID (1) */
-#define CK_TOP_NETSYS_2X_SEL	      32 /* Linux CLK ID (2) */
-#define CK_TOP_NETSYS_GSW_SEL	      33 /* Linux CLK ID (3) */
-#define CK_TOP_ETH_GMII_SEL	      34 /* Linux CLK ID (4) */
-#define CK_TOP_NETSYS_MCU_SEL	      35 /* Linux CLK ID (5) */
-#define CK_TOP_NETSYS_PAO_2X_SEL      36 /* Linux CLK ID (6) */
-#define CK_TOP_EIP197_SEL	      37 /* Linux CLK ID (7) */
-#define CK_TOP_AXI_INFRA_SEL	      38 /* Linux CLK ID (8) */
-#define CK_TOP_UART_SEL		      39 /* Linux CLK ID (9) */
-#define CK_TOP_EMMC_250M_SEL	      40 /* Linux CLK ID (10) */
-#define CK_TOP_EMMC_400M_SEL	      41 /* Linux CLK ID (11) */
-#define CK_TOP_SPI_SEL		      42 /* Linux CLK ID (12) */
-#define CK_TOP_SPIM_MST_SEL	      43 /* Linux CLK ID (13) */
-#define CK_TOP_NFI1X_SEL	      44 /* Linux CLK ID (14) */
-#define CK_TOP_SPINFI_SEL	      45 /* Linux CLK ID (15) */
-#define CK_TOP_PWM_SEL		      46 /* Linux CLK ID (16) */
-#define CK_TOP_I2C_SEL		      47 /* Linux CLK ID (17) */
-#define CK_TOP_PCIE_MBIST_250M_SEL    48 /* Linux CLK ID (18) */
-#define CK_TOP_PEXTP_TL_SEL	      49 /* Linux CLK ID (19) */
-#define CK_TOP_PEXTP_TL_P1_SEL	      50 /* Linux CLK ID (20) */
-#define CK_TOP_PEXTP_TL_P2_SEL	      51 /* Linux CLK ID (21) */
-#define CK_TOP_PEXTP_TL_P3_SEL	      52 /* Linux CLK ID (22) */
-#define CK_TOP_USB_SYS_SEL	      53 /* Linux CLK ID (23) */
-#define CK_TOP_USB_SYS_P1_SEL	      54 /* Linux CLK ID (24) */
-#define CK_TOP_USB_XHCI_SEL	      55 /* Linux CLK ID (25) */
-#define CK_TOP_USB_XHCI_P1_SEL	      56 /* Linux CLK ID (26) */
-#define CK_TOP_USB_FRMCNT_SEL	      57 /* Linux CLK ID (27) */
-#define CK_TOP_USB_FRMCNT_P1_SEL      58 /* Linux CLK ID (28) */
-#define CK_TOP_AUD_SEL		      59 /* Linux CLK ID (29) */
-#define CK_TOP_A1SYS_SEL	      60 /* Linux CLK ID (30) */
-#define CK_TOP_AUD_L_SEL	      61 /* Linux CLK ID (31) */
-#define CK_TOP_A_TUNER_SEL	      62 /* Linux CLK ID (32) */
-#define CK_TOP_SSPXTP_SEL	      63 /* Linux CLK ID (33) */
-#define CK_TOP_USB_PHY_SEL	      64 /* Linux CLK ID (34) */
-#define CK_TOP_USXGMII_SBUS_0_SEL     65 /* Linux CLK ID (35) */
-#define CK_TOP_USXGMII_SBUS_1_SEL     66 /* Linux CLK ID (36) */
-#define CK_TOP_SGM_0_SEL	      67 /* Linux CLK ID (37) */
-#define CK_TOP_SGM_SBUS_0_SEL	      68 /* Linux CLK ID (38) */
-#define CK_TOP_SGM_1_SEL	      69 /* Linux CLK ID (39) */
-#define CK_TOP_SGM_SBUS_1_SEL	      70 /* Linux CLK ID (40) */
-#define CK_TOP_XFI_PHY_0_XTAL_SEL     71 /* Linux CLK ID (41) */
-#define CK_TOP_XFI_PHY_1_XTAL_SEL     72 /* Linux CLK ID (42) */
-#define CK_TOP_SYSAXI_SEL	      73 /* Linux CLK ID (43) */
-#define CK_TOP_SYSAPB_SEL	      74 /* Linux CLK ID (44) */
-#define CK_TOP_ETH_REFCK_50M_SEL      75 /* Linux CLK ID (45) */
-#define CK_TOP_ETH_SYS_200M_SEL	      76 /* Linux CLK ID (46) */
-#define CK_TOP_ETH_SYS_SEL	      77 /* Linux CLK ID (47) */
-#define CK_TOP_ETH_XGMII_SEL	      78 /* Linux CLK ID (48) */
-#define CK_TOP_BUS_TOPS_SEL	      79 /* Linux CLK ID (49) */
-#define CK_TOP_NPU_TOPS_SEL	      80 /* Linux CLK ID (50) */
-#define CK_TOP_DRAMC_SEL	      81 /* Linux CLK ID (51) */
-#define CK_TOP_DRAMC_MD32_SEL	      82 /* Linux CLK ID (52) */
-#define CK_TOP_INFRA_F26M_SEL	      83 /* Linux CLK ID (53) */
-#define CK_TOP_PEXTP_P0_SEL	      84 /* Linux CLK ID (54) */
-#define CK_TOP_PEXTP_P1_SEL	      85 /* Linux CLK ID (55) */
-#define CK_TOP_PEXTP_P2_SEL	      86 /* Linux CLK ID (56) */
-#define CK_TOP_PEXTP_P3_SEL	      87 /* Linux CLK ID (57) */
-#define CK_TOP_DA_XTP_GLB_P0_SEL      88 /* Linux CLK ID (58) */
-#define CK_TOP_DA_XTP_GLB_P1_SEL      89 /* Linux CLK ID (59) */
-#define CK_TOP_DA_XTP_GLB_P2_SEL      90 /* Linux CLK ID (60) */
-#define CK_TOP_DA_XTP_GLB_P3_SEL      91 /* Linux CLK ID (61) */
-#define CK_TOP_CKM_SEL		      92 /* Linux CLK ID (62) */
-#define CK_TOP_DA_SEL		      93 /* Linux CLK ID (63) */
-#define CK_TOP_PEXTP_SEL	      94 /* Linux CLK ID (64) */
-#define CK_TOP_TOPS_P2_26M_SEL	      95 /* Linux CLK ID (65) */
-#define CK_TOP_MCUSYS_BACKUP_625M_SEL 96 /* Linux CLK ID (66) */
-#define CK_TOP_NETSYS_SYNC_250M_SEL   97 /* Linux CLK ID (67) */
-#define CK_TOP_MACSEC_SEL	      98 /* Linux CLK ID (68) */
-#define CK_TOP_NETSYS_TOPS_400M_SEL   99 /* Linux CLK ID (69) */
-#define CK_TOP_NETSYS_PPEFB_250M_SEL  100 /* Linux CLK ID (70) */
-#define CK_TOP_NETSYS_WARP_SEL	      101 /* Linux CLK ID (71) */
-#define CK_TOP_ETH_MII_SEL	      102 /* Linux CLK ID (72) */
-#define CK_TOP_NPU_SEL		      103 /* Linux CLK ID (73) */
+#define CK_TOP_NETSYS_SEL			30
+#define CK_TOP_NETSYS_500M_SEL			31
+#define CK_TOP_NETSYS_2X_SEL			32
+#define CK_TOP_NETSYS_GSW_SEL			33
+#define CK_TOP_ETH_GMII_SEL			34
+#define CK_TOP_NETSYS_MCU_SEL			35
+#define CK_TOP_NETSYS_PAO_2X_SEL		36
+#define CK_TOP_EIP197_SEL			37
+#define CK_TOP_AXI_INFRA_SEL			38
+#define CK_TOP_UART_SEL				39
+#define CK_TOP_EMMC_250M_SEL			40
+#define CK_TOP_EMMC_400M_SEL			41
+#define CK_TOP_SPI_SEL				42
+#define CK_TOP_SPIM_MST_SEL			43
+#define CK_TOP_NFI1X_SEL			44
+#define CK_TOP_SPINFI_SEL			45
+#define CK_TOP_PWM_SEL				46
+#define CK_TOP_I2C_SEL				47
+#define CK_TOP_PCIE_MBIST_250M_SEL		48
+#define CK_TOP_PEXTP_TL_SEL			49
+#define CK_TOP_PEXTP_TL_P1_SEL			50
+#define CK_TOP_PEXTP_TL_P2_SEL			51
+#define CK_TOP_PEXTP_TL_P3_SEL			52
+#define CK_TOP_USB_SYS_SEL			53
+#define CK_TOP_USB_SYS_P1_SEL			54
+#define CK_TOP_USB_XHCI_SEL			55
+#define CK_TOP_USB_XHCI_P1_SEL			56
+#define CK_TOP_USB_FRMCNT_SEL			57
+#define CK_TOP_USB_FRMCNT_P1_SEL		58
+#define CK_TOP_AUD_SEL				59
+#define CK_TOP_A1SYS_SEL			60
+#define CK_TOP_AUD_L_SEL			61
+#define CK_TOP_A_TUNER_SEL			62
+#define CK_TOP_SSPXTP_SEL			63
+#define CK_TOP_USB_PHY_SEL			64
+#define CK_TOP_USXGMII_SBUS_0_SEL		65
+#define CK_TOP_USXGMII_SBUS_1_SEL		66
+#define CK_TOP_SGM_0_SEL			67
+#define CK_TOP_SGM_SBUS_0_SEL			68
+#define CK_TOP_SGM_1_SEL			69
+#define CK_TOP_SGM_SBUS_1_SEL			70
+#define CK_TOP_XFI_PHY_0_XTAL_SEL		71
+#define CK_TOP_XFI_PHY_1_XTAL_SEL		72
+#define CK_TOP_SYSAXI_SEL			73
+#define CK_TOP_SYSAPB_SEL			74
+#define CK_TOP_ETH_REFCK_50M_SEL		75
+#define CK_TOP_ETH_SYS_200M_SEL			76
+#define CK_TOP_ETH_SYS_SEL			77
+#define CK_TOP_ETH_XGMII_SEL			78
+#define CK_TOP_BUS_TOPS_SEL			79
+#define CK_TOP_NPU_TOPS_SEL			80
+#define CK_TOP_DRAMC_SEL			81
+#define CK_TOP_DRAMC_MD32_SEL			82
+#define CK_TOP_INFRA_F26M_SEL			83
+#define CK_TOP_PEXTP_P0_SEL			84
+#define CK_TOP_PEXTP_P1_SEL			85
+#define CK_TOP_PEXTP_P2_SEL			86
+#define CK_TOP_PEXTP_P3_SEL			87
+#define CK_TOP_DA_XTP_GLB_P0_SEL		88
+#define CK_TOP_DA_XTP_GLB_P1_SEL		89
+#define CK_TOP_DA_XTP_GLB_P2_SEL		90
+#define CK_TOP_DA_XTP_GLB_P3_SEL		91
+#define CK_TOP_CKM_SEL				92
+#define CK_TOP_DA_SEL				93
+#define CK_TOP_PEXTP_SEL			94
+#define CK_TOP_TOPS_P2_26M_SEL			95
+#define CK_TOP_MCUSYS_BACKUP_625M_SEL		96
+#define CK_TOP_NETSYS_SYNC_250M_SEL		97
+#define CK_TOP_MACSEC_SEL			98
+#define CK_TOP_NETSYS_TOPS_400M_SEL		99
+#define CK_TOP_NETSYS_PPEFB_250M_SEL		100
+#define CK_TOP_NETSYS_WARP_SEL			101
+#define CK_TOP_ETH_MII_SEL			102
+#define CK_TOP_NPU_SEL				103
 
 /* APMIXEDSYS */
 /* mtk_pll_data */
-- 
2.45.2

