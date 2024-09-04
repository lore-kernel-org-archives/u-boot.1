Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2371CD37B4
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 12:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B147889C3;
	Wed,  4 Sep 2024 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DB1rwlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BEA889FF; Wed,  4 Sep 2024 14:36:26 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7ED8897C
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 14:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViZmUIskojFhpupbVpmZD3oS3XFLctvvsrCtkJIotDhiUE4rlUiL5/G753tTk9AChrnXRgmGVo1FhNot/GNdB3YYLJQXj/4tbbdL/Bja28ggZHZ5Eefbk29jrZ492C2L2txVDhaRLkDZXCKATimG3e9b6f1td+Otlgq4Wqv9zmCPYTgrGsOwo+ZH8NBfeecYr+y4e2CSyo89haOl/4jTnM+sO0C2Kcnyudi4DEw0I4fFLx6LAxl1sDXqp1K4oX2RQCq5hI5Xf1jNedQdCsXPCOA3Q9FKmVVgHr2AG/DjOxqr/QmTouc120x/yCw8kOOkZKs8pSDcZyl9V+czM+shaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud6jbIECoDqqGN6mrcPiYMk+ugxCf78qbohqeYs4kh8=;
 b=qocyeE/iI9xHEhQF+K1wEICxdr5ZmT5WhHjEDumcaPm5dXYTyAEB4y8vZ1FVJMEhT6vOjeQVL43dOMlKf2r1DMJO9PK3fpGKWN7u4EYQK6BvlqAfDGhMaFHkFW9nZngelC6dJ0hLQahkBxMfa2pBgMzpAzlN+sgUciV2o/fHfwUuYIZ8fuajfyvTU0thwMVnomwfJAPJqCkJsr5gbEwUeZ5lIZJUGxq0IozlHyQolwAmEJb3T4V0qX/AaP2l3GnjbGVZLgSFqJtjshCm0j0yweOqnwRVri4mFaKgzhb+RCrTCMaLIFCX35ndpIO5P/T+2DjgSiYs9n4B0iR/bvjPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud6jbIECoDqqGN6mrcPiYMk+ugxCf78qbohqeYs4kh8=;
 b=4DB1rwlRg2OXpEiktKHLrK0dOqyQJOfpNbW7GkMdMa97KoFdv7ApuJnKZiXadkSXOjvmTVpxvM/wNtgYerwOsr2JxPGsz6YmegdHzOBQOHGCFRmfv1akhlUV2id4z9EjRqrUCq9+tWQ6stD325dEdYm3fRl8FBeyczA02y7GjBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 12:36:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:36:20 +0000
