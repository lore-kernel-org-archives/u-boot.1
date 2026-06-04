Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C653CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 06:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96ED48467E;
	Thu,  4 Jun 2026 08:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Pr4U6eyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224E284715; Thu,  4 Jun 2026 08:22:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D423C844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 08:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780554140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnkITSSmm0IeaD+k0hZADdMi/G9s3JlbasndgZ6C9aE=;
 b=Pr4U6eyO008K9Xjeg+LrcMEQRciLgXy5ZIJZ8xyFRmys6MkuAYF7/l5NYgDALaGJ9tES/M
 Lu+bEq/swBo6QwysQi+HN8iObFy2y2oZi3rxqA/yfEvP2g4E6tQqGLaW2fvKAB0D03N+97
 14BTA4tqvotMwFbcnVF8cF25F4xXg9Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ZsOk2dVwPVC33L2FgSaYxA-1; Thu, 04 Jun 2026 02:22:19 -0400
X-MC-Unique: ZsOk2dVwPVC33L2FgSaYxA-1
X-Mimecast-MFC-AGG-ID: ZsOk2dVwPVC33L2FgSaYxA_1780554137
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39672f9e6f2so275891fa.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 23:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780554137; x=1781158937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnkITSSmm0IeaD+k0hZADdMi/G9s3JlbasndgZ6C9aE=;
 b=DcZjXFnVEl2Qg/lAjh+NybKZ50icPFsHEKGj6FM/EO7t2NvTpsyq90HoocUgzd6Aaa
 8cNXPzbekTTUKNHIcv2N+ECfrTifxvFYoieroVNPqjIhUKES8ggwE5KISZSfPjHF0ikl
 reXs5EsES72sMQd+eQiX416VrLwKcYASYml5a30TR+oaUNPZYVqnE3NKrssk4cHHRRFY
 PgfH+HsnzU6yqTKEUB/Mlsut6LLpa5uJBrEkIqYaDfPftgw9lnMEFADCu8bML6KEdM5r
 9gy9Rma1P0k5otDtqb4Ai8SxFjkzjBWNhkGq0tBypcHSOWfKTfx9WxYZHqP/OK7/MAc8
 5goA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zXEpJx2pskLWtp+Z/E/5wx1PqZYsm7Ppvbfzvlg5/BrEkn+OkQJWazbPJo7NyrAI1GvZ96dg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0SiDuj4WoX1mIFV+1AW4U9PQs1ze7RNWjWQ14JS/nMUW/sBBw
 WegUPn6g6dGligOXlhCZB/Ny+6xSba3v3eA6QysNHWowVSaJJ3ybkgMIcrLCBfbUZSdg1UXLT+P
 DEK8UOydikcbfJVakF1JMLEwUMm/pEUhA0KTYnGLWIDsB95NH+4f49BF/wBHaKUboxuSstK+iBF
 gBqqF6ZUl7L6P6hCTTRKte+2v4o9kd1Ijq/H5JkQ2xiSI=
X-Gm-Gg: Acq92OGlymQkc+TY9rkRwQgDP8SrNpZEJk2aRfAmRFKhnG+FU9YNVBa6Hk6gsUpIuul
 OVF4iFp1o/5f2qvO0rof6U+3SF0TsrtkzS59H5pTQ3Ol3Qf4eoSDQaXUtYrUYTZlaNEVvRoOnRW
 rbr40jWnJ/IOG4wW23ZJ6P939KVLXkl7tsY5OpZfWOoDwZsbajfbN0agKiXiYHGVpMAVvquk9KH
 +XeXEXrWmIYpWJb
X-Received: by 2002:a05:651c:512:b0:393:a31a:ab30 with SMTP id
 38308e7fff4ca-396ad1734e4mr8673741fa.0.1780554137112; 
 Wed, 03 Jun 2026 23:22:17 -0700 (PDT)
X-Received: by 2002:a05:651c:512:b0:393:a31a:ab30 with SMTP id
 38308e7fff4ca-396ad1734e4mr8673571fa.0.1780554136372; Wed, 03 Jun 2026
 23:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
 <ag-EpjuQlre9QmYN@daedalus> <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
