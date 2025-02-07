Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98030C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEB4807AE;
	Fri,  7 Feb 2025 07:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rTChDGt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0743080812; Fri,  7 Feb 2025 07:52:00 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98139807F1
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOYsP2CmppN8AOig87cXxKXmERchPB1fNNqB886lgJeifBe7nGuc/vaoWfCOAa3zCybxUI/Gy6tWBN00mJ3QNOG8PoBhyddLiIb1gz/87XBPTXxrdStJ+OJlJNfY+6U3xkGpedPQ6JjnndSwmx6SvIDGgoctpUazLqxyMgI7EioO+axq1YBxJnhSkM7qlKeYutiZoajrNRoptt2ni+TUs1bxanY4jhxjzzEStxqwj+grE8w8Q9LOc9yTymurCD8XgiLSVm0JOxk57n+B2cZftjJP47l66CHapPSLY0pTSeKGqnd/csOIuh/KMfaW6XbGS9CnawShHOvoYweE6NPm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cnexe/6H+fTdsoxJaXRxA8oc3pk/h7xttEtG2QayXAM=;
 b=g2bo4RUxI71yef4VPmvGioxhNHf2pnXWCt4lMvCjWsIQIFg+pXoVBxJqdA4bSX6PSvMqYdzJxxYKbkUptsrfe3XXDsLTfifC+Gf2q2JZNdTCh5AIdUdse60xUvc6OXqYpsX6oXgN+ubt5T0EuPboX2ikPMwb3RcvJmYh/zgLJeyoYh3qITHrCzr+p/3w58ESrc6eHRwC4/MXELphDr+T4NbCH3Cy+/YXeyRUn8+rsQWkxiaO4vBWizf7H0qYy80JDAFFPB1e0PLRfZ6/FgwRkcCrRkfXDK97aPw3GzMChQHUmYzBekgHW4HCC4upuQpoJe7Ib9W2RK3Szb2aS3cOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnexe/6H+fTdsoxJaXRxA8oc3pk/h7xttEtG2QayXAM=;
 b=rTChDGt+JFYeb0/nmE6GalQDm1J+V8FSpc42/jXrGJNu4TcBTkBsI/mvjPB7XlJuLbl1OqTt9Ei56jxg6YkNnJDtQ+qY101oniWSo+8Lzr96oQxUbzzcH56LWGIX2WwN4dxzKxhj+PLSLJKqrz221YybLfKCQBo0nGeLMWIg2Gj4QUxZOMYpOQOL7ID71/75vAdqUI35wVmvwatE32PyElX3wmdlyVwMmHqV4eY86eGzBIyu097RBz7Igi1oxdINlbiL4IST+VorHxX7UtKL/JI6Xe43P8ex9qq4dZEeiqxpGpQaRlaI9IQZCkH+vJmp9cPK6qWGv0IqQMOJXrrZ2Q==
Received: from CWLP265CA0429.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::15)
 by DB8P195MB0709.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 06:51:54 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::c0) by CWLP265CA0429.outlook.office365.com
 (2603:10a6:400:1d7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 06:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:51:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:53 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:50 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 3/4] arch: arm: dts: k3-am625-phycore-som-binman: Add custMpk
 and ti-degenerate keys with CONFIG entries
