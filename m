Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29E5C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 07:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBB0805C2;
	Mon, 10 Feb 2025 08:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VClF2EGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3A680548; Mon, 10 Feb 2025 08:36:44 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D2D801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPZ+2enPz0KWpI6Ap88kMeHdrxDKZZ548UAQafSF3ZenSYczUfIh8i77P++ZJ8Ayz4yvf8itJ5V4guOZJb7teS49GxyeJdEv5U03or03jjG3eWKIUTwGSdhaBdjdsFiJMUy01L7TR8zxGuEfQI4KGoK9IouXj0jZUM0XZ8Xvgh3qkrs3THDELyg0jV/70MuBsAspPRrlO4TNbvJUE+5/QL7Q76YujUy8GYuQGWtLRpEP8dCEimTtOOP7JnZGzNYon45XXg5BSmx6raR96EupQeuvmSLdU0Q32MYdozjjTc8T6hBpukTwgwKRor6dI2j9mpcEPDrAjyaEUgvRyu5XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLJMFwk3wrhJjJRHHHzWVu0eZfd09oFxFCjbDYgsy80=;
 b=LyUm9/RxADQB5CcfcSVIoHL1SNhGN5eB8DJSo1af2AnJd94V8vD2ngpPdW0C12wLBL3rImjPauOoVMaLUVTZcNuG2hpxwCgzv/zFfCsUUpzRMBgwr0cxRIyW+vS1D0e/C1o9ebf7WasXJKknGTNv8yA+BDKeks6qaHYE1vnlF7Pa9uxZE2hFWQY2ZGzSWSJaO3ihCXkwa/V/f4RIZGFjj7P4RrZMHxadlOdAt/9WEJuFztzzL98Y3df50Gi3DUAyj8IajQWROzIOyL0FgbG0VI4Nfey9097Iag4PoKvNpLo3MTQi0O66ET0qMrNAXh8+I3wJL6A/HAkDd3l0n+hfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLJMFwk3wrhJjJRHHHzWVu0eZfd09oFxFCjbDYgsy80=;
 b=VClF2EGOZ7OX2SUFFYe+YOAr/s75wklb6034nticEgMFQ86c94ifRz+UnCv3MH06N61fnf2xVKPOBmXQxf8yF7CJAl2a+K5Qh8qlRwnLcAY0/Iu+HwdlwBV8iJo8f7KRLca5PT+V4EDpgMpXG+kO3UfsEHA7dawjMjTioU3YpyL3zM4S5X+ON3tfjDj2++h0yOqYn5q0phA5HkLrYps5ZK6x2ZoBjz/dTFk1wTchfaATixZD37CFjmh8Hc4hLnJ6EPS3S2w6UKQBuBj+bZ5xXrHLzRj9QalbdydjoY1VhN42e1FPhS13YqXBVJzi4BepDo+uulA/hpvNXYd+jRUh2w==
Received: from DUZPR01CA0224.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::20) by PAWP195MB2447.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:364::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 07:36:39 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::c) by DUZPR01CA0224.outlook.office365.com
 (2603:10a6:10:4b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:36:39 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 08:36:38 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 08:36:36 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <d-gole@ti.com>, <nm@ti.com>, <afd@ti.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/2] arch: arm: dts: k3-am625-phycore-som-binman: Add custMpk
 to all images
