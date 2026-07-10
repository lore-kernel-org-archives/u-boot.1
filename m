Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7984CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649D98407E;
	Fri, 10 Jul 2026 20:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="boRC5kLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190028407E; Fri, 10 Jul 2026 20:59:42 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B5884A90
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44856d185bcso681079fac.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709978; x=1784314778; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGSeHIq1E6tUkU1n97vkOmiM2gVFmaviiqqDwyf1B3U=;
 b=boRC5kLnZEG9OwjOhI4wuVANUnqGq3uD7ifQcjK49EiZWViQr+T6s/K2PNSpNio9Bg
 K2BLI4DSTyJR45xHH+leX3G0GLKV1NeIfm8WsO6JqHdHGLGoKZd3TGeFFy3LM/QrRO1T
 E4pTLJokdKTfI/4xUdolq8B5jAoCxJ+34QUJ5RIsJinLWSEAPOFwqDmZAnqlDN3bXro/
 /rkrtsfzmBZE5dEtpmh6yqNrWP0MnOISpOPMLjTC8dGhiaNb99TzYJv+jo1v/WElOz6p
 euO8PCQE0zL2RJHafp5LRAEnEaNtr8sEgZOk5xqzrI32Vxm1gdJn0orN1AnayzDjGXks
 DCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709978; x=1784314778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGSeHIq1E6tUkU1n97vkOmiM2gVFmaviiqqDwyf1B3U=;
 b=kok+iMQP2sgqc3bq8Xu+ETZt/lKUgyZ1BfZ1c2QenYsO/HF3GrC69j/ecvgpVyCvRu
 Kplhk0GoZcJxj3oKF7dl1BOoyRocdRP3ucTlDMqDfdz3fffwP/Z/ZHmyqV6yY/OWfjz5
 rdgkYx3/sx3Dn+esq57NucwkwZYc9yNH1ODsKaTD4qkEkmoVfpW0L7g9NMDklICMhxmg
 jqLUPSWMOkqz3Ia/CsjdZG8H3WCRTM9v0hVockyp1GgieSlL1Zasavi95si3rWIe7kC2
 7itd66kBBIoP2HDO6D72m8u+skNkVV4cexb9Z+vVB63TPZ4gXD8JDUUrifiWovacOKIr
 5DUA==
X-Gm-Message-State: AOJu0YyM1QvbVqkkT2FMi76gr6i65zm2UG4Zh7XdAWPblbr4H383ciq8
 2T2FgF2FaHbDirL3YRTs1mqx3ijbWzBhIK+lEkUxk3UgJYAU/TKp2Q1FFTSIgcDrW3A+XjDZhYw
 md66L
X-Gm-Gg: AfdE7ckeoRCJXI75Gnpk3Xyd7YNTFicSMVE/BY/iBj6rYt11+IdRaZhaTEMCtEo1spd
 J/LEot4th2PsFYMZM1ArHmN6SPDoFD6CyKtyYJw7e/wBUiWSLhsRNbUP3iUiBTYiY8Oa/PWSTIa
 Hq3hCpKsPAeHRxaAk3uiGIZ2JnOfiT9oVSPHlbz2nqTgqEVgVFG/tu4oHserMOqTbkQAPd8JoIh
 QwikKqNqp6wGA92a0lsshezIA6GWPb6ZJLhHtznL43UeaRlz8vE7vNGehJkBpqAURovWqP8RN1t
 JlSajBWaj+ZVPDtPGVr7CcDMz0IwV0yjFAPovBHDqO/BRrcjfvW+p0wyp7GLSoGj0P1fO5TQrQK
 loKuPrKeIlq4x7GPA0o/RKp/B7UFomfii1JpYR9aq4Y4XK5quNrW7rfodo0oS3pTPnKm+IvdNhA
 MszDsByrdsKRh2a3mb
X-Received: by 2002:a05:6870:f629:b0:43c:5b9d:4bfd with SMTP id
 586e51a60fabf-451f14838fbmr91967fac.31.1783709978568; 
 Fri, 10 Jul 2026 11:59:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:35 -0500
Subject: [PATCH v2 19/24] clk: mediatek: drop parent udevice field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-19-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4826; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AKPwBtyaz2JY5jcIIl5Xte6SIUMkuGbyI+QCCqnlQEE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDWpWeQukfqRNQsMawHE9HASo6VGIBZG34a+
 nxcsDWqUXWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AisMIAJn096X37qT6KjXcI0yT7Nz/WADk3aTxrCv/e4C
 +0Oj4eK1s4GpTh/pUDlsVbClf0AXHGb7BzJXdmF4h5UjwlVLrDsJM7g7TatyTJHqM63N+nWL0ec
 uhoN0iHPhaQQkI6Bi+wsp0iOR2Ar0B+VMDO/udzHqCQksKjjYn0fZ7B3Vdw1Qht0afAobVC3uTz
 9LBdkPI3vRLSrzAxPJ4OJgP/x7iFdIjOq+wNgS1DE8+oA6LqObHUNW9MKMLzslWkksoq3oyXGKG
 +YYIKuTa+hrMtkfLhOta/SjW4HMKWVfb7wJpp0axw6j6ibHvgLVDzet3j7lInyCQ+rxNMjK3H2W
 rIZI=
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

