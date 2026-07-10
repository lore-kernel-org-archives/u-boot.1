Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2FAC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB96184BDE;
	Fri, 10 Jul 2026 20:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="fnV7LtRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B909484BD7; Fri, 10 Jul 2026 20:59:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB0D84B9B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9f5637634so855496a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709977; x=1784314777; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gVhwqxx66a6jqFXBf4/4B5mULxrQF3FJtr+WYk5nt/g=;
 b=fnV7LtRqY5k/Ss0xZU6WM/2oJ/PjiQfRqvrXNR3zMTZyC+xZpVYDbTUy4c9vSW5cEE
 xwxRiX7IOxYIEILeFbaTw+XZCnXH2xTSUeag58p4dU88fwgGKepodEONr5TBkGw517JX
 f+iwFvL4+CdkddcsrSC9OYk/PRvWCKiADtZZ1XyN1sIOCYtJEzjdo8NpWNv5UHr+nzqE
 pBY2EngmUvqYgSIaRiSz4JC2an/D50BPGo5TZe1mCr5GQYx3ef8MTks6Dvpf7Q3LhFsK
 GdWsg8gjoa6YKx++BxMsBOwUYlRqqAHZBVTWw3Ps+tky0gIvidkVqkyoJV9CQ4TB381U
 nkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709977; x=1784314777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gVhwqxx66a6jqFXBf4/4B5mULxrQF3FJtr+WYk5nt/g=;
 b=a2KIfXqyJL0PG2NtCDypFNC7dkraoAmI6LWmXzLKteLSBcsW5pdIY+idiHNbc26cnd
 24eCWJKYH5C3glTFBid5i+kmDr78AVJEfxUaIF80RdH/bZ2338ySPwS2h44r5zklkgIP
 S0lX5FKxzAzci2T8jtnWBuC+fPLX/Vfivg61C8ETTgU59aMnXG8eNDlki88xCJ+VXuRx
 1lLVSgPazY50W1aNxxWnibK+p8Hwn5ZjGAD1xbC04EK5EGbS2LkW8k7k14Kw7X+0tHX5
 lBgLcvbogqKEQ4G1WNfQmvflNvQeMfVHZhHZNSPjvBQ24VQQciCLcOGanXgXr97kxMSp
 tAIQ==
X-Gm-Message-State: AOJu0Yw//Ek7jMwDKSA/H21j3vxFOnD4csIq1VNtzNBy5FxYgqIHEM52
 LL0wJUoVlnJd8kNj1HfW3oudzXK3NhR7v1UHRnqpeI+Vk0DUl1qrjEjFH/UfqDfyXDtk504NmQM
 HTKWC
X-Gm-Gg: AfdE7ckt2ToZBk4Rwu8mnkdYhdXe4uwIGhqy1d8nV/mO+NyfltZllCXdjMQvnm+YCZ8
 s20FurxY3t35tcYxFgFDx/WvsfBnpbC9ONGOGKdCJDcs6x7XizNPcbLui0zB2SuGvT0azOB08rJ
 Ke4T7ruHaeYtpJauXbpQnyTWN6NE4GEwiH0xejZJxqFKjya61OBmVL6Z3i6vJxNnydtF58QJBH6
 5zxlgW4ZMuoKPUIzx+e3/C0j1HPC8/f9gGBaDBRPtyxMVkH1KSJXuYcHT6agFvZjopeL+z3Cvhr
 CeMjEklU+iPDP6p9ZrHJ+I7nj/PDXu47tAoIs9d8Mb7q/Gu6KDuttW6byYaQY6DKzB8Djuj9TFw
 30OtO1glodalq1QfAJ73lrUKOO9YDRt9W0IG+bUYzpaD8HWoRfoMsoG9WCoG2dgbhoR2XBhuCSs
 Jd6ojI9sZBrZEiZC/9
X-Received: by 2002:a05:6820:4c86:b0:69d:f7f8:4825 with SMTP id
 006d021491bc7-6a39a85624bmr359184eaf.34.1783709977204; 
 Fri, 10 Jul 2026 11:59:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:34 -0500
Subject: [PATCH v2 18/24] clk: mediatek: use registered provider for parent
 lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-18-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5119; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=A/3VqK11trHPWFVqqCwvWK7XQatEqQV9dWRmwM89gzc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDP6tC1hm3UedC+Mh1nGu1LPURXJN091b4/w
 LoUXaQhyOuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7j4H/jMsJ0WGmF2VAduCCExVgqVujfBPkQwti1k2+ck
 x6/CiUHwTCl7nD/Dl24Tmt7BH+3UAyzWWPeF2iIcrhJJ9w8yo6jjV1OHP6VOyfw6n7dU0nMHd1v
 4kNOhqy0kxpFWHgRvUykxzx/1xzXsUjPpix4p5xUidQbo3oOMcW30SuOhHqdqXeaiTDzZ40qNto
 cZus42OwJsCfgjYrCLrOb7skzWukBeca3SPO/Ddm3i5p2Zru+joR3T+ZJ/gghUkDwhrhMB4IWso
 dc6gv1idhfbtMT4lREKT8v1CYiR7oY6MBGD/rY5y3u1CVVpEl36cnKQD4aLt0N4kkhJwMjLSPUl
 1d+E=
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

Replace complex and fragile parent/grandparent lookup logic with a
simple lookup that matches CLK_PARENT_* flags to registered clock
providers.

