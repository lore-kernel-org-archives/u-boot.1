Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FF3CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 05:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A7B86F8E;
	Fri, 20 Oct 2023 07:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4Q6K8nM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE18487185; Fri, 20 Oct 2023 07:06:46 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B5C86F8A
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 07:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du+k3E7KYFOcNhrnTHUQIKueymSG+tt728LDKrJDOEtovDurI5wopImJmu4VWSkAZ4j3vp2M7x+eDozGb15VAPANBV8eoQaWGJAH6kF2CNZz1seEAIU0Mxaf/F9PxLMWhsiqMVZjV03ivHw9Apd1awyhm+wZzDhGXaUj9/CPMZERDxVcleahdEtp8PSlWxM83mft0Sn4HTFLFhAEGpGPUxboXaskbI73VgSsbEUezg5RMQK/FZPTT85esF+ZPBg/UsEmk7iQ4b1zk00IFQJWawuFYkYDZTU3D3uEYsOn+VNPD40qNSNjJ3E9jj3thfAgGfwyoKKXRPX/jc4SPrknEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0i5wcwQYUR1h4eXLDX0kceM8mnCLcWhzCCwT1d1HZg=;
 b=Lu2jlyboFbSGYKgT7gKms/pQzWkmz3V8eDZiTj0dofMiJUplIZ5OmtVlR9RWAe+cmtISui3uJl4sBCA5bw0V98YSvvThLBHdA/Mvacve5Hyq2mlGza47fo6DP6fdDnqttTtqkQF3Cv9PjoU73eCbMTrYUyBMIuEg3yGpzpObsqfs8E9g1ccHRXl8qsuz/Ag2WecAHiXQ9GWdp/AgvOECPnS7UuPnROtISK17o+iWaN94N4aYABsifDNnehW6OgdXJYVxY6GX0CG+AT8+aZVbn63jyXlOBzAsg2/RVyLZVFXerjUUzxkzvOIe1UtZjNsONbct9PKlqORNpbpYefsH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0i5wcwQYUR1h4eXLDX0kceM8mnCLcWhzCCwT1d1HZg=;
 b=h4Q6K8nMJibqvfX5FeR9D9ewYwvLQKJn66LK1gbG5xfw97LOqlPPwWcSkwYC20enoG+RXygkmV6VeecGAkt6ZZe+mocZ3D65yq2jCAWLsFlWloneDfzEx01yJX/WszqNkNBKoosjfvg1CrMjbfgIlf91MLL3BKoOmuVOz13XrV0=
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 20 Oct
 2023 05:06:37 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::30) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 05:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 05:06:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 00:06:34 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Fri, 20 Oct 2023 00:06:29 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Disable Tri-state for MIO38 Pin
Date: Fri, 20 Oct 2023 10:36:22 +0530
Message-ID: <20231020050622.972750-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 699b1588-d828-4856-7699-08dbd12a5589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPTe1/1ilvlpjtIQYPrtqztJm+xfK+CzOo5F24QNt2V4GWrEBWDRO0XnOjIuagzXQf7H6Lg02YblST72XYl04OfOSqUEJiOoKl9YmaUYUzF7bBBHZzsN6+xqvcgfTqY3jT5oBRy0pFLXtSjSAS78dbkmf2i5pS0foMYa85spFI6RYc3IcoinRmTYGGYW2WgpsFuZ/8HdHABV9gUL4gpGGjMkzqNArt5VMKGP8ynWhrldO8sYG75lGFc33JUkG4xQGW4kqt9iUP2tEmCEkuSHg0ecuCTxev3JAf6JG6/Fp+9KAPwmuUPQ3tBw7ZAw/wkLv7zEvPKAZDJLQLHFO/Kpj0ETMZsbez8xBqdun+n9d/4EHq+ovGJ+4nmrbkXbHWlTGlboVLKb6bRj/p1AHMC31ZAy3swo7FeiQHbL/Cv2csj1smRXYzA1duYax6aSoL1F+JqjzLHqECAt7SeXytDA8CvkppoeuJEgSCCpjrKTPe5IQciQGgsOOM+ORwDIJdZe7o1HDjto/UxY3kJzCcpJxoL3Of8fyNwtcwKQYsy65U9YmRnzTWKxtT7bZPYhzaMVBe9vyz3OiOwr8Ku61GXv2mkOiAGB8Kker7gDOcWRTcb+ffne/GSe7bTifNJsj+q1n46xLvAEMQeWMoIWMe6CiOUQWFeum5Pd7k9EgjBUbf2ds2G9N6htDI/r0WX8aCVAgzxcUYXu3JgvOrGSZQpMx3rn8xSDOOkNZPdxxNNZrWnXbzjoqqspqb1yMdeBXZDFAyLO9AIv683GVwkqIKq+sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(36860700001)(336012)(40460700003)(426003)(26005)(107886003)(2906002)(40480700001)(1076003)(81166007)(8676002)(316002)(103116003)(82740400003)(6916009)(6666004)(86362001)(4326008)(70206006)(36756003)(70586007)(8936002)(54906003)(41300700001)(2616005)(5660300002)(478600001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 05:06:35.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699b1588-d828-4856-7699-08dbd12a5589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

gpio38 is used in SOM's kv260 to reset the Ethernet PHY.
At present, HW reset is not working properly as Tri-state 
is enabled for MIO38, causing inappropriate PHY register reads.

Disabled Tri-state for MIO38 to make HW reset work.

Tri-state disable :
ZynqMP> md 0xFF180208 2
ff180208: 00bfe7a3 00000540

Tri-state enable :
ZynqMP> md 0xFF180208 2
ff180208: 00bfe7e3 00000540

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 25 +++++++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 22e7d68d02..c4f1da9218 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -190,6 +190,25 @@
 &pinctrl0 {
 	status = "okay";
 
+	pinctrl_gpio0_default: gpio0-default {
+                conf {
+                        groups = "gpio0_38_grp";
+                        bias-pull-up;
+                        power-source = <IO_STANDARD_LVCMOS18>;
+                };
+
+                mux {
+                        groups = "gpio0_38_grp";
+                        function = "gpio0";
+                };
+
+                conf-tx {
+                        pins = "MIO38";
+                        bias-disable;
+                        output-enable;
+                };
+        };
+
 	pinctrl_uart1_default: uart1-default {
 		conf {
 			groups = "uart1_9_grp";
@@ -345,6 +364,12 @@
 	};
 };
 
+&gpio {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index eadc256306..6c5e0e5660 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -178,6 +178,25 @@
 &pinctrl0 {
 	status = "okay";
 
+	pinctrl_gpio0_default: gpio0-default {
+		conf {
+			groups = "gpio0_38_grp";
+			bias-pull-up;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "gpio0_38_grp";
+			function = "gpio0";
+		};
+
+		conf-tx {
+			pins = "MIO38";
+			bias-disable;
+			output-enable;
+		};
+	};
+
 	pinctrl_uart1_default: uart1-default {
 		conf {
 			groups = "uart1_9_grp";
@@ -333,6 +352,12 @@
 	};
 };
 
+&gpio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.27.0

