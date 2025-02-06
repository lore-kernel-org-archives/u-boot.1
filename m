Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7406C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C5F809D4;
	Thu,  6 Feb 2025 13:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fn11bCC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E7F80A0A; Thu,  6 Feb 2025 13:37:26 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A773807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab7800d3939so31227466b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845444; x=1739450244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DZSwQzkrRqpo1XwVZJtkmJf5l1pcvbmtC81C2TDYDoY=;
 b=fn11bCC4yYZqpb1E/63QxiNdAqroU29gRsBb7DT+bxp1PtHP1jzntKKvtU292a3o/S
 6Hlv41a8Malo0CVevZzfSA/h3KPC2ZwhQktxhloOH6viCtdCftcm/WFiwTpcO1afVdCC
 gzXZwcO8RXev4hzakpoLAXweghwdKtEmeUIhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845444; x=1739450244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZSwQzkrRqpo1XwVZJtkmJf5l1pcvbmtC81C2TDYDoY=;
 b=DT+IBYecv8W9rtfjH5S5+s6jDAGH51rkCalIBD3NhD/Pg3ZzB8czYiUU5NPWkTvzLT
 RBc3fDJc8N4W6LK7616ae8XVkyt4GG3Mvv9178GkTGx7nYny7+7XdtX6xiJLMB4JakoC
 tluY89+lhKdHTDDctg56wSdmVPPKDsS/nMr0qF5W6Axnor5MzetRHAnvrrloQOHTo/Tg
 2HjjEOXfsdwuLb5ZI5h3PS76KQeIU7X6T+mU6I0MDuna7A4VZ8gcd5pLE3MzB0scf/6t
 XWh3Usq43nmf8gNcm3/xXa3LQchZysQaji9ajzEfvfkPaNCbsdjQpGhifVRIIeBVfXzR
 T8pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOgWdxdZ372UEu9Kc/YxGORkv7QBChgQULPk8/25QB0rPLHomV8gEr37sdFt8WlF2AbOEiwxM=@lists.denx.de
X-Gm-Message-State: AOJu0YwmPcwZYnuSnznsq1mltxIkeJWN8cDgF/0TWkeXADVRJZ1NmJvT
 u8zQQvP9W1xnRgkUgct9X9wtYiEQmYCqi0acEsB90tZfq/oQqkQz41kORYAgoJcEZIGVI7Wcg9f
 +gJeGVgtedUnkmWN1Hd4B7hQldVDmHeO42CX7nIIchFqn3Pvf5g==
X-Gm-Gg: ASbGncv2Xtt0CGdfddeFbE72PYxA/R1tjidaMIBDyge7x2Z/xDr4E7scXEZLWai+2is
 XDgb56FoAKMdZS9p90b1zqgfUt+CQH1OST+xMmuY6mcw7YvtL0wc9Mw7baGrHNeutgsWWwCu9DA
 ==
X-Google-Smtp-Source: AGHT+IFVs+86dARyF8joxMYiJJjdWixDKoxMOQdX3cPaW3P6+7X2eUHZf08ujOp5MJ2PNtbiIo1NCoJ/mLBktS3Bfbo=
X-Received: by 2002:a17:907:3fa3:b0:ab7:e16:aab7 with SMTP id
 a640c23a62f3a-ab75e23d8fbmr614891666b.13.1738845443702; Thu, 06 Feb 2025
 04:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-23-sjg@chromium.org>
 <3926cdd3-39e8-44da-84f4-b9c877d6ac60@gmx.de>
In-Reply-To: <3926cdd3-39e8-44da-84f4-b9c877d6ac60@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:37:11 -0700
X-Gm-Features: AWEUYZkiet-axgybmEDS4NGlO1fxYrKEYCoroVrmIFqc6kAL5f7FHDVHUN2rjdE
Message-ID: <CAFLszTgN=k7mjR3-=XW7ZZOMpRPSdxuAXqszPeE4qJAwVKOnVQ@mail.gmail.com>
Subject: Re: [PATCH 22/32] efi: arm: Allow use of the EFI table in the app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 6 Feb 2025 at 03:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/3/25 18:42, Simon Glass wrote:
> > It isn't worth the hassle of omitting this field for the app, since code
> > is shared between the payload and the app. Adjust the condition to avoid
> > a build error in the 'efi' command with the app on ARM.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   arch/arm/include/asm/global_data.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> > index 8d51111f095..6a85fb2e152 100644
> > --- a/arch/arm/include/asm/global_data.h
> > +++ b/arch/arm/include/asm/global_data.h
> > @@ -108,7 +108,7 @@ struct arch_global_data {
> >   #ifdef CONFIG_SMBIOS
> >       ulong smbios_start;             /* Start address of SMBIOS table */
> >   #endif
> > -#ifdef CONFIG_EFI_STUB
> > +#ifdef CONFIG_EFI
> >       ulong table;
>
> Unfortunately this field is not documented at all. Please, add a
> description. The description '/* Table pointer from previous loader */'
> given in the X86 code is quite unsatisfactory. I would not know what
> table the field points to.
>
> If this field is EFI specific, shouldn't it be defined in
> arch/x86/include/asm/global_data.h?

It depends on what the previous firmware was. Where it is coreboot,
this stores a pointer to the coreboot tables.

On ARM it is somewhat EFI-specific, although only because we don't
expect people to want to boot from coreboot to U-Boot on ARM. But I
have long-since given up betting against any particular boot
combination.

Regards,
SImon
