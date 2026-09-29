Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769E6CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2987F607E2;
	Tue, 29 Sep 2026 19:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4s48J1C6KFez; Tue, 29 Sep 2026 19:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0EA4A6071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710535;
	b=UFHeqaRzSDGgWqZkGgvD7FzZ28U9rpV2iWjzxM2Wuw5q2xNjSLPMdnXzn2qvoCheQ3ya
	 h07AhMEp+pfh6mvdI0JGDfNbwAHlSa+8Bb45hyW4DwCIV7fMv7H6iox6Ef0E8YnYFHH7U
	 CqKvUXps7pxJbzgKd8T9Baa0gEyM4KUJOrWIkFNo/TVfS9X80ldYF+/KRIfIY563vSEzu
	 VITKpTvmtvpG8vRlln6bc7OA9zY/TGW0VHZRRN75lNjyP4HpWBByJYTX8tDyoCP05Kn4/
	 w6UXasRuL7jOh0VHR+8dVOyoChhknZf9ICK5Zck0OM2mrK5UhS+2/22RL2BFZ0D4llQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sPsYXKQwagJZ9gAxwbPpqF6d4tqfwLVSADdkeEJGSRc=;
	b=CzmWvWGJThIj4+Ct7tFrM+KjRpBH0UJ/oJCCUGRUaTk2/geQ9QjMmJ1ivFkVNNiobY54
	 UfslZlLEWg5OpE30cESu4Yb95XsXJrK0b6+PoKml24hzvq1bWnFnL5jMNCCI+POWSg0Ld
	 atNbOIoWZUIQhUUZmZhaAVuvV7Z+Q16DfOoOpKp6wQ/jerIX0XZW53uEA782+zrdydcI/
	 fwLpTvFUokI5Ar5Y9YUCd3v8sHttTNVXR1bEGiJb2ytwWaSoRgSJKTryzntZrR4dNLgHs
	 Xme67H7U5QM6X8XkcgASUeAlNOKELV9tcW6BJ+SEeuIqH7erKaxdB1Mvt54hfrgY3Ww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710535;
	bh=sPsYXKQwagJZ9gAxwbPpqF6d4tqfwLVSADdkeEJGSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eM2c+/gzYz5sotXIz0fmCqN0F4Wzq2QJg2aYwl/b09woS81SmQJh5R2BHcnnPN6hv
	 w5pzt+L5SOsRscjfnblyphclPyNgsFWjVgUQKrQel+xIeS5u0O+bZaLey0XgGouPA3
	 Ek38xoZ9U4EizXWZep5W7Iu/laF/Y59uxAnaZFfRQkhSm8WRec18Ab+1Qyci6Gv/5+
	 Zqf/GD8TBLX5Z44m9orfwdhlcMh55TatOKZq95ZKr/nBoy+zw5eeqhUnyYtXHFXGI/
	 Z44oFscv4ni2wnWcdTSA6J0KaXRwwITxxv8+609wg0xPte22/JaDremTyBuPCFW3gL
	 GvjgykvI+tipA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EA4A6071D;
	Tue, 29 Sep 2026 19:35:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE57B282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFEF5407AA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id letX3AZxQees for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E010440766
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710533;
 b=byMHkPzRWiKmcVoYq99IILelKBPBPtVO10feTVabryFsUfZhpqTnuv2/GhlEr+ppzoM6
 4LS1sPkDAhzAMfl+neBkgZiXONMLAbCNbrAGKnx64WxPhsw8bYKTsahS4GXD/B4j+JGDU
 X1bPlkehhmY9MOtH3xDF6yk9rAuJai8kjnVOUVbcSb1RSqXuIIx5LKgWhBbNG3KnVfKmj
 tjFgWYBbPLVPLWu3qaETYtT4eoSpi2uQENev+w5M7ZmuVKQDFjCxireYkVmDKD4WS/8/k
 zfuDKrqeXZ9JCx+dl1Qhi0LKXTCukNuUMGyCaspyw4wGUQIZPrDRZVyRIOfVYsmDljg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710533;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sPsYXKQwagJZ9gAxwbPpqF6d4tqfwLVSADdkeEJGSRc=;
 b=fu1Z5lnmReDgs5C6mNerngMhTbZm2hkXrT8J3D0DWl5kCh47rMtTspKmXJJh+WDuD5B8
 oDzBqduknqO53mYST6gFqA6aF8zzfgmdzQY68KX/FCHMGfQQDmV5n+xZWqbaLW6Qye7jU
 Yx6pI6wxQubFhhtvoiGHiQej05jGN4uqnnL5lOFBSoypE/UVE9tbS+qT/Gx1t8uCDUUkb
 Obkn4iVwn2op2QfmfjkC9s9oO0NxaQRAp6MvzzUgadF7W3i9FaIfW55tQ8bHdrlUhauzC
 geusmIqMMDM+Oj5yaMi/LmnL3Ts6a3mSYH4G0qFbLCkz6ViEkDRhZ2TcRuTGZawX3qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=pUij+DOX; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=pUij+DOX
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E010440766
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 11869B0055A;
 Tue, 29 Sep 2026 21:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710530;
 bh=9CY9r7rzE42t/lqLW4zUlrTNYH3d22OIxmUYnYQHd7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pUij+DOX3BvGJKYsFopDcoJImcEQXOU0j5CPARc0r9FlyFZWzIq+Bgp3hh7IbXUDQ
 1nMD27U84qjcZc6cGmjRRjg9RCzs0fD8eOuURjFBduPZI4uf4i5HW/Uc1MxLqpA+cc
 QC1O8uPpq2mO9GXpQBL3wXvdgRBbp1u9i2FIY9BpJE7DCoY9MuXdwKuH/yXUT6et+l
 EG7Fz5I6cT5H7PXeJFhn3ejbdF0hxQK/lBtTHHOOQdoUWL6JB5q/4QUBvvXGeMjg1w
 JCQDz9FHiWgJHOqBmyd4T1dbkFLnJ5tzgYANVOrZviaTRpVtI63jlUC+Z41ngncpbJ
 5a6ClBc/4dklg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 04/13] board: lx2160a: serdes: move the SD1 halt and reset
 into helpers
