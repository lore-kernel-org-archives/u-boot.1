Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD978C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3723084BD1;
	Fri, 10 Jul 2026 20:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JOydpudl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B75E84B9B; Fri, 10 Jul 2026 20:59:38 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F9784BC8
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44cb057311bso632346fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709974; x=1784314774; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hoW2BW+zYhRDVeqW7hrIPAhaeQ41A2mmCa7YBpY0yB4=;
 b=JOydpudlVZE+KxwI0/50Ee6TTD2k9tftta+sNBYzaL6aPI5kHyGFjgy+DstfOIc5yp
 cKaVCZ7gZKwJUb5NBi2dvH/GeySY98WbY/FTKkc+tdJssbK31FsyD5jN+01CiO8f1gxy
 5ZSHg8oWey/1kyMzZLSdLt412OW6qw15z/a60Pga+aeO9ltsC971E4CigLxYXC0sJ5Ds
 6kcN9G/SO5ZHbAvgPk5fBQozy+lt6GWem/eAQB6COkgjVmeNmHuajyQ6/a/L+1q7Jr04
 Wjew2Sp8UcXCeVb4n1cYhNr9x6JX8sJw7MszyNXIi/5BLllvKozgnCxd1j9ZApqrVTX6
 jaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709974; x=1784314774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hoW2BW+zYhRDVeqW7hrIPAhaeQ41A2mmCa7YBpY0yB4=;
 b=CAp5Eq7ETshc9RBi/lSzL3NP5g/3fr6cR/pcs8IUOLmgOPvCdKOS8BXyO7UCbk4/ws
 i8Pqf0Rn+ZshVXdLuzRTDjRUBIncAeF9iLdWPLOdBTGKeamDKuui7V4mQXnzMsfUVWrE
 lwf6OrhpLmayoSnTE2N82SjvYyn/y2q508XcXd3AhFiI5dWcK5RUFvWWr4H9EadKAVQL
 TllpkW8FQUSgfzAXx3gxcRLf96zlXuc29KEbQ3lIOMwpeH+rv4ykhopDJkgDBeIn8Ryl
 sGdQUSDGDq1ITAFCm42NEgYGDoEZBtcuYBkTxI9l+Hmm615IOLz9x1D3zZJ59v8DFnUm
 A7OA==
X-Gm-Message-State: AOJu0Yx5YFCAShzlczdyWrupyGM1gdtbyYy8Ipy9H0AsJMwK8BkPXsad
 stGQx97u6L0DECZ7NODX196hiRYsRttHFo16FY2Ngdms+JuEgbBiX4waQnjTC+9OcxDdTY6feA0
 9lzCB
X-Gm-Gg: AfdE7clxcEwxi+LMQXpEGlfPZWzgnoSxzBo0eSTPQOyh9mUQ1HxMA5F6I8xkbMaWtyC
 lccrNp/qdW1XGW5ouV4qZH011hirjA8NoBvRF1BBAdOf0FQhuKJE5bhK8uJtSHZG/F8Nv27DyBY
 S+iN4r6yQJwMUCqtA+q5hCs6oS+2JUBkeRWYu3YPwPV8WMPp15LMNwolJYTNH5IcbQwAvwfTX/s
 ZdScElQikvd4IOYcOyxybwEIXwvHcXIHTWv8PCPGTV+jrlFFo5daNR4r4mBv3xb2h1IyqDssVbi
 gVmjjtahtwt1/B1k8m6Oc31q3MJWzjbVWy0vd48U34A3KuZWPQvWS5mUjTA4mUUT8dN/44pdMyu
 owQyTqAL+WxkFXjoHot+ihoPv8B78JaqpAEVuhqa0aEL+3ThsOZ6m9oDmegNKzgjh2RWhJ66bIL
 H5Bh7QgR6eT2ZoWACN
X-Received: by 2002:a05:6870:8455:b0:448:558c:d84b with SMTP id
 586e51a60fabf-451f148922amr83011fac.38.1783709974648; 
 Fri, 10 Jul 2026 11:59:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:32 -0500
Subject: [PATCH v2 16/24] clk: mediaTek: mt8516: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-16-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Z9UnAAEbJ+2DoDIl0pUhL8Cni9wDj2r76F2xUJRCJb0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDBNN/K3d52Z3HVclfQ38R0s7ijUGuXAmH4n
 eX1zMCmnpOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAwRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9mcIAI0Pf1OLitmg7nsCqzWNYnm/0GR4Q1/2lDBGran
 49SaD4N/As5nT6kuh1SaSPYwI5wJzT9t0c8V7+tbXgEIv5kh2+sUD6ASm5f2nnJDKePKdH4VfoK
 tC6/pXwrcuAJtA8vlVzUB84fMpDFwRpF3+MxcmoVQHZ1dVJicNIGtK8hlpZqvv/ZYyqAQsSOugo
 c6ZhfuikCvD2byk7xhwSP+YPWWzFiUDlu0ChEgBANhUyk7kbADiHiq4TQSb84jUP4Kp2BO87qTn
 n2hhcb74cIaTk0QTqpZZB8zQ4itpTkxibEqqFvrgOYQ25J9LOr7FmptBsoO1JusUPlxhpMSWlBG
 AjGU=
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

Add clock tree type flags to the mt8516 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 1070dd1551b..3824885682b 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -744,30 +744,42 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP5(CLK_TOP_APLL12_DIV6, CLK_TOP_APLL12_CK_DIV6, 8),
 };
 
-static const struct mtk_clk_tree mt8516_clk_tree = {
+static const struct mtk_clk_tree mt8516_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_DMPLL,
 	.muxes_offs = CLK_TOP_UART0_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt8516_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8516_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8516_clk_tree);
+	return mtk_common_clk_init(dev, &mt8516_apmixed_clk_tree);
 }
 
 static int mt8516_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8516_clk_tree);
+	return mtk_common_clk_init(dev, &mt8516_topckgen_clk_tree);
 }
 
 static int mt8516_topckgen_cg_probe(struct udevice *dev)
@@ -795,6 +807,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8516-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8516_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -805,6 +818,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8516-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8516_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