Date: Thu, 6 Feb 2025 22:51:21 -0800
Message-ID: <20250207065122.2495923-4-d.schultz@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DB8P195MB0709:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bf8684-db4c-4af1-d948-08dd4743e7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75a7HoDySh7Tjx8WBIkRJuaEVYv3Q6lBQGceakatNOjBPN7hLHFnmW5cwXVw?=
 =?us-ascii?Q?5nIaWTb3e8CEhYrfU61eB0q2KY+XCa8EJPgqgM5bNWpuM+cSHlPdzzebVE8V?=
 =?us-ascii?Q?T//FHEy/m+t3vlfh/CpbUjZmGL/7pcjVgfe4xt/t0ONRfyPWU649hMLM3Vxw?=
 =?us-ascii?Q?zaTfr9KjQ8D4LuH2dBZYiIDj9F1A6VczjgDlrAqxGhXJbLFFhwahzyziCaFD?=
 =?us-ascii?Q?lFDGiv2+Ca3y+EcywtlfJ2rWgnhaGGWEKoSntMmQ5D+CxoUBgSniMTCfFCPI?=
 =?us-ascii?Q?8YkP9HbZQRxNGYjXcglaspB18cBAaIFBWvdhtIbdQp0+sdKn5UpMwgH1NlIy?=
 =?us-ascii?Q?UqbnlxZAqYD8tQNm5wTzz/+HHzEeUgwIc+XtNSmFjRLOlpwAteQECgC6SWGx?=
 =?us-ascii?Q?P7xQxD46Qk/S+6QBC91N1cptNBfDHU+XmfoOB86MQAM394TmLbFawxb3BNJG?=
 =?us-ascii?Q?H19MquFq1CZM8RiifrdvPT+FpAyhjOOH4FFVXGF+AyKb6P+8SyOxJ29SbvPW?=
 =?us-ascii?Q?VRgq6aLhpSNfwfE5yZkCkO7JEjsClWC7oTFAAgHeTh3RLGrJeJJsU66tqCvi?=
 =?us-ascii?Q?7GVET2o111AfyDSZfOmZiMZ7uKncjpqhexEM2xtpMnD483i5e13Hk0Uwc35X?=
 =?us-ascii?Q?mc6gdb8ixta7mRR4lLTAsnWqgde6wBJnXRwLc/d+CBK+482AIz6M1PbPlGtg?=
 =?us-ascii?Q?UYXj5MFVhAGC9qZqQZKuPg23kOjTgx2BBvd9MWN7dONnWBP3EYBNsO51YBNP?=
 =?us-ascii?Q?0NKY/9P9VGfpVHDGdpUpIp8oivmh5QcLWnx4Qc4zBd+/+Be1Mq/TwE0wRqX5?=
 =?us-ascii?Q?BYNu9XuMps7x5KXP0KLPmYCFjaipzvg2ZKRnIWsf6ps+YyGUJb2xTCRdXyOo?=
 =?us-ascii?Q?4vy2PXwbNfybrXHDH20+rVW79MQTyJPOGrN7huSWsrlIwLXbPuGtGRbSNDXC?=
 =?us-ascii?Q?fG/UaeSFsnsz3fpiRkjLDTeW3DTYrc6Vg9KF4I+7oAt5k1u+bGhuAJlLQj5e?=
 =?us-ascii?Q?mJ4Di8ZOwCgKgM1aNfncZUs74Xf3Vu9ksCnIFW2zzOLsBeMJ4HeQvtEB+9UR?=
 =?us-ascii?Q?HjqYs6h3ro2fvUvPsmvkzNdIbP/HOvl5+fCCkkyudPJbdk5iHCP2iFM9alem?=
 =?us-ascii?Q?ZhU87BO4Q44PTizz8dQNj8IF/jAocqNLtx9wgs1kpLkjGWERj8nLo/lEq8vO?=
 =?us-ascii?Q?mDp8WZ0Wp2oZgHqowYWAmSczXyOvxItp51VR17TyMCY334NPZK4y6VQZGHfC?=
 =?us-ascii?Q?jlvg2mIHsGlVe2RMXYVxuacIn4B6YxsLoJcpR8NtuwAp0amAoZXD/3c7zyaA?=
 =?us-ascii?Q?ry6tXbjoxW8yiHErwjQRe32TDTtZk8sVrwRG73g+vyy/r0KcJZ05w+Lx8gUV?=
 =?us-ascii?Q?mpUAVMjY9baussTmHr2hqN7SJyQU/LM4pYwEXNDjcFCO3gAS6icTIwT6G439?=
 =?us-ascii?Q?FnQxBv+0owEdtcGEpzwSctLyQXl0W2fVZ1vi0yPa9pc5A3y9hKGUjBYYR0Ud?=
 =?us-ascii?Q?Qzj2AsDzS4OgaMo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:51:53.6261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bf8684-db4c-4af1-d948-08dd4743e7f6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0709
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

