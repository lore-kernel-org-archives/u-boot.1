Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ADAFCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAAAC84013;
	Fri,  6 Mar 2026 23:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zRs76Bs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F9BA83F2D; Fri,  6 Mar 2026 23:07:16 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD15583FEE
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso10704495a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834831; x=1773439631;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ITtINfRcn1rmOWp3ivpSYRzfIcMdjeKbwW/17YHjVm8=;
 b=zRs76Bs9FyMLGcOj89pEMWlwuG9xW7vQwdOE7n4Zx/d1BK+Q96TAyGexhvBdFMPdHJ
 0wttcfcjm25AxUWOIiz3i50qzvW7nsGQh+M8hYpDBgsjzr9Y8jzK4h/R3RBvFTWRwO1F
 g+Dcg5IoZX9/fOYNesjVECKheKqRxZkj81KfJxPD1kItrP9MmQHYzW2/Pdbi6k3p388P
 dm6fmu0CokrHrWCxMgmhtgBOHmUMXPtbCYIyGrrcbmZlW/o7MBm9HjowoATTCASKvEvB
 eN14LzzTPP841BDoRU1aUqmVssFPe3A2jVSTIQ7uMUOzNAQ1GhKGaNJrx9KSAa1nTdMz
 MALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834831; x=1773439631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ITtINfRcn1rmOWp3ivpSYRzfIcMdjeKbwW/17YHjVm8=;
 b=gL1G7tdqBuFeZFRSv3sRXLRRfLR3U1rTx0SLkJEmmxe6wubopfVHoFv2kSlqUpoHRS
 gww+iQurtG4keGbLG408mDY5yQ9EBnceLkRAMVZLHW+P9Px/xYLRSeo5oS5ok4yQawQ+
 2suxG5myGjHaCzm+lejaSxfCGrIBNPDUV5ceEvr69ozKKwfJBlJP49cDl9lFo9nbplxS
 h4RTlx392MtUsoZ/zH2oUpd91VMvRyirO3FDgt2hvOWuGxvKMye9OL7tYUpI5vkACj1B
 gYK5d9yawf/NlqUbhyH8MRYIGr0UP9XqPntTQMh7zWa2hZbJ6tqAj/+2wLEFosShTbOb
 d2OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAkXpAKzFdO/lxWgaZPShV2p7zf1YGd07lv7TtcysmAyQbFPOb0+C+LpoMq3kpSBe044+P6Ik=@lists.denx.de
X-Gm-Message-State: AOJu0YynDleRpqlJ6IhzFgVmR3MAEQ3YNwAXsBbnl0RfJnwXyrBy45is
 /NzTxtOS+U9uQPGgR5cpdfilyL5wZR2xOtDVUd8/INuHWzv/O/5yIzk3w8/hQggAC4s=
X-Gm-Gg: ATEYQzzJFBtoe2CjVVZIrY9mdC17oEqLAprUinYTntubtDTRB8x7xQSxx8nZeyczWrr
 m5xyk5Dlfp+IS4FXsP2h9B+vEnQNoCxOL5CQw31xsPO4mNjc7hEFnY2DDHtdlVBisvBtHHHipTr
 AxtzR5VG/Jie3ufwVUzd1KV8R1QzmTJw43+DN4P4QeUKLPsJG4wYoHQK9eQ+ZuVz94elqEoV64H
 4XpkVz2K2MNOcqQ3LHH0zW3d3SRsQhfTJbxjjb2wSOd4xJYaDH3YoXLKwsrMeoUFu6EOuDaFlK/
 vTqtmGS7xAX8+D0aMsoh5tXQLrm9ExDf95/CoZ4c58RkGLJ6gmv2l6Z2Qx4MxSd38laiZto8URE
 ay/5vUMjciuEAvS7W/GRVNjssCq5wp2vw2pSvnJRhY/pWh6axNA6rDNJHEB9iJelGj+bWZGTkW7
 qZtNPcKN1frmTFRGUt+MMiW0sKYWBw
X-Received: by 2002:a05:6830:67ee:b0:7d4:57d6:956 with SMTP id
 46e09a7af769-7d726e27384mr2352247a34.0.1772834831615; 
 Fri, 06 Mar 2026 14:07:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:56 -0600
