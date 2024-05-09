Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE0C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B31087FD7;
	Thu,  9 May 2024 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gT6DCr5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DC288076; Thu,  9 May 2024 17:16:06 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1E987DEA
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2b4aa87e01aso780574a91.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715267763; x=1715872563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XcZ7MZ4rl89u5vpQaUu2JAg612ZP61kFKe9cUF58Wp0=;
 b=gT6DCr5So6KTuQ0AJP3WPkjkr4KVCJa4w5aKXxkERtv3AD38v61btf+bssw7t4+vcj
 4ZaG8Yr3sB6l8G/und9przO8BIHhBWeW6arqlf2m8GAPaJKJpAtJt5TRfkiqEK8Osg69
 AC0kRIcAQBuBevTqXf7ZRqGE2F1uJ8vp9/JchScnySOZGy+kMhjw4X3uIdhxzfhGv+Ba
 rDBmcaqfGnXQj5b99dR0rLpai7VPOzwrCiWKBzkjUhCPEnbbkQbKBy7II+J2p+kPrh4/
 /GCgYqvRPxwdl1aGcfWK/fSNDu/zNv1FqDP5cxudqIs5sh4PJnYNDNcLfhlrjOsG/uuw
 FPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715267763; x=1715872563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcZ7MZ4rl89u5vpQaUu2JAg612ZP61kFKe9cUF58Wp0=;
 b=gFb5irzAHMMAVV4Bdqx7AtA/tbHbrVHAwhdmi+UaFXyhmCXSUEvKpyD4OB8lUXH+lF
 KFReknUFyllwTypFSUCq5aRvdx5TZrwhBKcbhm6aEFQ1CKi39FRw6RJtThw2luyklZ4D
 Y7xiBDLUDkF+BuaR3Fvp6tZ4EZpZqe7QE7x7Fxknjbq4JlIkb8T+lqPIR+H3uiVjn+Jo
 6QIylWUmvcpYtJ0FGXXQWMLBAWP/FDngg1wmZ12oBDBRTxxSYpVodSBZ9rEjCRYNNfee
 BlFDLvOZqYhzYoZupjULudhL5i+x0XhEfCioUczv9vsrfnp+RxQay8X4LOhw3Q95dvXR
 EIFA==
X-Gm-Message-State: AOJu0YxMsvQOMt1v+h5da/kQG+72bR3QVjgkcVkzaS0Xoesex+LEhGvJ
 D0UzTjReOV8Ffg5DxLINo+U9Q63DsC7uLWwAFoX7LM+uflGy/QfbrY09dTM+bv/bqLv71++rROH
 EhIzT4XwRw3zyVAp1MXdxZL8W+KXFvIIFPRyJRA==
X-Google-Smtp-Source: AGHT+IFLoSKmNzHIXR7p5+ObejyoMSJ0eyuHB2UiNeZ6DyTqejcMN+NvnaR+MjVLIFQ5LZGkiHqxF/toTZ56tQKdlWQ=
X-Received: by 2002:a17:90a:de0b:b0:2af:ff3:e14a with SMTP id
 98e67ed59e1d1-2b61808fae6mr5502140a91.16.1715267762569; Thu, 09 May 2024
 08:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-8-raymond.mao@linaro.org>
 <CAC_iWjJ50--SCCEq3srxD0+F_5_5s_okfghcsjJrA+WJ9ftWLg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ50--SCCEq3srxD0+F_5_5s_okfghcsjJrA+WJ9ftWLg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 9 May 2024 11:15:48 -0400
Message-ID: <CAEfUkUKgagdhdCOPon=8fUgSiiiT0Rr_EHEg-4mDDp-+0=4+iQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] lib: Adapt digest header files to MbedTLS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Wed, 8 May 2024 at 06:30, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 7 May 2024 at 20:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Adapt digest header files to support both original libs and MbedTLS
> > by switching on/off MBEDTLS_LIB_CRYPTO
> >
> > FIXME:
> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > including <linux/kconfig.h> causes undefined reference on schedule()
> > with sandbox build.
> > As <linux/kconfig.h> includes <generated/autoconf.h> which enables
> > `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule() are
> > defined in sandbox build.
> > `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` is a workaround.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch.
> >
> >  include/u-boot/md5.h    | 17 ++++++++++++-----
> >  include/u-boot/sha1.h   | 21 ++++++++++++++++++++-
> >  include/u-boot/sha256.h | 20 ++++++++++++++++++++
> >  include/u-boot/sha512.h | 22 +++++++++++++++++++---
> >  lib/Makefile            |  6 +++++-
> >  5 files changed, 76 insertions(+), 10 deletions(-)
> >
> [snip]
> > diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> > index 9aa1251789a..e2b7fdd41c8 100644
> > --- a/include/u-boot/sha256.h
> > +++ b/include/u-boot/sha256.h
> > @@ -1,6 +1,22 @@
> >  #ifndef _SHA256_H
> >  #define _SHA256_H
> >
> > +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> > +/*
> > + * FIXME:
> > + * MbedTLS define the members of "mbedtls_sha256_context" as private,
> > + * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.
>
> 'be able to access.'
>
> Isn't the MBEDTLS_ALLOW_PRIVATE_ACCESS considered deprecated?
> I'd prefer if we fix this properly.
>
> If  MBEDTLS_ALLOW_PRIVATE_ACCESS is deprecated, that is another issue
other than the one I marked FIXME here.
Once MBEDTLS_ALLOW_PRIVATE_ACCESS is deprecated, all callers are not
able to access the private members (e.g. 'hash->state').
Currently only arm drivers are using 'hash->state', but I don't have the
background
context about this - why we cannot use the normal hash functions without
knowing
the 'state' like other arches.

Regards,
Raymond
