Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5D5C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C9A82F10;
	Mon, 26 May 2025 20:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Fs2uC9u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C05882F87; Mon, 26 May 2025 20:03:57 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6BB82F10
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzg1Hh5FcIw26VW1UrPslAEPsAWQ+2TTLvfTYn2wEWxZ2tM0EQ/Hs0B13VAtLwMhnERmGK6Pz4uWjupp3CH7bGox62A4O05FJx88YFJ8TYTSxU1/s9tIF297R8vYm62NPUea8R4TqwKRu2W8u0s9r/ve4uUEltPyF0AWvq0MG0DhSDQtcgz2kT9XWWN9XWYv8R1KTe2FaXTnNYtQrs1010kFhXhKYGgu8Om/wqtAiJDZQ7bt+L/gBqWV5FWwPf0b5H/J5gpMUv4L3zZwNVm2lJgW1ERZFlGTnQBLhiBtJkTIsciOsftSnbcoIJLxTFVD96OiXQAKwoGvE3sJzuM0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg1FkHFkFiJ7O0Evdr65LFSJEw+3L70bpcgCX+GmTmg=;
 b=uhGBpjqq9VtMiNM+2dWgPyscvHTQTTWoXxJ5ZGujkAVfYzOME3g1oKomD9sN84Uc3so+knxrxc69eeWCuCYglsb4yZu92DqXqUMAzxP7+qJydKyIbCcZl7GMmjvHoIJQS53id6tw57zXjzOkX6cqud2Kaea41NSh7owtSWyfA8KnTckz41COf7dd4BEshfdT8mExqusvASBZp2yS7HH6MII2v4trBrzGsZwiO/yygnIf5ZwdxDdKYwuGMgjKzDG752BghJmHKU7OSDLbJtyzYLRvRxS2Jx9NY3FPWh1hvyQzaDIJ+c4jWA//0nQY708m26eYpOzvNl02T65ymbrchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg1FkHFkFiJ7O0Evdr65LFSJEw+3L70bpcgCX+GmTmg=;
 b=Fs2uC9u1sPcjaEli8NISKd1LiyBE98Ava+WpNlCTG9WnuQOaX5oyd3g2oFG28W7o/+6aqvW1egOYpV0GiCGUzFwuuCyJUQz16odDQwfGdf1RyPPmtr+xoDr1EYCCADyJ29Dl6+gi0Q9/V6HlYTwu5WdLjQfOiCTnBci/GEdexY78PGZhgCu5OZJAdiYmi/s6Sll/aY6DaIRLTyEnmmLU3C6nbxWS/M1wVP8XZnpgF2dYGnM9R8zQZ3mAXFeNoIO788R3ID4+uQSzWddCnwnO5rBXO5t8F72oS14IpSs//IO5QhpZLsGPnldHlVPapFR6xmv++KzFIdx4RokiMoT0Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:52 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:52 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 5/6] drivers: ddr: altera: Correct code alignment in sdram
 file
