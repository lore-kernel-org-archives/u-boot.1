Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845BDCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E50983A5D;
	Wed,  8 Oct 2025 09:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jk+IWlXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B98839A7; Wed,  8 Oct 2025 09:09:19 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF405839A7
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIEw8yYCDQ2gDaG9EQXZznQ7pjCYRFxqE7zpFLUo62lZRZ4Mulh0V2yLv9f4IbZcNmJgtF/aj9j66wUsCCN691HqjRxFsyc8rEeIe6u6E5wJyzNRznkbTJgOauj9tGUTFg8U+DtBntHeSXqMMD4YOuftY+ef1lA+Zo1lM57OHDhaj4wbzk9AyNfBpm8rbUo4Pv+giEACHn10XvGahdi/Hqwd8KJR6GAcFNMQ+pjVJ/WM1hCx42Ps2K9LSz+HsCm1QBjXB38kksFDgkVRt9e5h4DYlEo3Kga/nk2Md3aJ1+2TzhIcN4MokCaxKHAb6cbczjt96W6sbxBrXwjIHCnb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltX6/euev1zwjfN7IF3s7H9dKhXfifCa4REK3olovDc=;
 b=IG84LIOWKWAdUWPHpzsdeSYI1DmXi76GpljyyFOPpHNdPraYt7TGoRazbhtQUxo6yPxv52ogQi/nuxUkrq3Rg0pzuG6Hb1xIAJnPuOQ4SJZ/fD+v5cUT1b704lQWxY71XF2CaSIPQQ+cp3l8EewrthxSrF4PL3iYgwhrwklV2lORl4Qr3jUqiUj7VGPu+sm1YXAX4UpcVe5uTiZgyL03QwkN1AKGnYLEHPECoRiWzdQrnmIZ/0aNTZ5F1pmxJEJPf7S9HAUDpTokCsuKo1yl0P1ufsayI0EBTte8OXmgUQ11AGv89sixS44kU/MJoMkHl/Vi7Inm4SbMY2EHr2LAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltX6/euev1zwjfN7IF3s7H9dKhXfifCa4REK3olovDc=;
 b=jk+IWlXkGQI+S6/oBSUGwPlVI/2ixxgK+fA/6WzUGte72+GcLiuqWRIEFh56O8MO5nwStUcCvUs212pR+aiFqI5gU+JgzFX0skrtA3Dn8F0P2JZ7tWWucLNcreO3V1BlajJe4+GtcR2R5viDJM+IMLtHNc4VwH+aiQ2DYHTtP9BnjOL14aPxmiueGu31JK/reGWqzmhMnHo+Hxpeiy4l6sxGAWMTmcJStXQDxnQxPeJqoKVgMgSrxhTpuCYABBL57q2o4BlBZqXFnhU7IMf6hjATE/Q8kA2MEPVuUushNZ3VIyPl1bRiYBc+cOODkNnjMV20mAzb9s9UaA4Ln75LIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7638.eurprd08.prod.outlook.com (2603:10a6:10:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:09:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:09:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 2/2] arm/airoha: partly revert support of multiple RAM size
 for an7581
