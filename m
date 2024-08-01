Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F99FC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 20:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6C78863C;
	Thu,  1 Aug 2024 22:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="crrQnK1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D1B98863E; Thu,  1 Aug 2024 22:46:16 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF2B885AE
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 22:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db1bc36bc2so1245846b6e.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722545172; x=1723149972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wc/0jFn57Gw1proH03fgnKlMiHGfcYZi2yF52YXuOv4=;
 b=crrQnK1TLkQ9lSjIEvZKwQdv+1zS9CjPv5O+MbJ/BVWatEffOipfLuz0mBUWSwwPbv
 Cau6gvuuaIyA3NAPYUGoATRQMfSm5jGugfoNJJnbB04P4vTkqdBkoVhhCBB4SScRVpYk
 tCJhgVZAoCceljwquUR0XrcblsKpUr6MiUqA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722545172; x=1723149972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc/0jFn57Gw1proH03fgnKlMiHGfcYZi2yF52YXuOv4=;
 b=LL9E9IB7BxixpKjM4jv2ce9dMZrJzhzZqTLp70DHyOquTbGodBeAMfO7xo6Ip3aYLB
 UK10oAukTygcx88Nc64Mbqo91VGzZhGsOPqi3orYgSJbAc7sKSgDHCWKYa7/FhBC70QE
 gYfv7zaaBtYYcPutOWqqNLiZU/0m8V4KxyDMhECe0pFXUhllasxqT7Wsf7AmKoeLaFLa
 3M4GRSz4vX5CA7GEg/QZnqZRjSc8gusE8CXC2D3dZ+Bo2VA/gvkTLy9kIn3zaFW0rRPZ
 QrVTsph4bHenUQMW+aKQ/ipL4EWlAxIqY9QDp/7aE7I+80JT7stNa4p/accYv19BBOcm
 zATw==
X-Gm-Message-State: AOJu0YxQW4fpCS4FqAtF8d1t2euhNSo8BMRJnzI+OmWIrEU5r17niVVM
 PUCUDI0eiybN2J5aDNmkjEFRHBTVdgtsNEGBj7HL15b8FV8scSAfZ6YdhTsi8xg=
X-Google-Smtp-Source: AGHT+IH5/Cw/3FRX52ABXgr92brCcGwtR7KKYBUOFDAoeAMwf2tR9J1h/fXgPqSx6+WUclubImmzvA==
X-Received: by 2002:a05:6808:1782:b0:3d9:3f0d:8ed7 with SMTP id
 5614622812f47-3db537c4660mr1417550b6e.3.1722545172199; 
 Thu, 01 Aug 2024 13:46:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563c7afesm101370b6e.58.2024.08.01.13.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 13:46:11 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:46:06 -0600
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
Message-ID: <20240801204606.GJ3794063@bill-the-cat>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Nw07KzWTCDIfRAn"
Content-Disposition: inline
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
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


