Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A2DCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37D383AB0;
	Tue,  2 Sep 2025 10:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tVmy8D0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A024783AA9; Tue,  2 Sep 2025 10:54:46 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D0883AB7
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/fqYhgVg18FhzltkuqlCnDsuuLdPCFtUwTnuQq22Dd92j9y5tcTucJN6bkDRShqG8otFBHllwIcgjcJfbrbi1YzBY3YWt3V3viBpYxSWRe5eIyLSnjwB0vDU8mj0iyD8xc9gap13vUJayD6P9N0bTgZdImlGH1h1umnWAo8NUhpovTLQ2TNEJvrvA8aUFn8u2cA0Mwkp0h3fiQnUVkWNw42th7iP5Vz8WzukswZXYcczvFtQI3oPP+6CQlOMvofV8CS+/gjpNFeiAn/cwD4pJLLKGXIY6aMA3v+ba0IZODWcOuPNOQyfnVstK8wXUoc6iuz+0c6Ihw9szH0xg4rNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oOJyhHqezpdLYFcRspP6AiM29bMEPTKjJMbjhMZ1v0=;
 b=KzeC/D3P9dAH2uBgYr2xw9cB2K6ws93pgJcJCGxRbgeMrPGZHFFa+eATqxOKnG/6RLW7A3B6jTY0QnaR2OheIIeiB4ttJfevxcLGk6FcfjPYa59kEX9Sr2IcnOzT9vLD1NO4QYCE1Ysto3BKC7TrN3b0dZZvxrEMpt1inmLGIH5vQIEqTpSpEo5Da79oMR1msmbN1dK21y28CbNvcyR3AxDP/Ayg8Bi+WGOm5kQMvInsz8GitQctX6NBXA+ppmSYoFWLUiZmFgbRH8d5KR8pEjV3RjmjdxVFmCve0IFLpIboUHZrI8vGycwNPRZDESWERo8czDQB8hKYxNP+0Ny7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oOJyhHqezpdLYFcRspP6AiM29bMEPTKjJMbjhMZ1v0=;
 b=tVmy8D0iGlO7QTjJlvkDe9NzLO3J29FBZURT0b41N1qeuQGtTxegBO5Jfhi6fjqfyj9D9sjKKhAFz3ALtmuxoMo0U0OkHrv6Z5ChsAJVFgEv7iQX/7LCq0pDLMMghrs/WEZE9AKu26rywUCSqL2ZAECySjxpEpn3o9ICbEebRaI=
Received: from MW4PR03CA0050.namprd03.prod.outlook.com (2603:10b6:303:8e::25)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:39 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::54) by MW4PR03CA0050.outlook.office365.com
 (2603:10b6:303:8e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:37 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Rohit Visavalia <rohit.visavalia@amd.com>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Paul Alvin <alvin.paulp@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 11/12] arm64: zynqmp: Enable DP for kr260, kv260, zcu100,
 zcu102, zcu104, zcu111
