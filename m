Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28442CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 13:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9372883C62;
	Wed, 12 Nov 2025 14:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KNyFX9+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0BB183C64; Wed, 12 Nov 2025 14:44:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F2A83C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXPOc5wxeWnoXfF2b+6fNkMM73Vwqb3bCxULAnjwYealWyYPxx711m8nG51bwm50861zcoD+EPKWDIr622mlmsvN3+n6WyyGh9LMYg01ZqP7OTaIT+ZpdWL9qGx5q8M7I+LOjgJJ/xJiGI497zW/iITQlZrMXh5/jzFcSysojtNhu1OzXsdSegLFpMFN/IZCM12QtoTrX/y7Olh6CBM9SL7HrI4FInYHOMmnVT8RWXXw9IJgLNBh6XMA+i+Fxuxae++snWh+oi7HXFDReizGQ6xE3Eeyds77d4O/bUvYi3NtZRBMij2bjYupQztb4gFtV0hpczHRFZXbuA31mYuq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE818o1r3nQDcR2wLn0c/PoW90B5DU5co9YoQchW+ns=;
 b=Ow3qHPuXaNaUvqmp5OWlHv2Gevc7yCEqsZ35aZ6kopJBnLYPorP/C/oE9PRtY1S0KDJGdO2Gvfh28r8LHzFCMonv6MgZMypZoowBfD8hrb2kgU3tjAYsb9ekWBkTqvBTXv+096K+jljEsfdL8/oD3MP0NDzKoHWBsFTWJDAOAge6Ox8OyWoqBaWZFn+RFzTwcOiYuOVULvKf4KZUU+ZDiWrkZR9TxGSXrTsEtKbnf1g1/e3Mg0eUU4pN6p8pVLF4ls2v1fD4nMHvb6l11V5SQFbCR+WnCMYrum03neEim6zHx/2r9OvDIYbJLNQq5CxbDw61882kc5MiJeUiOUI22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE818o1r3nQDcR2wLn0c/PoW90B5DU5co9YoQchW+ns=;
 b=KNyFX9+1FMBFXeUbc3rlkcpgXBxZyDetXlhHFKTiDBz2lXCw8aZSRBKc6ciy0qvlo/PhhkrLisdpBYXS/PswojVsHK1RW2Z3IoCvXgKSoJ4yxd6tga0enNehNLjnA3AwoUhJXwHlP6QPWUkqtXbRrhn8BQZcbPbxkft406SNUFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB11940.eurprd04.prod.outlook.com (2603:10a6:800:307::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 13:44:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Wed, 12 Nov 2025
 13:44:34 +0000
Message-ID: <89c8a024-fdd6-40ac-8208-a97dba4f1016@cherry.de>
Date: Wed, 12 Nov 2025 14:44:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
To: Kory Maincent <kory.maincent@bootlin.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20251112131719.98950-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251112131719.98950-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB11940:EE_
X-MS-Office365-Filtering-Correlation-Id: 855e7590-d0bd-43ee-e916-08de21f19d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWI5Zk1iUjVwa0NPaFpwQ0I4a2ZiMnQzV2hBNisxRkRoNDg0Qzl3Q1drM2to?=
 =?utf-8?B?c2JWN3RtVWp4bVorV1FObDFmMnVKcGhJNEhNUFQxU2R2OXhqWFNSZ2JxYzNr?=
 =?utf-8?B?U3Vtd3lZNVhuZU1uL09pYXJIRFFCcFBESk9OTjNRdDkrTzVCK2R6bTZMN3Ex?=
 =?utf-8?B?bUozaVRKbDVyM0tscmtQVUQ3enFsQ0hkRUlIOFk4Q0pOakwyN3lQYzRMNmZW?=
 =?utf-8?B?S21KRlBKemdyWXhsQ2xLcGFQaXZhc1c4WXVjMG1zalYwRitRUkpKNG92L2Ew?=
 =?utf-8?B?RVBhVGVKTWFLUnhVQ0Rqa2sxeU51N1JpOEVOYjBXVHBpSFpISWl6bjhyaWkx?=
 =?utf-8?B?S1JQSlZ4TTVFNTFBQXEyR0VXaGl0NUREdDBIbzd4K0xYazZyVEtvRGhiRFZX?=
 =?utf-8?B?U0lWRVU2YVJwdEw5THRnZU4vbThlcFZ1dXh3Q3QxRmFEYWRQaVN2bUFFOVRV?=
 =?utf-8?B?WlExZFduNkRBKy9hQWttTDdPKzUvMTVHMVlIaFo3VWVDbVduS1hOMm10ZlpZ?=
 =?utf-8?B?RmsweHIycFM3VFdidDVGVko2YzlySVQwWWZjaVF1Z0VubjM4dXdwblY0a1lo?=
 =?utf-8?B?YU9DbU9tZzFySDVqbzV4Z3pxaFhEWjUzTDVsTmJyR1F2Y2xpNGJRbXhSMFpD?=
 =?utf-8?B?ZUpqSkxyS3B6R01HYVB4dWJydlZhYlNURjd3bDNUcjBheE9TZDNqUlNyajZH?=
 =?utf-8?B?WnpwTVVCTzRCV0E1MHBMRmZiZHp6OUhaelNKUmdEM3BHWU1aQmpMdVByd1JF?=
 =?utf-8?B?NEo1WFYza3p5TkxrcHV4Ym92bUhZODRkbUsycDZSK0tXL3BLYTJUc0tuNUdH?=
 =?utf-8?B?RXRaRncyajVjYndPWlBnL1FZM3RJQjgvcG1CeFlLaDZTY1dTamxZVm42QkZP?=
 =?utf-8?B?ZXI4ajFFTWF0ZWtFQ3BjdUJjajdrV2IzQ1Mrc2hRSlVRYlZmS1RENGlqcnVU?=
 =?utf-8?B?UUtxUk9MUFpzdEtmZmlrT0FDZ3l2dGMyd2RTSFNCeUVwYWxHMDlFTCs5a0tN?=
 =?utf-8?B?bDJZNlB6aTl2VXVwZEdUMmtHN2QrV2RpUmIyYW4rSk1IbFlyTkJ0KzZwY0Vl?=
 =?utf-8?B?NFp5dVBoQlNrUUFka1ZGbmoyQitmTDluVU90eDNoOFhQMVBZUy81bHdLYjJK?=
 =?utf-8?B?TjVIMlgwd2pwTWVTMGQwbldiQ0VzaTRBdG5ZUGNOMU5XNllIdXMwM1BnNTFI?=
 =?utf-8?B?RG5tM1gwaUlaeWZocXpDeHJDT2lUd3crOXFPSC80Z2Z4eU1LQkFheU5PME5p?=
 =?utf-8?B?YzZQTDNkajNzY05xaXM2c09ZYi92YUdOQ3dGalFwbkNBRitqUEw3UFhISEhG?=
 =?utf-8?B?R2J2THJmcTBYUWJWWUZiZHNQaWptbHllTkNpd0NnUlVzOGNGektzVS9SSVVJ?=
 =?utf-8?B?K2JGWnpYWGJ3N2JWdnIyQzJFRDhZN2ZsU0RRa2Q0NEJvOHNVM05QMllYZlYv?=
 =?utf-8?B?VzVia29zalpBejdaUDJaMTBVTnVxM2gzY3VEQWFMTzdNNEhFdzdGSVRiSkNq?=
 =?utf-8?B?Y2lDV25rdURmajdOR0RjVFYzQ0VlMHZJVEpmWjlaOHFYMjhwdUF0aWQzTjdF?=
 =?utf-8?B?Z09HWHF6eGlnaktzUFVtOCswZDRPaE4zNHZzYktpb04zYnJ1Q2pkajNLS3Mv?=
 =?utf-8?B?MHpLaGY4V1V6Tkl6YUdVZDdISDhCbCtkS1hReGNYS0FnazZPaDE2NkNPcGhS?=
 =?utf-8?B?Q2NtYSs5RERoMnJoNVQ1bk5keWNGRjZ6ZENRdUR0T1lwSk5XYXdiSGZNSkly?=
 =?utf-8?B?WjlOMitISjJsT0ZNUTN2dmFEN2hESktDeXhVdVhMN0J0TkwyNHk4clNEOWZn?=
 =?utf-8?B?YXlMUzk1L1JqeG45bmEySkdBWTNwL2E5UHEwZWpmUlpLZ25HNlp5b2crSTY5?=
 =?utf-8?B?YVVJOEgzaGFBSlBLRWRESEd6L3ROa09kVmU5bDlNLzBWMmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3l2bnF5WFFmS1FYS2hmNDhtUzRQWHArV25QY1puTzVjazMwU3YvcEJyWWVM?=
 =?utf-8?B?ZjhQaytaTmJZQjg2YUhjRHViSEx4MjVBTjM2TGREWCtUS3ZPM2VkZE9MTHky?=
 =?utf-8?B?c1htM2IvL2l5M204YnNwSHUzRHBtQnU1bENaRnBiT0RVSktEOU1UZHVFQUw3?=
 =?utf-8?B?YVlUeW9IUUNUbDlHNnFaN2NmOUNPTGtIYjVpakxWeHlUc1BjT2xZK3pRbmNj?=
 =?utf-8?B?WlN5c1pRby85eGhRV2MyM1lpd3A3dllrTFZ1QUZVVEh1MlZ5WFdTdkkwUVov?=
 =?utf-8?B?WVc1T3RBUFczWnB1RjFIUFE0SFNVNnBjTVNaTHJQZ0pZN3hSa1AzcGhZSVIz?=
 =?utf-8?B?bk5BdEdEOGtVWW5CVmFNL1lMZTRNL01ZaVJqSHpQeWhJNXZCazdLbC81M2Fu?=
 =?utf-8?B?QmFJQVB0YmxPYWtKVk5YME8yWEdBT1J4dFlpUnhXa001ZUljNkN6eC9qQWZW?=
 =?utf-8?B?RWdNdERCRkhEcGhLNDgzU2ZmcFNhMnkyZWJhOWQ5VzcxbllLZVRNQnpBTkFI?=
 =?utf-8?B?UFc5elUvaGdTQjlwK1l0V0V6ZGdxMUM0M3RSTDZ4MWdDSGJvdzlKVU5DbTZJ?=
 =?utf-8?B?eHdMYTlIL1lvM1dGUWJDVEVhcWpucEM2NTM3MG1zTDd5dkNnVFZFUmo2Y0JF?=
 =?utf-8?B?MTM4dldXVEFZV3BqaWJNVlFGejhxWXBwNTViQ056bnhIMlY4Q3lubTFZWGJT?=
 =?utf-8?B?eGQwZlhKa0ptTGp4T1c1N1ZOWmhaQjFFeVFHSkoybjJMeW4zTTcwYXdOcG85?=
 =?utf-8?B?NisvcysvWWYwYW9yN3BhOWZ3cFpuYVk5V2NoeVlTY2ExTUNTMi9vYmdrWk4y?=
 =?utf-8?B?UkdIZzU2REQxQjJsYnUwWmJBWHNFMFdSQ05aVW5CaDRvSnV3Y29IL1RWKzZl?=
 =?utf-8?B?WWc0M3d6cWY5TGRMalltVVkxQXpvaGdqbnVUSWtJTitmZ2JaQVRBRGN6TFpK?=
 =?utf-8?B?N3VLbW1kQ3VpcEZKNkpxTlBPYXVlOXRYZGJCaGExTThXNjZORTVWWkdzUWdS?=
 =?utf-8?B?Z0VGb2Vxa1JMZFVpV3lYWXhKT1phK2JlYStyTk95Tm1DbCtMSng5Ylg2Z3Vi?=
 =?utf-8?B?SmUxTlRQYm1EMFYzNENPM0I0bzBrWVlTcmJvWWVYZ0ptVm9kQnk1UFdoODNs?=
 =?utf-8?B?RGNlU3RRRjE2cVJUR3BNRHhYNGJPWUFqN1FYemNMeUlrdzVyZThkWGdTYTZo?=
 =?utf-8?B?algvWHpMNjYxNmFZNFlHeG5nY2hZUjJtRzZVU3VYdkw3Wnl6NnZ3Q3pUMVF6?=
 =?utf-8?B?UEhYMkRFazVraUluR2RheUtXdCtTK3JpSHpFWlUwV3h3WDRqdHo5aWFWMndD?=
 =?utf-8?B?NXZiMThCc3J4MkRoUWZEY2htaEd0OGlKK0dzZHFiUWVERE9rNVh5aTc0SE40?=
 =?utf-8?B?UVhLV1A0OTZvTWxBQVFtVE91QnZ3WHFKWW9oMTR3aWhRTkZ1clp4SFY3Ujdr?=
 =?utf-8?B?VFBiWDFHQTVSWS9jZTJGSXlmMk0xKzk4SW9WOFlYZVZtUHhCZFQxWmsyTm02?=
 =?utf-8?B?ZHoxWng2T2FGbUtJejg0MmNwTUtRM242TllYTkpGTFJSMHdmMnNtUDZURlJs?=
 =?utf-8?B?MUtsdnZVMlRLMDRlU1dIUzIwMlpCN1VKcG5pOTR4bDNlOW1PQjFaNkFyK1VL?=
 =?utf-8?B?a2E5UzN2M01kZmo5UDZjcjM4eEVYR3JEQm1YZ2FTV0hFYkkvdlpVbDhGbDRL?=
 =?utf-8?B?UTZ6UnR2MFdnbzhhc3IxTy9CL1ZFM3V5UzZSdm9jT0MveGpGSEcvRlZpSUcx?=
 =?utf-8?B?NkUzZ2lFU0tSQzdWQkR0aHcxUGxmcXJDUUg3eUhXRnI5N0xoVUdoZVRUSmhp?=
 =?utf-8?B?N01mT2t4MFF1azNxN1ZYQW41RlUwSG0zN2lrOU41Q0d6dEZDWXU2TVoyMmhr?=
 =?utf-8?B?M1JaYUxnblhVWHhORmdDWUlFQnUxcHZZQWt4a0dacndJb1lodGh3SzJMbE9U?=
 =?utf-8?B?VUF6NXpWcjN0ME9NSVREZDhTSEhLbmYvcTRmem12K1NMWExoaEx3dzJZRW9T?=
 =?utf-8?B?WU1UUkdZUXdTb0paSERvTVMxQmRaU2tYMWFrVzZXZzUxK0tpVzhVaXpyWkdV?=
 =?utf-8?B?RXlUU1E1dTJTVThOVndKcm10VTBRbzhvc0dwdWswSHlSMnNKbWRVTE1IQnlP?=
 =?utf-8?B?K21kZmpjdlZhMzFZcm9QZFRBMjh5WlVrSzdDR2FBV1QzSW9QQ2NOd2ZSQ2Ro?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e7590-d0bd-43ee-e916-08de21f19d3c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 13:44:34.8061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbpv/HvOUncbXGmcgSjcY6Fxvq+H8Q7oXei5OZydk94J8Ss66NmQEDQgETpFdNPoQTGtKOI7aYxe0Up9U4IvCybXEd0ppKsZ0AdXyloX8Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11940
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

Hi Köry,

On 11/12/25 2:17 PM, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> Fix two memory allocation bugs in label_boot_extension():
> 
> 1. When label->fdtdir is not set, overlay_dir was used without any
>     memory allocation. Add the missing calloc() in the else branch.
> 
> 2. When label->fdtdir is set, the allocation incorrectly used the
>     'len' variable instead of 'dir_len'. The 'dir_len' variable is
>     calculated to include the fdtdir length plus the trailing slash,
>     while 'len' was only for the fdtdir length. This caused incorrect
>     memory allocation size.
> 
> These issues could lead to memory corruption or undefined behavior when
> processing device tree overlays via PXE boot.
> 
> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree overlay support")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>   boot/pxe_utils.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 038416203fc..7a64b6b97d4 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -474,7 +474,7 @@ static void label_boot_extension(struct pxe_context *ctx,
>   			slash = "";
>   
>   		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
> -		overlay_dir = calloc(1, len);
> +		overlay_dir = calloc(1, dir_len);
>   		if (!overlay_dir)
>   			return;
>   
> @@ -482,6 +482,10 @@ static void label_boot_extension(struct pxe_context *ctx,
>   			 slash);
>   	} else {
>   		dir_len = 2;
> +		overlay_dir = calloc(1, dir_len);
> +		if (!overlay_dir)
> +			return;
> +
>   		snprintf(overlay_dir, dir_len, "/");
>   	}
>   

I'm wondering if we couldn't make this easier to maintain by not having 
two calloc and snprintf calls?

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..6c1bf05cf66 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -474,17 +474,17 @@ static void label_boot_extension(struct 
pxe_context *ctx,
  			slash = "";

  		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
-		if (!overlay_dir)
-			return;
-
-		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
-			 slash);
  	} else {
  		dir_len = 2;
-		snprintf(overlay_dir, dir_len, "/");
+		slash = "/";
  	}

+	overlay_dir = calloc(1, dir_len);
+	if (!overlay_dir)
+		return;
+
+	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir?: "", slash);
+
  	alist_for_each(extension, extension_list) {
  		char *overlay_file;
  		ulong size;


Also, we probably want dir_len = len + strlen(slash) + 1 to avoid a 
second strlen on label->fdtdir (at the top of the git context here).

Finally, I'm wondering if the snprintf should not be dir_len - 1 
considering we calloc with enough room for the trailing NUL character? 
Or not have + 1 for dir_len and calloc with + 1.

Looks ok to me otherwise!

Cheers,
Quentin
