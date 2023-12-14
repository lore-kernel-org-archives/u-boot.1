Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731CBC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 05:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB1B879F0;
	Thu, 14 Dec 2023 06:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2aB5xgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFD3879E2; Thu, 14 Dec 2023 06:23:59 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8E9879A1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmF78mqxeOCinwdIolWR4zb9ry6t+T6sZV4arzvkEO+Dhfwwg98nmscaSDYerFskXz+Zx2PrUWY9+Lcq7yZ+Ldk6U1nXKJj5hnEZCJXfcCRMtH2ZhcV87sPshdAVKQ7aIPM6XC0+JcLNcKfxNE5FVShNI1f7F24qjrhBXStC7k/nW0Z8psqekUTYQMrwV4MMiM3LjmeG4t9IrSfQFu4Ec6QZEFoFVLpf6SlvXK2gsZds2mQ1UGBGvRLJXSHb5prSbc22iFkN/lfrirOFFFZIaUlLNX5rfVk+3myNLO8I3uSXaD7EY5wySl51kX89zobeG5TMq38E8WLk5nvWpvp+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP9GePWSXqGDQKtvrtRE8hPGd/uUZUKR4AqAU7qa3k8=;
 b=HkqZhchd4ZObjLs3diHGRdsfu+agqmSIcyeIhwFk3+sMOPP5yynITKWWRALyqaXQ7GJR2bgArPGp/d114yaQOsTUBmqKuAryioUZ3uQaVN0WpBaOzB4stXrpRYaomeB7w0onZ2efrvQWB8K3W07PDYFOdsEg8MpXBgT4YVmSo80Z8oK7fWtxJMK3TGDYN/FnUTHxxavc0eViAx6thvgqOL/GyYhvNwAMGwFa3rZRPx2QwN1z895LL0sNKlieQgBQTSLen14xqNs2Hep9liVxD3suSfUfOF6P4He3lmGHgYbgFDkP1z431GftWcjXYNdPnNsXpp+gJD/45UV0laOPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP9GePWSXqGDQKtvrtRE8hPGd/uUZUKR4AqAU7qa3k8=;
 b=Q2aB5xgHGK4eGREpMQJaQNhAw2rxcxdLlqLohlIAdrp1q52D8xAb7j1E2owAP9vnGbDK+AYazD9NYEZay3gCT/10mrsRU4u0vOxDfzdlh2cpZdGr+hMYUsosRpUKk+z+CXUv0uvk4aOWi4U0BPuNCr5fzqB82kp+FpV2FJIjfX8=
Received: from SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 05:23:53 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::a2) by SN6PR16CA0039.outlook.office365.com
 (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 05:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:23:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:23:52 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:23:51 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v6 0/6] spi-nor: Add parallel and stacked memories support
Date: Thu, 14 Dec 2023 10:53:33 +0530
Message-ID: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: e0653f43-bc1b-4b48-e229-08dbfc64dcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sg0q9rvmFoeY7BP1TMmcJpZa18tHnPb2qYk4j/dnqiXSxywTRjHRhkibqc4Nl0lhKtyDkfxSd5VdP9ePtUzRklO96Qe2kLr/uYrMxWWCmTHjbhfTdC7KrP89ABHmbJJmZTDZWNfDObJCn7vdVxKOBLCh80b9kip6ft+Lzp8gmBPWDzXiAUTt+XiX0LKl+TV43rdHRCLHlFKJDbpcFrsTfqLswDjNX1Z0nu5fnMk6KupsGxRzhjH2YtzTvF6tT5xnjfVvJOLGP1FsK1r64ulggYIKnidX3KzSFgYybHNVEvjAbxrJ4MAkts9/q6JAo2x//IcZ40ctb606LrlcEG0HIXwA0t553Bkqzl9py342eixp+fiurlGLKV4wTU0ZNpAYZIpxAmIO4vyIz25E4BQ3zK9rxZH9V4J4hPc2Bp2e/dhCznTpN4y3qf9bautnijqxOd0jQAzWnD09M5y8o8AIagYvhyYE2+rPyoiYUEVEDdiCLN6ZPOpWBZDFATao3crWScmzMu6l9k5I/n+u9fUagV3BmcwEQm4fRlBqwrUpNrZ0YjnHjT8N9h5gklFSE3OnE/oYYF/v3lunffioZk2gMViRShEhUZiSkXc0SaTbwK4ZG6cxpzmnCvEn1qoa+LJVM9rQPp9cpZbjX94O4d69L0L8XvAnP6okqn5zLKJJgYNQquaL1PprisIYQj1Pbms6L5A6b8gZt+GVVhHCqhfvFqyG2zwq3vQOASvIxYls+fx+uT/56cIRu4qq330fOmkU0RjT5JuF7umXBvBFDAfZ8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(26005)(1076003)(2616005)(107886003)(336012)(426003)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(41300700001)(4326008)(2906002)(478600001)(8676002)(8936002)(70206006)(70586007)(316002)(6916009)(54906003)(82740400003)(36756003)(86362001)(81166007)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:23:53.4365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0653f43-bc1b-4b48-e229-08dbfc64dcd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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
flashes are connected and both the flashes are of same make but can differ
in sizes. So, except the sizes all other flash parameters of both the flashes
are identical.

Spi-nor will pass on the appropriate flash select flag to low level driver,
and it will select pass all the data to that particular flash.

Write operation in parallel mode are performed in page size * 2 chunks as each
write operation results in writing both the flashes. For doubling the address
space each operation is performed at addr/2 flash offset, where addr is the
address specified by the user.

Similarly for read and erase operations it will read from both flashes, so size
and offset are divided by 2 and send to flash.

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
 drivers/mtd/spi/spi-nor-core.c | 401 +++++++++++++++++++++++++++++----
 drivers/spi/altera_spi.c       |   4 +-
 drivers/spi/atcspi200_spi.c    |   2 +-
 drivers/spi/ath79_spi.c        |   2 +-
 drivers/spi/atmel_spi.c        |   6 +-
 drivers/spi/bcm63xx_hsspi.c    |  42 ++--
 drivers/spi/bcm63xx_spi.c      |   6 +-
 drivers/spi/bcmbca_hsspi.c     |  34 +--
 drivers/spi/cf_spi.c           |   6 +-
 drivers/spi/davinci_spi.c      |   6 +-
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
 drivers/spi/spi-uclass.c       |  23 +-
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
 44 files changed, 773 insertions(+), 226 deletions(-)

-- 
2.25.1

