Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A08C7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 08:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98AD81F66;
	Mon, 23 Jun 2025 10:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XJo4T3bX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC9781FEE; Mon, 23 Jun 2025 10:10:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CE980548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453426170b6so28663375e9.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750666245; x=1751271045; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3k/4SKluaFpv+T0vKZq2M29d5NTGgRlxoie63h6J92E=;
 b=XJo4T3bXylRYyBwAQHf0Ysm/MDULYKullB57yqL6fQKJkUgbsFTycvRJKOBiKyJnGt
 yvTNBGs2FOjowuzmUSvGrK+FbJJtnUX4sjk1AYQr+uIUoTHC1m1aKd4kPNfrPbLi2MnO
 XqrvBjVGt58ciCvsb/6r1cU8UAL77Zrw9CHH/51ApI8Kde2XP6TGysZzrTwBd+r1X8AE
 k9RVFwTf4w3iFbUf8rsWmgT1+HFmQx/eg+f6hAYEmSTvA7E6yggWMZi1HiaetII/UKwO
 VVliG4/VCW6R5TSXPwscxWwhGqBQzNBuo8TEm4nmUExoFzRi9xrOHHGS/CaZHc2nf7mC
 zEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666245; x=1751271045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3k/4SKluaFpv+T0vKZq2M29d5NTGgRlxoie63h6J92E=;
 b=hREyBiROQ97KpjHfEIgA24OCGpTsSNw6KE8kWLz2Myy4Ud+/4looQzFkr91mUvg2zP
 Rp29UQBV6gNLrYnrwmbZnbsIP6j8Bn81O1HrCKiltZ0sFXTcJ/5fysT0N8dKp4Krx1rs
 dn7IjpM6F06muAXGABLh1AehMOkTw2XxMnU5Zy3uCZOorXfR8mVe709WFfW1A8kDutPw
 MtQFoUlty0/gfkoPISj+REn1F5L+Xd0BjD3gg0ZByVp7rHu+KEJteEGY+Fldzkq9opB+
 ficx4tl2qV39yfJqZajFcJAM71Q/+Mu/BIBKmB0W4CtKjKj+WTphdbu/eEtyPFH5l/Gb
 JJcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX93ayGhb2HbQlAc/ioRWSrSB8zWLj9ouilhhYn5WvfwmPLL5DCgpUvSksG5zhp/NAhj9WO9R0=@lists.denx.de
X-Gm-Message-State: AOJu0YwYlWSU4tBrc9ZQ786fYieFt2DQm4ciAVC/q4+1fD/blIa8DW2U
 eXoXTCpPVSexkJ0uYlb3r0IQ0mS8sLMheeFRtc0MCPzn9Zv7PkI/DDoeXytdWiXLBoo=
X-Gm-Gg: ASbGncuBt1OwfByDAiOPipepx9jOn4gOfHJxe+8t2Mi18MGWxrpe0EMCtImjNxujMgU
 FZ5xW7o8v2LP9i1QLx4mkQYSuFNh4mJ+v7+aSjortwUKARxdOz4ecIIUfVolW2upkFKnnDhFMWr
 n9E5Fqy7bzCyvbPAl15alDlRyScU7mNdT2L035QR75fIJ6GGNhjSoqTkaT1fTn8mjmUvBKgDpJL
 HM7WOYPL77vl3yGTxmrJQjKr7xZ3OXLi9ITFt56ZKXsGQBFSr88yOGmPlUY/LG2RyaevIZ8uDd5
 j3un5toAAQBO0de5JVQG+JUg7/7uENyhi5QBpLmYXHjZGeyz8Mn/JNOYovTzjC7LX++SJ7AITXO
 wO++5WneRp+VswZLEyDQjg8nAIa9QJlvV9f4FQAGvYw==
