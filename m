Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C7E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 19:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291358006D;
	Wed,  8 Jan 2025 20:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c2mwuCyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB23800D0; Wed,  8 Jan 2025 20:15:05 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356158001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 20:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46772a0f85bso395661cf.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 11:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736363702; x=1736968502; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zUzHK+OUKURKhS3fPAdvNwLIs/qNqtw4qNuZUbFtXGw=;
 b=c2mwuCyPM2naMF9gWKmWzM5OTUmt/k1eparD21WhfDRfsTTuAsLc3OdRTGFZkNguZA
 KgE7QDMZCMsocuWR2xfFCe5/z6aQRO8r3Ifr2ynEn1qwRB5i7QkLfizAMw/16j/4UjFr
 uTlsRoZneT+B+MvynWg5KJmAsQid0+WKhEBPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736363702; x=1736968502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUzHK+OUKURKhS3fPAdvNwLIs/qNqtw4qNuZUbFtXGw=;
 b=TQpy8umk4OKZ07BkecJARRTz596NTJxsGWj1N4PzSb9IJQZUVHldDAbOWPWHO7kVMb
 YzW2y6Y96nhfEsj6WMLcgeurZ1Aw31VYUvr8uhHWb4wYNQThn2G2guxe5FpAZeLeBvn5
 fCpd3vbgs1gjl3z2DjH0qjaiadLzQsCQH6m8p7ewMVnU+hVWhvYFbxJpPMlHQ/Mb0NzR
 wDwe5qyQ+vB8SWKWIF6EUG+FCMWlO5IkK+wtZLp6m8rCexp5uLSz7H42z4tGrv9ujVRs
 j4WSvYewDbxSl9QthpMNio1cvDewTsAOkUzhL21d+VcfBl/i53dT2PjEXQv2RIITXqZ3
 TTWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfnDixVGt4qg3CU3yBAcwGGJe/j9tS9rR8JQN6+/l6EHnbSzeb8Ode99H64jqTQJQpc4Z3D5U=@lists.denx.de
X-Gm-Message-State: AOJu0YxDzI/uZpb1lpTOLD5Ct6WiJi+HQ46H2jO6ZPRUHVvtD/jDV2rQ
 aWJVOfc5tcAnEbHWKdpIi7iV5eTUopRp+2QJZQ0fw/UtVx/ARbPAYpWaIzsrNjA=
X-Gm-Gg: ASbGncsmQEFLZo7nU6jVybzmdW7tP3JiCWRNgEaZz1d/g6OYvItnfg7AT8TkWHoIVsJ
 g6478jV4mmmHjspjijF+xYy5gV8oRPD50Mrw51TYg6RBevunEF+iYm3K70eymxJstEBXRMlV/xp
 OKOcW+nfLLUUnBYAb807tlP6lZFZ6bPFgE3OukaXikvfJjc4+0OP8HR8vrEreaoLJ9VZw1WtD7c
 D1L0zutD19aH/4r0gsvQQf/YjZ2LD9fvOfRDgisD8hk/LzxJiAHL3s=
X-Google-Smtp-Source: AGHT+IEa1F8s3R05pDw/Rm2lwdMxI4FrkHCI74ZQm/KY07+YogbJW58yf/JYnlF5mOgEY16mCmrxBA==
X-Received: by 2002:a05:622a:1a96:b0:461:9d9:15c2 with SMTP id
 d75a77b69052e-46c7107de32mr47213631cf.1.1736363701865; 
 Wed, 08 Jan 2025 11:15:01 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e653f52sm198669001cf.16.2025.01.08.11.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 11:15:00 -0800 (PST)
Date: Wed, 8 Jan 2025 13:14:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
Message-ID: <20250108191457.GQ3476@bill-the-cat>
References: <20250106144755.3054780-1-sjg@chromium.org>
 <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
 <CAFLszTi5dxQyf_wRpGWRz9S7YsETpeRxA3_YJrhm+Lp0uw7bmw@mail.gmail.com>
 <3b854695-990e-47f3-a9b8-34b1b2790d28@gmx.de>
 <CAFLszTieNX4-JJqQrdNdm+sBhnBHZrAwawvQ+J-D3s118uob2w@mail.gmail.com>
 <20250107151127.GI3476@bill-the-cat>
 <0d35cb20-3509-419b-ad4e-7736a35398f0@gmx.de>
 <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TKQL/GeOR2jIUrzA"
