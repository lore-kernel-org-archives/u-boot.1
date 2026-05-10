Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113BCD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6623D847B0;
	Sun, 10 May 2026 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vQBDK3cH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I7/WMR9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2028482E; Sun, 10 May 2026 19:17:42 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5279E84715
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gR6QbRz9tqk;
 Sun, 10 May 2026 19:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjmgDnuYAPkIQ01lrA44FeBMf7KmoPoscpv0QcFtOqo=;
 b=vQBDK3cHzdaOQbr4/XoVe3gLLEi4/RAvEDIyI3vPW7AJvIeekNYQt2mk+8YtGCYjHOue94
 fHldUeON2JKevUxgwbZDIqIuXwGKi1bGbjKjjV3otIzJdWSOf+Vyt24T6QwAxvgR3E7dnT
 Xn6LdRNTJpYmA2uEoY4JCr661/2xkHpGPxaq1JAc+Tr/71t6myW/3BqR7DbhpZb/b7F+gL
 K4sw7zkPi8jSWPxdKzSYCtALetZ7ze7MYNei7Bl/ZZWOxx0BStWdme6uWgSQIS9suOY7YD
 7PNYKofA4jU7BS5NPsVPwWgICwauv8dt2Qm2RA4TOuUdAW1jXeTqA1IoE9T+xQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="I7/WMR9a";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjmgDnuYAPkIQ01lrA44FeBMf7KmoPoscpv0QcFtOqo=;
 b=I7/WMR9aDw1Xp/0jQh/3hleMWHsSFTn2jO/2rusGGXp1rl+w4sZ0pBri3zL67y3FHjFYbb
 XWnDdcSYC5GrN2SUDK8rENGFAw+EnA9tB0gTGw64k91+iSNAwwhx2eeydGfQFf/84cytST
 Cmv5X2zbZSGUqYwqN9tO+DvA8OFr5PehLevkJ5vAJE2t/5foR34bu4dISEFcZCQN/mKN7h
 ABnRMeTE17Z/v5IXpPDOKtmvYQpSzQuWME4uD9GsOMBfegMSGdpYONeHGtH/7JFSGW6ksG
 pWdp+j9IP8XgHpE8aDrArqR4uXnWoaenAM/Rd/MTxh4YV/ZmdhyQotYVEI9MHA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] video: console: truetype: Staticize and constify driver
 ops
Date: Sun, 10 May 2026 19:17:01 +0200
Message-ID: <20260510171723.56866-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o685844bisferpa7oyf31xwzdxjcxto8
X-MBO-RS-ID: 87cc170b97ac9f7d6de
X-Rspamd-Queue-Id: 4gD8gR6QbRz9tqk
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
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/console_truetype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index eaf169e8386..b9b6f394fbc 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -1069,7 +1069,7 @@ static int console_truetype_probe(struct udevice *dev)
 	return 0;
 }
 
-struct vidconsole_ops console_truetype_ops = {
+static const struct vidconsole_ops console_truetype_ops = {
 	.putc_xy	= console_truetype_putc_xy,
 	.move_rows	= console_truetype_move_rows,
 	.set_row	= console_truetype_set_row,
-- 
2.53.0

