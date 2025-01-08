Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9115FE7719A
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13379800DF;
	Wed,  8 Jan 2025 18:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f7P9AWyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18FE8036B; Wed,  8 Jan 2025 18:03:01 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559EB8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so204824966b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355778; x=1736960578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yGM0NG1MouQFU0IshdoN3sNdIlCGqiFHk5lS7+sci6A=;
 b=f7P9AWylJ37XMbIoRQ3GgphAOvGFnycUqzFe0MnFEUxojUty9ROJc2fIpUTDSkKjhB
 HJ9No0lK7AWr0i/3w1IOOJnLH5ckNxAdAIlqux6Nx0aVUc49xMk9XaruuJc/KpmjPGk2
 7XzgruJGlH4F9gzzE9WbP20s1pq5xHNmWhZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355778; x=1736960578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yGM0NG1MouQFU0IshdoN3sNdIlCGqiFHk5lS7+sci6A=;
 b=IAN8iy7ip01U5ob0Hu9bqT8pNoXCxLOyExHThScT/+e1K9GEW456ga3eLmB/n4Qaow
 Cb6MhCpxZS/q9XFWV3Ih6AMH4r57wISnDw3/zDQ6zb8QmOpzUw0IJ4oKUk/LOxIGKd19
 Q4cce6g3wSRUfb8x0hTRoqX3wMQj5wCf8/Qgy2/sU9ugn8+G9PyrhmWBTrqfjpNyeFlU
 twbcOTOpFrfy+ZPEVLkUUikjnT6N+Tw65AYtYva8sBBWA5mmI2MzxZ6/ZP1oNMA9rsIk
 tQ/oI+qdHKi4M7kFX98yxneTMqKzTpsIhgZMhBzImYXWeYyI9RRljx1IQ4wTfqS9r8tF
 OzEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWInKxZ3Ani2FvdQNM3K3o/ASGR35v0WyHr0mpsQSKXatStgL6lBcgrsDTG+VY0gd8kt2+bTrg=@lists.denx.de
X-Gm-Message-State: AOJu0YyHUpNrC4OjAJrc3ioJckCNaCzzf82PAMiSU3Q0ODu2GyzU6Yj0
 dxQUssdnkRmzAULE+w1WSb4ryjbiCD1QETua4yUJGQFs5CQ7cWp7V+XwAyxACWNT64S+1amd4nz
 13sTIMM1qP422m80RFyplaqy/Ctvn8dYpjP0a
X-Gm-Gg: ASbGncsz3VfZydX48JZTnxuPPeGWf8h3GJ3uF2ZWaATjL7DXrbnLFSJWNC6E39z9sCm
 mHifr307WvsXXXbAKoZx1ic3mQyF141kA8+yIRp4=
X-Google-Smtp-Source: AGHT+IEJqrIHyIeYudmb7tyUwiP52N/iPi0QBwQqA+z5HyCPW5st7cAd15W4xqngbV48XqugyqfrxW5Zok2XcORLOsY=
X-Received: by 2002:a17:907:72d5:b0:aab:ef03:6d46 with SMTP id
 a640c23a62f3a-ab2c3c63f95mr4310166b.4.1736355775947; Wed, 08 Jan 2025
 09:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <39dcdeba-0314-4008-987d-306b63c3d0ea@linaro.org>
