Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7379CE8D5F
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF3F890F4;
	Thu, 19 Sep 2024 11:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TOtZCvly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6644890FC; Thu, 19 Sep 2024 11:17:50 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E31889100
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRQOy8/5ZQFJ0+KN9J1dig+FXkHAUNXSi/RCEcVS0gWNwDfeZo2HlM3GCgp0Q24zBxsJRSQq+vZB3UM6obWYkjtEKAEmqV+XAahXgzY+oSdJ+2wQYE72nxAbQQiz2HwHXLud1vx/MMLnzx2EzeiA5OoOdf77iODHlMMIrcAtH/kUlzQElmr1mnnM6lR6ltNfaiDCcLm7FS+t1hMOYiIH2NJHzGuIX8d/U88F61gNXDp3lkkXW/xclbwGbzm7RUFcbHoLdk30sQYEk0v+mkfzU0iUIxlbqFrEt9aVgMX6roJSwx3KPFvXwVYBi12YKkQR+97Ineg/+b40JOlCHoZGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHtDvXqhnGQyVSyKWD1X3D4FIofR35YaZpiwWzoXYwE=;
 b=MVmu83HWj+hwtY2H7zNwuKfIPpi+rrOXHFnfUw/OFARx+ClFHShsu6bDAPxX1Bc9gwjWYkNbXDPoYKrTqKB0UWa8ZcZCo1eD8GOgeaMS0BKaGrIkzp5comUD8USxyP/I++0fHXxe0oeZWUENuGDVbAHqR5+c0j7iK3tIzZuX93AIFbZn+R51LJUXYAAcU9Ilsv24v07SVXqFT7XkloE49hIdwmXaMTOrL0copxuISbPSOvPWowjvjAnWZECFiik+j1ryIfNlI1amPIYTLFGunZJjLrUymjII09qY/iOgRLmT1wUp9nBUU81AAUanBHZUKQZB6GKvoWJhIJjs/n0W6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHtDvXqhnGQyVSyKWD1X3D4FIofR35YaZpiwWzoXYwE=;
 b=TOtZCvlyZeqO0raD+V38cNaezaGe3NUnr4Sm01tGV8R4RsLDff7uAFshodf8HArM8sfsWMbSDZgCHuvxg0FsfBfP3gHiSuG5d4xNtzA/diUwrSo6cJ7HNkoT7wuU9e6RBSobF3auiM4EtHWl2PcTnTbDIHBOPAJE+znFlw/OK6w=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 09:17:44 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::e5) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 09:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:17:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 04:17:38 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH 0/3] Add AMD UFS platfrom driver support
