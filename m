Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0ECD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7847183FEE;
	Mon, 18 May 2026 03:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WsYbb7R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9062383FEE; Mon, 18 May 2026 03:13:10 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC6F83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btFz6U3XXJI/GWFxqilKPh602kk2AZMlxsUVRZ4y1XxQfmdaTZZPXKL4DAn+X4KnUk2Dm6rJyC9Ch0z/dzl5kxT1a6bYAKNVS6ABJqS7PfYVjbO9s4IMw4NnpM/QA+ANKMLpip9gySgy41gO5SY1BZTW1Y+kMXWDx8WqGhnGN76HNWWvyF3nJcj7IODyiuA5nAg904dDDuzbicvOGUgPN038gUg2f+dwUNcwYRR53wyEarMn3Yi06xqJnHpJaPmWmCqhACtWZY0yUE/MlTIWomozo4T1ucCXC4yOXjkTwifRn0/PKRShvkaRDLLl1ri/Q9O18B51ttkELeJcP/4MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaIRNlrMnnag39RcVsQxFZbktiCwLPtuREu6BpPolwc=;
 b=TjjSW0Ds1Ew7uSUvP/LFOqFw5hMInVkHMMQTFHtqOdbye31Fh1FU/EGo5aU1uhsfrhwe327mtbVXjxECUPOTj5R6ZWQ017griikQtdZ6oWRqpot+ANFi02CEkbKNPHG4vbuYorl1QRsmo8ZGC51Bd7GccW5BV/5xGHXpzFzkrt/c4zuriA/eu4iAaIiIyfr5j7GnAzvPCkLX9L0nDkeVSAx83BcR7UNgvvxiKI4pVRcyGWW64Vy1VXjVYkIoD11tZvzgkrkhWXcvtOpKiyYHRGr/HsCf+YFpc+TYBGaCK44elZar/vB3VJkqhNPahqrVBpofL3ZbudORpl5V7W6J/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaIRNlrMnnag39RcVsQxFZbktiCwLPtuREu6BpPolwc=;
 b=WsYbb7R3vJ8jJqtwm0/FP+TQXoLy//DZVGjB12s5ZZIaLKKOxcElVr1yMhZWtH6xAWvFY8iJfa1oqjwel50TVVitnb65eKT4MJw4f0B33VgxYmRhVU62DAeswdpoZWfKjeFR1rF16nNRNvxJNGv9Le2HcP1Z4ZnlvbNH6LsB47ot08WSgvxKxCPIMEW5Oye0Uz0P5ELLj+OT3puNZ1OJFctdvnnRN2ut4JfMgOqjGKYrBEVg4iM/u7U5VJNZ/TC6sgzV1mVwxJxB5HkNMSZZu3KOeHkUrpD1+DpY43CDU0eNzw+1EZ341KFoS7rsQWTGYTKelU6fAhT9nWjYeTWXUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5556.namprd03.prod.outlook.com (2603:10b6:208:297::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 01:13:05 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:05 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
