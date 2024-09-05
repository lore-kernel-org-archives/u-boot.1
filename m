Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D085BCD4F4E
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC87B88363;
	Thu,  5 Sep 2024 05:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nwNicgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B362887F3; Thu,  5 Sep 2024 05:22:05 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88804880A5
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXXpznoOxQkfNcxGrou0STAxGcUY+qn2Q8I0YA41amTDlhyNdfODY1P0kZeBk51LPZpp5espgTJIoCzidEYGzyr8OcRmcERMPkbkV/GzjCwuJE8qL+Dgcy98HgNnogxwz+3C4/gZQFQhw9Nxjm157MProDr9VGTvySpcZvzo7Z1WYHqIDmgSe/vOJFlF3gQ9mLs+v/ZmN5naYLghVVofcGXNmgswj3r+cuL7GAA6xYXDyrkHamYaB/2wxaIEyYDDSyY+wcJWbuKBMJlyY8iThjJLD9KeCyBRDIh/CTWmpuryUO0Awuh2TgCzaHMUazokb1sk7A7uMjjzAO1fsMLAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KStDVsskOW8onVvRXiPtIot9uPqU6t47jTVfarOI0DU=;
 b=o1qnws9WjsKAY0AshZPu6bAhN2MTeH0dEaFGlWF7mRH4iqToA4n4gkPsV2djQOtCZY8sG+mT2fSuT147rU1fvEJ7+pVzhKlKcnEWy16nXKx64/kKiT8yRz/wvNRJg84UerMlu4nldyng1kEwF2zLbgqM1NnagQgqD7yMlN+m3UUieVfK6OwgC3JgRE6+V4FQedApHcGkRqrwG6T4SP8LjEu52vEZL3BWxXbZ+hrLNPsOYRknhwwz0Gj/I2Vycy3mo65CEmZhnR5WaOlpbchOAC1OE465ipWuOgmNZJ7vrMr6yrtJtEKLUMSKArQjFj5nCSoa3+Dv1IwVuwrEsiTzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KStDVsskOW8onVvRXiPtIot9uPqU6t47jTVfarOI0DU=;
 b=3nwNicgKcYTqrOBZ0pe5FjUSfxRy49qNN6wb48QHKD3G6xUsn1mDXwJeTMoKcpQp+BbHfwXaXn2pmkdzjEyBolks2PndMWM/L/ESSKAgb1zmBqAfPd6qFbNUv8+ksmDo0WyRRiWp7exYy+82qo9NJKV2Ey/818zQ65meoo1I6m4=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 03:21:57 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::b8) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Thu, 5 Sep 2024 03:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 03:21:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:21:55 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:21:53 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v13 0/8] spi-nor: Add parallel and stacked memories support
