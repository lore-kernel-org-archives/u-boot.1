Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F883D69104
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 12:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEB7897F3;
	Thu, 28 Nov 2024 13:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gYocDcJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C364D8985C; Thu, 28 Nov 2024 13:33:40 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D77897DD
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 13:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cfc19065ffso921582a12.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732797218; x=1733402018; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRrJ9LdAjweqvmZUTUmqPoHFXxLF6p+3lo2Ih48iAyA=;
 b=gYocDcJje+vKgXTOBgCvOR1BOtDzktsbtWPGZ1KEKlDpiB6qviMIAW0zPMN7nzuMLk
 3+5yoSMK0cCtNM/4/GCF7Gko+IPhiL7Tjhe0KQuTs+oCi66zY7GMoOurn4jpDzOfCgYH
 xryuePz+KgwLDoDb3kl0mUNUHI+H9Vo/6ByAZXLqaBeeHt2rmRABcqd/q5MTMRNMzTuu
 ostNqkESduiBxT5dAqei+9U62jZT3mZTFzVWXrUcvssNEyyDpNjhZxZ3dqRhv0h2qlK5
 sRh3ZBQApDVGmqYrbtWlpfJkqzSWqTIIpNiK+3RzZBlCAnMtiC6+MpsXe06zXB+Ix9at
 oOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732797218; x=1733402018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRrJ9LdAjweqvmZUTUmqPoHFXxLF6p+3lo2Ih48iAyA=;
 b=HiVFuqwbqXabfOfosHaC8D/QWxNbORB/9A7efRTk41XUD6UgsmpTF5SrFKgbM29FPi
 XzZQenWkFzc4C3kRLVYQdgMRqjRuGPxgcA8dD0blPrrIrfdEOme6xin+HHLHULecR7Bu
 YcQMu9d3LwC0qy8PyDMZXFvrCDx09X1qOTtgQOQbh58cYf0w4kV65WwiODKnDac9Ts7B
 +Y85pG0QjDyHfC8ynIbElYc39ZsNIPFltJMeScSrOhiRj8s0HyX5phm3cF+Bs0izntOi
 pQN2SQL3Ni2dreJAO+2MaV+SVmdwdAqWlJwDvEbMaPMKba5xPcP60cMMMMZwHWbKLNhv
 RVYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4TvRIEtVY6F0kCc2hH52fwc7CHbhGuUzbXp4Ayz8RApUQ7sTTCjz2XT7AfqzFu2zYn3Pj5Gg=@lists.denx.de
X-Gm-Message-State: AOJu0YwqOeNkaNol7xsggUuewWTHq8TUaMCUdX2qP9R49J/8zFoRNAWe
 g76U9fMMnw2IbmFttToCaN2DGfWJHtbKZclSejzaDhSOKWf2213u5u/hZLA3XpM=
X-Gm-Gg: ASbGncvVQFcuZ6pD9aGPMSQWg1HaBaWgPP2LLS+v6wb3I4VliJc2nXKpG3s7oUNZBLc
 0bolbfF1uTtkWUgmImHS6caocee+77EC9OSqR9at/Pd7I7rOvLOUuKwmgyxVNDq4UVC4wokXRC7
 Qk26l1yeSNQSqckYZCdp7sWhgDb1/rE4WN7Czs80F3ug6m6qMG6p3cXLEHIHF1HOsoNlMFQ002x
 TSxuVfm9N6LU3hdBmrSuKtvQgSQIR3xpOtkSD6ihXnsFOLAhlJbuRYJCZZGGOCIfEcvmvQqnpny
 DF3O60AQ8d7/h/+SB/GO7cQOV/ingivy
X-Google-Smtp-Source: AGHT+IHjfBoauDl1HGCXpenlePbFMbJtbzNqQAuIfBxZCPTMi8lRGvqQ/CWGrm0rwynnXzW1I7MR/Q==
X-Received: by 2002:a05:6402:2712:b0:5cf:ac4f:83c4 with SMTP id
 4fb4d7f45d1cf-5d080bb5b3dmr6540495a12.12.1732797217840; 
 Thu, 28 Nov 2024 04:33:37 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d097eb1fe8sm682394a12.74.2024.11.28.04.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:33:37 -0800 (PST)
