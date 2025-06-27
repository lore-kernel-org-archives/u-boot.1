Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B83C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7670382E52;
	Fri, 27 Jun 2025 11:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zwj+lnSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BF782E9A; Fri, 27 Jun 2025 11:03:13 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9874D82E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi5GRbBkQwF+qtkDCkDe9nHrKT2haLz2QhLZ/CPPTumkCqwVmfPuyemnnB9dPT0AsyNmHV6ITpkBXzV8c9LP3Jjcho652wvEEbVygZKoG/aIpS5Pvsb40kZTxFl10XHR8vpKoFCgkWAweVuXhlE3k7FYCYCcHInUT6aYVvLoCgWJttrcVmQzGhXMCvrbQ9739q0++VZU64oN+NxcJCySyNCHYLsfVCd3a5QzjIE/QTONiNKWzBrdiOGnoCsT/WG7t3kF+AehyYUEbm2iwtOQXBrW3BvrxbGFbm0EXz17yQ13+AwIFLWUPMtuWO6SRhyO+qDaxSJb+aYa5JkHC6Uhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6wScS5peeE9RdSPpTFOeLmmXauPZvMJ/ZtrD87DnOs=;
 b=Z/GXku70809jCjABRV7c3jQy3Vo9vpOu47wsof+xpqm+VEOKBKModFUoCblsb1Rve/4tMdeUftXBRuV5kyMerb2ZBXyth0bbTYTA4vWi48RwxrkC3d7fkvkl+v0lQem+2LGVeDAb5Vdh7cF5vkFam0CB++WvXiZDd7Nfwh5L6Ck9umTXwojj0zx81VaPLkivaoyhpVGeAGuOgOVdUvTuKy7JKsrBPA7oPCap7WUlFZEmNK5rYGiPhUllPTAC36QaD1pcxZ/2uA3UWEUNRUzHj7lXwF9buBfzU8k6wy2FMX5lnePUZ+i5JekMxltZgO4xA4XxIiVCjpgTUFqvhWsM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6wScS5peeE9RdSPpTFOeLmmXauPZvMJ/ZtrD87DnOs=;
 b=Zwj+lnSVNWCRTJEWcFAg1KhXmrR68crGdGBTfjqn+BLPgPVXYV/8IqMwtJP6u4Vi1bFjvIROx1ZP5Y23IpFGtQqiSpdi3CIB+k5tBjaToAo/mLPK0Z9DdMb682pVQ/5tG48Mvg7RO4K5coMI/1EpXcW8pvJDjsXkadfH1UUCS+U=
Received: from PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::34)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 09:02:49 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::f0) by PH7P222CA0013.outlook.office365.com
 (2603:10b6:510:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 09:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 09:02:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 04:02:16 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Jun 2025 04:02:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] xilinx: zynqmp: Remove PSCI_RESET from mini configurations