Message-ID: <53a73813-654b-4d9f-8296-a87228aea142@amd.com>
Date: Wed, 4 Sep 2024 14:36:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fwu: do not allow capsule processing on exceeding
 Trial Counter threshold
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-7-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-7-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c94ad9a-6941-4b01-a899-08dcccde2dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJFOGRuNkRsSnNkYldaQ0o3WWJ0MmdkaW5PdFhnWVNBYWE4ZEtJQnVmVEdR?=
 =?utf-8?B?OFdMS01XdFlUTXljV3Q4cEYrc2hxTXV4dVJZZXVjRmt5bGhQSy9nRThveFlx?=
 =?utf-8?B?MDdhYjl2RWRyREFRV1FrakFsNVNmQjlBeFQrc29nbDNnZ1RvNU0xT2pzL0JD?=
 =?utf-8?B?ZVBFUGlCWGxhU2J1WmpsaGM4N292bHhiS1Bkcm85YnhZcDMrZXpVU1NvU1BI?=
 =?utf-8?B?cUQwbEVzV0F2YlNEWHVpRXRJWDRidno1SlBmYW5QK3VhUmhiS0FKdjM3UDYy?=
 =?utf-8?B?VXJlTHFlOVZzbXpLbTVBTzY3bFIveWRFWXZnY1BCekROeThzaFVrYmVQWXJv?=
 =?utf-8?B?aTczN0pkcFQ5RDdGM0hnc2RBcGo0L0V6SSthN2kzSkdwUUMwdmtBTkxXTGZU?=
 =?utf-8?B?QkFqa09FL2VjSkZWRHFJbXc2VTRPV2dGNi8rMFVNSDRUd0s2U3ZhZ1pMc3pQ?=
 =?utf-8?B?RXYwM1d3bVgyMGtweXVYNGZ2a1BoVk5UWm5EazM1bHFqdW44TlZLaGgvKy9Q?=
 =?utf-8?B?Sk1FWTkrajQ1c1c5MzBRdmZoN096bHlhRCs4ZDV6N0tNY1RZejJyczJkblhi?=
 =?utf-8?B?cERKZkJyaTRpcWtHWHZoRzhsR09qeTlBVmdhOXFhWitKVStlS09RQzdDNVVp?=
 =?utf-8?B?RDE3Z1I4VDYxcVV1TE0xV2UwRVR3djNqb1dwVmZCZ0dnMzQzU3NSQkxqL3hx?=
 =?utf-8?B?VnROL1gzMXZnblozQTlaZWRwRDk4K1MyWUVYdDZMNlpQVHBUTi9XUFA5dE80?=
 =?utf-8?B?RXZ1eXUrL2g0QzJ1cHV2T1VvbHJCUWJWMnZYdU9HSGtLUUpoSW9HSXdzNVI4?=
 =?utf-8?B?eThqdkdFMkQxcjRSMlZoMFRjOUFnQUFPMEVVek5LRTUzeFlmTE5ZVmNKbUN0?=
 =?utf-8?B?SDVpWkNNd09OclZEd2ZkdEpwR0pjZVNGVFREWFNjbG4xL3crT1l4cUxaOHNB?=
 =?utf-8?B?Qit4YktpNEd6RU94ak4rNjhOd3ozVGVPN1RwVHkremxwYklIY1RQcW0vSUMy?=
 =?utf-8?B?YzFQb1lVczF5b1VPaEM4Z3RwT1lCVEFlM09qSFF0MlJzbWw1RnY2RExKOFky?=
 =?utf-8?B?MHlUTXZMOFgxUUFpT0Y2c1VvK2F1ckg4SXJKZWlpN2VyRjlScUdBdEQvUkxl?=
 =?utf-8?B?UXVoSjQxNEVOeGNmNm8yYTFoRW9IY2lWV1d5Ry9jdGIvQ1lZV3BvcWZscmtK?=
 =?utf-8?B?OUtYVUVvZWYwNVA0WXNBUk4vNWR4Y2MvazBJVzBlanRETkd2SWRwV2xsa01j?=
 =?utf-8?B?NjJJMG9EV1dtK2pxdzN3Qk14Z3BvK2VhQSs4VEROOTA3V2RKVHNEU2RhanZI?=
 =?utf-8?B?bTdrQmdyOVhNWE9nNllvYlU0ZnY2M3lWZHV3Qy8xMEdBbnZwbXRKWGRnd1Z6?=
 =?utf-8?B?M2t6M2tYN0Y5ZUlabDdBdFN3dWVpSU5RTDYwRDZNVzhoKytxM2dudGNBT05h?=
 =?utf-8?B?RjVQQTBRK05keVlEMVFRd1pkRGRMUlB6UXpST2MvZVkvYXY1ajZteTVXSyta?=
 =?utf-8?B?citKMUVKL0JaeVFaWXgvUDBmc3UzSkhrSVJjcVhoMnJ1NU9zMGs3N1dHZDRD?=
 =?utf-8?B?aDROblpxM1lEVDdvcHhjWkNWYnIxZlpMYjJEamtqMit5RUVvVE5YcjJsYlQy?=
 =?utf-8?B?QzdJcUJJVnVBd0RQR0g5Ym1nbzk4blB2NDVLMjhHVVhmSjdUenY5R2Y4TThl?=
 =?utf-8?B?QUJnMi8rZkxuTVhmakpscytFQTVyeHFrQnJueGJWYXRFWUpOSUZaZzdXL0R3?=
 =?utf-8?B?emUzM1JCU3Z6MWx1VW1HN3NiUHJSWDlDTE9sWTZaMWxpNXFzaTREbmk1R2cy?=
 =?utf-8?B?d0Q2ZjBsdUgrbi91emw3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5GNlByYzJ1Y2FUdFF0WnkvMWRkamExZDlublRuT1pTaWdCOFhvQVo1eitK?=
 =?utf-8?B?QkZTWEdNdE5jMVV4WHNaZFF5SUV5SzVRdEhpaTBRV0ZVM0VSOXZyQ2RRVzIw?=
 =?utf-8?B?TGgxQ09MeTkzMTdQaTY5U05FM2lRVUhBT2RKWWxRclA3bEtFRWVxb0xKd1Vp?=
 =?utf-8?B?NHFxMmp0eG9IcFVRNm9DM2Fua0E5WW90TnE1TEdpMmFYVVY1cEFLcTVmY0ha?=
 =?utf-8?B?blBQL1hLZGlBdmRRRUhtemF2bXdDQnJWRHNEcXErR1RjMnlURUxvQVJENER4?=
 =?utf-8?B?TnZqRWNlcGRpOWQzemphK1ZlOENYSEJTMUUyYUJ2RjFnQWRPOGl3M2NENnBa?=
 =?utf-8?B?TUJSalM4OUY0RkdGcVhXOXpjVmVBcmFCTlhtTnNlNkwzeXVFTkRzRHBwUEJH?=
 =?utf-8?B?M1FqaEZqbEN2K2tLMnFWOTB0ZlQrS3MrVU5xYmRXR01HTzdoNlI2TGlaWWJa?=
 =?utf-8?B?UnRBcU9lRDgzU1podml0YWMwZE95ZGdBTTRyQnF6eUprbndvQktZMUxucjlz?=
 =?utf-8?B?RURWN1NxQnYxdU83cGRmVkYvMXU0T0J4OHVUS2l4MGZocnBnRmtaNWNLK2Vm?=
 =?utf-8?B?SW5nWHpyOWk3ZnNOSExRTkpXWUV0TFBweFRMbUhhZGVveWMvYjVwQnlNSW9h?=
 =?utf-8?B?TjQ0MXZHZWkwMk9KMlRTSjMzSTlnWi9MZ2pDSVM0ZEZkWEpYZW5Ic2g0Q2tX?=
 =?utf-8?B?ekpHMmNMTUVaMERpR2xraFNrSDRvL3BwclJOWDk5R0RZWlRQUHpWSmhwaXpR?=
 =?utf-8?B?VElZOFQ3MllEYXo3R3VMaEN5MllzZWNvTHlqdjE4VWlTZkc1U0hNWFBMeERj?=
 =?utf-8?B?c0RQWERHczBUUG93aFFyVzR4VVZ4aFp0bGkwT0ZuYVg2K1Z6SXByUWY1U2Vs?=
 =?utf-8?B?NEVRSUN6VnZRR1BnMi9udTI5TVFlTVlydURCZUMzRUp2RzNTM0l0NnIxOU5j?=
 =?utf-8?B?NFlxQlltcyt1b0JZZlZhaE1qSm9RNVcrbS90TGxSaXhFZjJqTnFHM3AwUkVt?=
 =?utf-8?B?RTA5WStDTUVSWTE4SGFZcWRKRHhUYU96MjFhZmsxcEpqak81MXpXQUtiMXIr?=
 =?utf-8?B?Y0RLVWFaalFpVGIzMmY4eEtYdWFuK1JGV1pvVGp5NVB6MUY0NVdKTTdvL1VK?=
 =?utf-8?B?MUJER2NBTVArN0N4bnZKUHo4bHpySmRhaHFHamNsbjBJaGZ3RnhqSjA2ekFS?=
 =?utf-8?B?YlM2VWxqZklOajJKZTN2NTUwYXkxekFVVVRHb01YWTJVQ05yR2xadzF6WkI3?=
 =?utf-8?B?aHVaZTgyZ2IvME5NWmlYbENRVVRQWXlxWVBBSUlpLzJlWnhDbEx1cU8wTjF1?=
 =?utf-8?B?dlBOQng1c2grMDJhZWNOVnptcG9JYndaREhZUHRucXY0bC9OM1hDci9PSVJT?=
 =?utf-8?B?Y2J4SHhqems3V2pVMWFDSEtIeWhnTXJkUm16YS9QZzBKZkdKTjlNa3dRUjA0?=
 =?utf-8?B?QTVINVRPL2tyY0JzNERlY2luejBlS05lY0RqdmlSZ1VwS0JJOWdrSWV6QnBQ?=
 =?utf-8?B?SmdMTGNxSFBFcE9QQXFWZVZiUWlOZTV5d3kvWkpRMk91WjFKRVlTNkZVSjhL?=
 =?utf-8?B?ODIxNGZCMCtiMUtSc2t4UHZKS3ZUVGdFb3Y1VnNGSWlsTXFKVGJWcVl2YlNI?=
 =?utf-8?B?VEtQMmdRVmF6L0trT1Z3Vlk5QUNja1lXVUVzWkQ0S25rZTBET2FUYllUUGt4?=
 =?utf-8?B?YnJsTzErZG1vbzc2VzcxUkQrVjcrbjlHSWFaUUVPcXdhK0EveFhYVUZPZTFR?=
 =?utf-8?B?RXhZOGk2VWRFNi9UdkhnK3BiL2Zmb2l2SkhieU5OazQ1aDhhOGlKMFk2TVA0?=
 =?utf-8?B?T0R1a2NIcEVIOFRSR0hhQk14Vyt2aE1mM2xMWEhha2t5ZWJXbEs3ekZTZHdi?=
 =?utf-8?B?Y3plR1lRM0tOWVhIRXJDY1haQWhRNGRVMERESmRpZS82WjlaU1ZTczlwUEJi?=
 =?utf-8?B?THd6Rzd5c0RqRWE4RnZabTdBUnRna0kzMzFFVmFaaUhIdEp1WW9vY2VWYmFW?=
 =?utf-8?B?Ry91OWo3ZGdwVEpMVjFYS1ZQZ2RhZnlOcDF0aU9aSHF1UUIzUitCWXh0VmR4?=
 =?utf-8?B?T285ZzY0YnNxKzg1Q3FSdVFnWCtXWUdNeHhHY2pGZExQQjJwTWhmSTl2NTZW?=
 =?utf-8?Q?PvZcNWRnWdfJI3lrmhbLeQIRE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c94ad9a-6941-4b01-a899-08dcccde2dd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:36:20.5815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8zTgGSGQGPH33+7fhKLfTlVtDRCtWJOa3TFfKoMfiG7RfTmTzIPjP5spkX8jkbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> When in Trial State, the platform keeps a count of the number of times
> it has booted in the Trial State. Once the threshold of the maximum
> allowed count exceeds, the platform reverts to boot from a different
> bank on subsequent boot, thus coming out of the Trial State. It is
> expected that all the updated images would be accepted or rejected
> while the platform is in Trial State. Put in checks so that it is not
> possible to apply an empty capsule once the max Trial Count exceeds.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/fwu_updates/fwu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index a94a769a2b..7f085a0211 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -113,6 +113,8 @@ static int fwu_trial_count_update(void)
>   		ret = fwu_revert_boot_index();
>   		if (ret)
>   			log_err("Unable to revert active_index\n");
> +
> +		trial_counter_update(NULL);
>   		ret = 1;
>   	} else {
>   		log_info("Trial State count: attempt %d out of %d\n",
> @@ -762,8 +764,8 @@ static int fwu_boottime_checks(void)
>   		return 0;
>   
>   	in_trial = in_trial_state();
> -	if (!in_trial || (ret = fwu_trial_count_update()) > 0)
> -		ret = trial_counter_update(NULL);
> +
> +	ret = in_trial ? fwu_trial_count_update() : trial_counter_update(NULL);
>   
>   	if (!ret)
>   		boottime_check = 1;

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
