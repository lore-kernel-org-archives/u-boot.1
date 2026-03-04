Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1098BEDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDFC83F7F;
	Wed,  4 Mar 2026 05:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cMQtQb2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8255983F61; Wed,  4 Mar 2026 04:37:54 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8188483E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXo0whHv0/F8u+uhSnQjNh6d48+vorjXMehfv8wM5j4TA96CTpL1lKLvamq6bdl/ekd4UELvRXWr/bU5PU95NmYi18HKJN0S601N0e0uBCbn+WECHCnOZrLv7uGv4lzDBkVlFXgfqYwu4pR2tgAZtpmbWqNyFH+Xaw2X2HCGBHYW4R5x8ExoB4h4qUhCQzhLx7770LUSc+KRH+kD8VVpppSj+rEdySiPEisfnyKymuNgR8FDK7DTCjcbsmnmiDVWcgFpvzHfXmXzUFDFz8fpeWSWBMd/0WpoG1T5L8pgivzbdkO3pf1VAZyPX3t9nvH71eg58wh/h9KQpLh+JKD9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs4aT2v8CAAxOvp5M4Z6FPtAM7RNaf15WLpAETNbXWc=;
 b=tyCHQUBbZesXcd3z3SBPFJV2yGFlqvsqGhYqZmGkXPaMnI6u+SF5E+ZTNpx7lKI5J64Yw8YuOdJp+266Qq/qQuieHWEmL9r9L6MGY7nItP+sOFs69Y1MMdq1lE+jfoSNu+hxU4MvNDU5bKMz9FP1fzFkphHwxZOk7cL12LFMiO1HPls6Bp1kBF7qnn3H/Xk0EHJrVaX2IYFRcwosYh2UfBmk2x4gTaud0MVvIHq6hZv+wqG8D0cvmYckzzh01BLYpf+ywa4zHrSbYbeNhaQ3sh5l4u3WGldwFzxMWF4qQW79uIKGWWEOTR0Gh2epP+LgrnYQZOnKqECRdlm0vqg/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs4aT2v8CAAxOvp5M4Z6FPtAM7RNaf15WLpAETNbXWc=;
 b=cMQtQb2XdNlHyIdoBRXPYKrkUcYLhJ7W424esVPlzKkxE1jeBblSmvMXLkPJciZ4U5d/SSztMA1lvfQD9bJfOedhhGtsxpYxuTx5G60saTUI4lL5Zk7w1Ho1tjTEvLyhCc5c02UmAx1K7YSwLLNeSqBp+yEHvkRNHqRYOLlTe5yeH8C2In7XYfrLzMYO8QeSqvTxeFda51W0Q5a/dIgi3mCx8r4qO5B1WXgkzdyhTxN+7N1j5P4IE8GFd4ZbkS5eagFXfYie5+s+blJh30vT2ZJb5e4sJ8+Xu+w5rTM9OPCrCTlFjK4a6IKxclUYKyIoXqtNexS3TBj4kA+O9ObvRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6025.namprd03.prod.outlook.com (2603:10b6:408:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:37:49 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:37:49 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Add NAND register address and data register
Date: Wed,  4 Mar 2026 11:37:34 +0800
Message-ID: <20260304033734.28135-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf03088-7d70-4a3a-dec4-08de799f6866
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: IuImtR+gJgtjH3S8O8yC9xSuic+0NyxdpSm9ddBPfd58RD6Bq94z+efhpIEsf/cFDh14ccr9oLVBxb8bZ/z2Q26rSZtDLzaMvIA8Jx8x8yRJBlr/kbH9ap3VtJjPB/YUI3edcNfgq85VA7GoMjmA1AVU4Ys49PP6csMvVQyituu5+3ZrOucs2hCeCM/y0gDI7Kl12vbCCcmAq8tUWbH3ycNcIwkYT32e9p9n6sywED5KMxNovwF0w5d41bM02wFsTh/kkXYjAl4DFnRl9t03rrS4pHZ2jE91SYkJyK+YVAI8b0K0bjPfKJf9WJNrl6KNNuBngiBD7wjzwPnjbNHsJ+ABj//U/Knz1WOfST27l/8+4G4NEYUdCT7+esB+ODVRws4vPB5cHid58bPWwD/WNF6/+CtU2Yez3y5AVWu3W+yKckECKXFUh0K5mllQZIfMeoIJURuFfjOvMreq3VhU5KE/47/fO8pSJpP2kCP5aN4n6+AdP/N7dZYVAKFtnClZLbyDNvFnlCSBw4++gIm7LIwUh7MVgk2XWeUgrmMSX/yMmNAFziU3d4OF0Rjz8cH+9aU0FrBKmPfO8NidlwyrcwXepzYlZXdxUYS5iPEgFr0/UxRkO7fYLWRww5ONSl4jYk7oLB53b009ksIytTOS3eUQWDFhdOhI0VLc2Fvq+acLO6PSpauw3hZqYAcL9Zl46IkkRmvkeRT55w4SVAXuTJl+4YP72sFcEFWiu4SIeaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hgCFQ8SiqGJKc3YFAYKTd+6oNmW1pkTFyedPB4t8Y8r0+D0YTBNw5IWGFXka?=
 =?us-ascii?Q?zkpz1gaas2EqJ0eNc2kUE+ZRf6LamPXRR1m5Mn4TryGFJ/JuamYgakD2ma5u?=
 =?us-ascii?Q?0Z672o1eN7tJWWCiyR1K5Zp4/Q5hBRbYi7ntsSYbKS73eT0/XVDFIyNaGVxV?=
 =?us-ascii?Q?Kom/AFsEdDtrJ7CcFXNoW2vI0tLCgDeETH1Cix/vjwn3NnJV9vWIbr78Z6In?=
 =?us-ascii?Q?3LWZztNaI4OuCL4UyCw2L55VdtIfmAz00uQAly62iGrhFrw5a4inBn1iKnrI?=
 =?us-ascii?Q?zG4/4JK9eMe5FxIge2buiKEIDSqQe97oNm1ZNjQppK1n+Q4351EHR0MJjp3m?=
 =?us-ascii?Q?Ktg5uNQcKY0xKmUXXJLKqUjfYVSvPsy4vAmh+AICsfwZiufZw5faue7lEWxK?=
 =?us-ascii?Q?dmFIVxYh0rhs9It9X6ktjSi4oxdIrFaue0zS+2ZVHpGZOBxsRQzloJZmdLAQ?=
 =?us-ascii?Q?+kv365eb/hcUX9e3kajhnejf26PLXeuggku+xoITf80GcI/LuwhCIlZCWJQa?=
 =?us-ascii?Q?tfhfiesVUxfCz086pAr8bmaewZZ+Ndv5mW1l64JbS5d6DK19kvaB0zUJ/IZT?=
 =?us-ascii?Q?+Vbv6yteqFrh45rjZK9QzNtKFDHFTZTtQBafEKDGHy3P32ibONaVdxyeia8J?=
 =?us-ascii?Q?3TxN591MWNpxGtltVlcK2EUCs6Gpv0adjSPgvzhLtvQ5ECYyaBLZSpg64vAe?=
 =?us-ascii?Q?oS+zlbSCPPVwv8Pl2bhLC+Asp0OZtFy2gKxJLeXdW9jrCWwjUd1pFSaXfNhZ?=
 =?us-ascii?Q?BY7/CiEkUxS5oUs8Ja1DJochbeeufsa7pJowDCOtneluM/o412G65Eb9+rLf?=
 =?us-ascii?Q?YvGpn6csmvbnLqrdsLgJZ0Dy9bBFyM8/DChv0ZVHYGF7oXigazXZa6Jla/93?=
 =?us-ascii?Q?TGwuMYDgVadTyA5oTbw/03lC7lnauaFbw5noSDR0DnKPYWezv4f2HitbU7SD?=
 =?us-ascii?Q?+Y1DWQ1bYrkknp0ts8kKXLq5R7VUG94mF0aBxtrfM52BG5vhMOXCt0c9o0eQ?=
 =?us-ascii?Q?OzPfGEIZBqn7aA2cu5/ujStD/8+xL6du5spqZ2FiSs6Y/FVV7tEUYvrE4f6y?=
 =?us-ascii?Q?O11W2B/rmuXnILwKHopg7u4/2/37heHn63LhH0M4GuH43TyL7tfApD7/vy0k?=
 =?us-ascii?Q?sRSRkQyUL9gvAqGEhE0m2qNOcFDuYtPiRQknYFYOJQvA61pS/NTRvPyjbzZM?=
 =?us-ascii?Q?F4bDun1k1FOLjp9dm6i3nchf7mgTX9r/O749UvjhEXInQTZpwDMrNRboHNVM?=
 =?us-ascii?Q?mL3wwjr5TknKskxzvsNd05IDQInn8h0XqyF09ulVXpegSeElQfbj0rYeOYpK?=
 =?us-ascii?Q?wfEeGsNxUNv9tnI9zJH4VB8NaRxHcH4yUfMQ7FQnUd2OPGEy8JisS9Yn/I0g?=
 =?us-ascii?Q?cQNjP4pljUqFUIEKNlQW+kfny5RfE5RfXtBb2VjzEmkwc+ZNmnOJFDKH6MHD?=
 =?us-ascii?Q?LUEMHH/iy/Cz7iTDGzKIEblwiBU23IWa5rHrwTiLmFTlfDdv1cZR5ebPjIti?=
 =?us-ascii?Q?En7PNzorIVz3M/SmOlDTJeBrU1tnVaDbVptESVp6TGv+3Pr81cgktiwi2cUh?=
 =?us-ascii?Q?IasmxX7tHLE3+NqWPFgBTaA8V47AHg5lak9AP8tgZ740+YH1Hz3NMB8uJNhs?=
 =?us-ascii?Q?8340OJC4YHQJNSmbwW307d9oK/sqYdCUd2rMkDeVGggeyOrL7mxG4o81OWkw?=
 =?us-ascii?Q?k2zViDt8N4kPehi3nIj3gOy7iWlgcmhBZ+xzmGG/Cvoi6Ub5yWVn0ZuRP5oU?=
 =?us-ascii?Q?MaXuidKFrqiliePG+UgQL95EdgWRsPI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf03088-7d70-4a3a-dec4-08de799f6866
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:37:49.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B31SsaeDf1invE+jwBWrGhd9WTy0stLmzc/5swB6eX7tcijVBHzS/6s+fct9CP84jXxEJCfpokR5TZbvUAPrtsUVholbxQRkNcxekHtTgdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6025
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

These are required by denali_spl.c for Arria10. Pre-set nand base and
data address will be used for spl nand read and write.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/include/mach/base_addr_a10.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_a10.h b/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
index b947cc07291..120cbfa23a5 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_a10.h
@@ -12,6 +12,8 @@
 #define SOCFPGA_SDMMC_ADDRESS			0xff808000
 #define SOCFPGA_QSPIREGS_ADDRESS		0xff809000
 #define SOCFPGA_QSPIDATA_ADDRESS		0xffa00000
+#define SOCFPGA_NANDREGS_ADDRESS		0xffb80000
+#define SOCFPGA_NANDDATA_ADDRESS		0xffb90000
 #define SOCFPGA_UART1_ADDRESS			0xffc02100
 #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xffcfa000
 #define SOCFPGA_FPGAMGRDATA_ADDRESS		0xffcfe400
-- 
2.43.7

