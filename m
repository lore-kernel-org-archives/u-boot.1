Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D4CCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A2E84663;
	Thu, 30 Apr 2026 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m+iTtSw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C582584668; Thu, 30 Apr 2026 10:23:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE14E84653
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUrs14Kz109aPePIJtDxBCNKaiGY2ik44N4goom3wQZBsUWnBL/iIFwnz5n5MUWSpdinhyDLjTstepvoq7fCDLgP3kdq69LsH69PrsVc9NZz+IMqOIT6unCn57/EXuOOrHLlmqFbtBTEVTfcowZGWvWIT9St7vaxiZZ8/TrHVnM8SoLHbo/Rm3islvjF9swrVvA8PmW+Hd9rxAVL9+og7VQ2aY0uCbsKV3Gi0ChqDxqY6NKcs87RuMmct6+mppCos8y92X18nfT+9FfQVTphZfO3V7V7v2WYUCV/+sla7GoW4NqV7wljhxM5J4NLQV0Y0B3/+Ip1HWOAHexgr+b7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YVsr86nBi/t2gVzaD26uqpdtiYJb+HtYM8eJjmy9L4=;
 b=PLz/FFxh4lLmrOGbdW6k8WqnDPZ7GRrxTGu9E1FPrrXi4wtBPYCRkVwCAYFXdMjUk27lfG5447HqoFXuIpH+x9xm4SGM4Ws73n2PQP3ojVqn4IvD042lCNy1uiA/qih/o5K8zzB32spGLMkLiahwee2CD57tDl17aPxMRt8MLdAdhHResaHrVfAKkry6Y4sueooIyV8FSFvIkvBwH/UZ2nyi/IVV3yg/F9EBSDSmZs9tbb65fMFgF4y6dTYDU7ImM5WbKA2gXgckkPlo7vDsD+/gFK+Tqnt7jBQH42rOYmS2YbvsJc9JqnKosnlopl5BJANyN/a/I+Nnx6DtuY3OTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YVsr86nBi/t2gVzaD26uqpdtiYJb+HtYM8eJjmy9L4=;
 b=m+iTtSw3q8KNeD010eYVQlUsa8m95R5v1dxc/TvJN3PsOPQ2BFGOEcnz2cv8qw/igcWnaKu3AqfOlU/+MjNCO6E943K9lx4acuPYu/8T4Pcfb/aOyCLKkyTH4hTfkWUzlTbFDoP+uItf6BtXrvvYIPRjHqBydgKnXTi4t68SoQPL3fiUApSfA1GZtMaVIEX3RGTyRODsXuNbkm/7SAi+7rLTouLS6YEh86F9vvTyebAJGKx2L3V4BG/BAWaSGxyU5iNmem9s+ixCfwTDEXVIK8fVy0c83yxhAZvl2DZVyAX8qjbsE996fxXPvrfOIperTGgY46+Er4pbOnePxQHGEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:23:11 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:23:11 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
