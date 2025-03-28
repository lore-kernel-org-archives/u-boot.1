Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B24AC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B6A82075;
	Fri, 28 Mar 2025 14:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMnqB09t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCF9820B3; Fri, 28 Mar 2025 14:08:00 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B617F81DCC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so10973525ab.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167276; x=1743772076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cWs9BYziA2cQJt+B4gNkyb+i3hWuSuZwUmHTjFD890=;
 b=aMnqB09toOu6mt0pXAvRYsOgZjI3rQDyGY7DrJ1KHbzuQ7k2Epbv6eQA8DAl1l5ceO
 mXHM5yoy/R2FTpZKcY7q2a7RO+f/XhH/7QFtlBbEhNZcpQbw8Sx2tdsA2uB5JDxHu8m6
 opfp6N1qt8U4F7U2X8UYXZ7S65WxBKCA0QMxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167276; x=1743772076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cWs9BYziA2cQJt+B4gNkyb+i3hWuSuZwUmHTjFD890=;
 b=cG/7hywYth4n0dvEhPvMp+KvLkdPq8XV65ofAIMzXIziyNeAcaiPjt9nIBvQ0vDB8x
 iPUqKGL9ndkuX3I4wtOP/0WwWrl0SxzoXgU8B1RkUbelS0b5Tumcr9ZMgzVL9XMuP0Sx
 lMJbXvJxqDTPKsyIHT+Q2mnZlc5+E/JESylzq1Q+yX5ObPRwafGLLNjwXhsRkkcUt1QW
 EUM8BG2TnvmB/ZlytjgZGkXcIN6jRamPuQEToRQe2cPBb5zuM1Rks/6W6hOEgOdlBvKD
 O6+1AEZvb5d57di6dNIEPVZDzfanezYqajRkBcEQau5WCcrHFp7Y0uz+09WpEKplFD0s
 JjNA==
X-Gm-Message-State: AOJu0YzCdTCSQMA+MpXFjByHTeAjeO80Ukxi7IEkYfzyDHGerLQ63kzB
 5y+9S92lMLVdQmWnbkpsumo8/WfjQRitD0DKbB3UfO3HBZXPQWcHOYRL0TKcES+UhFD6L8r52dM
 =
X-Gm-Gg: ASbGnctsDSWV7fQ9jyOI+yeblKPwaEkNFaOOi2z6wM+FhIK4jZAoLpuJXFRV3rtwof+
 l09n02i9VILYg/0qczFPgZr0YsIvg63HDDvfiMniV+/depaHURjfMKB3EihHSZvGuw6XaQtt9at
 gpir6QodpZQs++JJAtI4D9dvzfAWdrrRTGASsmGB8Ync4QeebFTIUd7TCEdJiHHnOt1JD9ACUfH
 QYs2UAXrkCIxgzbJOtE+zxgMNqLaok71QO1H41OkbfzW1d/TkJA/EtxHFtM4/1ZOnpY+KhSMYX0
 0TpFpnPsotZvc+2M0Ea4RIEMUZkvNp5buC5Mw5SZ2xWndHDaIDFd56/KiLaufp0eBIpfEeKC2WT
 VfLBRBA==
X-Google-Smtp-Source: AGHT+IElnkpTpFTYTm/gzIXZhdqWh0LwgMVovraHvIuOUu/HlwOwoae5YGg+2CSB4TvBveGNYKIkQw==
X-Received: by 2002:a05:6e02:3207:b0:3d4:4134:5213 with SMTP id
 e9e14a558f8ab-3d5ccdd5bdcmr73553895ab.11.1743167275658; 
 Fri, 28 Mar 2025 06:07:55 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/56] expo: Pass in the video device for cedit_prepare()
Date: Fri, 28 Mar 2025 07:06:07 -0600
Message-ID: <20250328130713.2612648-21-sjg@chromium.org>
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
index bcbbe69fe33..3fde6928f90 100644
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

