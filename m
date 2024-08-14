Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204CBC52D7F
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 18:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C47889D3;
	Wed, 14 Aug 2024 20:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UBmIaH2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B73889E9; Wed, 14 Aug 2024 20:04:23 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11AF088859
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 20:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70949118d26so84308a34.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723658660; x=1724263460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=smCvey4YcVb5ZBywuql3/YE4nb4FGztXlnjjXBZdwzg=;
 b=UBmIaH2uGGJujpsPGGh2P11qrVNAJ2UtCQ6R2CUv6JwQf97jDYpqP+px3HsyWHfc8q
 ljFp82PSjvui+FJYMiOfRqxDQsN1dn/B9uyh1PvsVKYQwcqkaNsTvpm+4AioSRt3K/Ye
 G8P12Eki7buAT1oY5JUUZg6xxkabEu1+IeRe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723658660; x=1724263460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smCvey4YcVb5ZBywuql3/YE4nb4FGztXlnjjXBZdwzg=;
 b=bMv9D2lZ4XPVwLiD1EQ30mHWdJqPaK0T080NeHRhsrAccOAb07f2OPz8jy966kKVRM
 jYOmI6MnxbFDX4fnQ86bdEFpEqSFt8+ntapF0jUKeVrFUQmsbM7/lXPC036296idimSQ
 Fz4rELdc8dMmkZno+NEei9VtiyBcKPTOQ3eeAHGrYExfZFm8F507gTQhnrzpml1KJBlz
 BOpnnS8HJ17vYVuHVL8JtyiKVNdaSpmgMr0x2/L/3JH0dV42tW/O1Py5+J2QTPUuMzlN
 2CU5fTmB6OoWxH2OaF+2NVEYXsOUORDvGNQB0ggaBm7AhHdkfdCl1+wkjFNq0WTm8+fJ
 qXqg==
X-Gm-Message-State: AOJu0YzXmxQ9DAa+lBaJPV6ofByoxsKXLFY6Labww8YLqeJ+eWpkPlYf
 9r4y92EzKsyxeJgGewWMTxxuF4UTN1Cjw4z/CjBgw7iHjPmw1A/k9+7Rsogf/UM=
X-Google-Smtp-Source: AGHT+IGrWsC0x+qTOwd65xhWvXb2ijCtCAGutlEyLIWNR2whhvArVzd0axBN6lNm6AOuPdkW3hsC9w==
X-Received: by 2002:a05:6830:2707:b0:704:470d:a470 with SMTP id
 46e09a7af769-70c9d9f0888mr3511057a34.28.1723658659597; 
 Wed, 14 Aug 2024 11:04:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b89058esm2287580a34.71.2024.08.14.11.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:04:19 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:04:15 -0600
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
Message-ID: <20240814180415.GQ1626301@bill-the-cat>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240801204606.GJ3794063@bill-the-cat>
 <CAEfUkU+hDK2z4wJYSBU5_r1Bwa9npDDw0s6AixUBbM=wGGXzfw@mail.gmail.com>
 <CAEfUkULc6J_mAqfj7hKS8QQD+-Kw04bO_oU5=7hduF3=h1XUcQ@mail.gmail.com>
 <20240814150710.GO1626301@bill-the-cat>
 <CAEfUkUJrLu8hbuQVDQiGH4LYRYHW9QUwN2t7aD4ahTsOYm9qAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LrTShLX8N0saEjNu"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJrLu8hbuQVDQiGH4LYRYHW9QUwN2t7aD4ahTsOYm9qAg@mail.gmail.com>
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


