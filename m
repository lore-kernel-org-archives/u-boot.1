Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A120C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 21:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD2DD40769;
	Wed, 16 Sep 2026 21:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrfta_j4VUQh; Wed, 16 Sep 2026 21:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C8FE840723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593433;
	b=qy5PpcBkR4VyBMbwjaYaYgABQPS4B7uQAhZ37bN3Vy178hV1TbFKCHQKfPj+Xub4a27B
	 zd2+3DPM07fP1ROvFymmpwZPUpVqwwb3zzCCQUbcfurZh6vj+GXgngFCNiPbTM3AZuOO+
	 BscEGggprIG38zQ8XLaiUBvfmyMSIxahjWhJI1NgGjEaDMeMW1eRL6n3oT0FE6As7uSdD
	 LFsY+5NCWmk+0mTA9wgdmlTBHBA6RINyrJV3kkRh7JEd7Rk3HA9t7Pc10KI5rGXoAMtLC
	 M7O1uBEUMN7WYA/Dc2m4aRPElk459XAqg3ct1oUjYzmkDGMJC1qktaDc/f7IziYVZTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
	b=s+Mi9bC7b4RKL/iJkxWoOTgh8rvo+CrbmErqmV4Qgnj5yvZnMv02OE0kQJY2e7iI7Ibx
	 BfFmuAo7jNEOtvqUVkn5A0DzbStDSzW4WAsvIrSPDJWi7ZD4A1N+SsBiXHTyWAWvTtRLk
	 /62MU/dy7hXeCcxeAy0UcnlAOIS1IfQJcT/lSUDff+iJHJVZwrG2sZH7mL9GWRoU5voz4
	 POPgypBmt19RH3YJwsj882/uH/H10WxIbl+oAYmGEi3JVqCQMuCuLvihjQxz/mcRMn8Sb
	 tZCQwCstEQHxWpTbeU4O+6/HlH4sBXEN6g6sZ7RK2kg2RzqMb6N8HuLu1of4O0Vofaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789593432;
	bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ELeWVF3NWIVmzSgce24LrUjA9iCImIuArggCb9zewutaDF1RNmARSHv2N0q3gdVNA
	 RG7ES+9qSGaHwarjnVfmQvn4TK652FjZdC2gpORSYLJxd2SOu2Y4w/DO7erPmSDUeT
	 ASqA138YXK+g8u45nQLrAcKLMbkGjPgqAo9y29ebBznvidKMdrVV6qREzlJByqQt5E
	 p421Hn9/qM6/DtcZOv+GVzsE06totqo3xRNjF3bQlcgQKqdptXofN2KAp59+iTaj5I
	 1mibQv48Yi1vW1s/Na9ck+WbmeOdngxKyOcnhYAax+LkMB7Kg9Ym01ObRjFBujiLQP
	 CAgXi7QZgaTOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8FE840723;
	Wed, 16 Sep 2026 21:17:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C25E824D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C41380DD6
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiQ5M8WFjYLE for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 21:17:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4803180DD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593430;
 b=jBtrqTuAFE6ip9XoZYCVmztzIZi5NR5/LHFOedvxq2SBT9k5kZKALHhhe/RVQ+hzNWuH
 kSTzIXtQi6xLNUlO2554Mljch7Y8qmvWW+gOSTYmnN2oXPJTo2TDSth0qnhsPCeEkjBhR
 yDa0wAqvNq3byMqTN1tliGKJN+r0DZylvEQC8Ol60qUyRERUFyFQAsV+XHsXCTr0pH0Vy
 lLRv8Ir6bnO3Aswv42cgQyFKBsG0U3ujJqFYPNDJHDtqxbWTbwLkPusGIRoXN5H4PPhOw
 iZXRHtBuYH955oeKZrxFxbdFLNZrojGnhqbVxIPgAlEJtUwq+uAkB6OSCjFhL7QRCfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593430;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
 b=bOqIyl/XUARF3DXtKPu1Kz7QKCf8sLLiJQTXNBWYbf2gUbw8DCduz++5FCAHdbkxShjx
 ZDNig7KiVhj3pGZrsIAvI7kfbC6P5Hj0XPDLxjj3NdCMGYPKmUhih7nWw6Xvv11w+obZf
 EIkIUaOTbJXaWB+SVNc77iVBoqTWJ8+klLmKcobgDw9p/ChGPb17NWjwzG40OGCg+R3/E
 /zqvKKjD+3SQQnf1y+TmXfhvwDoZKyS8csgzP7pO14F+nkrVgBOHiAzYIzW8IunsIZk9G
 JT/HnjM0uxcEmTOpOKOCkr8DtKaYMYmPBscPZh/OQJzsdxniENccZ4f/x62HxA52l1A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="b+m3xAg/"; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=b+m3xAg/
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4803180DD3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id E7C6EB0054C;
 Wed, 16 Sep 2026 23:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789593427;
 bh=YblNKC7FXP7CbHiIwTqa/5jqAtMgYlG38n2wJuBnOks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b+m3xAg/qJT08XbQN/04Wpo4uU6zTv3+G0v0r9jjVrhm80zyuVuo84tS+dc6j1whl
 B0RAAVo32l5mALiwQNXtz+aL10j08/kx/bb7nezqZwtvSDSVoPMtx2Vt/Y9MS6zfTn
 jINCZv69WMQ2BYBVeypKYHX4nog2P3BYYCDqvq0+tEEFdf38OKkDeElxSYdG7hlywm
 bUc+bt+GtripuVmTgFSU4dep5XrIqgHzN0kfxwGwNqiyJZnTb7yvGzCvujeohlfUqd
 J3ig5fXNZK3z/emmQWINOwZ0UK+E+k+Kpv70bBYLXirhzcwd1u2z6LBc0WXteNxjfa
 GooXihP2DBLZA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 3/5] board: lx2160a: split SD1's second 40GE port into 4x
 10G
