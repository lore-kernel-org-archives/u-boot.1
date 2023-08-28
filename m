Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C66C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A7480569;
	Mon, 28 Aug 2023 22:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gc8rhCYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D9480569; Mon, 28 Aug 2023 22:24:02 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D4A80275
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b962535808so55967781fa.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693254238; x=1693859038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjLPbjx4qOoSDSKEbluduSjaWMQ2QofjdI3XRoqQGQY=;
 b=gc8rhCYEbJ9DPpeRIIrNJofMDP218TcnZpLeJbJyu5FNv9NxnxPP7P/5bO/TIP/Lxc
 u5wNfbbyvZ804WcDp6GcBC7RXYgUXOTj4d/gX7L7jMU1h0LHR0HbYIxkqZukxyDdBZTW
 UGFZZSDVliw9ue5K00jctBc3I+fGBmT4y1xgohSOfm/RBesl6TGLldDyLd7EcPn0zFlQ
 Cw48lQFesiqfI4Cz/4lS8Czrrn9YZNteNqDFMtnVYelstalV9lfOp4okVJe+9pxM4SEr
 pmq5KjZD4ctOMAmXXqdoMBFDWvK4YCGQxjQczfB2fa2Fr8pjoXwsQHdkmCi7XhuX3fKN
 reFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693254238; x=1693859038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjLPbjx4qOoSDSKEbluduSjaWMQ2QofjdI3XRoqQGQY=;
 b=hi8S83tgRLtRfY3Z9uy3SHL7p7m4BszkuH4swaUdP1XKTmsdp6WJssVutdOBHBJ9nW
 7j8P1HuIBZ2Ald9g9sfJ3hdxIETeA3ClfCkW7JVW9Sp9IB622jiVOjtg5roxhJBXt606
 7F8UVT+t3ijzRZnycvIEr8cD0LMQPwKV0kHAXkFMhDo5fiJfifHfhILonoqqGHSigUb/
 9/vp3+Zw1FFEa8ZMlCjv+J6Q/Ypu+jc/mW9mahIV2vlxrfU0fKpPrG+S4ujOpIz30dKF
 QSpud/ARTa0vSOOhmCXHhV6pBruQ4+rWFv7I2YHjQ/uY/PsmVvLvzwrUI7HyU/bStY8L
 Y48Q==
X-Gm-Message-State: AOJu0Yxk0VG+5GsRNu4BeIbYtb6Ei7RxFizPwvtqb9x0HnOK1xYFqLUx
 sovlXu/MQYTScg230iHGUfZl02959qZigUVsv4A=
X-Google-Smtp-Source: AGHT+IF4lHR8o2xvdPstHE7/sbdG/uXWf2tnRZKILu55o4FtR/OLMB9j4kQaA1M9bnuF3Vc3k8elbMs9h/Y2yq6D+/A=
X-Received: by 2002:a2e:a0c7:0:b0:2b1:a89a:5f2b with SMTP id
 f7-20020a2ea0c7000000b002b1a89a5f2bmr19780082ljm.2.1693254237830; Mon, 28 Aug
 2023 13:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
 <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
 <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 28 Aug 2023 21:23:46 +0100
Message-ID: <CALeDE9OafhEwznXY5K4YZeMezuZRo5D1Gb57DDxFzPEufcHEfw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Simon Glass <sjg@chromium.org>
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

