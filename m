Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E3CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAAF864CB;
	Fri, 22 Sep 2023 12:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ly4uoeD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90408655F; Fri, 22 Sep 2023 12:35:56 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7D9864DD
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4pWZ4hNbR29kwCidq0OQS2bsCcZNhPP6tSuYeTHwEH0ys4IZio39eObGTLCgqv0mFisrMZN6uHaZzdo8gp7jNn7UaT255LA5aFNYgWC+vZmiUNEUmmOpMDgCKX1O696YXdACu6N7vjHXCipTw9aOELNU3PVTBV9HLWRa5LaaF9rvlPSR9/a+CQ9I7ZJwMx+PVBXVXJkv6hH2BqmjcUvPXZipaydJ7SlIb9yvlwtPiKV0HyFYYGs+buqaGqQOZLVbxUJG2V9evoLUB9wW/1gqtYnQ240XDMbEdwLnaRQOpIleN8wI5keefHT0hHwVf8/tmfpwfg5qqarQGYnu4W1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8SYidn1TJVDRCshYwln/Lb72rJSuBPnd/cvN0pQqXI=;
 b=SE+R8sxSCcD+KEupqgEuIQVQQ9Cnf9T1IFCB3JSB5pLmkehkH1NoSPhePaABiqHEUUo9x2ISuKZsTMUAoPs9yIt4iEh8wr1QUjYNE46kb1Vl59nWm6aQc4Qnu+vKiO+kFrk5QJ2ZG8xsnQSn1l+ueBq63tykhBUx/HY7UlZOxemGRc1EhwF2FbyV+Hho8sofetJLOf8TyePq7NeGwj9LmJWKDbKaFs9u/uKqOmCt0B6ThBtYsD/wNo+TxiOYaDy+DPx1J02cWra4Nx28TN49Zbhs4mByFMFVcLSpAvVVep1f0oeSiPVgpvEfW7fpAA7y2vm/ysED8ap3LHIH/2+a4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8SYidn1TJVDRCshYwln/Lb72rJSuBPnd/cvN0pQqXI=;
 b=Ly4uoeD8v5oIAFrlsl5uOs6Xz5CXI4HYDyNsecsDEqKe5WzkQTOVvlh7of/4WWigtNx07laIXST7IMHQs8HSYA3XFGmsjYWR+6SYbBDZdXq9QkYbCK9B12kTVfBH//iLpPaqFx15xLbSxEMgvy8g0YZul8SPuVtpj2ArNu4wyQI=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 10:35:49 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::70) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 10:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:35:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 01/14] arm64: zynqmp: Describe interrupts by using macros
Date: Fri, 22 Sep 2023 12:35:30 +0200
Message-ID: <e0db567e1eb4e4e90e59270f41708919682dacf4.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21127; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Vyo+Xr5yW1YG2pARaUWL0XY7ApGrlpVtUzsgfu+5I+I=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3MlLT04949C6ZwlX+Y2wR1ymUjPezJtZ2zIx6cYO9
 tQlFcrRHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiM44xzM+u22W6OJWnOeLV
 nEhemdv3F60/lcqwoNOXxzlhZ1L7zt1OO2YGPzNkiXv+HQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: be79a764-8024-4ec1-1473-08dbbb57b02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLbuxOwrHrrkb9q+RinBoHBmXQ2V/n2fjzfn7dm0aIo84xNQA+QSlRUWeOSoGBbmCn8nNchvH0Omy6TWfub86G6r57iqySzvf7WC8gG7ovBi+u6AibSnq7FnVfukiztT62/xjvqxUMoSmEkF44MhqTQ9tS6ET1Mq2jEE6h7ZS3v+6oee5QO1cdbvyZNWYoYlIaw9/PAcECRk3T2RQxDS2gVz7zc1/+4pKsIM6zbloXvKZUuVfAW2tzAdcglOLb3gRYbazwglDAODKiAkdyJ4U3MsLJ06e38W2uOOOU3B10dbyiJ/sw1KtigMLAsX0MBdXUFahwu3CDwxbG4LCAwBxnU8MW497XDYG8sssJws/Tl+JAou12FckzLtEL9cCG1AWNKXCVOmGOZY0KB+D9Psh1yj7+mlan98IHHX+7u6Ow3nVkw4ajzsGOz6G1kx/uuS70lGsm8HTjrr5KfNe4Ib3mWEDjT/w0yD+OPQf4u0PwP8qYc8oZldEA+iWPQzVn+Z2ftNno3Bjq7mFS9zOc2Wdx3FFnb2rYmn/T+GVObe1oH7CFD7+S5gVRcU9vtaF75z6wPE5dTg+9j1Y9PFRpWp1vgo/pGV/wZj9kc2iOPiGzb7/crKCJ+K+BgaBZfcD06U2G5w6rNgltHCuV2qQagcfEzA6Ui7lDsQTv+eAgmUvajjNR1YvqBDlfFugKxHsXwFdy9SIzBgovdtD0Mi7zK66AJBQteZhqQ5azgVPFspYo4RaifK8ABP66l5FGWXXOksmCromHoLcXsdpZa/s6XGKICaKOq69AdU6TruVswsCDen1qg12vTHZp6gTMI6C9Sp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(1800799009)(230921699003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(44832011)(5660300002)(26005)(16526019)(40480700001)(41300700001)(316002)(54906003)(70586007)(70206006)(110136005)(30864003)(478600001)(8676002)(8936002)(4326008)(36756003)(40460700003)(47076005)(36860700001)(2616005)(426003)(336012)(83380400001)(6666004)(81166007)(356005)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:35:49.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be79a764-8024-4ec1-1473-08dbbb57b02e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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

Use arm-gic.h and irq.h for interrupt description. It helps to improve
readability of device tree file.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 184 +++++++++++++++++++++++----------------
 1 file changed, 110 insertions(+), 74 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 8d3501018455..951f3f795e97 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -14,6 +14,8 @@
 
 #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
@@ -122,7 +124,7 @@
 		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
-		interrupts = <0 35 4>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		xlnx,ipi-id = <0>;
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -152,10 +154,10 @@
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
-		interrupts = <0 143 4>,
-			     <0 144 4>,
-			     <0 145 4>,
-			     <0 146 4>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>,
 				     <&cpu1>,
 				     <&cpu2>,
@@ -183,7 +185,7 @@
 				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
-				interrupts = <0 35 4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 				mboxes = <&ipi_mailbox_pmu1 0>, <&ipi_mailbox_pmu1 1>;
 				mbox-names = "tx", "rx";
 			};
