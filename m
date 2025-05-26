Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53D5C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B53982F50;
	Mon, 26 May 2025 20:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qQWPyfBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3623382F50; Mon, 26 May 2025 20:03:54 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F006882E37
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfoWzlekWVG4Jc6HhgNxUHkECCLSejgHFaTOa041t9FRtUxQ5c5YXokjJlFTHC3ZrsPobVW0ry+6Zitht/qfmYaxWRnuGX30WXM9rlbxmMn3y1U+dIy+7ly3SpYamP13GfVI9kZnpbVaDncXkwSQgQLmEBFgfgfj2t3dCU6eWw9BY5hou/N5iiohr/KH1DsItCjeL+sMlAB1R7nqQESQW0QTrH3ID45smI+cgubomIVJXe7rKMESptJ5C2+LI58zJLTNmZOXBe/rEiee0zLaFwyt+SmsDcouQla5QxmGDb30p+1p2yXpLgckVog3letOF9S8cI3fCncuM+onEkvpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1G1HOcGh4StUS0Ow1goluQa4AX2c+YqvhRv/KsRbhw=;
 b=djW7WKyryTM0u32Xz03E7df93kyODexaAEJ06efq0JlMGxbwO/z9QoP/XNmsfnYd1Vlw44LMnQKiPHTr0rmznDqq+ejTeuSmhlUQKBU52NC4N7pDEnyTcPYf8QyWaPTSSc970VpyYh3lq/tCe2OzfIPN85Wcp1ktcMSyxE2YRUtQYIYwYLGgjLlYAEHTdqxOrI2djSCbuv1VjX1XKfxoqLK9E8Iiv1veI3/QGqBAxyktQ8o9J8sGCzI/mDQS1aIgH3vV3GBT2o0dnRk2oIIoOf05n6E0qvlT5+e2EwAOs4YeESi6HCRBHym3en83r7pbjunqNHlTW2sll6cVyBn5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1G1HOcGh4StUS0Ow1goluQa4AX2c+YqvhRv/KsRbhw=;
 b=qQWPyfBjVlMcsVvNmUL+EHRIZkBV9eNtq/cAq5qzkLcKPIdfsrwoS8t8/Bcfck+X05eaY/qLnakgr+jaWK9aOIO+lnu4Mqqm3leFeYhxxKtajQygdB0TpAcSk6HKrh5ebTe1yk0Arby7yIXnNFU7y09CsAscuBs+YV1iOec9CM4Tzd/APSN3ej38r/At3JXIi2lZ9QvZWiZFFoVfRqWxmJaEjup6RSUor+LQYIIYDy973qdulGUgI4LbbEH6ghFMCnuPefiBijede7d21O94E5wURXFqNi5VO7flubXAX80amO6rLKal1P9Sbu4hSxgiR7OmD1bY9XYeqdKuyqBg3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:49 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:49 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 4/6] drivers: ddr: altera: Clean common code for SoC32
 devices
