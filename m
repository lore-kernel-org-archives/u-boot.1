Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0957C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3B1828C2;
	Mon,  5 May 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QfqX/r25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C7380F03; Mon,  5 May 2025 17:43:57 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FA180F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so2982121a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459833; x=1747064633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhAdjy9sGB8nG7x3ZG8aiB+iyYUpWATDPJx8MZBKwRs=;
 b=QfqX/r25y9h4LzFa7VnFzNpicloSbHY5P6XJNgwyAVipDlGa30o4d6nkVjYCOG84xC
 N9jN3+ACnTYLgxeWyZyP1TsWmnHMdBhtAfuPOKlNJDCf/DW46UwypWZNB0cws5WMwpDB
 K2LlmX2qTXbeAqr1ig5s44D8YG9jiES2sGfsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459833; x=1747064633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhAdjy9sGB8nG7x3ZG8aiB+iyYUpWATDPJx8MZBKwRs=;
 b=VDR3nCIcH9IYXvca3sfLz+3/p3velkBo/39MNxQTnafKL36uLXpu6lIBxo9LTPro+c
 5NVg1lopHJHHcva08OVoja9Stwo9/KZMAH+1TeMMfMjrc5L5C5LG8tMHi/AU94RLsFvL
 boXroc1ogsbZIlB3Q/PSo3vkpxbY0lP6hhSvIm3Cj+8u8jKlbbhY0I00/MI60+bXU2Oe
 2V/WR0I6CKFbW9GUheTZhQ1L4iHrW34QwdZwNafuwy4FHZIzYc8MtFCWvc6q1CnBRiJk
 GjvBvUa8IjtgWaRjvY8j1NAOLVJ2mB1lVOONMhTu9yvpu0YhMuS5Xgok+JzJrmDIdJpB
 nL+A==
X-Gm-Message-State: AOJu0YxMuMejnTH359Wa6MWKZJAdAN2jrUTfGsLRM2CuznB6rX+MT/oX
 gKjTRTXCOp4GcMB7p+oy91RFn+zzjEDeG6O5h2LedrG+SqhGQlfWb6kWtlMPfElfixzJsojdZr+
 /py1V1U8=
X-Gm-Gg: ASbGnctgUZhF9eJYszVJgsBdY8c/k6lZ9NmnPe1+zGvmylCPtTFgLkjb6Iv5b9SUg+O
 ylgiqBYpmkz2TZX995d6p3b8OX3r3lnpC2sTGw/61WJCGtw5G56ZrAaI6oS3WhJvAu5JcwDbeHR
 qgR6YSK06sv058yZjXHWlAjvDZf6syX5rftqBuAxsrxBkNRstHPzWEvyASo7j6xWBIDobAZ6Of6
 OPFSbkBKYblEfEZYInLhvVuuGCcAvGOXAyoN7roXGSsI5sVo4CIdT1VLu7dcIjizXE8F/VyLGwA
 /d+TspjSo63X6eYwr9LCAfHqUCDQ068MIGDq
X-Google-Smtp-Source: AGHT+IE54Wk8NHhR+1rv5K87TwP1jg3bIIfcR5NcVYvNYDVwcYUCoz/KT19f9k26BIkkWfVpzME4iw==
X-Received: by 2002:a05:6402:5211:b0:5f6:2249:d424 with SMTP id
 4fb4d7f45d1cf-5faa800ba52mr7663392a12.24.1746459833136; 
 Mon, 05 May 2025 08:43:53 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/19] expo: Use a different logo for the second menu-item
Date: Mon,  5 May 2025 17:42:40 +0200
Message-ID: <20250505154308.2911248-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

When testing menu items it is easier to check that the correct preview
is shown if the preview images are different. Make a copy of the image
and modify the palette for the second menu item, so this is obvious.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c         |  2 +-
 drivers/video/video-uclass.c |  6 +++++-
 include/video.h              |  3 ++-
 test/boot/expo.c             | 29 ++++++++++++++++++++++-------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 4a442e16850..5d77a0eaea8 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -67,7 +67,7 @@ int bootflow_menu_new(struct expo **expp)
 				  SCENEOB_DISPLAY_MAX, 30);
 	ret |= scene_obj_set_halign(scn, OBJ_MENU_TITLE, SCENEOA_CENTRE);
 
