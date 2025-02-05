Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66736C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 19:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FCD80562;
	Wed,  5 Feb 2025 20:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6LsXwQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3D180762; Wed,  5 Feb 2025 20:02:34 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4A380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so29726366b.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738782151; x=1739386951; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KKq0DYFsupa3wbrv29N0Rab1DrFOrIFaXh2ZoUKyCtM=;
 b=W6LsXwQcvSKexHIqBbRKoFOkXOQh/hk+xevkXp9sL98fuJpA7DqOohJ+ODedp0brMY
 xj/VDJRofKf22pIqDNehWHp69sNxo4HYC94ihrtPojNq4a+R6R1iOmWxAmIH9G2G5Wtg
 YwbAaCJ1nc1lNu3STZdfxy6hwv8cc2GYFy1JWfA7Xo0ltouo/BqjM21IIbpCd6A2DwYx
 Lut5O4ts9Kbj+h3YaHoVw3Ay6mezk3mtMP6w9U1iVwJFPwCN6uSZF+wRSWGyFf4cNxPq
 XMLZW5/oK/LxoIVCdKAc+Qa8RHNntD6dbfaxtCaN36Y1QxI8D17gGU30pVsQ01ZgavG8
 k9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738782151; x=1739386951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKq0DYFsupa3wbrv29N0Rab1DrFOrIFaXh2ZoUKyCtM=;
 b=Z2UwoLVJgVSb+8uv+Nn6Qd440mBYmDALzPUbZg3/VZEBROmlmYPaP/wA31nMc6Ic5A
 GNUPvTbDYdcbnWsh7ctkL3hYUxByMPuOewV8IIkH4jS9eDnF7QGCQtfJZn+zOmItUGAj
 6f/ut11WkXtFK+fcLRQMhSToMt32eQYd3cX5Rc0CgMi5yr+8YBz33KRZpl+2i1le+p7p
 W6YlICl+rpQftjegjTNeBKsnsMmOQieT2oRHCJ+eoPJBAlON/Yy3JkhrK0FfxNRqLw2W
 m9MaNceMATe3LhyNSWRbeVjJ0z/s/bxq3NORAIRBezIXN6/4JdFO3oNOaPbH0tLGU34s
 J2Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqDOnYjKH0uVTuhevIkeNR/lETwL8UAxW0IUkEHCShudYCTUqLVAPd4Qq2bKqRLgFvuqu+jVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwaC/HGCQcy0OdEDygT70GG7+M024EK+cExXc4FHJt1gm0HjpBS
 KexW1bx0aqWmpThfjOc4lcszdoWvv3yfqw5hFKgvQBLzKCHBh6/I8/1H
X-Gm-Gg: ASbGncu7tI4M5s4HizP0S0KZbBkALRccJCYrGANkldzBX695vsxBE9h7ZHKg2qyzbOx
 cyDTNbNBXHp9gJZSmorZQwDtKgGZ3bETAqcVealbKgCq9Uszthsnn60aMmzKMOpurfCxp1HaesG
 1iNL1vXjVsUX2artvYfaePT8Ch0iUWWUAAbizAubujn5+d699VB06HgdwdpclXtm7+AyhhEKCDY
 dWgoFI/clpCW0Vfz0eHe6Ep5yUQ38XNh/CSfrl7Dn4XGSIeeA7vjQHxdfnvVW7jlPEUgyblBK90
 lEc/fWFSbxQH/x/DH0raqx9CJdf6q1AfyslB+jQ9E2bxslFpzd3fnWLSsu2COQ==
X-Google-Smtp-Source: AGHT+IEIMCqped3X+4DYqyG0vK6Kaz9Cu537Ioi1jxzWTnBZDAhaiQ7VYNR3h8cNsXBcAOZ+SCe3fg==
X-Received: by 2002:a17:907:96a0:b0:ab6:df79:f577 with SMTP id
 a640c23a62f3a-ab75e2456bbmr420455566b.9.1738782150972; 
 Wed, 05 Feb 2025 11:02:30 -0800 (PST)
Received: from ?IPV6:2a02:810b:f13:8500:4eb2:14b1:ddce:aa48?
 ([2a02:810b:f13:8500:4eb2:14b1:ddce:aa48])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a2fa50sm1138849366b.128.2025.02.05.11.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 11:02:30 -0800 (PST)
