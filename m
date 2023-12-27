Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888BAC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14BBB878C1;
	Wed, 27 Dec 2023 09:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g+v60odq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7F18792D; Wed, 27 Dec 2023 09:39:35 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAB4877CD
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e81761e43so1286009e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703666371; x=1704271171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+71rxcQ4tKfwCLlKcqp3uUBwlFV73S+sxYa2p4O/HU=;
 b=g+v60odqkqeeNq+hKXWOu5joxdf2xgU7DU7cE8+WRDmob0KRUdh6flKQUH4cvs6rM2
 ou/xkBSU3iXglL1UOww9dWMjkNJp+BXyBaXQ8MhZgN1jBfgf63OwvLVj2vONRK0xeTQG
 17rFcA7ayIDNA6TUy+6l3dozZpTLfocgM/F7CR64+CLbqM0Z8j5uQLBXtqIoOBvKBJBI
 kima5p986BoHINlOdTk3TCNFSIWQ4isbvXLJ+ydV5CEwG57RWzl53BxhtkHiC0rfVWYa
 khFFu1xANu0JJdng1UFbzRjciQi8BcdrDvHu3iqYMmGJm9ekzFBI+eaLCdsqDNQnUUwN
 nwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703666371; x=1704271171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T+71rxcQ4tKfwCLlKcqp3uUBwlFV73S+sxYa2p4O/HU=;
 b=IOKl/HDHFffZiVwHIKLkAnhrrr9oSRQnt/GopfnVJuLHMTYETZZ3eQxnn8ncEI/+iz
 jRi26JVyKU3KMWY8/CMxRhECMH4R+fmakTm/SBqLaQJJwG9BCCgYdXnC7EhQEowBCM3o
 9fAIsGuac33Rmk43btpME8z6aMGHvSD/lFGf3RdeYsifFHkvPYVy+56iGnXMMkwXnc1C
 L/6SzRTjWj532eAqnopxhlnmQDp/YSx/n32JRnA27Vqcxsa917eNqhbc7UKE1s3KnTHS
 PrTsVHbpYQIN89ici3dHbheqX34WZSTGpXjzJefWq2Qn9laJMGDZ0aHjkIi9z+BhrKpm
 vF+w==
X-Gm-Message-State: AOJu0YxFxMtHJDHg5tCg0QUGBFaFfdXQbrNVlml35hmbVvf4uuD3JAR8
 JkHHtId1xd+1tiHnyJoLRNUij0baSqls3sl/D26xR7ZXnh5URA==
X-Google-Smtp-Source: AGHT+IF615JeVVQerag8IApiJkfg/Dol0flL4S4XWJANjO9y7DJgDj8neeZVt/XdD/tg2HOkNo8rnjztkn6RCJQCKCw=
X-Received: by 2002:a05:6512:3093:b0:50e:7fdc:6eda with SMTP id
 z19-20020a056512309300b0050e7fdc6edamr1211106lfd.93.1703666371524; Wed, 27
 Dec 2023 00:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org>
In-Reply-To: <20231222061208.3009970-4-sumit.garg@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:38:55 +0200
Message-ID: <CAC_iWjL7A857Hdd8gdAC_XqV=kap_hDwEzPf6R77_QUpcKyzdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

Thanks this looks great


On Fri, 22 Dec 2023 at 08:12, Sumit Garg <sumit.garg@linaro.org> wrote:
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
> index 27b9437027c..09330421856 100644
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
> +u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
> +
> +u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
> +       $(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
>
>  u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
> -       $(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> -       $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> -       $(dir $<)u-boot.dtsi ... \
> +       $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
> +       $(u_boot_dtsi_loc)u-boot.dtsi ... \
>         found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
>
>  # Uncomment for debugging
> @@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  $(UBOOTINCLUDE)                                         \
>                  -I$(dir $<)                                             \
> +                -I$(u_boot_dtsi_loc)                                     \
>                  -I$(srctree)/arch/$(ARCH)/dts/include                   \
>                  -I$(srctree)/include                                    \
>                  -D__ASSEMBLY__                                          \
> @@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
> -               -i $(dir $<) $(DTC_FLAGS) \
> +               -i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>                 -d $(depfile).dtc.tmp $(dtc-tmp) || \
>                 (echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
>                 ; \
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
