Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17006C2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A9386B53;
	Thu, 17 Aug 2023 15:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gPMkOLdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C5F86B4D; Thu, 17 Aug 2023 15:37:54 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDE286B33
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe2de785e7so12467011e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692279471; x=1692884271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qv1ajXwbmujhw/z/2Ss+QSAnB10h7O7hH/lwqpe5Gs=;
 b=gPMkOLdDJBuH8Udl6lVHpzZMfiQQP9WkIQ5XqIwlHnFvRs7HsjDzauW8VrnGaj71av
 Wv53hsnEcQ3f7Wm/majSeH83wqIsrxV+hCX3NJ8GJWAML5C6Ik6rNkQpX7kV8qfec1ge
 QeCUntdFAupr2peHxVsczmkeZZhCC5SE3U2SlWlfOO4T1BP7exFnwh5orYXhUJSGJyNC
 3yCM9WjfCrGAfLyBaAbuR3Ypl38wJ5+8w1x+nW9gWzqFwjafeR10Z8oxuLZdfaPhUOjW
 Sh5J1ifZ5R2KZPaBnVbPn6Y51XmN1BlM5Ro0XSAn9vBDiX7b/oTHRAZBXwoDIBv1Mb1O
 9uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279471; x=1692884271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qv1ajXwbmujhw/z/2Ss+QSAnB10h7O7hH/lwqpe5Gs=;
 b=bKWjgkijRnJHjjg/Zyw+N4b6yElEMQWgdITrVAmbVBstEq8zAGCRIm0XJh937fOXQj
 SazQy7hDuQf5kfYUIVQfwm8x2Z+/PdeJoItWGKC3w8i/XZRiWmSuWg1xDf9hfEOx61zp
 M9s/mIReRSXZifaf9jkd+4Go7awlqEswSAA4hkc8GhZ80JZ2IC0uEYnHnJGt189FdwB5
 ZUyLkCn8JPJeMi9KgFw+O5m2Y8gst31sjFw6v70u12931Dq2i2ih8xBfkAypBYdL6O9w
 M4eylpEUex2WwTWVzMZQlHvLqYEkh3+gdDWRq+mT+n+Cg2FezWLOxGQotn9wDuOrYzHE
 zWkQ==
X-Gm-Message-State: AOJu0YwXPt6J5mB9allPCJvJd7UDE3WuR4SnZ80x+u9GoOOCCMPkUsEM
 f+c6y5SW92aU4NdOBym+2baiBruXdL4XiYUV1r0Ur++s3owpZPGF
X-Google-Smtp-Source: AGHT+IEms3DV7J/qfJrYDYzgz3g4M7MssxCB4BO/uMgEcjsW3/cQ0bLlOjIMEwL6t3JSlbIeTWcv26NfUy/VRjRtUxs=
X-Received: by 2002:a05:6512:398c:b0:4fd:cbd6:d2ff with SMTP id
 j12-20020a056512398c00b004fdcbd6d2ffmr4612129lfu.33.1692279471399; Thu, 17
 Aug 2023 06:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-4-sughosh.ganu@linaro.org>
 <CAC_iWjJ_FJZd92WzSnAZNupwxLq5atTsvHCqy4i_3q7E23Rzvg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ_FJZd92WzSnAZNupwxLq5atTsvHCqy4i_3q7E23Rzvg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 17 Aug 2023 19:07:39 +0530
Message-ID: <CADg8p97ZPmcbGm8YE_vc4ZoRWxi_CM1JJEHZUZhh2-1pf7JRNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

hi Ilias,

On Thu, 17 Aug 2023 at 17:29, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Thu, 17 Aug 2023 at 08:49, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The EFI capsule authentication logic in u-boot expects the public key
> > in the form of an EFI Signature List(ESL) to be provided as part of
> > the platform's dtb. Currently, the embedding of the ESL file into the
> > dtb needs to be done manually.
> >
> > Add a target for generating a dtsi file which contains the signature
> > node with the ESL file included as a property under the signature
> > node. Include the dtsi file in the dtb. This brings the embedding of
> > the ESL in the dtb into the U-Boot build flow.
> >
> > The path to the ESL file is specified through the
> > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Put only the setting of dtsi_include_list under the ifdef, moving
> >   the rest of the logic out of the ifdef.
> >
> >  lib/efi_loader/Kconfig             |  8 ++++++++
> >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> >  scripts/Makefile.lib               | 15 +++++++++++++++
> >  3 files changed, 34 insertions(+)
> >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 9989e3f384..d20aaab6db 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> >           Select the max capsule index value used for capsule report
> >           variables. This value is used to create CapsuleMax variable.
> >
> > +config EFI_CAPSULE_ESL_FILE
> > +       string "Path to the EFI Signature List File"
> > +       depends on EFI_CAPSULE_AUTHENTICATE
> > +       help
> > +         Provides the path to the EFI Signature List file which will
> > +         be embedded in the platform's device tree and used for
> > +         capsule authentication at the time of capsule update.
> > +
> >  config EFI_DEVICE_PATH_TO_TEXT
> >         bool "Device path to text protocol"
> >         default y
> > diff --git a/lib/efi_loader/capsule_esl.dtsi.in b/lib/efi_loader/capsule_esl.dtsi.in
> > new file mode 100644
> > index 0000000000..61a9f2b25e
> > --- /dev/null
> > +++ b/lib/efi_loader/capsule_esl.dtsi.in
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/**
> > + * Devicetree file with the public key EFI Signature List(ESL)
> > + * node. This file is used to generate the dtsi file to be
> > + * included into the DTB.
> > +*/
> > +/ {
> > +       signature {
> > +               capsule-key = /incbin/("ESL_BIN_FILE");
> > +       };
> > +};
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 8c5e25c31c..3cec46bb15 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -334,6 +334,21 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >                 ; \
> >         sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> >
> > +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> > +cmd_capsule_esl_gen = \
> > +       $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
> > +
> > +$(obj)/.capsule_esl.dtsi:
> > +       $(call cmd_capsule_esl_gen)
> > +
> > +capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> > +capsule_esl_dtsi = .capsule_esl.dtsi
>
> Any reason why cant reuse $capsule_esl_dtsi in capsule_esl_input_file?

Are you suggesting having a lib/efi_loader/.capsule_esl.dtsi as the
input file? I thought having that distinction in the names between the
input file and the generated file keeps things a bit more clear.

-sughosh

>
> Thanks
> /Ilias
> > +capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
> > +
> > +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> > +dtsi_include_list += $(capsule_esl_dtsi)
> > +endif
> > +
> >  dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> >
> >  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> > --
> > 2.34.1
> >
