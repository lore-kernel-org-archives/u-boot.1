Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B0CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7A68484F;
	Mon,  8 Jun 2026 09:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nC6fwny5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC7884154; Mon,  8 Jun 2026 03:28:19 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B51083314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTKBEUBdDg60J5P91ih1SbvFjfyPONSgH47GjxXOdDQIajs4Ul1R1XSz/fy6ejKzmPRnl7OPBRAHk2NoSWi7Xqo3NAmeoZq+MVpwkvuolKR8t8W50BSocvmLl+VD7A76nheyMdJSPdGYJb8SD+H50kBF2dSkZfptaT4pOjn7eWEDI9kjpp4xtAaGxvpFTCXWoKRznaPyy4MMgNN8NRpEQTZx4fnStSXP+ONQGEh9ajWv4VQBTw/juLAtbIwqJ37SRexzNXC3BE42w0vm+alyiUJ31IdAyjb+mfRh1mb5EVx6TAucF6TGHGK6gzZtPbMvSsyyK1x0SIcylACuzylTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXk/XNRgqXEv6XgjDA1hMUir45Q/ABj0DL6e2ASLu3o=;
 b=UlSIFL37MawD316AIav6UefOV4/uK9O9MiTLM90+oj2Jfmo9bsLSgZ7oREXPp0xZW5yDEgeYNT+wEYoALURqqgtoCvEAYJIC8QmIYeD+QqQVEfAw2nYtsKJ6YybFHv8UoGUE0zo1mth1wXGsURjKJt8UryBN4D6gCU9DYRd+f6cTYHrumeYLn/lJyBM/3UmZtp7y1KhYfMAQlJ021S81aefzeCMG56EfHbBWEhuEib0n55WkTfOjahTtqk79T718m0nnI90kGVMZbLIRC0DEhR6WgsAK0NwXvRTOsyhXjTir1wT5C4hw3+bvuKTPsHplt3Kj1EKDpWZNFN5RHOf0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXk/XNRgqXEv6XgjDA1hMUir45Q/ABj0DL6e2ASLu3o=;
 b=nC6fwny5QZwmVaB9tT8DvKN5yBZ+BA0Pyiib0BsHC54ZAD9V4uNHReY/7OX9RqhNY+G3vFwVs4MffwKO6aghoW5FqzHLoSIhO8krGEJpOcDZ8dmbPMZcSKbW3MC3VoDU9yYBnYv53c8E9RGIw4zARs+P7XUqtwFQXcDTkK1lhtTr7J3arsDZjkMEh49Bop7a9NfdiZlUT6HUIcicPLMPD954BjZ1SBsqGkygARGYzd3H6bHunM2+9FBeQnbhqXZ4s5ydbHZPl+Zn3b4C7luFJSTGBS46m9LmB7cqQ5y6t15f3MP3jc8I8yvyMFZRPXcLcY0v/RvdELqoo6t0gb3j6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:14 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:14 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 1/7] configs: socfpga: n5x: consolidate ATF defconfig and
 simplify VAB
