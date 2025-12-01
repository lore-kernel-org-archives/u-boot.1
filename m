Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE3CD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 19:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB48A83D6C;
	Mon,  1 Dec 2025 20:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="OBoYiueV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671E283D8A; Mon,  1 Dec 2025 20:59:31 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559BD83D4A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 20:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQAL+8HWw3/D3ML+s0NYb7nwir2hzMwlkNLGC/Dxy/pPhuVsTM8vdvUAeRItsb/toQ5eFyVSwIqsuT8iBDCrbA5B0IKPO+E5Wa8/f5gHBJHMCF0MB06QmO8D+wHxBbLxN6ua0JUhm0YaMNnXKWaY9qiKVJk8MStOFAN06xgs4DViRoCayVM5gIh9eUvyi6/Uo5yP4KphVMLTe1JBqfCB5If9t4QJrD6zg2Ju+RWzcTASfEOf6z3PXJHIvk7Mvhu4m43X0Yt2TD5QZ7bf+VBCovXEyJ26wvfkQ10eL5lMB3vX7ZbCjOYGkWuW8QGsgCYyrazvPxiyhuxAcyP27VIptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elMq6k/lBBypw/QRACv+3Dg1OIxFmmBKy1+0qHLK2Fc=;
 b=PMvyik8t4PnNcVBFlUKxxcoGgmZoofAVWSTVkToctvYzTGPXVWNVnj0GGziH/+e/Z6oB5O45CZbVslPi+5j9b0Jmdi3vokCXBxIkJmz59I1YedTjVZClcAPEpMGCtUuhpiOg+fr0k9wq2HBztwnVFqWZy/0dcOEXoeoiYBIrla9zwOe9zD2UyW3xHZT1gpC9/8KntokfAYOT+KY1V7QypwF29E6FYpRDKzN1J6NlkcEQgjuoLFYO1Eou9us1JBaD0p9o07E5FJI/p94w3xnq0x+vJPrByzYhvsJXAFPbERqVyZrNcGR1ygeZqH0zpMnH1wy7+ETFY3/4MToRbNFlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elMq6k/lBBypw/QRACv+3Dg1OIxFmmBKy1+0qHLK2Fc=;
 b=OBoYiueVpAFf/u+dfrDu9yBcblxwhRJmT4+LY0IjbTCEIMmFFBgn669mrCsXdmMa76u+NQxVzaGRCtVZRblCaaQMkW6qKncTFfA2g1QBZCf1I9H7alzvuufIl1sff6kQCqyttPLNTYVPPVWuJhVOorl7frDX4EncEQi2JGvK42Jkv1je1xAergeexLgJjOuehvrKf+2NWIRQZCNNuKMEN3w+L76Q+hUrT6DZEGEDb23EMUHuG2HGJe3/0ukUhYJ4dC1VknRIreXVJBeEyu4LnB5OEBiPqvMF5UXiBRPIOYbo/Tqp2El5IbTsdrUIFlAuq9BhI/YTRRGSmNawfFdEoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:59:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:59:28 +0000
