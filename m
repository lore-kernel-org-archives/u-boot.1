Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38676C7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 01:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF9A82CCE;
	Sat, 21 Jun 2025 03:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LejnQ1oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A860182CF4; Sat, 21 Jun 2025 03:37:03 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8039B82AA4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 03:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60ef850d590so640559eaf.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750469819; x=1751074619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GtjHn4PQzYZmB1OXdN5pOTKE5l34BuOikv5XoELNmfQ=;
 b=LejnQ1oYl+vq6a8p/qlyqDIq77iz+IwUau170yKejGqwLmhgRH9l/9JUiM5d9cwcA2
 AvhOxnSS41VSjGWe4eR9rLO7o9XuzJlJUxl4CbymDGdgPZPnIR02ojZRnB6A+zqY2kqy
 Lf2VVfXwHhjGmJckRc08+i/IUBL5IyT9r4yhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750469819; x=1751074619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtjHn4PQzYZmB1OXdN5pOTKE5l34BuOikv5XoELNmfQ=;
 b=Jv+qNMAHFyViJW0CCXOSUPDbaloVRfogLFgV9N9THTnB8RugnFTG27yFig+4gghPQK
 p/tyOex77cQbPJAlq5IzTWtMqN97dL8AufjM3Yr+A8PNOx/Axdu0LgYcvGwQi14nR+km
 iqn6DDPkArJus54soQFQGcShBpoFvMDXPE2Te1eM3C9Cx6leiJUyuaJuvc1k4QrIJHrD
 3T8vZFEdhBWJI5XUe2QQsX/dZ0lH8iY9P0/Qaz08c3yxsErw0VD+wc451wQtLGCEKNFs
 RvCFKE9g9rZqxm/mG1ZbmT5xCmSBK4vmtRYmPVX4Ck+vl1nOtP/82VcwM9ht6xNNdma/
 hOdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3OT67VTIYjGHw/EcfYvw0dUs8JsDjxn+joJ61h8JP6HZ2SXtvUPgiadgDZdUUIqmoJoyB1Lc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc2khSFc3XqfVVJJGblG7nj9F9qNhXK4J9/1O4XqJ5wwoPcAyW
 GGzU5KRKPJ5j2lIzO+7+Jh0c7M1cZETPOhhcPDoZ1rt6p6pzzWE1TYFQ8V5cGz0SPlg=
X-Gm-Gg: ASbGnctIU/idZAXEtt3O37P/+RB/VikWgE7dsqC+XFcyn2p8TqAMtBtBclZ4uA6op4O
 eIqbn6dHaKzLyYmN6COPHCTDiqVaSDAfFu84jU/xvfyXgZs5RIG/kGBYItbRdrQjZ21isJ+CVGi
 BxKEHRclNb9mgLUWM26tgSIjQFaxQzR1NVO9nd2XCZ0t/z2GZKzma7GBstkAXht3JS0cGy9DHLJ
 QRFa7EA1t9U/t+CkVznFWuBvIKpSTFrY1P68Uogd68sEUTNnp7UP2mdgMAA8kp5CDo8u+nHQt4s
 qssDHSsZDtI5XxRcNC9eYM61Fw0S+q6b4zLmerc+t6R+NyHJh8Re7ohwNahawHvBhqPDO8UY2CF
 slpBIVvhHnNKSFkD+28y96Lk=
X-Google-Smtp-Source: AGHT+IFWN/CMRp8J2PXFp+ZzCnKdtrqxYk2cKqHNGfidYNaly0hXpnzwKH+He5WkcntGUV9T2eVJqA==
X-Received: by 2002:a05:6870:ac0e:b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2eeda4bb996mr3597286fac.1.1750469819103; 
 Fri, 20 Jun 2025 18:36:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee664c467dsm632313fac.4.2025.06.20.18.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 18:36:58 -0700 (PDT)
Date: Fri, 20 Jun 2025 19:36:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
Message-ID: <20250621013656.GP216500@bill-the-cat>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
 <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
 <CAJaLiFwW_=GZcyS8qEyCepkYyHsGs-3hOiS6ubNbN=2=WC9ReA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lhgb8m1iImdk4VZN"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwW_=GZcyS8qEyCepkYyHsGs-3hOiS6ubNbN=2=WC9ReA@mail.gmail.com>
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