--6Nw07KzWTCDIfRAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:25:10AM -0700, Raymond Mao wrote:
>
> Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>=20
> Motivations:
> ------------
>=20
> 1. MbedTLS is well maintained with LTS versions.
> 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> 3. MbedTLS recently switched license back to GPLv2.
>=20
> Prerequisite:
> -------------
>=20
> This patch series requires mbedtls git repo to be added as a
> subtree to the main U-Boot repo via:
>     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>           https://github.com/Mbed-TLS/mbedtls.git \
>           v3.6.0 --squash
> Moreover, due to the Windows-style files from mbedtls git repo,
> we need to convert the CRLF endings to LF and do a commit manually:
>     $ git add --renormalize .
>     $ git commit
>=20
> New Kconfig options:
> --------------------
>=20
> `MBEDTLS_LIB` is for MbedTLS general switch.
> `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
> MbedTLS.
> `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> and Pubkey parser with MbedTLS.
> `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> introduced.
>=20
> In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> for testing purpose.
>=20
> Patches for external MbedTLS project:
> -------------------------------------
>=20
> Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> executables which is not supported by MbedTLS at the moment,
> addtional patches for MbedTLS are created to adapt with the EFI loader:=
=20
> 1. Decoding of Microsoft Authentication Code.
> 2. Decoding of PKCS#9 Authenticate Attributes.
> 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
> 4. MbedTLS native test suites for PKCS#7 signer's info.
>=20
> All above 4 patches (tagged with `mbedtls/external`) are submitted to
> MbedTLS project and being reviewed, eventually they should be part of
> MbedTLS LTS release.
> But before that, please merge them into U-Boot, otherwise the building
> will be broken when MBEDTLS_LIB_X509 is enabled.=20
>=20
> See below PR link for the reference:
> https://github.com/Mbed-TLS/mbedtls/pull/9001
>=20
> Miscellaneous:
> --------------
>=20
> Optimized MbedTLS library size by tailoring the config file
> and disabling all unnecessary features for EFI loader.
> From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
> sha512) are completely replaced when MbedTLS is enabled.
> From v3, the size-growth is slightly reduced by refactoring Hash function=
s.
>=20
> Target(QEMU arm64) size-growth when enabling MbedTLS:
> v1: 6.03%
> v2: 4.66%
> From v3: 4.55%
>=20
> Please see the latest output from buildman for size-growth on QEMU arm64,
> Sandbox and Nanopi A64. [1]

Let us inline the growth on qemu_arm64 for a moment:
   aarch64: (for 1/1 boards) all +6916.0 bss -32.0 data -64.0 rodata +200.0=
 text +6812.0
            qemu_arm64     : all +6916 bss -32 data -64 rodata +200 text +6=
812
               u-boot: add: 28/-17, grow: 12/-16 bytes: 15492/-8304 (7188)
                 function                                   old     new   d=
elta
                 mbedtls_internal_sha1_process                -    4540   +=
4540
                 mbedtls_internal_md5_process                 -    2928   +=
2928
                 mbedtls_internal_sha256_process              -    2052   +=
2052
                 mbedtls_internal_sha512_process              -    1056   +=
1056
                 K                                            -     896    =
+896
                 mbedtls_sha512_finish                        -     556    =
+556
                 mbedtls_sha256_finish                        -     484    =
+484
                 mbedtls_sha1_finish                          -     420    =
+420
                 mbedtls_sha512_starts                        -     340    =
+340
                 mbedtls_md5_finish                           -     336    =
+336
                 mbedtls_sha512_update                        -     264    =
+264
                 mbedtls_sha256_update                        -     252    =
+252
                 mbedtls_sha1_update                          -     236    =
+236
                 mbedtls_md5_update                           -     236    =
+236
                 mbedtls_sha512                               -     148    =
+148
                 mbedtls_sha256_starts                        -     124    =
+124
                 hash_init_sha512                            52     128    =
 +76
                 hash_init_sha256                            52     128    =
 +76
                 mbedtls_sha1_starts                          -      72    =
 +72
                 mbedtls_md5_starts                           -      60    =
 +60
                 hash_init_sha1                              52     112    =
 +60
                 mbedtls_platform_zeroize                     -      56    =
 +56
                 mbedtls_sha512_free                          -      16    =
 +16
                 mbedtls_sha256_free                          -      16    =
 +16
                 mbedtls_sha1_free                            -      16    =
 +16
                 mbedtls_md5_free                             -      16    =
 +16
                 hash_finish_sha512                          72      88    =
 +16
                 hash_finish_sha256                          72      88    =
 +16
                 hash_finish_sha1                            72      88    =
 +16
                 sha512_csum_wd                              68      80    =
 +12
                 sha256_csum_wd                              68      80    =
 +12
                 sha1_csum_wd                                68      80    =
 +12
                 md5_wd                                      68      80    =
 +12
                 mbedtls_sha512_init                          -      12    =
 +12
                 mbedtls_sha256_init                          -      12    =
 +12
                 mbedtls_sha1_init                            -      12    =
 +12
                 mbedtls_md5_init                             -      12    =
 +12
                 memset_func                                  -       8    =
  +8
                 sha512_update                                4       8    =
  +4
                 sha384_update                                4       8    =
  +4
                 sha256_update                               12       8    =
  -4
                 sha1_update                                 12       8    =
  -4
                 sha256_process                              16       -    =
 -16
                 sha1_process                                16       -    =
 -16
                 hash_update_sha512                          36      16    =
 -20
                 hash_update_sha256                          36      16    =
 -20
                 hash_update_sha1                            36      16    =
 -20
                 MD5Init                                     56      36    =
 -20
                 sha1_starts                                 60      36    =
 -24
                 hash_update_sha384                          36       -    =
 -36
                 hash_init_sha384                            52       -    =
 -52
                 sha384_csum_wd                              68      12    =
 -56
                 sha256_starts                              104      40    =
 -64
                 sha256_padding                              64       -    =
 -64
                 sha1_padding                                64       -    =
 -64
                 hash_finish_sha384                          72       -    =
 -72
                 sha512_finish                              152      36    =
-116
                 sha512_starts                              168      40    =
-128
                 sha384_starts                              168      40    =
-128
                 sha384_finish                              152       4    =
-148
                 MD5Final                                   196      44    =
-152
                 sha512_base_do_finalize                    160       -    =
-160
                 static.sha256_update                       228       -    =
-228
                 static.sha1_update                         240       -    =
-240
                 sha512_base_do_update                      244       -    =
-244
                 MD5Update                                  260       -    =
-260
                 sha1_finish                                300      36    =
-264
                 sha256_finish                              404      36    =
-368
                 sha256_armv8_ce_process                    428       -    =
-428
                 sha1_armv8_ce_process                      484       -    =
-484
                 sha512_K                                   640       -    =
-640
                 sha512_block_fn                           1212       -   -=
1212
                 MD5Transform                              2552       -   -=
2552

And to start with, that's not bad. In fact, tossing LTO in before mbedTLS o=
nly changes
the top-line a little:
   aarch64: (for 1/1 boards) all +5120.0 bss -16.0 data -64.0 rodata +200.0=
 text +5000.0
            qemu_arm64     : all +5120 bss -16 data -64 rodata +200 text +5=
000
               u-boot: add: 19/-18, grow: 11/-7 bytes: 14696/-7884 (6812)

But, is there something we can do still? mbedTLS is a more robust
solution and I'm accepting there will be growth. But still the
process/start/finish is much larger. Is there something configurable
there?

--=20
Tom

--6Nw07KzWTCDIfRAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmar9AsACgkQFHw5/5Y0
tyym0gwAuewOl9arCEw85IgLSSDXPLFArNzHajf2RXxPCZnw8BDQfztqdGM9jtV1
7Bka7GjP9xAiCQU6k1cBOSACl1jVa3Npx1SzmiQ6iZxP/8lR+nmjNan5KgQRiL2g
q/xXR2SZxQT3dS+iPt/Pv4+2Fyq32myGopxtPcBnOGIGPk9xPBpAlloS+2MLZYlG
2UFjLoNLs20mTiEtrAJNbuxKzAOX5YVhKR+h3oMuiED8bOUsJ/bSm612HtDc7Gk1
cpRqvN/NsEdVTV+28DHt1RnYnQ9HIvhi3d9yWEM/glomUD5Ep2nJZOYQbznSU3JC
KVi8IF2qDON+b3FDTdipsbTsOQngr0CeUa+RHj0cF2BsnuGK3d3m32WQV1qO6din
wEJqi3wmZNOttJPdpij5QgtrTc7yaPH4HI4H0IurjfrVpYZGc6GF5nTylmdUikUF
Bphh2HPQ7SmbAdBUosTMmxHL8kvQR9P0jWDepza6DjHi3RIpvCdLoBYwx0MpJOf1
l41e8kmf
=NMXB
-----END PGP SIGNATURE-----

--6Nw07KzWTCDIfRAn--
