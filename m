Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB1C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C677686A57;
	Thu, 24 Aug 2023 22:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E7COZ046";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978B986A8F; Thu, 24 Aug 2023 22:01:43 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5487A86A23
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 22:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so384752a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907298; x=1693512098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYHAfWu2rnzTKJDSZVeiLFQkK9PPSItsu91p1Jk0W9o=;
 b=E7COZ046gCsgQIa57YgHj3WwyjSRKY6rXC0oOxFs8qlnzSCwM2TyZQXEL802EB+1tM
 t3Ymch80D/jP4kzdNeu8W1SZ9sT8bbcU1kdo7mBVesYlIR75XksMnQq8a7IQlVsoRE4G
 ncdudCTKLQf8Ru7RJKUYhMwvPfeTk8R2TmiCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907298; x=1693512098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYHAfWu2rnzTKJDSZVeiLFQkK9PPSItsu91p1Jk0W9o=;
 b=E9HpvXsezQfdi7oQi1NSCfkBbTBVIxJPhiZ0gaIjPTVoh9A25Yn2WnJJ8u0/wsxEaj
 GqM93/aLSilBZPSfGM/OOA11uSUSMk0twt+IxONYOEjw5+SsSjxdODuhf0tZ9urqGwSI
 LE7kZT3mMJGiZAfG3BjhPs/nmJii3Ym/dEgkD5PdlroK2eUqMsvu5x6PLvG+2MiDn1tZ
 CypLQtVksCvz5iw9QCcuo7xq8JG83EGs/ofbCoKQ+9B2Yvfjbh9U0a+pdkf7lcaI7PQD
 Ssns69n4gp/ImQaBaUoAPYxEOtIY8H7RR8V1paiOfxTXOclpfouz/MiPlEfbc0/koM5f
 g/gg==
X-Gm-Message-State: AOJu0YwrRC4p0VovphAmCwDPJ4oagrXSWuhwC5tN0I7GvbhNfbN5avp3
 Pio8S579mCI8Nd6sU7rRfKYobMbk0YCljUe9qqsiJg==
X-Google-Smtp-Source: AGHT+IFgZp2vUJgYxy/u1k7uD66ZXa7j5GWS4QESNWGrN8s1nA8qyFDpxM8jb+MLA/sKzkaZPfXg4JoFll2HoDul4dY=
X-Received: by 2002:aa7:d4cc:0:b0:523:5012:63d5 with SMTP id
 t12-20020aa7d4cc000000b00523501263d5mr12595696edr.16.1692907297529; Thu, 24
 Aug 2023 13:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Aug 2023 14:01:25 -0600
Message-ID: <CAPnjgZ1NFEVDcu-qOhTrjNpTspJ5OcCUZrDJJkru0mY-McPhzw@mail.gmail.com>
Subject: Re: [PATCH] Convert CFG_SYS_UBOOT_START to Kconfig
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, "Andrew F . Davis" <afd@ti.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Mingming lee <mingming.lee@mediatek.com>, Mauro Condarelli <mc5686@mclink.it>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Jesse,