Subject: [PATCH v2 9/9] clk: mediatek: remove use of CLK_BYPASS_XTAL flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-9-b253b49f17b2@baylibre.com>
References: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
In-Reply-To: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5358; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AhyCw3P3oQ9L5rdK9Pzbssw2VIFr/cs8+2FH/X84kfk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0//kONKjl34HSXdHC+Aiir2xt4IZ8asJqBCC
 jD4dtK/J2uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP/xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZVUH/3KTC4ZrNMrdvLbhZieRfnS92oAX+o8Wtl0i78I
 nXrZFsR92A9XQix8RD7940tcP7iVpq5DCVb2lv1aZcOG5p4CsLOMMY+NO5Dbn5CqlYPax0Lt/Yi
 L+p3ICS8HZcBIJ58kz0YbM48BHldJB/fxciydEoyNSo/GX6UhKE4LxgQzDwSuLAPzRqlzMsEsi1
 Gxy3YEuj2wvu/oV9d66BY2rL4AkA4g5Mpchcw/FPm7BjWC+VIVgJknSSMvflQT8RVh/8lrYa2vc
 06eCJFZNneb+qyUTzzXu31qi5aJDd7L4+wbFrnY+BlyL+26AxPro6BZftlyg2M4ZCzz6pcr6O8f
 hvyg=
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

Remove the CLK_BYPASS_XTAL flag completely.

It was a bit of a hack that was meant to handle mux clocks that had
mixed parents (e.g. XTAL and TOPCKGEN). The idea was that if you didn't
have CLK_XTAL as a parent, then you were supposed to add the
CLK_BYPASS_XTAL flag to the clock tree. There are likely a number of
drivers missing this since it is not intuitive.

In the meantime, we have introduced the CLK_PARENT_MIXED flag which
handles this more robustly. All of the affected drivers (the ones
without CLK_BYPASS_XTAL) have been updated to use CLK_PARENT_MIXED, so
the CLK_BYPASS_XTAL flag is no longer needed on other drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 2 +-
 drivers/clk/mediatek/clk-mt7986.c | 2 +-
 drivers/clk/mediatek/clk-mt7987.c | 3 +--
 drivers/clk/mediatek/clk-mt7988.c | 3 +--
 drivers/clk/mediatek/clk-mtk.c    | 8 --------
 drivers/clk/mediatek/clk-mtk.h    | 7 -------
 6 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 40e8429521a..42c3741ce62 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -525,7 +525,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index c2c216fcdf4..65d4142fa63 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -530,7 +530,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 };
 
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 641881fcb28..e7b81a512de 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -446,7 +446,7 @@ static const struct mtk_clk_tree mt7987_topckgen_clk_tree = {
 	.muxes = topckgen_mtk_muxes,
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
@@ -771,7 +771,6 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 83f7c559e31..943f85e701e 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -788,7 +788,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(topckgen_mtk_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -799,7 +799,6 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = 40 * MHZ,
 };
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index e86e677d8ac..30439ae7d93 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -735,10 +735,6 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
-	if (mux->parent[index] == CLK_XTAL &&
-	    !(priv->tree->flags & CLK_BYPASS_XTAL))
-		return priv->tree->xtal_rate;
-
 	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
@@ -1005,10 +1001,6 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 	}
 
-	if (mux->parent[index] == CLK_XTAL &&
-	    !(priv->tree->flags & CLK_BYPASS_XTAL))
-		return priv->tree->xtal_rate;
-
 	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
 }
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f81e214bf00..2d67cf15f47 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -13,13 +13,6 @@
 
 /* flags in struct mtk_clk_tree */
 
-/* clk id == 0 doesn't mean it's xtal clk
- * This doesn't apply when CLK_PARENT_MIXED is defined.
- * With CLK_PARENT_MIXED declare CLK_PARENT_XTAL for the
- * relevant parent.
- */
-#define CLK_BYPASS_XTAL			BIT(0)
-
 #define CLK_PLL_HAVE_RST_BAR		BIT(0)
 
 #define CLK_MUX_DOMAIN_SCPSYS		BIT(0)

-- 
2.43.0

