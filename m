Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5853EC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 09:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A705F87929;
	Mon,  8 Jan 2024 10:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGfe3Aov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2C987A21; Mon,  8 Jan 2024 10:25:32 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A807877DE
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 10:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC4Cu5f6SSt7X4nuA6IacpRFJ6xgYJrNYnQNM5uvWssQt2AyKCF8+zGU+c0Y9G1Yi12ClIv7OHuCmuPjfcn0f9sPn0c0sYaldURU6xf4MtNwtwvKZzXxmoQd4VFI8idDfZ/K+hF60wd/Bmkfc8gh3XSZFTQ1QTCehVAloSgX+uKiz2fIY3qYFrGDAbMc0n5c6mZ+gNCwQN+JldB0ewARgdLf5uDPBxFoXaG1lEeHpgNeI9/Pcdu75v8dPQ0dhlQl0At7zcJYtRq5jQnOQjs44rj+foKs2wXC9/vWRzkTmwNgZDbrMADrSXdSTeeAUcM06ZSEnvV063L9xBpWex4MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHd8GuAFbF9YnXby/U2a83bJWdEUhfT8Fiee/dwfZ0o=;
 b=Q/R+c5/ioFW881BW7ZO69ZaJ/H3YX02DlUC12qygcADDVf9fg6VrKs9QI+FtUI/bmZqVpvKn0RlzvPdUabfT6ASahfUNAJFG4YTmR6cQA9WVNaRTgjlb3SFEVTKCSnlaRqSp1L6WSi6eYdFSZg4mrP7q5yiAvC7R9G5fC/YMGa0pnDJl8OG8Dczt8hNk1k6KZ+2Mv7bf+MG8aEOIN/5yvuC92BJb2+zZgNDQhHNxIXNnLyuzNNF+ZbPPEc/S/lW9r3VqEGz5MK+jgepDR9UOVYOIc5QMgKS9ijknBNsSZXV2EftI2wp67uXZY/g3bWPdT80biAFGKP+od96f6WzBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHd8GuAFbF9YnXby/U2a83bJWdEUhfT8Fiee/dwfZ0o=;
 b=ZGfe3Aov/yDdZCmodFn+D0/BRsbGBdqOGbMsQrGlHp6ooa7vQiSYkUFiHybfM9DFKQnrY8MoMYXztvifvp1HvZNFWDyK0gRADjFWO5uFUfGyADu1sfAwGKLEI6X6EygZRxpoR53buY0DTmYLTqzwEpRCDJJ0swbLux+ImKdc4Ac=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 09:25:26 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::24) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 09:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 09:25:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 03:25:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Saeed Nowshadi <saeed.nowshadi@amd.com>, "Simon
 Glass" <sjg@chromium.org>
Subject: [PATCH] arm64: zynqmp: Replace '-' by '_' in fixed clock nodes
Date: Mon, 8 Jan 2024 10:24:45 +0100
Message-ID: <3979167636f0a5970a9ab642a4e0ea6a46b3f8d7.1704705872.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8240; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5No8hG7lpgn0krOv3YjEkjbgFArO1XmL05tc2cf750s=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTZ+8Nrb2lbPrXdcP5N+NZ2n/1X9F+cLL9zMemu1Jr2d
 yrqoieUO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE7mUxLJjy6sXxyxXXojdM
 4j7IK7JJalvPngKGBW3ZL6Y3Gdx4OuvOnudVQaHCs8K0/AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c5b988-8764-4368-a845-08dc102bbf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm0lohjTOdydKjk01KHTVDsFB6gDM+rpLifUuRKFvgxJqmLcuHIj9zkE1g/A45dhevgqG5eRqmmlAF25HVoUaNQJTyQHfmQfGXEDBnWruA3BgO9vjU1w+0ZyOOAR2Gq8Nf4GVRsnhsZ00GE0TMk4HVpScqvtG1v3Pl171q5r553b3K5DC2ZccEN7/KHOsgY0jwatttP6+Q817yHZ74jaCQnFfnKd+M9W/oQ/OwHWMDJEK0n+wLj+j/1sYMK26vxbVF24B5VJGh/RZ+h+sX2fNwyJl/qro5nslKqC1LMkXRQe+oNN4GgrKVSCQRfSVN11YOvRl89cL78jACI54qE0mvh1z81QzqIJ0IoPtbkqAMvm7O2nnTLHFWrtpvEt8oR7KkAPBSvLfPCkB0kx+0PkNsPDvamHWFK1eKqf07YoX8Hi0gHzIv8vGhO9JtuF1OeSOd8NC+0/FhngmCu+uUZBUuMqtKl46JBegdkuT5ezLESkLBSxDa27KWGuAe3Z4MAG3uPbkoacDhUftWVclZtav6YnSWzAII7nH5lr61F5e3SzIKA0DEoSbgqr/EKLowReuDDYihdnzczBdKeCFCICdOgdIWyKDwobIQqqLBUEE9G4tnfrMimoNgUyPcUn5kCOyYM5b+l91TSHT3P0wP7QDR7r3pfPOcCHxNaiBMQGGaTD/Kn0lD7kb/74PL5NuRcvMy8RlpyW/Syfo+kyDYB20HCvm+0ZV0Acrf/WIkEv+uK0sOr5Wv9XKfomoiF7Ha1LT14talGWQi+BNDe9AARLSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(6666004)(47076005)(478600001)(26005)(2616005)(83380400001)(336012)(16526019)(426003)(70206006)(70586007)(41300700001)(82740400003)(40480700001)(44832011)(36756003)(81166007)(2906002)(5660300002)(8936002)(8676002)(316002)(54906003)(110136005)(356005)(40460700003)(4326008)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 09:25:25.6458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c5b988-8764-4368-a845-08dc102bbf33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563
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

