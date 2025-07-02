Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54786C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA68A82E86;
	Wed,  2 Jul 2025 09:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vsqxwhad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2334682ED0; Wed,  2 Jul 2025 09:46:59 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4317682ADA
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5gBzSWVylqQvXLdMJmgakUl7MgQFSfWS9BX/LS2Sum/Z+sM2diy1m+Lw2YLKDrU2QokTRZhGXKtlxIo0qLBkdwOfF37WXab/Qm5yoX3jEUJuCCbEXKXHPZXjo73tfHwQQhOHUHsxs2ub1mDzW5tWH0k8azYgQt4wTtDGzwnSbZWpLADun+Og4g6hlJdb/VQ0ETzkHT/GRw9eNgwNOGw1i9obwnBey9ysVAhOAk38d1B/BW2NRQP8RHFubQ5Pwp8DEh22fDTcLdhUCNZHXMucDNVOxfvwC9YvbOcxg0bWjykSAitqYFXz4QUMIWW5mY1kCrR4/XbNY85nYTfFkeFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXQdeUg4xgp5WDyWltlTdA9gmNkK6iT8JvNACzjGveA=;
 b=rnRbHUyhDg4M12KTGd4l2FpR0Y5agh/oXMQktSY47kKWb1xdHWC8l7Zq+6aUvLJnhwqwdGPFTai/8yTKC0atENiSIC8zXkU6+z5p0WnXFQijjl3rQTC/looVUxbFrXNcqmGuHJQY6QX4DMZwRLxLZxpI+DoOqZ8BArjsMkb1jvMNwx79zKrSDr2N9qwyR2bh3B3Yrqipd3GHWS6XBCxhDC43irwv3HZnutQq9aeRJ+U6LeSBhFuEsbkgi+ziqZPFIUXpuMJqY078w5fBBvZrN4h0Z6ABCFMrlLQJrLXlpWgvjqr474w4MZs0L1DMr8NZVXf+WEahlsuZLzHLtYBK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXQdeUg4xgp5WDyWltlTdA9gmNkK6iT8JvNACzjGveA=;
 b=vsqxwhadHrHxRzkWl1rtGE11JE+sneVydcuXpua6FZNYy2e5k1O9harYiAEJEJhQwIu9SBs2k0EnRQhr8DzJKzQfsgoXJrAGikrH6Hqq5Ozc472Sij45v/7LhmlDJkq8xXRofxLgszQ6NJcCyf1TyPGOU3JaHU64AyiDE7YOyF4BQfV7MRxaDa9cOwlz2aETB3XafV0huCys5AfNtTccWdNg1ByMIlG778FAMoIimOGQWfN2GQBJAoGMI4IleCw8ZdUukvxDQClq6P76YKW1M+MW3D18ZIrP1Azmlw/SXEUXpgQCeWZqxnOWvJ+vixg5nLL+WoFQuMDLmb8SHrTrnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 07:46:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:46:55 +0000
