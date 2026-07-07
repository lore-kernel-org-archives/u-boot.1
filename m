Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB3EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082C78497A;
	Tue,  7 Jul 2026 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="AzFVK/Ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F054F8494B; Tue,  7 Jul 2026 17:10:35 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF278494B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a31b9a492aso2320086eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437030; x=1784041830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R8J86CsSP+IQEqU56TSU8LATIDIK+mrSlZkaePyxwMI=;
 b=AzFVK/UddJh0OYcrxRFstGt1WScV97Qhs05lI3+/57spDdZKfP4ODXnB3rjRQ6GW5x
 e4nR/AsoRjRkCWc8IS8UD8RBiKQ8ZPrWgkbOopGDBXxiHl4PMIjQezvr5oROcMbSOLM9
 yWZQAGyo3IK9u6KWkQoBlS7YoliSETrrbDy3pOYgj1NHuYqOXC+7nyBky06/NNB5sgVV
 w9VMYpvyDZ+4NHNnuW3Hnodq1Wn7CTIFNs5ro4kjzVikVDxWb58qUdcSNnlsF1jLXuzp
 0FDjrz9nRZvmx0pp7r1EdWvzCfBGwPjyjs0bT9V1cxzOuDPp4Tuu1EfNWWCjO2j7a5CC
 w0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437030; x=1784041830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R8J86CsSP+IQEqU56TSU8LATIDIK+mrSlZkaePyxwMI=;
 b=ItoCKpwvOxsZszrUaJxP16yFugfjHFkVCKTpE5Qz9FcanCm+wDCJhcMX1lTxi8DRvZ
 sIpysEHGSB7Yukt2b/Y2u0huHjnw1bKuba7lmcT4y3g3ueht4YRhew8uvyUhky+/dIcE
 cV7SXTVG/ndtPRIYfxl+F0vo5nonacVGvOe567Sh8Q7Wpc9TRui+xbMoplfoPGg5Q9YD
 1DhcwxzOCSEuIBNwaoU5TRcDB6N9plHjHuKDr1N3D3Dg6oAxPZKLhYmCd3w9Dp2gyLXk
 BUXfpsaQ+siOUwnQVB9S/xkm3hfHH24/3wN2CC9kTaK1Acnkc5ryGECsNEpXpQqVSYAj
 oOPA==
X-Gm-Message-State: AOJu0YyjeYUmPPJTeoyopmrmuQpMTkUkkXE/BMTdxe6y3NHE0Kg23lav
 MYWWf6JZeSkoh6CUKyfSyCdUaxfxUyT0Ran3dO5DiongGKHjor1xYA8SrEt0x9fmQnQ=
X-Gm-Gg: AfdE7cnwwg68j+OQoFrGEm2CG10X2lfp6vNLcGmhDJEN+UFs1o9Lu/3oB7ugeE8kA+2
 Tqa4RKjYDuEO1uIKC1gXptpkQiw8EfRlng6ntMDqHaBEPpP+ikn6GLSuSaDBudEs8PAriOGYhdV
 4zaEaPercp+dRLpuUMi07ao3RZkpN1VIdXRpEqzMChGUDvMxzbarlxgGprZhRAv7eDWCTLsCTpL
 zGSxldw+bcd7xqXOhk1eq7KhUe8X0ia/sEMtAAlomrxcAu4CeGqNHHUIKC8wDP63A++kZa6iBLA
 9llrPiqxlY6SkRjoHZbt25m83P3CAqcqAkZD53mD5xerjyn/VXgCdyuDYPQ4jhiqCYzUZfM9Fkq
 m70N09FDOjx5WcofuQfiPAPVRgyGw+M7Rk2BtJ5RzLwad4pfljR8MnJ9M7fwnOmM75/qOiKUTki
 vooNPP3y/h3txpTGW4JQ==
X-Received: by 2002:a05:6820:4b01:b0:6a3:129b:e617 with SMTP id
 006d021491bc7-6a3555122f3mr3598985eaf.71.1783437030188; 
 Tue, 07 Jul 2026 08:10:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:25 -0500
Subject: [PATCH 05/24] clk: mediaTek: mt7629: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-5-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=H3zNJ9Wbe/hmMciQKwEXX3w285jg/vnVIw9Y3B/4a1o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZR8uCdcqAXUHlZahYTQKwzYxfT3DZ5ImB+Y
 4Ro6VmYOvKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WURYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ar/0H/0W4Ms8UQ3qMiHW3qgc5F3fzHqHwf+9WeB8PFTq
 4toZWSHBiP3zq904hByPrhX1IjNlpxZT9906lKANCwuQqSsLgduxUTvpLB+rfCdu2aW6REzzHgZ
 ww4Dztt7acyyBjrq6JQMWrzpqXGCWywp/4nonHjhd3qBM1Nqyw+93DLZyQFfdOrs0O54riIYfda
 0ISZeKf1K8aSYE7zcDlnjzW6OvdeYz2UzXiH4RYMJdGBeHfR/s51riuw0GP4FZTF4dvSeTq7f7o
 yn0rPo6v4XQR07cqWI58PT5gHjcnZIbOXyOSlxTqOhV4qCskluE0duT/2LXn0OIJzZZsYNqWliP
 910U=
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

Add clock tree type flags to the mt7629 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7629.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 74510ee36a9..621abe4d1a3 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -575,20 +575,32 @@ static const struct mtk_gate ssusb_cgs[] = {
 	GATE_SSUSB(CLK_SSUSB_DMA_EN, CLK_TOP_TO_USB3_DMA, 8),
 };
 
-static const struct mtk_clk_tree mt7629_clk_tree = {
+static const struct mtk_clk_tree mt7629_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK20M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt7629_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
 	.muxes_offs = CLK_TOP_AXI_SEL,
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
+static const struct mtk_clk_tree mt7629_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_clk_tree mt7629_peri_clk_tree = {
@@ -628,7 +640,7 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7629_clk_tree);
+	ret = mtk_common_clk_init(dev, &mt7629_apmixed_clk_tree);
 	if (ret)
 		return ret;
 
@@ -642,7 +654,7 @@ static int mt7629_apmixedsys_probe(struct udevice *dev)
 
 static int mt7629_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7629_clk_tree);
+	return mtk_common_clk_init(dev, &mt7629_topckgen_clk_tree);
 }
 
 static int mt7629_infracfg_probe(struct udevice *dev)

-- 
2.43.0

