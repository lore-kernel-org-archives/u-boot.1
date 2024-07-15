Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4751C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3647088835;
	Mon, 15 Jul 2024 16:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bHInnjTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D56A88842; Mon, 15 Jul 2024 16:38:40 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7764E88677
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxrwCTQudy3c8UvMe/zuzd3AvVu+m+30+AshNxRUkFzR0bt3x+4Z9cyZQC+hBTtcgwer7kazeVYgbeujfEJ1Enitt3PAhDAdnlEg6av16ShbQVgFQb2S4SmZ2FdB47DkDpxqTQJttfsUlG2olh593s7OsVhhONDd60tsqCgoT5LKBm/Bu6jgTWTw62R+w3ah8kK9yp6rlW+ZE+5KFKQHuUJNVCY4NCdgmdo+RiS55TxlNGeZ/dubHfIYV0K10z6RNA2cLQuuP2sdfts83ftdLVdAdvizXeC1uQEQYhSDRFVYtwlsPtd0vsudP8NlpsglfRM+8WmVrn3H7ketuBjbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlbppUdDh8YMaxJWTc5kC7Ez8dV9V55d5hXIr3dCpVk=;
 b=uqWDxrUGYtOoDSk9995XDUCGamYSCj61CVegf7TE4c3+d+3+bBEBe5Im+KkXl9+TvhFu1nXcvGHpY8Jff7oX+xNJctLiAouKWZ7nz4HD08hFYCovT+FCItCRY0DHr5oTYM0kJnXm5kdIdX7+bgudkY/WUmbAPi2eMWB1f08T7OlApKM5/afHojqPsQAQ0BIMl9A71/2dUb5WlBgqTpj4IkP49PXS+50Q92vCtXRAL87xeAlGczr7inQHwyh8HN0EtpbItISxrJ6kNiHmVd69HTYue0R+iYfEzhTj2+IwIMPhiNvCjy2UwSq4isZMyn4ShegqDGRxyaiNPN7L+Z7qqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlbppUdDh8YMaxJWTc5kC7Ez8dV9V55d5hXIr3dCpVk=;
 b=bHInnjTn21OPPdjm8VmE7mBor5VfWsZvUjZPRp91nu7D6DL1fdiQ2dwvXpP0v/wP3rFgHLeF3FVX7G9k4EAI5/4fGiTPjHVdtra14AWD2/L1r+C/bPlWJxCU5J6uwfklr1JSjoR59ixdBfgDAm5yl0WkHyX1Rr/0EfRqnkW4Dqs=
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:38:34 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::42) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 14:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:38:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:38:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal-net: Align node names with dt-schema
Date: Mon, 15 Jul 2024 16:38:30 +0200
Message-ID: <102d9499e9bab12f89dbf9ceaa49a11d685146b3.1721054306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VWIqb/nfyAPXpTAIMvf4zp4JDa9WbEQc3CKDMeS7Uvc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSpJunvfy/fldVq/n39zAXsSyrV2yavmma51HhCseK22
 Z6mwQ/dO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE+rczzOEK3OT+bK/k7UVm
 d56qbC5mn+en1MYwi/mqTOJmN8VZl0MvrEs7qpb9dMM6JQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6b133a-c1aa-4a03-8df9-08dca4dbce75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vpvj8k4HHSZnYQRP282It7xnatk6pIDBwnUBgJM2oLp0KfT0s4PrUTYSLNl4?=
 =?us-ascii?Q?GmBzj6OwY7NBs8w0pja96Hc7zQUy2wFPLJCpQel+4k6I8bh/GVlyAhY7ESqN?=
 =?us-ascii?Q?VC0YljSYqshYCm3DH+7hGDTkqqMKb6yhbJZwYBKHK28fOjxfe1YeXnVKWFB4?=
 =?us-ascii?Q?XwruD1aZMsvEYexcSae92kQp3KhvpiXPsxiwaEp+DmTEPHCYqhzcbsmOcoY+?=
 =?us-ascii?Q?yfnUQZBnOa71Z060txtSuX7WfXcXdU65LmHenbdc73bhnyGsQClogK+c3VeE?=
 =?us-ascii?Q?u/b3IitRLjUG0+H50CdRLfOGb8XAOB/OtaDpxHeI+R4P5g+/auk+tmOhUUb4?=
 =?us-ascii?Q?ce3S4oBd/dGXKuNVjqegs6oMm8aNF/QdEez5r+S/KuoLj6XFy0ZEL0oqQ2bp?=
 =?us-ascii?Q?Egj6d7DfSeRLMoeahPznYt0bZ6WMsENl3nuq5jmINBRbbxzdkr8DiXYiXkwE?=
 =?us-ascii?Q?sIM+VC3fRQJ/Ktkx+oazuNfLtaHkdZY2PaC2RQ0t6siRRx7VeyH28tjbjvof?=
 =?us-ascii?Q?3lBBIrHBKv4m5RruODFqx7pbZ1Ezd096XfYiMU/SgL5c0fMx9UtioRRRubPX?=
 =?us-ascii?Q?PcXAdjjwga0qJxUYj5/U1kjlLIYy9aSeMm1extmgHwJLF/uUp/rXRLcFrlQH?=
 =?us-ascii?Q?RKJWUgoma8BRPSz0eDMZdsNHKNzW/P0BeP6GhW9UjJbw5/BErypMllkPF2f2?=
 =?us-ascii?Q?uwgilIglMKeA1PUFQP0FixIaXQGOVib7OtSzw2i2qKvNUE+1zrML+Z81uzgJ?=
 =?us-ascii?Q?c8r64A+mkmsDy5yGsLjrgi0DMb/Cw+SEuNmqvAZnvTkB5C/NfGzDlxI08E1v?=
 =?us-ascii?Q?s1rMQFq7KPnO58PVVgOx3ZUN6Y3tZV14M620oUkpYzHSpFf+ECTD4uFeWvRY?=
 =?us-ascii?Q?vQiadAwTe2x9WSaj+Sn3wHotTedB2Jlz7CtaApWzTH07f/darjGTcpVpTvNN?=
 =?us-ascii?Q?1c6VYKiJEmCYZ2pzc1gaY2I19P9F8hpEZ98Cff/zfC3CGlWnwYG17auxQDfr?=
 =?us-ascii?Q?TaTirO+SZOpY3IMa2Py7fUE4Q+mnGyuZ51nk0PzaKQJPzqW+NIBpBYUKpCN5?=
 =?us-ascii?Q?FQY1Qs3AfYjxzRj80cj7C1aA7OhLkEaPHhWhI8QjbHHesQ6NwucNsyAerLTL?=
 =?us-ascii?Q?FtLDB86gRkrjBjG31kwu8O559P2UP4IGluLLLxxLB3LlrxQGNDh1wZ9SjCBP?=
 =?us-ascii?Q?d4SBbYBvRr7mvhElNy53U5Vgy/0JUbwqBKfPjoFuf68+KfSPHyeY/t25GIdP?=
 =?us-ascii?Q?Xdp1LUzfcc7UgHaLTOY3T+/a6kDVtq/E/pqwzWShi/cKgW5vE096ujyCaEx+?=
 =?us-ascii?Q?IVY1gPBcXBXFzKGSBwSl9qq0Cp0knqLsFciy77XcspdIO4HipKpLVeQ7FKfs?=
 =?us-ascii?Q?6JV2IuUDP8c0fNRSffCusujunu4425toyRlCgpeU5ebKL4iaihgQzGDjR3j1?=
 =?us-ascii?Q?4I4Jnn29G7sABzvEIqdkpRTtyIOc6YOm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:38:34.7433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6b133a-c1aa-4a03-8df9-08dca4dbce75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

