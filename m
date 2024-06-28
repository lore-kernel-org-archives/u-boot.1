Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533EDC30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B0C885E1;
	Fri, 28 Jun 2024 19:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fD1wYIxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5094A885A2; Fri, 28 Jun 2024 19:41:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD72885D4
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-425624255f3so5780155e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596500; x=1720201300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+VqgFpybrKKi1ENpWeSBVaTVBicGVWbauPS9WF1fX0=;
 b=fD1wYIxLbT+ygnWvh9nSKTmebL/0w0uvC6NbeKWIfHf+4rV7KDfZ4CrAoUcUfOk4/t
 xQmEliekjq/zCa4/OfHHJa0R7Vt3yVUXGaWAI186kU4qhXSEGNWRWUb8VpF5imbKvR5c
 h3hlq52/QuwBO06am+ZChi+dKJ4u2uPmdmi9yXdKyDxU6jx7I5jzS4meXm0I7Z341cX0
 Sp38yWsDqB5gtzaQgoWsA3vhLsn9BQQlreoSx7HaTAMXOG/sobYTHVcRVz284fY9byoj
 hww7EBAHis35dLoMlznXtlBOpPtp7ds+aVFFLgT9GEp+ljoePQpZS3THVBklvRiRAl+g
 2Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596500; x=1720201300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+VqgFpybrKKi1ENpWeSBVaTVBicGVWbauPS9WF1fX0=;
 b=WrriTAsfwm6xEXtR6svYM2Csz4nCXMB8veg7btEQ3hYQUJOqyJbYaCFWRBNL+HP8Zb
 UztSuzAADfdBC46J4OYb+xP0PrHZ6ZbhX4D9483SqhpIpN2NO+/XYmABKVjnXgN11fwU
 6Mz/2H4ezfP5LnssOeCvGFBHYdxnBPxjzPsiSTuJt09s8KDsMOQvsU706MeGX0PpMWLf
 GBOc6YapRu6AB6kGuHDuzKYzMvYRQYGy8r/udftfyUvelzTXlkRRZKSbXmVKInoBgLdz
 ARHCRhmrPEz4gUal4nr2C862N8ApnRgi9u/hvfHxo19duI5UvFPI3TAc6ZWVquGd53pN
 kk0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFrXFc2bNjYAHaMIstg7f4b5lP4EUxHroTNCeYSjfFhZ+mzYh4+4CIxKzkvGSMk5B9PwosYuK9/UQLS7NE6SJuoVERbg==
X-Gm-Message-State: AOJu0Yyu0uYDrLhQapwjuwe/sDyGzfRIk7MdUUrzm1Pc2h7fqTNMPXcQ
 sH4dPoPIQPKzZ8iJ3zzZOV7vwli29lVR+rFFKfPmATRJIK8fpBRH
X-Google-Smtp-Source: AGHT+IFSg4cE87aPInbivMspeWWSpSbng+LbwhvQ+5X66BFRf4ejsQv4ZjbSm4D5NGJ0qifJOWKv3Q==
X-Received: by 2002:a05:600c:4ecf:b0:421:347a:f0a6 with SMTP id
 5b1f17b1804b1-4256d4c1d7cmr19967165e9.3.1719596500520; 
 Fri, 28 Jun 2024 10:41:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 06/12] clk: mediatek: add support for parent mux from
 different source for topckgen
Date: Fri, 28 Jun 2024 19:40:51 +0200
Message-ID: <20240628174114.8675-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

As done for infracfg, also add support for parent mux from different
source for topckgen. This is needed as upstream linux doesn't use 1/1
factor and use directly the APMIXED clocks.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 42 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 4b8a904aa5e..790b92eaf86 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -338,6 +338,19 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
+static ulong mtk_topckgen_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
+					   const int parent, u16 flags)
+{
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_XTAL:
+		return priv->tree->xtal_rate;
+	case CLK_PARENT_APMIXED:
+		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
+	default:
+		return mtk_clk_find_parent_rate(clk, parent, NULL);
+	}
+}
+
 static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -348,22 +361,23 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 	index &= mux->mux_mask << mux->mux_shift;
 	index = index >> mux->mux_shift;
 
-	if (mux->parent[index] > 0 ||
-	    (mux->parent[index] == CLK_XTAL &&
-	     priv->tree->flags & CLK_BYPASS_XTAL)) {
-		switch (mux->flags & CLK_PARENT_MASK) {
-		case CLK_PARENT_APMIXED:
-			return mtk_clk_find_parent_rate(clk, mux->parent[index],
-							priv->parent);
-			break;
-		default:
-			return mtk_clk_find_parent_rate(clk, mux->parent[index],
-							NULL);
-			break;
-		}
+	/*
+	 * Parents can be either from APMIXED or TOPCKGEN,
+	 * inspect the mtk_parent struct to check the source
+	 */
+	if (mux->flags & CLK_PARENT_MIXED) {
+		const struct mtk_parent *parent = &mux->parent_flags[index];
+
+		return mtk_topckgen_find_parent_rate(priv, clk, parent->id,
+						     parent->flags);
 	}
 
-	return priv->tree->xtal_rate;
+	if (mux->parent[index] == CLK_XTAL &&
+	    !(priv->tree->flags & CLK_BYPASS_XTAL))
+		return priv->tree->xtal_rate;
+
+	return mtk_topckgen_find_parent_rate(priv, clk, mux->parent[index],
+					     mux->flags);
 }
 
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
-- 
2.45.1

