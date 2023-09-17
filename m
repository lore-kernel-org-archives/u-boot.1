Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9064CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A65D86A28;
	Sun, 17 Sep 2023 16:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FisqnWMr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nGdwqgaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE1C986A2F; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5320586A1D
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVH90gLQz9sb5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIfVFvI1iv/tWGX8u3nZTuUgwauHbu6wpy8W+p8rop4=;
 b=FisqnWMr/wAYwTHm/tLFJMTteXOSX2epCmPx3Jbcldrn/ilfq5lWFqyB4JuCxEfXOVSCh5
 Wmb71XwzQFOEeaf0wwZ0Gm0OKVyVK9KO5c9gQqn/TCOFQxVJ4hTfw5djcjKOqKxBUymv4X
 10S4DraTRo+3P9TVE9kwh2/PkatcVEi/dqD/B2Bc/hItmasf3R3xCkk7d9K7YBdal2zt5e
 Bm0hBKH3fgOZ5xW6sxYvo9M2NFqZRgCK4jpEOoObdPIR1HLCml/tAwykEUNiinEAoQAK8N
 5UaQliUHPnLvvjSffaKot5uzwjH0k0ei7WEVONp2tIE3Fyn6UJQQGivtgtkaCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIfVFvI1iv/tWGX8u3nZTuUgwauHbu6wpy8W+p8rop4=;
 b=nGdwqgaQrQIVbhJy07r3qe3xTW6n93DhkBcLXyY86NNjtPjun8gVv7NVMzGwfkiJh/EqpZ
 w8SoVkj9j5wxvcmPG579Y38aeimEPnTjkNqonydo7qW+JCXwIkLepXvdeXpHz2DOY9ClTO
 WK2t67iHSi4N28ShyaH8Q1mYo0J/jf5uXNg5jcU5lh3C9lL5V5f/VmfgDlcXquTnCmpO1/
 lzJlIzTD1gZoSu/EptjdMzz0Cjsa9njGr/IiapXSpx5xn6LMb332L7F7bwA4lLJXWLQ1zy
 NIZ3tE9erUtmru0yQ7VST2vyxMwt11GtmDWPZR7Y9xzZh0thQsc4GP2atuH72A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/20] clk: renesas: Synchronize R8A77970 V3M clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:31 +0200
Message-Id: <20230917141141.379884-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 400ab2e591ba2e8c17f
X-MBO-RS-META: zrnkj8nsr8mysyu7otuwemo6gro8wmcs
X-Rspamd-Queue-Id: 4RpVH90gLQz9sb5
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

Synchronize R-Car R8A77970 V3M clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77970-cpg-mssr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/r8a77970-cpg-mssr.c b/drivers/clk/renesas/r8a77970-cpg-mssr.c
index f5d77df4233..32923b423fe 100644
--- a/drivers/clk/renesas/r8a77970-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77970-cpg-mssr.c
@@ -1,13 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas R8A77970 CPG MSSR driver
+ * r8a77970 Clock Pulse Generator / Module Standby and Software Reset
  *
- * Copyright (C) 2017-2018 Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2017-2018 Cogent Embedded Inc.
  *
- * Based on the following driver from Linux kernel:
- * r8a7796 Clock Pulse Generator / Module Standby and Software Reset
+ * Based on r8a7795-cpg-mssr.c
  *
- * Copyright (C) 2016 Glider bvba
+ * Copyright (C) 2015 Glider bvba
  */
 
 #include <common.h>
@@ -42,7 +41,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a77970_core_clks[] = {
+static const struct cpg_core_clk r8a77970_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",	CLK_EXTAL),
 	DEF_INPUT("extalr",	CLK_EXTALR),
@@ -57,6 +56,7 @@ static const struct cpg_core_clk r8a77970_core_clks[] = {
 	DEF_FIXED(".pll1_div4",	CLK_PLL1_DIV4,	CLK_PLL1_DIV2,	2, 1),
 
 	/* Core Clock Outputs */
+	DEF_FIXED("z2",		R8A77970_CLK_Z2,    CLK_PLL1_DIV4,  1, 1),
 	DEF_FIXED("ztr",	R8A77970_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",	R8A77970_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",		R8A77970_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -87,7 +87,7 @@ static const struct cpg_core_clk r8a77970_core_clks[] = {
 	DEF_FIXED("r",		R8A77970_CLK_R,	    CLK_EXTALR,	   1, 1),
 };
 
-static const struct mssr_mod_clk r8a77970_mod_clks[] = {
+static const struct mssr_mod_clk r8a77970_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A77970_CLK_S2D2),
 	DEF_MOD("tmu3",			 122,	R8A77970_CLK_S2D2),
 	DEF_MOD("tmu2",			 123,	R8A77970_CLK_S2D2),
@@ -166,7 +166,7 @@ static const struct mssr_mod_clk r8a77970_mod_clks[] = {
 					 (((md) & BIT(13)) >> 12) | \
 					 (((md) & BIT(19)) >> 19))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[8] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[8] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div */
 	{ 1,		192,	1,	96,	1,	},
 	{ 1,		192,	1,	80,	1,	},
-- 
2.40.1