Date: Thu, 19 Sep 2024 14:47:28 +0530
Message-ID: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: fc66d4ed-2789-4fca-9f4c-08dcd88beb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2bgLrRqwW+s2L6QR9PQp6PwyvCyoxkwkzUjAf19PyGDBGsy1oBD9x5uLy57I?=
 =?us-ascii?Q?U3QbvdgIbuxAN+gikBymp+SaZW3+Gy/6Cp3b1uLJDP+dPGDr4L9eXJMoRzbW?=
 =?us-ascii?Q?PnYvyzrGMIO6ekqtoWYnM+CiAi9XEmsjkckl2/zlD9p9l0xtVW26CCgz0Ncd?=
 =?us-ascii?Q?NSjH2ZFcg/F7Qxn+7fU/Gbjg+KR3hURtLJ7FWdk9OOyGu6BLQaBJx8BUvpHm?=
 =?us-ascii?Q?mJ7YwTSML740hF2jDCzKlJ9M3cgT7XhRZNvqHYDO8nfLaloJmQ+EkjP0qov5?=
 =?us-ascii?Q?wQ4sr7h9oDAls6FP779CbQWQwfUtVLkKyxmd6iLLtkTJYyDcCVrmrez8A3W1?=
 =?us-ascii?Q?kxq3i9ERTIz5lJizkWEAGYhmyd/lVjUsGljB2vcx6yo9ksmGEyqpBKUgQpTw?=
 =?us-ascii?Q?9ugQEOawupP0i4Odj9ppD+Z+B3axvybiuJwdpuVFRNPGNJBWe0iSQvyWv3w9?=
 =?us-ascii?Q?+s80FBedX+qmdiIsdE9nOO1U/YWhmbwVddhg5HsskO2TLRRxnmgb94zU2TCk?=
 =?us-ascii?Q?ItZ/rafvyaBKxmzM0JVwrHGeytgUXCh348W/8WscLtqWWtjVlwcmOGOsJlSg?=
 =?us-ascii?Q?ucY1HYivM8G5YcomPkgcXpxaOYC+6vjdfhl+ggop7pcvuOJeqjLWahgPhpou?=
 =?us-ascii?Q?yfOcAPciHlv2voty0e/dYpUBqzB60jrdZSf/Rhw/wp7L6t/PqavKQy1opOyL?=
 =?us-ascii?Q?y4PK0xUnNWgQiy5x4X/hHsQPo90uOTQ3WAPLRqYfZjLKNnp1IwmGNzdJlk8u?=
 =?us-ascii?Q?QHuRwsk8pzWMiuM35vDqwtDDHkOnSVIDgUM/v/xcgMlLEv+DFAzwE9JS9Tf5?=
 =?us-ascii?Q?i+RRmgzrhbQvsqMVqCUNAqlSNY5dn6yI+kyGDi98BOEFdGBLlYXuGXnZh/tF?=
 =?us-ascii?Q?9vO/wwt8G3qEl6JSnHMOWLt+cok+mZNcx0uRvB/XEOby1tIimCH6MkO0jgu8?=
 =?us-ascii?Q?xV5l90ABhd8h9hM5ukzDqGolYxMGBYJ256/yZsWIGl0ocmaG+yn9HKdtalui?=
 =?us-ascii?Q?KzwvnNgzP2ze8fiawRqePe/OG7TrpVo30WcfbFXgce5OSQv/MqtdznzqNCTk?=
 =?us-ascii?Q?7eiV8GT5JLTCh6fdTmSdPcJ4nKbExTLYexXUomhAon7Bgzsnuva+/prV84U5?=
 =?us-ascii?Q?ilF24xl2aLHWG0fCEHS6v0Y1bQr41xYxK7bn0x2z588+XBAL1ee36Lkw1DAO?=
 =?us-ascii?Q?kNCn1xSOdmdYYRarrH8B/6AUQ8yZflcwXc3aOUhTmD7cBPjxsULy9NgSulCd?=
 =?us-ascii?Q?S62fk2q/TRGu4t6BU4CUyG8Tan9EebJkyBin2VI1BBgFcB7R8+CXLPWKtmpg?=
 =?us-ascii?Q?79pvjyWRGvsa4F7kUtWJdWiJJ+iU69HOB1a5wmFPNnaGM7d+TAMjMR/mFJWr?=
 =?us-ascii?Q?S2lVp5o2aeUMiqnfNBHRc+6alMXVD2kXfluxMxLzfDeRwcRuoBp9jbQBY3Qk?=
 =?us-ascii?Q?Oe4N5mzKKgE4hwT/PXlLDphQ0PD5c5WV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:17:43.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66d4ed-2789-4fca-9f4c-08dcd88beb46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

Enable UFS DWC controller driver support and add AMD UFS
platform driver support.

NOTE: These changes are rebased on top of this series
[PATCH 00/13] ufs: enhancements to support Qualcomm UFS controllers

Venkatesh Yadav Abbarapu (3):
  ufs: add support for DesignWare Controller
  ufs: ufs-amd-versal2: Add support for AMD UFS controller
  configs: versal2: Add support for AMD UFS platform driver

 configs/amd_versal2_virt_defconfig |   2 +-
 drivers/ufs/Kconfig                |   8 +
 drivers/ufs/Makefile               |   1 +
 drivers/ufs/ufs-amd-versal2.c      | 501 +++++++++++++++++++++++++++++
 drivers/ufs/ufs.h                  |  11 +
 drivers/ufs/ufshcd-dwc.c           | 141 ++++++++
 drivers/ufs/ufshcd-dwc.h           |  69 ++++
 drivers/ufs/ufshci-dwc.h           |  32 ++
 drivers/ufs/unipro.h               |   1 +
 9 files changed, 765 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ufs/ufs-amd-versal2.c
 create mode 100644 drivers/ufs/ufshcd-dwc.c
 create mode 100644 drivers/ufs/ufshcd-dwc.h
 create mode 100644 drivers/ufs/ufshci-dwc.h

-- 
2.17.1

