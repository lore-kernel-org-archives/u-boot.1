Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BEBCED628
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 611668918B;
	Wed,  9 Oct 2024 10:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cShx3iEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A858918B; Wed,  9 Oct 2024 10:56:15 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC48F89186
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fadb636abaso65633871fa.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728464171; x=1729068971; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AW3bJ3haELYF/L+9diubZ362nk+ggWnqFG8JPKUARMs=;
 b=cShx3iENK89PUVbRtGOg3mrjoNKLx/LXdNWIZBEPQrcPp2+7CRxFlv9fdgf3ae/Ncc
 9sXBA/6QyVqLCyl8BDvnpUeKOWY90mh8n3NQZaxY8zRsM+taqDg0p6MPwEXNsTo9WlHt
 xfA7Xua4Ik5x6pX5t1vxqNfLPuHK45LaPdadjsqjZYZTODuioIhf8U2+2mj79SqPnioG
 V7o6fIesL4X5/5FCWmhRe/PiZgdt35Hm3BrQ4LdqNG3Jhi1rpVqrE4KLq98oEHi7f00A
 RGlEpbnyp+kAqxtWtRk0fZTm9IHV5F/u+gTQZ/3nW4s7sJVHBubhbUazgqMHFftbauJN
 KYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728464171; x=1729068971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AW3bJ3haELYF/L+9diubZ362nk+ggWnqFG8JPKUARMs=;
 b=JiNMgLWCWxgf+Hcm2UytEOsd2BvEgYvskLfim4a9FrrE+xUpiasV/cPGeFGY99yr9X
 ZU3VKaIm3BPoEsyGr4T8ABdTe92k/lkh4haCX1vcoIrNSu5CBoc992bp8mt7C1EPViXo
 7n7ZR26wR5bIHEfgJcU3y4eLbP1v1FuIJT5FqqXkTrQz7w5IwOOPB18AJ1JfjJa0DmHX
 NgLEslhrg1SJxSHEYPMFO/Au69N7YXZvSY9//ne9UWAziHJKqoVnjOxVgbfIACoAqsIj
 AIdef431SWzGkn/Bswd0KaTQHwxwB+jkSflnPdRLep1kdW+5aZIKIvk5JTnWuwIqsJyy
 GrTA==
X-Gm-Message-State: AOJu0YykOFIO9gQB9jkTJqasz0zval7U8xl4bY8SQJDMF6VGvGJ7WbS/
 dhdeuTOEisW/7Je87CJb6bTwGwdSEQpaaJ72uqQ/C3usYHkxpwiYJqqcWDiOQWWAHYYQHEiEuUl
 jl4CRDfmK+vKkOAWAGNyZum1+eUY=
X-Google-Smtp-Source: AGHT+IHrzpMlu1FxbK+73Vl3MjxtqC6ECO1MnqCdeVlin2fBGV/f2RFDK1xwtqT514juzWuieH0W4kMSqapVOIj8Zr0=
X-Received: by 2002:a05:651c:b20:b0:2fa:d296:6fbf with SMTP id
 38308e7fff4ca-2fb187120b8mr11121261fa.1.1728464170842; Wed, 09 Oct 2024
 01:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241004230756.371153-1-marex@denx.de>
 <20241004230756.371153-2-marex@denx.de>
In-Reply-To: <20241004230756.371153-2-marex@denx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 9 Oct 2024 09:55:59 +0100
Message-ID: <CALeDE9N-qXAWKT4hyOMsRetW6XnWSfwFiM2Nr79u3iwymtp5mQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Drop SPL_FIT_GENERATOR support
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
> The SPL_FIT_GENERATOR is long superseded by binman, drop SPL_FIT_GENERATOR
> support as there are no more users.
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
>  Makefile                | 18 ------------------
>  boot/Kconfig            | 15 ---------------
>  doc/usage/fit/howto.rst |  4 ----
>  3 files changed, 37 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a70926ec2fa..45592eb2bac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1139,13 +1139,6 @@ ifeq ($(CONFIG_OF_EMBED)$(CONFIG_EFI_APP),y)
>         @echo >&2 "CONFIG_OF_SEPARATE for boards in mainline."
>         @echo >&2 "See doc/develop/devicetree/control.rst for more info."
>         @echo >&2 "===================================================="
> -endif
> -ifneq ($(CONFIG_SPL_FIT_GENERATOR),)
> -       @echo >&2 "===================== WARNING ======================"
> -       @echo >&2 "This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate"
> -       @echo >&2 "to binman instead, to avoid the proliferation of"
> -       @echo >&2 "arch-specific scripts with no tests."
> -       @echo >&2 "===================================================="
>  endif
>         $(call deprecated,CONFIG_WDT,DM watchdog,v2019.10,\
>                 $(CONFIG_WATCHDOG)$(CONFIG_HW_WATCHDOG))
> @@ -1413,17 +1406,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
>  u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
>         $(call if_changed,objcopy)
>
> -# Boards with more complex image requirements can provide an .its source file
> -# or a generator script
> -# NOTE: Please do not use this. We are migrating away from Makefile rules to use
> -# binman instead.
> -ifneq ($(CONFIG_USE_SPL_FIT_GENERATOR),)
> -U_BOOT_ITS := u-boot.its
> -$(U_BOOT_ITS): $(U_BOOT_ITS_DEPS) FORCE
> -       $(srctree)/$(CONFIG_SPL_FIT_GENERATOR) \
> -       $(patsubst %,$(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) > $@
> -endif
> -
>  ifdef CONFIG_SPL_LOAD_FIT
>  MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>         -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 51e6cd6cb1d..4314227d5f8 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -282,21 +282,6 @@ config SPL_FIT_IMAGE_POST_PROCESS
>           injected into the FIT creation (i.e. the blobs would have been pre-
>           processed before being added to the FIT image).
>
> -config USE_SPL_FIT_GENERATOR
> -       bool "Use a script to generate the .its script"
> -       depends on SPL_FIT
> -       default y if SPL_FIT && ARCH_ZYNQMP
> -
> -config SPL_FIT_GENERATOR
> -       string ".its file generator script for U-Boot FIT image"
> -       depends on USE_SPL_FIT_GENERATOR
> -       default "arch/arm/mach-zynqmp/mkimage_fit_atf.sh" if SPL_LOAD_FIT && ARCH_ZYNQMP
> -       help
> -         Specifies a (platform specific) script file to generate the FIT
> -         source file used to build the U-Boot FIT image file. This gets
> -         passed a list of supported device tree file stub names to
> -         include in the generated image.
> -
>  if VPL
>
>  config VPL_FIT
> diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
> index 280eff724f6..675c9aa5bb0 100644
> --- a/doc/usage/fit/howto.rst
> +++ b/doc/usage/fit/howto.rst
> @@ -57,10 +57,6 @@ own subnode under the /images node, which should then be referenced from one or
>  multiple /configurations subnodes. The required images must be enumerated in
>  the "loadables" property as a list of strings.
>
> -CONFIG_SPL_FIT_GENERATOR can point to a script which generates this image source
> -file during the build process. It gets passed a list of device tree files (taken
> -from the CONFIG_OF_LIST symbol).
> -
>  The SPL also records to a DT all additional images (called loadables) which are
>  loaded. The information about loadables locations is passed via the DT node with
>  fit-images name.
> --
> 2.45.2
>