dt-schema is forcing some rules for node names that's why align them with
it. Labels are not changing that's why this change is not breaking any
other board specific DTSes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-net-mini-emmc.dts  | 4 ++--
 arch/arm/dts/versal-net-mini-ospi.dtsi | 2 +-
 arch/arm/dts/versal-net-mini-qspi.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/versal-net-mini-emmc.dts b/arch/arm/dts/versal-net-mini-emmc.dts
index 8a864ba3ed3f..e200fb694c6b 100644
--- a/arch/arm/dts/versal-net-mini-emmc.dts
+++ b/arch/arm/dts/versal-net-mini-emmc.dts
@@ -42,14 +42,14 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		sdhci1: sdhci@f1050000 {
+		sdhci1: mmc@f1050000 {
 			compatible = "xlnx,versal-net-emmc";
 			status = "okay";
 			non-removable;
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index 5d188db62d92..d511b823754b 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -42,7 +42,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <0x2>;
diff --git a/arch/arm/dts/versal-net-mini-qspi.dtsi b/arch/arm/dts/versal-net-mini-qspi.dtsi
index 097b58c633b8..e29a3f36d6e4 100644
--- a/arch/arm/dts/versal-net-mini-qspi.dtsi
+++ b/arch/arm/dts/versal-net-mini-qspi.dtsi
@@ -42,7 +42,7 @@
 		bootph-all;
 	};
 
-	amba: amba {
+	amba: axi {
 		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.43.0

