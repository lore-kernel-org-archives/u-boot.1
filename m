Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2461D5C0F2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947DC836CE;
	Tue, 16 Dec 2025 09:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FEVlAjx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB76837F2; Tue, 16 Dec 2025 09:46:35 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B2B836AC
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaUDSeis2j9Gcbsvi2U30oNR08TrmLRNVZ7Ydv5XnBbgkhLnn11kcFhzHk5ONA6ys6hQCiKZv2kSkKIhourGlw5o3oZuTYDxbaMkOZTfNuDJwl/n+aXUEDP0Lyth1j7N3btP6hmFxCPuV6AIA5jAiUn4CJfU2lgaju/jPMzcC8UGN6aQoHbZxmpqztoDSMWD0tOjqAyCZQh2ilrCEbe4+G+1qHOYPMIVzBjEOSZkn7P6OkCdCtwZDBs998DnGRPkxWkPKRQJxCy8uMEpk6mnGABX5QWEK2fLsVrfb8PH68R/82qam1WfvE+bUOumj48Rx5Fy/+flnh27X9Y9f61SUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gaFNqA/aS7Q+Fxvg2+voJZWtWWVunkbIFm9cDxtT3w=;
 b=NvRisX4S0u+2Tj1B5zWpGxRWozo6Zv8AigvEkWkRPLw+/RGepQnRD8xVPFOjrLKIeyq9RZOjGLU8Pggd0utQhdqbgmclXdCI8Ppsl9ukh5OdMuwZMukR6Y9aHTYw6jEvGFZYuQ2BEfvEM0uZ+HKhgR0brSOQXWS8kG4CyrewBWWgUZmNV9r3gLpw0B2D7KGc+Lzs9eyxlLWVrRuJyxd1V/y5kDnEZRe/lqXc29z1GphJokzCV0Clh6K37A2+o/pG1roVXuWLfuJlh0UqTI7mRYyK4kkxvlwxYVJjHlKKOv3pi0wArYDQqhg6jNTiS62c08nBgrHJXgNBu1WjDpmNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gaFNqA/aS7Q+Fxvg2+voJZWtWWVunkbIFm9cDxtT3w=;
 b=FEVlAjx2XHj/+aE60hZpYW37HOa32afYiTuXT/DMvGJQxvVoBksxGdmoolY5pGFIOKISrUb82q+YycIBTZxxaC1cFgu2Nag9lg4BOrg+Th4fakphaLJ5L7F3Ib/D9ZZi1pQdexswu+V51cFXq5wDIYCVRUezrmpMVh4ZBEA0VBswwLFKnV06s/+aM9q5f66/eeEuR6JomkZi47XWBTZX1SSUb1Ay4I523a06licg+QxVSaAQi9eVAas/M2JhCWv6OrIuo6ldhx2xaqQKy22D7ozVLljIl1xJmQ9z9AlzqBmSJJhDth2guuFHrxH1ZlLm/Mny1k47JoTCvIWpucf/qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