Message-ID: <8a3bc250-48fd-468b-8ca5-630c0d819f8f@siemens.com>
Date: Mon, 1 Dec 2025 20:59:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <56c8a3fb4a86a72839a3651dc6a7ca871b62bd01.1764574369.git.jan.kiszka@siemens.com>
 <20251201175518.GB2247668@bill-the-cat>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251201175518.GB2247668@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faf82ad-7521-4d4b-2d72-08de31142276
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmYwN2k1MS84M3FqL1ZnRU5rRzVpTUYzMC9pbk9YcFB4NUVoa2JvVDl3eEUr?=
 =?utf-8?B?WlRjS1orUUltNUtpcjlnRko2THEyMGpXN2RobWxsVUQ4RmVpVGYyT1JGMFZR?=
 =?utf-8?B?TGtmcUpFaXFnM3hjSzROb245OTZTL0hhL3NGUzZJS0d3S0FNSENpbkFoa2N1?=
 =?utf-8?B?TXFTZWdoUGFWa29uUVlRQkZDZG5WNFpYNUxsQyszaXA4RXhMV1dHQ3p3NS9z?=
 =?utf-8?B?a0ZyamZzMjlCQXRSRGRlTnc2bEFQaUFPT2dpK1A3RUNKekptTTVqNnQwSXla?=
 =?utf-8?B?K3d0NVppVTVVUmVXcE5PajFDQ051WEl4bis1U3R1Y2c5R2hiUnRmbUQ5ekRz?=
 =?utf-8?B?dnBSeStPc296OUZXUE5JbDBDbnRrd09Iay9aZzliOThqcTZCZ1pISWpVZnBr?=
 =?utf-8?B?eTliUS9QVW9Od2l1M2pPNW4wZnU5TnA4NXNraUtIa21iV2lZQllRckxMWnoz?=
 =?utf-8?B?dG52L2FPTEJVL1dIdFlOWTFYSWNXNE5keUhCZzdiWVhGZFpVNnlzSnhZbUta?=
 =?utf-8?B?d0JMMlVDdGRrZXZ4dFBEL3FFNTd0RzhTM0s5VkpQTEdmVGovYXc1aS83cmwy?=
 =?utf-8?B?VmpON3BFSmo5aEowM1lpTDdDR0xLTmR5NTlYSTZjV2lSbzhVamdPTmZPSDdl?=
 =?utf-8?B?Q1FXRWxPT1R5M0dseDlLbk50WWgvSlhGTlBLTlE0Y3RzVW90aDN5eUR5OEsr?=
 =?utf-8?B?eXVyaHVGbnNpWXUyVnNCZlVWeGUvOHVYMXhCNXkxRHFmYjllVFlmdlpCM1kx?=
 =?utf-8?B?ZHJJNk9JcEE1NisyTWVVMjFnUGRaNVBCQmhwMkpjWktVa1YyRUJsU0ZZREFO?=
 =?utf-8?B?NHBISWRKNWZjR0MvVllWdUpWQ2E5OGQ2c0RvUWpBOEEzWVpuUEZqRmFZWkdW?=
 =?utf-8?B?R3JIUnUyMUV2NUZtRS81Qzd4WjdlT2F4a2RtYkE5QjNWci8xMEZWTUVDTm9U?=
 =?utf-8?B?YWdDRm9HbnJPYnpTSytiWlR2RFJKcEs4bUJJbUQ1dm5YUXYzZHBPeFhqRkFP?=
 =?utf-8?B?TjE0cDBlUTd6dDBJSWE0VUV6ekxlcllUQVpnZG1aZE40RjZmOXplR1hHWk5G?=
 =?utf-8?B?Z3dCMm5QaDZNSStKT2hJekE4Wnk4RStIQkUweC9aTmc0MGhpMlQzL2dsN2xt?=
 =?utf-8?B?aG1vYTVTMk1oYmRIeDM4MzFPcmx3YVY5RkFsaVUyY2F4cmV4SHM3ck5QT01S?=
 =?utf-8?B?RHRKQTZTeFFXUkgxTVNUc0F6SzdmN1o5aWV6VFhGOHRWYUprZTc1enJMREJr?=
 =?utf-8?B?L0lLMHlhcmlJcDFQMnhCV2FsMnVWNHo1dW5jeFRtdkxwVVBsRVJhWkhQbVVn?=
 =?utf-8?B?cXNsa1dzaGN1ZnQ0ZlRBTHpHM1VobGUzSDBRa2xZVC9tb2ZUcUtSbGhiMStl?=
 =?utf-8?B?N0t2TW1DcTRlZG9uWk84L050aHU4bUV6Y0RRWjU3bnBzcmY2dHdWRVM4MmtG?=
 =?utf-8?B?Y0lnOS9HQXgzR0NCWkFacFBUTkxkR3FKODlLYU5kenZjSDRQR0thWmxoUWJD?=
 =?utf-8?B?d05MbEpkT0hzcnByQmNKQjhUUmxoY3NQZzBNaVRERTJ1c0s2eUpVNmswUXFv?=
 =?utf-8?B?bG9WMVEyNm5Felg0aU80bStVVEJDeHBJdFhJYmtyVlpsb25CSzIxZlRzWDRY?=
 =?utf-8?B?WCtLaVBRM2ZiZ20yV0hyZmdJR1huc003NkdjY1U4OVZKSUxjMThwUElQTTBG?=
 =?utf-8?B?WTNvdCtSam13aXUxMFFBWHJmVTE0Y3VMY0FMWEJMNjBzNnd4SFFXbjJuRVpK?=
 =?utf-8?B?cW0yaTRha2tZVjdPQnV4M0VCM3h0czl3NGpPdE85SHM0L2o4K1ZOeS8vUm5B?=
 =?utf-8?B?bWhBK1ZtcUhuSU14VTI4dEczRHpHSTRvRDNBRG5lMS9pNkZzeThEY3hHMXpR?=
 =?utf-8?B?dGIycGErbFNtOTRsMGtwS2w3V2puVHJGSnEvRE1mUUVzd2d1MFZUeXNBZGdJ?=
 =?utf-8?Q?SMkF6FddqVBBJfXjEZFuBWUMA4TYOHyP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRHRlhZTkRoUVZiYnRIQ1B2TGpSaHN4c212azJwTklNOFk0aTIwQko4aTRt?=
 =?utf-8?B?SW5nUUpBS29ZL29HS1RuSGNJNzRZYWRsU1lSM1dIdFhicGM4REVOM3pWTzFp?=
 =?utf-8?B?Z1krMnM3K0lrSjFZdlkrNERiWnF1LytGWEswcllJY3g3M1lpY0VBTnFsRVNT?=
 =?utf-8?B?bnlzSDFTRHQ5QUV6S2NXYnpUTDkrM1YzY1dyeTlzUFdkcjltY0dVUVBodWlZ?=
 =?utf-8?B?WGFvQzQ3YlliTFJnVERla0d5dEZ6Z1Q5SjduVzFpOXlsejhCNkFNUk15a0NC?=
 =?utf-8?B?RFptMldzU2pLSFdrMGpoU09LazBxaHE1RDBHVWxZZm04cHN6SmE0SEw3d0hI?=
 =?utf-8?B?RDIvVFhWZXJrUFZta1dzNFRWYklBdkd0TUVBNGVPeXFmM2JJbndUditaVU41?=
 =?utf-8?B?dVY4TEg0UlZ6VEFpa0hVellJS2ZJbnJkTDREa1hFL3A3L29SSlRsZlc3cE80?=
 =?utf-8?B?UEFVellzb1k0dVVhbzk0NWZPQy9aamswazBOOEsweEVsOGhwUE5mMnNGc29s?=
 =?utf-8?B?bGRwVitZMzhpa1dPZUZHMjIwcTZsb0FZVmNoMytKWko5OEdUelRGRkNndkRW?=
 =?utf-8?B?R0dpQmozbkJ2RkVVdElaRHNXTFFKa083RHUvUlpjOWx5QnZTVFVjTTRmNXpj?=
 =?utf-8?B?RVYzS2xnaHo0R1d4bEtKeXhJc2k5TnZHRXgwWDhrNzVzQ2MwZW5JMXhZUDMz?=
 =?utf-8?B?Y3J6QmxlVnFUa1pvVzQwNGduSHhJVkM4cFkyUUFRTFRSYndOdUNOTG51cUtZ?=
 =?utf-8?B?dFNXaGNHRkw2aytQSFRwVGNIazZWTEtjNCtSTmFPQ0JwRkw4eUpUN2tGRTZn?=
 =?utf-8?B?QmpPZWRrVDlLU1VlSGZjdk5xVDNaOEdWRE84QUhhaTlOVDBHOUxEUnhqMVU2?=
 =?utf-8?B?dXZjR2Rnakh4d0Z0WFh5NCs5cGJ0cGlzSU1FY29sV0wxckYyZ0EvR0dRU04x?=
 =?utf-8?B?Mmt6NytzR2RaVHhxQnhFTTRpOUF4TVZqeEI4Qm96b2t5UkxPQkx6L2JCK095?=
 =?utf-8?B?eDJEdDNZT2FGaTgyOGR4TkhtK3ExRkRpdldUUURuVU84WGIya3NwdE5RQXpn?=
 =?utf-8?B?bm4zZXlhblpCS1pKTnlpMEFvazlVSWZEVkVxcUVtTzlBZThxM0puOFVJNWZQ?=
 =?utf-8?B?cml5RzJpN0xrUDdxKzNrMWkvYmNUam5KcjBReUswSURrOU81bDFRSXI2STZV?=
 =?utf-8?B?YVFNT0d3ZVJ0TVJWWXFMVW5qOXJ2Zmg0RFFrZGo5RUN6TmVjOTBNQVZVL0RN?=
 =?utf-8?B?eDRqd01leDhLN1MzNDd1RG5FWVNrRmk3cjFiK0dNM3M0cHF1ZkswVjZjTHVU?=
 =?utf-8?B?WXkxS0pPYVN6UjBJKzRWQ1NVVTBUL0lROHNSdWU5WkdQVFAwMnZEa29raXB0?=
 =?utf-8?B?RGRud2hGRDlIZjhLWWx0aUFVR0xsajlIV3JRTHU3MmJFSVIxakRuVmIweWdC?=
 =?utf-8?B?YmZ1d1ZBbmdUUmZGWnljMzQ0Y1cybGFsMDRrNllwek1zYlprd0txS1ZtcW5y?=
 =?utf-8?B?NG40OE5nMmRoV2gwekZVNmxoSUxvRW9SZVY1QVBSMHNwSXNHclNiMmdlMWw1?=
 =?utf-8?B?NWVNVnEvL0w1N3o2SnJZcjl6TDIvK25tenQ5LzNLSE0zSDI4bVdNUThHTDA3?=
 =?utf-8?B?cTF3Z21VakxJSkp0TVlBd3FhMWJrKzJPRFB2SWxDWHlUMm55SGR5NExIb3l6?=
 =?utf-8?B?eWQvOFhZQlZ5OGRJeWQxOFlYR0JIcERHNG9ZQlZGZklUU0E0SXFXMDlBUC9k?=
 =?utf-8?B?dFdRMlVsYWIveGVWUmtiM28vc0Z3TG5Hb2duV1RWcG1MVXZUSGZmSWYzRHdP?=
 =?utf-8?B?YVZsL0FDYUtlNlpObWEyTjY5am83cExOaGxvUlgxcU85UGxrTmJWWlpnZHZp?=
 =?utf-8?B?Vk0ralpzMEJoclVlck5LRVJyQmZweGltUjVDREFFcDFUQzQ3cFJFOStkUFZI?=
 =?utf-8?B?RUNJYUw4c0R4RlVENlA3cFdFZGkzTnA1MFlVYlpmUUhpZWlaUnVnR1prTjE0?=
 =?utf-8?B?RGR5Q2dIRmhRdktuTDRuTnRxbmxBVCtQbFhlcGFFVURXSjZ3Q0lCMjRsN3g4?=
 =?utf-8?B?RkVod1ArZEg1Wk5sL2c2QkRFYXRNMnIxVllvZ0k4N3c5TlZCZnp4QlBMQklk?=
 =?utf-8?B?aWQxVHU4TFN2OGJLbFIySjNzaXFoYmlEWUV1VzhPRjBZM2JGQ3BUWmloRUJq?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faf82ad-7521-4d4b-2d72-08de31142276
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:59:28.1471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvjIU6St21i5N/SP0p2SiNyWyXp4dz8o9dJivJQrusnRRDR62IP+41CCmCGAXEftVt7ITl818APosvfVa1AsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260
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

