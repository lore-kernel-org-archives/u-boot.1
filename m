Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A98C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E05E801F5;
	Tue, 21 Jan 2025 14:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukVjTPRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7133C80326; Tue, 21 Jan 2025 14:42:06 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF35801CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMzP3XN0mDbII4odbjl7QG8whRwxK8eWTes01HcBCxNXZ1KTxNxpoke6NAegoyF94RyQlEMJkS2UVWVRB8Nzs4enqkwncjqvQmgCoKPMR6PYKgpJeAZYZVXaVOTuASK+Th+S+zz1FvMfbctQz05GuJ19SJBv3BcyjRoqIAXx4AhWBckyIypzHceDWxOaCoKDHi7zFX1w6Y2c7Nbc9kYImmOF1BF8LjjYAl65TFeHdEjEFR2/Zzb5oiRpP/KEG03CNk62f0wJ7zQjQ+bM/o6Z/8GoMx1P5wYcHKdEoW0glzK5o5/q79rzKcUNdYtCooZpMxSIIj5wTwPaYRQT7t9aKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnXRXP/it27t4D3k94WYeSB9q+h6zWYic/QFomYpa4w=;
 b=x4whgwTuEp9O6nPXGbg38dIFykb9tOuRQvZZlcMDAbgJ1PEEWElOucPDNhDXU4UeIq9UWC/nyINO+XRI2LiGNzXlOVo2hrrJDZ2P1Oz9H+C9XfPbjBvdX02U3mQUP82mxCzMCAMAxzxB1yaw5cJWuPjvWrDYNCrb3U4kw9AftEdeKPt882lDH4k7fRYC5URjViWZjbmAB7Cf784uCsdqhw7EAoWpdruxdfJSumSPLtV1scsWJloD9l+yvt+vLkyJ3Tv2jJFSciaqJN6SkX/6f5e/VfF/IidL4jVxSQEWcnB9/qsNOpZBcJedczl5En3leb77wRPF4NCuO2Zhv54DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnXRXP/it27t4D3k94WYeSB9q+h6zWYic/QFomYpa4w=;
 b=ukVjTPRNk5C9fZyS2wS3rN68ugF+oAaDbO/deUWnLznFBcdqXThHD/P0O/MPrYRmFsJE1MWMQkTbooQ85fa4Sy5WkaGPlsA7oXrE9U/TuAFl3o8MXG80u7dFNvXQEYiJ5nlVImpCyzTrkZQncJlnD5MmGHpGtJIhXeHOUZQ5Oqk=
