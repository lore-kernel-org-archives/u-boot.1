Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FFBC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214E087B6D;
	Thu, 26 Oct 2023 16:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDozXgqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E1A86FB0; Thu, 26 Oct 2023 16:05:13 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2AF487AEF
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRbIHzQnV7tYxg5gKhDwXleYTYgIRAiuaeNcZJjBC1gaYPEFjdHZZj90pRQ7LFLLmDYT5ERMwZBmb5WAL1UAdpjT5i3dUtzUHIjCRFiuTLZVAyo8Br2mw2cKF6gfWE75mxMH3w5AM+FM+hDyZfmJePpTsBHztdUDszZZ81HAvSG0fQDkKOOn0357McMzr3hmhzAExRHvrVslHgZBRGotlA7trDfNaK4SDHovCy77X1O9awofeOFYY3Ec+5yw6Z360KmwRN1QDpfmjcI8Ko0OdDgXB2pN0hdt/cJg8G1xpLmqojJ4w3AGz4goBYfuJhf9p1MZwbTGG9H4ZubjwCd4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbwYDcfZduy1DMUpY6DlKlYsDBI5xmD717GY4AApU+Q=;
 b=O33ZxuCy4zevH33lE5qnunJXyZIJm3tZBr3BrqO8T/cnW8K/K9a1F4mXDcDFjsJiQf73hyigxTH6y57H4jyD3GZWh/QdIRaOj6gxFSWQDBp7edS6R7Zl5LkiXj0IwvgiUrc0Z6W4H/+rXhYgVVtE96ImOGYnuNWRvRjqJxga7Bg0Q+Lnb/LFrF2soS85woDTnQLn0SaaDKrlHIpFIiLccCgV6cilZlWRkFJzcwunxj+sTeDcNaPlcnq3JFuSYI5+MhIrm2VWLKxThZNrGjklkC2VimSo3wZclvwi4GaA2yigF1cAqVFU5DFxjmCuF6keWwHDmFUEGLRQ3+oZH5pjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbwYDcfZduy1DMUpY6DlKlYsDBI5xmD717GY4AApU+Q=;
 b=kDozXgqOlSGscUoMj+Up1O8iKKgo11sgO3Tqj6Ur76DtE693a8Mj1+hadG9lN/80/VGTDwbNP71PDyGpsLaYztEb0ghKaRD3nU+HbsoB/TyswJBvHmuC5f0M7zpg5dH9IIj6THX2gn/RR5J5Kq/VuhLDjoEgY/6KcDI7usjvNpA=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:05:01 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::45) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Thu, 26 Oct 2023 14:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:04:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:04:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/4] ARM: zynq: Add DTSes for mini qspi configurations
Date: Thu, 26 Oct 2023 16:04:49 +0200
Message-ID: <28b3cdd7e91b2b4c3c36d0bf65aa5bac042f248c.1698329087.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698329087.git.michal.simek@amd.com>
References: <cover.1698329087.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5460; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gvREj6bJTMwbBzTfvwGN6rndhMoeWgdDDM6Ef0EnGIw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSrIoarC7RY/GPeMf0usnmYXal363zCfvHVL7ecufRVJ
 LK2L6qvI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkfg7DPN2jVz/P3KXZZpcn
 mlQhEHrLLKtcgmG+E+uKuiU9GVnGGj17y56yKnzhMuoGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e02c93-5641-4818-ccfc-08dbd62c8a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2mxNphxucvCfeRSxzh5mkdgMfYVvYrQUrV5crHPx/kWKzxV448huhdOo5vFCBcRuhxyqlTo0mc5L2uhx7OgTPQMDk/Z/yU9AxPbyv6U42u3dqQDHTL5MzQ0gKlt1+W2WVm3mrOW7Klrx9bApVZxvCWE8ekIDzjxCwjXFbaR00EKh0iSqo985Zd94+855P6jY9XZ8uUtAbPQjbHqDzV620dVpA90Hz842rguCaEH8YC16wcl0KrVdNrWbeSEGtek1QEHu9CEN45T2zwTb4GEvE/azIsHqlO77NdTMDTea2l55v256eXU1r5lgaEqo5NCLDHKD2kG6rXbHrt99OmkyvcfiMY4BKjh6kZeAMjERJuYhLCn7J+r6G4Qyj+hcEMN2flcIBwpM2QhnyoRldtV6uh6UtLLUzu+YsnpxrSPvhvvH/Zh4gZn0xO1E2NM6LcRt1VWo4eBtcndej5e2FF4tcHJl9cGsaAN42e1BKLGZeHJiOXM6yK1DIhttYlhm9oQDeUaa1PuFh8RulpCnnqyeXcop+tlBGXzOQH9ZOPV2pPwQ5R8eJOflW5jO3nWjzA8/LuCxNJGczVSv5mj8NQRsLkyAdrRX4cRrPj1zKjwe8smGWiRUH1+YmJg6cBUDmnmfElCxtmNVIHPY4a+iJ8/fEIygLHWsOS6+FU80lIBGARtyONBgi7s8FPtYTCyW4sdWalqq94JFKfKo4SR8/QwvQ1iOf+9C/F7AdlkY265ccvRVXWMc53p0tEcYiJpFQ63/nn97srtz6WkX2xpDcTtAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(36860700001)(2906002)(70586007)(356005)(316002)(70206006)(110136005)(44832011)(2616005)(6666004)(81166007)(16526019)(40480700001)(336012)(966005)(47076005)(426003)(82740400003)(86362001)(36756003)(5660300002)(478600001)(40460700003)(8676002)(41300700001)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:04:59.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e02c93-5641-4818-ccfc-08dbd62c8a8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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
 arch/arm/dts/Makefile                     |  6 ++++++
 arch/arm/dts/zynq-cse-qspi-parallel.dts   | 22 ++++++++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-stacked.dts    | 22 ++++++++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x1-single.dts  | 16 ++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts | 22 ++++++++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x2-single.dts  | 16 ++++++++++++++++
 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts | 22 ++++++++++++++++++++++
 7 files changed, 126 insertions(+)
 create mode 100644 arch/arm/dts/zynq-cse-qspi-parallel.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-stacked.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-single.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-single.dts
 create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 96066a2b6b87..faea47e81bdd 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -372,6 +372,12 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-cse-nand.dtb \
 	zynq-cse-nor.dtb \
 	zynq-cse-qspi-single.dtb \
