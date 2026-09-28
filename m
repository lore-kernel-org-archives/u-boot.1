Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B72C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45CB660697;
	Mon, 28 Sep 2026 10:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THG5ZOt2Dqkk; Mon, 28 Sep 2026 10:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0E4146067F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590501;
	b=beeAvyOxYnR/3JJziDVA6uoAwyBc+ZQ3L7/PUSn8JIORAkzZl/UgbRrUMh2FKXh6yKiI
	 XZKxnIM+lhUS35dq/Ra7brQk1/3BorcRAlF7r6g4bpUuq/gISocGb3ssT3zDvqFozCuI1
	 ghKVvkDtFXft+8wMTNOKH40f9BQHbq2BvJmM0C3nIL4940kygn2zGMxt4zcZJIutggO9e
	 teqhiw2j21W0E4YLVnXug1OJyB0Pnh10lnQz3rCPTE+k9eg0aMIW+XKfsVNz7x0wD/3Oi
	 76AqDb/Zn+A60mVuOGqOKb3YRQ0Aex3HSDrqfWg844GUkNoRu/OmWd0mNCrt9doyRmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jy5+okCJUEwGoWVvCQ4SdWYWt9MjyPyg7rpb/8+hPBY=;
	b=RNgFMVwXSWEchRALYzlSnc9DDeti68s5jJpgud0Ddo8GtNT23H5x/1UbQRlpP36riXyr
	 HuB+WW/wrcNX1lpr5mBusj299lBFTEqzEq/TXAKaVaaQUPCTBh4IZLcy7U2npGR8ryvqm
	 YVrdd+HrwTO9RFd1sp5cZRAuXqDkKMej/23nBTjxSVTZzjbZxWCzBR1MyalgZrUePsL3Q
	 Js9cl/vFVUCtqW/TDnle0y71FSXrCwk7uOugt5asWl6jx/axEZK/orxePUWggtuEbaV3o
	 mlE9kGvpQf2GEoPyWuyeID+PMbZkfmKJaNalrR14gf+CZnqqnFqBuBes4bXe/M4f7Qg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590501;
	bh=Jy5+okCJUEwGoWVvCQ4SdWYWt9MjyPyg7rpb/8+hPBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dN9dtzQ+hieroW5g+8+XL6Vpi59+Xtv2lDFLOPsTir/R8QusV5FmucOBkcq1Mg93f
	 KXmAurWKPVCBNckL+UXbAor6b9djEItxBSjmGm79wAdqmuXPO4hVhNxZ7Gb0zxxWfJ
	 ddRbpBN59d/fUBVsCGIrDi/zRke1v80PWekgc5reK3zBJbqu9K/qOTmQG1XM2VYtNr
	 RHIqUueJUCYHuFpsXu8gr7SVI8bXl6xW7eKfoh8dU9AoaD0WW7fqmqbGMbzlwxc213
	 cMBQSumm0XNySsyqysQ85vzQmMBRH5xEqe4trWwVeARhMrq/4LjigWsaA7Nb5OGROa
	 R8gTkc6uRVwJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E4146067F;
	Mon, 28 Sep 2026 10:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F080F361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6CBA401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_y1YzOmxDoF for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 99D9A4019A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590498;
 b=jBv+BY0/+AJuzCy1iLhWl11pUQik+e5019kA97taHd8qTgrB2koj5DgtSpj7KliRSuCZ
 kC4avUCTXVDRbT7FEdiMMJdpDVavb4U9QY7IspnAWzGu64obTPlVKCjr/wSx9wNtGV+Le
 LvmLVNIedNE7xeAeQi2hiAtIG7+APCDHcd83ozv4cIsF5Xoq48qkeIRFbM1jsivQa5axa
 IOqeZX27BVRdFBH3OOOJVju2iws8dWxdEr/6GWAQZQ8mhwzyQ4r7HIGJVcaGfL9cAmfZ8
 mzoY5+BIj32Nz8s99yfydroC+apCXor0Q0wrGPkQAAgBSCvTjOi5Nk4KDmpGci47Kfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590498;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Jy5+okCJUEwGoWVvCQ4SdWYWt9MjyPyg7rpb/8+hPBY=;
 b=lTzjVt+BcgJ2YqFFfuJs16VMjoF4cuCBoEB5UYeIQm8+NeFd/tdceuGGJXdjMs69pCGU
 HwNUd5JYYbUtOYDB7/9C5FBYDi+GMoMR+VeKaDfSMiEzkYYOoPaEw16sgKmeAlba0CF3w
 ZoH54PWv4kZf4QeBjUtlFbKOoeTp8Z3X/pYJNeBCm0/PwulJHQ0G7xzQHa9CWwz6Cq+9V
 WSvdR8rg6Li6oA6OTekH83BSZTLbV6zsJb4nUGsF3u9lNZRX/rkV+p9r+jivm5UyHezz1
 0NIfPwszI7tS6Ei3nwdICVPTkYFp+5mRT3mCfqLTqU7+nUPDJ61xVHp2XmWimnCBgGA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Njfko6iT; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Njfko6iT
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99D9A4019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B3EFCB00539;
 Mon, 28 Sep 2026 12:14:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590495;
 bh=tRMwmnSnqOFS/3QSyyHp7ZltajnDcuxtkAZwyjFpUOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Njfko6iT+VaIlIW7NesTJj8cMNx3WnD4KOW5371kSbD6MeZEr2DcHL7ApmYiJaP33
 lgu3bbfzEIt+T4oD5kloXJmiwcGpbpUA72Fygt4ZYdGYVC4uR834Xsy3OUl7+Et7Y1
 qNkOjOk1FKGytsFsOTo4qqjU5nVabKq5ZLJqjrHVQzwsdasaA+wjmuLIM5iyY6O4RM
 agr524s9PHxVnri58xvQl7eO5sa1V0ZslljhzBU1y0prBSnqqm6YyiKpmDuVPong4j
 NtIMe56iFT7EKDdPrgNddB+a7tQkCpzzgmC1bgVZ5Gt4Vb4hpqTcyuLLrjpau8JtGE
 MHAGjIU2qHmyA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 03/10] board: lx2160a: serdes: set SD1 with a table
