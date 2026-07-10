Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB9C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7924B84B49;
	Fri, 10 Jul 2026 16:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="DxMRdU0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78CD84B04; Fri, 10 Jul 2026 16:13:00 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E683B84B30
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493b1710405so4963605e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692778; x=1784297578; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMis4QVxuC8dtqjypewtFr9KHLE62G019aBfVL02EOo=;
 b=DxMRdU0P4UaXDWANtkt0mR6RTzNZvpoBrcS3iYNaDLANM0RwdtD7bpR11QWKU+1u9D
 5IZG3YRjLLUQOXm5umB4dJwiezROP2D0lhQ7aLV6z6lUDYHpB8P3b2EQtRCBYSSsFM/x
 lJJNH3WlAk11jhRqjlJvAUXnKBhi4WeCZMyZ7YqMDDES2JRBOSSoIk1u1YgxNIosVuUA
 cCMSUhjbhHwmsDQM/9sCfLMXTILwDW8rZGXfVHOHiyEWsgJoAd8+EY5pEWQrNJMAYtHf
 hzqzNJztwmkrGW7SBeCHoKHkcD1MbeeRlC5ynWwH3Q/hCzfhrT1JAL0HpB4tmGR03G7R
 tQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692778; x=1784297578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMis4QVxuC8dtqjypewtFr9KHLE62G019aBfVL02EOo=;
 b=rlXfQyAr2e2Jf57My45YJfpH+KVR2f+sTGBtBnpUet+WXK5oB6ffycpw6cgqkFbgDZ
 3TT7r1Z6xPiGp7eB0+XVOdc6uoaH7nzFnvIdhbmqdZUzplFjGNqRPiM0FuPw9mwbAp6i
 sNrZDQ4EbWmHkxqlMtMveltLUyLQI/OQHYhnJWDh/MuhHGDUzBnZhJa6rXsI3S0wTfTf
 O21jVokG2FJ60f7NTnfUiAXq+6MsY0INXgMdyZNnJKfIfcb333d551YkWPtqb9TY9M5l
 ZUFr3Lh0B3SH8YxuFt8ACK8L+O2t2rEy2vGTSEASRtPWr9y3BEgid9FuRodIiHRSEKhU
 j2bA==
X-Gm-Message-State: AOJu0Yx8gHqmQBSdIfHhxq0/fXMgeIMHf8YKRs6UlpZGnG1tryXYVhrg
 lNu85QFWpE81UJeoy6Ogvh9qp4A9YAXSnQJ7KXAC7NCKG96lb3k/BbXfIdZCR1SO6cU=
X-Gm-Gg: AfdE7ckufUJ/+NLtT499i/RaE4MtNkj7T/wxgh/+otTN6nYxzEffyp3l6CiPdtugApl
 +R3eRYFBmvfCHJ52AISb9H0SFvESv7ET8qI0ONr6UaUaR7NvUM08zSiIJlbo0BdvSnyiCr+CMfw
 PtKr8ghZuOTejF311amFSBuOxJYgVzm5TEE1uSJNtq/Ym96Z7ZeDiPILRy/UZMV5V++8GdPYENw
 bMIJD6wwcCSZQVv0vuxBnuTx24YBYBE8DO3tXfH1YWeFagneULZ/nRArica3VXXi3QAhYtIarki
 tpm6L7zc8YMkYIrFqo17bvFIa2F2AgLgNydv4/leWAS3lgbk3Ad9qnrCgzy42v5YtNWJOA+TZuE
 5mcSlvcuqPJkn5IcDGXp0SQj5N8diCdB+VpvSUX1Sx/vg9pkD6ej3oVlfoZ/T8MjuisOhgUWNhw
 UJIOZfpgx46fqYsBSnywURC8crrlX7G4froomCI3FK8M8D981ktgBN8VxCljK4Uv62m/luVTtnQ
 wocAda+57dJTwQCd1lDs5DAhSiLtxgyDHpRqunZXiGSyHS4xp9YFr+T0Gw2R0vJd6Q5MTE=
X-Received: by 2002:a05:600c:8506:b0:493:f7ad:b236 with SMTP id
 5b1f17b1804b1-493f7adb25dmr2743325e9.16.1783692778291; 
 Fri, 10 Jul 2026 07:12:58 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:56 +0200
