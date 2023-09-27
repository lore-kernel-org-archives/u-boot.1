Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BB4E810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3D186B94;
	Wed, 27 Sep 2023 11:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HTwE/b6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DDF86177; Wed, 27 Sep 2023 11:57:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4403586DDE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4EhCO1UbRdwoCDb3/XZSBWmI3FseZo+uv9hvTwYhDNzSKVS/0NkeTC+K/V+8bbZk+JkjzJmCNgh9DyaEGpQVceAOs4V2PvL4/kkcm9ZK6DlnZL89BK2inkUY0ODypimL3KVv4y+Ut3dBcvZr7SloQsf+t2WtGSynJwv7AJQWKyGyVieQZnYm4bwIaKntI78ngClo3sKOa9ocBbBRbqtYBphx07T3hSVQaIb7szCd+t2W5kO1q6mb3etmUS4FlX0wfRZGZSV7MJL/S2/3npl98uNMA6z3rfnwXdVtPzHLfflB0CqNBGuM6m0ewUzXfNBUgBL4HSzbO9LBA4WsqHhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjmQYSxlOr7FwhDSJcAcpXhmYBHkZ6H7znmUTaNfk7k=;
 b=g6NK0JZ2JGuI5U0DzK69mbuDjr9wazLlB9mwghZdSHkmI84YPD3agCtZ9SNVDmUR61eZLebjcZI12YpeIra9WXftwEtcDtX/55ZnEhQcDn80kJfKz7Fp2fvcU0ZrsVsamJeiWu8iAkLbzoLbA8tLTshYWPn4m+PRKXLjvRRYoNC61mJYicsiNWW3296OYfmTp63fMlkCzVzjLaMsTFJIbYczk0d3MRwYOgrDpbF55zIvvWb+eYTH+BF2WCNN7gxwMtTikLpDNT+csICuZEUuhGu6IsGDYkxVQat56fmJK7TFtMTbBZeJ4Kz1P9mFw1kcvB/atUYuWiWW68aXoIdFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjmQYSxlOr7FwhDSJcAcpXhmYBHkZ6H7znmUTaNfk7k=;
 b=HTwE/b6urX4WQBntGivSyYp+ihLSlPPrs7TZVTc0sfKbG5mWdhAIYDbQd7QAbsF8Nl4EafU4Q2Dk2q+5cw8CK6PY8zUg71cv4PBbrnblhYZQDaBVN4hYt/WVJX7g/vwz6mP7B6EdbFu9UpZRFNUrmVNLtDuw5NRZQfSD+CXSdHg=
