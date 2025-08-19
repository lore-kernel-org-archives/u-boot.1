Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6AFCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D334480FA1;
	Tue, 19 Aug 2025 09:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="HkAbVCZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCBC81E13; Tue, 19 Aug 2025 09:14:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2AC8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/ymiyAuvij09RTzWjyvgk/a6xSd0JiBIxTMYB164wU2BPPQmOXSbD2d/lOAjjiKbku94Bp/yLbx9YDwOvgxGzNKzP0xWwEgasOab+Bpjp/Vm35rBMSDvOrWy5naPj4k0ip/QrtYn1MkQ9ncNls2i64zDKa4ERetwAXLPM+LZnof64tQFnCr7hXiyEszAVZIOxzPgA2qFc3696HDgzOLSQkxi2uadRqh7ijnm+cGG8K8ggkTsMujUPHIG7plEJzQhP1D3Fa1uFc7dZr4CAbYENgWV5ox6LQe0rGZiDloRA4MZ+2UMNpjqkY2970YJgR/aMJRnQLnADSU8E2PyM9HHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waCUIfJbc+sRI+XYFNoWQBvk9A+fGenvoWexcfwbi9M=;
 b=RMRFU51lYMubcfMEdc+546SOvonGNLq46oMddgiDPT4H1kANZqNel4vyzD1Wul53FEGf75lv3aK8KOqOIS8A+MqL5sLeqXYBcHg7ejqmbljjrnPB2XIhItKDaCaRCbESbwYUILfFV4NC0cAPtONwPk+5Il+p9+mr6Ju1c17jdEE4DqX47Tt8ju+l//9FZLuCwb0IWo1jW5CC4zQQ/PSFPsSq6AZ9n9bSsJnbFfmIoRLa6VNVhrXW5zxwQw2Qeid3FjtWFWn/xvQgfA9XQSBdnTtjQzHg2qOFhboToatU15wixy27C3INf3ozo1QGvPCv5p2h24tIFKziQo3qjZfzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waCUIfJbc+sRI+XYFNoWQBvk9A+fGenvoWexcfwbi9M=;
 b=HkAbVCZdzSs3jM39E9dXcTe/2E5VE6H7ZKQzRlQAYLu3hY3TQOARZoXC7m8jd9CH72fmcBkz/jNbtGI0fnq6flQ/d3fJpQzumlO1v7OrbWw8YgC8Q0MT8GZztjnKZPPY8JoTEJYLIFQxtbVXGGNfOa88QaYFIHDMqOUbBam/mpplUFfLbsbQ74rWJXt1yEkUqJ/1PqD1C6M7H3P9qaSSexwg45yeM2vTBgEaYJVIQA91LTE/myrfZU5Xyo92QliJkyNIM6andmvBpo3HfUeh5JWKNX6G96wQ2jKICtJDSo1j64dgadXipl4a0q7pYDVJHYh8rkeU0y6rpi73fd7MQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:14:16 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:14:16 +0000
