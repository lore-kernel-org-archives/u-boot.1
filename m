Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7060EEB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D129D83FCD;
	Tue,  3 Mar 2026 01:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kFF0O6IL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD56A83A1B; Tue,  3 Mar 2026 01:05:18 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BE183F64
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40423dbe98bso161767fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496313; x=1773101113;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l2EpeVX7i9YMlF0S8hKLRvldxEaT2DDov1ubFQBxNIM=;
 b=kFF0O6ILF8D/ZSbK08/ZeGU+jIVY8hNibAIMrqKb+MRItAiPSv3rFF5v2Mu+wUWCLc
 zDrtWXXKdmvmw3PTEGZ6GmIo0ai7joi0zTNGVh1jjRKTVtNsrrdK0IkwKnR5RGWdn19p
 k6TaHNjJnwPWi21S2TsBzlowVSBTwrId8Tyq1J9oC8F/24mOPwdMnzPynqAbfZLplVu9
 qhfCisJ+8Z23fFp0DfzDN4DBN0Sl0jkp46GDRf4E1JcwK9YOD6eINbddXKifPOdJrgjh
 lKHzTpc8lHzQ7+YMI5h3tzB5YZJB/hy51Xc18b6jCTv3k4Z1W5GZj7FMXbuzIzgYVJTn
 dVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496313; x=1773101113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l2EpeVX7i9YMlF0S8hKLRvldxEaT2DDov1ubFQBxNIM=;
 b=WstoSMrDGGlBvjs+iaKkKU/zTxFPl70/2SyboYoczFuSRhaOI9eI9yFhaVH/rvb6h3
 JKQMHKh97jMOix/z1x5eO2P3BwCpNsmBcAtxHxExn1uWXeF4BvwI3eb7+7368tqJK8CC
 dywFJ8oju2UCNPLVteE+RwHMMRaz1fhFJ4f3xX9hRzAQCqCzSU0jETILmsXzDJ1IvFGm
 TlCV8Vazv4P0b2Dg4p6+1GiRUU7uOq2aVk8+ns134034WW9znpEg0hk6MiQpn8Fr0jjd
 v/wePngR2bMXyFcaHJ2FMyRWQbcmw3MYUZY52NJ9HD9Xjgm3BhJXT0LPtExEeYXpIv8u
 D3xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnrLX7CRtUAiiFNpkyDoArBUXrTYQBJ7UcOLEevn9MWJAdZzds/RVt3PAro9EuDWND6vxjX/A=@lists.denx.de
X-Gm-Message-State: AOJu0YxHr+zfRBKKuxyvH5D/rHqwayTZnzUZx7UR1EBJM5lJ2+/NZl74
 MVtEcTWZ5PWilh8GJkHP6FHWoQEJCDReW34N+/sqbtil6+FZ24Ev0YeciU0v/i081OE=
X-Gm-Gg: ATEYQzw7qLps24PQFgYcfUzB4iW8UMjU/BuCFhIMWqTcZ2le34LZ0Zh9fhbmyYsjJgI
 U6l1/ZK+iorREunm5tYg5ks+O+hlRHKA/l9OuspiyOCvRneXpBx8GE5z8GpbgwIZFxD6U4GHgkR
 eQtOXoEoVrGj6bfemsnqZz9kLXQ0lNCDPOgDimvCMCX+4rCJ2+Pe9QDVpX2TFqGxrDvI7Ba5bGj
 2YbHrKKuD9ABS7riIjJ75TNGxjQSS7IPGsxD8o+AmM3By4plUIPLe3mic9bABY+r6QrHr5krnNg
 afySxg5hjQrm3Z9IuxpalASm9s54EhNfZoOJUlxwtjN1PTfH5wExGks9MGHL0so79evYOD/qtsf
 4oXA1NzR+xbs/7G6XsB83lPyLiJY7Toekz3VR6Bj5lGQbE+XfVBQjGRfZpkHpRQDse/eWlg5kzc
 23n8XyfltA3ue850zLDRVFgOLkH5qjKV36K7mNWeo=
X-Received: by 2002:a05:6871:c905:b0:409:7d3a:bfdd with SMTP id
 586e51a60fabf-41626e20b79mr8534111fac.4.1772496313413; 
 Mon, 02 Mar 2026 16:05:13 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:23 -0600
