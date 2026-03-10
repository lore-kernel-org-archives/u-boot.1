Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B2CEB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C418284171;
	Tue, 10 Mar 2026 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z/ZW/Jfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD4638410C; Tue, 10 Mar 2026 16:34:31 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E860C83FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4670676ba03so861239b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156866; x=1773761666;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9j9icCyCxNrLkivCYntGaDGgO1BuKBsiYYlKM8iuuo=;
 b=z/ZW/Jfw13D7e2rQI/cUhvDuEF/eigfoG42HP24KJBsoLz4CgaWOqrTy5qjxiEd4xw
 ouqGW7dkIHa9MHYEHFvlmse6UGaYaLKD0CagblQPj7cycILcufkJVJAb96HMgkDFP+3/
 idjeAcmSiUvNBga7RZZbi8W/y0+J2SVlShtz82orJTHdVpnHTH1xKRMRTWqOH1PuAztz
 XQ1pIZmDmMscAdlwxNmaksH94AJtTfjMRoo+AcbuTOp1qhRidqEpR6Mqo7HEQRHPW7J+
 /6VDeCD5lDZT4Yf2fZKM457QrcTpBiEgxPAiJCHFZ8z9MQk2OO+NHRnDYtjlgNRzq1Jy
 9JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156866; x=1773761666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I9j9icCyCxNrLkivCYntGaDGgO1BuKBsiYYlKM8iuuo=;
 b=GypZ1YUoPJjXlI5q3XWWWA/6Ll5ExqylZOrPiUHWcGuONOu/pF+hard663zzAGlFK9
 4zrv9O9fvjhVQv8vPzGUe2CIYrnzFx14F/dIhPg35gR3+v6/bzyfYCTe66AXK2XXMWxE
 oXb469yTwcmH9+NIE3d9VTZF6pvLBCy016ir+pp1MaI07195Gq0ac2XabOyL8aC+j3c+
 +xjgVcXmv8N8UOn9x2unKKEdH1Y6tQMa2bn9tTpy00L7QOmkRzm7yquuSy8kJZqJV5aF
 xi05AnUUuLXScjNQ3LPvtLUs1aHyR+5aI9ZzDvJ+f8+qtOLCgmoZHB19STWvKTe+z8ze
 TL5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFCChQZFaXDx5j78AHIeT4Xawvs4Fir5vDID60iVh0inwwP3xq4ksJkryomITSV0m6X/3tOs=@lists.denx.de
X-Gm-Message-State: AOJu0YzUuy46ky1YyzYa33/0qGJkOcK94MUf0mM4nroWIYAr3vldDoHS
 /JGwZQ7g0FwjZfISXSdgtn14wiLEQOMMBaQlyCj3LHNmRcZiPwhYcHpRZoVhFAa07y8=
X-Gm-Gg: ATEYQzwxsrpqi/1WnxUGshMfvs3RFpyqHdjyUPgp7WWaFXOy44uITQG/IvFbqJWuvKR
 3BXua7/JxJ8rqfTVgGaV7lWodB9nGNzaDf4XpnmE7al3ABIZ8ti/FDPQSU08SuRySos0sgetya1
 2wNn7QfZPGU/bfjDgFFVblx2iOrvfVAGYSf4ntxHA+MnfzWEfXaotVfe1v/h7abwW4XhkvB7NIf
 FCf3G7JFhniGoDXswSaMxwO2izdzp73MAY8+iUZhHrEEHIVSDcChyRwx8c7bx8KUEe1l3JAqYG6
 rHtSh0E/56WqmEdE4+Or9XKX1+lkPSMgW7+/pimtm7PjIQjDmJrJzkAI639lD7FY9R+eyVZRM8H
 yyjKqlYhIc72Mpsl0dK1tNIW0qE1vogcphEC9JmVBhTROXVBolodHSpM5UfLU8MRuXuJMFTjItK
 qgKDLC2I9XZKGd4kVJBatICkH+u33J
X-Received: by 2002:a05:6808:3025:b0:45a:8cdc:669 with SMTP id
 5614622812f47-466dcb9a23emr8228797b6e.59.1773156865662; 
 Tue, 10 Mar 2026 08:34:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:23 -0500
Subject: [PATCH 10/16] clk: mediatek: mt8188: convert CLK_XTAL to
 CLK_PAD_CLK26M
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-10-66175ca8f637@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PhcRpeb2jocrXAQqUOBQ6KTuY6mwwGg+G1s+clzj22w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnGJYCt4rxTlNV+GiIZ8tTJLcbI0zQjAJ5oK
 YfdCsjye/yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA5xhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ac4IH/1D2KgLOoYjTqfHs0WsQ290ztOyZauyY81axNI7
 j/EyCjQ9yJ7BHwBuZrfBF6uL4Zsg254P4iWYD5RVeuX0RJXHyIZXiKIKgYireOE/JmNbqO/OpSL
 MIwFAkJW8thIHSjD1ys1LM+YHx6rbaMe6LHg+EqEwLCT+0cfAcZ3LVJ88neHfaGl4/W6kqgRjj9
 yFIOQ7KY0oG+pbRWoueLHzsz1GD5bSDaarCyRs9JAMpWREotDqgZ0AxaST4RuJGqXt5mPX1pQvV
 2zgbqXZitvJRS3/WiRNpY4FiqopfjfK8Tpp21iH0ogy7EGX0vpsKW2NUF1p8IXrMk1OzVryv7aM
 QhWY=
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
 drivers/clk/mediatek/clk-mt8188.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index ca5fa8af86e..3e413e111f1 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -84,7 +84,6 @@ static const struct mtk_pll_data apmixed_plls[] = {
 };
 
 static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
@@ -93,7 +92,7 @@ static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree = {
 };
 
 #define FIXED_CLK0(_id, _rate)			\
-	FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
+	FIXED_CLK(_id, CLK_PAD_CLK26M, CLK_PARENT_EXT, _rate)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_ULPOSC1, 260000000),
@@ -1408,7 +1407,6 @@ static const struct mtk_gate topckgen_cg_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 	.id_offs_map = mt8188_id_top_offs_map,
@@ -1620,7 +1618,6 @@ static const struct mtk_gate infracfg_ao_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8188_infracfg_ao_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
@@ -1663,7 +1660,6 @@ static const struct mtk_gate pericfg_ao_clks[] = {
 };
 
 static const struct mtk_clk_tree mt8188_pericfg_ao_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
@@ -1699,19 +1695,16 @@ static const struct mtk_gate imp_iic_wrap_en_clks[] = {
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_c_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_w_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };
 
 const struct mtk_clk_tree mt8188_imp_iic_wrap_en_clk_tree = {
-	.xtal_rate = 26 * MHZ,
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
 };

-- 
2.43.0

