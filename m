Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860ACC88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E9EA80E3F;
	Mon, 14 Sep 2026 17:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x67gCMDIYaPw; Mon, 14 Sep 2026 17:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF70480E34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789405568;
	b=cQ1kTppLb+wj3hNukUmimtRMBYzCFovlHNgP7kZ/ylYuhb69Q5LZNeyeJyBXqvVAzyp6
	 vhg0v7EpwEUC0ICrJMWXoiFUHDoEt0uPKGduUpMeDI9aPzzDHyLoJFZy8Ua/9Zh1ULlul
	 GLaej17sBEFM56h46DuFdgK0jiZFc6yZ9+hu50Om5cW2bi+w5CAgtv1vpg4KLbedeu/Kr
	 dJGb4R1ADqVLMYO1d3c+vYsstyFbgTHrx4z6rGG/GYVMYGTa76E11pVlnaqoCVRSy/i2r
	 ieACDTS9ivfM2JLhhjpvG2X5d459Id6ErpD7Tnygj8N0Adc4BMgyd4jtAQ85U2v7t3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789405568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6ZGrrEQrBGenvAA/hijfK5/dBXTBUZSHw3kUxPZgGeo=;
	b=ITk33zkEJaRfWjK7RibqSjUJ7wRGVCPt7lotjSrMyQAU1XQM1EhU7d7x7FnH9zsvgWRV
	 ASlp0JTMHlp+YZkAVc3vEZ5+HHEcbX3iMz4uFeqo50vplCmQcUDres6tBtUgpb8TqdZQV
	 Cu6bnDIdcA96con3QCtNob+vZb+Vi8EAZ0crk5wbLiHg+ljdSnz1l/9vaFV397J3xDLad
	 y8VhwhNNJgqcaKinottDlzndQYoPlhoGqVVN4Mgp/h/PC+o2Z6VP80fDCk301rNcUxtY7
	 M/tWNW6yJ0FainsJ1rYM8v9AUYAPhYDshS3oI63Y2I+KbGEe4gSyn7PfwhJoQdQy+TQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=q6t0eS4+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789405568;
	bh=6ZGrrEQrBGenvAA/hijfK5/dBXTBUZSHw3kUxPZgGeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoy5Ck2u9sfAWd5xrCbnq6vzd88pLQJKZr8J1izb0yROQU5Rc2dt1vwalHpIVPtNH
	 JMulkpAelMQ0GGn8mf+74v6+M/cVH5u8QSor1r/aePfsBco0kaR1Mo3qVM+uiy7LdQ
	 ovIPPuqeK+vdJUEf82Vhf414hQ8Q+iFq0nd4tiFVvi8Z64Dqz8i7cPLNIjdqqulCPb
	 UFVB0fqQsEg+yUCSM7bqoayImKNmdDXLjDKgf2uXwgG50ZG9CxvzVgtVP4NlKolub9
	 rrvjvTjv0EEdD+dBtBmR8n8d89gFGMp3sAF/WJn2temH7YPC0XsG26biI9O5LOtI+0
	 aTzY62wRgKscw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF70480E34;
	Mon, 14 Sep 2026 17:06:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4D5B259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA63880E34
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p-yfjacxzaql for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6EFA580E30
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789405565;
 b=alTKSgwDlID7Da2MRMIPHKRajvEIGfmh2/L7Fd0QvKSV7ki8wcMsZs4vw7fQ05EDDCz0
 vKvRYsNGrUJnDJoa0CTfjKwFCDgzkZKoXJ+Ch7JDl3afcEZp91zLsRW77htPMr2MsBZcr
 1HuK7Ks48gwFJgJiayFc9r3iP5vmQGx4dNMdPkUybytqmd3bM6avUPMK+1ogyO4bDgDOd
 5DF2SnuaEn9p0FFrpnjOOfboSeDcrqkE2t3bwXidQsrWtfoTS8zKwAsDqEdCq7dHtrqnk
 ofdEWSHODk6RQXN6LphdqGG2E4AuOIDaGiIS9wOr23wrT6nyl3WzAtCjcy6kaK5FYuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789405565;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6ZGrrEQrBGenvAA/hijfK5/dBXTBUZSHw3kUxPZgGeo=;
 b=rlMvzbY/ZP1c1OsG3FiH0NkrT5kHcxuRWZavtEW2Ij1dx00ACkaXfPMibpXJv61ePchk
 qjYqwvkaxC5RtwIa1bsopdyCaQKxllhH5Om1O0E2bCjW333OJpaw/jM5NP7JDrdUxbguF
 f/QrPT+H0xTHyRj5k6stuT/tfLNHun+txHS02c7CnuaxrMkpaCVqhtFzk0T0Twhq73gFl
 2WWiLb31Hgt9AfyX6uDFj9651by4hpULNGQs+zZnvAD7Tw8qDv83Q/kPVrhfJc8oEoSde
 qqo/9Spk3o6HkMBcJ5iVOX2FSuc8fEqOP6WAlJfQqTxmO1GgANOxS/vRJBfTZFD7s4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=q6t0eS4+; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=q6t0eS4+
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EFA580E30
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3C7F8B00539;
 Mon, 14 Sep 2026 19:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789405563;
 bh=9ToAQ85zws1jNt5DDRN+XLiM+oNGAOLNwoImKJtW/yY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q6t0eS4+LEb3ruX4qkscO7SZDI9dc07mehxq1xmG0AmkTvxowb8+5l9lA0/5qg9rs
 ZrfhWxHYF8tth94ilYD1I+cuRGRCT+4NshVT3K66kwEZIdQ47rlqGVoeli6KZeIIyZ
 tyb0PBItvBjo1XeCS+0jGZ49wdBp5YDnuAsBITwgoJn2UhZ/+HYNjf7DcswK0I1wUu
 nn3EydgaYzl0nlMd/mXdeB4Of0X1wjbmxcHVGqX57PIFaoTqZtzN/lYhvtArVhjXFm
 YGx/HZp+PpYjTJIovtygeMKb5EYZL9OVA2w0YIwfmxTvzX6yGLtD446BcNwZqUWy5c
 ytq8jQoxjmLKA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 4/5] lx2160a: add SerDes 1 mode: 1x100GE + 4x10G (mix)
