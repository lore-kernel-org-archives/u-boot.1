Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F0CF0435
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 03:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF1789043;
	Wed,  9 Oct 2024 05:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M7TVq1Io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8B88906D; Wed,  9 Oct 2024 03:52:53 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065C189099
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df67c67fcso2490078b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438768; x=1729043568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+X8fEo5NCu1VpUfjqmzWNWgtzu/iLbevWYEqQkvmJ+g=;
 b=M7TVq1IoFlEQiwXAnKnlmUSzoAh8xAYXvHoE9RYbSdhTfYE4JEyIPMPvlKco1ey5v/
 Z7r7uH8BeyTbJh8JXqoOQKBVoJJKcr2lQqbsZA57fHpkkjcabnflePBaFO0oKPfjLGqY
 CiTlbUhlHij3HE9hUtY7u7Nc2ohtz0Hbz837M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438768; x=1729043568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+X8fEo5NCu1VpUfjqmzWNWgtzu/iLbevWYEqQkvmJ+g=;
 b=fE0Pj4u61W7GC17aCVeAmwFVkLEIDrMtmk8vDVrMkxNpitD7WGhD6849prHUdBvdzV
 Z9sFf85q2TjdXWEm31DuyrUG3PlzgKtWXJmMCxarcwhOcsrmSQ3RHiWMXjajangY2S81
 UhWqDabXi9R05l+uIajWzQzlBnPOq5cgdnUKLqKtMSzZRiBYI5/OAouYi4CqYRipPZin
 bOl3thimvLQtOClRG3BsH+eV7hpbUgyGc/X2d+029plobpIxHHIRy6O5rGDqh3EDP3hK
 76O37565/r4UilJIDCya3YH0iyldZkEwd/RTjxxBvul9DOvDjrUcVrlfVxS5zANEuWsI
 MXXw==
X-Gm-Message-State: AOJu0Yy/thncFvbXuP3ppAPVPonlMbcAW9ejFOdFlM/92ZajgEc4T4I3
 9gYaba1akJdNZ+bDgx1ogF4reEvjBLhtqezPISA5DvB3Tnzl06oc3zWIeuKzcur9sRrlJstT4eW
 5017m385j05I03lzJWJFlSzH8KMrNjvvIyESl
X-Google-Smtp-Source: AGHT+IFKTnBHjvtylRTPMbH6IzxgYvFUONopcGi6PqFMjpzFWBJzhrbBWR/o9p42azG+DjbfHX/wa585IVOuS08wq+Q=
X-Received: by 2002:a05:6a00:18a8:b0:71e:108e:9c16 with SMTP id
 d2e1a72fcca58-71e1db74db0mr1545614b3a.12.1728438768557; Tue, 08 Oct 2024
 18:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:34 -0600
Message-ID: <CAFLszTiDw-a=yYv_ueXRpfqHd2ngsQCPSWgeamxbMyCpPEKcZQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Linus Walleij <linus.walleij@linaro.org>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 05:28:26 +0200
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

On Thu, 3 Oct 2024 at 15:51, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>
> Motivations:
> ------------
>
> 1. MbedTLS is well maintained with LTS versions.
> 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> 3. MbedTLS recently switched license back to GPLv2.
>
> Prerequisite:
> -------------
>
> This patch series requires mbedtls git repo to be added as a
> subtree to the main U-Boot repo via:
>     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>           https://github.com/Mbed-TLS/mbedtls.git \
>           v3.6.0 --squash
> Moreover, due to the Windows-style files from mbedtls git repo,
> we need to convert the CRLF endings to LF and do a commit manually:
>     $ git add --renormalize .
>     $ git commit
>
> New Kconfig options:
> --------------------
>
> `MBEDTLS_LIB` is for MbedTLS general switch.
> `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
> MbedTLS.
> `MBEDTLS_LIB_CRYPTO_ALT` is for using original U-Boot crypto libs as
> MbedTLS crypto alternatives.
> `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> and Pubkey parser with MbedTLS.
> By default `MBEDTLS_LIB_CRYPTO_ALT` and `MBEDTLS_LIB_X509` are selected
> when `MBEDTLS_LIB` is enabled.
> `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> introduced.
>
> In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> for testing purpose.
>
> Patches for external MbedTLS project:
> -------------------------------------
>
> Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> executables which is not supported by MbedTLS at the moment,
> addtional patches for MbedTLS are created to adapt with the EFI loader:
> 1. Decoding of Microsoft Authentication Code.
> 2. Decoding of PKCS#9 Authenticate Attributes.
> 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
> 4. MbedTLS native test suites for PKCS#7 signer's info.
>
> All above 4 patches (tagged with `mbedtls/external`) are submitted to
> MbedTLS project and being reviewed, eventually they should be part of
> MbedTLS LTS release.
> But before that, please merge them into U-Boot, otherwise the building
> will be broken when MBEDTLS_LIB_X509 is enabled.
>
> See below PR link for the reference:
> https://github.com/Mbed-TLS/mbedtls/pull/9001
>
> Miscellaneous:
> --------------
>
> Optimized MbedTLS library size by tailoring the config file
> and disabling all unnecessary features for EFI loader.
> From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
> sha512) are completely replaced when MbedTLS is enabled.
> From v3, the size-growth is slightly reduced by refactoring Hash functions.
> From v6, smaller implementations for SHA256 and SHA512 are enabled and
> target size reduce significantly.
> Target(QEMU arm64) size-growth when enabling MbedTLS:
> v1: 6.03%
> v2: 4.66%
> v3 - v5: 4.55%
> v6: 2.90%
>
> Please see the latest output from buildman for size-growth on QEMU arm64,
> Sandbox and Nanopi A64. [1]
>
> Tests done:
> -----------
>
> EFI Secure Boot test (EFI variables loading and verifying, EFI signed image
> verifying and booting) via U-Boot console.
> EFI Secure Boot and Capsule sandbox test passed.
>
> Known issues:
> -------------
>
> None.
>
> [1]: buildman output for size comparison (With both `MBEDTLS_LIB` and
> `MBEDTLS_LIB_CRYPTO` selected)
> (qemu_arm64, sandbox and nanopi_a64)
> ```
>    aarch64: (for 2/2 boards) all -1568.0 bss -8.0 data -64.0 rodata +200.0 text -1696.0
>             qemu_arm64     : all +4472 bss -16 data -64 rodata +200 text +4352
>                u-boot: add: 29/-14, grow: 6/-13 bytes: 12812/-8084 (4728)
>                  function                                   old     new   delta
>                  mbedtls_internal_sha1_process                -    4540   +4540

I am not going to review this version as others are on top of this. It
looks reasonable to me. We do need to tidy up the hashing in
common/hash.c at some point but this series doesn't add to the pain
there.

I do worry about the size growth, though. Do we want/need the mbed
algorithms? Why are they so large?

Regards,
Simon
