Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC42CF855C
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C93891C3;
	Thu,  3 Oct 2024 08:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3N9zfiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3A8891BD; Thu,  3 Oct 2024 08:29:15 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311EE891C3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKg/nnZ8GFC4inf3+r49LiqbW8F+wGcs5k3qEg/vDaKhhWt7YCYYe7qNIgVk2Ckjtd3M+g/3GRP6GIyZ5y7WWcbthYBeYXiiOomU1Pwfpl4T2DlsbUjIIyFqEhI+hYSjtr3I5GK9fyNVp37UgGdhZNfMvqdf0WAmEP3pUiMEJV7Avtv8O3/hqaB8TVh5TKVYjoEMepHSh8gfjEi7Ohh7lQoVctG68TzwhUKRDQLg5zupNl0d5/NXNiKWQyxv4p92cM+VSYPb3WZJ5wjB1NMolzvOYSsytbXrAkLhRlWzOmurh2NHCv3lSQ6v+3NgPShXiY0oXNiJCoiuCewsk9sB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=MeuIxQL5dUAIoWEv2/hWriwhlmzLxdlZe7NzFaL4mzAVGBb0kygbzZWaxRcZ23sngPdJZQkxvkOSrZ4NbYbiY2sg4NNi+K5lwyye4MMGIxSyUwL6dUvV+fMlLjRLr0UyJn7EW62l31BYTSJmy5JilkkZjA6iHACTGWAhj6fu/lm1p1I2iZs4f6vndA4F89HC1+fQGOE1o0nrsf450F9PqI5fGtIGzKvmhUBw5haAU7y0KTF5FHB/Poah5LkdnorsdS5OHs+Z0PqByB67UG5xPvWfhHQ/HR/kC7SrHUZO1+RBKNbw4VqNznRmvvmin/Utw6b0PVdprHHYI7RLavs++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=u3N9zfiA9d9ePqmTyC+hPBW9Yu4OSi/fkqXsAhEtdPLIrn71vlTqODy6LPAFWiyvbruZiE2ZYscRNJ/979mSyJmfy66piKGdooVn+9b/6IKUIvQIdVLX1rgYaQguH1P01rAsTQVd9DlLeOfGZoNUTZt9/SEK6OOJ81vwZe2QAdQ=
Received: from PH7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:33d::25)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 06:29:09 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::40) by PH7PR02CA0019.outlook.office365.com
 (2603:10b6:510:33d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 06:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 06:29:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:05 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:29:04 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Thu, 3 Oct 2024 11:58:43 +0530
Message-ID: <20241003062844.15338-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: de32786f-0756-4ae6-be81-08dce374affa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1sVNJUw/TBLvah4KyZtgZREBRhVeEHQ8ljT2Eo4itJmgIB93xhlJYTnBXS1A?=
 =?us-ascii?Q?qZuOgm+oG4HqyhVaCf8cnBHF6kk7UB+qHpdNHW1uLKBwKqKFJEoXubTg5F9g?=
 =?us-ascii?Q?VHrY32CKXHfHNlvmPaZ7wMTrqSjwi1tHEkeMxzYV3gf4OtrRjduiH122awzm?=
 =?us-ascii?Q?g6LgvB9nVGHwYAsoTzbCPk6lta16RpnoK0Fy2j0xkSIkmnI/VgIKSkdyqaPS?=
 =?us-ascii?Q?T3Yx9HcKR/5zalf5nbjEApeEaNAb64MwwrqRFMan4eUClYiX7pnCf9y8zl6U?=
 =?us-ascii?Q?9Z/TJgsuIYnoo4lnSg21taaMbm+aQIYkUGlerkSI4pjTSZdbdyEYJ68C+J+N?=
 =?us-ascii?Q?AkJofT/J0pkldfUU2PcncDcrZ+2zMChuhjb8nLu7ExABKZ6sfkS8I2Cirsyn?=
 =?us-ascii?Q?+kJ8s0UC1WDK2TcSu6Rh6L83dNB+ZoWnJSgnEdgZ8lk2UwPG8AMQFv1c+j+N?=
 =?us-ascii?Q?QkMHAvgGxePuMmWWmCXkh+gdJQzJbK+X8AUxsw+2E5aeIrxwLyGKsLDtkgPC?=
 =?us-ascii?Q?m6JMJrIB/SY9rpCuTx0+Qjj9BxxY2TdZ1PStdnn4uQ3L9VKmgldUuLjfaF1+?=
 =?us-ascii?Q?UcyPp69w7XBJ7osYYmqr4oPSV/yaeU9lAA+4Yzr25QsptbuVVdVJSt02TR4E?=
 =?us-ascii?Q?z0WzuOp7cg6Al5MPWDALKBzS829OFGDRXDulS3XZn2ltc6FZ+ml/XOWPPTNd?=
 =?us-ascii?Q?Iif0EWyhMkp+BCW5gTaNFvp4MqlvrotIby2tTclI3FvZGtyw3ANDFn9Ddztz?=
 =?us-ascii?Q?uodOMZxdvwSHAHNcDyca97Cff1AkSJJJZrPMqZ6F6iyWX4iNu63le0goNutF?=
 =?us-ascii?Q?+Ssqi4ZRJerCptHRFLSDHC8A50t5cs7H/3lS0MLPcmk6K7K2ZC2em+2o2K9y?=
 =?us-ascii?Q?x2Dx9QiAS0uzxaC2hC1Rz1czKvMK/yAt7rbzUObTK1tdizfWCEFYPZ8OhxhN?=
 =?us-ascii?Q?8FIQ9L403ynK0SRccNH7nmFaa4YAaHGPT43yEMPjoTfHIdPAKqyPXce+u0LC?=
 =?us-ascii?Q?lCW7P/Mv2LeXTiGU/QkNjLLWUi+h9VPb1JZflRtKW99YRNTJVytms6qUIi4o?=
 =?us-ascii?Q?bIJYE0hhHWTcq2k8GlobfzyNtfsH19bHkw///O0Ue0NSLXZRUoO3ZO0dNN9u?=
 =?us-ascii?Q?/GQmTC/QTCJYGEWatGd8tlAubJ62AbsSfYjl1/yaIPJzS0PJC0WemY3rn33/?=
 =?us-ascii?Q?rb+6LSBB/56fRzSuJza9WfOpPUDE6kHVrFKpyiFZeDHtJaSjS50bjHZQ+JeF?=
 =?us-ascii?Q?lC1nSAO+RKrI28y5avHN1p26DPfxDP6xIOacKnNGJJgT0u7V2rn8OsO+esT2?=
 =?us-ascii?Q?g2uS0b5gezQWVUIbEBZCR2GtQpzn2jYgrZW7RksMIz7FXzAJTAVPZbeoypzO?=
 =?us-ascii?Q?Jm+Y1amkq4ch8yoqpz0cih7JC0ku?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:29:08.6049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de32786f-0756-4ae6-be81-08dce374affa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

