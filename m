Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20766C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0696839CA;
	Thu, 10 Apr 2025 09:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TWSIEL6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DCB839D6; Thu, 10 Apr 2025 09:38:40 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DF7830E4
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbQpwlIHmAwZSGxwV3XQqEe/6d9UUhyTJFSGbieD9j4NWtxX/SwQSgQkkRQbQzamaMTH+Phwd+K6ksqjEnt3IyDiLOcOd7L3fE/WeQUYQ/069N8chYXPRbt6Iy8t5wMCNFoREnrMAzQFe8zLCYU3VZYPkzchJ0Wbni9Cyxw6UnHzDjcKOEaCgFfWjlhH8pfY3c/95L1WOrX/qto5Y/JKcE+vPkxRsgCxrLWSzS3GzAZuU4cDhnCJMYsTzJuxgWiRGwxTMVQ4Rh78E58HTC7An0nwvftOxNhsRIvM8y3jFBc1F+FYgTRYPikGLlLB/t1kywSUcHn9ydI8mFHXFbdIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2LTP+rInQIaA0elkDqTWDEy3lTVqXNjikIcw0sGw14=;
 b=oaojrPNV9o1wp77DjNkGBCaNn9eHpPGQtvsRpRupFhPOInYVK2c/BNix2m+cdyd02a3C5JimAyKJpEyPrtt7nWCyxxFhz1OeUBm6CHVbp61RcBZc05yXRrUa3RmoxzJxBJU+pJhgIojVu+W8ZaIzRjwEeYUmAKejMRBgQrAskYqdJYdfpyx45IAViUp4qLCtonQ2Yvj6NqRjB5dCnqvf2Cv1NtpNe6D5pR9qiviHxHS4gyTKM8hwmP1KHPokcVH9IYZsZWI5lD5DAkBvj8r4amnHkd/itEwxCiCS8Wb/Au2PseMQ8Y+7QE4uW2HDEtom6cEMgPcKIHhSXidXf9RAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2LTP+rInQIaA0elkDqTWDEy3lTVqXNjikIcw0sGw14=;
 b=TWSIEL6TqJqua8UMl28RftOiK8VD7j1O4KD1IVIOcTepGEylm1QvDlagA/95q/S2ZVDhOvBo0BSPJmPnAf4jIXR+r7z5oUIfLkIh0aLJzdD/jnJS4TQDSlAG6oFIfp1O5ktMeUBmdTZgekh3i1S4Yiu/bxkwPFVJF0mxglhjzIU=
