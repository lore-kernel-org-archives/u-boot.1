Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53449C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F3781273;
	Fri, 28 Mar 2025 09:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrN2SK9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD8781951; Fri, 28 Mar 2025 09:20:41 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B6D810F4
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so1435726f8f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743150036; x=1743754836;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PS58rRCw/9LhuUCAgjpBpEONvhJ8NBpzW6wXM6HFqeo=;
 b=MrN2SK9w+VVVm4f/+yuRrPiv0+WwEMcebUPH8aTdC8QfQoBX/LLb5pvPZ+q4KlRmMU
 o0kflRvyKlEtY8slDO5Ll3LJDjvOcV4r8TwuDGnMF/V9wixTH9akaOy+jb+e3XcGqCR6
 +DPXgGHeCo27/4Is4Us+MUHoITnq5EO2obDIDkpMVjUOgutg+z0l21TPliZpZZCC9VpU
 T1drZeOia5AQJptxYLrgUCgRY1ghzX7euG6JxYiJp3DpTshhplANcSmPSnolIsIfGjaa
 5h6jrhfH1+zf60RiIWgV3uHPYfPB2rFanXl18BSzY1jw8hcf/X+CqFru8lPCmJmwZaIM
 WGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743150036; x=1743754836;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PS58rRCw/9LhuUCAgjpBpEONvhJ8NBpzW6wXM6HFqeo=;
 b=vJGXoOkmKPJw6fopWO4eanuSdkbW3TgV+/qJgXPuMLuS2z/ffxdXT5u3Thw4/Bjo5W
 TvVAicTUXp6jU2uspV9frZ5t/SFPMaqLGPZMy17iTXU8/0ai7TPyzfxQoAxl22xgSIy9
 28P/U7SNNK8UojrvtjziWcSp5RAuo73tHhGSrwew7PihG/2yq1aT3Ga1UnQ7TGoYyEmt
 FGx7kjaypL56BKqoCEzAq6RsXe6CPvQCToxg6pWAN1ih9rPHKtquAyHmBTcMmEJLdRoe
 t5ekMVqZlTXwIek3QYGQsFEpl/1k9BPyyz7vcKInYEMG1jdE1J0RmKmXUySl5O9n0XPW
 uIdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR7kXOcMZsGE1+qjVf7u1oGbb4cPJIv3H8ecAKLXgaVNREIUcs6JMEUZKs3l10zk7GkD/SspA=@lists.denx.de
X-Gm-Message-State: AOJu0YycSszXt6cmQWVy3FqXh1ExMBr4VV4Pfc4jQfHjlT2b+FABlgbj
 U5uCacpNe/bfS163D19lvudZr5orw7ouaJkOV9t221qSQ78+kz6Q607h18/AxEg=
X-Gm-Gg: ASbGncuaGK74vrQCRJS11rw4J9TdpTcskvac9TGUYiZI5pr0peUdiHeOWz+mY4im4n2
 RwXvGXb404dXfNAixw2uSn0c49zJfkks12NXk68qVts4+2jEQqNDZVpNu/ZB4gt4Id4pDxVxMmW
 +GN8HaBI/vttnFNNJCefKinbDKT2iGrFM5UmNmUKYM+tXhIm5a7wGZtCAZKNAB5iCLFtRVmaWNi
 EH9A9JP9MT+qzgzd38vRSNB5cj4Ht2bmqvkljZG6CFMkfNWFB0IZNXqnVOmObgQSBi4QsPq+GdL
 R3i1C+T1Ycmte7et+7qTGHJmYohEH4n0NeBRq3fqXGsy4kzfJQrl+09tRt0B5o1y
X-Google-Smtp-Source: AGHT+IG3u0iNX+tBz/VHBpgGi6AM0BpUuMuJ0/TjH3cTZmg7stcY9ckWhfDsnLAm+3Ef1TssT/V6Ww==
X-Received: by 2002:a05:6000:40e1:b0:391:255a:748b with SMTP id
 ffacd0b85a97d-39ad1784903mr6127186f8f.39.1743150035982; 
 Fri, 28 Mar 2025 01:20:35 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a448dsm1844715f8f.100.2025.03.28.01.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:20:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: usb:composite: data abort on second ums launch
In-Reply-To: <8734eya8no.fsf@baylibre.com>
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
 <87v7rypcoy.fsf@baylibre.com>
 <CA+GyqeaFbV3BM-1YFW4iJ3nYSL5jXfRS+_Gg7AEUg9d1yxjSjA@mail.gmail.com>
 <87sen2pbsl.fsf@baylibre.com> <8734eya8no.fsf@baylibre.com>
Date: Fri, 28 Mar 2025 09:20:34 +0100
Message-ID: <87wmc98t2l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Zixun,

On jeu., mars 27, 2025 at 14:46, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Zixun, Marek,
>
> On lun., mars 24, 2025 at 18:40, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>
>> Hi Zixun,
>>
>> On lun., mars 24, 2025 at 18:33, Zixun LI <admin@hifiphile.com> wrote:
>>
>> resetting ...
>
> [...]
>
>>
>>>
>>> Each time when ums is called 2*FSG_BUFLEN, 256kB buffer is allocated
>>> and it seems not
>>> freed as fsg_common_release() is not called.
>
> There are quite a few things that are wrong in
> drivers/usb/gadget/f_mass_storage.c
>
> 1. The "Synchronous Abort" exception happens because we call
>    kfree(common->luns); and common->luns is not allocated via
>    malloc/kmalloc.
>
> 2. We use a kref member that's unused and can be removed
>
> 3. There is a memory leak (as reported by Zixun) when unbind() is
>    called. We should call fsg_common_release().
>
> I will send a series to fix this.

Series send out here:
https://lore.kernel.org/u-boot/20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com

Available on patchwork:
https://patchwork.ozlabs.org/project/uboot/patch/20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com/

If you could have a look and test it yourself, that would be greatly
appreciated.

If doing so, you can reply to the above thread with: "Tested-by: Name <email>"

>
> Zixun, thanks again for reporting this and helping me reproduce!
>
> Mattijs
>
>>>
>>> Zixun
