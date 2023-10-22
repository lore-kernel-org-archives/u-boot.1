Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD6ECDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 17:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D9587777;
	Sun, 22 Oct 2023 19:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lK7HiEJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883D087770; Sun, 22 Oct 2023 19:08:19 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC4268779C
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 19:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a8628e54d4so20789807b3.0
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697994495; x=1698599295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N4W1ggQDjZ9Mn0gCuYRtWfwZceYVPAye8PenVZl7iXg=;
 b=lK7HiEJZ1Ca/z7ac/fz4EDrGBG2zgAjwHrzqrArC6+8tb0KmrT/s2LTLBzLyGnJxq8
 DqZ0l0c0XbOxo8PvQ5vaFF640V3s1mC5M5PmClZ9Hdrfj3LkknGM79W6ptVA3N1yXg/W
 husvhTmySqFVbnhU3iDJMKYXMRFh/h55Fn50c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697994495; x=1698599295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4W1ggQDjZ9Mn0gCuYRtWfwZceYVPAye8PenVZl7iXg=;
 b=ab1ph4zmt/Hj6nPa5NTX0OQ4gGA8JOxNkNVIXtyWZvlzDkJz7ZCcGO8eJYA4UjVtYA
 QaSt9eYbOc3k6xYW2Wx4XZOuciIRi+XHGUcQqI7XBf5au5U9693wJO0t3/26SVW6s1/O
 7ClS8QOLuOcebSuOHO5BJ0hvJyJEWs/i33XvODxaI6sNifzSkbDhF8S5hf7IF6PG+04t
 ta+tIsW9OZxCEBxlHNxXizzajMNC870RHz7vivQeTKTzym908ExG+mBf9PQjzWC7Usju
 3s9E2VVY+rbyTyOHBZilecjj9s74IRWKkK8HqLIjDeqacw3lVrByZ/bKa3pMaSO4Gku4
 rOJw==
X-Gm-Message-State: AOJu0YxnLyrnHXv3k1m6xFdF0qI1Xfxy+4rWk/6aP/QsNCYJ8U2skd/m
 mlThMEWuzlJHrYZpDJkQUXb0sg==
X-Google-Smtp-Source: AGHT+IHZDTKBH5+j3m7Ux1Wlh1c4Hj5if0uJe1IFUGu07Sx1408t5tLdYghk2NOXIOYsnSRplyycyA==
X-Received: by 2002:a81:9294:0:b0:5a7:f61f:7000 with SMTP id
 j142-20020a819294000000b005a7f61f7000mr6887488ywg.1.1697994495372; 
 Sun, 22 Oct 2023 10:08:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d02f-b9d9-0a79-793c.res6.spectrum.com.
 [2603:6081:7b00:6400:d02f:b9d9:a79:793c])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a0de20f000000b0059beb468cb4sm2433790ywe.1.2023.10.22.10.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 10:08:14 -0700 (PDT)
Date: Sun, 22 Oct 2023 13:08:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231022170812.GD496310@bill-the-cat>
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
 <20231022155543.GC496310@bill-the-cat>
 <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WQp2FrMtRGV4cb4X"
Content-Disposition: inline
In-Reply-To: <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
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


--WQp2FrMtRGV4cb4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 06:34:08PM +0200, Heinrich Schuchardt wrote:
> On 10/22/23 17:55, Tom Rini wrote:
> > On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:
> >=20
> > > Forward and backward compatibility of Linux kernel device-trees is
> > > sometimes missing. One solution approach is to load a kernel specific
> > > device-tree. This can either be done via a U-Boot scripts (like the o=
ne
> > > generated by Debian package flash-kernel or by a boot loader like GRU=
B.
> > > The boot loader approach currently requires to know the device-tree n=
ame
> > > before first boot which makes it unusable for generic images.
> > >=20
> > > Expose the device-tree file name as EFI variable FdtFile.
> > > This will allow bootloaders to load a kernel specific device-tree.
> > >=20
> > > The variable will not be exposed on ACPI based systems or if the
> > > environment variable fdtfile is not defined.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v3:
> > > 	Add documentation
> > > v2:
> > > 	Use a unique GUID to enable future U-Boot independent
> > > 	standardization.
> > > 	Do not try to add the variable on ACPI based systems.
> > > ---
> > >   doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
> > >   include/efi_loader.h       |  5 +++++
> > >   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > >   3 files changed, 52 insertions(+)
> > >=20
> > > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > > index fb16ac743a..a81d09ae81 100644
> > > --- a/doc/develop/uefi/uefi.rst
> > > +++ b/doc/develop/uefi/uefi.rst
> > > @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is::
> > >       Loaded image - end node (0xff) - VenMedia - initrd_1 - [end nod=
e (0x01) - initrd_n ...] - end node (0xff)
> > > +EFI variable FdtFile
> > > +~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Ideally U-Boot would always expose a device-tree that can be used fo=
r booting
> > > +any operating systems. Unfortunately operating systems like Linux so=
metimes
> > > +break forward and backward compatibility. In this case there is a ne=
ed to load
> > > +an operating system version specific device-tree.
> > > +
> > > +U-Boot has an environment variable fdtfile identifying the device-tr=
ee file to
> > > +load. The content of this variable is exposed as EFI variable Fdtfil=
e, vendor
> > > +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tr=
ee path
> > > +name as a NUL terminated ASCII string.
> > > +
> > > +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wandbo=
ard.dtb'.
> > > +On other architectures the file name is preceded by the vendor direc=
tory, e.g.
> > > +'rockchip/rk3326-odroid-go2.dtb'.
> >=20
> > The Linux Kernel has split 32bit ARM up by directory now, too.
>=20
> Since Linux v6.5. That is why I wrote "currently". Once we migrate the
> values of $fdtfile in U-Boot we may want to change
> distro_efi_try_bootflow_files() to search both with and without vendor
> directory.
>=20
> Are there already plans for that migration?

Right, v6.5 is out and has this change and v6.6 will be out soon enough,
so the documentation we're adding here and now should be worded such
that doesn't get stuck on these specifics.

And then how this kind of breaking change will be handled by
distros and everyone else is something I wonder about.

--=20
Tom

--WQp2FrMtRGV4cb4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1VvYACgkQFHw5/5Y0
tywvYwv9GrSFik8vxZE7xVQXOAaHZ+08tautnlPDBHRhnXq2SvMAezGaTKXCV4Hg
/ddCFaK3K8wf9Qs3GBhs2oaERYz+3DIMhCFKV8V6W0i4z+OTlulJYWI4dRWexuD0
3NtC8ovoXrohcS/AiWOC/t6ltDGWkyq9KnHpjBDupWp6xQP/x9DZD4uoKXH5fuK/
CZaY04pUlMpKi0PWAvgvYA4B0xAI3v7UvxhzD1u0Tk/lMSP8Jh6LaeG+mjWtQ61X
w5vS6ro0oX4KEFmPqBVtlShLsqHjmPjtGYjjAM6o2tqpVWhMeXuiZgMs8jKYH0It
86sh9q/4cNB1sFC/+T0vv7va504EJfgSThh2oxQoGIfaKaXlb+q13HLGua8a0cNg
DK0p6lRMObSadtbrkLnc/6lTZokj3g6JLUT9WpB0tm7kWQV2TcII3IS98uoxq6OS
neFGy4G64GPNcvjBCBdLn1QdnQiTGYugB1WlTIet64qYvrV5Mn/x9qvlLTzHXWQm
j2U+rPIy
=hvC/
-----END PGP SIGNATURE-----

--WQp2FrMtRGV4cb4X--
