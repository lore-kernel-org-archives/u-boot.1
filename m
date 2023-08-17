Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CDC41513
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9A686AD8;
	Thu, 17 Aug 2023 13:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BQfL2BxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4DD86AE7; Thu, 17 Aug 2023 13:54:53 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA9E86AB0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bbac8ec902so1036801fa.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692273290; x=1692878090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LNoLOEsd0Dt8uMB9IHOamYjC2o/ixae3bsrOf2y1YdE=;
 b=BQfL2BxSw63svI2QesInzMlM9saIj3A4ELZ8CSrLiELVDs7WrTw6XJMqCvY04o4wDH
 CxCQT1xVkkQH8Et98M+ZCG9rzKCyebfij8iqIM0lKiC3pDEVuy2FhzwtlbnjZVVQu8Fz
 6sEfJNThVVE+5YcP3uV4zXF3pvAkhsB3x5jsGJq2QwB/H+81VsGJyZ08w0bw/cpcqUGm
 3LcaB5+hNqIJ+20hsXN1hBdDDUFTeLPYpWK8oMFMglZDnes9A/FTaR5BJDssnF+2Yn7k
 rY93N6dg6sGNS2wPZFWweppixX0Ryt5OCb3LyB7jjufw2NiHgIdhyyzb2ZLC5QdWWMXe
 hFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692273290; x=1692878090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNoLOEsd0Dt8uMB9IHOamYjC2o/ixae3bsrOf2y1YdE=;
 b=ZMJbeS+FdoFH1FBFzQA0H0XeQUQP5WUVKfjArWTimogP3M3b6DaSi4pFQYniGohl9q
 UHlef9Ya9haFlQbwPUKCexQ2ktxfgi0VJ+LkIBlIc7KYa13cL4/Eiyksq00V/X0NdfmK
 teqXbBNzJspL+7XQ6B+C3DxBw/48bEPdEVUSxqtlgXJs8/A1thdhJBv+cWvc/w3iCZu5
 ec7EWFF/AIWKtkZrClXQh5tSr6QlXkVImJ83qeGsySMmFIRqPyG5K3UlahU8PVD4+lvo
 c0LZyd6ti2dYX0q47wt0+2e56TrLWOWtUggp9O+viKzgcvVlgVZz/by1VglBdYjheOSR
 l+zg==
X-Gm-Message-State: AOJu0Yzqzk7+HCjZATSaFxaFlfkahDnDgWsuq2dSDuLU3XxVXx5lbbpG
 LqBVIobRCh5PR+e3tuP5DIvp61+U+DOg2dkk6BmyPnPuStwa0aRgSfIIqw==
X-Google-Smtp-Source: AGHT+IFnOSyRT65QjKm9JyAut9YxMyDP2U6rYgtaCLmPXAWBt/Vz2k0smSpih+gYdmuSk2gBrYkQfkHiuHtanJDhufI=
X-Received: by 2002:a19:3810:0:b0:4fe:a2e:890c with SMTP id
 f16-20020a193810000000b004fe0a2e890cmr3197896lfa.49.1692273290289; Thu, 17
 Aug 2023 04:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-2-sughosh.ganu@linaro.org>
In-Reply-To: <20230817054856.2019253-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 14:54:14 +0300
Message-ID: <CAC_iWjKM1b9h9MVVS1J=F404DpBnBgnG-UT8VmXG-uL9mj+81Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> At the time of building a device-tree file, all the *u-boot.dtsi files
> are looked for, in a particular order, and the first file found is
> included. Then, the list of files specified in the
> CONFIG_DEVICE_TREE_INCLUDES symbol are included.
>
> Combine these files that are to be included into a variable, and then
> include all these files in one go.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes since V1: None
>
>  scripts/Makefile.lib | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index f5ab7af0f4..368b5a3e28 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -179,10 +179,13 @@ ifdef DEVICE_TREE_DEBUG
>  u_boot_dtsi_options_debug = $(warning $(u_boot_dtsi_options_raw))
>  endif
>
> -# We use the first match
> -u_boot_dtsi = $(strip $(u_boot_dtsi_options_debug) \
> +# We use the first match to be included
> +dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
>         $(notdir $(firstword $(u_boot_dtsi_options))))
>
> +# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
> +dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
> +
>  # Modified for U-Boot
>  dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                  $(UBOOTINCLUDE)                                         \
> @@ -320,8 +323,8 @@ quiet_cmd_dtc = DTC     $@
>  # Bring in any U-Boot-specific include at the end of the file
>  # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> -       (cat $<; $(if $(u_boot_dtsi),echo '$(pound)include "$(u_boot_dtsi)"')) > $(pre-tmp); \
> -       $(foreach f,$(subst $(quote),,$(CONFIG_DEVICE_TREE_INCLUDES)), \
> +       (cat $< > $(pre-tmp)); \
> +       $(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
>           echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
>         $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>         $(DTC) -O dtb -o $@ -b 0 \
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
