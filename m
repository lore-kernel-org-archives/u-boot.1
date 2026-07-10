Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F658C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C837A84B92;
	Fri, 10 Jul 2026 20:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="OUpl1bK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C78284AE7; Fri, 10 Jul 2026 20:59:26 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7269284B72
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a31c05e1f7so325218eaf.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709963; x=1784314763; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XoQqNLqGIsbgVJMhj6WHbCjkFtxb37K9aKV3WE7yjDE=;
 b=OUpl1bK/fQEWmEv/ypAByMgVq0dvk8k22ws05f4r5AGmbV5048jCf9uYP1yaWGw7jK
 kJ6shYT9WVdDHdNxjTLVI9KpFX51uQv4xNfZrZtQqwQOTIZ+QIVuybCLb7j4vo+Yiucp
 4t/gz4fEkAb+jHGVm0+e6rPAj0+UPPtCam6eBfzt9lViWHnEgtXNpQS400mX4ieQ9aEM
 S1IUwLFX0g5JH7s3BemttOnf52FO2cd/vJ8XkHkMv4xV8c9KYyxed3l/FzzRaTCSwgwL
 3rKm6CPJMd2XxVe3SGQE8vmEwXMQBxtni6IOaIZIvkYiejN/E6lKbSKi4IVHQAhtKJDl
 mi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709963; x=1784314763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XoQqNLqGIsbgVJMhj6WHbCjkFtxb37K9aKV3WE7yjDE=;
 b=Oi7GtCs7IiT/TsruVHSgBLGn7QPNDIiVCs/nKEc0psLx0q9bOToosfX4CX9wSQVPrD
 ow8HVFaOvj1GFLtaI/uwdCsBUwRHeibUX9E0oM53o/och10Nsrk2E6Yk7LKdZBh1R3nl
 wmvLusr79wvEHkok/6sU/SHLINQ7aUADr3/8AHiUJXeaW3ekEiDaZitVIDV7HrTIpN0D
 Gug707OYBbz5QLMmTvM6H2uRWghmVJrjin5tAz2ClKtjlNm2p4PuyPZiKX1vZuq9eQl9
 gBsOtsEITogIeA9sXhKwzyxo6+abRzyf3Aw2hwacVHWxE1fHij1XmTWVb2J3ffG7LXHf
 LI/A==
X-Gm-Message-State: AOJu0Yw9vcQTEUPsNsa8l7/GhF2y8QrM8xZ2QwRF7LEfrGZoC2btUaSr
 RzlvySijjl6KVSgGM904ENCb+y6hJ6hc6LaO8GNgyT3pcghGAgAE+nHw/USxVjLBtcFoocp/9mP
 NWiAs
X-Gm-Gg: AfdE7ckm2KLrxxHT/x9goFshJ7/w1OjGuRVpR4bosNfdzoCBG9scC7bREsjH0KByTRW
 0PSeoPrFf8sR2UtKlO6PGuYFacE8Xx3sLiy3cNbn7Sh49mA7NVBO9/iqsUmr8WCPEhKxAgBCFNi
 DGmpvk9M9BeHSD3nLYliXD7BAPn6TV1KNo9Xrd3nldq9JYMLJwBT9qSm8K0RufLSHkRbfrlbF9H
 wmft1JaklwT0U/+KWa/daFtrx2+4xM8oqzCGR3qjZ5Ec29mEhE8c1Sn2eUKtszJBP3qDcpbN+WA
 MMqTU5PEGSr2bNdK5QdMZOan0d/yk5PndZ3SC1S10ylRNABOPQ9vrJBHOZ8Fdl4fZMw17vyoqdO
 31EWakh+4/hu+xP4g/8gUr8Gb5FaQ/yBFZrnpuY84/evFMx5b/w515UClIby/ZUqFZ9BF7AB3Zh
 N6JvuwAxcaA7h2m2Oc
X-Received: by 2002:a05:6820:8585:20b0:6a3:7d24:7b7f with SMTP id
 006d021491bc7-6a39a5aec02mr226243eaf.17.1783709963155; 
 Fri, 10 Jul 2026 11:59:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:24 -0500
Subject: [PATCH v2 08/24] clk: mediaTek: mt7987: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-8-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2809; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8IuUIBEN5ufl4L2ZReJVDuG+zqSwykdCVcpVsfrJLjU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCMtqN11m3zpRBA2gtSiBBWGS+/TrHMi+YbR
 o1ssjiGWqaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAjBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APqQH/Rf+1SQkCj2EyelnSAYXmhQJBJCCsKFfWizwkTh
 vTMPX5BSozvZkpfQosbex95Pq0mo6p4tNTOidFKfoVfiKfTLaLVtLRMiBpbYd80/rxaxuVQ0GyK
 iqNhOvS6TSVC5s535vA36qSITzfQfMjXJLtRnLaGvS/NBNp8cVdak0n3FFjSGhf5z6aOlMq7lh6
 zJS78AFS+7tNvv3CbqxGkY2gr6SY3tGU9nfyTeBnjR2FK6CeNbZagK/WRzrpUiLh9Aw0Sour9hA
 19rMC4NloR5VvQMvQunaKvhgRtA46RU5fVZAqsq5Uz3K4/5g1/DqLJvvpNiFjtIDtGWiLSradqn
 GzH8=
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

Add clock tree type flags to the mt7987 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 5f102636079..27367de82ff 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -60,6 +60,7 @@ static const struct mtk_clk_tree mt7987_fixed_pll_clk_tree = {
 	.fclks = apmixedsys_mtk_plls,
 	.num_fclks = ARRAY_SIZE(apmixedsys_mtk_plls),
 	.flags = CLK_PARENT_APMIXED,
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 static const struct udevice_id mt7987_fixed_pll_compat[] = {
@@ -77,6 +78,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt7987-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7987_fixed_pll_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -457,6 +459,12 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
 	.flags = CLK_PARENT_TOPCKGEN,
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt7987_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct udevice_id mt7987_topckgen_compat[] = {
@@ -480,6 +488,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt7987-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7987_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -783,6 +792,7 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
+	.type = MTK_CLK_TREE_INFRASYS,
 };
 
 static const struct udevice_id mt7987_infracfg_compat[] = {
@@ -800,6 +810,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.name = "mt7987-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7987_infracfg_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
@@ -829,7 +840,7 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7987_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7987_topckgen_clk_tree, eth_cgs,
+	return mtk_common_clk_gate_init(dev, &mt7987_clk_tree, eth_cgs,
 					ARRAY_SIZE(eth_cgs), 0);
 }
 

-- 
2.43.0

