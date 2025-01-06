Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FFAE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8F380137;
	Mon,  6 Jan 2025 09:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NwfFhgnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236EC801DE; Mon,  6 Jan 2025 09:42:40 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E438007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1L6kIbN+TrReRhVXbQ8JKP3YMv8SVD+vlYSXLeIrIS8WR58toVdigEFF2UhY1Lal32z84TycBsiSpChuBuWIdlhIsrL86/CXzNkitsyK1aSLAwrMHi+KyFjz0j+ezeCTM1m6VZRUDaslIvPedg2Ty9rgSTBPQjEx4GwhyDibqlno3cE927UxlcU5F2R4CFJriHgufelxc7E9Xmg9NgR5TXwXj9eKf5m8E1cBVwPX1jtoK/Q+W/jEXTx3SfcVIT8yX5tTZFF+dmMjU/1R37R9ePrZyRztnaj1tuVUuuhaionGwwF4VII1k221kOFGfu3dl/IJZOhdcptip9M/VQxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbWoqtzeZGaetd/aRZyF13Cm8MAQN1StUuWD9anFoYw=;
 b=gn+HQsqYSz0+w50LHibUOaIQ4K+gXAaC9WtPMdHIGd61ZgRgzAya/z2j2z/ZTp7q3/dD5Vi1dfCLgAdeOA29TKZset52OGC2eq237qVNZFlRsdpvA707a4NoCJNN0uk030M4xCIlTvmJ+8/OVLFk4e4bVSwwieeEd7eBQS2OK9yy8N2Opi6kTjZPPu8RO0mrGysBYaypLzFF/GtBacDmqEh6pv/1e2K8L8Y0aPY/znres/GHilw5SifcAURY+Gfd/RPR4lVd6D2M2sN4TiJsyUvtZs1uI0SdknMLDeNpDCVONBq6adsWaQiZOtI85HpG5Bx5Htc10zM89VmisDBZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbWoqtzeZGaetd/aRZyF13Cm8MAQN1StUuWD9anFoYw=;
 b=NwfFhgnbyn50td+APysB34qnxCjHnvhD/sgD+UgO/aResnuVlV9YKcWeDnSJGxyyaHkJ1C8r4TjmaojRUYfcFmOWRAjFCHLvHbsaTvDlwHdRLfMzNRu2FY6mUXKEQBJt/NYmF256ow/C7p4gDSW2QWsh8XdHSonqlKAJc7t0SUE=
