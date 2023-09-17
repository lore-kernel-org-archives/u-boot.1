Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA270CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4C869F2;
	Sun, 17 Sep 2023 16:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LsHNRjpc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PlInhDjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6810C86A51; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E008C86A2F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVH74qPKz9sWC
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2mN8NlCNUu6l8Zy2K2iVFWVe6VA5GJ97NthEEEYVQc=;
 b=LsHNRjpc/0B/2QAahiOrqKZmCu9hSHg5Ee60suuvF0wJqaTUhL4JKvRxlsnQm3zk6R187e
 JeInPVJD4ofoJ1ODBDix3ooh+Nv16zIXy1PFa9TEUAwsinXdkx8nRL1xOiAb5MVrlCcHi4
 YH/YHBoKRQUDFY453471eARc1MIRavlk79vyIYLqPO5z9OCkmpfkBNb6FY21NfBz51FWyX
 19uJZBQkQhqUNRomHBaXJ53RqGM0fii9my5Tr+waQSEStueemJ88KMs5FmPhQN3Sb4uA1c
 FKYKBjiOMjMEHy86HTo8GV6W/3/wa9DI9Ws6U74CqXQPo98IDZyeFwaa+BRomw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2mN8NlCNUu6l8Zy2K2iVFWVe6VA5GJ97NthEEEYVQc=;
 b=PlInhDjZp006JOn8PdIusti3d5vjQCQJ6BXt/7Eth6JGs4prZT5JPgwWm4hjKEqv+WsthM
 F/lr+qydxwtV24oiYvLGbsrufgCqnLsYuC1iSnK5jy7KY+6JA+Pnjj0cxmQcpgXgJdu5Ll
 vQJ/z34uHm9ceyocDk9mO9c2s9CZzUSDd2wkcxRIQwVXwxF3K1LdZTfeKDCB1s0vNKrv8v
 U73k3Hej2xlZxn0vgJKrGrn6p3C79W6/Vv322z/Fv0ORLxo3+CDe/Ewt8hkLlJGKxMMDla
 NfizZ5xiZLy97E3UO8Vi/bhcuCNYZdo/9kb6iCqn8XaI6KXQrWhskND8wMsbng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/20] clk: renesas: Synchronize R8A77951 H3 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:28 +0200
Message-Id: <20230917141141.379884-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4298f77ed481a348ff8
X-MBO-RS-META: y8s1zwskegg9b7zo8bjibdwqzegkt8m8
X-Rspamd-Queue-Id: 4RpVH74qPKz9sWC
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

Synchronize R-Car R8A77951 H3 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 005f6a9ecd7..0e9b9ccf979 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -50,7 +50,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7795_core_clks[] = {
+static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -126,8 +126,7 @@ static const struct cpg_core_clk r8a7795_core_clks[] = {
 	DEF_BASE("r",           R8A7795_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a7795_mod_clks[] = {
-	DEF_MOD("fdp1-2",		 117,	R8A7795_CLK_S2D1), /* ES1.x */
+static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("fdp1-1",		 118,	R8A7795_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A7795_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A7795_CLK_S0D6),
@@ -161,7 +160,6 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] = {
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac30",		 326,	R8A7795_CLK_S3D1),
-	DEF_MOD("usb3-if1",		 327,	R8A7795_CLK_S3D1), /* ES1.x */
 	DEF_MOD("usb3-if0",		 328,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac31",		 329,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac0",		 330,	R8A7795_CLK_S3D1),
@@ -186,28 +184,21 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] = {
 	DEF_MOD("hscif0",		 520,	R8A7795_CLK_S3D1),
 	DEF_MOD("thermal",		 522,	R8A7795_CLK_CP),
 	DEF_MOD("pwm",			 523,	R8A7795_CLK_S0D12),
-	DEF_MOD("fcpvd3",		 600,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("fcpvd2",		 601,	R8A7795_CLK_S0D2),
 	DEF_MOD("fcpvd1",		 602,	R8A7795_CLK_S0D2),
 	DEF_MOD("fcpvd0",		 603,	R8A7795_CLK_S0D2),
 	DEF_MOD("fcpvb1",		 606,	R8A7795_CLK_S0D1),
 	DEF_MOD("fcpvb0",		 607,	R8A7795_CLK_S0D1),
-	DEF_MOD("fcpvi2",		 609,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("fcpvi1",		 610,	R8A7795_CLK_S0D1),
 	DEF_MOD("fcpvi0",		 611,	R8A7795_CLK_S0D1),
-	DEF_MOD("fcpf2",		 613,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("fcpf1",		 614,	R8A7795_CLK_S0D1),
 	DEF_MOD("fcpf0",		 615,	R8A7795_CLK_S0D1),
-	DEF_MOD("fcpci1",		 616,	R8A7795_CLK_S2D1), /* ES1.x */
-	DEF_MOD("fcpci0",		 617,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("fcpcs",		 619,	R8A7795_CLK_S0D1),
-	DEF_MOD("vspd3",		 620,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("vspd2",		 621,	R8A7795_CLK_S0D2),
 	DEF_MOD("vspd1",		 622,	R8A7795_CLK_S0D2),
 	DEF_MOD("vspd0",		 623,	R8A7795_CLK_S0D2),
 	DEF_MOD("vspbc",		 624,	R8A7795_CLK_S0D1),
 	DEF_MOD("vspbd",		 626,	R8A7795_CLK_S0D1),
-	DEF_MOD("vspi2",		 629,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S0D1),
 	DEF_MOD("ehci3",		 700,	R8A7795_CLK_S3D2),
@@ -220,7 +211,6 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] = {
 	DEF_MOD("cmm2",			 709,	R8A7795_CLK_S2D1),
 	DEF_MOD("cmm1",			 710,	R8A7795_CLK_S2D1),
 	DEF_MOD("cmm0",			 711,	R8A7795_CLK_S2D1),
-	DEF_MOD("csi21",		 713,	R8A7795_CLK_CSI0), /* ES1.x */
 	DEF_MOD("csi20",		 714,	R8A7795_CLK_CSI0),
 	DEF_MOD("csi41",		 715,	R8A7795_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A7795_CLK_CSI0),
@@ -324,7 +314,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

