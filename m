Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE2D6E2BF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5549839D7;
	Thu, 18 Dec 2025 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U+a1NE6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7389C80077; Thu, 18 Dec 2025 18:18:23 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43324836CE
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3f0c93ecf42so1260610fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078291; x=1766683091;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dLKwZZC24pumN41pEQsuk9P9tjQkkR3Je9PDljIN3Do=;
 b=U+a1NE6dBDF0JRJEcbiZ9rbNrJufQDtI/iHDM8fyrzAani50T67Lfr8Kit6ZpRk7Jv
 a+ikgmmZEAjCLbJxAYst7yt4Il84AQLFj0qqXR6AWElT3Tzb+s8NfErupOsJ9xahnTmn
 2hsjX47d61alC05NwMRzTHz+pAbJUSuI9grOMsZgKvay4wkznjmUT7ju3OsSiQZg4cQc
 J+JwvjA1U2wp3N6KOe937cTA/VjsZPERoIPSuZZvEfGPFqvlQhQngROdFC5QT5caZG1h
 /E5tWknacIl+mWMpvCrFJ6dSXoNOsCheMx62PVFj8NYmgDQquzIAUDK6hCyMSiih7rv9
 7ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078291; x=1766683091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dLKwZZC24pumN41pEQsuk9P9tjQkkR3Je9PDljIN3Do=;
 b=AjxrqyR1gzzRKG/orNEseC3fynO9whZWqXMth9xqpVNP1hpM2GBdNteMiJvV7GHpyl
 W7zuBO1tFgxqDSjHdrnA1zTmSVeQgBxu1BHDTF9ctxyL0Jvs71rTu73sUUJDFPHc+77o
 yBv3eXZNLuozh8V/9qakb+FMsmqBdO/qRBp7/z9eOXzgso8kPua/yf7ooPmfnT0p7dI9
 7W9iSJUiA5HDSM4RnhE9P2oXlJqx2U5PY5C6lZzTFKSof+iFT/ApjEiGI+TNxAwPQGGZ
 L+f8FYDznfMaslmKc+S1CzoyFxVaZ0ZwC7jcyHzMR134skiAb9Ekr0Sinat33rTkqbJt
 gBkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcnjfMKlEW50C6QrR14xMDtM2tzOXDgR7E4W8F6drCTuBAV4pTawkMkx+LR//KehI4pztWIY0=@lists.denx.de
X-Gm-Message-State: AOJu0YwgE7ihrYIz+g5X0mvBxx24TtEFbf3HCB83KowojwPO9gdlvr+P
 qVCZkkaUpZEWy14ExTI24kESjwgvsZHqtK8lAa6A9iivYsa6IdKaUVOzYJcGaVK0NZM=
X-Gm-Gg: AY/fxX4onk/JCT0KjnoyAVd58F60AeM3R02bxyaaWlKOIy+aR9k/fJ6QdfJJmxfqbRH
 gRc4tvQjNCXj/trY+cGDHLYwBsOTweYPdtiAS/bO2pfWcN8pXDmdpmr1CKYPJvRoP8X+DHJ638N
 N/r4VwXO94XYKfgsBf1pudZ0EZeA9f9F2rKjkSsNXphktNo7cyadDm2WI5nIIqLd4qgdlnB8B/5
 2auohG+WfNwXRsjD9iZpQ2esy3t5sT+JERv6izyHwt1uk5Ejf+4UP6whxyh4FJ+9xL0/oXJnVJc
 M1HrKYjFYehm+4yn6uxP4x07QnAG92Jl9Vsca99M8VNMoBoL5ds5CX63zc6KhigXbY04UZfzOZH
 yAmVaCidm4VFvjw0UYkqUf+7pHXS0G0G5/WauP6GUtxqoNaU366/6HE+KWP/l0wW086KTJFXrfx
 sl+D5f8bXtR3QlzWo=
X-Google-Smtp-Source: AGHT+IHIOidLd02tQ9z8pAl8LeYyi/3d5bN3yb7XtWYr9Cbp1oKCN8A7QL4hoE+x3To4OnhULdXwDA==
X-Received: by 2002:a05:6820:6106:b0:65c:fb36:f246 with SMTP id
 006d021491bc7-65d0e386ec8mr102240eaf.19.1766078290908; 
 Thu, 18 Dec 2025 09:18:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:06 -0600
