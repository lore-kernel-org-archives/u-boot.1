Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8624DD6ACC5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6EB8978D;
	Wed, 27 Nov 2024 13:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="lfmRkWN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238AB897D5; Wed, 27 Nov 2024 13:17:59 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FFF89782
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmSJue/17vQL++nmI68P0oyLRySg0wmNGjA+KWt/wTU807VB6gEQw21EvWABpcQzOH9c2FsT0i3FaNJONaXEK60Hzg4OhmfxIWgks0pu/AhJqn7+bdkHO33EqprfjYHLqaewDIJtz4kZ/PJRljEIuV0c88DbeyiusciTQKW63+Fjw1lx4Z4MsVJUxxT6sxBFS2XNVD0HIhbFuzohbs7MgOIP6oUiJQ8kAaWF2zfmBuHU1RwU0ld6/K1YRS7OS8QFYFD77CBdnlO8gmkbPjbmGLCT9xy86YKKWnJEAiQz4SPtcpdhXQnTc/WLyeTYak56HgNsKTSGmONx3kJuoPKZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yeL4/zPHXWu2h9K5P4yb1/qZl5ebyKYVuPjVPmpu7A=;
 b=uxYPEyqY6b+ZXlNdyxMFMEe0RfPLPdqf7qJ+B0qXxbaqvkth0qgtS+tSrZ/RuXHLlMCTa8uvz12o0FDwbiaUNBblKQFo+gWRGQubbk3qig9GkHd8gaZ35lgIEEgdNoZ2eKWzH2SOZDlyPFdrgeN59eQrS+FAbQDx0Y6V+oqBkYsUy8cyL6ShfvQeHmh/e6oIr51qLqW7nGl7wjP6Mfsbg4Gsf2TQmVp3TCKYxXvErLnBYDICEJUdu4fiuePiW5pSGaAUzgRxi/n83l49d5l3j9bAtceKqltW0FaQlB96fVADmAXE1bsrgXm6r0HdyG0pXHs9LRseiaeRWFkOW9h5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yeL4/zPHXWu2h9K5P4yb1/qZl5ebyKYVuPjVPmpu7A=;
 b=lfmRkWN3BcBhmFLqHnlb0baChNp/5aAzhy4t2LzUfbtjdytG6QEgSfvJKgcJ/z0fQaWfDu7gU5ttN/vyfd5ZSYBCtvlmFEKrLYUNx89co9/A1Dd2SNDinForGBvr9mfl6P5YXq7C8aqrJvKRr7P23fPGBAK0llnUpjhUwiy8wCY=
Received: from DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) by PA2P195MB2532.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:408::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:17:54 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::6c) by DUZPR01CA0346.outlook.office365.com
 (2603:10a6:10:4b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Wed,
 27 Nov 2024 12:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 12:17:54 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/4] arm: dts: k3-am625-phycore-som-binman: Provide capsule
 nodes
Date: Wed, 27 Nov 2024 13:17:33 +0100
Message-ID: <20241127121736.1525948-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127121736.1525948-1-w.egorov@phytec.de>
References: <20241127121736.1525948-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|PA2P195MB2532:EE_
X-MS-Office365-Filtering-Correlation-Id: da303426-aeff-45f0-c035-08dd0edd8580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wJ5qa5fkrg1B9on2ylIIT92jvCuHbk92QrGG4PAKhhIw/oDLi+p0UPLNzvAS?=
 =?us-ascii?Q?oOtZE36lvRo6hvJeb6VI6G9jJCs7fBZ3lmVrhXELRJTlh03reBGLcllpny+R?=
 =?us-ascii?Q?MgmT1MQk30vZXtUoGpkByth60E9k5uXgdiNX2cvzcxoqp3PTMJlUyqRvW1Ke?=
 =?us-ascii?Q?KpWqrsmNn4ATFl2JObusH5r1Gppu44scRJgdfTI05h3RdOnw2r+2bqgh4Rz5?=
 =?us-ascii?Q?aqG8DBL/OTft3WnwYsLaZdL/E2N+UEWA581GJAjcqwkhCCLBHuWssqRQp20a?=
 =?us-ascii?Q?zlYdT+cxyp902WWnRl3cVMRkgitB4dyq8PZB3N+d/Iy9chkk2H8TlWRZ+PFN?=
 =?us-ascii?Q?NVNhg+vEZa2RsmiJNz6rG9O7xE745tNQjuvS8bLcp8mUwl3R1KHtACCNC0Z4?=
 =?us-ascii?Q?PSU8yRlm3WYXnjUyKrRUf+CXzvSo+Nj4iMGXHsZHtkkGDfRfc+NHdIpDRPRE?=
 =?us-ascii?Q?yjO+GqL/wIfmmXO711ToC7NJpu/BgVGRiLMwwN5kLueOZPmV6tWT4+NyMzOj?=
 =?us-ascii?Q?Tb7Q8w44mrbLbVpYgnGuMJ2KYDZp988Duoto3lFqbU1kRu5yfqbvL+EWa5mk?=
 =?us-ascii?Q?N/Ux/SvfNxQQxj1VesxedSVMmTgcGXNlmWrXij+A5XfmAgGoEreSt42sGowK?=
 =?us-ascii?Q?tyeAAxO2soHQHg5VJOFPAUF5R1UzMXKqJITO9nB2RAd/8a4ObgT5ohSlI8fd?=
 =?us-ascii?Q?t4jCOKnIBEtdJAisPISZ/QA5RBXBolJTkMHISxAF+nH3m7IpA3u9tXq5OXAi?=
 =?us-ascii?Q?M1vJmS9ibozooZrkFBp+/BjnVMOx2tCHv0PMI2KHMA5pq1annOmaOhq9IMme?=
 =?us-ascii?Q?rQXoEV34rOJA4wii8Tc7N0XD9eZlKPdR9SwXheLv9gh8ah+6dWildGiwZXUa?=
 =?us-ascii?Q?x1w46VeQdTlYKiKRiWLxVmUsnCF0Bg5wppLXC5mfDjo//ycA14AC72Cvamcf?=
 =?us-ascii?Q?dq+gV22IUYVTle9L/V2yIRUaulU0wUDzlYhJqOlrYzuLrQdHXuS8YF5IG1b0?=
 =?us-ascii?Q?izxMRXmLJXlmpz2AghBNEjmjchgpo4Ph9zk67NVoQNuI71qYDTcNKtMoMdf+?=
 =?us-ascii?Q?sQhD6L2Xp4LDvwpdWFgpk3f1F3ZfEWflsof8W/8breI85Rcl3vWrbwbF/6MM?=
 =?us-ascii?Q?c5MBiF5ybDv1VmS0hhIKh/1YXki74gJwrb2s9Xl7PRydD1YWSAE3El/lpYc3?=
 =?us-ascii?Q?kzXPDEd4e9G5XDFFJCqnLGrSGVInfR9Lf4xUxbp+eU+PQy49P9xOcfKYIHBC?=
 =?us-ascii?Q?zhwUeQvY5KgduN+GXU0t2b2O4bK8PJs9aIviCleCwam0AFFKom0V5MacSjlZ?=
 =?us-ascii?Q?bybQqnRlpa9kagoEOfXpcFJCAZOaliRbreKv6mkoykf82KGc2pk9rHFw+2N3?=
 =?us-ascii?Q?1dg5loM6aZF7iKzfKbAMD8jVIKKNc5DtJjD8lGVnuNS7xjvFb8SPd+VNjMm/?=
 =?us-ascii?Q?DcxIE4FxqQoFbn/zHGzZ7c3TbFE6dxd7?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:17:54.6066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da303426-aeff-45f0-c035-08dd0edd8580
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2532
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

Fill in phycore-am62x capsule GUID properties of the base
binman capsule nodes.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 63f2eed7ccb..31456d23167 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -137,6 +137,20 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am625-r5-phycore-som-2gb.dtb PHYCORE_AM62X_TIBOOT3
+		 */
+		image-guid = "C7D64D6D-10B2-54BC-A3BF-06A9DC3653D9";
+	};
+};
+
 #endif /* CONFIG_TARGET_PHYCORE_AM62X_R5 */
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_A53
@@ -460,4 +474,29 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+&capsule_tispl {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am625-phyboard-lyra-rdk.dtb PHYCORE_AM62X_SPL
+		 */
+		image-guid = "09841C3F-F177-5D57-B1F6-754D92879205";
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		/*
+		 * The GUID is generated dynamically by taking a namespace UUID and hashing
+		 * it with the board compatible and fw_image name:
+		 * mkeficapsule guidgen k3-am625-phyboard-lyra-rdk.dtb PHYCORE_AM62X_UBOOT
+		 */
+		image-guid = "D11A9016-515E-503A-8872-3FF65384D0C4";
+	};
+};
+
 #endif /* CONFIG_TARGET_PHYCORE_AM62X_A53 */
-- 
2.34.1

