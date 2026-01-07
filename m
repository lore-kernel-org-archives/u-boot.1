Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D6ACFD65B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D6583AB0;
	Wed,  7 Jan 2026 17:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a3m0xrRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C737B83A2D; Wed,  7 Jan 2026 16:51:26 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD6B8398C
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e3dac349easo1839218fac.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801083; x=1768405883;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E44twkOPMoRlM3qc1CBf9ibbzRClYnuc5OoGq0wTWCY=;
 b=a3m0xrRIRMZGuNybR9p4w1jTaZ5H8LsrJXWyjO+5TJWcD/i3F5HnoUK4PZi7rSjDtw
 6xh/rMK5Dsmid1g7FdnVfC8J0T4QMDVLdNc+7fFxQzyTrJK51YIXftosK6ehvbYdZ163
 SmI2l+SP5LnsQeCpypvoLVWf5RAPBxQgR2OB3NvndbsCNXgojUFUFYpu0dSgvsdm7t4I
 IeDp2MWWkzbcKg7dnJP+KKQzdW2zn9rJeWOBy+pLHX5QfQ98Y04lE83HiCiu0Kh629Rf
 C1wxwYh4QiqrXXdaAYBKbZNL04i2BOEq7Ov7k/512pjQ/fDUs+9MKCkTYpY/Sz2lu6h9
 qG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801083; x=1768405883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E44twkOPMoRlM3qc1CBf9ibbzRClYnuc5OoGq0wTWCY=;
 b=UA6aWl/xEt7cKXwjUCb1gYgDnDXA8us8naOWlCPrG+PDuBCnR4poFm1o9hoqLjI0tY
 FzmbpQC8zjeg0e3HF0J19BPEsfEpF0+Yu+qlV1JeFwwut6KCGlwc3Bre42Efe5SiuQZY
 UPW2u2i1H/Zz0q+lz9Uva8CrBNV0cnQ37AB8DVMZ8IA3ohc2lxEmewl/CSY+m80Uhn0H
 YjzdpXJBXvkgEP/sOof+QlohUjqdJugTn2j+Pj61+I4rGVdkGSG3wnJgspNmGRSrSJyi
 TR/wSTH7Yn4Q4rJhasIC6KP9wU6TxvHa6N0CWTt36PSXd1JDTNwwLHpL1eki8yDEvQzw
 2kaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEp1y/AzdKSxA0xzFDJPZ85Gsa8JGZik7BCzkY7d4ynuuaWmkQlXaH8tU+j/jXOvzjeHE+cKQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2hGXQ379IUH+lmZHEut3n0qiLejtJLCP3OgCG+UZ5jdPQeWF8
 wvo4DjL422VAZKWKkrdGl7zm26z7mdMOtgXhEd7xbzSdOkmJP26QvEsc2TlCxp55TB0=
X-Gm-Gg: AY/fxX41+qPJEVwDDXpjMGanlJVxjCsQfT5Wnrb10lbW39KbcMzQPHebkpwR1Eo3ytK
 eYwJqAowsvSSkbA6TdF4XZ1z4MTITQ2magFRd/HR6wsiUGLeO1xqxO9qzbL64zVK7I02mVKIkbq
 QmDOpYSFsLrm99JjxAy/j4gqK5AqvGdsEBE35+mW5SRgR91AIhfRE5j/3X/AmHpSiJqH9uhc1Ff
 apJQWVcE+m1ACEQLxJ4+GBP5ewe/QHpqhbwuVWJy96qNnkLfCLgLuRUB2/0kc9M3Rsq9JPQQC4h
 of+f/hpD4SOqw5SX/mV+WyKOp3zRWjKMd2YS4riVdPE6Tp/P4vV+NEOQQ/WY1TbYfe1Vc35nmtk
 YauSfIGCnadGasTp80NEtk8Hiffr8GstYcsOuXOiYLZookMh/S0VZ+r+IbJivs+DJuDWqUJodDV
 zd3D6f0qwGFQSOEU8=
X-Google-Smtp-Source: AGHT+IG9R9zCi08/nKsTaICjUvxXNlaUhAFLn/tht5vJggJiZqwhG/szFWZmrjz3T0IC7DUrAmEsuw==
X-Received: by 2002:a05:6870:85d0:b0:3f5:b9c7:6d00 with SMTP id
 586e51a60fabf-3ffc0c7479bmr1163381fac.57.1767801082703; 
 Wed, 07 Jan 2026 07:51:22 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:12 -0600
