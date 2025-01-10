Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F6E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EEC800D0;
	Fri, 10 Jan 2025 17:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sc7nMx31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2498036B; Fri, 10 Jan 2025 17:48:37 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F1080050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4679fc9b5f1so16591131cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736527714; x=1737132514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=33CA0B14hXF+1oZJzkpaMI7jt4WQKVRxRRybajoVm38=;
 b=Sc7nMx31KmuIVroV1WExrIU/BQtoC3QK40s4p4UjhJBmsDEEK+uRdwhaq0+N4Disff
 rcLfoP1TDJEPS8g5qKbmVzkdk3o5uOePOObsVhZAm6DdXOtKWRf+/lYb2EmZyEPs8DRq
 H6HnA1cUTzaweQqmyV3k1hBFzvO1WiEPIIZWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736527714; x=1737132514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33CA0B14hXF+1oZJzkpaMI7jt4WQKVRxRRybajoVm38=;
 b=aU8sh8GPAVNZIujzlAM4kp2Agk7bAhJEOTulRZs4nLNYGVREwhcBI3dHMawTDIjpf9
 KoCEGVPeb4Q2GumCSsUhojPR3SptSctMd0KcXDij+IPxlW+H7HdCgwPEHb7TLIZrbJLr
 nHY+fFVJwQa+E7cFDxh5m+xliDXvmSkMI1d7QTuOGiNGIwosF89lN4JpMVVTNigJxSq+
 jdVIz3JAb1Jde46ayd0/gnFPG+szV664/EBdptE1DFEQm/GYoJ0yfBuF63TSBWo6OPF8
 toOWO61dB8ACpr191NzHzw0QFG9OZg6m6VKEof2EeY0q8OWT0cc92brhApx38lOVRIvg
 boPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDEq20TZFHooyDXx1ZWH8vsi0xOzmCCD1E0eK24p8RFq95ja4whzJR7hl8L2c/yUTif6fgBCA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/e92+iwIVBxyZEaFExrLWOH9PPqMy5Hhs1K7bhMouD8cuCKK9
 FduT2wVV55BX1LR2IkA9fZD2fnYwilYzmNDl6FTzKSWlShBR7vUBN23GDslFBAU=
X-Gm-Gg: ASbGncvet2+WUKCUh98li1rWcFIq5DO38h+b3ZVtE0u1zkaEF3L2Y1dBZ0ykNwzKcSh
 nMu1z6Sym5N6BEsphNcEtd7f444kPdYZUc5hRLbGPCf3bLmGt6J8jWmBRYb7qv67c48FNqyrMn/
 l1mYG5TPh3IZk8vzfZufVINHKASgWy/3yeF+sAvYeTb11OghWA6k377g2EUXldkYkTEpEa4915a
 5VDmaMSJdJMoNuxBBQ9OwKL3pK7JoaqtyfI9fgtvA9EULLfNDZCh+0=
X-Google-Smtp-Source: AGHT+IGGKZ207RzUSoHw4aTF7vZx0u/SiGkztf8VNIIiVrxlPctBJZ4fbrwtMlm+zmqFjiSbOa+Trw==
X-Received: by 2002:ac8:7d8f:0:b0:467:45b7:c495 with SMTP id
 d75a77b69052e-46c7108f867mr173651421cf.15.1736527713542; 
 Fri, 10 Jan 2025 08:48:33 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873eaf88sm10875531cf.81.2025.01.10.08.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 08:48:32 -0800 (PST)
Date: Fri, 10 Jan 2025 10:48:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250110164829.GJ3476@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9p3Fp/JFMkXlfXcE"
Content-Disposition: inline
In-Reply-To: <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--9p3Fp/JFMkXlfXcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 06:40:37AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Jan 2025 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 08:02:01AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 8 Jan 2025 at 12:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> > > > > Hi Heinrich, Tom,
> > > > >
> > > > > On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx=
=2Ede> wrote:
> > > > > >
> > > > > > On 07.01.25 16:11, Tom Rini wrote:
> > > > > > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> > > > > > >> Hi Heinrich,
> > > > > > >>
> > > > > > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > > > > > >>>
> > > > > > >>> On 07.01.25 13:15, Simon Glass wrote:
> > > > > > >>>> Hi Heinrich,
> > > > > > >>>>
> > > > > > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> > > > > > >>>>>
> > > > > > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > > > > > >>>>>> This test was hamstrung in code review so this series is=
 an attempt to
> > > > > > >>>>>> complete the intended functionality:
> > > > > > >>>>>>
> > > > > > >>>>>> - Check memory allocations look correct
> > > > > > >>>>>> - Check that exit-boot-services removes active-DMA devic=
es
> > > > > > >>>>>> - Check that the bootflow is still present after testapp=
 finishes
