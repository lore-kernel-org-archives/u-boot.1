Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C7FCF34D9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737AD83F80;
	Wed, 19 Nov 2025 16:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JopBGHWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE5B83F85; Wed, 19 Nov 2025 16:29:25 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A43183F62
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJP7LTp4o0KckubePzQPFT9t+anS/9jX0frnE7moNY4+nwVX+ADrbtKOTbDafPhifxnkeSRxuGRJO+gVr0uvH+4P8Msm8IzIVfwVH7egpG53URHuUrYTO43Gp/w9o0sef7Ro6+O+LkB2xrzZTXo/VMl+2XYRedXZxyyzjvETEcvG3CWvZh9bzYUDVJ7H9Cs4IfVUJQn/8xCwYhSYoV6UD5prhIZVhg9mm3hEbUragwZnz0Jqc9HujYONB0ncY9nTxDmsnRHXb19JWi2M/8fWxCpDUW5JJCpoTDUjSmh+89zoBB+ucEUUon8McwBDTyUtYftF0k8xQjf8ZyAvVY67Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPR54koyRdRN9vzSoC3ooHweX2ZZaLsMtLDF169wp28=;
 b=emmtsguhJJFmHuAOEF1WmoLj+OidcOwbaoUrdnVFr1OgFHd0lvSAJ6vxYNB5cykAQHY75KRqJlT+bdz26cbYuqQEwF2iLgM+p13iR1JsASZRPsuWDe+3uVLd21Fn5NdfJpyY8awhfADryMJ3JLc28hCvxZx7/bBdMQ0hQi+pAKoqHtihrosMz4x5eDZYyv/rOpwMBU+C/vjIITR1f0QEzlLhgtAV2Ou+5nbDCahkKfZ01E8KbZYoXGvPXdw2LqjnAD6DGmv0tfnzeMLUV/PXKGIM0OcujJ4W+C6GQ8XrwWRClXvOH7NGy2+ehMiE4kDNvNntMCdRXczxEhLgo6r9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPR54koyRdRN9vzSoC3ooHweX2ZZaLsMtLDF169wp28=;
 b=JopBGHWWECIbFcZG8WrvKrIjsvDQDkJzxtOvOSCS6HzOJlKxFAaYiB6Zqw8w1dIk2i/ZA05ZsmQVReZwVDIcpPZ2iZtbvwRwZd/RKqaxjFQXZS9LN0trEQBFrCizNBD2uErDnnd9vOrC4B2TQZvyPQNdejc5zYzbCyGx7IAIaX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:29:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:29:21 +0000
