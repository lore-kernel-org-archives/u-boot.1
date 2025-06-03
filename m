Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD0C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A908F8291D;
	Tue,  3 Jun 2025 13:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XRhS1Hgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B230281E72; Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C4781FFC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xImw6t8CTOQZjuFUuSm0jI9vyfQfz+CxnRuyvL/Op4Nz4sGnAAec72Z9I/sOWC4PPd9aYTU9u5VYI3tYrdzIG2jl/tl2Sf1lnuhQyZ7kxV9LawPmY4nfYLzkkqaeboONulhbJ+mgVhYew8TaJlAbetnBCy5Grj6ZIQK34AEztBxLIR7hXg509BBaAPR4akjsFXUVNGbp7CfrowvkeCIDTwTYj0CAoQf0gmw31hT5RFlZuF+ENSyVxdbTu3P1xG/Xr8qHkgdy0xkw0Ju8tfkzTCrW4VGGZUl4pq0uJVZIxIhx1dHBM/RPd92qjd0xquhDw49h6AGcsRLx/uZEUnBhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BN9YlbZFudAva4BJgx+z+B15y33uADByxK+x1o45+4=;
 b=pd7MCu0aEQkMnbfmMeIuduT59g7licmGZzNjFOd5wLUIL3enBDt6XEXh2hRIirzNo3AXCBziI9OakotOhqh2KDPSLmmRtwFNeMPs5pptRCazwqm1MJ0RjQH9887FXS/NoK5nXr1Oc9aUjb5PHzEa+LosVG40E3/fsuwF46CihHk17Ss84YYeoM20JTQeOttql/aOI44Zdl5dLgNF9kkIk5bxzdQHlRbGef8bVl6rzeDfWSCo7jEfN4eODBJlHv8MIG7NUJPPokeQGJxseQL6CMSUrwiMLRdHIIrUSUKashKlru5Z340+F1mr480rU4Vl7Ijjaef18ys3YTrfMfv2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BN9YlbZFudAva4BJgx+z+B15y33uADByxK+x1o45+4=;
 b=XRhS1HgzkvHwO4pFqvEl+AEGAU+Y+X6L48zKYFrmQXGfJoS/eQW6m5l3B1sgBcKTmit18lKUDHc2h85qJJF03yToq2dzFFKXig86g1XTzD6XFGP5xsOYJLFxpApDE8lmenYjNMjxPA0B8d+n+AZxZpk+lH7eVxniKxgiuk+V0k+NTxruUWV+gBY9lZkMaHbHPiE+GAnq7e2lbzAnGmrcKox1qKdnl3GUyh5WNkGMfWHXD/FGBFsjlgqzqc5rRqqSJ3qA/SXVnAnA2/WEhRbIw8AFHm8FcrYdfu82FqgsS0tBj8c/FEg+tsbiDajqONbnf03/UE6LaokJ92MSGPKnow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:55:00 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:55:00 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with Dcache
