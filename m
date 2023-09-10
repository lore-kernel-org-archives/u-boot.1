Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D184DC71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 23:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FFEE86CE3;
	Mon, 11 Sep 2023 01:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XCMfUB3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D9386B94; Mon, 11 Sep 2023 01:15:13 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D129A86CD5
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 01:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so5018390a12.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694387709; x=1694992509; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY6ucHvEMbGVMHcbXFvcY8WZk1F1H4zBgKZX81DKhks=;
 b=XCMfUB3VqzddM++XUetrl+k5etdVaJZfGIAL4o4Z0fI87rwin61g/Qzu9ddXktMUzT
 mt9AUwVQzL/zlDQXfd4qAOjI62UNV1JS26ZCXfdQg14QAxe0Ju8/BB7Y99QLAaCHqiel
 VHjSKzRJum9h31BDBWziZM696a72244xyhlvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694387709; x=1694992509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DY6ucHvEMbGVMHcbXFvcY8WZk1F1H4zBgKZX81DKhks=;
 b=e2Cf/4oqhj1gYsvDPbmQNcpykcLr4WL3hHzmAezKLupvnkT1JHBBVKpnEozblDaQBm
 k3BMpAmHAnH0y766R13gzfpG6XcqAreH8F2ANHEUbTsA4DRnUgXBWOFBdaYffRSFRKvt
 PUvBLLHxOB3SLIOlfE7gu8nUAXLdsiKzNhHkIcLi9QAXEZRh6VnRiZS3uP7PZpHqqe2a
 TRA1esNlvNe5qlwRBvGabGvtBzSAOK3tFPaAYokrjlwY7+cdCf+73SD97rmbRmR3fFt2
 Hmz6VXkOiP46/2L6nUhlugHoOKhX7iVy4MHieCE6etkPT0+Iipg1cSm/iYR1NKKxe1oC
 dkAw==
X-Gm-Message-State: AOJu0YyUzIX64ikzo3VuJ03iEDcTdSvx9bMlqR2MXRV0TJK7eolfG7TG
 t13eE2pe7KEHK28UYvPsUcPbVyscjGIQOXHLRcKkkw==
X-Google-Smtp-Source: AGHT+IGimRicgj6a/qMVONRbZjJqZlS2UwLMGrpoTsTGzyab2GpdjXDV7t0rXj9+uUnzdP76oE3ZJ9D3y0Q9L/CdaTY=
X-Received: by 2002:a05:6402:1287:b0:51d:95f2:ee76 with SMTP id
 w7-20020a056402128700b0051d95f2ee76mr6671705edv.27.1694387709110; Sun, 10 Sep
 2023 16:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
 <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
 <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
 <CALeDE9OafhEwznXY5K4YZeMezuZRo5D1Gb57DDxFzPEufcHEfw@mail.gmail.com>
 <CAPnjgZ2TvK=RAD=f9JG4qJHnfjDh0_n7N3JQich_juZ2qisHQQ@mail.gmail.com>
 <CAFA6WYNmc2JN9kZ1Ts+s+LbmvTds887ghNTc62ZNOZySGkmHpw@mail.gmail.com>
