Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8610CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9097C811EA;
	Thu,  1 Oct 2026 20:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz9L0p4l_UFo; Thu,  1 Oct 2026 20:49:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C5873811BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887740;
	b=DeZ4FEYq3yN1PTHkbKPUBJ4ljlyJSVuuXR+pf+RgoHm0CCrQPEgjnJAQLvljpuAsOcvH
	 KyqVYnB/YN2i/OrefEuQq86Lx4kZXARcPHPMRVqcGzyjKI8VhNH9gPe+p9qrZibCWFwAu
	 inzOQo3iq5C5Zj6fQYTil+xZSmW5fAES+qAtzZbXU/HORT+qKUAw9fypvEi0ROMZBejkL
	 Ulvl4H02zphDtDeJCtOwlXTL7hp55yZlJEG87DvQOJYJZKFwilbmvlkQ66qq2ewaM5nUs
	 AgKd+QG0FIned0hLNiC83zLRUczXlMr3VpsqRCaSHoU/MTTVeQIFAg0LspS3t5VySXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
	b=FFh+m/zEIZSGawSfAq+RbA7UtnAWfY7m0fEUn33o3n0mGQGZdVqQEu2dgAYu5+GUaeco
	 BCkjod7/U+LKNk3sKIgtcQ/4vERjAXIi8yYhlqk9XCcJWoEtl0KxUN9CvZopeTzuzO8tL
	 S7YCJmIUNHC0thnLFC+6IqnDZhFRKFl4jBm+7lKY+j9GOKe8CdlX1fkUhvegTMeKYM1H3
	 asYTT9Vv3X/PvvrCYla9uSiSZ9CnmsfDlLN4Pcw3vIdCzSBNAwAQVD+voH7SsKqXn9au2
	 jp0twWsyKpRsjk8RQAmhEmMQPzZ72EFa3Im5gwteQf7Q8QZZkdfMAoYJuKrM1quw6Fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887739;
	bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knJnOYhrDTtEfvjuaUm3cYvLEnRbfadAof+Lm4Z28SODNQijSEVV2mLr8N1O9vt+w
	 C9CRsKyCFUZG2dLLcbgCAT/VPAR/w+LxCX6lvZ7wqZo8YGNCx9Rt41hlxJ+P6BB0co
	 +DeePTSna/FUS8GXYNVNUzdlQEeGz/usEyy/twtTJ4OSlzQ4lvv12vUMO6jNwqNFWm
	 gaT9NU2q/DgP2byZjK/OFKFx3/ar9bB6up0Ehxcv9HrGM6R6YRBGHTC/OzinyJIUWT
	 r4LjZGb8iqDnaQ0saKGAnv3vWfe/87NbXCLn+xtC3YAM1aYuKouuauKAZuPjsFcIAg
	 AedV8Q51EffPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5873811BB;
	Thu,  1 Oct 2026 20:48:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34D92282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AD78607E7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id erJGY3gdd_wA for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 64A4260660
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887737;
 b=R3jZvdm1LrvLWbjBd+uJEU82We22dcmzHIQOthIVxm04DuA1qDAGqNqt70nn7XtnaCHc
 Gr+pJYHtKCjzCkblKN7uEfIlD9ZLAZn3HUrqBJ/8YBn9VRUQ/n/2sFrYqTXI/wwVrbSb7
 GydRMmB2jtJs39iS6Sh0o/E5vHmyuk9CMSlMmK6HqqzsDkzB6Fl0/NFH7kNikBWoRK/BW
 zmDUR5MjVuzmWigi3tAlM9mJ9VvwdfnMsyXeMHIudOR/UmKwkAyOem5HQ6TVkwVu90HUz
 6IIOZ6GsYW4qu43LVk0LFFDZEUlcGIKl3qngCVJmJKRa9hMabNq9fFB/tfzut4Ogz5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887737;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kUifEAxxo8GipAmSlSNcvZAUCeFDkQQqhtncNvHoWFQ=;
 b=PNHSPY/1xkmmD6TH7REhu/WMiayRWlM06Xj9ZwDKLU4uXH5/kSNNKUxkXmIoLRSgVAG2
 IF0B/Uv/VSgp0EWdIgTGNWZhkjeNVDrZsuhNr5ysrDsdLv9mvmKXZWwse0TH3wVGTsKQl
 g0TG3f5Rt1tcyfIr1KERa4P5GkGuGXzOPA5QdY7WMUp4Nf/k2J/jeJj2i9BGH0J5r3zqm
 yDbZEYRsqY4HfHo+ZN7bO5tZddkkoJZPU+xwjccKuDG1IA7a/AHl8fTd5tacDeNAY+s47
 jDREBRIe6nLSd/xoPy3WqMC2JIEPlOhZ1ceI1z2F2Qu8MX/pg5GG+zAh70kGf24sG0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=N9TM3QKt; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=N9TM3QKt
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64A4260660
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DAA9DB0055A;
 Thu,  1 Oct 2026 22:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887735;
 bh=05h7GbiCFhP6S1z3rt1gLUxMsyLw/lyhqqTlRK4Hdwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N9TM3QKtzsZpg5AJOrhdAISgY+uVyDRfbNBEjEkFVQdap8xtK6KX7c7ILGxKOJLI+
 tbLPmwpedi9HCZYhTRLm4WSb8uv+wXyUlXiDezw2d3PzKj/5iV5md0XN9uaErN4Kwg
 uKDIAehOy90FXdtI46z2NBUdX3XkSishNZ505Y22+cLbFqCOnoGb0cl8zwG3nuECwG
 p2UpPXXPjQrLM1W+GPir7UYhJTiptmg0pzUKEXESRpMRnTA2vNFUM5zLQWGtKac3aq
 c2AUY8nXpcbLd9peJpC0b43jAC0lNdPPgLPmPFC8/rV1iu39cQAzeH156z1RlNyDrq
 sIdzwcazE8buQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 03/13] board: lx2160a: serdes: rename SPLIT_POLL_US to
 SRDS_POLL_US
Date: Thu,  1 Oct 2026 22:47:20 +0200
Message-ID: <20261001204731.1774613-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
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

