Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA03DC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 03:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9CC8769C;
	Fri,  1 Dec 2023 04:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyN+tj/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18084876C1; Fri,  1 Dec 2023 04:18:56 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F7A87684
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 04:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htCLD0DyMVyoPO9GZ+LuwTQue6KIDcXGu5JDGmHxdfBXJhDqzT4ZqufokMh7niqx55FZvMUmV8rXXJD88b5ieyYymtkni1ItSYOU/wzCGROE7E+pdVvm85LJ51CkhGATFXB+6XRmPQIZPMuBNalE7Sv/oVYzrQ82sJ+NoYtqMRkOgraRORZT2hRLPVb7uDEyXMluTExNpRAEqVDR1VLWxr5hvM7Y6xC3bdNutSbOP3jwb6MYBWm3O8KuGy7hEG10D8bGVwz2yRwhJtllIfGTYzkwfz2iuuBer461+fxk5euvCCpaKiWS39eHTrPewwA+sLK46HpqCfFrBTczAFLGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaBvjWscMQHhfaZIvb6/Eeq3BWLMiMVxNOfNRKCRJ40=;
 b=Pk5DSzMlfAuREJyAxm9imSLAPwUyMbNX00Wa65wXEWGAXyFR48kSsHoqTl4JiBwPScjHGRvyPInx12oFqLqN22XRfUqXDlC648+9Cyo76kyqw//wHn/LPBeF0tOisFeh9KH0xABuS1XNpEDl3wgOBOFRibdhuhSK9E8czdJTXZZL4Wxm2Y2pLZqY7hnW32+O0bNJ6BU7k8Reab+9dGe7WRfrhGycifirQObmDVqAdR4FbOIVVqXuC3qSeRrelD9xY7kPRTIu4+b+4BrzOtbzgeA8qF2roLmO/HAIJ+p+qYBHA3fGe8C+C/HzKi4QJWnvn8n/D1NX1rXQ8SuZvkfk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaBvjWscMQHhfaZIvb6/Eeq3BWLMiMVxNOfNRKCRJ40=;
 b=LyN+tj/rb02TS48l/d9kt8PfSIqilMKKBuL76yKLAEbT/DzB85vJevkcaaBEv+cXjsddWVe7dEiKzrt9z3KRTSH9wcvzCvBD9wJxXbPFxkOmzz6b/FNuLaMwkOClVa30QdtCzOa63A76vF5xVe2mNP2PmCAvY5XJzBW+JdeQR4g=
Received: from SN7PR04CA0177.namprd04.prod.outlook.com (2603:10b6:806:125::32)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 03:18:49 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::27) by SN7PR04CA0177.outlook.office365.com
 (2603:10b6:806:125::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 03:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 03:18:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 21:18:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 21:18:47 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 21:18:46 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v5 0/6] spi-nor: Add parallel and stacked memories support
Date: Fri, 1 Dec 2023 08:48:33 +0530
Message-ID: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1e1335-fc18-4c8d-b342-08dbf21c3c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+/oeffP7+yNFEmbpNW3dic3jvlAxFoFSWacNDQYj/Cio0Sw2TUYeI1oSi7KnLA2J4R1Hon7MWgdvAxXduxgkYkxIO3IvvR3AwVcPMk1pHaBoQsuNHXfZZMbFNE1qNE+FPphNCNCBLLR1awUSTOQu/p9OourQwyOeF6hfdwdUw7rNKpT5MOUi9pY+sya/LPKd8DLDWAKh22imN9zrg5cfNiJ+H7EfNjKroxo8ptLZ5iG/2pMk8OAGjxHuQ8wnpZUbrUtUqiiQoeB4HApr7TG43e/e7c63Hf/atKctB/idXVRSNwMdZU4DAFiEYsfnsnS3j11ey35Ac9CmbbeCpAgaMW1SqSS/nwQ7qXwaXpp5o+vDqTYKGiaRL/7RguQrYFskxMlUecUdVA/OsiHp1lcYNm54s5ZC9EkVqjVyZ8g6yzkEMwCbt6/z86Ek9Sp9dlp4CWHEDAGpLpLxBjne/3Yxq6NF0Qljih2DT89+YJB3i4NQzGuX5SfCqEsAqmnIStsLk2bhm1cGnQlDABLTzJ1hg0PXJUGcqAuuV8S7uYNJVi85tgj/ToxGU+99jcXZgp4yl+FO9+1gT5MLM/mT3bPZ/TBmG7oAHriGnsci9q7Wc1LE9dTT5kDvK0pGWlxbFk/lC65scm7iXdN0oK6aAQLH8JW+pbd4C9P1rHs5+MVdzD93en0AErr3/hWl+xeTazlfzBT50JpSFd8HGkgCho53LfOPOq+1J1fpu9oCjxE7xDuiKaFwq/iwF7UkKYh33mYfuFNGLhmXOxt1JJIbyBqgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(26005)(40480700001)(40460700003)(36860700001)(81166007)(356005)(82740400003)(47076005)(2906002)(5660300002)(336012)(6666004)(83380400001)(426003)(1076003)(2616005)(107886003)(70206006)(86362001)(41300700001)(70586007)(478600001)(36756003)(4326008)(6916009)(54906003)(8676002)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:18:48.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e1335-fc18-4c8d-b342-08dbf21c3c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
Changes in v5:
- Fixed the issue reported by buildman.


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
 drivers/mtd/spi/spi-nor-core.c | 390 ++++++++++++++++++++++++++++-----
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
 drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  24 +-
 lib/acpi/acpi_device.c         |   2 +-
 44 files changed, 765 insertions(+), 226 deletions(-)

-- 
2.25.1

