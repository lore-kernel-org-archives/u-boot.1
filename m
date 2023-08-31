Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B64C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE99865AB;
	Thu, 31 Aug 2023 05:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cv/B9Mp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB39886614; Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3E58657B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso9213239f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454019; x=1694058819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qC3DoUISujW2GZWgoPyDi/nmWht3/MKHDdhYZT9SHb8=;
 b=cv/B9Mp2nZyg7RmdQakIbXmDq7XtqGDJP1+OjntULAHc8fDuvOX8GPpsZipMRHtwk4
 5BZZ8uJrLLK+hFExY2o7uAIpW3rfA/KtFqadA4rVcPKubgXv8mc2carDls/LoAAbwjUs
 L+jfgNg/kMWGsJq2uFhbWxGvsDU+Ni4ugHPbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454019; x=1694058819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qC3DoUISujW2GZWgoPyDi/nmWht3/MKHDdhYZT9SHb8=;
 b=VuQzGkU/nZAPoXDjfnjbw6ypR2MvdAJt8ICybpri8hGju8sMSHq/GHjqMajDpfs/1f
 J+Rr5uOeBeP8tD1CsU+D0smjpzHkS7IxpFBtR1qhAmnnZE0v3UA9gWBQO9vu1u0GTcth
 wwE2ifd4CJH+d25r420/CYroPpyuk/CTovFBtO52h7FmR2c7yHs+PPOhIyKf1W25SaDr
 LZ82YztntzQummmXLy/wdelDW3DVw0EMMfYDnwEPR8OH+0nvoKQazvMdCA6V+kWrYA0E
 x2TauEkUz+GJKlMcXTrjxUwkQsVwPxlMHFWK3XZu5Jo0kkWMqjWSWIUyWnj4GOnV+te+
 FOTg==
X-Gm-Message-State: AOJu0YyFKTD3ZkxmiklKHb26u55Z7AAQteuMtFCEd9BWuPtI76zdc7tW
 JmqhwHflCq/ss0p8WNQukL7+NeMp6MPAY8qTYmI=
X-Google-Smtp-Source: AGHT+IGN5ZnY7wFs81dQQuCR6lWcUGxjvZYayhKZ3ef2NM4xYMJZ7KP2aR8p8KlVNL4wOxfCioaHfQ==
X-Received: by 2002:a5e:9910:0:b0:792:1b70:b344 with SMTP id
 t16-20020a5e9910000000b007921b70b344mr1305169ioj.1.1693454019765; 
 Wed, 30 Aug 2023 20:53:39 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 12/19] Kconfig: Create a menu for FIT
Date: Wed, 30 Aug 2023 21:53:06 -0600
Message-ID: <20230831035319.2316665-13-sjg@chromium.org>
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

This is a major feature with a lot of options. Give it its own menu to
tidy up the 'make menuconfig' display. Drop the 'depends on FIT' pieces
which are now unnecessary, since they are now bracketed by an 'if FIT'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f603a64a23de..467bca706782 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -9,8 +9,8 @@ config ANDROID_BOOT_IMAGE
 	  This enables support for booting images which use the Android
 	  image format header.
 
-config FIT
-	bool "Support Flattened Image Tree"
+menuconfig FIT
+	bool "Flattened Image Tree (FIT)"
 	select HASH
 	select MD5
 	select SHA1
@@ -25,6 +25,8 @@ config FIT
 	  multiple configurations, verification through hashing and also
 	  verified boot (secure boot using RSA).
 
+if FIT
+
 config TIMESTAMP
 	bool "Show image date and time when displaying image information"
 	default y if CMD_DATE
@@ -38,7 +40,6 @@ config TIMESTAMP
 
 config FIT_EXTERNAL_OFFSET
 	hex "FIT external data offset"
-	depends on FIT
 	default 0x0
 	help
 	  This specifies a data offset in fit image.
@@ -49,7 +50,6 @@ config FIT_EXTERNAL_OFFSET
 
 config FIT_FULL_CHECK
 	bool "Do a full check of the FIT before using it"
-	depends on FIT
 	default y
 	help
 	  Enable this do a full check of the FIT to make sure it is valid. This
@@ -59,7 +59,7 @@ config FIT_FULL_CHECK
 
 config FIT_SIGNATURE
 	bool "Enable signature verification of FIT uImages"
-	depends on DM && FIT
+	depends on DM
 	select HASH
 	imply RSA
 	imply RSA_VERIFY
@@ -97,7 +97,7 @@ config FIT_RSASSA_PSS
 
 config FIT_CIPHER
 	bool "Enable ciphering data in a FIT uImages"
-	depends on DM && FIT
+	depends on DM
 	select AES
 	help
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
@@ -105,7 +105,6 @@ config FIT_CIPHER
 
 config FIT_VERBOSE
 	bool "Show verbose messages when FIT images fail"
-	depends on FIT
 	help
 	  Generally a system will have valid FIT images so debug messages
 	  are a waste of code space. If you are debugging your images then
@@ -114,7 +113,6 @@ config FIT_VERBOSE
 
 config FIT_BEST_MATCH
 	bool "Select the best match for the kernel device tree"
-	depends on FIT
 	help
 	  When no configuration is explicitly selected, default to the
 	  one whose fdt's compatibility field best matches that of
@@ -124,7 +122,6 @@ config FIT_BEST_MATCH
 
 config FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by U-Boot"
-	depends on FIT
 	depends on SOCFPGA_SECURE_VAB_AUTH
 	help
 	  Allows doing any sort of manipulation to blobs after they got extracted
@@ -139,11 +136,12 @@ config FIT_IMAGE_POST_PROCESS
 
 config FIT_PRINT
         bool "Support FIT printing"
-	depends on FIT
         default y
         help
           Support printing the content of the fitImage in a verbose manner.
 
+endif # FIT
+
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
 	depends on SPL && FIT
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

