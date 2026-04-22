Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603FFA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40899843E0;
	Wed, 22 Apr 2026 19:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A+OoE+BF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C45484333; Wed, 22 Apr 2026 19:10:07 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66356843D6
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHRabA6Rk9pcW58fYHe3QjjEUwhbq8CXV46ybxnnbWO8lgqJVz7qihttPsuLf7Ry2/Oso0AXVZsoWVp0yD/ggT4PmqgpDH7fMbJidMw1OpYs88Nhw/dDRygu1SmNKssRxRcp+2/Usfpm36U25Gn4DPTSkQqutaAX0gBhEHh9SC757hn3RBiDJaMpZZZ/7Aodu6RVk6P/a4QdQAmrzyPFaaA5k1ho/0wJAwBKgVMOc8xg0JT98nkbE+FxzVgT1adBXZ2+2PKhF/vV6p86PgfcFakRDlRboKezAVccDnMmZ/J0cvJvJpA54UQSR6bNGDKLOeFBJAZlna/fljXfegKtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdcTv0+2zoc9+J4qVs/bczbAwtIlqvAH2DxqeUNyNWo=;
 b=kagIK5At8f6gW8Fscytd5WwZl6M8ZszKWrQrVaiBR3BtK26tXfXKEJi6Om442uX9iBxuRHmI41Z/EIogiAhBOFZWk5fSg18Oleyk9MnI0qJrX3S0srm1OsP7iKJKZ0nFrrCojfHHTmizbgmPFvm4XZEd8ez7jRT1cXyLzSobbxxtiNWc6Im57Lb70lU/rkUxjrVneknk022XRAO/YRMllF6ZRf8EMgii/z2TRuCQhZKGePq0cjXvAQrl2KPUM7wWQ2mh5LwLW+fcVylH76NCsmlkx2SCMO3Ehxz7Y2/RACJRYXi2GUTnq3WNKb3P6zCaxJDcxBsvrm10JXm155A8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdcTv0+2zoc9+J4qVs/bczbAwtIlqvAH2DxqeUNyNWo=;
 b=A+OoE+BFT90cX9uZjB83bGzSw0nZeU4jNgni7z5/ilh+zwQu0KEvWks/+o7v1lO7hZ3Y9U7X9xT44jbSHc9wwEFj9NrJDlvTga/2x7v04qX/D+BlyG/H+dvK8T8taPvtkAIMwXRcZThYvDtHDDdkgIwy9l71o9SheCJyntNBT7U=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CH5PR10MB997695.namprd10.prod.outlook.com (2603:10b6:610:2ee::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 17:10:02 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::1e) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:10:00 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPP2769561;
 Wed, 22 Apr 2026 12:09:57 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 5/6] efi_mem_sort: use list_for_each_entry_safe instead
Date: Wed, 22 Apr 2026 12:09:45 -0500
Message-ID: <20260422170946.3394481-6-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
References: <20260422170946.3394481-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH5PR10MB997695:EE_
X-MS-Office365-Filtering-Correlation-Id: 747a0ab1-9fe7-464e-96de-08dea091fcb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zVf1Y8rpcfThfBBxhKcmiobsYAsNxJcqXLpGub9jpQlIkQFh/ii8pXryhguLnb2YMXOCckZHqwdhF6WPEw+ORlzSjsjRUG0gLYhC+sEb56vcuBIf+h2x3kJJD8eyacq0NNCvZDwGhLSXVTPXHCpdKuIux4cafzfzW+P9fHLk+I640uToU8niH7k4a6NKaGKT2AiQi7WaZt+qK/8pjUM1Hl42d960cHp8aL0tbPFNsrNxEoESLgmIVMhPa9b70371gMd6gY4u0vB6C5rqleVIVgyWctUhaV/zqxeSoh9BQS+dAHu0Uop+w+i+OlSbJG36w7AI8gs1fayqytYvnwm+2ijYmWRHyDD5V36EWh+Z4TcX53hVRbAiiQ9ZiLmw4Z6cyE2EkjSEcjpLkSCXFSHaAQGtwmodJYaWr+UAyaUAfOGHzb/y+4iNq8oFsPvhzIQJKviZ8Rq4UP9nbbp/+P46EbvHxIGOqOb0k6OqNfFyPabtqrYXoKJYjbZrMzk7ai/HEoRrgzD2EeLI+eq8iWCaimz+cgM8IcHh7pMc/3wc+5uBUAn7KxyycFmVNSHjNYr1QA4CtRIpXjHoGupw2WpD0cEpeWRv10+R7+TmKC428uhTz7o24zkLn02HddANdlKxVNbU9knMT1+b14fTyLxC7P4WMCD2ZIEkyVI5jR13FaFBA8ZuExkSPC0tnuQ49mkTcXyQkCdLfcIpG89eiuOHwRHT5fIObQycCCWJSalbdmNXGlo8PyAmLxwAm09AADoOSfo5L9kUB6y6EVQT1LkxpA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7I7IgTBY2tp5kt7ADY5I3wbiEBJSDi/F7XGJYTvuY2j+ChPv3eUqYMwNoE9HSQAKijf51y9DI9Ez1+ysePeKkoSYyi49//DKpE7JHCJ7YcgZyrhE3e5zuK3y4TeOkJb4Gzd+oxoiuqUaD6OhuUNaHU/I4EXgmW1puINgurksbJq8le5aowWELKjF10aOSQfFpEZ+26e1VVvOuIpHmrM0UgjlhAAJWBeWd2mcE+ptLV4n038+APTkn3Sbg2P50wTPKXTaPzs/mlmPMzTRUgyoyz460vZE98kgJTmEfdv8zNaeWXAruPTTXBOw/cX/dH50yOpPurwskLrsvA7DAZdewvfmHF96ZIsuuYfDUnlyRb8BJxHwP1CDdVzTFXiCnn8KGL97TRrvovgr+RcoUTi3P+hE0HaK2/UwB0LkwsuPk1/+bxN/UXD2I+HIpGRCNVdA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:10:00.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747a0ab1-9fe7-464e-96de-08dea091fcb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997695
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/efi_loader/efi_memory.c | 47 +++++++++++++------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..046a2bb4641 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -128,44 +128,29 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
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
+		if (&nextmem->link == &efi_mem)
+			break;
 
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

