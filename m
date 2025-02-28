Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEA3C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B328142D;
	Fri, 28 Feb 2025 11:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uL2t9g6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C3A81100; Fri, 28 Feb 2025 11:55:51 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF018118A
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJqUQCIfzX0F/h4m5uPF09l8ycPGxGZcwnNVmVpFIfHG+d5EqcDdqXDKulESevY0eXqs2O+0DoHDh3f0ZsCFkZ3o1oGsZMXzzWeQVguuw0Ms+4wWl7uIhJAxT7R5QLUxdMFhka6xyrvpeuEVuc4OfDxRNCKB4rdGlb1SFkw5mU4Z5NvPlyOu0IrVtDBZokzT0NqZU4b6Hg+z59ar7hO98NeqzJY/C9YgzXEOzeq4FcYG5PzqRfO8+1ga62acldw+tOIMX2SQgN+fFGLLQIY/81wUeTffdA2tK9lb4d/VDBaAfX7WTUQRwfqy0Jj4HbLIQDa5QB6krMI1/9+QRKZ0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ME4kj2ycxj4YbGXpHBZmyHzkyztYw9L/EvWT8K98rw=;
 b=C2spof+QjiG8iZ5ljJsKLbNvXHLjDttaCXcAbe57RQjxvs7wuQQHwDMGJIiM+2ELXSpWmNeG7Di9xMES/UMsr16snXO4A4VPe4i4z4NfhrAYmm8ZM0t4OKM/dpF7KnUURaC1bv+Uq6rbD2CqUzjuX4HBBolstt7xVzCt0ZVlVDSb2ZNvxZdyRDIlCi5mfYrqJ0cIuWBwi6Yvlu4WsH/aQFCAy7i/IRRqSNTEfV55xySbohhe/VkZT6HppTk35EKAeUh3iFOAGKzfAVCK74GmIrc0bvukpVOFhe8aQ596rGKrxYvgCgejq7viWiWs9yodas78C66aVaJywGYaseE0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ME4kj2ycxj4YbGXpHBZmyHzkyztYw9L/EvWT8K98rw=;
 b=uL2t9g6JDSGm/vxOm30BISYL3xsUZUBalih5u1wzMrarbpO1l9nxHMpNlcszMPfupz+SsQIvjDETVbC0me3jEN2isFblxO8KUr2d3XQ5uFCihnCs7WBwI90ADzlG2XD0shjU5aXIkGC2eP3/lgR2C6CAzph82xPS2yZJw8YKKN3Mr00AhBdY1xABsQ7XfAnfKR6DCmfIbekOPDCtjnaI1rQ4X+p4aBZ+8oIv7xADHhcAeUUEC0uIQx1klRDcQkP89JN5wDRq/M1ATlOThq/9m1ROs9PeyGIKllbKb4mfpm4xlTK2WXHMOMh/3t1Q9ZR85hR+4OrFjkvbrXkoCnTTNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:09 +0800
