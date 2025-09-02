Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3EBCA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A995D83AB8;
	Tue,  2 Sep 2025 10:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JeFrRx/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CAE83AB8; Tue,  2 Sep 2025 10:54:44 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF8283AB0
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWpVv8wDLtDGsjSNPxh8LSTlpIi8m5/gOoIc3nbNQroOpWkatEX8sDE94nGXIrEBk6XvPRfFvUXj5QH0ITbzQLOewSNJmJ+4b2+o0gDYojg8b0vJMKZiaE87HsuGnpJHoec4opkgdB0XTLOeeJ/LV4A+gMjUsIYY1506KBNjw4g1TdWENAdE2PWXsaIf96D245fSNc88ty8d14JAiajDJph65MOySoLaXzBXh9qRkO/P6h4gF+f9RmAAkwg9VsAVIakBH0vm6ZPwzVV/wM0HO4Ye/g03eri4IX13yQROzlhJK1vvNL8kAJlS7lzlxWq5NBZFMMx7RYHV+70eLpt2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+o7obv4W8NuIrdnEwZVKEzu/cXJvbh8NsJBwLckfWE=;
 b=mirVMzeNtVwsQSNNhdtidYajPA0Sx5zoE25GbtCBH0cR1pOqjcFFgWdDYEaI8guc/7Wg3t1VmSzR/pOnB6yybHSbtvltzKARPTGDR4SISl12y/7hZ5+Pzov6TYJkCnsmdHG5j+CHegp404WGhFw107v5xd66APFPzA4K1Z/vS5irJdGbej/p3bGF9RRVLZVEvz0nhoMin/z9VBFE+dErlPSxj2+lrwEy8ROlXTfCmIctjDHpXYbF2QdeIQgNmzyMGxECBQnfwrawNMuKZeV20jqLNUsmvSZKbiI+snTzYeRwj3JBa0nDWvuE5ckOKWt/Gylj/5wWb0wu9SS0QASPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+o7obv4W8NuIrdnEwZVKEzu/cXJvbh8NsJBwLckfWE=;
 b=JeFrRx/OwC0Sd91l+HHewu8Nk/AnAdn+vWRjw4SglpXz2qdaGWsNIG4sN7WyeXPys30x3FBH77VqP2ZvJyczE7Y2dLY3YfksxGvhczpqeOvLnVIjpLUzq0UEIAOplh6Ku2rFSS7ImisBva2zdx/F92AaYbSFlZ0czNT+BraLTiE=
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:38 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::70) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Tue,
 2 Sep 2025 08:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:34 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Quanyang Wang <quanyang.wang@windriver.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 10/12] arm64: zynqmp: Introduce DP port labels