Date: Fri, 27 Jun 2025 11:02:11 +0200
Message-ID: <cb5189d676852cad7ab3c0691490b2d0dac618b4.1751014928.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QA9SoobPE5KTK3pO1qejMHKSQd1+Cy+9zPEyewVHrRk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTExYny+U5iMCjelviJLzZ4wmJfbfP5vlKea3xvuG6e3
 vR24oy7HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARgbUMf4VfnWm4qrGvv0Ts
 hU/B5EqWU1e2GKg6i7h8nnmQ+4ShsxojQ69CnlJA1LH3XPZSKw1y3h7d7ut06N0ULhHtLb81NNI
 ucwEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 747052c5-657e-4b6e-6605-08ddb559642a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3LE5syfTSWiC6N6LjdkT+uGBJAA5E0CWuYHQiKYtWcmfA99wTy6poBy/B6yS?=
 =?us-ascii?Q?O6iOUaNvjqHb+mknkPtMgFoUFuYTF5+5qQ2FrjkUG5/7rB30c1Zn1KkN+kA4?=
 =?us-ascii?Q?uzKYMnE2Wi1LoQX5/AYj9E4u/jM61GZSbEFeRn3S/9z73FYOG2EytA89H+Ks?=
 =?us-ascii?Q?ehm/Zv4tVfhUY1K1Usu2pX7VFdEpmwAUU+lOGEVahBuFTryVr+c2bose5a9O?=
 =?us-ascii?Q?uYYAXq5TfcXUGJHsh/KP4cWg+CWR2Ly6vnJW7/1H7jnX58l6+vvc+yFbH3VG?=
 =?us-ascii?Q?o8g/en/V4Mthw5Pq+d7Wn/nVnrwypS1kXZmt7A7mIMwJ4nm2K/jioeUHYPIk?=
 =?us-ascii?Q?8C4AylFnFb/p9mfKaxb+SkSEDA7InucqjNdR6gFec/e4Gsx6Tqi9NsnxFACf?=
 =?us-ascii?Q?zIY1NhUAW5whP+ofmpfQAPFgZVFvZH6delTVkhG8YOoXTrKjdeNGl4EYhcql?=
 =?us-ascii?Q?cdGSi18R8PEWnuCyoXXSo38D7UyAiLJP3/3SZo6VTXRD0/PmmSOHcwRIqkwN?=
 =?us-ascii?Q?RuC3e8MZD9TXBeUnx4C+H7FfLlbbuW8fGenGsJN/h8l8jZ0DytaiUbyfRWRP?=
 =?us-ascii?Q?QcbfA65k9Y5ufhwHGyDNPancmaEITb5ZLG/OZSMbiFNdZg9OfAN5vAP6yz7n?=
 =?us-ascii?Q?fHJjJDINSjDzzNCjoEhtLydnZ988Yy5XBmoM/YsnjHoknAXczcexEzbKVdLE?=
 =?us-ascii?Q?kocte480Oh62bJcfgZNR9vU/9B7Z4MO0LnbAYo/GCH4FnIyZDEYX7MgNfvcw?=
 =?us-ascii?Q?jGtP4ClyC9KeyvShrhiJacwqbMxuw/W3Qca+DxWEXrtT3pvoRvelD/scMQJ2?=
 =?us-ascii?Q?2Xq5fPa25PmGO9I0OqjgFwr9rD5kFhUMxByziFrCGr/XfRcmTzTgus58Cogu?=
 =?us-ascii?Q?zSnAi6xPOklhRI1U2PxqkBxNlvnYo01iJlbMnXBcg2PS8jBZI7onhRuqvOj9?=
 =?us-ascii?Q?QbcdlftLsSj4oxsUrJhJeezT/5ODsYFEbvOGn4a1dttGlPC1L+Y27UCSru2T?=
 =?us-ascii?Q?SYCJm6Md6RkK/EB3L54uNj6VEB2rH9L+ZizL8RvA/nsMyZcVGDteqgtuzOAt?=
 =?us-ascii?Q?j8vGb2awxAjolvx5Rp2ayMSbYUxlbcAnJImRIgXKCan0eX92jsAUp8JkMMPv?=
 =?us-ascii?Q?EiDcDgJWD3OAsTuOnGGbOebOEJdpQoYFgtq96q5BBhjortNBPRqif/HwPXK0?=
 =?us-ascii?Q?TNiVGO8ni/yfxnbq7zwaU5HTc1ofpc0OTzBAQZOdefpsW78V2XgD1eDlYrg9?=
 =?us-ascii?Q?z/PsLwa4LSzj14bq6qI56B3CBK4dxey2p4JPxYcjl4wrjLRPoPaY/JByoApc?=
 =?us-ascii?Q?u/kSa2TvYWwxl/nnBILeZ1mye3gsT3E2cbMXT1o/k+ocpDf6OJ1NWBGIPDaD?=
 =?us-ascii?Q?49Ag4B0GMqdxJvcT31HAnGLO8hQbEKbCUKIUmNfM4fCdMqF2Nhw8dNTH2u2Q?=
 =?us-ascii?Q?HycNI8dZ1JK2xvYb8Rbmp1ubv+BNV6aSviVNmszz2ezBm19qjblUV6GHGthy?=
 =?us-ascii?Q?pojZFDyo6XygYwQkEWXmT+fEdrq1B+6wOLZp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:02:49.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747052c5-657e-4b6e-6605-08ddb559642a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
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

There is no reason to call reset in these size constrained configurations
that's why remove it to get some space.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_mini_defconfig             | 1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
 configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 33f85f77ce3e..8aa4c8dc77dc 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 2ddaecd5875a..66e0d5242821 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
 CONFIG_XILINX_MINI=y
+# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 31bba1712fb3..cded70f8f2f1 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
 CONFIG_XILINX_MINI=y
+# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index 3b202b04ab3f..f5c79779df3d 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_XILINX_MINI=y
+# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 67e1a6e7037f..fa58f2a73c0d 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_XILINX_MINI=y
+# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
-- 
2.43.0

base-commit: 100095b952751117155ee6a8ee535225b29a7640
