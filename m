Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C15D2F032
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC5084090;
	Tue, 27 Jan 2026 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f32+SlaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D8B83F9D; Tue, 27 Jan 2026 09:17:48 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F97683FC5
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzsbqaWonVIIXyuh0kHZTDplf2KuIINtfrc+Cu71ccFHBpOeyIx2+Gwt9rL5TAchlvl/8YJUzsnoTLvp3Y6fgBVoLtFo7bvqbRVFUhy5QTqWAqNr4LWWVGRp/tuGs0NLaRVgrwooae/z1BwZiOV62/GYt+edmsc5avcYxwMxkOTZk6CNiCLeulnvywj5XyzMdPvfblTsuzC7jmA74ixxKaNA1RvWiE0x/PznjQVNUYqlAfYYB+pjzxWVeDUtewD8xB5ChNp3L35ySGXzZLyvJzTNQHE5liFjfMIRa04pSZHwLfwvimWFIwjt6DL8xlY45O35RSIj8qb4Ra3AWmiAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MVD4nwRLio1XEuNjljKyZiLa+MXPia0xN7HLfLotdo=;
 b=CLCvLs+JeX4VefD07KvUwQbHxasPObvlnLFJUaFAHieTp4/jagYMpQIFJuhirvSY6Ks09TBuPqm1k88PdsM2HYyz3dB4e+r7E9YRFb8q1VyLJmEjCVZBcqKA6pXfpzM0HuaQAnBJ07o5/EV7AGpnqXxk6EAHBTYkqZiQRmisfzFCNv3qQ+yDJSFdaI3i9mUpiGb2w2hS5zc5Iva+xCcJpGOqRrlHZs2s6yYSc2epR0u4hC5cF6G2AxPhOY5m6q+Ecqrz6W+4L/OJC8BnSXTXu9QlbcWz+p6EchOVQctlc3mqUdQD4Sl9Poy6OvjDYdGLJk8vpcXQ4Fb2xypfADAwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MVD4nwRLio1XEuNjljKyZiLa+MXPia0xN7HLfLotdo=;
 b=f32+SlaE1g5VRzNT9Z8FpiMOFIFWUOjlYMPOltIQRFwdsHsJzNCh8jY2TPOD48ubyy7vEn51mO0r4cBV1YAtH0sEMNR7Z7C20GI7xkz+x14VxZXKymYalZX6bw9gK/6fQMEz/iM8TY4HvSy48HRUJgXKnKyaELzDeG3/vro9AV0=
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by DM6PR10MB4268.namprd10.prod.outlook.com (2603:10b6:5:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:17:42 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::f2) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:41 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:38 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:38 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8Hb2O4030066;
 Tue, 27 Jan 2026 02:17:37 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 06/10] arm: dts: k3-am62p5-verdin-binman: Configure
 firewall for ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:48 +0530
