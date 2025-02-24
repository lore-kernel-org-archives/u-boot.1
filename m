Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B3C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 16:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E010E80079;
	Mon, 24 Feb 2025 17:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LPMujpan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7186805C3; Mon, 24 Feb 2025 17:03:12 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEAD80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 17:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22114b800f7so90420225ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740412989; x=1741017789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kSEFy3Vh3pO+m+DJmFSt07QipKW+YHtwMQJoSCFXbM4=;
 b=LPMujpanZvE/YK0e8WSmHEz1gMfn6I0rdUtxPXUEe7uL8CS3mvvGDP+yZjV0geXkwK
 SBzjr/LIYahJYT3wbh0EZX5UJa8yJcOpvoU914eSO3DaJ3z/jPiE5JEV0mWpLuHXS6Zs
 yvtxtEBED029/oqmww5gf//JwpCa8JxXGbEiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740412989; x=1741017789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSEFy3Vh3pO+m+DJmFSt07QipKW+YHtwMQJoSCFXbM4=;
 b=s+JfForDJBYVmPJ2c5yq/13pzGEmRtljH/ol/VfOgDIt5IGa3+mp4qWXnSYDawCIlB
 OtuiqCmdThO3MvDvJIjdf6vKev/Y2kM7y3wYhIPreqTzxNhuxX2MQpy2L5I7v2gBsHkj
 21PV6N2sh+4ZmDe7xoQY5xt3+fIuM6FdohYgCZhHlgmI+PGDTu+9jeqSB/HBMqzEqd7A
 FsEpUqfhOuClMReddPTI/Qkff3CIdSEesi3e5hrL3qiBKHUztUj/gfuVdFRdUjlS4vtt
 rqLUSyqI09MvBJZc486S7zKzcJNi64zlAxZnTs5MCRBsolnSug8w+X+js4ida76x4QZS
 mpNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN3Ub3KQq55GfSv/pNDOBJXgq54UGwd6D1ZBTP67E7oLC3Kbl65vAxARNxGD3TmwMwtnD/Mcs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg98T0vVRqR4Lb1CDefxBgVq2vXOn4O4vSGDoyPCfLR/G4QfTF
 6gj1JX4Y3mISPQsRsQTYHb7ffFRxhGh07QKyngC4nAVtBYHM9usa1k/G3PNA1aM=
X-Gm-Gg: ASbGncvM7JaeuhDl+sEJACOu4zNJPj0uZwE+Rts7AVc1qCZH9fsKojJ+fi2jvwGj3yc
 R1e+c6kGc+ZbYNV9LDUM/fcC9S88kByiimrIyOAVl/QfMxJ0OLCAboBw4bHLgETZb007/vLyNxh
 pdPdNaSwueG+vZ7S7MR49XRVN7sI7pQQzo+1wi0lJ8bD/00SYAx+7M1hVIw7ICH1baYrIVT8GId
 lo2I5wSavuN/EkIodLdYBFBvcsUrSjdxO1XfFfALWUBOx8CesTJr4IKudgL4ezv/hYBlcZMWxi1
 jBGApeI9ZLkkwpIQ7BNKii87
X-Google-Smtp-Source: AGHT+IFMz/ZUKunfS/0WfOFcmZ/PLxPpI3ofJdLwhYy9uf6d9ogvSzpEBH6JjyfkFaW97ISnqqXEkw==
X-Received: by 2002:a05:6a00:1892:b0:730:7885:d902 with SMTP id
 d2e1a72fcca58-73426af0afcmr22349491b3a.0.1740412989103; 
 Mon, 24 Feb 2025 08:03:09 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73440ea9381sm4523307b3a.157.2025.02.24.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 08:03:08 -0800 (PST)
Date: Mon, 24 Feb 2025 10:03:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 10/17] spl: Align FDT load address
Message-ID: <20250224160305.GG1233568@bill-the-cat>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-11-CFSworks@gmail.com>
 <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
 <20250224145657.GD1233568@bill-the-cat>
 <31342144-345b-4dd8-b80e-f53376a591d8@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o92vIlBuH4sxMk2E"
