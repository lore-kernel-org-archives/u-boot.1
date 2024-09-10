Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8372ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640F489062;
	Tue, 10 Sep 2024 14:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="YOSjTcvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265B089062; Tue, 10 Sep 2024 14:08:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5339E89037
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFm350GbQPet/5J4+p0AnfanU1Gy7blvtG+YC4o2/I8b3M03/EM82tD7g92cC/1XFkaqo8lrCsbQn60ZblUla8on0No2uySihnd1WEP5kEalcpMcCBaPau6ipgzmvaUlkUI0DVMTeAwOFWXivgZweJ6wxi4mCKj0Wc/aYh1WdqabesptrjDcOaTUBG7o09SDKfQ2TzoBscumalhDHALzt3SekbLIj9mM9FudH7ABSI90Bn4KHFwDzgLdd89RwouS/8alX/6VLLpFRNDu26a7UvPkaSalK3i9SG5Qc39mloOogvHwJ/Ye3ObtaIw/6Es4ZANcQyMajM7+WbkrRP6ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7ZZG52GW4uWuJMy14hx5ZEDpxCXaget+8LsE29viWg=;
 b=r3Ls/wNt/8mPS/3w91iOHZHgkdLZxOeGteXkS7SBcOkH84MpPBBEApsS4KM0y8Kpi3lgWd87sspzXEAYR9eXsXYO11EdMxL6XDi2Wf3EUgAABrH5+bNscK8CQ1zkYf18akiMm8ma9m1up+ExS0MSKvsavoz65nE89qq0efUf/SVt601PTglIHpYe85+7rmnKgCZ2hdczAreM51Xt7+jZyo8WllJsq83bjo6MVgQue8vxhm5DQgeH968D8T1GuNK6kanxh9NYh8mtDVxIuZ2MUmmY0geaYHSGtKbkzNvsZnN0B9A1fq+jfRmQIXfNoIwEImspKVT6z8Y8yrLJrQE3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7ZZG52GW4uWuJMy14hx5ZEDpxCXaget+8LsE29viWg=;
 b=YOSjTcvpcLVNNESe/wRSYxzJ/XSDEF4ISyVYllQhkRTrg6To6CqHIB9n6PilgZccXEKrcbLDzwP9Kr1STtBGs88w6MEIZKblfmerC2wW94RMdpw5/VvAkKb5c90NoRFgC9mrS5mp+fxOvOQ1KMWn37gowUjJ5MnHAlDVruS2nENeHe5MUUr1ktbU5AzU57fthrvsk33HErEuslvhsf4TMUp6X82nuagTwJM3Uch4JucvjcglprFSbAPXEeQZEOQDyXiH+1Y8963AtSZDmpflBby2Cpm7XZ6lxgZUqb43igc8/ntPJCJCjLYgMC44IG7DI3gB0BTfOr1AYz2W2LCi7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:586::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 12:08:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 12:08:10 +0000
