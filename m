Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E913DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 15:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26522886DB;
	Thu, 30 May 2024 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lZ05wgmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4B7886DB; Thu, 30 May 2024 17:48:23 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94199883FA
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2bd816ecaf5so86632a91.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717084099; x=1717688899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivCZKnr5fwc971XDX3BNDZKG39sOq0AE/J1GdJdT+mE=;
 b=lZ05wgmvYad+cW06DC7avwfrZS8slDr0FYkuSi5JCk2SBQfK0+0GyZ0hirC11pip9o
 PsQQiOK5mX4+D+1gao8WJJ1wMcZDndr582fNUl9gK+C+5ch3iR5tPcOjHbB7xQYCSw2D
 CL/26fdK592zGn7srSYBpIH+I0bBkEI8OlQOim6CO0Gok7az5vjSPLBkcblRoR8g5JvY
 4v0QoBT0wuoPfDcooozHUbbs1w5h2du5f3KfYgDbSsB1bBhv4Eorv23NaYgjNV0ek81p
 PWaP9ESqumxSoSRPJ9A3OsIieob0JDhXb353dxRvxFWjdu/uW3wnJcodVF2oDkZatrMa
 Dj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717084099; x=1717688899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivCZKnr5fwc971XDX3BNDZKG39sOq0AE/J1GdJdT+mE=;
 b=P9zF2B3Z/BC9emurm2+6ZN7ygpkRIku0c45RjptzqbtDKEhWVp0jCSxP381H4h9SNG
 9vn9YTaWvaaQ/+9S84NKux2QQ3dCOUfatPBNAiED8ysh0VhJxY+hD/p88JnHeuca1atw
 ZJIkw0Teig01yPp3Ig6m5mBcz9acJnYcGIi7/nMR/6AiIWOgCdkM4URZmVXcFNySaKZC
 6mFCfq+uYcW8DnRxa0x+Eic7kOLzrHY/VPT4gDLrxCDQWc+qbDdYtJ7dGEF4gW2GsicK
 Asb0k7fH4ldOAKuEYz+Mieg3KhJNuzFmTypZzOnOg1L1ExmG1oALoaQMnFsJLiXjyN4e
 EEdw==
X-Gm-Message-State: AOJu0YzTpCkXmabjYoHaArq69SF8o2zS8vvkpW99uoJuFhP+WPit0fY1
 5g5hiprv9U/XDrw+p8hLFFJexkqQ35dmm1gE66FJgekRvWd99LfPNfMSEl1EmmB3/o3tTZy+1uY
 I5UeqpdIcf4ZofGUytTDQnx8d5Z5dNl4qh7x8BA==
X-Google-Smtp-Source: AGHT+IGPHkRU25Y3k9G2VLo7CYKcTbZ16h8D7jDxQ8eR3929hl+5HjozV8ln3cS1yui8kfGNKP6yod19U7X5Cd79IsI=
X-Received: by 2002:a17:90b:3c90:b0:2b9:ab0b:c5b with SMTP id
 98e67ed59e1d1-2c1ab9facf0mr2261207a91.17.1717084098972; Thu, 30 May 2024
 08:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
 <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
 <20240529184255.GC3714513@bill-the-cat>
 <CAEfUkUJOD=KEnUo=7BD14mW2yfq8ZnGREqMgOQfx2pkWxLvtzQ@mail.gmail.com>
 <20240529194715.GD3714513@bill-the-cat>
 <CAEfUkUK=NPS-_Jhi7==93YQUxkhOd-DjTn7AS4m9QCfGo86G3g@mail.gmail.com>
In-Reply-To: <CAEfUkUK=NPS-_Jhi7==93YQUxkhOd-DjTn7AS4m9QCfGo86G3g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 May 2024 18:47:42 +0300
Message-ID: <CAC_iWjJk8BHZgTcYAS-Jj1_iEq_XVGoKc6yZ0qQ2tnq1V0AMeA@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
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

Hi both,

[...]

