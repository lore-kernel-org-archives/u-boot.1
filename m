Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B7AC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D224C803F5;
	Mon, 12 Jan 2026 14:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="stD+Hkg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E6683CBD; Mon, 12 Jan 2026 10:38:35 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFF983CBD
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTm5uAGRILxEfEDroT68RVO+XtE9vrAI04tEscw79MjXgtm1XxHreTMgNqI5eTds7kCUpd/hmIUjr4+Y481KNmXlT+12d4+pSd5aN7qGspp6GyWmx3Af/Y1lXHAn0K0Xdzg/FwxmcExi/dCIUyNlwI7PFqnAogaIZO6pEJZEIZJQM2d2aJV4e9ODMBxyWwGriEPuSm7I0QDLgS9QKGveKFyo40/ftWLUqXCjL4Q3ZB0nwIeC0KgzX5hvCIvGrslSI0K4iBO4kNRBaBav91eZuKh5fH5h8OagMHj658FzDqiUcvpq3Vy2xgqZZ0yqiY+1c56o7VRIVSytiP4IPzVsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugpvGISUkvowL4U5jkwIWNLMNKREI8D9e209z4R+v/Q=;
 b=CP67pS4Sxru2+g5iSlWKPTtWZ6yLsdoIu4I+IYEwtZTnufkc8rKcvi5Ews9AYf5RRiP7MFUOvPIRQl4CsJ7/GwPJmsik9wtY2jJN/qCa3I0XSWllueUSZCOMy+5i47CyMaTTaD1rt2/ofJsAEJzT7LsTT4jyONtCgU6IRTThWQ/avXOc+0Y83sPL389rk3D53zsCiTtQsyGAYVkpun453ZbLV3cyuMof1QB39gT/HJzP3pVfeR7Vni7NtSX0m7yB5joTDUxLya5aZd4PfZ2/KAPPHFpuxv3qYa7nJg2CoWHCpMOvYgGghoNLGXK+xtQjgozaudm/P7BzfchW6f8TgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugpvGISUkvowL4U5jkwIWNLMNKREI8D9e209z4R+v/Q=;
 b=stD+Hkg886GuR1xmtiKACfJNBo3IS1btNobVWmeRii4deTT7sftDHG9rn30oiI9/CiZAQ1wWa6ubyCgPp/vW4PubzYNHaZweKQ6jkWakgn0nuCSiNa6z7v2XUCDM7+ETvcNYryTfl4ju2gs8tnBSnZoiNWy+jOrDJpKqEBZHUTo=
Received: from BYAPR08CA0043.namprd08.prod.outlook.com (2603:10b6:a03:117::20)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:30 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::79) by BYAPR08CA0043.outlook.office365.com
 (2603:10b6:a03:117::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:30 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:30 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:29 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:29 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9cSZ7156288;
 Mon, 12 Jan 2026 03:38:29 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 3/5] arm: dts: k3-am62p-binman: Configure firewall for
 ATF/OPTEE
