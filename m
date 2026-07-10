Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4A5C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF9F84AE7;
	Fri, 10 Jul 2026 20:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GLFQxRD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FA284AE7; Fri, 10 Jul 2026 20:59:31 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFD984A90
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4472500e25fso669844fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709968; x=1784314768; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oecEC4v+PMdfD9+SACRwG3f+dXRm5K0jmeNMbzu2JdU=;
 b=GLFQxRD8ULFdcaKn6g+IwBCpZaIoZVbxOGfmib9gKVkCjVM17H+L26j/FJ7wk3Ub/n
 rRPdKqGm/lHA8wDwRINjIpH5XS+HLNBoNoORAe5ZI+EnGAlMlcA9IgbPTpuY9N83uy2E
 npLi62BJuoHB4FvL01MkY1QffGx6JHVkSAcNensMegSeIpRmnmz0xBIFLdO12E7xRNp5
 Bzd3x89rX2r7IhFYpEtP75XI4FVIBRrDKSLhaK+K+HJM+UhAz0Vd2TVfvkuhxZoZTXL7
 +Rvi5MEHQXf4/kqd9TjB0O6dhphbQadTxPLINWnRYwOulSZRG/m6rP/miIVVnnfd8LWQ
 lyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709968; x=1784314768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oecEC4v+PMdfD9+SACRwG3f+dXRm5K0jmeNMbzu2JdU=;
 b=nF7eFG+kE+9F5gS+IUb5SlKcc8KzGEGneZyjtASY9D5PfcDKpy5IYZP9R7M8q6T9oL
 1LNFsZoxEzmex6Oeqs7PCEw1y+VcMxNfMKAknUtmAfrsyTDAeuNEhkeF3GUOhLENpzMT
 S2v1WEIkdmxLqYNv8ut7LXr+mupnK+Oed2UsFe0FwOVQ+Jx65PdIu2VAQm1NFQfNX1bF
 mXxEItvxUYrMo7wiZfcPxGEK7xUufGrI2NHNgIOzKTRd78VOwIADHWEXQ4vN4Zs8wP3e
 GmsgUxcJPemA+aCe7p7t+Ic1pa51Fp1IgxwAMzuFoFJvUFQpfMDDe/OtopPUhBfNftyA
 9uQA==
X-Gm-Message-State: AOJu0YzBkxE/fc8k6odJ3xoz0D2i8POpp40BfMwuJZ37hDZr2MEsR+Yh
 Mh/tOtmZprBiebS6q4z+VJkYU7NvhBXGkC5SvIIpko7TbAP1BbLfyATNaIoiukafSaBWMHzAN6T
 axjCU
X-Gm-Gg: AfdE7clZIBduJGtiQ7vTYgch1Vr8PnGs1tkgWnjLxXRbglnENESB2K7QX1RPAgV4sMR
 JlRnyRA2P92bysixVjeaIvYt3TJEMi62voZ8Xld4kJhvOXBbbwazNF2KZ66b64e25EGvqAsTEI3
 9eDV263PKBiVUsRxM6d6NFTmXHOjbO/vqplJddPl6Hq23WEttKWvpKOm4hACCBClnjnrtpipj4v
 o3Z9ra6C2Iws5c+vdCqCIMuGRJXNIlB5oRGxAofQuJr6tMaFhgx/Cx7KkbETGsKHbLvWqESy5in
 fcNv0MWnvsBg4RXUuC5Ahbz8m7wZcuVO4DTHCfKy4SgMnzWLG2vHy86lx3nAiWI4aqJBm35gLLc
 MVndDp/NzYs0Y39CcBQHKd7n08ZIg/0Bp31Vxvg1r2WRCVLBqWR+F0s+TDwkZodmBRUdjzajh7s
 J9ZXK/swOMaxH/fLHd
X-Received: by 2002:a05:6870:5b8e:b0:447:48b6:83c6 with SMTP id
 586e51a60fabf-451f12bf22amr93177fac.24.1783709968301; 
 Fri, 10 Jul 2026 11:59:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:27 -0500
Subject: [PATCH v2 11/24] clk: mediaTek: mt8188: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-11-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HKZVubT0IIXNd8twJRTenUkR23T7/EvmTS5B3sb6sY0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCgcdmWu+9Kd1uvTBAZukPJVxNCxhD26VsjX
 orUemo29bWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAoBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASdMH/AkUGFxke35oMG5v7KRes3fZ91l83AZVwQVPUIT
 ekiifRnr/dM9K5EV3syDUjBu+8bKlcXudjN1eRQaroqqolATdK4pjVOQxjHLOPrK3SNifcAae//
 BsQ9dBY0dM/g7yvvy4o7/rrUhVDFUMAKPy0RoGniFeUlluEGCqa24bSiPZypj0OC3M19yyLVF3K
 MVHBFHoWkKOn7QaaNvAMwudAOG6uqrifJElCNwwufMUhCgdu5qJB7gYdZZPBtTmSumVyEHcRHQs
 GPwNhe5k5BmnNhl/aileBOa5514bfxOcH0wuLQHq5kqNDM6QU4GJpguT1O9njaKW16kMtz9e4mI
 eH74=
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

Add clock tree type flags to the mt8188 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index b82a6ab5452..9cc7180f1e2 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -89,6 +89,7 @@ static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 #define FIXED_CLK0(_id, _rate)			\
@@ -1422,6 +1423,7 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(topckgen_cg_clks),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {
@@ -1794,6 +1796,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8188_apmixedsys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1804,6 +1807,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8188-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8188_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

