Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891EFC47079
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E8987A65;
	Mon,  8 Jan 2024 15:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BwRuye2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CB287A8C; Mon,  8 Jan 2024 15:48:21 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F41D8794A
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7ruKPXVoq0SfGxO2IelsAh7oXO3uuVQOu3S5hC2iFIpA6F0ILxiX+sI0HrVXsF6FeU4jNIsy9OI0GJ2uXboLG0sL3dksPz21zmjdQFBmDWFESAfShxqbuGOWMQmDDJVqJnommpFogKzGt35cGBs5Xox3edBP/ZPHVm64VfUIy2hEuNHs7PJ3joOLFc+QeatqhXnCHA8vsMtyt8en9r4XxPGXwFE9BCPk0xGM1+EfIHprha4E6PEFSjVhIdIOOuGAVkATe08NbYEGvQSfn+UbDvae+EWSP3S5wFPvCM/Jubnj8VllmVDOiTnZOr0GU9l2lS1rfov9nBWJSdSUWtJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCFocyojGIiIulffsAzbjWczyFQmeeM8etxvaEDa0mI=;
 b=NheAM8anPqB7cUQ8/nMY22EXhsLSksw13BCGRqJ/fNb9yb/jjZr7nXGq/7wPiHXCcXrYDj3gQWizPJ1i3cQrg9HnRo+9FeUu6PbxnA0gYmMPNrVc0qt6ATIs4T1WdIkBUJVEXaslV1vmCOlftdXU3CWa5Q+4qZiMmL8k4V9vYssIaU5kGRUXpYsygX48k4DK1Loz9I/CvszdrZaeeqh1s72up6cm9NckxlpuMzLHuon2+gZ5QVLyR490P+5DrRjzE+lbzFD1gHHvEBodKrE6mQQrYoWkIlaQtpDvbGI7sYhYLcWHHvr3Mun6UQI606UzbtO5KeM9pq3FgTfWZPKNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCFocyojGIiIulffsAzbjWczyFQmeeM8etxvaEDa0mI=;
 b=BwRuye2Xy5H4AlGG+dJfniS67Vuje02DTv7DCWG4GNpc5RDRIJcwtRGtfiDr2/Y2VjP4eTFpPE77dRfjPxh7ge2yOHoG/2fQcZAxa5rZcpva6vvw9mN1fvL2Q9IJ3cyi4zKnAi21pAsT3lEWZRjmWWVK26zZ8HBD+a0bFH7mr+A=
Received: from PH7PR17CA0070.namprd17.prod.outlook.com (2603:10b6:510:325::10)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.22; Mon, 8 Jan
 2024 14:48:01 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::42) by PH7PR17CA0070.outlook.office365.com
 (2603:10b6:510:325::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 14:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 14:48:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 08:47:59 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Match dwc3 interrupts description with values
Date: Mon, 8 Jan 2024 15:47:56 +0100
Message-ID: <caecc1fcf26951a4c0297a4764dfb797795c7bc6.1704725272.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ULZIzvIkJJAcCVlQMmXRoP7t1jttE6mKD0FZ5dd22k8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ53JLSV5OP1H7QkwxcWf8vKbTGf4+guVLSiZfmuSktj
 /T+n8jviGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOZ3cYwv0bi+w+tJ7x/Nkjt
 ubpIPGTpxrMMtQzzEyXPVK6LNir8l9u2+/B+OYlvHhctAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: c6899e13-e3fd-408e-007c-08dc1058cfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Lh8NN8D0giHm5YHMBzgJ4qREZqSgSnaRjEPes0IPb4AOTcydCUgZvwdu5Lvvn1LOQRKWk+5t59cPz8UV8ZB4ok6xfHlXGTPiUi8jZxB6Ul1Z1o5Q7NGS230QvT+a2vl20EaM6HCJemKDV2TttGgZBaPiP6JZQQuqtSMz6Tg/3nI1yY6tdYRRS8Kqm2avCK607ldWb5go9d7g0IJGFKYir0ltSiEtsMZCbFZY0OIGp3yDaVjMq8XJFmjB2oIBmy/OXQn4T1hcRGgTP1A/xLdY9e4v15plIMrSk+PMZbuT5O+oqRW9XJpZ0N4jU3wD1BrlJJmiEVH7ngcRowPlhPP93PBVoeDGwU0GHfZpgaigBpBy1xKW+/51YL1WYjaIz6t17U0PDMYz7nQBhvHwKDMO688nKY9z+oti7nrdLvHVZbmd81TbCN0HRrTBQAtU7l2sppz5IfSz9ber0CCBdj6BoHKHnq5v4g7mc3CQLU/UJ83nylK2fDRBL0jQz+yYUwTMJZvlWSDdg4C8D2ifQNwtC0FgPj4D7/rNt4lzwFK366SD5k/EUa2iE/RfY/XSCT7qp+besrdPtDmQAFxibdX4KhrBMhMOXvhDT8BrRIQUzkIDga2R/J2LF1KWSusLf2iTocP0cpHYLQlxmZOol3wW7vluzg7Vk7PY9l6uycAsYtccoiTaEBhb9REYE6K6hUZX1fP4iSKv1Nw6ZR0sxQ1n2PwMOgF49GbRKVm1hmsRPaJFBGBsiBMquCPqBQvrNyptuAzTEjOPQ1bwpN/jb/Y/9fsmmYFTtfsO4drdWXFtEaW5+fQiqPM0zcmNqkLfaQc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(426003)(26005)(336012)(2616005)(6666004)(478600001)(36860700001)(82740400003)(86362001)(36756003)(81166007)(356005)(5660300002)(2906002)(41300700001)(16526019)(47076005)(83380400001)(70586007)(54906003)(70206006)(316002)(4326008)(8676002)(8936002)(44832011)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:48:00.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6899e13-e3fd-408e-007c-08dc1058cfa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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

Correct IRQ values don't match IRQ line description.
There is one more IRQ (hiber) but it is not described in DT binding spec
that's why value is not described. Just for completeness dwc3_0 has hiber
IRQ at 75 and dwc3_1 at 76.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 21be909b1abe..7c7cbfb287fb 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -996,7 +996,7 @@
 				status = "disabled";
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
@@ -1028,7 +1028,7 @@
 				status = "disabled";
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupt-names = "host", "peripheral", "otg";
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.36.1

