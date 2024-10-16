Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA36BD20698
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB0BE85B66;
	Wed, 16 Oct 2024 05:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lieZyNr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EF4889AA; Wed, 16 Oct 2024 05:42:42 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC97182BA7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 05:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7afc658810fso552708385a.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729050159; x=1729654959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Xv6WVCXxE+VHfQ3GB52IJzF7xdIu69e1LG6ewaP5pk=;
 b=lieZyNr+/kA7PxhLQdJnyaP/8gZ0VNH+w+Qmd3/g31stlELq5QiJOJrDWIMf1oI70f
 QeuPjOhRP9UxVSX48ayq9qUD9X3m6YXyGMtmRhaJ03IK5NRHMRlM6ROqc5AlfiBZY61x
 rOygGU1uJeVRwFLCqFkw2uM7LdCjKOYA67wFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729050159; x=1729654959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Xv6WVCXxE+VHfQ3GB52IJzF7xdIu69e1LG6ewaP5pk=;
 b=lwgqL3gKcnqjSOVcPM5AgYvNa53/cFNaWV9NEgpuRKp6PjaEd2egVMhs4ugVl2LKVY
 MEP9sSNQISc5Zo4gN8SkZ6JAkBNBkRiKf1beQ4DABu7KxfSTcFMBTr9ll9NbCkew9+7w
 ByK7Zw1mtcXOdeYtn5hU/Fw3jItZA2KB8ESX0gonSLNOM2ja+8g7ykm1VOwJUQVohozD
 cq67j61OSMQQJMZkLHRmQ1r1N3ueT6QqyJk1zW3IBLutEhoO6Q9XHaT3iq4HPREVN2Gi
 P9pYKVhGOwlyohw7+4HLDknx/6+zEgWj2siCQtMkfPyPWqq6H302eTiqDaseAl1U4Cx4
 yIgQ==
X-Gm-Message-State: AOJu0YwtmiqrVu0NSDFQRJLMkuWbfh2H+2jzRaSDjGBVdCdjRfs0sCoD
 M52mwsUXZnJsKlWKpZesrLFPQWdMYpRfZPCXUaaI/oXDTQ0BSeUazj84xhMHxDSS7NVe9Nb5m32
 TiDQ=
X-Google-Smtp-Source: AGHT+IEJm5MLHDAWoFx0pw0dXwZHaTm+2xUjig+ZWiBTezysE+t9WJaZsf5V5UsCQzrYIIBKMGcoFw==
X-Received: by 2002:a05:620a:2728:b0:7b1:448d:ea53 with SMTP id
 af79cd13be357-7b1448deadamr181549585a.21.1729050158528; 
 Tue, 15 Oct 2024 20:42:38 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136164dfbsm136470685a.21.2024.10.15.20.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 20:42:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] Revert "Makefile: Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE
 support" changes
Date: Tue, 15 Oct 2024 21:42:35 -0600
Message-ID: <20241016034235.89354-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

:hile we had hoped to be able to remove these options finally, it was
missed that zynq still requires these currently.

This reverts commit 5b9261fb0b1ed087387f2036d279fd3f4bb20a61 and
commit 099b6df556c95f5d06864612e9199eab7ba50ed3.

Reported-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile                | 24 ++++++++++++++++++++++++
 boot/Kconfig            | 23 +++++++++++++++++++++++
 doc/usage/fit/howto.rst |  9 +++++++++
 3 files changed, 56 insertions(+)

diff --git a/Makefile b/Makefile
index 0005e999a657..3267fb1c469a 100644
--- a/Makefile
+++ b/Makefile
@@ -1145,6 +1145,13 @@ ifeq ($(CONFIG_OF_EMBED)$(CONFIG_EFI_APP),y)
 	@echo >&2 "CONFIG_OF_SEPARATE for boards in mainline."
 	@echo >&2 "See doc/develop/devicetree/control.rst for more info."
 	@echo >&2 "===================================================="
+endif
+ifneq ($(CONFIG_SPL_FIT_GENERATOR),)
+	@echo >&2 "===================== WARNING ======================"
+	@echo >&2 "This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate"
+	@echo >&2 "to binman instead, to avoid the proliferation of"
+	@echo >&2 "arch-specific scripts with no tests."
+	@echo >&2 "===================================================="
 endif
 	$(call deprecated,CONFIG_WDT,DM watchdog,v2019.10,\
 		$(CONFIG_WATCHDOG)$(CONFIG_HW_WATCHDOG))
@@ -1412,6 +1419,23 @@ OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
 u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
 	$(call if_changed,objcopy)
 
+# Boards with more complex image requirements can provide an .its source file
+# or a generator script
+# NOTE: Please do not use this. We are migrating away from Makefile rules to use
+# binman instead.
+ifneq ($(CONFIG_SPL_FIT_SOURCE),"")
+U_BOOT_ITS := u-boot.its
+$(U_BOOT_ITS): $(subst ",,$(CONFIG_SPL_FIT_SOURCE))
+	$(call if_changed,copy)
+else
+ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
+U_BOOT_ITS := u-boot.its
+$(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
+	$(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
+	$(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
+endif
+endif
+
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
diff --git a/boot/Kconfig b/boot/Kconfig
index 4314227d5f86..925afe06a19f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -282,6 +282,29 @@ config SPL_FIT_IMAGE_POST_PROCESS
 	  injected into the FIT creation (i.e. the blobs would have been pre-
 	  processed before being added to the FIT image).
 
+config SPL_FIT_SOURCE
+	string ".its source file for U-Boot FIT image"
+	depends on SPL_FIT
+	help
+	  Specifies a (platform specific) FIT source file to generate the
+	  U-Boot FIT image. This could specify further image to load and/or
+	  execute.
+
+config USE_SPL_FIT_GENERATOR
+	bool "Use a script to generate the .its script"
+	depends on SPL_FIT
+	default y if SPL_FIT && ARCH_ZYNQMP
+
+config SPL_FIT_GENERATOR
+	string ".its file generator script for U-Boot FIT image"
+	depends on USE_SPL_FIT_GENERATOR
+	default "arch/arm/mach-zynqmp/mkimage_fit_atf.sh" if SPL_LOAD_FIT && ARCH_ZYNQMP
+	help
+	  Specifies a (platform specific) script file to generate the FIT
+	  source file used to build the U-Boot FIT image file. This gets
+	  passed a list of supported device tree file stub names to
+	  include in the generated image.
+
 if VPL
 
 config VPL_FIT
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index 675c9aa5bb0f..b5097d4460bf 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -57,6 +57,15 @@ own subnode under the /images node, which should then be referenced from one or
 multiple /configurations subnodes. The required images must be enumerated in
 the "loadables" property as a list of strings.
 
+If a platform specific image source file (.its) is shipped with the U-Boot
+source, it can be specified using the CONFIG_SPL_FIT_SOURCE Kconfig symbol.
+In this case it will be automatically used by U-Boot's Makefile to generate
+the image.
+If a static source file is not flexible enough, CONFIG_SPL_FIT_GENERATOR
+can point to a script which generates this image source file during
+the build process. It gets passed a list of device tree files (taken from the
+CONFIG_OF_LIST symbol).
+
 The SPL also records to a DT all additional images (called loadables) which are
 loaded. The information about loadables locations is passed via the DT node with
 fit-images name.
-- 
2.43.0

