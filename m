Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4CAD39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C92A8412A;
	Thu,  2 Apr 2026 11:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZjG78OJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4086484106; Thu,  2 Apr 2026 11:29:31 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C405D840B5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3BixY4pt9EiSyb064BuMiqnLGyvyRh8qswOevZ6EuFPwCcU2GeQQONQI25/qcEtEZgW/I5NdDZbAe1V+UY71bThbrPhuRljzwnzwsVQFOk2LQJdxDlQwIBHmTD/ztiZw/R7NEJv3IV5zIBe696r1lJVpz7HJlS/TrterkPip+ijnJaF9hRCR1n74j3S+8sr9AoJIjBZPg6CDugaXiQk1CGG7L+18RPGyaEfOFyhCPIdV58QN7tmSGoPHk3JJLloRbY18wDq8UZIe7FcV21eHGDpaJ6E8lgpJ965fiSjb6kFgBmXn3QqGkgJosAc/w5b3HQM/A/AlUrl1/zh6Gm5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7JhY+SKxyoHGPHhOSdEtTl2o7Rrqas5t7+/D7elm2w=;
 b=L7oHDDO7l7hVGVs3yzMnt8XzyCS2txzI5kw3aAZs09EZ35A/lq4CcAC0kSrmICux5Jp0FTrTEIbvJr0sRJNOqJpTZUhpjrMDfu78EfJztVg7GeT9EUmqG5UoTdkVN/iBUrw3BxOBBpHamhT1e8oli1/pn/PcLZzPDt0LzlAN/Zk+odkbjwwjxLMTcEUDKUh+hZl+m+Mmfl9WzYyCzcjXAUwHyBjTYM2J95OQsspbgqrjpGI21YsPMo3lQIS/PfWyQ8+Hezh2hYjyeBFlNe3xWo9tAKhlBn8pVJ2Hqe+mahQvtsIxVrLknKnpKury6+1xK31HCViSLXayabljCp/qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7JhY+SKxyoHGPHhOSdEtTl2o7Rrqas5t7+/D7elm2w=;
 b=ZjG78OJuurrxQMCRE0tfjsS1DE+0E2H16GAw7dosK/NT4m0NAcm7yZzBGesgVcYTOoaAFeuZUXl7br+Rqk61kl1jkMhJ9MnhRcKQvrn8bkRnyjXh7AwDDouLW/NE5BPMvXpZeBoUjpWU4bY9+EyX7Z/H56mhzMscsvMiEAIaldoTRAL4CepfMAUbvMNZtLC/M+7DfmUbJO1BMbJfN+Kt39n2eO4LXgYKSlnuuNGzl71CovY0NnKVMXwEhzoz7ghawuJ9+H70Zg1UNIOAi6H7tDC6Tdh6pzbSwfbUGg8BjQX/NztIMl5GVTXNtaY47P9ktwWNNuGCGZfp3RgOzCGzoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:26 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:26 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 0/6] imx9{4,5,52}: Add Quickboot support
