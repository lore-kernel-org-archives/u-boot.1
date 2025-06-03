Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46148C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630C2829B2;
	Tue,  3 Jun 2025 13:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Wbjw0EXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694F182A8D; Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86F9828F8
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmxqQ/WgOmeD3hXWbwZG5PGLIBBuzp5W6d8+Vz3eJVavXVs40hghJ+TvpQm2CaS42LTwbNCb1nQmX5KM8ABK97VPtOWv2hfuBJmsJh1AOZhsLK8DiZShAIZ2T3ZpYZgVJAteq1SUUMoWOK8sH01H02rlw5nEUB8B9SSbDXeNin4nqTft/n3Ew5BnpKaiN4kKgriGPjykblqMCtFtFM8eLJR3rFuFeVyT/oLwgAXgi/EhcwQvQXfRe4Fuf7kel+74GK6q2p6dH2Hi+lCqDhtadMzXCPr78TJffDzZ6gnuIdEO04KqjkVS5+a/UaMiur9e/GuKRRrZVcSNU620wXsBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1G1HOcGh4StUS0Ow1goluQa4AX2c+YqvhRv/KsRbhw=;
 b=PV5PTRfMHMNhd9ysW8PXKuDujUDyF0cyNduWRrybRln+3tJUEZ+YxAG+M9857WPDx0q4hECq3aJjD7VQSHLxu6zQUNdt0zk3H5XL+9Jl26iR+lIZq74oWp33gbK7kITbOofPymsAuJpdz6IB6dqp8MoL1AyeD8nSPidlJF7cYsrXhnpzQSeLcp8Bu3RvwaH/d/Mssh41L5REbVYX+LS5bjUoPYbdGHQ5GU+LOun2s3H6ak3D3azyLYISa6xZLZnifHzX473apuV3rr6V49DrXN+GL++OPsf0aZjRf2wDBD3vyF2AtSEG/KdaoQunHDkJUBI56oMsAYnmO2W8pO8bEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1G1HOcGh4StUS0Ow1goluQa4AX2c+YqvhRv/KsRbhw=;
 b=Wbjw0EXkClJnkv9hqxMl6tl8uBinawzKKqe0M1qvW9jwVNcyg/hKbhrI/EvKyEq4DVJ6Dg3l3wQvh+N5O55cr9Jx+EG6/uDyszpaXU1H66mKpUY7qIf9lyVgexdl5T+1OUyTvlC6dq3lT9i9Ugy9XsQLik/7x+RtvDmQDp4M78bNxLx7pmb/+DXIz9o9yr487H5oaHY5rOQYdPssbbjcCS354SWBTrzOn7otN2S+LQy9HI+CriBHxt379MRGi6KaYGhmaoRN8u4/CYSimcG95DNCeiQMrQbin8pf8tbqHu1a1rYoq3RRmDqly3SPkb1/5CoPSvVu7kApYTkt9518/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:59 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:59 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 4/7] drivers: ddr: altera: Clean common code for SoC32
 devices
