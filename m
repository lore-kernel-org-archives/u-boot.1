Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D9EC4450D
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3A083AE9;
	Wed, 21 Jan 2026 13:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LAX2hiy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E31682A9E; Wed, 21 Jan 2026 06:48:14 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A32983015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypPUN9Hv0CDUQsBOsygAp1IofR+OFoHNm/NwB1lQUedTazy4Q0p5gIkD1FdVNIGyTyzic47Al6YvWLpbP8nvm35fvA0vYGpC6rFKZvh8OY19H/lwXxP4fZZjzX4pe20p7gRL+pX13skIfF+kLDmGz3SLMq34ccsItvDongF1sS3cHvw/91RcfgvCB9eIy95B3moIqD2cLcupcjRpQBKS0Fv8Od5hD98qDeO9IpJMP9F2Ath0EzZ3zoUgmmV8oo6+zLm+PJqxJpaidvhyEyyIIbLl3elZCIG02sBmux83b+86mGFbP6hAIe71M+KhD6+uwObjk75+gRn2IVklfde+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYFdXbpPPG7769gN5eP+Bj33dyBqQMm0SxVgGJtGMx0=;
 b=wJUtcuObyXJ4+nU/iFjFqRZz5938a4DUNR4sMpDnROAe+SfOaE2lgdeq7PnKi4VxiD0ZdluZmg+ex9kXjroERmAKZLu4bonM111VnRC2anwxE62+LRL1uqjKw6+05cBaIGnmY52RFObO9rLe0oU+KbMuim4myXW3ge4RbUwmb1miKb11gT1fHUQNcPg6V6+Db/NTINke3wbnmKHkRIodbsVnWrKqM/OPvvOBAI+41XXpLZ+RDaSSWLVtma+MoFhi9GiaJ/wOCdWIDTsx9PvYo3Kw0aI9GEWNIRJokJIJ3c5ihk8SqRE2Mv5+7j2aQcYDTVjFj5G+4f2+S5SFzuXM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFdXbpPPG7769gN5eP+Bj33dyBqQMm0SxVgGJtGMx0=;
 b=LAX2hiy7uoM2L5ZkFvkMAJO5DI9A32+YvgHt0VJzsPoLCFAUVvpwQpOymqes59PaZysNk6Cttp7IgU/sR8TpIlLntfJ4O4Hp2th3EDZhOMo+0y6jbZZ7HcLFZ5FS9Ejbf5P0DdjTzwBVF5nFmpQpsmzaZe96DgLoWlc6+DdsQWU=
Received: from BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) by DS0PR10MB6198.namprd10.prod.outlook.com
 (2603:10b6:8:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:48:06 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF0001640C.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:48:05 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:48 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:48 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5ll7Y2472698;
 Tue, 20 Jan 2026 23:47:48 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 2/5] arm: dts: k3-am625-binman: Configure firewall for
 ATF/OPTEE
