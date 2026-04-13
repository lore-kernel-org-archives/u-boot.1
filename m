Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DECF531C7
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7365C84223;
	Mon, 13 Apr 2026 22:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RyV6OnuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4BD84214; Mon, 13 Apr 2026 22:36:28 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1A7841C2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbEk0oYgiFe9SKRnTQpgKN5rH4YIPxIxVCsoOTyj0wEgLSYpdoxlBBfUTbb6hGcgF9bbNwze2aZQQBbm7uVpWt61ldPsc9413/5ZZn9zGepl0m+kQSIJ/09wyzG6JMSX8OWCR6n7qw2cX+fzk2EcWLS3lmRvdSUtDJJHAHG3fhcNjftp+LvAJ2iilDaJx1JM7Y1zel6MhrngcMd48eCHEKWgeDN6rVhAihPA08+X3ptUZR2vG11pLAdlAka/jmJfRgjKOpoXsGHktZLwZuaU8CM3FbliqCH5LY1yICEYzho1ah+OB9QJt38atC3Evz13qNe4Dj73v2hH3M7Cj6EEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQKpbcJEKnKinlEEbpc+8bgMb8B6S3eq7rICLTbSouk=;
 b=bk5ZGo/VSckk0Hm/JlevIlqtE4QteMC4FagW6cTEOmDh4Wq98Xz2ZmsbL3KvKm/NPlL+FEmYYjZyrWrn/nfXjKaDuN8O5HAxpHheXNWpCcdEimjcPiZhvZRusis6W/MpEJT8Um6AjBtzFRC3Lxb4D3J0HpdvnfC0NVAbgJF02qDxTreHCS3UQd7jsXN0jAH39eyfAxmdtJc3XJPIvKgv9Gueu2ZHyAdcX9WF2LYgoJpodAMmXtFkt7Gqvikz82fkeUtCWXituU1PlWkPLbz4RcGKp5fuBwZ/t1qJj4hkHfUPlYoU6OB/lhS3/R7Nzhg/GVWOtDvonKs6Yb3oKD92eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQKpbcJEKnKinlEEbpc+8bgMb8B6S3eq7rICLTbSouk=;
 b=RyV6OnuSEERpv+v6aTzuQb85oAp8YHx+E8ZwlTMh3BLC+47sm/n8eqHacabDdZf4oYmAUrkAkQiGF8GQWjqQcyEu7WT9bgdGd7YmMXcud9qxJ0GatgMvMRg44PLdpg/B41rjjurEC2mWacFa2ts8+zZBIHz/gM137RFqe1+P3ns=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 20:36:23 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::87) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 20:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:21 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsc2729634;
 Mon, 13 Apr 2026 15:36:12 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
Date: Mon, 13 Apr 2026 15:35:51 -0500
Message-ID: <20260413203555.1990337-3-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413203555.1990337-1-rs@ti.com>
References: <20260413203555.1990337-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 861ba52c-fe1b-4222-84f4-08de999c52ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SNpJSC3VTQWQe8Fe4XqZsxWYIE/o1+D58kU9/3tgsGulRjuPgTlDgkIGJRaoo/K0VsjEXyKD3tBWBroHXkZk7YepcDQZDH5T+8o1hGADaXw6i1zAaAegHDKE46zg+sacNm/jeuiSv9E6goTC/HzXleC8iXa+amZZpLwp3UE6kasDSte/JjOJGv9BP0JtdD0eus7MD/XMR/DCEze8XnL/fr8Q43BujHG4ilUWxkH/hU1imgAZcDa4PGu0fmiY8J9F0RQhAB1aAj5nYXSWKv5LtdvXHWTZKgk1AqpRodfY1oql9P4tV0XbXo90Enpwr/E1iDw4Fg9PzT9nmjBAjDtAEinLVPlJ0oAVVV2+mgd71tnhIeBv7NKGenUvw6NQu1TL5kgISTp068C86G5IvXN0BKfO2VdzdTROJjdtHzYz3/2Jpwg5ht1MOKhLlmSlUDqT0/4w3G4jG5HvUHHXQYo3m/ynno2CyqWhXWIz6MVRCXVcfEJkxl0ffXvP1VPMP2U63z9tHd8cmaB/Fbt24E5yF6mhps+wizsDvd0SG10KCbpNdgwJp+HqbbyqlKRtxmyAWMBp7XF9Nxqyjfnn1DYL/jqIrekmt10fgwDdsBaRyoKqp2Gqus8v3WDlbkW1B94+my9d0Qvzidqv8rRez+GMxX1JvDoRmKyifuqYj9cOXVmKapZgjI/wjtOisd0ka/W+6Khrm4OQG5ufeLPRUD3PvoKaiEFUd5r8mi3qpoXK2eikeCT02NxUNLSKFS/6rrlDqcPpSa2lqtUEprE0GHEf7Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jOyiH8nVzrDizS9q0hCWT+FJq/Tms2nU422cLFUfnjgscEGBajAgwiFjrVuySAsaZz/duYW+LYcX5BiBtvgKNMEu7q8/A7d1s2yzBcQVIy2RD/EE7Mb/YI0Lt6zuQpN2mdtVQ1u5dl6UHg7yrOdE3iePElydSIRXLB0mTnhUeyW1s4SIHiDDlf7x1UJWfk9o+joxHIR0GwAEYvBGi9clPshVz7YkCClEy/i/MmUVMmw8RLrqu5t23dRw2j4esw0NQBYD8mjPw3lGx4VNfaLK9u5QAUQsj8iX3+slEmxNjDkwdJwWqysEMida8zefJ6KRHgnihnUnBNtqcQm+0a2zyem9x3GQgP7Pt2i5Yof/BGI9NYP+ZXtEWBKAhbr7Kt03uhAXH6c4PzqSE5Guputvk8WAGhz8AR8Ni3ZiF+/Of/rJb/nBq3v4zESNC+2EmZr7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:21.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861ba52c-fe1b-4222-84f4-08de999c52ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
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

Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
parsing a new device tree and properly warn people when a reservation
overlaps with an existing allocation.