> > > > > > >>>>>>
> > > > > > >>>>>> The EFI functionality duplicates bootm_announce_and_clea=
nup() and still
> > > > > > >>>>>> uses the defunct board_quiesce_devices() so a nice clean=
up would be to
> > > > > > >>>>>> call the bootm function instead, with suitable modificat=
ions. That would
> > > > > > >>>>>> allow bootstage to work too.
> > > > > > >>>>>>
> > > > > > >>>>>> This series is based on sjg/master since the EFI logging=
 was rejected so
> > > > > > >>>>>> far.
> > > > > > >>>>>
> > > > > > >>>>> Yes, it was rejected because a solution at the lib/log.c =
level would be
> > > > > > >>>>> more generic.
> > > > > > >>>>
> > > > > > >>>> As I mentioned, that idea isn't suitable for programmatic =
use.
> > > > > > >>>
> > > > > > >>> What can be done with show_addr("mem", rec->memory); that l=
og_debug()
> > > > > > >>> does not offer or which you could not do with a new log fun=
ction in
> > > > > > >>> lib/log.c that takes variadic arguments?
> > > > > > >>
> > > > > > >> There are asserts in [1], for example. How do you propose to=
 handle
> > > > > > >> that? See [2] for my previous explanation, quoted here:
> > > > > > >>
> > > > > > >>> CONFIG_LOG with a bloblist option would be a great idea, bu=
t it's hard
> > > > > > >>> to programmatically scan text...plus only the external call=
 sites are
> > > > > > >>> actually logged.
> > > > > > >>
> > > > > > >> Also see the discussion on the original patch [3]. There was=
 also your
> > > > > > >> reply at [4], but I think you missed that this is intended f=
or use in
> > > > > > >> unit tests (i.e. with ut_assert()).
> > > > > > >>
> > > > > > >> You also requested that this be generalised, rather than bei=
ng
> > > > > > >> EFI-loader-specific. I have no objection to that, but don't =
have a use
> > > > > > >> case for it yet, so have deferred that to later. It's a fair=
ly simple
> > > > > > >> change, if/when needed. If the series was not NAKed, I'd be =
happy to
> > > > > > >> do it now.
> > > > > > >>
> > > > > > >>>>
> > > > > > >>>>>
> > > > > > >>>>> Tom suggested not to send patches that are for private en=
joyment to the
> > > > > > >>>>> mailing list.
> > > > > > >>>>
> > > > > > >>>> My contributions to U-Boot are only ever about private enj=
oyment :-)
> > > > > > >>>>
> > > > > > >>>> Do you have any comments on the patches?
> > > > > > >>
> > > > > > >> Regards,
> > > > > > >> Simon
> > > > > > >>
> > > > > > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/2025010=
6144755.3054780-6-sjg@chromium.org/
> > > > > > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax8=
0sBombYo_k0YgiuVnP=3DKZCOvuA@mail.gmail.com/
> > > > > > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_=
GmKJ=3Dx+M4=3DUY_O6roSOpZaDxag@mail.gmail.com/
> > > > > > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-8=
5958065BCD2@gmx.de/
> > > > > > >
> > > > > > > Looking at the logging portions of the original series again,=
 especially
> > > > > > > if this was made generic, we probably don't want to print to =
actual
> > > > > > > console every time we're making a note of some memory allocat=
ion for
> > > > > > > example, that would be unreadable outside of a debug context.=
 The point
> > > > > > > of this really seems to be "log things for verifying in tests=
 later".
