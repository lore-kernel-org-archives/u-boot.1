Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED60C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209E9885AF;
	Fri, 31 May 2024 16:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N8Bm/DLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB311887B2; Fri, 31 May 2024 16:46:46 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DB3882A5
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VEkg9N017850;
 Fri, 31 May 2024 09:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717166802;
 bh=styw2rJ0Eiz5oECBIeN0Lf/jSFpW0AfGCbaKJ22YGwo=;
 h=From:To:CC:Subject:Date;
 b=N8Bm/DLceKIpgS9Csbk/OenJtx0oLFWZkWy+lbsF2gKQyid/ybOspFEsyXzLv1Dxv
 /Cp6HbR9BNOCJbEefFIVoe7rq8fzmrd3HXrKssvz26KNVvJb3IiBBKYpXFvUMXxYfu
 8dUTukwD6SyqHwBCrelxfOeQYUDwvQC03knsBqqs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VEkgme114410
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 09:46:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 09:46:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 09:46:42 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VEkcYI086727; 
 Fri, 31 May 2024 09:46:39 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
CC: Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>
Subject: [PATCH] spl: Kconfig: ARCH_K3: Set default
 SPL_STACK_R_MALLOC_SIMPLE_LEN for R5 build
Date: Fri, 31 May 2024 20:16:36 +0530
Message-ID: <20240531144636.288599-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

All ARCH_K3 platforms need about of 2MB of malloc space post
reallocation. Since, this space is allocated from SDRAM, provide a
generous 2MB space by default.

Platforms requiring more than 2MB can override in defconfig as needed.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 common/spl/Kconfig                 | 1 +
 configs/am62px_evm_r5_defconfig    | 1 -
 configs/am62x_evm_r5_defconfig     | 1 -
 configs/j721s2_evm_r5_defconfig    | 1 -
 configs/j784s4_evm_r5_defconfig    | 1 -
 configs/phycore_am62x_r5_defconfig | 1 -
 configs/verdin-am62_r5_defconfig   | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc12..46bacad2d81b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -409,6 +409,7 @@ config SPL_STACK_R_MALLOC_SIMPLE_LEN
 	depends on SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE
 	hex "Size of malloc_simple heap after switching to DRAM SPL stack"
 	default 0x400000 if ARCH_K3 && ARM64
+	default 0x200000 if ARCH_K3 && CPU_V7R
 	default 0x100000
 	help
 	  Specify the amount of the stack to use as memory pool for
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index b365c7ea902f..ace55696737a 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c4b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x3C000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 648241488ed0..4b2e57b13a09 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 5ef5247a3e00..0352f940041c 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c76000
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index f5fe7432206b..d6a702cdfe96 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c76000
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index 389672d52271..05f8ace748b7 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index 06c63fa64880..8266a7f6e8f1 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x3A7F0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
 CONFIG_SPL_LIBDISK_SUPPORT=y
-- 
2.45.1

