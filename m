Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870CEEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A078086B16;
	Thu,  7 Sep 2023 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JVxCdq4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7EC86AFA; Thu,  7 Sep 2023 17:59:54 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9468286ACB
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-794c7d95ba5so46553939f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102389; x=1694707189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exw6NQMiT9vP9DRkiw0iggFLQArW04Aa/pGSc3aenEk=;
 b=JVxCdq4TU1tXK5c3lRkRpWBFDBXD2jcSuVTPJ444LnHPO3g+NcPiaSvfLPhV4ikqVQ
 zOkdDKE0mG8ugc/oup5oExzZMcG7dm9E/bqcvE2ss7Va5F0m7yB5hKITMKDfzlFzMPmj
 DsjHCL1oaNzPPyuCmf3AIPhO/BK/JfYvvDWyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102389; x=1694707189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exw6NQMiT9vP9DRkiw0iggFLQArW04Aa/pGSc3aenEk=;
 b=G4l0Z06rL/+EPKB7kbkBSWbOhS+3/zVeTALRkoINg2GU2pNcuXssKtPEWiysvL6FSV
 M9DaGVCYdIa/lF2KPovAlAhMby+2Ii5nN4mOIsvYrV+R93EvQ4dT4802nhzRSq44t3Mg
 JDwyGTHg7SGjcdB0HL5rvMUfAvWD8tmCiI5E2YDy3xaIke6g/vfGtNfmof5BivC4dBnG
 MKJO8AC44o0tjqwrHGPZrgfzUpBqJioUKEg4vYHqJ0fNclcnpDEoEWbX867laY/wjJna
 l0PRfRRlAg+ev1UjxB7LwdmbBj5RwyMp9hWNj3u1jYxJZFgLhbM4evU6RkVZW7/MCzxm
 Ie3Q==
X-Gm-Message-State: AOJu0YwRW2Q47sUtWczuqk3aj9UTFerGkobXB4CYGIa2l3gvbpMkfIO9
 /5zlA35vqCF+2U9nxJxxQ9eeuCi5R0F9QCjBE00=
X-Google-Smtp-Source: AGHT+IEUupGPatVX2IEoF1oi0ZER0+gLSFFg9ZtUGeoUGx4As/6rL8j9bIe1wPA7DQR80Ii1US2XEQ==
X-Received: by 2002:a05:6e02:ca3:b0:34c:e16d:6793 with SMTP id
 3-20020a056e020ca300b0034ce16d6793mr106462ilg.14.1694102389244; 
 Thu, 07 Sep 2023 08:59:49 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 12/22] Kconfig: Create a menu for FIT
Date: Thu,  7 Sep 2023 09:59:17 -0600
Message-ID: <20230907155933.48511-13-sjg@chromium.org>
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

This is a major feature with a lot of options. Give it its own menu to
tidy up the 'make menuconfig' display. Drop the 'depends on FIT' pieces
which are now unnecessary, since they are now bracketed by an 'if FIT'.

Leave CONFIG_TIMESTAMP out since it affects legacy images too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Allow TIMESTAMP without FIT

 boot/Kconfig | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 017f7117d57f..99a2ffca2fc6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -9,8 +9,19 @@ config ANDROID_BOOT_IMAGE
 	  This enables support for booting images which use the Android
 	  image format header.
 
-config FIT
-	bool "Support Flattened Image Tree"
+config TIMESTAMP
+	bool "Show image date and time when displaying image information"
+	default y if CMD_DATE
+	help
+	  When CONFIG_TIMESTAMP is selected, the timestamp (date and time) of
+	  an image is printed by image commands like bootm or iminfo. This
+	  is shown as 'Timestamp: xxx' and 'Created: xxx'. If this option is
+	  enabled, then U-Boot requires FITs to have a timestamp. If a FIT is
+	  loaded that does not, the message 'Wrong FIT format: no timestamp'
+	  is shown.
+
+menuconfig FIT
+	bool "Flattened Image Tree (FIT)"
 	select HASH
 	select MD5
 	select SHA1
@@ -25,20 +36,10 @@ config FIT
 	  multiple configurations, verification through hashing and also
 	  verified boot (secure boot using RSA).
 
-config TIMESTAMP
-	bool "Show image date and time when displaying image information"
-	default y if CMD_DATE
-	help
-	  When CONFIG_TIMESTAMP is selected, the timestamp (date and time) of
-	  an image is printed by image commands like bootm or iminfo. This
-	  is shown as 'Timestamp: xxx' and 'Created: xxx'. If this option is
-	  enabled, then U-Boot requires FITs to have a timestamp. If a FIT is
-	  loaded that does not, the message 'Wrong FIT format: no timestamp'
-	  is shown.
+if FIT
 
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
2.42.0.283.g2d96d420d3-goog

