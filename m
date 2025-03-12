Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7A8C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 09:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C46801FB;
	Wed, 12 Mar 2025 10:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EjNTpYRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E8B805D7; Wed, 12 Mar 2025 10:43:16 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02401801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52C9hAEd1464496
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 04:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741772590;
 bh=EF6VANPba25B5aqJu2HpGqf06o6V0p59kBgxDU7dB6A=;
 h=From:To:CC:Subject:Date;
 b=EjNTpYRW/n3UD7UmsxzXQ/9IMuiSU9jGs/ElAU9yVHZYXXux2qFUlcpHqqDCuGMLc
 oSzKkHiOQzldNpq5ZKUYZJDzNfE0LgMpSzxzxmGySs6gLONOq+n9TilkeWtgkUdM4Y
 H1oxjzSg+IBSWyhgrZ4roEwObEQRRRFLlkcWZlAo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52C9hATY012710
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Mar 2025 04:43:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 04:43:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 04:43:09 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52C9h9Jm119647;
 Wed, 12 Mar 2025 04:43:09 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v2] spl: remove usage of CMD_BOOT[IZ] from image parsing
Date: Wed, 12 Mar 2025 15:12:40 +0530
Message-ID: <20250312094241.629707-1-anshuld@ti.com>
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

More info:
https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
 * Add SPL_HAS_BOOT[IZ] configs
v1: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/
---
 arch/arm/lib/Makefile |  4 ++--
 common/spl/Kconfig    | 13 +++++++++++++
 common/spl/spl.c      |  6 +++---
 3 files changed, 18 insertions(+), 5 deletions(-)

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
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 21a5cefee7a..36c0fb063d0 100644
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
+	  Boot an AArch64 Linux Kernel image from memory in falcon boot.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..8905c776ea5 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -335,7 +335,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 		panic("** no mkimage signature but raw image not supported");
 	}
 
-	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {
+	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_SPL_HAS_BOOTI)) {
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -349,9 +349,9 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
+	} else if (CONFIG_IS_ENABLED(OS_BOOT) &&
+		   IS_ENABLED(CONFIG_SPL_HAS_BOOTI)) {
 		ulong start, end;
-
 		if (!bootz_setup((ulong)header, &start, &end)) {
 			spl_image->name = "Linux";
 			spl_image->os = IH_OS_LINUX;
-- 
2.43.0

