Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD5EC369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B93C81E18;
	Wed, 16 Apr 2025 15:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VWCFgyXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C16281B4B; Wed, 16 Apr 2025 15:58:17 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A4182F30
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso2598209fac.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744811893; x=1745416693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0wb/hGJF075Zm1WWuU6o+UBjq7kyh95qPzGNL+OVnks=;
 b=VWCFgyXfA4xuUk3k5LXl9dPiUA+d44uyLbEqM2nQxFTXmzb/4H0zWFNgxuEbQ1HIfM
 pvfubb6XPd1uYdxMc/O+/IW/Gcf4NjlYgeANqSrklGShlx6CYCE7hiPp1ZKrZtLjhSZj
 o50ShfD5RlwrkhAEWkIWqm/VN+xPPmg/alE7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744811893; x=1745416693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wb/hGJF075Zm1WWuU6o+UBjq7kyh95qPzGNL+OVnks=;
 b=YyFPIkdA6C8LBDLMTYY4p/BcjzoGJgcZhH1QYcv/Prik2vbBswduTigC7IhzJN25mB
 BAI5evlChsW2LmCysoPhDw4O2A4fh5oJT2yNSnFz0laSx2j/U0fQBcg2vEy+O1aNXnY0
 CvOi8LvLsbDEugqKICWBDNTJICA5vDWGTyMQvgqhK1JHr3gEhXDZ5B9q1lCRdAziU4mV
 aKIm8dd4F2jbbVee8mb5w9KJn25xR+VohKZ2nTlTk4KYsO4OSJQsfP35ycMjxFJGrnU1
 b+yT0DLG13EmLCwfqm3fHcOsNqfUmFgMxvvyZ6q4utPpJILoBCF4G2IYjn9K0N23XGn4
 jVrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkCcf1oTRaQcuShbFxP37k6UdDlIXmUMg57msi3dIDhBDX0V0jW1B06WrsSvzTYe/HKsGjUy8=@lists.denx.de
X-Gm-Message-State: AOJu0YxWwIEUzbGzG58cef80yHlvcoMm2ZYHZNQ0uvmHda55XNFCMq+o
 Fg/l3G02F2BNzf2N1eqKMT2ZfHKjk/IC8yxozQ0pfQdmN/lUhTNqBtwx0YnQPlU=
X-Gm-Gg: ASbGnctrLRGpXaNhFBbRV26nZpL9WIb7sMZGkRwwfcQSc7n8NukuXQAl+FufqeVUFnu
 HC9UWbMGkmGhcvlkxwmKQYlSRR7/hHew8ayy8QCjuk41pkTooy9KH4slzdlSnP3GnmeZ8N4ciOs
 aAiy57ld11O+aFeX0MSXmJWy2g1oov14qzQs4W0v/fS0A+x5Q3QaFMhVfTD2i1Y7vB+t9kCVBTq
 wqnwN7LJ44OquSi1FpswpEbagVS1GIOcJD0buPqs98jrOsx1srG0Zi3Rq5GIRHdTRhmMY3YcDQX
 HAYJo/Lu6VWD6I3XHcxdyOiD353TafLH96jWCXVyADCY+vmKpF2+AABjqub0cj31ryTYTpaYZ52
 jzw==
X-Google-Smtp-Source: AGHT+IGv6Vbypk8Wu8s1cIvZ5AV8+1NoNWB3pHC4aICb2IM223x1JPk07rC3+4kLNkoRu7OfJCaXGQ==
X-Received: by 2002:a05:6870:9628:b0:2c1:bc87:9bd7 with SMTP id
 586e51a60fabf-2d4d2d899c6mr996832fac.35.1744811893140; 
 Wed, 16 Apr 2025 06:58:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8d3bbsm2765410a34.33.2025.04.16.06.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 06:58:12 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:58:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools/make_pip: Use virtualenv when invoking pip
