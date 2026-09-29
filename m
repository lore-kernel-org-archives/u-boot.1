Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8569CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C1F5607D5;
	Tue, 29 Sep 2026 19:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wwKerSYUdpOw; Tue, 29 Sep 2026 19:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7440D605D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710664;
	b=NmO2gThU0iTB2YO1WYsqSWhcbzsYHxiIVLYlsXvbqd6UO3Hp5Tb4m4F7xJgKAudPF3Tn
	 YO4oJBFy2mbG3ZdPIkpynmmnk4AbzusNPSctsBHjx4lCVps1p6MdBrzR9utPYQHNm06MI
	 XTqCyIN21xJS9Dy7KApXquuCCijscwha9uefNfQnsG3sIUo/NVJ0zLz1gR2dFBQoIHsiO
	 JDiJeRm4brVoDl8tbqXvezdtRLtNCi9QEdeg7edU+CVXZw/vcIp5cfG5yOc4df8VXVaKB
	 MVY4GOyzbuHhprRztaKp+PrKESrSk2gdGCLvrdwGx/SOsLKE6GJCKjMPXw0Pmg/NF4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5SUJRHiq/6OMiVoJ+g34p0BN1D0duot2jEnMKpdvYFs=;
	b=gbralUhOuKZbJgnORUOiocmraVHpR4ouzMBBcgsYF0jnOFhnnOMk8z/vknXWBDoS7yKR
	 XFuvnwDiTiBWRW3tWrXBV+oTb+M5e9QU3Mavwjsrw2KMbuyArWst8ca3K6wxM/y9yi5TD
	 gs81Xb6zwemNRqGocCg1dllJKVdytCEgiOL0htg1pa7v/Oj8EEN3VuK0IetrD+VURMUbE
	 xKllD1RuduIZ9U+O+XPU1LRl3kW6VqqrM/772Cp2DRNQyo4lTxpNyYH4yKt7/CmjxpSX1
	 cNQm2c2ONgGo0oGd/Dy+5lwccXKRVecKBWiAktpHekD1W2UD/WyBq7Fg28fYcfheb+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710664;
	bh=5SUJRHiq/6OMiVoJ+g34p0BN1D0duot2jEnMKpdvYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sAAxhViWtrO+6AUILLD4rD66RAo1lRqPbLJKWiswIYQDKq3qYTZ3jlarlY5ZUZfFT
	 y1L8C9EXHtxVbdSS9Y6In/ckEEhWqwwroJ7vjc9lmIt9mc7il0b4p8PpIij7J9heG3
	 tXHtibNgwg1roTPoPEaP6OspitsaFktAcv6tTjrMHZ6wyBrV0AnTbirRDPkiOCTqgW
	 x90BDnVCHDsRuM8qKdrQnMgYwsoc5iDIMyfS9a7VepoqvHcko1J/nXyPz68FeQtnb6
	 SreOFJi3hFuS3C9lQt4kFEkhDBkkXd8fS7hGLLz023t1O0k8VezN56R+/Yy51gPNZD
	 FBQ+xcUOkewzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7440D605D4;
	Tue, 29 Sep 2026 19:37:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A9D13D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C7E940333
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ea5EXgx4g3g for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 902D2400D5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710661;
 b=r6nrEAsJxRgb8gBbwSZ4/zR3FybVnQRN2rj5HvPrYJ+1N+HcLfwwpLtXJb8n28ID5z4s
 OZDeZ+wJzQz9TNGan9W1fjAYB3AzFHHncJVA9CZG0qQ/Q9OxA6hTNL7aP1SQtXeM8mXyP
 XSF4LLj6uOj2qKnNoPgodBBYhZJ0nfBQXmgKEe8zxUh4MJqfBikrGuiXHaQKq8Pd8y0l8
 p0kjuphpudmgPX3lYZ3r+eZm/TjGYlXdZMdteLjc0Qr2ti8WhqrAJ8ZunhbTzEpXPfHMc
 uW1q+YMnBzUuPYgGO8Z0TH+vAkaEnTWICMjDabGZYUIc/lXagkSRewpBjAMWK3MXzwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710661;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5SUJRHiq/6OMiVoJ+g34p0BN1D0duot2jEnMKpdvYFs=;
 b=qnx9NSglNoJXiiPPILKh7loNIs9RnU4nYDonL8QulLljuTIeVjaUOe1os70jswUWfrC+
 bQXPixaoqGWkRf2igrLhZX9XgVvPyzhwFstyRqTPs6ev62bRV9B6pcU1GwWKuwnaLY4dH
 +12KpdTvRU/+M00UpmZDaReLRZHSJX6F9AXtIQ2bE2C3Im0AxnBdU7qKE0LxDgijEs8p5
 uaIavKmiUcR/zs3sDuuFXEjzVPfdJjluGE0UOedyHd9a0bkd6Me2ot+85hM4TDbaz+kHz
 0/PT26L2Mw91O+vKzEfsEEd+KN6av86OOsEUEUAmweS9A95NNtr16tidtZA5Zf67AXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=tzj4NNLW; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=tzj4NNLW
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 902D2400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 6BE27B00565;
 Tue, 29 Sep 2026 21:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710659;
 bh=f+u/BQfL9sdx40dWxbQdsps8YucgyPWJeD+hvri7st0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tzj4NNLWuxsGpiHk3vasB/Ey+Pm9zBAxukut5WvW/mXnjkVFAVLAfNuVSDIq/CihL
 mzPItUXT9+pPKbKdqPMnXGImGY7/nNxjdz6Lp86pzioPxcv3aJwV0/DeqkXSGTWB0a
 f3ninyj+PHx+nw9JKJPW/C7i35dC+HRqOhLILP9RKgKtn0RfPF6ejWCJ8buZjM21Z1
 YB/IrXGKpqc3OnxiB55w/4mOdq7Pyn+uswoXdZhPDrGwLY3GThLiEpjii9xb5Gl4mi
 ZTERjLL+IIFJKycEdHnHH3RuQ/W+RVlv+A91xlKNJ4bkGTQt5UM2cmf72wjZkl9fZq
 6aH/k1KfA+Eag==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Date: Tue, 29 Sep 2026 19:59:42 +0200
