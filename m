Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2C1E68143
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 08:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA3D83981;
	Tue, 17 Feb 2026 09:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KcisbyqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D5B83B8A; Tue, 17 Feb 2026 09:46:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B668063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 09:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F41023F2C5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771317972;
 bh=kRj2ISLOmJRWz2uyHjS8d5Ey44l5Na+qR+SlhJ9x2tw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KcisbyqV7Ow+OAc7l8GTSu9q1kqCVLgsjyGo1gtrTYara8wzqJQnZXeRcw+cz2HYP
 xgE8+dsXuSV2WZuOAHyvuQtLaU0aokTijUA0xR0svysadEpJRadpoCk23SaKhv5r49
 SpdKaAX88Txo4oVyWbBmvYskUlOTjBlOBF/avoGADrWBlLkTsf7Uv3Xuc8ipPG0RUE
 OhJC+kWFTxl/8K/xiUKA2i3qHtWr5JjgLpjTnkIDJRxHxzu75XBH1Db3UaeAvicF66
 DVsczOs49BABv4uw9omeBb2PXSgM3J0yuLmhnSPa4AftnjY2v5e+nwmDe7kc1Qrl5n
 j3bcmcXKcT2BEuVdryrlZyRkIh46wd+0/y6BpxMbB1Kw96ChzbqvOWEpyHu8TyBfwU
 i+a6WDnNf82hrpxI0x5i1H8hIzzISPaBGCFiUbn6UcxeswkCZgi5L3VXPzV7Ahxgo/
 2ykzDYoq25U8rB/PVeehy/sElJeaNp0hFfpZizAZIMbGTBf49OaR8MXWiIDUOPDDhC
 MhyDzUPqQCgggOnyGk+WBGZd6/VU4cfy0KehPD0ulZXX0xWDzVsMqM+ul0YKrImNK4
 SyGrRmgIhoshFCfyRYNQWBsdy2HiDnrP3xl41TY5ySbyPnbh+n1eyMI7MXvuYYKl2C
 aJ2OSgMeP037p7k+VwSKfsHQ=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48378c4a79fso23836455e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 00:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771317971; x=1771922771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kRj2ISLOmJRWz2uyHjS8d5Ey44l5Na+qR+SlhJ9x2tw=;
 b=L9qeVW7nX7hvB0AO2MGnCe7vKunr33gTiiPs1mP4PAAGVYycIt1C5CzARte8+buWm5
 pG4adE5ITcQLUncth2DllA5WiNirVsIeF8iqhY7i+Di5RpkcrX5WMgUhzzI23x+Btr6S
 hokeye9Y6Jg2004HrHaXWI9RxtYPNxBUz5xVr1OaJCkE1Bci9AW+P/PFJ8XzcR0u/4gs
 RdT4uAYM0g3o8/f34sB5ejAFj1Z1rSuQ6illbFw0unySRAw7gy/ARCaYgLXFD6wIBOLs
 QnzpLEHMnYu9D7qm28XuxhftP9nNoCzzcdC4GJeqSmej6d+NlZluC/zvvPUvedfg/T+z
 0v6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0/9u//2CsiSLUOfk8uhmDOYmZ4hSAOicqlLS7TFy5Eip/uUt7pE6P+L5kC7ZyPqF6E5mSnkI=@lists.denx.de
X-Gm-Message-State: AOJu0YzTlUE80e5nplx/TCVUzVFu5SXFv1oUdH9u9q4wi6DCYnkEAQaH
 ++HytgQrOASgTJlHPwCMeRzLB7HC1W1927ZRrjbrRquMNIQIDV3kXyuvHiNUp29mtsYh3SU+wrO
 klik+P4oBz2FKZ193DR5t5LWU+cDV8gTUtTC36oS25aKUCHupGm4mmVLuDI8zMuUwpFQKMcg=
