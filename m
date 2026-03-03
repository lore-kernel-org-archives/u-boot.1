Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E9EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA3183F61;
	Tue,  3 Mar 2026 20:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lzGufRJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C187F83F9A; Tue,  3 Mar 2026 20:55:54 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB70883F61
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d19d3c7208so4662763a34.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567750; x=1773172550;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l3xP1fevMeLte5tnBbRaXD9Bg5RfwsGc6PhwSpXmM40=;
 b=lzGufRJP9UonyiXE/g0+tJg2yj0vku8XCXnZYMHExCwuZrreq3LkUVwyBKE0pV5pCY
 NlVYztpUnd/p/2daFgJUbWia6NpNr75OFGhccvpmZa0PNgsq++jSS2frVgkQbTiJ77DM
 uFTSi4O3q8DH8RXWRGDMiYsxdMVykBBzQs+iLES5yMPqQbxO7gHPzS8+gGAMSK5bhDqA
 4P8Ajr+tjV9FIQF7NqwfNp2xJYkZ5/3geSBdbesGcOb4Hcl6ektoisoZY3w2prQY2Blr
 v0bKU6N1xVk4YgVhE5QDnf9Q1zraGrOuLnbDO23eMVwRbcymRqR4k6E4xbu1Aj2pSKYX
 0iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567750; x=1773172550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l3xP1fevMeLte5tnBbRaXD9Bg5RfwsGc6PhwSpXmM40=;
 b=bb/gKjqHMnDWawZnHQNsapAR3CtejuNiFoxsl1kW2jVOwDQtLb3S10DGPV3tXr4WZY
 mBr3FKZQwTiSoq9IFUfpXleQzGT7pGhlLE5PTDSxIEzVKZ3gce5qOPpmyq3WzN0eNYcq
 KEAoEMox4dXOitC9NrAuo6mENYKbMFqNnLmc+ma68AKF6w++h7edd3KhySXvu+kU96Nh
 2eD6B/Ob9tejv1H9E0o1N5x53RBThV5g6WqCnQTtONQ4R0lU87khD/DnEgBlHr2fEiJ9
 AsBW2STgA0VK8zoKss7PAfdcR0QHIlbe7bZtuNpoWBKvOfZ1r5FlHLWS3s7UeSnNpWCh
 pd8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWEUFvsx9aVBsdW5491NoRWLLni0ShupTwUUxStNVx9Uz2wWpKwaekqEn6Y7xd7/L+zH462zE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0w9CLmeL+iuOhUxTw7mNE+j6ObSN2Iy7W7X+XmpvPwQlXXmiQ
 vzaGv8DAhUTn5cRd6OuIk2DWokB/7jqcFcgkeTIeyvvOAG24nU8/VVC701X5QuE9KdM=
X-Gm-Gg: ATEYQzwYEv55UX320b1DVo55aXA5OrWanvYrWj2lsidicrNmYEE5EfZuENeDMdFmGtt
 cBMUH/YlwfoI9Phn+3WFmSRwAItGVqJSDKC9wxeZBTL8Fv4TCKfmU+28c2KXPX+9ECny+rjA/Sf
 nBTt3m9MHL6M/HiLc48ZZulHdCjvSEZ7ZgwxAmIsWapBPi6GvLhCUiT2qb1AfpSKWR9cFpHcPeI
 4b1vxaEqkfZTTsIhyo542cGjL12a+4t8y2WVZI768aqZ9uFNezXeKg+HhEqlNamNJi9471VJaSg
 oFF9B9tnAUUuRDniey2UVbcZIFn9ffwV8jQSpae6kn0r0qvM/tCKO/q9HzIOLvAYpyu6asK+tcM
 zBENChqyjMjUJcTYLdT0DMdboWJxx6hPXf7n2QuRthIUIC2LzxmhQmIDHOHWyG17kJhSdToUU2J
 PnrofiD09SNuOk2kd2lObPGV0zTxnk
X-Received: by 2002:a05:6808:1705:b0:45f:16d1:8f5c with SMTP id
 5614622812f47-464bed66f46mr9472355b6e.28.1772567750452; 
 Tue, 03 Mar 2026 11:55:50 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:50 -0600
Subject: [PATCH v4 2/7] clk: mediatek: refactor parent rate lookup
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-2-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7056; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=4KgrOon9zRQOTihb6tZ+rADYYDy0Wzjy9yMIqHn7qzk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzyckS+oDKFrmM2XlL8t07RGiury0aF06+d5n
 efSqCXF0JCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8nBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai6QH/0/EIZMhBB8QKxywGPsm9HMJSWoeW7vWHDoCHAt
 Pt/xwd81n6ti1KpSsCiw6RdpRL/rolHhnaiM6xDmvB6aOxQBy7V2hHMyaPQW0VdXK7rdXxeu2PS
 CUvHFLld2KL4QWNZcQ2xRMa4BJF+dfaDmgkerfYW54xo2CFoQ0/hSPGTQKrFqIvnNC9X5qYprv2
 ZeoSWN+N8ha5QBI6B6gMxhyUfoJwAR+3u9Fr37lpafATI7Oz3Hoq+I4f37sQ+WBW0mA9amYaJGM
 PSk40DTw3Oh8sKaahNFZbcno9773HbNeLMiIs8R1s0xApkwnBY6XSrE8llFy628x1Qo0ya2ERlF
 KdZc=
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

Refactor duplicate parent rate lookup code into a common function.