Date: Mon, 14 Sep 2026 19:04:16 +0200
Message-ID: <20260914170417.3052423-5-vjardin@free.fr>
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

The four existing SD1 modes all keep the eight lanes on one clock:
fast or slow (PLLF or PLLS).
This one does not: lanes 0-3 stay 100G CAUI-4 at 25.78125 Gbaud on PLLF,
and lanes 4-7 become four XFI ports at 10.3125 Gbaud on PLLS.

Checked with:
  grouping     [LNA-LND] [LNE] [LNF] [LNG] [LNH]
  PSSR0 0-3    6a01xxxx  CAUI@100G, MAC 0x01 -> dpmac.2
  PSSR0 4-7    28xxxxxx  XFI@10G,   MAC 05/04/03/02 -> dpmac.6/.5/.4/.3

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/serdes_split.c | 271 ++++++++++++++++++++++++++-----
 board/nxp/lx2160a/serdes_split.h |  11 ++
 2 files changed, 244 insertions(+), 38 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index f48c882aa22..bf337355c7d 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -438,16 +438,16 @@ int lx2160a_serdes1_split(void)
  * The register values below were analyzed from the CPU for both cases:
  * protocol-13 vs protocol-20 run.
  */
-#define F40G_PLLS		1		/* PLLS index in PLLnxxx()  */
-#define F40G_PLLF		0
-#define F40G_PLLS_CR0		0x00040000	/* REFCLK_SEL=4, 161.1328125 MHz */
-#define F40G_PLLS_CR1		0x86100008	/* 10.3125 GHz clock net    */
-#define F40G_PLLS_CR5		0x00001000
+#define SRDS_PLLS		1		/* PLLS index in PLLnxxx()  */
+#define SRDS_PLLF		0
+#define SLOW_PLLS_CR0		0x00040000	/* REFCLK_SEL=4, 161.1328125 MHz */
+#define SLOW_PLLS_CR1		0x86100008	/* 10.3125 GHz clock net    */
+#define SLOW_PLLS_CR5		0x00001000
 /* PROTO_SEL=01010b (XFI/10GBase-R/40GBase-R) + IF_WIDTH=010b (20-bit) */
 #define F40G_GCR0_MASTER	0x00000052
 #define F40G_GCR0_SLAVE		0x00010052
 /* LNmTGCR0/LNmRGCR0: USE_SLOW_PLL=1 (bit 28), BY_N_RATE_SEL=000 full */