Date: Tue, 16 Dec 2025 00:46:21 -0800
Message-ID: <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e10b63c-344c-4576-2641-08de3c7f9aee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dECc8I94KG6ynJ5chfF+u0dlrOS1YzKwWipU7JmOdCv9JDyzWdf1PDFrtJMF?=
 =?us-ascii?Q?1hNZptkOCKUCCrTm2BXboJ4R2xELarQWje85fbMOZDTHorL6V+kM+u9qov71?=
 =?us-ascii?Q?lfIKqGhjyLp3dwCj+wlWmgU02HReH02Xc7czMJTs2p+aPe8lbZY5P8t8N/xl?=
 =?us-ascii?Q?LKN+Jn/uRiOmOVItg2acsJ3ky5gFaGjyAMhm0+Ubox/CxTkws7FADTPQJ+hX?=
 =?us-ascii?Q?eTd0XfnSq3jNvbSbhns66cVz4kyyX9gNHp++AhfI5h6gFSyNZxEGlbimybLz?=
 =?us-ascii?Q?6EldlV7CtP30d9hZutqvk/ZQOUwqQjlHEPfIkqS4HGNH1s/G/6DwvIDQKop5?=
 =?us-ascii?Q?9KlvH+ZFt2MvqpLOTxIlUssvFcUnaX75+97DaXRyD/K0i0DfdlhZ7SOQFtPs?=
 =?us-ascii?Q?Z3jTedegCBvT3mnWjbAuCdH4L6oRRGcHX/cHkVUlfresE1Y3jcUUeEeviNvF?=
 =?us-ascii?Q?s8LbqMW/iQZ7m2e6Y46s0tZjwyvLhGe2lxNe0QWjRdRfMinlyF17XwJMalhZ?=
 =?us-ascii?Q?JKHJOivbVRCOgL4z3SyiRPO4ftdK+kNOHfoG9PC7Zln8YkVC1FspKCLgSsqd?=
 =?us-ascii?Q?23hxPLa9L5MT0ScORd2KR3CQUCPyFqQegTg8eOZy7ajykTUNHcQFIHHsGGo9?=
 =?us-ascii?Q?NYfeGZJXpEfS1/Yzg00N2VZ73XdqUe1pnCCzYe7lPBEu1GHUGggHCdSecaa6?=
 =?us-ascii?Q?u5RiOE8UPapUw0sCY0dS2tHEVgDU+s+3NCaw461Fp9eo+48AU1g5d2fkedsJ?=
 =?us-ascii?Q?zfv91WyIkrIbHbwnYsJFizxUMqZdy7hnOntULy2aqOIOFLPfbutt0xZUuK8b?=
 =?us-ascii?Q?EuY80/o9p1mBG/CqREocW56N+u0YTpLXxzsariobAYnTOX2a8bY7XgAvZ9GT?=
 =?us-ascii?Q?LOkD7fEJyvLRTsXjRRxwvDr1tEW++A2x1JbrTeGYx6tNfGCcgSYlW61ESURC?=
 =?us-ascii?Q?JimjD2CY3+gUUgkn5TyKgxApeRApLi0+v0oJ9LccGDjDtR85vA/rOO7ttcE3?=
 =?us-ascii?Q?STX9DPDbbXIK119ec/GZca4rwq5D9/rtx5OQJQ3Hungq3PLNaU/24D3+pWx/?=
 =?us-ascii?Q?wJA9McwggpWxMXxuX+oxlCpqVrRM3G6NsTCfLZ0COjC+X6ESKcKhJrLRojrN?=
 =?us-ascii?Q?O+c9kcX4CGvV5s/yCzzYkCpGJNzhaS1H8dfwjQn74O68ELRMR7klqUQ10Oq9?=
 =?us-ascii?Q?vnFiWXXw/Fh+W7zeatr0KgrXerTV/OzHKzBsIJ6KbVRVXXoH9SZ/7eJHYfdz?=
 =?us-ascii?Q?3BZ+KnolpE6ZjOxva4o8JbJLrOFyyjUksEsR9HJuYRDkY/oE1qdjkcdMbF/Y?=
 =?us-ascii?Q?z+SMFTg89UdQXpm0Zt47U+P7DgXFIANS3GzwEMq1I6OFoiB6udhMEd8/iWh4?=
 =?us-ascii?Q?xW5mMbqI77x/+WxOYpUgXAnhvbSaOpyz3kGLrl93McRM9h1AxlGcPl7V5icy?=
 =?us-ascii?Q?x1QKnYHsuu14rBILkMdenvQU2LuQtsev?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XEFQBZfM0XE9+mha/Lziz0vczaHbZf+E6xUTVZht5bvtbk2FeR2FxIWfOFRp?=
 =?us-ascii?Q?AlhkETf+ojh1O6Ew87JHuFhqVjuTczOkyxIiVq4DUkvzJS6xZQFnaUBt92ir?=
 =?us-ascii?Q?1yogKsQGY4LHelq/E8uy5L6bb3JaOytsiyKC1CPhT1191EabyUvtZR0RHfX8?=
 =?us-ascii?Q?MQMZNgLUK2Qzr1tnkryiWc2bgio69CBA5oayGIShYyRMFqxqsWH0Gyt25qj2?=
 =?us-ascii?Q?MjmUdgSO6leDrMODUNtqX3da6HyXSvxbktGzwEW1/owZwjIbV6mda0RpfxFE?=
 =?us-ascii?Q?MxF+wovk7jJehKNHaq6DhbKSh94RWIetD7EMXqgLQPNWMr5+ACGHJr5qSJJ7?=
 =?us-ascii?Q?ke6LU8RKqWsYiyehAt0HAWQmQArKomxdH6nOju8nigelCEZmJKxZLVn2NvUG?=
 =?us-ascii?Q?YyRyIlZhgCV1TzjZ0Y14vxj8wgVZRseOZELiUwQ0IoV9n7CttfNIEEvDTc17?=
 =?us-ascii?Q?kU2C4HHebNSS2LXKtNhPTJhzdZgV5VyS44G7sKCWTcGkpP0IKsXqrFFm9g+M?=
 =?us-ascii?Q?fnuuvNBhVM6qP1yf2EzwBWAEeabCVYvyGevW58pAQY35eDPqf9BHPbSSLo+s?=
 =?us-ascii?Q?tOEB0TUC2NI/V/zxb19l1IRi8ZFlsrSgLcWncaxlZpeLZ1ksu13trtWZqGm0?=
 =?us-ascii?Q?0a8m87NZyWcQkvOIo4lwQ6ICHhvNgH4DSq7aibFlc57sdNJTeqUXKAWGNmZP?=
 =?us-ascii?Q?4o+v9K295D+BGIzH0Y0e3R/BgcW0k0s3Kr9TQfGOSLTXTxHJejwiiV08Vamy?=
 =?us-ascii?Q?BW+s+OZtQPMBxpms1KE3GMYCIzleQmcaiwCTOlzKX9p1H31RaLYCQV2kKkXJ?=
 =?us-ascii?Q?3dyJu1R2OgDqz3ES4JLwalyBrapLIWAP2jnYA4eydchQVyTLKyFPVADn6dJs?=
 =?us-ascii?Q?FuOx0CAca7tRh5dnFoln4kENK/HKM5A0Crx4PvxmLBKX8KUoKvbyRrLjrwnB?=
 =?us-ascii?Q?tLRrwdSe2dXhsA+qhiv5f8k1J4m7Q9bUoWifzbeMEJudhfSVBBfMArMpk0h3?=
 =?us-ascii?Q?u+U0uOwhEIa98Fbus2XLugSCTnslDIoiMt+JcBsGNI2ZSGUN2qepoGjdXd9l?=
 =?us-ascii?Q?p89QYFEGeuDQCIXdxVTGr64UUjOU7mG2x4m/tt+tgVIHsprMd+K1OuzeTE4h?=
 =?us-ascii?Q?ObSVI6J5FyDIEIwhZM8NAA/qOXpOO+oAANlytoKk/sA/NBs3OgHByfci9FD7?=
 =?us-ascii?Q?fDFA3sRdKWD5t//oX0+MUz/Va69qXP0O9xRhbq2IzjDkNEoAHAG1l7xxCiBS?=
 =?us-ascii?Q?BzbqcU3HcjmlgId08N4/2Qw+DhUqE317m3YfP5K2STUEERa6F/d5Ra0Gna3i?=
 =?us-ascii?Q?yaWzPWbDW+vnyKkjVWPFx3ICflcFmKuGSCT/BAf1Id3FuMFxzXecMPgBNa3b?=
 =?us-ascii?Q?TbkwALegUyMSbNrWw7NN7KFbD618f8FKhicnDxcgjqLTZwdLshV6v09Hpysd?=
 =?us-ascii?Q?Sm4np3YUKm+pQXyVr7YJtxE5REuSuBLSgjQLjExNmzEKQqRBr+Te+kcDQ3Ao?=
 =?us-ascii?Q?UKv5bc+9FoFkA5jwt3DmVJ5YxzEh4SMkjwmPZXLgA8B+gdMUZNxEAItoZR9m?=
 =?us-ascii?Q?5tcrMC4LJCJdCHxoBsEUW2PJeMpAEHE38vZUD8pIAsWKhh8w8S5LBWXieGbQ?=
 =?us-ascii?Q?yoYj4/BzAIRcP39ThfXjZTTexqzEhLs1ip+gYWu13g/W7sB3/zPwKWvnQdbz?=
 =?us-ascii?Q?GEiv4FIgkaLl6tfupyllXtPh2Juq52AzCNF8MX9QTVjiAv8np2qS77aGfjDw?=
 =?us-ascii?Q?vGpOmMemAtz8Mvx+4PXU0zOVLuCvSvc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e10b63c-344c-4576-2641-08de3c7f9aee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:29.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDOwEZ6hcJwdVepXah8tPleLuAu/ukCAGdqoi7nhI5a1XBHD4Tv17dAyvBjoL8oiX7eV6WTAwNJNR6pw9PLms2d7PsZUmJ65E0KCuwZrPAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

get_ram_size() uses size from device tree. So, it has consistency with
other device families.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 7a0a043557b..d5892850da7 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
+#include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <ram.h>
@@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
+	/* setup the dram info within bd */
+	dram_init_banksize();
+
+	if (sdram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%d MiB)\n",
+		       (u32)(gd->bd->bi_dram[0].size >> 20));
+		printf(" mismatch with hardware (%d MiB).\n",
+		       (u32)(sdram_size >> 20));
+	}
+
+	if (gd->bd->bi_dram[0].size > sdram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+
 	if (sdram_is_ecc_enabled(sdr_ctrl)) {
 		/* Must set USEECCASDATA to 0 if ECC is enabled */
 		clrbits_le32(&sdr_ctrl->static_cfg,
@@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	}
 
 	/* Sanity check ensure correct SDRAM size specified */
-	if (get_ram_size(0, sdram_size) != sdram_size) {
+	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
+			 gd->bd->bi_dram[0].size) {
 		puts("SDRAM size check failed!\n");
 		goto failed;
 	}
-- 
2.43.7

