Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEF2C07E97
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD3687736;
	Sun,  3 Dec 2023 14:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IIEzfbni";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dJBYXOnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A312A87669; Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64CC875DF
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjnQK0Dq0z9sd5;
 Sun,  3 Dec 2023 14:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+ibvEJWZ0ldtS0fXUvHQXNvY5VoReEXhYkDE6LljME=;
 b=IIEzfbnijsHf8hbjzFvb+/kGbLxxEUqcxuZNJ5IKhlrXwjYMtx9SZjHpD14DPb2abi7lf4
 VnqKbWspXP9XcvU03pVa2Oj3qNDDxKoSDzj4q+02+T1TAPbYcCbiKi5vUh6yxdKBv0XO96
 G2/+XEsWaSx4YOzSWvaCSbtSJXJntqHtrEcY7SewzvENzJaAgV6E7tEzPgYGNPyGBXF7w6
 fk/PDIiWgBW0RrL7X4rUo/mpMXTUP5jilbakWA/5YF57R4bsOOA9NSLjR76QFxjgDqpte6
 0wV8mNbw5Y4+1SghlBorTecPLxnHvmoELpiP0GodWnLMh36dB4xOssIsRYgpvg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+ibvEJWZ0ldtS0fXUvHQXNvY5VoReEXhYkDE6LljME=;
 b=dJBYXOnG5FBLHMvMXcBiPLfPbw/VjlsxwZTjGI+xwPRbj36/K6iXXjhAwJdW6zyszBFS7Q
 L/ISpYiPO8zYSDNBe3yj52vHdznGe+ovCFtD/EP9ghqP0i8FKFW9ZvlvRN4Ui+8bjqOzEP
 mgbxm8v2ZdTSNPajhASa01Qr/XGZibIBzxSj++XP0olrsdhqbVvxgHJZZX936IqWv3BNLi
 B0ZEvWeQREVV+JmuICYic9krhwmQWSQX5qZh8CzPh0flWDOTmsFBYy84S2uSuL+D509VzP
 8BIYvNdmrBwIQhW/VU1Ix35lpKL9GKg3RvEZpUZZws6WJOCfdmRBdNeSR3bwNA==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/12] clk: renesas: Synchronize RZ R8A774E1 RZ/G2H clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:20 +0100
Message-ID: <20231203131635.119191-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ec3712dbc6ecb38408a
X-MBO-RS-META: pf6hc8u1rzck3n57df6ajjwfjzni17d8
X-Rspamd-Queue-Id: 4SjnQK0Dq0z9sd5
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

Synchronize RZ R8A774E1 RZ/G2H clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a774e1-cpg-mssr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a774e1-cpg-mssr.c b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
index 28d8a8832ae..6a8fe92b975 100644
--- a/drivers/clk/renesas/r8a774e1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
@@ -76,6 +76,7 @@ static const struct cpg_core_clk r8a774e1_core_clks[] __initconst = {
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774E1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
 	DEF_GEN3_Z("z2",	R8A774E1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("zg",	R8A774E1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774E1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774E1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774E1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -124,6 +125,7 @@ static const struct cpg_core_clk r8a774e1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774e1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774E1_CLK_ZG),
 	DEF_MOD("fdp1-1",		 118,	R8A774E1_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A774E1_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A774E1_CLK_S0D6),
@@ -221,7 +223,7 @@ static const struct mssr_mod_clk r8a774e1_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		 917,	R8A774E1_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774E1_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A774E1_CLK_S0D6),
-	DEF_MOD("adg",			 922,	R8A774E1_CLK_S0D1),
+	DEF_MOD("adg",			 922,	R8A774E1_CLK_S0D4),
 	DEF_MOD("iic-pmic",		 926,	R8A774E1_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A774E1_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A774E1_CLK_S0D6),
-- 
2.42.0