Date: Tue, 2 Sep 2025 10:53:32 +0200
Message-ID: <933151f48f236f64ec9e91b9da4f174460a269e6.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IC+RjEXB4KNvcUsxlF4p/R2zm73N3xhFB6+5iTKYfEA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29Db0fnvtMBp2xP/5540sP/z6e7inw2hn1sattZ8e
 /COYZF6UUcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMpHoSw3+/78zHE+9UtKeW
 f7iqIdy39pZ5ViBvT5mp/BrdPw77ZnAz/I/YlDDn172/WllmsZf3HN3+s3DDm8NyOR8EF3WdaFL
 Z184GAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 62eb3ab5-64cf-4328-3f8c-08dde9fe58b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gq4ZLNWbKfb+s0S6hDBkB2cRmfFRYTc/Ae82po9UeSyHmT3UqnITgZtOU21d?=
 =?us-ascii?Q?8wPdNibgEEyz9MFsPN2wIReCmrTnRJUt2Lor8C/WCo+YN6lv33XnF6NPlxy0?=
 =?us-ascii?Q?p4sXKZzD1AWNlfj7pHQaa2esCOKgmGMzl5o/RcepLMJ4ceOnalvu37T6XKOW?=
 =?us-ascii?Q?lRJ3ev3yXDsyNzdBFiPkH2N9Ywuel1n+W6blQ2GaoqZdL5pPWTrR6R/SV5Nv?=
 =?us-ascii?Q?PPs6stAZO7q/BePqj4d9fp93U6rmmb9XiGZWpTC+2dMm2KHhYsxqgM63Ajca?=
 =?us-ascii?Q?eO/NATjLsF2Gg1/DEGIFjJEQEebIe1ftnoQ7hfgQIMuzv75TPEmwE0iGBYvZ?=
 =?us-ascii?Q?juGe/vDuTgrxQmS6ESQ+IRO8SSR98U6E49uBc5yVRQJjbuCKKwQTo/LbNnXy?=
 =?us-ascii?Q?l5KsGuOD/L8K/0GGzOoAJ61saiCxmyC+YgFrmV3LmIpXtB1s4J9DZ4imv9YB?=
 =?us-ascii?Q?IZVXC5zof1QVw0JTzf3dElOWNaUW6nsjDf73e5BhzBvmeog9T4VVdUKydsbN?=
 =?us-ascii?Q?4a1+nN7ESQnVDQzUWOlx84zSnvEfNklhYOF0JatMfnfvGPDfYpEo+V99F/+P?=
 =?us-ascii?Q?MHrYC6Se+ytVVN6g4iEZlOIUvRygJ9hp5kjINAPx7cXCUYvEbxKkoHAclZW2?=
 =?us-ascii?Q?1uZ/xf9znOWzOP9lMfuTNTlUZYgzbBsgJCSPu4EDsaaeDTQkGJqye5F7N/MH?=
 =?us-ascii?Q?9h+aa/AeUGPzkQ8asI1Cr7aFoUpiowizeXOAoBD7rcSBLJLZXIflUL/YTKJR?=
 =?us-ascii?Q?93F/ftGZKf3CRUURrDUTWvBdbJBnqojwXtwVAVMd59jPrhACOdCwXk4pXXeA?=
 =?us-ascii?Q?pYfGtIeCJkBSYPLxHx6KxAwARBvWddIHNMnfg6Cgjp91icL6PCPuP08KiXnt?=
 =?us-ascii?Q?XidEz00XLNOhG/njTfiLP67EF6OsLysMxdtAAWUjXyD9ocysO8zAoSAGZgvp?=
 =?us-ascii?Q?KqfCLOzjoY+1gGg3JtRuYEeP83YLDRmg+uoiEOBcge+MOJC+ACC8pmxCndv1?=
 =?us-ascii?Q?SckGWiDCdi0T4OQOYDbCN/oj2pay808ri5xLdyXi3b6mJsIr2kcXtJEXUUCf?=
 =?us-ascii?Q?YX0bEDvebz2R5VcF7UTO6EBg8LEQ4cE1cAQRplc4QZi48TH/mTRVGdzXBAFL?=
 =?us-ascii?Q?YvNmVxSBOv9ZcIARNhBkIwGykGLTbvCGYTMyT6BAFCoSaCt5GyO2l9xV25Kj?=
 =?us-ascii?Q?RhjH/9p6JIM+pIMHmlZleL9caFajni9XFnNl/kkM225084Q/hP4P5JVvvgGI?=
 =?us-ascii?Q?yuXDt+6Inv3nnHAJqRQchYnO0fySA6tlCzcTot1u/dW7Vgx2tcxtBF1Csror?=
 =?us-ascii?Q?gc80m5wI0M+9SJfbKbT0XNJFcizBAD/loefr4e3lCPJ1iRoBcfXnaqLLODBT?=
 =?us-ascii?Q?V8MYk6g8zo6hcJ/nCyETl9Nx5sg40SOILaF7VMzO5e8K/BimBhsexfS5+6d9?=
 =?us-ascii?Q?PB620LoQyLTST/aMBhMs8/zHr/iLWFJQR9Y5+w1YmGL0clr1bgqN8Cfv7PMA?=
 =?us-ascii?Q?/vuK/JLk4hbQhHzBYnH/b4MKcDPfnBAr3nLk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:37.4560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62eb3ab5-64cf-4328-3f8c-08dde9fe58b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

Describe every port by unique label for easier wiring with DT overlays.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 10 ++++------
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 10 ++++------
 arch/arm/dts/zynqmp-zcu106-revA.dts    | 10 ++++------
 arch/arm/dts/zynqmp.dtsi               | 12 ++++++------
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 60ac5085f738..99ad220d13d6 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -155,13 +155,11 @@
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+};
 
-	ports {
-		port@5 {
-			dpsub_dp_out: endpoint {
-				remote-endpoint = <&dpcon_in>;
-			};
-		};
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 078d98e8ff34..a4ae37ebaccf 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -116,13 +116,11 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+};
 
-	ports {
-		port@5 {
-			dpsub_dp_out: endpoint {
-				remote-endpoint = <&dpcon_in>;
-			};
-		};
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index a19d78e5546e..1ec95c67a7d1 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -1079,12 +1079,10 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
 
-	ports {
-		port@5 {
-			dpsub_dp_out: endpoint {
-				remote-endpoint = <&dpcon_in>;
-			};
-		};
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
 	};
 };
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 27bbb9230fe7..02e1c4615c7e 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1320,22 +1320,22 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
+				live_video: port@0 {
 					reg = <0>;
 				};
-				port@1 {
+				live_gfx: port@1 {
 					reg = <1>;
 				};
-				port@2 {
+				live_audio: port@2 {
 					reg = <2>;
 				};
-				port@3 {
+				out_video: port@3 {
 					reg = <3>;
 				};
-				port@4 {
+				out_audio: port@4 {
 					reg = <4>;
 				};
-				port@5 {
+				out_dp: port@5 {
 					reg = <5>;
 				};
 			};
-- 
2.43.0

