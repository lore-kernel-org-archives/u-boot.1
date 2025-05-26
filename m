Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF9C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D1B82F71;
	Mon, 26 May 2025 20:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PXauw3uU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EE682F35; Mon, 26 May 2025 20:04:01 +0200 (CEST)
Received: from SJ2PR03CU002.outbound.protection.outlook.com
 (mail-westusazlp170130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F7D82F75
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMDY0ZCh+t/+XDHWzl3jDqeMXM5+6qyehfru721X2W3FtRzDwI8qdWmlbgI3Ubs/5d6EiDOooM68KEhAgu8fA1g5roPX3u7SmDuAwT6vPZbd54aK8SNnNbrn6U1uM6u350QMdFT7nFryjfYPANWkaPzhnP3ZRoKoT3I0bNmJp48WmZJGNj8RrRP5I482jZKoCB9Ydm4+VOqDENrIr2c0yj6+p9Okl7mKhe6128BLVdLbUvLKmtmjHcOcpukux7w2I1L/zK/xo1CQ1ZU288UP36DeSDScpT2hGOyk4mVv1sx8P/MnjQ56uN3CgrIcgQZDy/+sdE8FOd5Nk/O4KRmaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPW3TBgOw3GikLlN7DsNRn5DuPa17jra+wWyfCvDRa4=;
 b=pdS8DYqfWeBwNli/2hfnQUBSWr2qALFb5Rtl1v3vegQZpxylyrb30oHlxnxZiuCB8FxglWD+sIUDVv49IkzlcMdV78WW6kITbEutPrvVwawTqfYPfhnADkeoxB017SWTM9f9FFMoOSAxOfJzm5FA0n84GwBhJEdz0I1Q6wINmfyORgqeLlR7uGsVA3RX5HWi+Edh4UUqwQv0VGpCa/rMXyB7f1sUp/IauV2fEvzp4DWk8XI9R71ZxZmcVAFlULYRFOPKoR0/UT65mDLaxMCwnplITNjcNSMrz43zXWaSjqxPseUof4cLlpl/nOh54jmsqIVC5Q4vxI90vJScrgDEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPW3TBgOw3GikLlN7DsNRn5DuPa17jra+wWyfCvDRa4=;
 b=PXauw3uUUs4gdlm52JCZJ4GPVr9SK8JQ8idlERLBOQeNFSVIIJunNbyQVD+NU3BGXErI1g8b3tz7N9vWXIXsjBqTfMTwdaDQeX80ZzAnAtHiE10fSeQ2zsbcoOaqvVzVfGNt7XwPD1+jDvLWwRLwSeCy6pg7sNdNcuJu6RDQwVfX509XOU4AODAmCTKwkMnWNHSNFqR/O/h+fOmNvpvxpeAWqUD7hl6hvvuRTra1EJcVaELfNedpbYHtlHzkB9BIPeITwA66d5pZsFGmQ3+f8rxf1nXShWgPfbgPZkSbDsZYI6TRciDQb7apkz/GvrxzzdFC8oP1X5km3KRwf8ZHww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:55 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:55 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 6/6] drivers: ddr: altera: Improve DRAM init with Dcache
