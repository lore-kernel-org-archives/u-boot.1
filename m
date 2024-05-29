Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8668DC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8196688611;
	Wed, 29 May 2024 21:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FMOLT/PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 872E48864C; Wed, 29 May 2024 21:42:20 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7657885E1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70223dffaf6so131588b3a.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717011736; x=1717616536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sNUNdM9DnCiyUfn14ULt+nOfY2IIS9s74o9Cf33HKUI=;
 b=FMOLT/PIJZ3/pzhbg9V1twilmzuLMeLhHq2HcWI30AGIMrmsopqMrCheUoajURBpJ9
 /R7DuERydNug+Hxrt996JtTYvM9qWRghfs2JTb4M8mZ3vOCrly6uTbs2VIzkukXMLi6G
 imiQ4/bjgx9t+lPIWIFuO0ybwy/CrVyHzvSqRhpFqj1W10gqXGidi2RSQCRJSvdA2YCS
 Z/Ej/B5qanbnj/UHBoFETNtgHSbmT2QuzZLyQMYkmxYWShtspgbxAVPGz5othgnE1JfD
 b/XGx8cfGO+GwhKVetb5t+WmCrkEUaqMBzWYatrjtXLWi40bHRalHw6CTnXhgFwaCCpY
 vsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717011736; x=1717616536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNUNdM9DnCiyUfn14ULt+nOfY2IIS9s74o9Cf33HKUI=;
 b=mdmyPruO0F/gVpBPjZfOjVNv/YXKLIBxG1PBi65yPjoW7HNoH7M+X+971M1BbTSzcd
 gXOdEV/iBIveWz7/ZIhTicgjN7LFRekrTAgynLJ/FyE2KllF+Ps2Qo1nMWzmqx27QKgd
 WxuLYVCl6Pwu6wrkx733URQi+PYuyHxBgCEMyoS0pjLVqDnWGe79D9Ja8Tl8YX7ij2PF
 vFw0ZQBMu7jFJcf+68Vd/0fXAMGXwcrKgllPJ8Ye+L5uii3oSP8H7yvhYUiNpCMTQxrI
 ODTD2Y3DMsMXciEr4AwXJcg5OpL20Bn4lIlmyULOTabwkCZB0RsgqgGNcR2WdIW/gJl9
 PplQ==
X-Gm-Message-State: AOJu0YxgchG+OVO0zYhKZtoN+lTM233bhpWvMqtJu6u8CEJXUJKQaiM9
 Ky11fVPgGJXy9Js25XfCitrsE0R+g+POkg7x0rIav1+FVe+9OuoaIXPEQmlTxJ6F65jyBmINUUM
 5/t4nAaJkRUCuWjeEqAGJpcb9KQir3Zv0yUIkjQ==
X-Google-Smtp-Source: AGHT+IER3G2RLPhxFwDmu+TsNBNZGkv8ZLpNK4IxRxuGlCWCd22tCxL0JqulrWddXl58h3czzJh44zH5sLru+QPfTz8=
X-Received: by 2002:a05:6a00:6c9c:b0:6ed:60a4:777b with SMTP id
 d2e1a72fcca58-70231106e91mr62b3a.8.1717011735940; Wed, 29 May 2024 12:42:15
 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
 <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
 <20240529184255.GC3714513@bill-the-cat>
In-Reply-To: <20240529184255.GC3714513@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 29 May 2024 15:42:04 -0400
Message-ID: <CAEfUkUJOD=KEnUo=7BD14mW2yfq8ZnGREqMgOQfx2pkWxLvtzQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
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

Hi Tom,