Message-ID: <4fce2690-bb35-4e1e-84fc-91564b7d78e8@gmail.com>
Date: Wed, 5 Feb 2025 20:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250126234838.561065-1-jonas@kwiboo.se>
 <20250126234838.561065-3-jonas@kwiboo.se>
 <4e6629cf-9685-4b91-800e-82a9df30d5e3@gmail.com>
 <f52283be-6119-4682-a41d-efff377365ab@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <f52283be-6119-4682-a41d-efff377365ab@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Jonas,

> Hi Alex,
>
> On 2025-01-27 19:59, Alex Bee wrote:
>> Hi Jonas,
>>
>> thanks for working on this.  Please see one comment below.
>>
>> Am 27.01.25 um 00:48 schrieb Jonas Karlman:
>>> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
>>> the more common 0x0 DRAM base address used on AArch64 SoCs.
>>>
>>> Add default options that should work for these ARMv7 SoCs. Same offsets
>>> as before are used, just below 64 MiB. Hex values have also been padded
>>> to improve alignment.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>>>    1 file changed, 24 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index 5aa9e0f1af3b..da20d3233fe3 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>>>    if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>>>    
>>>    config CUSTOM_SYS_INIT_SP_ADDR
>>> -	default 0x3f00000
>>> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
>>> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
>>>    
>>>    config SYS_MALLOC_F_LEN
>>> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>    
>>>    config SPL_SYS_MALLOC_F_LEN
>>> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>    
>>>    config TPL_SYS_MALLOC_F_LEN
>>> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>    
>>>    config TEXT_BASE
>>> -	default 0x00200000 if ARM64
>>> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
>>> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>>>    
>>>    config SPL_TEXT_BASE
>>> -	default 0x0 if ARM64
>>> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
>>> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
>> I'm not sure if adding RK3036 and RK3188 is correct at this point. Both use
>> SPL (without TPL) currently for DRAM initialization and thus need their
>> CFG_IRAM_BASE as SPL_TEXT_BASE.
> I think it should be safe to add these default values here, any value
> defined in board defconfig or soc Kconfig will take precedence.
>
> The RK3036 and RK3188 boards use SPL back-to-brom to load U-Boot proper,
> if someone wants to move these board to use similar TPL+SPL+FIT this
> will prepare for such occasion.
>
> Having them included here also prevents a possible issue in case someone
> in the future where to add a select/imply ROCKCHIP_COMMON_STACK_ADDR for
> these SoCs, else they may fallback to wrongly use 0x0.
>
> Do you want me to drop them in a v2?
>
> Regards,
> Jonas
it is currently "safe" as it would of course be overwritten by the
currently existing defconfigs. But if someone dares to use this symbol for
a downstream/new board for either of these two SoCs, things go south.

How about adding some "extra security" by making it
     depends on TPL || ROCKCHIP_EXTERNAL_TPL

As I mentioned off-list: I'm not sure if any of these
XXX_ROCKCHIP_COMMON_BORD belong here: I understand the goal of syncing
configurations for the different SoCs, but I'm not sure if a symbol called
ROCKCHIP_COMMON_STACK_ADDR is the right place for it (plus the
XXX_ROCKCHIP_COMMON_BORD symbols (should) have no dependency on using
ROCKCHIP_COMMON_STACK_ADDR, neither code-wise nor from semantics).

Regards,
Alex

>> Regards,
>>
>> Alex
>>
>>> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
>>> +	default 0x00000000
>>>    
>>>    config SPL_HAS_BSS_LINKER_SECTION
>>>    	default y if ARM64
>>>    
>>>    config SPL_BSS_START_ADDR
>>> -	default 0x3f80000
>>> +	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
>>> +	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>>>    
>>>    config SPL_BSS_MAX_SIZE
>>> -	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
>>> +	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
>>> +	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>>>    
>>>    config SPL_STACK_R
>>> -	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>    
>>>    config SPL_STACK_R_ADDR
>>> -	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>> +	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>> +	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>    
>>>    config SPL_STACK_R_MALLOC_SIMPLE_LEN
>>> -	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
>>> +	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
>>> +	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
>>>    
>>>    endif
>>>    endif
