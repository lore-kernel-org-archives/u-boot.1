Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12664EE208C
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 11:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6904383B95;
	Fri,  6 Feb 2026 12:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pXU24yPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C0283AAD; Fri,  6 Feb 2026 12:05:30 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F19B8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 12:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=t-pratham@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLvh8WJgRdBapYI2yjoE+3vRGE8oYjPLJMeVqbzpZgjIJhOjYMnJVHfn8F+0gycCAeOE/lbqLxU2YSXX53dfOXGLAG1s3mWc7iO+AfwzZWY3lzK2JVuJiEF2fUke56iYiZ8fG/cgVErSGGQALCmx48XibY+1KjhKRfC9/DB9vlpHHz04AemvzvxrwEhZH7PiOXiYsI5OMxbG1PhuhdAWeraLjZt57DgNeyk/E1dIBoRrHScy3paXJTxF72/eawEKNYn5OHaiGUv27U8KetJmUFmOYLg33SBECxOvTbqxF1AEgOLAbLARxI9NfsF+sF/a6b9JTBfJBajrW8oB4Bg/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCMAotRWKFHQZx8f7CyWdmenIk1Xw+mt2pgxCwf9L34=;
 b=TcQ7KZozurKr7TRTfviBtDsgCP2DID120q6M6kHfO/S4rNLKNg178b2/p2NZ4xLOEKTkRvcGFpnL47Q/rO7FVzOXUMSs2GGX1DHGU/Pb5Im3ZWszKxDSPXDtxgjeW0JGJUIbGuw0aOLnbY1+QYAdxe3dXrnHvVMHkKtNLyXMkfCi2PUzrzIbiDoXulX4TwjvjDUTIrrpCtPcKer1BYbHDGNNVYF671wptmQPVWMzB/Wpv8IwGryevOVN+/oXDh7QakYD0BgsRxX5PaEk68CVHxsjB/Gpishduo67bxOPsXw+VSXWj2Shb6qM8bFL/8GT9QNCA7DX9bnc4cF5/6k9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCMAotRWKFHQZx8f7CyWdmenIk1Xw+mt2pgxCwf9L34=;
 b=pXU24yPPjJF1svgJ7mQ0teSsxhsTBI4pbkR0dSFwScMiEtKMkbcaGmWSxQDUZBj1UhZK1hMCYwoWsXDSuMY4h3nA9QIp0RE8g6AwMkdSYt3E++Ic24Eo21OBnHqvANmlEwU6FStjTE+5EOHH0/PYuvCLyEzDL4fQVVuPuX2pZzQ=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Fri, 6 Feb
 2026 11:05:25 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::85) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:05:24 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:23 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 05:05:22 -0600
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com
 [10.24.69.191])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616B5L1n686932;
 Fri, 6 Feb 2026 05:05:22 -0600
From: T Pratham <t-pratham@ti.com>
To: <u-boot@lists.denx.de>
CC: T Pratham <t-pratham@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, "Vishal
 Mahaveer" <vishalm@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Andrew Davis
 <afd@ti.com>, Ryan Eatmon <reatmon@ti.com>, Neha Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm: dts: k3-binman: update custMpk to use
 signing-key-path node
