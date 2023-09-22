Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E506CD4F58
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C400686B53;
	Fri, 22 Sep 2023 12:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZCDANjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B77086B4B; Fri, 22 Sep 2023 12:36:50 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500E186AE9
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe7uhsnkkSZLT4vE+h3XvGvWyPTVhT+1RHEum3eMuO85P9XQUL7qW8ceqJ8jYEqDBeFzjiQUAhY3Zmjd8Z55MIDQMs+qyQV9vKgCwCc71rJV6DHcGyGsh0QxzgMHY38Q+yTeQDqXLbSFV49Esj9+w+Y2JOxEGJc4otZbpBbD0ZZiUAAAz/R8RZ8BmiD+w+aWLSGWHZiv9qYYWfrK29JiSQOZ4xsPq9IdaO1bKS4U75NCAxBhrj0GV+8OARsIGPQuHgDKYMZAOrYAwD9SxDLUpF80qIN0hWRhfq7uXjOO7Begjc49iMzT6J9a2/NUnxvFaPJnDPTeA74ztvkHoHKYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLceXfEqZaWeKmD2Gypew/A7MhjAcapFOL0Vja/Gopg=;
 b=QFT1XQJj5toGlhh0Bq4CoRwupab6cFWMb8w7X8wnJAMfTBHrKxCImh9CsaF58HJBYUZA1mlscbsFPI5qGDJDDqQRuGdybMuENHofOS06DBlJuqxJHQCOgwHwlarzI84GoDxG1vchBkJAFd92aOObUIpI130w2RdyNvsnTFazP3qeAXQV4l97GSKcUt8CUXnvrI4LEwZJl4j5jlUpB1n29rxO9jMpriR+/infL8X2XJR+TAJEthhyUsiPCGPuVV6AERj3Gsi+c4WHKCLeHh/KK+Jf3x6QvclVfZzD3PNXIR+Ut/6A1MPKQEy2GZX3IZLSFPHjhOxiXnosKbNIKge8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLceXfEqZaWeKmD2Gypew/A7MhjAcapFOL0Vja/Gopg=;
 b=IZCDANjfUQHcDPTOWjejGDoMluFh3Ya+GqS9ngzIorwl3baN+gXKR4QWx8dhrP94s0qhOw8+j+LwGkmIIU6FQSloGgBdDk7KMpFUN5xlhnQtywDPDaZRQs0mEO5W61EYutxGzSKMEcor5J69ZXZyVetoi/hmv19VhsuunWtu6Zs=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 22 Sep
 2023 10:36:43 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::61) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 07/14] arm64: xilinx: Put ethernet phys to mdio node
Date: Fri, 22 Sep 2023 12:35:36 +0200
Message-ID: <ff165281a70a38e2b76fee91e6255ce95ce8021b.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8523; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kc//g/1y0rh9FYVmOCYeZe0YqEABaZasL0RUfsUOPDM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3KmbRX8mLj1yfPvpk+u8Mg04pp5Xk0pWV7D3anzty
 +LQwbynI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEUINhDk+f9q3Zf3Za5D38
 sSYk7WqY4QXXZQwLOie9O1Ci55dluCev1U4yaRvT5pJ+AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: f273ea86-6d31-4e84-efc7-08dbbb57d02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io1UCv2WG/dX0H5dRWlmCrz0EyBUYFS4SfMMpfneH4dLhPgvJTv8Aur+GxzuHD8Z5irdwjGohluMWe4oxN/NU/7R1YKVjqxO7TV9dUxnCwao/6e4Q0w5rLvULTL2vsAeo3s7djhx2CgSMecL1DsqMS24qab1rcEIJaSmUkj+AgQgvKI/Ee6CovLMTLEGX805FxN/cr23rUOttThluD3+CdfG/L3VsUZYVMBGeok/T+l+s8Xl51XqkCFX/dsPMl0xoUhlGMj7+lAWr1juRroRHPnfghWhfDzNyJsPzTEMt76V1eS/3xeAS7ShJNDbJeO2xSKm2QUb3q9BZ5niaS1/hEyPtxLFigLmhBesYVF7wUJLStyJJ6jnGRJGkt0WMcnF0bsiVhooh3/QfCLYWRmS37mtUeLGFWBBIysh8jAvoyQtf24PZAaUIXRmAqv1efKiGrnuYXtsr1CkTeWzkNPK0Z8//VLIumN4LKAJnEAlAu+uiLDSoUEGRtTNCgvJ4n3V/4k8PxH4gEl1o5vIjfPmzR3Z5TSv4+fbe030PxKwf8dudgTZrhdNZ1rVZW6CyF+MiHG3QS9x4sGGylpfSxn1m2DWmLmhbg9pr1t2Il58IL2D6lMsSRGi0gqE15s90Aw/+D0eG/zAhJse5OixS2SnMjYpUMXYqI7L2ifBWKnTDloaXnWFgyCr583MZyrb8Pumk6E9Qlq1hT6X9Zua2+tPJLN15Zjq1M6va+WAZYRwomIhmomdnALp8ccY0Nhpd2OHhbhBdMmEwfJfKdwZZ1EWhAoGqo/KDS23qWNDl3+a/1MQqQQ7SgBdSJ6808U61rQV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(1800799009)(186009)(451199024)(230921699003)(82310400011)(40470700004)(46966006)(36840700001)(16526019)(8676002)(8936002)(26005)(6666004)(110136005)(356005)(82740400003)(81166007)(2616005)(83380400001)(5660300002)(44832011)(70586007)(70206006)(316002)(41300700001)(426003)(478600001)(336012)(47076005)(2906002)(36860700001)(40460700003)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:43.1365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f273ea86-6d31-4e84-efc7-08dbbb57d02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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

