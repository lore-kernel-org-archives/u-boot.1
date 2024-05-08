Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83A7C25B77
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F448843F;
	Wed,  8 May 2024 14:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTPasW5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F648869A; Wed,  8 May 2024 14:39:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B791988306
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so993694866b.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715171985; x=1715776785; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NwuH+P5r+qaT6VT8sFEYcQNhkA0mKNBFV6BLR4T8GqY=;
 b=lTPasW5kZu7jSMkU42sbfoOF5JPew2T7qHZKs+TQXbbmEX0iiyqHq6GRRwvLc/fSfT
 FnYHRYjcrFi/dP1YRr20QHp2witFHUrO7MDKe89k7ojz0SD5KuS++y/atkTlWB5bK3ME
 1c6l2zu2XygwbuJTh0elDPPBdda2SIBKJkNBITwNdQMlnq2gx66fGUqCneStySvfAXqT
 ajsIJoA6QEMtVDjVaoayDfGOrAmHcQ6jxEMj34zosWxqPh8M2ZK5KNCBImQsMnba7UwU
 ba1fp3eOduw+El5MdWZr9o+IuHVD/sUujaKft4Pqy5rzjIrSY+Dl0FtHITGWBBUROBJu
 ezLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171985; x=1715776785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NwuH+P5r+qaT6VT8sFEYcQNhkA0mKNBFV6BLR4T8GqY=;
 b=lZ6GTDfwB2i3CKXf8r/9FLw7VL7Y0cE0hS9F1Hzb9G+DNwJJX8sOZd6Aou1gPCQdbI
 H7P0Zg24thd2S+SsksCx/QDMpwXtYRMqcVyopriGxjgGMeS6e8eJIWsLleKTFASuPkqQ
 kX79PZ/gRK5XVRGltPa3HXcuSt+mAt7tXd0Wo3THfrKo6e8CocFxxmJEk0b9w2u9RFzK
 r23lJCoW7ndz6cPjbtvR6iVrmcWIHY9Rkg3Q4nqmDj10e6dXBNqfJrwQEpnlX7pz5PKc
 6+veYZNyOofZKyutnku7BrRB3qMfnm4IRj7J6phT/vOsJVbdClsg9sFIYaSfxfhvPDxc
 vmnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4PYSShhha1zW76Bi70CKA5p9lTCdfHpPNbUH3aGjBKfM+36vT1uYGcJm/VFK0jf0OtnPteI24tehngrDxhB+GRdie3g==
X-Gm-Message-State: AOJu0YzAhlXHY6QtBbPYqEygbQqk+3rM0D9R9cPZ9qzhNd79eDZtglqe
 MKKlUID6uMIeXVlFxR9mPxiqvwuRTeCXB5tBCYRn3h2UF7t+RRlxHBwM83iAKsM=
X-Google-Smtp-Source: AGHT+IGgJ6nld90jvmLQNlF/5M/I9F/vzXsld9SAtng5Argt+jH+Y8Yt6ETzbS/vbRPaSMbfljT6iA==
X-Received: by 2002:a17:906:a449:b0:a59:a0c1:b222 with SMTP id
 a640c23a62f3a-a59fb95d71dmr154306366b.39.1715171985137; 
 Wed, 08 May 2024 05:39:45 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 lk5-20020a170906cb0500b00a59cd2d802fsm3764334ejb.131.2024.05.08.05.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:39:44 -0700 (PDT)
Message-ID: <81f02041-6cf8-439c-b7a2-9edbfe038de6@linaro.org>
Date: Wed, 8 May 2024 14:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
To: Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
 <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
 <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
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

Hi Sam,

