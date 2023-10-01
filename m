Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B5E78493
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 21:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB3B1870C5;
	Sun,  1 Oct 2023 23:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KktuxMqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0775870B6; Sun,  1 Oct 2023 23:08:25 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E323D86A28
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 23:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso2108981f8f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696194503; x=1696799303; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXbWCKRFqD2vKHh5lMXx+wSppQg6yAkbPcmVqdWebh8=;
 b=KktuxMqbLhsY4nbY38nTBfblCk2aH9RDZFTuLW0h4XcG+Ksp7tWYdqIBF2MZDBkl1M
 Vo3R87XdDAn68m57PyLf0YiqyrKv/Jgltauurf/Oicj4kIGnAbVSrLm1w+3GPN1p1mmr
 MZmUw1Plssooh09/PikUA58zfar+vb6vc2kJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696194503; x=1696799303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXbWCKRFqD2vKHh5lMXx+wSppQg6yAkbPcmVqdWebh8=;
 b=FIdbbImnTWRctuHVq3RX5fEMg7619p5UmjMElboqd03WdKQtWxi7Vf5K76+QvQ3XFs
 XFbZQxcH4cGyxB27sRD9gIv/x9sI7qkuDcb3Aq/eb6c6eNqEjnNx8BnDhuLXDb7AkdLE
 ju9iTC3fe5z2MQsgr9mujYSU6ytAnUoZ8SNj+p5bYoO1hQ19IWZLgVyngSmCQmwlG8QL
 calGzxm7Q3iOYFGzOrWzExaFJObD6tTc20J6/mJmDHQWq8KMiHb+stiRY/pGQsuH5QrQ
 m5jOPbTAhlhuGZvKVardM5zTJQVw6o55g806arAJt8HnTGvt4/PkIMig+F0MYMSKQuLm
 waUw==
X-Gm-Message-State: AOJu0YxZr3rUtM3TkX9vTTe2sWz2TnmaENYTpJw+ItpprndmnG5OEZNR
 HqXjaDpT8W9tu17dP1SJ7jumm0DjyhBqE2DZ+j2ROA==
X-Google-Smtp-Source: AGHT+IFiD+hIKoaT5T9N6uRIMWe4jnm1QGYuSDn5YivapUW8TqJWXzeVG8srsJ0/01XoDznWxtcttfytinPML8JKR3M=
X-Received: by 2002:adf:e68a:0:b0:31f:db12:f5db with SMTP id
 r10-20020adfe68a000000b0031fdb12f5dbmr8550471wrm.32.1696194503166; Sun, 01
 Oct 2023 14:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
 <CAEUhbmU0t0LE2M+9L-heY3UZBgNsgDuPN-JheFsUwMfBndE+Dw@mail.gmail.com>
 <CAPnjgZ3JnvcoQ1Vi-AXnW6-wC0H_FNqoQJp31Kdyp+TBOL6Dnw@mail.gmail.com>
 <CAEUhbmWwBjgS+b7oTQLg9zUwFvxQFwO+eomgn9ZJhS32BKaE1g@mail.gmail.com>
In-Reply-To: <CAEUhbmWwBjgS+b7oTQLg9zUwFvxQFwO+eomgn9ZJhS32BKaE1g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 15:08:06 -0600
Message-ID: <CAPnjgZ2C3LHX18=MJyPU9_MMG2-ByYHrKw95=f-rnb2xnpJW3A@mail.gmail.com>
Subject: Re: SSE instructions
To: Bin Meng <bmeng.cn@gmail.com>
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

Hi Bin,

On Thu, 28 Sept 2023 at 08:41, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Sep 28, 2023 at 10:20=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Bin,
> >
> > On Thu, 28 Sept 2023 at 08:15, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, Sep 28, 2023 at 10:41=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > Hi Bin,
> > > >
> > > > U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get=
 a
> > > > compiler error:
> > > >
> > > > drivers/video/console_truetype.c: In function 'frac':
> > > > drivers/video/console_truetype.c:30:15: error: SSE register return
> > > > with SSE disabled
> > > > 30 | static double frac(double val)
> > > >
> > > > Do you know how to enable SSE for 64-bit?
> > > >
> > >
> > > The following patch could enable SSE for 64-bit:
> > >
> > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > index 26ec1af2f0..250d7c9948 100644
> > > --- a/arch/x86/config.mk
> > > +++ b/arch/x86/config.mk
> > > @@ -27,7 +27,7 @@ ifeq ($(IS_32BIT),y)
> > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > >  else
> > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common
> > > -march=3Dcore2 -m64
> > > -PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > +PLATFORM_CPPFLAGS +=3D -mno-mmx
> > >  endif
> > >
> > > However as Heinrich mentioned, U-Boot codes should be written in a
> > > "floating point free" way.
> > >
> > > The fix should really be updating console_truetype.c to use integers
> > > instead of using float/double.
> >
> > Yes, I can do that, but it hangs going into 64-bit mode, which is
> > presumably why the flag was added. In fact it was your commit!
>
> Yeah, indeed it was commit dd4611dea435 ("x86: Ensure no instruction
> sets of MMX/SSE are generated in 64-bit build") and the commit message
> said the reason.
>
> >
> > Is there some missing init somewhere?
> >
>
> I believe we should turn on X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT on CR4
> to enable SSE.

OK thank you, that worked. I will send a few patches.

Regards,
Simon