--LrTShLX8N0saEjNu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 01:49:43PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 14 Aug 2024 at 11:07, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Aug 14, 2024 at 09:42:08AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Fri, 2 Aug 2024 at 11:34, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > >
> > > > Hi Tom,
> > > >
> > > > On Thu, 1 Aug 2024 at 16:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > >> On Wed, Jul 31, 2024 at 10:25:10AM -0700, Raymond Mao wrote:
> > > >> >
> > > >> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> > > >> >
> > > >> > Motivations:
> > > >> > ------------
> > > >> >
> > > >> > 1. MbedTLS is well maintained with LTS versions.
> > > >> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> > > >> > 3. MbedTLS recently switched license back to GPLv2.
> > > >> >
> > > >> > Prerequisite:
> > > >> > -------------
> > > >> >
> > > >> > This patch series requires mbedtls git repo to be added as a
> > > >> > subtree to the main U-Boot repo via:
> > > >> >     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > > >> >           https://github.com/Mbed-TLS/mbedtls.git \
> > > >> >           v3.6.0 --squash
> > > >> > Moreover, due to the Windows-style files from mbedtls git repo,
> > > >> > we need to convert the CRLF endings to LF and do a commit manual=
ly:
> > > >> >     $ git add --renormalize .
> > > >> >     $ git commit
> > > >> >
> > > >> > New Kconfig options:
> > > >> > --------------------
> > > >> >
> > > >> > `MBEDTLS_LIB` is for MbedTLS general switch.
> > > >> > `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto
> > libs
> > > >> with
> > > >> > MbedTLS.
> > > >> > `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode,
> > ASN1,
> > > >> > and Pubkey parser with MbedTLS.
> > > >> > `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto
> > > >> library.
> > > >> > `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> > > >> > `LEGACY_CRYPTO_CERT` is for the certificate related functionalit=
ies.
> > > >> > For each of the algorithm, a pair of `<alg>_LEGACY` and
> > `<alg>_MBEDTLS`
> > > >> > Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options
> > are
> > > >> > introduced.
> > > >> >
> > > >> > In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and
> > MBEDTLS_LIB_X509
> > > >> > are by default enabled in qemu_arm64_defconfig and sandbox_defco=
nfig
> > > >> > for testing purpose.
> > > >> >
> > > >> > Patches for external MbedTLS project:
> > > >> > -------------------------------------
> > > >> >
> > > >> > Since U-Boot uses Microsoft Authentication Code to verify PE/COF=
Fs
> > > >> > executables which is not supported by MbedTLS at the moment,
> > > >> > addtional patches for MbedTLS are created to adapt with the EFI
> > loader:
> > > >> > 1. Decoding of Microsoft Authentication Code.
> > > >> > 2. Decoding of PKCS#9 Authenticate Attributes.
> > > >> > 3. Extending MbedTLS PKCS#7 lib to support multiple signer's
> > > >> certificates.
> > > >> > 4. MbedTLS native test suites for PKCS#7 signer's info.
> > > >> >
> > > >> > All above 4 patches (tagged with `mbedtls/external`) are submitt=
ed
> > to
> > > >> > MbedTLS project and being reviewed, eventually they should be pa=
rt
> > of
> > > >> > MbedTLS LTS release.
> > > >> > But before that, please merge them into U-Boot, otherwise the
> > building
> > > >> > will be broken when MBEDTLS_LIB_X509 is enabled.
> > > >> >
> > > >> > See below PR link for the reference:
> > > >> > https://github.com/Mbed-TLS/mbedtls/pull/9001
> > > >> >
> > > >> > Miscellaneous:
> > > >> > --------------
> > > >> >
> > > >> > Optimized MbedTLS library size by tailoring the config file
> > > >> > and disabling all unnecessary features for EFI loader.
> > > >> > From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1,
> > > >> sha256,
> > > >> > sha512) are completely replaced when MbedTLS is enabled.
> > > >> > From v3, the size-growth is slightly reduced by refactoring Hash
> > > >> functions.
> > > >> >
> > > >> > Target(QEMU arm64) size-growth when enabling MbedTLS:
> > > >> > v1: 6.03%
> > > >> > v2: 4.66%
> > > >> > From v3: 4.55%
> > > >> >
> > > >> > Please see the latest output from buildman for size-growth on QE=
MU
> > > >> arm64,
> > > >> > Sandbox and Nanopi A64. [1]
> > > >>
> > > >> Let us inline the growth on qemu_arm64 for a moment:
> > > >>    aarch64: (for 1/1 boards) all +6916.0 bss -32.0 data -64.0 roda=
ta
> > > >> +200.0 text +6812.0
> > > >>             qemu_arm64     : all +6916 bss -32 data -64 rodata +200
> > text
> > > >> +6812
> > > >>                u-boot: add: 28/-17, grow: 12/-16 bytes: 15492/-8304
> > (7188)
> > > >>                  function                                   old
> >  new
> > > >>  delta
> > > >>                  mbedtls_internal_sha1_process                -
> > 4540
> > > >>  +4540
> > > >>                  mbedtls_internal_md5_process                 -
> > 2928
> > > >>  +2928
> > > >>                  mbedtls_internal_sha256_process              -
> > 2052
> > > >>  +2052
> > > >>                  mbedtls_internal_sha512_process              -
> > 1056
> > > >>  +1056
> > > >>                  K                                            -
> >  896
> > > >>   +896
> > > >>                  mbedtls_sha512_finish                        -
> >  556
> > > >>   +556
> > > >>                  mbedtls_sha256_finish                        -
> >  484
> > > >>   +484
> > > >>                  mbedtls_sha1_finish                          -
> >  420
> > > >>   +420
> > > >>                  mbedtls_sha512_starts                        -
> >  340
> > > >>   +340
> > > >>                  mbedtls_md5_finish                           -
> >  336
> > > >>   +336
> > > >>                  mbedtls_sha512_update                        -
> >  264
> > > >>   +264
> > > >>                  mbedtls_sha256_update                        -
> >  252
> > > >>   +252
> > > >>                  mbedtls_sha1_update                          -
> >  236
> > > >>   +236
> > > >>                  mbedtls_md5_update                           -
> >  236
> > > >>   +236
> > > >>                  mbedtls_sha512                               -
> >  148
> > > >>   +148
> > > >>                  mbedtls_sha256_starts                        -
> >  124
> > > >>   +124
> > > >>                  hash_init_sha512                            52
> >  128
> > > >>    +76
> > > >>                  hash_init_sha256                            52
> >  128
> > > >>    +76
> > > >>                  mbedtls_sha1_starts                          -
> > 72
> > > >>    +72
> > > >>                  mbedtls_md5_starts                           -
> > 60
> > > >>    +60
> > > >>                  hash_init_sha1                              52
> >  112
> > > >>    +60
> > > >>                  mbedtls_platform_zeroize                     -
> > 56
> > > >>    +56
> > > >>                  mbedtls_sha512_free                          -
> > 16
> > > >>    +16
> > > >>                  mbedtls_sha256_free                          -
> > 16
> > > >>    +16
> > > >>                  mbedtls_sha1_free                            -
> > 16
> > > >>    +16
> > > >>                  mbedtls_md5_free                             -
> > 16
> > > >>    +16
> > > >>                  hash_finish_sha512                          72
> > 88
> > > >>    +16
> > > >>                  hash_finish_sha256                          72
> > 88
> > > >>    +16
> > > >>                  hash_finish_sha1                            72
> > 88
> > > >>    +16
> > > >>                  sha512_csum_wd                              68
> > 80
> > > >>    +12
> > > >>                  sha256_csum_wd                              68
> > 80
> > > >>    +12
> > > >>                  sha1_csum_wd                                68
> > 80
> > > >>    +12
> > > >>                  md5_wd                                      68
> > 80
> > > >>    +12
> > > >>                  mbedtls_sha512_init                          -
> > 12
> > > >>    +12
> > > >>                  mbedtls_sha256_init                          -
> > 12
> > > >>    +12
> > > >>                  mbedtls_sha1_init                            -
> > 12
> > > >>    +12
> > > >>                  mbedtls_md5_init                             -
> > 12
> > > >>    +12
> > > >>                  memset_func                                  -
> >  8
> > > >>     +8
> > > >>                  sha512_update                                4
> >  8
> > > >>     +4
> > > >>                  sha384_update                                4
> >  8
> > > >>     +4
> > > >>                  sha256_update                               12
> >  8
> > > >>     -4
> > > >>                  sha1_update                                 12
> >  8
> > > >>     -4
> > > >>                  sha256_process                              16
> >  -
> > > >>    -16
> > > >>                  sha1_process                                16
> >  -
> > > >>    -16
> > > >>                  hash_update_sha512                          36
> > 16
> > > >>    -20
> > > >>                  hash_update_sha256                          36
> > 16
> > > >>    -20
> > > >>                  hash_update_sha1                            36
> > 16
> > > >>    -20
> > > >>                  MD5Init                                     56
> > 36
> > > >>    -20
> > > >>                  sha1_starts                                 60
> > 36
> > > >>    -24
> > > >>                  hash_update_sha384                          36
> >  -
> > > >>    -36
> > > >>                  hash_init_sha384                            52
> >  -
> > > >>    -52
> > > >>                  sha384_csum_wd                              68
> > 12
> > > >>    -56
> > > >>                  sha256_starts                              104
> > 40
> > > >>    -64
> > > >>                  sha256_padding                              64
> >  -
> > > >>    -64
> > > >>                  sha1_padding                                64
> >  -
> > > >>    -64
> > > >>                  hash_finish_sha384                          72
> >  -
> > > >>    -72
> > > >>                  sha512_finish                              152
> > 36
> > > >>   -116
> > > >>                  sha512_starts                              168
> > 40
> > > >>   -128
> > > >>                  sha384_starts                              168
> > 40
> > > >>   -128
> > > >>                  sha384_finish                              152
> >  4
> > > >>   -148
> > > >>                  MD5Final                                   196
> > 44
> > > >>   -152
> > > >>                  sha512_base_do_finalize                    160
> >  -
> > > >>   -160
> > > >>                  static.sha256_update                       228
> >  -
> > > >>   -228
> > > >>                  static.sha1_update                         240
> >  -
> > > >>   -240
> > > >>                  sha512_base_do_update                      244
> >  -
> > > >>   -244
> > > >>                  MD5Update                                  260
> >  -
> > > >>   -260
> > > >>                  sha1_finish                                300
> > 36
> > > >>   -264
> > > >>                  sha256_finish                              404
> > 36
> > > >>   -368
> > > >>                  sha256_armv8_ce_process                    428
> >  -
> > > >>   -428
> > > >>                  sha1_armv8_ce_process                      484
> >  -
> > > >>   -484
> > > >>                  sha512_K                                   640
> >  -
> > > >>   -640
> > > >>                  sha512_block_fn                           1212
> >  -
> > > >>  -1212
> > > >>                  MD5Transform                              2552
> >  -
> > > >>  -2552
> > > >>
> > > >> And to start with, that's not bad. In fact, tossing LTO in before
> > mbedTLS
> > > >> only changes
> > > >> the top-line a little:
> > > >>    aarch64: (for 1/1 boards) all +5120.0 bss -16.0 data -64.0 roda=
ta
> > > >> +200.0 text +5000.0
> > > >>             qemu_arm64     : all +5120 bss -16 data -64 rodata +200
> > text
> > > >> +5000
> > > >>                u-boot: add: 19/-18, grow: 11/-7 bytes: 14696/-7884
> > (6812)
> > > >>
> > > >> But, is there something we can do still? mbedTLS is a more robust
> > > >> solution and I'm accepting there will be growth. But still the
> > > >> process/start/finish is much larger. Is there something configurab=
le
> > > >> there?
> > > >>
> > > >> I have investigated all those MbedTLS native functions with big-si=
ze
> > > > (_process/_update/_finish).
> > > > For MD5 and SHA1, we don't have turnable configs.
> > > > For SHA256 and SHA512, there are a few configs:
> > > > 1. Performance configs only for Armv8/a64.
> > > >     I didn't turn that on, which might affect the target size as we=
ll.
> > > > 2. Smaller implementation with lower size (only for non-Armv8/a64) =
at
> > the
> > > > expense of losing
> > > >     performance.
> > > > I didn't enable both, as #1 is more for performance and might
> > potentially
> > > > increase target size;
> > > > #2 compromises the performance and only for non-Armv8/a64.
> > > > Looks like that both don't help in reducing the size of qemu_arm64.
> > > > But I will try #1 on qemu_arm64 and  #2 on sandbox and let you know
> > > > the size impact soon.
> > > >
> > > > The smaller footprint implementation for SHA256/512 can reduce the
> > target
> > > size significantly on
> > > those "<hash>_process()" functions. Please see below output from
> > buildman:
> > > ```
> > >    aarch64: (for 2/2 boards) all -1468.0 bss +16.0 data -64.0 rodata
> > +200.0
> > > text -1620.0
> > >             qemu_arm64     : all +4608 bss +80 data -64 rodata +200 t=
ext
> > > +4392
> > >                u-boot: add: 29/-17, grow: 12/-16 bytes: 13072/-8304
> > (4768)
> > >             nanopi_a64     : all -7544 bss -48 data -64 rodata +200 t=
ext
> > > -7632
> > >                u-boot: add: 21/-8, grow: 4/-8 bytes: 10692/-4364 (632=
8)
> > >    sandbox: (for 1/1 boards) all +19312.0 data +1440.0 rodata -4128.0
> > text
> > > +22000.0
> > >             sandbox        : all +19312 data +1440 rodata -4128 text
> > +22000
> > >                u-boot: add: 258/-206, grow: 122/-59 bytes: 90286/-762=
86
> > > (14000)
> > > ```
> > > Since this is a trade-off between size and performance, I will add one
> > more
> > > kconfig to
> > > allow the user to turn it on/off. What are your thoughts?
> > >
> > > On the other hand, the "Armv8/a64 only" options depend on NEON
> > > instructions, so I
> > > will keep them off.
> >
> > Yes, we should have it as a Kconfig option. Can you perhaps do a
> > real-world performance test (so some not-qemu platform) where you sha256
> > a big hunk of memory? That might help inform the defaults.
>=20
> Below are a few tests I did on my Ubuntu PC, leveraging the benchmark too=
l.
> I measured two key factors, throughput and the number of CPU cycles per
> byte.
> Each process was done with a 1KB data block.
> The throughput was measured in an average data process (KiB/s) in 10
> seconds.
> The number of CPU cycles per byte is an average number of processing 4096
> times with the same data block size.
>=20
> See below result:
>=20
> Original:
> SHA-256                  :      87972 KiB/s,         23 cycles/byte
> SHA-512                  :      107328 KiB/s,       20 cycles/byte
>=20
> Smaller implementations:
> SHA-256                  :      65872 KiB/s,         36 cycles/byte
> SHA-512                  :      94059 KiB/s,         23 cycles/byte
>=20
> Please note that this is not very precise as it depends on many other
> factors,
> but we still can take this as a reference.
> As we can see here, the "smaller" one is not too bad.
> I would put the kconfig for the "smaller" one as a default config when
> MbedTLS is
> selected for qemu64 and sandbox.
> Other platforms can decide what they want depends on the real performance=
 on
