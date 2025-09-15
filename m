Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC86CAC598
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 17:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2ADB830B4;
	Mon, 15 Sep 2025 19:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jjr0L4cH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBC58318E; Mon, 15 Sep 2025 19:42:37 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D9A802C1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 19:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7459d088020so2169640a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757958154; x=1758562954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I+/oZocbYf9n0sBrXgzPbdILxkO93SyUX3fp3J+eDMo=;
 b=jjr0L4cHGap9wtrJ1yMBdcOGqwQI9Duh7/+6mO73WpFNyFnmN8Qv1WmN1FRkvObS4J
 2bZ4JwvRxerXQ0X92LSln9IlhWTxxQSPkb6QXI+Nq2mQCGPP2q+Ru+/lqA6CfyEZjvz1
 f3eBXpqnjMPR7ufXIDiSnpbNePBC/yBbZzmfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757958154; x=1758562954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+/oZocbYf9n0sBrXgzPbdILxkO93SyUX3fp3J+eDMo=;
 b=v0o6N4uTDDdMo/V9fR8FbOwDcgRPQYPS54HBgwZFRvvYc6AuaH4fcECP9bfGLR0GXY
 w33DwUf8+7PRGSHiLZpDK25PClWS9dNvOfYqmGrHWlNHy97ijpfd1VjuZU9P+3s6i1if
 LfxXVIbA3Ed2kE10LuF+ubYXdPsjAgF1E0SSX6NoALnIIQlEeP8LUaua60fxDdC3kgUv
 jYKcJWCMPA57UziX5YwXsJAmtN2ygWsiCxTTx8fo4AK+/vay2RsRSkVKxV7YtXBcjEFQ
 GWpY7Pp4rLMZL9oqtNvVtugfKKFANDNGv3uj0+qH0lDmCgRkrb0tfd2PnLUhcD1MOIFF
 VBkg==
X-Gm-Message-State: AOJu0Yy7uE3iPOmjPmkguEo/BWhXVBNyawmwKDpW2JidjDQoLrET9M2G
 tmSOPnnUGw454kIrZjsXnuRR1g73In9xD+EoMmWqHBVZLfqMg3Q6N7NTw6vB8C+Jd9RgyEhMqwq
 01tM9P7M=
X-Gm-Gg: ASbGncuEppJpw7kR7u0Ye6uDdoXBQ/ZQ40SeyU3XrEDFATmeWfblajYmjMQZIp7Jv2N
 9cN3O6vCwrdS8YUYXqzCvikd+Yncj7xtEJhbvKIF29tyKpjByas7PgHvt/DCOmRzsC4GeAS1VhV
 OJCR9relLFhKV2vfIRC5IqkzfnCCelyZZi+OChI4+/PZPmMhb8kQ8MQ44C476fxyZUHGrLwdjW6
 089PmXZTMQUjXsJl5tOKM6nDVLwAC/N3rGXis/yiYz99fKBZ4TO1hP/y3yttx3k8FxRI+WJ91dI
 y2ibYUPUL3Q2i8LzFlMIR67V42hqtLPQVkvrZs62onL6nnzPbusyy8+JKkzBbfLXHlIsf+XiFjB
 9pXkj48TgdDXDmKZnyUhGL++LJH7mRxoKuwASiy2OyFXFQ9UaZ9PMGgobfi9tmrOjlho=
X-Google-Smtp-Source: AGHT+IEDo7n2lUFhnrF0xDOsDcNfAcU75oI3s2zrA1OFq4GKI6cA2Ali3f/iQZ82BFKRZHLsgFyXgQ==
X-Received: by 2002:a05:6830:258f:b0:746:d955:4803 with SMTP id
 46e09a7af769-75355abf4a2mr6329068a34.24.1757958153961; 
 Mon, 15 Sep 2025 10:42:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7d74121sm1329390eaf.23.2025.09.15.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 10:42:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:42:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Convert README.commands.spl to rST
Message-ID: <20250915174231.GM124814@bill-the-cat>
References: <20250912230257.4145026-1-trini@konsulko.com>
 <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
 <20250913151807.GE124814@bill-the-cat>
 <8581B186-2D03-4905-81CC-1AECC3E5C1B2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3sZg5kzEzhi4cTDu"
Content-Disposition: inline
In-Reply-To: <8581B186-2D03-4905-81CC-1AECC3E5C1B2@gmx.de>
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