Date: Fri, 6 Feb 2026 16:34:39 +0530
Message-ID: <20260206110439.1236201-3-t-pratham@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206110439.1236201-1-t-pratham@ti.com>
References: <20260206110439.1236201-1-t-pratham@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a77ffc-c7e3-493c-24bd-08de656fa0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FinnvTCoiCh/d2/mFRn/YNulC1WOi0kwznkIa0WZi4K57q3AZU+6JnHDgn9N?=
 =?us-ascii?Q?FHzNxDd1FB9Dg7nsMTQDXArDbB9iA5N+KDry6dFr0s1COJyO1N2MgY2NJ7fe?=
 =?us-ascii?Q?OIjWsGuL1fGQsrRt8HZmGe0K9Wa3rNLtBem9Upo6Q+MgQ0MKdfroUwEdOJr0?=
 =?us-ascii?Q?iUP101SlPC+JWl0sSktCmigN6ho2hTJKbKIVf6M8Hd8WM3856c7eL1ugmm83?=
 =?us-ascii?Q?YKWIIpmgDXMgMmpn9OcD3kX4DbwVeuZMt6yBoWoxnp1NLf2AeUGOqw11B8aP?=
 =?us-ascii?Q?tjVrrLRFsUngxKFlnjCqg9S4cq2EwOCt2GIxjIJb9/XfI4vaaE4VqLplbzAi?=
 =?us-ascii?Q?zza9gWbrflU+ga1XTFhdBV3L4qtyp8gXWmUH8BqUVbLum7wBFYyNyx0La71H?=
 =?us-ascii?Q?FCEbok6y7jHL1r2HV8sRVGG7RKnSrNTjU8Re+AxaI2uv8OSnGZuOIBhAZIh7?=
 =?us-ascii?Q?KkMaXenFSYEzPsmjGmqcHV2yOOv3FnBSNEEeGqFMXGUwYMuOufml8ICLbwZb?=
 =?us-ascii?Q?zUWhRgSzzkTd9I5oaYV1Yv2A17AURMQIPbpsb+H5/zxPXEu2/lQjxMNRvkmC?=
 =?us-ascii?Q?R48tslJ1/5lPnFRLse9Ls7xusLIIhepA65Hesj6w3rUuqXhw7lYlCitz0QNH?=
 =?us-ascii?Q?tLy5Y6G5aUljOXHojnASaqTWJ06UUlNN3PcEWcIi3lsW8q2QgbAjX2FFWD9x?=
 =?us-ascii?Q?k8HczboQhRjqJvQFBy1kKaQhKmt6n4JEHqyRO/ViDcGnIsrM/VX/2DERfHEf?=
 =?us-ascii?Q?jdykeHyBuxRqJ3nyHIY6qfXSq6ZzMP55Nh6C5VkBZMVCVzTvaL1etMcsJ9b2?=
 =?us-ascii?Q?eWsNKkYy2ZezkKgPL2MOfQi2YBfQ4kVyU813q1zyZp26ImyivbQxaAbSsxx/?=
 =?us-ascii?Q?eBvraJny3CRlVNVSIxlY1L3EMRP9OKt7UfDKNp/Sg+DB5gVQbxLDsxK/kPhP?=
 =?us-ascii?Q?XUSim5cziYFaTahUKb9c9rjfWmCoAek4MdwsoSYmQwi4GgMt/3VvOXmr+URz?=
 =?us-ascii?Q?psW5BJFPLUy2e6PBjKIOsfz85VyCYdzZahmwYelrA/+eEB9MQ/S9D+GV05fj?=
 =?us-ascii?Q?rjndRgszUnls5XYf5XGMetF9B+8T8H52oJ6WoHxw6trZoFTadEFPEGCmTaVn?=
 =?us-ascii?Q?vcN+2ezWDpTDD2iFm2sPntA8g78y1owQGJasdiGm5EhEOCDYvXkyEsMa0ZsL?=
 =?us-ascii?Q?QA3e69p/by9lXIdWWj41uspQeYPEB242Tyo/Zx8ZaEyGJbqhpe/XmeT6hFa9?=
 =?us-ascii?Q?2P6bG96e+zX9Etm+ch2ZPc2qbYdbXcJlJdZqDpPcMFdvYgDmlYlW9tO8GghQ?=
 =?us-ascii?Q?xrcduSEM12vFJVbNObP/H32pE90/oYs/yEfWQHacUBU9kFzhHt6PTfZZRXgC?=
 =?us-ascii?Q?G7ouPQFcGfI3Qt0WPV8dreZQ4X2K9e5RrZAfNQeWS/tWYJ/Hw62fqrSAYSWa?=
 =?us-ascii?Q?+PYI1k526dtWgKfitYmcvCjnlgWSBhYa+tmhnz7j5tdpooJGO6XGX/zXPcV5?=
 =?us-ascii?Q?wutXXSnUOi/1oKlaqZJjUrkr+3M0FoP4b5Bt1JDMPm0b0jDTYnujnRO8sl7z?=
 =?us-ascii?Q?88W+iOeZO5nV5Pea3cBCeRAF+C1BZkJIfzib65ll2gv8N5pC5wumgnPIXw8r?=
 =?us-ascii?Q?B0+odduWagD3M1nrgLEvbAD9OqA9bHLWdiE79Md9lABmcagqQeqS8AfgPO5q?=
 =?us-ascii?Q?7uPxpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P/9PJJM0s2q9/himnFRpi++iUDRJtK/zc6q4r0gXPU9hXHJ4HIQMCKEXLJgAPYhrJsZ5iefdGdTRlEpaFsmuEPTq2ruJf28/ISo45omo8ye6L+l98xXdiKMx147kuZR/Xz09O1Q+aQPR8ag5gr/r4rxFVdihMHWFPzFkE8FTfKmkLQ3jZot7ofuPLA6M2ncR08uonoN6cGucLwRG+RWvCslg/Ve33t9kZ4mwEUelfmQ7JSRItW923BjESmq7mTep2nMSHXgu+CpTy9Um/VZPgWE5+hIBggL5Nv1TUyAoOgDCt7YFHP7IlBsc8FmgUZ6X9chUvUVWBr80rxiMLc2oDNXX3iTmihyNeIWv7EKJmVlBY+FqfwGspzsmWvYhHi0cW31g/08zSlUElNWONjwOe0uGiVzNR0VcslA+r/HkMocY5REAfE0c3Ghr61d1++QE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:05:24.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a77ffc-c7e3-493c-24bd-08de656fa0f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643
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

Update the custMpk node in binman to use signing-key-path to use a
custom key provided for signing bootloader images. In case the
SIGNING_KEY argument is not provided during build, fallback to the
example key in U-boot arch/arm/mach-k3/keys/custMpk.pem

Signed-off-by: T Pratham <t-pratham@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..51404513561 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -14,7 +14,7 @@
 &binman {
 	custMpk {
 		filename = "custMpk.pem";
-		custmpk_pem: blob-ext {
+		signing-key-path {
 			filename = "arch/arm/mach-k3/keys/custMpk.pem";
 		};
 	};
-- 
2.34.1

