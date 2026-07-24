Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531CC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 276CC811A4;
	Fri, 24 Jul 2026 08:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pumERJ2P-SSb; Fri, 24 Jul 2026 08:36:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD441811A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882187;
	bh=8mmn8xP/q6IZ6xIuvOf/HJb7n1HzPzkGOfiC7U5I8Ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVQR34aQTmcQXDGnDiqFp/m0ztY97obbF4yzjDgoRgGlFShJD/9jAzQkLndIqJn3j
	 4rxwVCcJTrP/YP4UMcl7IT6k1g6o9IO9IWxzmHbkVoLVVeAy04HZXnP9cegPXxM81P
	 jwykQfIPAzLNl/Ea7hXhSIX+BoXIttXnvdO1ozRs+Z5utfyxhzxFLVhHoBqyHuRUcg
	 4rpPgpxVLRI/A4qlcqFsmEmppSqek7wa3Z8bcGAel3LKjYe8TedjVUqxdvvwVGGMAf
	 y/1nUmLmIWZY06TJD1W9HKv0VMKP7gjKRdKnL7mhmmodIw0UXT/x73dVGBkBb+N8sX
	 qQdN4bgeJRz+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD441811A0;
	Fri, 24 Jul 2026 08:36:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70E8778A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61A2C404A1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdzth6qO6ziF for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:36:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C258B40064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C258B40064
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C258B40064
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:22 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so144723f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882181; x=1785486981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8mmn8xP/q6IZ6xIuvOf/HJb7n1HzPzkGOfiC7U5I8Ic=;
 b=ZSE2B9+VlC8nzfzJoVUgv9xEFVRtfTm9arodinGJMto8TmC2nFKinRmk7TK0WqAQrt
 9OiInfRxlOvVuWTRoljwioSlkNNNyHtQAf8rJELuAk2XOV4U6cS4WlnTnflxqpCq4C3Z
 IiqxuLPoR3c2no5UTYTBHLaepiAg4DEVzK5B3b2DKnyIaCzBw1FVGJJbed6pL3XMC783
 ObmREuKuVyuASqPIBznxAnKo/v5oEMNKqnKQe8ouGTNyJIWxq42ztLNfCT6SESDS0AO7
 eIfLmM14rYkJYjmEhk54bqJTohla4uFXYsRxmhnr8a3VAUgHcmC8F/HRMKYnfTswA0gl
 sFaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8qGJ1jVcC1wo9k1CMcIWdRBx7AQsMKEvwGAk6iu+DphqFaZv4kO7TSUThYzQAp6A0jMveczw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzNGXRuAzsTzvKEhqyGsOnOdDdg0vWLeTDPDV1ekFl/k5vKXOfE
 JqoPkTwHBwh6WSj6F7zygvo4wjOP9z4trUFDUjLTFreYu1eh7HF/ZRITsrN2jm6PN2o=
X-Gm-Gg: AR+sD10uYF2HuYXIJGhlW/SBu3yb9+apJr90acqx74kEQDTNzvJqzS5oR1PpLK5Ufyq
 JyyXSxTG6u61AWzwBtAl4HcMXOMNZqotBC9jWly0dY2Cr0dy29Qbhzu4eqKCtwEKAjOR/PdiwV1
 sSdZcf5R+ZTy+76b7x7RIoyjG9Lg80H4VNwNbusfXv1eAhGSZqYXqBEhLdOsAydWVGkqCNCtMeA
 069lnBL+d5PwJjNiiaBjIZTRVN8ke5cHt7TzSoP0SQHti00VeFTu7FSvK+SM+TLQHZnTxGRR4pO
 V6C6kWooKvlfUoBmn2VVzEg+dALPkV3PgP4ZP4tXWhS2FxxMsxHh/kMp4GclprOt8g4t2gr6bub
 5fYp3SA0kzGxwnhApGyTPRvZdLItaT+rSfYj7x1E7yFg31uYXscVidjHzjAIEfyhGYW9Lliy3yl
 UZzDAqKoSTnS6fpmhm7lkvdUubJeePhukyTduHHfvtaWyyLuyrxZx20g/H3C32yGMVt2WSvjRZw
 hEXbFKdSMjfKqr8VlbYjuMJ5A==
X-Received: by 2002:a05:600c:56ca:b0:495:5de0:d87 with SMTP id
 5b1f17b1804b1-49573cf0e1fmr52981005e9.36.1784882180522; 
 Fri, 24 Jul 2026 01:36:20 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm15324465e9.0.2026.07.24.01.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:36:20 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 24 Jul 2026 10:36:06 +0200