Date: Tue, 29 Sep 2026 19:59:36 +0200
Message-ID: <20260929175947.1379710-5-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929175947.1379710-1-vjardin@free.fr>
References: <20260929175947.1379710-1-vjardin@free.fr>
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

The split halts the 100GE port on LNE-LNH, reconfigures its lanes,
then resets. The following patches do the same halt and reset on
other lanes, for the other SD1 modes.

Move them into helpers.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v5:
- New patch, split out of "set SD1 with a table"

 board/nxp/lx2160a/serdes_split.c | 132 ++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 44 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index aeae8fbb340..5dcdeff5898 100644
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
@@ -251,8 +252,7 @@ static void print_rcw_view(int sd)
  * This is NXP's e100g1_split.rcw sequence, moved from the PBI into
  * U-Boot.
  */
-#define SPLIT_FIRST_LANE	4	/* LNE */
-#define SPLIT_LAST_LANE		7	/* LNH */
+#define SD1_LNE_LNH		GENMASK(7, 4)
 
 /*
  * PROTO_SEL=11010b (25G/50G/100G, shared) + IF_WIDTH=100b (40-bit),
@@ -309,73 +309,74 @@ static int poll_clear(unsigned long reg, u32 bit)
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
-
-	if (!srds1_is_unsplit(base)) {
-		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
-		       in_le32((void __iomem *)SRDS_PCCD(base)),
-		       in_le32((void __iomem *)SRDS_PCCE(base)));
-		return -EINVAL;
-	}
+	int m, master = -1;
 
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
 		       'A' + master, SRDS_POLL_US);
-		ret = -ETIMEDOUT;
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
+static void sd1_reset_req(unsigned long base, unsigned long lanes)
+{
+	int m;
 
-	/* Reset. Every lane is its own master now, so all four count. */
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 	}
+}
 
-	for (m = SPLIT_FIRST_LANE; m <= SPLIT_LAST_LANE; m++) {
+static int sd1_reset_wait(unsigned long base, unsigned long lanes)
+{
+	int m, ret = 0;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
 		u32 t, r;
 
 		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
@@ -395,6 +396,49 @@ int lx2160a_serdes1_split(void)
 		}
 	}
 
+	return ret;
+}
+
+int lx2160a_serdes1_split(void)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, ret, err;
+
+	if (srds1_split_state(base)) {
+		debug("lx2160a serdes: SD1 already split, nothing to do\n");
+		return 0;
+	}
+
+	if (!srds1_is_unsplit(base)) {
+		printf("lx2160a serdes: SD1 is in neither the split nor the unsplit state (PCCD=%08x PCCE=%08x), refusing\n",
+		       in_le32((void __iomem *)SRDS_PCCD(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EINVAL;
+	}
+
+	/* Lanes E-H are one 100G port at this point. */
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	/*
+	 * Reconfigure while halted: four one-lane ports instead of one
+	 * four-lane port. Everything else about the lane is unchanged.
+	 */
+	for_each_set_bit(m, &lanes, SRDS_LANES)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), SPLIT_GCR0);
+
+	/* Re-point the protocol converters. */
+	out_le32((void __iomem *)SRDS_PCCE(base), SPLIT_PCCE);
+	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
+
+	/* Reset. Every lane is its own master now, so all four count. */
+	sd1_reset_req(base, lanes);
+	err = sd1_reset_wait(base, lanes);
+	if (err)
+		ret = err;
+
 	if (!srds1_split_state(base)) {
 		printf("lx2160a serdes: split did not take (PCCD=%08x PCCE=%08x)\n",
 		       in_le32((void __iomem *)SRDS_PCCD(base)),
-- 
2.43.0

