Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6EECD9BE
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 03:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A5583B86;
	Fri,  6 Feb 2026 04:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="IpZSI1JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8EE83B85; Fri,  6 Feb 2026 04:33:11 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BE983015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 04:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq6swrJDpDF5cdP06/tg3otpB7wzes4tFutD8NygZNfvVBEOHde5/27h79XH2BJmalU/poyiyzoOLG1vxm5SMaL25V3+G7SvoZhISDCdY22HQ8Rq9O7ThG3+lFmr4XHjKaa9dHFECedhkjCT5gJk7UaUZhs32tK8BQ+4z6PSH800O8hcfLawA1jFErMcSUL2jiVNUkumt3rqHgZ/XJ1ebLp66Xc0qvQQ1RGBlfZ14cFEPGTCt4cXR5InDW1ajoMMp2vDEMIqV5QhZH/ZMbYAP9Vkk3JwsHjjnNGAwdHE0RMGig0ZRSDhXfqIJg4+f64clYKtoDgtA/IHZtK2trEaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUQCRo5XWBubqbmOtMyonSdPU+J4Eqj4R7dKNIEu+88=;
 b=BoWp85WuRi1MhILkJ+uY80BdiI1sRVjPnoZfjDDZ52JMNVQM1gHf/i86SE+7aA37/oVIewB2zdSQEO78ZjyCxSt6WtaTipKebJXig9q68OLVMP06YTJHLi65RrLINQBvHLBCwmLbus7AethvejaNYH1MbAUKvo56d3AZJOC2gC5LCTGSFOMyBgJXODl5qvTtMrb7G1vPsOoJCWp3dC51F7aBTqLF0swbcU4igerq0eRAKCKrj2fEICUTnipG7jjMiay1D1zXp5+DIanlR4GxdIzPHe9PEYimnWUMbOBrPwJhXoGb+ttabPUpwfKpyw2hZNxTBSSLPR9St2FiQZcG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUQCRo5XWBubqbmOtMyonSdPU+J4Eqj4R7dKNIEu+88=;
 b=IpZSI1JWkfiSKwRgEsGL6FJ5zU2oqK2CThOwz2ghZ3wteBKdGstdUaKHzz2qfHe7VLpHdL42wiCiSMVvqoKCHY7d6gyZKMy9zWL4LzrtRYgy+qFRlp+xzo5uQLaPkl+c74oWdSRlH2SzSgnYoU4BWkblmB3KzOwyFQZY/ekB0LjtcYxKZXopu6pooUTXXOJQaHyHDBCdWUgUTj8sWXhCOZFmHH4/FJJe6q3kn6+T0Q+7Ju1wgo2padg9P5aao9cPC66oM/e+VYDqPlDdD5nOTa5JDd9bvXTmk1qwZUs8jnoNrKwsScurSOkVIOVVSAGAj+I8Y0W6JyS1dWcCGT8wWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by PH0PR03MB6557.namprd03.prod.outlook.com (2603:10b6:510:bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 03:33:05 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 03:33:05 +0000
Message-ID: <827bec45-c680-42f6-828f-0d7020503a10@altera.com>
Date: Fri, 6 Feb 2026 11:32:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
To: Sune Brian <briansune@gmail.com>,
 "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
 <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
 <CAN7C2SBDat32aNjROeet5BwZTpJxN-8DOKx4gU12QY_ibbDLtg@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SBDat32aNjROeet5BwZTpJxN-8DOKx4gU12QY_ibbDLtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|PH0PR03MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9a6867-6cb9-4791-85c4-08de6530702f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cCtvdVVkVHBSN2NjS2c3OE5ZWDczYk0remZUN0pIdGlESnA4LytGdlhXaU9W?=
 =?utf-8?B?S3dzMnY1cGZxSXFLR0tveWgvVTdyczhIczZkVGtNdHlISThoSS94OFJha0w3?=
 =?utf-8?B?OGtvOHVpVE0zdzNvaFc3ZXFEUVo3RGdnMXdXWkhjVEYyWk1GSlZHTEJMNVQr?=
 =?utf-8?B?Vk5rQllDZGQvNE5qRnQ5RG01OWM1NWtqZXV3Yld4eHFPbjZKRXZrQjhhWWFG?=
 =?utf-8?B?YlFxNzZCSWEyazU0RkZraXUzUnFFYW5saUQyVHlqNXdQNUV2RjJNVW9EbHVG?=
 =?utf-8?B?YXg3ODFzUUgwaTN3N3hvdWhiUko4UmM3MUFVWFNqZnU0aGpDazMyYmhUd05T?=
 =?utf-8?B?dE5TOEhCR05uUHpwemlpMFNSdHRXQXEzaTlFNGNUMVNRTWdIcTJiU0JkZ2Zv?=
 =?utf-8?B?SysyNDZtNmtlYWppbk9DTnNkeFNlSitRL2wwcCtBdE9WSlcya1RkZUJUS3Jm?=
 =?utf-8?B?dHQ2eGE5bmxBRENBTGFkVzVOMjRtZ3duUVFKUndsVFo1eXVDdVdaaGNDeDZ4?=
 =?utf-8?B?Z081SnRISFdxN3ZIYVRIVkNGM2MyT1NyRk1ORk15dWpBUTZvajl5M1ZUYy9N?=
 =?utf-8?B?NGRPOVYxME9BYmxHQStxUWhlaWlxVmZmNGVYWWcrcFZNTzVtMGUvLzZJc2xo?=
 =?utf-8?B?bElWMDFFOENRVkp6R3hyNzV0dy9OVUVFMmdRRU9GaXAxWnl1cUhOQjh2Q2FX?=
 =?utf-8?B?NDBtY1I2c1IxaE1aVThNNkFoeFNoSFlrYXMvZzA0bURLcy9STWk2aXJHeXMy?=
 =?utf-8?B?UFJkNFpzWllKM0c1aVdWYVFaSE9UWUVVbUQyUWlmQVNHV1BZVDhuWEc4WmVJ?=
 =?utf-8?B?TmppTUtvL0xzZ3pORkRoNUdTdTJzaGRnNnRpQ1NEbU5Lbmg0NDduM09SbmVD?=
 =?utf-8?B?N05YQWpSVFh3L01aclRUcDBDRHZkby92T0JKam9xSXU2OVE5Q0JXQjdsM1h4?=
 =?utf-8?B?T0tCSGVSUy93d28ySUVWR2p4NDNLOVdKZEZoQXpYeWVLK21zaTg4R3kwTzBM?=
 =?utf-8?B?d1FiK1lYcE82YVRCOUxGdDZ0ZklhczJhYjh4T3ZqanczTThRai9zUng4Q2pw?=
 =?utf-8?B?SnNLcm9yaXI1K3NWVVFwa0h2NGFKd09HUzU1WHhNdysySDhrQTRuVEdoVEFQ?=
 =?utf-8?B?NmplUXZzZUVqbWJMQ0g3Q2V4N0dnbmxJMkZJVDhaVm1UTWk4N0xSWDZxNS9J?=
 =?utf-8?B?SWlLenNnOEVRS2xDalRYbEZ1NCtqSEVVRlFBYmZvNEVUbVdYejJhektTN2gw?=
 =?utf-8?B?NjFIOWZzeE82bnJULzMyV3h6dzFOZjYyY0ljT0tTem5RcVpiWk9yYVE5VUlr?=
 =?utf-8?B?YTJ2cWEzZXYxN3Y4THdleHdzOEJNT3BXMjJaNC8wNmhUVWpCUHRXRC9QMTRL?=
 =?utf-8?B?a1g0NE5JOFJ0Z1JybFJFaEt4OUNRUkhWS2txUXhJdnJRY1BZa3pkL09iSGZn?=
 =?utf-8?B?cGhVeTNub2pwU25tSWVuM3ppWWNNODVrNjEvMmJRVHlwMk1RMWFhdk1UR0o3?=
 =?utf-8?B?YUw2YTJBcExWbXFxK05ncUVOaC9wRlQvc3JUQ1o1clpXR0R1TDRMRXlQVW1D?=
 =?utf-8?B?SVFuazROL2hFWFlnTEMrZXVWT0tKNWFDcVM4UCtnVTlXdVJneDNkVXpDLzhk?=
 =?utf-8?B?bGc0M2pUQzhKTDFoVDFzcllLK1RSZ1BPbGdBb3EwYVBHLzFWZXNocCsxT0ZT?=
 =?utf-8?B?aHlTcXcvSksvMTY3cmx1eVlETkZ5TzFJQkUxMS90N00zSGF2dFRBeEdxemdP?=
 =?utf-8?B?U1ljZVcxTXlUQWZRVFBKaGZITzM4SjNWRHB3N2VxVUZCZDFrMHd1eUFzTHdQ?=
 =?utf-8?B?U3ZSbnN4TmwzaDBCSjBkdE9DTTBrdm53REQwTDdCYkJPUlBySGhxMGxMemJk?=
 =?utf-8?B?VWpxeXBuSWNCYnJhSFVCQ3hMNUs3dHJCL21yRnc4Q3diaUcrOHNZOGlmMzJU?=
 =?utf-8?B?ZHUxOU5HbVpRb2NzMThFZ3hkcW1rUFNzLzVwb2pxRjh3R3VuZmJ5ODF2NGs4?=
 =?utf-8?B?Q0lpaXRqQU5kTGw4VFRRRXhsSy9Pc254QUxUQU9wVVR4amMzaXBqVU1TTXNT?=
 =?utf-8?Q?2UuYae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXUxN3RtYXBJNC85S0NreU8zVGRHbzhrQ2JZU2FodjZQQTRicUxKMjg2WTNs?=
 =?utf-8?B?cEdLZHpSVmVLZHE2eDNzVzllRWZHTWZXdHBzYm5CQlVpRVNRaWFVdVc0Tnl1?=
 =?utf-8?B?Mk81Sno0NjdHSWVXd3Z6ZjZCMHZUcGFHTWwxUTExOXpHMWhkZDd3ZHpJdHlP?=
 =?utf-8?B?OFBQd1RvYm91ZS9uVkppdjNUZ1FhVDBoQ0hONVBHYVBFb1o0Wk1ISmtGWFBQ?=
 =?utf-8?B?S1BqaHpVMy9yWk9HdWh2a1E5bnFnSzBlaEJ1NDQvamM1ajFMUitNY040ank0?=
 =?utf-8?B?M3JINnJiRkNGbVhraFhCSW1sNTZGZkNpOHlmS1BiM2Q3bkFtMlJHVXI1V3Rq?=
 =?utf-8?B?NkFMQnpnZEhoRnhDZnI4RFF5S2ErRUpqaTNtbXJSN3d6bkhyK2lVeVFYc09C?=
 =?utf-8?B?alhOR3ZFWWs1VndGeEl6Y2l5VWJzeWp4cGFJUExVM2FLT21KbmFJVzNOSzdN?=
 =?utf-8?B?eHNKY05HTUJXakxVWnU2SStsZys1cXBnVnBYQkFYZ2VWR3M2SkxJMFFxdWZL?=
 =?utf-8?B?dEZHdVl3QjFtR1dRWUJ6bG0vQU5DSEEvcWhxSXlkelJyYzRsTVhBelhJR2hw?=
 =?utf-8?B?L2dqTXRhSmZJY25wSXVmL2RQaHhtRENUOGFWSU9iVjNRK0NQR29FWC9FN2px?=
 =?utf-8?B?Yk5KNzdHTUg5OGg5dmtQYWtNZjlDV090UEpUWlNGU0dVMzRMRXdMd3dkZUVJ?=
 =?utf-8?B?ZGRQdHAyTGNDZkEyUWxXSzE4R3RsdVl6YTF1Zi9HRjVod1B4WjdJUTl2bXVE?=
 =?utf-8?B?bkZrODQ4cXhOUGMwUDQ4eDRRMmhMUmp3Q3dhNS94cGY2QWFDTHN4NEFQdmpk?=
 =?utf-8?B?MlhMSVhFdUVkL0djUi85Z0dJMkxXSXl2V2NvS1QyYkhlYVVTSE5NMFhZcFJo?=
 =?utf-8?B?Q2xmNzFDMURzQlNGZXl1VkQ4dFJRdWpKUXpXblQzaS9DNlk5ZEN3K1MvWHc4?=
 =?utf-8?B?aEZ5c0NKY2NtYWFQUk50OHdVUTlZZXVtWmR5WXB4TWhMYmJ1aDc3ZEFJUG5S?=
 =?utf-8?B?akpVNHVkUmtTMlRpWVVYSGozd3FlL3RrK29lT2ZTcXM1NnE0SU9xdnR2ZW1R?=
 =?utf-8?B?N0J0UElod1FzbWorZXJ6YlNWbHZQS0JqYThLN2luUVRSOVZWRTR6c2FISm9i?=
 =?utf-8?B?Nkxlc2VUTDhNdk54QlBPV3k2UTUvR0hrT0xvRm5wTEJITjJ6ckZvRE1aT0tZ?=
 =?utf-8?B?enA0b3NGZ2E3M2I3SWh5bmdIYVB5eXpmSEt5U1NHNFVVT0MweGJBazBxbjJQ?=
 =?utf-8?B?SlNIek40V1VGOE5Za3IzZjE2ZFlDZDFldnA5UHhQNlR5bWp5NHRCN3ZjNDlG?=
 =?utf-8?B?dnFhcFIwSU1KWjB3REhLTUttUGIzbGpNNmlHamx0L2VzTFI3aFpla0VDdnZI?=
 =?utf-8?B?WHlDVHlDSjFaaGZkd2gvT1ZQTy9DanJUK1UwekZyWGdMWnZwaVZpTG45a2xH?=
 =?utf-8?B?Rnp0SklvSjZDVGZsc3RjT1dMTEdKYVJpeHE2NTVyZXhMelBLMGRLOERwcVkr?=
 =?utf-8?B?K2V5ckpzM05iT2Vra2pkMEM5bUhFRWpCZjUzRmhZSWYxYlNJRFIxTEFnb2xJ?=
 =?utf-8?B?UjVTendrWS9RWHlZeFV4alpTbnVjdkRwN3RWYlprbmxtT2t2ZzdSSWgzcjdT?=
 =?utf-8?B?ZnRJK2NzRHZndGE5TTBaOFNMK2JJY09KVDFQRGw0R0hQaVJmTkVaR0huS0VV?=
 =?utf-8?B?R2xjSFY0bmlib0t1MlVMWndITkVqUDMvc2Y2M1pXUUpaaklBY1N2MjlmNk9S?=
 =?utf-8?B?WEx3c1RaTkF5T2NTbzF2UkdMcjhvYlJ3OUVHMnBDREduK3NvejZrK1Y2SU9v?=
 =?utf-8?B?NnhQYng3OURkVis0ZFN5MG1MV2ptOGNjTnJVU3RqbmMrTTVSNlpMaTE0em41?=
 =?utf-8?B?ekpJS3BKSFk5cldyL1dNWkxtaHc2bnVvWnlRM1J6V3BmTEtlRDVqZkdjYy8r?=
 =?utf-8?B?YVBxVWRjK3F4REFudUt0dGs3L3ZyN3NXVmJGcFpaV1Q3OHlTZFRUc0VnNFMy?=
 =?utf-8?B?bVhuYmpSaGs0RXppa3ArU3QvYlRDbGViOU9oelNBcnRjdEZKbTZ4KzBIdnli?=
 =?utf-8?B?TTBPWDhKK1MrSXUrZ2JPbEpnaExZYTQxY0hPU3d5aTk5V0FiTTdIL1pTbkVB?=
 =?utf-8?B?c3hmc29HVjcrV2l1S3BZdjJiTll3SlEwTjBBUFpmL2ZKNmhDMEgvQ2pTT3k2?=
 =?utf-8?B?VGdveXhYbkpiRXNYVm9WWkhkSjlramZidFlxV0ZVSWJvYUQ3NUZPUkhEYkRC?=
 =?utf-8?B?QkJCTU1mcjJiY3JXSjlLRGo1c0RpeWtNcXVjMlRsYUhpbEZBNk9SdkcvbWlu?=
 =?utf-8?B?K3k4THRVYjZDcndzVXFPMEV5OGdteEo3SGlMTHY2VEtCUmw4d0ozdjkzMHo1?=
 =?utf-8?Q?x7IhSbv2ANDEYFe0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a6867-6cb9-4791-85c4-08de6530702f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 03:33:05.3031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKW/UkLxzKSMSoZ5XKjUwiB8qKcf1crIko5QIdJp9enT9kYBXqagIaO5g7WlCq3A0bNPbGgzXr0UWd62F8hR9fElkR+0ndENWHakSbII9Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6557
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



On 6/2/2026 3:17 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Tue, Jan 27, 2026 at 4:03 PM Chee, Tien Fong
> <tienfong.chee@altera.com> wrote:
>>
>>
>> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> Add DRAM size checking compare between size from device tree and actual
>>> hardware.
>>>
>>> Trigger hang if DRAM size from device tree is greater than actual hardware.
>>> Display warning message if DRAM size mismatch between device tree and
>>> actual hardware.
>>>
>>> get_ram_size() uses size from device tree. So, it has consistency with
>>> other device families.
>>>
>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>> ---
>>>    drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
>>> index 7a0a043557b..d5892850da7 100644
>>> --- a/drivers/ddr/altera/sdram_gen5.c
>>> +++ b/drivers/ddr/altera/sdram_gen5.c
>>> @@ -6,6 +6,7 @@
>>>    #include <dm.h>
>>>    #include <errno.h>
>>>    #include <div64.h>
>>> +#include <hang.h>
>>>    #include <init.h>
>>>    #include <log.h>
>>>    #include <ram.h>
>>> @@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>>        sdram_size = sdram_calculate_size(sdr_ctrl);
>>>        debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>>>
>>> +     /* setup the dram info within bd */
>>> +     dram_init_banksize();
>>> +
>>> +     if (sdram_size != gd->bd->bi_dram[0].size) {
>>> +             printf("DDR: Warning: DRAM size from device tree (%d MiB)\n",
>>> +                    (u32)(gd->bd->bi_dram[0].size >> 20));
>>> +             printf(" mismatch with hardware (%d MiB).\n",
>>> +                    (u32)(sdram_size >> 20));
>>> +     }
>>> +
>>> +     if (gd->bd->bi_dram[0].size > sdram_size) {
>>> +             printf("DDR: Error: DRAM size from device tree is greater\n");
>>> +             printf(" than hardware size.\n");
>>> +             hang();
>>> +     }
>>> +
>>>        if (sdram_is_ecc_enabled(sdr_ctrl)) {
>>>                /* Must set USEECCASDATA to 0 if ECC is enabled */
>>>                clrbits_le32(&sdr_ctrl->static_cfg,
>>> @@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>>        }
>>>
>>>        /* Sanity check ensure correct SDRAM size specified */
>>> -     if (get_ram_size(0, sdram_size) != sdram_size) {
>>> +     if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>>> +                      gd->bd->bi_dram[0].size) {
>>>                puts("SDRAM size check failed!\n");
>>>                goto failed;
>>>        }
>>
>>
>> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
> 
> Hi T.F. and Alif,
> 
> I know you reviewed the code.
> But I am not sure on 2GB w/o ECC run it will pass SPL stage.
> However when applied to the patch 2GB w/ ECC it does not pass SPL.
> I would like to confirm that ARM GDB cannot be used to test ECC or not?
> As I do see it involved D-Cache on
> 
> "drivers/ddr/altera/sdram_soc32.c"
> 
> Thanks,
> Brian
> 

Hi Brian,

The code has been tested with RAM boot via ARM debugger on our Cyclone V 
SOC Development Board with ECC enabled, we are able to boot up to Linux 
successfully.

Our board specs can be found here - 
https://www.rocketboards.org/foswiki/Documentation/AlteraSoCDevelopmentBoard

You can also refer our documentation here on running U-Boot with ARM 
debugger - 
https://altera-fpga.github.io/rel-25.1/embedded-designs/cyclone-v/sx/soc/boot-examples/ug-linux-boot-cve-soc/#appendix-2-run-u-boot-with-the-debugger-from-command-line

Thanks,
Alif

>>
>> Best regards,
>> Tien Fong
>>