Date: Wed,  8 Oct 2025 10:09:03 +0300
Message-ID: <20251008070903.370974-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2583f684-e45b-4cdb-2529-08de0639966d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ufoM7wj8uprRVkSKqIgouJla+Ub6uvXNKiCPJEQklnKDUSUx+P/nRpJUWJ/8?=
 =?us-ascii?Q?3h9biWNzO0+U4FmUK4PIOPy7RQCo3NLAhCPQWd1INF5iY9CkAh7V1owKKzV2?=
 =?us-ascii?Q?0plgUH0wTMbgdv8Sl5yER/O07U786qTJLXPs6Zu68sxUudVr7i43RLZRr2li?=
 =?us-ascii?Q?MyE2EF4f9q6XYkgOih+wJfYEZyZ4OYBX/eZjyqImJs+eWLoO28KSAvR+r59g?=
 =?us-ascii?Q?lIAU0Wb+2HpPqNvlAAdSFo0NAqvGl+O9DFw+DXvxtgAmeXdoQLqKKUn7wehm?=
 =?us-ascii?Q?hJ2Y68ZvgMs4vWoWK8IcIDp95h5x4/M1369R0CQ3Mfv91BsZZhP0yPOFudP7?=
 =?us-ascii?Q?HeTo7UpayAXgTDBrOVX6tLlHjBjyXOSisuw9OEZOuZhJRu3uQEUDlQfkOPVk?=
 =?us-ascii?Q?5d57TtByfTPD/5etDAbuRDR5/QixNy8l3CbKz1xSV1S7hSSO4X+W5gCdub8m?=
 =?us-ascii?Q?eX8iDFrNrs/ChQpAWpKgdD2y1vRTokAVLdMIP4dfXUxce+It5ge6NfTS/Na/?=
 =?us-ascii?Q?1YU+e24raNSy6GOR98fgr8iFy9lHB++mvcjHFqq6WJIi0yXQJxF+aIQzCutt?=
 =?us-ascii?Q?Eu80GVHaIKhvs0Q2X+dkiijraJB4LoSP0UsYMBvh1QeCDNDBMBhv4tjulSlv?=
 =?us-ascii?Q?OU6J+IDlFf5wKrUeuzQinMBZ4d5RwHqegYFtgSmnjqQjrhTlm5DcQJ73izeX?=
 =?us-ascii?Q?GyhckUWu5gxzdvAFnrbgecaVzQMFwOkW0LZjzb2Zhv0WL6V54XQWm65YgHx5?=
 =?us-ascii?Q?CSdP0UgmzIP7j76L+jwwfHwQOw3lfp01+UfO5nqikkHppyHfD2xGuodMYaD0?=
 =?us-ascii?Q?zWhRng007jQqovN7Q2OqMYFTs1D+uR+DFbCnhetHuIKX2UP0lS+0etL88ge4?=
 =?us-ascii?Q?wpHz7Xoa+lwMW0jds1pkbgh8YupbERJv91SmBec21YDvdKMknykeRH40Fy0+?=
 =?us-ascii?Q?Pdrjo2wewMEBq77Md9GG35fAucjF2FynwSsxuR37cdUwCS1cmJ6+lMVn41qK?=
 =?us-ascii?Q?D5X7ibuCWiDXkh/rgMdFd3Ch9tJjLHEY2rRnai7yPFRQ6aSO3FzhGGAittMQ?=
 =?us-ascii?Q?ZiyeptnFOS3kQyHzuq0tpAIv+5vUC16bTC07qdzV1S3ZKJ76ZicKl/JSPIzU?=
 =?us-ascii?Q?anFewGcmKfuk/KaA2xMMOxVrvaPKg47MthQbLWKyGz9weZnaY49cW3BPmL1c?=
 =?us-ascii?Q?dPL4c7rOQSFEb24WEoo2OAyVfzroVRZr0kD8DUvQXgkAbHXDyZTuhk3MPLFk?=
 =?us-ascii?Q?mzCb3lcigOr5eL61Una68Zbk8g4SUTU8PPwM2KMhrQqWyJCWcVKCmnnbMaTl?=
 =?us-ascii?Q?EAhrvapyeaOTnaDRNZ+Y4SY0cBw0DUSdTFomdAsIit/Piy7h93m3NRKr1LN4?=
 =?us-ascii?Q?Cy/SCovkIPZWjTQihWArBKTIEfFMa3OcYJHAmzYeAKrM2t9Su7kBo72gRZSd?=
 =?us-ascii?Q?nXe6ZGwBa+vqeqws+Njgpdi1FhrQtOMi6hal7C/8BVyYz21Bsa7kSyzN3xwa?=
 =?us-ascii?Q?9/UazICH6m1lQY3sfbL3l9hoMJZFWl4K/LQZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RH0vgdLLZoTB+ddm3QC1M+F+M5wO99GC6f5Ln2VQHtrN0Ow+QW/1i313rrsW?=
 =?us-ascii?Q?ALA1gEPNpTq+FV6cr4sgkjKjGCpuCDQyokBi7emPYZF7rM80J12nritj/Dt+?=
 =?us-ascii?Q?zIIvpQp+jQ/z6rO3kbuQUwSLl+evM8XbNXZS2kcB02BmLXXuKmXfyRDFaqWO?=
 =?us-ascii?Q?BGS5aiwdDrqI671CCb1mPUkb/DX5+2Pmi2WTsfxM2tlZ8wGRyK/P/5MrF+b0?=
 =?us-ascii?Q?il2ruLEsGg/FBaQGDL7IugR7YIktoPhFI4SxS3hJyZ7lVKMpxSFSujjzQmt8?=
 =?us-ascii?Q?1fU7qAlXBRgJc4JDkxulFet1BpG5SfZlaUOGDBCwtkdT2ghgZP1r4u1uWCXN?=
 =?us-ascii?Q?6wiRcBr/DnTK6FWZNTyqPJ5zrSaOcNQTBbkoyJVKPpYML8gJQ0egExS0T3pB?=
 =?us-ascii?Q?kJkEPw44EgG9q4wsqNf3UGbfswna2+p7KnxtV83P7WyQOFfCIWsOE5Lqf+mY?=
 =?us-ascii?Q?6puU5mVkz0Oa7nbRXp4U/81d0TMrA3LVJ8MEqAz3QRUujavOABkjIVbyk7C4?=
 =?us-ascii?Q?8JrSm0rPNObBr4DbnJ4H6bQLce2i2Ofcttrm5ymYsH6b7gqy2Il2rDMTcvEa?=
 =?us-ascii?Q?3saYpjNN7Baq4SIXD9SaxEBKNoI3AqrGkTIosONBjzsL4I7YER4KDBqTUq/U?=
 =?us-ascii?Q?g0MG11fud64Uhh/UcTZuotuicoxdpHB1Loa/lRyFwALqZSRGmEF4XqHsGYwO?=
 =?us-ascii?Q?24qaz3Cfy5iIaLV8fPq0MwTnXQpGvaJHvSU6KXszqNr27NrKy8u7ZhJw0ezS?=
 =?us-ascii?Q?O8aEqvOBNWYc02zByrWsurjb/9hdpvmBnZMTIRKPTgOvjFCdmF6tMmXJsS46?=
 =?us-ascii?Q?fPKyG8HjafQQjQrDG/LLdwcXYF3q/cnZn6raNZx3vmgmrbxbvec6FN6+erlp?=
 =?us-ascii?Q?1RBFo+W7tE2F6AvowH9PvHlXd+OisbeVypFxITAuy1gnlY9YFJSfJ4SQH3gO?=
 =?us-ascii?Q?g/TtrhgVj9Kf5XITl0WJN85Fn5eFgTsoEWXnBgI6pgXi/KbnHlDBjlDqHmjx?=
 =?us-ascii?Q?g3GSYQ/9PO7gO7oE72dzz5O7kCsoNUcSZKWo55Dy/Agdkf6e3ltTUXWu/HJj?=
 =?us-ascii?Q?+6YQDw0XKHfujImFNl/NmY5vge4E9pzZgQT+YLMJuWChI3oB6wyDyv24YK2V?=
 =?us-ascii?Q?UHsYSXTvjQ5mHQw7R2y5DXfKxQWQNPhYCZpCK9UDffbvHAxF0XlBN51KOCGZ?=
 =?us-ascii?Q?8tbCHlbQWSsue20nj6I4uyLDaDYqRoujQ6hj8SN7ME2pZeJ2Hs459K4PNIkY?=
 =?us-ascii?Q?Q9AhXPV0EBbieoQnYn+1ckDJydIW7EqGwy+QwxEN6bvV1LUk+BoGOJxYQspP?=
 =?us-ascii?Q?ZGpwjA63ehT5lKfanM3ecbKG/gWfnK/yY74qAfnXtrHI3cDneLa5pbmuDqOZ?=
 =?us-ascii?Q?6Kal++njI+KUI6wOI4iazTfykp/wxCEi+jOM/C9YpJVjwI5h6CU3nxhd1gHU?=
 =?us-ascii?Q?J1A8DQ/f4TgTmGKKKvirqiC7ygOjTrbqNZBi890TcWe3CnMASOh4eTGg/TA2?=
 =?us-ascii?Q?Y40x40+eM3hxBWhsqdPVLDg4wG1TRe7b6lO4YqqI3MTltNbvpFDPAJiCvMP9?=
 =?us-ascii?Q?9/kJLKGgbhCRYSypWSbe1eaZosyriVrIrhAG/dsIbATLsFJa1pHan96IHmP+?=
 =?us-ascii?Q?YP8/E8VuzNUAi0qHOQyvWvs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2583f684-e45b-4cdb-2529-08de0639966d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:09:14.3054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbAdCvsSOo8QQ/Z13TYHW22ivD2XTcl7ViC2j7EinY5pI8J6saqcnT5fWvNzZ6CBrANqjuUcM03WlUx7x+EMtRYNnv6PsV4vpcBX++GJxHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7638
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