Subject: [PATCH 8/8] clk: mediatek: implement dump callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-8-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9849; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rKIQcrfxCiRLbqu0MfsR9wpIbJzyepYas0StyDOKlZ4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDdE3aW14uUhPslBnxlKDwKo5maaaY5OWZdy0
 406JSbExRiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3RBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALwwH/0TcsR78k1dlnh20IaAcRPsSz8qSPShC+dArQs5
 QTOWGMP7zR6jIAk9H25Xd4Ppq1zU9pAzKapIK2GHyoHP901rpkpLeV60Im8ZIssW3FDg6nvNtiH
 /Hpca+yyTt23rfCyA1BvgF0vK0ZRXpyhn2zihtGvShf0eJhMJxv0imEHl1/fjVCIO8mt6bWd00w
 3Jz5QNu2Wose0Dvs4N2uK+euZ+bWBPa7LhUlWjpu5OBqnbD9DPUXjP1uNNlLUEbEcu6fhJB/cES
 inp3aoSH4RC4TsBew0BhEV2B+TC08+m8jA2w1SwtPmg+85mQhbzLu67j5iwqEfpuSjzhQ3pZtLB
 YarI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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

Implement dump callbacks for Mediatek clocks. On these platforms, there
are 100s of clocks, so it can be easy to miss mistakes. The dump
callbacks will be useful for debugging and verifying clock configs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 248 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 1539dc6cbcc..a3dd18363f6 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -193,6 +193,108 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(CMD_CLK)
+static void mtk_clk_print_dev_parent(struct udevice *parent)
+{
+	printf("Parent device: %s %s\n", parent->driver->name, parent->name);
+}
+
+static void mtk_clk_print_mapped_id(int unmapped_id, int mapped_id, bool has_map)
+{
+	/*
+	 * If there is a ID map, then having unmapped and mapped IDs differ is
+	 * expected. On the other hand, if there is no map, then they should be
+	 * the same, and it is a programming error if they differ.
+	 */
+	if (has_map)
+		printf(", (mapped ID: %u)", mapped_id);
+	else if (unmapped_id != mapped_id)
+		printf(", (error! should be %u)", mapped_id);
+}
+
+static void mtk_clk_print_rate(struct udevice *dev, int mapped_id)
+{
+	struct clk clk = {
+		.dev = dev,
+		.id = mapped_id,
+	};
+	long rate = clk_get_rate(&clk);
+
+	if (rate < 0)
+		printf(", error! clk_get_rate() failed: %ld", rate);
+	else
+		printf(", Rate: %lu Hz", rate);
+}
+
+static void mtk_clk_print_parent(const char *prefix, int parent, u32 flags)
+{
+	const char *parent_type_str;
+
+	switch (flags & CLK_PARENT_MASK) {
+	case CLK_PARENT_APMIXED:
+		parent_type_str = "apmixedsys";
+		break;
+	case CLK_PARENT_TOPCKGEN:
+		parent_type_str = "topckgen";
+		break;
+	case CLK_PARENT_INFRASYS:
+		parent_type_str = "infrasys";
+		break;
+	case CLK_PARENT_XTAL:
+		parent_type_str = "xtal";
+		break;
+	case CLK_PARENT_MIXED:
+		parent_type_str = "mixed";
+		break;
+	default:
+		parent_type_str = "default";
+		break;
+	}
+
+	printf("%s%s-%u", prefix, parent_type_str, parent);
+}
+
+static void mtk_clk_print_single_parent(int parent, u32 flags)
+{
+	mtk_clk_print_parent(", Parent: ", parent, flags);
+}
+
+static void mtk_clk_print_mux_parents(struct mtk_clk_priv *priv,
+				      const struct mtk_composite *mux)
+{
+	const char *prefix = "";
+	u32 selected;
+	int i;
+
+	printf(", Parents: ");
+
+	selected = readl(priv->base + mux->mux_reg);
+	selected &= mux->mux_mask << mux->mux_shift;
+	selected >>= mux->mux_shift;
+
+	/* Print parents separated by "/" and selected parent enclosed in "*"s */
+	for (i = 0; i < mux->num_parents; i++) {
+		if (i == selected) {
+			printf("%s", prefix);
+			prefix = "*";
+		}
+
+		if (mux->flags & CLK_PARENT_MIXED) {
+			const struct mtk_parent *parent = &mux->parent_flags[i];
+
+			mtk_clk_print_parent(prefix, parent->id, parent->flags);
+		} else {
+			mtk_clk_print_parent(prefix, mux->parent[i], mux->flags);
+		}
+
+		prefix = "/";
+
+		if (i == selected)
+			printf("*");
+	}
+}
+#endif
+
 /* apmixedsys functions */
 
 static const int mtk_apmixedsys_of_xlate(struct clk *clk,
@@ -437,6 +539,36 @@ static int mtk_apmixedsys_disable(struct clk *clk)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(CMD_CLK)
+static void mtk_apmixedsys_dump(struct udevice *dev)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	u32 i;
+
+	mtk_clk_print_dev_parent(priv->parent);
+
+	for (i = 0; i < tree->num_plls; i++) {
+		const struct mtk_pll_data *pll = &tree->plls[i];
+
+		printf("[PLL%u] DT: %u", i, pll->id);
+		mtk_clk_print_mapped_id(pll->id, i, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i);
+		printf("\n");
+	}
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
+}
+#endif
+
 /* topckgen functions */
 
 static const int mtk_topckgen_of_xlate(struct clk *clk,
@@ -651,6 +783,48 @@ static int mtk_common_clk_set_parent(struct clk *clk, struct clk *parent)
 			&priv->tree->muxes[clk->id - priv->tree->muxes_offs]);
 }
 
