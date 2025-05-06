Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3848C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDA382163;
	Tue,  6 May 2025 16:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gbANL3sF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2506800C1; Tue,  6 May 2025 16:13:18 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AFA828F8
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIWsCkuTN8AX/fGL0BvboBau1dAEFxw+kkDD2TPZjqLHFQc0BZDjyCy9qj6p19KxEuurt0oQR6pZ3GBOwdt01nYwjG83bJMpx3wTLGdnszC3rEfTWYK0BSWJXW/4sEt7OsBZRihN3aWoFObviD8jhC77uQd2f2eeoxkz9+ljdPyMSN0rqpFV3aYWQkuEGPqQ0Toz0BH4CFiU4ik71HE09l6urdVZdAc01TfATVm9eNIoYt8nCSK1zoKLCbmmaQLwoSXJJ7iDYKMIXUDGGcE5IYxmwv671E116kwO6/mcHVqMz3eB2RE+SUh4uaImPc5+HnEfUT0cbNaaFgRtQLOKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2x4pIRf3vmphRidkefqdqysFibB7yZ2MsS13ghfiYk=;
 b=ggcMFrHlbfxHvFOJuFBvW82Me8eK64M3fRgvLf08pm09VBbqmrwUBqoQrNOguPAlAMMf1TysqoYSD23oavXghtJn2gFRjkI9aNL5UDlkOhS73hCL44cMWX+KfO+RHbzltclgRTtc0ZXbkkVSBQiiy/3LLsZ2QMpQFxpidZVisMpVBFeIuKHIV7r0xeJnjklG7GW63U1vgzJVwgJsEv7yX7idInS8C97iAiG0KqiDMpf49rP3EsI6J5XUulbswGeu/Mcm57C7TNDqUt3V2SJZAvnS31PT3b20p7KOPBbogDYNKXwzlXRyoROM/PhELStDNWbBhC76anAkLYwBibzOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2x4pIRf3vmphRidkefqdqysFibB7yZ2MsS13ghfiYk=;
 b=gbANL3sFNQExHJvs/5ftAq/5CxC4APxH0lb5X/1i3um97YYxbvG69WEK+kCqjbuIpRuh2XviRXJdshop320xuFBF7Y66Phk9/STpFSgs4x3kHKhM9fy8XDZ5xwr9halUMI3XWsbcQK7K8c0VJuYE7gXBCJ3A6a7x+3JtlmCgN2D+OU8HAzL2JVJVqDq6Pa8w55jW7zPkdhphaWz+Pg6LP846zJ3uQE/Lf1ITN+Uu8VO0i/g5TN96PrbTaxmNijkxyS1vGQMR0HqzNovGbfSSvFAipvWxWvEcUBVgIE4cCBxun6GD3EujiRQwnvh5ok4745pya1E46xSU8NycEW5uIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CH5PR03MB7934.namprd03.prod.outlook.com (2603:10b6:610:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 14:13:07 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8678.025; Tue, 6 May 2025
 14:13:07 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 1/5] drivers: ddr: altera: arria10: Add DRAM size checking
