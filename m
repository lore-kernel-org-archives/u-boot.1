Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96339C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0231B883AD;
	Thu, 11 Jul 2024 18:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rt4D23Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6A4883CE; Thu, 11 Jul 2024 18:59:11 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABB4883A4
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa36C7FOgvB9cmHMqenzEC78/Gd8+VxUgm4o6DdP2iEdyib26fCc7MRzj4phLdT2HS3IpnNVJo8PLeWBWangZ1l7y9f50/UxAX1z16BPLMmtXJCZdiuMctIzWMjSO5jVK8FtNH1kuYke8Brf/3J3PBl2Y3ozur4SzxpoVB+zaq3hFO+61MAFRsdJqS7ywCFW3KnjEJa5bVFhbQlUIX/0sxJ8FC7qsiQHOghtp7eKBrviTEGZYAGliF9TOA4PXjJYjoSDEiYZnTLu4ZtvcB762G/oiA1x0hKq85beTJ8JfMdgwXnE2TOXgXvHWdBs00Ln+H9n14T/WA5+9Qa5b0TYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZZCv/6oQ3zn4QTciBT4tqLuf0Bwr7tWbENuF80A3m8=;
 b=MRG/ucvIz0PFY8OdFzrmCJGvTaQFrZwJD5quunL9j+kTrQxCYwEOmADVf2CtiaQthaX+9RFppzjev7bzYezJ12+Wz0zNrTT2XlsdBE7KamjoukwHvdhc7onn1QnA1LX/J4eGL5PlutN6tCIcEYHNh8RnrZfiAx6buU3jCBkeeHtk8SddRxFEjLMKr2D3r+v5vsZx+5zxZ8KxhlTwHbo0mBZ2aNgsiyJxEvtN9MbN0PQRN0lKDWrEe8+Zyd92Txy5t+CGPkOd/8Zyyg6c2v5YWU1kPXXe8UjH3WMQ39WaaGmo1gIAoi6fM7YN0w+cr7WaMuWiMy7Fh/XkvQikuWnL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZZCv/6oQ3zn4QTciBT4tqLuf0Bwr7tWbENuF80A3m8=;
 b=rt4D23DgwbM23O3zOJV7zPinJDBlAmOG1jWJ1w4e+tIFbdzhEnGjXIXmzLieUZVcV4QiiX4grd7NmAWlRrSd0Ez3X2Ewdc9d/gcNBMeplGZQSwYH6JJ0D1kFb1s4YppzZow3pkiId21bX91Fa8w4RMoExsDtFpagTcZTt808cAM=
Received: from BN9PR03CA0801.namprd03.prod.outlook.com (2603:10b6:408:13f::26)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 16:59:04 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::f8) by BN9PR03CA0801.outlook.office365.com
 (2603:10b6:408:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Thu, 11 Jul 2024 16:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:59:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:58:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:58:48 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 11 Jul 2024 11:58:46 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH v2] amd: Enable the NFS command for Versal Gen 2