> > > > > > > Does that end up being useful? I don't know. Heinrich or Ilia=
s, do the
> > > > > > > tests in [1] look generally useful?
> > > > > > >
> > > > > >
> > > > > > The tests in [1] are not documented, not even in the commit mes=
sage. So
> > > > > > the reasoning behind the tests remains Simon's secret.
> > > > >
> > > > > Are you asking for code comments in the test? If so, I can add so=
me.
> > > > >
> > > > > >
> > > > > > At first sight the tests in [1] don't make much sense. E.g. tha=
t only a
> > > > > > subset of memory types have been used does not tell that the ri=
ght
> > > > > > memory type has been used for the right object.
> > > > >
> > > > > It is a pretty good start, though. It makes sure that the memory =
types
> > > > > are sane, checks addresses are within DRAM, etc. With [5] it makes
> > > > > sure that devices are removed.
> > > > >
> > > > > >
> > > > > > Implementing a specific tracing functionality for EFI is defini=
tively
> > > > > > the wrong way forward as it will lead to code duplication.
> > > > >
> > > > > We can cross that bridge when we come to it.
> > > >
> > > > Well, no. It's backwards to make a bridge in one place when everyone
> > > > agrees it needs to be moved somewhere else. I mean [5] is a generic
> > > > issue and test/py/tests/test_net_boot.py or some other test we alre=
ady
> > > > have which tests booting an OS should confirm that we've quiesced
> > > > devices before moving on. And as a bonus it's in python where deali=
ng
> > > > with strings doesn't suck.
> > >
> > > I really don't want to write C tests in Python. CI is slow enough as
> > > it is, something realy want to fix. I'm also not sure how you can tell
> > > if a device has been removed. Run 'dm tree' and look for the missing
> > > 'star' in the resulting 300 lines of text?
> >
> > As I'm in a bisect-hell in our C tests you'll have to forgive me for not
> > thinking the C tests are noticeably faster than python tests. Or that
> > they aren't their own potential source of corner-case bugs. But I
> > digress..
>=20
> Welcome to my world. I bisected my lab devices so many times to try to
> isolate all the breakages that have crept in. What is the problem,
> maybe I can help?

Sure. test/cmd/hash.c::dm_test_cmd_hash_md5 fails randomly, in maybe 1
out of 100 runs, via pytest, in sandbox. Not via "./u-boot -T -c 'ut dm
dm_test_cmd_hash_md5'" however (I stopped checking after 1000
iterations). I was iterating over "and built with clang" but I think it
happens with gcc too, from the actual failures in CI. And you can use
"-k ut" to limit to just what's matched there, so it's a quicker
iteration.

> > And yes, taking a bunch of text and parsing it, is what python is fast
> > at. And easier to write.
> >
> > > But actually [5] is not generic, since EFI uses its own code to remove
> > > devices. This test is solely focussed on EFI.
> >
> > Yes, you're testing the EFI version of the code in
> > arch/$(ARCH)/lib/bootm.c. The remove devices functions being called in
> > both cases are generic.
>=20
> The code in EFI is:
>=20
> if (!efi_st_keep_devices) {
> bootm_disable_interrupts();
> if (IS_ENABLED(CONFIG_USB_DEVICE))
> udc_disconnect();
> board_quiesce_devices();
> dm_remove_devices_active();
> }
>=20
> It does call somewhat the same functions, but is doing its own thing,
> not even using the arch-specific code. As I mentioned, a nice clean-up
> would be to make bootm_announce_and_cleanup() common.

Yes, we almost agree? Both the EFI code, and arch/$(ARCH)/lib/bootm.c
have functions that make the above calls. A nice clean-up would be to
have something common.

>=20
> Actually, now that I see efi_st_keep_devices, I wonder why Heinrich
> didn't want my ANSI patch[6] which serves a similar function.

No? Your patch disables ANSI output in those tests, that variable is for
making sure those tests can accomplish (if I skim things right) similar
kinds of tests you've asked for before, but with an EFI app instead? But
perhaps better to not start yet another tangent here...

> > > If you want the logging to be renamed and placed centrally I don't
> > > mind doing it now. But note that only EFI will use it for now.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > We already have function _log() which is variadic.
> > > > > >
> > > > > > Simon could write a new log driver that parses the `format` par=
ameter
> > > > > > and saves the binary data in an appropriate format for analysis=
 by the
> > > > > > unit tests:
> > > > > >
> > > > > > * For %s the driver should save the string and not the address =
of the
> > > > > > string.
> > > > > > * For %pD the driver should save the device path instead of the=
 pointer.
> > > > > > * ...
> > > > > >
> > > > > > Some changes to the log driver interface will be needed to pass=
 the
> > > > > > variadic arguments instead of the formatted message.
> > > > >
> > > > > Perhaps the word 'log' is confusing people. But the above suggest=
ion
> > > > > is quite a complicated way of handling things. We have no way to
> > > > > decode printf() strings in this way. See log_dispatch() for how t=
his
> > > > > is handled today. It uses sprintf(). Trying to test based on text
> > > > > output would be very clumsy (lots of regexes and sscan() calls?) =
and
> > > > > result in a huge amount of parsing code, highly dependent on the
> > > > > printf() format, etc.
> > > > >
> > > > > I very-much doubt that would produce a useful implementation, but=
 if
