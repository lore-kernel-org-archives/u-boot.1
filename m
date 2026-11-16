Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DB606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ogazQrIe;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=OsRl6z3s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6D2C407EC;
	Mon, 16 Nov 2026 17:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ko9sNTwyisjb; Mon, 16 Nov 2026 17:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 075B240800
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850597;
	b=L8XvWSrYtG3oYo/UrnJozGK4i/ZWKL9c4asGs+I6aCz2rV3sJqsF35jsvvq8T4VkX//B
	 N+dAIMa9szF7xImA3mxhQwTt067QfYWRfMp+vqxqB315E1TyvcdQkk0vRNOUlpZKz3vaw
	 /UJ1kWgKL1vp1Qp5G883fbARUdIqpTjaRrYpaS/Lzk9o6BTfbcLErJLdeoCIemoen3GEM
	 /C4Nxl2Vy61kj4y5yXC57ZlrL35/rZIIF1oWMwfupjlCuPPZYIO5hR1cNdKOWymcDWpRs
	 6bR+3Y/3MhNfVuoWDa3RebUB3P8WzBru1OQPULzvx/LJ2BBRrzJue+tEPg27FvQXjWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6q76wn0u8Zrt6B7No9xmX/5xgkTUYU7BYJrmQWgVkvE=;
	b=M/gPx247Hc4ABgC++6uXGpTl9WvonFMBUC0Cw+BRKNeVbZAn9PwWg67QCEsqfb7jvYDj
	 ywMqQxXts734undQt63dv5HkBdMGBwM0cU/5evgyj9CZQJ3wrI2+BhrDlakv+qHEwz8FL
	 yQsWAbNrChxU587sTuqz8gIm8JGFZ0geNOlP/tH6Fok2S0bnRzdXT0mNaODf2mv2aVaeL
	 VnwPGd5qHwXR1P/Zrrw9M5N5iX+v9txn8E+34XEPm+pT3HMTkTfSHK4gBuBC95TgM7E94
	 t8ouMLLL5d24U3bAW8l3t28dCQHukxxM+JLoFX1CIOw8uYfu+PmqjTEnVRWPSbB1Sbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850597;
	bh=6q76wn0u8Zrt6B7No9xmX/5xgkTUYU7BYJrmQWgVkvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogazQrIeHeXzqYgSKceGfRhm09LeCQye714DFgXa6Y3pgVffOspJ6wMEMwJWFh3aT
	 P663KOhwOOplirblrmbPhCVkeiQAQ2DK6FtU1l4veH/aMumU10TKmom4K4/Fo7lE2H
	 oc92K0VU/H6jhzjGdOE79vy+j94d5UvABG5emdhH6pJskKsjuIqXRY/6E2RHas/tMJ
	 OwQA4LPlyHZX1DFtkEJCWplZ9FfOtAKWfRPcuKeUG/FWTEn7IOtL4h2AfagrH8MBD1
	 iKeTxaj6D4KjFURf0N7DSFgrLuaNAJI613K+OXuGVSp/ADiHo/5jv6HmT395VCgo05
	 eSyVpero+56sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075B240800;
	Mon, 16 Nov 2026 17:36:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1447F2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEB3260685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LgkNgUMXYPDZ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 469D3607E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=OsRl6z3s
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 469D3607E4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw4z37DtzMlvB;
 Mon, 16 Nov 2026 18:36:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6q76wn0u8Zrt6B7No9xmX/5xgkTUYU7BYJrmQWgVkvE=;
 b=OsRl6z3spLyXz4abrmHVubs5ZPerUn469CnCr3j9jixwYyfasA8N2b7dJoIq+/zQbGSCvc
 zbOzRUlTpf9MAD6E4ue1mBGBU+DdCzFaDenVe/hNT/dpnD49D05yyRLyv2hRpDkzlnTjJB
 3URZMGtRFEwh4OxjkQYt2TFk5HLcf0e/H2CWsFgq1Tz/yLuV+IEmtcAbPhieWl6IigV50V
 +i8mriqMU08639+hil2ZA0sPcBPmKgnVCAFmdvYgKHRIgDiGXUfSMM9XDzm5hWEr8N+usK
 B9YhLum3dUxSmj9XuRfsYhHbrDyrromnw6/2QEFG5h+as9+J7JRpm997tQ91GQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/20] clk: zynq: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:59 +0100
Message-ID: <20261116173546.3487841-20-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3e1fe367fd6fe4d8416
X-MBO-RS-META: twe3n36a9cno3wfmtp9q49h1f8odwy6z
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
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index a8505f62bba..7dfe2c0cd7c 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -500,7 +500,7 @@ static void zynq_clk_dump(struct udevice *dev)
 }
 #endif
 
-static struct clk_ops zynq_clk_ops = {
+static const struct clk_ops zynq_clk_ops = {
 	.get_rate = zynq_clk_get_rate,
 #ifndef CONFIG_XPL_BUILD
 	.set_rate = zynq_clk_set_rate,
-- 
2.53.0