Subject: [PATCH v2 2/8] clk: mediatek: add array size fields to cg gates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-2-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16483;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=g6E5YOSg8yhLE5xKLTXRRzTGkORtYSoA5m0qUrt+y+U=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDGONA/qb0GAGfBUMgdzNOHYgCMk0XM9WsGw
 YT4p9s077GJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6AxhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABj0H/0bVKdqhWHvNcYrYhpcYlqmRjo4fviQNW5kEqEv
 vNfTWBTFmM9IpxjOMA43tj4+IbtbQQOUzQ5z2g4mNhQq99m7HiyfP/WccR6Y3CnBAPKx9IRPVzL
 Y58Rgk1laYKJrs7wEFm5vd3ELsOua3itZpcCLfq2jT9vp+4dVnNEK70BuZqSoVGPY90A76i0ZSD
 VJOmXcYaUJZ+qKJv1WVq9UEevwyEDPSTQg/9VBZGIdHa3T65KjT65RBclu3vw5o/C2HLKYAmhXU
 VQDQdj16D5c26p8cyMjjvboIieKJhFkHNiTJS4f20RJCYSiGvM+QTl3r24HZN0UAlVXVRuQ29+X
 GcMk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

Add num_gates field to struct mtk_cg_priv and populate it for all
existing drivers.

Currently, there is no bounds checking when accessing the gates array.
Adding this field will allow for bounds checking in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 12 ++++++++----
 drivers/clk/mediatek/clk-mt7623.c | 12 ++++++------
 drivers/clk/mediatek/clk-mt7629.c | 15 ++++++++++-----
 drivers/clk/mediatek/clk-mt7981.c |  6 +++---
 drivers/clk/mediatek/clk-mt7986.c |  4 ++--
 drivers/clk/mediatek/clk-mt7987.c |  4 ++--
 drivers/clk/mediatek/clk-mt7988.c | 12 ++++++++----
 drivers/clk/mediatek/clk-mt8183.c |  3 ++-
 drivers/clk/mediatek/clk-mt8188.c | 23 +++++++++++++++++------
 drivers/clk/mediatek/clk-mt8365.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8512.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8516.c |  3 ++-
 drivers/clk/mediatek/clk-mt8518.c |  3 ++-
 drivers/clk/mediatek/clk-mtk.c    |  3 ++-
 drivers/clk/mediatek/clk-mtk.h    |  3 ++-
 15 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index ccad3820c1b..16c6f024e72 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -692,7 +692,8 @@ static int mt7622_pericfg_probe(struct udevice *dev)
 
 static int mt7622_pciesys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, pcie_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, pcie_cgs,
+					ARRAY_SIZE(pcie_cgs));
 }
 
 static int mt7622_pciesys_bind(struct udevice *dev)
@@ -710,7 +711,8 @@ static int mt7622_pciesys_bind(struct udevice *dev)
 
 static int mt7622_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, eth_cgs,
+					ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7622_ethsys_bind(struct udevice *dev)
@@ -728,12 +730,14 @@ static int mt7622_ethsys_bind(struct udevice *dev)
 
 static int mt7622_sgmiisys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, sgmii_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, sgmii_cgs,
+					ARRAY_SIZE(sgmii_cgs));
 }
 
 static int mt7622_ssusbsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, ssusb_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, ssusb_cgs,
+					ARRAY_SIZE(ssusb_cgs));
 }
 
 static const struct udevice_id mt7622_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index cfc711ad216..5a60a86233e 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1057,8 +1057,8 @@ static const struct mtk_clk_tree mt7623_clk_gate_tree = {
 
 static int mt7623_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
-					infra_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, infra_cgs,
+					ARRAY_SIZE(infra_cgs));
 }
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
@@ -1079,14 +1079,14 @@ static int mt7623_pericfg_probe(struct udevice *dev)
 
 static int mt7623_hifsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
-					hif_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, hif_cgs,
+					ARRAY_SIZE(hif_cgs));
 }
 
 static int mt7623_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree,
-					eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_clk_gate_tree, eth_cgs,
+					ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index e0eff01561c..e4132f6195f 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -634,17 +634,20 @@ static int mt7629_topckgen_probe(struct udevice *dev)
 
 static int mt7629_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, infra_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, infra_cgs,
+					ARRAY_SIZE(infra_cgs));
 }
 
 static int mt7629_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_peri_clk_tree, peri_cgs,
