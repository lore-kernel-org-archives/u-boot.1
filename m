Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC2BCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EE486AB9;
	Sun, 17 Sep 2023 16:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XWyPaSXE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W3FbuDgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6B986A81; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC8586A88
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVHB26h6z9sbr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3I1MKRbveey84Uekanbb/CaMd5G2HKzpj3QUgh+3vyQ=;
 b=XWyPaSXEVljVCbW34NXDBHSSgFo4ppo/ZnK8mk/SkSyezR1Kp+gxWnj3H1hy43FcpGKaaR
 WLxFeRkzPcSgLhB0CGgpFAm6SLoRFT5bsOWfGzgwOyk72FMamVHrx2yutAEKNQ4DgXMQ61
 prrypXtAMrxQzCZq6okNcgQVVMSm64GdaW/gu39OGxDSbh6yOiC4n4jcFgWamdOstJbmcb
 3oxmrkYVLc1OLejR9jSg8M0aUGnjLnssqiqxcyNjp3hciXYSCl5as3pFQo19ssaww8umt0
 7htDkiHyEyBlZiQpYLLdbj20yELC45rJGTkJNqBHEebibim56Ml4hMUlDLY41w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3I1MKRbveey84Uekanbb/CaMd5G2HKzpj3QUgh+3vyQ=;
 b=W3FbuDgWfD+6ml5hX+Z9x8hvfJf/PIq1Tq0LBhdmpc0wWgs0h8ShR/lQtgyrAsXW8BQmgA
 skplETVrbnGLKAVNIaEbbhFCVshZkeRANjrMZosVlsBlFTPWLy+Fpa70ddfncskwJx8hAM
 me95pBPBUI15JJH3nBT5Rh7AXySOherHURyQlrYVrSwaLBjfJANlV/TYvHtbH7+KM0Nux0
 UUPdTXnDL7F1txlR0XgVKfbt46UFM7shPcO6oxf4Ikk4OTHuiwKd6IeK4talW4Gg4DGwz/
 Ji4mFB3A+MWy9wmMOge6Z83IaSCSczRjZqHzqQFLfLnM6hLEt+lir/MVIBqcuw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/20] clk: renesas: Synchronize R8A77995 D3 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:34 +0200
Message-Id: <20230917141141.379884-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6qdi63zfxmeur5jd88mxmy8w315oa7dq
X-MBO-RS-ID: 48d76a2773595811f0b
X-Rspamd-Queue-Id: 4RpVHB26h6z9sbr
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

Synchronize R-Car R8A77995 D3 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 03ae863c8bc..0ef1c1d8143 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -50,7 +50,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a77995_core_clks[] = {
+static const struct cpg_core_clk r8a77995_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 
@@ -118,7 +118,7 @@ static const struct cpg_core_clk r8a77995_core_clks[] = {
 	DEF_GEN3_RCKSEL("r",   R8A77995_CLK_R, CLK_RINT, 1, CLK_OCO, 61 * 4),
 };
 
-static const struct mssr_mod_clk r8a77995_mod_clks[] = {
+static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A77995_CLK_S1D4C),
 	DEF_MOD("tmu3",			 122,	R8A77995_CLK_S3D2C),
 	DEF_MOD("tmu2",			 123,	R8A77995_CLK_S3D2C),
@@ -167,7 +167,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] = {
 	DEF_MOD("du0",			 724,	R8A77995_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A77995_CLK_S2D1),
 	DEF_MOD("mlp",			 802,	R8A77995_CLK_S2D1),
-	DEF_MOD("vin4",			 807,	R8A77995_CLK_S1D2),
+	DEF_MOD("vin4",			 807,	R8A77995_CLK_S3D1),
 	DEF_MOD("etheravb",		 812,	R8A77995_CLK_S3D2),
 	DEF_MOD("imr0",			 823,	R8A77995_CLK_S1D2),
 	DEF_MOD("gpio6",		 906,	R8A77995_CLK_S3D4),
@@ -209,7 +209,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] = {
  */
 #define CPG_PLL_CONFIG_INDEX(md)	(((md) & BIT(19)) >> 19)
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div */
 	{ 1,		100,	3,	100,	3,	},
 	{ 1,		100,	3,	58,	3,	},
-- 
2.40.1

