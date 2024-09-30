Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A35CF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 06:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886C388D16;
	Mon, 30 Sep 2024 08:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TCy4fIFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D47885B3; Mon, 30 Sep 2024 08:03:02 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0460A889B8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4a3a4432737so1508650137.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727676178; x=1728280978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Mf9y0x42QZw/ll9mAsy8i2/CBLLqjHlZDEEfXymmf4=;
 b=TCy4fIFYUJ3uK+rpT6au1INPxXYfkswKRdu+XFsijM+qJ03m9p3scguxVgpTshfriB
 klb1RzoJeYzxxbS4+LJ5G4SsgjmdKF7M85GxlwGcrgqyLzT7cPdz27a7QGaRPiyJcknF
 MR37JynI0qAaJFhcFKumbI/VLJKKNTIR0FWSg5CUEnP6Q+Ua93EYNpUcxFqxS5IDUH/0
 AALxVpWYOapnE9qUVPnwshb+SZ3qHN/ddSE57yfxZcy530TntXB5Npzeoj5ophkhS97k
 r3ZnivhgVvUcuTlo9tfuCVmoZ9cE8/vXITIO5w3PtiwZoBK1zSrKYJUIwX60YbFdSVGL
 Eu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727676178; x=1728280978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Mf9y0x42QZw/ll9mAsy8i2/CBLLqjHlZDEEfXymmf4=;
 b=mmBdPYjptDZ+i4OqHnbUBVBARIQi3UkyLgNFhLZ2Qp6deXMXxiclf1pWiVpJVtPgXm
 fPIiUKKjqvd67/V69mQAyiCyZtSaDFd9TTPUGnyhWoen6Jzi8IhhW7EK2vpXcB/vMUjM
 YGXTIrWnbEBWZWAjj5l8Fh844M1tSmw9xUIZqsYYlUw7IJI8SSFnss2+X0t6hfr7CFVA
 V6BSB59XZsFz1pVfmX9G2GD+EgVuIeDeY1AD0oR8C5zYGUA3xB5OLQlPFusTwsS+u8us
 hLDcDbLK1n/hfzwkbjgnOkKuB/aJKy96plrTwzgWFEjvZwZxPvziChuJ79miWKKGQLNI
 7Zlg==
X-Gm-Message-State: AOJu0YwVloHu8bITmy6/kpxMn+vnwfef64IlDULiOxxdeN6IYBBpXE4i
 OLX5HcGshMxSQmY1Yfu6/OYMs/Q5n3pV4g6ReitT9TH9P2I6gzNp1Y9je/KtVOrPQv7MMmfHbD6
 r2ZHP1Lp4lTir7Ht0r4R7jqSEoDX3h5fVCV4YGw==
X-Google-Smtp-Source: AGHT+IGci/GSa5LH0S0qtXzqBY7JUb2QMFElZvjBH2iOjBcDPd5spH9VMToBC2RQLVq2n2DVGaAlfOVtVDblGMlda9M=
X-Received: by 2002:a05:6102:1614:b0:49b:ce5c:d46 with SMTP id
 ada2fe7eead31-4a17d72c9e4mr9400499137.12.1727676177775; Sun, 29 Sep 2024
 23:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
In-Reply-To: <20240927214955.394224-2-marex@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 30 Sep 2024 11:32:46 +0530
Message-ID: <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
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
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, Jan Kiszka <jan.kiszka@siemens.com>
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

+ Jan

Hi Marek,

On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>
> Currently the enablement of OF_UPSTREAM results on the build system
> searching for DTs only in dts/upstream/ . There are platforms which
> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.

I would like to understand the need to maintain DTBOs separately from
DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
DTBs? Jan recently pushed those so-called U-Boot specific DTBOs for a
TI platform which were accepted in the Linux kernel upstream. This
patch will just deny the ability to build those DTBOs from dts
upstream tree. IMHO, this takes a step backwards on the whole notion
of OF_UPSTREAM.

If we really want a middle ground solution to allow migration to
OF_UPSTREAM easier then we need to find a way to build DTBOs from both
directories (local and upstream dts). I would imagine that will likely
complicate building and packaging DTBOs.

-Sumit

>
> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
> in case OF_UPSTREAM is enabled, build this target for arch/$(ARCH)/dtb
> to generate local U-Boot specific DTBOs.
>
> Adjust top level Makefile so binman would search for .dtb and .dtbo in
> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case.
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
>  Makefile             |  5 ++++-
>  dts/Makefile         | 11 +++++++++--
>  scripts/Makefile.dts |  5 ++++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 525576f987d..fba8e48681e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1194,6 +1194,8 @@ else
>  dt_dir := arch/$(ARCH)/dts
>  endif
>
> +local_dto_dir := arch/$(ARCH)/dts
> +
>  ifeq ($(CONFIG_MULTI_DTB_FIT),y)
>
>  ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
> @@ -1377,7 +1379,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>                 build -u -d u-boot.dtb -O . -m \
>                 --allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
>                 -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> -               -I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
> +               -I $(dt_dir) -I $(local_dto_dir) \
> +               -a of-list=$(CONFIG_OF_LIST) \
>                 $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>                 -a atf-bl31-path=${BL31} \
>                 -a tee-os-path=${TEE} \
> diff --git a/dts/Makefile b/dts/Makefile
> index d6c2c9daf31..f872a867667 100644
> --- a/dts/Makefile
> +++ b/dts/Makefile
> @@ -11,12 +11,16 @@ DEVICE_TREE := unset
>  endif
>
>  ifeq ($(CONFIG_OF_UPSTREAM),y)
> +local_dtbos := local-dtbos
> +local_dtbo_dir := arch/$(ARCH)/dts
>  ifeq ($(CONFIG_ARM64),y)
>  dt_dir := dts/upstream/src/arm64
>  else
>  dt_dir := dts/upstream/src/$(ARCH)
>  endif
>  else
> +local_dtbos :=
> +local_dtbo_dir :=
>  dt_dir := arch/$(ARCH)/dts
>  endif
>
> @@ -40,7 +44,7 @@ endif
>
>  targets += dt.dtb
>
> -$(DTB): arch-dtbs
> +$(DTB): arch-dtbs $(local_dtbos)
>         $(Q)test -e $@ || (                                             \
>         echo >&2;                                                       \
>         echo >&2 "Device Tree Source ($@) is not correctly specified."; \
> @@ -49,10 +53,13 @@ $(DTB): arch-dtbs
>         echo >&2;                                                       \
>         /bin/false)
>
> -PHONY += arch-dtbs
> +PHONY += arch-dtbs local-dtbos
>  arch-dtbs:
>         $(Q)$(MAKE) $(build)=$(dt_dir) dtbs
>
> +local-dtbos:
> +       $(Q)$(MAKE) $(build)=$(local_dtbo_dir) dtbos
> +
>  ifeq ($(CONFIG_SPL_BUILD),y)
>  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
>  # support "out-of-tree" build for dtb-spl
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 1fe142f2bbf..f4d3a37010a 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -17,8 +17,11 @@ endif
>
>  targets += $(dtb-y)
>
> -PHONY += dtbs
> +PHONY += dtbs dtbos
>  dtbs: $(addprefix $(obj)/, $(dtb-y))
>         @:
>
> +dtbos: $(addprefix $(obj)/, $(filter-out %.dtb,$(dtb-y)))
> +       @:
> +
>  clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
> --
> 2.45.2
>
