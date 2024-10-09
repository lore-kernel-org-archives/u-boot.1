Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D33CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D278902E;
	Thu, 10 Oct 2024 07:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tB17c/Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9153288CC9; Wed,  9 Oct 2024 17:08:49 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A505288C4A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 17:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71df04d3cd1so4245388b3a.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486524; x=1729091324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KkZbT8qEeF38Ru5DqnWFClejVoQcv7bznD/HMmA7ar0=;
 b=tB17c/BzfFI0DkKBkKPOw/JbEKrcEJm4KokitoRpNJ2EFuaGHVtlD7YL3FBhGb5Hj0
 8xHkGBdMHXLaB82/PYA72i9hTWK2vGA4/Ny4XafV3ClT5xZO8vW95Y5WD6KHZU8wt96h
 CStvF50eqQWcaM/hAaF3wgt/VIzQvc7aaEMOnS4FFuiXMen7wNAYHRhcHKM9X6+dJVY7
 ohazMie+dM06Q3ONu/731vc9ng/Fnd2KW8VMrhFghGlbcT8BnKBMzoyFwwQAWKhR9LJJ
 AyGXHwntlirBqPzDjFLER6O67YoNqCrmQSrcW1tGBBQaQsgL0j+BXkK51X2Tc6pc3iNm
 Q3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486524; x=1729091324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KkZbT8qEeF38Ru5DqnWFClejVoQcv7bznD/HMmA7ar0=;
 b=bQ4YkzKrw/0doMk4vp4EqDu4naURCnb2B62QddaYbme03v8yeyIe4EpHKq3B+E3xmk
 YzeCQtrxD8Z9Q419l3XKEn7MHJ4nNDfUUtC4WGoYwWlmZJ9NCeDAgyU/JKS62gcc3eWr
 3ztpzVicIyd4qj7Ac9wtL7iygC5ZOJ1w8D2pQN3R468w2oFZ43gzTge0nVT+OcmlxnGX
 pDub7M23aqgeBKzA4jusVaFgFrMAeb4eZLoS/f8ivmYfmPhpaATbFDuaFLAPqgzHqAto
 86SPTik4mvTjBTAcGcfjt1xe9NACtBR9/DGpSiTezC7fOueKZJ7rDbUxj6uZmiuVVNBk
 qnIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUDak/XPtPc8nJKhxjQkZvBq6SJN0VSqeLQ3zhBU2mBLXFMKMlLGBFnR5FvD82Q1KDzjD7foc=@lists.denx.de
X-Gm-Message-State: AOJu0YwSccZGH9PY/MlbSfQBZPdzO/qwfUxQVhaTWpT2waNykYUzOJQw
 rdqJCES6mZfrdti23hnVdfTYdjirWSkGcoQIZA1Cn/y5BT9z2GEGNkYx61Ru3hXvFYiXHbsAB5t
 e4CJXTI7PTZf0ZMd6Ye/ainIACrsfFu3ASk362w==
X-Google-Smtp-Source: AGHT+IEze2ooPGZ6/ALL18WTxBNokzV211Gt7PzNYFwHMO0mk+RDWjHrB7+JvfzKrs/TTfWGn+TAMLKZVFx/09ormS0=
X-Received: by 2002:a05:6a00:3d55:b0:71d:fb29:9f07 with SMTP id
 d2e1a72fcca58-71e1db8ee24mr4360247b3a.15.1728486523875; Wed, 09 Oct 2024
 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <CAFLszTiDw-a=yYv_ueXRpfqHd2ngsQCPSWgeamxbMyCpPEKcZQ@mail.gmail.com>
 <CAC_iWj+OFJOhQxnfFf4hP469e9rJdrVAb8+H_vpguAiuf2D-sQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+OFJOhQxnfFf4hP469e9rJdrVAb8+H_vpguAiuf2D-sQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 9 Oct 2024 11:08:31 -0400
Message-ID: <CAEfUkU+C3yANU7BAeRb5u8bnUczgEk+HLhnZc31dgWf-F6u0sQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
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
X-Mailman-Approved-At: Thu, 10 Oct 2024 07:23:03 +0200
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

