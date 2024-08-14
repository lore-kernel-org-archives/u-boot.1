Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52F6C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 15:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F02889A1;
	Wed, 14 Aug 2024 17:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZBriwdmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEAD889B8; Wed, 14 Aug 2024 17:07:18 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E9C8895B
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 17:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70942ebcc29so4626475a34.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723648034; x=1724252834; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DVjHBFhEbgaCvgC4k5+XN8dgBr0kCoF+k58w9o3m07A=;
 b=ZBriwdmkX5AxHLvBC84/E3DdE1tzu7O6hRIfcV4hmsN/0hEg4monLQWBjHyiEqa2iK
 d0ljfkT4x2N1FKfJFRGbPsiL91Xk8kzMxwCKDtNGm6WWxfMcSdBqwR6p+O7f88qkdmT0
 mAl0NnEm+XbN164aH34bq1EUH8fYmyspO4S2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723648034; x=1724252834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVjHBFhEbgaCvgC4k5+XN8dgBr0kCoF+k58w9o3m07A=;
 b=lKJBPXdB1O/HiPkN/+KNgTCWZA3wjOUeMTKeeP+mckZIHj04dN0ctYyp6XqZNP8L/5
 L5T3Hruvqf/1qZXPkINFajcgmvUEveEHtje2eSuDpIQbF8l6BiQZV6OTJcczxFgooX6+
 sVbBg2NmZPFmSbYAu5Ypvv4iNYKo9p6UL6jyzPsf6BVjAVc4S3CKHUf0vbp3GwNivDwI
 XCh3VSAU9DqxVe84+J9GvwHPvfBwtn7yrWiIGLKUAb2W09GTAJs9YK38Fa5Z6KARfgbi
 EsUcq4ARmVb3hXgmhSe/ygvzbGTktelurr0crP9Ugp5NUHdyg72Bll7Tn+TivRMnxmjj
 LvgQ==
X-Gm-Message-State: AOJu0YwCw8HAYu65lbpg+eyKYVJ45d2UbANG/SAUfwTWbmOgFMn8j8NA
 dIQG6WGZxJteBBSvSd4Fh5VosDRHrYmQKWQtjqAzpArUdwvcbipTuK8jgeRgk28=
X-Google-Smtp-Source: AGHT+IHKzTWoVaqF2vgx1IC97gPtRexhlfSeTwZgAMK8dq0jrZJtgGwZ6bJ5iLfyXTdeTSXLqVqhvw==
X-Received: by 2002:a05:6830:65cb:b0:703:795b:f675 with SMTP id
 46e09a7af769-70c9da1ef6fmr3954233a34.28.1723648034416; 
 Wed, 14 Aug 2024 08:07:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b81d999sm2242407a34.17.2024.08.14.08.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 08:07:13 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:07:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v5 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240814150710.GO1626301@bill-the-cat>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240801204606.GJ3794063@bill-the-cat>
 <CAEfUkU+hDK2z4wJYSBU5_r1Bwa9npDDw0s6AixUBbM=wGGXzfw@mail.gmail.com>
 <CAEfUkULc6J_mAqfj7hKS8QQD+-Kw04bO_oU5=7hduF3=h1XUcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lzxJHwR40QEELkUc"