Date: Sun, 9 Feb 2025 23:36:22 -0800
Message-ID: <20250210073623.2994856-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|PAWP195MB2447:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cfcc7d-05ba-44cd-4454-08dd49a5a7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?824uhXFFyz5o2WTTFWPm/uC73BEl846aNgJuJR+ByFASCrP15ju/iKoRp9hS?=
 =?us-ascii?Q?/cgKX71R7sg7IFEfFSX6JAiO0A3dd7Qt5bpzl+8MgUqZgMTPDxurFUBk4WT4?=
 =?us-ascii?Q?YEaTDWI0jUF7XiLe5qxQOjMzaeTBhHvh31sAOMJzc60qjwEkIOn3EcXMpnom?=
 =?us-ascii?Q?10RJXCO6T3IAbx9fgaMCvjWN2t5xCtHePZJhkH9RFc7WKflk3DqJEl0r+RFc?=
 =?us-ascii?Q?kofpTyP3RiBR7ilkPqfln7ctUch8GK+GBDFGKBUNk4YCsRzTLjajc/EOwPkS?=
 =?us-ascii?Q?B6fTbbj6qSCnGJaMJxuFgIWumaRMYW1VGBy4TGkTaPcoXz+9dcGdi5LZsW71?=
 =?us-ascii?Q?oh3WJjx9OTfrO1x0gvN/CgtGxh11IEnVsU50faGsUo5MwTpP7I2Ba7HjEe6S?=
 =?us-ascii?Q?NL9ofsMpXlq7YbkUdYWYRawJiMDsqDz31fgI1CzbXW7hbGVUKa54sDokqPRh?=
 =?us-ascii?Q?OxcuOzIeA2KgrrFqpc2QlELXMBiF2Z/IrvxP/ergY/qIGbfmRxsd2jcoL3mr?=
 =?us-ascii?Q?jOV68hUs3GFFujbWlQx1wyGqBSgLEmdv0LHj5oQRuypoqVOkW8HQa3JBYPyV?=
 =?us-ascii?Q?00ClCJEMsFQq1ICJBo//r8z4WOIQ5NKTUY3GjJL8PkJ2kkMQ3kbLGXQwKZHP?=
 =?us-ascii?Q?fEx10Kddm93ny8lk/KsLFJXA+j89ph5YQS/vTGGjZd7iA2oyFOqXXEOvoZdl?=
 =?us-ascii?Q?BchRGoWghJ9O1Wi2gGmDDBo4o53ROU2t3htxvFhcBgK7/diyRnA5iQJttXd2?=
 =?us-ascii?Q?gdpgCxxyOTOxoBdpDqZd4NnR2hU2ZXNh/yk1cFhm45KYLfsenl3f1PlaMxlA?=
 =?us-ascii?Q?Ve9qnM/H1/uMIOxcZGsLqPFVB6vvWQiCzTMa/cHOdvkiwQ4Asm5ixIxg4MhK?=
 =?us-ascii?Q?YP00ZOsPp8kB2TaTEYjXR3TlqASsPIad4i1OEQImPvyA+fTW5bOOa400alcP?=
 =?us-ascii?Q?fVr27rlRaXbwNPYtJ/6VcTnbqgvKEkZhGWjXde3O3AehQYSJwXP7gGgq2u2L?=
 =?us-ascii?Q?A5ec+01ZEC5r/s6msZAKYaxdTIWEkq9UrD13decvEDhdChyygmabazF2LdUm?=
 =?us-ascii?Q?EEYv+D4zUCtMy6kFY5K/8oYDso3FHNXMBjS31LpT/xaoIbN3huHJT/OrSWeo?=
 =?us-ascii?Q?lToc1U6oGqd821goiwSS1EdYAVwkgfv9bVUplc5L0mSvCKSB6BK9pY9k1ASF?=
 =?us-ascii?Q?iKWuddTTOeFz1/S/2wLcEbGNs9eV++8QlSMHHkSlSvXx0ck8qOK19E7xaHWC?=
 =?us-ascii?Q?VxD8zBROHZuu8pJn1dbMP6g4qWf8ud5gndTx6upKeKBAIaRNcvhRPZNcfb+L?=
 =?us-ascii?Q?Ox79tPtsIjiyxr58szH/Y2otRLt3GsYmNiz1af9KaItbF1w8G5+mi/20Xh6i?=
 =?us-ascii?Q?wFYtKuuTtmZOJVpzNqI8IQMLIF8tVKUzE1mcAzK+VRCOWKFCJzDWOyUrjGq7?=
 =?us-ascii?Q?WMyaesTVHOKTRct158T10dOhIx6M3G0VJPkWaKZMz/240WiKLAJKVf7TyngJ?=
 =?us-ascii?Q?Wp4/qSeK/iXzO7s=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:36:39.2587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cfcc7d-05ba-44cd-4454-08dd49a5a7fe
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2447
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

There are some device-tree overlays and firmwares with missing entries
for the keyfile. Add them to sign all images in the U-Boot FIT image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 49 ++++++++++++++++---
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 31456d23167..7c72da6deda 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -227,6 +227,24 @@
 		fit {
 
 			images {
+				atf {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
+				tee {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
+				spl {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
@@ -313,6 +331,9 @@
 			images {
 				uboot {
 					description = "U-Boot for phyCORE-AM62x";
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
 				};
 
 				som-no-rtc {
@@ -321,8 +342,11 @@
 					compression = "none";
 					load = <0x8F000000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
 					};
 				};
@@ -333,8 +357,11 @@
 					compression = "none";
 					load = <0x8F001000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
 					};
 				};
@@ -345,8 +372,11 @@
 					compression = "none";
 					load = <0x8F002000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
 					};
 				};
@@ -357,8 +387,11 @@
 					compression = "none";
 					load = <0x8F003000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
 					};
 				};
-- 
2.25.1

