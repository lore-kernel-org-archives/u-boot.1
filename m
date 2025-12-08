Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E13D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729D383B86;
	Mon,  8 Dec 2025 20:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qs26e5Tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C13983B64; Mon,  8 Dec 2025 20:06:54 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B98783B07
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrhQDdamTXdN0KFdZ1LFZyAu5Y72AwM940dCdojUlKSttnGu2hMki4xe7YODQMhnHKQUC48VFT1BKfXq8QXBuPcRzV7TC9Sq5Cb+ajGD8nUQDK9G7alRRTGbp3rt0oJxp4xkiGwq4VkPPSbmOiaf4mH/Hft+eayA4D6HUVS8IZhN3NTnNJWzzOQnlLvWqhivX14ZXQ5TE13aY6e7gXBwBl65R8seVeaV9Y3ZyQ5sBAysrUI6QEUEKXsFdGyjJ3vU3ZWdk65bUAbx/41anstwxv/Qr2asMBhkNWUQb8cbtELMrg6+X/zXnNwGcc9HiLh17kyy0Y1/7eFUMMddugxleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDJMtNB5hXthR0Tjo0QBHJFiXIDwpddH5HgqaJzUV8U=;
 b=mUzE/rLLwI3ShnV9DD/ciNtop2GqnPbT5nTf4RC+6S+H/NTA3Ex0D+K9YFPYJazdj4cR7ENeGuEAgHgyw+AkoVMHuCwMxti+FK0WEDQxcvb7QsljR+S5mCOZXZxOw12PSUjr536WIV4JXrhupPZlzfAdW6ih21ZUpkGJSyiRhqkJakLCGocvCgL/fMEYptysm6LIWJkbjACt7Cp5Idxh+aZ3JEdkaESVW5X98EoWhSA5qBd25uyMEc612xF20rpJJLOMOMTkw6VPPXxCQOLdt4S5lErX900mTHwVVqJghmYqM91q0wAu+SeqSiTcH44KvhjBDk8V/G0+ovSj0d+UOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDJMtNB5hXthR0Tjo0QBHJFiXIDwpddH5HgqaJzUV8U=;
 b=qs26e5Tx3dBKsHejFDt2nNo/MATeSJb3QHnT+lBKDH9lcupaw5Lx4ZAaOSNyZJI2fS9K9Bo8+am1PyfZIyYsrv7eGr+vbJBXOb8CblFI2UBm7eCwnGEHv9nYY5af7d/NkCmFFpPa08/2R/mqXnR3JZO2pJnfZ4FAbxyPDIllpCY=
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by DM3PPFF584262A5.namprd10.prod.outlook.com (2603:10b6:f:fc00::c58)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:06:45 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::c5) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 19:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 19:06:45 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:39 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 13:06:39 -0600
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8J6crE4121137;
 Mon, 8 Dec 2025 13:06:39 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/4] spl: Kconfig: k3: Set common default for
 CUSTOM_SYS_MALLOC items
