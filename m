Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA7C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 04:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E101869AD;
	Wed, 16 Aug 2023 06:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvabZ7PO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C4C869B5; Wed, 16 Aug 2023 06:29:53 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64802833F5
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so7953426a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692160191; x=1692764991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r1Vm9bIJtMzzCwJ8nP7e4xZbXDBddllSWTpMsAPgCc8=;
 b=SvabZ7POmxGmhSahJMW20392pLEyfZKJbpEe8orpf2DyXIbWxRMU+Gc5wACQm4AiXn
 95cbwn9n9dRUkgSQVq2brwL3DOA4hVaHOwvpRJZ5xZmp0TIeJDTmJElbQ/2i9I+K5QaG
 tU7Ro7Z/atWxNfCsHArRhTKnylTNZ9Ywv0UrZyBCT9vEyS48HryIO6z8Y5NMfKt20BeJ
 RrCFL1JrQHA4bXXG4UAitb6S1dTV5SNHQZJQBf04sS+AucYn3M3fftjNjj8dIi7fULou
 ahYVngjFC7MK4U2y+ucGSi8WA7fDpX329EaqRX+jUE0wRx7lRRFiHve/5fyjUr9elz6a
 t5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692160191; x=1692764991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1Vm9bIJtMzzCwJ8nP7e4xZbXDBddllSWTpMsAPgCc8=;
 b=P/TwGJR9xW1YdavLrajvAWe7v/r+c8xuf7Z9KtMJSwTYibSuxR+2lufQuUZkxPwMy7
 qnFCb799bbwBmzjoFkiV/NQ3WRERm+gdx99UcjuE45NtgL6LJZkHbaS1MuhPoN5UEvQh
 VFwLQ0vv4tH8hAJVrxfbFSltdwa5VfOkOpzrRVxwdwQ7rILNdxXadUjEmcy5rL2OFnW/
 M5slgGut/c16A1z9DvxvJVmuLYKiwLHd1RXcQADWIMn0CWueaQvWtJ79sinkoJJPquzZ
 CrateuSoLDcsG7aaWK+rJ3u8FII889Skau2oNvJrCZv2vsRdQzqyLhcFr2FRti3/SWyk
 CxVA==
X-Gm-Message-State: AOJu0Yxv3klUbWMdDbPooEAb2FbS2Uk+wX7eWpjzySSlhTMJKA/Cl0rE
 sOBtx/d8f/EDFxcwHGrYD+A9ix7cQ/2xtummJlRXbQ==
X-Google-Smtp-Source: AGHT+IGznWxn0T3LwAMwlP2K7LtSFVh55A44ZR3uc+6X/INfa+8LJMG6Dr45f1HuFdb1zpnmoFip6fb3U31dPlPAXkI=
X-Received: by 2002:aa7:d143:0:b0:523:bfec:4902 with SMTP id
 r3-20020aa7d143000000b00523bfec4902mr660482edo.0.1692160190981; Tue, 15 Aug
 2023 21:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <20230815202402.GD3630934@bill-the-cat>
In-Reply-To: <20230815202402.GD3630934@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 16 Aug 2023 09:59:39 +0530
Message-ID: <CADg8p96_QTd2m74PsQeMcyk-9Ryb6U+dUvVantuaSDC3t=43uw@mail.gmail.com>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
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

On Wed, 16 Aug 2023 at 01:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 15, 2023 at 09:56:20PM +0530, Sughosh Ganu wrote:
>
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
> [snip]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 368b5a3e28..2e71f190bc 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -334,7 +334,23 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> >               ; \
> >       sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
> >
> > -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
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
> > +dtsi_include_list += $(capsule_esl_dtsi)
> > +endif
>
> We should only need to ifdef around appending to dtsi_include_list.  The
> rest we can / should just leave always there, that's cleaner reading.

Okay

>
> > +
> > +dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
> > +
> > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
>
> This part here is a separate bugfix and we should do that as patch 2,
> and the rest of the changes here as patch 3.

Will put this in a separate patch. Thanks.

-sughosh