Message-ID: <4f0169b3-10ab-4610-a3db-2020c41aacd2@cherry.de>
Date: Wed, 19 Nov 2025 16:29:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
 <DB9PR06MB8512FD168E1197521BDD445DCBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
 <b4e389fe-024c-4eb7-8c5b-b27188f50b48@cherry.de>
 <DB9PR06MB8512F93000C1876567D017E0CBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DB9PR06MB8512F93000C1876567D017E0CBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: b8033849-b967-4b8e-2e82-08de27806957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0w2K1A5SkRsRXFsTjlUZXFrRFB4ZzNpVk5mT0ZkUURzRnJRWDJmQzBJRUs4?=
 =?utf-8?B?ZlFrSzRnL2t3aHV5NkE5bWVHaHRaYU1qVzVDKzBTZU9nbXFJejNZVk1UNFVE?=
 =?utf-8?B?d2c0RlBpQVh3cU9hcUJ4MDVSREdjNURza1FoTS83U2RKbkxaOTdrTGRxK3lz?=
 =?utf-8?B?enBBZW8xVmRReHZnYWZhTVJuY2Q1UHk3ckhnZkhOK0N3cXBJZEEwb0MwajJh?=
 =?utf-8?B?SkxOTlZtdm1CY0FCY1Rtck1Ka1VhcnpHSW9RdVZJejMzRkNBMVpwZW1ieGpD?=
 =?utf-8?B?Rk9CL0lKQ0QvaDYyU1BWUVRyc3c5aVFnWWI5WElHWGh1S0l1MTVHalVCQjND?=
 =?utf-8?B?SzJQckowZUx6clE4OGdFODN3L200L0lYT2dSdTVabEJQMW9mdC9FNG53QXZo?=
 =?utf-8?B?YzFJTUE0V3FNSGQxWno0WXhvdnhnZ1ZrbjhDZWljaUxGZ1czZDJHYVlNZXl5?=
 =?utf-8?B?YkZiZUE5MzVkSDhLckdqbmhMeUdXMDZkQXRUS0Y2bGphSThsS2VwQllHYzJ6?=
 =?utf-8?B?WjNPWWhHczlvTTB0Tm9IVHBwYXhpRC9zb1dTM0ZZWGVTUlZxN2Zlbno5cndj?=
 =?utf-8?B?QVhQRUJ4VmRmR3kyaVNrZDFaWS9aNzJGN1RJaHhtZGZPMldUTmdreHZzejdL?=
 =?utf-8?B?cXE3TTRuT0NDYUNuc1JaUHU5WWhiRmtQdkJNTy96UGtuNElHb2JjcWVOREhW?=
 =?utf-8?B?bGRrc25NZ1pPWVo4bEJ4Y1dXV0JBZHNCbTdqck9PYmZoNHlrM2tFc0k5cGN3?=
 =?utf-8?B?d1NPSzRCaUIzd3grZzUzWVBTVDVQT3JpUDJ1eHVYVlp2Z0o5bW1RbE1sd0sv?=
 =?utf-8?B?YXBob2xsWjdWNXRGbGp5WHZuSmpoaUNLQm0zdjBNM29IRXBQeEZkYzdKN2Q0?=
 =?utf-8?B?b29WN3J1TW1oTmJSR25LTkQyNy9Td1V1MmJFU0FIYk1qclY5bEFsbXdoRUJM?=
 =?utf-8?B?aTk2YVBBSkViOElVK2l6cjI1bHJKNEhDSTdvZEhmc3I4dGgzNGprbGUrbU8r?=
 =?utf-8?B?bCtVZFNIM0lsYlFTQkRDbzhjVlVQajRmNVhWS3dMYnNaR1o1anJ2STJoalVt?=
 =?utf-8?B?REhBdWpabWJKYW1jUlZBYUVnQjBqTmE2ZmQ0QlI3VnlTQm5jT2pIaW1XOEp0?=
 =?utf-8?B?RDhtM3doSGJaUE1OdXdiSFVBQTRuV3lBeDYwcVIwTVNhcjdIb0tKNHhOdW44?=
 =?utf-8?B?UURXOGlWMTlUd2hWbWhtd3lGQVpWNmZIYlFlN1Nxb0o1TFd0YWJyU0FVRUpv?=
 =?utf-8?B?V1M4V2xteVpQMDhsOGxHZWxHQ1l2SFlad2NXdmdLQzVzbW9lUUkvamlMTDE3?=
 =?utf-8?B?dXh4WkFkaitUeVVFc2U4ZHNpVmphMnpuTEx4UGZmVmlsVmhoUGRxRG13dC9Y?=
 =?utf-8?B?WGRZcGZZY2g5eW4wOWx0TVVMSVduUzl2MGdxTzJCbU9BSEtPbE9ZNHJuK1Az?=
 =?utf-8?B?TVFhYXpOK2pHbFVhZjhKeHZaSnprbVJkSUE3ZnZIa3d1Mm5KOU5iVXh3eklH?=
 =?utf-8?B?aDJNOVlLYWs3WXVvMzVFWmhPZE42VllROTliVndqRnNYRjFoRWx0QS9ZV2dF?=
 =?utf-8?B?WUNhZjFueWtuRG1Kcyt1K2ZNVGcvVzIySTBza2laem9XUzQyZkEyRmNNN3Yx?=
 =?utf-8?B?N1lwak84bXhORHZFeUU1WUZtZXRNNlVtejd6VVJBeWpOYXVqSktJVEFpYlJ6?=
 =?utf-8?B?WU5JaHhOUE8wbTJMK2V3OWZPZHNBdUxKUUQzUnRkTlVHc1RPT1I2azJoZllq?=
 =?utf-8?B?cHlqOGZsemN2MTZwdk0yTitMZyt3dmRqbDdQUzlGcnRSVUVibklpVXA3eUtH?=
 =?utf-8?B?QnRGZ1VTZlBGNjhhdU5BVHpsckR0UzNCU2xKMUZ4cEVTZGNhUlo0ZHROdjg5?=
 =?utf-8?B?QmRnN09wUG41Rm1qNlhQT3h6VFVmZTBlOEg2eDFnSTdiQ1B1dkE5OUk2bHly?=
 =?utf-8?Q?bCWxksZv6aNUG9ozg1irjfmMcvyqAjQQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVh1U2JKQ1J5NHVHN2tGWjRSVzNPY21NendEZHNwekNVWlR3azE4NVJBZU4y?=
 =?utf-8?B?QWNpbnJPZTlZODVNcXoxOFQyaGxQNWZBSlpTeGs1b1lReHcyOEhXbzk3OVE5?=
 =?utf-8?B?Y1EwWGg3aW1yMTYxa3p3K0o4WHlmdU5vTVNmZ2JrcnJ0SHVjeng5RXRLQ2Qz?=
 =?utf-8?B?emorWThBdlpZeVkxNDFZLy8rM0V6UUgxSHc1YjhLdXpieUt1YWFkYm9aVVpy?=
 =?utf-8?B?bUtYR1BIRFNZT3JxUjVmdUl5L09aNkFaWVBidUlLc0dvVmk5L2NSRTFUNjFw?=
 =?utf-8?B?ZzQzM0IwbjkxdlliYmtkNkp5MTlYTVZabFBHQVNPU3JnL0tRUzFPVnBrcWZN?=
 =?utf-8?B?TUNXR0s2SlhoOTZGTE5pWUIxOXdMVHI0SldvRGJ0alRzMGFnYVI3aEtmQno3?=
 =?utf-8?B?K2ZkME1RdnlyU1ZBck9lWUxzZW1pUDZXYzhDV1dma1BZbURaQ240THNvSlJ2?=
 =?utf-8?B?VmhMT05sN2FlUkltVUlUWkk2QzZYa0hlc2NvcXJ3Y3dLTGlOVFA2d1dMSUpa?=
 =?utf-8?B?cHY1cTk0OXdjQ0JYQmdCVWJuZVNrWWtoTFZmUkUvMDkvcEg1RytJRC9DbmJY?=
 =?utf-8?B?WE5zempndWdHb1JtbXNYM25vYjkxMTFyd3Z4ZFFid3BFMWxYaEdncHhiOVRu?=
 =?utf-8?B?ditjQTZqaHJucjJDNmljOURMdnRwT3ZmOS94dzRvTnFrQkZxd0tDZXptWnUx?=
 =?utf-8?B?d3NuNzdWbFpLaEpYYWxPRU1PblIycDRUMkxRVVZkSFR3QXN5Ui9kQWJ2RGh3?=
 =?utf-8?B?c2UraUdJT1lyaEdCdmgzeStDVUhYSW9EbTdNdThFWUxIcU9NY0pkT29CTGUx?=
 =?utf-8?B?TlhIUngzd1A4NjA3SSt0Qy9GR0RwdkZnQVQxRzVBa0JDNlFJd3h0VzR2bFhv?=
 =?utf-8?B?OUJydzlIZURxSUZFYzhQSHc3bnpVWDlrazcvRE8yU1huT1ZLcFc3YVEwNEw5?=
 =?utf-8?B?amhNajA0V2t6WVh2dFlUSENYbWlnN1YrWTdnZHQxY1A4ZnRRK1FacTdOWnh3?=
 =?utf-8?B?VldoVlk3RHhFVDZhWWVEdCt0bXpTNkRWTEdPOTl5L1g4a0ppRE1NN282TnhN?=
 =?utf-8?B?Q0hmVU9wcTM4YU01WWk5dS9TTFUybXFCZ0FDdDBjZm9sUUVvY1NaRWErTUdn?=
 =?utf-8?B?L2dzc1d1VVQrbEN4ZEFmQjE2MVFUWXhmVkx2L2FIa0UxVDJ5ODd6Q3dLWDdH?=
 =?utf-8?B?OUVRZDk4NXlhZ0dnQk9tZW5OUThwMlhkYm9SVkt6SXp5YVFmMVZrVWFvV3k0?=
 =?utf-8?B?THpkZDFOdDRJTUtyL1pnR0I1TFIxRVV1anNjZXhHbktYb0ptN2xER0VveWsr?=
 =?utf-8?B?MlU4V1NIT0FEdlVLTWtJN3h2ZlhsRzl4dzF0S0Z2TFhxYStuM3pSQ3RDSTR0?=
 =?utf-8?B?eVp1RXZuSVMyZGVWMkw0SWhnakpUYkpFdFA1K01Hc21vZWEzT2RJYm5ybHpz?=
 =?utf-8?B?WFJCSnFWWUcra3hrZ1FWY3BKOWJoY243dnJjeEFidzBtOVZ0YjM3YjAyaHJM?=
 =?utf-8?B?TlZLWGh5d3o2dm5OUUVUdnR2aUtuSWMydzVLZHJkd21TUFJ0S1h0d1p5ams3?=
 =?utf-8?B?QlhuaER6VFJhQkd0SUZyb2EvbWVmQlAxeXNZN3JLaUc0bE1GVk1pYmU4SDRp?=
 =?utf-8?B?eGN2Ukh0OFN6RXpQZnp2aFNia2YxQ0RkUTErRTRjRjhQYVJvaEZ3K0NzZFpG?=
 =?utf-8?B?cVJvWEF1TitldEhoRlRzanVMcVFpNnlsa2dOa1d2b3FmTXRoTjdJTTdmN3pU?=
 =?utf-8?B?MWZWMGxJU1MxRjMxVzJxekFOU29xMXRsSG52N0pYRTJjUGUvcmdQdzF5UU90?=
 =?utf-8?B?OSs5K1hCaFQ2MEtMWVNWenh6SVgxN0EwZWRaZEtiZ2J1SUtoTVh4SmhjZU16?=
 =?utf-8?B?TFV1KzlzM0luTDFKUEk4eUxROFhCKzRwUGJPTHI1Q21wdTZzOTZUdEpadFMr?=
 =?utf-8?B?a1RkTFR2Sy9RZlVrdkdObnRROEVkbTdReDhZN2tQdHpOMllUYmd1clg2MHVI?=
 =?utf-8?B?OXhwNU8wejJDMXBUNjRMSHZ3K1UzZ21rZC8vMEEvSnZ6bUljWnhXVDhMZnZz?=
 =?utf-8?B?YkFOVkRxbXZjNGRPdXRMWXd4eWZ6NUQ3VVBuRkJ5Z3VnZXBHNElWT1MzeHJO?=
 =?utf-8?B?SXpvcGY5Zk9kSldOOTFQY2JRYk53UWIzYlFDTEJ1cUxvaUlsUEhRcnBDb1Nl?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8033849-b967-4b8e-2e82-08de27806957
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:29:21.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txSCHDHoZV9LAbrKMNaeoRlqesg6UcdTlw83JlorDAIMd8tk11PvHLuE1/VkDINNT+LPZVQyEPw/lrM3Ju+BYxbdDZh3YLTO91nfyrG4pg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967
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