Message-ID: <f72b868d-0c73-4a51-8862-1add2c3d0e8a@kontron.de>
Date: Tue, 19 Aug 2025 09:14:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/21] mtd: spinand: Remove write_enable_op() in
 markbad()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-14-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-14-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bac4e7-3bc6-4194-47b9-08dddef001a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG9HNjBjMitLUE50bWxhUEZoZzN6M3NGVmZ5SFNZZmtQbE5STitZUUdvaDVH?=
 =?utf-8?B?V1g1bVpTdDl2eGo2c2hzbEkrdHBrTFdhQUxsaHJKZ1ZKdHlnK3grK1FvZjRR?=
 =?utf-8?B?YVNEcnNSU0d2ZDF5Ry9Vc2pUNFBpVUg5cHNYU1VISUxtQXBjZWdwNXB1b3lR?=
 =?utf-8?B?WEo0QmFnVHV2R0U5eWhKT1BiR0IwL3BuOE1KUmJpb3dvUCtMWUo3ekJVa0Nn?=
 =?utf-8?B?d2FPakk1QWtXRVgyaXlQWkdBQ3ljc1BwU0NrTHRTaHkwMURKU2R0SzQ2c2ZT?=
 =?utf-8?B?RkhlZEtidC9sNzlRamV2bGUyMmlGLzdzbXRRNE5lYmh2WmlsVUNwYnp6Mkd1?=
 =?utf-8?B?RUs2K1c5WUVtOXorQjc1dUV4L2g3YjlZaE85VHlxWXF5VjY3RDVMcmRZU1NE?=
 =?utf-8?B?QW40dTlPdnJ3eWZQdWFoOVJuSmt0RE9LMkRzL1lTMENRSWVoRnVhanJkdTVl?=
 =?utf-8?B?RlpZQ1V3SE1HL2NUOEpOMDB5a0hyeGl6OFFCOFJhWU1aSmVUMU9pbFEwUnhj?=
 =?utf-8?B?emFxSHNtZ2ozako1VEVlTExXOE1WbGsrTWJDTzd4aFVVQU9XQ1hxcWhZK1J3?=
 =?utf-8?B?aGIyYys3Z2R0TklSTEk4alJEdDBRQ2M1T3ptYzNUMloxTUZ1dlhZRk1DUlJU?=
 =?utf-8?B?V2hYb0w2WHBIRHJmNDVJWnVzUlk5S201Vm4vbGJiMkVxdE9NdGJ1NmNXUDk4?=
 =?utf-8?B?TkRJUy8xSG5EVXlVTTNLVWpvS1hySU5kUS9QUXpBQkQ3VkV3d29BQ09HQjZ0?=
 =?utf-8?B?NEFCeHgzdTVJTkdacVd6QVNkVW9seUpDV29tdzRqbUwvNWZOdnRObjU5dmRq?=
 =?utf-8?B?UElsaUZ6UzNLUGR6UmhWdFJFQlVuYldxTzRYVk5hMFY0QXFzbk5yTlJNMUxW?=
 =?utf-8?B?UHRoTjB1THNWV3ZUNFduNURGQWZNNWt5eGM1UktKQm1GcHk5bnRieDZVOG1N?=
 =?utf-8?B?UFU0NXIvMk1kYUdUeEFYTDYzL0Njd1ByaUpXeHhjbVlhWE4xN1ZIVjMrK1Fi?=
 =?utf-8?B?eHJCYm9CNGpOcXd6M3RFVk1TcEF3UnNFVnJDWjI5M3poUWdIdXNuY3NBNU9a?=
 =?utf-8?B?NFJIdzZTRG5KamN1OGlWSi9iZDV5cisrbGduWVUyTHg1MERpcG0xQ1lqeHNP?=
 =?utf-8?B?bjNVeDNsMlFyN21IZVFHMDVtdE1td2I0eG92cTZvN0RyNFVzQTg5RjR4YW1t?=
 =?utf-8?B?SUlqMmlaNFFTZ1ZDclRROHc1SURCalA0UXZabm9QOGVwamVweENjeFFIaG8w?=
 =?utf-8?B?NmtEVXV5MHFMeXRIREtienI4THRnb1h3a3VMVmx0ZEV0RWwyWDBGK01pdnBw?=
 =?utf-8?B?SEtNYTZNejBTMkxidUtQVUJNMnIzZENEZWZXdytFUmdLNTNud3VwRWlPQjBD?=
 =?utf-8?B?WTJOYzhlcCtMdHFVMTUyYk9EK3FpM09zcnFOTC9rbFFvamUwZ2NCUjE2RXV6?=
 =?utf-8?B?cXpDaEoxTENZaUJZcXhhVG9MWmVJWlBsZW9jc1RkajRxcGlPa2gyR0hzWTg3?=
 =?utf-8?B?YWx1K1hwZ01xNXVDTmFqcllFTTVIWmV4MUJNMWc1eUROeGh4Q2JidXRMdXU3?=
 =?utf-8?B?Wnc0RlE1bjd0U0RyNTNhY1d5WDZDZkNkd3luTy91dnAzbWNwN1ZEemZtUUZv?=
 =?utf-8?B?UjhnRXpwRUpweVNoRmJ2Q3Z2RGRCeWFKZHl6SlhaZGhXRGxrbWtuSHRCaEIw?=
 =?utf-8?B?TU5pdXFJYWJnRE13ZWVSRC9PTkluK2hsb0Q0MnR3VlI3aCtKMy9ZM3BYY3Aw?=
 =?utf-8?B?bUpVd0t4Z2hUSkRWcWhQUk5aZ0xJWWE3THZQV2w2UHJPaUFJT3lHWFhyQW1w?=
 =?utf-8?B?TzBnRG15ZlRtRnhXNHhHd2JIME5CK1FVdy9DTDZTV25wdWFqT3hnR2JFMVRJ?=
 =?utf-8?B?OGZSVGo3cTNIT200ZlN6c1JLeGx5YURIaUY4ekJ0N2wvbHF2UTdxVlE2NnpV?=
 =?utf-8?B?VTlKOWh1MWZaWm8zOGErbUYvUlhuRnUrMjFsVENBVk5tTnJ1NFRGaUYyWCtU?=
 =?utf-8?B?RmdpMWhFNkVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1lzT1RmT1Q2MGlyZnpZVndaVy9QVzNYK3dVZENYZ2NMQ1JxOVZuNzZVNkUr?=
 =?utf-8?B?a3pPRGw4R3lXWVRJZDdrWlhvTElHQlNRM2VEU0RzSnlOamlmdjUvMmswTXBk?=
 =?utf-8?B?aDNPUklLYnlzcnpRUUF2SGg3WWw4SEQrK2dLbDNGSWJGZHBsZ3JWM2lONVhD?=
 =?utf-8?B?cTZhV1pFaythMFhkN2hraEpUZG8xekoxdHhGTkRxQ2hWQWx3eXFMYmFYdnhO?=
 =?utf-8?B?KzdBcVgxMXEvQ0ZzUzFmT3VVSHFCOGIydjFRR3Rwcmt5NkhLa2ZyTHg4R0Vy?=
 =?utf-8?B?dm83dGpRdUxoVmc3Y25KK3JGTTByZ3F6eGoxbDRWeTFZZFlpRmZFS0FObjh1?=
 =?utf-8?B?am82N3ZvQTZMK0lkMG5Mbm1BQzdKQlZyUWZYM3J5WmljTTRpSzZkaktuWGtl?=
 =?utf-8?B?VDZFNTkxUVZMOGEvVm1QcnV0THRFdzdUczd2WFVzU2xDZm1DVHdkMnZqSWdQ?=
 =?utf-8?B?N3U2Z0xGSnAzdURjbUFXVWdScVgxQVphaDZydmJOUFJqWXBlS1VXb0hrWENO?=
 =?utf-8?B?T1ZXY3EwN2VXMHFhb0ROdGVRWWZ0TUJja1dPcm5pbTZGbU1RSmN4SEJtNXp0?=
 =?utf-8?B?WFQ1RENKRElFWTEzalJobzhvQk5FcUtDck5VSTRZdXFMOGxHelhuSjlWV0Z1?=
 =?utf-8?B?T05JZ0RuU0pZV1JVUXMxWnBDeXFiWG1DcmtNekM3dExhYlAxSDNrOGx2UjhE?=
 =?utf-8?B?RFNLd0hzYVBPZ2JvdmJmMmJkWDJZK1o1SkZreDQrcThta2l6d2VDNlQxUUZz?=
 =?utf-8?B?TW11bDhVRlNsMUR3ZGpuLzhhckdvWTdDdWVxa0hFRDFHYndSSFRPTXdvbXcz?=
 =?utf-8?B?QTV0ZW5waE1RZXVQWjk4b1AxbkI2d1YvT3hKa2ZLVHJ3amc5V2dpOHJ5TTRu?=
 =?utf-8?B?MUZJMUNjTHdTU1ZINk9KdDRDSzZuMnFKVnN6ek44TjBKSkQ2UFhDUHFGT2lL?=
 =?utf-8?B?ajROaUV1UWxlRnVITzdIQnpDS1hqbmVybnlLbjNaQjlydzhkaVU3b3h4NWZ1?=
 =?utf-8?B?RzhSc1h5UG9mVHhpZVoraGNDSjRTZCtUWFFnQXpTcHViRDNZcmtWcDh5dFZV?=
 =?utf-8?B?MFY3YTdHb2UzVVhBaUd3UVppM01WbE1wZU9TZmNmWmx3UU9EWXFoTDJGbXBO?=
 =?utf-8?B?amoySFBOZWhOT29GSXZ3ZXY4OCs5bVNnb3l1RGVVSkQ3WHFpWUVuN3VWeHFB?=
 =?utf-8?B?TGMzVVJyZGVaWXpzWWNkL2FYTjlmTlp4VXpGL00wZzRsREdPb01reXZBQm4r?=
 =?utf-8?B?YXpaWHNWTXFXeGVvdHFkb2RqMEJDdEVyTURDbkNuM0xIMGsyZk9tUDU0M2dO?=
 =?utf-8?B?WWdmcENHNzN5TWxqK2VuL1Q3Z2s0Y1hzNHJkV2xWN09JdE9uTlZNNDFSeVpq?=
 =?utf-8?B?UENFL1M2Y0ZGUzh3U1hISGgwdDVGWTBnajE0ZEk3aTl3cGp4bmJwT0w1L0c2?=
 =?utf-8?B?YkRpOTg0bnd5aGF1T1RYYXNEaVN0N3pkc2dGUDBicFRBSkVRdlFvTkpySzlj?=
 =?utf-8?B?c2FwdU44Ly93OGdJbHVSVjFlSDg1RTYrSDVoSFQwWGdpaktWR3VISEZkMEgx?=
 =?utf-8?B?MkVTbk1PeFZ6OXFrREZmcU05MENwYXp5TkU2dGsrQXpHU1RTc2hWUTVTV2dl?=
 =?utf-8?B?YXJCV1JyUkhRZ2ZzbjhvUEtybDgvbXNNTkJsdkZ3MCtmbWFNUERpbElEN3B3?=
 =?utf-8?B?KzhWb1Eycm1CclRiQkJqTzU4Z3g1eGVHZUYvUHE1THZieFlEam1rOWlPUzIy?=
 =?utf-8?B?ZVhIVGdha09uVmVBaE8vQjM0U1gwWHpOMlRzMHI2blJmTVUxczBoN2Q3WDhL?=
 =?utf-8?B?dGRNWW1RNm81K0xQSkVzZUxWWVJXTDZIVFVUcEZ4SVY5TXJsQTNNR0UzUDdh?=
 =?utf-8?B?MTFIR0hKVEdxbENEWnN2UU1kMlcrRUlDOXJiM2MwTGEwemNlbkNJS1JDR1Nw?=
 =?utf-8?B?T2tmUllNY2ZQbXVCMUJrajR0anc5UGYzNHY2VmN4aU1QNE1kUVZJNm5RbVgx?=
 =?utf-8?B?RmsvWHF5RWQrNTZ5V3FqK3V3RGVQd1BNYXNSQjVDODNqYjRQaDZ1TStlcU9L?=
 =?utf-8?B?SlpxNHY4N0hXMFdxL0lLRlVybkxDbkUzcy90UzlwT0JKTFFzYTlTVG02Slhq?=
 =?utf-8?B?a21WTmNDUGFxODBUZ1JYS3VUM2ZDUzFWa1FEbHQ4dkhxU0lrTXZHRGJCak5I?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bac4e7-3bc6-4194-47b9-08dddef001a8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:14:15.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlmah14WqGNt4Tk6d/jztq8PezhsWmSIBALtmH+sw/5JiUK34Bj33eqaNUS6SBEGbvXoXEWc9psIzGKt4P1BkFdvziH4oWWDJGBZzJivJxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> We don't have to call spinand_write_enable_op() in spinand_markbad() as
> it is called in spinand_write_page().
> 
> This is the port of linux commit
> c6858779f1f5 (mtd: spinand: Remove write_enable_op() in markbad())
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
