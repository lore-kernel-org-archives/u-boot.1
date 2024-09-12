Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF94EEE270
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D402A8913A;
	Fri, 13 Sep 2024 01:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OsnzTmQy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sL9Gm3S+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9137389119; Fri, 13 Sep 2024 01:54:30 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F97C89117
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X4Z6W5gj7z9sWx
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzPHdBfqZcw2l4abESKQyVaCPOzHnCVs7t+bUYa+pR4=;
 b=OsnzTmQyRMJxC/S9itSRwh0WFAayZLjhiepN+lHYHrNSBCME32g+IsYkO+hAdeu4HheT/y
 qyMhH1E8BAzFyB3shgfqMIH2DOVFs4crlzOoRyHzjH2WHKVCP3Etd+JaajurA+F+AYXBc9
 7fvN8tFFI13Abtefuvti9PYvHxnlVa+zlxLLxLp0k1tvYwv8d0Uu7Tt2y8by9pva0D/fO/
 8I3+hRksE5hGXr2iCi3MlSqJYAftScSrN9wEDmz0H4J3huZ8f4QRWAgzpzhdsfwh4YM3IL
 i69J1xF4Jem0qo82/f2o1HbQQIdFWRzPTQQfXZdEbRuCA7ZxbypdR6CWGav4Tg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzPHdBfqZcw2l4abESKQyVaCPOzHnCVs7t+bUYa+pR4=;
 b=sL9Gm3S+hbJSRgCAkHtmgwhlp5qGPrXE/yrUuAQCgALPabsullJk/7y3OLQ7+ga21bZP1n
 jPC4/abD+AcnWXm+wUGOAoybhHoRu0SAMg7lycBY0h7SrZw5R+9ktInl2h4vHO6Fxlj2p1
 fM+W8Pijdmn+S/F45oOXYupR+K5V9Y8+9EIKpScoE17ROutSowOXxG9Epw34wGibrPIHhS
 nbJYhpDbr9h075UUSdd0PvrQ4t51+45JkaMm097uQZzX6MgpYuWOi24IgQfz3irz2vLHHM
 PNRV8lI5ZU4rDJmYf/Ozcea5m/LnMQ5m3yUbzdLoIK/38jLtoKG5ir+RULUjhw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 4/4] clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables
 with Linux 6.10.9
Date: Fri, 13 Sep 2024 01:53:59 +0200
Message-ID: <20240912235407.348317-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
References: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4oeuaegyi9ww4djxr1jgxkaaacw58ukr
X-MBO-RS-ID: 601a07c6370c21e7f57
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

Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 64 ++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
index b20d559bee2..2e98e262fb0 100644
--- a/drivers/clk/renesas/r8a779h0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -15,6 +15,12 @@
 #include "renesas-cpg-mssr.h"
 #include "rcar-gen3-cpg.h"
 
