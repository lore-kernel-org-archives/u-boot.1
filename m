Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083DFE77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 05:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216C180214;
	Thu, 16 Jan 2025 06:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AOZOcoU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E588033D; Thu, 16 Jan 2025 06:19:14 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9001B80040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es5mz+vyimu+uSFJyG+zlmGbwU3eA8ePG1e9D8y7VFpYpdk07p9zu44Y+GKpy6QP/ZCUdajcDElBQnJ8n/F0Rmd6alHeVlKKPIWAK3j8Bsr9v+KjdWALEN4GDQcP9gr6eow7mumdJdXkrThtaXPRyg94okdz9zh010qH7kZD8BytfFd2o2ywyj0EAK/+f+jGMbGL7AKU0gRJYyUdNOMcHOxQ4LQgAzh96sxwkS7AloN0t2tmQ2TPextiBzVlUUqadLKkahHy3QnJd8KbMyKH5lTLgOVw+9kjFny9E4fSgmDPCbCrKwnAZ7mTNnivCp+smaIq0u7BVU4e8yJNdCOIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oaYyBI1pINw4/IBziWEq/0pyrTM03NphqyhOJlk2DE=;
 b=AxLw6oda5NA8Np/wyzYd7hnZF5ihUtcQu47rN8dwcJfWMWuCgf0fK2dPIKsezNH4R7Vefnt2brhEPnI/p1inxB0L3WdBgAykXHk7t9XjUVYpLSYTO8jEPCPw1BNzwJjcx8F+ikC2YT4vgZTH7lHYKuappipQUpu22qkWK//5zK84CerUUhI+iycBkOvVHuiu8WhFBebaf7dm7sk1CP+GVpNVeSomngRd+WCALC3ERhluyzmQMD+2dy791g5JI8wGFbwWwwqRWAM9XtVPI0m+ndNbUUhsQopDsJK2XShoukxJgC1jTRTYxljXqOpDyGIzsNxtg3y81DSENVm2FuVtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oaYyBI1pINw4/IBziWEq/0pyrTM03NphqyhOJlk2DE=;
 b=AOZOcoU9rLqvbXa87WvoE59WEgT+YfjmrZQVyGtGvHoceHb+jpZmkEqk7pUuHeLDeeKgi6sRyZsKxuvGKCjRAdORwOIurXpeL0MjirEZwWv4hkY2ru70Hjy/cJvFs2oSaYA02wSsQO8xBl10mICIUq6tBSo004gWYVcIQA/7Jjc=
Received: from MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:19:07 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::a2) by MN2PR16CA0039.outlook.office365.com
 (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 05:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 05:19:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 23:19:05 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 15 Jan 2025 23:19:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH] xilinx: Enable support for Infineon Octal flashes
