Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302AEC44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9831284A75;
	Tue,  7 Jul 2026 17:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="j8xEQOoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC3484A75; Tue,  7 Jul 2026 17:10:49 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739C584A90
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-448df16ab34so1609317fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437045; x=1784041845; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HP1zSxRnd5a/MllpXM/4Glp8fO3+IwYWdAmngEky44M=;
 b=j8xEQOoc0+4HHNBDYdGKcul/JP+Z7bUytflU6wCgnPqpXXurt1f8+c8VbQyYXcxcRR
 VyK+vAC51A4+p++AW3/CqwV5NAs6MhBj8a7Tga5Gs1Pe3HyD1b+4mTpKaNHjAnG2CrX8
 nwy1H9ouJoAd8nmfLcs/1yVU5PvmCZfWlj+kJy6vYlRatl4VA4iIhN7nnfTU6asD7knZ
 94liQ7/2DpLmomRIvmEbBAf8ndPyLEps65OwNomfn30Lpva6vb5esLHfqUQrxcw4xAWB
 +pQCHUGrIRiVpTzSNWPxqH6IIa7CZTc8FK+tIrr9aISP+oXhTu83AMFpEBMdOG06xxWg
 pjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437045; x=1784041845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HP1zSxRnd5a/MllpXM/4Glp8fO3+IwYWdAmngEky44M=;
 b=BWtzgUSZgNHdQ4YvI4onCwzWtmFV+By8fk5yTjKlsycydMghQ87qnFNh9fcsrKtdEc
 Noh9D2kg3sYZlfXmGlzf9s9ITSQJ9oZdAvVlyFwYduKbVFQaB9powRkxmvTFm/FJ6VX4
 Uop0ZRVdVa1BIf7iK0tHxLWRx8zVQh5/rT7/kIO2z24DILQcvQDf1FipX1G0USo6KYuJ
 ahs3sl85jMTU+zt/oTLYre17R8It07dnyt33YvRZ2D8nlu9bX/lR8doxZqPG70TsQFWa
 JSp5bYroLBscKQtaMuAFx7XsyiRrwWfOfnG4ERULasq5kGI+Yo9wNWZBWYFUTrLzMEip
 0LMw==
X-Gm-Message-State: AOJu0Yz3jFJ9XbPwtiXRhrwS/I+EleKKqGhhVcrlhvQlIo81KMvQ+rlo
 r0LIqBHWUdBYSxM449mwKPPRSxZb6dlng/rslErAPzP52Zm4aTEL09vlqg6xvWg9XYQ=
X-Gm-Gg: AfdE7clLnoASqnKRQ9vZcLsCWA+oUbfNCyfacRM02tILwvAyDrtFzElDGB3GhO2cuXW
 59uvD1Hq08D8oO0rKe6mGN8cH/RXv1S5KHWFFqIEGYBiFguCpi+woK33kV1k33zFib7yvQ269cd
 FD04GdzM7iDuTr/+zONM0G+7MvCdIrEJlnB86+L6PYaYPTxm1XxCe6hysjCo4dSqdBceCI4k2re
 Rp6NwRaLiCgT9aORfXydVxESYA5S40+6JAZJA1NfbKLB8IvDFJHwYHRU3ZGR9cvE1YmeVYT/huf
 R9+txtYYfC6pHKE89JBchAPhgbrgdd8xoF8G6aY/HunDDOlR+/IbYhfngLIdXgI1oepVyQ59cmN
 5dHZFq8w5dWTnuCFEUeSiBu05KP857JWubTnOlDJcXeOQ0tWr7vprs99/r7peq8HGK6/fCsM7Uw
 wNLeKuSJSUTV55pbTauw==
X-Received: by 2002:a05:6871:a1e1:b0:448:cfb4:c70c with SMTP id
 586e51a60fabf-45105f0e27bmr3363787fac.35.1783437045126; 
 Tue, 07 Jul 2026 08:10:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:36 -0500
Subject: [PATCH 16/24] clk: mediaTek: mt8516: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-16-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=U4dc0uUKt0rhUNywK2Y2UYGbCBWyRuOUYGE17b/+XfM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRabLn+vaV4CXgx5v1xTDnrUCQ6nNi8IdIsvQ
 iXEGpj3MeiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WmxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABEkH/2N49sf2DR2cOPRXN3Nnr0NsgVgcQFthcNomoma
 +a4qVWGUPj2xElMhiFgIyGRfO+PELBM7mA7cJ9J6RU88XOhF33+4u0lmf3R//Llq8SufaQrXLu1
 /K9rqMyC6XpwUqqQ/Xj7Szv09pEciK3QR8rwk4wxY9rtwqXglOd5mRDbfkDVGE4k41pDAalbrDp
 MOqInKSGiqSFABd0PXLqIdST49HnT/2iSEXkAtdVsHkcLzfrcJzTa7EfdMyEnL3eIuxUwz/AvhI
 vaI3z79bKwOwqNBHMX61W/8wEgTY32/UmP3nqHF2GMreyh4xTXUEhh4BdZ8+A9/sjWos0xVQPYr
 WjIg=
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

Add clock tree type flags to the mt8516 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 1070dd1551b..0aa35a69b47 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -744,30 +744,42 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP5(CLK_TOP_APLL12_DIV6, CLK_TOP_APLL12_CK_DIV6, 8),
 };
 
-static const struct mtk_clk_tree mt8516_clk_tree = {
+static const struct mtk_clk_tree mt8516_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_DMPLL,
 	.muxes_offs = CLK_TOP_UART0_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
-	.num_plls = ARRAY_SIZE(apmixed_plls),
 	.num_fclks = ARRAY_SIZE(top_fixed_clks),
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
+	.type = MTK_CLK_TREE_TOPCKGEN,
+};
+
+static const struct mtk_clk_tree mt8516_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8516_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8516_clk_tree);
+	return mtk_common_clk_init(dev, &mt8516_apmixed_clk_tree);
 }
 
 static int mt8516_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8516_clk_tree);
+	return mtk_common_clk_init(dev, &mt8516_topckgen_clk_tree);
 }
 
 static int mt8516_topckgen_cg_probe(struct udevice *dev)

-- 
2.43.0