Date: Thu, 5 Sep 2024 08:51:38 +0530
Message-ID: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e79633-5f41-4576-190c-08dccd59e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9BECTaabLFRU3qwZfDWZwIL4pPWRKGu9L1rqk0IUKgSCDnxQgBUys1+XmF43?=
 =?us-ascii?Q?YkjQy/q5dlFbW8kFHUCXVU4FPo59hWPJeYfNrtSoilEcJDpfS/xxo2f7FnY/?=
 =?us-ascii?Q?TFWDWrPUfffrT28A48FlG/hiODd3thX44W0dV+BzFmWvkCV1l5bNqVKj7/7I?=
 =?us-ascii?Q?UghjDWrrP5udqbSHMk77kJJHXvQJUPhCfr5lNe9+Lv6UJKo/w5Iq2GqlYo5y?=
 =?us-ascii?Q?54jU1qKAI8/9HIWhY21aC2ZOwNeKiKjihDe3ykI0+JytWadbVUfFTwjVPXT/?=
 =?us-ascii?Q?uTRToMAs5z/4Q4twveF96IRpzpDgpnAWm2t598b7b5kPHEeFWx9A4qs0q5ht?=
 =?us-ascii?Q?sz5SV+2fbZ/P2iBllkWf4tdkh4aUhx1vn+SG3LGmoRWvmgWf7yZt4c2LY9yT?=
 =?us-ascii?Q?uqgR7AEKJ8zuTB3FuZr+6yCP7B07mUNuhDN9izPbTJeyMsXKaJfHjoOASVrq?=
 =?us-ascii?Q?SpKhtDuMe+qbnaj2yoKVwgnsBH8XrXiwCneqwDoWDmQj6WFncAWNBQFekVnW?=
 =?us-ascii?Q?yNq1lF/N3AxXGfqfjzwE3Iwr2YEBy/3B0+gJM6NWBohh/DP5oJkaBKOjFZpj?=
 =?us-ascii?Q?7D1zgG3F8+LjzgbvPeltZj73bZT0KvQPreRVh0Tz03zjVILo7vgROatTZ+PR?=
 =?us-ascii?Q?kg6bvGan1QsRMQuJLDaC+OIuEvtUa6XiNwuOCgCQ0DtjgfSbt+N5H3B2Lp4O?=
 =?us-ascii?Q?bNazv4zV1r7+ggFQbZ9wV44A+6iMaK5m7xE00VinBvGv4HuSjfWX/p/YERjF?=
 =?us-ascii?Q?BKCnKmaB531UkJ4c0TN7ZNAZeUYBwW97mmKDKeoSge2J0GiRy5t89H87wmrT?=
 =?us-ascii?Q?iMNo6JUqmHx1Do13BY3x4pP7IFhXdNq05apuew7xmdoatfjKVAcMzz4pEUl3?=
 =?us-ascii?Q?NDdrJdxzPnlrK12BSxxLzdUujAgo4zw0mAGwWGCghUctShSbGFuWtkfKnzwr?=
 =?us-ascii?Q?R4E77DgWq+sYO62dpdHOe14mVqvDdWy6KyCKRLVo7AD9v0tFVJYDtJK6oeVq?=
 =?us-ascii?Q?jDJ9WPATeJfy+oBT6U7DsLXsq5sIf3msYCEOAnq0nDebG1EQR3AVFdZX4pJI?=
 =?us-ascii?Q?Mta19h67gIGCWeEyX3THi6mefEQsdxo1GKoKyHZXSm4RzkaArBkx9wNw8sqw?=
 =?us-ascii?Q?LhlLD1KFYlxG8ua+e47X7FoA0jk+mkNMdcbNXNQbazgfAo2RPUYuM06DmP91?=
 =?us-ascii?Q?Cg7vHC/WUtDH2oAxhGPAgcOO41gJkNhGB0Jr+oqJlDUvt4HOfMEM+2jcF6uZ?=
 =?us-ascii?Q?q2oYaMo5I4KUI/Zeo9r/PITdu4uJPOj077hhoAI+RvzCdZJBlgzforWhTJ7g?=
 =?us-ascii?Q?WJUfPXxoWauP8jbD7MUHU1YiDD0bKeLiZ/5B1jGqsS2R6fo+w1w0huMxc3xn?=
 =?us-ascii?Q?dxvkMSF6kvLwI4LL8NtGiElx0yW2wWcMW8bv7ZmHdgRe/gC1hKShMVaiIt+3?=
 =?us-ascii?Q?22D4HHe+oF7IFtJ21UMg5IO/QsO1p2P1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:21:56.5611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e79633-5f41-4576-190c-08dccd59e593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
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

This series adds support for Xilinx qspi parallel and
stacked memeories.

In parallel mode, the current implementation assumes that a maximum
of two flashes are connected. The QSPI controller splits the data
evenly between both the flashes so, both the flashes that are connected
in parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->flags.

In stacked mode the current implementation assumes that a maximum of two
flashes are connected and both the flashes are of same make but can differ
in sizes. So, except the sizes all other flash parameters of both the flashes
are identical.

Spi-nor will pass on the appropriate flash select flag to low level driver,
and it will select pass all the data to that particular flash.

Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling the
address space each operation is performed at addr/2 flash offset, where addr
is the address specified by the user.

Similarly for read and erase operations it will read from both flashes, so
size and offset are divided by 2 and send to flash.

Changes in v2:
- Fixed the compilation issues.
Changes in v3:
- Fixed the CI issues.
Changes in v4:
- Removed the dio,dummy_bytes variables from zynq_qspi driver.
- Fix the compilation issue by including the DM_SPI config.
Changes in v5:
- Fixed the issue reported by buildman.
Changes in v6:
- Fixed the issues reported while running the sandbox test cases.
Changes in v7:
- Fixed the issues reported while running these da850evm_defconfig,
  imx28_xea_defconfig configs.
- Fixed the issue when DM_SPI config is disabled.
- Fixed the issue while running the sandbox_noinst_defconfig with spl
  ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
   jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
   jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
   ### ERROR ### Please RESET the board ### Changes in v8:
- Fixed the compilation issue with imx28_xea_defconfig.
- Fixed the SPL size issue with the axm and taurus defconfigs.
- Rebased the patches on top of next branch.
Changes in v9:
- Updated the commit log why SPL_FIT is being enabled.
Changes in v10:
- Added the new config SPI_ADVANCE to fix the issue while enabling imx28_xea_defconfig.
Changes in v11:
- Removed the unused variable, corrected the type of variable and replaced memcpy with memmove.
Changes in v12:
- Fixed the compilation issue with mx6sabresd defconfig, as the binary size got exceeded.
Changes in v13:
- Fixed the compilation issue for imx28 by making bisectable.
- Disable the config SPI_ADVANCE by default.
- Rearranged the patch series order.

Ashok Reddy Soma (2):
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar

Venkatesh Yadav Abbarapu (6):
  config: mx6sabresd: Default don't enable the flash lock
  mtd: spi-nor: Add parallel and stacked memories support
  spi: spi-uclass: Read chipselect and restrict capabilities
  config: xilinx: Enable the SPI_ADVANCE config option
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver

 configs/mx6sabresd_defconfig             |   1 +
 configs/xilinx_versal_net_virt_defconfig |   1 +
 configs/xilinx_versal_virt_defconfig     |   1 +
 configs/xilinx_zynq_virt_defconfig       |   1 +
 configs/xilinx_zynqmp_virt_defconfig     |   1 +
 drivers/mtd/spi/sandbox.c                |   2 +-
 drivers/mtd/spi/spi-nor-core.c           | 400 ++++++++++++++++++++---
 drivers/spi/Kconfig                      |   6 +
 drivers/spi/altera_spi.c                 |   4 +-
 drivers/spi/atcspi200_spi.c              |   2 +-
 drivers/spi/ath79_spi.c                  |   2 +-
 drivers/spi/atmel_spi.c                  |   6 +-
 drivers/spi/bcm63xx_hsspi.c              |  42 +--
 drivers/spi/bcm63xx_spi.c                |   6 +-
 drivers/spi/bcmbca_hsspi.c               |  34 +-
 drivers/spi/cf_spi.c                     |   6 +-
 drivers/spi/davinci_spi.c                |   8 +-
 drivers/spi/fsl_dspi.c                   |  18 +-
 drivers/spi/fsl_espi.c                   |   4 +-
 drivers/spi/fsl_qspi.c                   |   4 +-
 drivers/spi/gxp_spi.c                    |   2 +-
 drivers/spi/mpc8xx_spi.c                 |   4 +-
 drivers/spi/mpc8xxx_spi.c                |  10 +-
 drivers/spi/mscc_bb_spi.c                |   4 +-
 drivers/spi/mxc_spi.c                    |   6 +-
 drivers/spi/npcm_fiu_spi.c               |  14 +-
 drivers/spi/nxp_fspi.c                   |   2 +-
 drivers/spi/octeon_spi.c                 |   2 +-
 drivers/spi/omap3_spi.c                  |   4 +-
 drivers/spi/pic32_spi.c                  |   2 +-
 drivers/spi/rk_spi.c                     |   4 +-
 drivers/spi/rockchip_sfc.c               |   2 +-
 drivers/spi/spi-aspeed-smc.c             |  28 +-
 drivers/spi/spi-mxic.c                   |   6 +-
 drivers/spi/spi-qup.c                    |   4 +-
 drivers/spi/spi-sifive.c                 |   6 +-
 drivers/spi/spi-sn-f-ospi.c              |   2 +-
 drivers/spi/spi-sunxi.c                  |   6 +-
 drivers/spi/spi-synquacer.c              |   4 +-
 drivers/spi/spi-uclass.c                 |  34 +-
 drivers/spi/stm32_qspi.c                 |   2 +-
 drivers/spi/stm32_spi.c                  |   4 +-
 drivers/spi/ti_qspi.c                    |  14 +-
 drivers/spi/xilinx_spi.c                 |   6 +-
 drivers/spi/zynq_qspi.c                  | 121 ++++++-
 drivers/spi/zynq_spi.c                   |   6 +-
 drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
 include/linux/mtd/spi-nor.h              |  12 +
 include/spi.h                            |  23 +-
 lib/acpi/acpi_device.c                   |   2 +-
 50 files changed, 795 insertions(+), 231 deletions(-)

-- 
2.25.1

