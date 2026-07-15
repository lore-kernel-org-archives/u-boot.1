Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA98C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0B884CA1;
	Wed, 15 Jul 2026 16:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZyZkCNH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0271784C90; Wed, 15 Jul 2026 16:28:59 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14CFC84C23
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso3042724f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784125736; x=1784730536; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3OVj90A26O/mBaUOAh2YgYsyF9IBJ7Eye6ioZAgo5ug=;
 b=ZyZkCNH8G4YUZY2TXxmqP/ESf/xwWQ8Qg8XnWFyRs7OwereVwAwhwnQrDZjuM5z0Sl
 3Fz2juxIpJ1Lemdyflgm8mhsnVxPqD7cenTcIvgmeSQHBvt+GFaoW21THW0ltjlUoczu
 7trmylZaN8XM5QHUb75Id9VtS4R3N5b+VnFce69V5Bn0wNy07DwOaWJ2AucRnvN44r2L
 T9fPldmV4i1yfI7LIRBF1QZ8jySk3rczFwdGfqdRD+38/TlEJhi84Z4/J6cdTyIoF1N8
 uiXloh5c4o6RBE1D/9vTO7NRznP5Te9bJbFRQDHmzEFA0HTdNmOd0O2jsFywsJBLEIVo
 uaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125736; x=1784730536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OVj90A26O/mBaUOAh2YgYsyF9IBJ7Eye6ioZAgo5ug=;
 b=IM+I+Lj4FhsuBvOVvbRvz10YB6iXTyk/Uv1+hQGFRB9M8ZmipbU6jjg/mE6CoDkPF8
 BX2zReDJChuP8l0jnzmMANgrCRRop91k/gayDEvUd22qcFEEDWra+HWWEL8GaBw1uzk1
 kRuzFlrndDS4SSwxMC9Oma/mb/94AFCRv4bTJsSTlBGZGhEId99YlMSmDc8/U85Jhql3
 vy78wr+voxDxfoZNjmJ0f3n3Sbn4I/nO65qPjxPVaqguMZGHIe1S1gTeAP8AspGi8eFg
 V/txuA9awn/zm6uIjdPbOo2z1BnSY5SRQQntZ+kYiZjxI4FPLQjxXNbBgtlSvP9z/qrI
 OZWQ==
X-Gm-Message-State: AOJu0YznA5LdFamW8jET43dRziv71nGLnFAVHRm8gf+/v2aqnXCNIfNB
 VRXdM8nyqkoNBOn4iDzYy5/inoMvx5fcOpHhzVycfW4QtXSBSF8C83CcEGg7jZAuqkY=
X-Gm-Gg: AfdE7clRWx5590G/ba06bLmM8GUPftWkky+NNlf+/rDj8C7Mc1jOtp8OyquCCvdm8Vr
 7/r72t7KuD+nsD80bm67vJqXLRVfqw+2EXpbEBJYWEvBld4q6b9fUU8CO18/eWc4TmBPbHa/8zM
 2QXFZQqUuTd8+mwDn0dG1tezdclUAV/dgSoNAlflH03jT/DxUYCybiYESYXJ+3JWBiJkpAm/B6H
 cZxEvDqZWM7b5jEtGmAdGt79cjJVZEUWTyU+A4/SHpiqb8483wJIfuqupM1MhI58hxoLmFxoOn6
 IQ2gdYzKNVa1Ry7crVVf9fz4tVK9a0AsLAm67dTgVSYA6QWrDBlRw9tFfYHKSZBKG8HCpXhOocW
 C+Vu2cDVS/XvVNaKnTPBXqkHiyQj5P7hwyKE/o+S7fPYQW7OLmkQVfwOAwx5k8YCEl+aSduWwcf
 uoZE/Yk4FZxsg+OIbRGqdJwvONgh45LFQab86vBXFIxcIS7bTgE3VT4TdnqV3UDtuy9zwv6C+iN
 6hS4fpFjiGfEbrrLYRf/DYCuvZSHw7UVtDGIOziETLt8NivDmFOwQvuh2hOZMN3TJOsfg2f
X-Received: by 2002:a05:600c:1393:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-4953c273bb2mr35518525e9.25.1784125736238; 
 Wed, 15 Jul 2026 07:28:56 -0700 (PDT)
Received: from [192.168.1.62]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm151881745e9.5.2026.07.15.07.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:28:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 15 Jul 2026 16:28:54 +0200
Subject: [PATCH v2 26/32] clk: mediatek: mt8365: use driver data to store
 the clock tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-26-23e907516010@baylibre.com>
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

Pass each controller's struct mtk_clk_tree through the driver data and use
the generic probe function for all the MT8365 clock drivers, instead of a
dedicated probe per controller.

The apmixedsys and topckgen controllers keep their own U_BOOT_DRIVER since
they rely on dedicated ops and on the parent bind() callback, but they now
get their tree from the compatible data.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 748549f393f..2603aa46b20 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -761,16 +761,6 @@ static const struct mtk_clk_tree mt8365_infracfg_tree = {
 	.num_gates = ARRAY_SIZE(ifr_clks),
 };
 
-static int mt8365_apmixedsys_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8365_apmixed_tree);
-}
-
-static int mt8365_topckgen_probe(struct udevice *dev)
-{
-	return mtk_common_clk_init(dev, &mt8365_topckgen_tree);
-}
-
 static int mt8365_clk_probe(struct udevice *dev)
 {
 	const struct mtk_clk_tree *tree = (void *)dev_get_driver_data(dev);
@@ -779,12 +769,18 @@ static int mt8365_clk_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
-	{ .compatible = "mediatek,mt8365-apmixedsys", },
+	{
+		.compatible = "mediatek,mt8365-apmixedsys",
+		.data = (ulong)&mt8365_apmixed_tree
+	},
 	{ }
 };
 
 static const struct udevice_id mt8365_topckgen_compat[] = {
-	{ .compatible = "mediatek,mt8365-topckgen", },
+	{
+		.compatible = "mediatek,mt8365-topckgen",
+		.data = (ulong)&mt8365_topckgen_tree
+	},
 	{ }
 };
 
@@ -801,7 +797,7 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8365_apmixedsys_probe,
+	.probe = mt8365_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
@@ -812,7 +808,7 @@ U_BOOT_DRIVER(mt8365_clk_topckgen) = {
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
 	.bind = mtk_common_clk_parent_bind,
-	.probe = mt8365_topckgen_probe,
+	.probe = mt8365_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
 	.flags = DM_FLAG_PRE_RELOC,

-- 
2.54.0

