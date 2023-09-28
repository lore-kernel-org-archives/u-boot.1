Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47339E732DE
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B895186E5E;
	Thu, 28 Sep 2023 16:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHPF2qmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B629D86E60; Thu, 28 Sep 2023 16:41:09 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8A78654D
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-533c4d20b33so21416161a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695912067; x=1696516867; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twJp+/yTzBgv2oSbg7xDBC6d4538NZzYE8uy6QtnHO8=;
 b=NHPF2qmx+g49e/wqA+Lsq5+6iekiAaQF1PAsO0K10pKqwP0VZUjsZMKlwApGxi7OxS
 Y7xwP15lhn6l+3Iejw3LgMQkTPE3onApx4xOnl/gSsR0QMxkUC7ICRaVRDdEHCnU2r/e
 VSJZK4vyv/iyO7fd3NBSUe7mHnXw/y6HrwVFb1C0EenXYk7kcCQPO33nYq69Tfifm2Rs
 fhXoVU/D/IPA0j5KdmemGdqH+Z585keuAc924hoNUtHFhiEkkSsjNnlCPjy2bJv+jUdx
 mFV9qEqzIgK09A/8gzzgB695QcMDTXX131phWsCcOyLUPtDDVyNYG0WOl9tIjqkovOzL
 bHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695912067; x=1696516867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twJp+/yTzBgv2oSbg7xDBC6d4538NZzYE8uy6QtnHO8=;
 b=P4Mo6OTmxWJNbHsgd57j6gOOcKRr15aq4ZmaIT7UcH67FvZrSvXGgxbEcR2f0F6IEs
 SealxqtUHdiSCZpiiKzhjk8B1sjGF7yv8rNCs3RF/2/DW9SfZAfBWsWxNm8ivMJX5Bvn
 0/4NjOWBT7Wi91X1ueK61vwCBFtstFob9rVIsPwxQ/T4vooW4RAkxwtMG+Gze64tSJYZ
 JUEG5uQIjdhf1rZArS4Sk3Hy0VhYfj+vMRA/d+NDjdOzwdUxa/Oq7LzMx1G2RCFpBLYe
 ynN8Ny4iTFFUZwPuAUHMuwY6vgh0fluwSlh9OsjUFWbe4K0obiD78bT28hTRHIJlotO5
 PaJg==
X-Gm-Message-State: AOJu0YxeYD8YBrCsRYbXpAT3Lz2xwKq8iJoGFh2Pja6iK8WoHqtfeyt0
 bmNkYi3sEhbYnshz0Se3MdUU7p1vWpPcdd5QomBr0mNP6H8=
X-Google-Smtp-Source: AGHT+IF4dbhX9BagTNgzLE+vuPSLjlS5JiDvI/upAfSOgWpQXl8WfmLjovQWzVfSP9GoQ1hacTvQtnbSZ6AHqcbIa/Y=
X-Received: by 2002:a05:6402:5106:b0:533:26cd:37c4 with SMTP id
 m6-20020a056402510600b0053326cd37c4mr1408307edd.11.1695912066868; Thu, 28 Sep
 2023 07:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
 <CAEUhbmU0t0LE2M+9L-heY3UZBgNsgDuPN-JheFsUwMfBndE+Dw@mail.gmail.com>
 <CAPnjgZ3JnvcoQ1Vi-AXnW6-wC0H_FNqoQJp31Kdyp+TBOL6Dnw@mail.gmail.com>
In-Reply-To: <CAPnjgZ3JnvcoQ1Vi-AXnW6-wC0H_FNqoQJp31Kdyp+TBOL6Dnw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 28 Sep 2023 22:40:55 +0800
Message-ID: <CAEUhbmWwBjgS+b7oTQLg9zUwFvxQFwO+eomgn9ZJhS32BKaE1g@mail.gmail.com>
Subject: Re: SSE instructions
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Thu, Sep 28, 2023 at 10:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Bin,
>
> On Thu, 28 Sept 2023 at 08:15, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Sep 28, 2023 at 10:41=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Bin,
> > >
> > > U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
> > > compiler error:
> > >
> > > drivers/video/console_truetype.c: In function 'frac':
> > > drivers/video/console_truetype.c:30:15: error: SSE register return
> > > with SSE disabled
> > > 30 | static double frac(double val)
> > >
> > > Do you know how to enable SSE for 64-bit?
> > >
> >
> > The following patch could enable SSE for 64-bit:
> >
> > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > index 26ec1af2f0..250d7c9948 100644
> > --- a/arch/x86/config.mk
> > +++ b/arch/x86/config.mk
> > @@ -27,7 +27,7 @@ ifeq ($(IS_32BIT),y)
> >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> >  else
> >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common
> > -march=3Dcore2 -m64
> > -PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > +PLATFORM_CPPFLAGS +=3D -mno-mmx
> >  endif
> >
> > However as Heinrich mentioned, U-Boot codes should be written in a
> > "floating point free" way.
> >
> > The fix should really be updating console_truetype.c to use integers
> > instead of using float/double.
>
> Yes, I can do that, but it hangs going into 64-bit mode, which is
> presumably why the flag was added. In fact it was your commit!

Yeah, indeed it was commit dd4611dea435 ("x86: Ensure no instruction
sets of MMX/SSE are generated in 64-bit build") and the commit message
said the reason.

>
> Is there some missing init somewhere?
>

I believe we should turn on X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT on CR4
to enable SSE.

Regards,
Bin
