Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BD6C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 06:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C54382B20;
	Wed, 30 Jul 2025 08:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="oe6/GrdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0316E82BA1; Wed, 30 Jul 2025 08:35:50 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C32E82063
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 08:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvQRXBWaeLaYkIYqEypx7J75YqK3apocevVsjxLVVUJpp6y0K+LnZEaHGwxHwCKBvHBsrZ9EoQblRGLWadawkJ07xSC6IlzPmIhRY6zb76u18M9JP0vzf15Lvqz+PeqQY2h4vgXog3twogOvhv88Vnl8scP6zo2mZVqblxTqHSFPlIRNaYQDfx0BL4/cxhbDJggAphCCh3sjhd7EjVuKGqnO71dHmFY6L4Bi/fUPqyjQSZ6/R2e0Y48MzGzar977Ql/KZtPDF0Qzq9NiPGNIBZakokDPFreody7GaUVpCvWc3ZcAJZraHWGEH3LKy33gGnUNM16VDBwr49AWr/tm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul+mlrwBbiFpbb1+4B0zJdHJdLuNH7V84Kas71JoCHU=;
 b=roFmQ2UmItXl4HjXGogOoOu/YihcuB6PUbVGzN8CQFDLMyam5c2+g/zPdXgOl7/f0XuWApN+WcMmUj4jr6VgNvWQQkGeCMumMooqXowNQNM9yYbrKk4yY1+vbFxYVrlBhz/2B86GNIiCZgaMkFm8jGk7BhtLUe/RzrKWZrov/d6AYXUB084BAtoqptkJE7VdTm6Vc96z99ePdlS9lwGVBe0pd6wERzhmCIh9gFGZBlUtajphdNMjKZm9U7DQtLOAbHZUO8Gp8EdkGMLX5aI6zLI4Zzfk4zz3DCaRsSISTofmm6OyfLrYjLVpg9w71UtQohenlqgpkB//qVXElTTULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul+mlrwBbiFpbb1+4B0zJdHJdLuNH7V84Kas71JoCHU=;
 b=oe6/GrdIwcMq3J+PL/tHDQJe5RU+WRGBuRD9Tucsh6PKocQypV7I9Mtd2jmL5vm0YUACGKOdY7FOeoCghYJvkzE/MYB4wO391oOha/UV5mNFEjau7NN4PKV3k1SGk/kJeiHMbHrUPmKci9RF1y5NIvpXqrRLGzneX3+U+I5ks4YqoAoWZ/2S4UXv2x/N9UW9uInZ4A9nMjISozE1ZST+JeRAZ8WC+BFtBHeN49DuRAw4JYEqOrgcPcrc4++6nZhX/DPwigOeDBrB1c1Xl58FX0gIa2qBjpr4TLXtU41JF13gVZSB7oIXmNZrsA2Ql2CbCsBHMzj+NBBRvODVdYrO4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:35:45 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8964.019; Wed, 30 Jul 2025
 06:35:43 +0000
