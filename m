Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66618C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19640879AF;
	Fri, 12 Jan 2024 07:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="saoXtduT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BF3879B0; Fri, 12 Jan 2024 07:48:33 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDEF879A8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C6mSP7088979;
 Fri, 12 Jan 2024 00:48:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705042108;
 bh=Y5HDsUTzK6RhTQSBdHuno47ngAB0w/4yqf6egumv96E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=saoXtduTFlzuGXB7/KkPonyMUZDHKAdWh3qtUn8Raww1MUb1IEf9PqpBJDepMz3Zo
 3UP7Dv8R9r/9C7snnY78XPTFYOxTHBodV/SyiA8w3PvFek3x68NpyhuZE7a5r1Nba5
 7x7X+kq6yrQYRNcVIs+KNDxb33jCqSfs6XEGda+w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C6mR90022756
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 00:48:28 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 00:48:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 00:48:27 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C6lxsF063681; 
 Fri, 12 Jan 2024 00:48:25 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 08/10] configs: am62: Add configs for enabling ETHBOOT in R5SPL
Date: Fri, 12 Jan 2024 12:17:57 +0530
Message-ID: <20240112064759.1801600-9-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112064759.1801600-1-s-vadapalli@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Add configs for enabling ETHBOOT in R5SPL. Adding a separate config
minimizes the risk of going past the R5-SPL size limit for any future
config additions.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/am62x_evm_r5_ethboot_defconfig | 110 +++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
new file mode 100644
index 0000000000..4912f97d7c
--- /dev/null
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -0,0 +1,110 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-sk"
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SIZE_LIMIT=0x3A7F0
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c3b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot R5 SPL"
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
-- 
2.34.1

