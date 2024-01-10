Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9EDC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B0F87B00;
	Wed, 10 Jan 2024 14:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyPoKEfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9C987B04; Wed, 10 Jan 2024 14:36:32 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F9E87AB2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 14:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ytt4s7f0v3ndMmOMQpMosTbQ9JCHjPKB2LjZDvL2zINA1nttWXmPXrCoyb7tWhWCSi0WbZbLz/7mxb8eXxnEX4OocJokuGm7gYrQr3PxXeaAkszmRn/1o8eCfkT/SE281EqtA7YCBBLUMkyYOB0o2lCdQgIdfJ2GQlGxzDaf3Cj8nbOp7yNg34ZKS0HNfkKWXuYNd3+tgd0ydcSHJUAT8q+IOpVyEazCV8dxbgDZyAAnirk/0ztZdLJyyMREHGulCfg+puiCMxwNw4fAVscrYNZhGh09RxnCK50L/GkNA6J3zLtA6ybcqjCIvd+PP7yBO6XqJDL/Q9ABwn+Uwaiwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkhrh6r/j6ZMiOaauwbj5+iZqOXAZvWxVeXWasxf/6s=;
 b=fxZyw3v+XOTs1AnjZola7R5xfOfmSMMoTPY25YPGUqgtmLvpyzHboLfD8WSzESh05R+sfH85hO5tBQk6n+Wx8GA7dbxHS2gYIp4xXGcM3zivnTRn7CL/4Qz3EacwCPAu+O82XdKYi+jeHkXAkANBeHVVWy/EPrbjbRpDnJmhzIlZLNOQZYZGskgU4KwhVixN0JvkqNiaZbqTlDIxJ+D2/J0GsWWT0l24L5jJt4GbG8RI5N3q4mA2mIz9dOyeaFwFJmWFG2fEbAJGE/nHhoA/+4J+6RzUNb1Ct/pj3cOFojIcB24LeOF/g+Qqx8wANJixKqOAiLE6Ot4Atx/dgZ2/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkhrh6r/j6ZMiOaauwbj5+iZqOXAZvWxVeXWasxf/6s=;
 b=qyPoKEfIdQxq+bKnisGLCE9WNKdxs+OaQW6H8LOxHfYazPJD8K8FoyEHS9aMwFkwzSn+VgvbH5u3Xwg33zRbp8gfTfUBPHphjLGvjZwPEy+RBqIt67N91qPw22MB4hnKpRkZchY+3ORzMYWaZdl/tzbOyb4qjR9/bMDs6LDbZWg=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 13:36:22 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::21) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 13:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 13:36:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 07:36:02 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Piyush Mehta <piyush.mehta@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Saeed Nowshadi
 <saeed.nowshadi@amd.com>, Sharath Kumar Dasari
 <sharath.kumar.dasari@xilinx.com>, Shubhrajyoti Datta
 <shubhrajyoti.datta@amd.com>, Simon Glass <sjg@chromium.org>, Tanmay Shah
 <tanmay.shah@amd.com>
