Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E3DCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AD986AD8;
	Sun, 17 Sep 2023 16:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Cw1dDw21";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GpBI1G5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688C86A26; Sun, 17 Sep 2023 16:12:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D045186A2F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVHC4N7Wz9sZl
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRc/5POHEjjCP9G/QD3e4+zb8YosU4M6B2sKgrhAT1E=;
 b=Cw1dDw21KzkGxMi6ovEaWHVso/NYd6mhfItY5a3XDnmbK/JEYRUPF5a1TNWQCwgMsuE5H6
 4ZZfp/6/JDwVoi1JTOwvOak2gzpbrLw8NuaVe4ej9HWReG9PRuS71RWsPO8fOjkCewMd4Y
 YP5as2VCZZdJXiZyYe1F47geQbtUVF+82M+aQq2h8opsbfTxww2trndVW3rvJCi9huZQYY
 /k0zxTd030Xzj+RuV+I8uSRdplP5BZWGKq83UJVq5wk4E2jKQhAiLXbcq+xBzn3mdqZDZq
 jRLxDuty9xWvYB40Q/Mi3tmuCoJSYZqOeprxBvpPIrEZLOo8p4ib3a+q+l8C5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRc/5POHEjjCP9G/QD3e4+zb8YosU4M6B2sKgrhAT1E=;
 b=GpBI1G5vC1fx0MllVBC2AFFFBVSa69+23uJt+1R5FGzAsxMDKfYfNl5r7tnZAMoHugMucj
 INfJp7DQzxJ8n6eqQklHXJQ1GQsTBOBBfyxAguO4mFDeo2wiRclogmc/Qvwf4etZYA3VDs
 2Vs6fjMfYuXH/0yr2lZ+VhfiBJcCcDwKKKStdyyJ4rPUjxsV9aGhFfWWeJ1gHVm02RMrrO
 Gh1C2fpCc6I47kpR4jhsMcJ35hU5ZrYmcGnjQZoM2sztykjymuH+swyc8kOM2iRpOvbUlz
 jjin2X9ZCZ4YTauAOurrdBiTMl6DeqbOoo5QbAi/AtztqRroOANxywE5HESyAA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/20] clk: renesas: Synchronize R8A779G0 V4H clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:37 +0200
Message-Id: <20230917141141.379884-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ed2b56d221b50c8e39f
X-MBO-RS-META: z9qxsiuyadyhbdbewjd41mydtyryw77n
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

Synchronize R-Car R8A779G0 V4H clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

The PLL2_VAR is not implemented yet and PLL2 is still configured
as regular PLL2 only.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 28 +++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 8625e8a2d36..219024a7416 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -56,7 +56,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a779g0_core_clks[] = {
+static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",	CLK_EXTAL),
 	DEF_INPUT("extalr",	CLK_EXTALR),
@@ -142,6 +142,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] = {
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
 	DEF_FIXED("vcbusd2",	R8A779G0_CLK_VCBUSD2,	CLK_VC,		2, 1),
 	DEF_DIV6P1("canfd",     R8A779G0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
+	DEF_DIV6P1("csi",	R8A779G0_CLK_CSI,	CLK_PLL5_DIV4,	0x880),
 	DEF_FIXED("dsiref",	R8A779G0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
 	DEF_DIV6P1("dsiext",	R8A779G0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
 
@@ -156,11 +157,13 @@ static const struct cpg_core_clk r8a779g0_core_clks[] = {
 	DEF_GEN4_MDSEL("r",	R8A779G0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
 };
 
-static const struct mssr_mod_clk r8a779g0_mod_clks[] = {
+static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("avb0",		211,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb1",		212,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb2",		213,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("canfd0",	328,	R8A779G0_CLK_SASYNCPERD2),
+	DEF_MOD("csi40",	331,	R8A779G0_CLK_CSI),
+	DEF_MOD("csi41",	400,	R8A779G0_CLK_CSI),
 	DEF_MOD("dis0",		411,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("dsitxlink0",	415,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("dsitxlink1",	416,	R8A779G0_CLK_VIOBUSD2),
@@ -177,6 +180,8 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] = {
 	DEF_MOD("i2c4",		522,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("i2c5",		523,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("irqc",		611,	R8A779G0_CLK_CL16M),
+	DEF_MOD("ispcs0",	612,	R8A779G0_CLK_S0D2_VIO),
+	DEF_MOD("ispcs1",	613,	R8A779G0_CLK_S0D2_VIO),
 	DEF_MOD("msi0",		618,	R8A779G0_CLK_MSO),
 	DEF_MOD("msi1",		619,	R8A779G0_CLK_MSO),
 	DEF_MOD("msi2",		620,	R8A779G0_CLK_MSO),
@@ -198,6 +203,22 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] = {
 	DEF_MOD("tmu3",		716,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tmu4",		717,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tpu0",		718,	R8A779G0_CLK_SASYNCPERD4),
+	DEF_MOD("vin00",	730,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin01",	731,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin02",	800,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin03",	801,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin04",	802,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin05",	803,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin06",	804,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin07",	805,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin10",	806,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin11",	807,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin12",	808,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin13",	809,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin14",	810,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin15",	811,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin16",	812,	R8A779G0_CLK_S0D4_VIO),
+	DEF_MOD("vin17",	813,	R8A779G0_CLK_S0D4_VIO),
 	DEF_MOD("vspd0",	830,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("vspd1",	831,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
@@ -209,6 +230,9 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] = {
 	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CL16M),
+	DEF_MOD("tsc",		919,	R8A779G0_CLK_CL16M),
+	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
+	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
 };
 
 /*
-- 
2.40.1

