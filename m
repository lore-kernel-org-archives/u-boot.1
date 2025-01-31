Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3824C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1549D82163;
	Fri, 31 Jan 2025 15:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MatmamVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1DD8262F; Fri, 31 Jan 2025 15:38:42 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9405982119
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 15:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso2810667a91.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738334318; x=1738939118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GbBtCPHeX2fXv5jLLgToVqOUo/whMw2U8GwFW8I9cpU=;
 b=MatmamVsZvduGJoTC3HdJvC7lOODgTbepMsyTe7TRyjf1m/YmtIf6A4qZ7VTsMFGCY
 a0EVDTuXYGAFpmRWqxwg5u6RmELAnlN3VYCINXyAVvkzVP7l1QA1eCfprGhp2lfEkV9x
 WLAFE+85XCUcj8aOPUk1AWXRLGQTd46fScamDEsPaqzgcejI/7LqBaSKJjuFc6DhwJlu
 I/SSEx/7SutY0FwRl0x8n5xYU7CwIYTE83AepmkVNMLj3OfWgkA1djl7xeCOCuTfUVrl
 u+ySyaH79plzdMPAgAmngONa1WROkAs7hzAJsJCL8FDoiKNvj+Br4BeGmJQ9t2RlSq1X
 wKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738334318; x=1738939118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbBtCPHeX2fXv5jLLgToVqOUo/whMw2U8GwFW8I9cpU=;
 b=TwjgD79ulSJT+AmPXOMz8erfhmGMhLQCm3JMPy0GFYGoKRduYw1ZFd4ja5Jw8/5m4h
 gMr6/f50civWD/K3fAWik2yFwquP/7eJoEMG4CzDAnaQFyz7I8fq4jYyVXdQBtdgA+9m
 C4JNKHfOKLvUwl8TsC6P4Cmf5FMze/aJREJLQNiHo9yRnURADA9T+ymJoZvaTJUBjKLX
 mT/SgzjpGdZkhCqZv5LUmkPUTdMAM5pZWjMtYc8uhMfSiKKHE07AACVlmUl/0SL/oBly
 L5ufOFgHM8Qv1QO7wJF9PylDThRaS71VwNSjcJQqFFL6kpUu7GKjeW6C7s1BMDWF2iij
 oGJw==
X-Gm-Message-State: AOJu0YxqOhUO303SxN4Rhe5khZ/oq/0dlG3y/x277VjZHXM/Bd6mZKBB
 BHKrZEiJRvqUl4+qfqRuh0vMshJlaOLINNkXXb/EguijVPlAzqpEup56bXk14L4N6QW5XitW1gd
 SpCGeKkqtxjU+vn/P42dtxehCdD+kp3iSdNS+bQjG6hblgrDxvHlGmw==
X-Gm-Gg: ASbGnctBjfP6fKm5Qs15QqYG1Sq9QwmE0JfPPFHZpoTz/kuX0VVHy8MHD8nR0Pfyk70
 F3iMLXNresylXDo+REjiydnIHmr/MScUkzMWRSOznAYNLUN9vPdhZCARhxkVcCcxOxXoYvcy6k6
 bS7BUi3Q9s6/wB7e3HQ4zpEYOJrJ7O+Q==
X-Google-Smtp-Source: AGHT+IFx/vto6xtL4UPda5jhTvzd07kMb1Pj1QiyKVKSB7na08kuhLCMojJh98U1h0D80dsyA6vzdp/qmLakg/DrysY=
X-Received: by 2002:a17:90b:258b:b0:2ee:fd53:2b17 with SMTP id
 98e67ed59e1d1-2f83ac836d0mr16422928a91.29.1738334318100; Fri, 31 Jan 2025
 06:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
 <CAC_iWjLCMYCCCOAZ2V0XcNQVvSrk0NZjoOwxN+9n9PvbsAiheA@mail.gmail.com>
In-Reply-To: <CAC_iWjLCMYCCCOAZ2V0XcNQVvSrk0NZjoOwxN+9n9PvbsAiheA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 31 Jan 2025 09:38:26 -0500
X-Gm-Features: AWEUYZkMcTBPO0KuKrgVRDBb_-pPLTpmPqU6uctHexKRiSLcRMIEWq5JrSzLhSc
Message-ID: <CAEfUkUL=Q2tHaXm8sZ1JgKYNC5W_Lh2VWXsqehfaXWjKcH4X7w@mail.gmail.com>
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

Hi Ilias,

On Fri, 31 Jan 2025 at 08:40, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond
>
> On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Currently building with WGET_HTTPS,NET_LWIP and MBEDTLS_LIB failed
> > due to a few incorrect kconfig dependencies.
> > Fix these and clarify what is the purpose of MBEDTLS_LIB_CRYPTO_ALT.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  cmd/Kconfig         | 1 -
> >  lib/mbedtls/Kconfig | 8 +++++---
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 1a0985ca479..071601b5ac2 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2161,7 +2161,6 @@ config WGET_HTTPS
> >          select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >          select X509_CERTIFICATE_PARSER
> >          select PKCS7_MESSAGE_PARSER
> > -       select MBEDTLS_LIB_CRYPTO
> >         select MBEDTLS_LIB_TLS
> >         select RSA_VERIFY_WITH_PKEY
> >         select X509_CERTIFICATE_PARSER
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index aa82336ef14..17ed2bc71de 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -116,6 +116,7 @@ endif # LEGACY_CRYPTO_BASIC
> >
> >  config LEGACY_CRYPTO_CERT
> >         bool "legacy certificate libraries"
> > +       depends on LEGACY_CRYPTO
> >         select ASN1_DECODER_LEGACY if ASN1_DECODER
> >         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > @@ -210,12 +211,13 @@ endif # LEGACY_CRYPTO
> >  if MBEDTLS_LIB
> >
> >  config MBEDTLS_LIB_CRYPTO_ALT
> > -       bool "MbedTLS crypto alternatives"
> > +       bool "Use legacy crypto libraries as MbedTLS alternatives"
> >         depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> >         select LEGACY_CRYPTO_BASIC
> >         default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> >         help
> > -         Enable MbedTLS crypto alternatives.
> > +         Enable MbedTLS crypto alternatives and replace it with legacy crypto
> > +         libraries.
>
> This isn't too clear for someone that hasn't been involved with mbedTLS.
> Isn't that enabling U-Boot's hashing algorithms instead of the mbedTLS ones?
>

Yes, currently only hashing will be replaced by U-Boot legacy crypto
when MBEDTLS_LIB_CRYPTO_ALT is selected.
But mbedtls provides more "alternatives" options than hashing.
The reason I keep it named as "_CRYPTO_ALT" is to allow us to extend
the usage other than hashing in the future.

Regards,
Raymond


> Thanks
> /Ilias
> >           Mutually incompatible with MBEDTLS_LIB_CRYPTO.
> >
> >  config MBEDTLS_LIB_CRYPTO
> > @@ -451,7 +453,7 @@ config MBEDTLS_LIB_TLS
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
