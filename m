Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C26AC47072
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE97C87725;
	Tue, 26 Dec 2023 10:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CisTVVyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79B887800; Tue, 26 Dec 2023 10:28:13 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD2F875BF
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dbb650ad59so2610289a34.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703582889; x=1704187689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oq1rVDFdp5CBOw5nCe4bzCQhhxBaVKfSY2/jdz+ynVY=;
 b=CisTVVyKbu0eR91VLPpukhy2HksbHvYgk2S3HvXiVnKCxPULtWTyFnmYWXROp7vfqO
 +06c92rJXWFGKlbknvo/1edUsQ8PMApc+OhfmBjVOKifX1+n86mv215umC3o5AjFib7Q
 d5t/Uvm4+FlcZNHstMUyMUmHciNleWeMGpW2qSo3Ai1rw5obYASSgdjKzGfQ2pfTyL8L
 kIeRAR90HIEazwwsMqjgdM0/efKrJ10sD44EwdACeWK8tdH7tG9LogqL4P1T4OFci5jd
 TDq5VlXKvWxpiEFEswVpgXrKYo+hyeJdR3gfmUl9XJ3odmRvPHelyLN5bBqqBytV1r0p
 +MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582889; x=1704187689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oq1rVDFdp5CBOw5nCe4bzCQhhxBaVKfSY2/jdz+ynVY=;
 b=o4t72PhlC9ON6+N2BKV2kDHIwb0Nsxzq8JGgBGHNaktKiQzY8LzbPJwA8lW2D/SpUV
 yvGtGVTO1XUxeF2QTWK2CprF8YZakipC7ys0G8zGUg2VsW+BpE+135nOMnSPj1SfGlYA
 JBQI/64QSZd2Vwt/eabI+vIDH7OOV8djfwiZVAdAnTKaCJUcFsDvDflIv4T83y7aPnPm
 KmngH0cQlCxJRUibCPV0x8mGoxrLWH21gEZp3H0chszpP+yS3ZnE2+I3Ne1rL/R+90Fx
 NbgrDFkLnomhvTYjZJowdJkdclbLQnMnyF+x0yuvoKXK5YHx3fpMdrcbs4wMTOn+xVJD
 UtHQ==
X-Gm-Message-State: AOJu0YzpXk9VBRq+7vFPgSo51bwemCY3Il2KhBnkHqQERd9Y7WAf3/QE
 bsYRQBde0+WjHhfS1++Q/UENxeRJD+MNd8bbCfhgWplehWL/Zg==
X-Google-Smtp-Source: AGHT+IGxBUfag5a7FlpjISD90jksp3d/u6G/NOBpTX3lBljfyGadMtLhhLuFjDGG0wzUK5hfX4iR2e4YjyFLAY5Ifk4=
X-Received: by 2002:a05:6358:9141:b0:170:17eb:b3b with SMTP id
 r1-20020a056358914100b0017017eb0b3bmr4628131rwr.37.1703582888637; Tue, 26 Dec
 2023 01:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
 <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
 <65d0c4d7-ba69-4cf8-ae8e-89787f2aa009@linaro.org>
 <CAFA6WYMR6tSvxDZ7Gym=YAhVxpP1dFP1Mie+DmBRYJxMi5yXwA@mail.gmail.com>
 <7f92f220-7d65-48f4-b200-f8b5372d4216@linaro.org>
 <CAFA6WYP918rsAp+FQ-Dyb8f_V1jBSN72CGMEfr4o+VYRtTRF1w@mail.gmail.com>
 <81cffa0a-5f91-40ee-bd43-b6ea009a3f1b@linaro.org>
In-Reply-To: <81cffa0a-5f91-40ee-bd43-b6ea009a3f1b@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 14:57:57 +0530
Message-ID: <CAFA6WYNbheogFQJVGkAKNTb1XfPGRAscrsgqfpRq4NR3JEDZ2A@mail.gmail.com>
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

