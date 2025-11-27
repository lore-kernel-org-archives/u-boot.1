Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DC0D116E7
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 02:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE8A842A2;
	Thu, 27 Nov 2025 03:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AF/hd6GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DFC84262; Thu, 27 Nov 2025 01:56:51 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D8B83AB7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 01:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ3fKl/ZQQw2VG8Jtdx45T9LEjqIU9Jpb6rAvqaZIxzFKwK7KCv4gzC4aCsKjp0n0FJ7/Hv3BgWUQbGxTd6B25j3NEAKi29XxWVVGZuRfy0poD0UIKKfAJMfPqYrOMkn2MNXvPggjPGxO3VaE+jDEAbGne24SWz6j7kHh9LUf8rY3Ibtqjp/oYU3CPtDW3Hp5yDHR9nPTDCpffeoJwP2SXR/XBeZ6/y5EV7I9fGTrUU9r3LqRPGZFRQvY9HUPh3HZGWtfgl+x238OK7QyhnDFZxM/KwsTj9B5u5I60gnYShOUHkllodTO9qDLM6EIuKBPL8fvYEoELNxRiQnasOXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNvy6dK/W+I1cw32DTOfasRawWHVpclf30HlHfpXRtk=;
 b=GDh9eSpxYUrH1S/oyJVpYTdvSpHqMmzlfexGR0MWc+Pz6FrPdTv3jSFfW5ZWc+A9jduNHcDO6P9rIMkOci3r8JJ/Idck7YNqktLkOpT3OrFq5wrr4FZ4t5TOMUXnNceiMB1eGBr8sFP01sHJfm9wVs7wEhaw6SqVB0F6gIWCvY9+MfrH4XZf+gva0qm2b4xfM03DEQLbuu7Q28Cla3FP9lk8PsbKVi9bFte7fwcVauKButQ2ZKeaYc0ZPNR3tQmQ1W02kZwH62t4VMMFR8w2Cbb7AZCNqL4pEz9UTQxQID+1I7bGcdJBU+tV3hBMQwywXNY64ElEId716tpY+OST9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNvy6dK/W+I1cw32DTOfasRawWHVpclf30HlHfpXRtk=;
 b=AF/hd6GEM8xBcK/5UCRYcBhQWJYYRmz8vm4yySLLKIqKit5E2196OJ6EFTrDL4HZF6QF3nb/tXYgvnivhaHkicivXZxFhmoQIkVRx6gBrLsdnyXbBHhPaMenWrae/UzmSe5TdHh31MShfSHGrswjbBHz45aWkYvSqfKOTPx9gndizHm4vxAq0xEA75xFCQgMWrQPaxFbvxSxEeZmjsA22sknGgNehPNt2Ja2KTeQ4fEZIKV4mjmloBAhFlgTZ7Og+FxDFVOkC4ir4O4n78LqdbRrWz3PZOf/lZVjrry5TyWKU0sh3qXvgH0wLPyoxOLrkSKzL3S1iS0zqrgTmWmirg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA3PR03MB7347.namprd03.prod.outlook.com (2603:10b6:806:394::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 00:56:41 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 00:56:41 +0000
Message-ID: <eb3978de-ee7a-4aef-aa91-9c8cabff552f@altera.com>
Date: Thu, 27 Nov 2025 08:56:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size and
 complexity
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
 <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
 <45a5d75f-99f6-4583-9071-2f892aadb2e6@mailbox.org>
 <87tsyiupr8.fsf@bootlin.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <87tsyiupr8.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA3PR03MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: db635962-ab68-4ea7-cc1e-08de2d4fd3da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3ZHc1V5bVNpNllUa2xxVlpaZ053eTZrM3JId29RU2greFhxQTdGSFdvTDZM?=
 =?utf-8?B?OEZDbHR1MDV6M0xIZEF2NWJnbDZaeEJsdWJwNHVRV2kxVzBodk1UeFdlbGNm?=
 =?utf-8?B?T1g2ODZnZmMxQ0xzeThvMElFZVZzeHpzVXNtbkZRVEpaTDU0M2JOdUtFVFdU?=
 =?utf-8?B?MkRRWEhhMFZFSEJkMmlNTjF0WXJpQ2FsZm9QdGZnNU5xd2NYM04vTWxnWnRh?=
 =?utf-8?B?RUxjU1N1akVSMm15VkJRTVllVXNkMVdPcUZLYklxQ0tSOGhtUkFXS3pvQTJK?=
 =?utf-8?B?Rld6b2NBZzMvQ0dodlMyOHZYbEs0MGFOcnVFaGd2dEFIU1MyeUs4MjJoRkV6?=
 =?utf-8?B?YkcyZnhMZGRwcmg0TjFXS3VHR1huaWlrRDVlelRKT3ZDYzlaL0lodmYzVGZD?=
 =?utf-8?B?N0VYSGVCWkRJa0NHSlg1VGc2UWFNQ2JWT0dLU3NmbmpNTGx5bDVKZUtIVWJi?=
 =?utf-8?B?VWlFTW5LSHZDZnpueGNKMW4xWVlpMnRFKy9qSEFuRFVnUzN2WFZIbnVlYWRh?=
 =?utf-8?B?RU0vSThtOEVwR240MWF4dWJoVHdtMFp5UHVhdmxOZ3RBT3BQM1JuMlhkVlVR?=
 =?utf-8?B?UFcrYnpRSStYUmhYMGd5d3RpQkh6V1Y3RVk0SlRsaEJZTUxwWDlaNFl6akk2?=
 =?utf-8?B?NStzRzlMTzlvcGNqdnUzM1d0WXhXNER5NVR3aXVyZ1ZKVnl3SEFHZ2FPcm9M?=
 =?utf-8?B?bTl4d0JyMmlFSktWVmliMlEveHFnK0h1Mm5taEhVdEFsMUtJYi83b09pUjY1?=
 =?utf-8?B?LzU4VFp3UC84MkpkMFVwbDhLclczeUMxSzhwclErMUlBWnVRR0pLVVlVWWds?=
 =?utf-8?B?Y1d5eEx2RUR1ZFJSZWFJMXR6di9YM2JpelNSakhQaFZ6U0lFRG5xRnlDRUUx?=
 =?utf-8?B?OGFWSXluR0dkT0I4NzRoWkhBWTJZa09JT3NFUzJuUFJ0ZXlrSmxrQ2NrMWZu?=
 =?utf-8?B?L0VNN1Y0M1ZDeEtacjJWME9vakdKbnliV2t3alZPK1NWK25wc0FwbmRjLzJM?=
 =?utf-8?B?U0JZQTdPSW4rZHNsS2hpNXlYSkVCWmJtZXlWbWJNb21CeU91M1ZZWWdvVzlo?=
 =?utf-8?B?aHFEU0RGdUtJSGl2a2tMSkh6S0NJdVphTGFSdE0wQ2haaE5YaVNKa1pvdVcx?=
 =?utf-8?B?NW1qNmliZmZTSm1UVjEwMkNSMEQ1ckNlaWUzK0s4eWF0dVpVVzA4YVdPb3h3?=
 =?utf-8?B?S3NhWW9hbDEzVU1rM09semY1VCtjT3pVRGJ1MGNzMUNSV01YdU9qUDNyMFNo?=
 =?utf-8?B?UDg5dytOLzM3Ym4zUUsvczdkemRmVEtFWUR6ODZlaStWMVYrODNNTUFNditP?=
 =?utf-8?B?aElaa2tHZVB2WlJsRHppRnU5aVd5SlZPQmVLcDFKMDdrVXdlU1R3UklFMU1u?=
 =?utf-8?B?ZWh5dGx6K1lySFYya0Q3VW02WmhHVklBVDA0eXQvaEFsTUxyVXVUQzZ2M2hC?=
 =?utf-8?B?alZ0YWpVdVNWTmdHYzkzM0c5QmQ3M1BIOEdyRXl4YnBpM2t5QVBKbHdURlFu?=
 =?utf-8?B?ZFBOMzcyTkx1OFFVYzlSYmZXQW9rR2xIY3JIdU5OZlF3STZUMW9oMmk5UkU1?=
 =?utf-8?B?MGovb1ltcHZLM1hzSEdPbWJlOWJoQ3V4WmErNFVEaVh1S1pVSGE0T0pkaFJ6?=
 =?utf-8?B?QUplcUdNVjh2VTAvL3J5QzV4UDkzRXdvWFQwMHFDb2FjSTN4SG0rSk41Mk1l?=
 =?utf-8?B?Q0h6Z1d5UVcxc0UvelFaNVFoQzJFaVExejhITXpDNUhGU3FqRkpGcGxwN0tl?=
 =?utf-8?B?U3F3MmkwT2lBMDEvdk1VOEVSM2VNRXpIWXhiZEN3U3BnTzdnalg4SGNGdWNn?=
 =?utf-8?B?THE1cS9uSTZwUG1hUDB6dVI4V0s5UW9LeTVhRm05R0tSZVR3blFrQ2haUnVj?=
 =?utf-8?B?aFZKVlhCWDZ1NHZueU91NDA5S2F0L1JmajhXM0FEQWlFQ29sSzJnQXFCY0pm?=
 =?utf-8?Q?3u1lgRWcUK8B/uFdE4aSPz4ZAwkkLb7V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhxVFpVYlYwWlk2Yk1VaUhqQnQ5ZE5FM3BOV0hnYzZSZndick1rQjVzS0RK?=
 =?utf-8?B?czBncHUraTRpV3NQd2YvYW9qYWp6bzY2RjJQbGx0S29pTXI4NzZjd09iSnhn?=
 =?utf-8?B?YUNSNzdmRkphUjR1Qk5PZ3hkR2wvNGxzLzNRTlNPQlNMRXgycVl4MWJlNWtv?=
 =?utf-8?B?bStmUU9HaUc4bmdub1VsQlk5MURqZGUwVEdpZFRxd2lJb2FSdk9NNG5mMnBQ?=
 =?utf-8?B?U3cxOVN0Z3UyQkZPYjNTQ2svdkZFc0ZJSlprUU1SY2Q1Rm84RFRTMXFMNjJX?=
 =?utf-8?B?a3V2cUlSWEY3U3V5Wk52UHc1c2VoQVp5ODE0a1dnU25zWEdWejhzdTEwN0py?=
 =?utf-8?B?eGE2YWxZTEV1akpRaDExUjh1VTU5aVVqcUtlNm5nelFhbHcxQStMR3JVMW5q?=
 =?utf-8?B?cnNmSDBaeHVhRFU5dTVlakJNRTVWUEN0bzhBTEwzVWNiaUlhV1MzQmY4UUhl?=
 =?utf-8?B?bXFZMGtTemx3Y1NlM0g4QWpmZXdlYXFRUk1GQ0d2SU05N0Y2RFhmSEhHV0lH?=
 =?utf-8?B?N2FieGdmNTBtTnBaOGZQQ2puU0J1Tmk3MlpsVDZxbTRWMVp3eWV2YTE5MHBZ?=
 =?utf-8?B?d1pjM2dUdnlBa3VjbDJnWm9ueHVta0xRWnBzRk0xUTIvbVVWSW1qS0MySDNt?=
 =?utf-8?B?ekVlTjBCeEtCQTlOSk9NUVlCYy9CWWQ3RXdRaFJremV2WjNMTkh0NGJYTXU5?=
 =?utf-8?B?TERNRlJXSVZGWnlqRkxPOWVrVG80MkIwMkhXa0x5MlpYVXowR2Z6bExBYjB5?=
 =?utf-8?B?TnRiNmhUU3l3K1RjcDBObjNFRjVINklScExkQk1YRTIxYlp4NG5sQ2h1UXcv?=
 =?utf-8?B?Ykt3alBIM2s3ckRPa014ZGRqR3oxUmRpOXFqV2FQV2QyaUY0ZmxqQ2RtVURJ?=
 =?utf-8?B?MGxwQlgwTmNyUnBkU0ZRaWtvN0REbDNDUTZ2YkVadzVXck15RnN2ZmpkNllw?=
 =?utf-8?B?VENOKy9LcWtRd1VpNjYwbGhpem1NdFhKMVdnMURZTUlvSHFsQjZRVHkrNklh?=
 =?utf-8?B?cS9zTHc1a2FpT3dJZVRvbHF6NDIxNkhGRExoT0ZTbnBwcngwRG1wU3NMWnVr?=
 =?utf-8?B?OWtaeEVYTno2c2lJeklqY3ZaRjBEa1VqUTZ1cmVLUFQ5RWFFV3Rxc0Urci81?=
 =?utf-8?B?c01WNUFZNTIvMzhWUEpyQlI0Z0RkM3VqVDd3Vi9kUzhiWXVOSER6eEh4eVgw?=
 =?utf-8?B?SUNTUGhIVE1qU1FGNFBwbTNXYTNZU2E1dHlMVEdpYVAwRlptQS9oVmZRR2Zi?=
 =?utf-8?B?Z29ZWm1hOE1ucnNPK0I0cUE0ZlBiQTJ5eEJLWjBpczNXZnlWVHBaZ2RTNVNx?=
 =?utf-8?B?Sjl5OVRyaThPOGJkRitDTjVHclN3WWdoMG1qN3ZBbzhYaDJscG9sellvWDFJ?=
 =?utf-8?B?c0VPODJkMEtmdi9iNVhWSXA5eGlCUUZGVG1FczdwamdkUGFrdUxVekQ0TDYv?=
 =?utf-8?B?aEtKdysvSTU3Y056MGRFckpCMmxMdW9qRUxKTmQzRUVBSEZidnd1cVRJZ0Jv?=
 =?utf-8?B?akRzK3BjaHR1bE16VGM4OHRmMUJjWXI1QVJBa1NXRWdPc0tjZ3VyYjVpYTFG?=
 =?utf-8?B?cHY0bnFZR3A0S2M3eWYyVUI3aysxUmNjWm96K2FFM05jaDhxdGdaaWl3LzBG?=
 =?utf-8?B?L1VqVExHVVRUaE5Wb0toMjlSem5SbGFONGFRQmZ4eHV0dUJCcXR2eitSZmFm?=
 =?utf-8?B?S0o3VUxQU2hxekw2WlBtT1dFNXlLbEl5bGVPUUZHY2ZJUTEwWStDbjlvVkVs?=
 =?utf-8?B?T3hReWlEL09MM3RIYWtheGZYQXNDRTNKZmR5SGpucjQ2TCswbHA3UkVKejF2?=
 =?utf-8?B?SVFhVjNwOGgwMm0vYy9mQVVFYWh2RnFzV2dPakQ3RTFoOUx5ckFDcW5iMzVs?=
 =?utf-8?B?VHdPeERMRkJuWkJIdzB3enJRcDRQQWRPc3oyZm90VWw2dUN2Z2wvS0p6UVRJ?=
 =?utf-8?B?RzRnK215TldnMTQ0UkF1c3M1Q0FJUXVVVFdMdkRueUZXSXRuTXo4Ukh4YmhX?=
 =?utf-8?B?MlJnUnBoZDR0SmdYbGNtRm55SGF2UnB0QTNoT2FPbkRHRXM1VER6dFN5NTVl?=
 =?utf-8?B?U05BUy9ZYWFjQ0d6SVgrZnNDb3ExMFJKamJXMXVKTDVRSjc4bSs2M0YrQlRa?=
 =?utf-8?B?SVE5NUFTK05oenMweWlKbDNzbzNlWHB1NjEwMGdnbnhkQmJ0WjQ1UjB5amJ0?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db635962-ab68-4ea7-cc1e-08de2d4fd3da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 00:56:41.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd1SsWk5yjYtGAC4CpDmQ9Hg7z+QHI8QE0O7sWuOfUvmofaXozs5Hr5pj7AMJ+fHR50KTTNsG6nuo7CNKPVFg+NmFUHHmLmI5BlazOXxEUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7347
X-Mailman-Approved-At: Thu, 27 Nov 2025 03:33:35 +0100
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


On 25/11/2025 10:54 pm, Miquel Raynal wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25/11/2025 at 12:55:30 +01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
>> On 11/25/25 1:00 AM, Heinrich Schuchardt wrote:
>>> On 11/13/25 04:03, dinesh.maniyam@altera.com wrote:
>>>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>>
>>>> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
>>> Thank you for looking into this issue.
>>> In the patch you use CONFIG_XPL_BUILD not CONFIG_SPL_BUILD.
>>>
>>>> to prevent running `chip->scan_bbt()` in SPL builds.
>>>>
>>>> The SPL only requires basic NAND read functionality to load the next
>>>> stage and does not need full BBT management.
> You do not need full BBT management, but you probably need some of it,
> at least the part that finds it and interprets it, for sure.
>
>>>> Running the BBT scan in
>>>> SPL unnecessarily increases code size, memory usage, and boot time.
> "unnecessarily" :-)
>
>>>> This change ensures the BBT is scanned only in U-Boot proper, where the
>>>> full NAND subsystem and dynamic memory are available.
>> How do you guarantee that the content that you read from the NAND is not
>> corrupted, or read from already spent cells, or is even aligned with
>> what U-Boot would read after scanning the BBT ? NAND suffers from
>> considerable bitflips and short cell erase cycle count, the bad block
>> table scanning is very likely mandatory. Disabling it because it
>> increases code complexity and size is not a good reason for disabling
>> it.
> I agree with Marek, you cannot simply close your eyes on the BBT. You
> *really* need to know what you're doing here.
>
> In some cases (which must be clearly identified by the system owner) you can
> leverage the BBM only, but:
> - this requires a bit of logic anyway (finding the BBM location +
>    reading and remembering the block state)
> - some drivers set NAND_BBT_NO_OOB_BBM which prevent the OOB to be used
>    for writing the BBM, in which case you don't have any other choice
>    than searching for a BBT.
>
> A third option might be tempting, but is IMHO unreliable, it is to rely
> on the ECC results. For instance, many chips still use Hamming ECC
> schemes, which will generate invalid reports above 2 bitflips. So on a
> badly damaged block you will end up with misses. Also hoping for the ECC feedback to
> tell you a block is bad would require to read the entire block, because
> any single page in a block may lead to a block being assumed bad. It's not
> like you can just read X pages and tell "I have no error, so it's
> fine". Because if the block was declared bad by the OS because of page >
> X, you won't detect it and you'd read stale data.
>
> Thanks,
> Miquèl
>
> Hi Marek, Miquel
>
> Thank you, this clarifies it well. I completely agree — the BBT must not be bypassed, and ECC alone cannot guarantee valid data. Your points about BBM and the limitations of ECC are spot on.
>
> Thanks
> Dinesh
>
