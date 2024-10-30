Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FDDD6B6AE
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93EF89231;
	Wed, 30 Oct 2024 17:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="rBmmxs+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B488921B; Wed, 30 Oct 2024 17:48:35 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2662B89212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX63S0prqaBiOGycTwQX8zvo0Nf5b3MjIYezdvPczif45/0UfM9nod1Tdb0Kth8HTb5WA41vEKogmRaYu52FmpcJ9yvsGryhWZ41zIDJQ3v5j2Clox2o4DjXNV+xNUPN//pTpkzEfIOV2+PFIBsB8DzQjXeRJJkGpkZLGVAT6IjwgibllWUfD3kUie2mJc5tziZf/nwA9jLhRc1Uw9D6N4mH4vizN9XDZedeiNzhgBLk4cIlSYAES8FVd17tzMyTv/SYy6E5WwauwTFrKNkwxJ/h4UML0Gy6XAFRSSj0R+6mvcMEbMKXdeLT6Gc5bt8kmDUMtKgQH1dmHdYC/jB2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iXAGBFzjUZ9wD400AnKrMOIV1BzxaNgKUcZaYklIOc=;
 b=QRjDprPqDE63WHzKdgTei7WVr8ktsZ0mNJ4FtrfDTitTxIOjAW+HaMhnMaVCElItfL3HxGXqrldb37K/09ZVr+g3CPk5vkjggmSmzCE8g+oBGpNezY8L0moK+gQaVPEepOa3J22UT8iAqWDBUNhwml7PHXYYX6CQBuVfKiOac9G3dS6PyXhUzxs5LNY4wDbsB6rlbU/JGDCPvf3d9VkwRfnJeiewpyIudr6JCke5PPLZTKkXh2VjSNGIYYgQ7wXjSYIzcaM6jXQCEu7qMA73+pBVaa0XjuIx3rSBU28MuY23oGscrI870SMQKNlorFbuuaUAs/E38A2tcamqrhLCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iXAGBFzjUZ9wD400AnKrMOIV1BzxaNgKUcZaYklIOc=;
 b=rBmmxs+QqvbvCknXpLyKf8MQJZVviFaj+TwrlX7gOIUo4hgVkk1GlEc7F9Z7uVs2EKOTke9R4VtWcYy8d5K6iX6DtPkqd/YmaB9gLRuTjiFDBLHzaZ3zVyir/OgY8s1mC0FpAaJrgzzAW1nAMjTwusWw0xgf4AtvmDMqtHRmjqc=
Received: from AM0PR01CA0130.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::35) by PAXP195MB1277.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:1a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 16:48:30 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::c3) by AM0PR01CA0130.outlook.office365.com
 (2603:10a6:208:168::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
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
 2024 17:48:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 4/6] arm: dts: k3-am625-phycore-som-binman: Add SoM overlays
Date: Wed, 30 Oct 2024 17:48:13 +0100
Message-ID: <20241030164815.1763506-5-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|PAXP195MB1277:EE_
X-MS-Office365-Filtering-Correlation-Id: a941facf-bd32-45fb-4d49-08dcf902af1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6BqdX12HCenTllxO2fUcULX75e5UNhpRTv40GU2mFhyVM60C63NSp9l50+9?=
 =?us-ascii?Q?cGhM6oDLgRaUNTpdFyByjW2BvH7bi4V/7Sx5KfwJjaqxmo759OvdMIeP51XO?=
 =?us-ascii?Q?h3tQFBP2+NqKuuIYHiD1CkM1DnaKK4JexpHejmEVEsO2l6ASL3nA6otKt+DJ?=
 =?us-ascii?Q?X6EUDbwHncyMtVc9554LsWRiNKXQnYws3jWwMHjnWH2TpbCEpm3LqXlRyu3X?=
 =?us-ascii?Q?mq1f9crP9dL1iTB6NQyZpTyLMChSUU+lgSFveEk51cEfAnh9xZAnSnJxAZRV?=
 =?us-ascii?Q?TnkLeSoNKh9/tbjag9FcaGbKGqzbMz9TpwdnQIPAkjDGz6FJjzhMTohRaHRN?=
 =?us-ascii?Q?SHQ40ti3Nt2JVbw3VXViFjrVtUt5mGue3mWqrkym+1N6pkziEPy1qNGyfBnc?=
 =?us-ascii?Q?aDydJPYtE6iOYbUei0UDBw6SgDacm+Ndy30/qsUaTcro6LHPHGBUy2lolmxf?=
 =?us-ascii?Q?iIuAlftMrizoUoPjhE1MMy3ODJUxp9WStk4mjcaTyiRapi9Gv1uw6ioAG319?=
 =?us-ascii?Q?imDaWBSSVHUd8K9KV521fFFzrgLeexiU7gI6WAhhUrCSy1nXZSYnYyWqEhOv?=
 =?us-ascii?Q?fZZM0YbV9IlT9HBIfrYn5Np8YsOBzpshWirOIm/1nWRR20ibc8kcue4A5TzI?=
 =?us-ascii?Q?+1mh6MbtL+nndlWS95Bjp9CPDLFYijdznPLNkClTYkdS0rZAX2ewP6GZl7LZ?=
 =?us-ascii?Q?6m/2YX7YW764v9HnZJq/yTYi+QKtxAHRVI0ORL8HSC9yVRPM6J7ICcP7yUvj?=
 =?us-ascii?Q?f7MsxJMlmBt9HBxdDaLE8BXnDfP/ZWzlPmH3OXYdAeLv1X82fU7loCWk0xqh?=
 =?us-ascii?Q?CW7L/CKiPgb9cEK34jXB7vlDc25O8M7We4G/cVcx0DnVRaXUI8uha0o0X+AE?=
 =?us-ascii?Q?sv8a11uaAh/zGgKPVezEN04uvFUv3xVwGU94HiiKqtiAK5MI+j4zXcr1S2Ce?=
 =?us-ascii?Q?wMAbHlktFqwyOWmqtlsPxtiYvMW3rYqboMYfrSABaj0BE9Gw8/TS2Cdx0QxT?=
 =?us-ascii?Q?GNgtalvwE0FRPITHs68txHABGM0NeFdApgW7q8ScVQlndwLMBOYNC5qFvSiB?=
 =?us-ascii?Q?bhloJWoJJMJHrXYJu/inqZrtYJ2OIaQlqWvc+yv6DncjPCaQDqj3iPxq0B/w?=
 =?us-ascii?Q?/qDKSuJQHQyCt83/pa3LiqEDR2cN3JvuZ8PX0POwtvHOyqWEKU4xK8mHw7+L?=
 =?us-ascii?Q?PNey4fPCQd0STpmCRk2MDNpwc1t49RLywPHFbVzEpefkcrI50R0RLz0MHlfa?=
 =?us-ascii?Q?jZACHPVqal7jwX1YzA4WNcJPQEiG/Jb4On2E/mNMEJ6OVCyiFqC0mSqBZd/o?=
 =?us-ascii?Q?tazePt/bISdvWVFYjm4pig/ytcZwgmTUDn3MoMaYIvDsNJJr+NjF9v+rNr5n?=
 =?us-ascii?Q?6gPdFo9PH9wUYmdGM8HHVnJRSoPHdhPPhEDHiyMb/hCQM8FlhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:30.2039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a941facf-bd32-45fb-4d49-08dcf902af1b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1277
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
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 0961ca66f28..63f2eed7ccb 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -301,6 +301,54 @@
 					description = "U-Boot for phyCORE-AM62x";
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
 					description = "k3-am625-phyboard-lyra-rdk";
 					type = "flat_dt";
@@ -325,7 +373,11 @@
 				conf-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
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