+	zynq-cse-qspi-parallel.dtb \
+	zynq-cse-qspi-stacked.dtb \
+	zynq-cse-qspi-x1-single.dtb \
+	zynq-cse-qspi-x1-stacked.dtb \
+	zynq-cse-qspi-x2-single.dtb \
+	zynq-cse-qspi-x2-stacked.dtb \
 	zynq-dlc20-rev1.0.dtb \
 	zynq-microzed.dtb \
 	zynq-minized.dtb \
diff --git a/arch/arm/dts/zynq-cse-qspi-parallel.dts b/arch/arm/dts/zynq-cse-qspi-parallel.dts
new file mode 100644
index 000000000000..afa6348cf595
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-parallel.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI Quad Parallel DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI PARALLEL Board";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	parallel-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+	spi-rx-bus-width = <4>;
+};
diff --git a/arch/arm/dts/zynq-cse-qspi-stacked.dts b/arch/arm/dts/zynq-cse-qspi-stacked.dts
new file mode 100644
index 000000000000..47859f7ea84c
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI Quad Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI STACKED Board";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+	spi-rx-bus-width = <4>;
+};
diff --git a/arch/arm/dts/zynq-cse-qspi-x1-single.dts b/arch/arm/dts/zynq-cse-qspi-x1-single.dts
new file mode 100644
index 000000000000..c14fb422b7fd
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-x1-single.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI x1 Single DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI X1 SINGLE Board";
+};
+
+&flash0 {
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/zynq-cse-qspi-x1-stacked.dts b/arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
new file mode 100644
index 000000000000..0f4d414a2534
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI x1 Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI X1 STACKED Board";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+	spi-rx-bus-width = <1>;
+};
diff --git a/arch/arm/dts/zynq-cse-qspi-x2-single.dts b/arch/arm/dts/zynq-cse-qspi-x2-single.dts
new file mode 100644
index 000000000000..11be06385da2
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-x2-single.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI x2 Single DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI X2 SINGLE Board";
+};
+
+&flash0 {
+	spi-rx-bus-width = <2>;
+};
diff --git a/arch/arm/dts/zynq-cse-qspi-x2-stacked.dts b/arch/arm/dts/zynq-cse-qspi-x2-stacked.dts
new file mode 100644
index 000000000000..d1b42e9269bc
--- /dev/null
+++ b/arch/arm/dts/zynq-cse-qspi-x2-stacked.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx CSE QSPI x2 Stacked DTS
+ *
+ * Copyright (C) 2015 - 2017 Xilinx, Inc.
+ */
+
+#include "zynq-cse-qspi.dtsi"
+
+/ {
+	model = "Zynq CSE QSPI X2 STACKED Board";
+};
+
+&qspi {
+	num-cs = <2>;
+};
+
+&flash0 {
+	reg = <0>, <1>;
+	stacked-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
+	spi-rx-bus-width = <2>;
+};
-- 
2.36.1

