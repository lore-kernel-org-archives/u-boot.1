Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D909DC7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0EE86A1F;
	Thu, 24 Aug 2023 21:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hdMcXkVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2B586900; Thu, 24 Aug 2023 21:59:37 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3191E86A63
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so7778039f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907171; x=1693511971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdf3f8FsHlaQGqWcWD6KNCT/LH2dfqnAxntmSOaYWcM=;
 b=hdMcXkVNuWpGpJAUFMVZJu737ib2aGfhRxu/lb3/WfN5OD7evQDZsHq+h8VdOwXSkm
 2LFth8ep1azZEZgtHHfig9FHiWLZ6iaBeaJMVSXV+/Lt1R+z2lLVnrKjyFwbpiEDFf4G
 mHBS6AvLVJ1nQruhhzLT1UXPrD9ngyDWKIxD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907171; x=1693511971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdf3f8FsHlaQGqWcWD6KNCT/LH2dfqnAxntmSOaYWcM=;
 b=ISJGdtSuimYGrdiQiqok3DiqaHOMlIb0QWDGNBu5FQkBwmKy7eq131jjTKhsvV/now
 voZpmxt2Wu9g5QHPNCruMPcJQcV3QtbmxHt/wSJXs42CQl7rFsAj00c0UmqlrqPNGqhk
 9bQcUV60Sa2Wz3xZYK1Gz9uhLLWf1SFtCh0EQHY9oOYGDRAKNi0O7drg9gRIOPioZe67
 BDc1HFVhqOIcotg2huCXWHcfUOginJEv/O6Y49J6NPL/FHuT4t+ZdeIDI7y+Z8Uh/FWj
 5zVcAiAb0A9EcB/jBBWCOgZtzEU7p9fCvP7dUDDQ4o2ZwgcCXkNECgU2NjU9hg//MfsX
 MLOg==
X-Gm-Message-State: AOJu0YzfsUpj6LivP9Jaxg+XEQ5aLrHiriRJYTVSuCfmCAMPZfcrZmxg
 HTzeY29p+yLOexsRYNwYhFj57xG3pxl0Rm4rjbo=
X-Google-Smtp-Source: AGHT+IEyHRhoFOmin5gQ2RCPE7t7YhwV8pnpWyrgQBU0FXaca3/eUMKJKwjqZM4ZFkBWLUOvIW0qEQ==
X-Received: by 2002:a05:6602:25d3:b0:787:1a8f:1d08 with SMTP id
 d19-20020a05660225d300b007871a8f1d08mr6445075iop.15.1692907170864; 
 Thu, 24 Aug 2023 12:59:30 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 04/19] video: Move BMP options and code to video directory
Date: Thu, 24 Aug 2023 13:58:55 -0600
Message-ID: <20230824195917.1687886-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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
2.42.0.rc1.204.g551eb34607-goog