Date: Mon, 26 May 2025 11:03:27 -0700
Message-Id: <20250526180328.13644-6-nareshkumar.ravulapalli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5286873-3b23-4a55-9ad8-08dd9c7fac71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sOHAm7zqHVOcTa4p8+/e9f5wPgiv8y4gSbp1HAn/JbBqAihCs49OmYvzPcO/?=
 =?us-ascii?Q?zhnEOv7RRSFKRrRjyo1VGTH72WgCJBH/WjaS9Q9Gd2p0v+Nrl/xIs2t2Xfma?=
 =?us-ascii?Q?8O02Jv8/pwg6Iu/suwjyk9SxZQFCZHOPoej9bMVQIs3cA5J7nIpauRsByB4g?=
 =?us-ascii?Q?5OUdSqm2yscJVBNQSfpjt7X0ztIX2zhxBV9pVXof6CqIH6+DTCpxdXaw5FZ6?=
 =?us-ascii?Q?j2dtHeLJxrmPUekYvDqEnpRgprpQFXr2uOtte19+EeM/Y9+eBxpyphpYvYlT?=
 =?us-ascii?Q?ffqiCNNCYxiWqqmMmY68VeqHidz48+5Yv5hPoRIILlLwKPoLgTj3woR2nLhi?=
 =?us-ascii?Q?pFGa0G9xp669bEaAY0NnwlNxmAzgoouvjEb9DqNF0t35PdJg8iMgaczEooIx?=
 =?us-ascii?Q?LPuxN01PDMRehy9cXhV+AzQZCg5WAheUTztE7bxpK7OxUz2ZykUzF1wld70/?=
 =?us-ascii?Q?1eFXaLUEVGZPGmlsUb6c3BUI18+wrodOgWIiOn7rhU8Xgro9i6Cb5LUlf9UH?=
 =?us-ascii?Q?OgZa4vZ1h8fdhoTpO/WvualyjvFI1E3dQkBErtp9TMfgeYVk15JV+moh1Mvf?=
 =?us-ascii?Q?oUKbiVuIq2GK/Q0wNqQczdzeCbX3ca0u384E3STlK5L0gI9G8ihQc5B76Aat?=
 =?us-ascii?Q?Zpd48XvWjbBixkUxST8iDZQP266rPxhriu2qJ4+h2FA8k0DLqlKhPTO9AR7K?=
 =?us-ascii?Q?f/PAR4pB/rxK+oQnEuumTUaEzRFN4Ynbq6H42UmM9Pwtj9pFDza0FbaSIPgl?=
 =?us-ascii?Q?U7afSl69m+1Taw4JPztnkzwPos66gZUTI2rqDGemGiWbL2PN5WQ3BF30iAlR?=
 =?us-ascii?Q?yo6W4NVRS8fDVTvEvpjKWzTZWUZsEuTwHN3nypWMCzQVmGLN4t9YP8ytFBlk?=
 =?us-ascii?Q?sJ5utC36YzEMMYkgf/LlEeflAPGzRLrhQQ42zwUfL0BhqSPtMYdGI3OMIT1R?=
 =?us-ascii?Q?fxKxwyS919CEIEdZ4vNCSgPkEw5V3+M7xYvAqJdyh//6BAb9uAQhCAmCSs8K?=
 =?us-ascii?Q?nY4BvqYWat0fOfhG05MkY/zpO25Uir13btfYBFJatpJkIk+zlGDifN2/ssAU?=
 =?us-ascii?Q?B7kPtwoWXSzJ+L+rT6CEkQYSz8LjKd9w7oGs5uwczwVZ0T48AaB/N39rOr6A?=
 =?us-ascii?Q?AHDZJphuD7UN+UjSvMmeHT9L2up2IhZ0Lq18Et2rRa/QKt6QJYsDhuyIy4Oi?=
 =?us-ascii?Q?A8P8r8L3WEd3nhHP9FDB2nY4m//WeuSsy51lQs7UddhIDl7s/mjf3ws6AVLc?=
 =?us-ascii?Q?tfCpRAkbeATUe9Z7+981tfwAryZs97qpBaCmQGiC55SWDo28hfQMhfd/cpn5?=
 =?us-ascii?Q?e56PMIyuuxLQZKY6ahG/LK9nM2r3y2OQqVgEMId5Lq3at6b8R+dBSggSPzYM?=
 =?us-ascii?Q?rpMTc3BmSSUnVBunOZhL8Q6V6tfmerOHbn+NAs336LLSlcErl0pIufCm1r2h?=
 =?us-ascii?Q?klE+pKc4GwA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZK8LhUwG0YaUSd7e29UrlYdgRw4TRSihdQ/uFb/E2PIVhSruKCPbbuNxbSS?=
 =?us-ascii?Q?TAmSbX6FlP9Vrd6j2mJdYEHGYCSXHJB6Y46XXtOd6vpJhl8ZqDO/UNsr0r06?=
 =?us-ascii?Q?U6b5khaWk96s7HGD2MUUrx4GAUvmhTa56rUiqv4VGEkogqChUMTtFZzE+D0p?=
 =?us-ascii?Q?Ppsh8EIQdFwglI9EtZ7kOOthUJ3zFuAGiO3aPWti0Sco0mrqeQKZBszkJ5vE?=
 =?us-ascii?Q?ui0EbKv7ek5+UjahXlQZF90fjq61ENAYEJsFG8b8hqAhtAhBwmsj4q5/lm7h?=
 =?us-ascii?Q?u98mc5hXbaIA9U5NS5Rg/jgcObYNxjByEQ/LLk5dXMDYsHQ5lY/yhuU4jQPo?=
 =?us-ascii?Q?Du4wB8njw+YSKx6AcKXXoZLVex//HKc50KkIQIxfIZ4bmZbw1S3XofAb+Vta?=
 =?us-ascii?Q?NP2348TBziYYiC7COnrAdxCfSxN0/XKwW6dfSOC321NuOdNawlzOLUVx3MdP?=
 =?us-ascii?Q?fbVeF/aoYBoZ8AW+351AoUI/jL2u3gNfghR3RDdhO0/IDb7E44aYAJvFCFPV?=
 =?us-ascii?Q?2QKECN6x0aSBm1TdohV8NObl/6xdXDJm34NE8LXXjOD2NsGutHmApObVDKDt?=
 =?us-ascii?Q?F1UBFGmrL+hLNzYoCeIj7rAe5GoYwL7a8hFFZX0hoCrpgW9Gj8grqGfrZ2Wg?=
 =?us-ascii?Q?gU7FX+GDIn0YX1AhLMdyhkSzk1P9cekS59494492zg5a0NAEMV9H7KHW6N8l?=
 =?us-ascii?Q?naqTs2Ky42IQ067aWbW7PeM/lsVl9+MnLiioTwCst/DgR+lTP03URlJV7dyX?=
 =?us-ascii?Q?5KC8pJ+cuxrPDyuV0yUZBtAqV7w399CDr8cB+f6xH8DhAbNB9GExl6Oaq6LR?=
 =?us-ascii?Q?c39+znwgnAsGOm6ixmdQzrwVPR6UOvr2QspC5TRJa0bKnrzp6rZeJIwU7aW8?=
 =?us-ascii?Q?ZGgVOYh8/ELDHapt8n2f77wyzSj8ej7TtwmG3tWZoLLIEWFLUhjAXwKTgeCv?=
 =?us-ascii?Q?Vv09eLC3RWZv2vcwWjOA9PzKGSgHe7RCmI5UyOV714P8k/y6K/84pX+u5/16?=
 =?us-ascii?Q?R3G9G6HaSRDTwBSSOIQoaPFXuGNHC+I6lbrKRRl/KGlHiBIpZWmzHXzQVL/M?=
 =?us-ascii?Q?PvTLEs8Od0ayBL+tR2Nb7Q9uQWw2f4KVJukqub7RPeYRXlip9favq5q3GabK?=
 =?us-ascii?Q?n4inr5TQvRqwbuKpLSne+6hsQBOKJl975Wu2eUWtqH59GS5ac/w3ncGVid64?=
 =?us-ascii?Q?2iR2+BQ8Jlb5njTm6wPT2h98Jp6+GVqzD7IPr5NOE+4g5RaCzV1bd1VgMQlp?=
 =?us-ascii?Q?HwNc8dTfBL8Vwo454hdw9JYDYaAV1I560tLDOSHnzKmPn6CQKePVP8CYV2Po?=
 =?us-ascii?Q?hp6Kc+z3bXU2JnnL3JpIZzSciTrPgQyVu2hNOztRqfQJlSrMaGlJ7bBK8O6N?=
 =?us-ascii?Q?gvXV4CEgesfYDpFvyA9ABgBjkFcag2vIqp2HkZhEv7Ba9pcpOG2niuo9J8Xf?=
 =?us-ascii?Q?HEDQdtEBLtF6p/ZKlVgMjtkAEKbbUMFp0p1Z+FH4EueAwJGSSD9eNwNPCpPa?=
 =?us-ascii?Q?QvUgo7pAddk3Rdr9YTkXjseMRzgs3MapZq16EXQ09ZhMP05N/r95otoj1GZf?=
 =?us-ascii?Q?Qg3bszxYZEl4IO9Jz0OgF9g9/LB6fAiDSHHEaV/wuIV3kQsQgbowD2l0pOjk?=
 =?us-ascii?Q?Ld7oUhxe9sJk/0TpNxNVY68=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5286873-3b23-4a55-9ad8-08dd9c7fac71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:52.5149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 872gXlD2I3gBlEY4cvEal3qH3IwWH2a+k5+PAX6fys7x+sk+3ZuDYRtblBRt3fkOkN9V40Az0suQmrZrXn3AXHWkJVTlccCqBXodIPYZDRMynD2Y3JYAVgOB4AyA24+L
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

