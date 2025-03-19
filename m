Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B80C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175558219C;
	Wed, 19 Mar 2025 15:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJEcYSRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2878482115; Wed, 19 Mar 2025 15:56:32 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A71A82145
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso32036925e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396189; x=1743000989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arUR2G1ey/u1nXracH22TcW8XDi+uIWaWSqOl3ePOMQ=;
 b=FJEcYSRiiqAERhBgBR8RkfI2stPnXvAQglMd8cFr7gpn7GRbeIVEuYuysIjyhwSbsJ
 /qmcxaDZtcJ/23uKxLgJMVPZLFQSCTWPp7idb26HqvO68MIM0VESnD1RlgaI+LB7BSiY
 vVDgYJ5A8YDbmt8ci0/LUrH9qKHUdDpCFSGWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396189; x=1743000989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arUR2G1ey/u1nXracH22TcW8XDi+uIWaWSqOl3ePOMQ=;
 b=TQLQKNtXU6A+vWdauaHaNw+y4v31/ixVfJSDsGaLeHwWMRG4whY8wvU0rGDFsc9d80
 KlpbtBgYZ0Czh4yn6cF1T03xfwOwHdMr6yxcIKPeQKL1yKIxtI9UtgGO5YtMdpsD+Rqb
 sWK0l0PPf+5OMvlBWgikTRfi26A32FnLKndp0E90TZ/gS4RpUBu2v227ix50wYVUrzOu
 Ny++UxAiGrT5udR5SEcDvtEu92dQnigJFhwaAxbb00uBWTqSFBG8IkmncE+LvlUu9O3C
 5P5I2SkjU1nLMCu6nBDcPGsS1afT8zwi+5Xibq/uLGa0ghHihthb/g/lKSJQtNQJHJM5
 lV0A==
X-Gm-Message-State: AOJu0YyICjM89HHuU5QlUqqSv2dRzqziORlFwqeW5h9nZ0DqpAa93Bob
 PcQjEthGFqA80eSMlhhE3wtGzwnpjKru3YjTbtBKUv1kmS7+H7qs2gC0eCXkIJqaU2i66LJUwZY
 =
X-Gm-Gg: ASbGncuk68B8Kb8+h3lOi2CbSWH5Ls1KdtcsRQ5YiGqJfrd/1b1C4VSx8UrWKTvzPfC
 xXawn/D6sPj+rPeM2yIy5QsxN6hLugZVn+vk61fyhIxfLsi2557hiS5AGZ1pGpBxFpLu+vatIqQ
 f+8rGVteefaCx0xSm1obPK0gmEkfOX3c4RnTHAaRheDcmI35FxzzG1YD9ruI73tJHgeFXFC2kz8
 NzrO14GYFLLK7hy+7QqlZMNWU1IjEroupSMoRdl2D2oD6/zITqtnAoffGdI6mzlBr1vbvTvEhT4
 R2KQ9JEh3wa5t0E1eXXADCToJyJRNlJAMXjoEotxb9RuRcBJET75
X-Google-Smtp-Source: AGHT+IFW5qzgsxJl37gUu1rLbgQ9MFB2nO/cnBjjPB8hPHTG9UeCX3R1CGAkb2GHTZnwtNTwgz9dQQ==
X-Received: by 2002:a05:600c:190a:b0:43c:ea40:ae4a with SMTP id
 5b1f17b1804b1-43d438a8607mr22564075e9.31.1742396188997; 
 Wed, 19 Mar 2025 07:56:28 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 33/52] expo: Tidy up scene_txt_render()
Date: Wed, 19 Mar 2025 15:54:38 +0100
Message-ID: <20250319145512.2391122-34-sjg@chromium.org>
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

Add an early return if there is no string. Move all declarations to the
top of the function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 1e68c17c386..8ecfa4f33bb 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -417,6 +417,9 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct scene_txt_generic *gen, int x, int y,
 			    int menu_inset)
 {
+	struct video_priv *vid_priv;
+	struct vidconsole_colour old;
+	enum colour_idx fore, back;
 	const char *str;
 	int ret;
 
@@ -432,32 +435,27 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
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