> each platform.
> Is this fine for you? Please feel free to advise.

Thanks. Yes, we should just default to "smaller" for everyone.

> > Also, sorry,
> > I don't understand your comment about NEON instructions. Is it the kind
> > of thing where there's too much core variability in terms of who has
> > what? If so, it too should be an option, but not enabled by default.
> >
> > The Armv8/A64 accelerating config depends on some of the NEON instructi=
ons
> for example, vaddq_u32() and vaddq_u64().
> Please see this link for the reference:
> https://developer.arm.com/documentation/dht0002/a/Introducing-NEON/Develo=
ping-for-NEON/Intrinsics
> I think we are missing this in U-Boot.
> I would suggest ignoring it at the moment (keep them all off).

Ah OK, follow-up work then.

--=20
Tom

--LrTShLX8N0saEjNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma88Z8ACgkQFHw5/5Y0
tyysWAwAhaC6L2Au93CZPMysBoKF5f6qKVIZwD3SyLnh9718ZTUeXbCHfcDB6w4i
CgJTUqwOg6KkhSNsMJ5SGHPNwBSidaHBikx+P0AJPmO2+r5hmcMB6iIutJRa1/h3
kM1IX5PyOTOjgifaFf+b3kMOM9GvbqAAhykKkCzOOUETcpiP0Jxszdt7S/QUNkE5
Pd00adhohx4zKggkCIea/WRwXeHrUkusI/I484432vOc4F3mdWD+4hWKoxOw8x6n
yjKKZSC0LDppWq48B6xYKNfDrEPfqJLMYhrOXGb4EEvfkytC5p5j3RPaWQKyfbWx
pg7xOoHiz9NLHhDtTsnnh7cq6bqDCFZpj0QBCDV+ZqXkFx8phmcVR3Lm3A33UiGy
nvvTsfhn4qGnjczQSl5fZBMr3O8PTx9SGUi1QZIRE+HvT/8a90riXvXsNDJcdbj/
5J7CzVrRpUXwCC4SQs330pfmhb9qPhBWCtWUOWNTHW8M06IuzMeLIJA9b/Zr/cAk
7XdtHF6B
=R0lF
-----END PGP SIGNATURE-----

--LrTShLX8N0saEjNu--
