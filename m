Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9627CFD65A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BF1840BE;
	Wed,  7 Jan 2026 17:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F5wRPLX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2616483A26; Wed,  7 Jan 2026 17:22:38 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75608398C
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c7533dbd87so1622304a34.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802954; x=1768407754;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VNnsYUzluZah7JCthe9zOSPNJoqqZGPX0lsyTM7RmkI=;
 b=F5wRPLX2OrI7wj63Xzi8b21twpNLqBB9YoK1NlsrIIvWchWvClhy8eDam2Qkrv+4wG
 FvT3ViEz5Hp/SoLc/dw4aKZSINDMZWfxQcYlXRC/zny+9ucxppflasOuNWcgPj5Txw29
 kd3XgAGyWIufFk+Tvv/wgJA7yfUbrQ5TqcmNsUwu33qJAB78GX1GDd8mfGC4BBqY3Q5W
 V9oCO0ZYCF6eadCo/r6eWcGjS+lOr0+Yq+swKR7lc3iTPkl3LioE5hZ/3ysy/P0UtQPP
 cbCAmBcBv6FjvSqji8pL4xGnZs3AIUIPCQvBtBPmJEn6XB8UOoyrrQZc8ZuDIsrYpnVv
 /XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802954; x=1768407754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VNnsYUzluZah7JCthe9zOSPNJoqqZGPX0lsyTM7RmkI=;
 b=EpDavqD4WhWNOPak/LWi7WfBnVbMse8gu9ZNdoAPppkgQ+wTbiCpwnDuEox3qKVGka
 CFLdi1dBs1B3UWBh1aMLlnbyW7AcH7T5sr4+PSDL0p31duUQNBBpI/On0YyyXgGYFwGO
 cSRR2zu3pQWIrcltzfoXGVVho+9Z9AmkKF/pvYvA4BVCF89q+EuhoWuFqbbBNRz+YIRI
 8YZ/bQg8155KilwGz4p+JNE21aICauDdit+vJufXn26RiRmbyGgNmVuewjSMSfC4iwF1
 fL1pjMouHVPSW66/lAVQo7IEq690WLe/Uzr8sbq9CZgaCjpoPNJ9G+vFHWWGLXDrtTrq
 BXKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPgn5wp+O5hbLKpOTWIKUUxZ7dQLLLAZA/wlM5DNs9AXAvKpeh/XeKsgH9oaiBW6oP3JQ7DT8=@lists.denx.de
X-Gm-Message-State: AOJu0YzPvzn+NU73eyHptqgY1DerCDXN1+pVaoOwgXK0Jw/yFOyw4jXU
 Q7m+JDqVksCyTT4kp5ZFyaDOgCKXkxNjdVNAqPaxvYbPGGxTyFigNLq3knw1E7FoxKg=
X-Gm-Gg: AY/fxX5pgUK3FcZsbAcsEaeWz1iGFevScvr1bHBpGsh6FrRhubp7NzMQjETdlOgXIQK
 GsWIEtgEeOiJrXHKMqrMc0hSeqGHB0jx7kDYoXSXVgTBVmh+uxrK6FQh5irw4LXzNaWdZUTv2xJ
 /FgOIh6Lf/qH/VWLrhTrpMiv5b2v3hJYj7HERiThhYuQbjk7ZkNyd7hiD0gmhli7qxl8iBEW2uR
 gRXlfWf0WZG1P2u6bZtdWH59oIGtRXwicH/kWII7OInIxCI3EPRCpNI11Yb3IVWHKwL1y4gUsBU
 Mn2it3T7PALxXK8XmE6BgMtzmeh2BXrTZ0jr+//3VNQXcsFvKxv5kvsDD/MnM1W//eu76xAT8kn
 nMm6WEWIq3gtyOVbqb15vbON7000rmXPl9QACmrkcoZLFu7CuD2T9575da1FCZoHStILjl/XjYV
 T+i4PyJg81hwpeFOo=
X-Google-Smtp-Source: AGHT+IE5IBlFWDjNS5NCHGIISvfO+zEfmm3tzmSLAJFS0Ei4CMxGmxgqpGAfKmTP/LnkBeOMI+j65Q==
X-Received: by 2002:a05:6830:3103:b0:7c7:6479:38ce with SMTP id
 46e09a7af769-7ce50b8ce7fmr1784320a34.18.1767802954585; 
 Wed, 07 Jan 2026 08:22:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 10:21:13 -0600
