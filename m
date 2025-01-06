Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98CBE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C845805D5;
	Mon,  6 Jan 2025 09:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o82Wq8x6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B349805D6; Mon,  6 Jan 2025 09:43:06 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DF48058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXRj160dw4G803k7S8RsM311GALv0RQLtQHd2Ym+6JrxJpZ9vVLCZkxAESi8T7WMNBNiuclSyZd8cF9F746BryfHKtVIBKeO6tVYlYffbdpgS1n3yVjcTOGX/RFjnjyf0SWQByArs2rdKT0n4Ap3nWo6sZaFm8SP4m40D7kUIuXnmQ5h5IqJ1Ehebad5V1PDjdLLkLjNGdqSirO6QgwdpxiLHvBXPn1HQ/HCuD3aum9VtdIF5mTM4AIRkbU19rB7X2idmZ4Ga7QRJPCrr+E8oDI2pjzOaUwX9D5cCYCFZ0FmaLCXBdLwWc/nhJNOpTxnSMXSBQ8c17UZX4rDnx4G7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbPYR4omsmxX2afU7mlm7q6U040zaO6gPvoyi8WDFhg=;
 b=PKw8j21jWke8v/XmRTJdicTQcxfJbMq7H3nAJVY50KMrLJp2hiHj8uIKLtg8cYudMeQFoWpfjRnAGk2nu0lFWbu6Ch3SQnuNnmcv0nlEFf3JSZR/rkrhXOLGW2ZhVkb637tAxGA7kS8pbvb4YHFleGGok2qnXkGqXRkkxQpCb+CHZGI+xgxWAOhBNWw5WBVrMQyLK9MwDXJ9lO5winkd6w5DTjyLi8oB4o/wsO6Bw+fWJNkEwYaggJaKtqOkU/wXoyV7R9Y/qrYctTBdyZSViipCvMScQVsZ5bDo8opQzoUWVMglF3qnZ2oN4Ncl86zJrlEYYcRc3hyQnv/+ujg3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbPYR4omsmxX2afU7mlm7q6U040zaO6gPvoyi8WDFhg=;
 b=o82Wq8x69tdfzTExUHti/mgOV27G3cUguA3QbAZ8g+BnjgipngvA5NV0r0qm8jh1G6ZSblqzmeg8iv+pwHTF4WhYZ/j54IfBoPhR4wWyLEpXk+QpLcYbRg5Rs03ugaLIKX5PYdmRc7apWH0Rar4WmL6NPkvLpTIeIOGzmJ3/9xk=
