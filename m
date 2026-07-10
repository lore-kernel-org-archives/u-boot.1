Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36C0C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E16E84AA1;
	Fri, 10 Jul 2026 20:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Km+1MJE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB90684B06; Fri, 10 Jul 2026 20:59:17 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854EC84A78
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so640039a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709954; x=1784314754; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywC9/1/035Q+/eWFTomBhj/kOuVYIvkNZEIzdfOj6fM=;
 b=Km+1MJE6seaD9d7tBA8HKPAFonC98tE+CDv8xNzANky50KNDz8wjFBTyhbqo+argoc
 PSNb6goZbnqOIh+QCbyDB5dGhNWmR5FyG5m8kic0QLG/RGZlUsLe4CsGGJpd67ilyL78
 kPwCg0WJfxzCCtBmwzeq8byyzs2TuG0FkaW9u9yRZHiY4xy68RcL6KmBasq6JJGLP6F5
 FecCdbhHv3twO8YGdx305dqyfuTzRg7GPV1tGPxnqYjZOB2CHiyRJe9Z9HRb3PEzGE6Y
 yBbQxYCgFdHzTUJ6DSdy8N8aTc5wgHKg7i6WRRHYZcxxFhsYs7FVjgdrDY0eWnnQdQv4
 sv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709954; x=1784314754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ywC9/1/035Q+/eWFTomBhj/kOuVYIvkNZEIzdfOj6fM=;
 b=tU2adeTqbGnTPBqh/n5Ezs+BRY6ehd0TJVyElQpPOah9hnO8vDs+0f33e26ey98nZu
 t/NlcnN1Lb/gC2AogVs4CZpwIzk17QYqr/XJ3Go/t4qiNczt8MrCJ7PiBoVchJfaj/QK
 7ZWqdrLi/VzBFYR5HNr4B/5kIxbjumO0TB/hs+mW54gpMik+QBrNMiyCGt4AY60ChC/O
 LXZ/ZjZcdfQBxcnT3aNc5mRFtULuofpHI3zxIPbnYS0Kq6/iZ5Y9Nzdm+Kgwn8R3hhq8
 StmPa8iN1edAfpOE3fhkBDjgejAEICawcQzkyM/NMSwyi81vyjpA/N7ZIVZ/U1Yg/eK+
 0v8w==
X-Gm-Message-State: AOJu0YzOlUKMr6NiJQUYzE0SqPvB4sZY9uDwYxdMwTMTUWilz5ZHOCJd
 199kLQl1wXr4TWLNYdginQk6uT1DBpTpjkBauSpoQqlWjywqPa6XQ21ohDaPsc5wyL/Mzo0uOeW
 /vvIa
X-Gm-Gg: AfdE7cnm6Ku4dnzyc4yCTqnCmFraBf/E+PsSgjOnkpdB7yjT6RDtRf3prD9fRDQXb2Q
 cM77BIThga68KGo1k0QikkAWWNYIIzUPbzK/NaKmLXCxa/+AoseTjTpDJuqyoPEiEuvdnzbCSZ5
 oKdDPB0B2ewx9Z8M2CxUeutZ9uhQhKWnWLeKE99EVM3SweA6PguNLkNmb5t6GZN8pSuwLmMPa+G
 A53Ly6m9p/npknG8rnbb6Tf81j7bewARIhZ68N7ORogPrnumUQEz+fg52n22TUSlIrdNZp0d3aL
 IN/fo+Xvit4QkCwNkXXt1i857/jfiLVgMGHwiQd1ICFbtmq2JXu/4Ulgx9LCNKXb7YWN+HM2UEK
 V8gVsohn8LgZTXfzsby73jo5igvcXylPK5TsQxjcDI3ScDeDWat6nEnvYEqXROLl1ZcZNIsEr/Y
 3OwDg4R8RXN8JOyLrR
X-Received: by 2002:a05:6820:1ca9:b0:6a1:8223:466b with SMTP id
 006d021491bc7-6a39a600be0mr341133eaf.28.1783709954050; 
 Fri, 10 Jul 2026 11:59:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:18 -0500
