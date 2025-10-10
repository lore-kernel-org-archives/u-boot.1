Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDA0CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7A08444B;
	Fri, 10 Oct 2025 21:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bapH0Xw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6098584280; Fri, 10 Oct 2025 21:09:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905C383914
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8z8JLJjWQG6GUdJfo7BpZII+SuijanxaeH52Havt2EvwuU7S+jOWffWRxH4aMy5qcYdRstFZBznGf6XBxkq5k2P4jdtjNazfcf9pxri4CegvWPJgXlaHdbQFegUXlLm2rJsoZvuYUGOewDMYhFnNZ5yASXi3fDmI4U+Auu0vwGpQe2ezIifH2c9NFVXG70T1madTyTkkDBvNC2b0tX/z/D4bAKb7pI4YjVOBu8KSyIiKIDl23QwhwNO/dS4txZyGHpWqLzZXCwI3eDsv3LhE2sFghRvtFSfbM83HyI8RXGpZsvSDJT4+NztT4jAPPRuHMQdzNfThx1w5vrVaFdgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG0N7S25zeP/+NDFOXWSpkcH/67vI0EFKrTPStSN+1g=;
 b=aSMVw3ak40Rmh9y5Zn2Q8h4kr5qvtJava0rdaV7rSS0zRODy0IZbbLZ7qZdAicn0aKg9955h6STMHdLRBSd7J5Ez2yMNx1J2/n3oeDa6TH7jxAZLLwk+rAdaigMo3x0YSOg90mxg1KBT4+1balvfYIt270GgpwPeDMeHO2wMUbq3tmK2C/RLTybRKbPs+9OA/Yx841piTyQ9oYSP41duU+d8QiOXgt0y66Zl79Q2WsZM+jxZ5u6yGYZyoj0qpf1Syj1NYd4ixsjMdmBs/asoEK8kEl+CqGkcEq536sXMVSAlaT+MqaaP4BAucQaW4BrjLn1NwbBcfYMr4qgmjEfJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG0N7S25zeP/+NDFOXWSpkcH/67vI0EFKrTPStSN+1g=;
 b=bapH0Xw6OxVBXal9Ntcm0lC15U++D1TvQ9p63Ol4QfhoDZnhftHQq7VBqfA7i2sk7mjUjkqlfrlRFSWOdoU2BQA31GhktCsB5nEkopNhi8R/TNNxjw/vBTw4UEOHuJYNkS/VfJE7u63YVtYu064BqHNB9ypSS/Vud0X/5Lznp8M7fnQUHIzdHLsLspMCiZRgOtPbYnkkP129IynI53+nPB4uTKLJDRpJscuqTExvUwxrdDfKzYFscLqOCS1lt+WBwzBoPwamrzT2iybIfnLQSPwEDc5l+QbdWj/XoMXPsg/5NLPYQJzxIr6KYu3qEPVxKBphJdmbBiUK2ue97+DqpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 10/11] spi: airoha: return an error for continuous mode dirmap
 creation cases
