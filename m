Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F0D64086
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329C883AA0;
	Wed, 17 Dec 2025 08:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Lqy6eMI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899F183AB0; Wed, 17 Dec 2025 08:27:27 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E6983979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLbMOzixxQxt7fQwQiCduvstQfy5hAkpn2ZE+S/cBqTkXZ6T+TQiALHl87osvdq8U09Xf4rHZAKXZwZhswAir03PnIpceMQHVzXeg7wu3iTr0ofyRk03p7CHHhOpBzb0MPkkOgfK/YycDEoj8qC6zdcwYYMZykJhMhTELWmBaGpW3Q7HLxnAmgc1FJAE8r2m1iJoEVky9uelyoogehO6JtQfT6q1dN2I/q2ioavRPtHZxuLePToi/8GToprFboJgctHMTWH28KZI/LLGnY+zqAAqR/YHW12XzzZGFbIdXpV9j8ZDJSz+RAr3Hzbu/bYLv8pIGLn+M5H97Qt0Qeu4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBlkRqvlr7UbG8aMsRHUIG0qX1LRivN2cErvadJKdPs=;
 b=mB4ChXH5U9TCY8GAczO6GJ8LuqCQCYHwGftOqJaZIfXbyAWzd5JmPW009YSgraMrFFpshv2jzL6fsEWClV1vuNYHY+QVtezyt7o/sb/xTOs6zZef0AFv+cQYBM4Vw19NDQa6QkiNDtaA2dmR/9Qpdrw35QbNX1PEhBmOf4sypbImZ19eRZGpek1OIZ4XELcnnlXp9wX0JB8IaHvp/H9dmqx9ex5VO1gI0VTk57hM/Wdfz387R9LewBLCyvs/1H6RJZFkj+FYPgtD12CXqzjB82dOWsQ8jaM+2ZB1JfS+rPzdlxdqXimKSPQJhb6w7p4jN/X2aogHF1bKYzpYtmQIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBlkRqvlr7UbG8aMsRHUIG0qX1LRivN2cErvadJKdPs=;
 b=Lqy6eMI/MgTv0woDvhj3Gt0xzqRbQWS09YBg/mCiLHS/KKwdQh6U3j7iSEI6V7FInD4l0/DywZdUudYeft5gDJBYuB+HTKRzw5VB6enkb1fztS5OUmpVXAXvFrmTvtOcyRaiHb18/4T8dhhv2rXVPQWEiH15thedzVXo5ZvDjD1x85DvNEwN1u45ieU7ePtxEJl3CMinuARnzF+D2RxlXcO0QywuD0YyK05A6DPBmGDBRm+1h2s/av10XGIg6SbMrLGYzZOkRKsSSLpiY00CNrmqH1gObtYQ7+yQB/fH0eeLdarM01bB999bJdy6R/CgAy0FcWzV6EUVjyTkKdS5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5760.namprd03.prod.outlook.com (2603:10b6:a03:2d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:27:22 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:27:22 +0000
Message-ID: <bdc886c5-c101-426c-844e-ef5b5eaac120@altera.com>
Date: Wed, 17 Dec 2025 15:27:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SCMJ4bK0eQc15zGtn1g9-EOuOucY1z+_AjLwrV6dbY3QQ@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SCMJ4bK0eQc15zGtn1g9-EOuOucY1z+_AjLwrV6dbY3QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: eca3a69a-da8a-4957-ebfe-08de3d3db7a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU1zNnEycUxTVUt0TnVVYlRFdjg2Mnk2Zk9ROEg1cGVWcXhMQjF3OW5tM0NB?=
 =?utf-8?B?WlZRck94SDZiblNWMmRmWlMwbXJyVXNDcTVWZVFmK0JLZmNmN1RQU1Y4aTRL?=
 =?utf-8?B?cjAxTytJdjhWR1J0cGJWcFAzVVZOMWg4QUE2dWQrbDlaNm1SSmUwZ1Vzc0Uv?=
 =?utf-8?B?Q2pNNXplVHdjaStHbkhyam43WFdGVjBONGd2V05oN2JoSXVuUXRnTjBXTmZO?=
 =?utf-8?B?WXlKSGpSeU9GNzNwZ01KVTRJNFAwdnZEUSsrQTNPK2gwaEVwM2pPOWNEZk9Y?=
 =?utf-8?B?SDloVTBKZm5Hb2ZFVGh0bGVlNUtSUTFHY3lQZzVFd1ZaWERPU3BUYXpHSEFo?=
 =?utf-8?B?a09oOUo3MDdMcGQ0TzBvSjZpeUhtdUpQeGhzVk1zOWxJRDM4K1BiOFhaY3pF?=
 =?utf-8?B?M0phUXMwck1pZnBPMFhqbU1RNlNIL1hBbWczUHhjOXo5VHNPQVlLYlRuZlVo?=
 =?utf-8?B?a3VOZENLdVQ3c1g4MWJpSE1qVEMyMlphU2ZESXlKbjh0ZEVRWFc4RkVUWmtR?=
 =?utf-8?B?S1JPWEE1eTBFbXZUM1gxbkNIV2p2YTJYOS8xYjdybnR5TGpQZ3cyL3lHMHpI?=
 =?utf-8?B?a0oyZmJHRWFVa3o0UjlsK2hsVGVJS1IvbHhCRmlUcDRweEVkLzZyajhhbTJm?=
 =?utf-8?B?N3RGWG04eGc0UnBzYXBMVkZtVG5vZ3RvV3didXZDSDQ5cG9pVVRSMzNsdWkz?=
 =?utf-8?B?TTh6R0VBMG1lL01IQWdrQy83cjliQld2amVHb3ZSTytIc1NrY3JQZnNVc3dz?=
 =?utf-8?B?MmMzUHN1SWIvdU1kRzFJZWRjYm42ZWJTVUpaRkpURWFUcEFQd3orMEpja0l5?=
 =?utf-8?B?a3Y5THh6K3JTVkg5NzJWZzJoRVY5R3gwZFBhTGNxbW1sQ1FsOFMwQjF5UUtu?=
 =?utf-8?B?NzN0dEVmMmpLRFI3NDVLbUdyNjUvTXl5bUdCbW5KUGtOeHZuTW1SSlY5a1F6?=
 =?utf-8?B?K3VJcTF0Wm1TQ2JmSkZMN3FxUVBVT04vRnhEK2t6SGZTVENzeXdiMkYzajlk?=
 =?utf-8?B?U0NhUy95cUxUWGxTVDBXSjJYNlh6QjdtN29wQXcySkNyamo4aDRUYlNud21K?=
 =?utf-8?B?WHYxbkxqWk5vRjNyRUkxS1Fidlg5VCs4WlVTZXhHSXpqa21RSUlDNGFNejIr?=
 =?utf-8?B?bmt0Si9PNVFaVWIwcUlzdGhURDU0N3pDNDZlWkt5ZTlabit3Z3YveUJzaFRT?=
 =?utf-8?B?Vk5oVUVtQ2toWWU4bWNSb2Y2NzQxMDVTN1c3OGdia2VPUU82bSsrT0l4dWZY?=
 =?utf-8?B?NGc5M3I0bVM4bDlSb29hWWk4VDMvWWRmWE9XazdzYllyZ3I4YzNkREw1ekx2?=
 =?utf-8?B?c2dwZGw3M2lScDV1ZU43bnlWdzZkL0pUUDUxRGdHcU4zN3EranBTVVJ0WUFi?=
 =?utf-8?B?S2tGbHVRMXp3VTZjY2hzS3Q0WThNa2FLcEUxUFZiMTc4SEpROUZFT2x1b1dI?=
 =?utf-8?B?K1E1YWRya0xEblZ1MnQ3bFJyc3Q1L3BHM3JtWmh3NU5Jdnl2ekpQbXM2WDFm?=
 =?utf-8?B?RlJYK0pYNkR3cGYrdXhwdEJBWGlmS00zc3EvY0NzUGdXQXYyU0NGZ1dnYVo5?=
 =?utf-8?B?Y0dqdnB2Tm1yM01LMDhqbzdYMzREdTFLNVpoajhnbWVoSmNqekdKdjQ2cU5D?=
 =?utf-8?B?TFErSG9HMTNRc0cvckxjUnNJZW9WOXh1SCtiZWlVdGw2ZUdrNTBiMi9TR1Bm?=
 =?utf-8?B?UmJvUFpTNS9WSGwrNUtJVmplSCs1dU5SUXRPMzNzUDRGNnF2QXp1WGxxWTJm?=
 =?utf-8?B?YjN6a29vblJDQnhTOWpUNEFTeGpjSmdiWjNxVHBXOUVkd2ZnWDJ4aTZZblNz?=
 =?utf-8?B?R08zOUYzQWxtOTg3TnFPbWhhZkdpQ3dnTkxSeDJUeUpWOE40akkvY3VmblEy?=
 =?utf-8?B?Syt4MzUyQWtUVklXMFYxUlpWRXRTSERTdEtNcnNLY3lyeEYvWW00M1BSYTdl?=
 =?utf-8?Q?xjup4peQs2Tjvig6JrnHz0HOUvq2vE2v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxvWWpkV3pnMEI3anY4cllHNy9HZTBqWlc1eERsU0lFRW05bjVxMmNyVDIx?=
 =?utf-8?B?MzBUVXR5T0xzQ2xYZTJKLy9TM1k2VHJpdDhFYlNRWXlUR3d2eklSNkRPM05E?=
 =?utf-8?B?Ny94Q3I0Y0FEUnl0QUs1Z3dBbWtiY2Z2UmlzcWRuZE1NdDI5MzN0NjF0ODVw?=
 =?utf-8?B?QlB4Vkx3Y3AweG9mbC81Y3JEeURGY2JjUnNXZWsydklWWjNWNHhqUnNlR0VQ?=
 =?utf-8?B?Z0VQaHU0T1VWRmZOd2dPZi9zRDd6NngwbjN5REFVMHMvWUE0bW9RTjlCWlZM?=
 =?utf-8?B?OTZCRlVJWG9UeGt5RHh5L0xaUlhrVFZsMjVKN0N0a2crZ1lIRTVFRzQ1Mm1N?=
 =?utf-8?B?SnpscEZxLzBRaElKYy9PMWxiTnh1UjJ2Tjd2QVZYaUEzWkhsU2l6Z2NtV0Vr?=
 =?utf-8?B?STR6cE1ETUdPODdGSlpYVWhsRzlMQjR1WWkxT2tWdzVCNHgzVWFpUzVkSDVI?=
 =?utf-8?B?bHBndUhjWXFibFQ2Y0o0My9sNnJQOSsrVGg4cmtObjcvbHJJT1kyT0lFQjRa?=
 =?utf-8?B?SnpKQlduckpEaS9jZFRBa3lYa3BXV3JJcW1kQzdCczdwekNzaTVqNDRlVnh3?=
 =?utf-8?B?UHNsTjI5NjA4ZGZJdnYxS1JsSkNKMndoUEM4NHVkblg5OTlTd0FmTjdYQjA4?=
 =?utf-8?B?Y0QyU3Z6ZmIwL2IxbEFmck1BZU52bjJVUkZvaENNVkFuYTZDVzFzT3RNK3ow?=
 =?utf-8?B?R2RvQTlGRnZETk9JWVY2bmxNd2tuNWpGYlROQ0VXZFdManRwOTVORmFWbUhx?=
 =?utf-8?B?cjh5SmVHOC9CWUQrVWhTK0JtUWFyeWdWR253Qjg4SW1ZeVUwUk5ySkYvb01m?=
 =?utf-8?B?SGdFOVNKbTUzclYvTE5HQ1ZscHFPbWhiVFEwRDRtbTkzWkUrU3k3MkJPZkRm?=
 =?utf-8?B?NHBBUTBBS2piU24xTE5obUNmOWZPNHltQmcwOGdWd2JRY1ZJT3VjNnhUeEJC?=
 =?utf-8?B?dXVsQkVoSzQ2SGJqRU8vdEhGeUk2RUdrZXNkdnhYWFcrQW4wbENBL096TVIw?=
 =?utf-8?B?bFByRnpPbU1wSDFhODBVbXBmajM1YlZ5WGRORFhubldSTWlINlpxYU9xWlhR?=
 =?utf-8?B?RzRiZW1sWFIyR09GZmZGWWRVVzBBM2YvTUdteGtRRmxmU3BBWUdYZDlJNlBx?=
 =?utf-8?B?RUdjMFAvVDFGRnVHN0kwRG50NlZ4WUtuOHEzamZNdDRtZjczbUdBMWozNkxD?=
 =?utf-8?B?N2Z4SkdQN3Y1eTYxaGttUE1teTFqc3h3R0dYdTZzTUtrNnlEWHR5SVIzK1RO?=
 =?utf-8?B?cmxvT1A0a1h4ckV0Q2JpYmo3RmxTRDJodDdoMmNZTWxHcmFYMFNWNko4M1Rs?=
 =?utf-8?B?MkgrZGlqMUVXaTNONEdWQ2ZYejk1VnppcmtmQnVHOG0xbi9GampyakNDTjlv?=
 =?utf-8?B?V3BheEJYV1Q3a1BaVU1lNXJIcGptcVJDd20xVnA3YkYvM2pwWGF2T0YzVGlX?=
 =?utf-8?B?Zy8yN2pHY24xWnVXdGVoNks5aWhHejFCMmQrdkQ3bG5nUnBiYjRWVWxtUzVy?=
 =?utf-8?B?Nk5KZ05tTlBSeTRYQnF0ZW8vdVpRK3hZNWJ0SVJNSVlEOFBtRTFhNStmM3Nn?=
 =?utf-8?B?SE9CdUhVTkxIM1RlK1czYWo5R2sxV3V1UjhjQi8wL0t1bU1ONUhvVGd6czBG?=
 =?utf-8?B?ZDFnYlBTT3dGWlMxRE5zVnhYYnZacUFDSkxKSGdzRTVQdEJwSFpKcW0wK0xs?=
 =?utf-8?B?cFpVRXZxOXFlU3cycy82V2RGU3B6N0FyRnQ4djkrd2FpSGc5NVYrYTR2bVlL?=
 =?utf-8?B?UUNrekc3dnVnbmwxWEJnaS90M1JqeU96Q3ZON20vQml0NlZ1a0RiRVlSZFNH?=
 =?utf-8?B?VUp1Tm9EZnhUTEZFYW5LNVR5QmNYZEdGQ3JFaWI0UXlnK1dhWXcvQmowZFpW?=
 =?utf-8?B?SGhDSVg3SlhqdWZ0NnRuTHErdGNQY05IVnk0QWEzZUgrTUg4QjA4c1FZa3JG?=
 =?utf-8?B?SWFwemRYYkVZRFlsRDhBL2w2NVRZRkRianFaWTIxZnhpdmhna3Q1VlM1K0NN?=
 =?utf-8?B?dHJEWmVoV3lLNVpYM3hhazZRMS9lTU8yRGZEVE5TdnBQWGI2THpka0xkb3Jx?=
 =?utf-8?B?S3BVdGhlMERlKzNGa2ZDQW9FY2xaL3kxTEg1SzlEQjN5U2R4UWJsMnhDTHE2?=
 =?utf-8?B?MUJ6SWU4ekpNNVU3WXlKN29zQXJ5QmdsNDJVQmo2Ui9xWDQxOG1yS1diK3lE?=
 =?utf-8?B?aEY4akhtaFZLWGVuR29ZYTlIUCtkT0t1clVQKzI1V083ODlBNWNzNGo0dk50?=
 =?utf-8?B?U1dGNHZNczNPSnJ4R1UyTkkrTTVuY1dTK2QrNVAwOENxTWJOSXhSTTNlbkxa?=
 =?utf-8?B?MFBCTGhMb044d1JDSXB4dUpLMGw0TE5OejhDVlN1NitXRmdtc3VZYkhqQVJu?=
 =?utf-8?Q?x5q5zsNoUDXuFS68=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca3a69a-da8a-4957-ebfe-08de3d3db7a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:27:21.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68D5dhKSCSVU1L/GAXLPW3Gd1dEqSLGCOG/0GkSN6of4oSXivrX3ijnVnXYhnBFcZVaJNYZUKVJBEtQmfEV4RxuqMLSrl6k8IT4KwtIrNpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5760
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

Hi Brian,

On 16/12/2025 5:46 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Alif,
> 
> I have a question on sdram_arria10.c
> Why spl_gen5.c requires:
> static struct bd_info bdata __attribute__ ((section(".data")));
> with gd->bd = &bdata;
> But on arria10 this is not required, it is done on another file?
> 
> Thank you,
> Brian
> 

I found that removing these will cause failure to boot U-Boot SPL after 
trying to reboot from Linux, SPL will keep on looping during DDR 
initialization.

This could be because of the missing board info in the memory, leading 
to a failed initialization as gd->bd is not set up properly after a warm 
reset.

SPL runs from the small OCRAM before DRAM is available. CycloneV has a 
much more limited OCRAM space compared to Arria10.

Due to this memory space limitation, there is no dynamic memory 
allocation in Gen5 SPL, therefore bd_info must be allocated statically.

By declaring bd_info as static and placing it in .data section, we can 
minimize Gen5 SPL OCRAM usage, as well as making the SPL execution much 
more simpler and robust.

Thanks,
Alif

> On Tue, Dec 16, 2025 at 4:46 PM <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>> case.
>>
>> This scrubbing implementation turns the caches on temporarily,
>> then overwrites the whole RAM with zeroes, flushes the caches and turns
>> them off again. This provides satisfactory performance.
>>
>> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
>> Preparation for Gen5 uses the same memory initialization function as
>> Arria10.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
>>   drivers/ddr/altera/Makefile        |  4 +-
>>   drivers/ddr/altera/sdram_arria10.c | 25 +++-------
>>   drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
>>   drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++++
>>   drivers/ddr/altera/sdram_soc32.h   | 11 +++++
>>   6 files changed, 115 insertions(+), 21 deletions(-)
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>
>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
>> index df79cfe0f7f..5c78a4c1fea 100644
>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>> @@ -27,6 +27,8 @@
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> +static struct bd_info bdata __attribute__ ((section(".data")));
>> +
>>   u32 spl_boot_device(void)
>>   {
>>          const u32 bsel = readl(socfpga_get_sysmgr_addr() +
>> @@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
>>          /* enable console uart printing */
>>          preloader_console_init();
>>
>> +       gd->bd = &bdata;
>> +
>>          ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>          if (ret) {
>>                  debug("DRAM init failed: %d\n", ret);
>> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
>> index 7ed43965be5..b9e3302d714 100644
>> --- a/drivers/ddr/altera/Makefile
>> +++ b/drivers/ddr/altera/Makefile
>> @@ -7,8 +7,8 @@
>>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>>
>>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
>> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
>> +obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
>> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>>   obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>>   obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>>   obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
>> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
>> index d3305a6c82d..0e3a1d42f34 100644
>> --- a/drivers/ddr/altera/sdram_arria10.c
>> +++ b/drivers/ddr/altera/sdram_arria10.c
>> @@ -21,9 +21,14 @@
>>   #include <linux/bitops.h>
>>   #include <linux/delay.h>
>>   #include <linux/kernel.h>
>> +#include <linux/sizes.h>
>> +
>> +#include "sdram_soc32.h"
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> +#define PGTABLE_OFF    0x4000
>> +
>>   static void sdram_mmr_init(void);
>>   static u64 sdram_size_calc(void);
>>
>> @@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>>                    ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>>   }
>>
>> -/* Initialize SDRAM ECC bits to avoid false DBE */
>> -static void sdram_init_ecc_bits(u32 size)
>> -{
>> -       icache_enable();
>> -
>> -       memset(0, 0, 0x8000);
>> -       gd->arch.tlb_addr = 0x4000;
>> -       gd->arch.tlb_size = PGTABLE_SIZE;
>> -
>> -       dcache_enable();
>> -
>> -       printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>> -       memset((void *)0x8000, 0, size - 0x8000);
>> -       flush_dcache_all();
>> -       printf("DDRCAL: Scrubbing ECC RAM done.\n");
>> -       dcache_disable();
>> -}
>> -
>>   /* Function to startup the SDRAM*/
>>   static int sdram_startup(void)
>>   {
>> @@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
>>                  puts("FW: Error Configuring Firewall\n");
>>
>>          if (sdram_is_ecc_enabled())
>> -               sdram_init_ecc_bits(gd->ram_size);
>> +               sdram_init_ecc_bits();
>>
>>          return 0;
>>   }
>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
>> index 3c79bb11802..7a0a043557b 100644
>> --- a/drivers/ddr/altera/sdram_gen5.c
>> +++ b/drivers/ddr/altera/sdram_gen5.c
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright Altera Corporation (C) 2014-2015
>>    */
>> +#include <cpu_func.h>
>>   #include <dm.h>
>>   #include <errno.h>
>>   #include <div64.h>
>> @@ -17,8 +18,12 @@
>>   #include <asm/bitops.h>
>>   #include <asm/io.h>
>>   #include <dm/device_compat.h>
>> +#include <linux/sizes.h>
>>
>>   #include "sequencer.h"
>> +#include "sdram_soc32.h"
>> +
>> +#define PGTABLE_OFF    0x4000
>>
>>   #ifdef CONFIG_XPL_BUILD
>>
>> @@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>>          return temp;
>>   }
>>
>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>> +{
>> +       return !!(readl(&sdr_ctrl->ctrl_cfg) &
>> +                 SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
>> +}
>> +
>>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>>   {
>>          struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
>> @@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>          sdram_size = sdram_calculate_size(sdr_ctrl);
>>          debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>>
>> +       if (sdram_is_ecc_enabled(sdr_ctrl)) {
>> +               /* Must set USEECCASDATA to 0 if ECC is enabled */
>> +               clrbits_le32(&sdr_ctrl->static_cfg,
>> +                            SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
>> +               sdram_init_ecc_bits();
>> +       }
>> +
>>          /* Sanity check ensure correct SDRAM size specified */
>>          if (get_ram_size(0, sdram_size) != sdram_size) {
>>                  puts("SDRAM size check failed!\n");
>> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
>> new file mode 100644
>> index 00000000000..b8b42ef8e03
>> --- /dev/null
>> +++ b/drivers/ddr/altera/sdram_soc32.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>> + */
>> +
>> +#include "sdram_soc32.h"
>> +#include <string.h>
>> +#include <linux/sizes.h>
>> +#include <cpu_func.h>
>> +#include <watchdog.h>
>> +#include <wait_bit.h>
>> +#include <asm/global_data.h>
>> +#include <asm/system.h>
>> +#if !defined(CONFIG_HW_WATCHDOG)
>> +#include <asm/arch/reset_manager.h>
>> +#endif
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define PGTABLE_OFF    0x4000
>> +
>> +/* Initialize SDRAM ECC bits to avoid false DBE */
>> +void sdram_init_ecc_bits(void)
>> +{
>> +       u32 start;
>> +       phys_addr_t start_addr;
>> +       phys_size_t size, size_init;
>> +
>> +       start = get_timer(0);
>> +
>> +       start_addr = gd->bd->bi_dram[0].start;
>> +       size = gd->bd->bi_dram[0].size;
>> +
>> +       printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
>> +
>> +       memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
>> +       gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
>> +       gd->arch.tlb_size = PGTABLE_SIZE;
>> +       start_addr += PGTABLE_SIZE + PGTABLE_OFF;
>> +       size -= PGTABLE_OFF + PGTABLE_SIZE;
>> +
>> +       dcache_enable();
>> +
>> +       while (size > 0) {
>> +               size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
>> +               memset((void *)start_addr, 0, size_init);
>> +               size -= size_init;
>> +               start_addr += size_init;
>> +
>> +#ifdef CONFIG_HW_WATCHDOG
>> +               /*
>> +                * In case the watchdog is enabled, make sure to
>> +                * (re-)configure watchdog so that the defined timeout is
>> +                * valid.
>> +                */
>> +               debug("%s: %d\n", __func__, __LINE__);
>> +               hw_watchdog_init();
>> +#else
>> +               /*
>> +                * If the HW watchdog is NOT enabled, make sure it is not
>> +                * running, because it is enabled in the preloader and
>> +                * causing boot loop if is not handled.
>> +                */
>> +               debug("%s: %d\n", __func__, __LINE__);
>> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> +#endif
>> +       }
>> +
>> +       dcache_disable();
>> +
>> +       printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
>> +              (u32)get_timer(start));
>> +}
>> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
>> new file mode 100644
>> index 00000000000..85a951a5a74
>> --- /dev/null
>> +++ b/drivers/ddr/altera/sdram_soc32.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>> + */
>> +
>> +#ifndef        _SDRAM_SOC32_H_
>> +#define        _SDRAM_SOC32_H_
>> +
>> +void sdram_init_ecc_bits(void);
>> +
>> +#endif /* _SDRAM_SOC32_H_ */
>> --
>> 2.43.7
>>

