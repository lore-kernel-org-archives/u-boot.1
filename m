Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD50EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA5384118;
	Wed, 31 Dec 2025 18:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YCMuP+f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B9B84132; Wed, 31 Dec 2025 18:37:05 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A88840DE
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivgVkUvRQwscTD6Ymd30x2mjA8AdPmf6XE3m3Ix3vOHc4HNaJgqeAeGEO11noSNa7zAwy1Ve4iNTCuluOq6bUHYZROt4Uz5ex99tLGCp4CQ5H63fnykfSqNh/4n7lziQXtZCk7et5Hc0x4svBD33K2HMkZ8b0QIa+iS+GPNNPQ8KN1+4o0Gy3jEBghy1JOcnMfNvL5hiwjC19teOVuy/yhOJkH+2Px/Ilto5ecXV7RcYDuf/EXeaxzhBLdQeC9PQiAHJDcs07egOzpnwHQvu5Aau/EdcyljR6QMi3kye76Pz/sNalFKPhWkl9GO3Rdkpl9qqgRT5fcYteBpIDtCUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjZEJx6sUkY5GTnEOQgGWYzf9Owi1eB/M2ubjBvO170=;
 b=u194JGWEwD3Ngssm9D2WfiURAvMC/L908LGXO5e8gFOV3cAvKfM9dBK+12WMAlaT7LDnPkTKs6wQHbKN2KucwtB8FxafQS1uOdghPzdE3JQESA+/oMq2Yqt9mDdAIb15jojrwWHj6JuGBmojokeM2qBpU4NgEUEefedpXfWHaTZ2OiUpfSSLeBFcOKZAcOrwP4zlIkbbYCzHZNGBALd266Tbv8i3Jw7CVagkaSPvOeJlQcUfthLzilfXqLyQCs8gd3TFFL/TK9gHNxXmroC3XSfPiL++3UD33OmQi187W2TSVLJ53gATuCGWvawImDt6Agmm79+g1Hx7u++GFkCPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjZEJx6sUkY5GTnEOQgGWYzf9Owi1eB/M2ubjBvO170=;
 b=YCMuP+f2URrNvwZBdZvNiZVEPq5v0QCtHrp22iXNnIsf7x33QgcARf0b8XwIu7HUZfrx8bojZeC7VQ1hN7WPh6oMSp6aLiONt4rbg0s40i4SmeDbK6370lDtqQiPCsTRr/zlHujE7ue3LQnpavMn59RSvPOcZ3wohn7gfgED8jc=
Received: from MN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:52f::13)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:58 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::44) by MN0PR03CA0011.outlook.office365.com
 (2603:10b6:208:52f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:56 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:49 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:49 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqv2541396;
 Wed, 31 Dec 2025 11:36:46 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 06/11] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
