Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6091103A9A7
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0636683F6D;
	Wed, 25 Mar 2026 12:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dHSEXuNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448D483F86; Wed, 25 Mar 2026 12:16:50 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0C083CD3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxXKr+jDYzMgMdmjg8HGIyhGfM6cdRHyqJO/L4e6cxmWrefG+5ylOFtRYAKo6tjljVvXK96zKCCvs0f9e1ftSeC++HSJyukQ8qZuzfNYak418LsOlXZu+VBkXUp6TFs1mnA/lAibeaKw4STsM2cR6IM6+YNkq3aU83gVmh7BhEzKbTXnZr6+SVWUFVDSjo0iTpstdaFsuft1DaBkaCD94ht1NH/7uemKIpPysdu3jK1PiNlGE71kRtMv/Z+Wwk7Xd3owE40cS8GYrAeW6g/Nlk9sO6wWWIN/ZXoYiqp9LEmnuZ2afM5cNEjZigZPpKAbB4UxO3DESiWEYg2fFElczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+/lR6S/DiSC4ZyPvMd98nN3kMvt1qkZWnuFUu078BA=;
 b=c+rNsoXcRCqTq4o6sZWLlLGTl5c0uSipFwWPCuByIT/NOx3zQhWZrV+UsUBvUTIqlwEzRi7bkqZGoG4aRns2t/TO74PkurcGl/1OYy2X/XaG/UzlYY5DWJ1mFTc5GBgRFa9G76IZOw1tdeASefXk8DOTehaB+zyRv6uO6m+5CQKeNFf0feqp7rL/4LloDn6blob8qIiStleyt2tvpg3YZNuchfWQp6zNhgAtM+YO7KNPnDKGEoQh8mrTfaVuRTof+Us2IIIu+YPT35doZszna+zV3jP6eQDxxUkpP1Mf2vUZvCxzKI9zMGNs06OIZfGIHjxaCEuTiMAY+RfAglpP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+/lR6S/DiSC4ZyPvMd98nN3kMvt1qkZWnuFUu078BA=;
 b=dHSEXuNPQYF8u2pO9KbW8yJQMcPih1mbZbRwjv5MT4xnmuqGi1KawVDzV6MHE6dgj6PQdClMBuO4m3L9vUIMWpmLKQSPUILOfsO3BDqEp6dNcRCw6HaZJygp9TQXkdlKn8b0w3wjx1weIiWZcvt07A3sOOJcsC6kHIdi3z0XH3ZQHFKgoaZfGrB0/S3ysnQSVs2nQ7mEsHLEZyQIWhCETR5imoP2IxbfM3qz7eih7dASe8HoY59Mt3BlXxsjnUvEpgbqBYJk1LZBRw5aqJZSu7kDEg3wvSBky0gnbRPCo/u1gJhHPfHfe4oYZAC2BESMR2D1pKKZ+HSJffNXIauyxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:16:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:16:23 +0000