Content-Disposition: inline
In-Reply-To: <CAEfUkULc6J_mAqfj7hKS8QQD+-Kw04bO_oU5=7hduF3=h1XUcQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--lzxJHwR40QEELkUc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 09:42:08AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Fri, 2 Aug 2024 at 11:34, Raymond Mao <raymond.mao@linaro.org> wrote:
>=20
> > Hi Tom,
> >
> > On Thu, 1 Aug 2024 at 16:46, Tom Rini <trini@konsulko.com> wrote:
> >
> >> On Wed, Jul 31, 2024 at 10:25:10AM -0700, Raymond Mao wrote:
> >> >
> >> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> >> >
> >> > Motivations:
> >> > ------------
> >> >
> >> > 1. MbedTLS is well maintained with LTS versions.
> >> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> >> > 3. MbedTLS recently switched license back to GPLv2.
> >> >
> >> > Prerequisite:
> >> > -------------
> >> >
> >> > This patch series requires mbedtls git repo to be added as a
> >> > subtree to the main U-Boot repo via:
> >> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> >> >           https://github.com/Mbed-TLS/mbedtls.git \
> >> >           v3.6.0 --squash
> >> > Moreover, due to the Windows-style files from mbedtls git repo,
> >> > we need to convert the CRLF endings to LF and do a commit manually:
> >> >     $ git add --renormalize .
> >> >     $ git commit
> >> >
> >> > New Kconfig options:
> >> > --------------------
> >> >
> >> > `MBEDTLS_LIB` is for MbedTLS general switch.
> >> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs
> >> with
> >> > MbedTLS.
> >> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, AS=
N1,
> >> > and Pubkey parser with MbedTLS.
> >> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> >> library.
> >> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> >> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> >> > For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDT=
LS`
> >> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> >> > introduced.
> >> >
> >> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X=
509
> >> > are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> >> > for testing purpose.
> >> >
> >> > Patches for external MbedTLS project:
> >> > -------------------------------------
> >> >
> >> > Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> >> > executables which is not supported by MbedTLS at the moment,
> >> > addtional patches for MbedTLS are created to adapt with the EFI load=
er:
> >> > 1. Decoding of Microsoft Authentication Code.
> >> > 2. Decoding of PKCS#9 Authenticate Attributes.
> >> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> >> certificates.
> >> > 4. MbedTLS native test suites for PKCS#7 signer's info.
> >> >
> >> > All above 4 patches (tagged with `mbedtls/external`) are submitted to
> >> > MbedTLS project and being reviewed, eventually they should be part of
> >> > MbedTLS LTS release.
> >> > But before that, please merge them into U-Boot, otherwise the buildi=
ng
> >> > will be broken when MBEDTLS_LIB_X509 is enabled.
> >> >
> >> > See below PR link for the reference:
> >> > https://github.com/Mbed-TLS/mbedtls/pull/9001
> >> >
> >> > Miscellaneous:
> >> > --------------
> >> >
> >> > Optimized MbedTLS library size by tailoring the config file
> >> > and disabling all unnecessary features for EFI loader.
> >> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> >> sha256,
> >> > sha512) are completely replaced when MbedTLS is enabled.
> >> > From v3, the size-growth is slightly reduced by refactoring Hash
> >> functions.
> >> >
> >> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> >> > v1: 6.03%
> >> > v2: 4.66%
> >> > From v3: 4.55%
> >> >
> >> > Please see the latest output from buildman for size-growth on QEMU
> >> arm64,
> >> > Sandbox and Nanopi A64. [1]
> >>
> >> Let us inline the growth on qemu_arm64 for a moment:
> >>    aarch64: (for 1/1 boards) all +6916.0 bss -32.0 data -64.0 rodata
> >> +200.0 text +6812.0
> >>             qemu_arm64     : all +6916 bss -32 data -64 rodata +200 te=
xt
> >> +6812
> >>                u-boot: add: 28/-17, grow: 12/-16 bytes: 15492/-8304 (7=
188)
> >>                  function                                   old     new
> >>  delta
> >>                  mbedtls_internal_sha1_process                -    4540
> >>  +4540
> >>                  mbedtls_internal_md5_process                 -    2928
> >>  +2928
> >>                  mbedtls_internal_sha256_process              -    2052
> >>  +2052
> >>                  mbedtls_internal_sha512_process              -    1056
> >>  +1056
> >>                  K                                            -     896
> >>   +896
> >>                  mbedtls_sha512_finish                        -     556
> >>   +556
> >>                  mbedtls_sha256_finish                        -     484
> >>   +484
> >>                  mbedtls_sha1_finish                          -     420
> >>   +420
> >>                  mbedtls_sha512_starts                        -     340
> >>   +340
> >>                  mbedtls_md5_finish                           -     336
> >>   +336
> >>                  mbedtls_sha512_update                        -     264
> >>   +264
> >>                  mbedtls_sha256_update                        -     252
> >>   +252
> >>                  mbedtls_sha1_update                          -     236
> >>   +236
> >>                  mbedtls_md5_update                           -     236
> >>   +236
> >>                  mbedtls_sha512                               -     148
> >>   +148
> >>                  mbedtls_sha256_starts                        -     124
> >>   +124
> >>                  hash_init_sha512                            52     128
> >>    +76
> >>                  hash_init_sha256                            52     128
> >>    +76
> >>                  mbedtls_sha1_starts                          -      72
> >>    +72
> >>                  mbedtls_md5_starts                           -      60
> >>    +60
> >>                  hash_init_sha1                              52     112
> >>    +60
> >>                  mbedtls_platform_zeroize                     -      56
> >>    +56
> >>                  mbedtls_sha512_free                          -      16
> >>    +16
> >>                  mbedtls_sha256_free                          -      16
> >>    +16
> >>                  mbedtls_sha1_free                            -      16
> >>    +16
> >>                  mbedtls_md5_free                             -      16
> >>    +16
> >>                  hash_finish_sha512                          72      88
> >>    +16
> >>                  hash_finish_sha256                          72      88
> >>    +16
> >>                  hash_finish_sha1                            72      88
> >>    +16
> >>                  sha512_csum_wd                              68      80
> >>    +12
> >>                  sha256_csum_wd                              68      80
> >>    +12
> >>                  sha1_csum_wd                                68      80
> >>    +12
> >>                  md5_wd                                      68      80
> >>    +12
> >>                  mbedtls_sha512_init                          -      12
> >>    +12
> >>                  mbedtls_sha256_init                          -      12
> >>    +12
> >>                  mbedtls_sha1_init                            -      12
> >>    +12
> >>                  mbedtls_md5_init                             -      12
> >>    +12
> >>                  memset_func                                  -       8
> >>     +8
> >>                  sha512_update                                4       8
> >>     +4
> >>                  sha384_update                                4       8
> >>     +4
> >>                  sha256_update                               12       8
> >>     -4
> >>                  sha1_update                                 12       8
> >>     -4
> >>                  sha256_process                              16       -
> >>    -16
> >>                  sha1_process                                16       -
> >>    -16
> >>                  hash_update_sha512                          36      16
> >>    -20
> >>                  hash_update_sha256                          36      16
> >>    -20
> >>                  hash_update_sha1                            36      16
> >>    -20
> >>                  MD5Init                                     56      36
> >>    -20
> >>                  sha1_starts                                 60      36
> >>    -24
> >>                  hash_update_sha384                          36       -
> >>    -36
> >>                  hash_init_sha384                            52       -
> >>    -52
> >>                  sha384_csum_wd                              68      12
> >>    -56
> >>                  sha256_starts                              104      40
> >>    -64
> >>                  sha256_padding                              64       -
> >>    -64
> >>                  sha1_padding                                64       -
> >>    -64
> >>                  hash_finish_sha384                          72       -
> >>    -72
> >>                  sha512_finish                              152      36
> >>   -116
> >>                  sha512_starts                              168      40
> >>   -128
> >>                  sha384_starts                              168      40
> >>   -128
> >>                  sha384_finish                              152       4
> >>   -148
> >>                  MD5Final                                   196      44
> >>   -152
> >>                  sha512_base_do_finalize                    160       -
> >>   -160
> >>                  static.sha256_update                       228       -
> >>   -228
> >>                  static.sha1_update                         240       -
> >>   -240
> >>                  sha512_base_do_update                      244       -
> >>   -244
> >>                  MD5Update                                  260       -
> >>   -260
> >>                  sha1_finish                                300      36
> >>   -264
> >>                  sha256_finish                              404      36
> >>   -368
> >>                  sha256_armv8_ce_process                    428       -
> >>   -428
> >>                  sha1_armv8_ce_process                      484       -
> >>   -484
> >>                  sha512_K                                   640       -
> >>   -640
> >>                  sha512_block_fn                           1212       -
> >>  -1212
> >>                  MD5Transform                              2552       -
> >>  -2552
> >>
> >> And to start with, that's not bad. In fact, tossing LTO in before mbed=
TLS
> >> only changes
> >> the top-line a little:
> >>    aarch64: (for 1/1 boards) all +5120.0 bss -16.0 data -64.0 rodata
> >> +200.0 text +5000.0
> >>             qemu_arm64     : all +5120 bss -16 data -64 rodata +200 te=
xt
> >> +5000
> >>                u-boot: add: 19/-18, grow: 11/-7 bytes: 14696/-7884 (68=
12)
> >>
> >> But, is there something we can do still? mbedTLS is a more robust
> >> solution and I'm accepting there will be growth. But still the
> >> process/start/finish is much larger. Is there something configurable
> >> there?
> >>
> >> I have investigated all those MbedTLS native functions with big-size
> > (_process/_update/_finish).
> > For MD5 and SHA1, we don't have turnable configs.
> > For SHA256 and SHA512, there are a few configs:
> > 1. Performance configs only for Armv8/a64.
> >     I didn't turn that on, which might affect the target size as well.
> > 2. Smaller implementation with lower size (only for non-Armv8/a64) at t=
he
> > expense of losing
> >     performance.
> > I didn't enable both, as #1 is more for performance and might potential=
ly
> > increase target size;
> > #2 compromises the performance and only for non-Armv8/a64.
> > Looks like that both don't help in reducing the size of qemu_arm64.
> > But I will try #1 on qemu_arm64 and  #2 on sandbox and let you know
> > the size impact soon.
> >
> > The smaller footprint implementation for SHA256/512 can reduce the targ=
et
> size significantly on
> those "<hash>_process()" functions. Please see below output from buildman:
> ```
>    aarch64: (for 2/2 boards) all -1468.0 bss +16.0 data -64.0 rodata +200=
=2E0
> text -1620.0
>             qemu_arm64     : all +4608 bss +80 data -64 rodata +200 text
> +4392
>                u-boot: add: 29/-17, grow: 12/-16 bytes: 13072/-8304 (4768)
>             nanopi_a64     : all -7544 bss -48 data -64 rodata +200 text
> -7632
>                u-boot: add: 21/-8, grow: 4/-8 bytes: 10692/-4364 (6328)
>    sandbox: (for 1/1 boards) all +19312.0 data +1440.0 rodata -4128.0 text
> +22000.0
>             sandbox        : all +19312 data +1440 rodata -4128 text +220=
00
>                u-boot: add: 258/-206, grow: 122/-59 bytes: 90286/-76286
> (14000)
> ```
> Since this is a trade-off between size and performance, I will add one mo=
re
> kconfig to
> allow the user to turn it on/off. What are your thoughts?
>=20
> On the other hand, the "Armv8/a64 only" options depend on NEON
> instructions, so I
> will keep them off.

Yes, we should have it as a Kconfig option. Can you perhaps do a
real-world performance test (so some not-qemu platform) where you sha256
a big hunk of memory? That might help inform the defaults. Also, sorry,
I don't understand your comment about NEON instructions. Is it the kind
of thing where there's too much core variability in terms of who has
what? If so, it too should be an option, but not enabled by default.

--=20
Tom

--lzxJHwR40QEELkUc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma8yBsACgkQFHw5/5Y0
tyyUpgv3eHgcbMtN5VA2JnoSL/hbkfB5XtUmTzJXIsFFWBK71Mv58PgMm9OdApC3
LHAkdltEKE3JhVCoElhsOlghrig4V+youf3XQyAM+fK0CHI2nNK2oO9/SrliJDbw
/MDgoWZZNzLFbTvs2xXD+RnhtUMXsyojyXKaA6k0Ki2JRrdwLPwQ756jk1w41uOW
d5TZMLbbflQmUEfadMmtcGAxCpDAXIQx7ztSJy6e6n96zNaJOL6IDDtzLQU93zvn
NpqQDQwApeDScUKtdR8na3+VA4zmPsSvOvHo4tMAmx0CWzSocM2Eb5oxHNCvOjGe
0PvTJ3EQinDLfLLGy3ySyzn5YYL+v33ZtZrMweM+5lMusZeSs3j3yrT88UaH4K0O
dt3kfeE0YbZQMr0YSRS9g6M9eO90yTROV4KkM3t9ht/KSl09+CJI8eFXKzibgFNX
mm+EP84JmhwJtPPCjtJdKFi0hX3fO8bVuZpk+iUP+UQv5+vmcDDUlEBbtsTyOowh
eGTkJw4=
=qUkY
-----END PGP SIGNATURE-----

--lzxJHwR40QEELkUc--
