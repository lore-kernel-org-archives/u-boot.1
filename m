Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA131C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 11:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E7488180;
	Fri, 10 May 2024 13:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AfqramUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B7D8811C; Fri, 10 May 2024 13:23:49 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF18588180
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 13:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so438291166b.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715340226; x=1715945026; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9xIW9zNLWwQXIgGWEMPG1F03jnpqbNUMiIInSIVTCo=;
 b=AfqramUSNTZJCUc0ulM4K5jZUPjSwFMxDx28M78hNc1v1cLgLEvcepo6F1/nK73e1f
 5xxFpjvUBs0TUzOSeijOCSXkJoqDzaB/2Iln3FpZ1EfKZvhYXzD2wnbZNxoBIvRgHgkU
 1pkLiqP4J5US6vNxbLqD4MPVKzHBu2Fad8+abfyZZACMXHa8W/jvBH8Av9Zj/Nq0sjBG
 c0wQCSyttibSaRwJFGIdjrj7rzs/bXkexwqPdFDQfAv/QVW7cNfN3Ao0qMbXKGQn6Oe/
 EjYLONOtcJJ9I14oBLH4LjstI0zjBte+Y8rd/w9jHIkgta21XcJ15fhWz5T8f0AmkAXa
 BZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715340226; x=1715945026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9xIW9zNLWwQXIgGWEMPG1F03jnpqbNUMiIInSIVTCo=;
 b=tTtbj6g2GpiuydFdi0IIKA+X1Pp0E3gZtLeGzsT/M/wmxUxSXk4nIinwr2Hby06PN7
 buU2G6LIylRphMBzInmMrtpbX2iFTKmiYBOMhyiiIeo4Ytmqxj7U7CwVSuVLKVbC6UGY
 7+/t2Qd7gNY2tN8kmcdyuqoaXo4tkWkiULwOrxsLb+/oODVnMb6iQBhZ08f5lglppvy7
 wBbhNW9ma0JZRNNIIanAYik3ZWFitaWwQtPfSuNWTCUhFhxfPlBVYOrtuExd+y6leJiO
 6whSExDJVv4mpgpFxOCnm7T1V+JZlsZ5saLPEP7QYs1FYqlLoLGibkLMCcvatSpG2qH/
 FEUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmeHgWZaVU1Tt6ndne03U9aoZjezcfolyxy+5pfQJ+7E0Q9MvdzMNmaVOMj2Tgr4Jm7vGSRSfNVUrLcSjV5bupJbgD1A==
X-Gm-Message-State: AOJu0Yy96oO47xvPn4jHBEsQOZwYSVMJSb6N+BxTR6bCAdPtM7Rp+cHh
 JjsgwiJs0gPCqx6ceMfabcUFrXCK/WKG0REukuxQCg7GhtPtmeBQ2E/abXYs8hs=
X-Google-Smtp-Source: AGHT+IERqGBpPdKa6HGdhjLwhZss+IiRHxFvNFRSib657WP8V3QadwoEN1jnWy0i5aEwqHTPLefzGQ==
X-Received: by 2002:a17:906:aa4d:b0:a59:c23d:85d8 with SMTP id
 a640c23a62f3a-a5a2d6653f4mr152178866b.51.1715340226365; 
 Fri, 10 May 2024 04:23:46 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894e90sm173673466b.70.2024.05.10.04.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 04:23:45 -0700 (PDT)
Message-ID: <9f1d5e8a-65ab-4418-a9e0-029097a03189@linaro.org>
Date: Fri, 10 May 2024 13:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
To: Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
 <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
 <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
 <81f02041-6cf8-439c-b7a2-9edbfe038de6@linaro.org>
 <CAFA6WYN+2wtsyAtKNw5C_JSQyjHLNH3Bcbdr1FtizGFtS-vg7g@mail.gmail.com>
 <bHzxMz4-ns_UBmX6JiIwBdVyoBiKFJgmxJSqZptJjmGEmRNpYH7d0pv1MAIvvZQM-DnSgLud9Ws6B3HIs-XqxyptALQuCqECNRr1HZf_iak=@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <bHzxMz4-ns_UBmX6JiIwBdVyoBiKFJgmxJSqZptJjmGEmRNpYH7d0pv1MAIvvZQM-DnSgLud9Ws6B3HIs-XqxyptALQuCqECNRr1HZf_iak=@samcday.com>
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



