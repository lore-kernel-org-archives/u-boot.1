Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53638CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADCE86A77;
	Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oj/+5jYl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Gag22USu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC4C86A63; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2898086A21
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVH56TKmz9sTr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hd3rrEjG892oOsZRt28Iu2Pvi7S09m82C+enmAQ2UXc=;
 b=oj/+5jYllhyWTwsOlvTqN2f6PM7p37eqTu77pAna+BwPOT0vsI2uMWnbmtHMl1El8VDK38
 z1uBTdAirij9beVfurSgQrDYBb2UQlOMmhj6++RH0Q3b1CqKSoQaRSVqm0RBf078ApYXmL
 TLdnS+iAHNYHG587zbnLlMshe44IFwuIK8Jd5hY6LZvmHrEbL2/qLofxZtRkfg89wMqSLB
 n6GV2TceepdDgXU1epcV1d/1cgjjVTValm3iUuqjrKKfSY0bpu999aVf49kpqYX+SJQaWF
 CUYeQtxCOlfjC16Gl/WApHmaWrbwW8kx5LXxJEdgXuC49KqSEpOueHlQ/FRlog==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hd3rrEjG892oOsZRt28Iu2Pvi7S09m82C+enmAQ2UXc=;
 b=Gag22USuIVYh+w3tsrY7Dc3sQeNfrife+dys7bACfqODgPYWmHXkYwqSkKbesAxtW0VTx2
 IziDVoWkYg0+atKKz2B2QRdw+oIXXEE5mx99bHsqAc6enlhEG/cUpsWjKj55S2T1n5pNjW
 dpw6OFZIlncHYEXsytP2zqllapjZipb5MsRXxpil/g6hvcXte88NVoXV3VS2KjfMGHF3vj
 EtZKK5/642ZQNlVkT0FyX0JdB2vQZYiMURmCR+4iRkgcWpS/+U7ALP/tNRl77aXN+TuUAv
 mrQ9WvezRHNBNDHeoSO6VIdzCGnCDh0aqSVXNfEK+Eo/3FLmvPiZBVpYsTp5eQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/20] clk: renesas: Synchronize R8A7790 H2 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:24 +0200
Message-Id: <20230917141141.379884-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fhxny9t6qsbtabkpy494i91ii8estqwh
X-MBO-RS-ID: 5e5306b8d2a73c03b3f
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

Synchronize R-Car R8A7790 H2 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7790-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a7790-cpg-mssr.c b/drivers/clk/renesas/r8a7790-cpg-mssr.c
index 1f3477fa6e5..686f2af0052 100644
--- a/drivers/clk/renesas/r8a7790-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7790-cpg-mssr.c
@@ -38,7 +38,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7790_core_clks[] = {
+static const struct cpg_core_clk r8a7790_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 	DEF_INPUT("usb_extal", CLK_USB_EXTAL),
@@ -88,7 +88,7 @@ static const struct cpg_core_clk r8a7790_core_clks[] = {
 	DEF_DIV6P1("ssprs", R8A7790_CLK_SSPRS, CLK_PLL1_DIV2, 0x24c),
 };
 
-static const struct mssr_mod_clk r8a7790_mod_clks[] = {
+static const struct mssr_mod_clk r8a7790_mod_clks[] __initconst = {
 	DEF_MOD("msiof0",		   0,	R8A7790_CLK_MP),
 	DEF_MOD("vcp1",			 100,	R8A7790_CLK_ZS),
 	DEF_MOD("vcp0",			 101,	R8A7790_CLK_ZS),
@@ -230,7 +230,7 @@ static const struct mssr_mod_clk r8a7790_mod_clks[] = {
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
 					 (((md) & BIT(13)) >> 12) | \
 					 (((md) & BIT(19)) >> 19))
-static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] = {
+static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] __initconst = {
 	{ 1, 208, 106 }, { 1, 208,  88 }, { 1, 156,  80 }, { 1, 156,  66 },
 	{ 2, 240, 122 }, { 2, 240, 102 }, { 2, 208, 106 }, { 2, 208,  88 },
 };
-- 
2.40.1