Received: from DS7PR07CA0022.namprd07.prod.outlook.com (2603:10b6:5:3af::24)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.37; Thu, 10 Apr
 2025 07:38:33 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::3) by DS7PR07CA0022.outlook.office365.com
 (2603:10b6:5:3af::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 07:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:38:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:38:29 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 02:38:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Padmarao Begari <padmarao.begari@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Srinivas Goud <srinivas.goud@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Remove UARTLITE from defconfigs
Date: Thu, 10 Apr 2025 09:38:20 +0200
Message-ID: <86b100692101089dd8d9a8eed45461e8855384bc.1744270698.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f10774-1ead-466c-cee2-08dd7802b23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DsxOfJn3G4S2Rk+LaawbQb5NGpfNByhurYeATKvAATJrC6nrN6OKrGvLusA5?=
 =?us-ascii?Q?ohJdSdbPeYqazhTrz5BUJAsY3xN6ZBHmKpFp0u1acQvTE6SNakoHafPRNZyL?=
 =?us-ascii?Q?gNYKhqBm8lvhkbAKH9p4AB2ervsD0zw++4I7GBSTiNnMjUhLr/vchn045ntx?=
 =?us-ascii?Q?YN8i3RQK8We0yUrZjZdpNITdRPe+d7Q/ssxauE37wrEbo+v9bryiRRfEIj+d?=
 =?us-ascii?Q?C/8etFMoc+dW+lL75brSqU76NQ8qrKTXZSUzFjcveW09Dlm/CEP5Qp4nhKZk?=
 =?us-ascii?Q?k2/THR9N+AT4gxAKf8BYzTC4N9670WGoccdVfcwAXz1sMxc2wZ+Z1TYvo7an?=
 =?us-ascii?Q?pMhwtB9SnooLWNSP+YETlGY+RM7BuysNepuzz2XUA/13elBkqlGqcq6BdLLA?=
 =?us-ascii?Q?P0hGzstDzepeH2NYCdxsL9icv5Zec37uXQlH22z/4yYRZnjBuBQE1ZT8Dexe?=
 =?us-ascii?Q?ZR72VwYmL5Y/NJHEUaFj97edXZ5G8lrHKWf5q3iscNRmi2K+BTg7Vkgl+BKJ?=
 =?us-ascii?Q?2qTR+fTjtYAtMGsaQDl/LwA5sZCmQ9c2+B5IBVTMScDDNlOWqMM/4FQkgjFg?=
 =?us-ascii?Q?FP58tOC5CRXn+s87A85UfAZrHLrskMYm7KCpMfoNmmdeVPClE3JGLYYXjXGw?=
 =?us-ascii?Q?nAS5fXNpWQAHq3q8PO5ziiAvMBcJ9i3V6h4y/3JJIYJP9zVhvvkf7SLAqfx8?=
 =?us-ascii?Q?Cx47MYoA+Jh5wHtNm/6A/poe3DRUqMivglwX3fxSoE77sg+Pe7Tio6NGpqNp?=
 =?us-ascii?Q?g7Xgrgj6JLAHvcIN6uJWzzad4RVJMUF3SMwcitt7HqD48fpY6IKyaLD5NAGP?=
 =?us-ascii?Q?mdUuOQX9+ZH5vidbF/hqsEcYj9CqbYNKvyM6fKXgJHevqZ3y7r7Q0s8Rx1m0?=
 =?us-ascii?Q?b+OGiuA21iZlwIT3C3TGhMOa53h7aPJ/qOstb1KI6UjkuGBB79KzoOVjyOzG?=
 =?us-ascii?Q?YvhICveFHBsIIIZeppAfmdow/0FwiRW0sD9DSoKfw9lghm+x/a1saq9zKQkc?=
 =?us-ascii?Q?MCIQ5ybPteWulOpxMFTB78yX3QqAB7Qp8k0iypiFRqohnCC0zOU3VIPvsux2?=
 =?us-ascii?Q?c5uh8sqjcKTE9u4l6/2DPktsOqxgidVYxUjHg2TTeEbHonmEvCes/v8jQtdC?=
 =?us-ascii?Q?fbhPion9NHCxgwkUZmruIArlll6Uz/0yna8/l2A0CSnDQzMmMIRTKylylt7J?=
 =?us-ascii?Q?cr3wCNyDdkRUt2U+vwqWIYcXPtQ7RmDKujjl2Ro1F11X5J0selrzcWgZqPJw?=
 =?us-ascii?Q?xZ+cpSKZcVvQXmT6zJXw/0Uwsr4s3Hww8ARnmWA3PpBHfBXLOVyJYfyxMmvQ?=
 =?us-ascii?Q?CkvfdGBdVLW3zxRttaGTeaPfEKeOCSVQvdoXb/dLGMHkAvoIvoXLBPb/V1r+?=
 =?us-ascii?Q?DBlWXY3hCRD8Zg9eCVZHAAQFbDWXSFVBNOAxXqIFl3SaMRcoPeb2rW35E5Yh?=
 =?us-ascii?Q?FA6g52PfPIfwC79+eueQCaUF28B0E3fnU8m3XvW6Og8BDfA9+Bk9I45bzVfj?=
 =?us-ascii?Q?IAko5ymYX7DXx1qR8X4t32o/6ZLXncuAczG0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:38:33.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f10774-1ead-466c-cee2-08dd7802b23f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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

Remove uartlite serial driver from defconfigs because is not tested or used
on ARM based platform as console.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_net_virt_defconfig | 1 -
 configs/xilinx_versal_virt_defconfig     | 1 -
 configs/xilinx_zynqmp_kria_defconfig     | 1 -
 configs/xilinx_zynqmp_virt_defconfig     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 4da31b5c1194..49dc9bb5c4d3 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -123,7 +123,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
-CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_XILINX_VERSAL_NET=y
 CONFIG_SPI=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index baa4b8e412ea..ba4519ce3037 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -133,7 +133,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
-CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_XILINX_VERSAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 16cd8c3921c6..ae79f1017013 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -187,7 +187,6 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_ZYNQMP=y
 CONFIG_SCSI=y
 CONFIG_ARM_DCC=y
-CONFIG_XILINX_UARTLITE=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index abd1e1bb574b..29aa5891b230 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -199,7 +199,6 @@ CONFIG_RTC_EMULATION=y
 CONFIG_RTC_ZYNQMP=y
 CONFIG_SCSI=y
 CONFIG_ARM_DCC=y
-CONFIG_XILINX_UARTLITE=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
-- 
2.43.0