Date: Fri, 10 Oct 2025 22:08:40 +0300
Message-ID: <20251010190841.1590130-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e353d3-9cec-48c8-7fa9-08de083076eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jZa1JA3M89VfjsiN3l3Kr5q83aO3P1liQJ3ITJWEDm6uNQi4tAH/REXpMpBe?=
 =?us-ascii?Q?WCASB+Lk4mPB6Qp1QN3nuuvv00PNLrhjPOExKzruqhjvJ2aSOhvGwJhsvVYq?=
 =?us-ascii?Q?nh0FCb+5DjYd358I3cLdEwa3XY2ucTRwm0+ZKEOeuY//6BaDTWE49y9j1zTP?=
 =?us-ascii?Q?snQAOq1PnnjDCIUiVnFoKJkCGQaQyc4VBMWdprIw2gY3BSDw0wmQSDFsz/c5?=
 =?us-ascii?Q?o/BpLmjZFO0Uw+NA2IzsLIB7Vok7k+IZqPQWbZ2slXFFvZdlyRoFw8jThaNy?=
 =?us-ascii?Q?nnS0zIzVnymSoH28zEZKQKKeIo4YOQdDMOwx5C+WwyegIPPkaL+EUjeLt8rH?=
 =?us-ascii?Q?+AmUdlGbKiVE92Ptw2XbQULr8IIVwSch5ORuMbiunwtlc1ga9rhEI9nwaKQt?=
 =?us-ascii?Q?tvv4CX047GerOZ/l7N/LRMsx1tabOeTlEZCDbF9KVM8eYXacxX1ItYVbLKgU?=
 =?us-ascii?Q?J3ht5AV42Y7QmJAlX3tK7WJ02sRPK4PgxL7nTPq4GkK91UzhPeCRB2QAX9fw?=
 =?us-ascii?Q?WhHMoNhQrGoYDOGaLrDsQn28YgLzUdJav/IL+cjtrLzR2xJXPP2eMNrcOWz5?=
 =?us-ascii?Q?H2rWBpzwrd+JDoR+epHLzEaw/TyrSogAYjdxwAtdNEBHEuqI0Ucho3iqHDVS?=
 =?us-ascii?Q?WsSsoW7LQkY6THZldY/GWLmD0AENLgQ5JNye1Ia8fsvlvj0kvRIXbrVNWsG7?=
 =?us-ascii?Q?O4lxu+nAJbueoC26WZgI9bzSX5nqPuZ6dDxXSLKYjdcpz6KXKmQtSFtc5o4H?=
 =?us-ascii?Q?ilQxR3x47OhwwAS0s0ycVC9fh1KgWMyGvp2LG5IE7KttS5ILQE8pyESqM807?=
 =?us-ascii?Q?94fBI8CJ2UOaYElYMKOd33N1um85hleAp0wjwQPGhV+NonqA2Ty9lcx6nD6P?=
 =?us-ascii?Q?AKx0qCQpBJoH5XjRQAzNWohjMugm+UPEaL+72XB+JrLT0xUQYcJ0zDTTmnlf?=
 =?us-ascii?Q?UwjJ/rnJrWDZMX7V2Zsu3Ctt95xB7dXhAc2xBp8ZQsYJoaqSBKVWTb3AENQ+?=
 =?us-ascii?Q?S8j0mxUtJMGjX23vWA3BnQ3YSTXClXZCQQDPjDGgaYMljJsPRN51MyUaZTbl?=
 =?us-ascii?Q?T3HGK/nwWtvFdQKaluZHsZjw9W+w2ANDteV2mvRawotBVD1qduxE498a/ssE?=
 =?us-ascii?Q?e5mH3G7mUvlB88PryhrAk4ROxxZRcS/w6qiAhr1/KvsxbxMrKJNAsaP8xFIU?=
 =?us-ascii?Q?FqjhduAgCTCdyav7alxsG2A/JHuBc91q30ob3Y+uAdSB7o8fnrtWD24QsLW5?=
 =?us-ascii?Q?2doNSTksyyhTJgIcjgCy9OoYctjL+XAffVC2yP1+U697UsM7XTfl9GcOp6cb?=
 =?us-ascii?Q?EN1N/o9+kHQONeGxK+HUMolu5z7W5BQia/j3Yvd/f1kw5DQgdAvrnZePErFx?=
 =?us-ascii?Q?rYE/CbptadGz1ozO/hjJLedNA4SV2ZzwlVDhBoVH0m2OjYGRIx/MXG9SWwG1?=
 =?us-ascii?Q?hL8HmDaPgiVeZjzcGtipu3y51n0hjx16qWn/uzIbY32NTDr1An5EeoRtH+A3?=
 =?us-ascii?Q?D+7Ynj06Fi6TZXDvrxN1qGgtO7UQTiGvUaOs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQokUbeqY6RGSqARhyEFdcA5EiCirYanLDo2MZNGZOBr2VaKDUUMp87LLXKQ?=
 =?us-ascii?Q?DWuEDrmt0p6Ix7TwYb/8oGAUuv4jAARQZrnKq1/dD7emDkZs0PLy7/pajyd5?=
 =?us-ascii?Q?K6SvHnyCz2QplJxTweABb+EiKPcI9iv+gZRydcddZir6PYnM3q7zN+zjnWJ1?=
 =?us-ascii?Q?wW2Bmrbyg1YhZurcmgoK0KauS0+KbTRwp46/I7cHRB7/m/nTg+3vr8c6mOBk?=
 =?us-ascii?Q?ywD1MyWbkJx+dPp/GBkEJjrvse+n711vQqoSBcCbDGQCJoE7fnWa50yMhs0j?=
 =?us-ascii?Q?PKl5ycbT3NvuAdt1D8ODGmUYYmKw4QuXdihb9OTkSLYkYQZF7WyZffFewWsL?=
 =?us-ascii?Q?4tgGOIs3le+PS7jSkqoU9l4xSqKrKQ0IdPOuExrvwJ1Lp4AjJ63hGqTFetYf?=
 =?us-ascii?Q?hZedzNUkJxf2+B7XoDOYveJtl/VMTgdGsms47VZhlsGXNfchAglQ3fjo4N/j?=
 =?us-ascii?Q?+JStR4zZdvrOKOlsT0Rm3E8oT0ZqJuxmJAaBFxsPGYDYwFs+nsmdSKzVzkBp?=
 =?us-ascii?Q?8EKVtWo3ajZls/I1uUa0Z0zmLvrFycdC9Pix2n5iWlTW9DkP58NW4MD28DnC?=
 =?us-ascii?Q?iP/BUQURDUvC4Dn48XwbTa60nzI8EpwCLb3m1Q6NXwuHhvVWJTqlC/DzvEhG?=
 =?us-ascii?Q?dQdZCrAlE2jYNSpFGZ498WWsoVTMWsbhGxxHDQwBuLiNNjXcI4PO9OZsMxFQ?=
 =?us-ascii?Q?ioRiyrfnSlj9CY+BtTctmx1ecl0auiGoiT46BLky/3bVvUk1Lxvpx68Ag3dv?=
 =?us-ascii?Q?ug+WMPKGZml7cvGSmSqOHzy2Eb3/jqgsgMfHLQLgqj1NHXic6MYuL0IolHx9?=
 =?us-ascii?Q?0QHvjWJEpngbryvU6tv21OkDZz3rv1gsd/QX+CUAai6Ef4jBQvlpK1OJxWp1?=
 =?us-ascii?Q?dhX0cRD46PBaPCyt3hZFKs7wHLFOjksXb/CllAUbeMxOk2w3pRhCtzhi9lcs?=
 =?us-ascii?Q?qs+v5nM1b3ZLXBGgwClNK35m4e0x7mzvf4T2zGQQFIGxMOFEKw48WbNS4Hua?=
 =?us-ascii?Q?FplPuuiCiJWPLG/Y8N0rrS5CB50+5xIzzNEbz+7rRQUxaPVLMJwls7xzM8KG?=
 =?us-ascii?Q?scySDYdx09DNbR0aD7vnj4IW/HZ/APpBlCVibz2q4MZcEO9tX8dsXQNWnfM6?=
 =?us-ascii?Q?wTSrHd9pB06teck/BUN4F3pbKTLTniiu/JyTT2zs2/v210m4/JhTtXaJxcgh?=
 =?us-ascii?Q?geizJuTiGYvNGCuCTjfyn8GQPjPyxP0CHZzKw5EQQvrw2GWRrKdJAk2c+itL?=
 =?us-ascii?Q?FfAOw27r+eoTDRop+fm0AZ0yMjhTkAO9HCZWNDl4OIscQJyozFVa+C/M000z?=
 =?us-ascii?Q?AWxI0SpmxBsUW7QEgPxYqFPNHr9T4oy+ZSOtRU+K0is94rZwnnmO2oy5Sq6E?=
 =?us-ascii?Q?FlxYbusKkd9Lr6xBbmevd57DtQwM6480LoHlb7lFg/RhElMC6kgu2Z01Ymwy?=
 =?us-ascii?Q?ERk9oAhTCt7WzuYNGQdM2W7Fnpgq6eh+Xifwr9cXzaz/vVGJ7efd7aVFGnDT?=
 =?us-ascii?Q?KxUI+EusxyPpzeT0WI5UV9IzcOcXjiBgtL0jONOZ5i3UStp8dANrMs40/fZd?=
 =?us-ascii?Q?9M7eBy9jkNWKI39or0AhvuW97PKdDEy3rq8/7UW9Fb55yKce0LFjSLBZVIw4?=
 =?us-ascii?Q?BkPZ37wTusnto7iUi41KNxI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e353d3-9cec-48c8-7fa9-08de083076eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:58.1595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0moVVVOrlCiHby6BhczakWfgXWz9dR2n9gIeQnBnVreCLQUX8LC1fb927P2KsJCaW6lT89Tts61khEXU2tYN7FjlTMncyUtfMooaB4TNWrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 9fc44e7088a..7d6af690bfe 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -540,6 +540,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0

