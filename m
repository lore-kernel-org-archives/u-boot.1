Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E604C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BF087B60;
	Thu, 26 Oct 2023 16:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAwb4Y7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D1F87AEF; Thu, 26 Oct 2023 16:05:18 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15CA87B5E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8UOWD4yVpk/wN5Iw+ZLL4bm8rh9WDom8XRDndJK5ZbR77NshiX8aRKRHko4w4Bw3Ns2PWHanOsHZvbQTsDQ4ocabtk3H/2rVfAj7AR8y6Xbj066+6GESrl8IyAsdcPOfn1IFT9iXgkFFG7OXD0N0PRbOVx+hcysmcwJqAw6A/s96RhIIcDez+gK+bWLFiZw8Im8jfksjg8pL0VD9bWXggQ+ll755HSFYl9xWSj8UmS0ep5RKqiZVFPrZc4jH7XtDJlk/Xv/DNb0mfPPkmpYW97cpCmb9z6az3LKgF1/zw6eigZXLFDyXYlmo1V5INBicK8/8TCKqiuOGebmbK2EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcIOr7nayY6tZSOwI7BXzEPU+JKBRZAwtjr7Uc5O5cQ=;
 b=WuJaid614ZIImAjNzuDwe/3P2eYNbH3HdAHOXqRMSUvPEEB7pMwBm1iX8WUup4nrnVnxVu3EDt9rlO5NeTL17BXHdQQVfJDusdJDfHUVeei7pno+Mrz5OXiuvA4HKlZ0ih+7eHtdaTnwG14CeA/rXBy/rZgwF0M4AUfFWqXgpFAE3GDXjGgUCrssDm/94GaKAqyUJHinWwsh9i/Q8ORsz3s9JJPtHp7fJ2mB/2aLMbSu7HN7PcTOBjnGybLUntwFYrf8lZ0SGN0VKOqEtqPamJ5vyocwnhf+SbKRjBtz2CmZCgua3RShLLsEQ5s92FghWW8fGuMzt/58Pb4uoVGj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcIOr7nayY6tZSOwI7BXzEPU+JKBRZAwtjr7Uc5O5cQ=;
 b=AAwb4Y7zQQ0im/C3DBsXqJGE+blk8nazjthXajqvrU1vrgz1krFbxSSkCCTAlNFwFs26p1sZobPWSGRieccHMzZ7R7wl9aGI4yvvdDz9IgCqTn9HavS8JyA5TCSiwfG2HKVvc8WFlwheNxnA8vaymcqgt/fZtkVREYHSaCWu68w=
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:05:12 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::e4) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:05:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:05:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 4/4] arm64: versal-net: Add DTSes for mini qspi/ospi
 configuration
