Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA35DC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 20:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243DC805E9;
	Mon, 13 Jan 2025 21:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gO+am0it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0178060C; Mon, 13 Jan 2025 21:20:35 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA3E805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso43391696d6.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736799631; x=1737404431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GlW3BxX/9geJe0jnUZTWxKmvhYCESK1wIq4g8Xmimck=;
 b=gO+am0itgUUR2qAjlm9IrPps8fnB8YWteS/1xPgBxAWeqgWki6yrx8rQlQOldDWy98
 ac8xsT9vGjvZNY8DWUJKLtwPlZ3iQB/hfKZVjmU2tApdJiGf9El4IEZZqkLZ2XBcuvaa
 BbJSRSZ+pIGlmRJZXIL52Jao1QlOC7VYbt/8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736799631; x=1737404431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlW3BxX/9geJe0jnUZTWxKmvhYCESK1wIq4g8Xmimck=;
 b=T9GiUGXAh+coM/atSmGlVNQ/YcUB6Mfgibd3aB30EtZi6pA7+BFr5uvPRd4IK8O+R6
 WxMgUnizH1GQfTnT5r0w1KHhTGDYeI59uiU0wvCYRYKL6Jw+FcsANdgbpidWcfyKCv6g
 +ZIkBEVes5ePwE2hIbZIzOFErHu5lTMK+O0URugmyC/c/jKEzB5FJMkHnThoiIhSRpAj
 HIcvwmRW16JYbLSCftusnLrH4Gnmm8zlxoDoEa1FB6KjPwU4SvnDxwHEHadGyxuCZB6Z
 9Iur463uvCt4PEh9TfQeUanA3jLFSrA2VQnyBD+wbYSpt1ORM6YtmfGYkMZDp+0pzPeE
 Vyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtqHEp2Q9EwuKLOB08/2hnNfpE6uQEBYVN/H/lCZ88OSLWJIbxU5T1nrNEToqCRjagjB5juk=@lists.denx.de
X-Gm-Message-State: AOJu0YzYGzPhrsd5CjuhGI5qM9WPF+KuMfPo0dSUQtY4n/tZB2UDSxtU
 doxcas+sKA8gtdyklmulPLsKTsQIWHkfzdIjg9SzS3TbBKG7V9j93+/1TJuhfXlgbNcWmd24f84
 T
X-Gm-Gg: ASbGncsN1A2V7FSHa9amIx66JSeR8MYSFj93BrC8PpEGVGn1L78YGO/J1nlwOrCE6jW
 8BjZGH8zaITs9f2cnu0Ne6IbCyOt02PdO3inGerAlRlbBUthPVA3HdVo0h2U72lrKmXogDjFfTu
 bJzXfN7ZP1qCgSqsxCIoWJJqL4eLsrZRp1XVcrimktVWjQKXJQ28LooBNVh1qgMys5iIai3EMd0
 pLFcR2uGIdwB3b46EFBiQB+RFhdiuIarXktHS6m6PTpv+XTfVB8g1I=
X-Google-Smtp-Source: AGHT+IGjPR1xp+poPFwift3/6iKUdOme/jMXvnB/LGuYsmpulxFs9aGQTVyjKLPJhIqACq2vaJwdLw==
X-Received: by 2002:a05:6214:438a:b0:6d4:1d7e:bc72 with SMTP id
 6a1803df08f44-6dfbaa09432mr154126556d6.12.1736799630565; 
 Mon, 13 Jan 2025 12:20:30 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad880a1csm45306636d6.28.2025.01.13.12.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 12:20:29 -0800 (PST)
Date: Mon, 13 Jan 2025 14:20:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250113202026.GC3476@bill-the-cat>
References: <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
 <20250108191457.GQ3476@bill-the-cat>
 <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
 <20250109165121.GZ3476@bill-the-cat>
 <CAFLszThGNgH2rtLK5d+YEj4-p+cFpVLtMu_+Z_SHYbU8vp6Wkw@mail.gmail.com>
 <20250110164829.GJ3476@bill-the-cat>
 <CAFLszThVjiDgi5_V0yRbWo2pbbv3LEZA4TM=dkiJTd8D6gTe=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3w+NulUv/ApAK6aX"
Content-Disposition: inline
In-Reply-To: <CAFLszThVjiDgi5_V0yRbWo2pbbv3LEZA4TM=dkiJTd8D6gTe=g@mail.gmail.com>
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


