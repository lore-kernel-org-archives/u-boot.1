Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89723C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02EA186597;
	Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HP0QKlIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B808654A; Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D8B86583
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-79d8edd6d99so206401241.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454013; x=1694058813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CsWMqEk3oMmc6S+7f5tjPeulJ2dbevolxE7NE1VoFo=;
 b=HP0QKlIpyla5KslplLvKHEQGXa0pD4je/+2MkljDBWNDl3Lp/p+89LLYE5lydOkNS+
 Y/KeR4h5Ltae/oBdX3ppKL1zgriMS9C0LemVvNLmRtim1v1YXUdsr+6KKzqnjb72aC5U
 si8A6jpzMvhl1k7jZIhc/md6qFlerJHHLmrzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454013; x=1694058813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CsWMqEk3oMmc6S+7f5tjPeulJ2dbevolxE7NE1VoFo=;
 b=Wyh9amgbMaB3oRBC37a5SBVt/PvNNskv25YY95Uu2YDWjSV2YKb479E5//clPREFyB
 SBouKdYAEWliYNYYFsgYZKCpRYGVX+Ze5mDFZe065hrniXPfAPpMOQBAWDNhyZteTWcC
 +CWhgIjNxP5fGjqBo7Z6LdHt1qLPEW/Fylap83TOEmr+CJa/A8mqaXLqntVf+xhEABbL
 iqlVvZLxVvbdB7EAzioNW/zclooAaxOKyRg+MHKWgVKlw1Inu8EHjsqp7ePmI0GOIoGE
 NQdjsfgfGI06rFC4YGbbWunMj7hOO3JDZt8+3nzSX6gPJXgTbqN2DKywROuadOpW8+PJ
 BaOg==
X-Gm-Message-State: AOJu0YzTlFMAyRWp5mZy7YKALCU+yF4/AKIw7Y0q+U1Q2dTT1IZBTT9d
 oUF/aHVlD+iCAUcp8dU+ofn2KD6NU47l0po+2lA=
X-Google-Smtp-Source: AGHT+IH+VMoi3xQggalHC/I3wJj2apTomze8Jcsqgpzlr7TO0Zm76Scho/I7vUgjhI7iqYFumRUdpA==
X-Received: by 2002:a67:e3bb:0:b0:44d:40b1:926d with SMTP id
 j27-20020a67e3bb000000b0044d40b1926dmr4419102vsm.32.1693454013477; 
 Wed, 30 Aug 2023 20:53:33 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 04/19] video: Move BMP options and code to video directory
Date: Wed, 30 Aug 2023 21:52:58 -0600
Message-ID: <20230831035319.2316665-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

 common/Kconfig                  | 11 -----------
 common/Makefile                 |  1 -
 drivers/video/Kconfig           | 11 +++++++++++
 drivers/video/Makefile          |  2 ++
 {common => drivers/video}/bmp.c |  0
 5 files changed, 13 insertions(+), 12 deletions(-)
 rename {common => drivers/video}/bmp.c (100%)

diff --git a/common/Kconfig b/common/Kconfig
index 844531a59eda..2f46fdb3f62c 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1167,14 +1167,3 @@ config FDT_SIMPLEFB
 
 config IO_TRACE
 	bool
-
-config BMP
-	bool # Enable bmp image display
-	help
-	  Enable bmp functions to display bmp image and get bmp info.
-
-config SPL_BMP
-	bool # Enable bmp image display at SPL
-	depends on SPL_VIDEO
-	help
-	  Enable bmp functions to display bmp image and get bmp info at SPL.
diff --git a/common/Makefile b/common/Makefile
index f5c3d90f0675..0a3f75f2f1c8 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -45,7 +45,6 @@ endif # !CONFIG_SPL_BUILD
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
-obj-$(CONFIG_$(SPL_)BMP) += bmp.o
 
 ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_DFU
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 09f2cb1a7321..a4befd6b655c 100644
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
@@ -1117,6 +1122,12 @@ config SPL_VIDEO_REMOVE
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
index d13af9f3b19b..a3182dca734b 100644
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
diff --git a/common/bmp.c b/drivers/video/bmp.c
similarity index 100%
rename from common/bmp.c
rename to drivers/video/bmp.c
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

