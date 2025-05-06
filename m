Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F43C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F289E82A46;
	Tue,  6 May 2025 16:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dC6MCUH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76C682A36; Tue,  6 May 2025 16:13:40 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73465800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi9v3gHchmg2S4vHF8lQXGT3YbCy0cAAyNyToTI3N5kLMj67O/rgPZIoBfzQUA6sJn8BVApPyAI7zSk3c33Kj0WviljGXZgI+1gXfxesYg1QyKWQpNeyv4Rlh+/VRhWpSjZsP2VXFWk7txl/u8Ia+4YfBRGZcnRTmUgr+EXZhyA3UnlfIxd/bPom342Qkj1uX6Ky/xfRgOtGwXnMJp3S+VfGIln7X7WHChArdvpWi/vSxxCajA2U9FUE8hOyKEvdZxdtvq3+OmBSl6/64H9tiHuDJoFP6Fg54amjVm1pr4IsKT3ah4E26yPb/w8JwX9sZOGZDAO8lN0WwropWyo6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfX5mwIWi7FCUCqG1iJOmnYjC70/NYArK1QPGY8N7I0=;
 b=nvHEk55pykdPfyhXPdyoBQTwmc1btH2NSZDmKCOxQL/fnn/T0JHcNbhexVHATZ9OOpg5TFC2K+Qr9o9fe/vcngCKyg5rafqNDWeXOSC37TUIBqmtu1aN+OzWMWdeqH61dOxSWHv6oFniHJSrDWPYvVWqxRuxb+a73XGSqsj/LcZaXwqEu/NkpE3HXJcD8/NkZn82HOOx/+gfsd6PkOHsuCeC1YEBWNplbvrqa9kWfp3rvggaeW2OK0ErLUJuwXeHtLcsOAAeTv1UFb3hL96Sj9DlxMagwbwhFRfAkf7F9a0g3oH9UbHJyzgK85Y0X13czeBIM01ZJg/wm1WN/MJjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfX5mwIWi7FCUCqG1iJOmnYjC70/NYArK1QPGY8N7I0=;
 b=dC6MCUH84+z/Rl+afR/lCW1KNZQ5nLA5VlzqXZvN+OCCeU1whwhLOr5WRk1ykc2j/dPAcFAo+8ind2wqqxffAOLWbxOsDpIzcky27aFtsnf9U12gkg0amvK8HgEX9S/56GHnGfQ33xNjRD5EbGnI1k8qLrgJZGad36l2oCcIOrduPFfHuGjAOrNEsxHH8FS8l65h3nnx8frUGy5559sFvUrJ77E5VEoovDzCqqhUE/RsZyCF8YAkYt1l3vvunYHulZj7XleMfG504MuaJAvBWfD1DiLZ7IF2/uWQInSlKxGYvXSoyAgnh0HEGt/RAZBoUJHBU686tRjT06uZwmD9vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CH5PR03MB7934.namprd03.prod.outlook.com (2603:10b6:610:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 14:13:30 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:13:30 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 4/5] drivers: ddr: altera: arria10: Move common code to common
 file
