Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50682CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE38B86AB7;
	Sun, 17 Sep 2023 16:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YW894P6V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SN8syxaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A812786A63; Sun, 17 Sep 2023 16:12:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B8886A23
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVHD0KZCz9sWC
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GB6b0ASlr4WumgrKwH8VCJCh8QCGb+6WCu66u+pktg=;
 b=YW894P6V5o6shoFLg+k7fIM3i8/ziwEEdNs7JV52mA6O0MHMxI+T/tgck9ncNOZ6mLAmkb
 eMurnLOC8H4NwTTQSxpeawN2OTCaph6Oe5HJ9uyiWaV22m3wld4H51lTQx37HQzeOoBYjk
 tCcblpuN5dGLMimWZQ7pd70QN0rCw5jegUHnG1xCK8CNXp9jflAVSVteW52goHEQGNghKU
 nmlwycU3YBj9aiyq8JGv9vXNxoltw9D6Nt0gAMXPifpIlBy3PpN6xhAAplr4c8abd7ztGt
 /6qbWn2i54yPpIXRjaAPKFZW56w/kn6Jb3g1WHZG3YaP/qrtQPdL9sl5KHErrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GB6b0ASlr4WumgrKwH8VCJCh8QCGb+6WCu66u+pktg=;
 b=SN8syxaT/s0RtZ9FvNwWRigEpp99RsEXBKwoqeuDEqwyyRNXhk4946hzbSWNZ00Mw4Fwkj
 Yduol4EohzMUvvirDEP0ilO0DQGemirLeuePEsWNKywime8eFbkg3xojDSrQOutyPTvvDJ
 ZavyV2188XWK/G1vIatszbM5enPfrWvjVAuBH9EbZFVkDjbLLQg5w0cCrluK0DWPkuBfAz
 ZAmLa58x5KBdegRHnawRww22i6u0OTvSLtuLAzugwLLmngVWwTJvoGj0CBZiz94I5FIlj5
 H/5ggQ684nHfQCo73IBkMXpMN617uitfTZ5hTnv4qUNhPkIpZiF8b1Y5S2d2UQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/20] clk: renesas: Synchronize R8A774A1 RZ/G2M clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:38 +0200
Message-Id: <20230917141141.379884-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mnq9etn1r5uwaxyftgmnr4dqoxhes5p4
X-MBO-RS-ID: e07e1b4bde54f00f5be
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

Synchronize R8A774A1 RZ/G2M clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 1f76d6b2c2e..6280061af89 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -47,7 +47,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a774a1_core_clks[] = {
+static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -121,7 +121,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] = {
 	DEF_BASE("r",           R8A774A1_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a774a1_mod_clks[] = {
+static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A774A1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774A1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774A1_CLK_S3D2),
@@ -276,7 +276,7 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

