Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD3C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 03:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF87480C93;
	Fri, 14 Mar 2025 04:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VjJAXZMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E0D80F4C; Fri, 14 Mar 2025 04:55:13 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7030808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 04:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E3t8UU2057278
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 22:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741924508;
 bh=GFUz2BUr+G6Yqvdrn5tHmkJtH+ZA8eB2Uo/sBE7136k=;
 h=From:To:CC:Subject:Date;
 b=VjJAXZMrl/O0C4O1LukKcApLWwY8NBxAQkOWBW7kDP//vfP55H7y/9CGTzO3oj6vi
 h1Q86pzMc5M2U51gV7D8mgaMweRJSY8bRO6b18IUdvF4gRr+ltxMr/Cilre5X2diWM
 4ZtaSJQjbpYhRAc7XhYuqC3ZDM0mKByupfOdsYb4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E3t8eI103874
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Mar 2025 22:55:08 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 22:55:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 22:55:07 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E3t73L020767;
 Thu, 13 Mar 2025 22:55:07 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
Date: Fri, 14 Mar 2025 09:25:04 +0530
Message-ID: <20250314035505.4029331-1-anshuld@ti.com>
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

SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v5:
 * Remove imply clause for CMD_BOOTZ instead add default y for SPL_HAS_BOOTZ
 * Update commit message to reflect the changes
 * Remove 'More info' link
v4: https://lore.kernel.org/u-boot/20250313032842.1189977-1-anshuld@ti.com/
Changes in v4:
 * Don't set SPL_HAS_BOOTI for sandbox by default
 * Updated prompts for SPL_HAS_BOOT[IZ]
 * Removed check for SPL_HAS_FRAMEWORK from Makefile
v3: https://lore.kernel.org/u-boot/20250312124757.789013-1-anshuld@ti.com/
Changes in v3:
 * Add imply clause for CMD_BOOTZ to enable SPL_HAS_BOOTZ
 * Fix broken check for bootz_setup
v2: https://lore.kernel.org/u-boot/20250312094241.629707-1-anshuld@ti.com/
Changes in v2:
 * Add SPL_HAS_BOOT[IZ] configs
v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/
---
 arch/arm/lib/Makefile |  6 ++----
 common/spl/Kconfig    | 14 ++++++++++++++
 common/spl/spl.c      |  5 +++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed2..e409f7a7947 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -35,10 +35,8 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o zimage.o
 else
 obj-$(CONFIG_$(PHASE_)FRAMEWORK) += spl.o
-ifdef CONFIG_SPL_FRAMEWORK
-obj-$(CONFIG_CMD_BOOTI) += image.o
-obj-$(CONFIG_CMD_BOOTZ) += zimage.o
-endif
+obj-$(CONFIG_SPL_HAS_BOOTI) += image.o
+obj-$(CONFIG_SPL_HAS_BOOTZ) += zimage.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 endif
 ifdef CONFIG_ARM64
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 21a5cefee7a..1d690bee389 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1153,6 +1153,20 @@ config SPL_OS_BOOT
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
 
+config SPL_HAS_BOOTZ
+	bool "Allow booting a zImage style Linux kernel from SPL"
+	depends on SPL_OS_BOOT
+	default y if ARM && !ARM64
+	help
+	  Boot a linux zimage from memory in falcon boot.
+
+config SPL_HAS_BOOTI
+	bool "Allow booting an Image style Linux kernel from SPL"
+	depends on SPL_OS_BOOT
+	default y if ARM64 || RISCV
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

