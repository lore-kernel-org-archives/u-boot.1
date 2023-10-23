Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15424C25B41
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF24587874;
	Mon, 23 Oct 2023 09:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQKe/mNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DFF87873; Mon, 23 Oct 2023 09:22:05 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4BE87876
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES2ZqZf2lBv8SGXuWY4jVTe4fr36RCqyHoiZ0qq5ybEOZ3nLrodWEkClv7Nck3qYix9rUeR0hK7naap3fkKs0wm2VS/RxrrwE3C3DdFz8Lwa4z6PA+tcIovJx63VNS6r7oCWh0CR5AEzhaxHfApNUeIvBYsRRamB0llZn4kEFOu6/HZ7qqf5rNIg+cmUJDXSUEtsupuciPRujT2U+3ZKs5DCvKDL3T2HS72JoqbF3RL5JedDmrreykurE1NCH8Rgv6AYZB1aSeG7VsrGAhH5ZYCuCB2X0DuKl2wT/iJOM0MlYPmSce2YaGWsQ/cMwrv7IPGD1WwhyTbbKTzBQKwhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nZBHbf/NohkaQrJn+XfVVILyAlT12hABZ2kXcQkcPM=;
 b=HkYQBLOU5kKpGn6Lfh+SSt4PsnCZ0TWc55qMyK219QslywwAVP29t1+JRbvji9sAsJ/00/IMsx8b31+w7PlaBKvG69p5hrVrYhFUY0KATbkbJewnTb8tP8JpkdZ/gtfuqA7TmqhW5CGA7NuZyWIQGqzg28IIeRjVexo6ZZhDu0gig3B2WoTowQVqEqQdhwTVnWj/TW7OR1bEX9Vv/Ds2QlV/NUIAenw1gPJLpXowtcrEHaqSzaj6srxXvrtRFJcOoxuKhz577A1UZiV/5wl4eR72K3cSwyTVnvtplDtQ9+tKUaeeN1kyYzwCxn/tzDbt22GJvflA3iG2B8BgTzSfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nZBHbf/NohkaQrJn+XfVVILyAlT12hABZ2kXcQkcPM=;
 b=SQKe/mNCQuLD2t/iL+zNzp0mF+ncn2cq2MlGfZi4PajygZMuERXWtlTB2nMPpIGTSgWsuKGPiQQ2nPcjPFSeGC9bmLElXPTc5nZ2SCnNORRTyXWxbcWspuGieeISrvHeS+SccX91XxHoXelsqXk4rYC44DTlUITuB3hvCUtLth8=
Received: from MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::34)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Mon, 23 Oct
 2023 07:21:59 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::66) by MW4P220CA0029.outlook.office365.com
 (2603:10b6:303:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Mon, 23 Oct 2023 07:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 07:21:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 02:21:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH v2] arm: xilinx: Add missing dual parallel flash description
Date: Mon, 23 Oct 2023 09:21:53 +0200
Message-ID: <cddf2909d0445eba08b998d42ffc31c1fa3132b9.1698045694.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=k9PDEpZTJpeFnt++NvU3eYKSOV8lkTurel9wofqnwE8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQzuX/r+dntJ2zfcsHVbdGZSZXN+Qfbzs6p/3G7vYl7V
 lyb0JRnHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAia20Z5nCs2fBGNFP7S63W
 9y/3NUpVPHZE3mCYH9gS/1jp8Y4/i+4k2Rudf1CmaPKgHgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a97053d-b3f3-4aa1-e98b-08dbd398be4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVSasQUfLvoPUEm8tmXs2/TtNPqZsZcLEvh0WiIdyvUlzHvGlVo0o7EjBin2qjm5UUU8qXIB3jfQodnm2E19jaBhC1PXJvpbrB2587cw0NMUuEwtlVAEkPPWGhigTAbkf6pqOMFU5hvB1SftD+IZB6QDMm0csSOT7yOM0gKaBrpzpDIe+7ZI0luslS+DbYgb4pZ8GRNlTcF8ywnJGT1aof4DeSFD7atfVvF4yYE3jrkmkSgPy7FgerbxZZugD7AjkbIUXFcNZk6C8rdObOt3Sc0bD6Ids/IyQC9kec1qpkAZ9DlDg/RW1LchpOImS3aaAII+oOa7Dm/0IyJ0xCMw4JxkzxDYGCJNTSZYv+Y/JHvXRUwET2FmmhRvHcJ/puZFpwwruLw3P9ntJXBzCfFyoUR1DCk0JazVH1M1Tar/HLiFFGa4RqOFp3Fnmgzj+xoEtWa6CRez6l+GAPSiL7itOEQQzG51exjjMWrvveBfnHW+DhlJ78do0bK4CE4y0izKqR54zCdX/6oVGMs8XfKs8AjWiCgDkbT8iEyvlTM84kg8UpKXUZ8cLq4lqfDlimA9SpP+umMPWtSlBeaUrQad2vPqsq3QyF+8E++rqeD93VlbqeJOxyVDe3gEQxjbQ6Fs1r5cZw51XGrF+DOxgy7IUYoPtXU5qvHn+GAfk9PVzNnpSf7CjYv5uGzSfkx0a9RXr/lb8/hlIJ7kURFiKal/rr5uYq1/+LUKLU/wyEOZVDpmx+/SfUKz1jrsO9JZnOV+ErpuLjEQE1+CSha2PQ2+lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(47076005)(70586007)(70206006)(316002)(40480700001)(41300700001)(86362001)(2906002)(5660300002)(40460700003)(44832011)(8676002)(110136005)(8936002)(36756003)(2616005)(81166007)(478600001)(6666004)(426003)(336012)(36860700001)(83380400001)(356005)(82740400003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 07:21:58.2408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a97053d-b3f3-4aa1-e98b-08dbd398be4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

Describe flash memories based on the latest DT binding.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Add missing description for zc706

 arch/arm/dts/zynq-zc706.dts             | 5 +++--
 arch/arm/dts/zynq-zc770-xm013.dts       | 5 +++--
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 4 +++-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 4 +++-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 4 +++-
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/zynq-zc706.dts b/arch/arm/dts/zynq-zc706.dts
index 03eb016ed687..18963a395156 100644
--- a/arch/arm/dts/zynq-zc706.dts
+++ b/arch/arm/dts/zynq-zc706.dts
@@ -309,10 +309,11 @@
 &qspi {
 	bootph-all;
 	status = "okay";
-	num-cs = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "n25q128a11", "jedec,spi-nor";
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
diff --git a/arch/arm/dts/zynq-zc770-xm013.dts b/arch/arm/dts/zynq-zc770-xm013.dts
index 21902fbb0cc1..582aa1f1b873 100644
--- a/arch/arm/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/dts/zynq-zc770-xm013.dts
@@ -61,10 +61,11 @@
 
 &qspi {
 	status = "okay";
-	num-cs = <1>;
+	num-cs = <2>;
 	flash@0 {
 		compatible = "n25q128a11", "jedec,spi-nor";
-		reg = <0x0>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x1000000 0x1000000>; /* 16MB */
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 25ef646c8466..83b8a98d80ca 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -71,11 +71,13 @@
 
 &qspi {
 	status = "okay";
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index ece9e6914541..dd37b726d3dc 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -67,11 +67,13 @@
 
 &qspi {
 	status = "okay";
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 7372968e5734..811cebafe9e6 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -67,11 +67,13 @@
 
 &qspi {
 	status = "okay";
+	num-cs = <2>;
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x4000000 0x4000000>; /* 64MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0x0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <108000000>;
-- 
2.36.1

