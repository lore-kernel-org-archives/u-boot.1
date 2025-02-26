Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E88C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BAF807EE;
	Wed, 26 Feb 2025 16:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iYTBtCns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A8E80805; Wed, 26 Feb 2025 16:23:56 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24892805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fe93d7a588so599541a91.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740583428; x=1741188228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bv7dimAoG5DOkDalHPKpsxJbsPWEUAekOM/m62jJhZc=;
 b=iYTBtCnslYGFsxemNjPv2pkMdD7IhfBc06joO1jGzhqIkCXSPTMaHHteyqFE/Ucb4Q
 mmMtyafq7+XIeYLfe46g74MHPHfq6Ca20QVDTJAUGbfLzMi6snbPSV5mfeYZN03y1j+N
 kmDC05ktrWm5deVpSY2pFl+KZovuDDfWwM/Vnjc5NS+PGH501Q6YTdsUcLqZlG4hjuXf
 KOgcGfOaB/cJD8/iLt8wuMt2WWujKBKHAK3eAnUJu/P91DS3qe3uF4NQPiNFIcuWDYSQ
 E3X2zwZ0g9Io8IowjKbK38HHIeyvHsV//nQhhZ9SVA8vv0noLdFXpunTQgYMtaGhJg0X
 hdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583428; x=1741188228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bv7dimAoG5DOkDalHPKpsxJbsPWEUAekOM/m62jJhZc=;
 b=OKpDZMz1ccP3fVB1Pee+SjpJSvssLqqD9IGOEcVB/unREqFbynorRyxoEuqNEoSjXT
 UunNKToRKoOuVxNPGZOGOTRPlWdNAQIRGTKwwD/ihiOvPbk2MXfKcJ3IaVYaSGJwPyiw
 BtmDEBxP4JcfnlLnWczFIwOd46rZpqO7hOnceQG2owJdy6Y7iIjgklJWakA9V2+6VMFF
 jYIxv+kNBUO7Qml2o7Bk6g5sJwQ6yCC5rl3w/V+D0Sl9yvjJ3HDiYD8tBlS1bTGnCiq8
 fqgOdXZynfa3X+2JnGGr0yUtP2XK8GVmlmc0/n+zMZHKX/NNa/lP5bHHx9uhzojH6qKT
 uHLw==
X-Gm-Message-State: AOJu0YwxZWYcQ8weNsHk0A3MqyT2kJgpLdFNguh7XFNP0Zzr1luanbe4
 u8+1rDTBpERpBQiyDH/XvNONtvH1+KUgZ2FXXXFXM/N99DMLo7a8w6EIXCyQp2oEqGFkKVQIGo/
 NNgZSRVD5xkG7aGZqNTZL+9z4+f3S3CxSzf2avw==
X-Gm-Gg: ASbGncuU8ZtY/wsiBFrh8OEiiangT0PNP50EYjKOLOiO9hGb9UHv2EepCf6cGwNguOq
 MH5qgVveAQ/T5yfkUBNlPXklUiS4Ze9yN9quuVRrFtFiFh2SGRMSeDumvir86Fz8IUULYk1qH4Q
 pBpzE+f5etgA==
X-Google-Smtp-Source: AGHT+IFvEUY3yGUYDT7ihi9U6Nfnwqhwxuli7NJl1aBF+UPkS0/UWP4PdkKgczTjUsuS0xl1Ua2rudjG8aP5r+KGaZQ=
X-Received: by 2002:a17:90a:d00d:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-2fe68ada48emr12136584a91.13.1740583428349; Wed, 26 Feb 2025
 07:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
 <CAC_iWjLCMYCCCOAZ2V0XcNQVvSrk0NZjoOwxN+9n9PvbsAiheA@mail.gmail.com>
 <CAEfUkUL=Q2tHaXm8sZ1JgKYNC5W_Lh2VWXsqehfaXWjKcH4X7w@mail.gmail.com>
