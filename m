Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E7CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 09:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCE88804B;
	Mon,  8 Apr 2024 11:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kaSluC1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AAF88060; Mon,  8 Apr 2024 11:13:32 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1838F8804B
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 11:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7e6e0693df5so201629241.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712567609; x=1713172409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A1Tfvqb3VBjGG3iUaBc3XEjU3xPMzmDddfL1TGMcm8Q=;
 b=kaSluC1R5M2XSfmlI+NkGRvx3Z9iKk/x+V+nVwvWj4F0GBfDmkXsHvbI6HvspKIdWS
 FWOgIwli7PMaP9qDxlDTB+kvr+2TYbkOnSG1VCX3k0xJ6QVTzplGmC/4aUTBOmpGNg9B
 pJVNewvU4U+WN+suBmN7amWqHZKbbX4J6VMpPnq4EXo5wCgMz0lJ32kycP2h5PXhNu9M
 3F3k7ejLbYFurvF/q33/ONja0VI5/w/60gQ/30bcg28KncA9WQriutwoNZUCtBSO38Tr
 Hn3Y8GRCXEPcJ8oIymzibn9pq4Bl37pgHkpOGdVu48Z/xW/kaUnS7Xi0RtLh3SvKmPCk
 HYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712567609; x=1713172409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1Tfvqb3VBjGG3iUaBc3XEjU3xPMzmDddfL1TGMcm8Q=;
 b=F/8HlLlKzqwwgY/QMiLRlQQbwekRZK9Vik4XeG/BY7557jqjXS3DEBSt5jmrk62Q+b
 QPgv94I+O9GKJBXvbVjzktJZmLQQNC7An+4CXfps5uRBiV9G//kOIus8piz8cS1FS+CK
 3cbIwSwrddIIp+MSCr4HAZ5FTR7yvV012oiCaMWm+q4J+3dT/gfv78+Mf7xpLhCcJ12e
 fa4c0XChC6Y/bdClkwlD5W29YDx+rS9/ylDzPHxpfJWx4hOwD1v2s/jGBVeztV8owjfc
 5Upzt7hRbnishU5Ht1MOatTUVPYQd/XDDNWIyJgR1PHHmaZO2IeroiMaxu/ghE27bb+a
 zj1Q==
X-Gm-Message-State: AOJu0YwbxIeFwKPzEKZAU4iJoIC2iQT5Q1jTzzt+uanom5HpyKvENWIX
 B1/ub3IH8OmwRGe84QMN/NzLeyAGWiDVvMezsFw6MDkf18gizd20uh73TEkhIScbZwXTnPU9qC8
 ZW+3DRmkZidntOiy6AI5av9L5k1CYKPoOCsxrrg==
X-Google-Smtp-Source: AGHT+IETSYDyjP0IKD9G4CJUPxcmeKoPdFimuU1yMtMj3PPIIK6ACa9BIJas7aODxkKB8Scc/8ZTezSRhNYyi5wFETw=
X-Received: by 2002:a05:6102:4426:b0:479:fd7a:655f with SMTP id
 df38-20020a056102442600b00479fd7a655fmr1825062vsb.4.1712567608790; Mon, 08
 Apr 2024 02:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
 <20240405090742.4148304-7-sumit.garg@linaro.org>
 <ZhAOtg6dmD_rBaO4@gerhold.net>
In-Reply-To: <ZhAOtg6dmD_rBaO4@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 8 Apr 2024 14:43:17 +0530
Message-ID: <CAFA6WYOr06N0re===10E8OWo0TUa-umLZCWpsNwQVndFq8Vn-g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] board: add support for Schneider HMIBSC board
To: Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

On Fri, 5 Apr 2024 at 20:16, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Fri, Apr 05, 2024 at 02:37:42PM +0530, Sumit Garg wrote:
> > Support for Schneider Electric HMIBSC. Features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 2GiB RAM
> > - 64GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> >
> > Features enabled in U-Boot:
> > - RAUC updates
> > - Environment protection
> > - USB based ethernet adaptors
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I don't think this is a big deal but this patch would be a bit easier to
> skim over if you move the (unmodified?) import of the Linux
> apq8016-schneider-hmibsc.dts to a separate patch with a clear note in
> the commit message
>
>  - where it comes from (link to Linux patch), and
>  - that it can be removed again with a future update of the upstream DTs
>    in U-Boot (once it is applied upstream at least).
>
> You kind of have that information in the cover letter but I think it
> would be good to have it in the commit message.

