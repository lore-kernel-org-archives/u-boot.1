Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76FAC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D708889AB;
	Thu, 25 Jul 2024 00:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pBJ7hjt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444878899C; Thu, 25 Jul 2024 00:36:01 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF58889A6
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5af7ae388so164985eaf.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721860558; x=1722465358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eqXERaNuE5goeKJW/kUQWOIItKGf7ze6zF6kFDehn8c=;
 b=pBJ7hjt2vNFJEiSacvvRa7GyotkBt6DmCrfXsD55rGtcXfFFJkxZ9lO/PxxTwa8HjL
 XZiujrRYPVr97je79D6AWQ63D1ZNf2ZAnU6SgYK0YtdcLsjQ4inOf2cVc5J5NJ6RG/fz
 6MwS8EWxq2tnOEpDJDGiuycSbvtmuYGowqiGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721860558; x=1722465358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqXERaNuE5goeKJW/kUQWOIItKGf7ze6zF6kFDehn8c=;
 b=FS4yJJamP0zZkXptjAHRg570SDOiIoR8UJu2JRIpPHJkREVt6pNYE5QqJZDLGBMAV8
 5xnBMs+4rHX4N/ItuulWxNPGZBbMELj6UMuOXuJSbY2gM8xKGI1/AmVPMw96ij894cCf
 NYkcgfaFhe92DEEbgpUYGo/yMLsi7Vk8zGLmsIUtZRRfVeJz46Zi7q0IS1VrkfKL2770
 XynpitJ5GLApPLU8nrSrfZ1Ktq5joaY39ggbRXQFvTzZi4KGssevI0eMdsUklOi+m1zp
 J7vSkYOYHjbpvyU7Ohs8SBad22RxCZydCXV3K8ZrqcuxLQMp1Epe+YXNyD6vuJ+i7sjp
 lKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9SIx6MQ2rsLyqho5Eoyf+naBER37RRtflVic42issTNaZT13ghvDuzRICTOnZhU1uy8I2vO3ZBig9n6BrGfppCSi1Aw==
X-Gm-Message-State: AOJu0YxGc/PVwX+1JmPj1Y8eHCnNDi3Ui4t6c3eDPK9d/YH5aKOaIEhf
 9vQP5zQzXX166Z4NbqJGrOTJdmiKB7v7KkT7aWReR7N9d1rJqgrb9fNk8Ki+IsU=
X-Google-Smtp-Source: AGHT+IFNmrT7eABE1tyT3Tii+RG5tPUnBq0lxAS42CHsqtA6s943hdeZiYdTor+7vKcFNdNpSfjVYA==
X-Received: by 2002:a05:6871:e712:b0:260:286c:ca07 with SMTP id
 586e51a60fabf-2649fc8c29amr556765fac.12.1721860557805; 
 Wed, 24 Jul 2024 15:35:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-265771e5f1bsm53226fac.37.2024.07.24.15.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:35:57 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:35:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
Message-ID: <20240724223554.GO989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CAFLszTiY7hDq4x56UDDCEOOHCGKUSfv0HqwA4-y0nFAFpywvFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H+SQDAXANzE5jGEK"
Content-Disposition: inline
In-Reply-To: <CAFLszTiY7hDq4x56UDDCEOOHCGKUSfv0HqwA4-y0nFAFpywvFw@mail.gmail.com>
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


--H+SQDAXANzE5jGEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 04:17:32PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 24 Jul 2024 at 14:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > Use this new data structure in the utility function.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > >  1 file changed, 19 insertions(+), 16 deletions(-)
> >
> > This is rather big growth when we didn't already have realloc:
> > 05: lib: Convert str_to_list() to use alist
> >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> >                  function                                   old     new=
   delta
> >                  realloc                                      -    1120=
   +1120
> >                  alist_ensure_ptr                             -     140=
    +140
> >                  alist_expand_to                              -     136=
    +136
> >                  alist_init                                   -     108=
    +108
> >                  alist_uninit_move_ptr                        -      76=
     +76
> >                  alist_add_ptr                                -      72=
     +72
> >                  alist_uninit                                 -      48=
     +48
> >                  str_to_list                                204     232=
     +28
>=20
> We can just drop this patch, perhaps? It was really just a demo of alist.

Yes, and no. The next good example would be on
cortina_presidio-asic-pnand where the reason this series is a size
growth rather than reduction (where it is BTW on LTO using platforms) is
again, realloc. Is this just an unfortunate given then?

--=20
Tom

--H+SQDAXANzE5jGEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahgccACgkQFHw5/5Y0
tyxrCgv/W04Z1HtfwSirM+X45I3Nzu/a5InWmnEOwJvaBabD6JOLR6FkNE0qUrd9
yR3iA8KfiYTgqqslR5rzoZdrHC2ZBtLi95+FHD0rxnQ4jce12N0aFzQCj7al9p5L
yJxMVnoesiucGkZHbalE8UnHdK22W+fdA/7tpVoaCl9/GIaxwzJHcZfOYQmEIGnU
FfYC8tX2ZlabBpcf6hqbFGI6eWWecZ6Hk2YHCT/URVuOk33sdBpGMOLzOBNAoFlk
iUmPmf+6DNrpJvrCMzUdePUlGg9CST9CkB8ROVfMSFaM8gNPbLBQAfBYL634BdFI
SSKLJ1xPVj4Bz7WC5G8bvx551qN3Erz2vUi/ZwHCxDCfxl4onJ3ud8f0KI+azqrZ
B6KCnaTbfBC4FCijfKNcEfRKEf4wm6RrcCu0LNIFRk7VEABAU7nR8TS6rgR8NqgR
i8etYKNH77UbxqsTaUeWUbfHq0BJ2oEYInObvGe0knr13pDrLomMaokf3vZ5ylUs
C+EQb+ON
=7Xc0
-----END PGP SIGNATURE-----

--H+SQDAXANzE5jGEK--
