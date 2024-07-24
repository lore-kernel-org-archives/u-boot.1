Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C0EC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FB888918;
	Wed, 24 Jul 2024 16:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EcZceHBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3AF88938; Wed, 24 Jul 2024 16:37:20 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD30D8889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b78c980981so37541896d6.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831837; x=1722436637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+EVG8Wsag0JB2h8x63I4QQF3kHjmandcjmG5BjhwrDo=;
 b=EcZceHBlY/HOh7jqmiRoRtsWCZJXP6+OLZ2d7F6IZdKqwyopOaQBiXprZgc1sLWd2y
 a5gZ/XbMJueGh94ky3RSj1thkSBWJasgK0dBptUruv9S9DJuh/tTTCy/fLMioaJu9GxQ
 sQFZBnpjWFfIfUUI/Im9GlQWNrSFQPi7K0Als=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831837; x=1722436637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+EVG8Wsag0JB2h8x63I4QQF3kHjmandcjmG5BjhwrDo=;
 b=A4rqcb8G0J58j7eJwdOG+ZjrR+Qb6dhbKcdHiwBtucheukdDVAnFHB9EdOO+Yz1XmS
 /fgqIdIQzRnODAcgGI49Ec74aE0fs+STIb91ftxqfZtaNORvtDO6jZQYlnFRPPfcwVit
 Onv/e+DbOzvetQ9O8RM5niUpg/QN8Cb5mOncv1EfPcbtgLFaQHWv08ZxD1mHM9Yl4a9n
 PASSTHPGLjV7gSRWvvNWlfDrmdHIlAo1BEjnNIXr96+acZCZaLU0fewX+z0LCA/N91AG
 4fxr4RCxh0gLn6UkfPv3J3f6ib7JaPaoGl+6pDmaKgbfsrlqzziYoIIwtuvHbQ/595Jn
 D+mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkQOXRZFXqGnFS7jVfBG0brj/jDpx+ZyNr1ORX0ImyogS5sCtlNUsRcSEt5YrMj3PiUf9naSk4yA0QFcRJOYm5caHwRw==
X-Gm-Message-State: AOJu0YzJB85WylTuJFODTFuyxLJ5QsZwBrusnSlacW0wBAGIqYdyRhie
 KP1CZZ1Zfsfzxq7o4GzwUDhCwPNlxZUch2lGergVwy6ncpb2/10dak0nH2ka9+AGcRt5jhFlfcf
 BQKjQ1RfjD+M/GNTZgLWJQd0jNYucKWDZ+dDv
X-Google-Smtp-Source: AGHT+IGlMOpYCKdZ8eugKgYY4gUQXQu9Exl6v5WoWkJ6DJrisf/UUVuz5vg5Zmk/sB+qOYd48Gqlw8OmWBEclALv6GQ=
X-Received: by 2002:a05:6214:c46:b0:6b7:4712:c878 with SMTP id
 6a1803df08f44-6b9907c79f5mr28448946d6.41.1721831836419; Wed, 24 Jul 2024
 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
 <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
In-Reply-To: <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:05 -0600
Message-ID: <CAFLszTjNpqGYTBX0=KrZH2Qwo2X=hqX3+4BDUHmkhfn_FViLcg@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Raymond,

On Wed, 24 Jul 2024 at 08:35, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom,
>
> On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
>>
>> > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
>> >
>> > Motivations:
>> > ------------
>> >
>> > 1. MbedTLS is well maintained with LTS versions.
>> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
>> > 3. MbedTLS recently switched license back to GPLv2.
>> >
>> > Prerequisite:
>> > -------------
>> >
>> > This patch series requires mbedtls git repo to be added as a
>> > subtree to the main U-Boot repo via:
>> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>> >           https://github.com/Mbed-TLS/mbedtls.git \
>> >           v3.6.0 --squash
>> > Moreover, due to the Windows-style files from mbedtls git repo,
>> > we need to convert the CRLF endings to LF and do a commit manually:
>> >     $ git add --renormalize .
>> >     $ git commit
>> >
>> > New Kconfig options:
>> > --------------------
>> >
>> > `MBEDTLS_LIB` is for MbedTLS general switch.
>> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
>> > MbedTLS.
>> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
>> > and Pubkey parser with MbedTLS.
>> > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTLS is
>> > ready).
>> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
>> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
>> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
>> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
>> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
>> > introduced.
>> >
>> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
>> > are by default enabled in qemu_arm64_defconfig for testing purpose.
>> >
>> > Patches for external MbedTLS project:
>> > -------------------------------------
>> >
>> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
>> > executables which is not supported by MbedTLS at the moment,
>> > addtional patches for MbedTLS are created to adapt with the EFI loader:
>> > 1. Decoding of Microsoft Authentication Code.
>> > 2. Decoding of PKCS#9 Authenticate Attributes.
>> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
>> > 4. MbedTLS native test suites for PKCS#7 signer's info.
>> >
>> > All above 4 patches (tagged with `mbedtls/external`) are submitted to
>> > MbedTLS project and being reviewed, eventually they should be part of
>> > MbedTLS LTS release.
>> > But before that, please merge them into U-Boot, otherwise the building
>> > will be broken when MBEDTLS_LIB_X509 is enabled.
>> >
>> > See below PR link for the reference:
>> > https://github.com/Mbed-TLS/mbedtls/pull/9001
>> >
>> > Miscellaneous:
>> > --------------
>> >
>> > Optimized MbedTLS library size by tailoring the config file
>> > and disabling all unnecessary features for EFI loader.
>> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
>> > sha512) are completely replaced when MbedTLS is enabled.
>> > From v3, the size-growth is slightly reduced by refactoring Hash functions.
>> >
>> > Target(QEMU arm64) size-growth when enabling MbedTLS:
>> > v1: 6.03%
>> > v2: 4.66%
>> > v3 & v4: 4.55%
>> >
>> > Please see the latest output of bloat-o-meter for the reference of the
>> > size-growth on QEMU arm64 target [1].
>> >
>> > Tests done:
>> > -----------
>> >
>> > EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
>> > verifying and booting) via U-Boot console.
>> > EFI Secure Boot and Capsule sandbox test passed.
>> >
>> > Known issues:
>> > -------------
>> >
>> > None.
>> >
>> > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU arm64)
>> > ```
>> > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
>>
>> bloat-o-meter is a bit off then, since buildman shows:
>> u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
>>
>> (Please use buildman for the size comparisons in the future).
>>
> The reason that buildman is showing more growth is because I enable
> "CONFIG_EFI_SECURE_BOOT=y" in my patch, which is off by default
> for qemu_arm64.
> Since the buildman is always comparing one local branch with the
> 'upstream' (I didn't find a way to let it compare two local branches or maybe
> I am wrong), I guess I have to first merge one commit with just enabling
> CONFIG_EFI_SECURE_BOOT to solve this. But I get this makes less
> value...

Yes, that's one way to do it. It cannot compare two branches. It only
compares one commit with the next.

>
> I think it is better to use sandbox for comparison from v5,
> and I will add one more platform (e.g. imx8mp) for reference.

Regards,
Simon
