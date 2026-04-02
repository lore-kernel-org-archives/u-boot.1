Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E1C1112247
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9139584118;
	Thu,  2 Apr 2026 02:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jZNg+YLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DC784113; Thu,  2 Apr 2026 02:14:45 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F86484056
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObobNvoOP8/h2mf6RZy7JEkT+L3XsLG9jGpUXwoezC+LZCemYa6lfGXxiE3avsEgPOHZQgHJOPLJrYpfCbyw1bFWQwtx0YU33yi5kMDDxMyk/w37yH7USmbzReBSuOycryebqrqa6T10Dyn4Aoq16oyYOAmgzxgfDpHic+gqKiVkX92Yj9EzqBgBJ0wcvfZwkWb0jrXNGOmuA3qc05MF0Qqfgp6LWevaCtf6DgM5KZ4VqEB8x6mZEVCD2YnsLsTmkHuD335JYfMszH2ooC8KYASlP5k0Wqft4UD9zF+jFbfFb16y7Ot/PHbJf2YMRbwQPc0v+3HB3/ZGXoxiTYW6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKOsfII2Dp+yuGfFlBUSdnfW5SXDD+u0rlaVQdix7r8=;
 b=j/P0Dy+RTQlaa/WkDNYOD9nsXJysBH03uhGSRthC3x30ALoYWng0H//+MekJNBCC6VaoFcMhHrsYsn7OXDu98S3qH4hYV3TJg+Zwzm74FmtBTVz/RYFkJzbryiU4MvImMiLdTTMkfmN/YcttLuz8V6wam39YskRwFwjYYW99XhgAEwzatvowIRckp3+P1hzHBIaXdrrizubUoAUw4YerfkJFOP6RXW+/IcyZrZkA0LWrENWBITtN8wQixE3Zwv3lK9M7GoRESQSa+XKTBCONEVavKNKzyOXcECovq0PTWDHN67ogLOlbT0c4wKjf2pzwya20viTWraUKFTO8OtgJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKOsfII2Dp+yuGfFlBUSdnfW5SXDD+u0rlaVQdix7r8=;
 b=jZNg+YLVuRIVIXP+BvvYVGKkeHshzRpu+jY+12Mi7JtlRvgrBNrQ44NvE41fMg2E3oWuZzDMF+5QA3iyZw0Oy2U3yhmXsQPNyoqbsImMG/bMq2pj7ZlqoPg3NtX1UXiCWx3wlLd7xiCiQjBQLpE2jPbitGmHEIp/HyvPil2HGTE=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by DS5PR10MB997707.namprd10.prod.outlook.com (2603:10b6:8:341::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 00:14:40 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a5) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Thu,
 2 Apr 2026 00:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 00:14:40 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:21 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:14:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:14:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320EKsB1004385;
 Wed, 1 Apr 2026 19:14:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 1/6] lmb: add LMB_FDT for fdt reserved regions
