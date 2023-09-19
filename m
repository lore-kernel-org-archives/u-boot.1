Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02ACE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055DD86C22;
	Tue, 19 Sep 2023 20:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lO2glawB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB0886C1E; Tue, 19 Sep 2023 20:09:46 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D13A86BE1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34f68fe0944so20928255ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146982; x=1695751782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tROP6EQIWq9nw+l80hGZyfAmW8x8IXHXYimznruf3BY=;
 b=lO2glawBw5hQZiytDc6PJEc7HADAKyMLTVLnAXuM/zeRkB8Bsy52iaqGB2VxkX1FDL
 4fYBSXFPURt1D6mSLfj08ITUI3cLQCfLjiyfU0zWx0uwFtHUNcCkf2PIklupXqq68ToQ
 ph8/Hf7fLn9lmGxNVMr2rMF8IVmSg5R9O8gak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146982; x=1695751782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tROP6EQIWq9nw+l80hGZyfAmW8x8IXHXYimznruf3BY=;
 b=h9ZdpaK3kF3f9SbOVbNF+fx91qQaaTcFkJrCbL4YAfnq/Hhq+ZvcBM0b0ZCGP/rt1c
 7OCEru1+uw+tyGtMN6scALw++974grI/p/rHzSm4GcUVkbWaFdbCNaCnR5giy6H1aa44
 7GAA1Fm1qWUBoiocVAZ71A6iy2zBdijsA0m78S4pizUMFgbyFGJif1C954W/umWZxhEy
 BmgTSZCAG5f4samsIpPPSLRKDMU+k7d+v6i0N0TMux8ZfLuWU8z/kbnnm+gPC2i8zj7v
 EEHIhT5umpVUi8NqZOgORddUObJkFyEocwpPxEPDzghdEbCGb6owvJTKAQRexdZqUdHb
 fTqw==
X-Gm-Message-State: AOJu0Ywnv4Ab2pdNr5JeBaOr2wDOGdujr8rL4cxM0RE/vjU/XMiBUyS0
 UXjaJ0fSIuA9YpvLObnBX7J+kaoa9j3o3IqnBQg=
X-Google-Smtp-Source: AGHT+IHbM3tS1RbmnAfD98xhGRUnzSPqYPHIqJ+2PGTh7PVZeHIdWo8qbLlJPMu5voHPXgi7J2TyBg==
X-Received: by 2002:a05:6e02:1aa5:b0:34f:f0d9:5a1c with SMTP id
 l5-20020a056e021aa500b0034ff0d95a1cmr716834ilv.15.1695146982772; 
 Tue, 19 Sep 2023 11:09:42 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/36] expo: Fix up comments for get_cur_menuitem_text() et al
Date: Tue, 19 Sep 2023 12:08:49 -0600
Message-ID: <20230919180918.2904313-20-sjg@chromium.org>
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

This internal function could use a comment. Add one.

Also tidy up a few other comments.

Signed-off-by: Simon Glass <sjg@chromium.org>

fixup: comments
---

 boot/cedit.c          | 10 ++++++++++
 boot/scene_internal.h |  2 +-
 include/expo.h        |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 73645f70b6c..1324a861998 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -229,6 +229,16 @@ static int check_space(int ret, struct abuf *buf)
 	return 0;
 }
 
+/**
+ * get_cur_menuitem_text() - Get the text of the currently selected item
+ *
+ * Looks up the object for the current item, finds text object for it and looks
+ * up the string for that text
+ *
+ * @menu: Menu to look at
+ * @strp: Returns a pointer to the next
+ * Return: 0 if OK, -ENOENT if something was not found
+ */
 static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
 				 const char **strp)
 {
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 695a907dc6a..42efcee092f 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -185,7 +185,7 @@ int scene_render_deps(struct scene *scn, uint id);
  * Renders the menu and all of its attached objects
  *
  * @scn: Scene to render
- * @menu: Menu render
+ * @menu: Menu to render
  * Returns: 0 if OK, -ve on error
  */
 int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu);
diff --git a/include/expo.h b/include/expo.h
index a2b3a71c159..297d892de8e 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -505,7 +505,7 @@ int scene_txt(struct scene *scn, const char *name, uint id, uint str_id,
 	      struct scene_obj_txt **txtp);
 
 /**
- * scene_txt_str() - add a new string to expr and text object to a scene
+ * scene_txt_str() - add a new string to expo and text object to a scene
  *
  * @scn: Scene to update
  * @name: Name to use (this is allocated by this call)
-- 
2.42.0.459.ge4e396fd5e-goog