X-Gm-Gg: AZuq6aKStFnoFeHfBv+3/kP4yTPzsJmk/Kak91b4r0zVvegZH4J3nO/obdDQukZv94T
 i/XJQxlkSiVuhDcRMM1qKfNQosMre4OxShhRzms2qkWDv5whJRMNL8Plo0l0Gr9VuBzTIcCXjea
 0EuDMWcwO4xUzdqlPY0z/vp20LXLqEpTYDRcfMq9MYUd21qbcGEl4OlqEostlltBC/pjH9qyeiC
 JliolfcAmZFx9OklEHoO5f2bjnfmcrMCxT5u1zNmHNR2q+EXUFU937w+d6A7CiomKbPYmYiUOV4
 jV8g0Sl0Tp2PnWUHpWD9wT5B4tMWz3i3IZgmH+XLe3oWhYAcKLvrCxgK7ckNL8q8d7OmlTiqJ7k
 I8ouji15LJYtsK0cu5BFDsm/uK82JPPHODxNWV9mkEw17aWUfzdqAgtEp6ujFLMqPggSYDOQX4p
 AQvE057EQ5CQF9N3Uyboo=
X-Received: by 2002:a05:600c:310b:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-48379b9f174mr183361805e9.9.1771317971445; 
 Tue, 17 Feb 2026 00:46:11 -0800 (PST)
X-Received: by 2002:a05:600c:310b:b0:480:4a4f:c363 with SMTP id
 5b1f17b1804b1-48379b9f174mr183361565e9.9.1771317971042; 
 Tue, 17 Feb 2026 00:46:11 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48387ab1974sm129292315e9.3.2026.02.17.00.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 00:46:10 -0800 (PST)
Message-ID: <740c2e83-b7c7-49db-bdaf-067352d9aa16@canonical.com>
Date: Tue, 17 Feb 2026 09:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: require at least 128 KiB of stack space
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
References: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKvGLUoR7-hD3LdgkYy5Oh2zR+g+P5ZtKnkpg-A_XvfaQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKvGLUoR7-hD3LdgkYy5Oh2zR+g+P5ZtKnkpg-A_XvfaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/17/26 09:18, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Tue, 17 Feb 2026 at 09:47, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The UEFI specification requires at least 128 KiB stack space. Consider this
>> value as a prerequisite for CONFIG_EFI_LOADER.
>>
>> Mention the requirement in the CONFIG_STACK_SPACE description and decribe
>> that the UEFI sub-system uses CONFIG_STACK_SPACE when defining the memory
>> map.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Kconfig                | 8 +++++---
>>   lib/efi_loader/Kconfig | 2 ++
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index ce25ea24a60..99b3cd62526 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -615,9 +615,11 @@ config STACK_SIZE
>>          default 0x4000 if ARCH_STM32
>>          default 0x1000000
>>          help
>> -         Define Max stack size that can be used by U-Boot. This value is used
>> -         by the UEFI sub-system. On some boards initrd_high is calculated as
>> -         base stack pointer minus this stack size.
>> +         Define Max stack size that can be used by U-Boot. The UEFI sub-system
>> +         considers this value when setting up the memory map. The UEFI
>> +         specification requires 128 KiB or more of available stack space. On
>> +         some boards initrd_high is calculated as base stack pointer minus this
>> +         stack size.
>>
>>   config SYS_MEM_TOP_HIDE
>>          hex "Exclude some memory from U-Boot / OS information"
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 13e44be1d06..450ffa61c0a 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -15,6 +15,8 @@ config EFI_LOADER
>>          # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>>          depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>>          depends on !EFI_APP
>> +       # The EFI specification requires 128 KiB or more of stack space
>> +       depends on STACK_SIZE >= 0x20000
> 
> Won't this disable EFI for ARCH_STM32 devices? Those define the
> default stack size as 0x4000.

The UEFI specification explicitly requires an enabled MMU.
The ARMv7-M architecture does not offer it.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>          default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
>>          select EFI
>>          select CHARSET
>> --
>> 2.51.0
>>

