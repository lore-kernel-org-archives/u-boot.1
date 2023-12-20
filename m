Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13326C46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C813871CC;
	Wed, 20 Dec 2023 12:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJ2I5b5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0323187509; Wed, 20 Dec 2023 12:03:43 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49828701C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvTY6gFd1ueKiRfZ9NBt2ONqgInbKw0Ehj1aKwSi9bau6gAQjun4gn6smz5Avw8iajwnVJ3ioL6UwAvjDN3vEOpoFoPinxWddlQs+6VycmvjLN3IOrGufEsF61EAVbUwi0MzXTOTXZBWZVqtw/nN6I9D3E0IH0E6RsEVCbk/HDrQHZvLznqUh93BOVGKPQD8dMZ6XR6COCUmx8Z32k72oW1iQugwR3LAqBu+WsCqu1AtEnSN4cE/e3rXOAfrerFcUGGLFy+LmUfNTa/9mya7bjiXoMgBKcAMMPUuc5LyVk9d6vzXXxN0wpbqq89rmemUpUco9e/Vexc9KCx39inkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMWYaK+M94n8u4Hh3x8EoBwOquUnz/sxxYgZBETPzGw=;
 b=VA6fdvBrWMaS6M1VFl4pzMYsrbbgUsa6JHpIQCFCumdSBHfffE13Bod4KWXRC7uEKeW+xZ4BLmg8Zwa9P0Nh0uJHjpOmf+tMuL+0acaP8richB58k/eITi39+pR27T+RSFCxN2mXmd4Ymvf4Fdj9wm7PHQ3Blev6zyLLigtvl16nD2uVX6rCvkov3ybwfMsISNxEdVXZZoEybURSlY6Mav5DKgTwUC9b+VaCk949swdc4VSjvNBBjw/U7Ky3i49Hb/c0AzC66m5P3uFU9RbTMjRLqEILJg9FhX6sZji8xpUmBlkXyq3ZOX9VSxzVUZ+4dPYBTjyNDQoFXtGEpDYJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMWYaK+M94n8u4Hh3x8EoBwOquUnz/sxxYgZBETPzGw=;
 b=WJ2I5b5HAaY96xf/bYAq7elZMWFayO3aZ5jCS20kMwUVYe2y8fB4mTW/bvHfTNiZu8Izo+ehyifkZ1OpExxxb/9kAnN9Df1JBEaMfLVly/Z95+KdgSucEqPYmaKL6fsHl4SGps2E0eZD5GBmPMmtevKbrDxte0EPZH7FBufTSJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 11:03:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 11:03:37 +0000
