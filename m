Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FAFC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA32084AA5;
	Tue,  7 Jul 2026 17:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="pciqVrEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB3C84AA5; Tue,  7 Jul 2026 17:10:51 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48A084A92
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-45133d2974fso166190fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437046; x=1784041846; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Q8ybHzVAiuQfrDfqfd+dyiLAkrhV/DSNbwh6P0c9kw=;
 b=pciqVrEJonBlFR1tJSZfx7LClJAI60wkIEdt7lK1vyel9avLZWua9ILxeosz3roptL
 JS3tmlNGxhX5gOXQ3ORHE9Yo+FmgIt5FgekfG9hJ0DXCh/7d2ep8LgoLLBg+/hX0ZqtW
 hpT9tJ2p97PZeQr6eb0LEfNE/t+DxpN0hgIyh8gJmIbgx3s/NG4wWC3S/amjED3Aqe1G
 WgYTqWU7X4eirMJEqyvJB18eHnTiD/3+U7FK9oqAfo8LiANnQ4KcndFmZBLcNs06me72
 1CWyJltQd8j26zE4s7nuAg59D3Hk8dFY9CbkYM2tK19AsTuggw2hd6h+XDrK7NmGXPtI
 ehhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437046; x=1784041846;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/Q8ybHzVAiuQfrDfqfd+dyiLAkrhV/DSNbwh6P0c9kw=;
 b=kHr7mbKEJppRWkRSUwrT+ugA53UpiPX1wSIsBWJ2OskAxxf0Mz0YlGtI0N+gyMKFSs
 QjZdSwpsibxf2MZtY7BpeZKCMzPlfFAIO0LfWrSHj17MXaujVl7/00WlJhdEuhu8MLAW
 sVtarDd7QDPLcf4njqo8g4uXeJb9PJLKXK5cykz95JEfgFfA8knZEQeP0/AcVlMz3Kul
 yodi/Fcfn0mLOtH1IsnQnwLSwqbbw38DrRlQYC6QQDF2pbNqBrlHk3YfgggQT0XY6B60
 3fijCCcxZWBl0MRcoK9SIblOtbHsKrgZN9dhapyFfdS4OhRCjS8UN4gUWnLQo+B4owgD
 j05g==
X-Gm-Message-State: AOJu0YxqcJ4X15iMxTwEKa7hcBsVCIkwWMGC1zHq6HfE2m+qtQpc41K0
 58zYRQepyktTYq1H/V8b46hbs/TFRkkNKSD3X1eGQua/cwQYM7MFKGvlOgUozEhkzqk=
X-Gm-Gg: AfdE7clWKUc4sm1sY8rR49bUZD7wO1Z4qvp7WK+vkqIqDHFSQZBAIDcvz5Jauqk74pM
 4Nh7wKbGiOh0Lugub7fjZg5IJcsIou+k466Cz+9vVXKH9fF5u0/xi53WEgcHvBuVfwaLmizscUc
 wL9EPsiTOnSl9C9ESqG19qtNKS1dsczWX+R4/Ce4MXSIV2acv8WVXK00fbwBzKhHuwVm5/I8XWY
 gzPbv+cvJVGJuDlAlLjascvp3n3RBniVcRLMf/rWLq9NjvIyMWoDaO4m5vDs9zO2FeL8Gyn4Zwh
 uY/GeY2fwqginZ1lHGpQFWdYlHp5BI9EFuKpZJaRR0y5dSTKTrH5zLjhJ/IA1u+Zf/B0ZbbxmLO
 qvQqw4FnvcvX+3b85/N9F44w5QeXx9vn1hzs15aYFvLUjaUfZUElKfAO8MovDK9uCtrSDrrGUTw
 t2RQ36JOPK9O8X56HD8w==
X-Received: by 2002:a05:6871:660f:b0:448:558c:d831 with SMTP id
 586e51a60fabf-45105e098a5mr2855782fac.42.1783437046316; 
 Tue, 07 Jul 2026 08:10:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:37 -0500
Subject: [PATCH 17/24] clk: mediaTek: mt8518: add clock tree type flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-17-65d24cc0d569@baylibre.com>
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
 bh=ueP3OeA5mjc+9YoZkNGGOpeAnARunZOhyhdWJEVcSxg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRajCkzpn4LfZ8ZGQ+SbEkxHAccTaQojkWfZ0
 uay6mA8p+2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WoxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABVMH+wcPx1OHEYVVJfZYdUHsIu1oprhucjZZiPJMalr
 h5kjwWbHd1qa/EQWuM+mDxMQZafzVQFd/YaayHavzznLkVDF/3iVU7MyAuZneFlh+eknpxDXXqg
 BieGHgOqIdtOI8RvqHYWAEaEPaCIjg4LANdn1R7CcwbVNs+LcJVJiyMV1R/t1bgtwH+svh4DSlv
 cO/EiWII/l0gXqS2dWYiRAx8V35srVNSggL+1MlMtk7h60gE1p3Wzq6auwAGW4BjyT+or0BZV96
 ryBeAIcrbY0rUpaV1BkIrt2J3s5X3Z0GuuF2/Mx0Inr/WpU1IaL3sxDH0GVtsh1MUf3LfI0y8VM
 Fzuk=
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
 drivers/clk/mediatek/clk-mt8518.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 2b213e720a0..972d634cab7 100644
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

-- 
2.43.0

