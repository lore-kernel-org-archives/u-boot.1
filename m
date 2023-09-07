Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FC3EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDDD86AE1;
	Thu,  7 Sep 2023 17:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RoY7BIwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8AC86A74; Thu,  7 Sep 2023 17:59:51 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23D586ABD
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34e1c1405easo4386805ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102383; x=1694707183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jA7OnEa03y2Hgwi3UMDF8ZqFwSFYh7R/faoPpIMrSI=;
 b=RoY7BIwGXMV2MmOEpU3lzaZ1gZ03GI129WwfqnhrezVbFTC8J/1JKuibJSAq/9YsDB
 +Z2fVPpKp93cSAz4rFTcDs/KO9AeN7b3op6JoOtvQ3mojnWqC/os06fthWXaUhynq7x+
 BQDrALgM4lzXjdYWdbzqm2YBLaxMTEsGpa+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102383; x=1694707183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jA7OnEa03y2Hgwi3UMDF8ZqFwSFYh7R/faoPpIMrSI=;
 b=eidJNw4YMIUd1Ip2rGrwh+T5CtsYXzMeZORGu8QT4MM2EFN5fUJ1eo4fOcyDvWjH6I
 wWfF9FVQH4MM7dKah75kWb3Vf6AgoI0syfz+638Lc1szdmjDUUFiICEpB5V7OVzooBFI
 W8X/0fixxM/uZlH+8XIFwFz3DJlsaxmAKZd70ReEC9QRsd4w7rtzRqvh+44GPK8BA05I
 xuOBmkFIYi11Rs/+Qaq8uTAABsmSNnwhvfLtyh5hLa8Xth7sGBhB0XM2B8g1nniOXeGg
 +0X37WAfCjfv33SbcQqXrWzFIR+6thiLZhlgRm8kvubV50GYzXDjt/4TecThuDVn2xEp
 lfsA==
X-Gm-Message-State: AOJu0Yy3xkW1Ey9ql/K9tFPJdeqzmS9pWg2zXh33TT/usnCrBIgBm0C/
 UFXzsoUo4AY67J3UZnFejWzPTQf8+asJm70wsU4=
X-Google-Smtp-Source: AGHT+IFvZYpJV7IxdCHJnmfn0FrgjvaAAxAHr1q2MgZjTmbkVLcqWFYyr0yH/tBWTcFkFWUdoBJPyQ==
X-Received: by 2002:a05:6e02:144d:b0:34d:f32c:1d8f with SMTP id
 p13-20020a056e02144d00b0034df32c1d8fmr114253ilo.17.1694102383321; 
 Thu, 07 Sep 2023 08:59:43 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 05/22] video: Move BMP options and code to video directory
Date: Thu,  7 Sep 2023 09:59:10 -0600
Message-ID: <20230907155933.48511-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

Put the options and the common BMP code with the other related Kconfig
options in the drivers/video directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/Kconfig  | 11 +++++++++++
 drivers/video/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..1ea820c68869 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -682,6 +682,11 @@ config BACKLIGHT_LM3533
 	  LM3533 Lighting Power chip. Only Bank A is supported as for now.
 	  Supported backlight level range is from 2 to 255 with step of 1.
 
+config BMP
+	bool # Enable bmp image display
+	help
+	  Enable bmp functions to display bmp image and get bmp info.
+
 source "drivers/video/ti/Kconfig"
 
 source "drivers/video/exynos/Kconfig"
@@ -1125,6 +1130,12 @@ config SPL_VIDEO_REMOVE
 	  if this  option is enabled video driver will be removed at the end of
 	  SPL stage, before loading the next stage.
 
+config SPL_BMP
+	bool # Enable bmp image display at SPL
+	depends on SPL_VIDEO
+	help
+	  Enable bmp functions to display bmp image and get bmp info at SPL.
+
 if SPL_SPLASH_SCREEN
 
 config SPL_SPLASH_SCREEN_ALIGN
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6841d8965842..88b37b1855c6 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -3,6 +3,8 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+obj-$(CONFIG_$(SPL_)BMP) += bmp.o
+
 ifdef CONFIG_DM
 obj-$(CONFIG_$(SPL_TPL_)BACKLIGHT) += backlight-uclass.o
 obj-$(CONFIG_BACKLIGHT_GPIO) += backlight_gpio.o
-- 
2.42.0.283.g2d96d420d3-goog

