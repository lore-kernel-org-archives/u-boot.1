Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A546C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 16:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09CD886E1;
	Tue, 11 Jun 2024 18:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="heSMAh7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5093D886E3; Tue, 11 Jun 2024 18:07:06 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012C5886C0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5ba090b0336so567653eaf.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718122022; x=1718726822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MVVgnEmUHlARmmFvJOfRX/U7TnAnI1mm77zkdfnYH7U=;
 b=heSMAh7P+qhzLai90iNbXswBzp+bvBVvZRoyPyCR3q1B/VJG1CuWD85yFx/1Vdm8GB
 cLKiRdAoV5PfX3HW+SqcEBIGRa9rb0pS9piWH6MNDjlFMjNpJpW25inKp8VSRBiWOKN/
 i6okM+wPsctWUPZJ5hcXYeRLORL7m5BF08HJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122022; x=1718726822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVVgnEmUHlARmmFvJOfRX/U7TnAnI1mm77zkdfnYH7U=;
 b=ob9oKENvnkn8vTHw+8pm9URbIzkLHXYye5tZOhtpw6KP5bNtmvULsedcOuNR0PqsaD
 NUk9nZVf/eo6u5NTmxdmHYxfBHZuOlnogG6udbZ1+2YIke46pKp9JFLz+AcHfRgzPR+2
 CVbxvpqnV9/mcaxpLj2xbXw602F5W4tZhpWGp5g1oSgkkAjlZIQXZKB1pWqgk5SeV3Bz
 qLSLQQ27yc3hLDh3ft1jC/vhkaRW0KmMQJrW1LMTy1BYHaq7U7FjSiC+iYapR9BNm3eA
 50d/FqT7ytoAkrFg4YvIAjDFwFYnvOhARH3QQBhAC2BT9bd+rrH+j6Y70pgEX7xHbXX0
 yqvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0eNRFc2Oi+yz3PpDn3YQ8lFqTjvPPd9a+BSghJJZ7KysKpLzGd/PVncdlN+nyOofu/qllQpJgrhTuHtvR1C/DtGkqzg==
X-Gm-Message-State: AOJu0YwitsMCwP6cFVgW5lTuAQCrmePfYtxPbn7Z12da7pFgjSkRIjpc
 ShAPmYv6x7ZPu3Wgo9SbRw4MLeTnkKzhkRUI44odE1OKzJhTe7NLNXPug2EmelY=
X-Google-Smtp-Source: AGHT+IGoxb9OhEwwLUVpKqf87gYJa9lebiEaCfGi+vqmjMgUmrvV5WMprMytt5pg0pYG5AXt9IstHQ==
X-Received: by 2002:a05:6820:809:b0:5bb:16a:e09e with SMTP id
 006d021491bc7-5bb016ae606mr7272927eaf.8.1718122022497; 
 Tue, 11 Jun 2024 09:07:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5baf0173e25sm888367eaf.33.2024.06.11.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:07:01 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:06:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, hs@denx.de, pro@denx.de,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240611160659.GH68077@bill-the-cat>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <34fcbe3d-f361-4671-8d27-e02f9a5dce9c@cherry.de>
 <20240611152733.GA441859@vamoiridPC>
 <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oq2kJvnX9FD1BfO6"
Content-Disposition: inline
In-Reply-To: <374a3eee-e24c-4acd-abc3-f69f628a285a@cherry.de>
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


