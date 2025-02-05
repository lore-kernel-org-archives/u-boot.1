Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF9C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2613080780;
	Wed,  5 Feb 2025 09:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HvNuuVkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDDA80780; Wed,  5 Feb 2025 09:02:32 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B00E807B9
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JihYr6Cpcs/g3QH2+uVP0nai+ej1xNl4frtluMvmCh1hacHkeXwknWBRGw+5dkqNjlSju5OlYgPLgVmGwEKyr9suqDM+GIlkVxpWU8SMNUhnlk2atZANoVNVXCNFgA6qOI8Hzb3kycW2gIt6ABsi3QfTnG7Q4gANyKbHcAepa5OQ6Agv6XCzP1u2y/Qg19n+jp3N+avY2t/iAYN4hRf1h8fgANCVlP0gpVM3sdVEaYrt43yk3Cp7d4AhmCxlq99UBIRNmwKwm08Lw/K/YTI798eNdTMbU98DFkOb6bnN9rW3JKJ5VGa4dkCkhfI2o5jPrOlHfiBzLxn7wigHG2jnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cnexe/6H+fTdsoxJaXRxA8oc3pk/h7xttEtG2QayXAM=;
 b=WSiz3Ul0N5jgRhgks6gVkUAxGj73hJyJtDTo69WT41S+dnp2WBfEg9WKIW0NHE56Uy8IvYuAvFxyDJ8eDVkuPrrEwsrCa1m62BHOoNHJa0qv9dmiq47x+X1oJu7awmaZ7VnruVe/EyL4PVFRMO50+bh4DMwVhaF36bPq2CPvzgCQ9r//NV+M1S3vrPeM0vpCH/j+A72iLd4F4gfzM/gJdHFWeEKTmWugIUsr4mOwimkxxXAU0nnXd2Ol3wD1Rc7UWe0tCKwG0Ad5hrK0vIauhJ2f6u5jCRkepXW7a60IR+lie4Y2f3NUVLn0OldFH/wyx/gYz4ybCKHN2/Byj4qLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnexe/6H+fTdsoxJaXRxA8oc3pk/h7xttEtG2QayXAM=;
 b=HvNuuVkPTvKUxmkbjijGKzWSPCw6drvyn0xGs7md0KR9A/VkLjzJWsBjsbsb1n+Ivx57gyMIkvyxMS0Qlec+eMUFUsD1JKGCSOmDFTtDgziXNsBuC+7gGDNWYPuh0IiYG5Twd5ubhR2qIWD3IjcdUoY4I3CrijOPeL1ZOqRhbcwwtMuUhoHONau+/NAbzQdkg+/ntWhltn7nCmXj6RFmZtg/ozyCG2BeAT9ljPYwGrVshi7iEMLGAouAavsFU56nvPJz2e4YcjTy3tgLUDZ/C6MKUvCp3LCWRBC52DFRGzw0GDz9yyu2XpuDK4iCiq3kAXo6fmPI4rdHQuTesMQ57A==
Received: from AM0PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:208:ac::16)
 by PR3P195MB0668.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 5 Feb
 2025 08:02:24 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:208:ac:cafe::9c) by AM0PR07CA0003.outlook.office365.com
 (2603:10a6:208:ac::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.5 via Frontend Transport; Wed, 5
 Feb 2025 08:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:24 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:23 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:20 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 05/10] arch: arm: dts: k3-am625-phycore-som-binman: Add
 custMpk and ti-degenerate keys with CONFIG entries
