Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CFEC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 10:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2767D8784D;
	Sun, 14 Jan 2024 11:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZMRRivZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C31C87831; Sun, 14 Jan 2024 11:17:31 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F0687835
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 11:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e779f0253so468355e9.1
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705227448; x=1705832248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAxST3W/8SHkL1cYCYZKP36M4jXXvJRLVnSXLxunP5g=;
 b=kZMRRivZxQMn2WkJi48+xz3oa0Y9sw5gyi/+bc0aWwR/7lHjHcxMuM9OG7Ba8uA0pk
 RC1eBirfD8JLN1rRDLpYMJxVfJkFIsa0LYh6AlBmQ8a1qSdkbeyLhOzkzrfx0bvBwgN6
 GL7o9IVRhLuzRuqq4glGfIaQdRiutuQDYg3MLtn2P2lKCpcEri4LQaGQsZeFMWSxvzx+
 ldfRD5QgrWp72wOKUlLle4HDnLYrBzOsA1TOoHqHL0BJ1iLjx4jGV2YyM+cMD0vicI0u
 YpJgTnOitZZla8kaApuHptiBGTTjLcBhfxyKVjUuXqyhaJSoCEBwl6cYDQ+NYAoRDHUA
 Cjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705227448; x=1705832248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAxST3W/8SHkL1cYCYZKP36M4jXXvJRLVnSXLxunP5g=;
 b=nXVLHGNPH+WNG4/2TCQEWf+bQY5VtKDFz8qQHbbXoma/1doo/0YcaiM51ega+Nco1W
 EEDJildIjtRJY4NJkqqCUI9nup59T6T+M6/ERhbP8Yvg3LTfNreoa1DD67zgzwXTj3j6
 I5Kx/c9245rXDhZH88HVvW37X9sobc8LoH0fxeM33nfe7VB9CRMGfGYzh5GaEp3WN/RX
 bxJVjkcSkJO3zhEiPcJlWHqbMP98oe8XuShnkk7dZvZbyKFZG98ARYpnZsfstLhXiRtq
 J59PypVVs/njOkcCn1hLRll5Yfz+pATvcH7Z3qN4WyaTCtwOY4jhoh4qL3YgQW3nB9GX
 l0sA==
X-Gm-Message-State: AOJu0YxDXsQNKNh0ToZ+dLoSe2m+6aYPDKNSRLsXWYkRY5k8r5/9vLD8
 lRsl40nL9p3H5/kCxWyfkzzHfCS3WXq6UiNk
X-Google-Smtp-Source: AGHT+IFity8kZ0XwQm7YqNxXRGPu9k8J8DTTqYHkG4Rf/6QE8oTBvRwZFxnr0VF9DR4efE5WSlCGTA==
X-Received: by 2002:a05:600c:4709:b0:40e:4db3:f7a7 with SMTP id
 v9-20020a05600c470900b0040e4db3f7a7mr2639438wmo.110.1705227447841; 
 Sun, 14 Jan 2024 02:17:27 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 cf12-20020a170906b2cc00b00a28116285e0sm3906165ejb.165.2024.01.14.02.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 02:17:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] cmd: bootmenu: rename U-Boot console to Exit
Date: Sun, 14 Jan 2024 12:17:01 +0200
Message-Id: <20240114101701.23070-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240114101701.23070-1-clamor95@gmail.com>
References: <20240114101701.23070-1-clamor95@gmail.com>
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

It seems that the U-Boot console entry of the bootmenu has lost
its original meaning. Now, even if it is chosen, the probability
that you will enter the actual U-Boot console is quite low.
Boot env, bootflow, bootcommand script may appear, but not the
actual console. Hense, let's remove ambiguity and name this
entry by what it actually does: 'Exit' the bootmenu.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 cmd/bootmenu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index 987b16889f..69fca710a8 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -119,7 +119,7 @@ static char *bootmenu_choice_entry(void *data)
 				iter = iter->next;
 			return iter->key;
 		case BKEY_QUIT:
-			/* Quit by choosing the last entry - U-Boot console */
+			/* Quit by choosing the last entry - Exit */
 			iter = menu->first;
 			while (iter->next)
 				iter = iter->next;
@@ -361,15 +361,15 @@ static struct bootmenu_data *bootmenu_create(int delay)
 	}
 #endif
 
-	/* Add U-Boot console entry at the end */
+	/* Add Exit entry at the end */
 	if (i <= MAX_COUNT - 1) {
 		entry = malloc(sizeof(struct bootmenu_entry));
 		if (!entry)
 			goto cleanup;
 
-		/* Add Quit entry if entering U-Boot console is disabled */
+		/* Add Quit entry if exiting to U-Boot console is disabled */
 		if (!IS_ENABLED(CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE))
-			entry->title = strdup("U-Boot console");
+			entry->title = strdup("Exit");
 		else
 			entry->title = strdup("Quit");
 
@@ -532,7 +532,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 		title = strdup(iter->title);
 		command = strdup(iter->command);
 
-		/* last entry is U-Boot console or Quit */
+		/* last entry is Exit or Quit */
 		if (iter->num == iter->menu->count - 1) {
 			ret = BOOTMENU_RET_QUIT;
 			goto cleanup;
-- 
2.40.1

