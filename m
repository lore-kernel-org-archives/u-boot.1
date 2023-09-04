Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB2C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3439C869F7;
	Mon,  4 Sep 2023 16:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uzwe/Mm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1362869F2; Mon,  4 Sep 2023 16:41:55 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0DF869B6
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34ca1aadcccso5388605ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838511; x=1694443311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO1qNUb5TlKyTrV+QW2lrs9qzTaSP/6oCwMO37mzZpQ=;
 b=Uzwe/Mm2idJokhIatPVQ0+je7INDyyMucwuNVJlGFBWr3mebx7Dl/bSCMlBhu6ssHt
 YUxTteIsyGJkdqZqWhrWJyyEY4ippbBt02ZUT8QYgVyUROiDbtJnlTox3myqCp1QMR+E
 ZLkfDAm5GIQL1lZEU5OZ+SjcKUriatlvHgwtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838511; x=1694443311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JO1qNUb5TlKyTrV+QW2lrs9qzTaSP/6oCwMO37mzZpQ=;
 b=Sin0iAQKz/VY4kK6IKRQ7J6pAAa5gIO1bkYKICXbYA5IT9ZM7hgi0UsvVnBqHzyLjo
 blxFZFTqJKpKzO2Aa8M8PNEIwop7qwT8g1HhVaaZojKmyK0x9XYOGv754YwndsKgFqcR
 TLL3z1OMpt7MsUch9HpseX1H57W6PzhAnZmWifPr34Kjs1PqOXuV79fjjFUyYJw14P9/
 KwszIEfQ0lnae1LTAOYmqNkkgu0f556UBRiX9pGAs+wxFkZoL7NStY+mJpLRFFXOZF7l
 8bIIofOXwL6dSxcehq3Qx4qO5RPfj9FUmVrAxuwh/a3qQ3jINWwCIxm5CqR9BIiH5w1g
 8sBQ==
X-Gm-Message-State: AOJu0YyQf6ef9a3IdOwNhZe0mIrALv2ZR5264p/peI8gx6LEE5JuHcHD
 oLQt6Axnc4BEmg86lAKxXy8cMrPaheVrX5tiKO8=
X-Google-Smtp-Source: AGHT+IH/G5D4Xn3IWtWM8AFimtpjJAZrJ+1QhJfQX5Cr+jYVgMWEHtRlt3LYJBWleE+8T1nH6rTptQ==
X-Received: by 2002:a05:6e02:1d11:b0:347:6b30:5bd3 with SMTP id
 i17-20020a056e021d1100b003476b305bd3mr13693211ila.13.1693838510960; 
 Mon, 04 Sep 2023 07:41:50 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 12/20] Kconfig: Create a menu for FIT
Date: Mon,  4 Sep 2023 08:41:15 -0600
Message-ID: <20230904144131.2699824-13-sjg@chromium.org>
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
2.42.0.283.g2d96d420d3-goog

