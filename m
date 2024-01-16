Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D4C47DA2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4063A87977;
	Tue, 16 Jan 2024 17:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPL3Dw1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D392186F80; Tue, 16 Jan 2024 17:08:27 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D874A86A26
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337bad75860so500566f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705421305; x=1706026105; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UcgnrNgImjMumC2WLIFN7EpejgLQvupcmktb7zZUzE=;
 b=XPL3Dw1Xgu+BEI8/pVzs3OAGgoklNZ5gTED6GIj1CbQkFxd23zgoEUprTOzgN/MjmD
 lso0WyZ6bUR8DEQ4f1JRSrACf0U98KxP8sz+1HBvugfTYHE/3LrAnkuLx2NCP8GTZubs
 zhwwsUDKb2Yg4EjvIqcps2cWnL7fRGih+Qq3xym1osf9KhSCrehMYjJGSShIwF3Jqn7h
 snm8cKhUP/EVNSIpPmEDJyU8AmTeuHKn3n9byNGtWnF2F/N1JqDTR7/1HHyQANbQJGy4
 apmSThy1iq2ayNN25WLzy5SdvdyBrLpViqotQ2PkoWHrOVjk94H3MR/tLdr00a95XD5i
 Xffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421305; x=1706026105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UcgnrNgImjMumC2WLIFN7EpejgLQvupcmktb7zZUzE=;
 b=pi8qIq9ZktIAPEMda4f8rzKnWcG4S70pcx/gtAePDQwaqdE5ghnvJAJm3R1Gt0dEdp
 lEvvJ60j464TjPTGVanE/jH5WFsSaeiV128lO0nUdKj7T/qockX60DY+8h1Kd8fY1+uV
 eCjW8dxGT9uWZQ7KL1ctYSnkoCNOSP8rO9Soj4FcAvR5cWCIESWRpASJigJUwxNdv1ap
 o103xldPOKhv4yhVSi+3giI+0d0f/8VHeeS8kmZ4Q6klxB9A9vWy/hjm3R5KBID7oNMl
 82O3PRPfFRcucYKmJHr/JO4N1llnXnsh8w64k5JS2MwI/2sgx1JhMHiSyhYhE3xRjLbu
 gm4w==
X-Gm-Message-State: AOJu0Yw9RcohiCg3VjscYioFCgsAeWBbfzmhL73p2lwjk0F7eJWXUBGW
 QfhQyyN8AhxemwJleX9FkHDj4DfQZkB3K457o2o=
X-Google-Smtp-Source: AGHT+IGLxgXc3AzpEeWUvsJSV/YV6ZCYz8WG3OXuQFhf4PJVFtuWCo5wwGKFXxns3k0P+bgYhAUEsd16iheh6cF57e0=
X-Received: by 2002:a5d:6188:0:b0:337:bf4b:f6ef with SMTP id
 j8-20020a5d6188000000b00337bf4bf6efmr325850wru.108.1705421304970; Tue, 16 Jan
 2024 08:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20240114180741.2114-1-seashell11234455@gmail.com>
 <20240114180741.2114-4-seashell11234455@gmail.com>
 <fd037cd9-176f-49e3-bb78-9cc54371ed26@gmx.de>
In-Reply-To: <fd037cd9-176f-49e3-bb78-9cc54371ed26@gmx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Wed, 17 Jan 2024 00:08:11 +0800
Message-ID: <CAOKwTdokAd51aCSr4-r05U10MLOdSEYmnwZxwEXz9Kz47DfUmA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tim Harvey <tharvey@gateworks.com>,
 Wei Fu <wefu@redhat.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yannic Moog <y.moog@phytec.de>, 
 Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jan 2024 17:47:14 +0100
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

Heinrich Schuchardt <xypron.glpk@gmx.de> =E4=BA=8E2024=E5=B9=B41=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=80 05:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On 1/14/24 19:07, Kongyang Liu wrote:
> > Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >   doc/board/index.rst            |  1 +
> >   doc/board/sophgo/index.rst     |  8 ++++++
> >   doc/board/sophgo/milkv_duo.rst | 50 +++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 59 insertions(+)
> >   create mode 100644 doc/board/sophgo/index.rst
> >   create mode 100644 doc/board/sophgo/milkv_duo.rst
> >
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index 531e547e7e..a0bd534742 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -45,6 +45,7 @@ Board-specific doc
> >      sifive/index
> >      sipeed/index
> >      socionext/index
> > +   sophgo/index
> >      st/index
> >      starfive/index
> >      ste/index
> > diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> > new file mode 100644
> > index 0000000000..e097afdac6
> > --- /dev/null
> > +++ b/doc/board/sophgo/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Sophgo
> > +=3D=3D=3D=3D=3D=3D
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   milkv_duo
> > diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_du=
o.rst
> > new file mode 100644
> > index 0000000000..b63304b510
> > --- /dev/null
> > +++ b/doc/board/sophgo/milkv_duo.rst
> > @@ -0,0 +1,50 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +Milk-V Duo
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +CV1800B RISC-V SoC
> > +------------------
> > +The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC fro=
m Sophgo.
> > +
> > +Mainline support
> > +----------------
> > +The support for following drivers are already enabled:
> > +1. ns16550 UART Driver.
> > +
> > +Building
> > +~~~~~~~~
> > +1. Add the RISC-V toolchain to your PATH.
> > +2. Setup ARCH & cross compilation environment variable:
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> > +   cd <U-Boot-dir>
> > +   make milkv_duo_defconfig
> > +   make
> > +
> > +This will generate u-boot-dtb.bin
> > +
> > +Booting
> > +~~~~~~~
> > +Currently, we rely on vendor FSBL(First Stage Boot Loader) to initiali=
ze the
> > +clock and load the u-boot image, then bootup from it.
>
> Thank you for providing documentation for the board.
>
> Could you please, additionally describe the procedure to run
> u-boot-dtb.bin on top of FSBL.
>
I'd like to clarify your request for describing the procedure to run
u-boot-dtb.bin on top of FSBL. Are you looking for a detailed, step-by-step
guide to replicate the process and successfully run u-boot-dtb.bin, or
would you prefer a more concise overview?

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
> > +
> > +Sample boot log from Milk-V Duo board
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: none
> > +
> > +   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)=
milkv_duo
> > +
> > +   DRAM:  63.3 MiB
> > +   Core:  10 devices, 8 uclasses, devicetree: separate
> > +   Loading Environment from nowhere... OK
> > +   In:    serial@4140000
> > +   Out:   serial@4140000
> > +   Err:   serial@4140000
> > +   Net:   No ethernet found.
> > +   milkv_duo# cpu detail
> > +     0: cpu@0      rv64imafdc
> > +      ID =3D 0, freq =3D 0 Hz: L1 cache, MMU
> > +   milkv_duo#
>
