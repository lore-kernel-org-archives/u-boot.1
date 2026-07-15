Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A342AC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C353784CCA;
	Wed, 15 Jul 2026 16:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="J1HvkjtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D93DA84CAF; Wed, 15 Jul 2026 16:29:07 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8E884CA0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so13128295e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125743; x=1784730543; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tvX7txqC/GX/NaUoLIcBSgiBicfduKVUpR5wn4Itu0=;
 b=J1HvkjtR2LkOoS3ZK8KLgsi3DEDhPGH988qLcU/kI06S1v+n927HPXy9tfsVO3zjoS
 EsFF5PsxLDZbwS7CqykYoUz7SoRu8VDmQmAeAoyEy8WIK7lTqCcADmDiy1lyQhaeGGvn
 Qcnrb+zpLQQiuSDjGJMDLn1u/qszqUSgcd7xjN0ZsjYEVSsqjucwbaSmzOsFrXNuuqbB
 TsMEHSIrGKB3ermD0j+mD2vPkk4OmDos71/F3S35KwasWnzxs+xxNDqZqmCOn3ZhO94o
 lk1Fm8wGm2OHs9ZX/fRrbRO0UOuN+gykGMa98t+3himyV+CtFDwgwj3v1gVsGGIPIZ/9
 55+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125743; x=1784730543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0tvX7txqC/GX/NaUoLIcBSgiBicfduKVUpR5wn4Itu0=;
 b=T4Y7iNR/wStg7KFxh46lkKGGJn0PN7q9Kr83W/UiuRQFOCxKp7z90lkKO6B2f/fUnI
 Gd/m0B8l5+ko+2BKLx8oQCDSRSTjjPZZkgBDT1aHTOpo+LYodg5YfbrwEmSlSyv/XWAq
 p3q3DVgPu8t8CMJDCQhdESh/ReEXGUoWMAjQFpzIngnQ4PlLu4kFMZjLLxPBvRbde1vM
 2TnqQpxP4Kw/lesBygfg754Nl4oB3OUZsbDdBBa7JTcHnk3vsbNgZfOYxbztJ1LAxMQR
 QsSPaQsEdqC0rk+EGFjT6GHNbi0nIh83WrW3GqiAbypJIogcucTwMlaRER8EdhbTefb5
 FQVA==
X-Gm-Message-State: AOJu0Yzjn45K+EcWXYjTigpEtEj1Isyn7NM6RGQSielrQvVO9uHl4INy
 lNMSkoCah2hX8J4vIIWzzUlDdW7faCoggP7MrkGSZGdYmJ01/bBGsvQ76GbyAYsRCqU=
X-Gm-Gg: AfdE7cmkOPFurK/UwxRgcpIMvxIIQXliGxWMlqC+50lTQdgIPICrx88Tu2iClTbT/Zd
 HyXdoA7/PvIz5qkHW2qMj52d+wrnSyLJG4bIX4kY1K4GPAs0xN+tnH5LcC3y7jP9xKJ6XI/RVBl
 TLZtp4fHczqbeVPZ8uXE41eM3ZWTzdm6yMf1aqWyxHb0ZMF5MH4+Rm21hlWAqveliVzqdYWnacs
 0fpzGN1psevM1sra4FE5m4B7whIPo4dDETrEAUHLjc5V1nKpbNkknFwgSDQvgSdQhXuDRDpx2xS
 4A46U6FRZXhanXeFqc3/7WMImfS6QQU3Ccw8cyJJR+oqyVaZo5y1mwH0ko37XiwwtuMWy93yvsa
 /lpt9ktb4igZgp1oEnciapcpXhp/guDk2f5icnBQwI0zk4EOog5Gh0wUIyOP5XBXRJYKuds5jp7
 w5WDP6dENpuJteB8RJbFAIuUTEZsH92hEgI8DldoXEjSNPwPHv0F8nHmtBqj8VBh0f/0kUvI6Xj
 AZj8yJHRSZj6KQn/Hp5WD9PfZnUGUNCqBmuV6WSfRtCEzbzs1erhcCOTl5orKi5dRMbSUvLxP/M
 Tm2X8lU=
X-Received: by 2002:a05:600c:8b32:b0:493:c566:7bd6 with SMTP id
 5b1f17b1804b1-493f88db5a9mr177968535e9.18.1784125742931; 
 Wed, 15 Jul 2026 07:29:02 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:29:02 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:59 +0200
Subject: [PATCH v2 31/32] clk: mediatek: remove the dedicated clock gate
 code path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-31-23e907516010@baylibre.com>
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

Now that every MediaTek SoC describes its clock gates through struct
mtk_clk_tree and handles them with the generic topckgen ops, nothing uses
the dedicated clock gate code path anymore.

