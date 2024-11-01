Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3590E674BF
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C964892ED;
	Fri,  1 Nov 2024 10:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4p6l/4tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F90A89045; Fri,  1 Nov 2024 10:18:44 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DEB892B5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpfJM5QPmdGyQKD4FIVRayWhpjFhBvE8ITdFSzRk/tW55BGGHGP7oRc1NnB+3MlNbvGl3wLYDpmJUGoBAJw9j83vuCGaHuDg+6ZE1+LuGsgLY5DgZtuUam7ZsIbp1bd1Q6E1iZ2QxXqQudXXRTeAKiI4MBz6r0EiMUUu+eqUeebGDR58k7vrzrm6lla2HnZm1MspwNZaHh3pMl91lUmyDtkzRSHzMif7/8Ai4qaFil7HzSKx3SyO8rywAYPt7WE7J7KxBjuF+iy+Wk7LnBARh+YAAdDzivzwl2PFd73t+7VpnAjHdYDS7BaYref+U5YqvYRAn/bo9Hrn/eHcGYrMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPjyO61aXgWrkFUXbG5srbrmjKcFruHUCI+6u7z8/zg=;
 b=Ont+Rv8p6PiM+d+sPqV8945hsq1PsnmOf/zmYeCZ0NNarad1izS+Bh4xteBfUtxXbYuKbyubF95prmThz7TJ66Q/Zd8FU6CJRWdHVla9pXOFRzCAHToI4b2C7gRnmUWauyuzQj4ycExlRJaV6eaHgb3rpOOaJhiWwCWgm7/4ZYFZQhN1CZzErMYidI0p4ayCZjVI/BAcI/fcsmBE/juZ6xn6h5jB6pmBgngfyYnX6nGUfOMaWiWeuloRLbHuvflBz6Kinl2sF8n3ObfmwaAtxk8G6fprfzYMTsNFh+3OiNxfUJJACCx7OqARbrLdtqDumDOU6J3M3tXHhdzvdKQdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPjyO61aXgWrkFUXbG5srbrmjKcFruHUCI+6u7z8/zg=;
 b=4p6l/4tkiGIoGbXR5XXnHkLnF+X4V6tUPOx36HuGP7dG3K7rLqTWZ2oMGkG/5sDWSPy8nyFwPIIjoS0F1VoDK/1MNrN4wfDMuCeHmcUS+dhAPXtmArfXqIdg4fdRf1VeXWrGtSmAZKkjh1EB8ZF//SY0Fw/EOX7wcAg3y53K9mg=
Received: from BN9PR03CA0129.namprd03.prod.outlook.com (2603:10b6:408:fe::14)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 09:18:35 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::f8) by BN9PR03CA0129.outlook.office365.com
 (2603:10b6:408:fe::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>, "Jonas
 Karlman" <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, "Marek
 Vasut" <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, "Oliver
 Gaskell" <Oliver.Gaskell@analog.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, Tony Dinh
 <mibodhi@gmail.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 5/7] arm64: zynqmp: Generate u-boot.itb and QSPI image via
 binman
