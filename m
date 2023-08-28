Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8192DC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C69D86456;
	Mon, 28 Aug 2023 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eF8nIFu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E8186430; Mon, 28 Aug 2023 19:53:25 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 001838648B
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58e6c05f529so43962307b3.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693245198; x=1693849998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ExcmtfcQahwphXsVmtMz4dlA+x25EHG74pAjmQDSrfQ=;
 b=eF8nIFu8rk3pauv2WSGMjDfa/2hExC7i3OYKccMk7Wyquo9BAW845w/37fxu45nLZa
 VIQ9q/iD6wLXrMuhuaBgSQbXo82t9JbYRKpDZnRvelz3Jk99xK6JDmf1R6PxacF2Z1/3
 eks232AIIcWhkcDmXG9gfAmYZltPJCd2Qkt80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245198; x=1693849998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExcmtfcQahwphXsVmtMz4dlA+x25EHG74pAjmQDSrfQ=;
 b=e4+NTIoipWZFqo9JMxTFNT6WfyVJFA9R0PUlcPpSWplPKL3YYvsTshAjNhRQgjNEbq
 rMhIxYqmBZHGIsYBmqLLFupE5I49ge9Cm2BmjMYlA+pdK1ERCg92LHxpFBy4UhpEtyB5
 ZHEJ8CF3/DgzEHTI2afcA5mjJBuXDubS91ipaHnH+Zon1aUv4kBM0eKCj4F2lTnlCIys
 nktzATIcuC2Mp7JF2qZzXiOi7FMT3pCbKO0E68/IQYTVDRoP1OcCNhsoxLvH9plvlyp8
 wFG0RIJjzXaT+grQlsNZhVSyLUQBTbNOZXCM5xp1ZHsNb5KPgSGHPJe80llZkY3Ko+ft
 KzJQ==
X-Gm-Message-State: AOJu0YyfHX6QREz/tzr3msQN/R8TkM041rAyyei4SjsopYZzgvWwu0Ml
 J7DTHj7y276kkLwzWvrcONEUsg==
X-Google-Smtp-Source: AGHT+IHyA2Cpd8ko0ajyW1uRnGGivcDwsNT6mR4d0FpS/2fzeQa9NXfrezeD5zWjFLAb1r0GZb6Zwg==
X-Received: by 2002:a05:690c:4505:b0:583:b72c:883b with SMTP id
 gt5-20020a05690c450500b00583b72c883bmr23897002ywb.11.1693245198729; 
 Mon, 28 Aug 2023 10:53:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a81710a000000b0058bcea54fc2sm2267466ywc.57.2023.08.28.10.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:53:18 -0700 (PDT)
Date: Mon, 28 Aug 2023 13:53:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230828175316.GI3953269@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fo3unteMhmHmZ6Yd"
Content-Disposition: inline
In-Reply-To: <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
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


--Fo3unteMhmHmZ6Yd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 05:37:45PM +0100, Peter Robinson wrote:
> On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > >
> > > Provide a way for removing certain devicetree nodes and/or properties
> > > from the devicetree. This is needed to purge certain nodes and
> > > properties which may be relevant only in U-Boot. Such nodes and
> > > properties are then removed from the devicetree before it is passed to
> > > the kernel. This ensures that the devicetree passed to the OS does not
> > > contain any non-compliant nodes and properties.
> > >
> > > The removal of the nodes and properties is being done through an
> > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > behind any Kconfig symbol.
> > >
> > > I have only build tested this on sandbox, and tested on qemu arm64
> > > virt platform. This being a RFC, I have not put this through a CI run.
> > >
> > > Sughosh Ganu (5):
> > >   dt: Provide a way to remove non-compliant nodes and properties
> > >   fwu: Add the fwu-mdata node for removal from devicetree
> > >   capsule: Add the capsule-key property for removal from devicetree
> > >   bootefi: Call the EVT_FT_FIXUP event handler
> > >   doc: Add a document for non-compliant DT node/property removal
> > >
> > >  cmd/bootefi.c                                 | 18 +++++
> > >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > >  include/dt-structs.h                          | 11 +++
> > >  lib/Makefile                                  |  1 +
> > >  lib/dt_purge.c                                | 73 +++++++++++++++++=
++
> > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > >  7 files changed, 179 insertions(+)
> > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > >  create mode 100644 lib/dt_purge.c
> >
> > What is the point of removing them? Instead, we should make sure that
> > we upstream the bindings and encourage SoC vendors to sync them. If we
> > remove them, no one will bother and U-Boot just becomes a dumping
> > ground.
>=20
> Well things like the binman entries in DT are U-Boot specific and not
> useful for HW related descriptions or for Linux or another OS being
> able to deal with HW so arguably we're already a dumping ground to
> some degree for not defining hardware.

It's about validation and Simon is literally in the process of having
the binman bindings upstreamed.

--=20
Tom

--Fo3unteMhmHmZ6Yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs3wkACgkQFHw5/5Y0
tyyQ0wv/d/BEDHigNdG8F1qbw9KvJEyEvdEIcV8izd0IAQPcN7es2AVz04OCpUAK
tYejURaU8gm6OJ+0/Gm2fYYkS5zV87JYkXSM1BJnZcwQ0RzDd9x+HmbXKuv71LvZ
MC72MfnEkcnw4Z7y+YaxVq0Gzh8BoMwXpCeTGOKtzLvN02aDw6vqtyzfg3Q+oifd
J5Fubq52iD7Ij5iwWgLCuRi+a9rlTkcy0oj07svSiDv2ygd/8Z4yBYWuiSkhHYX+
sU/nLl2JWQwH1/y5qzseMpaBipgydALYj9p7/qNEW7zcuaTMln6TjcMnshvYgRlk
w/7csX7th9upNoej7GhFDDxSItvjnqWT8LTqw2GFuwSiyY+QR1hNzwpW6fcx+xC+
xj0mWValgFiPc16PCZax1L3stSQAbOVBj0q7Q9y5NxEhw+tciWH3OBkVlqrspoOP
S64U0WXyNFVNClmF+g1zvE4T/x+JtfYrpIqg346BC1kjuVGPi5yw98c9OLHnuDjy
4NjHMcOH
=Qxcn
-----END PGP SIGNATURE-----

--Fo3unteMhmHmZ6Yd--
