Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E204CD343E
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 14:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B31D88B59;
	Tue,  3 Sep 2024 16:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tPR7Bl1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC6A88BC4; Tue,  3 Sep 2024 16:59:54 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC4F889BD
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 16:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d8f06c2459so1211202a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375590; x=1725980390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcAftqpWmltfOeaMshBL6tHIKZg94J3f5NP/noldInQ=;
 b=tPR7Bl1OWumj0PFQv9QrSLVOAVj8YYs/M3hMhkKZka9mca8CWnu5ZytyMjFwz3gKHS
 AMDH4WYCji6DILzqf/vJOs7kNc/cQGrLPX6zMfBrvv/bQnQ2+HzO2cob3hsNl+B5a9XS
 hJ4TdVcdoVMeHqvpFfeevumJaJisouIYfpa6mIYmnNCLrsas3fH+W4uTatGQMFpts3nq
 bFwUs5bTy7fpQdok062kSqEl8YfS2QFCT+RCMLphl2VUzaCXGWykTm4S7z9yIInWuemI
 KLnzwtFcDXNm4n1QWoIVfix7pAyua1Rxm7uqYhbkO4+EP8Duq2OeufzW/8AN1PA23pRj
 ctlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375590; x=1725980390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcAftqpWmltfOeaMshBL6tHIKZg94J3f5NP/noldInQ=;
 b=GY6PgUZIrdpOpAiRQQCs7YutPgCvgzCQKNbVsO1dPKdyehnczhoPb8Vfy+wm5CLv3h
 sF3D2WUjlSD2QvI94ZYCy7xSpJ29nHZMxsYQaLG0XFk2q4euRvgDd+quUTtQ1fW1Aac4
 7blEJvSE/vxc7GPDZu6t1K9AAjKE0yYVy8aICSToJEjiEA82rQCjD3/UlzKTgBcJHVPU
 llaa+aDWX89T+1u7Dw1Sv3IPcgZFMn7bgS2Oz9iBrXFAWVqYM3C7CN0JE+4eYL65LMF9
 rwONtWqJr3dGuKvNdqBive/rweTKEDT47ZWAb9MvpzkAi3n2CRfyfDR3EfEgVmTBRG+y
 /o1Q==
X-Gm-Message-State: AOJu0YzBwoGdhuIOk2b9JG3IXhC4YgAONd8G30b9aVAMyy2tpm0PrHbz
 tYBcAGFfdD2DGuuKwXeAKit1yeApwSVqB+s4/PLAol2UnL9gjJ+pG7xx3oRkjio0NTcQfZqHORk
 8Sdu9mXCZ0FTVgs7YLJ4+KId7KRNXsrkPeXVVEQ==
X-Google-Smtp-Source: AGHT+IFoUy2jiYKL4RcGSsZfBToJGDEpjpD81xiCK6rsJ39Gb0fKAHseItNNbtbfp4l52vXdlury8OM+uE247K4G6aA=
X-Received: by 2002:a17:90a:e2c3:b0:2d8:9a0c:36c0 with SMTP id
 98e67ed59e1d1-2da55924370mr3374402a91.8.1725375589518; Tue, 03 Sep 2024
 07:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
In-Reply-To: <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 10:59:37 -0400
Message-ID: <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
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

Hi Simon,

On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, 16 Aug 2024 at 15:44, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> with
> > MbedTLS.
> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> > and Pubkey parser with MbedTLS.
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
> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> certificates.
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
> > From v3, the size-growth is slightly reduced by refactoring Hash
> functions.
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
> > EFI Secure Boot test (EFI variables loading and verifying, EFI signed
> image
> > verifying and booting) via U-Boot console.
> > EFI Secure Boot and Capsule sandbox test passed.
> >
> > Known issues:
> > -------------
> >
> > None.
>
> I wonder if we could leave out the SHA stuff? The algorithms are
> stable and this would seem to avoid much of the size growth, and all
> the pain of trying to integrate another yet another hashing layer (we
> already have normal, progressive and h/w acceleration, plus
> UCLASS_HASH which h/w acceleration should use but that migration never
> happened). I struggle to see any benefit in replacing U-Boot's very
> solid hashing infra with something else, particularly as this series
> adds yet another. Better to invest the time to refactor it. I asked
> about this before and was told that it would happen 'later'. Let's
> just not change it at all, then it is more likely someone will sort it
> out.
>
> Unfortunately, MbedTLS depends on its own digest layer. Unless we patch
MbedTLS
to allow an external digest library from U-Boot ...


> Also, if MbedTLS is wanting to be a general library for TLS (I assume
> transport-local security, not thread-local storage) perhaps it might
> consider changing to non-Windows newlines, or perhaps even kernel code
> style?
>
> We can feedback this to the MbedTLS project when the first series are
accepted.

Regards,
Raymond
