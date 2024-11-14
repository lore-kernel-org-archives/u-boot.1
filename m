Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5416D41C3B
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 05:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3319B895A9;
	Thu, 14 Nov 2024 06:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bm9vq5gV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E870895BE; Thu, 14 Nov 2024 06:16:04 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C33288ECB
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR5NvJHoKnHMH/3IiGcAEoZ7UJId7XFgY9uWk12jhevpqwYnHdwpq1mQo5/snTxYbe5XRXoivZG+RNc9WfrB4/doF51tpv6G8TCBzJca6HzBFjtcJ/plg0MxtCMRTz1nY4ha5M3FclhggsFgcKzFrGxN2L2Is9QGr2KfN9gSxYYi4mz/LQQe1Vi7PBwcepmWIr5D2Ag7o8Fl9Hp0Me6oFvBOKONU8o/I9d88qoKorKcP7ivXgWSo8H3+0SaO6vAiyvdqbhvZZjDSvjewLqlB78q+NnS3/bOL/0DTWPI1P6nRABi2swS0B9S5COtvwllBDbOUM3XA/7TU5E6kFYIpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a4zTiCHeBKXLaHnMxvASoXOHE2CDUPg82fXCvDazuc=;
 b=PsXEeNPLANZ5+RNESWWA+B7srIsuTtfqjhDnsz/O0QM7kFnBtuI9SvU8P/wquaDsxqUejvHwJDOIfxQoSqs+ux/oUynukslja1WJOzMjSk6Tg5E5JFfFJqebI3u4ajEmKpENLbWsSj/pizCPe6uhTUS2mg7m6oXGaOXAjc6xYMQ6eIL35fGOgALtbA21B18L6BdDpeyo6Ykg6OGE5WePr62RXUsZgM4BHzp8gCi8AiHIgnYRDGzDW5aEoSdkP7ExHxDZGInLPUyT3ylT2nEfgg7Z/5t6Jr3vZTdoy4sUYPGgB0lUNLl2sgrJzhEFzwsx07OLrVKWB7EuU0u7opO5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a4zTiCHeBKXLaHnMxvASoXOHE2CDUPg82fXCvDazuc=;
 b=bm9vq5gVx06hRWPN2M0YfwCAm9Om9c8DSMr031okONxAYMrVFpYwiLk7OfHsiv56/a5Ggr+FwewcVW1aQOQPLJb5TRPfFYN53UowCSCmadK7cWbCXM8cax2wEE0fbvbWfPLcN3cNcEeOERHJXpZHqg/AeiDTwCAOC9aRieb6hH4=
Received: from PH7P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::33)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 05:15:59 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::f8) by PH7P220CA0033.outlook.office365.com
 (2603:10b6:510:32b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 05:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 05:15:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 23:15:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 23:15:56 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 23:15:54 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH] cadence_qspi: Update the delays for flash reset