--3w+NulUv/ApAK6aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:01:36PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Jan 2025 at 09:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 10, 2025 at 06:40:37AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Jan 2025 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 08:02:01AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 8 Jan 2025 at 12:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> > > > > > > Hi Heinrich, Tom,
> > > > > > >
> > > > > > > On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 07.01.25 16:11, Tom Rini wrote:
> > > > > > > > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wro=
te:
> > > > > > > > >> Hi Heinrich,
> > > > > > > > >>
> > > > > > > > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> > > > > > > > >>>
> > > > > > > > >>> On 07.01.25 13:15, Simon Glass wrote:
> > > > > > > > >>>> Hi Heinrich,
> > > > > > > > >>>>
> > > > > > > > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypr=
on.glpk@gmx.de> wrote:
> > > > > > > > >>>>>
> > > > > > > > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > > > > > > > >>>>>> This test was hamstrung in code review so this serie=
s is an attempt to
> > > > > > > > >>>>>> complete the intended functionality:
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> - Check memory allocations look correct
> > > > > > > > >>>>>> - Check that exit-boot-services removes active-DMA d=
evices
> > > > > > > > >>>>>> - Check that the bootflow is still present after tes=
tapp finishes
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> The EFI functionality duplicates bootm_announce_and_=
cleanup() and still
> > > > > > > > >>>>>> uses the defunct board_quiesce_devices() so a nice c=
leanup would be to
> > > > > > > > >>>>>> call the bootm function instead, with suitable modif=
ications. That would
> > > > > > > > >>>>>> allow bootstage to work too.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> This series is based on sjg/master since the EFI log=
ging was rejected so
> > > > > > > > >>>>>> far.
> > > > > > > > >>>>>
> > > > > > > > >>>>> Yes, it was rejected because a solution at the lib/lo=
g.c level would be
> > > > > > > > >>>>> more generic.
> > > > > > > > >>>>
> > > > > > > > >>>> As I mentioned, that idea isn't suitable for programma=
tic use.
> > > > > > > > >>>
> > > > > > > > >>> What can be done with show_addr("mem", rec->memory); th=
at log_debug()
> > > > > > > > >>> does not offer or which you could not do with a new log=
 function in
> > > > > > > > >>> lib/log.c that takes variadic arguments?
> > > > > > > > >>
> > > > > > > > >> There are asserts in [1], for example. How do you propos=
e to handle
> > > > > > > > >> that? See [2] for my previous explanation, quoted here:
> > > > > > > > >>
> > > > > > > > >>> CONFIG_LOG with a bloblist option would be a great idea=
, but it's hard
> > > > > > > > >>> to programmatically scan text...plus only the external =
call sites are
> > > > > > > > >>> actually logged.
> > > > > > > > >>
> > > > > > > > >> Also see the discussion on the original patch [3]. There=
 was also your
> > > > > > > > >> reply at [4], but I think you missed that this is intend=
ed for use in
> > > > > > > > >> unit tests (i.e. with ut_assert()).
> > > > > > > > >>
> > > > > > > > >> You also requested that this be generalised, rather than=
 being
> > > > > > > > >> EFI-loader-specific. I have no objection to that, but do=
n't have a use
> > > > > > > > >> case for it yet, so have deferred that to later. It's a =
fairly simple
> > > > > > > > >> change, if/when needed. If the series was not NAKed, I'd=
 be happy to
> > > > > > > > >> do it now.
> > > > > > > > >>
> > > > > > > > >>>>
> > > > > > > > >>>>>
> > > > > > > > >>>>> Tom suggested not to send patches that are for privat=
e enjoyment to the
> > > > > > > > >>>>> mailing list.
> > > > > > > > >>>>
> > > > > > > > >>>> My contributions to U-Boot are only ever about private=
 enjoyment :-)
> > > > > > > > >>>>
> > > > > > > > >>>> Do you have any comments on the patches?
> > > > > > > > >>
> > > > > > > > >> Regards,
> > > > > > > > >> Simon
> > > > > > > > >>
> > > > > > > > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/202=
50106144755.3054780-6-sjg@chromium.org/
> > > > > > > > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jg=
dax80sBombYo_k0YgiuVnP=3DKZCOvuA@mail.gmail.com/
> > > > > > > > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbko=
XkC_GmKJ=3Dx+M4=3DUY_O6roSOpZaDxag@mail.gmail.com/
> > > > > > > > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B1=
1F-85958065BCD2@gmx.de/
> > > > > > > > >
> > > > > > > > > Looking at the logging portions of the original series ag=
ain, especially
> > > > > > > > > if this was made generic, we probably don't want to print=
 to actual
