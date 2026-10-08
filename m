Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A875CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD3CE608B1;
	Thu,  8 Oct 2026 22:46:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVEZhfDcHmX4; Thu,  8 Oct 2026 22:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0D2C60872
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499564;
	b=rTn7z/B9PdOkkcOymUqCYIzXDtkmHjnnW0aMbEwVaU4aUEinR/L8cZ5dh0xTKT3Bku9/
	 UkJytDd4M2YGzRtE+lHhZs8MbhFWuilPbPDZpfh4dHwWcZudgVyzD/mhl4RwudEwNZsAB
	 2yZ8OkB9VEm1zgtc2EQsPNcPN/4u0pT8i10R9jp8i6n2fzqjYaANpPcXFGE4DYNBg/hTc
	 5fYVTUV3SaQnKNz/e9EakiuKMtNK8R1r58KaOEEDA7n8l4qi9nuWSqlUCGd4xiFGBsBls
	 cwrifcamGMxVUnnmc6EPWP0TflKtWY0/PX8n7cXgEY+fO06yyl07yGhVAgjRHJExTgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VVE5MubX1Q2fbeAHIAp1b8hBAYtFcQpUbezwwwGooUw=;
	b=p4lX55UyMB5xmOX0v/9fjO93ljvxKRNsR7e079TuVRIStYAzLmOlkUSvyip44cUBSR48
	 50BeLXghIqbvD48tw7VGV1r+TxNN/Z48aqc/gtuwsLBFNFAimqoAJPQMUO1Pcv6UJdwbi
	 4yceKHqYtoLtMCY8PPObLAKa1XVBlQO/B/PxSt7QjFwQAVXypIYbsrHacsn7ZanVCQfn6
	 hmk5mWbhA9k9DEyrTGW93HrabdFdqC8PwLHzcdi0auYLUTBqlCEvbokkl/zZet0LLTcK3
	 pdVJYMMpP4NtcDj4oUzd6KtDrkAr5qlVLq3K88UxYR5ibqDhjjAi+6leE18dbd6U0Tg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499564;
	bh=VVE5MubX1Q2fbeAHIAp1b8hBAYtFcQpUbezwwwGooUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EP5ZWhQQnVEdTiQZpgm58W9CWFpzdGIsmmiOEmiyJgt66UGNkY12gYfNJcR4q1IVC
	 7Ki8k/78fCtPUKLdgHD/XZwgq5IKe0WsdnfrXoe2il+UYUUukh+wT+wqtR+WQV1Unw
	 rUYX2AfR5bQbwn+cKUeDOPT7vkBgWIaB5Sr7Osd5jCaNUiU0CDl5zMSsOiLI7gmqj0
	 oxXgi3gItl1Ou4GC0oElWABihSmBbpCZmF4mpluLldfuLW+bLPTOVPB+0mdufzSe+C
	 8MkEIpryiQmRikYlyr6RE8xVATXqkMQc3LufmsESR6SqHIMvRUmDh6VlC18NKj3LM3
	 uW4PENzmAvOdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0D2C60872;
	Thu,  8 Oct 2026 22:46:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E70934E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C195813FC
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOPRIakaz9Ku for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:46:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 450A8813D0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499562;
 b=hgaHP4vIKnIlU8R/AV+cGMPmHaMxPcUNaJ5Yp4WBH+KjysbkZTvqTJ93HK+YnbTQB/RF
 oiP1rmCkS8QXd7LQedpKyvE14uIPEvKnDC8XFMnMHgFpGJkNkso+Sbv8+/OzDycgXe1MY
 9iq4s/WEAPVC3gnN+knOqWCdB4npELcrS7IrFWd4t6UEIUVDGsMyCxCtTLGJm47rfjWP5
 2nbQrxiFMbSoEE0d7aLcKXrrWA5fNVyd+JJkOzMJvUjkd8fPnGGL4ftTozQD33PR9neCH
 v8UZiMfvVcyGWIRY/RMhfvEWs6NVjttDwzkJ0dEpu/r0MQTaqZBPUuX7cV4CztRm6zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499562;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VVE5MubX1Q2fbeAHIAp1b8hBAYtFcQpUbezwwwGooUw=;
 b=hYUwJWUVemZMEqvT1GH/TDuvEngBavuxKKR/eimv7j4FJh6j1n2Paw+OY8ayfOP06t2r
 LBqLDetbNDQA0zKu00ClNqKJBIW4u2WBy6EH0JRyjWWPS2URdmjjBsCdFIyKGfNzGubkc
 3kdyS4itGggFVjJ8RgM5qDP+tidZMXXqWkd8dpbbcGBice2VKH6ylHPW/Jizz1K1EqtTn
 w9N3HmjaexToWHwRLBjnP4qkHVh2dFw2ziQJmT3Sg77FYoDiVMf3QVKVLipZDAlr/Dtwv
 MwW2If8ufNUBEkTT5qtsCfUcFM9wdO+LgygOBlqgyeN9vxxgf90yympAdKCWA7A7uiQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=RusIn5I5; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=RusIn5I5
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 450A8813D0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 3DB5CB00539;
 Fri,  9 Oct 2026 00:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499560;
 bh=qgYGbctZF2RG5ewns3n9zynpSfyMj+WYrYLNR2Rxy/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RusIn5I5s+XNRI646xZJ4EUhyDlLv6BBFjnMjmklRxVqhjwOp6t0Zk6EMKSF1zO7D
 RHh6e31DclKe5REe12mNzIxg4qcy4CGOc3W5JMMrTs57suy7GBjPdLsj2qsmPXTUmR
 g4rKneTe1rrlpWYRLRfBC6lE82ZijcBqFb2CA3b//gvhV7TjMX079Dpoj1wUQzCuIJ
 XXqrI/xH4GD94k1u1HGeoBcTYNu2J7vkcdtWrF0Cl/weU9XFVTuhFCidDm+RL3+iai
 sQuwuDP3byZpfU6Q6a9DaUptm+alXg+geviZrWl3lv14t04xlzI4A/Uhut2N4tOMVu
 Ux2EwBcjUkHQQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 09/13] board: lx2160a: serdes: enter a SD1 mode through the
 mode it starts from
