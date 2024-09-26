Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2435BCCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1596888C94;
	Thu, 26 Sep 2024 06:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQSzTEJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCD288D4D; Thu, 26 Sep 2024 06:55:49 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537B688D29
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxo00wmpk4niSgiAUlBEoOqa2vKuWsTeEaPXPiizDVaIt37BFncARTx1iQh7uJijaZ0giZaruawOxxx9Zngpa+MjNjpgBb4GbPt2ndPElX/O9OItYpgAyMa62pV/8/IlUmGQU8msm85Wp7aeCyFZneZQvuwTZkrVRSNsSnpfyFy4X3FsRk+wHTGhtbr6BuFAlFIungJIc0Ryt1dyHb9F2kbKjyWMXC9poO4OVwDP62je6S5/XxuRbJ6K+7Gf0EqVCEWn+nC7MA6PF4OUwmjkhZWHMppA+Ck4R66rT2nx5KAOSaqR0Kxe3uxva21fB+Y/AVRzl7zZJCHbFHf4+Md24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdb5Nw+u65Tq0qL8sBWm80808kpJ5dgTVrdE7wFtaJQ=;
 b=nEIImNWH7k01h4AoS+9mPcLE8nWq0NSCzMPF6+6YSQypzgMDD6C6FC3wkWEMYz7JUgX657SGGZ5+nOsIL35xXGaA8p4T+tl7Wy+ncKOgVDH5T8XDKnoaFDPRpdcBjk+btXYLjBCzRA46gXEowdDOJWC+y5JGCj8m7wVWGdDAI8Eo/4jf+gbzkgwQ27vYrM8HX0Fr+/MKRaYGA9GnchntGSSFO98dkanjqigOgerbzPaV9v2Yt6fru6p9wBH0nhJA+qX6UmqZLfRQLbsfOaVXWMG/6+E4eLlVfUN5voA6gJaib5ytEVpQE2klUO6uFpWoic144lq14VZYThrxmP9RSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdb5Nw+u65Tq0qL8sBWm80808kpJ5dgTVrdE7wFtaJQ=;
 b=uQSzTEJ0rX3zWAi91GHRZEw7YNfgPeOI/0S/gZoBltfn6FqGQt+zQuoG3I4REYxEU2YJDHitiaDjTnLaSf6owiYBzNFFiESWvzqSpp7nQEWp7plEVELeh+6aqzrvGE5CJa57jrZ41tgK+wko7RQnwqoH7h/C+CXLjP3C1uydTlk=
Received: from BYAPR06CA0018.namprd06.prod.outlook.com (2603:10b6:a03:d4::31)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 04:55:38 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::43) by BYAPR06CA0018.outlook.office365.com
 (2603:10b6:a03:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:35 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:34 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v14 8/8] config: xilinx: Enable the SPI_ADVANCE config option
Date: Thu, 26 Sep 2024 10:25:08 +0530
Message-ID: <20240926045508.1492638-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: e51604f7-0f0b-453d-51c4-08dcdde776bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imXSA3f0PFvTgJ+jXWPtaSKip4vFW17I9KRVTgDI73ZaFDuRbTOECM+nW9T1?=
 =?us-ascii?Q?jr7kFxZOnY4V2Dn7xTKJnb8p8T5K9Kql+btf7Rq+8NdE2pLUF46t05ytFaSz?=
 =?us-ascii?Q?jlXEEy5BoRHPl4hNPLxl6Ha3dZhBKRLw83IbAP9OhbKtAfBfvuA1vAPEjhgK?=
 =?us-ascii?Q?4OCIR1Q1VqzPEddvtH/FgswDl4gL5ee+cWfnt5n0O8auIdJmLwlmR03xQ/76?=
 =?us-ascii?Q?m/us2loMTo7wpC9mteRSg5Ms18ENZ33sYZ8Z44rtyNA2mmV8MXLwj01QFpVy?=
 =?us-ascii?Q?v3CkHXlLkuKaggxivOn7JGeNUxzD0cTQESmUxF6XnqbQlpDTNrCfW6kpNGDw?=
 =?us-ascii?Q?iKG/uokPRC3R37AYc+28hT/bHSnyr83gKI80FWEq2/8kLOWWu7VUK/PDZRDK?=
 =?us-ascii?Q?djZyPg1f9Y1nRzo+7dJ5ssHx15mHTRBdklO2fuSGPw6HqBoXHGTXpIzK2BJv?=
 =?us-ascii?Q?wq7QxijOZb/LStBdt3J8BBn9vpp6r4rChOu4fDRUayNjyjMbYJafl7iNxda9?=
 =?us-ascii?Q?i1V4FX+73dBXCKQCPb5LKNoimlV54xDHsZDnPDK0BPFMnwPkFHRamR275Fj7?=
 =?us-ascii?Q?RGx2Fx9lnqfRPjzM9FcCVPXVb/DvBqGock7UUg8gwXkKxaAeDyJflJaoVV61?=
 =?us-ascii?Q?BU82L3e0jSruHOUXmbDCC/zKLBVm8tpoJJ/BWX6SjvYiBut7olUBX0aQUnUR?=
 =?us-ascii?Q?yhkG3pZj9OvQhTVciq6Q1NVGPsk2qBiuF8x8NQmALJo+cIaHJBe4NyBNE+tB?=
 =?us-ascii?Q?rDz3ffC7twbYlag2abANnWeSVdfgC/4usbt4dvLSG0eDYlhRWe9v2G7ifTO+?=
 =?us-ascii?Q?mRQNp9J0oEGduZbFtB9qELCu5nq8rsHdAKBjlxQjD7DGj197c9Ns84Ga2soV?=
 =?us-ascii?Q?/sRNCge0M3jqn0YTMJeMI3XSm2jm1nKXsX9NZW52cF/02rwxa8eGTzkXvDti?=
 =?us-ascii?Q?zyAB1SWtFXZAocjk9mVxAf337h1rwOichQPCEJ19qBgMXJNEq1FUflaEDLxr?=
 =?us-ascii?Q?i09fwfH68fV3hM/hn/P5IxB1Uj3yF1CB54rBpN5TcQl4MDp7XM09XfQqduns?=
 =?us-ascii?Q?kvGzEnANMA0y6yuyxmVUJHjHcgWJgw5R5ZbltwQs+pLbGOjIIRVXWsuBhGjK?=
 =?us-ascii?Q?QOhkekLIqpfCi86zG75+p0HzSmzLcrzXoI1HbarnCduXkIhzgGJ6zCPumnpQ?=
 =?us-ascii?Q?cfKUKSJ5FvTWu0sBdL1diBDVX/0bRDpQDqYT4KG7cWfyxEonZVJUvdYvYLEk?=
 =?us-ascii?Q?gM7Q2i/PTju6G06xjDCoJ6rPs4GfCZah/XZ4jni16QTj/3f9qJDuCnR9yioT?=
 =?us-ascii?Q?jUHoOh9hFmgrIsL8TumRRhp7NnGUAj2gnfJeG6ZKjZb8CSLKWvZ+WJXwrEqQ?=
 =?us-ascii?Q?htOLw+E7vlZnYV7qsHKPtvDMJ767h2A/yMoFse9yrVhD4jf50HNdq/RcwNRA?=
 =?us-ascii?Q?b02j6YviGhbIr2vLExZy0f0gvtCANb2R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:37.7795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51604f7-0f0b-453d-51c4-08dcdde776bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