Date: Thu, 16 Jan 2025 10:48:57 +0530
Message-ID: <20250116051857.346921-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e1ed2b-8c07-4f0a-4239-08dd35ed4ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PFFESTpazV3gprSlbwNXupiMqcJqucHIBskyE0xeKFQPGER8TUgVwD9PPxn6?=
 =?us-ascii?Q?/zWYDuZFkivYSn4h17guPDznT/1nqFxN2VJYqeb0Z0V7SlNwOJbT1M/h+/WL?=
 =?us-ascii?Q?nmr65b71gZFwqD/HMwWeNv5AeWse1zL5mtTrDTEs9w4P3J2E3Gfr46+QJ2uO?=
 =?us-ascii?Q?I5gbxAa2hlysd9YjlR1tIarBdi+t4ZDrPGZ8DuP3IB5k4j1nDC0sJUVYyGl8?=
 =?us-ascii?Q?vUl9HQG2TAqhrwM2Kyv1uPcsPs2Dme2+GRAuQGFgM7qWXsRfnuszNMvUZ9/O?=
 =?us-ascii?Q?QvkaSoefI2VHArKlNvJM46RksGotqgYl+Z3y/HsK2yN3Xuk/hQnIJTUSQ5Xu?=
 =?us-ascii?Q?ro97XMZIJorejIoPp2sc6L0ePUBY+TyJqCylHHtGFexkzpCCQlbKOU8XuSux?=
 =?us-ascii?Q?TkJ7rvdh/tADDmcV5gLRPMyC/6sDWh/dUD7HaTe7qhiGflAxjONgOJeQN2iV?=
 =?us-ascii?Q?Yy++BxO/IeftvRVS8rwf5RNI6Q0J3GhRF50F9RwBRvxl8ErcqWdmVr/0qeuF?=
 =?us-ascii?Q?p/5yJ24yKq9AYup0UosIH8cKwHSkrOav3A3ENq5KxPbEIUGjrP8lPklU8JZE?=
 =?us-ascii?Q?5bOaQYhDo9NwOm5ojUJYaOgKeG1khHuf7V7veYa4qWGKryDARNBU/nLU5bUG?=
 =?us-ascii?Q?iMTDmveORkLCPnvqRghq4MMrqP330294jkcFKf/k1iietdwolpntnePpl3Xh?=
 =?us-ascii?Q?J53B3vkXPj13k6px6p5WIqSMUADW6y+fOcMYW2CClLaZMQE28dVsDwQqg/a0?=
 =?us-ascii?Q?F5CdWE5KI+fOJMQj5wkaM/eV1IcsedKjEON7wReDSi2gdtY6wbPMMt5t/3Ma?=
 =?us-ascii?Q?9pYfZ0OK5ah8iCIJyohdeU2CVLBFlRGk4drECJz0xAO9GjG613zL9ti8C9lI?=
 =?us-ascii?Q?GtA1LE6uhFTxfHr4xrC14HfLL5lQCL89u39c/wPzOQDmBXdITubHZNsYwZUS?=
 =?us-ascii?Q?776gAyHVPio9UBkchXlcntH+cC1oBDXJjLr76RuLdX7XwHB/wucMX8WB90WB?=
 =?us-ascii?Q?0pRZYaQY2p5e3Bm0MCRY+S+yOj7joEO1HWQZYGVvvqTwiVyGmnNQPySuzCU/?=
 =?us-ascii?Q?2jzVkmJcFRC1uyBKi/snjQD1QhJrZgFD29Zslnqfw0CyP79WkDl6SFtIMbtq?=
 =?us-ascii?Q?57+CbIEZXa+wNZIZjcLyd6SdwD5VEVsSxyym7WazSxEZQVnGsx99jMVSU3Kp?=
 =?us-ascii?Q?742j6N6r87vXOD4DYwXxRPcXfn/XRz21uqslXG4F1d1bDQlm/WivLMBbP7VW?=
 =?us-ascii?Q?m01b6I2oW4oXkjY9OJXvda3dwRtM/h7ZUUe19e64RPrprJDWPSTjY5gWvRmB?=
 =?us-ascii?Q?71tfwwCBn+nM06pHwz6GYBP6t2i4ssjn6YqWRzSxzA3AbPR5ovjrwzktOV70?=
 =?us-ascii?Q?cP1Iu9yGztFI+NXZABQphvNpU3XPe5pRsKqPcI8nOKJ47niIS8+a21tsChC4?=
 =?us-ascii?Q?nUcVyisMrBBZBWzOjJhcUzbuAQekjCKCsAfdd1Uh0dRTMxfu+mAcvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 05:19:06.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e1ed2b-8c07-4f0a-4239-08dd35ed4ce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

Added support for Infineon Octal flash components on the
Versal and Versal Net platforms.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 30d79ab8c8c..b40f7b7f855 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -102,6 +102,7 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_SST=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index fb757c1067d..ccbd33ee1cf 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -112,6 +112,7 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_SST=y
-- 
2.25.1

