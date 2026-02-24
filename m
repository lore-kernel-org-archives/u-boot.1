Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6023DF3C99F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2D083642;
	Tue, 24 Feb 2026 16:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5a47T9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6836783642; Tue, 24 Feb 2026 16:48:30 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F028D82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so3422874a34.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771948107; x=1772552907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vcXaHSkgOaAxwdkJkWb504Mk8nqRwn6Phrri6YJZFO0=;
 b=J5a47T9DV8Ep70vy1pM7fHNLPLmpUUVSlctD4LoXo/GqqwtXK3fxPAvFL80G1Ne0Pn
 n3chpPH+/zkqAcW1nA0jppUwk9dyMiGHlhaXaVtFTsfe+eoQVbBLKtEUzL93sA/IUTf9
 rUnysCeSo63vDkgNSRidPlrmCTXDfTQTFwbR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948107; x=1772552907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcXaHSkgOaAxwdkJkWb504Mk8nqRwn6Phrri6YJZFO0=;
 b=BNqxyPToBTkhaczpg8O53pDbnbKuViuZkD7gAk0+IQyzYehxDmh4063IP+26sfZLU9
 MrdpEMRL+59BiHT7+Vxr5s2JE7CcNzoOuvKGa+QJ5afttUU1M4s9AAhoDZDU05iXsmsO
 /MHgAWteYZDOjew4R2Y6FdQ4QEDYeCgBKyeP6FUhIPaY4AGJfYnVAeGL74M1LdJYR8xq
 FRIgaCZgIGbTsbyOG3hCSoSRqAYHZC8hv9wpTU51PJYhlLMO+l2wGjSCXBhVrXjpTvmm
 n3RqIaHg5EGjvc6SzNqF/kOMTnJJZuyx/yit8iOCmU0d1xwN4DfVhH3Qz+/XgT8h924X
 NPrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8IJ9jjugssiy4YgN+ZlVnseNzUD4AhjzFiajdFza9Lumx8cEO7q9yrDXU2TvDVxWNSwZpL5Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yye4BC31JpiyiTKRWbeHDUN21syyffeA7G96PJc8YNilLrKu3uH
 iWM2JnFieuli47wvsSOhL2H0t9V2TQMQlaSDIdBSOh6oSlchf9EuZf1v9CmSh3wF1J8=
X-Gm-Gg: AZuq6aJWtEnX3pf1/5u/HLxYrZtMxs9MLVohyATg/Uv28Fp8bm7V+nnUTuHkXUXjsPv
 tpPDWTObAnglY2IlTCWNse6I0nKV3YElkjZUD7k9E2U/SMobJywO4/In1F2rgus6RWSL8a0DwlC
 beOuWIt/UYHY8HqthNA4FsK33RTRM4N5rRz24t8aVelZcyHREQqS2tZQ564uKTQpWxt4O8DP+cO
 ZLrrlOUofFZszvTF+vCAUs8SHXVtfnKLZ+Dji+fQ6dOA8w+1HwctKGa0nMx+9bM0uAjL0M/bW79
 ybhRdtc44kkWGtqhgLG7CRJAdxmrjef5uNgYHiTPCFQFu3S2qXB1L2DTbpkHYbVtNTCJ1Cfb7Nh
 o6mVI3x4gcdEuAg+t8MH36Vjxr1msZqmin++kMz3gvGL087mT98og+7WtgZjSKLU/0fjBdikpNR
 3YUAaHXKxT/KCZhcFxNAD/8QDY0lQJx7jSHJ3J2zoNcCkIM5cyvnbcsZYLaBGymbuuwPLIBQGvf
 EqS+Z5ArpQEoxAyacTKHWrxNAxd9j/wkoVZOYO7bFmLsgVsatg=
X-Received: by 2002:a05:6830:4988:b0:7c9:5959:8de with SMTP id
 46e09a7af769-7d52be9584emr8683889a34.9.1771948106602; 
 Tue, 24 Feb 2026 07:48:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0386c6sm10910743a34.13.2026.02.24.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:48:25 -0800 (PST)
Date: Tue, 24 Feb 2026 09:48:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <20260224154823.GQ3233182@bill-the-cat>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat>
 <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+34cK6WU8BUCeHfg"
