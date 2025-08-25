Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939CCA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 06:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A687081E13;
	Mon, 25 Aug 2025 08:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WVOM1q+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5264F828A2; Mon, 25 Aug 2025 08:22:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A75808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 08:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK/Hc1hl0mGu/CdYIx6kRH5i3nOEkQUh/hJXLf4KTCOzzQBmpLcBcsTRlZiZBs59+nfBaKWFIbb6we7XVGRIDoph1uEWjyv2Fif3YVof26oczg7JO0dJU//AE4VD7DTXaFNf+r73sPeuLDEsgPffAR92Oc7rqnst5O4iHlmGe/46xLmm8H7DCFnmSStR1gaF0erXy2n5lVIC3XcHVv/5vqsvMhjmXbD5Xt3/Gt/YlZFpzYhyldJRq9q9+XYoTQ741knTbyISQ8EuanYC7peVlXDV/fKdeGuvcaIyRa9ke5aeHlwo327zUZimm7tCZvs7V82ged2XSIhcb4enBkWGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V8RirJd5H2Xk0+iqiPOzKzdDTs4BWx0UrRQqWbarxo=;
 b=TbDB3S5slYc+4CxAZMyxs+RtganuLQuahZYbgZRVKwbz/iS+tC56v7aXhZTVUN58OVgD+HrS3G74OKWRjhHGfe4IeYQlF5VfNhHLOMnZGEYYTjJHjHGlRmECF9QM/JEF6LhbwT5LpFj4xMT0ts/9aKn+KqbrDMCG0Q8+NG08z0bk0tmYs6rgawjtUPiu8DsIXJuTc1eSHMRJlpYlmWIVY2pVCVgNj1PkM1cbyvvemsWgpKAmiLNyflw1Usj1GmZh4lQP9PN+pbKRzL0ay/4IGUrBpDan0eTa3bKb+gNFv0Kz7951qraSSdQmXatihqutJwwxumirdY/cPxTtT9OTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V8RirJd5H2Xk0+iqiPOzKzdDTs4BWx0UrRQqWbarxo=;
 b=WVOM1q+VY5MfAJNTmkcjb+gOsLuJZbwDsu5A9m8LxVK/12Q0cgRnjefaHtwfVbdkiinYEhO+hm+VoAXPNwa7hNqRZ5xEbmuYNL/7t414yhzQgFCh3deuoTBDpuem0n1YS9etv6wQiQ/rDD6Jq98OkTbTZlHnfaGgodLi2xz0KlhKUhrUao+cbAXvfS+HlivMGcb0fr7FQ65c9UY/GkwsCOMwGkBm2HX3DoD0bN8kiUgMI76VLsFoPA9ufVPrM6lWZMvvuNL37y3lqzScpT5qZwq+hP9XCaImtVrlM2/PM0IN+UXsavP5u1r4XoV+8i16iqrm0edVHGmAX9r5+tjNQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH7PR03MB7337.namprd03.prod.outlook.com (2603:10b6:510:2f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 06:22:02 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 06:22:02 +0000
Message-ID: <9a458b2e-61cc-4a99-bc04-6180f2c0f624@altera.com>
Date: Mon, 25 Aug 2025 11:51:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-5-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB81378100F4DD4F43A8F92ADBA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB81378100F4DD4F43A8F92ADBA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH7PR03MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c191cab-fd59-4af3-0c11-08dde39fb44f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THMzRTc3V0pXMmYydkVLak00OFlFVytRRWE3Zysrd1REWHF1L2FGU2Y3cW1F?=
 =?utf-8?B?QktWdkNEeDlzU3V4Mk8zc1praHV6dkoveTIvWnljQW4vYlhGTTVOMG5kdUt4?=
 =?utf-8?B?M2JnUE5EVDFNY3ROU1Ntc1FVWlZZUEV4ejdnbzJFQi90aWNmOW12Qmc0a2VJ?=
 =?utf-8?B?YzFyU1drU25XL3pTOThLdlk3NmhMSmN1c3ZaSStkRjh1NnhwRXpYcTY3WEZj?=
 =?utf-8?B?aEorc2hJV1A1d3RpR3JaVnB0OWRwSUhiay81c0pob2pkMVJqdERWS1Myelcr?=
 =?utf-8?B?cWJMQVVCYkVrNS84ejBOT2pTMkFBN0VRS09MeU95ampUMlRFVTREem5HcWdT?=
 =?utf-8?B?WmlPUzBjbGg3MGwvVGRtR1NpVEpKVG84QVBPdlhPWG9Pcm5iVDRTWWcxcHV5?=
 =?utf-8?B?cWcwbmJvT05WOUloYnpWUXVzNWhXVGlhUUsvaGxUTDhzbjhHUjVyZ3hrbGNR?=
 =?utf-8?B?WGhpWjJ3Nk5BdmM1ajFnN3BKdDFzZStPNGVUZVczcFpaaUZmNDBvbXVRdTht?=
 =?utf-8?B?MUh1R0FqenhtK2JSMVd0ZUUwNFhrVUVtd0licG1oQ0V3NWR1MW9nRjRxbFhn?=
 =?utf-8?B?eHFneEFUYkdZMmpsckxWekYzdzl4L2krcDltTDhDMy95eGovNVJ3SnZNOFZX?=
 =?utf-8?B?OFc3Wjd3YlU3anMwR2pCVUE5S1F2Nmt2VUpzYTB3bVFNcUplWTJnZ0lSV3gw?=
 =?utf-8?B?L05iUEljSmJyR3JlVCsxdjBENG9OQVpXTUxnQ0h2Z0JrQ0ZVdUhMZnc3ejJQ?=
 =?utf-8?B?eHhWNlRNWk5QbmJWM1I2RTc2KzdkOVViMDlGYit1dkFpQ1hCbXM2dHM0dGVh?=
 =?utf-8?B?ODQ1TVFuMkFGd1RDN09CbXlSZWNjdW1oK1NLNTYyQTM1OWlTbkJrVWt5V2xC?=
 =?utf-8?B?NlVsTlBVRWl2M001dlArQUdnenZ3UFlQMFczRHFxWk9iNW5LV0VVUnVkRFNm?=
 =?utf-8?B?TlRSV08rUk00QStQdXhZTVdtaXFVRE5LbVU5MW9EM045bzUyWHFaUVp2NjhP?=
 =?utf-8?B?bjRIV0RPN2xRRFE3RUs2UFBCWE1DcEJ6UWVZeGluQzU5T3Y0TXBOWGZzenY5?=
 =?utf-8?B?TW0vSW1tWllpL2RzR0lndXMvTHovRGdkaUY5SXVFcnBOamUwSGRMSWpyTFNU?=
 =?utf-8?B?U0EwMVNCRjJJRzFBcTlyMi8yYXRpQ3lEZHVnTng3dUlPd1JtL3RDMUZOSVY2?=
 =?utf-8?B?Nlk0dHc4UWNRWVBOb0N6STg2M0FBZkExeUlpeEtJbUJ3eXI2NUR4RW5tcjhX?=
 =?utf-8?B?U1I4VEdUdzUwdFVCSmxTOWlEZDBUM3pUOFdCbEMvZStmam5oTm5tS3JCSy9G?=
 =?utf-8?B?L0RGSGszODVScEUxOWRKaUhXWVRZYkF5T1lOTzlwY0pna3dZZm13VStkcWN4?=
 =?utf-8?B?V2F6Z3JoeEJCMVQwRmZ5NXJEMnUzZEVQQis3bVJsOHJSMUhxOGJKb3pVMUFW?=
 =?utf-8?B?RzhlZUE0d2R1Ti9pSm01VEFJWDlMY092V2RrdFlOVFVJaU0xbkdvTnM0b05M?=
 =?utf-8?B?bHZ6dWt3ckxiWTdnWWJxaElIZFlkYUg1UUxRbXRUUHZsNm4xanR5WmZtQmVI?=
 =?utf-8?B?b29ZdDhETDZxdmk1aHNNOWlXaXVacU9HUlFNNUJsalM1QjA1S0N2MUxZeEtl?=
 =?utf-8?B?S2xtVW1SNnlBbm8zcDRKNjRuY1gyQklSdnMzWU5CQzgxZlFEek9KMWptNTBk?=
 =?utf-8?B?MDQrZEJmMzVYVStQWjlnVm81RjNjdW1QaDBUdnZ3Y051T3IzNlRJdjhycWcw?=
 =?utf-8?B?NFp2TExlQlYvZnQyemdiUDBKN0VNaHF4V2FmN1FJdm9Kdnd0UlZ2MUdTeHA4?=
 =?utf-8?B?Uk5Oa1dxeEgvc3VSaWF2Q0IxVFJYWWE5MkhnWForZmpVbm1POW1qTEZZVkxO?=
 =?utf-8?B?Y1lRa00wNTA2dkg5K01WQmRaaTNZTFdYQzZwTXVWRHZsWVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eThENkNQOHJFdkp3WXJRNlIyTUZOVGpZZE5tb0NpVTB1czdRSnFLTjhOeElk?=
 =?utf-8?B?Vzh3SGxwemlGVjNIWEx4cVRkSjN4ZXlDOHlqYkpXSTZlbEtEZWkzSU1OQWhH?=
 =?utf-8?B?Uy8xZngrTytXS1VyRzZqdDlDNTlZdjArZ2dZVHl0dGtjR3EwYTVLR3NEcTY2?=
 =?utf-8?B?a1RKSzgzVmJOSDdQQnRiTHRCM3pqdTM3Z1NwSVR0RXpTQ1pBeWVHNEFBaXFP?=
 =?utf-8?B?d3BYOUZkeUxZV0xrc2pCc2REN2x2Q1d5Rjc5VDB2WUw3MjJtSzRCbUVmZzRj?=
 =?utf-8?B?akI4QU1LOHVZTHlEekJsNFV2S3lqSTZCWEJ3TksweEhpaU0wM01oSjdvUUQx?=
 =?utf-8?B?M1M5M1lLTnlEWWQ4NjVWSFQ3WkZPc3hJR28zbEFJL1N0YUJ6S05lRzdBR0JV?=
 =?utf-8?B?Wkd3Y1B0WlNSbStxTTdSelBvbkptMHJEVHM0aC8vN3Q2L2lCZzVUUVltZVhP?=
 =?utf-8?B?Vk8wcHB0WW10cUNWYU5NZTFBN0RpVnpkUGlMeThQd3FOdnNKTTdKZmdnZzN2?=
 =?utf-8?B?WTRNOFZ6bFVjRlFPWnBqS2FZRVplS2JIQzJRYWFBNDlUWTROYTJUUXFGaG04?=
 =?utf-8?B?TURGdUo3V2drK2ljYlZURlFNWi9yakx1Z3NqVWtVWDVQRFlUVHNTeTRPNnhI?=
 =?utf-8?B?SHpoY1BJNlAxZEl3cTFsL2VRa3EzQ0FjbFFsTFdqREpCWDBlUjVjb0tTbVV0?=
 =?utf-8?B?UGRsNHpGL0haREU2cisxV3I3MFFrWk9wSlVrR0I4Y2VkR2NTbGlQWXg1YVFY?=
 =?utf-8?B?eXQ5ZFJFNE9UMVVsT0JMQlAxTlNzT256SzgzYWt2djM2ZFd1UVFGZ0p5OWk0?=
 =?utf-8?B?WU51K3hYYms2UzlVUm95b0c2TjRKR2xEYVdad3J3VVQ2b2pNWUpuaTlRdWFj?=
 =?utf-8?B?K2NlNDRNaURycjNFSVplRFVzUUxhY1ZWOCtuZ0JjSnludC9wZ1Y3NkpabThC?=
 =?utf-8?B?N2VBZElDdldTemdJMXZWMkdYYzRnY2dwOEFRWFZlN2V4RDVMREpRUEw4dUlm?=
 =?utf-8?B?OUljRjJabW5EMzdYR3ZINllqK1U1L2FvZnM0NXI4RFFQcm1xUFBhYi95RTdY?=
 =?utf-8?B?cmRRK1NhakZxYTlIVlV5ak9sb1l4ZjZxRXdTMDRlTGtzNDJVR1VGQURNME1m?=
 =?utf-8?B?SkVNSFdJV2x4NmI2WmZnTWtxUFl0WU5oRmlXU2hhb1JVamVEeVptVGhBTGF2?=
 =?utf-8?B?SmhGUjZqMDNnU0lIYlBJaCtsQXhKd0IySDRGcnRBdlh2THcxZitLdmVjYW5Y?=
 =?utf-8?B?RmRLRGNua0w4QVpTVVhNOFAvMUN6NlBYTlpQdHlCQ3BDK1QwaDJFUy8yanNi?=
 =?utf-8?B?dnhYMDVncTlXN0owRUxuNzlDSzVSQ2ZBSG9yeVhwQXdoeFpIMEpVeVZQUnZQ?=
 =?utf-8?B?VkFKM2c5SDJVd3Mzd0N6Zkw1NFhBdzJVL2Fva3BkWTFTQnlVZzlJSlJHUlpM?=
 =?utf-8?B?enRib0ovNzVrb05tWWZ1OUV2eXpwNHVNYzRuNUR0L2psRFY0TDJxNFNlSmFF?=
 =?utf-8?B?aUJJK3VXTGhUaXJ5eVptL0RvMkY1R29SeVhWTGtvYVBCMXgzZnNxKzFFVkdN?=
 =?utf-8?B?RGJVbHIrYUxlSXYvK1NQNDBrM1ZqUGNQVVd3TmxIbXJjU3RIZ1dwQ2FUSmdq?=
 =?utf-8?B?UVlPV21FUnJOZWpRZWxXSzI4Um5ndWxpYjlKWWx6SkcxNThkcDNzNVFYbXdw?=
 =?utf-8?B?ZDByaG1oVmRpdlI4ZmczVVZHalhmMnFyU3RJME85b0xDalE4elZLUy9uY0w2?=
 =?utf-8?B?SjdPK1hEaWdVS2d4eXYweENnMkZSYVlxbjVpUnRBZ2pUWW0yVkJkV2ZSYWNv?=
 =?utf-8?B?V05wc1diNVZ2bDI4b0VXeHpFdjZaQUtyU2gwd3ZmNVVlNlB2K2ZTNVY2L3Rn?=
 =?utf-8?B?WEFjeEt5S21lKzl5QXFBZWpTM0dBanlrVGIwQ3hhZkZvTEZZTWxOM0V5VC9t?=
 =?utf-8?B?a3dJWU5pY054dnI3R0ZsMVBTREhzSGNRbUhTNC9IYitDT0Voemt0OWIzOTFY?=
 =?utf-8?B?WERBZThpUDZIYW1KUTZyVFkwejJSQk5xaU5Gb0p1eitzVWNiZlRObHprTUpu?=
 =?utf-8?B?ZzZxb0hTQ2dPSCtwL0tFWXM1TlVmSU1hVkNxd2dCa3lwYnJFWXJVNW8yTzE2?=
 =?utf-8?B?S3FwZktobHlZdzR6YU5RZEVZNEUzYXlSS1BKR1NLZ2lpd0RKQTdJREsxempJ?=
 =?utf-8?Q?Qbp4zHvLPmL7yvAeNlEiOL0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c191cab-fd59-4af3-0c11-08dde39fb44f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:22:02.5778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X0h2WdMLrcwA6wwO/KEpSc3FCKRFONnznnPC8J7Jx2l1ILOCweXOqE4LpXGRAEuctdTWrV5KUVuPv/8v105Bo4TxIi2RfBM+M78YK2V+Qq2lfGAryNnrTWoQldEVgll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7337
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

Hi

On 25-Aug-25 8:36 AM, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Friday, August 8, 2025 6:04 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
>> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Subject: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
>> registers
>>
>> For successful reset staggering pulse operation, reset pulse override bit is set.
>> Port overcurrent bit 1, which in reality reflects PIPE power present signal is
>> set to avoid giving false information of Vbus status to HPS controller.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   .../include/mach/system_manager_soc64.h       | 12 +++++++++
>>   arch/arm/mach-socfpga/system_manager_soc64.c  | 26
>> ++++++++++++++++++-
>>   2 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> index c2ca0a50e35..8a7d47bee44 100644
>> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> @@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
>>   #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
>>   #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
>>   #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
>> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
>>   #define SYSMGR_SOC64_MPFE_CONFIG		0x228
>>   #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
>>   #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
>> @@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
>>   #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK
>> 	BIT(0)
>>   #define
>> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_
>> MASK	BIT(0)
>>   #define
>> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
>> +
>> +/*
>> + * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
>> + * Bits[14:13] Port Overcurrent
>> + * Bit[12] Reset Pulse Override
>> + */
>> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR
>> 	GENMASK(14, 13)
>> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
>> +#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
>> +// BIT 1 actually reflects PIPE power present signal
> 
> Using /* ... */
> 

Noted, will make the change.

Kind Regards
Naresh
