Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BF5C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A51988918;
	Wed, 24 Jul 2024 16:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BoRNOwA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C770788929; Wed, 24 Jul 2024 16:36:36 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365118889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so38780596d6.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831793; x=1722436593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Wj1bfx7A1wPs7umFPV4+JxI/jfh34vCBxHsxF+kFBM=;
 b=BoRNOwA5z5QRa7+VBD0fqyau0hgQc+yMy43QWHwwYvcqhRHNpWPi3hdb08JUn5FsjK
 dq59VsNwyBbTNpL8Yms8L3eqnAPUJ6JcHEh3s/fMt1g+dZab0llFMR3xCeJyV+ndElJL
 1XX7SMdApE/BMevzq6y6SGkfibWdd929/UwGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831793; x=1722436593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Wj1bfx7A1wPs7umFPV4+JxI/jfh34vCBxHsxF+kFBM=;
 b=k7fhxVKDecp0Wz4kpEmVAr3+o/HTNZ627gDzFCZxnkMdYxG6DeDsdJhGnsxAOWbB9z
 fJuf4jcMl5+m6UC+qteetZSUWkLNFa3GSdnO7ouT6eXnA/7DUDJTohGSrfRbT9rc2r5R
 URUj18EePOo0ZNWKbsFkS3dIOmXrxxOabotJwWfJZzsorR2MWVkKzaOvbXYtzL7ubEmb
 5hdrIFR9Ch73FXZYgkvah2tcd6lW9xDAEPobnJN7qPGKlLGxdu/TELq3cAD8Nu/03WV9
 NpH7Cw/KTlfncYVmiBPB7NyraF2KScPLeFORm+e1awfTgva1OhuyqIy+p/bqZJ63HiYh
 tekw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU67vUK3in3OI5Nv795Z3lT/DBJkCrOgYTMktHqt3ww5KVQ87q6ij08OhEGq3/grB2RDosBlVtAvgqiwHtRpxWlghu3KQ==
X-Gm-Message-State: AOJu0YzBP2xYlI3fwiXqhOLLEL+OYbUXcYPioZiQAuBp8EJ1UFF9rEOU
 CCwVK3g+/a4gepZqBhDYkzMgaHVID0w4Vfp5jqH/IZ7FnDyBJV03YKehp6xFSkOrdCAJ0wdmEPr
 gHBqzzjUZgut+R5pul56apgVKPFKFtVWJQGSx
X-Google-Smtp-Source: AGHT+IFd1F95hV5fEkuvSZ+S8QP9EDWhLmgAcBKnaoRFdK6Gja9pQRK0YfOTe++VWTTeFi29s3sYG2YHVbbbcK97Vng=
X-Received: by 2002:ad4:5c42:0:b0:6b7:a427:d5dd with SMTP id
 6a1803df08f44-6b98edec009mr45007206d6.52.1721831793042; Wed, 24 Jul 2024
 07:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
 <CAEfUkUKhso=O4oFDoJsEd=m+o-avKYvTHMDUHGQsLFQs7vpy-w@mail.gmail.com>
 <20240723204502.GJ989285@bill-the-cat>
In-Reply-To: <20240723204502.GJ989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:36:22 -0600
Message-ID: <CAFLszTgK45ak5bSMbGhXLfZpetGGr8WGCK2jfK-eXvF-bRrPFA@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
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

