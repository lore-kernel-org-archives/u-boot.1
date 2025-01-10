Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9E7E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC522801F5;
	Fri, 10 Jan 2025 14:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DzuHxm8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A635F8036B; Fri, 10 Jan 2025 14:40:58 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD4D800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so3325771a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516454; x=1737121254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CLvN/Vi9pevWZ7huKhXayukBhREKbHzXN02hZ3pYu5k=;
 b=DzuHxm8dw+xZgcdGjnjv2pI+EtQQYwUpEYt1GSVIEPokudK3Ug91wVH6iQXgRxU0DV
 mNvgwU2ygDOKxnDVNigz/nazj1t0G53DX2g07IyZlyMedg0J4DX+22M+shHdkr4i+y+8
 QHrW20wBDLJpbQ71F5eydg5qsDhYThL90vqUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516454; x=1737121254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CLvN/Vi9pevWZ7huKhXayukBhREKbHzXN02hZ3pYu5k=;
 b=SDcrT2J9NAHzwPpWEsftQYfKneNIUeeI3jOX+kLBy5zwFWb3hWEKBs2Iva8ONesjLT
 lCUlZV6E700PoZdDdC3niYZoyMA9FRVa8N2p/7NDtGyDYSNBN6LAe4oJ1oM614ufxMs6
 0uHwmZjKYQ0ku92xZRMk9xxfyRlFPz/mmsmey778+TQIU/C+B1elebKNbakxWLbepnvf
 HHdD7Oa3t/KRKV708rt9v3yEDACQU1IhSuXrBJOIKGG3OjzQo7mtOdrz5vObSoXvd6c2
 XMwx5EW0PkcRWEPZG/8npvsJd9IzEWbGw74MKa2jI3daquqJr4yPijW7fPXsYUjOkU1x
 5yHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2zXK8HR66n2bzOfobkbJCDcpQyfSh3YcY8nOPjB7dIL713unLLazqFJzbX8QxD9klSKHMh14=@lists.denx.de
X-Gm-Message-State: AOJu0YwGKS4H4VqCDT0FeYKP38Toj6fTNzANEC9zjgo3KZI2+/9mSQAw
 McYuEIyD2ne0bFIGwKRPtVb/YKkHjyJrxWPVK2Z3Q64cG3FkoptwFAv0EogDLPURA9P53Iv+32u
 2WbdnxgRqFi9Hut4PAV7Xi36OtEqJ7F8PiJeY
X-Gm-Gg: ASbGncv3sKAeqN0u23wF4EDN01f6p9mVSrumCNKkcv19PzpcWHwv1ZG819A0tz6Yy0E
 KzNsw5bcvlb+KIHMFyFr6rVxFuKJ35tMxU/+0yUM=
X-Google-Smtp-Source: AGHT+IFaUUOGjCOEB4RvmXSMF66bLj6He4L4cu13+yU9xI5XaKJtmg6mOSxqq8/l3Ol7wOtrhcoUMZXjvMh0Xo9DILc=
X-Received: by 2002:a17:90b:2d44:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2f5490a9e79mr15917648a91.29.1736516454096; Fri, 10 Jan 2025
 05:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
 <20250108191457.GQ3476@bill-the-cat>
 <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
 <20250109165121.GZ3476@bill-the-cat>
In-Reply-To: <20250109165121.GZ3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:40:37 -0700
X-Gm-Features: AbW1kvZsgfSbz4rHXI5rdKgmQPn0-lcUsbfqdb4z13Mqw-icwjtoe48sf3Gyxoo
Message-ID: <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
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

Hi Tom,

