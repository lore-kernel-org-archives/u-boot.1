Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134A9C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7CD8881F;
	Tue, 30 Jul 2024 16:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nxZUgR/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204CF8881F; Tue, 30 Jul 2024 16:06:10 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A114F88607
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cdadce1a57so2941697a91.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722348366; x=1722953166; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MRNkMoBEXRF4I32kQ/r8u638ZAgYCqObR5wOjqelgaE=;
 b=nxZUgR/Nm5HbR2NniKPTebiQhHtMJKvvWLpy5o8g+Q1X2RG3cDk/rI0MU1QFoXX86+
 JU9bkwdjcPkYA9e02pBZqWMmERJT3f+uV8/JCoKPjC7NhuWMaoUvIiHNVEaviVMjJ8E9
 y114V6uawGOtZG/LB+JzN7ocwRZjXLq0Wk0wERqT8cxZ+XoeRWS1V7UON/hhTyJZI6Mr
 jnga1MJUGReOYQpwSpYxf0diwzjnq85oyx06LMurtuK5CTFDQs08s2KpB5Lz27Vu3drC
 cDC9nufVZ+52IpCNS82y1aOYxAcXkEEy7wx1oGr1DT7HyZpRL3IKZa+wjXC674Axq3Ty
 c86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722348366; x=1722953166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRNkMoBEXRF4I32kQ/r8u638ZAgYCqObR5wOjqelgaE=;
 b=rDB+6pyfYh0IVbi3tSa4RjDnca1oFy9wZZFjpHqOscz8FKFIMQ9NziVxL25Ib8g6cS
 ZQCOBPW8jfOQoj4IbFYcj1bOCYW1qFFGbGGnduJ5GboW+yZWvkrIPfMPkOtUJswtvwaW
 IkBgm9mdAJhzeHG8lRFO4qmIKmSlANtIeVUI6ZT1XeFUnppjpKQ4WNBq8Jr0MHvKyg9/
 Ty9W72jAP0bFyDwm/NWhJuuDn9WdABOBjtv27vow1kTWS/yhDitbJI+OkwkGFxcySDR/
 TmywZik/Ec+Ek/UkvDWe1P8I8J4G0ZG0NxNZP0hD5FeJ7EHuqHQicGXhqMbG8JOqbn0s
 l9Vw==
X-Gm-Message-State: AOJu0YwNiaYLLRbXuqjYHllqOM5k7Qm3yVW71fPNcLHfpsoXXbxrBbtQ
 SNZ+6tGktVb8ITVTHVE7KuCgGO/DNPZ2EnH3YRJHtO92Lo9aj0+HTjN8x4MJmUjP7K6NswMqdX2
 JrgaiUNOg4cf+3kpJ8hQOCRDnGGGo5rmvMrfOGw==
X-Google-Smtp-Source: AGHT+IGUUMxoxJqfzDP7ErVvIlPYundIkaMdC40aOe+ZuEoziNf2QmCyg61gwSfDuJOYEtfu/8WHGkc98eK4IeCq+3s=
X-Received: by 2002:a17:90a:9a6:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2cf7e606ccemr9241614a91.31.1722348365611; Tue, 30 Jul 2024
 07:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-26-raymond.mao@linaro.org>
 <CAC_iWjJtLb9N8sYn2qczTeLYdeuN-uZvjNGGf4KsD2Ks3uB1OA@mail.gmail.com>
In-Reply-To: <CAC_iWjJtLb9N8sYn2qczTeLYdeuN-uZvjNGGf4KsD2Ks3uB1OA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 30 Jul 2024 10:05:53 -0400
Message-ID: <CAEfUkUKi8qcMRPSVAxz2qeQh-xmMJiD0g9iDyNQBiiP21uwy5Q@mail.gmail.com>
Subject: Re: [PATCH v4 25/29] mbedtls: add RSA helper layer on MbedTLS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 30 Jul 2024 at 04:05, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
>
> On Tue, 2 Jul 2024 at 21:33, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add RSA helper layer on top on MbedTLS PK and RSA library.
> > Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
> > MbedTLS implementations respectively.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch.
> > Changes in v3
> > - None.
> > Changes in v4
> > - Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
> >   MbedTLS implementations respectively.
> > - Remove unnecessary type casting.
> > - Minor fix of the include directories.
> >
> >  lib/mbedtls/Kconfig      | 36 +++++++++++++++
> >  lib/mbedtls/Makefile     |  3 +-
> >  lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 133 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/mbedtls/rsa_helper.c
> >
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index d8a8f87e031..87c500d6ca9 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -124,11 +124,13 @@ config LEGACY_CRYPTO_CERT
> >         bool "legacy certificate libraries"
> >         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +       select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
> >         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
> >         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
> >         select MSCODE_PARSER_LEGACY if MSCODE_PARSER
> >         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
> > +       select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
> && SPL
>
> SPL shouldn't be selected. IIRC we discussed the same thing on another
> patch, so I assume this is fixed already?
>
> Yes. It is already fixed in the upcoming v5 as below:
```
select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
```

Regards,
Raymond
