Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2FDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 09:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365D8884FE;
	Mon,  8 Jul 2024 11:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6934m8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512BB88650; Mon,  8 Jul 2024 11:18:13 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E146F884F9
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 11:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVuXHklkWdmyuP0YsdbGjxzfqKPmdP28J2zkXk8Gw+FufmJe1g5jJs8+O4FXKWoVHROAcISe0qnhKBNLD1CayJEP08fiQCFcCXnQWIq5ZEQeS4tX1y/DiyMY7B93iJdLyFv7RX+H71e+DW9c9C0DQIR4zDAiWc3D2muNCKzOVvIbh81SeL8slHxKpz+yl/QhKcEZMW+qGen1Wr32CwJzsFJMETOVJnQuQW3C4smc8z8r4j+wNwh/bMKNnfUzr2Cpc4JoSp0XLp8K3gRBwd0W+ddx2MNduLNQ12+NFSL3d/Wx+P+7w4/Sxcf2CC8gQBPF0JYyguHpWKQRQvdhXE7m0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heMD7o/Gd2Yzg+lYXEztdhgYA+d5rfFUfwrv8Sd6VPA=;
 b=cJ/evp/q1GSmxB6Qo1VEEan7G7dlDxcgVm0FnHXYjHDf22TCavzhRqyogFGLAwCiIOO+1orwu5SFqalvIKDHFiGEJQvuICTvAzehAfReBnhYrr74j1xj9az8aCjo4UeJ0XzOjHmoTR1lmL9jJBgmIAFej4tTuvJQKX2xuNBIT7BTq24RjfOhLBKThXXg8jLIQTNm0xBaOSTTPK9m9oH2nYcPjhKZEaf9HprA0XrDcjMuOAy31pjQMSL7W8qrSrpSJQIA8RGFY9t8rdMNRJumZj8kZZr3uhwvepiXpc6DbaRK4xNNbCYFcZcm2bUtn+CZno53RdUqnL5d3ZTGCR9BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heMD7o/Gd2Yzg+lYXEztdhgYA+d5rfFUfwrv8Sd6VPA=;
 b=m6934m8Ba9UNkZqxIjs0djCzX48cW42Nzd1CnA0cCczf53I9jr5Xfz84OVhy3t4IFAFpe4bD9F/NLbqm0a2hKMBEw6ppZdClCGelHYrsU2GKlThO5ENHWuYsHXyLlIb/pvPQrgFk6UpnmLsqWwfqvovRB2ZQASqmLpPIu47kN6w=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:18:07 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 09:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 09:18:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 04:18:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 04:18:02 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] config: Enable the config CONFIG_MMC_SPEED_MODE_SET
