Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7F0C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E516587EE9;
	Sun, 28 Jan 2024 16:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Yz6RLEbG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dCuTl04Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BD787F68; Sun, 28 Jan 2024 16:55:56 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F80587F07
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNGHX2VbGz9stL;
 Sun, 28 Jan 2024 16:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahOM/G4q+u6NGFRsXGi3C+AOj7fnyj5PJo2bXKGOo1U=;
 b=Yz6RLEbGMxERWAHCZ4F16viLz8TDoEbSQgUl4MvV6boaxJwGe5BTjoBu9UMpcL00ISactc
 dP5W3ovn5mEG29Z+JibBV3psdS/MWbFnicnskVS23FBPqfGG1F2VO1ZpqT9is3zbUjvciH
 XYkSy+sroP3HVUJE/Xo7h5TSw5CbFGTVBoMxLTQccB7I5we/ytWO/zNYrjwi1D4Bha18+u
 FEpL3WOZbdlqXe2k7HFrX0q2e2CwyEV7CwkNXYQvYSQRn/M0Z+ZVD+w10RiEUcyD65vtVT
 bAB2asz/88OZwSMFO0t6qnfE/bO3K9VcT+piqAf4FBTSHDDNy7cW1TlFSh26Ag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahOM/G4q+u6NGFRsXGi3C+AOj7fnyj5PJo2bXKGOo1U=;
 b=dCuTl04Z30Dfaf/G14X4gcdjS7dk2aCWoyzNQqhKHhrF7HayKThD5pnM6aAk5GeYhRSPVJ
 9rVkhnhZ5nl5dtFLKikxlRmMnUcuY+Gv71rugizetsGe/5Qf4Dnossn/9nfDDaq4cOMY5h
 HB4EQ6/gDZ2QiuYjI0aQ6SFhfcEiXZ9D+gqk/2+qpfGxm1l2CaAP/AqOp0dytwkjjJEtmB
 InYGlFeM4YzhYR67Cre49y+Q0Oxp4ZcDY4rgHRd7LvRDNx48Lmb2ESEd1TeRwbr7HLs22g
 yxY/LEv1ACae2Yef6AoZI2Cx30xJ0b7gngJDII+Kb00qTf6ezm0ty3JHurqgtA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 04/11] clk: renesas: Implement R8A779H0 V4M PLL7 support
Date: Sun, 28 Jan 2024 16:52:02 +0100
Message-ID: <20240128155458.56712-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0a50f6d91f2ca583d10
X-MBO-RS-META: rhmqfuq88gmnxst1pbcyz7oa3yggip1r
X-Rspamd-Queue-Id: 4TNGHX2VbGz9stL
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

Add PLL7 support to Gen3/Gen4 common clock driver. Add initial PLL7
multiplier and divider values into table in R8A779H0 V4M clock driver.

The PLL7 is new PLL added in R8A779H0 V4M SoC. Only integer multiplication
mode is supported by PLL7. The PLL reference clock are either 16.66 MHz or
20 MHz on R8A779H0 V4M SoC, and the output frequency must be 2000 MHz. The
multiplier values fitting this requirement are calculated to 120 or 100.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sean Anderson <seanga2@gmail.com>
---
V2: No change
---
 drivers/clk/renesas/clk-rcar-gen3.c     |  6 ++++++
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 10 +++++-----
 drivers/clk/renesas/rcar-gen3-cpg.h     |  2 ++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index 196903e406c..b84024266f4 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -306,6 +306,12 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
 						gen4_pll_config->pll6_div,
 						"PLL6");
 
+	case CLK_TYPE_GEN4_PLL7:
+		return gen3_clk_get_rate64_pll_mul_reg(priv, &parent,
+						0, gen4_pll_config->pll7_mult,
+						gen4_pll_config->pll7_div,
+						"PLL7");
+
 	case CLK_TYPE_FF:
 		return gen3_clk_get_rate64_pll_mul_reg(priv, &parent,
 						0, core->mult, core->div,
diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
index 8bb7b41c787..502b20b554a 100644
--- a/drivers/clk/renesas/r8a779h0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -206,11 +206,11 @@ static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
 					 (((md) & BIT(13)) >> 13))
 
 static const struct rcar_gen4_cpg_pll_config cpg_pll_configs[4] = {
-	/* EXTAL div	PLL1 mult/div	PLL2 mult/div	PLL3 mult/div	PLL4 mult/div	PLL5 mult/div	PLL6 mult/div	OSC prediv */
-	{ 1,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	16,	},
-	{ 1,		160,	1,	200,	1,	160,	1,	200,	1,	160,	1,	140,	1,	19,	},
-	{ 0,		0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	},
-	{ 2,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	32,	},
+	/* EXTAL div	PLL1 mult/div	PLL2 mult/div	PLL3 mult/div	PLL4 mult/div	PLL5 mult/div	PLL6 mult/div	OSC prediv	PLL7 mult/div */
+	{ 1,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	16,		120,	1,	},
+	{ 1,		160,	1,	200,	1,	160,	1,	200,	1,	160,	1,	140,	1,	19,		100,	1,	},
+	{ 0,		0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,		0,	0,	},
+	{ 2,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	32,		120,	1,	},
 };
 
 /*
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 7bea09c4827..4efb9b6ceef 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -131,6 +131,8 @@ struct rcar_gen4_cpg_pll_config {
 	u8 pll6_mult;
 	u8 pll6_div;
 	u8 osc_prediv;
+	u8 pll7_mult;
+	u8 pll7_div;
 };
 
 #define CPG_RST_MODEMR	0x060
-- 
2.43.0