On Mon, Aug 28, 2023 at 6:55=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Sumit,
>
> On Thu, 24 Aug 2023 at 04:44, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > Add support for 96Boards Dragonboard 845C aka Robotics RB3 developm=
ent
> > > > platform. This board complies with 96Boards Open Platform Specifica=
tions.
> > > >
> > > > Features:
> > > > - Qualcomm Snapdragon SDA845 SoC
> > > > - 4GiB RAM
> > > > - 64GiB UFS drive
> > > >
> > > > U-boot is chain loaded by ABL in 64-bit mode as part of boot.img.
> > > > For detailed build and boot instructions, refer to
> > > > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > > > ---
> > > >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> > > >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> > > >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> > > >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> > > >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> > > >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> > > >  board/qualcomm/dragonboard845c/db845c.its     |  63 +++++++++++
> > > >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> > > >  configs/dragonboard845c_defconfig             |  28 +++++
> > > >  doc/board/qualcomm/sdm845.rst                 | 100 ++++++++++++++=
+---
> > > >  include/configs/dragonboard845c.h             |  28 +++++
> > > >  11 files changed, 337 insertions(+), 13 deletions(-)
> > > >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> > > >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> > > >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> > > >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
> > > >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> > > >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> > > >  create mode 100644 board/qualcomm/dragonboard845c/dragonboard845c.=
c
> > > >  create mode 100644 configs/dragonboard845c_defconfig
> > > >  create mode 100644 include/configs/dragonboard845c.h
> > > >
> > > [..]
> > >
> > > > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm=
845.rst
> > > > index b6642c9579..8ef4749287 100644
> > > > --- a/doc/board/qualcomm/sdm845.rst
> > > > +++ b/doc/board/qualcomm/sdm845.rst
> > > > @@ -35,9 +35,25 @@ Pack android boot image
> > > >  ^^^^^^^^^^^^^^^^^^^^^^^
> > > >  We'll assemble android boot image with ``u-boot.bin`` instead of l=
inux kernel,
> > > >  and FIT image instead of ``initramfs``. Android bootloader expect =
gzipped kernel
> > > > -with appended dtb, so let's mimic linux to satisfy stock bootloade=
r:
> > > > +with appended dtb, so let's mimic linux to satisfy stock bootloade=
r.
> > > >
> > >
> > > [..]
> > >
> > > > +The dragonboard845c is a Qualcomm Robotics RB3 Development Platfor=
m, based on
> > > > +the Qualcomm SDM845 SoC.
> > > > +
> > > > +Steps:
> > > > +
> > > > +- Build u-boot::
> > > > +
> > > > +       $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > > > +       $ make dragonboard845c_defconfig
> > > > +       $ make
> > > > +
> > > > +- Create dummy dtb::
> > > > +
> > > > +       workdir=3D/tmp/prepare_payload
> > > > +       mkdir -p "$workdir"
> > > > +       mock_dtb=3D"$workdir"/payload_mock.dtb
> > > > +
> > > > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > > > +       /dts-v1/;
> > > > +       / {
> > > > +               #address-cells =3D <2>;
> > > > +               #size-cells =3D <2>;
> > > > +
> > > > +               memory@80000000 {
> > > > +                       device_type =3D "memory";
> > > > +                       /* We expect the bootloader to fill in the =
size */
> > > > +                       reg =3D <0 0x80000000 0 0>;
> > > > +               };
> > > > +
> > > > +               chosen { };
> > > > +       };
> > > > +       EOF
> > > > +
> > > > +- gzip u-boot::
> > > > +
> > > > +       gzip u-boot.bin
> > > > +
> > > > +- Append dtb to gzipped u-boot::
> > > > +
> > > > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > > > +
> > > > +- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboa=
rd845c/``
> > > > +  directory. It expects a folder as ``db845c_imgs/`` in the main d=
irectory
> > > > +  containing pre-built kernel, dts and ramdisk images. See ``db845=
c.its``
> > > > +  for full path to images::
> > > > +
> > > > +       mkimage -f db845c.its db845c.itb
> > > > +
> > > > +- Now we've got everything to build android boot image::
> > > > +
> > > > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> > > > +       --output boot.img --pagesize 4096 --base 0x80000000
> > > > +
> > > > +- Flash boot.img using db845c fastboot method.
> > >
> > > What command should be used here? I can run 'fastboot devices' but am
> > > not sure what command to use to flash U-Boot.
> > >
> >
> > At the time of writing this doc, I thought it was understood how to
> > flash boot.img on db845c. But I will make that more explicit. Since
> > u-boot has to be chain loaded by ABL, the command to flash boot.img
> > (containing u-boot) is as follows:
> >
> > sudo fastboot flash boot boot.img
> >
> > > Also, is it possible to flash U-Boot as a first-stage bootloader?
> > >
> >
> > That's not possible currently due to Qcom proprietary bootloader being
> > used. But there were plans to replace atleast ABL with u-boot (See
> > slide 9 from this Linaro connect Qcom keynote [1]). I hope that will
> > materialize soon.
> >
> > [1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJyA
> >
>
> Thank you for the link. I am pleased to hear it and hope it plays out
> as that slide seems to indicate.
>
> I would like to suggest that 96 boards should use open-source firmware
> when they launch. Once they launch there is little incentive to clean
> things up.

It's something that has been suggested from the outset but the fact is
there is no way to enforce it.