Message-ID: <e5c64596-b118-4394-87b6-1b121c801af2@kontron.de>
Date: Wed, 30 Jul 2025 08:35:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
 <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
 <kn34dabjpqywranhgrtpy77bmuviluhzgf2pgtdguqvgwk7e3d@3zud5czxsewc>
 <20250728102923.GA32387@francesco-nb>
 <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
 <20250728164441.GA15074@francesco-nb>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250728164441.GA15074@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3531:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b24269-8602-432d-3c95-08ddcf334e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlYrK29WVStTUFhkVW5oUXRWTGJQeldab0N2d1NraDFDNVoyeXFEUDRRUlJG?=
 =?utf-8?B?SU4rMkpBNmcwVGRwMzRCdHNTVlMrQ1JzN2pXem14TTJzanhrNkNJRXpDL0Fi?=
 =?utf-8?B?bTdqZG9GYW0xZVhqbTlZSmdhTHlHN0QyOVRUZXJpSHNKbFltZVBxNTBFUGxa?=
 =?utf-8?B?TU5GM3NSK3ZhN1pySkxBWEhtZUg4SE1WY0RxSkdlMUlRZzF1TWIwL0R3Umk1?=
 =?utf-8?B?QjE4emF4TDFNVXZiN2U5amtMN3MydU43c2NnOVpVeXZsTUt3Uytuak5XSjFo?=
 =?utf-8?B?cVY0LzFQaWdmZ0dBeDRjanNZUGRtS1pPcTg4SDVUN2NvWHlxUk1Vbm5SQjcr?=
 =?utf-8?B?aTU1d3djZVkwOTlUWkkyOXFTZnM3NUpHNkc2YURESFNLNWVpVnoyWXE1TzZm?=
 =?utf-8?B?NkxJSzBqeWNWVFpOMkpSWlBneHFlN0RKMlgyYXJjbkllS282V0V4dy9BV3RF?=
 =?utf-8?B?a2U1cnVDNVY5KzZYdUo2cm1GczBWOHBrb0NYVEZnVDdybGJlK2ZTL0p0L2ZV?=
 =?utf-8?B?cTBocThtakFzVWIxRnkvRnJuNHBua2ozNkdSZEJLQ2YvTnBTazdEd25HWEYy?=
 =?utf-8?B?YlNOU1NmNmxJelVJSkRLM1FLdm0xbEY5UGFNalRqVnpYQ1JsNlVwKzIwa3hm?=
 =?utf-8?B?ZWpiTTEwWm9xcEFDR2dKUU5aaTJBTG40ejVpM3p6VFRpdjVkRnpRd2xnbkFz?=
 =?utf-8?B?dk9LOFUvenlaOElVYnhudmVBYjA5QlB1KzJORVhpQTVockpnY3FNUzZjYjlp?=
 =?utf-8?B?VEhTcXhMSGVaZUh0ejUxUmcwLzF4OE1Tb1pVREE1TVMzK3dHbVdUT0NxbzR0?=
 =?utf-8?B?OXg0RmV5QldkUmltKzVWei9iV1R3WnQ5cVYvVEsyN1JwbEdsR0J3c3VybE83?=
 =?utf-8?B?RWs2KzY0cDE5ZXNmOUYyVXdHNGZDWEIxRjF0RjI0T0gvOVVhemFjY1BiRDlI?=
 =?utf-8?B?eFRMVmcwK3BNeFBKWEhJQVdGamw1L3JBSkh6M1RISGpQUXVYTC9QMThYUUlz?=
 =?utf-8?B?NWtCTkM5b1NKaFZ3L3RhOWdMdnVPdndyajNsTXpyKzQ4VmhGUUJtaGtHY2lR?=
 =?utf-8?B?QmFzd1lKY0NLVktkcGFHR0xubTZmMFplcUpDV0xFV2hvc2RzSEdIeHFva0FE?=
 =?utf-8?B?dkR5SzJkRzlaTm0yNit5eVRtcC9lUyswbmx3eEMveWNjUEhDNmgycXpaa1pp?=
 =?utf-8?B?c3cwNGhRMEtIdUhPckZSeXhBN0RJaWxXTUVybDF3YWI5RHFWZVk3N0pMclZt?=
 =?utf-8?B?WnlVSGlxWGtpNm5yMnUzNktub1IyaVFVSVZDYWpHaW9zVnltT3I4TFBiVm84?=
 =?utf-8?B?WVJWQWtKM2NIWmdXZWMwSllmVXBVYmkweFNZbnJtZFozQjlBUm0wOW53VnB3?=
 =?utf-8?B?aEdiT2QwdGRETUt5aVViMUwyUWJSc2c1cVhQMDd1RlVWem1BQ0ZEdVBVd0hO?=
 =?utf-8?B?RUFiWVl3M2lzamM3ejE1a3ZwLzZGN2dtTjNvZmtlZzZGTGpGVFowYytXdDN6?=
 =?utf-8?B?b2RrZmF5M20zTnoxU3A0RVJJWUQrVmt4Q1RuUTFjdGxDNzUzWUF2NHNuL2Vx?=
 =?utf-8?B?OUY0bFJ0bVBZVXU0d3AyR1VOajFFZzJ5bnZuTVdIQU1WcjJDdm5hanJ2VkVi?=
 =?utf-8?B?bHJ4YjRUTmhrM0hoamErcHd2UVc4bG5zT2NTUE41d3lRRmJ1VW9USUpqODY1?=
 =?utf-8?B?VHNSVHczNy91b0xGbzBod2d1VE5Qd0lQYThLQms4R2ZtV1kxV3FRZ1ZiLzQy?=
 =?utf-8?B?SmZOcGVlZ3lkNXMrZDAvclk2WG1MTGN1ZWpNenJVWm5DUkpaY1hyQjdEcHpo?=
 =?utf-8?Q?XBo23GUbUlMiQvY4NueokC9FTkvWx5cFP+kSM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0pqZHhzbjNUK3Q2N0VKVHBLcmZUelU0NDl0dTBCNkhDejd4T3JIU2dScEtE?=
 =?utf-8?B?YWkzU2wrVkN1OTJHU2ZqNjViLzFLUkhvc1hpVDVXVHpac0tSN3NpaEZnZUVZ?=
 =?utf-8?B?ZE9Rcm12L0labUNQT1llZXJMRC9NelBCbEJ0K2d1RkcycDFUVU1TRjlFamhk?=
 =?utf-8?B?aEl5aWdsRWsrRU1oOVo0dkMzdWZ4ODhZMGVjbWJLT2NPNStDaXJXZThwMGtH?=
 =?utf-8?B?SkNIUVMrdEJTRUdzWG8xTDB1TXQ0bW5aTEwzak1Kb1hBMExGeWpIN1VuZWo0?=
 =?utf-8?B?bCtnLzZsT0JMOUs5eUpDR1h6OWFCdldvNklHZG5teHVCemdCSVA0eGdyZWZl?=
 =?utf-8?B?d2tQajc3YzlCNjNYQlQ2WE5SZEpEem9VVUNhY0lCYzJzM0o0Z0lOMG0vdTVi?=
 =?utf-8?B?VEFJK2RROFdJZWhnQktPeDM3UC84YkZydnZsdURmbTk5bkx3T3ZUa0xGaTY5?=
 =?utf-8?B?QWYzY1lqM1dlRXBSZFd4Zmg2NjlkaHA5V3FCSk45dFVjRTZvcnFmOW9Odkpk?=
 =?utf-8?B?ZzdDbnJKZERibEQ2Qm1FYVpqWE5GaE5kNmp4RDMrbXV5L3ExQ0hzYXJNbllH?=
 =?utf-8?B?R3M5dy9kc0swMHVMaHVLVVNtNVA2WklleS9ZWnJNaVRsNERKcTFnK3JYMXh1?=
 =?utf-8?B?RENIZjVjNEZxSG5EMCs3RW5vUStlU1ZQU0UwSGFTRGVEaFhYMHNNRnNqSkhz?=
 =?utf-8?B?Vmt1UHJDVVZFN211NXBoWmdtNzRLcWZrQy9jSlA1THA3bVF4WVpOKzZhZXBL?=
 =?utf-8?B?U0VXZDd3Sy9rRXJzOXhsSFlnSFV1MUZQSVVEcUhrV0tKUlR4Vkl0b0pRZVZZ?=
 =?utf-8?B?bmpMK2F3QXQyVjNxUEVRMWxrMWJBNU9ybmFORmhVM0tnZFMxZml4YkRPTmNk?=
 =?utf-8?B?dzJFNDVlRGVPWVhTTnRSVFJ0S3RtWnh4elI0YW5UZ0plc0dUVFhhTFMvV3lB?=
 =?utf-8?B?QzBUMlZqLzNXMFh5b1FjelZ4VDdFR09ZTXhaNXNUaCttcXo4cXVFWnBPUmR0?=
 =?utf-8?B?cnN0MlQ3VlJ2K3JsWTR1TUtkdTBEODZNNVpvQU9xdlJhRmJ1VlF5MTdBU0g2?=
 =?utf-8?B?blZpY0xpd1JvSzFleXRCQkpvVlpVMHc0S3N0YmhaWE9NS2N3bTVMWE9zTGQw?=
 =?utf-8?B?aU9tU1MxOENPRStrUlYxRFZqb0VndnROSTBHcUZQWm1iQktGL2tZTnJUTVVJ?=
 =?utf-8?B?Q291UnlXZTdIRWl2dmJURTBQNklSWnJjaWVMMFR6MkFCMllaalJGMFZ0T1Rq?=
 =?utf-8?B?eXBJVnNsbGgwN1RVZENrSDNReWJlVGJ1bzFmeDZsOWpSUUJKY0d2M0NTMzRl?=
 =?utf-8?B?V1doY21HNjE2bjdZckM4THZPcXJSNEdaR0FkZmlwWmE5bm9IRGs5dmJYMGYr?=
 =?utf-8?B?dUE4c1V2WVBYSXViaGh4bmxDb29Id1lEZ1pIb3NJcDUzb211ZERxeEFWNFEv?=
 =?utf-8?B?QjF2cDBrRWlZTzlRcUNhN3BVZFYrR2ZSRGNYMHRSbHhoV1F2M2VmTFc0N0l6?=
 =?utf-8?B?V09VNkJXbWNoemI3R0NiQTJzdEx2dUROQ25aVHN4WVpFY1NiNDBBTzZ1bzBG?=
 =?utf-8?B?WUJXSm1uOU5XUklVbFMvTDcwZWZPelM1VHN6RWxJNTZSR1NaVndjeG1Pc3FQ?=
 =?utf-8?B?N1Y2NlhZb1V3ekFVd1lvbWJ4YmplclhDeVFzdm9xRVRqRXVEWWFTUGxLUitU?=
 =?utf-8?B?T0ZIdzhGOWQ5SXJUTGFxSUtHdStuajhKM1FySkZ6b1dEWldFTW15NG1kRnBO?=
 =?utf-8?B?akJGc016UWhXTDVZblh0dTBjcnRDWmkycklxaG8reWNkUkdQVi9SZ21xa2dO?=
 =?utf-8?B?ZHVqcWMrTm1OMUo3VFFDZWdvN0VUZElwL2lQcGdPcEhqSEIxdGJIU2NmaFhp?=
 =?utf-8?B?dzVKcGFEWXI3TnF5VUxpYjNDWEh5bHozdU04QTkyb0tmdkFzS0tiUXIrRXMv?=
 =?utf-8?B?UnBJd211M1FlZGc2WE5xSkNUa28wQ1RlTTRDc1o5eWZzRTJHczI5QWVRanVG?=
 =?utf-8?B?cjh2TWVPRWdKVldscTJ2TEVoSExMZkwyVmxEREw0NE14UE5lemFlR0U4OWI3?=
 =?utf-8?B?SFZXZEczMXcxMUdGQlFuUXNiOHFBNzh0TDUwWk4raFN6WlpRYXEvVVluVFgv?=
 =?utf-8?B?QlJzeWd1NjZCdWsvVG9NbWtHY0tjK1RMMFo3UlJCc2ZldFNEYzVoOFlJaUNa?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b24269-8602-432d-3c95-08ddcf334e93
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:35:42.7984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVs9mt+yjWV4z7Gt8NqV9/mk4o3NJW5K3Yp6E7Xdak5dzvm0y0GXlAAPqRRshMww4QYJMc+cDZdyF5q4U7GI1LwuRpXvbWdsgSTKlcM8mRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3531
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