Subject: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
Date: Wed, 10 Jan 2024 14:35:59 +0100
Message-ID: <f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24733; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Vev4mF8q/+TDpK3v4YVSwoRxXoZYg3zZ1N+GZdGEHhE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtR5c7WcHFYt/tuR3ej/uLdz6vtkTp9zdeeEKxZVLjY52
 vb96dJnHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiLrYM8+vmf7K4Ks7Qu4Gh
 Oyzl2vJ/Bo0yTxjmR7XfPp4/+Ymce63x000n319ddpt/PwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ddf65a-3332-4d1d-8140-08dc11e12280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5XohktWVZKXiGJ8OyEp2Rr+3nhcK0jx90HsDSutii09qQVjeQe+pBUBlPGRWg7D3e/LDcCdFg30wykEL5ht2rKmo1epzgp+FIP7bVdYajM+/SvwhchdNguFZ71JZhRNhf/lL/ahPLEpQP9IL2J3tDJSMIGbfwmd/n/4CGfmCOuI20UVPKA964VGy8ke/EO495emJEUy/u0T93dHiPoPQfYQrpekf/wwwWGiGeCEtdQN9g5OJpLF22Yq5pTaeqtzGYHamue0sloYBBtdFXxET/GrqsnsNlEOaraHE/gjsMViathfh4MH8+t9JhHKLzzUyL7TauhRNFncD4Jwmru3KX77Xm+/exUewXmHvDn6heWqgvTUOnXC5aZ04MwNTMlCS136fZdfhWojMRY0pmR1Fwpt1WSp+NlgTCb5nsWVVnv6Yk2IxVDx+ra9IjRaArKCui9Xhu+Kph7JTN3z1TpIEq0uGhwpF+LAf2+vwo49D8QSsYDCSyeft7qcBIiy7UC+UpqZeBQGzVLpC7lTNNiazxnH99ixcorrTyc8YwEnzG1ZjDnZdLX1xrS7jbei3B1ZhWa+vN0tll1JwbWknEdYPUEJ1opvJlQm2CbZQL8ZLuATGvW5vg7D+UHqfML/AA/OGx+HGTwyaACRftVhuTcQ7nRMPDxHeEkia627MRYTjoc03N7HJQ4YyFgn/HxqJ561pO6If4YK4xMeX77B6BSBqWzP+MIHFCEhePg0VvvluZOdwNPA6LRkEioqMqDbMp0eomKjO/OvfV7IiEC9Y1p86A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(8936002)(8676002)(26005)(83380400001)(426003)(16526019)(336012)(41300700001)(54906003)(86362001)(36756003)(4326008)(2906002)(110136005)(316002)(30864003)(5660300002)(44832011)(70206006)(70586007)(6666004)(478600001)(36860700001)(81166007)(356005)(47076005)(40480700001)(40460700003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:36:22.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ddf65a-3332-4d1d-8140-08dc11e12280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
related to qspi, spi, nand, i2c and ethernet nodes.

All errors are generated when dtbs are compiled with W=1.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-a2197-revA.dts                   |  4 ++++
 arch/arm/dts/zynqmp-dlc21-revA.dts                   |  4 ++++
 arch/arm/dts/zynqmp-e-a2197-00-revA.dts              |  4 ++++
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts              |  2 ++
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts              |  8 +++++++-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts              |  8 +++++++-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts              |  8 +++++++-
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts              |  4 ++++
 arch/arm/dts/zynqmp-sc-revB.dts                      |  4 ++++
 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso       |  3 ---
 arch/arm/dts/zynqmp-sm-k26-revA.dts                  |  6 ++++++
 .../arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts |  2 ++
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts           |  6 ++++++
 arch/arm/dts/zynqmp-vpk120-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zc1232-revA.dts                  |  2 ++
 arch/arm/dts/zynqmp-zc1254-revA.dts                  |  2 ++
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts             |  4 ++++
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts             |  8 ++++++++
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts             |  4 ++++
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts             |  2 ++
 arch/arm/dts/zynqmp-zcu100-revC.dts                  |  2 ++
 arch/arm/dts/zynqmp-zcu102-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu104-revA.dts                  |  4 ++++
 arch/arm/dts/zynqmp-zcu104-revC.dts                  |  4 ++++
 arch/arm/dts/zynqmp-zcu106-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu111-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu1275-revA.dts                 |  2 ++
 arch/arm/dts/zynqmp-zcu1275-revB.dts                 |  2 ++
 arch/arm/dts/zynqmp-zcu1285-revA.dts                 |  2 ++
 arch/arm/dts/zynqmp-zcu208-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu216-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu670-revA.dts                  |  6 ++++++
 arch/arm/dts/zynqmp-zcu670-revB.dts                  |  6 ++++++
 arch/arm/dts/zynqmp.dtsi                             | 12 ------------
 34 files changed, 143 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/zynqmp-a2197-revA.dts b/arch/arm/dts/zynqmp-a2197-revA.dts
index 84167050d10e..d88fd1266005 100644
--- a/arch/arm/dts/zynqmp-a2197-revA.dts
+++ b/arch/arm/dts/zynqmp-a2197-revA.dts
@@ -39,6 +39,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bootph-all;
 	clock-frequency = <400000>;
@@ -64,6 +66,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bootph-all;
 	clock-frequency = <400000>;
diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 2076271ac993..d7549078d889 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -139,6 +139,8 @@
 };
 
 &i2c0 { /* MIO34/35 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
@@ -196,6 +198,8 @@
 };
 
 &spi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	is-decoded-cs = <0>;
 	num-cs = <1>;
diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index f1b0a4aa65dd..f1bb07555923 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -206,6 +206,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
@@ -476,6 +478,8 @@
 };
 
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index 36a0db44fd28..54f70337fb5d 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -133,6 +133,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	scl-gpios = <&gpio 34 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 83b8a98d80ca..5f74afafa090 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -70,6 +70,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
@@ -163,6 +165,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	i2c-mux@74 { /* u46 */
@@ -300,7 +304,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
@@ -316,6 +320,8 @@
 /* TODO samtec J212G/H via J242 */
 /* TODO teensy via U30 PCA9543A bus 1 */
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index dd37b726d3dc..54a501c0dee5 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -66,6 +66,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
@@ -158,6 +160,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	i2c-mux@74 { /* u46 */
@@ -288,7 +292,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
@@ -318,6 +322,8 @@
 /* TODO samtec J212G/H via J242 */
 /* TODO teensy via U30 PCA9543A bus 1 */
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 811cebafe9e6..b4a7e9c94310 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -66,6 +66,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
@@ -158,6 +160,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	i2c-mux@74 { /* u46 */
@@ -292,7 +296,7 @@
 		i2c@3 { /* MEM PMBUS - FIXME bug in schematics */
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* reg = <3>; */
+			reg = <3>;
 		};
 		i2c@4 { /* LP_I2C_SM */
 			#address-cells = <1>;
@@ -312,6 +316,8 @@
 /* TODO samtec J212G/H via J242 */
 /* TODO teensy via U30 PCA9543A bus 1 */
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 5a60b86a574e..a45eb45ed3d1 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -142,6 +142,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	i2c-mux@74 { /* u33 */
@@ -378,6 +380,8 @@
 };
 
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 8517bdad6f47..b7262cd4f6e2 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -163,6 +163,8 @@
 };
 
 &i2c1 { /* i2c1 MIO 24-25 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bootph-all;
 	clock-frequency = <100000>;
@@ -189,6 +191,8 @@
 };
 
 &qspi { /* MIO 0-5 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	/* QSPI should also have PINCTRL setup */
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index 5333767361f5..4d3b08455b3b 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -13,9 +13,6 @@
 /plugin/;
 
 &{/} {
-	#address-cells = <2>;
-	#size-cells = <2>;
-
 	compatible = "xlnx,zynqmp-sc-vn-p-b2197-revA",
 		     "xlnx,zynqmp-sc-vn-p-b2197", "xlnx,zynqmp";
 
diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 5859e6cd8c23..d9739ace2a65 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -142,6 +142,8 @@
 };
 
 &qspi { /* MIO 0-5 - U143 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "jedec,spi-nor"; /* 64MB */
@@ -253,6 +255,8 @@
 };
 
 &spi1 { /* MIO6, 9-11 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	label = "TPM";
 	num-cs = <1>;
@@ -264,6 +268,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bootph-all;
 	clock-frequency = <400000>;
diff --git a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
index 0d96c6f9f041..7765bbe6174b 100644
--- a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
+++ b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
@@ -55,6 +55,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "st,m25p80", "n25q256a", "jedec,spi-nor";
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 2a3bbe170472..c18499284f01 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -85,6 +85,8 @@
 };
 
 &qspi { /* MIO 0-5 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* u285 - mt25qu512abb8e12 512Mib */
@@ -170,6 +172,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -270,6 +274,8 @@
 };
 
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index e0e4f1b13ada..f6be7e6f3462 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -85,6 +85,8 @@
 };
 
 &qspi { /* MIO 0-5 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
@@ -171,6 +173,8 @@
 };
 
 &i2c0 { /* MIO 34-35 - can't stay here */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -380,6 +384,8 @@
 };
 
 &i2c1 { /* i2c1 MIO 36-37 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
diff --git a/arch/arm/dts/zynqmp-zc1232-revA.dts b/arch/arm/dts/zynqmp-zc1232-revA.dts
index a288029797b6..cefb90b2d315 100644
--- a/arch/arm/dts/zynqmp-zc1232-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1232-revA.dts
@@ -38,6 +38,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB FIXME */
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index cb9ef3746803..d67052e62ab5 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -39,6 +39,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index 27b38e981a05..c8224c9376f6 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -118,6 +118,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -353,6 +355,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index ff7069bc1249..04a0a7c7c320 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -109,6 +109,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -132,6 +134,8 @@
 };
 
 &nand0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand0_default>;
@@ -498,6 +502,8 @@
 };
 
 &spi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <1>;
 	pinctrl-names = "default";
@@ -518,6 +524,8 @@
 };
 
 &spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <1>;
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index b97f7ee8d44f..a15965de4865 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -103,6 +103,8 @@
 
 /* just eeprom here */
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
@@ -128,6 +130,8 @@
 
 /* MT29F64G08AECDBJ4-6 */
 &nand0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	arasan,has-mdma;
 	num-cs = <2>;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
index 2b66abc9f7e6..252b159d7acd 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
@@ -171,6 +171,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index c5945067cd57..528b5beb4dee 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -176,6 +176,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 3132fa533b8e..09e1cdf6d509 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -228,6 +228,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -492,6 +494,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -970,6 +974,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 31effbf27a8e..132ef164ca15 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -135,6 +135,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -438,6 +440,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 999b2431bdf2..771016f32d1c 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -140,6 +140,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -450,6 +452,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index ba3989cad3e4..5775745b0b5e 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -240,6 +240,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -503,6 +505,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -977,6 +981,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 787cf0d87f9f..192db8ea6f53 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -200,6 +200,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -380,6 +382,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -788,6 +792,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index 095c972f1322..c5816311b90e 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -44,6 +44,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index 4060dc3613a2..5c03b5276a97 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -69,6 +69,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
index 38735b1ce1ac..84214b823870 100644
--- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
@@ -76,6 +76,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index b4e24745a9a6..1030ca7bfd6f 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -226,6 +226,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -392,6 +394,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -642,6 +646,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 6f593e80841f..bec17b56fed2 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -236,6 +236,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -402,6 +404,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -652,6 +656,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 7f70904f44e7..1a7a6efe8509 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -235,6 +235,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -401,6 +403,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -615,6 +619,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 0adb2062aef1..9dfa2af064b6 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -235,6 +235,8 @@
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -401,6 +403,8 @@
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -615,6 +619,8 @@
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <2>;
 	flash@0 {
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 63238c08780d..6178aa069170 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -640,8 +640,6 @@
 			clock-names = "controller", "bus";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			/* iommus = <&smmu 0x872>; */
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
@@ -722,8 +720,6 @@
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff020000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_0>;
 		};
 
@@ -734,8 +730,6 @@
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff030000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_1>;
 		};
 
@@ -794,8 +788,6 @@
 			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
 			      <0x0 0xc0000000 0x0 0x8000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			/* iommus = <&smmu 0x873>; */
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
@@ -895,8 +887,6 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff040000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_SPI_0>;
 		};
 
@@ -907,8 +897,6 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff050000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_SPI_1>;
 		};
 
-- 
2.36.1

