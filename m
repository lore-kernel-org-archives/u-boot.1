Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D1BCE9D48
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A91A839F1;
	Wed,  7 Jan 2026 13:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAaMI5bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800B483AB8; Wed,  7 Jan 2026 13:13:12 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0B5839E4
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcHD4RHYAqDUhfxc70bNMiPLgwgZkHnHXLBiDeRE5RNCOFSOXJiR+u8GG4ot18EUVQKWM+lnM3futS2N7o7pS7K+IxuTOYQd5jw/5YsxafIjw4N4ZuyuNxoh6UEqwlLHHGDYbwWTVJ9XDxNrj77W+jKlXafM2qm31iDKSDHdta5rlSuhcZyF85vCVQQ/Mra8njvxAEcChJ+oQ7dwy1uMRAEEEDuzyuJIy+OyXZBJKlZDL/3Vfgm6EYI04aSaDyt05FZK5Qkf9Mb2eBqJmichBcxjnzjBd9flbMygCYAo7LVGr/oaamk/G0KBfrwJXdH3WDrBQ582vAaOO3u3tU9m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDb9o9LqnQxWKBjWS/D7+K2pfHTC3LKhOC7JVY6gdLY=;
 b=I5zk0C6lWtjayOHm5wNzwR4ROqZC3ZwBsbN04ater+u5n6kvyrN/Cyh7qCMNSrquzOccOxENIq/LfvNtJtnb5im1tpx07WEoPsmpQeGu8kYMOzzUAbYPGWfOT6BmxOw1QRZ+GglQ0PxRtWxRjHQI5C2riKVRAJbX8cBNfOzhbgkrqqwIbQGWMEXPQD/Ucajfs0ts99amF9tdFJHhurPKKAq87BKgfleaUMF66TgLfD8VTA7V8eoxVdf1NXcWT+/5i7VbkuEBwr9I7jrbt2rCfLbFtGzkpEGRTiDsfcwYeRBWNPuAxN8u9L4sHHlaVCDJvhfm0jFNzaHAaxtZfW34sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDb9o9LqnQxWKBjWS/D7+K2pfHTC3LKhOC7JVY6gdLY=;
 b=rAaMI5bcnclavApEzENHMJa9+IIg17gGLGGpIxPU24ts5PlCex2vglRpAVoveyHnajTvZPNMD6Q7BXNIFRI/cE3k3BxsjyAUncuWy00ZS90AiYO9wkrje0GHprZU86g9d2t/gZZpbKsbihxDCZbvZJ+tdQj2wlQRUaqSMIJpfxo=
