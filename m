Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2360CC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D5988C3F;
	Fri,  2 Aug 2024 21:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ON1ZiOVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D6C688622; Fri,  2 Aug 2024 21:52:03 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D16688622
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so45598215e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628321; x=1723233121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cmeWB+D0lILjJuJwQtC1PhEdk3GWPK+PYFgpMfusl/Y=;
 b=ON1ZiOVHsMyXpJE3JNw8aZcvXJEtVfocq8TdzI8/YUqtXimYLWkPOXwRyYz/Db8zEt
 mpg95oT3mZ+OvRhWKTDv+wHvD7qC9QXTwTIH3gAEhCvhy4EtAj7DthsgaF2oMec8GLWr
 Q7nHkX/hfq+T8z9n7StJNpmFoMEBAT6DlfqJEaRv2l3rKoODe/nZ/4vV1ajdAH2FLtcj
 nL9TAWswAYkqUp//1scLdZwkSIyNND/NDTE7eDQi0SAadPi9tNJ5cc5sxHMQCVc/GrcJ
 xaR13/y/VSzK8iUKA1O/eD7WQF4sWeHAKpDgqFqmkzaNJyWeMb3FTUthn+kSnq+xb7VR
 wLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628321; x=1723233121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmeWB+D0lILjJuJwQtC1PhEdk3GWPK+PYFgpMfusl/Y=;
 b=g6b3d/Qn6JNgN36/Hs59bGZYgGT4f01X42yZ7jw/TtHm7zFVh6k52R5b7Sfl3McepH
 rZXlL3MeUBKHy+s8l8vclyCV+FqxC8y5jyNMSZ8Dw701qV8+HhPyHi57sovFlAL1iINm
 DT7JP0oXKrB3FmCVNTK4Y6YfnU1TeCFPeWzNU7DQzMxBjR7Ls2UH2lbrieoCzQaY27Ci
 lYCZWviEM8WK7+kCQ14JwZcy1uguSxRhdC0PJD0DkERAmMXNelPLLhWinaonnxjglQtQ
 gErRqiX6uzAtYEqWOifTIM6d3IdFVj2YIX+oA6SiiglCE89d85IR6CbY71qT5SdEVrY/
 4HsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvDMqetxR+CZ9FLgvYr1D1B3zW2pAKCMi62jGzcPQEqXb5M1K0HVqJWEUVjj4iqRN0P1rI8o6UyKUJ3XP9x1H8lR1mbg==
X-Gm-Message-State: AOJu0YxIMjxnbHkJDHV58k3NyX8PALsbR232/wtw9GcyvOO6yZ3cPh7x
 ydTp/rQ3PwpYME1/5slIkkAqt/2QcNGRXXuyKcUZywd9F1SP9eqD
X-Google-Smtp-Source: AGHT+IHAPK909zgwcTJNriZicScXGbKZOssMp80/uasauGM6mMVlyzL0gPvpUFpai3BpdWlWDC4leQ==
X-Received: by 2002:a05:600c:468b:b0:428:18d9:9963 with SMTP id
 5b1f17b1804b1-428e6b2a6c8mr31095545e9.22.1722628320739; 
 Fri, 02 Aug 2024 12:52:00 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:52:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/8] clk: mediatek: mt7622: add missing clock define for
 MAIN_CORE_EN
Date: Fri,  2 Aug 2024 15:48:28 +0200
Message-ID: <20240802134835.24006-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134835.24006-1-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
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

Add missing clock for MAIN_CORE_EN. This is a special clock as it's a
gate for the APMIXED clocks required as a parent for CPU clocks.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      | 29 +++++++++++++++++++++++---
 include/dt-bindings/clock/mt7622-clk.h |  1 +
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 8f173b79453..49adffb3b43 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -66,6 +66,24 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	    21, 0x358, 1, 0x35c, 0),
 };
 
+static const struct mtk_gate_regs apmixed_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_APMIXED(_id, _parent, _shift) {		\
+		.id = _id,				\
+		.parent = _parent,			\
+		.regs = &apmixed_cg_regs,		\
+		.shift = _shift,			\
+		.flags = CLK_GATE_NO_SETCLR_INV,	\
+	}
+
+static const struct mtk_gate apmixed_cgs[] = {
+	GATE_APMIXED(CLK_APMIXED_MAIN_CORE_EN, CLK_APMIXED_MAINPLL, 5),
+};
+
 /* topckgen */
 #define FACTOR0(_id, _parent, _mult, _div)			\
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
@@ -554,12 +572,17 @@ static const struct mtk_gate ssusb_cgs[] = {
 	GATE_SSUSB(CLK_SSUSB_DMA_EN, CLK_TOP_HIF_SEL, 8),
 };
 
+static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
+	.xtal2_rate = 25 * MHZ,
+	.plls = apmixed_plls,
+	.gates_offs = CLK_APMIXED_MAIN_CORE_EN,
+	.gates = apmixed_cgs,
+};
+
 static const struct mtk_clk_tree mt7622_clk_tree = {
 	.xtal_rate = 25 * MHZ,
-	.xtal2_rate = 25 * MHZ,
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
@@ -586,7 +609,7 @@ static int mt7622_apmixedsys_probe(struct udevice *dev)
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7622_clk_tree);
+	ret = mtk_common_clk_init(dev, &mt7622_apmixed_clk_tree);
 	if (ret)
 		return ret;
 
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 2f36abcf8ae..569bfce0d05 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -169,6 +169,7 @@
 #define CLK_APMIXED_AUD2PLL		6
 #define CLK_APMIXED_TRGPLL		7
 #define CLK_APMIXED_SGMIPLL		8
+#define CLK_APMIXED_MAIN_CORE_EN	9
 
 /* AUDIOSYS */
 
-- 
2.45.2

