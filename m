Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E3DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02416807EE;
	Wed, 26 Feb 2025 16:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xm1XQ2yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189D80F96; Wed, 26 Feb 2025 16:26:35 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BE8805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so13620898a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740583592; x=1741188392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3XolZNoqx9gl1F9VCdvBL07kcEOuDmFp/qT+EiqqBes=;
 b=Xm1XQ2yuwb4clPJ2/ODOebSJD021J0IR4u31dn46D5Z3etP6VCMP1ibqLRJ3uePPHv
 M5mov+w6zscThUYU9tPviDr+NKzr776IVsan5xMv/YlXH0iBOsCvIF3/jh5KAAfU/0jU
 qAC89WOo3cfUDo6UWpYaqaQuH7t2yo/FoyjA8Lk3M0ORGqdV9NnhGGAZTHrpQRTZLpIS
 nV3AqhiDGy6uvraBLTAfl/e0NEAL+wqt/rTkMnTrtqv3Y+16DvATOZ0gzT4UwoQIrX3a
 RcT3Mo13SN2dA2nIyv1XImbzVG1CSpJkmv8/E+YCx5oL6NzuWEww5JMWE4zw0Hl4KQxn
 824A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583592; x=1741188392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3XolZNoqx9gl1F9VCdvBL07kcEOuDmFp/qT+EiqqBes=;
 b=S8raNjAFprujb64VI4gPHDO2CcQa5DQRxELCcU+/0aoT3qgRr/dNol7FweZvxjZ1cH
 iolnKEXu/EquGaT8BzOS6rUvL8jzFre1HDkUw91mPDBnnVgSJIsehI7vQt//Ww9yzJt8
 mRYG9kxDAWLmBavkYriiGVp7ri4mmeUNku+DqLCb5YJcUf8843psKJL1663hR3lqQ8/h
 FdtAYrOnzCOqnY4iSUQQ3EF/yilfGoB6lmBa7+rgA84i36TkRaV5VBmAdimBSXkYyU0y
 wBfAqNau4ePwfT6FE2zQwUyOyyfFFIaRYJpZj6OzmfKLxBze0Gk7jMP3RWUG8X13tD+7
 B4sA==
X-Gm-Message-State: AOJu0Yzi2FxZeMUquWAjS29bLG5wv4Za1efAor37jcMEAC+oOe0GM7e4
 ROEwHKUWGCyKpwYJ+jmQbcb3vHoHeBQgnmr3g+v6QGVr99m+GaUNXXgn7401PvJKxvrCkDdBAOY
 pxt4Ub8mffglIs8gjWl0CF3foKnNt9ekd2Wwsbw==
X-Gm-Gg: ASbGnct6n5hqmy6lS2b/+x+ZKiAXnwyyzXBbWI8oKj4BB6ZdW8GQaNRc697DxDczlPj
 +QHQd5JGXyokdqM3iHNPmnqWgdkf5HRlEOVG7AnzMsK1ZjcrSxg/gFUUeRCS7Es51jCENBWH/6L
 Xwcwn8YVKJZQ==
X-Google-Smtp-Source: AGHT+IEIAzUk6GnziqTqaX/5/iaD6DSQAmjowAQ3RVyhy1pLBcxDYePCcpguC+5pcwtqG/NRMZlDZXr6ZqjnQaxQwkY=
X-Received: by 2002:a17:90a:fa14:b0:2fe:84d6:cdfc with SMTP id
 98e67ed59e1d1-2fe84d6cf88mr4216100a91.35.1740583591903; Wed, 26 Feb 2025
 07:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
 <CAC_iWjLCMYCCCOAZ2V0XcNQVvSrk0NZjoOwxN+9n9PvbsAiheA@mail.gmail.com>
 <CAEfUkUL=Q2tHaXm8sZ1JgKYNC5W_Lh2VWXsqehfaXWjKcH4X7w@mail.gmail.com>
 <CAEfUkU+vSH0WXZ_S_bPT_kt5cWdbPVDcOgOe_j+FmjPKy27oJA@mail.gmail.com>
In-Reply-To: <CAEfUkU+vSH0WXZ_S_bPT_kt5cWdbPVDcOgOe_j+FmjPKy27oJA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 26 Feb 2025 10:26:20 -0500
X-Gm-Features: AWEUYZkbCEQEVu6TuzfziwmkG2Dj_f5yyRnb7eB-N4pDjJFnz2tI50qvX18JhdE
Message-ID: <CAEfUkU+vgwSNgKdkz1q5h9wtU5K4L2e6Xi2m_BXRZm8ddPDp1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mbedtls: fix incorrect kconfig dependencies on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

