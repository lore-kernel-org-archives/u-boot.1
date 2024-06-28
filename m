Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA559C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDEB885F5;
	Fri, 28 Jun 2024 19:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVJ4Tgvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313BF885E1; Fri, 28 Jun 2024 19:41:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18AB78859A
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4256eec963eso5828405e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596499; x=1720201299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tohjr4VjHD98/JWTlDbqTbWbnP0JE5W81mAiq7iFIBw=;
 b=MVJ4Tgvg6G3NGJsZqTqPH5d7KgIyQQsk/71Xc/v+ViW7EqaLPD3pcSAEegdYsyZuUy
 lr3oGsaREVTYty7YMObgmQ644N/coEC/R6fZFq5alStZAO4L5/CUZ5V5hsTOv7bmT9F0
 8kRICGlZ6xtqVlES3jCbXmk2YWviGmLBQwL77eoAoXaodgWRLQhsT4mlOtEdCKE9YEja
 eG7a5WpJdSQMxzE4A/PaclDPW/59m4bNHK6CKCFxjemNMjnpbqvh7wuzkxsxiGwWJiIr
 EEICBeLIwzH165tIi4y25mcMN/3dAPBN/Sat/kms0Gj3YfsHPpaTnHrWs9BCyfOrppVe
 16fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596499; x=1720201299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tohjr4VjHD98/JWTlDbqTbWbnP0JE5W81mAiq7iFIBw=;
 b=qE26Tkiqm0EO3KX8fjNhCd/vdXtijjOgr0sT0G1XfYsQS5/pJKIYnCuY8o4YUGXjY3
 57s4hZ9L6RnVyK+Ih794oexKDtNh7n4Q8Jf94mv01yvKjzSbBF0qiyrOwFOgUUN3j+Zi
 h0GxKxDGWOr7sO6gksCU0/kXK/PUwrViLPRFqtMxRdENKuajRE0z4RADu6KfV6xnQsrC
 Xg/EVOzy9GaPCw/qmT/VLUAeHKfnCfRHCSBsA/BU/uJcmVMm6qWseyabbgHjbjdIZj6q
 ZhtOmx4hebNImqzagFYxjEYIuQPikLQkNgLf50Fq6ntviZOrOPUCHpPJ2usL/kEu8KSg
 n8iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkcSuSmyExGtf74wzHBX9+bUVmXcOLOHxZaOkYwYtiVyyf+oNYuSSW+0Z6b/XplcFpqKeoPJXJZyM4vZcrmZt0pEu2Wg==
X-Gm-Message-State: AOJu0Yy3+wSdtkbVxQKsj41rpG4LqhDKmGCahEuzVjeQDd4wpt8KtTsz
 eLU26PHMjuLVHZ0erAW8uebMxPzIHGFkVINrdaIe9I7QPrDd0VIS
X-Google-Smtp-Source: AGHT+IE6CVoY7urZXAJmZKD0GxnuxM56oYjzMk8TdqyDB89QyyVpjEamP1Um3D5UH2RPqoH65QtLMg==
X-Received: by 2002:a05:600c:548d:b0:425:6d00:3572 with SMTP id
 5b1f17b1804b1-4256d003730mr18363725e9.6.1719596499539; 
 Fri, 28 Jun 2024 10:41:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 05/12] clk: mediatek: add support for parent mux from
 different source
Date: Fri, 28 Jun 2024 19:40:50 +0200
Message-ID: <20240628174114.8675-6-ansuelsmth@gmail.com>
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

There is a current limitation where parents for a mux can be all declared
as they are from a common source. This is not true as there are some MUX
that can have parent from both infracfg or from topckgen.

To handle this, implement a new flag for the mux, CLK_PARENT_MIXED, and
a new entry for the mux parent_flags.

To use this, CLK_PARENT_MIXED must be used and parent_flags will be used
instead of the parent variable.

Entry in parent_flags are just a struct of ID and flags where it will be
defined where that parent comes from with the usage of
CLK_PARENT_INFRASYS or CLK_PARENT_TOPCKGEN.

This permits to have MUX with parents from infracfg or topckgen.

Notice that with CLK_PARENT_MIXED applied the CLK_BYPASS_XTAL is
ignored.
With CLK_PARENT_MIXED declare CLK_PARENT_XTAL for the relevant parent
instead.

Also alias for the CLK_PARENT macro are provided to better clear their
usage. CLK_PARENT_MIXED require these alias that describe the clk type
to be defined in the clk_tree flags to prevent clk ID clash from
different subsystem that may have equal clk ID.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 69 +++++++++++++++++++++++++---------
 drivers/clk/mediatek/clk-mtk.h | 43 +++++++++++++++++++--
 2 files changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 79230fc26e0..4b8a904aa5e 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -54,13 +54,27 @@ static ulong mtk_clk_find_parent_rate(struct clk *clk, int id,
 }
 
 static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
