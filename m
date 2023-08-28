Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94B6C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEB086507;
	Tue, 29 Aug 2023 00:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CX7S1S60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2E186482; Tue, 29 Aug 2023 00:10:08 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0758864D9
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d7838958d17so3227582276.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693260597; x=1693865397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Pfjk8bwVxfKsh7t6ZyC6RlB9GIn6BEmw7EWSYr0Au0=;
 b=CX7S1S60uMLPxeEyNT7vT8dXKZ8j0ILJulPWdkOaIP+TOHsPskmLKidkBPPEmc2mgh
 mNQ+qQJwM9k+GRXcyq0+07wAqvLor+rWFJriYSG5/JOXqbyWAluB1hxXB9AHT5ZlohIN
 1/xc1gtoMXn18buC4k18/jz3C7H/NazZNYHMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260597; x=1693865397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Pfjk8bwVxfKsh7t6ZyC6RlB9GIn6BEmw7EWSYr0Au0=;
 b=PJmxyQn+O4WNwIcNIsTHsOjdoAeT3w4ylp71hqr4f6qzW1M0E62jD+AUqx4Y3UUo0v
 7V5mtIx6nhUxFL3L6qHOHutxcgdZC3kzXjE1wBMypste99lRwwZuFDDZMqtVYgYYPau9
 8tg/S+Pc9tQnRD/pqFR0KXNaJdcHAtv2gXyFxlMADJICk0XZj3Fs0I1Q+0tgXxzfDcg1
 FkwrT2id/bNE/1NJgN63YW3Z9YuapW5/GxsZReA42se6KALCLNTXsMkAE68T/6cG7UzP
 KmUIFAUoiARuV2J99qvX1bbgLZkX5lzuxmTP0oHQKvPz0YKiRgKAE5UwjxpvP4geclsz
 Wtrg==
X-Gm-Message-State: AOJu0YwNh2x1UEcUywjNJrLQA3NP917vJ+quUo7cDuaSjf4QK0DlVNVo
 b/kKbxKpaHPxdWILYVgvhNsojuBS+GnSHDG1Nqn9gg==
X-Google-Smtp-Source: AGHT+IGN+ZWFSIaU8V2SUPTo7im63VQlXZb4x6gUui/2q0snyyyv8/CGIQ+EBPY3eZFGEPsvzGIYjJK7j6ZLo9h7PRg=
X-Received: by 2002:a25:8502:0:b0:d4e:3ffe:79d4 with SMTP id
 w2-20020a258502000000b00d4e3ffe79d4mr26066407ybk.61.1693260597155; Mon, 28
 Aug 2023 15:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
 <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
 <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
 <CALeDE9OafhEwznXY5K4YZeMezuZRo5D1Gb57DDxFzPEufcHEfw@mail.gmail.com>
In-Reply-To: <CALeDE9OafhEwznXY5K4YZeMezuZRo5D1Gb57DDxFzPEufcHEfw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 16:09:34 -0600
Message-ID: <CAPnjgZ2TvK=RAD=f9JG4qJHnfjDh0_n7N3JQich_juZ2qisHQQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 rfried.dev@gmail.com, 
 peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com, 
 dsankouski@gmail.com, stephan@gerhold.net, vinod.koul@linaro.org, 
 nicolas.dechesne@linaro.org, mworsfold@impinj.com, daniel.thompson@linaro.org
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

Hi Peter,

On Mon, 28 Aug 2023 at 14:24, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, Aug 28, 2023 at 6:55=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Sumit,
> >
> > On Thu, 24 Aug 2023 at 04:44, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > > >
> > > > > Add support for 96Boards Dragonboard 845C aka Robotics RB3 develo=
pment
> > > > > platform. This board complies with 96Boards Open Platform Specifi=
cations.
> > > > >
> > > > > Features:
> > > > > - Qualcomm Snapdragon SDA845 SoC
> > > > > - 4GiB RAM
> > > > > - 64GiB UFS drive
> > > > >
> > > > > U-boot is chain loaded by ABL in 64-bit mode as part of boot.img.
> > > > > For detailed build and boot instructions, refer to
> > > > > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > > > > ---
> > > > >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> > > > >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> > > > >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> > > > >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> > > > >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> > > > >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> > > > >  board/qualcomm/dragonboard845c/db845c.its     |  63 +++++++++++
> > > > >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> > > > >  configs/dragonboard845c_defconfig             |  28 +++++
> > > > >  doc/board/qualcomm/sdm845.rst                 | 100 ++++++++++++=
+++---
> > > > >  include/configs/dragonboard845c.h             |  28 +++++
> > > > >  11 files changed, 337 insertions(+), 13 deletions(-)
> > > > >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> > > > >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> > > > >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> > > > >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
> > > > >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> > > > >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> > > > >  create mode 100644 board/qualcomm/dragonboard845c/dragonboard845=
c.c
> > > > >  create mode 100644 configs/dragonboard845c_defconfig
> > > > >  create mode 100644 include/configs/dragonboard845c.h
> > > > >
> > > > [..]
> > > >
> > > > > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/s=
dm845.rst
> > > > > index b6642c9579..8ef4749287 100644
> > > > > --- a/doc/board/qualcomm/sdm845.rst
> > > > > +++ b/doc/board/qualcomm/sdm845.rst
> > > > > @@ -35,9 +35,25 @@ Pack android boot image
> > > > >  ^^^^^^^^^^^^^^^^^^^^^^^
> > > > >  We'll assemble android boot image with ``u-boot.bin`` instead of=
 linux kernel,
