Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47453C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 17:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8715D82AA7;
	Tue,  3 Jun 2025 19:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=novatechautomation.com header.i=@novatechautomation.com header.b="HQbeihZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E152582AAA; Tue,  3 Jun 2025 19:06:36 +0200 (CEST)
Received: from gw2.cammew.com (gw2.cammew.com [64.182.209.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1335582A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 19:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
Received: from eric-Desktop.novatech-llc.local (unknown [38.62.160.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gw2.cammew.com (Postfix) with ESMTPSA id 34AE1EDCCA;
 Tue,  3 Jun 2025 13:06:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 gw2.cammew.com 34AE1EDCCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=novatechautomation.com; s=relay; t=1748970392;
 bh=RRuy2vKPUTXqqyovYK+WSgMX6fKr43rY9XrSk/MZZb8=;
 h=From:To:Cc:Subject:Date:From;
 b=HQbeihZJp2g117cQ3bnL1DQvZ4StkwnwUL4xCHtI9XWd8ceDbFjrOxVVw2m3MGsBd
 ojRCu3s6HtoNTKyC9G0oeXMyRtsJQl5GJUTk5olW83FOkFOl4u02vqOwlsVlKtwggI
 npidsfMnXe3cJwX02tcqDJWkPY4xhYcFIArlAVZE=
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Subject: [PATCH] dtc: Add Kconfig option to pad device tree blob
Date: Tue,  3 Jun 2025 12:06:24 -0500
Message-Id: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
X-Mailer: git-send-email 2.34.1
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

This will allow arch(s) that use device tree blobs to pad the end of the
device tree so they can be modified by board files at run time. This will
help prevent errors such as FDT_ERR_NOSPACE from occuring.

Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
---
 arch/Kconfig                    | 7 +++++++
 arch/arc/dts/Makefile           | 2 +-
 arch/m68k/dts/Makefile          | 2 +-
 arch/microblaze/dts/Makefile    | 2 +-
 arch/nios2/dts/Makefile         | 2 +-
 arch/riscv/dts/Makefile         | 2 +-
 arch/sandbox/dts/Makefile       | 2 +-
 arch/x86/dts/Makefile           | 2 +-
 doc/board/broadcom/bcm7xxx.rst  | 6 ++----
 doc/develop/makefiles.rst       | 5 ++++-
 dts/upstream/src/arm64/Makefile | 2 +-
 dts/upstream/src/riscv/Makefile | 2 +-
 scripts/Makefile.dts            | 4 ++++
 13 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea33d07c086..bf4c2c80891 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -63,6 +63,13 @@ config SYS_CACHELINE_SIZE
 	default 64 if RISCV
 	default 32 if MIPS
 
+config SYS_DTC_PAD_BYTES
+	int "Size in bytes to pad device tree blob"
+	default 4096 if ARC || ARM64 || M68K || MICROBLAZE || NIOS2 \
+		|| RISCV || SANDBOX || X86
+	default 32768 if X86 && EFI_APP
+	default 0
+
 config LINKER_LIST_ALIGN
 	int
 	default 32 if SANDBOX
diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
index fe6ad7b849a..87c627c01c8 100644
--- a/arch/arc/dts/Makefile
+++ b/arch/arc/dts/Makefile
@@ -11,4 +11,4 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=  iot_devkit.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/m68k/dts/Makefile b/arch/m68k/dts/Makefile
index 8b354b9c570..0f06109aa06 100644
--- a/arch/m68k/dts/Makefile
+++ b/arch/m68k/dts/Makefile
@@ -21,4 +21,4 @@ dtb-$(CONFIG_TARGET_STMARK2) += stmark2.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
index 9be902d3bb1..0f3a7472a67 100644
--- a/arch/microblaze/dts/Makefile
+++ b/arch/microblaze/dts/Makefile
@@ -5,4 +5,4 @@ dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/nios2/dts/Makefile b/arch/nios2/dts/Makefile
index d77db9762a1..75951164978 100644
--- a/arch/nios2/dts/Makefile
+++ b/arch/nios2/dts/Makefile
@@ -5,4 +5,4 @@ dtb-y += $(CONFIG_DEFAULT_DEVICE_TREE:"%"=%).dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index cf1872f3fdc..2b10c2d6c01 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -19,4 +19,4 @@ dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/sandbox/dts/Makefile b/arch/sandbox/dts/Makefile
index 1c9fb4a4566..0d7b0b80e21 100644
--- a/arch/sandbox/dts/Makefile
+++ b/arch/sandbox/dts/Makefile
@@ -11,4 +11,4 @@ dtb-$(CONFIG_CMD_EXTENSION) += overlay0.dtbo overlay1.dtbo
 include $(srctree)/scripts/Makefile.dts
 
 # Add any required device tree compiler flags here
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
diff --git a/arch/x86/dts/Makefile b/arch/x86/dts/Makefile
index 9a46726e026..725991e2629 100644
--- a/arch/x86/dts/Makefile
+++ b/arch/x86/dts/Makefile
@@ -24,4 +24,4 @@ dtb-y += bayleybay.dtb \
 
 include $(srctree)/scripts/Makefile.dts
 
-DTC_FLAGS += -R 4 -p $(if $(CONFIG_EFI_APP),0x8000,0x1000)
+DTC_FLAGS += -R 4
diff --git a/doc/board/broadcom/bcm7xxx.rst b/doc/board/broadcom/bcm7xxx.rst
index f1994d9f975..f559d5c290a 100644
--- a/doc/board/broadcom/bcm7xxx.rst
+++ b/doc/board/broadcom/bcm7xxx.rst
@@ -149,10 +149,8 @@ and with a generic ARMv7 root file system.
 				 * to the Linux source tree as a .dts file.
 				 *
 				 * To support modifications to the device tree
-				 * in-place in U-Boot, add to Linux's
-				 * arch/arm/boot/dts/Makefile:
-				 *
-				 * DTC_FLAGS ?= -p 4096
+				 * in-place in U-Boot, set the config variable
+				 * CONFIG_SYS_DTC_PAD_BYTES as needed.
 				 *
 				 * This will leave some padding in the DTB and
 				 * thus reserve room for node additions.
diff --git a/doc/develop/makefiles.rst b/doc/develop/makefiles.rst
index 37a7deaca92..593556f4dd5 100644
--- a/doc/develop/makefiles.rst
+++ b/doc/develop/makefiles.rst
@@ -1430,10 +1430,13 @@ When kbuild executes, the following steps are followed (roughly):
 	A central rule exists to create `$(obj)/%.dtb` from `$(src)/%.dts`;
 	architecture Makefiles do no need to explicitly write out that rule.
 
+        The device tree can now be padded by the specified number of bytes
+        by setting CONFIG_SYS_DTC_PAD_BYTES instead of explicitly setting
+        DTC_FLAGS with the -p option.
+
 	Example::
 
 		targets += $(dtb-y)
-		DTC_FLAGS ?= -p 1024
 
 7.9 Preprocessing linker scripts
 --------------------------------
diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
index b6db0dc6b26..01a5265114e 100644
--- a/dts/upstream/src/arm64/Makefile
+++ b/dts/upstream/src/arm64/Makefile
@@ -6,5 +6,5 @@ include $(srctree)/scripts/Makefile.dts
 DTC_FLAGS += -a 0x8
 
 ifdef CONFIG_RCAR_64
-DTC_FLAGS += -R 4 -p 0x1000
+	DTC_FLAGS += -R 4
 endif
diff --git a/dts/upstream/src/riscv/Makefile b/dts/upstream/src/riscv/Makefile
index 980617e6de3..43351f801db 100644
--- a/dts/upstream/src/riscv/Makefile
+++ b/dts/upstream/src/riscv/Makefile
@@ -2,5 +2,5 @@
 
 include $(srctree)/scripts/Makefile.dts
 
-DTC_FLAGS += -R 4 -p 0x1000
+DTC_FLAGS += -R 4
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 685e3371bc6..3871a4ad412 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -16,6 +16,10 @@ dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
 
 endif
 
+ifneq ($(CONFIG_SYS_DTC_PAD_BYTES),0)
+DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
+endif
+
 targets += $(dtb-y)
 
 PHONY += dtbs
-- 
2.34.1

