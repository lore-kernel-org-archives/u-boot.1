Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29483C98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989D783015;
	Mon, 19 Jan 2026 01:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jhWm2QyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2798307F; Mon, 19 Jan 2026 01:52:50 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C232E8004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqKo6r10m/WuwdkKYyhUalPxTZcvdK9l2K1vk1ZxkeX4f8Q0FhCGd3cJUWWdLZ7FSoHWkmt4yE7CxANmWmoR+mSChZuoqPDaJoeP3jeduPBM4nXatejZaeMoS8wsxk7N/JB85rveViKCp3/fJfteORcRtamgWX35jsjXvrX6bZPTIp9XWdvLB6PPXs/h2H0har8mrPJZNAhVjFwKMoXR22gMB1+TZL5YQgOa5YZT5pAyg1BYkEl4vuADGmZjUBkTvO3O6x4kY2ARHn464n3QlDBPdiif04SiXk4ng/e7umPsp2oNFubobeknu+8f/01m0ZzFPj4RlyRa92qQVWEm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KAF554Hj4H1FeBs+tgL3vT3h/vuMAzDPDEptfvz06w=;
 b=e1RZ0T/A3NwFEJPzwiiMKOzY1aPfVqsiolqUxaK6LnsOkp69bolcNfy0+jis9XN6ZFj1SpbpaJ2yU6s3BUTxSdDGuXkswB6nrTE6cFyTZWiJajUa/1UjdctgqGKenalVTAsjTvPcQcNrCCHJAyxGgiF9kd6xVXPDSuaeTs45uN0rfL7a57aN880zgPJJwlC7DkzaZpm6QRqN8byn1h+ehS/tfxePhPFxtkRUM3HuQozjakHNkjvdmKbEYQkEvdV8P0KqoTvtptxlCgx/++1e8HYGLPHm4ZfLX4bmhm3624Y16icukXqiRBzlN0sOxqFiMtie+fRQgbAj/lwOQsha/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KAF554Hj4H1FeBs+tgL3vT3h/vuMAzDPDEptfvz06w=;
 b=jhWm2QyJU64eoGDgsieDqdVZoiwv8w3hnGxPjqXtD8qTa86H0pQlsMS4vkf9asVxSPGGqa1qL2sY6Bm7ZB5YDWINLkEdY/5OYOExNKnIu9896lrqDgUHqasYj1AGlxvlzcU79nn0SWr6IaCrmI16JWlhAljGAb7YF8qgGyfXPBVjqW0nnNem/hsZmikc5CVLF8oKZh/qFRPRq4LDDSYPK2KBl0yze4+JIhW5bceBb9UlUjo8x/QCPFBesovZjN4EwC5d2AQTEsHxLA2Oa+6k+lYaKpqtp65rz73v4v6xGCCuKR4mRhUYVG+gacbYbIQ2G0/+E7SHtqg91yeWxEgzNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB7492.eurprd08.prod.outlook.com (2603:10a6:102:2b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 00:52:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 00:52:40 +0000
Message-ID: <49b51908-435d-4f3c-be40-79f4095792b6@iopsys.eu>
Date: Mon, 19 Jan 2026 03:52:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: part: fix partition search boundaries
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20260106051457.3600260-1-mikhail.kshevetskiy@iopsys.eu>
 <a77efae2-6c83-4c18-852c-db83034475ef@cherry.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <a77efae2-6c83-4c18-852c-db83034475ef@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0031.eurprd03.prod.outlook.com
 (2603:10a6:205:2::44) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ee0624-1a62-4506-806c-08de56f50c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHhXRStrdGd5ekxSYmo0RnJCYkxsdGkyZ0RuR1B3a1E4YjJLUTdXV2doV0pR?=
 =?utf-8?B?dUE1aXNPYWZKSS9qSTdRK2dXdmtZNy9BOHhEd3dwVEZkN0dsMXRsL25nbmVY?=
 =?utf-8?B?VFdwKzcrRUxSb0NtZWI0aWpaVUFSeWZwbjltcDJSYThiYkh5SzRUZVZ3NFdF?=
 =?utf-8?B?Q0lhQ3o2UUhmMHJjalBIbElqNjkvUkswTnMrcXhXTHZCMWVKaElyZ2cycUZC?=
 =?utf-8?B?Q3BibVM2aXFGSUhCbmtDOVh4MFd5eGNFUytDM2tkQWVvZ1dXVUlrYmJqUlVW?=
 =?utf-8?B?UVRtVEJHREhiNEFMRjdONVg1MzdhTFVqbG5jVUxaNjNId2hva2pkbG9PYkFW?=
 =?utf-8?B?elA3SEZnU0NDKzFJcXFaL2JRZVVCZXRCbWV6S0tnelY5b2c2enRsYVUxUDdy?=
 =?utf-8?B?M1ZHdXcyQnVkcWpMbWxHRjlZS2JERW02ZWpBdHVnVGtjZjc5bWg1N1FWTVcr?=
 =?utf-8?B?TWM2QzFQNlFMUlJmQS9hcVBHeTExSXY1NllSL1RaZ2dGMWZHZkFxYVVNbkho?=
 =?utf-8?B?RzlJN3dEYUpsYVJ2aHhwQzk2UWNMWmprd2d2Rm9NQ1lzN0NLM0hUWWc2bWww?=
 =?utf-8?B?bVhqQ2d2Y1pYMjYwUHpyMzhMUFd1SlZZQ2ZLMVU3bHRFeFpxOWtmZnY3elhH?=
 =?utf-8?B?TU52cUpuZ3AxaEs5UWd3dHJvb2xEd24zTjdyOEZ6b1lxWGlkMEZ2dlFublRL?=
 =?utf-8?B?Y0lpSXNubDlTRlYrWjl2MEtvL2wyT3kzWVR3OGhqR3h1QnUvRjE4dVk0cDRV?=
 =?utf-8?B?UlJ6UG10RUVMaEtvbElVcFQ3R0liS1JtUkFvNGNGN1R1VGZmUHVjTzNQZHRw?=
 =?utf-8?B?MTFRVlBlMjFtTHJiVklBWjIrRWkvS0NUSCtYWUlxMnlaWHNzSTZwNG5jUnFC?=
 =?utf-8?B?dXhqVnIvaFMzRFVjcjVUdktXSGJRdll2NFZTSEsxakMvOUhlRUk4alo5SW96?=
 =?utf-8?B?U01rNG04SkNET0p6NzVXdzlYNm8wbGJvS1RWbjJyRS9LNVdjYVhXcHAxRjA4?=
 =?utf-8?B?ZXN1Q3Q2TDRINTBpRmhxQ2lPaS93a1dCcXhxaEdQc1pJR1BhYkkvclB3WkUz?=
 =?utf-8?B?bG9SY29BOUIxeXZ3SkUwTzFVbVVFaUtNcXBRSXdhejZxZ2FnTkV1c3hjT29R?=
 =?utf-8?B?cGcrZVJ0Q1BTbEV1RHZWUHFpSGFhc2FnbkxZT3dIS21OdytZcURuZ0hqalVM?=
 =?utf-8?B?clBTSEIvdllxVHE4OHZmNTBTRHZ6S0c2a3NaSUhNUUJRODZtUVFwZ2h1Zndn?=
 =?utf-8?B?Nzdadk5ZTzJxM2hCQWlDK1lQNHcyY214dUhOOVRIZFhIN0V6bXJpbVFYWEZo?=
 =?utf-8?B?N2hBS01ZUkhDRTl5a1JBSkwyQmJOeUpDVjkreUFkTmxrL3VqTkE4MUxMaEN5?=
 =?utf-8?B?cnpRS2VieGh5ZGFIY0xEeUs1QU9yeFRBa0I4c1NzQlROa3BHZ1Z5cmJVQkl0?=
 =?utf-8?B?Q0hCWGR0c2MxbDB4Z05wQmRKYmdvZGVLQXhjNDZoTzhkQVVRZEl3MTBISTBp?=
 =?utf-8?B?RWZMRGlPOXVuWkljUW8rUjJROVpCdzRYWFNEZmcrVk9SZG5qVkNLQmNhYm9w?=
 =?utf-8?B?dDRwRWozbDJJcTFwYnpqMzk5VGpDSHJzSi9zQll3RWRWdFNKQWpEeWNDMFpz?=
 =?utf-8?B?U1BRSktoa3V2K2RmbDZzN0dITkJwQ2k0ZlBad2ZKb2dKQUlma2dFa0VVLzJl?=
 =?utf-8?B?VVExOFljSDVwTCtSQzZVNDh1NFArbTNhTEtjSlRnWnlPMGdEWUt1MkRReUU0?=
 =?utf-8?B?dHdEUGVjelVDL2ZPNVdPT0VMZWZZTVBTNkhTcTE2azRFTmVZM2pVSmo3bGx0?=
 =?utf-8?B?VytnaU5XSHBHODd4ZG5aU3BiTDl3NGYvVTZtOGZEa2lNK3BwdnJ1c0s2YjFs?=
 =?utf-8?B?OEhVMzBUU0VQMkZiQloweWxKOEE1aHZST2FTMVlUZUFRanZBNk5QNnRFZ0px?=
 =?utf-8?B?K0UzY1ZXQjJFSUZqbXB1aGdlY3FDY2RqK0lreXp3dStVZjBicTVCdTBSSmxN?=
 =?utf-8?B?ZzcyYk53VHZKeS9yS1FJeWJZYUk1TUJTUUdHK3JPSkhJSTlkTjMzcmRtYU15?=
 =?utf-8?Q?N6G5aU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFrSGE3eHVYWHNsTVVRZ0hKWllhTThxbkFob0NMd1V1Qy9wdm92T1I3Mlkx?=
 =?utf-8?B?RmttaFJVTWZucWhEUHhORTJhaTJWcUZPdUlLMFRpUnhoOEFNQWdLaWVvYWFJ?=
 =?utf-8?B?cHBieDUzeWFZMmxXRDJnL2p2bGE4WUNnM0pyeXp2aGFYRFozdzhEOXVUbWhD?=
 =?utf-8?B?cHRNYVhTS3AvY01LWk1jd1hkeU5ibFAwdTI3aDdiWUhDQTFodEVJSHhmM1Uz?=
 =?utf-8?B?K0tjT0o0aEx5dHlINVM3VldtcnM0dTFQeUlpQ2d0K3JUb21mRnRiUFFPMWVn?=
 =?utf-8?B?aDducXpPY0JSZUF3REFheWNoRmpiQmxJREp0K2xSTkFnN0Jrb2FEbVdtYUZi?=
 =?utf-8?B?QUFEeWdHRlkzZ3JlM3BWTUN6RE5qMU1KL1oyZ2VsT0VXeGNEbDdPV2VrK0M1?=
 =?utf-8?B?YmZSemhHUjdSWVlKajN3ZXBmL0doSW5HdUl1OWdRbEpIVllQYUpYOFJtZTN1?=
 =?utf-8?B?VTA1U1FyK0J0R1lXL2dodGQ2aDVtellCdGJ1b0ZCWlFoRU5SRWZ4bTZqa3Ru?=
 =?utf-8?B?R05GVDZTbU1oNXZxVzIxRmNRUHMxbHNnTzBJUW1jcTNMLytRdFNSb0Fxenhj?=
 =?utf-8?B?azZ0YXhUd3p2ZEwxd2VUR052bkJXaGVhMmRpak1LU2REejMxTWxtQUpMemxh?=
 =?utf-8?B?VkhmTjdIcXV3WnE2WUl1WUQybjNtWGxvelZaQ0trTkZTekZtOXpUQlhIYWdn?=
 =?utf-8?B?UVM1a053TmlHZ211QkRSS1Z1Z2hQRy9zVExrbkYySmhRWUxmOVozV3VXcWMr?=
 =?utf-8?B?RTYrMzMwQXpKU0NSVUR0UE8rV2oyTFBEbnk2OTh3bzhBTG52NFFvbk1scTB0?=
 =?utf-8?B?MHVtZTl2TFJOVHRyTksrTCt3SkErRkZxeGtWMlI3ZWtUZFhId1N6cmhzL09x?=
 =?utf-8?B?dlFWblVUQ0kwRW82M01rV1RXTG9zQlB4VnA0eVhpOXI0MmxjNWpjUUhTK0Q3?=
 =?utf-8?B?OXFtUmoza2lqN2xXTDN5eWg4S3U2Q3RkSjF5Z24yRHBONnZBS2pMWUpyVWtE?=
 =?utf-8?B?ei8yUDBiZk9KWlk1SzdQYzJUZXJlVzNUdWtaZUx6T2xpWXpFZDI4U3RYZWRD?=
 =?utf-8?B?SHlyVTdUeGZmNVhRNHdUWlNqYW40YmQwY2xhRFl6Y2wzdWxKbVhTcFZpbUVC?=
 =?utf-8?B?Q05vQVltSFQ3Y29mZGNHMWZPMmxuOENUQlhyMkQ1czRXOGxaV0oyZ25PaUZ3?=
 =?utf-8?B?Q1NOWCtpYnZ3bFMrMjUrT0c5VTRxdzNaQlNQM0JIM2pmdjlSZXZtR3RFaXRX?=
 =?utf-8?B?djhoUUs2V1dBRVZZbzRGMmpETFh3L3VLdTU0NDNHdCtpaUtzdnJhZ3BST3Zp?=
 =?utf-8?B?czE4UTdYcDhSemtSTzNONVU4L3g4Yi9RbmxQeDBicW9adzdOMzU4U01YcjFu?=
 =?utf-8?B?aXBCdm5YbFMzcld6ZjAxS3ZTbTE1RHNUNU5lUGVBOVY1ZitlVG1uRThmTWli?=
 =?utf-8?B?YUQ1ZkhtMTF1SVJHMndiM1RRTnQzTHZwOC9US3NwTFA4LzZYbktTMzdBQ0pC?=
 =?utf-8?B?TnNjTVUzNUx5aDlaajBNMWEySTg4cjBwdUZZOGJrcnZ0djdzaTIwU3g5YnNa?=
 =?utf-8?B?TXhFOXRGYWl2S3h2ZmYxMFVDM2tVY3MyL0pobFpzNE9zZ2FJRzZtS2cvRXhX?=
 =?utf-8?B?N1ZZazRuOWI0UmhPZzhxRlErNHZyNnl0MmZjWnVaS1d3b250Ui9XMm9YVDNq?=
 =?utf-8?B?blc2c3FHay9yNEdMNU82SDVISExFdEc2UDhhWG1iVzhlbTlIZ3RjT0xJaUtE?=
 =?utf-8?B?UExzUzdqdXg0TEhwWlpTM1BVaTFlT25BUlpIMnRJWUxRak9lN0FabkdGKzlQ?=
 =?utf-8?B?NlZ1Tmt5WGk4OU1kdFhIS2JuUzgwM2dTUUdhSEI5eEk3bG1YY05UdzFlUHVx?=
 =?utf-8?B?bWwvRnNIV0xjTWVTRmdibUlMTjY4Mi9Vc2taOU9MdTZianR2aFhxMmk0RWNt?=
 =?utf-8?B?amRUYk1JS0trdGZSbVlpN2hkdGs1eWEwSGVoOWpORHZmTGlyRDNtdENMTGJy?=
 =?utf-8?B?TER0VjVWclVhZ3hYanNRSHlHbGpkUFdRU3FSWndNRlJvcVBWZTBSdkZ2L2Fj?=
 =?utf-8?B?dzFjTzJBU0s5NWo2MjY3Z1hiSTdCSlFITVo2b2pnVFZyMVJ2K29YS09TTVov?=
 =?utf-8?B?YzBkS096dXNwSHIwdEdhcHJlSC9ZRkUvakVPZHFLbDY5NzA1NmJTR3FsdFY2?=
 =?utf-8?B?ZVUzczNOalZtdC85RzRsaUp1bGtrS3dNOHkrb0JNNE5zQVRNcWViYVBaQmxV?=
 =?utf-8?B?NEJYdW1NZURRc2VpUWtESUQ5NGh4cGFYNExWN1cxRXdwOGV5bW9JNlF1MGxw?=
 =?utf-8?B?VWdWQ05SYVEwTFFXbGFyMlFWMkZMN1M3OEZtOG93UlF4V3RkdytPTXpEb2Zw?=
 =?utf-8?Q?ExoN26xF2cPwS7hI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ee0624-1a62-4506-806c-08de56f50c0a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 00:52:40.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeXCQTdRQGf+f53VkDH+0cLDHnFIMZwyBEJc7Z22rc3EQB+PxrCopFPttgGkwIuiP/lYtxSLzL4XOwGu/oBXRTgNeK8xsiMfqvA64kx6XBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7492
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

Hi Quentin,

On 1/14/26 16:41, Quentin Schulz wrote:
> Hi Mikhail,
>
> On 1/6/26 6:14 AM, Mikhail Kshevetskiy wrote:
>> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
>> be read/write from U-Boot using read/write command. Here is an example:
>>
>>    => mmc part
>>
>>    Partition Map for mmc device 0  --   Partition Type: EFI
>>
>>    Part    Start LBA    End LBA        Name
>>     Attributes
>>     Type GUID
>>     Partition GUID
>>    1    0x00001000    0x000013ff    "env1"
>>     attrs:    0x0000000000000000
>>     type:    0fc63daf-8483-4772-8e79-3d69d8477de4
>>     guid:    5452574f-2211-4433-5566-778899aabb02
>>    2    0x00001400    0x000017ff    "env2"
>>     attrs:    0x0000000000000000
>>     type:    0fc63daf-8483-4772-8e79-3d69d8477de4
>>     guid:    5452574f-2211-4433-5566-778899aabb03
>>    .................
>>    8    0x00158000    0x0034bfff    "apps"
>>     attrs:    0x0000000000000000
>>     type:    0fc63daf-8483-4772-8e79-3d69d8477de4
>>     guid:    5452574f-2211-4433-5566-778899aabb09
>>    128    0x00000420    0x00000fff    "fip"
>>     attrs:    0x0000000000000000
>>     type:    c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>>     guid:    5452574f-2211-4433-5566-778899aabb01
>>
>>    => read mmc 0#fip ${loadaddr} 0 4
>>    Could not find "fip" partition
>>    ** Bad device specification mmc 0#fip **
>>    ** Bad device specification mmc 0#fip **
>>    Couldn't find partition mmc 0#fip
>>
>> The error is caused by invalid boundary checks. This patch fixes an
>> issue.
>>
>> Fixes: 43fd4bcefd4e ("disk: part: implement generic function
>> part_get_info_by_uuid()")
>> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>   disk/part.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 49a0fca6b89..4923dc44593 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc,
>> const char *name,
>>       if (!part_drv)
>>           return -1;
>>   -    for (i = 1; i < part_drv->max_entries; i++) {
>> +    for (i = 1; i <= part_drv->max_entries; i++) {
>>           ret = part_driver_get_info(part_drv, desc, i, info);
>>           if (ret != 0) {
>>               /* -ENOSYS means no ->get_info method. */
>> @@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc,
>> const char *uuid,
>>       if (!part_drv)
>>           return -1;
>>   -    for (i = 1; i < part_drv->max_entries; i++) {
>> +    for (i = 1; i <= part_drv->max_entries; i++) {
>
> This *seems* to be fine but I'm wary of the change.
>
> Are we sure **all** partition drivers understood this the right way
> and did store the maximum number of entries in that variable? This
> could open the door to out-of-band access/buffer overflow if we have
> some arrays of size max_entries for example (thus accessible
> array[max_entries] is an out-of-band access for example).
>
> For example the AMIGA partition driver seems to be saying there can
> only be 8 partitions, while
> https://amitools.readthedocs.io/en/latest/tools/rdbtool.html#info-show-information-of-the-rdb-data-structures
> shows 9 partitions, starting at 0 instead of 1 even. We have
> max_entries set to AMIGA_ENTRY_NUMBERS (8) so I guess 1-7 is currently
> covered, but this would then cover 1-8 which hopefully is still fine
> (we would still be missing partition 0 if that one is actually possible).
>
> So we need careful consideration on the impact of this patch across
> all types of partitions. 


There is no upper limit in AMIGA partition layout. U-Boot
uses  AMIGA_ENTRY_NUMBERS just to restrict the number of available entries. 
I study this and other partition drivers and fix all found issues (see
my next patch series)

>
> Finally, I'm pretty sure we may need something similar in cmd/gpt.c
> since the same check is made there? 

Good catch! Fixed in my next patch series.
>
> Cheers,
> Quentin 


Regards,
Mikhail Kshevetskiy

