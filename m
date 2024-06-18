Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F4C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8608883FE;
	Wed, 19 Jun 2024 00:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b4a1spSs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Kb7QoLZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A82883C9; Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9007B87B1A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W3htF2fYQz9stj
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfvMPIsMaJsolR72FG89FDVG6x3BzdJ7QHUKhKLav5Y=;
 b=b4a1spSsCdQSGBpMLXGRHcF1/PzIkgchYpGlL0Q2TGtqMVi/PyBsl6M0M+z54Iit+A3iO1
 AwsGP3PAkGnaMbUBPVqtfu6sJaPWKtfw8wjOwFWkhPpkGocdTcDd2q2VebP7EYgmpVkY/I
 AzMHS9d0Gp2BnGBebUq6KLBNzmKlqsNOwdsU0GdPdRhBoIQC0PnRKM+1sPHQVsRWIhdct2
 f6uIpXWVMIDKcA3nAe7U0EqNYz+DEBPcCy007STDDT1uGim3mMSoakmrn+cEil1+p5cqpT
 Kb4ujXROxOf/45FB/8H18SBfqQdxa7bEBq0eau3TjhVXNPDZMZ5MLSULA0Ux/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfvMPIsMaJsolR72FG89FDVG6x3BzdJ7QHUKhKLav5Y=;
 b=Kb7QoLZK9ERuIigXQKnpKOYgpGeTnjRyBs5WvgOKYiVAGZblAFdGgkRfpicrit+HLcY0A7
 aXQeXY2uEj7M3d6H8Ep0wptGun8eCPtXO1lRIEgMFuB0VKiy1Z6KXl7BThCaxFS4up4VTW
 P1AZRVfeHfn6qM3anp8zLRnyt1yqwJL03iIdImR4W2oLZ3IrXrGuuxPeTyOZoDx61fejqW
 qrwWB5grVaIG6v/P+K8KkhZ3qlxENy1nVb6EBKnDf/PoGBR7pi8//DO+8yCyHnqRmPbzvo
 dHGRTPAMaugoFKOHEq9yuPKEzedmDZnL9JBNO2ljF4evufdCdZGlBil+4x+HWA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 5/6] clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables
 with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:19 +0200
Message-ID: <20240618225505.154437-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
References: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6e8a5bc87afb2daa69d
X-MBO-RS-META: cu9ssfjcqm5omca7mnyzssbztwr1xwdh
X-Rspamd-Queue-Id: 4W3htF2fYQz9stj
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

Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
index 502b20b554a..b20d559bee2 100644
--- a/drivers/clk/renesas/r8a779h0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -172,9 +172,9 @@ static const struct cpg_core_clk r8a779h0_core_clks[] = {
 };
 
 static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
-	DEF_MOD("avb0-rgmii0",	211,	R8A779H0_CLK_S0D8_HSC),
-	DEF_MOD("avb1-rgmii1",	212,	R8A779H0_CLK_S0D8_HSC),
-	DEF_MOD("avb2-rgmii2",	213,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("avb0:rgmii0",	211,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("avb1:rgmii1",	212,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("avb2:rgmii2",	213,	R8A779H0_CLK_S0D8_HSC),
 	DEF_MOD("hscif0",	514,	R8A779H0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif1",	515,	R8A779H0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif2",	516,	R8A779H0_CLK_SASYNCPERD1),
@@ -185,9 +185,12 @@ static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
 	DEF_MOD("i2c3",		521,	R8A779H0_CLK_S0D6_PER),
 	DEF_MOD("rpc-if",	629,	R8A779H0_CLK_RPCD2),
 	DEF_MOD("sdhi0",	706,	R8A779H0_CLK_SD0),
-	DEF_MOD("pfc0",		915,	R8A779H0_CLK_CL16M),
-	DEF_MOD("pfc1",		916,	R8A779H0_CLK_CL16M),
-	DEF_MOD("pfc2",		917,	R8A779H0_CLK_CL16M),
+	DEF_MOD("sydm1",	709,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("sydm2",	710,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("wdt1:wdt0",	907,	R8A779H0_CLK_R),
+	DEF_MOD("pfc0",		915,	R8A779H0_CLK_CP),
+	DEF_MOD("pfc1",		916,	R8A779H0_CLK_CP),
+	DEF_MOD("pfc2",		917,	R8A779H0_CLK_CP),
 };
 
 /*
-- 
2.43.0

