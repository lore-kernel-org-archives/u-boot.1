Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F71CCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A958E86A3C;
	Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y9jHmgc4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ge+URVbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A7086A28; Sun, 17 Sep 2023 16:12:05 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1B986A14
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVH7252rz9sZl
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guaQXestH1pY16efMEzEQeCLvA2RebKQDwBO4p2GSck=;
 b=Y9jHmgc4xSlOoaY0IRHyIdJjJMWeC2LsjUjxBRZik4PpOi8eu149kGxQB1O12h08KLmXgj
 Pa1VtjvFyKOU+C0LwlBv3bIacUtLjUriC0HgSkWTD5+hKffRgiRew6Cw9XDofaLUK1RY5v
 lr/Cx0S+wtumfC9Ocv1PnHVHls8oZAlIW6AfXeFHEgrsKmPI2cPF83B7ycVmVpHtzvvhpY
 kiS+vrNKL9vCIt7edQq1qMYUZiyZ+kw09Y3djR+S3wzwn8SX9cjVokEiEeRyMBIgecgyl2
 Tb2qkfJDINlEa+EoVbK9fGMchhRHcL5RK7IW4eF6N35IRQzn+WHvTS47zTQ5eQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guaQXestH1pY16efMEzEQeCLvA2RebKQDwBO4p2GSck=;
 b=Ge+URVbiO6CecsbbBBsJHB0riNxH4xtk81ttwCHQgthyQ3PmEyVRgi7NHtlAx/zrriKks0
 KzczFh2D7VCNqnn39bbXcLoEOZg3UjLpA9de/iTsU22c/bbzbUbZ2DvG/59QbHrswqCgzn
 snjVSoG5PC48d3iZPIp3sQ2lz9H4bqCmDbgv79ORr5XlWNVbswJB5kPaBTbiHhuv47Vc+6
 HqyUO7j4pXZtPRM7aWaxRp47gEypLz1rxzTw80zQFzMG7yVf/MjQpTLhoionXmM2Fq3vPj
 +gtCar1EKkeU0wu5PZSO57y9Rck/oc/69g2sMbjoePVaQ78dgNccWYIabRXYfg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/20] clk: renesas: Synchronize R8A7794 E2 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:27 +0200
Message-Id: <20230917141141.379884-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8edc8b9e1bebca8db3f
X-MBO-RS-META: sea1e4sz7f8h881xg85kma68wmttfweu
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

Synchronize R-Car R8A7794 E2 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7794-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a7794-cpg-mssr.c b/drivers/clk/renesas/r8a7794-cpg-mssr.c
index b9dd88de98e..f1828a6e543 100644
--- a/drivers/clk/renesas/r8a7794-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7794-cpg-mssr.c
@@ -38,7 +38,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7794_core_clks[] = {
+static const struct cpg_core_clk r8a7794_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 	DEF_INPUT("usb_extal", CLK_USB_EXTAL),
@@ -83,7 +83,7 @@ static const struct cpg_core_clk r8a7794_core_clks[] = {
 	DEF_DIV6P1("mmc0",  R8A7794_CLK_MMC0,  CLK_PLL1_DIV2, 0x240),
 };
 
-static const struct mssr_mod_clk r8a7794_mod_clks[] = {
+static const struct mssr_mod_clk r8a7794_mod_clks[] __initconst = {
 	DEF_MOD("msiof0",		   0,	R8A7794_CLK_MP),
 	DEF_MOD("vcp0",			 101,	R8A7794_CLK_ZS),
 	DEF_MOD("vpc0",			 103,	R8A7794_CLK_ZS),
@@ -205,7 +205,7 @@ static const struct mssr_mod_clk r8a7794_mod_clks[] = {
  */
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 13) | \
 					 (((md) & BIT(13)) >> 13))
-static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[4] = {
+static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[4] __initconst = {
 	{ 1, 208,  88, 200 },
 	{ 1, 156,  66, 150 },
 	{ 2, 240, 102, 230 },
-- 
2.40.1

