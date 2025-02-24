Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC0EC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD2F805C3;
	Mon, 24 Feb 2025 16:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="daaL5KXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C5880F5C; Mon, 24 Feb 2025 16:16:57 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52A4800B3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f2f748128so2045480f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740410215; x=1741015015; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ilrCmCIVMfhSTsHZXSQd4z0FXR9xQ316LdeaRBbSeg=;
 b=daaL5KXgcTMkU292aCLHYjp7UDl1RXOl+4l2HB9WI6FUml/EjzcmlhiEvx5xXMfK9w
 fXyvY4/0iedba5lkf2EEIMi6P6QcaSUy8GrTRo/fYZJFho1/Sbf04omJqy0bWTd1Eb7c
 uycLVeVOw6AO3T3qR6REL7vSH4J4QYB1t0HbJynR9cNkZTqajk1cmhogZ9qRVvmzJtxf
 fvd20AhCV6PEH8t9v1NkSSeCjzGFkcwSaCDVnd79Dvon6mBO7BO6YTYBZqCNzVZlYjia
 m3gCHerrSq/sFqV/Rfo+69H4ALDFBXJQCJov70o9XMQ4sXBfbNeLMS+SsFx6t8i5Aadw
 +dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740410215; x=1741015015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ilrCmCIVMfhSTsHZXSQd4z0FXR9xQ316LdeaRBbSeg=;
 b=pkCtXv6huoijsD0EvXE49b9ay3tM5/jJZzgNft+63k+0BiKbrwkhpm/aTtNBdNFLG2
 x8Ah67EIkOIErfK0h20M31iz7NsZlpuwGVJr7GiiiGJldgz7p7XMB+3Z/Kqca9Zl3hD2
 ojiB530YuClPKzXDjet3VvlDYgnWJPeOfezsxKNTzkEXjNsUdnekXBYwhjL13ulsWgPT
 tn43JeUAaTDDGLAyLkzq07u9QRPapU8TFEowjNxWhyM6YtpuiQ0ANPwggmItC0OWyvGg
 W8mbMoz21/DSAXH6inOJnx7oEdg1Usd11zDH856C6k5CzAtVxOA/vXa24xQVs54mfbv5
 jp0w==
X-Gm-Message-State: AOJu0YylxL2BfH1abqoTRnXf79FIfT2W/3/Ap/rNijBPZsmhAUk2d1D/
 DKMor/MsZRjjZEzZV400i970lAHPys++s4X5AG8M3qmUBlaIK3kquIE0WxHpERU=
X-Gm-Gg: ASbGncuPJtGlauVwzmuPS3shGk/iAxRYCGxITcMb3CuQINtDBnG95fGToC7Z3RHZMZe
 PPsq2HGvJZxaqzm+Ex94ghlQ29nqaitFseIAI6ZzFOAjV6SK+nlZSQniakVTOd9Rq2y9/R2/7Z4
 B0VyUUQYE63AR3SK94WcRTa3Imj74v+oru9PuUZ+EyZDTieF5wN0Qqs97HTRyCmi4VgdExi3ioL
 muFET0dBQ1ObQ+YJpWt0N5enfSSlnikr1qDZxjDLrOPBIOTyjcUEtxauDMjIgPgzxog+lNxIZTo
 kRKrNOvk41iWJ2AjyPAfpjByLNc1ni+IQmSmrCsZ06ajGlVonz4yMnhHEPeM06T1fklw0IimB0h
 BG6i/Shk=
X-Google-Smtp-Source: AGHT+IGl4EW+Bw+OxVgnJa0i31DlLro1V+MVnu80h97kREFz4Sugp7fcwAGEjO/EdXUDnGBeTr6vkA==
X-Received: by 2002:a5d:64e6:0:b0:38a:418e:21c7 with SMTP id
 ffacd0b85a97d-38f6f0ca200mr12374333f8f.53.1740410214992; 
 Mon, 24 Feb 2025 07:16:54 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:3974:dc91:a561:d080?
 ([2a0a:ef40:1d11:ab01:3974:dc91:a561:d080])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa1esm31584021f8f.100.2025.02.24.07.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 07:16:54 -0800 (PST)
