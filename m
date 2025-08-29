Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A4C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 05:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E7A8354B;
	Fri, 29 Aug 2025 07:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n+7FJLvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C89383443; Fri, 29 Aug 2025 07:35:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF7983542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T5Z6SB2172495;
 Fri, 29 Aug 2025 00:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756445706;
 bh=1M7eebC0T6ve2uGk3BGjFSdJBcl0sChvSfkXf/DmZGw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=n+7FJLvQauY/Z/BpavMHBh+es9HzRBYolcxykzw/F37ncL8pXEEWZk+qZl7Q6TvKm
 eXQbTHit+lnxZ14oB8p91zpMT9SVcMqCgUnFLvBIPkkMF4DDWuFhE20vjN2amJMK98
 zfjPU6iYftEPE1A7qIg1Z1r1+EG6X7FzJN0PVr6g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T5Z5Dt3423881
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 00:35:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 00:35:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 00:35:05 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T5YqT61836809;
 Fri, 29 Aug 2025 00:35:02 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>,
 <n-francis@ti.com>, <jm@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/4] configs: am57xx_evm_defconfig: Enable configs needed for
 Early Boot
Date: Fri, 29 Aug 2025 11:04:50 +0530
Message-ID: <20250829053451.3615976-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829053451.3615976-1-b-padhi@ti.com>
References: <20250829053451.3615976-1-b-padhi@ti.com>
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

Early Boot of remotecores happens at the SPL stage of the bootloader.
This feature involves loading a firmware from the boot media to the
remotecore and requires the remoteproc, fs_loader and reset drivers at
the SPL stage. Enable the configs for the same.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 configs/am57xx_evm_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 911715e6141..9768115f4c0 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -7,6 +7,8 @@ CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am572x-idk"
 CONFIG_OMAP54XX=y
 CONFIG_TARGET_AM57XX_EVM=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x40300000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL=y
@@ -38,6 +40,8 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
@@ -84,6 +88,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SPL_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
@@ -102,6 +107,8 @@ CONFIG_PMIC_PALMAS=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PALMAS=y
 CONFIG_PALMAS_POWER=y
+CONFIG_REMOTEPROC_TI_IPU=y
+CONFIG_RESET_DRA7=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
-- 
2.34.1

