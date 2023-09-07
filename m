Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA4DEC873E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E66686ABD;
	Thu,  7 Sep 2023 18:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T28dsdQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7288486ABD; Thu,  7 Sep 2023 18:00:00 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37AF86AFB
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34e2aad3f8bso4596985ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102394; x=1694707194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLv1ju3puwoSKC0R10etIatcgh63WC+Hs4JtnYs7it4=;
 b=T28dsdQJeQCNjEcEFsZpudOKphxM07ttUKKJh6sVwREoIn2T5PNWUiu1HpFHNSQLcj
 FBa9aOQZaYN1uvXjKYl0xzt+cZSAqJqyeQvz5AdIe4wX/6BSsz/HirzM9hZZrKRwTe+P
 B/r+6794BNA2rBc7wvxC7HW4iBnkIEDCBfJao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102394; x=1694707194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLv1ju3puwoSKC0R10etIatcgh63WC+Hs4JtnYs7it4=;
 b=EiyPJ6TdqaC3e+emY1BgILyZ6zubXPD/sp/tlTnRLmvWvjYCznVle57tWnRGzE30RH
 kSj9cieb7aI098vD8w2NbvfF1WiF+4H4iHXzfzGA+5jEgykTmaVOdSliPRtJ7itOwQNq
 1GdgQ4Q5ma9yFicNQWPzp2kr2M/qnnyQR6PQRGlOToVOGBQLJZXdrnn8bvLTGK3FVSOY
 7NYe9Y5kt8RDem7nNp/Xi0QLdumtB4nFupc6Kq3cjc0PFR8q/gO5HDI5LyRtAYhJNp7B
 74RJWjB6X3HHizeLIFFm2nMCIcWeqbgkdLLnbaYu8iT5rDzUZ6aRh+1F6Hy8rSWCQvbq
 u1Gw==
X-Gm-Message-State: AOJu0YyXUmgdd9EmaWf79nnd9m5Z98bjDWDfcEGV7lZP7fnWSMUmaHOH
 lWYvEntGCQ+bphCRYc/KTSXkBj81AT7yyi60Q7c=
X-Google-Smtp-Source: AGHT+IFm8ZMOETSKksdDITCFFBCXBYXhEmd52xkD66oUzRoZ4AnFs8DJVfXvp9fav01MJdQDEH0qHg==
X-Received: by 2002:a05:6e02:1bae:b0:34c:c8e8:ca87 with SMTP id
 n14-20020a056e021bae00b0034cc8e8ca87mr149539ili.20.1694102394340; 
 Thu, 07 Sep 2023 08:59:54 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/22] Mark DISTRO_DEFAULTS as deprecated
Date: Thu,  7 Sep 2023 09:59:23 -0600
Message-ID: <20230907155933.48511-19-sjg@chromium.org>
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
index 4ebcf3109113..7ef44a26fb92 100644
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
index e8b90752f083..6172dc906bde 100644
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
2.42.0.283.g2d96d420d3-goog

