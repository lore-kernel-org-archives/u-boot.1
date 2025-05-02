Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F172C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F243282BBF;
	Fri,  2 May 2025 16:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gg2goifi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3E682BA1; Fri,  2 May 2025 16:48:49 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7BD82B33
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-864a071b44bso67801539f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197324; x=1746802124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1bSrZMRQE+PZSJoSdkYCvt1McfLfe6DWIKXviPigPg=;
 b=gg2goifikrwhdXbOuPYbY9Gkj5XnrdJMkD7Pd4x5RSD1e2SsnV4bvQ+leiVhz8rr4U
 Gz0QBEIMcehhSp7xtnh0fpO5ethRh1kWjESM1CwX0MVYyjXofiAK1XOeOm+D0U+MhiDr
 X2YjLlKQZ2H9Uk0Wh8Zr9ZsTJo+W+4egKBcwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197324; x=1746802124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1bSrZMRQE+PZSJoSdkYCvt1McfLfe6DWIKXviPigPg=;
 b=V2dWfEktOSM+X03c/rufhhmuAXLl083v2Io4toadthOxwD7D0QaNJwL9KuzKGv2+Ei
 u6ulpjlP9t4dTebZ4DbpyHl3UTb66P0MoHgOm/XrUI5KSmc4tnmNjtWcSTO9U5Oq7Peo
 tzdnpPQyQn9Fh82kb6QeAozOKAl4KhL4WSC4TPpNXaw1Eer39dfNWCcTg6LSP091FpRF
 jmul0lTBKBxuqh5j4GnkD6gKcg5M2ruLqhLUFh0DeBkCLvRS/TF0HQsR3iV2dXn/oTgW
 CsiptcOgLlrS826R6WgnvVPNTFJycJDWEj/ARPKi/YjIpg3RTNxsJFpQPAXZM1mAoxmE
 LsMg==
X-Gm-Message-State: AOJu0YyxoMOnWNGC4urxko7brjpStol2GyO4d0nFTjhVDMx7N9crL/gO
 cSOhXDlEykzMjUnYFiNlq0gUQrtku9FVZ4RgjJ0OOEjC2Xdd5XU8B4tJYn9PGddzUEeTrCr9014
 =
X-Gm-Gg: ASbGncusrdHpkDWIb1Sz6JdDLPnIk9ZRylZ8FgwiBw36uWMGorJOM3lR4IXKQyVeF+y
 uDkrL2hQD7lFqlf+utrr7Iws7az6M/o/IRFlWvRJu7911EmUqxkTAaowcMhOSDQhFxJ7uWtWn0l
 LfvxDplduYe7TTFJDSCs/WaXl6Y+PUec/ur/49fq2Jtj5fc2cIIfYU0ETwGqjeh6+LIeo5Qxp7K
 6tqrLbqWum0jLcSj0wK7cYvF32cb19a+Sja0vqBfvjmBpbPj6GAR2vNm5HN1j5wAqb1ltQk2XLh
 MCNYyl/cskl96QVYcAr1KXv7JqgvHHMz5YP+WbMZ1ZXxHcsW+5LeXwW+RomI8N+oDsCjZ3Skwrf
 GsHm8jLYvAo5Z
X-Google-Smtp-Source: AGHT+IGN+YLpk+Uv5g4Kc350J+E1PpwRilRPdVvtPNT+/8dJ2zUq9AL2UCsnDjJrUoBiOinuDFjH4Q==
X-Received: by 2002:a05:6602:3a10:b0:85a:eecd:37b with SMTP id
 ca18e2360f4ac-866b3490246mr382265139f.11.1746197324152; 
 Fri, 02 May 2025 07:48:44 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 41/60] expo: Tidy up scene_txt_render()
Date: Fri,  2 May 2025 08:46:39 -0600
Message-ID: <20250502144718.313633-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Add an early return if there is no string. Move all declarations to the
top of the function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index da3d30a9cab..aacdccdce17 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -418,6 +418,9 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct scene_txt_generic *gen, int x, int y,
 			    int menu_inset)
 {
+	struct video_priv *vid_priv;
+	struct vidconsole_colour old;
+	enum colour_idx fore, back;
 	const char *str;
 	int ret;
 
@@ -433,32 +436,27 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 	if (ret && ret != -ENOSYS)
 		return log_msg_ret("font", ret);
 	str = expo_get_str(exp, gen->str_id);
-	if (str) {
-		struct video_priv *vid_priv;
-		struct vidconsole_colour old;
-		enum colour_idx fore, back;
-
-		vid_priv = dev_get_uclass_priv(dev);
-		if (vid_priv->white_on_black) {
-			fore = VID_BLACK;
-			back = VID_WHITE;
-		} else {
-			fore = VID_LIGHT_GRAY;
-			back = VID_BLACK;
-		}
+	if (!str)
+		return 0;
 
-		if (obj->flags & SCENEOF_POINT) {
-			vidconsole_push_colour(cons, fore, back, &old);
-			video_fill_part(dev, x - menu_inset, y,
-					obj->bbox.x1,
-					obj->bbox.y1,
-					vid_priv->colour_bg);
-		}
-		vidconsole_set_cursor_pos(cons, x, y);
-		vidconsole_put_string(cons, str);
-		if (obj->flags & SCENEOF_POINT)
-			vidconsole_pop_colour(cons, &old);
+	vid_priv = dev_get_uclass_priv(dev);
+	if (vid_priv->white_on_black) {
+		fore = VID_BLACK;
+		back = VID_WHITE;
+	} else {
+		fore = VID_LIGHT_GRAY;
+		back = VID_BLACK;
+	}
+
+	if (obj->flags & SCENEOF_POINT) {
+		vidconsole_push_colour(cons, fore, back, &old);
+		video_fill_part(dev, x - menu_inset, y, obj->bbox.x1,
+				obj->bbox.y1, vid_priv->colour_bg);
 	}
+	vidconsole_set_cursor_pos(cons, x, y);
+	vidconsole_put_string(cons, str);
+	if (obj->flags & SCENEOF_POINT)
+		vidconsole_pop_colour(cons, &old);
 
 	return 0;
 }
-- 
2.43.0