Subject: [PATCH v2 02/24] clk: mediatek: add registration function for
 clock tree types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-2-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=FxDYRCoWp44quwNPpcomuDYE4Vixo1edepqsmkdZX2M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUBm7rn/3Sxt+BaYn9qa+Iev/Hv/+p6jQP+vw
 d1lCO+r9OiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAZhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/As1YH/jrqVlrOuKefmkyUKPf0UxvSr/l4Vj8W2FmVICk
 8SqIZdXakfp8mjH2+U5vP3NYKLHYNz07maYf9XVzANFncFshT0dXn2ESkNS3L1YIcnNlJW9Lv5O
 LLlLCWhV5xGn/m+dvf/grDAASiNXnsk4Ds/+2FwnZCbEJRcjBVagmf1FupSOznwEMGAsqCa1aRR
 LLXWXcSbje546w2RooM21xJe9ZC/ZQfTL0GmH477XIm0GWAOcBFhshrTvg+M7N/CatMdzERU69E
 5M3v1Sw1/Wm0kZl1k+NZzd9SE3NN0tNUpPEyWnApFVSfyGDpTGI6iyViw3lY51HZVGDMG/kLQlV
 rXDU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a new enum, field and function for registering clock tree types.
These types will be later used when looking up parent clocks. This
will replace fragile code that depends on lookup up devices by driver
names or ops.

We also need a way to ensure that any parent clock trees are probed
before trying to use a clock tree that depends on them. Since the
devicetree does not provide these relationships and there are only
a small number of clock parent providers (2 or 3 per SoC) vs. a large
number of clock trees that depend on them, it will simpler to just
always probe the parent clock trees on bind rather than trying to
add device info to all of the clocks to describe their parent
relations. For this, a mtk_common_clk_parent_bind() is added that the
drivers will use to set DM_FLAG_PROBE_AFTER_BIND.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mtk.h | 17 +++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9d0a6cd79cf..da584aba0c3 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -34,6 +34,27 @@
 #define SCP_AXICK_DCM_DIS_EN		BIT(0)
 #define SCP_AXICK_26M_SEL_EN		BIT(4)
 
+static struct udevice *mtk_clk_providers[MTK_CLK_TREE_NUM_TYPES];
+
+static bool mtk_clk_tree_type_is_provider(enum mtk_clk_tree_type type)
+{
+	return type != MTK_CLK_TREE_NONE && type < MTK_CLK_TREE_NUM_TYPES;
+}
+
+static int mtk_clk_tree_register_provider(struct udevice *dev,
+					  const struct mtk_clk_tree *tree)
+{
+	if (!mtk_clk_tree_type_is_provider(tree->type))
+		return 0;
+
+	if (mtk_clk_providers[tree->type])
+		return -EEXIST;
+
+	mtk_clk_providers[tree->type] = dev;
+
+	return 0;
+}
+
 /* shared functions */
 
 static const int mtk_common_clk_of_xlate(struct clk *clk,
@@ -1182,6 +1203,17 @@ const struct clk_ops mtk_clk_gate_ops = {
 #endif
 };
 
+int mtk_common_clk_parent_bind(struct udevice *dev)
+{
+	/*
+	 * Clock trees that provide parent clocks need to be probed right away
+	 * so that any clock depending on them will work correctly.
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
 static int mtk_common_clk_init_drv(struct udevice *dev,
 				   const struct mtk_clk_tree *tree,
 				   const struct driver *drv)
@@ -1204,7 +1236,7 @@ static int mtk_common_clk_init_drv(struct udevice *dev,
 	priv->parent = parent;
 	priv->tree = tree;
 
-	return 0;
+	return mtk_clk_tree_register_provider(dev, tree);
 }
 
 int mtk_common_clk_init(struct udevice *dev,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b39a62edc43..ce0685b830e 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -32,6 +32,15 @@
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
+/* These get matched to CLK_PARENT_* when looking up parent clocks. */
+enum mtk_clk_tree_type {
+	MTK_CLK_TREE_NONE,
+	MTK_CLK_TREE_APMIXED,
+	MTK_CLK_TREE_TOPCKGEN,
+	MTK_CLK_TREE_INFRASYS,
+	MTK_CLK_TREE_NUM_TYPES
+};
+
 /* struct mtk_pll_data - hardware-specific PLLs data */
 struct mtk_pll_data {
 	/* unmapped ID of clock */
@@ -261,6 +270,13 @@ struct mtk_clk_tree {
 	const int num_muxes;
 	const int num_gates;
 	u32 flags;
+	/*
+	 * Set this if this tree provides a specific type for parent lookup.
+	 * Devices that set this should also include mtk_common_clk_parent_bind()
+	 * in the driver bind function to ensure that it will be registered as
+	 * a provider.
+	 */
+	enum mtk_clk_tree_type type;
 };
 
 struct mtk_clk_priv {
@@ -284,6 +300,7 @@ extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
 extern const struct clk_ops mtk_clk_gate_ops;
 
+int mtk_common_clk_parent_bind(struct udevice *dev);
 int mtk_common_clk_init(struct udevice *dev,
 			const struct mtk_clk_tree *tree);
 int mtk_common_clk_infrasys_init(struct udevice *dev,

-- 
2.43.0