Date: Fri, 1 Nov 2024 10:17:58 +0100
Message-ID: <90b613796aee38158252c8bb1dfc3da0420f089d.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pHTY5hBP3P+O1ABlxikv/xezJeQNDLarfzW9xNFJfyM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOUc8Dpvw+xuYhcqc7QxeKecvH3ZIo6TzBpuX7Q4+v
 3o/Y9WOWBYGQSYGWTFFFmmbK2f2Vs6YInzxsBzMHFYmkCEMXJwCMJGzGxjmSq8VbL2vtNopwYwr
 obhGdolwQ2Qjw1yBDu6TulUMnjxfkviFPT12XC3TMAQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: b481ce59-6dd6-4fca-c0d3-08dcfa5629e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1yaBNMV5MC1k6C4GY8kFibulp/bjWtBZOmS57xnugCp/S0aCYUMr6vOA/XN?=
 =?us-ascii?Q?L0w22kBUCTMqG5c53l3Im5rEHiw4TtPBljpGwjSP/KW1vzdKDEW9pA7ICL8J?=
 =?us-ascii?Q?+xYM6nc+viRJsqg8zlaizH+RZWD/6daLKHui56duvQICmf7w2Pfe/PEApkS6?=
 =?us-ascii?Q?ARWPB/hWcjuDYplxYQ0JgCfZJeqyWqmBv6/xV4eb5tTVgaco/ZNje9UzI6oS?=
 =?us-ascii?Q?YJ7JsTF4SBCvMs8Oid8jQXe4ygwHUn4JZ06RFDhPfeohfp/Uw+J6Zmlnmhxr?=
 =?us-ascii?Q?g1sQJB9VDhu2U7i6i5UZi7EOcHclwLOKEFkoSyq/nGjtQ+swcLCObD+ipbMW?=
 =?us-ascii?Q?pG653WqYUGs6/M6jHWDIaGiEeDHRHSojmr+iP5yu9ddS60d0uEENazb6QaPH?=
 =?us-ascii?Q?UWNptioufEesSdL46d8f5C24FiAo44XGngN6ynt6YROnuiW+S0QbLZ912sAZ?=
 =?us-ascii?Q?hybnvkeaJzrNs+XLjeU2Yi7PbfmeEw2b5nZOVSZd7w1vQ02ZS6+pKIMrD+q3?=
 =?us-ascii?Q?WA0FtvcBVjfqOZmJ7jShzzTNfUoRPLtY5kYrXyONb6yvochsly5La+wptVA8?=
 =?us-ascii?Q?ATETdDPWi/1urnVayQVCASXs4OJ8RD4+yZfUO6raOsL7ZuaKHrH332X89d7K?=
 =?us-ascii?Q?1jZ+8hIA+aAUTG24R2l9zOiIZ6ljJ3HJLXov52dwSgSa2lLeH2XedOk+khlp?=
 =?us-ascii?Q?uouZrtuub2KCozOTO0IPF+7m7P9zkoDFzFwIDAY4fDa4eWzngpaC3DVaozqs?=
 =?us-ascii?Q?8o64JlBXKTf5DZdA2ej/xu4d1HtskEPH3RmrZMyiwjELWlLm1Kvg60M5bONB?=
 =?us-ascii?Q?+Gugz+mP/EK/I8tx1hZxIEdlNM+VRCmj23MRKOLlR1IdCSAyDeeUi9g5ycEd?=
 =?us-ascii?Q?72W4Kyx7lRE41CGzRTtjkY4zgPS0fqhi6dU/WRd3I6PudbbgEPaqgan/MOT/?=
 =?us-ascii?Q?FZOljwSmysbUmrN77BID1KFD/RmtRYxAf1LLleg5Kip1nJaMmt97hxdHAAc0?=
 =?us-ascii?Q?0+IqYznKDURfe2d6mcEemhrwUm8OwnTB3uWWXEOS8kjIonLpWegrF5hUj0fe?=
 =?us-ascii?Q?sIcMyhmZKJ0MEywlwzhpH+LhHooO34i6Nbzv9Pb9QVu2q0Iv7svkP6gK0+8o?=
 =?us-ascii?Q?cbGF85aY3Gcf+Ym+NfZKUI6GG3U2pByOM7ghnVSYH27C9L/q3Md3GgT2sK25?=
 =?us-ascii?Q?N46KnXK8OlI/E86zP4nMmCW7T8aRYVfWqhg9ESelCN4OfASWVMgYjCOCmk8W?=
 =?us-ascii?Q?tiQ3HkbwNNGE1b6qcI8dMuqeM8nIOzlCdLRWq6OitpSoI6A5D1GxvSDV3Olp?=
 =?us-ascii?Q?wuVokPToqaOil5IMt+a2a5kzOyzwybRpSZhouoLfoEQeKncRWc+3zIfB+jWa?=
 =?us-ascii?Q?je4lWdY5p2+UGrE3WBgQAGEIR+z3FCpkuG/sihe72bfLMSG3VQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:35.5935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b481ce59-6dd6-4fca-c0d3-08dcfa5629e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

u-boot.itb has been generated via mkimage_fit_atf.sh but it is on the way
out that's why convert it's description to binman.
Compare to script binman description is not able to configure BL31 and BL32
load/entry addresses which should be done separately.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch

 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/zynqmp-binman.dts       | 111 +++++++++++++++++++++++++++
 configs/xilinx_zynqmp_virt_defconfig |   3 +
 3 files changed, 115 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-binman.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 5d28a17b8b8c..25945efa5ae3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -320,6 +320,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-02-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-03-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-04-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-p-a2197-00-revA-x-prc-05-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-binman.dtb
 
 zynqmp-sc-vek280-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vek280-revA.dtbo
 zynqmp-sc-vek280-revB-dtbs := zynqmp-sc-revC.dtb zynqmp-sc-vek280-revB.dtbo
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
new file mode 100644
index 000000000000..df0fdf465107
--- /dev/null
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP platforms
+ *
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <config.h>
+
+/dts-v1/;
+/ {
+	binman: binman {
+		multiple-images;
+
+		/* u-boot.itb generation in a static way */
+		itb {
+			filename = "u-boot.itb";
+			pad-byte = <0>;
+
+			fit {
+				description = "Configuration for Xilinx ZynqMP SoC";
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				fit,fdt-list = "of-list";
+				images {
+					uboot {
+						description = "U-Boot (64-bit)";
+						type = "firmware";
+						os = "u-boot";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_TEXT_BASE>;
+						entry = /bits/ 64 <CONFIG_TEXT_BASE>;
+						hash {
+							algo = "md5";
+						};
+						u-boot-nodtb {
+						};
+					};
+					atf {
+						description = "Trusted Firmware-A";
+						type = "firmware";
+						os = "arm-trusted-firmware";
+						arch = "arm64";
+						compression = "none";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						hash {
+							algo = "md5";
+						};
+						atf-bl31 {
+							optional;
+						};
+					};
+					tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
+						tee-os {
+							optional;
+						};
+					};
+					@fdt-SEQ {
+						description = "NAME";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						load = <0x0 0x100000>;
+						hash-1 {
+							algo = "md5";
+						};
+					};
+				};
+				configurations {
+					default = "@conf-DEFAULT-SEQ";
+					@conf-SEQ {
+						description = "NAME";
+						firmware = "atf";
+						loadables = "tee", "uboot";
+						fdt = "fdt-SEQ";
+					};
+				};
+			};
+		};
+
+#ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
+		/* QSPI image for testing QSPI boot mode */
+		image {
+			filename = "qspi.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "spl/boot.bin";
+			};
+			blob-ext@2 {
+				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
+				filename = "u-boot.itb";
+			};
+			fdtmap {
+			};
+		};
+#endif
+	};
+};
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 310efdf2338a..09f487acf0dc 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -41,6 +41,7 @@ CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
@@ -241,6 +242,8 @@ CONFIG_BMP_32BPP=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-- 
2.43.0

