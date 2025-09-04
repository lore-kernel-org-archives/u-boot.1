Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93979CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 14:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E8883807;
	Thu,  4 Sep 2025 16:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BL00NVVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860B683B83; Thu,  4 Sep 2025 16:32:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FEAD837B9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 16:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqdjqADjyAwrV48uOBjNuDn1SUUoeGVtYMs3Zz8/d7iLzSobgfvcC9Mu0/jPHx6uw+E+HyEGhvqkf0fA0Lz56hHgzaHp8qMNSD/ytboK7LDHkyD7DCfE95H3P83//N3t7TUVn85rE4E/c1E2/c5xby8nq2TCiau2hRgGo4P2/W7LOQqzj1S9D1XdV6S69cWPXizmEDsRgZHxob7yGPvVj//SaMc6kZew7YTWyVMFE6aHmixVto4Khigp7qP+Zk4OjvMe4CQNemOt+sPjTXAdnKN6yb3OVAEumO5CKqIcFEUE8toOhX9WOgd1+okfOftw4PXSICM7dRY9IUJkae/S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXO+002rLCEbVTU1e1eesPtLHfK0QfIL/IQ7x1kv+50=;
 b=VfB0TLKwGPtAbR1yo/qy77XuCPO3Vdl4PEdkJO26cH5jixBw1qKmpwrP6+wULN30x/pzQjZ3m4Hz4CaDv83fmejsjYNLPQ5XjBa8bOP0hZcdyK61/H0EoK2yPITGTy0eNe/mVnYeK8+MaeXk8XvTGBqRmYj3RpePKyY0e87d5+krOJH1+A35B2GM6gN2nfn1w1Df7nL+NHJyDksvexD+BpoWNnAHfQLcyF6Koxd8/RGB0LPPla9Qg4RCggOD5zJKNDSR0BaHwUAHjYg7OceAKIvcX4CsZN/WZXNpgT7u5JO6nuIjbwZnQA5baozvW0HN05fp0/qrRLO6beyL7fqQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXO+002rLCEbVTU1e1eesPtLHfK0QfIL/IQ7x1kv+50=;
 b=BL00NVVOpjR7Pq2WseeLkSLzWKEXvdmZTrc7nu8DcWdmFV9AmtNuZ4bZ0TDXKRMq3fKOoM8AcMuu6KwZNz83Y15HfdeEIkkmO+st7awFAyz8PErkKzLmHqvlnILniRNjHb2wQ3Qc3XVXpgz4e536ZoBrCh084JLQWBitud9vF4r9w0Lf5Mmuy+gPVY18KJHgmLvx6f0IzXo8TkckgWwcDCOYwVMcCDulUH4HzeWwtSFsLJDAsyHwnROmB6lkiL+EcMGUyB6W6jWN620TeT34lhdONApLoIChlkJtsCETmBcoOPAje+tw9sKIIcqtzXThft3fyuoteMIryrYBddCeag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9231.eurprd08.prod.outlook.com (2603:10a6:150:d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:32:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:32:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 0/2] cmd: mtd: fix benchmarking