If we don't at least warn the user of these reservation failures,
there's a chance that this region could be freed and reallocated for
something important later.

This useful warning mechanism was broken in:
5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 boot/image-fdt.c |  5 ++++-
 include/lmb.h    | 14 ++++++++++++++
 lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558..0f5857f24d2 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
 {
 	long ret;
 	phys_addr_t rsv_addr;
+	flags |= LMB_FDT;
 
 	rsv_addr = (phys_addr_t)addr;
 	ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
@@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else if (ret != -EEXIST && ret != -EINVAL) {
+	} else if (ret != -EINVAL) {
 		puts("ERROR: reserving fdt memory region failed ");
 		printf("(addr=%llx size=%llx flags=%x)\n",
 		       (unsigned long long)addr,
@@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	if (fdt_check_header(fdt_blob) != 0)
 		return;
 
+	lmb_free_fdt_regions();
+
 	/* process memreserve sections */
 	total = fdt_num_mem_rsv(fdt_blob);
 	for (i = 0; i < total; i++) {
diff --git a/include/lmb.h b/include/lmb.h
index 427d701bc30..c6a1fc1ca47 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -51,6 +51,15 @@
  */
 #define LMB_NONOTIFY BIT(3)
 
+/**
+ * define LMB_FDT - reclaim this region with lmb_free_fdt_regions()
+ *
+ * LMB Memory region attribute flag to indicate that the region will be
+ * reclaimed with lmb_free_fdt_regions(). This allows device tree reservations
+ * to be cleaned up and tracked more granularly.
+ */
+#define LMB_FDT BIT(4)
+
 /**
  * enum lmb_mem_type - type of memory allocation request
  * @LMB_MEM_ALLOC_ADDR:	request for a particular region of memory
@@ -235,6 +244,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
  */
 long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
 
+/**
+ * lmb_free_fdt_regions() - Reclaim all %LMB_FDT tagged reserved regions
+ */
+void lmb_free_fdt_regions(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index 8f12c6ad8e5..7ecc548d831 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -463,10 +463,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
 
 static void lmb_print_region_flags(u32 flags)
 {
-	const char * const flag_str[] = { "none", "no-map", "no-overwrite",
-					  "no-notify" };
-	unsigned int pflags = flags &
-			      (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
+	const char *const flag_str[] = { "none", "no-map", "no-overwrite",
+					 "no-notify", "fdt" };
+	unsigned int pflags =
+		flags & (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY | LMB_FDT);
 
 	if (flags != pflags) {
 		printf("invalid %#x\n", flags);
@@ -654,6 +654,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
 	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
 }
 
+void lmb_free_fdt_regions(void)
+{
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+	long ret;
+	int i = 0;
+
+	while (i < lmb_rgn_lst->count) {
+		phys_addr_t base = rgn[i].base;
+		phys_size_t size = rgn[i].size;
+		u32 flags = rgn[i].flags;
+
+		if (flags & LMB_FDT) {
+			ret = lmb_free(base, size, flags);
+			if (ret < 0) {
+				printf("Unable to free FDT memory at 0x%08lx\n",
+				       (ulong)base);
+				i++;
+			}
+		} else {
+			i++;
+		}
+	}
+}
+
 static int _lmb_alloc_base(phys_size_t size, ulong align,
 			   phys_addr_t *addr, u32 flags)
 {
-- 
2.53.0

