Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C271E810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB14D86DF4;
	Wed, 27 Sep 2023 11:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDn05awi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CDE186DDE; Wed, 27 Sep 2023 11:56:17 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BB686E02
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsz2onW5Ol9InbjP+PXjSb67UpkIXyBQ6kFKbKhTQ7bHnMCo9JjeztuwY0nyzwuJodtTSlxN/79n9UlLluPDz4UItHE2liCnAdqF1aGFE89ef4aR41ne64bbRNueyTii7LDMzlp04S2vBL4vfef/Ev9+dZ+IHI/b286jr1MyvpLCCtKItyLgZHYdgBBz/Gcq28+T2RXcs5C/bwv1UstI5dwEBp9f8cSIug9g5OdCZGpkmcYARD8K50Vqzvh8OvopS5fwCyZsANMcXQN5/XXztt/7VtYjbxZRBmrUj2legc8bIM4B6oN2VjuyVX/tOPD9WdhEu3e51VxfLLIZuU/GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSVHSe6K0jz1U1GduyZ+oFQ/kzipNiAyJno4HhBh6e4=;
 b=ilPqg1qO9EznLXRonqcXSCPnx2qZSjsQfusteWBKg+lQu2Coyrsqg0J2FH+Rao621VHp3XqmDcLl7EYKNlb3S5KAvhRLMv8sh8KKLZz/raNpb9hYTAX05XhLO7r72FWLSop+J009puXkdngsEDJkHPkq7ijkdk1+nWrST7JY5OVliBXAEL3t7gcdtnXDjyqyE5/zWNxI4G21mreDhaqQVWUxLWgENOR5WtcLpicmXaJ/U6ohaK0NWD4foJU45kDcPpkbHsColrmb9xpGx7v88D45TRT4yNZ57/RD/fS23UB6nW2NPJzYI4mF2SwtEPexbIm2qUJR80afcQ2JXM/MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSVHSe6K0jz1U1GduyZ+oFQ/kzipNiAyJno4HhBh6e4=;
 b=qDn05awi951lNm4KlI5FexRN2eNZW2Flbs+Bq2CP+FYfL5uZbvlklzp+bbukxGGkpU57LztxlOo/KAVpBvp1smWKMUE5/P44reKD4G/ACYnUfNUBOw5masw6jbir4yHGKOqB932gP2zV37AHXDm9N2ds3+R/PnjIaAquoTZK8Ik=