Date: Mon, 18 May 2026 09:12:38 +0800
Message-ID: <20260518011245.19083-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ed40c6-68bf-4be7-3eca-08deb47a9d5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info: d6kdKjjyKDra4qw+B3449G4ZiDRiZxFDXT3PUDJ4FGQjYh/EtBMjdJNDBgcuoFHKIza+DrEgUtwJIBfyxnZlGx8q2pc40qN+cxSDt3htI+Uvs+FZkOXXX8mmuuaHwyIin723cGxCG81f94IkNjcu41vciXwjbC5Vhz4S3wLDj26jiKkMvU/JmacX3FowVmefAO7p/lv++u/bh6KlmIOyDyWFuTiYc1EjtfoivFZjmU5TQVIFL5PROCTqXzaBU2FmhfZCBSpfn/f++qMMID9HozwQcQRRXG8kFcYuFCmtCY075wV+Ivw4vgdaN2kc719Iigwj/i6NK3g1EFPjEBqI+vid78h/oU4Z/+RvNhuSD+z+vPrjKN/iW3pzJhbLzhtuOE4ZVOueBkc1fA68NHIk0wTTFuSGCfTOjCz3/vTC8gyhZ6snjhAkqd5C2kIvwyLhO87j+QZXmR5QVEA4wWy31G9o1+zuZLdHChfpIBdaF8YIO6fcmxecWMNAO+EHple3qS/ShkB50RyL1XXTadRq3dqPOkWgy+PL0pEicKf2Mfz7wqC+5C75bl3qQ65kFgcANg2hu3e1ILzVoMs1gHxsXODpIisjpkY9Y+LlSMkzQne9utgFCpUR8W0ddH0Jd7kUrj7lNoH6FN+A/WsClPZi33kW+aDIKl+ETCsQ69ndh7NTb2qOK0lIhKSEccP1RvbH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2N1TOzHpjjlsh2hC+BxIPc6zFxH/XlsXrMhOX4EeM/sQVHMaqCaqe6tIyFBB?=
 =?us-ascii?Q?arAbXLDovhl6Tk+5c46FTQEfG5/sRcnbWSTVJpugyCJq+7gLOYDy5ccATA/r?=
 =?us-ascii?Q?TQsbCcXfC+Na+tQ3aDP8u26jRf62ebhW8d/lLECpt+23Nkp+tcJA9wp/ZRne?=
 =?us-ascii?Q?8EGe10qV5qi7ki74C13Zn0215d2ZPY2NaBeOYKa86BcxiBQycGveSqrmuKoQ?=
 =?us-ascii?Q?OEPsjovL/biDjIngfiTr5Y2EnyzA/6/+fnpQpJTtIDPhNQa/3SXLCpnlvPs2?=
 =?us-ascii?Q?tATEbKmQ8hX9gvB0Rjhb6U8OZcWbBROs62OO4LdjvfzmmUTTcHBi1L10L7ju?=
 =?us-ascii?Q?VP2NTP4LfDvcO4hWdWa6oudx8hTkOAJ9kceCLZmXyyL8G5MEXnjm/uXX0KWa?=
 =?us-ascii?Q?mfhNGVV/+DGkKK3AHYXTXCZh8jvuXaSNUbI9/RURbekLocsFwRzJL4ridrsp?=
 =?us-ascii?Q?WNyL1ZoLjTF6/8I1zGy9URbMDBIlEgQDJnP+g72mXvr65At6wtT+Gqm1Ykww?=
 =?us-ascii?Q?LYMe6GbGQITaRf4HbKwabX70noZjavzTAaZ9LWI3AcWZ0pVW6/QhncXnj+70?=
 =?us-ascii?Q?Ah/Tz/n2Qx/+Pur5WA6xrEBieD79uAbv1ASBSFK6rTF1H94RR/SDQ0yxpimz?=
 =?us-ascii?Q?1sFRZjFuu4Gy1VhwoegQ5V0HJbaYZAQ5ofSdmtntbiGY5YieghXKkO8poF7j?=
 =?us-ascii?Q?MnBzNYYtOj4XOkNbHGyLWAc9UI3SciRIh9sduRHjXJvHeDpWO+ab33t5L35Z?=
 =?us-ascii?Q?BgB3Rg+AOsyknZvQ34uAjrEQdkOB6aZflkpUjhonl8HCZNWHy4Sr2QDquX0U?=
 =?us-ascii?Q?JFe0aTlLMhSM+8VY249u4syfkXmofkIjmMRCul2KnMZMaVGNztHNQWKUdMSC?=
 =?us-ascii?Q?zcLBUADHCpg+NUz81cNBKZE1cX0Tapq9+OFtg5omr233fXaKzqyXi/uhzR7x?=
 =?us-ascii?Q?0uB4KzstFF9bBN688PyRxR6MNQt2e0YXEuIZgvq22Q71/cSXzhMyKVdhr/O4?=
 =?us-ascii?Q?Cx93BmOiG7sM91CQgMg1M57CYxTscXeda2ptCJvE70O4oBOStSU5/1ogbxxH?=
 =?us-ascii?Q?DFqApftGbVCAtXAUMKN6SffpwObR2JzwRaJRS0EOZSSZEnWXame68h2kh3BU?=
 =?us-ascii?Q?uhxvDFxBq4tCQHuHkXFgr9XkNvgcVLJ2X3rV1ACUy2A8GNo0LlW9yGehfSmm?=
 =?us-ascii?Q?Pmsdw/NaMXn2dkq+HSBqSKvgqBEGB4YKu5ODhCujyaqjSyp97LDMMxvq3AL/?=
 =?us-ascii?Q?9xNyG6vKTn/8isJ8Gvx8pDRHuxnuayUEVYKaReoMf/m0g7RuTwgDApZ+Ijhd?=
 =?us-ascii?Q?r9wMJ2eXOiuEF31UlM6qj7dSGjKlW9WD5/MggaTXTf3Ty8BX/88IpHmCbdGA?=
 =?us-ascii?Q?OtjMNwdPnKr8MhN6M7YK4d56ib6Ln5bcPK3Phl5BC21b/EqKZ6H05YUG6fcJ?=
 =?us-ascii?Q?XHJNIIMqzp4YGcB8Bz6y4P77VBPXqrOu2LlpWTnsH7ZJnPh85VqxTbKffqZP?=
 =?us-ascii?Q?tG8Ae8z1IXc/VXudIB4BkWheH36L3NFr488UrKiBuepSuHQYDrBNrm8nRuQE?=
 =?us-ascii?Q?gKMfCHBaivXpWtttrIR7CYauAPfDrVm788pbaKv3c54NL5apjAYes4PJAvgQ?=
 =?us-ascii?Q?f2GwUDdbjxl0lsndlNwtrVk/i4pQbyYpNbmGOokCz5j//3FfNiuMr613qyx5?=
 =?us-ascii?Q?f2jtLfHwZWvus8ms1qeY54piFaM43R0wUUTfJig9Dr9mcTMb/9dm7mktGS9g?=
 =?us-ascii?Q?Qfa546TLxxUA+S4+2NvPZU9ORUalxqI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ed40c6-68bf-4be7-3eca-08deb47a9d5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:05.5432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gABP54yelhHtBsEb3mj5aq2bRJOFt2wtJU3QiWIKQbeu+vd3zpnMWGkqcFzTPe2kl7jCnarPk3sX1OAyV/gQYQOi5N5tINLqH6r42acznI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5556
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

Changes in v3:
- Regenerate defconfig with make savedefconfig

 configs/socfpga_stratix10_atf_defconfig | 90 -------------------------
 configs/socfpga_stratix10_defconfig     | 67 +++++++++---------
 2 files changed, 34 insertions(+), 123 deletions(-)
 delete mode 100644 configs/socfpga_stratix10_atf_defconfig

diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
deleted file mode 100644
index 2eea9a2a731..00000000000
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
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
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
index 8e80127b2d8..82f0cceafb4 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -1,80 +1,81 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
-CONFIG_SYS_MALLOC_LEN=0x500000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
+CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
-CONFIG_OF_UPSTREAM=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0xffe3f000
 CONFIG_SPL_TEXT_BASE=0xFFE00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x3ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
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
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_QSPI_BOOT=y
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
-CONFIG_SYS_PBSIZE=2085
+CONFIG_BOOTARGS="earlycon panic=-1"
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
+CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
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
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
+CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
 CONFIG_PHY_MICREL=y
@@ -85,9 +86,9 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