--Oq2kJvnX9FD1BfO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 05:41:19PM +0200, Quentin Schulz wrote:
> Hi Vasileios,
>=20
> On 6/11/24 5:27 PM, Vasileios Amoiridis wrote:
> > On Tue, Jun 11, 2024 at 11:33:12AM +0200, Quentin Schulz wrote:
> > > Hi Vasileios,
> > >=20
> > > On 6/10/24 8:51 PM, Vasileios Amoiridis wrote:
> > > > Add support to save boot count variable in a file in a FAT filesyst=
em.
> > > >=20
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > ---
> > > >    doc/README.bootcount                          | 12 ++---
> > > >    drivers/bootcount/Kconfig                     | 53 +++++++++++++=
------
> > > >    drivers/bootcount/Makefile                    |  2 +-
> > > >    .../{bootcount_ext.c =3D> bootcount_fs.c}       | 12 ++---
> > > >    4 files changed, 50 insertions(+), 29 deletions(-)
> > > >    rename drivers/bootcount/{bootcount_ext.c =3D> bootcount_fs.c} (=
81%)
> > > >=20
> > > > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > > > index f6c5f82f..0f4ffb68 100644
> > > > --- a/doc/README.bootcount
> > > > +++ b/doc/README.bootcount
> > > > @@ -23,15 +23,15 @@ It is the responsibility of some application co=
de
> > > (typically a Linux
> > > >    application) to reset the variable "bootcount" to 0 when the sys=
tem
> > > booted
> > > >    successfully, thus allowing for more boot cycles.
> > > >=20
> > > > -CONFIG_BOOTCOUNT_EXT
> > > > +CONFIG_BOOTCOUNT_FS
> > > >    --------------------
> > > >=20
> > > > -This adds support for maintaining boot count in a file on an EXT
> > > filesystem.
> > > > -The file to use is defined by:
> > > > +This adds support for maintaining boot count in a file on a filesy=
stem.
> > > > +Supported filesystems are FAT and EXT. The file to use is defined =
by:
> > > >=20
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> > > > -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> > > > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > > > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > > > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> > > >=20
> > > >    The format of the file is:
> > > >=20
> > > > diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> > > > index 3c56253b..d3679eb5 100644
> > > > --- a/drivers/bootcount/Kconfig
> > > > +++ b/drivers/bootcount/Kconfig
> > > > @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
> > > >    	    Set to the address where the bootcount and bootcount magic
> > > >    	    will be stored.
> > > >=20
> > > > -config BOOTCOUNT_EXT
> > > > -	bool "Boot counter on EXT filesystem"
> > > > -	depends on FS_EXT4
> > > > -	select EXT4_WRITE
> > > > +config BOOTCOUNT_FS
> > > > +	bool "Boot counter on a filesystem"
> > > > +	depends on FS_EXT4 || FS_FAT
> > > Do we really need this 'depends on' here? Especially if we have a cho=
ice
> > > below...
> > >=20
> > Well, probably this is redundant indeed.
> >=20
> > > >    	help
> > > >    	  Add support for maintaining boot count in a file on an EXT
> > > The help text is still mentioning EXT here.
> > >=20
> >=20
> > Ahh, I missed that.
> >=20
> > > I would recommend removing it, or listing the supported filesystems a=
t the
> > > moment. While I assume you tested with FAT, I assume that with FS_ANY=
, any
> > > FS should be supported?
> > >=20
> >=20
> > Well, I tested it with both FAT and EXT4 and it works. AFAIU, due to the
> > implementation of the filesystem handling code in U-Boot, if the fs sup=
ports
> > a write a function, then it should work. But I cannot test for other
> > filesystems apart from FAT and EXT4 so I think it's better to limit the
> > option to these two.
> >=20
>=20
> I guess we can let people figure things out themselves and add new options
> for when they have tested them, no strong opinion here.
>=20
> > > >    	  filesystem.
> > > > @@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
> > > >    	  This option enables packing boot count magic value and boot c=
ount
> > > >    	  into single word (32 bits).
> > > >=20
> > > > -config SYS_BOOTCOUNT_EXT_INTERFACE
> > > > -	string "Interface on which to find boot counter EXT filesystem"
> > > > +if BOOTCOUNT_FS
> > > > +choice
> > > > +	prompt "Filesystem type"
> > > > +	default BOOTCOUNT_EXT
> > > > +
> > > > +config BOOTCOUNT_EXT
> > > > +	bool "Boot counter on EXT filesystem"
> > > > +	depends on FS_EXT4
> > > > +	select EXT4_WRITE
> > > > +	help
> > > > +	  Add support for maintaing boot counter in a file on EXT filesys=
tem"
> > > > +
> > > > +config BOOTCOUNT_FAT
> > > > +	bool "Boot counter on FAT filesystem"
> > > > +	depends on FS_FAT
> > > > +	select FAT_WRITE
> > > > +	help
> > > > +	  Add support for maintaing boot counter in a file on FAT filesys=
tem"
> > > > +
>=20
> Seems like I missed a typo here as well:
>=20
> s/maintaing/maintaining/ ? At least that's what we have in
> doc/README.bootcount
>=20
> > > > +endchoice
> > > > +endif
> > > > +
> > > Since we now support FS_ANY, do we really need this choice at all?
> > >=20
> > > Alternatively, should it **really** be a choice and not just a bunch =
of
> > > configs that depends on BOOTCOUNT_FS + whatever's needed to write on =
that FS
> > > instead? I think we could have both BOOTCOUNT_EXT and BOOTCOUNT_FAT s=
et
> > > without issue?
> > >=20
> > > Cheers,
> > > Quentin
> >=20
> > Well, I think I kind of get the point but I am still a bit confused.
> > Do you mean that basically the configuration should be done the other w=
ay
> > around? Instead of choosing BOOTCOUNT_FS and then specifically to choose
> > EXT or FAT, to choose one of EXT/FAT and then to select BOOTCOUNT_FS?
> > If yes, what is the advantage of this approach?
> >=20
>=20
> I'm suggesting:
>=20
> """
> config BOOTCOUNT_FS
> 	bool "Boot counter on a filesystem"
>  	help
>=20
> config BOOTCOUNT_EXT
> 	bool "Boot counter on EXT filesystem"
>         default y
> 	depends on BOOTCOUNT_FS
> 	depends on FS_EXT4
> 	select EXT4_WRITE
> 	help
> 	  Add support for maintaing boot counter in a file on EXT filesystem"
>=20
> config BOOTCOUNT_FAT
> 	bool "Boot counter on FAT filesystem"
> 	depends on BOOTCOUNT_FS
> 	depends on FS_FAT
> 	select FAT_WRITE
> 	help
> 	  Add support for maintaing boot counter in a file on FAT filesystem"
> """
>=20
> This way we can have defconfigs where BOOTCOUNT_FAT and BOOTCOUNT_EXT are
> both selected, the user would then be free to decide if the same partition
> on two different devices but for the same purpose can be either ext2/3/4 =
or
> FAT, without recompiling U-Boot just for that.
>=20
> However, it would now be possible to have BOOTCOUNT_FS=3Dy but neither
> BOOTCOUNT_EXT nor BOOTCOUNT_FAT set to y (e.g. if FS_EXT4 or FS_FAT isn't
> defined).
>=20
> Finally, the other option was just to NOT have BOOTCOUNT_FAT or
> BOOTCOUNT_EXT and let people select FS_EXT4/FS_FAT and EXT4_WRITE/FAT_WRI=
TE
> themselves since the BOOTCOUNT_FAT/EXT aren't actually used in C code. Th=
is
> is less user-friendly though.

