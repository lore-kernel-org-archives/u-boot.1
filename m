Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6799C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7C583285;
	Fri, 30 May 2025 11:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ym1LZY7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CF483287; Fri, 30 May 2025 11:58:31 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24A383281
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-47698757053so24843001cf.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748599107; x=1749203907; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x67UGGtsM7gz9f7Qa0GohBSWo+VcsIAIybabK4KB9+U=;
 b=ym1LZY7iMO/qbpwLAtZc56A69kqPWqS7Wc1TVz5F55g1D+XRaH3SmcDyGToWxfsxc4
 PMLzK6HIByrTInGFD+nSq4iKHRbjdhybrmLFnUSt1EWKqSCr9C5w3w3PwkM6+PYEeNgd
 vngXhDOQtt8NovGEhoodORzuy89O6PKMuAt/2VGsWa0LVIlttgyny7H995WdN5vxNzXO
 gT4vgeCeOqyUPRI5iyaY0Q6xgZfnWBtyzgLcwrwGWb9tchHTo5qz3XdpagBHc2uX3agc
 xnk4wUpMWFnFboWSxvudZoteymEsGEHpuXBS7W4/Tl3jC+q5+BBqhtbSUoI7PDUi7UNF
 8Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748599107; x=1749203907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x67UGGtsM7gz9f7Qa0GohBSWo+VcsIAIybabK4KB9+U=;
 b=qbFo2ptWM0UUz4K6KwmabtImwxu/fpN8ylvcQQuZRTKUwm5EN8BPL9CZu5h5jVruPW
 pz0gTbuOJax+VGi1GMyP/v1VO8MZxJrXuBPCkUziSQUYEHGER51bCuPi63bfvp02RC20
 /vAhpXQmeXja7/YveOP4VMqqOK6IWgcykvyITaUGyUNcKLUivuTGIoeuPI2SxCRimEHB
 FHTHF7n4lwjs5KPYaErUSEouTm83hufoUBrGUckbrA1b04PPm2AWJFiXx1DkZUjapxl3
 P6gYcSMnr9P+Dgw/KJmDkC8PkVfemp+GxXU2MtouCPDgR+qW3UKlfSy88A/daK9gRfd2
 Dq2w==
X-Gm-Message-State: AOJu0YypetY+iI0lPgxkb33eO8a0o/W0AvFQUvViBv7LTYEDqFnjaNu1
 hODner6w6k/TBOkUM5wlRJuq1GdLIk5ngBpV6p+U0NC6dRc07dz3bjUSxIYNXXK72IPzAl9AbJq
 ex07hLsjL1/SSj1ZN8gX61okDim5VheSw7t2zmOUKrg==
X-Gm-Gg: ASbGnctFbrGJcC5QzCfuMTLnOa82kq0aqOKywFz1cyQ5sMMheGPIAR6Ab2Nm4/BkD3d
 sSJSHyxH9HyM5cQbApMOGk0wPtBHLKaN0z4a2kNa26rtk9huaPOqZICdVjjGj5pXmMdajxmdH0R
 CUJIFi/96m4Q1UZE58Fe8DTp/WZJksH8AmKA==
X-Google-Smtp-Source: AGHT+IFawe/ZEKb6Z0nA8MeJf6UDUA7ci/sJZW29NiYu+ErATW2BkAjuE9HRVobrjwGKQ51Iu/khXXicsc9+Ci7jFco=
X-Received: by 2002:a05:622a:259b:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-4a440054a2fmr51772331cf.17.1748599107553; Fri, 30 May 2025
 02:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-2-sughosh.ganu@linaro.org>
 <CAC_iWjJ1ghSnu5YAN3965mfL_SoadioFeV36yq+8K0fM1+Y=Kw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ1ghSnu5YAN3965mfL_SoadioFeV36yq+8K0fM1+Y=Kw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 30 May 2025 15:28:16 +0530
X-Gm-Features: AX0GCFuJWAcZIRG2_5N1l6BlJLIaDaucGyLcs0XvCB9891Lq8o-H83c8zW7Inq8
Message-ID: <CADg8p94eYzMpqVaoYtFewYEjgyFQip7hj-cXw-NQmTRQ6Wef5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] lmb: replace lmb_reserve() and lmb_alloc_addr()
 API's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Fri, 30 May 2025 at 13:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> [...]
>
>
> >         /*
> >          * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
> > diff --git a/cmd/load.c b/cmd/load.c
> > index 899bb4f598e..c3ef307bb68 100644
> > --- a/cmd/load.c
> > +++ b/cmd/load.c
> > @@ -178,8 +178,11 @@ static ulong load_serial(long offset)
> >  #endif
> >                     {
> >                         void *dst;
> > +                       phys_addr_t addr;
>
> addr is already defined as ulong in this function. You need a
> different name here.

Oh yes, I can use a different name. Although this should not be an
issue as the variable being added would be relevant only for the
encompassing block, where the other variable is not being used. But
this is definitely confusing, and I will change the name of the
variable.

> But on that why can't you use store_addr directly?

store_addr is of type ulong, and that results in a warning since the
API expects the address to be of type phys_addr_t. Typecasting it to a
void pointer does not help as we have at least one architecture
(riscv32) where the ulong will be 4 bytes, and the phys_addr_t has
been defined to be a 64 bit value.

-sughosh

>
> >
> > -                       ret = lmb_reserve(store_addr, binlen, LMB_NONE);
> > +                       addr = (phys_addr_t)store_addr;
> > +                       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
> > +                                           binlen, LMB_NONE);
> >                         if (ret) {
> >                                 printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
> >                                         store_addr, store_addr + binlen);
>
> [...]
>
> Thanks
> /Ilias
