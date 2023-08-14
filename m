Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7887EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 18:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414E5866DA;
	Mon, 14 Aug 2023 20:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pVqqufap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB5086828; Mon, 14 Aug 2023 20:49:50 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4474B80842
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 20:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fe48d0ab0fso7182897e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692038987; x=1692643787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1kmtkVeaxseAYOymz14EDvPi5gS0m+eKXZgXaOJYzA=;
 b=pVqqufapkglNLKxRw/qmOFADZc8pEYL+TT2+z3PMcM8VB1cyzBErsMyKikPVrHE/yQ
 BdlYmRb/eA44vzXp8cDVRkA5Ho4vVyvX24YSyw+O3Ju6OUB6M6RaoxNI8COM1nxXDBcm
 LyAfIdeAmMGO5r/eqhpH3zArUgnR8kvJHhpm9WBf6Li2o3Yl4PqNo3JdKm7APvH9NxL5
 bvCcY/L1akdKXqpsQTQtFZC63lWLqWchCxPHcDzyWZ8JfMRG+KyN2PCMh8ndtM8OTxV9
 BmYRJif2tWPNUc5QYhcNbjoWBTHUfllJ0ceYnKAlqIGAsQy4fumIgiYqxHo1B5m7jc9Z
 25hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692038987; x=1692643787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1kmtkVeaxseAYOymz14EDvPi5gS0m+eKXZgXaOJYzA=;
 b=LKorMA3s1YloYP2xt0zrQoSsjDkebVBoYysh3+NIiDKKqAsjjU5PhX2gDXIV5Pf/Zb
 PacAl5wfo2xdjrB3gu3Q+t/uzduAeGyD2oJ54G7/+pIruTge63cJDbtUznP64tpiuMH3
 mLMCWy9YJIuWp/EmhC9ocVoscwINu9KP8G+bcZ8VLM3ReRuPHbhTgCHHe9+avlpZgIVu
 5Nh8KDowm3Y+poVMPnuOMSmJHCQAJ7FIh67pP8FLFAG6gCUaiiiKRjaTtkY14jdn9KPd
 +RQg2YuEF5+lXHteXkUS8XZHuT12LIT39ZFC6fVb4hOCU+41iuHJpBzEu1XcxKI6pR/5
 hUMg==
X-Gm-Message-State: AOJu0YwPpRvKRU5KV5VYILa3nOuvktEILZCuoA/vTe9jz1O/0nsq+/fG
 qCBHZMCSlQYP13I4MVJcmcBEoaitPNits9nNJAhzxg==
X-Google-Smtp-Source: AGHT+IH5FjhUiI961Mo/ujk5A9QY2oHQpaZQ4NcSR7LrrL4fNeLdb/hQ7zTYEysqmFwh9UELXU86yCxAZDVmADe6Yzg=
X-Received: by 2002:a05:6512:3d0b:b0:4fd:faa5:64ed with SMTP id
 d11-20020a0565123d0b00b004fdfaa564edmr9109105lfv.11.1692038987325; Mon, 14
 Aug 2023 11:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-3-sughosh.ganu@linaro.org>
 <20230814150430.GX3630934@bill-the-cat>
In-Reply-To: <20230814150430.GX3630934@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Aug 2023 00:19:36 +0530
Message-ID: <CADg8p96MtFiWf=u2j6b9+ZxfGSyAZ=T11CDd6pFifLz_Bh4qwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

hi Tom,

On Mon, 14 Aug 2023 at 20:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Aug 14, 2023 at 02:33:07PM +0530, Sughosh Ganu wrote:
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
> >  lib/efi_loader/Kconfig             |  9 +++++++++
> >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> >  scripts/Makefile.lib               | 17 +++++++++++++++++
> >  3 files changed, 37 insertions(+)
> >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 9989e3f384..f40a62a0ba 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -272,6 +272,15 @@ config EFI_CAPSULE_MAX
> >         Select the max capsule index value used for capsule report
> >         variables. This value is used to create CapsuleMax variable.
> >
> > +config EFI_CAPSULE_ESL_FILE
> > +     string "Path to the EFI Signature List File"
> > +     default ""
>
> No default.

I think Simon wanted to keep this so that it would not break the build
if no option was provided.

>
> [snip]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index f41b16781d..cf4eef0b05 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -334,8 +334,25 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >               ; \
> >       sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> >
> > +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> > +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> > +cmd_capsule_esl_gen = \
> > +     $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
> > +
> > +$(obj)/.capsule_esl.dtsi:
> > +     $(call cmd_capsule_esl_gen)
> > +
> > +capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> > +capsule_esl_dtsi = .capsule_esl.dtsi
> > +capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
>
> This seems right.
>
> > +include_files += $(capsule_esl_dtsi)
> > +
> > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(obj)/.capsule_esl.dtsi FORCE
> > +     $(call if_changed_dep,dtc)
> > +else
> >  $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> >       $(call if_changed_dep,dtc)
> > +endif
>
> I think this implies to me that we should have been depending on
> $(include_files) (once renamed to be less vague) here already ?

Okay. That can be done. I had kept the .capsule_esl.dtsi as a
dependency primarily because that file needs to be generated before it
can be included. I suppose the same can apply to some other dtsi as
well.

-sughosh
