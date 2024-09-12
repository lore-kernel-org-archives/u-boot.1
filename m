Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC95EEE270
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBD489125;
	Fri, 13 Sep 2024 01:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="swc5wUeP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qXn2XBPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE8889102; Fri, 13 Sep 2024 01:54:28 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB1D89111
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X4Z6V5TGpz9srN
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP05jO5Fle4SlPV7wVlbA/hUTd6XynSqvxD/7axjrp8=;
 b=swc5wUePu6NIr5EhHd9DfLfzB9XpJgrkRGhQoGT8Sb3Nl3LEI/I10p6tlsOTrQrkPfecdH
 oX34mtVDQ5UtCPZ27u1/M0SoNWkothKZO46sDIst/nYVMkX5DHW2l6lyFP5LXHuNQ4tMZB
 MQQhnglN5VE63bnuZ2zeX/fn0I7Rbo+n77ROQVyS9/F+9xGA34yjCq5bJc9+iYvG5Aw+H9
 96MA1dMgrT1x7q/qdU7Iv4qmY75O5g0auPKHMSBal+PG4bcvxkeyCTVXKpZxLTYF+yJ6gk
 PUup40bmH3mLRqUz9CIIBM3GJ14rBmyP0kUKmtPxsmMM5MadEai+4yLLpHZO+Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP05jO5Fle4SlPV7wVlbA/hUTd6XynSqvxD/7axjrp8=;
 b=qXn2XBPSKacgu7s3pZrEoJo1HNpHNwvIcOtR8gbecR0ulpIq2cziUOvfxnbVCfvFY+KjrZ
 5Von6LBkfX++OEUyEMPVyv8o2HvA8N6s2EAtniIgKskiNZlUCEwSd+XfZonofE1RmgJivi
 FMff6QwYPNnFIUZOXc4y1YFkZcozQF9GxA9fBwlahToOiJu/7N28mzVT8Z2rlTjkI689Ef
 nrMhQmJEwtwRzPbRpdClcSYbrxwVwAXUm8oz/N3rgsFlCxvyaf6oxA1L4KpgaMhuiBm1rE
 6T5FAMRifcABd/7RBJSvZzdjl1BEUI096Mqbd15nnTsP2vbYwvMDd6U5ZilsHw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/4] clk: renesas: Synchronize R-Car R8A779F0 S4 clock tables
 with Linux 6.10.9
Date: Fri, 13 Sep 2024 01:53:57 +0200
Message-ID: <20240912235407.348317-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
References: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a197q3ukuwt8t849auhpnyjj65grqm1g
X-MBO-RS-ID: 97d403fc764d2f6a88e
X-Rspamd-Queue-Id: 4X4Z6V5TGpz9srN
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

Synchronize R-Car R8A779F0 S4 clock tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index ea98bc6e50c..fdca63a3e8e 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
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
 	LAST_DT_CORE_CLK = R8A779F0_CLK_R,
@@ -110,13 +116,13 @@ static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
 	DEF_FIXED("sasyncperd2",R8A779F0_CLK_SASYNCPERD2, CLK_SASYNCPER,2, 1),
 	DEF_FIXED("sasyncperd4",R8A779F0_CLK_SASYNCPERD4, CLK_SASYNCPER,4, 1),
 
-	DEF_GEN4_SDH("sd0h",	R8A779F0_CLK_SD0H,	CLK_SDSRC,	   0x870),
-	DEF_GEN4_SD("sd0",	R8A779F0_CLK_SD0,	R8A779F0_CLK_SD0H, 0x870),
+	DEF_GEN4_SDH("sd0h",	R8A779F0_CLK_SD0H,	CLK_SDSRC,	   CPG_SD0CKCR),
+	DEF_GEN4_SD("sd0",	R8A779F0_CLK_SD0,	R8A779F0_CLK_SD0H, CPG_SD0CKCR),
 
 	DEF_BASE("rpc",		R8A779F0_CLK_RPC,	CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
 	DEF_BASE("rpcd2",	R8A779F0_CLK_RPCD2,	CLK_TYPE_GEN4_RPCD2, R8A779F0_CLK_RPC),
 
-	DEF_DIV6P1("mso",	R8A779F0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
+	DEF_DIV6P1("mso",	R8A779F0_CLK_MSO,	CLK_PLL5_DIV4,	CPG_MSOCKCR),
 
 	DEF_GEN4_OSC("osc",	R8A779F0_CLK_OSC,	CLK_EXTAL,	8),
 	DEF_GEN4_MDSEL("r",	R8A779F0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
-- 
2.45.2

