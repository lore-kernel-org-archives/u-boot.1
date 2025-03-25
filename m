Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D767C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19ECD81C64;
	Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="n6iYJM62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA27C81C64; Tue, 25 Mar 2025 04:58:38 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1E180EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cfv9Z1eMBPdZLbbmVsgA92cYWMzJAyn6X2lC1r5c8L1NENPrHUpXBXNp/KOPl5mUIFfTXq1KtdPHH1LyhDvJiAawWepE2sEB+Kp6RKncOTBWK1VcnhkqGAAl05HG/Peu0kXfvKxM0O4GcA+rw71IhPXnujOoXoXj4zh3qDTVwN9SmWOFLwPpd0dsYZVS5BhARDHyS2GXosKaX8ZK2xximKz8m7opx6L/v2kOzCcwv06yowg3KYBYYxStryrADi8hG0SdwzzarRPtD0o1QjhD5iBcc7ZEsF0HQVLOFwwk/VxbTvxYsaFWS/PPnlx4x4c/v0+dkM+EyT12CVhjF328bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ya7WznNimaK6G3PzOiZ6V+hDJlwpL+m+lfwwcPeybI=;
 b=tiw5pdiZRQyHisDq31ng+4fDJlAx0pndtBFUgVDRZVwsRy4sjhFcvWVTC9DR88JGpSSTfCMUCEmkgZhkeFssVRbxqBpA5xP7rUaGraOXEQZOhT0rIbiJalvtP1aTx/SVjuvBvEH6a5BZq2V5H3t3zbQL+2/5TLW+eDhfyGwwKuSOGOmU/OTGJmp1VzBzxic9JVobTi3ScAxC9kE2hy2WWQ3JP8PeCFXjmphielyNl5mX8872witqV/TOOMZx9t9ca3bwxpUXPeJzJXj28VQvyWa0LpTQfHNDYy8EmSlPCLTEYvdXJi0dKx8t1dEbCSRIMTEcfe4GOaKyNlyLSJ+Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ya7WznNimaK6G3PzOiZ6V+hDJlwpL+m+lfwwcPeybI=;
 b=n6iYJM62oVGAcONVnBpzKTjtq5+O9hWzu4EXqkDwVlu1NCWChPb4ecveBLHpIUCd0waYMXJw84CtGeJQ90QXp2Ktxyv4cishBx1jPSLUuXQFSDvggFn2xiGK+aEaw4Or5k/U5LUWJd5Is7VeYWKJCRPhsEcIA1QYfylFgRSAIQW1r2Yfo3L3xP4htJV8vbHNQeEVc9HSojSQTlHmSxi5AMV0ARttW/5lLSMdXImM/9o+8GtshkLiRi4J00EEOBfKpJlbBdTUXjW02JhGqQ/TQJViAgI4xrvAT4GDRwXK6sYhR4BcgNsXfxoF0xmHBKLut55g/wNlksl65bavBGmPWw==
Received: from DU6P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::28)
 by DBAP195MB1098.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:33 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::d8) by DU6P191CA0017.outlook.office365.com
 (2603:10a6:10:540::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 1/8] arm: dts: k3-am625-phyboard-lyra-rdk: Add boot phase tag
 to phy_gmii_sel
