Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E4C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 10:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EB1864E8;
	Tue, 29 Aug 2023 12:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bE3IJimW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD678864E9; Tue, 29 Aug 2023 12:24:46 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14157864C7
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-79a2216a2d1so1510737241.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693304682; x=1693909482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ekNllEYvkw5i3hu4e5r/VXxZx5BCff6hOwGAIGz1Rw=;
 b=bE3IJimWcFkuO0R+aDhL7HubqsWRO+hT7vk//QN7toHBqIdRA8JGeIKWn8dxCLqj/V
 0pViUaN55NOZ08/0fUI6CtQMbuEFXnl8ojC5X4OXbG/4DAF3xhkHtqbbJspK6bewFEqT
 cbhBKG26OAAToEM1TFcxFEIm43GXuipnWVjhbZNKGxspjzUu+1MhsQTtk6lofQYCnaWk
 ctGFIqzExevyYSD3cTAoWiPk/A8T+5C11KslMorpM/XviO5yiszStrO4Oui2wkr6gU+s
 4pPJhM1Qme0Ovwu4P8Uq4uGUpFlx+Dj89mOjvu3Q4rG9yRI/L4UfUqFVa6iz7h7ucrUB
 Poow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693304682; x=1693909482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ekNllEYvkw5i3hu4e5r/VXxZx5BCff6hOwGAIGz1Rw=;
 b=EDxBKLZF1h2s4zJHo3RHA24m6Ll3nUu+6S8CUnlZahQ19VqHlPlqGZY5WVyiTxjznw
 TLvcZmOa+NN8Nx/pxDj3bOBKu6yOjn8fOuOarDH8I0Nj3luXyfFEY93bwZsZcUW0h+cu
 idbm59xrJ4FEKvMV2jGwYf52LRInOLsSNfkYJGqVegMSZ6ZXNWn/Gf+o+qjEg0dBDwhA
 7PZ1E/Sd+Xgk4GQrqCHTBCV1Z04JvsB4WKk4/x+Ncm511on7xMzGcE8kEhtXpabZSZDq
 IzE7aPzASSF5LWVkdeKCSlS93tvu0/u00/rmXIhJn6XSqSggw4MVL6v/hlgVw3oRqTA1
 wyrA==
X-Gm-Message-State: AOJu0YyCkLphC/3SoEzLBFVTC8/ZYgwwhd8yRoU7u5WLUTOjgyE/UfS/
 1GW8fAG6YkalwNfFG05OtCGSalnwe6iK8jRLNCzf9Q==
X-Google-Smtp-Source: AGHT+IGlXbKbCukWc2wfqA1DYPorlvGgxBan7/mYlg5nA1yeIBK0CiI6Yp5P4YssT0PjJJUBV/pIDvKJvkjlJoyEmzQ=
X-Received: by 2002:a67:bd17:0:b0:44d:4dd6:7965 with SMTP id
 y23-20020a67bd17000000b0044d4dd67965mr20272720vsq.5.1693304681791; Tue, 29
 Aug 2023 03:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
 <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
 <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
 <CALeDE9OafhEwznXY5K4YZeMezuZRo5D1Gb57DDxFzPEufcHEfw@mail.gmail.com>
 <CAPnjgZ2TvK=RAD=f9JG4qJHnfjDh0_n7N3JQich_juZ2qisHQQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2TvK=RAD=f9JG4qJHnfjDh0_n7N3JQich_juZ2qisHQQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 29 Aug 2023 15:54:30 +0530
Message-ID: <CAFA6WYNmc2JN9kZ1Ts+s+LbmvTds887ghNTc62ZNOZySGkmHpw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
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

Hi Simon,