Enable the SPI_ADVANCE config option for all xilinx platforms, as
this is required for parallel-memories.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig |  5 +++--
 configs/xilinx_versal_virt_defconfig     |  5 +++--
 configs/xilinx_zynq_virt_defconfig       |  7 ++++---
 configs/xilinx_zynqmp_virt_defconfig     | 14 +++++++-------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 776af9ae29..1e09c0808e 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
@@ -39,6 +40,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
@@ -58,7 +60,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_DTB_RESELECT=y
@@ -127,6 +128,7 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_XILINX_VERSAL_NET=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
@@ -151,4 +153,3 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
-CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 0d4591411e..d08e6af2de 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
@@ -40,6 +41,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
@@ -59,7 +61,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_IS_NOWHERE=y
@@ -128,6 +129,7 @@ CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_XILINX_VERSAL=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
@@ -154,4 +156,3 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_TPM=y
-CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index b2921df1d0..417973d104 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -24,6 +24,8 @@ CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
 CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
@@ -64,6 +66,7 @@ CONFIG_CMD_FPGA_LOADP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SF_TEST=y
@@ -81,7 +84,6 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_MTDPARTS_SPREAD=y
 CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_CMD_UBI=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_BOARD=y
 CONFIG_OF_LIST="zynq-zc702 zynq-zc706 zynq-zc770-xm010 zynq-zc770-xm011 zynq-zc770-xm011-x16 zynq-zc770-xm012 zynq-zc770-xm013 zynq-cc108 zynq-microzed zynq-minized zynq-picozed zynq-zed zynq-zturn zynq-zturn-v5 zynq-zybo zynq-zybo-z7 zynq-dlc20-rev1.0"
 CONFIG_ENV_IS_NOWHERE=y
@@ -142,6 +144,7 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ARM_DCC=y
 CONFIG_ZYNQ_SERIAL=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQ_QSPI=y
 CONFIG_USB=y
@@ -156,5 +159,3 @@ CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 491206998d..19d4b2f692 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -23,6 +23,11 @@ CONFIG_AHCI=y
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
@@ -46,7 +51,6 @@ CONFIG_SPL_FS_LOAD_ARGS_NAME="u-boot.bin"
 CONFIG_SPL_FPGA=y
 CONFIG_SPL_OS_BOOT=y
 CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
-CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
@@ -71,6 +75,7 @@ CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_POWEROFF=y
@@ -101,7 +106,6 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_MTDPARTS_SPREAD=y
 CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_CMD_UBI=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_BOARD=y
@@ -204,6 +208,7 @@ CONFIG_XILINX_UARTLITE=y
 CONFIG_ZYNQ_SERIAL=y
 CONFIG_SOC_XILINX_ZYNQMP=y
 CONFIG_SPI=y
+CONFIG_SPI_ADVANCE=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 CONFIG_SYSRESET=y
@@ -239,8 +244,3 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_HTTP_BOOT=y
-- 
2.25.1

