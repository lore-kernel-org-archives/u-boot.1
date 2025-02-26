Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AD1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFC1807EE;
	Wed, 26 Feb 2025 16:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F5+Kwcgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4784280F88; Wed, 26 Feb 2025 16:25:37 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D2B805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0e1so1782486a91.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740583533; x=1741188333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kWCQCz1LB6ga//TlJ0EO8Cu+dbpSARW+/ub73qABs10=;
 b=F5+KwcgkDEkvZnjV0X1tEJ6oYl2obtG+9i566/SVOAkWiHYd3JdcaJt0FY7h+dB/pY
 4kVb+mJ0AajCHE2UoEketuiXCSEqIl18VrQXFdHoIde7d5bKjlgKwPVTE6Qq3SGsQmE3
 wYTX1YtQCNuzprnHgB5e7QU6NGADgnLIi6PjucQIhodEetpdcS0wiuJfQqV13ODW4zZa
 Rlb/WOhhl8GFNfQj5koM1DyRMgW3MpzXLxdfA9cntXhSNcBz/vDriX2svf2jNSy6DUAR
 ajyyUajudWjbcmava73dU0ruSB39RwAUfzMzBhWBF2Gq9qdGawZAtztihQDz5hH1ionE
 ZXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583533; x=1741188333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWCQCz1LB6ga//TlJ0EO8Cu+dbpSARW+/ub73qABs10=;
 b=tx5L+g3Hbjvu/k7nvEjQA9n5LPuOacdziB/Gq8NTkvKuyzgAFCNSgzO3C8Qy8LDLFi
 uiyYdG8X6KaCWUUJLTzxBCS4/FNUBejP2BcaulvjMLAoKcIOeJbncCUgVpoBVcRj06Ei
 yUQNsJCFpcItbUR8q6CPTokQCMzeBVaByyeFOY1f9bGXaeg3dWbctxex6rTZ8X2OPELz
 Fk035gS8zSCTP4Dj7Xy3nf3GJRlJ4DjJFnBGaaxyKGzwlgW6NiXAlZCTZ1+lyw666Ugi
 dimja14JQwa3wE19zHWABaOnZpq9oeI/O0gT8LW9ZzB+ks+9iyBd1kC7BiIXuuDHtk5Q
 k9ug==
X-Gm-Message-State: AOJu0YyOQPqNWdeYesiAW2QKamVQH7tLu5EhMreUdQc6qMms7A7T2UH0
 sODJVyf2snX6wQ2gzyKgUQKcoJYG6pCnX1smPiSHeHLkpXLrUvp9630eNwIjP6MyU92vMGnPhec
 MK92xXZDuavNhD0A/ssqPo9cWUmZ796BNfsDgGw==
X-Gm-Gg: ASbGnctLvENkFwNnqp+5iBjFAgazdBmlxobHsKs3zh7lz/kovRAhv8mKpuXE2ASg9lu
 OW45z0KOS+wWhbSG4xfPky76/l6MUjETGi6aEHvAKcHiE+gi7dvDlGsHXhv14sUrzEo6X4Ugj0A
 fPIoio75IFRQ==
X-Google-Smtp-Source: AGHT+IEBYV6DEtE5CuEnbnsSdtSQsimKcvVqDXqg8YaNIOlA0ktPcdcR94iDVjX88PocOxWw6gwraukZ5quJek8CZXU=
X-Received: by 2002:a17:90a:e7c3:b0:2fa:2252:f436 with SMTP id
 98e67ed59e1d1-2fce7ace31dmr34125279a91.3.1740583533205; Wed, 26 Feb 2025
 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20250203220825.707590-1-raymond.mao@linaro.org>
 <CAC_iWjLYqUucPThnuYPP_Pr19BQfQPMv4AY5XHDnJ8Pi_=hfhw@mail.gmail.com>
In-Reply-To: <CAC_iWjLYqUucPThnuYPP_Pr19BQfQPMv4AY5XHDnJ8Pi_=hfhw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 26 Feb 2025 10:25:22 -0500
X-Gm-Features: AWEUYZkcQvmowkpdEPfjIz4r7HNW8n0-mvE9dtBFCbc7NTPTYlJhIl0fFH5xc3g
Message-ID: <CAEfUkU+292wu7gdbj-BJoj9oWdt0SuUOeHtF3hv_uOyvjG20DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on
 mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
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

On Tue, 4 Feb 2025 at 03:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 4 Feb 2025 at 00:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Fixed the building failures when WGET_HTTPS,NET_LWIP and MBEDTLS_LIB
> > are selected due to a few incorrect kconfig dependencies.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2:
> > - Remove the renaming to patch 3/3 and update the commit message accordingly.
> >
> >  cmd/Kconfig         | 1 -
> >  lib/mbedtls/Kconfig | 3 ++-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index e62817bd977..2e2dd459f56 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2160,7 +2160,6 @@ config WGET_HTTPS
> >         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >         select X509_CERTIFICATE_PARSER
> >         select PKCS7_MESSAGE_PARSER
> > -       select MBEDTLS_LIB_CRYPTO
> >         select MBEDTLS_LIB_TLS
> >         select RSA_VERIFY_WITH_PKEY
> >         select X509_CERTIFICATE_PARSER
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index 35d8c507a89..bb8ac5f862b 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -156,6 +156,7 @@ endif # LEGACY_CRYPTO_BASIC
> >
> >  config LEGACY_CRYPTO_CERT
> >         bool "legacy certificate libraries"
> > +       depends on LEGACY_CRYPTO
> >         select ASN1_DECODER_LEGACY if ASN1_DECODER
> >         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > @@ -491,7 +492,7 @@ config MBEDTLS_LIB_TLS
> >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >         depends on ASN1_DECODER_MBEDTLS
> >         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> > -       depends on MBEDTLS_LIB_CRYPTO
> > +       depends on MBEDTLS_LIB
> >         help
> >           Enable MbedTLS TLS library. Required for HTTPs support
> >           in wget
> > --
> > 2.25.1
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
