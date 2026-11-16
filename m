Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pxB2a74o;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=hhOEIf79
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1FBA8104D;
	Mon, 16 Nov 2026 17:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCGsBTa0WMxO; Mon, 16 Nov 2026 17:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A162C810B0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850571;
	b=SifJdpDO6bQnMc+HgJd9i1bPVFKuiFeJUFcEpw1Q3LUZN/rqnp60MSAef1/NlYAGmycb
	 QNL+F8i1g2I9UWUVjxyfOy2jNhB7loNiemduXu6xvw0sv02PqcijfzwZpY7+mHYPUJXUr
	 TgAe/u25yfFWDK2bq/oHkCzev6c6XGpSK6omK+oMmn5I8l1uKaDVlOj+kO/boT5Blx0vE
	 cQ9uYBEUSRuLuB9IjH1g8HoNz/oTnF3R6UlJhsCF5xRETOOu1SIqVxchgaguzWNopR0CM
	 SNoCrnHRl16BjVQbn1Dav+0QTyAMdJCaCHix74TRvHtZqZ565qQwOpOqSVxQBIreNPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ae/iwUeG1EBvqhrgvKBiE8RGl1waxvkSSq/PncXMTn0=;
	b=U0ctakf8eK/XvK5SBgGsZgVxq/PVUDVWfXeQxaxfY7o1vdKpZrVNBKmDlx1+N5wrH4FE
	 MCqBMCykHu+zD604V4TjppTXXPERfx44p5RgvFjpIDPf54gVYp0orc5ywdOvfUh4Cp6kJ
	 qy/+6njKfiIs/TEN9PwtljM87IkddERBFzyjv0yze900KU++j/unSBsT/V2tKOD4TYSon
	 6XZYM72X+xHo3gKv8aRcgcx3p7zMrtALrqqgdMC+LB4EhUYkclFV7p9X7BL7IE+D22R/B
	 llS1N9ZJYq9EZZwrP67/gLN9WPqvod78NbiefOnm3Sd2FkylRJlm/7y0g1pGSsB7fvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850571;
	bh=Ae/iwUeG1EBvqhrgvKBiE8RGl1waxvkSSq/PncXMTn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxB2a74otyWzysUIsSoSYSP4ogEQzXucZNuS16vanpFYuv0SHqrdND2l2x8c20oVI
	 NUgAhUVC7ExlxqJQO+W6uB/O13dqxoEHf0BwHChDr210tnqVSLfxiB2mlNC9pT2YFo
	 N/ld9bKtZVfhtADLCofDHmBIrmw3Zp53nJpEHFgVpgSqLhCZL+rOcf7UB26ZqhgGJZ
	 KQVEhZgq87VHqvk405yJokjmaq5nSC8b+zRGjGK5I8fRRdZNVSpzDpaO6VoM36DP0T
	 1lD2X3Fi3LFtILL21bjURJVGLGT9Z7wS3PONZQr5ihnSZ0T8f4jdYuseAfAvNV0DpH
	 BLE6tY3ZwU4gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A162C810B0;
	Mon, 16 Nov 2026 17:36:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F60C2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84F6E40588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2M0bWqU6wL7 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD4B44075D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=hhOEIf79
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD4B44075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSw4r1jf8z8sXD;
 Mon, 16 Nov 2026 18:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae/iwUeG1EBvqhrgvKBiE8RGl1waxvkSSq/PncXMTn0=;
 b=hhOEIf79/+XUcfbNxtNtRwZLZZRASotWeOwchkv2fpTrYwAot2zKUa+HWj2JGbf2AAi7t+
 gsqZV/k+h7ecC/G+ODJRTSMgF77HVfRPL+wILz0m2SbyPNPjrFMbSLikHPzvb6XqXGT7qZ
 iE9HbBaJRHu030AV9ah/xpzKOnUP1VDhBEvrL/tP0eKFkxZr5Y9+Yjm9p3yWlwgA11eJ6A
 VvNLq616FoI7rkcpnwzyIFhNGlfBYm2nPTUFUA/Q70wBPGRpbLvwhfc1RPnL5ftgE7X4Ty
 msg3TMIfC/sSZMAnOoRJ5aAlc9Kqkzgb/jEa7joMMQo8dUxbc+9wCsfAIpsRnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/20] clk: pic32: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:48 +0100
Message-ID: <20261116173546.3487841-9-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g7kdamk8ejeuf9iun6x1zsqn8jr6urgf
X-MBO-RS-ID: 017df9bfb159fa3799a
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
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_pic32.c b/drivers/clk/clk_pic32.c
index 885aa834516..88d79fdea26 100644
--- a/drivers/clk/clk_pic32.c
+++ b/drivers/clk/clk_pic32.c
@@ -418,7 +418,7 @@ static void pic32_dump(struct udevice *dev)
 }
 #endif
 
-static struct clk_ops pic32_pic32_clk_ops = {
+static const struct clk_ops pic32_pic32_clk_ops = {
 	.set_rate = pic32_set_rate,
 	.get_rate = pic32_get_rate,
 #if IS_ENABLED(CONFIG_CMD_CLK)
-- 
2.53.0

