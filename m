Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6F1C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F34E340640;
	Tue, 21 Jul 2026 08:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iv2Q8bcctaZp; Tue, 21 Jul 2026 08:13:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B47540845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784621627;
	bh=PFnUSnTYIqs4/NNB8WkzIk/IPtN5d2ikSdJ52xYvSBY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KrBEvXG3OnWaubhSEb3i3zTi9d8y88PaNAOBM2vPdIWUnlLxLXvTlMEtLSHNYp4IB
	 3UhdkEoYOQVXyHZ9e1rbotBHvtIo6TRQMpFXub+B35MF/orxSOBzwhRDIuwMvMgJ8/
	 e8uLIAA3FZSfZrAC79wCHfJyW/ISEYHd8Sr2pPnhWCAvMzxdK0oZ4T28WgQkbc2sV2
	 XSHEZE/UMDZB7xayNtrlCkVeRqoKpGEb9z6poqC7FrKTXRenKNFe9jcvlxAMChjGQy
	 crF9YV/Zn+grz85wFz77+qlZm5R9y1nxmbLUmQHSXiy6PHxQMUx7ccoakVtuFyXo2M
	 m6t3Cx0BKrNRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B47540845;
	Tue, 21 Jul 2026 08:13:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AC3E96C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AEE180C16
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KlNFzcpMThzY for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:13:45 +0000 (UTC)
X-Greylist: delayed 592 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 08:13:44 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AC28B80BF7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC28B80BF7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC28B80BF7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:13:44 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E836D3F62F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:03:49 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so10276499f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 01:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784621029; x=1785225829;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PFnUSnTYIqs4/NNB8WkzIk/IPtN5d2ikSdJ52xYvSBY=;
 b=FVe4C2onmEQ4/V7hWHjxPV0PW542potUgYVDgWeWpj8RQX1TeDRLlflwlozzmKdMGZ
 X76ZUSiNAUkJJ4BOOVzhsQBBrD72oAzBVc1oBWH7kWV8r1sL1A7xRJmRf3Uu5/bDsPjM
 KSVnj99OWVHcPeocq/DS6bgMeYnM1awzS3EA17/RjEHfGnZTeUhr6kC/Cy29s83YPX9p
 AYvi/fIw0NoLA/wrCYwQ3pTOHR23eX8qnvnuhH9MhjWt91gUTyKU++/Z1wRAOtLacmuv
 wLju6nVQ+2uqm4EL8bOH++UXUO4CNenEXIWrW/YALxUHF29qi21Bj+txYd/Vz0zxIA+C
 X1Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQuGR9sonIEfeoawATjvR4961USSpVTs/Swf8rR5cS+92FtqjtwzZ9ASEdu/aHm9aOHCGNQJo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwYekrr6mahc81uzR2weH4N4JbTNPSSF/ER4xR45sFaGWeFI10F
 tKwC/kwL0+5HdQGwGhXZwzIVK31oUr41kYwxAZREYlTsFcO1/uJjMbxMJcfZc0ccKnudpbIKf1d
 mcJOfPYya2zaFpahIwumPefW/M52pubkQL9Fw6ELKyaq0kaLcZUTrCGLEkDUxHtwqDhXJ3ijFIJ
 9WmFHtjXSsZQ==
X-Gm-Gg: AR+sD12xnN8z8DatfOionumfJpvuC9hsDU2SEFi/IPVMW4SextXt2HDuaWr5fE0m6S4
 mKtzfA3eYzXiE9L+LDBFrl8HVg01geoXepHeeDIxLy0+9mW/QSSRphVMkahnS7jQx1EkHToN0ph
 2nITPbub7fgcWZcAZPMe1fkxnvU+YrrR57OihixOkce0wuGswG+R+pzAMllySFarXwlDNkwBwOx
 HsqnWIdOx94SkS8GZv9vh/9gJ/8s/0hhnBV+oiXCnJYQ8E+18a2GW29OTDLBbfO0UVyHf4hqiLt
 Z7TxZzQ3CSPKQ7ju8MkpDAEK+iv3vLp+7IQt1u3ls7+ZaOyrizZofjuWY0l6YwvV2UFcRTAs2Qk
 u7gWOJMk3FSbejbe6Oz4PMlf6otzU7e8id7CGd1iwoTrVgB3BGhHeErKi7OSAt72yXQR7Y/fuT1
 Xn9qoSqB9/gw6+LeACRJAFPMvFQjgxm8/w