Date: Tue,  3 Jun 2025 04:54:39 -0700
Message-Id: <20250603115442.19971-5-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c83df98-1ab8-4e14-b3b3-08dda295771a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LeKGFlafXfpjHyRpccdywt8mbhgfGNUOe4B4pOq/XVyfRzBICqbHy8pde/9C?=
 =?us-ascii?Q?GM/XZUamIOQ8DtMUcRqjDOdWEeOy5Vu4NjF7Y2hp9K2U9dN7ZwgnL3alOWqK?=
 =?us-ascii?Q?LxemrBTI1ZBtFaJORNv3Ewaq1rAguLyklXNTlA/zem07K158C7bq5Z5OvFDR?=
 =?us-ascii?Q?ZKOwl1UmqdTXE1V468gaj3c24YDBpb+AnvkleEOfS/tgkjWY9qJNxLftAllN?=
 =?us-ascii?Q?8oPBS8YBQ9IeqBHmLt2udotaYKbF2wdv2zx3oovbL9R0IGywrp9j75zSxCQV?=
 =?us-ascii?Q?IwqqTtpXzE8FSFdHmpBVrtM8hPXKSVNWUXHH6+U+07PSiGNTridKNkfFu5bK?=
 =?us-ascii?Q?gb1fwjbi033RnrYkB/oebAeE5mm/bH8zhTUfINWc2yOwL9lC15xlg1rl7qfn?=
 =?us-ascii?Q?2FA13MgO+RNhjzYoiZTAgwBgEN5RMgTqjv+uFQdo2MbfpLhf8N1384WPeIhX?=
 =?us-ascii?Q?G21a92bjwS6bQ/0qbnZXEyuuTA7a6siVuM7OB3pCI6qan93jJI6raP0hgGCm?=
 =?us-ascii?Q?1eE3OB+txtR3Lurf9lf3jbrJ8Cmlb7/ozlMKbEHRRBr48S/bPfkwe+9W9RWI?=
 =?us-ascii?Q?g4tUEjT2GRKecBs8rb9XSPqCc9m/tAFP+DypvhwPpwjYSic87qUS+rWKtncs?=
 =?us-ascii?Q?Ul3yriMzFDGqX185xLw2o3IUX1QGmam25nScfoUxILD8jA9sMNr+vby89gvq?=
 =?us-ascii?Q?y7bjYpxXT+HQXXr3y+H8aNSa/zZm/iftR1W57QCs7Dcf1ZLMCSBPdHZ7myf9?=
 =?us-ascii?Q?UyjtAlk7qmtFR5ZJA3/YQZeXA6EPdN6PCvGo0qBLtNVXVEtC4Al3hrHUrDHv?=
 =?us-ascii?Q?ZQQ5GUzCDOBXrnGDeNnVfpFztpr+0HUUXmuHgAjEpu8XcW7BDLGgl8aDrkSn?=
 =?us-ascii?Q?AbDQrcaxotLmiE6BcyRi7wnEnwiI7+zyOWJRSfOfP6kDvxQ29Kei+IEOmTDi?=
 =?us-ascii?Q?vM2qnscpXT+Pu2LiJJ8v4cmVLRi+QTraakeHvENZbpi0y06GQJCwQaSX5ote?=
 =?us-ascii?Q?u9eZjtdCWkxgbcb/5gY/sD3bnViS5EHpbJgFPw+6sy26fkPOuqaIwvzxVawu?=
 =?us-ascii?Q?cCjcyY+8WNikW+fvvzy/z3mlvx4HKLqq672u516zM6U11TohDrbQuTgMU98g?=
 =?us-ascii?Q?jPL9BnqPqMmDgmQeDOhzIui+XWY695eMD3x1RtTmbENdLvy3Hr1ppJtYlvy5?=
 =?us-ascii?Q?HGvBsvvc4VZ/ZOLIWn35twSpTBCyxC515ltKMP27mQGhvz6YJohKjC2o7q0A?=
 =?us-ascii?Q?Xc+38dV4wK6dAXjE6PzilR+LPmW5DaZ0XSPpO2BkGDFhonUrH8rIwmOdF6dm?=
 =?us-ascii?Q?tEcZw1qZUsUxwUMOenAc9/B1jl1rZPA0gZcV2BiJlSpoBW210y6rJLXdN72m?=
 =?us-ascii?Q?VZ+10og=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLS6pLZQ3pY0F/sdmdGeelf3H2Zn0RvlzI1lSrnm/Ml+ULlfkM6g5t+I7FJH?=
 =?us-ascii?Q?RXZGAZBxoiH2LI4h0woCLeXwQxhKueUvRlJUQOnKDEAHkoCQKIx2c/DBINb7?=
 =?us-ascii?Q?tMAdHGiuAnSF2KUQ7v8j1bGGoGq/iP9RNj2H+MQcNShF2G33PkfI98CEwEX7?=
 =?us-ascii?Q?CD7H0ukoEZ/t6JQOIVPfk25gxCPkOjoKKE/SyzbBJr01TvPwFkIw7itqSM+p?=
 =?us-ascii?Q?ZBX8zQ8JoHdPnf70UovKMc0e7cCdNxGEkFMJgmCYPmA0ZJxc53ld5FzemGlt?=
 =?us-ascii?Q?fls8hQiD6so+ewFx45qfAJ6nWQLUK3mrOeArVTqZQunJIENkCvdiLWxmpF8Y?=
 =?us-ascii?Q?upYP2tYXPbLXoIGY897B6rhqVe90MdPXbSXEjiqTv7im8+ISDaSQY4Svr9vu?=
 =?us-ascii?Q?aE695EAo/wtzrLGUD/nKWBGlhEGUkhVp0xqY2lV9/ZrFKv3IveN+GZmgkElH?=
 =?us-ascii?Q?eUjWjVwhn8B1gsr4RUb2gWj612hZoS+CxK25Lcx3wn6l4Tszs4pQxfABfCKi?=
 =?us-ascii?Q?zSIc1Mvwvrl/DTJc6tczifOwhDsJ9fndOWY0OOPDDw+UC5NRoHRYiyUtSCky?=
 =?us-ascii?Q?dtXLnKta9NC2a5NGnL9o5/YTZiYAzyXbWyT9yFir73Pwe1uJ/yuI2ovqSuCa?=
 =?us-ascii?Q?BTVPBknXOpTQkp3k0lYQ2T8WfHMKVBZ2YCe1oxj9RfY8fnLRye07eyE3sGRh?=
 =?us-ascii?Q?RsRiKLrWjHyRY0MzqPQHUmiIKiuL4oE0fH2VOKNgXISi37ae8HF5VPA7kZr9?=
 =?us-ascii?Q?E3dVJgitFXZPa43YXyy1vspuy5XM/exIbVMuIke9U0d/e7zbw6LPtrZO4AbV?=
 =?us-ascii?Q?Z5/sq55/irliMRr8rUgZMhcf5Zd5jcHKAJBh9pHWIJN4SfcCdTSbMWFdGPO6?=
 =?us-ascii?Q?Xyp5RKDXaDFGf3d3VJDDlQ3uiL2C6SL+1IpCfsi/0pr8QL3CQiBe3rXSLoSn?=
 =?us-ascii?Q?v6CHXWW8e+WiaBRHF+RsGoWj1uNj/76mad8fu4ar1vmSSJWRvfogEAxvwfxa?=
 =?us-ascii?Q?g67W4PSQiFgI7/QGI62IN0FBSwCTdHG+reKRjTd5BsYxALjUXJttkpMcWg2F?=
 =?us-ascii?Q?WVxcErf+AZ9fBxZufTpiKm/8AIrp4t+cZayQiumt59oc/N18iI4XnJ2WIJZT?=
 =?us-ascii?Q?H/LBFPPl9tsYpzuhdoZHZWyk2JL1gOwWwIYjaCekjb9ZL9AlF92WD4VWGjuW?=
 =?us-ascii?Q?rQW4fSdwF9uCYgwpdtkH0YwD8DPhyZNXKR5VwXjbrTVPhq9zq9ZUNxxjcnXJ?=
 =?us-ascii?Q?sDXmSwVrQGmqL/MrUrpuVQYWYRzQ4T44cR+CNMmhamtg2WO0i+ExSbKAHaZA?=
 =?us-ascii?Q?bs6AL2QVTZMQkbrSANNKMvaA6waDeoWvsKltNCA9MF9ninz7Q+vQKDNslStW?=
 =?us-ascii?Q?gvFc38n8+/HFrtnDkdI4XOmhIJn51S1y1Kf0cB+Rx8PC8SZ1V76H5y5RSgaQ?=
 =?us-ascii?Q?tRyd8ivfS6RnUwwDbNs2NHI7rVq9sTBdBBECMKV2k+964XVUTj7P7pu6iJH1?=
 =?us-ascii?Q?zK6ylF8LGNPGhCFoPvbaiuU5E3rJPIpaGTvVXAV0VeL23Dh2hFN8vMmrTgV7?=
 =?us-ascii?Q?/PI5fNwwz1/GUc4xGix7Wofe4S5UdYqOyh/ogPZgS/KZ4gIepQ6vFIkV972Y?=
 =?us-ascii?Q?YSFdtfOBEk5W5jTEOYtZ9+I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83df98-1ab8-4e14-b3b3-08dda295771a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:59.0203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67q6etWNIR2Kig1MS14KKgDEVApgtw9f3yJZnWyyyDISNGhU4K0MWKmOtI2txPzIsL6ZqT/CzfdxEwS8lN2SkPjbiFOsEbzhNoR7aeRiFCUzO1VIzE2JcuNmcaCNJ9tE
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