Date: Mon, 28 Sep 2026 12:13:22 +0200
Message-ID: <20260928101330.881662-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The SD1 lane configuration can support many cases, not just the
1x100GE + 4x25G split.

Let's describe each one as an entry of a table.
Then, let's check the serdes1:<mode> of hwconfig.

The master-lane lookup, the halt and the reset of the split become
helpers.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 272 +++++++++++++++++++++----------
 board/nxp/lx2160a/serdes_split.h |  16 +-
 2 files changed, 192 insertions(+), 96 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 1a5c44e7740..11bec35fd22 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -12,6 +12,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
+#include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/delay.h>
@@ -245,16 +246,22 @@ static void print_rcw_view(int sd)
 
 #if defined(CONFIG_ARCH_LX2160A)
 
-/*
- * The split itself.
- *
- * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
- * U-Boot.
- */
-#define SPLIT_FIRST_LANE	4	/* LNE */
-#define SPLIT_LAST_LANE		7	/* LNH */
+struct sd1_mode {
+	const char *name;			/* hwconfig serdes1:<name> */
+	const char *desc;
+	const char *from;
+	bool (*is_active)(unsigned long base);
+	int (*enter)(unsigned long base);
+};
+
+#define SD1_LNE_LNH		GENMASK(7, 4)
+
+#define SRDS_POLL_US		10000		/* NXP waits ~100 cycles   */
 
 /*
+ * 1x 100GE + 4x 25G. This is NXP's e100g1_split.rcw sequence, adapted
+ * from the PBI sequence to U-Boot.
+ *
  * PROTO_SEL=11010b (25G/50G/100G, shared) + IF_WIDTH=100b (40-bit),
  * PORT_RST_LEFT=0 and PORT_LN0_B=0 so every lane becomes its own
  * single-lane port. Only those last two bits actually change: the
@@ -264,31 +271,24 @@ static void print_rcw_view(int sd)
 #define SPLIT_PCCE		0x00000100	/* E100Ga off, E100Gb on   */
 #define SPLIT_PCCD		0x11110000	/* E25Ga..E25Gd on         */
 