Date: Tue,  6 May 2025 07:12:42 -0700
Message-Id: <20250506141246.6672-2-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66702a94-c3bf-4067-0815-08dd8ca81fc8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QbZAvYOjQ+5tWN1t/nJqruX0ZIpNQlM74urx6blH3UCz1tE5i7mJjQGBOyqv?=
 =?us-ascii?Q?eBsGZuprBNSTx5DZ6Sr/ZV6nN0MCcwR3Qu71YtpsxCB4ZtIbpEL8A0ONRmJp?=
 =?us-ascii?Q?juH3uXge8qJR4ySxt9z1CGcUA+dvkZofKyP0tZTFPmC6JPcncod++alvQ1hz?=
 =?us-ascii?Q?81WPVMgHUq1Gj5NCLRro5VLyTP5CMbhEwg4/62x8WFd/i9gY9hrwlaB53WE0?=
 =?us-ascii?Q?g4jGCYj+GZQtTno1e6lboJYnHLPKnGJN6ODJfdcIefb6EF4FuQpHDo1F2Q2f?=
 =?us-ascii?Q?bwn5WXfrENQ8HCNslfPLyzzAsvkxvS7Q4anBlR7gcfdeOzVf3wP8/Cr7vAtq?=
 =?us-ascii?Q?LRziQNO/McrmNCcV0k9fbmvxUYIQtlj+b+z6vxFRCG6UhOXafzEk53hVyvcG?=
 =?us-ascii?Q?b2oG6XzzLlJ0YUFO8b+3xokTM6zZki81gNwwahaPBCWrGK2Tv3kfJCVl7oFJ?=
 =?us-ascii?Q?uDDuQdve/fwFxSyUSTr8LsV8PHcc0/EpOtuMBGaCUJpsrA1X2pBovWnHyvxL?=
 =?us-ascii?Q?S/udjfBFFhZdNhtRlq/5oPOVU/imHOZ1sBKxByx0uFWO0Ci5pvZLwVnTE+VW?=
 =?us-ascii?Q?UzawPOOfJupKv6th6UnrGJj1aLG0rF7Xxkanc8Qq+dctzvvJGh7pEOTzZGq8?=
 =?us-ascii?Q?0kh1CFWOoVfYEc3VqdOodKmCNAFRGENa4iqzkQ3CTZal2BRoQJu9m16ZF9uC?=
 =?us-ascii?Q?mWvR1acgr5X7VjJuPzZ3HWCH+5uLiwUTd/GqA749lfyY0UKKuo21nQ3hHvcE?=
 =?us-ascii?Q?oxRP59XpLoQaReO2x+zYMq0EyNj53FOAE1UKo9PGTUL4ca7AhjI9FF+m5yL/?=
 =?us-ascii?Q?HR8jmEAabM8zxA4S2I4n5lqVM/xCzHxsp1h4ilN8Y10ZK4KzYIM32k1TMbAz?=
 =?us-ascii?Q?7iIfG2VXiZjc+78oO1O1NCSdVtykoh/9+trlotYzkKPbNt7zZtAD0G9i3OfC?=
 =?us-ascii?Q?A9u0838YsceakbZ6t5tLny4jQSeOV8Z3lBrk8wymX2ybIqOwNUDO/aVh8R63?=
 =?us-ascii?Q?a9aHn5sLLCLhOV2/pNLQkJoNdLi9qkDWbq9ggZKdWcucfujpBYrwXxd/xWRB?=
 =?us-ascii?Q?IsWXJV32/8+yULkqviKMnvhzqNMox16QGtACxHWul1hZCaMfuDTP1jPs+1eU?=
 =?us-ascii?Q?J19pG4hOTNAyOCRHTPaQ5bPlPgJTDQIg5UgzcbQOjB5RzBlvGtn9OCUJQzG6?=
 =?us-ascii?Q?V7bkiXSDm+Vz7Ubu2II3fzDPisOa6FbIzTLCh+sjhx8UVwdxqE9Q6kQfqLd+?=
 =?us-ascii?Q?IrdkjdLWQ32eO5EE2m9TbMikZaaias4/FL9DSgtNodEu+F+9lP6iSByKfYgz?=
 =?us-ascii?Q?lPBp3jJ61KTlR7BM9cGGgEWzXtPHikU11JwdB7JjnXOjQ41YyO6bCpJJ36n8?=
 =?us-ascii?Q?E/nkO1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u7OhBfl1PXuNrF9LySd7WUu00gbrsdt9AX5Opnf0DJ6P313QtO99SGlUTHkp?=
 =?us-ascii?Q?Gqe/BNn0RHU8YsyXtYqdPAdVdzeJJkMdFgn3XQedibMEtBcIhiXAm1cxucA6?=
 =?us-ascii?Q?brXhf6Lv92UappHAsRdYKJUcfwernU2f/Iba5HHPoojnhF6ZIBop/+jebb6K?=
 =?us-ascii?Q?sPTDts4x3HWX3RCPI3GlaCIvsu3F/my4IPto2X9P0XoQYJYEl6SrlmPQ7oQv?=
 =?us-ascii?Q?LaLAH1pPhRac0rB4kHWOmOBqWC5ci9tvHDW7P4aUfyQ0ouopjQwFnkOiMpui?=
 =?us-ascii?Q?mAcMjcLmESM0CKTpdkmq+22dA7JYt7uz1nZ0FknfmLlGzbLlKDt3sCaZfq4x?=
 =?us-ascii?Q?jC4SGObcKt7waSJNUpYPpBgePvSwSAE0XmE8leh3boB5JpTvscS005HeiVLa?=
 =?us-ascii?Q?Cc/OFusETMCA8E/1c8B5LQOQNVeM8HViEBWT7AIIXEUPBtx/bG1QpEnaAiC9?=
 =?us-ascii?Q?ovuPe/bGC1VJAr64WZEvwSGSCOy2LIRFn6xdSiw4yPF4vPVk6eCjirKXhgHC?=
 =?us-ascii?Q?TA+PCBHl+DEfJ4mgt9fPLDXjmTxJzUkZ79SPM736o4+hcfKWJ/TTCJArxISx?=
 =?us-ascii?Q?O43KOZ7v69KqAsqxQj7GySl5Jjw+iPI93HL65EBmn2OOKgvdx/0ibzxLaTAD?=
 =?us-ascii?Q?J+JRTMgPYyWf5831FCsI5hVBFTm8JxUyHYycNnLpK2zXSV83+5weWjNw4Xg8?=
 =?us-ascii?Q?+WHu/Qd0RIsFNCu9sv8HcLJhD58+4N45595OsguVJPm6l/W5g6SB5RBAd4/i?=
 =?us-ascii?Q?yMdgMBPHrKF9rJ4qXv9sMHWF7FzFoAzF7O+qzhQWRQxFg3Cm8WstX+VxjlY7?=
 =?us-ascii?Q?cGuUHu8xa4m+jhm+QFojOEC88VCLLfE0uFxY687544YErNFixKAHaZ1/5BkS?=
 =?us-ascii?Q?v30L6f+mTSG7zQZf9eU0L1/KD0IopJU2lm0NRTi3kbzFPrcs6BOYse7tLnT6?=
 =?us-ascii?Q?2qfDoWQ9SipVjtv8PfkBWfflwEmITlAY9P94SBawgdmoz7PoE5azh8AvfLP/?=
 =?us-ascii?Q?pX1Ht54tuJM2MGR9wDUeRW1VVZSrZBNT+ep739eWxyp20KzUFNnkCSbEespf?=
 =?us-ascii?Q?a4rF4wMxQt7SPYxIYRtlTI6YnbOp3nvXlV6CiDKPWnv7Ycg7A9l2s4ziqZTZ?=
 =?us-ascii?Q?XLMB4ayJId5tVhxz2Jm+UXioxdayfN7Pzw+sQHrGK6kfMdpcs0Fmo4k1POcu?=
 =?us-ascii?Q?rpMO62klsnFupZ6l/qXJcfaL+oEc8RVb+C93l2fP2cd/YbJDAS5RbQTbIC91?=
 =?us-ascii?Q?GMDd9n0XnmqCbJPr5xMRkHmxrpdml2ooMpu5heYg2JnAKx+9SrF2sDQE+CjT?=
 =?us-ascii?Q?foaKmuxaAv/XFJZbwIezUYQ3Kh58gUxw8HhXndJXQ5yw7IBKzopupByd5PDj?=
 =?us-ascii?Q?/qKMjfFetLU4WgxQPry1wXzI2X9fM5G57pmLcwOEHbn6DMHoeigZd57PKSVf?=
 =?us-ascii?Q?zCQhO9GvBxH+4v5PjUyoBIh60wWCQSujmULd1G7irwRTUC4xalK+/mCnxWCx?=
 =?us-ascii?Q?5L5qfj2fpaqCwXR2Gx+4Jhuavete04iaKu6QiIiroipCuI/MM3ju+qGr3GhY?=
 =?us-ascii?Q?55MOfMxGdpCKioDaH1nSyHNF1O6KgllAkEGAshTaQl3clJTgzT55EFipUADX?=
 =?us-ascii?Q?BWRNHlsrydbvNyKT+9vXKBw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66702a94-c3bf-4067-0815-08dd8ca81fc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:13:07.3137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z/ix5MMwHj0dOP4WgEzL+oiGaA2P0jkPScg+WvJYTy9CkaZhWhrlN0HySy69q8jBUkNPHy1CJnuOqwUeDOObN5Wc854PyXRy6hWVrtM/HRWq0gI6k4AE2iwF3C5UVR0
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

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d3305a6c82d..d75203a1d2a 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <cpu_func.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <init.h>
+#include <hang.h>
 #include <log.h>
 #include <malloc.h>
 #include <wait_bit.h>
@@ -702,6 +704,18 @@ int ddr_calibration_sequence(void)
 	/* setup the dram info within bd */
 	dram_init_banksize();
 
+	if (gd->ram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%ld MiB)\n",
+		       gd->bd->bi_dram[0].size >> 20);
+		printf(" mismatch with hardware (%ld MiB).\n",
+		       gd->ram_size >> 20);
+	}
+
+	if (gd->bd->bi_dram[0].size > gd->ram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater than hardware size.\n");
+		hang();
+	}
+
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
-- 
2.35.3

