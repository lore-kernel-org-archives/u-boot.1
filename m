Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38421CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31FF83BC4;
	Thu,  9 Oct 2025 14:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qfrgkMMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A0183C6D; Thu,  9 Oct 2025 14:34:42 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D136D83A3A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 14:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599CYcBc533354;
 Thu, 9 Oct 2025 07:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760013278;
 bh=ezR/MsOTFFDcNSafhB79i3jp8MskHLyY9girqJk46og=;
 h=From:To:CC:Subject:Date;
 b=qfrgkMMyp/sdi9u8FUWYnsaDCAOefUDefp/yYs/9+c3KBkV8jAZIDYrsdUHDTE4Hs
 bvJ1uFjt4pL0RWD3KeTX5ELzq06JCn9tQlR2yk+bdjgM9+g+V0te6O56zsHa1VKwv1
 2p78V5M/yL6HUhe38hTIonZ07/mCsQWQgWP3BrFg=
Received: from DLEE211.ent.ti.com (dlee211.ent.ti.com [157.170.170.113])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599CYcLI915335
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Oct 2025 07:34:38 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 07:34:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 07:34:37 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599CYaTI252854;
 Thu, 9 Oct 2025 07:34:37 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v1] env: Kconfig: disable external env in secure os boot
Date: Thu, 9 Oct 2025 18:04:34 +0530
Message-ID: <20251009123435.960225-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
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

Falcon mode uses falcon_image_file from the env during mmc fs boot, but
external env can be compromised. Therefore disable access to external
env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
This is a standalone patch from an older RFC:
https://lore.kernel.org/u-boot/20250911131414.3296697-16-anshuld@ti.com/

Changes:
 - Add a `depends on !SPL_OS_BOOT_SECURE` for each SPL_ENV_IS_IN_*

Depends on:
  [PATCH -next v3 1/7] spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol:
   - https://lore.kernel.org/u-boot/20251006101057.4172248-2-anshuld@ti.com/
---
 env/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/env/Kconfig b/env/Kconfig
index adea277470f..ce88d640156 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -827,12 +827,14 @@ if SPL_ENV_SUPPORT
 config SPL_ENV_IS_NOWHERE
 	bool "SPL Environment is not stored"
 	default y if ENV_IS_NOWHERE
+	default y if SPL_OS_BOOT_SECURE
 	help
 	  Similar to ENV_IS_NOWHERE, used for SPL environment.
 
 config SPL_ENV_IS_IN_MMC
 	bool "SPL Environment in an MMC device"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_MMC
 	default y
 	help
@@ -841,6 +843,7 @@ config SPL_ENV_IS_IN_MMC
 config SPL_ENV_IS_IN_FAT
 	bool "SPL Environment is in a FAT filesystem"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_FAT
 	default y
 	help
@@ -849,6 +852,7 @@ config SPL_ENV_IS_IN_FAT
 config SPL_ENV_IS_IN_EXT4
 	bool "SPL Environment is in a EXT4 filesystem"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_EXT4
 	default y
 	help
@@ -857,6 +861,7 @@ config SPL_ENV_IS_IN_EXT4
 config SPL_ENV_IS_IN_NAND
 	bool "SPL Environment in a NAND device"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_NAND
 	default y
 	help
@@ -865,6 +870,7 @@ config SPL_ENV_IS_IN_NAND
 config SPL_ENV_IS_IN_SPI_FLASH
 	bool "SPL Environment is in SPI flash"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_SPI_FLASH
 	default y
 	help
@@ -873,6 +879,7 @@ config SPL_ENV_IS_IN_SPI_FLASH
 config SPL_ENV_IS_IN_FLASH
 	bool "SPL Environment in flash memory"
 	depends on !SPL_ENV_IS_NOWHERE
+	depends on !SPL_OS_BOOT_SECURE
 	depends on ENV_IS_IN_FLASH
 	default y
 	help
-- 
2.51.0

