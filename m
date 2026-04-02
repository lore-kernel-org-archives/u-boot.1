Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB6D6AB14
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4179D8408D;
	Thu,  2 Apr 2026 22:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KNf+VO0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C8380212; Thu,  2 Apr 2026 22:51:21 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C1A84056
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGXEThPuah+4Vp9Zy6V1aNWmL3TEw2u7Vvx+865Fow7JeVdVxaf8mqAXyvEqb1nJRDRL4j9yoHQ4IorOGCCDUziWGso2JylXz735ll3+yfrQ7d7XxHwAl3Kvv/Hhvyxu3B5pG5ymRn1BgCZxR/ku87Owi/FVpsspl8zTTq01PFbus28R/GSxKVYankRbmXKXat2WPeVtByGlZLBfRn27m0y5WXml9jzwLZa0tNvu6IwN7v7LgQFMaT7Ea57eDXF9QhM4xeFXkFY2sJ9sniBQSSCkFfUnZKbsGfMTlsrGZQhARo3HVD/xVfZpF4TkkSEddvQhqSd3z+evGU8NLh3gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GGKeCnV73W3aTCaY9Gzb+YH7LxviCucmxM588ysRNw=;
 b=Mc0HBHy4Q89a/MPIz/m2Sn6YHpYBwQCl5arm5mWG3yu5xxS6jqppD9BXF6iJzu1QBI/4zj2DNFjAg/JtRt2S8JMwdhU7qkxYtavO/Chk1F0UnVTysZEo3VzclA9uNH265H5Wk8q067JCbOzDXJg/FCJhDYlLKyZZvffpZ3MB+v065Y22Us1Uy0p9pBNVAmqJHS4+oSxlLzkIanpVCDYnh+iieeXMFmvDAKYJpcovULeyUcYeXorqVG0H4FNzj+tQ4s4TQ/chZoLOX2wvCKL7ck8qp2eNvYrMfyr6KEmmiI9HJ5XQMz3YUdobAipdHrmbvy86yZHdsiX26bgvyb1mlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GGKeCnV73W3aTCaY9Gzb+YH7LxviCucmxM588ysRNw=;
 b=KNf+VO0Xb3moHK8/xQtaNNSopJDfA01tkHwOmtiovnSQ6Ze2pDRIOw+EfQsKAjJTQRn9njp3qPCrsw+MxkBuRtVXP09A2xBN8gDxs5eLjmTaz4o+n+17PEYARIK9ycRVWvP/uT4zJm0zSiC0fpTjQw8rG1gQYcV5PT2SZ2snHNs=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by PH7PR10MB6105.namprd10.prod.outlook.com (2603:10b6:510:1fb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 20:51:16 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::2f) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 20:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:14 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bO2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 1/5] lmb: add LMB_FDT for fdt reserved regions
Date: Thu, 2 Apr 2026 15:50:34 -0500
Message-ID: <20260402205038.4005350-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205038.4005350-1-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR10MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ee2755-73d1-4931-f928-08de90f99489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zwag09mnC7WabxwgRHiQIIIUP7TRgKCW/8pKJwTdRUrT1eLxDsKrPLOi1W5JbQRgRm/zyQjDviq1/YxViz0WwVWpYkTlDyKTKlhAT1o7W6T/v1cR0SJZnGXmCl7pfXKuTho4YIIzGAfWOY7DtDHXSpAC0qVzkSsUQldL9mj08/q3453bfrwA0pcs/vvTg3gq/zPDWRZQBbH6ycyQtXWBDeG1NxOGusHaxHCuROwUY9pJuVgrQUh9+1r/U6V1l+uFv3Gyu1Z/zjg+EOM9CjQB3rsD2GTZBM/ZAswMCPwSyvrPTIItD4KDytG3xYJonHWf7yjhds2/Es9G2ygiC5Q5MkPTuINcV78xPsfrpI6eVqjLD7LGGGD8sag3GjVU/D+lBzqroMDmkDaG0noZPWyyM6MXL49EcwGE24yz1kvLEVw12A6J7Cx3qZ61JpdyQnVgnh/jOgm4+gK0ISDz4Q3bBaM7czzYQ8KmOZ6AIyNCxQv3D2oZcNcGg+i4hQ10LLB6ParMsqwTIugvRKOwci76s6+DGj8PQjFOOGT/M1MEqeF8TVYkoHhTCHY417VgPFPzjugWSs/8Fe0QFBjD6tqn7PVFNvGSibmuAib0vMqUJ5G+2av7xQoT7FRHX6WgyZ9COUE7SzOFT47K47V2KbR290/jV7pfPJUa6Y8Qa0uaKVpbnwXUWwLh3BUyn5ZIiwOqSzD/qMOWInuGgRZjcRowZJW7564sN7B+B41Pyop0Ui0aBKbAVCgq1XT1XxMAJZRrgVOFwdO7OiwbQvRcWUmJJw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BaT8O3fsV60jiFG7czEHWT7Mg6HfJFHjeYICxl8VCAnd6xUaXGnOnebcDgteUa1oPjaL5kxVlQ0RsEp94nOYK2QPAGLTUTJotsYg6VmBYq0fk78JdpH+TgDD7FfuG5+WK7RegmXq6G4+Tpm3pFN0buP0+r2haETspGt8FN26/za+0AojKuNBcC0GJSxjlos96ktoEXu7+X7ZjYSRxHhhNzysbDiECQ7vRKVa2FCN8fX3M55b0mK4A92RavZQgoC58SWtHEvj134LddXnx6dsFL9NAqo2bdlAHYm4XPCisAB/cYwp4Mc9o88g66udSh2k1IFhKfttj86nxttYd8jtRDiHuKWOHOXoftbSNB7ptvCzXMG1XaImUDUBmTQDd8AWyqvo7m3pBsWbYal6h1O41xmVzo5zpgL014fbj4hjkJONmezwfl4oxaI4RdgUHc6h
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:14.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ee2755-73d1-4931-f928-08de90f99489
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6105
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
 lib/lmb.c        | 25 +++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

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
index e2d9fe86c14..18703212afb 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -669,6 +669,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
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
+				printf("Unable to free FDT memory at 0x%08lx",
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

