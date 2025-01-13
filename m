Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D5C02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6155480628;
	Mon, 13 Jan 2025 20:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PC6i61TZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E14880027; Mon, 13 Jan 2025 20:02:02 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC61C805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso4813166f8f.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736794919; x=1737399719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cmu8JN5Y+Gd+RfP1UtIeh/pvkvVuhjKaldKCJ5O8T1M=;
 b=PC6i61TZ7fJas58Lw9DYjErwi62pEfTspfq6jJ2Z9A35zDEncefNipL3Dv1aw3oWQA
 hAmSyi8rs6a9USnYXa7qTHFFiZdcOWobVJMhPenmIguC6JGIg5oEmVSFN+dfFVjrwz4E
 ie7bZANxenKB8x7CBwdoD5lgKvJ0DgzBxswFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736794919; x=1737399719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmu8JN5Y+Gd+RfP1UtIeh/pvkvVuhjKaldKCJ5O8T1M=;
 b=jGZ96DR215qHa2qC6a3ne1w+rs/7R5Is2sy3lImNlKyo7LtdmZbD5wV97QcszIOD3L
 RcQM8bTlTlq5y/Uyq1vTpoQDl29rtRr5opIAszLRPo5OWRiZaDxxGRYcq0qROZ53Y7tF
 Q/OQLXZPQJThOJvTuEob73WqxuagpvabhVH1FPZ0sJKe6jGAvsLEeID5k8J9Ls5OaY65
 BNvnMp8G7uRFJfZfynhU5r/lr0GT8cQm2sy6A4QmJIwRw+6/jUT+TlTUkOowdd7PqmbV
 hgyQ2vqESzKgcrIELQaso6GytXOYCBGIr/MGPkuIPTueZ3b3d1peM60A+DipYLZzBGhv
 gc0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPuI/Yhb2Yc8Y7o9bWK32+MAWRtV1QTt6uGrqpMFYoAtNDfiw6mflTvpv2BI+YbRzPwJhT0sI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5n1AGEkhYUVJ2X6pkmLHVfAA5yzn+Su8e2xJshWN5drrSx3ce
 ASJze0LtWGHaNCvpzb85X/Zhi1nirlDb86hRvkLoeOQ8NUl5lhClr26qOh+IEc1q6f1T+OKV2It
 815Qtnn8PKxbmJt2yltxS2B8fXMZ8Y7Ez/66wU34LTJI8Z3A=
X-Gm-Gg: ASbGncsZdYRV/0GLV4L4s50hxpbjxx14DWsifc6ob4Tj6HV+4zn96yZyAJXPpBo4wAQ
 99Q5BL6vFtEq+vsbxuI87q8F4Tn2J1tMhpJPIW+c=
X-Google-Smtp-Source: AGHT+IExF04l7bedqqtzC3hR7OQ+HkLqGLTNC/4IUmaCNshH9/EgOoFs/Iy2yoJxN/wDebGtIptf99r3JVyEw7vMnsc=
X-Received: by 2002:a05:6402:4405:b0:5d4:35c7:cd7a with SMTP id
 4fb4d7f45d1cf-5d972e0b20cmr51545740a12.10.1736794908021; Mon, 13 Jan 2025
 11:01:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
 <20250108191457.GQ3476@bill-the-cat>
 <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
 <20250109165121.GZ3476@bill-the-cat>
 <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
 <20250110164829.GJ3476@bill-the-cat>
In-Reply-To: <20250110164829.GJ3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 12:01:36 -0700
X-Gm-Features: AbW1kvb12pvZt0pdV5sY87JqQclFBLQqkqV4SSN04FvhbLVwYh7rfQrSIIR_y74
Message-ID: <CAFLszThVjiDgi5_V0yRbWo2pbbv3LEZA4TM=dkiJTd8D6gTe=g@mail.gmail.com>
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

