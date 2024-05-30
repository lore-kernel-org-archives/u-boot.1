Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E409C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 16:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD29E88252;
	Thu, 30 May 2024 18:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YgZ7HG0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5468886AB; Thu, 30 May 2024 18:14:30 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1C687F51
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 18:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6c191abea71so431978a12.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717085666; x=1717690466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ue/oTY60PYyjliaidYjmebIjChMiwh9tIvgK/+EQYiw=;
 b=YgZ7HG0YvZyh7qs2hZrG1BXkjMJZO4oo1cRqjxmyW6nLmxezt9QbH8vuYrAbNFyl4p
 6iUlSrgs1qPliIRS6YxGbw8GWPIfvLD/f44/sIpLn4gylxD5ZoTtCsArnoqhhjPlSY5z
 nvS7fBw38Fo27fck4nXjFEPdrd+qyifB+FMatQHgy84Tba55LJrJBK/KtvrpMfbc8R2F
 lQX6t+u4gzjIUvW5nOd2wqbXrUxPx7Y+SJ/mu+NE+2m5jZKqDsJI0prWxxyLPhF0mTvp
 JrztzdPbHFmlBH6d96Xu6gHHsWtA4z2lAfVHd1Xa9Ho46dUq5QlMxfU/anzdLr6kzguX
 IkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717085666; x=1717690466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ue/oTY60PYyjliaidYjmebIjChMiwh9tIvgK/+EQYiw=;
 b=ByHtK6YGoiK0E3TbedS5Uf4zl5PFenC7xe17B0vWSEppOAgmkoSiXr/KXpI0XCc3jH
 lgSK4whKlTLsLJeN3aanq7Ugygxlmu9FDH6nA+IXMy4e4YKgujnLEp3j4NvVnrgDdS10
 +dYm9nZ+eNfI62Qn+WQF8Gq//8Dw5QyCiqvmQfJcylofiNcdpD5+25okc0I0bxuvS1aP
 NKWHbBvOJGCUvfyhH4ngFf3sbx/fpPhSKwHmaT+qgrNcgLUQ8uNDrVvbz3RO3/ZwJlpT
 UOzga5hJHKiZD7Qa4YSbYQSyvnDDI/mhVooEa9dOxX3AJMZybtNFzryy8wv163BCgylv
 8XlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQtaXgTIPMHfd6RNFMhG4TOdtaRO45fAiUdde/UfsFbHBhSrjEMYRVlTB2lV2CYHdZFFJZP1XVToewuBNFRhOM8onVFw==
X-Gm-Message-State: AOJu0Yzziboj/3Che4fjBgn1LLt1qwlvlKVMjx2jV1zlCU2eb5UBf3jm
 koOHOy4wwLZGlP3SV9+fQGHXAlzGEUJ+SAQL1S7DR/Q0GsJm3vfG8F48lcig7Vs/ElEMfaACdiu
 4a6eaIY49ESejXqzxujZfEx+Wu8byOoTd/eaksg==
X-Google-Smtp-Source: AGHT+IHtIVekn6IK2B7mQEnWScVZ4UPEy1ZRZ1ZK8MUYlV17WNmNvMc9bAIXY4ISMO0EJGdOgjgFpYtwS+2vDhzcRFE=
X-Received: by 2002:a17:90a:f283:b0:2bd:f712:48c5 with SMTP id
 98e67ed59e1d1-2c1abc4950dmr2757518a91.49.1717085666467; Thu, 30 May 2024
 09:14:26 -0700 (PDT)
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
 <CAC_iWjJk8BHZgTcYAS-Jj1_iEq_XVGoKc6yZ0qQ2tnq1V0AMeA@mail.gmail.com>
In-Reply-To: <CAC_iWjJk8BHZgTcYAS-Jj1_iEq_XVGoKc6yZ0qQ2tnq1V0AMeA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 30 May 2024 12:14:14 -0400
Message-ID: <CAEfUkULGrRGRe5Uf8R658BfW-Hvn8rcbgzvBhqNr4pbZVnThtw@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
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

Hi Ilias,

