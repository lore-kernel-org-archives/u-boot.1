Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119FF10ED64A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E70583FAF;
	Fri, 27 Mar 2026 13:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BteV2wpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4950583F14; Fri, 27 Mar 2026 13:10:41 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E82B83F14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB/QIDk4tuuaWuRcV4Cq5Nrx/UsU4nTtQfxIOKmyhCKr376nqUvhcfTI9PZXdL4J6NcAzNAJxYFiU3oXYCRvNDM3dja6yawPxnpQehk8UvdQ3s/dUVfCAJtakGCigwEhng8+4h8PsyNMZdh3V/rLtYdJRWCvxWuDBISWZn6L+ub87Li3lo7DUTvAcM7cncD3xF/RXZnLY1Y2TGmVMpEykLcMFQQMRHTNMx5SS0mIYQJ4+eqg5XT46rTGvMfUeJfp31liTAx2HXK/dBdVOCwC/+YMPX336UjkCtfGA3r6iJC8+dv/7XZ/ijQy2+d0lYdqMyim/sYt4io3NGGM15aSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbRSYAaoYmea3Ni6/abbyvu+VIoBv5YgiXmz3WIhkvI=;
 b=gnj7q63OtQ7fuiPIbym9jwLYW4ZTpwrq/k7efynTFpQXgkptQgNn6mDBqqs3Btqpv15EPLeRj9K0/jiXbcFRiKNcT/6SLtIfUn0vY2T19uzTg6aFuvp26JocQOIa4VsHUpp9drGfFMDuT3V2Vw7rw5TQXjd7/61yY+rg5k98fCwTfh5LRiy4zV2CnhZ2EUJHVAEP1N/0ei0VMVk3F1w3V1bOQaJspctQ5MsA1xI1zlc4tC3It0ZgLrjkEcDXURaNYaTAdmTMdn7n3hs7iA2imSFFOW2U3Oewup4uwacAijsKt4c33PvlB56BS1gKXLqfdKnYmCvBg7PYYx29Nvwfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbRSYAaoYmea3Ni6/abbyvu+VIoBv5YgiXmz3WIhkvI=;
 b=BteV2wpDDP/RjqrXuL/BRBgysV1ec+OA8yCZtG7mT6++L3h/gWwvv7waP3/INDrsEDqoTqm/3ita6Mcg27XN1KMYd91YV6ukPiuODq8Xc3R6mrRHMjDG1axtTWI1tKcqv+Gz23JFexU3Mt15yy1kccv0On4ID96d/wz9NlAAQOM=
Received: from DM6PR02CA0137.namprd02.prod.outlook.com (2603:10b6:5:1b4::39)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:10:34 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::56) by DM6PR02CA0137.outlook.office365.com
 (2603:10b6:5:1b4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:10:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 07:10:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 07:10:28 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:10:27 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 3/3] amd: versal2: Enable PCIe/NVMe support and add NVMe boot
 target
