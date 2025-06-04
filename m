Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C0C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC97828BC;
	Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dnmtvXZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37653803DF; Wed,  4 Jun 2025 21:56:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD0E800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpzGazrpYWDANMpG39Z8/h1tQyRlJ1aVL8c22v0ihsHgpS9vjxscb8cD5960XY7/P2nnBLZYJtSpcv7aH1J7dDFn0QC1OAnupLjmqeEIW7IJgaf310qllpBv+Hyqk+vUQXykqG3Wj208WDnMmNYtOG+QMQ9HYNgC+WRFFdTqFHYxUJTSgnhnNkbA6I2FT2UKaU6W0AsSrqDlzr2JH9OFi8SgYwLbzxnbFSKp4L762tV+iG3y5nuvwwS/IMMmcmjHdD988GThh9E3Ojg8k5HQ5v8SPaTKZ8jyQdnoXqkwFYKdsv8TniBKVODQFMOZuRcD52Y4FjgamOGwP6PMs14Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYEKfK9C6JUQQs9g8sIIuSd6e9RW4E6fIdNQ2eBxt5o=;
 b=ulH3eVN5WQW4hWlGjKTBaor6dCTRel2BhYoSXRpATsWnny9/wqDJqljxFhis/JGCLMlqA58yyuq1kQX7hr9vpgeghDqlkPH25jjcJW26whBUgwmLBZ/TO0skrvf80DMVVrT659ajlYGBb5btf+dGRWqu69xWiqtlgueF0yib/eX2enwsBTn5Uda+7bBrGVJoPX8nJ1Ux2GKyw3BT+/VffXRL1GAbU+5PxTP5+BHZr5+UL/7/EqdSQj8tz5Lr76t29nGbjcJHdVtEV+4eNY/ShaHhaGLGdn78YkzAMduJLoaAG3hiAkIyNFAlfDWYSh703aA3YC/LifQmzuXstyBAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYEKfK9C6JUQQs9g8sIIuSd6e9RW4E6fIdNQ2eBxt5o=;
 b=dnmtvXZiiPGHRtAhg/Fm9BnrcDDuCci26pdpxzPlGYViCOK40F0z//fYj4vV17aW6W91zkSaNjTe5ltHsz3MQ196FdLuKkZBWo4HgQpWBWSpnB+tRTSW5hP95CdXH59FYKPIf3/cuoLhU8UGral/iUrmsSbbR6KK2CplHnyeL2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:15 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 00/12] drop volatile from global data
