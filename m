Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E69FC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55CD88BD6;
	Fri,  2 Aug 2024 21:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3j/t/v4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504AF88BF2; Fri,  2 Aug 2024 21:48:55 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537FF88BE4
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so58373395e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628132; x=1723232932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z0CtOxcQBFmxeoCB8nUi9G76aXjLAXltW0D+YGaW8Vs=;
 b=W3j/t/v4G58qnDo70ZRSTkIs1+Aib9Oh6YzJ4tmNT0GZMz7mJNSwfT0O0lG9hPRfEi
 SSK6QOfWABDq+oeSHe5xFiVqZbHM4nnoRoelL2Ykqs1yOgEkOQP6StATcDRynTA4WUW0
 EaUPT0lN6AiE4EBUO4M2trOa1mamzC1o6TsPxb8WtcH1F26mk/dqJADAq8rHkbVPNhHS
 LFGlPlDqOW7l5g+mPwKnuxcr56mRVGsrf0pmyutZlbarwwDfvOewkP7y8H4UaHmTjHj9
 Ex5/zbF80JUSzNe8V6ppaPY/dTYIJrULzWTEYbDtTCLz+OwHg44npcVx2ulSdUjXDQ/F
 uD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628132; x=1723232932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0CtOxcQBFmxeoCB8nUi9G76aXjLAXltW0D+YGaW8Vs=;
 b=PTKm8zUSRdP5xihDfpBwrCPA1NOZV0Csxf4gnY4Ghrfgv+v1K3am5SuEbbizmPX4Io
 2AMU7K2g7FDwVWFSi7+Ber+0Cl2ihc97vmENRlYTK4NDr8GPBUZV46cgmH2SF3VtbGrr
 zO+L7GEF4Z6bqWEOYattDgggDfjs+qRD6yoOjuDNOut27ANUAQiy+CppUOkJn7GmCsWu
 a3UI6nntvoBzOmljXik06QFNlzfw+D9RoO07HCNK17YykFG3oElrw+sRffNbFXZrlrl0
 4K9/YGdTYYHBmDktQ+FcE+dGpdpfGj1tTr6qIM0H6lzlHCigkixk5XwPXZFotM9vdUNv
 SBUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7SrYcvQ+NJqLEoukjIYkz537WHDl9wVukRm2zvsFUIduD7Ki/jZM5pthkHinJeYkm7hUX4+s=@lists.denx.de
X-Gm-Message-State: AOJu0YzzC1CkC5365z8iftgOfE10EvFyE9at0D+ECjXTll8FyP9Nykft
 mE7raZlEpuUQPaoojfDgY1C0gP7Bq3pg0Qwmkf92f5D51n6uYJdu
X-Google-Smtp-Source: AGHT+IFUgwHI8Mq5gcThsaOOTRzHqoq4FJel3/QdHxPyF77dgYQ0HqN88/61LiZ/MeiaNaSJO57m1w==
X-Received: by 2002:a05:600c:3b23:b0:426:5e91:391e with SMTP id
 5b1f17b1804b1-428e6b78b2cmr30643975e9.26.1722628131689; 
 Fri, 02 Aug 2024 12:48:51 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm24827455e9.17.2024.08.02.12.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:48:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/5] clk: mediatek: mt7623: fix broken peri_cgs clk with XTAL
 parents
Date: Fri,  2 Aug 2024 15:45:01 +0200
Message-ID: <20240802134511.23608-2-ansuelsmth@gmail.com>
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

Fix broken peri_cgs and infra_cgs clock with XTAL parents as they have
wrong definition of the parent type.

Correctly fix them and use CLK_PARENT_XTAL for them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 5072c9983c1..4be914c8297 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -586,21 +586,26 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x48,
 };
 
-#define GATE_INFRA(_id, _parent, _shift) {			\
+#define GATE_INFRA_FLAGS(_id, _parent, _shift, _flags) {	\
 		.id = _id,					\
 		.parent = _parent,				\
 		.regs = &infra_cg_regs,				\
 		.shift = _shift,				\
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
+		.flags = _flags,				\
 	}
+#define GATE_INFRA(_id, _parent, _shift) \
+	GATE_INFRA_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+#define GATE_INFRA_XTAL(_id, _parent, _shift) \
+	GATE_INFRA_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
+
 
 static const struct mtk_gate infra_cgs[] = {
 	GATE_INFRA(CLK_INFRA_DBG, CLK_TOP_AXI_SEL, 0),
 	GATE_INFRA(CLK_INFRA_SMI, CLK_TOP_MM_SEL, 1),
 	GATE_INFRA(CLK_INFRA_QAXI_CM4, CLK_TOP_AXI_SEL, 2),
 	GATE_INFRA(CLK_INFRA_AUD_SPLIN_B, CLK_TOP_HADDS2PLL_294M, 4),
-	GATE_INFRA(CLK_INFRA_AUDIO, CLK_XTAL, 5),
-	GATE_INFRA(CLK_INFRA_EFUSE, CLK_XTAL, 6),
+	GATE_INFRA_XTAL(CLK_INFRA_AUDIO, CLK_XTAL, 5),
+	GATE_INFRA_XTAL(CLK_INFRA_EFUSE, CLK_XTAL, 6),
 	GATE_INFRA(CLK_INFRA_L2C_SRAM, CLK_TOP_MM_SEL, 7),
 	GATE_INFRA(CLK_INFRA_M4U, CLK_TOP_MEM_SEL, 8),
 	GATE_INFRA(CLK_INFRA_CONNMCU, CLK_TOP_WBG_DIG_416M, 12),
@@ -628,13 +633,17 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x1C,
 };
 
-#define GATE_PERI0(_id, _parent, _shift) {			\
+#define GATE_PERI0_FLAGS(_id, _parent, _shift, _flags) {	\
 		.id = _id,					\
 		.parent = _parent,				\
 		.regs = &peri0_cg_regs,				\
 		.shift = _shift,				\
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
+		.flags = _flags,				\
 	}
+#define GATE_PERI0(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+#define GATE_PERI0_XTAL(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
 
 #define GATE_PERI1(_id, _parent, _shift) {			\
 		.id = _id,					\
@@ -672,10 +681,10 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_I2C0, CLK_TOP_AXI_SEL, 24),
 	GATE_PERI0(CLK_PERI_I2C1, CLK_TOP_AXI_SEL, 25),
 	GATE_PERI0(CLK_PERI_I2C2, CLK_TOP_AXI_SEL, 26),
-	GATE_PERI0(CLK_PERI_I2C3, CLK_XTAL, 27),
-	GATE_PERI0(CLK_PERI_AUXADC, CLK_XTAL, 28),
+	GATE_PERI0_XTAL(CLK_PERI_I2C3, CLK_XTAL, 27),
+	GATE_PERI0_XTAL(CLK_PERI_AUXADC, CLK_XTAL, 28),
 	GATE_PERI0(CLK_PERI_SPI0, CLK_TOP_SPI0_SEL, 29),
-	GATE_PERI0(CLK_PERI_ETH, CLK_XTAL, 30),
+	GATE_PERI0_XTAL(CLK_PERI_ETH, CLK_XTAL, 30),
 	GATE_PERI0(CLK_PERI_USB0_MCU, CLK_TOP_AXI_SEL, 31),
 
 	GATE_PERI1(CLK_PERI_USB1_MCU, CLK_TOP_AXI_SEL, 0),
-- 
2.45.2