Date: Wed, 25 Mar 2026 19:18:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Teresa Remmet <t.remmet@phytec.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>,
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>,
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, upstream@lists.phytec.de
Subject: Re: U-Boot and legacy SPL power control on modern platforms
Message-ID: <acPEoC0W8DJMnYfd@shlinux89>
References: <20260320214518.GD502704@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320214518.GD502704@bill-the-cat>
X-ClientProxiedBy: MA5P287CA0192.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbb34b1-48a6-4e5f-394b-08de8a5ff2ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bq9GINZjvdwilAWs7d0NFSvPJh+9W9J+IVNb/nlqwR6T0qaceV2OBRpf5sdNgK2PQqtGRu1MDkdo8JNjswr1b+WgYJp5kdfBAfIehB3Q7dnxaOGo2ap+NI0DEQ0begm2Aa9GAFyIFKM585UMeRVZFO+ggC83qYj8NEqi+fHIQaj6+faMLf6KYgI77n3oCq7G5q/IKSw0rgo+J3oQhp3v5vuPehnDl+Dpu2EE71uozde6xh7YUbAeExIilmpbKKFLODvFyhv3WFVyXJCJ0JPXQrOdthRkDFpS1xyEV+xTWhKWh6gnCWT9XdTxiO7y3Y91NsmrOoxWvWHFhrlyiUxELc28OsIdh60yctQGkZmdJntvY4us6AaxH4Ir2EKkMmVi7lKuZv4UvP2GgAGfeO6wkyqKmisfeXQBYasZO/og3pYnTDUqALt+yPkMIdhFpE47JcH05JS7veThSOrV50XyTfimZ5j20l4Af7T9vtY+9j7snLv/euRsO2Mp2TkTHUIUsAULkWoVrOXkQg1HcWXi1kN76n6A7NbiUwB9R8yIxkA6JidemotLaElzEzgQFzyRajgwRIueJP/k3FbR4Sq8j7C0IwjvdAzWbtCI6GzALrcscH6gY9JBLzPRni1gKbz06PKd3OP9y/A0DMdut1YVOM3Q9d1XkPLNH1VK3wG5K0oZOU/hvPBjEcOoSOUF/T/sUR+3x+4kP08htO13U6xyFmkdytb830WsAdzn1sF4f35hYtu/XBQ3ogrgu3Fs9SV/rg/cQ8NVa06hVOQ/RLdC7RgfrzM4CNNBotjvR7guHlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSSYVCTujxZGuqGyucaHoMrxj5PQ/EB11rC6M+udXKqwTCbl88MXWkFRvLB3?=
 =?us-ascii?Q?tllsWSwat6kVsvSyE9HxPMe/tYuskmZKE9D0Lkkj10LScQWPTaoiuwiOfLhe?=
 =?us-ascii?Q?vOu9pxhzJGcv3qzh9+GP3BSiZATOCiBha6eR8Ro8IdgqD9w20aI2AdATqA8V?=
 =?us-ascii?Q?AEvA53/eipegSi0YrEd4Q6POjVaGjME1uqK8Ps3vyF/MBFHY7P4E8CEIID7x?=
 =?us-ascii?Q?PL7vi5Vj7AV+R5ZIX/C/afCYo+K+9dRTtk7PSwuMrYcCQUy8XEU/cBVbqkr8?=
 =?us-ascii?Q?Vh9eGs3yUJlJX61QVU6/+fiV/iqSD7GS81adzru+cdGZUr5lGlkH2OzubHsD?=
 =?us-ascii?Q?sGXYpKSrcVsXrfjC0kDYZe+kJmGKuz10f8Wtj4dVbCeP+j80M/F10q57BFs+?=
 =?us-ascii?Q?zwguyrUQYQQCeg+k8eToYibLiPyTATXDrrbiC/rQ/VtNuV4INeNHo1EIAkT9?=
 =?us-ascii?Q?PWlcU6gdgBAFXv4hUVGzarjUQibajOLBoaJNO2uGRPQ3X0zZ3HqHOjn3rcKL?=
 =?us-ascii?Q?QW5UxO6TP9s25Xe3vkDyZrwzXpgCZPm0bnKhTEZRkQllPu0AP+nOoDS+OCT4?=
 =?us-ascii?Q?uKzlRrVyAzYKCTzFzqSidQfW0qr9w9hCzVOL8nG2r9I6qR05F2qj98W1g96P?=
 =?us-ascii?Q?2gxECyvElhfsZsP4TgoFY9KwFJJSASv5lJmnMOZsh6cUpzPYd6su3mSc3z1q?=
 =?us-ascii?Q?egBHveD7LomJ1VEn4XTiNvD6BIkBW7NR+mpn7grk6/TlTyZLLh5vRU317VQe?=
 =?us-ascii?Q?lQY4SrR8DEhfIS7l0rx4C5eexYdkqICv/LFdrDvUkC8nCy+n1GI+glM5PK0M?=
 =?us-ascii?Q?G7guw46flMa9GsxG1BtrZMik5MMrGOjheix0tKs9KRSRezlKHOpdtYVY3M9Q?=
 =?us-ascii?Q?FBi859SsgalolS1i9V3dkVcme6zyULwbPfUqa39yiLhLB8t6exwjwNy0g/5w?=
 =?us-ascii?Q?jgwSVmCPwQHbP2cNmlSUQLc7z4AHM/z1spwSzySVcPTra7I4ZO90qjmGRkvc?=
 =?us-ascii?Q?f1BNIeIJMo+YHe/V6sRF+M/L8qCsKbqshHq4/vyCSqeAIE8gmUQilw4IiAiA?=
 =?us-ascii?Q?BV0hvgopmPWWYmHult9AeroI2JrgjdWUpSxfumMV9caSCXLwjv76bXr9ZcYJ?=
 =?us-ascii?Q?yzisP4E1E5gm2t4F9jcrOMDWA8IgXwbsBugEr9nQ7EhtbelxdmDQXrKxMY//?=
 =?us-ascii?Q?3mmCYPp6L61OfOA8UKjqZk9KpmLoEShC4Hra1c5jKJgroWlnhJPrRQBs0xeb?=
 =?us-ascii?Q?L+5l2YggEPp4gZvfEhu91Udo3Rb1OCegJ8mlChjZjyUuZ+vw6CeFVtjBT+cK?=
 =?us-ascii?Q?7XM9MBtapoysOYAZzG3cO5YE5Tjk8/Vyi+1tgxj41szwKhQX6+4GIErWC6+L?=
 =?us-ascii?Q?IK/i/aDIgDeSQm5Bp6vCSxomIOf2KvzbRyFjiwW1gf+hlSssts8QDKdH5pXC?=
 =?us-ascii?Q?DJVkTJbMMjMaTbiBthU58ncMXG5fBt5vEWhpZCh1OoTsxZVK8EJ3gZ4e2qa+?=
 =?us-ascii?Q?kbqk0s7XpfXPNNVfqNENUgVVnExqQ2D5Qs3Bojl+qoq85a5KuZU7VVjgUeId?=
 =?us-ascii?Q?S+LxnQtpnKwzjLvYo9VxaY4pel6v+w8LP+B+xLQp2DWhtbATpPJomgfxszAu?=
 =?us-ascii?Q?BOxhsVHYyk0Gvm7/LSUpowkR3Vk5Yjs5gSMRZ8DQGDcuCmsdB/MgXj5mnXi6?=
 =?us-ascii?Q?zmuk/P0HvJnHhNZgmFG1kVVsOhO16MCyrRq4KRVW3j0O3OVy34P3tfqKcuJK?=
 =?us-ascii?Q?/ifNBko3/w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbb34b1-48a6-4e5f-394b-08de8a5ff2ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:16:23.8315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ugvw1EXx7R6Ez3/Qy4B6OGtNJnatN8lNBJ8YPz1MkHqn7CAUI5JEGo9p0YExGrNOgdwsNHhFnLNgqKDR22b1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

On Fri, Mar 20, 2026 at 03:45:18PM -0600, Tom Rini wrote:
>Hello,
>
>As part of the work I've been doing on clarifying Kconfig dependencies
>I've stumbled on to a number of modern boards[1] that are using the
>SPL_POWER_LEGACY symbol. Can the maintainers please update these to use
>DM_PMIC, DM_REGULATOR (and SPL variants) as needed so that they use the
>modern architecture, or let me know what's missing here? Thanks!

For i.MX8MQ, I think we may need to leave with SPL_POWER_LEGACY,
the board has 256KB TCM, but u-boot-spl-ddr.bin is almost using all
of them if enabling SPL_DM, other SPL_OF_CONTROL and other DM drivers.

u-boot-spl.bin itself is 90KB+, but ddr firmware and hdmi.bin are packed
in u-boot-spl-ddr.bin, the image is a bit large.

Regards
Peng

>
>-- 
>Tom
>
>[1]: imx8mp-icore-mx8mp-edimm2.2 imx8mp-libra-fpsc imx8mq_evk
>     imx8mq_phanbell imx8mq_reform2 kontron_pitx_imx8m phycore-imx8mp
>     pico-imx8mq verdin-imx8mp


