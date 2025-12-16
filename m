Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55464D5CCB7
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 10:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69D8394E;
	Tue, 16 Dec 2025 11:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KOtDQLW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71F983956; Tue, 16 Dec 2025 11:11:03 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F8A8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 11:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKEzVUul+wtMXKuJnP0N946nKEhkVMWZV4vhsUr+Dh0RvEj2+q+PAW/kmrxtFXM9DHG51nqweF0wcU6ioncvrlc7WbSOkAFzBW1FvXI0hrjYg0KqvfnLi9wgeast5/ZBNzG2QdcT9Qxa/mhAHXwIGC0SddVqpHiu1FLxzGudV6gd4xI703Hn7Dk3bWUgQK0bGJKGQGi2jo97I6GNx6vI0e8qPvTAnjtGsKnvs5a2cdYL53d6AUyvf+qOyhKs7ixrrDvmPbwlVvb4E9Cb0v3ZphTmUwYtwAVP1TKyMwW4qf1IHtvhJZzAaq9MxHrBQXPh80Js0EeXk+Vcs8SAG4+gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPE4+kSyl8YMYr1SNo4T3Lv6BbXtBVazVz5AKWQYoFw=;
 b=AI4uhT6W+eDaLBeugyDE7brqYavWThgvmulLCo2iVFC37F6M6ePzhxnRoYHrLWiw56rBkVShitZjB9LihwH0TlmF3kDejTv0D9k8kyG5ROrOtrhY0baGbbDFHrG4y/6mRQ9vrH1jjED4atxBRGDyzzHw0VZFp2hzNqFsDC5MRsYl+RIdcRAXO69Cr090THiQN42iKUvS14WpUeDaLgC7gO3VRMO21/rGP75OQJM7rmOgKL00zcfd1ECw9iM6c4rTun7YF1On5XMddyrE9e59lVuYRR4ut05JBpowB1kDV4rFYxRcT83Y4FH1gi2XD2oHm/QKJBc4zhKyyg3YHWn01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPE4+kSyl8YMYr1SNo4T3Lv6BbXtBVazVz5AKWQYoFw=;
 b=KOtDQLW89bMiaxvCSQyHoGeLTvndls2nmeCBR32w4ogvuI7HYIvCH2gu2dB52XPQqmSUI6sN+ozBuLDXQx5D30djBk20u5HDgMF/zxOuPFfRsGQsAWm3sB8WdbH5Omv8ywp4EEl5RxUUMVH+XA3VmSPAmEZsJ/zRC5W7Ic7tF4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:10:58 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 10:10:58 +0000