On Fri, 10 Jan 2025 at 09:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 10, 2025 at 06:40:37AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 9 Jan 2025 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 08:02:01AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 8 Jan 2025 at 12:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> > > > > > Hi Heinrich, Tom,
> > > > > >
> > > > > > On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 07.01.25 16:11, Tom Rini wrote:
> > > > > > > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> > > > > > > >> Hi Heinrich,
> > > > > > > >>
> > > > > > > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >>>
> > > > > > > >>> On 07.01.25 13:15, Simon Glass wrote:
> > > > > > > >>>> Hi Heinrich,
> > > > > > > >>>>
> > > > > > > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >>>>>
> > > > > > > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > > > > > > >>>>>> This test was hamstrung in code review so this series is an attempt to
> > > > > > > >>>>>> complete the intended functionality:
> > > > > > > >>>>>>
> > > > > > > >>>>>> - Check memory allocations look correct
> > > > > > > >>>>>> - Check that exit-boot-services removes active-DMA devices
> > > > > > > >>>>>> - Check that the bootflow is still present after testapp finishes
> > > > > > > >>>>>>
> > > > > > > >>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> > > > > > > >>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> > > > > > > >>>>>> call the bootm function instead, with suitable modifications. That would
> > > > > > > >>>>>> allow bootstage to work too.
> > > > > > > >>>>>>
> > > > > > > >>>>>> This series is based on sjg/master since the EFI logging was rejected so
> > > > > > > >>>>>> far.
> > > > > > > >>>>>
> > > > > > > >>>>> Yes, it was rejected because a solution at the lib/log.c level would be
> > > > > > > >>>>> more generic.
> > > > > > > >>>>
> > > > > > > >>>> As I mentioned, that idea isn't suitable for programmatic use.
> > > > > > > >>>
> > > > > > > >>> What can be done with show_addr("mem", rec->memory); that log_debug()
> > > > > > > >>> does not offer or which you could not do with a new log function in
> > > > > > > >>> lib/log.c that takes variadic arguments?
> > > > > > > >>
> > > > > > > >> There are asserts in [1], for example. How do you propose to handle
> > > > > > > >> that? See [2] for my previous explanation, quoted here:
> > > > > > > >>
> > > > > > > >>> CONFIG_LOG with a bloblist option would be a great idea, but it's hard
> > > > > > > >>> to programmatically scan text...plus only the external call sites are
> > > > > > > >>> actually logged.
> > > > > > > >>
> > > > > > > >> Also see the discussion on the original patch [3]. There was also your
> > > > > > > >> reply at [4], but I think you missed that this is intended for use in
> > > > > > > >> unit tests (i.e. with ut_assert()).
> > > > > > > >>
> > > > > > > >> You also requested that this be generalised, rather than being
> > > > > > > >> EFI-loader-specific. I have no objection to that, but don't have a use
> > > > > > > >> case for it yet, so have deferred that to later. It's a fairly simple
> > > > > > > >> change, if/when needed. If the series was not NAKed, I'd be happy to
> > > > > > > >> do it now.
> > > > > > > >>
> > > > > > > >>>>
> > > > > > > >>>>>
> > > > > > > >>>>> Tom suggested not to send patches that are for private enjoyment to the
> > > > > > > >>>>> mailing list.
> > > > > > > >>>>
> > > > > > > >>>> My contributions to U-Boot are only ever about private enjoyment :-)
> > > > > > > >>>>
> > > > > > > >>>> Do you have any comments on the patches?
> > > > > > > >>
> > > > > > > >> Regards,
> > > > > > > >> Simon
> > > > > > > >>
> > > > > > > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-6-sjg@chromium.org/
> > > > > > > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com/
> > > > > > > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
> > > > > > > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065BCD2@gmx.de/
> > > > > > > >
> > > > > > > > Looking at the logging portions of the original series again, especially
> > > > > > > > if this was made generic, we probably don't want to print to actual
> > > > > > > > console every time we're making a note of some memory allocation for
> > > > > > > > example, that would be unreadable outside of a debug context. The point
> > > > > > > > of this really seems to be "log things for verifying in tests later".
> > > > > > > > Does that end up being useful? I don't know. Heinrich or Ilias, do the
> > > > > > > > tests in [1] look generally useful?
> > > > > > > >
> > > > > > >
> > > > > > > The tests in [1] are not documented, not even in the commit message. So
> > > > > > > the reasoning behind the tests remains Simon's secret.
> > > > > >
> > > > > > Are you asking for code comments in the test? If so, I can add some.
> > > > > >
> > > > > > >
> > > > > > > At first sight the tests in [1] don't make much sense. E.g. that only a
> > > > > > > subset of memory types have been used does not tell that the right
> > > > > > > memory type has been used for the right object.
> > > > > >
> > > > > > It is a pretty good start, though. It makes sure that the memory types
> > > > > > are sane, checks addresses are within DRAM, etc. With [5] it makes
> > > > > > sure that devices are removed.
> > > > > >
> > > > > > >
> > > > > > > Implementing a specific tracing functionality for EFI is definitively
> > > > > > > the wrong way forward as it will lead to code duplication.
> > > > > >
> > > > > > We can cross that bridge when we come to it.
> > > > >
> > > > > Well, no. It's backwards to make a bridge in one place when everyone
> > > > > agrees it needs to be moved somewhere else. I mean [5] is a generic
> > > > > issue and test/py/tests/test_net_boot.py or some other test we already
> > > > > have which tests booting an OS should confirm that we've quiesced
> > > > > devices before moving on. And as a bonus it's in python where dealing
> > > > > with strings doesn't suck.
> > > >
> > > > I really don't want to write C tests in Python. CI is slow enough as
> > > > it is, something realy want to fix. I'm also not sure how you can tell
> > > > if a device has been removed. Run 'dm tree' and look for the missing
> > > > 'star' in the resulting 300 lines of text?
> > >
> > > As I'm in a bisect-hell in our C tests you'll have to forgive me for not
> > > thinking the C tests are noticeably faster than python tests. Or that
> > > they aren't their own potential source of corner-case bugs. But I
> > > digress..
> >
> > Welcome to my world. I bisected my lab devices so many times to try to
> > isolate all the breakages that have crept in. What is the problem,
> > maybe I can help?
>
> Sure. test/cmd/hash.c::dm_test_cmd_hash_md5 fails randomly, in maybe 1
> out of 100 runs, via pytest, in sandbox. Not via "./u-boot -T -c 'ut dm
> dm_test_cmd_hash_md5'" however (I stopped checking after 1000
> iterations). I was iterating over "and built with clang" but I think it
> happens with gcc too, from the actual failures in CI. And you can use
> "-k ut" to limit to just what's matched there, so it's a quicker
> iteration.

