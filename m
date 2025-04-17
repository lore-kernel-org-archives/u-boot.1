Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130F8C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4391C82DB8;
	Thu, 17 Apr 2025 23:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHRcN91g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A96282E8E; Thu, 17 Apr 2025 23:35:59 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE60782CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so237584266b.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925756; x=1745530556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QCGibdLoe6tVXugKe2uXrK67W9I5Zp6XMqLW086Bc9M=;
 b=JHRcN91gFKD6Vv6Ghkw+NLgu0HBqxINX9N16V699oFTEJznboPWY0pYyl7kd1ApGgn
 nz376StiwfVCwhnJtejE65N2rGiBQ4CLy33gGF3jQnCW76QJ6hMsecYedyKx40bJzsL4
 tbK73SgLaDTeCfd5iyqkHntYHetCr6CK3tj7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925756; x=1745530556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QCGibdLoe6tVXugKe2uXrK67W9I5Zp6XMqLW086Bc9M=;
 b=jMfQLhHlOfnvp5UJDjrCl9EpCWOqhztuWxhhgvCi63cz7n9chgW4ksY4IUNGcnMGxQ
 7oivaCOG5DNUj3kURVvD2qxdFAOPezs3v2BSrbHl8LQ4vsL1Di0S1OFcO1Z7lMUf60NF
 CUEweV1CUZKi31/Rw5pcLnifOCqVLKpAaD9A9Kamy4Euece1fptRL4cqWrLjLewnRsvj
 tdED7NLFSv0XLtG6+Kcl2nskT6mePGeWpnVQsjZlHcJQBHLvxICG93UcK2qGlcWms0l2
 BpGQHCaXVnEuFIjBhPv1lQu2tJmFqwECVjA6cSdQd43AGTcqoCDpTygmW4+3QF3/rwCr
 VyrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoHVsYopAvo98lvyAKg+CmLlB4HZFinZuZlN2wfeqd/TxU9rVQXIRe9hvrItn2Srb5J1+xUyM=@lists.denx.de
X-Gm-Message-State: AOJu0YxutwMb4Lp25voCAAXjxbmKeosZQrS4RnQJuNLcCRDo9yrNTjEV
 D4hiJ/SEM2ZixpWFgWJfB5WfzD2p3MnDpSiPyGVW8VN1Snay0lTGh0qkm0900AzfBleUTqlcSx1
 Xpr5/pyLXEtg7yq0tGPoP1Ky1rg6ZkndOGW0e
X-Gm-Gg: ASbGncva/R88Fqvkqc3ZhwH2CfT3XrkDiUCj0Mh7Dg4GkDlXPKhxdXsn6asSkmoENCv
 A0g5J3y9Aq+aMWpl47rwicFtIBAhvzU2+J1NMZbI277QFvIJKIH6BSrGeaOh/oxNwfQdu31ZBv1
 Z40bnZP94kwMi36x+oPg4uzUw=
X-Google-Smtp-Source: AGHT+IHrxqTiZquFEMGMTG3VST6cbABrVtTP5NVq+o4/ZZ2/QBeDb9mDJ6jt8SdKPkVTQDTKy1AYW2qOnOQb4mA6kwU=
X-Received: by 2002:a17:907:2d0b:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-acb74e75fcbmr24388266b.59.1744925756233; Thu, 17 Apr 2025
 14:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250405190711.365419-1-sjg@chromium.org>
 <82103ca6-0e9c-4f4a-bfbf-547d1c06d976@gmx.de>
In-Reply-To: <82103ca6-0e9c-4f4a-bfbf-547d1c06d976@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:35:44 -0600
X-Gm-Features: ATxdqUF_PEmbQgiW1tlsWlDeUPylhR1c8K2VzWVOoaAj43anUBNZgyXMvLPV1qM
Message-ID: <CAFLszTg4xR0xsUj3i0ibauaKvS1+hPYCOf3sMeF4GFX5Ukf3Jw@mail.gmail.com>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Phelps <andrew.phelps@canonical.com>, Alexander Graf <agraf@csgraf.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sumit Garg <sumit.garg@linaro.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, 15 Apr 2025 at 23:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/5/25 21:07, Simon Glass wrote:
> > At present it is impossible to change the qemu_arm64 defconfig to
> > obtain a devicetree from the U-Boot build.
> >
> > This is necessary for FIT validation, for example, where the signature
> > node must be compiled into U-Boot.
>
> This description looks wrong:
>
> Signatures are in FIT images.
>
> Only public keys to validate the signatures should be compiled into U-Boot.
>
> >
> > A proposed change to QEMU to allow device tree additions has been
> > blocked for several years. The only known workaround is to use QEMU's
> > dumpdtb option, merge in the signature node manually, disable
> > OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> > complicated enough that it is documented in U-Boot[1].
>
> This seems to relate to
> [PATCH] hw/arm/virt: Allow additions to the generated device tree
> https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/
>
> As your describe in [1] QEMU already provides a -dtb parameter if you
> want a crafted device-tree. Your proposed change is confounding boot
> stages and and would not provide value to the QEMU project. It was
> therefore rejected for good.
>
> It remains unclear why you would disable OF_HAS_PRIOR_STAGE if you were
> using QEMU's -dtb parameter.
>
> What would be the benefit of compiling the DT into U-Boot instead of
> providing it via the -dtb parameter?

