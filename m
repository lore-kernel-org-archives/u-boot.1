Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230E3C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A51384BE8;
	Fri, 10 Jul 2026 20:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZNB5r4hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F9384BCB; Fri, 10 Jul 2026 20:59:43 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C71C84B9B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a1888969ddso782451eaf.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709980; x=1784314780; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LaS5oVPcOKirXMgw/5Lr/uuJts9id/DW46ex3rD9Qjc=;
 b=ZNB5r4hdHjdQDhp+Sl18u47M4UpNV+ycFR3vpyNmf52SeqBYECeYulReX8+zWzqrs3
 AM4jJZIBWBAUO8htBATQsDgqF0Gqzkpkxg0E/SvUZJmVqEUOkiHH8wI1AfTzLEwvqlsq
 1GYuq3PPe/lkI53JOZPw7u96Pn5Xre0S/BGdjBlGFoM9EC+nfj6snLszo/FEvutUT3XH
 YPfNr+bP0u/zO2iOIHDhg9QYH4O1ERN8nJ6ZvOUYPDTgawOucEHjHhMQrC6+UKRq9VlL
 eA+s4laF5GPku00jyEaHyByhf0muZo/L9xzIcWX4fB5DIbdIb+x7kdz8xFPr3jgv+l31
 rEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709980; x=1784314780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaS5oVPcOKirXMgw/5Lr/uuJts9id/DW46ex3rD9Qjc=;
 b=bc/S25bZjDSXSvWKpFx31fwahLt8yhELY08rE3iagMn8C6JEXvtZMRRMlJXCDmU9xz
 nDbFi8yCCv0zPXYVUO08Wu7UfHaIg9fL3OMuFUzWxD+0MFq7vTDI4rTMeqjXcPsSQOLY
 V2m6jcuVP0ieitVccsa6FSkgU5wjcoNL1LLOQrUTAUPEAHXaXRCNxfYEikIO3ZCXcGWM
 JeeYo8rW/XdQvVcR/yjfsxWsPfgVznCY4ddanVkEVZyNPPdoKvlQOfNaK99O83fzQTv3
 3ZEW5i2ifsLqQaoW9xuMgnSY4JQ9EIr3wsL1wppJkzAPZVzO7FCRoBe9BFNS8F8Zt1RD
 r2dg==
X-Gm-Message-State: AOJu0YyH1n/5fTpleEtkNo5eQQLu5fysIhJQUXGveWcU0aOKJwN16pKZ
 qkdO//1ETiKnozeGev8hF4m0FtOyTY8W2pV0pbf3rSNxUjMQg22f8aFjinD+MWSZzSOv4cWRwEy
 ZkTpG
X-Gm-Gg: AfdE7clSLKxb6dVNMiuhwpYCr2bOzLmHkmELB+GVxrwEQ50VaEJXZrOiNYmG4926zlx
 E11TEnhgbFlty5mMLiFWh4MMcGE+hY9PKU6UOaPhWCr2WHQ3t85JxtfxaRuTQnY8d7jKWezAlMs
 4USI6KKR2ou+nwLkqmoWp+bbdaUxdCi1lK8YXPGSYi1tzNjPSmHQt4K6azmEuwjEh2GnV8PWIRQ
 wGPC9mh1H0erFdvZ7DtxJvLk9WkwkhdQaOgM+k+lXmiywvRUgavH0Udid5G/leDeCWX6fAy1hsB
 6myRuG23GCfMDzwNOicxUI3BBw6Vj3s7l5va55EB5cPAndNKYkDNxdeH4MZD8bXem9OovtDbF+i
 0e9IbGEDQuQF0MtUBCg13La33/N40MaRW0wl6HoCFKlnYVcCR9C8eX0WtBZ0Wfc+2FT+x31yhek
 s7sXnxQJNYFggQMc05QiTpxh7Za1o=
X-Received: by 2002:a05:6820:310b:b0:6a3:99c7:1d2d with SMTP id
 006d021491bc7-6a39a6d3b56mr317196eaf.42.1783709979796; 
 Fri, 10 Jul 2026 11:59:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:36 -0500
Subject: [PATCH v2 20/24] clk: mediatek: remove mtk_common_clk_infrasys_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-20-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5899; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=yXPlAyLNWxydbVBeV3TQWpJG3PSBX8HzzXiezFb+P/8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDckH9aI1HkxsLVKRgZuBVaL8w7z37+w9IXW
 4bC3ds+M5OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA3BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdRIH/0zFUXANoh5xnjLYEwPXUBNCOuvI10U3Z65nRcV
 7STomd0OadGN0byjRDtC3zCj+Bsb8etmtOy2QjLLdJFcYin+2QrK6uPCYX10ZdYSM+aQIl7Hgxu
 ZqUXC393FM7a4aocULKL8sVy8MhmKi8uG44z98qPCPTWEfpME3K3ZBDTR/iZEMc7e2nQqDeIqh1
 x9eNr5Yv0OHvTlNUkp1LRJSlQnhEZiSC4vQ6tRm//Y/7lN5MFqGp8PhumOXqbcXICiTWf7hcwQu
 9pCnwGT6svnD+MMv0uEbFppO3BayZXdlQp9lykso/1UO2q45QbzWDPz/U8vXoe1qZcQRE7XEqsC
 sUYE=
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
 drivers/clk/mediatek/clk-mtk.c    | 6 ------
 drivers/clk/mediatek/clk-mtk.h    | 2 --
 9 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index aba870bf0f3..6cee27e2df9 100644
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
index 348b8c1e85f..38351e5c5d9 100644
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
index 23d34a315fb..debee21fcc5 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -716,7 +716,7 @@ static const struct udevice_id mt7981_infracfg_compat[] = {
 
 static int mt7981_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7981_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7981_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index a5301fbe8cf..5f40b782f4d 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -624,7 +624,7 @@ static const struct udevice_id mt7986_infracfg_compat[] = {
 
 static int mt7986_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7986_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7986_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 27367de82ff..b45cd5106b4 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -803,7 +803,7 @@ static const struct udevice_id mt7987_infracfg_compat[] = {
 
 static int mt7987_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7987_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7987_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 309b6e03ceb..011dbc8e7aa 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -900,7 +900,7 @@ static const struct udevice_id mt7988_infracfg_compat[] = {
 
 static int mt7988_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_infrasys_init(dev, &mt7988_infracfg_clk_tree);
+	return mtk_common_clk_init(dev, &mt7988_infracfg_clk_tree);
 }
 
 U_BOOT_DRIVER(mtk_clk_infracfg) = {
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 25b88198fd8..c8804583b32 100644
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
index 52d3428438a..61d718f162d 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -1200,12 +1200,6 @@ int mtk_common_clk_init(struct udevice *dev, const struct mtk_clk_tree *tree)
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
index 2993dc35efb..437797dd0df 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -301,8 +301,6 @@ extern const struct clk_ops mtk_clk_gate_ops;
 int mtk_common_clk_parent_bind(struct udevice *dev);
 int mtk_common_clk_init(struct udevice *dev,
 			const struct mtk_clk_tree *tree);
-int mtk_common_clk_infrasys_init(struct udevice *dev,
-				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
 			     const struct mtk_gate *gates, int num_gates,

-- 
2.43.0

