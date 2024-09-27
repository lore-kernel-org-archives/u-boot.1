Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E39CCEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F118F89094;
	Fri, 27 Sep 2024 09:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KF8WQe1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C94D8907B; Fri, 27 Sep 2024 09:01:49 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960BF89079
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD4pBuw6GuWAQ1DeGY0bUKFbhZlYg+iZ9dGt8FSjTYPr/W/+54Y+cJsbbl+FDuLh3oxy5dYIM3QC52rAdHPpOrSwLAss9SlRmLYBfY2mFCNfp9ZeuPGX6hegmDtQVfLcID51/JVXijch241DzY00FzYk/R8Z4wiLkcswyyE54Hn9OJyy2WTo3cmeJ1J4h7TaWIgxTtnUu8l8nxBBBj04+IJkjS7iUMt2m1+o9KiY4FhmD8sQOXXxlnVQkWP1fUTAPIYKpnF8NYK8+u1Z71D2bXoAb//SdwnYpXdu2dV9Y1dcdki3zgrXEJgq3qs4m8uUcnqy58TTpNdFc/9QMoB/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F41p4o8ZriZlTJSrhqdl3wD1bPE6VgsXNZn/GvGNYQ=;
 b=Rw5eOEzSz/WQc+hZz6d3pdTeoOxJOk5TmrHSGnK96aL103z2PdIN+eg2zwNSfC6FAPTA3sc7xhKmJUOFGIb5gO53zucBukO8oFRaeW342w87t2ihItOPEl1Eq/jYLF4Q6hP96MeteJ2YLoiJKKhpR9SfwGhlZU/p1dtxwEMHhufOTNbmbS1DCsLJTmeSLxtQcU1NRGq7Ym84XCBDn97N5hrmRayTY2JTNbcRrGvDydGHQeA86X1EDoERBMvT2lWZkUsG5UciOMagOdBkTWNMPEZ1I1sZYGkXgZOUegaUvhSZnMeUTnBTnNIAmTkp6Wz/qGXWCu5cWbxJOUnYx4cHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F41p4o8ZriZlTJSrhqdl3wD1bPE6VgsXNZn/GvGNYQ=;
 b=KF8WQe1j9lovtplA732LTH40IwuPOku3r519XDkyOrD6SzYAPhZnB0UPn/uUbzueOJu9S0vSI8O8nilVRB09/ELNAFa8U9rCwnZvm1s4HyXkzMRcvvRgaQUtXT4p+wJ6VKYXQA7GmesNblLI2A4DorydvYPNp5flLAd9BI+1v4o=
