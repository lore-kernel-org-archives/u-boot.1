Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5921D6B6AD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB02C89222;
	Wed, 30 Oct 2024 17:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="B2LRbcSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EDD8924D; Wed, 30 Oct 2024 17:48:38 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9000989206
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0URUbeG79XLqQevgj6XCkdlne9nf+qtP1q05GPwkIHyjSxcnojtiixefFYyjvqH9mr2abjjiRah2QAVDy9XvopSzTNQEwJg7NaUJ80HAcDcs5N/TNAhcc6JqSZyjZlwbU2LqUzqgnFGh14gLHCyheeRhQRG5I+CSGh7ePbvZnp8YwcelSKa+jTQxZs+YwNi04hsvlNFmQd9u9qN3mUPqkqBXb+h+SNaA4ozVTukq1GLrsM18JmKUYq7Qyszxi4RxNdp7W3xSW9WdjaN6IcmZpBemRnRaJsRUfkW1XX6lK1eH7a47Gc55ddkr5LPJ/nqDXSZfChXmvSsErDc2SnsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5CP0PexVJbfFkq5TQKweQfYLlUByGbHci1IsNBdv0k=;
 b=nZdjqBYVT3d2L3rbFe7cj1/O709Kodwutlp8I6FMM3vCir+4mM9FQEDg9ctlniOb5WXlgkfqhPUtrYwHeCudKoVz4Q1eccx0lZv1nGWNHcJIv97BJbdi4s4fUEmR7iyRxB7LGC9mUR10B9aEZTqOIC81E9vdnBd1w9TXrAwCeLXbGT+rB+QPeeTyBWYNmyB68cRTjd8IXdIk+X0u+3d4noF+Ie0uzaXhGHy+ay68DvoQdV3+nLLfS45UdXWfmWArNcMvCFILcuErjRjiqD0/2sBy3k+ZQ+sn87gC4XmfMZBf45xawAMKg9XHVMLgI0tRzJ8zY947J32LPEi8yXrH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5CP0PexVJbfFkq5TQKweQfYLlUByGbHci1IsNBdv0k=;
 b=B2LRbcSL4rtXHBoNKQeMLF9JIvVeGqvcszLDQKpyy/Jxbligh4CFbSPhEhMTcxYNq3U8lYPk4oPonmN1YADiC+xw/nkTuh0YeTzEIZEwSqa0vjHC0jWObMeDYVcVyObWF+2T35fkr4rv9jq+g4u/W7lTendj9gVzgyTT3P0oPoI=
Received: from AM0PR01CA0137.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::42) by GV2P195MB2259.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:48:30 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::b3) by AM0PR01CA0137.outlook.office365.com
 (2603:10a6:208:168::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 16:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:30 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:28 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 5/6] arm: dts: k3-am642-phycore-som-binman: Add SoM overlays
Date: Wed, 30 Oct 2024 17:48:14 +0100
Message-ID: <20241030164815.1763506-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030164815.1763506-1-w.egorov@phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|GV2P195MB2259:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d9e9f-d9cf-41fc-c12d-08dcf902af4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUmv6HXW4z10SL/KzpBdTv9WBozFg55a2I4mZ3wkSfZbPQ0srUur/OxDEvMl?=
 =?us-ascii?Q?B4LMaTjntxrs4aJ7qu2PMwJXio5asVTI+bIUGS4oa3ZmzDrCWbr/aREtncFC?=
 =?us-ascii?Q?XxX7+8yzGMhbRmqXTRO+YvTk10GeI6qbNiJH6mzQ9tEjZBH024ueYaj3fKMX?=
 =?us-ascii?Q?wnfUm5ZEYbGu5JO1XSGvedqWDuDSHUyl9bpthMbpjhmclxRmgn81kemF0N5+?=
 =?us-ascii?Q?dCzqxIH7gdQAWwiEvPBJLOs+j/QGvUPsGcBxn7IUcssiMxqdR2rl12VZcU7g?=
 =?us-ascii?Q?/Ay0nVGRgfxy4jt1iWSMzfT2UmRQONZg1QcO1KHmH1SSRXOWYqjhjwEUYJHr?=
 =?us-ascii?Q?OAAOHFau+Ge89Z3xkl3yG/1zFX2LN4JF1MR47oZxtY7stNPOVybNseCq6aSk?=
 =?us-ascii?Q?Gl0E1RhWuRvCNG9uCq6INuv5urC6q81RMpf+2ptU1HIy0yGfdD3TLg8ZtpJE?=
 =?us-ascii?Q?adUJEy3uqCNUlPTA6u4VHrUmgcEdCvXpgC9EAIqy2h3woFyUeo1ceH9Wiyl+?=
 =?us-ascii?Q?s0DLkI6Wyh7I4YgsH59RFxutKRbB4x+Y0VSO4gbndWjlB0Axa3SaEHnLQHLq?=
 =?us-ascii?Q?5OzVV6Wzs0/IMxy5lgvTqhY1BShkE8MdcoUAE5KdW8MH6PgMeDblR4HrhRp/?=
 =?us-ascii?Q?I1Ni2kKMgBtlI249UXS0h6TsTtpJwMGZ8psfbaIyOfHr260nlz1pETEK3B3J?=
 =?us-ascii?Q?wAh8kIcE1wSb4AmRrCWR9lY3FP84uAVDnSJy5/OVdKDh2c31PtDUjbOw7pUy?=
 =?us-ascii?Q?XpjxXZPNN+o7dNRyvKqkP1jk1x7mA+jTHbfE3HlwP5NSFwTLi5stLW0S4ivD?=
 =?us-ascii?Q?fVHbKFOJPabIDNcemue7yNUP1OU8RstqJYGqhC+eVpPz7SWy+ht78RRGauSp?=
 =?us-ascii?Q?oOIO1bkVTdQy6z30MkSAuUlfq6xKy5UJpjWI63u6P1mVcRT0W3i8FFUOdFGm?=
 =?us-ascii?Q?LXgiF36eath9JTMy2QSy8p6KxVYiw6sli2B40VrvF1kmDUHW1/oVPVbRRWIG?=
 =?us-ascii?Q?Dh7DEsh+/Dzlu34N9e4leyZRW3ba659r5N54iG+7BzTgqDBShkZH72Ppc6Wp?=
 =?us-ascii?Q?GcpIrt5DUS+1ilxdSq0O4D7brcCpBmZTTXwJsxbFrsr0uB1vnQfqdgf+V4O1?=
 =?us-ascii?Q?DVOiTx4D9B2hIja95TO51DBAgfj0lxNhy1kSCgKPKNU5+SkiKQqlqaZDkWnk?=
 =?us-ascii?Q?IjZCpC93ZyLPijX9y9JVJTYrDci4v3eprnxGSjK+CZu7xMPTJxO9Ea2wYgPJ?=
 =?us-ascii?Q?iDtUlOB97nMRqrNPcJpC4w9nUz5qI5qRqjkwtBUIJ37g1IbDBOTzgTCxQHc4?=
 =?us-ascii?Q?0YIgNmke6v4nqMfE1Cc/zm7uXTIMtJgaZ9DweQwDxC2RnXrNY9LQDXbViCP0?=
 =?us-ascii?Q?xBXcnszsrImz9Zb3VZYxxDJ/qOszDIY14rdCn6oP/3wOZdqI0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:30.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d9e9f-d9cf-41fc-c12d-08dcf902af4f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2259
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

Include SoM dt-overlays that handle variants of our SoMs into
u-boot's FIT image.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index dd0967079b6..88d6c40e95c 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -344,6 +344,54 @@
 					description = "U-Boot for AM64 board";
 				};
 
+				som-no-rtc {
+					description = "k3-am6xx-phycore-disable-rtc";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F000000>;
+					arch = "arm";
+
+					blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
+					};
+				};
+
+				som-no-spi {
+					description = "k3-am6xx-phycore-disable-spi-nor";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F001000>;
+					arch = "arm";
+
+					blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
+					};
+				};
+
+				som-no-eth {
+					description = "k3-am6xx-phycore-disable-eth-phy";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F002000>;
+					arch = "arm";
+
+					blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
+					};
+				};
+
+				som-qspi {
+					description = "k3-am6xx-phycore-qspi-nor";
+					type = "flat_dt";
+					compression = "none";
+					load = <0x8F003000>;
+					arch = "arm";
+
+					blob-ext {
+						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
+					};
+				};
+
 				fdt-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					type = "flat_dt";
@@ -368,7 +416,11 @@
 				conf-0 {
 					description = "k3-am642-phyboard-electra-rdk";
 					firmware = "uboot";
-					loadables = "uboot";
+					loadables = "uboot",
+						    "som-no-rtc",
+						    "som-no-spi",
+						    "som-no-eth",
+						    "som-qspi";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

