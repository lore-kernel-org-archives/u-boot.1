Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D05BD18157
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 00:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECAE891DE;
	Tue, 15 Oct 2024 02:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dTCwyeSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29AC0891E1; Tue, 15 Oct 2024 02:03:00 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAE0389179
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7afc847094fso377946285a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728950576; x=1729555376; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nd2MZ+qM/wdBKtwDG5zrXYhLXIOFltJdWOKAA6dzPJ4=;
 b=dTCwyeSDKrnxqOQRCvEyu1abY+ywDBKflMqgbXI0pHEnd3jPg/mbKlQAo1DaSLoPHX
 9O/BiGrr8rGv+fW/4Izj8IGfP4XhdaNyWe83XvLwRVyBTX+BiHCH/8oXSDF4M9dS1Fh0
 Q9AtBKHKSlASqOpkaNei3Vxe76KIEmerMKKw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728950576; x=1729555376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd2MZ+qM/wdBKtwDG5zrXYhLXIOFltJdWOKAA6dzPJ4=;
 b=cDaWWs4Fe9INTMLkUxxWF2bFitsKXsCRxCy/1zzuRB8+2fT4hZIV+fQ1vhqjjjGOmP
 dr7ShlVRY+xuGFoQny0q2uSakvegf0BIgzSMhzEvh0akZbs5o6odUO74p98GfYR4gtwg
 oqVRYsEdrm2dc0u57z9D8uIVbJShV+N3AMP2sYJJdpXcgMUxnYAmOiM6wFY5344y0EhI
 HEvlH82lYw5tKHees/w/YMKzmPZY+jGcOpYI7/k1Lo9XJPXG7seesiv7KgXH86u79vAy
 h+rgOgLDtBRalr0/XcvxOon3m40Tf8icbIq/NGmS8eh3xPjAafwC2U8Z8RUYbKN6/yUz
 oZpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1QNj5oopCxd8XYgF2Q+AKnB6jd7ACw7xArsnzFfSTLBAGcb1GKUT0tXNLa9/HObGj1PnYVvc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc1/4zNOTc5+nwms0g/WL8aKab3WEqeN3RyZE3rSTY70+dpZb1
 NMehQwrIdAlnrNIUb9dgTMHP7f8t2bSoLi9CHvqkPlnLgSiBz/XZSe/Wh18tHXY=
X-Google-Smtp-Source: AGHT+IFwekDyP6zCU1k7XrubuD8PgIh3iVvFs7wrYvu+aOyQ8mkbG6U5bLO2hzmkum47tnXWdaMyxA==
X-Received: by 2002:a05:620a:2987:b0:7a9:bb25:d495 with SMTP id
 af79cd13be357-7b11a3a77f6mr2096149585a.50.1728950576443; 
 Mon, 14 Oct 2024 17:02:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363ca30csm6932185a.131.2024.10.14.17.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 17:02:54 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:02:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Judith Mendez <jm@ti.com>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] TI: include: env: ti_common: move fdtoverlay_addr_r to
 fix ramdisk size
Message-ID: <20241015000250.GI53053@bill-the-cat>
References: <20241011000322.538287-1-jm@ti.com> <87zfnafy2e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Us1rhtY0FopA2VAA"
Content-Disposition: inline
In-Reply-To: <87zfnafy2e.fsf@baylibre.com>
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