Date: Thu,  4 Sep 2025 17:32:22 +0300
Message-ID: <20250904143224.657971-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: ade2b8f9-63a0-4020-4eda-08ddebbfe15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8aQDnkamXfo65lR/t/cAh50k64XkiVJh2vt34u8TCrW+Y8c7M5fpd3SSdgR?=
 =?us-ascii?Q?tx1ZaG44laVV0hhkMdnS2mZWD3kvppUMUuUnBVMrRsyZYCPkePwy952FeJwc?=
 =?us-ascii?Q?L5AYu0chVYrMOgUJSTwop/avGiV67k9jUAZLLKnW/P0Wm0bgJkZaTM0MO7EZ?=
 =?us-ascii?Q?rSM90DS2f0JAPyNeaRNmfQ/hjlfdAblGPng8SRiXXjNroIHypI/0NvncZvup?=
 =?us-ascii?Q?htCPlRyHVxrZSs0qXcSy+OQK5IRxrzrlSvwA4Yh02Sh9YkIjdp3AAPeLzION?=
 =?us-ascii?Q?8t4o1FtKgr8Ng69VvsBIJqG9Yt6nfozFVe/1DirRFdSoDTdj1XRRePEwqOHX?=
 =?us-ascii?Q?TN+Xkx7rSI5L2GGcOJ0y4xoPKoDGpIZuGTpvEg8H2eWDFKc66drBv2jDJnvm?=
 =?us-ascii?Q?AiH4YA1/UYeGpMJ/FcqDI5p7Q82bcM/gazRrafy51NLgbU5l2KwKq3qxMUY+?=
 =?us-ascii?Q?H3VV3+U8pBiScLm/joJNgHWReFfDQRq6+NOVM+3keiiVPUXi6tIemFUMY7eY?=
 =?us-ascii?Q?lJuax5sc6FgUHHRiBkYu08xjNUBshWZSkT5C66A1xZMwyxdlRq2uttuH9Qps?=
 =?us-ascii?Q?GTOf8WYU+qv1JcvCWaQXAdy/KV3NIwVW8e9tcu2HVIda92AlXkFdI9rBW3wr?=
 =?us-ascii?Q?Tx+A6Cwbr92ctiZGZuGi77GWmdmKJMbji9ZXnUGVZzXp5YNB8QpfW/HO9loc?=
 =?us-ascii?Q?E2C5IToV7QwFD6va9vbyG+fFLpaCIrdMd8KURva81gBdAMBS40ZlbMTJK7xK?=
 =?us-ascii?Q?2owgGf5xLaSd56Cony+Lne1F1bwIZhTxDbBZdOfJAcjWhNWhIxLtOu/q9M7q?=
 =?us-ascii?Q?uRRvVQVmEWRXJ6S4JEgFJgW6Vr18YwVC0fCkN0wmRGeggd3R2H3KSMqNRCrX?=
 =?us-ascii?Q?9PtstEkuYcD6RHvTe5SOgyx2HGH5kibCCQTxqcZ2kF9vX4f5TcT4Z7BSS6SW?=
 =?us-ascii?Q?LZlIOBI2n+PUpoBl+2qFs3mVm+gjCuESuoggQiVtaOhojnbOC7pDp9ZtsNmE?=
 =?us-ascii?Q?zUhaA9S8CmstSL7tqhNuHuryTtZut78GDm+t4uhysDckT5i+++RfZFAanKHi?=
 =?us-ascii?Q?rcXNmH/ZRkByEIEgn6fZHHaSkVurJeqL8gzyv46xKXPohllTDSW4DzHSuFVC?=
 =?us-ascii?Q?K4Heo8/rIVPhRjlRnDI4mL5uDwPywyCllfvzu0Q7fT3CnkqHctNgj4Xdn2R8?=
 =?us-ascii?Q?pMX9/VsCzeSJzRVRYDYo4KheOlKmvDKooPdkSzsbQQhsafJNqOERofnjah9t?=
 =?us-ascii?Q?ECo3NKvlEkrdoBVBn9obcf5zLOrKzOCU6mRLuMRpW2rRe7X3VFFSItKfAbRR?=
 =?us-ascii?Q?a6JmjltU5UBqJPdzgJmfvu5tRn1Y29Zr6L2cuRSz44TxVfgeEwM/HqG/FduM?=
 =?us-ascii?Q?GgvGjITguqTeJvnjgZLZC/YNKamZV5meD7BR1s6EWkfhpLbKvfg9LvXffzeq?=
 =?us-ascii?Q?007SJALdT4GRMJI61lFUzabJnfQw6ZHYwkU9SuytpF5aZRWkwCfbGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?outd2Q77llUVuFBHTcYPHekiwuP3YkdPdjCzqLM7o8nmir0sHkWup18IMAQG?=
 =?us-ascii?Q?sT4x7Px1GTnvyF92dPzObrWmBM0omaIuq4tlwx32Q10CMyGArcYiR0qLej9z?=
 =?us-ascii?Q?ElDFus1lWYrvRDqd5lfbLeueyUobHVRDiE9YbQzUyYPDXydealt7HUIrl3ZE?=
 =?us-ascii?Q?T3akRnVylEElgavo+eMascT98V7PrAhYN2sLTQc+Ae9AsK7Qv1TT3GRkLVZm?=
 =?us-ascii?Q?IPk6zo+FAvtVZOhhgETfdzJB7Sv4rj+L/i9hcCnsHaLbKQ/jNlPQiv9xuK/c?=
 =?us-ascii?Q?j8RUZ2IpDSTAZRBiIhZwJFui1StxqFuBNSM4BuIe9HMU74iPbDpF3OIH8XHM?=
 =?us-ascii?Q?eDz0dx8sAPEzJf0oH6WTWQIn00O0dauv/bw+LTxLB/JgfstI7DePwwUUYIaO?=
 =?us-ascii?Q?LYAxq4HSNEhzJix4Z3dHAhbZmI8mYHw0toWQFCUMinO3gbaRekdhRmCPQdNC?=
 =?us-ascii?Q?m1zbdThja1tlnOymGhE4PPfTqpQ7tqXbxL7QOp1GEzGOt4JNkmHvhS1I4WqI?=
 =?us-ascii?Q?Jp19RmG14/ipi2IwRu1pAHGNvX+MEC18ycbFZF4TJK6Uk0LNQdOkCkPPGhGW?=
 =?us-ascii?Q?zujWtgUpKe8Y7FsZSHj6Z1yzpJzMxqzSlge2gwV89WXtHDTIikN/zEK1Qj6L?=
 =?us-ascii?Q?tk5hziwOkwTKjpD3yuPDrZgVZKWRJK69HJ+rm3IhgUYG13gw4OsCMylns6NB?=
 =?us-ascii?Q?ehTUk2OvZVCTpEZQtpV81RvvZfaOpJb4nZuumLePcFuOdtxMTZ9UwV9MrpqB?=
 =?us-ascii?Q?1TZ+vJZFnUPofSoV2TYpX4x3j3nGZ1BFy2L4nlmydHZucFSJaTYRxdr1VJCA?=
 =?us-ascii?Q?IBuqJKafE5iSubgt3SgsoLlRRK5lJFWuoU4maUNg2xH5VfpvaP9e/piaRX/b?=
 =?us-ascii?Q?jDQjnxMbkt5SrdIyd8e2iyhYyPV+Jf549uOeWV/KdO0oukmcrQQ/TTZZE8II?=
 =?us-ascii?Q?Ng5KAPZLZg+K7U2RTTplcprjmHOINAFML6bQmtYK8bVKWlBD1sPyX7vWdhxd?=
 =?us-ascii?Q?aKa9nUan4oD0cWGXax8xQk85E3aBVPeqcRC/K3mEeqFpWE7hFPBl/e40RuYq?=
 =?us-ascii?Q?lJQEJN6YQeWIq/+x9IPI5DmnxPILW1WwHNr7j5lzYVU6WGKkfXUYnaBPC5kR?=
 =?us-ascii?Q?x5GEbamhOISUcQdgabcXyjs3oH3kj0EfBqJsK5VdJnY+EYYqFBqMGomH4R2p?=
 =?us-ascii?Q?ZNkQRvYZ3x/j6F8IOHCtay6Ku5dyWbw3Crci0LHBU1SWnFVY3XMzghfyfgTL?=
 =?us-ascii?Q?mtM4LofViJv1vu4VwFuiIvqdC1BnAz+XFuSgaN0moKbgc2oDc9TNGOQlltbs?=
 =?us-ascii?Q?ChID2EUukzFCtL/GhrXXGJEtUZZxWfEvsY3D+fcngLkUhZcMoVrXtTgHzfJ8?=
 =?us-ascii?Q?2hYlpG2p7bg+bDpzSLe24KBhDLk9GpAbuMyE6FsHVBl52rsoH+bmslLxPDDh?=
 =?us-ascii?Q?NUhkaThsowKEUqPLwSyaGRJNOjFYKTA2j8iWvIN/u+WthSDf0VUF3M94Jo+s?=
 =?us-ascii?Q?rGrM6vTlnhU7TeTsd5d5CFCdNxt63PSMNB/pUi2xrpOWguke4aZs2wUxxruw?=
 =?us-ascii?Q?pz1hC3C+pQ84FuVeNsv4h4GWC2jtugXi97oMCgMLC4MRGHNw6O51jr80++hG?=
 =?us-ascii?Q?ljNUhODu8qIuZLyf0Fnvjog=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2b8f9-63a0-4020-4eda-08ddebbfe15d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:32:31.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4H4KJTY/2SkIcvhWvue0EKBkxrlcC18GQLSNx8yyrnP52VO69ieQ3qef2tvxrehvOUN7TI6WOex/1JLSL3bSIIkh2AOiokgFluojqclz5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9231
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Changes v4:
 * attemt to sent incorrect patches (sorry for this)

Changes v5:
 * really rebase on top of master branch

Mikhail Kshevetskiy (2):
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/mtd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.50.1

