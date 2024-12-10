Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D0CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 17:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184D180200;
	Tue, 10 Dec 2024 18:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hMyUVRzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD0C80202; Tue, 10 Dec 2024 18:11:20 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81FC801FE
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8f544d227so23373896d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733850676; x=1734455476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NtvLxrm1C0khnbiuDEYgv3LN7PtXokYCRSboiHLpxXI=;
 b=hMyUVRzr6HhRmcd64oQUZeen58gcFPE/jC2ilSGDLMLD1US7+gBV1QFsGMTGRte5P7
 4Q3+VaSxdhj8L5mMlFdXo0u+7BEd3ju+iKITcTvs9Y9yJs/zMuC1FPOhcinDAnemcsQG
 nyP1ltJ5vmteCLUstomiKfrVz84fTE9l1Du4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733850676; x=1734455476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtvLxrm1C0khnbiuDEYgv3LN7PtXokYCRSboiHLpxXI=;
 b=nkI0WcQmNK7MWraB+sEtfOGvEamCk/YvIJqpHWR1LNP8WYWMjOLhf3aBM4VA+rniqe
 rt4ttr5r1A2qZdjJdw75y79L/nA1wDjUGBRmtST5xx0agylweW0kn6WwzzNoAGKMFtFt
 kyUU/Wt0VuPxApLq/PUW9Y130lmOoH+bkDdFlTTWDDlx9LuDDV1wVnHOi3Q21dMfUrRe
 Na5mm51fkp9xqrPvIoInjmUsL6Yc91cteZj8wvVKyr5B0UDwfzRPpM29s5ci98FAqUs3
 mHjdBLoSKDyYX0dXvMjnTICjy72fs+IvN4+TirHJjidsdu72vwXiUjJcPQYicL61ydt6
 G7+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUdAHrSc7V4z5HQ3BNk0H7nbfusyF0fDAnAHjn01V8CmYsABxJWfYrpBvrjupVc//ZVITlsRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyPsiuAJgPnt4wcPxy4wnDTT3UM7EtUpMKryJTvppLlhinnWgzD
 0xcGXYo9LkYy9YlggeoVDNeOCYh9eI4GGPbXtnrKg9LiTaPBoMHWK5/8lf9yzfg=
X-Gm-Gg: ASbGncvBMX6SfZ6ZC/c+8zNnxvDOa2BqmdkCjvrv1aF+j1GJanfxy6BBlwS+cBqEdZg
 7uMgqUhJi6R8NFnp4M2ouOPzsIE14Ch7Lr/Ma8zup6CXrUa0BH5QIBJAfqOIulsU5e1TAcwfXnx
 k6UTz0yxlqhBMuTj/f0Yxs9cvc0hNWCtqFnHa0kgP/X29VrP8dEOUUKJM9i6Ed6dbqjMfoeYBWP
 zsHGVzMcyOqvqmkLrn0vjS14ruUmjhI5I6sZNH3vnYD0FlEBEgLjA==
X-Google-Smtp-Source: AGHT+IE150k0Uvn2aSI1YFw4iotrx2TluAbJ9k3G3cn5b1DZPCseellR+cmEKs4oHrnV64vxrXZ63A==
X-Received: by 2002:a05:6214:19c3:b0:6d8:8a60:ef2c with SMTP id
 6a1803df08f44-6d8e70d6726mr329420516d6.2.1733850676637; 
 Tue, 10 Dec 2024 09:11:16 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66da48sm61568726d6.13.2024.12.10.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 09:11:15 -0800 (PST)
Date: Tue, 10 Dec 2024 11:11:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthew Garrett <mjg59@srcf.ucam.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
Message-ID: <20241210171113.GD2457179@bill-the-cat>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
 <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jEdFxDMrQ3ZhPXdW"
Content-Disposition: inline
In-Reply-To: <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
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