On Wed, 23 Aug 2023 at 20:30, Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
> renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> this meant that the value was no longer available to the Makefile. This
> caused imxrt to fail to boot. All the other boards that used this
> variable were unaffected because they were using the default value
> which is CONFIG_TEXT_BASE.
>
> This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
> value to CONFIG_TEXT_BASE.
>
> Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  Makefile                                       | 16 ++++------------
>  arch/arm/mach-k3/config_secure.mk              |  2 +-
>  arch/arm/mach-omap2/config_secure.mk           |  2 +-
>  boot/Kconfig                                   | 16 ++++++++++++++++
>  common/spl/spl.c                               |  6 +-----
>  common/spl/spl_fit.c                           |  2 +-
>  configs/imxrt1020-evk_defconfig                |  2 ++
>  configs/imxrt1050-evk_defconfig                |  2 ++
>  configs/imxrt1170-evk_defconfig                |  2 ++
>  include/configs/gardena-smart-gateway-mt7688.h |  4 ----
>  include/configs/imxrt1020-evk.h                |  6 ------
>  include/configs/imxrt1050-evk.h                |  6 ------
>  include/configs/imxrt1170-evk.h                |  3 ---
>  include/configs/linkit-smart-7688.h            |  4 ----
>  include/configs/mt7620.h                       |  3 ---
>  include/configs/mt7628.h                       |  3 ---
>  include/configs/mt8512.h                       |  2 --
>  include/configs/vocore2.h                      |  4 ----
>  include/spl.h                                  |  2 +-
>  19 files changed, 31 insertions(+), 56 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9b90204bfe..13d4c63439 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1364,14 +1364,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
>  u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
>         $(call if_changed,objcopy)
>
> -#
> -# U-Boot entry point, needed for booting of full-blown U-Boot
> -# from the SPL U-Boot version.
> -#
> -ifndef CFG_SYS_UBOOT_START
> -CFG_SYS_UBOOT_START := $(CONFIG_TEXT_BASE)
> -endif
> -
>  # Boards with more complex image requirements can provide an .its source file
>  # or a generator script
>  # NOTE: Please do not use this. We are migrating away from Makefile rules to use
> @@ -1391,7 +1383,7 @@ endif
>
>  ifdef CONFIG_SPL_LOAD_FIT
>  MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -p $(CONFIG_FIT_EXTERNAL_OFFSET) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
>         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> @@ -1399,10 +1391,10 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>         $(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>  else
>  MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
>  MKIMAGEFLAGS_u-boot-ivt.img = -A $(ARCH) -T firmware_ivt -C none -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
>  u-boot-ivt.img: MKIMAGEOUTPUT = u-boot-ivt.img.log
>  endif
> @@ -1433,7 +1425,7 @@ MKIMAGEFLAGS_u-boot.pbl = -n $(srctree)/$(CONFIG_SYS_FSL_PBL_RCW:"%"=%) \
>  UBOOT_BIN := u-boot.bin
>
>  MKIMAGEFLAGS_u-boot-lzma.img = -A $(ARCH) -T standalone -C lzma -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
>
>  u-boot.bin.lzma: u-boot.bin FORCE
> diff --git a/arch/arm/mach-k3/config_secure.mk b/arch/arm/mach-k3/config_secure.mk
> index 7bc8af813a..9cc1f9eb24 100644
> --- a/arch/arm/mach-k3/config_secure.mk
> +++ b/arch/arm/mach-k3/config_secure.mk
> @@ -30,7 +30,7 @@ tispl.bin_HS: $(obj)/u-boot-spl-nodtb.bin_HS $(patsubst %,$(obj)/dts/%.dtb_HS,$(
>         $(call if_changed,mkfitimage)
>
>  MKIMAGEFLAGS_u-boot.img_HS = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
>         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
>
> diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
> index 24ddcdb961..f76262bb0c 100644
> --- a/arch/arm/mach-omap2/config_secure.mk
> +++ b/arch/arm/mach-omap2/config_secure.mk
> @@ -102,7 +102,7 @@ u-boot_HS_XIP_X-LOADER: $(obj)/u-boot.bin FORCE
>  ifdef CONFIG_SPL_LOAD_FIT
>
>  MKIMAGEFLAGS_u-boot_HS.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> -       -a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
> +       -a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>         -n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
>         $(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 5e2d4286ae..f2f7821cc1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -737,6 +737,22 @@ config TEXT_BASE
>         default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >= 256
>         default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
>         hex "Text Base"
> +       help
> +         The address in memory that U-Boot will be copied from, initially.
> +
> +config HAVE_SYS_UBOOT_START
> +       bool
> +       depends on HAVE_TEXT_BASE
> +       prompt "Use custom U-Boot Start"
> +       help
> +         By default, the address in memory that U-Boot will be copied from(TEXT_BASE) and the
> +         entry point are the same. Select this to set a different U-Boot start address.

space after 'from'

Also this is a little unclear. START means the start address that
U-Boot will run from. If it is different from TEXT_BASE, then
something loads it here?

This could do with a bit more detail.

> +
> +config SYS_UBOOT_START
> +       hex
> +       depends on HAVE_TEXT_BASE
> +       default TEXT_BASE
> +       prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
>         help
>           The address in memory that U-Boot will be running from, initially.
>

Regards,
Simon
