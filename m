Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86362C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4297826B2;
	Thu,  3 Apr 2025 23:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PP6DDP2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DEC8272A; Thu,  3 Apr 2025 23:55:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1008215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533LtcpS3795565
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717338;
 bh=49CpMBBBE82+kkFBveBGNE8qnZI/WUSGrz6MhoUyXlY=;
 h=From:To:CC:Subject:Date;
 b=PP6DDP2lBJIZ40ySkOiOPk3YA+1lpIhP7rRv4uVOj3jWoG2JFVrU8oNV/J4dT57ij
 qO4StGP+tfdL+qrW3hU7ADf7WHDCh957KgB6Hu01wUoGq0gah5L/Aryxv/KZXJI22Q
 Ix9+ZAkX7bEZf1h3XXUJ3EgAcZw+5M4Mkoh7uhKc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533LtcZU055587
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:55:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:55:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:55:37 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533Ltb3f085476;
 Thu, 3 Apr 2025 16:55:37 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v6 1/4] spl: remove usage of CMD_BOOTx from image parsing
Date: Fri, 4 Apr 2025 03:24:34 +0530
Message-ID: <20250403215522.1284502-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Using CMD_* configs from spl doesn't make logical sense. Therefore this
patch replaces the checks for CMD_BOOTx with newly added configs
SPL_HAS_BOOTx.

SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV.

The respective C files (image.c/zimage.c) are compiled based on library
symbols LIB_BOOTx instead which are in turn selected by both CMD_BOOTx
and SPL_HAS_BOOTx.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Tested:
 * U-Boot CI: https://github.com/u-boot/u-boot/pull/757
Changes in v6:
 * Add LIB_BOOTx library symbols
 * Update existing configs ensuring no change in size or build failure
v5:
https://lore.kernel.org/all/20250314035505.4029331-1-anshuld@ti.com/
Changes in v5:
 * Remove imply clause for CMD_BOOTZ instead add default y for
SPL_HAS_BOOTZ
 * Update commit message to reflect the changes
 * Remove 'More info' link
v4:
https://lore.kernel.org/u-boot/20250313032842.1189977-1-anshuld@ti.com/
Changes in v4:
 * Don't set SPL_HAS_BOOTI for sandbox by default
 * Updated prompts for SPL_HAS_BOOT[IZ]
 * Removed check for SPL_HAS_FRAMEWORK from Makefile
v3:
https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com/
Changes in v3:
 * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
 * Fix broken check for bootz_setup
v2:
https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/
Changes in v2:
 * Add SPL_HAS_BOOT[IZ] configs
v1:
https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/
---
 arch/arm/lib/Makefile |  9 +++------
 cmd/Kconfig           |  2 ++
 common/spl/Kconfig    | 16 ++++++++++++++++
 common/spl/spl.c      |  5 +++--
 lib/Kconfig           |  6 ++++++
 5 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed2..c0a0e1dad0e 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,6 +7,9 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
 				    lib1funcs.o uldivmod.o div0.o \
 				    div64.o muldi3.o
 
+obj-$(CONFIG_LIB_BOOTI) += image.o
+obj-$(CONFIG_LIB_BOOTZ) += zimage.o
+
 ifdef CONFIG_CPU_V7M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
@@ -30,15 +33,9 @@ endif
 
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
-obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
 obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
-ifdef CONFIG_SPL_FRAMEWORK
-obj-$(CONFIG_CMD_BOOTI) += image.o
-obj-$(CONFIG_CMD_BOOTZ) += zimage.o
-endif
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
 ifdef CONFIG_ARM64
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..45224f1ae21 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -352,6 +352,7 @@ config BOOTM_ELF
 
 config CMD_BOOTZ
 	bool "bootz"
+	select LIB_BOOTZ
 	help
 	  Boot the Linux zImage
 
@@ -359,6 +360,7 @@ config CMD_BOOTI
 	bool "booti"
 	depends on ARM64 || RISCV || SANDBOX
 	default y
+	select LIB_BOOTI
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 94e118f8465..7d7fd37cac6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1153,6 +1153,22 @@ config SPL_OS_BOOT
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
 
+config SPL_HAS_BOOTZ
+	bool "Allow booting a zImage style Linux kernel from SPL"
+	depends on SPL_OS_BOOT
+	default y if ARM && !ARM64
+	select LIB_BOOTZ
+	help
+	  Boot a linux zimage from memory in falcon boot.
+
+config SPL_HAS_BOOTI
+	bool "Allow booting an Image style Linux kernel from SPL"
+	depends on SPL_OS_BOOT
+	default y if ARM64 || RISCV
+	select LIB_BOOTI
+	help
+	  Boot an uncompressed linux kernel image from memory in falcon boot.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..445c3ef24fe 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -335,7 +335,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		panic("** no mkimage signature but raw image not supported");
 	}
 
-	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
+	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_SPL_HAS_BOOTI)) {
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -349,7 +349,8 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
+	} else if (CONFIG_IS_ENABLED(OS_BOOT) &&
+		   IS_ENABLED(CONFIG_SPL_HAS_BOOTZ)) {
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {
diff --git a/lib/Kconfig b/lib/Kconfig
index 1a683dea670..8c39b3af7ad 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1202,6 +1202,12 @@ config TEST_FDTDEC
 	bool "enable fdtdec test"
 	depends on OF_LIBFDT
 
+config LIB_BOOTI
+	bool
+
+config LIB_BOOTZ
+	bool
+
 config LIB_DATE
 	bool
 
-- 
2.49.0

