Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F1DC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CAAB80EC0;
	Sat, 25 Jan 2025 23:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wqf9kGrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D7680ECD; Sat, 25 Jan 2025 23:01:26 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737B580C91
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-467b955e288so36535751cf.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737842483; x=1738447283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qkkp754RXXx2fEb6hxx6hVzpkOgFfOy629Ds9UEpqpw=;
 b=Wqf9kGrsr42OOZc3KqvX00RTkjhB4Rk9YApyqu2ECeP+5sz9s5d9FtbnOuZweP99Kw
 zwTofUW/gnyqVFO/+ooQfcOQPzYYqNzshaU3s/o8bMfHEUKIGPbNtmCn8CIbDsYdtPnH
 Y98kG1znlcd/Qby0UEOFY/4vJds+TMEasrNng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737842483; x=1738447283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkkp754RXXx2fEb6hxx6hVzpkOgFfOy629Ds9UEpqpw=;
 b=D4stNZhmEXvudoDPhcvkOsl1il6SvTOzO1SDoqEzOtbrN0J/Qw4GsDw6Z8iTX/qNuo
 ZKiNwNkVoxw60IcmNouBxFjAC+wbL2cj00ppuizfLBhwIyypzwyALd2swVO9qveu+JSG
 cKM9d5VaPp+I7ZF9AUPANcSScr5Vd0t9aQ5lp1BIx/TjrWmx+gXUXVAnPQACIvLIDKfK
 EgdOoJPcKSaMCi0neCNKvJqfnJ333KoHp9AhEmlphyhseHFVN+iTxeO7Hgl7aL+tx5NZ
 QeqUPpNSzXZ4gGVXJ1aALEP0v4O7Ce9ZVCU9a96GL3VfSor8vgwLbTamBYCXJ6SuNXKr
 M8PQ==
X-Gm-Message-State: AOJu0Yw5XzK0Rw78zZ+UP7mFRSbFx/Yc8wjsHp8sygJgbZSvaPh7f2vx
 Pk/oUmxl/QkS5czNmb3fbS2QWlMDdbY/Zo9xATEZH73XRSjp0OBthegp4iaUxR6SUMvmCg/iJob
 J
X-Gm-Gg: ASbGncsYGEqMkGWCIAXXNAHAR+SP7/SmGZNR44+vFr9iwyAyXhtHxfAGzeyw0Yrb1wd
 DyZ+J/BPR3uuH0sBFOdgHxpydEZOpYOAXG+SxpCmIzdcr42pKxXJmk4FOJrUaxTRIb05TSdboPp
 5eCMEn+5K48g9MDjUu0aGyLEe65VkaB3rhvM0FHrTEMRGpzpbO0CbrBtD96wOTlHDeeYTRQ5RNv
 C9t5BUDVkqnXNQe/Dl1kxgtEddwgTBixD5JraZVztG9y7kebYMhrrIsdOAQJeYU/BwKGzPs3cvG
 P45l
X-Google-Smtp-Source: AGHT+IG3I5FvrHBy+cHlD2TNfhpPHpTYYMd+oXP7wBaPUFc5SaAmQ95U9lyGdgBqyLhPUTymlf86yg==
X-Received: by 2002:ac8:5907:0:b0:467:5e4f:3d1 with SMTP id
 d75a77b69052e-46e12b90bc8mr534942711cf.33.1737842483130; 
 Sat, 25 Jan 2025 14:01:23 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66880349sm24133701cf.28.2025.01.25.14.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 14:01:21 -0800 (PST)
Date: Sat, 25 Jan 2025 16:01:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Add a report show test durations
Message-ID: <20250125220119.GG60249@bill-the-cat>
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
 <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eB4GeeWidCib5OIE"
Content-Disposition: inline
In-Reply-To: <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
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


