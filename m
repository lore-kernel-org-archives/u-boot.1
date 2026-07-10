Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D90DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B103084B04;
	Fri, 10 Jul 2026 16:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="gWQwp4as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360A184B5D; Fri, 10 Jul 2026 16:13:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCF084B37
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so1570915e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692782; x=1784297582; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QH6LjrrKr29iWY3l1XIL+b7IzBPcM5LTW+rtFNIK8pw=;
 b=gWQwp4asyp81dLQnAJXGh24YEKC4xbHtapReU90fN3c9ZyUXf/oCLFsSj9IjoR5D2y
 P54tLELxrymy30cX8Z/6QQ6P+agFBT9++2rqNOeWtn3asOScXAz2Apa4hmlW6fdvQTMn
 acYltHurbVrMr3HkEcPudt1AEaYgRPlX3MwLviSVyTVQJ0k5Jl4g/LI38LrxbaqS3GNn
 +/UbSfRDCsCOF0JwzcSZ2Ke8DcwcVkyjWOs5zkw5bHGL9gSDsMKGksgc8OYP29VWJ0Mz
 wE2V7E4f5JO8oWeWIR0em3WXon5uJQ/O23zZMM3lG6mofKAx8G+dKeVbQwI9v2HyYcNO
 4GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692782; x=1784297582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QH6LjrrKr29iWY3l1XIL+b7IzBPcM5LTW+rtFNIK8pw=;
 b=TuAVh90TL189IMyBZwoiwZRlBhFCtyP16ov9RVTrTfnVc0APzoA+gmczru6VWM5FnL
 pbFV4xuLhfcTTohqeof0CFzPWLCDM5I0d97F9O2u96zz44nWIweBkLXbh/fESbZNgDSo
 x/q8OVA2I+56u5idgLucseGrub2Quxylen8mb9L+NamufXr8jHD+neaGpE37cWnKYHBM
 PS2VN4rXRyNkaCcgLZ1m8n8uMo005qt6QJcnSFX3nrC2O5YXIft0o+c8pS0nQUf84L1W
 MHeqj9FgPULBCUIiwYWtDsvrsQcVXAUq798NNVas1XMgSN0noqfiQt7+d7mLnRj9SF2O
 68ig==
X-Gm-Message-State: AOJu0YwaGBS/uhNmZLc6wIlFzzdRJLLLPm1vT6ocBDnWVShIhcJOb0d+
 wHBam7Z6lUWL5bFbAv5SXjJtUYDsWtzamRDsGHdIitGOQ+sKt33XAvI+Yxik7UdedTYaQ2Z1YqF
 BKiCmUVs=
X-Gm-Gg: AfdE7clck6NhoBtnCzitBIqSog7f91Rh09xYsTY9W4HBcFPXYEEMuq0YsiQh5MJ6QV9
 14X6uoBphB4PxYkugE7Gh2ol+YS2vcfPnKCSJXVSSNgl/SOJ9x/yoIM71gs49rmXUyG2MumvtbE
 nqrvpgs4CRD1PUACjTH5RMW0Hl/MHpqqLxC6pXac4PqLF0lAQeb586+YZ8C9FbQ1KCCf0ngx0px
 phqCgMIfdsa4kFF0TdF4gTqR3P6PjmqtdyOsf56nVZ1ubDnjGLNPid0Huglv6UpECVIg6NXQCt8
 6b8BGDteHMyRYPyFh6ukqy6THmAUjN9vE1aHYCmgQdYRnQwe8lh9MPHOYJBtf9HLpsn7FRtOA9P
 xrx2r05xFAeAlLS8lsKu1qDrxiILGP7DMNXxepJBmUS0e/sMZ1PoTrHyUCeFbky4EjAtpBCY9Ez
 I8sncyhuAwTVat/NKHPocnrSGiuDRkCmiqfMPihjIWor97m55cG9TuUSLAWb/VHF/HkzN0F0rNl
 LNf8jQDzb4KaiXGtmxSDNv0Km8IU3crrHcn6ucu82vH1YvQO1/xI3ybJSqmhAFh0SU1EGU=
X-Received: by 2002:a05:600d:8496:10b0:493:e034:a3b5 with SMTP id
 5b1f17b1804b1-493e68c6eaamr90614355e9.24.1783692782503; 
 Fri, 10 Jul 2026 07:13:02 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:13:02 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 10 Jul 2026 16:12:59 +0200
Subject: [PATCH 8/9] clk: mediatek: mt7988: convert to mtk_gate_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-8-a4b5c491d9bf@baylibre.com>
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

MT7988 currently declares a separate U_BOOT_DRIVER, probe() function
and compatible table for each clock gate controller, despite all of
them sharing the same implementation.

Convert MT7988 to use the generic mtk_gate_clk_data infrastructure.
sgmiisys_0 and sgmiisys_1 are merged into a single generic driver,
while ethdma and ethwarp keep their own U_BOOT_DRIVERs since they
bind different reset controllers, but share the generic probe()
function.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 74 +++++++++++++++------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index ebad78a9151..90bed15b4c7 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -933,10 +933,15 @@ static const struct mtk_gate ethdma_mtk_gate[] = {
 	GATE_ETHDMA(CLK_ETHDMA_FE_EN, "ethdma_fe_en", CLK_TOP_NETSYS_2X_SEL, 6),
 };
 
