Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD72C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F13787B23;
	Thu, 26 Oct 2023 16:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oq54ZDYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A342787B68; Thu, 26 Oct 2023 16:05:18 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B59C87B66
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY1MRP3NWnv1f4sOAAVYUxaA/ozTE0wnHZAzkkdJd2B2SoyAMdRTfjhVg1WNGjWakGr7M97X+rbv8lAzdSN3/ANRJTpUTnwcBpB5JEmT7utRyQzgdywJoZpCE3n2OcUMDV4q4wHjXy4UrK5zHITWxo1DNAAx0iDx5tGVP5GeKAVZQHK1gkYK0nsMmmyMxCyLHcmoOP/yR7Tg7iENVpPS86OJrCJCFXNnjg25gpDA1B/4E4Vjxu99x1J3Alpmbp7TTtXe4FduppJ13ehLut8JdJGjTZqk59eROgYQ2gp3FJWCmW8qgTAVG6CS6pPL6JlK44m3DfoUPaSmSV0xjWgX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HnupfhS+bMj0ri0XyhDZJTzEyRBO5VqK6Ky38WGDhk=;
 b=IAgV8hCnRV43rVpcwx8ul/KBV+1W/89OLej8xoXtNPRmxJ+VggHdwPFt5GrM9CTY75COK/j/WErzVOOFJ5EOIqGuVdLN0Mh92+EbXUs9r8bRNuR1djbiHTLll/YZk0M92y5yy4fGBWU+g8LZJlvZ5uFNGvdy+Ao516qFZhpEJi7bvuqexklgG96vsrXudSnjckuEhppSxoqZWwCG0kfc+d/B0L5LsaCQBNnrQI8Xpgembj5oZNH+P7BD7S9HP6WgTYJIlf2FJBkENI+TW0h3fneWtq7/LX3AIzjAPsdEIzzTF8ojUCZKTbiloB+qDgmQcxhhKXgk8KKXgdWRUljlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HnupfhS+bMj0ri0XyhDZJTzEyRBO5VqK6Ky38WGDhk=;
 b=Oq54ZDYcYjZi+6cJNAEDZgrmX8cfWfrhDVjN7V6TZRi912tElp7uQ0yEQ8MeVAJ5HLwiCXiLZFUgIHehikj2IDqnHxdn711iz8ztoUItBm20zHtwZWWiCsKqQCscBdQ91bnTTNmuEjH2kbdY4mayEpSO6flxybQENzy5W12pyxA=
Received: from BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:05:11 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c9) by BL1PR13CA0237.outlook.office365.com
 (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:05:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:05:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 3/4] arm64: versal: Add DTSes for mini qspi/ospi configuration
Date: Thu, 26 Oct 2023 16:04:51 +0200
Message-ID: <9518ab1c4299a45e800b8611172edd78c9243132.1698329087.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698329087.git.michal.simek@amd.com>
References: <cover.1698329087.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3zyunilsfP+JdvanX7Lc7eaFXVwvMLqVmuS3kHBMPz4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSrIkbjf6lPJ55Mq9h69m+c5Z2fyft2b8k5KZW5w8c3v
 f7PEYW5HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAibtkM84OO64c0Prv4ZHX/
 NVm9uOwAu2MeXAwLZvW+mrfKqjNku8Ki7MbAlyftTvx/CwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 83244cc0-0b01-4b68-060c-08dbd62c91cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnFzs21QvxFyylaYquuKCc7NwErHYV8OWjoKcbquwfZ+h0LHz+2gGQoQdegBvN4ThavaXLy0NuYEMDohTUVV1VoFy19MM/0Yjty4dcoXCMdzcxIH9TDhw6vCGHxkzAvkuwpvW3TGw4Ti3Cqx/pyA5oLckOdHCJJB35Mlx0XEzgsqNzuA3gnl8/E6/Y0+ZWorIs4MhQwcx4BJxspgRX8LfBGWZjvsoRaL113cJlpCzdewD6x6413OXHgHHb/KLu4c65YsOQD0ye7BFIIzBIXXVHLDJyiI2FT78q/7Ld7fxMRYTwrCjy1dJRPuRjDV5+/2qmMbNls/rV9r168l7Xde9+YLmTtgu6M1CVPr5daVMvuRgAZncr1ajBLRj5YmYaYm8J9XfoKud8O43PWuZFFD5rPkPKCDqGUIs8CLFeWxaCjxL7SaQNgPtxkfkF4YcaU6S/P1EPda/61irOhBMBjRRofRo717nUNAWnouYtonunvqjFcP5LIkcxBZ30fafbmXSV2LLbdXdDHlWausevormz7HkCaVYiECFKnNtxdkXK+7N8GtvYOejog0AiAIjY1LHJ1pYkz2HGKytwF86kZAgI4BCQMx3VmH2FdCm7pIGy/iHP3Oqo22lXtbyt64CypJzWL/olL8PkbFWLq5MHyTmzorCHwBUhk+v6D8AXYHAuOXYSdgsi6+ph0G0VTchZjOZe+JcVVomWOR2bOkdXl3hWIkq+8meKkypeJ670GdDEH5Dc8mEJos/8eGPo4L5lS6skqmesMVAPp3B2cI3aKKBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(81166007)(478600001)(966005)(336012)(16526019)(426003)(26005)(356005)(6666004)(82740400003)(2616005)(110136005)(70586007)(70206006)(36860700001)(47076005)(316002)(8676002)(8936002)(5660300002)(2906002)(41300700001)(36756003)(44832011)(40480700001)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:05:11.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83244cc0-0b01-4b68-060c-08dbd62c91cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
 arch/arm/dts/Makefile                        |  7 ++++++
 arch/arm/dts/versal-mini-ospi-stacked.dts    | 22 +++++++++++++++++++
 arch/arm/dts/versal-mini-qspi-parallel.dts   | 22 +++++++++++++++++++
 arch/arm/dts/versal-mini-qspi-stacked.dts    | 22 +++++++++++++++++++
 arch/arm/dts/versal-mini-qspi-x1-single.dts  | 17 +++++++++++++++
 arch/arm/dts/versal-mini-qspi-x1-stacked.dts | 23 ++++++++++++++++++++
 arch/arm/dts/versal-mini-qspi-x2-single.dts  | 17 +++++++++++++++
 arch/arm/dts/versal-mini-qspi-x2-stacked.dts | 23 ++++++++++++++++++++
 8 files changed, 153 insertions(+)
 create mode 100644 arch/arm/dts/versal-mini-ospi-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/versal-mini-qspi-x2-stacked.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6a2f9cb20645..16161ed78d0c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -476,7 +476,14 @@ dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini-emmc0.dtb \
 	versal-mini-emmc1.dtb \
 	versal-mini-ospi-single.dtb \
