Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42011D2503F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C25483B0B;
	Mon, 12 Jan 2026 08:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzVpc17f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD23C83C01; Mon, 12 Jan 2026 08:21:50 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE615839A8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVeuneqz2fhpKag++KQX7drXWL26ekBveI445k222+ZwDzokQ6Sw5fWj+tJ/E3LgTkogSJUWTw1FXYzoxas6V4I+CWVT6UpBfFJoB3tBsbxWSYGJOj0KF2+K4UVZmaaUSXmDYY5eOpd3rX7EJv1Mts1uazJ9wvyYiM6Svui6bfnsNiaGu6oN0vbzM/W5qI06LrnLTNG/DS4x/c3GrMoJ6Md4mt4dL6GYXHdUB/+xe240Thr7svcWXj0P6z9DHQlr0CzeQ8OUV2LD856mp9ln1ICMzCoQxk/guxx/xRPhkSJ8fewv2SOWB27CLy1zq2EOzXlkla732sNS6iO1dsESWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RpGIdg/Yxy6fnBHp+RUX1B4gALKs84sGdr/aw0FOjI=;
 b=haJ5YH6p0csLZZrmo2rjXJkewpU0LyckSt1oSQu05Nwcvuf0htywI635JVKK0Kh1gsVdW9ODz9Dz5v3xuW1QN4FB5UhMPRwaMp+27wXoKNHDcm2Odymk3eLY/EETPUiJAHkDhptVtUkmmWdVG28PGv2Nzo7k5n44HPVAfWNjJrcUQ6jLbLNXXwhteOmqz1BJ6igim5uGrWPfSRqEZW/vXnaZl+HOxeGg1giBWGEwmTrfsjuFoeWLoDSrCj61YlAr+BtM05DpfNVYd7dLEebzWDkhpPuyeC/LvsczDs+hLdRo4LiWJyhOBsSQn7qQRrtSpkFly3RNT/mR6XBZngawQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RpGIdg/Yxy6fnBHp+RUX1B4gALKs84sGdr/aw0FOjI=;
 b=fzVpc17fSUx8DqyIG9tE0qxjfZsU6fSxL9mxQ2j4TI4QwUfUFZEpIa+oh0gJyrmA+I/hvFiNPZXd1N0MeISe1LIz9KggvTDk894WKytxHZKPvSCABxPIx7KSSELg0qdo9Na/eN8BH5mJNGj6rIJNnqb+qSR4QtUWmjBvTSUugUc=
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:21:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::a1) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 07:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 07:21:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 01:21:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 11 Jan
 2026 23:21:42 -0800
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 01:21:41 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jay.buddhabhatti@amd.com>,
 <arun.balaji.kannan@amd.com>, <senthilnathan.thangaraj@amd.com>,
 <micheal.saleab@amd.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v1 1/1] arch: dts: zynqmp: align cpu_opp_table with linux