Content-Disposition: inline
In-Reply-To: <31342144-345b-4dd8-b80e-f53376a591d8@gmx.de>
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


--o92vIlBuH4sxMk2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 04:54:09PM +0100, Heinrich Schuchardt wrote:
> On 24.02.25 15:56, Tom Rini wrote:
> > On Mon, Feb 24, 2025 at 09:59:42AM +0100, Heinrich Schuchardt wrote:
> > > On 2/24/25 06:55, Sam Edwards wrote:
> > > > While the image size is generally a multiple of 8 bytes, this is not
> > > > actually guaranteed; some linkers (like LLD) may shave a few bytes =
off
> > > > of the end of output sections if there are no content bytes there. =
Since
> > > > libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
> > > > explicit about the alignment when loading the FDT.
> > > >=20
> > > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > > ---
> > > >    common/spl/spl_fit.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > > > index 49b4df60560..86506d6905c 100644
> > > > --- a/common/spl/spl_fit.c
> > > > +++ b/common/spl/spl_fit.c
> > > > @@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_=
info *spl_image,
> > > >    	 * Use the address following the image as target address for the
> > > >    	 * device tree.
> > > >    	 */
> > > > -	image_info.load_addr =3D spl_image->load_addr + spl_image->size;
> > > > +	image_info.load_addr =3D ALIGN(spl_image->load_addr + spl_image->=
size, 8);
> > >=20
> > > We want to keep the SPL code size as small as possible as on many
> > > platforms it is restricted to the cache size.
> > >=20
> > > Can't we fix this linker issue in the linker script by properly align=
ing
> > > the SPL image end address?
> >=20
> > Size growth is always something to watch for, but not at the expense of
> > correctness and saving a few bytes. We really do need to fix the places
> > where U-Boot could but doesn't ensure the device tree is correctly
> > aligned in memory.
> >=20
>=20
> Hello Tom,
>=20
> spl_image->load_addr is always a multiple of 8.
>=20
> Adding
>=20
>    . =3D ALIGN(8)"
>=20
> in arch/riscv/cpu/u-boot-spl.lds before
>=20
>     _end =3D .;
>     _image_binary_end =3D .;
>=20
> is all it takes.

But this is generic code and I don't see how we know that in every case
every way we could be reading the device tree that it will be at an 8
byte aligned location. There's a number of ways today where it's not,
which is what Patrice found as part of updating our own libfdt to one
that enforces the alignment check.

--=20
Tom

--o92vIlBuH4sxMk2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8mDkACgkQFHw5/5Y0
tywL1gv9GUzr7z5TdK2R3FfogeGHnS+1HHDpG9atTA+qJ5YvFXkXoOUB9f4N99a4
bLg2Od47Gbri12VeO/rNzypRsk+BPlSsBbLI48Qm+Hdm4uOVm/h35zHIr6d18LQT
oZq3LD3Nk9jSuVc7bxQ2ibiXkC1u8jacWcKyeuxRirmEZAv6kMoX8zelIfgLgkWF
ECJ57AWuGGNu8YGSNWDUaoKptAQe0LRI3anUVzltiDGCTEofbclz5Em0mWTf8O+X
BTwlCNAbEG3/gdB/n9lQ2GbvT2d5UjhTShocU3hcOg/2eiCfjt+3BLyi5otZhbeE
j40ZceWVvKGnbn7qlZNCAF6RMLyZfclvsTl86UUcsuA+srobRe61MsmcfOaj6JLZ
wcQokpHs9GDKMQKV6HxsYcNm/e0bU06/xw0s6eS/UAlnAy7/lHUEUxj2kk3xnGOy
eE+Edz8KXf4ELeB2BtwZYBd+4t50HZKlOcOM8JebGljDcMjdoQeUpVc/zeO9PzvW
9oX66Uuk
=EdmU
-----END PGP SIGNATURE-----

--o92vIlBuH4sxMk2E--