Date: Mon, 12 Jan 2026 15:06:41 +0530
Message-ID: <20260112093643.885903-4-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112093643.885903-1-s-joshi@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 924f3a61-41f8-4d5f-6a91-08de51be58c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uzjvtKwSxknIy/U3uzf2zeGfUBHcQc7JhQkxDJeQJKtuYaPxSy2qJ0cF8gbf?=
 =?us-ascii?Q?HRljfacFHgOq/fSpvKt7hpkVqx7EnDVINLrkpf4BT9UFj3MdQRNWgz7OwCJt?=
 =?us-ascii?Q?nrkqS7qBs26nyhQ30bcyiku4OrTsBJM+fLnwlKy2SRB8x2gVh/EZzE4zlcDD?=
 =?us-ascii?Q?Vek1M4abu7C8kg0MxFVehoafnHXVM+NVFSJ+u80SuuJHVHitxQ6FSXgAXInS?=
 =?us-ascii?Q?ubPYwi7F8I/vmV1XmAei+fVuW03Q+gaaeHHNzGHTp9RI6T8znk5DFujzmQVj?=
 =?us-ascii?Q?Cpe1NLGtNB0hgt7XQ1nyWQdw8HZlQkmKx43/bMd+CL92vc8UccWebFlBRPa+?=
 =?us-ascii?Q?iNwBm7KoD/CupEfFyWF8WsCDr7TMqrAsom4rbwcG0iuLWu/mOgfRmqoSpmlk?=
 =?us-ascii?Q?i0rEV7kNLUDaSeE2Ov9r9b/te/t8vb8bc2kTY3afmYCerLjLQPnmgBMVSJPo?=
 =?us-ascii?Q?vK1xGA3VyLsKJ99zqB8SwiFRwdW4+onydtmU4S+AVAwKuZJNqKpQT1Njn2cG?=
 =?us-ascii?Q?C0A0maStaLbftvd5YartbCa92XMw4FijVEZGt6g5b+i+Ejo+U42TsNMU/AOU?=
 =?us-ascii?Q?FtnGGFxQqf4dd+kMXN/x571mURuDIdYGRvY6zGx2NXn011eqJHNdmFoqM0E3?=
 =?us-ascii?Q?jIyXkSvLIA/NY92z5R38PMoOI6aZUTs/bZKafPnjGD612KfoK4OWElIpXNNN?=
 =?us-ascii?Q?ijVUvZd+GtNwq4qvyuMfx4IJuYMC3lWtNpkdLKt86eBQpYbP/SAvlp9bSHqo?=
 =?us-ascii?Q?uYt+Q9YK+daT4D4amtnhAvC+iHQcvyseLu8q6cbHdTn8q4mJFaYeADnJksDM?=
 =?us-ascii?Q?1qCldgoMIffZBHaXlpvlcbe8f6IH5iI0KJMu8lM0n/uenxyF9/pzFMLYgi1W?=
 =?us-ascii?Q?MR2gP1EYZUGi6thReCwrXlL8gi8LRV0wKOLuwKg9tgSvLIDnRSbwqLKQ5vy4?=
 =?us-ascii?Q?5icEwKtx+RuGDBIWcvB6tubg+N2l/Pk5ZGzHOcofsXIH8wGU2JiZjf12nEFc?=
 =?us-ascii?Q?JYHinfet4kZlYnUjKOD+24g/A8z0tWGPwzWnpbgR4siHYC+ncfH9qGrp9wCf?=
 =?us-ascii?Q?p8UlT+M4RAOdqHp5zSaBxQnta/oyHrV+7IdGbNbKT1aVm8nnoeLrGAp9o1np?=
 =?us-ascii?Q?+oNSr3WLSpVhN7h1QXEHJCXsLZoHiZfgExye6nlubodTemAgkGlbdnEam6mp?=
 =?us-ascii?Q?jGKNQKuLA5ynzUHG8lo8T9vrRE8xMpOBGBg9AYH9Z6thzml+Q2RmHVYPJ/2+?=
 =?us-ascii?Q?ULwiti9lZK08xSk7LpUcgLdMfHW2sgXySf1mORj/DukGE92eF5MNBuwpDXSd?=
 =?us-ascii?Q?upOA5XJMKQmZUKTp2posRr49V1SsuTJ549M5/wgsJ8xO/6HMdUC/aUAw/UIj?=
 =?us-ascii?Q?H50bzcsfQcASxa9So04OqbtJlF7eN/SVxzOTDE2AuBE5pk4GVp4pfxHHJzfe?=
 =?us-ascii?Q?BNX9g0x0pKHv3nzFOn4nbSuVbgOz3IfhAHhrse/AWgMICY6J8+4IhpjKzxzp?=
 =?us-ascii?Q?tCLELHhGNok3t1wvJTxTUNy//xFao3KftAowpZaGhmTAKKBsdKyKJCdqggW/?=
 =?us-ascii?Q?G4eYbZ6c3MjN7h+oIQQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:30.6655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924f3a61-41f8-4d5f-6a91-08de51be58c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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
from non-secure reads and writes in AM62P.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index e1443d6226b..96c06c9ac77 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -217,6 +217,39 @@
 
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
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