+#if CONFIG_IS_ENABLED(CMD_CLK)
+static void mtk_topckgen_dump(struct udevice *dev)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	u32 i;
+
+	mtk_clk_print_dev_parent(priv->parent);
+
+	for (i = 0; i < tree->num_fclks; i++) {
+		const struct mtk_fixed_clk *fclk = &tree->fclks[i];
+
+		printf("[FCLK%u] DT: %u", i, fclk->id);
+		mtk_clk_print_mapped_id(fclk->id, i, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i);
+		/* FIXME: fclk needs flags to fully determine parent. */
+		mtk_clk_print_single_parent(fclk->parent, 0);
+		printf("\n");
+	}
+
+	for (i = 0; i < tree->num_fdivs; i++) {
+		const struct mtk_fixed_factor *fdiv = &tree->fdivs[i];
+
+		printf("[FDIV%u] DT: %u", i, fdiv->id);
+		mtk_clk_print_mapped_id(fdiv->id, i + tree->fdivs_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->fdivs_offs);
+		mtk_clk_print_single_parent(fdiv->parent, fdiv->flags);
+		printf(", Mult: %u, Div: %u\n", fdiv->mult, fdiv->div);
+	}
+
+	for (i = 0; i < tree->num_muxes; i++) {
+		const struct mtk_composite *mux = &tree->muxes[i];
+
+		printf("[MUX%u] DT: %u", i, mux->id);
+		mtk_clk_print_mapped_id(mux->id, i + tree->muxes_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->muxes_offs);
+		mtk_clk_print_mux_parents(priv, mux);
+		printf("\n");
+	}
+}
+#endif
+
 /* infrasys functions */
 
 static const int mtk_infrasys_of_xlate(struct clk *clk,
@@ -793,6 +967,44 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 	return rate;
 }
 
