Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B73C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8988187600;
	Wed, 20 Dec 2023 12:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LnjmeTFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E68876FF; Wed, 20 Dec 2023 12:28:04 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3038F87620
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e7f0bf46a2so14162627b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703071681; x=1703676481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vfDLIE52bS8HvDhc6h/xvsuBlhtPG04nzterLLUGczo=;
 b=LnjmeTFnCniTYnYNesRV0pG8TB9nf6P1sMYHNqkVx8pYlskeMrK5prbqqX7HjOzbCZ
 ixD05ziLJSffdvsShT8QE4En266uNPV30k4qwJYRvccbThDar+BRNRoE5G9aVrw0RAfI
 aCLidXnuaJm/ePfvJRCawYP3Fsz0hrd1bxPzHgafPebzE8X0KRRKg4LS3RtQ+3Z/DlWI
 UhA/GTJm3PEUUy8UDwn1gaV6S/blR6JEoMQIIXDehiPfih2rdQkSXhgRA+/Yr5lYp3fp
 6bFtkgoauov+4sB5C9/Ma5y3CFJxkGkWwXSC2mDXfjtBnwfaLhSjlanM/GfFzs60Ao0C
 b2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703071681; x=1703676481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfDLIE52bS8HvDhc6h/xvsuBlhtPG04nzterLLUGczo=;
 b=VMJpZM+i+BmWTcAr/m5eJvHvYTtMDH5U8LcMnIV+JoHX99LIFUyy+35KtHf+8SwmAF
 5yWFDo3ycAeRIm8ZtET3hl4PfXM8sRaRvLB8ADQ00Wpnokz7yLK9aIVKea71t+4Mx9K+
 u/uiafUeUHpevZK5xUjiBDfJfxb5niSOjAcaGgiml8p7sUdWWcCkeeA8fbDVqEMR5z0F
 uvaf2cmgPW4rdNiCPBPL+5l8ovKPLOBA6T6HqtBtgCfCN7mvwjAg8r9etRRBT/mVMwXD
 fdpRlyDSXm/f21OfE/+5ytWA0Z5juoW1z/2pKKgvG899/qLJvkx4/HB/j70qnEjoennT
 VDJQ==
X-Gm-Message-State: AOJu0YwmHJ7WcWz2HqnstzV4Qtd2n6Wf2zZ74HeX/0GuhN3y8yrVTTPD
 qYez11bOY5eC/OT9dJORJ/kF+246BEtechWyeIQHug==
X-Google-Smtp-Source: AGHT+IF/qoQCEJYf7aDwidLASTj7RR73NkX9AgNDY+/8Bv0rigRpTUvDHOzXlpsN2vKzS4i0Ez5rEcBMhBVy5wG0rx8=
X-Received: by 2002:a0d:d882:0:b0:5e7:e1da:53eb with SMTP id
 a124-20020a0dd882000000b005e7e1da53ebmr1699134ywe.88.1703071680937; Wed, 20
 Dec 2023 03:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-3-sumit.garg@linaro.org>
 <CAPnjgZ2v5WZ4aEOTqrGB7mxdmVAMYsHc8A7+YgUKubL51dp9WQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2v5WZ4aEOTqrGB7mxdmVAMYsHc8A7+YgUKubL51dp9WQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 16:57:49 +0530
Message-ID: <CAFA6WYPWVf+=Y5fLnhFJHsfZoqb6w8rvLOb_=G5zzU858B67pw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Makefile: Add support for DT bindings schema checks
To: Simon Glass <sjg@chromium.org>
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

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 06:51, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dtb files using the binding schema. Here we use
> > devicetree-rebasing directory to provide the DT bindings.
> >
> > Dependency:
> > -----------
> >
> > The DT schema project must be installed in order to validate the DT schema
> > binding documents and validate DTS files using the DT schema. The DT schema
> > project can be installed with pip::
> >
> >     pip3 install dtschema
> >
> > Note that 'dtschema' installation requires 'swig' and Python development
> > files installed first. On Debian/Ubuntu systems::
> >
> >     apt install swig python3-dev
> >
> > Testing:
> > --------
> >
> > Build dts files and check using DT binding schema:
> > $ make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Note, at this point dtbs_check is an optional build target as there are
> > many warnings generated due to custom DT properties used by many
> > platforms in u-boot. It is expected with these checks that compliance
> > with DT bindings to take place. Once that's done it can be added to CI
> > builds to remain compliant with DT bindings.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  Makefile             | 20 ++++++++++++++++++--
> >  scripts/Makefile.lib | 17 +++++++++++++++--
> >  2 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 750bbdb1b71..d8d168cd4c3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1158,12 +1158,28 @@ endif
> >         @# disabling OF_BOARD.
> >         $(call cmd,ofcheck,$(KCONFIG_CONFIG))
> >
> > -PHONY += dtbs
> > +PHONY += dtbs dtbs_check
> >  dtbs: dts/dt.dtb
> >         @:
> > -dts/dt.dtb: u-boot
> > +dts/dt.dtb: dtbs_prepare u-boot
> >         $(Q)$(MAKE) $(build)=dts dtbs
> >
> > +dtbs_prepare: prepare3
> > +
> > +ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
> > +export CHECK_DTBS=y
> > +endif
> > +
> > +ifneq ($(CHECK_DTBS),)
> > +dtbs_prepare: dt_binding_check
> > +endif
> > +
> > +dtbs_check: dt_binding_check dtbs
> > +
> > +DT_BINDING_DIR := devicetree-rebasing/Bindings
> > +dt_binding_check: scripts_dtc
> > +       $(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
> > +
> >  quiet_cmd_copy = COPY    $@
> >        cmd_copy = cp $< $@
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 16bbc277a9f..27b9437027c 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -356,8 +356,21 @@ endif
> >
> >  dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> >
> > -$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> > -       $(call if_changed_dep,dtc)
> > +ifneq ($(CHECK_DTBS),)
> > +DT_CHECKER ?= dt-validate
> > +DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > +DT_BINDING_DIR := devicetree-rebasing/Bindings
> > +DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > +
> > +quiet_cmd_dtb = DTC_CHK $@
> > +      cmd_dtb = $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > +else
> > +quiet_cmd_dtb = $(quiet_cmd_dtc)
> > +      cmd_dtb = $(cmd_dtc)
> > +endif
> > +
> > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FORCE
> > +       $(call if_changed_dep,dtb)
> >
> >  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
> >  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
> > --
> > 2.34.1
> >
>
> This is great.
>
> Can you put the commit message in doc/ somewhere?

As per your comment on the doc patch, this is already addressed.

-Sumit

>
> Regards,
> Simon
