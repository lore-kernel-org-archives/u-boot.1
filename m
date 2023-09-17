Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F5CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6106286A2F;
	Sun, 17 Sep 2023 16:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eytdRPiE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z8KXujV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B8986A93; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0AE86A3A
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVH80z25z9sWS
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGtGTjxPcTK0PcNgT+RudhuW1V2G8IXVEPQUQsZgn/s=;
 b=eytdRPiEZVTn4qm1GO3ZVxpw7muu+a5AIBy+tasMSaT0mKx0FrxChjL3p48Fc/EXR2uO0E
 qSc4JSnOeLXJ5IfVuCrGhOanBkY9kxApe39oynHieRuSHEMw/fry2flyjzYjB6jkncfdcK
 +24AtBwKdDos9AnBIO8ZW8KZiPS+p15v6B1jxXlEdyMDXLHyBOR528+DvrxyVivnegeKZT
 yNkWqreQG7dU4+3u1tLvK/fa23kIo+wpk86jxpZvUX4iUnYPYnDW6ej58NDeIfPmpxdtMF
 uaBNc/0vYiias2w6U0rzAqQDAgVxMkjOGpOaiKbXSRHpZ9TbftMWz4Y9M20eCg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGtGTjxPcTK0PcNgT+RudhuW1V2G8IXVEPQUQsZgn/s=;
 b=Z8KXujV+W7vv/YJWdpGOBk/jE1iBI/pUrjPWr0ee5BhGMaVUDMGRt7Vm4zNpbLLZp3oU9Z
 s5P7FSJfnr32qsGkece7lQ8t3v54A2neji4jbiQkQ/W4SXdiGN7tTP+2ZxwnhOrr5D+Hco
 XvDCedHTQmaNepkiUq4Euic/ypH9EIiA6+SRnixY3tAiOAY4L3zDDDU6y+YoaIgGX0LhXH
 97+yfsObzDnkmK8RS7axAAyDLydEb17p6XP0rJ8Ym4WupR+gscG2NLxZDVWRBwxJsc9lbl
 EJV8itqLqnmUlmvEtT8xymc5donq86Dw4oj44PucmoJRMefRFsrCZWVn3XgW3w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/20] clk: renesas: Synchronize R8A77960 M3-W and R8A77961
 M3-W+ clock tables with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:29 +0200
Message-Id: <20230917141141.379884-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 16f04cffbc4ad6105ac
X-MBO-RS-META: rxuym9xqq54o4tnb3iozwrjtqjj5iyts
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

Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 27cf62e0213..ea1f6d69062 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -52,7 +52,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7796_core_clks[] = {
+static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -128,7 +128,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] = {
 	DEF_BASE("r",           R8A7796_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a7796_mod_clks[] = {
+static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("fdp1-0",		 119,	R8A7796_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A7796_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A7796_CLK_S3D2),
@@ -299,7 +299,7 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

