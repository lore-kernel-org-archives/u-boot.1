Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACBFC02192
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8B680786;
	Fri,  7 Feb 2025 07:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZDoHu8/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13858082A; Fri,  7 Feb 2025 07:52:02 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83124807AE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZq38dN6jHr4Z+dWuv3TqBUtWjG9O2LpoYljScAv/NEx5W9SiKCINevnk2H7SWGbNaWtGAnkYF4t+uEJ6lpBdHfICWNeHoammp680fmzZtZcgBmsFGUQkKC1VlwWD/AX6CDdRUvVFR4g6g3Psy5Yi8w65p9dT2tcjllZ3ycWXhX3rDmAa9E1t8wYLEC5aOleC8H75c7jej9LIQlSt+46gIe1ifI0CPMmGa27XpYOb12/6dMvg0K3u+tUyOJnYuowBaWvTVIUO/4flk9P/F5stDbNtTwXBBgDAHW59pguTb/AuuOirD2deUpZKT0UC3RsrkPAacGfHz4Nn+BnSilwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thQ5zFipCDuvTkcTVvgUzPXf7LjiHlfZiyB2Zu49m5c=;
 b=odsi6F09LiwCRMPFB6mLQhjY4AE9/0w4eUBcx3Vnu4lxZg+C8k+NWA4/lqfZr4gptskw8ihYpDg7YIgP7OBZnROhKzL7HBzIGhA2fRogpv+Q6ABmEbWLP+4JEDMjD0Rn1DjBKkvcCSH9CVYbOEpTrYc33/raY/27oM7FGx+HAvA3/oK5rF2A0wiNStLGPDmoBGshznUbRnJq4RnWzQP8+ipP56NljMrhofD2GOqvgTp8Lre8hky1BLGxFE/ws7iIQdQyiSVEKT8wOprLJ5/njsh3gmpq+/XqnWfSRa6vTiWJWWOZUF+UGwUUOaEShRf7vd1Mo1buABDxahKZ5BvAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thQ5zFipCDuvTkcTVvgUzPXf7LjiHlfZiyB2Zu49m5c=;
 b=ZDoHu8/MfVuaWiA9kZ6Q6EBX4ClZdSbLuA9tOKnwdGIkLWdTG5dBersSxftDY9d001fR0hwATM53sCrLdGkbp2Rsvdvuq9BdIGA5WfBa+CHNOrS3hhwumqDw88TYOUnUSLwLNc5ZYyyX4Kwvh+Ks6Kaamn2vffscCcPjN8I61CDRPZDbSQS4/O08071iimEW9eN+jZX2+7TMJkRgB3HVD3IbsqBDh91zjfkVDT+DrpqL9PDj888w+SmV2zkh4vohHodsY0vEzrORp6B+G76hWZfDf6enMIiBJgl4TtHIWtUD5sMx9OqPbvjCMsVcCaqpCevMVv/BbgnzNYNLeVxUbA==
Received: from PA7P264CA0310.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::7)
 by PAVP195MB2309.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 06:51:57 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:102:395:cafe::a8) by PA7P264CA0310.outlook.office365.com
 (2603:10a6:102:395::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 06:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:51:57 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:56 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:53 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 4/4] arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk
 and ti-degenerate keys with CONFIG entries
