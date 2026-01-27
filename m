Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92407D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A73F840CF;
	Tue, 27 Jan 2026 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TQ4HAWT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA6E83FC5; Tue, 27 Jan 2026 09:18:18 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EB683FBC
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8YVkr0udfHZWqF5O7Nm78yG1Snh6yYoiN7Yl95FHBQjkGTeJlriYbr1ogDttKLPvlcjfPzJBF3NdFR95ucxxZxdKqEf6KGqICWH5QidzxDTUqg+YZUViPH+l0kZwJqjcZJJsUIS8FlrtoiBS90g75m0AV1lBYwdOAKZeZQPp/VdFqVYCWQmh3SCFpX88Io9NN+GzFjs4ZpM4lOQ1woSsB9BDc7tZo+jlm+6mWscL7NR0Hk3THaSv2e+vfCaFG5YPdf5nZbmL0d//45/fihqZCsmo0yZFUBoIJu06TL2jc8VwpKGEvB1uMRaXHmgWd7wFHR5A7fJN2DHVxVUvI5mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=lareXGCcA4YY3i2GKsYGUvBNLihPOd8Vhr7MuZvjatZcECVWWef/daQFIPtNryeekWtJJMgOAXeCCbwcXQWWd2hix3kP1au8xfy4XblXHzaxwBAgfp+TpErof5b1y9EIIceqd/XhPO4/ZJYRDcJoE8U+PTfTVyH3FEMvyuRZXiJT81GGyJDuzcMkFlTzG3zdYpBjhg10zqwdCFxns4IzPPcyU9NOplDpUx1Ja/xHNqElKf1ZmsVBjrw15PdN8Q/HUxdg/tGaftQFDbA9Zqy6jQuwfP8MwQn/cD0a6spPDNL/0sthB6eoEAxc3c9WQVH1h3uM3MZKSvNoAH9V6gxK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=TQ4HAWT0lJmqXwDz/DGBBHe2D/cstq1bvxO51NLor+VEw4M3noOpzfevMkZxWS1j2RW0vezRC+1nwI2n2Uo+n72DOPPepXOg45Wg7M5khsGzc8xg0WqQeEpH+cjf/ncqwlpjBoPdz5NQc+wBqkxLCm05h58DVco9Z+N0apOqQvs=
Received: from PH7P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::28)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:18:13 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::47) by PH7P223CA0002.outlook.office365.com
 (2603:10b6:510:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:18:10 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:44 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:43 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HglE185582;
 Tue, 27 Jan 2026 02:17:43 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 09/10] arm: dts: k3-am64x-binman: Configure firewall for
 ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:51 +0530
