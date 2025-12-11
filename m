Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E2ED41C37
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708D583A3D;
	Thu, 11 Dec 2025 14:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fDQ5+s4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E550C839DE; Thu, 11 Dec 2025 12:37:50 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1952F83BFE
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZQ/1iPRm/Pg8CgFh8ZBHc4Y7aVbm3cfk39jvrANN9VIEdz0daLHuHhyzjsCSlxp2Meife8mnTzYQKAh++yB2JbyEjVrtWze/1fTiLwxpSlXN0YFLRnrrhTO7fClSkbVqPEOHqgXyTRGn2SuMpRhHgET5rAqyMbN1X6cedERTl6SkdMlTmuKyJKYv9YQUp80Fzlg777clg+laOsci0kIOT2aTKWwF2tvfHrV1WG3msS9nfWQuYxaFn2p1RyTepp/c2LhgViixo5YrDYgqnvvQ74NRW7nLkR9R294TWgQUmXPMWsROz3S/NnAdkXDBVUiLEtlM+K2sAnZmw1AROQG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRe23NSB13jeuU9jSQAAcU1+VmHaoM64/TQbFgXeAkc=;
 b=pIFCyY3K9NXN516XcEuwLNrDvpd8XYr7MNbgKpYGte3Xm7Oumrbo9SHEUUaZygmJaz9lK6GmOG5qw0LLVMJrUowTdu65MgSVvvJ98HcZQwoQX3LYhXtRq7zomBjTaijLKZ9k1Yr+Fr0MpkVWBPfbdVC/RXZt6Mdj+zK6GJzpYFxNA9tMd5BoH81SJ7ogs0F9JW5QF3He60oNv3U+95B6ibRi8x/EmdRoczdFTHKNIGyHwOJHTRJsMQqSh3eBQnDZds01+VHvX1sIqIwVwiOzb+1vxflSnUXFKrjQhWlZbrpaG8fqkBkAGS/NQfSBJXr0AJmfnylxGspdEetbnaWIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRe23NSB13jeuU9jSQAAcU1+VmHaoM64/TQbFgXeAkc=;
 b=fDQ5+s4cE2z+6wLp2l5tUXWHDkhotvSiOch302Ej66xQ9735haij0T7j+Qajp53rqjiQio4ctuOOYJ9JAOaBNYlg5cyHSPfp38MgGErXhnqP4dLny89HojI5+rA6yjRgMDr5fEmf/cxkqosw1UkofZV5oKJ7+w8eCpxaHaNVOymeZv+Ctu6xt59UtLQLfrSgv8CMZzJpfAvgMJ9qC0k5DRTiBYIfyMCxUkksdFvxFOTHzKJN5g929DAzsdt5t0e4uA/Pp5uXSZskQEDhNIO6L+t16K5/ZeTysJyRdEyoW7kJ6PkxZH+F+OB9afAmhnnWhiJaTD139kYgV34sB6qnkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 11:37:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 11:37:35 +0000
