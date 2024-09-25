Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6831CCF9E8
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3760F88C53;
	Wed, 25 Sep 2024 19:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f77Y77My";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C72288B11; Wed, 25 Sep 2024 19:26:05 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6523388BB6
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so69336eaf.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285158; x=1727889958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NT1slpdwzT6idwjCh0bgnBxlN2oVbyz+WWdWSRmgjMo=;
 b=f77Y77MyRnh5i5bpmjCou6K9KahayIx0Y9venaOjaspl8iNVggFpwDe9TNSSmKl4Zm
 gWuffQSsaT2vJQ9t8ubR3IeThLFjVPCIPM0l+lo3LejUY7Zz9EcBIt2Tkb/7hlook13A
 Y8YrF8Zze4lxEfWL17fTvo15E9kJ5kHkNU+2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285158; x=1727889958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NT1slpdwzT6idwjCh0bgnBxlN2oVbyz+WWdWSRmgjMo=;
 b=wI6/xAKpoa3yhEnT79HP13Sia2xuYqSIFp/KxbtlJqvv4X3tdwq1uyJXoiGPfStMI5
 +AtkDjPwkNXeKZ23VDqZBTI5iFdACc/3AZ8Ex6ZahvnLWuimN9KLDL2b0uUcN0Q/ktE7
 bWcOGbH1I1YxtsXLAymHC0wqFuczFaYocCnDB9y2j0RKTna1vYAYUlxuLXkyc5L3Q5Mw
 QKvccHfqJ7CkLSoGWIj/z13zZoRkn9bL0Xv1ueg/9PFX1RkXwqgUNgxqEPD8XWOzGj2Z
 16//MyAfccaJIFKI4fZHrXpHDW0c+wxXbRNJJMU3NbUwQkYEHCDss4euinoQrhLpyugC
 MQeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUnZDnrxC+c6xGaCVgy93vXb2KEGf0JyWhVp7eGV0CIMnYAm+V5Ogk+i/pHKak7JpX0Hk8Tfo=@lists.denx.de
X-Gm-Message-State: AOJu0YwvpfiRlpcuaFCwGjeeloS5LF1gOWaKumCBQArrKyOEWX3zMHu1
 Nc4ZkYW5RaovGgfwCWVOU9TkVyf2aV+GhMB2ylr63YkK6eczqGDHaWYP9yqKo6Y=
X-Google-Smtp-Source: AGHT+IHftOGjOo+7O3pDv8HZbJxY/yJcQOD8jDI8wrluGuYy9tVHBHnk3wBP2kefBsuR5RPP8DWlug==
X-Received: by 2002:a05:6358:8a0:b0:1bc:2f31:ec1a with SMTP id
 e5c5f4694b2df-1bea8579b91mr213870955d.4.1727285158007; 
 Wed, 25 Sep 2024 10:25:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb0f76a139sm18150086d6.118.2024.09.25.10.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:25:57 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:25:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexander Dahl <ada@thorsis.com>, Heiko Schocher <hs@denx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] doc: Move the generic memory-documentation to doc/
Message-ID: <20240925172553.GZ4252@bill-the-cat>
References: <20240919151424.57663-1-sjg@chromium.org>
 <7969171f-e3e2-4492-8eda-b2cba7376dcb@gmx.de>
 <CAFLszTgFXw1ZNHZj08AWntseeiHmW81ND8Ze0Wy3neRWeXgMVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SrGi5B1bGE8xrKs3"
Content-Disposition: inline
In-Reply-To: <CAFLszTgFXw1ZNHZj08AWntseeiHmW81ND8Ze0Wy3neRWeXgMVQ@mail.gmail.com>
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