Subject: [PATCH v4 0/4] imx9{4,5,52}: Add Quickboot support
Date: Thu, 30 Apr 2026 11:33:29 +0300
Message-ID: <cover.1777536451.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 478f235c-4965-44df-b435-08dea691b73f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: NUApPf4TvL1h2+C6/rjuahsM+r0sHNOkKPOOA4XF5dKME2ag6OHcM8/m/KBLZ258ebLQwUmRT58D/Ze/m7o4P3sLKrcGR6COR9Caz4AtgcXzRSljN21YfZZemTSz7Ad9lBi9v5Q6m6VnAShxx2Fs2MEnTijvIcxO99G6fuyxatGtsvrYYGAXudQ4i6PP3L7AlIGmrSRIo9fO678yoUE5AzujQKB/fvGvdurrXcx5ZUrWSgU5+EMZE2BO5SKf6GZyLWNS/WvZFqYdfnDqVclKpt8pmQZkmArQqdq8V0TVpsVTR565Sy9q1eD/m7qVruzdGpxDCsKIaHkTVCuxdz0wjJQ+LLNhBp7uontGM4tlKNpwlxZA8RmzOoQeRWeKCj9te5n3Z5nqaz4bluxoDwKzYAc8coud47KNThGBgIJ5LplTzBIDiBdd8FhdIxdIyKdRd33WSxwno/wAhK+D907+sTkBj7PtIaLNKwUtWNeBzqwUKHteNXNfE0hiLRHwpxHT710FKwSvv8SEeNP1d/pYqS+EA6F52hvnAaKmD5NUMSqafCR/ci9S49bjZa4MXwDiWHnS1srPiJgRxLR/600RWFEZvq99ONRo+d/mA/Sj+X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZLFfjMibSYDaDAg2sDVOBgbGYHk0xiyKiBXf/AZVtdS6KSJXFnY4d4gJajd?=
 =?us-ascii?Q?05HMHGfLDr0xCQ5Ae7fNP8KItO7E1agJRJuu3ORfHxJBXMBoAd4bMxx5PjOh?=
 =?us-ascii?Q?YianXfr9E7fho6AdHIIAQaQW8FOwzTUF6qtpOqwVPaJtd0gk77ECCUfPBULy?=
 =?us-ascii?Q?Rs84UMnJIYq4V7Q1kp8RVqpBsX7Dci02gYWzJalwQ4VI0x0TiKLzd2gzI607?=
 =?us-ascii?Q?SFgzWM6mGT5cgmMpkiR/VyZ9Kc5AsOQZLNDExBwYwl8ukdOr8/JxwO7zLcPM?=
 =?us-ascii?Q?hSO3cHG76RrpLQhF/X5GQzwgGqEcnKxueX0FGffGgjjwoH2VFK2qCJNy8VKz?=
 =?us-ascii?Q?LRSG0vcKAsZWnHh519Xmtd1Vm5CV10UDL8Bp5983N4eokERCl/qPivgsw4d7?=
 =?us-ascii?Q?zt7Yq/YLyk3W3bDgAa47uimAZ6Ony83pxVKuiKyHMEhp8q/MvXVbKL9a3b75?=
 =?us-ascii?Q?RyMjKSOClwIDCe1P9/JFAoq0H4DKWPbNWkdOvspUmZPD1qx/OAsL4ZIhaqdd?=
 =?us-ascii?Q?ozH1XPrxd21S9I2+gj/5mswxSV1bfbsegp9+yxapa+7nE0BedKVabAEloDk3?=
 =?us-ascii?Q?VYnQX+mAmtjqZxi8ZW7fPnel1BNn1NrMHel8p4fdxJn5Jb52HEl+TqkcdyPg?=
 =?us-ascii?Q?0+yF7sMPbnN4mD7bfmmyuz+bLXLqpSd1HpfLmq9FUm4f/FPdY0mZH7LTWY9e?=
 =?us-ascii?Q?lp+diEG8f1shz+zU5zMn998AlMDZJTQXcnT0VkMrpjCucy/1l4jZPVu+0JNa?=
 =?us-ascii?Q?AJp/Q6bagDirXUzBGHJWA6zgdxfCnlJVF4IJ5hqOtvGu2hinKwmn7rVCSp3l?=
 =?us-ascii?Q?COPk7c4UJ+iVLL7e1w6CGrs282fM0zN/9XkcmdsgduxiAP1G0t8HaMiqolvD?=
 =?us-ascii?Q?GTVh2990ektfyfOB6zYQsCwLXJUkPErFF3JW6mSpcmLMGXpvAIMmKnNWc6HR?=
 =?us-ascii?Q?/uHywKSZc1zGVMNvJ4a39UnYNgxbLqXL1G642FDVesPR/t1sH0PLoauDJtpL?=
 =?us-ascii?Q?VlwncWwXJC+nZlF0z3HWPeIHP8bQqggs19pyEmOFFcZUftIwowUdQdQE6Ff7?=
 =?us-ascii?Q?lYlC9aTCD2Q8v1DUpEa/z0beJYGYPdR5U+poqzV8NBVUS+jAluWbYKsXBiIJ?=
 =?us-ascii?Q?tX1ojLcAydo78qZWJBtxTFiKdcFBvI1T7ha2IuIybEZB1M2s3wsJzX20yj/0?=
 =?us-ascii?Q?foHBlib/zrS0QUNI2lJyyJm/1wpftIYK8ksUDsAY+LD7tm7pLx+nV/TJynZ6?=
 =?us-ascii?Q?pEBfyDEe3/W4XZE1SmShTehmOglJ7GF1JiuUilw+rklx+KciEfes4no8gN2E?=
 =?us-ascii?Q?b115l7EtpdUXUfW01UBQEQ1qhJb7pJ9e16IKaGVkDNi3v8BGlgxQIf3vqAKz?=
 =?us-ascii?Q?gXqNhwgd2grrtHvt6d/fhDM+jTSev0GG+YE/0+8TwAp2C2LxrxNbbJ4gbxni?=
 =?us-ascii?Q?BToBeUYvhLih+gldD9Mkg0aN8LBQyoBgFmRVR1CCc8hhY9GzG74LcKJyRow9?=
 =?us-ascii?Q?4WWHJedqxI5iieudObO1Y/lXW5fRWOxkqD6ON9D7WgtfQncU2pU5xRuYnL5u?=
 =?us-ascii?Q?nqv+VNwmXudZTWfqvKD7DVV7QuZiTXtf7bEcS9z0JIizbQkmYZodHkfacAlu?=
 =?us-ascii?Q?CJniSG7hzkuhAf4+YLBxKcUDIqAfyj8WqyfNDq2pkn57/B1u6QvRwVVWADNB?=
 =?us-ascii?Q?7xSgUiE2Ux/eq2J4B0xEiZZ5tXj6I9KQHUsGu2cu+IujtIq4a7AQ3BGxq+KH?=
 =?us-ascii?Q?gjC1UFUMSA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f235c-4965-44df-b435-08dea691b73f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:23:11.1699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiAgO+3fUfQxqIUe3BKUI9jvj98sktAcgK5Nnew/QuiyBdCnJ2d3xviFe67CzjCum0N77bCX6eAWO6XG4ZbhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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

