Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90737C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA06382054;
	Fri, 28 Mar 2025 14:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OQCVM7Em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393A381EC5; Fri, 28 Mar 2025 14:07:58 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D718082093
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85e73f7ba09so185746839f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167274; x=1743772074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6ccc7hkcWRkwqcmQx3ToAXNZBq70B08KrDJ9cKCFes=;
 b=OQCVM7EmN+Rm/fzZqr0rfCwu8F9kNPk/0UH+ep3xlbwGhcv8DoW1klKtoB+NA8EN5S
 M+ziIdq/c1AikOcJlzGEmTOTHZdvRwmFxlZHdv6Snyj+29Q/XV3Xn+5pWkm+ILyx1Oa4
 IjHqMmPeUxwM1dTYjAj3dkistgdg/3j4roSNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167274; x=1743772074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i6ccc7hkcWRkwqcmQx3ToAXNZBq70B08KrDJ9cKCFes=;
 b=bnxiXcGlp2BfU3SH07OdBXtFe6V4RAJfXJxZdQxdxXUKqjnzAbpZ5pjJwctP9FwFkh
 q9xbKQHlCDDJL6/NG4n/XPdtX6mESdf5m9hEESOgDyJp9zzmD3AWvlpkGqHfU/5t71VH
 6nEsOhY0Bv6osLNoQ71StID5vHUb80sYxGhu3YnnPZBVDtS9sf+bnNJlY9n50lKZv1pM
 mq+rlVeYEBZIQddeL1XOg6bLNA9i4EaEYhF37pmnvGVveeZTt+4S2IqXEDTnKiPawjYe
 L23pFJ/wyTX1NoX2WjTt404MLUR4nqoXFallCqPTJ0NccJW+6rDyrJ5m/QC0YAajKOmA
 fNOQ==
X-Gm-Message-State: AOJu0YwsfpQpAsecEpacc3aLgoXNFC1KPFy5k3hopFkxOoiL3O8p92E2
 x/YGt0u+ma4TelzgmTML7weLqHjubqdGZ4pjejaPOjbLtUJVSwkL80vp7rTOc4+RIxPDGVLBN+c
 =
X-Gm-Gg: ASbGncsf6fbawHLsne20fx3HXKgFMBVqGSVFIxu6kLNsGjyPqvLM7gKvBKEobUaHABw
 iSpLutth6f2BR+L9T5smplp56tM4O3nWw+kUaToGMQG3k5OAqT0bybcmomQ65AsvhYwScJRL68n
 naCApenl7O7e5RZRxMBBwNu1IEsgUg8gBKP36DeNwqgYfFpsZrbeZcX0ITeIBSm5tMtR3W+MkWq
 NsGvYN/8xlijRJ6F2w5uz9t/i7QjFISyG2QA3e/KrQwx4cbsN/LrDYPeSBf3vvLPoFQ1HBOEuFZ
 2tgYjxScdEvcDzrk22YN+XImYJltPeQGYZC0/owY7Yy7EZtRqIg69btXwhauE7vnQHzW1SJmsg/
 OesC7Fw==
X-Google-Smtp-Source: AGHT+IHT7cgSBtxTd/7l+hrmvIYQDcoMJrmyuIJpxGiaa+XxP/L+6gK9+59Ly2SeMlI+sGRY5usPww==
X-Received: by 2002:a05:6602:720d:b0:85b:5564:2d51 with SMTP id
 ca18e2360f4ac-85e82137f88mr874884839f.11.1743167273614; 
 Fri, 28 Mar 2025 06:07:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/56] expo: Test some cedit actions
Date: Fri, 28 Mar 2025 07:06:06 -0600
Message-ID: <20250328130713.2612648-20-sjg@chromium.org>
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

Refactor the action-processing code into a new cedit_do_action()
function so we can call it from a test. Check moving to a new field and
opening the menu, to ensure that rendering is correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c      | 75 ++++++++++++++++++++++++++---------------------
 include/cedit.h   | 13 ++++++++
 test/boot/cedit.c | 43 +++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 3703538e5dc..bcbbe69fe33 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -149,6 +149,47 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 	return scene_id;
 }
 
