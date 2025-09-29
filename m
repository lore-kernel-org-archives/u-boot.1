Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD2CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3DE8341C;
	Mon, 29 Sep 2025 08:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mFNB0MTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCFF800B1; Mon, 29 Sep 2025 03:33:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C9080819
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvBWubzYXbvZugIoYGVD6hmPKi7rXNqBuofBrY1lQVjMrcelqpQKfmOhyRxYNANiRZSVJPJTjMuVk/BDALTftaP/QpjiuwZSBQ8M2CvoWozFU1+f6xgHtgoG95BlvUKYmwXbvxpskafjUuCmmZeMtUTh0yZ2Bw4Jm8xec6MP2MCC6Ixv2+VMktUnTvse9j7yZ/gjRa0R0xN+iiRnK6YyjyE210BqRc1WfQdl7a95eioXgBNWyxqpr80nT+rK2yqVWWXH6QjCgDkmtBblIHmgzTG1zjswE1arNFJxeCqSgK7oSdcxIKlq2pbWchbcvu4Jhzyb1nEYNro8XwuIX+gYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb6y3ymwIy566ejESCgXZyBaHXgE06X7pl3yzIJeCm0=;
 b=XQ5Ez4v0ptJQg9DHLEwmYr/yHAObXvvplynGItfvaWkK/E/ho9TDnzUQL+GOXb+m3sztx0JUpbKlPMEc57fq3Pnc/cX73McBH3PQ7u+maqctwEDm4E/k928YexpZibKI9i6laNYdn+BtgBY4vxtzjPi0D8NbSRXlC8+bKUZBg5X0HjTZycr8I26xyyfaf2KVZ06dxhiHSAuslsZM+NpAyQ1hIo0xUTMgPm0xECeizxpdLe223jOUkSKItlA0UeyZ/mZlcD63VbbPgoVzJiJ++AC/KNF79osPkCRScGAIHWv9RZR5MDAEsGfQWrIRYgKjMP8heN9o6rd+nTrxyoo6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb6y3ymwIy566ejESCgXZyBaHXgE06X7pl3yzIJeCm0=;
 b=mFNB0MTOuXLT9GbbB8AxOP0/IiF0yzp0mk6ilzRmyDYdISwf8qbMIsfKAhlSh7EBF1Qbd13hGhF9GssgCcDp/w70HOZJyjXv9AOPyRx48/yn08Hbty+Gix3IVxRj9gmNO8Le/j4rJ8zvBj/72byDriC461XXgzLDHLgYdEEJGs6gY63BNtIuAP+g83Zfk23NjuHtiPVfco8fgbeWeu86UxD16NCIujsuzlm9gQJZQU1xH+ZyC8Kl7iUxQNQ1yfS3CQd0JGMCW+YyrNb0AXVuCV0pCT4ocMFetf5GvKJhZH1LSQxMNpJs7r9ciM4FA56beUZ7gc8ITpC8Nk9ildVGkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Mon, 29 Sep
 2025 01:33:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:33:28 +0000
Date: Mon, 29 Sep 2025 10:45:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] include: completion.h: Convert the rest of the dummy
 functions to macros
