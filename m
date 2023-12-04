Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E01C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52D0876E0;
	Mon,  4 Dec 2023 08:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+iF280u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5543B8771E; Mon,  4 Dec 2023 08:54:57 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3964E876A3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu52cd95CKmx5XOXTqIxQntH18mokPXNidSdVlVav7GGKujnjXiIICH14iBLSVysAKBhTbRc/jWVWx3qaYBeyDTikH+WjP7jepiALV887vq89OsLvfHp8otT+q+mytJeM29GuLk8bgHw1HUYY7NoDv1qffqYYbEwog62Mdp4DfsIv8oJ05WVZrZiXaBxNFkiwby/L3O/t+AOy4sNGJK7XpYLRu4Fv5HjFcFzEvoy/b3usUAebUsOOkZKGJpeNCqPSxn/qZ87czFtXYLuGjQObpwtZ5Lnzqfm5QXIq5IEriNG+j/qLSqzxjt0/tSgDjCo9YTCLPo7GkkEBvMGSl3BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlxcYNE7u+dgDZjyHwD53NveW1ulTEI1vYLaPHTOfe8=;
 b=Z6buE5/7XuR7oD/DRwLeXnASIWXhQOZvhhTZR/wqbQR6r5d7JMMY+2fWTBv+8ZPCrU6FfzxtcQXPgdVyDzEc2XGCVVg0bW4MLNc5aV6nYu1iMgdgRWHkYrD9M+MefvEbCmVQzVDIxG4DYM+bK4rFJOo/J6i6hS+qn6DZVWxaBbHGYEb0T+nZ49AcILXJpT7RYiAL4eVMSShoHulJpCQh22WY/gzVsN+jcE5XpC/kfSkIy8qH5Q4oHOPQlAxjSmHuWMsSBRtP4kUXtb3z73PbCkHkWPvzwk9kqzlz1qUpA8Y1ADaDuUNlLSiVh40U8BeMGi5vPBtAd/LVRwc+vPigSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlxcYNE7u+dgDZjyHwD53NveW1ulTEI1vYLaPHTOfe8=;
 b=p+iF280u4MXdB/z4losp87tgPO0TkhEg9rLm7SQE2yK9LQtR7uZiCb1mmfHysB31n5SrnQJQAWanPSDPtqWWg0dclGFUlppqJmOeMiykqkShQtRkeB65TD3pv/K9wfxBqNL+e79i7eSvS1hiBJjVaSpEw0pcuVJQIckHA16PP/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 4 Dec
 2023 07:54:51 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 07:54:51 +0000
