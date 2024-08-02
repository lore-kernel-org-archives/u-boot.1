Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AC5C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9913F88BF5;
	Fri,  2 Aug 2024 21:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDe6IMvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC8988C34; Fri,  2 Aug 2024 21:48:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7948388C1F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so15442435e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628137; x=1723232937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cfTAfKVcuSLB6PDJiSxdZBEdBH6CVzfNQ0jWOt8dgDM=;
 b=bDe6IMvPy3BVE6kIKu4SFnXAWsNeTmy3MCXDFQAdPnolq0rzsT04uSDs2qAhdc2RZO
 UhsrCwI7fn8c42yNH1icjtHneKsIe4mPgcnQI5TigQfwvK0Iw3/bFhHls3swN3SAXySl
 LF61WXzyPRptTYn/70mJzn64WGZjv0a54GdwP4VNVddA7oG5M19gdKWn6Nb1TiARcc8K
 e+i6cyAaCJbdB9dPAwmNjW5+uxM2ACnICgIwdZ2jzhK3Hu3dTzXYFap8vsK6TDzyxkLA
 /LuDbDdqecUX3AM4sctO98i9mc1HoKN4LxvENN3GV8GYQzKA9HXGf9O4uiNxUe+gdG3x
 DxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628137; x=1723232937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfTAfKVcuSLB6PDJiSxdZBEdBH6CVzfNQ0jWOt8dgDM=;
 b=t+mmKE/l+cVd6OXbdhpNQ8IugJGYl2/Gfppnd8K0JqHpBnDhBzucSOX47CkeiXatMu
 4FQwDoHBK4bFAbsPrEaBzE2a+YcFMWtVDgRxt1TEvIIRSSnsFpMDy0ufAmPQt2fkfle0
 TgQfy2b3Wzj+SaqK5cavIRsLj8aU/cgRx6+J5VX8AeInaUSkmP1nNGj3MaaVwRekgCGH
 0m5LGMCw924/bRZ5tre1rrfSEABy+XQqHYLPGmZZxgPt/7ZatOkwfYBQmEGR8IgVIIV3
 eYOlc7R/PHyal1x38DjU/UbT9ze6kAQCV5mnLueaLTZl9nr6fBTg3T3m3SFk/j/4fSAs
 uMQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKOfPgRVim1BT2KLEwVUprd4ojHB/cf2t5K9SDpAMyhLkSMSeM1GDbESjllrVHJ2ISwxN2CiPAE3pKS23mJFLwy1ZI+Q==
X-Gm-Message-State: AOJu0YwP2L/1HMJ+GPDQc+Egc2phKoSzZjbNC4xE+ObnuV4NoX8vRxfY
 4SIhmFv9wpOqGZQfSwFRj+1Qxj7sz8VJv1jRSzBXsCF1FMHoBRmk
X-Google-Smtp-Source: AGHT+IFwzCw4sgwZBKaDn0fOh9IOJKBaY7sZT9ERH7UAMyaZSKoTaAUY/tlRahf+OVcb5YvW8I1nNg==
X-Received: by 2002:a05:600c:358b:b0:427:d8f7:b718 with SMTP id
 5b1f17b1804b1-428e6b7f0abmr30534075e9.24.1722628136685; 
 Fri, 02 Aug 2024 12:48:56 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm24827455e9.17.2024.08.02.12.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:48:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 5/5] clk: mediatek: mt7623: remap peri clock ID and add MUX
Date: Fri,  2 Aug 2024 15:45:05 +0200
Message-ID: <20240802134511.23608-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134511.23608-1-ansuelsmth@gmail.com>
References: <20240802134511.23608-1-ansuelsmth@gmail.com>
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

Upstream kernel linux makes use of peri clock MUX to setup UART.

Add definition for these and add remap table as in the upstream clock ID
order gates are before MUX but we require MUX first and then clocks in
our downstream driver.

Convert the peri clk tree to MUX + GATE implementation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 83 +++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 78e390d49f8..d0b80f48b0a 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -807,6 +807,74 @@ static const struct mtk_gate infra_cgs[] = {
 };
 
 /* pericfg */
