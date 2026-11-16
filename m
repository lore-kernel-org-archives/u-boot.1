Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB72606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KTK9rY9q;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cLzeX4GX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67BB981053;
	Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 446S8TTfAeXb; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3246181066
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850560;
	b=ObZrTMjlxz1jSf2UK7QErWCgxentAhClk89R+ljDvrVWwGP8ud5KYuyLY84VOK5XK6gX
	 O67/jhcWFSFZtDFxwB2HBSEewBn7lUc+mmGzxwzxFb9Ejcck3LaOrC6OxQ8MHpCJyitzd
	 pe3Jtd3zpS50wH8OhMdrT0ZbGaJjDHTNGiPQnjsbTPqORye2hW5I15Dto8LoY/iGe5n/G
	 GlI40X+zaJwl/a45BhsSoH1kqQ77I/ortguPAA7KbB3Lq/nzgM3sxDikvq/KuJL1HHj1o
	 KmzyEOarnlutvzmdbzucqSIKwGURnk1SZAqVBPu4mix5gpnSZP7Px2Enlm7cj4+yY0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wLy1wM6rlPa2RJAm8scP6xdjGDYeMhCqBTGpUq0jDyU=;
	b=Hn9y6lIRDGNis3eZE+3PsbHY/0R3vOaU8N3/GnHIY0nK/qFE+hleZ6p1H4k/LlLQgQHd
	 3h1S1PFRufssnyHDXlNOP4rN6x5cZ6bNRwiHhE3g+g/DF958AK/mOlUBsJSzZxh/a+3R8
	 nFB1J1FzC9U1SKOJQor2sx2kWScq/iNQ6seN5G/FsHjtrCpFhVu5/XrWqyM7ikTbn361i
	 KIuGcUcOz4e7xBPvgui5DzgBC63g0MPGUnX/jjVVVWC9OQs/Ns7bRiuVGV4TALbquLgsD
	 7eFd1Z0ut5OexHsw6vGaZfSANVKp668mIARtI1ALfEVLEYHgzw1d8bagaHYMobNll9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850560;
	bh=wLy1wM6rlPa2RJAm8scP6xdjGDYeMhCqBTGpUq0jDyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KTK9rY9qRSAO3xP+6r/2WHlFE8naXpnOCBhVKn3qAfRi7T77+X4jePvTdKc5xp4Df
	 hfoUzuENS2zBUQ0x0jLky7oXvCWO8G6yqwLfVmQy3Ua478PKie7peX7Vu/Ul6ziicA
	 t+ZCXZJnObvLo0G1ZN71lZSckpG+iz0Rxm2BAWaJdqU9pXOuMKz4a4EEL6Xn3ESi4I
	 g/LxKr1Duge4/le/mNzOi3oocATbgOWftXhmZCSpfYtdHz35ZTnMmWVBFXFfar4mqJ
	 DBqywTMhlPEzHrDhj2eJcMNL4NFxbgkzCgCoiXNmwsJc/hSOK1AC9TStGbF+iCUS9Q
	 lKgbTPwtrk+ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3246181066;
	Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5219E1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38838402CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTGhummuLc6q for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7CAF2402D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cLzeX4GX
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CAF2402D0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw4m4HMjzKnl8;
 Mon, 16 Nov 2026 18:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLy1wM6rlPa2RJAm8scP6xdjGDYeMhCqBTGpUq0jDyU=;
 b=cLzeX4GXLMOsLElXcwYuRV9VHSJ+HJ54e9zfIGjmUkkcxfixymniXY//h6fVo//p1UETdO
 aXR8Ejbckz8TBYUWtU1ciDmzjI40j7yCgdRNTWS7/2dqra/b/cUezW4BCLr+JRLf4/yimG
 RqapO3GPeC2Tlt7LnYd6dibT+G7YZ8FDFs807iktuD5HRxGCq1b2Kh/9qzclopsffwUTuU
 0gLqZ5Y9xKb+6/Dahg/i4G3B2CXdXD0+7WxT+zjrKjIp0A8gRCZ2DyD3xJ1IiP4dDgcxM0
 DBwFWtj9VZ9t3cwNJ8mQUX9OY6RhVFPviJCB7qXqWQcBwHbTXhnmEsJMutewxg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/20] clk: bcm6345: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:42 +0100
Message-ID: <20261116173546.3487841-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d9eb9314850c36f605d
X-MBO-RS-META: 7nd5knq9s99ncj9q78jjj879kyw4fq94
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_bcm6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_bcm6345.c b/drivers/clk/clk_bcm6345.c
index 0b41872b719..709754119f2 100644
--- a/drivers/clk/clk_bcm6345.c
+++ b/drivers/clk/clk_bcm6345.c
@@ -42,7 +42,7 @@ static int bcm6345_clk_disable(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops bcm6345_clk_ops = {
+static const struct clk_ops bcm6345_clk_ops = {
 	.disable = bcm6345_clk_disable,
 	.enable = bcm6345_clk_enable,
 };
-- 
2.53.0