+#define CPG_SD0CKCR	0x870	/* SD-IF0 Clock Frequency Control Register */
+#define CPG_CANFDCKCR	0x878	/* CAN-FD Clock Frequency Control Register */
+#define CPG_MSOCKCR	0x87c	/* MSIOF Clock Frequency Control Register */
+#define CPG_CSICKCR	0x880	/* CSI Clock Frequency Control Register */
+#define CPG_DSIEXTCKCR	0x884	/* DSI Clock Frequency Control Register */
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R8A779H0_CLK_R,
@@ -155,14 +161,14 @@ static const struct cpg_core_clk r8a779h0_core_clks[] = {
 	DEF_FIXED("viobusd2",	R8A779H0_CLK_VIOBUSD2,	CLK_VIOSRC,	2, 1),
 	DEF_FIXED("vcbusd1",	R8A779H0_CLK_VCBUSD1,	CLK_VCSRC,	1, 1),
 	DEF_FIXED("vcbusd2",	R8A779H0_CLK_VCBUSD2,	CLK_VCSRC,	2, 1),
-	DEF_DIV6P1("canfd",	R8A779H0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
-	DEF_DIV6P1("csi",	R8A779H0_CLK_CSI,	CLK_PLL5_DIV4,	0x880),
+	DEF_DIV6P1("canfd",	R8A779H0_CLK_CANFD,	CLK_PLL5_DIV4,	CPG_CANFDCKCR),
+	DEF_DIV6P1("csi",	R8A779H0_CLK_CSI,	CLK_PLL5_DIV4,	CPG_CSICKCR),
 	DEF_FIXED("dsiref",	R8A779H0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
-	DEF_DIV6P1("dsiext",	R8A779H0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
-	DEF_DIV6P1("mso",	R8A779H0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
+	DEF_DIV6P1("dsiext",	R8A779H0_CLK_DSIEXT,	CLK_PLL5_DIV4,	CPG_DSIEXTCKCR),
+	DEF_DIV6P1("mso",	R8A779H0_CLK_MSO,	CLK_PLL5_DIV4,	CPG_MSOCKCR),
 
-	DEF_GEN4_SDH("sd0h",	R8A779H0_CLK_SD0H,	CLK_SDSRC,	   0x870),
-	DEF_GEN4_SD("sd0",	R8A779H0_CLK_SD0,	R8A779H0_CLK_SD0H, 0x870),
+	DEF_GEN4_SDH("sd0h",	R8A779H0_CLK_SD0H,	CLK_SDSRC,	   CPG_SD0CKCR),
+	DEF_GEN4_SD("sd0",	R8A779H0_CLK_SD0,	R8A779H0_CLK_SD0H, CPG_SD0CKCR),
 
 	DEF_BASE("rpc",		R8A779H0_CLK_RPC,	CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
 	DEF_BASE("rpcd2",	R8A779H0_CLK_RPCD2,	CLK_TYPE_GEN4_RPCD2, R8A779H0_CLK_RPC),
@@ -175,6 +181,9 @@ static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
 	DEF_MOD("avb0:rgmii0",	211,	R8A779H0_CLK_S0D8_HSC),
 	DEF_MOD("avb1:rgmii1",	212,	R8A779H0_CLK_S0D8_HSC),
 	DEF_MOD("avb2:rgmii2",	213,	R8A779H0_CLK_S0D8_HSC),
+	DEF_MOD("canfd0",	328,	R8A779H0_CLK_SASYNCPERD2),
+	DEF_MOD("csi40",	331,	R8A779H0_CLK_CSI),
+	DEF_MOD("csi41",	400,	R8A779H0_CLK_CSI),
 	DEF_MOD("hscif0",	514,	R8A779H0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif1",	515,	R8A779H0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif2",	516,	R8A779H0_CLK_SASYNCPERD1),
@@ -183,14 +192,57 @@ static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
 	DEF_MOD("i2c1",		519,	R8A779H0_CLK_S0D6_PER),
 	DEF_MOD("i2c2",		520,	R8A779H0_CLK_S0D6_PER),
 	DEF_MOD("i2c3",		521,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("irqc",		611,	R8A779H0_CLK_CL16M),
+	DEF_MOD("ispcs0",	612,	R8A779H0_CLK_S0D2_VIO),
+	DEF_MOD("ispcs1",	613,	R8A779H0_CLK_S0D2_VIO),
+	DEF_MOD("msi0",		618,	R8A779H0_CLK_MSO),
+	DEF_MOD("msi1",		619,	R8A779H0_CLK_MSO),
+	DEF_MOD("msi2",		620,	R8A779H0_CLK_MSO),
+	DEF_MOD("msi3",		621,	R8A779H0_CLK_MSO),
+	DEF_MOD("msi4",		622,	R8A779H0_CLK_MSO),
+	DEF_MOD("msi5",		623,	R8A779H0_CLK_MSO),
+	DEF_MOD("pcie0",	624,	R8A779H0_CLK_S0D2_HSC),
+	DEF_MOD("pwm",		628,	R8A779H0_CLK_SASYNCPERD4),
 	DEF_MOD("rpc-if",	629,	R8A779H0_CLK_RPCD2),
+	DEF_MOD("scif0",	702,	R8A779H0_CLK_SASYNCPERD4),
+	DEF_MOD("scif1",	703,	R8A779H0_CLK_SASYNCPERD4),
+	DEF_MOD("scif3",	704,	R8A779H0_CLK_SASYNCPERD4),
+	DEF_MOD("scif4",	705,	R8A779H0_CLK_SASYNCPERD4),
 	DEF_MOD("sdhi0",	706,	R8A779H0_CLK_SD0),
 	DEF_MOD("sydm1",	709,	R8A779H0_CLK_S0D6_PER),
 	DEF_MOD("sydm2",	710,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("tmu0",		713,	R8A779H0_CLK_SASYNCRT),
+	DEF_MOD("tmu1",		714,	R8A779H0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu2",		715,	R8A779H0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu3",		716,	R8A779H0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu4",		717,	R8A779H0_CLK_SASYNCPERD2),
+	DEF_MOD("vin00",	730,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin01",	731,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin02",	800,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin03",	801,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin04",	802,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin05",	803,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin06",	804,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin07",	805,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin10",	806,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin11",	807,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin12",	808,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin13",	809,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin14",	810,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin15",	811,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin16",	812,	R8A779H0_CLK_S0D4_VIO),
+	DEF_MOD("vin17",	813,	R8A779H0_CLK_S0D4_VIO),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779H0_CLK_R),
+	DEF_MOD("cmt0",		910,	R8A779H0_CLK_R),
+	DEF_MOD("cmt1",		911,	R8A779H0_CLK_R),
+	DEF_MOD("cmt2",		912,	R8A779H0_CLK_R),
+	DEF_MOD("cmt3",		913,	R8A779H0_CLK_R),
 	DEF_MOD("pfc0",		915,	R8A779H0_CLK_CP),
 	DEF_MOD("pfc1",		916,	R8A779H0_CLK_CP),
 	DEF_MOD("pfc2",		917,	R8A779H0_CLK_CP),
+	DEF_MOD("tsc2:tsc1",	919,	R8A779H0_CLK_CL16M),
+	DEF_MOD("ssiu",		2926,	R8A779H0_CLK_S0D6_PER),
+	DEF_MOD("ssi",		2927,	R8A779H0_CLK_S0D6_PER),
 };
 
 /*
-- 
2.45.2

