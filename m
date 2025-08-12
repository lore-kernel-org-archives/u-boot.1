Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEF5C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDE38319C;
	Tue, 12 Aug 2025 11:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="NwynQaPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA20683214; Tue, 12 Aug 2025 11:41:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE6283087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4QwEhsMHs+9qbJW75wlpuujXwES3X9v5MKc4fqtlM3lrL9zWIHxGOuaeS1llyA44NVN0D/lP1Af6Py5Ip2UXcljFTrMdqKqMGvjmVSmbhtBdkQmDc3m3ET8U3scFFVAtOC7qaM1hUnqL+O5U6z7BITzfnPRgujIl2yidpFS7JTey5SA2fGE6lFFPOw75+nDFemgDQCqoXjDXbmv6iOx98DEnoJqEF9vS0H4mMLs0jyMK4wB2RFoZQcrFmREMI1//MCddnj4xxe716cIm+tdAr6IYn8Qca2YZHd3G6ipk3p1GPNybGh8PByuEGW43xZSbo6bWIAylK+H3J5ZpKqJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4BnP9G0RLWn8jMmeE4Kq36lc/SB1SiS0lO21CySXjw=;
 b=kPr90FZnu8OVys8QsapgMt0YPOv3fEXn7ZlI+jxvc0Mp+75eUFaPYJFJ8fzkcsbPiuRK2tUNASOUwHlFYmf6i6M6nzLUqRlSbq4xpnhdCKbKjeTQmAzfhnLMeWUu2z/ztJ1POoiS585cUXSqJHPR2Gcwry18dDkXA9C3ZmCODrqLqgCAyu9TencYkSo9oZZsHqOq99yt9LSDeyL6Wg8x2z8s80aNZS7v9GQ/VL+xpzlazc1WLaGMBtCYVdb0TTXKQb6dc8/jcPzaXhdxX2Yd0IP+a8tlHH2oL7UjdZ1Y4v7e/MlpGYusuzH43y8Oubb+rM61mdv53JWngyoxpE/8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4BnP9G0RLWn8jMmeE4Kq36lc/SB1SiS0lO21CySXjw=;
 b=NwynQaPBzWz/yqNTron5+5ZdgwoJGQM/5NwpmhahFeBrBur62DD2tPFCPy3RGtM/ZIoQnkZt16zumZZ5vtXXSEuynuRzHIO0Nl6Z9X+mKtVn2jCKWFTMpGto+kFx15Zbv27GYOmOgyo9HZEMN0NBAXm6wP4bBu4W2H9l1iMS8hyyuveq5VFZ8M5vEGd01fd7HiPbPizoBI1ueFh38NU82uJZp3kELc+xPuvFx1YPKuJQEuSoplylmWglX8HhnK3XSLOnDEteRWonUql75krAhVuHvI6YEu+AmcFMdy3KOoGJ1Vn+g+YFMqbbyi//WRH5TZYQMG8PFTGr52I3SjjDHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:41:42 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:41:42 +0000
