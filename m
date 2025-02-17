Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A887C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1FA8083C;
	Mon, 17 Feb 2025 15:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="scgCTiXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020F280843; Mon, 17 Feb 2025 15:34:33 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0D8807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsIxjqqqnfjaIP7NM5EHuL8RWBdQru00pz2G+l2iSc4+PoGIjpDR0e9R/+OXIfzvlQ3oLZGWDyoGbIhvP4zpOJ2O7XgrJMkMjqsqVPExSQzMAsA0Ecchqg7yf8aejYWHJ3mo4N+JECT0IV+lDIMQWZ3/W7uCXQsi/Iabu4wWQEbfYhwFlRLm38pr96FXA3N1khys7mEnMwjy0Ds8Q64xXQCZB7GcLwTxtd2f7q1hiUtEC2mkSxrDyo00KQnuGRUlciCJc4H3rTrYzdv7YMi/lg2C92iVBdVMSMU9v02tD+9eY+1Fcrk28cz0HCo1aDHAEV3TdLpvHcEXo4RY95pSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt4kxS816fMM+jHsbGDL3ZG7++DbCkaEM+e6QvFQBq8=;
 b=AGn+JiVJ4S9Vjc+sESSsRBg1UawqL7+VERS0FB2HvZ3+x5MWabC7JZXtEtonCeQxxnGJjDcOb9Vz+sGbN6n+BuldxE6FvoP1H4USABssp0P9QE7NtnplXqGY55ET/9N2TqC6rI2AK4QWfY8aqYSCOnB+pm7gRJf8r7ODwN8hPQ/9f5f6QWPocw5ikfzXIUP54QLctZu+n2nTifnwu4V/9oZYS//hNYvMGpC0pbHptVpl0YI7tlV8GS49e+9+BvZTh2atcYlBQufvAAZFVr+fmGJpMgjQdFqhR7Ci28YcvazVlfz9VonpnOtK69NPsIkuqt3W87ImdgsNg7yD5rQs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt4kxS816fMM+jHsbGDL3ZG7++DbCkaEM+e6QvFQBq8=;
 b=scgCTiXmEhmK1PsqL9VZ29TRUgP1kH1ZN0TiWyt1wE/7zMbOMQSTYGvg7LNrLkHJ9egrhBS3HmP4wB3QC1yaEbmmImq3RxN5VgQyU0w6o6gjZ5T8QjuRnCrwKM2ehp5oyTzLToeLXpJyYQKOQ6TQprJ+VYgls+cQNdDVZDwomks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:34:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:34:24 +0000
