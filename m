Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F90C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D6A86F39;
	Wed,  3 Jan 2024 11:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rPLIyuNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BBB86EEC; Wed,  3 Jan 2024 11:46:28 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993EB86F39
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENyv8chfTRVk5wT4XnWMqZ10Jo11D2mjdk338nFrfU3cSfttnu4edhuVod3g0M2kovhrzf4xLVCBCBV+Pwk+nFGndIOT5YLeHSvp2XASi87+8hZQQFeBKXIfp1y3s8EU4iEy93ZaqCPeHGkmaTHf/LfSIPceXXEpd7IdGZaaC4hei+zzvExmOyefkoqJMhCCF+HB33MPrlQg0Bov5RtSvK5eshWq3k4uhToIZh2VXNOB2oUwLEMWjAo4i5xiDeYMJXrUuTuR0SdMkB/z426t3PqW2OwLPPJIihpRrH8aeEM7UXK796dt07oxhP+f553Gc2fdDjJIXEIXS0SgyIUExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7LPxlMX1h3XVvoKen0swcriyvuM0tq05QoIhztVt3w=;
 b=HpKGXo6MbSJTW6AJs1s3OyNmdmh0jN9zLltog51O8sHGIco8ihmGbEwCvqMUpjcbeIhIsL23P6dLpCrF9Oyel/N8/yg1Moptf4zN1acjvmUaBmeukqhffZWGGnIsoyq5rkWgmxyyCFgMNqsYX/nI6FNTGsDtZEQLgTyMCVb4tTsuZWk7aoY4rB22Y1kt4bcN92a0DTCD32DgWMqb7OD88iSpAJMLVsp9odxpAGWL9OtAcagGOBA3qgqfjApAp2uAILrtvII4jpEj5wvya00n843EPO7ujk070CcNwoleUbLEjy6ULzP/kRcQpy5VvWcgQrcGKjEZFOA3JW7QXpKoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7LPxlMX1h3XVvoKen0swcriyvuM0tq05QoIhztVt3w=;
 b=rPLIyuNBTcHXk5bUwQsRnKcOCgo3pb6pcHYJGF2RgUqEN0UKgLTN8zzbwJnfvIFz1l5WnsY99rMjdmfokGo0x33pCF1gmtyKyogLjm8V8z3B1FQtS3c8gAXZOqJ96maF+KFnAQWply5kwWDqfgcVD7xSpHhxWrLQ/EAC27MO66g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:46:22 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 10:46:22 +0000