It is helpful when testing things in U-Boot, e.g. FIT validation.

>
> >
> > Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> > to hack the Kconfig.
> >
> > Add a new QEMU_MANUAL_DTB Kconfig option which makes OF_HAS_PRIOR_STAGE
> > optional, thus avoiding needing to patch U-Boot to get this working.
> >
> > This seems a clearer solution than just making OF_HAS_PRIOR_STAGE
> > visible, since that symbol is intended to be set automatically by each
> > platform.
>
> To me the new parameter is harder to use than simply making
> CONFIG_OF_HAS_PRIOR_STAGE always editable.
>
> >
> > [1] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
>
> The instructions that you provide in [1] are incorrect.
>
> "qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb"
>
> The second machine statement overrides the first one. And the second one
> will use the default machine which for instance on riscv64 is not virt.
>
> The correct invocation to download the device-tree would be:
>
> qemu-system-arm -M virt,dumpdtb=qemudtb

I didn't actually send that code in this patch, but please do a patch
if you have time.

>
>
> > Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > Changes in v2:
> > - Add a new QEMU-specific Kconfig instead
> >
> >   arch/arm/Kconfig                   |  2 +-
> >   board/emulation/common/Kconfig     | 12 ++++++++++++
> >   doc/develop/devicetree/dt_qemu.rst |  5 +++++
> >   dts/Kconfig                        |  9 +++++++--
>
> This patch lacks proper documentation in doc/

OK I'll add something.

>
> >   4 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index db8758e6dfe..b55ed61894a 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1055,7 +1055,7 @@ config ARCH_QEMU
> >       imply DM_RNG
> >       imply DM_RTC
> >       imply RTC_PL031
> > -     imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> > +     imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA && !QEMU_MANUAL_DTB
> >       imply VIDEO
> >       imply VIDEO_BOCHS
> >       imply SYS_WHITE_ON_BLACK
> > diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kconfig
> > index 4c15c8bcb89..3f9a6ea578f 100644
> > --- a/board/emulation/common/Kconfig
> > +++ b/board/emulation/common/Kconfig
> > @@ -13,3 +13,15 @@ config MTDPARTS_NOR1
> >       help
> >         This define the partition of nor1 used to build mtparts dynamically
> >         for the u-boot env stored on nor1.
> > +
> > +config QEMU_MANUAL_DTB
> > +     bool "Manually provide a device tree to QEMU"
> > +     help
> > +       For some use cases, such as FIT validation where a public key must be
> > +       placed in U-Boot's device tree, we need to override the device tree
> > +       that QEMU would normally provide to us.
> > +
> > +       Note: this work-around is necessary since Linaro has blocked
> > +       addition of a feature to support additions to the QEMU devicetree:
> > +
> > +         Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> > diff --git a/doc/develop/devicetree/dt_qemu.rst b/doc/develop/devicetree/dt_qemu.rst
> > index 8ba2b225590..c693b49d3d4 100644
> > --- a/doc/develop/devicetree/dt_qemu.rst
> > +++ b/doc/develop/devicetree/dt_qemu.rst
> > @@ -46,3 +46,8 @@ You can then run qemu with the merged devicetree, e.g.::
> >
> >   Note that there seems to be a bug in some versions of qemu where the output of
> >   dumpdtb does not quite match what is provided to U-Boot.
> > +
> > +See also the
> > +`rejected QEMU patch <https://patchwork.kernel.org/project/qemu-devel/patch/20231117021840.117874-1-sjg@chromium.org>`_
> > +and
> > +`discussion <https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org>`_.
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 2e88d210bb8..53f7e246a80 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
> >         development purposes, but it is not recommended, and likely will not
> >         even work, for production systems.
> >
> > -       Note: This option must be set in Kconfig and cannot be enabled or
> > -       disabled in the board's defconfig file.
> > +       Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB thus
>
> %s/usiing/using/

Will fix.


>
> Best regards
>
> Heinrich
>
> > +       allowing QEMU to support FIT validation, where the devicetree must
> > +       include a public key.
> > +
> > +       See also this for context:
> > +
> > +       https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> >
> >   config OF_OMIT_DTB
> >       bool "Omit the device tree output when building"
>
