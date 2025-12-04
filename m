Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55316D1CDCA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B9F83B87;
	Thu,  4 Dec 2025 11:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Kkt/23Qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A07C83DA7; Thu,  4 Dec 2025 11:23:43 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1046E83B1E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLgbJSSPOF9ugvnZq0TkryiZJGhWtGOnh8F+dLjOG2uhwEwt0hsSi6buXPDqoz47FN5eWZ09hEbb5nEOIEsoWAXlohCoIdmqhrM0qxJQGtXgihXcEQK+/HAz1FMm31ZULExZDatu4jluSSwSIxAlt5V180fuRd9iGshTCmgeCCqu/qUqXw+FPfnNz6ZKknE+zyqLYZ9J70LXh9eQT3KVprqFcWz6Av958YZfpUeuFrIPXo5HSUZliRORzT9N5pab/IqaHdjrQKdfzvc61XHcvpwL3nt9HcS2hNWAAbsF7G/qqJyWZwTWewaKfFrzX45tCLLTO2ORFGNKBx0h/HmBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzOabHRFg3c/u5LodeadQ7rWFZN920WfWXRCdECC8nA=;
 b=PLtEqIAuNsxway85vDzL7jC+UdzI+qWJC9pItr2ltfU2++7GHOVI//hOD415U2SuYlg2l7yhM05KW8gvqZW9YYIRCa16fjy84ZyFy71d8wZoMzk7GSd2X/VhWKVsP0UjJP2Z5al1S9pEPReIsaaFgs2gBzxuOGGb39z/v/7Gahiq18+yskjUPO+ZhH+zrS1R5U7Sw8o/gfA2F4ysaybz5clBBMCBhxeWSbVtK/Xg4KDcJUKqJciJBJjKXDfaTi5tZNNJn8FBwsp8MWbwzXXEIE0Z1e/r+E7+8n9nvrpS//5GAa/oJkYJKv6dtpdxJskuihUfhDgoFxvscaQHJoi6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzOabHRFg3c/u5LodeadQ7rWFZN920WfWXRCdECC8nA=;
 b=Kkt/23Qt5hexo/ZDGFOFXmY5xYEP844lpzKjyFxc7+se8vMvzYHzGdSMOVN8yRMXhGg/J8j+B0phcdVmPtx1oeMZynK3HzupJXVEswk/RN05lTYzlHGZIoZpZwjlB06jJ9iwk3zy2KAApS3niD7I/Rbp6z7IJjsOO1yw6jpC/es6zBQDZg/nUkFaTNBp0TTVQy5Ua+ioFqmDqqf1Mo/sZB17Ma7gQYYlRd8pip/kSMaXOt8/fOnyxrUWKLCvj7X4s5VXmmXoJZXgNfq65LJzbTQHtzWGLTsACzrk0Qcd6ATGhYnaSAlLONoX2mXNYAShIc9lRFWSF7W31KnR22rvHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB5267.namprd03.prod.outlook.com (2603:10b6:a03:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:23:38 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:23:37 +0000
Message-ID: <e792a0ca-93f9-4c81-9458-1cd863c06cc4@altera.com>
Date: Thu, 4 Dec 2025 18:23:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [resend v2 1/1] configs: cyclone5: Enable random MAC address
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>
References: <20251202053626.6446-1-alif.zakuan.yuslaimi@altera.com>
 <20251202053626.6446-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251202053626.6446-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 42308e85-6588-42d2-273a-08de331f2ff8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXVjc0hTcll4SHR2aFRlUUg3RU1zZkxUWTE1TjNpNEExNThRT2pROENZcDRO?=
 =?utf-8?B?TllKY1FjMHVVdXlhcTQ1WTRZQnZqVklpYlRMNFhkcHBPVW9LeEhYbFJsck5W?=
 =?utf-8?B?M3NobWlFdTRneGMwVGxSRUd4Rkp2Q2FRUEVZRTAwVHpEWnQwa28yckk3bnND?=
 =?utf-8?B?K25pQ2tFbFNUTCtBU3E1OTUwc0tyOXFrOTVUTzBSblBLRFNXWis1em9mN0lD?=
 =?utf-8?B?amN5T0dFeWFkTEdHUlMycGJ1YmdmRUlBQUFPSGdMNlpuc3VTMVZHQjhIREtG?=
 =?utf-8?B?M05mbjF4SnpieWtzN1RjUnZjeGd2RzJVaTRLRGtxMnRvN2ZMZno4djdQVi9s?=
 =?utf-8?B?NlBWR09nODRWVXFpUGc4aWsxak82VFJOeGp0c3FqaHQxYXh1MTBCZTRnWngr?=
 =?utf-8?B?V0x2TGpQeHhpTVNMZVJLRExrQUFoN2tsL0lad3hBZzJhamFZdENPUFlzNGpG?=
 =?utf-8?B?RTJxYnlXK3VkZXkxS1BmUUowQ2E3N0FXbnhydzZsQUxsaHlhZFFnd3FxWGhV?=
 =?utf-8?B?cU4xN1Nxb1BpNklTdXJPcDdhMGdPTERtT1ZMTUFvWktvS3FqZWlBM015TzZ2?=
 =?utf-8?B?YVRRdGVlQklNeGVESWZZb3lrOVdTeUlhaEZnRVJFZnVUYjlBcVBnSTdwMW9p?=
 =?utf-8?B?QmhXQUEvNHJYSE5RemVENUV3cFBoeVVLdEltUHA1bHp6cVlaL3oxSk9XMzRR?=
 =?utf-8?B?cUYyQmp0eWdGQkNsTkVIOWt2d0k5UHlrNGtyandYWXFMdnhrbHBxaG14anRR?=
 =?utf-8?B?bE0ramc4K2IyYVBscW5SQWpoMlNlZ1BnWmM0SW5tTUVZTE5WNGVqZ0s1ZTFl?=
 =?utf-8?B?ZDJTbDhCN1Z2VWZTMldMSFBMVkNha3pjTzVOSTg3aDRNZENsZ3NZV1pxdjNt?=
 =?utf-8?B?RVdDbzZyU2h5OFVxYzdJcmxlOG9NclhlR1hpaVI2YW1HaVBqU0VGM3g4RnJX?=
 =?utf-8?B?Z05KbXdOYkFENVRkVjJiMlBraGd3eFFVRHhMUXNXR29aWEttbXg1cEoySVls?=
 =?utf-8?B?YTJUY05aNWRIN3NnNVR0aWJYeFdMRzV1QVMwcVVjNVFvYWw5aE00VmQ3dlRr?=
 =?utf-8?B?SXZXMC9SSnJldDljTFFXMExzbDgxRTRYSzBxN3ZyOThwSERXVzJwQlpDU28z?=
 =?utf-8?B?enpnMThzVDM4Wi9Rd3IrdERudFBnLzZjdkxWOVErdUd1SHUzWmllckQwUWpj?=
 =?utf-8?B?TVFIR2h0V3lzUkk0eTFIbnk0dlBzRkVDaXJVZnEzNUx4NDRzZG5aelI4b2ox?=
 =?utf-8?B?QUt6V2JHdE95ZmFhTWgvYk50aWY2czNFYlpYQmFhUmh6M3EvOEM0N1A0WDRD?=
 =?utf-8?B?ZjRNRGZFL0Z0eURCKzV0alA5dHkxbFJ5aytUWlZtVXZpMUNLTVpHSUVKK1Na?=
 =?utf-8?B?bzZ3UVc2THRjRFIzbUtWM2tQSkkwOGJQNEt2dUoyY3hUMjZCZk84ZXkxWkRi?=
 =?utf-8?B?dWpzcG53SGVJNkZURG02bTB4RkM2U29YSWE2RXBhYzR6bG1EL0FpSHVqUnJm?=
 =?utf-8?B?eXh5N3dDSFREWEdVZ3E3MW5KY05pcDBFNmVhaWphRERsdWpaQ0lGcmtTV29D?=
 =?utf-8?B?bExaSHdUWjFVOW02eC9mVWtSd1V6aFppRUdEdGRuWmZ0cGRuVXlVVFRjY0NY?=
 =?utf-8?B?S2I3WjMwV2RnNmhGenRnUXlPbEhLZlZyczNZclRmOUo5TjdiNy9vdUlIU3FO?=
 =?utf-8?B?UUdrV2thOCt2RHRyR2dTWFo3Rk50bkhLL2U5QWxhZ1NZa2thamxwanRtWk1B?=
 =?utf-8?B?MXZZSTFKbVFVYlNuUkE4T09oeDRjRHZrRk9mZWlqK2dtYlIraEdiZWdXNmVu?=
 =?utf-8?B?ZE5lVENrdXZHK3k4SFhLMi9oc1VqSHdQaTdzWUlSb3VpOTBPQWthOGVDT2xu?=
 =?utf-8?B?WlFwVmlTN0xwcFI0dEJpSlJaSlNvK3kybDYyOWFlWHRBaS9scUFMSDROdVVV?=
 =?utf-8?Q?uzdpC4QpaXNVs/AAM59uaJ0+oD+fze9H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXl1V1hXRU41dStUQXBYbTQxTWljSFV3NTRIYzF1cittSENiZU94ZUxqY1d3?=
 =?utf-8?B?T1pFYUVBVmlLT2lZakUwUjhiWjVWVGJWVFIxMEhFaEZBajRhTHEzak5rNnVq?=
 =?utf-8?B?YzBkUG5heW1nbjBnU3ZoN1BZSWxHcU5uZ1htZzU4a3l3Z003QnZDbHJNTFRq?=
 =?utf-8?B?VWx4NERrRmVNbHNpN0lzZmxGR1hOWEhYeUo2dmJNaHNiYVBoYy9qdm4zblFD?=
 =?utf-8?B?Q1dRODNPbFI2TWIyeHVvb0ZkZFR5ZGJmRjRNaUdyQ3c3eXdwTzB0cEsvMlRj?=
 =?utf-8?B?QUtSYkxpYUY1NExyL3VwOXlsTTErd2tGUWsycU1XRGZDTzIvUG15dXZOZkth?=
 =?utf-8?B?QlhieTd3OU8wSEhkR0ludlRTSEVsbk8xeGEwK2tMcjNtVzhwN2RVYXltN0Er?=
 =?utf-8?B?YXVHTDhKQ1FxZWNtRzhuYjhtU1ZVSUYxNG4xbm5BM1hvajRCOUI4dWVFVjQ5?=
 =?utf-8?B?aVR5RVJEV3Z3WU8rSDN5ajNuak14VmRab1VyanZyY0JRcmRkWnBwU3lhd3FT?=
 =?utf-8?B?QXUreDBYMStVOUowZm9GQ3hXRStvMEh5VExOZWlkU1ZYZUlSZnpibWh6aTZv?=
 =?utf-8?B?WWxLR01BQ1ljdDBNYmQ1RWZiVmVqWEk1RkhJeHBGZ2J3MWZrV1ByUnVzRlBZ?=
 =?utf-8?B?Ylc1dVYvZXRac0MvZnFQSG56R09EeDFBbDRzZkxYNEFsdldwdDlCdmNDc0VB?=
 =?utf-8?B?a3Qwa0srUEMwMWZUV1dZRURYZjNxK0tBOS9LYWdwczgxU3NGbkczdjkydEZZ?=
 =?utf-8?B?aTJEZFFYVitzSzNjTWd5amx5dEVuckZwOC82V2s2ajlDb1Rub1ZpRDRlZjhS?=
 =?utf-8?B?V3krcUFHSG5GRmU5aUJ1eUp0NFZiZVNqS01Sa1BiK1MrNlZQaGNBQ1poTWxW?=
 =?utf-8?B?RFZENmxtM0VrQW5TT2drRnNwV09jY296K0xDWWs4a3ZQVTMxUytjd09vaXJE?=
 =?utf-8?B?RUxWRXhQRitkNUp1cXZURXNCOXVvUWhOcVVqTmZpNmI3bXk0Z25qUFgvRVRB?=
 =?utf-8?B?ZlZvZnM3cHAyYWg5MWE2bDY5L25hQ3cvRDNsVnVYaGZWZlljN2dGQ3BSYjFT?=
 =?utf-8?B?ZVA4VzlFNlVYYmF5MWVFcUdNS1B1YUhFSG9FNEJsalFlUG9vbTlTQkd1REs2?=
 =?utf-8?B?QkZiS1pURU9YZmVHbmdQYzNzM244QXpTV1Y4emFwWlJQSjVHVERSdU1Va3R3?=
 =?utf-8?B?Ui9sNUZ6d1ZrN0hUQ1FqaG9tZUdZOVJFVk9valg4dk5LZVNFSGNTR29QR2V0?=
 =?utf-8?B?ejNEWVZrM0RFb2NBamRNemJTdm85eVhac3U3czluWTlkSlN6MHlocHBTdVFG?=
 =?utf-8?B?b3FVYVBKMTJGeGlHcHdIc2phalVjMDM1TTJNSGd1SHZMZmZKY25YZWljYnBN?=
 =?utf-8?B?K25kd2R4T3RRd1FHcXRKRDBleGEzMXF1ZEZISC83ZDh2RUt1bDNpMVlrclJH?=
 =?utf-8?B?MWpjTEpRUFpmMDRoY1l5c2FYZDJ2dlJaN0FuVXhzR2Ntc2x0ZUtzSW12Mlli?=
 =?utf-8?B?NUVDanU3clBxV1RiWHR0aFFIUWNTbXp5REk5c0ZPcUl0L3l5TmlHVCt5amQ5?=
 =?utf-8?B?bDFuSEdwdXR3QUJxbERhdDNMaXJsWWU3d0N0MzUvVUtBbnVsV1Bla3ZHMG44?=
 =?utf-8?B?djJsdjB5TktBZ3gvWFBTMVVkenl3WUt2c1ViNkNYU0tEWlNuV1l2MUNJSzlv?=
 =?utf-8?B?WUN2Tmw5alV2S3FRZi9yN2pNK2lxUitnY2F6bEVFSERpUkJLVlNFbW5vY0FV?=
 =?utf-8?B?QlhMdGpmN2ZWUkhBSkJZRlBJdVJ5Zkl4NXlIM2ZFT3hLQVlkdmhsM2VpUnJv?=
 =?utf-8?B?a1BLYXlUUkNuRXgvZkdYWHVNQU9EZ0ttV3I5OUNRWHNQcWVLUzFJZE1EOG92?=
 =?utf-8?B?WG4zVVdvSDhmK2FmRXJ1NjdKcGc0QXRZS1NRc3dkVm9hdkQ3OE11SnJDRHRw?=
 =?utf-8?B?N0lNWmRjUHhKOTdFcFFlK2h2VVYwSTlLTzNvU0ZTdFJ6YlVzVEdva2dzKytk?=
 =?utf-8?B?NVJHS0V3dlovTXdoYnNiS1J3b05TSFJRTGNOZCt2Q1dmZjBjWXJaVVJxSStq?=
 =?utf-8?B?SldCbmNUVE0ydlQ4OTl2R2dnM3EzK0VvQ3BQV2NBazU5R1l3RmdNS2JWSUdj?=
 =?utf-8?B?dSs4cFBKd29ETWFTa3dqclpCMjNYZkVLVUp4d0l4UE5SRERhV0RsMys5VDBQ?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42308e85-6588-42d2-273a-08de331f2ff8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:23:37.8528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh1ReJ0LTw4p6bEz+DejQsASzF+cvloeLDABM8TWwA4PMs93rSE0IuwGevOKcxi6rkQNIUiNRKW6wP8dJvklPxmeT6u+eDVBqk2HHEQbyOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5267
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


On 2/12/2025 1:36 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable CONFIG_NET_RANDOM_ETHADDR to allow U-Boot to assign a random MAC
> address during Ethernet initialization when a valid MAC is not programmed
> in hardware.
>
> This avoids network initialization failures and MAC address conflicts,
> especially on boards used for development or shipped without a
> factory-programmed MAC.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_cyclone5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index f1bf0aec015..8b64c590e90 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -69,6 +69,7 @@ CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_MII=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPI=y
>   CONFIG_CADENCE_QSPI=y
>   CONFIG_DESIGNWARE_SPI=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

