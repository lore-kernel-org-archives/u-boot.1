Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7E0E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737CD80569;
	Fri, 20 Dec 2024 21:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gf+Jpuqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0318053F; Fri, 20 Dec 2024 21:37:13 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A5C80435
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4VI004848;
 Fri, 20 Dec 2024 14:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734727024;
 bh=hFGmo8GMPF8Gl/T8TzDmN6JEemPEb6/hheg+DnG5yxs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Gf+Jpuqtonx3kWHPwtLuxvm6bWFwdA4XUMaBvr3DeZePDlSo/IE5SoRlDNGg3Ttp6
 +24XqRYsujTO9U2xGK1QOsDTjkfPRTmqUhxIRvnIpk+fs80zhUCG50yKVMU4owxE9G
 UNd/MTximglQvPZDS+Fp9Qmjztz423n9dhVPFG2w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4rM054165;
 Fri, 20 Dec 2024 14:37:04 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 14:37:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 14:37:04 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKKb4SQ106394;
 Fri, 20 Dec 2024 14:37:04 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH RESEND 3/7] configs: am62x_evm_a53_defconfig: Enable MMC UHS
 modes
Date: Fri, 20 Dec 2024 14:37:00 -0600
Message-ID: <20241220203704.2076499-4-jm@ti.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220203704.2076499-1-jm@ti.com>
References: <20241220203704.2076499-1-jm@ti.com>
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

Enable configs required to enable MMC UHS modes in A53 SPL
and U-Boot proper.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/am62x_evm_a53_defconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 87dc1e73505..54f4ddedcd7 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
@@ -9,6 +10,7 @@ CONFIG_TARGET_AM625_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-sk"
 CONFIG_SPL_TEXT_BASE=0x80080000
@@ -43,6 +45,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER_DOMAIN=y
@@ -76,9 +79,21 @@ CONFIG_DFU_SF=y
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
@@ -99,6 +114,12 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
-- 
2.47.1