On Thu, 30 May 2024 at 11:48, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi both,
>
> [...]
>
> >> > > > > > >
> >> > > > > > > We need much more granularity here, and to re-think some
> existing
> >> > > > > > > symbols too perhaps. What we should be able to do is pick
> mbedTLS
> >> > > or
> >> > > > > > > "legacy SW implementation" or "HW implementation" for the
> various
> >> > > > > > > algorithms, and that in turn can have some higher level
> grouping
> >> > > to it.
> >> > > > > > > This should then negate a bunch of the Makefile work you're
> doing
> >> > > as we
> >> > > > > > > won't have CONFIG_SHA256 enabled as we'll have
> >> > > > > CONFIG_MBEDTLS_LIB_SHA256
> >> > > > > > > or whatever enabled.
> >> > > > > > >
> >> > > > > >
> >> > > > > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for
> >> > > high-level
> >> > > > > > grouping.
> >> > > > > > Underneath, the CONFIG_SHA[1,256,512] switches (and other
> crypto
> >> > > options)
> >> > > > > > can be
> >> > > > > > used as sub build options in both MbedTLS and "legacy libs".
> >> > > > > >
> >> > > > > > Take hash as an example, if the users prefer to use MbedTLS
> other
> >> > > than
> >> > > > > > "legacy libs" for
> >> > > > > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined
> as the
> >> > > main
> >> > > > > > switch
> >> > > > > > (the users can still prefer to use "legacy libs" for X509 by
> >> > > > > > keeping  CONFIG_MBEDTLS_LIB_X509
> >> > > > > > disabled).
> >> > > > > > Then enable the algorithms they need (e.g. CONFIG_SHA256) -
> the
> >> > > algorithm
> >> > > > > > options works
> >> > > > > > for both MbedTLS and "legacy libs".
> >> > > > > >
> >> > > > > > HW implementations with MbedTLS (aka, Alternative algorithms
> in
> >> > > MbedTLS)
> >> > > > > is
> >> > > > > > another
> >> > > > > > topic which is not covered in this patch set (It needs to
> migrate
> >> > > each
> >> > > > > > vendor's solution under
> >> > > > > > MbedTLS alternative algorithm).
> >> > > > > > Current patch set is focused on SW implementation with
> MbedTLS.
> >> > > > >
> >> > > > > The "easy" problem with what's in v3 is that X509 and CRYPTO are
> >> > > > > select'd under the main heading.
> >> > > >
> >> > > > Not sure if I get what you mentioned, currently all MbedTLS
> options are
> >> > > > under
> >> > > > Library routines > Security support
> >> > > > Do you think we should keep them in other places?
> >> > > >
> >> > > >
> >> > > > > The harder problem is that we
> >> > > > > intentionally have granularity for SHA256, SHA512, etc, etc and
> all of
> >> > > > > that goes away with the current Kconfig option if you select
> mbedTLS.
> >> > > We
> >> > > > > need to bring that back. And we shouldn't need to have all of
> the ifneq
> >> > > > > statements in Makefiles because both CONFIG_SHA256 and
> >> > > > > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
> >> > > > > CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
> >> > > > > something and CONFIG_LEGACY_SHA256 controls building
> lib/sha256.c).
> >> > > > >
> >> > > > > I think we should not introduce new ones like CONFIG_LEGACY_,
> >> > > > CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
> >> > > > enabled or not.
> >> > > > I understand your concern, I will bring CONFIG_SHA[1,256,512]
> back when
> >> > > > MbedTLS is enabled. Those options should control the options in
> the
> >> > > MbedTLS
> >> > > > default config file.
> >> > >
> >> > > My concern is that we do not have the correct level of granularity,
> and
> >> > > that can partly be seen by the number of ifneq(...) statements being
> >> > > added around already conditional logic. We should have almost none
> of
> >> > > those, in the end, is what I'm saying. We have a mechanism for
> >> > > configuring the build, Kconfig, and that should drive the decisions
> as
> >> > > much as possible.
> >> >
> >> > The `ifneq(ONFIG_MBEDTLS_LIB_*)` statements are due to the fact that
> we
> >> > still
> >> > need lib/Makefile and lib/crypto/Makefile when building hash and x509
> >> > stuffs with
> >> > MbedTLS enabled.
> >> > To address this, I guess we have to first refactor all "legacy libs"
> that
> >> > will be replaced
> >> > by MbedTLS:
> >> > Move md5, sha* from lib to to a new dir lib/hash and move public_key,
> >> > rsapubkey*,
> >> > rsa_helper, x509*, pkcs7*,mscode* from lib/crypto to a new dir
> lib/x509.
> >> > When they are all independent modules with separated Makefile, we can
> remove
> >> > `ifneq(ONFIG_MBEDTLS_LIB_*)` and all can be driven in lib/Makefile.
> >> >
> >> > Is that something you expect?
> >> > If yes I can do this for v4, or put it into another
> prerequisite/refactor
> >> > series.
> >>
> >> We should not need to do that because we should not have CONFIG_SHA256
> >> set if we are not building lib/sha256.c at that stage, is what I'm
> >> saying. CONFIG_LEGACY_SHA256 should control it and CONFIG_SHA256 should
> >> control the API and CONFIG_MBEDTLS_LIB_CRYPTO_SHA256 should control the
> >> mbedTLS version, and this should either expand on, or if needed
> >> update/rework, the mechanism that lets us also have say
> >> CONFIG_ARMV8_CE_SHA256 for using that HW based version of the support.
> >>
> >
> > But in this case we have to introduce two new Kconfigs for each
> algorithm -
> > CONFIG_LEGACY_<alg> and CONFIG_MBEDTLS_LIB_CRYPTO_<alg>.
> > CONFIG_<alg> is still there, so we have totally 3 Kconfigs for one hash
> alg which
> > seems adding too much complexity.
>
> I haven't looked at your v4 yet, but I think Tom is on the right path here.
> Yes, it might be a bit more work, but in the long run, it's going to
> be easier to maintain both in Makefiles and code.
>
> I think Tom is saying
> The API should be gated by CONFIG_SHA1, CONFIG_SHA256 etc
> the individual implementation musty carry their own symbols e.g
> CONFIG_MBEDTLS_SHA256
> CONFIG_LEGACY_SHA256 etc.
>
> If any of those are selected you turn on CONFIG_SHA256
>
> But for example, in that case, users can pick sha1 from legacy lib but
sha256 from
MbedTLS by selecting both:
CONFIG_LEGACY_SHA1
CONFIG_MBEDTLS_LIB_CRYPTO_SHA256
This is not something we want.

The user should only allow completely switching to MbedTLS or stay with
legacy lib.
That is why I believe we need a high level switch CONFIG_MBEDTLS_LIB_CRYPTO.

Regards,
Raymond