-#define F40G_LANE_GCR		0x10000000
+#define SLOW_LANE_GCR		0x10000000
 #define F40G_PCCE		0x11000000	/* E40Ga+E40Gb on, E100G off */
 
 static bool srds1_is_40g(unsigned long base)
@@ -465,18 +465,14 @@ bool lx2160a_serdes1_is_40g(void)
 	return srds1_is_40g(srds_base(FSL_SRDS_1));
 }
 
-/*
- * Bring PLLS up at the 40GE clock net. Nothing uses it yet, so this
- * cannot disturb the running 100GE lanes on PLLF.
- */
-static int srds1_plls_up_40g(unsigned long base)
+static int srds1_plls_up_slow(unsigned long base)
 {
-	unsigned long rstctl = SRDS_PLLnRSTCTL(base, F40G_PLLS);
+	unsigned long rstctl = SRDS_PLLnRSTCTL(base, SRDS_PLLS);
 	u32 v;
 
-	out_le32((void __iomem *)SRDS_PLLnCR0(base, F40G_PLLS), F40G_PLLS_CR0);
-	out_le32((void __iomem *)SRDS_PLLnCR1(base, F40G_PLLS), F40G_PLLS_CR1);
-	out_le32((void __iomem *)SRDS_PLLnCR5(base, F40G_PLLS), F40G_PLLS_CR5);
+	out_le32((void __iomem *)SRDS_PLLnCR0(base, SRDS_PLLS), SLOW_PLLS_CR0);
+	out_le32((void __iomem *)SRDS_PLLnCR1(base, SRDS_PLLS), SLOW_PLLS_CR1);
+	out_le32((void __iomem *)SRDS_PLLnCR5(base, SRDS_PLLS), SLOW_PLLS_CR5);
 
 	out_le32((void __iomem *)rstctl, 0);
 	out_le32((void __iomem *)rstctl, RSTCTL_RST_REQ);
@@ -504,7 +500,7 @@ static int srds1_plls_up_40g(unsigned long base)
 int lx2160a_serdes1_to_40g(void)
 {
 	unsigned long base = srds_base(FSL_SRDS_1);
-	unsigned long pllf = SRDS_PLLnRSTCTL(base, F40G_PLLF);
+	unsigned long pllf = SRDS_PLLnRSTCTL(base, SRDS_PLLF);
 	bool master[SRDS_LANES];
 	int m, ret = 0;
 
@@ -528,7 +524,7 @@ int lx2160a_serdes1_to_40g(void)
 		master[m] = !(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
 			      GCR0_PORT_LN0_B);
 
-	ret = srds1_plls_up_40g(base);
+	ret = srds1_plls_up_slow(base);
 	if (ret)
 		return ret;
 
@@ -546,16 +542,16 @@ int lx2160a_serdes1_to_40g(void)
 	for (m = 0; m < SRDS_LANES; m++) {
 		out_le32((void __iomem *)SRDS_LNmGCR0(base, m),
 			 master[m] ? F40G_GCR0_MASTER : F40G_GCR0_SLAVE);
-		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), F40G_LANE_GCR);
-		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), F40G_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
 	}
 
 	out_le32((void __iomem *)SRDS_PCCE(base), F40G_PCCE);
 
 	/* Every lane now selects PLLS, so one PLL reset restarts them all. */