Date: Thu, 26 Oct 2023 16:04:52 +0200
Message-ID: <a99a8d72201a782fc811715942dea97fb5ab583b.1698329087.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698329087.git.michal.simek@amd.com>
References: <cover.1698329087.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6905; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zWtqwgDVO0idf0SIH0/I0K6UuqMGc+5Qm6njFK30gdA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSrIsaLCe/YWLyeH8k815LENr9se9nhuY+vybSlLj+kn
 N0yi6+xI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkNx/Dgpkuh+Mfy02MeyaZ
 zh6jJlZ2TPQzG8P8oqb7Jb79TNkhN0X4+Z1DnrxXuGMCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 313ed580-2fc0-4e38-2790-08dbd62c9250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/SjMISK4FCgxNb2MIGsBgR0QhMoVqhJGs/Tm3sZFtg6BKo5Nc9PVbaTTdjiKjSrkv03eFAqdklj0mPvRjHXseHNjhX7hz8PWn7JOL4jJZODJfrC+zO74gcHZUXHm2ADkCneUHZBCq89/auD8YW3jsePPtabsqEy+CT0wB3Os3hwS6NLhFJPSJ6zovObZpQN3flDoCLSCPifMWC/jRKxxoGptsdQSfHtnrzWfMTQHnmarDgkzPdBx00ffAOuPb4S+M+FciDFi2cwy+SwweI+35bhPNeTPg8sTHmIWc7nRXqRZS7/bPIxQ5FuY1KBl8CgEiGtAKdB5Tp01VC+ir454F7bGkkOCzPqHAGQXRuLHkzFn0XK7KruvZRakNNSTm1fQxHpCforFWlFV6dAPjkKEm+FYXwQ3i0pZjAG8HL5uWDEgGnrdzRVwh0ZWvGpZwneCDsFhTw9IBBYsAgHwC1udSn/CDXA02bc5gbZg8GKPO0Ux5ccHEZKoEaZmZ2w4CMqLZDbKBQTx6pszKVb6HiuSVPqQ+lrvEk2z6+SGikBN2rstxyzd2NXhKtQJyEPbODAsWmqpXJIAPLS9ko8ssH/xRvBQRupOZK+ys4tg3l3/92MLqfmHtbh2XAz1v5hSzvYGUOgXIiLyb8SmT5BJwqtNcwiuLxvyvUyti5JU0lk6v1I+CBh4B8ExHeESBaXNAgxxwdUOj47hAywaXkaW+kF9HMdkkzkpxYV496pzgH5kr0mw7TGo8ZAxlcnq/P1LHrcYkcHOeWdtPbQigxfh28FxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(41300700001)(40480700001)(44832011)(40460700003)(356005)(26005)(82740400003)(81166007)(8676002)(8936002)(70206006)(316002)(2616005)(70586007)(6666004)(36756003)(110136005)(16526019)(478600001)(47076005)(426003)(36860700001)(336012)(966005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:05:12.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313ed580-2fc0-4e38-2790-08dbd62c9250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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

Mini U-Boot is running out of OCM and it's only purpose is to program non
volatile memories. There are different configurations which ospi/qspi can
be that's why describe them via DT.
DT binding is already approved that's why there is no reason not to add it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Support for dual-stacked/parallel configuration is here:
https://lore.kernel.org/r/20231020031817.267959-1-venkatesh.abbarapu@amd.com/

---
 arch/arm/dts/Makefile                         |  7 ++++++
 arch/arm/dts/versal-net-mini-ospi-stacked.dts | 22 ++++++++++++++++++
 .../arm/dts/versal-net-mini-qspi-parallel.dts | 22 ++++++++++++++++++
 arch/arm/dts/versal-net-mini-qspi-stacked.dts | 22 ++++++++++++++++++
 .../dts/versal-net-mini-qspi-x1-single.dts    | 17 ++++++++++++++
 .../dts/versal-net-mini-qspi-x1-stacked.dts   | 23 +++++++++++++++++++
 .../dts/versal-net-mini-qspi-x2-single.dts    | 17 ++++++++++++++
 .../dts/versal-net-mini-qspi-x2-stacked.dts   | 23 +++++++++++++++++++
 8 files changed, 153 insertions(+)
 create mode 100644 arch/arm/dts/versal-net-mini-ospi-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 16161ed78d0c..ef6baf4907e9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -489,7 +489,14 @@ dtb-$(CONFIG_ARCH_VERSAL_NET) += \
 	versal-net-mini.dtb \
 	versal-net-mini-emmc.dtb \
 	versal-net-mini-ospi-single.dtb \
+	versal-net-mini-ospi-stacked.dtb \
 	versal-net-mini-qspi-single.dtb \
+	versal-net-mini-qspi-parallel.dtb \
+	versal-net-mini-qspi-stacked.dtb \
+	versal-net-mini-qspi-x1-single.dtb \
+	versal-net-mini-qspi-x1-stacked.dtb \
+	versal-net-mini-qspi-x2-single.dtb \
+	versal-net-mini-qspi-x2-stacked.dtb \
 	xilinx-versal-net-virt.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP_R5) += \
 	zynqmp-r5.dtb
diff --git a/arch/arm/dts/versal-net-mini-ospi-stacked.dts b/arch/arm/dts/versal-net-mini-ospi-stacked.dts
new file mode 100644
index 000000000000..4bc954a18334
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-ospi-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET OSPI Quad Stacked DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-ospi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI OSPI STACKED";
+};
+
+&ospi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x8000000 0x8000000>; /* 128MB */
+	spi-rx-bus-width = <8>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-parallel.dts b/arch/arm/dts/versal-net-mini-qspi-parallel.dts
new file mode 100644
index 000000000000..edc231160946
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-parallel.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI Quad Parallel DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI PARALLEL";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	parallel-memories = /bits/ 64 <0x8000000 0x8000000>; /* 128MB */
+	spi-rx-bus-width = <4>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-stacked.dts b/arch/arm/dts/versal-net-mini-qspi-stacked.dts
new file mode 100644
index 000000000000..920eed2f8c5d
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI Quad Stacked DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x8000000 0x8000000>; /* 128MB */
+	spi-rx-bus-width = <4>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-x1-single.dts b/arch/arm/dts/versal-net-mini-qspi-x1-single.dts
new file mode 100644
index 000000000000..856c79c3c002
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-x1-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI x1 Single DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI X1 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts b/arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
new file mode 100644
index 000000000000..5f74d98ad618
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI x1 Stacked DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI X1 STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x8000000 0x8000000>; /* 128MB */
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-x2-single.dts b/arch/arm/dts/versal-net-mini-qspi-x2-single.dts
new file mode 100644
index 000000000000..6ceaa244e68a
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-x2-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI x2 Single DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI X2 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <2>;
+	spi-rx-bus-width = <2>;
+};
diff --git a/arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts b/arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts
new file mode 100644
index 000000000000..5f4d0b550590
--- /dev/null
+++ b/arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal NET QSPI x2 Stacked DTS
+ *
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ */
+
+#include "versal-net-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal NET MINI QSPI X2 STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x8000000 0x8000000>; /* 128MB */
+	spi-tx-bus-width = <2>;
+	spi-rx-bus-width = <2>;
+};
-- 
2.36.1