Message-ID: <3db43c95-75a2-4416-93ce-d0aacb542193@linaro.org>
Date: Mon, 24 Feb 2025 15:16:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] coreboot: Move coreboot logic out of x86 to a
 generic place
To: Stephen Boyd <swboyd@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-5-swboyd@chromium.org>
 <20250221010658.GD1233568@bill-the-cat>
 <CAE-0n51YEq9VyJ94NsF0ovNh-pturMBKe89W+W7cPdQpbJoVsw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAE-0n51YEq9VyJ94NsF0ovNh-pturMBKe89W+W7cPdQpbJoVsw@mail.gmail.com>
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



On 2/22/25 01:17, Stephen Boyd wrote:
> Quoting Tom Rini (2025-02-20 17:06:58)
>> On Thu, Feb 20, 2025 at 12:58:46PM -0800, Stephen Boyd wrote:
>>
>>> Lay the groundwork to run U-Boot as a payload on ARM coreboot based
>>> devices. Move the coreboot table parsing code out of arch/x86 into
>>> lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
>>> to be globally accessible, so move them into the top level include
>>> directory. Introduce helper functions like
>>> board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
>>> dram_init_banksize_from_coreboot() so that boards can still override
>>> these common functions while also supporting booting as a coreboot
>>> payload.
>>>
>>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>>
>> I see how the abstractions get used later on. The rest of the examples
>> in tree today are of the form foo_dram_init / foo_dram_init_banksize, so
>> we should follow that form instead. And I'd be inclined, but I'd like to
>> hear Caleb or Simon's thoughts too, on just overloading the weak

This adds a 6th (!!!) possible way that U-Boot can be loaded on a 
Qualcomm platform, on top of:

1. Android chainload
2. in-XBL (replacing EDK2)
3. as-hyp (EL2)
4. as-tz (EL3 with TF-A boot info passed in)
5. EFI stub

While (4) and (5) aren't supported upstream yet, if/when we do add them 
we'll have 5 different ways of retrieving the DRAM layout

a. builtin FDT
b. SMEM (qcom memory database)
c. TF-A boot info
d. EFI memory map
e. coreboot boot info

So to this suggestion (and Stephens answer below): The way Stephen has 
composed this coreboot support makes sense to me since I can just look 
at mach-snapdragon and all the codepaths are there. I'd rather not wrap 
the whole functions in mach-snapdragon in an #ifndef, it impacts 
readability and also makes it quite hard for someone not familiar with 
U-Boot to figure out a) why this is done, and b) what functions get 
called instead.

I would eventually prefer it to be a runtime check rather than compile 
time, and the current proposal seems closest to that.

>> function we already have and when we don't, #ifndef CONFIG_SYS_COREBOOT
>> the existing snapdragon function. I suspect we might longer term need a
>> bit different abstraction here to make it easier to override things when
>> U-Boot is a payload and getting this information elsewhere.

Agreed, I think I saw a proposal recently to some info to the /chosen 
node for this. Not sure if that's the correct approach but I do agree 
that we should have some kind of API in U-Boot to let us collect info 
from previous stages and metadata so that we use it later to inform 
decision making.

>>
> 
> Ok. I struggled for a bit trying to understand the design of the weak
> functions. I'll rename it and have it overload when nothing is
> different. That means board_get_usable_ram_top() can override all the
> time. The dram_init() and dram_init_banksize() functions likely need to
> stick around though and be called explicitly? Maybe we can have some

I think Tom is proposing to wrap the entire functions in mach-snapdragon 
with #ifndef CONFIG_SYS_COREBOOT. Which as above I'm not super in favour of.

> sort of 'payload' level event hook so that depending on the payload
> that's detected we can call a function to setup memory.

It really depends how far we want to go for a generic build. It would be 
nice if we could source DRAM info from all available sources (since 
there might be multiple) and then pick our favourite. I think this would 
let us do a much better job at defining and documenting all the various 
combos we have in mach-snapdragon too.

-- 
Caleb (they/them)

