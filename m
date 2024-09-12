Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD4BEEE270
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B423489111;
	Fri, 13 Sep 2024 01:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OPyFmpvZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u4sIyvR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A2B89120; Fri, 13 Sep 2024 01:54:28 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F859890E4
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X4Z6V1MTPz9srN
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Uw6IxUg68fLPe+5fzAboz7H43GcwxQfRXXqHJl7xvE=;
 b=OPyFmpvZUH8M3GqqrdkXxENygFM58ya41JRiu3SpXypjx8OgfewcxgkmpP8huOOZNh09jW
 1rqC7nPuuJuDTfE/1lxK1gOMdST7UTJQlxoHDnD3P06ZU2F7S50pYM7Z+6QvB2bIaYMmqg
 DyAB9yfxRM4UjUio6wzm0m6IlI6hvGW9hqugYw/r52QZfk2XDisTCVXqFXBWnM9O0FOIje
 VkevdngV/0DwFVsPbwFBlHECNJ9sYE76TIQYBwiyT13YTSTsrE3VPK2d6VV0/Z9Y4muyjk
 iWhtGKdRisLYAvJsIvS9hx2e5NFY0vYfTehSZVXa7y4xgqllb4oZdpvxwl+dTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Uw6IxUg68fLPe+5fzAboz7H43GcwxQfRXXqHJl7xvE=;
 b=u4sIyvR475A9tWVV2CdRF7S7fURFVKFyKOAZVOHODTrNkBE/pf5hxV+HXUtJ7AuEw5YDQI
 DnikXtuIUe4D6MW7V2FuJETxdEpEmbbm3FtpCAkcjRcdJUOL626t0U6E30aGnD4S/j2TLn
 i/48C4VepOOPm5w2UJOMNwW7LaM/FZCkKx98aEvwHBxShSgXot5vErF8sF7MoRdkrVzQ+k
 /KAVLxt2DHTI2vintnQGpRdXZSraih4WZWOVkXvqm9rb0QKt9QhOHsZvhrjUDp3A6TdChY
 zX5cumcozwpJ+jvMdcQ/C58kknCgDk381e5V2oJOeAS+Hr19dHuhRQGnXGQdnA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/4] clk: renesas: Synchronize R-Car R8A779A0 V3U clock tables
 with Linux 6.10.9
Date: Fri, 13 Sep 2024 01:53:56 +0200
Message-ID: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7rjc4coe6tbn7thmoic68xnncgks6idy
X-MBO-RS-ID: c5eae5c3db3a40dbf14
X-Rspamd-Queue-Id: 4X4Z6V1MTPz9srN
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

