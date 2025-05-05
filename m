Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CB3C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3112E82A2F;
	Mon,  5 May 2025 17:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2XOgv6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18B98214F; Mon,  5 May 2025 17:44:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6B282A5E
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so804202866b.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459853; x=1747064653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGvJlubC2Dcr4RT6lOXf6uX2hm1z15IHfUXO3mFCWkE=;
 b=S2XOgv6hXvQPge7w2GgembxZhsAbi5db4a3kQY6zfl83TqDYQCPlWzWVqGHLczp12h
 1AGQik8zgc3Jb/dlPIYZEWIpMzKKeMO+efLjhRknC/mkScka4/JpF+G+7rMBxe8OqK32
 j1tGlazNjDBapSuNMyX3lrOsWnJQYDSBZElG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459853; x=1747064653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGvJlubC2Dcr4RT6lOXf6uX2hm1z15IHfUXO3mFCWkE=;
 b=YVKm/vBe7imG32Z6qiOcecuVhUJ/nngI3UjwfankPIUCoINQyUEPhgvvcuVVY7khBM
 GMNx+ujurLaro+ulS8U72alpK5Clo8VOlKzi/jlN/+oznilY+6GSiYmoXuEdE9o/P+nl
 lQCO5ALP8/bUA5Gx6Mb25mdi+MNlEYVn38k3KPNQ+22fgdGI5rqpxhbN0nQOJOFa7Af6
 cTAvO0fjb11vzu23bZeb0mu30z7lcKFaCHmhFEQYj2TgON5MAPVrfEjLltYq/1/84aR0
 vk6elr/mJARDAqofxuty3+v2CUx2cIo43W1yA9XElzNMDIqYFK+txIJJEYnjyMB05Ac4
 nAlw==
X-Gm-Message-State: AOJu0Yx3L3/NxsNOcypZQJ1mgL+H5yCYGEwBhqM8FnHNPFmJSEbSMqN7
 a9YOGq953Nl0F5qqorYWIVtsaqLcgn9E8KZUlH/W3gxthPbhxQjVy/mtQII7Ot0WVD1fuyj9/16
 jfaSCjuk=
X-Gm-Gg: ASbGncs0bFMeZiB7f8cpperBTiUJbVEAYfQ4XZrEvcfwWat2I9bTqHbX054Fea1pD6K
 a2e5mjLor3/x3T40XLreJ6fpfDBluYVvum2NdKarlnUefT4Xk949oDq62RYF6IZXMq2A7lSfHXR
 WgTHQlCoJuvgacSyuWN+dah8V64RLKTXDi4TXvipiuc1wXQZ7CKC3UMzKLMSVp9JpizZjsZ5h/l
 Tm0l1VaIBdNrx2TDMfb2D11EeIspeOPC5yEGiNd4+joe24YDV/5uWUR7gXDtAooF8ZmyRgZECmI
 /Coc8vvvVrqCgnH8UMLMVOEGO85puqnr+7OR
X-Google-Smtp-Source: AGHT+IEtF2I5TzY6nKcnUMA2LHbNh+I2uQR+j4NyHqTbJLa9iHaIWR2UioaAo8IUo0vj5Zh87vccfg==
X-Received: by 2002:a17:906:4750:b0:ace:d91c:926 with SMTP id
 a640c23a62f3a-ad1a4acf986mr559712866b.42.1746459853040; 
 Mon, 05 May 2025 08:44:13 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/19] expo: Use a var to arrange horizonal positions in menu
Date: Mon,  5 May 2025 17:42:52 +0200
Message-ID: <20250505154308.2911248-15-sjg@chromium.org>
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

At present the components of each menu item are set at fixed positions.
Use an 'x' variable instead, so that we can eventually move to taking
account of the actual dimensions of the items.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index c2abf1e3926..094489e2a40 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -228,7 +228,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	const struct expo_theme *theme = &exp->theme;
 	struct scene_menitem *item;
 	uint sel_id;
-	int x, y;
+	int startx, x, y;
 	int ret;
 
 	menu->obj.dims.x = 0;
@@ -237,12 +237,12 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	memset(dims, '\0', sizeof(dims));
 	scene_menu_calc_dims(scn, menu, dims);
 
-	x = menu->obj.bbox.x0;
+	startx = menu->obj.bbox.x0;
 	y = menu->obj.bbox.y0;
 	if (menu->title_id) {
 		int width;
 
-		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.bbox.x0, y);
+		ret = scene_obj_set_pos(scn, menu->title_id, startx, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
@@ -251,7 +251,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			return log_msg_ret("hei", ret);
 
 		if (stack)
-			x += arr->label_width + theme->menu_title_margin_x;
+			startx += arr->label_width + theme->menu_title_margin_x;
 		else
 			y += ret * 2;
 	}
@@ -267,6 +267,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		bool selected;
 		int height;
 
+		x = startx;
 		ret = scene_obj_get_hw(scn, item->label_id, NULL);
 		if (ret < 0)
 			return log_msg_ret("get", ret);
@@ -291,19 +292,23 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			return log_msg_ret("nam", ret);
 		scene_obj_set_hide(scn, item->label_id,
 				   stack && !open && !selected);
+		x += 200;
 
 		/* space for the pointer */
-		if (menu->pointer_id)
-			menu->pointer_xofs = 200;
+		if (menu->pointer_id) {
+			menu->pointer_xofs = x - startx;
+			x += 30;
+		}
 
 		if (item->key_id) {
-			ret = scene_obj_set_pos(scn, item->key_id, x + 230, y);
+			ret = scene_obj_set_pos(scn, item->key_id, x, y);
 			if (ret < 0)
 				return log_msg_ret("key", ret);
+			x += 50;
 		}
 
 		if (item->desc_id) {
-			ret = scene_obj_set_pos(scn, item->desc_id, x + 280, y);
+			ret = scene_obj_set_pos(scn, item->desc_id, x, y);
 			if (ret < 0)
 				return log_msg_ret("des", ret);
 		}
-- 
2.43.0