Message-ID: <6bf6f903-ca3a-42ff-aa62-be3098615dd3@amd.com>
Date: Mon, 4 Dec 2023 08:54:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-18-raymond.mao@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231127195029.90951-18-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::43) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9641e8b6-c6e4-4478-4c1b-08dbf49e4aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmqQxA4W5cAYoZwGxSExdagi7sHFQHyxcuVijHXUjd5oYbMilWvm5M5wYLeGMdAQTQ/OhCoTXZuw17ng0nahzbukWRSWHpW3j+lV2mjdWK5utjoPVTV/ECCFw8s+pl/yLzzL2W0UviWYmCmAnDmF09IMcXrXL2btwCLiTMd2M3gi0lYKizrCP++kKJoMYlicnXrNZeveKWma3i/a1vJ8Jke52IVKp+7/TZiOAzPQFkO2p3kfVQIVMe4zdUeGjOfppUdmWRWaWC1jwF4sa536AdRnFzmOjEEXZl6x1y64csQ3gaIqdnNiHa8MxoMP2pN9FZlXFwyGqgcr7+ywxxD188+SLYQxMuL+4HjSeIlgYU8lNJOgEjfzSuDnoQbZF6js79p+0uSMfuW/0+QLHm0rvtce8A6jo5XsNnfI0NF7l92Pvb3e1hFEkSHRVlXkKneopDoBIksPD6exygX1R63ieJm9R8SJmtQEjU3D93+hxrb4g6vvJIcGiB4muSXzKO0utyzXzkrGhK3GDKPmHzVoMPpVTiUYbdOQ+G3Ku+cZRfsQ4q3Vc6T4SkYQWrsSNVaaeCHYLw6DTc4lqu1YbHXtQ6pjgMifLvezGLI0UHmQXJv2Jc5G+9z1B4DqPN8v6qHrfXsEOBQhaePzUWJ5j92i/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8936002)(8676002)(6512007)(4326008)(6666004)(6506007)(478600001)(53546011)(66556008)(54906003)(66476007)(316002)(66946007)(6486002)(36756003)(86362001)(38100700002)(41300700001)(31686004)(31696002)(26005)(44832011)(2906002)(2616005)(5660300002)(83380400001)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9iOTBpd1dkQ28yaFV5M3JYL3E2Wjc5Q05XbEF5dG1TUVpiN20xbHpsUi9i?=
 =?utf-8?B?QzdGNy8wT2lPQ0FWNEo0UElmYVJQZ2hsWCtPR0pEVXJoTmlVU2xoSUU5cUhK?=
 =?utf-8?B?WUtkZWEwY3hMdFRidnlOclk4RWxkdGVicGJuOTdZakhDVzJmanFPSWErQkNI?=
 =?utf-8?B?V1F0cEtMWVVqbnl0RHFiR1JBT2tkbzgrOU95UmZsVjk4MmxESWN1R3JRbnlt?=
 =?utf-8?B?QkM5ZDNiMWxXSWlZRVpVemJTa2VoZ1FEWGlsZklQTVV4cVJhV2J6SDBWTnQ0?=
 =?utf-8?B?b3NxbG1VeVNHcXphSzlWK3pJcnBUdGRqdDVMazdSeGkxU2lkWEVScG9UY0th?=
 =?utf-8?B?OUYzcGlCK1haWWs1d1BkdnhVUmppYmFLSzV1bnphQk5hY2JJbzlHUHRaeDRj?=
 =?utf-8?B?aEhvUnE5d2ZPVGJxMVNNeGUxNkZzSTZQaFJaRHZXZXpDMW5xNmtqNjE5eVZ4?=
 =?utf-8?B?Q0JGZ3Y1NjZuUm1vQ1dYWkpBdnFFMEplUFk5VWF2M0hkSm5DT0dmU1ROMTU0?=
 =?utf-8?B?QUgwUFhSK1luVmpLVE9QbkVtdzcrU1JWbzJ2b2pvUHlMbFUyTm9qZUZtQVFl?=
 =?utf-8?B?T2MwYXM0SUozSHBOVlo5am1TY2FqZXl2YnplYmIxWVBXQ2UzS1N4TVgyTXBs?=
 =?utf-8?B?TkIzQVgzNnRHelhEWksrbzl1Q3RtUDhPYVl0d3NwY2ZtdTZZRGVUSVMvSGtj?=
 =?utf-8?B?MDl6azN0MWo5eW9pd0FVNGJheFlacmZXd0ZRMVFhZjE5VkdlL09sZjVPVjBi?=
 =?utf-8?B?clNmRWh0eE4wTTV6OWVtcjZGZURKSzVPN1hSVlNmN3BlRTVvL1FaRWlqVGd3?=
 =?utf-8?B?V01tT1crQ3BNNjg5NDhUL3BZMk81cHdmbHFJQkdEbFhUQjZ3V3ZWcHZCVURY?=
 =?utf-8?B?VUxXbmw1bjhHbmJxeFJYVkhoK2lvRmtyTUtKb1U5Zm5jN1g5RjF5WTYxUDUx?=
 =?utf-8?B?enBQU29MNnZlMEozdnpPNFNkWkc4WkdkaVJJbnIyNEZEeHRGaWVReEdwU3Iw?=
 =?utf-8?B?ZU9UNEcyazVhTXFyZHlBbnpBU24xWDdRSjNLRnAwdmlDS0UxTkxmb0VBaTZO?=
 =?utf-8?B?ZmRFSjN6YTc2Q09qZktMeXBrSGI0N3Fja0czR3ZBOS9QMXVPTXV1bnorRjZU?=
 =?utf-8?B?SHZHZFdiRjV5dlRDckJ6NE4vL3U4RkNKODNEWC9zeXBFRlpXbnhOb1FZNFc1?=
 =?utf-8?B?dXZIU2hBZDdyOTB1ekJSZ1R4QWoyaTlmcmp1Rk53MHp0aXJqOFJ2YUhwYk12?=
 =?utf-8?B?UDF5WEhudSs3Q0Q4VXNtUS9HM1FVeFU1OWhIT1lYMUkzTEU3LzdFZnU3eEV3?=
 =?utf-8?B?aUYwem51S0lQWFNQN3NOZlhqVG55cG9BcXpCYlFGazBUQ0UvaDVsbTlkL1FX?=
 =?utf-8?B?TkM2ZWVEeVNVdzZGUlVoRndoRmZid1YxaE51NUlndmU5ZzJRM2x0ZDQyUXY3?=
 =?utf-8?B?UG5BV3BheGc3QVJTU3N2ZUNBVUQ3QlVzeCtlRWp2QlFZQkt4ODNUdHAxWXRB?=
 =?utf-8?B?TWgrdXNGcWVQM0lRM3VaRGVrUm5YZHFYbytDREtTdWt4a09tL3dBdnhpaHkr?=
 =?utf-8?B?Tlc5ay85d2FkUldKVjN1ZDlSSVdzZTlGelRRWmpObEtLdjdkb25EU3dYcC9Q?=
 =?utf-8?B?NFRUb28vVHcvZndGNmU3OHRLc08vbjZOU05lbnZUeWtyUU5BbGdXOWY3WDNp?=
 =?utf-8?B?R09rQk1ISXg2KzkraXpkVlRtSHVTTmRONVJ5SEpPanMwNjh6dldJT0Y5TUlB?=
 =?utf-8?B?UkNjcGJxRlF1K1pGRVBNekZoTnk2RGl0d3BYTnhrU29teS93NnAvbktDQ291?=
 =?utf-8?B?T0RTb05TU24yNjU5ekQvQnRzVXMyREpBVlJOWU4ydTM3UzN4TE9mT2hoNnJL?=
 =?utf-8?B?b01RWGx3TXV5YUZndnVRaU0rUmJmdnhWNStZaGxnTDl1SHB0aEN1cFhaQzNB?=
 =?utf-8?B?YmhMNE1WVWVudjM5S2VkMVlsRVZMbm9zdUlIOUYzaGFGRUdMdXIrZWpTS0RN?=
 =?utf-8?B?RHRhU2cxZy93cHExRzFrZGppMEVqcThRNGMzSlorMXZ0aFVTck9DRmN5dzMr?=
 =?utf-8?B?REp0Q1VHVU1tbmVkZG85bElQK1JHTUtOTGllazEwWGNHRWFzaCtHOHJyMmRu?=
 =?utf-8?Q?fAos1vBSpVsBKL46wK3ydeYqa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9641e8b6-c6e4-4478-4c1b-08dbf49e4aa8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 07:54:50.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61LQalGbs9Sk1F83hYHHnDU7gHGT1dp3iL5KHOBgc75qCdAM1GAif052JIC+tDh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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



