Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B296E674BD
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C802B892A2;
	Fri,  1 Nov 2024 10:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Czkl9i3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61516892DB; Fri,  1 Nov 2024 10:18:41 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625988F4A
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehRKmajvMaVKM3WXiUFTYlrbjBXN6/P1nXtLvO6eMGz6a/6uRxHcSblKEJCn6UhvlF0InJtiVQoKDWQ/LsxgKcUXphnIX8xdWz6bpST+RhupdS/6i32g4GAIan3xyTuug46lRbCwZamdWGuDQuinJBqrqPhdZWE9CwBFuzSQzDbIIRnnQ7tUrK3yWF4cxkqnbtnGTONI7U/iNBvfnRwqOWf313lQIeaWVpdHw/WysmYDyF3B6R3yeRg2/L8j0evuMQziuYGLKPtkNkQyLOpLynezWMVDRp+3D/WvIaFaDPJS3JsfbKpzYuNZ9HzrB9kqq8sQQAmt9FMX6AX3kx5qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh5A36rCWOHoh2t+IPEOo4CF46kkzMwkOSz99PlpsTs=;
 b=tnWL0KIrYUcazR89Bfyy1cNGkQctwdRluKqZnR4y8zXfjmUYc5iFLknGa1KFT5ZCRAXyw3Jd5FEHDiNU105arLEC7fZPRfd5QzHTgrHJLOxzPyljlkOvu49ZwWXOPuDaYxxD/VAJajvAsXlZjxRslGjWzXvvCVTWZ6A7poZHZr0e072RRehfzd6Glhvyc8zqQ2nmDU8LcI+f6xGRrUEWDcfIN5k1ad/1x7G3bbYZkM2540uqMWzj2ItuSHEC7Kefzvjn7AmJy5mbsBX7Hsd/1ncsMpjChHYsBSWziiZ6imaUh8O1zoojFBeSag1IOwSWkyfwxcIrlC3tahPguLMrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh5A36rCWOHoh2t+IPEOo4CF46kkzMwkOSz99PlpsTs=;
 b=Czkl9i3G8AYGMtcn1O5CU/MtTtpUzwAWEaeheUsLvhaXSMduofOelwQ7LXLYwQhm0MhNpPAGG6ZP5eyZSGHK2NqStkeO1zqkLtPvXCBTbG+Z5S9TY4ZAvac7oZMFESMxD4Lx+84KszAMabCML3xZy5UVS01DBDZH0Qqab9Nc5lY=
Received: from BN9PR03CA0130.namprd03.prod.outlook.com (2603:10b6:408:fe::15)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 09:18:34 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::f7) by BN9PR03CA0130.outlook.office365.com
 (2603:10b6:408:fe::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, Tony Dinh
 <mibodhi@gmail.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 3/7] arm64: zynqmp: Describe empty binman node
Date: Fri, 1 Nov 2024 10:17:56 +0100
Message-ID: <14d874ad4568fa8e3178e893224fecc5c676f04c.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730452668.git.michal.simek@amd.com>
References: <cover.1730452668.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6205; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mBKdhbTn5qSQK2bw39Ph+0rAzSuYFQQjswkxHn1y8OM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOYc1vPsCJGZ8dfpcMom9OelETmJsMEP+H/HlD3Y6s
 NdvFXXqiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABMJf8sw38UxVaHdI7DnRacR
 e690Q9xsRy0phvlFOkXfUm0OhOTEHrqvXWb9fffpwBcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 14865b4b-36d8-4adb-f301-08dcfa5628f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUqiMBgbLnaDKAq/VOojBVzbuEdal9fr/EwIfFPGkiU/TAsfRqBKQUT23UzP?=
 =?us-ascii?Q?I7f2+nicgv12vYs/fIg400VkYO7ps71ziKM83hapRjKRTHQecb2TYFMRYXIF?=
 =?us-ascii?Q?CDDnM4/MqZ005B2/ivSzGg7joeChEe/dt5DIMnlGVxmOFHbZ/DkyVxRTSts+?=
 =?us-ascii?Q?qzRmWKdYz8MpWI4KCgdcCLyBkIv2Sdjj8BO8uEEqt/tJ1kEdbpSZZtB/eAnj?=
 =?us-ascii?Q?gZph9ZFga953pzxpzs9JOL75ddJfzzfjAQMJY5Y0pIkfh1irP+c9WI+UXPr2?=
 =?us-ascii?Q?c9UP3L23j6dJ5wrTFx8FqCAEn8nryBzPMpZ7cI8P7xuhgcQ1+D7xnjhg1ROm?=
 =?us-ascii?Q?BYMbq0UyYOVRSJV6qwkzfGoQVM8Lzrb4nvY4IX7doUeno9i4xNJkwCFSXM+B?=
 =?us-ascii?Q?dUOpwglvnxQPUMOBr7KwWgMnoZT/PpTEAXuxghvOzqv0sZw7PSoxqwHg4nX0?=
 =?us-ascii?Q?fimZ9CDKpCtodCgM1vB7/lnrBr2nU1+O+1jfDODypwbUL0d1Ceo96meWi61I?=
 =?us-ascii?Q?k8giJoC5UXcjtZOmXHbS8fPi5BW7ECA/i6id8/h+DHUXE2WuOFqR9eag+Kgc?=
 =?us-ascii?Q?rDfuOsj7sbChLyxlQY9bZbM9dBJ+aLiCv/KD4vlHu1K9FiUrDfRp9tM/lpoi?=
 =?us-ascii?Q?g7/pdrRYrRt/P9nJks/NV7XNdYcpvQ3dVmtUuHqZEuK7gozzNy0/kf3QVrK+?=
 =?us-ascii?Q?SOJmivFvCgmD/GyVyV+qiWEcaXPllQHW6MLcJQO0qgZp6TpZoHAZXwzlGTMb?=
 =?us-ascii?Q?W+6vGmZQ7h2EXoLtrqyZryDu/LtrQ7+HEP/40a5N9+xmchi+i74dSj/huZ2o?=
 =?us-ascii?Q?X+7w1nKzinm9L1KYe0GopAxtTXLK5lgEv3+qWelWLlw/3DnD7PkSrHxg7sF4?=
 =?us-ascii?Q?RZld4qqBOf90cKrg/ESHiKpo1BZWpRjN1beRXEhpKrb/neeD/8/MmW2k88Yn?=
 =?us-ascii?Q?WKmiBV0Cf9Z57xYx5SCzSegVxcU5NYtjLxg9nW47jDPX3oAdwi+UmP+A4j3O?=
 =?us-ascii?Q?/XlTJftX+auandwAxSVLBhVs+/72XqiFPJlRseOZMTWMNH/mmdDNUp0fh0z2?=
 =?us-ascii?Q?Ds3NoKb5Nk2AJSdMjCMMtNRxVjE998/WhQoLnwaHbzn9Cwybm1Pk3sLazcFi?=
 =?us-ascii?Q?eq+MBrDt3PYqC+BQi3oRAPboz/2xEidHgOSRsxSxyBvz9JawQSGEhMN/VwsE?=
 =?us-ascii?Q?+fLqlS1ZS48Z40lpJEanS+R/blNiJGP8ScXGgHejz49EFwWvw2/gZRn5qygm?=
 =?us-ascii?Q?ZlahNG0PDl1+bhvxPX+xZIAsYjEIVn0rkMugAlTodAlP87mGQJFsN7AoSN9q?=
 =?us-ascii?Q?q4SLm15arK760/JD/DkuLRa2d5m0DF4Vf6wJWYZbQy2MO+hNIrs4aik0ELZA?=
 =?us-ascii?Q?G+U/kIhPTIDs3bI+RvMEBoe9NAtROqCfJxT1QHkcUfjuNv7wcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:34.0153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14865b4b-36d8-4adb-f301-08dcfa5628f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