> > > > > > > > > console every time we're making a note of some memory all=
ocation for
> > > > > > > > > example, that would be unreadable outside of a debug cont=
ext. The point
> > > > > > > > > of this really seems to be "log things for verifying in t=
ests later".
> > > > > > > > > Does that end up being useful? I don't know. Heinrich or =
Ilias, do the
> > > > > > > > > tests in [1] look generally useful?
> > > > > > > > >
> > > > > > > >
> > > > > > > > The tests in [1] are not documented, not even in the commit=
 message. So
> > > > > > > > the reasoning behind the tests remains Simon's secret.
> > > > > > >
> > > > > > > Are you asking for code comments in the test? If so, I can ad=
d some.
> > > > > > >
> > > > > > > >
> > > > > > > > At first sight the tests in [1] don't make much sense. E.g.=
 that only a
> > > > > > > > subset of memory types have been used does not tell that th=
e right
> > > > > > > > memory type has been used for the right object.
> > > > > > >
> > > > > > > It is a pretty good start, though. It makes sure that the mem=
ory types
> > > > > > > are sane, checks addresses are within DRAM, etc. With [5] it =
makes
> > > > > > > sure that devices are removed.
> > > > > > >
> > > > > > > >
> > > > > > > > Implementing a specific tracing functionality for EFI is de=
finitively
> > > > > > > > the wrong way forward as it will lead to code duplication.
> > > > > > >
> > > > > > > We can cross that bridge when we come to it.
> > > > > >
> > > > > > Well, no. It's backwards to make a bridge in one place when eve=
ryone
> > > > > > agrees it needs to be moved somewhere else. I mean [5] is a gen=
eric
> > > > > > issue and test/py/tests/test_net_boot.py or some other test we =
already
> > > > > > have which tests booting an OS should confirm that we've quiesc=
ed
> > > > > > devices before moving on. And as a bonus it's in python where d=
ealing
> > > > > > with strings doesn't suck.
> > > > >
> > > > > I really don't want to write C tests in Python. CI is slow enough=
 as
> > > > > it is, something realy want to fix. I'm also not sure how you can=
 tell
> > > > > if a device has been removed. Run 'dm tree' and look for the miss=
ing
> > > > > 'star' in the resulting 300 lines of text?
> > > >
> > > > As I'm in a bisect-hell in our C tests you'll have to forgive me fo=
r not
> > > > thinking the C tests are noticeably faster than python tests. Or th=
at
> > > > they aren't their own potential source of corner-case bugs. But I
> > > > digress..
> > >
> > > Welcome to my world. I bisected my lab devices so many times to try to
> > > isolate all the breakages that have crept in. What is the problem,
> > > maybe I can help?
> >
> > Sure. test/cmd/hash.c::dm_test_cmd_hash_md5 fails randomly, in maybe 1
> > out of 100 runs, via pytest, in sandbox. Not via "./u-boot -T -c 'ut dm
> > dm_test_cmd_hash_md5'" however (I stopped checking after 1000
> > iterations). I was iterating over "and built with clang" but I think it
> > happens with gcc too, from the actual failures in CI. And you can use
> > "-k ut" to limit to just what's matched there, so it's a quicker
> > iteration.
>=20
> Hmmm do you have a link? It's hard to imagine what it is, but perhaps
> a dependency on a previous test.

Sure:
https://source.denx.de/u-boot/u-boot/-/jobs/993200#L286

My current gut feeling is that we've got some section overlap issue
somewhere. And, FWIW, if I turn off EFI_LOADER I still see it. And if
you use the same binary it won't always fail.

> At present 'ut all' fails so I am going to take a look at that. Quite
> a bit of clean-up needed in test system, though. Ideally we could run
> the tests in random order so we can find and fix the dependencies. For
> driver model we reinit as needed, but that's not the case for EFI, for
> example.

Personally, for making pytest faster I'd look at the general
recommendations various blog posts about "make your pytest run faster"
and then go from there.

> > > > And yes, taking a bunch of text and parsing it, is what python is f=
ast
> > > > at. And easier to write.
> > > >
> > > > > But actually [5] is not generic, since EFI uses its own code to r=
emove
> > > > > devices. This test is solely focussed on EFI.
> > > >
> > > > Yes, you're testing the EFI version of the code in
> > > > arch/$(ARCH)/lib/bootm.c. The remove devices functions being called=
 in
