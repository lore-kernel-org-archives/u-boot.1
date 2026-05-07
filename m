Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BDBCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6037784C00;
	Fri,  8 May 2026 00:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gPJkokaj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WVBTQp3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6240D84C00; Fri,  8 May 2026 00:07:06 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF37984B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRDj0c5cz9ttL;
 Fri,  8 May 2026 00:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Wo9p9AAvGlPjGDboj2jQO/nbEsm10Deo8nGdeyQqN8=;
 b=gPJkokajqYORfoPkl7OLP1Afy/8iOn9t/NlARy9hIKqOKwjdfcl1n78XcYIHAPVYsu6nOT
 zqlRYw8jquyhj58XiwwPaXs4m+LNTD4BQ0Qv8DNwctrslSa67bIWTeM1fcbsBFwaD/2xh6
 OzrGASNjdRLJOarhXqjxqO/VvJUJ2S1ONMDM1t+EpBELKGt7mNz3iTL3rlhrEaSq00mOEk
 33UUiDIbXd/0tvO/pGLy5ljvbbc/rXedi8a6tMtfmYJffwCH4RSAUCPC3qdtLQJEjnl4sj
 8ZEyW/ZzNduaCG1qLPACoWtFUctL+e7p8pY3aGSsUHxmyX5F4YoNO+rJsoSZdA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WVBTQp3G;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Wo9p9AAvGlPjGDboj2jQO/nbEsm10Deo8nGdeyQqN8=;
 b=WVBTQp3GZbRe8JgTh7YRWlk3ejvfsbn+HHUwCGY7Yyb88vfrqU4NXU6t4fLoK9dqA9lk3o
 EbNSUjy99geMn4YEIjkG4qDzd0HyeA7pex8pChAI1opoZvTugsqJK8HC6Q1+zjvQ8G8Mlc
 hNP+rebeP4PbeFQJY/O+W/1xjN6BnYgbSEN0QcmFbcmIFHmWRLZRxyjdSWqvF7YrGeBet+
 6gLsknDud5Gt05MS+OTy9NsMlIdAba9KmqZm4/maFwcOCUm8q55hRpCM9bMADdJV3QSGON
 SBCLNzQPXYnpYCSVRFnt+ctJzM+zxp43zSgi3p/8UPw59dnbfHn+5vSrTUSukQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>
Subject: [PATCH 4/6] mailbox: renesas: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:31 +0200
Message-ID: <20260507220651.209168-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 95c4a11ac8cd857630e
X-MBO-RS-META: ushb3fzun1m4dkw3k8383u8766tqckah
X-Rspamd-Queue-Id: 4gBRDj0c5cz9ttL
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/renesas-mfis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/renesas-mfis.c b/drivers/mailbox/renesas-mfis.c
index 1e9e8285974..19b801e56a6 100644
--- a/drivers/mailbox/renesas-mfis.c
+++ b/drivers/mailbox/renesas-mfis.c
@@ -29,7 +29,7 @@ static int mfis_send(struct mbox_chan *chan, const void *data)
 	return 0;
 }
 
-struct mbox_ops mfis_mbox_ops = {
+static const struct mbox_ops mfis_mbox_ops = {
 	.send		= mfis_send,
 };
 
-- 
2.53.0