Received: from MN2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:208:a8::26)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 09:56:08 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::56) by MN2PR12CA0013.outlook.office365.com
 (2603:10b6:208:a8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:56:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:56:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm: dts: xilinx: Remove undocumented is-dual property
Date: Wed, 27 Sep 2023 11:56:06 +0200
Message-ID: <15980560b98672959a889ff9970cbe9540b4ed69.1695808563.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6942; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zZB+S9/M2ratC+2BqxPVEEVnllNE5reQ2j7UtYnRTt4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlThPyYaPw81y/uvYV1XmFW5XVKj6ly0+1r9fL0Z11oEl
 4WfLD/TEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZifYZhvsuimUd1Z8f4V936
 Zp1x4/H81Nt3PzLMZMw8qHFoTVGR6+InylIz/l1fPf2JHAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 252ba047-fc5b-4003-625c-08dbbf3ff934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tShIVEAqQs3JG252qD5I5keyhBNoyFNwxDQt9lWQi4/oJofYuRFEmL3NYe310qMdqQ2HRNwPh8acO9wYKDOCUF/GEckMMbNcOpfqW7xMbW0bCrdPdgQobnAfhRtXqVn0J6VJCF6nAz/fQ22R0leKS4XYSPdgIDnkpLWLLzKc9arAun2DX8kv62yPXNOy880d5JWTPkMsPUZrouvayIIo4+wu+BuyYu8avhM9pa1pUA6tPp2TWUv5lVS7uacv3xvY+tVqAmJAlSoFbGVfPVuiIdgKau68WNtD5Bi5eH8/CIx2Q87T3bJj7kVTZMZGZoSuRq9eeP4gQZQoMY5wz2vJejr609pBgRWY881PS19N0BBATvRfpQuKDsO4fOY3caZ98ZFF+oJ0vkP7MQeyp4opSK/Cvgnlnnlga3YsHo1yz4gXhxbe29BqwBmFwziEn6MUIOloANeZ/1V/s2c+A0xpdQI1ttfnFM0laluWfbOocvYXY2htwRQdtAs0aIH4BAdPZbWXGvCHcQVCdIVUqpzAnL7XtA3lNyfpa9eOywVq9dbDYBcwEwCCJIaCZ4wf4sCg7mgJw3xsJ++gFWmGMeiGRfRQZFiRBaPNpGyOrD4qHOdtbjc116yVPiKmcqNbeqdcoGQS43stc9iqhSxmWUr3iuIEih9lsucXRJg1BjLbjdW+vzvHnyo/FMeYMPnwoJJADzAKAJfzDNwjUxD3/XeEz3u1z8qnEEiPsoCh88WT7qz5jDk1DrnetJ8CmOX86WNnuumn3MOR0lXOS5b+cISPZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(478600001)(356005)(336012)(2616005)(81166007)(426003)(2906002)(36756003)(86362001)(47076005)(83380400001)(26005)(316002)(36860700001)(16526019)(82740400003)(41300700001)(70206006)(40480700001)(70586007)(110136005)(8676002)(8936002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:56:08.7393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ba047-fc5b-4003-625c-08dbbf3ff934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

Xilinx was using in past is-dual property for QSPIs to reflect their
configurations. But handling for them never reached upstream code that's
why better to remove them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynq-cc108.dts                           | 1 -
 arch/arm/dts/zynq-dlc20-rev1.0.dts                    | 1 -
 arch/arm/dts/zynq-minized.dts                         | 1 -
 arch/arm/dts/zynq-topic-miami.dts                     | 1 -
 arch/arm/dts/zynq-topic-miamilite.dts                 | 1 -
 arch/arm/dts/zynq-topic-miamiplus.dts                 | 1 -
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts               | 1 -
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts               | 1 -
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts               | 1 -
 arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts | 2 --
 arch/arm/dts/zynqmp-zcu102-revA.dts                   | 1 -
 arch/arm/dts/zynqmp-zcu106-revA.dts                   | 1 -
 arch/arm/dts/zynqmp-zcu111-revA.dts                   | 1 -
 arch/arm/dts/zynqmp-zcu208-revA.dts                   | 1 -
 arch/arm/dts/zynqmp-zcu216-revA.dts                   | 1 -
 15 files changed, 16 deletions(-)

diff --git a/arch/arm/dts/zynq-cc108.dts b/arch/arm/dts/zynq-cc108.dts
index dc942b0f595e..593ca4a49cf5 100644
--- a/arch/arm/dts/zynq-cc108.dts
+++ b/arch/arm/dts/zynq-cc108.dts
@@ -55,7 +55,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <0>;
 	num-cs = <1>;
 	flash@0 { /* 16 MB */
 		compatible = "n25q128a11", "jedec,spi-nor";
diff --git a/arch/arm/dts/zynq-dlc20-rev1.0.dts b/arch/arm/dts/zynq-dlc20-rev1.0.dts
index d06838c5eeb3..8d0073780336 100644
--- a/arch/arm/dts/zynq-dlc20-rev1.0.dts
+++ b/arch/arm/dts/zynq-dlc20-rev1.0.dts
@@ -66,7 +66,6 @@
 &qspi {
 	bootph-all;
 	status = "okay";
-	is-dual = <0>;
 	num-cs = <1>;
 	spi-tx-bus-width = <4>;
 	spi-rx-bus-width = <4>;
diff --git a/arch/arm/dts/zynq-minized.dts b/arch/arm/dts/zynq-minized.dts
index 3214ee49e283..96d2937de8bf 100644
--- a/arch/arm/dts/zynq-minized.dts
+++ b/arch/arm/dts/zynq-minized.dts
@@ -39,7 +39,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <0>;
 	num-cs = <1>;
 	flash@0 {
 		compatible = "micron,m25p128";
diff --git a/arch/arm/dts/zynq-topic-miami.dts b/arch/arm/dts/zynq-topic-miami.dts
index 57cb86aafd29..8307a2ef9dd3 100644
--- a/arch/arm/dts/zynq-topic-miami.dts
+++ b/arch/arm/dts/zynq-topic-miami.dts
@@ -33,7 +33,6 @@
 &qspi {
 	bootph-all;
 	status = "okay";
-	is-dual = <0>;
 	num-cs = <1>;
 	flash@0 {
 		compatible = "st,m25p80", "n25q256a", "jedec,spi-nor";
diff --git a/arch/arm/dts/zynq-topic-miamilite.dts b/arch/arm/dts/zynq-topic-miamilite.dts
index 366fd5bbb100..af0bc7ecf700 100644
--- a/arch/arm/dts/zynq-topic-miamilite.dts
+++ b/arch/arm/dts/zynq-topic-miamilite.dts
@@ -12,5 +12,4 @@
 };
 
 &qspi {
-	is-dual = <1>;
 };
diff --git a/arch/arm/dts/zynq-topic-miamiplus.dts b/arch/arm/dts/zynq-topic-miamiplus.dts
index df538865296d..36a7db355e5b 100644
--- a/arch/arm/dts/zynq-topic-miamiplus.dts
+++ b/arch/arm/dts/zynq-topic-miamiplus.dts
@@ -21,5 +21,4 @@
 };
 
 &qspi {
-	is-dual = <1>;
 };
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 2c3e30ba8916..cfd5ba1aac63 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -71,7 +71,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index ad724a135872..18e14389f85f 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -67,7 +67,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 296af0426ee2..cd7654a9f7ed 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -67,7 +67,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
index 3750bb38b585..0d96c6f9f041 100644
--- a/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
+++ b/arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
@@ -56,7 +56,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
 		compatible = "st,m25p80", "n25q256a", "jedec,spi-nor";
 		m25p,fast-read;
@@ -66,7 +65,6 @@
 		spi-max-frequency = <166000000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		is-dual = <1>;
 		partition@0 {
 			label = "qspi-boot-bin";
 			reg = <0x00000 0x60000>;
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index be75ca6443d8..e166c9555069 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -971,7 +971,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 6cae681dc29f..b90ff61d2416 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -978,7 +978,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index d08865203ecf..ba9e4891fccc 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -789,7 +789,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 702888177a1f..d09e53f42fa8 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -643,7 +643,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* U11 and U12 MT25QU02GCBBE12 1Gb */
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 989ac28c106b..fd026347c25f 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -653,7 +653,6 @@
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* U11 and U12 MT25QU02GCBBE12 1Gb */
-- 
2.36.1

