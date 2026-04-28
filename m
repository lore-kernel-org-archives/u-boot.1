Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D3DFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380BF8429E;
	Tue, 28 Apr 2026 05:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NCtlTFm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4F1842EF; Tue, 28 Apr 2026 05:48:37 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DD184258
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjpnykgQKWgDYemoCXUO5UCzJaoo6/Q9xGbHZyyEsLumjDgxo1dmaEzzAyMo+hQ+A8ZstzAhb32GSOW8tb2WECfAmANkbQx8hGdJBnFWoEA/97WVwMknn7NGY1syNb2eI2BIzii7LCRUoGjhHGoRXZ/CaiwUWtzFsdbT9G3k/+nmIf71SEkcxTC9yMGzVMhHpQYemTkdGg9bGQzseZjUn7KbYjVS2YzpiWNONiyj/MS1RzpPEJJjmTYsgyTkp5wqWtbWNpisvd2E3J9+UXB+BnzRMQQVmSjSJch+tkrPRuZ+c+yfLHZa0QyKNQaebta/zR019pt1xoJzA1C5u1PSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9pKPs55n0g9ZXv6WIFXpwj1brmkB7vuP59xWSfjVN0=;
 b=p5Dmoy2hKMWpFm+NXIlNiWLQ1B76W5BYVJuj+OEqKz0V1H5jZr3iwVArJ19p6qEWuWEOq0A1YDP/q1KobVlphw7EOXD8x2H+tFOLBuf7WgAI7XSoPECCsjB5v9xnaMXa8pMT+GTk2NRExE1wDYcOFmWfNJrKvYJIYLdHdnWWHPCiZ26KcH4DvlW9XJLOuu6YLd03pSOjfblaIPEBLgqjStHT7yFcSTVTLUjqp+oxuMHwajpxZyWHTeHI7lkSo+DhePOqg6rHZdiot3W5bjvnmvVTtlH44gRFaLBlZBvkrhWn+td3I8A+15QVmKMm/0guMQ9N+wqvykR/Lf6IYzybCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9pKPs55n0g9ZXv6WIFXpwj1brmkB7vuP59xWSfjVN0=;
 b=NCtlTFm2RTubn18hTZfbPabizLyOO1PM9U4LDZuyR+51QSrvy6zGmciuICKqpKziedxlYcXyhsg7pkRGpU8uNNU52c7hTjw7VDjOkm/CXZAW2+D82bfO8G5J+GM4znP/YkIh0UXIRUBUEyDvkzfGKhE7OmwN69ANA6qJ1gszNyUf+Ae97J5IQFx3mWGpJep3nXXTye2MmvDFUvP0LqhrJiHrKkFyUlA/GsS0oR2JhMG9vM7Ya3Zql/09B69/mR/KI2Mmuca/7R7ClRVKKAvz7qgVN16GND04xP1Rg2LNP1EeqhupFfp/Mp4pPZO5B5NnnOHw4MAvjOqtuVnBLS6afQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:29 +0000
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
Subject: [PATCH v2 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
Date: Mon, 27 Apr 2026 20:48:15 -0700
Message-ID: <20260428034822.23756-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef14a3f-4fc3-4e91-451f-08dea4d902b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: VmSFr4ENnCqjLQ7Voarxl2St3NLY65HUNqhNW/w7DeuEKM48oacGDC0apoBHt3D/MwhqS2VccRbtudvhbXgZkNIi1fh7Le3ftLGt062QX86YQzYcA3XnqnU8IWGxB0mMCYp64vgjug7eyD4GmEBIJtmASkpVskL2nVyPVWegkCEeJE6Z19IGRdczMsbX7Zoue35yw/WN/knZj6D3Xnyb4WQ7UV6KrdXIFqd/otMO25Yktr22NwZaCXgRCAxmURGAFrKw4DtpkZOg2uf/6RERlKNdvxVpyNmJejkZPwGGGJLRLpxqMHlLJXn3SrqRX/8zBAN5TFwmh3DVjs/TOvqmRswZulvpWi713ae4PH8kUO6xE4g5cpIxIESBqSaeF1vWJ5H+XxJKzesjUiA+fNzFtbPe63uGKeqtO8051l1gRNs1SdkpfKcMJ3xiIXUTF2QcNaf++vQmdr0TsbXHrBOKo4jwv5q7ReAYC6R3xYywkztGAB6YuUEcgA3FB/3g9BaA+losu2+LiNyWSSaBOnkXzSQk5jo9yTF9u8zzLMOFKQLltbM1aQnDEBFl5Yhp44A9LXoOv8QmoHtxkaQswCQOEY8gwtXUUzxCNrJb8teSXGXX7xxwMRqjYYElUbcS/9j6CjJrJGh8QxjoFlSYjxXsf/yqgeTIuSDt1Cd+okPBkvx1gbGNGzu7PLanivPINEE1rsTPC0TZSUjYLWeJJDCvgc207Mc2z/ZU6LJO9JjAtQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LW1TTI3qbvlbJcjn/mdTCxphF6nNSW8186xJHc1tdForjvLDPgtuBtB7eho4?=
 =?us-ascii?Q?MKQd8AzQR5qTs6pRHgBTqrvoDKNoFU4M8E0EucXwDVcegUKsywHaJybw67fx?=
 =?us-ascii?Q?LVulprsghslMx0LMPJQEYLRVReFBfotj4LZ8PP6KP6Ma3P2xfL48EiCaEtvd?=
 =?us-ascii?Q?m/nncVfPRU4UQ0aTan30CdySb1UGOu8ErnuVWpjoRECmGawc/5Vz8cwT7a78?=
 =?us-ascii?Q?CP6O95f3zoI/B7MlGYJVaHri+yxB6TQ2Y1ss8t/0Ty1Itbf3aemvYQ8nm5xN?=
 =?us-ascii?Q?nhsYpMKdccNM3f9SVq8Uf4n+cWtArkzghugsqnbITvud2GiH7+m3672XN7nd?=
 =?us-ascii?Q?D2rKmYMhvP4tELTFchg2W2flpXinqQnEsH7vK42M47cPcr9UBebo+hYjzIzY?=
 =?us-ascii?Q?OgeqT5cuDBxxaMw7oANVoGJNnSVUiQpzLy4vDaH/+p8R3PBF78p5ACfkHcqj?=
 =?us-ascii?Q?oYjFqttL2YK7F/Lgzd0D8X7Jq52wv/SgvuLNHGzIbIP+q1lACnIxxqEA2Qa0?=
 =?us-ascii?Q?pMCNWqmdi7qxiMRBOMK2uy+XjmPxOtYFPhDWnGvK32XBl+PRgLrXiIbU5txw?=
 =?us-ascii?Q?xHYTiX19pJvkCX2TdnDPqPWVKE8UsJZGLBj7qbbl5gx5R20zKEQRRM56hk19?=
 =?us-ascii?Q?DI25b2i5XUpNyc/W9/m5SjiQu3BqK7nTyEG7hEkcXKvRTy/qFrbM5gY7SZtP?=
 =?us-ascii?Q?Na/EgH437+kfUzJnyJ6qA0YUFoKiHyWCcM8Tbozrw/0ecXvc94N8dU2r1/6D?=
 =?us-ascii?Q?fIcw93WZcREDmqARb+JfNEWn+NBkT8XkBIhuf2uYoQQZXOwk7SWEwvRBLMdI?=
 =?us-ascii?Q?FpfnZyvXjQnDvph9f3nq7PjQdabzRc8+SOOpN2susbFuPgueMZ5NDP1m8wL/?=
 =?us-ascii?Q?QLc7Umqt7scwQX7HgJSFotUA2bXL1630Ud1/QJm7mIQTBdqwrGTTJ2xMY4MQ?=
 =?us-ascii?Q?KHtRGxlint6uMJuaadTf4CCrUj/EBpGxOZXjb8SYGfuAUwyxPt205bZ+XIL1?=
 =?us-ascii?Q?tHkaT2YfHPEujBd+BzbJD2Oc0fxuIPuM87j27xPoLw6kFOfRkowrWMnzGZiZ?=
 =?us-ascii?Q?IBh4+RfTCBpGaiFEL3ukFyW5Qi1MM8VIyPUNbcd+1vdx/QQqDEcgXPvE7So8?=
 =?us-ascii?Q?3hnrfPEpHGZEkMeWKeld5sVpTmpx8geIeTHJjNnmjeUMBmDcijrIB8iGZSzX?=
 =?us-ascii?Q?bA0kicnwlXAsN9dtxyHoEAGLarc/7JxzPx7rWsOcg1RdkkvujGD6SKd/Xlcs?=
 =?us-ascii?Q?MBKnHz4qWuLVHYFhyOmk6av6Ep4yMIRunMLixF8n6c9cDoYmessJRlS4asn/?=
 =?us-ascii?Q?WhFu9imY0U/D4lTrOwXRU6AsfZayP4mLLaJED22VJWQVKFGlGxuo4P1P7OBZ?=
 =?us-ascii?Q?ZllELu9Cm5BF5Fjn9FMJk8TgiNq8akYHvtFUMBE0pcU/T8VIiZA383CKRspd?=
 =?us-ascii?Q?EJS5wStXLgBQsYGrB9mrX4J0yiwSAeBteqB4v0/ZFM4G6rValTW4lHPGBLBL?=
 =?us-ascii?Q?s/dTDbnKctJqpoL1am5hdKT+Y/EYsLRENVauaFK+SPTDhHiAH1LYf7g0Y8Ep?=
 =?us-ascii?Q?MZ50vrForz5GGqVEtr167WNSWjscHCC+R3zhCXfGape1A2X36nczPsi0HGvK?=
 =?us-ascii?Q?X8ueDfW+VkOG/1ZbQEzUFw0a0pNbcbjr2zLqw2pYkLb0FvGwe4/6D9cDLbi8?=
 =?us-ascii?Q?LIKHRt+v/bTdp7BU3bqSjffH/cffLtrIrpEo1H7R8T+cvq5yd8RfMnC4YZTa?=
 =?us-ascii?Q?IIOr1botdZG5awPq58JoEgn+dDik0QR0LQRiQcr8kPxhYs7YacpK?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef14a3f-4fc3-4e91-451f-08dea4d902b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:29.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxwh6ZSKMNCF7erp9VD8DkIQvWYk2iidhSAQjLY13UXI71gY56ery8G5EHxRmc5UOllGdF/jPScvjAeDXxg6jZ3StzlVo6lfENKGN+8hjws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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

