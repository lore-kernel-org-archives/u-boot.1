Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A41C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E730835FD;
	Sat, 24 May 2025 17:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DyQygbJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0A7835CD; Sat, 24 May 2025 17:41:33 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1C782D06
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3da73df6c4eso6554535ab.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101289; x=1748706089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZ6Ajnn6AUEChhkdsumd2A7DIJ3DzK65XmjMIaPq+Is=;
 b=DyQygbJ0denDRG8ianSf9ILbuVDZB+q6urNavtwXuzqefaCjKkbmcQew3eAY3ZBW5p
 2j4yZqjSpi6YYcv4B9LZTE/isY4BWcQgyhyn9WOj+N1kxZmxa3MTjen7Ha8BDvorx51K
 8j2N+IlSlxWN8GkrlUh1UMbBvNexPfYo7Npps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101289; x=1748706089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZ6Ajnn6AUEChhkdsumd2A7DIJ3DzK65XmjMIaPq+Is=;
 b=s2GDHywrASDNqA/inJgfQJ09Voli9c8IXyKyWiHTMjjrzhAf+XemVryJBa+FZ7bxnu
 I3HOJ+I7F6Ln8rPnEiJ46WYTJdDAB00CFEJUBUs+HQpSbwh0e2cO5j0KkSdZNEEiKxFl
 3UuzH3EkTzgDYle4YoVl2jN3kwr/CKJnESGSFCw8HPcFl9eg8TUwNZOHxB7WSWCw0ynK
 MJR+ON9pV7SAboVfRmkHXRuKKy+k+i+rul/ZdvHUcGXtnbOBsuoPfHUgmAttI9aqTY+2
 5tieDfP6+B0HE94kHjpFz28QCN8kRLXNHJfgLWr39yti5Iy4Hv1yFtLP1ax4Kj3evWUR
 MDkw==
X-Gm-Message-State: AOJu0YyYP23vZ7/X2BKu6iISiKsnLdLTObzjLAFtaImamYc3OcNqVKgQ
 eHbSrKIjX3w8UcHJ9Mg1JT8gMsm+fkVTIEWoKnshSbth7VRIVYdOpmHMaih2FZesH78VtqjMPtn
 9p+CPnefw
X-Gm-Gg: ASbGncvTaWBYHYL4q/GfLB/mz4E/3ql/JEEQTmdNPF7wDSHX+iHqn+/QMcPCjRo3ceB
 1q7fAVr94qLcLufQtzV7ARflRObyNKMqUVbAqgYEp/1CVU0X5JpW2Un8p9+GLuR8qm2Y9C5Sscm
 +tpvAVKO7koxtLO3EXx3PUWj3nnQYN0bnn0Pgc1Ybw32HOayJegGe2k37wrpycLq7ChbbXZkNHI
 5dieMZNoxlOCDOO5XC/GiCMUFe0v9TJaajYGq2RY+1f7QPoEdklgz4gRcp/FxDmOhko5qZXeTRg
 lRTpq5hxrR8HQGWzPHTaGrzOhChegr6eFHu93abrpkmsh9Zu3pSw7Qm4AtjnnyS231SugKl264F
 I/yGIrnPiApgg
X-Google-Smtp-Source: AGHT+IHiVJu9qf7Ze1RXylRCC82zOTU+8uz/ohf+eeTh+oPAx+RWshJkT+7HiVZlA4LgiFqKLELSWg==
X-Received: by 2002:a05:6e02:174a:b0:3dc:757b:3fab with SMTP id
 e9e14a558f8ab-3dc9b68e03fmr27130065ab.6.1748101289278; 
 Sat, 24 May 2025 08:41:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] expo: Allow changing scene_img data
Date: Sat, 24 May 2025 09:41:10 -0600
Message-ID: <20250524154117.1217190-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524154117.1217190-1-sjg@chromium.org>
References: <20250524154117.1217190-1-sjg@chromium.org>
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

In some cases we want to change the image data used by a scene_img. Add
a function to handle this.