Using '_' in node name is not recommended that's why convert them to use
'-' instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts         |  4 ++--
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts    |  2 +-
 arch/arm/dts/zynqmp-mini-emmc0.dts         |  2 +-
 arch/arm/dts/zynqmp-mini-emmc1.dts         |  2 +-
 arch/arm/dts/zynqmp-mini-qspi.dts          |  2 +-
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts    |  4 ++--
 arch/arm/dts/zynqmp-sc-revB.dts            |  2 +-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     | 12 ++++++------
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts |  6 +++---
 arch/arm/dts/zynqmp-vpk120-revA.dts        |  6 +++---
 arch/arm/dts/zynqmp-zcu670-revA.dts        |  2 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts        |  2 +-
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index f737004d7943..9dabee3f9985 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -43,13 +43,13 @@
 		reg = <0 0 0 0x80000000>, <0x8 0 0x3 0x80000000>;
 	};
 
-	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
+	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_2: si5332_2 { /* clk1_usb - u142 */
+	si5332_2: si5332-2 { /* clk1_usb - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index cc57c2a1b0be..f1b0a4aa65dd 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -43,7 +43,7 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	si5332_1: si5332_1 { /* u142 - GEM0 */
+	si5332_1: si5332-1 { /* u142 - GEM0 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
index 02e80bd85e1a..7823c58cb272 100644
--- a/arch/arm/dts/zynqmp-mini-emmc0.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
@@ -35,7 +35,7 @@
 		bootph-all;
 	};
 
-	clk_xin: clk_xin {
+	clk_xin: clk-xin {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <200000000>;
diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
index ce1cdb207538..2f6ba95073ab 100644
--- a/arch/arm/dts/zynqmp-mini-emmc1.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
@@ -35,7 +35,7 @@
 		bootph-all;
 	};
 
-	clk_xin: clk_xin {
+	clk_xin: clk-xin {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <200000000>;
diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
index ee8be5360004..e35317f3e2d4 100644
--- a/arch/arm/dts/zynqmp-mini-qspi.dts
+++ b/arch/arm/dts/zynqmp-mini-qspi.dts
@@ -53,7 +53,7 @@
 			#size-cells = <0>;
 		};
 
-		misc_clk: misc_clk {
+		misc_clk: misc-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <125000000>;
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 9acccad40e77..5a60b86a574e 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -43,13 +43,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
+	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_2: si5332_2 { /* clk1_usb - u142 */
+	si5332_2: si5332-2 { /* clk1_usb - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index f7349fdc3b4c..8517bdad6f47 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -71,7 +71,7 @@
 		};
 	};
 
-	si5332_2: si5332_2 { /* u42 */
+	si5332_2: si5332-2 { /* u42 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 57cd9ba13e78..7717abf7bd8a 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -25,37 +25,37 @@
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
 	};
 
-	si5332_0: si5332_0 { /* u17 - GEM0/1 */
+	si5332_0: si5332-0 { /* u17 - GEM0/1 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332_1 { /* u17 - DP */
+	si5332_1: si5332-1 { /* u17 - DP */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
 
-	si5332_2: si5332_2 { /* u17 - USB */
+	si5332_2: si5332-2 { /* u17 - USB */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_3: si5332_3 { /* u17 - SFP+ */
+	si5332_3: si5332-3 { /* u17 - SFP+ */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <156250000>;
 	};
 
-	si5332_4: si5332_4 { /* u17 - GEM2 */
+	si5332_4: si5332-4 { /* u17 - GEM2 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_5: si5332_5 { /* u17 - GEM3 */
+	si5332_5: si5332-5 { /* u17 - GEM3 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 088545c87cee..2a3bbe170472 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -65,19 +65,19 @@
 		};
 	};
 
-	si5332_0: si5332_0 { /* ps_ref_clk - u142 */
+	si5332_0: si5332-0 { /* ps_ref_clk - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
 	};
 
-	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
+	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>; /* FIXME */
 	};
 
-	si5332_2: si5332_2 { /* clk1_usb - u142 */
+	si5332_2: si5332-2 { /* clk1_usb - u142 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index fa6046eb95c4..e0e4f1b13ada 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -65,19 +65,19 @@
 		};
 	};
 
-	si5332_0: si5332_0 { /* ps_ref_clk */
+	si5332_0: si5332-0 { /* ps_ref_clk */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>;
 	};
 
-	si5332_1: si5332_1 { /* clk0_sgmii */
+	si5332_1: si5332-1 { /* clk0_sgmii */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <33333333>; /* FIXME */
 	};
 
-	si5332_2: si5332_2 { /* clk1_usb */
+	si5332_2: si5332-2 { /* clk1_usb */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 76410de1edca..7f70904f44e7 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -131,7 +131,7 @@
 		clock-frequency = <48000000>;
 	};
 
-	si5381_6: si5381_6 { /* refclk_usb3 - u43 */
+	si5381_6: si5381-6 { /* refclk_usb3 - u43 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index c2dd9f696bf0..0adb2062aef1 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -131,7 +131,7 @@
 		clock-frequency = <48000000>;
 	};
 
-	si5381_6: si5381_6 { /* refclk_usb3 - u43 */
+	si5381_6: si5381-6 { /* refclk_usb3 - u43 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
-- 
2.36.1