Date: Tue,  6 May 2025 07:12:45 -0700
Message-Id: <20250506141246.6672-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CH5PR03MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d143ad2-2d84-412d-16a0-08dd8ca82d90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+pohio4jvi83YUdUjKyYe3VuKdTEXCAiSOvgXkL0mfdPBUDaLkjH82GdtgrN?=
 =?us-ascii?Q?uuK+Fw05X0zaUpDtzf7gbpmvNoLUQOX1YKDutvcdphPU0Mikj+pQAptet049?=
 =?us-ascii?Q?Qxjk5Zj1OqSClhHcIA7ZDFztZegLYhbchjTe0Iabmrhn741wubMknRt4eiS3?=
 =?us-ascii?Q?7qJcoaufNTJlbHrNX4aoff4OXX3VTBG3B45l+YWTLAlXVj0kb/5opszsg6WL?=
 =?us-ascii?Q?IxLcINSzkvakMvyambxhbDe5zQfZVaQx2OQdt+WJye9jo3LqhSTlszwz2sUj?=
 =?us-ascii?Q?BdRrZBsQoNhSvBSiGaZMq9Z4M2BUqQRjKi1Esk5HX/Lro/CeV4TvGA/r81S7?=
 =?us-ascii?Q?d0UJeNPtu3t2SNRXt1IWtDWz20joxN+82p4JDTGCl5bXuRn74Gioq6L3rVMj?=
 =?us-ascii?Q?8x17osKOEmIYEH3hD0h9jYyGsQzXo7lvehV1caY3c0CpscNnsycZGM09EUM6?=
 =?us-ascii?Q?50ea40J8zvO7dNkWqn0sVxVNcXA2kWlXPt8tBZeigFj61IrKL6TY4YIzLlRK?=
 =?us-ascii?Q?VKVkaTlS8whwECQWm9oJL8NiLcHxHFkM5nhsU8wxR/npneEtjkBWN0I9CFqe?=
 =?us-ascii?Q?wGtqAektHZHODgq5ZxHpNeF8ewWjrV6y7C0GqvOy7ZgfTRPjroWMkCY1gQVc?=
 =?us-ascii?Q?LXeAdt9EsH2bfgQAp48P9MV5HILaLIyR0oe7ENKmoqjmWG96DgWMIA202n2T?=
 =?us-ascii?Q?/r/twwxHxbYUo/HwX8XsMjimYP8+ycxKH6CMt4GZLGS+RbXp0doHUvEvtViw?=
 =?us-ascii?Q?s01a7QWdLro0FjGh2c+3HXDxiTRcFnTRABfKb9p/iUX3BCzpgWRHHsuD02TM?=
 =?us-ascii?Q?kDovLTJsOLmDZ38IKGII1n6DnZVhcznBbm8pg0zcjtRdj7FzzYlt7gbzwt7k?=
 =?us-ascii?Q?aHX3OrDyC94oj6jXAEDW+aCcxmdproGezkX/EilHGPQZZ3zSoSenYZ+nYPi5?=
 =?us-ascii?Q?7Lxmkm3rfuMMjMTeZNEa+O0f3fT3D6FSXnkBZzrWuX1cJXCoHAk+VrH10+BL?=
 =?us-ascii?Q?+Hl1sIOb7AK4PUxNGerzcEFA7Ob2N81Z8TDU9Wf47OF1NIdJtb7m/iIalhMi?=
 =?us-ascii?Q?AtbMnwOaPGalzBIN8tgVOMKXaP1yMLKfdwkCoDQKVKBJQlEZ97j4s7WQ/qBT?=
 =?us-ascii?Q?9EUhG/CjjmkNPPrlPmwm6zLAhOGDMwqSNLJVBoGhdvR+qKFmFpOTDCD8gdtc?=
 =?us-ascii?Q?uhJqKYaF9W/g8Lurzsp44tTrmctGM63FZKOnzsnwPX7GrNJRspp5x6aqirtL?=
 =?us-ascii?Q?hqKRrJU/LkXZ4Oxy54FRselwSNjjUAoTxrBvJxVI4NlBlHXXvg7C2+h8fm9t?=
 =?us-ascii?Q?utAiFRaNdVF+tZhVR/9xcZieWXtiMJvko1TrdZGXQGRuCYlbry3JlwTuYjm9?=
 =?us-ascii?Q?Brgj9+o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9dFtyKF7IcAVtsBTLcqTRT29VxjNav1YlmoJepHgBc/zzpuKrw6hO+Nh5hrq?=
 =?us-ascii?Q?Ng3TU1DXMC5L99SqFjzUockdNNAcVPD3uUhXWwPbYTQjh9KOkpVbzXX1MJTz?=
 =?us-ascii?Q?dOrgcHAdeUrADwmYziipqeIF/RszcXsBWMNkHS/NptAFicqTZGiD/dtcTivj?=
 =?us-ascii?Q?dyldeu1QYfA6HDzQw+PHE2qkOa+wHtni7kfSz3WZd+cMoGnQKP6zeSA9t8Fr?=
 =?us-ascii?Q?YYc8RQWcyKMc4WjMKlQLENg7vrzkH9uPGsZXLF4tM+1YQf48aYwGYKWqQidx?=
 =?us-ascii?Q?zWQbEEJvdoPvBqJKF0Qc05Iwo+ATnpQqg9nuTvqAAjcPwwE9G1xezaBJsEfc?=
 =?us-ascii?Q?gPdRGZqKxW7myVticin5KSNv+u4It1AmFs98lHBzrk3lW4hphqfOvyHE0Pwx?=
 =?us-ascii?Q?58yWklqqbvmbgloYFa1WxsKs1F/anPvhhSy1wbxFXJLAfm3MmcKSEvHjW0QZ?=
 =?us-ascii?Q?hQq62Br0K5/LpdgEUSVPdsctzIFdr5h0B8lGBCiloqg/Kcz9tLsVLT7+SCwQ?=
 =?us-ascii?Q?iSdBkKOYb43cXzCLm78OszKkN562I4XEz6bQ1EAO7NJaS0WKa/M+xIS0Rvbh?=
 =?us-ascii?Q?Y8iCL2dAxooiDuuXo2I2/3y3yYdifjjSJU/z9MtF5X+4SezQocRsshVuh/xc?=
 =?us-ascii?Q?hawwRDjiwSx9GQbZGvwpvcQN3/XFtJGwDkkexQ0cSC99WMVURE2CgxjZfwrI?=
 =?us-ascii?Q?CjpBjxnTD7WYTRo+DxB0FpIaWN5rRVDr6/Tx27oMV7bCaMtSlINRo+VM0NP4?=
 =?us-ascii?Q?yLZ1Z6BzbO7ZgjaxEkpLnUr6F2vpE3j1Jik1qLulo29yQ58VjYGIYHSURP/B?=
 =?us-ascii?Q?eFRqx+7vPhwcEusSJZEBaRlyhqv+nqVN3LXegphLjTLtEMPM/ilbGhc/XPMN?=
 =?us-ascii?Q?LZ6d6yDReHO0jyMzIQNQX8WMAkCRPfijda6hM+dv3cwzcTCtS6ULG6FAIE/v?=
 =?us-ascii?Q?gw/wBDDLS90gqkk3L/RqaPd2JTHpcSqemZMlPJ1DmOCoNCLUCMtlpLyzMpSb?=
 =?us-ascii?Q?LHpl/1UQCXR+q/XtciCBeMOh78fiBr8cSH/+HsZb4krgYA8r0HGbTDAxUvz4?=
 =?us-ascii?Q?Qm0/Rvknzh5hQ5ZMUnGXSlohUou80+wzRoxkvtoKfh8cyeSXNCot21ZivivP?=
 =?us-ascii?Q?LafbfGQWXP+Ta5jeC81Erf2/muGG3uIKGX4Lxsus4FrEwvtDT2PtyKBJU0f7?=
 =?us-ascii?Q?kGIPSUnP7Dj38UBSS2LdSzd5UHZO10ge4Jaa4hlxCTauth17/CoWEuEbD6Up?=
 =?us-ascii?Q?nj9rGNCQHP554QYGNqmLZdJEAwgH4dsg/h3WBEzkQjFCWwGnZ7Le1l5rpcmW?=
 =?us-ascii?Q?M5oCzuLeuXg4Pb3WgKjoG24nAz5ntZ17+/B6Po7Z+n2F9mf8lpJzsQaGZGjh?=
 =?us-ascii?Q?XnLunGV0QUCJRGZQiDG4CI7BYG5r3r61XjRY9/C2r9/IKzxAnNVjcXWc+3k8?=
 =?us-ascii?Q?e4iBiviCEbj/M4nB5ulMC32YRpis9vuQavzQYehL3puee1xa2Fsc8feEmJPD?=
 =?us-ascii?Q?CEcKgeLxohSUVqF18hKnFFAzdHKHYLPSl34JD1sdkZ4uhOuGzRWqJbR26u7L?=
 =?us-ascii?Q?j4JNu+f3MSDb7cLNRCbzYYPp3nQ39RR8uzflHZfgki6ozYiRc5p3nw2i/ZsC?=
 =?us-ascii?Q?vy0jiHYg28jY/pINHVgtCFg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d143ad2-2d84-412d-16a0-08dd8ca82d90
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:13:30.4273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjXuxCet6oTKosT+4nilGuoPuRXNlggGBfdLcGW9uuT9+K4RB7hyaH8h3vMuNiSVWGlyZHV09nLswJ+FYp4bkrN7eli4wiIO+7tZW5Jn97VZnQMA17t4O5kd4W+9Xm9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7934
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

Move common code sdram_init_ecc_bits() to new common file.
Preparation for next gen devices which uses the same ECC scrubbing
function.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/Makefile        |  2 +-
 drivers/ddr/altera/sdram_arria10.c | 20 ++-----------------
 drivers/ddr/altera/sdram_soc32.c   | 31 ++++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h   | 11 +++++++++++
 4 files changed, 45 insertions(+), 19 deletions(-)
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
index d8ad94f31cd..133d4604738 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -24,6 +24,8 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 
+#include "sdram_soc32.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 static void sdram_mmr_init(void);
@@ -194,24 +196,6 @@ static int sdram_is_ecc_enabled(void)
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
index 00000000000..ccb4266473c
--- /dev/null
+++ b/drivers/ddr/altera/sdram_soc32.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/system.h>
+#include <cpu_func.h>
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

