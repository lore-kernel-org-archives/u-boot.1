Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9EF531CD
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2776F841F2;
	Mon, 13 Apr 2026 22:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AiW8Q1/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED3C8424E; Mon, 13 Apr 2026 22:36:37 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04820841F2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH5W9+GgtTvTxPlWNx8tkkPllWKN8pgTqWi4qjrJVxGWiA7zO+wxzt4gazrR6iDyjANm5LwEAaYGm6xoZxDo4X25sxh+LmUV9+b68m6KcLH2i/hsmB7fRvRYlpbh+mYjbcNKvi6GwsBI0hp5xnWZ/RyexfUrKPNL1TdxMwJOZ0GMZIetxKbGGhWyLb9ke+8y+iEoQXlv/4SzaXmC5RKMfBGXiQB6ffzMPhhStOYUAc8EPgT5OL+hmi3lfruJ/A/AQARlHyt0RHfrD5tKDsFFxz6yOZfekhYom6v5g27Xq54mxx+g0vUeBrxjrC1bqN6nMka+jmb9YUMOCFumxnvRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLgBWxzLMC9Ao6f8URF9xRpqcblEbBU/DFtHJc4P+z4=;
 b=WnpqI3KrSDQtvwWES+8w5T/N1Okzk5DSdqvp3oF4XM7RmC3EOEKyJwYP1EtytaWo7CBQ+Kpl0pOd8MCMC5c7pmEcSZTxp5QpA2QvcLBRvxeHqXE0cJX6AJOw8nek0Xm2o+i3VA669x+lc6YWaWlYcG1YJvUM1C1tih5OZwHoQqT+GuAiGliU8jbzJ98g4joexQhfuUVVSm+THXt0NVf4D6T4wJw3hpItiKKRXLx8wdPCpj8Xt6ysnnnzhmhSrvvkE6cokAKPXQ9SvY8MoquLk950AXB2etaKMl4D/pznGIV1WR4sbj3ju56BKMQpij+xgBqP4BMx4q604wl5EXva3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLgBWxzLMC9Ao6f8URF9xRpqcblEbBU/DFtHJc4P+z4=;
 b=AiW8Q1/Ojdtl/uWr6E30PYDBwrwQmEnNZ93k/gwhfHKO8Y9ufviprjNFAmFB5uqnlURimw9VHiwJkHkgWkNX/mXflqAnBpvYXP4rIBUsaHZakZJF2cthr5jajNGWYBXRtH1TRTYLLfGVMkWegvqoUSmT6SutXgrn9SPhUJwy6kE=
Received: from SJ0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:a03:2c2::18)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:31 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::8b) by SJ0PR13CA0043.outlook.office365.com
 (2603:10b6:a03:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 20:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:29 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsf2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 5/6] efi_mem_sort: use list_for_each_entry_safe instead