Message-ID: <62a7a500-0d56-49db-8e6f-b88fc4c84328@siemens.com>
Date: Tue, 10 Sep 2024 14:08:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Frank Wunderlich <frank-w@public-files.de>, Nishanth Menon <nm@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
 <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
 <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
 <CAFA6WYM7n+cbFFrN8nH67pYCGo9ENn5Avv-2QOMA4U_ws+9ogw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYM7n+cbFFrN8nH67pYCGo9ENn5Avv-2QOMA4U_ws+9ogw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cab993-e8e7-4d73-6799-08dcd1913cf7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFluQUd2Y3VuNFh2MkdPZ05DeG4rTkE5NWxuVkZLeFVEcDJGVkNLdEN1Mk1W?=
 =?utf-8?B?S1ZPOFlad2dqTzhjS2M1MVBXSHl4YnNkTzZKais5dXI1N0RQbjhEaGxqdTgr?=
 =?utf-8?B?U3p5U0xYU2FpL05jbTZoWlBBUFNnNmg4SVpzaU8xZHBIVzhNV1NCYlo4L1JP?=
 =?utf-8?B?SVV0UG5rZVdyZ0FySitLM0tzUUlsMEgramt4TTFRcFVBK0NORVE4a0drWXg2?=
 =?utf-8?B?anBYOE1tblpWZlFnWitJTnpsSEIvTHdRekNUbngxVlpKQk1xdmZyT0pMNW12?=
 =?utf-8?B?ZWRxdjAyam4xcURuWWs3M0liTGZPWW9lbkJBcTFJdmN5bnZTUHdlWHJxczZw?=
 =?utf-8?B?WXZ3Mjh3TGoyM05YYjYwbjROMmxXNHBNUGlTSmd1RS9va1VDemN5MXpYOUFs?=
 =?utf-8?B?WEc4Sjk1L2lHY2ZaTG04L0ZJR3J3azVpQU9ubnIyelFNUnlzd294eXBBbm5o?=
 =?utf-8?B?Mk1DcEd3c2I3bFRGemhHbG5aZHRFWHZhdVRIMURjcXJoSVlqanZsQlJ6L0Fq?=
 =?utf-8?B?NlpuYVREZWpzNjE5eTNVUFIxTmh4MElOV0FRdTRaYUp3Z2s0eUVWblBucHc4?=
 =?utf-8?B?dDBhdkcxdlhhaHRwalRFbmJ0N040ZE5xaVZDcXFVMHdWSGlIODhyOFNESk9S?=
 =?utf-8?B?K1VkVmtGK2tqeCtlUjlSQURnWVppUEdWRk53YnhBYXJqMDFjT1FJRVhMaTN5?=
 =?utf-8?B?elYvM2swRmhYY2RRTG8wNi9LZXpORGFaU3loKzN3ZlZwWTd1UXorUk8wMlU4?=
 =?utf-8?B?REQvSlcxZml2RWtBUVE1eGRsTHRVQzl2djlaNXF3aENMcDBGelgzV0dibDh4?=
 =?utf-8?B?M1YyaFBLenNONWFTOEovT216V3poVkRNNGN4amc4VkpOOHh6b3NOTUNMblZG?=
 =?utf-8?B?aWR0VnZiQTFpdmpJdjlMMUVqZUJMaitVWGlubnVic3dDaVBPY05EUWZxYjRQ?=
 =?utf-8?B?WVpLRXcvSytKL1N3VVdzYklBblBKVkgxdGh5Sjl3WUd3TnAwcHZIS3RuM3c5?=
 =?utf-8?B?Mm9mWmNLV1RYVmpVQ09xSXZsTm5Qc01GZXdZSC9BbVFEVUQxN25oaW5lWm5j?=
 =?utf-8?B?ZUdnbFRxc3BCbGxyMXpYd1JxWlI4R2sybnNidGNJeFVjVzJ2dVM2dkZhWTdl?=
 =?utf-8?B?dnJhcnI3RXNFYUlBNkMxaVd6MDJoOTdoTjM2ekl5YnhRTHY4UEN2aTE5T0o0?=
 =?utf-8?B?OG5Jb294SllLLzRzVEZKK2ZKRW9OdEgvU2djck82V2Z4YjVhZEcrdHBmTnR1?=
 =?utf-8?B?RU5SeTRwOVF3dncybm1vdG5KWkZoYmFROGNlYlQxVE41bllLSXNzZW1vN0Rr?=
 =?utf-8?B?VGwyN2poR3JvK3VLL3pkMUJ5Z0JNVFZXa1FGTStvdStKdlFtaTdVOW53QVVC?=
 =?utf-8?B?MklJZ1dub2N6NmlZQkNERUMxdnVkUU1rUFF6d1BjU1d3TVhTbk5NVmxrWDdV?=
 =?utf-8?B?cENCL21LM1NMVHhNMC9ZcjZFVTB5OVRGSkVPdTNsTkg4aTdKaWMyb3RQNHh3?=
 =?utf-8?B?U21nZlZZRjluOExyUTlsaDNWek9hU205RUlBWURrMzUrRVkwcUlTTTB2bzJt?=
 =?utf-8?B?eDV1Mkprd3lUdGM1Q2gyWWc4K1VMUlF3a0NoNWhBUUNrSGp3UnF5NmZRQUYz?=
 =?utf-8?B?bmIxbHphL1c2bFFjaURTdFUrM3ZlM0dWRGdZbU5sekJSR2F4amtxSFB1NS94?=
 =?utf-8?B?NzNYeEx4WFI0UHlyQ0E3TStpdjBETVNFNFZDTGVHQ1JNSFMzeFMyanJxTnIx?=
 =?utf-8?B?bVRYNGgzMDFSZjlteWdOVVRGTEtUdTV0RVBKN3JJRFNCYXMzNUdicUJRcjh1?=
 =?utf-8?Q?ZgL61tR0seVNkI+0W0pQsQOo3rilmwBTGvS7k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUFnTnNlYmV1OWptM0hUSWFraVQvMkZBSkxXR0JNQXpKTWdVYUhqTUlHcDht?=
 =?utf-8?B?dGZWNVBBd0laZUhqbjQrSzEvVitEbytSdkFtbjdwdktOVmd0QUgzN2ZOM1dt?=
 =?utf-8?B?MUdlcGFIUWxqdXZ6TVh2dzQzYVJsZ3RONkdabEdmT01NZnphWEJ5ODJnbVpX?=
 =?utf-8?B?S24xV2xINTgzeW1BTXJ4RjRicFpMOUlpT1NZcGhFWUNQRVBNQzV4T2ZPVzVZ?=
 =?utf-8?B?Mm5abDhzSytkb3h4clY2RlZsVTYwd3YzTUlVK0QwUXprZ2daQ2M3R1VNM0tC?=
 =?utf-8?B?a2oreFVwSmlhaTVpb1Vidm1VUTA2UmMxbk1ua0dOK05BYTBJWnRjdndjS1JS?=
 =?utf-8?B?YzNhUlZzVTNsMHZwRitnUHpHdGt2c2llRm1YSnlwaTY1UHRVQ1BXM3AyeU1y?=
 =?utf-8?B?ZFEwNU9objFkUUgyanQ3YkI0MElBdklVak81NEdoV3NiYXZOYWRZWUdESDFS?=
 =?utf-8?B?RTBXSXhpOXE2eHoxYWhqVE00TzZscEg4T2RlbVdNUDhZUXZXcGJPalRnRkkx?=
 =?utf-8?B?c2d0OGdYZnlvUVdkZ0crMWRxOHRSYkkvTTdzYW5wTEdRbGhQTUgwWXFmZjBV?=
 =?utf-8?B?R3B6QnF1YnNpQXM5MWxDbXo3QUZlL0dGemFPdzdaNEVOY1huWWYvcVVZWFdW?=
 =?utf-8?B?YzdIUmY0V25jam9XOGZQVnd2Tkc3S29leStGREhydGdEQkcyR1Fib1llcVBr?=
 =?utf-8?B?WlBWVFpRaVhCRGpUcjdmRzNGcEljRXdTR0NKK1lCZjU0MVdRWlY5NmF1dUR4?=
 =?utf-8?B?VVVTMXA4UmJPWm9YWWhXb0Q5dEJiVzNPU3ExUVQvYVU4VkxOMHNBSnZWRnU2?=
 =?utf-8?B?ZWpBOUVsNjhHY0dxM1R6SFpJYzFDYjBpK0pxNmdiSDIzeFJKQW1KaW9sWnB3?=
 =?utf-8?B?NnJ4SDI5ZFg3YlVibnFtRm1zU0RHVkJrVlZ1SndPMlEzVGtlS091VTIxTUxL?=
 =?utf-8?B?ZTZYaG9jZGdieHE1SDlkMnhrWVlSQjlpMlF3OEpVV1cyTGdoNmwvQjM0ajVX?=
 =?utf-8?B?YVJTNFk2dkRVNFdUd1BQZmZTMHk4N0hQZTZMQW5LNDQ1VUpLMEdkYkpuYVFC?=
 =?utf-8?B?Q01vYlRmbktNRHJadW9vdDNLVExGNmdHUzgraXhHdFVjdXo4UmJWZHZqL29G?=
 =?utf-8?B?NWlyWFZURHpHUWI5ZXFXT092dUdDUk5NekFYUXdJNWNWS1Z3MDRhN29qWUhr?=
 =?utf-8?B?NnpTNEJvaForZlRGN2dDMkNWYmZ2TW5CejlORm1vRjAvNlRrYnkvQzV5U1Bw?=
 =?utf-8?B?TGNoTmluYmJHZExCSXNxdC81dW1Oelg5S2dsUlovR3djalN5YWlHVDZ6Vzhq?=
 =?utf-8?B?N2FOYnhmN2ZVWnZva1plUkkwRmwya2pPWEpKTGZOSHdZTW5TRjJNZUxMWFdt?=
 =?utf-8?B?ZWlmb2luQ3oxNXpWdTRzdE90ZnRuNVd3UXFweUZqWXp3TkdJUDk1eTA3cTYw?=
 =?utf-8?B?MTR3cmxsb0hRUVMxWGhQWHZZRGIrWWpNdkw3M2hrUW5aNFlVZ0xib0k3UWM4?=
 =?utf-8?B?U01jTThLUWExNXh0Rlp3VnJQcktML3NmZDVFSEo1ZUZyOVo0UCtadFJHSUwv?=
 =?utf-8?B?VEU4SmN3QXR5MzNsanFHdlFUUFlzREZVZTVjM0RHRkRPSFJwSzluQ293OUZh?=
 =?utf-8?B?S3FyV2RzSTNUV1V4djJ0b1h4YkZyQzlsS0FVK3F0WUZEZVFkRjkxVCtidHNq?=
 =?utf-8?B?WWlDZ2d4akJ1ZlZFeVN6OHdCK2JheEFHdHBCckJBM1FhYzZkb1F1TXozMDVM?=
 =?utf-8?B?ZXF4MVJXdC9abVZjYkJMbzlLZFhDR1kwT3pMQllPRGF5T1ZpODFpalJUTHNa?=
 =?utf-8?B?dzEyTVROc3dEa3BsZVhHcDBTcmNTVzV6UjJVSytObS8xRGFzbWYzWURyYjVt?=
 =?utf-8?B?OVlDQ1FnTURhRWhJN0VBcXdpWVgxcFJJaUwrODcra3NaWkNNS0tCRDhoeUpz?=
 =?utf-8?B?cjJ1L2d1RWF3d0krNW1vanhvSlJjYytuWWVaRWZibGtEMThmZ2hpVkcwcTZG?=
 =?utf-8?B?UmhrbnJaY1ZmKzgyb1BZYjZNTDVZamp1NkIxTkNSNnhhM0twTi9aZmoyRkQz?=
 =?utf-8?B?Nm5saW5TQTVYakQxb3d1K2IzS3ZCbGV5QWYxeVNJdndUTDZvOVZXZVgwTXhy?=
 =?utf-8?B?aTJSdmlSazZGN1FmSGpockVWeE9ETWxYbEdLSDYwRDA1UkIyQzZFZFN4NjBs?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cab993-e8e7-4d73-6799-08dcd1913cf7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 12:08:10.3855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu6ZtCY3jC02OQbiOBIBYzJNResFlHoUzzVbnU1Mb6nT5fMpq+xVoyI2lD5TwoVNf3MP0RdGmijy5YslhFEnGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6135
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