Move common code sdram_init_ecc_bits() to new common SoC32 file.
Preparation for next gen devices which uses the same ECC init
function.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/Makefile        |  2 +-
 drivers/ddr/altera/sdram_arria10.c | 19 +-----------------
 drivers/ddr/altera/sdram_soc32.c   | 31 ++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   | 11 +++++++++++
 4 files changed, 44 insertions(+), 19 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index c627f16711e..78b0afc38e7 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -8,7 +8,7 @@
 
 ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
-obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
+obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index ba6f0f4160f..4c48b1bab6d 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <hang.h>
+#include "sdram_soc32.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -194,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
 		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
 }
 
-/* Initialize SDRAM ECC bits to avoid false DBE */
-static void sdram_init_ecc_bits(u32 size)
-{
-	icache_enable();
-
-	memset(0, 0, 0x8000);
-	gd->arch.tlb_addr = 0x4000;
-	gd->arch.tlb_size = PGTABLE_SIZE;
-
-	dcache_enable();
-
-	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
-	memset((void *)0x8000, 0, size - 0x8000);
-	flush_dcache_all();
-	printf("DDRCAL: Scrubbing ECC RAM done.\n");
-	dcache_disable();
-}
-
 /* Function to startup the SDRAM*/
 static int sdram_startup(void)
 {
diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
new file mode 100644
index 00000000000..0b928a2352f
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+ #include <cpu_func.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
+#include "sdram_soc32.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define PGTABLE_OFF	0x4000
+
+/* Initialize SDRAM ECC bits to avoid false DBE */
+void sdram_init_ecc_bits(u32 size)
+{
+	icache_enable();
+
+	memset(0, 0, 0x8000);
+	gd->arch.tlb_addr = 0x4000;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+
+	dcache_enable();
+
+	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
+	memset((void *)0x8000, 0, size - 0x8000);
+	flush_dcache_all();
+	printf("DDRCAL: Scrubbing ECC RAM done.\n");
+	dcache_disable();
+}
diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
new file mode 100644
index 00000000000..4c6137e728d
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#ifndef	_SDRAM_SOC32_H_
+#define	_SDRAM_SOC32_H_
+
+void sdram_init_ecc_bits(u32 size);
+
+#endif /* _SDRAM_SOC32_H_ */
-- 
2.35.3

