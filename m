Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DB3C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7491885EE;
	Mon, 10 Jun 2024 18:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0651988621; Mon, 10 Jun 2024 18:12:00 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8373885EE
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VycJF4fgMzPll;
 Mon, 10 Jun 2024 18:11:57 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VycJF0ZlZzLqf; Mon, 10 Jun 2024 18:11:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 18:11:44 +0200
Subject: [PATCH] cmd: sound: fix help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-cmd-sound-help-v1-1-0c1e13a49ec4@cherry.de>
X-B4-Tracking: v=1; b=H4sIAL8lZ2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MD3eTcFN3i/NK8FN2M1JwC3eS01DQD85TkZEvTRCWgpoKi1LTMCrC
 B0bG1tQDDbAClYAAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

There's never been a -q or -s argument handled in the command, so let's
remove it. This was highlighted during review[1] but somehow still got
through.

While at it, slightly "reword" in the help text how the len + freq
arguments are defined. Indeed, len and freq work in pair, it is possible
to define none of either, n of both, or n - 1 of freq if there are n
len, in which case the freq that goes with the last len would be the n -
1 (and not the default of 400Hz if neither len nor freq is passed). I
assume this isn't what's expected but leaving it for another patch if
need be to fix what happens in that very odd scenario.

[1] https://lore.kernel.org/u-boot/CAPnjgZ0QWNqVFZfEWHxRcFOA3E3gRAZCYs77nGUXKL0pLp+JLQ@mail.gmail.com/

Fixes: ea58b9a404d4 ("cmd: allow sound command to play multiple sounds")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/sound.c b/cmd/sound.c
index 08bf74112f1..8f67cbd96e1 100644
--- a/cmd/sound.c
+++ b/cmd/sound.c
@@ -98,7 +98,7 @@ U_BOOT_CMD(
 	sound, INT_MAX, 1, do_sound,
 	"sound sub-system",
 	"init - initialise the sound driver\n"
-	"sound play [[[-q|-s] len [freq]] ...] - play sounds\n"
+	"sound play [len [freq [len [freq ...]]]] - play sounds\n"
 	"  len - duration in ms\n"
 	"  freq - frequency in Hz\n"
 );

---
base-commit: 4f836fb324ba500ecabdba4146c3ca9e1600cdf5
change-id: 20240610-cmd-sound-help-cfef07dcc95a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

