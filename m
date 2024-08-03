Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3094EC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3A688C73;
	Sat,  3 Aug 2024 10:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkBHPfpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851DB88795; Sat,  3 Aug 2024 10:33:27 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F26488795
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso54919425e9.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674005; x=1723278805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/T/GuEwwZi54Z3WKDVJyKCWeXiBgBCrLQdk//nh9XKg=;
 b=MkBHPfptspelRKDpzA2YB55DkzITmO+3EUIxbOxN5dAyoRqod0qWoJzk6t0dUJAlPM
 39zM+DPkyxkFc00OAJNQS3SvhWiGdKlDcdlt0CO/kF9gh1JhUBHN91de7VQjfMEvdx51
 vB3r9ysMdHsEPJmJ3QpRSUvyJJpf40Ld9y4IncF0AMl8W/rE8hTpFu6b8sOqu+cJpAGT
 /0R+XvJADeBFqFVZMK2dD2mgUaRBzkjeiQAwRRVmhxGpoI6+pJyhXgZrUlXMmQQ5HydI
 ppgBIxEo8sasTUKsyQf9aSIqKFz8aiBQb5YWnZZuEZdRG6eVyXKi2yOfVM7VLJV1s8ef
 E6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674005; x=1723278805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T/GuEwwZi54Z3WKDVJyKCWeXiBgBCrLQdk//nh9XKg=;
 b=HIGyJG4vwta/bquTDzSB1DxFMVPkNI4rmHctSg+WL07Ye3LMG8kSRfb+NVy7q4k5zR
 EOuhVRpcxSQYtsDoEiz/ftBLdq5WJMNGKcq2cTRCYj1joIS3pDPxiWt114EHHeNEGB5U
 YGq4I9i8S6dVyOVKLcA3lP7gimwfOaSahZFhPSSvTbJ6W+hZd4hS8UpLicEyUdkv/2jE
 Lae6+DBqZS/rM9sb3KtvSxDMDjgDi34kKl2ySS763W74zl4+HYkgt1c+oA1CUptrdNX/
 +pbA+ucuoQ64OI+FHzrNk6CPhwSaaKlukimn9yUiKQMVK/anttjEojGBUQ3GOXtxT/PL
 pEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgrAlFZHCd31g1iq3+s1iQWLrjBM/x+UWhx3AEt3zheOTOfhCbFhsXPOC4VO88rvul9VSYhq4GaJmKisyEBCDUPccxCA==
X-Gm-Message-State: AOJu0YwgiqoY4cVLmkCuEMMEJs+Xfh0+9Y32+js4O41KcOOPHf2WjxF1
 mGBLfTYd+zFJ1s8DxR+2BpxrVKzbPGgrhQ1oCl3fXMNJV1VVdaPJ
X-Google-Smtp-Source: AGHT+IE+JE+aay/d2WMHX4qYascQ4/yQw6Q49MYf0MGMSd6vtvIDniiY3nvzd9QibqWG0s09K8zCGQ==
X-Received: by 2002:a05:600c:1c94:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-428e6b839f6mr37693825e9.31.1722674004469; 
 Sat, 03 Aug 2024 01:33:24 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 04/13] clk: mediatek: mt7988: move INFRA_PCIE_PERI_26M_CK_Px
 clock at top
Date: Sat,  3 Aug 2024 10:32:53 +0200
Message-ID: <20240803083305.30697-5-ansuelsmth@gmail.com>
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

Move INFRA_PCIE_PERI_26M_CK_Px clock at top of the infracfg gates
in preparation for support of OF_UPSTREAM to have a 1:1 match with
upstream clock ID.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      |  16 +--
 include/dt-bindings/clock/mt7988-clk.h | 168 ++++++++++++-------------
 2 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 1ce8c4d8fef..5d146246fea 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -645,6 +645,14 @@ static const struct mtk_gate_regs infra_3_cg_regs = {
 
 /* INFRA GATE */
 static const struct mtk_gate infracfg_mtk_gates[] = {
+	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P0,
+		    "infra_pcie_peri_ck_26m_ck_p0", CK_INFRA_F26M_O0, 7),
+	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P1,
+		    "infra_pcie_peri_ck_26m_ck_p1", CK_INFRA_F26M_O0, 8),
+	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P2,
+		    "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_F26M_O0, 9),
+	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P3,
+		    "infra_pcie_peri_ck_26m_ck_p3", CK_INFRA_F26M_O0, 10),
 	GATE_INFRA1(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
 		    CK_INFRA_66M_MCK, 0),
 	GATE_INFRA1(CK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
@@ -797,14 +805,6 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 		    CK_INFRA_133M_PHCK, 30),
 	GATE_INFRA3(CK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
 		    CK_INFRA_133M_PHCK, 31),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P0,
