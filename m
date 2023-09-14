Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F10EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD058709C;
	Thu, 14 Sep 2023 18:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HC4kSoTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C607870C5; Thu, 14 Sep 2023 18:56:52 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F0A8708F
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-795547f055fso40791039f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710608; x=1695315408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7qvJaOzhNpUrZXrb6rcFBil/fMygzfOssQkug0BoTI=;
 b=HC4kSoTg1S8oaCrLZEmVm+HWvZrz9TAQA2sVTOw8hNAz1AnnKIUi75z+qEMRDf01UB
 QwqDa3aslj9DyguaTJwXDVcShgiBMkqSz/d+ikxYiy1hlIrH+mUnKk1AuGPqlZCfTHXk
 IBCMrfy+B+8YPBweiSAu6I60TVQMa82GcSkFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710608; x=1695315408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7qvJaOzhNpUrZXrb6rcFBil/fMygzfOssQkug0BoTI=;
 b=TZ2/8PibQmxvj+IJtr3PSJ6DAogFPmUhDYKc0gq0/Zbj+s4MA4B8Cog3kfv73K4Gf+
 RMcPxAd/F4dDSi8ep5YbJOv+lQ3TGSFZF+Bl4blXHcnivPaV/lcEFgFbl1n8PKVresNw
 Miu/EpnpIoTubHNqkobWaMxcmk87oA6RH9LsxVNWAXUa0skZCtKK4eTSrE8pUEF+Cteg
 oxH2NGmSgYvDMFwytEwjAr3xTl3kDgzDSmt1z398UU2e5r87sYcJiWayLOqFGrkpZ9MN
 /26suwZpxnsi0wbfvL8O189X7vlZyi2fmFSqNhqGLG7wNVBwBzDnX22CYCwvAS1dcLHX
 s87Q==
X-Gm-Message-State: AOJu0Yypi6G/XDsnAZN/HoSLl0s6NwVTpKz+D/ZOCfpykjl9Tu0DB0BV
 wKDoY6b/Xi3WJeeUCUDU9AGVyfWDxRKhOYZ5w04=
X-Google-Smtp-Source: AGHT+IGoXkzTi7jZrMFhVAxcN8Bs/EcECnmsSGRDMMsCBNup7DMhMbtompdpYlPfoGRSkxVajcKTjw==
X-Received: by 2002:a5d:9d8a:0:b0:799:178c:7be5 with SMTP id
 ay10-20020a5d9d8a000000b00799178c7be5mr9667167iob.17.1694710608389; 
 Thu, 14 Sep 2023 09:56:48 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 17/21] Mark DISTRO_DEFAULTS as deprecated
Date: Thu, 14 Sep 2023 10:55:55 -0600
Message-ID: <20230914165615.1058529-17-sjg@chromium.org>
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

Standard boot has been in place for a while now. Quite a few problems
have been found and fixed. It seems like a good time to mark the
script-based approach as deprecated and encourage people to use standard
boot.

Update the DISTRO_DEFAULTS Kconfig to encourage people to move to
standard boot, which is able to boot Linux distributions automatically.

Add a short migration guide to make this easier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

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
index 4ebcf310911..7ef44a26fb9 100644
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
index e8b90752f08..6172dc906bd 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -464,6 +464,28 @@ ready    File was loaded and is ready for use. In this state the bootflow is
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
 
@@ -775,3 +797,4 @@ Other ideas:
 .. _BootLoaderSpec: http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
 .. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
 .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
+.. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
-- 
2.42.0.459.ge4e396fd5e-goog