Date: Wed, 31 Dec 2025 23:06:16 +0530
Message-ID: <20251231173621.1069988-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ0PR10MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 78460851-c145-4522-0386-08de48933201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZqIIvDs0FxSWth8/oq9TbQfH1GkkRhNbSvk2ZILeAYNaXRVm8mGZ2nczQc2z?=
 =?us-ascii?Q?6Hrykd0LIcpZ+gMWsHcEOXOF6Em50kwfSrbdY7KaZN6xdOJrhklvYY6+R11C?=
 =?us-ascii?Q?pkmosM+KUyURXtHeNvePVLzt0H3iURWt7WznDXE0Uy9s07Hgu4gk8Cort9gH?=
 =?us-ascii?Q?n4UUuLHaZquNwF/OR/q7hECGw9THQLK7rK+UBSkZT7NZqnjBoB3mQT0Uxyue?=
 =?us-ascii?Q?MKXsV6Rz/7bvydipdB2SVr4jIOSEt+uTkPiI0LlzEg4x2ttzQdT7gqCsvTSZ?=
 =?us-ascii?Q?6plqp+0dm71exPelKw/yA8XnjEp15kj1pFQRZ+SOV7fwvZMbO5wJ0KDP6ALf?=
 =?us-ascii?Q?+RYfghadHN4n7rMHC4GeYhRtaWjMJTT7ovkXaP6WeISy4G3KCc5i8UUTzRBz?=
 =?us-ascii?Q?pZ4NT0dEy/+TqZOTY/avgVhGRn3DYN+jfwbCfG7ocJRZpdJl88ytqjmmVyam?=
 =?us-ascii?Q?JQD3SNxB5TtrxdxOlP4lC3JKsc9xbSZlTez9/WzY32v775xhev8eYyb8LPZu?=
 =?us-ascii?Q?E4ABx77FjtyW1ShHXHx9WElDHdsChz5wfxduqg+Ry6aQ5c5VsCZU+KiMueoi?=
 =?us-ascii?Q?aOyqu+lytS3ukaMy8A7DkEYDapHWnEjnnq7prkwOtfNL58bMkyOn5ZKi/RsW?=
 =?us-ascii?Q?O/kiFhcZ2+kSoXjXhu/OSEBICOKLhqaCT3TGlMFDebi2qZE23BYRenVX2tlS?=
 =?us-ascii?Q?aqXvJdilLSQb4XGoE79LAfr2aMTu2yKSkGKEabZRnOKEP0F0g4KDzdxXJKgs?=
 =?us-ascii?Q?YiY4gP7UYkOBOxJtsjmS+Ckowr3oh7FFC5VHGW6ZBG3E9k+wS2rIUuUlt3zr?=
 =?us-ascii?Q?3lBON4+D88P+I7728nNuKPj1lgiWlJqZeWLG5I58GOd1dDGB0MYYwxJClCJ8?=
 =?us-ascii?Q?OuKD21DpYN6FHy4qOl7iOf/pepGFczN5llnkJD5HRhmC6HIkoqvVgT2r4+1y?=
 =?us-ascii?Q?3+9nB24UwZUmCJhqN1Z67/+O1k5DQp6EvWgJALhjqKxHv+wzh33yFfgn13aF?=
 =?us-ascii?Q?JlNLUqMcIcKVFo7Xwy2yW4zA4EsAcbR/HK+vACCqudXfiLJ94NkIru00GkqO?=
 =?us-ascii?Q?WdpQ72yywEuSRew5ZFo6kwdsqLklpxQ0QW/hbsDUSojlW/Dg6Pi6T4taqu9J?=
 =?us-ascii?Q?1wAE8dcQfiyMnm9i26jNu6hHNjD/f+3FqFlGOrzHvc50Mt+92oQRTKHSQ46G?=
 =?us-ascii?Q?VzGfN7r1Qd0Uv8kIJDn3GEHc8fCc970/EEpdrTCEZFcvSBb4HB9dZ8xwdsW0?=
 =?us-ascii?Q?JZWCPmAlxFygc3HAHpKvx++JRfEsqThJgqEqaDveU7nqvs3txbKzteeJi5Ej?=
 =?us-ascii?Q?i0jcu38fd64+rrpTMJhjpDKNOBGsDLjQyfiu2D830La4wgxBuQWuvKUph91r?=
 =?us-ascii?Q?75w+OQGSObltxpT33yq3SOLSXJE1IpvX11FpcmOH3Ksuvn8xvHate8HehIV2?=
 =?us-ascii?Q?ALE8QifakyChhr1Dpp2PPbAf9kA6fjakOFGgvGROuQzOL8MoPEIRbwr2XqmN?=
 =?us-ascii?Q?uZswbxW0AOXLWsbxn49cXfA+mfP+FWuEsqgGG0g6i8RiFxk4PJT9qycAoYSp?=
 =?us-ascii?Q?+Z7MranY5yI5h5PMnqCWVZAM+W1vkeqR+OeVETQg?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:56.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78460851-c145-4522-0386-08de48933201
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
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

Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
and used by R5 SPL to boot the HSM core. By default, point to the
firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. Pack firmware for J722S SoC as well.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-5-b-padhi@ti.com/

v2: Changelog:
None to this patch.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/

 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f79b3e543ae..14ba9ba2c1d 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -268,6 +268,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -300,7 +308,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 278b7bfac7f..cbae8a93759 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -117,6 +117,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j722s-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -153,7 +161,11 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..63d210dd883 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -154,6 +154,16 @@
 
 		fit {
 			images {
+
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -188,7 +198,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

