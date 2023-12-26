Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3CEC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CED878ED;
	Tue, 26 Dec 2023 14:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INj7BOEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2061A878D5; Tue, 26 Dec 2023 14:57:51 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E174878EE
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlQKDZhOktBzswQCxC0SPWoRwxCwgkK0BL/HjW1/DXQVgR0AJ0V5j8YX2bKm0vRN2mvUSDVfdaZmMp6UJvNpW/axWcYBBHTOyAlc5Zmc+M7Gn2BoHEqrMfMCuFo0diYH3Bk4/ehm/AFHqL1TsxZC6ZHe9eGwK2ZpCO3zcEuhrYhZGxRa232Ac/x9Mld+6xhuyNg8FA0AUFedB4jDYhbIJqjFFXUKeoPLZlTl7FNV8YDyINkKyKsMON4tNJyfkxD59/btTckTNJlZWQpqpZJ8T5OzRuOGAQKDDNM+69Y2odTrfTTYB0Ewm44kp6bJGSXQpKiJVS8CmonBHxBqDSZycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaVJkQ3s98T75v9eB+hFYHc0ljxNNTCb37RK7BYKJps=;
 b=BXuk8lh/t5bgrqg9DItTXTpC80W6wnqHCue7bj0smyZpLFt3SV0beDCIh7D5qfwsq24Kg1VAN1rEAI20j59Xcb0uCgta6KSBPgE7ZJti5M4AacGyeMwqQV/6Aak6D+C8nnz2z7Xe9tQyKVqK5AS1Y+WVA4rwM+NathHmzYrqrGKn0MgjLavtSQumYs2gaDZlX9ffqXB08PI5oJrQny+lt0p2HIRabxO6Dw++Slb49moT27s+J7RQtS0niJ+ffP5+B5sJ7x4aQWkqJRAKxp95rUE/YDtlK30A16WZTzzFBL4lGMcOlOIbxP8UDbH5qvWF58N30FIQDiZ5h7l63PzRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaVJkQ3s98T75v9eB+hFYHc0ljxNNTCb37RK7BYKJps=;
 b=INj7BOEq6TbM/1Wmn0/QqKR2CHwLBmh1MOxDMWsxXWyTccPslYyXXU7p7o3x0bGZxkaUIwoPxG+mexSQlLUwkX1GIgeJvLt+enF63dJbsQZDB/T2YjfUHhFCu62N/qQbbQuuUPblScISm/fNcqrSstJCipbUtvCtfxKegp2Iezc=
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 11:45:03 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 26 Dec 2023 11:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 11:45:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 26 Dec
 2023 05:45:02 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 26 Dec 2023 05:45:00 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <lukma@denx.de>, <git@xilinx.com>
Subject: [PATCH v9 0/8] spi-nor: Add parallel and stacked memories support
Date: Tue, 26 Dec 2023 17:14:45 +0530
Message-ID: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bb9585-f28f-437b-25d6-08dc0608191a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: og6/9EUVT3l4UNT8iplbz6GEMKRZUyw25qnJ5dMT9VDiMW5AMCUF1Qibu5Lg2B5E2sFfWsDd41xT3y0EOPS3GRFFwfW5/1hCVLKUFiJO0FCE3CJlrcmGFwqjqS5xqvd4Fcj0SljPVMDCbugC4SiU98JLIdnX+ia/ZLx7PwsCJjPTGyobd0N/mH2gvsd5YWms6OTriKStO96rSmGc88/o2iIH2E9cfzWBV8wum7e577dgo1Xj8wJtvoPe9EU1f9rPe0jNWW16zO/s2Je4u8Fhbvpb4w0vbv8V2BNp0Z8924suilRhnFg9Lk737mOjDWG6VD2D8RVppe9eUtuDyKUS22ZjK7vblnN4CEyrX25vxXlPgP0qxIc+mE94kqz/n9+Ak1U9LysNvQarmUkuXBPj8yoEmsCTE2VIMxeR25sGlIW9In44b/ZOc59gImcLK49fcadGuH4ojejHZToRJZUjOX+Vox+um89tcGDzq+P96Y1+bj2W9sNP2eb/EQq3luo6AD3B2DFMVEm49tsPFDCAggEJiWoDkMtqjyRt/XQUpFJ85ZTBvcV/jzks+Uw8N9PXT/oDt/edI4wN1Cwlhi083wceH+uG0ilwxuJIE7wszTgQqk6xd02d4UrGJuXkXTQ8ncaWTwmQjeq5DVMN+sw2FwR0zwdo+xzefyhF8kSMp4Pf6ITPBjolSVVRhFc92rYBxaeQvB8rC3NRegA3tXOdwvO6dFr068uvW1iD24ZUuM+rfQZC68avxoFJzKXNy6/LtjaPQPY3MwS62i6WowsmCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(36860700001)(83380400001)(47076005)(36756003)(81166007)(356005)(82740400003)(4326008)(8936002)(6916009)(70586007)(316002)(70206006)(54906003)(8676002)(2906002)(5660300002)(6666004)(2616005)(1076003)(426003)(336012)(26005)(107886003)(478600001)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 11:45:02.9635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bb9585-f28f-437b-25d6-08dc0608191a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

Ashok Reddy Soma (4):
  mtd: spi-nor: Add parallel and stacked memories support
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar
  spi: spi-uclass: Read chipselect and restrict capabilities

Venkatesh Yadav Abbarapu (4):
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver
  config: xea: Enable the SPL_FIT config option
  axm/taurus: Disable the SPL_SPI config

 board/siemens/taurus/taurus.c  |   4 +-
 configs/axm_defconfig          |   7 +-
 configs/imx28_xea_defconfig    |   2 +-
 configs/taurus_defconfig       |   7 +-
 drivers/mtd/spi/sandbox.c      |   2 +-
 drivers/mtd/spi/spi-nor-core.c | 398 ++++++++++++++++++++++++++++-----
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
 drivers/spi/spi-uclass.c       |  33 ++-
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
 48 files changed, 790 insertions(+), 240 deletions(-)

-- 
2.25.1