> > > > >  and FIT image instead of ``initramfs``. Android bootloader expec=
t gzipped kernel
> > > > > -with appended dtb, so let's mimic linux to satisfy stock bootloa=
der:
> > > > > +with appended dtb, so let's mimic linux to satisfy stock bootloa=
der.
> > > > >
> > > >
> > > > [..]
> > > >
> > > > > +The dragonboard845c is a Qualcomm Robotics RB3 Development Platf=
orm, based on
> > > > > +the Qualcomm SDM845 SoC.
> > > > > +
> > > > > +Steps:
> > > > > +
> > > > > +- Build u-boot::
> > > > > +
> > > > > +       $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > > > > +       $ make dragonboard845c_defconfig
> > > > > +       $ make
> > > > > +
> > > > > +- Create dummy dtb::
> > > > > +
> > > > > +       workdir=3D/tmp/prepare_payload
> > > > > +       mkdir -p "$workdir"
> > > > > +       mock_dtb=3D"$workdir"/payload_mock.dtb
> > > > > +
> > > > > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > > > > +       /dts-v1/;
> > > > > +       / {
> > > > > +               #address-cells =3D <2>;
> > > > > +               #size-cells =3D <2>;
> > > > > +
> > > > > +               memory@80000000 {
> > > > > +                       device_type =3D "memory";
> > > > > +                       /* We expect the bootloader to fill in th=
e size */
> > > > > +                       reg =3D <0 0x80000000 0 0>;
> > > > > +               };
> > > > > +
> > > > > +               chosen { };
> > > > > +       };
> > > > > +       EOF
> > > > > +
> > > > > +- gzip u-boot::
> > > > > +
> > > > > +       gzip u-boot.bin
> > > > > +
> > > > > +- Append dtb to gzipped u-boot::
> > > > > +
> > > > > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > > > > +
> > > > > +- A ``db845c.its`` file can be found in ``board/qualcomm/dragonb=
oard845c/``
> > > > > +  directory. It expects a folder as ``db845c_imgs/`` in the main=
 directory
> > > > > +  containing pre-built kernel, dts and ramdisk images. See ``db8=
45c.its``
> > > > > +  for full path to images::
> > > > > +
> > > > > +       mkimage -f db845c.its db845c.itb
> > > > > +
> > > > > +- Now we've got everything to build android boot image::
> > > > > +
> > > > > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb=
 \
> > > > > +       --output boot.img --pagesize 4096 --base 0x80000000
> > > > > +
> > > > > +- Flash boot.img using db845c fastboot method.
> > > >
> > > > What command should be used here? I can run 'fastboot devices' but =
am
> > > > not sure what command to use to flash U-Boot.
> > > >
> > >
> > > At the time of writing this doc, I thought it was understood how to
> > > flash boot.img on db845c. But I will make that more explicit. Since
> > > u-boot has to be chain loaded by ABL, the command to flash boot.img
> > > (containing u-boot) is as follows:
> > >
> > > sudo fastboot flash boot boot.img
> > >
> > > > Also, is it possible to flash U-Boot as a first-stage bootloader?
> > > >
> > >
> > > That's not possible currently due to Qcom proprietary bootloader bein=
g
> > > used. But there were plans to replace atleast ABL with u-boot (See
> > > slide 9 from this Linaro connect Qcom keynote [1]). I hope that will
> > > materialize soon.
> > >
> > > [1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJyA
> > >
> >
> > Thank you for the link. I am pleased to hear it and hope it plays out
> > as that slide seems to indicate.
> >
> > I would like to suggest that 96 boards should use open-source firmware
> > when they launch. Once they launch there is little incentive to clean
> > things up.
>
> It's something that has been suggested from the outset but the fact is
> there is no way to enforce it.

Er, the board is listed on Linaros web site and has presumably been
blessed by Linaro. So don't bless it until the patches are send and/or
landed?

Regards,
Simon
