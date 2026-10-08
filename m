Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C19CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFE2D40933;
	Thu,  8 Oct 2026 22:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qx4_ZsHguHYO; Thu,  8 Oct 2026 22:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37EC1408C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499438;
	b=hckZVUq5VHmuAPOXRApTx+6Os7eTIFSmWdTbHYZENDFCW78OnEZ9j15sfxkxZIr/8zgX
	 jH7M+Q22uUqnFNISW3HE3KjKKANFXqcKy015KO3E4fdS0tm97C0HcGbOIemqM070s6I6v
	 axjpelnAG4EzJRuBW1jGHkxodo5Z3v5PmdsNhBzZSjGZvD13oMAQliTolsDN5xqAv9VJ6
	 otqDakjiucDveEgdkqN8lJJHMRNB5eV1l0+xoURD5yYuMVj55VWRMiacvxh3bb3K1Fw+F
	 7NwjWnxvfn5Kwx/huQQoNic09S9yXeVk7UemkAHOpgoKdbbE/V2xjw8q8O1eFOb+naA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
	b=ojZBDGQQFwmSMZmlLFzxW4oVbKjlwjOfL+dCDFJnDDByH2HtFWVpebJgICLUgdXOxQat
	 YiFgjMLrrLPzqpsIhB1/lebxD1+KMznTIO3CX84zqGmcDFbzWjGe95JCHM+Oivmv4s97X
	 DfTjARtDxbIygGymLEkUJDLcukVq+qcBJzFixlQelN9Rhbg4N8IV7XTv+9dimUPf1ckRI
	 COGVlF+BmQFs/b6RTReYfOlLAYWW15D9scJUfyxZAkOjPoU0ycaS05aJR4hnQGeMkTzKq
	 nH2qRhGTw0p8uSXaH0drhKA3ijkiBTH2zSTH6jGkhLIDS4Kn/EPJ/7psOfUfvSdpS9g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499438;
	bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5mN5l2X5vNy9B4OHhOCfcF7q2GC/MSF7DKjK7Wl5qBctXVE8KthO66RR8ERsh5v/
	 Wv3L/UGgakDifQOK5SUO7tA7pXAnQsWg8CLfDMONuxvRa8m6aoPQEGkmSKOC+/v8wG
	 13cmorLWKfD98tNexYzV9XljNUOk54PwnaIYzZpRH89f12HNpCFfg+dyyDWRtncF1A
	 yxp/HKFpzgPzfsxAuiy8W939N9p9+8D3THNbs1JrFGiqFRfIE3q2f4pzwm9DdRRjDb
	 5yJHp8bGckFGLU/ROU6MDdGXmsuoh/z8dv6LI4NVmJOc/LSPDvCIBGRJr+EsGEt+zC
	 BlPz3pcd9RpmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37EC1408C7;
	Thu,  8 Oct 2026 22:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3531A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 290A6403B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSKSdy8ANtyO for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2E0AD4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499436;
 b=JuoTBEvDzcj8DnnVK71aWtkasNsDszoL6pPSdC93xek2QCe3m87u1W/XmLKA36QgcFxY
 /Ye1SPlpHt0IctwuCZkpRbxXqRl6upBflzsmX2bVgTXh7NksJUs0NDFrZwHFY6npY1vJ5
 hRCjwRLOQrxEhpOuFr06qSxTCFh3O/1KL2wtbk07gNMv9msT7C60ffEk5WHmHipF4i6Sy
 46HNOj2sEEtCMsTr7zeg5XTB/oA4K9KDBPVyRgm6mde7suwPIWMZIlPF4cZ+1SCOygRAc
 cYjFriHqK3J3leLnzoeSRQQ6id9Nlwb+h5Cucq/XNzQhx4BEc1CVUuvi56kjK4Fetag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499436;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
 b=hOpS8nAJabBZHT+/NUdJyysQK8pj3vOqOT9QfTiTdy4BtKy3h9MMuyno9N4o2yeZHmcH
 tx8ZRcwMV0fc/aX/RW9dtFOBBco8hKrcFh2HZWp5mDTUTjkVzEN/cLsQKgqSLEqQQqx19
 HstRM9L72Un9gtGEsZttr6iSpkXzHHhANItRGfsNiZhZI3ti5BpmkxoolA+J/QutyCakj
 r3Z29kuqDSVoMeBa/PlwjxJ0F5wxqFJqQ3X3eT4yK//8P4EhnJ1qoeQvlXXMYqyJXL87O
 DV7vTrQMbtJPt4MVe07bZeVCo7dYbxUC6TD5YHJ3Z/eNYsQCJd3k860GccRVHY26vgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=erhhDwuA; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=erhhDwuA
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E0AD4006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4E844B0054C;
 Fri,  9 Oct 2026 00:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499434;
 bh=05h7GbiCFhP6S1z3rt1gLUxMsyLw/lyhqqTlRK4Hdwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=erhhDwuAcOcavGZVp14WgMQb52yMwBHRs4GN3oN5bEM1Nr+LvuAYApNDwkDdZohHE
 E1Zn5AUdfMCvpNn9754VMCuydFFWxAz1Pzc2CRUc79p7SbODjxxCh+vn1s6noHzKym
 v0Kcvh10tm4jDjVVEUOfl3+FQlhAxU7+sAf8A+HNh3M7FzUeGGulXd5eIBoqGQDFBv
 QMyKAGimMwQg3F9x9hmWMq3PE1ICjcsWrFC+SqMcPcJbfVc8Br5tfLnyfh6xnUzVVc
 PsKYO6OiJgRY21Mg9kbnQJvIftlFsckJfgFaX6kIK9AbSWZZ3/bm+fwni73F1sZmem
 7GrVaCbBPeL2g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 03/13] board: lx2160a: serdes: rename SPLIT_POLL_US to
 SRDS_POLL_US