Date: Thu,  2 Apr 2026 12:40:42 +0300
Message-ID: <cover.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd4f1f0-2b18-4ad7-d233-08de909a5476
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: mjg5eB15MDSxikmUKXbdqEPrUNx1rTH33TV7apIzmfWEfay5yi5Tcl3QW5YZKYgD4Aoq79lUA2AwyqdGFpsAcvlgL4/95NccwZEGkcf1a9sq5zHZ42AmFNG7/RsFGqTHI5FzmBWSSp0nBIgqiA9hMlWWWPD37BSiHRQEWqFfCFSK9lEXHV+VCXzJy/++A5lMPFlTnV1637EDQcl1nI2UgHXtg8HJSusBG4MgyQ9TcmquX1nLKFwyIAZ+bVf4vjXR6GVxU6ApRvevv4noW6UkUbI8rQPIhuB1xQWLSBkZRgWmv+N0uatSPI9Ge2g2QQlxGnEeNXKT1lc7Sekhfsa+Hxa4rtMQyMlBRVjzmm7pzA6K0dRrA9Gf+aQfGncxCTgGM0Y8Z+MoOU5qggDLnkS6rR23y3svlyTRlZsgQCbvYiJxCqhyJTZJs04N1W564nqwoKK97Mzt6tI8Kol6v8taRkxFUe0xefQGrGjDwKtfhwOCmmOZAZL+SSeaKJYyODZ6fNoiXgq4Au/XyOAkTF3/4rDwexdRtUl1oRBkFzeFbQSDA2+gPG5thB9r8ug7MVyeik9BkDSZomY+FeIZv3G/biDRpJ6MJ/NDCsdHDvSg/v4Xzr5u2rCpsfv+P7mn23CDqDXtetwWWWDJToRr8Z3uCOr7jutW22hElTiBgs40GIpnOhprUOZ/plj1es4jAdlzRUaf6iL1pNhl9zLJFA1P/hoEZbCJZhkKMkCiWdv2x3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oE6rSRkVNLnjEjKZWL859L4/wguHMlLX9OeE/AOgwBkpZt2Dn/8iwW8LQZvx?=
 =?us-ascii?Q?7W3NnO/oPg+fDrH07msBdWsQgXfMPAoxEBKFJ32TVk8T2SNuFB10gEm1/WpS?=
 =?us-ascii?Q?FH7hZRQvrKryRT8JKm1fDWog9PeHupwpRpT3hza2huHyo/P6/CysBNf7G5JS?=
 =?us-ascii?Q?ha60vN0CNUzeK6rz84EGCymVbaZb263gMBkSmv84JyUi0qdwac4k6+IyP4nY?=
 =?us-ascii?Q?We5C70gKyVIAE7dTmuVJxZBT/R0C3MtVXuKvdlWye7Q78znYOgD9QjT2o1io?=
 =?us-ascii?Q?eXg2IfTdvY1w7DYPVKuuiC8ihCKEriXmF82R4doDMsgfglwG6PgWYH6UsROI?=
 =?us-ascii?Q?+Jb1UcV7mUH80IxU5ux2u2op+79cj+KD459va104PvOJpcC6sFuMfNSMa2r4?=
 =?us-ascii?Q?+ar8H1cVD8gvTKVLBUO5+4hY6EQ4BboMl0koLfJzlDsX21ss78gwaPX8Xkco?=
 =?us-ascii?Q?snLJWn9rd4VvaATBHvJqiFrJKrqdxaneLVhWBtiVjuR5gPYVgePMAcjl66sS?=
 =?us-ascii?Q?OzrrCH2QFILJzj8RK7WLU5XWhVE/1jWeddQFgyZz07MwpUWGVGWqSAG4rjzQ?=
 =?us-ascii?Q?R9KfvQ5cMs73mPfEbQl2vfFPom/zw/gqTwaeje8UakxKggkFB94S5akip7Lu?=
 =?us-ascii?Q?JNqScerJde1sCcNnZ9wgejtUKI/ptTXptxooiNgaxq67UGnm6qddUYDBVs8W?=
 =?us-ascii?Q?GoVqzXUCwX50PySNjSjOC4qdwvQwLml0ltwf+n3nCHOz1+NNP4YvCEeq9RMM?=
 =?us-ascii?Q?I8ho0sfBkFYfm2TlwouZudXnVCHol3AYiz2PP/ZAe48pIvzAK/Y3ax/1ocRS?=
 =?us-ascii?Q?ftJpwoRHcpdrxfQxrgL0q6yqydM67zU0Hq4vBSrbBgpIRehwpYIS7AuDqICE?=
 =?us-ascii?Q?u+uFby0Q9fIwSq8etqazhbrFeCP+LXNBwUyr8NLp/tMQP8pYGZdTQ1SbRsBp?=
 =?us-ascii?Q?0dJyBQSequ+NOp68f8cy9ghnY5nn3PcmVynztrcRI34OJMzSzzeTIM6AMFdE?=
 =?us-ascii?Q?KjxQvSHGTaNcCkoie1Cda0wcFSaw6ZViZmVltl/T+2b3veG9Z2bXaUD7Jqic?=
 =?us-ascii?Q?XZ8YCygRUYm8QSVj07+4089Kh7j9DpnQdNgDcegBFrfdHhG3jk/Vg4QUiaIB?=
 =?us-ascii?Q?ew/kPO1wEG74jz0Per2Kw4glONZbl3RwouqNRwlWAW23gPLajN8OYLtU88tQ?=
 =?us-ascii?Q?qBAzA10SjGfU+e9QufjBhrA/MCJkFDSW7eacOBaXmj2r5VDlwoO7cuSTTLUB?=
 =?us-ascii?Q?8wzVtclcsIW2bNFs7OMzac/uZmQAYthCyCTn1ZIwcq1cji/qIZ4D4NloLPoS?=
 =?us-ascii?Q?KpHwu4rTF0ysrkhaB7LRaLgPgNSRoqO0r+uBDwrWobYjpvdBnGl3aXcogwCW?=
 =?us-ascii?Q?Tonfd2MPeATGbQc4NuwElXWPjytdNgrmArW1qRHF/zEQa9aZxMbm7YZPhfui?=
 =?us-ascii?Q?YGVarreoxqSh+B9jOOQfVsfi74qPwH0tjf7iKkAwKKdDfecm/M+Qrwz7W3fD?=
 =?us-ascii?Q?AT18Uncb/zBXgxxm/7IiAENL9Pcwa9J6QwQQRACu9/jRvsXzP+of0o/blJ//?=
 =?us-ascii?Q?qUNvhMc+UVqeDx4tHEENUfiPG0nuQVQMqtUq64s5eh61vzjHJWo2NSiNO40p?=
 =?us-ascii?Q?Xte+wJXWHUIRFEcSAprSUTvZD+QsrBGCx8zBvDHWs7gGer7cn8P4pTQGWa6j?=
 =?us-ascii?Q?fEsCkN4oUD+bwNqEfQgOFIMEFJqAiR3fGePc9Els/t956TVwGDZczLerLvNJ?=
 =?us-ascii?Q?+4Yn5DaeYw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd4f1f0-2b18-4ad7-d233-08de909a5476
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:25.9174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzAsEce/4pQV4n6KPCbbTOAsvPhpseXz19yHbeIzaJIH7G7Qg/Jlsq7MZZOAKCxLIi27SfK5P1SHm5uleAqdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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