Date: Mon, 8 Dec 2025 13:06:34 -0600
Message-ID: <20251208190635.2044082-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251208190635.2044082-1-afd@ti.com>
References: <20251208190635.2044082-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DM3PPFF584262A5:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf122e6-f276-450e-d966-08de368cee32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RqtAHCsP5FJt+4L0Ch8vY8mk4+wR58Vm5CiFPGTTiZDlYQ7JYTC4cNcFK01k?=
 =?us-ascii?Q?BV+zS2iSxUKfe4lQ3WWjHAdxLi23KWA3/Ya/uyuQLNIFujJ7+VQ6NOgHUA/6?=
 =?us-ascii?Q?cnm0A1rQ2qClWGT6F/D3oXPNse3uURhla93vvV/FsBQLIixcQLVb+eMwbSd0?=
 =?us-ascii?Q?8c96MAFzj2/ZlSoyPjc6alFgfPUW0gVZbI9ID7KJEnpcd5Aw1En2+SZlJJqS?=
 =?us-ascii?Q?mEPWggtUR4lHWLzvE++Ww7YOS+0+K8Q1BhEEFc48r5e7cNAIO9B+nWKsMhlo?=
 =?us-ascii?Q?cWlDX0j/w1afPmYj7QVcgC2GcN4230gsAP9d9wAqPGHj0qDyILeTyzdOQm6n?=
 =?us-ascii?Q?F5uOLhu8fbd8KD3qa7FcFE81VsXzEcYBpNWjcn7IwXLIvnebFi5UWeC3BZ0x?=
 =?us-ascii?Q?fgyfOURzJn9ZM/k/mJTQHR7IWItWzwMp4w6CcR0Shr/cL6wA8K0Z9ot+AqHu?=
 =?us-ascii?Q?VdIYNxR0t6urMRclKZU1WOnkkd0rV0hIl+E+ca+yIuZ6b9mPJCeC8UfFqt2Y?=
 =?us-ascii?Q?vMNAmfrsZ4Jqwrr6BcMyx1xMx+YTCEVn/22jkfpdQz4/Su+0jfcS68g1YB3H?=
 =?us-ascii?Q?Jhya29ot7wv7GWqyPXk1THcl7daeqavoKuywmmVYL8d+PJy8nRwf88gU0BOK?=
 =?us-ascii?Q?BllnkPa2cmjqx6L+zyvAlnGmwbOg29N3UlNkIzzmgkeMnfFtTq6P8fXKaPPd?=
 =?us-ascii?Q?7rAdaWWoUb0gJL4dAqyrP+8JhNQ+OaLnevpAkui5Fuq3QRUEMkFlz2hIVVaO?=
 =?us-ascii?Q?xL54TivqsWDrRXeMa6vm8IFR8Oq2K14BEM+8vsYbCNrMmdVJHo7+6AAiZlfK?=
 =?us-ascii?Q?RPNqyL76lMDsWgAwjn9GNGEVTwrZqxCr8I6DjyIw1MEYabFwintZ1Jkv1q4S?=
 =?us-ascii?Q?hZOlkTC9707XCWcG56Bez8MSvXMfKJjXcIIH81Ak7AMGDLVRgYBVr9qML+kd?=
 =?us-ascii?Q?pIbXmKla8i9U3U3hjp/67rULLri81pj8paGqonXuE52uRs5xWxVEITBt+L5w?=
 =?us-ascii?Q?NURpTlJApSNbxNCPWgP68hi74q+mEMKZeavUhSIFIZoAVJIPncPx/qjndTp3?=
 =?us-ascii?Q?EHHHNT3J2kRZ4hgJa33Fz1Onxw6sVhcZQG0l25kAvDwYDKychAxraenVnGSu?=
 =?us-ascii?Q?WO1+SZonO81+aMw+/rUjOjyMAHW6cSJh8+ZhTj63B6TFCUX1MHIQGDu7UQ6P?=
 =?us-ascii?Q?3YBx0TjRI/qBhQpskyarb8szvexGrx9O/gzqHBEioFGunPy5lpqVyYvzWecQ?=
 =?us-ascii?Q?IAtVB3f5WmHbdk9zKgNq6tZ9vWtktMQJ6Sit+UGJAng13LfDnqbHMa8TeGzC?=
 =?us-ascii?Q?R1SJBX9WCk8oADdfkqA3iWzxnV/lhhDg1iAsZc5qJ9DXXChcIG9gtmdgUTeX?=
 =?us-ascii?Q?lQLr1Uo00F7RETTCwMaf6sXp94Unt1d6tONQJDDP86/CmsKjlstIUMlAjjKF?=
 =?us-ascii?Q?wiCTdpeeWpOipbpYXtrisgH/FibnZijnygMx3eDihg6vwU+7rSNNRtKc2jRv?=
 =?us-ascii?Q?hGFQefXYqxL7uHImFX5VXCAyUJzKPwMlt0N5g3RbAX5OZ4HcD+lgxLd8qeiB?=
 =?us-ascii?Q?SbT4p2ruvXN+uGHuT9k=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 19:06:45.2003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf122e6-f276-450e-d966-08de368cee32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF584262A5
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