Date: Fri,  9 Oct 2026 00:42:16 +0200
Message-ID: <20261008224228.512353-4-vjardin@free.fr>
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

The poll bound is not specific to the split.

No functional change.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- New patch, split out of "set SD1 with a table"

 board/nxp/lx2160a/serdes_split.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 1a5c44e7740..aeae8fbb340 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -264,7 +264,7 @@ static void print_rcw_view(int sd)
 #define SPLIT_PCCE		0x00000100	/* E100Ga off, E100Gb on   */
 #define SPLIT_PCCD		0x11110000	/* E25Ga..E25Gd on         */
 
-#define SPLIT_POLL_US		10000		/* NXP waits ~100 cycles   */
+#define SRDS_POLL_US		10000		/* NXP waits ~100 cycles   */
 
 static bool srds1_split_state(unsigned long base)
 {
@@ -298,7 +298,7 @@ static bool srds1_is_unsplit(unsigned long base)
  */
 static int poll_clear(unsigned long reg, u32 bit)
 {
-	int us = SPLIT_POLL_US;
+	int us = SRDS_POLL_US;
 
 	while (us--) {
 		if (!(in_le32((void __iomem *)reg) & bit))
@@ -352,7 +352,7 @@ int lx2160a_serdes1_split(void)
 	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
 	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
 		printf("lx2160a serdes: LN%c did not halt within %d us, continuing\n",
-		       'A' + master, SPLIT_POLL_US);
+		       'A' + master, SRDS_POLL_US);
 		ret = -ETIMEDOUT;
 	}
 
@@ -381,7 +381,7 @@ int lx2160a_serdes1_split(void)
 		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
 		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
 			printf("lx2160a serdes: LN%c reset did not complete within %d us\n",
-			       'A' + m, SPLIT_POLL_US);
+			       'A' + m, SRDS_POLL_US);
 			ret = -ETIMEDOUT;
 			continue;
 		}
-- 
2.43.0

