Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757CBC47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 12:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A920A8747A;
	Tue,  2 Jan 2024 13:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="err7dUh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6625C8747A; Tue,  2 Jan 2024 13:51:05 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4788187128
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 13:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so53297615e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704199861; x=1704804661; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fhWCkr7KYy/BtOXz9Pfz7Vb43dnCbhDWjZp9qtUHu0w=;
 b=err7dUh28aqsocLKJoK7M22ZMYCO/bMglYA0RWxRasKrawoWcmEJx7p6ToeL4GWcbA
 mz24KOoP2IXbBW2Z9WU0VikBtbMsu8nnPGqF5ZIwwUJaDFSmwDq89WwqHuGB9240F1pj
 9pBEwmT8qeQq3UNTV+UcBANavxN7HO6ybRhtHBaF+7yjRudezfoKccUNgex78PAAgdTH
 0GFV3c6/eu8ReFxJaXfghW96t8qHX9Vpgfo2YprHQgGXVIHu7geAsuBtkHiEwnRZJMkU
 f5L/oNmz84L4MX/8xdW5nbpPKmTjPgfM3Y+cEO8kJY4ssNfG17z3iDey/c0NdHK8ck7O
 AaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704199861; x=1704804661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fhWCkr7KYy/BtOXz9Pfz7Vb43dnCbhDWjZp9qtUHu0w=;
 b=V3KsWqvVNPDsKvUwz3RWE6pU8r5mr4XBeSRRkAzX7CdAvMHE9fzElOnmmiFs2C6jmM
 MlTkbgP054yrrY4BZhPuCmf4pQ4YNiZ9TnfWfgP0CyXGsj2x8C7KTVdWoCjuXGv/sw4z
 FfoWmq3rn/PI+wzrearTFQaWO5lz77YaaDK5DPe/pszyeDDBFW+y7d08QyFKpccqSnl5
 A0+Qjg3xiS672qzfE1RLcbvti6Q9oGYQftMxyL0IBDkhh+vP97ADdfPUbJh/9tqdjmr0
 SuCA+GFI9L/2sPP3ggeYcVfaCQb9cw5NEIzz9nT03LKfyGwPofJ2sGJRLxa0DP3C2tJ8
 mUhQ==
X-Gm-Message-State: AOJu0Yx3B9HHMS0mhrHBJSJZXCJXQ50IycFjcHL1qZhq+MBvT1BPlxUA
 a0dk+EEMw5vauke8eVV3miuoiky95/aniA==
X-Google-Smtp-Source: AGHT+IGxXNdX7GI0iRHERB0fiEQkwsAgzM6e5ETceMxKfQby68vcFIYP6EYpI4TQNL1XfsVERmBaxQ==
X-Received: by 2002:a05:600c:198f:b0:40d:5f64:748b with SMTP id
 t15-20020a05600c198f00b0040d5f64748bmr4342264wmq.61.1704199861648; 
 Tue, 02 Jan 2024 04:51:01 -0800 (PST)
Received: from [172.30.140.140] (gateway.braid.business. [82.66.147.134])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a056000055000b003372dcd739csm9176259wrf.86.2024.01.02.04.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 04:51:01 -0800 (PST)
Message-ID: <a2393800-ea34-48f4-9300-5a2821cec7e7@linaro.org>
Date: Tue, 2 Jan 2024 13:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>, sumit.garg@linaro.org,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
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

[snip]
>>>
>>>>> However, I am very much in favour of having a generalized U-Boot
>>>>> image. This might become true in some cases like U-Boot acts as a
>>>>> second stage bootloader for a particular SoC which is a unified image
>>>>> where the prior stage passes the DT to it. The Qcom effort in this
>>>>> direction can be an example here.
>>>>
>>>> Not relevant to the topic at hand, perhaps, but Qualcomm uses a
>>>> closed-source blob to jump to U-Boot and is certainly not an example
>>>> we should emulate. But yes, passing a DT to U-Boot proper can be
>>>> useful.

Just to chime in here, this limitation is true for production Qualcomm 
devices where all of the bootloader blobs are signed by the OEM (true 
for most phones). But for development platforms we can do better. I 
expect this is a topic we will keep on coming back to, so I'd like to 
just take the time to explain some of the technical details on Qualcomm 
platforms, as there is a lot more nuance than you might be aware of.

