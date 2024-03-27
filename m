Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5907DC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 08:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C054B88044;
	Wed, 27 Mar 2024 09:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="QK2yXgos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C955D8805B; Wed, 27 Mar 2024 09:56:21 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1288573F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEZrQ1DhaOGe2nBpaKd50FtAbc5tWE4KtzOTMZB1mtldlhZ3beRjSRinPZhr4xFKL2GfW4NM7rZTEP/0oven6En9wFAU09TWh4ZzYqmuOQwYAxZkL9Rot1/uP7peUYzIxGppED09agOiiRrBSWSRRRkqp7Fcca/STMCBdPEA4+dcwiJq+hEhSBBtMU7nZDPD9ZGtsvwr3iU5qgkR+XVoPGN97Bcs4+TP6uMIdsfrmanABAcCLDGsyDhj4NnitOVk4BwTwtV/CkFiwZHghgYyOQYHwoerTlS492VV71LhjxZhxZDS1EL4SP4+aRa7fUGt1dzNV40BpALyao8oJYHd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y+nn3W5uHMIvqOu/OVfBl3x6gx6rLlFnjf4Gtpxwno=;
 b=cMxpWqkwqo4/9GFes3uz5Sj2GrJ61t6M/Mc8wEWCA93xJsBsKfD1RpDgAXgGGQZHsK9XZ8WdWYigv4lMP7N6lFaTIQaAf8+By8ZmJpnipxG6znQRFKfsd6W56CYJ/+B3/A5vBssVN1VLTO8T7QsXrM1iUOZngjBA+f1JOYPehoHfv3fSoS4W1d2eMIjTF3jVXpHIcMUyQSGX5lKc9qvQy4m3c9BPhfntlvTP9AtN+ke6YWEId/CUeppSEwbaQSDYNxW3yGHl8pnXN+PKoZ0CZF0inyeWrFIRN+AoEPRkZa7/M8uPdjq+IjqXbWkqvRzsdIApV0+68T5yEQOngzjpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y+nn3W5uHMIvqOu/OVfBl3x6gx6rLlFnjf4Gtpxwno=;
 b=QK2yXgos1WbqIy7e3rSKgZEtcHtvvoqbgT5JzxEk3kCHFniuWQIW4OwFkZFFva+Uy9oi5d/Le4KdiyIZUAauVyev9//gN1dKTl/8vHahHPwV18n//FVogCnLvNkudU37+FbSDtjy2ts70uqIowkuDkTjfnEyqhoBU79fxLv6xMBgttyxuNEWGMKOWi0YJ+1c/oUs7QqkJ+qnsXOCxAk+dDj2psyWvnOhJNJRTzoT2OLyZBDuPQwuMoa/OaOKXruzcGmLM9NiGMoxt7qKeCNq7s+p5CnkJjgdodzQlEzLs5RMamOcRkWKPo4PRblDpEswuyKdynsHV1IIdUxMx/UzxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Wed, 27 Mar
 2024 08:56:17 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:56:16 +0000
