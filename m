Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8A2CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27156836F0;
	Fri, 31 Oct 2025 08:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="raK0o4Ah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C129836F0; Fri, 31 Oct 2025 08:38:19 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6368331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojDrHbjk8nAxa4oxKvydhM4AHGAOQAM9UHJ7rPh3TQ3cFffa8O7ln8eRYIHFlX0h2ZbwRqbZKApSjwzyVzHXlTydUxZwUg/6fZO0MxIsSbe66iQcdFkJtnycDXQ5YRpoUpgy96NU2LdooZG8ySm4tGDrkj3z/In/yn8INrsYXf7xn9YUhlY4Lz86+6vo3EsB+5gVgGtSA7SFAcoQyIqP3dpD4dcHfMjbbd9z6wySruv5ABFmgT5lN65oUUWTYMTCTGfApKQQJuiPrdRACjfmXbEw1r0n8sf+5DkhwCgBOJ+xdlB+VxtHyqzlL9SzJc/IDYdDhcapCNPNnk0DGX9rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ9PSE0oEV8LYVNQfuvCaVIQi9Ktfgm4kHQ6rApuoPo=;
 b=L8JaDnE/6rv/Jf0NQEyTjO4a9qkpsz8JtZf57VoIYP7gGAvHqvCZYdRiv0M6MFnuN7Dj+LNS24Gvgl3EdAeJ8RIxEGttwn4p6SjAhD3LgB+/O385aRUltrPNT7hO8lsOmctNzbTzIgcZ1A+08+mxnh+xLNjhbTY/dEm/OJ+NxdKtDpBIyoVy7VykHmGJUCkWTgu45teCvrCHfOWObRw4RMK3VvXam83rl+L+SxirLT72Do6X+PhCXyu43CONwZjs2fNmHyN+Y3bmYrWWMH5RI9nu5L1B+ZpPU9oUJ6Nd7ykRyQkI0mSTSx+p0j5OzjdgXaGW6pzoVJq+ZKnSozT+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ9PSE0oEV8LYVNQfuvCaVIQi9Ktfgm4kHQ6rApuoPo=;
 b=raK0o4AhdMPaay83BkjgV+GS0XJJAVvOQO4cLoZLO5bXZ4Y4uOH4u9wtfSBIUME7Gf3SdNopMwoCzAP7Wmx04O3YL+ClChNo6840EyvigvV60IoLe2E7G3Nnl7NdJenvDoWPRUp3CEFFVGLduWcPNDKWwtJh6Z2tc2YQtw787mo=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by CH0PR10MB7500.namprd10.prod.outlook.com (2603:10b6:610:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:38:12 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::7f) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:12 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:08 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7c7bq3539890;
 Fri, 31 Oct 2025 02:38:07 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 1/7] arm: k3-binman: add tifalcon.bin for falcon mode
