Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5976CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 914E860891;
	Thu,  8 Oct 2026 22:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ak8qrH5PFYfv; Thu,  8 Oct 2026 22:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A16976084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499459;
	b=IcxclrG4ewgrUIho54HHRm34tAGgf5f/8rqpmn6U5TX9E3ldboQf70Qw/dyNfNBxD94L
	 9ggg1xuAeUNckZ9lxEOneM4dZCBRJyRbE7GulgSpF9z0ch2J6rjdd6ya4j78S6hs7wFRV
	 KJJ/CLw4qNiKv72RBdEpx3V9OW3sq3s/6lk7tMgqzK5mKhdVltRky4Zwa/3dcQzziK/P6
	 HS6vnKXD71l6lQPMuVFjitMZLf+CX1LN6RiLXIZ0L+rettD6kDZoMuJaAcuAUZGhr1NXM
	 u1c+8vQRBjyNT2QEoYznp+d7MJukukTWV/WnTR+SVAQwp7qg6PIAmDGwDE2HD3IhO1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BLWVXfMHXVvIpVJrps5cfWMT7iZT70Nh2EK90ph7Ef0=;
	b=fdNcqdIYW90Pys+mlx6B5nkzh+XkOo2cI4kbzjy6p+2UKFx4hF2G4KShPHWiV5ukjiJY
	 dm/2SS6nTuT6e87ommR6IRWtniiVw9Z3o5HSDipVZ1flTvT5KQ6E5eRmhol0nvJq1HSfr
	 lDBEszCnHVU7xrQw9k9wT4VrVyzTmP6GcYabkjAwI9HAJnL4GneB9M3yj0zH955UzYNvl
	 jg9Y57+SXBYFtZK+l2vChgnaDQg7e245h3PvLgyzJZ7/1jHuTHZOsplIVTzRR5c6YnFsu
	 2oNaUXRnRJzCKDpHv74zsQ+G8euAocXhOF337cO5Mf869KNMbAyAWNL+ohFEh3Kav8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=GJj9Mv94;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499459;
	bh=BLWVXfMHXVvIpVJrps5cfWMT7iZT70Nh2EK90ph7Ef0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHrCkZqUVP3R0lNSeERQJVbV0znv8f7W4YwNKkbb4WcYya7Chvsz+enyk6S8QSson
	 PcvINpRgxK2kw91kMRua/83+amI3YE0EXbvqkr7x/+ptKVw7fVFnRedjyFSdwgR4OZ
	 c1h1dSGcKaMEIZSZdH1WacPNX1VDxUyeZ1f9zKU/7rDDgrqq8NvDOlHwCvPiWvzqlI
	 pi3GBxECpzCWPfK18HM1ZUwtJfTDLLrmhegKOHUmxH/SS+HTj2hRZz/KZriRU+5OlQ
	 y12deb2hNOIbAYW/4Ea9gEkPw5eBqEOaR/UEbrNSw+0l3qQjycroKFQlS3/B7YlXFC
	 wS62yPYrZbJ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A16976084A;
	Thu,  8 Oct 2026 22:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA05B356
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A76BD6084A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGWIZLZKI-zk for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E08360832
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499458;
 b=L5WU5sggqOUCgj2Hal/z+ERceHjWKhFB+3/XubdY3P5O4yx+aGp5hMGIBxXQ+V9gES1e
 jhF7sjZ62s6PPmudE4aRp4W4YEN28hBT1pD4t69HANNCcn9jEbn0n0wmB/nCrykRI1sJA
 1MDhaCSbcgZfbvrt5RhFval1eyzPx62O24nGmWZkqyDrPg8a9G2ccsFaNw5fZaWr61y3+
 RyttiULmCIuEPd52+oPtfit7pNmyy0ThP5FW2eHioMwDY/HOVAB1yRLBk2JErj7c7ble0
 Tl9QkkMxtQ/E7MWxkUfi3lDrPLniLIGOHoz7mhYaY5kqrd/YHiCglLjGbd3S4KZ0Bpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499458;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BLWVXfMHXVvIpVJrps5cfWMT7iZT70Nh2EK90ph7Ef0=;
 b=E9x2peevp840JzV3b1MV0WeQoMn/gHluUJVL0yxIy0DUVPMDuT3ECfJewFDBlK1ARhYc
 2OsuB+/nmjz7pM1jf3OwGNE+qDtQYf/pTmLWs7X+HQv/v4QbOyQB3zlatG8GtXLiFd1vN
 N5vcYGgUJ67hS7VANlNT5m0OV2HByMr9LwEhzTUbe0+BkHlQJZa30YW7MFazsPxUXKfGr
 Z5gyfhTTflfEYbLrBVD8dlpKdodSzPTKNnKI8Qf5tkDtVf/VaJLahTvtjf5p+DO9VMnS1
 uzqmZoUi0X9yA6+Ccy+pcLMY9CEh1pk1f8xWwdbyYokA72ZkxEeYsFkd9PyghGwwP+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=GJj9Mv94; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=GJj9Mv94
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E08360832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:44:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9A692B00548;
 Fri,  9 Oct 2026 00:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499455;
 bh=uNGeUM5weCle4ETniL4+nnN+uWS0RIqLzYVIDmzpVyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GJj9Mv94IFYQd15J07P2xujGho3qiZyugOCKaaKdjEOUKMP5KxObcla4PIJ2/Imoy
 xAwsdlBsL7CWq/STyt4qqUuYaSp6Z8Z9+N3noAnSIPBnPLo3Fj3gzOheqdW2kcwJmA
 kwONcstzJzD8MyffyCkfW8S+7rDVB78p61yrZAou2PxLvJ/MulM+C4G6RxedyLZTVd
 VIsLOnyWDOTOKjp2cGM9/Ow7XFYqYIITx0e3G8LSGRWvntAKgd00JK2YRlXd9GCLrC
 3RA1QoshTJUqHXNX/Z8DMh5RhHi4vvFpoDry/kO+0RruIYtPMh+jRyQSDiYkurVAXj
 slhmpWBCmQwxw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 04/13] board: lx2160a: serdes: move the SD1 halt and reset
 into helpers
Date: Fri,  9 Oct 2026 00:42:17 +0200
Message-ID: <20261008224228.512353-5-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
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
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

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