Remove struct mtk_cg_priv, the mtk_clk_gate_ops (of_xlate/enable/disable/
get_rate/dump) and mtk_common_clk_gate_init() from clk-mtk. Clock gate
controllers are now just regular mtk_clk_tree providers.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 113 -----------------------------------------
 drivers/clk/mediatek/clk-mtk.h |  13 -----
 2 files changed, 126 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 61d718f162d..a5e983c44ac 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1039,90 +1039,6 @@ static void mtk_infrasys_dump(struct udevice *dev)
 }
 #endif
 
-/* CG functions */
-
-static const int mtk_clk_gate_of_xlate(struct clk *clk,
-				       struct ofnode_phandle_args *args)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	int ret;
-
-	ret = mtk_common_clk_of_xlate(clk, args, tree);
-	if (ret)
-		return ret;
-
-	if (clk->id >= priv->gates_offs &&
-	    clk->id < priv->gates_offs + priv->num_gates)
-		return 0;
-
-	return -ENOENT;
-}
-
-static int mtk_clk_gate_enable(struct clk *clk)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate;
-
-	if (clk->id < priv->gates_offs)
-		return -EINVAL;
-
-	gate = &priv->gates[clk->id - priv->gates_offs];
-	return mtk_gate_enable(priv->base, gate);
-}
-
-static int mtk_clk_gate_disable(struct clk *clk)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate;
-
-	if (clk->id < priv->gates_offs)
-		return -EINVAL;
-
-	gate = &priv->gates[clk->id - priv->gates_offs];
-	return mtk_gate_disable(priv->base, gate);
-}
-
-static ulong mtk_clk_gate_get_rate(struct clk *clk)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate;
-	struct udevice *pdev;
-
-	if (clk->id < priv->gates_offs)
-		return -EINVAL;
-
-	gate = &priv->gates[clk->id - priv->gates_offs];
-
-	if (gate->flags & CLK_PARENT_EXT)
-		return mtk_ext_clock_get_rate(priv->tree, gate->parent);
-
-	pdev = mtk_clk_parent_get_provider(gate->flags);
-	if (IS_ERR(pdev))
-		return -ENOENT;
-
-	return mtk_clk_find_parent_rate(clk, gate->parent, pdev);
-}
-
-#if CONFIG_IS_ENABLED(CMD_CLK)
-static void mtk_clk_gate_dump(struct udevice *dev)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(dev);
-	const struct mtk_clk_tree *tree = priv->tree;
-	u32 i;
-
-	for (i = 0; i < priv->num_gates; i++) {
-		const struct mtk_gate *gate = &priv->gates[i];
-
-		printf("[GATE%u] DT: %u", i, gate->id);
-		mtk_clk_print_mapped_id(gate->id, i + priv->gates_offs, tree->id_offs_map);
-		mtk_clk_print_rate(dev, i + priv->gates_offs);
-		mtk_clk_print_single_parent(gate->parent, gate->flags);
-		printf("\n");
-	}
-}
-#endif
-
 const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.of_xlate = mtk_apmixedsys_of_xlate,
 	.enable = mtk_apmixedsys_enable,
@@ -1166,16 +1082,6 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 #endif
 };
 
-const struct clk_ops mtk_clk_gate_ops = {
-	.of_xlate = mtk_clk_gate_of_xlate,
-	.enable = mtk_clk_gate_enable,
-	.disable = mtk_clk_gate_disable,
-	.get_rate = mtk_clk_gate_get_rate,
-#if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_clk_gate_dump,
-#endif
-};
-
 int mtk_common_clk_parent_bind(struct udevice *dev)
 {
 	/*
@@ -1199,22 +1105,3 @@ int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
 
 	return mtk_clk_tree_register_provider(dev, tree);
 }
-
-int mtk_common_clk_gate_init(struct udevice *dev,
-			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates, int num_gates,
-			     int gates_offs)
-{
-	struct mtk_cg_priv *priv = dev_get_priv(dev);
-
-	priv->base = dev_read_addr_ptr(dev);
-	if (!priv->base)
-		return -ENOENT;
-
-	priv->tree = tree;
-	priv->gates = gates;
-	priv->num_gates = num_gates;
-	priv->gates_offs = gates_offs;
-
-	return 0;
-}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 437797dd0df..a6251547ecc 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -284,26 +284,13 @@ struct mtk_clk_priv {
 	const struct mtk_clk_tree *tree;
 };
 
-struct mtk_cg_priv {
-	void __iomem *base;
-	const struct mtk_clk_tree *tree;
-	const struct mtk_gate *gates;
-	int num_gates;
-	int gates_offs;
-};
-
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
 extern const struct clk_ops mtk_clk_fixed_pll_ops;
 extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
-extern const struct clk_ops mtk_clk_gate_ops;
 
 int mtk_common_clk_parent_bind(struct udevice *dev);
 int mtk_common_clk_init(struct udevice *dev,
 			const struct mtk_clk_tree *tree);
-int mtk_common_clk_gate_init(struct udevice *dev,
-			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates, int num_gates,
-			     int gates_offs);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.54.0

