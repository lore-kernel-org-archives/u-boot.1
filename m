Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A6AC54E76
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 13:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BBF87555;
	Mon, 20 Nov 2023 14:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="pGMTp2te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EAF387090; Mon, 20 Nov 2023 14:16:34 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC68E87154
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 14:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso18666525e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1700486191; x=1701090991;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDnRQmJFrWwmGrBlV/mY9BrrPNAcFeHNVE6zEadA5dE=;
 b=pGMTp2te6FYLBu2IxuCen1yInB5DPLWbEhrwM+yMIdS7Hoku8h5E0g6/vDXGVPFRNZ
 tA/Ik2WU0KCKU1R9jIN4dc8WrZ/jkf+qdluWZ9YZHtF34Lpb9FnXA7GcGZNF6TkCQ+4f
 4Cr5vIRHb8a1PKjgezW8ZrLRPInUiZ7N4INVfkafi5ej5DudRCMLec2JUKnen0VtY6Wm
 yVlrvv65aded6KNR+Wyv6DqyaY4c7n+kGSszrJktLM+J8kHNT8IUoymgAWu1SLOgHa0R
 I5xHky4aT/AsOrrnnPZCKXwdDimeXeoxHQ/j4vd2bbze56ft9xRNFjQIHTKEiStKwX8T
 oCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700486191; x=1701090991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDnRQmJFrWwmGrBlV/mY9BrrPNAcFeHNVE6zEadA5dE=;
 b=P3/OYn1/2mKVJBFCzVUayQBxjmUh1RSAatDj/ipjj49oWt6viyn3Sw8s0cjVXXPzVK
 uGFeu+iBL28OgN0aTktQc7fhcRP4pe65cIG78MngBNCKlJR9aMVpV2bsm2v2BmY2mkDu
 ZRY5mJGezi69OGsWNT3IG9xHCAP3JpHD0z2t3gU+yR09EUEdSBXyGKWk7veQz2M9cmln
 bYPzkO3gutkvFCw1hRiekcmqrTdktfsJXUV+8oawrJtp2T4RhQFcUiV33DHw7mByps0O
 AkdW/X8cz8Q2G2AFuXTJb9tj5sg2fcriQzqXAeWBshIJkzj5W5D+NwHV73a5t8OCctK4
 c06w==
X-Gm-Message-State: AOJu0YxvJhRIXejy2A8TOw2PYuJ7J2zQQ9ISIC8+xIBaDvacDaDnVovA
 fIpUYKXqDdoBl7HfZJSG3qDJLQ==
X-Google-Smtp-Source: AGHT+IEAWT1I6h02qtINDLOMM/k6TagCQI5r5oNXrJd2lXv+Crj9fos40+IDSrlLnaL+Bo6/dieFQQ==
X-Received: by 2002:a5d:5f89:0:b0:32f:7bf6:db01 with SMTP id
 dr9-20020a5d5f89000000b0032f7bf6db01mr5243528wrb.67.1700486191041; 
 Mon, 20 Nov 2023 05:16:31 -0800 (PST)
