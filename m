Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F4EC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D863E82B16;
	Thu,  8 May 2025 14:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D38828A2; Thu,  8 May 2025 12:56:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 737E782162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 12:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jayanthdodderi.chidanand@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AEEA106F;
 Thu,  8 May 2025 03:56:04 -0700 (PDT)
Received: from e134675.cambridge.arm.com (e134675.arm.com [10.1.28.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 580B33F673;
 Thu,  8 May 2025 03:56:13 -0700 (PDT)
From: Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, oleksandr.tarhunakov@arm.com, artem.kopotev@arm.com,
 manish.pandey2@arm.com,
 Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/1] board: total_Compute: enable bloblist for SPL handoff
Date: Thu,  8 May 2025 11:55:55 +0100
Message-Id: <20250508105556.2205022-2-jayanthdodderi.chidanand@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508105556.2205022-1-jayanthdodderi.chidanand@arm.com>
References: <20250508105556.2205022-1-jayanthdodderi.chidanand@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 May 2025 14:50:08 +0200
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

Add bloblist support to total_comput platform for passing data
from TF-A using the firmware handoff framework.

Signed-off-by: Jayanth Dodderi Chidanand <jayanthdodderi.chidanand@arm.com>
---
 arch/arm/Kconfig                             | 2 +-
 board/armltd/total_compute/Makefile          | 2 +-
 board/armltd/total_compute/total_compute.c   | 5 ++++-
 board/armltd/total_compute/total_compute.env | 6 ++++++
 configs/total_compute_defconfig              | 3 +++
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7311d3b754..0c04048f0e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1415,7 +1415,7 @@ config TARGET_TOTAL_COMPUTE
 	select DM_SERIAL
 	select DM_GPIO
 	select MMC
-	imply OF_HAS_PRIOR_STAGE
+	imply OF_HAS_PRIOR_STAGE if !BLOBLIST
 	imply MISC_INIT_R
 
 config TARGET_LS2080A_EMU
diff --git a/board/armltd/total_compute/Makefile b/board/armltd/total_compute/Makefile
index f1ef5a0c39a..615c7876353 100644
--- a/board/armltd/total_compute/Makefile
+++ b/board/armltd/total_compute/Makefile
@@ -4,4 +4,4 @@
 # Usama Arif <usama.arif@arm.com>
 
 obj-y	:= total_compute.o
-obj-y	+= lowlevel_init.o
+obj-$(CONFIG_OF_HAS_PRIOR_STAGE)	+= lowlevel_init.o
diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index 75ba3c33d56..75bc6b0631f 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -31,6 +31,7 @@ static struct mm_region total_compute_mem_map[TC_MEM_MAP_MAX] = {
 
 struct mm_region *mem_map = total_compute_mem_map;
 
+#ifdef CONFIG_OF_HAS_PRIOR_STAGE
 /*
  * Push the variable into the .data section so that it
  * does not get cleared later.
@@ -45,14 +46,16 @@ int board_fdt_blob_setup(void **fdtp)
 	*fdtp = (void *)fw_dtb_pointer;
 	return 0;
 }
+#endif
 
 int misc_init_r(void)
 {
 	size_t base;
 
+#ifdef CONFIG_OF_HAS_PRIOR_STAGE
 	if (!env_get("fdt_addr_r"))
 		env_set_hex("fdt_addr_r", fw_dtb_pointer);
-
+#endif
 	if (!env_get("kernel_addr_r")) {
 		/*
 		 * The kernel has to be 2M aligned and the first 64K at the
diff --git a/board/armltd/total_compute/total_compute.env b/board/armltd/total_compute/total_compute.env
index 7924632678e..84d5a10b107 100644
--- a/board/armltd/total_compute/total_compute.env
+++ b/board/armltd/total_compute/total_compute.env
@@ -11,6 +11,12 @@ bootcmd=
         blk_dev=mmc;
     fi;
     echo block device is ${blk_dev};
+    if test -n "${fdt_addr_r}"; then
+        echo "Custom FDT at ${fdt_addr_r}";
+    else;
+        setenv fdt_addr_r ${fdtcontroladdr};
+        echo "FDT address is now set to ${fdt_addr_r}";
+    fi;
     if part number ${blk_dev} 0 vbmeta is_avb; then
         echo '${blk_dev} with vbmeta partition detected.';
         echo 'Starting Android Verified boot...';
diff --git a/configs/total_compute_defconfig b/configs/total_compute_defconfig
index 70bec3ba3a0..e66c011efb1 100644
--- a/configs/total_compute_defconfig
+++ b/configs/total_compute_defconfig
@@ -55,3 +55,6 @@ CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=256
 # CONFIG_RANDOM_UUID is not set
 CONFIG_LIBAVB=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
+CONFIG_BLOBLIST_SIZE_RELOC=0x10000
-- 
2.34.1

