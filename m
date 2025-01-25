Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057EEC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753E880F10;
	Sat, 25 Jan 2025 23:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YHi1Bqr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4248A80F56; Sat, 25 Jan 2025 23:53:39 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CCB80ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso383917585a.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737845616; x=1738450416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BBfm85eNGQ0obdCl+eJ/NILCqmk98o9VvXA8altGTeg=;
 b=YHi1Bqr3TuDVT8RrkfPp6TrJPBV10l4SEVBN/MjhVtlRWqs9IQruAqqBWCnU7J39AR
 2xGTdzqSLnd/LBsNqwgcQ60MlAxXIJxlb3eRQ2cRkMJFOxmiTjJLzAp1k/Lkc0RfeTOJ
 AgUxAAS7YbE6D6+HPzsKwwOrNku0PHsj2NFXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845616; x=1738450416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBfm85eNGQ0obdCl+eJ/NILCqmk98o9VvXA8altGTeg=;
 b=UuFPE2Tr9DLpXv5G/NABTgtnRdM6PT5LfL+UWnm79a2+V3tq++iFsK5YCivoqLGhoJ
 8VlfT22xNdAzhFQX+H+5RElgAUURGVPgGR4VpStzUxMSwICig0OcZG4H4q5jEoLVx/kA
 BpQsaR3o08Nz5d/Gnaql1jYD2PMGOH2akIu6fsueAi/I2tyY3Wj+T5FAT9NiwKbTe6tD
 smW+2RBDeYl8KlLX+jQO5OM+1/r+1K0qDSsK4ypo8LGPUUNwksJpr/NP+qk/raD4xgs9
 yTvfX3mVXOynXL6mf0mbYzSNTfkR9FdRfd8wTPeFooIewU2jMhoCy88zZJX32jVias5k
 5Ihg==
X-Gm-Message-State: AOJu0Yz1rHw7zglgxjAUw/FIA/n+GtkOaPa+NGImoJVekl7lwJfXIAgF
 m24mTWaGdtOUYcwmEnbJGTyqfJN8tY0mU45EsEk6ZSRFq0p8fphXeICvCj/GelQ=
X-Gm-Gg: ASbGncvtYoBUKjU5o9/m1OS7FaBHAmDpsSYEeq0dorOoXhaS2zWe3VTBE1bhJK6Qz76
 4qTuyrRt08EqhcMGmtDuUFMm1/Nj7r39v2j+cOIvppgpTOXI4PH70Bt1iJMhQI0NUey59L3LqBO
 /c/E4k/SullJhubkEY+bcLvqU0oLOFgIYwJDHk7y5T4Dsbf4o6DTlJTmgn7ShigDVxfBaAN1gLF
 CUpoJNUbsZpnM0rkZy2l3UJg8TBbeUId9K3Ikdref7rEI1/49SgX9gcNrGMhA/xpbCSwZfNyziV
 45Pw
X-Google-Smtp-Source: AGHT+IFaQICzSn+qrUgh6nl3AcJYy1D86rRnMGD0AQPH70mHinihFz8WPEJ1Dk5y9Cza2a7aayhukA==
X-Received: by 2002:a05:620a:191f:b0:7b6:67e1:b4ff with SMTP id
 af79cd13be357-7be931ff9c8mr1994745885a.28.1737845615724; 
 Sat, 25 Jan 2025 14:53:35 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8be35sm234926785a.46.2025.01.25.14.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 14:53:34 -0800 (PST)
Date: Sat, 25 Jan 2025 16:53:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Add a report show test durations
Message-ID: <20250125225331.GI60249@bill-the-cat>
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
 <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
 <20250125220119.GG60249@bill-the-cat>
 <CAFLszTgw+u3rQ8N3vqB1bZ6RdOY_poJUO_WULQ-Q+q28S46FaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fDb+6lMB7/0QoR1n"
Content-Disposition: inline
In-Reply-To: <CAFLszTgw+u3rQ8N3vqB1bZ6RdOY_poJUO_WULQ-Q+q28S46FaA@mail.gmail.com>
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