Content-Disposition: inline
In-Reply-To: <CAFLszTgWe7-zDejNzn1+QDLhjAHz8e=m+r5zYSmf91RAY=ZkTQ@mail.gmail.com>
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


--TKQL/GeOR2jIUrzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2025 at 10:02:52AM -0700, Simon Glass wrote:
> Hi Heinrich, Tom,
>=20
> On Tue, 7 Jan 2025 at 08:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 07.01.25 16:11, Tom Rini wrote:
> > > On Tue, Jan 07, 2025 at 06:57:50AM -0700, Simon Glass wrote:
> > >> Hi Heinrich,
> > >>
> > >> On Tue, 7 Jan 2025 at 06:11, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > >>>
> > >>> On 07.01.25 13:15, Simon Glass wrote:
> > >>>> Hi Heinrich,
> > >>>>
> > >>>> On Mon, 6 Jan 2025 at 10:00, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > >>>>>
> > >>>>> On 06.01.25 15:47, Simon Glass wrote:
> > >>>>>> This test was hamstrung in code review so this series is an atte=
mpt to
> > >>>>>> complete the intended functionality:
> > >>>>>>
> > >>>>>> - Check memory allocations look correct
> > >>>>>> - Check that exit-boot-services removes active-DMA devices
> > >>>>>> - Check that the bootflow is still present after testapp finishes
> > >>>>>>
> > >>>>>> The EFI functionality duplicates bootm_announce_and_cleanup() an=
d still
> > >>>>>> uses the defunct board_quiesce_devices() so a nice cleanup would=
 be to
> > >>>>>> call the bootm function instead, with suitable modifications. Th=
at would
> > >>>>>> allow bootstage to work too.
> > >>>>>>
> > >>>>>> This series is based on sjg/master since the EFI logging was rej=
ected so
> > >>>>>> far.
> > >>>>>
> > >>>>> Yes, it was rejected because a solution at the lib/log.c level wo=
uld be
> > >>>>> more generic.
> > >>>>
> > >>>> As I mentioned, that idea isn't suitable for programmatic use.
> > >>>
> > >>> What can be done with show_addr("mem", rec->memory); that log_debug=
()
> > >>> does not offer or which you could not do with a new log function in
> > >>> lib/log.c that takes variadic arguments?
> > >>
> > >> There are asserts in [1], for example. How do you propose to handle
> > >> that? See [2] for my previous explanation, quoted here:
> > >>
> > >>> CONFIG_LOG with a bloblist option would be a great idea, but it's h=
ard
> > >>> to programmatically scan text...plus only the external call sites a=
re
> > >>> actually logged.
> > >>
> > >> Also see the discussion on the original patch [3]. There was also yo=
ur
> > >> reply at [4], but I think you missed that this is intended for use in
> > >> unit tests (i.e. with ut_assert()).
> > >>
> > >> You also requested that this be generalised, rather than being
> > >> EFI-loader-specific. I have no objection to that, but don't have a u=
se
> > >> case for it yet, so have deferred that to later. It's a fairly simple
> > >> change, if/when needed. If the series was not NAKed, I'd be happy to
> > >> do it now.
> > >>
> > >>>>
> > >>>>>
> > >>>>> Tom suggested not to send patches that are for private enjoyment =
to the
> > >>>>> mailing list.
> > >>>>
> > >>>> My contributions to U-Boot are only ever about private enjoyment :=
-)
> > >>>>
> > >>>> Do you have any comments on the patches?
> > >>
> > >> Regards,
> > >> Simon
> > >>
> > >> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.=
3054780-6-sjg@chromium.org/
> > >> [2] https://lore.kernel.org/u-boot/CAFLszTjxOE_037+kR0jgdax80sBombYo=
_k0YgiuVnP=3DKZCOvuA@mail.gmail.com/
> > >> [3] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=3Dx=
+M4=3DUY_O6roSOpZaDxag@mail.gmail.com/
> > >> [4] https://lore.kernel.org/u-boot/D513D326-41A6-425E-B11F-85958065B=
CD2@gmx.de/
> > >
> > > Looking at the logging portions of the original series again, especia=
lly
> > > if this was made generic, we probably don't want to print to actual
> > > console every time we're making a note of some memory allocation for
> > > example, that would be unreadable outside of a debug context. The poi=
nt
> > > of this really seems to be "log things for verifying in tests later".
> > > Does that end up being useful? I don't know. Heinrich or Ilias, do the
> > > tests in [1] look generally useful?
> > >
> >
> > The tests in [1] are not documented, not even in the commit message. So
> > the reasoning behind the tests remains Simon's secret.
>=20
> Are you asking for code comments in the test? If so, I can add some.
>=20
> >
> > At first sight the tests in [1] don't make much sense. E.g. that only a
> > subset of memory types have been used does not tell that the right
> > memory type has been used for the right object.
>=20
> It is a pretty good start, though. It makes sure that the memory types
> are sane, checks addresses are within DRAM, etc. With [5] it makes
> sure that devices are removed.
>=20
> >
> > Implementing a specific tracing functionality for EFI is definitively
> > the wrong way forward as it will lead to code duplication.
>=20
> We can cross that bridge when we come to it.