On 11/27/23 20:50, Raymond Mao wrote:
> Add platform custom function to get bloblist from boot arguments.
> Check whether boot arguments aligns with the register conventions
> defined in FW Handoff spec v0.9.
> Add bloblist related options into qemu default config.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> 
>   board/emulation/qemu-arm/Makefile        |  1 +
>   board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
>   board/emulation/qemu-arm/qemu-arm.c      | 54 ++++++++++++++++++++++++
>   configs/qemu_arm64_defconfig             |  3 ++
>   configs/qemu_arm_defconfig               |  3 ++
>   5 files changed, 80 insertions(+)
>   create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
> 
> diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
> index a22d1237ff..12821e7083 100644
> --- a/board/emulation/qemu-arm/Makefile
> +++ b/board/emulation/qemu-arm/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
>   obj-y	+= qemu-arm.o
> +obj-$(CONFIG_OF_BOARD)	+= lowlevel_init.o
> diff --git a/board/emulation/qemu-arm/lowlevel_init.S b/board/emulation/qemu-arm/lowlevel_init.S
> new file mode 100644
> index 0000000000..d72d7c938a
> --- /dev/null
> +++ b/board/emulation/qemu-arm/lowlevel_init.S
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <config.h>
> +
> +.global save_boot_params
> +save_boot_params:
> +#ifdef CONFIG_ARM64
> +	adr x9, qemu_saved_args

Based on logic below this is available only when CONFIG_OF_BOARD is enabled.
Please look below.

> +	stp x0, x1, [x9]
> +	/* Increment the address by 16 bytes for the next pair of values */
> +	stp x2, x3, [x9, #16]
> +#else
> +	ldr r12, =qemu_saved_args
> +	stm r12, {r0, r1, r2, r3}
> +#endif
> +	b	save_boot_params_ret
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> index 942f1fff57..a3892630d8 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -4,6 +4,9 @@
>    */
>   
>   #include <common.h>
> +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
> +#include <bloblist.h>
> +#endif

you have dependency on OF_BOARD and BLOBLIST.

>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <efi.h>
> @@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
>   struct mm_region *mem_map = qemu_arm64_mem_map;
>   #endif
>   
> +#if IS_ENABLED(CONFIG_OF_BOARD)

And here OF_BOARD.

Not all should be aligned but I don't think current #if


Thanks,
Michal
