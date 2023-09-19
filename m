Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1CCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFA286C58;
	Tue, 19 Sep 2023 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FB0793rR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EC986C48; Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ECF86C33
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso208378539f.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146989; x=1695751789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er3M4kFL4DXI6sJTY7uYhJT6emwo5F0kjoeW5H5T8bw=;
 b=FB0793rRYxwGNM2HF8Gfyqq3tpDvn0sxu5VuzjT+8nsCDcTEdaDBiEsIxdyV6yRfqO
 c0JLi9K3cxUIaz/68lNF4OovdHzkrrufM/T9+tRysiqe3nb8Igqvw9weREXrj6cr5xuK
 7Dn9XtRYN+fXNCiLPTJ+2KTabn378//sowbK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146989; x=1695751789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er3M4kFL4DXI6sJTY7uYhJT6emwo5F0kjoeW5H5T8bw=;
 b=BjK6eJSeIsNqBCyIcFNVU9smXIgvIeC2Tgw+kkOeAc0YyIiZ9jm7or6cbGb38eOrwp
 lOM38FAoUGD5DIFBrrgQk6Gm96NXV8c88P7NKyHDdSAmnyA1Aji687Khhjwe9vEoCTNA
 3qbLTm906kWjkrQDFpbKF/rmzgG+RngatlnP86C+aGNRseafV/gzSQRtXfIBGp/SsQ8h
 WitdqCQfGl0mjVTevVkHeF47r5RtjgDpdgflED62VdIoG/mWoubmQwrt9JagRuCx/CIS
 bIws5BZpX7i+fay0F5gSGuB5hUJhaWTyxXEVmeODcQ6//42H9m9FY/jx73ef751rlf+t
 H8/g==
X-Gm-Message-State: AOJu0Yy5q+XHQ/1rQ6U+LeVIOTpP5tlRXwu1iPtcI/55hTfuF8Pnes6d
 Xn5cEXHxS9ZUtjHC9j9qp1OetmrCdc3i/eTGe5E=
X-Google-Smtp-Source: AGHT+IFyczvGw8xuwIkIXqGRc0MEwhsTA1xcqd0PpDn7d2WKgzrDVz+8sDXMAyWnybFx9pgV97G5lQ==
X-Received: by 2002:a92:c24c:0:b0:345:fbdc:bb78 with SMTP id
 k12-20020a92c24c000000b00345fbdcbb78mr711659ilo.29.1695146988812; 
 Tue, 19 Sep 2023 11:09:48 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 27/36] expo: Add some scene fields needed for text entry
Date: Tue, 19 Sep 2023 12:08:57 -0600
Message-ID: <20230919180918.2904313-28-sjg@chromium.org>
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

Add the CLI state, a buffer to hold the old value of the text being
edited and a place to save vidconsole entry context. These will be use
by the textline object.

Set an upper limit on the maximum number of characters in a textline
object supported by expo, at least for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c   | 10 ++++++++++
 include/expo.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 314dd7c6e84..0b44a13748a 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -32,6 +32,14 @@ int scene_new(struct expo *exp, const char *name, uint id, struct scene **scnp)
 		return log_msg_ret("name", -ENOMEM);
 	}
 
+	abuf_init(&scn->buf);
+	if (!abuf_realloc(&scn->buf, EXPO_MAX_CHARS + 1)) {
+		free(scn->name);
+		free(scn);
+		return log_msg_ret("buf", -ENOMEM);
+	}
+	abuf_init(&scn->entry_save);
+
 	INIT_LIST_HEAD(&scn->obj_head);
 	scn->id = resolve_id(exp, id);
 	scn->expo = exp;
@@ -57,6 +65,8 @@ void scene_destroy(struct scene *scn)
 	list_for_each_entry_safe(obj, next, &scn->obj_head, sibling)
 		scene_obj_destroy(obj);
 
+	abuf_uninit(&scn->entry_save);
+	abuf_uninit(&scn->buf);
 	free(scn->name);
 	free(scn);
 }
diff --git a/include/expo.h b/include/expo.h
index b192d55665a..c470f5be34d 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -7,11 +7,14 @@
 #ifndef __EXPO_H
 #define __EXPO_H
 
+#include <abuf.h>
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 
 struct udevice;
 
+#include <cli.h>
+
 /**
  * enum expoact_type - types of actions reported by the expo
  *
@@ -121,6 +124,9 @@ struct expo_string {
  * @id: ID number of the scene
  * @title_id: String ID of title of the scene (allocated)
  * @highlight_id: ID of highlighted object, if any
+ * @cls: cread state to use for input
+ * @buf: Buffer for input
+ * @entry_save: Buffer to hold vidconsole text-entry information
  * @sibling: Node to link this scene to its siblings
  * @obj_head: List of objects in the scene
  */
@@ -130,6 +136,9 @@ struct scene {
 	uint id;
 	uint title_id;
 	uint highlight_id;
+	struct cli_line_state cls;
+	struct abuf buf;
+	struct abuf entry_save;
 	struct list_head sibling;
 	struct list_head obj_head;
 };
@@ -180,6 +189,11 @@ enum scene_obj_flags_t {
 	SCENEOF_OPEN	= 1 << 2,
 };
 
+enum {
+	/* Maximum number of characters allowed in an line editor */
+	EXPO_MAX_CHARS		= 250,
+};
+
 /**
  * struct scene_obj - information about an object in a scene
  *
-- 
2.42.0.459.ge4e396fd5e-goog

