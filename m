Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E08ED73086
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165EE8412A;
	Fri,  3 Apr 2026 04:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i8EaeASr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7614384106; Fri,  3 Apr 2026 04:25:52 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF2883693
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO9kx4t9rx6duPuMyDUArA/BPXI19TpzZs8ImFH3qag5NMqpxLniUqWGWSWj+D5qTGFUB8LEs+sTC7F4EIjtwVMgRSJnxFWAnFoHiJkB4kGMgcZmuY1kivsbtF5qusdLpW6LNfbZ/FUqpKY8BDp4M2bMuPcK6BOjzfZzJ4DGEUEqv/JZJgdFwLxGXw6GJdWwHZ6wYTHXFV7HFT2NrNbC8L6x0C9PW0YAyNrW6M1iPYLYWelF7K0Cmm3XB/0WTYnLQiFB6+RBt5GMimsJt2Rrvc/Gt3GNr9RkmIR937VrnfTa45fFrsS/D2dB9NnTeHUINRwylE9DG2CQSyKqhwSa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9pKPs55n0g9ZXv6WIFXpwj1brmkB7vuP59xWSfjVN0=;
 b=k7nnOagZrDySokvl4XcWnkdSL20qpS1+mYQichE8RU2NAtGrffKQXBZbg2VLKkX7OalNstCk7wMMAX0DJNllJbTFjNk0Or0kKsQJoErtBXCZQ5xzY6Xp5cREt6IhRiMMjIYqz7quhDL/iJQTD2OfJfOGVOA42xefE9f8F30+7VtPbxiMSBHzXRvqt8VbD8dj/TTWH9mfHvix1Yebk702Gy0ZHzVQ3KjcviGNI9CbRNLuv/O22eHAzp7pUVx+x7UYjugN47UJu+h84jexEfiBaJmQNTKO8z3SIT7NNstRAqGKRGuIl17DSNWPacLqsWkdse9qVBTvVpo4aOZ3ACxadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9pKPs55n0g9ZXv6WIFXpwj1brmkB7vuP59xWSfjVN0=;
 b=i8EaeASrzhAPlEbKG/a3cJ7fgw6kSXb7D8h2kLvkhbStmlud/nH+MG0epCqk/HxQ1ZbSPqVFLGveGyfvvR/WbxBS/zfvoxCTDYJqcCcQtjTlLST+UQ8Pasmbav2DTjCVDvT3MZ7TypWbbxA4yxpehGR1S/QLGJ8dGBOEdBrbFwCCohlDa1naYb+ZodGFfNtXLS0W8utSW/tKSSPbN0+dFsPCTmsyhdTdrXas9NwqvcPNNzXhqaY0xIhXj5qbbM+AqWT39ysuwMg9KM9L1eH6josLQZgZeaYdXmfMNqY2c3ZIxK32utExS8KGLQztyZrIzXSCMXfteJPow2MSFHf9Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5421.namprd03.prod.outlook.com (2603:10b6:a03:289::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 02:25:46 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:46 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
Date: Thu,  2 Apr 2026 19:25:06 -0700
Message-ID: <20260403022513.9446-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a19ed3-3a8e-4663-5adf-08de91284ff5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: NK5zvWCjGqJ4Kx0mEGbWOYYkKH96CAyM9Qy/VxDqPtapswufO3LIIvRAlAyPEoxe4Ku9u8xbh6dMdVCDR4a56aUETpFAUAdi9KqGsfB/LgErvZyPAZJ45NoSTafrotSwE87wFEiRkNUlw/1P4UecGouZgTS4J6NlqwlZ2n4fzF3l3OGvuIcoY9uKPvq2fVZAA354g2Zmr+8RwYCx79KPgt/jQzJmzqWpB57fqPn/WLLqDeJPGQ0uybqLaEuNBICOWLILH62fELkagDm82pT9/WmDErR3Kt48fpWFRsEaD/+sSy+wbfauEM2V74VWl9AewbRmFY9Fc/KVskEklGKWIWyFcQ49iqWnhbHPlEQ1o/DtG2aks7WLHeAtDwVBq+E86P7xCOS47dBQIRH7LANRCxpLFQJYJ03Iufjt5ycdQ5NvBiY/RdJXpmRQcUiZ3atPW+NWPHddpn3f6TcgjlCWgBSl4isENwfT4HsXhlYfWxas4aHj9vrpBGnhiv7b1Kq956dsWUHDU9gvoJBQjeAoH7892VcejWpb/xyknC7QUk+yMjyF7I456ahDz3XYC0hPCLazhVNPnLO2UnnOpZgDUMwBw/GvS4l0P1w80sOrPeCpEdPCo7Skc03GS7bb5yZ6CFUtwA5W8N6kn+iPBDFl+eIEIMOt2yPCLM/8Q0p+gdTAu6ezSsOwy2s79EG++aerJSC8PTP/HYQ8DjikhHsb0c1agWwexuIHSmXquGZ/f7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFeX5y7bBr0k7TJWDVMwbkzz4QRbADZiPa6UmGzQjH5fyM5pOgL4n9rdx/DM?=
 =?us-ascii?Q?5cID5BDQYrojN8ZZlIJoIHhaHmN1Di5qBi7/RNyZcbzH3xwLh/UcDX+FQ8rT?=
 =?us-ascii?Q?tuqZ5qIEYVzxwVXUycQHdSy4/K8r+oTh3PQ3yWOFNhLzBtfVW1H/YE0ZIuJw?=
 =?us-ascii?Q?CW/ubzNLrKwxWnRFPp+Qb0a5+yF4tOXT1RUgXk1FdrbmeIpGC5POUc3TUCGx?=
 =?us-ascii?Q?BnK4lErbEVdYS6FPkC0vyRENic5Xx1o0uc/I72aEyuXUPMNKPBduB0CKiu+G?=
 =?us-ascii?Q?0YxN4gV9rzBIboyYFv22iZezQAvW5wVbEQTGQ5P+KulDkZHhgx1so1s6KFRq?=
 =?us-ascii?Q?gHOR76cf69NgsrYDY+9b+/4O5kIGZKpHtvggVxCJBoAeI1/48mq3wBAfyj71?=
 =?us-ascii?Q?rQFiy8lx2L+cIWE505wjQsnykPH4x+IekTcLkO/IEdkiAA8McuknaphQ/yE9?=
 =?us-ascii?Q?Hh4cSMxwLsoNtofCFGwkTV3Ar8GI/7GxecorKl6pXknTLGVOoKePyo/to3HY?=
 =?us-ascii?Q?Iyvn1VDOhy2K+oXeLvGGz05SG0bkm7q6ihPzFQJLDP7qHcjC4SWTgf72oCRg?=
 =?us-ascii?Q?Vid2wyki4feUqrjGEogGTLR78JHsZzDr1cVjUex2bAm65r1t7SF+IBzfRQPc?=
 =?us-ascii?Q?nYMAZNiPjbIX/6RI5j1zGQ1rzXAw24k+La5Js6t6YypOYxTLNMsO1h1qjWfD?=
 =?us-ascii?Q?jjsxb3sZLKq4g6S2GInOY3yk42xpjcp/+48UOol92g/AcOTHcy0PjjlAVOTo?=
 =?us-ascii?Q?wbD6N4OS8J33XD3QNgH4tmZqbGuQLSGXKhdBaksdzQt+ewrg0Fn5Z+l/om79?=
 =?us-ascii?Q?XhjbdiIpnD6vugp6le+7GW+hiz/GDodQrc8G1+pZM6moVkTyDOHLEP1oUenP?=
 =?us-ascii?Q?+BR8FrhKvz3mUjPEPAvLrzCLBZmgVak+eeXO3LAIGVmx6Q1F1H0UTyiDr5DC?=
 =?us-ascii?Q?mPCStlQfowvhx4+W9DOeRDfU1X2bFXPqlU96yRQdXMmIcsymyQWCZ5fZ1K4E?=
 =?us-ascii?Q?7lokcYTIkmhLLnMLNOX3IOPFuzH4RFFmP8DPalf8Kp5b9yDGbV6djXENv1DF?=
 =?us-ascii?Q?dHQje9ms0zfhcdBuXdCJeRPZ5mJ+PdihjaMzdqbgcUyF60W/0+5XtvRLotA4?=
 =?us-ascii?Q?91VGon52vFYS1BmBSpPtW6rYZ/uS/KNrjWBmzFya1PCHUW3fcXK0KEFh3bws?=
 =?us-ascii?Q?vij5IE+W3yebMfcWrAg1rBMkktD2XY7kfH1MxleIv6rccQI9upr2HBnvD2WU?=
 =?us-ascii?Q?/QJPw41ccLx17yKr41V5Im6e7dtjXr+F/B6lotuqs9OpVL7yOcZTtxZHdOg1?=
 =?us-ascii?Q?hx+xU+n7jRKep4vD+7QqnBDnTz8ydWeKdG7nI3Y3lJ9Gm4H4PeYJdgDZI1KE?=
 =?us-ascii?Q?g601qrSMTBsGV5LfbXo8vArio9P0PowQaV1VBI1zHRVekjvC9nIh9oMv73s1?=
 =?us-ascii?Q?SpScOS1Q1ATryQLPr1gU9DrUg7rhuub0v22kZb0mDGkpziBFYdqyArEa2QJ3?=
 =?us-ascii?Q?FVBF9fc+ey8GYUtAdbrvItAB54nWN2udz4DVQl7Qu0CuvRieHMOts8B3Nrqs?=
 =?us-ascii?Q?rk9YCI7eL8lrC0oG0Lc6XYFWWb2yaukwKh75gGcD3wu2s98rmXKii4a1+wDL?=
 =?us-ascii?Q?MMhphtGif4zwotSTkyGFdxPLyPwFMB/dT5bFX1B6iWd6HpILSKpxmTHYEV6A?=
 =?us-ascii?Q?FgrmDxm+3C7sns2EWWtLcl/trqouQtM7Ho46JvYkgH5+xCcLq6F8VL6e0mW0?=
 =?us-ascii?Q?AkDzz7MQjVptVQXtMuJa1suWPm2wx54=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a19ed3-3a8e-4663-5adf-08de91284ff5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:46.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c76XSjQoVR2VhGUwTMvO2xMFdQglZVWw2PpNlgPvLM5ns2eGf6M9MIq1pvops5EsSAG08SsddBsdUuMHKZaA0Rh4ptGLfVHwIhnzntJoB/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5421
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Combine all MMC and QSPI configs into single defconfig which is named
as "socfpga_stratix10_defconfig". This will be the default defconfig to
use.

This will support booting from all three flashes using ARM Trusted Firmware
(ATF) as the secure runtime monitor.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_stratix10_atf_defconfig | 90 ----------------------
 configs/socfpga_stratix10_defconfig     | 99 +++++++++++++++----------
 2 files changed, 58 insertions(+), 131 deletions(-)
 delete mode 100644 configs/socfpga_stratix10_atf_defconfig

diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
deleted file mode 100644
index 206343885d9..00000000000
--- a/configs/socfpga_stratix10_atf_defconfig
+++ /dev/null
@@ -1,90 +0,0 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x02000000
-CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_stratix10"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2085
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_ALTERA_SDRAM=y
-CONFIG_DWAPB_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_DW=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
-CONFIG_USB=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_WDT=y
-# CONFIG_SPL_USE_TINY_PRINTF is not set
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index ef21dc92493..02a1875a72e 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -1,93 +1,110 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
-CONFIG_SYS_MALLOC_LEN=0x500000
+CONFIG_TEXT_BASE=0x200000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x04100000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
 CONFIG_OF_UPSTREAM=y
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_stratix10"
 CONFIG_SPL_FS_FAT=y
-# CONFIG_PSCI_RESET is not set
-CONFIG_SYS_MEMTEST_START=0x00000000
-CONFIG_SYS_MEMTEST_END=0x3fe00000
-CONFIG_OPTIMIZE_INLINING=y
-CONFIG_SPL_OPTIMIZE_INLINING=y
-CONFIG_REMAKE_ELF=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
-CONFIG_SYS_PBSIZE=2085
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_BOOTARGS="earlycon panic=-1"
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
+CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
+# CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="Image"
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPI_FLASH_MTD=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_CMD_UBI=y
+CONFIG_CMD_UBIFS=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_LIMIT=20
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_INTEL_PR=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=256
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
 CONFIG_USB=y
+CONFIG_DM_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