Date: Tue, 25 Mar 2025 04:58:17 +0100
Message-ID: <20250325035824.2304200-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|DBAP195MB1098:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ac4f61-cce9-4b38-8e74-08dd6b515008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?trzx3lxkLouEkYBK5VuYerwo816i2Et/V98m6cWsdkTVaMn1kGJANZEI9R+C?=
 =?us-ascii?Q?dB+wtc5u3L56LidJD6Y6wTEx+HIgMK/Lv1k6j381iKK/f+AD+yMafY9ZgFY1?=
 =?us-ascii?Q?7LKPg1vrOfMxTzZRJAjruZCHMYH+oJq5Pjm6cr4VMhwqxiV3SnmdN7Yp2Ate?=
 =?us-ascii?Q?aPgwXhmfwklZMyjLoR0rmJXZs2JaRhHLEclGo+OVkLodQuD5erdulKgxMTBI?=
 =?us-ascii?Q?/85xBxR1S54TVoN9GI13buAq/tODNtwwo8ibeoMHun2SZwiH+YohHoru/62B?=
 =?us-ascii?Q?vp29HGAjhiByGbRru1vZFpZ2xKKEilFvHuYKoVE8sV389fXS37mrdXDsiYNu?=
 =?us-ascii?Q?JBAWguKxXK1f7fsqh44WvAPXKjKDzR3tGX9wcebMV24pD/RZiu9bFaaD4/7g?=
 =?us-ascii?Q?UpWT58xoVS9hpRSuBqXAQZGvJjC7fi0IS+jt1wB6xMNMBmgwIDZv9PJzCU0y?=
 =?us-ascii?Q?J4fuJKp8cNfEvkbqy5hYD/EO/GEzfCLGmjFwWCGLNsEycuweBtbFXGBu7ggn?=
 =?us-ascii?Q?yjya0+WUF1hDzYv0xYRu7zGmluNf/y3TG+lz8GuiijG38eRVo0hBr80fM1+F?=
 =?us-ascii?Q?oXIXXK679OvlhY5fUtPQc88rOLXXqjlwG6i9oGv5ijLuz7ICfcmq/rUMX8w5?=
 =?us-ascii?Q?jAaHqKBcqUhp9scPLNif+0pGSZmb+IzQqjQznSOkPUKzkBgVQWe1mgr+Lrfs?=
 =?us-ascii?Q?2Qs4jLbfHvUgzWI7VwqjifwVXjDXH1NBWZCQKyWartLRL9qZGQTnq45vgduu?=
 =?us-ascii?Q?lb0S9AmZ2e2Q9RCQqdZSq5YKpd7MZOMj4yFJOz/jeBUev1lLvjOc4CRA8lVL?=
 =?us-ascii?Q?58poGiUnK2Ww3qv64/OO80uPTl/yHDx7Pn96ZrP1EUNOKl31gBgttjW8zxqV?=
 =?us-ascii?Q?l6d1OahBaVaZSKeBTZhe1jfYIZY5Pk20TM9jiVHvLnzUGpu/wW3N9WWDDz4X?=
 =?us-ascii?Q?dhZKmH8vtSKSfeKAZb82J+Zl9gLK3fa2n6d3Sw+kolKa2X8YpRl/iTH8oLx8?=
 =?us-ascii?Q?aGy+IEDr/8+jZ7jXHn7B9GrEjJ1j4BkPfRWgXp5pj6fA0yNp90+7PkzS2tKR?=
 =?us-ascii?Q?QF8aEY5vgZ3amkubzgcoehQGS77zqIOAXLmU/diaFAgilT821P0yZ2TcBJTq?=
 =?us-ascii?Q?OeXfhxleMpANFFn/cXEaIMGf5cqJL6PM0l/bbnocNob6uKyTclXbdAyjg7Bs?=
 =?us-ascii?Q?vbDlWd3gJtP5Wq3YrVLhAjWS1N7b2kyAjWSLt1/qxrOrLnVqDP4eFU+/fKLA?=
 =?us-ascii?Q?wtajKR8IGjWXLJTp9Zxc7xanEYS0FP0h2jOWkZU7qq8UmqzKCUEtkzkjjvff?=
 =?us-ascii?Q?hny0LE0ALAU6JXMWmYHu2Gk2xJVzMG383GW6lzse5JBa5nf0tFEx84nKMl5N?=
 =?us-ascii?Q?wo1yw1L6QuPEKfWn0c/9bunAEO8gQgwNGGmsch8IXur9jz9fDnLf7DvETznB?=
 =?us-ascii?Q?V3xP3s05LBVFfBFyARxTSmsFURRImiA9W+WvMfewWiFlDfocCXvbrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:33.4958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ac4f61-cce9-4b38-8e74-08dd6b515008
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1098
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

Add bootph-all tag to phy_gmii_sel node. This is needed for booting via
Ethernet. While at it, drop main_pktdma reg redefinitions which are already
provided by the top-level SoC device tree file.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index 2bc5acbec23..253ca297e12 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -42,6 +42,10 @@
 	bootph-all;
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &fss {
 	bootph-all;
 };
@@ -86,16 +90,6 @@
 
 &main_pktdma {
 	bootph-all;
-	reg = <0x00 0x485c0000 0x00 0x100>,
-	      <0x00 0x4a800000 0x00 0x20000>,
-	      <0x00 0x4aa00000 0x00 0x20000>,
-	      <0x00 0x4b800000 0x00 0x200000>,
-	      <0x00 0x485e0000 0x00 0x10000>,
-	      <0x00 0x484a0000 0x00 0x2000>,
-	      <0x00 0x484c0000 0x00 0x2000>,
-	      <0x00 0x48430000 0x00 0x1000>;
-	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
-		    "cfg", "tchan", "rchan", "rflow";
 };
 
 &main_rgmii1_pins_default {
-- 
2.34.1