-#define SPLIT_POLL_US		10000		/* NXP waits ~100 cycles   */
-
-static bool srds1_split_state(unsigned long base)
+static bool sd1_is_2x100g(unsigned long base)
 {
 	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
 
-	return PCCE_E100GA_CFG(pcce) == 0 &&
-	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
-	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
-}
-
-bool lx2160a_serdes1_is_split(void)
-{
-	return srds1_split_state(srds_base(FSL_SRDS_1));
+	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
+	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
+	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
 }
 
-static bool srds1_is_unsplit(unsigned long base)
+static bool sd1_is_100g4x25g(unsigned long base)
 {
 	u32 pccd = in_le32((void __iomem *)SRDS_PCCD(base));
 	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
 
-	return PCCE_E100GA_CFG(pcce) != 0 && PCCE_E100GB_CFG(pcce) != 0 &&
-	       PCCD_E25G_CFG(pccd, 0) == 0 && PCCD_E25G_CFG(pccd, 1) == 0 &&
-	       PCCD_E25G_CFG(pccd, 2) == 0 && PCCD_E25G_CFG(pccd, 3) == 0;
+	return PCCE_E100GA_CFG(pcce) == 0 &&
+	       PCCD_E25G_CFG(pccd, 0) && PCCD_E25G_CFG(pccd, 1) &&
+	       PCCD_E25G_CFG(pccd, 2) && PCCD_E25G_CFG(pccd, 3);
 }
 
 /*
@@ -298,7 +298,7 @@ static bool srds1_is_unsplit(unsigned long base)
  */
 static int poll_clear(unsigned long reg, u32 bit)
 {
-	int us = SPLIT_POLL_US;
+	int us = SRDS_POLL_US;
 
 	while (us--) {
 		if (!(in_le32((void __iomem *)reg) & bit))
@@ -309,79 +309,82 @@ static int poll_clear(unsigned long reg, u32 bit)
 	return -ETIMEDOUT;
 }
 
-int lx2160a_serdes1_split(void)
+static int sd1_port_master(unsigned long base, unsigned long lanes)
 {
-	unsigned long base = srds_base(FSL_SRDS_1);
-	int m, master = -1, ret = 0;
-
-	if (srds1_split_state(base)) {
-		debug("lx2160a serdes: SD1 already split, nothing to do\n");
-		return 0;
-	}
+	int m, master = -1;
 
-	if (!srds1_is_unsplit(base)) {
-		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
-		       in_le32((void __iomem *)SRDS_PCCD(base)),
-		       in_le32((void __iomem *)SRDS_PCCE(base)));
-		return -EINVAL;
-	}
-
-	/*
-	 * Halt. "Halt only has meaning on the master source
-	 * clock lane of a port (LNmGCR0[PORT_LN0_B]=0)". Lanes E-H are one
-	 * 100G port at this point, so exactly one of them is the master and
-	 * the other three requests are ignored. Issue all four anyway
-	 * (that is what NXP's sequence does) but only wait on the lane
-	 * where the bit can actually clear.
-	 */
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+	for_each_set_bit(m, &lanes, SRDS_LANES)
 		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
 		      GCR0_PORT_LN0_B))
 			master = m;