Date: Fri, 31 Oct 2025 13:07:51 +0530
Message-ID: <20251031073800.344500-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH0PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: d012683c-b116-487d-ce20-08de1850725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aM9Yeg8+Hmg+nXjGQ4s90X8ZI7z5KVXgy+5r9cB6oCwq8hTSuarHBvMdU4ef?=
 =?us-ascii?Q?9+bmGTC8XgF4cDcu87CsN6r8zhfwxhsl5IbVFnzZy0DUBQPqezPyDsxWP4ZL?=
 =?us-ascii?Q?r8hjfCp29icNthabpBg25wLzT+VvFsSpaDOQdGOWYH7k939MAOnR51J4lO2k?=
 =?us-ascii?Q?6fjl4HZdDvAxWvvnuLYcyphQQQV1XzFekn0VXW6FO2N7aTyMBby4Lgzu7Apr?=
 =?us-ascii?Q?Z+aK0eui97FqMLQB/9vaUCcPK36WtqIOQAaATbjwD5uiZB4+hm38u8m6KoU/?=
 =?us-ascii?Q?XvwnCRkwFslP/uigEzSSWi4MtuR+pio2VrOSGAvhkrBHywyMcvuzybuDl27N?=
 =?us-ascii?Q?IG9hVT9ioA3i5bTsYYbp44VFU8ClIwhur2YKqxBQy4jR5KO/KTYTOoGxlPWH?=
 =?us-ascii?Q?oEpa+TnW9/qGShUYhP/D7dSo3v4dNXtOoU+LiGG+vr/9DdmHnHk18pi3S0r9?=
 =?us-ascii?Q?ZriulRnj08uEvEvmZq8YKFhkN0l38KF9xYpx6vTvCwKuUfx3gZFUMNA0C9fT?=
 =?us-ascii?Q?HNjWW3d977eWHxtdkRtx2WX9TCb36jU3wqADKEMPkYbHgDoNsA7AsccqvL4n?=
 =?us-ascii?Q?YsJJIxdUiut+xTiI5ppAmBLqRA8+aklk9WpIcO7AuuSxyU7pgXOhBmfuOPzU?=
 =?us-ascii?Q?kcmpMRK2Gs7yveUwszgQe7gagJuovmhl2l9akrXdy0MBJj0L0yYyPdH8Ubw2?=
 =?us-ascii?Q?DKieZadtnMi3iBjzpamwAxM/kZCyrfhZyso0lo2NlxaFe6LMdmmPYDkiqAd1?=
 =?us-ascii?Q?t3x9+CCgAieEb93LW/HNN+0uYScMBMUStuwjKVdmIBIFWG71lfPr/Cq75BJs?=
 =?us-ascii?Q?W5RL/hzO3lv1G0klgwdlCZ8gUtQ5n0MLyNT63sw44Bm7JBG0qlzAmE32GFte?=
 =?us-ascii?Q?Fc5E8dY31PzGUS/RTrz2AnIrdfCjmXHEmtHzv2EyFilDgTZju8OjJP0hdYGz?=
 =?us-ascii?Q?Oky62pCd3F2MZD6O8uk9zkkWal6IOzpqZPeTDdd90BahgWRxc+gXs/6mgfNX?=
 =?us-ascii?Q?2SgzyTEmxMaD9w4OMG657y8DFrd+zk5JqEbeznHGUKNCnNgRxKESilnXYhqv?=
 =?us-ascii?Q?bsRPxJi4gawFBTtTj2TJq2LLy2g6ydmxYkYv7QrVQqqYlqip8wLa5StAIwAU?=
 =?us-ascii?Q?KBCrUPoFDewM1JX6urcp4ykgWP+rCrpG3d8xKlo7tlnpyXdqTG9aFOmysIyt?=
 =?us-ascii?Q?aC/2E1J92u30eu1vpUo99WQxh9IakJpgZVcOEzxf9L7fFxqiGD3hrXV9Uqxe?=
 =?us-ascii?Q?LkwkmxSn40LHV2FyoweyUBbOv0j14MHmO5ZN/6O7bv3FnJienNnLG6ph0IJi?=
 =?us-ascii?Q?Lt//b2Bj++lSnKv2XLdnEOq/m9+Nsr0GP8bWrO784j1oSiTURbhq8skM71sD?=
 =?us-ascii?Q?/wFFHljgioq9Yyr8mPQCHLrGTHUiTFs8oWsYeMFYgsuZjJP7whHeQGE0dprC?=
 =?us-ascii?Q?RrpEXSCQF5iBoXNiZMPcsMxnIrCvno533cEjITzEsIFc0P93biWRkIBYbLRF?=
 =?us-ascii?Q?d8H4BADGDPilKRf9dB/vuDUGPaaSPelvFd8cyZaLfUzdMv+cwfseXk6zkQUp?=
 =?us-ascii?Q?6qSlwfoPgzASAPUwBLU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:12.7694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d012683c-b116-487d-ce20-08de1850725d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7500
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

This patch adds creation of tifalcon.bin for the AM62a, 62p and 62x.

The contents are the same as the existing tispl.bin but A53's SPL and
the FDT have been removed as they are not needed in R5 falcon mode.

This reduces boot time since the payload size is smaller compared to the
regular tispl.bin.

tispl.bin    = TFA + TEE + TIFS-STUB + A53 SPL + FDT
tifalcon.bin = TFA + TEE + TIFS-STUB

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Makefile                             |  2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
 5 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..d01cbce8b7a 100644
--- a/Makefile
+++ b/Makefile
@@ -2470,7 +2470,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw*
+	       imx9image* m33-oei-ddrfw* tifalcon.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index f743c4353b4..42edb35fa7b 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -206,6 +206,70 @@
 		};
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am625-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+					"tifsstub-gp", "dm";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index e3a2d155d51..cb9a56b8c37 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -144,6 +144,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62a7-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index feb59edcd83..e1443d6226b 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -161,6 +161,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62p5-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..761b1730464 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -489,6 +489,60 @@
 		end_address = <0x0 0x9fffffff>;
 	};
 
+	ti_falcon_template: template-9 {
+		filename = "tifalcon.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for falcon boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					ti-secure {
+						content = <&atf_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					atf_falcon: atf-bl31 {
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					ti-secure {
+						content = <&tee_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					tee_falcon: tee-os {
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+
+			};
+		};
+	};
+
 };
 
 #endif
-- 
2.51.0