+				  u32 parent_type,
 				  const struct mtk_composite *mux)
 {
 	u32 val, index = 0;
 
-	while (mux->parent[index] != parent)
-		if (++index == mux->num_parents)
-			return -EINVAL;
+	if (mux->flags & CLK_PARENT_MIXED) {
+		/*
+		 * Assume parent_type in clk_tree to be always set with
+		 * CLK_PARENT_MIXED implementation. If it's not, assume
+		 * not parent clk ID clash is possible.
+		 */
+		while (mux->parent_flags[index].id != parent ||
+		       (parent_type && (mux->parent_flags[index].flags & CLK_PARENT_MASK) !=
+			parent_type))
+			if (++index == mux->num_parents)
+				return -EINVAL;
+	} else {
+		while (mux->parent[index] != parent)
+			if (++index == mux->num_parents)
+				return -EINVAL;
+	}
 
 	if (mux->flags & CLK_MUX_SETCLR_UPD) {
 		val = (mux->mux_mask << mux->mux_shift);
@@ -352,6 +366,19 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 	return priv->tree->xtal_rate;
 }
 
+static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
+				  const int parent, u16 flags)
+{
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_XTAL:
+		return priv->tree->xtal_rate;
+	case CLK_PARENT_TOPCKGEN:
+		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
+	default:
+		return mtk_clk_find_parent_rate(clk, parent, NULL);
+	}
+}
+
 static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -362,21 +389,21 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 	index &= mux->mux_mask << mux->mux_shift;
 	index = index >> mux->mux_shift;
 
-	if (mux->parent[index] > 0 ||
-	    (mux->parent[index] == CLK_XTAL &&
-	     priv->tree->flags & CLK_BYPASS_XTAL)) {
-		switch (mux->flags & CLK_PARENT_MASK) {
-		case CLK_PARENT_TOPCKGEN:
-			return mtk_clk_find_parent_rate(clk, mux->parent[index],
-							priv->parent);
-			break;
-		default:
-			return mtk_clk_find_parent_rate(clk, mux->parent[index],
-							NULL);
-			break;
-		}
+	/*
+	 * Parents can be either from TOPCKGEN or INFRACFG,
+	 * inspect the mtk_parent struct to check the source
+	 */
+	if (mux->flags & CLK_PARENT_MIXED) {
+		const struct mtk_parent *parent = &mux->parent_flags[index];
+
+		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
-	return priv->tree->xtal_rate;
+
+	if (mux->parent[index] == CLK_XTAL &&
+	    !(priv->tree->flags & CLK_BYPASS_XTAL))
+		return priv->tree->xtal_rate;
+
+	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
 static ulong mtk_topckgen_get_rate(struct clk *clk)
@@ -490,12 +517,18 @@ static int mtk_clk_mux_disable(struct clk *clk)
 
 static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 {
+	struct mtk_clk_priv *parent_priv = dev_get_priv(parent->dev);
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 parent_type;
 
 	if (clk->id < priv->tree->muxes_offs)
 		return 0;
 
-	return mtk_clk_mux_set_parent(priv->base, parent->id,
+	if (!parent_priv)
+		return 0;
+
+	parent_type = parent_priv->tree->flags & CLK_PARENT_MASK;
+	return mtk_clk_mux_set_parent(priv->base, parent->id, parent_type,
 			&priv->tree->muxes[clk->id - priv->tree->muxes_offs]);
 }
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 8dde9e56e81..4423689803a 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -13,7 +13,11 @@
 
 /* flags in struct mtk_clk_tree */
 
-/* clk id == 0 doesn't mean it's xtal clk */
+/* clk id == 0 doesn't mean it's xtal clk
+ * This doesn't apply when CLK_PARENT_MIXED is defined.
+ * With CLK_PARENT_MIXED declare CLK_PARENT_XTAL for the
+ * relevant parent.
+ */
 #define CLK_BYPASS_XTAL			BIT(0)
 
 #define HAVE_RST_BAR			BIT(0)
@@ -30,7 +34,17 @@
 #define CLK_PARENT_TOPCKGEN		BIT(5)
 #define CLK_PARENT_INFRASYS		BIT(6)
 #define CLK_PARENT_XTAL			BIT(7)
-#define CLK_PARENT_MASK			GENMASK(7, 4)
+/*
+ * For CLK_PARENT_MIXED to correctly work, is required to
+ * define in clk_tree flags the clk type using the alias.
+ */
+#define CLK_PARENT_MIXED		BIT(8)
+#define CLK_PARENT_MASK			GENMASK(8, 4)
+
+/* alias to reference clk type */
+#define CLK_APMIXED			CLK_PARENT_APMIXED
+#define CLK_TOPCKGEN			CLK_PARENT_TOPCKGEN
+#define CLK_INFRASYS			CLK_PARENT_INFRASYS
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
@@ -97,11 +111,31 @@ struct mtk_fixed_factor {
 		.flags = _flags,			\
 	}
 
+/**
+ * struct mtk_parent -  clock parent with flags. Needed for MUX that
+ *			parent with mixed infracfg and topckgen.
+ *
+ * @id:			index of parent clocks
+ * @flags:		hardware-specific flags (parent location,
+ *			infracfg, topckgen, APMIXED, xtal ...)
+ */
+struct mtk_parent {
+	const int id;
+	u16 flags;
+};
+
+#define PARENT(_id, _flags) {				\
+		.id = _id,				\
+		.flags = _flags,			\
+	}
+
 /**
  * struct mtk_composite - aggregate clock of mux, divider and gate clocks
  *
  * @id:			index of clocks
  * @parent:		index of parnet clocks
+ * @parent:		index of parnet clocks
+ * @parent_flags:	table of parent clocks with flags
  * @mux_reg:		hardware-specific mux register
  * @gate_reg:		hardware-specific gate register
  * @mux_mask:		mask to the mux bit field
@@ -112,7 +146,10 @@ struct mtk_fixed_factor {
  */
 struct mtk_composite {
 	const int id;
-	const int *parent;
+	union {
+		const int *parent;
+		const struct mtk_parent *parent_flags;
+	};
 	u32 mux_reg;
 	u32 mux_set_reg;
 	u32 mux_clr_reg;
-- 
2.45.1

