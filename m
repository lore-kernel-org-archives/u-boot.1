Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C94E732DB
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E2D8655F;
	Thu, 28 Sep 2023 16:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nc1Bccr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6A986E62; Thu, 28 Sep 2023 16:33:06 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7A6864C3
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5048156976cso4927021e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695911583; x=1696516383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOclK4YtTkeaGT9ygADkjFJfF2hZeGkmYSD+i36MPYA=;
 b=Nc1Bccr1kzhRpSlsFKflAjeF225JtjSM/rcKo2rt/l13tO0FhizuGeZp+3IypI6ItT
 yJRIRoA8i0cJlXSH0klEkwLNbVyDZNmtA2f+bE+DyRTy3zl3+SGjJ3ZSdg7erdIO1PUo
 LfSmaL0hdMSs02Ff4ErXfOmTWTgfEuxR0OpD9pvxF58IVrcXgwwxg/2Imi7VSGPclqDL
 P8vx8pSr/Lohls7+BaA/46uQCcZF3zJjGJOo7S1boVpEeZ67NI2ie6+dij731qZS1VB/
 XY5AWEIFDOTQD6U66z2zV14V8gZxG1xyvzyNH90gPzo7wKT2I4oXqbszIy6Mn8YlJ2Gu
 GsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695911583; x=1696516383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOclK4YtTkeaGT9ygADkjFJfF2hZeGkmYSD+i36MPYA=;
 b=gPcFvbKN4RvEA9l7QY0B3thnQfWjzp0ftpTy5D2VhB14Qh/M8Zuv3igV/IZnMFb/Lr
 nUxf9XV09UimlW69X1PzLZ4yUomwJiJPmekSddwYMgt6hKG7oMxhdju7g/pW+DvsEEc1
 zZxyNc1pMZnDBJVJfM9h8/vnAZGqK5ainaZHq9uHKjAdp7uiEdezah0U8aQDw2FG7tEX
 9m9b4ciQ8i93X4c80gvYTS9zUGQAkwGjUR0NIY4H7oi8dweL6gxkNeeMvjtZABYthsJ6
 ryO/qWqu6j+twyHDxDQvvnGcf5vC/ynyOZWN0Ts5YU88szjIq/DWLXlHOPwrWaXY0wfw
 zU4g==
X-Gm-Message-State: AOJu0YwC4UjaeSkC6UZrQsmM6CIH58Jz1rZs2VGLSi6PN3dcqtsBesTS
 SdpDmDQwjXRFQz9D/zQBWrXeAm4TfyUz/lTkYpchiKEqkWE=
X-Google-Smtp-Source: AGHT+IHPp/0jzG5speYnPtPZanRj2Ik74DiNU+n7Prmj4LHNTejiQ/SjiDVutETcffhZHPhi/nEQx6SDJ1GD2ALcl1E=
X-Received: by 2002:a05:6512:1595:b0:500:b828:7a04 with SMTP id
 bp21-20020a056512159500b00500b8287a04mr1420935lfb.18.1695911582611; Thu, 28
 Sep 2023 07:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
 <20230928122317.GD305624@bill-the-cat>
In-Reply-To: <20230928122317.GD305624@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Thu, 28 Sep 2023 22:32:51 +0800
Message-ID: <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
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

Hi  Tom

Thanks for your understanding.
but  this patch  is an incomplete patch.
After I applied this patch  I had another error.

arch/arm/cpu/armv8/cache_v8.c:773:2: error: #error Please describe
your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
  773 | #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP
and enable dcache.

This error is the same as that link.

Best regards,
Jim

On Thu, Sep 28, 2023 at 8:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> > Hi Tom
> >
> > Thanks for the quick review.
> >
> > if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
> > So we added a workaround for our bmc uboot.
> >
> > the error message as below:
> >
> > CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
> > build error would happen.
> >
> > arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> > arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable'
> > arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable'
> > arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dcache_=
all'
>
> OK, so you need
> https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.3721455-1=
-bhupesh.sharma@linaro.org/
> to be applied, as-is, yes? Thanks!
>
> >
> > Best regards,
> > Jim
> >
> > On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> > >
> > > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> > > >
> > > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > > ---
> > > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-npc=
m/npcm8xx/Kconfig
> > > > index 5f4a0506dc..163e7e7d48 100644
> > > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > @@ -6,6 +6,10 @@ config SYS_CPU
> > > >  config SYS_SOC
> > > >       default "npcm8xx"
> > > >
> > > > +config SYS_NPCM_DCACHE_OFF
> > > > +     bool "Do not enable dcache"
> > > > +     default n
> > > > +
> > > >  config TARGET_ARBEL_EVB
> > > >       bool "Arbel Evaluation Board"
> > > >       help
> > >
> > > Why do we need a new Kconfig option here on top of the existing gener=
ic
> > > ones to control cache?
> > >
> > > --
> > > Tom
>
> --
> Tom