Date: Thu, 11 Jul 2024 22:27:35 +0530
Message-ID: <20240711165734.1561933-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5ad148-0698-4207-5782-08dca1cac517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBdOS6CxFNBTQ4VpEBanuz0rm5vGuAHa4SNi4ehLpP7nXT/5EsqswJdyPCMr?=
 =?us-ascii?Q?QEou9NcwQ+CY8nmbH+MaQygU2ZESp2hnN2HX0a6lurJ+J5P2Xx2aWq1+nE45?=
 =?us-ascii?Q?PLrh170fp+M41D6I4Foi5Gi9QshBnLZnX2e87Ja7yUxGVgh2r6xnCJ+ngTQA?=
 =?us-ascii?Q?88m7eY4tMzYWwAAiZNZGrZk659sbwkq3Q+P1ITXmw+BgPwdG/33BQxYUaAMU?=
 =?us-ascii?Q?0F0NB8z9ighQBHOQXwkds8Pf6V8NmwH+Wnido8z4uAuPbzucUW17I0aP6kaL?=
 =?us-ascii?Q?dlEoCasP2mv7+BydvYVp6SbWc6BpNxmoTmsQTKd6EaYcZ6MXjoPTuQnX5FNx?=
 =?us-ascii?Q?5xsVa2RstdwCVDpZGDzaLY5Rx7umsRJEjWdzuE9VmAwhFgPNJK70ud7kAwZc?=
 =?us-ascii?Q?sboTZgBkBeXkOz8z/MEIp4o2Vwf8iokB2CDYYy+XvfQx323BKAOYGA5zCeg9?=
 =?us-ascii?Q?LjsY460KZC0zJ2wcpVygflyigwVmet3LcWBRzGW+kdUL/Njsk5TCcZBECfuw?=
 =?us-ascii?Q?SQ+++xcWu9kZ/mmKKN+qU5FsJ7TtObKOiILBwDQrJAaJax/4PgivGmEG5DbF?=
 =?us-ascii?Q?niQSrmur662fMHrKIoPA9sbS152mQS25zctxxxbgKXcungJKaTlL1vLj6YYu?=
 =?us-ascii?Q?nygDwHLUem52/fSwuOyJyxdvYTfoWf5E+vuJsoZqOGeTbFhS+Tdexd+vBAbz?=
 =?us-ascii?Q?pDFe3a0128hEbuxQHAd+wexMS+z3HgH/66HZEAc/cpTCe8ImpWAE4Mr6oU85?=
 =?us-ascii?Q?Uty48Cugb73hXze4UtZGCDgSbKbPbdJrjg0JSdT8K3kSnf/YRKwHZXQp2Ce+?=
 =?us-ascii?Q?b+kFdRQQFaoR5W26uiWmaHHJRHHCzbopOYd47Q5jDQ82/LVtT7AvVpNilyFp?=
 =?us-ascii?Q?61aLoQ9kZ71Ozr/bfcOIxOXaFm2qz2EFg0b27vXQ4uSuMClzVe0P3EXza+Sr?=
 =?us-ascii?Q?40WElqBt0ndxKdYSREkCwFegFJynJd8IMryjgna/CT5due96pKihLNm0ce+g?=
 =?us-ascii?Q?SDMPJ/JtAswv51uemmR1KM+6miBvBij+QUE90P23YvGJ8wUMKjxsT3kNPwFo?=
 =?us-ascii?Q?A/ruA6jANm2MJSYtGn6uXY9cZNR6q/umypA1bHdkwvVN0TIeF+g7A8IVgQFt?=
 =?us-ascii?Q?CiYaELdUwGNdC39Uegl5WZlgqp9SEj97w5pfjuTAae2XSO5aEHgK6Dj5aGe0?=
 =?us-ascii?Q?3GZ5FG0aHoywZA1a9MKauNPs6xgDZtkBwF6bVk8mN3Lh8uQ5jeKQnLeE7nNu?=
 =?us-ascii?Q?OF1SmOcYZW0Y0ZEmVunmGiwugSXvAswT/1y+eVV3ML4aB5IB3afdHZYELrue?=
 =?us-ascii?Q?KoSvKhmTuiw1KXzqXDaoBsJ/GGdD5aOvAAl7erux+U3y86b/BtMgHBZY4URy?=
 =?us-ascii?Q?TrD+T3nKWG9qD0cA7M0KDf2yJfc8/58IRxuiJIgV4MBf4P47t4Bgu7WzWS/p?=
 =?us-ascii?Q?mzBEQp0G6JZAeT6ZzHJspkjp0/LaLCeh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:59:03.9374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ad148-0698-4207-5782-08dca1cac517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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

Enabled the default utilization of the NFS command on Versal Gen 2
platform to facilitate booting images through the network using
the NFS protocol

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
Changes in v2:
- corrected commit description.

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 2d611f84cd..bbe7db4fb3 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
-- 
2.25.1

