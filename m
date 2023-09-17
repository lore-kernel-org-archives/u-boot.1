Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA5ACD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4C186AEE;
	Sun, 17 Sep 2023 16:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QaqeAE6a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BgWUCvLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1178286AA3; Sun, 17 Sep 2023 16:12:12 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9614586996
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVHD2hDPz9sb5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQcB+zmhoZS+hf6qlIBgYIeVec3ur0KWnVXzXcZCpfI=;
 b=QaqeAE6aE9ywrUcHfIfUxp3UivRFJ5LAe0KNHJA4loWR52LiYsqz5KJ3swa5B7V1yR9QhQ
 /RaRfaqM3A5O75UMUrl0tiDJJ98ATLdzyZJY6d1Fvc37eNClyssbqPh+vSRv0+0RHrAJL2
 YKCo4xbkCTWuMa6gOgoby3v8C8uSFFmy/rXF7EGLRVwSP8pdZQ1LwKC95ytXcv5UXo6qVQ
 CXLPkIiWjpNzPePKk5gPiHYItjjVV+0uo6UMiXexOts+FO+C8D541QrhK/xxmOPDkCs6LE
 WE4BSHJJaS25L4Sw1Ny9LECGCNH6yWsqBPyIBTpG1jiIoGCYlN8YFdbUavOjAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQcB+zmhoZS+hf6qlIBgYIeVec3ur0KWnVXzXcZCpfI=;
 b=BgWUCvLFRCHSZb1n4Kr3Dj0DDZSGwDCij0htDm5brH5ul5YAhcf9PMTWb0WlHWZXEopNsf
 vApNhnr1F+9i3515eP+Eix2PZGaoTXNRzAbIY4gg7RPdXrz1H0w3qDX50kZm/P5WPPZIgR
 EF+QEWIai4lJm/xpfRjAQUH0cMB2iy80+1w7BBaZjC3fFTv0BfiE9Vxsv8bMt3/PfNb2PK
 70tCILXpY7msNoG9gmY8lTQ3jtFt6aceg3qFhC0agEG0B+YCEyqGaeMfKnABqFT/VZp1sz
 lxA5mNCYh8DCpF4KBeDGjnJ6vxQ2wXgpE3uVsqsMiSE+t8nL0tXdourtqX1Osg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/20] clk: renesas: Synchronize R8A774B1 RZ/G2N clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:39 +0200
Message-Id: <20230917141141.379884-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5kjmmwx8wz34mg596qirjgb6qtspzsua
X-MBO-RS-ID: 943806163688226de0f
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

Synchronize R8A774B1 RZ/G2N clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index b5927c7892c..60f4f1da519 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -46,7 +46,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a774b1_core_clks[] = {
+static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -118,7 +118,7 @@ static const struct cpg_core_clk r8a774b1_core_clks[] = {
 	DEF_BASE("r",           R8A774B1_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a774b1_mod_clks[] = {
+static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A774B1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774B1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774B1_CLK_S3D2),
@@ -272,7 +272,7 @@ static const struct mssr_mod_clk r8a774b1_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

