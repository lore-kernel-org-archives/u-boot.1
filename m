Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2D3E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 16:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA18F8005B;
	Thu,  9 Jan 2025 17:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPyrT5ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7DA80107; Thu,  9 Jan 2025 17:51:29 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B238001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 17:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8f916b40bso14245066d6.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736441485; x=1737046285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5XS6qMZd67K3nERYh2lcHIInIXq0X50k5FOQ6VCwzzQ=;
 b=EPyrT5aiHENarG8cqFW1xjp8s/PP2XSQy4RSiW6JJKct7b3vL6mpcAlwQKaKptkVQx
 oUfCQeBwpA1dHD9xC1IcBg1UqzQDQPNG1TUxtuLo+sKO+IAokmuozABw9XqPR6xnjhWN
 KIXPM12eqOyJ6WP0TnGmlo7G0BT2Czn3ReA6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736441485; x=1737046285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XS6qMZd67K3nERYh2lcHIInIXq0X50k5FOQ6VCwzzQ=;
 b=ln4P7c9Av9xjfbO7EjKUVHGuJU+s5JgvfxiktAnjwxRF/5jCn047UcQiqe7w8nqWF1
 G3VkSKF78dr8ZglX5/WAcfPGPbbeyl3gxeF+gWD6DsXials/DgFFN18DAvhhyCFumM8B
 HXd3/IFQ5YHHm6z4146lRbzfnESYsAB5fgusdpUp2YMV1tDsHnzvcl1SVkmXn+w2pyzx
 ePQemugdUCysijoch+neUuREcOaBAydyHKghcD8iJh0rEX5pkEMe7DNULzS3LrRUVWnT
 dZvle/Jr8w1uxnpK+CuQ0WA9A5cnwb0/QCZWgThVaWKQf+m1W8RhmJ0Bmq0oNv7GF8eo
 lvXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+NnJ1ctnn+47XhzDy4DS7qizhArahB4rBYofoDRSwemCWkhjjJfWjI2OmmSMTvorp0aqriKc=@lists.denx.de
X-Gm-Message-State: AOJu0YzAAjVkIZouUi7b/pxYskhlOymOzHtpuYMjxXys3wnzWCXlYMby
 Xu0NQKZBZ/T8KK0lIyk3/sKFZ47yEmio0DRgKFHFAUKUhEByjo4o2/f1kaz5mdw=
X-Gm-Gg: ASbGncvC5GZ48LgHZYWxsfpyMpWuRNa5AHGUXEYoB4ASKUfmhsDXWEOmpO3syMYpayf
 Gnkd0/zLy4JAPO2OO7eP6w8TL9o4ZmTe6pg9aHb5X9D+J4mnK/McnOhXp9ncZpONQ+dLx8lH8Ly
 TIbCFE3IpZ+FJt+OV9v+cQPy53FohdzUlGfYID+4QglbmKPAXQGZeQT3aT+SPiH1PdyN768mJHz
 46y2eNoB8tVAIuwnd+dh6hjESGEIG6P+8Ayd8WU3pOmFvajLYYay9U=
X-Google-Smtp-Source: AGHT+IFQ+DU5SOQjmN/jnIp4LRDrHg30JHFk5YTcn4EOaZBY1uk8isqE7gdoyr+j0jiZF0hpd2y6YA==
X-Received: by 2002:a05:6214:3197:b0:6d8:9be9:7d57 with SMTP id
 6a1803df08f44-6df9b28be85mr120561716d6.37.1736441485005; 
 Thu, 09 Jan 2025 08:51:25 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f5easm150176d6.2.2025.01.09.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:51:24 -0800 (PST)
Date: Thu, 9 Jan 2025 10:51:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250109165121.GZ3476@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRlVKYpts9GDTFID"
Content-Disposition: inline
In-Reply-To: <CAFLszTh8BZGEpTs_gxo89dMdd6v3PmuFtTMHxmfGXDUwmdaMfQ@mail.gmail.com>
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


--MRlVKYpts9GDTFID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 08:02:01AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Jan 2025 at 12:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> > > Hi Heinrich, Tom,
> > >
> > > On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > > >
> > > > On 07.01.25 16:11, Tom Rini wrote:
> > > > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> > > > >> Hi Heinrich,
> > > > >>
> > > > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
> > > > >>>
> > > > >>> On 07.01.25 13:15, Simon Glass wrote:
> > > > >>>> Hi Heinrich,
> > > > >>>>
> > > > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> > > > >>>>>
> > > > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > > > >>>>>> This test was hamstrung in code review so this series is an =
attempt to
> > > > >>>>>> complete the intended functionality:
> > > > >>>>>>
> > > > >>>>>> - Check memory allocations look correct
> > > > >>>>>> - Check that exit-boot-services removes active-DMA devices
> > > > >>>>>> - Check that the bootflow is still present after testapp fin=
ishes
> > > > >>>>>>
> > > > >>>>>> The EFI functionality duplicates bootm_announce_and_cleanup(=
) and still
> > > > >>>>>> uses the defunct board_quiesce_devices() so a nice cleanup w=
ould be to
> > > > >>>>>> call the bootm function instead, with suitable modifications=
=2E That would
> > > > >>>>>> allow bootstage to work too.
> > > > >>>>>>
> > > > >>>>>> This series is based on sjg/master since the EFI logging was=
 rejected so