Date: Mon, 8 Jul 2024 14:47:55 +0530
Message-ID: <20240708091755.5021-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 059593ec-be12-42af-704f-08dc9f2ee0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zq+eH0WHdm3EUaNgh/e0KS8RaqjY3DMqH6EqMAj0XunDZTAJu6wiOZY59uDC?=
 =?us-ascii?Q?eE9aZCZS6YmBOEbRohxaBbgCxxP5ZB/GPdRigZk5YDxOXZs7+vkjzIkvVHTo?=
 =?us-ascii?Q?8XVDr8cTqqLAStBmOV58qGtrOJ2xzv85uGRJebRHgDQPJIuQnBEAC0126Ck0?=
 =?us-ascii?Q?kBW2JVkYadWkKGZ8+xAmkCt1XdcZnyDdHZe6O5F1iArUw5vqGupYFD6l5bWr?=
 =?us-ascii?Q?GkjTuQWhQlaHFHEuzFbf1DEaPVhVtD1PIJPUYVF1OOLLLEvbFq8fI6yxBM4x?=
 =?us-ascii?Q?eODUvzNgg001TjEcEGuceOm3FkrQQMShWXzlTGH1OgoGrVYnibT1kntp7GIC?=
 =?us-ascii?Q?qkFBnBWCHcNCEQh/26EMbB5FGTfZmoj4kyit74JOkb3yGDjoTyHCcnnc1Tc9?=
 =?us-ascii?Q?J7LEZx87xLikEckXQa4cqEmFDacwvECjaSm42AFB7HpmO1Q8rTgOn8LsMlHp?=
 =?us-ascii?Q?q+FcMyElaq8AAyKQfEfBePBJVekPx1FV/yMykjvH0jFNx/wu2aBvMknZ+Tem?=
 =?us-ascii?Q?Yy7Dml7OkI6wsCrpeNfhwiDcivUk+GhdoGD2LDJeFpCZnagfMXMSwPi6tluu?=
 =?us-ascii?Q?TPtS6qKFRegcywkht3ymk8JuIu4UWTY9jV4GcVYzhJbJHtxMDAU+7fEB6fO0?=
 =?us-ascii?Q?X6AIPNcsp178fuA+/SUiGrxw3GzAQ8tiliG0Jca7d2Qe1lRxnuuiF6U09X1/?=
 =?us-ascii?Q?ixBfgIiBWqcVMs2jxoR44HIQlN25wqPB6OpHt1bGWeIQ+9d+20Pm4bJOtvn5?=
 =?us-ascii?Q?yULRtfgLdoIhVILIzpMeJh36fT1ZFjrXqa9IiOeMKzr/zdPgRw0lhQ7o0i9j?=
 =?us-ascii?Q?4u7B6UtAgu0Yan1zWpDxJIf2Lfq2O6bZ0s6Z2hh7RPKOkNufYixAp1EKskWr?=
 =?us-ascii?Q?LNAp/4u9WfpLkzUuFumbCKEGJCuM5q8gb4+pJvdYv19jSTaHVcla+CKIp4MC?=
 =?us-ascii?Q?wBoeKjYoMal5wqV1iQgbwq6+fjocjnAPp0k7Nt4tYrTvsMF9ExRasbA0OCax?=
 =?us-ascii?Q?Mkll1Oy/Cif0nj/Yz7CHfTiaOyX4MIb1CJLlm75oCk+C42J/VZBi8DK6ybs9?=
 =?us-ascii?Q?46keJ1OiFcC4epXcXw3/NGw48YYZG8qAzvfKR5i5pLI1kAzt9bpX9AdaLbnf?=
 =?us-ascii?Q?icLhQl0QOPrtOKmmCi/fZsDeF51AHdjjLp11CycslzjsA7RLRBsDAMOX1I/3?=
 =?us-ascii?Q?AAWCQDpeFvNW7Nb4etJax2j+2958CBgxuSvYIFRf3+jYBT1aGARFnksgIZHB?=
 =?us-ascii?Q?xA8OA2cMaDmcdkFI9n/jaPXViKVIN/UufMKbxRvsIx9dgcX8fQI+2Poemxxc?=
 =?us-ascii?Q?eaQRXNxMLDmY1u6XWZPZrVg5TiXduTdM4vvAs2Dyj2LQIqWovRPp5QsmXkEw?=
 =?us-ascii?Q?ORW0NASraVR+EvgICEILJH6p41CVF2e2lnbX6h/MG/xSPNAmQNkcNFmebVIb?=
 =?us-ascii?Q?XAEF9FP+wXgReIYOSZ6zfQ0Duk7TNwNG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:18:06.8060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059593ec-be12-42af-704f-08dc9f2ee0dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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

Enable setting speed mode using mmc dev commands.
The speed mode is provided as the last argument in these commands
(ex: mmc dev 0 0 10) and is indicated using the index from enum
bus_mode in include/mmc.h. A speed mode can be set if it is enabled
from device tree or from capabilities register

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig       | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 2 +-
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 2d611f84cd..f8df0b53e5 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 53ef81e64d..40a9b16b9c 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 915f0b993c..dc1754f6d1 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_NOWHERE=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 9be904fd30..f8b6a3f1aa 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -81,6 +81,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_MTDPARTS_SPREAD=y
 CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_CMD_UBI=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_BOARD=y
 CONFIG_OF_LIST="zynq-zc702 zynq-zc706 zynq-zc770-xm010 zynq-zc770-xm011 zynq-zc770-xm011-x16 zynq-zc770-xm012 zynq-zc770-xm013 zynq-cc108 zynq-microzed zynq-minized zynq-picozed zynq-zed zynq-zturn zynq-zturn-v5 zynq-zybo zynq-zybo-z7 zynq-dlc20-rev1.0"
 CONFIG_ENV_IS_NOWHERE=y
@@ -155,4 +156,3 @@ CONFIG_SYS_TIMER_COUNTS_DOWN=y
 CONFIG_SPL_GZIP=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_TOOLS_MKEFICAPSULE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index fa912ae3bb..1133134e3f 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -101,6 +101,7 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_MTDPARTS_SPREAD=y
 CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_CMD_UBI=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_BOARD=y
-- 
2.17.1