Date: Mon, 13 Apr 2026 15:35:54 -0500
Message-ID: <20260413203555.1990337-6-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ee20b0-91b2-406b-a4a2-08de999c57b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DvaHWnJ5s2ah9TiJfUidsEQG6d1HNgxTNAzlxoC2K2Iw8CxEhsfqmQcT0gpOH3yGD0OLqP+5wLmngtEd8LH80uWLxx6SugEbdF/+Ox5No7haytFeUW+0ODDNC8nse91gA87kTxmU6FFb8JErzlh/BKwL7qrJ9q96Mhf8P9O3L49VOD0wshvsEZcT8v+hqnLWMIDl5PFzd9KOXiSlvbbs105cVgpG5fgcPwnEOLcdqiEXQP4Gw3xszViNFRJXlfSzFz5fvQ8d0KQNxc2fdUek1qpTd5eyj2lR5laOrYkClixYNjcgWrwWzLkvXIALpWG0QwtuPSw0NnUva98IXv5b6G7uJ+YTraT+RwcPZDWI73MCt4/HMyJVQLwtoeWBbfjY9F2bzgRLX1EYDYponzsmj8VQgzlJ5LJD1YbNhgUolV4z+rspLhmeA1skjagow7S3LYRB9ijnXVnbVqQaYqlF72xbqUrhxc0GTIysSLSnhqsH4rAOxjitSFchk64LBOUhjZkjc+zpnzM8so6LfMOmNshwiDTvwkRYnhuzEMMNMVLsPAZakcgLC5l2aJXak0xFWUPfvzdoVakcOq2tr+1avPuc5gt7HXqhyHbRrAQnPiKa9iYJ+mTeJ7EZSNqj07rIBHNwipBi2yKfJiqQa4v/ikmlDkBV0xYMHFKHZLr8u9iojeBXEE9b80UJUfkt8SbpBXNGRuQlrrGA63nQZI9GKjs0o8pljFg/QEf35RaKgJGHG48OnGYj0ZA3wKxHXmCjMq89t/R6ykcDC6smIG/O8A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHyEElVoSrnceQubCcSVHUYDH7pp/6yd11qusNYEWGMh/izoHFfygFe1xTuYA7LiYtZoxRnR56JKabskeCmLVxbxNEdXacaQmhqdT8W9UII1tN4ijWj6kzPmbaE9wVb0PDPun/XoOzCav0yKedvQuwJnKommws3EKNWB10H4qzB7iQbcIcld61Fa9aRiicTApTj5aFxiQg8ukEuDsoBUcoh85IDv0KaUkN7FcATpeHiUtrpr7/aB6ChTAB+Mft4O4igrivBCmo6mWGouF/t0adMh1BsaTcOkmom9LaRX/GonHCYGlPsylRZ9VuC26dx+IF7b6jjHtUrnc05Ukav6fYvCQR4Z5QlvZyp132b16QQTApsL7vzbRxPB/IzoU0gZfGiJaxhjwGF0K2cz8hUKVKSIASDs8UmzOdOy9dG9qnQFW2fgb/qnBcho6Pi9ybOS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:29.7177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ee20b0-91b2-406b-a4a2-08de999c57b2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
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

Use list_for_each_entry_safe and comparisons against the current and
next efi_mem_desc. This reduces the computation required for merging
regions, prevents unnecessary additional iterations of the list, and
requires less temporary values.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_memory.c | 48 +++++++++++++------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..b3b292ebf56 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -128,44 +128,30 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
  */
 static void efi_mem_sort(void)
 {
-	struct efi_mem_list *lmem;
-	struct efi_mem_list *prevmem = NULL;
-	bool merge_again = true;
+	struct efi_mem_list *curmem, *nextmem = NULL;
 
 	list_sort(NULL, &efi_mem, efi_mem_cmp);
 
 	/* Now merge entries that can be merged */
-	while (merge_again) {
-		merge_again = false;
-		list_for_each_entry(lmem, &efi_mem, link) {
-			struct efi_mem_desc *prev;
-			struct efi_mem_desc *cur;
-			uint64_t pages;
+	list_for_each_entry_safe(curmem, nextmem, &efi_mem, link) {
+		struct efi_mem_desc *cur;
+		struct efi_mem_desc *next;
 
-			if (!prevmem) {
-				prevmem = lmem;
-				continue;
-			}
+		/* Exit when we've got nothing to compare with */
+		if (&nextmem->link == &efi_mem) {
+			break;
+		}
 
-			cur = &lmem->desc;
-			prev = &prevmem->desc;
-
-			if ((desc_get_end(cur) == prev->physical_start) &&
-			    (prev->type == cur->type) &&
-			    (prev->attribute == cur->attribute)) {
-				/* There is an existing map before, reuse it */
-				pages = cur->num_pages;
-				prev->num_pages += pages;
-				prev->physical_start -= pages << EFI_PAGE_SHIFT;
-				prev->virtual_start -= pages << EFI_PAGE_SHIFT;
-				list_del(&lmem->link);
-				free(lmem);
-
-				merge_again = true;
-				break;
-			}
+		cur = &curmem->desc;
+		next = &nextmem->desc;
 
-			prevmem = lmem;
+		if ((cur->physical_start == desc_get_end(next)) &&
+		    (cur->type == next->type) &&
+		    (cur->attribute == next->attribute)) {
+			/* There is another similar map coming up, reuse it */
+			next->num_pages += cur->num_pages;
+			list_del(&curmem->link);
+			free(curmem);
 		}
 	}
 }
-- 
2.53.0

