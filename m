Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B428CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5368C608A7;
	Thu,  8 Oct 2026 22:46:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAL8otvb7MUB; Thu,  8 Oct 2026 22:46:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C94A60872
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499586;
	b=rdjpxOTD2UjUmhJQd46ZggmREdfgZHiy8Z+pKTOX6k8eUUOLx7xhFfjLuvdd+8uJX18Q
	 5SdLPh9voOScpHZ5ruwPzWcfAi1q7UbVQdq8M66VRBy5tbtjHpDCiNS5j+LXUn34o7NK8
	 Ll/GrQGpzRtIgjPc69YBDkZNEtVqzO52nkAcxzlfbGTB6xYrCisPE8fqiE/rU/eBSLc54
	 mUlsbX1hz9TG7/VqZZTTc9QszDTMUvZIFTiNrYP9d2Q8oF8G4G8fWIXjf1LrOhOHS72Wl
	 Po9sEkT7pC67bi+VoEqDnSInOQoorFt1jWpZWohkrEa5KnQNjUuvypWEXMA1BwmeqvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NmykHBnG3iqqllAtmSR4VZP6jV/9iI5fW7zrME+2ZHk=;
	b=Wjsg42UT8C4gGZOtAMtUSw+DqhPoOzfe9N4dUcWl2etTKIyqgiT3zGwO0ZnRb0fwc8Ex
	 nSbsHI+0IQGhtfuJPqWfaCu20Y2wqxzLA8cDm/xgG85dzfVuDwdzwysPefo4M1QUA+KXk
	 tYFgz8FmcOKfpSHIPVOyIkXmC3CUkMbUDbn70v8yeqDQc8+lUu6L511gRPtR/GHx6RMjA
	 8GphQZkh/sjFak5tCesgEGZzReHIKKROFQ0tuEFpJKmgj4X9YB4SX9UgDk+nBpDPhy1x0
	 EMrwziU7wD5jBumhaROrDVW1oGzoocJxTK5oWX7pa6O6q1z+ZqdB9fIC3s5Qy+A91NQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499586;
	bh=NmykHBnG3iqqllAtmSR4VZP6jV/9iI5fW7zrME+2ZHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxxWUqmXCs7t34I65vxFXHaHjL0rviS6L/0IPXAnHQLOPgANJLbGoRuIwhdPD+J+X
	 Y/mlDJ5hHFD+Phz2n1OrTqmho+YiqCWhDYiu+LFXShJPEnZqWVJc2E3PTA/8yw3Rcj
	 L/aOHFO4ClJ9gYGhzIPWbOqOz4hxTmJYRTCoyeAsbCNJgtQG+7KAomyVTpubMGQIVh
	 nvGv87qHS0BJtiSd7EGYoIjVJMwhAgdsAtUum52b4a/6EB5udoSCOu1isXLv6kgdUS
	 sQ0zl6zZ0Sl9O5IIc7MHP7lbUQT8xdc79bnlpnywgTIjA9GKULFUmdIi39IJtQtxC8
	 b9plgOOqiQPKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C94A60872;
	Thu,  8 Oct 2026 22:46:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78B931D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ADD140098
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFzDqKKPdDqH for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:46:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B77C24006F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499583;
 b=hdk6VRx45FbYjrGueRtwYNHxKc1d+eF5dG8WmBho9nMyHjxwSOIENgEdJ9xzjwdsOUgR
 p70dGTodnyYu3Vnj1ZsBJodgqlvJAIdTkmJkfnD6lhnqujCSUxXpRnpqTOAec1DwceiNf
 C1Qr/PylS4tfCJgg+OohndaGbarfrf0qOBgoBLQHET2dRM4nezNamstoDZiM9yyz+FkUS
 sWrJ1M7dtdFoqih3wHdq2FYEOI2/X3YMRBKjrirB3QdWDiMDueKTkz4SlBpt0V7X7Pdb+
 oRJoGIYJZLKC4yCIeh1MJnf5AYXT88zOMgoKGIgX/HL2n98SlG1ixVVVbKRr7MSJlPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499583;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NmykHBnG3iqqllAtmSR4VZP6jV/9iI5fW7zrME+2ZHk=;
 b=MDNjrQxyiwvTcqXIo5I9lpTsOPBTtMA7i2iGvU1D8JUC9HEkKfqSH306IXVD4hSZAc9M
 xHGJFCJK+emmxsdu8x0ZM9DjuPtfCgh71zz/a40MnqzIUHIJyH/ndy3PsfrILh0XGN9T/
 Mm/5okv8QnH4/bTubL0iYK4d0an3t0y1F+KFj+oI/cvSb+jC1TQ1Pa8R3pWj4MCODB0Am
 X7jYTZvwanshKL9+03RFjhIIwVu4KijbgBzJycQ1s5TgzaQlb4NxNsM4l0rJCdGPYtPLV
 Yu3besvxdi2sKab96rS0BfN0zzHfxqaqiPMbpLfE19csqWPCAeDbEMwByjEN7BcptUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="MmIaTv/G"; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=MmIaTv/G
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B77C24006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 46284B0054C;
 Fri,  9 Oct 2026 00:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499581;
 bh=gWarvuP/FgsoYtFfvKMhQreEY8cW3yTB/DOr+Aeaqgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MmIaTv/GO/8A4phQ3jwYTKF1mz72ZeMPw68dt9OpJMecTz8pq3tajwoBUCzIJsAcC
 RY80R09JrVKHC0kfEvkVI0Zz82wM/gsSKxUZrMgoSWB8r13SMEdftjNW6PC0LWyuuu
 Aryb3iTM5s+sw6su5i9RnwiQifp++FWfOp444r4Hvr5DTgtX754O5MFSGHtmpgn+Ge
 M72w6L4AK6vpwAz9xd9kzF186atbkufLXa7dY44kiFGmmHU+LBmwnt/OEPsj00ytxa
 1Rqiymwtxg/KKvhA3//L3jqqFKRSVgS9kUt9JPPDW/oqxmf040UVNAsjVH9ijULvpb
 Hl/4PICBmtd2w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 10/13] board: lx2160a: serdes: add serdes1:40g4x10g
Date: Fri,  9 Oct 2026 00:42:23 +0200
Message-ID: <20261008224228.512353-11-vjardin@free.fr>
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

Add a SD1 mode that keeps dpmac.2 as 40GE on LNA-LND and that changes
the LNE-LNH 40GE port 4xXFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v7:
- Reset only LNE-LNH, as 100g4x25g (Vladimir)

Changes in v5:
- sd1_reset_req()

Changes in v4:
- was on v3 3/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 41208ca79ab..316d500292a 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -572,6 +572,50 @@ static int sd1_enter_2x40g(unsigned long base)
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
+static int sd1_enter_40g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, ret, err;
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
+	sd1_reset_req(base, lanes);
+	err = sd1_reset_wait(base, lanes);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -592,6 +636,13 @@ static const struct sd1_mode sd1_modes[] = {
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