Date: Wed, 2 Jul 2025 16:57:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
Message-ID: <20250702085738.GB27006@nxa18884-linux>
References: <20250605074610.1424953-1-mwalle@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605074610.1424953-1-mwalle@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 300af4b9-a4a5-41d4-619b-08ddb93c9ddf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SvVO91PzWzJrlddWoQt4jCgh7BHTfPnNn5ykjoCSc9kahcVp3JTR/t3T0yiE?=
 =?us-ascii?Q?0EOdhI/3ufplEGXczpZg239gCw1iDssod2bgy2SEXB4hYPOOC0g83TB7gSYt?=
 =?us-ascii?Q?oL/BXAmWEnW2jyr/Fqo80dPyQWxsrXIAw1oJV9wGzIZqfnsB4e+/3rK9I64N?=
 =?us-ascii?Q?ViMXsfx2FXfI7Y7AF4On+hrnB5LRfjxDYTtL9dEB75fQzwU1qWmN6mTFy6wC?=
 =?us-ascii?Q?1WspyQkAp1ti07OXRltpPzkjiTQeaprSU8P6mX7/g7Oc87/3D8tEUVmgWwJe?=
 =?us-ascii?Q?teZlwGRkYgMYrBRWVL86kwi/eHwYv5gH2TYn6DsEOhaNwV2qv1F4UH55Dqw4?=
 =?us-ascii?Q?ontlM5KGH0udnu73NSeER41BGgaed/zVGYMoiiDAK0OI0f5mplmaIHeBUXMU?=
 =?us-ascii?Q?GqTARzif0NvmLjA9pAA0dnS2vIUJ6eAficNC46U3fvltcAYObLBfLzCXHHs0?=
 =?us-ascii?Q?/cSMisFXRbUe5ZlVdngfgZcL7ZMuLxPEYAboIRZauyxTvdcoeQndsL7vp50g?=
 =?us-ascii?Q?06sKzw9XJOrIPUwex9JCBB8NMIhTdk9TZKZ+aMlGJe/Ix+JNg4qcOGkOlBWh?=
 =?us-ascii?Q?Tvs6rfVIDJtDSViju2xMi97d7gG74fwvSfeQNvVNBxhuIzgj9Uku8p4AycZY?=
 =?us-ascii?Q?qAOdr/oAsclVeSP0PI5EV/kSlhFSYbhco3KTX1gKefWvSV+FM0G00+FdsEij?=
 =?us-ascii?Q?xFY9b5O3NjzWq47OBtabE4EJ6uXcgZKBSeRZJa66PQZPF5Hqf3AQLK45FdLi?=
 =?us-ascii?Q?sh1mv0sUizgHnpNTj2fulc/dsWlQinRKs77xm6WA18NlyFQ3+8svFQ1l2VK0?=
 =?us-ascii?Q?52MW4Ox/yQg8biQB1fsrymD6pffaUp+7Hm5q/F4Us/QS4rL0VX4aRmWGrSph?=
 =?us-ascii?Q?5CDlmW9pI89RfWayx1+BD6b3CK0amc1beVmNY4ooIiMTYGF59h9E2sBj4M/P?=
 =?us-ascii?Q?Eqi7ngIqcCtkLc8+nmgSbf6AmXwdUF+sktQwOxXSeg09W6T6CKYyOIKLA+jx?=
 =?us-ascii?Q?5/9+O/D6Mh6cf5CzoNU0nFmirfJ88oo2rXA4OKU8tZoWWQXz5IgfWxPYGoUU?=
 =?us-ascii?Q?+tm9mqabEMIIbuNYEIXyw44NbgjPjC0uuG68/3h1k+OTg15Uegb75pBxSCd2?=
 =?us-ascii?Q?BqIBlys1PxU/P48HoH7hefjjFzOPfNSaSUr5CIWrADITVxM0kOZRThOk2tvf?=
 =?us-ascii?Q?GutT0RyGzTkOEcBwdVY5BRsA9PB3jizergxuBZ1bgjuhMoDeWV8Q2DAO7hTm?=
 =?us-ascii?Q?35bVj9JSPMFM3Rb6Nq0z5zwy2htKl1TzK3tmQFmrRFY2I1NBvQBwXHhZHn8T?=
 =?us-ascii?Q?ypDzhRR4on+UDO2EZHROxOlNDzYZ14sVo8T/i4Do2SEkX13i3z2trpnr0evr?=
 =?us-ascii?Q?2rVvElEiVSwWZIzBTKgFXvtdk2jBWPCh6wqBPUZzdpt+EZHqB+LGc4JM7O+7?=
 =?us-ascii?Q?SLYirFnNwjhtsZkYs4/Be3SpGNo5vG9739qd34U9+1zhZp8kCxWCUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcwIyLPyDKuYuPyAu36tskdSkpPbdflWb2k++JC6jzm5XNgWJdHQ11I9KV9+?=
 =?us-ascii?Q?OANqBgD7tF7INBFiomBBMZg5Ynb7UHP0XFWPa0lYNQkHjxr/XXI+GTKJvEfB?=
 =?us-ascii?Q?lH7cQzZBm9O2dPS+GGI7lfp9339CFxgImHeGiMk7xscn4jevTct9ZRO2rfvf?=
 =?us-ascii?Q?dtWSwbjQp3Tb2pMX0s1bNiQ+JpIrI/HmdGeLNEmgQwtESCTmYre6xiMBlKuY?=
 =?us-ascii?Q?l+NjqBSGDTSNd8WT1BYp6oc2KY9JYlaIm7dFeKPnLnbIC6n/FMAQVPMG5Ur5?=
 =?us-ascii?Q?WeKrJEYG+0MJa1BJjKCFo+DheY9y3u5Jeq7OpnAohnaCbr/yIoGhaCRmvhUm?=
 =?us-ascii?Q?9qBmfr7eXJlIk3m3H17ztcO4XkgWqNnQKxN0e6EFu4IQqNzx3jgCzMQ49vXV?=
 =?us-ascii?Q?YqsQc08+8j/d8n5Kib4nl1DIrUI+SDZLLH3uIl8jZh5R1yyfRJpXrqMedaUx?=
 =?us-ascii?Q?Jazp/TwAMChtf7eOT8pa2uVN1cCyRYEyvgSmsur7OPxqa1KbrH8IlsE2XmlN?=
 =?us-ascii?Q?laICUG5muVrpqLZT5nLUGiT8kG0VD3RMLArs2D4iA+7XwlQkOUexo0l6oCQ8?=
 =?us-ascii?Q?lfhHfZuKYwo+eQUq3ydnPnhVopUGJ3vnyRzlcHJXsvojOQ0RuwT1FLRFvCfr?=
 =?us-ascii?Q?qZuskCjbBXJIUA/PKIJUjersvBqRarCaA1vXxwt6XRQYGAKCyYYypXTdAj7p?=
 =?us-ascii?Q?JaP0jBo9XQbdJhXCswuhhi36CL84xX6PdYMFRmVTc79EzDkh65Z9BpG8UWms?=
 =?us-ascii?Q?bzyOKJq2WCiyHpr1x0Dldo8vks+/eeuc+n3V1yjUQKNGK0lZVbi8t/H0TBZQ?=
 =?us-ascii?Q?UY08sG+ulrQ2z8DAvyFOS717x4J+5OWRUdn2tJzVoEZ6drp8rFjVRBMj/ymO?=
 =?us-ascii?Q?164eLlvXg7ehp/mDsmI0BpTc3tHF5UTsq5OOBVbboqBNkU509STdcXPYSxf4?=
 =?us-ascii?Q?882snPOc5DVybODWDXcAG0IIh+u1j/4GBMuC5W7nzGOOFW37NeQU/inaV1DW?=
 =?us-ascii?Q?klhWOcyO/KPLP+2u/Srwn+3e0xqNpt9C87uhn8aDhWiMF1ZiWc8i5CLcYJxJ?=
 =?us-ascii?Q?wfEuB3jcDy145EJgjD7p4w2vFLdRakoJdyyrgqrsnSZRvWY8LPXUn1V+ZLNB?=
 =?us-ascii?Q?rdMq/QChEGUu+LPxygkPhtyRAqX3s2kt3wOagATnfjaDLoTaPkoecTPkFsfN?=
 =?us-ascii?Q?jY5RPIBJRyy3DMYl7VfOBh8ZTOXPyDB5LMl/ePTFLSw85mdiO2Eif1TynwkP?=
 =?us-ascii?Q?9fskZvHrSM6u0jzLefAkWfErjXaNLiMXjqLk7SuKY07fuKa/Bs8pSE1ZhmND?=
 =?us-ascii?Q?H1Q8EQqAHmtOr4fdwsUBMBcZCY4XF6zcfaYlh/FgXPAo316tdWPrm2R1+SQM?=
 =?us-ascii?Q?5V3+RdRddxdSaQpd1uxWAEq/oikhVM09+jAy5WQ3rZ+rtf5serK2wgyZ/c5x?=
 =?us-ascii?Q?ySZx1duBS9f2ysLU4SwxDSltoxC/Tw2qyx9DZ6dOsd0zweBO5sn6X8sHw+oq?=
 =?us-ascii?Q?8GV4zi82aS6v9NfMKHE95pvhswSyDoTnCL1le0wXTh5IOXNLjehxKYnUVFsd?=
 =?us-ascii?Q?//q62bE+6qaZTOKUSZedBB/vqrniyDF+lgYV7mJe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300af4b9-a4a5-41d4-619b-08ddb93c9ddf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:46:55.7491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CE304o0nMPEGRAbQ5uEu4M3wD5314JamxzbSve4pWQndMHcZzLorH29lg3dSmx/ugGP8gAEw81cYrt4ngQTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341
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

On Thu, Jun 05, 2025 at 09:46:10AM +0200, Michael Walle wrote:
>According to the help text, you can set negative offsets to indicated
>that the offset is relative to the end of the parition. But kconfig
>doesn't let you specify negative hex values. I think this fell through
>the cracks when converting the symbol from a '#define' to a kconfig
>option.
>
>Introduce a new boolean kconfig option to switch on the "relative to the
>end" behavior.
>
>Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied to mmc-next after resolved conflicts. Sorry for late.

Thanks,
Peng