On Tue, 29 Aug 2023 at 03:39, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Mon, 28 Aug 2023 at 14:24, Peter Robinson <pbrobinson@gmail.com> wrote=
:
> >
> > On Mon, Aug 28, 2023 at 6:55=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 24 Aug 2023 at 04:44, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sumit,
> > > > >
> > > > > On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> =
wrote:
> > > > > >
> > > > > > Add support for 96Boards Dragonboard 845C aka Robotics RB3 deve=
lopment
> > > > > > platform. This board complies with 96Boards Open Platform Speci=
fications.
> > > > > >
> > > > > > Features:
> > > > > > - Qualcomm Snapdragon SDA845 SoC
> > > > > > - 4GiB RAM
> > > > > > - 64GiB UFS drive
> > > > > >
> > > > > > U-boot is chain loaded by ABL in 64-bit mode as part of boot.im=
g.
> > > > > > For detailed build and boot instructions, refer to
> > > > > > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> > > > > >
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > > > > > ---
> > > > > >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> > > > > >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> > > > > >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> > > > > >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> > > > > >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> > > > > >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> > > > > >  board/qualcomm/dragonboard845c/db845c.its     |  63 ++++++++++=
+
> > > > > >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> > > > > >  configs/dragonboard845c_defconfig             |  28 +++++
> > > > > >  doc/board/qualcomm/sdm845.rst                 | 100 ++++++++++=
+++++---
> > > > > >  include/configs/dragonboard845c.h             |  28 +++++
> > > > > >  11 files changed, 337 insertions(+), 13 deletions(-)
> > > > > >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> > > > > >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> > > > > >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> > > > > >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
> > > > > >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> > > > > >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> > > > > >  create mode 100644 board/qualcomm/dragonboard845c/dragonboard8=
45c.c
> > > > > >  create mode 100644 configs/dragonboard845c_defconfig
> > > > > >  create mode 100644 include/configs/dragonboard845c.h
> > > > > >
> > > > > [..]
> > > > >
> > > > > > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm=
/sdm845.rst
> > > > > > index b6642c9579..8ef4749287 100644
> > > > > > --- a/doc/board/qualcomm/sdm845.rst
> > > > > > +++ b/doc/board/qualcomm/sdm845.rst
> > > > > > @@ -35,9 +35,25 @@ Pack android boot image
> > > > > >  ^^^^^^^^^^^^^^^^^^^^^^^
> > > > > >  We'll assemble android boot image with ``u-boot.bin`` instead =
of linux kernel,
> > > > > >  and FIT image instead of ``initramfs``. Android bootloader exp=
ect gzipped kernel
> > > > > > -with appended dtb, so let's mimic linux to satisfy stock bootl=
oader:
> > > > > > +with appended dtb, so let's mimic linux to satisfy stock bootl=
oader.
> > > > > >
> > > > >
> > > > > [..]
> > > > >
> > > > > > +The dragonboard845c is a Qualcomm Robotics RB3 Development Pla=
tform, based on
> > > > > > +the Qualcomm SDM845 SoC.
> > > > > > +
> > > > > > +Steps:
> > > > > > +
> > > > > > +- Build u-boot::
> > > > > > +
> > > > > > +       $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > > > > > +       $ make dragonboard845c_defconfig
> > > > > > +       $ make
> > > > > > +
> > > > > > +- Create dummy dtb::
> > > > > > +
> > > > > > +       workdir=3D/tmp/prepare_payload
> > > > > > +       mkdir -p "$workdir"
> > > > > > +       mock_dtb=3D"$workdir"/payload_mock.dtb
> > > > > > +
> > > > > > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > > > > > +       /dts-v1/;
> > > > > > +       / {
> > > > > > +               #address-cells =3D <2>;
> > > > > > +               #size-cells =3D <2>;
> > > > > > +
> > > > > > +               memory@80000000 {
> > > > > > +                       device_type =3D "memory";
> > > > > > +                       /* We expect the bootloader to fill in =
the size */
> > > > > > +                       reg =3D <0 0x80000000 0 0>;
> > > > > > +               };
> > > > > > +
> > > > > > +               chosen { };
> > > > > > +       };
> > > > > > +       EOF
> > > > > > +
> > > > > > +- gzip u-boot::
> > > > > > +
> > > > > > +       gzip u-boot.bin
> > > > > > +
> > > > > > +- Append dtb to gzipped u-boot::
> > > > > > +
> > > > > > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > > > > > +
> > > > > > +- A ``db845c.its`` file can be found in ``board/qualcomm/drago=
nboard845c/``
> > > > > > +  directory. It expects a folder as ``db845c_imgs/`` in the ma=
in directory
> > > > > > +  containing pre-built kernel, dts and ramdisk images. See ``d=
b845c.its``
> > > > > > +  for full path to images::
> > > > > > +
> > > > > > +       mkimage -f db845c.its db845c.itb
> > > > > > +
> > > > > > +- Now we've got everything to build android boot image::
> > > > > > +
> > > > > > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.i=
tb \
> > > > > > +       --output boot.img --pagesize 4096 --base 0x80000000
> > > > > > +
> > > > > > +- Flash boot.img using db845c fastboot method.
> > > > >
> > > > > What command should be used here? I can run 'fastboot devices' bu=
t am
> > > > > not sure what command to use to flash U-Boot.
> > > > >
> > > >
> > > > At the time of writing this doc, I thought it was understood how to
> > > > flash boot.img on db845c. But I will make that more explicit. Since
> > > > u-boot has to be chain loaded by ABL, the command to flash boot.img
> > > > (containing u-boot) is as follows:
> > > >
> > > > sudo fastboot flash boot boot.img
> > > >
> > > > > Also, is it possible to flash U-Boot as a first-stage bootloader?
> > > > >
> > > >
> > > > That's not possible currently due to Qcom proprietary bootloader be=
ing
> > > > used. But there were plans to replace atleast ABL with u-boot (See
> > > > slide 9 from this Linaro connect Qcom keynote [1]). I hope that wil=
l
> > > > materialize soon.
> > > >
> > > > [1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJyA
> > > >
> > >
> > > Thank you for the link. I am pleased to hear it and hope it plays out
> > > as that slide seems to indicate.
> > >
> > > I would like to suggest that 96 boards should use open-source firmwar=
e
> > > when they launch. Once they launch there is little incentive to clean
> > > things up.
> >
> > It's something that has been suggested from the outset but the fact is
> > there is no way to enforce it.
>
> Er, the board is listed on Linaros web site and has presumably been
> blessed by Linaro. So don't bless it until the patches are send and/or
> landed?

I see the reasoning behind your thoughts but I would suggest you read
through [1]. It should provide you with enough background thinking.

[1] https://www.96boards.org/compliance/

-Sumit

>
> Regards,
> Simon
