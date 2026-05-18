Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1FBCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 06:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB3384659;
	Mon, 18 May 2026 08:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cU3Cs/Nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B64384659; Mon, 18 May 2026 08:21:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A12383AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A1333F60E
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779085311;
 bh=H2XSqHqfwnyka6E63R1JJFDWlawfFbLZ+6ijFSWLkoo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cU3Cs/NxNEvRXA59D941HKTkfuVdJSm0d8PrleoVovBh0+px5/31sx9ne4nXG3GoC
 vw1qazCFe45F732tuIcGJj43rGtqttVp/9qGA+bXs3wuKtcORCjJ9M4IDVAtU+GC62
 lCe87ZTbcU0hbo9tTMWTvvZZbICO71QdA1xEk4gYWgmePKrsvbg8+8kceVmTClbzls
 YpBCnzzoBwnTO7tlyv4foKlMFOn3jEA4Hq7YZOy54cIB58ZXCZBwve5mRHw7b1A9rD
 yHEBEYjtwuGaAf+Foo0i0K5e9L5j4p4zNaAqEdQi4h51i88GPL/FB8PWQ/d4siFrWf
 vWSfvkWX198Y8TRVQfcjUO3BkEFRaKqRTJ8u5FVcjBIYqSPAXaogpTYTDkfcmmVTeN
 5pz2e73o2XruTgEcqNYMmicjZIUta+XDeiyZgCUJ65C55ckwrFmgsfTSXiEt/GpgWH
 tbzQNjk2h6gv9xT5cnm9Iu5Y5EytknoekPKnfcBr0Zsv/2MwmMeqFhVFJM9urCnVY4
 2aEO/jICBErrZypxnzfLPMP5ATZkJiwH1HnEebI+fZSeSoRU6KfQR2r9PetLzlfR7B
 0CGAIAgHGuTp+K9SSt1HqX+eNLLVvgVGKfbE5xKTNkMFVSdHZBckAGHMfTb1wqb+ly
 yyHbJmG2tdWse9FFhvs731qM=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fed2519daso9824235e9.0
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 23:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779085311; x=1779690111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2XSqHqfwnyka6E63R1JJFDWlawfFbLZ+6ijFSWLkoo=;
 b=kPZ0IHxrElgwHm9xhfuO2z/kXnrxgDegNI12QheoF9o7g9EdQC4aNxgxpVnv159jDH
 d51jq86B7I3lv8Ta7thMno3mP9Fkgw0YMMby785rJr2fewuo8LetCzWU/7savQgovvCV
 ou+DZmKP2VM+wLCvwb+cQTM28BH44GJtrM4lBClUmg9oayE1cLbVCyV1Joc2gM1tbg27
 L6at3w2xv4s6uv4+rJTNK7BuW+NmOvEiVDbVnZrZcL2/oebspBWz6yym3WyJL3ng3SiE
 LImEgBKfJimcmkUXuQH0gSomkSnx9AFvOlTer6CxxZKOyJki66yKWRN9kxKJYfOKD+L+
 Mr+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ82zq0whZDWuMNqgQQ0xE6cyoLNEwn99sIagalG5BDGtWLy2Evmeaw09oC0W/N/Wcp95SZZ/ik=@lists.denx.de
X-Gm-Message-State: AOJu0YzZd+Izmpj+7Fcm+vYxox618zq7I40/7OQlycdeJMokqSxo9NEZ
 2C86aSY8nCFjB/KHN2PncX9Qpq7IR+lgoYjQZKxwX4EDrr7l25RskQaVA6QWEpIQT6cahodPULY
 H5igOisjK2C3GsE1T0IICLabPHK0sdWDdn+0u5NqFP8aAUIttO/Fy/ZVpsYGdyv2Ewx+uQxI=
