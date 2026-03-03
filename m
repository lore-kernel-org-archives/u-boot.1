Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0482EEDA69D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 16:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC676839DF;
	Tue,  3 Mar 2026 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W1lhiaHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6214583F2D; Tue,  3 Mar 2026 17:47:59 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E88838BB;
 Tue,  3 Mar 2026 17:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz/YfIImPcTDToMmbLokZcPLgEsBAHOp8adaAzeTkQwVhWUg33H8zaf0CdkBugCnfrEgfA8cdyPaFTjqP/nylp1GztMksffyqgCjwWked9ybobzUx1pHqT3IzvNzb+eyN4zOvR5UggohRwfq7/px7IokJk060pSCRnG/iV9XmDkY/sW8v35rjEKmHBDyQZy8wGV0rqeBrv5ybeyamtt+zraIuom2BZscG8qeo06CzhJS446jqzRuBspGWi1u6Ftt0j1oKUSh348PMwq5frZ938iCW0zj0/m1CWyv6hH1ouPnVyI3ZM7W2f7a8lkL5jWzGXKOtB6WSLuvXCiRUsZzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiHcvwOIKFXu6PZSxahMhhtBxZZKorQ4IeVQNqqYJc8=;
 b=kxSAeo0+N4LIl5rwWZjLQvYD0En3UHE3U2XRM74X9jq2IJzEpH1aDzfJKa+VD4N26vKSm+lyaXXeaWjd1+/AcfcbQFGxfJlBwCh92tIRW39QIXGQqzDkTCaR6JnF0hV5iyEcsO2CJHa56B2lkneAYmXlPff7K0ZHEA3D4scoI63FG3rQ+OThbYmWNYGk55SUkwavypsXGO5/LcCU9hTlUegVej5Q5sBxPxGb8mWX4ZhpfI/VZu5PY04Hl9wyDV0m54+PCbVju4zHd/Q5BTB0wpuHzx5zYAErGEMEEcl1LyI8kA1na/V+e7yHlJJ8uCs4qLVOojuBfkbRE4Bd0+RZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiHcvwOIKFXu6PZSxahMhhtBxZZKorQ4IeVQNqqYJc8=;
 b=W1lhiaHY/Z0DE0C++v3vV2Omb/RvB35Y4TlFX/xQ7hSjYScKtT7HrauxNWs2n9iBN9JCarSC8YcrQi/ZnWcH8THQXTcyjo+MQJ3dvj0cCsUs3GF1wFOZULkGaJNS6kXeZiDfVpEz6HCynp6PQ07iWglc96mvKhOke8C/5tREuNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB12112.eurprd04.prod.outlook.com (2603:10a6:10:641::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:47:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:47:55 +0000
Message-ID: <125d5679-6ef5-490a-b09e-6517ec3cf1af@cherry.de>
Date: Tue, 3 Mar 2026 17:47:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Binman and blobs
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
References: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgrGjthPK8uxD0fErNfgaGYawiv6ojF42sakLj7oVejQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB12112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af48315-265b-43f8-e6fd-08de79449e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: Yxp5cuiqHgz5FFMy1ZJXtu/WBkUP611Qk13Ir9EfEATbYkMd/TtgMbanlhT+I6bdzGiphELWcqO3hf/xKkvXV7Q18sH9YIZJS7AZ6NuunbpaPR+1aDO+ckzBCDQpIYeHjuoS7+VQA3oPreq7s191RamxUcNnXxwe5wi5sbi+KgXc78jJUhrPUwEGP9hoEYf9iCzcvBdR7x2nldHb2up3frw2wV72Trkbb7tcUots4+rvGi6N8OQA/+f+5oA2Otit+K5aJH0gph3QWLN9wpuxJvCIcsCbAxOZngIGtGkSmbF6N8f2cyrVPtutjZdGgr3PD8PEpAn3B0fYMfyxor2npgOKZmVyOTBFEroyM9TjXvE4YAAFX1yvp+m6UDcji9m1QFyHv4zkyQ5V1XWi9VLbN2pU6N6onQp2tJOXhdJT7+PszhBRFKI/Nh4npVRu3J2Uwx4G67qxXbjZutijfgA9n7LTnU6eYSUyY+l8hNQUGXobZi9ChCLYGPk41aSAd/HD2II+vHX9WrKl7tBfgF2YrPWRSQy6gqNel6tiuj3NRY7Rtmty6JmbflesZWm3+CURV6kT8LKhz5AdDkShrH9h1S1k/eM2SCEu+CLT7O8U/r1hgn7ivMPqf3gXZGSog6apYBvdxpmmiruI+26cNTJL1HreI6kR41sPGNp4NNImQc2joItE2lDu+mxq1i4/PdNanv6iHMISvmN952nr1JY80kBbnS48cMP6iU1g9eMmxbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RUTm4zM1RjK1NWbklnRXZLUmVzcVRTVWR5cTJGOE9Qa1J3V1lYZ0dSSmUz?=
 =?utf-8?B?cSt4MDFTM2pvSzU1czQ1YlhGQlhnTXlwOW8zZXh1SStNWDVLUEhwbk1ON1pw?=
 =?utf-8?B?MzdMOEVtbFdIM2lpQzBzbmNkSkdqb242T2dLODYxQm15V05yM0tKSXpqTnY0?=
 =?utf-8?B?cnBWVXBESjNheTh0alN0OVJlR0s1WlIwbTVXUXdaV3FoYVI5eGJuL01nbnAv?=
 =?utf-8?B?eFhNQmlNRUVkUkVoK2thK0xWcHZ1UVA1SnJvenRlK2ZvZS9vVS9GRmRqVFFU?=
 =?utf-8?B?TGFKM2lFeGoycHZjamZtbDFPaGt4ZnR5V2YvalZNekhkQzZ3YzR5RmNhemtD?=
 =?utf-8?B?Qytkc1hhc2lPT3diK1lhcmtkaEJnbFYxenl3QndFYUdXeU5WT2VEcytVSGRt?=
 =?utf-8?B?Rks0NytCSSsvWktVSnU5YWZvY1BrTmlQQTFBUmE4UmpGSWd4cWZBUEJKRWlp?=
 =?utf-8?B?d0N0ejQvd3JKZ0NhdnFlaHZZdGdhV0FJeUVFV3FHREJQRHVJM1pTZm11SlNh?=
 =?utf-8?B?NWRGcThTUGNnWG9UaFJlNy93eEt2QVkwZTFhSjQyUzRneEpoWGZDMjU3U0px?=
 =?utf-8?B?THJ5L0xmZ2YrdFJtWVhwZkFzRnNZYUduTFdqR3dXVk1HeTM4TXZMNXlNVUQr?=
 =?utf-8?B?d0NLbjJoajdxZGl2QytZVThQbjRRMGkycFpFNlp3TGx3M2dMSlNOTEV1ME5B?=
 =?utf-8?B?T2laR0pzUlM5ajFRMnNKQ0xvdEJ3Uk9yQ2lMdHY3cTh3VFNvdmt3U2lybzU3?=
 =?utf-8?B?VTd1Q3MrL0s1emJlNzFJMkNtOGl5M2RmcC8yS0pVV0M4ODVhS0E4aTYzSS94?=
 =?utf-8?B?dmZwNmYzL0FjbnBoWE5JMG80c09lRnhYcFhUVFczSUk2Y1V3SThxaDBlZWk5?=
 =?utf-8?B?YThha1hDaVk5UVlqV0tsN3p2aEM0cjgyTXBjTWFZeFQxeE1rVnJLVlRGd3Bs?=
 =?utf-8?B?eUIrOXR4WjRHR1dZSzJkV0l1RzhtSEx5c1d5T3dyMHdOUEJoeDVQZHpyZFN6?=
 =?utf-8?B?MHUzandqMFVkRHhZWkpBSDNpUS9oQWwwKzFSbUxvYkdKYWRjRXF3L3JFYWVX?=
 =?utf-8?B?aFRDRGx4VGFoSjEzblZxdnFxNUVadTNvUHU1SkZIdDdva1ZvY2FIN0J0UVBq?=
 =?utf-8?B?WUhQdmx3cmJZUmhMN1I4YklVSEsrQm0wKzV0QzFzck5ZMy9GV1h0SWRmSEZE?=
 =?utf-8?B?eXF6SUMram9WTWIwWnZ4eHQ0T1dBY1BsSlRjdGhDODN0VmJELzRKTjliaGlH?=
 =?utf-8?B?SzQ1Z2NiWTJuRzhNYllKNXFVZGZqdzdSNlRGOEhaSmNSRlRwRmNFSVZuV2lz?=
 =?utf-8?B?ZkJqTG5MK292bTJCWEl5YnZnSXl2UTRkVUswQjdiRTM5WWdqWHRXdTVaOE4w?=
 =?utf-8?B?K2ZteHJoVHhicXY1U1I3SVZ3VEp6cElCSEN5V2JHTDQ5MnAvbkVsK2N4L0pp?=
 =?utf-8?B?UTNHdlBMMld2cDhzSmh3VEVuWnF0OEo5L2NZRUowMjZvUFlJbDVhcy83TUR6?=
 =?utf-8?B?bGpicFNCR0N4UWhVSTFvNk9rajFCa0J0V2R2SWt3TzNORWthbW0vVmFncUJm?=
 =?utf-8?B?NGorSFV2aXJEYUpKZXNjMmFaVEpob0VMN2lEK1BYS1ZncFowUHRWRTJ1emFY?=
 =?utf-8?B?Mi83NmR5OFAyZDhIbjRmQTZVbkVKL1FNcUloTnNSbDhsUU5BanczOGNGRUUx?=
 =?utf-8?B?MGhnMjJFYldvZmJnbmcvN3FZNElMOVpqYkdGeUk2c3dVclIxOXRYeG1GMVBP?=
 =?utf-8?B?M08wQWJ0T3kvUHh0YXcwa2JDUEtEbzFmTjZ6MDNVZ3NyZ1k5THBab1B2ckVC?=
 =?utf-8?B?T2MyNXFrSXVDMzNYSmhzVTBlZjVyODhDSkZXSkQ0UFc0Y3B4NlZzT1gxYUVx?=
 =?utf-8?B?SGRDSXE0a1hRYVI3N1VkM084TWhMNHUzSThJYVdYRTkyRUY2NkkwQ0VPN3Q0?=
 =?utf-8?B?Y0Npdk1SQmxFWGpkNitYcDNmNHdKVnNSTUJsakprRHhJZ2lYK3ZmekdIb1dp?=
 =?utf-8?B?OWxGK1RYWWt6RytaeVA2VTYxdVdyT042bXNMQzRjYXQ0OHhvUEw3WGVPeWtq?=
 =?utf-8?B?L0YxdjhFZ1hWNGpCT1ArUW1IUlh4bEhPZExUcGhWN08ybmNsYzNNekpPZTZM?=
 =?utf-8?B?MU5NYnZCNGZCMEwvbVJYaXNwTnRzVittdXRGUGUyR09Cd2VkOXQ0MVBoT3Mw?=
 =?utf-8?B?WGdkWFNDcnd6N1A2NnpENVZsN1lUKzBWSFM2Y0s4Y0NtTGR2OXVTaVEzRWRp?=
 =?utf-8?B?b0lVQ3pKbFIxVmw4RnJ0UVhNbjFOai9YMlU0N01ucjN0TlFpcWcweE0wMlBz?=
 =?utf-8?B?Sk9QczVqRkZNYUVVRnZXZzl3VUJkS1JVbXlWTUxyQnBtTmhpSXJ3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af48315-265b-43f8-e6fd-08de79449e2f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:47:55.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCvQ0sSpzrWhe7vEFBVHENPhMaGcUqPXSYtDJt0milvNZspCi50CVjFZzfEuSckHwyvSc0toZtf+bwxoel7T5u0prdfYG94/d1l3kusCy9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12112
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

Hi Simon,

On 3/3/26 4:14 PM, Simon Glass wrote:
> Hi,
> 
> At present binman handles finding/building tools needed to build images.
> 
> There is no equivalent mechanism for the firmware blobs themselves.
> Users must manually obtain these and point binman at them.
> 
> This is quite painful at present. Each board requires some splunking,
> reading vendor documentation, etc.
> 
> I believe we could create a similar setup for blobs, where they are
> described in the image description (compatible string) and there is a
> way to build them, download them, etc.
> 
> What do people think?
> 

I don't like what we're doing for bintools already. We don't necessarily 
know what we're building (e.g. build_from_git() which only allows 
building a given branch's HEAD or the default branch's HEAD), we 
download stuff without enforcing checksum (e.g. 
fetch_from_drive()/fetch_from_url()) from places we don't control, and 
downloading from the distro's package manager is APT-centric (and racey, 
since apt-get update can be run from two Binman processes at a time and 
that is still racey to date, apt-get install can be made 
multiprocess-safe but is also racey in older versions of APT). At least, 
we can bypass all that if the bintool is already present on the system.

