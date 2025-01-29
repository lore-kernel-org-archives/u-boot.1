Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666EC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C1280885;
	Wed, 29 Jan 2025 16:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WpyUfOzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1405280977; Wed, 29 Jan 2025 16:31:48 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23FBE807E2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXujaq/kmmYLJQP06C89H+8/MYA6ffrnCFZTTmL1bzYipRxUN+79Xc7PifHEtBm5IBcinoF0jiHFsF2ySGK+0dCyHbL5L2atRzjX/fFVOOZK9A0F0YFUIgrRiOb7QsSwwEwpP298J4pkXwqWQB2NCxoKWOcSmG99Imbk+4WZRc36529uxeZlXUpzrFAwltPCOaERkPPpyNl5OexlERXkFlm6cGRiOvukMxsypvVJwT6VauumSNlzFTGcthg0X2gHyDB6mXte5cI4HzPJsZ7YUW/u2LCWakURYrkP4mUeq+hrdi6g8ZANBNU2dGWmII8ks9uJZQwlX+X5MZGy9ilY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3y0IXpklw69URNkH/nxcpBL7bxlx3zpozYvNBrGWYQ=;
 b=xAOOx9I1qwMoZ0I41D5wntVjDXighXZJSd+/TUFJoOxEtl26QITfJrScBR6k1PQXMno3iFmg597sol/OXaSqABjnpB9Neq3c65ztSHLYBgDDtOAa4Vn6Y6HpBbVBGZArHGeY3oih/Sbw/QSWvqH8fK9PAer7iE9/UEUCkMtWEtojrFs2SIz5TRFz6wWEpW+OGD/FMiMuqks1DRBeFhC9mUnjSs5FGOKlOCo1GfV+VTl7Iy4OrmrkbdHtc1LMyUT3TUoICtomWEo+QKx0oQFjrkvv4VOYpTkQKOq5D6iG9CGEXe4tqOO+JHQcngoUT11DB7vu2fefIJSmPKzZg9pCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3y0IXpklw69URNkH/nxcpBL7bxlx3zpozYvNBrGWYQ=;
 b=WpyUfOzPwx5QxBFqxcerGRZg0K9G+kK8Kgq8Z5w1ai8sVHoIhsgh5yCtbJokPIAlwUjvQsTDC83GMMDBILyxbsjhKp7uR3BcQ8G2yPAgTl8g/DTQ2IeH0j+BpgF+zAxFUSgxzLwPfI7QbXRAvED08S+myC9upgFfTB8+LhjU0C0=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 15:31:34 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::17) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 29 Jan 2025 15:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 15:31:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 09:31:30 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Prasad Kummari
 <prasad.kummari@amd.com>, Srinivas Goud <srinivas.goud@amd.com>, "T Karthik
 Reddy" <t.karthik.reddy@xilinx.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
Date: Wed, 29 Jan 2025 16:31:25 +0100
Message-ID: <cb05adaf0758c2c4f1361f8665169897493638e7.1738164681.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9174; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VDWiJ3oXqs15ni6kUSoKpg87qNA4AIqk0UX6TDLsAtA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvRZnucOXTgfe+1J+6Mvf27NZV8cekKtb4/6uV3PWuZ2N
 Rzlkiv+2BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmsuURw4LeXTzevz5c7uis
 5d8276D9Fqm7/04yLJhzO2PfEveyq03qzxitX/isD3FJ9gAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dc43f3-09f8-4a8a-b7b2-08dd407a0329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dp/hdS1PEUFhsm/vy/eWhi/B54IRsBzrOv8mGuKmj0BJ/b0JxUrRSavCAJQk?=
 =?us-ascii?Q?AA1DFZHFzlo5UVtrsQrOJTqsoF7pH0LDUEODU1Wo7Woy6OP2ZN7pP/bZA0Iz?=
 =?us-ascii?Q?F71wuD9qbRbG0XcQJZzXSaozRoVHeEiFABItW0VE8i2LlK4EKydiQThPx1R5?=
 =?us-ascii?Q?JIr3zUw/jXq7cGIpBc1cZzUA6VxIv/tQ0UaQ/mnspRv+ZyhEEqWyiOEKf+12?=
 =?us-ascii?Q?szdQw4CfFgJZQFTjxNRbAMsxE1wQaSuUZuxBV2eQ63W9xN4DRxXJJLWriK3L?=
 =?us-ascii?Q?vIsGsH1TBDngRugvZ+FA8VCh1ybt/kpBlqb89uWhIHzsAAYPhRrOFf/U0ovm?=
 =?us-ascii?Q?xHeSIxFNA9Sph1+sYoop/49R6oCWPwxyj+q/k/nFcvwDHBgbrpd36najxS4n?=
 =?us-ascii?Q?fpqMbQKFKWkwQt0JE7lO24bx68QmVPj9qZiiHvLbpwv6OPXcGsCFD0XZMykl?=
 =?us-ascii?Q?U4euDqZl0dF0D0FVY9kmXIULkxOgXvlvsb3kliAo7pyJfmLiXDBX8as5PQXL?=
 =?us-ascii?Q?c9WzSL5DnerCTX2bDWOcvMZPveCppNIEto6yaws8ne4KPE4oLFzDpeNG/HXa?=
 =?us-ascii?Q?m6L2ScKVryQBIGMWYFzx/d78DNLwozPDsakg29KE5L/s2GbmafwMM9dJ/hDz?=
 =?us-ascii?Q?sxP6Vd67gAmDnw8STOt4r4TzvqHMPRoWs9ObF7ViDJWp2FgbpzVsRXbUfs8R?=
 =?us-ascii?Q?RzORwn71FiQwpLxDGWhzmWxVZYVmdpYGFmDqKOjYpOIuDGKInZ6y63Rid98F?=
 =?us-ascii?Q?ffggtFRPBlOz8hVheoDvDtbZ5QjRg0tjHXEBQ91LXUBx//WlgtJKQao1mSJV?=
 =?us-ascii?Q?3MPKHG3YgTOoPgd6tqyDOMLTuNPUdXAPvmjWCsDxDtY8xy7PrdxSXzY/G1Gm?=
 =?us-ascii?Q?bGm11tUfJyTJo70POm+RNyEfw1pUTw1WURzczr+8K5cDoHGIdPfA69xzA5WM?=
 =?us-ascii?Q?KlcuarF0E6efOKmvcN9B/gXWwkWaneSYo3B4XSqUbO7VVNoyZ7Yde9NXqxSE?=
 =?us-ascii?Q?eTYQPlZcPqwwu9Cb7YIg7Vnb7NkL5rFBZ97aLgeWecsMP+qXYOcXcJiHFDji?=
 =?us-ascii?Q?Bvv9EcgBGkwLmNRgqo4xjvAqJWFcA8Nc9g4vGJr570VSpJiT+lkV+Fu0yipA?=
 =?us-ascii?Q?6NvgZxVrzkl3eTRiY/S23oBMghixs02u/v6CQXHQmiue2F64+JOiLHErxTk2?=
 =?us-ascii?Q?zzbmlk47C9OYRchhINNUDJX1MebcDNHxLjfo0VaXNHO6D74b14wsqqkviKvB?=
 =?us-ascii?Q?dNOxDIUT1kZO95RdC2L+mypLHJgw6Ws/aak46qMCgOzzvYpL0pMKkgXWl0q9?=
 =?us-ascii?Q?egpgHhpztSVgOv96agpQATXHRHgnzkb4iz3sPZUclmBbgJZF/8Dpem1Wp8+5?=
 =?us-ascii?Q?stLRNGaEW8QVOjV6AijTXBj8jbuVMsL1VPS9EKb6XceW+GEsFvCq6h35VuWh?=
 =?us-ascii?Q?T38s6YhiW5O4vZXVOP9Vb9ah70Ni/e9vpxWnZlpH3hiOLcYcyfUyg+kaRCmj?=
 =?us-ascii?Q?U3nyI++Ap8W1BEA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:es; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:31:33.8950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dc43f3-09f8-4a8a-b7b2-08dd407a0329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