Message-ID: <20260127081652.506357-7-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DM6PR10MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a73c65-9e9d-40f2-7f7b-08de5d7c8ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fSxQ2Hzmc1uo9PE2lD1roe/mRGUSxQruaG9RgXMTMdQg6dCPcaXPJ3z4c0r4?=
 =?us-ascii?Q?rQRTP0zgGHeLVhDo7OaBWF5jPUeBPP7/aGlslVDB2aZOplH7VTyO7ZQoxu9v?=
 =?us-ascii?Q?jK99g2ROFn7LGrT8dg9ZYH4K95pRiLov0Lm/s3VTD2bqoVni2A7hAZ1mcsBl?=
 =?us-ascii?Q?NHoCcIWx34mm7bLAu9xWkyyjWwHVRDLB3daNivwISBWUe6nZEs1Gl+4FgLTg?=
 =?us-ascii?Q?xZOxhTLvSBQGvk7UYR9RwcxfC0x1Jq4WXU7OFNoI1+N5dPYVAukH0gFnptnq?=
 =?us-ascii?Q?Q3gSU9h1ix1weUYZuM+kj6iSmDUR5B9vGQ31SyLKnX9Ah0EgVU/g9rhitnfI?=
 =?us-ascii?Q?AJNSa6UpG1CLGix3ZAJ2A/BMD9Csnqp4Yrm4D4fGtrzQT2uVjgGORe2lyt58?=
 =?us-ascii?Q?L2AVRhIK46HvpZIQhWEtZlExRA/KOkJY3k8k8HIa50T48rIVIF5w/cv8VptB?=
 =?us-ascii?Q?lPwV+ErXw9lN3zD5ca/SVoscI8lpIYjlGezzMtx8JuHDTbsIoVpZLUuxgwVL?=
 =?us-ascii?Q?k5Pa7dhY7IpMq58Lp83DB3hRmcTCF7I9xZbxi2SeWSKlQiMFxIoV6hYsZto7?=
 =?us-ascii?Q?EGj1fE5yVb7q8KLLyz09JPyfD3OosrHdOvBAAXSNie+MgtmLX8tiT347Iyt9?=
 =?us-ascii?Q?DpKMikT11hVLVwMpwXeers1eYAO4TOxH1rGt5xt3AnCBJOTyRtO53Es+dANF?=
 =?us-ascii?Q?b3kyC3qd5vqTPGIjPkNDZGYIWmN/63bfiOJfe19PM5RyHLXhP3zTyKAFEVsf?=
 =?us-ascii?Q?HIQdzo3+5mJoS8Ii1CgcpWf/s1wp0yUknVrcDmOwwqTEysuM1eooBEMecWRZ?=
 =?us-ascii?Q?FFl/qgxEQIYf/OMys5kehaVH4RCjAu66povmXvwVoe6J3jGJAJO1NwyUM7TT?=
 =?us-ascii?Q?K7E4FLDIEJj9dDoTlcIzH4Z8U3aFEy+ZU6ikU6k2bwXFrdEFxao1GR4Zo2/y?=
 =?us-ascii?Q?hauI/iR53VdzPTcT4kCmEFVPgrPCi9iajc2YZycm4WdeLND7h86NPWB4FPdZ?=
 =?us-ascii?Q?QASyaV9u8Vb8WTGXeeD75wdEZnAWneqwPMsuLLrv28V1Gu8xlohfIKOkMeL8?=
 =?us-ascii?Q?tqqkrTUrm00duD1PCK/r04mnJrPRrlvYG2ybq9/leC8w19N7z0RKzQwcG2OF?=
 =?us-ascii?Q?NWUO2gYzCa2+OPBAmsVqFu6LjabkakGcsgVvI9zYlsMTgb8FoHSKIfIfCQVA?=
 =?us-ascii?Q?4k4pbkbxmusfmZfyH1IycouZ+Oq9ExAXieJmT4/1qYTIkOL8pahND/5L2J5w?=
 =?us-ascii?Q?W8u5HyN7M8WEvFcAjU6IYR9bbhQg4O2ci7vi70SwLxpUtZT3oqNTdwtl7HRx?=
 =?us-ascii?Q?kWZIUMdBgSaGFtweOPFsam37tXlN+GxSc4lkVP0DMSg6fpkJf0y/wyIa58Qf?=
 =?us-ascii?Q?OTON3M056K92BC/rh7nU9Cn9JE/UHEMY5QIpGW02vGWBMNOH/Hfxd8qxckZC?=
 =?us-ascii?Q?ob7ykgvrNOK/jBS7atSFrzUNbgpx6jGywNvtZY3uwGaclpnTSaMPZhTidj2p?=
 =?us-ascii?Q?xlo+bchMO7L+4SO0suc5qyPSmhBcWCqxldrP63DOsSBbSWpZzFfXZKBmIAeU?=
 =?us-ascii?Q?jRRv9xvaLeq5TekbTH5woEDwh81P+DW3S5WInPu23AhQwbS0fNRyiz/h+nyC?=
 =?us-ascii?Q?QGurN9KBhUJAir2X5h7mNJjHslrg7J3SETsV8OKm3LaVbUziGXGynC/iZYLH?=
 =?us-ascii?Q?ysR37w=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:41.8668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a73c65-9e9d-40f2-7f7b-08de5d7c8ad8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure read's and write's in Verdin AM62P board.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 .../dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
index 57ce3c0b41c..b46e871ef8a 100644
--- a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
@@ -159,6 +159,38 @@
 
 		fit {
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

