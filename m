Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B8C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 06:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFA48651C;
	Wed, 30 Aug 2023 08:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSrTQ6sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB598651A; Wed, 30 Aug 2023 08:57:49 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DAB86475
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 08:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXnjWWw4diGuAz/f6YGT3S/uvbll/qkLXfbkx2Bv5wcEHZ9E3QnsyaXjOIWOsEETSO/ZElshbUKTUFztXvUT69I9JtJyLMIpyBR6MbwN33zhXQrncQ/TX/LLWOk8S8vNth4cER2IMeGwC/yGet3SDU37qIVVMTJ0igBhkDsPbk6UDEoeli2BBlDBV33I2D/nBUXWMMNpG1Zz6Bw10a9WQAv1wzldnOLUDE07J28SoBNpzru3p7R34O5yO1NCE+Q6uSLC5MqBqC141XemFHt3Aha6fW8zRsnIXyVh3tGlHXL58EqiFSKDye98VaKvwaG8payWTyJg+K1o/i+99afqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpKgToRi+li55mFoqwWZj6XmtMU1mUkE999tH6ODFZ4=;
 b=n+8dwcjI3JnGi63ANBkeZxqgpBTDcR/ay6pPEBtkUzA7NDV+2XNKz5+qY/h1anX1xmaGZTKz1eYBTCElZgQf8Ln1yymyiF4/Rr2fgNeT+I8gBWgNgwJIC9hMCgGgXvnaRqA4DPpTUdm00vP7yUfFCIr9kBkIAFprN+truWLugffl6Hm61i8sRS/TzyKKpuLaAVnKHwzHcWaCZs82aqgEsvryRv+HA8E/0yaJ/mWGotMBbGsX0L74hyLyah/dRWC1gb+PElpXuwxeRX7YtdOnA2HEF1G6bBbJ8u5cx5Vle1Jg3k5HG8MImG5/3i3PXr52QcgkmoVdP3TRvX1CBPlZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpKgToRi+li55mFoqwWZj6XmtMU1mUkE999tH6ODFZ4=;
 b=lSrTQ6sxRvG9jXpznhvDH9UMq/K1bwwgqR43YL7SmO7lH52ezcRl6m7ay4BX6KZRbmCvlTkXeBv6LQoXrcxnNav8dLxPlifDDB834YJ8nm/ngR5Vt4TkfZ47CUDc+5irwjRJiZ4+uMl45Dd7I+Yeo1yArEZorvGnarYztKHt3/8=
Received: from CY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:930::8) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Wed, 30 Aug 2023 06:57:43 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::da) by CY5PR13CA0025.outlook.office365.com
 (2603:10b6:930::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 06:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 06:57:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 01:57:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 23:57:40 -0700
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 01:57:40 -0500
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arch/arm/dts/zynqmp-sck-kr-g-revB.dts: add
 output-enable pins
Date: Wed, 30 Aug 2023 07:57:37 +0100
Message-ID: <20230830065737.4083577-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae0a8c1-ddc8-4247-7831-08dba92667e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mEdJtpU9i8UwONbmPIDEDDc3wY4ZAq88VtnHLZLkWg60ekkOCSPkUEP0sS3LkrYmRe1gmYsE2wL6mweejZAWeJVQK4u2G4hxrm0EUForUiCiaH4WUaE9LeNUJsRtmDN1KBN0mGeLEATpQr8qws5PZNT3lO7qSZQ1VyAmxFVlSdb1r8o9+MU1/pmBn9Yb4EUaQXgXwu2ogTeoXv0Txm57TE1S0zw2N/tatFfCB4ANJhbibtlyMyzCBttiN7LWLKsKwdCeefud/hkAi3Z14i05AtyihGOxqIXpDQ/XtrEsoWgePr69BRogUSg6zLEQIRCj7jgcQFP+jk/bseLZsNdTuVpVR1WYomjQAFez5f2gD1cD4TzTtkugsno6OzCpA63CzVkxNxI0Tj4f31myO8ujgn7IUWLBwxEi0GJZZeiAp/JmlEC5UNu/HW7+0j70fLRMfKba9OJ0hh6+SqvdsNkpSIdC9X+bfa2apsHtatrNT1Q1mQiLWdyNA9x2lxeMol3zCeqm3WKwvChO40sddVffneun8cIBrBG4R9YTUzO9bHkp+q3vBUNd/96wZ9KN7A6mxSvpeUy4cYSW2TN6+FUachiSBM+zQ6OZslj07OhcLCLvOtvqX6WxL2/NBZgknewTfYNGzmbfEVRkesFcnvGLhj7i76Md7f18DBByxIL9RHVjlR/lcU346N644MCxSqCco1kTG3OzX4sXjmSlrfgTJsgGyWjWb91WqZtVKeubPubkSBCDdSqwmfYtUD08GYU7OOf3sOe++W5H0qEJyu/rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(83380400001)(356005)(478600001)(82740400003)(26005)(336012)(426003)(81166007)(36860700001)(47076005)(2616005)(40480700001)(70586007)(6666004)(5660300002)(2906002)(44832011)(1076003)(316002)(54906003)(6916009)(8936002)(8676002)(70206006)(41300700001)(36756003)(4326008)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:57:41.8644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae0a8c1-ddc8-4247-7831-08dba92667e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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

Now that the zynqmp pinctrl driver supports the tri-state registers, this patch
makes sure that the pins requiring output-enable are configured appropriately
for the KR260 Starter Kit.

Without this patch, the USB to SD card bridge on the KR260 starter kit is not
enabled correctly when booting via SPL.  This causes u-boot to fail to detect
the SD card interface.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 arch/arm/dts/zynqmp-sck-kr-g-revB.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
index 1ebbe683f3..104e67ddf8 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
@@ -248,6 +248,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -299,6 +300,7 @@
 		conf-bootstrap {
 			pins = "MIO45", "MIO47", "MIO49";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -306,6 +308,7 @@
 			pins = "MIO38", "MIO39", "MIO40",
 				"MIO41", "MIO42", "MIO43";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -314,6 +317,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -344,6 +348,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
@@ -371,6 +376,7 @@
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			"MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
-- 
2.25.1

