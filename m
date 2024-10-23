Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE21D0BB47
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 22:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA55892E1;
	Thu, 24 Oct 2024 00:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WTXSnyyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BC38930D; Thu, 24 Oct 2024 00:56:40 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0822282BA7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 00:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbc28f8e1bso2398266d6.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729724195; x=1730328995; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kvBnNPa+istl4va4NlC1zA3E8hgWXF38e8pnezgjqFI=;
 b=WTXSnyyg1xLNOOrJya+n/ZGiPQqw7Bd1YMPPxW1faXBJHENKRr5natphqzvsnwoWWp
 7ETcf5Fa/mslQ3ZTG3CNjDE1gbndvMF+CMv+1AUxhSIqZpQouOegzzyxmg8ZoCHGgcM2
 AaUagkQDc59YOB0TRQGf9Ixx4NM5Aef93NbWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729724195; x=1730328995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvBnNPa+istl4va4NlC1zA3E8hgWXF38e8pnezgjqFI=;
 b=nAs4dWrBSh9nT+VaYXsftAzFlznWm0LSTCmcpdJXho/mEX2f8+GiNROzLzPJT3pQpb
 JcsN7bJ2yGWDZmd7+iafl9R09W03I9+LiJ9RPaa5rIpRZ/GjcZp+LpGLIQ1c4RPNGLD5
 ANQI1rmuYu99d5ee6aDoZ3ScnhDRjrkQUWThQFIbFhyZz3gDS2kqMthZfZ8n4quIpo1j
 LFZEstwUiARE20yD2qs1kf+/UU5rqL/4uLIyUHU0oDzv1f3GmZUz5/+2+l5ByD0pj5xt
 QXvAaCBkIbMGtCR5iXGBceOImqAmRgmVeFBYUdaHdV6HThNq67/zC3uRw7sbCnfKPcUj
 TB6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO5uWCqPdh4r5g6+snoz41TYOoAPMSPCw7nTjF3nw6y3y5te8QSh+LXVO2F/agtxjXoXX3HTg=@lists.denx.de
X-Gm-Message-State: AOJu0YwbeG8lCOxaZAFDTZXLP2N+KE9lo1ONkTttI4z4V7Y9Ki2L5HHH
 IQYK2gopeaRfVbtOimjDEpkbN9zHYh2WbqIp8ejB3cGjrKOUzae1+Y11CthdJJk=
X-Google-Smtp-Source: AGHT+IFVxtrkxdNRi+7ljjaQhNoEnyPF03SIibiANFlHwfMDdEpXTJ/4WRnoJfpr22Xg/tjDDPPhGg==
X-Received: by 2002:a05:6214:3d11:b0:6cd:6ad4:1fc2 with SMTP id
 6a1803df08f44-6d0a26697ebmr329226d6.44.1729724194746; 
 Wed, 23 Oct 2024 15:56:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aca1asm43818516d6.7.2024.10.23.15.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 15:56:34 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:56:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <20241023225631.GN4959@bill-the-cat>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <5cea49dd-b67e-428e-9ccd-ef16036a53e1@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rKny6c875lM5hu4X"
Content-Disposition: inline
In-Reply-To: <5cea49dd-b67e-428e-9ccd-ef16036a53e1@gmx.de>
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


--rKny6c875lM5hu4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 07:07:43PM +0200, Heinrich Schuchardt wrote:
> On 10/21/24 18:32, Simon Glass wrote:
> > Hi Andy,
> >=20
> > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >=20
> > > Hi!
> > >=20
> > > looking at the redness of the output of `make W=3D1` here is the ques=
tion:
> > > isn't it a good time to enable `make W=3D1` by default. Yes, I unders=
tand
> > > the impact, but at least we can do it mandatory for a _new_ code subm=
itted to
> > > U-Boot, right?
> > >=20
> > > Ideally I would have what Linux kernel has for a few releases already=
, i.e.
> > > Werror by default and getting close to make a clean builds with that =
and
> > > make W=3D1` at least against default configurations (yeah, with U-Boo=
t there is
> > > probably no default, but sandbox one).
> >=20
> > Warnings should be warnings...if you would like to enable it for CI
> > that is fine by me, but the U-Boot makefile shouldn't do it. It
> > defeats the purpose of having a distinction between errors and
> > warnings.
> >=20
> > Regards,
> > Simon
>=20
> Most contributors don't have access to our CI.
>=20
> doc/develop/sending_patches.rst does not indicate that patches leading
> to build warnings won't be accepted.
>=20
> We should at least amend the documentation.

Yes, please, someone.

--=20
Tom

--rKny6c875lM5hu4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZfxsACgkQFHw5/5Y0
tyyocQwAlSP+eeyohAuTqqMS5eznfvPGQ2kKJ1g/hg7PhvqyzK9yDqeasIs0sKQ8
z4BoHyBg2HmyB4CTMl0z32id7uxpE6WwIbDifivNvdYA5rD8CtEmczmfkoo/p02e
7g8LsNPycy0/0YaYIlUnObBD3kzrbjRLtzC8Wol5VjiHmLa+9feZ09Dx1uOIZHkA
Tx2+6d6BecNSU0TY6pn03ESSCkScwFw/8yUlT6hTzJ/DP2aBQaTiTDfo43Sla6pp
+2NhKCoikuNiPovqfjlE23aN6/Bqgtf86OmN/bgVWhO6P6sR8o2Ktbo76jhATUyt
D4FClPReLQoQWixjh4jpirqWW01k1r9BSREFlee3W60aOD2GpMYGphf3qGfe7uES
P2APfeQqp5K13tOJ28e0esXaex/OGjAsB3GO8F3F0LwGapvSJF+6UDXmXino6jqF
yJxHuPYAKVRXjtqCpiuHrks9aE6xs01keYG8MnbNSY1Awjn1DuksEJqiCmAE4DnJ
L9Frhxcy
=iYIw
-----END PGP SIGNATURE-----

--rKny6c875lM5hu4X--