-	out_le32((void __iomem *)SRDS_PLLnRSTCTL(base, F40G_PLLS),
+	out_le32((void __iomem *)SRDS_PLLnRSTCTL(base, SRDS_PLLS),
 		 RSTCTL_RST_REQ);
-	if (poll_clear(SRDS_PLLnRSTCTL(base, F40G_PLLS), RSTCTL_RST_REQ)) {
+	if (poll_clear(SRDS_PLLnRSTCTL(base, SRDS_PLLS), RSTCTL_RST_REQ)) {
 		printf("lx2160a serdes: SD1 PLLS re-reset did not complete within %d us\n",
 		       SPLIT_POLL_US);
 		ret = -ETIMEDOUT;
@@ -592,11 +588,11 @@ int lx2160a_serdes1_to_40g(void)
  *   40GE lane   LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000
  *                            ^ PORT_LN0_B
  */
-#define X10G_FIRST_LANE		4
-#define X10G_LAST_LANE		7
-#define X10G_GCR0		0x00000052	/* as 40GE, but own port master */
+#define XFI_FIRST_LANE		4
+#define XFI_LAST_LANE		7
+#define XFI_GCR0		0x00000052	/* as 40GE, but own port master */
 #define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
-#define X10G_PCCC		0x88889999	/* XFI converters for lanes 4-7   */
+#define XFI_PCCC		0x88889999	/* XFI converters for lanes 4-7   */
 
 static bool srds1_is_40g_4x10g(unsigned long base)
 {
@@ -636,14 +632,14 @@ int lx2160a_serdes1_40g_4x10g(void)
 	 */
 	/* The kept group's master, recorded before anything is halted. */
 	for (m = 0; m < SRDS_LANES; m++) {
-		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
+		if (m >= XFI_FIRST_LANE && m <= XFI_LAST_LANE)
 			continue;
 		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
 		      GCR0_PORT_LN0_B))
 			keep_master = m;
 	}
 
-	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++) {
 		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
 		      GCR0_PORT_LN0_B))
 			master = m;
@@ -665,14 +661,14 @@ int lx2160a_serdes1_40g_4x10g(void)
 		ret = -ETIMEDOUT;
 	}
 
-	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++)
-		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), X10G_GCR0);
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
 
 	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
-	out_le32((void __iomem *)SRDS_PCCC(base), X10G_PCCC);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
 
 	/* Reset BOTH halves, not just the four lanes whose GCR0 changed */
-	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++) {
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
@@ -680,7 +676,7 @@ int lx2160a_serdes1_40g_4x10g(void)
 	}
 
 	for (m = 0; m < SRDS_LANES; m++) {
-		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
+		if (m >= XFI_FIRST_LANE && m <= XFI_LAST_LANE)
 			continue;
 		if (m == keep_master)
 			continue;
@@ -733,22 +729,187 @@ int lx2160a_serdes1_40g_4x10g(void)
 	return ret;
 }
 
