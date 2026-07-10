Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3828C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBB084BBD;
	Fri, 10 Jul 2026 20:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="I94GMVm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CC684BB2; Fri, 10 Jul 2026 20:59:34 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E513C84A90
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-448b89f700fso835490fac.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709971; x=1784314771; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6XbtpASWPm0DtZhg+fyogHE68OB9V8mSjXCrs3PXJo=;
 b=I94GMVm74VSNsCjvAKaFFXKV8lqz59qKeOSzDlhOk3w5Xy6XfvqyDQ2PFs80ti9Z/L
 UMVKSCcszLSqY/1MH0wM7OsNMvOJFn7oCLSXW35t/+JWWhdzx2D50zW5BlsB52WxIDL7
 0yviN/nNtn6mUfAx2kvDWdSgMp2ICTc4mDswjSXStmnOBfX+4VSsarp28zYrQFDHwQhR
 C03GiuJQ8/kqHumKgpAL7wBIVahCDsEUC7vZxAto3WkXHeMeH6Gyu8cL5/JuLzgopH63
 O3P9smjJMfdCCR5ikQ8MJlnBk2r31eQqlLQWA/rHSIylsg1a56Wtb3kfhpzcsInbu1uQ
 Qdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709971; x=1784314771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N6XbtpASWPm0DtZhg+fyogHE68OB9V8mSjXCrs3PXJo=;
 b=hWe32KkoKfuBPJ4hc59CNDGCoeI1sYitbaDTfXniEBrxbXCEV6fY/wIa1wlDZZ5Uaq
 aIG+hG2vtqrFx4hUYaAUMIZa7JXn/EZhd9r3Y4W3J34ErAvLeRPmCl7YaL2ZI8VczIeJ
 jukCRPQNBMeqT9E3LqMRRIefSxedan3lYVSO2kXzQcRC1sh+2dmNF8VtkbKUYgfN9LGT
 YP0RLqLInhTTRL1A4tsbfFpT41PdRt5RaMPm7o/4/gCkZ1dNUGk3C30DDQrbFGr6klSl
 Upab/+sGHDtYjXHnyQghp72RP4R3mUyGkVR6fVpktOHhzrN8CoapZ1kGF+v61GmLnX3p
 jGoA==
X-Gm-Message-State: AOJu0YycaDPgDJIBSKfJ7/SC6k0o9+dJ1xHiGJEEAVGTCvmntilckS82
 Yr6C0N+3pnv2MI14vkwFdS/fEkB7l8dzEHt8EBPrNaNgLSxX2vUHLQIqh4J7WikmXG8ebI1j5Ge
 FUyqE
X-Gm-Gg: AfdE7ckD8OUWqCpRCfwEUmeKNkw6GgnJUqnQBEzplC5ZYju5wnfmjiQuFgppSvzEytG
 N3Ypi7TaDLKL9hQDb2PBZZyrS2hGtMj3SMYw8n72DLvQ40priTqs6GjebEmXKZkSBJfpYUPBpTO
 ktvL3NBvP0QPbHg4kxLW6mxNVPjkztSQN8q6NFMZCBhPzzBLGueYz98SuGanYbp9ALECVbcwQWF
 qzocjLjyAO4vDKnLpCsSUhP9e89JegpIwCR9tMlPRrWXlxMjMQxx5Fm9kkKbgV10SSMi3/PH+kV
 01xEymJ9OdYr0XxYwFPPXUIruR52DZJh+bp5bD0ADUU44WfL1k0WyPRtfTw2jBI5d0Ysb44j2ja
 TQWUEU5KWpPr80ArwSkvvN+yqaLIjwyvCcjpD22d4ZhgNpDECErd/tmv9s3+cKA4NISA2q3Q+qb
 DZvpotDQmUSMuYHySq
X-Received: by 2002:a05:6871:8795:b0:447:7f2a:baa7 with SMTP id
 586e51a60fabf-451f12294acmr84761fac.16.1783709970685; 
 Fri, 10 Jul 2026 11:59:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:29 -0500
Subject: [PATCH v2 13/24] clk: mediaTek: mt8195: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-13-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nWyypTMzg6/FhxRE+e7ULXHE/QdVrjdX07l1yq1NEcM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUCuQAsdPrDUNpy8MB0SWFVMADoTmK2LvFIf5
 XR6emCY4XOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFArhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABtkIAIG7XWyhX/8GWh6nbnB06XSMvRgY33p3El6tBcP
 bZBErwqTgLzqeIpBPSkqKjqGtu0q6/FuEDZesBG3vuNjHgEKxFL8I/1h5acTUtzgjQYx6g9270Q
 q5w0abl7zm9p8mv5ZAE68DZ33VrvI7/sPJ2O9DmteMLxEAO9Kjk1KUnr6j+ngTKE3f4RRZLnn2w
 JMRWFh33wctAOcfQXxd/fGnXBQEDGJi5/ZmGN6viafJl98tyy9Kwwwrvr9lS5KOsHVdp3Nb5YVa
 VDGUF48UMbDl3ug+sG5cICtBBsPt/9xXMt9gol6NgwEa1vh9UY8oikNTPPylKuM1NoQnmpjoIe3
 6wng=
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

Add clock tree type flags to the mt8195 clock tree structures. These
will be used later for parent lookup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8195.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index 37cceb5f32b..3afae4d725c 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -101,6 +101,7 @@ static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree = {
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
 };
 
 #define FIXED_CLK0(_id, _rate)	\
@@ -1423,6 +1424,7 @@ static const struct mtk_clk_tree mt8195_topckgen_clk_tree = {
 	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
 	.num_muxes = ARRAY_SIZE(top_muxes),
 	.num_gates = ARRAY_SIZE(top_cg_clks),
+	.type = MTK_CLK_TREE_TOPCKGEN,
 };
 
 static const struct mtk_gate_regs infra_ao0_cg_regs = {
@@ -1635,6 +1637,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.name = "mt8195-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_apmixed,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8195_apmixedsys_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_apmixedsys_ops,
@@ -1645,6 +1648,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.name = "mt8195-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt8195_topckgen_compat,
+	.bind = mtk_common_clk_parent_bind,
 	.probe = mt8195_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,

-- 
2.43.0

