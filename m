Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C75FCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23AF0407C1;
	Tue, 29 Sep 2026 19:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljuXxvdam3jA; Tue, 29 Sep 2026 19:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6CD31407B8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710516;
	b=OCtDanaWcFJ/IrU/+yWrUO+B7UsDq4cixw+XBg6rT1N9j875gv3H6lsIas158gCr3Cn2
	 CgjQ81PrUn7H5jl6I0oyfacldAgXbZtHfq92X0x6WwQGMM43rlHRvaBnDnNkZe5z34fpu
	 I41lHMMu447Zxzra3fcvxk8QJ/6WatDF953haVLXHtdAaEDCb51nVoHcyLrz6n74FKamV
	 +7m0Qlix1GX3zx7lb8V1MxQnd+wc0LBy6hqed48aIgPBoIDXDKXAXIkL03P26ZcNfNuik
	 8/FfyiawsCA+Fh3SJ71KxkJtf+rLkqoqk/bHa1QtIOMO3uDAd+wmenRKd9vtmcATTSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=znHHlXKrrJL3YpYvu1vWy4rUakssPAj24jWZyVsimco=;
	b=JIDdNtBvrpGq4qmPU7Bk7e9FuW+DLDoi8KwCxaK2UAc9gB+H20tMGx+Pn2v7sXvwInaU
	 6uQG8lA7XYvyQz5WOIZf4HO/Hdgk4KERTOmlpkQ4hxXPBEale8PUy+6pQsXMpxBsI/l20
	 66HTbhA3EkkrsnmobCanP36914b+G6BaJsNQO/BrAHgbqf5r9IztvVnDHE9luECPuTvGf
	 GpAL/eYGAq7onPWbiqQe+WLiY8w8Prt+7OUntAhmam2vgAglbo7OH2uRU4tnMJ4nezd5X
	 QRpk40nRv+f94MAAqrWekSsbVPUHohQeW6t47cOCn9AMsi/lldte0+JxcTsJHSNX5YA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=BYZLZOfW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710516;
	bh=znHHlXKrrJL3YpYvu1vWy4rUakssPAj24jWZyVsimco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vmdpRmnhNr5SRdVOPWrF/P4NAG9wAl/oe93codJhzMoY0eql+4y6GjTrGsx2Agk5E
	 lT7Aq0mEGqJXWMi/urtUYVgBGnS7fr+qGhyWJlm+5Msndlngi2IbbrNtiqgsK8aMms
	 sA00I8TDOIOJI2CU+JsW4uN1n52Z1qtUN+Kxygv+Z/kgyan6QKJ9bEtUqzyEu9TuBm
	 SlhbytllWHb0ejmoEwy6tmtCwrUrVSbjwAIv8aLun62xKn4FZVdovh4a9IUWAFVweI
	 8w3N4oQySVoPpSjJ3WYPpVM1Um/75llXPNqob8qc7fHWm5ojDbsszQjpBHg8BGNFkk
	 ma8G4FCmRQSeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CD31407B8;
	Tue, 29 Sep 2026 19:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6919432A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FC3B407B8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gl0iE_0K9aIX for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A6EC140766
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710513;
 b=qr3/RG/Z+U4Qvw9T6oGvPVk6wVDuLiViEUB2sRoIoUEpJv2IkAaG1YVWXNxofOReHQik
 7LPgY/ZAtMGR0nKuDK47fTy63i04PN5w7Y29bWEYvcFCTrc+6te3CrceSEo0bFpnHqRfg
 bkuXfZX9z5tux9aIcJ3KhEtXypPhlPLIfqAUW0lzmcwgijCNKE7ekQQyYCTL+d7jDOkhe
 dIapViiIRyPdCRUTDfA3sG+7cO66pdu6L/A5WQWYtdHGExQM30GiDAgybDpqYwxyQSL1C
 C0hhxZsw7xxxYk/ACPE1l58nf11Zv1EHv26ArtalnftmvFKdUXcpoK3fT/51mlLeogw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710513;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=znHHlXKrrJL3YpYvu1vWy4rUakssPAj24jWZyVsimco=;
 b=ZRJr7cDuhgMDywd2jns+bnI/8Qly1wQVnwu5w6RpcmyY6gl2MnnWLxfXs2DvyJFshOKZ
 crLcPSuip1zmdpz8xS+zGkc2TnHApoxGBYETchmVeM4TqDrXLqFcYOXv0EKdD8XKqiu7P
 Al8+r4s/zSruZ0gQcLoAAhZslbfyyM2LdJlPyeKvLOt0RBFxxohsYrpl7jgbDdawhb6Kp
 cVQvPe2nOgqdiiBQzSwqltgPsSI/VkLm5VsrBpqKB95LlhfTvoy99tFhvs7gQqGJfQhBX
 ktiXIrzZQYO2wpflp7v/k6IBSdURpVrl7vl+wyhmouyy333NPg7JZiS/1+hOtGsFuJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=BYZLZOfW; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=BYZLZOfW
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6EC140766
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DB438B0051B;
 Tue, 29 Sep 2026 21:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710509;
 bh=sMI65sSYOHg3T/W96odSQcF7qoyWAS64xXgX1JSGcpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BYZLZOfW9DVC0vp6XW8/xkT91RN1a57x2yzSGIKPJVcqWbBsTB9T3EcB71H9/dVKo
 F1xTduneb1gJOn3hyJdZrbfG+Stc4uuEARFOGga8WQwGLpTgWZgBdDKRZTjbdBbeaG
 91S8tvtXUYmyOGYaxObxJaaQZd2H/Z5aQnShDjDfYEnPTpL4Hri3/1P1b6q9etMNAa
 ErGBsMYVYD86+W3CFjO4P+KfnuW9yRQ0gFfl9kx/sy1+RawO3y4rRLhXB2KQkB6WU7
 BYESlelVnGKJ6Mz8u+T2wN6dkyLD2c5wkVwm/4XK/k0djLjVG6HKVfvF4M47lQips7
 B8a2VeaAWktlQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 03/13] board: lx2160a: serdes: rename SPLIT_POLL_US to
 SRDS_POLL_US
Date: Tue, 29 Sep 2026 19:59:35 +0200
Message-ID: <20260929175947.1379710-4-vjardin@free.fr>
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

The poll bound is not specific to the split.

No functional change.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

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