Synchronize R-Car R8A779A0 V3U clock tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 31 +++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index b44d5603edd..7875a990c2f 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -55,6 +55,17 @@ enum clk_ids {
 	DEF_BASE(_name, _id, CLK_TYPE_GEN4_PLL2X_3X, CLK_MAIN, \
 		 .offset = _offset)
 
+#define CPG_PLL20CR	0x0834	/* PLL20 Control Register */
+#define CPG_PLL21CR	0x0838	/* PLL21 Control Register */
+#define CPG_PLL30CR	0x083c	/* PLL30 Control Register */
+#define CPG_PLL31CR	0x0840	/* PLL31 Control Register */
+
+#define CPG_SD0CKCR	0x870	/* SD-IF0 Clock Frequency Control Register */
+#define CPG_CANFDCKCR	0x878	/* CAN-FD Clock Frequency Control Register */
+#define CPG_MSOCKCR	0x87c	/* MSIOF Clock Frequency Control Register */
+#define CPG_CSICKCR	0x880	/* CSI Clock Frequency Control Register */
+#define CPG_DSIEXTCKCR	0x884	/* DSI Clock Frequency Control Register */
+
 static const struct cpg_core_clk r8a779a0_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",  CLK_EXTAL),
@@ -64,10 +75,10 @@ static const struct cpg_core_clk r8a779a0_core_clks[] __initconst = {
 	DEF_BASE(".main", CLK_MAIN,	CLK_TYPE_GEN4_MAIN, CLK_EXTAL),
 	DEF_BASE(".pll1", CLK_PLL1,	CLK_TYPE_GEN4_PLL1, CLK_MAIN),
 	DEF_BASE(".pll5", CLK_PLL5,	CLK_TYPE_GEN4_PLL5, CLK_MAIN),
-	DEF_PLL(".pll20", CLK_PLL20,	0x0834),
-	DEF_PLL(".pll21", CLK_PLL21,	0x0838),
-	DEF_PLL(".pll30", CLK_PLL30,	0x083c),
-	DEF_PLL(".pll31", CLK_PLL31,	0x0840),
+	DEF_PLL(".pll20", CLK_PLL20,	CPG_PLL20CR),
+	DEF_PLL(".pll21", CLK_PLL21,	CPG_PLL21CR),
+	DEF_PLL(".pll30", CLK_PLL30,	CPG_PLL30CR),
+	DEF_PLL(".pll31", CLK_PLL31,	CPG_PLL31CR),
 
 	DEF_FIXED(".pll1_div2",		CLK_PLL1_DIV2,	CLK_PLL1,	2, 1),
 	DEF_FIXED(".pll20_div2",	CLK_PLL20_DIV2,	CLK_PLL20,	2, 1),
@@ -110,17 +121,17 @@ static const struct cpg_core_clk r8a779a0_core_clks[] __initconst = {
 	DEF_FIXED("cp",		R8A779A0_CLK_CP,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("cl16mck",	R8A779A0_CLK_CL16MCK,	CLK_PLL1_DIV2,	64, 1),
 
-	DEF_GEN4_SDH("sd0h",	R8A779A0_CLK_SD0H,	CLK_SDSRC,	   0x870),
-	DEF_GEN4_SD("sd0",	R8A779A0_CLK_SD0,	R8A779A0_CLK_SD0H, 0x870),
+	DEF_GEN4_SDH("sd0h",	R8A779A0_CLK_SD0H,	CLK_SDSRC,	   CPG_SD0CKCR),
+	DEF_GEN4_SD("sd0",	R8A779A0_CLK_SD0,	R8A779A0_CLK_SD0H, CPG_SD0CKCR),
 
 	DEF_BASE("rpc",		R8A779A0_CLK_RPC, CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
 	DEF_BASE("rpcd2",	R8A779A0_CLK_RPCD2, CLK_TYPE_GEN4_RPCD2,
 		 R8A779A0_CLK_RPC),
 
-	DEF_DIV6P1("mso",	R8A779A0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
-	DEF_DIV6P1("canfd",	R8A779A0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
-	DEF_DIV6P1("csi0",	R8A779A0_CLK_CSI0,	CLK_PLL5_DIV4,	0x880),
-	DEF_DIV6P1("dsi",	R8A779A0_CLK_DSI,	CLK_PLL5_DIV4,	0x884),
+	DEF_DIV6P1("mso",	R8A779A0_CLK_MSO,	CLK_PLL5_DIV4,	CPG_MSOCKCR),
+	DEF_DIV6P1("canfd",	R8A779A0_CLK_CANFD,	CLK_PLL5_DIV4,	CPG_CANFDCKCR),
+	DEF_DIV6P1("csi0",	R8A779A0_CLK_CSI0,	CLK_PLL5_DIV4,	CPG_CSICKCR),
+	DEF_DIV6P1("dsi",	R8A779A0_CLK_DSI,	CLK_PLL5_DIV4,	CPG_DSIEXTCKCR),
 
 	DEF_GEN4_OSC("osc",	R8A779A0_CLK_OSC,	CLK_EXTAL,	8),
 	DEF_GEN4_MDSEL("r",	R8A779A0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
-- 
2.45.2

