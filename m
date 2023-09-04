Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00516C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79638696B;
	Mon,  4 Sep 2023 16:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G0XR9KEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C75886961; Mon,  4 Sep 2023 16:41:48 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5579986998
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34e2be5679dso4477625ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838504; x=1694443304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaxS2r0G+B/WiBjyCN0VtJ2DOnsYdmfPnecroXP8SLw=;
 b=G0XR9KEiwF/5U23wKzWf2q9yKKHx1PdG3ZyqyaPFQd5xVMJ0tclsSzgYrRT1m27znV
 64jTONEyRIcppU0ca6fEZPubxAXeWbL48Ied/r+s8R5ehyImsOnNXK8wIMQfOPSWoH8K
 eK9f35AMB85v/oMuaEZ2O626qOp9xH8Z9/V9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838504; x=1694443304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaxS2r0G+B/WiBjyCN0VtJ2DOnsYdmfPnecroXP8SLw=;
 b=Ijk6mam8bpQGhAVzEFrfT+A7IbbNyLzgX6FOK+g8rQYVfphTJalcry/v1OajDm61sV
 eqPzAjht3AiSDgr6aRn+AVQfS2kHisdAqIpwWMzA8AzDVupxQaj+rNqKxMk0HojY+vn9
 rzrI6TOwhZPxYYvJnKfwz058DIOapmjG/tUsuNEc3eOv7okrHg71xk355l4PtL39am44
 Kb/BlWVFEXN+/LRVSm8x+wV5u+f2vl3Ol5njZsxDx/yQArvPHwydgk2chZYv6w+0bXc3
 VerGb0sLrBEQWWUhSVe38fvkuOjenEosMiz+ekMI+idjGu7e6JwcSGPoZaGyu9s67yP/
 oW8w==
X-Gm-Message-State: AOJu0YyixQVq9AfNq4A2ciKer59kjlE932mIIA9V4vNJOHJiory/bREV
 LEFatLVEYwecg6jpcDr3T4tOEJtDMDs7LyzxSss=
X-Google-Smtp-Source: AGHT+IHhbBlPJrfv5SfUnXODOO5m5EasrW5ERAU9Tgudnila5DN6Dm+GiKzQBvfmCbsLv8oaAAW4Dg==
X-Received: by 2002:a05:6e02:f45:b0:34d:f0b4:787a with SMTP id
 y5-20020a056e020f4500b0034df0b4787amr10012226ilj.15.1693838503865; 
 Mon, 04 Sep 2023 07:41:43 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 04/20] video: Move the BMP options
Date: Mon,  4 Sep 2023 08:41:07 -0600
Message-ID: <20230904144131.2699824-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
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
index 09f2cb1a7321..4eeb8ce022a6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -959,6 +959,14 @@ config SPLASH_SOURCE
 
 endif # SPLASH_SCREEN
 
+config BMP
+	bool
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
+	bool
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

