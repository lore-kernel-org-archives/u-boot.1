Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAABE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A668724F;
	Mon,  2 Oct 2023 03:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KkpGqER/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F68B87237; Mon,  2 Oct 2023 03:18:15 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2CC8723C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3513b5a9e8eso38279685ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209380; x=1696814180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqJ3k6eq+fONjC6XAXk7qX5shaMeXvNPDIB9TpkZMUA=;
 b=KkpGqER/qoP0CmlLVlRE4UfKX5lx2W2ySylk1YcJy8i2lKEhZRfablF8IJtiuq61eZ
 4QcUoT6rC30+My/bphCMi0X1v5RfpeMomcXzXqawJlNAzhx1TXiq62ZXWQai7lw++pSh
 7B1fF/CBfMlfTU7iLLVVH8lkDtMQuKE7jIlI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209380; x=1696814180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqJ3k6eq+fONjC6XAXk7qX5shaMeXvNPDIB9TpkZMUA=;
 b=td4Fpqb9eE4NSuuPnVwmEIljoYGJowlGH0M7FUifoh/8onrv63fIY5nUgGxM8ckJeL
 ExTam8kTWtnvPAooyLMAX8DmZBbjBd2i2kdAF/WQ6X6hw9KALv97vkyiNzDIpsQwzFK5
 r/6+R9MrEl6Sgaq8C9iIb6NmpREaOfetTm6LIrqDsnKGvYRbx0qExQg2FZXsD2zpW4X/
 eLc0x0utGJJJ7/ooa377Uv7AP+DVASyRv/ZdlfT06pDKBwVyLdMjUhgYyrv9Q4EMWoXf
 rNL87vvKZfuTk5kogcK+6Y3Pl1RF2RgastQ8LuV09yfPjTt2QEs1K4cQSGsD11MvihI/
 Dtmg==
X-Gm-Message-State: AOJu0Yz5zXBfiZm9ztL5O0boUs9QkWNsMEY3TbzuMJV+mnhDnXzg4hvF
 1PpzmeIre1oAjvqnpL/kubuSBx7hkYMtnvl0wuQ=
X-Google-Smtp-Source: AGHT+IFSOMnLgItpjQ0UpwlvgMzRyHr4Y1nAXHXWSk/3DuWrXGHr1kjWS2swiUk7nh7UdJwyZZLdMA==
X-Received: by 2002:a92:d249:0:b0:352:609f:e4af with SMTP id
 v9-20020a92d249000000b00352609fe4afmr9138186ilg.24.1696209380276; 
 Sun, 01 Oct 2023 18:16:20 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 16/34] video: Add a dark-grey console colour
Date: Sun,  1 Oct 2023 19:15:26 -0600
Message-ID: <20231002011553.463514-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

This is useful for highlighting something with a black background, as
is needed with cedit when using a white-on-black console. Add this as
a new colour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c                 | 2 +-
 drivers/video/video-uclass.c | 3 +++
 include/video.h              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index d4dfb49ada15..0b37971b1ff4 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -346,7 +346,7 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 
 	/* draw a background for the object */
 	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
-		fore = VID_BLACK;
+		fore = VID_DARK_GREY;
 		back = VID_WHITE;
 	} else {
 		fore = VID_LIGHT_GRAY;
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c818..51fafbb21747 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -281,6 +281,9 @@ static const struct vid_rgb colours[VID_COLOUR_COUNT] = {
 	{ 0xff, 0x00, 0xff },  /* bright magenta */
 	{ 0x00, 0xff, 0xff },  /* bright cyan */
 	{ 0xff, 0xff, 0xff },  /* white */
+
+	/* an extra one for menus */
+	{ 0x40, 0x40, 0x40 },  /* dark gray */
 };
 
 u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
diff --git a/include/video.h b/include/video.h
index 4d8df9baaada..ae9ce03f5bfa 100644
--- a/include/video.h
+++ b/include/video.h
@@ -179,6 +179,7 @@ enum colour_idx {
 	VID_LIGHT_MAGENTA,
 	VID_LIGHT_CYAN,
 	VID_WHITE,
+	VID_DARK_GREY,
 
 	VID_COLOUR_COUNT
 };
-- 
2.42.0.582.g8ccd20d70d-goog