In-Reply-To: <CAFA6WYNmc2JN9kZ1Ts+s+LbmvTds887ghNTc62ZNOZySGkmHpw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 17:14:57 -0600
Message-ID: <CAPnjgZ3QD0HDAQ0Feo7eLTJR0mvZapbY0_sWoLJTXDkA-sjFJw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Tue, 29 Aug 2023 at 04:24, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 29 Aug 2023 at 03:39, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Peter,
> >
> > On Mon, 28 Aug 2023 at 14:24, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > On Mon, Aug 28, 2023 at 6:55=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Thu, 24 Aug 2023 at 04:44, Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org=
> wrote:
> > > > > > >
> > > > > > > Add support for 96Boards Dragonboard 845C aka Robotics RB3 de=
velopment
> > > > > > > platform. This board complies with 96Boards Open Platform Spe=
cifications.
> > > > > > >
> > > > > > > Features:
> > > > > > > - Qualcomm Snapdragon SDA845 SoC
> > > > > > > - 4GiB RAM
> > > > > > > - 64GiB UFS drive
> > > > > > >
> > > > > > > U-boot is chain loaded by ABL in 64-bit mode as part of boot.=
img.
> > > > > > > For detailed build and boot instructions, refer to
> > > > > > > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> > > > > > >
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > > > > > > ---
> > > > > > >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> > > > > > >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> > > > > > >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> > > > > > >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> > > > > > >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> > > > > > >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> > > > > > >  board/qualcomm/dragonboard845c/db845c.its     |  63 ++++++++=
+++
> > > > > > >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> > > > > > >  configs/dragonboard845c_defconfig             |  28 +++++
> > > > > > >  doc/board/qualcomm/sdm845.rst                 | 100 ++++++++=
+++++++---
> > > > > > >  include/configs/dragonboard845c.h             |  28 +++++
> > > > > > >  11 files changed, 337 insertions(+), 13 deletions(-)
> > > > > > >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> > > > > > >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> > > > > > >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> > > > > > >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINER=
S
> > > > > > >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> > > > > > >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> > > > > > >  create mode 100644 board/qualcomm/dragonboard845c/dragonboar=
d845c.c
> > > > > > >  create mode 100644 configs/dragonboard845c_defconfig
> > > > > > >  create mode 100644 include/configs/dragonboard845c.h
> > > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualco=
mm/sdm845.rst
> > > > > > > index b6642c9579..8ef4749287 100644
> > > > > > > --- a/doc/board/qualcomm/sdm845.rst
> > > > > > > +++ b/doc/board/qualcomm/sdm845.rst
> > > > > > > @@ -35,9 +35,25 @@ Pack android boot image
> > > > > > >  ^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > >  We'll assemble android boot image with ``u-boot.bin`` instea=
d of linux kernel,
> > > > > > >  and FIT image instead of ``initramfs``. Android bootloader e=
xpect gzipped kernel
> > > > > > > -with appended dtb, so let's mimic linux to satisfy stock boo=
tloader:
> > > > > > > +with appended dtb, so let's mimic linux to satisfy stock boo=
tloader.
> > > > > > >
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > > +The dragonboard845c is a Qualcomm Robotics RB3 Development P=
latform, based on
> > > > > > > +the Qualcomm SDM845 SoC.
> > > > > > > +
> > > > > > > +Steps:
> > > > > > > +
> > > > > > > +- Build u-boot::
> > > > > > > +
> > > > > > > +       $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > > > > > > +       $ make dragonboard845c_defconfig
> > > > > > > +       $ make
> > > > > > > +
> > > > > > > +- Create dummy dtb::
> > > > > > > +
> > > > > > > +       workdir=3D/tmp/prepare_payload
> > > > > > > +       mkdir -p "$workdir"
> > > > > > > +       mock_dtb=3D"$workdir"/payload_mock.dtb
> > > > > > > +
> > > > > > > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > > > > > > +       /dts-v1/;
> > > > > > > +       / {
> > > > > > > +               #address-cells =3D <2>;
> > > > > > > +               #size-cells =3D <2>;
> > > > > > > +
> > > > > > > +               memory@80000000 {
> > > > > > > +                       device_type =3D "memory";
> > > > > > > +                       /* We expect the bootloader to fill i=
n the size */
> > > > > > > +                       reg =3D <0 0x80000000 0 0>;
> > > > > > > +               };
> > > > > > > +
> > > > > > > +               chosen { };
> > > > > > > +       };
> > > > > > > +       EOF
> > > > > > > +
> > > > > > > +- gzip u-boot::
> > > > > > > +
> > > > > > > +       gzip u-boot.bin
> > > > > > > +
> > > > > > > +- Append dtb to gzipped u-boot::
> > > > > > > +
> > > > > > > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > > > > > > +
> > > > > > > +- A ``db845c.its`` file can be found in ``board/qualcomm/dra=
gonboard845c/``
> > > > > > > +  directory. It expects a folder as ``db845c_imgs/`` in the =
main directory
> > > > > > > +  containing pre-built kernel, dts and ramdisk images. See `=
`db845c.its``
> > > > > > > +  for full path to images::
> > > > > > > +
> > > > > > > +       mkimage -f db845c.its db845c.itb
> > > > > > > +
> > > > > > > +- Now we've got everything to build android boot image::
> > > > > > > +
> > > > > > > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c=
.itb \
> > > > > > > +       --output boot.img --pagesize 4096 --base 0x80000000
> > > > > > > +
> > > > > > > +- Flash boot.img using db845c fastboot method.
> > > > > >
> > > > > > What command should be used here? I can run 'fastboot devices' =
but am
> > > > > > not sure what command to use to flash U-Boot.
> > > > > >
> > > > >
> > > > > At the time of writing this doc, I thought it was understood how =
to
> > > > > flash boot.img on db845c. But I will make that more explicit. Sin=
ce
> > > > > u-boot has to be chain loaded by ABL, the command to flash boot.i=
mg
> > > > > (containing u-boot) is as follows:
> > > > >
> > > > > sudo fastboot flash boot boot.img
> > > > >
> > > > > > Also, is it possible to flash U-Boot as a first-stage bootloade=
r?
> > > > > >
> > > > >
> > > > > That's not possible currently due to Qcom proprietary bootloader =
being
> > > > > used. But there were plans to replace atleast ABL with u-boot (Se=
e
> > > > > slide 9 from this Linaro connect Qcom keynote [1]). I hope that w=
ill
> > > > > materialize soon.
> > > > >
> > > > > [1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJ=
yA
> > > > >
> > > >
> > > > Thank you for the link. I am pleased to hear it and hope it plays o=
ut
> > > > as that slide seems to indicate.
> > > >
> > > > I would like to suggest that 96 boards should use open-source firmw=
are
> > > > when they launch. Once they launch there is little incentive to cle=
an
> > > > things up.
> > >
> > > It's something that has been suggested from the outset but the fact i=
s
> > > there is no way to enforce it.
> >
> > Er, the board is listed on Linaros web site and has presumably been
> > blessed by Linaro. So don't bless it until the patches are send and/or
> > landed?
>
> I see the reasoning behind your thoughts but I would suggest you read
> through [1]. It should provide you with enough background thinking.
>
> [1] https://www.96boards.org/compliance/

"It is recommended that all documentation required under the 96Boards
program for the board and SoC be freely available from the 96Boards
website. Any documentation that cannot be provided from the 96Boards
website shall be available from a vendor or other public website that
can be linked to from the 96Boards website."

So are the SoC docs available for this board?

"It is strongly recommended one open source bootloader to be provided
for the board that executes immediately after the internal SoC startup
code. The source for this bootloader should be available from a
publicly accessible site or integrated into the bootloader trees
onhttps://github.com/96boards"

My reading of this is that an open source bootloader is optional.
Would it not make sense to make it mandatory?

"It is strongly recommended that vendors of an ARMv8 board provide a
port of the ARM Trusted Firmware (ATF) and PSCI reference
implementations, and a port of the Tianocore EDK2 UEFI reference
implementation."

Why suggest a UEFI port? Wouldn't suggesting U-Boot be a lot more
useful in terms of building the open source community?

Regards,
Simon
