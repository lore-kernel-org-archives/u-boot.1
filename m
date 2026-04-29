Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C44ECCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E714848BF;
	Wed, 29 Apr 2026 16:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uZkIW3KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9877D848C5; Wed, 29 Apr 2026 16:46:43 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171F1848BF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CF89CC5EF2A
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:47:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9AE06601DF;
 Wed, 29 Apr 2026 14:46:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0797410729F63; 
 Wed, 29 Apr 2026 16:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777473999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Y/AgHeXrmyda9GTcDIbQ262lNG8IfGJLIDQkjT+gQoM=;
 b=uZkIW3KQoimINfN66pHGczkq/70eyLZHwPWVpyIlXfO6YV7//uvyP6MaUWq+JT10sy0G8+
 df4CcM5UCKhRe75IUrM+DirVI6wNAAA4Qj6tQtrKMqa6sAyAB+vq9wZJRYYqJAgrIcZ4Hc
 acpa0P/6MCO/iGg9LgCEk9w9wPGs7oOWlD2shN+PxdOg9wa4z9VblVZ8WQugT5X3k3JGG/
 En+kfKFQgJwoNXNE/g08cHeugSU5Zj+nINmdv2Galb41U4ba0L2SJ8wOO3FeqWw4Thb8cv
 aSbDr/hNS5yPXOtcwoexCPJSxrOZC+SIi2xCTZTOrw0AH2RrrSKDAMVs5aJeAA==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, quentin.schulz@cherry.de,
 marek.vasut@mailbox.org,
 =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [PATCH] scripts/dtc: drop yaml in DT validation
Date: Wed, 29 Apr 2026 16:46:15 +0200
Message-ID: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The build issues found in dtc/yamltree were partially mitigated by a
previous commit (807bcd844a: "scripts/dtc: Fix pkg-config behavior under
sysroot"), but upstream dtc simply disabled yaml, and the same should be
done here in order to permanently avoid those issues.

Backport the change below from Linux v5.18 [1]:

ef8795f3f1c ("dt-bindings: kbuild: Use DTB files for validation")

I tested this patch with a couple Yocto builds: u-boot and u-boot-tools,
using the current master branch (rev. "c53b0708f9"), having removed
libyaml-native from u-boot-tools's dependencies.

[1] https://git.kernel.org/linus/ef8795f3f1ce

Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
---
 scripts/Makefile.lib             | 6 ------
 scripts/dtc/Makefile             | 8 --------
 scripts/dtc/update-dtc-source.sh | 2 +-
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b8969b7de54..d66f1ed13b1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -86,12 +86,6 @@ base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m,
 extra-y				+= $(dtb-y)
 extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
 
-# U-Boot specific
-ifneq ($(CHECK_DTBS),)
-extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
-extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
-endif
-
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 6f309b37e08..2ba8dba03be 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -17,15 +17,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS := -I$(srctree)/$(src)/libfdt
 
-ifeq ($(wildcard $(PKG_CONFIG_SYSROOT_DIR)/usr/include/yaml.h),)
 HOST_EXTRACFLAGS += -DNO_YAML
-else
-dtc-objs	+= yamltree.o
-# To include <yaml.h> installed in a non-default path
-HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
-# To link libyaml installed in a non-default path
-HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
-endif
 
 # Generated files need one more search path to include headers in source tree
 HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 32ff17ffd08..94627541533 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
+		srcpos.h treesource.c util.c util.h version_gen.h \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.47.0