--fDb+6lMB7/0QoR1n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:50:02PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:36:52PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > Execution time varies widely with the existing tests. Provide=
s a summary
> > > > > > > of the time taken for each test, along with a histogram.
> > > > > > >
> > > > > > > Example:
> > > > > > >
> > > > > > >    Duration : Number of tests
> > > > > > >    =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > >        <1ms :  1
> > > > > > >        <8ms :  1
> > > > > > >       <20ms : # 20
> > > > > > >       <30ms : ######## 127
> > > > > > >       <50ms : ######################################## 582
> > > > > > >       <75ms : ####### 102
> > > > > > >      <100ms : ## 39
> > > > > > >      <200ms : ##### 86
> > > > > > >      <300ms : # 29
> > > > > > >      <500ms : ## 42
> > > > > > >      <750ms : # 16
> > > > > > >       <1.0s : # 15
> > > > > > >       <2.0s : # 23
> > > > > > >       <3.0s :  13
> > > > > > >       <5.0s :  9
> > > > > > >       <7.5s :  1
> > > > > > >      <10.0s :  6
> > > > > > >      <20.0s :  12
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 77 insertions(+)
> > > > > >
> > > > > > Whitespace issues aside,
> > > > >
> > > > > Do you mean the blank lines? pylint wants those for top-level ite=
ms.
> > > >
> > > > That's weird but OK.
> > > >
> > > > >  we should probably not do this every time, just
> > > > > > when requested.
> > > > >
> > > > > I'd like to see it on each run, actually. It doesn't take any tim=
e to
> > > > > calculate and it lets us see where the time is going.
> > > >
> > > > We already print the full time, and I think knowing what the tests =
are
> > > > that take so long, so that we can see if there's anything to do abo=
ut
> > > > it, would be more helpful. The general feedback about our pytests t=
oday
> > > > is they're already too verbose in the normal case.
> > >
> > > This is what is shown in the full output (although with CI you have to
> > > download the files to see it):
> > >
> > > [-] Section: Timing Report
> > [snip]
> >
> > This is handy as a one-off, and maybe hints at a few tests to look at
> > more, but perhaps it's mostly "is what it is" tests (and not just the
> > sleep test).
>=20
> Perhaps, but I would hope we could speed some of these up, or reduce
> the number of variations.

Looking at it, all I see is a sample that yes, we should see if there's
some way to speed up output from U-Boot to python. None of the "long"
tests look otherwise out of line for what they're doing.

> > > TIME: SINCE-SECTION: 0:00:00.004227
> > >
> > > This is just the summary which is visible in CI:
> > >
> > > [-] Section: Timing Summary
> > > TIME: NOW: 2025/01/25 14:28:57.730179
> > > TIME: SINCE-PREV: 0:00:00.004234
> > > TIME: SINCE-START: 0:02:00.307984
> > > TIME: SINCE-SECTION: 0:00:00.000041
> > > Duration : Number of tests
> > > =3D=3D=3D=3D=3D=3D=3D=3D : =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >     <4ms :  1
> > >     <8ms :  1
> > >    <10ms :  3
> > >    <20ms : #### 47
> > >    <30ms : ######################################## 377
> > >    <40ms : ############################# 278
> > >    <50ms : ####### 69
> > >    <75ms : #### 47
> > >   <100ms : # 18
> > >   <200ms : ### 29
> > >   <300ms : # 15
> > >   <400ms : # 13
> > >   <500ms :  8
> > >   <750ms :  6
> > >    <1.0s :  2
> > >    <2.0s :  9
> > >    <3.0s :  3
> > >    <4.0s :  4
> > >    <5.0s :  2
> > >    <7.5s :  2
> > >   <20.0s :  1
> > >
> > > So what do you think would make most sense?
> >
> > By default, neither of these, and only when requested. Looking over at
> > one of your runs, no, I don't want to waste more output space. If you
> > must do something, log it off to examine later and not add to the main
> > output.
>=20
> OK, I'll just put it in my tree for now.

Sigh.

> BTW what do you mean by 'by default'? What other way of running would
> there be? Are you thinking of a CI flag?

I mean passing some flag to pytest, like you do what you want more
verbose output, or less output. I don't see this as something that adds
value to run every time.

--=20
Tom

--fDb+6lMB7/0QoR1n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVa2sACgkQFHw5/5Y0
tyyd7gv/fiPXbJqNIpeLVhUhBDNXMTA3IAUrVMTTR4F8XwAeM3osY3vQ4ruDoLLu
7n/L6B1lkVVNaZfqTXMdbMijsoVGfNLBkVJWGZGbcjgg1b4eoSsMjxO7PkmqQQJQ
FcUWmlZwb31Iw2exxC6ijCWQQbEmkLy2AgrGfYLu58jnE6UxUbbtwvxb6UQHmTz4
osdabfXEcxvYXkTupjyboMAt9kfh7ZHREe+KLyC2Zw45MWYSuXcE9I9MaFrRZ+i4
yxg8Vqu3e2RGwVOsC6uv5oOEeP3cUKNTNC/PAOBPpWvd8/hC7TkzRE5QhIk2ztRm
ZU3/xkigAzzyumrtvPRcDsW9r9iQiE1wvu3r/7/QrMDgYUS9xYumKyGMo5kfaPJm
qmefOp+p7O6Arg97NftpruguNalIAMC/eW0YyiXs1oiPP55+TznpfpoKj9+FA7wp
SSJJH/9CkqMGjdSzKh97HS3ZTniFCUE2luvJeKpUlx0u5Uq8YZJw4iPiIhb+NPYD
2LI89Ha3
=P4OE
-----END PGP SIGNATURE-----

--fDb+6lMB7/0QoR1n--