Message-ID: <d15f32b0-5b56-455e-8fe6-7ab03df1bb0c@kontron.de>
Date: Tue, 12 Aug 2025 11:41:41 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 03/24] mtd: nand: Add a NAND page I/O request type
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: abb204b6-7bcf-459e-213c-08ddd98471d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVZ6K1hQNHQwT1BFNHFDMFR5SWpFK3FoSnBISEF0amt1MlFTSkw1RnJrWHU5?=
 =?utf-8?B?VW1sV3lwZ3MyeVhhTnl0UUdhbC9Mai9nU1lkd1d1RlF1Kzh3VUdQZVpJZGtX?=
 =?utf-8?B?TkVkWW5NRDA2MW9pRFd3MzBXNmpOb3Q5S050Q1F6WWo5YTMzRDV0TWR5UVRR?=
 =?utf-8?B?S21Fb2k3Wlg4NUlLdzdwblVxZXNaT1doZzhLbm5XcXM2S2loeXhEZnU5UjFQ?=
 =?utf-8?B?bzFoOXdlRDdGT3BCMTRwakxwbHkrWkVvblI2dFZBbVZmNDdQYzJ6emt0aTRZ?=
 =?utf-8?B?d3FTeVk1Tk94QWJ3Vkpsc3NhRGVDQnhxamVTUUpLYTFHcFNqUTJ3TG8zSEdq?=
 =?utf-8?B?dkRFcDdXQ0R6UEJ0bWpzRmplRmlZODhZdERubnYzdnZFM1F3RkZUZXdkSyt2?=
 =?utf-8?B?ZFRTWDBqekRyemdpL3hsZ0d3d1o4L0QxTzZDSWNpT3pFS1p5NTB3aXZrZXdj?=
 =?utf-8?B?QjhQUnh4dGlkeGROTDBiTHZhUG0xaGtEaG1PL2J2NEtRRGtvcXhZZS9pZ1ZM?=
 =?utf-8?B?Z1Q1THUySDduNjYwU1pGSTJSMm4xSzdRdlBPbkszRjhwcElXU2ZwVDNEd3hI?=
 =?utf-8?B?bDRqaGc5bG5TMXNIWjlZcWJkRU9CMmtoZVJ6RnVIYkY2MVMyY2NvQktNeXlU?=
 =?utf-8?B?S1RIcmt5NlhGQVQvZVVJbTlhSlJaZXc5Q3E5b1UvMk9RZlc2a1pmZUJ4SE1J?=
 =?utf-8?B?RHRLTFBwT0o1bm0yaVI1Tm12NjFub05NVzI1dzVKM2JuTGk0NDNjdGIxZnR3?=
 =?utf-8?B?N2tRZ0pnODgwallEVHpnbzFZQUhDYUpSd2ZtQUc4UHdGOGNKbGtLQlpvT0gy?=
 =?utf-8?B?MXVNR1pPR3RaYnB0d0h2OXA5eGw5c0Q4Tmw4U05UMGs5NUp3Z0NYVUtOTFFT?=
 =?utf-8?B?d2Z4aXFzdWxkbTBJNjRCWjF4czVnQXdXRW5KMUk4WDBQU3NiL2VMK2lzUldC?=
 =?utf-8?B?RVNEMDBGWEptYzcwd004ckR1N2FjWmJTa3NSTTU4bEVyRmpNNVFtaDZKb2g0?=
 =?utf-8?B?a1FKb2NHOHdjcFlCWlNXcTJMaGZHNzg5M2VUamRiNnNQZVh0QVdhVS9qTHk4?=
 =?utf-8?B?dmxCTmI4U2tEWDR1V0JYK3ZBWk9udWowMGF5UXpUeWlDdEJXSEZwbUdOWFVP?=
 =?utf-8?B?ZlVNVGJCWFFnbW4yUGhwSFFOZmEyb0hiVU0za2ZPd3NCaVJZU0V4TFAvVVJZ?=
 =?utf-8?B?SUpLcUNqa2VZWUlXcGg3SmpaRnJGc0pKazFrTTEwSFZGTjUxTG5PTUhjanRG?=
 =?utf-8?B?dWwyYW5DSDZuQm4yb3Q3RHdWK01BaHBtcEQ1SHhMSkR4bkdMVWNMQndEcHl5?=
 =?utf-8?B?MHRmYnZHai9RNmlyUFkwV3JpY2ZlVFJiZEFncGl6WnA0aG9ZallmbE9Rd1Av?=
 =?utf-8?B?aFJWQjZwSzNtMG5CdTVPUzYwRVd2Q3IzVitJQ2RLdXNIdm9QVGlBeU5XTjBu?=
 =?utf-8?B?QU8zRlhqOG1VWVZJUCtLM0RPSGd4azZPa2NDTmRya1FUMG54VmVRTFJkeWZT?=
 =?utf-8?B?UjZJSVdpOFRKNy8zR1dkSElsQTljNzJxMFBLT0FjUGh2K0JQSkp3YWs2NEJO?=
 =?utf-8?B?YXQxR1lTTmo5bmpsUWdmR1VEVm1FSXB1ZVdaWGZqYi84MUptTUh0Y3djdVFU?=
 =?utf-8?B?eEVhOHdlVU5QNDVuSFR3Q0VoTnNXTE51VmFZNE9KL1VGWHVkTldyUjh3eTFL?=
 =?utf-8?B?SWN2MWg4MTFDZEo3cURJa0hiT3Y2Myt1VkN6VXJycE9OQmtBSzZLb3dBd09M?=
 =?utf-8?B?ODdhK2RDaEpWZEJoeUZEQkFqMFJsMUJFNVlnWEdtYk5NaXZSamlTeUlOcTMw?=
 =?utf-8?B?a0RVWDlmOTVNTksvVXhLdlhpNHB0ay93N0ZYRjRVSFgwdVdoa3p2cmRVQWM2?=
 =?utf-8?B?ekRVdHNpUWtpMnluUXgrcWlLcVE0M3Q3T2hua3VIcGFpYmwrM2Z6N05Dd0NF?=
 =?utf-8?B?d2k0SU04d0VGWXpMZm84TkFJaU84K3F1ZkQrUjEyRjdDc25DaVpYWXd4Rms3?=
 =?utf-8?B?ZC9hV2NaUmpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVaQVorNUNPNm1DYS9IUDNVWTJKMjRWUUFQUDlQWGczcTU3amp6Y0xLZ2RJ?=
 =?utf-8?B?ZktRY2FDSWs1dEx2UXlWRGVYdnpYeG9MdHNjTFVkcVpNLzFzbTBxRmZPS1FI?=
 =?utf-8?B?Q284SXhjOU1IZ3hqRDY4YnpEVFRHSjhNeEJhK2lQTmN0R2dySTArekJGSTJ3?=
 =?utf-8?B?UGNxUktXVXNHN3JuMEs4MmR0Y3dBTmNsOVFtT1NzV25xQ3l2Z1BocklpSGtm?=
 =?utf-8?B?SUNuMFhPRk9pZWJ4QU0yMnNqM3Q5cjBrOWQrdytnSU5VVjlwVjVaVjFWMXQ1?=
 =?utf-8?B?YU1oTFdGUExjSm84U2dKV0dBQmxtSlVsSnorWFV4SncxWlpBQm42MFlBTlgx?=
 =?utf-8?B?MVZZSVd1cXBCc1ZSV1E0MG1yOHY0V3dFTktacmtsbitKWGZYS3FVdWN6K3la?=
 =?utf-8?B?UFJ6dmtDN0NjVHB3OUhwQzhrNVRWTzNMblo0aDliT0F5dVhMVURXNXFyMHVs?=
 =?utf-8?B?NUdCNk93ZHdOVnZ2a3hJYS9OeWtRamhBVDIyWFBUSC9pQ3A3ME9pZFJxM0Zt?=
 =?utf-8?B?YnJITXM2MXY4V1cxendJZ2p5eFFsKzlqTUQrV2ltT2ZuL3cvYzRFTm5Wbm1H?=
 =?utf-8?B?N3RLTzdkTkJZay9KZWRJQlhhZmR2YzBsM1pKd1hUejdTRWFQMWoySUVqSWZN?=
 =?utf-8?B?M2o0dEFiRlpXZkswbmthdHgyRi9zemIwL3dJcTYyc29zSmN0RG5xNU1IbVBi?=
 =?utf-8?B?K2htZlV2bWl1UFM0NnRKRVA4MzkxZnNSMXBWN3VrTmduZkQ4a3JWOVVscUVo?=
 =?utf-8?B?UkN4bDJDTjliV1M2V25BbGkwakpaS1p0dENNUWU1TDNQWG1pL2N4cnlQUldi?=
 =?utf-8?B?K3p0SWR6SUVjQ1FQbUZlMTJEbDVaeStkOUE3MHkzRitoOEhpU0g1Q3hVVnU1?=
 =?utf-8?B?QkxpMG1xTUxUR2JqR3Z2bmEzVWFuYjRNMGt6d3A1a1NZZUtMNmFrUFFCajR0?=
 =?utf-8?B?cVVNcm0wSFNWMTBTNFEvSFZNbzZHVDlOdjhieW9adlBodkVpUGtEZXJrN2pm?=
 =?utf-8?B?Mi8vbFoybWFNZ1FscXBxdFB0S29IRVVkM05VaEJxZjhPSkV4RzRiZUljMFJu?=
 =?utf-8?B?SHhBeFRJMjRLVEtPVWk3RGRoby95NTdvMkZlYUJuektLU0JRUHY5bGhuUEor?=
 =?utf-8?B?L2JvVFFrN2MzMlRPaHF1QTg4V3hnWTNZL0JUV1V2VUQrVGhXODIzWGp3NFpF?=
 =?utf-8?B?WXJrSGV3ZEc1cFlnNTdnK0twS3VaQXQrZklqQmhmS3U5VUZOdm55T2toNGpI?=
 =?utf-8?B?bUVjOUhLazZuT0JDQUJwY2I4UEZwSGIvY29WdVR5WmFXRUNubFd6UUVFSU9q?=
 =?utf-8?B?Vi94TGFJbkxhUE9FeWQwbHd6a0RwUksvaXZ4ZjBiVHhkU0RPWGlwUTdOdXZo?=
 =?utf-8?B?bzJiY2U0ZTNmZ2FSZGgrSUdoOUNKRDZSY0lDWEc4Ylh3MEFvOEF2bUVrbStO?=
 =?utf-8?B?WDA4Sm5ZUHM5SXRYL0NwUi9iemJHOVNCYmJmOGhnRjlod29zMHhqSGk1RjhF?=
 =?utf-8?B?Si91QStsbmpPeFA5eUgzTnMrYlBWNVNuM0R6NnlQaWtJZ2Vwb05IYlNzWUZv?=
 =?utf-8?B?WGU0UFZqQmxndWNSYTUwVW50NzlpYVpLTFZOUnJHZHhIbTJqQjUyQXZuenpP?=
 =?utf-8?B?K1hyWlp4Y3ovREFFem12TVJIY0szSGxYMWZaV0NZQVd4WVVKa1UzWEg3M3M3?=
 =?utf-8?B?STlBNitNa3h3anI3cGt5QThBays5TlhtUHpqWE5tY0RTeXlYNHhEdmppM1Bq?=
 =?utf-8?B?VHdaWWtyMnp1SVh0MDVpR1YvY1A5U3g4Wk1DaU0wQUVWb21Fb0hRQ1FweWRE?=
 =?utf-8?B?cTgwWUVTT3BlTjhPWlQ5MTJWZndONmcyb1RlVnpObmtSNU9pa0x5VlF1QW1p?=
 =?utf-8?B?VThhRVI4VHpOeDd0M2RHcXlZWCtXZ1laSXc3OXloWGVhRlZMcG9vQnpGdi9U?=
 =?utf-8?B?K2ZsV21tak1mdm5HTWRyMTBOOFZNU2tnQ3RDWE9paXk3bFdsMlVKOGs2MGd0?=
 =?utf-8?B?OXU2U1V0UUtVTC9LWFozbjJwVUdXcGFQdTdXOUZmMGdXcW5yUWh5eU44NVBF?=
 =?utf-8?B?VkVEcmxXN0Zna1lrRVJjbWozTklkSjg3ME9HczVOREMyME8zejRweWhTVy9P?=
 =?utf-8?B?TGVkZWUrMGZZV0hUdkpUK3hLVmMzVllUWTM0U21uNlJlSXo1dW4zRmxNelRz?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: abb204b6-7bcf-459e-213c-08ddd98471d7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:41:42.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAK1vTCHFz0qLJbVDpDga7FCIMzYcedkr8e8oiE/29k7Sh5iCnDCsj7/i5oIfTXb9k4z3i8M0M5slGEUZtZyiqZDg1aauCrT6lornFDRXuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Use an enum to differentiate the type of I/O (reading or writing a
> page). Also update the request iterator.
> 
> This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
> (mtd: nand: Add a NAND page I/O request type)
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