Date: Wed, 1 Apr 2026 19:14:05 -0500
Message-ID: <20260402001410.3736815-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001410.3736815-1-rs@ti.com>
References: <20260402001410.3736815-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS5PR10MB997707:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcdcb49-dc40-456b-35e2-08de904cd567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: bMW+QtgMiHRmYn1lDvpLEc4jmfa4cRUMptRWt8iclJIBDnDn1TwAWBof8r/h3m6a06JiWNQ3thHnbuXK4Hsk6KmUaX+yGYWuvSfleQ7N4RLRzZsGt6mciGa0H2PmEuy3zI7vRwmGoKEi4qGCv+xvLPFdjCpzX+3gQ+xZoio6HC18ZO/Q7/RwnVGU283Vn2jWPMbc8SOu4hYA6QJqAyUtSV3qeV8suYiwYo8YS8dX/rczZWpxJzDld2FkmPdmO1pIBEylUTEied+hQnRYUTSONMBu8UpXdqqG9IDhQJOWkSpJgnCWU4tQvDYMNdIeHD4GLjWFO5Teurg0vr4MStynY1GH5qJhb4OIYz+tynEzVpQJFe1sj4EdFQlntX7OxqV6vnGm8O/KRMSysVMyr2dYchhO9Bh2MqWqYx4LmEOHw0AJxBI2ZXBoBn6RgeY2lg0ZvF5kCIS18b4HutSGDxCN0WgU6plihx67yUptWMBw4Xw8fhXPR2pzbpA9Bin6pfk+wDT/IP9d4sPqH/EETlfJkQHnmpAlwn1PYtHZGhMoWBgInKyHLeswrr4GEqLrirVus5w6b+/5sVDJtoVuwnKCF1iTCWpwHg0zFrii6C2a3bSburFD6pZr7+uKh1GDsmMeJwgtzE8BhNi4wY7MifsEXslCJLE+lMTGslsYir14/bRFqaqF9BL+Z4LkKqp0b+mAr12o3rbD5qZE+8ytoYs7QMngH16aZ8ndi4/U7onZMCMVLZv7L97rFQ+eQ8cF1LM7W6KZ9wY+rZVdCeWMJh3tmQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qm+yCNLmE1SU74dpQVh8XgNCn0/ZY0A94jkkm9j9HmW5Hph7kiYu9cHZxT8W52F0yKieoFlWaaZe7XoaDJ0og7FlD2zdzBj25s7yW1sknbjjBIJpwKo3p+MdQ4t80W82DQdEW1m9BMv7VOk436LygifP3kswPl4+gyUNzzMUAROhclAdgpVJPmzLZUe0YBveDOlRRSy3C+fDFTtRk7BE8WaF6ysKBuKHEcRWufnrmbn6mWZgghfEnEtyg+xcsDSDd2Anddlu4JdtYTfKlVfvI1B4aDWW11YWOoZqmRqkr6eI5Gfb5f8ZuU/9fqQXwVcD15yDzmIttiOIGyywcwuAVnFF99ZIRq2zi9e5g1Fuej4/L4npKJWlfiQ8fkEX9iTy41vtX3RLqsfPrKryrFtN0xY2UFtJTWzpD4yNMoInAUdRcMxk2IrMSJQdLJdJbb70
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:14:40.4101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcdcb49-dc40-456b-35e2-08de904cd567
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997707
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
 include/lmb.h    |  7 +++++++
 lib/lmb.c        | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

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
index 5d5f037ccb9..1b59a63f61d 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -25,11 +25,13 @@
  * %LMB_NOMAP: Don't add to MMU configuration
  * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
  * %LMB_NONOTIFY: Do not notify other modules of changes to this memory region
+ * %LMB_FDT: A FDT reserved region that can be reclaimed if the FDT changes
  */
 #define LMB_NONE 0
 #define LMB_NOMAP BIT(1)
 #define LMB_NOOVERWRITE BIT(2)
 #define LMB_NONOTIFY BIT(3)
+#define LMB_FDT BIT(4)
 
 /**
  * enum lmb_mem_type - type of memory allocation request
@@ -215,6 +217,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
  */
 long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
 
+/**
+ * lmb_free_fdt_regions() - Reclaim all LMB_FDT tagged reserved regions
+ */
+void lmb_free_fdt_regions(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index e2d9fe86c14..542bb11dcf5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -669,6 +669,29 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
 	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
 }
 
+void lmb_free_fdt_regions(void)
+{
+	struct alist *lmb_rgn_lst = &lmb.used_mem;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+	long ret;
+
+	for (int i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t base = rgn[i].base;
+		phys_size_t size = rgn[i].size;
+		u32 flags = rgn[i].flags;
+
+		if (flags & LMB_FDT) {
+			ret = lmb_free(base, size, flags);
+			if (ret < 0) {
+				printf("Unable to free FDT memory at 0x%08lx",
+				       (ulong)base);
+				continue;
+			}
+			i--;
+		}
+	}
+}
+
 static int _lmb_alloc_base(phys_size_t size, ulong align,
 			   phys_addr_t *addr, u32 flags)
 {
-- 
2.53.0

