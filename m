Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B105C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C85A80E56;
	Mon, 14 Sep 2026 17:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1ADSaNvcnRG; Mon, 14 Sep 2026 17:05:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2AB0F80E3F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789405547;
	b=tLRnwkqLigshhgampSe7zkRzzmYoARwPuu6AIvmeIyD/yA+iTkrrgJoEx2ArHO0swXjo
	 tVY38wRO4JidYObt4L4QOCWGtCN/x7fP/z9Hz50VIfq/LIp5UDblfJRL/B1kaGNymxopp
	 5AfErf2sHWvtybVkzX5YHH0skRDG8yO/Ooy9ocZOxPiEIe53M7+TXwRpDG+QeeX3+2OiZ
	 /vTY4z14TlQ1fg/HLfq2ZpSEigNK3UzP5sYW5v/l1OAML+0uBoimnTto5KEJgI4TZA/Ak
	 Y8lETBaw8j6BqdPnajlmdnVkUun/2pZ2uEkhXshq9+t4bSYxU1HU2jpHsoJH1E0XKig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789405547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
	b=jHdIaR1/tdCFIXL+XRHi7cKW9p5ki0xcf668Rnd38XdK7fL2YkotmvqcdDb6wMmUmMY1
	 RBrg90uabhx3BOfcjUdRT02TZfl9GRMaw6ar6xx1nwo5nzhhy8IM3McE6Yp5l/5Nt9MxV
	 i15iZxJc220UYgfth6o7orILewllH/I8nXgC+WdJRiJLO0SJSMomU9k4G4mwc6dCy3/dz
	 o0K9DD0pXu++pxwv9GsdgMilRYL8CifCG2y/bch2YYFnQl4oQSdVIOIom99hqjNOll+ip
	 85CUt/HArxRJJ49Df5ixMk2jkAtjmDmnX4fJBa1EKF9mSCcYGGda1whIO1qGrltVxPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789405547;
	bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0EPzA+Ty30WwcEICPzODWunUNXkYdXkqux/aODJiAYcb/QxpjlyG8c4UldfW3X76s
	 CVWo77U8lrGYuEzO4rKPoF2P+M/j9wQIFl+Jx481fG9b3TROqgz4EKHMHku/VQp45I
	 2bJ3dZSltN8Xyf4GBxumQDdfkP7GJNGkzgHn01UoWq844BNrfcR7yJOK3/xDfrPzgO
	 jLK4k4yFGqVjC50H9SViO03iia8U1wVyK+D9SQRsru/TcxPW1wCWZtwa9p5vu4T9Pl
	 +FpukG7/HcLtgR827TBgDESRUYJ+hetCbdNhaYq6qCXgl4FGCQ5goLGC9gFKW/T4Xg
	 VyUSV20pyDIww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AB0F80E3F;
	Mon, 14 Sep 2026 17:05:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE4B465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C311C60708
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwFoUQ3YF8Yl for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D014F6062A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789405545;
 b=ApnHF6vEEjzGLR6ZSUTmXT7fq80Xq6UdexqM2nZb6kBI11yvo0thm2AmzixHHGxnZ/M4
 0wK3ZNDF7jrSJt+BRVnChrKzqvrDt5ooOJAWtTUZ5M2VhNs1FyddxJ788aYaej6Eet7lD
 sTmTheM8rCwU8md3Rj+eB5xn1OXyQCH1OsDYVfmjTTtSLrGw6sVQB7MzZ7kKEz+lqQm85
 X9aXvBIOqBkAWVRE+/Gngd72Gmn8j5qy5hqc1Oo4FuKBB9pyPmyKN2qgFdRipMgMQbe2T
 OB+ykOB0iHJx+YvulzZnexai+pZOWu8z8zG8TkYzAcVyC+Ml61ONlaRZ8CMxckA8C7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789405545;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fNAkaiX+jgF/nwJbBDGLcbf1BIRsKlJNGSEeFd6vIck=;
 b=ebXvj3SU+lGOEqzO6Vf3CPw/EmcDpmI7DXxaIbtaIbRjwl1uR+6CCGLXl8tZxStqfHAj
 vy+PEs2N7bFJCHoRJdd9caH4sc2dIxynG85ZT9/zkGhkp3xTby5N/tCqFMAtCVQ+x5Q30
 DnNfbHmnBnT3yAdyVF4mnIME1wUS4cGrgvhBNj35VhM+SA7WezWWmWihL0vaCQhz9nUOK
 AmBnGzbvyGq/RHpms+/D7WI7l17gDWBQRhjyEx2A07JEcykz2B5dEJjgQgGi8JuDIGi70
 cstjZswMiZtS1+W20H0IvCR3RPQORcJBhdQ5+LC4afBBFv6hdZ1iLlAl0HSQ54s4yHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=nCr6HkQH; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=nCr6HkQH
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D014F6062A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 17647B0055E;
 Mon, 14 Sep 2026 19:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789405542;
 bh=YblNKC7FXP7CbHiIwTqa/5jqAtMgYlG38n2wJuBnOks=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nCr6HkQH/sU+PpQnf/lyMeBStUxkkE48olBg53a5V0TjTEHL+EDkTR/A8BE3TITUi
 QIZ4T+IkUjYsz9SEY9i1r2QQoQ8bfaU2H8xLV56mqSBQGktA+m0KlhVP1uXP5B3wVu
 rfuaGbNRuVGN9XV3/Np5gmEZlTdLA/DG68nI40+nUEflyTFu+M1MmzIQwEnYE3ysex
 kPNo+MmjkPvITPWQBb15N5KHNlV92l622dGTSaOd6rO6zR7UEY5RtsWU42cjL0inwW
 g1hwy6I5+jGzSt7X+P6KTrHXfjaP9WTG45TY9iZBLkCzuoOafjgOvEXia5DgZVvus2
 sYCKUeYkSe+Jg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 3/5] board: lx2160a: split SD1's second 40GE port into 4x
 10G
Date: Mon, 14 Sep 2026 19:04:15 +0200
Message-ID: <20260914170417.3052423-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170417.3052423-1-vjardin@free.fr>
References: <20260914170417.3052423-1-vjardin@free.fr>
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

