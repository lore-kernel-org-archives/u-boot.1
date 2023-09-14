Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCFEEAA5A
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CE8870C7;
	Thu, 14 Sep 2023 18:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KRlXVsn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61E9870B2; Thu, 14 Sep 2023 18:56:45 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97CB186F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso43929539f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710601; x=1695315401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzUyIztaIQ3pjN8EQPBewZL6c0xLyMQ01auuaFPtu3Y=;
 b=KRlXVsn3eOt8NEAk0xHQOS0Lu7chNq/7GhlcKaZfxSOmmIBRGIVeA4B+8h+ZBhrYha
 R20cDgHT41VfkZ4C8HdRJGGqqRe+cW8VW9KvxhnQkSqeAaI9BWOor72bgBopVJBlECpi
 0gPdvF9MZceGFBFbuZcYLePbuEBgONfoy7LuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710601; x=1695315401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzUyIztaIQ3pjN8EQPBewZL6c0xLyMQ01auuaFPtu3Y=;
 b=Urkm8yZGOkJsLgs5e6uOHpeewzXuQ/HVQGVgcAxWd8pgeguNNKy6lc/xFhGL+W3rKV
 IDEH+v+WALIYM1slhsz1XuNgQSqCPe6i/mn07EiGDS0Xh3vd3MNf2HqdeH9rIa3hLgpz
 JTW6NYW3s4Vv4Dz+3UzU92sIqPQTi3pNCweAmk3IefB08twrOan2UDm1PNoAjSEROQW3
 5kIWn379i8LE5jLolgkpj5ufLT1x1mq+/+LovnWkNuFq0fXHTHdoJvZ/Z22iwuh3fWmo
 vcDHZt/XTx8wEHZaaQCXY4/fIE/pp6kK8u5efLt+zHAynJkfgmdkNBXoQNJq5k1W0jth
 6New==
X-Gm-Message-State: AOJu0YxwZbj86ETtKvC3HUOct0b2E2GkE2mCgjjKMQvvKI+CX/B67pFM
 XjNHPGsJMRR1twPfibQzbTU5KXkXONNF5pkxeNM=
X-Google-Smtp-Source: AGHT+IHz+fJoDSZoTEzG/i8jBif+Jw2exbLPMnw/B1jYPzRvn3fDYfdjVGuxDnEMuiOzWrCVW6hRcQ==
X-Received: by 2002:a5d:83d5:0:b0:792:9a3e:2dd with SMTP id
 u21-20020a5d83d5000000b007929a3e02ddmr7008068ior.3.1694710601257; 
 Thu, 14 Sep 2023 09:56:41 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 11/21] Kconfig: Create a menu for FIT
Date: Thu, 14 Sep 2023 10:55:49 -0600
Message-ID: <20230914165615.1058529-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

(no changes since v4)

Changes in v4:
- Allow TIMESTAMP without FIT

 boot/Kconfig | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 017f7117d57..99a2ffca2fc 100644
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
2.42.0.459.ge4e396fd5e-goog

