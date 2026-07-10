Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB0DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AD484BD8;
	Fri, 10 Jul 2026 20:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="paZm3Afz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E5D84BC8; Fri, 10 Jul 2026 20:59:39 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2BC84BB2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44caeb973b3so749933fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709976; x=1784314776; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1T+9bWiNA7e+BBPElWZb8EHLwPZNjfRnUoVi9RQSjNE=;
 b=paZm3Afz+Fkuv8rIUO1Jfk777PQfCHThYURMGfN0jZn+sdx+/uO3y0Y2r3SXQNdLMp
 Ykuy9C2mBfN8bZQwPfPCYXFfBFeQWxJL2uvy1TzbrSSPEv45Ed4F43wdcyww5h/54FvQ
 IwhurWYhl+rTZPNjAVHR6aH6QHLqKzaf7Z46gGdlNJ1wHZAXmYwtF0mPFyOngTv/h2tX
 w6ibY7CcS6E1cZpEzS22KxgLDy9YT/qyJS+5g/ya62ql8yUloDcbH69yu/n7HsMrbERP
 ZB3CgZQTdtaYZBzsZcea7pmi+pOyNtnveJVxHJoKzR8GhqgW2tYeJ+d7dtlM2srZoCag
 xkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709976; x=1784314776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1T+9bWiNA7e+BBPElWZb8EHLwPZNjfRnUoVi9RQSjNE=;
 b=GiV9tuZNP3rcqJpWIvSXHfNcRj2lPPF56lVhDtKMhSM6iIBtoeD4buZO2ptoNKSqo4
 PukarT3zRIiKZ9veaRAqbkh6YD2p57cIqptoaX6hnEwFZEjWrnWTCBDYtiMTQsi8YJU/
 3Di+LG/syMhma9NjPOBXmTG+zRJjdaz3UIHA33Tf8+7oHCLpHv/Uqvw7j1XvmkU5Lpb3
 iZv3NpHyBguWwhGdjCiVt4EvwPiHiVJXi47+kHP3Vta086wEjU91Mdf4TkDTU6YtVadQ
 gGxP3hsjaxfyjhb8tCRtCK2vL5+LhkUo5odwnZdDobzRukGb+6S6VGKgbbVzRK+KAjJ0
 DpAw==
X-Gm-Message-State: AOJu0YxVri3MPlOnaMRtxQY2OPsmn/+r3iJNnYwWuNwt8miXU7QFGdUh
 EQX1Ygs7ut9XVx1fw2j38BeblU58alxISiuY9ro2wq7Yz5rmgXtH4Z7J+pXQ2UxQS56VvdMOCUZ
 zWpWu
X-Gm-Gg: AfdE7cnk/mqF2hrTXIrlSWMIx1u6Ws/H1zh3A3Sc65MUFxrqzGUdh9cRaFiF5Et3yex
 ltPUrN2w+DkSY5UJc/aqqkipDlKgQ/w8eDppq4gHTSw1g86d+6Ls20qbJRwrHYTY1exI4EhFC/d
 sxX9Hu8GbvcKBQgR1bi4y3ioGa4NMXQ1qMU24AldDZSopFTnFMNrys8/MGtIOdZgkfA0AKgWGX0
 UoMXzDE+OcsioOWvLX4+Qewi2IhOTw1gZ2pRVKV0xnX+t8lno7l7B7w/PIpuqbYKDw/GrtZEnZU
 aewnJ8OxmnpQEIwl/F2vnz61mhfmS46lJF3RasSR22/LWBzfOdcb55WlUzvn+aU376rFFxm5BWa
 RQgeXwz64zK2/CkQemmQz0pwx+pVOUsYmTeJwhPOiVxUgzoBGi5e77ma03rUTEY7CXPzmxAyN+P
 iIMzGTFm9IGeU0Du/n
X-Received: by 2002:a05:6871:2e83:b0:430:2b69:8e9a with SMTP id
 586e51a60fabf-451f0faf919mr103305fac.5.1783709975937; 
 Fri, 10 Jul 2026 11:59:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:33 -0500
Subject: [PATCH v2 17/24] clk: mediaTek: mt8518: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-17-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=V3lEitSFQ1lKVlQ3hoHX8SOXdNZkkSsAMQ5HKLbA5Xo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDIeoOE+zyuy214IZpUuxeh1R4+jNdoAPeoD
 rgtkpJ6ls2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAyBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASjkH/3fxK78PN4Nn/NMi8XjrAUmkautfV1PeK1KIl9S
 P4eOKz/mBWjIxAmbhbLxgHlBhjmq5Q/CVUekGhkUndS/h8W5SHcJwciJhQyiZ5FfZTKORlJWoDL
 Omu/KWAe3e8HXrA1L7uuZs6S6AWxm7Ckw70kdJ/pr7vZVqjgg3bV1vIns8E6rShTPPqjFJUdtq8
 2RbiAemQgnLEHlCvcMZMFU4vhHuMJ2yf2L40b+Tx92ulI/iQOwoF98c5fJBXmAPMMPhX9HRx/bQ
 GPGHo+4QYbf9BO3k/tNYL0fkizRvwOh5SU4aW0f4l+RKr6ckE1nCdFCaf3LrykT8E0jD+d83tdU
 /b5g=
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

Add clock tree type flags to the mt8518 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8518.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 2b213e720a0..51599c10cd5 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1500,30 +1500,42 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP7(CLK_TOP_DISP_DPI, CLK_TOP_DISP_DPI_CK_SEL, 0),
 };
 
-static const struct mtk_clk_tree mt8518_clk_tree = {
+static const struct mtk_clk_tree mt8518_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8518_topckgen_clk_tree = {
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
+static const struct mtk_clk_tree mt8518_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static int mt8518_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8518_clk_tree);
+	return mtk_common_clk_init(dev, &mt8518_apmixed_clk_tree);
 }
 
 static int mt8518_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8518_clk_tree);
+	return mtk_common_clk_init(dev, &mt8518_topckgen_clk_tree);
 }
 
 static int mt8518_topckgen_cg_probe(struct udevice *dev)
@@ -1551,6 +1563,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8518-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_apmixed_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8518_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1561,6 +1574,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8518-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8518_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8518_topckgen_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

