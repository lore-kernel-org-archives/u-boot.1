Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD1BEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC39686ABC;
	Thu,  7 Sep 2023 17:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mHpk+K+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB16686A34; Thu,  7 Sep 2023 17:59:48 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57BD86AA7
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34baf19955cso4890405ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102382; x=1694707182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXuZoOehHb6vS9h66JMz/DUSh8y5dZKnwYScXVc+fK8=;
 b=mHpk+K+panm7gdO5kNBx2NYmHHyzMSxq72xQ47BruDIhsq4Sx1DPwZ0HPOuKBFnB7r
 kmF27ppQ0cfhSxsemPHaDAbhCx0SRx3Cc9GvsUxNTTEFdrT1wquOs33ilakLMqVe8Jom
 lwYHVOOvW97HV8FyEx6QD45sDyJzs1f2dMMrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102382; x=1694707182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXuZoOehHb6vS9h66JMz/DUSh8y5dZKnwYScXVc+fK8=;
 b=IiImS3v43MrIwPFYultqukGpl4PBX3IrfB5meXOukE574wg5aSRlbmjruIXkO/Hdft
 0nOSD2Qex4pV7IfSyxkGDzMHAoMP/jwlrFfToAOHrw86ZTf0DXRitIBvO0eOCjZ9CXlV
 y44lr+YGkCqRRbZVWBimzh0iEgZ1xfigPEG7QLdEv5cigRgJ05Y3ODsGTajpeVp+JNTk
 QVnLPSYJlLFrALgM/NXCdKPCJLOE8F127bbSSA2IeGt8ZXuEIA+t3g0WdlAKSdSfW5lS
 KGlRNcSVERw9Rkoh99qq166juO/pNnc36ZprMggKXSR1MCAdKx1pp4a5OCRM6bGR+uCb
 l7jQ==
X-Gm-Message-State: AOJu0YyhPFVV3fRjhbUYqvQu5SqeKdTnyq2Cg0JGo1lIF6ZCRkr2fLYq
 ZzC6HUURny0mXBo95SeB3/89JayhKjcrBn8fDH8=
X-Google-Smtp-Source: AGHT+IGTYaFAleFKPQmm1euJYYPeQpE9MuSIYi3XLoTflSaomHFHbjG3k5RMAp11mviI3dwJe05DwQ==
X-Received: by 2002:a05:6e02:1001:b0:349:8fb5:87c4 with SMTP id
 n1-20020a056e02100100b003498fb587c4mr131667ilj.14.1694102382539; 
 Thu, 07 Sep 2023 08:59:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 04/22] video: Move the BMP options
Date: Thu,  7 Sep 2023 09:59:09 -0600
Message-ID: <20230907155933.48511-5-sjg@chromium.org>
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

These appear prominently in the main menu at present. Move them to the
video Kconfig where they belong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Just move these options to driver/video for later consideration

 common/Kconfig        | 11 -----------
 drivers/video/Kconfig | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index d916194b9423..d11292f52c2b 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1168,14 +1168,3 @@ config FDT_SIMPLEFB
 
 config IO_TRACE
 	bool
-
-config BMP
-	bool "Enable bmp image display"
-	help
-	  Enable bmp functions to display bmp image and get bmp info.
-
-config SPL_BMP
-	bool "Enable bmp image display at SPL"
-	depends on SPL_VIDEO
-	help
-	  Enable bmp functions to display bmp image and get bmp info at SPL.
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 09f2cb1a7321..ab927641bb7a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -959,6 +959,14 @@ config SPLASH_SOURCE
 
 endif # SPLASH_SCREEN
 
+config BMP
+	bool "Enable bmp image display"
+	help
+	  Enable bmp functions to display bmp image and get bmp info.
+
+	  BMP is a simple graphics-image file format designed to store bitmap
+	  images. It is primarily used on Windows devices.
+
 config VIDEO_BMP_GZIP
 	bool "Gzip compressed BMP image support"
 	depends on BMP || SPLASH_SCREEN
@@ -1162,6 +1170,14 @@ config SPL_SPLASH_SOURCE
 
 endif # SPL_SPLASH_SCREEN
 
+config SPL_BMP
+	bool "Enable bmp image display at SPL"
+	help
+	  Enable bmp functions to display bmp image and get bmp info in SPL.
+
+	  BMP is a simple graphics-image file format designed to store bitmap
+	  images. It is primarily used on Windows devices.
+
 config SPL_VIDEO_BMP_GZIP
 	bool "Gzip compressed BMP image support at SPL"
 	depends on SPL_SPLASH_SCREEN || SPL_BMP
-- 
2.42.0.283.g2d96d420d3-goog