The modern Qualcomm boot chain is (roughly) PBL (bootrom) -> TZ/el3 -> 
sbl1 (secondary bootloader) -> hypervisor -> XBL_Core (UEFI impl) -> ABL 
(LinuxLoader.efi app) -> Linux

On production devices the best we can do is replace "Linux" with U-Boot, 
and if we're lucky then we can leverage features of ABL to simplify 
things like DTB selection (it supports picking from a bunch of 
concatenated DTBs, but we can just as easily implement some similar 
feature in U-Boot ourselves).

On a development board I have been successful in replacing the 
hypervisor with a stub and replacing XBL_Core with U-Boot - giving us 
EL2 and removing the entire proprietary UEFI stack. There is no reason 
that we can't go further than this.

The Qualcomm Chromebooks all run Coreboot, for sure on those it would be 
possible to use U-Boot much earlier (although there is still the 
proprietary XBL_Sec TZ blob).

The Dragonboard410c (and MSM8916 SoC overall) has been pretty much 
entirely ripped open thanks to Stephan Gerhold and the msm8916-mainline 
project. On these devices it is easily possible to run U-Boot as a 
first-stage bootloader (at least to the same extent one can on the more 
open ARM platforms, or even more open if you wish). Although the 
bootloader of choice for most of these devices is a home-grown fork of lk.

For new SoCs, with the number of Qualcomm devices out there, and 
communities like postmarketOS enabling support on so many of them... My 
hope is that we will quickly see phones being the most common Qualcomm 
devices supported by U-Boot. While it is indeed extremely unfortunate 
that we can't replace the bootloader entirely, using U-Boot as a fresh 
slate is still extremely liberating (EFI! Firmware updates! No need for 
distro hacks to update the kernel! Multi-boot! etc...). I wish we could 
focus more on how U-Boot will make supporting Linux on these devices SO 
SO much easier, and less on how broken the (usually impossible to 
modify) bootloader they shipped with is.

While almost all of the boot chain I explained above is proprietary, the 
ABL source code is publicly available (although most device vendors 
don't publish their modified production version, I suppose for fear of 
embarrassment). The statement "Qualcomm uses a closed-source blob to 
jump to U-Boot" is at the very least an oversimplification.

To be contrarian, here is an example of a phone vendor who do publish 
their ABL source code, here is the code that runs Linux (or U-Boot in 
our case).

https://github.com/SHIFTPHONES/android_bootable_bootloader_edk2/blob/sos-3.x/QcomModulePkg/Library/BootLib/BootLinux.c#L1039

My point is, there is a lot of nuance and complexity here, and we need 
to be careful about what exactly we're referring to.

Kind regards,
Caleb

>>>
>>> It's a very valid use case we need to continue to support. And to save
>>> Mark from having to repeat himself, again, it's intentionally and not
>>> changing, how the Apple M1/M2/etc platforms boot. I'm pretty sure the
>>> fact that one can use U-Boot this way is part of how engineers get proof
>>> of concept work done to show that if they had U-Boot available then they
>>> could also support X/Y/Z easier. And maybe they'll be able to longer
>>> term push internally to use bloblist to pass things along.
>>>
>>> Heck, trying to not go too far off on a tangent, maybe the m1n1 loader
>>> can implement both conventions, as both Linux Kernel[0] and Bloblist[1]
>>> use x0 for device tree, but bloblist has x1 non-zero and Linux does not,
>>> so both could be present here? Or is there some incompatibility I don't
>>> see on quick skimming?
>>
>> Right.  Some time ago I suggested Simon to lobby the Linux kernel
>> folks to change the arm64 Linux kernel entry convention to state that
>> x1 can be non-zero in which case it points at a bloblist.  If that
>> happened I'd probably do the work to make m1n1 pass a bloblist.  And
>> it would probably make the folks who want to directly boot a Linux
>> kernel from TF-A (without going through U-Boot) happy as well.
> 
> I got a lot of push-back on that. Perhaps there might be some
> willingness if it is explained that Linux doesn't need to understand
> the bloblist, just tolerate it being there. There are probably other
> people who will be more successful at pushing for kernel changes.
> 
> As you know, the handoff protocol is designed such that you don't need
> to decode the bloblist to find the devicetree. BTW I would like to put
> the ACPI/SMBIOS tables in the bloblist as well (with EFI we would
> provide pointers into the bloblist for Linux to use)
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
