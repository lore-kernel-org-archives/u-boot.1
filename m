Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0B1EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69355840F6;
	Wed, 31 Dec 2025 18:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ug6rbkki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED62840DE; Wed, 31 Dec 2025 18:36:47 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A19884105
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT6yOXlCOzlfm2tlYE5QFwd/oZl1q4j/RNTE1pnEBPmiBTEFXss4Nb0+yvfczIk6EUHsGkdDZ8Q1yrWRTpgMsIqvPChPO4mQ9OZuK85/kglAfX14+a1MYqgoHBJ18fAkCDFyxOHlzNN/k7sHEupTmRI08btV/WPuHZEo5CQ8bzxJ8mk5knfUgct1QXaBwGjpZfSvHVMXPxv/nCHRK3FeHbhx7a8zA1p6iw7bioDIXTDR7io4Lt90Q0cJrM+bu7YoUm5+bBtb4zixvL/bVqzeDdPm9JaI7YOUe16M0h9ztk+o+u+7RUhS78XI50Byn3X5ehN8YQXb20xj4IMtxNNUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIlfB8ivqiCtB1QeppKhhiNGbQkPMBZcbUzr1WRUDeE=;
 b=mTBxp6tY1dHFCa7a4DHljoj8DhlohrQTYvcZMLwOWMFRLMb+MY2ldIettASXsMsbjFAsY6KtW+sKFuK/Ezlk+RWVtEGmLVroF9bYP/E3vNVGoFe/5EuWdJQt4pDyowRJL0oXF1kvufGgoG59CIpBkKpqxxg188OR45+D6VnaTyp5Dt6x/hmOoyt4DnoqANiHj559wgIQnlyDMgFt9nJVOS6FNK0I1uLnH/+Jg2N2Qa6seIZ33ZPh3AH/bu45ODT0zBERrKZjR939516Y0AabBq+G+Cnm8o262F9zJ/yYNmfts3mk0VrwdpvA3dc5QYno2sB6FV/htUgR5d2H1WPI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIlfB8ivqiCtB1QeppKhhiNGbQkPMBZcbUzr1WRUDeE=;
 b=ug6rbkkiACl2KTa8oi4j11U8eN5Lm+vGjTILaS08XSRVi6QS8jooy+aWpYX0f4Lsp2M+UbD3+WBUl3Sc1ygZ4DYKBLJ5XxsWhuDggHzqesi14GlII8hycf1oJKV3ERu+owhNc+c6pHKxH3IDOwgYhqOpJH/HjjZWiGl7Up1ojHA=
Received: from BN9PR03CA0266.namprd03.prod.outlook.com (2603:10b6:408:ff::31)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:42 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::6d) by BN9PR03CA0266.outlook.office365.com
 (2603:10b6:408:ff::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:42 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:36 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:36 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqr2541396;
 Wed, 31 Dec 2025 11:36:33 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 02/11] arm: mach-k3: Use FIT image data addr as fallback if
 'load' prop is missing
