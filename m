Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4DEC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C26A884EA;
	Thu, 18 Jul 2024 22:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CtQZajYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55F38859C; Thu, 18 Jul 2024 22:39:59 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4745C88481
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ca8dfa2cceso534192a91.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721335196; x=1721939996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0yb+V67Nk/8UDA6AMYDZUxO/auPI1a+b9Kh2VfFBNs=;
 b=CtQZajYqllnTrLZkhAsne70YA3YybOAx+FEN9drVv3zx3cImJNbX8Bc93S2Uw3K4ZB
 Yb5PHK/n44E5gFMGV+xsg6aSQMymWgto65uzSONLPS2vD4d6CoiG3T3ME5qodod0N6b+
 XEG+VsMBTBBkAdFnmYck8+Vu9hUUbBE+6NLSjuja6HWd5GenRWp6RS6C3H8Ii4f3f4x2
 W9eaxyvKXEdDQZkPbYP3J7/tN6pBrSOqYkBuzUuemfXnrW0YIsiEPaLD1iP8WBv84+2r
 AECqUg14NnKUBd8h0BNGeEDlzRoJrPSAgcJpMpEB7jG5O4voSG4Ra6kCzHLMORuI9I0z
 rVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721335196; x=1721939996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0yb+V67Nk/8UDA6AMYDZUxO/auPI1a+b9Kh2VfFBNs=;
 b=WIvn74p5x5BlHkcOAe6XNJP+BrF9eS3ztTAP/OICNWsBY/8jB/YDHXTq6+uFoEmH5z
 n2ikeoJDQahf66ughvQbfv6x2SLypl+hqpNTTdgzKwlzIoL4GmIXi5h7G6RmqfPQYCbk
 X9y0jL7JHlAFjRYmKToWJHXNWqHSesZmgrmGLK3fjjVoONre9ixN7z8Q+3L5BEXLuLtC
 HQy6zkbAfwBfDmOnMe1N9XHOqvh9mEgp9PUncbS5GJTU9E9v0gcvhCfgcLSBmy1R/dbG
 dMpbiCaTNtyztLJliChwO2GtZok4sz3NBx8WfpCr3v/3fd7mOIvdFB/7AImY4rY/0y1U
 zANA==
X-Gm-Message-State: AOJu0Yy8aV4Qp5v96WH5OeRab72BGxhSFC4IM1tWVD4kVMfhysEyYLxr
 NhdxqAXGuZTs3ZbrqY28NIX4JYqbxyzHXcSfwl3vd4qS4A5zhF4lPyZZeUqWOvdqAItewafLK5s
 b0ins5SXFJGllIuSv9Dt4lBw66L3t2y0sn0RTZg==
X-Google-Smtp-Source: AGHT+IHQPoF2VahbISwMYJiNmMgahOoIa+JIBB9XQ8Qvnvvcyt6oZ9NvxKn+8uudlPVPgNZAvVUsDqQzzk7xgjhymq8=
X-Received: by 2002:a17:90b:a51:b0:2c9:7803:1cf6 with SMTP id
 98e67ed59e1d1-2cb527a1155mr4574957a91.20.1721335195639; Thu, 18 Jul 2024
 13:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-18-raymond.mao@linaro.org>
 <CAC_iWjL6E+SNLGjzO3s7-8MJH4XjKyPeN3WkUjQrxFRrjfO_7A@mail.gmail.com>
In-Reply-To: <CAC_iWjL6E+SNLGjzO3s7-8MJH4XjKyPeN3WkUjQrxFRrjfO_7A@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Jul 2024 16:39:43 -0400
Message-ID: <CAEfUkUJ7iq+J_x-8JXooSR8ishaJqvZ6krwaugxRvLUYN51LYw@mail.gmail.com>
Subject: Re: [PATCH v4 17/29] mbedtls: add public key porting layer
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
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
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

On Wed, 3 Jul 2024 at 07:47, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 2 Jul 2024 at 21:30, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add porting layer for public key on top of MbedTLS X509 library.
> > Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
> > MbedTLS implementations respectively.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Move the porting layer to MbedTLS dir.
> > Changes in v3
> > - None.
> > Changes in v4
> > - Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
> >   MbedTLS implementations respectively.
> > - Move common functions to helper.
> >
> >  lib/mbedtls/Kconfig      | 50 ++++++++++++++++++++++++
> >  lib/mbedtls/Makefile     |  7 +++-
> >  lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 138 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/mbedtls/public_key.c
> >
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index 0cdf0135667..6f29b0c81a2 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
>
[snip]

> > @@ -232,7 +258,31 @@ endif # MBEDTLS_LIB_CRYPTO
> >
> >  config MBEDTLS_LIB_X509
> >         bool "MbedTLS certificate libraries"
> > +       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
> > +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +       select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
> > +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
>
> Why do we have to select SPL here and in the Kconfig above for the
> legacy option?
>
> It should be:
"select SPL_<ALG>_<LEGACY/MBEDTLS> if SPL_<ALG>"
For example:
```
config MBEDTLS_LIB_X509
      bool "MbedTLS certificate libraries"
       [...]
       select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
              SPL_ASYMMETRIC_PUBLIC_KEY
```

Regards,
Raymond