Date: Tue, 2 Sep 2025 10:53:33 +0200
Message-ID: <15e863adca11431f68d37d732cd8a453e508ad91.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6033; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tgMlenAEXiGUQdQT+djcmExb17nFes4BtQDM3yYAYuU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29A3I/nFsV+C+hN/vjlu8pj18o+jK4Q5773c2+0mZ
 7Ui/YyuVUcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMZK0nw//4E6dZFyV9YBPO
 m/VUpb8kX+RFxNk50Xw6LB6zizfwnQhiZFjzZEXo7sg6o/gvHz7tcRIwWpH+bH3jnodsr/fryBV
 qHGQDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4bc64e-1bac-4632-266f-08dde9fe59cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RwAD7ch+P72k/LRqS7L946wDcVMur2Vs/sRn9bU22ys9H6qyFcXcnkDmy2fP?=
 =?us-ascii?Q?0xfhJfeE6nSi7lVJwEyOZSj7uJE7DidCEn/c0GtsQV863Mp/crF1o4SesfGX?=
 =?us-ascii?Q?pw2qTOTlI3cEoHs0sCDPEGIiIqpyqKfw1qr6l4cW8meX7niFK9n94nVys0oY?=
 =?us-ascii?Q?WHHSCveA1KNSPDV05OtaWZCri/77VhdhLaftsj19AGq1IDvQjW5hTrps2wm2?=
 =?us-ascii?Q?xLdvdRAEaTCP6S+7n9isf2c7V8eFbBEGmEsk98E1rJdZ+PAl3WhaVVLsExKg?=
 =?us-ascii?Q?TJqliF2Ve1cdmrtv426yJO6JW6Q6z/LA+ZTWJ2KoALZRz1mxdyFIYSIyX8Yl?=
 =?us-ascii?Q?TeNz4pKvFHIJD8M/TTBJup088VoAFAVPBNJUUv0OALfj/mBnFxFVw8vjDXVw?=
 =?us-ascii?Q?dYtal6KCp6c4RerXIZfE+ymC/fkknxCDhzCzso9uNkgh1oaSbalc98hUDD2U?=
 =?us-ascii?Q?sdHB9kHeXaB+X2nJUoxmh6qqgiJ5VpaeE7pRf2c3C+p91Zj8KDCgksdHg3uq?=
 =?us-ascii?Q?8L2bNrFvoQr2LfvAcuysC5sc3i6zlH4zaxfm0K43KvcJfyGEnbzbt9u5E3Ae?=
 =?us-ascii?Q?7D3EuqH1xFVKy+KhA9qlofylHhpHinfJPnEV9u8d/aSod+jY3WkxSNXBWl/f?=
 =?us-ascii?Q?i/4sHJfR+Uq0kVlu9w8P35jK5g7EeLsfsyJcsFcmpKNze3suJfk92oO2chPR?=
 =?us-ascii?Q?nGYxrmVd5aaUpfugmIBtBbw9zNKZ9Xzktbv6i4a/iyPMM2b8MugMgC6fC5gA?=
 =?us-ascii?Q?hepEpn41abh6jAuCvw5lF66cwlgjpa6m//RiVelD6r9/L2UJ12h4fLrkb0Mu?=
 =?us-ascii?Q?1SKfhxpukwZe/K3Hs38ANlKNihYSJySYv//5iYqouQ7no/SnspVVeebNOb6o?=
 =?us-ascii?Q?oD8QhzkGJ6eg5YmS4lDClEnfLiAgGXOEmGgwtDns6ATrnARVhbbwFmi1wKwN?=
 =?us-ascii?Q?1xAOylrsvYD1zdDB2Dz6dHYYbuasDAm1fxm2U2wtZH3hVPmF1g2ie6ntdCQ6?=
 =?us-ascii?Q?epy8LkAiDvDB4dMr9zxrMODC7jbDatR4w0SA4BOGM0/7XWdla4yV4rDdvRcU?=
 =?us-ascii?Q?/nbQRpF+/RCG+GyVdWimLXQ8ra3ICcYb0YxzqJr59NVvY7DXvNb1t+0q1I1f?=
 =?us-ascii?Q?ju29x2KEeuQM65aatollA+AkjmkHktHFPrIJaW5rozlM4ciruvERl1J0aVIr?=
 =?us-ascii?Q?WG6s1zEGOQyl0+aKPfcc9unJ4uHLiIbrq9TE3D6UZJbRVynvo7bKGn7ZGwOJ?=
 =?us-ascii?Q?L/uCJaoy1isdnwjv8WFRWczdLv4H5kxYTRMiAIq2Cx8ZXe63dLEajjnPF8ci?=
 =?us-ascii?Q?higns79rpqSP36olmvu6P9CTangc4JrfK77myhodmbDHM0BlFZmNja5fs0Y5?=
 =?us-ascii?Q?po/jhStuckVRAGNU29ml+wXJ3h3WVOH9bCV34xtpRkzrd8XxxIxKb9NhWVq7?=
 =?us-ascii?Q?inq9uRC8cUkSi5zlQyWrUz9SPspJ4vZxWuLNUne1TNPzo5x6PZwwkKCprwRa?=
 =?us-ascii?Q?Fhfma7HyaQMPzzVoJThnGMJLQoXgoWz2ktGK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:39.2656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4bc64e-1bac-4632-266f-08dde9fe59cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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

Upstream DP DT binding enforcing dp-connector and port description to
operate properly.

Co-developed-by: Rohit Visavalia <rohit.visavalia@amd.com>
Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
Co-developed-by: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>
Signed-off-by: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 17 +++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 17 +++++++++++++++++
 arch/arm/dts/zynqmp-zcu100-revC.dts    | 18 ++++++++++++++++++
 arch/arm/dts/zynqmp-zcu102-revA.dts    | 18 ++++++++++++++++++
 arch/arm/dts/zynqmp-zcu104-revA.dts    | 18 ++++++++++++++++++
 arch/arm/dts/zynqmp-zcu104-revC.dts    | 18 ++++++++++++++++++
 arch/arm/dts/zynqmp-zcu111-revA.dts    | 18 ++++++++++++++++++
 7 files changed, 124 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index fbacfa984d76..b92dcb86e87e 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -71,6 +71,17 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -145,6 +156,12 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 };
 
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 	assigned-clock-rates = <600000000>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 3c36eb52e968..d7351a17d3e8 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -72,6 +72,17 @@
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -122,6 +133,12 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 };
 
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 	assigned-clock-rates = <600000000>;
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 3542844e6977..4ec8a400494e 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -134,6 +134,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &dcc {
@@ -607,3 +619,9 @@
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
 	       <&psgtr 0 PHY_TYPE_DP 1 1>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 955810ae7178..7fa77b59906e 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -151,6 +151,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <114285000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -1082,3 +1094,9 @@
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 64d822255ec5..135bfa080828 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -60,6 +60,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -545,3 +557,9 @@
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 3e883d717c2f..20d17a07e7eb 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -65,6 +65,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -557,3 +569,9 @@
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 3a1580dfc400..cfb4f6487675 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -129,6 +129,18 @@
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
 };
 
 &dcc {
@@ -882,3 +894,9 @@
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
 	       <&psgtr 0 PHY_TYPE_DP 1 1>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
-- 
2.43.0

