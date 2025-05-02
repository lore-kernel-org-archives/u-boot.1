Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C6C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6348E82A8D;
	Fri,  2 May 2025 16:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oIJ8Vbwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036C082A64; Fri,  2 May 2025 16:48:11 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB38182A7B
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso199768739f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197287; x=1746802087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ip8K32xXIv2w5EvQ9+w9pyJBsF1KHiagSMCx40POjes=;
 b=oIJ8VbwbcO3IbkBmU5pyLIHZVfptvVb6bSY0a+RCMhrK+oc+UnG4kHau6loaDXoQVh
 EuK7x6HrSHyvuSNVKYzme8dvtnu174Dc7AawEWNaNZrqW3GoepqDQk8BQtOiR2zb34K2
 sIprI0fkggaIFOi8AVvtq5+WYfrAI86dicqew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197287; x=1746802087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ip8K32xXIv2w5EvQ9+w9pyJBsF1KHiagSMCx40POjes=;
 b=Rd2Ky4Ij9HigpMwg+VCXcoeS0EjMa7baWsx+mznjpdCyC4RkkHEitaCFhw9MqWcUJ9
 j4I2Gw0SCW6cIFyhnfLTmH4JlcuCMiIlOVWZmaMhAHCjWfIxaQr8y/cLThu3UKaQYiJy
 RZiYWD9ZfJ2UoIsj5frvAjhHyLI/2VQnb2eK8ahrNjeI1V0AWYrTlP8dkG4aZ18v/pkZ
 nnB+6sWsogWxH33CG+wUEBYSsCp+y4w0hvOtXNAeAsFBayJcQuWzn6JqX3xvJdojersB
 rz6C3vP3Ftqj9ovbOrqTXvzkmRFLFu/dtxLneVTLKN124qvGwyWOqnPhYkQhDAPDmeGj
 0Bdw==
X-Gm-Message-State: AOJu0YxM4W01PzTlE/v0kojclp9RUcFgIhFoamVSTXJiwjFYnyXu6jYI
 137jJmhM6OjZxm+Knti/0vWXgncTW/svSqgAaqQVSoScTdwVOhoyYnEykmm0j/+eNpF9eSZOD8w
 =
X-Gm-Gg: ASbGnctHexUrnAvb9lm8MlsRm573uPlvucSJchxJ+KKRy9Iqji2HVwOEMLbxAg8oOSa
 JS6qE+ZT76kQv1FE76LxZSvjciUakD91rccLCh/m7B6+v8nwlGt/UEBaDwawxqrHAaW2y89u2D7
 TmzhZXwL3wieOoLlms1fEbnD+q4Pu37vgkarMP5WS7GHRIPuBvyx2UxqNzIrbNHZE2ERYWDuo1P
 3slMKMoS1GreWzvyDQiofeK9agASdLyQm7WYCIFCw9n7PcfL3ab3QclZfVog0XzzmubJ2l2DjxJ
 vzxmhDLzNRvwKz/jnEnvOBGm0jGNuR1DdtK+sGsfRCofDklqRfyCNEhgDcpOByezGL+wE3UkOWX
 OvA==
X-Google-Smtp-Source: AGHT+IED1efl7bWMkk8Uc9ivwpys1EQkA4JdW+19N+HQ8FiACvx3kHZpvc41DQWDPrQzDd3dx16OKw==
X-Received: by 2002:a05:6602:3718:b0:864:677e:ddae with SMTP id
 ca18e2360f4ac-8669f9ac967mr491443839f.6.1746197286814; 
 Fri, 02 May 2025 07:48:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/60] expo: Test some cedit actions
Date: Fri,  2 May 2025 08:46:21 -0600
Message-ID: <20250502144718.313633-24-sjg@chromium.org>
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

Refactor the action-processing code into a new cedit_do_action()
function so we can call it from a test. Check moving to a new field and
opening the menu, to ensure that rendering is correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c      | 80 ++++++++++++++++++++++++++---------------------
 include/cedit.h   | 13 ++++++++
 test/boot/cedit.c | 43 +++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 36 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 8c6948d1d46..f1a9ee7ce20 100644
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
@@ -167,43 +208,10 @@ int cedit_run(struct expo *exp)
 		struct expo_action act;
 
 		ret = expo_poll(exp, &act);
-		if (!ret) {
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
-		} else if (ret != -EAGAIN) {
+		if (!ret)
+			cedit_do_action(exp, scn, vid_priv, &act);
+		else if (ret != -EAGAIN)
 			return log_msg_ret("cep", ret);
-		}
 	} while (!exp->done);
 
 	if (ret)
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

