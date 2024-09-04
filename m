Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46813CD37B4
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 12:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E5BE8897C;
	Wed,  4 Sep 2024 14:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKPE8T27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A7A88AFF; Wed,  4 Sep 2024 14:37:07 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CEB88960
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 14:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4gJ0b842VCVe7ziPyEo9/BwAejX/u/gUYphtzMfCr5EitTyLW9bYuATcqqI8Ac+FfXafuUPMmWO8TWEPFzJkfLurxT1pRcdd+cpT+agFmFSjXhvunump7SGnkOPohNGblVt7CFJITTICy2evdnQy3BM/PdG45L4p3/0L9ld/Lii0GQK5cJrf3ARKusptrn6nS/2DS+1Lc9fuI83/fFbi4RcL77dDce+8Xv5OrXG3OVvRLbXGeKwJbbi5nvajjibGKlnqy7J5X0TDceELnOsVuCamsSa++REXz5xgd76tbwyozoY7eZhPRd4Uu1sh0yhdYHgHorQjibo6cUIm1qxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9x2OYyYKaonqFGNiiJg8aVOrF9ZJ0L2VRY+2cz0yxM=;
 b=dLmA07NMVaIlXcQSizj6HZ5hNEH2B4Ouq4opXNNBeiRNEjiLu03afpSfHDtCJqT1K3Gq06ilBo97LNqa9C6D5lCP3wMhlEWtVQ5M3h+t/rjZtpQ1Ebh4001c9PF3GRmwXFLdkMAQmCjXqrfcyVlEkNPNpftWasBVErmhherE2n0JnTNGHYvWmrgPdWLu8kfxjsYj2490d3Gbq1Djc2GbTnNJo6pru0zkStk1Bgj8wlbBVwx1bh0UkTda93+x3NqZQf7bw/ScwmGHM/4UA0/GePp1Z3jxm7dY8Sj78OKkj2zqY0k5tnWRvsSTmEnGniW8rN+fKg9vY6JK9Tl86ZYBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9x2OYyYKaonqFGNiiJg8aVOrF9ZJ0L2VRY+2cz0yxM=;
 b=DKPE8T27VldhpU/0K8KFBrWx+pRS2YZ7B/A33edZJOetUWfJfM+YrL+psZTopdxSJrQ3RMCSZbe3ZMHu1rZY/gZRtHf1nGksgekq84kqzvTx561STHGFyrYCBtyJ5VU44+RqpSLyNmzbWnC6DmZkDricPNGbSVSZqsi+YjT7AJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 12:37:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:37:02 +0000