Message-ID: <20260929175947.1379710-11-vjardin@free.fr>
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

Add a SD1 mode that keeps dpmac.2 as 40GE on LNA-LND and that changes
the LNE-LNH 40GE port 4xXFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v5:
- sd1_reset_req()

Changes in v4:
- was on v3 3/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 5c234d4d4bd..9c3e5f9561f 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -380,11 +380,13 @@ static int sd1_halt_port(unsigned long base, unsigned long lanes)
 	return 0;
 }
 
-static void sd1_reset_req(unsigned long base, unsigned long lanes)
+static void sd1_reset_req(unsigned long base, unsigned long lanes, int skip)
 {
 	int m;
 
 	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		if (m == skip)
+			continue;
 		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
 			 RSTCTL_RST_REQ);
 		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
@@ -441,7 +443,7 @@ static int sd1_enter_100g4x25g(unsigned long base)
 	out_le32((void __iomem *)SRDS_PCCD(base), SPLIT_PCCD);
 
 	/* Reset. Every lane is its own master now, so all four count. */
-	sd1_reset_req(base, lanes);
+	sd1_reset_req(base, lanes, -1);
 	err = sd1_reset_wait(base, lanes);
 
 	return err ? err : ret;
@@ -562,6 +564,62 @@ static int sd1_enter_2x40g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x40GE + 4x10G: dpmac.2 stays 40GE on LNA-LND, LNE-LNH become
+ * 4xXFI ports, dpmac.3-6.
+ * An XFI lane is a 40GE lane that is its own port master:
+ * same PROTO_SEL and width, same PLLS and rate.
+ *
+ *   XFI   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
+ *   40GE  LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000  (but its master)
+ *                        ^ PORT_LN0_B
+ */
+#define XFI_GCR0		0x00000052	/* as 40GE, but own port master */
+#define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
+#define XFI_PCCC		0x88889999	/* XFI converters for lanes 4-7 */
+
+static bool sd1_is_40g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GB_CFG(pcce) != 0 && PCCE_E40GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_reset_both(unsigned long base, int keep)
+{
+	sd1_reset_req(base, SD1_LNE_LNH, -1);
+	sd1_reset_req(base, SD1_LNA_LND, keep);
+	sd1_reset_req(base, BIT(keep), -1);
+
+	return sd1_reset_wait(base, SD1_LNA_LND | SD1_LNE_LNH);
+}
+
+static int sd1_enter_40g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+
+	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
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
@@ -582,6 +640,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_2x40g,
 		.enter = sd1_enter_2x40g,
 	},
+	{
+		.name = "40g4x10g",
+		.desc = "1x 40GE + 4x 10G",
+		.from = "2x40g",
+		.is_active = sd1_is_40g4x10g,
+		.enter = sd1_enter_40g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
-- 
2.43.0