Message-ID: <9a87c145-ff0f-4f44-9dee-20af2f843b2b@cherry.de>
Date: Tue, 16 Dec 2025 11:10:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: elf: Fix typo
To: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
References: <20251216093513.424736-1-daniel@thingy.jp>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251216093513.424736-1-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5feb6dee-1b30-4156-22cf-08de3c8b682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVlzVVU1aU1TUVZaYVZSa2NmOEJua0kvRlpNaXNpeWFjbmY5NVVsU1g0ZEhr?=
 =?utf-8?B?L0I4NVQxNWNjVURKNSt2SG9nM3ZIQ2lwVEtXcW1RNi9rc0J5WnA2bVoycGVj?=
 =?utf-8?B?QWorYldmRVlUVGwrRTNxNHdLTjZsdk0yZXZKSmhsUThZSVZNRy9RTUFPU3hs?=
 =?utf-8?B?Y2JxZGl6VHNKc2xHTGg4VUZBUW8vU0dONWJ3Zm1Tbml0alRYWldmaDhjdHd6?=
 =?utf-8?B?bzQ3d2tYME5ya0g1SGtjWmVFZ3NEY004ZHA2SUdNdWdGVUw1SG15eEM3MTJu?=
 =?utf-8?B?TTFERmxpdE9zeStxWExJUTNWK1dOR0o2eGZkdjEraDlTL1p1cE1jRGY4QmFQ?=
 =?utf-8?B?djFjb2cvMlpqWlErcXE2dGlDM0FMNTJzRHEzS2FNREt2c29GTXFxK2xaYmhH?=
 =?utf-8?B?L3ZqYkU1ZHhvd2V0THZpeEd4MndlVEwvYXFlckwvUVVlZnZwMTJyQ05xWCtG?=
 =?utf-8?B?YWJObk9rRFpyaCtvc0JRT1NqdUYzT2Zwa3IxbTU3WDU4dlJwLzNJOHBFZDdj?=
 =?utf-8?B?bzNoYW42enFrVHlPWnlYZnpWRFJTSmtTVFhvejlrclBpek1NczMyaXJnNkdI?=
 =?utf-8?B?dmU1T3ZLR2ZRNWgvckVJK1Z2MWlxKytoa1lkUDNYOHJHOUMyR01hSkVNNWZl?=
 =?utf-8?B?NWU3WkJyR2Z2NGVNVFBRai9lanQ0dUk5QTJZSDhrUk1IMDZITk9Gcy9qem5O?=
 =?utf-8?B?Z3lMV2dyazF5VHdEd2hSV09pRGo5OFJEM0pWa09GZWR2TjFyS1pUUFZsMk95?=
 =?utf-8?B?QVh6RTJMemZUVnNNSWpFWVhkdXFhd1o5WElGT1FQbnVmNlVsUmFlZEJSSWFl?=
 =?utf-8?B?R3lweG11YVgrdktJUjdtaEhrUjh4Z0RHY053c2dTelBJN21rNlRvd2Q2MXR3?=
 =?utf-8?B?L2hxOFZVMlltL2pDenBrTUROQU5jRCtwVll1c3lqKy9QNENJQ0FoTVZhdVcv?=
 =?utf-8?B?VFV5MUhMbmpUQUljUFVmV2ZNT3MwbjlsUGY4cmxIa0d6ZjZlZVk1cEhuaDNE?=
 =?utf-8?B?Z0FsZ01vdDBmOVYrcWZWb0lSajBOSWVIaHRXVXcvUHplWEYrOU5uSkpUbld4?=
 =?utf-8?B?NTRHRkI4T1ozUXpvTWx3TVJkb01jY0dieSttWXVrczhoNWdYTWpEV1NPd0F1?=
 =?utf-8?B?bzh3aENSUm9ETElFYUtncHFEZHRESDhHcm40RkRSd2xYMDRRZVBBdUZtZVd4?=
 =?utf-8?B?VlYrMjN4UjNMYk5vQmpBdlVVR0V2ZC9sbkxvanRYa3Q5U28yTE9rZjhab1g5?=
 =?utf-8?B?bTY0K1RacFpFd05CNHcyOHV5RnZpL2dGVXNzdThXeEFja1FEdmhSOGlPaDVS?=
 =?utf-8?B?OFNadDJmdG1RcnArZWYxMXAzcU00TXltbnZLemRXeDlOMTNzdlFja2FPRFRX?=
 =?utf-8?B?c0lDRDRJRmhqdjBsZXZaMEVJT1o4SVEwYUIxVjAycWpIZkg4Mmh4UVp0aE1V?=
 =?utf-8?B?VWxYNzc5c1VVcWFhTXNVemdFM1B2S3E5cm4xNkFscFJJTTdMN2YvcGllWlNH?=
 =?utf-8?B?ZDE0aFljdllqQzVWeXQySUhOcmJIcklzc1VHRnNGY1U1bTEwOFo2VXczblhv?=
 =?utf-8?B?d1lJN3hmTG8xdjV5SUgrTkp3bWpYcDdQYTA3Mmp4WkVWYjd2YUhBbWdhd2Ny?=
 =?utf-8?B?RWxLYktRZDV3c3NXSmJIZ0YzRDNCR2hSVnM1WFVqaDRLVVZ0MnEybXoyTFRI?=
 =?utf-8?B?cEgwR3ZxcFZyYllheDMvMzdoM1hFdUgvd0U0bWU3TDdTV0w5V3lYUVFKMDZ3?=
 =?utf-8?B?ZDMvcy9EYmxGMmZsV3JBVjVOZ1Ira3lIZkNleGpZTFFBWEtUQ1JmYUNXOTc3?=
 =?utf-8?B?QUp5MmwrWjhzM3VyZ0J5SzZoS2FpMk5Za3pkQ1k1b2hJbzZRTDR3eVFlSTQ2?=
 =?utf-8?B?Tml2NEtTemZxclNKQmJpT01XK1hBc3h6YXZ1YWx4N2pUaHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHd6WUdQMWFHYWt6WDZKSmNpU2JuejJoMFJodHFnQnc1cVhpVDRTODNTSjAv?=
 =?utf-8?B?Y0FXTVZKM2ozY3VLVEo0dS92MEZCM1BOblZUb25QVGNEa2Q1cy9Zem5DNWtP?=
 =?utf-8?B?V24yRFlQK1E3MXR3dDl0RjRrQUhVbHlVajRQbmlCczJlSzIzZXpiRm5yeVJj?=
 =?utf-8?B?bU9TbjNQSE5uVzFoY2RFUlQ1OTN5aTNlTDA1YnNrUEhwaXRxeWRpRlQwS0NP?=
 =?utf-8?B?ek1FWjRPK0FiaEYyQ1FSL0NSRUIrcDZ1bktROUdOTndzVHl0anhpWWlScURz?=
 =?utf-8?B?N0dCWDF0LzJEaThUVkVyN21VclBQa3BKZWNlcmczL1dmVC80RjFhL3hBY2RG?=
 =?utf-8?B?dUpsUzYwcG5nNTRqdjBmcHJiUVFIU2tWR0tEQWxVLzlQM3orNG45MzQ1eFZD?=
 =?utf-8?B?SDFQUFlPSXZKRjRxdWE0UVJRM1VSelVhVzRjYU9jbkh2YmpwWGFQbFNtTnNv?=
 =?utf-8?B?VG9PK2pTNzJDVENOOFkvSE1xekhQenlVMmx6bm15aWRtSTFqYmkyd25RZzQ2?=
 =?utf-8?B?WUVDdkhjOFcycWI3Q0dsbUJPK2kyWWNib0ZxT2JpT2xoR0dxcEJHSWFlb2Qr?=
 =?utf-8?B?T1RNV3FDTDVmdVJRa1hMazZ6YTJYR3ZmYXZxelZSaExMaDh0Z3Fva0xrWUMy?=
 =?utf-8?B?eVJoUFBrTTZvZWRyZWk3MGRvb3hrK2hPa0tSeWZoelNESjE2U0kxTE5JTU5X?=
 =?utf-8?B?SUVyWmNIS1hFeDZqQ3BOUGpKWjBXTU1rRUo3ZGZFYWRPTVBaei8xWU1UcTZE?=
 =?utf-8?B?WElkd1ZIUnB6dU1PRXRqbXR0aFBZNkF6aUdQdThUK0FSOHlvQy81ZmVzOHdF?=
 =?utf-8?B?WWErd3g5b2xaTW1MV2lZTFd1dllqZEdBRmtqVld3aVVFTGJTRWVCTWhrdDhl?=
 =?utf-8?B?RWVDMnQ1VnNUQ3d4WGVQMWM1MlFhTVVTcFU1RGFzUFJKK3kweGU4OVVpdFg5?=
 =?utf-8?B?Uk43Z1BMeU8xK2RUeEEvRDhvVnJXRTA0emFUdnBITjdyUUFzam9kd2tDNE5l?=
 =?utf-8?B?TlpDSzFEWVdJbTFOM0htODN2WEJja1djVVR1dkRndjZ6Y3l6aS9PK3EwTmQ0?=
 =?utf-8?B?ZzJoTEgzTkhTbUZNQjYrWHdZS3JtUDNwZlUyOGlrMG0va1E0U2h3dlphbGVq?=
 =?utf-8?B?UjQzbHBpWURCYldFZzczUENBd0ppMHlTMjBCQzBnSFZJRXJ0czBIQmtXQjk1?=
 =?utf-8?B?NDNoVkJ1VWRTYldOVCtqK2xBWEw3ZkliaWVJT3N5Uy9SL1d5MFZWL2M4VzFH?=
 =?utf-8?B?dWFmc2VLVnlvYlRYV2szSFAwWUtQSUEvNGprMnBuT295WFgzQUE3b3BSTVNO?=
 =?utf-8?B?QmlqM0VWM2pMenJxaXd1NmNvWDRhcTZOMzRrUWo3cnhwVWthWnJlbkplZVVE?=
 =?utf-8?B?MEZZMG5PNUEvSk5nODVXQk5OVGJka2d0cVVqUnVZL2JqNGxEMU5JY01Sb1Jl?=
 =?utf-8?B?Y0VpK3pSRHhrOWtOTERaL2JuTGlHcjRsOVBBUEQrek1xQno2OU5WOWxKU1Jz?=
 =?utf-8?B?ZDZpR1ZpeHo5NlorU1NUL0tFb0JhTDNDS1VqTW1oVDR2N3FXZEhkRjJKSjFR?=
 =?utf-8?B?Y2taRVdJVklQSElVQWhnMElvSVRFeG5KazRrS2RyS2t2VnVvb2RCd0RseGhz?=
 =?utf-8?B?TVhyMzMrVk5raDQybUlwYW8zN1VkRmovQ1ZKVGxqdkh2dWVRa2lSS3J4bTJn?=
 =?utf-8?B?b29sblNpRmtMckNXdnp5endBeEJCTmUxSEN4N1dwVVBTWW5PdlgybndjTHp1?=
 =?utf-8?B?d2RPWFhDUjh2ZkRyVzZiYmg5YmduV29tdGpzc0J4MFI5M1llWkNrNUxKeEMw?=
 =?utf-8?B?K1h3Q21CTFVEZ2p1WTBYQzY1NFdYekFuUEdIKzhpei9jSmszazMweHRNbFM4?=
 =?utf-8?B?ZTBBL3FVZmhOWFlMSTJ4SHE3cHV6WGY3TDBydzR3LzBjZGorN1FOMzB6ZExw?=
 =?utf-8?B?bHRMZGtqeG9DMm1sdVVLSFpkSmdkenQ0Y2FyVFl1MStZN3FtazBRWHJ5RDBO?=
 =?utf-8?B?T2crMVBSeTg4V3RPODk4alVXUHdDRmxLNFNNYVRlcjQwdmdNZHh1K0I2Ulgw?=
 =?utf-8?B?UG5lamIybkFLV0tvaXZnTjhCekVrd25ZNUMyOTdKRWE4YzQ0T3VuN2Q4bXZU?=
 =?utf-8?B?T2hhaTZKbUpPRGUwekh3dGRNSS9IaXdRbGcwVGprUi9WY0h1TS9wbGZnYVNy?=
 =?utf-8?Q?3cc4WxUQ9QXBtC3B8/ckVnI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feb6dee-1b30-4156-22cf-08de3c8b682a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 10:10:58.0388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYoGhefI7DNC99sqxwzq9vaIA2mImjckKf7k2qaRRRZ+Vgin0fyLGU/7fK+6tqXCoDOgylXpbZpmSnvdVqb7QkWE5vBLjapNLdra/S963Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706
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

Hi Daniel,

On 12/16/25 10:35 AM, Daniel Palmer wrote:
> [You don't often get email from daniel@thingy.jp. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> I guess someone had EFI on the mind when writing the comment
> and wrote EFI instead of ELF.
> 

Looking at the code, I believe it should be "EI" instead?

https://elixir.bootlin.com/u-boot/v2025.10/source/lib/elf.c#L201

Also please add the following trailer to your commit:

Fixes: 839c4e9c5bb0 ("elf: Add a very simple ELF64 loader")

which should automatically Cc the author of the patch, here Bin Meng 
(added manually in Cc) who could tell us what it should actually be.

Cheers,
Quentin
