Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5464AC3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B70880F9;
	Sun, 14 Jul 2024 17:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqSEdjYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC90288360; Sun, 14 Jul 2024 17:53:50 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5608780A
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367a464e200so2077525f8f.2
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720972428; x=1721577228; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MllrgsadJlQWbPtOK2PIMctHZjps/ZTicAKVaNbH+zo=;
 b=dqSEdjYZegZLl1FB9uHkv3CjG1VyDY5xj17dnAVKR2evIvV24npd+QFyE846vUfzcZ
 8NCytR6jmXg76dl3DNHH4FY4v8MwD0r0I36sol8Ay8p/TvRxFmvCBt1lOEQ7QAF99K1I
 u/LnGDl0x0wQ19Pz9E25IGavBSNbOY3KiSgaAClVhAUcgLVsoJStvvqCA/RH+mm103Nr
 Xsc6Uf6V4GbyQBBukQvZSskXMRi6md2vEr6Hu2LtOBo0Bgmh5+CsPgNuPGqnWhPbzmFx
 C5vhZWfNnYHdVVQEGkux0O2cyYdYjYUKCLjXsBtQM+IeuyANix5vunDzyZwHu/n8baDD
 2MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720972428; x=1721577228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MllrgsadJlQWbPtOK2PIMctHZjps/ZTicAKVaNbH+zo=;
 b=N9LhdIRCqXqMl/S1bP0Ud77J/Dd1wNA2BhD6YCFJe94V+6FLtbROjnmDY85kHW5MX+
 IZhuZsJHueLCdFEfRmh9qNbAKN/6yrZejNnvjM4gIqp7Hd7fkXiAs2OGOhehAxITcHJr
 XpsuO3b07DwkERoMV0klZ0qogpjWLmmUDjoTynaBLJma2VwhMDbHJmMzPGpKB1PHxuTt
 R8IixPoOjUpkj8nK6rc52C0o9oZ68pSprDAIsW/H6nW/rpzDrhUZFwWGz3BXb4HApjWl
 IF7rIqG5yTvmoljBR+mOhzVnXACu6Y7G4zAr0agwdVFIAMlO3KZaLbOUqd2x9mDRO6Kr
 ru/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG6RBuy/QJGB4Yk1TPiYkwsvnCqbFGvfqT8/oYO/C5q8eTYboVRWfYMNXL8BXNuYYwQm9wnjReLekiPYhal92B/nLT5w==
X-Gm-Message-State: AOJu0YxQMffN0Lq8JkhrO2/e3/gvvgPDohmAJ16d6K5wzc72I21Rdysv
 k+feOJtltQBU3D3FxOixHoWsGNdB9WLEP9u+S9wTq4Oo8bFwsvQ48IvR7yJyWfndl4pkVOKjw23
 TOwHWNa2fnJyv7jk++nhuXHk844k=
X-Google-Smtp-Source: AGHT+IGCJnHwqNrJQpcRrDjGhZFRW6CHhjOjX6sbkfr6MjirJoEYpF1p0J6YyIfOItmzM1xxSCNaRdZcUZc79/COcmA=
X-Received: by 2002:a5d:4288:0:b0:367:9387:e48f with SMTP id
 ffacd0b85a97d-367cead91fbmr9573558f8f.66.1720972427447; Sun, 14 Jul 2024
 08:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240714150828.736-1-seashell11234455@gmail.com>
 <20240714150828.736-3-seashell11234455@gmail.com>
 <50e8f905-5845-4faa-9e75-8d7ea1051a74@gmx.de>