Date: Wed, 21 Jan 2026 11:17:09 +0530
Message-ID: <20260121054712.176939-3-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS0PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: f05df9b5-e60d-4a1c-03e1-08de58b0a5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jwe3OoMWt6wpGF7DEK0ZEl5c6XVvfZW0t2xn3bSXKvL3ieYm4ROljeYMiqI6?=
 =?us-ascii?Q?1R2GTXQc0eg2o+QoR+Xh1D9hzuvVwqJZ/rJuNZdN0bSUIAV0b1jYXuG0Rzeo?=
 =?us-ascii?Q?1Vt8yGaAVRrx7qLs/zzdHmajX2CmJc2ABjUi75vWDYP8s4+tDFFWIsQ61J8S?=
 =?us-ascii?Q?S/xs4+hVv3hiZP/aINCpLXlW6YN1ar0aBoelU4PcAY4cLWiwIZe9DKqp/4Im?=
 =?us-ascii?Q?7M7QonpHPM/1q7WLyooQwyvRgPt4gX9g22EcMlpORa87W7ZCFKIpNPmfh1EX?=
 =?us-ascii?Q?HbziRy4JIbmwj4brFbjVpbseOjBxXUKa6AnDygzvNz0Sm1oH/sSu+dL7Omj4?=
 =?us-ascii?Q?SH0y/DE2mX6URHKo7jusTO9/Q/jG5OyDc4V9TaFVasSbZ5lOaNWPLdWzEumS?=
 =?us-ascii?Q?H+iFW+DeN0YmJPo4tujXbvUC+//89ApDPYp7IeoPhsVF4cUP/2jttCoVR/sn?=
 =?us-ascii?Q?A7kMs/WDghB5Lop0elUHAbfNlpw6C74Lqjl37WPz7l3sb7XLRhX66lKVWNT1?=
 =?us-ascii?Q?WOQI99dscDpCt+0DcMOw6tstXglbfTMTnxowngYKkwp5nOeN938lpuyn9M0g?=
 =?us-ascii?Q?JtKr6sKFwb+Gg75Gn5eIEDb6lYKTHykUX5EL1t4FTq7Mu38ENb1uCUqOekUu?=
 =?us-ascii?Q?q6mXNBymn1kURsWiqJmWx/y4Vx/iaw3noJAWoLHO1nZg0Lx4vnl64MM8fR3P?=
 =?us-ascii?Q?bc7yjNasNjqK1JR2/w0j+cwVrYYuHnbYBJZe0Z9/sMgSfOvefoWmu97SMevA?=
 =?us-ascii?Q?GuKhkY27e18Rlqn54YVRtgwSEfgbtyWYJnfrod/zgtWnU09dtTZlkoT4aeuR?=
 =?us-ascii?Q?v0SzaAwaVVNbSc0GaFkIHv0N7vIKA1Uixlzk1Xiij9zbCBr4IYO7gq2sL7j7?=
 =?us-ascii?Q?GVn/4LjBDmnZo49gyo9Twt52kua9VAa6gq119gnuAymxlsJal+gTAZBblmHu?=
 =?us-ascii?Q?ze/1H8tNZ/JGQJ/5LfYHcnx47BDNljTi3rPlJD5sHxtL2JTlr/uMoDYByald?=
 =?us-ascii?Q?9HoH1ap9HNFNBhSDxW7/OORnXiqfoo8RRMWdXLvY8I/mnfKbUjM4tw4JT1uZ?=
 =?us-ascii?Q?l98oRnyGKDSi2t6/t9w3T4WbSZUMFjHzsED69Fhy1DY0t1T5LqIWGq0xOrRQ?=
 =?us-ascii?Q?8x1AJtYRF+oeXkt0Con3ZmBW6mMThhN+B3F+fOfekFZCx2xHcdzQ0noDyLMi?=
 =?us-ascii?Q?HVZkE8qMDH/d0V19tC1p0vQk3UWiaLZm9JRCWlrOlwvbDkVrOJosomKcEKPY?=
 =?us-ascii?Q?6R96kbgwIuNvtxrL2h945rxK9I4essltZl5QM3C/+VlyE6+9AoGZ+iP78HbD?=
 =?us-ascii?Q?czHCmuRRsWDeB2jqcx0DmZsxYU2Hfb0xGyZDX9t25Mo4Yfq/Ean65HuF8hNP?=
 =?us-ascii?Q?FZtv4BDg+XBNuEs60SP7ZoCgsSeldkU1+0IDDh6ADMZuiycLU0iS3d2OiUS/?=
 =?us-ascii?Q?17mRs51fi8Yb9+hmPtHyJXUQeZzwnFCERdMYUsIT8jaMpDdz+hVfsXD93YDy?=
 =?us-ascii?Q?stm00dNs6TETIHDeNHzD3cIV/6R0ykkvVunzxlFqSzs1PrG1LjkQPpwaH0Hb?=
 =?us-ascii?Q?I/zkVYxYj7pLwTZcJDmEOmVE1C6zJ6h2j1gZ2Fe5iMjWX9THsKA179Ql9nB+?=
 =?us-ascii?Q?0mnDsZTGz3QG+4rrB11RGY0fnimKrmVn/U7RLu7Z7+E9MfWgd/55Yu+tOcg6?=
 =?us-ascii?Q?oxbbwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:48:05.3319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05df9b5-e60d-4a1c-03e1-08de58b0a5ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
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
from non-secure reads and writes in AM62x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 42edb35fa7b..8d6015e44a9 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -275,6 +275,35 @@
 
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
 
 				tifsstub-hs {
 					description = "TIFSSTUB";
-- 
2.34.1