Date: Wed,  4 Jun 2025 21:56:00 +0200
Message-ID: <20250604195612.2312979-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c1a21d-508f-46ee-ca9f-08dda3a1dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y5t5LGy4FCzTbeQhQYojZKb/GUquoA77jSx+MgZpFZRGn9w3O7bCc9OLll3o?=
 =?us-ascii?Q?Xi198dCE4orMjt5BNZKXy8qEDPDtv1nEP8GBKKCcNoKRjsjnFJiuO8KCabwv?=
 =?us-ascii?Q?I7IyKMmoM1XNn9CrJmWz6SXu5wiphXv2S8RLcxDapV/zoqaET8VceQXPqcPn?=
 =?us-ascii?Q?hcxQHdp5Lh9+mwxvnZ46oI5ss3WaVmwZMv7h6mR6LsgSycpQqgxt70nqwaNP?=
 =?us-ascii?Q?7OpZrd0+AcMlI15uapyRhy3SX7saqT6mqmpzljlLjksOm5dp9mJ0tq/f2l18?=
 =?us-ascii?Q?Po5V0nPphVW4dlzT/7KER0zvom/bsoWam5W8d/Y/uGZr9B8zc8p6sWE8B7La?=
 =?us-ascii?Q?Ce9lL7+6YHH1Meeb9lvymeHA/Wt+mCWN15kUGtpm/xjbbikmCnsaN+qT1ibJ?=
 =?us-ascii?Q?oK7pHFjQFdswdYADAxqc6jM+XxoudS2cyfRSAamrueyIwbp4PeYceUhJe5h/?=
 =?us-ascii?Q?jYgg/YI4SIMzNwG147eVvj81oyyeIuYY3Rqqo86fQ8o0lyM95FAdmfDiZHwI?=
 =?us-ascii?Q?IKefEclaAlt4M7HYzT6tk4qed3QLZleqkzNFBzAmNyZ7NX+N4m8U7JN+6+WO?=
 =?us-ascii?Q?ekyBX8rv2qkmxFdYOF1AThaN8IhDtKXjjLaWBnEVjaRcAkS17VAu3Mu6kPih?=
 =?us-ascii?Q?q03ECbaJNiC+8LIyIN98VducyZb5Iw5GkRAzUBarfuKe1WikGyacoSrfiPF7?=
 =?us-ascii?Q?2QF1PN83dtDo88nIPNsYJ5jktIxPbl3jdVQwaTVcXGdYOZOViWUD6Z+tfzAT?=
 =?us-ascii?Q?sZabDeSBSr/U8Q3y2htZ/kU0jQcH96vbnj74nRCr5j/bepDH0rWMgF/7Fw8Q?=
 =?us-ascii?Q?Hlr/V95t7mHegQwQ2MUEcUcL7QIyLznOmCZ0tz+AN+hV2AGaT9ROUhMrO1Od?=
 =?us-ascii?Q?423bwPszGh95TfmxscWlcEckp/LpS9rmz6/hBUVKWRSqhs2wuzf2nC+vkCBz?=
 =?us-ascii?Q?3tKCOTZ5EsvUJcGp3dvo5KQhVcUrsan93Zt+3a8BHnQlvHzwdEoxv5HIpL4p?=
 =?us-ascii?Q?gujqvW6Tl5C796Yg0RGwo2Nmn7t4g19aXlNJx6N31rtUvnH+YSggL56aXREL?=
 =?us-ascii?Q?AqbfR6+1+y9Md31q7tgn9JfOiFtWvC3hyP+VJiZmZJfmhmClBx01BdkFSKn5?=
 =?us-ascii?Q?1vXEyZ8rwkXlNv/hY0eQtDKkuDWNKc6N8KqsOTsHvuSrM/qn/WVOX2bW6YUo?=
 =?us-ascii?Q?GlPWJEOqITOHmDwGvTiO3M3xakxzLBXW+7OmG3Gf9r4OnrdhsVgsYsFHyXWO?=
 =?us-ascii?Q?aI+Stesp6BAdwK0Bq030jTXLh/8flrWWT0fLIS+lacPpBewCjeck3sdcCjWW?=
 =?us-ascii?Q?hmxSVd7ULwIVtO+UUHa777w2dUH336A46uMrv7b+rf7Y/8dieK/2W77GoFIj?=
 =?us-ascii?Q?Yzppf+XDCsskyIFDLZtJR3l5G+aeG73KfteLstHL392vB6El6ogUXmhMyv8l?=
 =?us-ascii?Q?LnXYIs8gMjp7urxlxITQIFfaK32sONFJHrhQrk18mjYHAD8K2p6DnBeOr2c/?=
 =?us-ascii?Q?n4ztuxNXDN0dHbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwJxEvbBNzmPFc9GzGx+ZOm29+f7/druFM+TS4LXf1GAYTHXqhJp3gMqJ3Nj?=
 =?us-ascii?Q?XvIGQTmdM/XSsh00odAQmw/11/6w/q0ICNctLE4vTaqhgt5ua9rFaaaAG2o/?=
 =?us-ascii?Q?0rZDHI3CJCgA8GOd3bQ/3cc+Tend49VjOyfSotgOmzOQ3Gtlvpgk6T9dHmyb?=
 =?us-ascii?Q?912odkJbNfKgHw+TwUyG7BCFf+TsFu4els1R0jG7jXSJFERiTB6np6ghdzDK?=
 =?us-ascii?Q?TUj/+N/98JDQFz7SPjsE6C8sMSem/0w5vMfuSR6P0uvgtAIuCU4FkWwM0YBl?=
 =?us-ascii?Q?fX0uX/OLLbdm5vGQHPaff4JLdUsw+UQlzEaTYcU3L1Ksv9V9HLWWDfRnWvoo?=
 =?us-ascii?Q?/Itg6EJbnNJLPEgawipoz87MfRqttGxE09gmOihtxvBnaizvJXXHD5dbRFc9?=
 =?us-ascii?Q?HbjWvOAO9WAx02uhTAExsALXjA5Y+yUJPqW+vUzhwIHALvOF76wOnTFKbd96?=
 =?us-ascii?Q?eqiOUa+RBa8kFYkun+G6U+V5jw7UJL2v24bI0Lvz/5qYm3pNLMci9gQVRFPO?=
 =?us-ascii?Q?oLxKcMwl3w/e/kBlCybgjkhzIgnmKGxgUCVDP1edTUw0HD8M1KfQy6TkoI2h?=
 =?us-ascii?Q?rtGzfhdKzsJtve7o8LELIdN4E7FoCUAF+Jn6Bqt0XmMC67N+rHehfJvrH7mr?=
 =?us-ascii?Q?uOIYAIbZSaIjGHlciOmIDUlM3Vv7LfSbyQuPQtnzb49243yLu++agB/TmkFb?=
 =?us-ascii?Q?T1uROaK4bzwq+Fz7lNCj3e+W74/YFO7oKEPYbt7LBAZi+6Uoepzs4uT314tl?=
 =?us-ascii?Q?CehucCUohgpMqyXKRmdGxDPGofjyFKB2UhisUaXcLbrKhavbUWyd3SgK+xch?=
 =?us-ascii?Q?6qVBMunOpBfDKpDsXysHIYYsbBYSW1sA5KNkOWSTJKZhUpz2XYET2OD2hAtV?=
 =?us-ascii?Q?NvqW5JhMP9Z1qkddS0Jdq4yAtjUOZvmu0FGZKSEO0bBID4O6BZ/9OWz2ACF6?=
 =?us-ascii?Q?W7be0w9aiZEq2ekP8Qu+qLUwLVSE5ABSdSvpiCAojklMTHR5cyXrMSTJGBvY?=
 =?us-ascii?Q?q3MHn6WujgQUfSYwUdLJwQSZaT+GG2Ca0yqLPLrnzqb3pRwhcZ93ZQDPVtnr?=
 =?us-ascii?Q?kyE9mor1ah8Oi9dtIDudpdg0WmhHOgzIX4IdPtsvdpOXdQqzyKJIAEAli4Lw?=
 =?us-ascii?Q?xFJxzyqQDARnJ+AOix4ue8KYpIs4ri8449o8id/q3YGAxhGLGZ+G6FsVPU4g?=
 =?us-ascii?Q?MgzCIPJzmROr5c4mOpLXiGT2mT+MZy8roRGak3ZSpi7Ba2YlfAzYxwGdmE2G?=
 =?us-ascii?Q?6K5SWxYqPUQwUjfJlduCaKisQB+MbZPVyHTTBGMPh15XAFB0oLyqcC1ifZ9z?=
 =?us-ascii?Q?rO4bxKOPWMPdDzgaL1MxG4td9S4yd4e3CcFB+z9+J1FSO4TOK2wYBbUpqz9I?=
 =?us-ascii?Q?WO9gyfoGg00EXV149iRRVvjWeMfhOTU7c+XiSMBF7xT5Cdy+3JCIk/3SVtJw?=
 =?us-ascii?Q?RUGnlo3H1n2WtnuMlO2I6dWLhHgDLOcWd6r/Kd8dS5jCi0rQo7oIT05SmLMU?=
 =?us-ascii?Q?AdpHZLMYDJscYg24UrGLhno+lQrhYEtqNG0fH+9wULoNi+kRNy+0N3wQ00jj?=
 =?us-ascii?Q?nzUGtqi5siLsVuO9fmFsTHtnHvY9y6PM7sJNza5fq+BmnuExhJOvmc7HltHq?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1a21d-508f-46ee-ca9f-08dda3a1dcfc
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:15.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO+vv5oJwPdk5gr9Od/4tH2gHbiI8Dym9/l8j19X3BZZnFbutSn9zBhiRwoE3ko0X2jPUdnZOa80/PsjRVu77+2ZdqZtXee+hyVqTABsk6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

