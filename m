Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E07AC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395DA82163;
	Wed, 19 Mar 2025 15:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EVGVqhKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A426882115; Wed, 19 Mar 2025 15:56:39 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC51782169
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a823036so43401325e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396197; x=1743000997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6EXakLFQcHZQoTyFCXAbJzuhukepxES4/Wb2eKD2CE=;
 b=EVGVqhKZl+uDtJTk9aVKg1v/LR8gid32yqSK6BNEQhQYKLJEgaCrpYSh/R2JSU/nNS
 kfb4y/MA3wBdiI8fzFvPnWkGsBk+XYrHxr0Lc3evXxYooNu7lQLj1wy54M8TP+lnZixb
 +5aisILPZUMnVW2mXWXiUAvQZoomNPyvgqUGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396197; x=1743000997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6EXakLFQcHZQoTyFCXAbJzuhukepxES4/Wb2eKD2CE=;
 b=pO6WnJhJFfeM3wbGpGOdkDFMzJDIsLhqFj2cIIMeUPzSyH8avCNuhzS6UgvnrWlH9R
 9KS/J9nck6xPqvhmveOmTcQV4m7adu+FKDcpKTtqguSafMCAaro3WpYEy9hkj584mBX4
 4AmodTTnYh18gZKR9mpvuH3MK/GXm3kJgY5cPUYpGOfxvc662DnHWyG28UiyugtzcQx6
 uY/QIWAF5c5KbB2Xrg7I5zGY1pMmF1euYSyZyMBK8SQZykRqkSmXRwhspJmJFtb9Lrk9
 53EbW/UKdfsxVvYfqr3VY8L6VxX61vodxGnnPZ2Q4Zh94FyppSh8jTn8f5DUguZzuOHH
 UKnA==
X-Gm-Message-State: AOJu0YwCKlxmRLSUwBYc2jrZBRhiguMCPp7Qd47HH5+YS6sSPzB+Bztm
 jKQEi/9pwsN+TpbLMMNrSfrufFPPaf7z8Irnr19gQtMqS1ktYYqxLastJgFz5cVlGIiFzc/+7Sg
 =
X-Gm-Gg: ASbGncsPfWzIJWGbyOO6lqXxuf1Nvi+yH9g9XeYBXPg0bag6BszIftse/+HgOMOJgVM
 yX6lHz4r2K2QwTz7OyvO+rP3GVwKour+T63kisfnthKxk01yll0yoppgxfUPVnRFFDUBc0jzPsG
 s3Y1zOSwCtfqyjz+UXwqaey4FDSYdbm21pnToblSjdn51rorimVEWM6QuPBeNxwQMXHxBnjTBJ7
 RF8+qKm0ws9fSz4J6H9A8REmSe9yluvT/oP8J5mY6vq7HiJvlko5EEAi1r7BZJmgjVh3hm3FENN
 sHLwio5nuWst9J4YvnGxJZCWmSfbS761na2aHUE+YQ==
X-Google-Smtp-Source: AGHT+IFPCsdzLrur3orlR63v+SLeyXb+Yo51SibseGiyqJGsC2T+bS4JA1fb2wsKmJbFcLsJwllK/Q==
X-Received: by 2002:a05:600c:1d92:b0:43c:f184:2e16 with SMTP id
 5b1f17b1804b1-43d43782e19mr29002485e9.5.1742396196572; 
 Wed, 19 Mar 2025 07:56:36 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 37/52] expo: Support white-on-black in the theme
Date: Wed, 19 Mar 2025 15:54:42 +0100
Message-ID: <20250319145512.2391122-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Allow this setting to be controlled from the theme.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/expo.c b/boot/expo.c
index a0be1404f1c..4e855f60d84 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -277,6 +277,7 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 {
 	struct scene *scn;
 	struct expo_theme *theme = &exp->theme;
+	bool white_on_black;
 	int ret;
 
 	log_debug("Applying theme %s\n", ofnode_get_name(node));
@@ -287,6 +288,9 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
 	ofnode_read_u32(node, "menu-title-margin-x",
 			&theme->menu_title_margin_x);
+	white_on_black = ofnode_read_bool(node, "white-on-black");
+	if (exp->display)
+		video_set_white_on_black(exp->display, white_on_black);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
 		ret = scene_apply_theme(scn, theme);
-- 
2.43.0

