Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0D3C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083ED84C4B;
	Wed, 15 Jul 2026 16:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZOsrMOyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CD584C39; Wed, 15 Jul 2026 16:28:46 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BBA84B43
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso22467625e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125723; x=1784730523; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziKR2qZDVHOJP457E83cH/O6xrD5sAgappasJwGyGaM=;
 b=ZOsrMOyNqFTkfjsWyQx8Ql6kPP+NQFXy81zXjDGGkveiTy4xVuOL4SK5fLAlgS2r/N
 17rFIL9XaVZl7o5Xb4eyXAsnJyO7X6USwqhnl3m/1odmyChi2c8QFtCzs23jqeA9G8X4
 t4KyfAlJsuqp+Huhq7xuY4FYtf9ZgkUdAbYfNM3HVTLWCa9txldHl7bfPfoDkOWEqBYw
 64iB6TR49ZPNS17Ru3UQhZUhgdvJLFzVFyC3XOjUeNtzLT7YYZEOYlr48H47cSlqn4t7
 Mw2qpYdM7fYe02RQvhBD+zwT35G3jslmTAJ1dC/1NDa/TykMc4H0ztQMrGKS0jxvUWMs
 ef0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125723; x=1784730523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziKR2qZDVHOJP457E83cH/O6xrD5sAgappasJwGyGaM=;
 b=VcnwPyX+0z564q8/tj4yIxb03ihj2rI96NfFF8bYsyfhCCjytIcJ98V3/IWgGZtcyp
 hL8WylrKb93vXCEA2ZDhiSo9dxPKkYIYxu32DtgiOsl13CS/yT9xalEQkGGDvD2mT8UQ
 WU8jB1slsvmu5kEKFVR6S6Idxb7AJ1M99RmpoOt+dt6gv31DAEXvjg3UbQgtUdMJ7yMk
 odwiKu8vluj5H1ZBKfPpwImBXNKoxUNfTrmRH9Bs2MucmmOvx5mfSnQRWGkkn7AYjVsP
 e5Owj0Ydu8VxVnlzMEkfozKSCkt5V1v89rAeivxs17eYpTO9Xr7eAuObaQrnIaP4IZoV
 Gl1g==
X-Gm-Message-State: AOJu0YzgDhgFLJIz2hv30TxMp4iqq4rEGdUOGDvH4UH9GLdmBPrsEFXY
 miXn5/XLGmAiNuJvZnVebfryhaT55TSTaHV1dfhK1GKVBVq1Nr70OPNGeyUoHq+/fb4=
X-Gm-Gg: AfdE7cn1Vd8uOcdqAIj8PaXr956OAcawRIgyQ4ZyWJDMNJklaReCKBuvrjSifCyTHSt
 L0EBC8addrks+lzD5c897ae88EE9e87xf/66uTWpdmUMaYG8zXRc71Ai4RHjqXRlQPRGA4EHkiM
 LEflADuE9dFlRwbsGcCj5n58WsL0CXPMhwD98rBtAWwHtj69Sb3TjYi2IEfCJyvyqg3O1YvPfmG
 nqwjRSbE8uRhci5tmRV4KAmqgffE/1jvooPjOaWu12M7zHPD/5POg0CoIiId0Pgzy/j8Z4SXhAB
 LathLT7eWQJHNfkZ5F1J3/yQKgZZndZzEhkwmp8a6Gt4V+8CeVnypiUNCga2RmLAwaq0ehQJz35
 UvaI+lShf2DWJvhghLQbedEifmhMoMeVcirb9PP5VgMNIP72eVkwp1/dbhbW0PxaICE0oro+N+1
 jb5do6K4522AYMRcRsUCp8ssMbH4zpoZdpJo9ngIEQKg9Emdt6t9hUkard2Wcc7cxgOPQieXGIZ
 VWfPk9uhNEexmEtGADfX02nWQJxKYltQERo7GNALAMTAhfMVgqLOijfdLQK/OtPx3RCQuT6B+9S
 4esvRro=
X-Received: by 2002:a05:600c:19d0:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-49518308220mr94220745e9.28.1784125723535; 
 Wed, 15 Jul 2026 07:28:43 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:45 +0200
Subject: [PATCH v2 17/32] clk: mediatek: mt8183: deduplicate clock gate drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-17-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>, Sam Shih <sam.shih@mediatek.com>
X-Mailer: b4 0.15.2
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

Describe the infracfg gates directly in a struct mtk_clk_tree, reference the
tree from the driver data and use the generic mtk_clk_topckgen_ops instead
of the dedicated clock gate ops.

This stops using mtk_common_clk_gate_init() and struct mtk_cg_priv, which
are scheduled for removal.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index a619dce5ca3..a168a2eb9d5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -627,10 +627,12 @@ static const struct mtk_clk_tree mt8183_topckgen_clk_tree = {
 	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
-static const struct mtk_clk_tree mt8183_clk_tree = {
-	.ext_clk_rates = ext_clock_rates,
-	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-};
+static int mt8183_clk_probe(struct udevice *dev)
+{
+	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_init(dev, tree);
+}
 
 static const struct mtk_gate_regs infra0_cg_regs = {
 	.set_ofs = 0x80,
@@ -802,11 +804,12 @@ static int mt8183_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8183_topckgen_clk_tree);
 }
 
-static int mt8183_infracfg_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt8183_clk_tree, infra_clks,
-					ARRAY_SIZE(infra_clks), 0);
-}
+static const struct mtk_clk_tree mt8183_infracfg_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.gates = infra_clks,
+	.num_gates = ARRAY_SIZE(infra_clks),
+};
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
 	{ .compatible = "mediatek,mt8183-apmixedsys", },
@@ -819,7 +822,10 @@ static const struct udevice_id mt8183_topckgen_compat[] = {
 };
 
 static const struct udevice_id mt8183_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt8183-infracfg", },
+	{
+		.compatible = "mediatek,mt8183-infracfg",
+		.data = (ulong)&mt8183_infracfg_tree
+	},
 	{ }
 };
 
@@ -849,8 +855,8 @@ U_BOOT_DRIVER(mt8183_clk_infracfg) = {
 	.name = "mt8183-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_infracfg_compat,
-	.probe = mt8183_infracfg_probe,
+	.probe = mt8183_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_gate_ops,
+	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.54.0