Received: from DM6PR14CA0069.namprd14.prod.outlook.com (2603:10b6:5:18f::46)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:42:30 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::7f) by DM6PR14CA0069.outlook.office365.com
 (2603:10b6:5:18f::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 08:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 08:42:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 02:42:26 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Paul Alvin <alvin.paulp@amd.com>, "Srinivas
 Goud" <srinivas.goud@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>, Vishal Patel <vishal.patel@amd.com>
Subject: [PATCH] arm64: zynqmp: Enable iio-hwmon description only for SOM
Date: Mon, 6 Jan 2025 09:42:21 +0100
Message-ID: <08ee4ce2fe242905dd99cea2b87373b57d8fea91.1736152939.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=uc9XVd9+zh8p1nRaujOwpjS79vSFe1JsSbxzyZv/Z8U=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTq6flSPnuMFH781lureK1xdorXchvBXdbtS16eDf/S4
 i/sYKjTEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACay+SXDgomM76eKM275orG1
 7uAH7mytAzeqnzHMM0/+q+Mv1BBYwBqp/vDbd87Fy7etBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ad1045-288d-4f2b-425a-08dd2e2e0e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mia7QidA/Ln57drtL1Ae4e8TUgO1LHG9ItMQCMWf+HoX79oYTMtB8IKpIdY7?=
 =?us-ascii?Q?45O9gRRxoxRFgUy5QvKshp/bgiHy7G+p/A8v+Z7hhUfTsvEGNxeKUKaw7nNv?=
 =?us-ascii?Q?9+z7+EkI2uREnAMF1bt6MBBK6WYjk34BjhY0WAUWP36fSH5BHRXjfUX6sjM2?=
 =?us-ascii?Q?tSGoSzRKkNU8OsEg/7zFzlXFXVLyJ1I1sHQlcxUvtRMlHIGyp42xfapYy8WO?=
 =?us-ascii?Q?f59VQnvxm/Crq7u11sfvLz2qmqsNBrz4biG4I+tQsTAOEzHguzN+8RfNgdZj?=
 =?us-ascii?Q?LJLsI5+XZyUEtyIWrFDjfT4W95Bkuo/5KQgACr39PHr9Vn/Xw7xOFueKJG7a?=
 =?us-ascii?Q?IjzwAYaHOFHpj10bv5Wi7rkQZGPrwvPuf2lLeEaaqkZiJb/oZHqtRt8y98fW?=
 =?us-ascii?Q?k5kqTE2aymLAKPwub8DP0VdoZeD18D98gnbfwMG0bD9vRl0yN2rA/4lsnrw6?=
 =?us-ascii?Q?MOi+h81qD3f6D5MSH0dadOxDfiasTMZryzu+//Px3HhV0JQ+azStLPAZvFgU?=
 =?us-ascii?Q?6iVmoHrX0Ej8I1iNLCLcAwAYpIwvTcXI1CH7jOu8n2dJo4K+uP9u82Wnls5M?=
 =?us-ascii?Q?dmXfA0ZO9RRX31T+5qDEIAcsx/Jsqk48ZWsMFEPu3y9VQo+vT3khQZgkHEcI?=
 =?us-ascii?Q?8ZScioEf+PtxCP630WmswSZ3jl9dOPtRN/SgKhvbPYYXwJg+mx2e1VxV+D++?=
 =?us-ascii?Q?0POrXgz87EfwrzbO8bEIhsBn6LPvJC/kMJmIkwqe14BpStqWdku60sKRXH7H?=
 =?us-ascii?Q?WlRUpiOEdId12gN2+6Gw69RUJMtRgVgDCbBzc2TN//rRKhApegupMnfoe3OV?=
 =?us-ascii?Q?I5CeI2ASHFSBnvVqUQBEjW5g5OT7I7FiCsgLmDYICUm7Ok7CqOqN/2L6Papq?=
 =?us-ascii?Q?ZWiMbr/o+7X9V+PN3Cil3KOcaTYe2m1+XiopxQtJSfU18McECxK+0kxUzTsX?=
 =?us-ascii?Q?HPzwQiH5mGhSef5PEcrv4BjW+lKGdzomrUCFQPJ6vpSHBW0JsEbtSf0gWbvR?=
 =?us-ascii?Q?8sfLtzvTMgXIlzr4dO768QA3pcgcaocTl4A94nSbimO8OVz4k7ZYbxVTQsSn?=
 =?us-ascii?Q?6UE7HGgWzSe9nLI8ZixNyjNvee8Y3nAPz42n8MKeWhj5btzVAEbzMy7D+n+s?=
 =?us-ascii?Q?tE++1+oKn98m4+wqncBeVsUGb/su5xVlioYhNu3m2lQ9Y2uHWPOKiUVSRIVY?=
 =?us-ascii?Q?yct+Tlbyo6oB2y2qDxeneTFGSHqt0CHePF3kzvce5wPlbpu4Tm6WXD/RvnND?=
 =?us-ascii?Q?KfBnm3dOFwkrAwz3JqFNv9d/zTqCI7y2evA1Hg3ARp02RQWFEm4emLdbppkc?=
 =?us-ascii?Q?67+D20IJxJ4ZMUvhQvg0C+hrnSe2mUUxIYEt9ga4noMqWoqYACdzHZZWtXvX?=
 =?us-ascii?Q?sEhnHtmvysLEDpk3cuYUdgognGBMIfBgFgQYHorwZRB/lIkJaWd+oYRLyNQd?=
 =?us-ascii?Q?fv2CUb2VhA4W2gttZEkUzKhRL/pi0z3DU7doyerf3icLq6LEdl1vLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:42:30.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ad1045-288d-4f2b-425a-08dd2e2e0e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Description is coming from SOM only that's why enable it only on SOM.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 4 ++++
 arch/arm/dts/zynqmp.dtsi            | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index b514dc27f710..70acd3eb88b8 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -97,6 +97,10 @@
 	};
 };
 
+&ams {
+	status = "okay";
+};
+
 &modepin_gpio {
 	label = "modepin";
 };
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index e8750b08162d..0e0436ecce82 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -393,8 +393,9 @@
 		};
 	};
 
-	ams {
+	ams: ams {
 		compatible = "iio-hwmon";
+		status = "disabled";
 		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
 			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
 			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
-- 
2.43.0