Received: from PH8PR21CA0004.namprd21.prod.outlook.com (2603:10b6:510:2ce::11)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:13:05 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::33) by PH8PR21CA0004.outlook.office365.com
 (2603:10b6:510:2ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 12:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:13:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 06:12:58 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 04:12:58 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: zynqmp: Remove ina260 IIO description
Date: Wed, 7 Jan 2026 13:12:48 +0100
Message-ID: <138720bf2ff976974f5ce3566446ecfd93b9259d.1767787961.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3861; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VlOHVeUz/dP6CMnzK8SYopKJBVsGDDB/NrO8iFfUMME=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTG+R7qVJqrmzA1cKIvuy1H2rpemVuFR6Iq0nav5r0Wa
 bZ5akZpRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkVhkjw1en17Uzw94LRkUL
 Os9a2vGn8WB7SttTOb1JzlziV5o+3WJk2PUnpKCVc9evNULfHvW0Kt6veLyidcuajVM5/7OZVc3
 6xQQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: f02e0d80-c189-4152-1f8b-08de4de61c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gsemmBoERBdBHgWPUSXmcVlXKZk53/UamcEqqQzrIldFJ9yP3/8YJIkCimLK?=
 =?us-ascii?Q?fCQO5HeMH+6De0ZeYwEvEEnoInNl6mpY9cP2ePVykFqKrqKEzFW9FmmIqe8s?=
 =?us-ascii?Q?ngyBDAJwlvt+OWeiMzrUARoPWD4csQ0SbOx6XQloK4UlL2iKUqmsW/8Gh/tw?=
 =?us-ascii?Q?8QZ541F/6MA0FKj5LkOihuua1qQ8nZ9CuMYntORRSN5LauepjADgzhZH2xDg?=
 =?us-ascii?Q?AC55QfvgBYr/XVL5Z0Az7tbJjwkbEajrq0akIb5vNoLNd+FTEoaKo1S25wTP?=
 =?us-ascii?Q?4JdkIIvDWoXjszrae/bxTrSy8Evz3GZv9/9H8o0Z6jyXgmJWX9uxDRbkoWZ7?=
 =?us-ascii?Q?G27bYhdKoQUgidoRqNNitrxGPvYFm+sQ+jAA+fTMMUW0hmcdbtK4aYUlRoe5?=
 =?us-ascii?Q?HBjblAwWyLX78MvBDl+G66ntBtKxM+XdL488UACKdsNMQAjoo3vJVY/ehKry?=
 =?us-ascii?Q?HrfE+ETwgnPR7F9mNAuAW+Q8lS/HDAbWX+B9iWb5ig3hooSoa1/qi0i6cY6h?=
 =?us-ascii?Q?00SDGtvVyA46GHLjk0QIMjqyhb8zv+vgUl2mFOGuvuCP3+kiDWg+ITHSaLfo?=
 =?us-ascii?Q?F7zX9QMskcCKSlODcm/kBDgo/ZDJA+tVYgftL/9E1aUlsMBIUUlN6L/yY/6U?=
 =?us-ascii?Q?U6KvrdvcJXCTHtWM/gZqfbje2pSJECFn4DAuVlC2xHvkZxvDClK5SH3UcEVX?=
 =?us-ascii?Q?TBznbHLMMPDboW5e1vBFsHphLGK1GJ4ioD9fnkPpFCYUy43ijqMUvza7KByJ?=
 =?us-ascii?Q?4tdVC4wUJfZNKkNHhuSrBtPd3Z0qXfwQMQ6WR1i/UxM4WS+45GHFHNm/bBwc?=
 =?us-ascii?Q?//0y572ER0F1u5Weh2p37Eeujj9Z809vdIYCB8Ozqg7az1jNh06xP0pWD3H1?=
 =?us-ascii?Q?lhoCZSf6XtQWN8JNootSvDPJBNQtTKd5n6yRFysdBsVplJYZTzb4rTlNWD4f?=
 =?us-ascii?Q?Sf0VF9e/Ne64Iq0x6kIMhetnz6DL6+LEQWnTT4YuVAwNgTYqkNvJhW5GPbAx?=
 =?us-ascii?Q?OBs0tt2zMzLJO5Q+cwR4ZOxBUsvmYUNsm8ooc/bew3/awGPGICxiCSNNjSeh?=
 =?us-ascii?Q?GxFtPbkPemvDKVHNOa30oE5bbscKCNQD8RKQ9PzRanGvXjVULtW0iJWXR+Yo?=
 =?us-ascii?Q?U/LtEcgvLvZOR+tGz5Etq7V9VqUCiMtm1uELfv7MM/YS7nY8lJxBiyuG7Qk6?=
 =?us-ascii?Q?6JTKKFYi+TgQD6aD605Xv4L/qvn0p5JF+/Yxp1BIwH+elxUZpSe137DVvar4?=
 =?us-ascii?Q?ir87czUKo0CgBYtPHadLwa0QIj7RmSqmiwo2zU+22QdQSBms6ltkdOrvYnfs?=
 =?us-ascii?Q?Yh5vnorPwdIWGqrIaB7npL6Ep6S668kaCVcB8bCteaxaunm67juiqJAu6tZk?=
 =?us-ascii?Q?MW5JVgWad/LXIes113WfOw9NeEwbFk1qvcqplQxQt+Gm7hve0jDSz8Zh4ucW?=
 =?us-ascii?Q?eEK72dXtiZjaBPwG02zDlNOXV2OsY20qdO1WoE641rjtGbdtHShksYfVRyKA?=
 =?us-ascii?Q?E4eGp9Gdi8lN9y4b25KVTRLPWB865aEeUtx1QIqb/wr1wQ6SrPc1f6uHCQV0?=
 =?us-ascii?Q?JPHck+3kKPWnA+iHnWg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:13:04.4504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02e0d80-c189-4152-1f8b-08de4de61c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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

Kernel has hwmon driver that's why there is no reason to wire iio to hwmon
converter.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 6 ------
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 6 ------
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 6 ------
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 6 ------
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 6 ------
 5 files changed, 30 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 02be5e1e8686..832dc5ab2458 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -26,11 +26,6 @@
 		ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
 	};
 
-	ina260-u3 {
-		compatible = "iio-hwmon";
-		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
-	};
-
 	clk_26: clock2 { /* u17 - USB */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -67,7 +62,6 @@
 
 	u3: ina260@40 { /* u3 */
 		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 88396d089f43..532f6bf92bc5 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -25,11 +25,6 @@
 		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
 	};
 
-	ina260-u14 {
-		compatible = "iio-hwmon";
-		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-	};
-
 	clk_27: clock0 { /* u86 - DP */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -95,7 +90,6 @@
 
 	u14: ina260@40 { /* u14 */
 		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index e041a962d89e..458d79e81192 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -25,11 +25,6 @@
 		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
 	};
 
-	ina260-u14 {
-		compatible = "iio-hwmon";
-		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-	};
-
 	clk_125: clock0 { /* u87 - GEM0/1 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -96,7 +91,6 @@
 
 	u14: ina260@40 { /* u14 */
 		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index fbbebbea80cb..e7417af8ae01 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -32,11 +32,6 @@
 		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
 	};
 
-	ina260-u14 {
-		compatible = "iio-hwmon";
-		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-	};
-
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -96,7 +91,6 @@
 
 	u14: ina260@40 { /* u14 */
 		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 87f94f8ef9d8..7a05180e58b4 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -27,11 +27,6 @@
 		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
 	};
 
-	ina260-u14 {
-		compatible = "iio-hwmon";
-		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-	};
-
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -92,7 +87,6 @@
 
 	u14: ina260@40 { /* u14 */
 		compatible = "ti,ina260";
-		#io-channel-cells = <1>;
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
-- 
2.43.0

base-commit: 988a6f38ed9cfbb9757b76a16cb9cfec4601de85
branch: debian-sent3