Message-ID: <20250416135810.GR5495@bill-the-cat>
References: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
 <20250415175944.GA650630@bill-the-cat> <87ikn44io3.fsf@kernel.org>
 <87fri846zb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NcvMkzYYFVTypufC"
Content-Disposition: inline
In-Reply-To: <87fri846zb.fsf@kernel.org>
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


--NcvMkzYYFVTypufC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 02:38:00PM +0200, Mattijs Korpershoek wrote:
> On mer., avril 16, 2025 at 10:25, Mattijs Korpershoek <mkorpershoek@kerne=
l.org> wrote:
>=20
> > Hi Tom,
> >
> > On mar., avril 15, 2025 at 11:59, Tom Rini <trini@konsulko.com> wrote:
> >
> >> On Wed, Apr 09, 2025 at 09:46:34AM +0200, Mattijs Korpershoek wrote:
> >>
> >>> Recent Ubuntu versions (24.04+) disallow pip by default when
> >>> installing packages. The recommended approach is to use a virtualenv
> >>> instead.
> >>> Because of this, "make pip" is failing on such versions.
> >>>=20
> >>> To prepare CI container migration to Ubuntu 24.04, use a virtualenv
> >>> in the make_pip script.
> >>>=20
> >>> Note: This has been reported on [1]
> >>>=20
> >>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
> >>>=20
> >>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> >>> Reviewed-by: Tom Rini <trini@konsulko.com>
> >>> ---
> >>> This has been tested in docker on ubuntu:24.04 after running:
> >>> $ apt install python3 python3-virtualenv
> >>>=20
> >>> with:
> >>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
> >>>=20
> >>> And shows:
> >>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-p=
y3-none-any.whl
> >>>=20
> >>> Also tested with "$ make pip".
> >>> ---
> >>>  scripts/make_pip.sh | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>
> >> So, this ends up failing with Ubuntu 22.04 thusly:
> >> https://source.denx.de/u-boot/u-boot/-/jobs/1103567
> >
> > Argh, sorry I did not test that.
> >
> >>
> >> And in short, I think your original plan to use venv not virtualenv is
> >> correct, sorry for the noise. I'll post something to install
> >> python3-venv to our container shortly and switch to venv not virtualenv
> >> as that seems to be the long term best answer.
> >
> > Ok, will send a v2 to use venv instead.
>=20
> Posted here:
> https://lore.kernel.org/all/87ikn44io3.fsf@kernel.org/
>=20
> As mentioned in the cover letter, this requires python3-venv to be added
> in the container and I've assumed you will be doing that, Tom.

Yup, thanks again!

--=20
Tom

--NcvMkzYYFVTypufC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf/t3IACgkQFHw5/5Y0
tyx1JAwAuvmFRkXTKz+pB3VpATGC5oJe0ey9rocxKKdoj6tjA9sqNa9T9drevL2C
VVJunj25VFUvt3FNbpQ13/sbS2pB+SuHvSfsq0O5J6Dz1BYcayiyeEQ9poxkzGHm
C7OGOWf1s6eCjm9lVi3pFPXy4frA8MEWxarucBn6ziZS3qN8hhnsUpzfp34EJZ+U
I8OY7BNmdkFFkUH3gLY4JXuKAFRd6OVFRj5FyJJLtioBjKL7cKmPiS2fSc/l/4+0
cjYS5v3gbTtSZrsJjSNaRGGbprAT5H0Aighi0mODJd+nRthW4uYVKPbLazjPa0iw
1OBFoIKyyPcoR+vpf26MGG/AHh4ribMPcgCkBGmcY4YQIqqFuXf3yWb9LePUlJGA
ktOZf2pM2l1pLxAq5pVyPcVS4Rtpwmo9m/Mp7hrAG7j3o8mAArfd4WLPe++Qxtco
EznbLSvr9umWTWwa/6Zo0FaXbPjpE7HkctzYRkL7H07Z1uygZEbehF1k2/MhQzp5
p2hRP3aX
=jCGH
-----END PGP SIGNATURE-----

--NcvMkzYYFVTypufC--