On Wed, 9 Oct 2024 at 05:50, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Simon,
>
> On Wed, 9 Oct 2024 at 04:52, Simon Glass <sjg@chromium.org> wrote:
> >
> > On Thu, 3 Oct 2024 at 15:51, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> > >
> > > Motivations:
> > > ------------
> > >
> > > 1. MbedTLS is well maintained with LTS versions.
> > > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > 3. MbedTLS recently switched license back to GPLv2.
> > >
> > > Prerequisite:
> > > -------------
> > >
> > > This patch series requires mbedtls git repo to be added as a
> > > subtree to the main U-Boot repo via:
> > >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > >           https://github.com/Mbed-TLS/mbedtls.git \
> > >           v3.6.0 --squash
> > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > we need to convert the CRLF endings to LF and do a commit manually:
> > >     $ git add --renormalize .
> > >     $ git commit
> > >
> > > New Kconfig options:
> > > --------------------
> > >
> > > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> with
> > > MbedTLS.
> > > `MBEDTLS_LIB_CRYPTO_ALT` is for using original U-Boot crypto libs as
> > > MbedTLS crypto alternatives.
> > > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> > > and Pubkey parser with MbedTLS.
> > > By default `MBEDTLS_LIB_CRYPTO_ALT` and `MBEDTLS_LIB_X509` are selected
> > > when `MBEDTLS_LIB` is enabled.
> > > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> library.
> > > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> > > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > > introduced.
> > >
> > > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> > > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> > > for testing purpose.
> > >
> > > Patches for external MbedTLS project:
> > > -------------------------------------
> > >
> > > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > > executables which is not supported by MbedTLS at the moment,
> > > addtional patches for MbedTLS are created to adapt with the EFI loader:
> > > 1. Decoding of Microsoft Authentication Code.
> > > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> certificates.
> > > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > >
> > > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > > MbedTLS project and being reviewed, eventually they should be part of
> > > MbedTLS LTS release.
> > > But before that, please merge them into U-Boot, otherwise the building
> > > will be broken when MBEDTLS_LIB_X509 is enabled.
> > >
> > > See below PR link for the reference:
> > > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > >
> > > Miscellaneous:
> > > --------------
> > >
> > > Optimized MbedTLS library size by tailoring the config file
> > > and disabling all unnecessary features for EFI loader.
> > > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> sha256,
> > > sha512) are completely replaced when MbedTLS is enabled.
> > > From v3, the size-growth is slightly reduced by refactoring Hash
> functions.
> > > From v6, smaller implementations for SHA256 and SHA512 are enabled and
> > > target size reduce significantly.
> > > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > v1: 6.03%
> > > v2: 4.66%
> > > v3 - v5: 4.55%
> > > v6: 2.90%
> > >
> > > Please see the latest output from buildman for size-growth on QEMU
> arm64,
> > > Sandbox and Nanopi A64. [1]
> > >
> > > Tests done:
> > > -----------
> > >
> > > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> image
> > > verifying and booting) via U-Boot console.
> > > EFI Secure Boot and Capsule sandbox test passed.
> > >
> > > Known issues:
> > > -------------
> > >
> > > None.
> > >
> > > [1]: buildman output for size comparison (With both `MBEDTLS_LIB` and
> > > `MBEDTLS_LIB_CRYPTO` selected)
> > > (qemu_arm64, sandbox and nanopi_a64)
> > > ```
> > >    aarch64: (for 2/2 boards) all -1568.0 bss -8.0 data -64.0 rodata
> +200.0 text -1696.0
> > >             qemu_arm64     : all +4472 bss -16 data -64 rodata +200
> text +4352
> > >                u-boot: add: 29/-14, grow: 6/-13 bytes: 12812/-8084
> (4728)
> > >                  function                                   old
>  new   delta
> > >                  mbedtls_internal_sha1_process                -
> 4540   +4540
> >
> > I am not going to review this version as others are on top of this. It
> > looks reasonable to me. We do need to tidy up the hashing in
> > common/hash.c at some point but this series doesn't add to the pain
> > there.
>
> I don't have time to review those things in depth. OTOH we have enough
> testing on the CI to make sure cryptography is working and I do like
> the state of the patches as well.
>
> The current code leave mbedTLS hashing algorithms as a choice, but set
> the existing hashing algos as the default, since they are smaller and
> work with offloading. Since using new algorithms from mbedTLS might
> have valid use cases, I suggest we pull this and clean up the hash
> subsystem, to include all 4 options
> - mbedTLS in sw
> - U-Boot hashes in sw
> - Mix of mbedTLS & hardware offloading
> - Mix of U-Boot hashing & hardware offloading (already works)
>
>
The patch set has these already with combinations of kconfigs:
- mbedTLS in sw (set CONFIG_MBEDTLS_LIB=y && MBEDTLS_LIB_CRYPTO=y,
  tested via github CI)
- U-Boot hashes in sw (default when setting CONFIG_MBEDTLS_LIB=y only,
  tested via github CI)
- Mix of mbedTLS & hardware offloading (I didn't test this but it should
work as
  it was when SHA_HW_ACCEL=y)

Regards,
Raymond
