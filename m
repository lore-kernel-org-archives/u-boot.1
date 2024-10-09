Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC49CEDD89
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A76E8920D;
	Wed,  9 Oct 2024 15:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DOJG/n7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AE3891A7; Wed,  9 Oct 2024 11:50:33 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CC488FD2
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20bc506347dso52721655ad.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728467429; x=1729072229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlZ9FoC2oHMC8TJVigBdcH3aSndlHNbWWUSCurgqCGY=;
 b=DOJG/n7HKG+CaULX5CbelIfCM+3mMU7muobtFtZuiAAUPjrONftvahqs/xP5x6M4B/
 dtkUakAvNQRGRyKY2MIxOCkJ75wMHQgarTIOeQpHZ1JkfLEgkR9Bul/SpDg5rZn324TF
 ugA/kPAcP97gjNiRBG6QqITIiJE4ToHxlDAYO3+EkRgoCUoTSQ7+KzBMHpLH8LjkrRhu
 uzS0P0+SAdFLRxZDSiRxQUULoIGzwZQziqsc5arbSQeS2SKUHa4yBZYiZAknRmDki+t+
 Ds7OQ2eL4RLIkdvhmzAzN3Wlr7pa5gC2I0IVHSKk570A19sW87mdB7LARldNlfHSIIcr
 A9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467429; x=1729072229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlZ9FoC2oHMC8TJVigBdcH3aSndlHNbWWUSCurgqCGY=;
 b=lrXFRvYAGtXvYtFChMXASNHgbvtfh8lvZrXyRx/Kw1JTqrfUMkrVu6u3yjvZFpA8ad
 Q39tUfWj4iAagR1C2Ev1bYk5sVPHBEQ3Fchka8hTPPHmsqKIG86S8SSSxYMY3DudHVby
 xc7Qlx32EtsactzvNEacETqfHm+KD4k7dRvOkikB42zH6ASbw4/V05wcHWz2AZpxmC0+
 rtFzm2Y6zCG6/+MJAr5G7zknCUKIPtIik5wIyMoOeAAcKyfTCyDM1Qu31hyWvYy9hSQq
 +Xk52CgXKGneo94SksWHIhPMQv/9mEK2r/035ZsqIcgNBRX8PmNWxDtPbdyGMFB69m1T
 MkZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDfeUi/9/dCPd+by/ED6kFPACDF3hQVpRgze+etyASFaEihLy/kccdPxBmUjFutpp6KptLiY=@lists.denx.de
X-Gm-Message-State: AOJu0YwuY9lgNePXBCV8jl3lw+EUJt4pz80En6RJZ8+qzyWhRPmxTjHU
 IdEaLGC0fZn6zP2fDPZNvzjpUPzrBVqGI8ErqlF3YuvSR6geY5mk6XmL58JGLcN3d2kTc2Fmq2T
 90XL3yVf0QS+65a/bTdLHhw0Nnnn34Jzagjs9rQ==
X-Google-Smtp-Source: AGHT+IFnD1q7G82GDtsVKLsDo6xFsjU1fPExv580xINPoB2ll7UidYUpUhvPef127PcOyVCMLTxcZzpQpJckVSevfQI=
X-Received: by 2002:a17:903:7cc:b0:20c:5d5a:af5c with SMTP id
 d9443c01a7336-20c636eb65cmr24185515ad.4.1728467428990; Wed, 09 Oct 2024
 02:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <CAFLszTiDw-a=yYv_ueXRpfqHd2ngsQCPSWgeamxbMyCpPEKcZQ@mail.gmail.com>
In-Reply-To: <CAFLszTiDw-a=yYv_ueXRpfqHd2ngsQCPSWgeamxbMyCpPEKcZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 12:49:52 +0300
Message-ID: <CAC_iWj+OFJOhQxnfFf4hP469e9rJdrVAb8+H_vpguAiuf2D-sQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Ian Roberts <ian.roberts@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

Hi Simon,

