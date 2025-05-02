Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EFDC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A501782153;
	Fri,  2 May 2025 16:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbkeNkzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811ED82AB1; Fri,  2 May 2025 16:48:12 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A73082153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso71300739f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197288; x=1746802088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0nmbiHU3nMfsNSfEW2oQbJEVuKTOtakQM/W9gY5ONs=;
 b=LbkeNkzCikCp64Nkb10ObA828vcJjXQaq9xUZ1f1VF8yPWwoyDXDn86u0fHPvyU0O4
 harY/cS/11v+3l0fW3Upg1Nq+IsqrkPNU+QDrvpi2ycn498VZ5a0idKHOUFh9gt9NraC
 5mLOBrahbKqZgq/WdFFNhetwmFusF12FY1/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197288; x=1746802088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0nmbiHU3nMfsNSfEW2oQbJEVuKTOtakQM/W9gY5ONs=;
 b=iUUhPVneaFtPRiQaSf89xpMARA9BV6RC31zzIwNLukUynx37W9b90znBUX2bA5cpXG
 CjYh9mOB5HKW3Al+e0THyQpfsOnPV9Ppk4eMYNqWL1K8oFleDrFWGap7qs5fSl/bu5sp
 CYwi3WUog9i4I1axSBVeeq7SOu1kuH8M9T4gK9PrZQNGus279tQTQT+svcmI6sNwYE+q
 l6D+zCQi2u+iJ2mW3XpvZUrO/Ek3Qg/klWmq5rDfNMm0KVTt6dUFmeqybGOpd4ueH7Ky
 /wLkGxnofhjRVqpK9WujRSU0XV6oK96YU/gb/a4ot1uXNfZx/+9/2002bSmkRZ+ISg/B
 lP5w==
X-Gm-Message-State: AOJu0YyYibxP+1WkU+OPxEMBvsoI4uanz0VmJashgcRJQM/jZXSS7lxl
 whw9yCKFi25ruao9AL7pC6OktCGB2scRQB4Mr3fBodInqJG1GplHkFEDUHZNaJEXjXjGAUWGawg
 =
X-Gm-Gg: ASbGncutcK+lc1VbELGMO5ErWnH/q/LLfUGAKDZBcke8kd8ZmawkH9jxMcYOhHCymLZ
 9fGayPuSM3kR27nMvQylXu5C3UlACe6rRE1CiMjafFw4DxqZHXCVW80tUKvGpTIbULSme7Xp9vM
 vS/YPpcGGpFLrANy99XQWH24+3Gr2gAylomzTnIPoXwnUh6fKGbeD/Li904JoiqYgkJ0jBDn9SO
 fDLAfXpTbT6VWUaAV/YwpNsNpycD2wXBSJRwOSrtBAnFWDWfqp4sGEiJ0A1EQJGJO8O3RkoufTX
 zIMLhq2gKMuuqemNoWFCuvQ+h6C2IYZ0wpUteWQ/NcCvSXgAtcK9E0VQrSc1O1LZDtLfmArMKdh
 Lew==
X-Google-Smtp-Source: AGHT+IGe4/A1Iyp1ikZ8JOsz/PHlf+2EztYZ8+NsGaV8ZTR7RhoOVCkZj4r3tF1se6+C9RC32Xc5eA==
X-Received: by 2002:a05:6602:4899:b0:864:4a66:f4df with SMTP id
 ca18e2360f4ac-8669f9b5d70mr474313839f.6.1746197288376; 
 Fri, 02 May 2025 07:48:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/60] expo: Pass in the video device for cedit_prepare()
Date: Fri,  2 May 2025 08:46:22 -0600
Message-ID: <20250502144718.313633-25-sjg@chromium.org>
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

At present this function locates it own video device. Pass it in to
provide more flexibility.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