Subject: [PATCH v6 18/20] doc: imx: add document for i.MX95 Image Container
 Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-imx95-v1-18-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: e41e95f6-7295-487c-0153-08dd57e67578
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXMyemJwREE2Y2NlYS9LK3IyVGRPNS9VL0h3L2VYQ2lWakUxc0cvY0dyYVBH?=
 =?utf-8?B?M2ptcHpQMkZldE5pS3h5YXUydnVHYTNmWTljTTlhem1VdWlodFpPbkNOY1U1?=
 =?utf-8?B?T0QyWjF1b3NHb0JRellPM3plaEh2OTlET3dDV0NQOE4vOGdnT3JoZW1GbVc4?=
 =?utf-8?B?SE9mMDZudklPdlJybjZscnFFUGJKeEt4VG4rQ1BwZUM4RHptN28xbnBNZGMz?=
 =?utf-8?B?YUZmN2lNazRKOG9DbndxWklEd1MvTzFjU3M1U0tCaFF3NVU5K1JjNGJQdTdm?=
 =?utf-8?B?SHhMZkFyVnZLczVydHNsRmJWNDFNNGNjQjhVWkxJTHZHZHpHRm1Gd2FQSFps?=
 =?utf-8?B?MnFYMVYvZWRROWlhWUZBZVZtZTNuWTkrUTQ1SmJMUWM5ZE1XdGV2aXg3YklY?=
 =?utf-8?B?MnhVVVF6RlV2TFBUVDFaRzUzei9XNFRmeXRhaE1XR0JjMkFYM3JpYXJzazdD?=
 =?utf-8?B?L3M4NFAvSWw1Y1RCWVFMNUlTSHplc0tNZFBTM1dkL21GWlFjTDIwN01IM0VF?=
 =?utf-8?B?N0FsMCtPNkRTRnc0TUtDRmJsV3pYQjZIQ2ZmOFRBY1V1Y2w4MStvR1ZjWWY5?=
 =?utf-8?B?dWhRVFdhL21NN1RydXZoNDFUTDBHZ3hZcUxEM1psVkNpYk9yZ1ZDVE5haFpJ?=
 =?utf-8?B?a3JNM2doM3RHdVN3L24zOTdFNDhNejBQSWk0RWNDT1Q2TUlBSm8zZ3dOTmEv?=
 =?utf-8?B?eVB0NGZFWFdHa2dwME04Tng3OEhndnVjQkh2UHFvWGIzeVhqVjlpWTQzTlVZ?=
 =?utf-8?B?Y25QeHBDNitZZGUydGZjY3NEdHpuanJSN3VoWDZtMncxVTF5RUZ6VXUvUGZI?=
 =?utf-8?B?Ykx0UkIvRmVCSVpYbUE0STA1dlZFbVViZmZxZ1Y1Tm85ZmRYMHY0MjI4U1c4?=
 =?utf-8?B?enN1Q29vUVNhMUxieUh5NURZUjFGQmUySTdLcDhSMlkwbzJ5WHluQVhRRjlD?=
 =?utf-8?B?T2lZVWpJY01qekpSU0JUVit1NDhHSVBTZ3kxdEsyTmZRVm9NZng5dWxUZmx2?=
 =?utf-8?B?eEpiblJUQlB2VmkxcHdwMjJveEVvTGxJQ0picVFTa2pUQlNCN2lqWUFIeUpS?=
 =?utf-8?B?RXRVTG95L3VpSzducGtLTTFqUFhraXdseGhYTXRQNEZnVzVpZjhic0luRUtu?=
 =?utf-8?B?UXhQYUhLUDRaVVNTSzhtT3RjZTZxR2xCUjI5OU9FVnd0YnFPQ0hvTEVXandt?=
 =?utf-8?B?Q1hHTWlKTkZwR3FaQ0ZsRk4vN2wwaHlFOGNvQkhCRnE0RDY4ek56QXIzcTJj?=
 =?utf-8?B?bEFBVjl3OVI1UFNPVXRDZ055L01Gb3dCUUFiWElmRFJUd3I5ZUtsTE1UMEFW?=
 =?utf-8?B?Q3psNEcvMDZ6L2tIWHBkaTJGcFk2SGEwL2ZYL0I5eWd1Vm1GOHhKTWM2Z1B6?=
 =?utf-8?B?LzFzRmszWFBOWFM2WGhaRnB6ZlVaWkQrQTZMV0hZZDFFUzFUWHhHY21pNWtw?=
 =?utf-8?B?KzVXWUpZbk1wT2lHUjlwWEZlaUFTMXJGSXVxenhFL2R6NHd4NE9IQnBwUzd0?=
 =?utf-8?B?WTZxa3J1MjYxYU5MNkc5ZG9VVFJzNXltRXpkZkIwRVp4SmNaY0k4V0tWNmNp?=
 =?utf-8?B?L1FsczBtSGNIWVJCbnlHWHBxZU5keFVwbkJ5MGw0L0VEWXpsckJwMUtuQm93?=
 =?utf-8?B?SDIxVWY0eTdOV3FPU2I4eWl3clRqOG44bXZDZGVnV1FrMTM1NUF4V3FJNFE3?=
 =?utf-8?B?V0REV2J6bUdSSHAwMlphNE53eGFZMVJ2Ry9GRW1GRk9WaTB1Uk1oV1dINlVV?=
 =?utf-8?B?U1lrNzhqbGtkeVFQYkJnc2pmNWFIRWtHeEVMRFIzbVg0Z3NRMzVnQi9lcmpq?=
 =?utf-8?B?a2xGVmpuZU1ZY3dMbDZCM0lnNktUbzh2NGVoSDNQZmFDZFZyNDdtMzJmVFEw?=
 =?utf-8?B?amdhS3FkRE9XYW1EbWQxZjlVTTRIWm5RZjc4eFh6bGJYcU1IZ2xocXlRLzRn?=
 =?utf-8?Q?Mtw2duECF6haNCluQwpj6JyU5LJxSYJF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjM2SSt6bkR0M2pVYmZSTmFrWmYrMDRGbXdhalMrZGxDTFRMNkoxSks0OVJW?=
 =?utf-8?B?NGZCZ2dyZnpvYlpndW9LaHMzVE10MVc3dE9HRCtwRE82YUtJREFVNW43MWg4?=
 =?utf-8?B?SDd5UmloT2x1eVVJQmljb3NIbWhvUUFPSFN5dTdEY2hCS2s3REpuV2NxWDhi?=
 =?utf-8?B?bzdjdUFkeG5IS2lxT2UvR2s0N3RaOEtuUlo1c05XRFhQWTlvdWxFUzJpVnVJ?=
 =?utf-8?B?Tm1PZktoTzVkQVAzcmRybjllVGE3UTBEYkdLT2RMWEFFaDlhU0luUjVZSXdT?=
 =?utf-8?B?M3FPVjIvMWFkbFpRTHhvRzJkMUd4L0J0cDVIdndmWFFrcWdrbHhBL29lbUdJ?=
 =?utf-8?B?NitGR1FNZHZ4eWRObXdTcFFDc1lOd0twVDNNMk9YaldQeis3Q2oxV2ZTaW9x?=
 =?utf-8?B?VjR0aWMreEUyaVN4VzRITTUzZnVDdHVpVU83cjVMOVQzU1c0Nm9FR2IxcFV5?=
 =?utf-8?B?M3R0VmhFOGtqbWdDVjJWWjcwSmtCMW1HZWl6Unl3bFlQVzdWd2pIVVpBOGNF?=
 =?utf-8?B?b0dCcFZzRElCUU9ZTlpnaTR5UlVJeTd3UHA5VnBWdEtwU0VPcnRVd0NuN2RS?=
 =?utf-8?B?amU3TnB1SmFaSHJ5b0NFWWJYdnlTYUYwb2ZJeHd2NDR5aE54VnB0ZXI1Mi9r?=
 =?utf-8?B?SHJQc2w2SHJIYkNWNVhtM3VaeDU4cXZxSlY5NWx4aTJxanBXSmh3aWxiMWlU?=
 =?utf-8?B?a0hwSC9rMnAwTHVFNVhqQVhvQVdjUVlwNEw3SDZmWHVrSE1RTzZjNzNadTBE?=
 =?utf-8?B?SENVL0tCYXFtR2tRdmtvbjBSY21nZS9HeVJCOWRvQVVjZEsveGp1QW1lK082?=
 =?utf-8?B?NklDZ2VLVTdEY1R0ZzFTN1VSSUVEWWgrcEQzUjZaNXltWE4ySnhvd0tzK1BE?=
 =?utf-8?B?cXA1OHZVTGxUSndNTExhNkdQV2E2d3M3RkZEcnFoeTFGblBkUnZZa01iblRy?=
 =?utf-8?B?NmZhdmNKeXFkeFlZRURnaEdvQ2N0VVBtQlpkRW9vVkhEYk9OK1lsSU82d1NQ?=
 =?utf-8?B?bDJ0Q1ZJQnJFelZ5TVJsQWRzRG50SnNmT1ZOcU1HaGFIU25zbUcxckl0K28v?=
 =?utf-8?B?ditXNUdPcUhJbDVEME45MXJSNjFuM2VMMWpUMWR6VEhSSDhLV2pqaVFhZVEx?=
 =?utf-8?B?Y2FObFJUNVROOVdUUm5mWmhNcC9MQmFHYmNGY0tURmI2bkg1MmFnbDUya1pH?=
 =?utf-8?B?WnVjeW1xSjlhOTc4VUI0UjIwTE1wZjJzZE1uZ05iM2VWenArUzNHWFMrajMv?=
 =?utf-8?B?TStleE1tVGdYV1dYbU1vRnFPQzBmVERBQkN3SGI5M2FCU1R4aVFWTVJ6NWk3?=
 =?utf-8?B?eVM4bG9Od09FVjN3VFJzL3hONUF6RGZzZEFpcFN4Q0hVa2tQbEFHSk5YajF4?=
 =?utf-8?B?T1FsanczQmhReVFuTERxN2tqSi9ia01hVTNaNExGZWZyOExTZWM3b24xQmgy?=
 =?utf-8?B?YW9seFlwKy84UnQwNDNwZTJiRUswb3FodjVaRjQ2YVdyS1JZd2ZMcjBPK3hB?=
 =?utf-8?B?SHQvMmdLOUxOWERUamF2YVk0Vi9DeUNJRjJVUnNZWFUvZE13amhCYzd2enN5?=
 =?utf-8?B?OVpUZzc1MS9lb0pianFTWXA1dkhERHFkU2kxdHZsWSt6UWs5UmV1YUdCOWpZ?=
 =?utf-8?B?OWRkbnhBUkh4VlNSWUNhb0h0N0tlQXlFRzZSZVZvbXdsZE9LclZrKzl6TUdm?=
 =?utf-8?B?Z21XcVhmR1lHcHlSclhDZ2w2ZllkeXJyZUFPcGxGdjM3QTFlNDZKNG9ZQTZT?=
 =?utf-8?B?NXQ3bndIZTIrc1BnUGNlMHZQbnRMOVFMOGk1YjVWbGFnUVU5UFIycHRyUFNs?=
 =?utf-8?B?bmIyZjNRR0drUmthai9OL0F1ZGFlbFRBNmRvQ1JzWHpERWp1SlV2SVhoZFhJ?=
 =?utf-8?B?ZFhFcXVtUXh2aXVHa3VZdm9NN0E2bVd1dlFrWE1WeFlrZnVLd1FJOWdvTGF0?=
 =?utf-8?B?Q1ZoS2NQejJZUUN6RTVRQnJ4VHlIcHE3dUFocDdRaHo0MXAxTUsyN0orYkd0?=
 =?utf-8?B?SXZHcys5Q3RUVkg1NVJkTDdVRjdwWE1INmJkZ252K1FIT1VrTjBTek9MOFBT?=
 =?utf-8?B?T3FRdldyREZOTE56U0x1Tkh2WXVpOFhNbkhTS3pCT3ZZTE00Q3Vsd2hZbkEx?=
 =?utf-8?Q?FaUbpLT3hLX/z7yFSHPzK5b+6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41e95f6-7295-487c-0153-08dd57e67578
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:48.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQRRm55ZO7CltGHbMU1rpy9phJNaHLHct0B4sqTqLbIE00pCq7sR69zlW0zPdUknZyoTUj17BjfGdgrKC/y1eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Alice Guo <alice.guo@nxp.com>

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 0000000000..2ad5734506
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Conatiner |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Conatiner     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+

-- 
2.43.0