Date: Wed, 16 Sep 2026 23:15:47 +0200
Message-ID: <20260916211549.3432913-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916211549.3432913-1-vjardin@free.fr>
References: <20260916211549.3432913-1-vjardin@free.fr>
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

lx2160_sd1 40g4x10g, hwconfig=serdes1:40g4x10g.

  XFI   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
  40GE  LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000
                       ^ PORT_LN0_B

same PROTO_SEL (0x0a spans XFI and 40GBase-R), same 20-bit width, same
USE_SLOW_PLL, same BY_N_RATE_SEL.

It is inspired from the 100G+4x25G split, but using PLLS.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/serdes_split.c | 191 ++++++++++++++++++++++++++++++-
 board/nxp/lx2160a/serdes_split.h |  11 ++
 2 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 0f30019e20a..f48c882aa22 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -585,6 +585,154 @@ int lx2160a_serdes1_to_40g(void)
 	return ret;
 }
 
+/*
+ * 2x 40GE -> 1x 40GE + 4x XFI (10G), keeping the QSFP group intact.
+ *
+ *   XFI  lane   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
+ *   40GE lane   LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000
+ *                            ^ PORT_LN0_B
+ */
+#define X10G_FIRST_LANE		4
+#define X10G_LAST_LANE		7
+#define X10G_GCR0		0x00000052	/* as 40GE, but own port master */
+#define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
+#define X10G_PCCC		0x88889999	/* XFI converters for lanes 4-7   */
+
+static bool srds1_is_40g_4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GB_CFG(pcce) != 0 &&
+	       PCCE_E40GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+bool lx2160a_serdes1_is_40g_4x10g(void)
+{
+	return srds1_is_40g_4x10g(srds_base(FSL_SRDS_1));
+}
+
+int lx2160a_serdes1_40g_4x10g(void)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	int m, master = -1, keep_master = -1, ret = 0;
+
+	if (srds1_is_40g_4x10g(base)) {
+		debug("lx2160a serdes: SD1 already 1x 40GE + 4x 10G\n");
+		return 0;
+	}
+
+	if (!srds1_is_40g(base)) {
+		printf("lx2160a serdes: SD1 is not in the 2x 40GE state (PCCC=%08x PCCE=%08x), refusing\n",
+		       in_le32((void __iomem *)SRDS_PCCC(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EINVAL;
+	}
+
+	/*
+	 * Halt. As in the 25G split, only the port master's request can
+	 * clear, so issue all four and wait on that one.
+	 */
+	/* The kept group's master, recorded before anything is halted. */
+	for (m = 0; m < SRDS_LANES; m++) {
+		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
+			continue;
+		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
+		      GCR0_PORT_LN0_B))
+			keep_master = m;
+	}
+
+	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
+		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
+		      GCR0_PORT_LN0_B))
+			master = m;
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_HLT_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_HLT_REQ);
+	}
+
+	if (master < 0) {
+		printf("lx2160a serdes: no master lane in the dpmac.1 group, refusing\n");
+		return -EINVAL;
+	}
+
+	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
+	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
+		printf("lx2160a serdes: lane %d did not halt within %d us, continuing\n",
+		       master, SPLIT_POLL_US);
+		ret = -ETIMEDOUT;
+	}
+
+	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), X10G_GCR0);
+
+	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), X10G_PCCC);
+
+	/* Reset BOTH halves, not just the four lanes whose GCR0 changed */
+	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+	}
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
+			continue;
+		if (m == keep_master)
+			continue;
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+	}
+
+	if (keep_master >= 0) {
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, keep_master),
+			 RSTCTL_RST_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, keep_master),
+			 RSTCTL_RST_REQ);
+	} else {
+		printf("lx2160a serdes: no master lane in the kept 40GE group, it was not reset\n");
+		ret = -EINVAL;
+	}
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		u32 t, r;
+
+		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
+		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
+			printf("lx2160a serdes: lane %d reset did not complete within %d us\n",
+			       m, SPLIT_POLL_US);
+			ret = -ETIMEDOUT;
+			continue;
+		}
+
+		t = in_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m));
+		r = in_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m));
+		if (!(t & RSTCTL_RST_DONE) || !(r & RSTCTL_RST_DONE)) {
+			printf("lx2160a serdes: lane %d reset finished without RST_DONE (TRSTCTL=%08x RRSTCTL=%08x)\n",
+			       m, t, r);
+			ret = -EIO;
+		}
+	}
+
+	if (!srds1_is_40g_4x10g(base)) {
+		printf("lx2160a serdes: 4x 10G split did not take (PCCC=%08x PCCE=%08x)\n",
+		       in_le32((void __iomem *)SRDS_PCCC(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EIO;
+	}
+
+	printf("lx2160a serdes: SD1 now 1x 40GE (dpmac.2) + 4x 10G (dpmac.3-6)%s\n",
+	       ret ? " (with warnings above)" : "");
+
+	return ret;
+}
+
 /*
  *   setenv hwconfig serdes1:100g4x25g
  *   setenv hwconfig serdes1:2x40g
@@ -598,8 +746,9 @@ int lx2160a_serdes1_to_40g(void)
 void lx2160a_serdes_apply_hwconfig(void)
 {
 	if (hwconfig_sub("serdes1", "100g4x25g")) {
-		if (hwconfig_sub("serdes1", "2x40g"))
-			printf("lx2160a serdes: hwconfig asks for both serdes1:100g4x25g and serdes1:2x40g, doing the split only\n");
+		if (hwconfig_sub("serdes1", "2x40g") ||
+		    hwconfig_sub("serdes1", "40g4x10g"))
+			printf("lx2160a serdes: hwconfig asks for serdes1:100g4x25g alongside a 40GE mode, doing the split only\n");
 		if (lx2160a_serdes1_is_split())
 			return;
 
@@ -607,6 +756,23 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 	}
 
+	/*
+	 * serdes1:40g4x10g is a target MODE, not a second step the user has
+	 * to sequence by hand: it implies the 40GE conversion first,
+	 * because 1x 40GE + 4x 10G is reached by splitting one of the two
+	 * 40GE ports.
+	 */
+	if (hwconfig_sub("serdes1", "40g4x10g")) {
+		if (lx2160a_serdes1_is_40g_4x10g())
+			return;
+
+		if (!lx2160a_serdes1_is_40g() && lx2160a_serdes1_to_40g())
+			return;
+
+		lx2160a_serdes1_40g_4x10g();
+		return;
+	}
+
 	if (!hwconfig_sub("serdes1", "2x40g"))
 		return;
 
@@ -671,6 +837,22 @@ static int do_lx2160_sd1(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_SUCCESS;
 	}
 
+	if (!strcmp(argv[1], "40g4x10g")) {
+		if (!IS_ENABLED(CONFIG_ARCH_LX2160A)) {
+			printf("no 40GE on SerDes 1 to split on this SoC\n");
+			return CMD_RET_FAILURE;
+		}
+		if (argc != 2)
+			return CMD_RET_USAGE;
+		if (lx2160a_serdes1_is_40g_4x10g()) {
+			printf("SD1 is already 1x 40GE + 4x 10G, nothing to do\n");
+			return CMD_RET_SUCCESS;
+		}
+		if (lx2160a_serdes1_40g_4x10g())
+			return CMD_RET_FAILURE;
+		return CMD_RET_SUCCESS;
+	}
+
 	return CMD_RET_USAGE;
 }
 
@@ -714,7 +896,10 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 	"    - convert SD1 2x 100GE into 2x 40GE without touching the RCW.\n"	\
 	"      Must run before the MC starts, and the DPC must carry\n"		\
 	"      board_info/serdes/follow_hw_pssr: RCWSR still reads 13.\n"	\
-	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g"
+	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g\n"	\
+	"lx2160_sd1 40g4x10g\n"							\
+	"    - split SD1's dpmac.1 40GE port into 4x 10G,\n"			\
+	"      Permanent: setenv hwconfig serdes1:40g4x10g (implies 2x40g)"
 #else
 #define SD1_CMD_HELP							\
 	"    - no SerDes 1 Ethernet modes on this SoC"
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 36d486d7301..1b65848db2f 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -34,6 +34,17 @@ bool lx2160a_serdes1_is_40g(void);
  */
 int lx2160a_serdes1_to_40g(void);
 
+/* Is SerDes 1 already 1x 40GE + 4x 10G? */
+bool lx2160a_serdes1_is_40g_4x10g(void);
+
+/*
+ * Split SerDes 1's dpmac.1 40GE port into 4x 10G (dpmac.3-6),
+ * keeping dpmac.2 as one 40GE port.
+ *
+ * Refuses unless SD1 is in the 2x 40GE state.
+ */
+int lx2160a_serdes1_40g_4x10g(void);
+
 void lx2160a_serdes_apply_hwconfig(void);
 
 #endif /* __LX2160A_SERDES_SPLIT_H */
-- 
2.43.0