Received: from SA9PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:6e::21)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 09:57:51 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::42) by SA9PR11CA0016.outlook.office365.com
 (2603:10b6:806:6e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 09:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 09:57:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:57:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Do not use '_' in DT node names
Date: Wed, 27 Sep 2023 11:57:48 +0200
Message-ID: <dd33d6cb0595ffedab117d477f4a3c9d9eb11715.1695808665.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5961; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zOaV4JKmmfytS78RrWrZ1Rr3AzDiri2u31jZRqdoA8g=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlThP7NuBF+//Pl/lciuuw8YYthWdOxYxBe2YcGqnjWi7
 Ke3z9x4rCOWhUGQiUFWTJFF2ubKmb2VM6YIXzwsBzOHlQlkCAMXpwBMpOQjwywmvhVlck1+bE4M
 6165Xfn81mylqxXDHF7/2TYX9n/8b8PVyxDvtiIzqoc7BQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b002360c-2d01-4877-3531-08dbbf403646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9sHQWiJOhW+5xLZiQiRw971QQVI2PyKGghSClYvRdV5NxAmhn+wcAIQXob/hytEDxbm/HPfOklwyrt+9OtCV6imJdwIaVmU5yUE/MdQODZsq7GbMAFbQgGklrYdKd4lkjSkNKfflws4d6Od2eR+Z9aAe0DDdG9H8PgFJUMD9b9fHBxVU4a4ZHB+Ae5POcKkHqeEOYpDp8urr6JXlmE0ljko5qQwpaWv4qYmnU3Gl8rOSa/ETYW+8jy91IZxIJKi8CMLdhWt15KKubba8U5rGqODlYu4lDG7k1IvFEutq7+KfiDIZxsWlzaBHaJ8SfWZArmghvivbKaYKrCE/sH40d6wUZlx12U5FUQ/cnVPkN4NxdvDnMPq3vcbeiJzZ8JxFH2orVhmW+P3w/KK9juyiP2fkRkIlSKKLuoaH13Rj0iEl0cnyCc+MfwU5v00AtZugu303oDA439qVMKUp6+s63g/Lk+//TbQzu+ns2tDr1XGUKiE7FtIY0haH5YX6jLP/iamvMiNn8bfQWG3S4Nfn4cgS/8vCzLKqGHSrNI4ABeEl2PEfV6lkD67mkuo/pFIxjAPoKnO+GQ0DqwJPkPZdzeiA7HhVRFadLK1zjJALxliWc5O1UvnSyWlpIwMLFNMHtY7OudINMteGd5DEHw22nnWNqsD8mxgk36tZ74xfYav690VQAuTdLEbsNfQcSebiAJvfMreHuG4jeKpOi86b3XA82aDKDxSaYR26w2w3U2jfyGUOopY5JNryzgg9ukTcYFLgiE+s/QF6m0VOz5LWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(2906002)(70206006)(86362001)(54906003)(426003)(110136005)(478600001)(82740400003)(47076005)(356005)(36860700001)(336012)(83380400001)(16526019)(26005)(81166007)(316002)(5660300002)(70586007)(36756003)(44832011)(8936002)(40480700001)(41300700001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:57:51.1815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b002360c-2d01-4877-3531-08dbbf403646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

Using '_' is not recommended for node names. Use '-' instead.
Pretty much run seds below for node names.
s/heartbeat_led/heartbeat-led/
s/gtr_sel/gtr-sel/
s/zynqmp_ipi/zynqmp-ipi/
s/nvmem_firmware/nvmem-firmware/
s/soc_revision/soc-revision/

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 8 ++++----
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 8 ++++----
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 8 ++++----
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts | 8 ++++----
 arch/arm/dts/zynqmp-zcu208-revA.dts     | 2 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts     | 2 +-
 arch/arm/dts/zynqmp.dtsi                | 6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index cfd5ba1aac63..25ef646c8466 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -363,25 +363,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr_sel0 {
+				gtr-sel0 {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr_sel1 {
+				gtr-sel1 {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr_sel2 {
+				gtr-sel2 {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr_sel3 {
+				gtr-sel3 {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 18e14389f85f..ece9e6914541 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -365,25 +365,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr_sel0 {
+				gtr-sel0 {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr_sel1 {
+				gtr-sel1 {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr_sel2 {
+				gtr-sel2 {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr_sel3 {
+				gtr-sel3 {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index cd7654a9f7ed..7372968e5734 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -359,25 +359,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr_sel0 {
+				gtr-sel0 {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr_sel1 {
+				gtr-sel1 {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr_sel2 {
+				gtr-sel2 {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr_sel3 {
+				gtr-sel3 {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 97b9cdf82ae7..c456c375ac80 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -427,25 +427,25 @@
 				#gpio-cells = <2>;
 				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
 						  "", "", "", "";
-				gtr_sel0 {
+				gtr-sel0 {
 					gpio-hog;
 					gpios = <0 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_1";
 				};
-				gtr_sel1 {
+				gtr-sel1 {
 					gpio-hog;
 					gpios = <1 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_2";
 				};
-				gtr_sel2 {
+				gtr-sel2 {
 					gpio-hog;
 					gpios = <2 0>;
 					input; /* FIXME add meaning */
 					line-name = "sw4_3";
 				};
-				gtr_sel3 {
+				gtr-sel3 {
 					gpio-hog;
 					gpios = <3 0>;
 					input; /* FIXME add meaning */
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index d09e53f42fa8..22ad8d33a116 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -57,7 +57,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index fd026347c25f..575ff5b1b77b 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -57,7 +57,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat_led {
+		heartbeat-led {
 			label = "heartbeat";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 30bd7b499603..f03c201caee9 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -136,7 +136,7 @@
 		};
 	};
 
-	zynqmp_ipi: zynqmp_ipi {
+	zynqmp_ipi: zynqmp-ipi {
 		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
@@ -206,12 +206,12 @@
 				mbox-names = "tx", "rx";
 			};
 
-			nvmem_firmware {
+			nvmem-firmware {
 				compatible = "xlnx,zynqmp-nvmem-fw";
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				soc_revision: soc_revision@0 {
+				soc_revision: soc-revision@0 {
 					reg = <0x0 0x4>;
 				};
 			};
-- 
2.36.1