Previously, we were walking priv->parent path to find a the matching
provider by either looking at driver name or driver ops. This was
fragile because more than one udevice could match the criteria and the
search depth had different rules depending on the clock type and the
parent type.

This will also enable more simplification in the future since we no
longer have to keep track of the udevice parents.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 98 ++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index da584aba0c3..9a1001ff938 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -41,6 +41,33 @@ static bool mtk_clk_tree_type_is_provider(enum mtk_clk_tree_type type)
 	return type != MTK_CLK_TREE_NONE && type < MTK_CLK_TREE_NUM_TYPES;
 }
 
+static enum mtk_clk_tree_type mtk_clk_tree_type_from_parent_flags(u16 flags)
+{
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_APMIXED:
+		return MTK_CLK_TREE_APMIXED;
+	case CLK_PARENT_TOPCKGEN:
+		return MTK_CLK_TREE_TOPCKGEN;
+	case CLK_PARENT_INFRASYS:
+		return MTK_CLK_TREE_INFRASYS;
+	default:
+		return MTK_CLK_TREE_NONE;
+	}
+}
+
+static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
+{
+	if (!mtk_clk_tree_type_is_provider(type))
+		return NULL;
+
+	return mtk_clk_providers[type] ?: ERR_PTR(-ENOENT);
+}
+
+static struct udevice *mtk_clk_parent_get_provider(u16 flags)
+{
+	return mtk_clk_tree_get_provider(mtk_clk_tree_type_from_parent_flags(flags));
+}
+
 static int mtk_clk_tree_register_provider(struct udevice *dev,
 					  const struct mtk_clk_tree *tree)
 {
@@ -228,50 +255,16 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 				  const int parent, u16 flags)
 {
-	struct udevice *parent_dev;
+	struct udevice *pdev;
 
-	switch (flags & CLK_PARENT_MASK) {
-	case CLK_PARENT_APMIXED:
-		/* APMIXEDSYS can be parent or grandparent. */
-		if (dev_get_driver_ops(clk->dev) == &mtk_clk_apmixedsys_ops ||
-		    dev_get_driver_ops(clk->dev) == &mtk_clk_fixed_pll_ops) {
-			parent_dev = clk->dev;
-		} else if (dev_get_driver_ops(priv->parent) == &mtk_clk_apmixedsys_ops ||
-			   dev_get_driver_ops(priv->parent) == &mtk_clk_fixed_pll_ops) {
-			parent_dev = priv->parent;
-		} else {
-			struct udevice *grandparent_dev = dev_get_parent(priv->parent);
-
-			if (dev_get_driver_ops(grandparent_dev) == &mtk_clk_apmixedsys_ops ||
-			    dev_get_driver_ops(grandparent_dev) == &mtk_clk_fixed_pll_ops)
-				parent_dev = grandparent_dev;
-			else
-				return -EINVAL;
-		}
-		break;
-	case CLK_PARENT_TOPCKGEN:
-		if (dev_get_driver_ops(clk->dev) == &mtk_clk_topckgen_ops)
-			parent_dev = clk->dev;
-		else if (dev_get_driver_ops(priv->parent) == &mtk_clk_topckgen_ops)
-			parent_dev = priv->parent;
-		else
-			return -EINVAL;
-
-		break;
-	case CLK_PARENT_INFRASYS:
-		if (dev_get_driver_ops(clk->dev) != &mtk_clk_infrasys_ops)
-			return -EINVAL;
-
-		parent_dev = clk->dev;
-		break;
-	case CLK_PARENT_EXT:
+	if ((flags & CLK_PARENT_MASK) == CLK_PARENT_EXT)
 		return mtk_ext_clock_get_rate(priv->tree, parent);
-	default:
-		parent_dev = NULL;
-		break;
-	}
 
-	return mtk_clk_find_parent_rate(clk, parent, parent_dev);
+	pdev = mtk_clk_parent_get_provider(flags);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return mtk_clk_find_parent_rate(clk, parent, pdev);
 }
 
 static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
@@ -1104,29 +1097,22 @@ static int mtk_clk_gate_disable(struct clk *clk)
 static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	struct udevice *parent = priv->parent;
 	const struct mtk_gate *gate;
+	struct udevice *pdev;
 
 	if (clk->id < priv->gates_offs)
 		return -EINVAL;
 
 	gate = &priv->gates[clk->id - priv->gates_offs];
-	/*
-	 * With requesting a TOPCKGEN parent, make sure the dev parent
-	 * is actually topckgen. This might not be the case for an
-	 * infracfg-ao implementation where:
-	 * parent = infracfg
-	 * parent->parent = topckgen
-	 */
-	if (gate->flags & CLK_PARENT_TOPCKGEN &&
-	    parent->driver != DM_DRIVER_GET(mtk_clk_topckgen)) {
-		priv = dev_get_priv(parent);
-		parent = priv->parent;
-	} else if (gate->flags & CLK_PARENT_EXT) {
+
+	if (gate->flags & CLK_PARENT_EXT)
 		return mtk_ext_clock_get_rate(priv->tree, gate->parent);
-	}
 
-	return mtk_clk_find_parent_rate(clk, gate->parent, parent);
+	pdev = mtk_clk_parent_get_provider(gate->flags);
+	if (IS_ERR(pdev))
+		return -ENOENT;
+
+	return mtk_clk_find_parent_rate(clk, gate->parent, pdev);
 }
 
 #if CONFIG_IS_ENABLED(CMD_CLK)

-- 
2.43.0