Message-ID: <5fc01bbe-01ac-43fc-b7a9-03ff149b6014@amd.com>
Date: Wed, 20 Dec 2023 12:03:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] qemu-arm: Get bloblist from boot arguments
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain
 <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Sean Anderson <seanga2@gmail.com>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-3-raymond.mao@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231219211114.393193-3-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 630f089e-51a4-494a-488f-08dc014b50af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ/sGYHPRjF1bHkhAd1JWabPHwZRo7dIQSdIaU4cqtcSWLXYt0WmGZzMvWLTkG/w/NLUEb1G9ewFW+w+WUVsHEoZgNgcXn5zHxkgOqeIDgUK09ZXtUkWBLKtIqiLolXdsNh3ZOGEAToTGThPx4/tyqbFxQsS1Qqm1hJVBjv1fMaDCdgj2qOiVRyYPj1iAx3DPnGQCo/7sa+Le4D1Uoz3Os3Yk98+eZhK6nRqU1sY0914csL+HyOzzMyEy7Ut/QCZrujYMVUZJmZM3MMrXlvmDJ9QOC9tAgEZr1YfrhrxY1QrdOAr/JF+B7gddP88CfPWSdhYcCZBTgBjfd/MxJ7xClER2EIOozhMraezNy9RPfRFMEbWbUYqxdY3c2vP85djFlLxQU7KiLdFSFOhuOpet9QjlbwjEBN6Y2DvyfTKiTxjPk3Z6UlkOHoMN3SElE5G0QEVRU08r4pdQlisaQVpm2/qDBLWMid777lz2UyHWJFftzp6GRqKpAjmRP04WIdF96Q1RU4MeGM2JTZcTLXwvdrF96COp71pIxJBo8AnK3Jy17pK1b0Al1V7drb1CcdT/l5RO4YfUidgFd1JkPtdtP9pO7SPs2LwruAP8jrnh5B89E4eTrHYFmoiZGt0P52Tohjg3sbLuNZS6IxLjNAQ6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(2906002)(36756003)(8676002)(8936002)(7416002)(5660300002)(44832011)(4326008)(26005)(6486002)(2616005)(41300700001)(478600001)(6506007)(53546011)(31686004)(6512007)(6666004)(86362001)(31696002)(66946007)(66476007)(66556008)(83380400001)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JLSXpOdDNWb2xTVk56SHpvd3RwWVl4UUdtNkU3cDNIZWRyWjVEeDdZQnFm?=
 =?utf-8?B?TDJmdnNFUDN4eDZTMWlZa0p5OHVhV3JpMXZIeFpCUCtSM2tjeEwraTM4Q2xV?=
 =?utf-8?B?eCswbjRZWUJubzJET1ZBa2MrSDVLOTQ0b2xzcG9uSU5BTTQ4WXhGSS9KKzhu?=
 =?utf-8?B?aGVueWtpWXdMaElkeDVlU0hkS2J2VWp2cW40V0ZrbXhDZGVYVFpjbzkzQ3BX?=
 =?utf-8?B?T0FNWjVVUjhhSzAxSFBLMjlPMHIwcWFrWVlSWno5allZalNqd1BiQ3BzMjlp?=
 =?utf-8?B?NkxYSXowbkdLbGZiRGJNeG83TE1ZUEdzWmVvTE8zWTFQdFZ2WGFNOXdOUkVC?=
 =?utf-8?B?dEhIOS91bW9FZU55UUFyaGkrV0RtRENNaU1JekUzMmJERzdIWkJSdEREUTZU?=
 =?utf-8?B?aEVWQ010MlBkQkVkUHd4djQxa2M2eGFlaHJ4M3psb285bnN1NDdUd3pjQUpi?=
 =?utf-8?B?eG9keGxqSkhjalNSZmRBTjB0THdpSm9yenRxOUlkVXM4TUpvZVBUbGo5Ylpw?=
 =?utf-8?B?MFh2cXZZOWxOSmFoVUxnTFZiRjJnMzdjc0wxb2FrR052VnRJZk02NjVlYnB5?=
 =?utf-8?B?aDB6U0NGc2IyUzhzZ1hKdkw3ZEszd05Fck5TaVVJOUhwZ0FLcUZuWHBkWmZj?=
 =?utf-8?B?VmNCVHZFWDlrYThSbXVPaEpKNEpTanJwbEsyYzVvYTFnUVJuaGZnRXNIVG9K?=
 =?utf-8?B?cFNDTWZiRDlNUGwvVDJkdDFLOTdZN1NsYy9NS0xQOEttMlNGY3VtaVY5V0RT?=
 =?utf-8?B?Vi8wcGk0TTk1T1NHbEFGUytRN3kwS3RXOGMzemhHd2dqNzE3TEU4anpSdThm?=
 =?utf-8?B?UkMyeDNDckVrV1F3N1YrVGNTNlBPbytURnFpT0RPbytIUW94aWgrMzF5T0Fv?=
 =?utf-8?B?NHFJWTEyeS9XYlpWUWhaK25IK0xDUUgyTHR5ckkwbHBMV0xOYXNWK1RhSTZY?=
 =?utf-8?B?OVBMYzlndDVyZ2g3RlRUb0UxbVdaakhkSnJZU0RHa2lGMmdybWNPc1Z6NEpu?=
 =?utf-8?B?UWI5b3B1ZitRNDJKU04zdVoyZUpUZDl3ekVSRUZtc09FNmF1R1laMzQ1V1d4?=
 =?utf-8?B?Yk8xbk5KTVJiaE1WTS8veTd5L2VjVm5CRGhHTC9xVHRIQzNoVW5SSHdYdThk?=
 =?utf-8?B?dkNoY3A3WjhYWjI5TFd4bGdtYTZMOEdGYUdmdmNaOXFFbE96V2RsaFp4SEhR?=
 =?utf-8?B?eDFWamVCdHFOSHZXSmNKMGRUZnBrMUZaYjBSd2IyVStZVmR5SkhMS2crRmYy?=
 =?utf-8?B?M1ZXMEpicHV6bkljbHFnSXArMmk4SloxSG5RT2gyVktsYyswVTFtZ1IzNWFh?=
 =?utf-8?B?UVY4S1NLc0hKZ25sZmJoeFRoZ2ZWLzBzZXN6U0xldGlkcjdKS0hsYUtWVmxl?=
 =?utf-8?B?WXZoL2NlR2NRdHN5bWQ4NCtsalFCUjQvTTQyaHVHenV5WkFlR2gyWi9wL0lC?=
 =?utf-8?B?eWdHQzJIS2dhaThianhNbURzNTVWVXBKTWdiVVRuR0NlVXFFMHdFNGlqV1BZ?=
 =?utf-8?B?SHREZmd0dCtZQWJIOStxTU9od1hydmMvQWlnK3ZnajNqVm5nbldPZDhld0Jq?=
 =?utf-8?B?U1RvTllwUjBKRnNXWkRxbzNmQTFTa2g2YXpTZDhiRmxGWmY5YTdNak9vTUFl?=
 =?utf-8?B?blBkS1AvNkZjYkpOMkV1SlhrVDE0bG9PZmo4RDZjcm1nNzdwTGkzTm9leWp1?=
 =?utf-8?B?dDNLeksyYWNOY3JLcDIzb2pZVitTcU9WYUV5QVJYZERCTGZTR1VqdEVaSmY0?=
 =?utf-8?B?dy9wd1VzaURld0ViRkp0TnQxd0hsT21DUWlqZWx0UmpveEpxSksyc1E2c09E?=
 =?utf-8?B?R1hYVUhLMjAzQkdSdHhQL2JKUW9vcDdtalBlbEhTUkVVeUZhT3kwMHJzR2o1?=
 =?utf-8?B?cjZBdTZTem90WVFVNjRVSmpydkhWc0x4Q1dGQ0p3dWNEQmI2N3IrK2duUXM3?=
 =?utf-8?B?emsvaDl4WmlzYkR6cU1HR2VjMUIvRkc3aHR2am5GYlJqZVFHWFJIWVZlWmxn?=
 =?utf-8?B?MGxQbU9VOEwxZkZ1RUFIQnhxRFF4YXdxaTFFUlNVU29QbWpuM0FrOXliY01G?=
 =?utf-8?B?U1F1amt6cVlDejNzVDVwNy85aDBvSmo1RTZ0R1lpWDN1Z2JVUnk0OGVUeWNa?=
 =?utf-8?Q?Zqg2ZjBk9pbmvOwGo2lDkon9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630f089e-51a4-494a-488f-08dc014b50af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 11:03:37.0387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ki0cnZp1kawaFfl/LD09wCz/tVNkz+5tBlv1calaLjYZYjr/3UrUvMRR7o3a8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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