Date: Thu, 11 Dec 2025 20:51:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull fsl-qoriq-next-2025-12-11 for next
Message-ID: <aTq-PI6p3NPbdUMQ@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: d2add3d1-1a2a-4874-de74-08de38a9adc0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mO0RU9WipLxu86JFCsbSnjyQMSR2o1GdpMmVJaM6ZR+di5VXvTWqCvzz3Wba?=
 =?us-ascii?Q?GfpFw+3SF5oHFIOVgUqnsSd0jzMsaoniJ1GxPCISOr0YA+mKCD4teJD/bTF5?=
 =?us-ascii?Q?qWZrATxLxDTaiuFv7kgWkhcHXRgOLskUuE6U2/zPbyeK0hyDz/UaXW7fbYy7?=
 =?us-ascii?Q?7XFJpICVjY5cgJadIYbJir+EIOzYU3cI6VPyeiPf0Ntm9/ReQGF1l40831mj?=
 =?us-ascii?Q?W8pjy+jxlSFb9Ztgz9/adqDHO/MMGv1DThkMU5DiURBixyJYpr+Gj9OMM1wr?=
 =?us-ascii?Q?4UTY+YAg1KXSj1gZNHDjX8nej8p+kRduaIgPqzAsXipK6RP3ZUyjCz1icEln?=
 =?us-ascii?Q?eFzQ56NtRZrrTTMymAiNz8qPaWRCJTT2srEMEZHB0IPPM4BywyBd0g0NLUS1?=
 =?us-ascii?Q?pPTkLDzCtwZhuE37EdPGFvfXlPcHjQjbLsOC3FJ4xMrVI5r+/Gx3A12u6hzd?=
 =?us-ascii?Q?o9zq75oygRT17ltts136ISXS+INf2hwVJDNe1QslFR0AluR6TgWjRNuhk8wF?=
 =?us-ascii?Q?KCAPcXNPa9XHJQoHsps52WxKYaezmmLpguv/hbB8ks6hS4sFa2sCyDseTUI4?=
 =?us-ascii?Q?99YlhH6eD4DyRmeToGP2zFM2cQV+y+QGF6bqycANDOC3u3XhdpL7QH/fR5g8?=
 =?us-ascii?Q?HUObpZGuLKqlZDImuO3oHa36vPb64fPJ4oeuK9Q+lQdR7Ok+cGDHrlb560fw?=
 =?us-ascii?Q?b7n+rQ0QUMw9NsygVEReA8ZWzAmeQi9Y0QJRRUYfN4Ues6gTM0HxOh3C5x6Q?=
 =?us-ascii?Q?sXgD3pKuFcVLrtGVTCGgXPoRfHvJeNwWLt2X1buqS5/8oyH06Qb3oibnD1BC?=
 =?us-ascii?Q?0fHWNadFtoG/Ephe3ei9qKeXkoNHmDZRyUsOwY3wqWc7bu/PUMRzty7F3EUU?=
 =?us-ascii?Q?FRDxoKXCu8BbQGxLu0t409Zt+y5MyMkoocWINPWuLkJukupQXFymzO2Ld7ZT?=
 =?us-ascii?Q?PO8H76NysDlGJqx0gP5zC/jG7gSrCxkOnCtgnxupJf/BN6HiIxApn2gM4b0S?=
 =?us-ascii?Q?vFWGDWzFe4crNKUyMSBvdXzWsBcteSDIlbHwWtCG/wS1bijrlWGnr5Mx9Nww?=
 =?us-ascii?Q?LWZWyhA+DsD6y2yLo3AoGkH1xPxF5XhK2c1weFkNqEE2Orwr6YMi+ib/M/GS?=
 =?us-ascii?Q?+aefCEYGkYYHhR5NJFIu0qGDZl1qus6LWHg29tgnAGK6D5jsJJqQxrotqpFc?=
 =?us-ascii?Q?q4ARxH/C9pICjN+2Wli8cyJKxbbhwyDDVGJQ8D5GsEw2XoelZdqQfPGThyeq?=
 =?us-ascii?Q?oxu1wECJ85w0sbxnf2Jv7P5fgWgAFcWTPXJ5QJ5COT1ixaElu6fWNE9mqUFE?=
 =?us-ascii?Q?QtBxV0ETLWfhVbsvWQYC9Lh62zbSjwTWcP2iuig5qlEKE5wBvmHKuqFt7QeP?=
 =?us-ascii?Q?Kpc0hWYCA4mMrgjjPmdTxHMN1DcUz4TopvRFSrUvXygoxoIcDgEvW6qvPOTo?=
 =?us-ascii?Q?q0uUldr6PSDkLJKRjIUxW378XV85tTyLNvsQo9vwIs9EnfcfPxCExmd8/nJ/?=
 =?us-ascii?Q?dANIRMM0+nQM2qMnZEL4lBaHNq8rpoZccDq+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VvkccMt8Ccwp66wJgDCFbdIfTElMLMuRCJNLsaiO/a1IZAS1l9FWXAN09ehc?=
 =?us-ascii?Q?bpxcpz+xD2BnE9RljdvOHMeRLZ5eyezXhv44dP/iKqlfi8p2w1WdvUdo7E8o?=
 =?us-ascii?Q?r+/obYz/BBwaJVp8k2Ujq4/5feYn+/TE9OXm/8QPJpPfFFsvAACx2whC9Nl/?=
 =?us-ascii?Q?igTfRZP3nNyrVS8Mxrm2ZGr3BNRfV4ZqCsuMRZctsbJbq+FlKjH8DC99LhJl?=
 =?us-ascii?Q?kI/st/Bm2DfW6sL0Grtf4Fer5SiV3Wkzw0nZT062H44m65UX2hSFSS7xoZD2?=
 =?us-ascii?Q?mr6Q7+E02tCMUzY1LgLcX7ANEXQD8CNgs6b5BgiNVVIeyi/f41kSuHEueFAo?=
 =?us-ascii?Q?m5hvDH4KX94aCpXvRjgB0hF1FDTSbN2o9idj/WFwzJgCCrMxR/Qmsx3QF6mg?=
 =?us-ascii?Q?1mQpzhKRlTYjXOFPpQ3zWdVizMLDGpaRY/8kJqAR500ZQ4GstciTqLZPztV6?=
 =?us-ascii?Q?ZDZB/zYCMSX6hGXcP1qVftFvBRlNc8YvOZerQ67dD/MyETLgjBi4/E5nEHwG?=
 =?us-ascii?Q?RLzPLnzF2pQDpQg+cydoQkiHOGC342kXFmkwYuh4FmuUwYgSk3kXnCqUeqh6?=
 =?us-ascii?Q?vHDwriNk705wNndGfRl7N0FNy8ASjQeYdW4FhlUYkuAE43yxqcEdlOSDYfYr?=
 =?us-ascii?Q?CmISfZqk6Q/wQhCr7iqJ5nw6j73moOoglLQMlp8wC51EsP7zlk1hge0kTicw?=
 =?us-ascii?Q?ZCiCIx8ZN0Igq4qJtMC+/RlkiPflQzM9mmAD3msBvrfd2YsMD3GJ0wjLTuLg?=
 =?us-ascii?Q?SX4z7pBNDnj+dVZvBO6mjglvaLo07G7wqVDy3rY1NV3Z8g3TtvOdIkp15z2T?=
 =?us-ascii?Q?S3KOgVyCDDKqipdnWG8jUUeEtHw2Y6nW9iueo9H5T5nTZTQ2FK+ipYzOZQ4K?=
 =?us-ascii?Q?T6JScZx/d1Gd4tJddL6wsJ5X7mGUtYjCxQhbb/L9VhZfOeabiBrN1eObO347?=
 =?us-ascii?Q?UKKC6HyNtWlxOD/KHozL4wwxxHFkG6TF0NUeCtAEh5GJ6PREi68nxccfimkM?=
 =?us-ascii?Q?Ktj/KxNBcKnt3LvAiOh0tzBltVLUF0lUl4jHTbRnIJMLtBmlgBfcTm1xPSeL?=
 =?us-ascii?Q?8L3e8E4pNGbGdnCW+ZkU0HTU0IQ7fAHtZgrkXmXv6RaaFJKtywK5hBzchuYt?=
 =?us-ascii?Q?7uHQmPm+LxGqwHkJWzQRnCtMYud2jDz13KHLLK94NPgheybMZM39Qw2MtaTA?=
 =?us-ascii?Q?NheF8K7ocw1KeFp8haRr5k3N3rKlSZNKVGb07uVR+RlEi5/jPpeHM5/5h2fc?=
 =?us-ascii?Q?bQ4nkfPCT9sxHwfMESrf6OZPNmYEUiRUYM+BuEyokEncl+jMzTZKQ0AGlUwZ?=
 =?us-ascii?Q?DaGMTHbuXWrfD1OiGnM1ow/aBusuvmVRhfGhDgM8cq6/UbD8Q1MRpp+MFoYt?=
 =?us-ascii?Q?7yep6wbNulIEf5y/npSEPRTvRnEYDplI1g1mLRo+NJkeg6SElUgsgbiFX02h?=
 =?us-ascii?Q?vdQUyHK7m6ZrsPlnF8XSmBGVXRqlv6Cb8qLv+9OQEha+rEGeaVunHBXbIiSR?=
 =?us-ascii?Q?4lTonlEaYT8M1/4tt2GvKjj477IzoeV3Krg3FfItLlUkkMFS7HmLhw8wVNDO?=
 =?us-ascii?Q?d6QnIDf7p8Ped6trqJyAHqJkxYiR4FI6uGrTuRV8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2add3d1-1a2a-4874-de74-08de38a9adc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:37:35.1544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRmOKCh0QqqTJCVFT5G6fRe3sCDYZalNVaqSsCnBrUynJKpaJ0+KLJ2rEvDQMDERYJbk0njrQeseJEEoSJZ5fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956
