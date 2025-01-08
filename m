Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68475E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC597805FB;
	Wed,  8 Jan 2025 18:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RBLCqSgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D3480654; Wed,  8 Jan 2025 18:03:11 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39B78006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so9961966b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355787; x=1736960587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JyuZFeeTyKncS2hbAhqOAub+69l3+KVcyeo+Y1AyAH0=;
 b=RBLCqSgPfMe9sovRdXb3IsPo1b00qzUvrNrtqRAhT3xO5fN/euTORI0dYZu7iW+FkA
 ssOndk6kImS3xwJfptLN/VdaewvPBRoX6icIaufRTwFT2KYBX3WxJHFwiustJKdR5bb7
 kM5+fxVFGdVhV/tNbavM+Lns4pwIMI8PniVCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355787; x=1736960587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JyuZFeeTyKncS2hbAhqOAub+69l3+KVcyeo+Y1AyAH0=;
 b=rkGT6Fvpd5b5KXGpwLveAmdd+FY6H/jlg/jUw0sPK3Y8GaW+ZQ14LQdJ8lw0ZYWYdq
 C4NdZtggVFobEafZwXLtsb5x0NAqGfrVOKy62HVVkSwZVhDHspnMrnkwd2cEUkyBKWyW
 AWC6QDW8z2xIg/mjsJclaCr1ZFiymEozFXhieLiKoS7/cK4vLdIQlWzAod4MVATYh84l
 u3Ld116tQDFNJ2B4Fggt21ghn4n1WkbfTGnw3Bk+ki/8PvImWXRegEErF42PCjSk+haU
 UOdukbib405jkBZXj8V0kiS3sPxMp+R8/CtepWcpbAflFPkeM7hWocqFFbk68mFWeZNN
 4MYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB/GsYiJk4BugB8O5hSznCYn1lYzDXM0nBGmFSJTS9Bkxtmy0PSDtn2ytCLE8aWP45yqnQoP0=@lists.denx.de
X-Gm-Message-State: AOJu0YxK2zo8i1ey2utI1aNQFBOr6xbGOl6HXTx6WdkMppUSZp2G8w3D
 pgxIyBlyX4yTQ24g8uvHc2CVxjR42BLQ3gzWL0kf0Mtk97pKf/bJU321Qk+4RvbWxVlFz2P2/aY
 9aHSJBUD6OdFRqqTpK9VEM/QUs+hhUZvKVtgP
X-Gm-Gg: ASbGncu963Ivzo5ewJnVqkokyZzSwBoAErMY06rIXnQCHKC4uEJLM5zvWS4noGcPw4t
 hzbPZSpTTIIRNYWuJi8z4QVGQXbHJuPpVHbWO7jg=
X-Google-Smtp-Source: AGHT+IEHsm07yXUjSXwjGDfq5r9kpbrWm78sQ29GNhwWUZ1rxtDnZn/VFbbu2Ox1aORUwVkIMEZbmOwcgkF8xn7m4xc=
X-Received: by 2002:a17:907:2d8d:b0:aae:c159:9e10 with SMTP id
 a640c23a62f3a-ab2abc78decmr334166266b.42.1736355785663; Wed, 08 Jan 2025
 09:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
In-Reply-To: <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 10:02:52 -0700
X-Gm-Features: AbW1kvZ7soaTC1bViuHbS5EBLyh_an3o6sv4s9qXdOjtBMsd5xyJqwdkiWnbltw
Message-ID: <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Marek Vasut <marex@denx.de>,
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

Hi Heinrich, Tom,

