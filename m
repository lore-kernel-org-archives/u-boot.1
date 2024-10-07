Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F07CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE2888D63;
	Mon,  7 Oct 2024 06:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YNHbct5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498BF88D5D; Mon,  7 Oct 2024 06:47:25 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBE388D3A
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daWXQCxAtzvCNQSzfboopmCT7TteCt8b1PUkmj+SYMxWliomS6LznyHF4kvBwtJlYex1sMRz+Bk7iExYdr/4sdwf689+6VO+uTPKU6iaZeYiDCjKJwNFYh9HYVXVToPT8xM7mim8Vp9oviuAkVksFYaa2rZvRksFbDqHa1Lqdoj26ncsJDezLX5feTyqRz1rzSOzv4NUVkm9AtFynDv9rRIR1jGJ5HH0RhQg1nt/HFnsHIqcBarsqITrlKv6ssmYCyYr6SYkehMlr8yhxWlF4V27wHbUuKgalQ5HlBY19kk8reg7fhx8A76bB3SySkhJ4iQ5bLx6Q2jryHGAAyrVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=AYCc78xljMl3yP0wh2OxTEnMl9l/rUf2YQpOfAhvKHAOwuNwcfiXSq22D04q8RkcOp9uiXggVkLY8CybPnlyD4SbLkgAHSgxOoLH27yVDirHy13Tii87NalK1td23fVbSBhVG1hgugYSSkUDh6pyKL+t+8++pux3k3bBuL635QHlGJhJspxfFXItGTSL4rQE6bX1XiC7r5nVlmL4O+rFwEFKkqNy7LzNS/huvdoK/fVrdXfZdCvCHC2t7gPPQL+0pTNWiLQAawgrnkYQ1pBjG77JgFqafzSH6eEIrmu2k5Ob0tLv2tn4rOdtcNho9ebDdm0wcaocodnPVtLZn1Rxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=YNHbct5PPQPxJIFapDncudbUkN7vR76pBP0TCpQM07jjX6rZIfJBgVmcfNVr0tEdAwV9p+VsHWOvSdO1MDSWcNFv1wQvtRb/0M/X+6RFBpM9cc23XFXJ0ZdHAn5UfzPOfMec9I3UanW4ctT6f2W5grl0+T0wfPKvUArP4NAsb5M=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:47:19 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::30) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 04:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:47:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:21 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Mon, 7 Oct 2024 10:15:46 +0530
Message-ID: <20241007044547.23896-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: a487aead-e2dc-4a97-6e28-08dce68b1fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XWZte5ynaWFErFujDa+JrUby+qBu4cYVbuKHvnpcpM3oUPoIIpkJl5fxSOvN?=
 =?us-ascii?Q?uFc4sHWFQas4s9T6Orhyecq+4SabARgXVc8ZM2IbjLv2XJEk0fe0abHGV11g?=
 =?us-ascii?Q?Af+L7gYxY9BQ/VsfSqX21fe/Lpr6/LRJR597ZW8M0x8tAMm7tfoECKfSX89o?=
 =?us-ascii?Q?gPkWk8Z7NwJ+rW71qOyP318boVdjdHDde/uSXwck17dWQVQCr6fYqiS2uPJc?=
 =?us-ascii?Q?e7EN9qCI042T5s6qZi36+xnHhu/G9sNSjTpwEZCPXHraXBQ5yTcz7gv0BL4m?=
 =?us-ascii?Q?YPavjVKrnCC4b3yrIRA0nqE47m3eboCXOvAB56ro4JtRUJaKBsKbZ55eRUUf?=
 =?us-ascii?Q?qs+HojbhMgEhogKbvwvStVknqs3Bq8Mvl6JZXVWC4ahWekzDZfR3EjGPZgGe?=
 =?us-ascii?Q?ic3AUOExfhQBneTXtQtUBqZxOMGw+OkyZi5Jus4uuEttH10GqnXZxNtNl6bB?=
 =?us-ascii?Q?wYu3NrEsaQon/9paXdm0VVCkLy93hWobwCgrWdC/a0qLg43+gSucd3olN93f?=
 =?us-ascii?Q?FlGnyrOqLIU/eYrh9b2W6RFPFE8sKlGXxtplxq2ZeZRkmO5sb4APRpIM3SlH?=
 =?us-ascii?Q?3/tEGA7mbHG4OAuD5S39OxLG1dcXjZuZ7A9b4fT9faCgBVNT9FvAJ769TAu0?=
 =?us-ascii?Q?g1Jy1X2EevBR16lEU4bQeND9AsngSAwMXXl6182wpewY9PK7kpHo/P2yN7Oo?=
 =?us-ascii?Q?0bSOZ4Y1ivYQrikMZpjACa29PSt+sYPMmxMXIaQEfrX2pp+BNa/JytwtgMlk?=
 =?us-ascii?Q?DLSdSuL8rlTHPVICUut+CfB74bgcEHqjKR3EeEG2Xf945NccXP/1QpYcLcLe?=
 =?us-ascii?Q?JDFzh+x+jV9Kv5PBmdau2x8C+kFe6dKPzlwipOOVmcVQCzyc45n5VUSdo4ut?=
 =?us-ascii?Q?qt219gM7kxc5JHCfiM4LJmUo4eD/ap5z6iTjRLmm6yHCPYBzu3W0fe7rHZ/2?=
 =?us-ascii?Q?Ngfsof7Er9ePksTV2oNPJ6x+l5pPPiQHCma/a2B5V+xZ5q/gsyX4npT+9T1q?=
 =?us-ascii?Q?4gGrt/3SfrYbDs4UGROL3Pj3p7OlQIzk3XfjX7qjJowwcJFuU+trj/VjBhai?=
 =?us-ascii?Q?V7QqxO6Dgo5MMyR7KJYOm9obzwcWVpfOCmAgR1SrBw8xJeYTAi81+5C79hZk?=
 =?us-ascii?Q?T3TrEn7ylFIA2O96SDIUavQXemjri8EvY0v+tW3nLU5drfGKb0no+SnwtAcL?=
 =?us-ascii?Q?2+veNv+uZztfON/ojYR/BUg8WbUnsr4Iwf4DD51cgVkA99A3UPFw31v8l6tU?=
 =?us-ascii?Q?CHX2wxZyAHEApa18xRKz7GqaV9F6t0STfsmtoe9JPgOSnHw3K0AoC7X/HxHZ?=
 =?us-ascii?Q?6+bSOMWul8gsiQLPWZjH1/+Q0lro5/cVWPCh7SYPygZ0DlwW4MGeskbvpL2A?=
 =?us-ascii?Q?0hcRpqQBZU9fIwnO+AU9tVe9gdKX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:47:18.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a487aead-e2dc-4a97-6e28-08dce68b1fd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5a07edf5cd..4f0199f099 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -29,6 +29,11 @@ CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
@@ -204,6 +209,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
@@ -223,8 +229,3 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_HTTP_BOOT=y
-- 
2.17.1

