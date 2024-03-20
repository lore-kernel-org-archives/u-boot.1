Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F2C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 11:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA86188010;
	Wed, 20 Mar 2024 12:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CW+gAYlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2A687FF1; Wed, 20 Mar 2024 12:24:28 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4966887FB8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 12:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd3TOhywwQ7eZYWhV/cade/afmtKtg5PBQpdzegFP2A0NRX6WDAGg5WGSK+LltfRQX8iP8Hcu18ZRnwoR0ysivhpHCkR7rYQ6yoyHxOXTBmN+R7gaQ6KrsN1QpuljI1pFp0GuC5KuiBu3jBddkHYNxh0a3sYJJYiTI8wZ8NDQ40KYySCo+NLhCVsfm1Wvy7Vj8e38EUp4BT2y2/fbH1W5GkhWivQW2h5n3KlTIYneu9yTv3Pqd2m5VgUrBmXiGrxiXkidMX+EllsluBfYtrvW62ODEmMxcaWvEJfZMXLeCuXa4TEiR90iDhJ+K87FfxDwizSfNYzA8eyohvwgz+VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Sgb9fYfFJ5e92OSQyxpKn+9B9iVikhepd/tf4it2g=;
 b=nbcXWyWLW1hdd6QoQEmK6M/4Ocu5AIXS6knFdpobxngFp1+LilyqYwRpLwSW5/32EhzGgghJ03hHwpHevX3FxF+X4BO4c3zQqf5d5doDdWN8y+wWY4L0YYSPmUAMQJuk//Vom2cGm1ChCrk7UUCCt8NXx2+qEi992eI9WKCXGSsKqv+CaBoQ50uQ5x54ePS05rwN7m4arIwxx37PDBjlJO7qhS8vR7GF1yDi3aKjbS2g8E5qdto/DD9bX/XawlWfXEO6RUgMa9GNARyv3QFEO5L7BWpr7/1w+6FguBT/jPSZdMyIjqvJ+sXxrmdTAV5syfafdWoO4CEn+oIE5oPoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Sgb9fYfFJ5e92OSQyxpKn+9B9iVikhepd/tf4it2g=;
 b=CW+gAYlXsnbgoxlSRW5A5wM6I5KcX4Zd3AYUS3LxP9afIp+lZcNexSgSxV0dMU9fW3G+ZcklvEohvfHSLY7u/xW8T7yb5KbEZ5/YwLRFZ3XJ2b8jpryPSCJ1jtF76qBJBKNxa/vlyq1bK+sNBLdUEvHyUo69wKoKVHmm3+g2YfA=
Received: from BYAPR07CA0022.namprd07.prod.outlook.com (2603:10b6:a02:bc::35)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 11:24:21 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::84) by BYAPR07CA0022.outlook.office365.com
 (2603:10b6:a02:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 11:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 11:24:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 06:24:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Add bootcmd_usb4 variable
Date: Wed, 20 Mar 2024 12:24:16 +0100
Message-ID: <cb36fe6bd1fef540441e1d8c32636ae6f80357b4.1710933852.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=b/5eYLPxQQ7Md9tSMY0X9/68oaQ+gz5qFblSJ9Hcsic=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRfx2NtDq/edMFwPeP5zXpaDZfz/1UY713Y9G7qvAcLD
 7Z6XuS42BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmoivCMD+l9sWcvSWfWBVq
 u9mXicyYZ2byNJRhQRN7vsq3RU/eMJjmPZsaoqqgn7T8LgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 30310bcc-e212-44c9-500f-08dc48d04992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pM9CCbChNDOr1SUu1fWR8IQYVdgaxLZiFzYeEVK0rp1mxuHC7HDEYrNDkELZgH/qs9k/cnEfguw6XJY5k/jcbECg7/JouGq8kTvXkpkKy18I5TeTlcdcvHpr5AJ1hQhYxkAhd1Dq2XEfVOkeCuIiftKC/jJGgFruNMfOyykRmH5CNU4lNPJClwf9NE6emJKwCbNuzOohVL+gQ3lCO16gszUjfT6wRF8k+gQ2kRrPCHCmF3ur8IjjaZZvZ9kAQCB6h4A9cpRb+B5jR5Giy8hLB/0KRgFRt2kY77z+SrbJNx30FuoyYOInh+rMCY9x5YqTYMBKHFzKIPW7pjkPG88iVOVwnhPKVmkfznX96msJGqn2tFsDIsOnquXyLGidpY/nDA1OupRn4rgf8PLepmqTClW6mgRuB4U+rBRgMQnZexuorPihq3y3lnLUk5tr9bHy+eMyRbPtayHqPSBXUfoVSMR0HfRqSDQwTrElqv1l5xbGSXBSqs+8ziTkwGY78t4hJMCQQ09bWWF4qqZ62hBWvB5Ma6N2mLtg2neskCVTl6lxG4UJTfqJcRNUCZo4oXYo2o5jeL0wEmFkqZ0B4cvzALx51up7bnrUw60VE9mAdRcGGHsd/v9RC6HKdYaKZCYePPxg0YGsTTLP7uTjbw57q7XfcckVArHGIEjmIrGRl0o++b3vP+OBjshRvAGvp1Q+eHc0fhGC9zlmZOdDqSPC5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:24:20.3084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30310bcc-e212-44c9-500f-08dc48d04992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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

From: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>

Add "bootcmd_usb4" variable to boot through usb4 device.

Signed-off-by: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

It should be the part of
https://lore.kernel.org/r/20240305110256.153308-1-venkatesh.abbarapu@amd.com
---
 board/xilinx/zynqmp/zynqmp_kria.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 7d3ad3122605..846eceb0118d 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -17,6 +17,7 @@ bootcmd_usb0=devnum=0; run usb_boot
 bootcmd_usb1=devnum=1; run usb_boot
 bootcmd_usb2=devnum=2; run usb_boot
 bootcmd_usb3=devnum=3; run usb_boot
+bootcmd_usb4=devnum=4; run usb_boot
 bootdelay=2
 bootfstype=fat
 bootm_low=0
-- 
2.36.1