+/* 2x 100GE -> 1x 100GE + 4x XFI (10G): SD1 with 2 differents PLLF and PLLS */
+#define M100G_PCCE		SPLIT_PCCE	/* E100Gb kept (lanes 0-3) */
+
+static bool srds1_is_100g_4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	/*
+	 * Disjoint from every other predicate here by construction: the 4x
+	 * 25G split matches the same PCCE but leaves PCCC alone, and both
+	 * 40GE modes live in PCCE's E40G fields rather than its E100G ones.
+	 */
+	return PCCE_E100GB_CFG(pcce) != 0 &&
+	       PCCE_E100GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+bool lx2160a_serdes1_is_100g_4x10g(void)
+{
+	return srds1_is_100g_4x10g(srds_base(FSL_SRDS_1));
+}
+
+int lx2160a_serdes1_100g_4x10g(void)
+{
+	unsigned long base = srds_base(FSL_SRDS_1);
+	int m, master = -1, keep_master = -1, ret = 0;
+
+	if (srds1_is_100g_4x10g(base)) {
+		debug("lx2160a serdes: SD1 already 1x 100GE + 4x 10G\n");
+		return 0;
+	}
+
+	if (!srds1_is_unsplit(base)) {
+		printf("lx2160a serdes: SD1 is not in the 2x 100GE state (PCCC=%08x PCCD=%08x PCCE=%08x), refusing\n",
+		       in_le32((void __iomem *)SRDS_PCCC(base)),
+		       in_le32((void __iomem *)SRDS_PCCD(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EINVAL;
+	}
+
+	/* The kept 100GE group's master, recorded before anything halts. */
+	for (m = 0; m < SRDS_LANES; m++) {
+		if (m >= XFI_FIRST_LANE && m <= XFI_LAST_LANE)
+			continue;
+		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
+		      GCR0_PORT_LN0_B))
+			keep_master = m;
+	}
+
+	ret = srds1_plls_up_slow(base);
+	if (ret)
+		return ret;
+
+	/*
+	 * Halt only the half that moves. PLLF is NOT halted here, which is
+	 * the whole point of this mode and the one place it diverges from
+	 * lx2160a_serdes1_to_40g(): halting PLLF would put the 100GE lanes
+	 * into reset too, and they are meant to keep running.
+	 *
+	 * As everywhere else, only the port master's request can clear, so
+	 * issue all four and wait on that one.
+	 */
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++) {
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
+		printf("lx2160a serdes: no master lane among the lanes to split, refusing\n");
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
+	/*
+	 * Four one-lane XFI ports on PLLS. The lanes' TGCR0/RGCR0 have to
+	 * move too -- unlike the 4x 25G split, where the rate does not
+	 * change and only the port grouping does.
+	 */
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), M100G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
+
+	/* Reset both halves, slaves first and the kept group's master last */
+	for (m = XFI_FIRST_LANE; m <= XFI_LAST_LANE; m++) {
+		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
+			 RSTCTL_RST_REQ);
+	}
+
+	for (m = 0; m < SRDS_LANES; m++) {
+		if (m >= XFI_FIRST_LANE && m <= XFI_LAST_LANE)
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
+		printf("lx2160a serdes: no master lane in the kept 100GE group, it was not reset\n");
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
+	if (!srds1_is_100g_4x10g(base)) {
+		printf("lx2160a serdes: 100G + 4x 10G conversion did not take (PCCC=%08x PCCE=%08x)\n",
+		       in_le32((void __iomem *)SRDS_PCCC(base)),
+		       in_le32((void __iomem *)SRDS_PCCE(base)));
+		return -EIO;
+	}
+
+	printf("lx2160a serdes: SD1 now 1x 100GE (dpmac.2, PLLF) + 4x 10G (dpmac.3-6, PLLS)%s\n",
+	       ret ? " (with warnings above)" : "");
+	printf("lx2160a serdes: the two retimers need different CDR rates -- U21 25.78125, U25 10.3125 Gbd\n");
+
+	return ret;
+}
+
 /*
  *   setenv hwconfig serdes1:100g4x25g
  *   setenv hwconfig serdes1:2x40g
+ *   setenv hwconfig serdes1:40g4x10g
+ *   setenv hwconfig serdes1:100g4x10g
  *
  * Idempotent: a board whose PBI already split SD1 skip it too.
  *
- * The two are mutually exclusive -- one re-points lanes 4-7 to 25G on
- * PLLF, the other moves all eight to 40GE on PLLS -- so `split` wins
- * and `40g` is refused alongside it rather than layered on top.
+ * All four are mutually exclusive, they are target STATES of the same
+ * eight lanes, not steps to be combined. So the first match wins and
+ * the rest are reported and ignored rather than layered on top.
  */
 void lx2160a_serdes_apply_hwconfig(void)
 {
 	if (hwconfig_sub("serdes1", "100g4x25g")) {
 		if (hwconfig_sub("serdes1", "2x40g") ||
-		    hwconfig_sub("serdes1", "40g4x10g"))
-			printf("lx2160a serdes: hwconfig asks for serdes1:100g4x25g alongside a 40GE mode, doing the split only\n");
+		    hwconfig_sub("serdes1", "40g4x10g") ||
+		    hwconfig_sub("serdes1", "100g4x10g"))
+			printf("lx2160a serdes: hwconfig asks for serdes1:100g4x25g alongside another mode, doing the split only\n");
 		if (lx2160a_serdes1_is_split())
 			return;
 
@@ -756,6 +917,19 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 	}
 