Message-ID: <20250929024524.GC4184@nxa18884-linux.ap.freescale.net>
References: <20250926153128.3680800-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926153128.3680800-1-trini@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f8bd24-6f65-4925-af24-08ddfef830d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0jFqhuiVXOzc/EAxf+g45dS7/6EYhzQydROXZhg2jOiiT59NKe+CWWY57HsU?=
 =?us-ascii?Q?slYYG/qnMe4KZBkYrhlJUsH62Ow0SRZXNcpI15fE25ULfycYv4RC3wki6o2w?=
 =?us-ascii?Q?0eNLn4C0iKCmkFFpMakTgySAP35SaObCMUg37XG7WYMOqnF/CB4Vi9IC2WAT?=
 =?us-ascii?Q?kJcs/qxfN6fpdAv2zR+sPERSp27jGzrEFfxxndqZgjPvUJBnn0lYBsqJsMOJ?=
 =?us-ascii?Q?V0DGWsgXXHXMYA6zOGzIyfTL860w2fSIxiRFCGkbRGalguKpvHTNR7KjG2Vp?=
 =?us-ascii?Q?AdpxPa0VrVNjBMLMZ5PegnLJtpb2Bh5x9aO+LRrPSa4UNCD9nVy34o4zMj7s?=
 =?us-ascii?Q?kS9ff0euh5J5StlKh0auBUM5qCFuMr6yn/oSYj23gTQycCxpqpbJSv8nOVtp?=
 =?us-ascii?Q?lXclRT3mYR0bodIBJklgmNt+z3o9Q7SuTaTevyzI2UNokCMv2ODYJAyvTpwI?=
 =?us-ascii?Q?4FiDxXx3/Yn/o6tcX8pORRISGABwzdXaz5ELnY/liaX6lGJ55okj/lkV/XBT?=
 =?us-ascii?Q?wzNq5+d7gLaMNYREsWCyTZz48A4GGj3IHbsR+ZN28+be1TzWNiVmtgz1spMm?=
 =?us-ascii?Q?oKdJLW49wAAwtNtIsYuuLAOzgEF8H6r47lWqLDK8GTVoujkqdJX03CAOja87?=
 =?us-ascii?Q?XFSz+T8gbrSoVRb3SCbY/XZb9kE1S7k/vt/9CcMk6Qtm2F14XBx8bL0tpcBF?=
 =?us-ascii?Q?Hjc0TdMLe1mFQyEyr/IiRvmJFnDsx57oVC62iVwQlUo4GwVgLRNsWvOm5Hpi?=
 =?us-ascii?Q?CVGusEq1ofKQx+TvF6GwG3XLL7gI4BlQ2OFsWrNSioAHMT4TcECsLAhOGUGk?=
 =?us-ascii?Q?1fgnTdMlD15cnkuudsRJBzHm8k9FEUCaGajZ6qmq2ZQhlw4gA1l3XmJFIrCL?=
 =?us-ascii?Q?349m9GiB/ua44KfVVG0IyohZAidhDjSNUy5iXcWkB02fp5jgZyKEymhjRheA?=
 =?us-ascii?Q?zv0Lm6ChWmQI91gld75dYQeD3nM/HpIIwMaXHN9ksB+sqpcrFdVEQkL57JEY?=
 =?us-ascii?Q?rCJuLuc6dR8D33gqmPQF5stSst/qXJGlJQhHzqsc/CxA8Cz5ARSCKt7fPzuw?=
 =?us-ascii?Q?YCWLNR7RyLWEOWaOdSdNvxfaV1T0VyLXzjhgPwVUC/ErwRdvquuAVdcEbKRo?=
 =?us-ascii?Q?BJuuwTL5D+uu6NFU8tBa9ZDGExU/ordzHOpSn1XbdwYpMGo14gvI2srN5msp?=
 =?us-ascii?Q?1jco++kURdyXxA3JuZ2spvh70ZRRv8ay7/kmhOQhdg0M1pqxtjSBn/G0Qvfk?=
 =?us-ascii?Q?veSJ7wV6Pf2xofImsXqG4Uy45FqbES5HnJdeUjeiwZztPpI40C4Xmy2QL7wd?=
 =?us-ascii?Q?nj/8pSfzup83pWeL7ujfi2FlumnCjWkezuMYzI9LEvrarmqvtD86dCcyqDqY?=
 =?us-ascii?Q?NE0zGilhov1sjS0xRHpKfJKoEGLAk3nTmXK55b5YCZyrU142F1+/R3JdwWBi?=
 =?us-ascii?Q?Mb9XwGpNGnuh64F1seCxmIqbfkJtOUZo2WPItj4UiIWzg3tl6O3k8NmEhepu?=
 =?us-ascii?Q?pArploY3q3zdZVhij/5tLaNtTOoDR1An/Uwv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbeXez8NE3Uc6CC/KYmr9smrU6/B7NUUd60syuQdz9ChAeDKEqCWiJHDG+vx?=
 =?us-ascii?Q?SRCKNfTmvB+uyOA/mo0j/bXLkDTpuY7zgUQtQU+eO3Fp/7dht8wTP0+NKf7A?=
 =?us-ascii?Q?CbRpLrZeFWFcyCmrNsiLlhRMq7Ke6Gwlk0gu+xAWQdKH/cexV2vdiss+4FYi?=
 =?us-ascii?Q?9NG30HLv2n76V2+NV++S6KefAZY2XrCpNRYndWgik6iwRRYksBgsXlUmaICS?=
 =?us-ascii?Q?n0KGps6k52Vt7S8Eq1CIzq6TZc9yuCVK4C515LSnrcPKhln4+H1WXToyGne3?=
 =?us-ascii?Q?4xkZEX0+fke2mQ3DQBoijrjJgcK+iiMLmmLhMofd227B8WgyIkkCu0EgnXhU?=
 =?us-ascii?Q?wDeTjQ5SJN8ATrEQc7CVa07Mvo8ncx2AX/ck4gUAVKdsqkwC2DNkjNHKe+Bm?=
 =?us-ascii?Q?KjC0U2Yiz7fZXB3Hv7MWwxoPNimWRiid/YO7gqs2YMnd7sOKCN2EBMA1dRJL?=
 =?us-ascii?Q?MJ1WAzLUMi6VMALbeLkIOIDuZChVQgOwhy2cZosH95iBYNzEWSVLzZ3JBE9A?=
 =?us-ascii?Q?AyyOaRzrDoDB6GIN1Np0XU2YFAQwznjEwh7VmuVQqPCYK4+3KU+wWiMcPiJu?=
 =?us-ascii?Q?Qw7OJef7MJtVmIMn/pSCDVTHBj0/gSMegABLCj2cUWO1N+MzgoL8k/AAgJK/?=
 =?us-ascii?Q?eUM5Lj6nq9y9iA3jfXSueHFNKEYr5c8d5Mv4iNPJpIJS2Y5Um2Bf83len0Mv?=
 =?us-ascii?Q?y/QwG+oIstHCfkswTIuPjQ1yta5zQMcZqNIC0/dhyH8tJjCpf0hf3F3YIFOx?=
 =?us-ascii?Q?DWt6GZlZMQhS0Lqrr3wFUBphi1bURmMqULgTG68ZT2SM8V0fQsWr7mcnTRw4?=
 =?us-ascii?Q?czJtZxg+ywyNIjFxFYdrKZfEy49gC/Pub+sa1OQWgAmwVvsjfXbUNb7pBSDH?=
 =?us-ascii?Q?R1adrrM22lShxqfZXHWpRd3pGrTs1ZA2w+nXTiNzFTAV+YaPbcS22HE8SEnR?=
 =?us-ascii?Q?kvegt8iuuuiCw/gkTXgVUaM6PSkc6olqRu4vGze+059cThagePeHh9M3MZTi?=
 =?us-ascii?Q?C7NUZDv7MUmIMqsnOiATHj7TEsvyp4qTC+aQXyU9Z2c7daQ4l4mkbHuI0Pj/?=
 =?us-ascii?Q?u9ao311tbzfYVNVs1w8nArewyaYGMVPoTz8KR01ZVFvejO7maC8reC0GTwG0?=
 =?us-ascii?Q?UVxwemM/ToOpnJ5kGBMRMWCtrt7EZKI9yUFMDO7S6kK26E0vx28TMf9p/gZD?=
 =?us-ascii?Q?aCyZC63FemtjWO2ezBrLyBTz6Vu39VB3y8ZVGM692p599bwUsQb8dHYzMQcC?=
 =?us-ascii?Q?5x51AoW8YdITin35gZXfICfFsLDI59l2j3Y7TPxAO31JY5Dr1Lm91f+MVfZR?=
 =?us-ascii?Q?gkCaRxrF/vmpQDijUh30vUeJg6McL9BxVRbC0FVeVcx+cyd2egUhacKgkb+y?=
 =?us-ascii?Q?9CcP9ms0BVZpmGRjxS5fAO3/zZI+4dV/9jYV0xsdG/t/cznkSbc90gRhqaW7?=
 =?us-ascii?Q?GRN55w/p6RItjYLwjOPNjJNIC2hqfFqPb0rK+7KWzHoRGbiM3wjCVK+kUKP+?=
 =?us-ascii?Q?fFQye/TKhs5HGzsHPyG4MBwFrbaEVY5QRR3Wnkrrr1GIml2lUh3MPB+RuS9v?=
 =?us-ascii?Q?8U1N1g1+nH+JQwwjemJvLFN2c1cEUXAcx05lDV3m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8bd24-6f65-4925-af24-08ddfef830d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:33:28.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivz0VpSTDTcYrWxSLYVLRmNNqSRV5ebKUV+xPpY3PG3k/PhCja394hm70ItbdZGcbK5G4bUnuQrQuuubOpXrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Fri, Sep 26, 2025 at 09:31:28AM -0600, Tom Rini wrote:
>While we declare some of our dummy functions as "inline" we do not also
>declare them as "static" and so it is possible for the compiler to
>decide to make these as global functions instead. This can lead to link
>time failures in some cases, such as "allyesconfig". As these are just
>dummy functions, convert them to a macro instead.
>

Sorry for my ignorance, why we not follow Linux Kernel to use "static inline"?

Thanks,
Peng
