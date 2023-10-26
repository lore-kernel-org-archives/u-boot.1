Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992C9C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933C087B61;
	Thu, 26 Oct 2023 16:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMh7w8Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866BF87B66; Thu, 26 Oct 2023 16:05:14 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631AA87B49
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkRWKGWVw0iqr4Hg6n4P+0+cdbGezVaFK+1ZOk8/r4/mGW3eSsM2K7gXs7vuvBwLOf4UrZsvPxKeZQPEe2UCpbr0sjoFgHvrnGCIEp4cQ42MkulkZFca5NOu5ybzKAiHeQh99Te7UdlxOr8mwTVA8luqVwjaucaCLwoJOLziNhfFS9xBT1jKylmMFlO07mKB6HDlrZn5Ndyygxg0HoSr0ShN+8zOKHq6SEvtFBuo4d6pkSKtDq0YoSr0TE83bPsfFN2SicxnO2mkxoAh7XSj7uocQeYsyGnnwxw8Omm4yNPU5gr3kMgaS6nlqAobGjE6aRQgXh3QgTL1myCEImHhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/vcNzdIwjo0EF4V2/jvAViUYDQIh9AYmYfNiav9UOE=;
 b=dbazYUoi/mvbFaseCTs0RAIcByw+mXpMC+H6qLaeHBNKCr5anGrPskxOmgmnc2b5oyRxndcMOzUJ620mUJWhUEJ3uOErobS0A1Em19FITeHOShYlz4FUJR5MdKUDXb+n2kmx5PeAHxEhSgW4yD8yuixR+412xaiWNkOHH63H/D8nVS1+kXxmDp2ufd+zNVMVtdi6H7EEFGPZ+bJof5pMmDoVf35ZA1Lf1aAcKf7N9YEL7GsDsKgxkyqJu5PNC7qvH9VWYXN2tzgUmxQc9MY0yAwy+5bB0XxDjiid9TL0YttWOQsdoJpLkLFbKUFNidzLRYjeC6bwER6KTiHTZC+zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/vcNzdIwjo0EF4V2/jvAViUYDQIh9AYmYfNiav9UOE=;
 b=nMh7w8MjwzmEaHUYbAb/upX1AU1hOJqeNWTHlKP9xYa6nGkClEnq4o5UcCzMEb2jsmO5B8Jf2r/w6+5Liu+Gda2QqhHRbH/k8keBZLMxCqDHwAgPupvKbS8hNvPAQpYSvHoQi7FPKKwnyJDggC2GZYANTN5WGRm8hgNaMjYyZaY=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:05:04 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::d3) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:05:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:05:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 2/4] ARM: zynq: Add DTSes for mini qspi configurations