On 12/19/23 22:11, Raymond Mao wrote:
> Add platform custom function to get bloblist from boot arguments.
> Check whether boot arguments aligns with the register conventions
> defined in FW Handoff spec v0.9.
> Add bloblist related options into qemu default config.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   board/emulation/qemu-arm/Makefile        |  1 +
>   board/emulation/qemu-arm/lowlevel_init.S | 19 +++++++++
>   board/emulation/qemu-arm/qemu-arm.c      | 51 ++++++++++++++++++++++++
>   configs/qemu_arm64_defconfig             |  3 ++
>   4 files changed, 74 insertions(+)
>   create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
> 
> diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
> index a22d1237ff..0eb262e4e2 100644
> --- a/board/emulation/qemu-arm/Makefile
> +++ b/board/emulation/qemu-arm/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
>   obj-y	+= qemu-arm.o
> +obj-y	+= lowlevel_init.o
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
> +	stp x0, x1, [x9]
> +	/* Increment the address by 16 bytes for the next pair of values */
> +	stp x2, x3, [x9, #16]

There is specified how transfer list should be passed from one stage to another.
Which pretty much saying that when bloblist is enabled this is what you can 
expect on arm64.
Why not to add it directly to?
arch/arm/cpu/armv8/start.S

WEAK(save_boot_params)
#if bloblist
	(your code)
#endif
        b       save_boot_params_ret    /* back to my caller */
ENDPROC(save_boot_params)

because pretty much all platforms which want to switch to it will just c&p your 
code.

that being said qemu_saved_args can become just generic save_args and you can 
also allocate space in .data section in this file.

> +#else
> +	ldr r12, =qemu_saved_args
> +	stm r12, {r0, r1, r2, r3}

And this part should go to arch/arm/cpu/armv7/start.S

M