Date: Mon,  8 Jun 2026 09:27:35 +0800
Message-ID: <20260608012741.23760-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 78008866-0ec7-4d61-5018-08dec4fd3591
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zQD7AF7qCA/6F48XRl9abkCNtOvxAj2jZQIwYiLrzLniOMgAJKZaGlFDTHJ8S/nroNrvGzxFXi0XRMxFmW5EZULVDGKq8EwRj07i845u61kYFNOsD9r/oF5w7imrAMYdir0dYuZISEfFM4qwoStStYd8iiCVZ61JhaVDTMb8/JMoyw4KVv7n12dMoMHBcAPkT1Hiu2dyJxKp5CsxvwPK7eu/64NsFtlEbnF4qlRiG8K6L4kx5dmI72S3I9Ok4oko21VASjAVP8I4khi0Xh9wcyy1FeQ32EZXU88bACvg00kGylySlLmfMDWVxgmo0opWFBjW2HKPamzQukVXYwQZmjO0WviYO6wOoGKM2kIrefyA5pCjLpd963waqrKqR27GlJqSCUBoWDXMAFgSqwM8/zgphIeYj3onSEwIMyUdqR3ameq+1+CoQXOnkH/3uw5EniniFj12Rmnnf27U5A8SbUefz43TpcU9I4a/+OskWPVqiC+/nkUly9oqpbjENNBm97pGiYmvKhDl/pS3kLDT3plobibTDTKBx/RmbzANYm/hi8K89nxcAXLc+UvlMM0AyTv58HDiP/1TkeDXUsRflxVw4vwNIK/ccvbG79hl08jxyAVbpLOWVk33Pp7vpm4TmmWEPDW7zZFIh9Q0yfH8+C1I74+v5fDhATzU+g8c0pYscwEgIk65kg1k4Ij9bPoj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ClPfNkkCPp08xpWmPx3Y2TM+djbDUinslBJoZPEmiKnEPBiFj642FQP85Mk?=
 =?us-ascii?Q?gk1ntaKJafN1ST24OvDTtAV5ferPdzMW/32K+PMbvru9iI1UW5q444ut7+e5?=
 =?us-ascii?Q?9a4jEq1TAQLb81+r0C5gLm1LvZnPiqKHlqwmTFr7znC9auHVHukLV6/gN5Se?=
 =?us-ascii?Q?hpkHumIxU0ecJ3DsSMwhOaRu3GuPgClAIjm0SwMK8Ng4m3AzOD+E84iS8Z15?=
 =?us-ascii?Q?F9ed7r/3gSvBvztU+oe113jVmEqoMJQYph0pDEhvhGTP1yNQYAn0PQM3dABZ?=
 =?us-ascii?Q?BWxCQIejReqAwkIG1zBICVK2eUbXByZOz12aqXpRWNZnz1a86otwMPym2PRF?=
 =?us-ascii?Q?z0ItYL+pG6rO0lZjP/PR+frP0QD4N5NN//Qql0WaC9xp+1k0bsZONcIZT70N?=
 =?us-ascii?Q?/bx9aHMz609ErFLDbxqSfxwdBo/pqo3h7V9buFGKfamRYxKzDNlTg/IsARXz?=
 =?us-ascii?Q?TzR9/rdTT3iYZhEQv90lPoK8xmMadfFOffrzJq+jFUtrmSDV2VNFkS0DVDrk?=
 =?us-ascii?Q?q/iIywFoOqkpbF9MgqUf4D+1kX/CQhwGBj0+cTyWAR13sDsGPxcMmQkmfHfO?=
 =?us-ascii?Q?NgWdT+Ey1p3b4Z6Dp+ySn+ttyagBUde4kC2tnZJ+DuVrrev3gCBxzZYT72ff?=
 =?us-ascii?Q?yhBk23vHlMbALgBTY9H3NDOQqI9GxeypMKcOfBVLh0BdY3d4DSOfGkdHjBsh?=
 =?us-ascii?Q?T9SROO6lBaswBmRNv66XDhdRSfW7G4mA65ckrwwky/gWola80LW59wTLjfZX?=
 =?us-ascii?Q?fczY1XhHHJobf+Pu1Wfov2UW8ei+p2MatmyNruAaUZpLhzEsBe/Kocxwg5ug?=
 =?us-ascii?Q?DE23XSxQTDSSPcpnB6PHXgHHqg67YrcS1t0GSmCz+aYYpFIOtLghR+1sKouG?=
 =?us-ascii?Q?YrbuyYz4DBql3qSRlKNZE4LGYOMutA8WXsFlaXD+9QoNYsA9SRqiVWPOuBQC?=
 =?us-ascii?Q?oikXdq1h3NuwfgxFUeF+qGqk7Ph9foGky8/QSW5AbQS45kv0lDx0W8PnrPyf?=
 =?us-ascii?Q?RdXr009EHNutxYYsyFQgRVhcPH2J77pEjbV+CBX09fewLb5Mza6SXNDzROHI?=
 =?us-ascii?Q?k7dIdK87gcVw4pa0s442T2Lmss9KvRdUOVigSlH1TQL9KWWOkOKQcJiFpM5T?=
 =?us-ascii?Q?X4wXmnIu0BpHiXtn0LYIaaiMCCJpo45wcmQNkZ0tabzY8hlGKyy0wBAnAoip?=
 =?us-ascii?Q?SsClZto/DGg75KAve7giNkP3r47oV3et7hUwLQct30YtNMxcvYcOpRCAOhg3?=
 =?us-ascii?Q?yrv5pV4BRVFyj2wHbTlK7ZtUDTK+h2rWqBM83JnG1aqRc+yl4SqqeqKSo7NZ?=
 =?us-ascii?Q?bLXKmZC8j7LslscSRsToIlJGGt6dnJ/ov0l1K48NNgqpx1Nw3kROzky/ndQC?=
 =?us-ascii?Q?OXBgSuDLNgLz9wGSPeNGCbn/bmY54XamKifciD1XnR4vxixlXQQIOzwIRe+b?=
 =?us-ascii?Q?FU/qNGtnywQSWr6VOaaBGnUOX93SMq2LDUu/JBAt0H/SJXOkIVHNkYfjWoVg?=
 =?us-ascii?Q?hCoyXSl/re4XhFNaXKhWyAB0nJFqF9e6iTHaSpUbP0Gf/quuVPDHxXX0Z0lO?=
 =?us-ascii?Q?WzZ95TqWLqp9Cy5CzYdM1scL952EyGyTk1KQqhknoeMnPOCh+xOdED0qZd4k?=
 =?us-ascii?Q?GYfodpWM9wPkHm0+lSy06EJ+E0Vs8bok0EvIvSr8Rg1qqizd5+Tdp1c6lloO?=
 =?us-ascii?Q?LPmm/cQIf5b9+oj7DAkuaZNFSV6gGI47Zz/D+ZpOKkB+SDCXtsgPeShJd0gy?=
 =?us-ascii?Q?k8uSY5nDEw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78008866-0ec7-4d61-5018-08dec4fd3591
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:14.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjHD9dnH7BvWYYrV/kbI9bTS6TG5uyj9OlLu9zpggCc45Yp+g6H03WXPVyMNVwDu2bT4El0VI62sD2J5l9ZKJJJSIxDeDXbx6lQLd84wXUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Replace socfpga_n5x_defconfig with the configuration from
socfpga_n5x_atf_defconfig and remove the latter, making the
ATF-based configuration the default for N5X.

