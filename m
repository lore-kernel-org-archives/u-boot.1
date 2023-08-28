Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4FC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E5486530;
	Mon, 28 Aug 2023 19:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uu6bYiWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD0C86507; Mon, 28 Aug 2023 19:56:03 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 938B686518
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d71dd633f33so3460157276.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WX65vnyBgJaGKpyO0Pxvtj+a0LrNY6pJ0HST+O8C2qs=;
 b=Uu6bYiWhWKJ3rLXXrGUFKj99A61QJq4IGbfEdgxhaIa+pPkkXb0tcDjjf4NdwPKNwK
 VKmFIsKjobseycDt74dmfIOgFz87AreakTDziCJmclWLuMNf5i1m79XQbha4Hw19YGUX
 FyEwjS+Scs89kZq8F7ZasZKglQ5TeSEBzs6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WX65vnyBgJaGKpyO0Pxvtj+a0LrNY6pJ0HST+O8C2qs=;
 b=F8RrfmgX9aRo5UnzDQpluPRCbcWyNNx1S11S6OzLl80BtI6NJVqI6E6BLDw23lMK41
 3hKlU7bbwiXTv/jRGD4jotK6sAVyFj5WLfoP3nnFo+h0Obtc3f4aEL5vXRBCjh2ozFdA
 bxn4XE37Y2jvbpkNJHqohXtNCQJvKDtI17l+qMW9csjAdymARJRh8GioxFdIU9rZBigW
 R/FhngvdSwNDO+5/3Q/CYKs8wsL9zqGqpBXLCNee58gM13s23LaPnZ6I012ioPRknH3i
 kZtfSLHB3OqAS12O+owrDXXVbiHKj2EUR9uflOcb0eBqjfG4rU3ib6uCfode9B6d5UkS
 Wikg==
X-Gm-Message-State: AOJu0YwfD2IF1CWjZll7vQZMxJq7hLRHUtvUiihI6vwZ6lF41ij9/P7A
 j+sXWCqD81o2NLPMvQJEFMv7XyAg2agfnqUVOSHApA==
X-Google-Smtp-Source: AGHT+IHOk371qsV1/h5UzuFkXT1tT3KwxhjGszitmw+ZabR1gaCjcpoLHa154oSTxsb+Uo5FKlufjygRW7Yg0k1NaT8=
X-Received: by 2002:a25:858a:0:b0:d5c:1b9b:6f5a with SMTP id
 x10-20020a25858a000000b00d5c1b9b6f5amr22746860ybk.44.1693245356091; Mon, 28
 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712071212.2188390-1-sumit.garg@linaro.org>
 <20220712071212.2188390-6-sumit.garg@linaro.org>
 <CAPnjgZ2jR_fpjKo6XyG6eOY1ZX9ktXsaON6Ey6STY1ZjcnUzAw@mail.gmail.com>
 <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
In-Reply-To: <CAFA6WYMQRFuga9h=PA4UCYofOt7x2Gohh9oDQAQTaL4ZFKr-Vw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:57 -0600
Message-ID: <CAPnjgZ1jPVk=NX2aJVfEXwA-XmvoXO4v31c_nepjEMgeu5+rSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] board: qualcomm: Add support for dragonboard845c
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, rfried.dev@gmail.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, trini@konsulko.com, dsankouski@gmail.com, 
 stephan@gerhold.net, vinod.koul@linaro.org, nicolas.dechesne@linaro.org, 
 mworsfold@impinj.com, daniel.thompson@linaro.org, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 24 Aug 2023 at 04:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 24 Aug 2023 at 05:29, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Tue, 12 Jul 2022 at 01:12, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for 96Boards Dragonboard 845C aka Robotics RB3 development