Remove the parent field from the mediatek clock private data structures.
This was no longer used other than debug prints.

The uclass_get_device_* functions had the effect of ensuring that
parents were probed. This is done now by having parent providers
probe on bind, so re-probing here is no longer necessary. Clock trees
could have more than one parent anyway, so the existing code was not
completely correct anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 48 ++----------------------------------------
 drivers/clk/mediatek/clk-mtk.h |  2 --
 2 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9a1001ff938..52d3428438a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -320,11 +320,6 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 }
 
 #if CONFIG_IS_ENABLED(CMD_CLK)
-static void mtk_clk_print_dev_parent(struct udevice *parent)
-{
-	printf("Parent device: %s %s\n", parent->driver->name, parent->name);
-}
-
 static void mtk_clk_print_mapped_id(int unmapped_id, int mapped_id, bool has_map)
 {
 	/*
@@ -677,8 +672,6 @@ static void mtk_apmixedsys_dump(struct udevice *dev)
 	const struct mtk_clk_tree *tree = priv->tree;
 	u32 i;
 
-	mtk_clk_print_dev_parent(priv->parent);
-
 	for (i = 0; i < tree->num_plls; i++) {
 		const struct mtk_pll_data *pll = &tree->plls[i];
 
@@ -883,8 +876,6 @@ static void mtk_topckgen_dump(struct udevice *dev)
 	const struct mtk_clk_tree *tree = priv->tree;
 	u32 i;
 
-	mtk_clk_print_dev_parent(priv->parent);
-
 	for (i = 0; i < tree->num_fclks; i++) {
 		const struct mtk_fixed_clk *fclk = &tree->fclks[i];
 
@@ -1019,8 +1010,6 @@ static void mtk_infrasys_dump(struct udevice *dev)
 	const struct mtk_clk_tree *tree = priv->tree;
 	u32 i;
 
-	mtk_clk_print_dev_parent(priv->parent);
-
 	for (i = 0; i < tree->num_fdivs; i++) {
 		const struct mtk_fixed_factor *fdiv = &tree->fdivs[i];
 
@@ -1122,8 +1111,6 @@ static void mtk_clk_gate_dump(struct udevice *dev)
 	const struct mtk_clk_tree *tree = priv->tree;
 	u32 i;
 
-	mtk_clk_print_dev_parent(priv->parent);
-
 	for (i = 0; i < priv->num_gates; i++) {
 		const struct mtk_gate *gate = &priv->gates[i];
 
@@ -1200,43 +1187,23 @@ int mtk_common_clk_parent_bind(struct udevice *dev)
 	return 0;
 }
 
-static int mtk_common_clk_init_drv(struct udevice *dev,
-				   const struct mtk_clk_tree *tree,
-				   const struct driver *drv)
+int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	struct udevice *parent;
-	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
-	ret = uclass_get_device_by_phandle(UCLASS_CLK, dev, "clock-parent", &parent);
-	if (ret || !parent) {
-		ret = uclass_get_device_by_driver(UCLASS_CLK, drv, &parent);
-		if (ret || !parent)
-			return -ENOENT;
-	}
-
-	priv->parent = parent;
 	priv->tree = tree;
 
 	return mtk_clk_tree_register_provider(dev, tree);
 }
 
-int mtk_common_clk_init(struct udevice *dev,
-			const struct mtk_clk_tree *tree)
-{
-	return mtk_common_clk_init_drv(dev, tree,
-				       DM_DRIVER_GET(mtk_clk_apmixedsys));
-}
-
 int mtk_common_clk_infrasys_init(struct udevice *dev,
 				 const struct mtk_clk_tree *tree)
 {
-	return mtk_common_clk_init_drv(dev, tree,
-				       DM_DRIVER_GET(mtk_clk_topckgen));
+	return mtk_common_clk_init(dev, tree);
 }
 
 int mtk_common_clk_gate_init(struct udevice *dev,
@@ -1245,22 +1212,11 @@ int mtk_common_clk_gate_init(struct udevice *dev,
 			     int gates_offs)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(dev);
-	struct udevice *parent;
-	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -ENOENT;
 
-	ret = uclass_get_device_by_phandle(UCLASS_CLK, dev, "clock-parent", &parent);
-	if (ret || !parent) {
-		ret = uclass_get_device_by_driver(UCLASS_CLK,
-				DM_DRIVER_GET(mtk_clk_topckgen), &parent);
-		if (ret || !parent)
-			return -ENOENT;
-	}
-
-	priv->parent = parent;
 	priv->tree = tree;
 	priv->gates = gates;
 	priv->num_gates = num_gates;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index ce0685b830e..2993dc35efb 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -280,13 +280,11 @@ struct mtk_clk_tree {
 };
 
 struct mtk_clk_priv {
-	struct udevice *parent;
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;
 };
 
 struct mtk_cg_priv {
-	struct udevice *parent;
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;
 	const struct mtk_gate *gates;

-- 
2.43.0

