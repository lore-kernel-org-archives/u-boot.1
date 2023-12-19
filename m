Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82343C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 06:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1151B86FCE;
	Tue, 19 Dec 2023 07:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ob/EDU+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34E980788; Tue, 19 Dec 2023 07:25:38 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8E286FCE
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 07:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d9fdbcec6eso3057117a34.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702967131; x=1703571931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wNcK0AqNDSHyJwbf2mvuv7ngW3ix6936CCmeiTdndG4=;
 b=Ob/EDU+kvriEe6i9yfmhF65SOpbORWNuLTrrjfDSgg7M8aXhacIh5v/NPbvTuLU1NI
 u07yVIkK8w//bQ2lesk58XteTKXSSEqNz1e6VcjRQHX86p7TAJt6caBV+MkGfbILmczU
 gQVPyccV5umjV3aX5YEYmDnwDf2Ve8eMtDX6JX+HFpavvpMhCthbQZSDojySemWgLuq0
 dbuLsD4kvRO9vf0ar+Odc9Hu1Mye8qwDWf9dSKZ1AojFZiPumglFE1Vm4CWWxr714M+R
 gkXM891BcbiUCyKpWB8DSUKKKKPrVkCIBCfsEo6EeL+NwmHEPkxY5ygzrcaZKrQnN6uU
 o7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702967131; x=1703571931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wNcK0AqNDSHyJwbf2mvuv7ngW3ix6936CCmeiTdndG4=;
 b=o4tnPwbMMHJ3nGRCFBLS6/mc3vBBv/ANEc5PbHKuymG3TZHhWE5LRr1V8Qg1fojo2O
 p5fRjtLX1182QwJtzAH+G6TDY7ILfSqv68JEV/84p2Zoi+XS6rmN6k10EXusCguAH0li
 x4CgKY6DhoALWsEuPdGtsTTO19XxDbCgZwCtNDwLbw9QsFafmoU784NFiQL2FU+xd6CM
 GMOYkD3xJ3HEcSAIm/rEwxeEoD6hJdzAKM2qmqlqsqZz09dikKaHt1Kwj1ARyfu9LwsM
 nqW9GRKH24Fr6zMZGmnMh8ZkUCh2VkYpb1d1zPOqHu+F8jBvKqta1gio9bBIj3H/26Bo
 8uDA==
X-Gm-Message-State: AOJu0Yx15kbKPfXebWJkxjODzYYPPe7lwmUIl4vTNC5gWUCR58F9U6MA
 c1h1PgHwgTl4l/R3ehX8ue4wyV+SWM0Swz00MXaGnA==
X-Google-Smtp-Source: AGHT+IFzPloXuMc6sCLYmuUVvUkhB560pn1BbrZFd8ynKrY2sFOb992e+Q4R8AWMmgarNrzaV6VphZgqerj7OqglBDA=
X-Received: by 2002:a05:6830:4428:b0:6d9:e86a:aa65 with SMTP id
 q40-20020a056830442800b006d9e86aaa65mr19841156otv.24.1702967131041; Mon, 18
 Dec 2023 22:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Dec 2023 11:55:19 +0530
Message-ID: <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add SE HMBSC board support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
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

Hi Simon,

On Mon, 18 Dec 2023 at 20:32, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Mon, 18 Dec 2023 at 00:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > SE HMIBSC board is based on Qcom APQ8016 SoC. One of the major
>
> Could you please add a doc/ file for this board and explain how to
> build it and how to run U-Boot on it?

Ah I forgot to add that since the build/boot instructions are quite
similar to db410c. BTW, I will add that in the next spin.

-Sumit

>
> > difference from db410c is serial port where HMIBSC board uses UART1 as
> > the debug console with an RS232 port, patch #1 - #3 adds corresponding
> > driver support.
> >
> > Patch #4 adds main HMIBSC board specific bits, features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 2GiB RAM
> > - 64GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> >
> > Patch #5 - #7 enables specific board features like RAUC support,
> > environment protection and USB networking support.
> >
> > This patch series is based on top of Qcom maintainer tree [1] + the latest
> > PMIC patch-set [2]. Feedback is very much welcome.
> >
> > [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
> > [2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322
> >
> > Sumit Garg (7):
> >   clk: apq8016: Add support for UART1 clocks
> >   serial_msm: Add support for RS232 GPIOs
> >   serial_msm: Enable RS232 flow control
> >   board: Add SE HMIBSC board support
> >   hmibsc: Enable RAUC support
> >   hmibsc: enable U-Boot Environment variables protection
> >   hmibsc: Enable LAN75XX USB ethernet driver
> >
> >  arch/arm/dts/Makefile              |   1 +
> >  arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
> >  arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
> >  arch/arm/mach-snapdragon/Kconfig   |  18 +++
> >  arch/arm/mach-snapdragon/Makefile  |   1 +
> >  board/schneider/hmibsc/Kconfig     |  15 +++
> >  board/schneider/hmibsc/MAINTAINERS |   6 +
> >  board/schneider/hmibsc/Makefile    |   5 +
> >  board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
> >  board/schneider/hmibsc/hmibsc.env  |  11 ++
> >  configs/hmibsc_defconfig           |  79 ++++++++++++
> >  drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
> >  drivers/serial/serial_msm.c        |  23 +++-
> >  drivers/usb/host/Kconfig           |   1 +
> >  include/configs/hmibsc.h           |  59 +++++++++
> >  15 files changed, 665 insertions(+), 8 deletions(-)
> >  create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
> >  create mode 100644 arch/arm/dts/hmibsc.dts
> >  create mode 100644 board/schneider/hmibsc/Kconfig
> >  create mode 100644 board/schneider/hmibsc/MAINTAINERS
> >  create mode 100644 board/schneider/hmibsc/Makefile
> >  create mode 100644 board/schneider/hmibsc/hmibsc.c
> >  create mode 100644 board/schneider/hmibsc/hmibsc.env
> >  create mode 100644 configs/hmibsc_defconfig
> >  create mode 100644 include/configs/hmibsc.h
> >
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
