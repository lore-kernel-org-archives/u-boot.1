Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A96C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 15:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C315E886B5;
	Fri,  2 Aug 2024 17:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O1R+BFxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D49F88BA4; Fri,  2 Aug 2024 17:34:37 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9F088641
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 17:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d2d7e692eso6790440b3a.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722612872; x=1723217672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IdYHjvV7lgDCFxlR5UAni2X4xK7E4HbHP3VDa4Rps2Y=;
 b=O1R+BFxZqyQYp2vN/vyZQbvu4+gKbA2eHqxMxNQeAqRccELshE1QisNXyXuDFtfgVQ
 bBjBlI4UdZCb5vWDYrGSagUFRmwXcff5FIWbPMiI5se0Yi4ddyUlf5NJd7epxFKKRRq2
 eCfi12ZpTNmATTISzpspKK2IMVzRRXetFS1CKLFjvisN4Oob1Y9tNe8oUc8NK9XiCzcQ
 BIbO3gYFBNMQaqYYdQfvqQHI4AKJ0WXUtSUV6CJGMTmFD4Hz15iXdOTlDq1IU+424e1C
 f/pt8MXzMs0vdt16xYavFspAerws5B48aqsf/ebT0a6KmSoj/wf5c+8k9pPXRWEg3Djz
 A0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722612872; x=1723217672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdYHjvV7lgDCFxlR5UAni2X4xK7E4HbHP3VDa4Rps2Y=;
 b=mzJOxwPEA+AAGTreou6pez1qjiiL3xF//Blhzw6UwreO4YrzfRtnlLMtbA1W8BzxWT
 ZZqiPDt5HJykmRtA7ojadZAg4UKA1/kozjLnRhBfWvZJV/AGkfFerF9036PKLAevTpbA
 veaze714ehCgJrkJlclTz6+AdesF1zhn2SFeAixvEg89vfk9z5a8BLI5qnUGL9eY5VoN
 4jlyxBvJRtuzPVuXIjCfjzjOBw+KsyblnNJN7ZEdJ4HBFTFAwVj4j/n4Z27JTgzb8zeS
 s6Uwts94doXgAT70xR5Q5pHejia+r5+J4GiiZAQPTKqA3h3oukAxnWDIkj5FIDRqoU6r
 MvPw==
X-Gm-Message-State: AOJu0YwBminiLc6kj3FT+OMJdkbgRDVLa3Wd4aPiJQkz1qRq7Fq0KaAx
 koNI8b5dR+80dnsj1b0NgYVnNzJ3XC+4ALYq/sFn9TwNJHnco7rXP+wuHRuvU312/GzhdYU+9nm
 MYydkV9okC9hIhB2ovF1Lirhd420uguMUFBMinw==
X-Google-Smtp-Source: AGHT+IF+msUL9uV7nPW8OsJBv8wHJlSbqQgETJEACNyktPrqRxYJvEa/KtVKKFLepjMmb4WzUxZlBtGLXCsVFNvHfQ0=
X-Received: by 2002:a05:6a00:9451:b0:70e:98e3:1aef with SMTP id
 d2e1a72fcca58-7106d084745mr4183111b3a.29.1722612872054; Fri, 02 Aug 2024
 08:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240801204606.GJ3794063@bill-the-cat>
In-Reply-To: <20240801204606.GJ3794063@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 2 Aug 2024 11:34:20 -0400
Message-ID: <CAEfUkU+hDK2z4wJYSBU5_r1Bwa9npDDw0s6AixUBbM=wGGXzfw@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
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

