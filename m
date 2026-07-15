Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6A3C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D7084C6C;
	Wed, 15 Jul 2026 16:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="oww4KjOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF7C84C5C; Wed, 15 Jul 2026 16:28:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9509684C1D
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so3159961f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125729; x=1784730529; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkfqA/5pDde9EJu+fkfgPo2CBP3mLsefrQWMHk2/sdw=;
 b=oww4KjOQyZs3cEZREm3dqzDN30icXCus2cKVYZ3K0ZzGxnXYsThCt2BakNbO9hLOFN
 GJbsD5v2MvRM6AYMaNhSjv0puRgFhuDomBWro1Iv10U/Cd6gxn71YgG08lkvPyaSZU9x
 ZYUwtNYGxByDr82XekRnF0OgLF9mR0Cw4pDMTx6Irm/bz/TblrpVveAsKRGHolhDcj+k
 7XyPgk49whZoaS4RFM5Cv9yJpqY/1QYBQu9XyHsKHnRRidbNSXwD+Sz7GbdLiuIFYtYj
 y3vWCodr+Q8DK0eOfH8pUbHsrcTpbKhsSn8Il4hDUAVWlOKEMlpW0Ffi8jnK24HDakcJ
 1EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125729; x=1784730529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkfqA/5pDde9EJu+fkfgPo2CBP3mLsefrQWMHk2/sdw=;
 b=b3apNNyIC4oEgyT1hZPwMuRGCAgUWRR8JIXDaTQpJQ4cdZrMjhXNQ7siTxsvtbExqc
 tuN8y9+c0TTB56AIpvJvGYIwzGnhBBZS9NS7fWf/2NX0P3D0G0bxRlwOXW3yAOSg3M/v
 X82IUZYJlAbGCibJil9PdlPXSwuODa79kTVugvJIlA4kcoNDj/kencbx2tVN7P+BZwl1
 oajsoaoV9VqXcf2HoAtpKgDonHVRzVy2lCF4Bbk7o3+L6tmGNDjT+FKD+BCVOIGmsfPu
 vgD0LOOAGFQWCPsY1dKpw/cXbawI3G2yU0kIDp60h42RofqRZPR43mhWi0QdAz6GB3Xy
 dq0A==
X-Gm-Message-State: AOJu0YxAw9v1RayHpDHAeZ6lXu7YGtQ1p7Bgaycc4s/jlqihDXssM1U1
 WasIUnXJlXk30X7bAzYEIq3mDcYpsSMVmruf7yxsYH7P6k5tXO9Jt2SY/z3eafXmwt4=
X-Gm-Gg: AfdE7ck7H9aAVh0dBNFUwz4HxrrjKSidcjkyLRxXzv4jFn8ojuRNFi7JNywijsI3TXP
 Kr0iQXBTJegGSJ+K+sVlOSpz7E+q9jRg+TMNi6hUrBwzhxCYKCW0QE5oz8lP6oocYMYiiVZe1PG
 x1jfxsD6c4+jm0E1AKjzGXEl5br4TZTdSXhOq2MrH4rCD847vhFcCE1W8rumtr4nGDoRVcQgMHy
 yFeeCCiqCwDltshHnN63DXQ6a8tGFkLszIp7CAh/8HAah2JfJqA5TolbAsKMnrDnul6Socbku5t
 lxDZ2LWWiZypR7+kCXUlavk7xWvmtdf0nRNGXzDCTnHRgfv6cpEmc1Z9NCk1kDPlsHZAygdEYxs
 v7wQK7pBI9btRTMocHDWplZ3qoUbGZJUsPAGbz++SeixHUBBb4HRRBDhVdUP1dCShtrXt5jixzX
 DaczCz/nWoqr4LPGGHIFKeroy7bSirEXZlV1GuWg+ezREgWNEVNM4lidEryhaglGOwWueDpwTcP
 kJElwUDuyR33i5C9MlclCYaqTdHdOBYx7mS3c+GmAeFOLY3STYmKOtvsHkT7GJvQ4nfLiFD
X-Received: by 2002:a05:600c:8509:b0:493:e451:fb8 with SMTP id
 5b1f17b1804b1-49515904c4cmr101158965e9.21.1784125728894; 
 Wed, 15 Jul 2026 07:28:48 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:49 +0200
Subject: [PATCH v2 21/32] clk: mediatek: mt8518: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-21-23e907516010@baylibre.com>
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

Describe the topckgen clock gates directly in a struct mtk_clk_tree,
reference the tree from the driver data and use the generic
mtk_clk_topckgen_ops instead of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 1033ecae187..1c8a8c70956 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1526,6 +1526,8 @@ static const struct mtk_clk_tree mt8518_topckgen_clk_tree = {
 static const struct mtk_clk_tree mt8518_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = top_clks,
+	.num_gates = ARRAY_SIZE(top_clks),
 };
 
 static int mt8518_apmixedsys_probe(struct udevice *dev)
@@ -1538,10 +1540,11 @@ static int mt8518_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8518_topckgen_clk_tree);
 }
 
-static int mt8518_topckgen_cg_probe(struct udevice *dev)
+static int mt8518_clk_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8518_clk_tree, top_clks,
-					ARRAY_SIZE(top_clks), 0);
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
 }
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
@@ -1555,7 +1558,10 @@ static const struct udevice_id mt8518_topckgen_compat[] = {
 };
 
 static const struct udevice_id mt8518_topckgen_cg_compat[] = {
-	{ .compatible = "mediatek,mt8518-topckgen-cg", },
+	{
+		.compatible = "mediatek,mt8518-topckgen-cg",
+		.data = (ulong)&mt8518_clk_tree
+	},
 	{ }
 };
 
@@ -1585,8 +1591,8 @@ U_BOOT_DRIVER(mt8518_clk_topckgen_cg) = {
 	.name = "mt8518-topckgen-cg",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_cg_compat,
-	.probe = mt8518_topckgen_cg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
+	.probe = mt8518_clk_probe,
+	.priv_auto	= sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