Hmmm do you have a link? It's hard to imagine what it is, but perhaps
a dependency on a previous test.

At present 'ut all' fails so I am going to take a look at that. Quite
a bit of clean-up needed in test system, though. Ideally we could run
the tests in random order so we can find and fix the dependencies. For
driver model we reinit as needed, but that's not the case for EFI, for
example.

>
> > > And yes, taking a bunch of text and parsing it, is what python is fast
> > > at. And easier to write.
> > >
> > > > But actually [5] is not generic, since EFI uses its own code to remove
> > > > devices. This test is solely focussed on EFI.
> > >
> > > Yes, you're testing the EFI version of the code in
> > > arch/$(ARCH)/lib/bootm.c. The remove devices functions being called in
> > > both cases are generic.
> >
> > The code in EFI is:
> >
> > if (!efi_st_keep_devices) {
> > bootm_disable_interrupts();
> > if (IS_ENABLED(CONFIG_USB_DEVICE))
> > udc_disconnect();
> > board_quiesce_devices();
> > dm_remove_devices_active();
> > }
> >
> > It does call somewhat the same functions, but is doing its own thing,
> > not even using the arch-specific code. As I mentioned, a nice clean-up
> > would be to make bootm_announce_and_cleanup() common.
>
> Yes, we almost agree? Both the EFI code, and arch/$(ARCH)/lib/bootm.c
> have functions that make the above calls. A nice clean-up would be to
> have something common.

Yes indeed. It still does not provide a test for the EFI bootmeth,
though, where I found half a dozen bugs.

>
> >
> > Actually, now that I see efi_st_keep_devices, I wonder why Heinrich
> > didn't want my ANSI patch[6] which serves a similar function.
>
> No? Your patch disables ANSI output in those tests, that variable is for
> making sure those tests can accomplish (if I skim things right) similar
> kinds of tests you've asked for before, but with an EFI app instead? But
> perhaps better to not start yet another tangent here...

I wouldn't know where to start, anyway...

