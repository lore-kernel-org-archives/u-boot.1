Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFA8C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B9F82F14;
	Mon, 26 May 2025 20:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tcIkdctG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D649F82D43; Mon, 26 May 2025 20:03:45 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C775F82D43
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jusMwv4K3yWGGENpHcw3yPwuMAwLM71ffWNNkl4dQXD5bkPj/Ii32nBZKEev5358KhwjMesFb014Q7yCQXuwWqD2JZPwHS31IrraEdUK/MI7xZnPRwRwmOvaIOD3vy0QHgipiK9VtHForczRspjMWkFplLWLbj7crZdG5MASNYG74Yu90Pjv/M0D/wqk5SD450l0FoBpCyEmsaBbWu+s2hPklZrsABh+QI/psKxqN8bW6i6w2736cAuFRDZMIyaTYmqym2LfbbMn/6krukn3ZwrX3AhVTwT+XYqpuCDza0q8HdqoOyuEcZXvXYVUuAY0SPPTx6pYMAmJESPZDL2UGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2b5QCIgD+rDcA+8TkLdDdr3N9sNfnDC7z8bimZevpc=;
 b=TCR80e7FKS1hYO8tFjF3MVJu7N06V3oy/Jpb4CWcprLSor7YWldWe9UfV6iz6efxo/hqaXOuoyU9n1f9w/AAFZBt7dDHrPSYPySktyTGHWWM3m4mAnkV4GuHxopT9XXwjFab0JizTSI8yNHJzsQbq8WhHy6GLhv9Utae/+loscsM0EJ5iKWIrOkiBqtntM3YLEtOoynXiRad9Gz1uMgU5Wa1UxqjIXeGR+kR2oJBAF+izXj8UqXwf9uggz3EoXXdXDtSRTrYiyNm2NY0sUq6unZWBTk22EVABIxiZtzpCuxgeK9UOSAgT5I90zSFa5cZ3PrCt+wKwqXQYNHO9PwOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2b5QCIgD+rDcA+8TkLdDdr3N9sNfnDC7z8bimZevpc=;
 b=tcIkdctGC9LpLTXyKiI8r9mRmrwnDMDqgFNP1KlWLIzq8jqoibWxhX0Cia3J4a+oSTpfmg5S5xBROX5DftkO5j2JZbBIHpPt2dziVI1J/RUpfZjAZGFVLZzaVp61UsXQVaGaX5hqBaWUNCtjb7E8mJ9HkU3K7RgSrOMRXupJ4twcucPyC0gs+l+2bkW83x+AXaiAnWWqUGnYKNnXaJZKeEgXK/xTdFV66+6+har/fL/M+ZFUFRMKy0TjsKZ6c9b7oXi8noeOQKyclkjnTu6Vkfn0xnCWa5pqEUprD1W2o38jCKAtYTSUhOcZOcOftnUnbYR7uAwS6+fpasrtOfL4jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:41 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:41 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 1/6] drivers: ddr: altera: Add DRAM size checking for
 arria10