-static int mt7988_ethdma_probe(struct udevice *dev)
+static int mt7988_clk_gate_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree, ethdma_mtk_gate,
-					ARRAY_SIZE(ethdma_mtk_gate), 0);
+	struct mtk_gate_clk_data *data;
+
+	data = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
 }
 
 static int mt7988_ethdma_bind(struct udevice *dev)
@@ -952,9 +957,12 @@ static int mt7988_ethdma_bind(struct udevice *dev)
 	return ret;
 }
 
+MTK_GATE_CLK_DATA(ethdma_mtk_gate);
+
 static const struct udevice_id mt7988_ethdma_compat[] = {
 	{
 		.compatible = "mediatek,mt7988-ethdma",
+		.data = (ulong)&ethdma_mtk_gate_data,
 	},
 	{}
 };
@@ -963,7 +971,7 @@ U_BOOT_DRIVER(mt7988_clk_ethdma) = {
 	.name = "mt7988-clock-ethdma",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethdma_compat,
-	.probe = mt7988_ethdma_probe,
+	.probe = mt7988_clk_gate_probe,
 	.bind = mt7988_ethdma_bind,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
@@ -991,29 +999,6 @@ static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
 	GATE_SGMII0(CLK_SGM0_RX_EN, "sgm0_rx_en", CLK_TOP_XTAL, 3),
 };
 
-static int mt7988_sgmiisys_0_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					sgmiisys_0_mtk_gate,
-					ARRAY_SIZE(sgmiisys_0_mtk_gate), 0);
-}
-
-static const struct udevice_id mt7988_sgmiisys_0_compat[] = {
-	{
-		.compatible = "mediatek,mt7988-sgmiisys_0",
-	},
-	{}
-};
-
-U_BOOT_DRIVER(mt7988_clk_sgmiisys_0) = {
-	.name = "mt7988-clock-sgmiisys_0",
-	.id = UCLASS_CLK,
-	.of_match = mt7988_sgmiisys_0_compat,
-	.probe = mt7988_sgmiisys_0_probe,
-	.priv_auto = sizeof(struct mtk_cg_priv),
-	.ops = &mtk_clk_gate_ops,
-};
-
 /* SGMIISYS_1 */
 
 static const struct mtk_gate_regs sgmii1_cg_regs = {
@@ -1036,25 +1021,26 @@ static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
 	GATE_SGMII1(CLK_SGM1_RX_EN, "sgm1_rx_en", CLK_TOP_XTAL, 3),
 };
 
-static int mt7988_sgmiisys_1_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					sgmiisys_1_mtk_gate,
-					ARRAY_SIZE(sgmiisys_1_mtk_gate), 0);
-}
+MTK_GATE_CLK_DATA(sgmiisys_0_mtk_gate);
+MTK_GATE_CLK_DATA(sgmiisys_1_mtk_gate);
 
-static const struct udevice_id mt7988_sgmiisys_1_compat[] = {
+static const struct udevice_id mt7988_clk_gate_compat[] = {
+	{
+		.compatible = "mediatek,mt7988-sgmiisys_0",
+		.data = (ulong)&sgmiisys_0_mtk_gate_data,
+	},
 	{
 		.compatible = "mediatek,mt7988-sgmiisys_1",
+		.data = (ulong)&sgmiisys_1_mtk_gate_data,
 	},
 	{}
 };
 
-U_BOOT_DRIVER(mt7988_clk_sgmiisys_1) = {
-	.name = "mt7988-clock-sgmiisys_1",
+U_BOOT_DRIVER(mt7988_clk_gate) = {
+	.name = "mt7988-gate-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt7988_sgmiisys_1_compat,
-	.probe = mt7988_sgmiisys_1_probe,
+	.of_match = mt7988_clk_gate_compat,
+	.probe = mt7988_clk_gate_probe,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,
 };
@@ -1083,13 +1069,6 @@ static const struct mtk_gate ethwarp_mtk_gate[] = {
 		     CLK_TOP_NETSYS_MCU_SEL, 15),
 };
 
-static int mt7988_ethwarp_probe(struct udevice *dev)
-{
-	return mtk_common_clk_gate_init(dev, &mt7988_clk_tree,
-					ethwarp_mtk_gate,
-					ARRAY_SIZE(ethwarp_mtk_gate), 0);
-}
-
 static int mt7988_ethwarp_bind(struct udevice *dev)
 {
 	int ret = 0;
@@ -1103,9 +1082,12 @@ static int mt7988_ethwarp_bind(struct udevice *dev)
 	return ret;
 }
 
+MTK_GATE_CLK_DATA(ethwarp_mtk_gate);
+
 static const struct udevice_id mt7988_ethwarp_compat[] = {
 	{
 		.compatible = "mediatek,mt7988-ethwarp",
+		.data = (ulong)&ethwarp_mtk_gate_data,
 	},
 	{}
 };
@@ -1114,7 +1096,7 @@ U_BOOT_DRIVER(mt7988_clk_ethwarp) = {
 	.name = "mt7988-clock-ethwarp",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethwarp_compat,
-	.probe = mt7988_ethwarp_probe,
+	.probe = mt7988_clk_gate_probe,
 	.bind = mt7988_ethwarp_bind,
 	.priv_auto = sizeof(struct mtk_cg_priv),
 	.ops = &mtk_clk_gate_ops,

-- 
2.54.0

