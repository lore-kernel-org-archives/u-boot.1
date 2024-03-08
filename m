Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7D0C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 08:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE5E88044;
	Fri,  8 Mar 2024 09:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nB89pgmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D926C88044; Fri,  8 Mar 2024 09:41:01 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E61687E39
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 09:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNa/rZTTSqV//mvUTMlCbuvHIdMAoQxID/466ySLqki76TAAH72HQRx7GS+ziyshUjPyVXx0dnA9pfVpb2iZEXRXivky0FNGiX9gQHdynfEOfnQw+qdRBcgl8E7hp6qmjQIqOOXL7CmJQ1LO4dcBS0NJ6pCC2ptr1HrMBZDj0hld11dMU9GYXb8kpKn8/1KTonVYT2LZ//m1fkna5hHn31TqSelZPyO5Bj21dDXzIAw1i7E0JkaBiHq/QuL1vuXIf11xnuRwCIbIbA1u73DNWc/WFzzxlSL9w2dAFO+7xDD19xhwc0kejuC6CyyvujPmRqXhLQlpLPtd+RZPkQ9+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwtp2jmiQ1SUXdcKJxoVbyRVkMMOeJMFH0AC5O3o0WM=;
 b=OR0u2Xu5xZ7VdMp9ejyLlu4/mvSKoZ24OmHxORRA/4xMR7ozZdJt5r/tVgP2C2L8wPolcAzdK5F9tLguHz/tqdgTM4Sx1tSqbeUkAcQDLaMB4zTCs55UiiVnAegaBL+SgB2xqUqbYvso+xI5k3pLXqJ+epFHdcPF/z5vqv58bdb27LpVkZMBpQtd9GiUzOeereKcOB2XduJSpG7OGtkAYYjpddE4H9oCJkYV86OOCNRENmqmoKDdbbyJrzuLFXCWU3MioAmof7bCQ7M2bACartskeEzt5fWqoH5wyyWMjxUSruVz4SovRRlJjnEpH0F/imTTlz3XwbBFXZO3sSbMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwtp2jmiQ1SUXdcKJxoVbyRVkMMOeJMFH0AC5O3o0WM=;
 b=nB89pgmkrmSoJcQ45eGkaEB6lTsaH+Pq9k0mwh4FmK0qfYe7XPQmfWPA0eNf5V5+3DDifcoUefwhbENGaQYMYXsh92DLxqML30AB0G0hYjsmHZhQqwvvAdxwdz3bec7tfKwo3C/kn8z3jraMfT5PG3DwbzO5xjWArf2yoOTqZoQ=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 08:40:56 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::83) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Fri, 8 Mar 2024 08:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:40:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 02:40:54 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix gpio-key DT description
Date: Fri, 8 Mar 2024 09:40:52 +0100
Message-ID: <a67884f4fad98b94198123eef45ffdad511b0dc6.1709887234.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TTI2UHns5wL0ZCdf1vA/Q090mKODwNWXwZ6eOn7Vv28=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRX5zmOux0okOZKv/l99pSr25brHMy36jw58aNojs6//
 74O5z5e6IhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATyRNgmMMXH8nn+uAGu0WD
 f8n/LbtdxQ9fuMUwv2pa+zkD3v1iH9YkBdnmKZ/IL/jSDQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d652a30-9514-4cd7-0a0f-08dc3f4b78a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcM6sMXqy1YCnFlC5cZTt3apDVdBaaqc5T48lzDnhPay730UwIH3TSdARYkK6JUqTkRWU3g/6wFj5qo0FnCJ2ScoLmZgONDguGenqWwOo/wXgenfNp5yI7aot1M0pfYvE1xGLTuOGBreRtJqixZuS+uD/eC07/BNJqKq0jA72CXdKlFj/V1lyZ0gX32BTrXWn7231AjB5HiXPTAEXnYNhj8XcCiWG/dQRoVqQ3mAmGrX82tm0eHlWWUSOLgaCUDWZ5PF9hWLN7Z/kaCupSqGxzVIKTlEazz3vGxobY6iVs4chNS7s8c4t68eyre0hbcBqajxyzAUgObwEGtHQR7LUJSDyFdT0ooMqH7kY54VL2DLKVrlknL0yOgRoDVEIpGphPhQGvXctel7Fubawk33IbbF0gI0HXlqvQb3qZQgPWEwZ/1YCsKxTX/qPp7nhhaGNEfC4rd+lgQu+oQlKZ3A8vuGRLWbt6B5ec0h23U2K5f2yc3ATEKVqJByTL10ja82GmD8dJ48ZLNg02kfoS3IEwdZbWiYrcOXcGVGIfuFIefFUiUObCbRTOMKOO6pzpqFvSi0erJejFEAffLVDgC4DFKYa2LujP2XbcpZy+2U2XOq6zrU3SzsPHlDfuXaTCBaOsj253RBncT5/Crtqan8MJ1PBDiq9mbJaYXoPrtN6y14HXaydaJ/WOctniEyv4u6xj4AM1QBYqSwuSqWhNSdBXuI26+5uScDYX+1VzA678cGjd+Q8P0O/NrEPlS8tZVe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:40:55.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d652a30-9514-4cd7-0a0f-08dc3f4b78a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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

All gpio-key descriptionos with dt-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-revB.dts            | 2 +-
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 2 +-
 arch/arm/dts/zynqmp-vpk120-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu208-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu670-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 8517bdad6f47..de2d7842ae28 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -49,7 +49,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		fwuen {
+		key-fwuen {
 			label = "sw16";
 			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 2a3bbe170472..b626d1aacf58 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -47,7 +47,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		j383 {
+		key-j383 {
 			label = "j383";
 			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index e0e4f1b13ada..e0632883e4ec 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -47,7 +47,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw16 {
+		button-16 {
 			label = "sw16";
 			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index b4e24745a9a6..a113e475082f 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -46,7 +46,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw19 {
+		switch-19 {
 			label = "sw19";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_DOWN>;
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 6f593e80841f..4d7d5d2e5eff 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -46,7 +46,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw19 {
+		switch-19 {
 			label = "sw19";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_DOWN>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 7f70904f44e7..def3b53cef7f 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -49,7 +49,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw1 {
+		switch-1 {
 			label = "sw1";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <BTN_MISC>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 0adb2062aef1..41f9a23d06ad 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -49,7 +49,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw1 {
+		switch-1 {
 			label = "sw1";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			linux,code = <BTN_MISC>;
-- 
2.36.1