--SrGi5B1bGE8xrKs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:50:45PM +0200, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sun, 22 Sept 2024 at 11:02, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >
> > On 9/19/24 17:14, Simon Glass wrote:
> > > Move this section of the README into doc/ with some minor updates to
> > > mention SPL and user lower-case hex.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   README                 | 45 ---------------------------------------=
---
> > >   doc/develop/index.rst  |  1 +
> > >   doc/develop/memory.rst | 45 +++++++++++++++++++++++++++++++++++++++=
+++
> > >   3 files changed, 46 insertions(+), 45 deletions(-)
> > >   create mode 100644 doc/develop/memory.rst
> > >
> > > diff --git a/README b/README
> > > index 4be1e8c22a0..d73042406b6 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
> > >
> > >       =3D=3D> U-Boot will use gp to hold a pointer to the global data
> > >
> > > -Memory Management:
> > > -------------------
> > > -
> > > -U-Boot runs in system state and uses physical addresses, i.e. the
> > > -MMU is not used either for address mapping nor for memory protection.
> > > -
> > > -The available memory is mapped to fixed addresses using the memory
> > > -controller. In this process, a contiguous block is formed for each
> > > -memory type (Flash, SDRAM, SRAM), even when it consists of several
> > > -physical memory banks.
> > > -
> > > -U-Boot is installed in the first 128 kB of the first Flash bank (on
> > > -TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
> > > -booting and sizing and initializing DRAM, the code relocates itself
> > > -to the upper end of DRAM. Immediately below the U-Boot code some
> > > -memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> > > -configuration setting]. Below that, a structure with global Board
> > > -Info data is placed, followed by the stack (growing downward).
> > > -
> > > -Additionally, some exception handler code is copied to the low 8 kB
> > > -of DRAM (0x00000000 ... 0x00001FFF).
> > > -
> > > -So a typical memory configuration with 16 MB of DRAM could look like
> > > -this:
> > > -
> > > -     0x0000 0000     Exception Vector code
> > > -           :
> > > -     0x0000 1FFF
> > > -     0x0000 2000     Free for Application Use
> > > -           :
> > > -           :
> > > -
> > > -           :
> > > -           :
> > > -     0x00FB FF20     Monitor Stack (Growing downward)
> > > -     0x00FB FFAC     Board Info Data and permanent copy of global da=
ta
> > > -     0x00FC 0000     Malloc Arena
> > > -           :
> > > -     0x00FD FFFF
> > > -     0x00FE 0000     RAM Copy of Monitor Code
> > > -     ...             eventually: LCD or video framebuffer
> > > -     ...             eventually: pRAM (Protected RAM - unchanged by =
reset)
> > > -     0x00FF FFFF     [End of RAM]
> > > -
> > > -
> > >   System Initialization:
> > >   ----------------------
> > >
> > > diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> > > index 0d0e60ab56c..cbea38d4323 100644
> > > --- a/doc/develop/index.rst
> > > +++ b/doc/develop/index.rst
> > > @@ -13,6 +13,7 @@ General
> > >      codingstyle
> > >      designprinciples
> > >      docstyle
> > > +   memory
> > >      patman
> > >      process
> > >      release_cycle
> > > diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> > > new file mode 100644
> > > index 00000000000..fa1ae5e97ed
> > > --- /dev/null
> > > +++ b/doc/develop/memory.rst
> > > @@ -0,0 +1,45 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+:
> > > +
> > > +Memory Management
> > > +-----------------
> > > +
> > > +U-Boot runs in system state and uses physical addresses, i.e. the
> > > +MMU is not used either for address mapping nor for memory protection.
> >
> > Hello Simon,
> >
> > Thanks for getting the description moved.
> >
> > The text that you are copying dates back to 2004 when U-Boot was
> > focusing on the Power architecture. It needs some rework.
> >
> > On RISC-V there is a physical memory protection (PMP) which is typically
> > set up to guard against overwriting OpenSBI sitting at the lower end of=
 RAM.
> >
> > There is some ongoing work to implement NX protection via the MMU for A=
RM.
> >
> > > +
> > > +The available memory is mapped to fixed addresses using the
> > > +memory-controller. In this process, a contiguous block is formed for=
 each
> > > +memory type (Flash, SDRAM, SRAM), even when it consists of several
> > > +physical-memory banks.
> >
> > Can we simply say DRAM instead of SDRAM. We always refer to DRAM below.
> > Whether the RAM frequency is synchronous or not is irrelevant here.
> >
> > > +
> > > +U-Boot is installed in XIP flash memory, or may be loaded into a low=
er region of
> > > +RAM by a secondary program loader (SPL). After
> >
> > This does not describe U-Boot SPL as being a part of U-Boot.
> >
> > > +booting and sizing and initialising DRAM, the code relocates itself
> >
> > Initialization of DRAM can be done in code running before U-Boot.
> >
> > > +to the upper end of DRAM. Immediately below the U-Boot code some
> >  > +memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN>
> > +configuration setting]. Below that, a structure with global Board-Info
> > > +data is placed, followed by the stack (growing downward).
> > > +
> > > +Additionally, some exception handler code may be copied to the low 8=
 kB
> > > +of DRAM (0x00000000 ... 0x00001fff).
> >
> > The exception handler code for RISC-V and ARMv8 is typically not located
> > at 0x0.
> >
> > On RISC-V stvec, the Supervisor Trap Vector Base Address Register,
> > defines where the exception vectors are located in S-Mode.
> >
> > On ARMv8 VBAR_EL2, the Vector Base Address Register (EL2), sets the
> > location of the EL2 vector base.
>=20
> I don't believe we need to get into the weeds on this description. It
> is just setting some guiding principles. Yes, every architecture is
> different, but people can see the general idea.
>=20
> Perhaps we should add details about each architecture at the end, i.e.
> provide a link to an arch-specific page which provides more
> information?

Perhaps we should start by moving this content out of the top-level
README and note at the start in the new document that the information is
outdated and needs to be updated.

--=20
Tom

--SrGi5B1bGE8xrKs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R6EACgkQFHw5/5Y0
tyxANgwAlyNEhYkNcHaIgMRr6PEKTK2WhAIZ3u2rcRkcc5CADmaOfR28jvCRsPm2
YIryAHPuw+AtUAEvO03C4RpXtQibIYEXzR5nAN+5i91Z9oIzxdvnIkpB2Uyx2Lf/
wOSz2eHTtcRozr7NxXwtyM/GXX3g+oRKN3NK9bNj4PwwhuZ1BJv/c6co4L1Rtowj
9fnuoh/NwgICHhcKhgpU9j2pko6Kn8gbB5XJm8b3/eEv1rS/6WbagKcqmmsyOUzx
X79V2HPIDbGvrqG22BtIKcVViEW2WNtPmsxo/zKFpuxQxO+nVVwoDj4uEB2ulC2j
jhlccs2EYorfldG3QKwb32O4ql+CVekKc+RMpDCnSAkFB97cb2W7+8/J73GQC7KD
p7N9YBDCTSBvaTD65TggtyFz6wkqfIwmCeHiful+akdYjg/yzq3AYZKieXkNMiMS
TuzRhvs2oa5AutjrHBofaK5rW9fvejFnSOizTzecO4zeVv810uyNrp4Qo9pZIBAd
jnW8Loee
=Qxdd
-----END PGP SIGNATURE-----

--SrGi5B1bGE8xrKs3--
