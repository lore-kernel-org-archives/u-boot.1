Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD4FCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9D286AF7;
	Sun, 17 Sep 2023 16:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dRCmYW10";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j2b0x1wU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AB686AAD; Sun, 17 Sep 2023 16:12:12 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E159F86A88
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVHD63jrz9sWS
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gr2ZGaLNygwVfFzeVEHCRCDE0C7fgMtVFbir5J4IDGI=;
 b=dRCmYW103RFBxrCIVhbQmzu2RipgSZmlDqQZlTE0pjhfqLOVntnJUccy8kSMtwxoUb+TNp
 jJAd7BKu0rO2Llcq5rwzcOx8kMdziHNuTLqyxA9XubkMpobPEFvQv8//WmL06UuefL91FX
 mkjvzcfYx2Co8hz8s94i4ey4Y/MxcZEVLq4wSWfSCcdw5KV8HjRPBd5QSVWW1fDp9ZLDLp
 YOdUJiV0fQWS0IYsB0NjKG50vuk70iXdXbupQ7Ujiu0or0RzOcjLwRT6dqoUD9dOg9XPRN
 jmbXakySs/0UE1YnLd/nZGFeWDPl8i7PzR6d6TzJwGi2Q0LqauzHLhA7GpKvPA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gr2ZGaLNygwVfFzeVEHCRCDE0C7fgMtVFbir5J4IDGI=;
 b=j2b0x1wUpFWTmKmuPmmPxZqkLhkWBnTroVIbnzwtQzZpA2GO1XrB4HoOL2wfYPIijAMIRk
 zOdfuyzsfDp1XpYUaQoyDsICLEZSJ7zr0WdZ6HkIwx39kXdHBFqrln+afkgbL0do8GAbUk
 RDAs7N1fbbTk073sf3SXi6fsYgjvyCJHOnSEnaLO3cX0rSChqszEZHW3C3d0M3x+Je2Jxw
 rk6tFNkRmQ1lEint1ioBHwaEg7rDqJ3BNxbDypsJQ500dFqKwUMstcsBUdY+j4EkLGhOua
 pu3zkxsNjss64DolFAARFTIv5KLVXzsgtclICMy3gcyh6ZHwPNcGFHEO6PJTug==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/20] clk: renesas: Synchronize R8A774C0 RZ/G2E clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:40 +0200
Message-Id: <20230917141141.379884-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c22421ebbdeef7b48fb
X-MBO-RS-META: rk5oy6hdnc1shjaiaprdbpt3bwmry7mq
X-Rspamd-Queue-Id: 4RpVHD63jrz9sWS
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

Synchronize R8A774C0 RZ/G2E clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 802a9c0b119..4768ceb0fa6 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -52,7 +52,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a774c0_core_clks[] = {
+static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 
@@ -131,7 +131,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] = {
 	DEF_GEN3_RCKSEL("r",   R8A774C0_CLK_R, CLK_RINT, 1, CLK_OCO, 61 * 4),
 };
 
-static const struct mssr_mod_clk r8a774c0_mod_clks[] = {
+static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",			 121,	R8A774C0_CLK_S0D6C),
 	DEF_MOD("tmu3",			 122,	R8A774C0_CLK_S3D2C),
 	DEF_MOD("tmu2",			 123,	R8A774C0_CLK_S3D2C),
@@ -259,7 +259,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] = {
  */
 #define CPG_PLL_CONFIG_INDEX(md)	(((md) & BIT(19)) >> 19)
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div */
 	{ 1,		100,	3,	100,	3,	},
 	{ 1,		100,	3,	 58,	3,	},
-- 
2.40.1

