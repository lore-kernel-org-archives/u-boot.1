Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0BAC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99433807F1;
	Wed,  5 Feb 2025 09:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MhrWOfgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF78280780; Wed,  5 Feb 2025 09:02:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86D880815
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qql5ah6RbSZQqk1cfFlbMXjDngHXfwwU0eEsl0FmTElCMWjhkciLrG9cnbu5s+ym7PCErex2pSgTniCqAtBpdc3mPaPmX0MZ7iOBhEjczPszxjSQMlicG5jD9QSCdta0/gjHeckTuQ0vvwdUDECmlcGs1OtEeLnP/uTyguLoCyydvNZA9L4gShZNquKSqRbPDXjMoVi6wVYP6+uU9Mij/ykolU+gOUCEjOV2WsB/FvGPTDQytFznUxqHlB4dyVDetb1HuC8KfNAWo4/okLn5IwqXi7NM81FajqSfANO34CFb57ksT4nJHU7ykFmZf5Y7Op+V4R1jodWr5pl97akpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thQ5zFipCDuvTkcTVvgUzPXf7LjiHlfZiyB2Zu49m5c=;
 b=SbUXr3o36Xt1fETGXeAcuylE245Q54NqtethUlKnPzSNeAgYJ1E34KomiJdRWROFAoDT9dpKsuA1vWfMmzPvUU+M6YN/pzKxeYwsa2MrFUQmjpzbQ6EIvjQzmOweUbL87VuqDBWYXv5NZyzt8Quyk3xE4e2JNjqHYwu9qew1GN5UeMVQwIAsPv5bU697Wo6QO8U4eeqxF8xKTIhwIWFzoOQ4D0ceEUGhmaLTuK9eV8Fuqz6aQQ8BkjEROfcOlYuCFN+8vMAv/9/du3CK8ncSO/Gq1N0U05etuwzkw9xj3rT6kD/r1MLs3zH4sqvZfMulHzujVg95rR7wrFXbWNNOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thQ5zFipCDuvTkcTVvgUzPXf7LjiHlfZiyB2Zu49m5c=;
 b=MhrWOfgEYwl4Rmv/6Z/fLiPb2xyYOWJc2Ww9eeTMcqi3BR4gyNOTq84PZstFNP1Fy1Q4x2/CrsDNTJAD+ctIrIzOOIJQr8PTXHvOlvNVYJHtqM82jh+SaJcnnxQ1IrWWkKmPAKljiQ9vI/69ysc6vETRx/eBgwgDTFbcLJz5w15v4yGwZgPbyjRgiWI9G92JtASnI2DV3vMZh0lNaS41+kJBWzlKWd8mdQfX5rLnqguSpw8ZKqfaOanOaXFmFDf9nRXtn2XaKWLOJRKsU+fPp3HA6t/FpZ3PQ16H8ReL31PnfpEH3HAn7MvJqh5Ke9B1L5no8CDK9cjb+vUXTWhN2w==
Received: from AM5PR0101CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::35) by PA1P195MB2583.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:44c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:02:27 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:206:16:cafe::ab) by AM5PR0101CA0022.outlook.office365.com
 (2603:10a6:206:16::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:26 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:26 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:23 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 06/10] arch: arm: dts: k3-am642-phycore-som-binman: Add
 custMpk and ti-degenerate keys with CONFIG entries