Message-ID: <c69414e0-c841-41b9-937f-1465b6d35d8a@amd.com>
Date: Wed, 4 Sep 2024 14:36:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fwu: check all images for transitioning out of Trial
 State
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-5-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 338031bc-5f86-43e1-da03-08dcccde46c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEowYXFBdkcxOU5kUUowcjBGd0drcmlYemwrTDlXQk5wS252SlduNk92ckZK?=
 =?utf-8?B?Y3E3ZUFxbHlBalZMUXE3LytJODBOckFFQkVKeVFLWjRLa2JnN0hXUTlkbXQ3?=
 =?utf-8?B?QnJPTEQ0aDlwcGtJWkErWUxiT1ZGMGthWEFtT3hYRkNLdE1hUWYwR2ZEZHpm?=
 =?utf-8?B?S1ZWcTlpbGRxWXFCckZBZElnVDMxU0VUMVVwYStOWEc1MWV6SnliRWpXQkZY?=
 =?utf-8?B?QWV0QWt0eGFwNTV6NWdHVmk1UjR1UXJyclBWUTVGd3BRTjcyV1hUeTZOUHlC?=
 =?utf-8?B?d0RGcXZVcnRtQUVUQlNWenI1YXJmUDVTU2diVW5jQ3A4cjJkMXpPN3VJbThV?=
 =?utf-8?B?ZHhKZWNEdkNEdjBlbi9zc3UvTFlCNzA2WGxwWnd0RC9ONngwL2JFU3I4K2ZG?=
 =?utf-8?B?aDFpdXdHWUt5dGcvY0JwVUozaHB1ME1acTlRS25lT2U5b1NBQllEOGZINWhW?=
 =?utf-8?B?TlNwc1pnbTlubDNSeHlZWXNxeCtHdlJ1REM3V29aeGcvTHAzYnVodFoyaEJM?=
 =?utf-8?B?eVRtSFJ3UFdlWWhoekl2YTBKZ2NuV0hTYXhMM0R6OCs5RFY2ZUp4VWRZU2FB?=
 =?utf-8?B?YktBeEpjOFo0cDc5VDg0azhCdnJMTzhBSURVc055YXpHcmFjcWwrTkFjZnpq?=
 =?utf-8?B?SkM5OVprM3ROM3kwNngxb0szRnh1SndETzExdVEwT0llaGlGZGxyMXNmbnpH?=
 =?utf-8?B?SUxPZEUwakorTUtZcnZwYXVkSC8vQVhaYnpsMXYyckg0UHhQOFYvQmdvY3dl?=
 =?utf-8?B?dlF5cWVJaXlHNStJVmNicjZxZTQ1QklNcXdDckRNaWpubGcvY2YrK3dCMG1B?=
 =?utf-8?B?d3NXWU5CMTVvRStnaTYzRE9odjZIeTdiaDRlNjltN09nL3RGcGxEa2NnT3ZT?=
 =?utf-8?B?R050cFhXdUt5b1ZqQmxGNjZXVVp0SDl1eGtHYUdiMWM0SzllMGF2cHJCRWJa?=
 =?utf-8?B?T1NiUUhUclhmMWNHZzZYODlCUVFxU3VHd1BKTjdQUFBjK3lBdG1VNEhLNVk2?=
 =?utf-8?B?TkFWVWVlR2M4SkR4V201UGM2WXQ0Y3daNm84VU5Yd2Q3VFFKMGs1U3dYSXpX?=
 =?utf-8?B?ckV0a2xvSnkyZklxL3NTWExjR2FNRzUrZUNBMnVGQVFaVmhJVnJucmlNU3l0?=
 =?utf-8?B?M0FuZlg2RWwrNUlCU1NwNlpaeHZDelRpYlZ2SE54bHEvVHBPUk44UjZpck1M?=
 =?utf-8?B?cDBoMEVqRkRyREMwS2FUa3VTRHg5RW5iR0g2YStJQjNzWnBHYWlVd0c0NGRX?=
 =?utf-8?B?bkM0ZDh5NTZOWEc5cDRhOE5IN1hGR2x4V0loTkpHbGZPV1hlcVVhTmUwZXBz?=
 =?utf-8?B?NWZpcWpWS1Y2V1gvTFZUZTltcjVwOGtPT0t2WjFzYU9VbmxmTnVZVUE5STB3?=
 =?utf-8?B?VmFJN1IrdWZiSklmdmljcW9scnhicGY5K29XNUp4RWtzekRHNXZncTg4M0ZI?=
 =?utf-8?B?bFpDMW81REVrcjdHRGk5K29ybTBFQzhQdU5PVW9KRDl5Qmg4dS94SFZ4RHpt?=
 =?utf-8?B?NStSSW9hLytSd2QwUm1WWFBKQW1OWEhBZnRXMlNJdHZocVpmZ29kSHROOVdP?=
 =?utf-8?B?SThFSGZvZE8zRFFBN3l1cjdEK1Q0YWlnR3A3OUdQUmpQMTFEWVRWQjBNRGVI?=
 =?utf-8?B?M05DUmhjL0VjYkkwS0I3emZBY25tdERuZDFTV0FYOWhYR3VacmExanJWb0c1?=
 =?utf-8?B?Tkp6Y05WamluVnBZNXhFTEVSYVJRMWVVZGh6UzVCRUcyY3V5MWFtMHlKYlNX?=
 =?utf-8?B?cjBiblAwbGJERlhGbHFKTFVRcGUwZGd2TGVsdU9YQTRCSitVNUw0YkhrUnlN?=
 =?utf-8?B?cFlpTG40c1BBcFNJWktRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FEOXlwOHJiRFlOZkYxMEwwM3VLd3ovZHg5UUJXdkNSMW1Hek1GYkYxc0ow?=
 =?utf-8?B?c0RmTFVJaXZHUEQ2OTdpT1FBQ0ZCbVRBZzFTS2piK0tyeUpobUoyUEhjMmNv?=
 =?utf-8?B?WS81MlRYMGpWdFRnTXNyTjJnWnQrVHNTaGdzeWlZb05Cc1hkWUY4Wk9NYTVU?=
 =?utf-8?B?bVluYU8rM2VOZjRNSVBxNG5rZ25yQnllYWNCQnpzUERpUEo1ZklTaWZabWFx?=
 =?utf-8?B?SGpUK0NmejY2Vy8vRm01MEdtU0RtT0lwMjRaTllsclpvOE8xSmdvUm9sWVFr?=
 =?utf-8?B?RTFzTEx1K3ErMzgyYnY2aWh2Wm9JWklGZ1hWblNNNnpkU01USXdKQVJKS0lh?=
 =?utf-8?B?M2VKVmkwWmxmVTVEbWJ6WHpaU21ZNURLc1VDY1NwT3RQdUtxWFZQb0tpemVh?=
 =?utf-8?B?di9GZDJLWkVYZ2h0VXlteTZlejhLYWh4azBlQ3NqcTljcDA4QzZ2cmgrMm4x?=
 =?utf-8?B?N2hJQTNtTHVTbndOUmg0OXdMRUtONStDVmVsWnY4V25kbHJQTzJDQ2pMZndC?=
 =?utf-8?B?ajkyWS9lVHk5ZUZvN3J3dFBOeTRRVXdqWVAwamlISlhLSTVqWkxXRm5OUk1R?=
 =?utf-8?B?UHdPUDVBSmlncUo0TEtVU1Y1aVdrMjNFVkZVOXlhNUhkWGZSdXdxcG9oVDdZ?=
 =?utf-8?B?ZlR4QTM1VVdOLzdESllhWkhaaDBVRXFKWkZaS0ZYb0Ewb2V1bFVQbno5KzF5?=
 =?utf-8?B?a1NOUlc4ZlZlVUovZHk2ZXh4ZGNIYlY2OVFEeXh4dHVkbzRINTVSdWNGclpi?=
 =?utf-8?B?bWxaZlVVOWtLSi9jUERPQnB6YmxVMVlzejF0eDlkRFdQUE1RQTlybC83dEtK?=
 =?utf-8?B?YXVTSWxpd2NZTjcxckNJNVJnSkxPMFJRRkVSelJFY1d0SDRZZkcyN0tJdTZE?=
 =?utf-8?B?ZGlxWS9sSktFUFJteTZrOGNTdVNhbzhBaDBpM2MwVk1HdUE1SUZTa2crYUk1?=
 =?utf-8?B?bHZNcVJzRmpFQ25MVElKaFY5MUxOdmRBcUdrZExEaURNa0hCNmhhSEcxN1Fz?=
 =?utf-8?B?K2xlSCtXQ2pRTHo2QzZIU1AyZVdnK1VmMWVQcjJOQXEyYldlOEd2K0tBWDVI?=
 =?utf-8?B?L01oU1Z6NVNwbUpUakxzMmo3ZFladTRBdG1hOVlnNU44N242RTl6dVhTS05U?=
 =?utf-8?B?RVJLcGEyTmtpTHBSSEZIVWxtRk1MZ1ZZM2JqbTJSL3lwOVZQWWU1YjJNdFI3?=
 =?utf-8?B?MjViUENZaS9tTmd6YzJIVllLWVEwamdjR3Qwc0ZTZmV6czB4QWFYSjhPQUhw?=
 =?utf-8?B?Sk9ZZEZyMmVPVE1Zd1VUTThDVnhJM3lEaWdaUEVUWlY1bVNPZFo2RFozTHls?=
 =?utf-8?B?cjZ1STNYMW51cjVQaXNLR3dtZXFmOElPQlVxZTM2b3hmRURhUW9jSC9sUEFE?=
 =?utf-8?B?NUhjQWhlaXk1Q0dST3JlRGNKNzRxOXhCekdWZ0VyTkhEQjR4blhnaXdmb2tK?=
 =?utf-8?B?c1JkajltQ09VRHlMQlNEYkdydG5RSmMzZk1tdWRLVmJOSjM1Smw1U3JNb0RT?=
 =?utf-8?B?RWd6SmRKaW9VK3NKaW0xak9iTFF2WThXcUQwVVl6VGVXaDFEaVVwMmhPbHBB?=
 =?utf-8?B?a0loemZ4TE9jVmhxVUtYdjJiYTdZRXpQNHBrQ1Zoc0J1WHg3aUNoTTBicXhy?=
 =?utf-8?B?eXk1QURxZWpaTnBHTVdVVXlDZS8ybS90N1h6OG0zS2J3Mm5QbVZ2TWQ0bWMw?=
 =?utf-8?B?MkJaTTdQWVJMZWdXZWI5bnQwekhvYmoxTVlWSkh4UlFXU1YxWktpZVh4VFgr?=
 =?utf-8?B?NVcyaGpaeUtZeDExWHQzajNBd0MwSzBqS2lBZHIzVG5zdnRCcGZQclZXTW00?=
 =?utf-8?B?d3JXdWFhcFBjWnlNR25zNGhTSjJHbEh4Q3NwQk52ZTEwc09wRkU0MWs1Sjky?=
 =?utf-8?B?cDRoTDRKNkVpUWh4SHQvVFRSYXpKY3lHaG9pWk85L3hWd1VScVk2UVdMUnNT?=
 =?utf-8?B?aEZPd3Nhb0xiS041NWovcHBhTm1BUzE4OHBIMmQ1Vjczd21XaWVscnVMT3pV?=
 =?utf-8?B?VGRObHhZZzFONVlFTkYzQ2xWUE1teTJqSzBzVUh2cFJ3alNJUmR5M0JnSEhz?=
 =?utf-8?B?ZXZLK2RTS0tVZk5XZmJoNU9aUjY4Y2dOSENIL2pNTm95Wlp0WWNadGl5NkVV?=
 =?utf-8?Q?cqRJAhKxYkDRcSKMZUK8FPWYo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338031bc-5f86-43e1-da03-08dcccde46c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:37:02.4412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8prFfRDKDctmANupxQEGeb6dLsj4PTuVpxzZS2ZCbeC51Q0GlD1lWID18WW8WwF3
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
> The platform transitions out of Trial State into the Regular State
> only when all the images in the update bank have been accepted. Check
> for this condition before transitioning out of Trial State.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/fwu.h            | 11 +++++++++++
>   lib/fwu_updates/fwu.c    | 25 +++++++++++++++++++++++++
>   lib/fwu_updates/fwu_v1.c |  9 ++++++---
>   lib/fwu_updates/fwu_v2.c |  3 +++
>   4 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/include/fwu.h b/include/fwu.h
> index 77ec65e618..70a5166f5e 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -417,4 +417,15 @@ int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
>    */
>   int fwu_init(void);
>   
> +/**
> + * fwu_bank_accepted() - Has the bank been accepted
> + * @data: Version agnostic FWU metadata information
> + * @bank: Update bank to check
> + *
> + * Check in the given bank if all the images have been accepted.
> + *
> + * Return: true if all images accepted, false otherwise
> + */
> +bool fwu_bank_accepted(struct fwu_data *data, uint32_t bank);
> +
>   #endif /* _FWU_H_ */
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index c7fc8987be..a94a769a2b 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -28,6 +28,31 @@ enum {
>   	IMAGE_ACCEPT_CLEAR,
>   };
>   
> +/**
> + * fwu_bank_accepted() - Has the bank been accepted
> + * @data: Version agnostic FWU metadata information
> + * @bank: Update bank to check
> + *
> + * Check in the given bank if all the images have been accepted.
> + *
> + * Return: true if all images accepted, false otherwise
> + */
> +bool fwu_bank_accepted(struct fwu_data *data, uint32_t bank)
> +{
> +	u32 i;
> +	struct fwu_image_entry *img_entry;
> +	struct fwu_image_bank_info *img_bank_info;
> +
> +	img_entry = &data->fwu_images[0];
> +	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
> +		img_bank_info = &img_entry[i].img_bank_info[bank];
> +		if (!img_bank_info->accepted)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int trial_counter_update(u16 *trial_state_ctr)
>   {
>   	bool delete;
> diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
> index 023e43728d..c311a8857a 100644
> --- a/lib/fwu_updates/fwu_v1.c
> +++ b/lib/fwu_updates/fwu_v1.c
> @@ -52,11 +52,14 @@ static void fwu_data_init(void)
>   	memcpy(dst_img_info, src_img_info, image_info_size);
>   }
>   
> -static int fwu_trial_state_update(bool trial_state)
> +static int fwu_trial_state_update(bool trial_state, uint32_t bank)
>   {
>   	int ret;
>   	struct fwu_data *data = fwu_get_data();
>   
> +	if (!trial_state && !fwu_bank_accepted(data, bank))
> +		return 0;
> +
>   	if (trial_state) {
>   		ret = fwu_trial_state_ctr_start();
>   		if (ret)
> @@ -112,9 +115,9 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
>    * Return: 0 if OK, -ve on error
>    */
>   int fwu_state_machine_updates(bool trial_state,
> -			      __maybe_unused uint32_t update_index)
> +			      uint32_t update_index)
>   {
> -	return fwu_trial_state_update(trial_state);
> +	return fwu_trial_state_update(trial_state, update_index);
>   }
>   
>   /**
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index 69306282aa..9c696952ed 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -88,6 +88,9 @@ static int fwu_bank_state_update(bool trial_state, uint32_t bank)
>   	struct fwu_data *data = fwu_get_data();
>   	struct fwu_mdata *mdata = data->fwu_mdata;
>   
> +	if (!trial_state && !fwu_bank_accepted(data, bank))
> +		return 0;
> +
>   	mdata->bank_state[bank] = data->bank_state[bank] = trial_state ?
>   		FWU_BANK_VALID : FWU_BANK_ACCEPTED;
>   

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
