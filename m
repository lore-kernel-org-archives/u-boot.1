Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84619D6E2B8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E44838A5;
	Thu, 18 Dec 2025 18:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jEqK4DZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903078042F; Thu, 18 Dec 2025 18:18:10 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD6180FA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3f5ec7636e2so340438fac.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078286; x=1766683086;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBOZOjqKaA71NCZ0mRgveIjJfsAKsLTtqlXUrIZWWQE=;
 b=jEqK4DZi3X1cwTOVgGe9dDh2mfWPhY1DYDgxfSGFAGrjar4whONe8m4cly8ogRBnUX
 7F9ffubXuFcmZtlgYawEnIB/AvfmQcXr1TXYgprjzOQn75tCTk4DYlpRdRno1wu4inxP
 v9J9Xgt5HGDO+viLTV24SY9b28nyh6yyKY5uVKhaVkzrJ4J6B7q34NraHKiyy5S6aAl4
 rqf8AX1HICWcZ63qTxXph14vGeh38MnoV4ZseqeRPCO6Ia8oR5hCm3dJRgmMc8Cmc/pN
 Rjmt37PkKzEl/D/9943vtsxG46ppvGnf+QXRNacyqrtyQ4ZS6x8YD4XDL2GpLcbJZMfU
 nLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078286; x=1766683086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PBOZOjqKaA71NCZ0mRgveIjJfsAKsLTtqlXUrIZWWQE=;
 b=wUA8esF3BilOqMj0VBO/pjYkRL1Hm5ILd8gyhRrqk/WtorxQeX19CKltjk3rV+qv3Z
 dP2oMKO1QT3jPzhFWxXe25a1tAaDLJoJexfVJ6462L3lOkgSMLQRoV+sJta3pVOvxeTD
 OJ1OLHQjlwO3fXfVPhF+DVpIHKUxfDBdespT2zYQWlPADN6JxRwoJrZ6XoYAa87SDrhf
 PlXnvPwYzw+txmpuSUoTFN4FRxrg9+rGVABEvT9HKt0Ohqa/GHnCqHDDd2gFAgTLWiED
 oiSBe2FmZjBDd3Jp9FI12UaC8djq220XZioGOxi0O0yANwM+xuaydf35nx3lzyblnIYy
 7H+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBSo0ZSxiASRTcF4civFayKS9dxEI7R//jRhUFLc3ZwS3QPxkEZl2apo01y4xmSwFA9lCu5eE=@lists.denx.de
X-Gm-Message-State: AOJu0YwC9EnKX15y2CqDtJGSwz+QrJhMKCg/Jf/qXLuO4AgbX3UAZiQS
 1py0sfbknWKTZTjXqG6DQHhnFRvA4yAAaVi1zzE68XTL3VWThxuEVGl/OFQiXZgmW48=
X-Gm-Gg: AY/fxX7jBjab96ppp3Nh2UIMGk8dCarRSBlw3gwWrf+edHzURiIWOAvo4SvNe/wj9AI
 eJMBf7M2OFXho5B4nrk6hAHhaVbJxNYJyeX8XEfl+GeNK4rBLGH328uQPJTELVGMSvVfA/M1Azg
 NOf4KttaXdgH3RYJS4Xc5o4v8attHQxjUWz6m/b2qj3+fOY9Iom00s81RG3MGDJq1nqtU7UfTcy
 HqErOwRu7AC9ApsA42S6CaQk3JXP3N/i8fyIwwFvQMQ3rwkSTpXtAcS9w9/zxmO1IYRsPVJsUjc
 x/rNPp18ZWO7VzGcABBf7gOvxVvdwSYsMLOQ5Dchi90r4+wYR027FM4Eba9r/8BR6x/JVXJuvni
 rZS8dSlWAcDq1zUBnVOrp7oCV3U2AF3bkLGLKJe21FwFR9P+e0AuGNUOKEp60IFu5HvX74UUI9Z
 hFZETeFHcykMdzIbY=
X-Google-Smtp-Source: AGHT+IEvyXThncSn6EagOHFVSrxOn3NdNxzEqwL6DvnQdCvLlcVgd0SqTkvafE1SAwDbdirO6fFG7Q==
X-Received: by 2002:a4a:bb92:0:b0:659:7e1b:c247 with SMTP id
 006d021491bc7-65d0e9240cemr73605eaf.3.1766078285689; 
 Thu, 18 Dec 2025 09:18:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:00 -0600
Subject: [PATCH 2/8] clk: mediatek: add array size fields to cg gates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-2-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14331;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=BTtPUtKZDfH5/4oUvHNTNnFidH6az8OyStLJH7nif8Q=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDccOmhstAvNjyo8qGWiDIv7ifZfaQOLAG1j+
 C9p/LufeKSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3HBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ap3gH/izwu8cCONgIPP8vLZ+gXXrp1j1+osVOix9Ubag
 vbmWrt/+SfDSRIS/CuqeXHr5LJXmuVE1/5NYiQyidiN/rvZhla5dr+CqJEAaICX/QCfEOrjK6B1
 ghIcIBfBUJy16H2qjyJHtMqFDIy/2Rdwis+cYJut6fzVxBioAzyeCH/Fldlhl4fwIs0TkqpFO0A
 9Vjjuu2JOLwTvGmLe2sCngmQ+ENDY9eBe+tse3HqHpM5I2sM9kmJfFdpGaJXvPATYnyKAWZ6YVS
 VWKw/rPRQUQIL1BTsoq00IZjil3kTPXFW4B2gimYueSIT2CjWkz5jBW/J+efG9ef0syswtFGbZz
 UeK4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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
 drivers/clk/mediatek/clk-mt8365.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8512.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8516.c |  3 ++-
 drivers/clk/mediatek/clk-mt8518.c |  3 ++-
 drivers/clk/mediatek/clk-mtk.c    |  3 ++-
 drivers/clk/mediatek/clk-mtk.h    |  3 ++-
 14 files changed, 57 insertions(+), 35 deletions(-)

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
index 9cb2aff2bee..c8adbe538d9 100644
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
index afff3167284..d2ac5ad1bb1 100644
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
index 8e37803e97b..e0ca82de01e 100644
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
index d594fc6df39..43820557ba7 100644
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
index 05c22fce10d..3259f6281dd 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -284,6 +284,7 @@ struct mtk_cg_priv {
 	void __iomem *base;
 	const struct mtk_clk_tree *tree;
 	const struct mtk_gate *gates;
+	int num_gates;
 };
 
 extern const struct clk_ops mtk_clk_apmixedsys_ops;
@@ -298,6 +299,6 @@ int mtk_common_clk_infrasys_init(struct udevice *dev,
 				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
-			     const struct mtk_gate *gates);
+			     const struct mtk_gate *gates, int num_gates);
 
 #endif /* __DRV_CLK_MTK_H */

-- 
2.43.0

