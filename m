Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DE3FF6E97
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF12843D0;
	Wed, 18 Mar 2026 00:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FCkb0koO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04A08439C; Wed, 18 Mar 2026 00:26:44 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9B3842EB
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46704177543so130186b6e.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789999; x=1774394799;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qhgWgirB9gvNIH8nD4KGgVSPZpIMDDfUlY+aTcfKjqo=;
 b=FCkb0koOs6jI3y6PTAhnN1HpkbcekBQbA4FvtOHvkfOOUfW1oCE0Uvw121zkdrGbxl
 G6ZCyyowxXJ6qBe/sdHZ0w+zzElrLHgknuIUWUvRSiCZ3FYvRxn/oAzUizW6FddlAlmf
 nIBJS7vA3Vq99SBq/NZQ3tuwXQx4ZDK4AnX2Vj63DCIUSQve/5RE9sfew/BIEu4KQ8aj
 CnNUPorbtftK0AOgwid+5RVZN7KD7h3yet9RZ22TtLBeXgx7U1ruGgeXMueMTpUzGUGF
 zx6qFnwzt9AzEYq7Eh88hNQb9TfAJCFXAjMDqI2Gw2sOK96aD0Z/ztHAthZmYsmU0ePL
 zCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789999; x=1774394799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qhgWgirB9gvNIH8nD4KGgVSPZpIMDDfUlY+aTcfKjqo=;
 b=mfCa2MpOnUTZgnr7zqrGS0UbUq4eZwxu+AR90U1B5WPnpo6U2z/2/dJBk+xweHsYpN
 eaGfYZpD4rdPmr/GRuBI2RHkCj6QzboaLOUjxYJdgOwdvcgSCznovosGppuMoEiNAAyH
 ly2E/ynv64FMLsMXG6BeTDo1FH5A0DKQ2bSRm68qKuSvWrndmAwZ0f/A+IMTggD7Jk7z
 45raH3/3QiCr5i39EhxoyDQfPh0nAY+9h6ttpa4kKlEACVBXTOR4z75EIjFkkNnXEn4l
 RrZdYP+nWt9QVxN/NgdkuoGe27JTeJaSUaOQFUsEbqCvWf1bhpen0WGVj73KE6QBKbTv
 AKzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfrq98MGOyNJ6p1JG0FjKK3MeZpCQNisD3Uz1J/KyhaOkE5hF7xEGykSf6K6cuW/PMx4rNhKk=@lists.denx.de
X-Gm-Message-State: AOJu0YxZwVEc9u09+K3IT7B34loBS85EkpylD6lbAfNxl8cPyUiHAiQb
 8KubXGHVLBZMvoq+1qXRGYt+ONuPX9P9GYvQmvbXjpoBjpeB2hZAjuf1GjVHEJwv8L0=
X-Gm-Gg: ATEYQzyLo9NovSErUNWYpq1uy8bbrSf7exlejiUo1G5Y0Tv9bDVgdzEf+F8/sCG7VlM
 SiCS0fSx1cfp9N1BMH0KcaeAySc73dLb6+LmvlrBNDnZaPta4bJZ3h37gXjiQBb+30ziz4cavpW
 K/+LQi1r9jXaoa9qUX0eqrZsFSN/5MSt/6mLnzWHNbfbsXVSYMD/XwBISZ6BYdQjHRWLjjlbIcT
 P2H//vlJjD3HIBtVUwiUIG/A3axgAI0Ve3IpLShnkwFnyeiNuqjGz7w9Y4CQTXCEFOuIG3Dwm3s
 bapNmfVGvZzQImv4mrZ/j/E3P/6s/BZDoaySiLPYU/05nw/avZrFYSnt2zzv6z/lKwi3abPn/Uv
 sWqoONyi83HnXzU/YBMc3kaK9lzaKpPhTYpJJmM6rsn/zSl5c+nLxwQmxyfcISP12Nwabyo8lXB
 QPJlZU3wkF5ujHN47vZn5l5GF75A==
X-Received: by 2002:a05:6808:bcf:b0:467:254:b90 with SMTP id
 5614622812f47-467ba194543mr841716b6e.10.1773789999298; 
 Tue, 17 Mar 2026 16:26:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:27 -0500
Subject: [PATCH v3 14/16] clk: mediatek: remove use of CLK_BYPASS_XTAL flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-14-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5411; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BFRD91v2Xo+JE8TjSKy2wnVo5NCzL2X78Ugnj7Tbevg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueMNBxTIpImHpjbp+mg6yrgUoBoR2UF4RS/Sr
 5yy4QHIrxGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabnjDRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3nkH/iSIKJVuKVBFZzbo1OHDiC9n8Km+OLmPpEmdSnr
 i3diSMSZgvlFfhw30dpFX4KVqdmqVFHGS31INP/W3h6D0sSdgbD5KPWmOsfpIGpx5CMrI888lp/
 HPYC76c0CSIvWXXUa0KSR7vE+GsaJ2sKjVPPvk4dVKGjUac7+ZuiB11VLWO2UpXUfofUAqxXOWC
 U+rplCXjepFR68wzXMbAnENMCOUtZHUOaiM8n5i+RqMKqhs+Gn1gFXEeGfh7+YAQuB+iprHxTJa
 UHtj7CG+abvO9YYGDyqnYq04tXbZc/AcpSq1fxKtzOIJArYeKTsjQ7rhfARHNgGzXZm9+CPch2y
 WftM=
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

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
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
index 0c770a0bd93..cdd9b9e4092 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -623,7 +623,7 @@ static const struct mtk_clk_tree mt7981_topckgen_clk_tree = {
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
index 2f3e314b648..5ae76a2c47a 100644
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
 
@@ -772,7 +772,6 @@ static const struct mtk_clk_tree mt7987_infracfg_clk_tree = {
 	.gates = infracfg_mtk_gates,
 	.num_muxes = ARRAY_SIZE(infracfg_mtk_mux),
 	.num_gates = ARRAY_SIZE(infracfg_mtk_gates),
-	.flags = CLK_BYPASS_XTAL,
 	.xtal_rate = MT7987_XTAL_RATE,
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 21d194ed807..38a5c20035d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -812,7 +812,7 @@ static const struct mtk_clk_tree mt7988_topckgen_clk_tree = {
 	.num_fclks = ARRAY_SIZE(topckgen_mtk_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(topckgen_mtk_fixed_factors),
 	.num_muxes = ARRAY_SIZE(topckgen_mtk_muxes),
-	.flags = CLK_BYPASS_XTAL | CLK_PARENT_TOPCKGEN,
+	.flags = CLK_PARENT_TOPCKGEN,
 	.xtal_rate = 40 * MHZ,
 };
 
@@ -823,7 +823,6 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
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