On 09/05/2024 14:59, Sam Day wrote:
> 'Ello Sumit,
> 
> On Wednesday, 8 May 2024 at 4:48 PM, Sumit Garg <sumit.garg@linaro.org> wrote:
> 
>>
>>
>> On Wed, 8 May 2024 at 18:09, Caleb Connolly caleb.connolly@linaro.org wrote:
>>
>>> Hi Sam,
>>>
>>> On 08/05/2024 13:40, Sam Day wrote:
>>>
>>>> Salutations Sumit,
>>>>
>>>> On Wednesday, 8 May 2024 at 11:14 AM, Sumit Garg sumit.garg@linaro.org wrote:
>>>>
>>>>> Hi Sam,
>>>>>
>>>>> On Wed, 8 May 2024 at 00:11, Sam Day me@samcday.com wrote:
>>>>>
>>>>>> The newly introduced carve_out_reserved_memory causes issues when
>>>>>> U-Boot is chained from the lk2nd bootloader. lk2nd provides a
>>>>>> simple-framebuffer device and marks the framebuffer region as no-map in
>>>>>> the supplied /reserved-memory. Consequently, the simple_video driver
>>>>>> triggers a page fault when it tries to write to this region.
>>>>>
>>>>> How does the corresponding Linux kernel driver handle this?
>>>>
>>>> Firstly: I'm something of a middle-man here. I would consider Caleb the authoritative source on the carveouts stuff (since they wrote it) and Nikita Travkin the authority on the simplefb handoff (since he originally wrote it for lk2nd to hand off to Linux simpledrm and then adapted it to work with U-Boot simplefb).
>>>>
>>>> I consulted with Nikita on your first question here. He linked me to this snippet: https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/gpu/drm/tiny/simpledrm.c#L877
>>>>
>>>>> Is the
>>>>> framebuffer region required to be mapped as normal memory or device
>>>>> type or something else?
>>>>
>>>> So I guess based on the link above, it's just mapped as normal uncached memory.
>>>>
>>>> I tried to do something like this a few days ago in U-Boot, but a) it doesn't work and b) I have no idea what I'm doing: https://github.com/samcday/u-boot/commit/c100cb3711ddf5b01601691f3e6a9ec890d9a496
>>
>>
>> Can you start adding some debug prints as to what might be happening?
>> Also, look at my proposal below to hook memory mapping properly for
>> drivers.
> 
> I got to the bottom of the issue. This commit seems to work:
> https://github.com/samcday/u-boot/commit/25bf923c251b56d297d16898210fa36616294415
> 
> Calling mmu_set_region_dcache_behaviour alone is insufficient, as it
> does not change the "flags" of the page-table entry in the way that
> mmu_change_region_attr does. That's why it was triggering an abort
> in the previous attempt: __asm_flush_dcache_range was trying to scrub
> an entry that was still marked as PTE_TYPE_FAULT I guess :)
> 
>>
>>>> After talking with Caleb about this for a bit, they suggested the patch you see here as what I guess could be considered a "stopgap" solution that hopefully makes it into 2024.07.
>>>>
>>>>> Similarly would normal memory type work for
>>>>> all other reserved memory regions marked as no-map?
>>>>
>>>> I'll let Caleb weigh in here. My understanding is that the other regions should be marked as PTE_TYPE_FAULT because otherwise drivers might inadvertently speculatively access regions that are very much off-limits, such as TZ app regions.
>>>
>>> Right, carving out reserved regions and having the driver handle them is
>>> theoretically the "correct" thing to do here. But I'm not sure that the
>>> additional complexity offers much value from a U-Boot context.
>>>
>>> If we can teach the armv8 PT/cache code to handle this better, and teach
>>> all the drivers to map their regions on-demand, this would probably help
>>> us a lot (especially as right now if you attempt to access dead space
>>> between peripherals then you'll hang the bus...). But U-Boot is a ways
>>> away from that.
>>
>>
>> I am not sure if U-Boot is really that far away although you can say
>> the infrastructure is not hooked up for Arm. Have a look into
>> map_physmem() and unmap_physmem() utilized by various drivers which
>> are actually hooked up on MIPS. So I think the right way to approach
>> this feature on Qcom platforms is to start hooking up those APIs on
>> mach-snapdragon to begin with via mmu_set_region_dcache_behaviour()
>> underneath. We can always go ahead and make it more generic if needed
>> on other platforms too.
> 
> So I'm happy to explore this further in a separate patch. Such a patch
> doesn't seem like something that is suitable for inclusion in 2024.07
> at this stage, right?
> 
> If not, I'm wondering if there's any chance we can still pull this patch
> in as a stopgap measure? As it currently stands, the carveouts call is
> the *only* thing preventing msm8916 devices from booting U-Boot when
> chained from lk2nd.

This patches fixes simplefb on all Qualcomm devices, I'm going to pull 
it in and we can pursue other solutions down the line.

Thanks both,
> 
> -Sam
> 
>>
>> -Sumit

-- 
// Caleb (they/them)
