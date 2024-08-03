Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D023C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFEA88C8C;
	Sat,  3 Aug 2024 10:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mTPTalH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4D088C8B; Sat,  3 Aug 2024 10:33:36 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A017A88C72
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f0dfdc9e16so110094711fa.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674014; x=1723278814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQiUKqhHHdrND+h1X8pJDnIAu0BNKLvdFbhQmNswiOM=;
 b=mTPTalH5yG14shZKm6BnnFk5IXgIBq2ZJ+jSJbZJWJBNlIdxgCZZVB8IGXbys5FBi7
 xlOXOln6VIHa0pMdibJM+jO8dBw2kBBrKYoRGhHHejkVAaRrWSYulpMVzLC9Id5c9nPQ
 p+WC+LkoRmbHWsLLl253LWBJemptgrp4lgd09QzUBYjQtlLbq71kg72kdEBGLbcp2YLi
 +V6+MdEp1gd046kNgYjS/JrREeU/nhKWxvl+PP59Ssp40QuG5/bx27em66vfB21Bb345
 UjsioBx3RdWxKuyQtvKe9l8JN1eIofTW/Pc9kbZg4mrxlZkWP5xCaOjVoWonvX30TQYq
 rdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674014; x=1723278814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQiUKqhHHdrND+h1X8pJDnIAu0BNKLvdFbhQmNswiOM=;
 b=LGa1Au5Pe4H5wMmtBdro6CascSblRiuYU7PSLIj6w5VwGzsbHER1Aeuu31wXZ8wdFU
 QRedsfZmhnxfbW5iKOGTkMlVWsaPovnSjUUpbBBw8UiuGX0XiuCDR+Xv575CeudgmZTf
 +w/QLDvcnZajKT+U5t9kCWv+GVvLykg8HEHp6rJFLnP+wJi5M3mVJK5B0+M5j9+bo/SS
 kYMz+jer6dFCzM/qyP+D2oDfxevhsQdx86sJch4sNrclJtDBiOYXhIdgt/Eyip24E4IT
 CO/KBMdgMjFsNDFhgdzBxTbmcWyrYmvQJJdLuhku5W1mWMNMHVrRj64gDOLLm+OEzhVk
 Warw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXirvmJ6RxX6a0DUJQO4ocoqEAjk1efgghQLM4FourQuXnUVLs+Mt054TZL7YQOKb+sGjB9nNfhtTdbxJVrVS8HgHggjA==
X-Gm-Message-State: AOJu0YwxUCTYZUcSuxp1NzXyagKp8wJXYTBA9Cqp1/rO1jA29vFrVvIp
 htv4cIw2fhagw8YoDCSstlRfAmo6zdjTUvQc1L2bPpEIeREUL8x33g3kqg==
X-Google-Smtp-Source: AGHT+IGhh3ubTaJcDibnmQbjl014Hc38UhxP5CCc/XWeQjRVZdl6WIB3yhffeJT2WEDYXbiisFkOWQ==
X-Received: by 2002:a2e:9689:0:b0:2ef:2d3a:e70a with SMTP id
 38308e7fff4ca-2f15aa93150mr39358041fa.18.1722674013516; 
 Sat, 03 Aug 2024 01:33:33 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 10/13] clk: mediatek: mt7988: comment out infracfg clk not
 defined
Date: Sat,  3 Aug 2024 10:32:59 +0200
Message-ID: <20240803083305.30697-11-ansuelsmth@gmail.com>
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

Comment out infracfg clk not defined in upstream kernel linux clock ID
include. These clock are not used and can be safely commented. Keep them
just to have a reference of their existence.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c      |  16 ++--
 include/dt-bindings/clock/mt7988-clk.h | 116 ++++++++++++-------------
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 4c94cda2b23..b46ca9f4601 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -657,17 +657,17 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 			CK_TOP_SYSAXI_SEL, 29),
 	GATE_INFRA1_TOP(CK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
 			CK_TOP_INFRA_F26M_SEL, 30),
-	GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSAXI_SEL,
-			31),
+	/* GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSAXI_SEL,
+			   31), */
 	GATE_INFRA2_TOP(CK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system",
 			CK_TOP_INFRA_F26M_SEL, 0),
 	GATE_INFRA2_TOP(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_TOP_I2C_SEL, 1),
