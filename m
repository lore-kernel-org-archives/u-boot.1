Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FE2CCFA17
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3DC88CFB;
	Thu, 26 Sep 2024 06:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuzKewIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9EC087BF4; Thu, 26 Sep 2024 06:55:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745BA88C71
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbqGW9eEBz5EwovHHaRGhD1lYB72kzE3CixQ3D1NlRxbFAjMj6QeqbvBF3vTKYBvDprAJHJK4xvWpdA29ExUQL54TL2WGo5V5+ZTMZFsvJbCAt4mMQg0Y3vo2Tr0PwW7MRMGc4BsjVsRx663nPtr7Al0sHCef5ZfrHqdtRubmYlCZ3slrN6F7Tc+6Q4vpnsgOd8t64ewwICsuFrH6CsBV6luhGJ3YhHKBFQ7oyuvbqz7ScAVf538nxqFx/L24MxG5f6lZqUcwaDxBpwo/6uymWzRnzo8jfcfSYU4g6ZFJu5OPqdgfj9O3qoOmLJ+nk7kRnpyuZFedVQCZWpAYLwyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7tgclXvHpA9CDRTCdDf+4+EbwKnRVwdZkRSYZekF04=;
 b=OiyycI1tnHK+42bV3s1B8oHIxH8rWkb9nomdzBNDiGmJcsBSqOOFFpkP1ckbXDlsj22aEU/VLthlXpYQkLvtxXNn93PjkWM4mmIN//cp5fc3GCcD4TwpwroWfTPey6do7yvhsn2tuuRQHQcFrs4/eXCqwvQ76I97zPCiAq3udXppSqvvU4llmLxMjsm3Rtv8XrOjMLK2aJ9mybiAxygMrPWSipktCoFpUZyheIMmi1bXeOonmJYCBvKjqbGIW1u3bCb/uix/L8416SVnvjelyw5Mu3kjWWcKkXq9wunIsHJ0XuzRaes08bXBmhTC4FydhAfyC5Tb1UkW50/CFq0AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7tgclXvHpA9CDRTCdDf+4+EbwKnRVwdZkRSYZekF04=;
 b=yuzKewIM3NrmZuIQapbP2/StuGp/z4gLC3XsuQnZaH2Q8sk0Z8IeUptCRwbvM8shQ+htFCmy4sMDfdcp8lrYrSl6IlUu/7b/mJDDVAwe+sHTvDu/iGrx2oqclJDOEYg/5kNw3i2yTMYpXvqYqPF3KoCtG5NFmZC8fAY89P0fW5U=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 04:55:19 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::4a) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:16 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:15 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v14 0/8] spi-nor: Add parallel and stacked memories support
