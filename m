Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 19:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE2488100;
	Tue, 23 Jul 2024 21:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ygIHqgjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375D288100; Tue, 23 Jul 2024 21:24:54 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192DF86E35
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 21:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso125859b3a.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721762681; x=1722367481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d2nqJzCX5bf6HaybdJtYQE06SEf5XGEp4lRgwS1jhlk=;
 b=ygIHqgjUOO8aBapnGkz4MigiPjhSM/2hyT/E+SdGrxQk02gus1AkvOAtkhGp+WpluQ
 jQf/wZmxQ6qEc3YKe/XmXFN+7nBE0bhNBaakGY1jJFqrH7JKs6EphtLpW88xK92dlxqv
 5KO0LlqVrdN2TlZv8PIXawfC96BmVNpidP/Y47X3P1wS5WFtXVhvmZJwTDWGKqH1Gjf6
 jpkzmwnliaSB6VmFY4kydhI22wZngv3xSO+Icy+h1J05iR5vLvOL1F99vlqtyAODgrrl
 NzFH6HJctsIpCJFxBlboekclxYnqYrPfJTgLSnJROFqwrkdg5XG5hasoo4BzHwsAZ1nr
 1ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721762681; x=1722367481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2nqJzCX5bf6HaybdJtYQE06SEf5XGEp4lRgwS1jhlk=;
 b=kk/j59e1zpO4CPZsD84EIhVj74+z2Ec6Mr9jgicsK0Bni6KBI70fkt0Y8WnPgknPBI
 9NpL4PkSHGDvmw63tVv161V/jusZ3ywqHo+SN8j+ZQ3DSTMmyKBPYoXC1hDLeeQWxhmx
 s9ooZQA4In951W0R19VjL31nFnekeB45BINOwQdNNgXJ2F1P8UxqEHcyRshlXGXk5q34
 qe0ifXRBV/5DODMDvDo7pjbxfjq3Lgwo6CSUF2kPn9OMFPYSy/qvQgdwWG/DfQHbbN3W
 /88ahP2Gm37ujOLv6fTCNmVdltGcLu7v1lCo9sdVJ74sJmlDamKS1pdQ9TuCqIYboxOr
 m1KQ==
X-Gm-Message-State: AOJu0YzlbY3iucfZbGOZJ0OhQ4PZqo4tq6vqw7G3D5jaBca2I8zk1t38
 baoziGERpgPxP1HdlNgeqkpKwkItsUiyq6EbI7CZuagfVloaVhjUfrbOqk+/xoHtYwMF+xq7bxo
 EVMsy3UHuslHS9A+jC1vSMmumWNgOmNnY/xni6w==
X-Google-Smtp-Source: AGHT+IFWACeKB2ekl99WopUCCWn1mzWMm4oXUwVdMKUzBGob1oFzA0YOH/ylG+nvCWNsVpIwT0kHuZV40xS+AoLeDdI=
X-Received: by 2002:a17:90a:5294:b0:2c8:f3b5:7dd1 with SMTP id
 98e67ed59e1d1-2cd8d1095abmr5063460a91.16.1721762681369; Tue, 23 Jul 2024
 12:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
In-Reply-To: <20240703012555.GX38804@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 23 Jul 2024 15:24:29 -0400
Message-ID: <CAEfUkUKhso=O4oFDoJsEd=m+o-avKYvTHMDUHGQsLFQs7vpy-w@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
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

On Tue, 2 Jul 2024 at 21:26, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:
>
> > Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
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
> > `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTLS is
> > ready).
> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> > introduced.
> >
> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> > are by default enabled in qemu_arm64_defconfig for testing purpose.
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
> >
> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > v1: 6.03%
> > v2: 4.66%
> > v3 & v4: 4.55%
> >
> > Please see the latest output of bloat-o-meter for the reference of the
> > size-growth on QEMU arm64 target [1].
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
> >
> > [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU arm64)
> > ```
> > add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)
>
> bloat-o-meter is a bit off then, since buildman shows:
> u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)
>
> (Please use buildman for the size comparisons in the future).
>

I have a problem with buildman.
As I followed the buildman/README.rst and run below command, but cannot get
any
output size summary. Is anything missing? I saw some artifacts of building
each
commit being generated in the upper dir though.
```
./tools/buildman/buildman -b <my_branch_name> --boards qemu_arm64 -sSdB
```
I have set my branch upstream to upstream/next.

Regards,
Raymond