Date: Mon, 26 May 2025 11:03:26 -0700
Message-Id: <20250526180328.13644-5-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 777547c5-bb89-4a64-95dc-08dd9c7faaa1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9bBhrbdbTLwRQqkuSGh6rJn/w5iXyfSaFIBvWecy+Y7OYIXoUtBehprKNEyb?=
 =?us-ascii?Q?h+aBsXoiHm6t1PFsHRdabOJtBDCFvEJ3XDspGYkbqDt1WEfBIOvW6CI5EjOL?=
 =?us-ascii?Q?xcfGsEqgi3jX8eJSEgwGXRBLcLpNVjU6LCDIZXmiwQqeFdOBmtcx7qjH+Nhz?=
 =?us-ascii?Q?fJLw+woS+/iWn7TKfPTLgJCirUKh7zFEYDzCfmEiwqSKz1aOJ6l3bGFNizHk?=
 =?us-ascii?Q?nLXcvbgMLYoIamCe3cOeAVdQLuhWLH+KjVZ+AHaX7NFhmUL0hynuUyo7FRyI?=
 =?us-ascii?Q?d0/PY1HqWNKYJXAscmmcKLM6jXU6HHqDtYDJA6zk1YtyepqBytpfLmqEsawI?=
 =?us-ascii?Q?7h7jGQ6XXUMGlzrIRjbUomnJ5x/SVaQCDsMwU1N5FMV7sqHgsb2cQLoM86Ux?=
 =?us-ascii?Q?4apSlUshv8B+s7O+lNCPh7uJAXwl/0UunYqHUF4fqmJ3v475LTTOPLhWSpgf?=
 =?us-ascii?Q?EPfV4TdbHs1lXGu2eIKreHzRReLMBznyyyRZrbgkUCvGNNv+UmEJpkcjIOc7?=
 =?us-ascii?Q?nk0jQpJIPlAABr+2HScbl9Uh8sJe0xuxylXj/EyAzUwUxKUJm8eSPIwgs8xX?=
 =?us-ascii?Q?OKuOzuhc4B5/RJDu5QvJ1c9dnl3kQGFK1YKERtK6Hmc6fokJgVet0AN7yU3W?=
 =?us-ascii?Q?EIkf3lS1ZPkj+zYmFKj0p+M3gcboYfQ8DGvrQxZWqS62Us02Bh5h0UxLjU8t?=
 =?us-ascii?Q?4mNJofbnKX4sWmknrkmVZ0GAZGFGz8H7VitLMgjVChb/smYBVDuFSThuwPgg?=
 =?us-ascii?Q?bZTroa9Vrl6GWZ2Pc0bk7vNN+YZN4y6ZWVsM/XJCwjSYSiq8ZyUbit7tJW7i?=
 =?us-ascii?Q?X2X7OtQ647V3XlYPXL7TpXiOiT4VcJhKaEg1Deznenj+7OjVzoXVYwFuvHLz?=
 =?us-ascii?Q?EA//MwmdDe2yH7G6GqO90ivcRTVwZ9vov24+Lece9ubFNSasBndkNYYxEpqi?=
 =?us-ascii?Q?IQDia4KdSI1h8CvA0feCXy1Xuv292DLnsr0ML4XgtbnBcpk6/5MRVI7wQ2Pr?=
 =?us-ascii?Q?ZvQEeFqEuHJWEx0VHt3RwP4LT15VB+RQr78oSNVWB0ZUMjWGSUDVr9EMltjK?=
 =?us-ascii?Q?cS4Zq9glYeVQaguUR232DUucpDjveBQFDb0C0oMfeiTJzTt46DDj9XEddGxa?=
 =?us-ascii?Q?DcG6tC6Zg2eyyadoU4IiLwOPtLyW9HWTfQjTp3uLls3SmYXg8o/VKNbXyDY3?=
 =?us-ascii?Q?ayfLsltb4vugWdTvGlgGF9x9GlJ6SwaPw/GkQE2N5JCKYIrGRPkEGHXeOiSl?=
 =?us-ascii?Q?WyDFt48ghUam1ryB5TwWD5kVLINBsSRwXOhhj8rcmhZ44RiD6JuLwRb9D8ta?=
 =?us-ascii?Q?HjTaztSzfPrVgp7zn0uRjrsWteLYoILHXOmN5l8XucFPIMURfkPpkDzFoLwZ?=
 =?us-ascii?Q?Z+wA+5c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuvKLaFqqgn3oEu2XEyxM9OS3jq+5UwEg1A3nvoZOOfdzJZ6kR1V1nBcJSrO?=
 =?us-ascii?Q?1N5JH5WNbaOYOdCbXNgXjBaIMEcdthi81WZAz66AoDcQmn4epbhEmMqSSt93?=
 =?us-ascii?Q?ehOEU9TualOpU5jHZNp8Uu9C4w0gYfveWkr3mAcBZ5LzNpNaDRQVuvhm3E+4?=
 =?us-ascii?Q?JQ4J2SSnzKMJ5DzJeV6rLHnrUuoaIJtwVXm1yEDfCcB63reSXm1RkPxwHd4L?=
 =?us-ascii?Q?tfbxF9DX1TE9zD2kUngS+Im4FE1BZcYea9OHAaNVFZvm/RZJuIY2ePwzc/Hx?=
 =?us-ascii?Q?4kJqlFytow8D63E3K0HsSnPwEVY9SyKA70qAAdcuF1uKc/ZdqQHjF8UcWcrZ?=
 =?us-ascii?Q?WvQeFkKjKljY1jBAvu7OtsyOnD+6Xt7nLZpZwUhdQgBZf1qUGiSDk/k2vAQs?=
 =?us-ascii?Q?jlqIUQUXYdoaNzek58cUUvX8r/TYv8jHUDSeN0iAPBeitKv+7fvDxIZkqaoH?=
 =?us-ascii?Q?UNB0wmoQLDSbh6gJ3N73NwtyjP07LjIEqzYauPdp7mVvTWTUuyBvdrIB65l4?=
 =?us-ascii?Q?1C1caBF2tI+XaQuwdbK3NPLA0Oa6gk5jtC+EyjECRTP/5/VkeRiTCS3OwRvm?=
 =?us-ascii?Q?4tvCaGJQqMuDr09jfruehCuUAKUlZdBjOY2vBDp2p7MEeS5+DX5saTCY3bM8?=
 =?us-ascii?Q?ZxX2fAvi9Pm5MEIBRyrrv9dOCuh9vmEhsGdv3XP7CQPxW7ayWZzYOKFrRjaa?=
 =?us-ascii?Q?uO4OmvTnnv4Q/A7SDH0X1iQvFrN2NYc/17JAVf1LTwp39atwjmuRvJ7ftzeH?=
 =?us-ascii?Q?4xydKkHL1VtYjwTctchE2/X9wDMC9CJH48e5c10ku2Wi/ZhAwWqEHh9jiXkW?=
 =?us-ascii?Q?3lAxqrx9SCNLBoA1O2n4rwVBc+1s794tNXTFGbqkBF/+9m5CE/zsLdFi6liG?=
 =?us-ascii?Q?DO1OzmDAOaRfrDEPyUQIL4LRqtdKy1hjPXKFpuwTeyk7StgRyBY6EdMi71XE?=
 =?us-ascii?Q?Wd1d/JOrqDilVYxtMNQoOYY9/YxEEAtiOkq/EVs+qJu+gvrEXzIeuU3x5iBb?=
 =?us-ascii?Q?jzpARAc2yJqHGTDMlzCTMpHEx6F+Z/EKK1Sf/zH/nSxyNPuI0AhJ70/3In5M?=
 =?us-ascii?Q?q6UuDhx2LeOPYtrCPmdsw2oR53H8n1wBV0lHS+Lp1jHtPtqlo8ZenApq2ix0?=
 =?us-ascii?Q?UyfLbAXer5WtdczpndUKimufdg/T6Cn1KS5ybn+HCToIvNe93cRX+WF83Ah/?=
 =?us-ascii?Q?uz/UWCkm7Dtw15ytC6HkqfmnNQLQdYZ1EfJwXsp4OjCEKB4EPjn3A3tatw0t?=
 =?us-ascii?Q?n4hJZTeDS8cTZBsC3MhPUAizCqL6GGfC23/y4XMMY/QNgJYe8r4F04+kctB/?=
 =?us-ascii?Q?NFcCN/kk7UeNW49J8hcNIVDsXa6RM1l2wQe4Eaca1TY8o9mSe2x6Koi6wC9S?=
 =?us-ascii?Q?SvQa3ypmE2rPN0i5mUVTgL3b8feSRf99+Mk+drwp6QyZp0ZTqyDTqCt0+6Qj?=
 =?us-ascii?Q?Cp7l6/zDGpdwNe7e1ikf3Wuvel5+VqdYsXT7WFhov7c7T0vtfFm7jjqQl1sU?=
 =?us-ascii?Q?ElqPaRvl8S02GmI4ekqft5dNkJ5bulAelP/lV+kIKVsGzXDUyT8ZsqPhSGCj?=
 =?us-ascii?Q?A4aNX2J6Oj9atW8pDIBE6gSqHNKWlJAQo0CieQ2wZk1Cc1iRV+6oOSC8qYTc?=
 =?us-ascii?Q?+Py9qmdrGIXHeNjujyZJ+eA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777547c5-bb89-4a64-95dc-08dd9c7faaa1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:49.7491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4OVxe99buOFNP49QualCiH0CVoOZ8pq9GeQPEAmtzn5Dl074IAwIm5aOVlNekdRgwKBagczoW6J07ArjEcq6mUZZDMipgrwPIhTkfuDCwcGK5hts0mYxPLXxhlD8R+G
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