Received: from ?IPV6:2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31?
 (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr.
 [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
 by smtp.gmail.com with ESMTPSA id
 co8-20020a0560000a0800b00332c32d7ab2sm5282531wrb.88.2023.11.20.05.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 05:16:30 -0800 (PST)
Message-ID: <7009ef14-3259-4634-aa7b-a12d0b1a27e0@smile.fr>
Date: Mon, 20 Nov 2023 14:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] board: ti: Add j721e_beagleboneai64_* config
 fragments and env file
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-15-nm@ti.com>
 <f0f4b6af-9831-4231-8316-1e0b0dd2dab2@ti.com>
 <20231103190629.flhz4cr5wyjyym2g@remix>
 <ee1eec62-c7ca-450c-959f-f83d5b71f8ca@ti.com>
 <e65bb379-d4e4-4c05-9855-b69443886ebd@smile.fr>
 <335167c2-4f59-4190-80a4-d27c036ba8a9@ti.com>
Content-Language: en-US
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <335167c2-4f59-4190-80a4-d27c036ba8a9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Andrew, All,

Le 17/11/2023 à 19:43, Andrew Davis a écrit :
> On 11/17/23 8:27 AM, Romain Naour wrote:
>> Hello Andrew, All,
>>
>> Le 03/11/2023 à 20:20, Andrew Davis a écrit :
>>> On 11/3/23 2:06 PM, Nishanth Menon wrote:
>>>> On 13:51-20231103, Andrew Davis wrote:
>>>>> On 11/2/23 7:38 PM, Nishanth Menon wrote:
>>>>>> Add defconfig fragments for J721E based BeagleBone AI-64 and
>>>>>> corresponding customized environment.
>>>>>>
>>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>>> ---
>>>>>>     board/ti/j721e/beagleboneai64.env        | 19 ++++++++
>>>>>>     board/ti/j721e/beagleboneai64_a72.config | 55 ++++++++++++++++++++++++
>>>>>>     board/ti/j721e/beagleboneai64_r5.config  | 19 ++++++++
>>>>>
>>>>> Beagle boards are not TI boards, add the board support to board/beagle/
>>>>
>>>> Huh, why bring in commercials and organization changes here? am335x
>>>> and am62 are under the TI umbrella.
>>>>
>>>
>>> The SoCs used are yes, the boards are not, we only make our EVM/SK
>>> line of boards in house.
>>>
>>> We did AM335x wrong, in board/ti/am335x/board.c we tried to support
>>> like 11 different boards in one file. And while it might have made adding
>>> our own extra EVMs easier, it only made things less clear for folks trying
>>> to add their own AM335x based boards[0].
>>>
>>> We don't integrate support for any other board partner like this. Our
>>> friends over at Toradex or Phytec are currently upstreaming boards based
>>> on K3 SoCs and in doing so have shown us some areas we can improve.
>>>
>>> We focus on these little short-cuts to make adding our EVMs (or boards
>>> that look like our EVMs) easy. But that only leads to extra work and
>>> code duplication for external boards.
>>>
>>> If something is actually common to the SoC then lets move it to
>>> arch/arm/mach-k3/j721e. Tricks like board-variants.c only hide the
>>> issue and doesn't help folks wanting to add their boards based on our
>>> SoCs to their board/<vendor>/ directory.
>>
>> I'm starting a new custom board bring-up based on a j721e SoC (without any SOM)
>> and adding a now board variant from the u-boot provided in the TI SDK (based on
>> 2023.04) is far from easy for the reasons mentioned above (extra work and code
>> duplication for external boards).
>>
>> Also the build break for j7200/j721e SoC as soon as CONFIG_TARGET_J721E_A72_EVM
>> and CONFIG_TARGET_J7200_A72_EVM are undefined:
>>
> 
> The issue is we didn't properly split J7200 support from J721e and now that
> there are differences between the two, the only way we have to check which
> is which is to check the TARGET board, not the SOC (as there is no SOC_K3_J7200,
> but we are working on that [0]). So currently adding new J721E/J7200 TARGET
> boards breaks things :(

Ok, I understand.

> 
>> https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/arch/arm/mach-k3/arm64-mmu.c?ref_type=tags#L71
>>
>> I always wonder if I should work on top of EVMs board or create a new
>> board/<vendor>/ directory for customer boards.
>>
> 
> New board/<vendor>/ would be preferred, we do things in our EVM board/ti/
> dir that are specific to our EVMs, and there will be more churn, etc..

Ok, maybe I'll work on top of the EVM board support for the first try and create
a new board/<vendor>/ while cleaning for the final release.

> 
> If adding a new board/<vendor>/ for our SoCs is difficult just let us know,
> we are working several issues to make it more easy going forward and guiding
> feedback always helps.

Thanks, for now I only have the SK-TDA4VM board and I'll receive the customer
board in several weeks.

For now the main difficulty is to remove CONFIG_TARGET_J721E_{R6,A72}_EVM from
the u-boot config file without breaking stuff.

Also I'm wondering if yaml files in board/ti/j721e/*-cfg.yaml are generic enough
to avoid to copy them to board/<vendor>/. (I'm not yet familiar with binman tool).

Best regards,
Romain


> 
> Andrew
> 
> [0] https://lore.kernel.org/all/20231106165044.xrmlxoyfbnkmpb5v@revolt/
> 
>> Best regards,
>> Romain
>>
>>>
>>> Andrew
>>>
>>> [0] See "Software Design" https://jaycarlson.net/embedded-linux/#am335x
>>>
>>>> $ git grep beagle board/|cut -d ':' -f1|sort -u
>>>> board/ti/am335x/board.c
>>>> board/ti/am335x/board.h
>>>> board/ti/am57xx/board.c
>>>> board/ti/am62x/beagleplay_a53.config
>>>> board/ti/am62x/beagleplay_r5.config
>>>> board/ti/am62x/MAINTAINERS
>>>> board/ti/beagle/beagle.c
>>>> board/ti/beagle/Kconfig
>>>> board/ti/beagle/led.c
>>>> board/ti/beagle/MAINTAINERS
>>>> board/ti/beagle/Makefile
>>>> board/ti/j721e/beagleboneai64_a72.config
>>>> board/ti/j721e/beagleboneai64_r5.config
>>>> board/ti/j721e/MAINTAINERS
>>>> board/timll/devkit8000/README
>>>>
>>

