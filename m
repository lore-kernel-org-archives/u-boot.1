Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFE5C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6258384AB8;
	Tue,  7 Jul 2026 17:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PVYJcWOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA85184AA4; Tue,  7 Jul 2026 17:10:51 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C708496E
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso2087970a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437048; x=1784041848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bR9IxdNqLBNAIqJkTMLptz/rrK4hD84GEHXnG6nQP5g=;
 b=PVYJcWOJgt40WXAMILkwyix4VbwTXNRMBu3A9bOt3fpLpYtq78/ZjMU4pbNojLKRhE
 Rq2o9SFU6IKLcP3PuzI+647lJK3h0pu+fgVr83thDVFH9z7NmC08gqlmHJqBWBqAT1rO
 R//iMeJNL6TS7Vsp1U6oFY7In85z8FuAXnOrk0EX5DxwPjKNIFec9j6J4zB/bt/Ia2Vo
 PujkgoDup/l62gQDN9GmfxzxOYpsJaWNexTbes2tRte17qJELeTkjGg+ZikvIdkEESlG
 8kzUvdXilxfEoCJbkpJGNy+cNX4G4g+K62WJTb0R1C18Rk5AjJnZHUfB7LaX/PHob+nk
 OhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437048; x=1784041848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bR9IxdNqLBNAIqJkTMLptz/rrK4hD84GEHXnG6nQP5g=;
 b=eehMkGwqNbfuZUXwqjJ0TXU93vT0cjg6tM+gm77bKigH/PsfTXSYRjXzeW+uIXipdS
 82O1VWXKR4gidsAdkZQLUMwd5kqbDUm0UlIHAOXhjQJHs6w4qLFlrYAQwiAoWKC/8n5P
 03ABkOUsQvnMuMwxLwhDFr8iVRo3PQ6Mv4qZK0+5hyQzu0cn7vsF710z2M4j/wt+S99C
 BdTwPgioegujK4RgyQqgL1zxYS8FcpV4axSjcwcOHiZQmmFb5bDWS24ksBgruSSo965l
 otiLPTttq/VI4rW7z0qO8zJ5JUAWSxL1u5VmSH5NGqKym99nZGvIMpXBw2w6ocvgTS+t
 KUhg==
X-Gm-Message-State: AOJu0YzMR6F1K6X4hhQp4bc53mU6xOJLGN711Pr3PZzsm0VqM1xy0+fD
 lcHSMjdC0sPHM7hxx3doUu5Qsk0s5psBwzu4AHFT+1SsUXa5FknICo37NEiMlQSAZMA=
X-Gm-Gg: AfdE7ckqZiUYjfM1B0+8FPC7vaplkcrC7jllZSzPkuMuw+pWSB98jkxYe3TkII0wiEh
 fnScjFx/ATl/195bEnqhzqoqe9bNqUsbcWqbWcEQgtEujab9T5WwIxnsTK8HxSJVBVByr2VLmL9
 VCOUFJj/AX/PXgywrtaDUZvVGKYsgNKj0mvkncfK4UEJFaIoFEeNe3u1ES4xmCaQUQbkY8XpoZE
 MZgVL1LUa0yYIqy1ZnkKH75JQxkpagS1hJyynejpdolTD0pC6P8vNwn/+sQYEjhQFzlUn+nWZdb
 PW9mb5S550vgsnQnt2dAsUhi1HsHngyJSnINIwTGncOx7AyTum8zvBH0QahM/JCZq8C92mKPaEG
 +P6x5uSS0gYMt2KSSsSqBwUKZpzGXAKZVH7OR7yyIHw+RekuLhCd2VWCAk3fE6esZC2QSPaW5jF
 aUDO9uUpHbS6msS9R2qby0EJzqlome
X-Received: by 2002:a05:6820:623:b0:6a1:8113:d7f2 with SMTP id
 006d021491bc7-6a35558a410mr3628817eaf.55.1783437048381; 
 Tue, 07 Jul 2026 08:10:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:39 -0500
Subject: [PATCH 19/24] clk: mediatek: drop parent udevice field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-19-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4509; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wtQwn61b/d92nCNHOUbmy+oua0oARFEQZzAOd8wEzh0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaw7QKU42Y8LtzoaeTa/Pbh4hm3EbfXisoDj
 Ph1ETKteIeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WsBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3c4IAKHWVfXmqbp29Ehs0JRo6YzkUJgw8dNYurAyMwS
 rSvLbA94fUFJnf80NqNFIKJ7kU5kGW0LI0IQH+QOfDbUtrY8MRmLpIBxYl/gJk2I7jsQe/0SXxw
 bNs12nOGpqCAhlXXT2u3ZHo+yKPM9GVkx3814knE5dQj0p3/Db8YfPSsSxg9FZr8asTjxq48whr
 LOivFQmqvvzADn0GZQgmgeVxm3Nc71JHR+PdTxbGLGZ9OibR1Mly6mGYTtNpKZDqUZb0H6NM+gv
 z7msY+OHrzASIgJG/2w2a/L+uP5xNOSnt70U0t5MIkTso2H8Mnr//gSC3dHeN7Qg6M+6Q+x5YEO
 cf2g=
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 47 ++----------------------------------------
 drivers/clk/mediatek/clk-mtk.h |  2 --
 2 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d1cfa70e5a6..0afd94ed4ef 100644
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
 
@@ -1189,43 +1176,24 @@ const struct clk_ops mtk_clk_gate_ops = {
 #endif
 };
 
-static int mtk_common_clk_init_drv(struct udevice *dev,
-				   const struct mtk_clk_tree *tree,
-				   const struct driver *drv)
+int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	struct udevice *parent;
 	int ret;
 
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
@@ -1234,22 +1202,11 @@ int mtk_common_clk_gate_init(struct udevice *dev,
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
index 10df7571c9f..b9b9360b4bd 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -275,13 +275,11 @@ struct mtk_clk_tree {
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