Changes in v2:
- Add new patch to pass in the video device for cedit_prepare()

 boot/cedit.c      | 18 ++++++++++--------
 include/cedit.h   |  4 ++--
 test/boot/cedit.c | 20 ++++++++++++++++----
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index f1a9ee7ce20..eac851b395a 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -100,19 +100,16 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 	return 0;
 }
 
-int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
+int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 		  struct scene **scnp)
 {
+	struct udevice *dev = vid_dev;
 	struct video_priv *vid_priv;
-	struct udevice *dev;
 	struct scene *scn;
 	uint scene_id;
 	int ret;
 
 	/* For now we only support a video console */
-	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
-	if (ret)
-		return log_msg_ret("vid", ret);
 	ret = expo_set_display(exp, dev);
 	if (ret)
 		return log_msg_ret("dis", ret);
@@ -143,7 +140,6 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 	if (ret)
 		return log_msg_ret("dim", ret);
 
-	*vid_privp = vid_priv;
 	*scnp = scn;
 
 	return scene_id;
@@ -193,11 +189,17 @@ int cedit_do_action(struct expo *exp, struct scene *scn,
 int cedit_run(struct expo *exp)
 {
 	struct video_priv *vid_priv;
-	uint scene_id;
+	struct udevice *dev;
 	struct scene *scn;
+	uint scene_id;
 	int ret;
 
-	ret = cedit_prepare(exp, &vid_priv, &scn);
+	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
+	if (ret)
+		return log_msg_ret("vid", ret);
+	vid_priv = dev_get_uclass_priv(dev);
+
+	ret = cedit_prepare(exp, dev, &scn);
 	if (ret < 0)
 		return log_msg_ret("prep", ret);
 	scene_id = ret;
diff --git a/include/cedit.h b/include/cedit.h
index a9305ceebcb..319a61aecb8 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -56,11 +56,11 @@ int cedit_run(struct expo *exp);
  * This ensures that all menus have a selected item.
  *
  * @exp: Expo to use
- * @vid_privp: Set to private data for the video device
+ * @dev: Video device to use
  * @scnp: Set to the first scene
  * Return: scene ID of first scene if OK, -ve on error
  */
-int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
+int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 		  struct scene **scnp);
 
 /**
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 5b3e9b586a6..746f60067fd 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -63,6 +63,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct scene_obj_menu *menu;
+	struct udevice *dev;
 	ulong addr = 0x1000;
 	struct ofprop prop;
 	struct scene *scn;
@@ -72,9 +73,12 @@ static int cedit_fdt(struct unit_test_state *uts)
 	void *fdt;
 	int i;
 
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
-	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, dev, &scn));
 
 	/* get a menu to fiddle with */
 	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
@@ -134,12 +138,16 @@ static int cedit_env(struct unit_test_state *uts)
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct scene_obj_menu *menu;
+	struct udevice *dev;
 	struct scene *scn;
 	char *str;
 
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
-	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, dev, &scn));
 
 	/* get a menu to fiddle with */
 	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
@@ -189,11 +197,14 @@ static int cedit_cmos(struct unit_test_state *uts)
 	struct scene_obj_menu *menu, *menu2;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
+	struct udevice *dev;
 	struct scene *scn;
 
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
-	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, &vid_priv, &scn));
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+	ut_asserteq(ID_SCENE1, cedit_prepare(cur_exp, dev, &scn));
 
 	/* get the menus to fiddle with */
 	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
@@ -238,7 +249,8 @@ static int cedit_render(struct unit_test_state *uts)
 
 	exp = cur_exp;
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
-	ut_asserteq(ID_SCENE1, cedit_prepare(exp, &vid_priv, &scn));
+	vid_priv = dev_get_uclass_priv(dev);
+	ut_asserteq(ID_SCENE1, cedit_prepare(exp, dev, &scn));
 
 	menu = scene_obj_find(scn, ID_POWER_LOSS, SCENEOBJT_MENU);
 	ut_assertnonnull(menu);
-- 
2.43.0