> > > platform. This board complies with 96Boards Open Platform Specifications.
> > >
> > > Features:
> > > - Qualcomm Snapdragon SDA845 SoC
> > > - 4GiB RAM
> > > - 64GiB UFS drive
> > >
> > > U-boot is chain loaded by ABL in 64-bit mode as part of boot.img.
> > > For detailed build and boot instructions, refer to
> > > doc/board/qualcomm/sdm845.rst, board: dragonboard845c.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > > ---
> > >  arch/arm/dts/dragonboard845c-uboot.dtsi       |  37 +++++++
> > >  arch/arm/dts/dragonboard845c.dts              |  44 ++++++++
> > >  arch/arm/mach-snapdragon/Kconfig              |  14 +++
> > >  board/qualcomm/dragonboard845c/Kconfig        |  12 +++
> > >  board/qualcomm/dragonboard845c/MAINTAINERS    |   6 ++
> > >  board/qualcomm/dragonboard845c/Makefile       |   9 ++
> > >  board/qualcomm/dragonboard845c/db845c.its     |  63 +++++++++++
> > >  .../dragonboard845c/dragonboard845c.c         |   9 ++
> > >  configs/dragonboard845c_defconfig             |  28 +++++
> > >  doc/board/qualcomm/sdm845.rst                 | 100 +++++++++++++++---
> > >  include/configs/dragonboard845c.h             |  28 +++++
> > >  11 files changed, 337 insertions(+), 13 deletions(-)
> > >  create mode 100644 arch/arm/dts/dragonboard845c-uboot.dtsi
> > >  create mode 100644 arch/arm/dts/dragonboard845c.dts
> > >  create mode 100644 board/qualcomm/dragonboard845c/Kconfig
> > >  create mode 100644 board/qualcomm/dragonboard845c/MAINTAINERS
> > >  create mode 100644 board/qualcomm/dragonboard845c/Makefile
> > >  create mode 100644 board/qualcomm/dragonboard845c/db845c.its
> > >  create mode 100644 board/qualcomm/dragonboard845c/dragonboard845c.c
> > >  create mode 100644 configs/dragonboard845c_defconfig
> > >  create mode 100644 include/configs/dragonboard845c.h
> > >
> > [..]
> >
> > > diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> > > index b6642c9579..8ef4749287 100644
> > > --- a/doc/board/qualcomm/sdm845.rst
> > > +++ b/doc/board/qualcomm/sdm845.rst
> > > @@ -35,9 +35,25 @@ Pack android boot image
> > >  ^^^^^^^^^^^^^^^^^^^^^^^
> > >  We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> > >  and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> > > -with appended dtb, so let's mimic linux to satisfy stock bootloader:
> > > +with appended dtb, so let's mimic linux to satisfy stock bootloader.
> > >
> >
> > [..]
> >
> > > +The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> > > +the Qualcomm SDM845 SoC.
> > > +
> > > +Steps:
> > > +
> > > +- Build u-boot::
> > > +
> > > +       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > > +       $ make dragonboard845c_defconfig
> > > +       $ make
> > > +
> > > +- Create dummy dtb::
> > > +
> > > +       workdir=/tmp/prepare_payload
> > > +       mkdir -p "$workdir"
> > > +       mock_dtb="$workdir"/payload_mock.dtb
> > > +
> > > +       dtc -I dts -O dtb -o "$mock_dtb" << EOF
> > > +       /dts-v1/;
> > > +       / {
> > > +               #address-cells = <2>;
> > > +               #size-cells = <2>;
> > > +
> > > +               memory@80000000 {
> > > +                       device_type = "memory";
> > > +                       /* We expect the bootloader to fill in the size */
> > > +                       reg = <0 0x80000000 0 0>;
> > > +               };
> > > +
> > > +               chosen { };
> > > +       };
> > > +       EOF
> > > +
> > > +- gzip u-boot::
> > > +
> > > +       gzip u-boot.bin
> > > +
> > > +- Append dtb to gzipped u-boot::
> > > +
> > > +        cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> > > +
> > > +- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
> > > +  directory. It expects a folder as ``db845c_imgs/`` in the main directory
> > > +  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
> > > +  for full path to images::
> > > +
> > > +       mkimage -f db845c.its db845c.itb
> > > +
> > > +- Now we've got everything to build android boot image::
> > > +
> > > +       mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> > > +       --output boot.img --pagesize 4096 --base 0x80000000
> > > +
> > > +- Flash boot.img using db845c fastboot method.
> >
> > What command should be used here? I can run 'fastboot devices' but am
> > not sure what command to use to flash U-Boot.
> >
>
> At the time of writing this doc, I thought it was understood how to
> flash boot.img on db845c. But I will make that more explicit. Since
> u-boot has to be chain loaded by ABL, the command to flash boot.img
> (containing u-boot) is as follows:
>
> sudo fastboot flash boot boot.img
>
> > Also, is it possible to flash U-Boot as a first-stage bootloader?
> >
>
> That's not possible currently due to Qcom proprietary bootloader being
> used. But there were plans to replace atleast ABL with u-boot (See
> slide 9 from this Linaro connect Qcom keynote [1]). I hope that will
> materialize soon.
>
> [1] https://resources.linaro.org/en/resource/necH5bQcfrhCCkjSGHXJyA
>

Thank you for the link. I am pleased to hear it and hope it plays out
as that slide seems to indicate.

I would like to suggest that 96 boards should use open-source firmware
when they launch. Once they launch there is little incentive to clean
things up.

Regards,
Simon