Well, no. It's backwards to make a bridge in one place when everyone
agrees it needs to be moved somewhere else. I mean [5] is a generic
issue and test/py/tests/test_net_boot.py or some other test we already
have which tests booting an OS should confirm that we've quiesced
devices before moving on. And as a bonus it's in python where dealing
with strings doesn't suck.

>=20
> >
> > We already have function _log() which is variadic.
> >
> > Simon could write a new log driver that parses the `format` parameter
> > and saves the binary data in an appropriate format for analysis by the
> > unit tests:
> >
> > * For %s the driver should save the string and not the address of the
> > string.
> > * For %pD the driver should save the device path instead of the pointer.
> > * ...
> >
> > Some changes to the log driver interface will be needed to pass the
> > variadic arguments instead of the formatted message.
>=20
> Perhaps the word 'log' is confusing people. But the above suggestion
> is quite a complicated way of handling things. We have no way to
> decode printf() strings in this way. See log_dispatch() for how this
> is handled today. It uses sprintf(). Trying to test based on text
> output would be very clumsy (lots of regexes and sscan() calls?) and
> result in a huge amount of parsing code, highly dependent on the
> printf() format, etc.
>=20
> I very-much doubt that would produce a useful implementation, but if
> you would like to try it out then I would be happy to look at it.
>=20
> I mentioned this several times, but even if we did go that way, we
> only have logging on the external calls, so much of the EFI-memory
> allocation in U-Boot would not be logged.
>=20
> Regards,
> Simon
>=20
> [5] https://patchwork.ozlabs.org/project/uboot/patch/20250106144755.30547=
80-9-sjg@chromium.org/

Yes, calling this a "log" when it's intended for capturing information
for tests got some of this off on the wrong track. But that also helps
explain now that this is still on the wrong track and should instead be
following normal design practices for testing and expanding existing
infrastructure and not inventing a new everything. So if you don't like
Heinrich's suggestion, take a look at Caleb's suggestion. And if you
don't like Caleb's suggestion, go put this in a topic branch you can
merge when you need to debug some problem that seemingly nothing else
will catch.

--=20
Tom

--TKQL/GeOR2jIUrzA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+zqcACgkQFHw5/5Y0
tyykNgv/aeLNulXe2f0QfipE6o+U8P8pdg4gf9IE6eWo1VN+TBhWKXNtn0gQ5xlG
cxIe6eIB7ef212Wsql3/7NfT2wOfUcaWb5tzaSkbvWr9Gr5RfVlszM+WuFUahxm8
EtK/arRrx3ED05rOJZ/M6r4TSotsryVHYQZ1lNaeqBGoRTSH2L8ziZJX+P3Qz1KP
6x9n4/ExejvGta07FDY1ibXeAPbu9jUR5Nnhn5svtDLOlH5YSPE7w2iz9E/pR0Ke
63Wxpw+SvUa7SUszrLwZMaD04N4P+zHx67w3gPiiHlLIQqWjm5YLtHVUI+DFBfJK
+WlsQW5BoPA1nYrub2scguytm+OoBt03Ftj5w476mJ53BRklB7r6qDqeuPHCh5sm
MqArvItHHKRVvBYaq0s7Pi3bDAhr+9AMLSqH1Wlm+EyXgD/3n5jSgnndZtZH0TnJ
lgBO8WcOW6NPHRIdf0Z6fdm8azNuoFPrBj5Vg0IA1YASNblnTPBvF6b3Hh5WQ/CU
knr5zk5I
=8OiL
-----END PGP SIGNATURE-----

--TKQL/GeOR2jIUrzA--
