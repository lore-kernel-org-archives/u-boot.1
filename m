Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A91BEEE270
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF5089119;
	Fri, 13 Sep 2024 01:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UPUBJp8P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hTQ2ixgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8324489130; Fri, 13 Sep 2024 01:54:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BEC889119
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X4Z6W6J2Jz9srN
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 01:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nnvAxueocydLP23hoQhYQ8Q7G0SQMSiYowujIm6Ix0=;
 b=UPUBJp8PTD+AtYh4Wfkkv2J8qtSJCD/JKybEz1YpJsEfyRysNb5aSwOYrnpFM59u5atePg
 rBJwwuHtJ+U5XYhA4cOUX6kwBW09ScIr+wPgB3qfvrT3d1uFbcqyO2dAAoQu1BiOzUg7b6
 GvbNG37W7DDPAcWYIEm2Ue0ly1m0xacAgzjqLHO6QGcfERQKmI/NiiwexTzUEdhfqD6fCQ
 IBVP7jd2K70WbJGGI0hLjUjiH4PCRiCAVeKijf499w8haje5MSuHl7wue0Pd4w0cRpKsP/
 WpKEAIWw1w7Y0/ontsBSXJLfycSApejUpVJpGpCQbNPOCoGItp0wUSvjkYJFIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1726185265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nnvAxueocydLP23hoQhYQ8Q7G0SQMSiYowujIm6Ix0=;
 b=hTQ2ixgi+ismCRIbbpzur+2GdDFyrZemFzpve4glpjV0rnvKHapj+mcA5YiT8WI1OU5oE6
 ghgow9IuhuLZgrmbYt2WT5KCOLJad33sjqHcm9s1rEQb/c/LqurBrzOga8vhmXtHPeOHOx
 qvBGdDj1JVRK8nXz0OSQHJSAbA4CgX5U34i9mtcnLfw1MRYlsxzYmVbvM3di3L4oJrwCIq
 43t2AGvTLDZzuan1+d4/7O5nbellxzev5xnuYXtkoXyppSZdvd0yWYckQwuZXvztT2fUfN
 HvmGVWH4ghDK3s1Xd7Ns+PmJ3LP5UtrqNEssJK2B8W5XMXtfqYmlNedusa7UmA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 3/4] clk: renesas: Synchronize R-Car R8A779G0 V4H clock tables
 with Linux 6.10.9
Date: Fri, 13 Sep 2024 01:53:58 +0200
Message-ID: <20240912235407.348317-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
References: <20240912235407.348317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dtszzm9wanqkhpuin4b14txx165wxu7t
X-MBO-RS-ID: 1a38c4410bce6e68bac
X-Rspamd-Queue-Id: 4X4Z6W6J2Jz9srN
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

Synchronize R-Car R8A779G0 V4H clock tables with Linux 6.10.9,
commit 1611860f184a2c9e74ed593948d43657734a7098 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 4df0a69cfe1..9fb672a5369 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
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
 	LAST_DT_CORE_CLK = R8A779G0_CLK_CP,
@@ -141,14 +147,14 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("viobusd2",	R8A779G0_CLK_VIOBUSD2,	CLK_VIO,	2, 1),
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
 	DEF_FIXED("vcbusd2",	R8A779G0_CLK_VCBUSD2,	CLK_VC,		2, 1),
-	DEF_DIV6P1("canfd",     R8A779G0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
-	DEF_DIV6P1("csi",	R8A779G0_CLK_CSI,	CLK_PLL5_DIV4,	0x880),
+	DEF_DIV6P1("canfd",     R8A779G0_CLK_CANFD,	CLK_PLL5_DIV4,	CPG_CANFDCKCR),
+	DEF_DIV6P1("csi",	R8A779G0_CLK_CSI,	CLK_PLL5_DIV4,	CPG_CSICKCR),
 	DEF_FIXED("dsiref",	R8A779G0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
-	DEF_DIV6P1("dsiext",	R8A779G0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
+	DEF_DIV6P1("dsiext",	R8A779G0_CLK_DSIEXT,	CLK_PLL5_DIV4,	CPG_DSIEXTCKCR),
 
-	DEF_GEN4_SDH("sd0h",	R8A779G0_CLK_SD0H,	CLK_SDSRC,	   0x870),
-	DEF_GEN4_SD("sd0",	R8A779G0_CLK_SD0,	R8A779G0_CLK_SD0H, 0x870),
-	DEF_DIV6P1("mso",	R8A779G0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
+	DEF_GEN4_SDH("sd0h",	R8A779G0_CLK_SD0H,	CLK_SDSRC,	   CPG_SD0CKCR),
+	DEF_GEN4_SD("sd0",	R8A779G0_CLK_SD0,	R8A779G0_CLK_SD0H, CPG_SD0CKCR),
+	DEF_DIV6P1("mso",	R8A779G0_CLK_MSO,	CLK_PLL5_DIV4,	CPG_MSOCKCR),
 
 	DEF_BASE("rpc",		R8A779G0_CLK_RPC,	CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
 	DEF_BASE("rpcd2",	R8A779G0_CLK_RPCD2,	CLK_TYPE_GEN4_RPCD2, R8A779G0_CLK_RPC),
-- 
2.45.2

