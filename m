Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCC5C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DA182ABA;
	Fri,  2 May 2025 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FHI4vICT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09EF882845; Fri,  2 May 2025 16:48:20 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFB982AAF
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so66698839f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197296; x=1746802096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDtaTbAX0Px31/CpjhEoFK6XTCTQP6SpU47Th8Z/Ccw=;
 b=FHI4vICTXnPGhUC0bjeizUGCDsL7pijChWUEXNtyqeeiy1LcHBVrADn/GvO7eM4N5X
 rRt7xLA+SngX7GmtvhRGG9VVY1W0hQEEOm4JvJBFI39V4trGq96qfN+mJD3h9QU+V7MR
 tyrnTL7fe5DQrt0fa/OzjOSgjpFocbVSke9XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197296; x=1746802096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDtaTbAX0Px31/CpjhEoFK6XTCTQP6SpU47Th8Z/Ccw=;
 b=Tgh9vp2IPrmAgCH7LFPMDcXsUu19lwJQ2T4Ew3vsjXjbGTRmAuKv+v+wv1Ympwo1xp
 6xuFI0U2+vpweCiyql+9xoiNPlqtywSKgEGxHX0qJr4+Loc5BmotWxkCjKjGcS/HAtlF
 dgobDskY9WxPzChNBIXoJZv+JQTNxyJ8F7WFCxv7Ei2OhO62G7xpFKCGdo9x/b7WvZj6
 umnU9k+mv+M/pSx7pX2/rJobKL2rce036JRtMFlC2biFLPj9cMgpDBqXSQ6gmtVzS4eh
 brtT3cWFs69goCPVDJl8M6ToQqOcZ+chdmgVBn+Bwbahc/X5A4EEAnY3gf+zVw0ogTyU
 s8ww==
X-Gm-Message-State: AOJu0YxtqWYKJiv1MPhCk649VTi4U2wV6VS9FcG8UJkmiPuAzcjtCY0G
 dc/+wSBjLwOnxxRcJToZYVKLH20VYC59QHRPykJXJ83pq2is2x2ws5LSQ4HTiJVrMhNFGdzRL/M
 =
X-Gm-Gg: ASbGncuriEXy62EHKyIXRSipkiaKZvGP2307qGzkPpy7MuWupzjq8h6GILI3266e47z
 nDG0SvyqzWeU5JVoqwYOsESoX7lGxviUU8dOf1EAa/66HiHKaYKTWFJ9lQo704emYu9OD6v408n
 Ry3bWlcXal387bjbDeuL3Qo2hqq1YyqclDY51flxJ8oVAQ/wICA3o20iwX6k+tqUpwdUNJEJOl5
 MJBdRiw1vl0tYseg966PIU/nMuACmBGfXKcwTHKqsxyGdxcNZorlUh2ePKf+EMPFbfjqRnmlict
 kwaVtE0mjDZKlC1P/LeF4Aas+0+kIGyfAYYi+g963qJYIz7prhl+GYkfCBh9Yf+Sn6RQYY2uElS
 IUFuAjjpAobj0
X-Google-Smtp-Source: AGHT+IHa9mD38Ot2PzyyxLDJ+lEECex1UhaDmHRXy46VSSCNU53vMlvC73kgXFTs387TCBq7p7IuXA==
X-Received: by 2002:a05:6602:3a10:b0:85a:eecd:37b with SMTP id
 ca18e2360f4ac-866b3490246mr382030839f.11.1746197296015; 
 Fri, 02 May 2025 07:48:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/60] expo: Test editing a lineedit
Date: Fri,  2 May 2025 08:46:26 -0600
Message-ID: <20250502144718.313633-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Open the lineedit and add a few characters, to check that things look
right.

At present when the user moves to a new menu item, the menu code
handles this immediately. This means it is not possible to use an expo
action to effect the same change.

Update this so that EXPOACT_POINT_ITEM is handled in cedit_do_action().

Expand the test to cover this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to test editing a lineedit

 test/boot/cedit.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 97ca63b3082..0c34d4b3df0 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -302,19 +302,40 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_assertok(expo_render(exp));
 	ut_asserteq(4986, video_compress_fb(uts, dev, false));
 
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+
+	act.type = EXPOACT_POINT_ITEM;
+	act.select.id = ID_AC_ON;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5365, video_compress_fb(uts, dev, false));
+
+	/* select it */
+	act.type = EXPOACT_SELECT;
+	act.select.id = ID_AC_ON;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4980, video_compress_fb(uts, dev, false));
+
+	ut_asserteq(ID_AC_ON, menu->cur_item_id);
+
 	/* move to the line-edit field */
 	act.type = EXPOACT_POINT_OBJ;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4872, video_compress_fb(uts, dev, false));
+	ut_asserteq(4862, video_compress_fb(uts, dev, false));
 
 	/* open it */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4841, video_compress_fb(uts, dev, false));
+	ut_asserteq(4851, video_compress_fb(uts, dev, false));
 
 	/*
 	 * Send some keypresses. Note that the console must be enabled so that
@@ -330,7 +351,7 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5009, video_compress_fb(uts, dev, false));
+	ut_asserteq(4996, video_compress_fb(uts, dev, false));
 
 	expo_destroy(exp);
 	cur_exp = NULL;
-- 
2.43.0