X-Gm-Gg: Acq92OHdyC8FlOUkdNPIk4wc9KbFK68h/cHqGa/L/1Hfx4q6akG4q+XjmSDtbgQTeBo
 wMI5+18kBBb5u9XX3Y0kTu1aqcuIt5he0gBRUAJdNo/MVOKq7LpPzrtWPDSh2WiQjOYWXmK7u9N
 dz/KSjGamwVsXthgJ7ZRzof8jKl5oUoNPW+Rni7Z9dGWKlfAFwmSUUSafRZkNm2yPvyU9Uz1H4b
 4zWmjEV8w3X+8SzthFeWrGFWSJRXxTYH/+D0Ek0Y2ZYr7zzecEq7ZEYrAU59afqJdiDg9aBMZUq
 7akVkgyVr/LWvfoY2YfWG4xpKxbXDTLb1MlB+CDb9481IB6aAkS5mqbfoWOmqOndOpHwYZrn4/J
 pEgrh9iustW+I0K7iA9N3ws7wsCsB8H/nChbrlkCIbIQwmSln2z5kmcGRSeu5o/sBouBYpi0J6R
 NkPTP4MmABSFBdAYKa5zUF8p9+RL7Z5oAcC/UJWzuNh2E24dg7CYmW
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id
 5b1f17b1804b1-48fe6626cfbmr207031425e9.31.1779085311132; 
 Sun, 17 May 2026 23:21:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id
 5b1f17b1804b1-48fe6626cfbmr207031005e9.31.1779085310739; 
 Sun, 17 May 2026 23:21:50 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e8:f446:93b2:f50f:3c1e:870?
 ([2a02:3035:6e8:f446:93b2:f50f:3c1e:870])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm76754495e9.1.2026.05.17.23.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 23:21:50 -0700 (PDT)
Message-ID: <2aba13e3-89b2-4713-ba2e-5350e2a0a495@canonical.com>
Date: Mon, 18 May 2026 08:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, me@ziyao.cc, bmeng.cn@gmail.com,
 u-boot@lists.denx.de
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
 <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
 <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
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

