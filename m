Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB4ED5A6DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 04:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4555C896F5;
	Wed, 27 Nov 2024 05:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBWjQR1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57152896F8; Wed, 27 Nov 2024 05:38:40 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD45F89689
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxLv/5RhHK6R2Fx9ZLcUWEbR9NHX4XpsUkgqKUcpj/k+Q1wCPrgKt0zezC38aXaSQRkO9dJrtlcGLHYJeogsNfxcQDro8inywZywuQooKXLBVxGMqWEAvsbF4IwXqyxMnqYLlWzM4ElONABtWWFOBUMe02Ec/VgB/8YrW3slMlD6qdWds/ltiZHmS0/bThZKZagyhkjKJwUPnYKpZW9hqEgUurgfhk3f3mG7ztCIUazaZXNMbpQJ+gRnOi/sijjD7z0Zjk+TEuWNXcY5/ppHLLvx0zuz7ombAjMrV+5deRIEK2/rW1IUu2yktGXloBx5+ZHg0w/UL/PzA/8UbXp41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em69N7VnFVS/VPl4msL0iurgmq39zUx5gaFQ7tQ0gEA=;
 b=OgdLufZ5qlZsjKwcg+Bqc3gRF1AhV/4Je0ZZrHlGIe6UdjHf8FZowpwodQoos1NsWKlIttIaVwg/s21X2mMU4GCCjYVMmqYeTRVys67WD1sBoLixzhxb/WOOGoxYUaoMDG173mNxZDrMF/OFR4/TQuOzOCw+sEHX8/ZFQACaY9OpT8Bz0YEFk7bvwfRkZouXN6exQoS5jIsZJMpdwLeK4a5S/ffqLzHFBfKnU1Y8BpN2o6GbvLV+5036RNG545Wn7cJ0U4GRPwEXONaIi2mtRGCj8eAn3MrSFE+9zknRClcVq+e6fe7i2JIBeExMRfCFzXkDhxEsqiwtf9OIIO+xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em69N7VnFVS/VPl4msL0iurgmq39zUx5gaFQ7tQ0gEA=;
 b=zBWjQR1UapenwM9yJUkRJVQ9w6VPCAgcbnkXngMMJjQvtrEwB1KE+u9AMcAtlVnBpKJ415AiwiNkDakOQ2ZuTGz10b8K9/VXbRSuhWaDCz8GD1pNJYgjSalPZ0X5Ze+nBLFZzHafbPuJh20k5AcpqzP5hjHLHQhL+CUX8/Ra9Po=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 04:38:34 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::27) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Wed,
 27 Nov 2024 04:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 04:38:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 22:38:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 22:37:58 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Nov 2024 22:37:57 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] configs: versal2: Enable OPTEE support
Date: Wed, 27 Nov 2024 10:07:45 +0530
Message-ID: <20241127043745.249580-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 167cd58e-3cde-45ad-03b3-08dd0e9d5a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oybh0bAi3wW6gM8vRuOPLWkUWBX5O3GYL+PboU+5d1QizLQd7gySM31Q27ls?=
 =?us-ascii?Q?5ZNzMOLTdWhXZc/w0GfIE29Z/+nQP3L56WFw2UZbiXm4nKtdzuTe3CzgF1ww?=
 =?us-ascii?Q?SgBHGv7BzqNK/0r4O88FENVE7iJ1qUIsqxl7hLb0pAUNUCl7Vj3aGwjVFVZr?=
 =?us-ascii?Q?7yz/yPQNDcBu/H1ftjhW3WPkdy0pJqsVUZmA0rcZRch0NdpkmJG/cLuEO4QC?=
 =?us-ascii?Q?bfad3kiyf4p9Th1As9o9sgXTSWgX2Uz211h4wTvPsyC8JhIWCanDRPIDxGER?=
 =?us-ascii?Q?yOS2Xaa28kCiu8SOQ2no0RU5Ik1bXmhcoEZxENdrbkkuDS4apjT4QkoWvHMQ?=
 =?us-ascii?Q?6SH7ycQmiLsL6Y2dSS27XaquPTl59aZFStf3MMzp91/h2NOZcgM0xOgZHdb+?=
 =?us-ascii?Q?760KjEj1v1usaCjK14qBdxn/YdIJtub9JaWEOENJIw5nhRcX9s2BwnUAj1O2?=
 =?us-ascii?Q?V1Pl5aBHzL41H4lLEUuaZ1TRKKGzr6Jj7YiFIWbL3wMD95yg+wW8uhNdU/Ye?=
 =?us-ascii?Q?fyNyOq0hIivTswUqoCP/JgcWHArmRJ9FYD3Sio1jeeMKox6D+IzTAE6nVq9A?=
 =?us-ascii?Q?6MuvSBHLeqrWl/qtVGF3vt9MdnSXtbyelJrXxWchr7chO9WVKx4hpanSedJJ?=
 =?us-ascii?Q?T1ozkhEE+PIwP5rDCbbDEMV3THGgr+K2B2ZVuoC+OrasMqM0WDs2pHVpQZUa?=
 =?us-ascii?Q?8ktZRsr93Qf4W+iKdsChB1AWL1nI3LdZAwBYhPBziiMelzFYieaO7mpPVFZB?=
 =?us-ascii?Q?7eMynC+Ot9mZ6Gs/vJjBnFMjpjnHDWlGKh4AT+jjUxgi1ANaO/SoIZgNRArm?=
 =?us-ascii?Q?q5FtUGQmwnCd0SqHfekrj0pZGXKHVq8LfTO1nVnM6e2uFlSYLhR81mRRDZat?=
 =?us-ascii?Q?ELEU8MZiV2Q47GK4S6uxttM0Ogw6TwmObinl6WEwJ4Q3oLLZTcEcWvaf7tko?=
 =?us-ascii?Q?lrBZ37n6U7DUC+w10bzSUcHOwGt4n6GOeH12hSQ3zkXi+JyumR76iZ0PzD/S?=
 =?us-ascii?Q?ZDCrhPJixCdpiciGshf8KivunFqfQxHE6oKLmX9N2YW1LCivEzbx7JmmfNnb?=
 =?us-ascii?Q?LtvnXlP0L/K4ev2v5MAZd4z2U98nsY0T9U/SqjjjpXNtmJeBbqGRZ+wiTWHi?=
 =?us-ascii?Q?BxNeGMmDQkC6u8GwcVu3FbiYzgBzqGRYkqUrS6YD4QM0g1kuUPMvnnZqaRQ9?=
 =?us-ascii?Q?W9Lu7DKld1JaI67gkkNaQN47Ueq/mvMh1iJS3Qypo4L5uaClt5KTPxCz8YS4?=
 =?us-ascii?Q?WNRRmNYJdz/+kBne3oBbcAydqrEzFpZ4FVFV/9Ep41zI4POdJR1Cwxii1RCt?=
 =?us-ascii?Q?/BiEfPBqceUC8JF1jb07NBPOsuO3X5ienHAHXfjkjiLU0jdIp/ZR/3kby+if?=
 =?us-ascii?Q?hAdLfzjPhvKtAFeLevh9uaVDgUkr1DiPjQOTRyZwn4Wv3eV5/pAjpBjyxI03?=
 =?us-ascii?Q?m+TE9PJhxbOImfIdApfBQxzGWQDq7p9U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 04:38:33.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167cd58e-3cde-45ad-03b3-08dd0e9d5a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

Add OPTEE support for versal2 platform.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 08e607700c..b4aebf3e9f 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -130,6 +130,8 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
@@ -151,3 +153,4 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
+# CONFIG_OPTEE_LIB is not set
-- 
2.25.1

