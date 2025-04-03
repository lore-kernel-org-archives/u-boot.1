Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2395C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 10:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2F081CF0;
	Thu,  3 Apr 2025 12:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hDQMyxXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5960281FFC; Thu,  3 Apr 2025 12:59:06 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E2480194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 12:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c5e1b40f68so81412085a.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743677943; x=1744282743; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atx9FK4FyM5DEncz6yLRmFUclOgAP+10WQPGpGsMoQs=;
 b=hDQMyxXqgXIPRC3sUGH2zoEXGAimy9YHT1zNS0OmKiz8f1uOTKQQYHXFGAX0WnRqFi
 CRAAqZjh5ISFdHN2uBeEvAuqkwk5IXtl0fVptooGhZfyHeAAIrSsSA0257ph4LS09buX
 bTQlEMI02WbCoHUfmRgLHpHNAt4oSY9jyckUkxXiRczYtNBI3A4IvO742cxZl/viGtLx
 93arpbM9UOVboEIKnkrdIkQXuO6b6Qkp4HD5l854j3UFiE3Nubs1OsOQGhlQwBWiG2uL
 MDhvxWBDIsyvJiQmf/Ndijf9qtVUaKJKE5TwHq84Cd68tsiHWuGcYBWmgmIvoCj8nHL8
 dkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743677943; x=1744282743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atx9FK4FyM5DEncz6yLRmFUclOgAP+10WQPGpGsMoQs=;
 b=ErIoKJoD+RU4kAzHOcwIpcvnJELLwd+CdfWe/rQDk8KEls43ES1UOFEBPFA5Y/BEQB
 uQaKbCswYdpwlQS70RDipohDig0sYxIrgaqHcNpzKgKAeIh37s2512/D1mjRnn4qYgib
 x65ga0gobOMQXTTPCgR/jH/bfcS3m38v7D56YD1NhDoM73JcurwufiwfU1HydG9wgJyw
 688akT9FYF+C6vSIIriIGgtaOXe3nLzdwkVIc4gDCkCGdQZ3w/bj9NfLnHEV/h88Zcdi
 QpEl0KJz7qwzbZsqH9+vqHG5RTENWELennLrAnmDhfxKso4GZ2ZyflMGW19HocHwjtr4
 qy6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY+nchKAcmzV8VOWLgatr1lseTFJT3v9pPt+DgdsYNeeOLouPPgbGSgQ9+AKDK7aVSKcT/0hk=@lists.denx.de
X-Gm-Message-State: AOJu0YzaLBRcSVZ1V0MVHYXC+tsQqVIAQ1w3tsFAdvnAllylaTg6pIvX
 RM2GcMvOB+YH8CsBvKzjRPUFSoeNGcFj1+zdz98qtrL+/7PkKk7lKvJFgAL30WgwJo6kMz1j5dg
 0P4HpoXQHpSCX8ElV/FyBHGZSzUR99G+K4vztBg==
X-Gm-Gg: ASbGncucYUYJ0FQ/8ccWDQDF27AuF58kaReYwT0fV4/x7niiQpXN4r8e1ycEXNyU0qI
 MHFWkDzNF4xjxZ0V0KgjxpubI4F2hWwnMRx6pJa3vUs/8jyRmM/URWq6WdH+zMI7JkEmqXCEPAb
 PaICq+b6MfVx4xhxQyag0wE195Nd0=
X-Google-Smtp-Source: AGHT+IHcyG+eRunibEaELf8WqMWtxAThKiFnuZuxHY+xRviwiuUhJYua/T9tTcK0yZ4BPmV+4r6CLLYiKrRFeAjVRRI=
X-Received: by 2002:a05:620a:601a:b0:7c5:d1b3:d9b with SMTP id
 af79cd13be357-7c6862e716cmr3153899785a.10.1743677942952; Thu, 03 Apr 2025
 03:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
 <20250311133506.124914-4-mchitale@ventanamicro.com>
 <94b900c3-56bd-41fa-a2de-a47b21e02ee9@gmx.de>
In-Reply-To: <94b900c3-56bd-41fa-a2de-a47b21e02ee9@gmx.de>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Thu, 3 Apr 2025 16:28:27 +0530
X-Gm-Features: AQ5f1JptB4fZOUChese7c2HX-JD65_aaoybzlf7AY8wrgvONXTeXCq8CQaVHN3g
Message-ID: <CAN37VV57bGAo_ws8s6+-skZ-pWQPHJMb3H=phNiQK6eL5-mdGw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] booti/bootm: riscv: Verify image arch type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Atish Patra <atishp@atishpatra.org>, u-boot@lists.denx.de
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

On Tue, Mar 11, 2025 at 7:29=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 11.03.25 14:35, Mayuresh Chitale wrote:
> > Unlike ARM and X86, booting 32-bit images on 64-bit CPUs is currently
> > not supported for Risc-V. Hence, for bootm, disallow booting a FIT
> > or a legacy image that was built for an arch type which is different
> > than the current arch and for booti, set the arch type to be the
> > same as the current arch.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > ---
> >   arch/riscv/lib/bootm.c | 4 ++++
> >   cmd/booti.c            | 5 ++++-
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> > index 76c610bcee0..90f71bee6a5 100644
> > --- a/arch/riscv/lib/bootm.c
> > +++ b/arch/riscv/lib/bootm.c
> > @@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *im=
ages, int flag)
> >       announce_and_cleanup(fake);
> >
> >       if (!fake) {
> > +             if (images->os.arch !=3D IH_ARCH_DEFAULT) {
> > +                     printf("Image arch not compatible with host arch.=
\n");
> > +                     hang();
> > +             }
> >               if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
> >   #ifdef CONFIG_SMP
> >                       ret =3D smp_call_function(images->ep,
> > diff --git a/cmd/booti.c b/cmd/booti.c
> > index 1a57fe91397..00921ec4a9d 100644
> > --- a/cmd/booti.c
> > +++ b/cmd/booti.c
> > @@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[])
> >
> >       images.os.os =3D IH_OS_LINUX;
> >       if (IS_ENABLED(CONFIG_RISCV_SMODE))
>
> Why do we check for S-mode here? Wouldn't checking CONFIG_RISCV be more
> adequate? Think of a micro-controller with only M and U mode.
>
> sipeed_maix_bitm_defconfig has CONFIG_RISCV_MMODE=3Dy, CONFIG_CMD_BOOTI=
=3Dy.
>
> Cf. 3cedc97479ff ("RISCV: image: Add booti support")
>
> Otherwise looks good.

Thanks Heinrich. I will update the patch.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > -             images.os.arch =3D IH_ARCH_RISCV;
> > +             if (IS_ENABLED(CONFIG_64BIT))
> > +                     images.os.arch =3D IH_ARCH_RISCV64;
> > +             else
> > +                     images.os.arch =3D IH_ARCH_RISCV;
> >       else if (IS_ENABLED(CONFIG_ARM64))
> >               images.os.arch =3D IH_ARCH_ARM64;
> >
>