Date: Wed, 31 Dec 2025 23:06:12 +0530
Message-ID: <20251231173621.1069988-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de24af6-40c9-4b99-4c33-08de4893293c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jjnXpqb6beFT7iHfI419SK54N2W8FKUoEAdoNCm9COLrVF6Cw4phscC7pcnM?=
 =?us-ascii?Q?BsFzeB/UtBLF3pFsWpAktmljAhaTcmxoUOAQ3BjrSM4YoXHVf7LrOuN5nSav?=
 =?us-ascii?Q?yUtu2edtoDLZf7J+VXV/oiYWd2pZPV6rUA2wHd6gl0sVwlJKWEu11s27WZe2?=
 =?us-ascii?Q?R2Q9glfPnehFWmWhk58g5WdqbOtFprRWVM/PCW4NH2JgxL4l/uSbXENHo31N?=
 =?us-ascii?Q?5nZ2RYITOPmhBIuuFtJIN/a0uXoGf/wSpsvO1Q89h7IF+rXUhfWSC2wLmy8z?=
 =?us-ascii?Q?nzmVxLhQiJyuCx8lC//ldAp+na9lN17bjSNv9YqolBXy9tOKXXoeYMqkYnyN?=
 =?us-ascii?Q?45/E8cObbA/9UBWi+kQs7XETxtLSoCCvDwwTncnk25PdF58pHuwi6Pz6Xfa9?=
 =?us-ascii?Q?Zar/YilFH7DxLBO2Zd426Y8ljAQXuUTmQSGZxX+Ef/l1Lj7/NiI+oSQ8hHt2?=
 =?us-ascii?Q?AAOIA1bDXrEIwIQoh/Y6FaKC3DtQlnEYArkeEwZ70dU2/q3+b1K+Cj3jsdPZ?=
 =?us-ascii?Q?cc0VQWNXQVIwhSYk/c+JG1rlr/bNFt4GjVgCsVtwWB9XTcru3ViKHtcUMJrb?=
 =?us-ascii?Q?hV5e3zeojsaSIFeIbP4+jCXwx6uY6p6i9PzvPc97z13uoGBQdzJPH0IFTOnV?=
 =?us-ascii?Q?p1lFLCLVgRvG1mL5uesn84qaOgf72MDosGXKEm+8bJcBYCpWyDcITJvJY9q9?=
 =?us-ascii?Q?dklmankAsnRdSenOj2RMYgHAbeZZ+c9WaDXpICusPXbg17mn1VaQ7xexXga+?=
 =?us-ascii?Q?WJo5zzoToVwflWnITLQYcMGJKfrkrO+P4GpAImQy/mutokXjzGrS2IO9bm1c?=
 =?us-ascii?Q?+AdHtnrJdhHV2Fs8GL4+dvQXUuxRugms6qH+lWPwSiT005wqkz1ofmLWflnz?=
 =?us-ascii?Q?BN7JcNf7uEcQJud9O0n82iO1uQWspqg7AqMBE6CN6UnCN47Fy4OmfYBUFsGV?=
 =?us-ascii?Q?tV7e9tUB2rHKkGbmZtTNcB7Wd4D5akkYm174JFv3PEPtxnxpS3XjdxmjqJDN?=
 =?us-ascii?Q?+gkBt7+goZhhZqsk0F0946f8gZPZfXBBuIjMHVvqrUNtkAPUdXbHesKXMe6/?=
 =?us-ascii?Q?be42J+SZNX5/8Uy7VUx9IDBs5PWjjj8mdlRkWAixASqk4JHduy5Lr0CKKLNZ?=
 =?us-ascii?Q?4CL3hZ4mN9DIfRhqHCPrMT8FZU1R5RkhINiIfgIf6Ryjts0oP5Pga6K7CXBd?=
 =?us-ascii?Q?e8F7xMM/RtgJ4pzJUdFnAK1kKbibyIuWRoN4WSUSge9/zA6FgBkF3oAeTWSs?=
 =?us-ascii?Q?ZGyguMFgQEmfQWbdtowi3sGbEGRaOrEs9SViFUIIkfaPKJ9LMaZJaZ0z96Ep?=
 =?us-ascii?Q?H1Q7IU8i1kpkLOfQZ1sHjPvYdJ0b4CktHYyd0DVcNUFyA3CuizWGsr9573r8?=
 =?us-ascii?Q?WS6xTMvu9rAYTdId4Nmj9gAGn49ylTxEyXZeE2ZHeZTVEGpsO2nyQmSOHrOF?=
 =?us-ascii?Q?KKjmBIsRNPKCCKQKzvJ3UKaDJJLNu/SzZ9vtqD7CTzkPaaqk8/rbcALHJ8NX?=
 =?us-ascii?Q?OyKtn9tfEz+hRTZM2iFgdQfMfBjucjVuXOHteYEjt/6kVYNm+h6zu6cZyhJu?=
 =?us-ascii?Q?4dMGKqjUsAqM6BuCdkw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:42.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de24af6-40c9-4b99-4c33-08de4893293c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
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

It is possible for FIT Images to skip mentioning the pre-defined 'load'
address property. In those cases, SPL uses the actual address of the FIT
Image data as the fallback load address. Use this FIT data address for
referencing the image when the 'load' property is missing.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-6-b-padhi@ti.com/

v2: Changelog:
1. New patch. Fetch FDT Data addr for accessing image if 'load' prop is
not present in node.

 arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 03638366046..390e1324fb9 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -328,12 +328,15 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
 {
 	int len;
-	int i;
+	int i, ret;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", -1);
 
 	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
 	      addr, *p_size, os);
@@ -342,6 +345,22 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
 			fit_image_info[i].image_len = *p_size;
+			/*
+			 * If the 'load' property is missing in the FIT image,
+			 * fall back to using the actual in-memory address of
+			 * the FIT image data.
+			 */
+			if (load_addr == -1) {
+				ret = fit_image_get_data(fit, node,
+							 &fit_image_loadaddr,
+							 &fit_image_size);
+				if (ret < 0)
+					panic("Error accessing node os = %s in FIT (%d)\n",
+					      os, ret);
+				fit_image_info[i].load = (ulong)fit_image_loadaddr;
+			} else {
+				fit_image_info[i].load = load_addr;
+			}
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
 		}
-- 
2.34.1