Date: Thu, 26 Oct 2023 16:04:50 +0200
Message-ID: <e7d31a9d9c4a76e171eefc619f31fabd0831a614.1698329087.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698329087.git.michal.simek@amd.com>
References: <cover.1698329087.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6280; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=F4a0OqhlyuudpfmLQp1S6UVa4Nj9X/uBSdyWj5e+MiU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSrIsaPF+5szv38ludl/NSDoTwHdbw/GljtfT+BlWlph
 1Z9+sn9HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiv5IYFsw9OfH5YlG/R6oT
 ub5Ofie3wTiqW41hns1Wdam5jj1J241OnG7OXsdTEmyZDwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6a8c00-8a00-422a-88fc-08dbd62c8d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95Vimj7q/6adjiRTt+Qb7IJ1OL6cfKRfuwdm5XwVM8MtAsU7oxmFlCbKeLnSzz+LTIGS4d2KP3qVU0Y3coMFUA03jPwVDgaK6x+s1M+/ZED9eO/HxlR8rxhppo1xrllPwBtxTrrPG0XDCOTE2iP1WdHlVaflmMJ6CZpoMivSXPJpGrQYKdF1HEyCrAsvtBrJYRpgW52kQqCIU/x9+8jHbzgtfY2kmRN42xw8KtQGan6fZXB/xwjyHjyKiOQd7aGn913ke4NbZx3O/+soALOcpfTlG0eoDtWiyYaliwW/JTI35K7L/Ax6bxwBO1z8/KP9bdmt5f3mRDgk7M1uQ1KyeMVWQaBEylbH4f4fCkAN79/6QhOhamQJ5C3ypdW2K+6qZJyNpSSKdi8bXlb5gK/I/LMN0z5g9tO44aXm6m+8OkUrnc575QkVbeC+Vv/5XpZEo4spuylWGI7VqOTjNg8zyOVOIoRbYBwVLMLcRNy9gk3ohq7X4wuwIz+q+Maw7v8nVAmrzIjsSBAN0uXnph2D0dKcajXStx6z96FXyoMWODZI9Wuhdisn/deiT8A9Yh2hqA7eVQe7SkL2R1g66f4V2CeH4G/fabiyNyIIU+p+4LhS2K7dFo37k3kQXvvv2vmFQE2s4IwWI6gzaaevCl7hrtzmzctsBKt2lTdYb0HVcQ1lIVpKoqvBcotVr/nWaZS1A2XeVAmOcTn1mf4oCHadaQUfv0TsIJ1dcjUiEo5Ayl/+u8Sm/gtvth0bgNkShohxYi5WwF3rge4eLlKgqKAimA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(2906002)(86362001)(36860700001)(47076005)(40460700003)(426003)(81166007)(336012)(356005)(40480700001)(5660300002)(2616005)(82740400003)(41300700001)(44832011)(110136005)(36756003)(316002)(70586007)(6666004)(70206006)(966005)(8676002)(26005)(16526019)(478600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:05:03.7344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6a8c00-8a00-422a-88fc-08dbd62c8d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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
volatile memories. There are different configurations which qspi can be
that's why describe them via DT.
DT binding is already approved that's why there is no reason not to add it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Core support for dual-stacked/parallel configuration is here:
https://lore.kernel.org/r/20231020031817.267959-1-venkatesh.abbarapu@amd.com/
---
 arch/arm/dts/Makefile                        |  7 ++++++
 arch/arm/dts/zynqmp-mini-qspi-parallel.dts   | 21 ++++++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-single.dts     | 12 ++++++++++
 arch/arm/dts/zynqmp-mini-qspi-stacked.dts    | 21 ++++++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts  | 17 +++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts | 23 ++++++++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts  | 17 +++++++++++++++
 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts | 23 ++++++++++++++++++++
 8 files changed, 141 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-parallel.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-stacked.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index faea47e81bdd..6a2f9cb20645 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -419,6 +419,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-emmc1.dtb			\
 	zynqmp-mini-nand.dtb			\
 	zynqmp-mini-qspi.dtb			\
+	zynqmp-mini-qspi-parallel.dtb		\
+	zynqmp-mini-qspi-single.dtb		\
+	zynqmp-mini-qspi-stacked.dtb		\
+	zynqmp-mini-qspi-x1-single.dtb		\
+	zynqmp-mini-qspi-x1-stacked.dtb		\
+	zynqmp-mini-qspi-x2-single.dtb		\
+	zynqmp-mini-qspi-x2-stacked.dtb		\
 	zynqmp-sc-revB.dtb			\
 	zynqmp-sc-revC.dtb			\
 	zynqmp-sc-vek280-revA.dtbo		\
diff --git a/arch/arm/dts/zynqmp-mini-qspi-parallel.dts b/arch/arm/dts/zynqmp-mini-qspi-parallel.dts
new file mode 100644
index 000000000000..728e8223de4d
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-parallel.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI Quad Parallel DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI PARALLEL";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-single.dts b/arch/arm/dts/zynqmp-mini-qspi-single.dts
new file mode 100644
index 000000000000..0f9306e988c1
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-single.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI single DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI SINGLE";
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-stacked.dts b/arch/arm/dts/zynqmp-mini-qspi-stacked.dts
new file mode 100644
index 000000000000..9a9541b0b619
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-stacked.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI Quad Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-x1-single.dts b/arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
new file mode 100644
index 000000000000..5af875cc7198
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI x1 Single DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI X1 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts b/arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
new file mode 100644
index 000000000000..ebf890e0ae90
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI x1 Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI X1 STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
+	spi-tx-bus-width = <1>;
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-x2-single.dts b/arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
new file mode 100644
index 000000000000..a5ab31583ecb
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI x2 Single DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI X2 SINGLE";
+};
+
+&flash0 {
+	spi-tx-bus-width = <2>;
+	spi-rx-bus-width = <2>;
+};
diff --git a/arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts b/arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts
new file mode 100644
index 000000000000..e234b76f2529
--- /dev/null
+++ b/arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZynqMP QSPI x2 Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynqmp-mini-qspi.dts"
+
+/ {
+	model = "ZynqMP MINI QSPI X2 STACKED";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
+	spi-tx-bus-width = <2>;
+	spi-rx-bus-width = <2>;
+};
-- 
2.36.1

