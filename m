Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A3C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DC5866AA;
	Thu, 31 Aug 2023 05:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzNtIemI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428A18657B; Thu, 31 Aug 2023 05:53:48 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE7D8657C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34ca2fcdf9fso1479915ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454023; x=1694058823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQr9mre2eJmguT0ShOpxiUvmZmqZXCtqliTUykNb7MI=;
 b=bzNtIemIljw+hgyKQ6/pXXzwVAHaGEphZZ3qaJrnBDj0zVo24osZrL+H6xanOxIk0K
 ZZAo9u25TTKE1WmR65plf71AMSSuqZip0vonclSZXtb6bCXHNGyBxPifOH5dzbX+b6GM
 bsFn/LR5+sLmN76EWfbmFOwRq0+l+5s8SBk8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454023; x=1694058823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQr9mre2eJmguT0ShOpxiUvmZmqZXCtqliTUykNb7MI=;
 b=LAfFgp2NxHWu9G94UazG7IVgAt7DwgUg2iKuGIZwrnFrag2tE8AuHdLvAHy28esN0H
 FUsaaTe/G4cmTGuCYSUmCRlS+R/HKLaDtaJD5VZPvDZpDQA4+irg+3N1H7gbQP2pjdjh
 mtzyEz+Nh3DxOi/JgF4rfbh8pRS7NQEofHj31fGTReu+Wwq/rI2dG9LoIXTiLVCiSSze
 GrrRM4Bg/uG43GwQbhSuBd6MSAiRN/GlQfizys7/ohZH2zURxtZSTfDEUzkjYw651t2k
 XDFX7p3yXBlQyUl+NWa0UuWvNN5E+r6HfxUHWeXLWD6dYnU8ebSFvEdsrl20HT+qj3FU
 +zGg==
X-Gm-Message-State: AOJu0Yy4SwoA7cfvAYrFHiv/ZGFZNRcM3UK5a4343dDyjfOMhBvOGtmw
 d9boc7RBodmRUPsNlBoWKYilvBYMz/sAuan9ifI=
X-Google-Smtp-Source: AGHT+IGanBRT56z02wcjPCcV5zKCNkvKSj9OHOTOsn/aQ0upFu+e7pe3jP53TREgT9cH9COWfpRztg==
X-Received: by 2002:a05:6e02:12a6:b0:349:862e:a862 with SMTP id
 f6-20020a056e0212a600b00349862ea862mr4055536ilr.20.1693454023715; 
 Wed, 30 Aug 2023 20:53:43 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 17/19] Mark DISTRO_DEFAULTS as deprecated
Date: Wed, 30 Aug 2023 21:53:11 -0600
Message-ID: <20230831035319.2316665-18-sjg@chromium.org>
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

Standard boot has been in place for a while now. Quite a few problems
have been found and fixed. It seems like a good time to mark the
script-based approach as deprecated and encourage people to use standard
boot.

Update the DISTRO_DEFAULTS Kconfig to encourage people to move to
standard boot, which is able to boot Linux distributions automatically.

Add a short migration guide to make this easier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Mention in the DISTRO_DEFAULTS option that it is script-based
- Expand and rewrite the commit message
- Use the word 'Mark' instead of 'Make' to improve the English

 boot/Kconfig            |  7 ++++++-
 doc/develop/bootstd.rst | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 458512a4ade2..a7dea0a0623b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -784,7 +784,7 @@ config SYS_BOOT_RAMDISK_HIGH
 endmenu		# Boot images
 
 config DISTRO_DEFAULTS
-	bool "Select defaults suitable for booting general purpose Linux distributions"
+	bool "(deprecated) 'Script-based booting of Linux distributions"
 	select BOOT_DEFAULTS
 	select AUTO_COMPLETE
 	select CMDLINE_EDITING
@@ -792,6 +792,11 @@ config DISTRO_DEFAULTS
 	select HUSH_PARSER
 	select SYS_LONGHELP
 	help
+	  Note: These scripts have been replaced by Standard Boot. Do not use
+	  them on new boards. See 'Migrating from distro_boot' at
+	  doc/develop/bootstd.rst
+
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
2.42.0.rc2.253.gd59a3bf2b4-goog

