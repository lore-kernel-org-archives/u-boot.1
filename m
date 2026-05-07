Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6708CD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386B384BC7;
	Fri,  8 May 2026 00:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JOTmGY7G";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kEFUUm2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BE484BE5; Fri,  8 May 2026 00:06:57 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B9384B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBRDb3yjfz9spS;
 Fri,  8 May 2026 00:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=szS9D7dp3Y+9QNhgKcmvsrkdFlNKLYH/I8EapsAuzck=;
 b=JOTmGY7GoXjT11Onn2Rb2yrbanf75R7C1Uny5E7QbXihugXXRUZn7pROjx4gddCW4UumqY
 LrOfVM5d/Hsh6SRv48y9wnyhkG602VcVf5TZGwbaz9GutspPGjy5kESycwF8f66A0UmEiN
 WDiPexSzPYSYxQIKagPWgJ9zlHZolENU68j7aczYSAATWdbtLyS/6VR+CO1QCZc6x3Z0X7
 Lg0BUV8JyBHrO+B1/BmnaYSiFcw9ipKyLYxZxUsPQ7GD6ZWV6l1rI1DhhV7ldMj71yOZ4d
 eOTTx8m0Z6Pr3k726qZjuF04fglpJ7dKAPfF9r0PaokxCN3TuxtanfIoyfPmDQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kEFUUm2R;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=szS9D7dp3Y+9QNhgKcmvsrkdFlNKLYH/I8EapsAuzck=;
 b=kEFUUm2RdtUIb+L+6Hl7uV/ZutUpeG0lDioqruZh6ZVDV2TVLR1S4b7YC8XvNYSP/9qaiv
 qrWlLolw/Jyc+9GSexcjHHQlqpx/7ci1LfQpU5DUXt9txftvz49jAXaoA0U6FihnF8ISYu
 iLPNDDWwTQOSXI2x+bRSpeylkyFMvTa/fUJJY20vwUBbUpGUoB9ftpNH9mzWJVPEoaelj7
 hHdZimR0EF++/qyU4fBIzo92eDatJPmkwEWYq8y3xuyrpVBkyyYE/hhLNNTj4uyQ6u+yNg
 FcdP0tx6D2wcFaA7N+kgVhnqH0k2snbOJA+pinxNHWTlHgkCHsm1nQvb4oFoDg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] mailbox: apple: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:28 +0200
Message-ID: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ugmjdmj76siyo5juzaqkzqbxkr1dnmg8
X-MBO-RS-ID: c39b010c037d1c0fd6b
X-Rspamd-Queue-Id: 4gBRDb3yjfz9spS
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/apple-mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/apple-mbox.c b/drivers/mailbox/apple-mbox.c
index 2ee49734f40..39a7edc0285 100644
--- a/drivers/mailbox/apple-mbox.c
+++ b/drivers/mailbox/apple-mbox.c
@@ -59,7 +59,7 @@ static int apple_mbox_recv(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
-struct mbox_ops apple_mbox_ops = {
+static const struct mbox_ops apple_mbox_ops = {
 	.of_xlate = apple_mbox_of_xlate,
 	.send = apple_mbox_send,
 	.recv = apple_mbox_recv,
-- 
2.53.0

