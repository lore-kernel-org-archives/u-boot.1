Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84115CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3CA86C40;
	Tue, 19 Sep 2023 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="debj4FdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A155B86C21; Tue, 19 Sep 2023 20:09:51 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8738386C29
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso208377939f.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146988; x=1695751788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91SfZHpczX586T6a4K/moHuKXAEyC1vcgO299l+ki68=;
 b=debj4FdCIXnTMgSXnQ5tnpa+c60dg/C2RIcgjOlBApbqqPqNkOWnxNV0bUi5+UVg+g
 gYG7/XyQlEKTNFN7N8rkka1+tmHCs2j4jamlCqQNMg3hJS9oGp0m4tqXlTzbhf7BG21s
 NzCPY/zAj7+TfnU1Rd3meoMv3gytF/kBG7UeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146988; x=1695751788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91SfZHpczX586T6a4K/moHuKXAEyC1vcgO299l+ki68=;
 b=oifN6jGbwk2Iek+qDE3UFxIiOfl3b+3DB2ZT/Q/7zO/PUN3bS0AH1YlckX9mSbZdsE
 7/2LVT368nmifHoh16Ph9O/ozixMo7pPHonNoXfKqyBKnmrH3enCskto1X15WVcx20o4
 ULSk3p6IgWgg+KN3M1w+4D0zM7eFUCkpnNU4JdEkmvIuJ6XS3xhM+wObT1cFSL7VUpCA
 4iOXRnDf+9wUmliM2ULr+YRPiCiA55pKGzvu57fqdRiJuL4AsH6C9duWCxUYz3FfEs8H
 ntB/z7D4L7PHzh5X/7vLxochnCDUsbzB08hqcsy5JWwVAeorBKq3tbdCqizYiCKPmp00
 /7Mw==
X-Gm-Message-State: AOJu0Yz5DaqC0FEXEbFJukDFBvJ2OIVSlgfd+6Wt40mnxaX7Jzh/tfYg
 4ZSXwYmLrcGMtKHtwis01mfZ7oc5aQ5n0H49sOE=
X-Google-Smtp-Source: AGHT+IG2Gtp4hPsoiU3aT4Zhs3fTQ9EdeejwcUM//MD5WIoWiVmVBlARNYZ+ZCyWi4/o1dwZU+glJw==
X-Received: by 2002:a05:6e02:b26:b0:350:f51b:c333 with SMTP id
 e6-20020a056e020b2600b00350f51bc333mr779249ilu.2.1695146988081; 
 Tue, 19 Sep 2023 11:09:48 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 26/36] expo: Allow rendering the background of any object
Date: Tue, 19 Sep 2023 12:08:56 -0600
Message-ID: <20230919180918.2904313-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

So far only menus have a background. When other object types are
rendered, they may have a background too. Make this code more generic
so it will be usable by new object types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 40 +++++++++++++++++++++++++++++++++++++++-
 boot/scene_internal.h |  7 -------
 boot/scene_menu.c     | 29 -----------------------------
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index e98676b9387..314dd7c6e84 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -314,6 +314,44 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 	return 0;
 }
 
+/**
+ * scene_render_background() - Render the background for an object
+ *
+ * @obj: Object to render
+ */
+static void scene_render_background(struct scene_obj *obj)
+{
+	struct expo *exp = obj->scene->expo;
+	const struct expo_theme *theme = &exp->theme;
+	struct vidconsole_bbox bbox, label_bbox;
+	struct udevice *dev = exp->display;
+	struct video_priv *vid_priv;
+	struct udevice *cons = exp->cons;
+	struct vidconsole_colour old;
+	enum colour_idx fore, back;
+	uint inset = theme->menu_inset;
+
+	/* draw a background for the object */
+	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+		fore = VID_BLACK;
+		back = VID_WHITE;
+	} else {
+		fore = VID_LIGHT_GRAY;
+		back = VID_BLACK;
+	}
+
+	/* see if this object wants to render a background */
+	if (scene_obj_calc_bbox(obj, &bbox, &label_bbox))
+		return;
+
+	vidconsole_push_colour(cons, fore, back, &old);
+	vid_priv = dev_get_uclass_priv(dev);
+	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
+			label_bbox.x1 + inset, label_bbox.y1 + inset,
+			vid_priv->colour_fg);
+	vidconsole_pop_colour(cons, &old);
+}
+
 /**
  * scene_obj_render() - Render an object
  *
@@ -397,7 +435,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 				return -ENOTSUPP;
 
 			/* draw a background behind the menu items */
-			scene_menu_render(menu);
+			scene_render_background(obj);
 		}
 		/*
 		 * With a vidconsole, the text and item pointer are rendered as
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 326508874e6..1c2bfeadcd3 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -165,13 +165,6 @@ int scene_render(struct scene *scn);
  */
 int scene_send_key(struct scene *scn, int key, struct expo_action *event);
 
-/**
- * scene_menu_render() - Render the background behind a menu
- *
- * @menu: Menu to render
- */
-void scene_menu_render(struct scene_obj_menu *menu);
-
 /**
  * scene_render_deps() - Render an object and its dependencies
  *
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 95c283af4b0..63994165efb 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -516,35 +516,6 @@ int scene_menu_display(struct scene_obj_menu *menu)
 	return -ENOTSUPP;
 }
 
-void scene_menu_render(struct scene_obj_menu *menu)
-{
-	struct expo *exp = menu->obj.scene->expo;
-	const struct expo_theme *theme = &exp->theme;
-	struct vidconsole_bbox bbox, label_bbox;
-	struct udevice *dev = exp->display;
-	struct video_priv *vid_priv;
-	struct udevice *cons = exp->cons;
-	struct vidconsole_colour old;
-	enum colour_idx fore, back;
-
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
-		fore = VID_BLACK;
-		back = VID_WHITE;
-	} else {
-		fore = VID_LIGHT_GRAY;
-		back = VID_BLACK;
-	}
-
-	scene_menu_calc_bbox(menu, &bbox, &label_bbox);
-	vidconsole_push_colour(cons, fore, back, &old);
-	vid_priv = dev_get_uclass_priv(dev);
-	video_fill_part(dev, label_bbox.x0 - theme->menu_inset,
-			label_bbox.y0 - theme->menu_inset,
-			label_bbox.x1, label_bbox.y1 + theme->menu_inset,
-			vid_priv->colour_fg);
-	vidconsole_pop_colour(cons, &old);
-}
-
 int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu)
 {
 	struct scene_menitem *item;
-- 
2.42.0.459.ge4e396fd5e-goog