Code alignment is corrected in sdram_arria10.c file.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 56 +++++++++++++++---------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 4c48b1bab6d..a1288d5fb50 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -128,10 +128,10 @@ static int emif_reset(void)
 	s2c = readl(DDR_REG_SEQ2CORE);
 
 	debug("c2s=%08x s2c=%08x nr0=%08x nr1=%08x nr2=%08x dst=%08x\n",
-	     c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2),
-	     readl(IO48_MMR_DRAMSTS));
+		c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2),
+		readl(IO48_MMR_DRAMSTS));
 
 	if (s2c & SEQ2CORE_MASK) {
 		ret = emif_clear();
@@ -161,9 +161,9 @@ static int emif_reset(void)
 	debug("emif_reset interrupt cleared\n");
 
 	debug("nr0=%08x nr1=%08x nr2=%08x\n",
-	     readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2));
+		readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2));
 
 	return 0;
 }
@@ -224,7 +224,7 @@ static u64 sdram_size_calc(void)
 		(dramaddrw & IO48_MMR_DRAMADDRW_CFG_COL_ADDR_WIDTH_MASK));
 
 	size *= (2 << (readl(&socfpga_ecc_hmc_base->ddrioctrl) &
-		       ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
+		 ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
 
 	debug("SDRAM size=%llu\n", size);
 
@@ -263,7 +263,7 @@ static void sdram_mmr_init(void)
 	if ((readl(&socfpga_io48_mmr_base->niosreserve1) >> 6) & 0x1FF) {
 		update_value = readl(&socfpga_io48_mmr_base->niosreserve0);
 		writel(((update_value & 0xFF) >> 5),
-		       &socfpga_ecc_hmc_base->ddrioctrl);
+			&socfpga_ecc_hmc_base->ddrioctrl);
 	}
 
 	ddrioctl = readl(&socfpga_ecc_hmc_base->ddrioctrl);
@@ -351,11 +351,11 @@ static void sdram_mmr_init(void)
 			(ctrlcfg0_cfg_ctrl_burst_len >> 2));
 
 	io48_value = ((((readl(&socfpga_io48_mmr_base->dramtiming0) &
-		      ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
-		      (ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
-		      /* Up to here was in memory cycles so divide by 2 */
-		      caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
-		      caltim4_cfg_pch_to_valid);
+			ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
+			(ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
+			/* Up to here was in memory cycles so divide by 2 */
+			caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
+			caltim4_cfg_pch_to_valid);
 
 	writel(((caltim0_cfg_act_to_act <<
 			ALT_NOC_MPU_DDR_T_SCHED_DDRTIMING_ACTTOACT_LSB) |
@@ -413,23 +413,23 @@ static void sdram_mmr_init(void)
 	/* Enable or disable the SDRAM ECC */
 	if (ctrlcfg1 & IO48_MMR_CTRLCFG1_CTRL_ENABLE_ECC) {
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	} else {
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	}
 }
 
@@ -642,8 +642,8 @@ static int of_sdram_firewall_setup(const void *blob)
 		}
 
 		writel((start_end[0] & ALT_NOC_FW_DDR_ADDR_MASK) |
-		       (start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
-		       firewall_table[i].cfg_addr);
+			(start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
+			firewall_table[i].cfg_addr);
 		setbits_le32(firewall_table[i].en_addr,
 			     firewall_table[i].en_bit);
 	}
-- 
2.35.3

