Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CDBC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2336D84A92;
	Tue,  7 Jul 2026 17:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="St4yd2wQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F03084A6B; Tue,  7 Jul 2026 17:10:51 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DAB84AA4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69e9b037d82so3501412eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437047; x=1784041847; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qo7jhdMiOO+Qs0UJ3ZkLwBeGTJRYb2yrNpV0vVDKUr0=;
 b=St4yd2wQoLilN0BmiJFDfb510PQG/ISVaQQBm9sBRUShvQ3gSKCSMfsDl76caD/ORY
 hiQof1UvApHlegbwQReTjBREaxiZXky9qjQamMJ66dn7lJJL39lOb9b7+9m6x0V/zt5S
 3TMNRbBYGtIk4aCI6bsq/3iWSkjwygFzKT6tihQth3IxcVRKqK6gUH2f6BZV7bNpKtMa
 JHnSuVRKCOmf5wnR0tL9ajmx333nuBIkzwVYSutf5g4nlpxDL/v2WpaOCJT+VYRKq8ma
 SqW72mgBa55ntx7CXSWcK7yPHqpFM19rp+aOrF5x0ehivjeD6sHx+BTRUGfAm73LjOCJ
 RHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437047; x=1784041847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qo7jhdMiOO+Qs0UJ3ZkLwBeGTJRYb2yrNpV0vVDKUr0=;
 b=j+jh1eXc3NSp9iP7Nl057tYORTX8BRvSfflzdTFq+EtyQ/0O19EQ0D87IdXkoBbDRv
 LdhvaX/R8Sj2utAQtLC/gFzbvu6QTGlUKFFHPaUDyVlnAaHbI5qx+ul34BV+4DdXgAcY
 0tpbxMU2ieKaeFoaW0243ybjHeanSSFoQd3t9RGce6MNPK2UNwERPpiIR2z5fkKpJxBF
 FvYncwcUruaW15vvmthFK64ZwjmvadnJYcQvUlIOAaB02GfNEfOE9hPUxT0+yP+sk8ED
 xooyOhpsigLgttWG0RDx6CpyXaeukkAwDlbpaEkXfzFvZH+mNleGd4AQtGXVPc1B+1Un
 rnJw==
X-Gm-Message-State: AOJu0YyYarXoYFn9HZ4EFVhuADhgljxzpJp2kG7KDgGplH3s0AfSLX88
 MUH/qO5W7xXtmAuvgreqUUpg0V9FCxMN5taNqyNfkzA+soIQtsMqAQYZci8/5xVnu5k=
X-Gm-Gg: AfdE7clX5PJqx1xSlzJn+git8xWPH4aXpImE4U52P/akEzW8MePnYusD+Oes5PccXb1
 N08pOlNAEZq3MQdALMJT8FNtGVnb6xfQ2tIFyhr710m0ZWN0sVr/SALlBtXAXATesJhvJg+t+jr
 z0N/YRihNVd6ZqpW7NHwIEgLhnwEZG0rOGqes7F5onfoE3XXFOUIIofuXrxlKbtrj8V1nMJhlbS
 IDdi67/XURgBIRuum4xru1g4PbFmQrWfzQ6m9rc3mjvsL1p2WAdY3/JuKGES1XhxzFLRk11FIxj
 FcKYODVAWbnyZmWKt4HuRMHcrxfsm1LymMFhTqbDSzFai37jSH6inYS7SZdvGyQHBemHSKsqdZZ
 zKQZwR1zXQ7DILcQT5dRdYMiddx1XJlRZbfzuxw6rrxKDhgO1TvhDXoaG1fQKnANJewhY6KS41B
 xep4zEYjkcbb2K/4Zafg==
X-Received: by 2002:a05:6820:1390:b0:69e:b7f4:2a14 with SMTP id
 006d021491bc7-6a355289aebmr3832173eaf.26.1783437047305; 
 Tue, 07 Jul 2026 08:10:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:38 -0500
Subject: [PATCH 18/24] clk: mediatek: use registered provider for parent lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-18-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
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
 bh=OB2Qop5o0sM45tG5breiy8Av1YX3DR/V8272webL9e0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaprjtT6ROmIt1p2UouPU859GWSNQON4V/kE
 y0yvCNCv2KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WqRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVHMH/0MlKWEXr3oPt/W4f4k2mgg+16wZUvaxf9v1oj0
 ze5EM+8/+1+/w5bBDcyB7+9JGngbyu/9BxW2xk5JLWchOKBNAB144suMauukMJds56F1JeX5Emx
 FrzPIJBOlPUjsktVm0ux+Q954Uq8wd9BXAArx1CyNbe2eR9zWbjX4t6FLBmQHTKbBvV92Upx8mL
 9VWzgrDoWZ+96uGkE7D36Py25MY+2LSJ0LXerj2+uRWXuUAW3z9dv6r3bjo26BqGBZvhQjlMqfy
 IgztRSDkeHgCmy4o1z+d0EmiZ+nrw+ylT77EHgMFBgTV/+7QvRWLA3WTmRO2uQgy7/Ww4QiweAg
 UHQQ=
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
index 362e4c1c6a9..d1cfa70e5a6 100644
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