Date: Wed, 5 Feb 2025 00:01:42 -0800
Message-ID: <20250205080146.1944928-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79B:EE_|PA1P195MB2583:EE_
X-MS-Office365-Filtering-Correlation-Id: c9313bcd-37ce-46fe-009a-08dd45bb6e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uScg8FGEhuoP+xmCuNRB+P9wsCb5Umi5jvUFXXtoaf/S02yJ1TIFFs0pPeQy?=
 =?us-ascii?Q?OSjrSibeZL+TUrLxVl5AQwchod0UY7T+K6WQARcju6tC8g5sHEB+RrY+dRpK?=
 =?us-ascii?Q?i1VFumfFkOj+6k+IOm1DXwF3ZBe8irpGzAUBQsM8dvMnr3GNRg/JKKcynqRg?=
 =?us-ascii?Q?8JfYRbNtAJ9R4fUvUJPQCcvYiO/ZQuUnyJHpU9Rr7XAbXZMh/VnL/ca6oJHo?=
 =?us-ascii?Q?1PIhXUsx2HPaRPx0xQugMOmQD3uDJkDZF201E+Fe9XqYX9JUY/1gSwvEI96A?=
 =?us-ascii?Q?zV3UW1A/hZ2C5FnQbqG5mjrKJ2l4mIu+v7Ycr+eIpMYU0DQ4YxgXbT0kWwZZ?=
 =?us-ascii?Q?RKuXldcI8V8U4J/a5m/AwF8EcPUWP1ucMuv4F6Wm7DvdBNkq1uNON2535dxh?=
 =?us-ascii?Q?iHq2lASjIXhbFtkN4Gx4K9US+AzqhteXYmrXDgF5jxPlcItKCUpQjfnCTtHA?=
 =?us-ascii?Q?T3+QtproKLCjzLwu5FaP5+S5HuDAJG9NOaKhCFvJNaUwxXR++5czlu+30SBD?=
 =?us-ascii?Q?yJ9/oxzugnQYNIViHLAT93jybz6osd3G0yu/pUo5DVUqzHSwhX8i8oSf1zxs?=
 =?us-ascii?Q?uXdJSrfJ7HAINemOVMUMncsHkWsZqtRnG8GQFL5nO39c3lmNJ92Ql9FpEATy?=
 =?us-ascii?Q?AvAmAhxMXpYEzYVJPEiiJqbCIsTq9J79l0kjtnLL3ByrmxhT6jQAnI9lzFt9?=
 =?us-ascii?Q?NlmL4NAM74J4vVm+QPNTQH1qQP5bmAmPnKbPPzlrndPP8iOa8tTzhjbLhDaS?=
 =?us-ascii?Q?K+7rieWpuYggYvrz+Av8LQeI4eTS4QHIit4pMw/qbaN9tY79L2G6EheLES8A?=
 =?us-ascii?Q?xRR/6mnSGSEFf5R7LJh+SAwRpwNKYHB1OwD1viBe8upn/idmLcb5pYiTOiyo?=
 =?us-ascii?Q?N0iwiXyEWyH3Ifk5Mwz35UH2CkqKc90+AozwXTd2BcL3Xj2Fw1huxIxGGKN4?=
 =?us-ascii?Q?JYLMnnjDOcXpsGiBGPsoQ5UnEGV7EH6kjzbB477PWKtKtMP6ATELM/YKVkRi?=
 =?us-ascii?Q?UNErjj48ZS5fjDzlXLFeHfDBowqSHiM5KnvRzSxYsJorq7SQC0jCPSNvlRLp?=
 =?us-ascii?Q?DVUPEFBBaMtDpg0EeQ7oZPWpgQXxdwL4v59CjMf6qoSfIkE293Ww5E/kV1cu?=
 =?us-ascii?Q?ivyTPqBgOQJK9UsFoUvFW+/JwqvWujhroSWzngB/5yWMxguwWO7nqO4Zd95q?=
 =?us-ascii?Q?kMbhYs4HI0QpJFXO60bnz0z1ToPnAs93U3XMWhXpz7VdXvNNRXzoy/KVxJF9?=
 =?us-ascii?Q?k2gKu/Cws0IwRCyAqwoy0Jj3MvoW6CevSv8oLk1Bdxq1J3/YO0qgOGIWau9A?=
 =?us-ascii?Q?ER8uaKlMrXoBpCXhKFg+Y6Myn6LpH3lxxgCUyEhK68/UmW4lQnZwNOva26US?=
 =?us-ascii?Q?mm1nM/57IJcLvg0rBIhUn5riy+Wlu1zcbjwHCAp/Iyht3ttrrTnRYK+516EU?=
 =?us-ascii?Q?vIqvWp5iP3sfEJCKSBfLZY2i33FJrxgOCapqrxWK5KEi3oQWEdGefgVaU08r?=
 =?us-ascii?Q?DrGOYtjv1MQz2Gw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:26.7317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9313bcd-37ce-46fe-009a-08dd45bb6e44
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB2583
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add the SMPK and ti-degenerate keys using CONFIG entries. These keys
are set by the build system and are stored outside of u-boot.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 70 +++++++++++++++----
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 3710564cd4a..5d86da7754e 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -8,6 +8,13 @@
 
 #include "k3-binman.dtsi"
 
