Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983DECA0EDC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 16:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F0F88C09;
	Fri, 30 Aug 2024 18:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gx4kwssC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C301688C69; Fri, 30 Aug 2024 18:45:20 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A31988A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 18:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso729816d6.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725036317; x=1725641117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d4oG6iz0veVH0Z+BOcZhx7wONW3v34WJ+tzBweOpxZs=;
 b=gx4kwssCj2dBX1dOCiG8et5BSuj3gm/vQPk0dxP9Za4TxM5sMHjP9fAs9AHTiLasXc
 eHMljrZ2UH/0qpyyqcU88iZAN14auwLYAfe6iDGUJ2wjaGQBPHqrioqX1lROUrZyTjha
 Hi5tnUSQJOWMXhY9t7w8wtaYA3CvT8zQgo0HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036317; x=1725641117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4oG6iz0veVH0Z+BOcZhx7wONW3v34WJ+tzBweOpxZs=;
 b=mySEzWWCPfcVlo4xchqPo96aBRtM5oRB20pEcXXmbq85EV647lGZ19sGwONJqanCbo
 ts5k3yVlDnA3xIUBKz8rVeidyO6IoH82/JWcaY72luiL/J4xQfRsQvKtks5BMeZSqwkY
 Vli3br7bR5P3K9wjfEHcCNS1BxzAbmCfkS6H/XF1yAifZ6iIm90Od/eqMzd20AXSYcy1
 owT1UAK6iGgCtTX48yctHgcabkRdW0UTYGwCA0X9ekd5TWmLTBa6AgOIZ5+oE+D2UEcj
 OAlilyD0RrWKQ2hYGq4HtRk4ZoI+dIol+ShiA8MfP573JlBiq79ESEqZyVHtDi2Si+ZK
 B9Zg==
X-Gm-Message-State: AOJu0Yzn3L6mbUXcbjtk2gGJaivML3AqiUQ5rVoWasYHJMCNsUPcr5t0
 yMx9w+z5xdEwl/EEDCinD7FkrvQUsCo9Ec2VT6L0Zy3Hn9rf29nMtV2w7eT8v6c=
X-Google-Smtp-Source: AGHT+IFu9bydIqYRb5KByPz5PjbeUP7llXiWScy385hubFdbgqtNX2CzvRbt6h5JpuWit2O+FH+yBg==
X-Received: by 2002:a05:6214:765:b0:6b5:e761:73ce with SMTP id
 6a1803df08f44-6c33f351a03mr87294946d6.16.1725036317284; 
 Fri, 30 Aug 2024 09:45:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c96804sm16036746d6.93.2024.08.30.09.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:45:16 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:45:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use kernel=
 and simplify logic
Message-ID: <20240830164513.GV2479150@bill-the-cat>
References: <20240829185602.3179812-1-trini@konsulko.com>
 <CAFLszThtfWK7pm-JV35Z083G43TL3ySfcuX9a83-rcMHmh=OnA@mail.gmail.com>
 <20240830014943.GR2479150@bill-the-cat>
 <CAFLszTivDQ50yvTgXqc88afxX6UgcFNVLCGp=34HuwgaGt7ytw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeNPwt6FNKq8Csl2"
Content-Disposition: inline
In-Reply-To: <CAFLszTivDQ50yvTgXqc88afxX6UgcFNVLCGp=34HuwgaGt7ytw@mail.gmail.com>
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


--eeNPwt6FNKq8Csl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 08:19:04AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Aug 29, 2024, 19:49 Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 07:06:06PM -0600, Simon Glass wrote:
> > > On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Rather than guess what we need to name our u-boot.bin file as for i=
t to
> > > > boot make use of the kernel=3D option to always call it u-boot.bin =
and
> > > > then on 64bit platforms (and since future platforms use rpi_arm64 t=
his
> > > > list should not grow) also pass in arm_64bit=3D1.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >  bin/writer.rpi_mount | 25 ++++++-------------------
> > > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > > diff --git a/bin/writer.rpi_mount b/bin/writer.rpi_mount
> > > > index 73fb8bf6af04..ab7c3b5a2430 100755
> > > > --- a/bin/writer.rpi_mount
> > > > +++ b/bin/writer.rpi_mount
> > > > @@ -25,30 +25,17 @@ build=3D${U_BOOT_BUILD_DIR}
> > > >
> > > >  echo "Writing to ${mount_dir} from build at ${build}"
> > > >
> > > > +sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
> > > > +
> > > > +echo "enable_uart=3D1" | sudo tee ${mount_dir}/config.txt
> > > > +echo "kernel=3Du-boot.bin" | sudo tee -a ${mount_dir}/config.txt
> > >
> > > Does this keep appending more and more lines?
> >
> > No, the first tee will zero the file and subsequent -a's append.
>=20
> Oh yes.
>=20
> This is one trouble I have with rpi - there is an existing config.txt
> and some of it seems to be necessary on some boards. But I don't have
> the code to set up everything. Typically I just get a config from a
> distro and that is how stays, with just an addition or two. If we can
> generate it from scratch as you do here, then things are easier.

Yeah, it's very possible to go down a large rabbit-hole with Pi and the
config.txt and getting everything Just Right(tm). Enabling the UART and
as needed, saying it's 64bit is enough for basic testing but more is
likely needed if say a follow up step was to run some wayland tests and
confirm that output.

--=20
Tom

--eeNPwt6FNKq8Csl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbR9xMACgkQFHw5/5Y0
tywLmgwAgTYxMWueVSmvj5ulcvwOOSbzYiJ/A3dk98H6y9Q8K/YguhxrJUzrmSBP
Ei+lyocPc+P6ROr0cDyigBs6cAjnY0B3DNElYfKzh3qhOMIvE1oJ6pyoqLKxyHDX
XnIVI7p8OTu8TV6njUdftixNojuQuk6S7t0LO7bLLrbiGNzYOXMvPBb+GfGfVNNE
Vefu8gGntLO6B6zggKMndxCKmjVT002jM+qKySTEa1yjXygmsMhFgZSQjD1+uetO
dhugXX06VOW5pHkjLVkzn0vFsfuH5wM24KW3FR86kOSLlfWq1cP5e2h1pe8g2O0t
kZ4Px3QhvdQ5xUp+5QkQSsTPf5l5W69mUOtsP2BNclrg1SpASXXLzWE3yJKWQEEO
eenJUfRQ0AeI7enazgA8wU0FTWo5Uk3ooPBWOv/6ENh5JaOXx3H3uOKF880U+04J
GX0CpZ/fNyhdVhcVKhHBAu09TlH/Ca4mlcE0yiLcK1Wyv/+O13cN2K5lOkhcii4o
F733h2pu
=uLvx
-----END PGP SIGNATURE-----

--eeNPwt6FNKq8Csl2--
