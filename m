Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FDCE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 00:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD538862E;
	Fri,  6 Sep 2024 02:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGJtVV2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77498862E; Fri,  6 Sep 2024 02:43:58 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5557888CC6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 02:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4567587224eso9012591cf.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725583435; x=1726188235; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYZIOSKcw9EapAAwOkNarxFvPoBZTVpKyrvJm2AnZms=;
 b=hGJtVV2W5grsl1E33umBOsCMjpsqPIH4oqEgvXAZM2kSRfABeiIBlv33WEGV4jXdoX
 q3kwkxjxsOcewNxz4dOjTcnjQaAJbKNykXHoQX1aWHnnjep9yUN+GIjMmxLntcd/VfRq
 ECSysavuFkFqed4TlnO/ul7mlOcsuB0SXP65o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725583435; x=1726188235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYZIOSKcw9EapAAwOkNarxFvPoBZTVpKyrvJm2AnZms=;
 b=PQjLV1RtEYsAOu5buGUhx4oKHNbtWjug4XXfJsgjmNr0/p8qL+6+HjK3YRuQHUaA3G
 AxXepBn5sUiS94OipojUgUPtv1SAjU6n07Pri17UFuiOGscNWsx2j2VDqEj7UU0EjIk6
 wi4V8zATvwh33+BB+ETK8RN4Koa547/Af1kex33CS9E83ifVwvtfpkMTt0vYw3upL/Qe
 c+dZBe/+lSv1PAlhUYzGeVjMzMFoSOT1TD2lcyKMfQ3NjNt2CsfpQjsphdrzjezhZXWN
 Ft/LgSVM54v7KMAyj4mAp638imZXyfyC/xwQLHCTD0XGWBLR7DGy2yoKrwC9eczUspPZ
 pfUw==
X-Gm-Message-State: AOJu0Yw4IqYzyc9mc3P5XvEb1foEm9KqmpJKWY1O3hiu3VTFgCzjRXBw
 HNWWg+WytZtDukmtAxMDoedpkLz8ULrnIzDD+B8fLDqsNqTd3MreEy3Daj1b3mUSucpCOS7oziC
 Yg7J0CdG7Eci4j/8PVIvdrnzelhswnFtIAeKB
X-Google-Smtp-Source: AGHT+IH7wwIGGAJegSzuqyHoZUGlzZUFaeKZYxq8CNBOi4oGpRsiV3NRzc6IaxvRdIGNUeD70P/mcjQUmzIO9bI2pXo=
X-Received: by 2002:a05:6214:3b8a:b0:6c3:8360:583c with SMTP id
 6a1803df08f44-6c383605a57mr126828526d6.23.1725583435092; Thu, 05 Sep 2024
 17:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
In-Reply-To: <CAEfUkU++=WbmePTa_JwPkn6VoG0C+Y=U7SebXmNhcLyPTbKrZQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Sep 2024 18:43:44 -0600
Message-ID: <CAFLszTh56FrvLaHvat6Oz97EVzw9xYmQr+WyDNtYE=c2qmyJ5w@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Raymond Mao <raymond.mao@linaro.org>
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

On Tue, 3 Sept 2024 at 08:59, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat, 17 Aug 2024 at 11:58, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Fri, 16 Aug 2024 at 15:44, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
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
>> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
>> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
>> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
>> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
>> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
>> > introduced.
>> >
>> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
>> > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
>> > for testing purpose.
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
>> > From v6, smaller implementations for SHA256 and SHA512 are enabled and
>> > target size reduce significantly.
>> > Target(QEMU arm64) size-growth when enabling MbedTLS:
>> > v1: 6.03%
>> > v2: 4.66%
>> > v3 - v5: 4.55%
>> > v6: 2.90%
>> >
>> > Please see the latest output from buildman for size-growth on QEMU arm64,
>> > Sandbox and Nanopi A64. [1]
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
>>
>> I wonder if we could leave out the SHA stuff? The algorithms are
>> stable and this would seem to avoid much of the size growth, and all
>> the pain of trying to integrate another yet another hashing layer (we
>> already have normal, progressive and h/w acceleration, plus
>> UCLASS_HASH which h/w acceleration should use but that migration never
>> happened). I struggle to see any benefit in replacing U-Boot's very
>> solid hashing infra with something else, particularly as this series
>> adds yet another. Better to invest the time to refactor it. I asked
>> about this before and was told that it would happen 'later'. Let's
>> just not change it at all, then it is more likely someone will sort it
>> out.
>>
> Unfortunately, MbedTLS depends on its own digest layer. Unless we patch MbedTLS
> to allow an external digest library from U-Boot ...

Yes that sounds best. It looks like only a few call sites, so it
should be a matter of leaving out the MbedTLS code and adding some
static inlines.

>
>>
>> Also, if MbedTLS is wanting to be a general library for TLS (I assume
>> transport-local security, not thread-local storage) perhaps it might
>> consider changing to non-Windows newlines, or perhaps even kernel code
>> style?
>>
> We can feedback this to the MbedTLS project when the first series are accepted.

OK.

Regards,
Simon