Subject: [PATCH v2 2/2] clk: mediatek: drop probe-after-bind provider setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ccaione-upstream-fix-clk-probe-v2-2-ebcef2e94e9d@baylibre.com>
References: <20260724-ccaione-upstream-fix-clk-probe-v2-0-ebcef2e94e9d@baylibre.com>
In-Reply-To: <20260724-ccaione-upstream-fix-clk-probe-v2-0-ebcef2e94e9d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784882181; x=1785486981;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mmn8xP/q6IZ6xIuvOf/HJb7n1HzPzkGOfiC7U5I8Ic=;
 b=Z6P5qVQxF3AjocqhX3b3UMgC6hnqt1zrs4y7n+488afmCGC9oSEkzo9Qd+K3hoaefr
 DYCwZChkM8ZXKnDHb+GL5KjD9dDx1vaHdFghQx2vjPlaTM25tyv3yE8uVLK+LoRp9y/h
 f9/+kS/rSD1q5T3M2hgBDlhJ+2cX3oBlupliAko3S3+xGty73Ny66eO1CML/kl4QpK1h
 jNRpQ5ib+DDNkxn/VK6f9ZTBJilQiSKnVEasm79UhNxe8vPSchUj3/KkVppq1qtIAPu1
 qqedAAopHYOujA//xG1x780ODhKjEKSvCT9462YBcyLQowiwZWlKWvwUId5zJ+Jc9JlA
 afog==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z6P5qVQx
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: David Lechner <dlechner@baylibre.com>

Parent lookup now probes the exact missing provider on demand, making the
eager probing of every parent provider after bind redundant. The common
bind callback also occupies a driver callback that a provider may need
for unrelated setup.