On 10.09.24 08:38, Sumit Garg wrote:
> Hi Jan,
> 
> On Thu, 5 Sept 2024 at 12:08, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 04.09.24 19:29, Frank Wunderlich wrote:
>>>
>>>
>>>> Gesendet: Mittwoch, 04. September 2024 um 19:16 Uhr
>>>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>>> OK, our overlay sources are on their way into mainline, will only take
>>>> until 6.12-rc1 to get them here.
> 
> Glad to hear that.
> 
>>>> To accelerate the preparation, I ported
>>>> that change to a local branch - just to find out that OF_UPSTREAM has no
>>>> clue about DT overlays so far. And it is not just that there are no
>>>> build rules for them (that was quickly fixed). It's also that there is
>>>> no way to trigger their build for your u-boot proper.
>>>>
>>>> Are there plans for addressing this? I'm inclined to revive my patch
>>>> that allows to augment dtb-y from the board's config.mk. Better suggestions?
>>>
>>> Hi
>>>
>>> i hang also on this part, in my case i build the dtbos for the vendor and try to use fdtoverlay to merge base-dt with the defined overlays.
>>>
>>> see commits till July 11th
>>>
>>> https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/
>>>
>>> this fails because the target for fdtoverlays needs targets for the dtbos (have used the fdtoverlay target from linux)...
>>> but i build then without dedicated target (while building the basedt).
>>>
>>> maybe you can help solving the "small" problem in makefile.
>>>
>>
>> This is close but not quite the same scenario because I only need "our"
>> dtbos, and there is no need to create dtbs with them applied (they will
>> be used during dt fixup in our case).
>>
>> What I've now done is this:
>>
>> diff --git a/dts/Kconfig b/dts/Kconfig
>> index 569d4be338e..7ea4fd5a79b 100644
>> --- a/dts/Kconfig
>> +++ b/dts/Kconfig
>> @@ -226,11 +226,11 @@ config OF_LIST
>>
>>  config OF_OVERLAY_LIST
>>         string "List of device tree overlays to include for DT control"
>> -       depends on SPL_LOAD_FIT_APPLY_OVERLAY
>>         help
>>           This option specifies a list of device tree overlays to use for DT
>>           control. This option can then be used by a FIT generator to include
>> -         the overlays in the FIT image.
>> +         the overlays in the FIT image or by binman when assembling an image
>> +         that uses overlays during DT fixup.
>>
>>  choice
>>         prompt "OF LIST compression"
>> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
>> index 790f3c508f1..dc181240a21 100644
>> --- a/scripts/Makefile.dts
>> +++ b/scripts/Makefile.dts
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0+
>>
>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>> +dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>>
>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>  ifeq ($(CONFIG_ARM64),y)
>>
> 
> Yeah that's all you need to build DT overlays from dts/upstream
> subtree. Care to send a proper patch for this?
> 

Can do if you already want this [1]. Our tree [2] where it is currently 
included still has to wait for upstream 6.12, possibly even 6.13 as we 
need one more overlay now.

>>
>> I will also provide a patch to enhance the machinery in dts/upstream
>> /Makefile. This apparently plays no role when building U-Boot, but it
>> would still be useful for validation purposes to have overlay support
>> there.
> 
> As you mentioned we don't use Makefile for U-Boot builds. So it's
> better to directly send that patch for inclusion in the DT rebasing
> tree.

No, this is about our shadow Makefiles, see [3].

Jan

[1] https://github.com/siemens/u-boot/commit/2be0393b1718990abf2feb0b13dbaf79629ce692
[2] https://github.com/siemens/u-boot/commits/jan/iot2050
[3] https://github.com/siemens/u-boot/commit/de3df1fed47d2075bb3f9ecccfaa93a368b58924

-- 
Siemens AG, Technology
Linux Expert Center