Enable lwip and https on our platforms to be able to use it in a boot.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig       | 11 ++++-------
 configs/microblaze-generic_defconfig     |  8 ++++----
 configs/xilinx_versal_net_virt_defconfig | 10 +++-------
 configs/xilinx_versal_virt_defconfig     | 10 +++-------
 configs/xilinx_zynq_virt_defconfig       |  7 ++-----
 configs/xilinx_zynqmp_kria_defconfig     | 15 +++------------
 configs/xilinx_zynqmp_virt_defconfig     | 17 +++--------------
 7 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 57a6a06df7cd..8bee002777a5 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -47,10 +48,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -70,9 +68,7 @@ CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_IP_DEFRAG=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
@@ -155,6 +151,7 @@ CONFIG_UFS_AMD_VERSAL2=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 # CONFIG_OPTEE_LIB is not set
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 87756cb26df5..6075c6a2beed 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -46,16 +46,15 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_SAVES=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="microblaze-generic"
-CONFIG_NETCONSOLE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_XILINX_GPIO=y
@@ -99,3 +98,4 @@ CONFIG_SYSRESET_GPIO=y
 CONFIG_SYSRESET_MICROBLAZE=y
 CONFIG_WDT=y
 CONFIG_XILINX_TB_WATCHDOG=y
+CONFIG_MBEDTLS_LIB=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 081ad424a9aa..5ef5fd44fd37 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,10 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -71,9 +68,7 @@ CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_IP_DEFRAG=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
@@ -155,4 +150,5 @@ CONFIG_USB_FUNCTION_THOR=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 70e73ac7ad45..f228eef7c959 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -52,10 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -75,9 +72,7 @@ CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_IP_DEFRAG=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
@@ -170,5 +165,6 @@ CONFIG_USB_FUNCTION_THOR=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index c2422c5b4dcf..fdf8bb361294 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -73,9 +73,6 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -94,8 +91,7 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SIMPLE_PM_BUS=y
@@ -160,4 +156,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 2258b59e3edd..1e8ec90ff533 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -84,11 +84,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -120,8 +116,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SIMPLE_PM_BUS=y
@@ -131,7 +126,6 @@ CONFIG_SATA_CEVA=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK_ZYNQMP=y
-CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
@@ -140,10 +134,6 @@ CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
 CONFIG_DMA=y
 CONFIG_XILINX_DPDMA=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
@@ -231,6 +221,7 @@ CONFIG_VIRTIO_BLK=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index c0721b65fd48..036268c79f77 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -59,8 +59,6 @@ CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
-CONFIG_CMD_THOR_DOWNLOAD=y
-CONFIG_THOR_RESET_OFF=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MEMINFO=y
@@ -86,11 +84,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_BOOTP_MAY_FAIL=y
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_NFS=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -121,8 +115,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NETCONSOLE=y
-CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SIMPLE_PM_BUS=y
@@ -132,7 +125,6 @@ CONFIG_SATA_CEVA=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK_ZYNQMP=y
-CONFIG_DFU_TFTP=y
 CONFIG_DFU_TIMEOUT=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
@@ -140,10 +132,6 @@ CONFIG_DFU_NAND=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
@@ -247,6 +235,7 @@ CONFIG_VIRTIO_BLK=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
 CONFIG_PANIC_HANG=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.43.0

