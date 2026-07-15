Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02446C4450B
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C3C84C13;
	Wed, 15 Jul 2026 16:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="elQYks0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC31B84C06; Wed, 15 Jul 2026 16:28:38 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B407584BB8
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so22963235e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125716; x=1784730516; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+X3qB8bNVuhmrP6W8WRgI1jEnXhfxdfNlHIaXmBN3A=;
 b=elQYks0w1d4A/RDotfHTkFF7itZJCWgLE9HGNn0T8Jx+7ANOWkKy8w8uLFDG3xYFfY
 /OaSugGlWrL25L3QyX/yKfzPWBtUNUWR/33fv/UIW2tLhB2x1ofgRySLr3GnWKp43/yV
 +oAlZVdzPkiMp0UVu7x2LYJlkR3gm5aEmujV/ARiukuKhRnGwZFtDT9Fgm73jwDvD+xx
 4wwla4em92AcSPmJ3ve0aEeT6hXDpWhGvaVhVz/yVOhwnMaLlyspdcHBD5rzt4hKQKns
 ryh0ShSzc3tjFpAcH9eVvumIYcGzAucwG3P+ivCl+3MAsAKVKFBkmlVMRvpI9UWOkvIq
 m0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125716; x=1784730516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b+X3qB8bNVuhmrP6W8WRgI1jEnXhfxdfNlHIaXmBN3A=;
 b=NJVGa066sr+dFv8Vy0B4vZEzkumsCFstHS54WaFFOLX6QElaE3ETvIxBf/iQ5T2Wjo
 e1cs86+/Pq+v6q+9cYz1BtGE0ziAtyR1oHAgg8hscCTKUNylv/M/tVgP27MsIthcyQOx
 IPMs3LjhFop6I3xNeMkd2X1D/XYubduhTSB0frjMwgGtUlM8QtG3WnP993JA1MtW17fz
 6PvRuZpPmXEE763rNrd/fCEwmfSlYcrUdPBjPAJgFLof+XfIwL3BYk41XnIbrKih31/M
 Cc7ne4kd/Gs+V8H+THwnmgCCF5ZC0kFIYnhd9X1mmMFOJUq9YkHyE/O0o3qjt3XDGdYM
 mOpA==
X-Gm-Message-State: AOJu0Yw+1IYUtrLvKU8Zzls48DwLH2aRGOKdMOcHDESAGHjVOASOf2Sr
 sDjSiDv5htt6nKZKu6tK+B0W4C3Jsim8OLsZ7bof1bRcqBpX9+1CSXqBepY3BPFJolM=
X-Gm-Gg: AfdE7cmkA79GyqTsqH8WGZczDi3L9aelky6jIoXIHE/LA5jCsqoI/ZNC7s94vWK9EGO
 NG7Oe2URZ67hMi4LiN1uQQOyBCondtg7lizGm0bkzWs7+uwl74J+juIbrfnEgXoDhhdf1bGlYLf
 jSHHy6CFA+O06jru3U+7g4pUmk1xHFwLsZM21I1TYz3HrIxdWSyWy8OfD/Rp2r5Pb753ncbrRg3
 M3U9OYjyGIzhaLKk+gJBkx2A08ef5EY25bLEJr9aKBvb7tWN2xqk2fmPdRDTepsaKweTMPzFPpA
 SCEhFX+lwIqgi2M4aXqQ7bH5ZNRFT5GV1eWhjPuVWwTzAYpIOZ/YIIL6Cg6vPx1avQz6DRDGDTC
 eMdQ0TN0hCkZZcSkyQlyJqw4bvN5mrLJdv49eTEhZU4XTDvsf41L1FkPGLJLpInQwtg6K01Zhlf
 KzDNLPHrToyEccO+33qSFch5Mw90DZjCiaIUKI2g2ADZ9ObvfLxYbEG9t8PKxA8xZVT0XBpyg5T
 uOLhnvm7fsxfNhNjhnduZxQVf5NjFgl21XI5vAHIlMMIbvWf3pOOZTgJiLAZ/bOsMj4YMtT
X-Received: by 2002:a05:600c:1f94:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4953bfffbc8mr35267455e9.0.1784125716142; 
 Wed, 15 Jul 2026 07:28:36 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:40 +0200
Subject: [PATCH v2 12/32] clk: mediatek: mt7986: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-12-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

Pass each controller's struct mtk_clk_tree through the driver data and use
the generic probe function for the MT7986 clock drivers, instead of a
dedicated probe per controller.

The fixed-pll, topckgen and infracfg controllers keep their own U_BOOT_DRIVER
since they rely on dedicated ops and on the parent bind() callback, but they
now get their tree from the compatible data. The topckgen probe still
performs its SoC specific register tweaks.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index cadb944d551..23642eba40a 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -572,29 +572,34 @@ static int mt7986_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
-	{ .compatible = "mediatek,mt7986-fixed-plls" },
-	{ .compatible = "mediatek,mt7986-apmixedsys" },
+	{
+		.compatible = "mediatek,mt7986-fixed-plls",
+		.data = (ulong)&mt7986_fixed_pll_clk_tree
+	},
+	{
+		.compatible = "mediatek,mt7986-apmixedsys",
+		.data = (ulong)&mt7986_fixed_pll_clk_tree
+	},
 	{}
 };
 
 static const struct udevice_id mt7986_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt7986-topckgen" },
+	{
+		.compatible = "mediatek,mt7986-topckgen",
+		.data = (ulong)&mt7986_topckgen_clk_tree
+	},
 	{}
 };
 
-static int mt7986_fixed_pll_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7986_fixed_pll_clk_tree);
-}
-
 static int mt7986_topckgen_probe(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
 
 	priv->base = dev_read_addr_ptr(dev);
 	writel(MT7986_CLK_PDN_EN_WRITE, priv->base + MT7986_CLK_PDN);
 
-	return mtk_common_clk_init(dev, &mt7986_topckgen_clk_tree);
+	return mtk_common_clk_init(dev, tree);
 }
 
 U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
@@ -602,7 +607,7 @@ U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7986_fixed_pll_probe,
+	.probe = mt7986_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -620,21 +625,19 @@ U_BOOT_DRIVER(mt7986_clk_topckgen) = {
 };
 
 static const struct udevice_id mt7986_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7986-infracfg" },
+	{
+		.compatible = "mediatek,mt7986-infracfg",
+		.data = (ulong)&mt7986_infracfg_clk_tree
+	},
 	{}
 };
 
-static int mt7986_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt7986_infracfg_clk_tree);
-}
-
 U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.name = "mt7986-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt7986_infracfg_probe,
+	.probe = mt7986_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