On 11/19/25 4:06 PM, Wolfgang Wallner wrote:
> Hi Quentin,
> 
> From: Quentin Schulz <quentin.schulz@cherry.de>
>> Hi Wolfgang,
>>
>> [...]
>>
>>>
>>> This description is quite convoluted. I would propose to describe it as a list,
>>
>> I'm very good at writing convoluted paragraphs, so thanks for suggesting
>> something more readable :)
>>
>>> something like the following:
>>>
>>> When `fit,engine` is set to `pkcs11`, the following cases are distinguished
>>> regarding the value of `fit,engine-keydir`:
>>>
>>>     - If `fit,engine-keydir` is not present, value of `key-name-hint` is prefixed
>>>       with `pkcs11:object=`, and then passed as-is to the OpenSSL engine API.
>>>
>>>       PKCS#11 id: `pkcs11:object=<key-name-hint>`
>>
>> I have no experience with PKCS#11, but shouldn't that rather be a
>> "PKCS#11 URI" instead if " PKCS#11 id"?
> 
> Yes, of course, my formulation was sloppy here. Please use the term URI.
> 

I'm now wondering if I'm not just going too far into explaining what 
happens to fit,engine-keydir. It is after all passed verbatim as -k 
argument to mkimage. The special cases for pkcs11 are all internal to 
mkimage so I'm not sure if fit,engine-keydir is the best place to 
document that? That could drastically simplify the documentation for the 
fit entry in binman.

