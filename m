Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E283C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E35829C7;
	Mon,  5 May 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZiEgK5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638728295C; Mon,  5 May 2025 17:44:05 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1E28283E
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so7996418a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459837; x=1747064637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTahqJwhWR7omeM/u8eIeaCzmHxXZvju1oln8+g3qjo=;
 b=fZiEgK5X/CRZirH2dLYSAkW5bQZtGAWQ56Y+5ZXGhIZW9VJitzeH8Yd02ylD9HCOqo
 o3hV0RvfUg8JrCnYB8/bXEeJqSdqlLKyuVY5Snqh3WFlMkB6gX/1NGml38+MKqKdov8m
 xQEM3HfLSNgjHfRaRL0yAunxVuP1iy3YsTdWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459837; x=1747064637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTahqJwhWR7omeM/u8eIeaCzmHxXZvju1oln8+g3qjo=;
 b=jb2ngaY0xQb2h70RsCMMpSm1RKcY4VnaLRXKrhU/lomH7ofeb1ps5B1liCWdJZIwyk
 UbvGWJzPhBPmSyeuMNizr3KreHJoVBDZz7Jfakp8Ng9FVJv5uptS97ReMVCDBNlZHbdw
 8w1ytKZ3mAr1GVYgWlZgQwEZBG4nMTRkKgZ4uVeLJaaU9Ykew1rZF2BCe3LZSDfFXYX1
 8Fypzm8yfPtWhUwlwzGdReFFpk23I8bJdaw1BN/nFclC7vB0SIcvOqn0zJA+KL4fIHIP
 o3YHTHXVIkkPqPa000mR+7BV/q2OsR4VeRtXjvUaiDMAlQliUDC4dfmJ5goT+3p9RP1U
 I+dg==
X-Gm-Message-State: AOJu0YxQXWNwY1ZDgMu1jqYMph/EqKogfM1t1Q98xjr+iDNXiwmJ8IT5
 1N8oubYfAyPYpkgZn1EDS1eW5YWhIbqcG78HKEF/yhNsuG6a2btZZ9mjuCYpu+BJdRsf7xtQmWH
 xYKFRy6Q=
X-Gm-Gg: ASbGnctE6zmsFoV9jbPVHjogDkmWf/vJHUgPuC9maWEbowWSYV6FUJTGjbsTrJ3CLiC
 9i1sx4NY4FXWhZrMPxb1bZ1N8RFa6aR6Vftl0go+AkhARWcRbLM/pvxQFUA0DM6Wbll3u/54WPk
 w3P7VSJMNZLbQ4tyjhRRrNk+1p6bbtXXFcdilyKoY/I+71Z07bDGvGI5rkHM+Sm7uUrk75qbKfb
 CoFkCzfx7v0UbLqjx35Ze/jY4RfePZ6DYOVS55o/COFQXwt/JZ8LhrEf/sLINIMMBgEYfXUMps1
 VhEYQr3+RplmJlmFynhl3KIFFv9+TjRleFhP
X-Google-Smtp-Source: AGHT+IGsAAyFc9TdwuPCEhwpeQomSuxZjR7kQ8JksAhlMJj664zdQtrxOcXXLMUoHuvNEJq//PFt0g==
X-Received: by 2002:a05:6402:1d51:b0:5f4:9017:c6a1 with SMTP id
 4fb4d7f45d1cf-5fab05c2703mr6658368a12.25.1746459836702; 
 Mon, 05 May 2025 08:43:56 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/19] expo: Avoid arranging the scene willy nilly
Date: Mon,  5 May 2025 17:42:42 +0200
Message-ID: <20250505154308.2911248-5-sjg@chromium.org>
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

Moving from one scene to another should not result in the scene being
re-arranged. Drop this, so that tests can have more control of when
scenes are arranged.

Also drop the scene_arrange() call when applying a theme, for the same
reason.

Add the now-required scene_arrange() to cedit and bootmenu

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c   | 3 +++
 boot/expo.c    | 4 ----
 boot/scene.c   | 5 -----
 cmd/bootflow.c | 3 +++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 56dc7c6af15..b7c2d37e3a2 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -98,6 +98,9 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 			break;
 		}
 	}
+	ret = scene_arrange(scn);
+	if (ret)
+		return log_msg_ret("cac", ret);
 
 	return 0;
 }
diff --git a/boot/expo.c b/boot/expo.c
index 3e79cbca04b..d09cc1861da 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -185,14 +185,10 @@ struct scene *expo_lookup_scene_id(struct expo *exp, uint scene_id)
 int expo_set_scene_id(struct expo *exp, uint scene_id)
 {
 	struct scene *scn;
-	int ret;
 
 	scn = expo_lookup_scene_id(exp, scene_id);
 	if (!scn)
 		return log_msg_ret("id", -ENOENT);
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
 
 	exp->scene_id = scene_id;
 
diff --git a/boot/scene.c b/boot/scene.c
index fa8f540bfb0..2ca82236300 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -1062,7 +1062,6 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 {
 	struct scene_obj *obj;
-	int ret;
 
 	/* Avoid error-checking optional items */
 	scene_txt_set_font(scn, scn->title_id, NULL, theme->font_size);
@@ -1086,10 +1085,6 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 		}
 	}
 
-	ret = scene_arrange(scn);
-	if (ret)
-		return log_msg_ret("arr", ret);
-
 	return 0;
 }
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 6ffb1bd33e1..9d449f430c9 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -118,6 +118,9 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 	ret = -ERESTART;
 	do {
 		if (ret == -ERESTART) {
+			ret = expo_arrange(exp);
+			if (ret)
+				return log_msg_ret("bha", ret);
 			ret = expo_render(exp);
 			if (ret)
 				return log_msg_ret("bhr", ret);
-- 
2.43.0

