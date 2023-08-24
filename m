Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFA1C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B733586A3E;
	Thu, 24 Aug 2023 21:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LMiW7So8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B96869EA; Thu, 24 Aug 2023 21:59:45 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595AE86A57
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79216d8e2cfso7403439f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907179; x=1693511979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BslicSxK603wtNS0Z0yxlHsHQYRh8iWnrk2aKQN0qdQ=;
 b=LMiW7So8cjJ5JPsYJU3pP5t3JlBqDTolY/OA0l4F8RIt+5qZ9s8VpZA/zlG3TKGAIg
 Mty4M0Lab9q49c/HWOX/019CLVeYOkg1MRwsH0V6dfHXwdDhXPh0jBUr4oJjBYjlil1P
 mx48Yi0sFiRi2DoWmZtjmiW4tCbVt7Ld2ZUJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907179; x=1693511979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BslicSxK603wtNS0Z0yxlHsHQYRh8iWnrk2aKQN0qdQ=;
 b=UPjDfaNqWJRdt46rRiDGbEhWjgWUzpzX8D2ddSZY4vY7r+0L6XSuXBfjS0nOXMDIKE
 bxrZ9uD9EzPbP6OwXqmBp1h7tmIwNhK5GUP/eMYgKFrRkP1deG3xu9ovp/AvoSrjetsQ
 vUM505P0J7DWwjfhJXJCmqIbqvpvpN5UvSKGC3MFk7BDlOufec820UarOxu9itEzF0wl
 /lMjems4/ab2kBJVjDhV6NUdAofeOawq88181aJial9ubcV7YPvHn5PGWwkdKXRkdetY
 b6sxlVLLtDzx/pk1AmBJPuLkHG4owKUKBOOw1SaLHU+ltGHAnpKlED5EadBaN9zLNQSD
 NMCw==
X-Gm-Message-State: AOJu0YwCxvfs5OOjEHiHfTvlDNo4Dneqe+msogCoVED8QdXd6ZTNg8I0
 GAl6OM7nCm9uEy2TgKSnr4OiHcFajGhvHo1lwKg=
X-Google-Smtp-Source: AGHT+IFFJid0thZbWRYc8HVDDReOq0ptAOzu9a59v0jnk4azko3zmtD2kRPjB3TzZT+sHpI9JoSYPQ==
X-Received: by 2002:a5e:aa0f:0:b0:783:57ae:1894 with SMTP id
 s15-20020a5eaa0f000000b0078357ae1894mr7263953ioe.9.1692907178996; 
 Thu, 24 Aug 2023 12:59:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 12/19] Kconfig: Create a menu for FIT
Date: Thu, 24 Aug 2023 13:59:03 -0600
Message-ID: <20230824195917.1687886-13-sjg@chromium.org>
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

This is a major feature with a lot of options. Give it its own menu to
tidy up the 'make menuconfig' display. Drop the 'depends on FIT' pieces
which are now unnecessary, since they are now bracketed by an 'if FIT'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e378d9cdb4ff..bc3a68402a15 100644
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
2.42.0.rc1.204.g551eb34607-goog