>> > > > > > >
>> > > > > > > We need much more granularity here, and to re-think some existing
>> > > > > > > symbols too perhaps. What we should be able to do is pick mbedTLS
>> > > or
>> > > > > > > "legacy SW implementation" or "HW implementation" for the various
>> > > > > > > algorithms, and that in turn can have some higher level grouping
>> > > to it.
>> > > > > > > This should then negate a bunch of the Makefile work you're doing
>> > > as we
>> > > > > > > won't have CONFIG_SHA256 enabled as we'll have
>> > > > > CONFIG_MBEDTLS_LIB_SHA256
>> > > > > > > or whatever enabled.
>> > > > > > >
>> > > > > >
>> > > > > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for
>> > > high-level
>> > > > > > grouping.
>> > > > > > Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto
>> > > options)
>> > > > > > can be
>> > > > > > used as sub build options in both MbedTLS and "legacy libs".
>> > > > > >
>> > > > > > Take hash as an example, if the users prefer to use MbedTLS other
>> > > than
>> > > > > > "legacy libs" for
>> > > > > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the
>> > > main
>> > > > > > switch
>> > > > > > (the users can still prefer to use "legacy libs" for X509 by
>> > > > > > keeping  CONFIG_MBEDTLS_LIB_X509
>> > > > > > disabled).
>> > > > > > Then enable the algorithms they need (e.g. CONFIG_SHA256) - the
>> > > algorithm
>> > > > > > options works
>> > > > > > for both MbedTLS and "legacy libs".
>> > > > > >
>> > > > > > HW implementations with MbedTLS (aka, Alternative algorithms in
>> > > MbedTLS)
>> > > > > is
>> > > > > > another
>> > > > > > topic which is not covered in this patch set (It needs to migrate
>> > > each
>> > > > > > vendor's solution under
>> > > > > > MbedTLS alternative algorithm).
>> > > > > > Current patch set is focused on SW implementation with MbedTLS.
>> > > > >
>> > > > > The "easy" problem with what's in v3 is that X509 and CRYPTO are
>> > > > > select'd under the main heading.
>> > > >
>> > > > Not sure if I get what you mentioned, currently all MbedTLS options are
>> > > > under
>> > > > Library routines > Security support
>> > > > Do you think we should keep them in other places?
>> > > >
>> > > >
>> > > > > The harder problem is that we
>> > > > > intentionally have granularity for SHA256, SHA512, etc, etc and all of
>> > > > > that goes away with the current Kconfig option if you select mbedTLS.
>> > > We
>> > > > > need to bring that back. And we shouldn't need to have all of the ifneq
>> > > > > statements in Makefiles because both CONFIG_SHA256 and
>> > > > > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
>> > > > > CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
>> > > > > something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).
>> > > > >
>> > > > > I think we should not introduce new ones like CONFIG_LEGACY_,
>> > > > CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
>> > > > enabled or not.
>> > > > I understand your concern, I will bring CONFIG_SHA[1,256,512] back when
>> > > > MbedTLS is enabled. Those options should control the options in the
>> > > MbedTLS
>> > > > default config file.
>> > >
>> > > My concern is that we do not have the correct level of granularity, and
>> > > that can partly be seen by the number of ifneq(...) statements being
>> > > added around already conditional logic. We should have almost none of
>> > > those, in the end, is what I'm saying. We have a mechanism for
>> > > configuring the build, Kconfig, and that should drive the decisions as
>> > > much as possible.
>> >
>> > The `ifneq(ONFIG_MBEDTLS_LIB_*)` statements are due to the fact that we
>> > still
>> > need lib/Makefile and lib/crypto/Makefile when building hash and x509
>> > stuffs with
>> > MbedTLS enabled.
>> > To address this, I guess we have to first refactor all "legacy libs" that
>> > will be replaced
>> > by MbedTLS:
>> > Move md5, sha* from lib to to a new dir lib/hash and move public_key,
>> > rsapubkey*,
>> > rsa_helper, x509*, pkcs7*,mscode* from lib/crypto to a new dir lib/x509.
>> > When they are all independent modules with separated Makefile, we can remove
>> > `ifneq(ONFIG_MBEDTLS_LIB_*)` and all can be driven in lib/Makefile.
>> >
>> > Is that something you expect?
>> > If yes I can do this for v4, or put it into another prerequisite/refactor
>> > series.
>>
>> We should not need to do that because we should not have CONFIG_SHA256
>> set if we are not building lib/sha256.c at that stage, is what I'm
>> saying. CONFIG_LEGACY_SHA256 should control it and CONFIG_SHA256 should
>> control the API and CONFIG_MBEDTLS_LIB_CRYPTO_SHA256 should control the
>> mbedTLS version, and this should either expand on, or if needed
>> update/rework, the mechanism that lets us also have say
>> CONFIG_ARMV8_CE_SHA256 for using that HW based version of the support.
>>
>
> But in this case we have to introduce two new Kconfigs for each algorithm -
> CONFIG_LEGACY_<alg> and CONFIG_MBEDTLS_LIB_CRYPTO_<alg>.
> CONFIG_<alg> is still there, so we have totally 3 Kconfigs for one hash alg which
> seems adding too much complexity.

I haven't looked at your v4 yet, but I think Tom is on the right path here.
Yes, it might be a bit more work, but in the long run, it's going to
be easier to maintain both in Makefiles and code.

I think Tom is saying
The API should be gated by CONFIG_SHA1, CONFIG_SHA256 etc
the individual implementation musty carry their own symbols e.g
CONFIG_MBEDTLS_SHA256
CONFIG_LEGACY_SHA256 etc.

If any of those are selected you turn on CONFIG_SHA256

Thanks
/Ilias

>
> Moreover, this means allowing the user to select algorithms mix up with MbedTLS
> and legacy ones, for example, user can select both CONFIG_LEGACY_SHA1
> and CONFIG_MBEDTLS_LIB_CRYPTO_SHA256 at the same time.
> It means to build both legacy lib and MbedTLS which does not make sense.
>
> Why we don't have the CONFIG_MBEDTLS_LIB_CRYPTO as the higher level
> switch and keep CONFIG_<alg> as it was to select the algorithms?
> We still have the same granularity with this I think - and yes I will put CONFIG_<alg>
> in the MbedTLS config file so that it can control only the selected algorithms to be
> built.
> The only downside I can see here is adding a few `ifneq(ONFIG_MBEDTLS_LIB_*)`
> in lib/Makefile and lib/crypto/Makefile, but all the rest of things are straightforward and
> clean.
>
> Thanks.
> Regards,
> Raymond
