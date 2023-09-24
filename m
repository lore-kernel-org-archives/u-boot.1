Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EB9CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 21:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDE98694A;
	Sun, 24 Sep 2023 23:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V96A79X7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1548694A; Sun, 24 Sep 2023 23:23:10 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255E681FA8
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 23:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8B5A73F941; 
 Sun, 24 Sep 2023 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695590587;
 bh=5+VYFmS7G3av5WpDbiRkELDo1ZPbnQ9sLuGwjBPQbs8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=V96A79X76Xiypp4W3i6YPr5kfFnWCFn+KNmrOLgLA1IP8AneKlBtB62iZYZ+jI5wo
 CMpqA/unCFgzBChdPybiQ7+XPdubjiHvXwGgWQdH+RG3ulEIbCfH5WINR0vGyRc0Ez
 RgRpdwVsyG5kkMJLEXr4Iz2+kin/AgrNXI4nZPj1SSLWGnrIJloZ2D+Ffp8Qm2fr8Y
 DwL1FpEKdt5PgLHkPO5+SufQLboWG+NoOIgGWUdbGkUytZzcsrYeEfL2yYNVl9NCLq
 5/X+1gytBXUKmVxaV8xcrgjrw9e5GYwZ03RzRfclyYjAvxJZMKR3zeonqzAGCcoh9a
 UuvCzZ/92GEsw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: BitBlt test
Date: Sun, 24 Sep 2023 23:23:06 +0200
Message-Id: <20230924212306.134568-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The BitBlt test leaves the serial console output in disarray.

* Call ClearScreen() where needed.
* Test CheckEvent() for EFI_SIMPLE_TEXT_INPUT_PROTOCOL.WaitForKey
  via adding navigation keys
* Correct timer comment

For testing on the sandbox:

    CONFIG_CMD_BOOTEFI_SELFTEST=y
    CONFIG_CONSOLE_TRUETYPE=n
    $ ./u-boot -T -l
    => setenv efi_selftest block image transfer
    => bootefi selftest

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_bitblt.c | 83 +++++++++++++++++++-------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_bitblt.c b/lib/efi_selftest/efi_selftest_bitblt.c
index 1def843505..605078b722 100644
--- a/lib/efi_selftest/efi_selftest_bitblt.c
+++ b/lib/efi_selftest/efi_selftest_bitblt.c
@@ -14,6 +14,12 @@
 #define HEIGHT	120
 #define DEPTH	 60
 
+struct pos {
+	efi_uintn_t x;
+	efi_uintn_t y;
+	int redrawn;
+};
+
 static const struct efi_gop_pixel BLACK =	{  0,   0,   0, 0};
 static const struct efi_gop_pixel RED =		{  0,   0, 255, 0};
 static const struct efi_gop_pixel ORANGE =	{  0, 128, 255, 0};
@@ -27,7 +33,7 @@ static efi_guid_t efi_gop_guid = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
 static struct efi_gop *gop;
 static struct efi_gop_pixel *bitmap;
 static struct efi_event *event;
-static efi_uintn_t xpos;
+static struct pos pos;
 
 static void ellipse(efi_uintn_t x, efi_uintn_t y,
 		    efi_uintn_t x0, efi_uintn_t y0,
@@ -62,31 +68,33 @@ static void rectangle(efi_uintn_t x, efi_uintn_t y,
  */
 static void EFIAPI notify(struct efi_event *event, void *context)
 {
-	efi_uintn_t *pos = context;
+	struct pos *pos = context;
 	efi_uintn_t dx, sx, width;
 
 	if (!pos)
 		return;
 
 	/* Increment position */
-	*pos += 5;
-	if (*pos >= WIDTH + gop->mode->info->width)
-		*pos = 0;
+	pos->x += 5;
+	if (pos->x >= WIDTH + gop->mode->info->width)
+		pos->x = 0;
 
 	width = WIDTH;
-	dx = *pos - WIDTH;
+	dx = pos->x - WIDTH;
 	sx = 0;
-	if (*pos >= gop->mode->info->width) {
-		width = WIDTH +  gop->mode->info->width - *pos;
-	} else if (*pos < WIDTH) {
+	if (pos->x >= gop->mode->info->width) {
+		width = WIDTH +  gop->mode->info->width - pos->x;
+	} else if (pos->x < WIDTH) {
 		dx = 0;
-		sx = WIDTH - *pos;
-		width = *pos;
+		sx = WIDTH - pos->x;
+		width = pos->x;
 	}
 
 	/* Copy image to video */
-	gop->blt(gop, bitmap, EFI_BLT_BUFFER_TO_VIDEO, sx, 0, dx, DEPTH,
+	gop->blt(gop, bitmap, EFI_BLT_BUFFER_TO_VIDEO, sx, 0, dx, pos->y,
 		 width, HEIGHT, WIDTH * sizeof(struct efi_gop_pixel));
+
+	pos->redrawn = 1;
 }
 
 /*
@@ -107,7 +115,7 @@ static int setup(const efi_handle_t handle,
 
 	/* Create event */
 	ret = boottime->create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL,
-				     TPL_CALLBACK, notify, (void *)&xpos,
+				     TPL_CALLBACK, notify, (void *)&pos,
 				     &event);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("could not create event\n");
@@ -247,6 +255,9 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	con_out->set_attribute(con_out, EFI_WHITE | EFI_BACKGROUND_BLUE);
+	con_out->clear_screen(con_out);
+
 	/* Fill background */
 	ret = gop->blt(gop, bitmap, EFI_BLT_VIDEO_FILL, 0, 0, 0, 0,
 		       info->width, info->height, 0);
@@ -281,21 +292,53 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
-	/* Set 250ms timer */
-	xpos = WIDTH;
+	/* Set 25ms timer */
+	pos.x = WIDTH;
+	pos.y = DEPTH;
 	ret = boottime->set_timer(event, EFI_TIMER_PERIODIC, 250000);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("Could not set timer\n");
 		return EFI_ST_FAILURE;
 	}
 
-	con_out->set_cursor_position(con_out, 0, 0);
-	con_out->set_attribute(con_out, EFI_WHITE | EFI_BACKGROUND_BLUE);
 	efi_st_printf("The submarine should have three yellow port holes.\n");
-	efi_st_printf("Press any key to continue");
-	efi_st_get_key();
+	efi_st_printf("UP, DOWN to navigate, any other key to quit");
+	for (;;) {
+		struct efi_input_key input_key;
+
+		ret = boottime->check_event(con_in->wait_for_key);
+		if (ret == EFI_NOT_READY)
+			continue;
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("CheckEvent failed %x\n",
+				     (unsigned int)ret);
+			return EFI_ST_FAILURE;
+		}
+		ret = con_in->read_key_stroke(con_in, &input_key);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("Key not available %x\n",
+				     (unsigned int)ret);
+			return EFI_ST_FAILURE;
+		}
+		switch (input_key.scan_code) {
+		case 0x01: /* UP */
+			if (pos.redrawn && pos.y >= 5) {
+				pos.y -= 5;
+				pos.redrawn = 0;
+			}
+			continue;
+		case 0x02: /* DOWN */
+			if (pos.redrawn &&
+			    pos.y + HEIGHT + 5 < gop->mode->info->height) {
+				pos.y += 5;
+				pos.redrawn = 0;
+			}
+			continue;
+		}
+		break;
+	}
 	con_out->set_attribute(con_out, EFI_LIGHTGRAY);
-	efi_st_printf("\n");
+	con_out->clear_screen(con_out);
 
 	return EFI_ST_SUCCESS;
 }
-- 
2.40.1

