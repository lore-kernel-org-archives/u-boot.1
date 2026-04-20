Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE28EF5A8A1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60997842E1;
	Mon, 20 Apr 2026 19:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lQ+YVRxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488E18430F; Mon, 20 Apr 2026 19:13:29 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB048419E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-6102bac3752so2527895137.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776705206; cv=none;
 d=google.com; s=arc-20240605;
 b=Khh9AMdWmwGgJjQXeqGDiGYlW+gt5Cuni6BaNfGLhl2OxurbT9i3nWWHxJgyLwGkvl
 ooPiS5pKx1e145LSlUF9Wbax1v66DK3UmnmsCYICAPhfbjKFQVpAS2Pzd4SfvBqBZHf6
 PR1kXAXpr4DQrJcxXitcq97x7SchZurkuk/rHHDdtQIXDX6ORWdswuWGbuT1/ehLC1ZR
 1LDt4M0/+ubqNHVoTybyivd/hEOx6+xmsfvXMSrbxqe8qm1F3m+THEvCooN1+hYkaT/i
 eS4QUjYxtPsNo0NtcSRsTI4b+CNLQEd4NoAs/v8q1SMLQbjY30TuMiZyd5o3Cd3zy21V
 KhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZqoGMDwSX7LaU0i6wEkhP48iZgpKySb1iU5CihQtDH8=;
 fh=ZQCni4AQQQR19bbjvDTjIK+Rh6IKTeCpbTQI3cSQZYU=;
 b=lnHJOubvKHvEb13zEHZ3Gc56WHoQk6qyM9M9dKIiviWVRlX93oYSV/PHvwOMvBu2rg
 zj0VmmOrjI3Ynjq2dyieK7xYcYrE1R2welOmfleuj3EJR1NYHJukqwB69YEWuzX7OZCV
 Kq1yFlgHHOmSK6pZjrM6/NkSaXLVBLFwGu0RDKlbgc6iFcMr5Le2ftTSBjAeNrsxYGSy
 mOyTOWLPUBpRnlGVBh7fybtE5uYewlq4naR0kxrgbpb7/EcH7bK6y6tFJg8lvBQxQeAA
 8Tm6d1T6VVqE8FZVJkhLXJNUclALwmN2JZVM0N6zbXBfZYryrb2suSbBJpJd/9vyb9Qt
 /SPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776705206; x=1777310006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqoGMDwSX7LaU0i6wEkhP48iZgpKySb1iU5CihQtDH8=;
 b=lQ+YVRxjdmidh2VuMFIyXjLa9DkO4KvJ1AsHBNr1mOIf1QACaVxrD0DgMHjsilHqaD
 ruiu3tTpD8b/GkgMU24uoOQMv6MpinNRxmpuTtSQ+j1KS1auQfjEIfbJeExfG56EmEMo
 XQ6aMs5nXUxjadeOCmlWG5iXyBG8dzvFzTBd4zECNnxV2PYd130CTlXEk7XMgEvEEEXm
 B/Gynylydt31e+11vnv1S1db8bTCCCFqaiTlmNAOeOTQuTvShtaaTTkCpgAby3YZWPe7
 cbMYvl8pwXpTEn5K7XZ/sqR3drY1yZv9XrL3dQ617fSWHvpjx0s2UJMezQD7P+2LhDxH
 Q/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776705206; x=1777310006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqoGMDwSX7LaU0i6wEkhP48iZgpKySb1iU5CihQtDH8=;
 b=Pyup1sd4vDeHebxaFpjz6WanYh3yl/aJDinBTzk6GG4D+zqSe52ULp7LXWrJbUXiJp
 krdIjJPF8BIkTidJotKAY2e584x89jGg6sG8pGbcLl5M+u3lzcoU4IX8NTp26gGoVvC0
 u8b5w/b/UrmLcwTyHGPyjNjT6oypT3JO29zF7Bs+3KVyItmzYim0e/vFJPgajfbuVjoa
 RqdJxyITb0rPDlwQJf1o3/ShI/UN/zsca/eRI2qAHW01gZ6mNuZvTgfp8wAndVTiEI1a
 yCHrZN2gTofmLnG4uOql/y9VsSXbYupqoOCLhZ7CVM9XklW5slvcK6Mq6x0g4+zD8rRg
 EWag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/f66qJvsLgSk9Cgow4SBHxvyV2PGk9bkb8PFHM+TFbPd/lf/865cGLXL8lJsYnl7kufX8WCEE=@lists.denx.de
