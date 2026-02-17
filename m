Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA4E9A03E
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FFF83D17;
	Wed, 18 Feb 2026 00:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G0DXBsTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A44383DEB; Wed, 18 Feb 2026 00:31:18 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC1D83D0B
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c65d744cso2654590a34.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371073; x=1771975873;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=G0DXBsTS69WsZJUuCW/E9WRk6fA641jRNR4MbL3VWcFIB+Vx8dK4tXMWNj+q1HTM8v
 4AOZRhnUnaaB7yTiWaFN5t71ZyMywVUD2UdYY7Tw6BPNEc3hX4jCUrBXwcEZIPe11q+N
 6GMCgK1UOrpyRJag+Drxp5DFvHduqx0kvnnWbYO+tdL4PWE6AF/Apbqj1ge2U969dPtH
 Fzsv8ELgYHzaBHLzXf91YsrBkq+iW9O/eKa6b5fxcjmTesSqefSoCHHRe/53S+U3z+d5
 ZXEHK+ng1POMPS6uyBtrA5GIBrbfz6YFiepI4RHxXn0GOLNM7tDfQpcjeGq/UmTwuw6h
 ifrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371073; x=1771975873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=ZDjpeXsejHtnlePl72IcYZSVACbT0vsG18OCYqJLXoksV9Oga5/W2lWpDCjPM7C/UR
 tn1/Zoh7sIKjB1EkSbT1HLTclvoqC7bwqpS7TrTNge79dYUUFiUvLgedzQi1k71Zju3V
 Upgy1wdzksISlwHXPJcL2xDhyPuLZm8kx44LO7FmalTJ5vciHlKYeq2hTHh3qybyBvYA
 kj+makgWBV7p8IdZnl40IFjNElVAiM3hwswHcErJwHbeX7zTX19znIqNzKe4M8QUZPeX
 6J5AHkQIB23D+/XtoxfNR1oEU1e9mxyXxcH/7JP67hVdaUqo+2MCQSN2Kha7/4VLk2ll
 k6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ShXvFzhdAU9bkr0cbqXZEgiDSKYRCmj5wZfYKQVwvNehUuVT9nOZsRGuz63XumLGLvzmtZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwEW9qQ0xFduIbiSXWcru3OI74FOc94keewB2S/2XFMqlYYuMnK
 hkWgGWx9MwNDWJPQntjh2Z02YR1iECmMFl1kEYnK6i9SckDNBktnaJSaVBXiiKSjI3Y=
X-Gm-Gg: AZuq6aLDnQYKa0jfEkP8bkMN02DMVqE0Si+Bb1+10cY1PLJt9nVrD8MiZVNd4KPDnKZ
 IZTFHdq60rOBLbwlp+lbwd8q99R+/1XGO/1OI9w3u39uohe5AiDSnO+nns7EWd10lYLAhTELTWN
 q+qPJI5rKyYvtJ3aYMUOqoB8sHYMSO2mJEc+t4pvIz/y4+S2nAOmqcyZjEpq10LKjfCBBQPkT+x
 h27koEwTO9zf2P55z27YUX3mzvP8xUvganhh+bVzxRR7af+S/ftVrgX928x7t/p7RC2k6R/yzBa
 DeFqlzYXxyEj2ILfuD3H8ZMNdukQEGWLsERVMZuhN45hWIneZN1zGjoIYGlCvIpoKTo3NsGTFOa
 qrkrl++n4awT4KpA09rD4qMTLwhT0pYp3P1HAjwn/TA8MuMEPJJa34GVl6bFRvFW9LS/35M7NhF
 b+8EInUJ8GlO86+al8EZTHxa+MNw==
X-Received: by 2002:a05:6830:91f:b0:7d4:4af4:b7d4 with SMTP id
 46e09a7af769-7d505db4360mr150907a34.1.1771371073269; 
 Tue, 17 Feb 2026 15:31:13 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Feb 2026 17:30:09 -0600
Subject: [PATCH v2 2/7] clk: mediatek: refactor parent rate lookup
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-mtk-mt8189-clocks-v2-2-cd381cd05251@baylibre.com>
References: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
In-Reply-To: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5541; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8YFbB2CqM29lMFcwxaeZ41UGNY6AER3aHdzGWe9GU0k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPoWmGZhppGepHw/NzxS8DgSai7OufXR1wnUb
 nrOutSG+tCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6FhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqqEH/2pKV2ACQGWoaeXHjOfZO4ymZqK4iZew3jeSVGm
 OnOrgHBC5uLfIxcrpQ9ONw23e23GkqEFMiBacSrTc/a2Ki4wC3s5uTwPFbzwIpol7BC/skYj75k
 jPkBjkG64sb4/SnOdmQVBEdxly2gCPByvRygUHCkaR8vjp3GGjdtvKw2GRyMS7aPhDmy78tce1J
 H8IW6oGOBkEOcCaju/ZHhd3bM7a7iCMGKVfyb3R5J1MOzjaLwdtlFDCe9ixmZ0TQjnXITw+5GXk
 T5we+NQP5FlN2qC50wW85vWWDr50SDBu6lLscLq4nki2WaKWRfqpFoovEyHAbP9QafrA3UZIZDO
 f3NY=
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
 drivers/clk/mediatek/clk-mtk.c | 111 +++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b3f05bf5a21..0123b0ce7b1 100644
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
 

-- 
2.43.0

