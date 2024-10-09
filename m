Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CAACED62B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB0789182;
	Wed,  9 Oct 2024 10:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6umKtrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DC98914C; Wed,  9 Oct 2024 10:54:26 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F5589182
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so8789575a12.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728464064; x=1729068864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hm+CFwdp92p6FnevyaHiUXikumghapUIPjJQWimmzEk=;
 b=S6umKtrI7/h7fwUd7f/snJMGTPqMhdFLoNdS4tZtKIo08DVzB3Eg+9tdjgc30ihvqd
 nVS7xZD57TJ0hu68xes1/tlVncRino59+xo4pNmtAdrTPURJWS4Lmfftt0QuoVqxUpCP
 VY4H3wVX1+fVLGJoDjNh3CHc8RwOPESGZ9Hngxof9XYAeDR9DgJ9V43RF6ba+oVtOPcK
 4CSIeuYu08dVLXAqmJNds7qe/+aiGjMH0aOEosg6MfkFKPnaT7D8mKcSsBiZQWkdszmp
 wFxCMDVzzcnZEdE2D1nbav/EtDwHoH73Oww5Of6ou/z6jvw4IJJzrXDePUz27KqDEu3Z
 PDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728464064; x=1729068864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hm+CFwdp92p6FnevyaHiUXikumghapUIPjJQWimmzEk=;
 b=WvBrZL4NEqYHgkgV0sY/Cw+iApxqS5oRrpQnbLPO0GbyM7zXw143mtCs8FMqaQ1Zua
 vzsF+lb/3DG0wJPULEaSGFVCzERcjUfj8qBf+lvtnNv3OnAKBaKxqN2qgHwYQD+hPVmf
 zqEb0jCFHGiGBi+Gw94f22P/DxBfH6LNeUl9XvnNgahAouLkw0CgguTvMzpN0OY/Yay8
 g60ttWMNvU1YqlwHMs9LQTYucXXPx9V7s9eQOwrm7x9i5vJ4U0H1uqheTppC9uVcPYl2
 nZjBubwSgk46Vkkmi1KE8/CAL6Nd88rTJUPEGANzkxCRl7P2WT8mCVXvDsauPYlG2ROC
 J+4g==
X-Gm-Message-State: AOJu0YynpnOxRnn4PyQYEru6Q4JkSdQuKUE/7ZvqIkvVeuyyZeNufxFV
 C3PYRlHR7S5CRXjeTcCasAcN0jADxz5wb8QMnoUdGUmq752WfpsIlMFpihQ2XB7bG5U7/OhvNBd
 URwEymoTu0+OiKroO0t2zhjbyZB4=
X-Google-Smtp-Source: AGHT+IHjzDSXYAeARzcOt45pZeG1Yu+a2nsX7twmPwjILJtikZBWSb5IqXqU3r6KKsrE9uEqLxHTd7eWwlMScpo/s+4=
X-Received: by 2002:a05:6402:31b4:b0:5c9:5fa:1f74 with SMTP id
 4fb4d7f45d1cf-5c91d641ebdmr1217832a12.22.1728464063570; Wed, 09 Oct 2024
 01:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241004230756.371153-1-marex@denx.de>
In-Reply-To: <20241004230756.371153-1-marex@denx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 9 Oct 2024 09:54:12 +0100
Message-ID: <CALeDE9ML6cRrNP9oCrQa2Yp_kax0KF+fH2tgNtYo_aRucGo+aA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

On Sat, 5 Oct 2024 at 00:08, Marek Vasut <marex@denx.de> wrote:
>
> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
> is long superseded by binman, drop SPL_FIT_SOURCE support as there
> are no more users.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> NOTE: Depends on https://lore.kernel.org/u-boot/20241004225916.361000-1-marex@denx.de/
> ---
>  Makefile                |  6 ------
>  boot/Kconfig            |  8 --------
>  doc/usage/fit/howto.rst | 11 +++--------
>  3 files changed, 3 insertions(+), 22 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index af24de4165e..a70926ec2fa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1417,18 +1417,12 @@ u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
>  # or a generator script
>  # NOTE: Please do not use this. We are migrating away from Makefile rules to use
>  # binman instead.
> -ifneq ($(CONFIG_SPL_FIT_SOURCE),"")
> -U_BOOT_ITS := u-boot.its
> -$(U_BOOT_ITS): $(subst ",,$(CONFIG_SPL_FIT_SOURCE))
> -       $(call if_changed,copy)
> -else
>  ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
>  U_BOOT_ITS := u-boot.its
>  $(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
>         $(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
>         $(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
>  endif
> -endif
>
>  ifdef CONFIG_SPL_LOAD_FIT
>  MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 925afe06a19..51e6cd6cb1d 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -282,14 +282,6 @@ config SPL_FIT_IMAGE_POST_PROCESS
>           injected into the FIT creation (i.e. the blobs would have been pre-
>           processed before being added to the FIT image).
>
> -config SPL_FIT_SOURCE
> -       string ".its source file for U-Boot FIT image"
> -       depends on SPL_FIT
> -       help
> -         Specifies a (platform specific) FIT source file to generate the
> -         U-Boot FIT image. This could specify further image to load and/or
> -         execute.
> -
>  config USE_SPL_FIT_GENERATOR
>         bool "Use a script to generate the .its script"
>         depends on SPL_FIT
> diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
> index b5097d4460b..280eff724f6 100644
> --- a/doc/usage/fit/howto.rst
> +++ b/doc/usage/fit/howto.rst
> @@ -57,14 +57,9 @@ own subnode under the /images node, which should then be referenced from one or
>  multiple /configurations subnodes. The required images must be enumerated in
>  the "loadables" property as a list of strings.
>
> -If a platform specific image source file (.its) is shipped with the U-Boot
> -source, it can be specified using the CONFIG_SPL_FIT_SOURCE Kconfig symbol.
> -In this case it will be automatically used by U-Boot's Makefile to generate
> -the image.
> -If a static source file is not flexible enough, CONFIG_SPL_FIT_GENERATOR
> -can point to a script which generates this image source file during
> -the build process. It gets passed a list of device tree files (taken from the
> -CONFIG_OF_LIST symbol).
> +CONFIG_SPL_FIT_GENERATOR can point to a script which generates this image source
> +file during the build process. It gets passed a list of device tree files (taken
> +from the CONFIG_OF_LIST symbol).
>
>  The SPL also records to a DT all additional images (called loadables) which are
>  loaded. The information about loadables locations is passed via the DT node with
> --
> 2.45.2
>
