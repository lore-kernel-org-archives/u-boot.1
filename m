Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69980CEB2FD
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0588C88CBD;
	Tue,  1 Oct 2024 07:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpzCyPUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4CD48912C; Tue,  1 Oct 2024 07:14:59 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A843E88CA1
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLrNT8wz2n6A5NVBhKUBwcRRDk7GnUVC5ZyH2Vy5B+OdHePYr/Q95gcBCBkjk6M3PH5YMrqFCuKxksF53FrHIpyeyStY1yIIl/53NVzxk1mLpS12g/y346vxfQh9S4eli1r43T45xQvZjAnxVAxSRcLN6E+l/KagFCQvn3m2j5a2hWmeSe+AzQqbIfgRyXpmJt90/J4dmtx2XwCsN1A0eqqNlU1ECIsNPQuylENVFu7FtCEnK206H+9BBogZDal1wb5ku3vmrb2VNQ1MltTMP6EBzcqc29Q9II7PlWlN49X816Uie6bQ2w6lr8LtlDOCHvanaMBa37Sd19EWjoX/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGSsCvi4eRFgOpeC6lLmBiaCjMwoHxEbZi7aMqJ/rJs=;
 b=Koojp4GdKie9J+OWSD3yNyckBy4A/CZTYqQ4lPTElh3wFf3GE4CAZuLGgpvGBEr+Iqo6MJDBL1cs3c81YZTwMAiVnJJ3NWWoUz34uE1qwGYQJFth5vq5guhk1Uop8uiC0vmq/zeDTQ4nkZ0rt7SZgXWWBY5gcTlAmQ/gaemkJOFouu4okFigcjaxL15XUHqiiW4/PpCi/p4BLqiqamPz/cROTIsMmFJKvPdo6w1V3jbh1csAaLGtVzclHI2nX0QgZb3r4tupasBiqY0TZbzNxu+qKYBXUH+KKceo6STSZ8V1AfPTFmzWdhOMWZZ9rOv9g/g9juKy80RmlnPO2KF5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGSsCvi4eRFgOpeC6lLmBiaCjMwoHxEbZi7aMqJ/rJs=;
 b=TpzCyPUhrlnkLdszBidop9XJEuID/WE+z3blwoB8mGQ0Zf3u1rstD5CwUt0LT+7NBrDBvWgPPayZmthTFCRTqGKMlvDo8Osx7okeOthFheWchhM2B4bUYmb3PxHfny6smZTrYjMLE2l2QlVvOqmL4F+WkELD+aVgTf6MB17NuAU=
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 05:14:53 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::35) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 05:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Tue, 1 Oct 2024 05:14:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:14:49 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:14:47 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 1 Oct 2024 10:35:28 +0530
Message-ID: <20241001050529.17922-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 772cac6a-c32a-4a0b-2a94-08dce1d7fb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nnAI7Wr0BmT26nlRPIsjB4Gc9khZeUOlhayUi8gm4gUinDOqv/waZeZSwwZD?=
 =?us-ascii?Q?7y5Ljik7oupn/2c9AsTk0lzzfwPMwV8udrmOCjeyptpZ1b+1xQe1a03Ue4pp?=
 =?us-ascii?Q?jLwQ5ydoj0lADNrE8BO8glbc6jK8DCX9CT0YOnxZ37ETTch5WgCZsz4/KX3S?=
 =?us-ascii?Q?qR23e2fYjqYwWUcZXH5ZRcY4Xe5riCNaSDbkD7L32B50JXgRr77zWv+0MDXv?=
 =?us-ascii?Q?KdCC4KxrPwFo6tbrBRrBo2MNaerKRquwfnMkCUmMCC7tHadlF0S7BtEmhI3O?=
 =?us-ascii?Q?TTolz8yMLa9NsdtdaP6g9LlwhSi/gp8Z3RTqHy6IFIQqz5X7Q+MeM5tuZAQ7?=
 =?us-ascii?Q?dzeaQADzqWWtxlF56LMYZege3WzWdvXmqeqrSurwfvJm7aBX50X1olXYC+VV?=
 =?us-ascii?Q?P8HTvZrx+r9RJDmNu/Dth/jUt5g+QzcLN3J4G+kLqR55/laBST9Yb/ktOpZg?=
 =?us-ascii?Q?h4nHin83+0/jFBN4sUeK7k+LZUUeePmPYvbIA6tmKs9d/pUwi82irM+ax6qS?=
 =?us-ascii?Q?NpN8BUi3biRPY67b+0z2/xanHTztlX8VC8B3ZQZ8AoKNimqfx7Fj7viz/mGC?=
 =?us-ascii?Q?qOETA/tZOkOS4mXjBHV0EYZITUF2iAvBZX587IaZA1B7aTNFjRArGbNHKc7T?=
 =?us-ascii?Q?98EkVFZS02AkP64UygkEUhUhoAoTFnCkPqsWSb6oQtiEpM8W8alHpdg3RGXp?=
 =?us-ascii?Q?/7qV6KiPBb4m0BgtLBdaOJHUkTeFhmiwjP5DPyD8MvcrDsT/6zFV88NJkqjd?=
 =?us-ascii?Q?Ilwo2TqJ7tExDehT3unVjdbxQXpnHmLec+BWUSwgVEIirvqiv+udcOFH7OZX?=
 =?us-ascii?Q?6ymylZCn3v+52NZqz3eGXTThTUTsfklYGR2u4W2rpoT5lQy/gCHmwBfAQReg?=
 =?us-ascii?Q?hvjFwLMkFo4A7BLbW4dkEi+lEVv8ZPGa0Dhf28LjhSk8c/ZcvaY6kjZyd2p8?=
 =?us-ascii?Q?cO46jb5XcVZea8CDYwjeLxWbxnUOcpZ7JIuVJ01wYu8eUZASKlm1YbgS16LM?=
 =?us-ascii?Q?tf+OSnFM/x9/l785P470QW3kHPZTdIfria177qwBrjBgKhtAYHLX1OzQ+BOj?=
 =?us-ascii?Q?oVd+PfV3niNdn6PXIt/QpO3b7nAwfzRXE6aHSDzrYNrqoc7M6MEDgETuppEn?=
 =?us-ascii?Q?A1FNYogBhmGGZ+XiouI4vR61RLD8qgG7kW7ymk83e8jRIw8AdJRcTnT2u1dU?=
 =?us-ascii?Q?++Shxkjo7CdtzrBqajVl/NMBGH8T9FW9IktN3TNwOPr4h0/Tqj0dZ/WwhMuT?=
 =?us-ascii?Q?YQhNEf/Dj3ajQr2jmxz6ioLGsYswcZJEZOlqQQyFLr1fsUqnfdpxuZOuUYML?=
 =?us-ascii?Q?PXg422YhpHE1DXwR7HS1WTimOqaJQFz9s7O7SAQKIyHl5PGQe0yDBcppGxx4?=
 =?us-ascii?Q?wYbx/8Zp6gfR9VS3tyoDsbYevM+b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:14:53.3406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772cac6a-c32a-4a0b-2a94-08dce1d7fb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5a07edf5cd..4f0199f099 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -29,6 +29,11 @@ CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
@@ -204,6 +209,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
@@ -223,8 +229,3 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_HTTP_BOOT=y
-- 
2.17.1