Message-ID: <f7cb982f-66f2-47f1-aeb2-f3fa8e8b8912@amd.com>
Date: Wed, 3 Jan 2024 11:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm: Get bloblist from boot arguments
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Baruch Siach <baruch@tkos.co.il>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-7-raymond.mao@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240102221237.1007090-7-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ff2f11-93fb-49cc-be7f-08dc0c493a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UHFRFKlZBPm/Kev7QQ0yFdPaYFZhtzOBcWHyGGLSYEf5Vr06pbLsX5j12CiFI8R//ZmwysWRlepx9w5ARncA+VWH5mOomDZUHc26AmbQj1/qBA4kxT6aErcRMw+Ig4QhUh5wes/LkC6IyvkAZP04DmIWazFWv8ftWNtHRcUGFmI6Lo4OQbWQSBzGMi/Oq/H6bX0lq0/NDY+5RZRQiqDJ+zeRfTd2t0fgrOaSQvJSz8YSVyHIaJ6HhZpHsSuyLVqYBBsnpDbOLSdZqFco8aUkVRD7LYaRaiiigRtmefgIpEq92eK4tT9sU7wVrNzgawNYbPosr1tnEhacv5GGZsaKvflc0VpXZ5rPHH+9rKyCvHyGhp9NkdV1HltvJNXc1Bg6eOaSLribynEv5iVGMGA2HVghDO/dVA3IvJc92QUhKt3gIrSzaPJ9hqq6cS8Ee4HKk2FEpx56T/eQcn3iD/+0Kp7ApxwJEhMm3J5ZXAlsH+XiTaGgZJZr7s7AVAjPAOlIfyd0gHCKykuXORfckNZNRIdTqIQKf/SY5xevnLVYQpLyDe3O242EPQiA0XWsk64sQsnPndpWJft4O6D0bdalwceOOpnrENPDH002MHPEa8BMXguVO5I3Ji77fJAKiWLN54p3etN+FYwj8Ft0G5glQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(36756003)(31686004)(31696002)(86362001)(2616005)(26005)(53546011)(6506007)(6666004)(6512007)(66946007)(6486002)(316002)(478600001)(54906003)(8936002)(8676002)(66556008)(66476007)(4326008)(83380400001)(5660300002)(41300700001)(44832011)(7416002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhEbEdMeFkrSU9ra1NBK0p3cys5akRLaWdzQXYyS0ExaE1oTFV4Ukd2M0Zz?=
 =?utf-8?B?ZXVReVJvUm14TjVWY3EvL3RJNkUvdm01ODR3aDNTRzRqZmt1MUVXWUdSUlpm?=
 =?utf-8?B?aHYyK0xibmZiSTA0Zm9LME1uUVFDWnoxd1lTRUNBZTBYTTdtM1UvS1VOLzdU?=
 =?utf-8?B?NVpka20vRStTOWZZclFYYzhoWHZuRXV1YW81cVo1c3pQM1g2QmlFZkFlMEFV?=
 =?utf-8?B?Mnp1MmsvRHMxYi9ybHBlYVJMb1J6N0NpajlXckU2VnQvWHNMelZFMktEdzF4?=
 =?utf-8?B?SWV3TUF6elJ1aHkrc1JGVit1WnVCTGNpV1M1Qkx2QzdoaHljRVU1a0FPZ3FR?=
 =?utf-8?B?eG5DTXF3TUFJZFg0d0hvd2FneFlyQVFmTlY3MzNaYitjaFNiaCtQRmpYSXVz?=
 =?utf-8?B?TEpTUGdHbXpESnRxZFpYWnVzYnJNQitlV3RaM1NPVGZaaEtMMnZMMFd0Wk5u?=
 =?utf-8?B?QTZnWXZhSVJPelZCWHp3YndFajdxTHltUEJ2aStGeTdXZnl1ZHdCSFhMQkI0?=
 =?utf-8?B?VDh6SCsyU20xd1hWSXMvZUNmbjRlNUhZdEV1TDhwbEVUTUk1elpZdjNVbEJU?=
 =?utf-8?B?SG1DMGUvakJMOU1abHpnWllVM2xmRERRMmRqUjFORnFKdHE4ckgvTkZDSHpE?=
 =?utf-8?B?cHVkbUpJOTBMTmtFanJuSDh2ci9ybnlGWHB3dVJjdmVWWHc2cTJIckhoNGNi?=
 =?utf-8?B?bDV4bXBxVWdaMzVJMW1YTnl1VVBVOXNzRXUwR3ZxeTJHYVhUaG03dDJZS0tO?=
 =?utf-8?B?MTJ2UHpLSzFHMyt1TUVTSGxITmU1MDlRY1FHME0rWGJSV2FaVm93M1F5T2ta?=
 =?utf-8?B?M0grOEk1YWt1VFMxenE5WWMwV016b2huc0x4UmZsczBXQlE2dEdnQmdhYnhW?=
 =?utf-8?B?ekR2MllKbkhCaEJITUFGSWJQemM2QWFJeTFTN2FjaXdwa2ZnUlh2aDFDQmdh?=
 =?utf-8?B?RjBxNStMRDZpOGVrTHhiRlZjMlA0NTRRRlVKUFlyaEV3YTk5NW5QMyswSnpZ?=
 =?utf-8?B?b3kvbk9sVXRwa1d2UkhEVE1sZE0xUUFjMXlFamtScFN6Um1XV0w5Qmd1QSsr?=
 =?utf-8?B?NHpaK3RYazYyNGZMMmtsSGhHamtSazhYQ1dWZ2hxbmZubWtBM2w3b0VuMTdt?=
 =?utf-8?B?eUdSK0dObk1MOGlEQkw0NGNsZWJOdzViRTl3Uks1b1k1dThVYTc3V0FGQUVG?=
 =?utf-8?B?SkFuV0UyVWRFeERTMWdYSmhLUDZad1ZUVWhKckl6WHB2WDNrcG1zT09iSnNq?=
 =?utf-8?B?cTJGSGFFNG5BTnNpOGlWMmJCbEZ1UVRCeGRHZjNiZVRqOFc0NXd0Ym1lUXQ2?=
 =?utf-8?B?KzAvM0JsUGxNQThFdlFGTnlyMEdZYkcvWVRBaXpMNlRpVjhlM1c0b1krS2ph?=
 =?utf-8?B?RUwzWGNNM1dTbG0vK1h4YTVDZEJTTnBaMzVoakVaeWRRS285RDNVNHcxclRM?=
 =?utf-8?B?Z2lWSm5LZXN6WGhkQ2l1L2o5QTRPMTB4VXRsU2dtcU5OQXRhRWFTMEkvWlBZ?=
 =?utf-8?B?bXVmY0poeWNtTFVLV0NiUFdLWG9VaGd5UGY4eUtMK0Nyak5YZEU1d3pTcVoz?=
 =?utf-8?B?MC80ODMveDYrbG9oRkx1MU9IUXpIbTVQWEhPUnM0SklMN05KT1Z6UTFXeXYw?=
 =?utf-8?B?bW1EWkpUYnNRYXRTRlM4MUlXQ2s0Y0YrV1pVZ0RUN3c5ZWJGbFluSWFScTg5?=
 =?utf-8?B?djBaQ2J6ZEUwbU9hejVxZzBHMmlROUVHejJrZ2tYc1RZK1JzU2Exem50dytK?=
 =?utf-8?B?Y1RJcXovRTIwcXdBRjJwdEZ6OW5vbE9pYmpad1ByNktZUG4xOHAvcWNaK2xn?=
 =?utf-8?B?RGorK3RsRk9wMTJpOVg1TnBKQmdHWGRDY1BaMW5jZkZ2Q1JvWVhlaGE0UmRu?=
 =?utf-8?B?S243NlNQcWRBQXJ0bXRNZFVxbmVBaktZQlMyQTJ2eDVyMTZITnVnK0lVd1c1?=
 =?utf-8?B?RGFlUEVQTkJwbnpFWkpUeFB2ejVhRWhlSWd4aUxVdm8rT2svTnl5aVVpaDU5?=
 =?utf-8?B?bnJQWnNycnNWNmRqckJpRWU0M0l0UCszWXBGOUFFYktiSlQ5MEJ6S2N3cTBZ?=
 =?utf-8?B?aW9NTGtEN09WNlF2cThBbmY5WGlmSTRMYTQ4dks3YjdyWlQ3ZmNkYlB5NHpn?=
 =?utf-8?Q?sgJQwbM+zCpT1bvIyu3cKbMjR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ff2f11-93fb-49cc-be7f-08dc0c493a11
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:46:22.7300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBpZCeQOK8hxgZAZGwPXGp6OUQ+UKhJMrvc0JmuydfjUft203/R9vkA8YZY0DaVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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