All zynqmp boards have been already described via mdio node that's why also
convert the rest of the boards. With using mdio node there is an option to
add reset property for the whole mdio bus which is reflected by
's/phy-reset-gpios/reset-gpios/g' for some boards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

we will investigate if we can remove also that xlnx,phy-type if it is
deprecated now.
---
 arch/arm/dts/zynqmp-dlc21-revA.dts       | 10 ++++++---
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts  | 10 ++++++---
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts  | 10 ++++++---
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts  | 10 ++++++---
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts  | 10 ++++++---
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts  | 10 ++++++---
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts |  8 ++++++--
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 16 +++++++++------
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts |  8 ++++++--
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts | 26 ++++++++++++++----------
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts |  8 ++++++--
 11 files changed, 85 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 016081ef7b99..f737004d7943 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -88,9 +88,13 @@
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
 	is-internal-pcspma;
-	/* phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index d5cfc61faf71..36a0db44fd28 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -81,10 +81,14 @@
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
 	is-internal-pcspma;
-	phy0: ethernet-phy@0 { /* marwell m88e1512 */
-		reg = <0>;
-		reset-gpios = <&gpio 42 GPIO_ACTIVE_LOW>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 { /* marwell m88e1512 */
+			reg = <0>;
+			reset-gpios = <&gpio 42 GPIO_ACTIVE_LOW>;
 /*		xlnx,phy-type = <PHY_TYPE_SGMII>; */
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 56653ec234ee..24573f7b6c2a 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -110,10 +110,14 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
-	phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
-	phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
+		phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
+			reg = <0>;
 /*		xlnx,phy-type = <PHY_TYPE_SGMII>; */
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 4c8ae80f6f17..58566fbea78e 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -106,9 +106,13 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
-	phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
+		phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 4bdf58d11e11..529c98cf543d 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -106,9 +106,13 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
-	phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
-	phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>;
+		phy0: ethernet-phy@0 { /* marwell m88e1512 - SGMII */
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 64a676c13257..c456c375ac80 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -91,9 +91,13 @@
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
 	is-internal-pcspma;
-	/* phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
index cffad447406b..5b592324021a 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
@@ -97,8 +97,12 @@
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index bb0477825a93..83648c2a1c54 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -90,12 +90,16 @@
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem2_default>;
-	phy0: ethernet-phy@5 {
-		reg = <5>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@5 {
+			reg = <5>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
index 69ad58039e79..b97f7ee8d44f 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
@@ -88,8 +88,12 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: ethernet-phy@0 { /* VSC8211 */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 { /* VSC8211 */
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
index 3017c9b29a2b..2b66abc9f7e6 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts
@@ -116,17 +116,21 @@
 	status = "okay";
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy0>;
-	ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
-		reg = <0>;
-	};
-	ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
-		reg = <7>;
-	};
-	ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
-		reg = <3>;
-	};
-	ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
-		reg = <8>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
+			reg = <0>;
+		};
+		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
+			reg = <7>;
+		};
+		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
+			reg = <3>;
+		};
+		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
+			reg = <8>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
index 0d2ea9c09a0a..b1857e17ab7e 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
@@ -77,8 +77,12 @@
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem1_default>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
-- 
2.36.1

