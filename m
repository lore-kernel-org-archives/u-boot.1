Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C9C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D8C82149;
	Wed, 19 Mar 2025 15:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MojNDEGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75FB82040; Wed, 19 Mar 2025 15:56:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1778213E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3792799f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396187; x=1743000987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvkbVkiyvrCaUlSZzgXnHmDWM0WEujuqM5wIRq2cKmE=;
 b=MojNDEGYwT0HPywVO6JwwkbabS/VBwOITKVXCUavPJ06LCqp7Al8SrnTw8ARHS5vpE
 1UQowKwovfcOuCcR6hJlPoDpGPn26B6Nr4IDzY5aSvLKLASFPunxraBKr6iGAqxh69j1
 2Rtg1/y4LcFTjAfc/AUq/bZPMRyPJoThJS49U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396187; x=1743000987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvkbVkiyvrCaUlSZzgXnHmDWM0WEujuqM5wIRq2cKmE=;
 b=YxjRu9qYDv/BxSLfAni/976I6p5txnQQ7+exT/BXOt1wd5oJO2mdG/pDW/paAs9zrL
 DCn54SIAIEi700c5vGekc17F5vNU3tfGlGDO+WA42ekPSi2Fr/ZlKt4wzmy7VlaN3zKm
 aiPImOcIx5ujRSxhvtU2qCvfZN0lY1kxrpyg5Sw77mXZkLNgWFkRysPSWKJCQqtR/HlW
 scWd4k18kMuuA2zvulAE/DdR5/VTZYJoDq6lo2ZI71e7z9sgC2I+f+44c0b2oCsmRHah
 AuU2HSy3y2qPRQiJpnGDq+hLdDRwKexkYzr7eKKHUK7yiZtYOZjmR2TCnox2+C5iAMVi
 yNnw==
X-Gm-Message-State: AOJu0YxiykjmHYWZASqljqemaSkt2xmxT6pdHg7pXrwlq63gnZBNEi5n
 M46c+LVPdgs8uA5NETCEpXcw/kMNbA1JncK86S5K2qNRIPpNoSrdJ51e7cDMX0W0r+GMBJD6698
 =
X-Gm-Gg: ASbGncsDdKf6as8R8UqG3JGC9/ImKTB9VmZSdEmf/FOYofOU3iYTKi+tQLfrOky8baA
 kZdGCnVFN1VjSgVSxyDPWShSrDPq/cxaco+HS3EEPLDH1zninBgbiMX7IOFMOwNmQCnI/8iZiMK
 7DexzEqAmxWdbyAzWestAcq7kjRdz/rFWkS7PdYwcuafxs7ofohirMlFupcrvGMI8LXOMv2xwzN
 pdILrcXZXO2OQo6qk2Uv19POSG7uIaGliWuhMVDXL490LtLBE0B6SNYf9fzBn6bu6F8pgBVGxib
 x2FgxqNhPQej6Qg9KDoy2Cm0+spVlgKUqvMseibBsA==
X-Google-Smtp-Source: AGHT+IEkcCoTqhFod14TpbPdly/+ZVeEIhRWfABPlRlTtJV/IqxkuMvuKLlYHExDmpU3sDrsrQxDgQ==
X-Received: by 2002:a5d:6d8e:0:b0:391:1222:b444 with SMTP id
 ffacd0b85a97d-399739bedaamr3461956f8f.20.1742396186600; 
 Wed, 19 Mar 2025 07:56:26 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 32/52] expo: Move text-rendering into its own function
Date: Wed, 19 Mar 2025 15:54:37 +0100
Message-ID: <20250319145512.2391122-33-sjg@chromium.org>
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

The code to render text is quite long, so put it in its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c | 95 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index bf56f4341aa..1e68c17c386 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -412,6 +412,56 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	}
 }
 
+static int scene_txt_render(struct expo *exp, struct udevice *dev,
+			    struct udevice *cons, struct scene_obj *obj,
+			    struct scene_txt_generic *gen, int x, int y,
+			    int menu_inset)
+{
+	const char *str;
+	int ret;
+
+	if (!cons)
+		return -ENOTSUPP;
+
+	if (gen->font_name || gen->font_size) {
+		ret = vidconsole_select_font(cons, gen->font_name,
+					     gen->font_size);
+	} else {
+		ret = vidconsole_select_font(cons, NULL, 0);
+	}
+	if (ret && ret != -ENOSYS)
+		return log_msg_ret("font", ret);
+	str = expo_get_str(exp, gen->str_id);
+	if (str) {
+		struct video_priv *vid_priv;
+		struct vidconsole_colour old;
+		enum colour_idx fore, back;
+
+		vid_priv = dev_get_uclass_priv(dev);
+		if (vid_priv->white_on_black) {
+			fore = VID_BLACK;
+			back = VID_WHITE;
+		} else {
+			fore = VID_LIGHT_GRAY;
+			back = VID_BLACK;
+		}
+
+		if (obj->flags & SCENEOF_POINT) {
+			vidconsole_push_colour(cons, fore, back, &old);
+			video_fill_part(dev, x - menu_inset, y,
+					obj->bbox.x1,
+					obj->bbox.y1,
+					vid_priv->colour_bg);
+		}
+		vidconsole_set_cursor_pos(cons, x, y);
+		vidconsole_put_string(cons, str);
+		if (obj->flags & SCENEOF_POINT)
+			vidconsole_pop_colour(cons, &old);
+	}
+
+	return 0;
+}
+
 /**
  * scene_obj_render() - Render an object
  *
@@ -443,49 +493,10 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 		break;
 	}
 	case SCENEOBJT_TEXT: {
-		struct scene_txt_generic *gen =
-				&((struct scene_obj_txt *)obj)->gen;
-		const char *str;
+		struct scene_obj_txt *txt = (struct scene_obj_txt *)obj;
 
-		if (!cons)
-			return -ENOTSUPP;
-
-		if (gen->font_name || gen->font_size) {
-			ret = vidconsole_select_font(cons,
-						     gen->font_name,
-						     gen->font_size);
-		} else {
-			ret = vidconsole_select_font(cons, NULL, 0);
-		}
-		if (ret && ret != -ENOSYS)
-			return log_msg_ret("font", ret);
-		str = expo_get_str(exp, gen->str_id);
-		if (str) {
-			struct video_priv *vid_priv;
-			struct vidconsole_colour old;
-			enum colour_idx fore, back;
-
-			vid_priv = dev_get_uclass_priv(dev);
-			if (vid_priv->white_on_black) {
-				fore = VID_BLACK;
-				back = VID_WHITE;
-			} else {
-				fore = VID_LIGHT_GRAY;
-				back = VID_BLACK;
-			}
-
-			if (obj->flags & SCENEOF_POINT) {
-				vidconsole_push_colour(cons, fore, back, &old);
-				video_fill_part(dev, x - theme->menu_inset, y,
-						obj->bbox.x1,
-						obj->bbox.y1,
-						vid_priv->colour_bg);
-			}
-			vidconsole_set_cursor_pos(cons, x, y);
-			vidconsole_put_string(cons, str);
-			if (obj->flags & SCENEOF_POINT)
-				vidconsole_pop_colour(cons, &old);
-		}
+		ret = scene_txt_render(exp, dev, cons, obj, &txt->gen, x, y,
+				       theme->menu_inset);
 		break;
 	}
 	case SCENEOBJT_MENU: {
-- 
2.43.0