Adjust the BMP function to use a const for the data, since it is not
allowed to change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c              | 13 +++++++++++++
 drivers/video/video_bmp.c |  4 ++--
 include/expo.h            | 13 ++++++++++++-
 include/video.h           |  2 +-
 test/boot/expo.c          |  6 ++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 61b943e2b52..5d2d6617491 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -1173,6 +1173,19 @@ void scene_highlight_first(struct scene *scn)
 	}
 }
 
+int scene_img_set_data(struct scene *scn, uint id, const void *data, int size)
+{
+	struct scene_obj_img *img;
+
+	img = scene_obj_find(scn, id, SCENEOBJT_IMAGE);
+	if (!img)
+		return log_msg_ret("sid", -ENOENT);
+	img->data = data;
+	/* TODO: Consider using an abuf for the image */
+
+	return 0;
+}
+
 static int scene_obj_open(struct scene *scn, struct scene_obj *obj)
 {
 	int ret;
diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 1f267d45812..478b8fbe5fd 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -242,10 +242,10 @@ static void video_splash_align_axis(int *axis, unsigned long panel_size,
 	*axis = max(0, (int)axis_alignment);
 }
 
-void video_bmp_get_info(void *bmp_image, ulong *widthp, ulong *heightp,
+void video_bmp_get_info(const void *bmp_image, ulong *widthp, ulong *heightp,
 			uint *bpixp)
 {
-	struct bmp_image *bmp = bmp_image;
+	const struct bmp_image *bmp = bmp_image;
 
 	*widthp = get_unaligned_le32(&bmp->header.width);
 	*heightp = get_unaligned_le32(&bmp->header.height);
diff --git a/include/expo.h b/include/expo.h
index 6acbc54c648..522f6a93f98 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -368,7 +368,7 @@ static inline bool scene_obj_can_highlight(const struct scene_obj *obj)
  */
 struct scene_obj_img {
 	struct scene_obj obj;
-	char *data;
+	const char *data;
 };
 
 /**
@@ -708,6 +708,17 @@ void scene_highlight_first(struct scene *scn);
  */
 void scene_set_highlight_id(struct scene *scn, uint id);
 
+/**
+ * scene_img_set_data() - Set the image data for an image object
+ *
+ * @scn: Scene to update
+ * @id: ID of existing image obejct
+ * @data: Image data to use
+ * @size: Size of image data
+ * Returns: 0 if OK, -ENOENT if @id is invalid
+ */
+int scene_img_set_data(struct scene *scn, uint id, const void *data, int size);
+
 /**
  * scene_set_open() - Set whether an item is open or not
  *
diff --git a/include/video.h b/include/video.h
index 2fbf8a9598a..5b539eafb89 100644
--- a/include/video.h
+++ b/include/video.h
@@ -310,7 +310,7 @@ void video_sync_all(void);
  * @heightp: Returns height in pixels
  * @bpixp: Returns log2 of bits per pixel
  */
-void video_bmp_get_info(void *bmp_image, ulong *widthp, ulong *heightp,
+void video_bmp_get_info(const void *bmp_image, ulong *widthp, ulong *heightp,
 			uint *bpixp);
 
 /**
diff --git a/test/boot/expo.c b/test/boot/expo.c
index b025e48469f..239591ff6cd 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -262,6 +262,7 @@ static int expo_object_attr(struct unit_test_state *uts)
 	struct expo *exp;
 	ulong start_mem;
 	char name[100];
+	char image[10];
 	ofnode node;
 	char *data;
 	int id;
@@ -305,6 +306,11 @@ static int expo_object_attr(struct unit_test_state *uts)
 	ut_assertok(expo_setup_theme(exp, node));
 	ut_asserteq(30, txt->gen.font_size);
 
+	/* try setting up a fake image */
+	strcpy(image, "wibble");
+	ut_assertok(scene_img_set_data(scn, OBJ_LOGO, image, sizeof(image)));
+	ut_asserteq_str("wibble", img->data);
+
 	expo_destroy(exp);
 
 	ut_assertok(ut_check_delta(start_mem));
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa
