Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CADE83057
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 05:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E58783FB6;
	Tue,  3 Feb 2026 06:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YSY0g3j7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D3083FB5; Tue,  3 Feb 2026 06:55:00 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6790C83FA4
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 06:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA/eH06uDvD964hlYFOuZlqhv9l9IMBoHje5gx6fo+SrWQhqV6jprbCrp0WDHG3tt19fIM6kgQZa/gAAJlNHPFuXJhHfj7tytICBkPHby7uWi9fcZj0pErSYYjxzXUGvbO0owdgA8+hV4AhKg46/iUU4V3LIIbdZ6Rue4yp/98007tS6exM6SGppRWtXbPfr6CYFQoOGoLGbLfYXrT6kFXS+3vF6Ap3tRR3tz7k9mxRmcFAgi4+EnrwIoUbEZcr6cZQeu6FDOOuyvfwHb0BjgJTBY7HKint9z+CHY04KQMg3h47CarDvibPcwWehm2mVum1PtFHlHwuqqBy42Cs8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2mAxYb23p2euMlKgPoWfDn87pUCvHRsVdhnqGNmZBA=;
 b=sGFG+yAcmUK/7vccxrG7nnxt5cvIsCk4rEVY8VaE5ZeIFD+qIJOLZ2z0Rrx8U52npzugp1NCQpMgOWLjtSd3hwYHLuN2uQOYUTDjaWrHGziy5wBsFW3PiWtQGiTwF66BBCPiVqfWm8bIfHEXdKvwakVJxRVnmsQG6SIZgMMlVnX4UFcp+Fca2ZbeKtgqPHh3EvqDFIznyKNWmezQCcKtgJeCbXDldlzq5rRf+c4axlPxq/FWY1izCEEPVR5iVcgaYY29UpuyBnvGc8GnZ6qfB1CVn/YZYayLhROjuJdDk/NFyXCYb4LUqgWSSEFmZed0g4cOZQRK3RDMllaENMZe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2mAxYb23p2euMlKgPoWfDn87pUCvHRsVdhnqGNmZBA=;
 b=YSY0g3j7776DhgmwOmSVbHFsldWzH2EnknhjOdFyQUSSv2UhL/CwCJU/xoA/lxUpe9xT/PMKfwTr9/z9Ezgz1JGHf/wdBxOdP1b+btei68lsKiI9njlmhaqQjfHCjxFygX96TOdkDs4H7Tye8JvHFd/HGmqaFHkMn1uHa0AJ8USLKSNMZZ1ILvFquckMmqVJ2x1exIYDUaEdKoYvsmTffi6ppuiEkaOHlz75lhVtWDL2urmISJM5Y+nra0EnTXJ6hHkCzxQ7dWg7M2NIkgoaz0wD4R3YrTIfX9V6O1YLAJ4wJ4Dt7x7iJ1C2KebT6WxgrYc8ObShIGOhKSHKgh8N5A==
Received: from DUZP191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::16)
 by VI2P195MB3100.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:54:52 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::5c) by DUZP191CA0006.outlook.office365.com
 (2603:10a6:10:4f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 05:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 05:54:52 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 3 Feb
 2026 06:54:51 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] arm: dts: k3-am64-phycore-som-ddr4: Update DDR timings
Date: Tue, 3 Feb 2026 06:54:43 +0100
Message-ID: <20260203055444.202307-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|VI2P195MB3100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce98e81-b681-4997-727b-08de62e8bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9jerN26Mytv7s5Bl5NWJ96XgdTVDObuNE0hDqdaMo9sR3jEPTfdbXsulqbrL?=
 =?us-ascii?Q?WqqpbkkwhXpouv+5XWftXiWFQO3iWkPFgQbt9g3PtW8F+WZXv6UPHZ4bvjLw?=
 =?us-ascii?Q?xOa1aKKm6lZcqtPNjl7UQUG+fjYga8jyPEx38x4gXgNLesqaVd+EFUpnlBlT?=
 =?us-ascii?Q?T3symKsdyfYjcSmydLIgUpHNeeJPtipTrGItmnmDB/xIT/bokeFEMKDHPldB?=
 =?us-ascii?Q?nvtej259aegyCvbkmg3WWV5KoXIgWrpFC5xbIxohINkz02MQJjBTtDkKPHZV?=
 =?us-ascii?Q?bpZNdq60nRXBcRNtSlJWzbf+f8H2Mo6vLQxHNyAf2uYobtXZdQ/a8iQFKMyi?=
 =?us-ascii?Q?QegVK7M7nlt7MDXpK2zjaDoaCYovoZV7co5MmLoKILObrUfZYrKEjk2H8Ut+?=
 =?us-ascii?Q?IO+I+A5XJ0bFbC+HKOhIRBc2lwuFfNos6mzG6gP69n2qcOIXwfDsxE7EiBwR?=
 =?us-ascii?Q?WEgP4ZA6OWqewGcohdS3XjAvuscrTTb9EqsV939v/D6aouHL5jFfZAtYi+iG?=
 =?us-ascii?Q?fFVVOiT3/bovf2EFyiI8LuF0lPp5g7I+CFqjnOks7LpPiCtw4dmI9i05M2XH?=
 =?us-ascii?Q?Pt55ZIW85pet/Sc8N/moK60qtCnR5x62jRr4Ath/OegMc6VEp7HEcxt8ZG9g?=
 =?us-ascii?Q?btsyjRriEzaq3/+BCuokN36wq/fprVd0EN43/R8mG4q9rtzf88CqozyKGkgx?=
 =?us-ascii?Q?jIXdFqqVmDnuakYLN/CCp3vWNOAUflsr5nsZH8Xjgbne7cDfZzsmGmJRMgar?=
 =?us-ascii?Q?B2x7m9GptiAxuO997a2zfp7s+uJ/S3ABufAJBPCSJzRQ591Qzn/Czy2XoZ3d?=
 =?us-ascii?Q?v5PXUytR1V+uF+n/7iSTGTnRC29m6q93mZWZ4Es1NPAATIRix95BFOLlU8Fi?=
 =?us-ascii?Q?OmDTWS0j0rm4ErMm7PaAXxvlMWIzFI+q5gS14gH1CUiFN8VAokCAMuPCOwYP?=
 =?us-ascii?Q?h2N7BUGWPt9VXJ+tGFL5LQeB2AIGsypv+zp91dNF/8QQ1n6fgUTAGCjQKMMy?=
 =?us-ascii?Q?amuEQbL9NKMMLD/l08pqpGmDCAUb+Giz+dUNUoFp5t+luhsgj8HmX5k0TS2R?=
 =?us-ascii?Q?vsVvRET4YrieUiRYoQfMOsxcc7swh3VXR9vpU5lrZmQbulRQWsZK/WARRfYv?=
 =?us-ascii?Q?sXqEP/CbPvv1fidFmZtxq8hZM179n0uRMIXlDHYFHjC8sJowBpn2aAciX0Hv?=
 =?us-ascii?Q?SFGTgfFmaD45GkoXyr9NF9q0+ttVGRrJFZwqCKN6dFgi9HjO0yzRaNWUOgJF?=
 =?us-ascii?Q?i4JtsVoxa1nyuPQDqwfDIDpEcBrSArKXzEOfmNKoj3JLRpcq94ZilUNGlVvW?=
 =?us-ascii?Q?pxX5vBaxbqAUIt+CHp2/5gqnHBKWau2gJl9tWamfMYzu1rm83RHvuEPeDgCZ?=
 =?us-ascii?Q?Zq5/tocJX5SqmAVf0Kl70faNqrCUtZR1HWIxrMFjbQRhBf8kD9ok+IqSIYeP?=
 =?us-ascii?Q?wdPZVjeGSKbX17vYn6nl159Jb4Hd387pLmTPL70Sskx3kN+jo8PJBA8q66uR?=
 =?us-ascii?Q?0hJkpZPuQ5LkeyIfNINlQnyvfZhXdsyphw1lv7S12gnM6nRu1U7vB4VTOWjH?=
 =?us-ascii?Q?jRSEYq17fv0r5eDHpy6fCf9/ibMn+1O/ia+KvDfftROpN1UnGiuJvNScNukf?=
 =?us-ascii?Q?b7t+AbspnjjC/WMuFW+1RYqD3vl8Ot+a/PM0DEUjBRCAH5Rg2/M8zXrEB+uR?=
 =?us-ascii?Q?jIsOug=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nbak3hz4sTh/3hqHyv/Kwmz8VTTMy+O2kF1h586F57oh8ZYRUGO3TPbsIz6gOsc7R0ehTK+8mMtQiTy56RhhkYXVoUJkZukGhah37+QvlQMY4V0J9NJZK7afEsDYwwMcsEXZzJfsCwRJ0oOu3TUeA3A2XO2fPsqPOrvs/sa03nx225UugkeUwhtSatVQ4vIM/5mdiswCorJCq2/o6WoM9w6Ns+/H1W2SyoRmimcIUqtI9jaOa0fHY8jZX0DqMIX03duTtx6d9d8sbpw7ZU4V/9OI2nIYePhBd1g1l1lIqZoZQlTtWjo7B0QdpL8IAK3hZpvMtmqVbMIp7e806W+iLoFFV7bpUEhMjSXsFcvAZDOJfi/cdBS65Hm0MzJZOH23p5g8lFjkbd2taiTBD5u0ROtDDTlVJKjllrUxdLdbNqovp8H/tDU7SgHsdrnR10xX
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:54:52.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce98e81-b681-4997-727b-08de62e8bfaf
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3100
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

Update DDR timings to increase stability in higher temperature ranges.

Update DDR settings:
  - SysConfig DDR tool v0.09.05
  - Package: ALV
  - Extended temperature range -40C to 105C
  - Lower tREFI (ns) to 3900

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
---
 .../arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi | 197 +++++++++---------
 1 file changed, 99 insertions(+), 98 deletions(-)

diff --git a/arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi b/arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
index 14bccb7f390..9b2e0399610 100644
--- a/arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
+++ b/arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM64x SysConfig DDR Subsystem Register Configuration Tool v0.08.10
- * Wed Dec 15 2021 14:35:01 GMT-0800 (Pacific Standard Time)
+ * AM64x SysConfig DDR Subsystem Register Configuration Tool v0.09.05
+ * Fri Feb 03 2023 11:04:00 GMT+0100 (Mitteleuropäische Normalzeit)
  * DDR Type: DDR4
  * Frequency = 800MHz (1600MTs)
  * Density: 16Gb
@@ -13,6 +13,7 @@
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
 
+
 #define DDRSS_CTL_0_DATA 0x00000A00
 #define DDRSS_CTL_1_DATA 0x00000000
 #define DDRSS_CTL_2_DATA 0x00000000
@@ -58,39 +59,39 @@
 #define DDRSS_CTL_42_DATA 0x0400091C
 #define DDRSS_CTL_43_DATA 0x1C1C1C1C
 #define DDRSS_CTL_44_DATA 0x05050404
-#define DDRSS_CTL_45_DATA 0x00002806
+#define DDRSS_CTL_45_DATA 0x00002706
 #define DDRSS_CTL_46_DATA 0x0602001D
-#define DDRSS_CTL_47_DATA 0x05001D0C
-#define DDRSS_CTL_48_DATA 0x00280605
+#define DDRSS_CTL_47_DATA 0x05001D0B
+#define DDRSS_CTL_48_DATA 0x00270605
 #define DDRSS_CTL_49_DATA 0x0602001D
-#define DDRSS_CTL_50_DATA 0x05001D0C
-#define DDRSS_CTL_51_DATA 0x00280605
+#define DDRSS_CTL_50_DATA 0x05001D0B
+#define DDRSS_CTL_51_DATA 0x00270605
 #define DDRSS_CTL_52_DATA 0x0602001D
-#define DDRSS_CTL_53_DATA 0x07001D0C
+#define DDRSS_CTL_53_DATA 0x07001D0B
 #define DDRSS_CTL_54_DATA 0x00180807
-#define DDRSS_CTL_55_DATA 0x0400DB60
+#define DDRSS_CTL_55_DATA 0x04006DB0
 #define DDRSS_CTL_56_DATA 0x07070009
 #define DDRSS_CTL_57_DATA 0x00001808
-#define DDRSS_CTL_58_DATA 0x0400DB60
+#define DDRSS_CTL_58_DATA 0x04006DB0
 #define DDRSS_CTL_59_DATA 0x07070009
 #define DDRSS_CTL_60_DATA 0x00001808
-#define DDRSS_CTL_61_DATA 0x0400DB60
+#define DDRSS_CTL_61_DATA 0x04006DB0
 #define DDRSS_CTL_62_DATA 0x03000009
-#define DDRSS_CTL_63_DATA 0x0D0D0002
-#define DDRSS_CTL_64_DATA 0x0D0D0D0D
+#define DDRSS_CTL_63_DATA 0x0D0C0002
+#define DDRSS_CTL_64_DATA 0x0D0C0D0C
 #define DDRSS_CTL_65_DATA 0x01010000
-#define DDRSS_CTL_66_DATA 0x031A1A1A
-#define DDRSS_CTL_67_DATA 0x0C0C0C0C
-#define DDRSS_CTL_68_DATA 0x00000C0C
+#define DDRSS_CTL_66_DATA 0x03191919
+#define DDRSS_CTL_67_DATA 0x0B0B0B0B
+#define DDRSS_CTL_68_DATA 0x00000B0B
 #define DDRSS_CTL_69_DATA 0x00000101
 #define DDRSS_CTL_70_DATA 0x00000000
 #define DDRSS_CTL_71_DATA 0x01000000
 #define DDRSS_CTL_72_DATA 0x01180803
-#define DDRSS_CTL_73_DATA 0x00001860
+#define DDRSS_CTL_73_DATA 0x00000C30
 #define DDRSS_CTL_74_DATA 0x00000118
-#define DDRSS_CTL_75_DATA 0x00001860
+#define DDRSS_CTL_75_DATA 0x00000C30
 #define DDRSS_CTL_76_DATA 0x00000118
-#define DDRSS_CTL_77_DATA 0x00001860
+#define DDRSS_CTL_77_DATA 0x00000C30
 #define DDRSS_CTL_78_DATA 0x00000005
 #define DDRSS_CTL_79_DATA 0x00000000
 #define DDRSS_CTL_80_DATA 0x00000000
@@ -132,27 +133,27 @@
 #define DDRSS_CTL_116_DATA 0x00040003
 #define DDRSS_CTL_117_DATA 0x00040005
 #define DDRSS_CTL_118_DATA 0x00000000
-#define DDRSS_CTL_119_DATA 0x00061800
-#define DDRSS_CTL_120_DATA 0x00061800
-#define DDRSS_CTL_121_DATA 0x00061800
-#define DDRSS_CTL_122_DATA 0x00061800
-#define DDRSS_CTL_123_DATA 0x00061800
+#define DDRSS_CTL_119_DATA 0x00030C00
+#define DDRSS_CTL_120_DATA 0x00030C00
+#define DDRSS_CTL_121_DATA 0x00030C00
+#define DDRSS_CTL_122_DATA 0x00030C00
+#define DDRSS_CTL_123_DATA 0x00030C00
 #define DDRSS_CTL_124_DATA 0x00000000
-#define DDRSS_CTL_125_DATA 0x0000AAA0
-#define DDRSS_CTL_126_DATA 0x00061800
-#define DDRSS_CTL_127_DATA 0x00061800
-#define DDRSS_CTL_128_DATA 0x00061800
-#define DDRSS_CTL_129_DATA 0x00061800
-#define DDRSS_CTL_130_DATA 0x00061800
+#define DDRSS_CTL_125_DATA 0x00005550
+#define DDRSS_CTL_126_DATA 0x00030C00
+#define DDRSS_CTL_127_DATA 0x00030C00
+#define DDRSS_CTL_128_DATA 0x00030C00
+#define DDRSS_CTL_129_DATA 0x00030C00
+#define DDRSS_CTL_130_DATA 0x00030C00
 #define DDRSS_CTL_131_DATA 0x00000000
-#define DDRSS_CTL_132_DATA 0x0000AAA0
-#define DDRSS_CTL_133_DATA 0x00061800
-#define DDRSS_CTL_134_DATA 0x00061800
-#define DDRSS_CTL_135_DATA 0x00061800
-#define DDRSS_CTL_136_DATA 0x00061800
-#define DDRSS_CTL_137_DATA 0x00061800
+#define DDRSS_CTL_132_DATA 0x00005550
+#define DDRSS_CTL_133_DATA 0x00030C00
+#define DDRSS_CTL_134_DATA 0x00030C00
+#define DDRSS_CTL_135_DATA 0x00030C00
+#define DDRSS_CTL_136_DATA 0x00030C00
+#define DDRSS_CTL_137_DATA 0x00030C00
 #define DDRSS_CTL_138_DATA 0x00000000
-#define DDRSS_CTL_139_DATA 0x0000AAA0
+#define DDRSS_CTL_139_DATA 0x00005550
 #define DDRSS_CTL_140_DATA 0x00000000
 #define DDRSS_CTL_141_DATA 0x00000000
 #define DDRSS_CTL_142_DATA 0x00000000
@@ -178,7 +179,7 @@
 #define DDRSS_CTL_162_DATA 0x0E0A0907
 #define DDRSS_CTL_163_DATA 0x0A090000
 #define DDRSS_CTL_164_DATA 0x0A090701
-#define DDRSS_CTL_165_DATA 0x0000000E
+#define DDRSS_CTL_165_DATA 0x0000080E
 #define DDRSS_CTL_166_DATA 0x00040003
 #define DDRSS_CTL_167_DATA 0x00000007
 #define DDRSS_CTL_168_DATA 0x00000000
@@ -219,22 +220,22 @@
 #define DDRSS_CTL_203_DATA 0x00000000
 #define DDRSS_CTL_204_DATA 0x00042400
 #define DDRSS_CTL_205_DATA 0x00000301
-#define DDRSS_CTL_206_DATA 0x00000000
+#define DDRSS_CTL_206_DATA 0x000000C0
 #define DDRSS_CTL_207_DATA 0x00000424
 #define DDRSS_CTL_208_DATA 0x00000301
-#define DDRSS_CTL_209_DATA 0x00000000
+#define DDRSS_CTL_209_DATA 0x000000C0
 #define DDRSS_CTL_210_DATA 0x00000424
 #define DDRSS_CTL_211_DATA 0x00000301
-#define DDRSS_CTL_212_DATA 0x00000000
+#define DDRSS_CTL_212_DATA 0x000000C0
 #define DDRSS_CTL_213_DATA 0x00000424
 #define DDRSS_CTL_214_DATA 0x00000301
-#define DDRSS_CTL_215_DATA 0x00000000
+#define DDRSS_CTL_215_DATA 0x000000C0
 #define DDRSS_CTL_216_DATA 0x00000424
 #define DDRSS_CTL_217_DATA 0x00000301
-#define DDRSS_CTL_218_DATA 0x00000000
+#define DDRSS_CTL_218_DATA 0x000000C0
 #define DDRSS_CTL_219_DATA 0x00000424
 #define DDRSS_CTL_220_DATA 0x00000301
-#define DDRSS_CTL_221_DATA 0x00000000
+#define DDRSS_CTL_221_DATA 0x000000C0
 #define DDRSS_CTL_222_DATA 0x00000000
 #define DDRSS_CTL_223_DATA 0x00000000
 #define DDRSS_CTL_224_DATA 0x00000000
@@ -243,12 +244,12 @@
 #define DDRSS_CTL_227_DATA 0x00000000
 #define DDRSS_CTL_228_DATA 0x00000000
 #define DDRSS_CTL_229_DATA 0x00000000
-#define DDRSS_CTL_230_DATA 0x00000000
-#define DDRSS_CTL_231_DATA 0x00000000
-#define DDRSS_CTL_232_DATA 0x00000000
-#define DDRSS_CTL_233_DATA 0x00000000
-#define DDRSS_CTL_234_DATA 0x00000000
-#define DDRSS_CTL_235_DATA 0x00000000
+#define DDRSS_CTL_230_DATA 0x0000000C
+#define DDRSS_CTL_231_DATA 0x0000000C
+#define DDRSS_CTL_232_DATA 0x0000000C
+#define DDRSS_CTL_233_DATA 0x0000000C
+#define DDRSS_CTL_234_DATA 0x0000000C
+#define DDRSS_CTL_235_DATA 0x0000000C
 #define DDRSS_CTL_236_DATA 0x00001401
 #define DDRSS_CTL_237_DATA 0x00001401
 #define DDRSS_CTL_238_DATA 0x00001401
@@ -334,7 +335,7 @@
 #define DDRSS_CTL_318_DATA 0x3FFF0000
 #define DDRSS_CTL_319_DATA 0x000FFF00
 #define DDRSS_CTL_320_DATA 0xFFFFFFFF
-#define DDRSS_CTL_321_DATA 0x000FFF00
+#define DDRSS_CTL_321_DATA 0x00FFFF00
 #define DDRSS_CTL_322_DATA 0x0A000000
 #define DDRSS_CTL_323_DATA 0x0001FFFF
 #define DDRSS_CTL_324_DATA 0x01010101
@@ -343,7 +344,7 @@
 #define DDRSS_CTL_327_DATA 0x00000C01
 #define DDRSS_CTL_328_DATA 0x00000000
 #define DDRSS_CTL_329_DATA 0x00000000
-#define DDRSS_CTL_330_DATA 0x01000000
+#define DDRSS_CTL_330_DATA 0x00000000
 #define DDRSS_CTL_331_DATA 0x01000000
 #define DDRSS_CTL_332_DATA 0x00000100
 #define DDRSS_CTL_333_DATA 0x00010000
@@ -398,31 +399,31 @@
 #define DDRSS_CTL_382_DATA 0x00000000
 #define DDRSS_CTL_383_DATA 0x04000100
 #define DDRSS_CTL_384_DATA 0x1E000004
-#define DDRSS_CTL_385_DATA 0x000030C0
+#define DDRSS_CTL_385_DATA 0x00001860
 #define DDRSS_CTL_386_DATA 0x00000200
 #define DDRSS_CTL_387_DATA 0x00000200
 #define DDRSS_CTL_388_DATA 0x00000200
 #define DDRSS_CTL_389_DATA 0x00000200
-#define DDRSS_CTL_390_DATA 0x0000DB60
-#define DDRSS_CTL_391_DATA 0x0001E780
+#define DDRSS_CTL_390_DATA 0x00006DB0
+#define DDRSS_CTL_391_DATA 0x0000F3C0
 #define DDRSS_CTL_392_DATA 0x0C0D0302
 #define DDRSS_CTL_393_DATA 0x001E090A
-#define DDRSS_CTL_394_DATA 0x000030C0
+#define DDRSS_CTL_394_DATA 0x00001860
 #define DDRSS_CTL_395_DATA 0x00000200
 #define DDRSS_CTL_396_DATA 0x00000200
 #define DDRSS_CTL_397_DATA 0x00000200
 #define DDRSS_CTL_398_DATA 0x00000200
-#define DDRSS_CTL_399_DATA 0x0000DB60
-#define DDRSS_CTL_400_DATA 0x0001E780
+#define DDRSS_CTL_399_DATA 0x00006DB0
+#define DDRSS_CTL_400_DATA 0x0000F3C0
 #define DDRSS_CTL_401_DATA 0x0C0D0302
 #define DDRSS_CTL_402_DATA 0x001E090A
-#define DDRSS_CTL_403_DATA 0x000030C0
+#define DDRSS_CTL_403_DATA 0x00001860
 #define DDRSS_CTL_404_DATA 0x00000200
 #define DDRSS_CTL_405_DATA 0x00000200
 #define DDRSS_CTL_406_DATA 0x00000200
 #define DDRSS_CTL_407_DATA 0x00000200
-#define DDRSS_CTL_408_DATA 0x0000DB60
-#define DDRSS_CTL_409_DATA 0x0001E780
+#define DDRSS_CTL_408_DATA 0x00006DB0
+#define DDRSS_CTL_409_DATA 0x0000F3C0
 #define DDRSS_CTL_410_DATA 0x0C0D0302
 #define DDRSS_CTL_411_DATA 0x0000090A
 #define DDRSS_CTL_412_DATA 0x00000000
@@ -607,16 +608,16 @@
 #define DDRSS_PI_168_DATA 0x0000003A
 #define DDRSS_PI_169_DATA 0x0004003A
 #define DDRSS_PI_170_DATA 0x04000400
-#define DDRSS_PI_171_DATA 0x68040009
+#define DDRSS_PI_171_DATA 0xC8040009
 #define DDRSS_PI_172_DATA 0x0400091C
-#define DDRSS_PI_173_DATA 0x00091C68
-#define DDRSS_PI_174_DATA 0x001C6804
+#define DDRSS_PI_173_DATA 0x00091CC8
+#define DDRSS_PI_174_DATA 0x001CC804
 #define DDRSS_PI_175_DATA 0x00000118
-#define DDRSS_PI_176_DATA 0x00001860
+#define DDRSS_PI_176_DATA 0x00000C30
 #define DDRSS_PI_177_DATA 0x00000118
-#define DDRSS_PI_178_DATA 0x00001860
+#define DDRSS_PI_178_DATA 0x00000C30
 #define DDRSS_PI_179_DATA 0x00000118
-#define DDRSS_PI_180_DATA 0x04001860
+#define DDRSS_PI_180_DATA 0x04000C30
 #define DDRSS_PI_181_DATA 0x01010404
 #define DDRSS_PI_182_DATA 0x00001901
 #define DDRSS_PI_183_DATA 0x00190019
@@ -667,28 +668,28 @@
 #define DDRSS_PI_228_DATA 0x1F0F0053
 #define DDRSS_PI_229_DATA 0x05000001
 #define DDRSS_PI_230_DATA 0x00010A0D
-#define DDRSS_PI_231_DATA 0x0D0C0700
+#define DDRSS_PI_231_DATA 0x0C0B0700
 #define DDRSS_PI_232_DATA 0x000D0605
-#define DDRSS_PI_233_DATA 0x0000C570
+#define DDRSS_PI_233_DATA 0x000062B8
 #define DDRSS_PI_234_DATA 0x0000001D
 #define DDRSS_PI_235_DATA 0x180A0800
-#define DDRSS_PI_236_DATA 0x0C071C1C
-#define DDRSS_PI_237_DATA 0x0D06050D
-#define DDRSS_PI_238_DATA 0x0000C570
+#define DDRSS_PI_236_DATA 0x0B071C1C
+#define DDRSS_PI_237_DATA 0x0D06050C
+#define DDRSS_PI_238_DATA 0x000062B8
 #define DDRSS_PI_239_DATA 0x0000001D
 #define DDRSS_PI_240_DATA 0x180A0800
-#define DDRSS_PI_241_DATA 0x0C071C1C
-#define DDRSS_PI_242_DATA 0x0D06050D
-#define DDRSS_PI_243_DATA 0x0000C570
+#define DDRSS_PI_241_DATA 0x0B071C1C
+#define DDRSS_PI_242_DATA 0x0D06050C
+#define DDRSS_PI_243_DATA 0x000062B8
 #define DDRSS_PI_244_DATA 0x0000001D
 #define DDRSS_PI_245_DATA 0x180A0800
 #define DDRSS_PI_246_DATA 0x00001C1C
-#define DDRSS_PI_247_DATA 0x000030C0
-#define DDRSS_PI_248_DATA 0x0001E780
-#define DDRSS_PI_249_DATA 0x000030C0
-#define DDRSS_PI_250_DATA 0x0001E780
-#define DDRSS_PI_251_DATA 0x000030C0
-#define DDRSS_PI_252_DATA 0x0001E780
+#define DDRSS_PI_247_DATA 0x00001860
+#define DDRSS_PI_248_DATA 0x0000F3C0
+#define DDRSS_PI_249_DATA 0x00001860
+#define DDRSS_PI_250_DATA 0x0000F3C0
+#define DDRSS_PI_251_DATA 0x00001860
+#define DDRSS_PI_252_DATA 0x0000F3C0
 #define DDRSS_PI_253_DATA 0x02550255
 #define DDRSS_PI_254_DATA 0x03030255
 #define DDRSS_PI_255_DATA 0x00025503
@@ -735,49 +736,49 @@
 #define DDRSS_PI_296_DATA 0x00000000
 #define DDRSS_PI_297_DATA 0x00000424
 #define DDRSS_PI_298_DATA 0x00000301
-#define DDRSS_PI_299_DATA 0x00000000
+#define DDRSS_PI_299_DATA 0x000000C0
 #define DDRSS_PI_300_DATA 0x00000000
-#define DDRSS_PI_301_DATA 0x00000000
+#define DDRSS_PI_301_DATA 0x0000000C
 #define DDRSS_PI_302_DATA 0x00001401
 #define DDRSS_PI_303_DATA 0x00000493
 #define DDRSS_PI_304_DATA 0x00000000
 #define DDRSS_PI_305_DATA 0x00000424
 #define DDRSS_PI_306_DATA 0x00000301
-#define DDRSS_PI_307_DATA 0x00000000
+#define DDRSS_PI_307_DATA 0x000000C0
 #define DDRSS_PI_308_DATA 0x00000000
-#define DDRSS_PI_309_DATA 0x00000000
+#define DDRSS_PI_309_DATA 0x0000000C
 #define DDRSS_PI_310_DATA 0x00001401
 #define DDRSS_PI_311_DATA 0x00000493
 #define DDRSS_PI_312_DATA 0x00000000
 #define DDRSS_PI_313_DATA 0x00000424
 #define DDRSS_PI_314_DATA 0x00000301
-#define DDRSS_PI_315_DATA 0x00000000
+#define DDRSS_PI_315_DATA 0x000000C0
 #define DDRSS_PI_316_DATA 0x00000000
-#define DDRSS_PI_317_DATA 0x00000000
+#define DDRSS_PI_317_DATA 0x0000000C
 #define DDRSS_PI_318_DATA 0x00001401
 #define DDRSS_PI_319_DATA 0x00000493
 #define DDRSS_PI_320_DATA 0x00000000
 #define DDRSS_PI_321_DATA 0x00000424
 #define DDRSS_PI_322_DATA 0x00000301
-#define DDRSS_PI_323_DATA 0x00000000
+#define DDRSS_PI_323_DATA 0x000000C0
 #define DDRSS_PI_324_DATA 0x00000000
-#define DDRSS_PI_325_DATA 0x00000000
+#define DDRSS_PI_325_DATA 0x0000000C
 #define DDRSS_PI_326_DATA 0x00001401
 #define DDRSS_PI_327_DATA 0x00000493
 #define DDRSS_PI_328_DATA 0x00000000
 #define DDRSS_PI_329_DATA 0x00000424
 #define DDRSS_PI_330_DATA 0x00000301
-#define DDRSS_PI_331_DATA 0x00000000
+#define DDRSS_PI_331_DATA 0x000000C0
 #define DDRSS_PI_332_DATA 0x00000000
-#define DDRSS_PI_333_DATA 0x00000000
+#define DDRSS_PI_333_DATA 0x0000000C
 #define DDRSS_PI_334_DATA 0x00001401
 #define DDRSS_PI_335_DATA 0x00000493
 #define DDRSS_PI_336_DATA 0x00000000
 #define DDRSS_PI_337_DATA 0x00000424
 #define DDRSS_PI_338_DATA 0x00000301
-#define DDRSS_PI_339_DATA 0x00000000
+#define DDRSS_PI_339_DATA 0x000000C0
 #define DDRSS_PI_340_DATA 0x00000000
-#define DDRSS_PI_341_DATA 0x00000000
+#define DDRSS_PI_341_DATA 0x0000000C
 #define DDRSS_PI_342_DATA 0x00001401
 #define DDRSS_PI_343_DATA 0x00000493
 #define DDRSS_PI_344_DATA 0x00000000
@@ -901,7 +902,7 @@
 #define DDRSS_PHY_117_DATA 0x00800080
 #define DDRSS_PHY_118_DATA 0x00800080
 #define DDRSS_PHY_119_DATA 0x01000080
-#define DDRSS_PHY_120_DATA 0x01A00000
+#define DDRSS_PHY_120_DATA 0x01000000
 #define DDRSS_PHY_121_DATA 0x00000000
 #define DDRSS_PHY_122_DATA 0x00000000
 #define DDRSS_PHY_123_DATA 0x00080200
@@ -1157,7 +1158,7 @@
 #define DDRSS_PHY_373_DATA 0x00800080
 #define DDRSS_PHY_374_DATA 0x00800080
 #define DDRSS_PHY_375_DATA 0x01000080
-#define DDRSS_PHY_376_DATA 0x01A00000
+#define DDRSS_PHY_376_DATA 0x01000000
 #define DDRSS_PHY_377_DATA 0x00000000
 #define DDRSS_PHY_378_DATA 0x00000000
 #define DDRSS_PHY_379_DATA 0x00080200
@@ -2115,7 +2116,7 @@
 #define DDRSS_PHY_1331_DATA 0x00004410
 #define DDRSS_PHY_1332_DATA 0x00000000
 #define DDRSS_PHY_1333_DATA 0x00000046
-#define DDRSS_PHY_1334_DATA 0x00010000
+#define DDRSS_PHY_1334_DATA 0x00000400
 #define DDRSS_PHY_1335_DATA 0x00000008
 #define DDRSS_PHY_1336_DATA 0x00000000
 #define DDRSS_PHY_1337_DATA 0x00000000
@@ -2152,7 +2153,7 @@
 #define DDRSS_PHY_1368_DATA 0x00000002
 #define DDRSS_PHY_1369_DATA 0x00000100
 #define DDRSS_PHY_1370_DATA 0x00000000
-#define DDRSS_PHY_1371_DATA 0x0001F7C0
+#define DDRSS_PHY_1371_DATA 0x00000FC3
 #define DDRSS_PHY_1372_DATA 0x00020002
 #define DDRSS_PHY_1373_DATA 0x00000000
 #define DDRSS_PHY_1374_DATA 0x00001142
@@ -2186,4 +2187,4 @@
 #define DDRSS_PHY_1402_DATA 0x01990000
 #define DDRSS_PHY_1403_DATA 0x300D3F11
 #define DDRSS_PHY_1404_DATA 0x01990000
-#define DDRSS_PHY_1405_DATA 0x20040001
+#define DDRSS_PHY_1405_DATA 0x20040004
-- 
2.48.1