Date: Tue,  3 Jun 2025 04:54:41 -0700
Message-Id: <20250603115442.19971-7-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6886bf35-df4e-4897-9926-08dda29577d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mn8y87XfLdy10THMrOrLpOgYFop3hF5USxWqN+7EL7RAkfniWi5gMDlBK0hF?=
 =?us-ascii?Q?xe2aWD8RZlys/pZmtL+UsObf24lXhZiCh1VFiyU5Lj9FzN6zxe5v3K3iS5Q0?=
 =?us-ascii?Q?Z0fPThxVsJ85YT34KyK9lQ7J9dkRG3WkYHntG8i6c03rQKVuCzWV2aExy6Zi?=
 =?us-ascii?Q?XUVtuehVMhF95eFVge4T4jWQuYL7nL+1OIsiGqf7iAcDsxJxQ49b3pOBcyGW?=
 =?us-ascii?Q?LQ6Re3+MavTKDO3ERn+SSZ95TG+ihrQ5NFPxMEXzO4yh9HaFeRP5UGBpPuER?=
 =?us-ascii?Q?Ni3COnsudzuU2U616FkMHnkwWsEK1ogz4OA64YUBuvm2i974OHFL0f1G6h3c?=
 =?us-ascii?Q?dZ87kOPvDA1+7/mE7wWpSlaaMqwbw4h/jB1/EF3Zcz7FnezWP5POf5S+fxvA?=
 =?us-ascii?Q?6kvovsddRr8bG1crs0Qlk9i6bfq7BL+NgKA4lWpB+1ietyvh0WaCNoUiaTcY?=
 =?us-ascii?Q?nC3qRprs0JP7k7LgbnLnzPzlvqD2HF0K4k1W4rQyzdY/uabzxTvSKIXyB6ki?=
 =?us-ascii?Q?11U4tqx9Nom+xhGAMcRS1QVmYPaQrrsI33R/TrGIkhSL1Nex6MJ5+sTWIGMd?=
 =?us-ascii?Q?IdmOH9k4wy2wIpmu1nj3yOwri0Fb3ILRpcPMn8Z5prQ/Pc7kQS+wDXI1DtIp?=
 =?us-ascii?Q?vfUpyJSGmqbK70sYxlh+P3dU9HclWkbBAiOaEBUpLf7kunbyoJ2zSOtdG72s?=
 =?us-ascii?Q?Q3B7gYUz9gSIPrPoV/j4g5XtI9bCGn32GtMzNpMC+etQzjRB6kfXGjdFqHvE?=
 =?us-ascii?Q?G5Si1pT54SCPYg3hN/xPbRhh7GsjTXm68Y5j5DK51hSPe7mj2PcMCZH3QyRz?=
 =?us-ascii?Q?oppb11IdSathBsD0IBxN5BAjBlj1bmUrhxov3V1JJniMBIE/p0XadQctBwqy?=
 =?us-ascii?Q?m/LzF7wmlcG90nqePgxAS3oi0t7MfvThn5PkGxHJA5JvEmZtRlvaCpFRv4AL?=
 =?us-ascii?Q?2jTkHOIr0TBJLlroi7R2EmqcRnXCH1uAFLdzqUSlCjlwHw1tCk9hk8JFo5hS?=
 =?us-ascii?Q?8o/XdQSbqw01pJSNUvqgDg8xp6xR8LnlV72pHIvC10T80ATQCwjAs+vNaZRN?=
 =?us-ascii?Q?Ge2RprJ2FYtHFf0CwdgKJBn2DuK0gXDqJYTUnp6cGfh51aq+EBvLEdkwiMgf?=
 =?us-ascii?Q?VO0i59xnqHLwl9eDnHZ2k+1ZwpqTsDpA+ZKLqdHUxCDMLv2c9zpZ5SKbt/rI?=
 =?us-ascii?Q?HVavF8w/3i0+W5iV5luDO7QkJgR7FgWTkVZNG1qQRmT5CDK2F9P6kIF9rx60?=
 =?us-ascii?Q?WCLYrJD9kFEYnP3zupb24UzZr2vAyCwQ5I3xPY7rLid3yXE11678J606cKDG?=
 =?us-ascii?Q?CmsqB5daZ4y4v7ayBKD0cYKFqMPq6FB2rMIXVqQLdfFQ5tKSYJZ91JKwNXw1?=
 =?us-ascii?Q?faLwCRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5SpPl/D0G4MSxv2attrG8684QZ53Gl4sNk7BKO/HY0OZZXYKokDVnEximCr?=
 =?us-ascii?Q?KKbr7Dp/4U4WfBCpdbpQFnD4NELqLz7OJNv3fCWc1M1GsqYLgS47veFlkhYb?=
 =?us-ascii?Q?P6IMIgvlTluYbUC8NyOF6/lFQoPvu24OplYL9yGxXqQbcE22HY6AJKPbfpJ1?=
 =?us-ascii?Q?/MC1ZJ4zCIMH3QC6roTXN+gJdtkos0dzIMtta1qzpPzpxVK1Udxb7nx1LdzK?=
 =?us-ascii?Q?UZGHLzv9dBL41T+2EUOoU9IC420UE5B5YqTuJxvFm/vS2dwPJdyllDWHEqjt?=
 =?us-ascii?Q?nyf0NpKFXWICMBgYlB8LeGjrpyZgkxXuxMuO4Cz5uu4zuqm9U6fisGoZ3MWv?=
 =?us-ascii?Q?otMpuWU6fPa2GG7eL0ky71mbhd/0Tiz0KYl/hhfSZiMcKmHHrsdzpV+1/b9B?=
 =?us-ascii?Q?xDrNA+oY4aS0yLZ53jsuVPqRk9TaJXAWzk5HcPhYAZMP9K3KLW4rUXBvLin6?=
 =?us-ascii?Q?/FEQAla0TEztTYO/T38iniOoyRlZJ4pFvsupaubK1YlqjMsb4+FhcDXx28jI?=
 =?us-ascii?Q?jk0JYNKLryM3RoSDIw7gMSr8jX7FDD2oM7AqXb96QnKfi4cKGsDwevP6bwBQ?=
 =?us-ascii?Q?KLROw4Bm6r7UasUgGJdUFQbm09bXkSB0dERgKpOMuRv1LwxEjGapvM3aF0ke?=
 =?us-ascii?Q?5px2C7h5ZHwhuJKIfgIkDeKof5evo2wzGXirt0cBwWC1zWc2y0ZdBigYsES6?=
 =?us-ascii?Q?WiIfj4T9XAW2QWjVxIdStafx5EkyWkWJl8OZ+VjolTdXg4YOG8C8CbF0oneS?=
 =?us-ascii?Q?6bf7KGN6n+0IM7CcCeQ8bZBK24T75/ArOmS4KbQi4afGKMVcn1nMgyq/I8ty?=
 =?us-ascii?Q?363E1pjmIYYZCPITBEKeVERR75rIYtUpa1e8GEu74Y3nd5n7MCcSQCQJzc29?=
 =?us-ascii?Q?e0hGKQdHh7YNH1kF4Ae814k15g0GHQxaVA3i7wDqXATuGmlWGZKPt9AIj2v5?=
 =?us-ascii?Q?iuDbWdXUQQVLUtGug4nZ23SYa/6Ck4fS+bT0m/giQv3wE7dAoSZsiXN+sWqs?=
 =?us-ascii?Q?qmlYvLKb5ECYV/EkDx6JmH9GafW+qRe2iXjNE2sV4CLghf628ZCHDRU7lDY6?=
 =?us-ascii?Q?IU+krJRbi6pN6nqf566oX1c8uzg2T/OXM0yCkwI+wQZQTyZ6D1yovt1RZqn4?=
 =?us-ascii?Q?fnynCddfJ2Gaoxy4t9aDsDL3yebWnn2t6FtNmBDTRyeN8lv01rLIN1P8vjLT?=
 =?us-ascii?Q?7feLE2yH0T3zQE7TJSfZ64VXXIq/wShLe9xwEHl0nOustUlF6g51l6X8Vilz?=
 =?us-ascii?Q?MBROBokTwYpgjEl42Nl6HYd03wPUlo1+87u2Xe+FcUuX2Ufx2i/0kap9dkxx?=
 =?us-ascii?Q?F3Bkh2clCgQz+C3eXknvOyx07krD3K2sVAPlt6cvky42DLwMoVX491OQg2se?=
 =?us-ascii?Q?ITDpVNVe2/zUikHtFCQtJMmLbpCi16q5zM7IeqICFyNa/PrBeaVQ9w6KeDFZ?=
 =?us-ascii?Q?wkd3gG8/jyAfi/ONfLp3ym/wgYvRxLXqC6wmOwNlCO61aGG1HgH2t45iV+gU?=
 =?us-ascii?Q?Rt/gT/ua4Wz2OcA7HjesOj6cK0u28JxJB3wHCrP3IDZ3d4GilI68VKxWPIXB?=
 =?us-ascii?Q?Xgtf0aH9LpuaI/a1zqcD88cH8aXoaJJSs15SF43GNutMvx9mtyhWr8ppjmex?=
 =?us-ascii?Q?4ldWT08qLeuZqFpRMDyC0FU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6886bf35-df4e-4897-9926-08dda29577d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:55:00.2186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipQV1y3iFJ7i4VPmc8XwdY6ahIjYuS8XER/b40qUF6H5PnOLKxAHYtKjw/c03iBpEOwruixyUz3wLyifd/EiBPK8dKZEEbJjTdph2BNQtF1QkzVFouy3/C7hB7+eFysc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

