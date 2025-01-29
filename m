Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E524AC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 12:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B96D80FA6;
	Wed, 29 Jan 2025 13:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pbG3Q1/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743A780FA6; Wed, 29 Jan 2025 11:56:36 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC62680885
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-shenai@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TAuVCd1303274
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 04:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738148191;
 bh=bVR6gPSyR4jL7NqHAVzE28SqiO84u8hFhgKDesFJNxc=;
 h=From:To:CC:Subject:Date;
 b=pbG3Q1/KOox/2x+Fyp+pkd/7oMo9mcroxwawQm6bOXg7ejMqJx1HfxlbWNn3kXo0b
 0Fxx/uvnlLDx60eX8tgIgkZox6ZsAhm3FdgiRIrov6XA6ys8vfbjBtRMdjZMQnfkvo
 cJ4xn+MM/CJuVkVIggyMlsr7cyaMRSGZ2IxIKmOE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50TAuVPH009734
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Jan 2025 04:56:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 04:56:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 04:56:31 -0600
Received: from aashvij.dhcp.ti.com (aashvij.dhcp.ti.com [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TAuSQG118679;
 Wed, 29 Jan 2025 04:56:29 -0600
From: Aashvij Shenai <a-shenai@ti.com>
To: <u-boot@lists.denx.de>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <d-gole@ti.com>
CC: <m-chawdhry@ti.com>, <kamlesh@ti.com>
Subject: [PATCH] arm64: configs: Remove SYS_BOOTM_LEN for TI devices
Date: Wed, 29 Jan 2025 16:26:09 +0530
Message-ID: <20250129105609.2239453-1-a-shenai@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 29 Jan 2025 13:56:42 +0100
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

AM62x BOOTM_LEN is too small to contain OS images. Removing this sets the
size to a default 0x4000000 (for all arm64 devices).

It is unnecessary to specifically call the default size for the other
configs.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
Signed-off-by: Aashvij Shenai <a-shenai@ti.com>
---

Reference patch: https://lore.kernel.org/u-boot/20240708-remove-bootm-len-v1-1-2a537061426c@ti.com/

---
 configs/am62x_beagleplay_a53_defconfig | 1 -
 configs/am62x_evm_a53_defconfig        | 1 -
 configs/am65x_evm_r5_defconfig         | 1 -
 configs/am65x_evm_r5_usbdfu_defconfig  | 1 -
 configs/am65x_evm_r5_usbmsc_defconfig  | 1 -
 configs/j721e_evm_r5_defconfig         | 1 -
 configs/j721s2_evm_r5_defconfig        | 1 -
 7 files changed, 7 deletions(-)

diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index af54f9670a7..a8a73166597 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -30,7 +30,6 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_DELAY_STR="d"
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 000f412d4b8..a915ef428b0 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -33,7 +33,6 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 4bd5e8f63ff..289c41c3eb5 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -24,7 +24,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index ae57007d898..0b5eaeb363d 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_LIBDISK_SUPPORT=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 3aa17eb77f0..ef2ff411172 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c7effc
 CONFIG_SPL_BSS_MAX_SIZE=0xc00
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL_SIZE_LIMIT=0x7ec00
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 9d767d7cdad..702fe90b902 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41cf59f0
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL_SIZE_LIMIT=0xf59f0
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 23ae991e2f6..7ec9af8bc48 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -26,7 +26,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c76000
 CONFIG_SPL_BSS_MAX_SIZE=0xa000
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x4000
 CONFIG_SPL_FS_FAT=y
-- 
2.34.1

