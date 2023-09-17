Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08373CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D6786B02;
	Sun, 17 Sep 2023 16:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MS7zF7KT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dmr1ns7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600BF86ABB; Sun, 17 Sep 2023 16:12:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5201E86A81
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVHF1zLnz9sW2
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9IOapbaW8b5/Fl1n5sqKZRI91bxKccZNViQW03woJA=;
 b=MS7zF7KT4v1WEJ90WsMM0cLedoVTJE9551KVsIxqrVpTpJqIEsqHGHyesCAEkpkp7jT0l0
 Sd9dQuXUpJcW66UJ13A1TjTAdRuX3di9CwHm9H5g8aXV4R7R5QC2EtZunviy0sXi6P0/9Y
 +N95HP2CysNS1rDVTH/rfnriKwKhrIgX3SDQbZcNC+WJumFrQSKtOlatf1r3o3BHa8bXKw
 QUfk1+D1962ntARD6FQ6tD/RpErIPehOfDHTa00Q8viXVhupEUIw1jMXhb2azhxz9KRXfT
 9oqkCJNB+QrkRNuQePU5+iZiSFtQsKAl9uHj9ifAJtv1lJij++ikkfBKdZk8zQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9IOapbaW8b5/Fl1n5sqKZRI91bxKccZNViQW03woJA=;
 b=Dmr1ns7mQDUslNF2Xq/HvD2GAtYnb8cVPP+umc6DAl2IRjDgONIjyu6RkbaOjEEUqQJeT4
 Q79BUDSjFFwzmqNLbCa2oqzcdhtP8F1wwm1SWVaUWi9S1aHpHXR1L5XrnS+RPl0JEWJpiw
 QXP5+wauRreB9UgVZDt/ZoKwBE5rhMVJA60+xKwi07xEe75S6z67gLCRrk9PA0ct4AuaR8
 b2WM16djY04GujCYEUCUE4HySgyJbXm8qxQYiqjGvnUcHRV0B/46vEMimoDQ8bz2pEJHRP
 203bgpsYDUnke9GNufYPwDY4Wec4a45LV4RyMnQkpxaEqw4uoy8ZAaF4eF+0mg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 20/20] clk: renesas: Synchronize R8A774E1 RZ/G2H clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:41 +0200
Message-Id: <20230917141141.379884-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b65ab241a4c5146aa17
X-MBO-RS-META: deoc1breb9mfzmk457zyh5an1qrsjnsj
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

Synchronize R8A774E1 RZ/G2H clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774e1-cpg-mssr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a774e1-cpg-mssr.c b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
index 617fa769dcf..28d8a8832ae 100644
--- a/drivers/clk/renesas/r8a774e1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
@@ -48,7 +48,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a774e1_core_clks[] = {
+static const struct cpg_core_clk r8a774e1_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",      CLK_EXTAL),
 	DEF_INPUT("extalr",     CLK_EXTALR),
@@ -123,7 +123,7 @@ static const struct cpg_core_clk r8a774e1_core_clks[] = {
 	DEF_BASE("r",           R8A774E1_CLK_R,     CLK_TYPE_GEN3_R, CLK_RINT),
 };
 
-static const struct mssr_mod_clk r8a774e1_mod_clks[] = {
+static const struct mssr_mod_clk r8a774e1_mod_clks[] __initconst = {
 	DEF_MOD("fdp1-1",		 118,	R8A774E1_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A774E1_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A774E1_CLK_S0D6),
@@ -286,7 +286,7 @@ static const struct mssr_mod_clk r8a774e1_mod_clks[] = {
 					 (((md) & BIT(19)) >> 18) | \
 					 (((md) & BIT(17)) >> 17))
 
-static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] = {
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
 	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
 	{ 1,		192,	1,	192,	1,	16,	},
 	{ 1,		192,	1,	128,	1,	16,	},
-- 
2.40.1