Received: from MN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:208:530::18)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 07:01:42 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::a0) by MN0PR02CA0023.outlook.office365.com
 (2603:10b6:208:530::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:39 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Fri, 27 Sep 2024 12:31:33 +0530
Message-ID: <20240927070137.21816-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 535e5786-61dc-4cfd-485a-08dcdec23e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tXaLaQFufobvkT23ZtCQZ4g4zHKj1kpNTXhSeax2fpU1tlQyRkYSuq2rLWoi?=
 =?us-ascii?Q?WBIs9UqhYGX4pe3ejFf/oXx9fc7AeI9ayiGWLVe9/ZBU7aJOU6jgyq9kBoY+?=
 =?us-ascii?Q?FsVrWFuKKqsedJlO+TJnErhl1SukIOPfadnMEviEfBxMCBHZl/WlMMMHGX/K?=
 =?us-ascii?Q?pc6C7aIDGP/t/q71PtapbnxvRmezcAP5Bk3tpl4M+gQbna18ZXgPx0oq+6wg?=
 =?us-ascii?Q?CynwGpsJh7DzJzT7BBrtFVQ6cqhwIbHtGKWBFz0qKc+jqioPnNUsStIWixkR?=
 =?us-ascii?Q?brnePI5UKpeGXHFIo95W0K/HfRwu5zTbv+v/9Vu4tuznfpot6KFUlpkEBwDB?=
 =?us-ascii?Q?g5ucOf4fTkcW9a3XGNnZsRdlbD9KWqqyPZTgANpEU/oUfER7QZM6+IqWkXdk?=
 =?us-ascii?Q?XXxx8c/HaO4LkMOB+KlD69JVeziwTbFB8ZYvzLZSgco/SLcwn92J0OZ8fpTA?=
 =?us-ascii?Q?Ts+BAEc1PUq1QX984e/kx483m7OvgMYHgqKQ50MiXhySkQ4Sk0mNnmpkVO3l?=
 =?us-ascii?Q?b49H53mBFlyhEEAJc8xJSXlupmue7MSMo55RiCj5ezjEMLk5BRoVvo6w8sOi?=
 =?us-ascii?Q?vSME+Qqx25J9GNPveDmbkA6TgoR+GnCRGv96hAvn5z3JXZExY16TUeYGZtsk?=
 =?us-ascii?Q?lUsC056gXMSBZWx3jO781fWd1j0UVLdMeYDVzJtjMD2+JeTO87Ei5idOxj3+?=
 =?us-ascii?Q?SUXsZ7DSiK59c3LJStTHBU1WZZJzEryjZvc8VnVSHZMgZlLmBD5o2pZyB3FS?=
 =?us-ascii?Q?oTMiDfmkSupApoIczEd9gZss9WVZHrRN9QzFlhyzYKMW61PJaln2XDve9Pat?=
 =?us-ascii?Q?0K/jeCfu1hRC71RuGjD0WKWgsw/lkdWPCU4UIKbrZI6gqiL3ryJFrFDuJnt4?=
 =?us-ascii?Q?BYKFL/MYMdCWvltlSTvjOXuOOQspDInQQ8MiX2ymTKRhJLg5Tkuwy2yzLzOP?=
 =?us-ascii?Q?P4h0z5lHVu0eu+J0iPd9U9jGKljuCd3shpzdL5YuhWrsYWxOY9bBMRgrzHAn?=
 =?us-ascii?Q?Gyv1aWfHsgizmMeE9QuNxlnwZZC5GFwuoatM88SXi6AFPMqs4gv/c8kYGnUp?=
 =?us-ascii?Q?mfwlY8Kz1DH6h8hyIsduyMlDOKFpcjbWucVsCIn4OGCMN+pPiNQUN0ELVvX1?=
 =?us-ascii?Q?fQBa3revdbIYu4qXWJ2e+XhbbHvNvPSf0OYjGOTewjNdRcU3vNh5LAXxUFiT?=
 =?us-ascii?Q?by13xBRUoNql6tO8q23tIadwGlLPBYioPHJqBmOEJjV3reV6ZZ0Y/HZnHcM4?=
 =?us-ascii?Q?LRQX11VM8srpm6rvDtnWc/j12dfDpxc16bO1HHClHc8l6NvaXTdYNE01/zFz?=
 =?us-ascii?Q?CVOpTN/+GOsmRgt8jydLzQu3PEQ8inFy+OcEyV9d6ycIjiSxdS9pXT+OAh4o?=
 =?us-ascii?Q?j0s6jP7EGZEJN03KlPyL1YTZtMq5wLvsy1+UznvEH5zHbxhIdC9j5YHZ5Gdi?=
 =?us-ascii?Q?5t1GdcuKUbLWILSM7btyefLnDMxOdTBC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:42.4501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535e5786-61dc-4cfd-485a-08dcdec23e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
The usb5744 driver trigger hub reset signal after soft reset.
The usb5744 hub need to reset after the phy initialization,
which toggles the gpio.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index a9fc9bba87..8319144d10 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -82,10 +82,22 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb5744_data = {
+	.reset_us = 10000,
+	.power_on_delay_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{ 	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
+        }
+
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

