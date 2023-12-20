Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E41C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740768701C;
	Wed, 20 Dec 2023 14:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="orjP2swr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8757486DEE; Wed, 20 Dec 2023 14:36:17 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88063870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7caff8105dcso1706608241.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703079371; x=1703684171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JH8WwHjAfIJ99Uij6lUVrPdIT66OsZPVWOVxf7+NEYI=;
 b=orjP2swrKxifWscnEPzcVH9YLCFX5xztZw08HiRUEYxKDZ5pKS1E2+FV55kxXELfv2
 hxRQ14LaYHoMSgkrdLx9MNWk2zWCCwLUAYXeYGDODnZCYWxsZMbuaSxZEmp8M8bE6ci2
 yqIfEcoM3kgZa0f/GaqjO+vs2Z8aTCs8H/UW0vNgYOSjfyYrn37cQpU9gjAmFEc9nUvi
 jMLlefWf1xPj8JXNyhnRSVt6iPdLWQuHqK10RQtCtmiT6itDjQhTRQtd6uwgyFADmN1X
 ZdqwekyJhRTfT5VvDtW+04R2sS8CPpxu7s3uJGx7JfBjxRozfZILRRng2hSJDWlCQhVT
 BKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703079371; x=1703684171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JH8WwHjAfIJ99Uij6lUVrPdIT66OsZPVWOVxf7+NEYI=;
 b=fp6Vcrol1/RE9qn1n02ITaLgChX09Q1aFG6krs4hZ8LM221sur004glHm+9IzA13ne
 khIDuFaRkdfsbkNRC2cZGe3F28AGxmp7c04AOTJ9bNcQS+qCIfV0tcuX3z8V2LIaeBhJ
 GV0Y6fYFJGJ3zPN8NmmScYLUGR8P18R8WFLdYaAYe9zwRWy4sb4d/8xq7gYN99k2bdPG
 YjDo/3yxIKjqYSSonlCI71CWE1dxeu+ZN+FQ3SRpoIEF74BPL909TG4LMlgHIC+b7zcA
 wyFexY4NG2ZkCM2bqXSWN3IjTI+pq/CCzCZBcWP4pHKQRP+vz1orc9XTkHENPbGy8a25
 xDNA==
X-Gm-Message-State: AOJu0YyIYIRIW6H8tCr1UZA8/zBpX8l/KqYrrSoZekHtKX0/0gIugsWy
 eIPy4f6efWIm+FzGp8rPxAuiGuNpFJbsTqFqSpTGAA==
X-Google-Smtp-Source: AGHT+IGbnrJpDNo28xG9MPlTYee+95p9kplsWP5gBVBgtDptSGz6J8jXDsX7XkC63dzXfHuL60Jg0A/NCXB/Dn7aKQg=
X-Received: by 2002:ac5:cb0a:0:b0:4b6:edaa:39b1 with SMTP id
 r10-20020ac5cb0a000000b004b6edaa39b1mr1318053vkl.11.1703079371233; Wed, 20
 Dec 2023 05:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
 <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
 <65d0c4d7-ba69-4cf8-ae8e-89787f2aa009@linaro.org>
In-Reply-To: <65d0c4d7-ba69-4cf8-ae8e-89787f2aa009@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 19:06:00 +0530
Message-ID: <CAFA6WYMR6tSvxDZ7Gym=YAhVxpP1dFP1Mie+DmBRYJxMi5yXwA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add SE HMBSC board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com, 
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

On Tue, 19 Dec 2023 at 21:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 19/12/2023 06:25, Sumit Garg wrote:
> > Hi Simon,
> >
> > On Mon, 18 Dec 2023 at 20:32, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On Mon, 18 Dec 2023 at 00:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>>
> >>> SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
> >>
> >> Could you please add a doc/ file for this board and explain how to
> >> build it and how to run U-Boot on it?
> >
> > Ah I forgot to add that since the build/boot instructions are quite
> > similar to db410c. BTW, I will add that in the next spin.
>
> Probably just referencing that document or making the language generic
> would be good.
>

I will rename that doc to be rather SoC specific with board specific
sub-sections.

> Sumit, could you rebase this series on my generic board support? [1] in
> it's current form this series conflicts, and includes some of the major
> anti-patterns I'm trying to move away from in mach-snapdragon.

