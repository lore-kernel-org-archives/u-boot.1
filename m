Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CADEC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 12:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871F8801FB;
	Wed, 12 Mar 2025 13:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uktAuo6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CCE80756; Wed, 12 Mar 2025 13:48:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38D8801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CCm4WE1029231
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 07:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741783684;
 bh=LPPN43jv58FHi0fFJpi3kIKKX6i05CGxPmh+dm2lcIg=;
 h=From:To:CC:Subject:Date;
 b=uktAuo6c0rMahUrkSA/K/toWAOBFkkRr8ApTCDGz9Fj7ZFCDsDcA2Ps29DgJUdWQz
 0nBZa90nwcKm7KeIXWmbwzg71WqXN6Us+SPQecS6yrTwX3meov7f2tC5PzQP7jN/Ln
 V6eX6FBJ09P64ucjXFA5B/udNNrAPR1o8AfkCeng=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CCm4Pt071033
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Mar 2025 07:48:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 07:48:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 07:48:03 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CCm3f0118310;
 Wed, 12 Mar 2025 07:48:03 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v3] spl: remove usage of CMD_BOOT[IZ] from image parsing
Date: Wed, 12 Mar 2025 18:17:56 +0530
Message-ID: <20250312124757.789013-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
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
patch replaces the checks for CMD_BOOT[IZ] with newly added configs
SPL_HAS_BOOT[IZ].

An imply clause has been added for CMD_BOOTZ to avoid breaking configs
that rely on CMD_BOOTZ in falcon boot. There is no such need for
CMD_BOOTI since it's already enabled by default for the platforms that
support the image format.

More info:
https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
 * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
 * Fix broken check for bootz_setup
v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/
Changes in v2:
 * Add SPL_HAS_BOOT[IZ] configs
v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/
---
 arch/arm/lib/Makefile |  4 ++--
 cmd/Kconfig           |  1 +
 common/spl/Kconfig    | 13 +++++++++++++
 common/spl/spl.c      |  5 +++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed2..e857adddd03 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -36,8 +36,8 @@ obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
 obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
 ifdef CONFIG_SPL_FRAMEWORK
-obj-$(CONFIG_CMD_BOOTI) += image.o
-obj-$(CONFIG_CMD_BOOTZ) += zimage.o
+obj-$(CONFIG_SPL_HAS_BOOTI) += image.o
+obj-$(CONFIG_SPL_HAS_BOOTZ) += zimage.o
 endif
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index a04fcaa0e08..9f2ba4d02f8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -352,6 +352,7 @@ config BOOTM_ELF
 
 config CMD_BOOTZ
 	bool "bootz"
+	imply SPL_HAS_BOOTZ
 	help
 	  Boot the Linux zImage
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 21a5cefee7a..e0e804ae8dc 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
 
+config SPL_HAS_BOOTZ
+	bool "Allow booting to kernel zimage from SPL"
+	depends on SPL_OS_BOOT
+	help
+	  Boot a linux zimage from memory in falcon boot.
+
+config SPL_HAS_BOOTI
+	bool "Allow booting to kernel image from SPL"
+	depends on SPL_OS_BOOT
+	default y if ARM64 || RISCV || SANDBOX
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
-- 
2.43.0

