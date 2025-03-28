Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FEEC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1AF82155;
	Fri, 28 Mar 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UBNC50IJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3595A81273; Fri, 28 Mar 2025 14:08:31 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7E98211B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85b5e49615aso181666239f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167307; x=1743772107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kHpi+s/ed+oSyY0uWbDXteDelTUKtSEHMMC+tIhaeE=;
 b=UBNC50IJWL3Ocb+HKBEvdQUMTKpuA776LiP4g7rG2WikFGqnRbXTOreVUHVAZcC/JQ
 /Uqr96258N+k3rGnTyE/HxP59pcuhnmozXdlZhOhAmb2mvaBzqe4ddLNPMDJQaiBKPZn
 0hpnhxplVyC5OE4lMEpdQyBKDKMNQ8maiFOYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167307; x=1743772107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kHpi+s/ed+oSyY0uWbDXteDelTUKtSEHMMC+tIhaeE=;
 b=vUMJTu6rAqdTE1C2T4cPw2Y5Eq9Si55UDOalpxr30DDXh/axyzV/CI6Y0akqa1A55Q
 UL5LBogGXEvKp4yPACcOFReNXNC+FQQ/MFa//92kthP1AG3xMYB06hjUK7QLoFeXUJZz
 c5G3bqj6tbQsAElR9IVQusBaoeUvNRIJMa7pB5nfi5O0hIodZ4q7Sn1qti72XqE6rPCN
 rbOuMBq0mzzm+y2D405LNvm5+7Hf8ZCC9ZJ1E57WKzu+kuoDmFgWYCBMEh1M87dKSYaP
 cYZNLhXca+KDuyPzFkSvlWXSpZ1cIEFZh48xdnt+qL42kBW/CU/9Cror9bszNyHhbbOY
 BGsg==
X-Gm-Message-State: AOJu0YyksyLJxA8Uz7BonqtDE8p+ObtcRMic8dm5eb0WTd/svWblpBRr
 sWdN65nVLJeks8LnwLgO2M056//zrolcCcNCIbVnDbAyd3+dwIg9Ue7dRGKz2kzYpkrexcPWPAM
 =
X-Gm-Gg: ASbGncvP8VaTKbH5gUx8AJ/E1t3v+cFwusKPo+mLwo7V6zr+GHrs/WZwfYa+goDXNEC
 JlP2L6isR4DsOwfnyvi0sSIGK0eWjUCCZbkDDA56C15syFFbtfRozAcA5ll6uebGOZR8MPdNyBs
 qxK41kxaUeDrgZjirgnTziMhRCnojH7BG1Gbe/9UKFXlNbF3Git7JHpWobdd21SQFSDVYC9fTD3
 A+HBOxraJPpugv7f6lPxBvST6ptHsrLX8bd324EzNfIMyCzGcXpOoEnAvXynCu0uDzL6bJeWLwD
 ZIgLGXH86FdSKhX3lmQOxNmbEaQH6AqlwzA715gLRrmCSgIAj2kMKca/0gvpYaZz6+G3dN9x0pj
 Jov2WXQ==
X-Google-Smtp-Source: AGHT+IFWMIhfQikeFTEUWytXd3F3m8Dt7+CXxhw+QlCI/sNEf7j4d1VwTZdxqz1zdtAZI9WUWYYFoQ==
X-Received: by 2002:a05:6602:6a8a:b0:85b:46d7:1899 with SMTP id
 ca18e2360f4ac-85e82139690mr786939339f.9.1743167305189; 
 Fri, 28 Mar 2025 06:08:25 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 36/56] expo: Move text-rendering into its own function
Date: Fri, 28 Mar 2025 07:06:23 -0600
Message-ID: <20250328130713.2612648-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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

