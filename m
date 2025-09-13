Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BCCAC58E
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 15:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061EA82FC7;
	Sat, 13 Sep 2025 17:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4YneoXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A9683043; Sat, 13 Sep 2025 17:18:15 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9037282AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 17:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-407ec3048a0so31824895ab.3
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757776691; x=1758381491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hd1govipbZ0Rpz67djsWBVraWPcVFl1k122bz1rQ+4Y=;
 b=L4YneoXN3i/yPHVIKTA4I/bd2fiiqT23gpaJheo2R9gdhCj1pnWi9UYr+44qkeDplW
 YhtAAuHtb4sRTyBrv+u/PVV2zgHxxQ8GXw5yKFaVnQufaJ18SddtgcpCfMGcya6fu2eH
 dBu/OuT0PR5kbCD1H1yXCtO3liPjIWXVOjUZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757776691; x=1758381491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd1govipbZ0Rpz67djsWBVraWPcVFl1k122bz1rQ+4Y=;
 b=EQDDEMefUKdduwxci9Fz2F8APOKzltiW/f2P+zyyVv3Gm1FGI/6H7favYdPtir4sx4
 0oTZzcDNPgiVpcuZayhllKq9/BAto0V5qYqRDi+x8joWFHfl/yDcZM+c0c7yVmPoB/dv
 8fX9UCLcO+SwTuJCC4nOpU5/Oq1f9Mjij2RxdkzHjq3Fy1+oSND13ye0py38YZPHcPT+
 WYQ9uMbcNmiNK4dFrpMPN1HOHmpfMVCB7qplLXQkc0iS8x3i6I1on4GqhXAkiin2KxM6
 3GYq6h4JeW7YRExrxv6vH57JMwvJbkXu8XMKLCusMnJfkfu/3lAVzoDnlSPz0G4LTDtq
 Vdzg==
X-Gm-Message-State: AOJu0YxqhtNA0o6zADXqvkUAw9Gi9WpB/lkSq8eWoBh2LUDknVW2ygTe
 PmvOeX5hU8xYbQXoRjVgU3HtuAnyXYpB7RaOSWv35bgU7F9C663L44UMFNGpG9DeVWE=
X-Gm-Gg: ASbGncuMvnzqR4zSDc8IRD2RqxYRQJKMh+Hh+lzjIUbGlb+2/ktQtsmu4gpjm+jPfqD
 63CqByGXtiHw2aE4jyEsO2yPBxB4PfTjac3hX2VstQum4ZkOycnmy5XMkNfvfAaOidTLIlJvMkh
 LvAiWVYBQqlYqohJLw8wwwKcxv+T36dyxVlRaZvNktZ9bwup7U3p952IVRiFWuiaZ4XIkLb/Zl8
 MNMTf9OBCIPPsOw1CzFlM9jdc6WegqIyvGObD5+/9URXKrzr5TBbUaSBv+xeLmeEA7tl6xwjOsc
 hE5MvCsgj5D8bgVMyqG2yOBmsEhggf7ToCfKhjJ2jl4ui2pitjY/QHzK4UszlQnmJhoU3AbupmH
 NzHh09PruqGqBDZsvFh+DKxm4hih2UXwejKgZoh0DGhhn2tEEU2FXz609mqdu9ISK9QM=
X-Google-Smtp-Source: AGHT+IE9COUZyCKzYYbYDs2bDLgzuJCEvlMwBPsMdBvCJypBy9AOOgdTJ3vMccUFqzPD8MJMB/ZIyQ==
X-Received: by 2002:a05:6e02:1a67:b0:3fd:a540:9352 with SMTP id
 e9e14a558f8ab-420a3026147mr86654835ab.17.1757776690954; 
 Sat, 13 Sep 2025 08:18:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41df02f4c83sm33004895ab.17.2025.09.13.08.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 08:18:10 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:18:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Convert README.commands.spl to rST
Message-ID: <20250913151807.GE124814@bill-the-cat>
References: <20250912230257.4145026-1-trini@konsulko.com>
 <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3XRoAI8MhBahLgql"
Content-Disposition: inline
In-Reply-To: <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
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