[...]

>> I was wondering if you had experience with using id= in the pkcs11 URI?
> 
> Thanks for pointing that out, I have now additionally tested with 'id=%01%02%03':
>      fit,sign;
>      fit,engine = "pkcs11";
>      fit,engine-keydir = "pkcs11:id=<id-of-my-key>";
>      key-name-hint = "MyTestKey";
>      

Any chance I can get some softhsm2-util command to generate that object 
with that id :) I wasn't able to last time I tried with id=999999 or 
id=%999999 (since that's what I set the id of the key when importing) in 
the test :/ Possibly PEBKAC though :)

> There is one other aspect of the current solution that I'm not sure about:
>   * key-name-hint is an attribute per signature
>   * fit,engine-keydir is an attribute once per FIT description
>   
> I don't know wheter this is a use case for anyone, but I think if one would
> like to have multiple signature nodes in a FIT description (e.g. multiple
> configurations) and would like to have them signed with different keys, then
> it would only be possible to do that via the key-name-hint, and thus only
> via "object=xxx", but not via "id=xxx".
> 
As far as I know (but happy to be proven otherwise), this is not 
possible with mkimage right now. But note that I too was bothered while 
looking at what was possible with mkimage. In the end, I don't need it 
but I could see it being useful. On Rockchip, we typically only need to 
sign one FIT: U-Boot proper, and everything is validated by SPL before 
loading TF-A (bl31), TEE (bl32) and U-Boot proper before jumping into 
BL31 so there really isn't a use case here. The kernel FIT which could 
be verified by U-Boot proper before booting is anyway a different FIT so 
can have a different engine or engine-keydir.

I think we would need to use a per-signature-node Device Tree property 
to specify which engine (if any) to use and which arguments to pass with 
the engine as well (still per-signature-node; not using the -k argument 
anymore for that). This is something that needs to be supported in 
mkimage though, with possible additions to the FIT spec (though it is 
arguable). This would allow to use a different engine (or not even using 
an engine) for encryption vs signing, which we currently cannot do.

Cheers,
Quentin