Message-ID: <482ea637-f8e2-4880-9125-19c7eba517a2@linaro.org>
Date: Thu, 28 Nov 2024 13:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: core: ofnode: safely fallback in ofnode_lookup_fdt
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241113052050.1862420-1-caleb.connolly@linaro.org>
 <CAFLszThAmn_NU-PoYopjx17Bk6QxgbFaCWJjKdMAG5JzLJWdEg@mail.gmail.com>
 <d89d7d04-8ff9-460d-844f-c85129c5ba77@linaro.org>
 <CAFLszThmRJZHzecSH1A9zS7f3oiS+kCB=jBarHOZG7RGv3gL_A@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThmRJZHzecSH1A9zS7f3oiS+kCB=jBarHOZG7RGv3gL_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 27/11/2024 18:51, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 27 Nov 2024 at 10:12, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 27/11/2024 17:52, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Tue, 12 Nov 2024 at 22:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Under some conditions it's possible to hit the null condition here like
>>>> when running with OF_LIVE and using the ofnode API before
>>>> initr_of_live() is called. There is very little null
>>>> checking for this in the FDT framework, so returning null here can
>>>> result in weird null pointer conditions.
>>>>
>>>> Instead let's return the control FDT in the fallback case, this is
>>>> usually what the user was expecting.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>  drivers/core/ofnode.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>>>> index 950895e72a99..7a7f25fc537c 100644
>>>> --- a/drivers/core/ofnode.c
>>>> +++ b/drivers/core/ofnode.c
>>>> @@ -152,9 +152,9 @@ void *ofnode_lookup_fdt(ofnode node)
>>>>                 uint i = OFTREE_TREE_ID(node.of_offset);
>>>>
>>>>                 if (i >= oftree_count) {
>>>>                         log_debug("Invalid tree ID %x\n", i);
>>>> -                       return NULL;
>>>> +                       return (void *)gd->fdt_blob;
>>>>                 }
>>>>
>>>>                 return oftree_list[i];
>>>>         } else {
>>>> --
>>>> 2.47.0
>>>>
>>>
>>> Eek I really don't like that, since it will silently return an
>>> unexpected value.
>> What's the unexpected value? The only caller for this is ofnode_to_fdt()
>> and the return value for that is never checked. It seems clear to me
>> that in practise NULL is the unexpected value here.
> 
> Firstly, it looks like ofnode_lookup_fdt() should be static
> 
> If a node offset cannot be found, that suggests that oftree_list[] is
> empty, which suggests that oftree_reset() has not been called yet.
> 
> oftree_reset() is called after relocation. Before relocation, it just
> assumes that the control FDT is being used.
> 
> I wonder if you are hitting this problem after relocation, in one of
> the functions in init_sequence_r[] before initr_dm()?

aha! Now I remember, mach-snapdragon has it's own enable_caches() which
looks at the DT to determine if we should do some additional work to
carve out reserved memory regions which some platforms might otherwise
speculate on triggering a crash.

I think this is also specific to some non-upstream patches I have which
use the ofnode API, since the current compatible check uses fdt_blob
directly.

Disabling OFNODE_MULTI_TREE works around the crash, which would be fine
since we don't currently use it on Qualcomm (I think?).

but it would be nice to solve this.

What about if we called oftree_reset() immediately after initr_reloc?

Kind regards,
> 
> In any case this does seem like a bug that we should fix.
> 
>>
>>> I think we should panic. Do you know what code path
>>> gets you here?
>>
>> Hmm, I don't exactly recall. Should really have made a note when I wrote
>> this patch :/
> 
> Yes, I know that feeling :-(
> 
>>
>> Guess I'll drop this from my dev branch and come back when I figure this
>> out again.
> 
> Yes OK. A patch which panics would be fine for now, if you like.
> 
> 
>>>
>>> More work is needed in livetree to sort of the rough edges, sadly...
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