Date: Thu, 26 Sep 2024 10:25:00 +0530
Message-ID: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: a43c01c2-e113-4720-2bc7-08dcdde76b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0XmRb24jQDLGpCoV9kETGYJeMY149GC6qBk2WhaxMpYHBUhUtGujtmYgcJz?=
 =?us-ascii?Q?k1qULRaCwqVbxy0a1l+o/WwPjyjH+S8k37RvBc9K7HnTGVzW0cqNiZhSDauM?=
 =?us-ascii?Q?o6p71OkbgByv0NjD11+ZMjUZCHXbcH0rUeQm0givq/4xMv/Oim/D4sK5xFtL?=
 =?us-ascii?Q?h3qo2Fc5fXiG+gvA4+sY4rDBrWWlvgbt/Y7B0Jt8HF5D24PuMtsQfGl9retH?=
 =?us-ascii?Q?v4GD75aNuZTdQWq/+3BaQl1aosPu6HH7sSBJpp8gI39nX5unV8KcZlDmIR2d?=
 =?us-ascii?Q?v+E4aIij9kV+pz5KfKToIREow8yz0bMSDuhGoty9W5DSD3LCUzpyUednltdi?=
 =?us-ascii?Q?+MdbIqXXVI60KTUoFbIubrIfl9KZDyq0pjR40/qXPQkGuzbCN8bbSDIoLRQO?=
 =?us-ascii?Q?BAX08c1RIIdfpEf0tiGBpaTCpixH9yyKFmOuEJumaRaciUMiG0wNqQj+w5/F?=
 =?us-ascii?Q?J4w9A6beuEiAsaUjBQeoDsFDoS2oZBWQH+bYWnZrxKruGf1TaD4241lFX263?=
 =?us-ascii?Q?dHrPTQxW5Ax7YAs55E19iOkcZGrsh/iQXSswzWjnCir+3SHnOaLjjYaWYP7s?=
 =?us-ascii?Q?oi8Wzdqa5eBC9fwpG4pONzNu/Hi74+eZlO7JHFfudlbsOvt9UgKv5YiSTR/O?=
 =?us-ascii?Q?lhZAdcA1mSCiKAsbNWWehrjQ7shKi5y+5soBxppM/7AP/lzd7tyYe71UwuWl?=
 =?us-ascii?Q?XIRG2b/FriyDc+2o0qw65GoXMN34h121WwBhjZw/wVjcKumXJD19Ii7EWAyq?=
 =?us-ascii?Q?6WLuzUVqhBxgeIRGexhpBiYkxk8CABEi5mfujp+POoQWHkZsrZBEdcXAZCvN?=
 =?us-ascii?Q?n5978MFPpOsIOUxVfPp2MzhbU4s1Co6+enfZJVQIYbMotz7PQ2pYhDRR6DhI?=
 =?us-ascii?Q?FVDuOwEd1QkCTfvsJUUDRbDRnR04OtnHNvldNvkEytD4BMAU+XcZ7/Dk6GvL?=
 =?us-ascii?Q?1u3ce64AHibIhBob8Wak6/gzWHhroafRcbaktMrbWUBhb2/Unj7KxadQAJSg?=
 =?us-ascii?Q?TS27hgkHg5MuJd+U7tn7TCgLQrtBjze9zHnS+gLJ8pQW03bTF4zkgb1LUrbg?=
 =?us-ascii?Q?Py4OvrGBOOE+PvTvP1VgeeibIx7ZTjqCYGAzqrYyuZ5nkBZOhgcMfNgD93WR?=
 =?us-ascii?Q?8vRUdqm2cVDHyiysLBJaCV6q1hlTalnIpiUdr2GdeA1feMqzpDZPK3s2xRtH?=
 =?us-ascii?Q?Kn9eQJUApARr5N988ImODZIS4utHyWUPFPrshC12WTYvz67XQd9IXJdOV0d7?=
 =?us-ascii?Q?lDD3BKPGZ+V9RQMKMC6vj+XWWyDuVZj9xZcDG9htufLT0sl2g6kilQ9soCS7?=
 =?us-ascii?Q?DILiScG7cEW7tJQMVUHDzB5HjItEN/8X61XtUynWo3Bmhnm/OGElfejiTvql?=
 =?us-ascii?Q?IF75UD9MnA1tX1JojHHgWec1obbPZvI4dgtfJaz6K39fQAolPPMDXQuzqIva?=
 =?us-ascii?Q?mHlWPl82dX8wkhKio0yov+JQirv1CuSW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:18.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43c01c2-e113-4720-2bc7-08dcdde76b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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
Changes in v14:
- Enable the parallel/stacked feature only when the SPI_ADVANCE
config is enabled.

Ashok Reddy Soma (2):
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar

Venkatesh Yadav Abbarapu (6):
  config: mx6sabresd: Default don't enable the flash lock
  mtd: spi-nor: Add parallel and stacked memories support
  spi: spi-uclass: Read chipselect and restrict capabilities
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver
  config: xilinx: Enable the SPI_ADVANCE config option

 configs/mx6sabresd_defconfig             |   1 +
 configs/xilinx_versal_net_virt_defconfig |   5 +-
 configs/xilinx_versal_virt_defconfig     |   5 +-
 configs/xilinx_zynq_virt_defconfig       |   7 +-
 configs/xilinx_zynqmp_virt_defconfig     |  14 +-
 drivers/mtd/spi/sandbox.c                |   2 +-
 drivers/mtd/spi/spi-nor-core.c           | 404 ++++++++++++++++++++---
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
 drivers/spi/spi-uclass.c                 |  30 +-
 drivers/spi/stm32_qspi.c                 |   2 +-
 drivers/spi/stm32_spi.c                  |   4 +-
 drivers/spi/ti_qspi.c                    |  14 +-
 drivers/spi/xilinx_spi.c                 |   6 +-
 drivers/spi/zynq_qspi.c                  | 121 ++++++-
 drivers/spi/zynq_spi.c                   |   6 +-
 drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
 include/linux/mtd/spi-nor.h              |  17 +
 include/spi.h                            |  23 +-
 lib/acpi/acpi_device.c                   |   2 +-
 50 files changed, 811 insertions(+), 247 deletions(-)

-- 
2.25.1

