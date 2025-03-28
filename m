Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EAEC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712EB8209D;
	Fri, 28 Mar 2025 14:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OwP+TrX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C18C81EC5; Fri, 28 Mar 2025 14:08:07 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096DE820B3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-855bd88ee2cso57702139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167283; x=1743772083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDtaTbAX0Px31/CpjhEoFK6XTCTQP6SpU47Th8Z/Ccw=;
 b=OwP+TrX9NfTueUURC96Ar4mldhSj6Yqjhshqq65xipCrvRDgSa+hA06/IsIJTi3YfZ
 NaVAnLV/YIoPsS9V97zCaEbvMw0ivK2mBk62FFoNxnWg9Q0gkm49ZD4KAKeJ1mlYtWx4
 /9Ibl1uDPC3qelM3dyVbyzgcYGL4++HRyg/g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167283; x=1743772083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDtaTbAX0Px31/CpjhEoFK6XTCTQP6SpU47Th8Z/Ccw=;
 b=iz5/OBga8WPeBrDx45SBUP+UGyZGUAZae4GMtmxUmKX1WISgWdOJo5k1AJdNXxrAJu
 VnkGGtm0UEe5fC62lN53VNB8Xn2Au7N/1YYZ93wfK6p0S9EJTqUlh+PLQiQS7MUXiJMC
 Onr/LKqzwfGPG7qBLfZzCRcsu0H6ZUh59fDjPay7Wv8zAEmQRZLqRTTNpr98Dj7L5ec0
 fKXpY1Gc+T98hmKG7JW+TsdIGUKB+j620oiQajyhj9IzULi6VJY9lFK74AM4T5Zcy+Be
 7sq/4HeobmkUrhy9rRwjFaL7p/IEVsynerATMO80D2xw5hgbB9TOITNsbA2ajCwGuhDk
 tW5A==
X-Gm-Message-State: AOJu0YzvHKU3/HooEBWy0ye7SdtQgSZfbqfJ4kGV0vqCkYSEAVA9otbp
 WBLqGMe4kwnm025Eb40fjWq0T8A/MF+f1jFxehp7+FVLmWsc+kJTaPzpWmMml3GlVKEFc/xLWRI
 =
X-Gm-Gg: ASbGnctwD4zRIppE7yx1qENH6m77Oflcf9GZEski6WccYJkDlZvtcyOYeXkrwPUbqZf
 fcl1Q75620zeF+GsmMSHOM723tK4Pg2AHbz8TneoKSj8bPjE8dpGZunRnVFbaQZSH2ybQrIDgei
 zGMh0p984rxKKAMfUOXh11TpyTtoKmsKZD9YvxruEd7Jzf9IXpOzxA+yaod82e5N4ts/84Efdz8
 buuoSODfQCvVfGmkwuLwz52ubQtCrgOA1rW2yHsf8Lqog5O2VMmriUF2iQNlMonl0CFWn9MwhPD
 564r2PjF/3cHk07KsQswvNCCQ01meFDkGrdv+nQlRjFr+HGS38jkYxJzyOReof/L5B8vH72DGa4
 /l6BcqQ==
X-Google-Smtp-Source: AGHT+IHnF/35JyEsE+bKwitueM3tIr6a2NQJEzKtvD5L/iAfQ5FjKOh97aVPII92iaYtL+/lLibbcg==
X-Received: by 2002:a05:6602:3897:b0:85e:1ee9:1c18 with SMTP id
 ca18e2360f4ac-85e82134c67mr820655539f.9.1743167282918; 
 Fri, 28 Mar 2025 06:08:02 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/56] expo: Test editing a lineedit
Date: Fri, 28 Mar 2025 07:06:11 -0600
Message-ID: <20250328130713.2612648-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

