Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56445E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DDF86DEB;
	Wed, 27 Sep 2023 11:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CxGWOQJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF2186DE8; Wed, 27 Sep 2023 11:54:19 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6311F86D80
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbLrj/egtK4GYeew7ZqCnrzkEUGzaRb1wb8dYHdLUuKuXFE0F8B5HSRMDeTaDoRzMHV1nOTvdbPBx0+20m3W7GsCSAr3iPe3y8QK38gHoatcXNPz17N2ML/5JI/2iyn9zAwPfmgdX6Xv1Toqxzd3vusmWIpo64omR14KOCFpGXPZlXm/sToEzSdenHMXPu2ZMmJG1puvrAuHvkhifqMXRsqAAJu3loe4EiVMbq9yHrLLRiz6ObL0w3azwZLGAUiL5WFFsgO4HrfMp4oU9lyrSyy/3Ym1HKEyU91TWXeqGVgFMPAT/JF1Zybgjoqq4L742yHJrYxbVSZmbkJufQnWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtKUbFAA0QUcSmJhgC4pscMWODajlMo2oWDVANzaPN0=;
 b=LmPsugn5/rTlOiY7jaORkIVkt/5WrOCZK49RLfaXkZ2WpiFAyf9S0QSb0XyIIwDFarjY99MfovxJVeyQdrILYewzy41BLQANL0PctfcXzaqkGogGk8j06chnAXAeeO/zCL6chjYZEkjydrg3f2AJMS1EAWwUQ1OIBUhHyW8HF3Is4bYsM5w7iVb0vYrsZZGYty9c6FFVFqcyHLyDrR8eTVXeWafIjm2+rDTTGg+POlkKRnrlCKrY/PUDZwq8MAA7IvgKaDKtdtZSeERy33xagMH2DK8cILuh0BirsA8S/90ag/cPehurZbNt9sFHkqrKm+QLzLPWq4YaNx8G71b17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtKUbFAA0QUcSmJhgC4pscMWODajlMo2oWDVANzaPN0=;
 b=CxGWOQJkhd/oFrzU89bAOS+VbVD3wznvFIYAjTv6v/E94B0fP+wDi7r2e7nziPtO09wvqCnA33bPY9n+3WWeanjEhcUMrRh2vU+IcXUct+bnuP6rm/AAAUvw7uJnreTbGxSJ76gVEngbxMPC+sHlDheZEv9fYivuP83o3FvWduk=
Received: from MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:54:14 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::20) by MN2PR05CA0040.outlook.office365.com
 (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 07/11] arm64: zynqmp: Add support for SC revC
Date: Wed, 27 Sep 2023 11:53:33 +0200
Message-ID: <2790f6cede7485556d581ab8270dda477fa21522.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fR1ne2VAX54jSP3HM2YHn4RVb7es2P+K4lDY6vNXOms=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3/OUO5Z2TOuSn/tIznzVV7Ffq0TqPk3NY6r8avt74
 sHbyywMOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEGucxzBVj9QlbcEr+3GeR
 fN7ywFVHFe8YujHMZuN2myh2hHGl4PQi2QcPioXvdnAXAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dd1634-31e9-4922-9363-08dbbf3fb47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRlVx84tJ2gKhUofY2ViUsqv3+Q1WURSBccPMkcNZ6MNfT4TiwQm7QAm4FO/SvkuzH3J8W68tZQumgAXPPp3P5kP+lmcIXZW4MtgRE8qeZvRVAAhnHbMiC1RK208WizbjARPNK9iM85SmuCxLIOnsCC0ndhQlJVeJz9KFgYTm2SLI3XuydXDty5S6gICXHRu7T1SaIfnOXrjWkRx8JcjVOIf7o9enz7GcIVNbeKxhNaA1f7e/te2mO/SnqPBfjtu1vf/7Lmu9UGMUVjdQ0vl5xD5geVdc96+3cVCY80Sif0QF583VhuopY6LA+SUUaGPpVfN/iOUTj7CfM6xthRASzulzfWqSxNOZl96LgYkGvhDf2eHUQ3EN3Pg7vlSuPACfSaWNIfMEHylmzzkzscmQSWwZWm8iy3b9HBL6PjgcVHhYl/Dk74Tmk5PI1CB+lOJiyhzMOQP6n0CL38cYlMM/uG3PDPvlikbz9P08Jmuo/Pm2lc40WjF4yGkRh5GYzvpEqI9FoWtu3ih+u+wgP/U2disv16r8DLxlU3u2lpTG2bRFiIMrzhG4vcV2LDNKiIvcwuFEFTWla6C+Qe/gz58/mbIWhXiKSwoHrSB0heF1E8jvtFSTutGPtGk0zO4SPO6NFVHQhDjB+oPqXCogxpRHcLWS1oYCdCy27MgG5YuA7UjGC63scDE/LbyreXJKkRu2THnJuS3cIalqrTFpC4w7QTC8c5XhD4QIZyLRWI4CagOn5hj3cr1pufVXa//PmQlODaic/difc+mQombbZQcNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(47076005)(86362001)(478600001)(82740400003)(36756003)(6666004)(26005)(16526019)(336012)(426003)(83380400001)(81166007)(2616005)(356005)(40480700001)(8936002)(41300700001)(36860700001)(8676002)(316002)(5660300002)(44832011)(70206006)(70586007)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:13.4692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dd1634-31e9-4922-9363-08dbbf3fb47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

System controller revC is using ADI ethernet phy instead of TI because of
supply chain issues.
Describe reset assert and de-assert times to 10us and 5ms respectively
according to the datasheet. Also setup RGMII RX and TX delay values to
2400ps as per board bring up observations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile           |  1 +
 arch/arm/dts/zynqmp-sc-revC.dts | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-sc-revC.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 29c40d1c3b66..3cde86d9eb38 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -412,6 +412,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-nand.dtb			\
 	zynqmp-mini-qspi.dtb			\
 	zynqmp-sc-revB.dtb			\
+	zynqmp-sc-revC.dtb			\
 	zynqmp-sm-k24-revA.dtb			\
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
diff --git a/arch/arm/dts/zynqmp-sc-revC.dts b/arch/arm/dts/zynqmp-sc-revC.dts
new file mode 100644
index 000000000000..530a4a5f080f
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-revC.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP Generic System Controller
+ *
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include "zynqmp-sc-revB.dts"
+
+/ {
+	model = "ZynqMP Generic System Controller";
+	compatible = "xlnx,zynqmp-sc-revC", "xlnx,zynqmp-sc", "xlnx,zynqmp";
+};
+
+&gem1 { /* gem1 MIO38-49, MDIO MIO50/51 */
+	/delete-node/ mdio;
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@1 { /* ADI1300 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id0283.bc30";
+			reg = <1>;
+			adi,rx-internal-delay-ps = <2400>;
+			adi,tx-internal-delay-ps = <2400>;
+			adi,fifo-depth-bits = <8>;
+			reset-gpios = <&gpio 77 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10>;
+			reset-deassert-us = <5000>;
+		};
+	};
+};
-- 
2.36.1