Subject: [PATCH 5/9] clk: mediatek: mt7623: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-5-a4b5c491d9bf@baylibre.com>
References: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
In-Reply-To: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
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
 Julien Stephan <jstephan@baylibre.com>
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

MT7623 currently declares a separate U_BOOT_DRIVER and probe()
function for each clock gate controller, despite all of them sharing
the same implementation.

Convert MT7623 to use the generic mtk_gate_clk_data infrastructure so
that all clock gate controllers share a single probe() function.

The infracfg controller keeps its own U_BOOT_DRIVER since it is the
only one bound before relocation (DM_FLAG_PRE_RELOC), while ethsys
and hifsys, which both bind the same reset controller, are merged
into a single driver.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 67 ++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 56912ebdb53..84fe68dd925 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1069,10 +1069,15 @@ static const struct mtk_clk_tree mt7623_clk_gate_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
-static int mt7623_infracfg_probe(struct udevice *dev)
+static int mt7623_clk_gate_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, infra_cgs,
-					ARRAY_SIZE(infra_cgs), 1);
+	struct mtk_gate_clk_data *data;
+
+	data = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
@@ -1093,18 +1098,6 @@ static int mt7623_pericfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7623_clk_peri_tree);
 }
 
-static int mt7623_hifsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, hif_cgs,
-					ARRAY_SIZE(hif_cgs), 1);
-}
-
-static int mt7623_ethsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, eth_cgs,
-					ARRAY_SIZE(eth_cgs), 1);
-}
-
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -1128,8 +1121,13 @@ static const struct udevice_id mt7623_topckgen_compat[] = {
 	{ }
 };
 
+MTK_GATE_CLK_DATA(infra_cgs);
+
 static const struct udevice_id mt7623_infracfg_compat[] = {
-	{ .compatible = "mediatek,mt7623-infracfg", },
+	{
+		.compatible = "mediatek,mt7623-infracfg",
+		.data = (ulong)&infra_cgs_data
+	},
 	{ }
 };
 
@@ -1138,13 +1136,18 @@ static const struct udevice_id mt7623_pericfg_compat[] = {
 	{ }
 };
 
-static const struct udevice_id mt7623_ethsys_compat[] = {
-	{ .compatible = "mediatek,mt7623-ethsys" },
-	{ }
-};
+MTK_GATE_CLK_DATA(hif_cgs);
+MTK_GATE_CLK_DATA(eth_cgs);
 
-static const struct udevice_id mt7623_hifsys_compat[] = {
-	{ .compatible = "mediatek,mt7623-hifsys" },
+static const struct udevice_id mt7623_clk_gate_reset_compat[] = {
+	{
+		.compatible = "mediatek,mt7623-ethsys",
+		.data = (ulong)&eth_cgs_data
+	},
+	{
+		.compatible = "mediatek,mt7623-hifsys",
+		.data = (ulong)&hif_cgs_data
+	},
 	{ }
 };
 
@@ -1187,7 +1190,7 @@ U_BOOT_DRIVER(mt7623_clk_infracfg) = {
 	.name = "mt7623-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_infracfg_compat,
-	.probe = mt7623_infracfg_probe,
+	.probe = mt7623_clk_gate_probe,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -1203,21 +1206,11 @@ U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt7623_clk_hifsys) = {
-	.name = "mt7623-clock-hifsys",
-	.id = UCLASS_CLK,
-	.of_match = mt7623_hifsys_compat,
-	.probe = mt7623_hifsys_probe,
-	.bind = mt7623_ethsys_hifsys_bind,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
-U_BOOT_DRIVER(mt7623_clk_ethsys) = {
-	.name = "mt7623-clock-ethsys",
+U_BOOT_DRIVER(mt7623_clk_gate_reset) = {
+	.name = "mt7623-gate-clk-reset",
 	.id = UCLASS_CLK,
-	.of_match = mt7623_ethsys_compat,
-	.probe = mt7623_ethsys_probe,
+	.of_match = mt7623_clk_gate_reset_compat,
+	.probe = mt7623_clk_gate_probe,
 	.bind = mt7623_ethsys_hifsys_bind,
 	.priv_auto	= sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,

-- 
2.54.0

