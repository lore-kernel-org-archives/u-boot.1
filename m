Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B8CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 07:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B9C87224;
	Fri, 20 Oct 2023 09:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KB7jPWQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61EB78715C; Fri, 20 Oct 2023 09:09:15 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71FE8724E
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv2skuIOnQNYN01KHUXh9WZZkPqxzVVywftqlGcMkTicSWso57Ire1bv4webNJBUd5yc5Oxw0vlcSYl5kZ2DsWkrAIh4zeqw+JoEP9BFIcVdRGYMrm7bV7OF3ay23s0aQOOlf1NhkpXxAaQsUFP2RnqA/u8mQp7nS1yNegrJncu1MzH/g1oZkkuhdW2HRQ0lE3vvxAYzgcldPiEgxfwJscdtqCfKGdPWFJAb35qMKUuOFzDG1H0Ws1IPUuhF+NTf3Qw2K3NVV+KJSasLJJIKH9QOE8C99y8CcN7OhWnPV7kvhr8Kets1dBGEIRSWf5SFdsORScQdDU4y1Wbo5kArVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD08lmiK6NKmzBwYk7KzybUTE/yRZ/8PX6L/Rl7TaEY=;
 b=Q2iS6MZdD7XauDf6vzBVSSR4ywZ5Oip0RO/xIE6+WY/ZJOuSGETzd3Cwa+ykVdHxnqEB6zy0wy2pssZY+DrD5IgAsdnXQ0uqmZji86Vq/2DdRwY0tXsTMRxMnJBcUXUjJ+hK9m1ddencqAEQyB8bjte4SwSWA3/FDnP3Aj8gLTQkt9pRWLbEh7Z/L4gKHBc4W8frTRPefvhMFUYdTuBSOjWoAItR/C1TIjsBfoytlcX8JLsscTKj3PfjKYutFXK3kDIefIvGAOqLrpA1NUDIzNbPUWUH7ljva9mQf57Tpn4FwKoVzRU7JnIYB7e7z6+VXCzFaFnm7Xoi97rk1hVhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD08lmiK6NKmzBwYk7KzybUTE/yRZ/8PX6L/Rl7TaEY=;
 b=KB7jPWQyxPPWrGBe2zPR4fz3Lr5L+NI+zLCLiXUxseamBAY9IAMUwWmDUHi4B949cvvd5xofkuQGgd25CcwlJrr4vtkUmrWrN8xfsGn3w/gHSsAgTvmzBgpon1FYl7Ftn9TVIoRcaRQs9L7/7QMqUOIZfJNGOnPAKG5sRKOODKA=
Received: from CH0PR03CA0327.namprd03.prod.outlook.com (2603:10b6:610:118::20)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 07:09:05 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::f5) by CH0PR03CA0327.outlook.office365.com
 (2603:10b6:610:118::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 07:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 07:09:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 02:09:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm: xilinx: Add missing dual parallel flash description
Date: Fri, 20 Oct 2023 09:08:59 +0200
Message-ID: <f6b8dd8d4394332a5b5a1726635f0d97fd70bc1e.1697785733.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mNP9EMhOAU3+qTu8O/7qzrC/7dNL48GY9KD50sPuAyQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQj9VZJT+mrErrWl2f9cTx9hefmvQ0ZfFe3ha36qD214
 LygRvXUjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARnzaG+W73ZNYur3pblnR6
 99Pb6tzMtk1yxxnmCsR6Hz7pw5cgZLPd1+1N/6EZ5o0vAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 90358de4-fc81-4559-66d4-08dbd13b7184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auN8AFphEUN5qKnJQ5K87V/2CbqV//QbAlhIMQJYgAEDb4EXRhDS0zpEqRLaSOQE5jCXNVlmnhrZkN0bkqVhqg1PqrMdvKs+YV7mATB26eiGofiygbDCqxddRn3Mv+Zi31M6a8Zb6/djwrj0UfAKkatsOsRto+tOg9j1kE0q8qb0wzKQ9PfWTSPEGaUaxemV0D5LaOKttoMpg7io6R+Wri5KZnz8WlQSux0AmVXUV2YMlMhOrhXK3Bx8Vw6Wmqf0sqkXODCoQYW3Up0Jtbs66thQFw/JQXuw2C5FwITZJQ6EsONbCEp1ImmPgm1L5Kj3TLjBKBrCsMQ4zLqnhQQZ3FqX8LxiEpdqikZRKyCd/AElZ/WljwFKYDwIYmlyODWFP5j7bZc89LS3YOOfl2pyoRln+OHgMNtRehrL/HVgTv+W9u4NCznbf1DKapMteCuZL3JXyz1hzLzcf0z7VOMbs2KK5XtWr9yyUqgLmkqOsvaCSmxLNR02v6ftS23XJWEc+QWdkReQM/46MC49F7vmgNHjYReyp2JZkq3JrxR7v0ShNQuaQwLXj4m9vpjd03/cLhYiC40TfY2/vRG84IKWwZerjFAkdwgYEGofBvEqe0Vd6AUC1Yy9R6mS74ROINEGwChG31CB9hfb1nMKlsBKhFIymgDIe9sPgCUlLhvIz4llbT1fzN1UJjay7ma5zcgojW56r5Y1HKoaXnkJm72Z6fS/ksqJVGWlOj5LXslBo8JOSlNr46XUXXwrxUVwNidV8bG/BbWRDdzjynnA3AKFYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(316002)(40460700003)(47076005)(336012)(426003)(16526019)(2616005)(26005)(6666004)(36860700001)(70586007)(2906002)(8676002)(83380400001)(70206006)(478600001)(110136005)(8936002)(44832011)(356005)(5660300002)(41300700001)(81166007)(36756003)(86362001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:09:04.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90358de4-fc81-4559-66d4-08dbd13b7184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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

 arch/arm/dts/zynq-zc770-xm013.dts       | 5 +++--
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 4 +++-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 4 +++-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

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

