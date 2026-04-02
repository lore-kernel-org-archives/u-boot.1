Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B511112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052DC80517;
	Thu,  2 Apr 2026 02:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iglIHacq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C209983D8A; Thu,  2 Apr 2026 02:14:32 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A6284011
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNSMr2PfqHNdzg7B+kkNsu++6jeA9ttcWvKIf7kVawOhdcusUHspavt8tiV15G9IrkSeL04bNomgosbq42jNCH5huufwik/b2p3HApCZ461VmiQzYCaM2nIoVMm1imJUjJEigJ3X1XcJ0dnkOhSiB7LRrVkbdfhsnTwa+D3nZ2PhFfuynVy4edTQV8MTS5u3Qzpe3bImDSzx4msgu5WqODd5tlbxduDPP9AYxPONPrgs6XJdo+YRWiV46X4t3ThJGRpszB3OHwQPFZKkDaxXICiSGROe37bwNWemnq1hjb8K13Y3MSt0GKEjNv04ysEDMvClyUpGursqQnjC4NEHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPc6DMG5Yu+scxWkuVOP/T+FezA3X9fPYltU6uS3Bqg=;
 b=IiAk8HbOfxK24Fjp9oIZ3z5IbJh/IHmzZl4oY48qIQ5WLLUcItr9xMyP8fAlVO8HZvCAQlzuEUXX7CvSpLzdC0RcNJYKwKh/ybAI8d6GvTPeO88TJ8pio99c2N0TCXMy2YqRu47PZ0mh2tqd/vObhw2l+520UL2lSXyFvlChgtFPrrREY4xOfau0FsKmtyvxUGD9fe+A5R6Sogz1BZekyLkVZz9dAnb8wsk6G0v9irQETiEZAMEvaTlokx6/qSuV0apBdwuKlTdWlmkjE6n6+B3gVmxH4L1dG/ZvEeiYeN6m0TXbNel60uAD83DKzVL76sEJFjlUzFpj+f68U1mtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPc6DMG5Yu+scxWkuVOP/T+FezA3X9fPYltU6uS3Bqg=;
 b=iglIHacqk2dOOTi00ai360Wxr+iRYpCIrF/BQxGZ0isZ2tN3ITbUN1cSkc25yggBxudesln+WungAZyBEEMABvIZP/xHrjjBkckVLR43RXwQ2MW67l027AjGmtCS7Uuy75vVW0jti0pxeCQ5vaIomQof6JIxxVNopWRCvzJivxQ=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 00:14:24 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::35) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 00:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 00:14:24 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:21 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsF1004385;
 Wed, 1 Apr 2026 19:14:21 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 5/6] efi_memory: backfill EFI_CONVENTIONAL_MEMORY