> > > > > you would like to try it out then I would be happy to look at it.
> > > > >
> > > > > I mentioned this several times, but even if we did go that way, we
> > > > > only have logging on the external calls, so much of the EFI-memory
> > > > > allocation in U-Boot would not be logged.
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > [5] https://patchwork.ozlabs.org/project/uboot/patch/202501061447=
55.3054780-9-sjg@chromium.org/
> > > >
> > > > Yes, calling this a "log" when it's intended for capturing informat=
ion
> > > > for tests got some of this off on the wrong track. But that also he=
lps
> > > > explain now that this is still on the wrong track and should instea=
d be
> > > > following normal design practices for testing and expanding existing
> > > > infrastructure and not inventing a new everything. So if you don't =
like
> > > > Heinrich's suggestion, take a look at Caleb's suggestion.
> > >
> > > I don't have the energy to port the tracing framework from Linux to
> > > U-Boot, although I agree it would be useful. Still, function tracing
> > > is quite fragile and confusing to work with when refactoring code. I
> > > don't like that idea much for this use case, although if function
> > > tracing did exist in U-Boot I would likely have used it.
> >
> > I mean yes, it would be good if you went back and expanded on the trace
> > functionality you did before.
>=20
> I still don't believe it is the best solution and seems like yet
> another ocean I should avoid sticking my heater into.

I strongly disagree. If you go back to the trace code you brought in to
start with and make it more useful / include newer features existing
elsewhere you're not going to end up in conflict with everyone asking
why you're doing something subsystem specific.

> > > > And if you
> > > > don't like Caleb's suggestion, go put this in a topic branch you can
> > > > merge when you need to debug some problem that seemingly nothing el=
se
> > > > will catch.
> > >
> > > Here we are over a year after I reported the bug and we still don't
> > > have a test to cover it. This series is better than the available
> > > alternatives, IMO.
> >
> > Well, no. We have commit dabaa4ae3206 ("dm: Add
> > dm_remove_devices_active() for ordered device removal") we have a test
> > for the underlying problem. We need more functional boot tests, but we
> > need those to be in python too, and not more C code.
>=20
> That is a nice improvement, but did not fix the underlying problem.
> The underlying problem was that EFI was calling exit-boot-services,
> causing U-Boot to free up data structures which were needed to boot.
> This was on x86_64. I never quite figured out which one (very hard
> when you cannot get back to U-Boot to check).
>=20
> There were quite a lot of problems, actually. There v2 series is at [7]
>=20
> Only a C test can check what actually happens inside U-Boot.

Yes, I think now we get back to disagreeing on which symptoms lead to
which code problems and then what to do about them.

> > And you're not just coming up with a test, you're refactoring a bunch of
> > code and introducing new subsystems in order to do that. When as I keep
> > pointing out, we don't need that. We could easily extend the existing OS
> > boot tests we have to script booting an ISO. And we only run those when
> > say "ENABLE_SLOW_TESTS" is set, and only do that on tagged releases.
>=20
> Yes of course we need to refactor to make tests work. This is not
> necessarily a bad thing, as it helps us break code down into testable
> chunks. We cannot rely only on large functional-tests, not that you
> are suggesting that. See [8], but they are too slow, too hard to debug
> when they fail. They also tend to devolve into chaos as people get
> lazy and stop writing unit/smaller tests.

I'll just note that I don't ever even think to use "make tests" or
"qcheck" or any of the others since they never work for me. With only a
little bit of wrappering I can however run pytest like in CI.

--=20
Tom

--9p3Fp/JFMkXlfXcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBT1cACgkQFHw5/5Y0
tyzfagv/fP8PzAYbM4A7LGDWQ/Uhw6g0dWyd+aF7Te6VkU4Q3MvB/VDRwmltdSZP
KeMDY3wC5a5VGCsZXWi4yXJ9cYPJEe0RsP9LvSHWQu9TMjZuLhmtbdzAln/I21TY
VRipbg82b/cTSolrEmQtcgStVsFu3syS0UCSawdElCoIJ3VgTVuyH2Mi+HfabYt1
SxnpPmWY8myTz6d74TycRU4jsXvoCsaorXhUY4JqCjhoTF3SPTVUBbtiahthTqhZ
APtYQ5jbCdh5S0sLtqBSUgebsHvjBRzMsVanPNMc47dx+agyWBgySvvDbcvdwe4P
Qfr8ntW1MHgYBhJO8cq+755eIBJdk16hisKD9vE5LFbEjrHD+5A9d2S/7fSgrrSj
nWqtGN22JK6vkYn8cC6DZiFmfTEZXb0fPOOvbLEa0dwVPOHoAgWgMAcQ6W95PruC
8q0HTM6Zx3LietxB6EurO3UvP3+uPi92HYxEFwwVumxSVafllWBr9H5cPg88cgZ4
bYIxVKEX
=yxOE
-----END PGP SIGNATURE-----

--9p3Fp/JFMkXlfXcE--