Sorry, please ignore my previous email. We should merge [v2].

On Wed, 26 Feb 2025 at 10:23, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom,
>
> Is it able to merge this series for the upcoming release?
> This series includes the hotfix for the building failures when
> WGET_HTTPS,NET_LWIP and MBEDTLS_LIB are selected.
> But it is rebased on one of Simon's patch:
> '[PATCH 01/19] mbedtls: Add SHA symbols for VPL'
> https://lore.kernel.org/u-boot/20250126184333.4058848-2-sjg@chromium.org/
>
> Thanks regards,
> Raymond
>
> On Fri, 31 Jan 2025 at 09:38, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 31 Jan 2025 at 08:40, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Raymond
> > >
> > > On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Currently building with WGET_HTTPS,NET_LWIP and MBEDTLS_LIB failed
> > > > due to a few incorrect kconfig dependencies.
> > > > Fix these and clarify what is the purpose of MBEDTLS_LIB_CRYPTO_ALT.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > >  cmd/Kconfig         | 1 -
> > > >  lib/mbedtls/Kconfig | 8 +++++---
> > > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index 1a0985ca479..071601b5ac2 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -2161,7 +2161,6 @@ config WGET_HTTPS
> > > >          select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > >          select X509_CERTIFICATE_PARSER
> > > >          select PKCS7_MESSAGE_PARSER
> > > > -       select MBEDTLS_LIB_CRYPTO
> > > >         select MBEDTLS_LIB_TLS
> > > >         select RSA_VERIFY_WITH_PKEY
> > > >         select X509_CERTIFICATE_PARSER
> > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > index aa82336ef14..17ed2bc71de 100644
> > > > --- a/lib/mbedtls/Kconfig
> > > > +++ b/lib/mbedtls/Kconfig
> > > > @@ -116,6 +116,7 @@ endif # LEGACY_CRYPTO_BASIC
> > > >
> > > >  config LEGACY_CRYPTO_CERT
> > > >         bool "legacy certificate libraries"
> > > > +       depends on LEGACY_CRYPTO
> > > >         select ASN1_DECODER_LEGACY if ASN1_DECODER
> > > >         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> > > >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > > @@ -210,12 +211,13 @@ endif # LEGACY_CRYPTO
> > > >  if MBEDTLS_LIB
> > > >
> > > >  config MBEDTLS_LIB_CRYPTO_ALT
> > > > -       bool "MbedTLS crypto alternatives"
> > > > +       bool "Use legacy crypto libraries as MbedTLS alternatives"
> > > >         depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> > > >         select LEGACY_CRYPTO_BASIC
> > > >         default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> > > >         help
> > > > -         Enable MbedTLS crypto alternatives.
> > > > +         Enable MbedTLS crypto alternatives and replace it with legacy crypto
> > > > +         libraries.
> > >
> > > This isn't too clear for someone that hasn't been involved with mbedTLS.
> > > Isn't that enabling U-Boot's hashing algorithms instead of the mbedTLS ones?
> > >
> >
> > Yes, currently only hashing will be replaced by U-Boot legacy crypto
> > when MBEDTLS_LIB_CRYPTO_ALT is selected.
> > But mbedtls provides more "alternatives" options than hashing.
> > The reason I keep it named as "_CRYPTO_ALT" is to allow us to extend
> > the usage other than hashing in the future.
> >
> > Regards,
> > Raymond
> >
> >
> > > Thanks
> > > /Ilias
> > > >           Mutually incompatible with MBEDTLS_LIB_CRYPTO.
> > > >
> > > >  config MBEDTLS_LIB_CRYPTO
> > > > @@ -451,7 +453,7 @@ config MBEDTLS_LIB_TLS
> > > >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> > > >         depends on ASN1_DECODER_MBEDTLS
> > > >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> > > > -       depends on MBEDTLS_LIB_CRYPTO
> > > > +       depends on MBEDTLS_LIB
> > > >         help
> > > >           Enable MbedTLS TLS library. Required for HTTPs support
> > > >           in wget
> > > > --
> > > > 2.25.1
> > > >