Add # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set to disable raw image
support in SPL.

Add # CONFIG_TOOLS_MKEFICAPSULE is not set to disable building the
mkeficapsule tool and prevent build errors on hosts without GnuTLS.

Also update socfpga_n5x_vab_defconfig to align with the new ATF-based
socfpga_n5x_defconfig baseline. CONFIG_SOCFPGA_SECURE_VAB_AUTH is the
only VAB-variant-specific addition; all other settings are shared with
socfpga_n5x_defconfig.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_atf_defconfig | 89 ------------------------------
 configs/socfpga_n5x_defconfig     | 20 ++++---
 configs/socfpga_n5x_vab_defconfig | 90 +------------------------------
 3 files changed, 14 insertions(+), 185 deletions(-)
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
deleted file mode 100644
index 674ba744614..00000000000
--- a/configs/socfpga_n5x_atf_defconfig
+++ /dev/null
@@ -1,89 +0,0 @@
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
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_n5x"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2079
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
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
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 3b3916e676d..97c90656e7d 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -1,11 +1,11 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
@@ -21,15 +21,19 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
-# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
+CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
 CONFIG_SYS_PBSIZE=2079
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -38,7 +42,9 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
@@ -56,10 +62,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-# CONFIG_CMD_MTDPARTS is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="Image"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
@@ -85,3 +88,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index 817a01bbf51..3fe74846d01 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -1,89 +1,3 @@
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
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
+#include <configs/socfpga_n5x_defconfig>
+
 CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
-CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_n5x"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2079
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
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
-- 
2.43.7