Partly revert commit 726404a66c773 ("airoha: rework RAM size handling
to support multiple RAM size").

The general idea is good, but the call of

  get_ram_size((void *)gd->ram_base, SZ_8G);

produces the following result on my an7581 board with only 1Gb of
memory:

  "Synchronous Abort" handler, esr 0x96000004
  elr: 0000000081e201c8 lr : 0000000081e20160 (reloc)
  elr: 00000000bff501c8 lr : 00000000bff50160
  x0 : 0000000180000000 x1 : 0000000100000000
  x2 : 000000000000002e x3 : 0000000000000002
  x4 : 000000001fbf0000 x5 : 0060000000000401
  x6 : 0000000000000000 x7 : 00000000bffdb268
  x8 : 0000000000000060 x9 : 00000000bffdb2c8
  x10: 0000000000000000 x11: 0000000000000060
  x12: 00000000bffdb268 x13: 00000000841c56d0
  x14: 00000000841c56d0 x15: 0000000000000000
  x16: 00000000841506e4 x17: dd7fe29aec3b07e8
  x18: 00000000bf710e00 x19: 0000000080000000
  x20: 0000000000000000 x21: 0000000020000000
  x22: 0000000200000000 x23: 0000000000000001
  x24: 0000000040000000 x25: 00000000bf708e78
  x26: 00000000bf7bdca0 x27: 0000000000000000
  x28: 0000000000000000 x29: 00000000bf708e20

  Code: 910943ff d65f03c0 d37df2a1 8b150e60 (f8616a62)
  Resetting CPU ...

So just not call get_ram_size() and use the value from dtb.

Fixes: 726404a66c773 ("airoha: rework RAM size handling to support multiple RAM size")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/mach-airoha/an7581/init.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index be0ccadf7da..ab32706a79d 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -18,15 +18,7 @@ int print_cpuinfo(void)
 
 int dram_init(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_mem_size_base();
-	if (ret)
-		return ret;
-
-	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
-
-	return 0;
+	return fdtdec_setup_mem_size_base();
 }
 
 int dram_init_banksize(void)
-- 
2.51.0

