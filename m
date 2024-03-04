Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C794EC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 03:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE30187F4E;
	Mon,  4 Mar 2024 04:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hIIh3Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1362987F4E; Mon,  4 Mar 2024 04:11:03 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674F887D06
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 04:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUxs0YTAHIQag4MwBVdBvagNjkufdkeVJOBpDcaT91N9CahjoSsETe2JNK451IcKM28sFHCryhiMwzvrZSckgRIGxmBDqpvH64lvH1JgH4ptApYdh0JFrnIU8Xem7T5T3RA8TYIUANDtZTDFnmgQ+KmbT9S4cRxEZEBOKNa5PuqXg/D7WO+Ks62RaJ9aGsFuYOYbRMl+pxdQttk1kIXos3eAvwFWunZLeNGygQnB7w7cSHjxOwxc4YHTcQQeYsLQbOQMi8Cdh5s1iesFelWWSB1fCHz0m0ra0WLGOxg5XixHqjLZaXOZcw1V3/GUCH+0vF7wFdeDGCXhQ7X4+oduDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCiCIWbOJRFaEArGOFomq8GkplUtJO2qhlAqco+7HSI=;
 b=NQIheFqIpyjnKId1JLUQQSZLlD4D3T1yzWiuMF5bpaAzx8CqawSZom2iGVpUJAJn6+7oBOQW0MBexYLfiVSxdZDvjEHVMuaaIfjDF7xXfMjEDVhgabSjsdI86i8sLJMaAii4RSIXDwISc+iqIROXI9qHVXSW22ldu4ygzYdEiy5+CpIc93f2A+K/+gIDKDSPBaezJRy6KVQeZBXRKmlbpZcSSfYvwG40xNJ63PIUikrGRz+/LYJGqZJttzAwnI6c50S6IBxtjAzmLX6bj2AW7WUgkzW3hR8yxu3TdZq5B3KtXGTTAgUQ0XKyFO6u9evCkrfGFpc56dxClffv3Qp/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCiCIWbOJRFaEArGOFomq8GkplUtJO2qhlAqco+7HSI=;
 b=2hIIh3UyTaPabybtdPBTAG5kerY96v4qhgC9jQFkNHxibN7nnswfl0BW8hICnYTYGQLphsl+nLAcS3suAcp6tfSrryOvFIAeabsodr5ex+M+a6nhacC4ay2hj0oJXye2GpABVnAyULKkd1rcoiSdOzC9wOiqoV0cvZpDvulUGzA=
Received: from CY5P221CA0134.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::20)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:10:56 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::a2) by CY5P221CA0134.outlook.office365.com
 (2603:10b6:930:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 03:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 03:10:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 21:10:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sun, 3 Mar 2024 21:10:53 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Date: Mon, 4 Mar 2024 08:40:38 +0530
Message-ID: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d938db-b60a-4656-fc30-08dc3bf8b54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gaf5Q4G5STYrn8JqSdD4+WJGsqC0fatEyu9q7KmMgQ4OZAE+JyvwPtwazkmTD0Dq+pI/4pp1iHhjoaxs4y4jqDNNiqnZQbqMmJhAbJH2+h7jpuJhulQtqZdOBSmv1cSX9U74HTRT3pX+Mi8lgiqIce4beAtidTy8tK5SHjI6e5ZQp3mG9SDb6zvV/2zZDQbAtY9xdYlRpSnXuTc2wbyU8hoyt9XoZ1OjlXbr00dq4pjuQu00/gdv2H53cFfYV9qWH6dYkPmQBeMcg+Sc4baQZsJx1b6gyr2jjZhCmPw5ZwoODauDn9FcqKhMsYkHnAGn1hD2cOfFmR062AAhiHsQPfXh0LNGPVVD+FzIb84KMgmmHral4UJ1Lv2gWt5h5UwbKA/8eeL76E/kEfyOI2zY/YH4Sn+4lb4gpcoCqnKU87TPyR4VRsQKfGklamWiVB+SpFi96xCiZsKtlaeRg6BngaN4HLmPScJKD8eDopCRYGVRhCpAbtGe8QhKoLB9poOF9xq8gie+kamzQhcBLM3HMdeonjwu10Afzo3NXXWWzJmnHD/VL52EU+2JuV132A2meeRSBkRzsFbfbhAwJg1qswDyPQRveiXjludvQA2n+NN2TxijsqFI+RNqSsqu7rH1W369BIPE2M2I+NnOdgo204muB5n6Cbl0mrF8z2ZRTyPJxDwx/FaDoIcGqRBm2a91HJCWUp63zxns6RBVGfI9jYbpypsKuHZAwZKFJpteDLSdfXBPDUJq5FoUlgcbOEEu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:10:55.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d938db-b60a-4656-fc30-08dc3bf8b54b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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
Changes in v11:
- Removed the unused variable, corrected the type of variable and 
replaced memcpy with memmove.

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
 drivers/mtd/spi/spi-nor-core.c | 399 ++++++++++++++++++++++++++++-----
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
 46 files changed, 792 insertions(+), 228 deletions(-)

-- 
2.17.1