Date: Wed, 1 Apr 2026 19:14:09 -0500
Message-ID: <20260402001410.3736815-6-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf69ec6-6b10-44bf-0c60-08de904ccbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ROQ6VBlahYWvSZC1AyYpyGfNcX2FKquQCFOuxUZsAAmbmeTXxZayIq+gC+Px8p9nwaOwQImz94oFIRM+9tk+OSCO+L2iHygS5Esj1BWvxBQvTXRglvvOBkWBQTXC1WKXLbpT2uIrArumdh6riXAOxGo5KigpdNOHHsHqLOU0QUTF//J48jIQs8mhLTaUY+oOabDdN0SxNHJ4sV7+WzJ2pCMprZBkzNmcNGIrT/0zuYLiVvou87uqwS1Y8l1ANUz/6MlYaxKB9yMx1/OJEfcMzuD57hqVD5m3rWnqQPDjKHCjporM93W7ST62XubHSKO+DUv0r3AaLWfVwuWdHWDVRNyVgAfjKJHASSfErcamgqvO6LWchoMVkpmFfqIuwcf9EvMTx734nHIdYprbaJQDTF8ZhR7T1x8eRwjanRE4uqAwnGqId0og6RzUt7jNkhY1cGm5k02WaLiaT+06b3ih2I1X0l0FBSzLHrIvwlp4Ytprd41hiGiOIlbXJpyx1RJLZua7YOGr96e6AUY/cHSf4iJqG0vqKDvwxcZCoOAGLZMbVwEWGV+HmhZcqmQdXrfDhcJPam2ZWSoG5y+X2Qj002H6pp9nIZDX+TgzE6XP4q5Sa2x4G9Mton22LIPIpqiJ+IBc0WU2QSCchetHTUD/UG0hqLqKAmAZuIMSclTsgn/FUPipU2lA51a73eIw4ujdeq6KcjFfwRWe1HrsroryiHG7ASnhjpfmYxLGtjPvPNq4rFg0yEJk0k+fCZS2OYCWU/ZcPeTwggxAgkO4PFtyIQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8j3AdpG0DrafrLXZD/k2Hd8c+WdHsytw+FettolQlx2v4pOI1a8e6DPQNFae88tIwKlTbpsPHRGZdg31NcGcIxWY4dGE4ntmO2CLT2/3aMVtBIFRtOf2cNFHYZyyBSdax3tZ6i3FCaMHJm4tzwhbC0Npx/anl2WGDdR7h7r5LWT+X4inM4c4i/khu2lCUwaX7UtiPY15fDHmaNnwBZuZC6zI8SYimIZ01AN5Qwy9ocTeZq+Xz1yIjzyiYMEEHifuz5FyT7QIf9KpGU+aoUi+sw8G1VNSQHYNh3c6c5Q57MdA/mcMRAlkp3krmQMU0KwRu7a5C5Qnjr08uvSTnHXKfg1n4kIEXtx2GTiJA8rCd8FMQW6e/DG+JPJtuShUaYcfzufKxYWXQRwmnn79eZTuTd4qE2JctVeu8WyF0q0o4mEobQEhT3qmNxHIrrBh07Lw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:24.4994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf69ec6-6b10-44bf-0c60-08de904ccbe6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
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

From: Randolph Sapp <rs@ti.com>

Backfill any fragmented EFI_CONVENTIONAL_MEMORY when LMB allocations
start to fail. This may be a low memory environment, or maybe LMB is
running up against a tricky reserved region.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_memory.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 882366a9f8a..f07cc39b157 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -441,6 +441,27 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 	return EFI_NOT_FOUND;
 }
 
+/**
+ * efi_get_conventional_start - find the highest conventional region start
+ *                              address with at least the specified number of
+ *                              pages
+ *
+ * @pages:                      number of pages required to be in that carveout
+ * Return:                      starting address of the give carveout
+ */
+static u64 efi_get_conventional_start(u64 pages)
+{
+	struct efi_mem_list *item;
+
+	list_for_each_entry(item, &efi_mem, link) {
+		if (item->desc.type != EFI_CONVENTIONAL_MEMORY)
+			continue;
+		if (item->desc.num_pages >= pages)
+			return item->desc.physical_start;
+	}
+	return 0;
+}
+
 /**
  * efi_allocate_pages - allocate memory pages
  *
@@ -507,10 +528,20 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	/* Reserve that map in our memory maps */
 	ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);
 	if (ret != EFI_SUCCESS) {
-		/* Map would overlap, bail out */
+		/* Map would overlap, try something else */
 		lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
 		unmap_sysmem((void *)(uintptr_t)efi_addr);
-		return  EFI_OUT_OF_RESOURCES;
+
+		/* See if there is any EFI_CONVENTIONAL_MEMORY allocations */
+		if (type != EFI_ALLOCATE_ADDRESS) {
+			*memory = efi_get_conventional_start(pages);
+			if (*memory != 0)
+				return efi_allocate_pages(EFI_ALLOCATE_ADDRESS,
+							  memory_type, pages,
+							  memory);
+		}
+
+		return EFI_OUT_OF_RESOURCES;
 	}
 
 	*memory = efi_addr;
-- 
2.53.0