-		    "infra_pcie_peri_ck_26m_ck_p0", CK_INFRA_F26M_O0, 7),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P1,
-		    "infra_pcie_peri_ck_26m_ck_p1", CK_INFRA_F26M_O0, 8),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P2,
-		    "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_F26M_O0, 9),
-	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P3,
-		    "infra_pcie_peri_ck_26m_ck_p3", CK_INFRA_F26M_O0, 10),
 };
 
 static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree = {
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index 4fd968a12ca..5c643b979b5 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -80,93 +80,93 @@
 #define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL 63 /* Linux CLK ID (17) */
 #define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL 64 /* Linux CLK ID (18) */
 /* mtk_gate */
-#define CK_INFRA_66M_GPT_BCK	     (65 - GATE_OFFSET) /* Linux CLK ID (19) */
-#define CK_INFRA_66M_PWM_HCK	     (66 - GATE_OFFSET) /* Linux CLK ID (20) */
-#define CK_INFRA_66M_PWM_BCK	     (67 - GATE_OFFSET) /* Linux CLK ID (21) */
-#define CK_INFRA_66M_PWM_CK1	     (68 - GATE_OFFSET) /* Linux CLK ID (22) */
-#define CK_INFRA_66M_PWM_CK2	     (69 - GATE_OFFSET) /* Linux CLK ID (23) */
-#define CK_INFRA_66M_PWM_CK3	     (70 - GATE_OFFSET) /* Linux CLK ID (24) */
-#define CK_INFRA_66M_PWM_CK4	     (71 - GATE_OFFSET) /* Linux CLK ID (25) */
-#define CK_INFRA_66M_PWM_CK5	     (72 - GATE_OFFSET) /* Linux CLK ID (26) */
-#define CK_INFRA_66M_PWM_CK6	     (73 - GATE_OFFSET) /* Linux CLK ID (27) */
-#define CK_INFRA_66M_PWM_CK7	     (74 - GATE_OFFSET) /* Linux CLK ID (28) */
-#define CK_INFRA_66M_PWM_CK8	     (75 - GATE_OFFSET) /* Linux CLK ID (29) */
-#define CK_INFRA_133M_CQDMA_BCK	     (76 - GATE_OFFSET) /* Linux CLK ID (30) */
-#define CK_INFRA_66M_AUD_SLV_BCK     (77 - GATE_OFFSET) /* Linux CLK ID (31) */
-#define CK_INFRA_AUD_26M	     (78 - GATE_OFFSET) /* Linux CLK ID (32) */
-#define CK_INFRA_AUD_L		     (79 - GATE_OFFSET) /* Linux CLK ID (33) */
-#define CK_INFRA_AUD_AUD	     (80 - GATE_OFFSET) /* Linux CLK ID (34) */
-#define CK_INFRA_AUD_EG2	     (81 - GATE_OFFSET) /* Linux CLK ID (35) */
-#define CK_INFRA_DRAMC_F26M	     (82 - GATE_OFFSET) /* Linux CLK ID (36) */
-#define CK_INFRA_133M_DBG_ACKM	     (83 - GATE_OFFSET) /* Linux CLK ID (37) */
-#define CK_INFRA_66M_AP_DMA_BCK	     (84 - GATE_OFFSET) /* Linux CLK ID (38) */
-#define CK_INFRA_66M_SEJ_BCK	     (85 - GATE_OFFSET) /* Linux CLK ID (39) */
-#define CK_INFRA_PRE_CK_SEJ_F13M     (86 - GATE_OFFSET) /* Linux CLK ID (40) */
-#define CK_INFRA_66M_TRNG	     (87 - GATE_OFFSET) /* Linux CLK ID (41) */
-#define CK_INFRA_26M_THERM_SYSTEM    (88 - GATE_OFFSET) /* Linux CLK ID (42) */
-#define CK_INFRA_I2C_BCK	     (89 - GATE_OFFSET) /* Linux CLK ID (43) */
-#define CK_INFRA_66M_UART0_PCK	     (90 - GATE_OFFSET) /* Linux CLK ID (44) */
-#define CK_INFRA_66M_UART1_PCK	     (91 - GATE_OFFSET) /* Linux CLK ID (45) */
-#define CK_INFRA_66M_UART2_PCK	     (92 - GATE_OFFSET) /* Linux CLK ID (46) */
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
-#define CK_INFRA_PCIE_PERI_26M_CK_P0 (145 - GATE_OFFSET) /* Linux CLK ID (99) */
+#define CK_INFRA_PCIE_PERI_26M_CK_P0 (65 - GATE_OFFSET) /* Linux CLK ID (99) */
 #define CK_INFRA_PCIE_PERI_26M_CK_P1                                           \
-	(146 - GATE_OFFSET) /* Linux CLK ID (100) */
+	(66 - GATE_OFFSET) /* Linux CLK ID (100) */
 #define CK_INFRA_PCIE_PERI_26M_CK_P2                                           \
-	(147 - GATE_OFFSET) /* Linux CLK ID (101) */
+	(67 - GATE_OFFSET) /* Linux CLK ID (101) */
 #define CK_INFRA_PCIE_PERI_26M_CK_P3                                           \
-	(148 - GATE_OFFSET) /* Linux CLK ID (102) */
+	(68 - GATE_OFFSET) /* Linux CLK ID (102) */
+#define CK_INFRA_66M_GPT_BCK	     (69 - GATE_OFFSET) /* Linux CLK ID (19) */
+#define CK_INFRA_66M_PWM_HCK	     (70 - GATE_OFFSET) /* Linux CLK ID (20) */
+#define CK_INFRA_66M_PWM_BCK	     (71 - GATE_OFFSET) /* Linux CLK ID (21) */
+#define CK_INFRA_66M_PWM_CK1	     (72 - GATE_OFFSET) /* Linux CLK ID (22) */
+#define CK_INFRA_66M_PWM_CK2	     (73 - GATE_OFFSET) /* Linux CLK ID (23) */
+#define CK_INFRA_66M_PWM_CK3	     (74 - GATE_OFFSET) /* Linux CLK ID (24) */
+#define CK_INFRA_66M_PWM_CK4	     (75 - GATE_OFFSET) /* Linux CLK ID (25) */
+#define CK_INFRA_66M_PWM_CK5	     (76 - GATE_OFFSET) /* Linux CLK ID (26) */
+#define CK_INFRA_66M_PWM_CK6	     (77 - GATE_OFFSET) /* Linux CLK ID (27) */
+#define CK_INFRA_66M_PWM_CK7	     (78 - GATE_OFFSET) /* Linux CLK ID (28) */
+#define CK_INFRA_66M_PWM_CK8	     (79 - GATE_OFFSET) /* Linux CLK ID (29) */
+#define CK_INFRA_133M_CQDMA_BCK	     (80 - GATE_OFFSET) /* Linux CLK ID (30) */
+#define CK_INFRA_66M_AUD_SLV_BCK     (81 - GATE_OFFSET) /* Linux CLK ID (31) */
+#define CK_INFRA_AUD_26M	     (82 - GATE_OFFSET) /* Linux CLK ID (32) */
+#define CK_INFRA_AUD_L		     (83 - GATE_OFFSET) /* Linux CLK ID (33) */
+#define CK_INFRA_AUD_AUD	     (84 - GATE_OFFSET) /* Linux CLK ID (34) */
+#define CK_INFRA_AUD_EG2	     (85 - GATE_OFFSET) /* Linux CLK ID (35) */
+#define CK_INFRA_DRAMC_F26M	     (86 - GATE_OFFSET) /* Linux CLK ID (36) */
+#define CK_INFRA_133M_DBG_ACKM	     (87 - GATE_OFFSET) /* Linux CLK ID (37) */
+#define CK_INFRA_66M_AP_DMA_BCK	     (88 - GATE_OFFSET) /* Linux CLK ID (38) */
+#define CK_INFRA_66M_SEJ_BCK	     (89 - GATE_OFFSET) /* Linux CLK ID (39) */
+#define CK_INFRA_PRE_CK_SEJ_F13M     (90 - GATE_OFFSET) /* Linux CLK ID (40) */
+#define CK_INFRA_66M_TRNG	     (91 - GATE_OFFSET) /* Linux CLK ID (41) */
+#define CK_INFRA_26M_THERM_SYSTEM    (92 - GATE_OFFSET) /* Linux CLK ID (42) */
+#define CK_INFRA_I2C_BCK	     (93 - GATE_OFFSET) /* Linux CLK ID (43) */
+#define CK_INFRA_66M_UART0_PCK	     (94 - GATE_OFFSET) /* Linux CLK ID (44) */
+#define CK_INFRA_66M_UART1_PCK	     (95 - GATE_OFFSET) /* Linux CLK ID (45) */
+#define CK_INFRA_66M_UART2_PCK	     (96 - GATE_OFFSET) /* Linux CLK ID (46) */
+#define CK_INFRA_52M_UART0_CK	     (97 - GATE_OFFSET) /* Linux CLK ID (47) */
+#define CK_INFRA_52M_UART1_CK	     (98 - GATE_OFFSET) /* Linux CLK ID (48) */
+#define CK_INFRA_52M_UART2_CK	     (99 - GATE_OFFSET) /* Linux CLK ID (49) */
+#define CK_INFRA_NFI		     (100 - GATE_OFFSET) /* Linux CLK ID (50) */
+#define CK_INFRA_SPINFI		     (101 - GATE_OFFSET) /* Linux CLK ID (51) */
+#define CK_INFRA_66M_NFI_HCK	     (102 - GATE_OFFSET) /* Linux CLK ID (52) */
+#define CK_INFRA_104M_SPI0	     (103 - GATE_OFFSET) /* Linux CLK ID (53) */
+#define CK_INFRA_104M_SPI1	     (104 - GATE_OFFSET) /* Linux CLK ID (54) */
+#define CK_INFRA_104M_SPI2_BCK	     (105 - GATE_OFFSET) /* Linux CLK ID (55) */
+#define CK_INFRA_66M_SPI0_HCK	     (106 - GATE_OFFSET) /* Linux CLK ID (56) */
+#define CK_INFRA_66M_SPI1_HCK	     (107 - GATE_OFFSET) /* Linux CLK ID (57) */
+#define CK_INFRA_66M_SPI2_HCK	     (108 - GATE_OFFSET) /* Linux CLK ID (58) */
+#define CK_INFRA_66M_FLASHIF_AXI     (109 - GATE_OFFSET) /* Linux CLK ID (59) */
+#define CK_INFRA_RTC		     (110 - GATE_OFFSET) /* Linux CLK ID (60) */
+#define CK_INFRA_26M_ADC_BCK	     (111 - GATE_OFFSET) /* Linux CLK ID (61) */
+#define CK_INFRA_RC_ADC		     (112 - GATE_OFFSET) /* Linux CLK ID (62) */
+#define CK_INFRA_MSDC400	     (113 - GATE_OFFSET) /* Linux CLK ID (63) */
+#define CK_INFRA_MSDC2_HCK	     (114 - GATE_OFFSET) /* Linux CLK ID (64) */
+#define CK_INFRA_133M_MSDC_0_HCK     (115 - GATE_OFFSET) /* Linux CLK ID (65) */
+#define CK_INFRA_66M_MSDC_0_HCK	     (116 - GATE_OFFSET) /* Linux CLK ID (66) */
+#define CK_INFRA_133M_CPUM_BCK	     (117 - GATE_OFFSET) /* Linux CLK ID (67) */
+#define CK_INFRA_BIST2FPC	     (118 - GATE_OFFSET) /* Linux CLK ID (68) */
+#define CK_INFRA_I2C_X16W_MCK_CK_P1  (119 - GATE_OFFSET) /* Linux CLK ID (69) */
+#define CK_INFRA_I2C_X16W_PCK_CK_P1  (120 - GATE_OFFSET) /* Linux CLK ID (70) */
+#define CK_INFRA_133M_USB_HCK	     (121 - GATE_OFFSET) /* Linux CLK ID (71) */
+#define CK_INFRA_133M_USB_HCK_CK_P1  (122 - GATE_OFFSET) /* Linux CLK ID (72) */
+#define CK_INFRA_66M_USB_HCK	     (123 - GATE_OFFSET) /* Linux CLK ID (73) */
+#define CK_INFRA_66M_USB_HCK_CK_P1   (124 - GATE_OFFSET) /* Linux CLK ID (74) */
+#define CK_INFRA_USB_SYS	     (125 - GATE_OFFSET) /* Linux CLK ID (75) */
+#define CK_INFRA_USB_SYS_CK_P1	     (126 - GATE_OFFSET) /* Linux CLK ID (76) */
+#define CK_INFRA_USB_REF	     (127 - GATE_OFFSET) /* Linux CLK ID (77) */
+#define CK_INFRA_USB_CK_P1	     (128 - GATE_OFFSET) /* Linux CLK ID (78) */
+#define CK_INFRA_USB_FRMCNT	     (129 - GATE_OFFSET) /* Linux CLK ID (79) */
+#define CK_INFRA_USB_FRMCNT_CK_P1    (130 - GATE_OFFSET) /* Linux CLK ID (80) */
+#define CK_INFRA_USB_PIPE	     (131 - GATE_OFFSET) /* Linux CLK ID (81) */
+#define CK_INFRA_USB_PIPE_CK_P1	     (132 - GATE_OFFSET) /* Linux CLK ID (82) */
+#define CK_INFRA_USB_UTMI	     (133 - GATE_OFFSET) /* Linux CLK ID (83) */
+#define CK_INFRA_USB_UTMI_CK_P1	     (134 - GATE_OFFSET) /* Linux CLK ID (84) */
+#define CK_INFRA_USB_XHCI	     (135 - GATE_OFFSET) /* Linux CLK ID (85) */
+#define CK_INFRA_USB_XHCI_CK_P1	     (136 - GATE_OFFSET) /* Linux CLK ID (86) */
+#define CK_INFRA_PCIE_GFMUX_TL_P0    (137 - GATE_OFFSET) /* Linux CLK ID (87) */
+#define CK_INFRA_PCIE_GFMUX_TL_P1    (138 - GATE_OFFSET) /* Linux CLK ID (88) */
+#define CK_INFRA_PCIE_GFMUX_TL_P2    (139 - GATE_OFFSET) /* Linux CLK ID (89) */
+#define CK_INFRA_PCIE_GFMUX_TL_P3    (140 - GATE_OFFSET) /* Linux CLK ID (90) */
+#define CK_INFRA_PCIE_PIPE_P0	     (141 - GATE_OFFSET) /* Linux CLK ID (91) */
+#define CK_INFRA_PCIE_PIPE_P1	     (142 - GATE_OFFSET) /* Linux CLK ID (92) */
+#define CK_INFRA_PCIE_PIPE_P2	     (143 - GATE_OFFSET) /* Linux CLK ID (93) */
+#define CK_INFRA_PCIE_PIPE_P3	     (144 - GATE_OFFSET) /* Linux CLK ID (94) */
+#define CK_INFRA_133M_PCIE_CK_P0     (145 - GATE_OFFSET) /* Linux CLK ID (95) */
+#define CK_INFRA_133M_PCIE_CK_P1     (146 - GATE_OFFSET) /* Linux CLK ID (96) */
+#define CK_INFRA_133M_PCIE_CK_P2     (147 - GATE_OFFSET) /* Linux CLK ID (97) */
+#define CK_INFRA_133M_PCIE_CK_P3     (148 - GATE_OFFSET) /* Linux CLK ID (98) */
 
 /* TOPCKGEN */
 /* mtk_fixed_factor */
-- 
2.45.2

