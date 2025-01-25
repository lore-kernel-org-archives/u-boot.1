Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B30C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D8880F53;
	Sun, 26 Jan 2025 00:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kghLDAs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E18280F56; Sun, 26 Jan 2025 00:14:46 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7BAA807E4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46c8474d8daso26739661cf.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737846882; x=1738451682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ULv5fotcWA7UwvT5mFcsPZl9VFpVXSwN2Hlyftwf8sg=;
 b=kghLDAs2eQYG6UOYp1tvhRZy3v/PbIHkrwYqBZGSgaSkiDK5nysv28mzg7oXz3ht8a
 hHbCUJFes8zrurJCVkzryvvYw+Gk0r1ektjZItVVC3MtUJ9lMp8Mjz7VoKi6fdqFrBii
 ZtzWGMwiKdjn7Lpo03bVpV86+NaHMQ8Zn8ysg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846882; x=1738451682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULv5fotcWA7UwvT5mFcsPZl9VFpVXSwN2Hlyftwf8sg=;
 b=Y+dqVP104eces0Je+z1ByAACvZBIWEZE3wLSSVPlzeO59lw0cP27rAkxbqNlaB5el3
 ndFmNQFbKklOcg+R0wTxH1r7MriI5hNtk2zNhdRTKQbF7Kc8L9G+Vt3cOa+ibBX/SHDx
 s0Pu0hn02YRWWq9pUJ4R2ffSmuhr0KarpnKMfbvpaOQ/wRLNQCMhA/nGnP8AacKUi/VY
 btDsJZukcYfW3ThdwNAxVnWutBDsqKwkb/ZkADvk7ylwq25hL4ACtcjQa42cxxLcELBi
 X34rLdU1xati5yLr9Vs7TWYgaJ2JeQVXQfKgq+l80jcueEyILXKX9RRwmUJKHIVGl0uo
 +yeA==
X-Gm-Message-State: AOJu0YwHsk7fFk3ArEIK2KWO1CmmS95S33UZDT/frd2qXBIbCO5PpXxY
 +QHpepBesfxsYWJa0HRcqtTvLwqbB7sDIGXo4i7GPH6FTKzq2gXBBDxVx3gZln8=
X-Gm-Gg: ASbGncsSN0980oV3U1kHC9iVoAfiuVMdG8eN9S8hYNMKMjnStMLz2fRyKZSKjtH522X
 RrZhWAxsegSAHIWxnfk40VesQdmBJt1Xa4mBXxXmmqG6l0zhPg9yvMvgD5zVfz8POkeBg8tOnE1
 20InjOcADI4fYAiHwA9EWeZvf/xipkeDbCz0eiooU/JaYDC9qLrLIlTA50U0H3EjCae9u5TmTrr
 rG4H+2zh8qdJhR3bjVq0QIv4vLz7cYtjBWzrC+veBk0hbHlAlV7S8G7LUclLJJXSa2uKFE2R/+9
 kg8O
X-Google-Smtp-Source: AGHT+IFLGKj4hzsnV8DaamGSzGNVEcYd40ZhbFM/qowNLjgdZPT8Nba48j1K0ehE10GdIVKapI9wZA==
X-Received: by 2002:a05:622a:1210:b0:467:4b94:cfaf with SMTP id
 d75a77b69052e-46e12b987e2mr429827511cf.51.1737846882366; 
 Sat, 25 Jan 2025 15:14:42 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66ba1407sm24273621cf.81.2025.01.25.15.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:14:41 -0800 (PST)
Date: Sat, 25 Jan 2025 17:14:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Add a report show test durations
Message-ID: <20250125231438.GN60249@bill-the-cat>
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
 <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
 <20250125220119.GG60249@bill-the-cat>
 <CAFLszTgw+u3rQ8N3vqB1bZ6RdOY_poJUO_WULQ-Q+q28S46FaA@mail.gmail.com>
 <20250125225331.GI60249@bill-the-cat>
 <CAFLszTiiVcjt89cGg8SSHbM+PUQOq4_D17eLvfKZRvBxqP_5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5z78OJ1hdgXHIveM"
Content-Disposition: inline
In-Reply-To: <CAFLszTiiVcjt89cGg8SSHbM+PUQOq4_D17eLvfKZRvBxqP_5pQ@mail.gmail.com>
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


--5z78OJ1hdgXHIveM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:57:14PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 15:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 03:50:02PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 25 Jan 2025 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Jan 25, 2025 at 02:36:52PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > Execution time varies widely with the existing tests. Pro=
vides a summary
> > > > > > > > > of the time taken for each test, along with a histogram.
> > > > > > > > >
> > > > > > > > > Example:
> > > > > > > > >
> > > > > > > > >    Duration : Number of tests
> > > > > > > > >    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > >        <1ms :  1
> > > > > > > > >        <8ms :  1
> > > > > > > > >       <20ms : # 20
> > > > > > > > >       <30ms : ######## 127
> > > > > > > > >       <50ms : ######################################## 582
> > > > > > > > >       <75ms : ####### 102
> > > > > > > > >      <100ms : ## 39
> > > > > > > > >      <200ms : ##### 86
> > > > > > > > >      <300ms : # 29
> > > > > > > > >      <500ms : ## 42
> > > > > > > > >      <750ms : # 16
> > > > > > > > >       <1.0s : # 15
> > > > > > > > >       <2.0s : # 23
> > > > > > > > >       <3.0s :  13
> > > > > > > > >       <5.0s :  9
> > > > > > > > >       <7.5s :  1
> > > > > > > > >      <10.0s :  6
> > > > > > > > >      <20.0s :  12
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 77 insertions(+)
> > > > > > > >
> > > > > > > > Whitespace issues aside,
> > > > > > >
> > > > > > > Do you mean the blank lines? pylint wants those for top-level=
 items.
