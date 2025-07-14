Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77817C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E7382AC4;
	Mon, 14 Jul 2025 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EXCdN+q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B0882B07; Mon, 14 Jul 2025 14:23:32 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3FB1805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmZGjzxRPY7JdTY6znSwGeE4wGHX9qd1n7IMutFaxp71Gg2Wex2f8zXx7KufohOitVGBSxUWr2ti7mhpyLJzY0VVYeDMCLrTA7D3QWBqXGBQjyXtAo0gGJvKmKwTxBljV4FPneeE/CeVj350OFV4kBNCZnPDDX/lMeu2xJHkDIVrbVp5g2b76uxzR53+yGdA3b2GQYNjaoLgPfN/u3FlWYBYFokwoudv1ZlaLPZir2dLpXKyeDhr6BuQJWaqlp1H/C7G8L2kMS6whtodWeW134FyEQsGjomSQpmoRZ8OiEPARKijup0rABun00fHvZW2BpmSsj4VgDhyaVAj+Tv+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daescypqEsBrGFCEGJyHgZzHcp7Fx0fXwRII2I5Mufg=;
 b=ReDh8/qTWI0i6F/qDSne3hfG8/H7cInhWvrrKyIYdAeyVg9s1OLfgvAeE6nYlemlaxOVT3AqpU1d82aPCa57h+whrESyrOg/+7ytzslecxC5b+6uKBVgYR3qHWrw/8GzqlDSbbFoUUaUyB9UHFeskQ1q7skE/x5Hj1nEVPW+TEZYIpfDTd/JmoaAHn0pkoiihm3CLivfWCIHJ8z0PB+bKI8HAaodyIRq1lU1qHXym9GXB1Yv9BL8wLAJ3HVZWP8uLvLjjEghqNns8z9PKY7ClTc1Qv8TirtgJy1D2C0tKRyiXi0Skwr2iDIj2cE3BmykpQv1vOpWNA9krcr1vRMenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daescypqEsBrGFCEGJyHgZzHcp7Fx0fXwRII2I5Mufg=;
 b=EXCdN+q6mPdOYEQ2pKNy6iM8L23RtxOWz6aE2P9HJh5bGodVblVvlv5XCOV9AwZGEiSU6WqErbWByn04LpnYTj/g3/MtDOTAzwi/myEOhuaM7nvzAmxjBdOcKncuToLGCduT0f4RlMsHQEmwfyRH2V2mQNLvykZ+OmDx5jClGxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10322.eurprd04.prod.outlook.com (2603:10a6:102:446::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 12:23:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:23:28 +0000
Message-ID: <d503ad70-75dc-415c-921e-e89aaed73bb8@cherry.de>
Date: Mon, 14 Jul 2025 14:23:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cros_ec: sandbox: Use correct value for number of slots
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-cros_ec_sandbox_fix-v1-1-04ac442b8f69@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250703-cros_ec_sandbox_fix-v1-1-04ac442b8f69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10322:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f9d87e-ec0b-4e64-1813-08ddc2d13cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QldKdnhuUjZzbzZrVkFWSGltSU1VTEdOaExpV2lEK3lQQi9IQ0JzbWs2RDFM?=
 =?utf-8?B?SlpSMXhkd2RFWGdQSy9FdGNlL2QwcVpXaUdLNDM2RlN0SU9OWi81azhZQ2dU?=
 =?utf-8?B?SDMrYnRPaWdZMm1jQjJCWXhkOTVEQ1hGYm9KSG45U1FlbzdFaTNpalZINCta?=
 =?utf-8?B?dWQ1WVBEckl2ZVRyUGQySC9YRnBOWmM2ckNzUGFleGhac0ZreHQ5WGZRSkFE?=
 =?utf-8?B?YlBTNWFzYkpSV2ZYTXZuZEdmU3pHWTZPOXVPZ0QzWElhbmxHV21WM3h6dnpr?=
 =?utf-8?B?WTdVMGhDQnppMnd5SE5iQzRvZFFhQmQwSjkyMktvSlB2VkQxYmJXRUJRbG9h?=
 =?utf-8?B?R3UwRlRRV1RtR051YllTTW1qZUFNc2NwaDBWMDd4dndqcW8vOWptb1lOb1hl?=
 =?utf-8?B?RStaY0E2bjNidjlFdlNNeDlGc3lKQVRGSElXbkNNOFFzSHRtaDBTMXZJejc5?=
 =?utf-8?B?aGlTQ0djdm1lM0JnT1F6V2VlR0g0bXc3czRYc1FQeUFlWE9XbGNzWUJVcmkw?=
 =?utf-8?B?c1N0VmE0Mkd0TVVFcVR0YlNHUVpBU0FHd2FVY3I4clFHdUYrNHhVbFhYcXNR?=
 =?utf-8?B?QWNUWDVNVkZHQlFVUUtoWEFmSUdiU2dDempQUFF0NVhPWGgzQW11eldKTHRS?=
 =?utf-8?B?a0svWklrWmxsbnZSdmpma0I4UmZKUWNSYmR2b2RuRUkyeWpzZkc2VURTVDNw?=
 =?utf-8?B?TGNFZHB5RCtzSGwyTWExVVRjd3g3b2xzZlA5RXBoQXhha3FBNE5RMkhZVi9W?=
 =?utf-8?B?c0c3NkxCQlZVeDhYNG0zZnY3aGY4dkFXSlRxVE5qMWV5MHA1eEd0a0pISFJX?=
 =?utf-8?B?K0VYUXZUYUI3UGlVa2JTNWJQeFUvZmw3dkg0ZkloNEtvYWZEMW9VZytNYXlp?=
 =?utf-8?B?V2pzcjNSQmY3QnU4dWgvaHRQc2kzN25TYmx6ZWFYMUR1OS9vTElMNmVrWEwx?=
 =?utf-8?B?dzk4Ykk2M29VTkZ2M2cwdTJxUjYwcWFIMGM0Q3pPWERqeTQvWjJ0TEF5ZG5z?=
 =?utf-8?B?MDZOVC9vVUl6NngwK21oc2tVbVgzMkdqZXpSaDF5YnMreFRhV0Jic2VlMzZu?=
 =?utf-8?B?aFY3cEh5dFVLZzJBcFdKS3M1elE3VFlBMVlZd3RraXlVMXYxS2hodjc4eCtK?=
 =?utf-8?B?eDVoN3BVREdVYTU1eEI0WDg4WlptU1FRanpMRkJYTXNnRmNjVXdOaysrK2xh?=
 =?utf-8?B?YnhQOHhPT3AxR3pZUDZid0xBWHJ4UEZoMFZvOWlydC8rQ0tlV3NtM2RkT013?=
 =?utf-8?B?TDJ0amMrTSs2UVQ1U2N3SzdzdG13dzV5WThjbzVkL3ZMdmdsd2QwMWdneWY4?=
 =?utf-8?B?Z21CV0xKbXJXVTRLdTM5UG5FaEpJOC9tTXdBRWZiT0tWU0NkV2hNeUpVZWNZ?=
 =?utf-8?B?alI0cGZTMG51QVNOcHBZT2lzc0ZvcnBVakFpZ3FkbyttQ0txRjFkK3QxUnlo?=
 =?utf-8?B?Vm56YU8reXgzYy90SzJwd3kwZGpTQ3lGL0p1QndObFc0MFhBYjkxMEpOSzVI?=
 =?utf-8?B?U2V4RVlMbnAzSkhBa1JTMmJuK3BGRGtoUnV1SDZVTWpNTk4zVUZkcmQzeUFl?=
 =?utf-8?B?Qmxaa09GdzhQN1RzKzA1amNCS3plMzFYK3RKVGZFRG9TWUZ1MDdReVdUU3Ar?=
 =?utf-8?B?aFl4MnpMak9PV25lRWtUUGE4M1l1b0dIZDg2cWdqTzRyT2p4SzdqZkFmWkEw?=
 =?utf-8?B?NjVONzVteUduZDU5RkttWTcvYStWTzFmYmhScWl2UFBFcW1rQlZTWUpkeW1i?=
 =?utf-8?B?NmJQNHZOdEtQak5jYXdwWG1CdVpNalF3b01RMEVBWTkrcGNqM1huU3BhSnM2?=
 =?utf-8?B?UUw2TVNTbUQvR0VWS2NtdW83Qkdpb1RKRTNmQ3p3MjNXSnpOZDhBVXJzQ3RN?=
 =?utf-8?B?RkhmWFFvZVYyaWZxNFZkTDd2SG9xcFQrUE5jRFdpTmRjWWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxBdTMvK1h5SnJEdHc5LzlBbWhsNVNJNmIvZFd3TUY3TGVvdkYrN3BZcTZX?=
 =?utf-8?B?cjdZZzlXdXljWE4wMHNKelYyVUJzMlRmSGcwaHphVXNIUURtdTZHTGZZTEFo?=
 =?utf-8?B?Y2ZrdzZHenUwRzg3Ri9jNitNZEYzSDBUbTFKRi9mbFU1b3A2L2d0WFAxcjMv?=
 =?utf-8?B?UFRkTG9aazBQS1dSTEU5SCtxTkNYVC9SSG5qRVRncDQrQWNFT1hheEJuRzJE?=
 =?utf-8?B?RlBHZnBCNDZ5UWd1WDhxYk5ld0NWWk40VmZSR0cxK2JRQm00SkRDMGlhcGdw?=
 =?utf-8?B?MkpHOXVOZmovUW5odzZrVlduZitDU2hiZlhWSmswd0lCdVhXK1RKZzloYzlU?=
 =?utf-8?B?NnhJbzVNN1JwZ0RJdWVDbGdmTnZGUEVyc0JJdU1nd3p4QnNYOVRWUFVpTEp0?=
 =?utf-8?B?R2NEcVhSM2FoUzJKaDZGVk10U0FoOXAvSE4xQ1NMVWsrcUV0a3BkNkJZcHVq?=
 =?utf-8?B?U0NFZUFmZnF1aFhuR0l1bkRCd2dhdEpmNDF5dmVleThpSU1hY3d4a011dXFx?=
 =?utf-8?B?MEF4U3hBWlliMEVuMjFiQmI0MEVISGZRb1Q4UHRqRmFTY0lmb2ZWMVp4ZDZC?=
 =?utf-8?B?QVIxRnlmRW9Fa0hyeHVmR1c0U1lPYllJaDF1MGZPeTNlaVI1WW1YTm1WNElQ?=
 =?utf-8?B?Y2RqVWZnU21iVTgwVE02UDhqbTYvMXl2UGF2NWswQWNsTGdnZnkxODBGelU2?=
 =?utf-8?B?dG9sdm5FY0ptMCtzYUIwa3JVbDdUdDFhZmFEOWdnQzY0M1lkUStwOXpuU3dH?=
 =?utf-8?B?VjFOUEF0d0Faa24yMnlYNmd2cTI3aXpjOVFmT2NINXgwOEhpdC9xZWY5TW1Q?=
 =?utf-8?B?TkhscU9odGx3V2dpaTNiODBHYzdKUEg3TkJ3eGdJaHAwTWJSRGJxcUdMSmR0?=
 =?utf-8?B?b3EvOFByR2RqZVJFS1JtOVVFb0I0UjVSemlBeGlCS2dUUHdwVlRyUTRGNHR0?=
 =?utf-8?B?R3Myd3pWSjBDVVNZUzJaSm1aME9XVDBQOThoZHVsQy9aVTludnJLNnBScmFC?=
 =?utf-8?B?a1E5S0JUYlY1UEtkTitBR1JyTW5wNFhjWWJ3T1dLYll5TEpNSTNSZU1QY2c1?=
 =?utf-8?B?MUM1NVYvV2VGWXNLemtTUG9FM1JjejlZZEExRW9CTFN1WmFwK09aNDBnRkto?=
 =?utf-8?B?Q2FMcy9LcE5IdTE1eXlJTmZXOWdGcWZPbmwrZ2Y5RXFGdzh1RE5CSGJXaTdk?=
 =?utf-8?B?d2dVbUJ2S0N5QnZrN0kreHhlaG4vZC9IcnExZ25DTTJpYlduMktlelh2aEll?=
 =?utf-8?B?bzBxbm53RGNrVDdwakxEdGp0aTRUaTNUUEtBZ2czeVZKNWhNajVaQXl2cVJV?=
 =?utf-8?B?NzliU2ZLOWpwNlpFVWtYUzc3OHp4NkU0bjBTOEppU081L2JNdVQ2UVAzaEtL?=
 =?utf-8?B?c1pDNDd1RFNMOEM4djRTcC8yZWlOaG03eXcrUm5zUHpCdXJsUVoyd0k2MUJw?=
 =?utf-8?B?U2JmM1Avc3BzdzNoTS81VSs2YTRNSmJISUpOempabDBzRmRPRFp3ZHM4blFv?=
 =?utf-8?B?QUR5dUpzUHlKQTE3alIrMFMrMnI5aU1BMFJkclVDakJTaTNnd3EzM0FyZ1di?=
 =?utf-8?B?Q2d1cVo5TGdYcFBXUFQzakFvQ3lWa01wS1B2a2NvbVM1amkwV1IwSWE1dHZl?=
 =?utf-8?B?ZVFhQ3dOWFd2SklIM1ZDM2hCSjdLV3k4alBueTZjSmVpdklDRVhhdi9tUmtj?=
 =?utf-8?B?OU1CVllsQ1lhb0UrYm5sTWlkb0U0eWlSb1drbElZb09ydUJpZFpXbENoTnNs?=
 =?utf-8?B?WmxFSmdvYWxDdm81QWpZR3YvMXk5K1k2TnFxb0ZtVzZTa2duS3MrbU9Ta0s4?=
 =?utf-8?B?SndIdWw2M0RmOWJrSys3ak8zVnBMQkZxa2dySngwcWw3T2FpUWt0QWtIV3dR?=
 =?utf-8?B?YTF3MzVrenY5T1ZoZWxJaEhpMGh3ZWhlR3hFMUVqdFNtWXhhZm5NTXEvRUNF?=
 =?utf-8?B?aGRIeTNMbUhLcG1SRzVsS1ZlazNrMjBKWjA0alFteFZHakppK1F4aWE3QTht?=
 =?utf-8?B?WjNsdGxSY0Q1QTR1cUVjd01NTFBKNUJUaGZIMG91bXFsd2t4RVUwOTlNS25q?=
 =?utf-8?B?SDRHdHRudjV5NFRBSTFvN01ZMjBCSlNudVY1eUhVQ29UcFZYbzRncXRLWnVr?=
 =?utf-8?B?OVdEUXhjc0pOejBQN0xodFlqSlJ6cEhzN0wxdDdPNjlEMm5qamt2WDM5WU5w?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f9d87e-ec0b-4e64-1813-08ddc2d13cf3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:23:28.6603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9apdsEXGX+flzH2XtHsLz1Z7F7puNkPo5uzct1FWQtjlffZ7tXnK5PB4/yFLVQWHx2haqSHApFXuF1sfHpz0o1KqnpQcp3PX1vYLMxHgMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10322
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

Hi Andrew,

On 7/3/25 12:00 PM, Andrew Goodbody wrote:
> In the definition of struct ec_state the number of slots that are
> created is VSTORE_SLOT_COUNT (==4) but the value of req->slot is
> checked against EC_VSTORE_SLOT_MAX (==32) so this can lead to memory
> access beyond that allocated.
> Instead change the size check to use VSTORE_SLOT_COUNT to ensure it
> matches what has actually been allocated.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Seems reasonable to me:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

We could have used "ARRAY_SIZE(ec->slot)" instead I believe but the rest 
of the code is already using VSTORE_SLOT_COUNT instead, so it makes 
sense to stay consistent.

Thanks!
Quentin
