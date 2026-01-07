Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FBBCFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F888409E;
	Wed,  7 Jan 2026 17:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jz+VleFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12C683A2D; Wed,  7 Jan 2026 16:51:36 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB5D80433
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65f59501dacso291199eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801093; x=1768405893;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dLKwZZC24pumN41pEQsuk9P9tjQkkR3Je9PDljIN3Do=;
 b=Jz+VleFJKczVkM8pfBa4dZA958XvrLkdWsc3bT5i1z1i6pjkd/AzJkRm5zLf0z2s18
 t+uzh9+cK5k8ZkFyhBGI8HT9s9lnIdJqBxKrhUrhauMIvTCaKmsbMnhhJU6KxHiwZ79x
 vOEeYu2x0U0OB8MlW4SOmbAFctjm+0CTDm2iA3DyslKjmlOPoRv6GrfXXBL/byVBx0WT
 qn4sNIPq/rPyohB9m1iYz3fGBgm9BSqRKT9L8uoAh8a8mjATY+9ruo4qjI8qqoxDZKpK
 yOEIJ1syhmHBRJIL7tDdz524fQB15qvAa50S81Aje8HfPq4cb/yZqYQ2dh7MuaG+BOpd
 DhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801093; x=1768405893;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dLKwZZC24pumN41pEQsuk9P9tjQkkR3Je9PDljIN3Do=;
 b=QesE6jBA+duXalui9EkWmq9edRrtEdICgarG8qKeKI6Ps9m18Hp57jW2uvmQauxA3J
 o+8/MtYf05gIGBju+fo8lVYkPCPoZrkTc8u6TEpR2J+KQZBZ//55IHz+Piph03c1tAjr
 LEo0b0ih5qHnT5lxvlS5yZrVivBg+d4PL7vzI13h8rtMWKdBOPgat1Y8JtYrprXI99WB
 CSmCGu5KPcPEpEQrWVxR6a+f4gVJdJonr/F0heIeL1fcyDfiLO48EnHNv0QoWr4rKADb
 33JE6CCqrBYisBYnZDx5hxMJJT/S79oIkUJUArrZpwsK57LujDGIgH7+jSVCO8fXbpmI
 HF4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJvGRbODlkLepx4oUhYpro2uKTaaci5a9rzdSsv4bfMxUIr89sVoLoDmxOcjf14jiZ9JB4mz8=@lists.denx.de
X-Gm-Message-State: AOJu0YzVIBiw7aBJ+RFCzSA+7iPWfa3ZvOYIEFvNBflO3UDTkgNteZ8d
 HRNnsjTxizcQfYVDsFbGT7U/spZJfh3tPhYYSvI6hjvseIP9kra8GWRGjtzJaHVpN9A=
X-Gm-Gg: AY/fxX79arMZ2VyGuFZc/cbm7cX/PRBclKTaGC1QbdBFo0iWc/vop0EkRtAsnNuRGQQ
 fj46TMYu4Bj1VDzo/6Fj4yQnvVYiNFLRKVo88Eti6J8GVy25e0LFEJa2PdfNpedRNI7qc6wCSew
 MkcnP6dYPjV/+VKbCfWAHs3X7xlsLAtY+ALMsv8w7EKU0daKuYRZFJ+CPXEaNs8UrOuDzTw/5zZ
 rr5Lnj2tLsgQFcyptd6/3+3R4L8L0hmbRKpcaY4XOiQk6vem8hGlc96Xn9QqdjFo4/j1UQ8zAPw
 WXjoCjOwwUPhOn6XWJtCf05cIuqHC0drV2hi/xSMaCe26+hz975HhqRPDjVfI2OedSrE+Gg6HWe
 GAd8xZPoS62w5AMNFONqY5MJfWa3KHyagfzIoQYKS2BZfPXthKhaJapikFrYG1nFEYMbd4DBhmQ
 lBccVRSRrshffI+9g=
X-Google-Smtp-Source: AGHT+IFgCzAOz/nz2cAKEdKTgbtHHLLMjFlAq8+cEi8nyJ2j5pEqMa6TGYUuEJbOvUSdDMCEXJVgMg==
X-Received: by 2002:a05:6820:1c97:b0:65d:1ec0:300e with SMTP id
 006d021491bc7-65f54f79b1dmr1002455eaf.58.1767801092844; 
 Wed, 07 Jan 2026 07:51:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:18 -0600
Subject: [PATCH v2 8/8] clk: mediatek: implement dump callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-8-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDu3AOEupqIy5ZadDiknfyu/x0sWBcdyO24z
 8D/Ib6/koeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6A7hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Avw8H+wbnYREZsi4zvQabHc22bgeRPU38v1toAk84kxq
 M8SZQ8ZILosvXfQ64X8/8duN1ArnVl2OrdJKabFXwIEOe9EclWm5UhGVjP68HpCnZa/XmBm09ws
 bj4FIJvwhC6omASSI3d+0g2e5Rc1DJF1SgGz+7P9iV5WoeOGTLZSBTHWixrJjSn7pLW6HJS9Mr0
 ZMZS1j0SMcqHOWUy442OZppaBE8za4xVv04AoO72kgoOJevlV8u70Qd6n88xcWAZhw3VnhCuuen
 zTukB42Y/5Lna2pz8jrjkQXHbPKAblrpFHETR8AcXR6blN+2AKODXuoKdKzDNkQdBojUFPriumx
 GRfM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

