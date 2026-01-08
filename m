Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C5D1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C211F84150;
	Thu,  8 Jan 2026 17:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DhU52DAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F2B84158; Thu,  8 Jan 2026 17:21:02 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5472383981
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGZ+Wj7b2Guh+uZNrWwUjqK3541XqYKaxheGtX47XPIUHk74C2KTSHiC1J7PzbpjLYkVESRgR05derDfvojAnj2oTi8co1YpmfZb2FPxdjgr3paXl5tWix57t+dIlzhGvddG0o199FwWVaklycVO0IEUQmu7quvtPGHNWj5GeHbLm0FqlMg3NTlXCbDDT5QnjtlaZ/v2ORBQuhwbkeNEo7tm6NN83HSjxsjedi643zLucji1zh7ciX+FzFOL9aOWR24UHc0ZCjC86g2R4fqOmUyPnCkJif0hdj/5BrJWkRcuqPUO8c0Xn0bTog2mb1pNyLVyH1LNxxzDhUBWSDSwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8upoYNoy7ugWBZu+/zs3N7S4xyzRILWcXJ9nZYEhy9Y=;
 b=MOsOTGsr85tJBOdVI6ePc23iDm+g7DN85Csqrp4GVVhUpaObs+KRuBeolDS0ZLpUf555JSUjm1M0q5C6Hvw73ZBgeLhApyY5pcfyj++jDAheCxgVOwoZQVQpZrXNqibLfpMt/HGrU334hmh60D1FkWLiJKQ+AQY+//tA1YjRhnKSg/FgONOIPLoSi6A5Kcmq5S7TXg4tk2Vjc0/Y8BWGxlnmCfCltp3dtGX4VnD3VV6c+J0Yo/+1rHqaLbuE+5MyLoCHQuCu19ZNfZ5PDpscd8eCWNDbzHJJwa2Ksla9o75fXB2O/ACg1C+P2ybjVTHIrGu3OnxjTMWGEtJCZWvkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8upoYNoy7ugWBZu+/zs3N7S4xyzRILWcXJ9nZYEhy9Y=;
 b=DhU52DAJzDPsb2d0D8BeyojTaIP4D7FAbSvePVWe7zt8q8YjwLBzu4QqVHFk0v5Mip00chjggeAuxiFXA+nd7W+y/EAleSWZwLAhBS/AiQKXCOpImHwUnGaStt/FlApUsFC2/fT5V0xq+qucYfnDvoKTMt5dN4tpwkhWlGXg1XI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU7PR04MB11234.eurprd04.prod.outlook.com (2603:10a6:10:5b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:20:53 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 16:20:53 +0000
Message-ID: <8608a798-183a-4f07-bfbc-1f45ae59a6ee@cherry.de>
Date: Thu, 8 Jan 2026 17:20:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-next-20251225 (for next branch)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>
References: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0156.eurprd07.prod.outlook.com
 (2603:10a6:802:16::43) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU7PR04MB11234:EE_
X-MS-Office365-Filtering-Correlation-Id: d61c6876-5342-4afa-ae26-08de4ed1e53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTV3Q3ppdE5jSkY4c2VpUHhQVlJiN1hzQ3V4alNUcXpvQWdYRVljU2JhMVNo?=
 =?utf-8?B?bHhnamRTcnQ4cjlHZXRRYWdWdnh2ZXJUVmNzQ29rWmdiRnVLRktPNjZEWndi?=
 =?utf-8?B?bGczMDc0Q2NLWSs2OU9OZGNOa3F4L2RHaEl0a1lCckhyQm5JV29veG1ESjBL?=
 =?utf-8?B?UFZSWmdoUW56a2h6RlJjRzdNT2FaZGFrNCswWHliQUw0VkZOdnp1OUErMjRD?=
 =?utf-8?B?THg2a3VwQk1PTGplOU84UGU4TUl1VjB3MWlBekdVbnUyRERtbVV4dFdPeUlH?=
 =?utf-8?B?Z0prbXJqTTM2Qm9PTm1BLzVJTmcweFJhRVVjR1FBcjNCNnNpZ2VxOXJhaWMx?=
 =?utf-8?B?ejFiYkhRdnkrR3JsZ2w2ZTdxMHNwYUVhU2ZWRFpaOGdPU3JncHNMMmlzVWdw?=
 =?utf-8?B?a3QyYkZFNzVEYVVoSTVTZmJGMjNxNE5kL2g3RW1DdFlOc3JIcXpLdU40RFpI?=
 =?utf-8?B?TDZRQnhueEFPWmRva1BkRU10THRrZjFLa3dBTzlWNWtpZXBPcWRqbDF2SnUy?=
 =?utf-8?B?SXJpT1VDU0JrTmNCQXViR3FJSVc0M2grVTFsU3RYcE1ZME1JZkNnejZnWlVG?=
 =?utf-8?B?bnBqdE1TYmNtODIvQTF5SlQ5S1JRQlZmN0J1dlowalRRRGJkaFphUVBKYXdS?=
 =?utf-8?B?ZkU5aGpRdFVpemMzbSt0MFBvSDl0bVlHWlJGckczQXJkdWoweGNpNFA3ZUJr?=
 =?utf-8?B?eXE0OVlHYWMvSkM0VzE1YkRLcFlqU1BqV3dHTlFZT1dXVk1rTlFxZUZiOWMx?=
 =?utf-8?B?UzJsQlFMaFJESnJMUlRXYVF3RTlRZTdicjNFUEZKMldIS3NuMHpQTytPZjha?=
 =?utf-8?B?OEhQbUg1aEkyejRYTHJSV1c5TTlManhPdkY3Q1ZIWGxMWUpEdEt4UFZXbFgx?=
 =?utf-8?B?cU5IUTYxZkpzeDJKOVpPUkgxcmNNRnUzdjFvK1JxV0tJQTE4MDJKdnFzeU02?=
 =?utf-8?B?MUpZSXlXOUtzVUZya3VrdFF3ZmtBeS94ejBRWDlkK08yV0ZXcXYzSzNmNWht?=
 =?utf-8?B?YjBPZS9Gb2VWemlqS3lNdmc0WFpYRzNET3h1UTlhNGhLMkFCdU9IVnhzRURn?=
 =?utf-8?B?VFFFaFZpZUNHaHlpMGxsRzZkbEgwOHZGSzZRVmZ1TFhmUXU1Nno2ZUtUZHdo?=
 =?utf-8?B?dnpacXlteitQL0p6L3kwdDc3MEJkTlhiVFArTjVMTXNZcmNEOWI0QlpZcmd6?=
 =?utf-8?B?SHFISFFuN1FIcHdGVUN6RjNRdHkvVUNVNWQ1bnZ6Qnp4TmJUY1d3ZHQ1V2Z3?=
 =?utf-8?B?TnI3Rnh2VUdIcjJIQ3NLMmd6L2lYT0xacEtBM2hCc3pvdjYxaHQ4YjFvU2JL?=
 =?utf-8?B?TDhrQ0J5SkwwaFhuNmxBNzVhOG5kTXZDR0hFTFhDSWtncmhabW01YWNrdC9a?=
 =?utf-8?B?KytEcTFPS0laZVd3dE1nZGVTZlIzeEdWbUpKQ2l4U0FsNS82R2xPc1RnNmw4?=
 =?utf-8?B?UGRZVUdqU2hob3F0WHVtTkhRSVhZR080ZTJLaW13TnlOQnVsUmEvRmJkRzl1?=
 =?utf-8?B?Y0dWc0xVTTZGaDJWY0RoNElnZktxT3pQT1B3eGY0blVvOWlVMFFISGJLRDUr?=
 =?utf-8?B?eGlFQkt6UHUzcTBlelQ5aGVHZVltVWZRRGhPQ1VrV3A2VnRxaVNWazdxNE56?=
 =?utf-8?B?aS9SSDJ0aDNwcUd4R2FzdlRpc0tITGFPalRxc3hXZ3B2MnpJSXhXWXc0bm4w?=
 =?utf-8?B?TWlsdVJZNmNFUGhIeTYyVnNkOEhvV01YdTZRUEx3dDdFRlZOZWZKRFhkeGpy?=
 =?utf-8?B?cWplVWoxS2Qwai91dk1pcjNaSHhYWlJkdlE0cnlaZWpHMEQ2c2NQcTZER0Jh?=
 =?utf-8?B?WEI1TUJUMXMvV2ZVdmJVKzhxMk0wNEM4cjJyeDFOdnlTai9kV3V3M0NoVEt1?=
 =?utf-8?B?N3hxOXJHNlJuQmNDRGlvL2h0ZTB6dUJDa1MrQTJJNUdsYWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmw0enBYNGtDSTRNQ0d2dDZVdnNtcnkvWmVlbmVWYWJiWHo5V1hEYmhXZito?=
 =?utf-8?B?amd5Zm84WUtmcjVBNEFDeDVQODdJeWNkajBzTEtnV0dsR3UxS2FSdzllREgy?=
 =?utf-8?B?RWJsSjdHZE1zcEpQZVRRMGhjRTYrQ1o2ZzNXWlV5RlB4V1RvRW5WeGZPalg3?=
 =?utf-8?B?TjlsUWJyRHlFYzFIQUJTby9oVHI5NkdBSDh6Q293ZHJRYWpwL283Vzg4MzMy?=
 =?utf-8?B?RTk2R2dRNWFCWGpCakN4UzNEOEEwYjJNQkFqdE9qTWw0TEVCaGlCM3JSdGRM?=
 =?utf-8?B?RGhhNWZsKzBTVlZzU1RVQ2VBanBndVNuZFlpeXFxdis2MzQ4UjVoMkNkNlB3?=
 =?utf-8?B?SDRFTjZQSGxucnhIRkU3SldRVlFOVUV4bzdIcmRtbjhTcjZGQ21zWHFEMlVY?=
 =?utf-8?B?c0N4b3hONU5nQ3M1ZXo0U3pUMUdJZGcxcmVpOFFEUVRGMHdDZ2xveVBacEpV?=
 =?utf-8?B?Y0FFMW8zVy9sN1VkRDhCYnh1WUpXdnBYSERlMzd2cUJNL2Vpd0F5dWwxSjcz?=
 =?utf-8?B?UUkxTGVlVGFqWW1jcGVhVUI2L2FncnlOcEFBVWRSOUx6d0E5OVduNmhyVzky?=
 =?utf-8?B?QVdSMWdxZFNnYWZlaDBJNWZIZFQ3M3FGQzdLMENxZm1GendrQjlpNWFob1NR?=
 =?utf-8?B?aXBLYktTK1RoRjdrYXBibU5HMDJrbFRYWWczNi9rUWYxN0ErelY3ZU0wV2tp?=
 =?utf-8?B?Vm1LUzJWV2xoV1p3dlRQL2h3bDFYOENBa0IzOVprVnJPTkZSeUVVK0hrWHcv?=
 =?utf-8?B?Q1Z3UjdCNlQyWjRFOVZQSXZwMll1NHYxS3RZUzZ4OWRiTmV2bEdQam9LYnJX?=
 =?utf-8?B?bUxEVU5qSEZhUm1BM09TTnZ2NmtwZHFrRko1eUFxOEhWYTlxd3RodS9GZ1Mx?=
 =?utf-8?B?UDYxRFNtV0JoUXpzdnIxRTM2R09UcjgrVzM1WlVQNVh0Y1YvL1hmaWhINVI4?=
 =?utf-8?B?VG1IVTU5a2dySHVnaGtsVk1SRUlYOUtxWWc5MGNmWUJVNmFnRFhPcnhaZkcw?=
 =?utf-8?B?NHprQnNsaXI1dVI0VnZBaXRGMEd6d3RTNllGSWdLS3d0OE5uOSthWENvZWNO?=
 =?utf-8?B?YWxvUVl6SUYrTXNCT1FDemMyZW9lN2pGcFFGS2RjRFBMVE5rWTcrdkpDbzFL?=
 =?utf-8?B?M09WT2J4OWdHV1d4YTQwclBpQXdWbVA0dHYwdThmTWkwU2Q2UDNoUWhWNnUx?=
 =?utf-8?B?c1ZuZFpmdG9PVzRDRW5TZG13ckt4UUIxZDVleVY3dHRvM3FBcHE4b2JILzhE?=
 =?utf-8?B?SjFvVnh5QUw2TlhkaitUNklLN3c2UjVCUS9iSzllc3lsdFZsL3RrN0MwVDkw?=
 =?utf-8?B?ZkhnWVJnc0JoYnI4NkJWUGJ3eDNyQTZ0ajFEMmFxN2dkVnhpRm1xYkovWXI5?=
 =?utf-8?B?cDlOaUdxeGlOTnV0NzFzK2RUVXF5dE5XKzdQNnZqNGN4WVZqV2lPOWhwSkpn?=
 =?utf-8?B?YW5pSmVzbzdxQ1E1QW9iMUxtQUJiSHJ3RXN3U0FabGFrdkpTUVYxcDFIUHFz?=
 =?utf-8?B?amh2VHdKem5POWpqdlREMWZiS05YRlZEbTRYTjFLZGJ6WmZzN3QxTGxaUmVp?=
 =?utf-8?B?c0pPcE5PR2U4OXY0NEdjZHd2d2JwamZsS1FZZk8yckhOeEhlTkU4Q2J2UVN4?=
 =?utf-8?B?VFJNMHZUNEZ2TlVjU1JUQXByTlo5TVAxQ0ZXWjdXb2NWRG1SQmZlYmdOdERC?=
 =?utf-8?B?ZVlKSWZWTTJpZkdyQ290QWQ4NUNMZUhWLy9zRENlY2NFVFlFdzVSVmU0Vldr?=
 =?utf-8?B?T0hKNFlTM1ZJdk9HNlZjeno3QmNSbFpmWjRkaUFneldmaU5hSHM2RVlKY3FL?=
 =?utf-8?B?S2lSNDlvVnBqU0JTMVozZElzNldpMjd1cDJlTG1zbFlnY0RWRmQvd0NQMEJW?=
 =?utf-8?B?YXVXZzhtYUY1WTVzTnRlR2FXZFc0THZUOGp1QWFvUGNMV0I2S20vVGJFVGND?=
 =?utf-8?B?NUg5WmwyYU9lQVJTV2lxb0ZqaDhEa1pjOG1oem9UUHBoSENuN2xZODVyTVc2?=
 =?utf-8?B?RTNTWW9iY2JjWWFtdEx4em93VjNCMFpDcGN1MmV6Q3NJekNXVExRdTlOdHNz?=
 =?utf-8?B?WXptbzhKSWNoQVJDWFd3RTBPbVJiN2cvdWNYQWxmU1ZjT09kdmRydWhnZmRs?=
 =?utf-8?B?b3JmKzkxV0tadzhab1NhSUJhdUNQMlM0UHRvdU14d0tSYlBPdzJ0ZGhUY0lF?=
 =?utf-8?B?R1E5bHVvWUwwMzREeTlEQWU4YU80eXRlbm5IVllZQ3Zla3phY0xCUlZCTWNM?=
 =?utf-8?B?cktzR1NJNWo5b1ZRNWxDanFGMzVwdFAvOU5tTzRzZi9DbklsVVJqNmJWTytY?=
 =?utf-8?B?cDJMUEpkTE1sODdwQm1PQWNieHNmQmZHNXFLOVhVMnVpOWFwY3h3Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d61c6876-5342-4afa-ae26-08de4ed1e53e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:20:53.5432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyOAMqoeiUFgdqBeN1NJntFsKxL3WPdE71voH2m0Pok9frVlXB1fT5f7O6LD0PX0mtgqr6K3I0t5eunRQRAkS9a8Zc9TdCLg+WSvXIhBwUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11234
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

Hi Heinrich,

On 12/25/25 11:13 AM, Heinrich Schuchardt wrote:
> Dear Tom,
> 
> The following changes since commit 
> baf076aeb32dcdd2b022405088c3288ffc160fcf:
> 
>    Merge branch 'staging' of https:// 
> eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- 
> tegra&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de439e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931009936%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UrWok7nyXyLT97iLd1o%2FxUIuYtwkRz7DcO8D8ogdH7Y%3D&reserved=0 into next (2025-12-23 08:11:36 -0600)
> 
> are available in the Git repository at:
> 
>    https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- 
> efi.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de439e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931023452%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=noF%2B4QWCdd9uds%2FLv5wxiCynT7PNTHKQFnDHXYn2%2BqQ%3D&reserved=0 tags/efi-next-20251225
> 
> for you to fetch changes up to 4c105d2ae7b0f847668ff1ef6b410f63ab4290b7:
> 
>    doc: board: starfive: update jh7110 common description (2025-12-24 
> 09:41:57 +0100)
> 
> ----------------------------------------------------------------
> Pull request efi-next-20251225
> 
> Documentation:
> 
> * Update StarFive Jh7110 common description.
> * Describe command line options of the bdinfo command.
> * Describe configuration dependencies of the bdinfo command.
> 
> UEFI:
> 
> * Trigger capsule updates with automatically generated boot options.
> * In the LoadImage unit test add a check that device-paths are correctly
>    used.
> * In the variables at runtime test remove an unnecessary
>    __efi_runtime_data attribute.
> 
> Others:
> 
> * Let the bdinfo command output device-tree information even if LMB is
>    no used.
> * Add long help texts for all options of the bdinfo command.
> 
> ----------------------------------------------------------------
> E Shattow (1):
>        doc: board: starfive: update jh7110 common description
> 
> Heinrich Schuchardt (4):
>        efi_selftest: Enhance LoadImage test
>        efi_selftest: remove unnecessary __efi_runtime_data attribute
>        test: dm: clk_ccf: clean up assert statements
>        cmd/bdinfo: LMB and device-tree are not related
> 
> Ilias Apalodimas (1):
>        efi_loader: Trigger capsule updates with automatically generated 
> boot options
> 
> Quentin Schulz (3):
>        cmd: bdinfo: provide long help with all options
>        doc: cmd: bdinfo: specify required dependency for some info

In the future, can you please consider editing the commit log when 
you're doing modifications to patches when merging them?

Something like

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
[added symbol dependency to lmb_dump_all]
[removed CONFIG_LMB as symbol dependency of devicetree]
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

? So that there's some info about what was changed from the patch that 
was sent to the ML and by whom?

(Maybe ask for permission before doing this as well, or maybe we should 
have documentation on what can be expected from maintainers to that 
regard? I know Buildroot does this a lot (and often silently), Yocto 
sometimes, but the kernel not too often, and it's the first time (that I 
know of) it happens to me in U-Boot :) )

I'm generally not a fan of my patches being silently modified before 
merging, though here it ended up fine so thanks for sparing me the 
rebase+v3 respin I was thinking about starting to do :)

Cheers,
Quentin
