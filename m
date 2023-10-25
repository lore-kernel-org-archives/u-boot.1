Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D556C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E4B87259;
	Wed, 25 Oct 2023 15:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X58o5hh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B7A879F5; Wed, 25 Oct 2023 15:22:29 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C371F8700F
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so79515651fa.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698240147; x=1698844947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+zRgA21ZdBAyjX/3uOjbeIJBZfGOWMcK/4UERYtvyRw=;
 b=X58o5hh9CDbjZ0QorIbepUHa0AKGL+WlZzfK+0WJJ2IlLathqKSp56dVJLzfok1Wlq
 BiYmfBhzkcQVMFyC3YVVpFT7YzUVXWMXhJ08Ks2NLyeNf/ZpEUwOWfguUScu/bhtll7m
 G1K6QxgMl1zQo/e54z9hKpIo/EdHWqAUstqTNydTpDoKuHYye6Fxo7akZonTVGMtG1B8
 fD9KocRYhogUNG8V3pzlen1r3XpXtt3einLwdrCzvr6/SX7L8KB+agRY+OZkxgzPrPBh
 V42lgP/2RnJLSJr67zGNJ2CdQRqHmWIe+4xsXYIdQr7d/NIsEVnBIjPBelBSLRIG+0eG
 EdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698240147; x=1698844947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zRgA21ZdBAyjX/3uOjbeIJBZfGOWMcK/4UERYtvyRw=;
 b=HR1Axkg9K4F/gTprTZpYxtRZCoWlYq6jxvELWvfMw7NHRgpj7QNvW+UUZDn46e/EVd
 DACDI3J3calfrPtmLNyadZf+BmvG2ucF1CyhvyFlC8YJwV1IaCpLEnGvz+jSZeAnC5xh
 DjCJQpTQlend7bmFZOZETrGe4YX+vix/xAHU1B8smeXoOkM/6U8mrMY9Qn3lRQOLXrtA
 IKplufriw7HrKC2c+PUMMqHUAzcIH7g+qXar7rYayZxgcP5tngFSfiIGi0McbjxrK1pd
 lpGUWxVn8R21zaUten64xDriEPgacWAzVgYEyddK5kMaCR2WNP3uRbNF7H8DKCgtAW4X
 Gr0A==
X-Gm-Message-State: AOJu0YwYOrBwQNAvbUxRktHfYmTD5xj4sOrOVoh5EsFGWfil2sK0ndDq
 ChItIC7kszv3wPJ8BQmPOAD1xkwaPeHVFhyjz9jCMw==
X-Google-Smtp-Source: AGHT+IEtqJZKmSEyZnBMRzzFlRY9tvXkNKmNs4CQcHI78LFO4XuwUQiGGAW6ik03e/7LGOBWaG+Lh10csji+h9FF0WU=
X-Received: by 2002:a05:651c:c8a:b0:2bf:fa62:5d0e with SMTP id
 bz10-20020a05651c0c8a00b002bffa625d0emr12263942ljb.2.1698240147006; Wed, 25
 Oct 2023 06:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
 <0459b591-1f22-427d-9b7f-5422dbe789b8@gmx.de>
In-Reply-To: <0459b591-1f22-427d-9b7f-5422dbe789b8@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Oct 2023 16:21:51 +0300
Message-ID: <CAC_iWjKMB4rO7tVh9sy7bd=gFEHeZKcwbM7cGkjSb+JkkLi_8Q@mail.gmail.com>
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>, sjg@chromium.org, u-boot@lists.denx.de
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

On Wed, 25 Oct 2023 at 16:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 24.10.23 17:43, Eddie James wrote:
> > Add a configuration option to measure the boot through the bootm
> > function. Add the measurement state to the booti and bootz paths
> > as well.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changes since v8:
> >   - Added a configuration option to select to ignore any existing
> >     event log. This would only be selected for systems that know
> >     that U-Boot is the first stage bootloader. This is necessary
> >     because the reserved memory region may persist through resets
> >     and so U-Boot attempts to append to the previous boot's log.
> >
> > Changes since v6:
> >   - Added comment for bootm_measure
> >   - Fixed line length in bootm_measure
> >
> >   boot/Kconfig    | 32 +++++++++++++++++++++
> >   boot/bootm.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   cmd/booti.c     |  1 +
> >   cmd/bootm.c     |  2 ++
> >   cmd/bootz.c     |  1 +
> >   include/bootm.h | 11 ++++++++
> >   include/image.h |  1 +
> >   7 files changed, 122 insertions(+)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index a01e6cb8aa..abbc72f4cf 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
> >         loaded. If a board needs the legacy image format support in this
> >         case, enable it here.
> >
> > +config MEASURED_BOOT
> > +     bool "Measure boot images and configuration to TPM and event log"
> > +     depends on HASH && TPM_V2
> > +     help
> > +       This option enables measurement of the boot process. Measurement
> > +       involves creating cryptographic hashes of the binary images that
> > +       are booting and storing them in the TPM. In addition, a log of
> > +       these hashes is stored in memory for the OS to verify the booted
> > +       images and configuration. Enable this if the OS has configured
> > +       some memory area for the event log and you intend to use some
> > +       attestation tools on your system.
> > +
> > +if MEASURED_BOOT
> > +     config MEASURE_DEVICETREE
> > +     bool "Measure the devicetree image"
> > +     default y if MEASURED_BOOT
> > +     help
> > +       On some platforms, the devicetree is not static as it may contain
> > +       random MAC addresses or other such data that changes each boot.
> > +       Therefore, it should not be measured into the TPM. In that case,
> > +       disable the measurement here.
>
> I guess the device-tree should be measured before fix-ups.
>
> A main source of randomness is the KASLR seed.
>
> @Ilias: How are we handling this in the EFI case?

We unconditionally strip the KASLR node if EFI_RNG is installed.
efi_try_purge_kaslr_seed() has a useful comment on how the kernel's
EFI-stub behaves.
In any case, we measure selected parts of the DTB, not all of it,
efi_tcg2_measure_dtb() has the details and we keep the DTB measurement
under a Kconfig node.

Regards
/Ilias
>
> Best regards
>
> Heinrich
