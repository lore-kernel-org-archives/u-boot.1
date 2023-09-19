Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC73CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A7186C78;
	Tue, 19 Sep 2023 20:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E6YaIR1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D02786C0E; Tue, 19 Sep 2023 20:09:57 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8681586BE6
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-350f43b9c3dso1389525ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146994; x=1695751794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGQSJPqCxJK/D36IFr8M78pOWZei9BxM9u4DkLBjcxU=;
 b=E6YaIR1XGaD8kviSEMll1gkpE8YMN5hsWlGioUIBMhOBj7RZ6zOlMxcRsCN0uE5S+d
 d4sJ/NyYSguMEs6BZBKo7fcMIdAe5Ya1uJ03jU2HGsUGKMmLmtZ57fNNe/6TyryyhFSj
 C9SdCqXv9dZpyXu+GvObRevux2MQCXMHDb2IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146994; x=1695751794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGQSJPqCxJK/D36IFr8M78pOWZei9BxM9u4DkLBjcxU=;
 b=UbgBzmh9RWxNwQ/im2k7SyTS5W6IPqM29D0rgCHKRAsjehZl2KeDdpUQGPXUj33ysb
 hHYg5QHlNUM7bl8H4SUDlaTf5u+W3rGh0/p7QsixWU2T3NfrMXbRQp4Q7M25VQoCgKdZ
 SHX7Z+GD4s8ZS8lm1NR4sZT7XRSxNYBO6GOlViN697fh4nacRJZx149k+FSoNxghfd2I
 UOT+6Vh0XVNvO6alyUytP5gQ8JwEB2NdfsJ+rP/aEUZa15WtbKSR/sl43XsM7rEsvHkX
 H8QMZ7pFh9jLdAzKu3JGNT52I7t/VDzK4Xdr9bGGGjG20yHkrjVu31o22Uymp9aV0lLg
 S7nA==
X-Gm-Message-State: AOJu0YxU/7hB5frca2zrjYgK/JDS5v2h3KIQS75Z5Ouv3TkcfSIi592a
 JUjLb2GDOkunWREkb5jPNziii0gxRQ7vXLHsvXw=
X-Google-Smtp-Source: AGHT+IF1JocitQvErZcTRKQv+J90i95nPFwvcJKZo/k6dzHfe9ZOFlhtIMoSdYo7bz8VoZ8AIHDuRg==
X-Received: by 2002:a05:6e02:130f:b0:34c:ebe8:9900 with SMTP id
 g15-20020a056e02130f00b0034cebe89900mr565122ilr.3.1695146994242; 
 Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 34/36] expo: Support building an expo with a textline
Date: Tue, 19 Sep 2023 12:09:04 -0600
Message-ID: <20230919180918.2904313-35-sjg@chromium.org>
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

Add textline to the list of objects which tthe expo builder can build.
This allows them to be provided in the description.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo_build.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 48ed31d5b32..95dd7463c84 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -287,6 +287,49 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 	return 0;
 }
 
+static int textline_build(struct build_info *info, ofnode node,
+			  struct scene *scn, uint id, struct scene_obj **objp)
+{
+	struct scene_obj_textline *ted;
+	uint ted_id, edit_id;
+	const char *name;
+	u32 max_chars;
+	int ret;
+
+	name = ofnode_get_name(node);
+
+	info->err_prop = "max-chars";
+	ret = ofnode_read_u32(node, "max-chars", &max_chars);
+	if (ret)
+		return log_msg_ret("max", -ENOENT);
+
+	ret = scene_textline(scn, name, id, max_chars, &ted);
+	if (ret < 0)
+		return log_msg_ret("ted", ret);
+	ted_id = ret;
+
+	/* Set the title */
+	ret = add_txt_str(info, node, scn, "title", 0);
+	if (ret < 0)
+		return log_msg_ret("tit", ret);
+	ted->label_id = ret;
+
+	/* Setup the editor */
+	info->err_prop = "edit-id";
+	ret = ofnode_read_u32(node, "edit-id", &id);
+	if (ret)
+		return log_msg_ret("id", -ENOENT);
+	edit_id = ret;
+
+	ret = scene_txt_str(scn, "edit", edit_id, 0, abuf_data(&ted->buf),
+			    NULL);
+	if (ret < 0)
+		return log_msg_ret("add", ret);
+	ted->edit_id = ret;
+
+	return 0;
+}
+
 /**
  * obj_build() - Build an expo object and add it to a scene
  *
@@ -316,6 +359,8 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 
 	if (!strcmp("menu", type))
 		ret = menu_build(info, node, scn, id, &obj);
+	else if (!strcmp("textline", type))
+		ret = textline_build(info, node, scn, id, &obj);
 	else
 		ret = -EOPNOTSUPP;
 	if (ret)
-- 
2.42.0.459.ge4e396fd5e-goog

