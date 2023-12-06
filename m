Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33961C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D3E87227;
	Wed,  6 Dec 2023 10:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4R0+I1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE4A8721A; Wed,  6 Dec 2023 10:32:08 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E2686D85
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4r/3doF/7d63MQDQMpdh7oufF8VSOxpVAUGP4NpN/4xydSwQca3NAxhK4OBBlCtleE7VeUflmy6mlGrVh5+csMvVGsjfu5jNkeO9ok0Wv8TX6u12UkY2xXCPzX2bjj9yKprpCdCh/IORgM47lc7JDC3lZ/KlanLpMfa1c1DpFpYafe3IpH2yaMfDSNstmKjijyGWUT6MV7eg400pmnhqz7ZPunXgB/l0ktBHz+JZB55Pf18rOo1D8dsp9rfSa5w9IRK7rWEFiomDASKBIwJ773LhsEjQutM9Plty53ev+dn254o+501UZmIDjW4PQGycUDDb/YhS6AcN1LZ3Y0XDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/2dmwCZFUv4QagN37DZ7MSIqLVS9hF2t4DepV7ZXB0=;
 b=hQeTPrZI5DnPMbowT8SX25KRGdpSlFcSL5EG2/bahop9cazQnkx1nXWb9FGN4jHCsLOBGkggucfHQgGOpkicI4kymb623zNnrMntt5rGixxh10Jr/B9AgQ3EOKP6KOdh37PHhTAl4iDrISusUjq/SSEPLXytLY9Tkps/RX5/BszlAn76tIHwDBAh23rOx16uAOQVMS1mzjUCyRIspLqDJ0HGrizih40HxC5221a8eTneoAJ6C6rm0PKGZMWekfXTeiq1T7Owxf6K3tCCFmNwltNheHVo7w2wUsmi/s5W9l2RveXNM71NitUah0YulcIuQSHpRP7oxYn0STww0phOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/2dmwCZFUv4QagN37DZ7MSIqLVS9hF2t4DepV7ZXB0=;
 b=V4R0+I1CPTxAHG6w5tlajSR3kg+idNzQV5bmhiNrtEnLKz8KWjgLMybsYarI18feANY/UfuJ/Cl8iuYxcOnuTbez3CIog35aAZs0i3KYOF9wIvM9rbB9DVTxdws1NBVop1r649Ku7p1/cmMzapF/FwE0fcARU/Q+f39ZMNDacBk=
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:31:58 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::2c) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:31:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:31:55 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:31:53 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH v2 00/30] Fix issues with QSPI and OSPI compare failures
Date: Wed, 6 Dec 2023 15:01:11 +0530
Message-ID: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 381c2856-59a7-4db3-08dc-08dbf63e314e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGTbmSlRJrSO2jo4IWQfjS0PmzECQeKDD4lRlFPoFkRNtsaZgft+Ww4RsKrjStmnoNPy5A/qnkIJhPerImlLdaCytw5qT0NqkuWVcZBI2+UgvTD7VOBxfmrWDpY8ZdR+WDmc0qz4r+0U4k6rM7FeEMWDJcYvs1gLNmgJWapz1nAH6GN+uEJkvXD+xyQ0nhfmoTJMplmfDYjoWbVxqMcjwDZ3F2cVNUK2A7BRuH1vmZM68FFVR+oxJMe5GO58jdEX0M1kS0tUeP8UlmAKuTVS83vyZpAOlhySek7Gj5O1oJiP4LXX6m0fEjD3+R1nTw4sfbfYp3Te9FkfMudlATMMdOWXvr08j+8aOUoRYMVSMJFjpDZQ0BSgqrefLs/bCCzp34vLUIV2uiQSOVdHrVXGFiJIgH18fnQG7O9F78RDoUGdhn3gY+7OtdfiGym4MMIW4nCTor5BWrNdwE7YKV+Gerqun1sHXh3vsqigr4bkwpS18+RczEBjrmGGY1cE1eKJIBui7tlPHONANx8BmF8oXMJUQKD3JCMpEBasyxtp6BnJClM5x7HjmVaPywljn9WDdz36BYeFDbfsjEXMydKKRtnxqAIh//TAj4jVBdnDjDRP6dEo73/TkS+85OJNoeYUgMFQRHvM37N34wNwdu21MrgWSR7uvz04Yc+vvnHpLj3s3juLNGBoWPGiGARq/w2w/50AnRplgNgX9RPfvuimClSO1Xrqtu+DImYTxcb7DbcMwnHHv5Z58nj59SGVMjuP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(40460700003)(5660300002)(86362001)(2906002)(47076005)(356005)(81166007)(36860700001)(40480700001)(26005)(426003)(336012)(2616005)(107886003)(966005)(6666004)(478600001)(82740400003)(83380400001)(4326008)(8676002)(8936002)(6916009)(54906003)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:31:57.7566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381c2856-59a7-4db3-08dc-08dbf63e314e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
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