There's really no reason for the gd pointer to have the volatile
qualifier.

In fact, I claim that it's completely unnecessary and just pessimizes
code generation and forces ugly casts in lots of places. For example,
see the casts in drivers/core/tag.c where elements are added to
gd->dm_taglist, or a helper such as cyclic_get_list() that should not
be needed.

Also, it is what ends up standing in the way of an otherwise
innocent code cleanup of list.h:
https://lore.kernel.org/u-boot/20250522165656.GB2179216@bill-the-cat/

Note that riscv, x86 as well as arm64 with LTO enabled has not had
this volatile qualifier, so it's unlikely there's any generic code
that depends on it.

CI seems mostly happy:

  https://github.com/u-boot/u-boot/pull/775/checks?check_run_id=43463083829

The one failing test seems to be an infrastructure thing unrelated to
these patches ("docker: filesystem layer verification failed for
digest
sha256:379cc6cd06dc3fc80e31d5170204c0cfcc25cb3b3ad457ced23bed2b38ec9f36")


Rasmus Villemoes (12):
  arm: drop volatile qualifier from gd pointer
  powerpc: drop volatile qualifier from gd pointer
  mips: drop volatile qualifier from gd pointer
  microblaze: drop volatile qualifier from gd pointer
  m68k: drop volatile qualifier from gd pointer
  m68k: drop pointless #if 0 block
  arc: drop volatile qualifier from gd pointer
  arm: imx: remove unnecessary volatile qualifiers from "save gd"
    variables
  efi: drop volatile qualifier from "save gd" variables
  lib/trace: drop volatile qualifier from "save gd" variables
  arm: remove volatile from set_gd prototype
  riscv: remove volatile from set_gd prototype

 arch/arc/include/asm/global_data.h        | 2 +-
 arch/arm/include/asm/global_data.h        | 6 +++---
 arch/arm/mach-imx/hab.c                   | 2 +-
 arch/arm/mach-imx/imx9/scmi/soc.c         | 4 ++--
 arch/arm/mach-imx/romapi.c                | 6 +++---
 arch/m68k/include/asm/global_data.h       | 7 +------
 arch/microblaze/include/asm/global_data.h | 2 +-
 arch/mips/include/asm/global_data.h       | 2 +-
 arch/powerpc/include/asm/global_data.h    | 2 +-
 arch/riscv/include/asm/global_data.h      | 2 +-
 lib/efi_loader/efi_boottime.c             | 2 +-
 lib/trace.c                               | 4 ++--
 12 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.49.0

