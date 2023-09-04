Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767CC83F3F
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFF286A12;
	Mon,  4 Sep 2023 16:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQXYvSg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AA386940; Mon,  4 Sep 2023 16:42:02 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3EC86932
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34f1bcfe044so1393355ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838518; x=1694443318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vV5t7518eWHsYi9bG7htimx6CYdGctgjMuZfiYlmEA=;
 b=CQXYvSg8ibA4SwKC/Uk+ONo663a7MNaa7mK6Y6KdSXVxNr6ehQiuwAQJ8aJWPYl9k2
 75rlUAKRZc2OSQXihm5yHx+6hd+P/wFAldTYN4zx8AwTrWmrHWU0Wv346GCzZ+tph/HW
 eRG1j3/BY4fK4S57lMJpringET/eld7XUYBH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838518; x=1694443318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vV5t7518eWHsYi9bG7htimx6CYdGctgjMuZfiYlmEA=;
 b=dl4lKYP/mSt72pct7Hzh0+yRSYahYXcVUwJGFoxeD6bZ4Bd0u9oy1o8KyUy+uVZocY
 +jAF6AURB/ew0fN1++WeeUmeW7UpsKrrLMOq3rUMV2Np0MTvUJ2V8iCPUImZFN9hLf36
 ex84NTl1rjDK9fgUaf5mFwB6xvAZzkWExDePZ4z2zTJpNrabYewoM86IQAJQCtKwIZ+i
 puLUSS2HpxtbW7FEH+oaDadR6/vEYnRvrXuMXh8gG0+LnNPrZaMrJbf8wJfHuf5oTkOE
 s0ydoVNlnDgPJG4Ba1QU/ZgLqgu8EM8054dSWgpAn/WFrYFmJZB+K0yL1zSDmB0TjCnN
 izRw==
X-Gm-Message-State: AOJu0Yx8yvH+drHeU6VllSpVPavAydiDmF3u26mjxD9KsGP6hS6+GQkg
 VQ8C7YbBkw6+hM37imCZNnKCBx2YjSaNWwv9pI4=
X-Google-Smtp-Source: AGHT+IH+6QlrH7tfhqXNHFv2WpZ6kIxCJ2gvtTZ0AQwihvURG8pXtTcYeTxZvq2rOHhETzaPBShoQA==
X-Received: by 2002:a92:d6ca:0:b0:34c:e16d:6793 with SMTP id
 z10-20020a92d6ca000000b0034ce16d6793mr10779919ilp.14.1693838517912; 
 Mon, 04 Sep 2023 07:41:57 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/20] Mark DISTRO_DEFAULTS as deprecated
Date: Mon,  4 Sep 2023 08:41:20 -0600
Message-ID: <20230904144131.2699824-18-sjg@chromium.org>
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

Standard boot has been in place for a while now. Quite a few problems
have been found and fixed. It seems like a good time to mark the
script-based approach as deprecated and encourage people to use standard
boot.

Update the DISTRO_DEFAULTS Kconfig to encourage people to move to
standard boot, which is able to boot Linux distributions automatically.

Add a short migration guide to make this easier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop extra newline and quote

Changes in v2:
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

 boot/Kconfig            |  6 +++++-
 doc/develop/bootstd.rst | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 458512a4ade2..08efecb13ef6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -784,7 +784,7 @@ config SYS_BOOT_RAMDISK_HIGH
 endmenu		# Boot images
 
 config DISTRO_DEFAULTS
-	bool "Select defaults suitable for booting general purpose Linux distributions"
+	bool "(deprecated) Script-based booting of Linux distributions"
 	select BOOT_DEFAULTS
 	select AUTO_COMPLETE
 	select CMDLINE_EDITING
@@ -792,6 +792,10 @@ config DISTRO_DEFAULTS
 	select HUSH_PARSER
 	select SYS_LONGHELP
 	help
+	  Note: These scripts have been replaced by Standard Boot. Do not use
+	  them on new boards. See 'Migrating from distro_boot' at
+	  doc/develop/bootstd.rst
+
 	  Select this to enable various options and commands which are suitable
 	  for building u-boot for booting general purpose Linux distributions.
 
diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index c01e0971dc84..ddcd05f931ad 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -458,6 +458,28 @@ ready    File was loaded and is ready for use. In this state the bootflow is
 =======  =======================================================================
 
 
+Migrating from distro_boot
+--------------------------
+
+To migrate from distro_boot:
+
+#. Update your board header files to remove the BOOTENV and BOOT_TARGET_xxx
+   defines. Standard boot finds available boot devices automatically.
+
+#. Remove the "boot_targets" variable unless you need it. Standard boot uses a
+   default order from fastest to slowest, which generally matches the order used
+   by boards.
+
+#. Make sure that CONFIG_BOOTSTD_DEFAULTS is enabled by your board, so it can
+   boot common Linux distributions.
+
+An example patch is at migrate_patch_.
+
+If you are using custom boot scripts for your board, consider creating your
+own bootmeth to hold the logic. There are various examples at
+`boot/bootmeth_...`.
+
+
 Theory of operation
 -------------------
 
@@ -769,3 +791,4 @@ Other ideas:
 .. _BootLoaderSpec: http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
 .. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
 .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
+.. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
-- 
2.42.0.283.g2d96d420d3-goog

