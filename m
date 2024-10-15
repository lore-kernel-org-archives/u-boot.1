Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D138CFC268
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 05:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217B68909E;
	Tue, 15 Oct 2024 07:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d4x4wFwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EC688DA0; Tue, 15 Oct 2024 07:23:18 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65FE8927E
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e28b75dbd6so3498832a91.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728969794; x=1729574594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iIVSfpl85z7agIvDe01hZAJ0IrlxYnBiJXK5w7B7yMY=;
 b=d4x4wFwccVvtNOyoEm0cLRjSYwShVYvIEeZ8lYPxgZvhw2oCoKL/V9+Uu5G8SnZov7
 nHvQ4jwdHWhk1gaVVyyKlvGIZnwhMUsmKrf0it8aKaTh7aRKzeolvn4pTLxj4h8N815Z
 DITKF7t8zRt3zTqNqtgw4oYndqB+h9hhBHB7dSHQ4Q5v5UMaYfryFavDYxhcHV0lUihT
 4wRn8jnqNrjqyVIs3E1x6/ziyVqwD746kNm3HwC4DykczR3MwZecSRamX+SZCAI28Mt/
 CC/tvP8hiFeHGowHsmpIERn4QTT6As5dkeKkHaNbmPuYFO6fq/icXk5ESbEo7CkT4Ss+
 R2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728969794; x=1729574594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIVSfpl85z7agIvDe01hZAJ0IrlxYnBiJXK5w7B7yMY=;
 b=glXmkgabjGj2h5urO6KgmphVqWPGP1l+4PIbomQQgwncZ43gjkcbDbfo9Aqx0ohBj1
 9IUeBqki2L6UDJKbu/y7E1vR7WEKLwfiulLtDMSGVnejSycBlz/UgnHXyWEiPPULZJJl
 TxjXhpTWIaX2MSkcfM30VPRqBTWQw2IftsEaII+vSAPAd6GCans72iPqUR+VykbDP9Zn
 yclYPjamHmVFiTzdC+SxPD4+QB9EYqZNkOobC0nlZYWOFXrWQI28waFn20C5PvXJnXIU
 UbQDcWyQvdDMb6U1lUznc9W3k11QDWzr+YrMdHYNczA9JnKJkQAaSTg4bJFjk/dlWgxT
 RQ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsTBIjSARuxpkBsR5cb02vSgIvBCUuZ7mNT+8DzhaJbXzsNJM2KLie4lgYjxsR2gq3uupUrXw=@lists.denx.de
X-Gm-Message-State: AOJu0YypEuTyzLq+V5RGO+Srn8MUPNKoOvyi3kiACVs7AqKrhqYAWRWv
 Q0SX9r0jaGFfioyRwhsQ2b0POd65V6HKvMky1n7J1kjT3taOR7nw2NZrSNa1FZL5VH0PrQt1ZR4
 0N7BakNouyVugr7Iu1+ZCUY83aZ+nkz/z8QGMFr4Faz8FjOOvCYw=
X-Google-Smtp-Source: AGHT+IEuF+zPAxIqbUufCvf/LP0YOqod17aBq7Qv4RCzbx/0GlGlA4ch2EYqM4GSGR/n2FuYhzZr0x5AV5gidxODksA=
X-Received: by 2002:a17:90b:1088:b0:2e2:da8d:2098 with SMTP id
 98e67ed59e1d1-2e3152b00f4mr12569625a91.2.1728969793809; Mon, 14 Oct 2024
 22:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241015043008.GJ53053@bill-the-cat>
In-Reply-To: <20241015043008.GJ53053@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 08:22:37 +0300
Message-ID: <CAC_iWjJeG76xHOZ526OqCEN_e0cP2Ovzes0pW+rSPPNvc75=tg@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
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
X-Mailman-Approved-At: Tue, 15 Oct 2024 07:43:12 +0200
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

On Tue, 15 Oct 2024 at 07:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 03, 2024 at 02:50:13PM -0700, Raymond Mao wrote:
>
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
>
> For the whole series, applied to u-boot/master. Thanks again for all the
> hard work here.

Likewise, thanks for the patience and testing!
Regards
/Ilias
>
> --
> Tom
