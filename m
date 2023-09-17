Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6ECD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9A986A26;
	Sun, 17 Sep 2023 16:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v+fmOoPy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mNwQxi1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384C586A81; Sun, 17 Sep 2023 16:12:09 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B407A86A49
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVHB4q1Wz9sb5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33AyZ+vwUP/eZlqz3jY1ORlygx2soD9o1rjlu7TG6ko=;
 b=v+fmOoPytyGivaNeOo3ngxNOoCNkJ01NCYAAhuohJLLk/j237rAfjXtyF9aRqkYYOoFyU3
 zPXaF0RuCfA9Lpcfsoy8EiplO5z6cNLLZVb2Ht+ql5+ujcwRuMoafG1lIrRVWLePpqkts4
 N6bAbectnHubSOqUqfbJI0EdfBwYMI4X1pQXMd2Y8JDHq6+zaV90XN3/mLij1Y1+nqfL4o
 q/bTDLr8H8vcovuufmd2e2OPFTyTQz5Xs3Rd8gF4f/e7DHKVLUghbUrJ04wzNpzClPBKQ4
 D+1WHiq0RA7R8WQAPXq8h+AiJb+WCv3Uudl5LGHfxUacOyn6rCE9+m08letwtg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33AyZ+vwUP/eZlqz3jY1ORlygx2soD9o1rjlu7TG6ko=;
 b=mNwQxi1RmWh0gdjOFmOsk6rdIV8xJeo0u4sRx4ZQoM/2r8Old6G1K35XddDNdXEQ5xKa1Y
 VA6DLjleHaxoIjipNQZN+kF9OCOkf7EyNuU62T3bvJlm3Z/LdeB0xSFRnKJ+7zE6Kk3wON
 Xe3sBWa4iVnUxpaRm4OIKGXLT1XVCaOySe/oSYW02xozQFpv4xIxq441OHrY+7RHYMnMAL
 pJfr+BZcvoN/HyU87ga77xE8EfJLVWxKMLyYB3M1yzfu0MmLLvLPq0OtfkEUa0OGbrV3mm
 fbtuoLji3JiZchAR04Q0BjmVnZajobxUkNmbFeFZbgvJVTsVqFALCCG+ArNzTg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/20] clk: renesas: Synchronize R8A779A0 V3U clock tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:35 +0200
Message-Id: <20230917141141.379884-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8uo6yd5ctmo5xax4e5jfgru1tibqoqcq
X-MBO-RS-ID: ab0b31ffa6cb76976d2
X-Rspamd-Queue-Id: 4RpVHB4q1Wz9sb5
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

Synchronize R-Car R8A779A0 V3U clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index 6b7ec36ab05..652bfe4f6d3 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -56,7 +56,7 @@ enum clk_ids {
 	DEF_BASE(_name, _id, CLK_TYPE_GEN4_PLL2X_3X, CLK_MAIN, \
 		 .offset = _offset)
 
-static const struct cpg_core_clk r8a779a0_core_clks[] = {
+static const struct cpg_core_clk r8a779a0_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",  CLK_EXTAL),
 	DEF_INPUT("extalr", CLK_EXTALR),
@@ -127,7 +127,7 @@ static const struct cpg_core_clk r8a779a0_core_clks[] = {
 	DEF_GEN4_MDSEL("r",	R8A779A0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
 };
 
-static const struct mssr_mod_clk r8a779a0_mod_clks[] = {
+static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("avb0",		211,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb1",		212,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb2",		213,	R8A779A0_CLK_S3D2),
@@ -165,14 +165,15 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] = {
 	DEF_MOD("msi3",		621,	R8A779A0_CLK_MSO),
 	DEF_MOD("msi4",		622,	R8A779A0_CLK_MSO),
 	DEF_MOD("msi5",		623,	R8A779A0_CLK_MSO),
+	DEF_MOD("pwm0",		628,	R8A779A0_CLK_S1D8),
 	DEF_MOD("rpc-if",	629,	R8A779A0_CLK_RPCD2),
 	DEF_MOD("scif0",	702,	R8A779A0_CLK_S1D8),
 	DEF_MOD("scif1",	703,	R8A779A0_CLK_S1D8),
 	DEF_MOD("scif3",	704,	R8A779A0_CLK_S1D8),
 	DEF_MOD("scif4",	705,	R8A779A0_CLK_S1D8),
 	DEF_MOD("sdhi0",	706,	R8A779A0_CLK_SD0),
-	DEF_MOD("sydm1",	709,	R8A779A0_CLK_S1D2),
-	DEF_MOD("sydm2",	710,	R8A779A0_CLK_S1D2),
+	DEF_MOD("sys-dmac1",	709,	R8A779A0_CLK_S1D2),
+	DEF_MOD("sys-dmac2",	710,	R8A779A0_CLK_S1D2),
 	DEF_MOD("tmu0",		713,	R8A779A0_CLK_CL16MCK),
 	DEF_MOD("tmu1",		714,	R8A779A0_CLK_S1D4),
 	DEF_MOD("tmu2",		715,	R8A779A0_CLK_S1D4),
-- 
2.40.1