+int cedit_do_action(struct expo *exp, struct scene *scn,
+		    struct video_priv *vid_priv, struct expo_action *act)
+{
+	switch (act->type) {
+	case EXPOACT_NONE:
+	case EXPOACT_POINT_ITEM:
+		return -EAGAIN;
+	case EXPOACT_POINT_OBJ:
+		scene_set_highlight_id(scn, act->select.id);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_OPEN:
+		scene_set_open(scn, act->select.id, true);
+		cedit_arange(exp, vid_priv, scn->id);
+		switch (scn->highlight_id) {
+		case EXPOID_SAVE:
+			exp->done = true;
+			exp->save = true;
+			break;
+		case EXPOID_DISCARD:
+			exp->done = true;
+			break;
+		}
+		break;
+	case EXPOACT_CLOSE:
+		scene_set_open(scn, act->select.id, false);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_SELECT:
+		scene_set_open(scn, scn->highlight_id, false);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_QUIT:
+		log_debug("quitting\n");
+		exp->done = true;
+		break;
+	}
+
+	return 0;
+}
+
 int cedit_run(struct expo *exp)
 {
 	struct video_priv *vid_priv;
@@ -168,39 +209,7 @@ int cedit_run(struct expo *exp)
 
 		ret = expo_poll(exp, &act);
 		if (!ret) {
-			switch (act.type) {
-			case EXPOACT_POINT_OBJ:
-				scene_set_highlight_id(scn, act.select.id);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_OPEN:
-				scene_set_open(scn, act.select.id, true);
-				cedit_arange(exp, vid_priv, scene_id);
-				switch (scn->highlight_id) {
-				case EXPOID_SAVE:
-					exp->done = true;
-					exp->save = true;
-					break;
-				case EXPOID_DISCARD:
-					exp->done = true;
-					break;
-				}
-				break;
-			case EXPOACT_CLOSE:
-				scene_set_open(scn, act.select.id, false);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_SELECT:
-				scene_set_open(scn, scn->highlight_id, false);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_QUIT:
-				log_debug("quitting\n");
-				exp->done = true;
-				break;
-			default:
-				break;
-			}
+			cedit_do_action(exp, scn, vid_priv, &act);
 		} else if (ret != -EAGAIN) {
 			LOGR("cep", ret);
 		}
diff --git a/include/cedit.h b/include/cedit.h
index 856509f0c7f..a9305ceebcb 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -13,6 +13,7 @@
 
 struct abuf;
 struct expo;
+struct expo_action;
 struct scene;
 struct udevice;
 struct video_priv;
@@ -62,6 +63,18 @@ int cedit_run(struct expo *exp);
 int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 		  struct scene **scnp);
 
+/**
+ * cedit_do_action() - Process an action on a cedit
+ *
+ * @exp: Expo to use
+ * @scn: Current scene
+ * @vid_priv: Private data for the video device
+ * @act: Action to process
+ * Return: 0 on success, -EAGAIN if there was no action taken
+ */
+int cedit_do_action(struct expo *exp, struct scene *scn,
+		    struct video_priv *vid_priv, struct expo_action *act);
+
 /**
  * cedit_write_settings() - Write settings in FDT format
  *
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index df191a09f89..5b3e9b586a6 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -226,8 +226,10 @@ BOOTSTD_TEST(cedit_cmos, UTF_CONSOLE);
 /* Check the cedit displays correctely */
 static int cedit_render(struct unit_test_state *uts)
 {
+	struct scene_obj_menu *menu;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
+	struct expo_action act;
 	struct udevice *dev;
 	struct scene *scn;
 	struct expo *exp;
@@ -237,9 +239,50 @@ static int cedit_render(struct unit_test_state *uts)
 	exp = cur_exp;
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
 	ut_asserteq(ID_SCENE1, cedit_prepare(exp, &vid_priv, &scn));
+
+	menu = scene_obj_find(scn, ID_POWER_LOSS, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	ut_asserteq(ID_AC_OFF, menu->cur_item_id);
+
 	ut_assertok(expo_render(exp));
 	ut_asserteq(4929, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
+
+	/* move to the second menu */
+	act.type = EXPOACT_POINT_OBJ;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+
+	/* open the menu */
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+
+	/* close the menu */
+	act.type = EXPOACT_CLOSE;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+
+	/* open the menu again to check it looks the same */
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+
+	/* close the menu */
+	act.type = EXPOACT_CLOSE;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+
 	expo_destroy(exp);
 	cur_exp = NULL;
 
-- 
2.43.0

