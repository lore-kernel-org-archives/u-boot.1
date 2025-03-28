Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E2FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5801C82139;
	Fri, 28 Mar 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Myq5Ylly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8312282093; Fri, 28 Mar 2025 14:08:30 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5033681FE8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso180955239f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167306; x=1743772106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZTNs2T/viaaPshsrs6HoQELicaf1cSDDvjQ59apVlI=;
 b=Myq5YllyNAgxUysbb2Aj/1tbPGLfu/UhU0ZXZhor4ipZj7Ye90TK0mrE/be7pvtOar
 9o0B5lh3qqD4nZdgXBILJDcUPghEMBIfPaXO06OcSvXbHjF4BSqBaJuJp4U9RmiPBh/Y
 6a7YXLRn9BjDMIWOcXsUlZ1YePpx+IMhayfO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167306; x=1743772106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZTNs2T/viaaPshsrs6HoQELicaf1cSDDvjQ59apVlI=;
 b=KkiQfWS4sqVewx2q+aDGVcekcjvSwHtmXc6+yAeOIzu0Kh/OH+tMOe6+Bmg98G+Dqh
 BQBsNdbbxhDkp3nU+OL52c1TrqWLZgN/MMS/IZl9cbS95nm09FwyTu8UkCsxXIWIhtYg
 DPpk6l941X5sRcFg3NQdMm9hBwOzY5GElBPlyXLIWaN0kYsJr1wJlteQktMkUTfZa9Qs
 3tw25k5fSS8TDzg1OSrb1/tXBwDdsSY3kg3di774ziwrTRbYFPEd2AdH5EC9VG3ujdIz
 /wAj6c/QGnX8KM2781hJBs9jnGxiEN+K3lJ6GMjl1an/rh+y/4LMs0wA1mJKOUMBQCo8
 yNqw==
X-Gm-Message-State: AOJu0Yw42ec3oQTsYWa6Wsr+oFpnE/rvjLLe/lTLJTz6zVALFJ2Rg+Ed
 OnjPNGe8bbc5/YGt6kyJ/ZvhVhGxRnTwaHlg9Ns8lJ3Pye5j8jxKgfzm+8IuGfwSH4nRMBijtqM
 =
X-Gm-Gg: ASbGncusuabBMPAsRNgaUv4E+/w/Tpo0mdY8koJqBiG+JLLxL6H76aDDzwoPqMtHoB0
 bpp6puIzmQP8bzZQnxuj1l6oqjCTQnxF74fMu4IksnkmAKPU1rPAEyrkzfkBw6Ga3s+jaFcuoYB
 NJAOPsnPjzehJUA0zmWpb8kMKRSVeKQ+P2ujFdNNzuPynqNKQ9O7GdDjFzjCXsADbB6FJm/OYs7
 k4Kh1GGJk6xp049bFNSHkFLND5yWOu4YSfCkDvmb+2IWyv0MmAtfg52lAaFYw+l+v7vbwOgU4G9
 Lc5DfXhcTf1jRrXrXJn4o2zVL3XPC3MwWk+71vJHPSuL9IU0PbTDwTpWIy74o2yb68fYSuLZfHd
 tHB5b2Q==
X-Google-Smtp-Source: AGHT+IH3vDofCmVg0HmX18o54+QMoU1rK/0co+ct7CDo6gfw5BaWoCSCMq9yTHHB8Kb1WWnlwyGtJg==
X-Received: by 2002:a92:ca0d:0:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d5ccdd1265mr82266785ab.8.1743167306383; 
 Fri, 28 Mar 2025 06:08:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 37/56] expo: Tidy up scene_txt_render()
Date: Fri, 28 Mar 2025 07:06:24 -0600
Message-ID: <20250328130713.2612648-38-sjg@chromium.org>
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

Add an early return if there is no string. Move all declarations to the
top of the function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