On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.01.25 16:11, Tom Rini wrote:
> > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> >> Hi Heinrich,
> >>
> >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>
> >>> On 07.01.25 13:15, Simon Glass wrote:
> >>>> Hi Heinrich,
> >>>>
> >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>>>>
> >>>>> On 06.01.25 15:47, Simon Glass wrote:
> >>>>>> This test was hamstrung in code review so this series is an attempt to
> >>>>>> complete the intended functionality:
> >>>>>>
> >>>>>> - Check memory allocations look correct
> >>>>>> - Check that exit-boot-services removes active-DMA devices
> >>>>>> - Check that the bootflow is still present after testapp finishes
> >>>>>>
> >>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> >>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> >>>>>> call the bootm function instead, with suitable modifications. That would
> >>>>>> allow bootstage to work too.
> >>>>>>
> >>>>>> This series is based on sjg/master since the EFI logging was rejected so
> >>>>>> far.
> >>>>>
> >>>>> Yes, it was rejected because a solution at the lib/log.c level would be
> >>>>> more generic.
> >>>>
> >>>> As I mentioned, that idea isn't suitable for programmatic use.
> >>>
> >>> What can be done with show_addr("mem", rec->memory); that log_debug()
> >>> does not offer or which you could not do with a new log function in
> >>> lib/log.c that takes variadic arguments?
> >>
> >> There are asserts in [1], for example. How do you propose to handle
> >> that? See [2] for my previous explanation, quoted here:
> >>
> >>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> >>> to programmatically scan text...plus only the external call sites are
> >>> actually logged.
> >>
> >> Also see the discussion on the original patch [3]. There was also your
> >> reply at [4], but I think you missed that this is intended for use in
> >> unit tests (i.e. with ut_assert()).
> >>
> >> You also requested that this be generalised, rather than being
> >> EFI-loader-specific. I have no objection to that, but don't have a use
> >> case for it yet, so have deferred that to later. It's a fairly simple
> >> change, if/when needed. If the series was not NAKed, I'd be happy to
> >> do it now.
> >>
> >>>>
> >>>>>
> >>>>> Tom suggested not to send patches that are for private enjoyment to the
> >>>>> mailing list.
> >>>>
> >>>> My contributions to U-Boot are only ever about private enjoyment :-)
> >>>>
> >>>> Do you have any comments on the patches?
> >>
> >> Regards,
> >> Simon
> >>
> >> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-6-sjg@chromium.org/
> >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
> >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
> >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2@gmx.de/
> >
> > Looking at the logging portions of the original series again, especially
> > if this was made generic, we probably don't want to print to actual
> > console every time we're making a note of some memory allocation for
> > example, that would be unreadable outside of a debug context. The point
> > of this really seems to be "log things for verifying in tests later".
> > Does that end up being useful? I don't know. Heinrich or Ilias, do the
> > tests in [1] look generally useful?
> >
>
> The tests in [1] are not documented, not even in the commit message. So
> the reasoning behind the tests remains Simon's secret.

Are you asking for code comments in the test? If so, I can add some.

>
> At first sight the tests in [1] don't make much sense. E.g. that only a
> subset of memory types have been used does not tell that the right
> memory type has been used for the right object.

It is a pretty good start, though. It makes sure that the memory types
are sane, checks addresses are within DRAM, etc. With [5] it makes
sure that devices are removed.

>
> Implementing a specific tracing functionality for EFI is definitively
> the wrong way forward as it will lead to code duplication.

We can cross that bridge when we come to it.

>
> We already have function _log() which is variadic.
>
> Simon could write a new log driver that parses the `format` parameter
> and saves the binary data in an appropriate format for analysis by the
> unit tests:
>
> * For %s the driver should save the string and not the address of the
> string.
> * For %pD the driver should save the device path instead of the pointer.
> * ...
>
> Some changes to the log driver interface will be needed to pass the
> variadic arguments instead of the formatted message.

Perhaps the word 'log' is confusing people. But the above suggestion
is quite a complicated way of handling things. We have no way to
decode printf() strings in this way. See log_dispatch() for how this
is handled today. It uses sprintf(). Trying to test based on text
output would be very clumsy (lots of regexes and sscan() calls?) and
result in a huge amount of parsing code, highly dependent on the
printf() format, etc.

I very-much doubt that would produce a useful implementation, but if
you would like to try it out then I would be happy to look at it.

I mentioned this several times, but even if we did go that way, we
only have logging on the external calls, so much of the EFI-memory
allocation in U-Boot would not be logged.

Regards,
Simon

[5] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-9-sjg@chromium.org/