Although the general practice in U-Boot is to have the board DTS file
submitted along with board code, if it makes review easier via
separating the unmodified import of the board DTS file then I can do
that.

>
> > ---
> >  arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
> >  board/schneider/hmibsc/MAINTAINERS        |   6 +
> >  configs/hmibsc_defconfig                  |  86 ++++
> >  doc/board/index.rst                       |   1 +
> >  doc/board/schneider/hmibsc.rst            |  45 ++
> >  doc/board/schneider/index.rst             |   9 +
> >  include/configs/hmibsc.h                  |  57 +++
> >  7 files changed, 695 insertions(+)
> >  create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts
> >  create mode 100644 board/schneider/hmibsc/MAINTAINERS
> >  create mode 100644 configs/hmibsc_defconfig
> >  create mode 100644 doc/board/schneider/hmibsc.rst
> >  create mode 100644 doc/board/schneider/index.rst
> >  create mode 100644 include/configs/hmibsc.h
> >
> > [...]
> > diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
> > new file mode 100644
> > index 00000000000..66dfa549ce1
> > --- /dev/null
> > +++ b/include/configs/hmibsc.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Board configuration file for HMIBSC
> > + *
> > + * (C) Copyright 2024 Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#ifndef __CONFIGS_HMIBSC_H
> > +#define __CONFIGS_HMIBSC_H
> > +
> > +/* PHY needs a longer aneg time */
> > +#define PHY_ANEG_TIMEOUT             8000
> > +
> > +#define HMIBSC_BOOTCOMMAND \
> > +     "setenv devtype mmc; setenv devnum 0; " \
> > +     "test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
> > +     "test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
> > +     "test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
> > +     "setenv raucslot; " \
> > +     "for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
> > +     "  if test \"x${raucslot}\" != \"x\"; then " \
> > +     "      echo \"skip remaining slots...\"; " \
> > +     "  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
> > +     "    if test ${BOOT_A_LEFT} -gt 0; then " \
> > +     "      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
> > +     "      echo \"Found valid RAUC slot A\"; " \
> > +     "      setenv raucslot \"rauc.slot=A\"; " \
> > +     "      setenv raucpart A; setenv distro_bootpart 6;" \
> > +     "    fi; " \
> > +     "  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
> > +     "    if test ${BOOT_B_LEFT} -gt 0; then " \
> > +     "      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
> > +     "      echo \"Found valid RAUC slot B\"; " \
> > +     "      setenv raucslot \"rauc.slot=B\"; " \
> > +     "      setenv raucpart B; setenv distro_bootpart 7;" \
> > +     "    fi; " \
> > +     "  fi; " \
> > +     "done; " \
> > +     "if test -n \"${raucslot}\"; then " \
> > +     "  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
> > +     "  saveenv; " \
> > +     "else " \
> > +     "  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
> > +     "  setenv BOOT_A_LEFT 3; " \
> > +     "  setenv BOOT_B_LEFT 3; " \
> > +     "  saveenv; " \
> > +     "  reset; " \
> > +     "fi; " \
> > +     "load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
> > +
> > +#define CFG_EXTRA_ENV_SETTINGS \
> > +     "loadaddr=0x90000000\0" \
> > +     "bootcmd="      HMIBSC_BOOTCOMMAND              "\0"
> > +
>
> The "text-based environment" [1] is preferred nowadays, i.e. defining
> these inside board/schneider/hmibsc/hmibsc.env instead (similar to how
> DB410c has its environment defined in
> board/qualcomm/dragonboard410c/dragonboard410c.env). This should also
> avoid all the crazy escaping to encode it as C string. :D

That makes sense, I will convert to that.

>
> However, I suspect that right now it would attempt to load this file
> from board/qualcomm/hmibsc/hmibsc.env since you do not seem to have
> CONFIG_SYS_VENDOR set correctly. It looks like Caleb removed the option
> to customize CONFIG_SYS_VENDOR in commit 059d526af312 ("mach-snapdragon:
> generalise board support"). It might be easiest to add a prompt in
> arch/arm/mach-snapdragon/Kconfig to allow changing it (similar to
> CONFIG_SYS_BOARD).

Although the restriction for Qualcomm being the only vendor for boards
based on snapdragon SoCs shouldn't be added in the first place but
since that patch did a lot of things in one go made its review harder.
However, we can always fix it which I will do for the next version.

-Sumit

>
> Thanks,
> Stephan
>
> [1]: https://docs.u-boot.org/en/latest/usage/environment.html#text-based-environment
