Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E51E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A615A80326;
	Fri, 20 Dec 2024 01:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u1ofRHof";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CI4Q+Gn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8608033A; Fri, 20 Dec 2024 01:05:06 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA8180312
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YDnjW40Zqz9sp0;
 Fri, 20 Dec 2024 01:05:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jFBZ3l6JiGzNBJhiUZNKCjHxwArPr04kZpzQyhO0XlQ=;
 b=u1ofRHoflsibKAsqlh6w8+MSYXImdMGVv4k1OKawIVVVJkXIHQ1WBVKbP2mOEDTUhU65qC
 v5ehuCF0twdI2n5vtNhUVWLR8x8Vn3BP0I+A4BFtsWKwUwE/PpmeaTjrEYFwt3I2ZHOydm
 /OdvUtNLCtodZjYcbusYGDWascLFq259yOdoNqOM7+DBG+kMJn6fy6BJwCxk1e6tlnOdtZ
 wCwMEvoUy9IjxbZ+4OP1ku3ftYi/o8KJiir6KuCPxya3PJJGPV4IQgo2nA6/J6aNovQJTr
 G8Wy4GJ9a2AD/TwPYXJtR16oSb97nBVvmX7XYS3oQvH+aXHaTodb3xsvuGqqYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jFBZ3l6JiGzNBJhiUZNKCjHxwArPr04kZpzQyhO0XlQ=;
 b=CI4Q+Gn7Zvb9UaY7W6TaqAucGkte36RSSGlcIaUC2F+1gh3Ck3as2n6W40LWsWGg6npP80
 dYiZQjbvr1dBTBV7Up5UXj+BYq55kGuOkDORDyLrYJ/ZYiFLCfkXqnKDeNwGnEE9U1bMzp
 BtC2RA6LeRGuJ2iA2+gZf1OtPCIBi2uxv54SbwU1yciqhutGR0Jr0ajZ5P2UM7EXC6XV4/
 1hrJcNK3mEpCgsG+pWhYdvLiO3VY7H1tQ3BXL7gxrMhSqS8PW6WyXEUw2dGA83ewzyq2v+
 pt+hm5wYdYnkNMluqW9A373ys8sVQoS3gfMt6dGj+3ViIFGpz6X5OHAnmPraRg==
To: u-boot@lists.denx.de
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Lukasz Majewski <lukma@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: renesas: r8a779h0: Drop CLK_PLL2_DIV2 to clarify ZCn
 clocks
Date: Fri, 20 Dec 2024 01:04:08 +0100
Message-ID: <20241220000434.167207-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 78gnab1i35swhyjc4t5gu36hi5cwzkip
X-MBO-RS-ID: 5a4785b99801af65da1
X-Rspamd-Queue-Id: 4YDnjW40Zqz9sp0
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Early revisions of the R-Car V4M Series Hardware User’s Manual
contained an incorrect formula for the CPU core clocks:

    ZCnφ = (PLL2VCO x 1/2) x mult/32

Dang-san fixed this by using CLK_PLL2_DIV2 instead of CLK_PLL2 as the
parent clock.

In Rev.0.70 of the documentation, the formula was corrected to:

    ZCnφ = (PLL2VCO x 1/4) x mult/32

As the CPG Block Diagram now shows a separate 1/4 post-divider for PLL2,
the use of CLK_PLL2_DIV2 is a recurring source of confusion.  Hence get
rid of CLK_PLL2_DIV2, and include the proper 1/4 post-divider in the
invocation of the DEF_GEN4_Z() macro, like is done on other R-Car Gen4
(and Gen3) SoCs.

Ported from Linux commit
92850bed9d4d ("clk: renesas: r8a779h0: Drop CLK_PLL2_DIV2 to clarify ZCn clocks")

Reported-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/0d2789cac2bf306145fe0bbf269c2da5942bb68f.1728377724.git.geert+renesas@glider.be
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
index 2e98e262fb0..70fa8ff2871 100644
--- a/drivers/clk/renesas/r8a779h0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -39,7 +39,6 @@ enum clk_ids {
 	CLK_PLL6,
 	CLK_PLL7,
 	CLK_PLL1_DIV2,
-	CLK_PLL2_DIV2,
 	CLK_PLL3_DIV2,
 	CLK_PLL4_DIV2,
 	CLK_PLL4_DIV5,
@@ -82,7 +81,6 @@ static const struct cpg_core_clk r8a779h0_core_clks[] = {
 	DEF_BASE(".pll7", CLK_PLL7,	CLK_TYPE_GEN4_PLL7,	CLK_MAIN),
 
 	DEF_FIXED(".pll1_div2",	CLK_PLL1_DIV2,	CLK_PLL1,	2, 1),
-	DEF_FIXED(".pll2_div2",	CLK_PLL2_DIV2,	CLK_PLL2,	2, 1),
 	DEF_FIXED(".pll3_div2",	CLK_PLL3_DIV2,	CLK_PLL3,	2, 1),
 	DEF_FIXED(".pll4_div2",	CLK_PLL4_DIV2,	CLK_PLL4,	2, 1),
 	DEF_FIXED(".pll4_div5",	CLK_PLL4_DIV5,	CLK_PLL4,	5, 1),
@@ -106,10 +104,10 @@ static const struct cpg_core_clk r8a779h0_core_clks[] = {
 	DEF_RATE(".oco",	CLK_OCO,	32768),
 
 	/* Core Clock Outputs */
-	DEF_GEN4_Z("zc0",	R8A779H0_CLK_ZC0,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 0),
-	DEF_GEN4_Z("zc1",	R8A779H0_CLK_ZC1,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 8),
-	DEF_GEN4_Z("zc2",	R8A779H0_CLK_ZC2,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 32),
-	DEF_GEN4_Z("zc3",	R8A779H0_CLK_ZC3,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 40),
+	DEF_GEN4_Z("zc0",	R8A779H0_CLK_ZC0,	CLK_TYPE_GEN4_Z,	CLK_PLL2,	4, 0),
+	DEF_GEN4_Z("zc1",	R8A779H0_CLK_ZC1,	CLK_TYPE_GEN4_Z,	CLK_PLL2,	4, 8),
+	DEF_GEN4_Z("zc2",	R8A779H0_CLK_ZC2,	CLK_TYPE_GEN4_Z,	CLK_PLL2,	4, 32),
+	DEF_GEN4_Z("zc3",	R8A779H0_CLK_ZC3,	CLK_TYPE_GEN4_Z,	CLK_PLL2,	4, 40),
 	DEF_FIXED("s0d2",	R8A779H0_CLK_S0D2,	CLK_S0,		2, 1),
 	DEF_FIXED("s0d3",	R8A779H0_CLK_S0D3,	CLK_S0,		3, 1),
 	DEF_FIXED("s0d4",	R8A779H0_CLK_S0D4,	CLK_S0,		4, 1),
-- 
2.45.2