Although, I haven't gone through your series but I was expecting those
conflicts. Let's work together to make this series compatible on top
of yours.

>
> You should not have to introduce a new CONFIG_TARGET_XYZ variable, and
> from what I can tell you shouldn't even need to add the board/schneider
> directory at all, you can just set the following in your defconfig:
>
> CONFIG_SYS_BOARD="dragonboard410c"

This is simply a misnomer, its HMIBSC board. I suppose we should
rather separate the SoC specific bits into mach-snapdragon and let
different boards use them.

> CONFIG_SYS_CONFIG_NAME="hmibsc"
>
> This will use the db410c board code (which yours is just a copy/paste of
> from what I can tell) and your custom include/configs/hmibsc.h header.
>
> The addresses set in your environment file should be allocated
> automatically at runtime too (see the ("mach-snapdragon: dynamic load
> addresses") patch).
>
> You should also switch to an upstream board DTS based on my series, and
> drop the "-uboot.dtsi" file.

Unfortunately, currently there isn't any upstream DTS for this board
but I will check with the SE team regarding their plans. Until then we
have to use a U-Boot specific DTS file.

-Sumit

>
> [1]:
> https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org/
>
> Kind regards,
>
> >
> > -Sumit
> >
> >>
> >>> difference from db410c is serial port where HMIBSC board uses UART1 as
> >>> the debug console with an RS232 port, patch #1 - #3 adds corresponding
> >>> driver support.
> >>>
> >>> Patch #4 adds main HMIBSC board specific bits, features:
> >>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> >>> - 2GiB RAM
> >>> - 64GiB eMMC, SD slot
> >>> - WiFi and Bluetooth
> >>> - 2x Host, 1x Device USB port
> >>> - HDMI
> >>> - Discrete TPM2 chip over SPI
> >>>
> >>> Patch #5 - #7 enables specific board features like RAUC support,
> >>> environment protection and USB networking support.
> >>>
> >>> This patch series is based on top of Qcom maintainer tree [1] + the latest
> >>> PMIC patch-set [2]. Feedback is very much welcome.
> >>>
> >>> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
> >>> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322
> >>>
> >>> Sumit Garg (7):
> >>>   clk: apq8016: Add support for UART1 clocks
> >>>   serial_msm: Add support for RS232 GPIOs
> >>>   serial_msm: Enable RS232 flow control
> >>>   board: Add SE HMIBSC board support
> >>>   hmibsc: Enable RAUC support
> >>>   hmibsc: enable U-Boot Environment variables protection
> >>>   hmibsc: Enable LAN75XX USB ethernet driver
> >>>
> >>>  arch/arm/dts/Makefile              |   1 +
> >>>  arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
> >>>  arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
> >>>  arch/arm/mach-snapdragon/Kconfig   |  18 +++
> >>>  arch/arm/mach-snapdragon/Makefile  |   1 +
> >>>  board/schneider/hmibsc/Kconfig     |  15 +++
> >>>  board/schneider/hmibsc/MAINTAINERS |   6 +
> >>>  board/schneider/hmibsc/Makefile    |   5 +
> >>>  board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
> >>>  board/schneider/hmibsc/hmibsc.env  |  11 ++
> >>>  configs/hmibsc_defconfig           |  79 ++++++++++++
> >>>  drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
> >>>  drivers/serial/serial_msm.c        |  23 +++-
> >>>  drivers/usb/host/Kconfig           |   1 +
> >>>  include/configs/hmibsc.h           |  59 +++++++++
> >>>  15 files changed, 665 insertions(+), 8 deletions(-)
> >>>  create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
> >>>  create mode 100644 arch/arm/dts/hmibsc.dts
> >>>  create mode 100644 board/schneider/hmibsc/Kconfig
> >>>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
> >>>  create mode 100644 board/schneider/hmibsc/Makefile
> >>>  create mode 100644 board/schneider/hmibsc/hmibsc.c
> >>>  create mode 100644 board/schneider/hmibsc/hmibsc.env
> >>>  create mode 100644 configs/hmibsc_defconfig
> >>>  create mode 100644 include/configs/hmibsc.h
> >>>
> >>> --
> >>> 2.34.1
> >>>
> >>
> >> Regards,
> >> Simon
>
> --
> // Caleb (they/them)
