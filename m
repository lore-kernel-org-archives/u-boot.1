Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AACBC83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 08:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD913822D7;
	Fri,  4 Jul 2025 10:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLCkCTpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031B182CFA; Fri,  4 Jul 2025 10:42:44 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9F2803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 10:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kovvTS/GuvcIbngFLg+hUMmpjgnaIC2ToG/MnLZUa3/X8+YfmEVRFhY7ER6B8OgWi5F+dfMUqTvXv69cmiNTI1x3GSYr1j3pGFBr67/9zdn1xq1VsHOlhsY6Ck0X2JQ58AZ1xfQ3DT+6JEplFH7OL/zRCR6Ia8eMBe0O9J/0UzH9X7Uif1+ywpzflnJIXmCTvrXXKQP8/NzWcaKI05v2XXL3m0WctCijPlpp75AqSBsnjWfFQRH76cnoh8pd+TeYcbiNMJOr8wltUtukWx/aYSSDSJaIcJ2LTviDDSIEmh+FUm+xlMJ9m2egN/RhdnvqMySAVP+pDi03aMwsCGt0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcltgjA1pR13uoYsYrkdHApc7dvt1kL/O+fUqHY33N8=;
 b=fPIBiFo7joZdFLSFXGg5Db1b7pSx5W18PpQI6AukPu8muPr35Bt1+muS/96mL9Ymp7xyAFsGu66tZlg7DI4U9Olwrq8rhxt1P53fp4KlCoChdCqeyRMsMjl1/A1r7rTh7m21AmG3PVONhgvspBLgEzB/e4llhEnK4ihUO8VhMLmiU5yopLOZ9ImqvOIZLl39J7z8zk0sMKt3AUOZtZd6deU8+AJxIrxsQkDwppqoqNxXzT5URE3Ij80GNs5okX89cNCP9hnccbuFo3BqiKAm2iv4Ibk0c+J7PwQ0rjuCAgzdu7fZtnvYyCfwT8qPLpFNi6ZCIqh2AUiSy4RD/BVAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcltgjA1pR13uoYsYrkdHApc7dvt1kL/O+fUqHY33N8=;
 b=CLCkCTpkhF2xqTTp8luK0dNxRlmg2k7dr9xsEUGGmJzT9jqFFcTJf8S49RQ/DQwLpwvLr35H7/lcLCOVmj90tnSZ+hKghoBB1D0XyqokjGsRD8m6PM+JX2enaovokenZcWvRrjWaQoGiNegeyPArL8regMB1ElR25LjSqdbyYck=