-	logo = video_get_u_boot_logo();
+	logo = video_get_u_boot_logo(NULL);
 	if (logo) {
 		ret |= scene_img(scn, "ulogo", OBJ_U_BOOT_LOGO, logo, NULL);
 		ret |= scene_obj_set_pos(scn, OBJ_U_BOOT_LOGO, 1165, 100);
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 780b2bc6125..c02fd9bb958 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -582,11 +582,15 @@ int video_get_ysize(struct udevice *dev)
 	extern u8 __splash_ ## _name ## _end[]
 
 #define SPLASH_START(_name)	__splash_ ## _name ## _begin
+#define SPLASH_END(_name)	__splash_ ## _name ## _end
 
 SPLASH_DECL(u_boot_logo);
 
-void *video_get_u_boot_logo(void)
+void *video_get_u_boot_logo(int *sizep)
 {
+	if (sizep)
+		*sizep = SPLASH_END(u_boot_logo) - SPLASH_START(u_boot_logo);
+
 	return SPLASH_START(u_boot_logo);
 }
 
diff --git a/include/video.h b/include/video.h
index 9ea6b676463..2fbf8a9598a 100644
--- a/include/video.h
+++ b/include/video.h
@@ -418,9 +418,10 @@ bool video_is_active(void);
 /**
  * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
  *
+ * @sizep: If non-null, returns the size of the logic in bytes
  * Returns: Pointer to logo
  */
-void *video_get_u_boot_logo(void);
+void *video_get_u_boot_logo(int *sizep);
 
 /*
  * bmp_display() - Display BMP (bitmap) data located in memory
diff --git a/test/boot/expo.c b/test/boot/expo.c
index ddfb739f9cf..64b6c154b15 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -463,13 +463,15 @@ BOOTSTD_TEST(expo_object_menu, UTF_DM | UTF_SCAN_FDT);
 static int expo_render_image(struct unit_test_state *uts)
 {
 	struct scene_obj_menu *menu;
+	struct abuf buf, logo_copy;
 	struct scene *scn, *scn2;
 	struct abuf orig, *text;
 	struct expo_action act;
 	struct scene_obj *obj;
 	struct udevice *dev;
 	struct expo *exp;
-	int id;
+	int id, size;
+	void *logo;
 
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
 
@@ -478,7 +480,8 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assert(id > 0);
 	ut_assertok(expo_set_display(exp, dev));
 
-	id = scene_img(scn, "logo", OBJ_LOGO, video_get_u_boot_logo(), NULL);
+	id = scene_img(scn, "logo", OBJ_LOGO, video_get_u_boot_logo(NULL),
+		       NULL);
 	ut_assert(id > 0);
 	ut_assertok(scene_obj_set_pos(scn, OBJ_LOGO, 50, 20));
 
@@ -526,8 +529,18 @@ static int expo_render_image(struct unit_test_state *uts)
 	id = scene_txt_str(scn, "item1-key", ITEM1_KEY, STR_ITEM1_KEY, "1",
 			   NULL);
 	ut_assert(id > 0);
-	id = scene_img(scn, "item1-preview", ITEM1_PREVIEW,
-		       video_get_u_boot_logo(), NULL);
+
+	/*
+	 * hack the logo to change the palette and use that for item2 so we can
+	 * tell them apart
+	 */
+	logo = video_get_u_boot_logo(&size);
+	abuf_init_const(&buf, logo, size);
+	ut_assert(abuf_copy(&buf, &logo_copy));
+	memset(logo_copy.data + 0x70, '\x45', 0x20);
+
+	id = scene_img(scn, "item1-preview", ITEM1_PREVIEW, logo_copy.data,
+		       NULL);
 	id = scene_menuitem(scn, OBJ_MENU, "item1", ITEM1, ITEM1_KEY,
 			    ITEM1_LABEL, ITEM1_DESC, ITEM1_PREVIEW, 0, NULL);
 	ut_assert(id > 0);
@@ -542,7 +555,7 @@ static int expo_render_image(struct unit_test_state *uts)
 			   NULL);
 	ut_assert(id > 0);
 	id = scene_img(scn, "item2-preview", ITEM2_PREVIEW,
-		       video_get_u_boot_logo(), NULL);
+		       video_get_u_boot_logo(NULL), NULL);
 	ut_assert(id > 0);
 
 	id = scene_menuitem(scn, OBJ_MENU, "item2", ITEM2, ITEM2_KEY,
@@ -670,8 +683,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(OBJ_MENU, scn->highlight_id);
 	ut_assertok(expo_render(exp));
-
-	ut_asserteq(19704, video_compress_fb(uts, dev, false));
+	ut_asserteq(20433, video_compress_fb(uts, dev, false));
 
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
@@ -762,6 +774,9 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	abuf_uninit(&buf);
+	abuf_uninit(&logo_copy);
+
 	expo_destroy(exp);
 
 	return 0;
-- 
2.43.0

