Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D32C44522
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9643283B0B;
	Wed, 21 Jan 2026 13:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hTTVVQqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B766682A9E; Wed, 21 Jan 2026 06:48:14 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F749839D5
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWLTadCVtYD5ShDl938fwAMedV01n2g2ml8NA1KYxXGTsde/TaT7S3NfH69O2lE59gbQZzg/f2ghpV0TOVURKCopmIySq8Te7VEXroVErK23/oWKLHX8jY6gqo7K44/zBvRM4vzFQtynuOUb44KEh3mBfnK5ITDwu9q61YXfy08cz1RGKG23VgxkcjFqzG+dqkqyTlElSZjV9qmTuVcgL3DZGZJIzaH5weVneJPVDOOI2BaQ/0S478xGIHizwHTqT0Iahqi/UJyzEx3id5DCE7/ep/L3boZFRaYOgT/N4WqSfgUlP0ekkULt+JMLQg++YBnw4PG5xrH79ICFYerLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=AGC7bYbDQLhXzrUjEK9aFCWpkIH32nq2fZ/VgaRT6WkMNgrPksLkbzGC3ZhU6Cag92b1W298gK5r3hL2vBxWN3Vwfklmklo/I3qd1SjpFyUYLFO8qnWC8GTx32S8bQjqFNQ9OJNeRnQavRm7GVFBOxOEAG9zc9+Aty+rZv+qt1bVqf/7y4q1538AeVra8OuetfzbAPFSKWwSChRRlNppBXZdl531XWNltFQnXJ5ugzub60Qb+1flOAikUt3RJsgN8xHeVdEpzUbxp90MuvWwE6ntkZ/UP/3u/ca5/5RdQpRY7xEduKKIDj7hs5CwA3DcuQqehXPRM+KgcUHIV0kZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=hTTVVQqakIOoSuh1G4SptbJl/RaR+Cz1+kZlLiY9LKjRfvNYWRyDIk8h7bZ6Z79p/FnMP4UD4tqJFz7F/4PJahEGHQeYB49BzptMoaVnBHuRgdcD+CuPrbxTvBy1s195QqAjTIQhViGb7wgOHDJrqRlzrnPqXM097yauTvfwSwQ=
Received: from BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) by IA3PR10MB8637.namprd10.prod.outlook.com
 (2603:10b6:208:577::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:48:09 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF00016412.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:48:08 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:52 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:52 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5lpIs2472750;
 Tue, 20 Jan 2026 23:47:51 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 4/5] arm: dts: k3-am62a-binman: Configure firewall for
 ATF/OPTEE