From: Simona Toaca <simona.toaca@nxp.com>

This patch series adds support for saving DDR training
data to non-volatile memory on iMX94, iMX95 and iMX952 platforms.
The purpose is running DDR Quickboot flow on next reboot.

The process is as follows:
- OEI runs Training flow for the DDRPHY
- OEI saves the data from training to volatile memory
- U-Boot can then save it to non-volatile memory (e.g. SD)
- OEI loads the data from NVM at cold reboot and runs Quickboot flow

By skipping training, a much lower boot time is achieved.

Changes for v4:
- add IMX_QB macro to include qb.c based on the boot phase
- change qb_ prefix to imx_qb_ for qb.c methods, to
be more specific
- add boot device macro to string conversion for the case
where the device is not explicitly specified
- pass quickboot args as strings and parse them in qb.c using
blk_device_get_by_str/blk_device_part_str (if they are blk devices).
This enables specifying mmc 0:2 for the boot1 partition of the eMMC
device.
- use blk device API instead of mmc-specific
- use SPI DM methods for spi flash read/write
- use malloc for storing container header instead of kmalloc
- add eMMC hwpart usage to the documentation
- sent the qb-unrelated patches separately

Changes for v3:
- Rebased and added support for iMX952
- Removed IMX_SNPS_DDR_PHY_QB_GEN macro, as it was not useful ->
now CMD_QB is enabled by default on the supported boards
- Removed unnecessary #ifdefs -> replaced with if (CONFIG..)
- Replaced spi_flash_probe with udevice_first_device_err to
avoid using SPI macros that needed ifdefs, since there is only
one SPI flash device available.
- Adnotated qb methods with qb_ to be easier to see in asm dump
- Removed explicit pointer casts from (void *)
- Replaced custom qb_crc32 with the U-Boot one
- Made eveything snake_case
- Enabled SFDP support for iMX943/95, as it is necessary for
proper erase size parsing (and is already present in iMX952 config)
- Improved documentation - explanation about the space in bootloader
- Added commit fixing a style issue in Kconfig

Changes for v2:
- Improved documentation to clarify the questions asked
- Detailed log messages for all commits
- Detailed Kconfig options for SPL_IMX_QB and CMD_IMX_QB
- Fixed the mentioned coding style issues

Simona Toaca (4):
  imx9: Add support for saving DDR training data to NVM
  arm: mach-imx: Add command to expose QB functionality
  board: nxp: imx9{4,5,52}_evk: Add qb save option in SPL
  doc: board: nxp: Add Quickboot documentation

 arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 +
 arch/arm/mach-imx/Kconfig            |  28 ++
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/cmd_qb.c           | 102 +++++++
 arch/arm/mach-imx/imx9/Makefile      |   6 +-
 arch/arm/mach-imx/imx9/qb.c          | 403 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
 board/nxp/imx94_evk/spl.c            |   6 +-
 board/nxp/imx952_evk/spl.c           |   4 +
 board/nxp/imx95_evk/spl.c            |   6 +-
 doc/board/nxp/index.rst              |   1 +
 doc/board/nxp/quickboot.rst          |  59 ++++
 drivers/ddr/imx/imx9/Kconfig         |   7 +
 14 files changed, 688 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/cmd_qb.c
 create mode 100644 arch/arm/mach-imx/imx9/qb.c
 create mode 100644 doc/board/nxp/quickboot.rst

-- 
2.43.0