Date: Wed, 5 Feb 2025 00:01:41 -0800
Message-ID: <20250205080146.1944928-6-d.schultz@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|PR3P195MB0668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8769fb53-4520-4553-3dd2-08dd45bb6ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JlbpivvRQvvf/mF96Ruc89qN0RBzpM+eMhUA1JlydC4cjfF2d+mUF4bK+9pX?=
 =?us-ascii?Q?pq7ZMYeuJlBtWpiUiD4NreeZlYWfWE7HHEPNmXbkFpc/BNz3hoDopkdryHXp?=
 =?us-ascii?Q?5WXQwxS207oOP4CUda4pCmJzPdvxhSHO7pHvm89pfb/I9AnUSSmioPjkhGwK?=
 =?us-ascii?Q?Y7j2e7Q0395t7cauwl1IhKDHTQ7vymtt/sQhHz09e1gq+NAbbAwweWzybm77?=
 =?us-ascii?Q?L8XAPnFBcu0qC+H1s+ruUNmHgLZYOW4v3qH6ykWUW7JkDZ+SF4bnVz9GSPiU?=
 =?us-ascii?Q?gyF0wG23j+rgVTt2yIFoVaI07PmTTpqXyCgRzGGBe9K6oKhIhlO9emC1hCWD?=
 =?us-ascii?Q?7dfqZUPcSxmmy5bg4251IqDuyI3pA7Bo/glHlX+tvdv9Zpz42punAK5kkxIh?=
 =?us-ascii?Q?Hbar+gK3Vj8rHcRrOxr1wvWyKyLwSSHUSRj+OLfrG3ryE5JxaQ6kTqbVNu/Q?=
 =?us-ascii?Q?Y8LPEnYJ3HWUwZQeZwY8K8ni83oztuhjlbxubWl0/9BKYkLP2eAITwzzcyAf?=
 =?us-ascii?Q?p+IxvutnjSJdjv0op2+UQjUbDwLXVFkHsVveHdZEwAO+CuWCsW5FYKsZqM74?=
 =?us-ascii?Q?peaoHRWDLP+PK1KO21CX+is0X0rkM7So3stEhsQ9fy7ODinbwvRnvfMZlBn0?=
 =?us-ascii?Q?/Q9idJ2eIVohDT6svK9Ap/LTjK6fASVVwgqeNt6m8rqnUu8lxUqBxwWeLTSe?=
 =?us-ascii?Q?Cu1NJNSjlF3ML3Z9buy8jMCHdNV6ITsfZTzgfAYpopblvXOFSme5kbZZEg+W?=
 =?us-ascii?Q?KweLn18oNDolOvuAHxWtvDHiYM3xczM+8z0dpyeBo5QsrQJP2DMWVyyJFYs0?=
 =?us-ascii?Q?nZ7V4j48xa0yA2JjU7dkO8mC5rPtlafeiIBeHSSFtYy4qiCFpBjZ77me0i60?=
 =?us-ascii?Q?QmUrF4civw3JdxTxFXA/kffwFK+WvkTo1HxqsZ0W8op2TJUdytBxGXjomqhD?=
 =?us-ascii?Q?BxqzJfxpQy957L3bBOL1G3Y+O1fgUfzYDDCNDkLxw8g+j10WJslZEnKrsgx7?=
 =?us-ascii?Q?cbp+zVbfv4nBQoGx0IJZ+NBVMoGQNpjhjQnylJBu87BrD4hul90UUNrOUW39?=
 =?us-ascii?Q?R7U6yCsgLuuwV+QgxFkmH6vIDKnaRUnXyq2VBIrRaWR+iG5x9NDHekseljuF?=
 =?us-ascii?Q?I8Q9MJ7NA72WO+i2w2VQ7lz4OioZoc1CGIm+CW34iroD1fjpVchboAiHsGIn?=
 =?us-ascii?Q?UvaSuWDjUPg2fHnin+xP2lGgon8Oxr4c9vweEvDRjEamM8JgpZbk+0cMIIkE?=
 =?us-ascii?Q?NMjbBDCSBDB8H3b2A4+a/+gs8NuugwH1bEa46PfaGtZI64qks1ULFMvAAd5O?=
 =?us-ascii?Q?zwrGbwUr7bsolm3FbodJu1eIexB/FFYNYfACb2X8ZmaRrpVtqL7XAYxEWY+M?=
 =?us-ascii?Q?UGcf0HZMN8+J1TnDgxuCwX+0dRq0n6/lR7lr5mjiJHS4i9EFo+AxfbdPJS+U?=
 =?us-ascii?Q?vFyjQYqo7XOaHOE4hAYVbLUPgzpLl0GgYHm/XUj+E+g+gYkm4jovZ7WmWpBW?=
 =?us-ascii?Q?vohP5DUeisWkj5k=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:24.4067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8769fb53-4520-4553-3dd2-08dd45bb6ce1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0668
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
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 72 ++++++++++++++-----
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 31456d23167..9682ab532ed 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -8,6 +8,13 @@
 
 #include "k3-binman.dtsi"
 
+#ifndef CONFIG_PHYTEC_K3_KEY_BLOB_COPY
+&binman {
+		/delete-node/ custMpk;
+		/delete-node/ ti-degenerate-key;
+	};
+#endif
+
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
 &binman {
 	tiboot3-am62x-hs-phycore-som.bin {
@@ -18,7 +25,7 @@
 			combined;
 			dm-data;
 			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
+			keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 			sw-rev = <1>;
 			content-sbl = <&u_boot_spl>;
 			content-sysfw = <&ti_fs_enc>;
@@ -64,7 +71,7 @@
 			combined;
 			dm-data;
 			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
+			keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 			sw-rev = <1>;
 			content-sbl = <&u_boot_spl_fs>;
 			content-sysfw = <&ti_fs_enc_fs>;
@@ -117,7 +124,7 @@
 			content-dm-data = <&combined_dm_cfg_gp>;
 			load-dm-data = <0x43c3a800>;
 			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
+			keyfile = CONFIG_PHYTEC_K3_DEGENERATE_KEY;
 		};
 		u_boot_spl_unsigned: u-boot-spl {
 			no-expanded;
@@ -172,7 +179,7 @@
 			core = "secure";
 			load = <0x40000>;
 			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "custMpk.pem";
+			keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 			countersign;
 			tifsstub;
 		};
@@ -210,7 +217,7 @@
 			core = "secure";
 			load = <0x60000>;
 			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
+			keyfile = CONFIG_PHYTEC_K3_DEGENERATE_KEY;
 			tifsstub;
 		};
 		tifsstub_gp: tifsstub-gp.bin {
@@ -227,6 +234,24 @@
 		fit {
 
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
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
@@ -268,7 +293,7 @@
 				dm {
 					ti-secure {
 						content = <&dm>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					dm: blob-ext {
 						filename = "ti-dm.bin";
@@ -282,7 +307,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&spl_am625_phyboard_lyra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					spl_am625_phyboard_lyra_dtb: blob-ext {
 						filename = SPL_AM625_PHYBOARD_LYRA_DTB;
@@ -313,6 +338,9 @@
 			images {
 				uboot {
 					description = "U-Boot for phyCORE-AM62x";
+					ti-secure {
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
+					};
 				};
 
 				som-no-rtc {
@@ -321,8 +349,11 @@
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
@@ -333,8 +364,11 @@
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
@@ -345,8 +379,11 @@
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
@@ -357,8 +394,11 @@
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
@@ -370,7 +410,7 @@
 					compression = "none";
 					ti-secure {
 						content = <&am625_phyboard_lyra_dtb>;
-						keyfile = "custMpk.pem";
+						keyfile = CONFIG_PHYTEC_K3_MPK_KEY;
 					};
 					am625_phyboard_lyra_dtb: blob-ext {
 						filename = AM625_PHYBOARD_LYRA_DTB;
-- 
2.25.1

