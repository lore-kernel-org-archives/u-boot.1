Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CFDCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C1386AC6;
	Sun, 17 Sep 2023 16:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qYxfKhgG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V+xYVctm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB45086A33; Sun, 17 Sep 2023 16:12:09 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A345D86A28
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVH92xVzz9sTr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0hGeU8QRvQEvtchRnH1QsJBOi3m8iP27nyGvtbhuA4=;
 b=qYxfKhgG35WgP6Q2QTpe07SauopCNQIxRwzNKkzlsGeiMS6N2dno1cz2dJ7Fi5O0D1xgap
 wldXHXDdvZr+jejmi2xXMA06dUCcDpOoqgl39wMZwtGgWJxrFSRB3wixaFr6KOrUb94fuo
 Op9WIA1hQ72dVWGZEK6IAy/Zu5NEKxmVQDd/c+uAtTZtqwxFh4Lam8ZW328kza1Vbpzl7f
 vfz2dX3SyB+h2zPxMWfvORGpEfEoEJK5avKbCSOEQkKV5e4O47oL6b9hg+u2ZRsh+L2he8
 Z2tFBBUBTsMzDtiTokCZyOYYZeFZ2cG/vWROnBG2Q5nHPBlHyyJTHFYw/31rTw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0hGeU8QRvQEvtchRnH1QsJBOi3m8iP27nyGvtbhuA4=;
 b=V+xYVctmbhZqWUh8taxwppFaGfTKtvrvx2Ljv1VPSC9ttCSIFqAyn5bmWcCrnxNlhiUzNT
 jDfJJYGZ0uD7wKPbYpfZ1lTHfFEi/pUwOKTfxfD3f1FQaxMh5DFhVjsiRkl53AsRWWBAkU
 kXROeBRgbtlHhEbGRgdjF8y0CozOpeB8IdBdm33nxrq5/icSw2P7NVseMn6Z8SsAkEyBE7
 YjrNeWv4BgjruiC291pvbPKLDa/4gJrEVKJAD3kUa9HD8YkzJjGBPp34jgJZeR9XqFubeT
 /9BtF4faAcKU1HIro9rNqu1myJ0WSaxEcVKb3weVskn/g/u6vZzElrGhPR3hfw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/20] clk: renesas: Synchronize R8A77980 V3H clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:32 +0200
Message-Id: <20230917141141.379884-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d37b146aebaef26ad27
X-MBO-RS-META: 15softqsgexa6xgoksudc7ergywkxw6e
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

Synchronize R-Car R8A77980 V3H clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77980-cpg-mssr.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a77980-cpg-mssr.c b/drivers/clk/renesas/r8a77980-cpg-mssr.c
index f29727ddb90..f35032b95f1 100644
--- a/drivers/clk/renesas/r8a77980-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77980-cpg-mssr.c
@@ -47,7 +47,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a77980_core_clks[] = {
+static const struct cpg_core_clk r8a77980_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",  CLK_EXTAL),
 	DEF_INPUT("extalr", CLK_EXTALR),
@@ -71,6 +71,7 @@ static const struct cpg_core_clk r8a77980_core_clks[] = {
 	DEF_RATE(".oco",	CLK_OCO,           32768),
 
 	/* Core Clock Outputs */
+	DEF_FIXED("z2",		R8A77980_CLK_Z2,    CLK_PLL2,       4, 1),
 	DEF_FIXED("ztr",	R8A77980_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",	R8A77980_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",		R8A77980_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -110,7 +111,7 @@ static const struct cpg_core_clk r8a77980_core_clks[] = {
 	DEF_GEN3_MDSEL("r",	R8A77980_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
 };
 
-static const struct mssr_mod_clk r8a77980_mod_clks[] = {
+static const struct mssr_mod_clk r8a77980_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A77980_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A77980_CLK_S0D6),
 	DEF_MOD("tmu2",			 123,	R8A77980_CLK_S0D6),
@@ -149,11 +150,27 @@ static const struct mssr_mod_clk r8a77980_mod_clks[] = {
 	DEF_MOD("imp-ocv3",		 529,	R8A77980_CLK_S1D1),
 	DEF_MOD("imp-ocv2",		 531,	R8A77980_CLK_S1D1),
 	DEF_MOD("fcpvd0",		 603,	R8A77980_CLK_S3D1),
+	DEF_MOD("vin15",		 604,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin14",		 605,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin13",		 608,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin12",		 612,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin11",		 618,	R8A77980_CLK_S2D1),
 	DEF_MOD("vspd0",		 623,	R8A77980_CLK_S3D1),
+	DEF_MOD("vin10",		 625,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin9",			 627,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin8",			 628,	R8A77980_CLK_S2D1),
 	DEF_MOD("csi41",		 715,	R8A77980_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A77980_CLK_CSI0),
 	DEF_MOD("du0",			 724,	R8A77980_CLK_S2D1),
 	DEF_MOD("lvds",			 727,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin7",			 804,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin6",			 805,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin5",			 806,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin4",			 807,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin3",			 808,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin2",			 809,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin1",			 810,	R8A77980_CLK_S2D1),
+	DEF_MOD("vin0",			 811,	R8A77980_CLK_S2D1),
 	DEF_MOD("etheravb",		 812,	R8A77980_CLK_S3D2),
 	DEF_MOD("gether",		 813,	R8A77980_CLK_S3D2),
 	DEF_MOD("imp3",			 824,	R8A77980_CLK_S1D1),
@@ -172,6 +189,7 @@ static const struct mssr_mod_clk r8a77980_mod_clks[] = {
 	DEF_MOD("gpio0",		 912,	R8A77980_CLK_CP),
 	DEF_MOD("can-fd",		 914,	R8A77980_CLK_S3D2),
 	DEF_MOD("rpc-if",		 917,	R8A77980_CLK_RPCD2),
+	DEF_MOD("i2c5",			 919,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c4",			 927,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c2",			 929,	R8A77980_CLK_S3D2),
@@ -195,7 +213,7 @@ static const struct mssr_mod_clk r8a77980_mod_clks[] = {
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 13) | \
 					 (((md) & BIT(13)) >> 13))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[4] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[4] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		160,	1,	160,	1,	19,	},
-- 
2.40.1