--3XRoAI8MhBahLgql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 02:32:26AM +0200, Heinrich Schuchardt wrote:
> On 9/13/25 01:02, Tom Rini wrote:
> > This converts the existing README.commands.spl file to rST as
> > doc/usage/cmd/spl.rst and adds it to the command index. Minimal
> > rewording is done to the previous contents, to make it fit better with
> > the overall style of documentation now.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/README.commands.spl | 31 --------------------------
> >   doc/usage/cmd/spl.rst   | 48 +++++++++++++++++++++++++++++++++++++++++
> >   doc/usage/index.rst     |  1 +
> >   3 files changed, 49 insertions(+), 31 deletions(-)
> >   delete mode 100644 doc/README.commands.spl
> >   create mode 100644 doc/usage/cmd/spl.rst
> >=20
> > diff --git a/doc/README.commands.spl b/doc/README.commands.spl
> > deleted file mode 100644
> > index ecfd3ca9ee58..000000000000
> > --- a/doc/README.commands.spl
> > +++ /dev/null
> > @@ -1,31 +0,0 @@
> > -The spl command is used to export a boot parameter image to RAM. Later
> > -it may implement more functions connected to the SPL.
> > -
> > -SUBCOMMAND EXPORT
> > -To execute the command everything has to be in place as if bootm shoul=
d be
> > -used. (kernel image, initrd-image, fdt-image etc.)
> > -
> > -export has two subcommands:
> > -	atags: exports the ATAGS
> > -	fdt: exports the FDT
> > -
> > -Call is:
> > -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> > -
> > -
> > -TYPICAL CALL
> > -
> > -on OMAP3:
> > -nandecc hw
> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
> > -spl export atags			/* export ATAGS */
> > -nand erase 0x680000 0x20000		/* erase - one page */
> > -nand write 0x80000100 0x680000 0x20000	/* write the image - one page */
> > -
> > -call with FDT:
> > -nandecc hw
> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
> > -tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
> > -spl export fdt 0x82000000 - 0x80000100	/* export FDT */
> > -nand erase 0x680000 0x20000		/* erase - one page */
> > -nand write <adress shown by spl export> 0x680000 0x20000
> > diff --git a/doc/usage/cmd/spl.rst b/doc/usage/cmd/spl.rst
> > new file mode 100644
> > index 000000000000..59471c65a623
> > --- /dev/null
> > +++ b/doc/usage/cmd/spl.rst
> > @@ -0,0 +1,48 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
>=20
> %s/GPL-2.0+/GPL-2.0-OR-LATER/
>=20
> Cf. https://spdx.org/licenses/GPL-2.0-or-later.html

Yes, and it's not a hard requirement to use the new tag, checkpatch.pl
doesn't even complain. I got this from the existing command I copied,
FWIW.

>=20
> > +
> > +.. index::
> > +   single: spl (command)
> > +
> > +spl command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Synopsis
> > +--------
> > +
> > +::
> > +
> > +    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fd=
t]
>=20
> Those brackets cannot be correct. I definitively cannot remove the
> kernel_addr and provide an initrd_addr instead. Do you mean:
>=20
> spl export <fdt|atags> [kernel_addr [initrd_addr [fdt_addr if fdt]]]

It's what the command itself says currently, however.

I'd be happy to do a follow-up patch to fix both.

> > +
> > +Description
> > +-----------
> > +
> > +The *spl* command is used to export a boot parameter image to RAM. Lat=
er
>=20
> In the current state the man-page is not very helpful. Please, move the m=
ore
> extensive description from doc/develop/falcon.rst here.

As I said in the commit message, it's a conversion with minimal changes.
I'd be happy to do a follow-up however improving it (and making
cmd/spl.c's help text also better/correct).

> * I would not know what a "boot parameter image" might be. Please, explain
> it for a novice user.
> * Please, describe what each parameter is used for.
> * Please, explain what atags refers to. I would assume you mean what is
> described in https://developer.arm.com/documentation/den0013/0400/Boot-Co=
de/Booting-Linux/Kernel-parameters-using-ATAGs.
> But don't expect a novice user to know.
> * What does the command do if "fdt" is used?
>=20
> > +it may implement more functions connected to the SPL.
> > +
> > +spl export
> > +~~~~~~~~~~
>=20
> This heading makes no sense.

I just copied doc/usage/cmd/acpi.rst for format as it's the first file.
I'd be happy to look at a better example.