On Fri, 22 Dec 2023 at 23:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> [snip]
>
> >>>> Sumit, could you rebase this series on my generic board support? [1] in
> >>>> it's current form this series conflicts, and includes some of the major
> >>>> anti-patterns I'm trying to move away from in mach-snapdragon.
> >>>
> >>> Although, I haven't gone through your series but I was expecting those
> >>> conflicts. Let's work together to make this series compatible on top
> >>> of yours.
> >>>
> >>>>
> >>>> You should not have to introduce a new CONFIG_TARGET_XYZ variable, and
> >>>> from what I can tell you shouldn't even need to add the board/schneider
> >>>> directory at all, you can just set the following in your defconfig:
> >>>>
> >>>> CONFIG_SYS_BOARD="dragonboard410c"
> >>>
> >>> This is simply a misnomer, its HMIBSC board. I suppose we should
> >>> rather separate the SoC specific bits into mach-snapdragon and let
> >>> different boards use them.
> >>
> >> Is there any reason why you can't just use the existing db410c board
> >> code as-is? I don't see why you want to duplicate it.
> >
> > I don't want to duplicate it but rather we should make the common
> > parts as part of arch/arm/mach-snapdragon/ and let derivative boards
> > use them. The HMIBSC board is an industrial board which doesn't need
> > any generic distro boot but rather FIT booting with OTA updates via
> > RAUC [1] along with U-boot environment protection. Doesn't that make
> > it different from db410c?
>
> Right, your series does this board specific configuration in the board
> header file (include/configs/hmibsc.h) and in the defconfig.
>
> The actual board code in board/schneider/hmibsc/hmibsc.c is directly
> copied from board/qualcomm/dragonboard410c/dragonboard410c.c with just
> the copyright changed, the serial number code removed, and a style fix
> to a comment. Ignoring for a moment the copyright issue which would
> definitely need to be fixed,

Ah, I should have retained the copyright.

> what I'm suggesting that you do is just use
> the board code from db410c.

This is just initial board support, a direct copy would just limit any
further board support extensions.

>
> The way I have designed the generic board support is so that two similar
> boards can share the same board code but with different config headers,
> from what I can tell this would work just fine for you.

As I have mentioned earlier, the proper way to share code among boards
is to have something like following:

arch/arm/mach-snapdragon/board_apq8016.c

You can take examples from arch/arm/mach-meson/board-*.c. If you don't
want to do it as part of your series then let me know I will include
it in this series.

>
> --- board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ board/schneider/hmibsc/hmibsc.c
> @@ -2,5 +2,5 @@
>  /*
> - * Board init file for Dragonboard 410C
> + * Board init file for SE HMIBSC
>   *
> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> + * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
>   */
> @@ -8,3 +8,2 @@
>  #include <button.h>
> -#include <common.h>
>  #include <cpu_func.h>
> @@ -137,7 +136,2 @@
>  {
> -       char serial[16];
> -
> -       memset(serial, 0, 16);
> -       snprintf(serial, 13, "%x", msm_board_serial());
> -       env_set("serial#", serial);
>         return 0;
> @@ -145,3 +139,4 @@
>
> -/* Fixup of DTB for Linux Kernel
> +/*
> + * Fixup of DTB for Linux Kernel
>   * 1. Fixup installed DRAM.
> @@ -165,3 +160,2 @@
>
> -
>         if (!eth_env_get_enetaddr("btaddr", mac)) {
> @@ -169,5 +163,6 @@
>
> -/* The BD address is same as WLAN MAC address but with
> - * least significant bit flipped.
> - */
> +               /*
> +                * The BD address is same as WLAN MAC address but with
> +                * least significant bit flipped.
> +                */
>                 mac[0] ^= 0x01;
>
> >
> > [1] https://rauc.io/
> >
> >>
> >> The only reason the db410c and db820c have their board code is because
> >> they're old platforms and already supported. For adding new support
> >> there needs to be some very strong justification to have board-specific
> >> C code.
> >>
> >> I think it would be nice to make the db410c code go away, or be toggled
> >> at runtime, probably most of it will just work and not break any other
> >> boards anyway. The db820c code is just part of what should be in the
> >> pinctrl driver...
> >>
> >> Let's move away from this old model and towards having more generic
> >> U-Boot images. This will snowball towards making future bringup even easier.
> >
> > As I have mentioned in the other thread, we should give alternatives
> > to the board code as well. How would you handle the following?
> >
> > - Fastboot mode entry on a button press.
>
> This can be nicely handled through CONFIG_AUTOBOOT. I currently use
> AUTOBOOT_STOP_STR but that's quite limited (only works for the power
> button with "\r"). Probably the right solution here is to use
> CONFIG_AUTOBOOT_USE_MENUKEY and introduce support for
> CONFIG_AUTOBOOT_MENUBUTTON to allow specifying a named button instead of
> an ASCII code. One would then configure "menucmd" in the U-Boot
> environment to launch fastboot.

