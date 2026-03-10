Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E3EEB1072
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A87684179;
	Tue, 10 Mar 2026 16:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bZc3re7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8598F8413A; Tue, 10 Mar 2026 16:34:32 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528B8840D7
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4671cbce32bso369277b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156869; x=1773761669;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpgaLML8+fqghPKVaFwMKGg6yGZThaTFsocawa38Mk0=;
 b=bZc3re7CdZGye+JTvPXLrWukozV5mYsEIeQB9GP5VglB3q0qKpjtg00PB5mWl260bi
 FXGZhp252bazBL4xuVOmYU36eBFSAq/CQ/iuz9FFvSuWc7tBCxZIEe9KqztXL3gIaM1Z
 TKQativJL7kD6xQasRg8xSYtqV7cE3Q7In+0LM2gOydbeyw15tCPuhkNCLyrRuYgcG6J
 OEJCUYUZYSkoTq3gVjvlVRrzHqXVQxZd5aTWVEyvMA0WqPjj2TXiELDdMAltgK8UvwJX
 v7kjLNpWZYNatEJVLyF6L4WWfg20uOUWmiJFFfCxNG4tGtPXs9HSNSwAINwwfOXQb11Q
 8BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156869; x=1773761669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YpgaLML8+fqghPKVaFwMKGg6yGZThaTFsocawa38Mk0=;
 b=sYgFm02aIw7cEeVDnlepVvsyh13/x+jhueJU18VCfOGZC4+iod0lu4eV3W5MP1i7xr
 Ld5k2SRKFk9GdoJ0Qs1/Qv2yG1xlV+ftjDsqhf3IOQKMOUgWC3e4q/LNQhfNp6WMmu3W
 ZGXjPp/0nIgC17PIDPI7LwO0Y9qXBfD4pmcz+/0Tqcsb3d149fAfumxkdnJ6Cq+6Llmo
 jv/ma9xXtqugqI44SNn3qA4mElgBBCtiMdmcHaGY4lnL2RuKfaoWksenNdTTmbDHeP+g
 el5Yk8scfi0FDzvj8yeqJks2r6ZJ/Tia4mpn/mqVNwJk3MQ3crjqOjMOtfCL3bQD4HVM
 640w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyHxJZ1JDp+6ZSNTEJH5MLUnT23UhjOvTAmvVwTiGjNma2pp67wrwiwSRZ1+ouE86NpNRfs8=@lists.denx.de
X-Gm-Message-State: AOJu0YzqI+3y6isDBLtaW8Q1//+Dremq+zxht9XGv1hLBJ/JPAW/5K4Z
 N5d8oo/xAjYY4j0BzxdWeX9kZkS/V04jEIXq5dJI/TqrWzD8n744gx6jjDtjG0MBfSg=
X-Gm-Gg: ATEYQzx4KnPCFWoQMJyf0m7Efey9bhxDVCqxPxLXZGTg4/QB+TEdvJPs4DbE1B9zjpR
 18UTH5nmm46Ys+CyYSmaklsq2d7qm1EzhbjfAS5HHROhR6s9YkIwGz9Ii+Ttte//GNpPSpXZgkU
 ZluOCy1Z6GuBtn5nJ7/t8P8Q7omFda7JrULguqljbgfiin3lX7OE9+n91+NQbSEVdJlEamhb9Gi
 ElqZvdYE/tGuQwRGvWyIM5cbd/ip1CoYgBsCnVIiHycUsI3uXvPBnBx9SH29gkr7rAoWcWJ3QS7
 bzrpTQb4E5s67M4rbi1hhlj30w3LnoMQXeLHCcYyZ0/nBgmtbHwSRisRfAAN1PtzMa2a3ud2B/n
 SBxDna5R2XieLFVTkkwaDjL3fcly86sfdJHGpwim36zbZJT/RSQF4DDSdnOyCtI2456fY71M8cF
 5mGxd2NxZorO5fLVPit/Nm+5rYqUjf
X-Received: by 2002:a05:6808:1710:b0:450:1d1a:5d9c with SMTP id
 5614622812f47-466dcbae17amr7386183b6e.33.1773156869050; 
 Tue, 10 Mar 2026 08:34:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:27 -0500
Subject: [PATCH 14/16] clk: mediatek: mt8516: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-14-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Np2L59SWHO++Mv51ernkdsgW0zwnFZyQmZqCjTT6cRA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnggeXuiWMRhp5azeZNB/gAi5ecoKAlTSFYu
 jGz+LtJK76JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA54BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmBAIAJPaHtTdtP6osCw6kXiScmmYVQDwYs6rcOq8388
 81yGdxG/cjGC+d2hhLiYc7QnYhf05F1e7mRh1dfgZHjVKWeR+xAdpNIbu+pnnak8lqFdGOnFe9c
 2HctKx8OhXaD/+75SvUflmNvdQbymq6klHxIttbO0zs7bp7Hv8PCIOY2v2zfOIKXt0TcTYEy+8t
 qrlxNS3ZVk6bnWp7jdR+EI8UjviAiB66Ep/yPbbIjaniGse9lhkMhyk8xwrfQx0ouEDOWIMjwmi
 ZfD7Gi+yLaezYyi+lBtB5quht8BvXtDHqkUayFbex+EvBEiW+PxjPNTWmw5ocwJYfETUluGzX/C
 5flo=
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

Replace all uses of CLK_XTAL with CLK_PAD_CLK26M.

This avoids declaring the same parent clock two different ways and will
eventually let us remove CLK_PARENT_XTAL completely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8516.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 74966051b1c..1070dd1551b 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -58,7 +58,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 
 /* topckgen */
 #define FIXED_CLK0(_id, _rate)			\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 #define FIXED_CLK1(_id, _parent, _rate)		\
 	FIXED_CLK(_id, _parent, CLK_PARENT_TOPCKGEN, _rate)
@@ -70,7 +70,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_EXT)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
@@ -117,8 +117,8 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_APLL2_D2, CLK_TOP_APLL2, 1, 2),
 	FACTOR1(CLK_TOP_APLL2_D4, CLK_TOP_RG_APLL2_D2_EN, 1, 2),
 	FACTOR1(CLK_TOP_APLL2_D8, CLK_TOP_RG_APLL2_D4_EN, 1, 2),
-	FACTOR2(CLK_TOP_CLK26M, CLK_XTAL, 1, 1),
-	FACTOR2(CLK_TOP_CLK26M_D2, CLK_XTAL, 1, 2),
+	FACTOR2(CLK_TOP_CLK26M, CLK_PAD_CLK26M, 1, 1),
+	FACTOR2(CLK_TOP_CLK26M_D2, CLK_PAD_CLK26M, 1, 2),
 	FACTOR1(CLK_TOP_AHB_INFRA_D2, CLK_TOP_AHB_INFRA_SEL, 1, 2),
 	FACTOR1(CLK_TOP_NFI1X, CLK_TOP_NFI2X_PAD_SEL, 1, 2),
 	FACTOR1(CLK_TOP_ETH_D2, CLK_TOP_ETH_SEL, 1, 2),
@@ -745,7 +745,6 @@ static const struct mtk_gate top_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8516_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),

-- 
2.43.0