+					ARRAY_SIZE(peri_cgs));
 }
 
 static int mt7629_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, eth_cgs,
+					ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7629_ethsys_bind(struct udevice *dev)
@@ -662,12 +665,14 @@ static int mt7629_ethsys_bind(struct udevice *dev)
 
 static int mt7629_sgmiisys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, sgmii_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, sgmii_cgs,
+					ARRAY_SIZE(sgmii_cgs));
 }
 
 static int mt7629_ssusbsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, ssusb_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7629_clk_tree, ssusb_cgs,
+					ARRAY_SIZE(ssusb_cgs));
 }
 
 static const struct udevice_id mt7629_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index f854f079c67..c8090688df0 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -631,7 +631,7 @@ static const struct mtk_gate sgmii0_cgs[] = {
 static int mt7981_sgmii0sys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					sgmii0_cgs);
+					sgmii0_cgs, ARRAY_SIZE(sgmii0_cgs));
 }
 
 static const struct udevice_id mt7981_sgmii0sys_compat[] = {
@@ -658,7 +658,7 @@ static const struct mtk_gate sgmii1_cgs[] = {
 static int mt7981_sgmii1sys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					sgmii1_cgs);
+					sgmii1_cgs, ARRAY_SIZE(sgmii1_cgs));
 }
 
 static const struct udevice_id mt7981_sgmii1sys_compat[] = {
@@ -699,7 +699,7 @@ static const struct mtk_gate eth_cgs[] = {
 static int mt7981_ethsys_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
-					eth_cgs);
+					eth_cgs, ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7981_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 257f89b7daa..735e824c874 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -636,8 +636,8 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7986_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7986_topckgen_clk_tree,
-					eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7986_topckgen_clk_tree, eth_cgs,
+					ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7986_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index b559152c045..99ff57c5dc5 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -818,8 +818,8 @@ static const struct mtk_gate eth_cgs[] = {
 
 static int mt7987_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7987_topckgen_clk_tree,
-					eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7987_topckgen_clk_tree, eth_cgs,
+					ARRAY_SIZE(eth_cgs));
 }
 
 static int mt7987_ethsys_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 56f3e5ebdff..da1d2e89d61 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -892,7 +892,8 @@ static const struct mtk_gate ethdma_mtk_gate[] = {
 static int mt7988_ethdma_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					ethdma_mtk_gate);
+					ethdma_mtk_gate,
+					ARRAY_SIZE(ethdma_mtk_gate));
 }
 
 static int mt7988_ethdma_bind(struct udevice *dev)
@@ -950,7 +951,8 @@ static const struct mtk_gate sgmiisys_0_mtk_gate[] = {
 static int mt7988_sgmiisys_0_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					sgmiisys_0_mtk_gate);
+					sgmiisys_0_mtk_gate,
+					ARRAY_SIZE(sgmiisys_0_mtk_gate));
 }
 
 static const struct udevice_id mt7988_sgmiisys_0_compat[] = {
@@ -994,7 +996,8 @@ static const struct mtk_gate sgmiisys_1_mtk_gate[] = {
 static int mt7988_sgmiisys_1_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					sgmiisys_1_mtk_gate);
+					sgmiisys_1_mtk_gate,
+					ARRAY_SIZE(sgmiisys_1_mtk_gate));
 }
 
 static const struct udevice_id mt7988_sgmiisys_1_compat[] = {
@@ -1040,7 +1043,8 @@ static const struct mtk_gate ethwarp_mtk_gate[] = {
 static int mt7988_ethwarp_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt7988_topckgen_clk_tree,
-					ethwarp_mtk_gate);
+					ethwarp_mtk_gate,
+					ARRAY_SIZE(ethwarp_mtk_gate));
 }
 
 static int mt7988_ethwarp_bind(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 7a1953ef6fd..5b41cf4b88c 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -777,7 +777,8 @@ static int mt8183_topckgen_probe(struct udevice *dev)
 
 static int mt8183_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8183_clk_tree, infra_clks);
+	return mtk_common_clk_gate_init(dev, &mt8183_clk_tree, infra_clks,
+					ARRAY_SIZE(infra_clks));
 }
 
 static const struct udevice_id mt8183_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 186638fcb66..f7c04047f4d 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1694,33 +1694,44 @@ static int mt8188_topckgen_probe(struct udevice *dev)
 
 static int mt8188_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tree, topckgen_cg_clks);