On Tue, 23 Jul 2024 at 14:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 23, 2024 at 03:24:29PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
> > >
> > > > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
> > > >
> > > > Motivations:
> > > > ------------
> > > >
> > > > 1. MbedTLS is well maintained with LTS versions.
> > > > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > > 3. MbedTLS recently switched license back to GPLv2.
> > > >
> > > > Prerequisite:
> > > > -------------
> > > >
> > > > This patch series requires mbedtls git repo to be added as a
> > > > subtree to the main U-Boot repo via:
> > > >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > > >           https://github.com/Mbed-TLS/mbedtls.git \
> > > >           v3.6.0 --squash
> > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > we need to convert the CRLF endings to LF and do a commit manually:
> > > >     $ git add --renormalize .
> > > >     $ git commit
> > > >
> > > > New Kconfig options:
> > > > --------------------
> > > >
> > > > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> > > with
> > > > MbedTLS.
> > > > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> > > > and Pubkey parser with MbedTLS.
> > > > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTLS is
> > > > ready).
> > > > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> > > > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > > > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> > > > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > > > introduced.
> > > >
> > > > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> > > > are by default enabled in qemu_arm64_defconfig for testing purpose.
> > > >
> > > > Patches for external MbedTLS project:
> > > > -------------------------------------
> > > >
> > > > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> > > > executables which is not supported by MbedTLS at the moment,
> > > > addtional patches for MbedTLS are created to adapt with the EFI loader:
> > > > 1. Decoding of Microsoft Authentication Code.
> > > > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > > certificates.
> > > > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > > >
> > > > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> > > > MbedTLS project and being reviewed, eventually they should be part of
> > > > MbedTLS LTS release.
> > > > But before that, please merge them into U-Boot, otherwise the building
> > > > will be broken when MBEDTLS_LIB_X509 is enabled.
> > > >
> > > > See below PR link for the reference:
> > > > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > > >
> > > > Miscellaneous:
> > > > --------------
> > > >
> > > > Optimized MbedTLS library size by tailoring the config file
> > > > and disabling all unnecessary features for EFI loader.
> > > > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
> > > > sha512) are completely replaced when MbedTLS is enabled.
> > > > From v3, the size-growth is slightly reduced by refactoring Hash
> > > functions.
> > > >
> > > > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > > v1: 6.03%
> > > > v2: 4.66%
> > > > v3 & v4: 4.55%
> > > >
> > > > Please see the latest output of bloat-o-meter for the reference of the
> > > > size-growth on QEMU arm64 target [1].
> > > >
> > > > Tests done:
> > > > -----------
> > > >
> > > > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> > > image
> > > > verifying and booting) via U-Boot console.
> > > > EFI Secure Boot and Capsule sandbox test passed.
> > > >
> > > > Known issues:
> > > > -------------
> > > >
> > > > None.
> > > >
> > > > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU arm64)
> > > > ```
> > > > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
> > >
> > > bloat-o-meter is a bit off then, since buildman shows:
> > > u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
> > >
> > > (Please use buildman for the size comparisons in the future).
> > >
> >
> > I have a problem with buildman.
> > As I followed the buildman/README.rst and run below command, but cannot get
> > any
> > output size summary. Is anything missing? I saw some artifacts of building
> > each
> > commit being generated in the upper dir though.
> > ```
> > ./tools/buildman/buildman -b <my_branch_name> --boards qemu_arm64 -sSdB
> > ```
> > I have set my branch upstream to upstream/next.

Please check here as well:

https://docs.u-boot.org/en/latest/build/buildman.html#theory-of-operation

>
> You have to tell it twice, once to build and a second to summarize
> things. My wrapper looks like:
> #!/bin/bash
>
> # Initial and constant buildman args
> ARGS="-devl -PEWM"
> ALL=0
> KEEP=0
>
> # Find our arguments
> while test $# -ne 0; do
>         if [ "$1" == "--all" ]; then
>                 ALL=1
>                 shift 1
>         elif [ "$1" == "--branch" ]; then
>                 BRANCH=$2
>                 shift 2
>         elif [ "$1" == "--keep" ]; then
>                 KEEP=1
>                 ARGS="$ARGS -k"
>                 shift 1
>         elif [ "$1" == "--board" ]; then
>                 MACHINE="--board $2"
>                 OUTDIR=/tmp/$2
>                 shift 2
>         else
>                 MACHINE=$1
>                 shift 1
>         fi
> done
>
> OUTDIR=${OUTDIR:-/tmp/$MACHINE}
>
> if [ -z "$MACHINE" ]; then
>         echo Usage: $0 MACHINE [--all] [--keep] [--branch BRANCH]
>         exit 1
> fi
>
> # If not all, then only first/last
> if [ $ALL -ne 1 ]; then
>         ARGS="$ARGS --step 0"
> fi
>
> if [ ! -z $BRANCH ]; then
>         ARGS="$ARGS -b $BRANCH"
> else
>         ARGS="$ARGS -b `git rev-parse --abbrev-ref HEAD`"
> fi
>
> mkdir -p ${OUTDIR}
>
> export SOURCE_DATE_EPOCH=`date +%s`
> ./tools/buildman/buildman -o ${OUTDIR} $ARGS -SBC $MACHINE
> ./tools/buildman/buildman -o ${OUTDIR} $ARGS -SsB $MACHINE
>
> [ $KEEP -eq 0 ] && rm -rf ${OUTDIR}

Regards,
Simon
