Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AC7C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E7084A9A;
	Tue,  7 Jul 2026 17:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GlVnplCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1591E84AAC; Tue,  7 Jul 2026 17:10:53 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9CE84A8F
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a1160a2c42so2841422eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437049; x=1784041849; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDzhWgGSLUPI5KxiO1FITAjmnXG6UI1eTWCj58iprWw=;
 b=GlVnplCe/dpx4oL/E8wnUiI0ffaprJPZcSGyGN4c+VnWIDeFfOaYuvp5bbz+QkFizi
 DQV1/Am4+2BGVODNyJtFrhIT6yPGEX+0czs9kpdPt3hBONyUFwDmUMrbtTbLepifz5rd
 5MgMFwj7xVh2k4fB+ViTb1gbT4OS4zfHa4CMdM5sPkDHBOiUnl4b1UK1UKqwRade8CEv
 EeD9JrbsWFamXjKsLyPAECZkG0mi+xjl8Z3bb18911ZqCNHmqzshzUOvf4tQhl9dkPB0
 i5emS8dbpxhWSWtP/TSt/qOjMG3Ltqam5IRDUQ4vDbwrGXQIdCkWmOSaEaA94cjEXpXU
 A7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437049; x=1784041849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oDzhWgGSLUPI5KxiO1FITAjmnXG6UI1eTWCj58iprWw=;
 b=Z+BK5hJBABsMP4xSjJUq0nqoX66hL6OZCIezlfP1calCX1bTdxgLKdCmyIb/B2qMl2
 g9OJ4IYk+qm2u8+9ZaiEAHoB0ZKrav6tqKJcf0HHJppAMTxcL0QcMcyhr/dy46k3c1pz
 0pR0LkIipl4JN5hkbJBh6YuzYQQEIj3IPfCGFYZ8X/ul9AU/JHaehnRRhgnZOqE6izks
 y5X9EjlLILyUBcdiMW+EFLKCuj493dUqQMTte3ZunVUQr792UxfXUtO8r3BNActtHvdK
 PitDrYyhN1f/3gjwq76b56FI9wD1RG1OpwUdSAWI6O7ZwqzGkC/rlyH9zIirZSgn0YYG
 +8JA==
X-Gm-Message-State: AOJu0YyH4VaHcZN9uX1YTMEV6nCt9CzSQ9CQGjK5m0KV6WWlBEM/dlJ+
 9qf5wY1sktMiyycvxaomClmYOhSHhtbhTlmokWrNCH4u6yzhUHW9tzjIVzrKUf7r4MA=
X-Gm-Gg: AfdE7cnIja/+klaHJ0hVwf8GWHrLeV70p/KtiXLCBExxsuYzYCznabhElJH5cKUi5Z/
 ytXSAS/ZEGP4y75mE5BpWZ2aKhuwbMyZIpQZbXJzmwkICcY/D6jprfISzBbpC5xL6E2rBouf/Np
 zqDYNJIXsOGbWLQ0O/7wo5EyKV5olrrGNuudT/m1lWiJR4og96RbA80jbwx6KSfF4IANksP3ffV
 oQKXhfkKtEi5ZSJbr9d4BGhUhkwz9fddEsjk0iP0L79AJifxHLmll4dM9DjHsEN9PrNd1xQQIWi
 dnJEIY42L4l8LhyDe264J+hWWriOFeDutBEVDbdRdaSHQ++PdEx8Jd40xInadn3Fzbce+epO5Sj
 n4GWvdphsQRHxPE/QbucPv6b0pqm72Ul+mI0o15qDwMEuKjAJFBPI5qD90KlmVEFOHHoBmuWNQ6
 GKMDFtuZcpvUSBkhQjjA==
X-Received: by 2002:a05:6820:208e:b0:6a1:1fde:c853 with SMTP id
 006d021491bc7-6a355245690mr3584301eaf.4.1783437049427; 
 Tue, 07 Jul 2026 08:10:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:40 -0500