Remove the common bind callback and its use from all MediaTek parent
providers. Providers are now registered only when first needed or when
normal driver-model probing reaches them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c |  2 --
 drivers/clk/mediatek/clk-mt7623.c |  2 --
 drivers/clk/mediatek/clk-mt7629.c |  2 --
 drivers/clk/mediatek/clk-mt7981.c |  3 ---
 drivers/clk/mediatek/clk-mt7986.c |  3 ---
 drivers/clk/mediatek/clk-mt7987.c |  3 ---
 drivers/clk/mediatek/clk-mt7988.c |  3 ---
 drivers/clk/mediatek/clk-mt8183.c |  2 --
 drivers/clk/mediatek/clk-mt8188.c |  2 --
 drivers/clk/mediatek/clk-mt8189.c |  3 ---
 drivers/clk/mediatek/clk-mt8195.c |  2 --
 drivers/clk/mediatek/clk-mt8365.c |  2 --
 drivers/clk/mediatek/clk-mt8512.c |  2 --
 drivers/clk/mediatek/clk-mt8516.c |  2 --
 drivers/clk/mediatek/clk-mt8518.c |  2 --
 drivers/clk/mediatek/clk-mtk.c    | 11 -----------
 drivers/clk/mediatek/clk-mtk.h    |  8 +-------
 17 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 21587b2a4be..416210a5845 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -797,7 +797,6 @@ U_BOOT_DRIVER(mt7622_clk_apmixedsys) = {
 	.name = "mt7622-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7622_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -808,7 +807,6 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.name = "mt7622-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 7a91ef9761c..930ce121342 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1170,7 +1170,6 @@ U_BOOT_DRIVER(mt7623_clk_apmixedsys) = {
 	.name = "mt7623-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7623_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1181,7 +1180,6 @@ U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.name = "mt7623-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 433036980c0..e3232a226a2 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -746,7 +746,6 @@ U_BOOT_DRIVER(mt7629_clk_apmixedsys) = {
 	.name = "mt7629-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7629_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -757,7 +756,6 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.name = "mt7629-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index b3bc95d01cb..dcddb6b4fef 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -690,7 +690,6 @@ U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.name = "mt7981-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -701,7 +700,6 @@ U_BOOT_DRIVER(mt7981_clk_topckgen) = {
 	.name = "mt7981-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7981_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -720,7 +718,6 @@ U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.name = "mt7981-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7981_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index c29cddf954a..55eff05555c 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -598,7 +598,6 @@ U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.name = "mt7986-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -609,7 +608,6 @@ U_BOOT_DRIVER(mt7986_clk_topckgen) = {
 	.name = "mt7986-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7986_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -628,7 +626,6 @@ U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.name = "mt7986-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 43d880f47d8..61e1bb66799 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -79,7 +79,6 @@ U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.name = "mt7987-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -487,7 +486,6 @@ U_BOOT_DRIVER(mt7987_clk_topckgen) = {
 	.name = "mt7987-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7987_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -810,7 +808,6 @@ U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.name = "mt7987-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7987_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 02ccf111192..a704a86465d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -874,7 +874,6 @@ U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.name = "mt7988-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_fixed_pll_ops,
@@ -885,7 +884,6 @@ U_BOOT_DRIVER(mt7988_clk_topckgen) = {
 	.name = "mt7988-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mt7988_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -904,7 +902,6 @@ U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.name = "mt7988-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 94f2fe38ed9..e0a63490375 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -822,7 +822,6 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.name = "mt8183-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -833,7 +832,6 @@ U_BOOT_DRIVER(mt8183_clk_topckgen) = {
 	.name = "mt8183-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8183_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 5e395eeec5e..eb98f7fdf6a 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1767,7 +1767,6 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.name = "mt8188-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1778,7 +1777,6 @@ U_BOOT_DRIVER(mt8188_clk_topckgen) = {
 	.name = "mt8188-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8188_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 5303bf916ec..10859bce02f 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2026,7 +2026,6 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_apmixed,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -2037,7 +2036,6 @@ U_BOOT_DRIVER(mt8189_clk_topckgen) = {
 	.name = "mt8189-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -2048,7 +2046,6 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.name = "mt8189-vlpckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8189_vlpckgen,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 080eded38d0..48298df8fd9 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1631,7 +1631,6 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.name = "mt8195-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1642,7 +1641,6 @@ U_BOOT_DRIVER(mt8195_clk_topckgen) = {
 	.name = "mt8195-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 70d29e6970b..7dffcaa52f9 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -789,7 +789,6 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.name = "mt8365-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -800,7 +799,6 @@ U_BOOT_DRIVER(mt8365_clk_topckgen) = {
 	.name = "mt8365-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8365_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index dc567402544..1c4d16d9301 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -861,7 +861,6 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.name = "mt8512-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -872,7 +871,6 @@ U_BOOT_DRIVER(mt8512_clk_topckgen) = {
 	.name = "mt8512-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8512_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 2043009d9fe..22df1422743 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -802,7 +802,6 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.name = "mt8516-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -813,7 +812,6 @@ U_BOOT_DRIVER(mt8516_clk_topckgen) = {
 	.name = "mt8516-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8516_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 81d0b701803..f7200f679d3 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1558,7 +1558,6 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.name = "mt8518-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1569,7 +1568,6 @@ U_BOOT_DRIVER(mt8518_clk_topckgen) = {
 	.name = "mt8518-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
-	.bind = mtk_common_clk_parent_bind,
 	.probe = mtk_common_clk_init,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9d2f2414b27..0d083d6b950 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1117,17 +1117,6 @@ const struct clk_ops mtk_clk_infrasys_ops = {
 #endif
 };
 
-int mtk_common_clk_parent_bind(struct udevice *dev)
-{
-	/*
-	 * Clock trees that provide parent clocks need to be probed right away
-	 * so that any clock depending on them will work correctly.
-	 */
-	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
-
-	return 0;
-}
-
 int mtk_common_clk_init(struct udevice *dev)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index d08ff24075d..aad86c0e2f2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -270,12 +270,7 @@ struct mtk_clk_tree {
 	const int num_muxes;
 	const int num_gates;
 	u32 flags;
-	/*
-	 * Set this if this tree provides a specific type for parent lookup.
-	 * Devices that set this should also include mtk_common_clk_parent_bind()
-	 * in the driver bind function to ensure that it will be registered as
-	 * a provider.
-	 */
+	/* Set this if this tree provides a specific type for parent lookup. */
 	enum mtk_clk_tree_type type;
 };
 
@@ -289,7 +284,6 @@ extern const struct clk_ops mtk_clk_fixed_pll_ops;
 extern const struct clk_ops mtk_clk_topckgen_ops;
 extern const struct clk_ops mtk_clk_infrasys_ops;
 
-int mtk_common_clk_parent_bind(struct udevice *dev);
 int mtk_common_clk_init(struct udevice *dev);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.55.0