On Wed, 29 May 2024 at 14:43, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 29, 2024 at 02:38:10PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 29 May 2024 at 14:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> > > > >
> > > > > > Port mbedtls with dummy libc header files.
> > > > > > Add mbedtls default config header file.
> > > > > > Optimize mbedtls default config by disabling unused features to
> > > > > > reduce the target size.
> > > > > > Add mbedtls kbuild makefile.
> > > > > > Add Kconfig and mbedtls config submenu.
> > > > > [snip]
> > > > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > > > new file mode 100644
> > > > > > index 00000000000..d6e77d56871
> > > > > > --- /dev/null
> > > > > > +++ b/lib/mbedtls/Kconfig
> > > > > > @@ -0,0 +1,25 @@
> > > > > > +menuconfig MBEDTLS_LIB
> > > > > > +     bool "Use mbedtls libraries"
> > > > > > +     select MBEDTLS_LIB_CRYPTO
> > > > > > +     select MBEDTLS_LIB_X509
> > > > > > +     help
> > > > > > +       Enable mbedtls libraries
> > > > > > +
> > > > > > +if MBEDTLS_LIB
> > > > > > +
> > > > > > +config MBEDTLS_LIB_CRYPTO
> > > > > > +     bool "Crypto library"
> > > > > > +     help
> > > > > > +       Enable mbedtls crypto library
> > > > > > +
> > > > > > +config MBEDTLS_LIB_X509
> > > > > > +     bool "X509 library"
> > > > > > +     help
> > > > > > +       Enable mbedtls X509 library
> > > > > > +
> > > > > > +config MBEDTLS_LIB_TLS
> > > > > > +     bool "TLS library"
> > > > > > +     help
> > > > > > +       Enable mbedtls TLS library
> > > > > > +
> > > > > > +endif # MBEDTLS_LIB
> > > > >
> > > > > We need much more granularity here, and to re-think some existing
> > > > > symbols too perhaps. What we should be able to do is pick mbedTLS
> or
> > > > > "legacy SW implementation" or "HW implementation" for the various
> > > > > algorithms, and that in turn can have some higher level grouping
> to it.
> > > > > This should then negate a bunch of the Makefile work you're doing
> as we
> > > > > won't have CONFIG_SHA256 enabled as we'll have
> > > CONFIG_MBEDTLS_LIB_SHA256
> > > > > or whatever enabled.
> > > > >
> > > >
> > > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for
> high-level
> > > > grouping.
> > > > Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto
> options)
> > > > can be
> > > > used as sub build options in both MbedTLS and "legacy libs".
> > > >
> > > > Take hash as an example, if the users prefer to use MbedTLS other
> than
> > > > "legacy libs" for
> > > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the
> main
> > > > switch
> > > > (the users can still prefer to use "legacy libs" for X509 by
> > > > keeping  CONFIG_MBEDTLS_LIB_X509
> > > > disabled).
> > > > Then enable the algorithms they need (e.g. CONFIG_SHA256) - the
> algorithm
> > > > options works
> > > > for both MbedTLS and "legacy libs".
> > > >
> > > > HW implementations with MbedTLS (aka, Alternative algorithms in
> MbedTLS)
> > > is
> > > > another
> > > > topic which is not covered in this patch set (It needs to migrate
> each
> > > > vendor's solution under
> > > > MbedTLS alternative algorithm).
> > > > Current patch set is focused on SW implementation with MbedTLS.
> > >
> > > The "easy" problem with what's in v3 is that X509 and CRYPTO are
> > > select'd under the main heading.
> >
> > Not sure if I get what you mentioned, currently all MbedTLS options are
> > under
> > Library routines > Security support
> > Do you think we should keep them in other places?
> >
> >
> > > The harder problem is that we
> > > intentionally have granularity for SHA256, SHA512, etc, etc and all of
> > > that goes away with the current Kconfig option if you select mbedTLS.
> We
> > > need to bring that back. And we shouldn't need to have all of the ifneq
> > > statements in Makefiles because both CONFIG_SHA256 and
> > > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
> > > CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
> > > something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).
> > >
> > > I think we should not introduce new ones like CONFIG_LEGACY_,
> > CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
> > enabled or not.
> > I understand your concern, I will bring CONFIG_SHA[1,256,512] back when
> > MbedTLS is enabled. Those options should control the options in the
> MbedTLS
> > default config file.
>
> My concern is that we do not have the correct level of granularity, and
> that can partly be seen by the number of ifneq(...) statements being
> added around already conditional logic. We should have almost none of
> those, in the end, is what I'm saying. We have a mechanism for
> configuring the build, Kconfig, and that should drive the decisions as
> much as possible.
>
> The `ifneq(ONFIG_MBEDTLS_LIB_*)` statements are due to the fact that we
still
need lib/Makefile and lib/crypto/Makefile when building hash and x509
stuffs with
MbedTLS enabled.
To address this, I guess we have to first refactor all "legacy libs" that
will be replaced
by MbedTLS:
Move md5, sha* from lib to to a new dir lib/hash and move public_key,
rsapubkey*,
rsa_helper, x509*, pkcs7*,mscode* from lib/crypto to a new dir lib/x509.
When they are all independent modules with separated Makefile, we can remove
`ifneq(ONFIG_MBEDTLS_LIB_*)` and all can be driven in lib/Makefile.

Is that something you expect?
If yes I can do this for v4, or put it into another prerequisite/refactor
series.

Regards,
Raymond
