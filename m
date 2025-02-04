Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889BFC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408E4807F1;
	Tue,  4 Feb 2025 18:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6702C807E2; Tue,  4 Feb 2025 18:59:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EB641807A8
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50ED211FB;
 Tue,  4 Feb 2025 09:59:20 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.31.150])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6D53F58B;
 Tue,  4 Feb 2025 09:58:55 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Liviu Dudau <liviu.dudau@foss.arm.com>,
	Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 4/4] board: vexpress64: enable bloblist for SPL handoff
Date: Tue,  4 Feb 2025 17:58:42 +0000
Message-ID: <20250204175844.19890-5-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250204175844.19890-1-harrison.mutai@arm.com>
References: <20250204175844.19890-1-harrison.mutai@arm.com>
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

Enable bloblist on vexpress64 platforms to facilitate information
passing from TF-A using the firmware handoff framework.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 board/armltd/vexpress64/Kconfig         |  2 +-
 board/armltd/vexpress64/Makefile        |  5 ++++-
 board/armltd/vexpress64/vexpress64.c    |  4 ++++
 configs/vexpress_fvp_bloblist_defconfig |  5 +++++
 doc/board/armltd/vexpress64.rst         | 16 ++++++++++++++++
 5 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 configs/vexpress_fvp_bloblist_defconfig

diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index 584b5455e9..7e8709444f 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -28,7 +28,7 @@ choice
 config TARGET_VEXPRESS64_BASE_FVP
 	bool "Support Versatile Express ARMv8a FVP BASE model"
 	select VEXPRESS64_BASE_MODEL
-	imply OF_HAS_PRIOR_STAGE
+	imply OF_HAS_PRIOR_STAGE if !BLOBLIST
 
 config TARGET_VEXPRESS64_BASER_FVP
 	bool "Support Versatile Express ARMv8r64 FVP BASE model"
diff --git a/board/armltd/vexpress64/Makefile b/board/armltd/vexpress64/Makefile
index 1878fbed4e..b0dd1d0af8 100644
--- a/board/armltd/vexpress64/Makefile
+++ b/board/armltd/vexpress64/Makefile
@@ -3,5 +3,8 @@
 # (C) Copyright 2000-2004
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y	:= vexpress64.o lowlevel_init.o
+obj-y	:= vexpress64.o
+
+obj-$(CONFIG_OF_HAS_PRIOR_STAGE)	+= lowlevel_init.o
+
 obj-$(CONFIG_TARGET_VEXPRESS64_JUNO)	+= pcie.o
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index b5ede58757..0b75c1358f 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -100,7 +100,9 @@ int dram_init_banksize(void)
  * Push the variable into the .data section so that it
  * does not get cleared later.
  */
+#ifdef CONFIG_OF_HAS_PRIOR_STAGE
 unsigned long __section(".data") prior_stage_fdt_address[2];
+#endif
 
 #ifdef CONFIG_OF_BOARD
 
@@ -151,6 +153,7 @@ static phys_addr_t find_dtb_in_nor_flash(const char *partname)
 }
 #endif
 
+#ifdef CONFIG_OF_HAS_PRIOR_STAGE
 /*
  * Filter for a valid DTB, as TF-A happens to provide a pointer to some
  * data structure using the DTB format, which we cannot use.
@@ -201,6 +204,7 @@ int board_fdt_blob_setup(void **fdtp)
 	return -ENXIO;
 }
 #endif
+#endif
 
 /* Actual reset is done via PSCI. */
 void reset_cpu(void)
diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
new file mode 100644
index 0000000000..dcc87db872
--- /dev/null
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -0,0 +1,5 @@
+#include <configs/vexpress_fvp_defconfig>
+
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_PASSAGE=y
+CONFIG_BLOBLIST_SIZE_RELOC=0x10000
diff --git a/doc/board/armltd/vexpress64.rst b/doc/board/armltd/vexpress64.rst
index a7f771d266..4dadadb53d 100644
--- a/doc/board/armltd/vexpress64.rst
+++ b/doc/board/armltd/vexpress64.rst
@@ -43,6 +43,22 @@ Juno is an Arm development board with the following features:
 
 More details can be found in the board documentation [3]_.
 
+Bloblist Support
+----------------
+
+The ``vexpress_fvp_bloblist_defconfig`` configures U-Boot to be compiled for
+Vexpress64 with Bloblist as the primary method for information handoff between
+boot stages. U-Boot offers three methods to set up a bloblist: using a
+predefined bloblist at a specified address, dynamically allocating memory for a
+bloblist, or utilizing a standard passage-provided bloblist with automatic size
+detection.
+
+By default, ``vexpress_fvp_bloblist_defconfig`` uses the standard passage method
+(CONFIG_BLOBLIST_PASSAGE) because TF-A provides a Transfer List in non-secure
+memory that U-Boot can utilise. This Bloblist, which is referred to as a Transfer List in
+TF-A, contains all necessary data for the handoff process, including DT and ACPI
+tables.
+
 References
 ----------
 
-- 
2.46.2