Initialize DRAM memory fully to bring it into a known state. The
process is improved by enabling the Dcache. Also, if hardware
watchdog is configured, it is reconfigured to avoid timeout.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c |  3 +-
 drivers/ddr/altera/sdram_soc32.c   | 52 ++++++++++++++++++++++++------
 drivers/ddr/altera/sdram_soc32.h   |  2 +-
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index a1288d5fb50..6cb5002208b 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
-#include <cpu_func.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <init.h>
@@ -719,7 +718,7 @@ int ddr_calibration_sequence(void)
 		puts("FW: Error Configuring Firewall\n");
 
 	if (sdram_is_ecc_enabled())
-		sdram_init_ecc_bits(gd->ram_size);
+		sdram_init_ecc_bits();
 
 	sdram_size_check();
 
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
index 0b928a2352f..5cdf48d2d01 100644
--- a/drivers/ddr/altera/sdram_soc32.c
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -7,25 +7,59 @@
 #include <asm/system.h>
 #include <linux/sizes.h>
 #include "sdram_soc32.h"
+#include <watchdog.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define PGTABLE_OFF	0x4000
 
 /* Initialize SDRAM ECC bits to avoid false DBE */
-void sdram_init_ecc_bits(u32 size)
+void sdram_init_ecc_bits(void)
 {
-	icache_enable();
+	u32 start;
+	phys_addr_t start_addr, saved_start;
+	phys_size_t size, size_init, saved_size;
+	enum dcache_option option = DCACHE_WRITEBACK;
 
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
+	if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITETHROUGH))
+		option = DCACHE_WRITETHROUGH;
+	else if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITEALLOC))
+		option = DCACHE_WRITEALLOC;
+
+	start = get_timer(0);
+
+	start_addr = gd->bd->bi_dram[0].start;
+	size = gd->bd->bi_dram[0].size;
 