+#if CONFIG_IS_ENABLED(CMD_CLK)
+static void mtk_infrasys_dump(struct udevice *dev)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	u32 i;
+
+	mtk_clk_print_dev_parent(priv->parent);
+
+	for (i = 0; i < tree->num_fdivs; i++) {
+		const struct mtk_fixed_factor *fdiv = &tree->fdivs[i];
+
+		printf("[FDIV%u] DT: %u", i, fdiv->id);
+		mtk_clk_print_mapped_id(fdiv->id, i + tree->fdivs_offs, tree->id_offs_map);
+		mtk_clk_print_single_parent(fdiv->parent, fdiv->flags);
+		printf(", Mult: %u, Div: %u\n", fdiv->mult, fdiv->div);
+	}
+
+	for (i = 0; i < tree->num_muxes; i++) {
+		const struct mtk_composite *mux = &tree->muxes[i];
+
+		printf("[MUX%u] DT: %u", i, mux->id);
+		mtk_clk_print_mapped_id(mux->id, i + tree->muxes_offs, tree->id_offs_map);
+		mtk_clk_print_mux_parents(priv, mux);
+		printf("\n");
+	}
+
+	for (i = 0; i < tree->num_gates; i++) {
+		const struct mtk_gate *gate = &tree->gates[i];
+
+		printf("[GATE%u] DT: %u", i, gate->id);
+		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
+		mtk_clk_print_single_parent(gate->parent, gate->flags);
+		printf("\n");
+	}
+}
+#endif
+
 /* CG functions */
 
 static const int mtk_clk_gate_of_xlate(struct clk *clk,
@@ -869,12 +1081,36 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	return mtk_clk_find_parent_rate(clk, gate->parent, parent);
 }
 
+#if CONFIG_IS_ENABLED(CMD_CLK)
+static void mtk_clk_gate_dump(struct udevice *dev)
+{
+	struct mtk_cg_priv *priv = dev_get_priv(dev);
+	const struct mtk_clk_tree *tree = priv->tree;
+	u32 i;
+
+	mtk_clk_print_dev_parent(priv->parent);
+
+	for (i = 0; i < priv->num_gates; i++) {
+		const struct mtk_gate *gate = &priv->gates[i];
+
+		printf("[GATE%u] DT: %u", i, gate->id);
+		mtk_clk_print_mapped_id(gate->id, i + tree->gates_offs, tree->id_offs_map);
+		mtk_clk_print_rate(dev, i + tree->gates_offs);
+		mtk_clk_print_single_parent(gate->parent, gate->flags);
+		printf("\n");
+	}
+}
+#endif
+
 const struct clk_ops mtk_clk_apmixedsys_ops = {
 	.of_xlate = mtk_apmixedsys_of_xlate,
 	.enable = mtk_apmixedsys_enable,
 	.disable = mtk_apmixedsys_disable,
 	.set_rate = mtk_apmixedsys_set_rate,
 	.get_rate = mtk_apmixedsys_get_rate,
+#if CONFIG_IS_ENABLED(CMD_CLK)
+	.dump = mtk_apmixedsys_dump,
+#endif
 };
 
 const struct clk_ops mtk_clk_fixed_pll_ops = {
@@ -882,6 +1118,9 @@ const struct clk_ops mtk_clk_fixed_pll_ops = {
 	.enable = mtk_dummy_enable,
 	.disable = mtk_dummy_enable,
 	.get_rate = mtk_topckgen_get_rate,
+#if CONFIG_IS_ENABLED(CMD_CLK)
+	.dump = mtk_topckgen_dump,
+#endif
 };
 
 const struct clk_ops mtk_clk_topckgen_ops = {
@@ -890,6 +1129,9 @@ const struct clk_ops mtk_clk_topckgen_ops = {
 	.disable = mtk_clk_mux_disable,
 	.get_rate = mtk_topckgen_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
+#if CONFIG_IS_ENABLED(CMD_CLK)
+	.dump = mtk_topckgen_dump,
+#endif
 };
 
 const struct clk_ops mtk_clk_infrasys_ops = {
@@ -898,6 +1140,9 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 	.disable = mtk_clk_infrasys_disable,
 	.get_rate = mtk_infrasys_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
+#if CONFIG_IS_ENABLED(CMD_CLK)
+	.dump = mtk_infrasys_dump,
+#endif
 };
 
 const struct clk_ops mtk_clk_gate_ops = {
@@ -905,6 +1150,9 @@ const struct clk_ops mtk_clk_gate_ops = {
 	.enable = mtk_clk_gate_enable,
 	.disable = mtk_clk_gate_disable,
 	.get_rate = mtk_clk_gate_get_rate,
+#if CONFIG_IS_ENABLED(CMD_CLK)
+	.dump = mtk_clk_gate_dump,
+#endif
 };
 
 static int mtk_common_clk_init_drv(struct udevice *dev,

-- 
2.43.0