> > > > > >
> > > > > > That's weird but OK.
> > > > > >
> > > > > > >  we should probably not do this every time, just
> > > > > > > > when requested.
> > > > > > >
> > > > > > > I'd like to see it on each run, actually. It doesn't take any=
 time to
> > > > > > > calculate and it lets us see where the time is going.
> > > > > >
> > > > > > We already print the full time, and I think knowing what the te=
sts are
> > > > > > that take so long, so that we can see if there's anything to do=
 about
> > > > > > it, would be more helpful. The general feedback about our pytes=
ts today
> > > > > > is they're already too verbose in the normal case.
> > > > >
> > > > > This is what is shown in the full output (although with CI you ha=
ve to
> > > > > download the files to see it):
> > > > >
> > > > > [-] Section: Timing Report
> > > > [snip]
> > > >
> > > > This is handy as a one-off, and maybe hints at a few tests to look =
at
> > > > more, but perhaps it's mostly "is what it is" tests (and not just t=
he
> > > > sleep test).
> > >
> > > Perhaps, but I would hope we could speed some of these up, or reduce
> > > the number of variations.
> >
> > Looking at it, all I see is a sample that yes, we should see if there's
> > some way to speed up output from U-Boot to python. None of the "long"
> > tests look otherwise out of line for what they're doing.
> >
> > > > > TIME: SINCE-SECTION: 0:00:00.004227
> > > > >
> > > > > This is just the summary which is visible in CI:
> > > > >
> > > > > [-] Section: Timing Summary
> > > > > TIME: NOW: 2025/01/25 14:28:57.730179
> > > > > TIME: SINCE-PREV: 0:00:00.004234
> > > > > TIME: SINCE-START: 0:02:00.307984
> > > > > TIME: SINCE-SECTION: 0:00:00.000041
> > > > > Duration : Number of tests
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > >     <4ms :  1
> > > > >     <8ms :  1
> > > > >    <10ms :  3
> > > > >    <20ms : #### 47
> > > > >    <30ms : ######################################## 377
> > > > >    <40ms : ############################# 278
> > > > >    <50ms : ####### 69
> > > > >    <75ms : #### 47
> > > > >   <100ms : # 18
> > > > >   <200ms : ### 29
> > > > >   <300ms : # 15
> > > > >   <400ms : # 13
> > > > >   <500ms :  8
> > > > >   <750ms :  6
> > > > >    <1.0s :  2
> > > > >    <2.0s :  9
> > > > >    <3.0s :  3
> > > > >    <4.0s :  4
> > > > >    <5.0s :  2
> > > > >    <7.5s :  2
> > > > >   <20.0s :  1
> > > > >
> > > > > So what do you think would make most sense?
> > > >
> > > > By default, neither of these, and only when requested. Looking over=
 at
> > > > one of your runs, no, I don't want to waste more output space. If y=
ou
> > > > must do something, log it off to examine later and not add to the m=
ain
> > > > output.
> > >
> > > OK, I'll just put it in my tree for now.
> >
> > Sigh.
> >
> > > BTW what do you mean by 'by default'? What other way of running would
> > > there be? Are you thinking of a CI flag?
> >
> > I mean passing some flag to pytest, like you do what you want more
> > verbose output, or less output. I don't see this as something that adds
> > value to run every time.
>=20
> OK, we could do that. But I really like seeing the info in gitlab.
> Perhaps we could have it appear just for the one 'sandbox' test?

OK, that's a reasonable compromise.

--=20
Tom

--5z78OJ1hdgXHIveM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVcFoACgkQFHw5/5Y0
tyy9+gv9Eng092iycdqd4MwpzZa1PkCetcWqAlTOSOlgEoTR8Utk09uFFZNU96h4
uJku7Jj8HTruLKYz3ZPcw41I1KcnrmwI+PsEk1fxisA5rUN+3D7cV59VGtaEoK89
G2puFLgaNTtQcTEUkHlnWeLYzvbXL+3z51czkWIZqrIRrHDMTaQGrLN2diVe8Ouo
vtq93kl2Ye4+lYTHctml5Rd2xvxYkvLDWONh2V9Ap60IREcWX7G9iY2S45dCoajx
DNoqkQu77t/VMlhtZgvzT98JysZMIKLFwdP3uFekEHpyBt9MVSaMC9RfVwEpsh3O
glKr9/gqdXh+4NxiOcu0YvdRy+9JcRfoJQzj/xeBDtkVr7iX0DkxV2Lf3RxibA8T
mOxgwT2kLHB/apgKVwwGifqCvUevmeF39eA79CDYKa4A8oLVhr9yrxytlzZgsYuS
HUmIiXDjdgVvg+cYj+NFeJzTNUxNqBkE0qMu6C6m7Zi7JahbTg6h8Aa4nImtNjuU
48QwyQlW
=QYwH
-----END PGP SIGNATURE-----

--5z78OJ1hdgXHIveM--
