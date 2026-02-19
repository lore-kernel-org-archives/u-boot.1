Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB6E9A04D
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B5A83F1F;
	Thu, 19 Feb 2026 14:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vqF4pvZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BC083AC5; Thu, 19 Feb 2026 12:59:30 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BCE83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww4rYRUQdgfQ3gkG0/Ys07lK0heOeOL3Z/mZWtrHYAoDVEdBgIB8DxIKa7STwIkt1707v09hjZIk0nu0bdu4qS8JB5f8kPP3c01gFwMYveRIYLDdmKIonCnmTvL5QuUUZKJP9d9B5YAKvya0+XAMw1BK+TPBuyqFcsbU/fMgn/gfBXWttHns1nrF2ZWH43srtZoZl6gcpQZ7IFV2+8/2xzm8GqBo+C0f1aNXo5MW7s+gn6P/lmxO3vHoeCnYp6L8Bi76M1ONsyOdUzebjrK7RIaO2XUT3oyzlYouft+ppVad9VtfkTnP01uh2kHdtmW6hJxD6p8BpMnVajmFZlS5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ck4b3JTkZ+EetHndcmluMBlBMXzVf0qusWGTupZYgE=;
 b=rmcaQDfW35IJYIciudLkQj3uaYlPA0ko23KS7Afg+EtcPql+VmICJwKpcszOmKriApuVKl3NJ4CxaVxNgjP1GFRqBR94vvIRT9awQCDU5velC1q9TThdXN+VaNlrM7M1eEgQBnuh6Ilm1SiTBpycxk25kYYuQzNpKsbTwJqecagGgQk0lFPIxK9ju+uLhsBHksd9TEEMMrI+GbqCn1vX3/6Y9HDGgXpihFSL2NzB6FD7Cq0qbT04L2qzsCcqgandNafj4jkWHRIl8ihVzKjpJm3e3gcwCzZubaC3cKDI5qZLZd6HqReLmArlg49IFNrq04nl+1NNSvR2bCL9cNl0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ck4b3JTkZ+EetHndcmluMBlBMXzVf0qusWGTupZYgE=;
 b=vqF4pvZn5byEaxhtFPgBNcy+rwRWPpogdzwMbM/dH4Fti1oACgcozYiu1RwmffbY290wQ/elB9xh6Sw/fAJidT5nBcNN+MYAIy5L2Uxi+17DfAi1tuBE0XKbPV9EL/ua/lBGwpx5au4NsPtRoGcKSVKpBOPP8hYcH/ORsm7EgVc=
Received: from CH2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:610:54::20)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 11:59:24 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::6e) by CH2PR11CA0010.outlook.office365.com
 (2603:10b6:610:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 11:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 11:59:22 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:22 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 05:59:22 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JBx59x2535407;
 Thu, 19 Feb 2026 05:59:19 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH 4/4] arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman
Date: Thu, 19 Feb 2026 17:28:37 +0530
Message-ID: <20260219115837.965532-5-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219115837.965532-1-sparsh-kumar@ti.com>
References: <20260219115837.965532-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f75a696-96f3-4ae4-f783-08de6fae5268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9x3ScvFY41U4N+HlfAxpqRGXla7Y/RfQlVBkexp33LzD56QZOIoUrFxaIHZH?=
 =?us-ascii?Q?QM1m023sXooDQ9spQqw6T7sUA/T/yLACN10zK1y9OO8PcqIsTdU0TzfD2VEz?=
 =?us-ascii?Q?HSnCEy2XN5wRglpEbtdPFGRWqXcyxlI8ptYlMlru9K8pF1gXukPtdILELfvw?=
 =?us-ascii?Q?mJvbOtkR4o3xDiW/flRFP/C20FBClaUWkekjRZHyTQiMJ8XnD5BbFcLYGDIP?=
 =?us-ascii?Q?vYC561ZVxpiUnkDObWPyRHUX6aF3ZErCR1UMspLubE0omJ1L+ofI7bXPBDRc?=
 =?us-ascii?Q?jaNa+eBluUjeHeY1Q9eKQTQ37TJq5Lk4xVGze5wpp5yZM4v3uQvCgpiEceKb?=
 =?us-ascii?Q?y3MCqBMAho6GCdjWeUtepPbVGbLg1TCkK6nWvhmkvBYvXfIJA7ONJqjqkLB7?=
 =?us-ascii?Q?aoTr0V+eW9a6wLovbBJay834kVku7c+ho9/hb3/Km3Ub7A+XHpZUMNzgdO+G?=
 =?us-ascii?Q?vUZTWAZe0Tpylb4pkt/i3aFmh2SQILsQdzQWWyx4d5YUVJOGY5QKrd4Splxi?=
 =?us-ascii?Q?kq/eU3Bvydy9VoNRHwqFkukpKUU3caTAZ8WvcwAl0qbH8/IpvTD/kXg1zcX2?=
 =?us-ascii?Q?FJ3Hhop7aI2Y2UWmEgFIUqAsiE5Sg150amTH5A0vlNvs6W4lOGC2k96V/qS/?=
 =?us-ascii?Q?wkfY8QgxxnA+Dfo/EaS/9+vZEkGKKMoZVxzJDf0RHC0tn5+FA6N8ITzTqjXZ?=
 =?us-ascii?Q?nyssSw5SvgFVZ4rHjGlb7p/KmZp+ZEqMA4EIJrybio8PoB51Y2DUWdAay92+?=
 =?us-ascii?Q?SZKwR5wgpVuc7cMzCrdlz/9UywUW0DSAm0OLEcOYlU3dzlr6Dvi/l8OY58UY?=
 =?us-ascii?Q?qAjrJWMOM7VF6jkb3QjWX7g+Lp//i+B6kwrFHz7JDSKOsR1r+Rbzo56daR97?=
 =?us-ascii?Q?ljeXna3zz+8QE8YPJhiQ+8CrfBSsU32v33EjFQknvXNm9XW2EiIMxY2PEQhp?=
 =?us-ascii?Q?QcCaoYwDPBEUklymdWHLoxdF4IkVED7erSJkBULd9r7Umnp8qgVZvV/WnnMc?=
 =?us-ascii?Q?FNuZjodAYCQLL68KFNI7v5IES0y/BixjxNjazBunVJtVI/HiMgsVTMost3Dc?=
 =?us-ascii?Q?Y/OvOg0rFw7ES9JwKJiBJr1N1MkBJWEsyZJxLZnnul3O//BmdB/ej2IL+bQ9?=
 =?us-ascii?Q?Wg8dyXTzOQh18kfKz/R2LX6XKflG96vA/w12DOiuQNZtUDVtOG8dA4XBOVMX?=
 =?us-ascii?Q?4XBcF7kLY4ox/MVT7Fb9LXueXvkKmpbD+4e0gLS7EGPpRNqbUpAXiE6ucbyt?=
 =?us-ascii?Q?gmt2ZfF4eSKQGMlYk8aaHz85hvPtbr8oaPfJq0EZSxeSY6UGOHEfhsJOtFFY?=
 =?us-ascii?Q?iXp4FoWcRyKfMeFKeJLgF2uoEf6rWHLp+G6SlBR0fddI9m70YGkrVBmIvbGJ?=
 =?us-ascii?Q?RrAKguQHTvQI8Pgqbu9eJZHhR0orrpaUFGb9K2ktBcFKdLmYRywuAAWcFu6h?=
 =?us-ascii?Q?jo4HQGFtK4ZuL8ckh8rxbotZK6sVrBAOSunlEgNqJMG5oXgiWwZ+w3GGkFc2?=
 =?us-ascii?Q?rGNT+pw36uWeCZJ9N7IAc2c+Ln/oXiBOJkkLglFu4I5Mb+DuL0SaDJHOl4dp?=
 =?us-ascii?Q?IJyu+Zlnplud92F7ndQOQhMQO5JTEyPGIxPzZFMWQ9FrZHTs4Rka1pZosfJm?=
 =?us-ascii?Q?FRyABaKe9HUSjEwXFhVF+KMbsLTDb8EAkpDAAihxCM9b/bWqkJqxjRC+I3gJ?=
 =?us-ascii?Q?nxKmKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4wCmWk6GOo5sYkJNibFL++I1zSHqBDDacKmq9roDRZsItjh8V86DC4FCyRMFMt4tdjy2GAmv/kTWAO+/uCGSr71nBPEpLVRSGlfGSt+ukxwROawwhZt48nvc/915ii9oDw+IeUFnxs+ZDtu9tfakli5jMexFuO6Lj3vdpQ3r9nUVNNoXtmL2qBQNALQZ/x6QVWiT9svDYoyCcZt31tSKMwA7l8DOxHBAdBztAosiMAyMtLz0fMlsOa5HHJI/4uhNnM8blQv0rGCcw6Th5QniJvNyWxyxS/v7/ors4EBCGbvXvFW2TvYwjDVHYRxdfpaQFGk/6BNnWxPvOwX/GEn/EWg1UvglOiLAvvWh+MLQzmoc+oCCvnHRgJdqHgYif45R/M+yORCSVUDu1hvw45G4AgcpHgr9D7zD3v9rC6vmQ5dwJLnaE8g/+VAViVG0gcgq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:59:22.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f75a696-96f3-4ae4-f783-08de6fae5268
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Mailman-Approved-At: Thu, 19 Feb 2026 14:37:09 +0100
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

Add rcfg_yaml_tifs node override to use tifs-rm-cfg.yaml instead of
the default rm-cfg.yaml for am625-sk and am62p-sk platforms.

This enables binman to include the tifs-rm-cfg.yaml configuration
when building tiboot3 images, bringing these platforms in line with
other K3 devices like am62a-sk that already use tifs-rm-cfg.yaml.

Related commits:
- commit 551dab22ce68 ("board: ti: am62x: tifs-rm-cfg: Add the
  missing tifs-rm-cfg:")
- commit d0c9d1c2eaeb ("board: ti: am62px: tifs-rm-cfg: Sync
  tifs-rm-cfg with TIFS firmware updates")

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 4 ++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 8d6015e44a9..ba29a047406 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -7,6 +7,10 @@
 
 #ifdef CONFIG_TARGET_AM625_R5_EVM
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62x-hs-evm.bin {
 		filename = "tiboot3-am62x-hs-evm.bin";
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 603487341d2..cca56b76d69 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -7,6 +7,10 @@
 
 #if IS_ENABLED(CONFIG_TARGET_AM62P5_R5_EVM)
 
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62px-hs-fs-evm.bin {
 		filename = "tiboot3-am62px-hs-fs-evm.bin";
-- 
2.34.1