In-Reply-To: <CAEfUkUL=Q2tHaXm8sZ1JgKYNC5W_Lh2VWXsqehfaXWjKcH4X7w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 26 Feb 2025 10:23:37 -0500
X-Gm-Features: AWEUYZmoqvUY1fHMQX17y17yz_VkOfD6UwILXIOXL_nmkOVVlhyoRA_d5b5gF0M
Message-ID: <CAEfUkU+vSH0WXZ_S_bPT_kt5cWdbPVDcOgOe_j+FmjPKy27oJA@mail.gmail.com>
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

Hi Tom,

Is it able to merge this series for the upcoming release?
This series includes the hotfix for the building failures when
WGET_HTTPS,NET_LWIP and MBEDTLS_LIB are selected.
But it is rebased on one of Simon's patch:
'[PATCH 01/19] mbedtls: Add SHA symbols for VPL'
https://lore.kernel.org/u-boot/20250126184333.4058848-2-sjg@chromium.org/

Thanks regards,
Raymond

On Fri, 31 Jan 2025 at 09:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 31 Jan 2025 at 08:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Raymond
> >
> > On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Currently building with WGET_HTTPS,NET_LWIP and MBEDTLS_LIB failed
> > > due to a few incorrect kconfig dependencies.
> > > Fix these and clarify what is the purpose of MBEDTLS_LIB_CRYPTO_ALT.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  cmd/Kconfig         | 1 -
> > >  lib/mbedtls/Kconfig | 8 +++++---
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index 1a0985ca479..071601b5ac2 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -2161,7 +2161,6 @@ config WGET_HTTPS
> > >          select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > >          select X509_CERTIFICATE_PARSER
> > >          select PKCS7_MESSAGE_PARSER
> > > -       select MBEDTLS_LIB_CRYPTO
> > >         select MBEDTLS_LIB_TLS
> > >         select RSA_VERIFY_WITH_PKEY
> > >         select X509_CERTIFICATE_PARSER
> > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > index aa82336ef14..17ed2bc71de 100644
> > > --- a/lib/mbedtls/Kconfig
> > > +++ b/lib/mbedtls/Kconfig
> > > @@ -116,6 +116,7 @@ endif # LEGACY_CRYPTO_BASIC
> > >
> > >  config LEGACY_CRYPTO_CERT
> > >         bool "legacy certificate libraries"
> > > +       depends on LEGACY_CRYPTO
> > >         select ASN1_DECODER_LEGACY if ASN1_DECODER
> > >         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> > >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > @@ -210,12 +211,13 @@ endif # LEGACY_CRYPTO
> > >  if MBEDTLS_LIB
> > >
> > >  config MBEDTLS_LIB_CRYPTO_ALT
> > > -       bool "MbedTLS crypto alternatives"
> > > +       bool "Use legacy crypto libraries as MbedTLS alternatives"
> > >         depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> > >         select LEGACY_CRYPTO_BASIC
> > >         default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> > >         help
> > > -         Enable MbedTLS crypto alternatives.
> > > +         Enable MbedTLS crypto alternatives and replace it with legacy crypto
> > > +         libraries.
> >
> > This isn't too clear for someone that hasn't been involved with mbedTLS.
> > Isn't that enabling U-Boot's hashing algorithms instead of the mbedTLS ones?
> >
>
> Yes, currently only hashing will be replaced by U-Boot legacy crypto
> when MBEDTLS_LIB_CRYPTO_ALT is selected.
> But mbedtls provides more "alternatives" options than hashing.
> The reason I keep it named as "_CRYPTO_ALT" is to allow us to extend
> the usage other than hashing in the future.
>
> Regards,
> Raymond
>
>
> > Thanks
> > /Ilias
> > >           Mutually incompatible with MBEDTLS_LIB_CRYPTO.
> > >
> > >  config MBEDTLS_LIB_CRYPTO
> > > @@ -451,7 +453,7 @@ config MBEDTLS_LIB_TLS
> > >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> > >         depends on ASN1_DECODER_MBEDTLS
> > >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> > > -       depends on MBEDTLS_LIB_CRYPTO
> > > +       depends on MBEDTLS_LIB
> > >         help
> > >           Enable MbedTLS TLS library. Required for HTTPs support
> > >           in wget
> > > --
> > > 2.25.1
> > >