In-Reply-To: <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 4 Jun 2026 08:22:04 +0200
X-Gm-Features: AVHnY4L6NBf7bwKSJ9x1UnH3o11elO2Mhbv9BrWU5s1YM089TrKEHdyDYf3wpoE
Message-ID: <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>, 
 Tobias Olausson <tobias@eub.se>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t6YMaSLLBkSvjSyLPN5t2De4mbEMHM67UwjSx-KMquc_1780554137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin and Eddie,

On Fri, May 22, 2026 at 4:38=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Eddie,
>
> On 5/22/26 12:29 AM, Eddie Kovsky wrote:
> > On 05/12/26, Quentin Schulz wrote:
> >> Hi Eddie,
> >>
> >> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> >>> The Engine API has been deprecated since the release of OpenSSL 3.0. =
End
> >>> users have been advised to migrate to the new Provider interface.
> >>> Several distributions have already removed support for engines, which=
 is
> >>> preventing U-Boot from being compiled in those environments.
> >>>
> >>> Add support for the Provider API while continuing to support the exis=
ting
> >>> Engine API on distros shipping older releases of OpenSSL.
> >>>
> >>> This is based on similar work contributed by Jan Stancek updating Lin=
ux
> >>> to use the Provider interface.
> >>>
> >>>       commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >>>       Author: Jan Stancek <jstancek@redhat.com>
> >>>       Date:   Fri Sep 20 19:52:48 2024 +0300
> >>>
> >>>           sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJ=
OR >=3D 3
> >>>
> >>> The changes have been tested with the FIT signature verification vboo=
t
> >>> tests on Fedora 42 and Debian 13. All 30 tests pass with both the leg=
acy
> >>> Engine library installed and with the Provider API.
> >>>
> >>
> >> But does it actually use a provider or an engine to begin with? I don'=
t see
> >> test/py/tests/test_vboot.py calling mkimage with the -N argument. What=
 are