Date: Mon, 26 May 2025 11:03:23 -0700
Message-Id: <20250526180328.13644-2-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01f8b69e-b680-4107-a0c2-08dd9c7fa60b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rN+BcWShWcNQ4l865iS4vVko2Wbo5A0ODAGfleCO/ayDWPHsLLKcs+EAmP7R?=
 =?us-ascii?Q?FQysMSm3BlRdEjU6H0+v3CDJJzVecaZUrEyJHRNUsGwdd+cy6B+E61jiCwrI?=
 =?us-ascii?Q?nHP372/IDLQSi5OkJtXaJjhl4bqaweJ1xr+dCBXA2CrN/K8gjJxwdBEHPotx?=
 =?us-ascii?Q?2AYQ0I8FimgKlI+Q11gjz+eISgv4gVhUMwJyrMGBj17tvUahkQNvRXUPj5iQ?=
 =?us-ascii?Q?9I7du1v6A9mEpALlYclxdXz4yrmFFmEBYk1LqN16ulw8XCkzy/7zsdcuKc6G?=
 =?us-ascii?Q?aoW/zNFj0ydEJaZFtc09xdoTn+ogcaef4c68oop48IWoSfvHCLcbJj2B+bVO?=
 =?us-ascii?Q?bvvCAh0KS2PrioISlqKeGS2rIpJa/PY/y+yCRNpkbsjbFmtv1XPKh0XFUAw3?=
 =?us-ascii?Q?srl1oJUkrSwHJ2cZRV8sO4lk6Sj76OFcqVzjNsGWEsPSV+bwIMgCczS5TtUk?=
 =?us-ascii?Q?qBxL+6pC+QTayE/8dWRmy84RbZt9pKUecsIdIdi3AYcqvyrBacMWzS4SJH2w?=
 =?us-ascii?Q?IFvb4kNsIPFIXl7o6tMr/dryOmRxlPQEXZUto1P+TEqX9JYxkUYy5FN1Dior?=
 =?us-ascii?Q?2E7+TvbbUnTqMxqjapC7gbhWfFRgfLSjqlycm0wrRIVyXc561aTFtn/FDoVU?=
 =?us-ascii?Q?00yRKnGjDii/2OjJoV46ABGsNhG4LKkraomGTE1PdmqdJjWiXGIeUjTESjIG?=
 =?us-ascii?Q?m3Nb+Qootismr5ZCixYApTpSqmG5o/CZ2sjQ2rje0fA3vvBgYV0VumKFFhXq?=
 =?us-ascii?Q?G8U8uC8oatx/8y38STQbrI43KgwqMSrUOMx4NvsrxxETarO1Be1RtLYCVSSS?=
 =?us-ascii?Q?1LbgQrab+YluwDdZBDiwyOWMd3aetg2NAFxBAo0AY2W89bqHX90eTVx8c4I6?=
 =?us-ascii?Q?kV1G+ONNav3Vtt0FpVgQCyLWiLpXz7WkTtvWBQKubWa6QaoBjiQmC+vRapsG?=
 =?us-ascii?Q?2P4l9I3bmdhDXusafZaUXBUTqFeAm9K6CllTZEYVo16lj3lpTkUYwLbLelN9?=
 =?us-ascii?Q?vLRynf70EgW3Tozqi6qQaUCx5/uZFn1uD/ViqxiKbpfQGQeKSIQVQiWOHB5R?=
 =?us-ascii?Q?nhMpFYZYGjKZUpeTzst6mtpgFGHDKYXDBGr9A/cZyrOjS8JjhHXpGFEl9K9I?=
 =?us-ascii?Q?Z4+Xj6ExEoGbxTCo/ZN0I/Tcz2ykJNKwgLWtHxNy66RWgQMiFaEXvJ3FkrtY?=
 =?us-ascii?Q?xVPwRkJ5UXZ05totflO8/tqrf6GqJvaV5VPoB2EsVGgIRcLB2UxiANosB79s?=
 =?us-ascii?Q?uFS1FA7dWVcgC+TGyTpjrL6q5M7VmZrxiXcySAEGvm+sHKW3L1XInSokcu3S?=
 =?us-ascii?Q?tRW7+QSM4F0ZDWkl4THglWZSWyyzXYCzGQm00Zic8wbIUnyq5XpFlhdSCYJu?=
 =?us-ascii?Q?vc0+RCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e7jsdhugRwu75VAxTXGASKQfvF8ReqZZXSl9OX5x0nA7p2TLyzvIhDK5BWr5?=
 =?us-ascii?Q?XnTTkFxWVb6S1lM5jPpxL52tw+LDO7k1rxN6pPzdgknZ2MRGwmmft5Zr4taE?=
 =?us-ascii?Q?sOWSZFM70/RXRFOAwKIDue3XWm8RHH/4ENlbylQUrlFDnSHnfMvfkXVOvDr/?=
 =?us-ascii?Q?WsgdxRit1qerOUydtXUAubDgIcsbNkFigfBVc31iDa1HpxjE91m2LLNdM9Ni?=
 =?us-ascii?Q?uacBDnmnINyyYHB0eVbjWTZfui3d1L+hJygZzCTBo4tsiSWEJvmjNe38euKM?=
 =?us-ascii?Q?vnBtQhh9MXtO9UaOkRL98/R8XDwSYe9VhJKdAV3alibr59Bi/6egMDHmkmlS?=
 =?us-ascii?Q?JdQN7DST5mn5fGYFC3wHsY9Y+YRgL6BRFsCtMZUb7Tvd7Bab6SmtvA7mqWEO?=
 =?us-ascii?Q?RbFCwmXTgMkrgnfqbP3ehg9GjYWr9ln+WSqBofM1uR1c3lq3OdEfV1HDWpjx?=
 =?us-ascii?Q?zS5+YgfRYAGH64CBMhF8IuAvPS/RNe4C4ppZKRDniuyxV5xVkALVvWKqKV8X?=
 =?us-ascii?Q?DwVhXVgt2dOFLW9ZSNTLCuBMGYmDnxnZva/IBKV4sghgm7nmuVTRRyN+3YsH?=
 =?us-ascii?Q?+dR2hhrN/H93eMlJ6t7PY6RcrQFsR0MXhjOHh81VaZkxEF5WRUvEoyAXuRLa?=
 =?us-ascii?Q?1GNoBGX2wJktffN1WNoUPHbSrLUob6ssyT/7sqXziHhaJozHZ/bC+SxSOfmc?=
 =?us-ascii?Q?ol70SwYzrBw6N0MmumV6Cc6a6MUMiPoODBWPnvkj8x6Jduwj2zCN68cRyRgI?=
 =?us-ascii?Q?noN18LiLgtuDTnsTu4iP39pANxeGAsX4YnPeauHRZKVwjgt+I5OwU6c5bpEg?=
 =?us-ascii?Q?QCVux2nzpIbxY8NN3XlCHgYYf7Trph0bjZ/eB36/bwiVdapQIwo5l6NIJp2i?=
 =?us-ascii?Q?gKyklt2E4Y1oCb09e7mACjKxNJRqVyrgSInQY2JTwZqLbilPWN6EXxliF3jb?=
 =?us-ascii?Q?/bzhSptH5tO1ME1CwbgWh6DgEC4vhiN0VabPvEydDZdLiuKM1XJhB8XvDtH/?=
 =?us-ascii?Q?7gpSeZqoo/1SPKJY5DQJp1DraGmZFBsm0ZnRIUHyd8rGjUtBZIywl5hhXKiP?=
 =?us-ascii?Q?MsLdgLcTf+Jkx43NTzhuX6PzuBvCuWLPh2c1gbX3Taz5E+bsBQDgy4cO3kV5?=
 =?us-ascii?Q?PgykA98v2wFtkDXrBcspYmzu874DYLypklgSZMjwlelLmTdNavvCnWeDIVu9?=
 =?us-ascii?Q?hTLxl0gI5dis+t9ZKWWKzSlud9bGmIO2EPZzGS5nuXIbdIGZ/yzagoxCdC3A?=
 =?us-ascii?Q?n4It8+hqlejC4lWRv7nOL+PwgaHNp1GOiWj3HLYC3RbFPWcIRcR9uC6IIYTi?=
 =?us-ascii?Q?2qMzvihtvEn3/S7ITOzF9a2J0WLOhZWXs93Pd4BW4jiUNRCGmyvLDDKGrjqY?=
 =?us-ascii?Q?tcSdvVfo9B1/d1dGHXTcGttUP8fOBoyr/F6pJligcqqaZ5qlMOrmZlT0pHDa?=
 =?us-ascii?Q?Giv2hjEhk1mH/YcrRiG5GtfjE4SpzHjDAqla3aKbiqo8bEdCzXlywA1PPEGe?=
 =?us-ascii?Q?ag5WaqXZB4FZlsTrlPkR2eA9IlWJk3BwUiKHz5SybnSBV6BlIbG5c6B+7L3O?=
 =?us-ascii?Q?TwARDhEexkQWJD4XNzIbpGf1uocs1+DOzPtTfUkVr8kbACz7AXkh3GFmhhuh?=
 =?us-ascii?Q?ASV5fWtWa2CtLf0BKqNIAR4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8b69e-b680-4107-a0c2-08dd9c7fa60b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:41.8043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EwnA+giYiCxAM8jbiIsn3C+m56wDXoZoPcapKClCc80o0rBzAt6LWvk6fjeV6tv5hzhJGQn34h5t7qwbOLgiaDI37lUhKzoLeBpM08jrTcQBmFNaNm7nViu6UIKzIWC
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

Add DRAM size checking compare between size from device tree and actual
hardware.

Display warning message if DRAM size mismatch between device tree and
actual hardware. Use DRAM size from hardware if device tree value is
greater than actual hardware value.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index d3305a6c82d..088dc1cb33f 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <cpu_func.h>
@@ -702,6 +703,19 @@ int ddr_calibration_sequence(void)
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
+		printf("DDR: Warning: DRAM size from device tree > hardware size.\n");
+		printf("Hence, initializing DRAM size to hardware DRAM size.\n");
+		gd->bd->bi_dram[0].size = gd->ram_size;
+	}
+
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
-- 
2.35.3

