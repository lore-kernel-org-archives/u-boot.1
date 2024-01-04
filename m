Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C36C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8260287A14;
	Thu,  4 Jan 2024 16:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sd1jjqi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84350879B5; Thu,  4 Jan 2024 16:12:17 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69E8879D1
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35ff53a78a3so2193935ab.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381119; x=1704985919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpqcU1Y7mDH9IuYja2MIELbGLSPNmWdDNZnaHD5YzMM=;
 b=Sd1jjqi+qwM1Gx8jIvvBP+7IRH82Zne3qvFm8gJ9tFWr7ykNcHr3uEGTiQRGHV83et
 fh/dhPQhlbQYTeI/I2zxG1omNNiaDbGTbZ9n0EXfpqFYIHIfE/S6HvVqqnzndps5IFWr
 r2PUV8rN0ualQ8SbTFvvJ41GxSkm+oNxaZ/0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381119; x=1704985919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpqcU1Y7mDH9IuYja2MIELbGLSPNmWdDNZnaHD5YzMM=;
 b=Z+WpvbpyKaDQuIVwA3Df6CE8KqiL+1FXBOA4mUeJmr2YA0gxD3sIiItFUbaOa5AmiK
 T67WG+g6YozX4OIBTRXX6ScGrJgyIsQzG5VZMXqDeVdN99L3fU7XgaaNOS68n5s+OA12
 kqJXb7YNKScnKN6dKU1tOYwnLcn4xEhXwCFy8rtG4sxBeNrtxSgqCjjukTnDo5qs/Qyq
 u/VJPMkPPtcMJijL7iUs53LMnvmJRFjoJUj6NiJQR3/OjdUo+Dfqz4MUMotVV6mGT3yg
 aJBO3mmQ0RE42fArH+c36qvM7bCc7RaNpvnEk8SnrrrNwSFJ7+7OiG3DIDiNJ/mKpJgn
 IRLQ==
X-Gm-Message-State: AOJu0YzUnDct6jCXge0aYVuOkrNTTCgqMOhe8AH9q7GOfBT2JadhAa+8
 GS3dXQ4BhnsbhBQqrGUHMWxLChDgyWNPkpKe0XX/GYNde/Wr
X-Google-Smtp-Source: AGHT+IE1LpImjGSh44ZIWEVtsXCfzD555soRQm09gfLrl7Ol+jQ5j2iN/VNT4jiDKEUgYm5lLs2YOA==
X-Received: by 2002:a05:6e02:216d:b0:35f:e7e7:52af with SMTP id
 s13-20020a056e02216d00b0035fe7e752afmr761934ilv.37.1704381118898; 
 Thu, 04 Jan 2024 07:11:58 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:11:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 01/19] video: Add a dark-grey console colour
Date: Thu,  4 Jan 2024 08:11:34 -0700
Message-Id: <20240104151152.697855-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

(no changes since v1)

 boot/scene.c                 | 2 +-
 drivers/video/video-uclass.c | 3 +++
 include/video.h              | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index d4dfb49ada1..0b37971b1ff 100644
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
index f743ed74c81..51fafbb2174 100644
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
index 4d8df9baaad..ae9ce03f5bf 100644
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
2.34.1

