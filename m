Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73786D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CD089228;
	Tue, 15 Oct 2024 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UCze7ALA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5872C88703; Tue, 15 Oct 2024 00:32:21 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5F8891AA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-835393376e1so295078939f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945137; x=1729549937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFEx0c0sJB1E97HMSZgPHLAAiSR/v3dkcFGFSL2x0+4=;
 b=UCze7ALAgp/Mg/vXQ9xPhCwSnYrI4SDEf4NDUpIHih8KLbL+/JZbmhHdHA0CC94kMi
 j9PK+UlK63xsukCHqyHpiJXFWwFSg09ZRTmJqzLf5yLroRkyJc3/pO352xkDBsuPoCwJ
 bgk44eWjC4/0MwgQRmX9d0FLDCq1ItI3Ybaug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945137; x=1729549937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFEx0c0sJB1E97HMSZgPHLAAiSR/v3dkcFGFSL2x0+4=;
 b=lDmR28Y5sXn6ZZbwWrIetFBYbusciz/U+oloTmLepTEq0Fws8bOe6FlzBuCiFmydQF
 Zf122OsIrCQYtxjOf85C9mwDV6lahegewZ4MMfheJXpnZOPPzZf0Y+3QYQKwOUpMbqM4
 /s7pzmp7tyNzMhUiB5dUqfFe4bnL8Oq6GnnxhYcEAAU8giY0ZDE8JGOPMqsVLdVRmqDP
 2JVm7p4vYQW00h/2D+0KteBv3U5aqnBNE+uJd1tjvxodmPekqHHXuDx3/wJiLlE7NqVY
 QF+iZxPe9wUUQ+2RlxaOmqQ23geJlsCxWf7ynTcEKZluDc7SVqKmn2XxWGjQgjJhxo/i
 ZhTQ==
X-Gm-Message-State: AOJu0YxIlhhaevn4uIMZCxwnhTHscXbUpPoyzbQxzZ2TA/fbj/aB4UhQ
 GiKgEyEN8eAB5qYhfYnc6WzsoRmWYhHAIv/De81swfVcRXd1hODdG0LyaW7x2wfh/31H+2zYm/P
 LMg==
X-Google-Smtp-Source: AGHT+IEUgBGo03TEXjxuJYUl//XIc/OM7Sjx+/mew8+rhy1TRZNpa0L7+ro7kFFR7NKXjG+8VFuCdg==
X-Received: by 2002:a05:6e02:2185:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3bce0b188mr84614385ab.24.1728945136989; 
 Mon, 14 Oct 2024 15:32:16 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 01/20] video: Add a dark-grey console colour
Date: Mon, 14 Oct 2024 16:31:53 -0600
Message-Id: <20241014223212.2212442-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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
index 270c9c67233..0135287cfcb 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -339,7 +339,7 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 
 	/* draw a background for the object */
 	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
-		fore = VID_BLACK;
+		fore = VID_DARK_GREY;
 		back = VID_WHITE;
 	} else {
 		fore = VID_LIGHT_GRAY;
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 9823673f817..a5b3e898066 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -294,6 +294,9 @@ static const struct vid_rgb colours[VID_COLOUR_COUNT] = {
 	{ 0xff, 0x00, 0xff },  /* bright magenta */
 	{ 0x00, 0xff, 0xff },  /* bright cyan */
 	{ 0xff, 0xff, 0xff },  /* white */
+
+	/* an extra one for menus */
+	{ 0x40, 0x40, 0x40 },  /* dark gray */
 };
 
 u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
diff --git a/include/video.h b/include/video.h
index 606c8a37fb8..fd19723b1d2 100644
--- a/include/video.h
+++ b/include/video.h
@@ -181,6 +181,7 @@ enum colour_idx {
 	VID_LIGHT_MAGENTA,
 	VID_LIGHT_CYAN,
 	VID_WHITE,
+	VID_DARK_GREY,
 
 	VID_COLOUR_COUNT
 };
-- 
2.34.1

