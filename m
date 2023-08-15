Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC1C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 10:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC0C8685D;
	Tue, 15 Aug 2023 12:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQHRn/UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E5586970; Tue, 15 Aug 2023 12:01:44 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60E186604
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5234b80e9b6so7130970a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692093701; x=1692698501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dA0fWgFUOaRijQG7PJ/pDQ0C05m9oeA03/43kM0gO6U=;
 b=oQHRn/UCrelj49+/K9WEWYdma2yJYJWIfNq7pGG9EyYHPpcpRx3bNIyc/6OdcUn5Ci
 ZpH47+raJkXkBbsWa6i8pzKxB6DRaAIv4g3UPngnWg7ln/UMARSddoE+kRuQdMEuK8t/
 vptdvo90R4lP4sD0Y/sbsyVtXFWzxV/xkg5rWhP0qR28zkqxHelKt7MiTsQT2hWDG9sk
 E0CTB+yUIay+VsF8ZU8/hpukGRuks43IalFObPQXVnZATxMDBg4LY97AmzZ4jiWCG3fd
 I5QkIjyFvbJeCl/sKYSpHXofESTwigDbSufpSnI2I6mrY4dExVCyxwTPheO5kXSKJopf
 bKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692093701; x=1692698501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dA0fWgFUOaRijQG7PJ/pDQ0C05m9oeA03/43kM0gO6U=;
 b=Ea4g/V4Wx1bsu5JYKXnbxBXCNs++XXm90CWEZtm6wBF5Ey7ku5KCYuCb5ijXm+TWen
 O6TdelpEgqdYVIHrxtGJtW2pYcXT9gPMMzoIBYjcnfA2InMNSoBI3Rx44QsBHdIvl8t0
 D6z8YkYDBS7SiCFUa6Mk4zPLKzw/bzt1lNzBPtBiHUsKlkPK414Ec2gX5/Fr09iBaX/W
 4+frz3TIn5spy3riIgqhe/6Ryx9ECzVgBLTQFlPPcIXwDQkxvNmbNhLB4Vr6DcvakW2B
 OfnGXMsuKyhXvyN8sV3GHyST+hyNIACAoJNtXgF7p0u3g8IBYaIlayfaRP0NWo24VIZm
 JzTg==
X-Gm-Message-State: AOJu0YzNlIeXMeOxoVBYmvY1oWTnvlwpas8AX0R6Wrox/WiaXVZ7chFR
 42LTnOlX2PhdpXV3flWO7haRcwWZttN+hUDHnBQWrA==
X-Google-Smtp-Source: AGHT+IG7c/1h1qZ9CJC12o/WSWy3p+R+5OvLN5exOF4miVC5U9Dv0TH/W0kJECd89ZVoo/kS42yFQ5z+I0EPcQbif00=
X-Received: by 2002:aa7:d481:0:b0:523:b665:e48e with SMTP id
 b1-20020aa7d481000000b00523b665e48emr10686478edr.7.1692093700468; Tue, 15 Aug
 2023 03:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-3-sughosh.ganu@linaro.org>
 <20230814150430.GX3630934@bill-the-cat>
 <CADg8p96MtFiWf=u2j6b9+ZxfGSyAZ=T11CDd6pFifLz_Bh4qwQ@mail.gmail.com>
 <20230814191847.GG3630934@bill-the-cat>
In-Reply-To: <20230814191847.GG3630934@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Aug 2023 15:31:29 +0530
Message-ID: <CADg8p95STxaruwZL8p5Pbkm2tv1GdozprGTUT63r23_HDFLNhA@mail.gmail.com>
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

On Tue, 15 Aug 2023 at 00:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 15, 2023 at 12:19:36AM +0530, Sughosh Ganu wrote:
> > hi Tom,
> >
> > On Mon, 14 Aug 2023 at 20:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Aug 14, 2023 at 02:33:07PM +0530, Sughosh Ganu wrote:
> > > > The EFI capsule authentication logic in u-boot expects the public key
> > > > in the form of an EFI Signature List(ESL) to be provided as part of
> > > > the platform's dtb. Currently, the embedding of the ESL file into the
> > > > dtb needs to be done manually.
> > > >
> > > > Add a target for generating a dtsi file which contains the signature
> > > > node with the ESL file included as a property under the signature
> > > > node. Include the dtsi file in the dtb. This brings the embedding of
> > > > the ESL in the dtb into the U-Boot build flow.
> > > >
> > > > The path to the ESL file is specified through the
> > > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  lib/efi_loader/Kconfig             |  9 +++++++++
> > > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > > >  scripts/Makefile.lib               | 17 +++++++++++++++++
> > > >  3 files changed, 37 insertions(+)
> > > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 9989e3f384..f40a62a0ba 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -272,6 +272,15 @@ config EFI_CAPSULE_MAX
> > > >         Select the max capsule index value used for capsule report
> > > >         variables. This value is used to create CapsuleMax variable.
> > > >
> > > > +config EFI_CAPSULE_ESL_FILE
> > > > +     string "Path to the EFI Signature List File"
> > > > +     default ""
> > >
> > > No default.
> >
> > I think Simon wanted to keep this so that it would not break the build
> > if no option was provided.
>
> No, that means that there's a missing dependency.  Blank defaults are
> almost never right.  And "so that we don't break configs" means that
> something else is wrong, generally a missing dependency.  And maybe I
> cut out too much context here as yes, this option needs to depend on
> some part of the capsule framework.

Okay. Yes, the above config does actually depend on EFI_CAPSULE_AUTHENTICATE.

>
> > > [snip]
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index f41b16781d..cf4eef0b05 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -334,8 +334,25 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> > > >               ; \
> > > >       sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> > > >
> > > > +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> > > > +quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
> > > > +cmd_capsule_esl_gen = \
> > > > +     $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
> > > > +
> > > > +$(obj)/.capsule_esl.dtsi:
> > > > +     $(call cmd_capsule_esl_gen)
> > > > +
> > > > +capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> > > > +capsule_esl_dtsi = .capsule_esl.dtsi
> > > > +capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
> > >
> > > This seems right.
> > >
> > > > +include_files += $(capsule_esl_dtsi)
> > > > +
> > > > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(obj)/.capsule_esl.dtsi FORCE
> > > > +     $(call if_changed_dep,dtc)
> > > > +else
> > > >  $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> > > >       $(call if_changed_dep,dtc)
> > > > +endif
> > >
> > > I think this implies to me that we should have been depending on
> > > $(include_files) (once renamed to be less vague) here already ?
> >
> > Okay. That can be done. I had kept the .capsule_esl.dtsi as a
> > dependency primarily because that file needs to be generated before it
> > can be included. I suppose the same can apply to some other dtsi as
> > well.
>
> You shouldn't need to have it be explicit, if it's in dtsi_include_list
> as there's a rule so make can resolve how to satisfy the dependency.
> But since we dynamically #include the other files, I don't know that
> they will be caught with the normal dependency logic.  But, it will
> still be cleaner to have the dtb rules depend on the automagic #include
> files too, rather than special casing the rule here I believe.

Okay, in that case, there can be a single rule for making the dtb.
Only the logic for generating the .capsule_esl.dtsi can then be put
under the ifdef.

-sughosh