X-Received: by 2002:a05:6000:2991:20b0:47f:70f1:a577 with SMTP id
 ffacd0b85a97d-47f70f1a665mr9573085f8f.17.1784621029265; 
 Tue, 21 Jul 2026 01:03:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2991:20b0:47f:70f1:a577 with SMTP id
 ffacd0b85a97d-47f70f1a665mr9573029f8f.17.1784621028764; 
 Tue, 21 Jul 2026 01:03:48 -0700 (PDT)
Received: from [192.168.103.136]
 (ip-084-119-040-110.um24.pools.vodafone-ip.de. [84.119.40.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51c33sm31561048f8f.12.2026.07.21.01.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 01:03:48 -0700 (PDT)
Message-ID: <e62b0956-a7bf-4f92-b794-277aaef52713@canonical.com>
Date: Tue, 21 Jul 2026 10:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: set correct frame buffer address
To: Simon Glass <sjg@chromium.org>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, me@ziyao.cc, bmeng.cn@gmail.com,
 u-boot@lists.u-boot-project.org, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20260501150550.228937-1-heinrich.schuchardt@canonical.com>
 <ea87842c-75ce-4d39-9ae4-0f8b3b913ad0@canonical.com>
 <871pfudqns.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTiz7YtBtO3yMgVbRxfOSG3J9A+3oTCYuko9me5ona3ZGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784621029;
 bh=PFnUSnTYIqs4/NNB8WkzIk/IPtN5d2ikSdJ52xYvSBY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QxszjfMlP5zhkuvYaXP4xVDWr7q6fR/hRgc5wP76maBvlAaTSYlGxtkPVJueYv6z5
 jtab9vMptEDXgtPFpZv33YMDVjrbZ8FmP9/uh9IBBfYKO0y/DS3Mc1vdSvm9PFqDcA
 iATb3if7KZuoDAwoCWHX31W2PlnJqeFAA7KjDsZoR2PET7W9VSZHlgqus+ebrNkpNQ
 GjgQ63H3V/N3y5ig5fRjlPx2zMzHf6GF4C9J3zQIDb1GhU4BPlVhs81JOtIaDFmEZv
 mablD40YN3KLCfjJ+9cFFoBkl9uleonkGw20r5wtEj2IJmEllXOCZ+iTW8LkW+EzCC
 QBLqZ7mqCs5nEVK45+7ElUhpECVh6wHJughoHthNV36WSen2dJwQDxEVb30uFkrv8R
 XfaEkmIllTQQjKAJ8aWqQZHvZmqO0dbaHXeet9Vs1jJoRL2FCRrQKgWkAPpOiQ37OQ
 6TlV6q3ZJ+y1DSy/YPDGSl6Auug68gp8W+H01PPxz67ZY7h55Y85/6zZa4qMPamCZU
 3GZdxG5o6X/B3uhgqzMDsTA7WcYzCeKBe/0rjSK8Ek2sdDGK2VTjZjOPVIsUj6zApd
 EjPqlafrqNOXtQ0X1Hscf7xf5C24s7SUI48B2vSnL2luZOCMoe2dAr+xk4UoDt+9fc
 RJ8eSnfl6DEEq7Y90VRW9q04=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=QxszjfMl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

(resending as the the first mail had the old u-boot list mail address).

Do you have a real x86 laptop using U-Boot?

Best regards

Heinrich

> 
> Regards,
> Simon

