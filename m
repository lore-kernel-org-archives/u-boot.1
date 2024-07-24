Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A27C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACE688918;
	Wed, 24 Jul 2024 16:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S0+uTOlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0798892F; Wed, 24 Jul 2024 16:35:07 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFFC8889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a1be7b5d70so753659a12.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721831703; x=1722436503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QPWRXlx4gDWHaPM8M0lUpw4vuT6LN8wDu61HasCXDaU=;
 b=S0+uTOlGX7EW71EC8D1J6P3KCbByQxd32TXLMmjItNOEeFMVNxoXu63ug7ETGdgk0F
 Db2wgDx2mlTlego09ktEZ11fvDXBiEXvEn6ofNK9Q2ckpoNZ2TyyOKghiy2YCvgA6aT5
 ZCRCvkUL9wTMu4yvZDGnL/nAwCh47P96viaEH5tecwpJx0S+R/x088/7+/vrXlyd+2CF
 WDKUXZqJjEfKoe7DAIsjZGsZaGCihddEb+wjFx/eSBzW+EwQO4H5oOzPT5YJmNtkVxOv
 gZqYZjbZEl+v9qKqZJZnlyuNNyJBpHGgGAiQLb6rQe7Hh3mGQjaRoKLg7OqxHU8Ub8IK
 1Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831703; x=1722436503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPWRXlx4gDWHaPM8M0lUpw4vuT6LN8wDu61HasCXDaU=;
 b=XxxooxwAUxEdTu9OiPGYdK+qClvww30uzsUadoP0hWnt6TOmcuN8sTkNSggwHmwR+x
 HMFy+PsgiwQiELlUYFadq2rT8WYC96xPJ2I7iyzZX8HkM12pnkIEQH2RCt/SYSpV7nPz
 YqWmmKqvWLSta3D+2KhscmOzBcgRYy8muHWMfQeZvmTkfj+6U0+af0pOrNTmFcw0igsH
 6Wi9m7UG/iqwZ0I/nJRDAgZnpZFcqP7lH0LUIM94Zo4F85JlMm2Z8Q2MOmxhYINBqYEE
 Hof9EkLLwY+H7JmbX/yxtpXMEsAt42eFdUzVQskx96SxOiTfKDOFt7jQ5iuURCQhPt2J
 cblw==
X-Gm-Message-State: AOJu0Yx4ihRsI9ZYzero5XYDaPrSLMu65v7XD4vuwfRWyKr5yNjoNABV
 fNKznacKUP5RMm38EDnBNnpK7dqFjvHhzBRjChF2hd98Yf8oVHTesyhtsC7Yc7C/NPff+aZcbnj
 3WgH3h6/Fn5LFVrfY/d9gzq57ep2nA1seUOF49Q==
X-Google-Smtp-Source: AGHT+IEeOZeLaIJISoJ7glRyyDUz62xLPrz5bZuEFax2FgBID2tY0RIcUNCoKO2Diy/xMDSm8CpQi9bygKZDVK/yhUs=
X-Received: by 2002:a17:90b:17cd:b0:2cb:5bc9:e3e1 with SMTP id
 98e67ed59e1d1-2cdb93878e5mr3523546a91.2.1721831703089; Wed, 24 Jul 2024
 07:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240703012555.GX38804@bill-the-cat>
In-Reply-To: <20240703012555.GX38804@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 24 Jul 2024 10:34:50 -0400
Message-ID: <CAEfUkU+EKc_B3pGTWXisKbn3ZcQcvGaUhnMZ193L9ajm0pJ1xA@mail.gmail.com>
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
> The reason that buildman is showing more growth is because I enable
"CONFIG_EFI_SECURE_BOOT=y" in my patch, which is off by default
for qemu_arm64.
Since the buildman is always comparing one local branch with the
'upstream' (I didn't find a way to let it compare two local branches or
maybe
I am wrong), I guess I have to first merge one commit with just enabling
CONFIG_EFI_SECURE_BOOT to solve this. But I get this makes less
value...

I think it is better to use sandbox for comparison from v5,
and I will add one more platform (e.g. imx8mp) for reference.

Regards,
Raymond