-	GATE_INFRA2_TOP(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
-			CK_TOP_SYSAXI_SEL, 3),
-	GATE_INFRA2_TOP(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
-			CK_TOP_SYSAXI_SEL, 4),
-	GATE_INFRA2_TOP(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
-			CK_TOP_SYSAXI_SEL, 5),
+	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
+			   CK_TOP_SYSAXI_SEL, 3), */
+	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
+			   CK_TOP_SYSAXI_SEL, 4), */
+	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
+			   CK_TOP_SYSAXI_SEL, 5), */
 	GATE_INFRA2_INFRA(CK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
 			  CK_INFRA_MUX_UART0_SEL, 3),
 	GATE_INFRA2_INFRA(CK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-bindings/clock/mt7988-clk.h
index b4b95a04087..653fd8f6d29 100644
--- a/include/dt-bindings/clock/mt7988-clk.h
+++ b/include/dt-bindings/clock/mt7988-clk.h
@@ -60,64 +60,64 @@
 #define CK_INFRA_66M_AP_DMA_BCK	     (88 - GATE_OFFSET) /* Linux CLK ID (38) */
 #define CK_INFRA_66M_SEJ_BCK	     (89 - GATE_OFFSET) /* Linux CLK ID (39) */
 #define CK_INFRA_PRE_CK_SEJ_F13M     (90 - GATE_OFFSET) /* Linux CLK ID (40) */
-#define CK_INFRA_66M_TRNG	     (91 - GATE_OFFSET) /* Linux CLK ID (41) */
-#define CK_INFRA_26M_THERM_SYSTEM    (92 - GATE_OFFSET) /* Linux CLK ID (42) */
-#define CK_INFRA_I2C_BCK	     (93 - GATE_OFFSET) /* Linux CLK ID (43) */
-#define CK_INFRA_66M_UART0_PCK	     (94 - GATE_OFFSET) /* Linux CLK ID (44) */
-#define CK_INFRA_66M_UART1_PCK	     (95 - GATE_OFFSET) /* Linux CLK ID (45) */
-#define CK_INFRA_66M_UART2_PCK	     (96 - GATE_OFFSET) /* Linux CLK ID (46) */
-#define CK_INFRA_52M_UART0_CK	     (97 - GATE_OFFSET) /* Linux CLK ID (47) */
-#define CK_INFRA_52M_UART1_CK	     (98 - GATE_OFFSET) /* Linux CLK ID (48) */
-#define CK_INFRA_52M_UART2_CK	     (99 - GATE_OFFSET) /* Linux CLK ID (49) */
-#define CK_INFRA_NFI		     (100 - GATE_OFFSET) /* Linux CLK ID (50) */
-#define CK_INFRA_SPINFI		     (101 - GATE_OFFSET) /* Linux CLK ID (51) */
-#define CK_INFRA_66M_NFI_HCK	     (102 - GATE_OFFSET) /* Linux CLK ID (52) */
-#define CK_INFRA_104M_SPI0	     (103 - GATE_OFFSET) /* Linux CLK ID (53) */
-#define CK_INFRA_104M_SPI1	     (104 - GATE_OFFSET) /* Linux CLK ID (54) */
-#define CK_INFRA_104M_SPI2_BCK	     (105 - GATE_OFFSET) /* Linux CLK ID (55) */
-#define CK_INFRA_66M_SPI0_HCK	     (106 - GATE_OFFSET) /* Linux CLK ID (56) */
-#define CK_INFRA_66M_SPI1_HCK	     (107 - GATE_OFFSET) /* Linux CLK ID (57) */
-#define CK_INFRA_66M_SPI2_HCK	     (108 - GATE_OFFSET) /* Linux CLK ID (58) */
-#define CK_INFRA_66M_FLASHIF_AXI     (109 - GATE_OFFSET) /* Linux CLK ID (59) */
-#define CK_INFRA_RTC		     (110 - GATE_OFFSET) /* Linux CLK ID (60) */
-#define CK_INFRA_26M_ADC_BCK	     (111 - GATE_OFFSET) /* Linux CLK ID (61) */
-#define CK_INFRA_RC_ADC		     (112 - GATE_OFFSET) /* Linux CLK ID (62) */
-#define CK_INFRA_MSDC400	     (113 - GATE_OFFSET) /* Linux CLK ID (63) */
-#define CK_INFRA_MSDC2_HCK	     (114 - GATE_OFFSET) /* Linux CLK ID (64) */
-#define CK_INFRA_133M_MSDC_0_HCK     (115 - GATE_OFFSET) /* Linux CLK ID (65) */
-#define CK_INFRA_66M_MSDC_0_HCK	     (116 - GATE_OFFSET) /* Linux CLK ID (66) */
-#define CK_INFRA_133M_CPUM_BCK	     (117 - GATE_OFFSET) /* Linux CLK ID (67) */
-#define CK_INFRA_BIST2FPC	     (118 - GATE_OFFSET) /* Linux CLK ID (68) */
-#define CK_INFRA_I2C_X16W_MCK_CK_P1  (119 - GATE_OFFSET) /* Linux CLK ID (69) */
-#define CK_INFRA_I2C_X16W_PCK_CK_P1  (120 - GATE_OFFSET) /* Linux CLK ID (70) */
-#define CK_INFRA_133M_USB_HCK	     (121 - GATE_OFFSET) /* Linux CLK ID (71) */
-#define CK_INFRA_133M_USB_HCK_CK_P1  (122 - GATE_OFFSET) /* Linux CLK ID (72) */
-#define CK_INFRA_66M_USB_HCK	     (123 - GATE_OFFSET) /* Linux CLK ID (73) */
-#define CK_INFRA_66M_USB_HCK_CK_P1   (124 - GATE_OFFSET) /* Linux CLK ID (74) */
-#define CK_INFRA_USB_SYS	     (125 - GATE_OFFSET) /* Linux CLK ID (75) */
-#define CK_INFRA_USB_SYS_CK_P1	     (126 - GATE_OFFSET) /* Linux CLK ID (76) */
-#define CK_INFRA_USB_REF	     (127 - GATE_OFFSET) /* Linux CLK ID (77) */
-#define CK_INFRA_USB_CK_P1	     (128 - GATE_OFFSET) /* Linux CLK ID (78) */
-#define CK_INFRA_USB_FRMCNT	     (129 - GATE_OFFSET) /* Linux CLK ID (79) */
-#define CK_INFRA_USB_FRMCNT_CK_P1    (130 - GATE_OFFSET) /* Linux CLK ID (80) */
-#define CK_INFRA_USB_PIPE	     (131 - GATE_OFFSET) /* Linux CLK ID (81) */
-#define CK_INFRA_USB_PIPE_CK_P1	     (132 - GATE_OFFSET) /* Linux CLK ID (82) */
-#define CK_INFRA_USB_UTMI	     (133 - GATE_OFFSET) /* Linux CLK ID (83) */
-#define CK_INFRA_USB_UTMI_CK_P1	     (134 - GATE_OFFSET) /* Linux CLK ID (84) */
-#define CK_INFRA_USB_XHCI	     (135 - GATE_OFFSET) /* Linux CLK ID (85) */
-#define CK_INFRA_USB_XHCI_CK_P1	     (136 - GATE_OFFSET) /* Linux CLK ID (86) */
-#define CK_INFRA_PCIE_GFMUX_TL_P0    (137 - GATE_OFFSET) /* Linux CLK ID (87) */
-#define CK_INFRA_PCIE_GFMUX_TL_P1    (138 - GATE_OFFSET) /* Linux CLK ID (88) */
-#define CK_INFRA_PCIE_GFMUX_TL_P2    (139 - GATE_OFFSET) /* Linux CLK ID (89) */
-#define CK_INFRA_PCIE_GFMUX_TL_P3    (140 - GATE_OFFSET) /* Linux CLK ID (90) */
-#define CK_INFRA_PCIE_PIPE_P0	     (141 - GATE_OFFSET) /* Linux CLK ID (91) */
-#define CK_INFRA_PCIE_PIPE_P1	     (142 - GATE_OFFSET) /* Linux CLK ID (92) */
-#define CK_INFRA_PCIE_PIPE_P2	     (143 - GATE_OFFSET) /* Linux CLK ID (93) */
-#define CK_INFRA_PCIE_PIPE_P3	     (144 - GATE_OFFSET) /* Linux CLK ID (94) */
-#define CK_INFRA_133M_PCIE_CK_P0     (145 - GATE_OFFSET) /* Linux CLK ID (95) */
-#define CK_INFRA_133M_PCIE_CK_P1     (146 - GATE_OFFSET) /* Linux CLK ID (96) */
-#define CK_INFRA_133M_PCIE_CK_P2     (147 - GATE_OFFSET) /* Linux CLK ID (97) */
-#define CK_INFRA_133M_PCIE_CK_P3     (148 - GATE_OFFSET) /* Linux CLK ID (98) */
+/* #define CK_INFRA_66M_TRNG	     (91 - GATE_OFFSET)    NOT DEFINED */
+#define CK_INFRA_26M_THERM_SYSTEM    (91 - GATE_OFFSET) /* Linux CLK ID (42) */
+#define CK_INFRA_I2C_BCK	     (92 - GATE_OFFSET) /* Linux CLK ID (43) */
+/* #define CK_INFRA_66M_UART0_PCK    (94 - GATE_OFFSET)    NOT DEFINED */
+/* #define CK_INFRA_66M_UART1_PCK    (95 - GATE_OFFSET)    NOT DEFINED */
+/* #define CK_INFRA_66M_UART2_PCK    (96 - GATE_OFFSET)    NOT DEFINED */
+#define CK_INFRA_52M_UART0_CK	     (93 - GATE_OFFSET) /* Linux CLK ID (47) */
+#define CK_INFRA_52M_UART1_CK	     (94 - GATE_OFFSET) /* Linux CLK ID (48) */
+#define CK_INFRA_52M_UART2_CK	     (95 - GATE_OFFSET) /* Linux CLK ID (49) */
+#define CK_INFRA_NFI		     (96 - GATE_OFFSET) /* Linux CLK ID (50) */
+#define CK_INFRA_SPINFI		     (97 - GATE_OFFSET) /* Linux CLK ID (51) */
+#define CK_INFRA_66M_NFI_HCK	     (98 - GATE_OFFSET) /* Linux CLK ID (52) */
+#define CK_INFRA_104M_SPI0	     (99 - GATE_OFFSET) /* Linux CLK ID (53) */
+#define CK_INFRA_104M_SPI1	     (100 - GATE_OFFSET) /* Linux CLK ID (54) */
+#define CK_INFRA_104M_SPI2_BCK	     (101 - GATE_OFFSET) /* Linux CLK ID (55) */
+#define CK_INFRA_66M_SPI0_HCK	     (102 - GATE_OFFSET) /* Linux CLK ID (56) */
+#define CK_INFRA_66M_SPI1_HCK	     (103 - GATE_OFFSET) /* Linux CLK ID (57) */
+#define CK_INFRA_66M_SPI2_HCK	     (104 - GATE_OFFSET) /* Linux CLK ID (58) */
+#define CK_INFRA_66M_FLASHIF_AXI     (105 - GATE_OFFSET) /* Linux CLK ID (59) */
+#define CK_INFRA_RTC		     (106 - GATE_OFFSET) /* Linux CLK ID (60) */
+#define CK_INFRA_26M_ADC_BCK	     (107 - GATE_OFFSET) /* Linux CLK ID (61) */
+#define CK_INFRA_RC_ADC		     (108 - GATE_OFFSET) /* Linux CLK ID (62) */
+#define CK_INFRA_MSDC400	     (109 - GATE_OFFSET) /* Linux CLK ID (63) */
+#define CK_INFRA_MSDC2_HCK	     (110 - GATE_OFFSET) /* Linux CLK ID (64) */
+#define CK_INFRA_133M_MSDC_0_HCK     (111 - GATE_OFFSET) /* Linux CLK ID (65) */
+#define CK_INFRA_66M_MSDC_0_HCK	     (112 - GATE_OFFSET) /* Linux CLK ID (66) */
+#define CK_INFRA_133M_CPUM_BCK	     (113 - GATE_OFFSET) /* Linux CLK ID (67) */
+#define CK_INFRA_BIST2FPC	     (114 - GATE_OFFSET) /* Linux CLK ID (68) */
+#define CK_INFRA_I2C_X16W_MCK_CK_P1  (115 - GATE_OFFSET) /* Linux CLK ID (69) */
+#define CK_INFRA_I2C_X16W_PCK_CK_P1  (116 - GATE_OFFSET) /* Linux CLK ID (70) */
+#define CK_INFRA_133M_USB_HCK	     (117 - GATE_OFFSET) /* Linux CLK ID (71) */
+#define CK_INFRA_133M_USB_HCK_CK_P1  (118 - GATE_OFFSET) /* Linux CLK ID (72) */
+#define CK_INFRA_66M_USB_HCK	     (119 - GATE_OFFSET) /* Linux CLK ID (73) */
+#define CK_INFRA_66M_USB_HCK_CK_P1   (120 - GATE_OFFSET) /* Linux CLK ID (74) */
+#define CK_INFRA_USB_SYS	     (121 - GATE_OFFSET) /* Linux CLK ID (75) */
+#define CK_INFRA_USB_SYS_CK_P1	     (122 - GATE_OFFSET) /* Linux CLK ID (76) */
+#define CK_INFRA_USB_REF	     (123 - GATE_OFFSET) /* Linux CLK ID (77) */
+#define CK_INFRA_USB_CK_P1	     (124 - GATE_OFFSET) /* Linux CLK ID (78) */
+#define CK_INFRA_USB_FRMCNT	     (125 - GATE_OFFSET) /* Linux CLK ID (79) */
+#define CK_INFRA_USB_FRMCNT_CK_P1    (126 - GATE_OFFSET) /* Linux CLK ID (80) */
+#define CK_INFRA_USB_PIPE	     (127 - GATE_OFFSET) /* Linux CLK ID (81) */
+#define CK_INFRA_USB_PIPE_CK_P1	     (128 - GATE_OFFSET) /* Linux CLK ID (82) */
+#define CK_INFRA_USB_UTMI	     (129 - GATE_OFFSET) /* Linux CLK ID (83) */
+#define CK_INFRA_USB_UTMI_CK_P1	     (130 - GATE_OFFSET) /* Linux CLK ID (84) */
+#define CK_INFRA_USB_XHCI	     (131 - GATE_OFFSET) /* Linux CLK ID (85) */
+#define CK_INFRA_USB_XHCI_CK_P1	     (132 - GATE_OFFSET) /* Linux CLK ID (86) */
+#define CK_INFRA_PCIE_GFMUX_TL_P0    (133 - GATE_OFFSET) /* Linux CLK ID (87) */
+#define CK_INFRA_PCIE_GFMUX_TL_P1    (134 - GATE_OFFSET) /* Linux CLK ID (88) */
+#define CK_INFRA_PCIE_GFMUX_TL_P2    (135 - GATE_OFFSET) /* Linux CLK ID (89) */
+#define CK_INFRA_PCIE_GFMUX_TL_P3    (136 - GATE_OFFSET) /* Linux CLK ID (90) */
+#define CK_INFRA_PCIE_PIPE_P0	     (137 - GATE_OFFSET) /* Linux CLK ID (91) */
+#define CK_INFRA_PCIE_PIPE_P1	     (138 - GATE_OFFSET) /* Linux CLK ID (92) */
+#define CK_INFRA_PCIE_PIPE_P2	     (139 - GATE_OFFSET) /* Linux CLK ID (93) */
+#define CK_INFRA_PCIE_PIPE_P3	     (140 - GATE_OFFSET) /* Linux CLK ID (94) */
+#define CK_INFRA_133M_PCIE_CK_P0     (141 - GATE_OFFSET) /* Linux CLK ID (95) */
+#define CK_INFRA_133M_PCIE_CK_P1     (142 - GATE_OFFSET) /* Linux CLK ID (96) */
+#define CK_INFRA_133M_PCIE_CK_P2     (143 - GATE_OFFSET) /* Linux CLK ID (97) */
+#define CK_INFRA_133M_PCIE_CK_P3     (144 - GATE_OFFSET) /* Linux CLK ID (98) */
 
 /* TOPCKGEN */
 /* mtk_fixed_clk */
-- 
2.45.2