--lhgb8m1iImdk4VZN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:21:59PM -0700, Tony Dinh wrote:
> Hi Jerome,
>=20
> On Fri, Jun 20, 2025 at 4:03=E2=80=AFAM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > On 6/20/25 12:53, Jerome Forissier wrote:
> > > Hi Tony,
> > >
> > > On 6/19/25 22:37, Tony Dinh wrote:
> > >> Hi Jerome,
> > >>
> > >> While fixing some ext4 file system problems on 2025.07-rc4, I ran in=
to
> > >> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
> > >> image,
> > >> and then u-boot execution was frozen without anything going to the
> > >> serial console. I did a bisect and found the commit that caused it.
> > >>
> > >> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc0=
2b8a75c1940
> > >>
> > >> When I tried to reverse this commit, I had a build error like this
> > >> "{standard input}:24246: Error: selected processor does not support
> > >> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
> > >>
> > >> Currently, the only way to boot Kirkwood boards is to disable either
> > >> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
> > >>
> > >> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
> > >> know if I can help with testing to troubleshoot this regression.
> > >>
> > >> All the best,
> > >> Tony
> > >
> > > The problem seems to be that some arm32 instructions are inlined
> > > inside thumb code and that's not allowed on this CPU without some
> > > interworking instruction (bx, blx etc.). For example, consider
> > > board_init_r(), is is mainly 16-bit instructions (Thumb):
> > >
> > > 006186a0 <board_init_r>:
> > > board_init_r():
> > > /home/jerome/work/u-boot/common/board_r.c:799
> > >   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
> > >   6186a2:       b0ab            sub     sp, #172        @ 0xac
> > > get_gd():
> > > /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
> > >   6186a4:       464a            mov     r2, r9
> > > ...
> > >
> > > but then suddenly:
> > >
> > > /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
> > >   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> > > writefr_extra_feature_reg():
> > > /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
> > >   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
> > >                 ^^^^^^^^
> > >                 32-bit arm instruction
> > >
> > > I would expect some call to a *_from_thumb() veneer, such as in:
> > >
> > > 006009dc <do_bootm_qnxelf>:
> > > [...]
> > > /home/jerome/work/u-boot/boot/bootm_os.c:379
> > >   600a02:       9501            str     r5, [sp, #4]
> > > /home/jerome/work/u-boot/boot/bootm_os.c:384
> > >   600a04:       f04a fc7c       bl      64b300 <__dcache_status_from_=
thumb>
> > >
> > >
> > > 0064b130 <__dcache_enable_from_thumb>:
> > > __dcache_enable_from_thumb():
> > >   64b130:       4778            bx      pc
> > >   64b132:       e7fd            b.n     64b130 <__dcache_enable_from_=
thumb>
> > >   64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__d=
cache_enable_from_thumb+0xc>
> > >   64b138:       e08cf00f        add     pc, ip, pc
> > >   64b13c:       fffffb28        .word   0xfffffb28
> > >
> > > We may need to move the inline functions with mrc/mcr to a .S file,
> > > making sure it's built with -marm on CPUs that do not support Thumb2.
> > > Then hopefully the proper interworking sequence would be inserted by =
the
> > > linker as is the case when Thumb is calling into object files resulti=
ng
> > > from .c files built with -marm (for example: arch/arm/mach-kirkwood/c=
pu.c
> > > which has CFLAGS_cpu.o :=3D -marm).
> > >
> > > In the meantime, could you try the following patch?
> > >
> > > diff --git a/common/Makefile b/common/Makefile
> > > index 35991562a12..a509675335a 100644
> > > --- a/common/Makefile
> > > +++ b/common/Makefile
> > > @@ -19,6 +19,8 @@ obj-y +=3D version.o
> > >  # # boards
> > >  obj-y +=3D board_f.o
> > >  obj-y +=3D board_r.o
> > > +CFLAGS_board_f.o +=3D -marm
> > > +CFLAGS_board_r.o +=3D -marm
> > >  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
> > >  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> > >
> > > I think it should resolve the issue, but is does also increase the
> > > size of the binary (+4 KiB). So the .S solution would definitely be
> > > better if it works IMO. I'll try to propose something ASAP, will
> > > likely be on Monday, feel free to give it a try by yourself though :)
> >
> > Or maybe this which is a bit less radical:
> >
> > diff --git a/common/Makefile b/common/Makefile
> > index 35991562a12..f0b7eadf7d2 100644
> > --- a/common/Makefile
> > +++ b/common/Makefile
> > @@ -19,6 +19,8 @@ obj-y +=3D version.o
> >  # # boards
> >  obj-y +=3D board_f.o
> >  obj-y +=3D board_r.o
> > +CFLAGS_REMOVE_board_f.o :=3D $(LTO_CFLAGS)
> > +CFLAGS_REMOVE_board_r.o :=3D $(LTO_CFLAGS)
> >  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
> >  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> >
> > Still results in +1 KiB.
>=20
> The above patch works great! I've tested it on 3 Kirkwood boards: the
> Pogo V4 (88F6192), Zyxel NSA325 (88F6282), and GoFlex Home (88F6281,
> same SoC as the Sheevaplug).
>=20
> The Sheevaplug is now 498K, which is well under limit. All these
> boards see only 1K increase in binary size.

Can we please get a patch of the latter option now for the release and
look at doing the .S file for the future? Thanks!

--=20
Tom

--lhgb8m1iImdk4VZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhWDLgACgkQFHw5/5Y0
tyx8CAv/Y3rb8ZyFXrpIXaSw8CXCRf3aPcgHUHd4mb5q+1wkEeAmgkvPFct7NdvP
bONs+R6hGR0gkELPQIQXyqJdVNhLgWAyxfbu0734vrkjelXG74m1xhnao2NELdpb
h7rUwvq8KuX4OHyWeHA3x4MWYqt/IElxT8CfKUB41167l0nATtlt8wgAVPmcLmzC
+y50PoCyH1+mEPf7T1eZLj0//CMClhmH87w+VWK35k5IRJGmkA7ecYLRsYWKGlzb
DVyNKHEMpMOZpQS/2InIhRgrTbS29X9yPdP9gcv20JTQMpFj6kBWvdYi5dK5rGV0
lWtEeAq3VjV6gDpUroSVumk6FbQyO5+we5DbDj5Gjo8f5DNwTxRQ8v56lS47VtEM
UCnmdZHbOyKop4FzZpLbkoRBtlb6T80g1YwpWffmgQ7jsaTbPGARLp3o+TYiDk7q
SI3xAmBKLvywrWg2gf99j6MChWUr3TZMl0hgOxenEMjVihkLPn9GfdyYrKfbFXZt
QtHOXNRb
=W6OE
-----END PGP SIGNATURE-----

--lhgb8m1iImdk4VZN--
