Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C697C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BA5867F6;
	Thu, 17 Aug 2023 13:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZrMo95te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C29E686A2D; Thu, 17 Aug 2023 13:59:17 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F45986751
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so12348867e87.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692273554; x=1692878354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aHanIKL0tRXlZzUDFfUA6di5ZxkSeRoP0mMVhooGs+I=;
 b=ZrMo95te1UbcbPWO09RNUAgoWnnWft2P3S0HcYCZhupvcsJrCRo2Ak9cmTSskbcLem
 ZqmzUAD6Vosgk/9HoF8Yde9t6inFhwrvB87LLLgoYtAMILrCQNh+r44C4fhypUSTxuMP
 P5vfetIaCmg4LAsMblRX33VL/1b4AolXv/gmQqd0g8Ne564Dof8D39Eg8gzbpvr/kY9+
 I0xtSVmfnt2cRAklU9CxU59lAsgGxjtdjHkdEPRs7gB5SwzBNtU2EQcoR8xE20qGoRZm
 dcY6c6YT/epFxvx3Ir4nqZKxY7IiA7MDiVoHFalzJj6UHWcMuA3ASqWBz5TBdvbMCs76
 /n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692273554; x=1692878354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHanIKL0tRXlZzUDFfUA6di5ZxkSeRoP0mMVhooGs+I=;
 b=S3Nb1OE5kNZ23BHTr2xNLQurCrNaDNbFonRoB6oZIpW5p30BP5bGmMS0Sop67GYPwX
 hVA/8strPM0YEz1dItZT5XZauUwXj964MdpVSL2fBEbmiIU33Xyz6RJw2Pvtdhtftz+w
 xrafpZSzc0RBcp6h3SLt2m3fUcU/Z/DwCm4n1CT+RGp0g5ZKVNvMFTvB9ySSER2tjiU0
 bnfhGazZZQ2BaPWtthyxfSgUTpYOeSbV5A3WYP7hPgHbJ/K1zLTbTZ0lAtgB7ug6ckc6
 M2bw6FdaMZQi5prYpFLdSsZTBZGWPhBAgzBLEKHCOqoUpBUuQ1FcXAkFBPugUnbcp0nE
 Ytdg==
X-Gm-Message-State: AOJu0Yy6Yf1v21qkvEy5rKS5A+bkUSXPnCoUKyEF81R1OvEhIq2CJnuD
 HPnaZ2zsN6eoxmeKrmy7WhIKTIBQsB4GdxJQPNH0yw==
X-Google-Smtp-Source: AGHT+IEiWdohtVVRsC9fOhoI5+yIST30TEm2qlKvFN6gD3KGhCD7ePoo26ax4cB/tV0ANRCHqRjG73ajyNJBFEAq6so=
X-Received: by 2002:a19:381d:0:b0:4fe:2f8a:457e with SMTP id
 f29-20020a19381d000000b004fe2f8a457emr3310347lfa.43.1692273554308; Thu, 17
 Aug 2023 04:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-4-sughosh.ganu@linaro.org>
In-Reply-To: <20230817054856.2019253-4-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 14:58:38 +0300
Message-ID: <CAC_iWjJ_FJZd92WzSnAZNupwxLq5atTsvHCqy4i_3q7E23Rzvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] scripts/Makefile.lib: Embed capsule public key in
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

Hi Sughosh

On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
> Changes since V1:
> * Put only the setting of dtsi_include_list under the ifdef, moving
>   the rest of the logic out of the ifdef.
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

Any reason why cant reuse $capsule_esl_dtsi in capsule_esl_input_file?

Thanks
/Ilias
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