+
+	if (master < 0)
+		printf("lx2160a serdes: no master lane among LN%c-LN%c, refusing\n",
+		       'A' + (int)__ffs(lanes), 'A' + (int)__fls(lanes));
+
+	return master;
+}
+
+/*
+ * Halt the port made of @lanes.
+ *
+ * "Halt only has meaning on the master source clock lane of a port
+ * (LNmGCR0[PORT_LN0_B]=0)", so the request goes to every lane, as
+ * NXP's sequence does, and only the master is waited on:
+ * it is the one lane where the bit can clear.
+ *
+ *  -EINVAL means nothing was touched
+ *  -ETIMEDOUT is only a warning
+ */
+static int sd1_halt_port(unsigned long base, unsigned long lanes)
+{
+	int m, master = sd1_port_master(base, lanes);
+
+	if (master < 0)
+		return -EINVAL;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_HLT_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
 			 RSTCTL_HLT_REQ);
 	}
 
-	if (master < 0) {
-		printf("lx2160a serdes: no master lane among LNE-LNH, refusing\n");
-		return -EINVAL;
-	}
-
 	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
 	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
 		printf("lx2160a serdes: LN%c did not halt within %d us, continuing\n",
-		       'A' + master, SPLIT_POLL_US);
-		ret = -ETIMEDOUT;
+		       'A' + master, SRDS_POLL_US);
+		return -ETIMEDOUT;
 	}
 
-	/*
-	 * Reconfigure while halted: four one-lane ports instead of one
-	 * four-lane port. Everything else about the lane is unchanged.
-	 */
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++)
-		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
+	return 0;
+}
 
-	/* Re-point the protocol converters. */
-	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
-	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
+static void sd1_reset_req(unsigned long base, unsigned long lanes, int skip)
+{
+	int m;
 
-	/* Reset. Every lane is its own master now, so all four count. */
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		if (m == skip)
+			continue;
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 	}
+}
+
+static int sd1_reset_wait(unsigned long base, unsigned long lanes)
+{
+	int m, ret = 0;
 
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
 		u32 t, r;
 
 		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
 		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
 			printf("lx2160a serdes: LN%c reset did not complete within %d us\n",
-			       'A' + m, SPLIT_POLL_US);
+			       'A' + m, SRDS_POLL_US);
 			ret = -ETIMEDOUT;
 			continue;
 		}
@@ -395,33 +398,138 @@ int lx2160a_serdes1_split(void)
 		}
 	}
 
-	if (!srds1_split_state(base)) {
-		printf("lx2160a serdes: split did not take (PCCD=%08x PCCE=%08x)\n",
-		       in_le32((void __iomem *)SRDS_PCCD(base)),
-		       in_le32((void __iomem *)SRDS_PCCE(base)));
-		return -EIO;
+	return ret;
+}
+
+static int sd1_enter_100g4x25g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, ret, err;
+
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	/*
+	 * Reconfigure while halted: four 1-lane ports instead of one
+	 * 4-lane port. Everything else about the lane is unchanged.
+	 */
+	for_each_set_bit(m, &lanes, SRDS_LANES)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
+
+	/* Re-point the protocol converters. */
+	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
+	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
+
+	/* Reset. Every lane is its own master now, so all four count. */
+	sd1_reset_req(base, lanes, -1);
+	err = sd1_reset_wait(base, lanes);
+
+	return err ? err : ret;
+}
+
+static const struct sd1_mode sd1_modes[] = {
+	{
+		.name = "2x100g",
+		.desc = "2x 100GE",
+		.is_active = sd1_is_2x100g,
+	},
+	{
+		.name = "100g4x25g",
+		.desc = "1x 100GE + 4x 25G",
+		.from = "2x100g",
+		.is_active = sd1_is_100g4x25g,
+		.enter = sd1_enter_100g4x25g,
+	},
+};
+
+static const struct sd1_mode *sd1_mode_find(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++)
+		if (!strcmp(sd1_modes[i].name, name))
+			return &sd1_modes[i];
+
+	return NULL;
+}
+
+static void sd1_print_pcc(unsigned long base)
+{
+	printf("PCCC=%08x PCCD=%08x PCCE=%08x",
+	       in_le32((void __iomem *)SRDS_PCCC(base)),
+	       in_le32((void __iomem *)SRDS_PCCD(base)),
+	       in_le32((void __iomem *)SRDS_PCCE(base)));
+}
+
+/* Put SD1 in @mode, for serdes1:@target */
+static int sd1_enter(const struct sd1_mode *mode,
+		     const struct sd1_mode *target, int depth)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	const struct sd1_mode *from;
+	int ret;
+
+	if (mode->is_active(base))
+		return 0;
+
+	if (!mode->enter) {
+		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
+		       target->name, mode->desc);
+		sd1_print_pcc(base);
+		printf("), refusing\n");
+		return -EINVAL;
+	}
+
+	from = sd1_mode_find(mode->from);
+	if (!from || depth >= ARRAY_SIZE(sd1_modes))
+		return -EINVAL;
+
+	ret = sd1_enter(from, target, depth + 1);
+	if (ret)
+		return ret;
+
+	ret = mode->enter(base);
+	if (!mode->is_active(base)) {
+		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
+		sd1_print_pcc(base);
+		printf("), stopping\n");
+		return ret ? ret : -EIO;
 	}
 