On 1/2/24 23:12, Raymond Mao wrote:
> Add arch custom function to get bloblist from boot arguments.
> Check whether boot arguments aligns with the register conventions
> defined in FW Handoff spec v0.9.
> Add bloblist related options into qemu-arm default config.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove low level code for copying boot arguments.
> - Refactor board_fdt_blob_setup() and remove direct access of gd->bloblist.
> Changes in v3
> - Optimize board_bloblist_from_boot_arg().
> Changes in v4
> - Move the function as an Arm-arch library instead of a board-specific one.
> 
>   arch/arm/lib/xferlist.c      | 38 ++++++++++++++++++++++++++++++++++++
>   configs/qemu_arm64_defconfig |  3 +++
>   3 files changed, 45 insertions(+)
>   create mode 100644 arch/arm/lib/xferlist.c
> 
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index b1bcd37466..0023c55d0d 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -85,6 +85,10 @@ obj-y	+= psci-dt.o
>   
>   obj-$(CONFIG_DEBUG_LL)	+= debug.o
>   
> +ifdef CONFIG_BLOBLIST
> +obj-$(CONFIG_OF_BOARD)  += xferlist.o
> +endif
> +
>   # For EABI conformant tool chains, provide eabi_compat()
>   ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
>   extra-y	+= eabi_compat.o
> diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
> new file mode 100644
> index 0000000000..163d20c11c
> --- /dev/null
> +++ b/arch/arm/lib/xferlist.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <linux/types.h>
> +#include <errno.h>
> +#include <bloblist.h>
> +
> +/*
> + * Boot parameters saved from start.S
> + * saved_args[0]: FDT base address
> + * saved_args[1]: Bloblist signature
> + * saved_args[2]: must be 0
> + * saved_args[3]: Bloblist base address
> + */
> +extern unsigned long saved_args[];

you should put this to bloblist.h. I would say it should be the part of 4/9 
where you define saved_args for armv7.


> +
> +int xferlist_from_boot_arg(ulong addr, ulong size)
> +{
> +	int ret = -ENOENT;

There is no value to initialize it here.

> +
> +	if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
> +		return -ENOENT;
> +
> +	ret = bloblist_check(saved_args[3], size);
> +	if (ret)
> +		return ret;
> +
> +	/* Check the register conventions */
> +	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
> +				      saved_args[1]);
> +	if (!ret)
> +		/* Relocate the bloblist to the fixed address */
> +		ret = bloblist_reloc((void *)addr, size);
> +
> +	return ret;
> +}
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index c010c25a92..418f48001c 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -69,3 +69,6 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_PCI=y
>   CONFIG_SEMIHOSTING=y
>   CONFIG_TPM=y
> +CONFIG_BLOBLIST=y
> +CONFIG_BLOBLIST_ADDR=0x40004000
> +CONFIG_BLOBLIST_SIZE=0x4000

This is likely not the right position in defconfig. make savedefconfig; cp 
defconfig configs/qemu_arm64_defconfig.

M
