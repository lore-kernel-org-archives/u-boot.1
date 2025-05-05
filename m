Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88974C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E28B82991;
	Mon,  5 May 2025 17:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hV8CeBtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829F482153; Mon,  5 May 2025 17:44:12 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79541828A2
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so3542129a12.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459846; x=1747064646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icW0A0+vUl9bYFzVWZEaH1IfVwkhIgtOn7rDI8p/DBY=;
 b=hV8CeBtQMhg0pNRCEVzHcUTeilOBXlD9U4VMIyCvctv0eU8Sd+vhxLKQhL8L/eikO+
 m9nyeAq7tlaSB6iD0PJ4JyywIFkDZpXpItGJxbrikhQxzGI8Es4iA1mHQ9G37D7DrW1f
 N5awwW6lPSmETN17zVYqJanVpFe2gZ3b+ebJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459846; x=1747064646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icW0A0+vUl9bYFzVWZEaH1IfVwkhIgtOn7rDI8p/DBY=;
 b=bUAOqCVRZWg5/uC3wes6bYnNG/wDWde2DCQOnkc50ckH6GzYiBJgV/TI3jATYsIdzq
 IytCQ3sB3km2Y52zfabMRvIOhOUM2gLewPaBM02DaqkFL6OuTRO03mw1xI6Suevt9vH2
 SAQtUg1tSuaKUDEQ3UT3hgRLerDi8xFcokf3jq5CXhwPCQhQMzB8vwjYMbqODBmVhcHh
 530TPXK+rDaknIK7jYFUgCJVqSJqXqmBakl52ctnNAoD/50obwk8GS21+BxGjxLgx4BC
 9QZyCBt1kTmJYYlFi5nusxqGYgTjCpDDvYR2nSsNv/ffqsrt1LK1bynBGPzDuoMY+YdB
 rtcQ==
X-Gm-Message-State: AOJu0YwXSOtYtUAC6nlWtDL3ksUQCBPcF+8jktKc/Pn5bHPKuB4wIpnZ
 XFt5utb3D/OgUV/wgZjbdm3yBJMAFf70WFBWe8GeenxEz0B14zlSazXmtZQCM7EIEiuc6X011F1
 vKgLU9yk=
X-Gm-Gg: ASbGnctu8h1qOe6ThC/iJ8dTe0EJnS6W+sZV8YIzTZtmi/Uv2TQ2iXNxIGiCuqiTATz
 kXKsW5By3mRxnJSb9Md9m1/tmurVN0x/vc24z9h65yqGN/a4d4zCrPwkj+Ky0ZmsgbtSjMnIm+8
 WSRi7/8dfTxLLcjOMujn4aheFusdHDh2zA//Lm0jsxS+QeBwlColz+ofu31OCECV/6AjLIDonFY
 nW13+B5NaX8QfxO36Du+TAIa+WhjLwBGLZGkfsb2yvFJuxIlVZnOOqgd2M9LibvLUTQy9j4ALCr
 vah6yPf8iO6PVzwGHqYdzfjUdgOaIY/2OVAgG7/dEYCcDkM=
X-Google-Smtp-Source: AGHT+IHJyIBTcCbux1W2Mirl1S3FdW4Ws5SwyKJUjn1lF/dSnL2/9EKAEkN5j6OiRHR4TH/q/S+ACQ==
X-Received: by 2002:a05:6402:1e8f:b0:5f3:fbb4:b258 with SMTP id
 4fb4d7f45d1cf-5faa7f502b3mr7109295a12.14.1746459846384; 
 Mon, 05 May 2025 08:44:06 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/19] expo: Provide a few functions for working with
 dimensions
Date: Mon,  5 May 2025 17:42:48 +0200
Message-ID: <20250505154308.2911248-11-sjg@chromium.org>
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

Allow expanding dimensions using the dimensions of an object or another
dimensions struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 20 ++++++++++++++++++++
 boot/scene_internal.h | 29 ++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 2ea8e30ad83..258161f27ce 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -1219,3 +1219,23 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
 
 	return 0;
 }
+
+void scene_dims_join(struct scene_obj_dims *src, struct scene_obj_dims *dst)
+{
+	dst->x = max(dst->x, src->x);
+	dst->y = max(dst->y, src->y);
+}
+
+int scene_dims_union(struct scene *scn, uint id, struct scene_obj_dims *dims)
+{
+	struct scene_obj *obj;
+
+	if (!id)
+		return 0;
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("obj", -ENOENT);
+	scene_dims_join(&obj->dims, dims);
+
+	return 0;
+}
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 04218b4b911..f9b30caa208 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -16,6 +16,7 @@ struct expo_action;
 struct expo_arrange_info;
 struct expo_theme;
 struct scene_obj;
+struct scene_obj_dims;
 struct scene_obj_menu;
 struct scene_obj_textline;
 struct scene_obj_txtedit;
@@ -325,7 +326,7 @@ struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
 					      int val);
 
 /**
- * scene_bbox_join() - update bouding box with a given src box
+ * scene_bbox_join() - update bounding box with a given src bbox
  *
  * Updates @dst so that it encompasses the bounding box @src
  *
@@ -338,11 +339,11 @@ int scene_bbox_join(const struct vidconsole_bbox *src, int inset,
 		    struct vidconsole_bbox *dst);
 
 /**
- * scene_bbox_union() - update bouding box with the demensions of an object
+ * scene_bbox_union() - update bounding box with the bbox of an object
  *
  * Updates @bbox so that it encompasses the bounding box of object @id
  *
- * @snd: Scene containing object
+ * @scn: Scene containing object
  * @id: Object id
  * @inset: Amount of inset to use for width
  * @bbox: Bounding box to update
@@ -351,6 +352,28 @@ int scene_bbox_join(const struct vidconsole_bbox *src, int inset,
 int scene_bbox_union(struct scene *scn, uint id, int inset,
 		     struct vidconsole_bbox *bbox);
 
+/**
+ * scene_bbox_join() - update dimensions with a given src dimensions
+ *
+ * Updates @dst so that it encompasses the dimensions of @src
+ *
+ * @src: Input dimensions
+ * @dst: Dimensions to update
+ */
+void scene_dims_join(struct scene_obj_dims *src, struct scene_obj_dims *dst);
+
+/**
+ * scene_dims_union() - update dimensions with the dimensions of an object
+ *
+ * Updates @dims so that it encompasses the dimensions of object @id
+ *
+ * @scn: Scene containing object
+ * @id: Object id
+ * @dims: Dimensions to update
+ * Return: 0 if OK, -ve on error
+ */
+int scene_dims_union(struct scene *scn, uint id, struct scene_obj_dims *dims);
+
 /**
  * scene_textline_calc_dims() - Calculate the dimensions of a textline
  *
-- 
2.43.0

