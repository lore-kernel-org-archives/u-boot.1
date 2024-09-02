Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC1ACD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB3C887BB;
	Mon,  2 Sep 2024 12:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PY+sb1iR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D30885B9; Mon,  2 Sep 2024 12:27:25 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D915F886E5
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5zbDdoBluqD30Ud0LNjHB3LMP4e2N6vCl4xGQjmxjurpe6eqNcQUR1NJwnF0+0KaXopZxZzwgVz2mlAZAJvGyVirLluRxQn/uBgl2NUxr4+FLzjKmNy/ptKM3hqeJJe6q0PuwEY3/Eb89AG7clEnOqQRrhPXjFhJMCGQqlHBQsopZ6zsyMM2J0BveSBTDyDbEAVj7wsJAiKWIB026qHLZfgPl2Cp8DvYLmluYjggWlb+2Y41bAaCuxshKJ06qvwIkJoUJbikTdO1V66DHHV8HgClpqI3c2B/zhDE/Zxo2CVArJDM3R6FCwMCjiXvBOehxcpKkc0zniKMavyyCZnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYAbFhTJTOGt01E03OIo15A8ZYFT5kNTC8Q3asWT6d8=;
 b=HPeHVSGPvP5A5Ho4RxU7wYIycfjp42qlrbTTkvx5kAG8KO9QZ74EX0CH0qgnV+/ZbeEjaM22nkBBIko0Z0hRhHHkho57+JsEd/TlumBEautbl5c9tmsBbZzKjaQPtT8vm0znMT1/OusL8meB41I0ogIEYXeRs0FhDqrVGoWcsMefGn0xpVqZ01a0bL3GwNUB6VqzQDo/FmeQlnKgncUce8vZ8yevsfwsKYp6lKfSxo+PwuBP2UBt9tD5Y7pO06nAqpcgEsoCMImoJFjQPBBX/Lc6c291adTqbwG8zMGecofGc1vn+gnlNvx/0lioKUQG7i+f7ZrPkVM+b6CbGEnl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYAbFhTJTOGt01E03OIo15A8ZYFT5kNTC8Q3asWT6d8=;
 b=PY+sb1iRoXQumpOlZ0cF+7+GDfWe1a77KkHK2+EO0FC5SEg0MIm6StJDaR3SOE1EA9JvDDXTn9llOiMrSBfwfpFMRy0Ni4dVbFaZ5bNNGyrOJEg8s4hudU3QWOLOtvZtN8WEJCul6+BLqxMEqmg0t3oRYI5VDdFWjXtKInsM3JM=
Received: from DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Mon, 2 Sep 2024 10:27:16 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::c4) by DM6PR08CA0012.outlook.office365.com
 (2603:10b6:5:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:15 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:13 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v12 0/9] spi-nor: Add parallel and stacked memories support
Date: Mon, 2 Sep 2024 15:56:57 +0530
Message-ID: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ea0052-f6ec-4065-e82c-08dccb39d14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lTrja1zHEXoYSVx4CYAJCRlvLy3gOYYDDU7/JXYB0i7exzIddZSAGVDswoPJ?=
 =?us-ascii?Q?f7srGI+Tg+g2hBkNLaiZhIfdmK1yAniS9BKK349msJDpaCuQrAqM2GZaPxNZ?=
 =?us-ascii?Q?CGtNphWry8vzYgJVds6bV+3040Hn16kB6xG1kkIspu+xZEbsEuW678bCyKtC?=
 =?us-ascii?Q?sOLOpXmAHFXsRnd3doY1WmiuOCZhFCuvTnYUy1Cb+BA/KEGN4k2qlP9PE27F?=
 =?us-ascii?Q?S1o2pkhfjqeiy1IPbGJsezafYawdN55fzh1k27mEs+ej76tUqt8h7XmAHDd6?=
 =?us-ascii?Q?4BBU+kEP9QLyRHohWXJePCK2WsXJfCt1VcdQonWbb93tQkbOC13CcGBAEjFP?=
 =?us-ascii?Q?MFS/YxQfvs2j6Dab0RJlrZHC9tcAJOWeYbTUAJaxZTjaL+wZIhYNGEA+ac9d?=
 =?us-ascii?Q?kbSz1YPm2IDYFIaSyMD9+RWDBbgdNhNWoeMBQcn1L9E5VJqsQv83bzlVdSGd?=
 =?us-ascii?Q?qJ9LIL/yTHoBN/EoXjGN5aUw3U15i7hAdV412L0zYo6yz+BPZiTCs2Q80OkK?=
 =?us-ascii?Q?O14rgei5XlJW/jH7cgv9/QWHhXcvuwVtzUgUuBVD5kDUzHB49lUGVMbBKN7t?=
 =?us-ascii?Q?wqDa/vE8qibwVvDmNnMGfwMH5ER76lFI6aIqFVVSZA7cqqXfYkfZ+UAfL3iN?=
 =?us-ascii?Q?GwaSQJdI1cqfhMX2rBYAoGPK5k1MruUvVjDaKmwdaxdOrfysS+v6FkIX4Oin?=
 =?us-ascii?Q?5tfwuYS7LqTYm+n85cciXVtqtjoabyavOUXf81/RY53GtUnxe5ogT5I2XPfi?=
 =?us-ascii?Q?03LcjmX+Vuvy58dGegL7FL0GC8LNGnQU8qgO1LwOqVofQqEpva4mNh3CoSYy?=
 =?us-ascii?Q?IkF+kOFKcpiyWkU6/0U2ekbJL4sIrPlDHLe8K+UthbOSCMpTzYfezElob29y?=
 =?us-ascii?Q?A2cxUowg2f5ovhK/uofUwMllZ57WtBOTt8Yfmt00MIZprARLzyBonKHepD2I?=
 =?us-ascii?Q?5nhZ9UB6s2vOaLImoWMgufz4+6kCbkgkGD1BRx3FblX49q/rVXNZPQeAzqpw?=
 =?us-ascii?Q?7KHjf+GMUoqIpqGCsEoGCWECjYFC4r4/iqgmY6XdG+GebvIRQRUh2VIqv0Jn?=
 =?us-ascii?Q?nkEh2oWthQwLcmb+8u2iHfRKAXec/v2YJ4gZwvv7SwZ5xtn+v6KQe92yqvw0?=
 =?us-ascii?Q?nat89oYESBCONzEA2R7GaoBOafKuzsBPRuSILXIakmmWXqRHABVldCVkWqPC?=
 =?us-ascii?Q?W+EaY/gehGpHDXwWhq+39ZqnIYOgXzKqDigx0jHKOeQlhbTmvbNYnQlFsF9G?=
 =?us-ascii?Q?s8oo1DpTW2dojYEcp5q0L8W93NLTvjifzg58ObzciF3nPp1dTp2vZgmoSfI4?=
 =?us-ascii?Q?kfacQhEMa01GMos0PG+XcFGamcMl00hmK5Am5TIhOF0ONW8LIi2+//mrRb5U?=
 =?us-ascii?Q?wnB5Phy3w4hBhxYebzZDJigMAr4IWcWsfBVKnA+GuSsr96MBulXIoJn9VTy7?=
 =?us-ascii?Q?sdLM2FPxXAYT4vgv/bygbJbZAHa71ads?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:16.3661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ea0052-f6ec-4065-e82c-08dccb39d14b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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

