Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07453E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 07:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AAF87107;
	Mon,  2 Oct 2023 09:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wj0Ypk6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FC18712E; Mon,  2 Oct 2023 09:41:08 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78517870FB
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 09:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bffc55af02so247363251fa.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696232466; x=1696837266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtveoxAHVhlJIobItiqft5qDEwoNtrI7BKqjyjwjWjg=;
 b=Wj0Ypk6NzGvIIaRF0+KSdt81EYIbpLHRxMFORs+JBJJBGffHbboyTeyX2j8hta8Rx3
 PXvWWZmIxp9p3uHOlqQI5bRZxa7dqg+5oMjZwGxerAc5TiaogJGRBqUH2Kc0iTnFuZ+J
 /VASABThv2evUPEa5MeR4pRl02jFy1mDZleY3VLM4vo9VvAd9Lmox7TzXY88gFW0XQ6r
 v7Q8CJ0ugx90lnYdTc5d9Y6RWwWxkXULtM06mmWiowNW1wxBLwcfeabf5oCHGCf9cR94
 QbDdbJ11vmake/vhKo41cy8wzGVHD+LgXeM6PcRO+gsFGel3j0Bqzn9wNEHa8hI477o5
 lPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696232466; x=1696837266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtveoxAHVhlJIobItiqft5qDEwoNtrI7BKqjyjwjWjg=;
 b=EcL2U2CbdmP1B/Lfl2QUpHp/Z9FNCrp/rEjrLi/QvOFL+BL+/PePja/aLV8Jytahk8
 ocdaBMET1GIwx7hOsUtQ2WlM7LYGHbJaglaMBMsGy9ICZnsiB9EfO0qdC2FsUXezWjsE
 hEI12LVdUC/TAINKu/WpEhwgnEb47nhJSQdWIB7svTwQGA7M9lEDB2o40Nu0sdj1G/4G
 ne1msb5piFy1LJ8LvpLLZTMomzqVZ/fY/A2IvdAIG4IHtDDjvebqqwHdTQFjqgR/lvR7
 6XpZnXIt9ImrBPFnahj7sbQmiVNZaDAP0/uYtqSZ9L2eZvKyqFS2re2wKFKeAPY49RJk
 kKAw==
X-Gm-Message-State: AOJu0Yzia8OYCb6y5ao9x0JVAV4Y5CZHbfrXtPRkJ65lRYDTLnLd+txi
 EasKXFculYQ+gbPldcZJlJPSsNn2bCsTi6M0pS0=
X-Google-Smtp-Source: AGHT+IEftKbzxUsF74PK1hiqduvJ2meYUuExYYg81RWPkj/YiNjkDPTy6XkTKwqSHIjRFPdevaroKyALqurtODRCS6g=
X-Received: by 2002:a2e:9f14:0:b0:2bf:f989:b8e5 with SMTP id
 u20-20020a2e9f14000000b002bff989b8e5mr9263808ljk.33.1696232465334; Mon, 02
 Oct 2023 00:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
 <20230928122317.GD305624@bill-the-cat>
 <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
 <20230928161657.GE305624@bill-the-cat>
In-Reply-To: <20230928161657.GE305624@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Mon, 2 Oct 2023 00:40:54 -0700
Message-ID: <CAKUZ0+HnYEKxJUbXdrHPMUMVROcFSu7aA_mspd9OnaMCPozXTQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
To: Tom Rini <trini@konsulko.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
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

Hi Tom

I followed your suggestion to modify the code.
but still have errors.
Should I use my workaround?

Best regards,
Jim

On Thu, Sep 28, 2023 at 9:17=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Sep 28, 2023 at 10:32:51PM +0800, Jim Liu wrote:
> > Hi  Tom
> >
> > Thanks for your understanding.
> > but  this patch  is an incomplete patch.
> > After I applied this patch  I had another error.
> >
> > arch/arm/cpu/armv8/cache_v8.c:773:2: error: #error Please describe
> > your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
> >   773 | #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP
> > and enable dcache.
> >
> > This error is the same as that link.
>
> Please use that patch as a starting point (and also possibly needing to
> grab
> https://patchwork.ozlabs.org/project/uboot/patch/20230822075112.717992-2-=
bhupesh.sharma@linaro.org/
> as that's how I'd like to proceed with addressing this generic armv8
> issue, thanks!
>
> >
> > Best regards,
> > Jim
> >
> > On Thu, Sep 28, 2023 at 8:23=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> > > > Hi Tom
> > > >
> > > > Thanks for the quick review.
> > > >
> > > > if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
> > > > So we added a workaround for our bmc uboot.
> > > >
> > > > the error message as below:
> > > >
> > > > CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
> > > > build error would happen.
> > > >
> > > > arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> > > > arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable=
'
> > > > arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable=
'
> > > > arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dca=
che_all'
> > >
> > > OK, so you need
> > > https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.37214=
55-1-bhupesh.sharma@linaro.org/
> > > to be applied, as-is, yes? Thanks!
> > >
> > > >
> > > > Best regards,
> > > > Jim
> > > >
> > > > On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> > > > >
> > > > > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> > > > > >
> > > > > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > > > > ---
> > > > > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > > > > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > > > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach=
-npcm/npcm8xx/Kconfig
> > > > > > index 5f4a0506dc..163e7e7d48 100644
> > > > > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > @@ -6,6 +6,10 @@ config SYS_CPU
> > > > > >  config SYS_SOC
> > > > > >       default "npcm8xx"
> > > > > >
> > > > > > +config SYS_NPCM_DCACHE_OFF
> > > > > > +     bool "Do not enable dcache"
> > > > > > +     default n
> > > > > > +
> > > > > >  config TARGET_ARBEL_EVB
> > > > > >       bool "Arbel Evaluation Board"
> > > > > >       help
> > > > >
> > > > > Why do we need a new Kconfig option here on top of the existing g=
eneric
> > > > > ones to control cache?
> > > > >
> > > > > --
> > > > > Tom
> > >
> > > --
> > > Tom
>
> --
> Tom
