Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B7C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41678694A;
	Thu, 24 Aug 2023 21:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PRe8Zf9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E33086A3E; Thu, 24 Aug 2023 21:59:48 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777B8868B8
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79276ee1abaso6492039f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907184; x=1693511984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtRp1A9+7Czr8rAXSPVIgIKQkLokPhW5FYVjTWtGu3A=;
 b=PRe8Zf9HXIHKk86jXVym1wswL0J27Tiz3GbzQZjEeqVxU5ftoe6AxH8qqg2NHAcz5A
 feeK+2S23JKyGFl4GW5Ff4FPzH0VZ4R56RjL/qtZk97m4XolR9fOwyhQvtfqGwOyHUal
 P5EW3SBM9uTA0QzrSB53NnqeQruogs72sI/L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907184; x=1693511984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtRp1A9+7Czr8rAXSPVIgIKQkLokPhW5FYVjTWtGu3A=;
 b=JwU9QFPHnAOLIYtf6Bqf8PuoqzeFR9KsFXX4GDx8lhrUXCsXEHZLIBlcrIFG2Dqe59
 p8aikDp1Qum2nr/m11Jf0/PpHVYU9/FOBbUzakokbTl/eGs5HthTnZ2E/yX1OgzIWprH
 Jt0YqLv0WNxZsfGVbMJgphJovZ3bpOVXo+2aan72LaTvejWpBz7/xr2MJ7VhBihNt5J9
 bVgHmp3FKz3FoVI4jX5TYTCC5+X7fyfdMDdfGedRLffIumqdt+meUFnu3svACgsdKOiB
 HgtYz3f4A/YSZGyjUSp+HuyiZ+tY1Wml3qHTzhsuVOtsflG3wXsd9RAyBhsbpqUphYMQ
 TuZA==
X-Gm-Message-State: AOJu0YxYUv3Jca+586nMMCt4MVquTSb5hS2XCEugbDb72MsOf4qg5BAt
 O0hlBY7aDNa7r2Tii4gKQyABGdl11xfFUp2b6ac=
X-Google-Smtp-Source: AGHT+IEUplGRUyQcFWdX4FC0mAd6T3ajv68uC57Tap5jnQKtuqZjDDPgF45WPFjmjATKWRfA3mKmpw==
X-Received: by 2002:a5d:9544:0:b0:792:70c2:9db1 with SMTP id
 a4-20020a5d9544000000b0079270c29db1mr2536513ios.1.1692907184095; 
 Thu, 24 Aug 2023 12:59:44 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 17/19] Make DISTRO_DEFAULTS as deprecated
Date: Thu, 24 Aug 2023 13:59:08 -0600
Message-ID: <20230824195917.1687886-18-sjg@chromium.org>
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

Encourage people to move to distro boot. Add a short migration guide.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig            |  7 ++++++-
 doc/develop/bootstd.rst | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 02b33323d726..4742ee2027bd 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -781,7 +781,7 @@ config SYS_BOOT_RAMDISK_HIGH
 endmenu		# Boot images
 
 config DISTRO_DEFAULTS
-	bool "Select defaults suitable for booting general purpose Linux distributions"
+	bool "(deprecated) 'Defaults suitable for booting general purpose Linux distributions"
 	select BOOT_DEFAULTS
 	select AUTO_COMPLETE
 	select CMDLINE_EDITING
@@ -789,6 +789,11 @@ config DISTRO_DEFAULTS
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
index ec3136535783..8b2f0849a1c0 100644
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
 
@@ -768,3 +790,4 @@ Other ideas:
 .. _BootLoaderSpec: http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/
 .. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
 .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
+.. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
-- 
2.42.0.rc1.204.g551eb34607-goog

