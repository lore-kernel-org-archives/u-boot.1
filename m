Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBC2C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B00187646;
	Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ti0RrZOw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I16KsQw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6768757C; Sun,  3 Dec 2023 14:17:11 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4C18757C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SjnQD3pMKz9sTM;
 Sun,  3 Dec 2023 14:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sbayR/jzq78WaJBdkzwndju3hA7/t2zWTIR/nRucmSU=;
 b=ti0RrZOwHBgX15ucwbhFIEg0RPr5mYA05tBHp6gvVVmPu4GjZHbazPjuc27DBjdfE8JDd7
 OtAe3CL7KsfFh2xYgWCuEOLm+g1VBls1X+aqTBEnR8C7B7mUu0KJ/sUU9p98WnGYdrl6i/
 pMXKA9nEhexrOzeAKL1dEYhziZinFxx8JKC9jj6l4QxOFU+06ws1gGNrecXtpOD4JncKKd
 YyEELfWUJETT2KMn1POABslj6K3E+OmAU8m1Uf+Tv42+j7iKjAvZ7gNGgpDr6feXeHGyQf
 7JGryfsGIaYYsN3Y0Wj0k+KmF2omV8Zuj3E3iL0aE+xbBGL+3RaUDBA722i1rg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sbayR/jzq78WaJBdkzwndju3hA7/t2zWTIR/nRucmSU=;
 b=I16KsQw0x4svm/FqWqZ1NW+Yo+mNoe/3KpYXn/ySv/sMntXKnAiNUxEgF/Gp0vc50HbDLf
 h8cMsf9kpUsRqVfjmHInrS1bMjSmLyM2gQ3QP1ykz9kga9yUfN2XLL0Utl4D6qAek8viPq
 g9xH+Oet2C7EDa6+bzRjRkLzoFjKSe3jXmag9ASggvQgovx2SBSWkqAnAyZzLpC+qrYvbJ
 qukPXvBHNf7grq6oDgnsE5oxcQ860WRElI3QJDUghKw6XVFFf+JM3T8FMXAq3S/hDsmwXW
 GpxTeIPyJ7yeXeCzlbuis0AYGDagpnsE6vSVxYZihqqXzGXrVyvz9CAsmsc25A==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/12] clk: renesas: Synchronize R-Car R8A77960 M3-W and
 R8A77961 M3-W+ clock tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:13 +0100
Message-ID: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4ee2c682d1c5c3e342d
X-MBO-RS-META: m7zbmam1k1pm6syxrhbp76gt98c4w68q
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

Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Add ZG clock macro into rcar-gen3-cpg.h to cover the new clock type .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 3 +++
 drivers/clk/renesas/rcar-gen3-cpg.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index ea1f6d69062..d741d547ec8 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -80,6 +80,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",        R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",        R8A7796_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -129,6 +130,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 };
 
 static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
+	DEF_MOD("3dge",			 112,	R8A7796_CLK_ZG),
 	DEF_MOD("fdp1-0",		 119,	R8A7796_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A7796_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A7796_CLK_S3D2),
@@ -235,6 +237,7 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("rpc-if",		 917,	R8A7796_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A7796_CLK_S0D6),
+	DEF_MOD("adg",			 922,	R8A7796_CLK_S0D4),
 	DEF_MOD("i2c-dvfs",		 926,	R8A7796_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A7796_CLK_S0D6),
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 06318c81acd..370f26c4f0f 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -24,6 +24,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_R,
 	CLK_TYPE_GEN3_MDSEL,	/* Select parent/divider using mode pin */
 	CLK_TYPE_GEN3_Z,
+	CLK_TYPE_GEN3_ZG,
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 	CLK_TYPE_GEN3_RCKSEL,	/* Select parent/divider using RCKCR.CKSEL */
 	CLK_TYPE_GEN3_RPCSRC,
-- 
2.42.0