Ashok Reddy Soma (2):
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar

Venkatesh Yadav Abbarapu (7):
  mtd: spi-nor: Add parallel and stacked memories support
  spi: spi-uclass: Read chipselect and restrict capabilities
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver
  spi: Add the spi advance options for non SPL
  config: xea: Enable the SPI_ADVANCE config option
  config: mx6sabresd: Default don't enable the flash lock

 configs/imx28_xea_defconfig    |   1 +
 configs/mx6sabresd_defconfig   |   1 +
 drivers/mtd/spi/sandbox.c      |   2 +-
 drivers/mtd/spi/spi-nor-core.c | 400 ++++++++++++++++++++++++++++-----
 drivers/spi/Kconfig            |   8 +
 drivers/spi/altera_spi.c       |   4 +-
 drivers/spi/atcspi200_spi.c    |   2 +-
 drivers/spi/ath79_spi.c        |   2 +-
 drivers/spi/atmel_spi.c        |   6 +-
 drivers/spi/bcm63xx_hsspi.c    |  42 ++--
 drivers/spi/bcm63xx_spi.c      |   6 +-
 drivers/spi/bcmbca_hsspi.c     |  34 +--
 drivers/spi/cf_spi.c           |   6 +-
 drivers/spi/davinci_spi.c      |   8 +-
 drivers/spi/fsl_dspi.c         |  18 +-
 drivers/spi/fsl_espi.c         |   4 +-
 drivers/spi/fsl_qspi.c         |   4 +-
 drivers/spi/gxp_spi.c          |   2 +-
 drivers/spi/mpc8xx_spi.c       |   4 +-
 drivers/spi/mpc8xxx_spi.c      |  10 +-
 drivers/spi/mscc_bb_spi.c      |   4 +-
 drivers/spi/mxc_spi.c          |   6 +-
 drivers/spi/npcm_fiu_spi.c     |  14 +-
 drivers/spi/nxp_fspi.c         |   2 +-
 drivers/spi/octeon_spi.c       |   2 +-
 drivers/spi/omap3_spi.c        |   4 +-
 drivers/spi/pic32_spi.c        |   2 +-
 drivers/spi/rk_spi.c           |   4 +-
 drivers/spi/rockchip_sfc.c     |   2 +-
 drivers/spi/spi-aspeed-smc.c   |  28 +--
 drivers/spi/spi-mxic.c         |   6 +-
 drivers/spi/spi-qup.c          |   4 +-
 drivers/spi/spi-sifive.c       |   6 +-
 drivers/spi/spi-sn-f-ospi.c    |   2 +-
 drivers/spi/spi-sunxi.c        |   6 +-
 drivers/spi/spi-synquacer.c    |   4 +-
 drivers/spi/spi-uclass.c       |  34 ++-
 drivers/spi/stm32_qspi.c       |   2 +-
 drivers/spi/stm32_spi.c        |   4 +-
 drivers/spi/ti_qspi.c          |  14 +-
 drivers/spi/xilinx_spi.c       |   6 +-
 drivers/spi/zynq_qspi.c        | 121 ++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
 include/linux/mtd/spi-nor.h    |  12 +
 include/spi.h                  |  23 +-
 lib/acpi/acpi_device.c         |   2 +-
 47 files changed, 794 insertions(+), 231 deletions(-)

-- 
2.17.1