+static const int peri_id_offs_map[] = {
+	/* MUX CLK */
+	[CLK_PERI_UART0_SEL]			= 1,
+	[CLK_PERI_UART1_SEL]			= 2,
+	[CLK_PERI_UART2_SEL]			= 3,
+	[CLK_PERI_UART3_SEL]			= 4,
+	/* GATE CLK */
+	[CLK_PERI_NFI]				= 5,
+	[CLK_PERI_THERM]			= 6,
+	[CLK_PERI_PWM1]				= 7,
+	[CLK_PERI_PWM2]				= 8,
+	[CLK_PERI_PWM3]				= 9,
+	[CLK_PERI_PWM4]				= 10,
+	[CLK_PERI_PWM5]				= 11,
+	[CLK_PERI_PWM6]				= 12,
+	[CLK_PERI_PWM7]				= 13,
+	[CLK_PERI_PWM]				= 14,
+	[CLK_PERI_USB0]				= 15,
+	[CLK_PERI_USB1]				= 16,
+	[CLK_PERI_AP_DMA]			= 17,
+	[CLK_PERI_MSDC30_0]			= 18,
+	[CLK_PERI_MSDC30_1]			= 19,
+	[CLK_PERI_MSDC30_2]			= 20,
+	[CLK_PERI_MSDC30_3]			= 21,
+	[CLK_PERI_MSDC50_3]			= 22,
+	[CLK_PERI_NLI]				= 23,
+	[CLK_PERI_UART0]			= 24,
+	[CLK_PERI_UART1]			= 25,
+	[CLK_PERI_UART2]			= 26,
+	[CLK_PERI_UART3]			= 27,
+	[CLK_PERI_BTIF]				= 28,
+	[CLK_PERI_I2C0]				= 29,
+	[CLK_PERI_I2C1]				= 30,
+	[CLK_PERI_I2C2]				= 31,
+	[CLK_PERI_I2C3]				= 32,
+	[CLK_PERI_AUXADC]			= 33,
+	[CLK_PERI_SPI0]				= 34,
+	[CLK_PERI_ETH]				= 35,
+	[CLK_PERI_USB0_MCU]			= 36,
+	[CLK_PERI_USB1_MCU]			= 37,
+	[CLK_PERI_USB_SLV]			= 38,
+	[CLK_PERI_GCPU]				= 39,
+	[CLK_PERI_NFI_ECC]			= 40,
+	[CLK_PERI_NFI_PAD]			= 41,
+	[CLK_PERI_FLASH]			= 42,
+	[CLK_PERI_HOST89_INT]			= 43,
+	[CLK_PERI_HOST89_SPI]			= 44,
+	[CLK_PERI_HOST89_DVD]			= 45,
+	[CLK_PERI_SPI1]				= 46,
+	[CLK_PERI_SPI2]				= 47,
+	[CLK_PERI_FCI]				= 48,
+};
+
+#define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
+#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
+
+static const struct mtk_parent uart_ck_sel_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
+};
+
+static const struct mtk_composite peri_muxes[] = {
+	MUX_MIXED(CLK_PERI_UART0_SEL, uart_ck_sel_parents, 0x40C, 0, 1),
+	MUX_MIXED(CLK_PERI_UART1_SEL, uart_ck_sel_parents, 0x40C, 1, 1),
+	MUX_MIXED(CLK_PERI_UART2_SEL, uart_ck_sel_parents, 0x40C, 2, 1),
+	MUX_MIXED(CLK_PERI_UART3_SEL, uart_ck_sel_parents, 0x40C, 3, 1),
+};
+
 static const struct mtk_gate_regs peri0_cg_regs = {
 	.set_ofs = 0x8,
 	.clr_ofs = 0x10,
@@ -980,6 +1048,7 @@ static int mt7623_topckgen_probe(struct udevice *dev)
 static const struct mtk_clk_tree mt7623_clk_gate_tree = {
 	/* Each CLK ID for gates clock starts at index 1 */
 	.gates_offs = 1,
+	.xtal_rate = 26 * MHZ,
 };
 
 static int mt7623_infracfg_probe(struct udevice *dev)
@@ -988,10 +1057,18 @@ static int mt7623_infracfg_probe(struct udevice *dev)
 					infra_cgs);
 }
 
+static const struct mtk_clk_tree mt7623_clk_peri_tree = {
+	.id_offs_map = peri_id_offs_map,
+	.muxes_offs = peri_id_offs_map[CLK_PERI_UART0_SEL],
+	.gates_offs = peri_id_offs_map[CLK_PERI_NFI],
+	.muxes = peri_muxes,
+	.gates = peri_cgs,
+	.xtal_rate = 26 * MHZ,
+};
+
 static int mt7623_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
-					peri_cgs);
+	return mtk_common_clk_infrasys_init(dev, &mt7623_clk_peri_tree);
 }
 
 static int mt7623_hifsys_probe(struct udevice *dev)
@@ -1098,7 +1175,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.of_match = mt7623_pericfg_compat,
 	.probe = mt7623_pericfg_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-- 
2.45.2