Date: Thu, 14 Nov 2024 10:45:47 +0530
Message-ID: <20241114051547.13940-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a8ec67-c824-490e-de23-08dd046b6c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dsZvGJyOSAabhI0J7yU1Bk2u1S65uKa307Udu2TyxTi3NVbrZ7+hcEsFUBJQ?=
 =?us-ascii?Q?3eUWBCtwDsI7S3UlFvdMOyn47tDFBshUl6oeYk+fiv34AEtzAm3oD6DpHUVN?=
 =?us-ascii?Q?NSyguitxeeXeSu7NNmhdM/98sIYIUB9Y2+l1cZoRaLuKDcOF/OdOXv6f3ULW?=
 =?us-ascii?Q?5wV+5xAJACIXR0E90KSGqenmBNlYldEadNb3Bp1fTfV9yaCIVSx9tUM1eqv+?=
 =?us-ascii?Q?lIqDBaDT+hS77wgRCgR+fKmiLzDMozxoWAOm6IZx6eArEFuDXCL05c7BWmBP?=
 =?us-ascii?Q?BnvVSvIwyZOGS9ceZpEDVFdU5mYTYe4ASEtRzsIug037gTzZGNogzTuw5rWR?=
 =?us-ascii?Q?XpdTKNAQ3JaDeIj8CdtfNgzEWWaGCLU6TcuS1wIEiLu3AF/XoZhLtKp9/4jw?=
 =?us-ascii?Q?Q1hmKo3Y4d1Nlli2VS+yFVaXP0E4n/ClKROSuAs9PHMEYDW2yp3rLAY5UDna?=
 =?us-ascii?Q?rNhUtDLRLsLtTN4FZ0Wu9N9kaDgBR8UE5liq1q5Rv3nA9fgvv0W3l6nlL8s5?=
 =?us-ascii?Q?mKKO3MZjk3cCHXPBelexx9Gw/jOGwyJjJBbimDJ4ai/BSXJSsJbJJO35fEOy?=
 =?us-ascii?Q?8bQDEZq29/3nzj996thoxDXkTNCzKmJTB6QtCJEIEIrq29coPvma5F0P9ipR?=
 =?us-ascii?Q?/+nKJXOYUb2abEC1/J0F0X7Id3nC8hOUlv2ig1MtRGO0Y2BBXoVjVnxHZ0lo?=
 =?us-ascii?Q?Hb51+hzVAyvRQqXZjsQmZc2z5EvU6GEY/dWPOZ8GrimUQvXU++/LvY1A+/FU?=
 =?us-ascii?Q?nVOe+0tl8kQ9LIY/5G3TqN7j8vFzjLZMDe9pDeWsz1ehM+kVxHIh2cz2jmSR?=
 =?us-ascii?Q?WB3ThXXof5PshLh16KH7RTAuhRvzn9bkLIrDoRJ+wzv/BlYFl945JLRXSy/C?=
 =?us-ascii?Q?DYK0DNl9h39pmu8E/aodtukd+8bdMqgQnfbSYndE16efOGZeyvhq8bIW7zIK?=
 =?us-ascii?Q?Yb87lC0VEGJkVmKuvJD6LbzJXvKi/5tWmIhPsLlQimtcdpNki1qqNjbWJboB?=
 =?us-ascii?Q?Rw4bma+oNfFwAHz4AzNX+AyeN0VjrbFZhhUfr3cgCI6UjSryYSuTJKi1x/Jx?=
 =?us-ascii?Q?24T2jT04GS/esPPVoaLqH9Jo+HEVS27sTGH0FM78HH+6yUWNoLqwcnFRXWo4?=
 =?us-ascii?Q?SG3HL/JFdfajwUtspu8DVyvRCkPPl6ejs29Vdug9G5p5nOXFd6yPeLizb9Wj?=
 =?us-ascii?Q?pWxZO/DaUk0Rc2F4a1VmClKMvzmoKQej0gk+Xg45gFfX0t9/ciM+Dem1uYLW?=
 =?us-ascii?Q?N/Ecmb0rhyHsRPZEyF90IZmiIqmlYfNd144DqDuUEkOukRS86k2F8Hcsa2YI?=
 =?us-ascii?Q?wTS9l9ef6tgCR7Gci5odSuqXskKxhjo9ZhMmB3xF+JrtAdXOFdkSn31rIXsR?=
 =?us-ascii?Q?KDhv6MnsX0wJm2Q4EBzILefGORknNSR2JG+8opVqSYutUlxCdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:15:58.1386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a8ec67-c824-490e-de23-08dd046b6c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

Updating the delays for flash reset in the mini u-boot case.
These experimental delay values by looking at different flash device
vendors datasheets.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 222f828f54..05ddaf5858 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -197,15 +197,15 @@ int cadence_qspi_versal_flash_reset(struct udevice *dev)
 
 	/* Disable Tri-state */
 	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
-	udelay(1);
+	udelay(5);
 
 	/* Set value 0 to pin */
 	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(10);
+	udelay(150);
 
 	/* Set value 1 to pin */
 	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(10);
+	udelay(1200);
 
 	return 0;
 }
-- 
2.17.1