For enabling binman by default there is a need to have at least empty node
present that's why create -u-boot.dtsi with empty node to cover all ZynqMP
platforms.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- new patch

 arch/arm/dts/Makefile                            |  1 +
 arch/arm/dts/zynqmp-binman-mini.dts              | 10 ++++++++++
 arch/arm/dts/zynqmp-u-boot.dtsi                  | 11 +++++++++++
 configs/xilinx_zynqmp_mini_defconfig             |  2 ++
 configs/xilinx_zynqmp_mini_emmc0_defconfig       |  3 +++
 configs/xilinx_zynqmp_mini_emmc1_defconfig       |  3 +++
 configs/xilinx_zynqmp_mini_nand_defconfig        |  2 ++
 configs/xilinx_zynqmp_mini_nand_single_defconfig |  2 ++
 configs/xilinx_zynqmp_mini_qspi_defconfig        |  3 +++
 9 files changed, 37 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
 create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aeccfa93fc53..253d883d6156 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -274,6 +274,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-qspi-x1-stacked.dtb		\
 	zynqmp-mini-qspi-x2-single.dtb		\
 	zynqmp-mini-qspi-x2-stacked.dtb		\
+	zynqmp-binman-mini.dtb			\
 	zynqmp-sc-revB.dtb			\
 	zynqmp-sc-revC.dtb			\
 	zynqmp-sm-k24-revA.dtb			\
diff --git a/arch/arm/dts/zynqmp-binman-mini.dts b/arch/arm/dts/zynqmp-binman-mini.dts
new file mode 100644
index 000000000000..8f3d18ef394b
--- /dev/null
+++ b/arch/arm/dts/zynqmp-binman-mini.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp-u-boot.dtsi"
diff --git a/arch/arm/dts/zynqmp-u-boot.dtsi b/arch/arm/dts/zynqmp-u-boot.dtsi
new file mode 100644
index 000000000000..9a7527ed5a10
--- /dev/null
+++ b/arch/arm/dts/zynqmp-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/ {
+	binman: binman {
+	};
+};
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 7aab69c9e46b..f0af27bbd4e6 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -59,6 +59,8 @@ CONFIG_NO_NET=y
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index c56b1e830d67..9b3ab06f7c00 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
@@ -73,6 +74,8 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ARM_DCC=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index a8dbf0056da3..3b088c5002a7 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -28,6 +28,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
@@ -73,6 +74,8 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ARM_DCC=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index ba8f02c5b11d..83bd3c9a5345 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -59,6 +59,8 @@ CONFIG_NAND_ARASAN=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SYS_NAND_MAX_CHIPS=2
 CONFIG_ARM_DCC=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index a8a0055f2e5b..fea0c6e08415 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -58,6 +58,8 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_ARM_DCC=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index c08b10c6944f..39e50ff8c4f8 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -31,6 +31,7 @@ CONFIG_LOGLEVEL=0
 # CONFIG_BOARD_LATE_INIT is not set
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
@@ -91,6 +92,8 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_ARM_DCC=y
 CONFIG_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
 CONFIG_PANIC_HANG=y
 # CONFIG_GZIP is not set
 # CONFIG_LMB is not set
-- 
2.43.0

