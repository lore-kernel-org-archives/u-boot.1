Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B130CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 04:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855DF87165;
	Tue, 14 Nov 2023 05:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uid3sNOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38B48710C; Tue, 14 Nov 2023 05:57:04 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D508710C
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU/HkN5fkltzVGkf7z9aK9bcKgyBtbfADm8DfWnfbe2YAd6IY2mM1g0aljtArl+XErrBBQ3Xt7+FcyUfvDsOBA2AOglQS2Mr1qBcQeROQMAG+bmOrHps6AV5d+zxpcRQPzpJwX+JZE4Epr+UB3zH/e6d515Ar1JpsfAXNaULIKM274g+kTmDtu+DOIrQ5TlPoa2APmxeDdf86XzzoPHqzB22JlKjmVAujkr2rfuCzK9iZkxeoIssSd/I4VXlo1xdlswLZpRDfs9nNRTQFoJGN6Uk7chLGX8K6ELAtQ52dGqo9Ct8QtvpNzcqtSt6EmaORpl1wt3NnWvxDSIR4Ln9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJMEegReaXzdbxYUATEXoqaLjfG1SOEb2NYPiq5CAws=;
 b=M8R1xt/lGRzbMtKIYVVZo2O9YHI/wokIwNhYz2L1r2Gz0roWUIIrkKHSZ9/k8VL5BYzZdwwStfdGDuirTB7RCcHjVUDflpXBG6FhZOkVe8Xm0zFTi7Q9PlCewKtk2AQEjbYcbTi70TgFKC8+x8G68gYrLQDqDj0p5h+3qP8mSO9YauVQ7lp/8e2ktZand5l+pyoOU2ZoDBdNA2ZsNU9notha6eJxzgBfoqrBkC1sfcf5oI6eWmBq7eVvWJVvq1PXlcbS/LxdG48Mc8EltcVWuFYa1wJqHmhWLEWRvQwklYJ0rXQonRa9e6zurh5U+COeHaM7ov74GG8mp2YnrD+ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJMEegReaXzdbxYUATEXoqaLjfG1SOEb2NYPiq5CAws=;
 b=Uid3sNOWX4CejLYvJF7ODlFdpbJE+NWCRU3SJv8iRWunlT+KrHC/gWi9/ECWeRkDcQ0ZQTl+TPan3h7whW76us7UI06LFSNzHo027AwQuvYgWQYP6taKoN0ZqcdLUtqm+0OzW32rAhY9nGTxcxFvNqGP4XKcyrs9ETYWWSE6VPs=
Received: from CY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:930:1e::35)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 04:56:56 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com (2603:10b6:930:1e::4)
 by CY5PR04CA0009.outlook.office365.com (2603:10b6:930:1e::35) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31 via Frontend Transport; Tue, 14 Nov 2023 04:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 04:56:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:56:46 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Mon, 13 Nov 2023 22:56:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v4 0/6] spi-nor: Add parallel and stacked memories support
Date: Tue, 14 Nov 2023 10:26:32 +0530
Message-ID: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM6PR12MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: b73f54a5-d98a-439f-4d24-08dbe4ce2049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sztLgjKAnsQ50Fs6l3TgwmnnpGskuLz3Sm/rl6e9+A66DhNOp+O58vP52PkMLZjWt3xe1FaQdkfc+kbq6uW65/llDtafb6r3iieDAb79IyBPYOAV4CUCwNXwUIrqUTMTjZV7Packp0rchuztpbbQ6ai2g1QI1s8HpyAUOwEG5Wa3aTXJnCS2ooBZUwcZ2XfqJbQAxRhHrsN062K/+HI36ZkXbWSttTpTsC3DgDtKORFiw1XZwLLy76+8Vbk5P0ZnUzBzij7hSap3twPFoDEGlhk2PR+beQzXVBpRyQ9FLsXPuJtZl0QLvPm5ki3hT5PDBxEVcL2njmJN2Ektfv0vNCP1Yj4668GJP8JgMPSYI872lP7QQabChIC3yUsVDk4lsE+gB4DDtQVd/Gie8v3OKXwKjbMIjQwwsBY/gQdOJEkPD/Cay0kd7sSmztJI+eyr5gxrIy4kqFRSwBG2BshYTgCJji0/5aP00Ftgbs4t5Nf+WhJcKJJH7uIPNPhUcTAdZwJO1d1B4oOJXlD41v3T/zkeN8kdmShkuKpSM6hNXDKD+ZuYT8eQvbfuUWPnWkW0zffSWx95380JW2VBwgEwRWnx6EElAjVypxx3MkgQ/N+qu8LP9tkxPzo9Gd7Dk4r3FDKEYnAo8giC3qSItqCLbQnzrwGRbHPPwQd4/wKcazgcXauHkLqqy5rezIhQ6AeJMkbGSuTgKlRUIsDwXEbbArHeSP1+QUOTIScmr8x9KkANbW/g+iISaG029NhvRKRd/wSd7Ds29tUkVGobrDXz0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(26005)(40460700003)(70586007)(70206006)(6916009)(356005)(81166007)(107886003)(54906003)(82740400003)(86362001)(36756003)(8676002)(83380400001)(426003)(336012)(36860700001)(6666004)(47076005)(2906002)(478600001)(316002)(5660300002)(4326008)(1076003)(2616005)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 04:56:55.8034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f54a5-d98a-439f-4d24-08dbe4ce2049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
- Fix the compilation issue by including the DM_SERIAL config.

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
 drivers/mtd/spi/spi-nor-core.c | 389 ++++++++++++++++++++++++++++-----
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
 drivers/spi/zynq_qspi.c        | 120 ++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 140 ++++++++++--
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  26 ++-
 lib/acpi/acpi_device.c         |   2 +-
 44 files changed, 765 insertions(+), 226 deletions(-)

-- 
2.17.1

