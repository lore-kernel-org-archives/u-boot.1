Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E69875C5;
	Wed, 20 Dec 2023 05:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i2G4nXGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0097C875C5; Wed, 20 Dec 2023 05:47:31 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B88987630
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d352c826eso2349565e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047647; x=1703652447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0j0XoX/F4CYjfrrCPTxHlaT+yiksoIM6Qy8SYqbu4M=;
 b=i2G4nXGsYDjfRwZSZEGivymwT56k3O8ffQDOCsIIl/ptpgfqwK8Xwur2bWBHdBzBTI
 rLeyJK9jE9gPFjeEgPWyEEz3ycEk/112sGrMHLAdYNKDO3qikkdZChWow0TfkMpd8kqA
 CwARxFDzEiQHiOJpdQ/3k56f4V3ym/ti8aXOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047647; x=1703652447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0j0XoX/F4CYjfrrCPTxHlaT+yiksoIM6Qy8SYqbu4M=;
 b=m/xjCL9+CEejL+mpuxH4JKdzWOUKyleg3Wa0gOEiBXOI+PbW7k6O/qhvLUpdU8aeqi
 7R+TavN1l18U7kZgEoImSq7/ZJ2QraMcN+rOegsjE4sDDSx+VijOUX2zAhohWoQf4MAH
 wpnKQpXZyHT035LIDcN4tBf1JZV2BC9LsbSF1vZyios9y6rJLbC2L16NSEQLiFsul52g
 n/CNqCLvHFG3uoAdKvVV5ltS04QbQAcVvIDAIhN2NF6DVjvlUV6r9mQ2UITsY3ZhuW5x
 AYPJPM7POnbYXYiH1OhLbuT5qNXsIeLnmEsEoVPqRKXbwL9tF4ZWVvchTznc+7PT9VcM
 790Q==
X-Gm-Message-State: AOJu0YwWB2I5Yz2uDl1SjuzETcHTM+qBcXBNw7nkgxmH9NLI6eZnqaDc
 DxfF80KekLmXkiOhXK6G2PEUUg/Avbp8FO0Wy/Evsw==
X-Google-Smtp-Source: AGHT+IH/9tW5NV6GCaMzuxvXkKRxguwQaOwhT3X3RkI6cJ8E1LvdCj5G9z/urywVSYomWPSAuBUoTGKCKRA1S6Gc6Bg=
X-Received: by 2002:a05:600c:808b:b0:40c:32c7:84fd with SMTP id
 ew11-20020a05600c808b00b0040c32c784fdmr10727069wmb.80.1703047647489; Tue, 19
 Dec 2023 20:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-4-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:15 -0700
Message-ID: <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi
 files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Allow u-boot to build DTB from a different directory tree such that
> *-u-boot.dtsi files can be included from a common location. Currently
> that location is arch/$(ARCH)/dts/, so statically define that common
> location.
>
> This is needed for platform owners to start building DTB files from
> devicetree-rebasing directory but still being able to include
> *-u-boot.dtsi files.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  scripts/Makefile.lib | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 27b9437027c..4a002b0e0ca 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
>  ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
>
>  # Try these files in order to find the U-Boot-specific .dtsi include file
> -u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> -       $(wildcard $(dir $<)u-boot.dtsi))
> +UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/

How about lower case since it is internal. Also we know it is U-Boot,
so perhap dtsi_loc ?

Otherwise looks OK to me.

> +
> +u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> +       $(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
>
>  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -       $(dir $<)u-boot.dtsi ... \
> +       $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> +       $(UBOOT_DTSI_LOC)u-boot.dtsi ... \
>         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
>
>  # Uncomment for debugging
> @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  $(UBOOTINCLUDE)                                         \
>                  -I$(dir $<)                                             \
> +                -I$(UBOOT_DTSI_LOC)                                     \
>                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
>                  -I$(srctree)/include                                    \
>                  -D__ASSEMBLY__                                          \
> @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
> -               -i $(dir $<) $(DTC_FLAGS) \
> +               -i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
>                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>                 ; \
> --
> 2.34.1
>

Regards,
Simon