I was thinking that with FS_ANY, we don't need a symbol per filesystem
type but can just handle it in the help text with something like "Please
ensure that you have enabled write support for the filesystem that you
will be used by the partition that you configure this feature for."

--=20
Tom

--Oq2kJvnX9FD1BfO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZodhwACgkQFHw5/5Y0
tyw0JwwAl1irjSuvUb323IUBMjNDJai5k+tYeYqkCj4p8sY7iIDVG4CwwmkxdcKs
4hEChL+K7Xf6CTPnHnhyE+aEuvpoBVv76ggK7syNbI5F6vEtYUcWfsXUsqHo8qp1
N2ebxaFy6vX+vy6q8RAhz52ZxhSkdgFHR6wOiHJqEzL6c/nCkWt3reX/QXUFPF2u
DcRZpCQHEHvDDOiw0QxlvjvKAlCYe1YqCbMlx3zsKKrdnst2b0ztCTvmOBDyX3Kc
i+m+/Ud+8bJW7/GzpOk6ZIygimOkqWJvlyGevHkODD17v4NqMxG4ODKzzIywX3UT
vV3efldt3emdi6KpJeT6qIdoSybNPAaDbdrQK7mgKFc81ZHAwAZo9R+GCRGlHRZC
U7pEs4ijPFj+s7gq9P4wALfwFCY3CnvaJP0ezHjXk2DX+F6wIG+9qCz6HXtOdgkQ
5HslPGq4L0OsAWzeLpi0ZZf1Yxu5FH/+tBmIwX4Hy1xDw1eXIHMpMH5S5k37jS01
q17Qd38T
=dlVq
-----END PGP SIGNATURE-----

--Oq2kJvnX9FD1BfO6--
