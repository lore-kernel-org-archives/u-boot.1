Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E0ECA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 05:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8147F83577;
	Fri, 29 Aug 2025 07:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVa1vap/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86AB83577; Fri, 29 Aug 2025 07:35:12 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F2B83443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T5Z9SU2144065;
 Fri, 29 Aug 2025 00:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756445709;
 bh=PxcxH5rkt+s66WfmNImLLMC8IRMNbVf4nIMFL5wOpDo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IVa1vap/7ULi8oCwcM0CWU7/HLUE99MOBozggfXJ7B8vsW/AIIJMbpJuC1YBL4JcA
 q6T3gWW6ci7a6clUB7JH4MVcfINNNU3Y4eN2+AibFBO6/YGE7oN+84kiQxX2dfMpSW
 y4lO4uxB1ytC4hTCilMEKB8Bqs38MbduBWR7DYi4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T5Z9EO3783293
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 00:35:09 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 00:35:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 00:35:08 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T5YqT71836809;
 Fri, 29 Aug 2025 00:35:06 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>,
 <n-francis@ti.com>, <jm@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/4] configs: am57xx_hs_evm_defconfig: Enable configs needed
 for Early Boot
Date: Fri, 29 Aug 2025 11:04:51 +0530
Message-ID: <20250829053451.3615976-5-b-padhi@ti.com>
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
 configs/am57xx_hs_evm_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 8d94b3ebf3d..6ad8f9bb23e 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -11,6 +11,8 @@ CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
 CONFIG_TI_SECURE_EMIF_PROTECTED_REGION_SIZE=0x01c00000
 CONFIG_TARGET_AM57XX_EVM=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
@@ -36,6 +38,8 @@ CONFIG_SPL_DMA=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SPL_YMODEM_SUPPORT=y
@@ -77,6 +81,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SPL_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
@@ -95,6 +100,8 @@ CONFIG_PMIC_PALMAS=y
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

