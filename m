Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F67CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0FB987209;
	Fri, 20 Oct 2023 05:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSUetkfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A849E871F0; Fri, 20 Oct 2023 05:18:52 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5507787033
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo7x1Od6EWBnDYcsuSHQRHDXkAaahAGtkbGGPpEnkODaciHtMScdETrPaKxS63v+dVXj4IGOFOyc7e78XK8BNiOTUI4AgdQvq9lZKtub7poIZByxuL6DNb3U7sScCFv6/9lsHYQCdS55EWg4TDeVibuyJxKeVKNIs6zWlQ3Fa9WnWvcBNikWVQcaxjdVQUlvhSchpitQWms5LUWBAaVoQaNe/9k9HAt+4gRaCsmDKRzntCPFlxxGQrZuNnrm0yH/hG8FtTHEKVqB6luWOwEaJYKYscx/FeV3XKpCXvYfWFH1QEOgWZsE8qp6MXFObVFFHnKu66QkrrpOutYBJKhrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPsQygwLwRHZjxm6yOKnzw/xGWqXLPY9SoB0OVQZcOU=;
 b=MQeMnOfFs+K952fmcYgT0c1ATBv1SdMt8LfWKhPKPUh22P8wFQzVTBs9z6WXah31pIRzCzSe1X4Pt3YX1x/WD6vWFmqi9ef7kPEnmliAFsLRjiWohKCuUawYc+4OWKMfigakDeiPkLzYsfYDAJD2DKhzMz4i46NWRxJ5QEgn97s5V9+Z0IMovbns56UqNJkzBDJW4wQQkidhmzYdTAqQalFMI70uo1q5ZjsOAsjHS8c/s5B2SBQkPk9TvXBpqsgnZT5BGMpfWOEiSB042XJ10YpyegxXZh+GtCJhL+abXdenXGcIZP09mBWNTfhHxUBhNXA0vCu/TenahoiXMa8sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPsQygwLwRHZjxm6yOKnzw/xGWqXLPY9SoB0OVQZcOU=;
 b=CSUetkfNYKrIg9hIXWn64ZS0mT8HM5Wl3efBA6ItUIEVckWuc8Rg6H+LVLPRfwitFe3UoHsqwiB4wN864FG11cDiHb8IW3BuSWIcVJdp/9Kmvh6rwj/dg6WlnxWL+LEBetGyDkvqWbfqn0FxTALUByfZ6UlRBjfm8aM4e5tEDVg=
Received: from CY5PR19CA0088.namprd19.prod.outlook.com (2603:10b6:930:83::7)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 20 Oct
 2023 03:18:46 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::69) by CY5PR19CA0088.outlook.office365.com
 (2603:10b6:930:83::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 03:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Fri, 20 Oct 2023 03:18:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:18:31 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 22:18:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>
Subject: [PATCH v3 0/6] spi-nor: Add parallel and stacked memories support
Date: Fri, 20 Oct 2023 08:48:11 +0530
Message-ID: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 17edad81-5f8c-4816-f3be-08dbd11b4515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKHFoVFBfdkFHvJwuKePN2UbTWkcWiWVpyV427crAlmnzdi0BpGXDl8SZKPuL2esoJk2mPRjiS3W6DB6LuFpQSxPxgUtLi+jm/T4bxVaSvgMv/jJjKWCInR4DFRemEhnKvhZJ/330R0pG0bSVxGx2hq2SQ+mFpIB1OwLn1mIu5z9UjKWt3J1Wizye0ATbU06SNdgm22JNPta4nGYLE4qskQ0d0+fcZKaMRvXrDLoUuKBb3f3KAwMLK+vS4aB/cTwuJ4Fez2Hla4GxVVKUL/grvQNgd4Pd/4UxW5poV2fTuVfOngj/HUCmCm141wlYI3en6sMZNiHqfO6z4JDTiQ48LT5JdMQ0piT0UeCDsW9EDj4JmUn1Qv9N0UTwJUEEOZyWXK8C4gdgpqpQqs6cWHMyDNaECK/cTS2xgFdHHlpo3UQdBu5MWmhj3j4qNmfi4BGJ/pk080AytzQjfxsGNEKM0zbaG/nDg99yFhbhadTml7iiLxCREghy3laih22YFcPYr91sgLm/iyCkTgh1+CBljwHYPpDhEfJZLUKA2882rOf0cm+ixtUOTsRWJGjPaAoeYhhiM/zENHY5X2fziIAD4UyA0w/8yyFBmIM1kcRUcaaKUEbFZFNFpj2a+N48gCQ9kdo8a+wKG8IDnlGBRzJLXye5cdVjdSEzMvpWL+6Hb5a7uyDhhsA1sCkPE2riZmi7Kb6//RZtGKkS0ZtqQo1xLGJfShoyTUTAgI6F+tJP7Of5hH5QFUDRzS1jSDzwFlAOj2tdkfi8lyn3rd58F8hkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(1076003)(26005)(2616005)(478600001)(47076005)(83380400001)(107886003)(86362001)(40480700001)(6666004)(40460700003)(8936002)(426003)(336012)(8676002)(4326008)(54906003)(70586007)(36756003)(70206006)(6916009)(316002)(2906002)(41300700001)(36860700001)(82740400003)(356005)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:18:45.5508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17edad81-5f8c-4816-f3be-08dbd11b4515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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
 drivers/mtd/spi/spi-nor-core.c | 385 ++++++++++++++++++++++++++++-----
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
 drivers/spi/spi-uclass.c       |  21 +-
 drivers/spi/stm32_qspi.c       |   2 +-
 drivers/spi/stm32_spi.c        |   4 +-
 drivers/spi/ti_qspi.c          |  14 +-
 drivers/spi/xilinx_spi.c       |   4 +-
 drivers/spi/zynq_qspi.c        | 146 +++++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 142 ++++++++++--
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  30 ++-
 lib/acpi/acpi_device.c         |   2 +-
 44 files changed, 789 insertions(+), 228 deletions(-)

-- 
2.25.1