A set of patches has been developed to resolve concerns regarding data 
integrity failures in QSPI and OSPI for the Versal, Versal NET, Zynq, 
and ZynqMP platforms.
 
The series has undergone testing with flashes on the default setup, 
and comprehensive testing is currently underway to test the series 
with all available flash parts.
 
These patches are built upon the v5 series, which can be found at the 
following link:
https://lore.kernel.org/all/20231201031839.239567-1-venkatesh.abbarapu@amd.com/

Changes in v2:
- Removed the SPI_NOR_HAS_TB flag for gd25lx256e and is25wx256 flashes 
  since it already exists in a tree.

Algapally Santosh Sagar (1):
  mtd: spi-nor-ids: Add support for W25Q02NW

Ashok Reddy Soma (10):
  mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx flashes
  mtd: spi-nor: Add support for cross die read in dual flash
    configuration
  mtd: spi-nor: Enable DTR octal flash program
  mtd: spi-nor: Send write disable cmd after every write enable
  mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if SFDP is enabled
  spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
  spi: cadence_qspi: Clean up registers in init
  spi: cadence_qspi: Initialize read and write watermark registers
  spi: cadence_qspi: Enable ECO bit for higher frequencies
  spi: cadence_qspi: Write aligned byte length to ahbbase

T Karthik Reddy (9):
  mtd: spi-nor: Add config to enable flash DTR
  mtd: spi-nor-core: Set dummy buswidth equal to data buswidth
  spi: mtd: Use split reads if multi-die flag is set
  mtd: spi-nor: program quad enable bit for winbond flashes
  spi: cadence_qspi: Setup ddr mode in cadence qspi driver
  spi: cadence-qspi: Switch SDR/DTR using SPI_FLASH_DTR_ENABLE config
  spi: cadence_ospi_versal: ospi ddr changes in cadence ospi versal
    driver
  spi: cadence_qspi: Add spi mem dtr support ops
  mtd: spi-nor: Add block protection support for micron flashes

Tejas Bhumkar (5):
  arm64: versal: Enable defconfig for Micron octal flashes
  mtd: spi-nor: Update erase operation function
  spi: cadence_qspi: Fix versal ospi indirect write timed out issue
  arm64: versal: Enable soft reset support for xspi flashes
  arm64: versal: Enable octal DTR mode

Venkatesh Yadav Abbarapu (5):
  mtd: spi-nor: Update block protection flags for flash parts
  mtd: spi-nor: Add support for locking on Macronix nor flashes
  mtd: spi-nor: Add support for locking on ISSI nor flashes
  mtd: spi-nor: Add support for locking on GIGADEVICE nor flashes
  mtd: spi-nor: Add support for locking on Spansion nor flashes

 configs/xilinx_versal_virt_defconfig |    4 +
 drivers/mtd/spi/Kconfig              |    7 +
 drivers/mtd/spi/sf_internal.h        |    8 +
 drivers/mtd/spi/spi-nor-core.c       | 2028 +++++++++++++++++++++++---
 drivers/mtd/spi/spi-nor-ids.c        |   34 +-
 drivers/spi/cadence_ospi_versal.c    |   77 +-
 drivers/spi/cadence_qspi.c           |  403 ++++-
 drivers/spi/cadence_qspi.h           |   71 +
 drivers/spi/cadence_qspi_apb.c       |  107 +-
 include/linux/mtd/spi-nor.h          |   22 +
 include/spi.h                        |    4 +-
 11 files changed, 2541 insertions(+), 224 deletions(-)

-- 
2.27.0

