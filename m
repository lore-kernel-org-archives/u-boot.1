Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ABCE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CABB4871AA;
	Mon,  2 Oct 2023 03:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fPAfavCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5A870DC; Mon,  2 Oct 2023 03:14:54 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0600F8711C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so476430939f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209257; x=1696814057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar8Ce1tpQk1ZM4KWvkd5rE3YGcZlRDYstSChAFKIZB4=;
 b=fPAfavCZkK+fX2Wysh0Sq4lLvYLdL7+h1fiPHYtQhPzMWTLec+MgK4oei8U4T3W4wp
 NNdlUfb4eOz0B/AzaohSW5GIDGGRN6pBrxjeHZ+MM4ZhtBQy9w0uv+3YBmY/2hGSstM4
 eT8VtWIV7GPvZuO4SfAp2haUrjRL8MHS93ies=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209257; x=1696814057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar8Ce1tpQk1ZM4KWvkd5rE3YGcZlRDYstSChAFKIZB4=;
 b=JwcLVWkUKNcX/FwYlIJWz5WfZrVaap49cHFlXzLNfe2L/v1sbXKdaiJ7AK+7wdJ8U4
 V0FM7nuTp4fj/bPb1nQmrbcYuTzUOrY0wLxpqiSS0b8wz2dXhJ2MPDXnT18FE69kMZpS
 DWkMlee5rD/LCQvLvqsU+5rUT5qUAXSQYwDn8CLnmLG/w5kToJwoiHOb0hDsr7L8CDY6
 pMZUg2Ay/ABRx7gGUUNcYt33000+F8WCaUIhRygAmxTgN+ke8Oxai5BkcTLwIhLVZ4FN
 dLp45RpG6UYN9Xn4FhE2kYjGbfTyllF9EyF7fuXEz0GPzBSnYIMtG8oNb/GF0Z7KC6ll
 FnuA==
X-Gm-Message-State: AOJu0Yyvenl6ei739tvb2v2W80KVGgJihdDhZKzXfPAKTrLFULCLmsH+
 aJpnrp4TN80kY74N0w4TXeM5Dta837jbCiJVqYY=
X-Google-Smtp-Source: AGHT+IE6BrlZb2N1duPbGU4/KlVaxaGZt9i21uqC56L//Bk+H2NZg27Zlq0vHWMTMTrnGREMJFXQNQ==
X-Received: by 2002:a6b:ea15:0:b0:79e:4abd:7be3 with SMTP id
 m21-20020a6bea15000000b0079e4abd7be3mr10959672ioc.15.1696209257639; 
 Sun, 01 Oct 2023 18:14:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 29/36] expo: Support opening a textline
Date: Sun,  1 Oct 2023 19:13:33 -0600
Message-ID: <20231002011349.461284-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

(no changes since v1)

 boot/scene.c          | 32 ++++++++++++++++++++++++++++++++
 boot/scene_internal.h | 22 ++++++++++++++++++++++
 boot/scene_textline.c |  5 -----
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 0b44a13748ab..6c7c926f7c93 100644
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
index 1c2bfeadcd38..7a84977646a0 100644
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
index 2caa81ee1582..6ea072a1c268 100644
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
2.42.0.582.g8ccd20d70d-goog