Subject: [PATCH 14/14] clk: mediatek: refactor duplicate *_mux_get_rate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-14-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3738; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=oyawHh6/UdSnYLLmS7thJnZY/M8EOmvZOxc0IfqwJQw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiWl3elg4MdwXnn8/DxpqlAO6Hi9CNoc/Wh04
 3wiqE9+NGiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlpRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJEoH/12AVbi1qzmgTsG88RnoQDkS+jDKDblj2i3AhLC
 q0CC6rVdGyf4hNKYAHp402NW37OewY3HGDN9cN5Xa6aGHVGst/csMXDWQnHQ/yCCg26uEdVrzvG
 AkMBwFWsdnTCg74nE1QqmPQXbkQkXDFQLmmxFNMc4v1euTc+ljeKggPWGcxVKYzFF6UGSi0m1zT
 rmFG6+oC3xZ0j9WPe2ODzYP6HbimDV8PnxR14vJCgZghxGipvlRFoOatjdrz2Wsat5xUWjqlXri
 SaZIzGOqbNkv3ENgdSK19hSFghLtAWabRARJ4/Q7a8URhwKzKvnl2i+UIu3+ooy2z2KZbPHFjYT
 AD1s=
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

Refactor two identical functions for getting mux clock rates. The
functions are renamed and moved to the section of the code that contains
other common functions.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 50 ++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c65230a7f9b..c5f6d45fd67 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -253,6 +253,21 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 	return mtk_clk_find_parent_rate(clk, parent, parent_dev);
 }
 
+static ulong mtk_clk_mux_get_rate(struct clk *clk, u32 off)
+{
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct mtk_composite *mux = &priv->tree->muxes[off];
+	const struct mtk_parent *parent;
+	u32 index;
+
+	index = readl(priv->base + mux->mux_reg);
+	index &= mux->mux_mask << mux->mux_shift;
+	index = index >> mux->mux_shift;
+	parent = &mux->parent[index];
+
+	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
+}
+
 static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 				  u32 parent_type,
 				  const struct mtk_composite *mux)
@@ -701,21 +716,6 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_composite *mux = &priv->tree->muxes[off];
-	const struct mtk_parent *parent;
-	u32 index;
-
-	index = readl(priv->base + mux->mux_reg);
-	index &= mux->mux_mask << mux->mux_shift;
-	index = index >> mux->mux_shift;
-	parent = &mux->parent[index];
-
-	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-}
-
 static ulong mtk_topckgen_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -728,7 +728,7 @@ static ulong mtk_topckgen_get_rate(struct clk *clk)
 		return mtk_topckgen_get_factor_rate(clk, clk->id - tree->fdivs_offs);
 
 	if (mtk_clk_id_is_mux(tree, clk->id))
-		return mtk_topckgen_get_mux_rate(clk, clk->id - tree->muxes_offs);
+		return mtk_clk_mux_get_rate(clk, clk->id - tree->muxes_offs);
 
 	if (mtk_clk_id_is_gate(tree, clk->id)) {
 		const struct mtk_gate *gate = &tree->gates[clk->id - tree->gates_offs];
@@ -959,21 +959,6 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 	return mtk_factor_recalc_rate(fdiv, rate);
 }
 
-static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
-{
-	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_composite *mux = &priv->tree->muxes[off];
-	const struct mtk_parent *parent;
-	u32 index;
-
-	index = readl(priv->base + mux->mux_reg);
-	index &= mux->mux_mask << mux->mux_shift;
-	index = index >> mux->mux_shift;
-	parent = &mux->parent[index];
-
-	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-}
-
 static ulong mtk_infrasys_get_rate(struct clk *clk)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
@@ -986,8 +971,7 @@ static ulong mtk_infrasys_get_rate(struct clk *clk)
 						    priv->tree->fdivs_offs);
 	/* No gates defined or ID is a MUX */
 	} else if (!mtk_clk_id_is_gate(priv->tree, clk->id)) {
-		rate = mtk_infrasys_get_mux_rate(clk, clk->id -
-						 priv->tree->muxes_offs);
+		rate = mtk_clk_mux_get_rate(clk, clk->id - priv->tree->muxes_offs);
 	/* Only valid with muxes + gates implementation */
 	} else {
 		struct udevice *parent = NULL;

-- 
2.43.0