Date: Wed, 21 Jan 2026 11:17:11 +0530
Message-ID: <20260121054712.176939-5-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA3PR10MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 3826ee0c-2690-499a-bee1-08de58b0a801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?db8WNNc6gNHdy73ubpMAEE0N9CBcrk6S8qXRFU630QyORXW4f8bjHhHO13RV?=
 =?us-ascii?Q?NypaFdHPvS0E94l7K3pIkF/uO/nQiyfmtuqyVefHUFplA0r7VmFqHBnD8x+U?=
 =?us-ascii?Q?kHshKi9GmbPN2wemQ4qAnE197tXW+unmg0yBHrDrkIHD7S/scmNoo/AFTUKh?=
 =?us-ascii?Q?p7r1+CD5AncllVBxY9lSuaUnRaULXcCvEHn5vcUCbf5avRuFXr23/liuZAWa?=
 =?us-ascii?Q?XbwTANo7gV2AQ+CPU2Bj4cgT8K6647i6fsHrvhQ4vYsG+lfZgYVuSECRHtPT?=
 =?us-ascii?Q?MH7gstHQ9IhtDrkIDH2vvcFGGU/rKl1auMByLynaWOk78j1vlL32xEoJ/z0/?=
 =?us-ascii?Q?9HWxbSAURilXtgt146dgpAR9jOVKHywus3cJHziQBkUabiujdVZGe5aD7MQo?=
 =?us-ascii?Q?LOn7Opdnsy0pChOT4fACPG0PYk3J4Z0I+3VSN7TJS7jZE98/kVEo5wCtHTKl?=
 =?us-ascii?Q?DVF1rm2HGq32PZab7QeVaax4TH77hxnLFDV8r3w7ZOXHKzWuCXiJEwFVdAj1?=
 =?us-ascii?Q?m9Sb32KFjmc1FN7ScTgm5yZCMm+ZjRGpMt568pN5+JeuyddM2hNscGXAIutb?=
 =?us-ascii?Q?bWxshTzgRyqGjp84qyMet8Es8rForNkzHL+OqiNYP1eo47ECnbM1R7g3x3On?=
 =?us-ascii?Q?CPuIwl8rKVrotfyC7WnNTFsYHN2AxOq7KFqwkzXAG5zWOQeT8yf74gRrKPU4?=
 =?us-ascii?Q?lAyupx3YX0AM5IowXbtEf33VpMeWtFhq8APz8kUU32Cf72StiT8rCrtjS2k0?=
 =?us-ascii?Q?pUPWz/xxp2NbKkGgFzfHxBO4ThRXGDKbGhHsO24UDnvG/Gn7oBTDSUTxWYzB?=
 =?us-ascii?Q?dOkpUtssNLhuPyB1qacLJkt/7OiS4tW+Uf7H52mXpyrJGfckN0LpDSKGHu27?=
 =?us-ascii?Q?pHtv2kivrfhux4Bnm6vJoOBlXhve64DytJu7vDdAsyDtNzmpDc9KFK8tWSq0?=
 =?us-ascii?Q?rrvvitHFiN5pRyrULKZhdo2pa4h0zzU1kSszuf4y0wdpoN4ZPCn/wSWsRoUt?=
 =?us-ascii?Q?DEF/j0O1MPhsy+2NCZuQI1uTlRRNKplpPe3rE72iS253v+lIsVNHl3LS6BV9?=
 =?us-ascii?Q?nC+ecOQv4E0It+RSDA3uNfFVeLmxksq76yb0/H2iqZcpNRWyBF20r5GL4hPy?=
 =?us-ascii?Q?UXTc/T7p6oNhXxj6mKygomhm5EUgsVb8AmxOE4kYFhuWj80KobTdKGzULfG+?=
 =?us-ascii?Q?MOkkGF8S2HiwMPNANM5qUOu+7ta+YF2KCXHGJ9opkG9QAeGkY1EnODl2IkaL?=
 =?us-ascii?Q?oDPf23vbmTTRZ/dT5lAhxCv3FiPGLa6CVULw8WhtTS3rDkQMioNEkaG8F9jz?=
 =?us-ascii?Q?lSmNxKracyhouJGWi4G879ROrUqo0YT79hqsbLVrlA+qz6aQho7k8Pjq+bei?=
 =?us-ascii?Q?y4DYJP5HLKHsulBCF/+z600hqQkjLFh58KWPACp8bIlKqXL6f6PqVE7swbHV?=
 =?us-ascii?Q?zyoBPV8BNn5yYhgOJ0wtTro354V/zMiWLQUD+xL8Rnym/Q96BpZpv8xwxIcY?=
 =?us-ascii?Q?W2AK9ZBVIdWOsgndhkKoBh5Az1eCt3qxYxaecRA93VOcfivCpxz4fRoWwFz0?=
 =?us-ascii?Q?Co15QQ6rXupHec32bUX611apM9ad/MSix4as9fFAgpimUd25NsD3txcKxetM?=
 =?us-ascii?Q?0wH4V4pLySoxGROX1xs/FeJpACn/yrDJsP4b48QCuRcdnf67HgIGvSIszHR3?=
 =?us-ascii?Q?2M7BFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:48:08.8137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3826ee0c-2690-499a-bee1-08de58b0a801
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8637
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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
from non-secure reads and writes in AM62A.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index cb9a56b8c37..49c90f5855c 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -200,6 +200,36 @@
 
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
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