Date: Fri, 27 Mar 2026 17:40:15 +0530
Message-ID: <20260327121015.996806-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327121015.996806-1-pranav.sanwal@amd.com>
References: <20260327121015.996806-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.sanwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: ea28c0b0-d7eb-4d76-33b4-08de8bf9d8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WYGK6vqUpydmVRaDvGihNt0LxQo5OwIbGVwzw/xezhKGUlvWG/TvrBxVRtpFF5JNFUEHNI2GQXwhI7xfgXQD0N/Uxw4lTqq5+/wEB2VvWdEhr+p717enYkH1VCAZnhMgn31Sg6Gz10d2/CW5ugORYpZ5eAtLFyujyDplOCbQofLRvwGHZVYN87DrJ4CiNwoI5CXunC9RLiCyk1Nr64MMr6qzujsubBff98/AIom5oCtNET0pxY00CFbiYZU4d7pm774VuVJiE4ff1bmccz4dZ3QWPrk8xcC1kCTKo2p9FjmEVEmSOchiJtMCgFUlQdJTDrI0exiIsBKvcKuQsmpX0nsrK/SeEKzw/oRBcghJ3nOavoji9kF9L2DNZpmKJftrWqcRbz2e+xZ9QtvhES23j6IPaYDcaW1K6uEwo7dLUyN7HRzNNXzgYhrnusFYGfZyPiC28WNHUCMTpBtIvpAtCVi74IE00ZBDb0jweCD0o9gR67+KJAbnNzj6kjUobTDKYqAfggewQqcRb4SmE1iWql2GFSUnIPVk8s8K8kj/+dA3RUxVKpEEJ33QouW6KydLTPFQB7e0sUPC5uUYK64lqv2VuCkYrYte5hd288yFM+fOzkpEnkGhL02S+D7lga6hqrM96EW+MJ/Ip2oe8ujJ85wJ7rOqZ96zbxmRCgz/CsVHmsVs1+Z+QZwHHVLA9Gt2kbT44gZugbj3+tuvHoESpOrktvLBjjfsVjRapk5MPxUbVGbnrtbwf4W91zP/9iUkNjwso5hhqjA8ObQo1TMADQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIFPRg3HGa4ftkKMDp2mzY15OgBkM+wtKRdynl8BZTNYuWaMuBzqnVn22itFu+kp70eBDnvJIED4i6kCFvmG7f9BJUepCTHoGQbqchoCV+K+yM82W3D3hCKGvU9Mvgn2lZad+oPFzwqj+jSoxggHN/LHNp7NBAKm36ja1bG9SGxJle9Cr9iDoHjVFxxcwvxM/+H/k8Sl2LlMNV3p2Y3AXBwtKfBJ/c8Mner0Asi1ME/EQDSUjF7h3SQ514dmpxisaNnnVyvDxKMwJljKPc83FftOwyRolsNxmjkTZt4YZ6GpIX1MJobv28Ado74o54f8pH02uyYfiZ9urAnjGPxl8BrSjRqp3rjCM8Y2VUp3arxfZhlYNH7ZTiPr/wIlK36CjBkrRDsyuqZVVaSRw58ABmSf0+leZn9cPyktpomt7Sv0v3JOV+0BSzBG3n3fcgOq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:10:33.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea28c0b0-d7eb-4d76-33b4-08de8bf9d8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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

Enable the AMD Versal Gen 2 DW PCIe host controller and NVMe storage
in the virtual platform defconfig:

- CONFIG_PCI / CONFIG_CMD_PCI: core PCI stack and pci command
- CONFIG_PCIE_DW_AMD: AMD Versal Gen 2 PCIe host driver
- CONFIG_NVME_PCI: NVMe-over-PCIe storage driver
- CONFIG_CMD_LSBLK: block device listing command
- CONFIG_DM_PCA953X: GPIO expander driver for PERST# control

Add BOOT_TARGET_DEVICES_NVME to amd_versal2.h so NVMe is included
in the distro boot target list when CONFIG_NVME is enabled.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 configs/amd_versal2_virt_defconfig | 6 ++++++
 include/configs/amd_versal2.h      | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 8cc21094653..e0bbc43ddc1 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_XILINX_OF_BOARD_DTB_ADDR=0x1000000
 CONFIG_CMD_FRU=y
+CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
@@ -40,10 +41,12 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_OPTEE=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
@@ -83,6 +86,7 @@ CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
@@ -122,6 +126,8 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_XILINX_AXIEMAC=y
 CONFIG_ZYNQ_GEM=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_AMD=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_SCMI=y
diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 404af2cd4c6..c8705aae17e 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -131,11 +131,18 @@
 #define BOOT_TARGET_DEVICES_USB(func)
 #endif
 
+#if defined(CONFIG_NVME)
+# define BOOT_TARGET_DEVICES_NVME(func)	func(NVME, nvme, 0)
+#else
+# define BOOT_TARGET_DEVICES_NVME(func)
+#endif
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_JTAG(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
 	BOOT_TARGET_DEVICES_UFS(func) \
 	BOOT_TARGET_DEVICES_XSPI(func) \
+	BOOT_TARGET_DEVICES_NVME(func) \
 	BOOT_TARGET_DEVICES_DFU_USB(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
-- 
2.34.1