Simona Toaca (6):
  imx9: Add support for saving DDR training data to NVM
  arm: mach-imx: Add command to expose QB functionality
  configs: imx9{43, 5}: Enable SPI SFDP support
  board: nxp: imx9{4,5,52}_evk: Add qb save option in SPL
  doc: board: nxp: Add Quickboot documentation
  drivers: ddr: imx: Fix Kconfig for SAVED_DRAM_TIMING_BASE

 arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 ++
 arch/arm/mach-imx/Kconfig            |  19 ++
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/cmd_qb.c           | 132 ++++++++++
 arch/arm/mach-imx/imx9/Makefile      |  10 +-
 arch/arm/mach-imx/imx9/qb.c          | 379 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
 board/nxp/imx94_evk/spl.c            |   6 +-
 board/nxp/imx952_evk/spl.c           |   4 +
 board/nxp/imx95_evk/spl.c            |   6 +-
 configs/imx943_evk_defconfig         |   1 +
 configs/imx95_15x15_evk_defconfig    |   1 +
 configs/imx95_evk.config             |   1 +
 doc/board/nxp/index.rst              |   1 +
 doc/board/nxp/qb.rst                 |  54 ++++
 drivers/ddr/imx/imx9/Kconfig         |   9 +-
 17 files changed, 688 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/cmd_qb.c
 create mode 100644 arch/arm/mach-imx/imx9/qb.c
 create mode 100644 doc/board/nxp/qb.rst

-- 
2.43.0