These are common for all K3 based boards. Add the common values as
defaults and remove from each board defconfig.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 common/spl/Kconfig                        | 3 +++
 configs/am62ax_evm_r5_defconfig           | 2 --
 configs/am62x_beagleplay_r5_defconfig     | 3 ---
 configs/am62x_evm_r5_defconfig            | 3 ---
 configs/am64x_evm_r5_defconfig            | 3 ---
 configs/am65x_evm_r5_defconfig            | 3 ---
 configs/am65x_evm_r5_usbmsc_defconfig     | 3 ---
 configs/am69_sk_r5_ethboot_defconfig      | 2 --
 configs/j7200_evm_r5_defconfig            | 3 ---
 configs/j721e_beagleboneai64_r5_defconfig | 3 ---
 configs/j721e_evm_r5_defconfig            | 3 ---
 configs/j721s2_evm_r5_defconfig           | 3 ---
 configs/phycore_am62ax_r5_defconfig       | 2 --
 configs/phycore_am62x_r5_defconfig        | 3 ---
 configs/phycore_am64x_r5_defconfig        | 3 ---
 configs/verdin-am62_r5_defconfig          | 3 ---
 configs/verdin-am62p_r5_defconfig         | 3 ---
 17 files changed, 3 insertions(+), 45 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0411a5edc9f..8e9f88d8c7a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -489,15 +489,18 @@ config SPL_SYS_MALLOC
 config SPL_HAS_CUSTOM_MALLOC_START
 	bool "For the SPL malloc pool, define a custom starting address"
 	depends on SPL_SYS_MALLOC
+	default y if ARCH_K3 && CPU_V7R
 
 config SPL_CUSTOM_SYS_MALLOC_ADDR
 	hex "SPL malloc addr"
 	depends on SPL_HAS_CUSTOM_MALLOC_START
+	default 0x84000000 if ARCH_K3 && CPU_V7R
 
 config SPL_SYS_MALLOC_SIZE
 	hex "Size of the SPL malloc pool"
 	depends on SPL_SYS_MALLOC
 	default 0x800000 if RISCV
+	default 0x1000000 if ARCH_K3 && CPU_V7R
 	default 0x100000
 
 config SPL_READ_ONLY
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c42..2586f6cd648 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -36,8 +36,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index ce503000e4c..223a4ab49e1 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -41,9 +41,6 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index d42bdf1f074..90be95fd889 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -43,9 +43,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index e1a748de5a9..860ce7bebc9 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -41,9 +41,6 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 6733dcfdd85..510bf306d00 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -40,9 +40,6 @@ CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 37b5c6a43e7..64d528351af 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -36,9 +36,6 @@ CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/am69_sk_r5_ethboot_defconfig b/configs/am69_sk_r5_ethboot_defconfig
index c85aa72cf04..62cd8f6cf84 100644
--- a/configs/am69_sk_r5_ethboot_defconfig
+++ b/configs/am69_sk_r5_ethboot_defconfig
@@ -11,5 +11,3 @@ CONFIG_SPL_NET_VCI_STRING="AM69 U-Boot R5 SPL"
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_TI_I2C_BOARD_DETECT=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 09784f300db..cb87c43311b 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -40,9 +40,6 @@ CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 50a9d95d7bf..7d607469c59 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -38,9 +38,6 @@ CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
 CONFIG_SPL_MAX_SIZE=0xf59f0
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 52290722686..5ca742db90f 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -44,9 +44,6 @@ CONFIG_SPL_MAX_SIZE=0xf59f0
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index aaf8fd32879..6cf399ed67c 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -45,9 +45,6 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
index 584a6415ca5..e310f247e74 100644
--- a/configs/phycore_am62ax_r5_defconfig
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -39,8 +39,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index 0368d4ef474..2ff3c54f42b 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -44,9 +44,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index d8117b1c1ae..2f11947b02d 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -44,9 +44,6 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index efba857ad70..6194ab60693 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -37,9 +37,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
diff --git a/configs/verdin-am62p_r5_defconfig b/configs/verdin-am62p_r5_defconfig
index a8b0e942b61..f5b093059ee 100644
--- a/configs/verdin-am62p_r5_defconfig
+++ b/configs/verdin-am62p_r5_defconfig
@@ -37,9 +37,6 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
-- 
2.39.2

