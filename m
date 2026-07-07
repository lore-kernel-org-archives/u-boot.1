Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF5C44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2174E84A7B;
	Tue,  7 Jul 2026 17:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mCeiqO0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9672484A3E; Tue,  7 Jul 2026 17:10:43 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C518496E
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6a1133217easo1210714eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437040; x=1784041840; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lwv8eD+5tV9ZleImw4zE9ROI04TqJeSxQrRKjH44HKo=;
 b=mCeiqO0mwsK7ExEACUr2UprQO1L/eyNOnYG8fgxmaO/OLoCG9siEEaVnZgbCnICg+L
 wU/+mMTA/PI/zRhWCg2WjoU7R8KVwft2A6aT6t5TuRgo56XxiBtrX4fPs5TANch6BAD9
 8kvFcai3XueaSkeYaS45Ocx2X1cfeAkoItaYr7mh5FBrBoFA8Vwna//1TQXQJH3ZZ82z
 2PFfRue+knuDUIBXtaC0thirQMizzh7fHYv+PS8JzLZhR+NB7/IHJoJ5G2lISZOGQGU4
 5kIPt/ewBDIqtIDTdnuV8I5y+1iey6Qo1D1NL3wIPde7Sg1PLsKbIkBW2qGaG8GNKWzM
 CILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437040; x=1784041840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lwv8eD+5tV9ZleImw4zE9ROI04TqJeSxQrRKjH44HKo=;
 b=HvP/btG51kSr/Zv5jWb3GY+9u8d1fBZnmTA9JnAjyvzCv4Mvp/8K3x2HeYd49DNjFH
 emkuyW5v83HEOI+l6WHm7kRZDlQkCb9SE3Sewusox+FPYmbgvqXL+zc079Yu2vGy13hB
 V29ChopEHAWZatZ+gMpW2eeXs6Bl29h3PQLPMAumVjcyt7MRoDHjICw/i/p4qPJIT963
 laIkQpR17yUJbXl2aeLIvojpITiT4wiLW3a+dwCzpdD0NaadO+YIPe/qgaA6Ea1c/cmD
 3XLf4JqP1OgDh6baSrFiBAa1sE95hxk+CprTePpgtfQJUfOC4ueC/otXPiE52C40zcP9
 R7Lg==
X-Gm-Message-State: AOJu0Yzu91FCssxOru5V8l593CDNf438C9Wxm+rDLnNVR13giAX1nyJd
 yeHq5C4dLyYxLAPo+1xSGln06eeT4uQLsWwbGhcddoxTrpmyY6t2z0ULgXM5bdfwy2w=
X-Gm-Gg: AfdE7ckTiw7XNUPq4SdBpTsu7bCXLUFaW5cq0I2kwpKvegMWIRTYkKcprjCJTPtjBlb
 P65pTbgQM2K7RlLuVNiqAPaR4m6W5fCpPfI8Vtyjk+4LX9Ht1C0xaYFZCpoMARCt1Ij1PKEQUxA
 YwstcrRah3PM6/yu+o9mCTQwH7juVtFzzS3MqqDCkX9HRX7wk7FLJolurqx/2JrF5PZQgGbMzLl
 0IUh1LMXhj0KYLTItm+AziYocZ5hrvwEFF/6//W/k1iW2UwklsWcvUv8+XPX/4Deyjp82TC4179
 lFdKGdCtj58zfd/nYoyRwQFDF/Nf7dwVboJ9w4aRGgSOWbllZScbETEV3seVn1tMPe5R0Nj7B4q
 gvCZ/euglRPTaAhg+3hKTBIxHHvPfMEj/PEU8jhvfd1PFvCOceqqAwZr65OZtvcUkysDClEhQzT
 4AM362JC/k5vRKEkgqPQ==
X-Received: by 2002:a4a:e904:0:b0:6a1:475b:32f with SMTP id
 006d021491bc7-6a3553f20damr3256716eaf.26.1783437040173; 
 Tue, 07 Jul 2026 08:10:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:32 -0500
Subject: [PATCH 12/24] clk: mediaTek: mt8189: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-12-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kqoneTmugBFC9OZ6B0r4rqw+sa8izlplwgahYORLlAM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRaAcyyoQbcGt0n1mMZB1A/aicZGKZvVtwo4r
 s4d1zC+puKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WgBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFFMH/0ulWLTLSn7p2YzcuyKWuZb7qaZ9B55UlfmzMzj
 yNSs/rXlJiN/YoegA4wXXBrDnwvi5ALxV931r/x7cmrtYO/mCCwhT71deBZNIRojoXr976LMKuT
 D4PfpDvq4yw6l4Z+tiYoIwh1VWthNBefkfxgL5AWaLgXxAe2siO0zQeG9qxT23IHQej3ipMy10n
 YCWhZbcbc4OR0lOYQ7Kh/rddpanuOhw6U0hqDN2ZNyHGiNoTvEHTqPBt5og2Z5sRGQt2blt0yRm
 +5ill5aIDgegi6pWeLXLWITpWxb23q1XRUtjmemqh0nuPm0iqBpylaF2Q2GnVrL9OTu9tBr6ppH
 efpE=
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

Add clock tree type flags to the mt8189 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index b174e259f28..ba89b3f5454 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1898,6 +1898,7 @@ static const struct mtk_gate_regs vlpcfg_ao_regs = {
  * arbitrary parent trees.
  */
 #define CLK_PARENT_VLP_CK CLK_PARENT_INFRASYS
+#define MTK_CLK_TREE_VLP_CK MTK_CLK_TREE_INFRASYS
 
 #define GATE_VLPCFG_AO(id, parent, shift, flags) \
 	GATE_FLAGS(id, parent, &vlpcfg_ao_regs, shift, flags | CLK_GATE_NO_SETCLR_INV)
@@ -1939,6 +1940,7 @@ static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
@@ -1953,6 +1955,7 @@ static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_gates),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
@@ -1964,6 +1967,12 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 	.gates = vlp_ck_gates,
 	.num_muxes = ARRAY_SIZE(vlp_ck_muxes),
 	.num_gates = ARRAY_SIZE(vlp_ck_gates),
+	.type = MTK_CLK_TREE_VLP_CK,
+};
+
+static const struct mtk_clk_tree mt8189_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt8189_apmixed[] = {
@@ -2031,7 +2040,7 @@ static int mt8189_clk_gate_probe(struct udevice *dev)
 
 	data = (void *)dev_get_driver_data(dev);
 
-	return mtk_common_clk_gate_init(dev, &mt8189_topckgen_clk_tree,
+	return mtk_common_clk_gate_init(dev, &mt8189_clk_tree,
 					data->gates, data->num_gates,
 					data->gates[0].id);
 }

-- 
2.43.0