Date: Thu, 6 Feb 2025 22:51:22 -0800
Message-ID: <20250207065122.2495923-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207065122.2495923-1-d.schultz@phytec.de>
References: <20250207065122.2495923-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|PAVP195MB2309:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2a3811-6d66-4c5d-5e66-08dd4743ea21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0MUXkEHMSQoobOxNlKwAjAN0t6Vkx+4IDftsbJ15JHOUcGLFucKaTagRUou?=
 =?us-ascii?Q?jlSTYxc7qXA1VZx/sIn+SzYyQCflqhJEJMR6JEuXjwBqYxD57Fz4uVuNt9B9?=
 =?us-ascii?Q?vdEjwoFF/VZKr2kqwoFcqfhX/rJ6kE4oYRC7HLcTnLqHbh/xcaHnx0KCh7/L?=
 =?us-ascii?Q?kHHpdA00MK5OHim/weOYKqu82o8TzwS1LPWZQEHWEqkawBahyLVvi3dpcv6t?=
 =?us-ascii?Q?ypro6FTcCaG3pgNIlUVzwlrEmncOkz4HFfY75kcbhAlwDKyAWGeQ/42phEZQ?=
 =?us-ascii?Q?cPniJX8JMkwrcnKUesoXpK2vg2lSxUa4pdMUjykFtOFqHgGbQ7nBr4QLJlMI?=
 =?us-ascii?Q?/c0kTFBO90XBxN0ZCIIiD4iFU68isoBPAFKVyskjxgnR+oYlHyqTlU6l+IJT?=
 =?us-ascii?Q?LEBlgkRgiV/YJz6J6DT9ER7PjbNFdqCT33Kb6jNxwMxFJkdgoCkZ5y1n4cUd?=
 =?us-ascii?Q?1vPvUqK5sQxljIJlwb6KHfQQye05I0EGQIGopqo/cUkpEibe1RkbgajzXCBD?=
 =?us-ascii?Q?dFZHflQC5/37sIZg+UWqs6fTldrc42EaO+BKXnLwPBTCl/+NZkQTDvf+yezJ?=
 =?us-ascii?Q?rmsT9RhNuz6D5meAf9Jw2OHvY9H9o61z5q7ZBYEg5m2vSS6bGHq4ogz7tlo+?=
 =?us-ascii?Q?M9zfM7ZSmcMauiZv8lT54i0v3INYycLUPW4juaWi9AJM/XfIBfXDXOdXHmpT?=
 =?us-ascii?Q?g2rKDUZ50bApfRcHkFFPXJS/bhP2Q9dIss3uZudCn+3A8bC5XKDc5FtRc+0m?=
 =?us-ascii?Q?wvqxCOFMXjEfKGCboetMlB6AGh3kIkt2cNALVM95CMIThcrX2trhqURE3/gT?=
 =?us-ascii?Q?65mDRqgajREFbVKTilitpZdP1eH/TukN6r9SpQ9oKAewa+88EP56xOX5QJT7?=
 =?us-ascii?Q?yu0O96rQZH46Vh1VnUQFQ4IpPa1rHI6jwLNegHu8zO2ABRMuvciTo4Xa6vbu?=
 =?us-ascii?Q?k+P19UmC3es/BmcUbwP676lMRpGgghIrFP1dPXtQJSdt6mCGKjWL3Mt9nEBU?=
 =?us-ascii?Q?brMzKVMgChgA1LVtwz6V1Kpu36kunUr0E96WrvvKr26ga+3j6iUsjWP2qSM0?=
 =?us-ascii?Q?ITtmOYMY5A/ScchTTvORvDXr993KoFuMiktdiFolz9/4lvehkP8ZylN5eNtE?=
 =?us-ascii?Q?48FkaD0AQezldp7Xj6pxOtNaV9u8rqrKEpRtdX+/FTLzTOHhlNdThppkhl9t?=
 =?us-ascii?Q?n/1vqi1dY0Fm715BCh/ZXcoeUHPoXnc3hCJVbv7S5Qe9VNpc4BzPhOh8AWhk?=
 =?us-ascii?Q?UUujuuudnEk2WkBf7nbmAthofxMpLJeJKVIqwKNU5X7RWinPxX0tIWNv7As5?=
 =?us-ascii?Q?zK7QH4KHlV9aF3Ee0yUUp6ZEQhn7Ey8rNx7rbZ/ZjjxsirF1S45po06/jaSi?=
 =?us-ascii?Q?gtSrO2DuaJEUn59rPHjejA6S3jb0OdHEQQKYdGnkpbNm6NdCtSsNzU7Io8yn?=
 =?us-ascii?Q?wl6QtJ0y7ROyiJUKc90kMu3l8XJPsnYtDQVnkkiTXHyq18UeWaRmkk+EaBsQ?=
 =?us-ascii?Q?9jLGperAbjKI6FE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:51:57.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2a3811-6d66-4c5d-5e66-08dd4743ea21
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2309
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

