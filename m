Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2480DCA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC4DE40953;
	Sat, 10 Oct 2026 22:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QW5OxMV2IvrK; Sat, 10 Oct 2026 22:32:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1484940949
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671541;
	b=rq4oqjXkMw4/scaYZrVa6y6PsTePlJnJTHlxGdHQbL7/uK76iEkS5EkIroP1/KwjbhMT
	 RBgbUr7fvDA0l7u2YCzRLeRWCYLg7karIBQGIMLeeHCV1GZPmGMoSnQHGKkJdx0wOwPWA
	 NHB83EM7JN4kHOsFtm7Cf7Myy+f+6NZwJ+x6yXV3WOWDjHnUy2UVeBt6p6retHlV/2N2A
	 yaZCVqzHUtuetZtWzK4ZW0zpcMeCz2gvBIJczV4KmUGCZUrwlFrjYNfzwiWx4USQ7aMLf
	 dZQy7dyiS4lxQplelUNPSrI4DyIKvG5Jx3fHV0tQiEQJkDCJwyguDOebwWOkwd+8SNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=NIWPqiTcXB3s2dI2nil9n9e+0Frgy6ijk+3D+YzJF3M=;
	b=gMAn1GMqpR/bMP/uw5fe7lDTAXy8MSY+Mj9yErkKd9bklOCLILg0FpRRla/tzajvLnJM
	 rOrKm0riOFHtLyio78SVK99BOSKvNFDmUmNul2s6iXAwJm7AH6alJrj+vOxXJFZ3NrhWC
	 ErD4wYYjv/Guc/pyAKvjFORd6hTHHiWxH/CCvOV9hqVeM+oFrvn5EcOTW8+oHeGku+5JN
	 fwIUXu1ezGtwHD+f78y4ECr75QS4VU5gpti/tZLH0tAldwMPknTDusQQEiolNj39bf8PB
	 t9c9WrzmO/SYm1a4zqA5SxM98lZD1pN8qqGUS0SVFtLH04S3uTAgeLYlX++bTXv46vw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671541;
	bh=NIWPqiTcXB3s2dI2nil9n9e+0Frgy6ijk+3D+YzJF3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=PFFO+Z0jBVauH20RaCZgVQfZFnfouTGRbvHzfnMpX3qhCHvH6pqhdvwVaBSS6GDk8
	 /lhWGEu2b6IRCPZWOyA+PfJwje8bXg15UcWhOOiH+st69Cf0lyo+/IAqnhz7X5PKxi
	 VmVz3XsgAG/iFwdHPaPk1bZ/ukTVTtIo4ev8QsZVrKy76fAAkFp8Z+PdiGQSqKB7Bm
	 NmnaO0KhMfXn/ekzFIiY4l0tdQIkJp9qGVKqrrf4BOFSEccC2QzdjNxVZ6WgLYs0o6
	 JAaXPFb+7Y2xN7XSxR9EUaRnJKpHRltUM7giicznHSwQSM6xfzlq7p+Nobc5jZrgO7
	 tZn15OUza8M8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1484940949;
	Sat, 10 Oct 2026 22:32:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C38499D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A823F400D5
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N65ledK5kyLd for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F25C140068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666489;
 b=tHFplTJzzt3GDhS1/t76kMOO8jpS5Rd9px+cf504xZ2OOb8FvaVcL/U+kQrkkTG5eIJA
 bA/sEdSnLzP0/FuS3Q1oqDVv2cm2NTq3n8K5PZW6EPdAkVRnN6gdYZnEjKX8pxLHkiR1z
 9C/z9qEcGt6xVCkIAYFZeaJS5T/KPupDdQyvXcGJaDI9Hnn4kz/3BLvTMTgqqHPvfQe41
 VGAOMFoRBW9o6yCbqDoxZS/80dtjrXvE33fmy8W8EcSzHKeyz/fYxM4K7iLdUmwTacaN9
 Hm99a0sUQse5rUfn/V3jewxI81wMIGm/k413LkFupXH//XgcW3ZmrJUQj3mRkM5iOVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666489;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=NIWPqiTcXB3s2dI2nil9n9e+0Frgy6ijk+3D+YzJF3M=;
 b=dM3QxB70W3/junl7A944j63u++GIII+bW9+jb8qXvcq7WwZoHCjOn+LiKnTFaj/fi+HQ
 JWreP7NLQDAgx+v2fUkOnMc8tcmvcG911qp1N0RZQRqDi7IDYsPV/7j+Akj2b8kTtXbsv
 yIrQKrAtr4682azlsguR2HDZ4G9K/exEzgV2SyJK1ALC4XOcm7ex7YAgvsziJfLSK1TdH
 GnFySevAFclLLYut8AUwDDKSnu2MpLt1BjyhKtl2xvQO9GeikcDfu6fe6bVwOts2AHh9h
 usagjJ6eL1vEkCx5lG4odqW7YpdzUUUSSsRbS/FkpVOanEVPXuq2DaaCzF9LwInnLLw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GJhjZcej; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GJhjZcej
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F25C140068
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EA09436FC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E69BC2BCFC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=fnukDp2d7uGRx8Lpnhl51eg+d7YX6AdC3vb5yKmwbgs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=GJhjZcejPH/euKHAnMwTJ+mMQVKdn1huP2fcaLe4pFUsiMrmIARy8Ps3jbg+1taws
 +Z/MbMmatS5ZIlPCuS0rXkP2kNLA72kVZJSgbgnMUDxv1vd/EGE7QT/cD1vWY7QIPX
 3a2Eth81qJeBEJHghoy86hoaxRQ6qC5W43f0gFrAWuuI7+WDTmBeLebk+/elQVYEus
 FC33c9JrDXmPGQPgWky0X47+xNVku/QAno7ojv8TGo7U/5X8Hpj7P7xGQ8nZ7jatvm
 bRS9U7r85l/OYSiYRUcZyd73Y+9yI720JbOMV12XsEp5f/dSLlUB/DbgRm858BCRpg
 paFwVLHxhd+4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2ACA9EC1;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:51 +0200