Content-Disposition: inline
In-Reply-To: <CALE0LRsCYT=h=X1fs_+H9WCWSeQSC2REfXRscg3eaK1=TVtNFg@mail.gmail.com>
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


--+34cK6WU8BUCeHfg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 01:08:23PM +0100, Enric Balletbo i Serra wrote:
> Hi all,
>=20
> Thanks Eddie for the effort on doing this.
>=20
> On Thu, Feb 19, 2026 at 6:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> >
> > > On 01/29/26, Mattijs Korpershoek wrote:
> > > > Hi Eddie,
> > > >
> > > > Thank you for the patch.
> > > >
> > >
> > > Hi Mattijs
> > >
> > > Thanks for the review.
> > >
> > > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wr=
ote:
> > > >
> > > > > The Engine API has been deprecated since the release of OpenSSL 3=
=2E0. End
> > > > > users have been advised to migrate to the new Provider interface.
> > > > > Several distributions have already removed support for engines, w=
hich is
> > > > > preventing U-Boot from being compiled in those environments.
> > > > >
> > > > > Add support for the Provider API while continuing to support the =
existing
> > > > > Engine API on distros shipping older releases of OpenSSL.
> > > > >
> > > > > This is based on similar work contributed by Jan Stancek updating=
 Linux
> > > > > to use the Provider interface.
> > > > >
> > > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > > >
> > > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL M=
AJOR >=3D 3
> > > > >
> > > > > The changes have been tested with the FIT signature verification =
vboot
> > > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the=
 legacy
> > > > > Engine library installed and with the Provider API.
> > > > >
> > > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > [snip]
> > > Sure, I can update the comment for v4.
> >
> > Since we're talking about v4, can you please make sure that for v4 it:
> > - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
> >   that will cover some non-Linux host builds.
> > - See if you can get access to a FreeBSD or OpenBSD host and make sure
> >   the tools build still works there too? I was hoping Mark would have
> >   commented / tested-by v3 because I do want to make sure the libressl
> >   case still builds. At worst case, I have a freebie Oracle VM that's
> >   FreeBSD based, so you can maybe spin one of those up as well?
> >
>=20
> I wanted to provide some context on my testing efforts. I have
> successfully tested these patches on Fedora and CentOS Stream 10,
> where the engine support is already deprecated. These changes are
> quite important because we are currently carrying them as a downstream
> patch for some RPM packages.
>=20
> Regarding testing on OpenBSD and FreeBSD ( it uses openssl 3.0 by
> default ), I tried, but I ran into some build issues that I couldn't
> quickly resolve due to my limited experience with those environments.
> Instead, I decided to test with an alpine+libressl container and can
> confirm that the build of the tools does not break with these patches
> applied, which should cover the libressl case you were concerned
> about.
>=20
>    # make tools
>    # ldd tools/mkimage
>    /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)
>    libssl.so.60 =3D> /usr/lib/libssl.so.60 (0x7f12973a4000)
>    libcrypto.so.57 =3D> /usr/lib/libcrypto.so.57 (0x7f129722a000)
>    libc.musl-x86_64.so.1 =3D> /lib/ld-musl-x86_64.so.1 (0x7f12975f5000)
>=20
>    # strings /usr/lib/libcrypto.so.57 | grep -i "libressl"
>    LibreSSL 4.2.1
>    %s/libressl.cnf
>=20
> I'm happy to provide my tested-by tag if it helps move the patch
> along. Feel free to include it in v4.
>=20
> Tested-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Thanks for doing that, I appreciate it. I'm much more confident the BSD
cases will be fine now. I still really want to see v4 put through CI
first just to catch any other oddities.

--=20
Tom

--+34cK6WU8BUCeHfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3IRwAKCRAr4qD1Cr/k
Cp7QAQDe8h0L1sUwDvZl4RXzgvtuxw5xF+xoFifOxHC1hIveSQEAln70fIrRrEd0
QPlxM+2KB8WnfiM9h7aJMcrs5Ej7Wgw=
=kh8O
-----END PGP SIGNATURE-----

--+34cK6WU8BUCeHfg--
