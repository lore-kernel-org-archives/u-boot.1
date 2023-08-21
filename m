Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F80EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 09:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04E287026;
	Mon, 21 Aug 2023 11:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="waswItUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B593687045; Mon, 21 Aug 2023 11:23:27 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC51A86BF8
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so4671434e87.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692609804; x=1693214604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=myqNnhJewPzeYwnoroPRUkZqh6t3joOjnIPEQodqbv8=;
 b=waswItUkRaj6NMo1lus4sXHqJBdgppPfs2lCfsWFx6etFNI3hNICpOVIwGENdaCFI0
 0/uGeEPhksmYn+gSzJbCxVkS0FrgmJXuEgalB1AXzleHyMGpeY41zqWQZlL7Z04ubJPv
 3+kZke8sEX0VKSsGZfKRqmCt2zS0AXwnwrtm2DAM92AYZgWNod49F0iYx6Ky8Vnz288F
 H+3dw5XcYAgyF18kIrfVqcgnjAev4GH45bc4bIto7JJBrjuKkBJfaEL9BCVWZ7OVZY/n
 PTYMpOWhyXxCHDWeoAOl4NGR+1uokehE1JiaAhLIQJqJ970Y8jXp3hAbC7yjEYlKOXbm
 faZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692609804; x=1693214604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=myqNnhJewPzeYwnoroPRUkZqh6t3joOjnIPEQodqbv8=;
 b=B/C51idaLMbtzQ2Px5T9Ljd999zTJ2ZkBR59fEo8axhn1SP6fu4Fx0DvdPuo5mrrsr
 ppHk5wDVbVKRKXbghK0KuzUt0HfVTzuT+0E8UGm+4DRTNqKFk5rEvNZdyN2Qf2oZtVBE
 3hILDCfJwjcwmenLuy68l068bbIPGflfAggliY+Xzbyd1CooASJ7hf3VMjpyecgXSLKq
 7iuLoNCMWRJwBiMbhvfww8JzYX36KIWbAeS4pVUuzzf/2iEKsJD8fl9WuYb36fF4ghOW
 i0gpZuvvQMX+EPH12hYFmikOFOhoNbI/NAHCosKwEsuBFMIU9JrC1+HrUi6F8NNKGplG
 jDrA==
X-Gm-Message-State: AOJu0YxI3N5a8DSxgxw3LPiHcxgjZT9b8I0RTaWnA6LBf3k8eHSfhyNg
 8OBrzGb6LRwq9vgHrJVrt35YRpSii+oAMjI3Lv9TQw==
X-Google-Smtp-Source: AGHT+IFVo8EmPam7yd4hAMzqF51veJ6prsXIHOOTQ8Mx1Jve2iTEZDpW1qmLya36i28N+JNJCqaghlnVfzTJebm/kIA=
X-Received: by 2002:a05:6512:3706:b0:4e0:a426:6ddc with SMTP id
 z6-20020a056512370600b004e0a4266ddcmr3557205lfr.0.1692609804098; Mon, 21 Aug
 2023 02:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230821072909.2387400-1-sughosh.ganu@linaro.org>
 <20230821072909.2387400-4-sughosh.ganu@linaro.org>
In-Reply-To: <20230821072909.2387400-4-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Aug 2023 12:22:48 +0300
Message-ID: <CAC_iWjLL=AqfqV3UQSNe63qWA+bCxdq-pKOu0XAHyGMg4BHEVw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
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

On Mon, 21 Aug 2023 at 10:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI capsule authentication logic in u-boot expects the public key
> in the form of an EFI Signature List(ESL) to be provided as part of
> the platform's dtb. Currently, the embedding of the ESL file into the
> dtb needs to be done manually.
>
> Add a target for generating a dtsi file which contains the signature
> node with the ESL file included as a property under the signature
> node. Include the dtsi file in the dtb. This brings the embedding of
> the ESL in the dtb into the U-Boot build flow.
>
> The path to the ESL file is specified through the
> CONFIG_EFI_CAPSULE_ESL_FILE symbol.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes since V2: None
>
>  lib/efi_loader/Kconfig             |  8 ++++++++
>  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
>  scripts/Makefile.lib               | 15 +++++++++++++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 9989e3f384..d20aaab6db 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
>           Select the max capsule index value used for capsule report
>           variables. This value is used to create CapsuleMax variable.
>
> +config EFI_CAPSULE_ESL_FILE
> +       string "Path to the EFI Signature List File"
> +       depends on EFI_CAPSULE_AUTHENTICATE
> +       help
> +         Provides the path to the EFI Signature List file which will
> +         be embedded in the platform's device tree and used for
> +         capsule authentication at the time of capsule update.
> +
>  config EFI_DEVICE_PATH_TO_TEXT
>         bool "Device path to text protocol"
>         default y
> diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
> new file mode 100644
> index 0000000000..61a9f2b25e
> --- /dev/null
> +++ b/lib/efi_loader/capsule_esl.dtsi.in
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/**
> + * Devicetree file with the public key EFI Signature List(ESL)
> + * node. This file is used to generate the dtsi file to be
> + * included into the DTB.
> +*/
> +/ {
> +       signature {
> +               capsule-key = /incbin/("ESL_BIN_FILE");
> +       };
> +};
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 8c5e25c31c..3cec46bb15 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,6 +334,21 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>                 ; \
>         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> +cmd_capsule_esl_gen = \
> +       $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
> +
> +$(obj)/.capsule_esl.dtsi:
> +       $(call cmd_capsule_esl_gen)
> +
> +capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> +capsule_esl_dtsi = .capsule_esl.dtsi
> +capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
> +
> +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> +dtsi_include_list += $(capsule_esl_dtsi)
> +endif
> +
>  dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
>
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