Subject: [PATCH 03/11] cmd: phonemenu: mirror the menu to byte-stream consoles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-3-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=4352;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=/mKdxYAuxwGadyLKCtPHJTCiuo/hLdKQi7LAU63mz2Y=;
 b=VbnozkMPmOu9ywmvEnEyFZZmSrveQ/JXB4SlrdHd+unag4NBI9CzpFgfy/AiIz8kb4kZRuQpz
 m6kjOaBZMIXBi1mWaw5Tn/F/eOPMV6l4aCGnQ7TSB19aiMB/8kpwfEN
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The pixel-drawn menu is rendered to serial or USB CDC-ACM.
Add pm_term_puts()/pm_term_render() to render the same menu as ANSI
escapes over those byte-stream consoles.

Wire it into pm_render_all() for initial draw and the up/down navigation
in pm_run().

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/phonemenu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/cmd/phonemenu.c b/cmd/phonemenu.c
index 30f994bcb64..e83394714c3 100644
--- a/cmd/phonemenu.c
+++ b/cmd/phonemenu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <ansi.h>
 #include <cli.h>
 #include <command.h>
 #include <dm.h>
@@ -9,6 +10,8 @@
 #include <log.h>
 #include <malloc.h>
 #include <menu.h>
+#include <stdio.h>
+#include <stdio_dev.h>
 #include <video.h>
 #include <video_console.h>
 #include <version.h>
@@ -234,6 +237,76 @@ static void pm_draw_frame(struct pm_state *s)
 		COL_FOOTER, COL_BG, foot);
 }
 