+#ifndef CONFIG_PHYTEC_K3_KEY_BLOB_COPY
+&binman {
+		/delete-node/ custMpk;
+		/delete-node/ ti-degenerate-key;
+};
+#endif
+
 #ifdef CONFIG_TARGET_PHYCORE_AM64X_R5
 &binman {
 	tiboot3-am64x_sr2-hs-phycore-som.bin {
@@ -17,7 +24,7 @@
 				<&combined_sysfw_cfg>, <&sysfw_inner_cert>;
 			combined;
 			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
+			keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 			sw-rev = <1>;
 			content-sbl = <&u_boot_spl>;
 			content-sysfw = <&ti_sci_enc>;
@@ -57,7 +64,7 @@
 				<&combined_sysfw_cfg_fs>, <&sysfw_inner_cert_fs>;
 			combined;
 			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
+			keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 			sw-rev = <1>;
 			content-sbl = <&u_boot_spl_fs>;
 			content-sysfw = <&ti_sci_enc_fs>;
@@ -101,7 +108,7 @@
 			content-sysfw-data = <&combined_sysfw_cfg_gp>;
 			load-sysfw-data = <0x7b000>;
 			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
+			keyfile = CONFIG_PHYTEC_K3_DEGENERATE_KEY;
 		};
 		u_boot_spl_unsigned: u-boot-spl {
 			no-expanded;
@@ -146,6 +153,24 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+				};
+
+				tee {
+					ti-secure {
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+				};
+
+				spl {
+					ti-secure {
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
@@ -159,7 +184,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&spl_am642_phyboard_electra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					spl_am642_phyboard_electra_dtb: blob-ext {
 						filename = SPL_AM642_PHYBOARD_ELECTRA_DTB;
@@ -190,6 +215,9 @@
 			images {
 				uboot {
 					description = "U-Boot for AM64 board";
+					ti-secure {
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
 				};
 
 				fdt-0 {
@@ -199,7 +227,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&am642_phyboard_electra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					am642_phyboard_electra_dtb: blob-ext {
 						filename = AM642_PHYBOARD_ELECTRA_DTB;
@@ -324,7 +352,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&spl_am642_phyboard_electra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					spl_am642_phyboard_electra_dtb: blob-ext {
 						filename = SPL_AM642_PHYBOARD_ELECTRA_DTB;
@@ -363,8 +391,11 @@
 					compression = "none";
 					load = <0x8F000000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
 					};
 				};
@@ -375,8 +406,11 @@
 					compression = "none";
 					load = <0x8F001000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
 					};
 				};
@@ -387,8 +421,11 @@
 					compression = "none";
 					load = <0x8F002000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
 					};
 				};
@@ -399,8 +436,11 @@
 					compression = "none";
 					load = <0x8F003000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
 					};
 				};
@@ -412,7 +452,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&am642_phyboard_electra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					am642_phyboard_electra_dtb: blob-ext {
 						filename = AM642_PHYBOARD_ELECTRA_DTB;
-- 
2.25.1