Hi,

Am 28.07.25 um 18:44 schrieb Francesco Dolcini:
> On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
>> On Mon, Jul 28, 2025 at 7:29 AM Francesco Dolcini <francesco@dolcini.it> wrote:
>>
>>> You worked on a similar topic, for imx8m, some time ago, commit
>>> d175982c207b ("imx8mn/8mp: Allow booting via USB"). What's your opinion
>>> here? How should we fix this?
>>
>> The solution on the commit you mentioned is related to the
>> i.MX8MN/i.MX8MP boot ROM implementation, and it works there.
>>
>> What confuses me about João's patch is that it was not tested against
>> the mainline U-Boot.
>>
>> Can U-Boot mainline boot over serial download on i.MX95?
>>
>> Adding Tim, as he has been trying to get USB boot to work with i.MX95.
>>
>> I don't have access to any i.MX95 board to try it myself, so I
>> appreciate some help here.
> 
> The issue here is not specific about USB, this is about code assuming
> that the relevant env config options are enabled without checking
> anything AND assuming that ENVL_NOWHERE is working as a default in any
> case.
> 
> See also env_locations in env/env.c and arch_env_get_location()
> 
> Francesco

I have the below patch in our downstream fork to fix the issue mentioned
here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure if
it's correct, though.

[1]
https://source.denx.de/u-boot/u-boot/-/commit/d175982c207bb2ace592d7985cd3f05ab99759d9

Best regards
Frieder


From 49b028284e36eeb7516f618e31bbf569956295ad Mon Sep 17 00:00:00 2001
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Date: Thu, 16 May 2024 14:27:39 +0200
Subject: [PATCH] arm: imx: imx9: Allow booting via USB

When trying to boot via USB on i.MX93 it is necessary to specify
the U-Boot environment location, otherwise the boot process simply
hangs (unless CONFIG_ENV_IS_NOWHERE is enabled).

Specify the environment location when booting from USB.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/mach-imx/imx9/soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 829b3b7b748..5bb0ab871ac 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -808,6 +808,14 @@ enum env_location arch_env_get_location(enum
env_operation op, int prio)
                return ENVL_UNKNOWN;

        switch (dev) {
+       case USB_BOOT:
+               if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+                       return ENVL_SPI_FLASH;
+               if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+                       return ENVL_MMC;
+               if (CONFIG_IS_ENABLED(ENV_IS_NOWHERE))
+                       return ENVL_NOWHERE;
+               return ENVL_UNKNOWN;
        case QSPI_BOOT:
                if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
                        return ENVL_SPI_FLASH;
-- 
2.50.1

