Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89956EB362B
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9595F83F4C;
	Mon,  2 Mar 2026 19:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fk/37Q8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C624583F61; Mon,  2 Mar 2026 19:04:44 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00CC83F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46413b2c3d8so1969061b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474680; x=1773079480;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=Fk/37Q8noR3c40bl1UNgZTJz/QzPrVrkqZSKyRBBBSLOpDHra9mdSX6/AbioDKmx+a
 yiZq+aTYQLIinPKF5rx9ufxObnImI435QCCLvMnP4eQvmd61Nz/ZVQSdq6Rf94OY9fWG
 UISD5m3fHXcVEw05JYodKy7GQUhIkJYZwPZs6ABh7YVCy8tJQypiGViqwDfkb1UNEkGC
 8A0HNTL1bqnAMd/K8myr3FPQ3zRSK1Guz+wfYRBQZzHw8TtcIgWkQh1VwKNPzv8xQDKh
 aPtzf4asQGSoK3fFkEaPgE5vZEkPfmTQKr6bAp32ypYEQvrNubv88EvqTLpTH1LdbJM8
 NhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474680; x=1773079480;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dok5TCZOOR1yRJocpiTUyQPxUVA6UawHSqoybTggNh8=;
 b=XDN7lxq+o3iEPpLrVe+RNDdO6UwRE1hEvpb1OiUX7iBuRa6Ai18Ry5VzuE3qPzWR5r
 lSP3LzlyYibeOsK4NK83zEfpoBm5X0pvl4P+hLkXWVnLjMKaZGWk49qjAemIAd07gqpi
 zeo5ORzcHktJzhrHBjs6YY2wqQNNPuobItM200TnzpkIf0GC6tPIHaeTU3NEVNgGNIhY
 tHh3GScyMpv12LdabgjxKJQJgQaAcbqOVPyRgXtwsNYCKl1P0Wr6S7tkWe9yfLsOX6pW
 IX8ecVusgKarlLKEEAGFcP9cpj1w9J0ceOP59oBM/i5NtPTfvI1UdkBOXu15Sj1xWCmS
 h16A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3N0BSHdwcpXVVIbywsh0MBEp/vZYsdkB8UZCrQf4O5C+I16IqQYtF8AU44yW26/575RJY1/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxBlfM5xHnLLEWETDIQMkmdOkkH0f3FZHZ8EXIZWlRh/LhwNW3M
 fChO8taKf0kntCWOEwLYrmyLZuZEDD6tAdZ4pg3JJSJV8h0R4vSMt9HWpIn7DDivEx4=
X-Gm-Gg: ATEYQzxJCk7scrVPjbn17wDVt1jEGr8hxdW5LVdWufHcXOxNWpw9Wwvg3uJFm6J+Az4
 pk27g5X58PjL8sB8mWFJYNSzRSK/3+BYcPw1ZlarwR7EEYvF8+a9FU00FQrUgm8dT91W9UsY6tH
 rv1cDBTAvh9q+UccixOHWpljzdAgQgFX4UrcSu3AcNptKkBNKFSrzgjNAhktr6iQx7pWW99p07b
 tGeMSo1QVyUIh0YWi910TfScsj/uSyZ2ed0sFj+BxGGuURRJn335obR0VXb0T+02AfEaeRa9xvX
 cK4ejvDiXN50Xw+7k0lfCIDQci3on2Eq3aYsvtiDghXmbZ7ZXXkfN+hPPY7M53pdMKInxJmgXhF
 /RPzv/jsLsqBtLCaBE5EPvJGOlQIiB46Dp6lvpXgAbjdWUGPKB90DWJoAaUZBa01yjWWQoG1vd2
 Pbe+6tUtzkZL80AB7/BX2cwiHQOnRDwNBvVC8Jdnc=
X-Received: by 2002:a05:6808:16ab:b0:459:b48b:d51e with SMTP id
 5614622812f47-464beadc661mr8693906b6e.24.1772474680241; 
 Mon, 02 Mar 2026 10:04:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 12:02:09 -0600
Subject: [PATCH v3 2/7] clk: mediatek: refactor parent rate lookup
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mtk-mt8189-clocks-v3-2-c48ec60344fd@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5541; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8YFbB2CqM29lMFcwxaeZ41UGNY6AER3aHdzGWe9GU0k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdENeXFqNnLguarpr8uxduYwelCxJW2c23w+X
 rNE86feLDeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXRDRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AOxsH+QGOmKLpxsGk6HvC+gdH2QBdOi9b9Ybs3YjZSMd
 P8Nn7i4pThGtADTkoN2AzP8rzeyRxN/csSgHqByQaA4dQL5lg9cEIlNpVycQseEPxTW68ImHI3r
 f0qZrZb7vZAMXS1Kewtl0M4J3g2yn82/AGl0FdaQD/ZxOZj207KctC4suWFO/oZN9d2BhW6nljp
 /wsLOY7k/2mcXdmNtLpGOT5EzadwBAMYdVgAIUyZL78MBta6tzzEJ+7ClW3SptyPj7dJSAVWLZh
 a5rf8rFt1vKIULsOhZKFF2qZ9VjFyhUmMAGfVfZnmXC3Bg+32jeoKATxlK4CbW1EklHar8LR5kO
 OvsI=
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