X-Mailman-Approved-At: Thu, 11 Dec 2025 14:55:31 +0100
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

Hi Tom,

Please pull fsl-qoriq-next-2025-12-11

-----------------------------------------------------------------
Stop disabling device tree relocation for ls1012afrdm and ls1043a
Address error handling in ls1088a board setup
Remove offline cores from cooling device maps
-----------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/28727

Thanks,
Peng

The following changes since commit 66be03b7ee19444b23aae3990a434a7470fc1641:

  binman: blob_dtb: improve error message when SPL is not found (2025-12-10 13:45:29 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2025-12-11

for you to fetch changes up to ff7c10d89b1509d3843d2bbb37e357aa1ca55210:

  armv8/fsl-layerscape: fdt: Remove offline cores from cooling device maps (2025-12-11 19:16:32 +0800)

----------------------------------------------------------------
Anthony Pighin (Nokia) (1):
      armv8/fsl-layerscape: fdt: Remove offline cores from cooling device maps

Francois Berder (1):
      board: freescale: Fix error handling in ls1088a board setup

Tom Rini (2):
      ls1012afrdm: Stop disabling device tree relocation
      ls1043a: Stop disabling device tree relocation

 arch/arm/cpu/armv8/fsl-layerscape/fdt.c | 57 +++++++++++++++++++++++++++++++++
 board/freescale/ls1088a/ls1088a.c       |  7 ++++
 include/configs/ls1012afrdm.h           |  1 -
 include/configs/ls1043a_common.h        |  1 -
 4 files changed, 64 insertions(+), 2 deletions(-)