Received: from MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) by
 PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:42:00 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::24) by MW2PR16CA0028.outlook.office365.com
 (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Tue,
 21 Jan 2025 13:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:41:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:41:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, Vishal Sagar
 <vishal.sagar@amd.com>
Subject: [PATCH] arm64: zynqmp: Describe ethernet controllers via aliases on
 SOM
Date: Tue, 21 Jan 2025 14:41:49 +0100
Message-ID: <6d360e71a0530d201578e27a6997dbd472772e39.1737466907.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UYnzbJibf5OE0Ea2jni7XMKkJl4qA9YKxEvOhQb5nf8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvT+JQq9qY9Fn+9mfOeQKVukkP7IWHDT/S+sk4ocJ0lEu
 OecZj7XEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYy8xPDXMFjlw//l5r97MR6
 p0/fc5Mumc1lq2KYwztlj0mh9dpn/6tlLJjzHx/TfjMvEQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 79992109-1173-4bc5-b517-08dd3a216124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KEOYWIWJYCW9N9Ty2whQHgF1ltmu5fxBznX8osa6erGHyk3ewarVaybBc1Cp?=
 =?us-ascii?Q?v6y9vFbI620B8KmC3cyJ0OGzp81y7hElzXfo/IzcbKcgVmcFliidwuHA74pG?=
 =?us-ascii?Q?m3szHNYVG5TAstAujcRABI4YkFi1J8cAhc3coUjoECITF6OYcfW1fscG+mgO?=
 =?us-ascii?Q?P2NhOgvJk0HMjB35iRwaWEk7SW3Gc1QY/mFEUupRhcC8QKxl63dMVolyVvI+?=
 =?us-ascii?Q?9MMRy5MDnLhbLuy5IHpbD/lzlMRTu6DG7WhVzksLEzluqPuKU77fNY7ItRHr?=
 =?us-ascii?Q?wLzWulZAkk+9r5HB3vCebwlJ7ZKLT7NHWiB/TJMyHMPOZvnM/58pZIzuT3M0?=
 =?us-ascii?Q?IbPPQXhddSoFgyhZGATpn8YrO8GacYoutGzt/hnoODPCldhVkoeCvqjK5cHG?=
 =?us-ascii?Q?H0S9E1mpV6ipyny/e3tQI+231f1oFlG8jRAfAa2HgbUxeMXtLRfupKMg599i?=
 =?us-ascii?Q?4QmDng+eooSzbB1BaYCT8jIRscRSMknVOYK/eNIAUPWXRfb5mdQTcQ0Wirur?=
 =?us-ascii?Q?3T0KJHJkL0F4TqBgUb7A9xq5n7U2iYGJRWhYUEO7IJ1o+mQSp2W58JqjTmV3?=
 =?us-ascii?Q?Yyzi/3PKRqWnT+/tJFE4mNFpPMDA7wHXqfw907Yma30pewMV5LEgjpZuf23I?=
 =?us-ascii?Q?w2BwXZczebrfzUmTVXtjozJJSkr4BbyDhz5OP6qsHCPEbt64/MkXaOyjy/fr?=
 =?us-ascii?Q?16urmmCmihmfiyPWmJOt0Kza6RTpMokm8kgAazJHoVsQlVbTIjzw+3rxdfG/?=
 =?us-ascii?Q?l4sX11FTqJhhRwQxY/up+Z6gq+eTWBS3Fv01ZO4G9HvfEC4frwYB+1wh9o4d?=
 =?us-ascii?Q?F5CyD+a04lcT3UaUL6YAfy+rIsv9ObUtxb2RvN3nt/unbXDXKg1AfiJlhR5/?=
 =?us-ascii?Q?vYXpwj3e1y0+B3poBD9zv2Zh+NQDdPaMta2860LQ3ZiTZ9wAhcLqQJQkz5um?=
 =?us-ascii?Q?kbWkd14aNqtMn+pYVwNMmYTbxM2MQgI8+zsORsrB/x1QfgLBgaloT6Vfv/sl?=
 =?us-ascii?Q?Ygb525GEsh6w/wxett43UZ671JqIed6kh24qZnAQMAfnoPKAPxKZoqjJHula?=
 =?us-ascii?Q?XoDFF+BpuPHLutsg8CRqEkbojZfuilk2h1VrdNWGtoKvq6H40u8Qo71prNom?=
 =?us-ascii?Q?USvPtogFvL0liLIojL0cim8Cid7Xdhe6gg6jGyVnEAu0IPnjSvbAUOkQBenw?=
 =?us-ascii?Q?USXHh6wq31AKAuY81KCFB/j8T1dAvUkaw2qqujjfWErycyCkWVF3RHAO+QU5?=
 =?us-ascii?Q?x9sunLw3oHp+NBOn4+ciNEMiyPHcLsqaapItbZWFudHYPO/k4kspQTTEiyt5?=
 =?us-ascii?Q?J897eLbAGq9arD3cEABgC+80cC2enJgURvHUbJqEfwpZZ7NOKvcRRY6hyh+2?=
 =?us-ascii?Q?cr82swasTzblpDfzTS5ASdxBnDjx6FfH1pil1b6+jHr1fpz+/PURa26r12tp?=
 =?us-ascii?Q?f7EykMEiW0l+KWDlnW74damBnqUxgnRtDuzXs0IJjmwkPoL/zCissg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:41:59.2730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79992109-1173-4bc5-b517-08dd3a216124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

Add ethernet aliases to CC (Carrier card) description to create a
connection which is used by fdt_fixup_ethernet() for updating
local-mac-address in DT.
On Kria SOM MAC address is read from i2c eeprom at start and based on it
environment variables are created. Without creating aliases U-Boot is not
able to inject local-mac-address DT property and OS won't get the same MAC
address unless another i2c read is happening in OS.
Also aliases are using string not phandle that's why full path has to be
provided but that shouldn't be a big issue because location of ethernet
controller is fixed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 4 ++++
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 5 +++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 4 ++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index d56e863ce1c5..02be5e1e8686 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -22,6 +22,10 @@
 		     "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
 	model = "ZynqMP KD240 revA/B/1";
 
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
+	};
+
 	ina260-u3 {
 		compatible = "iio-hwmon";
 		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 9d0c0c2885df..fbacfa984d76 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -20,6 +20,11 @@
 		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
 	model = "ZynqMP KR260 revA";
 
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0b0000"; /* &gem0 */
+		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
+	};
+
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index a98a888d1385..3c36eb52e968 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -28,6 +28,10 @@
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revA";
 
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
+	};
+
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 7490efea98bd..078d98e8ff34 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -23,6 +23,10 @@
 		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
 	model = "ZynqMP KV260 revB";
 
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
+	};
+
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-- 
2.43.0