> > > > both cases are generic.
> > >
> > > The code in EFI is:
> > >
> > > if (!efi_st_keep_devices) {
> > > bootm_disable_interrupts();
> > > if (IS_ENABLED(CONFIG_USB_DEVICE))
> > > udc_disconnect();
> > > board_quiesce_devices();
> > > dm_remove_devices_active();
> > > }
> > >
> > > It does call somewhat the same functions, but is doing its own thing,
> > > not even using the arch-specific code. As I mentioned, a nice clean-up
> > > would be to make bootm_announce_and_cleanup() common.
> >
> > Yes, we almost agree? Both the EFI code, and arch/$(ARCH)/lib/bootm.c
> > have functions that make the above calls. A nice clean-up would be to
> > have something common.
>=20
> Yes indeed. It still does not provide a test for the EFI bootmeth,
> though, where I found half a dozen bugs.

Yes, the bootmeth code is it's own thing.

> > > Actually, now that I see efi_st_keep_devices, I wonder why Heinrich
> > > didn't want my ANSI patch[6] which serves a similar function.
> >
> > No? Your patch disables ANSI output in those tests, that variable is for
> > making sure those tests can accomplish (if I skim things right) similar
> > kinds of tests you've asked for before, but with an EFI app instead? But
> > perhaps better to not start yet another tangent here...
>=20
> I wouldn't know where to start, anyway...
>=20
> > > > > If you want the logging to be renamed and placed centrally I don't
> > > > > mind doing it now. But note that only EFI will use it for now.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > We already have function _log() which is variadic.
> > > > > > > >
> > > > > > > > Simon could write a new log driver that parses the `format`=
 parameter
> > > > > > > > and saves the binary data in an appropriate format for anal=
ysis by the
> > > > > > > > unit tests:
> > > > > > > >
> > > > > > > > * For %s the driver should save the string and not the addr=
ess of the
> > > > > > > > string.
> > > > > > > > * For %pD the driver should save the device path instead of=
 the pointer.
> > > > > > > > * ...
> > > > > > > >
> > > > > > > > Some changes to the log driver interface will be needed to =
pass the
> > > > > > > > variadic arguments instead of the formatted message.
> > > > > > >
> > > > > > > Perhaps the word 'log' is confusing people. But the above sug=
gestion
> > > > > > > is quite a complicated way of handling things. We have no way=
 to
> > > > > > > decode printf() strings in this way. See log_dispatch() for h=
ow this
> > > > > > > is handled today. It uses sprintf(). Trying to test based on =
text
> > > > > > > output would be very clumsy (lots of regexes and sscan() call=
s?) and
> > > > > > > result in a huge amount of parsing code, highly dependent on =
the
> > > > > > > printf() format, etc.
> > > > > > >
> > > > > > > I very-much doubt that would produce a useful implementation,=
 but if
> > > > > > > you would like to try it out then I would be happy to look at=
 it.
> > > > > > >
> > > > > > > I mentioned this several times, but even if we did go that wa=
y, we
> > > > > > > only have logging on the external calls, so much of the EFI-m=
emory
> > > > > > > allocation in U-Boot would not be logged.
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon
> > > > > > >
> > > > > > > [5] https://patchwork.ozlabs.org/project/uboot/patch/20250106=
144755.3054780-9-sjg@chromium.org/
> > > > > >
> > > > > > Yes, calling this a "log" when it's intended for capturing info=
rmation
> > > > > > for tests got some of this off on the wrong track. But that als=
o helps
> > > > > > explain now that this is still on the wrong track and should in=
stead be
> > > > > > following normal design practices for testing and expanding exi=
sting
> > > > > > infrastructure and not inventing a new everything. So if you do=
n't like
> > > > > > Heinrich's suggestion, take a look at Caleb's suggestion.
> > > > >
> > > > > I don't have the energy to port the tracing framework from Linux =
to
> > > > > U-Boot, although I agree it would be useful. Still, function trac=
ing
> > > > > is quite fragile and confusing to work with when refactoring code=
=2E I
> > > > > don't like that idea much for this use case, although if function
> > > > > tracing did exist in U-Boot I would likely have used it.
> > > >
> > > > I mean yes, it would be good if you went back and expanded on the t=
race
> > > > functionality you did before.
> > >
> > > I still don't believe it is the best solution and seems like yet
> > > another ocean I should avoid sticking my heater into.
> >
> > I strongly disagree. If you go back to the trace code you brought in to
> > start with and make it more useful / include newer features existing
> > elsewhere you're not going to end up in conflict with everyone asking
> > why you're doing something subsystem specific.
>=20
> Perhaps someone else could do this? It would be a substantial amount
> of work to bring runtime tooling into U-Boot, bpf and the like. It
> would be quite a pain to use, I suspect, and certainly not possible to
> write a simple C test as I have done here.