> > > > If you want the logging to be renamed and placed centrally I don't
> > > > mind doing it now. But note that only EFI will use it for now.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > We already have function _log() which is variadic.
> > > > > > >
> > > > > > > Simon could write a new log driver that parses the `format` parameter
> > > > > > > and saves the binary data in an appropriate format for analysis by the
> > > > > > > unit tests:
> > > > > > >
> > > > > > > * For %s the driver should save the string and not the address of the
> > > > > > > string.
> > > > > > > * For %pD the driver should save the device path instead of the pointer.
> > > > > > > * ...
> > > > > > >
> > > > > > > Some changes to the log driver interface will be needed to pass the
> > > > > > > variadic arguments instead of the formatted message.
> > > > > >
> > > > > > Perhaps the word 'log' is confusing people. But the above suggestion
> > > > > > is quite a complicated way of handling things. We have no way to
> > > > > > decode printf() strings in this way. See log_dispatch() for how this
> > > > > > is handled today. It uses sprintf(). Trying to test based on text
> > > > > > output would be very clumsy (lots of regexes and sscan() calls?) and
> > > > > > result in a huge amount of parsing code, highly dependent on the
> > > > > > printf() format, etc.
> > > > > >
> > > > > > I very-much doubt that would produce a useful implementation, but if
> > > > > > you would like to try it out then I would be happy to look at it.
> > > > > >
> > > > > > I mentioned this several times, but even if we did go that way, we
> > > > > > only have logging on the external calls, so much of the EFI-memory
> > > > > > allocation in U-Boot would not be logged.
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [5] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3054780-9-sjg@chromium.org/
> > > > >
> > > > > Yes, calling this a "log" when it's intended for capturing information
> > > > > for tests got some of this off on the wrong track. But that also helps
> > > > > explain now that this is still on the wrong track and should instead be
> > > > > following normal design practices for testing and expanding existing
> > > > > infrastructure and not inventing a new everything. So if you don't like
> > > > > Heinrich's suggestion, take a look at Caleb's suggestion.
> > > >
> > > > I don't have the energy to port the tracing framework from Linux to
> > > > U-Boot, although I agree it would be useful. Still, function tracing
> > > > is quite fragile and confusing to work with when refactoring code. I
> > > > don't like that idea much for this use case, although if function
> > > > tracing did exist in U-Boot I would likely have used it.
> > >
> > > I mean yes, it would be good if you went back and expanded on the trace
> > > functionality you did before.
> >
> > I still don't believe it is the best solution and seems like yet
> > another ocean I should avoid sticking my heater into.
>
> I strongly disagree. If you go back to the trace code you brought in to
> start with and make it more useful / include newer features existing
> elsewhere you're not going to end up in conflict with everyone asking
> why you're doing something subsystem specific.

Perhaps someone else could do this? It would be a substantial amount
of work to bring runtime tooling into U-Boot, bpf and the like. It
would be quite a pain to use, I suspect, and certainly not possible to
write a simple C test as I have done here.

>
> > > > > And if you
> > > > > don't like Caleb's suggestion, go put this in a topic branch you can
> > > > > merge when you need to debug some problem that seemingly nothing else
> > > > > will catch.
> > > >
> > > > Here we are over a year after I reported the bug and we still don't
> > > > have a test to cover it. This series is better than the available
> > > > alternatives, IMO.
> > >
> > > Well, no. We have commit dabaa4ae3206 ("dm: Add
> > > dm_remove_devices_active() for ordered device removal") we have a test
> > > for the underlying problem. We need more functional boot tests, but we
> > > need those to be in python too, and not more C code.
> >
> > That is a nice improvement, but did not fix the underlying problem.
> > The underlying problem was that EFI was calling exit-boot-services,
> > causing U-Boot to free up data structures which were needed to boot.
> > This was on x86_64. I never quite figured out which one (very hard
> > when you cannot get back to U-Boot to check).
> >
> > There were quite a lot of problems, actually. There v2 series is at [7]
> >
> > Only a C test can check what actually happens inside U-Boot.
>
> Yes, I think now we get back to disagreeing on which symptoms lead to
> which code problems and then what to do about them.

OK

>
> > > And you're not just coming up with a test, you're refactoring a bunch of
> > > code and introducing new subsystems in order to do that. When as I keep
> > > pointing out, we don't need that. We could easily extend the existing OS
> > > boot tests we have to script booting an ISO. And we only run those when
> > > say "ENABLE_SLOW_TESTS" is set, and only do that on tagged releases.
> >
> > Yes of course we need to refactor to make tests work. This is not
> > necessarily a bad thing, as it helps us break code down into testable
> > chunks. We cannot rely only on large functional-tests, not that you
> > are suggesting that. See [8], but they are too slow, too hard to debug
> > when they fail. They also tend to devolve into chaos as people get
> > lazy and stop writing unit/smaller tests.
>
> I'll just note that I don't ever even think to use "make tests" or
> "qcheck" or any of the others since they never work for me.

Would you mind filing an issue on that? I use 'make pcheck' all the time.

> With only a
> little bit of wrappering I can however run pytest like in CI.

Yes, I use that too.

Regards,
Simon
