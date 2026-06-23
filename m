Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF763CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C82784A6E;
	Tue, 23 Jun 2026 08:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kPL8Gvu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01358849CE; Tue, 23 Jun 2026 04:02:51 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81569849E0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr+PidY7jg+wTGrlit3i824emEIuyRMYpnWyF4VVk7AyI1++6cAiJ+8SKr2FJVTrLcQYhpWbAKxzkEN04Nb8w8BFepg1hdiuL6f1wMC6cReT7LQ1jijPIO9vq30O9ONLc45NkcPlyyij1uJPPJCFTWEb27SsBn+Q+ezGBY3/Yrmkqmseg+WsWqcwfmfnDMEl48xKGPIuV3JZpAlUsBiWpV0Ppt+nDeWmpcCbFRzYWw964k/lSZBuD81hdUPCC10mNXG4Np8FzME4nq05V8kjGhKmAG43GmvYsfwnEXwfYUBJupAwUpGZ9nv281j6gGYl///fa168mNOVH/KR3N5vMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXk/XNRgqXEv6XgjDA1hMUir45Q/ABj0DL6e2ASLu3o=;
 b=OAhAq94hcWBLJypmjT3zD10TAyWuhXxKILhOjzKwr/1YkPXQ5Wwxb4C4LkD+R1TwrUFxg7P+KjhzaPHZE7zdzKOHbxNHuFD3aDrxwxTCQVaSuDB9HGkWSQnMZmMkOLuurwukIQrrsQjDiHGdudVKQupm/AR/mYAiYFrIjtLfHPB53C0g+kuQ6sjzJ7utcTw/6+sF31+1AD7cXPME0c6jHGi7CjYeHf/psLK0SSOdjWmPCViV0aECECBSbKAmDPswZGQTx8ZJ9Ea3pKRNG5SBVMIUvqU0a05JRrGVZdb6hdqDFYcWJfiGOui/k5v9vGiip/NHMlbvh7jyeOQv4Je5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXk/XNRgqXEv6XgjDA1hMUir45Q/ABj0DL6e2ASLu3o=;
 b=kPL8Gvu1cN9oRaMmuLuzrwnf276IScmUnypFbkTvYXwWzZIiay7f6MPhd46iiIaEbs4tom3t4WMnr+FN4f0S5fTrngWxikm6K0Vm0LSyvuFaKNCPBuO8e8e6+8aWyQY8eqbPc7NQ5bPA92fEODUyuWDHqiuweRyPJuDQ40NljzqqSHb5boHrtd53Xr5SqFjtDWGI6L8gFpcHnuWCa/7uMBspGTNDUu8blFr0WG+IgAgMRKDN5LiXgF9tzB2tk6dQcWAvHys8jUd1OSheK5WN6QHw2nh3uCBa/O2pyaZKaa7AHo+F1IjtDZaZh5p5YcyxpPFSpIBI9mpzDOjECUhhYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:02:47 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:02:47 +0000
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
Subject: [PATCH v4 1/7] configs: socfpga: n5x: consolidate ATF defconfig and
 simplify VAB