On Thu, 1 Aug 2024 at 16:46, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jul 31, 2024 at 10:25:10AM -0700, Raymond Mao wrote:
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
> >
> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > v1: 6.03%
> > v2: 4.66%
> > From v3: 4.55%
> >
> > Please see the latest output from buildman for size-growth on QEMU arm64,
> > Sandbox and Nanopi A64. [1]
>
> Let us inline the growth on qemu_arm64 for a moment:
>    aarch64: (for 1/1 boards) all +6916.0 bss -32.0 data -64.0 rodata
> +200.0 text +6812.0
>             qemu_arm64     : all +6916 bss -32 data -64 rodata +200 text
> +6812
>                u-boot: add: 28/-17, grow: 12/-16 bytes: 15492/-8304 (7188)
>                  function                                   old     new
>  delta
>                  mbedtls_internal_sha1_process                -    4540
>  +4540
>                  mbedtls_internal_md5_process                 -    2928
>  +2928
>                  mbedtls_internal_sha256_process              -    2052
>  +2052
>                  mbedtls_internal_sha512_process              -    1056
>  +1056
>                  K                                            -     896
> +896
>                  mbedtls_sha512_finish                        -     556
> +556
>                  mbedtls_sha256_finish                        -     484
> +484
>                  mbedtls_sha1_finish                          -     420
> +420
>                  mbedtls_sha512_starts                        -     340
> +340
>                  mbedtls_md5_finish                           -     336
> +336
>                  mbedtls_sha512_update                        -     264
> +264
>                  mbedtls_sha256_update                        -     252
> +252
>                  mbedtls_sha1_update                          -     236
> +236
>                  mbedtls_md5_update                           -     236
> +236
>                  mbedtls_sha512                               -     148
> +148
>                  mbedtls_sha256_starts                        -     124
> +124
>                  hash_init_sha512                            52     128
>  +76
>                  hash_init_sha256                            52     128
>  +76
>                  mbedtls_sha1_starts                          -      72
>  +72
>                  mbedtls_md5_starts                           -      60
>  +60
>                  hash_init_sha1                              52     112
>  +60
>                  mbedtls_platform_zeroize                     -      56
>  +56
>                  mbedtls_sha512_free                          -      16
>  +16
>                  mbedtls_sha256_free                          -      16
>  +16
>                  mbedtls_sha1_free                            -      16
>  +16
>                  mbedtls_md5_free                             -      16
>  +16
>                  hash_finish_sha512                          72      88
>  +16
>                  hash_finish_sha256                          72      88
>  +16
>                  hash_finish_sha1                            72      88
>  +16
>                  sha512_csum_wd                              68      80
>  +12
>                  sha256_csum_wd                              68      80
>  +12
>                  sha1_csum_wd                                68      80
>  +12
>                  md5_wd                                      68      80
>  +12
>                  mbedtls_sha512_init                          -      12
>  +12
>                  mbedtls_sha256_init                          -      12
>  +12
>                  mbedtls_sha1_init                            -      12
>  +12
>                  mbedtls_md5_init                             -      12
>  +12
>                  memset_func                                  -       8
>   +8
>                  sha512_update                                4       8
>   +4
>                  sha384_update                                4       8
>   +4
>                  sha256_update                               12       8
>   -4
>                  sha1_update                                 12       8
>   -4
>                  sha256_process                              16       -
>  -16
>                  sha1_process                                16       -
>  -16
>                  hash_update_sha512                          36      16
>  -20
>                  hash_update_sha256                          36      16
>  -20
>                  hash_update_sha1                            36      16
>  -20
>                  MD5Init                                     56      36
>  -20
>                  sha1_starts                                 60      36
>  -24
>                  hash_update_sha384                          36       -
>  -36
>                  hash_init_sha384                            52       -
>  -52
>                  sha384_csum_wd                              68      12
>  -56
>                  sha256_starts                              104      40
>  -64
>                  sha256_padding                              64       -
>  -64
>                  sha1_padding                                64       -
>  -64
>                  hash_finish_sha384                          72       -
>  -72
>                  sha512_finish                              152      36
> -116
>                  sha512_starts                              168      40
> -128
>                  sha384_starts                              168      40
> -128
>                  sha384_finish                              152       4
> -148
>                  MD5Final                                   196      44
> -152
>                  sha512_base_do_finalize                    160       -
> -160
>                  static.sha256_update                       228       -
> -228
>                  static.sha1_update                         240       -
> -240
>                  sha512_base_do_update                      244       -
> -244
>                  MD5Update                                  260       -
> -260
>                  sha1_finish                                300      36
> -264
>                  sha256_finish                              404      36
> -368
>                  sha256_armv8_ce_process                    428       -
> -428
>                  sha1_armv8_ce_process                      484       -
> -484
>                  sha512_K                                   640       -
> -640
>                  sha512_block_fn                           1212       -
>  -1212
>                  MD5Transform                              2552       -
>  -2552
>
> And to start with, that's not bad. In fact, tossing LTO in before mbedTLS
> only changes
> the top-line a little:
>    aarch64: (for 1/1 boards) all +5120.0 bss -16.0 data -64.0 rodata
> +200.0 text +5000.0
>             qemu_arm64     : all +5120 bss -16 data -64 rodata +200 text
> +5000
>                u-boot: add: 19/-18, grow: 11/-7 bytes: 14696/-7884 (6812)
>
> But, is there something we can do still? mbedTLS is a more robust
> solution and I'm accepting there will be growth. But still the
> process/start/finish is much larger. Is there something configurable
> there?
>
> I have investigated all those MbedTLS native functions with big-size
(_process/_update/_finish).
For MD5 and SHA1, we don't have turnable configs.
For SHA256 and SHA512, there are a few configs:
1. Performance configs only for Armv8/a64.
    I didn't turn that on, which might affect the target size as well.
2. Smaller implementation with lower size (only for non-Armv8/a64) at the
expense of losing
    performance.
I didn't enable both, as #1 is more for performance and might potentially
increase target size;
#2 compromises the performance and only for non-Armv8/a64.
Looks like that both don't help in reducing the size of qemu_arm64.
But I will try #1 on qemu_arm64 and  #2 on sandbox and let you know
the size impact soon.

Thanks.
Regards,
Raymond