You dropped the tags from the original commit. Please preserve them
as-is from the kernel repo and add your SoB-tag at the end of the list.

Please do this for all patches in this series that you directly picked
from the kernel.

> ---
>  drivers/mtd/nand/spi/core.c |  4 ++--
>  include/linux/mtd/nand.h    | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index c1b8b9627f2..d8abd03e919 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  	mutex_lock(&spinand->lock);
>  #endif
>  
> -	nanddev_io_for_each_page(nand, from, ops, &iter) {
> +	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
>  		schedule();
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
> @@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  	mutex_lock(&spinand->lock);
>  #endif
>  
> -	nanddev_io_for_each_page(nand, to, ops, &iter) {
> +	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
>  		schedule();
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 651f8706df5..0afdaed5715 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -80,8 +80,19 @@ struct nand_pos {
>  	unsigned int page;
>  };
>  
> +/**
> + * enum nand_page_io_req_type - Direction of an I/O request
> + * @NAND_PAGE_READ: from the chip, to the controller
> + * @NAND_PAGE_WRITE: from the controller, to the chip
> + */
> +enum nand_page_io_req_type {
> +	NAND_PAGE_READ = 0,
> +	NAND_PAGE_WRITE,
> +};
> +
>  /**
>   * struct nand_page_io_req - NAND I/O request object
> + * @type: the type of page I/O: read or write
>   * @pos: the position this I/O request is targeting
>   * @dataoffs: the offset within the page
>   * @datalen: number of data bytes to read from/write to this page
> @@ -97,6 +108,7 @@ struct nand_pos {
>   * specific commands/operations.
>   */
>  struct nand_page_io_req {
> +	enum nand_page_io_req_type type;
>  	struct nand_pos pos;
>  	unsigned int dataoffs;
>  	unsigned int datalen;
> @@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
>   * layer.
>   */
>  static inline void nanddev_io_iter_init(struct nand_device *nand,
> +					enum nand_page_io_req_type reqtype,
>  					loff_t offs, struct mtd_oob_ops *req,
>  					struct nand_io_iter *iter)
>  {
>  	struct mtd_info *mtd = nanddev_to_mtd(nand);
>  
> +	iter->req.type = reqtype;
>  	iter->req.mode = req->mode;
>  	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
>  	iter->req.ooboffs = req->ooboffs;
> @@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
>   *
>   * Should be used for iterate over pages that are contained in an MTD request.
>   */
> -#define nanddev_io_for_each_page(nand, start, req, iter)		\
> -	for (nanddev_io_iter_init(nand, start, req, iter);		\
> +#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
> +	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
>  	     !nanddev_io_iter_end(nand, iter);				\
>  	     nanddev_io_iter_next_page(nand, iter))
>  