+	/*
+	 * serdes1:100g4x10g keeps lanes 0-3 as the 100GE the RCW built and
+	 * moves only lanes 4-7 to 10G, so it is a single step from the
+	 * protocol-13 state, no 40GE detour, unlike serdes1:40g4x10g below.
+	 */
+	if (hwconfig_sub("serdes1", "100g4x10g")) {
+		if (lx2160a_serdes1_is_100g_4x10g())
+			return;
+
+		lx2160a_serdes1_100g_4x10g();
+		return;
+	}
+
 	/*
 	 * serdes1:40g4x10g is a target MODE, not a second step the user has
 	 * to sequence by hand: it implies the 40GE conversion first,
@@ -853,6 +1027,22 @@ static int do_lx2160_sd1(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_SUCCESS;
 	}
 
+	if (!strcmp(argv[1], "100g4x10g")) {
+		if (!IS_ENABLED(CONFIG_ARCH_LX2160A)) {
+			printf("no 100GE on SerDes 1 to split on this SoC\n");
+			return CMD_RET_FAILURE;
+		}
+		if (argc != 2)
+			return CMD_RET_USAGE;
+		if (lx2160a_serdes1_is_100g_4x10g()) {
+			printf("SD1 is already 1x 100GE + 4x 10G, nothing to do\n");
+			return CMD_RET_SUCCESS;
+		}
+		if (lx2160a_serdes1_100g_4x10g())
+			return CMD_RET_FAILURE;
+		return CMD_RET_SUCCESS;
+	}
+
 	return CMD_RET_USAGE;
 }
 
@@ -899,7 +1089,12 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
 	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g\n"	\
 	"lx2160_sd1 40g4x10g\n"							\
 	"    - split SD1's dpmac.1 40GE port into 4x 10G,\n"			\
-	"      Permanent: setenv hwconfig serdes1:40g4x10g (implies 2x40g)"
+	"      Permanent: setenv hwconfig serdes1:40g4x10g (implies 2x40g)\n"	\
+	"lx2160_sd1 100g4x10g\n"						\
+	"    - keep dpmac.2 as 100GE on lanes 0-3 (PLLF, 25.78125 Gbaud)\n"	\
+	"      and make lanes 4-7 four 10G ports (dpmac.3-6) on PLLS at\n"	\
+	"      10.3125 Gbaud.\n"						\
+	"      Permanent: setenv hwconfig serdes1:100g4x10g"
 #else
 #define SD1_CMD_HELP							\
 	"    - no SerDes 1 Ethernet modes on this SoC"
diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
index 1b65848db2f..adacedb5058 100644
--- a/board/nxp/lx2160a/serdes_split.h
+++ b/board/nxp/lx2160a/serdes_split.h
@@ -45,6 +45,17 @@ bool lx2160a_serdes1_is_40g_4x10g(void);
  */
 int lx2160a_serdes1_40g_4x10g(void);
 
+/* Is SerDes 1 already 1x 100GE + 4x 10G? */
+bool lx2160a_serdes1_is_100g_4x10g(void);
+
+/*
+ * Keep lanes 0-3 as the 100GE port and change the lanes 4-7
+ * into 4x 10G ports (dpmac.3-6).
+ *
+ * It refuses unless SD1 is in the 2x 100GE state
+ */
+int lx2160a_serdes1_100g_4x10g(void);
+
 void lx2160a_serdes_apply_hwconfig(void);
 
 #endif /* __LX2160A_SERDES_SPLIT_H */
-- 
2.43.0

