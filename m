Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD9AD637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 22:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBCF89198;
	Wed, 13 Nov 2024 23:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ng9v1WB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E34E8904A; Wed, 13 Nov 2024 23:20:23 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E919B89198
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2890f273296so3447011fac.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731536419; x=1732141219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MDLDVCAfKF9AS9d+P/AJXrBNviWc3A5OXlxLcFP9b6w=;
 b=ng9v1WB0x28/gfhRZ+qFrvWPqrHVD80QfY/USM0MAPpJMC93RjKPQUNdGO5TfymZYy
 1nAbW/PsHc/xY7FzCVn6oKv0crCrG6o1USFB9+V4r9PfF+Dcx2jFL1XrxNn57XDc0ngl
 HkZrLn39FecY2/B214MO7+PNPR5tbPEki1LU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731536419; x=1732141219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDLDVCAfKF9AS9d+P/AJXrBNviWc3A5OXlxLcFP9b6w=;
 b=gkULn7FfqIuQ9Y424UZ5hwQscOojoB1lc4GZKWEwZ4vLeJn1+zHjvoAMJEMqr0HiKi
 UyGCDj1+6B3d77g/2mTQco6Cekw8gKF+Axv6StD9HDRuTmbjKmO/rDkmJUaG08Kth43a
 Au4Zk+4o6cB2kcrgq2Heed1sgybqwdYGSDEWIAGXKE77/PTxfPCyRCqGCwakwu9Fjfuk
 F9WoatH7ohwob0kxh/FdX8HQGmgKT3gastY4z0Y8uLPwvxQGfgO2m1hSguwr68ML8+/o
 UGnJSbI+2sGVaI+CIdhQPOv2TZ7/t3qwqXytz1jFZTNH+SM+xgK6NBbac1i7EG0XtJ2Q
 84/Q==
X-Gm-Message-State: AOJu0YxJoM88JDjWabE4VwVAhR2lPNxeoA9UoD+l904SjosmuFK843RV
 sRgdQ9rIga978NFR04X48Gh/tavkd2i2FzPkRcyXrqUbrnIf0i64SYxUGj7Te0vnzkc5/bFr9ZG
 Vf6Q=
X-Google-Smtp-Source: AGHT+IGGw37QwBRgRIsayB0C/TjIrf+AtIF1LooSQYZLrJ2xPpVR1q4V9roALXDXbth2HJLp6O78bg==
X-Received: by 2002:a05:6870:1e83:b0:288:6a16:fe1 with SMTP id
 586e51a60fabf-295601116e2mr19216323fac.18.1731536419634; 
 Wed, 13 Nov 2024 14:20:19 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-295e92afbcbsm1242577fac.40.2024.11.13.14.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 14:20:19 -0800 (PST)
Date: Wed, 13 Nov 2024 16:20:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
Message-ID: <20241113222016.GZ3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
 <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FTuEmCyWF8dJ3Ghi"
Content-Disposition: inline
In-Reply-To: <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
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


--FTuEmCyWF8dJ3Ghi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 09:03:35AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
> >
> > > It has become more common to use config fragments to extend or adjust
> > > the functionality of boards in U-Boot.
> > >
> > > Propose a format for how to deal with this. It is not implemented as
> > > yet.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I think that the first problem is that this patch series is an
> > inappropriate method and place to start the discussion.
>=20
> We had a discussion a year ago but it trailed off.

OK. Still an inappropriate place to resurrect it.

> > I also think this gets things backwards as the common case is "make",
> > not "buildman". We need more defconfig's that are just base +
> > fragment(s) if they're important enough to be a combination that needs
> > to be tested and work. A board is not a time-expensive part of CI. A
> > pytest run is, a new job itself is.
>=20
> OK, that would work too. It would also avoid the problem of combinatorial
> explosion. But I am not seeing people actually doing that, with rare
> exceptions.

I think it's the exception, not the rule, where config fragments are not
being put to use in a defconfig. And that's possibly because not a lot
of people seem to know about the #include option, and then when I
explain it exists to people the next problem is "Oh, I have to do what
so that buildman also works?".

--=20
Tom

--FTuEmCyWF8dJ3Ghi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1JhgACgkQFHw5/5Y0
tyzFPwwAmP5slXSdduxYrsKbEWBgywerSzNKVQ0TiuHFUMqxhvDL+9y1L/bzladL
Xy9ZGgQl4knU2noi7F+Vwjj5gM5uPEZ3sLnk/KTU29X4Mz+7F57zTgyDvkfTHgep
6lB5xbP3gLKwPsh2mDmR76j3bpbYnIaXp8QquaX2ySGkcaikctLw4m3tdzc4QloH
GpF7J/l3krGiASlC02DompgPWWLNT/JHYqdOGQbzgsDJ7W7p71aRAi+N6MmfDCF9
4w40uHLw0fSoaziuEct6CVjJ2wlCyugSqSfw/RnedRMwW2s4k3qlV0eiQPBvERTY
F9NsDCOpziodnUSItrZrbYifLZDShosRaHz0VFtF64x0Z3f2O71mnmnNYPyHwWnb
oszMuSoBfIa7L/srf+k94raMFAfsqr0YmbWWT83yVg1i7WqrjRoGB8ahKzjPgSfv
0YpvXIGdqK8NmAQWj3OPwjmci5Yv1QLa1+xqwWpYX0xKiwdmAWNMMVxUFYk0kknr
1FoxWzrO
=XeWs
-----END PGP SIGNATURE-----

--FTuEmCyWF8dJ3Ghi--