On Wed, 9 Oct 2024 at 04:52, Simon Glass <sjg@chromium.org> wrote:
>
> On Thu, 3 Oct 2024 at 15:51, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> >
> > Motivations:
> > ------------
> >
> > 1. MbedTLS is well maintained with LTS versions.
> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > 3. MbedTLS recently switched license back to GPLv2.
> >
> > Prerequisite:
> > -------------
> >
> > This patch series requires mbedtls git repo to be added as a
> > subtree to the main U-Boot repo via:
> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> >           https://github.com/Mbed-TLS/mbedtls.git \
> >           v3.6.0 --squash
> > Moreover, due to the Windows-style files from mbedtls git repo,
> > we need to convert the CRLF endings to LF and do a commit manually:
> >     $ git add --renormalize .
> >     $ git commit
> >
> > New Kconfig options:
> > --------------------
> >
> > `MBEDTLS_LIB` is for MbedTLS general switch.
> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
> > MbedTLS.
> > `MBEDTLS_LIB_CRYPTO_ALT` is for using original U-Boot crypto libs as
> > MbedTLS crypto alternatives.
> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> > and Pubkey parser with MbedTLS.
> > By default `MBEDTLS_LIB_CRYPTO_ALT` and `MBEDTLS_LIB_X509` are selected
> > when `MBEDTLS_LIB` is enabled.
> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > introduced.
> >
> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> > for testing purpose.
> >
> > Patches for external MbedTLS project:
> > -------------------------------------
> >
> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > executables which is not supported by MbedTLS at the moment,
> > addtional patches for MbedTLS are created to adapt with the EFI loader:
> > 1. Decoding of Microsoft Authentication Code.
> > 2. Decoding of PKCS#9 Authenticate Attributes.
> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
> > 4. MbedTLS native test suites for PKCS#7 signer's info.
> >
> > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > MbedTLS project and being reviewed, eventually they should be part of
> > MbedTLS LTS release.
> > But before that, please merge them into U-Boot, otherwise the building
> > will be broken when MBEDTLS_LIB_X509 is enabled.
> >
> > See below PR link for the reference:
> > https://github.com/Mbed-TLS/mbedtls/pull/9001
> >
> > Miscellaneous:
> > --------------
> >
> > Optimized MbedTLS library size by tailoring the config file
> > and disabling all unnecessary features for EFI loader.
> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
> > sha512) are completely replaced when MbedTLS is enabled.
> > From v3, the size-growth is slightly reduced by refactoring Hash functions.
> > From v6, smaller implementations for SHA256 and SHA512 are enabled and
> > target size reduce significantly.
> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > v1: 6.03%
> > v2: 4.66%
> > v3 - v5: 4.55%
> > v6: 2.90%
> >
> > Please see the latest output from buildman for size-growth on QEMU arm64,
> > Sandbox and Nanopi A64. [1]
> >
> > Tests done:
> > -----------
> >
> > EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
> > verifying and booting) via U-Boot console.
> > EFI Secure Boot and Capsule sandbox test passed.
> >
> > Known issues:
> > -------------
> >
> > None.
> >
> > [1]: buildman output for size comparison (With both `MBEDTLS_LIB` and
> > `MBEDTLS_LIB_CRYPTO` selected)
> > (qemu_arm64, sandbox and nanopi_a64)
> > ```
> >    aarch64: (for 2/2 boards) all -1568.0 bss -8.0 data -64.0 rodata +200.0 text -1696.0
> >             qemu_arm64     : all +4472 bss -16 data -64 rodata +200 text +4352
> >                u-boot: add: 29/-14, grow: 6/-13 bytes: 12812/-8084 (4728)
> >                  function                                   old     new   delta
> >                  mbedtls_internal_sha1_process                -    4540   +4540
>
> I am not going to review this version as others are on top of this. It
> looks reasonable to me. We do need to tidy up the hashing in
> common/hash.c at some point but this series doesn't add to the pain
> there.

I don't have time to review those things in depth. OTOH we have enough
testing on the CI to make sure cryptography is working and I do like
the state of the patches as well.

The current code leave mbedTLS hashing algorithms as a choice, but set
the existing hashing algos as the default, since they are smaller and
work with offloading. Since using new algorithms from mbedTLS might
have valid use cases, I suggest we pull this and clean up the hash
subsystem, to include all 4 options
- mbedTLS in sw
- U-Boot hashes in sw
- Mix of mbedTLS & hardware offloading
- Mix of U-Boot hashing & hardware offloading (already works)


Thanks
/Ilias
>
> I do worry about the size growth, though. Do we want/need the mbed
> algorithms? Why are they so large?
>
> Regards,
> Simon