X-Gm-Message-State: AOJu0YzdPiUa9lWa0Cl8xCLXKXTuYTe/J5jZmDWIE7I5y9WnDJ2ym8z4
 pn2tgmebrjB2pL307bcmZX/WMnpY4RmsK/74GJqh6b5gIDa11FHEGCCjUttufljYCiz7bvvfyam
 Bop0H2p+41HXDPfqziiOf3A9czsv8Wo0=
X-Gm-Gg: AeBDiesxz4QeL4oSbsq7HC3SnyEMr+KoxmeQ2djz5VKnWBleNSTMpMLLef44HSurXMD
 2yxtZeo6koJik/5rYvIT4m2TF7pr6vRwwex+XUUUI8DsLInn/pn9YSWIL64s7UpkgojUCHk3cmt
 Y4PTZJvdzfyOKwBIiE4uQqSCuN5xSDM88WgbdEtFX/N8UXSHQgBm7Raq+JAxjA3EgDxoCRPVFqu
 1xq2LYx6SYTkbHXgkBEq94JKRWSt69CtCiVt+l0gO0XsLhWZEtb3AgFzCiIjzj367mc2TPuE+Xj
 FPc684DDWtasSWJfS/g=
X-Received: by 2002:a05:6102:2c0c:b0:612:13af:f5e9 with SMTP id
 ada2fe7eead31-616f7945bafmr7341905137.29.1776705205650; Mon, 20 Apr 2026
 10:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 13:13:14 -0400
X-Gm-Features: AQROBzBVUd_2I-ZB0cOalW74VDgUdwWhJtzeq_-u6NLMuN0K9iGQBHJt6IVOtVU
Message-ID: <CAMDkj5y2tqyx2ZXbsup_OqcTG36L0g+PSE_90W0zUxBuKAH4pQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] add software ecdsa support
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On Fri, Apr 17, 2026 at 9:02=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> This serie adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>
> To add the support of ecdsa with mbedtls, I have:
> - enabled ecdsa in mbedtls
> - add a function sw_ecdsa_verify that uses mbedtls
> - add a driver sw_ecdsa that call sw_ecdsa_verify
>
> I have tested this code with sandbox, and I have
> followed those steps:
>
> 0) build u-boot using sandbox_defconfig and adding those options:
> CONFIG_ECDSA_SW=3Dy

I think this kconfig is already removed from v4, please double check.

Regards,
Raymond

> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>
> 1) add a signature node to an its file
>         signature-256 {
>                 algo =3D "sha256,ecdsa256";
>                 key-name-hint =3D "private-key-256";
>         };
>
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb=
>
>
> 4) launch sandbox u-boot
>
> ./u-boot -d arch/sandbox/dts/test.dtb
>
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>
> =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> =3D> bootm 1000000
> ...
> ...
>    Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
>
>
> I have tested with success ecdsa256 and ecdsa384,
> but there is an issue with secp521r1.
>
> Changes in v2:
> - move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
> - rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
> - enhance dependancies for ECDSA_MBEDTLS
> - fix support of ecdsa521/secp521r1
> - add vboot test using ecdsa
>
> Changes in v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> - check returns and remove mem leak in lib/mbedtls/ecdsa.c
> - remove useless field  *k in struct ecdsa_test_vector_s
> - check returns in test/lib/ecdsa.c
> - fix third parameter when calling sha*_csum_wd()
> - add support of ecdsa in pre-load header
>
> Changes in v4:
> - change some dependencies to enable ecc
> - use ECDSA_MBEDTLS to build the ecdsa driver
> - support ecdsa521 and secp521r1
> - add a test calling ecdsa_verify for the ecdsa class
> - merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
> - several code cleanup
>
>
> Philippe Reynes (14):
>   mbedtls: enable support of ecc
>   ecdsa: initial support of ecdsa using mbedtls
>   test: lib: ecdsa: add initial test
>   drivers: crypto: add software ecdsa support
>   ecdsa: fix support of secp521r1
>   test: dm: ecdsa.c: clean this test as software ecdsa is now
>     implemented
>   test: py: vboot: prepare integration test for ecdsa
>   test: vboot: add test for ecdsa
>   tools: mkimage: pre-load: add support of ecdsa
>   tools: binman: pre-load: add support of ecdsa
>   boot: pre-load: add support of ecdsa
>   tools: preload_check_sign: add support of ecdsa
>   test: py: vboot: prepare test for global signature with ecdsa
>   test: py: vboot: add test for global signature with ecdsa
>
>  boot/image-pre-load.c                         |  56 ++-
>  configs/sandbox_defconfig                     |   1 +
>  drivers/crypto/Makefile                       |   1 +
>  drivers/crypto/ecdsa/Makefile                 |   6 +
>  drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
>  include/crypto/ecdsa-uclass.h                 |  15 +-
>  include/crypto/internal/ecdsa.h               |  28 ++
>  include/u-boot/sha256.h                       |   2 +
>  include/u-boot/sha512.h                       |   3 +
>  lib/ecdsa/Kconfig                             |   1 +
>  lib/ecdsa/ecdsa-libcrypto.c                   |  83 +++-
>  lib/ecdsa/ecdsa-verify.c                      |  64 ++-
>  lib/fdt-libcrypto.c                           |   2 +-
>  lib/mbedtls/Kconfig                           |  14 +
>  lib/mbedtls/Makefile                          |  20 +-
>  lib/mbedtls/ecdsa.c                           | 146 ++++++
>  lib/mbedtls/mbedtls_def_config.h              |  17 +
>  test/dm/ecdsa.c                               | 104 +++-
>  test/lib/Makefile                             |   1 +
>  test/lib/ecdsa.c                              | 453 ++++++++++++++++++
>  test/py/tests/test_fit_ecdsa.py               |   2 +-
>  test/py/tests/test_vboot.py                   | 143 +++---
>  .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
>  .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
>  .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
>  ...pss.dts =3D> sandbox-binman-rsa2048-pss.dts} |   0
>  ...-binman.dts =3D> sandbox-binman-rsa2048.dts} |   0
>  .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
>  .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
>  .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
>  ... =3D> sandbox-u-boot-global-rsa2048-pss.dts} |   0
>  ....dts =3D> sandbox-u-boot-global-rsa2048.dts} |   0
>  ....its =3D> sign-configs-sha1-rsa2048-pss.its} |   0
>  ...sha1.its =3D> sign-configs-sha1-rsa2048.its} |   0
>  .../vboot/sign-configs-sha256-ecdsa256.its    |  45 ++
>  .../vboot/sign-configs-sha256-ecdsa384.its    |  45 ++
>  .../vboot/sign-configs-sha256-ecdsa521.its    |  45 ++
>  ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
>  ...ts =3D> sign-configs-sha256-rsa2048-pss.its} |   0
>  ...56.its =3D> sign-configs-sha256-rsa2048.its} |   0
>  ...84.its =3D> sign-configs-sha384-rsa3072.its} |   0
>  ...s.its =3D> sign-images-sha1-rsa2048-pss.its} |   0
>  ...-sha1.its =3D> sign-images-sha1-rsa2048.its} |   0
>  .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
>  .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
>  .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
>  ...its =3D> sign-images-sha256-rsa2048-pss.its} |   0
>  ...256.its =3D> sign-images-sha256-rsa2048.its} |   0
>  ...384.its =3D> sign-images-sha384-rsa3072.its} |   0
>  tools/binman/etype/pre_load.py                |  76 ++-
>  tools/binman/ftest.py                         |  50 ++
>  tools/binman/test/ecdsa521.pem                |   7 +
>  tools/binman/test/security/pre_load_ecdsa.dts |  22 +
>  .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
>  .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
>  .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
>  tools/image-host.c                            |  79 ++-
>  tools/image-sig-host.c                        |   7 +
>  tools/preload_check_sign.c                    |  29 ++
>  59 files changed, 1810 insertions(+), 135 deletions(-)
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>  create mode 100644 include/crypto/internal/ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>  create mode 100644 test/lib/ecdsa.c
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
>  rename test/py/tests/vboot/{sandbox-binman-pss.dts =3D> sandbox-binman-r=
sa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-binman.dts =3D> sandbox-binman-rsa20=
48.dts} (100%)
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dt=
s
>  rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts =3D> sandbox-u=
-boot-global-rsa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-u-boot-global.dts =3D> sandbox-u-boo=
t-global-rsa2048.dts} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha1-pss.its =3D> sign-configs-=
sha1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha1.its =3D> sign-configs-sha1=
-rsa2048.its} (100%)
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>  rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its =3D> sign-c=
onfigs-sha256-rsa2048-pss-prod.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256-pss.its =3D> sign-config=
s-sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha256.its =3D> sign-configs-sh=
a256-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-configs-sha384.its =3D> sign-configs-sh=
a384-rsa3072.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1-pss.its =3D> sign-images-sh=
a1-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha1.its =3D> sign-images-sha1-r=
sa2048.its} (100%)
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>  rename test/py/tests/vboot/{sign-images-sha256-pss.its =3D> sign-images-=
sha256-rsa2048-pss.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha256.its =3D> sign-images-sha2=
56-rsa2048.its} (100%)
>  rename test/py/tests/vboot/{sign-images-sha384.its =3D> sign-images-sha3=
84-rsa3072.its} (100%)
>  create mode 100644 tools/binman/test/ecdsa521.pem
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_alg=
o.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key=
.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha=
.dts
>
> --
> 2.43.0
>
