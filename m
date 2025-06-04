Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D387C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 16:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D90D801BE;
	Wed,  4 Jun 2025 18:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KpXIk0PY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183DA803DF; Wed,  4 Jun 2025 18:17:51 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DBB800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 18:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-adb47e0644dso19769966b.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749053865; x=1749658665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gomc8WAngyapgPX8VMUMhczyiKJcmHR//dBHfEYT/Ns=;
 b=KpXIk0PY14Tg305qQ7kjEgeM72CAu06m6fbXOIk71sZ674oyYPkKJZSb1joECWxE9n
 UWZ//qJRaDP2PDq4e24TwCi+VBlOz1ygcU3uPTA40Yrn0UeUYq6vNCOvLmXDIa4/6cg1
 CS/HYzTbniCvNnm/d4zdL28BruESroinaP44M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749053865; x=1749658665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gomc8WAngyapgPX8VMUMhczyiKJcmHR//dBHfEYT/Ns=;
 b=SwZgVbXdPwUcWHI1zfIV810hjjpqS27o3f5DN9Fv1MvFhXZdLXRt4rRoWUmPG5ZaPe
 +CTyo7kJsFe9O1UIOjftTu8oZkjvEiXa8O5wHWTKX1Dnf3z3V0q6SBsJ1UDveHIVu7E1
 h1f4ypkzBJyEfsViZFNNwwOauZeXA160n5yEnq2eZKB9863wsqFinGuPaS8HvUHUpG6a
 KMtuN3wbyCpSdLrCcIKXf/DEHzBxdJ4k+yLOCx65NmjbKpy5WAUqEEnTr3gUz7pBG0UV
 NHSnnYrQXtjHvH0j/LCWg4e/5S0Q5/brxto3HDQrR1Cw1IfD5Wa1Sc1MvuXrPrypYCjZ
 6MOw==
X-Gm-Message-State: AOJu0Yx8ytK8GcLbzyw3xy10KifehB9mSTPBVTpFeBt2BxSbXbrOjlVK
 im5sxYp3mxaw9G/ZwCVVM31ZXsWleEzE6MHcKpxpp5HtNHKZtg4P/GVReE63NQ+SoSy+2gxCp5U
 zZ1/06akJ0cWAUyfYmfhyKQEjKKCcNqrIm9m4aZuQ
X-Gm-Gg: ASbGncs/HgnK6xBquYSHU+I0JqW0Wj8z1XrWtb88p5sAsrydpBo032fMsSyGbNBnT1e
 kIjQwah3xbpnLJgLCGn/6VDuKwc+xkeUfMefPSgxPhowq8kB7Vv0P/qrvbkM4nR3Ls6BkP1TEkf
 7NAnzXT+AqjSGWZk//vaWd5Jc17igtDiA6hjhe3AP0IdZC
X-Google-Smtp-Source: AGHT+IHFLjW4KEVJXVYcFx462qOhSp+yCcdTGTz/KfvERiwRzmXuMpQ5UOETJfB+6J1tS3oIRjq/1z4TooyffEaq6XI=
X-Received: by 2002:a17:907:2d9f:b0:ad5:6258:996f with SMTP id
 a640c23a62f3a-ade07828858mr16838166b.19.1749053864750; Wed, 04 Jun 2025
 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250604130923.1484873-1-sjg@chromium.org>
 <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
In-Reply-To: <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Jun 2025 10:17:32 -0600
X-Gm-Features: AX0GCFvWSPBEl3vqUB2aA_Rm_Rtz1QHvJ7A7_DmZCY-MYqbGQzu-IGa5c38SqXA
Message-ID: <CAFLszTi9yEz_JH9uXz8wmfsGJr8cKX2-zN1seX9cDTd+iqSEMQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 4 Jun 2025 at 07:15, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> On 6/4/25 15:09, Simon Glass wrote:
> > The condition here is reversed, which makes link and coral very slow,
> > leading to lab failures.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes 6c171f7a184 ("common: board: make initcalls static")
> > ---
> >
> >  common/board_f.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index bff465d9cb2..c8a612d6070 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
> >   */
> >  static void initcall_run_f_r(void)
> >  {
> > -#if CONFIG_IS_ENABLED(X86_64)
> > +#if !CONFIG_IS_ENABLED(X86_64)
> >       INITCALL(init_cache_f_r);
> >  #endif
> >  }
>
> Sorry for that mistake.
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

It's fine. I only noticed it because the lab tests started failing (I
have a short boot timeout on one of the boards).

Do you think some of the conditions could use if() instead of #if now?

Regards,
SImon
