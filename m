Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF10FCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A59A83F75;
	Fri,  6 Mar 2026 23:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nj5k3lHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9597B83F2D; Fri,  6 Mar 2026 23:07:15 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F317683FD4
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so7070219a34.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772834831; x=1773439631;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=946920ocimbYRGwt9Z6J7BAS8KrsPBGN7KzUQOs03fc=;
 b=Nj5k3lHcTODgUbRQzOlxlW2jASEbTeL2AkgFdeL/DP4j62lzzvLCAcwHEeUll14sZ9
 GJTis+wmMvjAzWRO0NLE2JRP4PkZ96LuI9l40j83xXjQldDD9ORBh7WNvRol9gTlv/aX
 rFQ2kZpVnF6JlAhe3HcSYSAlz7ZRFunRFOmW05Ci5Jox9DDyR5qQWeLlOzJ52fnyP/XU
 I4yhxwI7K264K5NaaXlwOaSeYKbvcnbhdpUdcqmvisSLycLYbRvth25c42My7GPRoNUf
 wj/2N+Hprb5iOPUNaglO65Y8BQdUVbkmO6l0cbJSrGjk9LuioGCMBNlZLfCE5sd1mZZS
 rxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772834831; x=1773439631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=946920ocimbYRGwt9Z6J7BAS8KrsPBGN7KzUQOs03fc=;
 b=tKToZ5KANSuKoSqEbSYnoh3rFPM3+EVCpZ30XcjZ6saP2yYErguerDfcidKdu7b3YM
 S9wSxwnrMLUU6gs0eQJUMRCXIGFw1/M9M/+iupiDGcVack7HbXp+Zctb6KcNsX1eg5PM
 M2Lnlb7zXRknmFYtVHH6D0POyNPTTchXTLXj2YDN1F6gWX5KzAG52Wzb1alRYZoMHpFY
 emJAgK2rjov3n2MJ6BmzHs2WmPTy7tgcpm9relbhkTZMUY/1UHKbcMEfMcKG1Rk6NGKV
 4FqR+IGkvM74hVp3rLenezanFp7aZJs5Msg44IsS9p8lljTj9f9pKD8g21Zb5QZCRsJ7
 IKcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs/VNl6ydUYTNvjnJzMmV/dAVeBY1H7PpWNIBNl/y9Lx4k0wduDX8wl3nBCELTNJtGZBqvXBM=@lists.denx.de
X-Gm-Message-State: AOJu0YyKMFnbLugr0IVEVQArvq5KBSJaUDG5WTgBK9zv3r09lOJxhpBG
 nIwLMiC2CnkDdr3dOne3dEwumFrxT/CV6XXnKCSUKGPu2PtmqWA9nQKkqZv9p2sB6v0=
X-Gm-Gg: ATEYQzwbFufY4jG38osEJ0mOoI1FKDAlZpEfF21FxTUOu90K5/uBtQ5tLr/l0NF6gTJ
 GoJb/79QdPCaLbZnFLISyggvnvzbIFnKhK+q4xhyJuzcW0bJqtOTSEa2ofHZlsPSLDlUFNOGkPS
 mIrv70JO84PWPNNNSX3WqHy1PUh6GXa4hqQLtPG92c19VBTR7VfEsW05TpzFLIfVO/+yz6r+cB1
 LVtu21M+S4wq8rNYEkVO9hQIdM3V9guM/05iVMQS2YUEzpu5NHM42UT4R/U//bjVbh7ZOYal7B+
 jiObPlTmjwjtPaRmos7QtJMNfPk5YdHyVtIip850WCmkr+cKgVqq9ActKtrdDQMsozX6JV5N+Tt
 90iI/7Hw7VwlTqYdnfN22M+M0TWE6jJHo+P5ylOcFo1JD9yrvjaV+O8bGrrPj7ibPpT8O0nrc7n
 zxukkyzrsfL+iNljMvGq0x0BwnJMbA
X-Received: by 2002:a05:6830:650d:b0:7c7:63b6:89d8 with SMTP id
 46e09a7af769-7d726f55c43mr2550301a34.14.1772834830710; 
 Fri, 06 Mar 2026 14:07:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5b830sm1707548a34.1.2026.03.06.14.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:07:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 16:05:55 -0600
Subject: [PATCH v2 8/9] clk: mediatek: set CLK_PARENT_XTAL on fixed factor
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-8-b253b49f17b2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BvUEENnLQoqRfu8G69wyRnUCxRgdoU8+ezQFGYPMl+k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpq0/5/m7vGh5EZEQ9U8M3WoN8DtJ/i9H7xZWP1
 rEG7lstBvqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaatP+RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkZIH/RU2sNr3B0JhWi6vsZchTNjCM2hcJQSJtPg5mmI
 7tMcoUCWieq2m8S8zeb1zGej92Can1/WAU83IHwy6Zbi2t8x/YKTu3STKJ3okaR1lMxRbXzjvX2
 SBlrHqKCDvyG6l6OsT+cyStDC5sUb7ZHgP4JUv/8evLFDkanGayDZR+amN9KwYpys3mI2r+szQ2
 gQgQTTvjEtxeW4gcMGO0t4xXFH5OjlvRe1NV5HQ9vcfAYY5zFqLyz7r24sH11sZ5mcwNaGyvSqR
 JDLK6Tj3EfzVHcHSAGTTuUf0xZBhQC9d1SHweorYsHkwi4PD67xFAhueze7XysIRp7ac6PGHHzK
 aPbY=
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

Explicitly set the CLK_PARENT_XTAL flag for fixed factor clocks.

Prior to this, it was assumed that clock ID 0 was CLK_XTAL and other
IDs used a different clock tree when no parent was explicitly set.
Making the parent explicit will allow us to remove this confusing
behavior in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 +-
 drivers/clk/mediatek/clk-mt7623.c | 2 +-
 drivers/clk/mediatek/clk-mt7629.c | 2 +-
 drivers/clk/mediatek/clk-mt8512.c | 2 +-
 drivers/clk/mediatek/clk-mt8516.c | 2 +-
 drivers/clk/mediatek/clk-mt8518.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 27663549928..dbacf485b69 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -95,7 +95,7 @@ static const struct mtk_gate apmixed_cgs[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 16424ba2de6..9bb2a1af734 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -269,7 +269,7 @@ static const int top_id_offs_map[CLK_TOP_NR + 1] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_DPI, 108 * MHZ),
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index b82212ec664..c675104d573 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -71,7 +71,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)			\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_TO_U2_PHY, 31250000),
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 69576304f2f..7af5858286c 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -69,7 +69,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index dac4aad61ef..9d03e245886 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -62,7 +62,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index c19828def06..e7de9d33e00 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -64,7 +64,7 @@ static const struct mtk_pll_data apmixed_plls[] = {
 	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_TOPCKGEN)
 
 #define FACTOR2(_id, _parent, _mult, _div)	\
-	FACTOR(_id, _parent, _mult, _div, 0)
+	FACTOR(_id, _parent, _mult, _div, CLK_PARENT_XTAL)
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_CLK_NULL, 26000000),

-- 
2.43.0

