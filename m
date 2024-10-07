Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC5CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 10:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC7D889E1;
	Mon,  7 Oct 2024 12:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fTOgU69j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230148863E; Mon,  7 Oct 2024 12:08:21 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9B088B39
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 12:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4a3cb61d179so1452923137.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728295695; x=1728900495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itSUuj6/aLWCAQ1C2aJ5Ny91rrBDpz23HgyNmsgFTpg=;
 b=fTOgU69jDAzcF4XpLIH+XyyWVHIaDsXDTBaK0rOiBMZH0OONDj+fbIyCJF7b8wHOHD
 al/iLLRecWuc1dueadG1EdgwSmXynxHI1/iWknnLawW5QkaPM8wKg8a5A7PzNPW/wXzv
 f+2jMw5mxcYphXPXp4tVzhXj6eRNi/k28wUsQ73whU9kwigbA5hDchXZyN9FUepPf/OU
 m+aa+sXkRGLDDWKd5OrIeRB6AuJaDJjqYSQgzkXEWxdEerDORkqnL25tfIT6ejtdbED/
 UqvsSQWLzidmhmWUdUjd9H4FoGqwQoLRfXhuXJjZKwg8ypPMsWd8cArmJLyE0VuDmQse
 qrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728295695; x=1728900495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itSUuj6/aLWCAQ1C2aJ5Ny91rrBDpz23HgyNmsgFTpg=;
 b=Nmrl7YAntg7ug0syY0Pmqo9irDDU0sfYALwvY3E91a2x1P3oVm6NYnU8ltZDCLlBdf
 PHkdlmWXUKu3vrs96f3SAFn4ulSleWOsAuPmadt281uwzp8F9XTf57rur8cbooCyJ0LI
 LGHSDUoGkdLDeRbPVIR16+HxSPJP72/HkzbOQGClEFQE09csFjlk9NzqaLF33jiSCqub
 mZRmMnEfIFGLxI9UoDOFTz1cSqNjyLguk+xNAlQhdpttcCj2n+wCz23N4WzPr/0P/dVS
 iGbA4uyBjwuIyczQNcirBmN1PToFRS+JXUulN7axL7FF5nbjvLX9z6NDKFHS/GQuucBC
 BRig==
X-Gm-Message-State: AOJu0Yx+i2jO2jjRh4zQ1zVanRvVYLiN+3BFY7JI0XQC6VVZLT9qS4ke
 HjeNGbvXJnPCPkJSaIOJtSdI8sYZjt0HAlbsfF+ahO8YAimLpdsRv1Wy3UoeeDL2G3MyTUrdgnF
 bSKhSP8Yob+xLptHcUsYnJj6ReN5JxAxdeqmOVQ==
X-Google-Smtp-Source: AGHT+IH+7XOsafF+teWXZ6IAQrECOAMvw6g8Sc/qcLQIXY7Te7UkxSiM2vevQuPfnwZ2rluGj7lCTWel+9IF6z7O23I=
X-Received: by 2002:a05:6102:6c6:b0:4a3:ba8c:879 with SMTP id
 ada2fe7eead31-4a40574f974mr6450870137.2.1728295695480; Mon, 07 Oct 2024
 03:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241005011315.436233-1-marex@denx.de>
In-Reply-To: <20241005011315.436233-1-marex@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 7 Oct 2024 15:38:04 +0530
Message-ID: <CAFA6WYO8LQGdPFp2ph2YXphfa5DPKkK5eChU6kbOCboEHe8UgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

Hi Marek,

On Sat, 5 Oct 2024 at 06:43, Marek Vasut <marex@denx.de> wrote:
>
> Currently the enablement of OF_UPSTREAM results on the build system
> searching for DTs only in dts/upstream/ . There are platforms which
> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>
> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>
> Adjust top level Makefile so binman would search for .dtb and .dtbo in
> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lothar Rubusch <l.rubusch@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
> V2: Gate this functionality behind CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
> ---
> NOTE: Depends on https://lore.kernel.org/u-boot/20241004001118.322531-1-marex@denx.de/
> ---
>  Makefile             |  4 ++++
>  dts/Kconfig          | 16 ++++++++++++++++
>  dts/Makefile         | 14 +++++++++++++-
>  scripts/Makefile.dts |  6 ++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index af24de4165e..a5258e8cb3f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1375,7 +1375,11 @@ of_list := "$(ext_dtb_list)"
>  of_list_dirs := $(dir $(EXT_DTB))
>  else
>  of_list := $(CONFIG_OF_LIST)
> +ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
> +of_list_dirs := $(dt_dir) arch/$(ARCH)/dts
> +else
>  of_list_dirs := $(dt_dir)
> +endif
>  default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
>  endif
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 569d4be338e..385058b429f 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -125,6 +125,22 @@ config OF_UPSTREAM_VENDOR
>         help
>           Select the vendor to build all devicetree files for.
>
> +config OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
> +       bool "Build local DTBOs as fallback for DTBOs missing upstream"
> +       default n
> +       depends on OF_UPSTREAM
> +       help
> +         Enable building DTBOs from arch/$(ARCH)/dts as a fallback for
> +         DTBOs which are not part of Linux kernel upstream yet. This is
> +         a stopgap measure to expedite OF_UPSTREAM switch for platforms
> +         which already have main DT in Linux kernel upstream, but still
> +         have leftover DTBOs in U-Boot tree.
> +
> +         Do not use this option, upstream your DTs and DTBOs instead.
> +         If the upstreaming is in progress, use with utmost caution.
> +
> +         If unsure, say N.
> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
> diff --git a/dts/Makefile b/dts/Makefile
> index d6c2c9daf31..32c749a043a 100644
> --- a/dts/Makefile
> +++ b/dts/Makefile
> @@ -11,12 +11,18 @@ DEVICE_TREE := unset
>  endif
>
>  ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)

Since CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS already has a
dependency on CONFIG_OF_UPSTREAM via Kconfig, can we avoid the nested
ifeq sequence here? This will avoid a redundant local_dtbos
assignment...

> +local_dtbos := local-dtbos
> +else
> +local_dtbos :=
> +endif
>  ifeq ($(CONFIG_ARM64),y)
>  dt_dir := dts/upstream/src/arm64
>  else
>  dt_dir := dts/upstream/src/$(ARCH)
>  endif
>  else
> +local_dtbos :=

...here.

With that fixed, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  dt_dir := arch/$(ARCH)/dts
>  endif
>
> @@ -40,7 +46,7 @@ endif
>
>  targets += dt.dtb
>
> -$(DTB): arch-dtbs
> +$(DTB): arch-dtbs $(local_dtbos)
>         $(Q)test -e $@ || (                                             \
>         echo >&2;                                                       \
>         echo >&2 "Device Tree Source ($@) is not correctly specified."; \
> @@ -53,6 +59,12 @@ PHONY += arch-dtbs
>  arch-dtbs:
>         $(Q)$(MAKE) $(build)=$(dt_dir) dtbs
>
> +ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
> +PHONY += local-dtbos
> +local-dtbos:
> +       $(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbos
> +endif
> +
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
>  # support "out-of-tree" build for dtb-spl
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 1fe142f2bbf..3ab67b3c247 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -21,4 +21,10 @@ PHONY += dtbs
>  dtbs: $(addprefix $(obj)/, $(dtb-y))
>         @:
>
> +ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
> +PHONY += dtbos
> +dtbos: $(addprefix $(obj)/, $(filter-out %.dtb,$(dtb-y)))
> +       @:
> +endif
> +
>  clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
> --
> 2.45.2
>
