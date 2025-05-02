Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C506C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF5B82B8E;
	Fri,  2 May 2025 16:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGa3dnIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEAAB82B45; Fri,  2 May 2025 16:48:46 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BA8828C2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-86192b6946eso67770939f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197322; x=1746802122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRSdrh2j7hFRY/BBto4Wio3tTkAkfTLyMvqzJn/Qps0=;
 b=ZGa3dnIp/y+EEBw+aXG7JNBF9682aB+/XvX4E794mvw87EklCY6aDnI4sGR090suRf
 LZ/sKJGSaW+KCl6zvvJwvPpK6q42pk7UeHSAXmL4dlfpdH4p34uENqZJyOl55BxUQ1pX
 M6WHOfLvK65mu6hE6rpLgZRCKtymXe5KCocfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197322; x=1746802122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRSdrh2j7hFRY/BBto4Wio3tTkAkfTLyMvqzJn/Qps0=;
 b=dkqSP043nqdn38n/F6ni7KGWhl4q/Lo4zHQ3bJcqfVn3OY9CCpJIXcpqWuHNU+eSFZ
 U1npZrC29uMuJ/suOa3F9mqlLTWV/3NpKcqVovgZqGt2b9rfNsmkccgEln5P/hYX5q/f
 94DUVPo974GQmK5n7iiT7/3G6kubED6rKpApzZ2GQ/ao+dRyb07ZVx2EN6fv5idfWud3
 FV2TO/azNPa1FYUX0GDDWXMDC6zrx8sKbF5WFZ+DqUo0Nb2bH11b2XpNfLEvRDpd5fqk
 K9JM/VFdWmqx5APXpUUIlWyZHlvmhqX5Rm9rZ0d4gfNJPtHf4ooJEQaTCwCquS7vnIxf
 C5rA==
X-Gm-Message-State: AOJu0YwlW3vRZX0hvFG/seXIpIjk9D3KcXzHO7zRQECQo+MkhhSraROw
 H5IRT2Iv1EHewJQ7jqEeoUFK8vZllwYts3mUptkCbMyZuLqE/LEdTR5LulYeZM9RzqmLitaCOgo
 =
X-Gm-Gg: ASbGncvxtCm8La6JkwEumDk5bC4J3A2CuM///oc2x4dAW7hAB34zm/1qVP/J0BLhsub
 /Za295/6N5dFyQR4FlAytl4HwUqvoeJ6JZQVOG3dEMajOCUX5K2my5lotRv822WDyE9Hb15y5eg
 qn65fuaR8eNxkZz2iRNJhaedkS03ROP2sPO53+ZhqwiLLWmoJeJvkA9twaV9hSSbF0dgxRSIc7G
 syoUSH5nO7UAYHgZ6DcxORLFdo//iltOicRdOkVGw/Ja7ZVyV4z7obZGK/auKLcMYuVZ9bgKEfC
 2ImlYaiRromEtD2jgNtzczW2ONrJDDPzY5QJjW11PEXMsBP4aUNSfUjoQ42FWMh95/ZiueEnkky
 UWA==
X-Google-Smtp-Source: AGHT+IEDrzk53NG07N5wgHoQs73U9/Z9xcoHHG+42dT0YX5wmKPNwgYmBCv74Eu2c63tgsMfftVLAQ==
X-Received: by 2002:a05:6602:3817:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-866b42992damr428485839f.12.1746197322633; 
 Fri, 02 May 2025 07:48:42 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 40/60] expo: Move text-rendering into its own function
Date: Fri,  2 May 2025 08:46:38 -0600
Message-ID: <20250502144718.313633-41-sjg@chromium.org>
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

The code to render text is quite long, so put it in its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c | 95 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 99623d2d3a8..da3d30a9cab 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -413,6 +413,56 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
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
@@ -444,49 +494,10 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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

