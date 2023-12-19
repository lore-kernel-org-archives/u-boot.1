Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF23C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0180876DA;
	Tue, 19 Dec 2023 17:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WZdd3yGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C3B87646; Tue, 19 Dec 2023 17:17:09 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EDA8700D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBLcrHfhcooqShM6eMxlrwckX2yeaWdZ21B1qAuXrZZnoK0XaUoXSGk9HvfxKXIzsUQp/RBEMnzcJnJNzjyRNKGtr+0vsSf8RNTGQQr0valWuoBNGaNnNEla8zXlM+xCVThFS6aIoFsSBT4cIXcRc2Fsi7s+vXvR3JKoU2HIv+gSi+8e56h1Jfc3BmHhaXyIBUId1Nq7YchzUINibK5X6G+nC5uMj111+vOoEfw0bBHh9g9dp6DoS1TW0SYBqza2FRumFeQvgQR5UkiT2pHSj/hhIshzVqFKrLR01F6vDiIT8ABUxbERkzBCT8VV0q4sNDseqaV8jo7c6hyOQcjjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1t1ugxrSwJYiiLoISPjaGGR709/+77tj4SZgmAf1J8=;
 b=f45pay1l6FDQJ2j3ZGtOU3kNDQjdJpLbkjzqqPoVgOX6bYM/POnpmJ1S+rFd5BGC6kKysedrwINnzmMc4lCT3yWF5HhULHScvJfTCEuoC+SHp7dSQMMsKytIszv21pcSRBZPzvYTX/BS2JQLs61DnNiaH6fIw6eM5bKFLM4xaOM9nB+EXkEOXRmQ4Sv4Zsu4YZL7I01omuJxxWsHa864ZtvpTTMtX68BwFfNR/E3y8Xn/R2XxGSsc3rUsK7Ufd4uilttOsuyUQ5diujwvzN2Wq0Y6VkX4W2/VuM6M2ka5kILVMlZPcE4A4d+z11TMzYFel9v6CpHSdBKsNYSuYQ1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1t1ugxrSwJYiiLoISPjaGGR709/+77tj4SZgmAf1J8=;
 b=WZdd3yGcgXg7/Lkt97oqnX+dywNign265l4EEdKhUP8nfnSfbLHUx5Zk/DT/iUezYXVJBpny1DblyO+IrgGAzXWbKZaFyZkYg9KvftSY6/RE3+0YrWzA0g2yEMXFEm4hGguhIwuabPFykzdfK0EOpOHVlB6c8TTTWPGXCOoAmAE=
Received: from CH2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:610:50::40)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 16:16:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:50:cafe::55) by CH2PR16CA0030.outlook.office365.com
 (2603:10b6:610:50::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 16:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 16:16:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 10:16:56 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/4] arm64: zynqmp: Move fixed clock to / for kv260
Date: Tue, 19 Dec 2023 17:16:47 +0100
Message-ID: <9a6c17fa754add356b3b03356e41d15e4a18648b.1703002605.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703002605.git.michal.simek@amd.com>
References: <cover.1703002605.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=R7rvyRXDia4RgSQkArIUK0uKVlDwJxns4Vlbjhb2jTI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGg+83ryiI/xd5aNscrYqD1/YxbBLdGadsau/1mrk7b
 GF3wubEjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRvQUM87SW7W3w+OQa4732
 p9b1rSXi/+YovWOYZ3awPrvo4jGzPK7nf/3WrxCobL14CgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 79758075-c2f6-4939-d516-08dc00adecf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtPbWT3DlQfeMfLeMja/wGPfa+G7KkXvEdXOl9a0UCVuNrJIuNv7I190CWeXDogHsr0v+nAr6gpls1IX2a+coJVYRFhxJf2q0FNUtr9+GghAeA5oOc1BrX1yK+grdrGDSYN00z18yj34JWB7ZFkWBHLL72NgjI0ivkT9OFXUsYCrk19hGA0+vlLO/8DqX0z/KwCzM6AKAaZrBRKIjmpcjMl9iPDy3TlWfYAa+XM6RaFpYeT+T1ovIKureRr1QsQ0poN0gtP7D/GW9r1CrTunSq10y5pHjw4xoUboiJGAKWwJfmXopR3r/0EC1F+TB36OqzYIuC+9McMiCQ4IEPx9PJgxpnQfqJon2NHt/0B7wFZfLFBBI/lbsxonI1CreT8KHi9Z2mSc9abOErsH4IfgUMAJq27DwywZHrE4Y3s2UeZnEufY3B/zX4K0HcRAhnLl/PEOElrFA67zFtX9J+JF0btuJns7FiTgaMRb/uWQuwS42t+hX7x5PtEfgUh6RP+H9nGVC1o8DlfwL4P5HIOLuYTjaXHrNvjegKy+IHQjtKKXezof26YLPBCSxIMVxRA9yF2pDrHZWxZnqWn/rwNiePOpI7BN0L1rsBwNk6vALY9op1pTZofx7tsG+StINBk4iDK8cso2d7VZDFuWfet6GV9TDZKWWjpdUyFc3nRbkB6TughkxF2djGus5beEpIIP4reAL9ZUInP39brJXjwfX2NSx3hwJ2gHK1ZSIvyI000uCmRKtuS8RClQrdoSpFrkTXsb+kahamrua7OZHvH4WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(44832011)(8676002)(316002)(2616005)(8936002)(336012)(47076005)(41300700001)(426003)(36756003)(2906002)(83380400001)(36860700001)(26005)(16526019)(5660300002)(356005)(40480700001)(86362001)(6666004)(81166007)(82740400003)(478600001)(70206006)(40460700003)(110136005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:16:58.3535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79758075-c2f6-4939-d516-08dc00adecf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

fixed clock nodes can't be on the bus because they are missing reg
property. That's why move them to root.
And because it is root it is good to have it as the first node in a file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 38 ++++++++++++------------
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 40 ++++++++++++--------------
 2 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index f43c159cdca9..3db420cc94bb 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -27,27 +27,7 @@
 		     "xlnx,zynqmp-sk-kv260-revZ",
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revA";
-};
-
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	u14: ina260@40 { /* u14 */
-		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
-		label = "ina260-u14";
-		reg = <0x40>;
-	};
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
 
-&amba {
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
@@ -90,6 +70,24 @@
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 and SATA */
 &psgtr {
 	status = "okay";
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 3643569cc7c8..6756fdbdfe9d 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -22,28 +22,7 @@
 		     "xlnx,zynqmp-sk-kv260-revB",
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revB";
-};
-
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	u14: ina260@40 { /* u14 */
-		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
-		label = "ina260-u14";
-		reg = <0x40>;
-	};
-	/* u43 - 0x2d - USB hub */
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
 
-&amba {
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
@@ -86,6 +65,25 @@
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+	/* u43 - 0x2d - USB hub */
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 */
 &psgtr {
 	status = "okay";
-- 
2.36.1