--jEdFxDMrQ3ZhPXdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 09:17:26AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 10 Dec 2024 at 01:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 23.11.24 20:55, Matthew Garrett wrote:
> > > From: Janis Danisevskis <jdanisevskis@aurora.tech>
> > >
> > > efi_bind_block had two issues.
> > > 1. A pointer to a the stack was inserted as plat structure and thus u=
sed
> > > beyond its life time.
> > > 2. Only the first segment of the device path was copied into the
> > > platfom data structure resulting in an unterminated device path.
> > >
> > > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> > > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > > ---
> > >
> > >   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
> > >   1 file changed, 21 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> > > index 9704020b749..cc91e1d74b8 100644
> > > --- a/lib/efi/efi_app_init.c
> > > +++ b/lib/efi/efi_app_init.c
> > > @@ -19,6 +19,15 @@
> > >
> > >   DECLARE_GLOBAL_DATA_PTR;
> > >
> > > +static size_t device_path_length(const struct efi_device_path *devic=
e_path)
> > > +{
> > > +     const struct efi_device_path *d;
> > > +
> > > +     for (d =3D device_path; d->type !=3D DEVICE_PATH_TYPE_END; d =
=3D (void *)d + d->length) {
> > > +     }
> > > +     return (void *)d - (void *)device_path + d->length;
> > > +}
> > > +
> > >   /**
> > >    * efi_bind_block() - bind a new block device to an EFI device
> > >    *
> > > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct ef=
i_block_io *blkio,
> > >                  struct efi_device_path *device_path, int len,
> > >                  struct udevice **devp)
> > >   {
> > > -     struct efi_media_plat plat;
> > > +     struct efi_media_plat *plat;
> > >       struct udevice *dev;
> > >       char name[18];
> > >       int ret;
> > > -
> > > -     plat.handle =3D handle;
> > > -     plat.blkio =3D blkio;
> > > -     plat.device_path =3D malloc(device_path->length);
> > > -     if (!plat.device_path)
> > > +     size_t device_path_len =3D device_path_length(device_path);
> > > +
> > > +     plat =3D malloc(sizeof(struct efi_media_plat));
> > > +     if (!plat)
> > > +             return log_msg_ret("plat", -ENOMEM);
> > > +     plat->handle =3D handle;
> > > +     plat->blkio =3D blkio;
> > > +     plat->device_path =3D malloc(device_path_len);
> > > +     if (!plat->device_path)
> > >               return log_msg_ret("path", -ENOMEM);
> > > -     memcpy(plat.device_path, device_path, device_path->length);
> > > +     memcpy(plat->device_path, device_path, device_path_len);
> > >       ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_m=
edia",
> > > -                       &plat, ofnode_null(), &dev);
> > > +                       plat, ofnode_null(), &dev);
> > >       if (ret)
> > >               return log_msg_ret("bind", ret);
> >
> > Here you have a memory leak for pointer plat if ret !=3D 0.
> >
> > Simon suggested a follow up patch. Instead we should fix it in this pat=
ch.
> >
> > @Simon
> > The logic in the caller setup_block() looks wrong.
> >
> > LocateHandle() does not ensure that when you try to read from the block
> > device the same still does exist. E.g. if a USB device is removed the
> > block IO protocol could be uninstalled and the handle deleted and the
> > EFI app may crash. Please, call OpenProtocol() with attribute BY_DRIVER.
> >
> > HandleProtocol() is considered deprecated. Please, use OpenProtocol()
> > instead.
>=20
> Can you please send a follow-up with your ideas on this?

Simon, it's in your tree. The normal path here would be that the
submitter would correct this in v2. But you're trying to short-circuit
that path for your own reasons. No one should be making work on top of
your tree except for you.

--=20
Tom

--jEdFxDMrQ3ZhPXdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdYdjEACgkQFHw5/5Y0
tyyBEQwAkhvUZPvKnMhZ+nCTiPVTIOd/3Pp6RdU+WAYxRifXfFVfiRvSc9d/xJyq
Jjv5WE6DZ1rWi4Y0WcOfz3EMa0FPqug142FVUvlIUseIgYTmObyXWHM0Ar+eb4Id
8BlK6H3M2evX1SZAnF6H0UE/MHeZvvjFqEWPhIUrirxLMI86a3Xhf+62QUfhAnhQ
lB49Iq5Lna5OHdmV0AtIrv45rKxpnefSBgaI3M70CYo6QHWeNxa+cTHFqbyi9FNr
7YlLNchc42CcljDhFdkBn1LjQsyhGOMPZFuosCpVNRz+RrkChGHJIx552gpHJAzV
2FuqT7QrGq1R35NJeZ0tgs7UJ8rns/AukOg7RX04U/cs2pyGFzncZQxh4XpsG963
lPu+1BifPk4t+wGa21DRmahLOPKfQgvkIdqC0pPVngwxHIgS2fztNrTNX3+w2mOn
W6jDULr1KCukAc0ipYNxzCtlHSwteblQKwHA8OJzmBhy3fe8Iay6cjFbFaYJwXVa
hM6oeirW
=FwQ0
-----END PGP SIGNATURE-----

--jEdFxDMrQ3ZhPXdW--