On Thu, 9 Jan 2025 at 09:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 08:02:01AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 8 Jan 2025 at 12:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> > > > Hi Heinrich, Tom,
> > > >
> > > > On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 07.01.25 16:11, Tom Rini wrote:
> > > > > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> > > > > >> Hi Heinrich,
> > > > > >>
> > > > > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >>>
> > > > > >>> On 07.01.25 13:15, Simon Glass wrote:
> > > > > >>>> Hi Heinrich,
> > > > > >>>>
> > > > > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >>>>>
> > > > > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > > > > >>>>>> This test was hamstrung in code review so this series is an attempt to
> > > > > >>>>>> complete the intended functionality:
> > > > > >>>>>>
> > > > > >>>>>> - Check memory allocations look correct
> > > > > >>>>>> - Check that exit-boot-services removes active-DMA devices
> > > > > >>>>>> - Check that the bootflow is still present after testapp finishes
> > > > > >>>>>>
> > > > > >>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> > > > > >>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> > > > > >>>>>> call the bootm function instead, with suitable modifications. That would
> > > > > >>>>>> allow bootstage to work too.
> > > > > >>>>>>
> > > > > >>>>>> This series is based on sjg/master since the EFI logging was rejected so
> > > > > >>>>>> far.
> > > > > >>>>>
> > > > > >>>>> Yes, it was rejected because a solution at the lib/log.c level would be
> > > > > >>>>> more generic.
> > > > > >>>>
> > > > > >>>> As I mentioned, that idea isn't suitable for programmatic use.
> > > > > >>>
> > > > > >>> What can be done with show_addr("mem", rec->memory); that log_debug()
> > > > > >>> does not offer or which you could not do with a new log function in
> > > > > >>> lib/log.c that takes variadic arguments?
> > > > > >>
> > > > > >> There are asserts in [1], for example. How do you propose to handle
> > > > > >> that? See [2] for my previous explanation, quoted here:
> > > > > >>
> > > > > >>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> > > > > >>> to programmatically scan text...plus only the external call sites are
> > > > > >>> actually logged.
> > > > > >>
> > > > > >> Also see the discussion on the original patch [3]. There was also your
> > > > > >> reply at [4], but I think you missed that this is intended for use in
> > > > > >> unit tests (i.e. with ut_assert()).
> > > > > >>
> > > > > >> You also requested that this be generalised, rather than being
> > > > > >> EFI-loader-specific. I have no objection to that, but don't have a use
> > > > > >> case for it yet, so have deferred that to later. It's a fairly simple
> > > > > >> change, if/when needed. If the series was not NAKed, I'd be happy to
> > > > > >> do it now.
> > > > > >>
> > > > > >>>>
> > > > > >>>>>
> > > > > >>>>> Tom suggested not to send patches that are for private enjoyment to the
> > > > > >>>>> mailing list.
> > > > > >>>>
> > > > > >>>> My contributions to U-Boot are only ever about private enjoyment :-)
> > > > > >>>>
> > > > > >>>> Do you have any comments on the patches?
> > > > > >>
> > > > > >> Regards,
> > > > > >> Simon
> > > > > >>
> > > > > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-6-sjg@chromium.org/
> > > > > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
> > > > > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
> > > > > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2@gmx.de/
> > > > > >
> > > > > > Looking at the logging portions of the original series again, especially
> > > > > > if this was made generic, we probably don't want to print to actual
> > > > > > console every time we're making a note of some memory allocation for
> > > > > > example, that would be unreadable outside of a debug context. The point
> > > > > > of this really seems to be "log things for verifying in tests later".
> > > > > > Does that end up being useful? I don't know. Heinrich or Ilias, do the
> > > > > > tests in [1] look generally useful?
> > > > > >
> > > > >
> > > > > The tests in [1] are not documented, not even in the commit message. So
> > > > > the reasoning behind the tests remains Simon's secret.
> > > >
> > > > Are you asking for code comments in the test? If so, I can add some.
> > > >
> > > > >
> > > > > At first sight the tests in [1] don't make much sense. E.g. that only a
> > > > > subset of memory types have been used does not tell that the right
> > > > > memory type has been used for the right object.
> > > >
> > > > It is a pretty good start, though. It makes sure that the memory types
> > > > are sane, checks addresses are within DRAM, etc. With [5] it makes
> > > > sure that devices are removed.
> > > >
> > > > >
> > > > > Implementing a specific tracing functionality for EFI is definitively
> > > > > the wrong way forward as it will lead to code duplication.
> > > >
> > > > We can cross that bridge when we come to it.
> > >
> > > Well, no. It's backwards to make a bridge in one place when everyone
> > > agrees it needs to be moved somewhere else. I mean [5] is a generic
> > > issue and test/py/tests/test_net_boot.py or some other test we already
> > > have which tests booting an OS should confirm that we've quiesced
> > > devices before moving on. And as a bonus it's in python where dealing
> > > with strings doesn't suck.
> >
> > I really don't want to write C tests in Python. CI is slow enough as
> > it is, something realy want to fix. I'm also not sure how you can tell
> > if a device has been removed. Run 'dm tree' and look for the missing
> > 'star' in the resulting 300 lines of text?
>
> As I'm in a bisect-hell in our C tests you'll have to forgive me for not
> thinking the C tests are noticeably faster than python tests. Or that
> they aren't their own potential source of corner-case bugs. But I
> digress..

Welcome to my world. I bisected my lab devices so many times to try to
isolate all the breakages that have crept in. What is the problem,
maybe I can help?

>
> And yes, taking a bunch of text and parsing it, is what python is fast
> at. And easier to write.
>
> > But actually [5] is not generic, since EFI uses its own code to remove
> > devices. This test is solely focussed on EFI.
>
> Yes, you're testing the EFI version of the code in
> arch/$(ARCH)/lib/bootm.c. The remove devices functions being called in
> both cases are generic.

