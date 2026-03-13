Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D932C105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FAA8433B;
	Fri, 13 Mar 2026 14:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eaIuxgXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646EC84358; Fri, 13 Mar 2026 14:59:51 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CAC84307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtYwK+J/11LThVuiw2+dFXI857jCxcTg5AVj8wD6HLCqdGuHW0cpkDCIecM4vFuVrPTpAkyYkrZgPd7g37q860TggjB5H9zi5Cy2bFY3ZOaBuCEoUyTvBCsyn4N7tyNp/iqFhxZyXuBCKrAmuuqF+ySsmdHyHkzrDEwKcykWAm8YIysNnb6TY2jjyCmdFXKIX3ydto6RUpoCVGBrj8kvKRX7b0gypCOyb5p9Xs1L/RANFTxrEFFk393nbXp6v/896j/s7ozTl3k3O2kdB31y67FBBUhJPIXQcj2r15HVsPXK/TkzbI7bhavh6S7xUy+0zgw0vcZl5Je/hjA6Vv5G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDKLCDHjycMzN1F4gktPQgWBVAS6UH/y4sA/XXy9wq4=;
 b=FKVSmMMB/HhaU1fVXg+0D2g107iCeHsxA8W+4S/q9pRkdgAFXbWKdrWomW4TfKiUzMtosB1wJ/M2Nbv2QWVik1bMWg0s+KlQFfojlNQVKObesla4mEZ76/j5a90dzQlvHuREN7gH76kECOb9qSNL4lg0qZShEFqLRA6lAVobKJYjvoPEJUFii6JpzmKdfX8yjv8uddK3KLPrFuWi58Xa/gGkmuEbD15zN0eweEBom9sYlpIiIIscD8U8gmPICLdUj0LhgD+rGVJzLV0xOrSKAdLxg7tjDjIYgeDL6YxfEQNYN4TsP3gzdJ69E73R/pL3J8k6DFXI5Trgbqoopzz5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDKLCDHjycMzN1F4gktPQgWBVAS6UH/y4sA/XXy9wq4=;
 b=eaIuxgXXTsCAb1LqMB6N4fZDeoRMNQAfhNpWq8bW3u60r36hPeCKUhlZdmQC4mepVodf/gFgzC+dINpdpj+lUyNdpV8Jq+bKpcZ/tZr9/eYZ6HSc34v/IvPRFXxZXs5CW+h51IlxLDulSC+yfKbkiJpFBGJphvvrkODaIxr2UZM=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 13:59:45 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::48) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 13:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:44 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:44 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:44 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jl638000;
 Fri, 13 Mar 2026 08:59:42 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 15/19] arm: dts: k3-j7200: Remove background firewall on
 DDR
Date: Fri, 13 Mar 2026 19:28:56 +0530
Message-ID: <20260313135900.3430264-16-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: d7532b95-8a6d-46be-4598-08de8108c828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2gUp6P5tPZ5f4Y9D7+edc+fR1bGrsqmYvEb6tK8ZYekzuc/fewYef9/DgV2V1nGiDVAGXYzQUe592zlxWpeG45NOI2YjH+ptdYkbheMqebL8ZodVk6phD+v5BsmUpGWo1ccwMoifgCMP3uC0hISZRXjknF2AcxXg8StHjEd6KlvgOLDJsIQIG0cnEmTWh8ezQ+DP4XesZ+yFVu3AUwtT4/258DoWjv+YBE2DS6UQUL8aULfdrl/MnpGHalLbMiml4uQ59TMHY1OvKrYSmUCRtoGgTobpzP/NP0hooSOM+x+mkC9x2D2d2NgjoCmrehNnyCNzM5JGPYzVqpv5PmIneZw2IXHBfcvS8khhqT2pepPSJljKnBAgIwFFChzl6N/y059GLbFr7v3QKyW4BatoZI4cHe7QNr15CkT2JyjYAbgFMEppNEc0/2RVeTJcNZH+2BVJjF2U0dAp4xyr1A3rEPm2T5USLDxcwrnVKkq83nSc7R5Z670ya1KHlJPVM/nD0g8m8sgae2d/wGEPYQGy00bDXlbK6XZlJthpIrZEO+JmgRDdI5/NScBUwXpLslcrUJbKPI/qhZuiSaB+RM4KQ/MSfMN1bOEil06kvHSz1ERmwkX77XcU+PwbPw2lO9KYMjLjRh0ALavfBiwN6tWM0ATUkCvBGvgg5q09rRge1YWkHH3AUNB14wofNEsIcqyJWKgMgfc5mPEPA3qobLk/ezPoZCjTuHZoZHG3KEPTUi2UkuhEPTBU4140HONzDa8DEGaya1XFsJYpMf/VyBC69w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vi8GosqBRK6zlCveiQQVU5iy/jYVxkm/9A+Gh45PT+EKei0zDORZIykQ8zB8pUZHHbmM5faTk5AMcbvti+hamsoikp+2uCT7lGT5gdUH6/6VCck1MCcUlEQAo46T+E8vt88wUkPxCo1RlcewS1ZYJziDJ9ncePyWwecK8b3Y1e375efXDnTXeRP7l3GTBK/RjyKdDKMdwQ3MDZlMYdgDy//PEKbi6bc5L3D/dtjxWwofdnwjVo+oHtT0NYl/o02Xd7FQwuY+z7nO3hSUEIKL4mwPYosk2xJI7dhEBrt/cQDtabhiySfDVGX4OcaslUbiZ10CSy8mgllp7zc17ZGPJIL6YwlMlC2LNIShR7gAAEJq4nE2fP8z3ylRgTl1seu53g13ZYnpzhyYJfcT+Pj9SQf8+eCc3/ukt45hkN2ZAuaeZNojV0u1olm/ljnr08MW
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:44.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7532b95-8a6d-46be-4598-08de8108c828
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
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

With updated TIFS version tag v11.02.06, the background firewall
for DDR firewalls are applied by the TIFS. This removes the
dependency of applying firewalls through binman.

Remove background firewall on the whole DDR, as this
background firewall is applied by the TIFS init for j7200
and j784s4. Modify for j7200 only, as there are no firewalls applied
for j784s4 from SPL.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-j7200-binman.dtsi | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index b4e0ce8bfcf..81be4d69187 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -294,12 +294,11 @@
 							region = <2>;
 						};
 
-						firewall-4762-0 {
-							/* nb_slv2__mem0 Background Firewall - 0 */
-							insert-template = <&firewall_bg_3>;
-							id = <4762>;
-							region = <0>;
-						};
+						/*	firewall-4762-0 {
+						 *		nb_slv2__mem0 Background Firewall - 0 
+						 *		Already configured by security entity
+						 * 	};
+						 */
 
 						firewall-4762-1 {
 							/* nb_slv2__mem0 Foreground Firewall */
@@ -308,12 +307,11 @@
 							region = <1>;
 						};
 
-						firewall-4763-0 {
-							/* nb_slv3__mem0 Background Firewall - 0 */
-							insert-template = <&firewall_bg_3>;
-							id = <4763>;
-							region = <0>;
-						};
+						/*	firewall-4763-0 {
+						 *		 nb_slv3__mem0 Background Firewall - 0
+						 *		 Already configured by security entity
+						 *	};
+						 */
 
 						firewall-4763-1 {
 							/* nb_slv3__mem0 Foreground Firewall */
-- 
2.34.1

