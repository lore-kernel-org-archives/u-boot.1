Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0484CCD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DD68490B;
	Fri,  5 Jun 2026 03:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vyGdJwTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9F2849E4; Fri,  5 Jun 2026 03:56:58 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51CF8491C
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3wQ5RFadt1zYResemFQQ533gn6iZGRP7dOA5x7uKk5he9etViVO8AFLdRABvxsRp8PGioQ/KNIxJygcZDGDUBhEEv0keIYMOdiudjo4pQirwFeA8ab+iLB8USzmcmVuZOD5Wnwzg5KqyqGXxew1xpg84TDVsSwLVp5EZ37/78AjN51IJq9kHGFXXANBC+lNhqJAO0v2sunneeMA9mmjOCAFz8XKTCh88IZl+MXRqdk8j3u5bAO+NEoMzIjBO6Z4rpZfdcpOj7lNznMrALcmQOdMbjDzW1zb/MYE3k+IUMqbfEHvVLFEOREXvgs0ykJb1jUMdRwHi3KAIDaFuKyyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gol0oknbZK3Ck7DCwRQiLDhHEBW+hrrNiDKRkJREIGk=;
 b=yTUMXi9m+IHBrolF72tQSiMHWRmZYghVSGjn40KctgC67Nk7mh7PVhCQRV4yZUQmojv4TWRPIzL1Snce7y6dj2Gup38OHmEy7yubDseM6otDWdN3p0M+VD4YC8Xyiem1E9x7AwuVQK/81KxSwvGnNHHZ8QYacF8my3R6haZvWlWlCpLfADSmzWIT2ZTOCakofGZkVy8naWgw0cIYtikQvfwlBqcBf0TFRA/jY7nPjovl8m+Rry2l+NbQs5BHZzMy+gXKRuml1Rj1FB+TlEQGiBowSwSSPwR/OKwSR1qmRMu4+ryPvkxmG2jNolML7M6FCNTHn+2Vw8GaRxraAIuSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gol0oknbZK3Ck7DCwRQiLDhHEBW+hrrNiDKRkJREIGk=;
 b=vyGdJwTyJb+lv3ffv0O8qFIMMbCEI5ETMwpizMZn/Xd4UCazPgr0jkIX4/KWCV4NUgIqEeYil+z+J8EEH2JAznRx8/WAZ5p7hxCHQrXqHoxt3+wTJsTPMsGsEH/7UnzxdH2L6Kt1S8CpKmkchOC8n25uE3iQcgEqDquFpD3Bj7O8CAim2XEAJzT3DELGt6oBX7LjAl/a+vcOSH6Bw2ORMcJpO4A+ahntaTqgtyvq+GexBBSDz/iPTrmtFrWCXGO9bKZSNwWHdQILJaMNmL4qBKby1SSEqWLq0HardpJAau47+wJMhqH6/cU15hKghsrLTcU0T0f8atoBhQPKnp6Tzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:39 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:39 +0000
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
Subject: [PATCH v4 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
Date: Fri,  5 Jun 2026 09:54:56 +0800
Message-ID: <20260605015503.11709-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 363603a0-b5a4-409c-01d3-08dec2a5aef6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: pCayqOK5ppOrxUkD24xkRGEOv89tvEKUozbZGxzhPKNMyPmWjfwVutX9VVB7GkMAdKm5jP+rUwwixrD9hwGonADChJRQNZdVmYu3Sb/jFFsRKXIsTTmKU66YK04Q5EuN98SG+YVry6j3DkDn6uErMFHtfEgfmig6Ycgh2hJ0ClWQ43pkd3oeBZW3yrCwYrgSuriQvarUQXSwu6M5+0JOwBFKchix9LkoHPe2mo6lIvkCr9j/EHQjp+cD/mCwjBUFKH4kIQ1H1d1sgsOwl7ioBpZ64IS3dAWw3Im9LiKnxxYLJ2/ZGHVAH388T8upYu8CR4OLpQcaGqj5ac9wB6wetdDKjvmbBjd53mtidkfV2darbf6sJoXf0jLnWaMjHIIcOHJXLqmBddNnsg8ZLRvDns9J2Ghm1IqiXUPTGwXp+JZk8RzuaFDw7hKhldyASFHsZ6nP+jBMT0+iIzvVFYhKXIHdHgSY0RvynKj0SaJ0zeMXdwBzsw8mRJM/2imo6Uaoicj2J762jgCrg+QGBBSu9Il+wRzKpsVrAgKvhWGAfNRt54V5zgjITkZsPQf1atXbOJyT1iTc1ukiJxiymyuUH9FhKMVolIzmryQCm1XO4ljoxiK7izXdTVETLuWJkVUNY0rUC1YMyvjMa5/Lk7hW20jLQjdUyJo/TpT78FEfEEcYFMWk/fu9bnV+pSV8MWQm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fj7wHItymtIy8NMV4F2NSLUZ5h38CyP++uSsXwmv+dSxfoYbrB7Zd+Cujp9?=
 =?us-ascii?Q?EwbEbSFDsCX0b/CyQ4FZ7AcnzA0EtLGJiWqpV212FVwXtqgXoo+5rstZeghg?=
 =?us-ascii?Q?RDcefIK2Ipa2eZ7gy9GoUa/vcbLoPJJL/VXTXrgbv7HHyN3cRrOiHVYt7Kse?=
 =?us-ascii?Q?AzQN3mOfiCAjnQmjBy9EY7aUf6J8PY2FKbFTK2dpsu8yJ0Q0hVLRXai7peba?=
 =?us-ascii?Q?8+Smme0Ng5vhgvNVeS1LN0jk7qh5R+lSftrwnVE/tNShh1Fmdp3L2p/fE0Dp?=
 =?us-ascii?Q?Yit/LWzOzvIaoG3x6ht4wCo54VukXV6dWQGCME4HktCq8DEcGMxG7jXXRWLV?=
 =?us-ascii?Q?g/Msi0xqmAn54i+cFMdpdJV//EvfnPTRteJ/XDBzedmc925IdOh4dX5AXHzu?=
 =?us-ascii?Q?MUq7SAcXE39pdRG5V99iExVJetuvkzi5Lx6Z+4WVrYZ+iXJ+3xe6LNoZiwOL?=
 =?us-ascii?Q?/iEUC5huXhYwo4cITXXOJFPdg1AJ094IngAKA9KGU5Zj42xgwdG3XaMztyLj?=
 =?us-ascii?Q?KhuX+AkCtQ3Y8anpkIQwFJBPmRwVGibxQ9yTHVDW1itQQT7StRuV39yR4tw5?=
 =?us-ascii?Q?0BZrw0cQwgFZTwlfUX44zHpGVTRfHiiYi2IUFraVqGxQrHGQ+iUjGIc8cGnX?=
 =?us-ascii?Q?cWhV8xWewpiCIZq2aWkA0SCX8N0GBsTYqIJYBuC78kzQCrI5Ff08gKneylHs?=
 =?us-ascii?Q?MwDJxI38L7qHFrorSFw0TXvwD1KDQM7uKPhi1F1VuUx9Bd0GgHLSfCeieKj4?=
 =?us-ascii?Q?p0XG6dOs0qGTVMBtzJincDgsAXGtVGlxMfe6xgK0OgHFi5JPTLkNNFfhOEu2?=
 =?us-ascii?Q?aMy6rxkAdkga63dqZcvTY10CnhTmSAsyCD06kqANXRMTyta55Ur7w80qdQvm?=
 =?us-ascii?Q?+f4Z8HDWlzyTF09U64KhRf50/vwkH/TFkJuOInaC5y1XKGsYg57jHrZz8Dq5?=
 =?us-ascii?Q?tXDPxF9RsoKUhABtatQ64VW2SSZL30aXTUh81QhOy+j6XGlzgBcWti6KKWCM?=
 =?us-ascii?Q?AuIsl1L5R595pGrRF5YVY0hSUUPgYAaNzSc9zukAJzraNJVvYy+UC73SmS5k?=
 =?us-ascii?Q?J2cY4MyT4WPd2ABllM7sK5aUlkTKCNMn9saFjGDYoFy4J8FOJEds9NJ0sKJF?=
 =?us-ascii?Q?AUpTKI1xAwb/dUfDCjaaJ4SJD3jWxd52/79ogXqRomlOLSULK5V7FcIcqzsO?=
 =?us-ascii?Q?3Qh6I1MahwaVCswHUfYm/QL2GPXxkt7WI1wLD4DVF4pf2P9cC+ZwkbssjyJt?=
 =?us-ascii?Q?w+8gUKO+mBT6NGk//2ZPMmPl1w9uJrCpplYZGYA16fdFbuetGBBoUGuw1zmP?=
 =?us-ascii?Q?FYaKi093xr2wxaA+WbhHjlJZ3/mHnv+xoJDf5U6bE5GQDxxIBlqm1vcqk9ei?=
 =?us-ascii?Q?zy3w4LTGxJCTCjATWzSdj8lYxFPx7YxZOF3imVPgvqXrU/sC2J6FF4bHO6DT?=
 =?us-ascii?Q?B9m8TJUTnH38fRwzJdAF+q4c83/0V1wM3KZUZ2z9DENnSsnGnbq+xDyGrNb2?=
 =?us-ascii?Q?7kpN+mzzRev4VuA7xoqRByKiYNofNq+p2cpl49OI3jA5y4Gu8e9+dubyHFwY?=
 =?us-ascii?Q?gm/Y9Nc9XwuMO3+ixUMFCjotztXLCoH54JfoqxIo2LcFhyzhXpeo0ziOO6QL?=
 =?us-ascii?Q?d3saA217/nQEEpEQyLAW6W4Hr1Gnfaq+IrhkbrnoI97OgOfTvEEu7EyGs2wu?=
 =?us-ascii?Q?fkpY4gADI84X+eTox3xyqZIQjf7TYOMxZv57U3YcS0Luu1dYiH72KLLXYK4S?=
 =?us-ascii?Q?D6Pd8p9InfYjlfFf+hvZ7qylukp4Bbc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363603a0-b5a4-409c-01d3-08dec2a5aef6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:39.7268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN8+JCZ2RIEKUDLhVwkOkhqgKR442z1BnKw1RJv7lkKoyf6DYuRIisGP6i9T7af9qVvs16mt7xZ+Yv7uXEHMQHyyCmga2SgZ5StINtX2OL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

(no changes since v3)

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