Won't this break existing users who relied on volume buttons to flash
their board and rather have to purchase a debug uart?

>
> This lets us drop all the weird non-standard keycode handling in board
> code and just configure it in the defconfig instead. I plan to implement
> this eventually but would for sure appreciate it if someone beat me to it.
> > - Configure MAC address for network support.
>
> I believe you mentioned elsewhere some board with the MAC address on an
> i2c EEPROM? The NVMEM framework solves exactly this issue, and U-Boot
> already supports it, just add support to your ethernet driver to
> retrieve its MAC address via NVMEM.

Good to know that.

> > - Setup board serial number.
>
> Same as above, the quick and dirty way to go would be to have
> mach-snapdragon check for an alias defined in DT and expect that alias
> to be an NVMEM cell which contains the serial number. On the Android
> phones this is set in the kernel cmdline from ABL so I would probably
> add some code to mach-snapdragon to check the bootargs for one.

And what about boards where U-Boot starts as the first stage
boot-loader? Is there corresponding DT binding?

>
> >
> > I suppose we don't need #ifdefry in the
> > arch/arm/mach-snapdragon/board.c file, right?
>
> Nope, we aren't that limited on code size, and the runtime overhead of a
> few extra branches is really not significant. If we do need to start
> caring about either of those things then I would rather do this on a
> per-feature basis than per-board.

The examples I gave were only limited to what are currently used by
Qcom boards. But we should be open to future board support extensions
too.

> >
> >>>
> >>>> CONFIG_SYS_CONFIG_NAME="hmibsc"
> >>>>
> >>>> This will use the db410c board code (which yours is just a copy/paste of
> >>>> from what I can tell) and your custom include/configs/hmibsc.h header.
> >>>>
> >>>> The addresses set in your environment file should be allocated
> >>>> automatically at runtime too (see the ("mach-snapdragon: dynamic load
> >>>> addresses") patch).
> >>>>
> >>>> You should also switch to an upstream board DTS based on my series, and
> >>>> drop the "-uboot.dtsi" file.
> >>>
> >>> Unfortunately, currently there isn't any upstream DTS for this board
> >>> but I will check with the SE team regarding their plans. Until then we
> >>> have to use a U-Boot specific DTS file.
> >>
> >> In that case, perhaps we can take whatever DTS they're using in
> >> production, or a version of it, and at least split the U-Boot changes
> >> (if any) out into a separate file as I've done with the other platforms.
> >> This way we stay consistent and can keep track of what U-Boot specific
> >> DTS changes we need.
> >
> > The first step for that is to land that DTS file upstream in the Linux
> > kernel and then we should make a switch. The middle ground here won't
> > be maintainable.
> >
> >>
> >> I guess this is all new territory for us, but imho if we're adding
> >> support for a board that doesn't have an upstream DTS, we should still
> >> follow the same model, open to input here.
> >
> > With the DT rebasing tree, we actually want to make these bits clear.
> > Either the board support is fully upstream and then we make a switch
> > to upstream or you can have a u-boot specific DTS subset compliant
> > with upstream bindings while upstreaming is in progress. There is
> > always ABI risk involved for using half baked board DTS files.
>
> The DTS file submitted in your series is a copy paste of
> dragonboard410c.dts with the serial port adjusted, the LEDs removed, and
> the copyright changed...
>
> This will make it the only board still using the totally made up DTS
> style that all the Qualcomm boards used to use, while everything else is
> standardised on upstream (meaning they #include the SoC and PMIC dtsi
> files).
>
> It doesn't make a difference whether you put the board DT in dt-rebasing
> or if it just goes in U-Boot, it should be a DT derived from upstream
> not some hand-crafted thing which will never be supported. Just copy
> apq8016-sbc.dts when rebasing on my series and it will be fine.

The major bit that I was concerned about previously is if people start
to pass that u-boot specific DT to the kernel directly. But with
dt-rebasing at least we can distinguish among them. So I am fine to
use the format that you have described.

>
> That said, as I'm writing this I've realised that the pinctrl-apq8016
> driver is missing a patch to use the upstream GPIO naming. I'll fix this
> in the next revision of the qualcomm generic support series, but just a
> heads up if you run into that.

Good to know.

-Sumit
