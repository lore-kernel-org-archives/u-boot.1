Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1379FC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7547088E29;
	Wed, 21 Aug 2024 18:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pxxfms1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C28588E26; Wed, 21 Aug 2024 18:19:45 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D8F88E15
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7093abb12edso4954973a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257182; x=1724861982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkP7Rr3nA8ezPy4hzL1j0FjYB9NDtHaobG/Q533spNc=;
 b=Pxxfms1D/vLma9d9Jk5Hn89ALNKfKRYlvA+fc0O7f7vltMpMTxkl09j9/KnVgxIVu3
 SSD9DszQ2GrdD+Kp100+E7dFp2CA1w2XaGkd1A7LZuODmm83u/qAYy9ypFWy0J4E4JWP
 mMVAIf6Z2jwxEDbfYTgZdjmq1JqxsbbvM7qME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257182; x=1724861982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkP7Rr3nA8ezPy4hzL1j0FjYB9NDtHaobG/Q533spNc=;
 b=B353uBzjwjWRVHmx0F9TnwnmQGKrYtpRYJK+h8FWkjwmIwQQvxta6S9zMXnUKOvJQF
 FADqNbzoQL3dr8b8L6ko3rcBmpMVnhIuHoNv1/wHg1hf1KSFzTvKWRhh/PQtUBlvVbli
 OCpPuwSixFyokaatGXxOdAI77l/r8/OGBzDU5CA/JpCVAhRtxi/TVkyuSchjMowMKiMp
 872ZrYrbndLTrlAlxV4dyzS6dD0Jlk+7XRA1M1FTbQEVvjMTAfh/65rytT66zcIDIcUg
 fX3++fHHNrKZwFZ74SqLxKy+loI9s2R3loilW3hf6MMC6sErrKA+FMq8z4W4BvDSp0KN
 9UwQ==
X-Gm-Message-State: AOJu0YyIi2yTMlMfh229w+B0L5P8yt3oFpIt8xL5x1hKM9Zy7huMX9vb
 3HdIb4pLu0wYWFKCap0qMz6CajBEHyhbcXrPGEkM4KWDvqNML4yCF4s8pnW10+lyrMOs4ltOgYQ
 =
X-Google-Smtp-Source: AGHT+IHoe2/NuLiv4abCHAsTBnxk4XpZLDXMOqHI/1EYqDFQEtovzPc+l5o/PT0Dr6NNpX8UZ56zog==
X-Received: by 2002:a05:6830:368b:b0:703:5d5c:3439 with SMTP id
 46e09a7af769-70df884bfaemr3437700a34.23.1724257181754; 
 Wed, 21 Aug 2024 09:19:41 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/35] arm: ronetix: Avoid accessing global_data fb_base
Date: Wed, 21 Aug 2024 10:18:59 -0600
Message-Id: <20240821161927.695717-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Use the new video function to get the framebuffer base.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/ronetix/pm9263/pm9263.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/ronetix/pm9263/pm9263.c b/board/ronetix/pm9263/pm9263.c
index 1de1bd68701..8125f064cf1 100644
--- a/board/ronetix/pm9263/pm9263.c
+++ b/board/ronetix/pm9263/pm9263.c
@@ -9,6 +9,7 @@
 
 #include <config.h>
 #include <init.h>
+#include <video.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
 #include <asm/io.h>
@@ -110,11 +111,12 @@ int dram_init_banksize(void)
 #ifdef CONFIG_DISPLAY_BOARDINFO
 int checkboard (void)
 {
+	ulong fb_base = video_get_fb();
 	char *ss;
 
 	printf ("Board : Ronetix PM9263\n");
 
-	switch (gd->fb_base) {
+	switch (fb_base) {
 	case PHYS_PSRAM:
 		ss = "(PSRAM)";
 		break;
@@ -127,7 +129,7 @@ int checkboard (void)
 		ss = "";
 		break;
 	}
-	printf("Video memory : 0x%08lX %s\n", gd->fb_base, ss );
+	printf("Video memory : 0x%08lX %s\n", fb_base, ss);
 
 	printf ("\n");
 	return 0;
-- 
2.34.1