On 08/05/2024 13:40, Sam Day wrote:
> Salutations Sumit,
> 
> On Wednesday, 8 May 2024 at 11:14 AM, Sumit Garg <sumit.garg@linaro.org> wrote:
> 
>>
>>
>> Hi Sam,
>>
>> On Wed, 8 May 2024 at 00:11, Sam Day me@samcday.com wrote:
>>
>>> The newly introduced carve_out_reserved_memory causes issues when
>>> U-Boot is chained from the lk2nd bootloader. lk2nd provides a
>>> simple-framebuffer device and marks the framebuffer region as no-map in
>>> the supplied /reserved-memory. Consequently, the simple_video driver
>>> triggers a page fault when it tries to write to this region.
>>
>>
>> How does the corresponding Linux kernel driver handle this?
> 
> Firstly: I'm something of a middle-man here. I would consider Caleb the authoritative source on the carveouts stuff (since they wrote it) and Nikita Travkin the authority on the simplefb handoff (since he originally wrote it for lk2nd to hand off to Linux simpledrm and then adapted it to work with U-Boot simplefb).
> 
> I consulted with Nikita on your first question here. He linked me to this snippet: https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/gpu/drm/tiny/simpledrm.c#L877
> 
>>   Is the
>> framebuffer region required to be mapped as normal memory or device
>> type or something else?
> 
> So I guess based on the link above, it's just mapped as normal uncached memory.
> 
> I tried to do something like this a few days ago in U-Boot, but a) it doesn't work and b) I have no idea what I'm doing: https://github.com/samcday/u-boot/commit/c100cb3711ddf5b01601691f3e6a9ec890d9a496
> 
> After talking with Caleb about this for a bit, they suggested the patch you see here as what I guess could be considered a "stopgap" solution that hopefully makes it into 2024.07.
> 
>> Similarly would normal memory type work for
>> all other reserved memory regions marked as no-map?
> 
> I'll let Caleb weigh in here. My understanding is that the other regions *should* be marked as PTE_TYPE_FAULT because otherwise drivers might inadvertently speculatively access regions that are very much off-limits, such as TZ app regions.

Right, carving out reserved regions and having the driver handle them is 
theoretically the "correct" thing to do here. But I'm not sure that the 
additional complexity offers much value from a U-Boot context.

If we can teach the armv8 PT/cache code to handle this better, and teach 
all the drivers to map their regions on-demand, this would probably help 
us a lot (especially as right now if you attempt to access dead space 
between peripherals then you'll hang the bus...). But U-Boot is a ways 
away from that.
> 
> Cheers,
> -Sam
> 
>>
>> -Sumit
>>
>>> As per Caleb's advice, this simple patch only does the carveouts for the
>>> qcs404 SoC for which it was originally designed. The intent is to do the
>>> carveouts for more Qualcomm SoCs in future.
>>>
>>> ---
>>> I'm not sure if it's feasible to get this in for the 2024.07 release,
>>> but it'd be great if we could - it's the only thing that breaks U-Boot
>>> master on msm8916 devices that chain from lk2nd.
>>>
>>> Signed-off-by: Sam Day me@samcday.com
>>> ---
>>> arch/arm/mach-snapdragon/board.c | 12 +++++++-----
>>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>>> index 3d5994c878..b439a19ec7 100644
>>> --- a/arch/arm/mach-snapdragon/board.c
>>> +++ b/arch/arm/mach-snapdragon/board.c
>>> @@ -467,10 +467,12 @@ void enable_caches(void)
>>> gd->arch.tlb_addr = tlb_addr;
>>> gd->arch.tlb_size = tlb_size;
>>>
>>> - carveout_start = get_timer(0);
>>> - /* Takes ~20-50ms on SDM845 /
>>> - carve_out_reserved_memory();
>>> - debug("carveout time: %lums\n", get_timer(carveout_start));
>>> -
>>> + / We do the carveouts only for QCS404, for now. /
>>> + if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
>>> + carveout_start = get_timer(0);
>>> + / Takes ~20-50ms on SDM845 */
>>> + carve_out_reserved_memory();
>>> + debug("carveout time: %lums\n", get_timer(carveout_start));
>>> + }
>>> dcache_enable();
>>> }
>>>
>>> ---
>>> base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
>>> change-id: 20240507-qcs404-carveout-only-7a15bbf3fd89
>>>
>>> Best regards,
>>> --
>>> Sam Day me@samcday.com

-- 
// Caleb (they/them)
