Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B310C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 18:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A203F869B9;
	Tue, 15 Aug 2023 20:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KgeGuypY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3A1869B3; Tue, 15 Aug 2023 20:39:56 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEAD86977
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 20:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99d6d5054bcso1088378366b.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692124793; x=1692729593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzBNQYVicQSwSF5KSP16nLKCUU/4QI1bGRg+lDxdAUk=;
 b=KgeGuypYGeVmuLdtyIL/n3Lib4CL45RtzgVDNHX5Lvmtb2xfNgXUl0EZK+5ftpxsmn
 unXWPps6ZUJR/CwnqosXOXdK25jpkbDm3IbAwqlIAnvPD4T5sWnpp5LXL6LHPECI1G5d
 O9+vC8BLYwF/nZ0QvkZpdI7+pzQwIpJrmeujY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692124793; x=1692729593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzBNQYVicQSwSF5KSP16nLKCUU/4QI1bGRg+lDxdAUk=;
 b=lqsHvc4FgQVdO8D9TwDMrEEFxyz0kVbCRE/38EEiGyQyyj9fBbRwIHCeZUTUp3fpns
 QLh5dsPWyc31PROmvfRncgoCG3RkmvugdowkOAqpvgzkRaV6NmF5RL1ZnpHniM9LhEum
 2YUHaLG+sEUhAeltIa22b2nrZCW2zOpgyY2SMDV7Y7rXv97a5HUlcBmpO/WeoBT/zgL6
 eSyExkgTCM8JM4AzVLoOCFjzj8oABhV5NEwDH5lBySrdk7cdPn5JcXMUgSl/gSChQ94y
 9XNishLJmfwRKNrpVIKNIc8Vuo1ZrCto+UJPBK4SWmg6LeGzoEsQ4FvYDiL8S27A6DgG
 sUHw==
X-Gm-Message-State: AOJu0YxNeu0E6ypM3juF7BNyto9+AJ1DtpUwEdg+hgxaT1JhLN74BPOQ
 KMKKBLj8cUfGsopQUeflbt8vI9fbWovT0m1MyrJYkQ==
X-Google-Smtp-Source: AGHT+IEK1rqEUdL0jGRqKFy4RoJkkihkF0Qi5cG8bsPrN9kAkn39VsV3xkrP6ekCGLwplAWaDAUJ62BBX+GBt0OiO2w=
X-Received: by 2002:a17:907:774e:b0:99b:4bab:2841 with SMTP id
 kx14-20020a170907774e00b0099b4bab2841mr2726639ejc.26.1692124792815; Tue, 15
 Aug 2023 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
In-Reply-To: <20230815162623.1824357-3-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 12:39:40 -0600
Message-ID: <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

Hi Sughosh,

On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
> ---
> Changes since RFC series:
> * Remove the default value of the config symbol.
> * s/include_files/dtsi_include_list
> * Add all the dtsi files being included as dependency for the dtb
>   target.
>
>  lib/efi_loader/Kconfig             |  8 ++++++++
>  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
>  scripts/Makefile.lib               | 18 +++++++++++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
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

Do we need this, or could we name it as we do with the .env file? It
seems confusing to have to set this for each board - it might be
better to have it in a defined location.

Another idea is that we could use binman to pull this in, e.g. with an
option to insert the capsule key during the build. Then it can be
anywhere on the binman path.

As you know I am not a fan of these opaque binaries when we have a
nice self-describing format like devicetre. But we can worry about
that problem another time.

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
> index 368b5a3e28..2e71f190bc 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,7 +334,23 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>                 ; \
>         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
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
> +dtsi_include_list += $(capsule_esl_dtsi)
> +endif
> +
> +dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> +
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
>         $(call if_changed_dep,dtc)
>
>  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
> --
> 2.34.1
>

Regards,
Simon