I'm not sure where bpf and the like comes from in what I said here. But
again, if you find that logging thing you wrote handy, keep it in a
topic branch somewhere and then later on you can "Told You So" the rest
of us later on.

> > > > > > And if you
> > > > > > don't like Caleb's suggestion, go put this in a topic branch yo=
u can
> > > > > > merge when you need to debug some problem that seemingly nothin=
g else
> > > > > > will catch.
> > > > >
> > > > > Here we are over a year after I reported the bug and we still don=
't
> > > > > have a test to cover it. This series is better than the available
> > > > > alternatives, IMO.
> > > >
> > > > Well, no. We have commit dabaa4ae3206 ("dm: Add
> > > > dm_remove_devices_active() for ordered device removal") we have a t=
est
> > > > for the underlying problem. We need more functional boot tests, but=
 we
> > > > need those to be in python too, and not more C code.
> > >
> > > That is a nice improvement, but did not fix the underlying problem.
> > > The underlying problem was that EFI was calling exit-boot-services,
> > > causing U-Boot to free up data structures which were needed to boot.
> > > This was on x86_64. I never quite figured out which one (very hard
> > > when you cannot get back to U-Boot to check).
> > >
> > > There were quite a lot of problems, actually. There v2 series is at [=
7]
> > >
> > > Only a C test can check what actually happens inside U-Boot.
> >
> > Yes, I think now we get back to disagreeing on which symptoms lead to
> > which code problems and then what to do about them.
>=20
> OK
>=20
> >
> > > > And you're not just coming up with a test, you're refactoring a bun=
ch of
> > > > code and introducing new subsystems in order to do that. When as I =
keep
> > > > pointing out, we don't need that. We could easily extend the existi=
ng OS
> > > > boot tests we have to script booting an ISO. And we only run those =
when
> > > > say "ENABLE_SLOW_TESTS" is set, and only do that on tagged releases.
> > >
> > > Yes of course we need to refactor to make tests work. This is not
> > > necessarily a bad thing, as it helps us break code down into testable
> > > chunks. We cannot rely only on large functional-tests, not that you
> > > are suggesting that. See [8], but they are too slow, too hard to debug
> > > when they fail. They also tend to devolve into chaos as people get
> > > lazy and stop writing unit/smaller tests.
> >
> > I'll just note that I don't ever even think to use "make tests" or
> > "qcheck" or any of the others since they never work for me.
>=20
> Would you mind filing an issue on that? I use 'make pcheck' all the time.

Done:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/33

I didn't file one for "qcheck" which fails differently in that same
environment.

--=20
Tom

--3w+NulUv/ApAK6aX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFdYAACgkQFHw5/5Y0
tywCtwv+LuP9rgKCX7Scnw+1TbluiJSolOQF0Y4Lf+6wEar7ZeBhzCbyQ3NY2I+K
tc6Vv71Osw2SdbaKww+q36en6d76MKIn2DsLQCYy1JAuEjju/FjneeKTTYXgFj4j
g/lS/jhZ8iTknwH2Nu+CE+q9FRVL1zQB23S6XmZtJcUWQsWenQvyGza8o+9TC+e/
r5PQ8fjRmfPZ0OnXVh3qHbNYr40cV6ZAZXrhH+Oq2Dsi36MJq68cAZyYmaTEU0Xq
55z1HTqZWX4P20OHazMxY9Zz1SIf+zR/8ZIpV+cKYZ3bGFgy0bBbXdxxVoEb4Vp9
CDSC2G1gWu/E0SlMYHK75ro3NQTasmRolUTyC9IuKBnzxHsxqZGWcyh0MfkPKGHA
AGyMG9jHdH3HDn4WAgDkK1PvxCOo1vEXuwjL8cLY4zyXodmd0dFCmTGRL7HntGsR
5myVo2x/IhYqCGppD4xTiuU0/3biS2uLaUNTRZbMQnLORuNB1wf3YoRphZKFACPb
F7NOcaLB
=QsXB
-----END PGP SIGNATURE-----

--3w+NulUv/ApAK6aX--