--eB4GeeWidCib5OIE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:36:52PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > > >
> > > > > Execution time varies widely with the existing tests. Provides a =
summary
> > > > > of the time taken for each test, along with a histogram.
> > > > >
> > > > > Example:
> > > > >
> > > > >    Duration : Number of tests
> > > > >    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > >        <1ms :  1
> > > > >        <8ms :  1
> > > > >       <20ms : # 20
> > > > >       <30ms : ######## 127
> > > > >       <50ms : ######################################## 582
> > > > >       <75ms : ####### 102
> > > > >      <100ms : ## 39
> > > > >      <200ms : ##### 86
> > > > >      <300ms : # 29
> > > > >      <500ms : ## 42
> > > > >      <750ms : # 16
> > > > >       <1.0s : # 15
> > > > >       <2.0s : # 23
> > > > >       <3.0s :  13
> > > > >       <5.0s :  9
> > > > >       <7.5s :  1
> > > > >      <10.0s :  6
> > > > >      <20.0s :  12
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 77 insertions(+)
> > > >
> > > > Whitespace issues aside,
> > >
> > > Do you mean the blank lines? pylint wants those for top-level items.
> >
> > That's weird but OK.
> >
> > >  we should probably not do this every time, just
> > > > when requested.
> > >
> > > I'd like to see it on each run, actually. It doesn't take any time to
> > > calculate and it lets us see where the time is going.
> >
> > We already print the full time, and I think knowing what the tests are
> > that take so long, so that we can see if there's anything to do about
> > it, would be more helpful. The general feedback about our pytests today
> > is they're already too verbose in the normal case.
>=20
> This is what is shown in the full output (although with CI you have to
> download the files to see it):
>=20
> [-] Section: Timing Report
[snip]

This is handy as a one-off, and maybe hints at a few tests to look at
more, but perhaps it's mostly "is what it is" tests (and not just the
sleep test).

> TIME: SINCE-SECTION: 0:00:00.004227
>=20
> This is just the summary which is visible in CI:
>=20
> [-] Section: Timing Summary
> TIME: NOW: 2025/01/25 14:28:57.730179
> TIME: SINCE-PREV: 0:00:00.004234
> TIME: SINCE-START: 0:02:00.307984
> TIME: SINCE-SECTION: 0:00:00.000041
> Duration : Number of tests
> =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     <4ms :  1
>     <8ms :  1
>    <10ms :  3
>    <20ms : #### 47
>    <30ms : ######################################## 377
>    <40ms : ############################# 278
>    <50ms : ####### 69
>    <75ms : #### 47
>   <100ms : # 18
>   <200ms : ### 29
>   <300ms : # 15
>   <400ms : # 13
>   <500ms :  8
>   <750ms :  6
>    <1.0s :  2
>    <2.0s :  9
>    <3.0s :  3
>    <4.0s :  4
>    <5.0s :  2
>    <7.5s :  2
>   <20.0s :  1
>=20
> So what do you think would make most sense?

By default, neither of these, and only when requested. Looking over at
one of your runs, no, I don't want to waste more output space. If you
must do something, log it off to examine later and not add to the main
output.

--=20
Tom

--eB4GeeWidCib5OIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVXygACgkQFHw5/5Y0
tyxsWAv/Y6cudG1+/aGxvzfe0UZfYXBEd34vtESjyq55TGA/qNhGgjV+SqqV9Aha
V2pRNZZEu0cuktbqTqWMBtBGwX2UIQSTFudW3yFOb5JgDksT18PTBQatKGWD5ed0
Yul2amzIlZ650prxl14Nv0lFBXk/uv8Bqh3DEJmGXpa+o/zYikUQU3O3bKVzK8k/
SPy0JSbsmPMXjkZbR6IBsyimx3CIxiNVSvxmVRhv+4vscI2+oZOsscn/q0BZWw19
fHbkhOG2H/PKKPa5PkbLRTFoR+fOZ/1HGlE4APs9NXGHU/C4o32T0IkFT7hzKEQi
CGyRngAGbQ3zuIigYMviFRSFgggjfiGmACOpSUTvj+vs6Tgoo0TeBJ/8NWgCjX+z
DIwC92jl9jiaFXtL+ZnptOSURxFI30losJLVREp0VzO090zZ7EZ/pbJEoDP8A90X
BMW+j0twyWPtk0Esm4s1ZInyJuAIOh9+3nXTQph+IhpxrtHdnb2fUljEjXg1bTCI
rGMo1cC/
=2rm6
-----END PGP SIGNATURE-----

--eB4GeeWidCib5OIE--