Date: Mon, 12 Jan 2026 07:21:39 +0000
Message-ID: <20260112072139.2709127-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de11c7f-e25a-488c-08a3-08de51ab3c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jC+biafe5oJ+1ZbFAKcwg0ihpftYwvip1/DgcuWTbC84X19tEN7ykaIxZfIy?=
 =?us-ascii?Q?yEHUs1DkBOeW0Wfk9JGyNWRhDZThH6lxKOLcRTLD+r5viYHk1eH5ywYRZngO?=
 =?us-ascii?Q?iT+eHJK8rtJeyvncqRnLv96crW9eWovb5+9spIl2ZrUPT0qPo6LtOEHR4ZsM?=
 =?us-ascii?Q?fxRoh5nBLfgu/84YVLYtwqABYbL6alabKslbdZ+7iJ4W8bdb+dxcMJrgQ65A?=
 =?us-ascii?Q?12R7hy/7eiRMjvULWpPxCCG45K5wKuZdrBbouMG9IkYCMB6YOsnY8Ch4fBB8?=
 =?us-ascii?Q?pAMwM31mEahOVNHoF+2ZCPJn9kPZ8+ihfM2HP3kbyCXjxTSvKy5uUyHnOe2S?=
 =?us-ascii?Q?MZgMpdUFS3PMwULOkDXEAMz/8rxt9KnvrW+W7aOJLgCiscAZzqkMGiqmdNFo?=
 =?us-ascii?Q?CxiH24iAWcTjBRPJbPmbHtusq5kREN6A87tsRZQU8ImNrEtiC7ivG+9yy/Mp?=
 =?us-ascii?Q?TMY7xJzTP+BdncX6Dd1RPpMugUfP9UM9m13TsCOYlAJqzJ0JXNejnXYFbRjH?=
 =?us-ascii?Q?HDwkUcVqkEcPZ1zwSQsmPPpa905N6vigoyvdXiSj66uw3CMOKNata9ukVVh9?=
 =?us-ascii?Q?kVj/CSqyCUEbbvvYmKBstbZ0Ug/kNRwEXIuTTg5UA/Yo8uY3+91z364pYuDm?=
 =?us-ascii?Q?iODUB96Wy9yQL2g1Pwwubxlj7vAV6vrrQuky9HejAMC/4p8ifZTnnN+L77Y5?=
 =?us-ascii?Q?qFWPA1jfAQPc7JmuhIWh6FglrAIriwfqKKYmK3H0V6I2xgl6zP0pxcsg+ysq?=
 =?us-ascii?Q?/gwjSuzbR54IYkkSwnudMBEehKm294pNruff8ooNvtncbiGCdlUYMJArCJWD?=
 =?us-ascii?Q?K6k4zl3bAail6nz4SJ/il9Vj/bTPmM/ThPbozt4MkP3/HifQUGM/JKVL6xrD?=
 =?us-ascii?Q?1VdPyWHZWr1xOE+gTZTn05SY17leud9YQCb9RI5YAxosg8NOscn39eo5uRqW?=
 =?us-ascii?Q?nc0ofmIXYRr+Apug1I8IkHADMlM6BtTIr6E8G6hk3lgS8wP637iQcIQ4OKI3?=
 =?us-ascii?Q?GrOJB8+oy+wk0+cADKQwJzPKULahzVzEjUfE3O6M4ssMZ0L+87B3z2/WviZX?=
 =?us-ascii?Q?TxXHkBTcQhQ6RNSnBmcs3oyMXg7E6YJg78cVUe9YQtkNDA/r0WMUjlHbIMeA?=
 =?us-ascii?Q?d0O5xwD1X8/PfZAKWH19+lPaL9uU12AbXuTWHBFr8Whgo3cqKy0AGPQ5a9Os?=
 =?us-ascii?Q?mTAGSCDyXZVyG4N/iI9DlRHh6vRmPQW15qWeDFUn+e9UG+1bRQr2FypNl6fa?=
 =?us-ascii?Q?NuaFtd6kj0GFJqdY5B+CJukS1yzvV2klc48GIpxRrVYEEsyt4475s4r/MBBZ?=
 =?us-ascii?Q?nkrXkUjEGgjqcpDSDM0RcNNBW9p/TCJffQLYBJdwx0cQnDfYg2bOLkQGevUU?=
 =?us-ascii?Q?BzfeK0bhO1BhuWyW9UfXspfDYY8jPBShBf0NHRj5Z9L1b/XKLPyaiGTH74eN?=
 =?us-ascii?Q?vX/fa1RTSF7JSeW6rwmvqDaet8u3AoR54HTOZuAUGReT9LvgY9Tngob4MboJ?=
 =?us-ascii?Q?TgfXJcUbMFUvuqMeeGngSGT7SmjJ1ZW5Dx6oh4tliCZS1a3cjdSRtbH4zi6m?=
 =?us-ascii?Q?x3z5diYinHxjceqomCo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:21:42.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de11c7f-e25a-488c-08a3-08de51ab3c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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

Align the cpp_opp_table and pss_ref_clk values with Linux according to the
following patch submission:
https://lists.openwall.net/linux-kernel/2025/11/11/424

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 arch/arm/dts/zynqmp-clk-ccf.dtsi |  2 +-
 arch/arm/dts/zynqmp.dtsi         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 52e122fc7c9..482f432ba7f 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -14,7 +14,7 @@
 		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <33333333>;
+		clock-frequency = <33333000>;
 		clock-output-names = "pss_ref_clk";
 	};
 
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 02e1c4615c7..13cfca66657 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -103,23 +103,23 @@
 	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
-		opp00 {
-			opp-hz = /bits/ 64 <1199999988>;
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp01 {
-			opp-hz = /bits/ 64 <599999994>;
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp02 {
-			opp-hz = /bits/ 64 <399999996>;
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-		opp03 {
-			opp-hz = /bits/ 64 <299999997>;
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <500000>;
 		};
-- 
2.25.1