Subject: [PATCH 20/24] clk: mediatek: remove mtk_common_clk_infrasys_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-20-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6122; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=i1zY1063FwOwiCKCVmKu4uGVAduV/QtNvXEMQAgKrvo=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLJ8xbZ/LihY1HFR6XPt+taw9YqPmx4FC2oppysv/eQRm
 eqsfqS5k9GLhYGRi8FETJHljcTNeUl8zdfm3MiYATOIlQlkiphMSk5qckZeapFDUmJlTmZSUape
 cn4uAxenAEyhxjwOhkn5a5tflcxsWHm5N9VFIiVUcNEC7xlnVOasXWkpevvUEcYVls+Ftev1ihV
 O1Uennfj/6OPLNJXcMy+utpuVBp5Q56hi9LypxcZavb6g1Cdo+5bv+kYbCtMbHDMFH9d985gily
 3ptj5dM3PWIwvvCCVD2yTRjztW7jvZt9fZyybF4tLVBbbHgvMsW1IOiWqorzsSbfBI8b5/FS9jX
 M+E3wWBPQXh6obZtyWnS3SmL2Hv+mZe8GiRAB9LS9iLhxWfxDgmd2+tizlye8YKvYYN6RpMaY8v
 X5d00fX+kCunkzjLyDbnKy/n4RV/j2qkHjEz3a37PerDk6/znX5fVNN44bklirf3Tq/mr76++m8 A
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

Remove mtk_common_clk_infrasys_init() and replace callers with
mtk_common_clk_init() as there is no longer any difference between
these functions.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 4 ++--
 drivers/clk/mediatek/clk-mt7623.c | 2 +-
 drivers/clk/mediatek/clk-mt7981.c | 2 +-
 drivers/clk/mediatek/clk-mt7986.c | 2 +-
 drivers/clk/mediatek/clk-mt7987.c | 2 +-
 drivers/clk/mediatek/clk-mt7988.c | 2 +-
 drivers/clk/mediatek/clk-mt8189.c | 2 +-
 drivers/clk/mediatek/clk-mtk.c    | 7 -------
 drivers/clk/mediatek/clk-mtk.h    | 2 --
 9 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index fd51173a701..afe1717bfc5 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -699,12 +699,12 @@ static int mt7622_topckgen_probe(struct udevice *dev)
 
 static int mt7622_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7622_infra_clk_tree);
+	return mtk_common_clk_init(dev, &mt7622_infra_clk_tree);
 }
 
 static int mt7622_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7622_peri_clk_tree);
+	return mtk_common_clk_init(dev, &mt7622_peri_clk_tree);
 }
 
 static int mt7622_pciesys_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 16894a68e3f..994413a6a1b 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1090,7 +1090,7 @@ static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 
 static int mt7623_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7623_clk_peri_tree);
+	return mtk_common_clk_init(dev, &mt7623_clk_peri_tree);
 }
 
 static int mt7623_hifsys_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 5d6af62664e..f7b2e559baa 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -714,7 +714,7 @@ static const struct udevice_id mt7981_infracfg_compat[] = {
 
 static int mt7981_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7981_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7981_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index fa12e86eade..731ed6035cf 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -622,7 +622,7 @@ static const struct udevice_id mt7986_infracfg_compat[] = {
 
 static int mt7986_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7986_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7986_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index b455f52bafc..e3a95864235 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -801,7 +801,7 @@ static const struct udevice_id mt7987_infracfg_compat[] = {
 
 static int mt7987_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7987_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7987_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index c8e635e457d..f4a3d40f5af 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -898,7 +898,7 @@ static const struct udevice_id mt7988_infracfg_compat[] = {
 
 static int mt7988_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7988_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7988_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index ba89b3f5454..a520f4f769c 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2031,7 +2031,7 @@ static int mt8189_topckgen_probe(struct udevice *dev)
 
 static int mt8189_infrasys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt8189_vlpckgen_clk_tree);
+	return mtk_common_clk_init(dev, &mt8189_vlpckgen_clk_tree);
 }
 
 static int mt8189_clk_gate_probe(struct udevice *dev)
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0afd94ed4ef..f584b26626c 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1179,7 +1179,6 @@ const struct clk_ops mtk_clk_gate_ops = {
 int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
-	int ret;
 
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
@@ -1190,12 +1189,6 @@ int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
 	return mtk_clk_tree_register_provider(dev, tree);
 }
 
-int mtk_common_clk_infrasys_init(struct udevice *dev,
-				 const struct mtk_clk_tree *tree)
-{
-	return mtk_common_clk_init(dev, tree);
-}
-
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
 			     const struct mtk_gate *gates, int num_gates,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index b9b9360b4bd..59cfeeb1722 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -295,8 +295,6 @@ extern const struct clk_ops mtk_clk_gate_ops;
 
 int mtk_common_clk_init(struct udevice *dev,
 			const struct mtk_clk_tree *tree);
-int mtk_common_clk_infrasys_init(struct udevice *dev,
-				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
 			     const struct mtk_gate *gates, int num_gates,

-- 
2.43.0