+	return mtk_common_clk_gate_init(dev, &mt8188_topckgen_cg_clk_tree,
+					topckgen_cg_clks,
+					ARRAY_SIZE(topckgen_cg_clks));
 }
 
 static int mt8188_infracfg_ao_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree, infracfg_ao_clks);
+	return mtk_common_clk_gate_init(dev, &mt8188_infracfg_ao_clk_tree,
+					infracfg_ao_clks,
+					ARRAY_SIZE(infracfg_ao_clks));
 }
 
 static int mt8188_pericfg_ao_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tree, pericfg_ao_clks);
+	return mtk_common_clk_gate_init(dev, &mt8188_pericfg_ao_clk_tree,
+					pericfg_ao_clks,
+					ARRAY_SIZE(pericfg_ao_clks));
 }
 
 static int mt8188_imp_iic_wrap_c_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_c_clk_tree, imp_iic_wrap_c_clks);
+	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_c_clk_tree,
+					imp_iic_wrap_c_clks,
+					ARRAY_SIZE(imp_iic_wrap_c_clks));
 }
 
 static int mt8188_imp_iic_wrap_w_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_w_clk_tree, imp_iic_wrap_w_clks);
+	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_w_clk_tree,
+					imp_iic_wrap_w_clks,
+					ARRAY_SIZE(imp_iic_wrap_w_clks));
 }
 
 static int mt8188_imp_iic_wrap_en_probe(struct udevice *dev)
 {
 	return mtk_common_clk_gate_init(dev, &mt8188_imp_iic_wrap_en_clk_tree,
-					imp_iic_wrap_en_clks);
+					imp_iic_wrap_en_clks,
+					ARRAY_SIZE(imp_iic_wrap_en_clks));
 }
 
 static const struct udevice_id mt8188_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 7897044e1ad..c88545fc7cf 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -705,12 +705,14 @@ static int mt8365_topckgen_probe(struct udevice *dev)
 
 static int mt8365_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, top_clk_gates);
+	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, top_clk_gates,
+					ARRAY_SIZE(top_clk_gates));
 }
 
 static int mt8365_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, ifr_clks);
+	return mtk_common_clk_gate_init(dev, &mt8365_clk_tree, ifr_clks,
+					ARRAY_SIZE(ifr_clks));
 }
 
 static const struct udevice_id mt8365_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 6d98403bc45..d4f6604c160 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -808,12 +808,14 @@ static int mt8512_topckgen_probe(struct udevice *dev)
 
 static int mt8512_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, top_clks);
+	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, top_clks,
+					ARRAY_SIZE(top_clks));
 }
 
 static int mt8512_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, infra_clks);
+	return mtk_common_clk_gate_init(dev, &mt8512_clk_tree, infra_clks,
+					ARRAY_SIZE(infra_clks));
 }
 
 static const struct udevice_id mt8512_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index c21b9894ad6..d5f922886a3 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -757,7 +757,8 @@ static int mt8516_topckgen_probe(struct udevice *dev)
 
 static int mt8516_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8516_clk_tree, top_clks);
+	return mtk_common_clk_gate_init(dev, &mt8516_clk_tree, top_clks,
+					ARRAY_SIZE(top_clks));
 }
 
 static const struct udevice_id mt8516_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 48ef209ebbd..92730f3f06c 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1513,7 +1513,8 @@ static int mt8518_topckgen_probe(struct udevice *dev)
 
 static int mt8518_topckgen_cg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt8518_clk_tree, top_clks);
+	return mtk_common_clk_gate_init(dev, &mt8518_clk_tree, top_clks,
+					ARRAY_SIZE(top_clks));
 }
 
 static const struct udevice_id mt8518_apmixed_compat[] = {
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index f91777e968a..ffaecbfd306 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -824,7 +824,7 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates)
+			     const struct mtk_gate *gates, int num_gates)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(dev);
 	struct udevice *parent;
@@ -845,6 +845,7 @@ int mtk_common_clk_gate_init(struct udevice *dev,
 	priv->parent = parent;
 	priv->tree = tree;
 	priv->gates = gates;
+	priv->num_gates = num_gates;
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index a4a3307e576..7bd432cb93d 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -279,6 +279,7 @@ struct mtk_cg_priv {
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;
 	const struct mtk_gate *gates;
+	int num_gates;
 };
 
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
@@ -293,6 +294,6 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates);
+			     const struct mtk_gate *gates, int num_gates);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.43.0

