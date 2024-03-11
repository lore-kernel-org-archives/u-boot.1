Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CC8C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4978D87ECC;
	Mon, 11 Mar 2024 18:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CaGFNIz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587A187E6F; Mon, 11 Mar 2024 18:23:05 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB778786A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVfONV9Cg3uau3ae2lc1RTIdqeyjc0ULIUcmWrHqjxuSTPJQGfBxKZk8TtdtUNhOTv2/oMSRtToQI+DwSX22KRFDyJn8JDY2BvTwvv02K/8mSari6i+AI61m2On35IyW4vkcotxh14uFzGpWHeEFcxig3PHizqhoNO3daEkdU3tbuXw19REaZ9Bw8fn4oC0CWDE+R8uGRO/P7qRXNV6q+garWetOPgp4Ru1wr+SQhB69a3hMvqqX+16Sze/oaK2TY4HWJTocerQyQ3GtevpicTs4Se3igqzQv0JwTd36s22PiIVfxk+oBYlE1fivLx5ueOazPOc1IJe4/7+9a+oa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rta17QdrhryF6RuLOQftQ6DQYYpfK1KiwwX7fQvgAkI=;
 b=nR7YSgLN1lzn3jbRMDDscEED6YS8DJCknSBbZsQ65xT01h+/J9FA6E8eHUkbZeigJbIwUAynjPfMV9p9im3FkfElqDJPMxrxJPuzaWYtWKj0MBXoU1YEdea2iz8OJU+3DtbKN3OjVxb4w5iQr8EdIh5nr7xMgEU+a+0JhzYj5P5otm09l9fTwOlkqQUpcZZ+kmobfl/tk/cjoDZ5AF61M1drBrJ+L+foo9z30mwm3+dR37II9cRZ2CcnewWCH59VCE9653pFMFUzPp/yOj2bIc6h3eQpu+125t4z/dPg+P9EPNK5SX7fKc/TmkprCxBBVFB/IUPMSv4c682kdY4v6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rta17QdrhryF6RuLOQftQ6DQYYpfK1KiwwX7fQvgAkI=;
 b=CaGFNIz2wmK97upiIEf4Lj8knM+GVYLgctbx2GFCATxEPxH8KlnGouST3Q/3TAB1N7vQjJ5QjFunXIYZfAA79AdLNAVKtqObv2aWKW0o5A+HUk6dQHlrxkX4oyCaiywWx1y+Dnc94iOJ4wJPxoh9iuamIDZmr6FVaTLJnX5kPK0=
Received: from CH0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:610:e4::30)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:00 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::e5) by CH0PR03CA0205.outlook.office365.com
 (2603:10b6:610:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:22:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:22:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:22:58 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:22:56 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 00/19] Add support for DDR PHY mode
Date: Mon, 11 Mar 2024 22:52:30 +0530
Message-ID: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 223fb24a-7934-43b6-c306-08dc41efe61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWkUHn0MhYJGXR8AzCezVuD3NvlCKFM8nuQXraWY2+ZoALO7UHktiKZ2XVOgibTuvUYPWkEW8U8xSPcYhjVOcLbn6s00dS8kGdkYuD4R1bk0asSgDGXwtq6PJeobkJk4q+Kip4tiIHXJ70t2RM3BjD5c8BbM4slUb0PLyZxs+Yg2PCfi/gt9Fcbero9WsHG54OICX+dageaWk7XMjK65/Lo2Bt5afp9NuLWDVRVHglrQ6Iuq6auyY/8Iu7hfkpWpGQAqMZ1OaGnoISiImr75Kkre5d6bL0LD70VibADCyaUjI6G0/5zcvX1/CoBx/mDaUSJNgfqJ3m8vJ7fUU8IyyhVJyXJLCOL2vK/hwVhFLTUj8y2BFckhSVDQEuS4xWobGuX2/ShhLMHLzoq1COLx68te3CzEUoIyF3+Ep3i+2tCJ5FVllhb0vNAutxSJRflqBGuVfwpFADipasmq77ahwSxNWk73VaHT8em638K9P/u3yRfj4XF6y3/a3YsPS5UvV7N7OZ7lU7Nr3I3Yv41CUBQ+knipAk8vTA+fq/ziK/WRBMWQdJ2KGKCVv4WPn+K9Vzg4NX/5k6jDweaiLvGRnw6qXZdrDDiOY/+d/jcM10P4aF0pgQkrA+IwUXD4iH9i0Ui4rpRSCXCRzfY8hXid6PZXB1+SPWy7uIMFBKGysUWkfmFPqSmjA6OR7FSdXhZZswsYaCbSvjAcS0LK0frkUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:22:59.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223fb24a-7934-43b6-c306-08dc41efe61b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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

Enable DDR PHY mode support for Micron,ISSI,GIGA and
Macronix Flash.

We are dividing the below series into three sets. This 
represents the initial set, wherein we have activated 
DDR mode support for flashes.
https://lore.kernel.org/all/cover.1701853668.git.tejas.arvind.bhumkar@amd.com/

The series is based on:
https://lore.kernel.org/all/20240304031046.25998-1-venkatesh.abbarapu@amd.com/

---

Ashok Reddy Soma (7):
  spi: cadence_qspi: Write aligned byte length to ahbbase
  spi: cadence_qspi: Clean up registers in init
  spi: cadence_qspi: Initialize read and write watermark registers
  mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx flashes
  mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if SFDP is enabled
  mtd: spi-nor: Add support for cross die read in dual flash
    configuration
  mtd: spi-nor: Enable DTR octal flash program

T Karthik Reddy (5):
  spi: cadence_qspi: Add support for DDR PHY mode
  spi: cadence-qspi: reset the ospi controller
  spi: cadence_ospi_versal: ospi ddr changes in cadence ospi versal
    driver
  spi: cadence_qspi: Add spi mem dtr support ops
  spi: mtd: Use split reads if multi-die flag is set

Tejas Bhumkar (6):
  arm64: versal: Enable defconfig for Micron octal flashes
  mtd: spi-nor: Update erase operation function
  arm64: versal: Enable soft reset support for xspi flashes
  mtd: spi-nor: Enable DDR mode functionality with ISSI flash
  mtd: spi-nor: Enable DDR mode functionality with Gigadevice flash
  mtd: spi-nor: Enable DDR mode functionality with Macronix flash

Venkatesh Yadav Abbarapu (1):
  mtd: spi-nor: Update block protection flags for flash parts

 configs/xilinx_versal_virt_defconfig |   3 +
 drivers/mtd/spi/sf_internal.h        |   2 +
 drivers/mtd/spi/spi-nor-core.c       | 185 ++++++++++---
 drivers/mtd/spi/spi-nor-ids.c        |  36 +--
 drivers/spi/cadence_ospi_versal.c    |  76 +++++-
 drivers/spi/cadence_qspi.c           | 378 ++++++++++++++++++++++++++-
 drivers/spi/cadence_qspi.h           |  57 ++++
 drivers/spi/cadence_qspi_apb.c       |  73 +++++-
 include/spi.h                        |   7 +-
 9 files changed, 740 insertions(+), 77 deletions(-)

-- 
2.27.0