The code in EFI is:

if (!efi_st_keep_devices) {
bootm_disable_interrupts();
if (IS_ENABLED(CONFIG_USB_DEVICE))
udc_disconnect();
board_quiesce_devices();
dm_remove_devices_active();
}

It does call somewhat the same functions, but is doing its own thing,
not even using the arch-specific code. As I mentioned, a nice clean-up
would be to make bootm_announce_and_cleanup() common.

Actually, now that I see efi_st_keep_devices, I wonder why Heinrich
didn't want my ANSI patch[6] which serves a similar function.

>
> > If you want the logging to be renamed and placed centrally I don't
> > mind doing it now. But note that only EFI will use it for now.
> >
> > >
> > > >
> > > > >
> > > > > We already have function _log() which is variadic.
> > > > >
> > > > > Simon could write a new log driver that parses the `format` parameter
> > > > > and saves the binary data in an appropriate format for analysis by the
> > > > > unit tests:
> > > > >
> > > > > * For %s the driver should save the string and not the address of the
> > > > > string.
> > > > > * For %pD the driver should save the device path instead of the pointer.
> > > > > * ...
> > > > >
> > > > > Some changes to the log driver interface will be needed to pass the
> > > > > variadic arguments instead of the formatted message.
> > > >
> > > > Perhaps the word 'log' is confusing people. But the above suggestion
> > > > is quite a complicated way of handling things. We have no way to
> > > > decode printf() strings in this way. See log_dispatch() for how this
> > > > is handled today. It uses sprintf(). Trying to test based on text
> > > > output would be very clumsy (lots of regexes and sscan() calls?) and
> > > > result in a huge amount of parsing code, highly dependent on the
> > > > printf() format, etc.
> > > >
> > > > I very-much doubt that would produce a useful implementation, but if
> > > > you would like to try it out then I would be happy to look at it.
> > > >
> > > > I mentioned this several times, but even if we did go that way, we
> > > > only have logging on the external calls, so much of the EFI-memory
> > > > allocation in U-Boot would not be logged.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [5] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-9-sjg@chromium.org/
> > >
> > > Yes, calling this a "log" when it's intended for capturing information
> > > for tests got some of this off on the wrong track. But that also helps
> > > explain now that this is still on the wrong track and should instead be
> > > following normal design practices for testing and expanding existing
> > > infrastructure and not inventing a new everything. So if you don't like
> > > Heinrich's suggestion, take a look at Caleb's suggestion.
> >
> > I don't have the energy to port the tracing framework from Linux to
> > U-Boot, although I agree it would be useful. Still, function tracing
> > is quite fragile and confusing to work with when refactoring code. I
> > don't like that idea much for this use case, although if function
> > tracing did exist in U-Boot I would likely have used it.
>
> I mean yes, it would be good if you went back and expanded on the trace
> functionality you did before.

I still don't believe it is the best solution and seems like yet
another ocean I should avoid sticking my heater into.

>
> > > And if you
> > > don't like Caleb's suggestion, go put this in a topic branch you can
> > > merge when you need to debug some problem that seemingly nothing else
> > > will catch.
> >
> > Here we are over a year after I reported the bug and we still don't
> > have a test to cover it. This series is better than the available
> > alternatives, IMO.
>
> Well, no. We have commit dabaa4ae3206 ("dm: Add
> dm_remove_devices_active() for ordered device removal") we have a test
> for the underlying problem. We need more functional boot tests, but we
> need those to be in python too, and not more C code.

That is a nice improvement, but did not fix the underlying problem.
The underlying problem was that EFI was calling exit-boot-services,
causing U-Boot to free up data structures which were needed to boot.
This was on x86_64. I never quite figured out which one (very hard
when you cannot get back to U-Boot to check).

There were quite a lot of problems, actually. There v2 series is at [7]

Only a C test can check what actually happens inside U-Boot.

>
> And you're not just coming up with a test, you're refactoring a bunch of
> code and introducing new subsystems in order to do that. When as I keep
> pointing out, we don't need that. We could easily extend the existing OS
> boot tests we have to script booting an ISO. And we only run those when
> say "ENABLE_SLOW_TESTS" is set, and only do that on tagged releases.

Yes of course we need to refactor to make tests work. This is not
necessarily a bad thing, as it helps us break code down into testable
chunks. We cannot rely only on large functional-tests, not that you
are suggesting that. See [8], but they are too slow, too hard to debug
when they fail. They also tend to devolve into chaos as people get
lazy and stop writing unit/smaller tests.

Regards,
Simon

>
> --
> Tom

[6] https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
[7] https://patchwork.ozlabs.org/project/uboot/cover/20240806125850.2316956-1-sjg@chromium.org/
[8] https://circleci.com/blog/testing-pyramid/