Subject: [PATCH v2 7/9] clk: mediatek: allow gates in topckgen drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-7-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VTQb0wPygvFq7lX9ZsvswsYreIjNQQ8htn6irAWc6W8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXogwALbfDBFkcwMILhx1CAMpPPFFe2TY2Ncdk
 MQIcSHSq2eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6IMBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ao6IH/AheqHVJyMwGK41WhxPsTVKFSzyKFZbopNYXHu3
 J75QOiB0r99Qf18vxsce5yTHCAzw//NqCoVZa/73q/wQvRIVcT4wCdEtNpIBPPUNgpe6shZNVCZ
 QMXCsdbZsAGbKPLiDvDraz+4rEDQlIJdGv4Jp2BSltcnMJzRrY0IFz09b4yxkgYCLbtXFEA69V2
 lVCdKOXMKZ3e2G5gcIGgwr3OAhTOTRh2+if6lyaPAyH1A9a6cydCmf7ykfcb39YtnaS6AfzTKf7
 UsHF0PZBDZB/LYjihyDu0yv7Fn3X6PGi3RGMb11xABeg5AYgvC4qHBfecdiEi7Pp12N3nNrI+I6
 wc4Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

Add handling for gates in the topckgen clk drivers. This avoids the need
to have separate topckgen-cg drivers and devicetree nodes for the same
address space and clock ID range.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 61 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e370d304c03..82306ae285c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -582,7 +582,7 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 	if (ret)
 		return ret;
 
-	/* topckgen only uses fclks, fdivs and muxes. */
+	/* topckgen only uses fclks, fdivs, muxes and gates. */
 
 	if (tree->fclks && clk->id < tree->num_fclks)
 		return 0;
@@ -595,6 +595,10 @@ static const int mtk_topckgen_of_xlate(struct clk *clk,
 	    clk->id < tree->muxes_offs + tree->num_muxes)
 		return 0;
 
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates)
+		return 0;
+
 	return -ENOENT;
 }
 
@@ -696,6 +700,14 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
+	}
 
 	if (clk->id < priv->tree->fdivs_offs)
 		return priv->tree->fclks[clk->id].rate;
@@ -740,6 +752,21 @@ static int mtk_clk_mux_enable(struct clk *clk)
 	return 0;
 }
 
+static int mtk_topckgen_enable(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_gate_enable(priv->base, gate);
+	}
+
+	return mtk_clk_mux_enable(clk);
+}
+
 static int mtk_clk_mux_disable(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -766,13 +793,29 @@ static int mtk_clk_mux_disable(struct clk *clk)
 	return 0;
 }
 
+static int mtk_topckgen_disable(struct clk *clk)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+
+	if (tree->gates && clk->id >= tree->gates_offs &&
+	    clk->id < tree->gates_offs + tree->num_gates) {
+		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
+
+		return mtk_gate_disable(priv->base, gate);
+	}
+
+	return mtk_clk_mux_disable(clk);
+}
+
 static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 parent_type;
 
-	if (clk->id < priv->tree->muxes_offs)
+	if (!priv->tree->muxes || clk->id < priv->tree->muxes_offs ||
+	    clk->id >= priv->tree->muxes_offs + priv->tree->num_muxes)
 		return 0;
 
 	if (!parent_priv)
@@ -821,6 +864,16 @@ static void mtk_topckgen_dump(struct udevice *dev)
 		mtk_clk_print_mux_parents(priv, mux);
 		printf("\n");
 	}
+
+	for (i = 0; i < tree->num_gates; i++) {
+		const struct mtk_gate *gate = &tree->gates[i];
+
+		printf("[GATE%u] DT: %u", i, gate->id);
+		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->gates_offs);
+		mtk_clk_print_single_parent(gate->parent, gate->flags);
+		printf("\n");
+	}
 }
 #endif
 
@@ -1124,8 +1177,8 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 
 const struct clk_ops mtk_clk_topckgen_ops = {
 	.of_xlate = mtk_topckgen_of_xlate,
-	.enable = mtk_clk_mux_enable,
-	.disable = mtk_clk_mux_disable,
+	.enable = mtk_topckgen_enable,
+	.disable = mtk_topckgen_disable,
 	.get_rate = mtk_topckgen_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.43.0