Date: Mon, 26 May 2025 11:03:28 -0700
Message-Id: <20250526180328.13644-7-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
References: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: d9590f80-f053-4299-2c1e-08dd9c7fae13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cATfNPiE75pNVQpUJI9djZa7+v5634b3maOD+ssrPi4pK/PVDPOctNtmlfUT?=
 =?us-ascii?Q?IZb3DH+0dAk2c66U7Is18wt4SiUkM5cyjq2qGmH3qlr5SPC1lG2cpRLj7bD1?=
 =?us-ascii?Q?AK+5Z15HnU1K3XEUAgk6fOe9ZVilncjLEu2WFhypxP8v+ClPuw3IicRtXlED?=
 =?us-ascii?Q?PmDPlMbxJKZMJ4Lr0ap5M6ozPhuJGIx2OlJ5UhM61NwRH6BoHAhEI+ZA0slw?=
 =?us-ascii?Q?EtoL0o9qa4Zx4zRmAunS5a0egBrZq7nn/jiKK0BglVn2SNfDKgU2pfVwOqs6?=
 =?us-ascii?Q?Q5wwk+I9sNkmpzT/gs6Op6tmd6aL9RLgIpgBgo2tCQtzpY3c53uKE5ydNiyC?=
 =?us-ascii?Q?6+GjSf5cBXyIenOqw1EcdydfRJw9dWX8T6iMEI9TP+mEWHQlQNbvcaQXsF4m?=
 =?us-ascii?Q?tyDd/l/bVqa7QB1LB+oC1Wlo2/zkIcetoPa9RtgcigkChV78EDsbIKf43AhB?=
 =?us-ascii?Q?s9uNVOedcd5/CACD/MsajlGCBu6kJ74ebdkTSq8J4cO9UAuM6wheNfXX7UjB?=
 =?us-ascii?Q?1X5GtQxnxa4cv0KxqBPgCjbW+CAs/o9eN1kQAkiixKuPPYiV/FdgOydc9bbf?=
 =?us-ascii?Q?Of7ThoTetFaDe19KqH2UkPe0jaPdSfucKp39AIlQCqUuAF9aHoYf2Cps9tSL?=
 =?us-ascii?Q?w8AJMupsnnSK06qUCEdx/eVChGmpx2sBIXwj/S7u4TyPOK5dwVJ/7pMz8sxY?=
 =?us-ascii?Q?yMXu82KljV1lYeD4AGj3JnAOml3IQD9McZfi5BqaJr26X82lg+2SiUn8HMe2?=
 =?us-ascii?Q?B3d4RMfEhUQa8EBS09f2TSEuijiDNk4PCa0JpqBosIaHgzyLU2Shc+OYB3nw?=
 =?us-ascii?Q?8ouIj4SUp1Dv20GVTQUpmLxv7kNQNBd54ELheN33v8O3wLlplvSbE/Pk9cG4?=
 =?us-ascii?Q?BnE3vzBfnIsyrdhVojCVDM0ZfuNIHeBdwd0yAFTI4N7QrwcQLBbc58nXkhvy?=
 =?us-ascii?Q?6cPKuADHOuLmQVLKz41gQt1jZDXAaMcK3nBY35f3h3x08dgp2kq6LYTlrgQ+?=
 =?us-ascii?Q?nXtp+jbqXI9alJIDdl5yhn/SOeT+r92HgzqzfKQPPY778VN9IP3mIcLorzf7?=
 =?us-ascii?Q?x9ER8XBuI15OZdMcXEkGFj0cNX8odwki0msx4rvoLoRD9nk7EAZtPw8iOefi?=
 =?us-ascii?Q?zNOTH6Rrr8WrEcxqihm8COriZ9gRg5clOmuLT5umO/W+nS+6fKWq9DTiuTjh?=
 =?us-ascii?Q?QQRamlNa6NbEwQPGmiVtMZV93PKefSC7CJYVhSVklqrNXheOHz8vLc5cgm0w?=
 =?us-ascii?Q?Lu/4CACyhHvwRRFPUUqFcpfu7NsmiwU8C4fIySfasZDDj8Lzv31Uc8fpue1I?=
 =?us-ascii?Q?4OlwzzR0HgVn4W0WPSY3pFq7EZauAkdG0WCYYkl9sNJh6luSgwb9VlGZdM4B?=
 =?us-ascii?Q?TIjzbFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LChDDO8oVP/m/Txcb63rhXjhoYKqelZlyLI+i5qFyTM5CMbIshmBupzxO2UK?=
 =?us-ascii?Q?VvxJt2+uUqNW8KVOsDGDzxTZHJvR5yH5Fc+UvTCKCKMKbSYeWmQ0opiLOPzw?=
 =?us-ascii?Q?izPtHBUYzLXn5qL1hUnU8DxelPUJQxnOohpfh74E4ueURfiovmncQhgLkCf9?=
 =?us-ascii?Q?P8cw+aq1Pnbc0xbN3mioAZr8/Zbfmr7UomWYA12Rzty9CpYgmgJEFl9543YF?=
 =?us-ascii?Q?EEsoo6dNLLQMekfy/MIbFpRM5eTPTxE2u6G45YrDdtDkwyT11TKFJGKJKLeM?=
 =?us-ascii?Q?j01lg9Rbq8Mv+LUG8A1dxBpRF9CimeAGSHkH0D0jH+WcuY13HUHU6VTULPLf?=
 =?us-ascii?Q?aJc8AuyKI3eFupQ7uvBa63zm1SfD/4pC66UAImuk3YSpoqFYyb5ujLbxwB/Q?=
 =?us-ascii?Q?m/DYIHOM0o/IsQhN1OwUY+DL8c7J12PtnGARXAjYY4nGCbXjp679Gs2veSY5?=
 =?us-ascii?Q?bOKL3uE2QpbIIuneuvzc1ezt1KbeeEAPMstcoTyKpTstUd1nbP0bV8OE/2t/?=
 =?us-ascii?Q?20a4LZLTRhvrf/3rVYXbIUHgaP6ygvka8rKTSSsHoOv4bLh1EmLQJDiudFEg?=
 =?us-ascii?Q?AUIz2EoWoyOeoAqRQL8KpKc79R/wZqPKhA+V+BBc/j0Ks8gIKD/ztJmA0P7o?=
 =?us-ascii?Q?vH41lfXRNIOA49kDnAW/z/uUmedup7daANJ4GpGmacmK48rnayBAeGvYjhHh?=
 =?us-ascii?Q?TcI3aMzI3DHLPvTVrtcDoO5QoROXJCGYq+Lm82W/F+gtL7ebw/L8IbbdmRMs?=
 =?us-ascii?Q?7sNCE20vxw+Dgjp87wLQ+5FiA38J2SSeKTaAi3uoawMzrRO6umdBcNion7fw?=
 =?us-ascii?Q?zG24+J5wcQBdkfUpa996jUSMH5eDSshporb6LM7UQa4VVVw2Z5WZbqiS0qYi?=
 =?us-ascii?Q?lcjHlVFw2yKBCn+GfaxHuI5Sf/I3bSSRa/wxMqUesvqj/qgvPwXNx1X2XzLS?=
 =?us-ascii?Q?uS0mougClcEkPq2KlSU38D/65L+G7z/CaRQTsZYTVtcKoe13cL8Ne+liNqUP?=
 =?us-ascii?Q?KMc4VFcoXem9NCZGMM6UmZbn29kcHPlboV3//o4LJpci01DQ2m25WRSrAYFp?=
 =?us-ascii?Q?rTCYLD6PHpdxkIQTTAFIKJVL9lTx54OhVr5SNaprTiq3FRrofHny3MZrWf0L?=
 =?us-ascii?Q?a/MnuqHaeik0wvQb38/0K51c4fR7rnFTDQY7DMoWbI/mHpuL28NH5d+10la2?=
 =?us-ascii?Q?EzQ2UYzqR0utM/ek5iCa7GH0RVJtG3FuKeYa/kcbyYwuqhaI6kCm7JsJ7725?=
 =?us-ascii?Q?D9x05nRmnSJA4KDgBQOb1+KN24+O+h4NMIoxRaQ7Qp39tmm7HlaSh2sAnBkB?=
 =?us-ascii?Q?UZnuh7gZsMeazAD3xUcXImVGMtgEw1W+3RkEKEYvzARjNupyuVKsR7R5KF0f?=
 =?us-ascii?Q?DEldW69aljHob5LDpehQS6gVzRtHpHSwpTy+uiNqRwqAP3m1IBhXsYR1ODhd?=
 =?us-ascii?Q?8JRaZyNhYYcXP6FrDE+XiI+1PIBWrwgDSNoJ6XY04EfGoRyE6TpQ0G5z9F8h?=
 =?us-ascii?Q?7vZJO/H59GsdXfSGRRlqn3SjgurwfGFvNLrANPvq+aWI+1iXBs2aTm59g+rQ?=
 =?us-ascii?Q?vgGAkkEDq2JEKmoKtJdUX+bZR6abvI13FQHHK3sdnNuMhGzEZpyK9+wJzx61?=
 =?us-ascii?Q?Dixm3VWO3Eaq+2g0Qpuswhw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9590f80-f053-4299-2c1e-08dd9c7fae13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:55.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTBab5dn8PoKY5TFFU3sQzQ7nc/pXRlWww1Dz0C3YRJ186jpGPNHt9AyO2oJ3GLvG9RxODV1GtO/mUHzGS/HGAsma5SR+klW35BZkeVJhwBaDtFUNqL+BRLMK7YS/uhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6379
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
 drivers/ddr/altera/sdram_soc32.c   | 75 ++++++++++++++++++++++++++----
 drivers/ddr/altera/sdram_soc32.h   |  2 +-
 3 files changed, 68 insertions(+), 12 deletions(-)

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
index 0b928a2352f..f63360f17d8 100644
--- a/drivers/ddr/altera/sdram_soc32.c
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -7,25 +7,82 @@
 #include <asm/system.h>
 #include <linux/sizes.h>
 #include "sdram_soc32.h"
+#include <watchdog.h>
+#include <wait_bit.h>
+#if !defined(CONFIG_HW_WATCHDOG)
+#include <asm/arch/reset_manager.h>
+#endif
 
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
+
+		if (IS_ENABLED(CONFIG_HW_WATCHDOG)) {
+			/*
+			 * In case the watchdog is enabled,
+			 * make sure to (re-)configure watchdog
+			 * so that the defined timeout is valid.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			hw_watchdog_init();
+		} else {
+			/*
+			 * If the HW watchdog is NOT enabled,
+			 * make sure it is not running, because
+			 * it is enabled in the preloader and
+			 * causing boot loop if is not handled.
+			 */
+			debug("%s: %d\n", __func__, __LINE__);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
+			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
+		}
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