In-Reply-To: <50e8f905-5845-4faa-9e75-8d7ea1051a74@gmx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Sun, 14 Jul 2024 23:53:35 +0800
Message-ID: <CAOKwTdoAQzPf3+-4ONJeNv35rRpJ=sBHynnR18-Ukj5J=i47KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Heinrich Schuchardt <xypron.glpk@gmx.de> =E4=BA=8E2024=E5=B9=B47=E6=9C=8814=
=E6=97=A5=E5=91=A8=E6=97=A5 23:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/14/24 17:08, Kongyang Liu wrote:
> > Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >
> >   doc/board/index.rst                |  1 +
> >   doc/board/spacemit/bananapi_f3.rst | 78 +++++++++++++++++++++++++++++=
+
> >   doc/board/spacemit/index.rst       |  8 +++
> >   3 files changed, 87 insertions(+)
> >   create mode 100644 doc/board/spacemit/bananapi_f3.rst
> >   create mode 100644 doc/board/spacemit/index.rst
> >
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index 417c128c7a..367da2d623 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -51,6 +51,7 @@ Board-specific doc
> >      sipeed/index
> >      socionext/index
> >      sophgo/index
> > +   spacemit/index
> >      st/index
> >      starfive/index
> >      ste/index
> > diff --git a/doc/board/spacemit/bananapi_f3.rst b/doc/board/spacemit/ba=
nanapi_f3.rst
> > new file mode 100644
> > index 0000000000..465040b94f
> > --- /dev/null
> > +++ b/doc/board/spacemit/bananapi_f3.rst
> > @@ -0,0 +1,78 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Banana Pi F3
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +About This
> > +----------
> > +Banana Pi F3 board is a industrial grade RISC-V development board, it
> > +design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> > +computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x =
USB
> > +3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> > +
> > +Building
> > +~~~~~~~~
> > +1. Add the RISC-V toolchain to your PATH.
> > +2. Setup ARCH & cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> > +
> > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can =
be
> > +built for SpacemiT K1 SoC as below:
> > +
> > +.. code-block:: console
> > +
> > +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> > +   cd opensbi
> > +   make PLATFORM=3Dgeneric
> > +
> > +4. Then build U-Boot as following:
> > +
> > +.. code-block:: console
> > +
> > +   cd <U-Boot-dir>
> > +   make bananapi_f3_defconfig
> > +   make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmware/fw_dyn=
amic.bin
> > +
> > +This will generate u-boot.itb
>
> Thanks a lot for the board documentation.
>
> Could you, please, describe how to install the u-boot.itb.
>
> To where should it be copied?
> Does it need to be signed to be accepted by the vendor SPL?
>

In the vendor's U-Boot SPL, OpenSBI and U-Boot are loaded separately. From
my observation, U-Boot seems to prefer loading a FIT image that includes
both OpenSBI and U-Boot. Therefore, I modified this part to allow them to
be loaded together. The modified code might be somewhat messy because I
just made it work.

As a result, it is currently difficult to describe how to boot into
U-Boot. Perhaps I can improve the documentation after U-Boot SPL is
available for Banana Pi F3.

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
> > +
> > +Booting
> > +~~~~~~~
> > +Currently, we use a modified vendor's U-Boot SPL to load a FIT image t=
hat
> > +includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot =
is a
> > +challenging task. And the booting method will be added after the SPL
> > +support is available.
> > +
> > +Sample boot log from Banana Pi F3 board
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: none
> > +
> > +   U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 +0800)
> > +
> > +   DRAM:  4 GiB
> > +   Core:  18 devices, 7 uclasses, devicetree: separate
> > +   Loading Environment from nowhere... OK
> > +   In:    serial@d4017000
> > +   Out:   serial@d4017000
> > +   Err:   serial@d4017000
> > +   Net:   No ethernet found.
> > +   bananapi_f3# cpu detail
> > +     0: cpu@0      spacemit,x60
> > +      ID =3D 0, freq =3D 0 Hz: MMU
> > +     1: cpu@1      spacemit,x60
> > +      ID =3D 1, freq =3D 0 Hz: MMU
> > +     2: cpu@2      spacemit,x60
> > +      ID =3D 2, freq =3D 0 Hz: MMU
> > +     3: cpu@3      spacemit,x60
> > +      ID =3D 3, freq =3D 0 Hz: MMU
> > +     4: cpu@4      spacemit,x60
> > +      ID =3D 4, freq =3D 0 Hz: MMU
> > +     5: cpu@5      spacemit,x60
> > +      ID =3D 5, freq =3D 0 Hz: MMU
> > +     6: cpu@6      spacemit,x60
> > +      ID =3D 6, freq =3D 0 Hz: MMU
> > +     7: cpu@7      spacemit,x60
> > +      ID =3D 7, freq =3D 0 Hz: MMU
> > +   bananapi_f3#
> > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rs=
t
> > new file mode 100644
> > index 0000000000..cc2bd6ab0a
> > --- /dev/null
> > +++ b/doc/board/spacemit/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +SpacemiT
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   bananapi_f3
>
