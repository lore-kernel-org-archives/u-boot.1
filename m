Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EC8C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4284988928;
	Wed, 31 Jul 2024 06:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jp32D/qs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7985B8860D; Wed, 31 Jul 2024 06:26:06 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A87387BF4
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3hdi7d5493T4no5xMr0noG6w5OLpw+l0KrOg5SeBNiT9R7SKDNrMTZixKMFnAB31esEc8+jK13xn375gmlbuLFg7+EzgcYstv+BvVNKBHA9Bn20oRiHbFg/OeUCYlzB+C2NeQ2n0lJC9TwBVWVshRtDlSAFuZQBNMf6j4BukzY+YJkFSf3A1wv158v+CO7iZlOkTSdaXioATPGKjvj+ShaaJkY4LLLijgU0D9nLX27m4u2RlDxMypAspjCS3VRg3Q8F2U/beIGr4nv125xj1CBKL2EELmrCNe+TZKzZIk9ryR8uSUKjp6rpeK78Kk7fiuJzEJLqLL3YX+vikbe2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7+fZUwiyS1eHsmZB02Rlw5z7J4ySH6eGVerqeE2wJo=;
 b=ORLP4gXc69tETqjgpUj8Hj6TdpxOUHxOcyG1+8F2CIed/V3XeEsWIstwV1zMlJo2a0y1MPH5FOsVAulxsgQCTeWNvc7Pa0QEZHoEG1QNa9yyrlW2IkDi8soumKgSHlVWVM4D9xzfvF6gTrodVeOUn/t++znxW+/tGe8S7hXXo10jJ6Ytf2lKYaEFW3DSAakQBA/RHnAQkYviY3jVZs7MQm3wttDkfJIrDgfKP5kz03PNhyWYHciYQWllOLzDSoMSr618zJpPU47dgnKOWRZYc6hdeWsIgcC6lqFew60QHqK0/a8NdwlWvtc0I1HZe2TgSLhnu9f6n5MskG6IDyvU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7+fZUwiyS1eHsmZB02Rlw5z7J4ySH6eGVerqeE2wJo=;
 b=jp32D/qsAMNPwAlXK+YbQMGTJaiIuPr9sUAmARtEom3gXR+OETJTR28jIn+O4XoxPqiZItGiGG213pazPSfQipbgGMlnnh8fFD8ZgoA2xrtusnY+cYGLKOl4wWUJWGDyE3jE+VbtAyyzrDTmdhpzFR4BNRTh7VNltYK2QjAZ1/p0P72b4ZrPQ3JaPq5mieYPVKJ+nkP9TP7P0/NRRFInAGhccusBvdxQWeQsVUIYqgr7vNg+/HTEmlyGsl2XLI6GMYehuVm1SOt3tAA7k7fWsZ4XrPXj/Xt9zhjgi2YJTpyJUFzGQ9bJPY3UvhAPKTMSjM9tL3E8iizYvbBNyOjKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by AS8PR08MB9573.eurprd08.prod.outlook.com (2603:10a6:20b:61b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 04:26:01 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:26:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] cmd/mtd: add missed featuries
