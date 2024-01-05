Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AADC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5FE876C4;
	Fri,  5 Jan 2024 14:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KNy4M3VU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53A586758; Fri,  5 Jan 2024 14:53:47 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BCE08798D
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 14:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7cd814fc6b3so527480241.1
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704462820; x=1705067620; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JFUDyxHWGX19F6viN8tbG90LopJjI22hvpi92RO2II8=;
 b=KNy4M3VUHQUC3s1OScO+P98tdBSd52OrV5qSiVrpFpAG4Vb98ajWkv6/oRKW+a/AA9
 G0g6B0woUxq8LbgiVr2gFwoRpb4KC3Z5cwrwIcvS5gU5NpgdaXv7oCMAZVvMErn8suew
 6JgtRQgUzCJHQF9oY+6EuLhRKv4EoP5B8OvZADIiyjGqO1mtjG3unEjfCvg3B767zlWz
 F9QOdw7d/0auAkJAoMkqU5E9Jw6yMcgNtxQSCE324wx2i4/YqmiIUVDQC+XU/Vj8BgVq
 lOba6NM165GuqQf3O/xsyNssmbXD9vZuTkRZ/WiFQ9iXGC9Fn2f99sFst2EeH5mlae+G
 +dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704462820; x=1705067620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFUDyxHWGX19F6viN8tbG90LopJjI22hvpi92RO2II8=;
 b=UMBfu2rf3T156HQmu1q1i/AgQ15tFT8fpy8JNsiw8X9/nyYSJrWIHCj+tLr53uW1Ez
 RdBL929FwDE8vqy5CUSkdZEwIZ8e1i2jpHKpMiYebXm5T9FeJKGB4PGW/ocqXuoqBcix
 wFq5rQdiNOH8KXWqDGMOTz3jwtr2uBxWqGZst642J7RTM3PIJPqiFG+T1tCO+vn9eRKZ
 Gk0rRszibyNLF1Wh3VK3dfLJM1T5k0PpHocrkvg8EIhGTERCZmyd8ZtYeITBS3urlfe1
 ZKfIzYGF1ri8Fr4pNRWHumFgmB/qkSFEhmQJ3kOi+XPbF2FjOQlEqQRZtW38Y8k4bJrr
 4VKw==
X-Gm-Message-State: AOJu0YwLz8HIBfu/vwQcxwCV8X+2j/XsssUH+RoGelzFPk86ZRRctr7H
 U1gRzroeno1O45nafb1tjOZoN9FAwnwwlagWSBDYgYaxapfoxQ==
X-Google-Smtp-Source: AGHT+IEQvO/+RBXyiaeMLtdqjzyMldf8rvMQsdLMICOYJNLwwdeK6n9gQf5NsmTpohGe3+TgvbJvxGPOVR+A4M6Sees=
X-Received: by 2002:a05:6102:dd3:b0:467:4ee9:fd71 with SMTP id
 e19-20020a0561020dd300b004674ee9fd71mr1706919vst.16.1704462820058; Fri, 05
 Jan 2024 05:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20240103130716.4144892-1-sumit.garg@linaro.org>
 <54d8ea1e-546a-4915-af77-b7c4e4954a8a@linaro.org>
In-Reply-To: <54d8ea1e-546a-4915-af77-b7c4e4954a8a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 5 Jan 2024 19:23:28 +0530
Message-ID: <CAFA6WYOoC+u=ya-P3xqGUkS7anFhYpVzKEKaMFLaoj96LT4SEg@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, neil.armstrong@linaro.org, 
 rfried.dev@gmail.com, dsankouski@gmail.com, seanga2@gmail.com, marex@denx.de, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
 u-boot@lists.denx.de
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

On Thu, 4 Jan 2024 at 18:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 03/01/2024 13:07, Sumit Garg wrote:
> > In order to avoid duplication of APQ8016 derived boards specific code,
> > move common bits like USB pinctrl and fastboot to board-apq8016.c file.
> > This will allow future board support like SE HMIBSC board etc to reuse it.
>
> You still haven't demonstrated a justification for having the HMIBSD
> board NOT simply point to board/qualcomm/dragonboard410c. Do you have a
> branch with additional features where it clearly makes sense to have a
> separate board directory?

Were you able to share any prior art in U-Boot tree regarding the way
you want to force different boards to use the exact same board
directory? I have already given you the Amlogic example and Tom has
pointed to the TI example to show that the path followed by this patch
is the common path for board code re-use.

> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > This patch is based on Caleb's Qcom common target branch [1]. As per
> > Caleb's comments here [2], there is no scope for people to add board
> > code for new board support. And even people can't reuse existing board
> > code like for db410c for further new board support but rather they have
> > to make db410c generic first.
> >
> > I fear this would be couter productive and motivate OEM vendors (which
> > aren't Qcom reference designs) to keep their board support code
> > downstream.
>
> This is the same argument made by those defending mach-* code in Linux.
> What I'm advocating for here is that we spend just a little more time
> doing things right, so that when the next vendor, or next gen board
> comes along we aren't copy/pasting board files.

I thought you were aware that there is still arch/arm/mach-* code in
Linux. And I am not aware that the stance taken by Linux maintainers
was to *not* allow new board support if they just reused existing
machine code. Your stance is just unique in this case which I haven't
heard from any other U-Boot maintainer. I am afraid it is going to be
counter productive for the U-Boot Qcom ecosystem.

>
> > IMO, the approach should be to allow board code reuse which
> > this patch is all about.
>
> Board code reuse is exactly what I want, just that we do our due
> diligence in not blindly putting code behind arbitrary compile-time
> configuration.

See the existing U-Boot practice for how to share board code.

>
> > The next steps should be to make the underlying
> > board features to rather come from DT but that as you know requires
> > bindings to be accepted first.
>
> We can have non-standard DT if we *need* to, I would prefer that over
> this board code because then there's at least an obvious path forwards.

No please, DT shouldn't be considered to be owned by U-Boot. So just
for generalization purposes non-bindings compatible bits shouldn't be
added to DT as a quick solution. Currently we allow *-u-boot.dtsi to
be a stop gap solution for DT bits that are still pending for upstream
bindings acceptance.

> In fact this is exactly what the below USB role switching code does, I
> already put the work in to make it generic (before it literally found
> the GPIO device and set specific GPIO pins).
>
> Below I have outlined the changes that would be necessary to have the
> functionality here built in for all mach-snapdragon boards, so this
> whole SOC_APQ8016 thing can be dropped. It's ridiculous to gate this
> code behind a particular SoC when none of it is SoC specific.
>
> >
> > Tom, Simon,
> >
> > Is there any U-Boot policy in regards to board code going forward? Are
> > we moving in a direction to get rid of most board specific stubs from
> > generic U-Boot code?
> >
> > [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/b4%2Fqcom-common-target
> > [2] https://lore.kernel.org/all/824be245-60c9-4a1a-a386-be765e8eba91@linaro.org/
> >
> >  arch/arm/mach-snapdragon/Kconfig              |  5 ++
> >  arch/arm/mach-snapdragon/Makefile             |  1 +
> >  arch/arm/mach-snapdragon/board-apq8016.c      | 64 +++++++++++++++++++
> >  .../dragonboard410c/dragonboard410c.c         | 62 ------------------
> >  configs/dragonboard410c_defconfig             |  1 +
> >  5 files changed, 71 insertions(+), 62 deletions(-)
> >  create mode 100644 arch/arm/mach-snapdragon/board-apq8016.c
> >
> > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> > index 96e44e2c549..8069a89bf78 100644
> > --- a/arch/arm/mach-snapdragon/Kconfig
> > +++ b/arch/arm/mach-snapdragon/Kconfig
> > @@ -3,6 +3,11 @@ if ARCH_SNAPDRAGON
> >  config SYS_SOC
> >       default "snapdragon"
> >
> > +config SOC_APQ8016
> > +     bool "APQ8016"
> > +     help
> > +       Select this if your SoC is an APQ8016
> > +
> >  config SYS_VENDOR
> >       default "qualcomm"
> >
> > diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> > index 857171e593d..7d210e6d872 100644
> > --- a/arch/arm/mach-snapdragon/Makefile
> > +++ b/arch/arm/mach-snapdragon/Makefile
> > @@ -3,3 +3,4 @@
> >  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> >
> >  obj-y += board.o
> > +obj-$(CONFIG_SOC_APQ8016) += board-apq8016.o
> > diff --git a/arch/arm/mach-snapdragon/board-apq8016.c b/arch/arm/mach-snapdragon/board-apq8016.c
> > new file mode 100644
> > index 00000000000..bb9a3a9f0fb
> > --- /dev/null
> > +++ b/arch/arm/mach-snapdragon/board-apq8016.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Board init file for APQ8016 SoC derived boards
> > + *
> > + * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> > + */
> > +
> > +#include <button.h>
> > +#include <dm.h>
> > +#include <dm/pinctrl.h>
> > +#include <env.h>
> > +#include <init.h>
> > +#include <usb.h>
> > +#include <fdt_support.h>
> > +
> > +int board_usb_init(int index, enum usb_init_type init)
>
> This function can trivially be made generic, in such a way that it could
> be done for all mach-snapdragon devices:
> > +{
> > +     struct udevice *usb;
> > +     int ret = 0;
> > +
> > +     /* USB device */
> > +     ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
>
> Instead do:
>         ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
> > +     if (ret) {
> > +             printf("Cannot find USB device\n");
> > +             return ret;
> > +     }
>
> Here we must check to see if the "device" pinctrl exists, use this as a
> litmus test to see if this board needs pinctrl state changes
>
>         ret = dev_read_stringlist_search(usb, "pinctrl-names",
>                                          "device");
>         /* No "device" pinctrl state, so just bail */
>         if (ret < 0)
>                 return 0;

Okay, I think I can try to make it generic as you want here since USB
is an essential feature for the HMIBSC board too. But I can't test it
since your series is broken for db410c, will wait for the next rev.

> > +
> > +     /* Select "default" or "device" pinctrl */
> > +     switch (init) {
> > +     case USB_INIT_HOST:
> > +             pinctrl_select_state(usb, "default");
> > +             break;
> > +     case USB_INIT_DEVICE:
> > +             pinctrl_select_state(usb, "device");
> > +             break;
> > +     default:
> > +             debug("Unknown usb_init_type %d\n", init);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Check for vol- button - if pressed - stop autoboot */
> > +int misc_init_r(void)
>
> As I said before, this code only exists because U-Boot's "autoboot"
> implementation hasn't been updated with good button support, this is
> also a fairly simple fix and would benefit all the boards, not just
> Qualcomm.

I would suggest you go through how "preboot" is used in the U-Boot
tree. It's not that everyone would like to switch to fastboot on a
volume button press. So the solution has to be commonly agreed among
the U-Boot community.

>
> If you really don't have the time of experience to implement such a
> feature, and this is really such a blocker for your board support, then
> that is a totally different class of issue which we can find a solution to.

And you just want to block new board support until a common U-Boot
feature is implemented and accepted. Let me drop this feature from the
new board support series for now.

-Sumit

> > +{
> > +     struct udevice *btn;
> > +     int ret;
> > +     enum button_state_t state;
> > +
> > +     ret = button_get_by_label("vol_down", &btn);
> > +     if (ret < 0) {
> > +             printf("Couldn't find power button!\n");
> > +             return ret;
> > +     }
> > +
> > +     state = button_get_state(btn);
> > +     if (state == BUTTON_ON) {
> > +             env_set("preboot", "setenv preboot; fastboot 0");
> > +             printf("vol_down pressed - Starting fastboot.\n");
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> > index 2a502c7c284..f7c6a6cbc0a 100644
> > --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> > +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> > @@ -5,78 +5,16 @@
> >   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> >   */
> >
> > -#include <button.h>
> >  #include <common.h>
> > -#include <cpu_func.h>
> >  #include <dm.h>
> > -#include <dm/pinctrl.h>
> >  #include <env.h>
> >  #include <init.h>
> >  #include <net.h>
> > -#include <usb.h>
> > -#include <asm/cache.h>
> > -#include <asm/global_data.h>
> > -#include <asm/gpio.h>
> >  #include <fdt_support.h>
> >  #include <linux/delay.h>
> >
> >  #include "misc.h"
> >
> > -DECLARE_GLOBAL_DATA_PTR;
> > -
> > -#define USB_HUB_RESET_GPIO 2
> > -#define USB_SW_SELECT_GPIO 3
> > -
> > -int board_usb_init(int index, enum usb_init_type init)
> > -{
> > -     struct udevice *usb;
> > -     int ret = 0;
> > -
> > -     /* USB device */
> > -     ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
> > -     if (ret) {
> > -             printf("Cannot find USB device\n");
> > -             return ret;
> > -     }
> > -
> > -     /* Select "default" or "device" pinctrl */
> > -     switch (init) {
> > -     case USB_INIT_HOST:
> > -             pinctrl_select_state(usb, "default");
> > -             break;
> > -     case USB_INIT_DEVICE:
> > -             pinctrl_select_state(usb, "device");
> > -             break;
> > -     default:
> > -             debug("Unknown usb_init_type %d\n", init);
> > -             break;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -/* Check for vol- button - if pressed - stop autoboot */
> > -int misc_init_r(void)
> > -{
> > -     struct udevice *btn;
> > -     int ret;
> > -     enum button_state_t state;
> > -
> > -     ret = button_get_by_label("vol_down", &btn);
> > -     if (ret < 0) {
> > -             printf("Couldn't find power button!\n");
> > -             return ret;
> > -     }
> > -
> > -     state = button_get_state(btn);
> > -     if (state == BUTTON_ON) {
> > -             env_set("preboot", "setenv preboot; fastboot 0");
> > -             printf("vol_down pressed - Starting fastboot.\n");
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  int qcom_late_init(void)
> >  {
> >       char serial[16];
> > diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> > index 453cb9d04c7..23024066f82 100644
> > --- a/configs/dragonboard410c_defconfig
> > +++ b/configs/dragonboard410c_defconfig
> > @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="dragonboard410c"
> >  CONFIG_COUNTER_FREQUENCY=19000000
> >  CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> >  CONFIG_ARCH_SNAPDRAGON=y
> > +CONFIG_SOC_APQ8016=y
> >  CONFIG_TEXT_BASE=0x8f600000
> >  CONFIG_SYS_MALLOC_LEN=0x802000
> >  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>
> --
> // Caleb (they/them)