Received: from BN0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:141::10)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 08:42:37 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::73) by BN0PR07CA0010.outlook.office365.com
 (2603:10b6:408:141::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 08:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:42:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 03:42:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Jul 2025 03:42:31 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sughosh.ganu@linaro.org>, <git@amd.com>
Subject: [PATCH]  common: memtop: Update the MEM_RGN_COUNT macro to 64
Date: Fri, 4 Jul 2025 14:12:24 +0530
Message-ID: <20250704084224.675703-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c95f9e9-f2dc-4062-aaa3-08ddbad6ba94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c/WrUziPz8V3flyfvzepmsDtKJ/O7ZFKqHuVILYxCgjvijeNiRoMhKsdjSgx?=
 =?us-ascii?Q?VvdCedx0/ZW/iQkN6SXHMc9bJ/qUlz2VJfqooYHAstODw1I2HQV5vl6Sh05z?=
 =?us-ascii?Q?jb6HD+H2md0WXxB/p3pu9qZ5XjnouYO2g/66K3ZVevrZAFRcPR0y5umYtl5w?=
 =?us-ascii?Q?RBCIBWnu5SJCAnrBKS77BfrBG5Kzdtso1emlr+5IoZPv6hyfX5INxZauCRcg?=
 =?us-ascii?Q?7d2bTsVv96OXNYjpHrtFxQyYZT5uk5dgHGBxSPqNOrt0VHL0c4WTVEttA7sk?=
 =?us-ascii?Q?v4SnZxet3a0/zfoyCG4lN7pEIxX/cz7BqYL4DRyM6hwYB1AUWCdoYCdQHuAg?=
 =?us-ascii?Q?D123Bbz2hS9V2tvzjE8yiiJ0dhtNsL+2OjENRzwraqie0XlkHAmXZ2RPk5Uq?=
 =?us-ascii?Q?jbBlc/C40S5A8x5160GYE7lbrFlL2r58nz/AL9Wu/oLY1HDldawMq8i7tDd/?=
 =?us-ascii?Q?0TspV7ZvkobeZ4W2LO0AVix26Vetz040xoU8HN9rH41NWr2YOoE9lYsqscZV?=
 =?us-ascii?Q?u20PXEgJx8hkeUISi5h9Hvk/+YZ7ZbaUJrAkmz+rty7z9+D4ORAhl7EZTaN/?=
 =?us-ascii?Q?SUAmixv18SywpVELgreKxVty6eZfZ6cPCk8e8fo07XgOcvhSBHOwKGgwKuOE?=
 =?us-ascii?Q?/R+aOp87VdRx9HKv9gIIrRerQIa8CzIPrh/DsiDi4xuKQ3WPmttILDtDPVAx?=
 =?us-ascii?Q?RtvNIhqg5IHqYf/hcAPUJcVWuGilvahgZHu+36VGX/d26Atcm1nAyLDUCgBg?=
 =?us-ascii?Q?w1zIkuVWgbcaFY4AcVUju+czadGPm6WDuSZHJNK8GFd9WgjMZMsmiOO7WSN9?=
 =?us-ascii?Q?Kix1ZoH5j4aRqdi+JnKxdSJrz6EzTgTY5ilTbM+LeMF1YdD9XsVA5cRlI1os?=
 =?us-ascii?Q?/xv9pFtmGgF0nxmeYkrmZrQjQ/k8fCAR08zWexiL8/7cKdha9bl6BbS3SDNC?=
 =?us-ascii?Q?yghFRQuJJQtv1C/ZXzg2Bm6Fs3cRnJZMySkxNfq2+ibVupJ9YiLX57/G5jwt?=
 =?us-ascii?Q?HSg2vglk34iXKkTGb/O8SYf39p2LOYDFVj4+z7Ru23AxURbo0uV+eQuaJ/GU?=
 =?us-ascii?Q?w+meGa2sW9YQ+iguv+/OXPU5AVHdslJajc8mQk9bJFuG+HezQB9/MVBZcJl/?=
 =?us-ascii?Q?4fEdUKGY++ql20K1kAJmQB1TsyXbi7noD0wlv/sL61Osrg6LgwNtbnSUttDZ?=
 =?us-ascii?Q?wd/bA08pv5qYQVKc3LP2M++a8GHr3KsuBvLrWbI9Gx9Ly1drKqM1ENWbCjXb?=
 =?us-ascii?Q?yg9hfTkAFFpRyxakQroIIWRFlK5jrUoxDqVDtPh8yeyMQqaG95D/+0USL9/N?=
 =?us-ascii?Q?MIO1xpNC6xut4ySjJPrUy1NAEE9/2BuAHnVZRq/jdDb10iF1p/v1yz7QWxse?=
 =?us-ascii?Q?2bolv/9vM8sLSlVj9eLnHLlbnbiYNPB9LoplSJVouyJWYdzeBBkE0gNHnS5k?=
 =?us-ascii?Q?Q2tSa6J+KQaliType21k+kC9xtJ9i9h3tWYbM46xzlie4Qt4RRZYrjo6dX7S?=
 =?us-ascii?Q?Yx7zRwEbFTdvok0Hfne5jsG2UwpkW2RJxXPq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:42:37.2127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c95f9e9-f2dc-4062-aaa3-08ddbad6ba94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

Crashes are occurring due to the number of reserved memory regions
exceeding the current maximum limit of 16. It is recommended to
increase the supported number of memory regions to 64, as newer
platforms may utilize more reserved regions.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/memtop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/memtop.c b/common/memtop.c
index bff27d8211e..8ad394193f3 100644
--- a/common/memtop.c
+++ b/common/memtop.c
@@ -9,7 +9,7 @@
 
 #include <asm/types.h>
 
-#define MEM_RGN_COUNT	16
+#define MEM_RGN_COUNT	64
 
 struct region {
 	phys_addr_t base;
-- 
2.34.1