> > > > >>>>>> far.
> > > > >>>>>
> > > > >>>>> Yes, it was rejected because a solution at the lib/log.c leve=
l would be
> > > > >>>>> more generic.
> > > > >>>>
> > > > >>>> As I mentioned, that idea isn't suitable for programmatic use.
> > > > >>>
> > > > >>> What can be done with show_addr("mem", rec->memory); that log_d=
ebug()
> > > > >>> does not offer or which you could not do with a new log functio=
n in
> > > > >>> lib/log.c that takes variadic arguments?
> > > > >>
> > > > >> There are asserts in [1], for example. How do you propose to han=
dle
> > > > >> that? See [2] for my previous explanation, quoted here:
> > > > >>
> > > > >>> CONFIG_LOG with a bloblist option would be a great idea, but it=
's hard
> > > > >>> to programmatically scan text...plus only the external call sit=
es are
> > > > >>> actually logged.
> > > > >>
> > > > >> Also see the discussion on the original patch [3]. There was als=
o your
> > > > >> reply at [4], but I think you missed that this is intended for u=
se in
> > > > >> unit tests (i.e. with ut_assert()).
> > > > >>
> > > > >> You also requested that this be generalised, rather than being
> > > > >> EFI-loader-specific. I have no objection to that, but don't have=
 a use
> > > > >> case for it yet, so have deferred that to later. It's a fairly s=
imple
> > > > >> change, if/when needed. If the series was not NAKed, I'd be happ=
y to
> > > > >> do it now.
> > > > >>
> > > > >>>>
> > > > >>>>>
> > > > >>>>> Tom suggested not to send patches that are for private enjoym=
ent to the
> > > > >>>>> mailing list.
> > > > >>>>
> > > > >>>> My contributions to U-Boot are only ever about private enjoyme=
nt :-)
> > > > >>>>
> > > > >>>> Do you have any comments on the patches?
> > > > >>
> > > > >> Regards,
> > > > >> Simon
> > > > >>
> > > > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144=
755.3054780-6-sjg@chromium.org/
> > > > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBo=
mbYo_k0YgiuVnP=3DKZCOvuA@mail.gmail.com/
> > > > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=
=3Dx+M4=3DUY_O6roSOpZaDxag@mail.gmail.com/
> > > > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958=
065BCD2@gmx.de/
> > > > >
> > > > > Looking at the logging portions of the original series again, esp=
ecially
> > > > > if this was made generic, we probably don't want to print to actu=
al
> > > > > console every time we're making a note of some memory allocation =
for
> > > > > example, that would be unreadable outside of a debug context. The=
 point
> > > > > of this really seems to be "log things for verifying in tests lat=
er".
> > > > > Does that end up being useful? I don't know. Heinrich or Ilias, d=
o the
> > > > > tests in [1] look generally useful?
> > > > >
> > > >
> > > > The tests in [1] are not documented, not even in the commit message=
=2E So
> > > > the reasoning behind the tests remains Simon's secret.
> > >
> > > Are you asking for code comments in the test? If so, I can add some.
> > >
> > > >
> > > > At first sight the tests in [1] don't make much sense. E.g. that on=
ly a
> > > > subset of memory types have been used does not tell that the right
> > > > memory type has been used for the right object.
> > >
> > > It is a pretty good start, though. It makes sure that the memory types
> > > are sane, checks addresses are within DRAM, etc. With [5] it makes
> > > sure that devices are removed.
> > >
> > > >
> > > > Implementing a specific tracing functionality for EFI is definitive=
ly
> > > > the wrong way forward as it will lead to code duplication.
> > >
> > > We can cross that bridge when we come to it.
> >
> > Well, no. It's backwards to make a bridge in one place when everyone
> > agrees it needs to be moved somewhere else. I mean [5] is a generic
> > issue and test/py/tests/test_net_boot.py or some other test we already
> > have which tests booting an OS should confirm that we've quiesced
> > devices before moving on. And as a bonus it's in python where dealing
> > with strings doesn't suck.
>=20
> I really don't want to write C tests in Python. CI is slow enough as
> it is, something realy want to fix. I'm also not sure how you can tell
> if a device has been removed. Run 'dm tree' and look for the missing
> 'star' in the resulting 300 lines of text?

As I'm in a bisect-hell in our C tests you'll have to forgive me for not
thinking the C tests are noticeably faster than python tests. Or that
they aren't their own potential source of corner-case bugs. But I
digress..