+/* ANSI escape sequences and line ending used on the byte-stream consoles */
+#define PM_TERM_EOL		"\r\n"
+#define PM_TERM_CLEAR		ANSI_CLEAR_CONSOLE "\e[H"
+#define PM_TERM_CURSOR_HIDE	ANSI_CURSOR_HIDE
+#define PM_TERM_CURSOR_SHOW	ANSI_CURSOR_SHOW
+#define PM_TERM_REVERSE		ANSI_COLOR_REVERSE
+#define PM_TERM_RESET		ANSI_COLOR_RESET
+
+/* Mirror the menu to byte-stream consoles (serial UART, USB CDC ACM) */
+static void pm_term_puts(const char *str)
+{
+	static const char * const names[] = { "serial", "usbacm" };
+	struct stdio_dev *d;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		d = stdio_get_by_name(names[i]);
+		if (!d || !d->puts)
+			continue;
+
+		if (!strcmp(names[i], "usbacm") && !d->priv)
+			continue;
+
+		d->puts(d, str);
+	}
+}
+
+static void pm_term_render(struct pm_state *s)
+{
+	enum pm_section prev = PM_SEC_COUNT;
+	char buf[160];
+	int i;
+
+	/* Clear screen, cursor home, hide cursor while we paint. */
+	pm_term_puts(PM_TERM_CLEAR PM_TERM_CURSOR_HIDE);
+
+	snprintf(buf, sizeof(buf), "  %s" PM_TERM_EOL, s->title);
+	pm_term_puts(buf);
+	if (s->subtitle && *s->subtitle) {
+		snprintf(buf, sizeof(buf), "  %s" PM_TERM_EOL, s->subtitle);
+		pm_term_puts(buf);
+	}
+	if (s->version && *s->version) {
+		snprintf(buf, sizeof(buf), "  %s" PM_TERM_EOL, s->version);
+		pm_term_puts(buf);
+	}
+	pm_term_puts(PM_TERM_EOL);
+
+	for (i = 0; i < s->count; i++) {
+		if (s->items[i].section != prev) {
+			snprintf(buf, sizeof(buf), "  [%s]" PM_TERM_EOL,
+				 pm_section_label[s->items[i].section]);
+			pm_term_puts(buf);
+			prev = s->items[i].section;
+		}
+		if (i == s->active)
+			snprintf(buf, sizeof(buf),
+				 "    " PM_TERM_REVERSE "> %s" PM_TERM_RESET PM_TERM_EOL,
+				 s->items[i].label);
+		else
+			snprintf(buf, sizeof(buf), "      %s" PM_TERM_EOL,
+				 s->items[i].label);
+		pm_term_puts(buf);
+	}
+
+	pm_term_puts(PM_TERM_EOL
+		     "  Vol up/down or arrows to move    Power or Enter to select"
+		     PM_TERM_EOL);
+}
+
 static void pm_render_all(struct pm_state *s)
 {
 	int i;
@@ -242,6 +315,8 @@ static void pm_render_all(struct pm_state *s)
 	for (i = 0; i < s->count; i++)
 		pm_draw_item(s, i, i == s->active);
 	video_sync(s->vid, true);
+
+	pm_term_render(s);
 }
 
 static int pm_run(const struct pm_item *items, int count,
@@ -290,6 +365,7 @@ static int pm_run(const struct pm_item *items, int count,
 			pm_draw_item(&s, s.last_active, false);
 			pm_draw_item(&s, s.active, true);
 			video_sync(s.vid, true);
+			pm_term_render(&s);
 			break;
 		case BKEY_DOWN:
 			/* Wrap from the last item back to item 0. */
@@ -298,6 +374,7 @@ static int pm_run(const struct pm_item *items, int count,
 			pm_draw_item(&s, s.last_active, false);
 			pm_draw_item(&s, s.active, true);
 			video_sync(s.vid, true);
+			pm_term_render(&s);
 			break;
 		case BKEY_SELECT:
 			running = false;
@@ -318,6 +395,9 @@ static int pm_run(const struct pm_item *items, int count,
 	s.vp->colour_bg = COL_BG;
 	video_sync(s.vid, true);
 
+	/* Reset the terminal: clear screen, show cursor, reset colours. */
+	pm_term_puts(PM_TERM_CLEAR PM_TERM_CURSOR_SHOW PM_TERM_RESET);
+
 	cmd = items[s.active].command;
 	if (cmd && cmd[0])
 		run_command((char *)cmd, 0);

-- 
2.55.0