X-Google-Smtp-Source: AGHT+IFauyINXkMayxLQIJVOWXWzG+Ve9zg460JBunT1lU1rruR11Dhk6dkRnOl5SGJzOHy29T9RuQ==
X-Received: by 2002:a05:6000:4913:b0:3a4:f7e7:3630 with SMTP id
 ffacd0b85a97d-3a6d27cf353mr8329911f8f.15.1750666244808; 
 Mon, 23 Jun 2025 01:10:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f95b:5bbb:67a7:dbd5?
 ([2a01:e0a:3cb:7bb0:f95b:5bbb:67a7:dbd5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188c6esm8559397f8f.81.2025.06.23.01.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:10:44 -0700 (PDT)
Message-ID: <2b144700-371c-4492-9244-41539457050b@linaro.org>
Date: Mon, 23 Jun 2025 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
 <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
 <CAJaLiFwW_=GZcyS8qEyCepkYyHsGs-3hOiS6ubNbN=2=WC9ReA@mail.gmail.com>
 <20250621013656.GP216500@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250621013656.GP216500@bill-the-cat>
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

Hi Tom,

On 6/21/25 03:36, Tom Rini wrote:
> On Fri, Jun 20, 2025 at 02:21:59PM -0700, Tony Dinh wrote:
>> Hi Jerome,
>>
>> On Fri, Jun 20, 2025 at 4:03 AM Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> On 6/20/25 12:53, Jerome Forissier wrote:
>>>> Hi Tony,
>>>>
>>>> On 6/19/25 22:37, Tony Dinh wrote:
>>>>> Hi Jerome,
>>>>>
>>>>> While fixing some ext4 file system problems on 2025.07-rc4, I ran into
>>>>> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
>>>>> image,
>>>>> and then u-boot execution was frozen without anything going to the
>>>>> serial console. I did a bisect and found the commit that caused it.
>>>>>
>>>>> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8a75c1940
>>>>>
>>>>> When I tried to reverse this commit, I had a build error like this
>>>>> "{standard input}:24246: Error: selected processor does not support
>>>>> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
>>>>>
>>>>> Currently, the only way to boot Kirkwood boards is to disable either
>>>>> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
>>>>>
>>>>> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
>>>>> know if I can help with testing to troubleshoot this regression.
>>>>>
>>>>> All the best,
>>>>> Tony
>>>>
>>>> The problem seems to be that some arm32 instructions are inlined
>>>> inside thumb code and that's not allowed on this CPU without some
>>>> interworking instruction (bx, blx etc.). For example, consider
>>>> board_init_r(), is is mainly 16-bit instructions (Thumb):
>>>>
>>>> 006186a0 <board_init_r>:
>>>> board_init_r():
>>>> /home/jerome/work/u-boot/common/board_r.c:799
>>>>   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
>>>>   6186a2:       b0ab            sub     sp, #172        @ 0xac
>>>> get_gd():
>>>> /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
>>>>   6186a4:       464a            mov     r2, r9
>>>> ...
>>>>
>>>> but then suddenly:
>>>>
>>>> /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
>>>>   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
>>>> writefr_extra_feature_reg():
>>>> /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
>>>>   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
>>>>                 ^^^^^^^^
>>>>                 32-bit arm instruction
>>>>
>>>> I would expect some call to a *_from_thumb() veneer, such as in:
>>>>
>>>> 006009dc <do_bootm_qnxelf>:
>>>> [...]
>>>> /home/jerome/work/u-boot/boot/bootm_os.c:379
>>>>   600a02:       9501            str     r5, [sp, #4]
>>>> /home/jerome/work/u-boot/boot/bootm_os.c:384
>>>>   600a04:       f04a fc7c       bl      64b300 <__dcache_status_from_thumb>
>>>>
>>>>
>>>> 0064b130 <__dcache_enable_from_thumb>:
>>>> __dcache_enable_from_thumb():
>>>>   64b130:       4778            bx      pc
>>>>   64b132:       e7fd            b.n     64b130 <__dcache_enable_from_thumb>
>>>>   64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__dcache_enable_from_thumb+0xc>
>>>>   64b138:       e08cf00f        add     pc, ip, pc
>>>>   64b13c:       fffffb28        .word   0xfffffb28
>>>>
>>>> We may need to move the inline functions with mrc/mcr to a .S file,
>>>> making sure it's built with -marm on CPUs that do not support Thumb2.
>>>> Then hopefully the proper interworking sequence would be inserted by the
>>>> linker as is the case when Thumb is calling into object files resulting
>>>> from .c files built with -marm (for example: arch/arm/mach-kirkwood/cpu.c
>>>> which has CFLAGS_cpu.o := -marm).
>>>>
>>>> In the meantime, could you try the following patch?
>>>>
>>>> diff --git a/common/Makefile b/common/Makefile
>>>> index 35991562a12..a509675335a 100644
>>>> --- a/common/Makefile
>>>> +++ b/common/Makefile
>>>> @@ -19,6 +19,8 @@ obj-y += version.o
>>>>  # # boards
>>>>  obj-y += board_f.o
>>>>  obj-y += board_r.o
>>>> +CFLAGS_board_f.o += -marm
>>>> +CFLAGS_board_r.o += -marm
>>>>  obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
>>>>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
>>>>
>>>> I think it should resolve the issue, but is does also increase the
>>>> size of the binary (+4 KiB). So the .S solution would definitely be
>>>> better if it works IMO. I'll try to propose something ASAP, will
>>>> likely be on Monday, feel free to give it a try by yourself though :)
>>>
>>> Or maybe this which is a bit less radical:
>>>
>>> diff --git a/common/Makefile b/common/Makefile
>>> index 35991562a12..f0b7eadf7d2 100644
>>> --- a/common/Makefile
>>> +++ b/common/Makefile
>>> @@ -19,6 +19,8 @@ obj-y += version.o
>>>  # # boards
>>>  obj-y += board_f.o
>>>  obj-y += board_r.o
>>> +CFLAGS_REMOVE_board_f.o := $(LTO_CFLAGS)
>>> +CFLAGS_REMOVE_board_r.o := $(LTO_CFLAGS)
>>>  obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
>>>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
>>>
>>> Still results in +1 KiB.
>>
>> The above patch works great! I've tested it on 3 Kirkwood boards: the
>> Pogo V4 (88F6192), Zyxel NSA325 (88F6282), and GoFlex Home (88F6281,
>> same SoC as the Sheevaplug).
>>
>> The Sheevaplug is now 498K, which is well under limit. All these
>> boards see only 1K increase in binary size.
> 
> Can we please get a patch of the latter option now for the release and
> look at doing the .S file for the future? Thanks!

https://lists.denx.de/pipermail/u-boot/2025-June/592785.html

Regards,
-- 
Jerome