Received: from CH0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:610:77::29)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:42:55 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4b) by CH0PR04CA0054.outlook.office365.com
 (2603:10b6:610:77::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 08:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 08:42:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 02:42:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Jonathan Stroud <jonathan.stroud@amd.com>, Paul Alvin
 <alvin.paulp@amd.com>, Saeed Nowshadi <saeed.nowshadi@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Add eeprom labels for System Controller dts
Date: Mon, 6 Jan 2025 09:42:48 +0100
Message-ID: <878558c3c859599d29bc4ae2278baebf84b368e0.1736152966.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oEUnCtzqBZXR9wPCdrQI7SxOmADK9iuLuyd/yWHgHzw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTq6V1fHJQcVBsVG6XNTxUxBleGvfDJi5458/z51gW6z
 nOYLBd0xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIkEqjEsmDf/vecjoSjP5eqb
 0xz7Z6iweLk1MMwv5bbW9r69Jbr9fcypmdf2XtnT4/QNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9ad7ea-460a-4a4f-7df9-08dd2e2e1d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlOZ9Pdcgx2EFoBUHmipNGhrodr5RGgwWx99v7o6YzHkEjnkjvp11R33pL6s?=
 =?us-ascii?Q?nLtxruggD5Pz+N1n3S3Akg74jjpjXaxnchPgvUGMmPPjekcqMsGN9sAw83Z6?=
 =?us-ascii?Q?gbKH4nbBgnGha9NB7QABh86+74V2+/558VWNbv24mWmY9TG8tDBx37dfgnE4?=
 =?us-ascii?Q?1tVico8ChlCHFnZclL7BL7JhstLJ6aw8kNHMktXl37ltdbrezxczZUAqIOnv?=
 =?us-ascii?Q?9mZdg2/fUVcOBAiNEZ0q9jpal/qyE7NN/UAbY1GUvZxj0vnjYbpQF1GdzwjN?=
 =?us-ascii?Q?JsAvYOHF+K6yN7qmehKw4Ngh/+z+3fMp54E1o2Q/ZUa1IStDezVpE84peVtZ?=
 =?us-ascii?Q?AU1flCt3vnsnB5GVW7232Ev4oWH7lsroxtztEaomRZ3KrbX7UaLoGQ1i+Qn4?=
 =?us-ascii?Q?K5IPoPbKUJZyX/cEXzi9U5oNH424ED2+u3mdAan7U72NIYrMLO3ZKACo+fPl?=
 =?us-ascii?Q?9tl7jjjOK8myUvzXKFY6Eat7rqSRelFg2xBeEHzojbYfF3iK4+TzgUGfVFQF?=
 =?us-ascii?Q?G2O96ilfJvhcPrFc1vlisglC8DIwZ8W3SKT/db8U7+Y0MqqH7t5XegzxOufC?=
 =?us-ascii?Q?vi5ImmPXNffbTlnNiQ1fSWL3adjdAOai2Ilh5Q3WSuqX4NMT9vbjaCbUq9xI?=
 =?us-ascii?Q?fPtzpbxi+3IqOcD8e6YNHCfs2FgPAME63Y8rtwyE9vbKadXXWI7KwOj8kx7n?=
 =?us-ascii?Q?dBGqoSlFn3BpBjTEzYnQ4oM34a87xBSQo5OIrjOYPuS2ZxYWbl2LhKjFsd4a?=
 =?us-ascii?Q?yXClymp+tIN31ppsIRaRYinH4HUKeX85HvSgeA6V9J4ex+fH8Jb9a7+dVs1O?=
 =?us-ascii?Q?Crf1vHasG2JG0l/ThcCAQAyCgup/wabsU12ec3TNN8x3/5r253Ek3zZcEw7b?=
 =?us-ascii?Q?8rXYKjg8d+IFSfUw0gJ/Gjo5D89yRy3L7MXWT03NJa5ILIQOh72azxgeLGXU?=
 =?us-ascii?Q?8K//fBOP6aCBhzqioJ8XP0c1FQVrGrI5g3GwhCmbLYnEahpY7qWXD4hFupPd?=
 =?us-ascii?Q?XNGSBnBC8+U6AlIGlZE6enPSPUi1+/xchrgZFuivvd1VsDzOgpYZPauZJC8y?=
 =?us-ascii?Q?VOcDksfQwY/BvJzLe9q+CJA8HvovA6oen8F6jrroT9XqyiaBEQBrtqMduZjf?=
 =?us-ascii?Q?q7Bc2qYTmpbAmau4Lvz5vmc35O4sBX2apJOfPNxSsMHqoBu7FcCFjEGbB3HN?=
 =?us-ascii?Q?powOeRTy3Bgk00w5SJgsvcSRwIz6j9ZVwfd8/C35n+GL9W4IwosLsg9OHKVS?=
 =?us-ascii?Q?4lNrKjOX4Dry0NcWoaY3hshzpCqKXssbTibkknZQeHnvhTktBXr7klL5OwOX?=
 =?us-ascii?Q?zpvsG5ZJSdBkAiQr1Xptv91kRjes6ML3n9P7iMgCohYCOEs6rt+eKwEtwVR1?=
 =?us-ascii?Q?D0A2Fj5ZDOqvqTPYQ7Tn1slwCUaUDibEKwvHNZ2dED0C1cSAXYaI5yGai9HI?=
 =?us-ascii?Q?AnG+xgO8nsuoXtfAAyPvgPsdjO1JZvRuS5f4lI5wkI1USV1Al312/H+xZMQr?=
 =?us-ascii?Q?JgTpXSaHG6OK4zQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:42:55.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9ad7ea-460a-4a4f-7df9-08dd2e2e1d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

From: Jonathan Stroud <jonathan.stroud@amd.com>

Label all eeproms so we can open by label rather than a fixed i2c address.

Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 4 ++++
 arch/arm/dts/zynqmp-sc-revB.dts         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index 4e0587fd441a..6e2d9542012a 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -494,6 +494,7 @@
 			/* Use for storing information about SC board */
 			eeprom: eeprom@54 { /* u34 - m24128 16kB */
 				compatible = "st,24c128", "atmel,24c128";
+				label = "eeprom_cc";
 				reg = <0x54>; /* 0x5c too */
 			};
 			si570_ref_clk: clock-generator@5d { /* u32 */
@@ -509,6 +510,7 @@
 			/* and connector J212D */
 			eeprom_ebm: eeprom@52 { /* x-ebm module */
 				compatible = "st,24c128", "atmel,24c128";
+				label = "eeprom_ebm";
 				reg = <0x52>;
 			};
 		};
@@ -520,6 +522,7 @@
 			/* expected eeprom 0x50 FMC cards */
 			eeprom_fmc1: eeprom@50 {
 				compatible = "st,24c128", "atmel,24c128";
+				label = "eeprom_fmc1";
 				reg = <0x50>;
 			};
 		};
@@ -531,6 +534,7 @@
 			/* expected eeprom 0x50 FMC cards */
 			eeprom_fmc2: eeprom@50 {
 				compatible = "st,24c128", "atmel,24c128";
+				label = "eeprom_fmc2";
 				reg = <0x50>;
 			};
 		};
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index c4f70581695d..6f5856017bf3 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -175,6 +175,7 @@
 	/* Use for storing information about SC board */
 	eeprom: eeprom@54 { /* u34 - m24128 16kB */
 		compatible = "st,24c128", "atmel,24c128";
+		label = "eeprom_cc";
 		reg = <0x54>; /* & 0x5c */
 		bootph-all;
 	};
-- 
2.43.0