Date: Wed, 31 Jul 2024 08:25:49 +0400
Message-Id: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|AS8PR08MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dca9a1-0822-4024-63ec-08dcb118e279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9QD4PH4asUQWD7GIYyrr/T1SugTRhfibmHHmlg1l9MEvn5ujZfEe9qwFmzeS?=
 =?us-ascii?Q?OwUXkpqDOApR8CsWFsrQBgU52RRbQXF9MORdbn0UPiRFH9+jiRMvxGROzpHC?=
 =?us-ascii?Q?58JqEbokUulbgzsqmAoayLHLdCqFOWzSpTEMnAEf5GFDtmaEuvWd+cXlcK27?=
 =?us-ascii?Q?EhtH3xjzEPvSK7lt2AyTQ/et5ceha5WXTW9ddOib/m+iolgw8n+B123MUNdU?=
 =?us-ascii?Q?fy/rFr0g4mCbGhXHeloCl1snNYxXiwEVYcp2LinDykC6qOaDVvs/Ns5W09WW?=
 =?us-ascii?Q?DMTD7YvEyOWb3WAYgBCdmXPkFBUBkBpUN9yPmuLlZ7YyFsxAl1JcmHl0+TTd?=
 =?us-ascii?Q?hzHWyBw+uU+VkXNzxXkXmeI3rTyWUFTCZHlMTEMTYOaCYjv2vzH2qedPNTU0?=
 =?us-ascii?Q?i1NuOSolojeXuVsOgLQgw78d19mG9pLm/VFL3kI1K/GZXNs08wDAE8cR4tXJ?=
 =?us-ascii?Q?NcX6RSYECOSMViW3XCUzzqPj+p3o1PlNM17tZeXStzCpwHsNiRR0g5J6h7Sc?=
 =?us-ascii?Q?6JNleegSpPeZCC3JPhV1cbdjId5P0+6KWnKEHJixZGBdu1mb4vOt+ibl4505?=
 =?us-ascii?Q?gabVGNGqfuQXVSxjEIHmhWr2PM6l1+/LSNLpEZ4399wRcwof53NAAPHcTHhk?=
 =?us-ascii?Q?mTAYBsXdwne77uyZjdHPDGgHu1hJCKRYEjCGGIf291K8zd2nREpftTKIa9Ay?=
 =?us-ascii?Q?0/eDwBmPPphSPSNaDYxJu+Z02+pbtqz1mHitH7t8PWFaWu7QFkPftidcyJfM?=
 =?us-ascii?Q?VIadoTZOlIXOol6uOHKsgu+8PGwURlflFNlZClGvPFvOy52c4GNdqzMPSHh5?=
 =?us-ascii?Q?kRItzjAxfudy7ItC8rmwxq6c8qR9P0cwiyp7e4vPWpsL297vFTwI4oH0MFAU?=
 =?us-ascii?Q?wsKwcCOs8pRHJ8yoxXLsxuQMHYB0bvcdCPeR0Gp+PKrRLBL0KxaML4QJIZkt?=
 =?us-ascii?Q?d6mYpvNxesAEOpSHdm/k7uZGiWvg4xyIfpxcs/oRpsNXpCYvbt7tpgLbpv5D?=
 =?us-ascii?Q?QwHxQRbUJZvrkzT20tfmG1NMN7UkA8sCCmq2XePO+hLKxg0IAXWnnKT0JSkq?=
 =?us-ascii?Q?/KX+ajyyC6VvzrSRofmPeJtwCy9W/zP/wQm2hXcnky785H897NCgqWikVdWn?=
 =?us-ascii?Q?1UhL5oJ5OEQ4N0q9IiDhfeVfHULqT9KUPDuNKsbnzhQq0pntKOrRcI18CdRP?=
 =?us-ascii?Q?WGTVyotjmL4Ce7WvHXyi3LXILn/sjM9UtNqnpeJVZvVH00CXCXo8VOoZu80P?=
 =?us-ascii?Q?XSI3nQCAYl7r1gb3GOmp14w5UW3vtoy+y5IzXWv5QwyyAD1XUk6NU+GOM6b4?=
 =?us-ascii?Q?Xh+oOB8u4lxRjfLNm4zNk7BbA6TXsv70rI2Z+YedTv8Uis5qJgu/h8zF33WW?=
 =?us-ascii?Q?iI5oY3X1Del4TEGEmNdIhdcCztyolWraqWJk8rYlyVZagghMnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9m3weqfrv9L+AZUXPp/nzMYGwo16yEDnKr8I1Hw5Q/rGWo7gWebhlFiwsLT?=
 =?us-ascii?Q?d8Nc5T0WW1qf9IXxRvKE+6f7e8uBtnrHKXUQ2rAvG0RC51EHHRgkl8+XvEKK?=
 =?us-ascii?Q?xhil/q+U29bN5e2ZkNx4XkNEROKfSceonf5t62vA4nug9p4sV9DhnfyeseUw?=
 =?us-ascii?Q?Ij7hhhdFc6dp015xn8KFto1WmdkAzsroIYarRxydjmwnZ4e4kgNR7qxD0hUv?=
 =?us-ascii?Q?ASnVDBjf4D+J8AX2vFulUxWxv5aWq/5+l/nPlaAR2f6ehxKgpkIQgJ1DmcyI?=
 =?us-ascii?Q?SUmJ8l+qVkGYoCZiU6S7IatRjBKZZVmIpeIqJ36npTO5P/EXLquGoh5wbf9R?=
 =?us-ascii?Q?mz/Ga0n32mJNdF46grdIqPvZPZ4e/ww1IXdtsEVDvcPKagaYNlDbDP4cpzst?=
 =?us-ascii?Q?pXUSJGXZ0BlZr3bWHRnVF1E4Ui6bPF0fflgagEQLJyfwDFGki+YxWkRa7NGo?=
 =?us-ascii?Q?kcCw3Z0+pFnUXURV6pwQvL2CmtuB5isqBXFyy8YtauA381/VOu2TI3JvraxN?=
 =?us-ascii?Q?FDtufXhgq9tXrhbzSPb+ZcOVlaHUrXntm3FxnHGFAi5eAHcI/DekQV96vWNv?=
 =?us-ascii?Q?kFxIxQfX6D+8VllZM71+sQHCVn6ev7d4K+ArvmhocC+8xjGVjLWAXkefWMux?=
 =?us-ascii?Q?CU7LTcksXyyq3yka87uVI6xVGjWKrKTz/GMqx/z9YQbKqxgf0tkjmKz7d5GU?=
 =?us-ascii?Q?9hHj0M/RrWuioZKNcRYg7jvjeDVMBZBAKs+Rk6gO8J2/MbxaVl7RpUhajsRF?=
 =?us-ascii?Q?2LEX1bWfTrF1/G/DAB6zbc3ofv521XbjX+eUGe7vSeIPfnYgLSGCO+zkflVb?=
 =?us-ascii?Q?yaxTk8rT51d7BZWv8n9NYQxet5T0LBhArru26EwSTCvTQTvOChwQHqPu1saD?=
 =?us-ascii?Q?mklaFH62z73RHQlWe4bPT7E9GdnHgajL8T40sG0qV7DyELuoSqFgltejh+xk?=
 =?us-ascii?Q?9b3EoDeg2YWeKoOwIHfUbzp+/JuRS59WT/zvNEgiLnCoI1H6A+0gaAeNXUrv?=
 =?us-ascii?Q?Z/TyyBQU0oxejD/zSjT2xvdGa2OtQtuMCGKCtlRB2HMm89lPo/pTOeA4z6MI?=
 =?us-ascii?Q?pnTALl4rMFx1aqz+9redQTGTxJS10n7nLiccoTmuHnE/SjHcavjp4kVpCR03?=
 =?us-ascii?Q?F2yiMUTK2gIg170NIR8SjAYEX1TyY497SeKydvh0DLsadBxN7pM88heVflDR?=
 =?us-ascii?Q?IdjILx9sg6UDCGwVEErOM+fti25K0s3A1Qhpej9tF9vHx6J1Z/fwJtgWFl6g?=
 =?us-ascii?Q?l3CkzB2iZlRJKYDYt4Ovb0/Z5zrPpDDm95emqE/a0wffYA3vlFAlqBTiKrmi?=
 =?us-ascii?Q?zTHibPEfsF7O9SZgIHsuX/EcI+fv9Kk3bdZ6+m1uXK0uR9L25lguRpvJo0tt?=
 =?us-ascii?Q?eyME6FCprcrAFPAT1lCs2loz6S4Wxr7U3pY9gTf6FUkJUtYvesA2OQGiDATp?=
 =?us-ascii?Q?65BDSRMR59EQor7rE+yU7tKdZZQOgkP4RhYcCOXv2yo4ok1lgeF12gBY+BlP?=
 =?us-ascii?Q?OSc2NLRds10xWKnMnBwVibzMBBnq+8Hr0Crg5hSPybXZU3crrakC5wv4olgc?=
 =?us-ascii?Q?ORf7lt6/sXNQl0ruAMbJFVhwvWLXDtN6cpsju8ViI9DTZW229b4Z352Xom1x?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dca9a1-0822-4024-63ec-08dcb118e279
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:26:01.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mztp4eOTnpHq/eT7NWfBzRSVTMW7hEFq2ZVuCQsO1IBc6p5I2tts1mV1kqQF24LvNjYQKiAg+O7r8qnXSqlz5ogGrS3n+Sdgrncw5muWMgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9573
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad  -- mark block as bad (copy of 'nand markbad')
 * torture  -- destructive test of flash blocks (copy of 'nand torture')
 * nandtest -- non-destructive test of nand flashes

v2 changes:
 * add cover letter

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add torture command support
  cmd: mtd: add nandtest command support

 cmd/Kconfig |  18 +++
 cmd/mtd.c   | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 475 insertions(+)

-- 
2.39.2

