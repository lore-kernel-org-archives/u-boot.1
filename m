Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542D1C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB85287751;
	Tue, 30 Jan 2024 05:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XO67mJAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9303787CAF; Tue, 30 Jan 2024 05:44:55 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F8F8772A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1jDiPmst+6xgUgPjl8mFQIt4wIqr28wGk9avyScqp7Nu5lIMHho7RvjNKlfrn5NEh2818EHhI74LcxMH9gdQ5KqxyKKxTtjmE+0CrT1alyF8QAugmQCHUA3IKhtTUp19FYdbp/BeCXdVwucNquerd1FCVwDwbqLqr2K/gCd2AIL88XinUsxBuTueYchyI8mXlzoXVIKhA/ItDVEzMidlsqbanNAUz9i6IeXqMjP5ihYmhjGaMykJP+7pxeCLnam/emN85ScZwiM90FnWvM4z8nC9fTYFvquORx/Z49CoxRB9pFRC1GCDGJMk7Vyjc0ziSen8z5mL6meejcHp4umkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84vAzrvpol1Ri7sWGcSDj/7DzCWSrs5Z3IouieD+XK8=;
 b=A8I0wMPN3Xv9sLLISJiOQ291WF8kD3QB33nvsrRWN3qe2g/zpJHbySqNanKRFZHMmEQamXW49jWeHr6FyUXtTNG763FNDwl+zZkRNlmSz00Wne4eXT3fPd7OvkZsQa5QI/fssbTm+CR89HnoGEMuCTE8h2J4hsRTza8sWRRPBYYspYGKlMTKeRY/72qyKcdeKpyMJXXEefRA3Pv6FQE64Pm3Pp9dTTb5+BjL8gMQqakCwDn8mZWwURKUylPBRACse+prN1v8Cr/heurRFfBBfnT3V8TEOOIA91vPX4X4bOiFYGOIsUGg4F5xiJ/ndnETVMA92N198/R99xg9PxLvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84vAzrvpol1Ri7sWGcSDj/7DzCWSrs5Z3IouieD+XK8=;
 b=XO67mJADrMxb9GYWI0rCAVHkRZ3Vx6197wRpOZ8Zyx0kwoZsqmL5w+ywz75IOEzNVyfSPnBhKE1ePzdH4BO9n0+529Pk6uRI12qNu9P0EQu2e0JxJxJoK+I3kRRT3LeSrQ5w4N0VHHpfvoqXID8AoX6F1wM6hzDfsWR4zFocOno=
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 04:44:48 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::ba) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:44:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:44:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:44:36 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:44:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v10 0/8] spi-nor: Add parallel and stacked memories support
Date: Tue, 30 Jan 2024 10:14:15 +0530
Message-ID: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b1840c-96ad-4f7c-747f-08dc214e30a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAD4QNASbn5kBsb8GH/wRB/cnfWobqpq2udjsNpeS51wJRvy8ArReMc9gTZdf5l3fsDNT7txSwZUklvdinERV7p8pgok1zruI7/hd/TvrP/WWrUZuW8YEmYlCfkIuxGY5rHNQWxf7gcNKBBL4cb62/v5WbXOXjBRoAHDb2iR3+udXCQETvYnt5RXVoZ5IieiiBU+GTOyEYmWHBAB0nufFckKOXnyjA9HLHoRqSqz2uwSNU3BXUFRpdEzmSqt3p4BR8Q2DwBfLattxu4Udev/n9eYcx/GsUDRHHe/k3tPVjYEsqXAP1TPwderY5PFHaEf/O3L2kurBZbjwObtcj3RlyNM+zGfRZU1ERf18dmxQ/6Z7IgcaPq0B2OrYXps3UcjEI7ZqUEn7DVyEsue80Vt/Ig5/awZWUdtk0mqONoBkl2LFxoXZHoF9UbVY/miFIjGlVqiVCxXGjBP6nd7jkyCJeRSzk3Aip3b0Uly35VS4tx1T8rSIKKH+LpOh2c6GlF8W3f1wRI7nkL3BGuV06ObbDlr6XAt5lqx8WEcfygQ5YfnOwbXmkamaQqR5YB9mGW8j6EhUwHfcXZ7nuUOAsh9yiCYnFGuWilQ67gQj9SZAhcC4TztEVQbcg81UXznMyL3AxGxJEgctxCX4wyjVzsbcXg5SncGnzaInw56bCSxljQ7WyuwsKgizdvqZIiRowFgkGIyih/sOMD+XJgmWjgBkMriEdqJpIXkImEVS50wcnb4L8ociHL7RpyU6eK+PuGbbEAdQp37Pjs5dqtKCTBdSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(426003)(1076003)(6666004)(336012)(36860700001)(478600001)(316002)(47076005)(107886003)(8936002)(81166007)(8676002)(5660300002)(4326008)(41300700001)(2616005)(70586007)(2906002)(6916009)(54906003)(70206006)(82740400003)(36756003)(86362001)(356005)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:44:48.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b1840c-96ad-4f7c-747f-08dc214e30a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
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

This series adds support for Xilinx qspi parallel and stacked memeories.

In parallel mode, the current implementation assumes that a maximum of
two flashes are connected. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->flags.

In stacked mode the current implementation assumes that a maximum of two
flashes are connected and both the flashes are of same make but can
differ in sizes. So, except the sizes all other flash parameters of both
the flashes are identical.

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
   ### ERROR ### Please RESET the board ###
Changes in v8:
- Fixed the compilation issue with imx28_xea_defconfig.
- Fixed the SPL size issue with the axm and taurus defconfigs.
- Rebased the patches on top of next branch.
Changes in v9:
- Updated the commit log why SPL_FIT is being enabled.
Changes in v10:
- Added the new config SPI_ADVANCE to fix the issue while enabling
imx28_xea_defconfig.

Ashok Reddy Soma (4):
  mtd: spi-nor: Add parallel and stacked memories support
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar
  spi: spi-uclass: Read chipselect and restrict capabilities

Venkatesh Yadav Abbarapu (4):
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver
  spi: Add the spi advance options for non SPL
  config: xea: Enable the SPI_ADVANCE config option

 configs/imx28_xea_defconfig    |   1 +
 drivers/mtd/spi/sandbox.c      |   2 +-
 drivers/mtd/spi/spi-nor-core.c | 398 ++++++++++++++++++++++++++++-----
 drivers/spi/Kconfig            |   7 +
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
 drivers/spi/zynq_qspi.c        | 119 ++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
 include/linux/mtd/spi-nor.h    |  12 +
 include/spi.h                  |  23 +-
 lib/acpi/acpi_device.c         |   2 +-
 46 files changed, 791 insertions(+), 228 deletions(-)

-- 
2.25.1