@@ -227,10 +229,10 @@
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	edac {
@@ -258,7 +260,7 @@
 			status = "disabled";
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff060000 0x0 0x1000>;
-			interrupts = <0 23 4>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
@@ -271,7 +273,7 @@
 			status = "disabled";
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff070000 0x0 0x1000>;
-			interrupts = <0 24 4>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
@@ -291,11 +293,11 @@
 				compatible = "arm,cci-400-pmu,r1";
 				reg = <0x9000 0x5000>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>,
-					     <0 123 4>;
+				interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -305,7 +307,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd500000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 124 4>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -318,7 +320,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd510000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 125 4>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -331,7 +333,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd520000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 126 4>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -344,7 +346,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd530000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 127 4>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -357,7 +359,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd540000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 128 4>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -370,7 +372,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd550000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 129 4>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -383,7 +385,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd560000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 130 4>;
+			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -396,7 +398,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xfd570000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 131 4>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
@@ -413,7 +415,7 @@
 			      <0x0 0xf9060000 0x0 0x20000>;
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		gpu: gpu@fd4b0000 {
@@ -421,7 +423,12 @@
 			compatible = "xlnx,zynqmp-mali", "arm,mali-400";
 			reg = <0x0 0xfd4b0000 0x0 0x10000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 132 4>, <0 132 4>, <0 132 4>, <0 132 4>, <0 132 4>, <0 132 4>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1", "ppmmu1";
 			clock-names = "bus", "core";
 			power-domains = <&zynqmp_firmware PD_GPU>;
@@ -436,7 +443,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa80000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 77 4>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -449,7 +456,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffa90000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -462,7 +469,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaa0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 79 4>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -475,7 +482,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffab0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 80 4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -488,7 +495,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffac0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 81 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -501,7 +508,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffad0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 82 4>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -514,7 +521,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffae0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 83 4>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -527,7 +534,7 @@
 			compatible = "xlnx,zynqmp-dma-1.0";
 			reg = <0x0 0xffaf0000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 84 4>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
@@ -539,7 +546,7 @@
 			compatible = "xlnx,zynqmp-ddrc-2.40a";
 			reg = <0x0 0xfd070000 0x0 0x30000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 112 4>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		nand0: nand-controller@ff100000 {
@@ -548,7 +555,7 @@
 			reg = <0x0 0xff100000 0x0 0x1000>;
 			clock-names = "controller", "bus";
 			interrupt-parent = <&gic>;
-			interrupts = <0 14 4>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			iommus = <&smmu 0x872>;
@@ -559,7 +566,8 @@
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 57 4>, <0 57 4>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -574,7 +582,8 @@
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 59 4>, <0 59 4>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -589,7 +598,8 @@
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 61 4>, <0 61 4>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -604,7 +614,8 @@
 			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 63 4>, <0 63 4>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
 			#address-cells = <1>;
@@ -621,7 +632,7 @@
 			#gpio-cells = <0x2>;
 			gpio-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 16 4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x0 0xff0a0000 0x0 0x1000>;
@@ -632,7 +643,7 @@
 			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 17 4>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff020000 0x0 0x1000>;
 			#address-cells = <1>;
@@ -644,7 +655,7 @@
 			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 18 4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff030000 0x0 0x1000>;
 			#address-cells = <1>;
@@ -668,11 +679,11 @@
 			msi-controller;
 			device_type = "pci";
 			interrupt-parent = <&gic>;
-			interrupts = <0 118 4>,
-				     <0 117 4>,
-				     <0 116 4>,
-				     <0 115 4>,	/* MSI_1 [63...32] */
-				     <0 114 4>;	/* MSI_0 [31...0] */
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,	/* MSI_1 [63...32] */
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;	/* MSI_0 [31...0] */
 			interrupt-names = "misc", "dummy", "intx",
 					  "msi1", "msi0";
 			msi-parent = <&pcie>;
@@ -702,7 +713,7 @@
 			compatible = "xlnx,zynqmp-qspi-1.0";
 			status = "disabled";
 			clock-names = "ref_clk", "pclk";
-			interrupts = <0 15 4>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
@@ -727,7 +738,8 @@
 			status = "disabled";
 			reg = <0x0 0xffa60000 0x0 0x100>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 26 4>, <0 27 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "alarm", "sec";
 			calibration = <0x7FFF>;
 		};
@@ -737,7 +749,7 @@
 			status = "disabled";
 			reg = <0x0 0xfd0c0000 0x0 0x2000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 133 4>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
@@ -750,7 +762,7 @@
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 48 4>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			iommus = <&smmu 0x870>;
@@ -765,7 +777,7 @@
 			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 49 4>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			iommus = <&smmu 0x871>;
@@ -782,18 +794,30 @@
 			status = "disabled";
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
-				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		spi0: spi@ff040000 {
 			compatible = "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 19 4>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff040000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
 			#address-cells = <1>;
@@ -805,7 +829,7 @@
 			compatible = "cdns,spi-r1p6";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 20 4>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff050000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
 			#address-cells = <1>;
@@ -817,7 +841,9 @@
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff110000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_0>;
@@ -827,7 +853,9 @@
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 39 4>, <0 40 4>, <0 41 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff120000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_1>;
@@ -837,7 +865,9 @@
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 42 4>, <0 43 4>, <0 44 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff130000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_2>;
@@ -847,7 +877,9 @@
 			compatible = "cdns,ttc";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 45 4>, <0 46 4>, <0 47 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff140000 0x0 0x1000>;
 			timer-width = <32>;
 			power-domains = <&zynqmp_firmware PD_TTC_3>;
@@ -858,7 +890,7 @@
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 21 4>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff000000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_0>;
@@ -869,7 +901,7 @@
 			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 22 4>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff010000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_1>;
@@ -896,7 +928,9 @@
 				reg = <0x0 0xfe200000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg", "hiber";
-				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&smmu 0x860>;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
@@ -927,7 +961,9 @@
 				reg = <0x0 0xfe300000 0x0 0x40000>;
 				interrupt-parent = <&gic>;
 				interrupt-names = "dwc_usb3", "otg", "hiber";
-				interrupts = <0 70 4>, <0 74 4>, <0 76 4>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 				iommus = <&smmu 0x861>;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
@@ -942,7 +978,7 @@
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 113 1>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <60>;
 			reset-on-timeout;
@@ -952,7 +988,7 @@
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 52 1>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
 			reg = <0x0 0xff150000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
@@ -961,7 +997,7 @@
 			compatible = "xlnx,zynqmp-ams";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 56 4>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xffa50000 0x0 0x800>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -987,7 +1023,7 @@
 			compatible = "xlnx,zynqmp-dpdma";
 			status = "disabled";
 			reg = <0x0 0xfd4c0000 0x0 0x1000>;
-			interrupts = <0 122 4>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			clock-names = "axi_clk";
 			power-domains = <&zynqmp_firmware PD_DP>;
@@ -1003,7 +1039,7 @@
 			      <0x0 0xfd4ab000 0x0 0x1000>,
 			      <0x0 0xfd4ac000 0x0 0x1000>;
 			reg-names = "dp", "blend", "av_buf", "aud";
-			interrupts = <0 119 4>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 			clock-names = "dp_apb_clk", "dp_aud_clk",
 				      "dp_vtc_pixel_clk_in";
-- 
2.36.1

