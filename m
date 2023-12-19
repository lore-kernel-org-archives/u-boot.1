Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BF8C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 04:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEF08709C;
	Tue, 19 Dec 2023 05:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q+epJdem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0F287073; Tue, 19 Dec 2023 05:15:58 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB3686F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AETN8xqaFFOtJoWEz7sNrMfxWM7vnGc198fIuahzqHr4WA7E0FH8FwOaZTrscgUlkOsSbhOKt4skZuV2+O4TPmPDaIbgA4s53iIBmG9ZBszCKdolzsS/vmoUeth9/JWNGo7x5uskYOBenzdZOsIHKl6Zqt6DvQJJ4PjCO/RrTViyREMLNISUcZp4nUsj19qUmzbqHdt/LxdwMbpLwY8fb0SuVUinUSWHVMxOdZcBkjLuGr5mjFfTJbxCsrDxv4gA+gkWXhY5C3rsqgbtgZTjgxxRnjmJ66Gz0F/RNyLntFtI3MQjHfXjRGoyyfgJzyPRSBfv68p3dtQyziE80R7yEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJIqC4VTf6YuRVckix/69RntaS0i1SlfxSDHnPbNOOo=;
 b=iAWNJN+irdyetre39LuO+mmTfuVpAGatLeoW+n53MSWf01yiM4NmOdYWvNe//Fkj3uqltEJ0Il446Q4wZeElReRdlfq6GktvXMo5HEMVMNOAyRdClt3sxwQ/envzG1sNJo4g/sjPGaFy0RXXhn+IXBMZ03qicoZXz6JQGXpEVeD43tegIMpucPLw+lw89whKqeAOc3gW6k6gz6JkvNYym/PHicaS+0SmhU4PJGkE9wY/GnXlZeHYmGgqXAMlMDkiqGEnLFiJPHTIUI3tARKvNRT5vkPFs/ea+f7VpCWip1xIZqgr+wHt/qXlBKxCfQAZunsLoDC1vKEN8xnziQYTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJIqC4VTf6YuRVckix/69RntaS0i1SlfxSDHnPbNOOo=;
 b=Q+epJdemZqJBKpRdupFcRb2YHF402udtLDySlGlZGM5EOARXQlI8oU3cJkLLWjU8JWlNHq7Ey+ziPETSvQh+Y2VR57pcd++ZLh5EggC5uUZvv764YS/113XrrTZsJGBW6XbAyeF2QhkxboU5VIV68rkzrj3ll86W74jQbRibJn4=
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:15:52 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::ab) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 04:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 04:15:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:15:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:15:50 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 22:15:49 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v7 0/6] spi-nor: Add parallel and stacked memories support
Date: Tue, 19 Dec 2023 09:45:31 +0530
Message-ID: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bce6e9-9f2e-41e4-9703-08dc0049300f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEUYGqO+z7hVMopxwON9SSVSRvQ6WZp4Tq+5/S4ccN6g4df5iLrA9fuQ57fTn+ZMFSHPe9qSpdkILPs8CPz/dd7PIYutvDZEwctDsz3svc/4+ua1gBI9M30JCxZKp9JiZVg/5BJ0N8/ccf3b3hc+7Mq6AU8DSuE+QC7I1eGOIC4yS2xZ8qXBMTRC+1AsKi0OYs6PyArP2Y87NoNvur1baxkD9hnXq3s4x96ptOhEovcD+Dumyi7Du+IN3JCbPnF//GighsjHjFycXRFppaPinQWuxa5k4w2unFprYZhtb3OFlg5aquyG7LLuBrBtHgEF0YiSFXVMzqggJ2UmWSsaQhjkfeo/P1THwqqi3azQrzfAPgF0WsnCu3YZuvPQMyydO38MV9OqFRN8yK96PiUqHFm+ap9z1JvSpz2w6ogIejFCrhzOrIyWxjba5TsXECw8bSWohjHc6J6G6ypDql6J903WKu3tBmTedIuMeJmI+JwNG+pt86GYdh4YsXFDWEZLy0c2wpzzEBAQktJnLVC7KwzwGUhbokDLTUjJAFxnIZNtRaJ6Ol+9krvW0Jev7CvetkRbR1MomRi6GK6FcBE3I/bvcFvTCDoPy0ohjnxFHZ63TDNFmqGGMjWsq9uV0LiTWksxUbA73nfDBBowtXRQOjo1wp3Q8oEKoQa42a1oSOqwiKY48XPTMnds3r9k3Q84EPuN5ckiloAINDsJirLnVuvrvHh5kJhUssTZUMoY4WTkiArbYB3kyQKjWYF1hXr3sLVQgZTPEWRBAcXJeo/b7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(316002)(426003)(6916009)(336012)(2616005)(107886003)(6666004)(26005)(1076003)(2906002)(70206006)(4326008)(54906003)(70586007)(5660300002)(36860700001)(83380400001)(478600001)(86362001)(41300700001)(8676002)(8936002)(356005)(47076005)(81166007)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:15:51.7927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bce6e9-9f2e-41e4-9703-08dc0049300f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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

In parallel mode, the current implementation assumes that a maximum of two flashes are connected. The QSPI controller splits the data evenly between both the flashes so, both the flashes that are connected in parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->flags.

In stacked mode the current implementation assumes that a maximum of two flashes are connected and both the flashes are of same make but can differ in sizes. So, except the sizes all other flash parameters of both the flashes are identical.

Spi-nor will pass on the appropriate flash select flag to low level driver, and it will select pass all the data to that particular flash.

Write operation in parallel mode are performed in page size * 2 chunks as each write operation results in writing both the flashes. For doubling the address space each operation is performed at addr/2 flash offset, where addr is the address specified by the user.

Similarly for read and erase operations it will read from both flashes, so size and offset are divided by 2 and send to flash.

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

Ashok Reddy Soma (4):
  mtd: spi-nor: Add parallel and stacked memories support
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar
  spi: spi-uclass: Read chipselect and restrict capabilities

Venkatesh Yadav Abbarapu (2):
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver

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
 drivers/spi/xilinx_spi.c       |   4 +-
 drivers/spi/zynq_qspi.c        | 119 ++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
 include/linux/mtd/spi-nor.h    |  12 +
 include/spi.h                  |  23 +-
 lib/acpi/acpi_device.c         |   2 +-
 44 files changed, 781 insertions(+), 227 deletions(-)

-- 
2.25.1

