Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F668606A339
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=02KJykH4;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=baaSRKVQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B8DB40829;
	Mon, 16 Nov 2026 17:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTbKWdl1UFXm; Mon, 16 Nov 2026 17:42:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B83334083B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850969;
	b=YdlzDD/tJeg82vqtnaKQ6ufW6SVEEVYYlybJ9pjjjXO1tqRvqw64WKRMKu37+yB6Kaap
	 2Xwh1ZfWEa7ZBOQSuZwCxqCI77LLon1b5+gdk6xTy2MgByRZ1hwgHLyzOvl5uv7XppKjZ
	 JKTX6AJIoKFO9aMBUEEVpgabyRKOng09RDcJvWMJjHr4goTn50qBpmU+p8Otlx/E3KVrU
	 CVetMGsAgLvO41LPM8vovy14ASDiHZXUszi0FtjmVjx7vk/nwpNPCqKAhcYrki1SIbt1l
	 Pwm6m+U69nWteMsiLEbtUIlM9OEBOGoVq6N4E4DeJfwrEBBcnpImuKr9nIOXe8UqH5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jp6mI1Zle//Jvb+u61CfTvpqSH5+KlaBQEX5pMvd7xs=;
	b=CdRa1P1iUJxn6ox1FW2unEF4a4xD/4WbwIgaUuYuZu8FNEZFfPcrY0Me/aCbZmj4VIh9
	 ZW5F9qvwbtSaZd+p4ki/7I31L8Rmeyj1vOoEp3d+VDOA1yk4xIQunfune8Xv17kO8ps46
	 uTBLb45FY5YJ3UAF4Jk2eQiXLCQ0srrnRGbkg5gfUK/CcZ+NAiXGO4uScwPdqWAoT+gSa
	 Pn0SwCi7zdxJRQoY73el0DpEa0Ik09HnX3BTB7QW8O8HoDFrtPzGi+OJpr56M8NFPOgeh
	 ciIrB2JFeYu4hzPumiURes0CKLpIv/lDZ114HAlvBu9fJ+QHC+w3FCikF1UNd+79sCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850969;
	bh=jp6mI1Zle//Jvb+u61CfTvpqSH5+KlaBQEX5pMvd7xs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=02KJykH4efK4mNOr+eqGfPPpTW3okL0fTXI5hunPapKi47oL5lkIbp4dcjCoUL2hY
	 P3kvzd0BoW4FfLJ5axnJ8O4xgIDTKaxc1fm/7zO+hbJilEMRrUO6Eo8OaaY7xcYugg
	 pLkI411KOPIs7PMwWL3Z9YyiqdgGwGVn31DjT8nywb055KS2dQZyHEIxV6/R+Wx/jx
	 uyb1hEE2WBSOXxVeo+FQqSqikwA22DeT4rItddieqbhJ91JMEzilruN9F/SWEeLhum
	 f4srYQFImvJd5i/g6pRyjaiArJofjkrPjom6PV573grP5a8k38uLww56yjItnwBA0S
	 lm3CFgUNB5vqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B83334083B;
	Mon, 16 Nov 2026 17:42:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 289D6169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EFF340282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBd2LPeSHL4B for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A3A94009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=baaSRKVQ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A3A94009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:46 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSwDg50t8zMlvd;
 Mon, 16 Nov 2026 18:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jp6mI1Zle//Jvb+u61CfTvpqSH5+KlaBQEX5pMvd7xs=;
 b=baaSRKVQbSjkoJJUutafgwz5UTQOH5tfUQZJji+RdIjTlvmH34FWkK3nF3LWvdSGjaS3ZZ
 s1bPiqxfk5pwM/cUlW3xtNy6IFNiFxN5vMWBC9eOATmZNO8emID5GayngnuVYlB3F4Bw2J
 B85z0f2izhnKcg/mAydujaw1oomCMG5uaJ0qy75dqYaieUDGOd4ydO7ouynmwEbjn4kQjf
 vWkBuGYRO/eTR1WFHfaZDpU6ITV7c74/0rZQlV2BM1BKbeD4Dc0v4rfyhINF5971gL7cZB
 pMDmVfTc/Wfz2nYfwUIbdcci7PZxPavsMbduONlfP4U6EiS3ZPoj97/aFMQboA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] reset: ti: Constify driver ops
Date: Mon, 16 Nov 2026 18:42:39 +0100
Message-ID: <20261116174242.3488252-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e1be0d50e8798ef136e
X-MBO-RS-META: zmaayq447qr3ghy98nqaxsmshr76aabm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/reset/reset-ti-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index e69bcd41cbe..d39f69b9133 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -178,7 +178,7 @@ static const struct udevice_id ti_sci_reset_of_match[] = {
 	{ /* sentinel */ },
 };
 
-static struct reset_ops ti_sci_reset_ops = {
+static const struct reset_ops ti_sci_reset_ops = {
 	.of_xlate = ti_sci_reset_of_xlate,
 	.rst_assert = ti_sci_reset_assert,
 	.rst_deassert = ti_sci_reset_deassert,
-- 
2.53.0