+	versal-mini-ospi-stacked.dtb \
+	versal-mini-qspi-parallel.dtb \
 	versal-mini-qspi-single.dtb \
+	versal-mini-qspi-stacked.dtb \
+	versal-mini-qspi-x1-single.dtb \
+	versal-mini-qspi-x1-stacked.dtb \
+	versal-mini-qspi-x2-single.dtb \
+	versal-mini-qspi-x2-stacked.dtb \
 	xilinx-versal-virt.dtb
 dtb-$(CONFIG_ARCH_VERSAL_NET) += \
 	versal-net-mini.dtb \
diff --git a/arch/arm/dts/versal-mini-ospi-stacked.dts b/arch/arm/dts/versal-mini-ospi-stacked.dts
new file mode 100644
index 000000000000..f46125da7165
--- /dev/null
+++ b/arch/arm/dts/versal-mini-ospi-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI Quad Stacked DTS
+ *
+ * Copyright (C) 2018-2020 Xilinx, Inc.
+ */
+
+#include "versal-mini-ospi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI OSPI STACKED";
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
diff --git a/arch/arm/dts/versal-mini-qspi-parallel.dts b/arch/arm/dts/versal-mini-qspi-parallel.dts
new file mode 100644
index 000000000000..8485cda35298
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-parallel.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI Quad Parallel DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI PARALLEL";
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
diff --git a/arch/arm/dts/versal-mini-qspi-stacked.dts b/arch/arm/dts/versal-mini-qspi-stacked.dts
new file mode 100644
index 000000000000..54d42775e089
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI Quad Stacked DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI STACKED";
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
diff --git a/arch/arm/dts/versal-mini-qspi-x1-single.dts b/arch/arm/dts/versal-mini-qspi-x1-single.dts
new file mode 100644
index 000000000000..4d459a197892
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-x1-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI x1 Single DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI X1 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/versal-mini-qspi-x1-stacked.dts b/arch/arm/dts/versal-mini-qspi-x1-stacked.dts
new file mode 100644
index 000000000000..905dc773405d
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-x1-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI x1 Stacked DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI X1 STACKED";
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
diff --git a/arch/arm/dts/versal-mini-qspi-x2-single.dts b/arch/arm/dts/versal-mini-qspi-x2-single.dts
new file mode 100644
index 000000000000..d25ad7c77807
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-x2-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI x2 Single DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI X2 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <2>;
+	spi-rx-bus-width = <2>;
+};
diff --git a/arch/arm/dts/versal-mini-qspi-x2-stacked.dts b/arch/arm/dts/versal-mini-qspi-x2-stacked.dts
new file mode 100644
index 000000000000..0c9e740c7284
--- /dev/null
+++ b/arch/arm/dts/versal-mini-qspi-x2-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal QSPI x2 Stacked DTS
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc.
+ */
+
+#include "versal-mini-qspi.dtsi"
+
+/ {
+	model = "Xilinx Versal MINI QSPI X2 STACKED";
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

