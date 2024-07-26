Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EA6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BBB884BE;
	Fri, 26 Jul 2024 16:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B32uUofz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06CE88637; Fri, 26 Jul 2024 16:05:12 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B6F878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a92098ec97so747840a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722002709; x=1722607509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jqC2iNB/4ejhlDsOazASki5Q0VHAotprybMkQddm5iU=;
 b=B32uUofzW/Nc5mzT3J+O69kboljEtfYBm8NqO7uL/NXdDYOm0B4US4pHYiKDFVkiPm
 5w67Lqm4hehNUpcOFdDmHYqrNluQQ8eeopUU9VPTJuqyerweeXpaDapxC4L193RKgc/R
 C2YSWNzMlOK4AMVO3VKXVELzJFzAdf2TJVC5gIV8zupjMv5W6/XdxLKnv3TOUtEToaXo
 vkO7FeCmlAvNSPP6zvjshdUB5nqTnAFkbl5M+eDF/zoeKQPmq1Dofk/dC6soJ2BAirf+
 pi0KhbdXNIE0fat2TKtqO/V4dsuom0scn1Sftewi5hNCW3ygZxYTGXjrPAglVzH7yClR
 p7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002709; x=1722607509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jqC2iNB/4ejhlDsOazASki5Q0VHAotprybMkQddm5iU=;
 b=jWR8yB0t26VRWT2rjKFlpLqUcfdSwm5ywqX4Rxvw9BpcyYIWnxYjgt1ye6QwfKvmjY
 ouPNswgdZib+XPYDawxXoTv2HK909JpU8K4eRLx+B2iiaphjuWd8tPV491oBv5ciUDxr
 BZwelrg+r8Pc92DWEbuNKy7FqTlfYVUbvf6a9pji/ifriaKxI68au0N9QA0MPm+r5yjc
 ZGSeGaQrk7EGkulmcOqmk/juvLgBsGwOBISsTUo6JFgGY7oGe/UHTMks5fh1DQIN+E1u
 X0lMFbHNV4m7Z0b6G548gnbiR2Aq9uMPZV+6bYKVQTptpoOwTX7RvrFgCr41G4BNmsaN
 Wong==
X-Gm-Message-State: AOJu0YxEr2ZfJJ5HjZCfI0uBLNrLdFsVfDjzgyK3RKHpbuywA9WCegYc
 uFC4kqXbG5GvoAvM0GOxWRqXQijLkSyqiy4Dt9sPMQ4PmDJnh+oStguZXRHECOajaHJ5jJklxER
 dtXgOCxK8H3uk1zMitaiQ3AWEZ2Py1VKUP5Y6DQ==
X-Google-Smtp-Source: AGHT+IFmkYY1q4hctLadM6EQTSDMzxyQp71bC3hdvxzke5Jbs+C7qWcDQI+anrUdLShLlWJ+hZADtl9YPEcnwQMsqIk=
X-Received: by 2002:a17:90a:6345:b0:2c9:7cc8:8e33 with SMTP id
 98e67ed59e1d1-2cf237b7e93mr7818591a91.13.1722002708778; Fri, 26 Jul 2024
 07:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-24-raymond.mao@linaro.org>
 <CAC_iWj+qFMj7JerKn6zJSE91uGSM=Dsceg8S3q+FHhY4dU031Q@mail.gmail.com>
In-Reply-To: <CAC_iWj+qFMj7JerKn6zJSE91uGSM=Dsceg8S3q+FHhY4dU031Q@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 26 Jul 2024 10:04:56 -0400
Message-ID: <CAEfUkU+fewZWsdaf9TvySHBeyR9KHY4jZCqd4EHFvc6XMGw65w@mail.gmail.com>
Subject: Re: [PATCH v4 23/29] mbedtls: add MSCode parser porting layer
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>, 
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

On Fri, 26 Jul 2024 at 06:10, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Tue, 2 Jul 2024 at 21:33, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add porting layer for MSCode on top of MbedTLS ASN1 library.
> > Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
> > MbedTLS implementations respectively.
>
> You should mention explicitly on the commit message, that this patch
> is expected to be merged in mbedTLS upstream and we can remove it in
> the future
>
> This patch is native U-Boot patch. The ones for MbedTLS upstream are all
tagged
with "mbedtls/external".


>
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Move the porting layer to MbedTLS dir.
> > Changes in v3
> > - None.
> > Changes in v4
> > - Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
> >   MbedTLS implementations respectively.
> > - Fix a few code style.
> >
> >  lib/mbedtls/Kconfig         |  17 +++++
> >  lib/mbedtls/Makefile        |   1 +
> >  lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 141 insertions(+)
> >  create mode 100644 lib/mbedtls/mscode_parser.c
> >
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index 8c5b617bb48..d8a8f87e031 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -126,6 +126,7 @@ config LEGACY_CRYPTO_CERT
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
> >         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
> > +       select MSCODE_PARSER_LEGACY if MSCODE_PARSER
> >         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
> >                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
> >         help
> > @@ -156,6 +157,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
> >           This option chooses legacy certificate library for PKCS7
> message
> >           parser.
> >
> > +config MSCODE_PARSER_LEGACY
>
> Where is this used? Is it on a later patch? The MSCODE_PARSER_MBEDTLS
> option is part of this patch on the Makefile
>
> It is used in the next patch (#24) , it is good to split into two since
they are in different
domains (mbedtls/crypto).

Regards,
Raymond
