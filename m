Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60470C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0840A84A4B;
	Tue,  7 Jul 2026 17:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WNSv1Um1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A5B849F0; Tue,  7 Jul 2026 17:10:40 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A8184A04
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44cc65b0a7fso549105fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437037; x=1784041837; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1eQBbNSp1tleD8bPGUwqveNJSsRdvspgz4fwXiQFh1k=;
 b=WNSv1Um1FV4+I8zFjb7nA9u887UwYycfUX4ThlkzrKNgSIPfahyjBgVmNsbwKOfAYC
 FrzO3cUbXuPrEUfft0O98FymiHAiNMjd5zk5w7nwmQGk5ZYbBzg+eYw+n9JTJgb74EHA
 Ni9pEiNEuqFni0tUXFSsXQYUUHBAW0DdWY15T9DHT+IaKRrnNebiUUjNb+rJehnl+xfO
 0yHhpWjpeII0AI8QTQRor0wC8WFBJwePqUUR3x+SvQeMkZClw0ytbz4qrUkEWB4Mdm65
 543Lrl+TrqeQsP5zcX7rfhHIf/Ay5boKNBxojaIex6YGGK1IiqZrA9fLHu77YISBAkk9
 h4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437037; x=1784041837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1eQBbNSp1tleD8bPGUwqveNJSsRdvspgz4fwXiQFh1k=;
 b=mLUaOW1ItADkVrgsP+0LmKZQJShzmfUDzLU59uWxnbUs9ShRrmgrmTZ/FIvg9yzPrV
 Fs9pfPN8pfDr/TyimaAEE6vQx5am1J1GsCITfrAkQUfz+C1zi75FBQFRokVV/mZRYOBg
 gxWRlPO4koSTBXU5HyPUjd6F7kmR2RqUZqw/VDu7Kyz74ZYIX2FZ+Yrp7b57gBEJ/f03
 Bz1YryBxMDOnvZbdHeauQ+q2/Mut9wdun1OPXYEdlkNf4b73cip0/sg1Rd7EY3ji/afX
 r544YqGCe84Y2FT1Zhn4QR2boJxyZ6gxWDibEZReNm7Upn9fUDQe/69/D/bCnHhK9YFD
 /LNQ==
X-Gm-Message-State: AOJu0YzTsvzUxjSb0XzjTBKKjOzlYs4q46XvXlS1K7OI4N1XHMocvGL4
 gJpa3H6Qy7IVZG2Ipw6xE5IgE6ncWLw8aplV28Apj+5OIz7J2D7qgpD+1h9EucJJXMw=
X-Gm-Gg: AfdE7clYtdQTuiU6nHMGpPrdzvN1Ddo+ThLRALGOvZge0ss1ASxA+5xMkvuk2b/gS4k
 QhVYXSiD1SIg/vRnAiszKAuhVrZ7Bh8feYOdnjIVNXZixZFJqGOo4y0FxFvM83md23YFKyY+mCO
 fN990lAV/0Zi2J1iIK2gtteWYHb5CbhUuHknAjbAiBXKi6nA8sfQOJh4jwm3wxdaQfX5HOmiJos
 oxAxeyK3LWfg4a45Rxe3+aqxTprmZKBfX7sNwbbjFB7VstdAVndfJzklnoulNAKJ9SYz/FJ16wB
 7jqwSSFeB4jOssPk2tqrcUy7NUq7C9AOOgmyzmkZnrKhuIPU97URgtbe15domRL7u9EaWnlxMnV
 Rd1BR56b2CWvR76bjVqfwMpPTY9YIxndwUaQgQr+4gMq+zNmCpzimfHvUVXz38aoKaNXqeKbkOD
 flNM4Fn5R2s4iVI7BEYEGlGrRRUF5D
X-Received: by 2002:a05:6871:550:b0:443:1de6:beb3 with SMTP id
 586e51a60fabf-45118932cc9mr1808061fac.5.1783437036717; 
 Tue, 07 Jul 2026 08:10:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:30 -0500
Subject: [PATCH 10/24] clk: mediaTek: mt8183: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-10-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0QXas2xmuASbsy2Td8J0fAfH+y5aX6xh/Gb87iWIYfY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRZzqBn68xtdQfWLlMpozkF745jJeLZdFMNmW
 UypuKBLRG6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WcxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ase0H/jIwda6Squn808clvkPEZEf30s0ISg7N/6KS0ND
 kQrqkE+XfgpnSCC7I3d3aeSSGuz0FMuUotf1pO8z5l/CnhIDc/syiukw2l99uYEZS2Elr07NQrO
 /gjnXy7EJom+nBDnuTLwA4o4RdL9S3gr6XaUlWBZG0YWywZAs8xsMlVHVnrXgAgXm1Q9WFCoijN
 WCXEPQmYbr78Q/BtTUfS/VmaLbX4xYqsgNHv8mU26I5TGGLCTM08QWeUdI5G/VMwBlBcTe9tdOa
 1n3pExweejoXxrBOLQaFwSX6XofeHimj4vxwxjeoT+VXZM22r/7ZOO96cV0rcJYT0N+/lY+fb1T
 PWVM=
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

Add clock tree type flags to the mt8183 clock tree structures. These
will be used later for parent lookup.

Clock trees had to be split now that each tree has a different type
flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 7b2d796bc6c..5e4b45a57be 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -604,20 +604,32 @@ static const struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
 };
 
-static const struct mtk_clk_tree mt8183_clk_tree = {
+static const struct mtk_clk_tree mt8183_apmixed_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+	.type = MTK_CLK_TREE_APMIXED,
+};
+
+static const struct mtk_clk_tree mt8183_topckgen_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.fdivs_offs = CLK_TOP_CLK13M,
 	.muxes_offs = CLK_TOP_MUX_AXI,
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
+static const struct mtk_clk_tree mt8183_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 static const struct mtk_gate_regs infra0_cg_regs = {
@@ -782,12 +794,12 @@ static const struct mtk_gate infra_clks[] = {
 
 static int mt8183_apmixedsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8183_clk_tree);
+	return mtk_common_clk_init(dev, &mt8183_apmixed_clk_tree);
 }
 
 static int mt8183_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt8183_clk_tree);
+	return mtk_common_clk_init(dev, &mt8183_topckgen_clk_tree);
 }
 
 static int mt8183_infracfg_probe(struct udevice *dev)

-- 
2.43.0