On 01.12.25 18:55, Tom Rini wrote:
> On Mon, Dec 01, 2025 at 08:32:46AM +0100, Jan Kiszka wrote:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
>> far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
>> by chance as both options were enabled.
>>
>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  common/spl/spl_mmc.c | 17 +++++++++--------
>>  include/part.h       |  3 ++-
>>  2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>> index d8ce3a84614..1942e417075 100644
>> --- a/common/spl/spl_mmc.c
>> +++ b/common/spl/spl_mmc.c
>> @@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>>  	return 0;
>>  }
>>  
>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>> +#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
>> +    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>>  static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>>  					struct spl_boot_device *bootdev,
>>  					struct mmc *mmc, int partition,
>> @@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>>  
>>  		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
>>  
>> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>> -		ret = mmc_load_image_raw_partition(spl_image, bootdev,
>> -						   mmc, raw_part,
>> -						   raw_sect);
>> -		if (!ret)
>> -			return 0;
>> -#endif
>>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>  		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>>  						raw_sect +
>>  						spl_mmc_raw_uboot_offset(part));
>>  		if (!ret)
>>  			return 0;
>> +#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
>> +      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
>> +		ret = mmc_load_image_raw_partition(spl_image, bootdev,
>> +						   mmc, raw_part,
>> +						   raw_sect);
>> +		if (!ret)
>> +			return 0;
>>  #endif
> 
> Why do we change the order here?
> 

Because v1 tried #if ...USE_SECTOR #else - and failed. Leftover. If
preferred, I can keep the original order. OTOH, it's the order of mode
enumerations now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
