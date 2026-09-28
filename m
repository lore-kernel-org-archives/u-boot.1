Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C94C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0275D60672;
	Mon, 28 Sep 2026 10:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuQTdAd0n3YS; Mon, 28 Sep 2026 10:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4A6C460681
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590612;
	b=DiPHW6ZT0aNQqqBV8jWFQzIvdrBxlisdgv6f4fEltQUX/DTB5GHexA1gPRqGbbZMSI+8
	 DUNtM3EGZTYm76dle3c5g4atpQFNLmD1iX7Q6qFED9GLUk18x77bWguLMRbbFfZL5eTN1
	 hKujWOxI7wsUHlL0s81iYbuAII/CKNNr7svhEIE/Lk+5zFJt5AgFIi58RSTpvTYUa/jgx
	 OYklJ2Gbqs0H6MRnYrCK6BWmU0iVdZEJmHCj30oJPIIK3jELq9uNqq+poXnNuqTUt5vcn
	 XvCiysu21JF9jlNyQ+igqNuAd6SQ/DkbDaqS0DissxFi4G1NtbDm6Xqiu/ZeVdxqUnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0VMh85x2fq8E+UvGwnAGH1eLkvlE5Y6kLEp5YmMS3nw=;
	b=pZj7mqPPKpgaRlq1PQ0wQ4N9fyayvcYWEDc8pM8glJkouRY/RDuof8uOs6fJfX65H9tt
	 mafSMojNwUzdXgGU+MpzTin5dgddAjtCG37h/0yg7DJhJGVOCZThZzikQbuP3J4E1jYx4
	 1HidZPx+hkKY8fMMjUbKm85pukEr0OH+73quCBbCeLIUP4IiL5ssI2fs6qISW6gVaNIV2
	 K0HBUB6tzK6aFJFrs7hZBtTAMhIkkv1M48BzuB+4NF0XpwCqls9hXHrtTxLjvscdQHM/Q
	 LWgSJ7Y3ibW08wQF6rYHPX6lYR+NWg5m7piddq9n420o7t7a+fArxRCRzKc9FEbTGXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590612;
	bh=0VMh85x2fq8E+UvGwnAGH1eLkvlE5Y6kLEp5YmMS3nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/y26xuoG2zua58vvgYChwgx0P+gZ/sGMs+6HxQcTRRtuf5AzGdj3dEL7FjI8sJGV
	 UUue1YW+g1tR1gN02c26IKJ+YBfFKtVMia/JMBGaRWhlJLMmHK2KZLQwWkOqckIAEn
	 MqYkbkHZYz9oHcE/MD5tRVJumL/taWNxykJas3y3R02qkcBI1mWueSrVaBG16nuAzt
	 HdqF491MEpsroauZdBU+F1LfDgYPgmVHxQpugu3C5ePQlVvCIMmc5XPghpkvBg6lXq
	 vE6r0b9xDcENEIuds1WZBc0QYSsLLwb9kI8xtzLKOi2w3iLUj2RHrM0vfAs7QJikgV
	 H98oLylRmcE2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A6C460681;
	Mon, 28 Sep 2026 10:16:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 274D43D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18FDF401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SAGvQpqS4zR for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:16:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 685794019A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590609;
 b=H0Q8WA9GapKF4LikfMjPAsEs7ph6VKtPKnpy8M9JjIboMQUfeMTGblbUAHFElLBBBk6e
 OKyycgkWwxHo2MTw/fxkRIuquGG7UwFAVi/B6RD7xR31CfFqOMBUgV/z0+0BoyB8h9pD+
 HLJGfZjXLx5J+6IOmyl+CpwmbhH61RQVD+IM0N+jnBFtOcqZDF/A3i5JkI1FYZjAcw6hd
 o8F98A20k/Dx/+4AUw1l9HxhgfYZjXFIfxNyryf5BMsQMjBz1mePhDCTOzBbQcSU9VxMd
 R2252Tn0pB+e6ICh8eyxImM5rIPzcloU/CyJsaJmGBSk4LtMtdtE1ovbqWsFDjlqWjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590609;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0VMh85x2fq8E+UvGwnAGH1eLkvlE5Y6kLEp5YmMS3nw=;
 b=ENAhQlwQNp7vjm1kefJtB+8xX80YnSWVCrBi/R9C6HgOz+akq07L7IqK513YYHIKxmGa
 Pz1WfBkU2D+Umx5HB7gnOtzkhkngPNsVCNweyNX7yaJm5siQ/w0+vCsJDWzJWONZqFtaM
 9CqTJBF4oAVjKbCKEVugk1Mr7Wnl3/OvazaztmWEdsh7TO2NLI7IeCydyRxXdXzrUYnTj
 VabxW0dSIhZTl+blpCRUQSy5k+ZgmBjB94uUcs36g83ZNjCDEO++P/2RW9tAmc1dRwAFP
 54PXHmtRo749vCEHdA/9XLMDrlju+82+G/VRfi9zHcoVxer2rMLV3XyfSdjneLjHCYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=BUQIlJCV; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=BUQIlJCV
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 685794019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 676DFB00548;
 Mon, 28 Sep 2026 12:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590607;
 bh=1I6zUkzf3KznUExmWW34SVbA7Ln7kuEvS/Tu8uRmRrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BUQIlJCVHmIt23j1UWKIzEBopONAuafqkOwqlqvFKL3YHL75WlOPHlwYEiD3vDP9u
 SOHMXlLtSac+/WLApc/v1Go/VOf2fEzovLaUh5xIEQVbV2G7dWIeNUUR9tIfdKJGAR
 uVumm59tGbzUBEu2hgE7EiREpa9mLiPoTtKSZWMNZaRrJrSPAQndmXrGGeD6bos3Lk
 Nct3qttSdwhQSsXuS4fo5CaKJ9s6q3XqPa3T7t5oG44sFoLCQD2cRe4Gck9Lb1aJda
 WmWRHCl/20IC1haGisOOqj3HGf5yLTWRRrX37d2D7KkAdA6d3pPJID91TYwr0tFcGV
 im1gDJYwRmeuA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 08/10] board: lx2160a: serdes: add serdes1:100g4x10g
