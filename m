Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF8EE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CDE87130;
	Mon,  2 Oct 2023 03:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IPSf6ma9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E69870FC; Mon,  2 Oct 2023 03:14:29 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69638711B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so476427139f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209249; x=1696814049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pvE1ljUbvbgdfNxmAL4G3HbixTLLfaVQap2vIp/V60=;
 b=IPSf6ma9qWLFNnkXtWnYcTgyORcncT8g3dVW+RDx/vmgdt6NXt2OiyYa8wnjim8azo
 spmxw6uwEkfQt7UdA4cpmT92Ot25jTLb4Z2r4eI2C7cYMxWrvHIcp3XIp/A42Hi0V6NV
 DcYEfY/JrFH9dM5dFKqJo9AyaZhN12dvWD1q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209249; x=1696814049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pvE1ljUbvbgdfNxmAL4G3HbixTLLfaVQap2vIp/V60=;
 b=a6ToTf3X+lRDaR5bYa/LnBb3rLWtOHG+i3+t7w+WPsaqlwkoVKWdfuBPC0l+2hrbV5
 wMiA0ijN+6Kur7mzK7nAo67lfbwfB7ouL06QHNI3U1nhV7dgASA0zGMKdEw7Nj2515Ql
 owD6e+zYwD4Nay8VrF97U8QwsIPaSuWGsEt77VxdzUle4TGq3yQqDzLZGUTjJXJp3ks0
 w3sOQJUp/PoCmw0G0OW52mj8yHZQLbRBFo9/eVy1j1/QGvk5tH6ZbJmIpII+V3Gp2xSp
 CTZaH/5RGL2pywTPlcP9uD0WT5a4WHxaBMReThcowNacFmo37n4/lXSdNjewc8Uu01OI
 DmDg==
X-Gm-Message-State: AOJu0YzLHYLabCR+Fjj8J4/1MZpR7ML6d/04tTnmxIXWZU0qoQkSneGj
 dURmIq4A3kRrWEVyzg2dBCup/r4UE56tNzu8C3I=
X-Google-Smtp-Source: AGHT+IHwzTUbSBCX+9b0dT0R4owmVGQXaFrXUBcPYCc3LPl632psMAiuSiaHKXqYaSFKvxEsfs0hUA==
X-Received: by 2002:a6b:dc02:0:b0:79f:ce11:c1b0 with SMTP id
 s2-20020a6bdc02000000b0079fce11c1b0mr11750862ioc.6.1696209249475; 
 Sun, 01 Oct 2023 18:14:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/36] expo: Fix up comments for get_cur_menuitem_text() et
 al
Date: Sun,  1 Oct 2023 19:13:23 -0600
Message-ID: <20231002011349.461284-20-sjg@chromium.org>
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

This internal function could use a comment. Add one.

Also tidy up a few other comments.

Signed-off-by: Simon Glass <sjg@chromium.org>

fixup: comments
---

(no changes since v1)

 boot/cedit.c          | 10 ++++++++++
 boot/scene_internal.h |  2 +-
 include/expo.h        |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 73645f70b6cb..1324a8619981 100644
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
index 695a907dc6af..42efcee092f3 100644
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
index a2b3a71c1591..297d892de8e7 100644
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
2.42.0.582.g8ccd20d70d-goog