Instead of relying on rules like X is always the parent of Y, we use
the driver ops pointer to make sure we are actually getting the correct
parent clock device. This allows the same function to be called from
different clock types and will allow future chip-specific clock drivers
to not have to follow the rules as strictly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 126 ++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b3f05bf5a21..921c3c0ff6a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -168,6 +168,53 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 	return clk_get_rate(&parent);
 }
 
+const struct clk_ops mtk_clk_apmixedsys_ops;
+const struct clk_ops mtk_clk_topckgen_ops;
+const struct clk_ops mtk_clk_infrasys_ops;
+
+static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
+				  const int parent, u16 flags)
+{
+	struct udevice *parent_dev;
+
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_APMIXED:
+		/* APMIXEDSYS can be parent or grandparent. */
+		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops)
+			parent_dev = clk->dev;
+		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops)
+			parent_dev = priv->parent;
+		else if (dev_get_driver_ops(dev_get_parent(priv->parent)) == &mtk_clk_apmixedsys_ops)
+			parent_dev = dev_get_parent(priv->parent);
+		else
+			return -EINVAL;
+
+		break;
+	case CLK_PARENT_TOPCKGEN:
+		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)
+			parent_dev = clk->dev;
+		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_topckgen_ops)
+			parent_dev = priv->parent;
+		else
+			return -EINVAL;
+
+		break;
+	case CLK_PARENT_INFRASYS:
+		if (dev_get_driver_ops(clk->dev) != &mtk_clk_infrasys_ops)
+			return -EINVAL;
+
+		parent_dev = clk->dev;
+		break;
+	case CLK_PARENT_XTAL:
+		return priv->tree->xtal_rate;
+	default:
+		parent_dev = NULL;
+		break;
+	}
+
+	return mtk_clk_find_parent_rate(clk, parent, parent_dev);
+}
+
 static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 				  u32 parent_type,
 				  const struct mtk_composite *mux)
@@ -470,7 +517,7 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
 	/* GATE handling */
 	if (priv->tree->gates && clk->id >= priv->tree->gates_offs) {
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
+		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
 	}
 
 	pll = &priv->tree->plls[clk->id];
@@ -637,39 +684,13 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
 	ulong rate;
 
-	switch (fdiv->flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_APMIXED:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent,
-						priv->parent);
-		break;
-	case CLK_PARENT_TOPCKGEN:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
-		break;
-
-	case CLK_PARENT_XTAL:
-	default:
-		rate = priv->tree->xtal_rate;
-	}
-
+	rate = mtk_find_parent_rate(priv, clk, fdiv->parent, fdiv->flags);
 	if (IS_ERR_VALUE(rate))
 		return rate;
 
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_topckgen_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
-					   const int parent, u16 flags)
-{
-	switch (flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_XTAL:
-		return priv->tree->xtal_rate;
-	case CLK_PARENT_APMIXED:
-		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
-	default:
-		return mtk_clk_find_parent_rate(clk, parent, NULL);
-	}
-}
-
 static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -687,33 +708,14 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 	if (mux->flags & CLK_PARENT_MIXED) {
 		const struct mtk_parent *parent = &mux->parent_flags[index];
 
-		return mtk_topckgen_find_parent_rate(priv, clk, parent->id,
-						     parent->flags);
+		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
 	if (mux->parent[index] == CLK_XTAL &&
 	    !(priv->tree->flags & CLK_BYPASS_XTAL))
 		return priv->tree->xtal_rate;
 
-	return mtk_topckgen_find_parent_rate(priv, clk, mux->parent[index],
-					     mux->flags);
-}
-
-static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
-				  const int parent, u16 flags)
-{
-	switch (flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_XTAL:
-		return priv->tree->xtal_rate;
-	/* Assume the second level parent is always APMIXED */
-	case CLK_PARENT_APMIXED:
-		priv = dev_get_priv(priv->parent);
-		fallthrough;
-	case CLK_PARENT_TOPCKGEN:
-		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
-	default:
-		return mtk_clk_find_parent_rate(clk, parent, NULL);
-	}
+	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
 static ulong mtk_topckgen_get_rate(struct clk *clk)
@@ -725,7 +727,7 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 	    clk->id < tree->gates_offs + tree->num_gates) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
 
-		return mtk_clk_find_parent_rate(clk, gate->parent, NULL);
+		return mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
 	}
 
 	if (clk->id < priv->tree->fdivs_offs)
@@ -963,18 +965,7 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 	const struct mtk_fixed_factor *fdiv = &priv->tree->fdivs[off];
 	ulong rate;
 
-	switch (fdiv->flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_TOPCKGEN:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent,
-						priv->parent);
-		break;
-	case CLK_PARENT_XTAL:
-		rate = priv->tree->xtal_rate;
-		break;
-	default:
-		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
-	}
-
+	rate = mtk_find_parent_rate(priv, clk, fdiv->parent, fdiv->flags);
 	if (IS_ERR_VALUE(rate))
 		return rate;
 
@@ -1024,20 +1015,11 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 						 priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */
 	} else {
-		struct udevice *parent = NULL;
 		const struct mtk_gate *gate;
 
 		gate = &priv->tree->gates[clk->id - priv->tree->gates_offs];
-		if (gate->flags & CLK_PARENT_TOPCKGEN)
-			parent = priv->parent;
-		/*
-		 * Assume xtal_rate to be declared if some gates have
-		 * XTAL as parent
-		 */
-		else if (gate->flags & CLK_PARENT_XTAL)
-			return priv->tree->xtal_rate;
 
-		rate = mtk_clk_find_parent_rate(clk, gate->parent, parent);
+		rate = mtk_find_parent_rate(priv, clk, gate->parent, gate->flags);
 	}
 
 	return rate;

-- 
2.43.0

