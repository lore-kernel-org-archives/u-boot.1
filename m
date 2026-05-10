Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809A2CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCB9847C4;
	Sun, 10 May 2026 19:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fLWdiiYj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CMMl22Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC30484715; Sun, 10 May 2026 19:17:39 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E8E8470B
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gP6JbSz9srf;
 Sun, 10 May 2026 19:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qh8P9iusoTshA0zVUEfXcNoWtViUBuSO70zABfSyP8c=;
 b=fLWdiiYjdNCFI9kIJUvBSZ5YyfRZMJ4jx1qyt7BTu7mscJ48cWd9abyjREbtoMrZWL/jK8
 l7KJvgx13P9+3XBIdLHSu8cEvwM9Nl3xXpxHkG8mUsHydcA0g54mK2x4QBDW3CVXdwhBcL
 HFR5KabX8Ap6htSOE6RdP9BIPXLuMDNpQjCU81LjTuVNlcXhawow/o34Q/+YUztG8MUBGw
 oLlyWl3ZM0RmC40NBKeR2B+apwpeyFYtxxAhhhUtJvXO3lQ5MSB5INhJo3qpTMg4EpOPS0
 XGw5D+E6CkRF2H/T5yjOlE3lteAZ6ne5x8w8cnaJX3OqDlH6QckAnmk+Tft7Tg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qh8P9iusoTshA0zVUEfXcNoWtViUBuSO70zABfSyP8c=;
 b=CMMl22BgM1m7hfAp1LD63YcK0yJ40zkv70c94tIlAIZ+0Jnb5qwV3LWp7xjU6AsKLtr4LS
 O84GQSFeNXPiDhRMSEjnkC+nytb/dQ0ySQOttkqjfds2/iU+9MQr42gwhcwnE5ZGgwKA8E
 iGyco93VhgNMYBzJYHtNTx0HixL0g+RvyB1TYr0M85A0e5J3yNTooeHrYhCaFhrGj3RNTq
 ZdIs/wFova1xOxmc/zHySZKzL+tmH7vEToxA9VJjBtptBXEfS0CKfbtYySaZwjW++GyBta
 XDEWTtY32FewOEioZkLOh5gSNAbEPMwlPSr4BG3oXEx6BKejpqOa/iLCmTvyyg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] video: console: rotate: Staticize and constify driver
 ops
Date: Sun, 10 May 2026 19:17:00 +0200
Message-ID: <20260510171723.56866-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9bh7fq5r4pdzcuuh33kiqohqgxfnx1ce
X-MBO-RS-ID: ceed1d68e35ac45a143
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/console_rotate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index 886b25dcfaf..e478e0ef3bc 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -284,7 +284,7 @@ static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, int cp)
 	return VID_TO_POS(fontdata->width);
 }
 
-struct vidconsole_ops console_ops_1 = {
+static const struct vidconsole_ops console_ops_1 = {
 	.putc_xy	= console_putc_xy_1,
 	.move_rows	= console_move_rows_1,
 	.set_row	= console_set_row_1,
@@ -293,7 +293,7 @@ struct vidconsole_ops console_ops_1 = {
 	.select_font	= console_simple_select_font,
 };
 
-struct vidconsole_ops console_ops_2 = {
+static const struct vidconsole_ops console_ops_2 = {
 	.putc_xy	= console_putc_xy_2,
 	.move_rows	= console_move_rows_2,
 	.set_row	= console_set_row_2,
@@ -302,7 +302,7 @@ struct vidconsole_ops console_ops_2 = {
 	.select_font	= console_simple_select_font,
 };
 
-struct vidconsole_ops console_ops_3 = {
+static const struct vidconsole_ops console_ops_3 = {
 	.putc_xy	= console_putc_xy_3,
 	.move_rows	= console_move_rows_3,
 	.set_row	= console_set_row_3,
-- 
2.53.0