Date: Fri,  9 Oct 2026 00:42:22 +0200
Message-ID: <20261008224228.512353-10-vjardin@free.fr>
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

So far a mode is entered only when SD1 already is in the mode it
starts from.

The next mode, 40g4x10g, splits the second 40GE port into 4x XFI:
it starts from 2x40g.

Protocol 20 boots in 2x40g, but protocol 13 boots in 2x100g, which has
to be made 2x40g first.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- New patch, split out of "set SD1 with a table"

 board/nxp/lx2160a/serdes_split.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 0107e8636a6..41208ca79ab 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -614,7 +614,8 @@ static void sd1_print_pcc(unsigned long base)
 	       in_le32((void __iomem *)SRDS_PCCE(base)));
 }
 
-static int sd1_enter(const struct sd1_mode *mode)
+static int sd1_enter(const struct sd1_mode *mode,
+		     const struct sd1_mode *target, int depth)
 {
 	unsigned long base = srds_base(FSL_SRDS_1);
 	const struct sd1_mode *from = NULL;
@@ -623,17 +624,23 @@ static int sd1_enter(const struct sd1_mode *mode)
 	if (mode->is_active(base))
 		return 0;
 
-	if (mode->from)
-		from = sd1_mode_find(mode->from, strlen(mode->from));
-
-	if (!mode->enter || !from || !from->is_active(base)) {
+	if (!mode->enter) {
 		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
-		       mode->name, from ? from->desc : mode->desc);
+		       target->name, mode->desc);
 		sd1_print_pcc(base);
 		printf("), refusing\n");
 		return -EINVAL;
 	}
 
+	if (mode->from)
+		from = sd1_mode_find(mode->from, strlen(mode->from));
+	if (!from || depth >= ARRAY_SIZE(sd1_modes))
+		return -EINVAL;
+
+	ret = sd1_enter(from, target, depth + 1);
+	if (ret)
+		return ret;
+
 	ret = mode->enter(base);
 	if (!mode->is_active(base)) {
 		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
@@ -679,7 +686,7 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 	}
 
-	sd1_enter(mode);
+	sd1_enter(mode, mode, 0);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
-- 
2.43.0