In-Reply-To: <39dcdeba-0314-4008-987d-306b63c3d0ea@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 10:02:43 -0700
X-Gm-Features: AbW1kvaUu_e1_fs5Vn2i66mpd_Ie4WlSs9Ly8Ca_djcOVeyo-0VoJnl-rIGHeRg
Message-ID: <CAFLszTiJ3vv+LJ0qrVsJQaBJOMw5tN0ADc0_u8cGCgc2qtUXpA@mail.gmail.com>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Wed, 8 Jan 2025 at 06:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 07/01/2025 16:47, Heinrich Schuchardt wrote:
> > On 07.01.25 16:11, Tom Rini wrote:
> >> On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> wrote:
> >>>>
> >>>> On 07.01.25 13:15, Simon Glass wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt
> >>>>> <xypron.glpk@gmx.de> wrote:
> >>>>>>
> >>>>>> On 06.01.25 15:47, Simon Glass wrote:
> >>>>>>> This test was hamstrung in code review so this series is an
> >>>>>>> attempt to
> >>>>>>> complete the intended functionality:
> >>>>>>>
> >>>>>>> - Check memory allocations look correct
> >>>>>>> - Check that exit-boot-services removes active-DMA devices
> >>>>>>> - Check that the bootflow is still present after testapp finishes
> >>>>>>>
> >>>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and
> >>>>>>> still
> >>>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would
> >>>>>>> be to
> >>>>>>> call the bootm function instead, with suitable modifications.
> >>>>>>> That would
> >>>>>>> allow bootstage to work too.
> >>>>>>>
> >>>>>>> This series is based on sjg/master since the EFI logging was
> >>>>>>> rejected so
> >>>>>>> far.
> >>>>>>
> >>>>>> Yes, it was rejected because a solution at the lib/log.c level
> >>>>>> would be
> >>>>>> more generic.
> >>>>>
> >>>>> As I mentioned, that idea isn't suitable for programmatic use.
> >>>>
> >>>> What can be done with show_addr("mem", rec->memory); that log_debug()
> >>>> does not offer or which you could not do with a new log function in
> >>>> lib/log.c that takes variadic arguments?
> >>>
> >>> There are asserts in [1], for example. How do you propose to handle
> >>> that? See [2] for my previous explanation, quoted here:
> >>>
> >>>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> >>>> to programmatically scan text...plus only the external call sites are
> >>>> actually logged.
> >>>
> >>> Also see the discussion on the original patch [3]. There was also your
> >>> reply at [4], but I think you missed that this is intended for use in
> >>> unit tests (i.e. with ut_assert()).
> >>>
> >>> You also requested that this be generalised, rather than being
> >>> EFI-loader-specific. I have no objection to that, but don't have a use
> >>> case for it yet, so have deferred that to later. It's a fairly simple
> >>> change, if/when needed. If the series was not NAKed, I'd be happy to
> >>> do it now.
> >>>
> >>>>>
> >>>>>>
> >>>>>> Tom suggested not to send patches that are for private enjoyment
> >>>>>> to the
> >>>>>> mailing list.
> >>>>>
> >>>>> My contributions to U-Boot are only ever about private enjoyment :-)
> >>>>>
> >>>>> Do you have any comments on the patches?
> >>>
> >>> Regards,
> >>> Simon
> >>>
> >>> [1] https://patchwork.ozlabs.org/project/uboot/
> >>> patch/20250106144755.3054780-6-sjg@chromium.org/
> >>> [2] https://lore.kernel.org/u-boot/
> >>> CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
> >>> [3] https://lore.kernel.org/u-boot/
> >>> CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
> >>> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-
> >>> B11F-85958065BCD2@gmx.de/
> >>
> >> Looking at the logging portions of the original series again, especially
> >> if this was made generic, we probably don't want to print to actual
> >> console every time we're making a note of some memory allocation for
> >> example, that would be unreadable outside of a debug context. The point
> >> of this really seems to be "log things for verifying in tests later".
> >> Does that end up being useful? I don't know. Heinrich or Ilias, do the
> >> tests in [1] look generally useful?
> >>
> >
> > The tests in [1] are not documented, not even in the commit message. So
> > the reasoning behind the tests remains Simon's secret.
> >
> > At first sight the tests in [1] don't make much sense. E.g. that only a
> > subset of memory types have been used does not tell that the right
> > memory type has been used for the right object.
> >
> > Implementing a specific tracing functionality for EFI is definitively
> > the wrong way forward as it will lead to code duplication.
> >
> > We already have function _log() which is variadic.
> >
> > Simon could write a new log driver that parses the `format` parameter
> > and saves the binary data in an appropriate format for analysis by the
> > unit tests:
>
> Isn't this precisely what monkeypatching is for in unit tests? imho this
> does not make sense as a logging API but expanding FTRACE to have more
> capabilities (like Linux trace has) so that it can save arguments and
> then having some nice interface to assert that certain functions were
> called in a certain order with certain arguments would be a scalable way
> to go (and surely useful in other cases too).

Yes, that would be nice.

>
> Honestly though it seems quite wrong for the bootflow test to inspect
> EFI memory allocations, these are completely different levels of API and
> any tests like this are going to be prone to breaking over time just
> because they're making assumptions across so many layers.

It certainly is a bit odd. My goal (not necessarily shared with
others) is to ensure that EFI memory-allocations are only done if an
EFI app is booted.

But if you look at the checks here, they do make sense. If someone
allocates memory of a different type, we would want to know about it.
If an allocation was outside the range of DRAM, ditto. I actually
would *not* expect these tests to break with future changes. The
bootflow_efi test is specifically targetting the EFI layer. I suppose
you could say that it is also testing bootstd in general, but there
are many other tests which are much better at that. So this test is
taking a bit of a look of what EFI is doing under the hood.

Anyway, I'll keep developing the idea, on and off, and we'll see where it goes.

>
> Kind regards,
> >
> > * For %s the driver should save the string and not the address of the
> > string.
> > * For %pD the driver should save the device path instead of the pointer.
> > * ...
> >
> > Some changes to the log driver interface will be needed to pass the
> > variadic arguments instead of the formatted message.

Regards,
Simon