On 5/2/26 15:04, Simon Glass wrote:
> Hi Heinrich, Mark,
> 
> On Sat, 2 May 2026 at 04:58, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>
>>> Date: Sat, 2 May 2026 09:28:56 +0200
>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> Hi Heinrich,
>>
>>> On 5/1/26 17:05, Heinrich Schuchardt wrote:
>>>> If we use video copy, bit image transfers need to write to the in memory
>>>> copy of the physical frame buffer. Damage control will sync the changes
>>>> to the physical frame buffer.
>>>>
>>>> Cyclic video copy will catch all changes done by EFI applications directly
>>>> accessing the frame buffer copy.
>>>>
>>>> gopobj->mode.fb_base must be a valid pointer to memory and not a virtual
>>>> sandbox address.
>>>>
>>>> With this change the block image transfer test works again on the sandbox.
>>>>
>>>>       setenv efi_selftest block image transfer
>>>>       bootefi selftest
>>>>
>>>> Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    lib/efi_loader/efi_gop.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
>>>> index 9403e09691e..ae44d140289 100644
>>>> --- a/lib/efi_loader/efi_gop.c
>>>> +++ b/lib/efi_loader/efi_gop.c
>>>> @@ -471,7 +471,7 @@ efi_status_t efi_gop_register(void)
>>>>    {
>>>>      struct efi_gop_obj *gopobj;
>>>>      u32 bpix, format, col, row;
>>>> -   u64 fb_base, fb_size;
>>>> +   u64 fb_size;
>>>>      efi_status_t ret;
>>>>      struct udevice *vdev;
>>>>      struct video_priv *priv;
>>>> @@ -490,7 +490,6 @@ efi_status_t efi_gop_register(void)
>>>>      row = video_get_ysize(vdev);
>>>>
>>>>      plat = dev_get_uclass_plat(vdev);
>>>> -   fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
>>>>      fb_size = plat->size;
>>>>
>>>>      switch (bpix) {
>>>> @@ -528,7 +527,7 @@ efi_status_t efi_gop_register(void)
>>>>      gopobj->mode.info = &gopobj->info;
>>>>      gopobj->mode.info_size = sizeof(gopobj->info);
>>>>
>>>> -   gopobj->mode.fb_base = fb_base;
>>>> +   gopobj->mode.fb_base = (uintptr_t)priv->fb;
> 
> Don't you want to use copy_fb (if VIDEO_COPY is enabled) so you get
> the hardware address?

Yes, that is what we can do together with PixelBltOnly.

> 
>>>
>>> I discussed the value of FrameBufferBase with Simon.
>>>
>>> The code before the patch is incorrect, as on the sandbox it does not
>>> provide a pointer value but a sandbox virtual address. EFI applications
>>> may use the pointer for directly writing to the frame buffer. This would
>>> lead to a crash on the sandbox.
>>
>> I still think this means that EFI on sandbox is fundamentally broken.
>> The identity virtual-to-physical mapping assumption is just too deeply
>> engrained in the ecosystem since that is the documented handoff state
>> for most architectures.
> 
> The ACPI tables have the same issue (needing to pass a pointer within
> sandbox's emulated RAM buffer) and we use nomap_sysmem() to handle
> that.
> 
> In what way is it broken?
> 
>>
>>> For the case of CONFIG_VIDEO_COPY=y it is problematic to pass the memory
>>> buffer address here, as Linux has an EFI framebuffer driver and would
>>> write to the buffer instead of the physical framebuffer. But our memory
>>> buffer is neither reserved memory not is it copied to the physical
>>> framebuffer after ExitBootServices.
>>
>> Right.
>>
>>> If we pass the physical framebuffer address here, then an EFI
>>> application might write to it and the cyclic video sync would overwrite
>>> the changed pixels.
>>>
>>> Setting PixelBltOnly in field Mode.PixelFormat forbids EFI applications
>>> to directly write to the framebuffer.
>>
>> That means the framebuffer becomes unusable as soon as the EFI
>> application calls ExitBootServices() since an EFI application can't
>> call Blt() after that

The EFI spec does not specify how you may detect or access the 
framebuffer after Exit boot services.

Operating systems have their own graphics drivers. Once they are loaded 
you should get output.

>>
>>> So if plat->copy_base is set we should pass PixelBltOnly as PixelFormat
>>> and copy_base as FrameBufferBase.
>>
>> If PixelFormat is PixelBtlOnly, FrameBufferBase is meaningless and
>> probably should be set to 0 instead.
>>
>> Anyway, as far as I can tell there aren't a lot of OSes that support
>> PixelBltOnly.  OpenBSD certainly doesn't.  And as far as my reading of
>> Linux's efistub code is correct, it doesn't support it either.  And neither does u-boot's own efi_video driver.
>>
>> I've always seen PixelBltOnly as a way to support weird hardware that
>> didn't support a linear framebuffer with a sane pixel format.  Not as
>> a way to support a shadow framebuffer like CONFIG_VIDEO_COPY
>> implements.  Note that CONFIG_VIDEO_COPY itself assumes a linear
>> framebuffer with a sane pixel format as it just does a straight copy
>> of the pixels.
>>
>> Instead of using PixelBltOnly, can we just disable the shadow
>> framebuffer as soon as we hand over control to an EFI application?  Or
>> maybe at the point where the EFI application uses the GOP protocol?
> 
> This seems like a good idea to me - the latter would be best since it
> won't impact apps which only use console output. The impact would be
> that U-Boot will need to read from the hardware framebuffer with
> write-combining enabled (slow on x86) but at least it is correct.

We use the shadow framebuffer because output is incredibly slow on some 
machines without it. This does not depend on whether we are running an 
EFI application or not. So disabling the shadow framebuffer when an EFI 
application runs would not be helpful.

Best regards

Heinrich

> 
>>
>>
>>> We the aforementioned change we will need to change function
>>> gop_get_bpp() to not rely on PixelFormat. Instead we need to pass
>>> priv->format in a private field of the graphics protocol.
>>>
>>>
>>>>      gopobj->mode.fb_size = fb_size;
>>>>
>>>>      gopobj->info.version = 0;
>>>> @@ -553,7 +552,7 @@ efi_status_t efi_gop_register(void)
>>>>      }
>>>>      gopobj->info.pixels_per_scanline = col;
>>>>      gopobj->bpix = bpix;
>>>> -   gopobj->fb = map_sysmem(fb_base, fb_size);
>>>> +   gopobj->fb = priv->fb;
>>>
>>> priv->fb is also the value used by the TrueType drivers.
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>      gopobj->vdev = vdev;
>>>>
>>>>      return EFI_SUCCESS;
> 
> It would be worth testing this on a real x86 laptop to make sure it
> can still boot Ubuntu, etc.
> 
> Regards,
> Simon

