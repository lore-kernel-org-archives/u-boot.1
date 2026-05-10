Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315ACCD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AEF84711;
	Sun, 10 May 2026 19:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iFo+vu5K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HDrAq+7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585B284712; Sun, 10 May 2026 19:17:38 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE48846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gD8gN1YDJz9vCB;
 Sun, 10 May 2026 19:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1+LBFO3fRtqD11CMjxLfK9RyS2PfuqNyvWau2qxC2w=;
 b=iFo+vu5KDJu0WvZ5myVJak0JX9VE/WCd5tTP7C5pOTeywt/v1+AoqGVLxSIjYoNjJBqPwP
 he+QKqnOgR7NtCmY8cYdpy+JV4rMhA1PcL+O59ojHo3EXqpSrBP7nh+Vem6MD+xu0RxjvY
 qp1D2tBbLkH5io2Ta+XiNTNfaqQPAnkMNbRMXNWqEMNgYfR/Vg+P4OXinAvbPOQ77knWDo
 HWKvjXmVdg4X9fBvAUlI3q17SMbwFTg2WRzsH9T4of0p3ZEADPiVr41J3b9XZ//YLmZD1J
 ygoWRIt7oSWkjenLYgcDhoUdM7m4wjBAt87cd3NnppWascE2ewDRsUehcEjCkw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HDrAq+7I;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1+LBFO3fRtqD11CMjxLfK9RyS2PfuqNyvWau2qxC2w=;
 b=HDrAq+7Ix/LdSa0ZMGQ1BHlE9EimMbTPsZWoFtcKx00yuxBWS4vywUbOaAy5izZAKS8U+T
 3wMrvsGgwyXRiM6Jt6rTk8gulij6MFTetHsyGIfmT8w2jG9GwAbpEh2b/NHfb++92nW3A6
 pCkJm7IAREN2S6daYt8BUjddn80GhFWKq8IDlJ1fg6BCpkv6rOCLH4dKhk6LSVnq1IaTYP
 TdP5Q+hf7gf0Twdzb/VmUxmYlV+81JomywIjN8uSlLLZM6HXc94Krw5KBfOB8/FbUIRXNg
 YiMNqjfVH7B+u6UCuFSzlJSdD55jPG7UjxePTLvcXJzC70zstnqPFav9E03vow==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] video: console: normal: Staticize and constify driver
 ops
Date: Sun, 10 May 2026 19:16:59 +0200
Message-ID: <20260510171723.56866-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 15gq7zxsfj1kjc9kbtt3iwa63n8dauen
X-MBO-RS-ID: c51ca59b514c295771a
X-Rspamd-Queue-Id: 4gD8gN1YDJz9vCB
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
 drivers/video/console_normal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 07db613ac53..6dc0a6eaf9d 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -133,7 +133,7 @@ static int console_set_cursor_visible(struct udevice *dev, bool visible,
 	return 0;
 }
 
-struct vidconsole_ops console_ops = {
+static const struct vidconsole_ops console_ops = {
 	.putc_xy	= console_putc_xy,
 	.move_rows	= console_move_rows,
 	.set_row	= console_set_row,
-- 
2.53.0

