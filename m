Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A332C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC56B80C93;
	Mon, 16 Jun 2025 15:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uk48/YKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B2381760; Mon, 16 Jun 2025 15:12:11 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64D38070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e75f30452so26879157b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750079528; x=1750684328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eog/YoB3gkEN2HfiHQq93Yw6Xf5SmqcwuCy3sh3iyAU=;
 b=uk48/YKHXCU2ePtd33nsVpqcZcx8KJcUXg6bGDCv19BgUPXqx0aQ3HkWMAp2yeoyE7
 K/q/yzCermaAqlm5Tji/AlMJzvNiwWa/umg+tluXbfysmA0Ze4oQhf01Aov/nCORQof4
 x6cNQhuDpfQcEMYIWJABcNdzSbqb5zpWNghgxwS0xFyKUCf1VEQ4kEx/Wlhp+hLEg+Eg
 DIuUSTqOsN7yCJ3wwggaiHcv7BIA6jY7GReuXll2+y0Pf1UsqEoZa9fTtFKdPp6sWAkO
 JxoT51cDaS9KwR7cGxPjr5pXBOJRD/hX12wBMwNp+OkhfbP+QLWoGzMcuXYR+8pAEXJK
 8kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750079528; x=1750684328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eog/YoB3gkEN2HfiHQq93Yw6Xf5SmqcwuCy3sh3iyAU=;
 b=hTB8SVMfHZfrv57tNHSE1UYw0QSImpUIa1q3vL4NNhquHGepP7kj10jwH25uiPOzzR
 Vt+F6W3jJtFRPhAl0XNdVojnC9TwTSzTAW/7lgGtJzvtWhjI36KIb7RCDxu6P/mBlTYH
 GOVculkus4t0efYhMKJ5UGL7WFco3YMo/UMwQeikfkmTnIKSkn8wnQ9yeIgGm4rchvka
 BohXvK0HsbW9P92qWKINeON/TsYLv0FC0bDn5Mr3gbxtR8pBpMVIsx8qrHC8JImeeEoT
 V2BMwZIHXRkN1hAQ42i/Iu9cK8KcyhcLyL2qBNgv0vhYgKoDSqCKNvxuEjwejqCIvW+j
 8JqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzvHh9O/f3fJrSgW/rf36lvgCm9HttzGQwKxy0l7R2zLG7y70Fs2fiH9EI7YcAinovI8umRHw=@lists.denx.de
X-Gm-Message-State: AOJu0YzsamGefhaZdw/0LE1BSI8RpXyNQMNTbce+yDPHgAzk5LYO5zwS
 PmKXZdx6apcyMxN/ZVERdsJd0Alo9sM4sE0UOj8p63EX6+/tm09b0/pmQRgifFc36E1/VEvsEt+
 sPHI5+zFRwkHxOSsLB0i6P1r4xMRtkEnk/4STOqpvvA==
X-Gm-Gg: ASbGncugkI4HLsKWPwc5k+tPWesLj9vi4FSzj6DJV6GOiwd0j77qbMztueOfsscIHDo
 f1rTH9AgiTH9JR3KOulhRVc59w0vouMvytzcczzZtUmLEXQRUCFu6rtOm/5ttqBgG0qtL35evMr
 1SMvaElMFinsRZTTWcaVWY9/o2fHqbB6hyLwdMwNOGxh5l
X-Google-Smtp-Source: AGHT+IFeMUqO4fE+mqjprjTyVbwVmN4ecldS49ddOBoQzZund4mG5dKmTHaR/FYcx1mCjKYD18ehKqS+Pc4n5/ELbzA=
X-Received: by 2002:a05:690c:a04b:b0:710:f20a:eacd with SMTP id
 00721157ae682-71175384eedmr105516477b3.7.1750079528569; Mon, 16 Jun 2025
 06:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
 <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
In-Reply-To: <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:11:32 +0300
X-Gm-Features: AX0GCFvtmeD1lFjC8gkCt6gLhCUfZj-MR6rlSVGaa2XlDl0k8rhfMWzrTiVAIXk
Message-ID: <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: trini@konsulko.com, mikko.rapeli@linaro.org, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Jerome,

[...]

>
> If I'm not mistaken, this patch is doing two things that are unrelated:
> (1) fix the KVM issue and
> (2) get rid of the __arch_*() macros in favor of the __raw_*() macros

I can split it, but I don't see much point since we redefine the raw_macros.

>
> IMO this should be two separate patches.
>
> >
> >  /*
> >   * The compiler seems to be incapable of optimising constants
> > diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
> > index f2393c041f44..545561ad1169 100644
> > --- a/drivers/spi/fsl_dspi.c
> > +++ b/drivers/spi/fsl_dspi.c
> > @@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
> >
> >  static void dspi_write32(uint flags, uint *addr, uint val)
> >  {
> > -     flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
> > -             out_be32(addr, val) : out_le32(addr, val);
> > +     if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
> > +             out_be32(addr, val);
> > +     else
> > +             out_le32(addr, val);
> >  }
>
> Unrelated change

Due to the the new do {} while(0) macro this doesn't compile, so it
needs to go together.

>
> >
> >  static void dspi_halt(struct fsl_dspi_priv *priv, u8 halt)
> > diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
> > index 3ac226879303..1c363115beb2 100644
> > --- a/include/fsl_ifc.h
> > +++ b/include/fsl_ifc.h
> > @@ -803,29 +803,29 @@ void init_final_memctl_regs(void);
> >       ((struct fsl_ifc_fcm *)CFG_SYS_IFC_ADDR)
> >
> >  #define get_ifc_cspr_ext(i)  \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext)
> >  #define get_ifc_cspr(i)              \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr)
> >  #define get_ifc_csor_ext(i)  \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext)
> >  #define get_ifc_csor(i)              \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor)
> >  #define get_ifc_amask(i)     \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask)
> >  #define get_ifc_ftim(i, j)   \
> > -             (ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j]))
> > +             ifc_in32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j])
> >  #define set_ifc_cspr_ext(i, v)       \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr_ext, v)
> >  #define set_ifc_cspr(i, v)   \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->cspr_cs[i].cspr, v)
> >  #define set_ifc_csor_ext(i, v)       \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor_ext, v)
> >  #define set_ifc_csor(i, v)   \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->csor_cs[i].csor, v)
> >  #define set_ifc_amask(i, v)  \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->amask_cs[i].amask, v)
> >  #define set_ifc_ftim(i, j, v)        \
> > -             (ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v))
> > +             ifc_out32(&(IFC_FCM_BASE_ADDR)->ftim_cs[i].ftim[j], v)
>
> Same.

Same here, both of the changes are needed

Thanks
/Ilias
>
> >
> >  enum ifc_chip_sel {
> >       IFC_CS0,
> > --
> > 2.43.0
> >
>
> Thanks,
> --
> Jerome
