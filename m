Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18EEC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A7684A78;
	Tue,  7 Jul 2026 21:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="S9W7lSSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DE584A1F; Tue,  7 Jul 2026 21:12:09 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B070D84A5B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-48a0ca07c38so2814467b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451526; x=1784056326; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qW4Qn5b8RD8+Ep7zGBqBrZIfcU7vUvNxt1ieKVWrQYk=;
 b=S9W7lSSjj2S7TdmcVthIj/kV5msVOgMZC4Fup9z7XvJYi4Fi+tNME30X+DItiGnwmh
 iRLtVh2ktW0Rk3md5PyVJaZku8UW60pP/8EMyTmD4OGQwdrW1bzIY/pnIvfMw4QNbOMj
 UFhJyVxGYNreNqGR1xdNAyK4K3DgnTNCwk8OUzZTzI1aj97OpvVK/BOSOyLNpWh5Nx8T
 +yDqQ+sqom8igy2Tiofps6g493m4flkILOKSxS5f1FqmwFHJA9MPLYK/6g8Wqw0669y5
 Bie1t/NytxOfHoIST9+AwV6PIb5+LlE6rZKMJaNvskSoDnFldgZhIWHh43Wn1xmd1x+J
 5z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451526; x=1784056326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qW4Qn5b8RD8+Ep7zGBqBrZIfcU7vUvNxt1ieKVWrQYk=;
 b=FDqLhVs0PceaS/snQDKenIjvQSVBxzE6UO3NRe+YKwQqBcH3jiVh0e+35yNtWVc+5A
 pG51lV7v3uyIsUl3F9bTdTH6FOjNuspXsJL0C2ZEJyiA5rAHRxuAu0pQcloi9uAbiTIC
 b4nHHBtO2RDprfqMTg4BUC6F2aJ+osoNE2AI4+RXtmULHye0BckhpxxvZD7OsSUk9Crt
 bxClICaFYdXwJQPxPjNBjDKbty3FhiAxK/US0eEvzza5SCwCrQuDUeHau+lNIa5X0gi0
 PPwQWz3H5XPmLiWX9FhvciP2VBhmotktCu4ETvDYYomhZypoYRk4t1ZctnhiTT89s0tN
 AjLw==
X-Gm-Message-State: AOJu0Yw8Ffc96bZfR47nfE31MZxgvqXyV6ZpzY0qp//0akuq1nKILesU
 teWD4OMMNlNKDF07PeiCKoptjvquhYShLY3OxEBFWkGXAHu7ayJJe8s2bw+8GOMXCGs=
X-Gm-Gg: AfdE7clILgKAYYAwe8z4dRuWwoS0/FigAxhWiMPqiyerZUcua+bNuVkK3kiNs/pFEnL
 ELf7Ul00MuTL01pV6c1954HA0Xy5eEkb6wxEqirDwxo4YP9x80yCbHgpqZxm2LcJRB1/b6uTtlX
 sVVbLTxIuk+QGrWry3Bi4hTgzSERCkhoM0AmYb/DUYX85GZuA59AhRqw79qZIESW0UTHpaDioEC
 cPgt7TJHPTJkuFbW4lnAycyc+sGWEQ4O10jfRo4kB5H318XGJDilY99eZ2zek7rd98MKTn7pG6A
 IMjYPDaK8r6/nh7tiuLkT4Vcn4hNCePQQB90dujPaSnyn8d+vf+KNe5Me1iXs80of2RupZrSBuf
 oNJBrbdOmJnYE1v5ywsg6crYGb3PfP/TO/0Wq+A3FcWj+rZd5xKgpwq0HGzDqxQLOnfdXXdDj+0
 3UgjERPo30Z4IaPypaTg==
X-Received: by 2002:a05:6808:3097:b0:493:e2bb:2eaf with SMTP id
 5614622812f47-49fde902d16mr5313962b6e.39.1783451526491; 
 Tue, 07 Jul 2026 12:12:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:09 -0500
Subject: [PATCH 07/15] clk: mediatek: mt7988: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-7-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3zUM0F5lJFAekOHylXHlaDZEJbnwtQJtAUMdAiZLaWo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8/aYYViWUwdauYKylzqPrHzCyWGFOvt83y2
 k4DjiEI1BaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PPxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ArIIIAJhC+1OZ+zkDnKJ7gGbU1qWRVWozt9lliWv80TM
 AIZoxpZgKbNpvq/NqTFx6sxlsITGRovm56MFJK/bvjWKM67wSSky2WDXw6qSUfePS6hCLBx6skK
 e4qa6cEabguoe+NkaUXEbT6dxY7VyYdTXNS4JJHLn0ax4bZDbCvj4CAnNYtHrSY0oeRa6bo7T3+
 q+7h2SUqkvQQnrKXsZXwJbX4bmyWN2f+QFA8cemNL23v+BSI76Cdnttc9aGBGkMV81oFORqPbem
 qDldC13Kit8XsrohWWW5gce4Jtfo3TSQvoTuk4YoMkIUDfxfZpQQscYkvUhlhSXV/WzCUOif0Km
 UmYQ=
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

Change driver names for MediaTek mt7988 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index f4a3d40f5af..2b2d5db90b8 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -871,7 +871,7 @@ static int mt7988_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7988_topckgen_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.name = "mt7988-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_fixed_pll_compat,
@@ -881,7 +881,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7988_clk_topckgen) = {
 	.name = "mt7988-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_topckgen_compat,
@@ -901,7 +901,7 @@ static int mt7988_infracfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7988_infracfg_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.name = "mt7988-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_infracfg_compat,
@@ -956,7 +956,7 @@ static const struct udevice_id mt7988_ethdma_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_ethdma) = {
+U_BOOT_DRIVER(mt7988_clk_ethdma) = {
 	.name = "mt7988-clock-ethdma",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethdma_compat,
@@ -1002,7 +1002,7 @@ static const struct udevice_id mt7988_sgmiisys_0_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmiisys_0) = {
+U_BOOT_DRIVER(mt7988_clk_sgmiisys_0) = {
 	.name = "mt7988-clock-sgmiisys_0",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_sgmiisys_0_compat,
@@ -1047,7 +1047,7 @@ static const struct udevice_id mt7988_sgmiisys_1_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmiisys_1) = {
+U_BOOT_DRIVER(mt7988_clk_sgmiisys_1) = {
 	.name = "mt7988-clock-sgmiisys_1",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_sgmiisys_1_compat,
@@ -1107,7 +1107,7 @@ static const struct udevice_id mt7988_ethwarp_compat[] = {
 	{}
 };
 
-U_BOOT_DRIVER(mtk_clk_ethwarp) = {
+U_BOOT_DRIVER(mt7988_clk_ethwarp) = {
 	.name = "mt7988-clock-ethwarp",
 	.id = UCLASS_CLK,
 	.of_match = mt7988_ethwarp_compat,

-- 
2.43.0