Message-ID: <a162464f-8cf6-4229-9062-f1369769af20@theobroma-systems.com>
Date: Wed, 27 Mar 2024 09:56:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Revert 4 blocks PIO mode read limit
 for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240326233502.2625015-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240326233502.2625015-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a64e07-d0c2-490a-30ff-08dc4e3bc359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOJo/pBFKMmboE5yIka00NrCjATZB56ngebbeCxpL2QDxZ1ggb8SN9skXzjgPe+r4V3QhhvHN6I2EanCYuebhFVQ4bp/Y1994KinMrVnmt8g3uNAnQM6igRDEYgRUwlQiu0DanAmktgV09b+d753ENC5tZ/FM8mJvqS8iatDYtamYQBbCkUhDC8CsRC79/EKmbpg3+vbG/KtVDjxo8wlhpTKI4Ar29WJ0b3kGI22WVcJ4pBUJojyCE/vwVTaa1Xjpcy/jmNjJKQNeMYQAyMJjWA/DD0rpS1mI58VjPghbPKUkLKFOvansE3hRPqwVGobfUMRN0i9SVK0zhs921+ZSZ/O3Jwfs0EzMYhPClsEn+9FNtCZ4RSXvw/pKFWzTb2pqn260G2Fx//Cppiy8ypp18kt1NHUIPN0DqqO1ugHAsBLhURr6aQQgAqZcgnI2HMrTew1cPwPLMtdznwBpZYM1VowE/Iketx0WYsDWyVhywWAIbnge+YHYXfEWmbPxrTjAhZotqd8Rg1LMOTeG/EODoKXIpBHdTnGUQmkQpUZg0RYRAbKng4bvqJvhXPfp0ppqEhUFLV4+FFNji1H3TefWIUgWRTrNDWR4p3YnmLehaouCeRQv1b1NfX07eetHQLqhZBbNACzVM1U6XhffSLDG6FdSHozw563C3yiAKwTtbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNLTFRQYXFLOC9nbWNhMTZDRytnZUxOb3FzMnFKUlNLdUx2bzZ6S1l0YjVU?=
 =?utf-8?B?ZWQxWFpzYTZyeHkzV2taT2F4Yk9veHd2VmhUR3dNMjhDOUJFc0I1NldtMFp3?=
 =?utf-8?B?cDVRTk1McXdYaVhlV0NGOFRPNXkrWWRTekdTWDVCMGNha24xS2ZVa1VCQ3pG?=
 =?utf-8?B?Y042NTJablFjVTV0ODNTREt1bWFicmhKWXpTUStVSzBBZkhsajdERnZSTmJS?=
 =?utf-8?B?M1FkSTJWVlF3THAzYVZHQTV1NWkwcDdSOUNGR2NZTmVoeWxGalRWMkE2ZWJp?=
 =?utf-8?B?RWNzSDVnbWc4VklhVHVTaXNmNXhGcFR3S1hJK2tpZ0s2WHR6N3RGNjQ0Y3JD?=
 =?utf-8?B?UXgzVEM3TzZ0c05hUjh5YkU2SS9sLzMraFpXTlN5a0FSaS95M0RhTmwrNWdh?=
 =?utf-8?B?VjhDdzlxZ09USHF6UzFlM0ZWZGExbXppNXZQZ1JLYjNkblVjQWlwM3RQQVJq?=
 =?utf-8?B?dFlZUzhEQlJzY25kVmpjUEVmek14UmZqVEZiVmY1YmVRVG9vSzlvSy93bWth?=
 =?utf-8?B?eVVFY3VyQjZGRGNSTW4wZm4rTlBoWklsQytKV090LzNIQUFNWnBzRmt6NkFD?=
 =?utf-8?B?ZlJiYWttQUYxUEd1cEJRUjdYN2oveUxHWUZSNXR5aXNPQ2JibFEzZnVkRHp4?=
 =?utf-8?B?S2oyUEc0aHk1eWhSVDFzd2lXNEpxOUdIT1RXdXVNLzFxRDNsNzJFRUNpQ2Vs?=
 =?utf-8?B?cDFqQmZWcHdHOW8wNnNwd1htamVCZGJCT2dSRUlnc0RxaTFGTCtBSk1aY2d6?=
 =?utf-8?B?UmtZcWhNNmt2VVphVjNQMDVZUEhZTmQxeVZ0MVZDYmdZMzFEdWZicmhCbVRO?=
 =?utf-8?B?L3NySWVDb29SWWxlVjBiRjR2RHlwTjFQbHVCYWxBKzI3bXRpaEovOGx0YURS?=
 =?utf-8?B?MStpUmVObUFhc1RRWmVmL0RYTlB3Y25aZnRucUxKMzF5MEVHVEhLU2RYTkcy?=
 =?utf-8?B?ZWJvLytNRmFUbDJJcThmemZZYVlKRmhwSzBnVGIzRmNSUXdsZGdubWpKU0Zq?=
 =?utf-8?B?UWZ1WTFudjd1Z0FTMTVoUGh0N2lTNWNIMStqMFkwcnM4VTBJam1IRnBDbjZz?=
 =?utf-8?B?MkhKRG1nWXJ6enM3SDVPOEplbUNMejd1QTMwaDE2c1FjVndzajQ0Wm5vOWhR?=
 =?utf-8?B?NHErR0NCRUxDRTVwc0xKNUVHVmwwMXE4Z0ozRW95dkJOZGNSS016dE45aW9q?=
 =?utf-8?B?QjFYSFFLeGtHSk1tZktKdkdnNTBUaGhpWUZBek90a0xWSDNBdnJkanRuSG9n?=
 =?utf-8?B?N3RIdmdzNWlsNk9zVVhmU1RjWEx4emJnM3ZWeWE0ZHFlYjVwaVRVS3h5R0lj?=
 =?utf-8?B?ZXp5MzUwK1FYaEJXZGR1Q3JaTnd0QmM1RFhKa1A4akl1U0c1OUhVa1hSOExn?=
 =?utf-8?B?S2N6aXMyYTN0bWtlbFd2aExDMFdsSi9PLzBNSkUwdWdVMDJnVnJ0RHZwb0Va?=
 =?utf-8?B?eGdoM0JXOXBXYmtWWHRLZTdTT01lSDlZdFNXRVc4OC9FcmFKSmJtT2ZCSEVa?=
 =?utf-8?B?Vyt2REsxYkY1MHd2WitQa0l5VTdmTjRpa20rRWxtSHZHSDZrWTcrdlAxRUlu?=
 =?utf-8?B?SmJrdFVMU0RXdzNGN0VHUFdDbXA1QkdrTW9hUFpzVENTUThwS09LT0laYXkx?=
 =?utf-8?B?Vkx2cWZySGs5dUl0YzAzTDV0a3piMVpackpwTUxtYy84ZkVrdjdxTGNBazBi?=
 =?utf-8?B?TG4xOXVtNUJGYzlVaTFrODVSdGU0T1NqOElscXVrMkV6dmtPUHRKaE9NcURr?=
 =?utf-8?B?aXg0UmR3NTJNaVJ6aHhLU2hTR3hjdUo4WjlHY0RkSy9YVjlBWVFEOUdqUmVp?=
 =?utf-8?B?Slh2RGljb284Z0Q2cWx5cTZEOHJDWkc1OFcrR1pxVEZxVXloWkVmTmJwbTBh?=
 =?utf-8?B?S0pnRnpFUGM5Q3N4K3d4YmpMbTdaOXRsZGxNTnNhWk1ueW1tdUw0aTk2cjlz?=
 =?utf-8?B?cDJkZGJCbU1sQmVUenFPVVdFa09aQUVkdDZ6UXZBVHhmYVp5T1FTTFdMTHJS?=
 =?utf-8?B?ZXZ5TlpjemVvNmtUaGhjT3pFZ0Y5eEdMellYaXp5OW1GejVnREl6WTZIM2pK?=
 =?utf-8?B?VXBCM0M2cXZsZm8zQmp6SUo5MDV1N1RueUdyVmpKbm1ubjVMVTNNa1JZaTlt?=
 =?utf-8?B?T3BMaEdMTHkvTDN1clNGbDZhZi9IS3RSV28rTHFTL0hzOExBOVI1dzNOVHNi?=
 =?utf-8?B?QmRxcVFBNFFPZzZmZFJ3VnFjOWNGOHZ0bXhzSUVoYnZQU2VtMmZvUzBXZFJ1?=
 =?utf-8?B?S0dvZExvQmVQdnE3TW1hZjNLOUxBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a64e07-d0c2-490a-30ff-08dc4e3bc359
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:56:16.8723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiaAOCA0ffqtQOqB7UXT4/VfcqvrKLg6LyegyYoVUQccoBm2Nsnx0V+SdVty6p/naeJqbVO4ikzSqEpi1EKAV5jl9IWEOrr1/RYfk3L0uwrl0gT7jKCT1cxsIPZgHcFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
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

Hi Jonas,

On 3/27/24 00:35, Jonas Karlman wrote:
> The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
> read in a single command") introduced a limit of number of blocks to
> read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
> affect of significant slowing down reading FIT from eMMC.
> 
> After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 mode
> by default") the limit of number of blocks to read workaround is no
> longer necessary and a Data End Bit Error is no longer happening using
> PIO mode.
> 
> Revert this limitation to allow reading more than 4 blocks with a single
> CMD18 command in PIO mode and speed up reading FIT from eMMC.
> 

Should we instead keep this code but surround it with
#if !IS_ENABLED(MMC_HS200_SUPPORT)
?

After all, HS200 is only implied for RK35xx boards, so one could disable it.

Also wondering whether we should do this dynamically based on the MMC 
mode that could be negotiated with the chip? E.g. I think it's not 
guaranteed that with hs200 support built and enabled in DT that it'll be 
negotiated as HS200?

Cheers,
Quentin