Message-ID: <20260127081652.506357-10-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e67271d-52b5-4f68-67a4-08de5d7c9c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQsJXP1DCKhcF4vsFhJNgZz/IlDOy2L9eSQh0y7GiH0v+QHMlrI+JHMY6SHD?=
 =?us-ascii?Q?PcCXcK1PBDGSY8KGcG9QpS2hsIJl/QwCMpXuFSwCFWWQV2AZXAAZpnmlvAaZ?=
 =?us-ascii?Q?H9q63O0CVd9Hl8QUYf1hwczxHJrsmVpVXGBqBeJTjkpDBc9Mm57NLnR7ePX9?=
 =?us-ascii?Q?1vkbpMTobsOrhV83+1QTBkL4c1LfM9VSkOwDRZErLfuzI/OuD1PBRUkDpyeH?=
 =?us-ascii?Q?Zs1SOIIwKmVv5dLnFTdZN1BzyRj4mi1uYCC+S9VUoh1WguYLcO98BwARjlx7?=
 =?us-ascii?Q?lzYZTHWkeNZRTVubojw4ato3Yas0OQG9/c3EpF7/uICKRE0I+3eqI7QNClwf?=
 =?us-ascii?Q?n+4oyZHyL0dTe/fRLaCwNlKLzk1jxRSgG2zJ2GaqOprurEKKdRLLe21flmfZ?=
 =?us-ascii?Q?MjA19mudG2X0TAnkk4tI1C7E3cfiXI47IMw5u/ZwgTcoPm2MqNd6/kNrbiUj?=
 =?us-ascii?Q?zyia0QbMejQJCyfzskWOV7S5yxjZrTqNxgsSUIRm39qSoknSsmIpzLxLowvV?=
 =?us-ascii?Q?8nMD3hEnVCXDPG4JuwATGp7fL6a3kMWm6Zmpr/R2qVcEyWziCK0P7QElwAW8?=
 =?us-ascii?Q?hPuxDOZmK3VaBzu6FKAKCxH7dSAIf1DVmnQcM9/XUpu6EXH60ZzH6jLKoakW?=
 =?us-ascii?Q?VDj50r+EhR5T0u/YctMw951u0VdTjXeLIx7Edkj2/qAdvF+Z48OLyqO/fs4L?=
 =?us-ascii?Q?5+xblsYuv+0FBKhsQhLEfZ4ECSZWIrM+u0GUjALgP6puzl3g0JOabZ21n2BQ?=
 =?us-ascii?Q?WiSnAUe8oeh5HUrljpim+reWjU4E3RAGw/KpoKzEkTt4HeHom6HBeB5U0v6y?=
 =?us-ascii?Q?s2tPAs537CnU3dFKflLY27y47IzUY3+Nji0Q8CWOWRt7/fpw8n4dU5dXMXkJ?=
 =?us-ascii?Q?jeOlsLsSCjhD8SM3j5TjS2kQYyTc96zoXop9P8ZOUWCBRZN6QhC2WOYeFp06?=
 =?us-ascii?Q?35eyhIuZssT7/X9HJa+nnk/RYEmJldDNV6XH8ABrNKP9EizQ/L1scJ5HZayO?=
 =?us-ascii?Q?ZMPKHp+jYwDWZKtsPYoMQxps7fFxHFUcI2QzALgw/8zwi36cOvENDku027Xe?=
 =?us-ascii?Q?D9R1r1dnBZJFokj1gs+1XV6ONrkS4z613ECONMvV77gzeayAX4LUo5anKxvt?=
 =?us-ascii?Q?/g4d4STDOhMM46xZ7gB02SA95hmsM00IBbYjyCSbsFF4H2CstwCTW2ILvzMq?=
 =?us-ascii?Q?UzUGLIEtseMTOCthr6L6ayn482Z9y+3uX8LwVcwX8N2CmpKVPySps4q40aeG?=
 =?us-ascii?Q?C3LM14mIytSRk2CacHaLq65yUYpyRcF+WzFtnn+FqbILzVOUJmt5XsRHl8vr?=
 =?us-ascii?Q?LhdbY1usB5HSnosBLsVkdSQKhnzlaM7mbq/m5aqcsMY+qoyImuKBTkaWz5Ud?=
 =?us-ascii?Q?K4qssEi2Tx1TCZTCLTUPpQalWPGHmW+kwkE/dHXoXZkNJuYUaLblVzl15Mf7?=
 =?us-ascii?Q?1hqDJK2aNoqwI0vVrMQlmPBGpFwm7r82bluZz7Q8VxXmbpIY7EpwgpBn9whu?=
 =?us-ascii?Q?418UdULXu0k4XWS7FWO65ZkkAJHaGinq/ll/EVFKvIyOIGuGqLCHzeVAUaI6?=
 =?us-ascii?Q?Ixn5HO5UXFD0m+/+D2CedSTewektENN/2Zu/7j0Vs4xrOkmGa4L1ireWPXvm?=
 =?us-ascii?Q?T/2DwSq0SrJ9kEHfKtVGg3/YfWhb8E5FBpgJSOujo2XIN4PdQxv03Ji+VYPm?=
 =?us-ascii?Q?+JS/qQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:18:10.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e67271d-52b5-4f68-67a4-08de5d7c9c02
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
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
from non-secure reads and writes in AM64x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am64x-binman.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index 32e47a3f688..f3c7f2c939d 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -139,6 +139,37 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-24-5 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <24>;
+							region = <5>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
-- 
2.34.1

