Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2755FC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E455B87EE9;
	Sun, 28 Jan 2024 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ntMqpJbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5086687D65; Sun, 28 Jan 2024 15:09:58 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C9B87D8E
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 15:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ae5e7d787so884194f8f.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706450994; x=1707055794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN2y7OK0g4OdphcZeVBsRi2Mu70cnfA/vqRgZlyhbh4=;
 b=ntMqpJbR/dq0LVrr9l/Vgb0p+UApat7jQybb9+3iKicRIKgfL+SzRDNWcQHGKTAOrm
 8kiAe0PmDlOXAVrtM7lcpfJ0ulBRzrOPycMAA6QFHA2+Dddwgn675P1mpDrMrCfrN8tJ
 xUtbhGw6mHCsYyw2sXlZiUCqYj20vxCNhWxjS1pvHzuUDlYqp47J98njCFgduBwoGWd7
 DdGTrCGE5F9k/4dqedNQ0hpXaFcLDSPJ5UnnOPRxmM0xu1Gh3Hbtg/ji/AgVu+++OlMQ
 Jt2dwOd3BIfIZDYoEpO6YGwnSaBS53+SDpEanJRm2B7ylhdOMcnOwJpHPpfH6MIcxKB9
 Tymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706450994; x=1707055794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN2y7OK0g4OdphcZeVBsRi2Mu70cnfA/vqRgZlyhbh4=;
 b=k8bB/YV8HWLSZOTPAuFSrtxPktGQgtMaDn7n+us3xRBCXfcxSftKZsqFs0W/m7eTvD
 iyksLbP7bNxHInuIG6AFlnyrHTWpDp86RvvTi5UtoKfSJs7eRrvt+s/lYqDtyGI9BgzP
 WV92YXOw7hrDedpWEb6YESQA36nTM1xxcXCL6qAxB8IYhClZGbbzICe/CXK/LLvoMcn+
 QZu2mZxU220WfPT6bK1Zm/N8WUJOjjHumpRyiSBcQ1K2cMDaGhefdw/SIOVxO+Ymygxc
 QC+yNSbqKmQJDc6iEHqxOhnpdY3IwQ5obNcxefEA2+IUpVzR4qbPyK7yt7gAWrDHMTDY
 2ovg==
X-Gm-Message-State: AOJu0YyB9kUjfBgJs8/tR90oT1+gz4x5ge86e6JHGMmsHJUPwUxkRxZW
 +CC1dNZtpEv0AAYAV+FtmnUugF0ft7OwIG69mfAoiqFMOVvJAjjcK3hgoswHUo52PeXcsAf8xkR
 zJnVH3ayxWgdz4hZKYixKuoggb58=
X-Google-Smtp-Source: AGHT+IGEVkv9Ar5ffh5mcqv7s4ujxzfxpg3kW/R7o8n2CZr9NUm2JibQbCsSdDH92tOanMgL7T2auZoKiGW0W67tl1s=
X-Received: by 2002:a5d:6ac5:0:b0:33a:ec25:60b3 with SMTP id
 u5-20020a5d6ac5000000b0033aec2560b3mr815263wrw.68.1706450993735; Sun, 28 Jan
 2024 06:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-4-seashell11234455@gmail.com>
 <2acf8505-315e-486d-a07d-c91fddfe6671@gmx.de>
In-Reply-To: <2acf8505-315e-486d-a07d-c91fddfe6671@gmx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Sun, 28 Jan 2024 22:09:43 +0800
Message-ID: <CAOKwTdoDyOGK9bV-jP=RczotQW2gderVqw0ru3CpQ=+80=Whzw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] doc: sophgo: milkv_duo: document Milk-V Duo board
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adam Ford <aford173@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
 Fabio Estevam <festevam@denx.de>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yannic Moog <y.moog@phytec.de>, 
 Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 28 Jan 2024 15:10:42 +0100
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

Heinrich Schuchardt <xypron.glpk@gmx.de> =E4=BA=8E2024=E5=B9=B41=E6=9C=8828=
=E6=97=A5=E5=91=A8=E6=97=A5 17:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On 1/28/24 08:05, Kongyang Liu wrote:
> > Add document for Milk-V Duo board which based on Sophgo's CV1800B SoC.
> >
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> >
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Add brief description of the procedure to run u-boot-dtb.bin
> >
> >   doc/board/index.rst            |  1 +
> >   doc/board/sophgo/index.rst     |  8 +++++
> >   doc/board/sophgo/milkv_duo.rst | 64 +++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 73 insertions(+)
> >   create mode 100644 doc/board/sophgo/index.rst
> >   create mode 100644 doc/board/sophgo/milkv_duo.rst
> >
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index c96e5fda28..d0f9f355d2 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -46,6 +46,7 @@ Board-specific doc
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
> > index 0000000000..cb2ed1ad98
> > --- /dev/null
> > +++ b/doc/board/sophgo/milkv_duo.rst
> > @@ -0,0 +1,64 @@
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
> > +
> > +Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these step=
s:
> > +
> > +1. Use the vendor-provided tool to create a unified fip.bin file conta=
ining
> > +   FSBL, OpenSBI, and U-Boot.
>
> Hello Kongyang,
>
> thank you for providing a documentation for the board.
>
> Concerning the usage of fip.bin it would be helpful to add more detail:
>
> * From where can the vendor code be downloaded?
> * Which are the commands to execute?
>

We have leveraged the BuildSDK from the Milk-V Duo project
(https://github.com/milkv-duo/duo-buildroot-sdk) and made slight modificati=
ons
to ensure compatibility with the mainline OpenSBI and U-Boot. After the
repository reaches a stable state, we will publish it on GitHub.

Best regards
Kongyang Liu

> Best regards
>
> Heinrich
>
> > +
> > +2. Place the generated fip.bin file into the FAT partition of the SD c=
ard.
> > +
> > +3. Insert the SD card into the board and power it on.
> > +
> > +The board will automatically execute the FSBL from the fip.bin file.
> > +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will=
 invoke
> > +U-Boot.
> > +
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