Date: Mon, 28 Sep 2026 12:13:27 +0200
Message-ID: <20260928101330.881662-9-vjardin@free.fr>
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

Add the SD1 mode that keeps dpmac.2 as 100GE on LNA-LND and makes
LNE-LNH four XFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- Was on v3 with 4/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 1c228dd5c06..7556ab57c73 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -616,6 +616,55 @@ static int sd1_enter_40g4x10g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x100GE + 4x10G: dpmac.2 stays 100GE on LNA-LND at 25.78125 Gbaud on PLLF,
+ * and LNE-LNH become four XFI ports, dpmac.3-6, at 10.3125 Gbaud on PLLS.
+ *
+ * Note: it is the only mode that runs SD1 on both PLLs Slow and Fast !
+ */
+#define M100G_PCCE		SPLIT_PCCE	/* E100Gb kept (lanes 0-3) */
+
+static bool sd1_is_100g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E100GB_CFG(pcce) != 0 && PCCE_E100GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_enter_100g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_plls_up(base);
+	if (ret)
+		return ret;
+
+	/* Halt only the port that moves. */
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), M100G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
+
+	err = sd1_reset_both(base, keep);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -643,6 +692,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_40g4x10g,
 		.enter = sd1_enter_40g4x10g,
 	},
+	{
+		.name = "100g4x10g",
+		.desc = "1x 100GE + 4x 10G",
+		.from = "2x100g",
+		.is_active = sd1_is_100g4x10g,
+		.enter = sd1_enter_100g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_findn(const char *name, size_t n)
-- 
2.43.0

