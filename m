Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535B7CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B741786A23;
	Sun, 17 Sep 2023 16:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tx0Zq5tC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D5IQxlZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA5786A97; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E0686A49
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVH83g3sz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1M7Yg/bbtwfJ3hsLUDOWY3MDwcwN/Rp2xO+GZUw4Ss=;
 b=tx0Zq5tC+Q8talUS9iuh3GrxzZ5pntlPZ16yVY2eXzTxPng4cjkkVAe/EXKs6geGvpAaMC
 6g7wyXOJysxxJUYFa5hRB7y34YzJI/yBgrs2D2x2l8ssDlSF1I4HXbGRSpQLzmd0NSf/A/
 6pzqi6Ys95casdNXbhFxskoBhYO8k+zHX00ByOJtVAImrS6BYZglVvxqV5cIQKfk2ML1qx
 uOGs/QsEe1QoAMuTFPNXOchKTOFcoJBvG2X+f1FYkBYyjGn504gd9FS6IIyEDRGBKr4MeC
 WXOuX/E290DATx7DaTInx5OzD5Pmud4uzmZny515GCHfEHdrmUWjG5GFI2wbKQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1M7Yg/bbtwfJ3hsLUDOWY3MDwcwN/Rp2xO+GZUw4Ss=;
 b=D5IQxlZ6t7kfcZ/SUI2PYSAPyrltO8EHjwCHmYDOh4OUfDWi6hnj/3ziCFzRM5uiS8aWio
 5CnWIlRiZ1r3ymmUR79+ipN0ZPrefk/fRbMTfQsOEZCSY6sJoVK3YHAQyJdCIHfZYLLPM7
 L0hIEeXr1Z84AnCZLzaTWydfVJT83oWaR00IIu0VBiMFbeoVOe4FJzu8wCIMSyJlbNWJGW
 ErZeRWpidgdhv/rDCCo1DerphSu937YD6MekHFLnxsZ6iMeCpiMDaT4SpsUVraEyVHZo/8
 ZI877DUPBQrkFpR9l56S3auoxbpOU5EBvbO792RSxkE40h/5G+xd/9+m1DuV+A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/20] clk: renesas: Synchronize R8A77965 M3-N clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:30 +0200
Message-Id: <20230917141141.379884-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cc0783ac3c171d6dd71
X-MBO-RS-META: eobc7u6odfbroxqnn4qe4yx4gwckuwqo
X-Rspamd-Queue-Id: 4RpVH83g3sz9sWt
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

Synchronize R-Car R8A77965 M3-N clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 58e557a95f5..8a5c1525ece 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -50,7 +50,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a77965_core_clks[] = {
+static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -124,7 +124,7 @@ static const struct cpg_core_clk r8a77965_core_clks[] = {
 	DEF_BASE("r",		R8A77965_CLK_R,	CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a77965_mod_clks[] = {
+static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("fdp1-0",		119,	R8A77965_CLK_S0D1),
 	DEF_MOD("tmu4",			121,	R8A77965_CLK_S0D6),
 	DEF_MOD("tmu3",			122,	R8A77965_CLK_S3D2),
@@ -302,7 +302,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

