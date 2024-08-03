Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8EDC3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA4288C93;
	Sat,  3 Aug 2024 13:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKxSATdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A487C88CC9; Sat,  3 Aug 2024 13:13:09 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F2F88C45
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso57775805e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683586; x=1723288386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cmeWB+D0lILjJuJwQtC1PhEdk3GWPK+PYFgpMfusl/Y=;
 b=YKxSATdm81Qj2wnQNEsC1WHEsKdcJBXAhOe+2CdDNCOIN2DqEs5xtMzPeDXMMHx/0s
 jS6JJ47UshfB4xYb8pglEL4jSUDDtH5LFHFNUCO2Md5A0u3q42hDEKRfDOq9gLjRhmKO
 DJKi0nS/QYH812DxQ8GzD0C46ctM+TXWr6ngQwtGYGsGE1bRw43BvWOALoZw/RUFAxoq
 JnQULR5uUl6oF8oOsnxPA5DLzEsheQRlFtzuGgUdqglXsjM5lEieW3wmdMlancpizMXo
 5JI/ZTA40LKzpKK6pADOuwL8tSNGcZzors2r9ZYcGo1cBC3laOnwH6PqHW/zDR/ljhp+
 4FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683586; x=1723288386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmeWB+D0lILjJuJwQtC1PhEdk3GWPK+PYFgpMfusl/Y=;
 b=olP0VrClGArerrpvmT0P0+Z3ku7KxYBnHYT5o2IhQOM1u7dB7uJNYd0XhlR+tuksNo
 tzR+BESSfxnOtiVDudZQLyAeSpghqT/tFCp/II7kYWarFetmDiDwW1gFvXz7KtmazPyi
 xKtwKNYAZ9t9tpDxZ8rBifFjKgt/IfMpx0330gTi0M3Y5E0k8kFW5T+7Ad5UywHjz99V
 +sHhOZ/x1Lx5WZbTq+Aza9Wu44ulB9oRMiUtaz6FtUTkk19hVFNIcNloxugTYkofyTtr
 Ki13P4p18s9tOEwlMsYacOVDy/VaWveYKeI0/3vCE5xeg0YsyjM098Xne/6RdOqfH5/1
 eLOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYRR72QiQ8UoQbAilmE2luh673Vte9ZG1XNIQJ7whJWlgjHCmdqO5KTIjq+svrA5qPFipuVukr0nQyZp6zPKLmdmUDw==
X-Gm-Message-State: AOJu0Yw4Tyi/uuJ9UCL5pI5q+vLKZphBnCNL9tXy6jlKs0YAsye9Mi99
 ufhKNDvOKWGhDlZmcZglD/YDwXD65OvPH3W81jW24iv71K+lES6r
X-Google-Smtp-Source: AGHT+IGhld0v0OJECw8G+gxiq4J2bGgWvXB/ropiZzhcIrZbtEkTdTFnPAVT+NmXIFXyx88eu9dBtA==
X-Received: by 2002:a05:600c:3ca8:b0:426:5dde:627a with SMTP id
 5b1f17b1804b1-428e6b7a333mr45233435e9.23.1722683586137; 
 Sat, 03 Aug 2024 04:13:06 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 4/8] clk: mediatek: mt7622: add missing clock define for
 MAIN_CORE_EN
Date: Sat,  3 Aug 2024 10:43:22 +0200
Message-ID: <20240803084329.1688-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

