Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2BECE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A9D86C66;
	Tue, 19 Sep 2023 20:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iIg52QYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C8B86BE1; Tue, 19 Sep 2023 20:09:54 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085E386C3E
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fe09b3586so7764785ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146990; x=1695751790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eTCX0uaUmOgunpKgcozQWeXSe8cuydhc5PvMECearg=;
 b=iIg52QYPQwiYn5ShSnK1Gv/xpUCyzt3/e6CMTCJjiEKIYNScMWngvzZ3/cBbCQvCoV
 U7gtMi93V9ZFVv0E9Zzox8M7ZYmaboGinFAPGo38UJcZIA3uShC4I4w613s8NBv4YOTy
 yH+KtdU3SwsQlvF8atsTXvlcDNCeEfrsTAz7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146990; x=1695751790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eTCX0uaUmOgunpKgcozQWeXSe8cuydhc5PvMECearg=;
 b=VxBlHz6kD46SAZcoQSXVOCnMlf8Y4Yy8J2lw15z9y26yhTgz/sjuEcM/cEQVeXZfVc
 tu6Uja25iZ5HyPmvefS57x8C+1q6nv/zrDZ+SXDHBnOGHPyMcgeqthQhePX1fxrK/Co/
 mmppJLZ2m16tSjH+sSF/+T+BA9iE5hlMfdfYhkbu+wsDWJlo+xUTuFQK78Ku/Xfz+bZm
 WlbWhYzVq3Q54VjFzlrtJW4Uf/DqT92EC2IITSNgnN1j1YilrpqOXE7FBH/rbGmwjEta
 C/YdQzNeiYSfZ9djnL7lwM98GNPoOI73bVMOqY+/Ps4mHvmV/w35sGQHA35xRlJnz+Mo
 AE3Q==
X-Gm-Message-State: AOJu0Yw2zL75s6JWx79QegBE9p/lXaF2HtHMaDwxQu9p5xJGC6dWJca0
 CNmcWUYdtuezttC5Aeml5uKf5Td8Ha7DLCY9A9o=
X-Google-Smtp-Source: AGHT+IHyO0LsI03zRVHYvPqj7lJp6jMjVzSLOXF8BRjLOwu7+6GhoyWgLPBX+IF7ljkD9Exqd1ZItQ==
X-Received: by 2002:a05:6e02:f0f:b0:34f:7e1b:a7a2 with SMTP id
 x15-20020a056e020f0f00b0034f7e1ba7a2mr525458ilj.13.1695146990582; 
 Tue, 19 Sep 2023 11:09:50 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 29/36] expo: Support opening a textline
Date: Tue, 19 Sep 2023 12:08:59 -0600
Message-ID: <20230919180918.2904313-30-sjg@chromium.org>
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

This object needs special handling when it is opened, to set up the CLI
and the vidconsole context. Add special support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 32 ++++++++++++++++++++++++++++++++
 boot/scene_internal.h | 22 ++++++++++++++++++++++
 boot/scene_textline.c |  5 -----
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 0b44a13748a..6c7c926f7c9 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -759,10 +759,42 @@ void scene_highlight_first(struct scene *scn)
 	}
 }
 
+static int scene_obj_open(struct scene *scn, struct scene_obj *obj)
+{
+	int ret;
+
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_MENU:
+	case SCENEOBJT_TEXT:
+		break;
+	case SCENEOBJT_TEXTLINE:
+		ret = scene_textline_open(scn,
+					  (struct scene_obj_textline *)obj);
+		if (ret)
+			return log_msg_ret("op", ret);
+		break;
+	}
+
+	return 0;
+}
+
 int scene_set_open(struct scene *scn, uint id, bool open)
 {
+	struct scene_obj *obj;
 	int ret;
 
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("find", -ENOENT);
+
+	if (open) {
+		ret = scene_obj_open(scn, obj);
+		if (ret)
+			return log_msg_ret("op", ret);
+	}
+
 	ret = scene_obj_flag_clrset(scn, id, SCENEOF_OPEN,
 				    open ? SCENEOF_OPEN : 0);
 	if (ret)
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 1c2bfeadcd3..7a84977646a 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -278,4 +278,26 @@ void scene_menu_calc_bbox(struct scene_obj_menu *menu,
 int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
 			struct vidconsole_bbox *label_bbox);
 
+/**
+ * scene_textline_open() - Open a textline object
+ *
+ * Set up the text editor ready for use
+ *
+ * @scn: Scene containing the textline
+ * @tline: textline object
+ * Return: 0 if OK, -ve on error
+ */
+int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline);
+
+/**
+ * scene_textline_close() - Close a textline object
+ *
+ * Close out the text editor after use
+ *
+ * @scn: Scene containing the textline
+ * @tline: textline object
+ * Return: 0 if OK, -ve on error
+ */
+int scene_textline_close(struct scene *scn, struct scene_obj_textline *tline);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 2caa81ee158..6ea072a1c26 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -227,8 +227,3 @@ int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline)
 
 	return 0;
 }
-
-int scene_textline_close(struct scene *scn, struct scene_obj_textline *tline)
-{
-	return 0;
-}
-- 
2.42.0.459.ge4e396fd5e-goog

