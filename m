Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A775BEB3622
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B6B83F0A;
	Mon,  2 Mar 2026 19:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yacLB8ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 067D483F63; Mon,  2 Mar 2026 19:04:46 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F07083A1B
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46394090d2fso1776395b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474682; x=1773079482;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=yacLB8jiPIiPKKW4AbH8g1vchFnhcD7toZ0ve66r2VYHHW1wl5XW0iuVLjtNX/CmNT
 feJgW0/AzP+yXKoB8GnqErCuRg1W7gGjHD5cG955jh5ic1fXIcpHpqObrHAbxXlxU9u7
 FmXxPbdAmHjQCcE2rspNHT1LWC1h6VGS1WyhJIBrM3DFGvO3a7P0YHmQI5ngeU6tcuVo
 fk44cBgERr7Ndh/9o5v0am6DsT4e3L/j6JWVWYFBL/OnyL/jUo75tj051U0pYuNrDMiw
 vobBRBs4eF/3mDeKhppdgHy333mZ0/YpH/1q5RpZA0cTBejhehw9Q7/84S3XUqUNymxb
 Cy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474682; x=1773079482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Z6HAJgraz4h2NN+YeuMwU+ctavLJKBeaQj87gOsYYM=;
 b=G87WIfT6ISGjc0SYJkxrwFTRfVvmoTGCmC9iOIyw4pEyss0iXEDb2lR2XBRYMUNbt3
 xyrXKctuQB4Yh8fDK+H2ZSijD4EIHCR2iP3cjkwYtweH6g0SRS2q7VPFWFqRBPL+PmDN
 v20NsqXSuOu+fuHUZ9ARFyTmuznPP4uDELf9nXwDJ8DsypX4Y8RZIFBlgJimo2jpF7hk
 Wf0qBUSu28eldecrRcHp/0On6G59R7ndPj23Szs9YPqYzLHAn0u5vd+F+CG/AwCWiKVF
 P1SP/JZLtX3nlEfbDZE8XSZHnKQNKP8xfjuZ+2b2GQRzu5BRTBK0/k+5hcP0Ht/KEXEa
 WOtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVtFufGPff5L9wzri5zAQm4N049PuMZkrJnKWw6ICk+skFsH2p8n2lfXiYGoM2yyQQdDVa4XM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4KGGgaEuY79aohzF6ToAptDF+4yRkQDn3D7racd8CgXD1cq4D
 f8dwJriymVmeKPEDHyLddw3bQKUjUXu3WqLOlkIBi8/n2nyKJ3nYoWdJN2KeuiTk5mU=
X-Gm-Gg: ATEYQzxr782GTP5Ijfn2nRLYoxb0SIbT3ArVkW2cxjERGmVFRCDNpTKB54WzigVxzwh
 Uua9S7V5VQ56j/NxRX1CG8ExKWY/i73TpO466eszUZ91IEWdK1VA1kqwGnrySeIXjSx4xylmD7T
 5mq39afhRlTPiUKtWDJrZVcboD9thB+WZw3W1moa9iDrghoP5sZNe3C/zbQM28/7aRCSmVSnAKp
 pQ3HFLBdbC9PnLNuG+Sff/7D5ur61pB4bNrbidb43cI3FR+5nFV+7rlVv/IG7JKecS3CJPZHhu9
 cmI3LyKDDMMdwavHwZdA5UvYR4Y9M7GHtG0jOGjnzzhTiZqZZfOHuFr7aRCMICXslTFTL+/pLrK
 SyT0zll6NhtDqnXFaw9kvCIN00Urmvd9H0ie7TDaN81QRUTULKkiR3s9zR/kO/U/JCyDhz14wwZ
 g0eelCBqp1bIIHmOtH35TScbHAY9MtyiqrwLTv0zY=
X-Received: by 2002:a05:6808:11c5:b0:45c:96bb:1202 with SMTP id
 5614622812f47-464befa2378mr6421986b6e.58.1772474682064; 
 Mon, 02 Mar 2026 10:04:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 12:02:10 -0600
Subject: [PATCH v3 3/7] clk: mediatek: add mtk_clk_id_is_* helper functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mtk-mt8189-clocks-v3-3-c48ec60344fd@baylibre.com>
References: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
In-Reply-To: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9958; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rQtZzGMOm61RptZkKnMBsoG1ARBDiNoGJZyL1uCk2Gs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdEUceivcoAFmdyOokyUzb8Z/M4v9+9RmQQKj
 q15Tk85r7+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXRFBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwPMH/2/RBIh4iRQlWzN+d78pMRUqvpp4+vx+bPgQQIZ
 e2/3haiBAPVJPjEBbWz35ATYYy0NlZ1k1omMlhkQuzyhOBHg52xbUCQOdVDySLV7KN36Fnciwmo
 NpE4/qKG++jScHkFFoti4u70tQUXYMgbxk6RLHMBzBzuGYwiJ1cHMAzdsVA/pHNvRzJ8qB2VJKp
 mlhu5ni5HeeIfIR1gRXaUkexXImssC8QKIfjGUvJ3TSsHIrPPs3TtDmkvoFwH3kSZF8voQ2OFp6
 R6p/5vmCdANU/TT7mMYaGE2KM+1J8TY0A5n2DjyBDyRHHOEWcGH05VAhMld7q8zr2rai9d/HB1P
 M8BY=
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

Add helper functions to check if a clock ID corresponds to a particular
clock type (mux, gate, fdiv). This simplifies the code and makes it more
readable.

Additionally, it removes the restriction that fdivs_offs < muxes_offs <
gates_offs by making the checking more strict in some places. This will
allow future drivers to not have to define a mapping to meet this
requirement.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 128 ++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0123b0ce7b1..3bd9021b9cf 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -85,6 +85,34 @@ static int mtk_common_clk_get_unmapped_id(struct clk *clk)
 	return -ENOENT;
 }
 
+static bool mtk_clk_id_is_pll(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->plls && mapped_id < tree->num_plls;
+}
+
+static bool mtk_clk_id_is_fclk(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->fclks && mapped_id < tree->num_fclks;
+}
+
+static bool mtk_clk_id_is_fdiv(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->fdivs && mapped_id >= tree->fdivs_offs &&
+	       mapped_id < tree->fdivs_offs + tree->num_fdivs;
+}
+
+static bool mtk_clk_id_is_mux(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->muxes && mapped_id >= tree->muxes_offs &&
+	       mapped_id < tree->muxes_offs + tree->num_muxes;
+}
+
+static bool mtk_clk_id_is_gate(const struct mtk_clk_tree *tree, int mapped_id)
+{
+	return tree->gates && mapped_id >= tree->gates_offs &&
+	       mapped_id < tree->gates_offs + tree->num_gates;
+}
+
 static int mtk_dummy_enable(struct clk *clk)
 {
 	return 0;
@@ -375,15 +403,10 @@ static const int mtk_apmixedsys_of_xlate(struct clk *clk,
 		return ret;
 
 	/* apmixedsys only uses plls and gates. */
+	if (!mtk_clk_id_is_pll(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->plls && clk->id < tree->num_plls)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
@@ -497,7 +520,7 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 	u32 pcw = 0;
 	u32 postdiv;
 
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs)
+	if (!mtk_clk_id_is_pll(priv->tree, clk->id))
 		return -EINVAL;
 
 	mtk_pll_calc_values(priv, clk->id, &pcw, &postdiv, rate);
@@ -515,7 +538,7 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	u32 pcw;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
 	}
@@ -541,7 +564,7 @@ static int mtk_apmixedsys_enable(struct clk *clk)
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_enable(priv->base, gate);
 	}
@@ -579,7 +602,7 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 	u32 r;
 
 	/* GATE handling */
-	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
+	if (mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
 		return mtk_gate_disable(priv->base, gate);
 	}
@@ -649,23 +672,11 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 		return ret;
 
 	/* topckgen only uses fclks, fdivs, muxes and gates. */
+	if (!mtk_clk_id_is_fclk(tree, clk->id) && !mtk_clk_id_is_fdiv(tree, clk->id) &&
+	    !mtk_clk_id_is_mux(tree, clk->id) && !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->fclks && clk->id < tree->num_fclks)
-		return 0;
-
-	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
-	    clk->id < tree->fdivs_offs + tree->num_fdivs)
-		return 0;
-
-	if (tree->muxes && clk->id >= tree->muxes_offs &&
-	    clk->id < tree->muxes_offs + tree->num_muxes)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
@@ -723,21 +734,22 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_fclk(tree, clk->id))
+		return tree->fclks[clk->id].rate;
+
+	if (mtk_clk_id_is_fdiv(tree, clk->id))
+		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
+
+	if (mtk_clk_id_is_mux(tree, clk->id))
+		return mtk_topckgen_get_mux_rate(clk, clk->id - tree->muxes_offs);
+
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
 	}
 
-	if (clk->id < priv->tree->fdivs_offs)
-		return priv->tree->fclks[clk->id].rate;
-	else if (clk->id < priv->tree->muxes_offs)
-		return mtk_topckgen_get_factor_rate(clk, clk->id -
-						    priv->tree->fdivs_offs);
-	else
-		return mtk_topckgen_get_mux_rate(clk, clk->id -
-						 priv->tree->muxes_offs);
+	return -ENOENT;
 }
 
 static int mtk_clk_mux_enable(struct clk *clk)
@@ -746,7 +758,7 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
@@ -778,8 +790,7 @@ static int mtk_topckgen_enable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_gate_enable(priv->base, gate);
@@ -794,7 +805,7 @@ static int mtk_clk_mux_disable(struct clk *clk)
 	const struct mtk_composite *mux;
 	u32 val;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	mux = &priv->tree->muxes[clk->id - priv->tree->muxes_offs];
@@ -819,8 +830,7 @@ static int mtk_topckgen_disable(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_clk_tree *tree = priv->tree;
 
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates) {
+	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
 		return mtk_gate_disable(priv->base, gate);
@@ -836,8 +846,7 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 	int parent_unmapped_id;
 	u32 parent_type;
 
-	if (!priv->tree->muxes || clk->id < priv->tree->muxes_offs ||
-	    clk->id >= priv->tree->muxes_offs + priv->tree->num_muxes)
+	if (!mtk_clk_id_is_mux(priv->tree, clk->id))
 		return 0;
 
 	if (!parent_priv)
@@ -917,20 +926,11 @@ static const int mtk_infrasys_of_xlate(struct clk *clk,
 		return ret;
 
 	/* ifrasys only uses fdivs, muxes and gates. */
+	if (!mtk_clk_id_is_fdiv(tree, clk->id) && !mtk_clk_id_is_mux(tree, clk->id) &&
+	    !mtk_clk_id_is_gate(tree, clk->id))
+		return -ENOENT;
 
-	if (tree->fdivs && clk->id >= tree->fdivs_offs &&
-	    clk->id < tree->fdivs_offs + tree->num_fdivs)
-		return 0;
-
-	if (tree->muxes && clk->id >= tree->muxes_offs &&
-	    clk->id < tree->muxes_offs + tree->num_muxes)
-		return 0;
-
-	if (tree->gates && clk->id >= tree->gates_offs &&
-	    clk->id < tree->gates_offs + tree->num_gates)
-		return 0;
-
-	return -ENOENT;
+	return 0;
 }
 
 static int mtk_clk_infrasys_enable(struct clk *clk)
@@ -939,7 +939,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
 		return mtk_clk_mux_enable(clk);
 
 	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
@@ -952,7 +952,7 @@ static int mtk_clk_infrasys_disable(struct clk *clk)
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
-	if (!priv->tree->gates || clk->id < priv->tree->gates_offs)
+	if (!mtk_clk_id_is_gate(priv->tree, clk->id))
 		return mtk_clk_mux_disable(clk);
 
 	gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
@@ -1004,13 +1004,13 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong rate;
 
-	if (clk->id < priv->tree->fdivs_offs) {
+	if (mtk_clk_id_is_fclk(priv->tree, clk->id)) {
 		rate = priv->tree->fclks[clk->id].rate;
-	} else if (clk->id < priv->tree->muxes_offs) {
+	} else if (mtk_clk_id_is_fdiv(priv->tree, clk->id)) {
 		rate = mtk_infrasys_get_factor_rate(clk, clk->id -
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
-	} else if (!priv->tree->gates || clk->id < priv->tree->gates_offs) {
+	} else if (!mtk_clk_id_is_gate(priv->tree, clk->id)) {
 		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
 						 priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */

-- 
2.43.0

