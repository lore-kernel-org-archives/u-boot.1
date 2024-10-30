Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD2D74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851B68920C;
	Wed, 30 Oct 2024 06:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgsPYZjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA720891F4; Wed, 30 Oct 2024 06:22:55 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2CA891FE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0FPtlkiyuva77OwD8m4Gn1xkQj8V+ku+/dhNDxbhpqNoCKlRwPR+48XPc06rRJzXx9kGn5UwetuITCfzKBttEJDYqXPE8FI+CRmCFDWxeX/SBSp41wWLRDRnlItfjM7KvMfflysMqdm8fII1TS88eoSfo9vM/qrar0CveDeP/tLmEJbLfaTcQufWqONInx8tLt5VLmNAzHPU+ozapA7NY+0f9hD2Isawq0rFtLAuqD2ZjQd1EY9LWua6VYnjjXBSHUh5/IJpJs/iZHEMzpMIwa+7Tzi2rrIhnZ7FfJjVF1wEEX9sZJXB8gSSg9lFYzA1mi9JzA4kbm3s2ijKlrDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=jNGXzyGtZ70jXnVaOzA8AE4tPEXSVBZ4l4yNHBttrF7XcL4Nvi9hWSneBAOTv2TIHZl7vW800EKdotwYad3Bcu/mQmXcpmzrRc4KHlHIYpyS5Fd+xEpCwXAGka9zUxlRo3+OJc380md8Xvgon99urRi30j5pxS2NfSBOGPtmw6xFSSPm1a+aMNvuK8Ndb4ibc+k44vzFL2ApIVYIny/AnGLhXpMrYBPBf0Hb1u7d1CaubGOX8i89qw1dLHWLnv/qlBfNWMyOYD3haohXZXwDcxoJ+0arqkGlJmV5/emBfgCh/VQAsJeZVsRt9zjl0zho1/M3bPAbwJRN7datroF3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=bgsPYZjZCfrjTSDNTstbrs3AVkXW64vcTBhaFVDUsJQTHqhLiZNEgXSQSZTziYOcpG1kZbDWAboIN5cMoBarCmQ/xHhac69Vyf8cW+PkbfA0p0LOIQPwH1iBUYM2lALUL1h5fHR/oKltn2YKKNNmL+EOsmePqynXwQH0/FsV8mo=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 05:22:43 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:39 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Wed, 30 Oct 2024 10:51:59 +0530
Message-ID: <20241030052200.24243-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e8d509-da41-4a3b-6163-08dcf8a2e173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aG48GxqWfuqtcf1Q72Vg8CpU1c2t5ZNEhDURBua5brKopesegHtGrNUc3AIG?=
 =?us-ascii?Q?1NjHLvU9Qr2BoaE74QDmV07GNWVvEkjV/FaYaBxzDTyyy0hc7TdFzzYyAOJc?=
 =?us-ascii?Q?OjrgVYxzcS9+GaxgPv2rcJKTD9NoCjkYGYUnXQD4JHBFEnIJ8QaIYqBEXQ1X?=
 =?us-ascii?Q?MpiLsYeso8wfPX8mYE2lN4nQZGtVPoHIjs6Z0/T6YDoFcJiaJD1BJ66TbV2F?=
 =?us-ascii?Q?8WWA4CBifeqx9dCA4rqWYhQNfXoMmcZ0RXG8cLxReMm1G52qwoIUW/WXCF8u?=
 =?us-ascii?Q?KrcBRqKUlJ/yKjD0DPsgcSpAkCG4OMm6s9jaqJIeEqmEd+2EBhCYzEggFD+Q?=
 =?us-ascii?Q?7H4tqon0HRq+7daipGrEY50YPabjCvqv13W4JsokjwY3CvVDNelXoeY+/NoF?=
 =?us-ascii?Q?eFzhAhD6Hd0BQ4rNPR3a2y5IaddeeelG0lhBvz4Lv3/lDl4/tcTlm0tAI4XE?=
 =?us-ascii?Q?+I44eylaB2D/mddp9U7V6BDPFAHipW7yCSC3QxPjtTLJ4yXud5zRRfCmpCDH?=
 =?us-ascii?Q?wp8I0kiNQUxG1JPc/SRBXwT4EACk4FRikzxGBhh8bI++/VvqelIM+jAiIOVW?=
 =?us-ascii?Q?2RwmqzWHxjTSGbaeZi4VcZrKHiWGC56h7AmeoELXDUacYE+51qHW7QeAtQLQ?=
 =?us-ascii?Q?5uSN/PJHltz9vZTKwJdGrMgR/M9WAx0f0IpzHD8TvR3EGJCXjnEyNrS8J/yy?=
 =?us-ascii?Q?0xC/kPwS/SRK5eLfr7H6AGLbLhwGQGU/iTSvGQX9d/VxEZesyO3OVFDfI1vn?=
 =?us-ascii?Q?rdneJ2HVYEfD7WpVpNopC1HxTi2LWC1IYi0iMlMr1K7/EYPtFWFLmuvg04B3?=
 =?us-ascii?Q?Wy3bfVB9Ujb9Lo/ytyPjxFNDaU3N+buwVVicZQ7XP4r7+GpFMoc1+EaouX7I?=
 =?us-ascii?Q?Hw01fQsnV/zerLZ21pZnOeOKdI5x4kN4F/O6obRS1FThaxdyILPDfnSj8K6L?=
 =?us-ascii?Q?smFhhfDRVXSvGixRE+PjHLhF2p5/7F+ZgMHrScYlbvpyua8AN5qkNvave/fs?=
 =?us-ascii?Q?amz/Qq922PhCgulyRh7+3K9CxEKxsN8NOlpySsyiL70Jw2DiVycOvZBy8og7?=
 =?us-ascii?Q?loXiMO8xR623q11mqOnPwrFetVYrlMtjVTFq6ZlGGrZ/53KJ87ShjsehJGiB?=
 =?us-ascii?Q?atMHiPvjDWAAcG+mQGz/KnS/LVjgSrJPcDtd9k0HkTFZ3UJ4DNS3EcvtzYqF?=
 =?us-ascii?Q?ydvPShzbByK6eQsUCQi7mZvn6OPAqrPByojpt5clG2ntqZ+08/noauu2bNvu?=
 =?us-ascii?Q?+byZOpvfhI7CkX34XQOU4uhD3mZ6Efh4vjzP2jPGbiWV18ujZfUkyOZ2v2+k?=
 =?us-ascii?Q?k0zSmiz+ojoFvf7cx0yisGRaJP7KFNeatbN/CXJjGdqOKXWHf0t0LdsV354k?=
 =?us-ascii?Q?cZTFq4DKzZbPPjwyXA6AA5DvWNlWeaG9rOeicpEUddfXR9v72A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:42.8874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e8d509-da41-4a3b-6163-08dcf8a2e173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