--Us1rhtY0FopA2VAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 05:39:53PM +0200, Mattijs Korpershoek wrote:
> Hi Judith,
>=20
> Thank you for sending this patch.
>=20
> On jeu., oct. 10, 2024 at 19:03, Judith Mendez <jm@ti.com> wrote:
>=20
> > From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >
> > When booting Android with adtbo_idx set, we observe the
> > following crash:
>=20
> In upstream/master, this is no such thing as adtbo_idx.
>=20
> This is only present in TI's U-Boot fork, via commit [1]
>=20
> [1] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-202=
4.04&id=3D1c6cf852b8b8f869d2c5e39eb071ec3025bf739a
>=20
> >
> >    ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
> >    ## Booting Android Image at 0x82000000 ...
> >    Kernel load addr 0x92000000 size 20195 KiB
> >    Kernel extra command line: console=3DttyS2,115200 cma=3D768M 8250.
> > 	nr_uarts=3D10 printk.devkmsg=3Don init=3D/init quiet firmware_class.
> > 	path=3D/vendor/firmware mem_sleep_default=3Ddeep bootconfig
> >    RAM disk load addr 0x88080000 size 16901 KiB
> >    "Synchronous Abort" handler, esr 0x96000005, far 0x155b104c8
> >    elr: 0000000080808560 lr : 0000000080808558 (reloc)
> >    elr: 00000000ffebf560 lr : 00000000ffebf558
> >    x0 : 00000000fff99000 x1 : 00000000fff9553c
> >    x2 : 000000000000000a x3 : 0000000002800000
> >    x4 : 0000000002800000 x5 : 0000000000000020
> >
> > This happens because the memory at fdtoverlay_addr_r is bogus.
> > In fact:
> >
> > =3D> printenv fdtoverlay_addr_r
> > fdtoverlay_addr_r=3D0x89000000
> >
> > And the ramdisk address range is:
> > [0x88080000; 0x88080000 + 16901 KiB]
> >
> > Which is equal to:
> > [0x88080000; 0x89101400]
> >
> > So, if we represent the addresses:
> > fdtaddr             0x88000000
> > ramdisk             0x88080000
> > fdtoverlay_addr_r   0x89000000
> > ramisk (end)        0x89101400
> >
> > We see that fdtoverlay_addr_r in fact has been overridden by
> > the Android ramdisk.
> >
> > The maximum ramdisk size is 0x1080000 (15,5 MiB) and a compressed
> > Android vendor ramdisk is 15MiB:
> > $ file vendor_ramdisk.img
> > vendor_ramdisk.img: LZ4 compressed data (v0.1-v0.9)
> > $ du -sh vendor_ramdisk.img
> > 15M     vendor_ramdisk.img
> >
> > When it gets decompressed, it uses 16.5MiB, exceeding the
> > maximum ramdisk size.
> >
> > Increase the maximum ramdisk size to 20.5MiB by moving
> > fdtoverlay_addr_r higher up in the address space to fix the crash.
>=20
> I do think that reserving more room between the fdtoverlay_addr_r and
> the ramdisk address is probably a good idea for Linux as well, but I
> think that the commit message might need a rewrite ?

Sorry for the slow reply here. This is I think a case where someone
needs to step back and think about all of the addresses again, and how
much gap should be between areas, along with just how big some areas can
grow to be. There should be some upper reasonable bound on overlays, and
it will be safer long term I believe to have that above the device tree
and below the ramdisk. Placing things above the ramdisk always results
in pain as there's always some new larger image for some valid use case.

--=20
Tom

--Us1rhtY0FopA2VAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNsSIACgkQFHw5/5Y0
tywzZwv4sRd/IvGWk4lqwxQ1+wI8AhjS/vOFjuH/es77q9iTluPjKjQQFM064/Hm
4GSyCDJt2+YF5Cak3JfR/G2s+zdiOwwNXO7yqM6l3qxS5W7Iy3zO4oMsxRCNoL1f
DCjN5HQzU5kwgmUzpgsCkjhfdl6Ee8jkgzBadNUjot2CWVvZBXQMG56ck6fQrMJq
KJQc1Y6beHopbd6t69/44bIn8rGT8zk6XwyFF1VuEtgeKBBsMww3eG47IV7/HAuo
DTsV5PTyZZZzcmZ2dNsqM69MC8KJ4SHNXFl/yv1QwEikM0Crd5mxK1V5CL18j+l+
bNPiHBefLuNKzZMVcBejFFoVa8ngD1IsyUoxdTrZbFsTcKTM8eV0lg+x/iX7eh+7
moKrU+GSMS4+P3pGbLHbK5HYcLOQcj0MDtnF5uiqBJWBZxGC10z5ogtYDdRztHbf
i/x5H2FKdv/h57I7fTb6CHCvhAxwU4f0/Wz841K/CNKs3w4ZwvWF4J+qvJTo31Dt
7PSY9BM=
=yx8F
-----END PGP SIGNATURE-----

--Us1rhtY0FopA2VAA--