And yes, taking a bunch of text and parsing it, is what python is fast
at. And easier to write.

> But actually [5] is not generic, since EFI uses its own code to remove
> devices. This test is solely focussed on EFI.

Yes, you're testing the EFI version of the code in
arch/$(ARCH)/lib/bootm.c. The remove devices functions being called in
both cases are generic.

> If you want the logging to be renamed and placed centrally I don't
> mind doing it now. But note that only EFI will use it for now.
>=20
> >
> > >
> > > >
> > > > We already have function _log() which is variadic.
> > > >
> > > > Simon could write a new log driver that parses the `format` paramet=
er
> > > > and saves the binary data in an appropriate format for analysis by =
the
> > > > unit tests:
> > > >
> > > > * For %s the driver should save the string and not the address of t=
he
> > > > string.
> > > > * For %pD the driver should save the device path instead of the poi=
nter.
> > > > * ...
> > > >
> > > > Some changes to the log driver interface will be needed to pass the
> > > > variadic arguments instead of the formatted message.
> > >
> > > Perhaps the word 'log' is confusing people. But the above suggestion
> > > is quite a complicated way of handling things. We have no way to
> > > decode printf() strings in this way. See log_dispatch() for how this
> > > is handled today. It uses sprintf(). Trying to test based on text
> > > output would be very clumsy (lots of regexes and sscan() calls?) and
> > > result in a huge amount of parsing code, highly dependent on the
> > > printf() format, etc.
> > >
> > > I very-much doubt that would produce a useful implementation, but if
> > > you would like to try it out then I would be happy to look at it.
> > >
> > > I mentioned this several times, but even if we did go that way, we
> > > only have logging on the external calls, so much of the EFI-memory
> > > allocation in U-Boot would not be logged.
> > >
> > > Regards,
> > > Simon
> > >
> > > [5] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.3=
054780-9-sjg@chromium.org/
> >
> > Yes, calling this a "log" when it's intended for capturing information
> > for tests got some of this off on the wrong track. But that also helps
> > explain now that this is still on the wrong track and should instead be
> > following normal design practices for testing and expanding existing
> > infrastructure and not inventing a new everything. So if you don't like
> > Heinrich's suggestion, take a look at Caleb's suggestion.
>=20
> I don't have the energy to port the tracing framework from Linux to
> U-Boot, although I agree it would be useful. Still, function tracing
> is quite fragile and confusing to work with when refactoring code. I
> don't like that idea much for this use case, although if function
> tracing did exist in U-Boot I would likely have used it.

I mean yes, it would be good if you went back and expanded on the trace
functionality you did before.

> > And if you
> > don't like Caleb's suggestion, go put this in a topic branch you can
> > merge when you need to debug some problem that seemingly nothing else
> > will catch.
>=20
> Here we are over a year after I reported the bug and we still don't
> have a test to cover it. This series is better than the available
> alternatives, IMO.

Well, no. We have commit dabaa4ae3206 ("dm: Add
dm_remove_devices_active() for ordered device removal") we have a test
for the underlying problem. We need more functional boot tests, but we
need those to be in python too, and not more C code.

And you're not just coming up with a test, you're refactoring a bunch of
code and introducing new subsystems in order to do that. When as I keep
pointing out, we don't need that. We could easily extend the existing OS
boot tests we have to script booting an ISO. And we only run those when
say "ENABLE_SLOW_TESTS" is set, and only do that on tagged releases.

--=20
Tom

--MRlVKYpts9GDTFID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd//okACgkQFHw5/5Y0
tyy2Uwv+MIug+9ws4AIwppIOe01H8xnF8pKWqkAtsMpOXLSc+vKz8Z7B7dZgEkXm
gwVWjxnepR6mTMdwPJT1yicS2AukBoehbMtfjAubi1iOH/NIUzRx8mxCeBUDHk0A
kxjg8upHw9HQ6pI3Agr9HgcI0+U49JonYUAOGJO1a/w7oi/E/LWN73ZCR05k30ud
D0h6CPiSHavUySYJeW7fARGhyOPDvFpcS1x1LPtJaJHkSd27qy279fz1iTkHC8MP
fMmIYb45Y99ZE58FpQ4/GGAGC9AUwjlEyrS4rl6zRgZDgJFzkn0AtyNAnzPt6nZD
/hXmqYX8eB5fCetjvnh/+VGphqSdxde8zC1I0f8mg6WtS0QKEP5UhLQqMjYIeexd
fFKCa+WrKm68QUVVyY5AYKEeIkebq62MqeC0dEU0jrkSHDJJi26dK2sJBABUSOzP
7vlViyyup6aDWpoX4Ryd/VHTpruyA5EZCy1t77PkWzg9mO2wffSqCkmJtIzqDtQN
jHjfHhwW
=M1Vo
-----END PGP SIGNATURE-----

--MRlVKYpts9GDTFID--