-	printf("lx2160a serdes: SD1 100GE.1 split into 4x 25G%s\n",
+	printf("lx2160a serdes: SD1 now %s%s\n", mode->desc,
 	       ret ? " (with warnings above)" : "");
 
-	return ret;
+	return 0;
 }
 
 /*
- *   setenv hwconfig serdes1:100g4x25g
+ *   setenv hwconfig serdes1:<mode>
+ *
+ * The modes are target states of the same 8 lanes, not steps:
+ * when several are given, the first one of sd1_modes[] is applied and
+ * the others are reported.
  *
- * Idempotent: a board whose PBI already split SD1 skip it too.
+ * Idempotent: a board whose PBI already configured SD1 skips it.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
-	if (!hwconfig_sub("serdes1", "100g4x25g"))
-		return;
+	const struct sd1_mode *mode = NULL;
+	int i;
 
-	if (lx2160a_serdes1_is_split())
-		return;
+	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++) {
+		if (!hwconfig_sub("serdes1", sd1_modes[i].name))
+			continue;
+		if (mode) {
+			printf("lx2160a serdes: hwconfig also asks for serdes1:%s, ignored\n",
+			       sd1_modes[i].name);
+			continue;
+		}
+		mode = &sd1_modes[i];
+	}
 
-	lx2160a_serdes1_split();
+	if (mode)
+		sd1_enter(mode, mode, 0);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 8dce9ddf97a..5a820c8c5d8 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -7,25 +7,13 @@
 #define __LX2160A_SERDES_SPLIT_H
 
 /*
- * The split is LX2160A only: LX2162A's SerDes 1 is four lanes with no
+ * SD1 modes are for LX2160A only: LX2162A's SD 1 is four lanes with no
  * 100GE in its protocol table.
  */
 #if defined(CONFIG_ARCH_LX2160A)
 
-/* Is SerDes 1 already 1x 100G + 4x 25G? */
-bool lx2160a_serdes1_is_split(void);
-
-/*
- * Split SerDes 1's 100GE.1 (lanes LNE-LNH) into 4x 25G.
- *
- * Refuses unless SD1 is in the unsplit state, and must be called before
- * the Management Complex starts: MC latches the live protocol-converter
- * configuration when it boots.
- */
-int lx2160a_serdes1_split(void);
-
 /*
- * Apply `hwconfig=serdes1:100g4x25g` if the board's environment asks for it.
+ * Apply `hwconfig=serdes1:<mode>` if the board's environment asks for it.
  * Boards call this from reset_phy(), before mc_env_boot().
  */
 void lx2160a_serdes_apply_hwconfig(void);
-- 
2.43.0