+	printf("DDRCAL: Initialize ECC RAM (%ld MiB).\n", size >> 20);
+
+	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
+	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
+	size -= (PGTABLE_OFF + PGTABLE_SIZE);
 	dcache_enable();
 
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
+	saved_start = start_addr;
+	saved_size = size;
+	/* Set SDRAM region to writethrough to avoid false double-bit error. */
+	mmu_set_region_dcache_behaviour(saved_start, saved_size,
+					DCACHE_WRITETHROUGH);
+
+	while (size > 0) {
+		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
+		memset((void *)start_addr, 0, size_init);
+		size -= size_init;
+		start_addr += size_init;
+		schedule();
+	}
+
 	dcache_disable();
+
+	/* Restore back to original dcache behaviour. */
+	mmu_set_region_dcache_behaviour(saved_start, saved_size,
+					option);
+
+	printf("DDRCAL: SDRAM-ECC successfully initialized within %d ms\n",
+	       (u32)get_timer(start));
 }
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
index 4c6137e728d..85a951a5a74 100644
--- a/drivers/ddr/altera/sdram_soc32.h
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -6,6 +6,6 @@
 #ifndef	_SDRAM_SOC32_H_
 #define	_SDRAM_SOC32_H_
 
-void sdram_init_ecc_bits(u32 size);
+void sdram_init_ecc_bits(void);
 
 #endif /* _SDRAM_SOC32_H_ */
-- 
2.35.3