--3sZg5kzEzhi4cTDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 06:49:46PM +0200, Heinrich Schuchardt wrote:
> Am 13. September 2025 17:18:07 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sat, Sep 13, 2025 at 02:32:26AM +0200, Heinrich Schuchardt wrote:
> >> On 9/13/25 01:02, Tom Rini wrote:
> >> > This converts the existing README.commands.spl file to rST as
> >> > doc/usage/cmd/spl.rst and adds it to the command index. Minimal
> >> > rewording is done to the previous contents, to make it fit better wi=
th
> >> > the overall style of documentation now.
> >> >=20
> >> > Signed-off-by: Tom Rini <trini@konsulko.com>
> >> > ---
> >> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> > ---
> >> >   doc/README.commands.spl | 31 --------------------------
> >> >   doc/usage/cmd/spl.rst   | 48 +++++++++++++++++++++++++++++++++++++=
++++
> >> >   doc/usage/index.rst     |  1 +
> >> >   3 files changed, 49 insertions(+), 31 deletions(-)
> >> >   delete mode 100644 doc/README.commands.spl
> >> >   create mode 100644 doc/usage/cmd/spl.rst
> >> >=20
> >> > diff --git a/doc/README.commands.spl b/doc/README.commands.spl
> >> > deleted file mode 100644
> >> > index ecfd3ca9ee58..000000000000
> >> > --- a/doc/README.commands.spl
> >> > +++ /dev/null
> >> > @@ -1,31 +0,0 @@
> >> > -The spl command is used to export a boot parameter image to RAM. La=
ter
> >> > -it may implement more functions connected to the SPL.
> >> > -
> >> > -SUBCOMMAND EXPORT
> >> > -To execute the command everything has to be in place as if bootm sh=
ould be
> >> > -used. (kernel image, initrd-image, fdt-image etc.)
> >> > -
> >> > -export has two subcommands:
> >> > -	atags: exports the ATAGS
> >> > -	fdt: exports the FDT
> >> > -
> >> > -Call is:
> >> > -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> >> > -
> >> > -
> >> > -TYPICAL CALL
> >> > -
> >> > -on OMAP3:
> >> > -nandecc hw
> >> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NA=
ND*/
> >> > -spl export atags			/* export ATAGS */
> >> > -nand erase 0x680000 0x20000		/* erase - one page */
> >> > -nand write 0x80000100 0x680000 0x20000	/* write the image - one pag=
e */
> >> > -
> >> > -call with FDT:
> >> > -nandecc hw
> >> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NA=
ND*/
> >> > -tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
> >> > -spl export fdt 0x82000000 - 0x80000100	/* export FDT */
> >> > -nand erase 0x680000 0x20000		/* erase - one page */
> >> > -nand write <adress shown by spl export> 0x680000 0x20000
> >> > diff --git a/doc/usage/cmd/spl.rst b/doc/usage/cmd/spl.rst
> >> > new file mode 100644
> >> > index 000000000000..59471c65a623
> >> > --- /dev/null
> >> > +++ b/doc/usage/cmd/spl.rst
> >> > @@ -0,0 +1,48 @@
> >> > +.. SPDX-License-Identifier: GPL-2.0+:
> >>=20
> >> %s/GPL-2.0+/GPL-2.0-OR-LATER/
> >>=20
> >> Cf. https://spdx.org/licenses/GPL-2.0-or-later.html
> >
> >Yes, and it's not a hard requirement to use the new tag, checkpatch.pl
> >doesn't even complain. I got this from the existing command I copied,
> >FWIW.
> >
> >>=20
> >> > +
> >> > +.. index::
> >> > +   single: spl (command)
> >> > +
> >> > +spl command
> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > +
> >> > +Synopsis
> >> > +--------
> >> > +
> >> > +::
> >> > +
> >> > +    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if=
 fdt]
> >>=20
> >> Those brackets cannot be correct. I definitively cannot remove the
> >> kernel_addr and provide an initrd_addr instead. Do you mean:
> >>=20
> >> spl export <fdt|atags> [kernel_addr [initrd_addr [fdt_addr if fdt]]]
> >
> >It's what the command itself says currently, however.
> >
> >I'd be happy to do a follow-up patch to fix both.
>=20
> I am fine with the current patch if you supply the follow up. =20

OK. But I also think that based on some of your questions, the first
step is to just rip out ATAGS from here. We have zero cases in tree of
ATAGS and SPL_OS_BOOT support, and this is an extremely legacy case.
Deleting that will make things a bit clearer overall. The next part is
that yes, two sentences doesn't explain what's going on here well if you
don't already know what's going on here.

--=20
Tom

--3sZg5kzEzhi4cTDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMhQBAAKCRAr4qD1Cr/k
CoBHAQCbVITkaGvhugK33nqBHX4jgPLl2DirW1ZGHwY3JHyo1wEAgHtK69ny/dsL
yKl/GK0gD91kgNi/+mAWlJ5q7yo2SgA=
=UsaJ
-----END PGP SIGNATURE-----

--3sZg5kzEzhi4cTDu--