> >> the tests (or command) you ran to validate this? I briefly saw the CI =
failed
> >> in v3 because a package was missing, but wasn't it simply because the
> >> headers or provider libraries which are now necessary for building
> >> lib/rsa/rsa-sign.c were not present? The logs aren't available anymore
> >> unfortunately. If that's the case, then that's also an issue. We shoul=
dn't
> >> need to install providers if we aren't going to use any? Yes, I know t=
hat we
> >> currently cannot compile if we don't have openssl-devel-engine (on Fed=
ora),
> >> but if we can improve the situation, we should.
> >>
> >> How did you test (locally is fine) with providers?
> >>
> >
> > The FIT signature verification tests are documented here:
> >
> >      https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-=
fit-signature-verification
> >
> > The tests currently fail in build environments (like Fedora) that don't
> > have engine support. This is how we originally became aware of the API
> > issue last year.
> >
> >      =E2=9D=AF ./test/py/test.py --bd sandbox --build -k vboot
> >      +make O=3Du-boot/build-sandbox -s sandbox_defconfig
> >      +make O=3Du-boot/build-sandbox -s -j8
> >      In file included from tools/generated/lib/aes/aes-encrypt.c:1:
> >      ../tools/../lib/aes/aes-encrypt.c:19:10: fatal error: openssl/engi=
ne.h: No such file or directory
> >      19 | #include <openssl/engine.h>
> >          |          ^~~~~~~~~~~~~~~~~~
> >      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
> >      ../tools/../lib/rsa/rsa-sign.c:22:10: fatal error: openssl/engine.=
h: No such file or directory
> >      22 | #include <openssl/engine.h>
> >          |          ^~~~~~~~~~~~~~~~~~
> >      compilation terminated.
> >
> > Github provides the Azure CI pipeline as a free service. I wouldn't
> > expect them to retain logs at that tier.
> >
>
> As said, I don't think we are testing OpenSSL providers in test/py.
> rsa-sign.c and aes-encrypt.c can work perfectly fine without using
> engines, but currently it requires the engine.h header file to compile
> (and if missing, then the functions, macros, constants defined in that
> header file will need to be compiled out like done in this patch) even
> if it doesn't use engines at runtime.
>
> The issue is not that OpenSSL is built without engine support, it's
> rather that Fedora has decided to stop shipping openssl/engine.h by
> default. For some reason, they still compile OpenSSL with engine support
> (I don't understand why). You are fixing a build issue, sure, and we
> must fix it, but I don't think this patch is doing it the proper way. So
> I am asking again, did you test with an actual OpenSSL provider (and no,
> the implicit file: scheme "provider" doesn't count)?
>
> See
> https://lore.kernel.org/u-boot/d8b15735-0b3f-4a72-a2a2-9ac6e12f4dbf@cherr=
y.de/T/#m7454283f474aaee33736e1ae7154569da846f14a
>
> >
> >>> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>

Chiming in here as one of the folks testing this series. I'll admit I
got completely lost in the mailing list jungle trying to follow this
massive wall of messages, but I finally dug into the logs and ran some
more hands-on tests.

I think the scope of this patch was strictly a backend API migration
to unblock U-Boot compilation on distros like Fedora, not supporting
real providers out of the gate.

To verify that Eddie's patch successfully switches the underlying
architecture to the OpenSSL 3.x Provider API, I ran a local system
trace using a file-based path (-k .). The strace confirmed that the
legacy engine hooks are bypassed and the provider module is used
instead. The underlying provider plumbing itself is completely solid
for standard file-based keys [1].

With that, plus the tests passing in CI, I assumed the new backend
plumbing worked as intended. From a functional standpoint, the outcome
is identical: your images get signed securely just like before. The
only difference is the internal machinery OpenSSL uses under the hood.

But you are entirely right. I didn't test against a real hardware
engine initially, and looking closer, I agree the current patch does
break backward compatibility for anyone using a real Engine on OpenSSL
3.x.

I did a run using SoftHSM to see exactly why:

Before this patch: Passing -N pkcs11 successfully triggered the legacy
engine. The signing succeeded.

With this patch: The OpenSSL 3.x version check unconditionally hijacks
the flow, ignores the -N engine flag, and forces execution down the
Provider path. The strict OSSL_STORE_open parser receives the mangled
string and instantly fails with ENOENT because is unconditionally
appending /[key-name-hint].key.

My understanding is that to fix the Fedora build issues without
breaking existing workflows, Eddie just needs to adjust the control
flow for v4 like you suggested:

If the user explicitly commands an engine via -N, prioritize the
legacy engine path=E2=80=94guarding the engine headers and blocks with #ifn=
def
OPENSSL_NO_ENGINE instead of a blanket OpenSSL version check.

If no engine flag is passed, route seamlessly into the new Provider API bac=
kend.

This fixes the compilation bottleneck on some distros, completely
preserves legacy engine setups, and allows real providers URI
string-mangling issue to be handled as clean, independent follow-up
patches.

Does it makes sense?

Cheers,
Enric Balletbo


[1]
 $ strace -f -e trace=3Dopenat ./tools/mkimage -F -k . -K mock.dtb -r
fitImage 2>&1 | grep -iE "pkcs11|ossl-modules|\.key"
openat(AT_FDCWD, "/etc/pki/tls/openssl.d/pkcs11-provider.conf", O_RDONLY) =
=3D 7
openat(AT_FDCWD, "/usr/lib64/ossl-modules/pkcs11.so", O_RDONLY|O_CLOEXEC) =
=3D 5
openat(AT_FDCWD, "./dev.key", O_RDONLY) =3D 5
FIT description: Dummy FIT image for testing providers
Created:         Wed Jun  3 19:26:03 2026
 Image 0 (kernel-1)
  Description:  Dummy Kernel
  Created:      Wed Jun  3 19:26:03 2026
  Type:         Kernel Image
  Compression:  uncompressed
  Data Size:    100 Bytes =3D 0.10 KiB =3D 0.00 MiB
  Architecture: ARM
  OS:           Linux
  Load Address: 0x80008000
  Entry Point:  0x80008000
  Hash algo:    sha256
  Hash value:   cd00e292c5970d3c5e2f0ffa5171e555bc46bfc4faddfb4a418b6840b86=
e79a3
 Default Configuration: 'config-1'
 Configuration 0 (config-1)
  Description:  Boot configuration
  Kernel:       kernel-1
  Sign algo:    sha256,rsa2048:dev
  Sign value:
4b88172afa850fb98d4c81662b043fedfebd7db55be8011aa464570e58289cf58939ea3adfa=
fd9dd808362cfbd830fccaf806bbdc3d221922ec4e59a478a526904b1f39afa28d770b2808e=
d727825953eb8e4f1387faf3396e6f0e8d1a5be1c4b698e94e383d466371b8469638a3d3e1e=
1a3385eb4752c7554d09289face527d60262f274c8ab12ae28069a51dbce19505578e391e2f=
c25a9df915b6917cf057b5b2ecd9ede7db81a0be1cb106db801f75500562902f45fbed9df5b=
87c61cabc854cf429d25f5977813bdb239b38e27ba461b752c612068ae1dc2566d3456d2396=
828bfaea1a946b77d0479ee720574d6068409353e4554d0dd5c56f1a0a6228
  Timestamp:    Wed Jun  3 19:26:16 2026
Signature written to 'fitImage', node '/configurations/config-1/signature-1=
'
Public key written to 'mock.dtb', node '/signature/key-dev'

./tools/fit_check_sign -f fitImage -k mock.dtb
Verifying Hash Integrity for node 'config-1'... sha256,rsa2048:dev+
Verified OK, loading images
## Loading kernel (any) from FIT Image at 7f0d23b65000 ...
   Using 'config-1' configuration
   Verifying Hash Integrity ...
sha256,rsa2048:dev+
OK

   Trying 'kernel-1' kernel subimage
     Description:  Dummy Kernel
     Created:      Wed Jun  3 19:26:03 2026
     Type:         Kernel Image
     Compression:  uncompressed
     Data Size:    100 Bytes =3D 0.10 KiB =3D 0.00 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: 0x80008000
     Entry Point:  0x80008000
     Hash algo:    sha256
     Hash value:
cd00e292c5970d3c5e2f0ffa5171e555bc46bfc4faddfb4a418b6840b86e79a3
   Verifying Hash Integrity ...
sha256+
OK

   Decrypting Data ...
OK

   Loading Kernel Image to 0
## Loading fdt (any) from FIT Image at 7f0d23b65000 ...
   Using 'config-1' configuration
   Verifying Hash Integrity ...
sha256,rsa2048:dev+
OK

Could not find subimage node type 'fdt'
## Loading ramdisk (any) from FIT Image at 7f0d23b65000 ...
   Using 'config-1' configuration
   Verifying Hash Integrity ...
sha256,rsa2048:dev+
OK

Could not find subimage node type 'ramdisk'
Signature check OK


> >>> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
> >>
> >> Please do not forget to add the colon after Tested-by so it actually m=
akes
> >> it a git trailer instead of just text.
> >>
> >
> > That's an unlucky typo because I added the trailers manually.
> >
>
> It happens :)
>
> For your info, with b4
> (https://b4.docs.kernel.org/en/latest/contributor/overview.html) you can
> run b4 trailers -u (if you started the series with b4, though you can
> probably create a new branch from an existing series with b4 prep
> --from-thread?) and it'll automatically fetch the trailers from answers
> on the ML and add them to the appropriate patches.
>
> >>> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> >>> ---
> >>> Changes in v4:
> >>> - Add comment that @engine pointer is null when using pkcs11 provider
> >>> - Remove extra line break
> >>> - Add pkcs11-provider package to build dependencies
> >>> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@re=
dhat.com/
> >>>
> >>> Changes in v3:
> >>> - Removed Kconfig option
> >>> - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
> >>>       USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> >>> v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@red=
hat.com/
> >>>
> >>> Changes in v2:
> >>> - Remove default for new Kconfig option
> >>> - Use #ifdef instead of IS_ENABLED macro
> >>> - Remove comment after #endif
> >>> - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> >>> v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@re=
dhat.com/
> >>> ---
> >>>    doc/build/gcc.rst       |   4 +-
> >>>    lib/aes/aes-encrypt.c   |   4 +-
> >>>    lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++=
++--
> >>>    tools/docker/Dockerfile |   1 +
> >>>    4 files changed, 103 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> >>> index 1fef718ceecb..29a6a632e7e3 100644
> >>> --- a/doc/build/gcc.rst
> >>> +++ b/doc/build/gcc.rst
> >>> @@ -25,8 +25,8 @@ Depending on the build targets further packages may=
be needed
> >>>        sudo apt-get install bc bison build-essential coccinelle \
> >>>          device-tree-compiler dfu-util efitools flex gdisk graphviz i=
magemagick \
> >>> -      libgnutls28-dev libguestfs-tools libncurses-dev \
> >>> -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone open=
ssl \
> >>> +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev=
 \
> >>> +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-prov=
ider \
> >>>          pkg-config python3 python3-asteval python3-coverage python3-=
filelock \
> >>>          python3-pkg-resources python3-pycryptodome python3-pyelftool=
s \
> >>>          python3-pytest python3-pytest-xdist python3-sphinxcontrib.ap=
idoc \
> >>> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> >>> index 90e1407b4f09..4fc4ce232478 100644
> >>> --- a/lib/aes/aes-encrypt.c
> >>> +++ b/lib/aes/aes-encrypt.c
> >>> @@ -16,7 +16,9 @@
> >>>    #include <openssl/err.h>
> >>>    #include <openssl/ssl.h>
> >>>    #include <openssl/evp.h>
> >>> -#include <openssl/engine.h>
> >>> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_=
0)
> >>> +# include <openssl/engine.h>
> >>> +#endif
> >>
> >> Considering there are no other changes in this file, is this include
> >> actually needed?
> >>
> >
> > The header is still needed to maintain backward compatibility for engin=
e
> > support. I maintained the #ifdef style to be consistent with its usage
> > elsewhere, based on previous feedback.
> >
>
> What am I trying to say here is no symbol in the file comes from
> openssl/engine.h and I can compile the file perfectly fine without this
> header included, so we should probably get rid of this include.
>
> >>>    #include <uboot_aes.h>
> >>>    #if OPENSSL_VERSION_NUMBER >=3D 0x10000000L
> >>> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> >>> index 0e38c9e802fd..f456f3c58e65 100644
> >>> --- a/lib/rsa/rsa-sign.c
> >>> +++ b/lib/rsa/rsa-sign.c
> >>> @@ -19,7 +19,47 @@
> >>>    #include <openssl/err.h>
> >>>    #include <openssl/ssl.h>
> >>>    #include <openssl/evp.h>
> >>> -#include <openssl/engine.h>
> >>> +#if OPENSSL_VERSION_MAJOR >=3D 3
> >>> +# define USE_PKCS11_PROVIDER
> >>> +# include <err.h>
> >>> +# include <openssl/provider.h>
> >>> +# include <openssl/store.h>
> >>> +#else
> >>> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3=
_0)
> >>> +#  define USE_PKCS11_ENGINE
> >>> +#  include <openssl/engine.h>
> >>> +# endif
> >>> +#endif
> >>> +
> >>
> >> Sorry but that's a NACK.
> >>
> >> As far as I can tell, this effectively disables using engines when you=
r host
> >> openssl version is 3.0+, which we currently support (and I currently u=
se
> >> it). You can have this for 4.0+ as engine support has been removed, bu=
t not
> >> for 3.x.
> >>
> >
> > You don't get a choice here. OpenSSL deprecated the Engine API starting
>
> Providers and engines can cohabit in OpenSSL 3.x, so that is possible (I
> tested it locally with the binman test suite, with both providers and
> engines local test suites working with the same OpenSSL version (Fedora
> 44 + openssl-devel-engine).
>
> > with Version 3.0, and removed it completely starting with Version 4.0.
> > If the environment you're building U-Boot in has a recent version of
> > OpenSSL then Engines are no longer available to you.
> >
>
> This only happens because Fedora (and not Debian, or ArchLinux) decided
> to stop shipping an engine.h header file (while still compiling OpenSSL
> with engine support).
>
> I can use engines with OpenSSL 3.x, with the current state in U-Boot, so
> you cannot unilaterally decide to break that.
>
> What you can do is either remove support for OpenSSL engines entirely
> when it's factually not possible to build mkimage with support for it
> (and no, checking for OpenSSL 3.x is not enough). That is, when OpenSSL
> is built/shipped without engine support (that is, for Fedora, unless
> openssl-devel-engine is installed). Or migrate engine support to use the
> provider API (by e.g. prepending org.openssl.engine: in the OSSL_STORE
> scheme) for OpenSSL 3.x. The user API must be identical though, what
> works with engines on OpenSSL 1.x an OpenSSL 3.x with engine support via
> the provider API must be the same. I would suggest to NOT go for the
> second option as I don't think it's worth the added complexity.
>
> >>> +#ifdef USE_PKCS11_PROVIDER
> >>> +#define ERR(cond, fmt, ...)                                \
> >>> +   do {                                            \
> >>> +           bool __cond =3D (cond);                   \
> >>> +           drain_openssl_errors(__LINE__, 0);      \
> >>> +           if (__cond) {                           \
> >>> +                   errx(1, fmt, ## __VA_ARGS__);   \
> >>> +           }                                       \
> >>> +   } while (0)
> >>> +
> >>
> >> Is this really related to the PKCS11 provider? I think there's a mix b=
etween
> >> "using the provider API" and "using the pkcs11 provider".
> >>
> >
> > It's a helper macro used for the Provider path when OpenSSL is v3 or
> > later.
> >
>
> I'm arguing about the macro being called USE_PKCS11_PROVIDER while
> having nothing to do with pkcs11. It's misleading.
>
> >>> +static void drain_openssl_errors(int l, int silent)
> >>> +{
> >>> +   const char *file;
> >>> +   char buf[120];
> >>> +   int e, line;
> >>> +
> >>> +   if (ERR_peek_error() =3D=3D 0)
> >>> +           return;
> >>> +   if (!silent)
> >>> +           fprintf(stderr, "At main.c:%d:\n", l);
> >>> +
> >>
> >> main.c?
> >>
> >
> > Not clear what you are referring to here.
> >
>
> The error message would state "At main.c:" which is absolutely not
> related to any file this is called from. I guess maybe you want __FILE__
> here instead?
>
> >>> +   while ((e =3D ERR_peek_error_line(&file, &line))) {
> >>> +           ERR_error_string(e, buf);
> >>> +           if (!silent)
> >>> +                   fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, l=
ine);
> >>> +           ERR_get_error();
> >>> +   }
> >>> +}
> >>> +#endif
> >>>    static int rsa_err(const char *msg)
> >>>    {
> >>> @@ -94,10 +134,11 @@ err_cert:
> >>>     *
> >>>     * @keydir:      Key prefix
> >>>     * @name Name of key
> >>> - * @engine Engine to use
> >>> + * @engine Engine to use or NULL when using pkcs11 provider
> >>>     * @evpp Returns EVP_PKEY object, or NULL on failure
> >>>     * Return: 0 if ok, -ve on error (in which case *evpp will be set =
to NULL)
> >>>     */
> >>> +#ifdef USE_PKCS11_ENGINE
> >>>    static int rsa_engine_get_pub_key(const char *keydir, const char *=
name,
> >>>                               ENGINE *engine, EVP_PKEY **evpp)
> >>>    {
> >>> @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *k=
eydir, const char *name,
> >>>     return 0;
> >>>    }
> >>> +#endif
> >>>    /**
> >>>     * rsa_get_pub_key() - read a public key
> >>>     *
> >>>     * @keydir:      Directory containing the key (PEM file) or key pr=
efix (engine)
> >>>     * @name Name of key file (will have a .crt extension)
> >>> - * @engine Engine to use
> >>> + * @engine Engine to use or NULL when using pkcs11 provider
> >>>     * @evpp Returns EVP_PKEY object, or NULL on failure
> >>>     * Return: 0 if ok, -ve on error (in which case *evpp will be set =
to NULL)
> >>>     */
> >>>    static int rsa_get_pub_key(const char *keydir, const char *name,
> >>>                        ENGINE *engine, EVP_PKEY **evpp)
> >>>    {
> >>> +#ifdef USE_PKCS11_ENGINE
> >>>     if (engine)
> >>>             return rsa_engine_get_pub_key(keydir, name, engine, evpp)=
;
> >>> +#endif
> >>
> >> We should probably at least print something when engines aren't suppor=
ted
> >> but the engine parameter is passed, or maybe even fail as that's an
> >> incorrect configuration.
> >>
> >
> > We discussed this in a previous revision and decided the comment was
> > sufficient. The correct path will be taken depending on which version o=
f
> > the API is available.
> >
>
> mkimage will still happily accept the -N argument which sets the engine
> parameter, even if engines aren't supported.
>
> I think if you have a file key with the same name as in the engine,
> you'll then sign with the wrong key.
>
> Think
>
> mkimage -N myengine -g key
>
> and you have a key.key in the local directory. If you compile with
> OpenSSL engines supported, you'll essentially use myengine:key, if not,
> you'll use key.key, without mkimage even notifying you by using the same
> command.
>
> >>>     return rsa_pem_get_pub_key(keydir, name, evpp);
> >>>    }
> >>> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *key=
dir, const char *name,
> >>>             return -ENOENT;
> >>>     }
> >>> +#ifdef USE_PKCS11_PROVIDER
> >>> +   EVP_PKEY *private_key =3D NULL;
> >>> +   OSSL_STORE_CTX *store;
> >>> +
> >>> +   if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> >>> +           ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> >>> +   if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> >>> +           ERR(1, "OSSL_PROVIDER_try_load(default)");
> >>> +
> >>
> >> Why are we unconditionally loading providers and specifically the pkcs=
11
> >> one? As far as I could tell we should know from the URI whether a key =
from a
> >> provider is requested by checking if a colon is in the URI. And we can
> >> automatically load the requested provider based on that?
> >>
> >> Otherwise the easiest answer to this could simply be: "let the user
> >> configure this externally via OPENSSL_CONF environment variable".
> >>
> >> Do we also need to update tools/mkimage.c (and doc/mkimage.1) to remov=
e -N
> >> engine from usage if the tool doesn't support it? Do we also need to u=
pdate
> >> doc/usage/fit/signature.rst to explain how to use pkcs11 provider?
> >>
> >> FYI, we (my employer) are migrating from engines to providers for sign=
ing
> >> FIT images with binman so I'm starting to have a look on how to do thi=
s now.
> >>
> >> Cheers,
> >> Quentin
> >>
> >
> > Additional changes may be needed down the road. I'm sure additional
> > patches will be welcome. The scope of this change is to introduce
> > support for the new API while continuing to support developers who are
> > still building in environments using the deprecated Engine API.
> >
>
> But it's not doing that? This is removing support for OpenSSL engines on
> all systems shipping OpenSSL 3.x? We cannot accept patches that break
> things under the pretense there can be follow-up patches. I'm not asking
> support for signing with OpenSSL providers in this series, I'm asking
> you to not break existing users.
>
> I'm still unsure what the goal of this patch is. It says it adds support
> for OpenSSL provider API but I don't think provider support was actually
> tested. It also says U-Boot cannot be built on Fedora anymore due to
> engine.h missing. Both can be be separate topics. The urgent task is to
> fix building on Fedora, supporting providers can then be tackled later
> on (by either you, or someone else; e.g. I already have support for
> providers locally, just need to write nice commit logs and wait on what
> this patch will become here). I commented out everything related to
> engines and ran the testSignSimple, testSignExactFIT, testSignNonFit,
> testSignMissingMkimage and testSplPubkeyDtb to check whether using keys
> was still supported (meaning, we aren't forced to migrate to the
> OSSL_STORE interface for simple keys).
>
> I'd be fine with guarding all engine support with
> if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> and making sure we at least warn (or fail) if an engine is asked by the
> user but we don't support it, so that you can build on Fedora again
> without openssl-devel-engine.
>
> Cheers,
> Quentin
>