> > +To execute the command everything has to be in place as if bootm shoul=
d be
>=20
> Bootm can for instance boot a FIT image with an EFI binary.
> I wouldn't expect this to work when booting in Falcon mode where EFI is n=
ot
> available.
>=20
> This sentence should be replaced by a meaningful description.

I don't understand what's unclear, sorry. And yes, Falcon mode and EFI
aren't compatible, but that should be spelled out in
doc/develop/falcon.rst and not here I think.

>=20
> > +used. (kernel image, initrd-image, fdt-image if used). The first argum=
ent
> > +passed to the export subcommand must be either atags or fdt, which sig=
nifies if
>=20
> %s/signifies/indicates/
>=20
> > +we are preparing an ATAGS or device tree for export.
>=20
> Isn't ATAGs the plural form of ATAG?

The most consistent usage is "ATAGS" and not "ATAGs".

> Why would you write 'an ATAGS' if there are multiple tags?
>=20
> Please, describe under which circumstances and with which values these
> environment variables are filled and what they are used for.
>=20
> * fdtargsaddr
> * fdtargslen

These are covered in doc/develop/falcon.rst which should be linked from
this document I think.

> > +
> > +Example
> > +-------
> > +
> > +On an OMAP3 platform with ATAGS::
> > +
> > +    =3D> nandecc hw
> > +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image f=
rom NAND*/
>=20
> What format must the image have to be used for booting? A FIT image?
>=20
> > +    =3D> spl export atags			/* export ATAGS */
>=20
> Is spl export atags never used with kernel_addr, initrd_addr, fdt_addr?
>=20
> Does `spl export atags` without further arguments create any ATAGs?
> Where would it take the values from?

Working with ATAGS was indeed "fun". I'd honestly rather follow-up and
remove ATAGS support from Falcon mode since it's 2025 and not 2012, but
the point of this patch is to move doc/README.* content to rST so that
we can then go "oof, that needs work" and try and improve it.

> > +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
> > +    =3D> nand write 0x80000100 0x680000 0x20000	/* write the image - o=
ne page */
>=20
> What is written to nand here?
> What relevance have these magic addresses?
> How would a user know which address to use?

More of the magic of ATAGS, which we can be glad aren't relevant
anymore. It's always at that magic 0x100 offset. And the "on OMAP3" is
the key to decoding the rest.

> > +On an OMAP3 platform with device tree::
> > +
> > +    =3D> nandecc hw
> > +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image f=
rom NAND*/
> > +    =3D> tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
> > +    =3D> spl export fdt 0x82000000 - 0x80000100	/* export FDT */
>=20
> Why would anybody use a device-tree from a TFTP server in conjunction wit=
h a
> kernel from nand?

It was the example at the time. But, because there's not a device tree
on NAND, that's what spl export is creating.

>=20
> > +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
> > +    =3D> nand write <adress shown by spl export> 0x680000 0x20000
>=20
> The address seems to be gd->bd->bi_boot_params which is hard coded in boa=
rd
> files and not visible to the user. This is just gruesome. The address sho=
uld
> be exported to a variable to be usable in scripts.

Preparing a board for falcon mode isn't a general task, you need to know
what your platform is and where things are because you're about to make
it a lot less flexible.

> Which customizing is needed to use the spl command? These settings seem to
> be relevant and should be described in sufficient detail:
>=20
> CONFIG_CMD_SPL
> CONFIG_OF_LIBFDT
> CONFIG_CMD_SPL_WRITE_SIZE
> CONFIG_SUPPORT_PASSING_ATAGS
> CONFIG_SYS_BOOT_RAMDISK_HIGH

Some of these I suspect so, yes.

> Which return values does the command provide?

Only the standard ones. A quick grep on "on success" in doc/usage/cmd
says we aren't consistent about this phrasing nor inclusion to start
with. I think we should update the "General rules" section of
doc/usage/cmdline.rst to state that "The return value $? is 0 (true) on
success and 1 (false) on failure unless otherwise noted.".

--=20
Tom

--3XRoAI8MhBahLgql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMWLLAAKCRAr4qD1Cr/k
CpMTAP0bW173gx53bnWyiomXLi+nfKRp735wsEwtLRgj05csPwD/ZLtlvuRCak1J
4RMdKE/Jd3JwnMoIVJEjEMl2yZ4Y5A0=
=n5eF
-----END PGP SIGNATURE-----

--3XRoAI8MhBahLgql--