Message-ID: <b275a43f-4ac8-4d4f-9759-d4df3437fa95@amd.com>
Date: Mon, 17 Feb 2025 15:34:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: versal: Update the reference clocks as per bindings
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, git@amd.com
References: <20250206091533.1447234-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250206091533.1447234-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dede35-4ea2-42c6-2556-08dd4f602cdc
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dNaUhQczlZU1R6cGdmdTZBdjhRWVZmUDdQUHh4RE9WSGRVZkNhL2JUYUUr?=
 =?utf-8?B?WVgzdERwQ014U2RtRXFPdk9sYllTYy9ibGVMaSt0amI4NWxMekVzbnNmQ3I1?=
 =?utf-8?B?UEV1MmYwNWJZUFRDbDZBYzQ5bTgrQW10WWNQOUVJMUwwM3ZTUHpudGg4M2Nm?=
 =?utf-8?B?Ky9KWEYvMGVFc0JaVnpLZk9IWEZWL21XdzJHd21ic1Q4VmFjRDgvRDVuMStT?=
 =?utf-8?B?RVFJWEtBQ3NFcjY3TkdjSWRPR01tT2pYL1JzY0tUaE5Oc1YxYVYybEY3SnM0?=
 =?utf-8?B?eFczZ3pJclp4aG5wRW5TcVdEdkZWYjNjZ2gxcFhVSFNYSEk3RTNCL3ozY3Yx?=
 =?utf-8?B?bXBvakxMbkxuc0JLaG5hQzNzMTdGRE05ZG42Q2hxMlZXL2tmdm0yeHU3NjlY?=
 =?utf-8?B?MUc0R2hieG1NRENVV0VEaEFlaDFROWpUUzVjTW85QnpVdk00dFd2aUdzQktN?=
 =?utf-8?B?VDhLWHkwN0JkVVJ4cThpcldaaHhDZlZJOXdZWnR2WTk0czhUdWNpajU3eCtB?=
 =?utf-8?B?QWYrdFhndzNaVHBHNy82SlQ4dnduQzIvZUFPNGM5ZlBCNkRCVDlUQlp4Y0tv?=
 =?utf-8?B?QUZzN2NQcldmbVgzNHJaUGFPU21hczl6WHpmVmJpV2MzUTBlYzdYRGFXRVZI?=
 =?utf-8?B?cTEvNkpYRzRtMENvM29KZFVsY2lBK0pNa09TOXVSUFFPZXR0YWV4R2dYQUcy?=
 =?utf-8?B?R05JcE1hZkVpQ3RPUGFoZFhkTU8xekl5RG05OVVSblgvaDlkdHVtS0xTUGox?=
 =?utf-8?B?WjJJUjI2NWZEU3p4L3FjRG9qeTdKM3RueDYwL243Z0FTTjNFMVRCM3V6ZjRv?=
 =?utf-8?B?VCtua2hPcnBTOGtZZHoyQ1Z2Y1hGdU96SXdCS2E5L0tWbXJQa2RKMjdoZGJh?=
 =?utf-8?B?enVxdis4eTYzWlVKR0VmcXdOSlhYbEJIYjJNdnRWalQrZGpPd0Y3SUpOWWNG?=
 =?utf-8?B?WkFzRUNrNy9aUW9mNkxpTnNqWlg0MWFMQXU2OTJ5Qm9VRW5sK3ZIUGIwbjdt?=
 =?utf-8?B?YkdYMmVXeEVsR2RxYnJCTTRLYnZkODZERm15L0I4V1h2dkk1Skh5SDgwM2lI?=
 =?utf-8?B?ckJzUmxwNG5DQ0M1eHNzM3BJQ0lncjhTNFU1VEFiaWROMFFNbkhnZ084bXlV?=
 =?utf-8?B?M2g0WkVMbENqbWszWndlSFhvdnFRdTZ3dW5mdlduSXVQcjJEd2ZTNVc0bVJU?=
 =?utf-8?B?VFpXbVZPRFhieXp6UThkK3JtSXZWTlhvRmVLcXM4WWFDZmMxLzJwZG9PNG9H?=
 =?utf-8?B?VWlkM3hnazZCaEp4a25CTytub0xMNVk3WnE3b240aUw3U1lMaVRRendZZFB2?=
 =?utf-8?B?Zlc3bGFLSTROWUVVajdBalFPWmlpaU91U0xWYTgrVjlFak1BMjE1QWYyK2Zj?=
 =?utf-8?B?TmZNc21IdklHbnZESE9pczcvL2tadnNrcllkSGRYVUhQdE1JMWwvN2xRWHlS?=
 =?utf-8?B?SW4rNGFVUGRxbGI0UTJhM2d2WjZTb3h0Q1pHR0xKY0dlN1ZxSHFnbEJBSEYy?=
 =?utf-8?B?eE5XdTJXemtvTzByck9LVzhtK3d3WldmWFh0S3YwZnl2YnAyazJ3TjRhc0wv?=
 =?utf-8?B?VDFyZTVsSVJHZUh1TzFXWmxoTzRrSVF6clc5WStGdXdkRHBIbEpaWS9COTZ3?=
 =?utf-8?B?ck1XWm9ZR2pjQUlIalUyTEpRdmVDTjVsSkxvMnk3bXBTcFk0U2h6NjdFVjlR?=
 =?utf-8?B?eWswa1EyZjUwUUtMT3E4L0pXWFU4TW8xSUJVZ3RwdFdzc3I1NWE5Rkk3cDJq?=
 =?utf-8?B?K1dVODZPeXdWcTJKUUFWaVdXMS9naUV2TEliZmVldHFDUkJab2dlcCt4Z1dv?=
 =?utf-8?B?bnUrVVhESHM5NmNFK1VuSzBpTWZtVlZ5dVByTU9ObFVsa0c0bk02eVFYUHAy?=
 =?utf-8?Q?TPqXKkQDDr2lC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1o2b1V4b0I0WkFEVk5ta0JNS1R1NFBzU1MyREgzMWcrdXIwVXIvZ0tvVlN1?=
 =?utf-8?B?ZFFPTjIyeXB2OEhYVDI4WkVVVllHRUtaWFhZQU44VjRtVTN2MUU0eS9GM1Jl?=
 =?utf-8?B?RWkvWDdLVThhR3FGRWhidjg3UUVBelN6TUNQNmlsVWVHNWFyLy84T1I0Mkll?=
 =?utf-8?B?d0p4ZHhyZ3diMUU5TW9ZZmVyRDR6N2hpTkpCNDhJVEdTaXE5T0p0aDNpNTNa?=
 =?utf-8?B?dEVBSUFhZmh2ZjRZU3dyNm05WkhOZkI3UFVoOTB6TjA3UE8ya2N0TjRCRHhy?=
 =?utf-8?B?UmlIWDZYRHJpazkzNHJKVjRUbEx3U2FPWUN1REF1blBnSXMxWitTMWk1dVpQ?=
 =?utf-8?B?K1JWaHBjTzRSNE5pT0taT3Z5bVZDUUVMdkFtcnRpN2tpUGZKc1hwVUFScnVH?=
 =?utf-8?B?Z0szdTlIZStNY0tFajR0UkliaGM0VmNiMnR0bmduYXMzQUdZMU93ZTBiVUk3?=
 =?utf-8?B?NnNFdkM4MnVJOTdWVFY4cE5EdnZId2NDOThzNTVzS2I3WS9KWEpJMzc3STJR?=
 =?utf-8?B?K3RFTjEzekZZQXhvci9xM2N6cHpJVTRyV2tva1d5Umd1WXpyeDlHOWt5eTl4?=
 =?utf-8?B?d1Z3V1FsbUdOeWxJUUo1RklnSTVFU0cxUDkyUkN5a0YyVzVvVWpvUHhTZE1s?=
 =?utf-8?B?bUo5eTU2ODBMUnFwWjdWWEVoRzlMOXZXaCtJczZhMUVrRlVydlpoWXJ0dWxE?=
 =?utf-8?B?bzcxUTI0YWZTQmwwNVgzU3Jwd1JlczJHOHpyOFZieEl4TnJZeklMa05KUXYw?=
 =?utf-8?B?RG10SDg3NGhLblBLVHNSTmM2NmxjNXJGWE1RNTB4Rm5majdvNnU1b0RRWExi?=
 =?utf-8?B?amRqSTIyNURFL1k2clE3K2o2Vld3VU1Kby96MUZFNExKc2d3dG9UTnhDWmdW?=
 =?utf-8?B?NGpKOUp1WENEZ0tKZXBmZWRJRGxVeGpRUGFPTUN1eERmVVhuMlBMWkNvN3VY?=
 =?utf-8?B?R1E5M0FZT3NSOUR1T05LMWJmNS9PVTlpK0V0S1NDUzlOY2NmRWhYblBYSDVz?=
 =?utf-8?B?RTBlNWdrZnJQUHE1ZEg3dmJwTUhTemFHNVpzUGM5Z0xualJ4Yk1YTlJYUkJW?=
 =?utf-8?B?dytmRTFiMXE0VFZnQmp1U0RTWE41K0wwQmhpVm9mallJUnhiMUNtUXpmQlhO?=
 =?utf-8?B?NFF1QWdxTWlYNUNrRjFidmZjWTZIL2d6K2NoUFVmdXdzN0FaOWxXNEs2ZXU1?=
 =?utf-8?B?QmlKdUhlNzRIS0xRTnNCVThQRWVJTEhTYzZUVnRoR2gxNlVMeElhYWF4cGE4?=
 =?utf-8?B?Wm9YUnFBSVRZM295VEVBSUxNd1ZMeFpJbkJYc1JEaTc4Vnl2NFc1alk3eEJr?=
 =?utf-8?B?WDVZd21XZlcrV1diL0hGa2dCYTBIdGZNWVBRODU5dndqdXRNdFFjODlqcGdD?=
 =?utf-8?B?ZHV5THBHQ3licTRxQ0twcUpCK2xKQ0gyNGtERVUvMXRoVVB1T2xDcXRwbWhk?=
 =?utf-8?B?cVFITUNxYzc1Yk1oRi80eFNteGI0NFA5dEJHTW1kSmE3Wkxwa1JFL3JobzVj?=
 =?utf-8?B?SEt0cXFCNnIwU0JuT1ZrL3FsTnZ3S3FSR25MSkMzdmpTZTAweGU4YWFNbEVI?=
 =?utf-8?B?R1FTRm5kYXIyK0ZjUjRnL3BBSzV4ZzJKMnNNQTlrS0lHTUp6YTU1OG1pa2N2?=
 =?utf-8?B?d0NqR0FUcDMrczFNTFZWVExyNE9yQ1dFKzdBaGs5dlFzcmIxKzFWSE9HZisz?=
 =?utf-8?B?QlhHcG5hRUFmd3pGV2NHdTZEL0M5a3EvejBxbjl2QVdsdktSOTBUdzlkSnBh?=
 =?utf-8?B?bzFLdDl1bVlBQllkYTE0WDZrU1VZQkIybEE0MnFUSkdEelVNRXJ6dHByeE9h?=
 =?utf-8?B?RjR2ZlNvTVlFWE1YMTVReSt2azR4eGlTL2hNeGsyWTZUOW9vTTNaR1BGMm81?=
 =?utf-8?B?djBjZUhtdHZGeVJZeEtrWmtmbFRkSGtGaHdYcFVST040Y1hiRjBtNHE3a0Vs?=
 =?utf-8?B?OXgra3Q0VnJNc2lVekVyeFhLRU9iME4xWDkrUXBQZ1o1MjIyTXQwczlQSXVC?=
 =?utf-8?B?L0tSUXZ2WWJnRFM4N2RYd1hYakpOQWc2cEZtZElQQkVsQzFuYlRiWlAyM0JN?=
 =?utf-8?B?R1Fvc3o1YWNDZC9qd01Vbm1acUM4Q01mY2JmZ2E2YytiWWZPTkRIKyt5WWQ3?=
 =?utf-8?Q?+VJYWGMFM7PcAjlguhnOiONIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dede35-4ea2-42c6-2556-08dd4f602cdc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:34:24.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbCxPY0XH4Xs8BiB949WPVSnriBzYrlHA7sf6JScd+pVTgddu1nS/syqyLOXLcRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 2/6/25 10:15, Venkatesh Yadav Abbarapu wrote:
> As per the bindings the reference clocks naming has changed
> from "pl_alt_ref_clk" to "pl_alt_ref" and "ref_clk" to "ref".
> Update the same in the clock driver. Also add the fallback option
> for older DT bindings.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/clk/clk_versal.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 35ee56d0693..3e471670a87 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -679,12 +679,21 @@ static int versal_clk_probe(struct udevice *dev)
>   
>   	debug("%s\n", __func__);
>   
> -	ret = versal_clock_get_freq_by_name("pl_alt_ref_clk",
> +	ret = versal_clock_get_freq_by_name("pl_alt_ref",
>   					    dev, &pl_alt_ref_clk);
> +	if (ret == -ENODATA) {
> +		/* Fallback to old DT binding clk name "pl_alt_ref_clk"	*/
> +		ret = versal_clock_get_freq_by_name("pl_alt_ref_clk",
> +						    dev, &pl_alt_ref_clk);
> +	}
>   	if (ret < 0)
>   		return -EINVAL;
>   
> -	ret = versal_clock_get_freq_by_name("ref_clk", dev, &ref_clk);
> +	ret = versal_clock_get_freq_by_name("ref", dev, &ref_clk);
> +	if (ret == -ENODATA) {
> +		/* Fallback to old DT binding clk name "ref_clk" */
> +		ret = versal_clock_get_freq_by_name("ref_clk", dev, &ref_clk);
> +	}
>   	if (ret < 0)
>   		return -EINVAL;
>   

Applied.
M