This already isn't giving me much trust in doing that for binaries that 
are going to be running on the target. This is us trying to come up with 
yet another build system, I'm not sure it is worth it. But I can see the 
UX improvement even though compiling for Rockchip is kinda muscle memory 
at this point to me so I don't see the high cost newcomers may experience.

There are build systems (Yocto) that deny network access outside of 
fetching source code. That is, binman won't be allowed to fetch anything 
from the network once the u-boot recipe is outside of the do_fetch task 
(fetching U-Boot source code). Therefore, it is an absolute must that 
the same binman nodes must be compiled with the blobs available in-tree 
vs building them with binman. We also must guarantee binary 
reproducibility, things that Yocto does right now (at least for 
OpenEmbedded-Core, which admittedly doesn't contain TF-A or OP-TEE OS) 
and Buildroot aims to do IIRC. Reproducibility isn't that easy to 
achieve and we would need tests to guarantee that (Yocto does as part of 
the CI). Then you have the question of multi-toolchain support or 
support for different flags in binary vs U-Boot itself. We very well 
could compile TF-A with clang but U-Boot with GCC for example.

We should be able to replace the binaries without getting a new version 
(commit hash) of U-Boot. E.g. there may be a CVE fixed in TF-A but we 
shouldn't have to wait for either TF-A or U-Boot to do a new release to 
get this fix in.

What exactly are you trying to prevent from happening or to improve? 
Should we somehow force documentation for boards to contain instructions 
on how to build/fetch those binaries and make that part of our CI insted 
of mocking the binaries? Note that this also will increase the time 
spent in CI, which is already quite long.

Cheers,
Quentin
