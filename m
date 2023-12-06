Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235DBC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76ABA8752F;
	Wed,  6 Dec 2023 06:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLk+dx53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBDD875F8; Wed,  6 Dec 2023 06:29:34 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F3787494
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGVEjvwzuHxJKq08HVHP0G6aGPbaHciorRKEH2IFTuLHBl0YU3M4AGsT1Wggk4XWxEuZ5AeO32hOsYIlb02TBPPvLSu3hDRT4bZmgNDJEtYTzocPTxhMO/xLrc9p7GEhD2bCe+m5DglEI1yIJnwzYHnZcuQAOqnMOue+naL/i/VDCW6Q5piN0R4RoCCEqXE0ZtfVVifWxQ5g5KjsUmKJv31Tb4UdRw6EWwvdEvqF2cg/87GcJ5dPdBf8Qz19XzrZjjZ9IeY9ispczEMM7c9qeDSTQo4btFEFl1suJUA8eGpjQ56XW1VSWRRjxyYT0dyTc68IAqPg0iUjJ5sIw/Iw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOykQu27Y/APPhNlj/XdTseCBZ5nLX1Sf1HA4fWYRIY=;
 b=m4gENe8xpYcGsaeX3bvU6i7eKUEab2dUicuI+XC/c/7jx8taduC1ThhLsqDE0axKTWnNWsdxbcdjuBvAmK+OiTwbVMgq0pPVCd2tBHMEPfqjlTyvfbqcAES2Jcwz+rqsM3YcuF+1A9zE/j15f6NtBHFclx7Y/CnLYLItbJzrmUmdV2hvwjDw+L7Vx6V8E/idXfahQ87zP+m8Z7MnSgenj8KgtPYGq5kHZvudsKFAshMTjdjOciqDpZBxPOWxLXhjbxRPg8u1G0r6LEwN58JSdBzCzNiM4qGDVd/V6MXHjjLQ4QdpotlkCeoW3KlhvrRRxWDTSg+V4wDpvMCvuwjBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOykQu27Y/APPhNlj/XdTseCBZ5nLX1Sf1HA4fWYRIY=;
 b=VLk+dx53Iqh97auwDbCrhgED3iFpdGsWkXf8vGui4OhFz7Gw0Y2vWK3qYye3TrZce9kmzGafezzjghnvtjEwhPgPBmZu24iEg5s/dQ4KvTHnzaFcdnIgZf16hylNGALwuCOoFoU6VHqbDYUMqXBG0mvgh5otKcGSCetD8/lWGFc=
Received: from CY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:930:3::28)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:29:28 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::4d) by CY5PR20CA0030.outlook.office365.com
 (2603:10b6:930:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:29:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:29:26 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:29:24 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH 00/30] Fix issues with QSPI and OSPI compare failures
Date: Wed, 6 Dec 2023 10:59:17 +0530
Message-ID: <20231206052917.3743991-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: c48e351b-f6e6-4be7-825e-08dbf61c50a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9P/jq7PVDTDh3A26i5Y7LgcF1Ee9B6CRgTFPJMtvTx84I2Xar1ZROD/KknvfX1whnMJWXSdc01j+6Xzh8m+V1zmdZOcFcUvFxygid5aPrFQZiuvSwDHX0yxc78QK0VFZPt+stXJltWm8PVe4i7W6XLHm/CxSkmu5u5hX3jRtP+pqb1dcJ3FsbvHWsdX78VHfgc4dCJF+S3gezrlaHdms6I5M0lkozGwx0rHlf67UUfqyjEUM+n9YMMevw3f9azqg07WIoDvsKn41RtAgo3gKG5phNNXfjwT2AtDgWbBlk+/yuKuO+DwPBmTML+/RBS2Tid15Gf4YpnPaojy6+AUvaPiFcDMguOqn/MALerEAxE4w5LHaFxOCVS8HCd1xncDRT5iCn+6BU+qWnFVzEDD11WAR1XQ916by/OMrE030Ww4FuU9NxVxm35clyjj4Cf2NDIG9Qo9O5XT01ldZybEY10iMFjbC4XEDRcR4CGu4GZbwN/noejab1p/ZKVCgbu7j/qq0Tx4pS6GaGysWfaBUsp0yAPguAbMZ1+bEh+STJBXxgmGarMhOYnPwpCf6WWeqlRGPRx7E2jK5CsjZFNG0Pl0GqAD2EUcTXb5WvMf5RZJhWWhHdP2Qeunxf/5V6pZpRwqrGiPRPtuamlatLruzcJ+HboiFvUI1BM8Q9ip3f2CUGPH3/UH3EpUgCBLk8Vbxw/koxCExMePCBb3/sX3o8yY77e5U7wHpNCZXai4q8hsXwvXuHyiKaEG1AgurWFs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(5660300002)(40460700003)(966005)(6666004)(54906003)(6916009)(316002)(8936002)(8676002)(4326008)(70586007)(86362001)(70206006)(47076005)(81166007)(356005)(36860700001)(336012)(426003)(83380400001)(82740400003)(40480700001)(36756003)(41300700001)(2616005)(107886003)(1076003)(103116003)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:29:27.4309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e351b-f6e6-4be7-825e-08dbf61c50a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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

A set of patches has been developed to resolve concerns regarding 
data integrity failures in QSPI and OSPI for the Versal, Versal NET, 
Zynq, and ZynqMP platforms.

The series has undergone testing with flashes on the default setup, 
and comprehensive testing is currently underway to test the series 
with all available flash parts.

These patches are built upon the v5 series, which can be found at 
the following link: 
https://lore.kernel.org/all/20231201031839.239567-1-venkatesh.abbarapu@amd.com/

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
 drivers/mtd/spi/spi-nor-ids.c        |   40 +-
 drivers/spi/cadence_ospi_versal.c    |   77 +-
 drivers/spi/cadence_qspi.c           |  403 ++++-
 drivers/spi/cadence_qspi.h           |   71 +
 drivers/spi/cadence_qspi_apb.c       |  107 +-
 include/linux/mtd/spi-nor.h          |   22 +
 include/spi.h                        |    4 +-
 11 files changed, 2545 insertions(+), 226 deletions(-)

-- 
2.27.0