Date: Tue, 23 Jun 2026 10:02:15 +0800
Message-ID: <20260623020221.32362-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6020b6-4c57-4e7d-b22d-08ded0cb8550
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: P2xBESP7QkxltTb80Bb4Nu1xsHHHavd1NJck2+3opUAaCSPrh8b8tDXI9DwgS5ism8NKfhJv1GvZkacv9MrhLFmPZIP2SWM0ynzKYCGvgECbAXSEMnu2E3RI0nwW8n+AMO7N8+hqjQHxLTCLizUPBlqFIPcHglo7wJQQKV1XdLGBfwWqYa5Zva2whC0hugkGb4eBYvxfohhMpp/qM8beMABycj9tlP+x+IO5kC3Kppmo4hYa8gzaAhVTk23cM8lImzeut7CNa6LqoCg/wDkK7G/8dswo2ULEbtXCssm7ybdJqB3zL/QQqd+qkBgeFgG3L0yF3wAL0nAXWkY6g7/1KmmOuXXKSGCEUI1nTjAMySR8qAx5pcnkMANT2HSJhiH6x4ykscrpaO/vlqy9ub/2k+2bRHVw9PoonO/Q5/hREmKg/g/b/tL5hHixL1mL+nUVTF72mqOuJ2k3sB9tgsB5bL0wj7vioqDPTzP8QG4gUbOxxoNkIELTq0eqJO4uklnsdWx7rG0B75slLaaBpGQibl33yO+mWKjFNMOPLBHOsIixX0DbfoalJmOKZgNy+5QCFljLOeKLQHIzmRKRL+wt2ATo/aTHyYn3alXrsdwJnULGHmla8ORYHZOJOFCREJQgUWpnrUE9V23bwJN9JDxep6lpqlMdbGadi+rbzHWk1Hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8Kt19AXmHI2TPkTyXIqGG5std6Dpw4iFBRLez0sFkrxbYq3Zl7g7xD035EC?=
 =?us-ascii?Q?BpuMRY7gnX/fZtXwP61j8y/h604W2HAU20MQLkbllR+JhuRaVR/9T4Srj649?=
 =?us-ascii?Q?cUPmhCEZXPn5Hj7ZMnOAEAWVgo+OH2khHZrPeoKufaKXdCnF29c/YOF3fAHI?=
 =?us-ascii?Q?aW7w1NwCMguf6unmS5+m7Tntbo4PNSZ86Rz/3LRAiKSsBHKdqxkd7pBq4wjj?=
 =?us-ascii?Q?JAP7TFey0UnAH5UFRXp85nFaR9ttU04mR1uLbcCyHXco7LPk1wQB5AeC2B8b?=
 =?us-ascii?Q?7sPDWvdLhZe5aCGUSOn6BxSCmr1Xb2uxbVeNZuf38gNVf/Lk+yOGjDoD8Eyj?=
 =?us-ascii?Q?Wd0V+zjyDNl2xCjf4FW/Qli/YQacS1WTRf+V708RMcZyOnGIDTz9KwDaeWj3?=
 =?us-ascii?Q?7PjR506Q3v/0aTmWe91X3yEtKzHEVZqlUdjQITfys9UN9NDHgfixaNSFeju6?=
 =?us-ascii?Q?dCf0luSWE7wWEn3V9/oivG6uw2Mz2AYDa18SNTknBKl9NpOHINrV19hMIUN7?=
 =?us-ascii?Q?0NJEmL3bawnCPaMlOhoqsBNBbIuS+qctN95Peienox/mveQmnK8Xt5RmUgvX?=
 =?us-ascii?Q?JOVI0opXTIPinBWrly8t7FgpNBCyj4RfvUcc+75WQONGjawY+ifQ4mCzfXJI?=
 =?us-ascii?Q?C8FkC3eHWheEcuLajmvpxhKQeBEDe9DpVMh48JCd1e7T7MuGm9q0rB1TRZni?=
 =?us-ascii?Q?7QIsynDiE0W3cAphNTZ2XJRK3FLJHt/A9f7g/3YZ8t5KVf5ugvDEOXPn1h08?=
 =?us-ascii?Q?DGrt41bU2QSyzLRCPfRilzZFayyvdTvdVpl3YUyjRPyNOnm7MSOCFeLwSRsp?=
 =?us-ascii?Q?M+P/CUA8P/ugMNsMGBTH+N828+soYQ0rx1glFnp+j6QSpUmNeZhQyLPNRZVX?=
 =?us-ascii?Q?1TSDouo39gBc6d8MpQDEbVPxcgptuu+ZNF3ay3gzEs//q38viw/ik+qIuxSn?=
 =?us-ascii?Q?t9w7V9YI4TOlE+usjXDuGomA7xDDyG6MdH5cv1KuIuQ5akpPj6X1+rkOKxls?=
 =?us-ascii?Q?Gc8pgTC5JwXjgHVM0NGqMwkYuWfr6Xsd3iMbORAav3mZjajJYbY1GEqzMkdn?=
 =?us-ascii?Q?lIrAoqgW3jxT7VD21AYH/i6pVH23M5MdznJGxZ2KZmq/UF/ShLsPzSN8nCn6?=
 =?us-ascii?Q?rHHEHlq59qvOPhtdCos40cdeznO61D778Xlk9kp5SL+g5ccwyKISOWu8ucfN?=
 =?us-ascii?Q?Z6SIduKjUwFx8lqqtoo4j/hBdpp2logSsuZoCNcSDM1RvOCeL1wn/23ofkZt?=
 =?us-ascii?Q?qGGUmUT+YjAzl1WDYIulrZw90Dch/gH8f1W3g8/dRVx/u7tNBs3noocqF+21?=
 =?us-ascii?Q?J+hspfnh+Ur5nqoNwUFge0J5cEEqfUeR2xYPxhiZO6Ils2SpSiUz9UG5SY/0?=
 =?us-ascii?Q?NbmaUzyI/khcbeewiIuoxHyKpAWqUc2hLvCtZgQiRPapIzlQJQVu82IYJtu0?=
 =?us-ascii?Q?pzsX8H+meCLkRYeG//h6ozajcbJAdR6hqB8PND1z+cYA0Kz38mR8JbQBZmf3?=
 =?us-ascii?Q?kViW8eUZk1QYh/hgUaUhVsouICUaW+eJJ6Jh6SDZVQemdIJNXT3687Lvj2eU?=
 =?us-ascii?Q?LRRlFEgPrsDPqa+w7CIHMVRbxcsa2lmHu/dBhjKutdGcAQuf91JGjF54kqmz?=
 =?us-ascii?Q?znumGeVwFjoi1rNzX5cKigOzeZUUIMwf5MK5Fgvz7Gc/ESuQTo/FoUb6Mv2j?=
 =?us-ascii?Q?dM8rx41xfiiFRrBRfl6wQfuBj3smb9PDTMTsY8AmPDhegoxj7O4kBcVgC5wS?=
 =?us-ascii?Q?krrdqwwWBtIyf4AkTrHIYoddx+ZHCDY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6020b6-4c57-4e7d-b22d-08ded0cb8550
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:02:47.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JUBdsWjR+w6y4btM9IZa193AD5fXU6tn+Az9X7J2ys/4xksrmJL1NBhwi7bc43KwTra3UhiMphgqjh3zVGWALXo0EPw7kSWqPaBSdDnCmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

