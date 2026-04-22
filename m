Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8EFF9EDF6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD323842A2;
	Wed, 22 Apr 2026 16:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LhecCMDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5300B842CE; Wed, 22 Apr 2026 16:54:17 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD88584255
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-56739adfa1aso3923239e0c.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869653; cv=none;
 d=google.com; s=arc-20240605;
 b=H6Hh13iaN8m+EvKkfUWkVJMTvyH0lqusZVd6mEUiXSGgmaYxySGAh05RLO2KMhhfcL
 c6psPbqPMHH9j5jZvM0BD/DlYE49IQ6nCrDtYbLxuHun4BUmYy9ZmcCpM4SrCytWOUWG
 sL0bAchTjmQxxIPaIFKi11rTN4+s9bnMcb3ukhCu4onN2IBtxaJ+tkL6U5e85FO9uUvK
 Ojrr3XVKNCgbkHTR4+xDasG12FXGlnf3p9A8B25ghbRu7MU1N3jcP0ldDhcd1SwKSTvL
 SevT7dduQ6d5YExvKdyswsJP9QoLMC1+Sg+Qd5AcgTk48OEDX5+4xdrG7Vqcc04KII4S
 cqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S+G7cOczzavPHZi7D26TJNfhW2KrBp+axZdOHXAEME0=;
 fh=wkDKGLJZ5W1SwtC3XktAttNt71kHPX/j8sPw3T/QGMk=;
 b=OJxcCZPgRxHV1jRhxDolVd6HSK0va3Rvzu5IPqhGfZQORAypDH1vXeKg3C8zVCUTgM
 H5TiT3jcLRtEg/1A3LiqnpkpjClnMEMMIMD5JJ9DXr4Tia0B0mzSTB3mJCEzLfDV2H6i
 Aj/dYYHA9eNecbKreiJ7PjjsIrA5OHLWUH0i5ANn6LeDHQcA3EBcXkAY6grFqFxwZ77S
 sqkjEMnKk3XTBO91D2mdyFJmnGsDf7Znn4x6GUXoB7BBp9aP52Kz0UkMuW8OjRMF4y4Z
 mIsde/Og4w703pEYewyEPKQX2JZACbIX0kSOkV9VQmTVdlWEgsUl89dAj6P82TLQSwC1
 aJrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776869653; x=1777474453; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+G7cOczzavPHZi7D26TJNfhW2KrBp+axZdOHXAEME0=;
 b=LhecCMDCSH/oTrSjFLcFbZsFMaDKnWIotbcf4W1f7f9NikMr590gIOLRZCqbGmD7dE
 ZTUQSm/RWzQwMG17/Y+rD+Qo74VLd2N+zTcQ4FWfGm6fd43mPASYlTSsJ70wJs4boETf
 d0jtcZJSPbd8jtNP62vsMAlW8sS1CpfxiBH2QxyJy0DnqOl8aMT+JIZ48lTUsPby/VMW
 dGmcyXTSsGBkoSYQu4RiTZ54ofk3TGbHOS7DjlQS7z/vWAOXPaJmPjBS6idGlK4YazJu
 KzpbPHcMEPJYQaWrf2aS4Gje2fkhfsDJ6AV+Yj3bR2JFjOmSoaZaYMSmTMPaOV1iducs
 trJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776869653; x=1777474453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+G7cOczzavPHZi7D26TJNfhW2KrBp+axZdOHXAEME0=;
 b=eQG+Uob/RK9ZjBXg34DWBg6j0Ed7NI3gCDmhP49zei7rTPEvfx2vaVoliWxN+tu5qE
 WsTK8yUOptiBewIbtLNKU63WdOF2Vko8pjiTbLJDvVnykmTx8rxAt+bCuNZEn2mGPab8
 AAIs9SuTqxVrBed8SYJAWBInT9KBj3jWkSkNgkLN9KoHlR+8n7qSDdJi5rIOGg/fq0U+
 eaBpKQ+MgkhGFXUa3YYhlRXEOMjqTkPHQAJGxdmbngNHaOGb/4AnHkHhvgMoYjWuKRnC
 JCAPGD57Ba2aF6UZ7Kx1jxlJGVtXPsvNl/sm46hZ4sUgdLh7KAMTv13e8pSLj20yd2Ts
 0MBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aQrnSr4DW7BnRXVN9bxzzspgW1/UlEwrGdvidKQC1sVOAXTrndV1iHJj9XP0UcotDPlA9kp4=@lists.denx.de
X-Gm-Message-State: AOJu0YyjbM6cxGk6ORfs5invOioxnnDrWN7EckStsdfjfC2yoFQJf8zQ
 sg5TcOB1nlzVEvX2RCKbo+V4/seVWHfcbFr9Bo5FE/EKV+yS4M2iLJsIicBkGmSTdyYw2759WYA
 5emPESTYubDh9Fm4QqGIUPFUnQcN4y9c=
X-Gm-Gg: AeBDietS+cKkG7OJ5dP5Lm2VNg49e+8huqsVOJV7qAj6OpLFhHyim+6zTzfTxJhvtlz
 359PR6/PagWpM8eb9LLd9CHeofzHDb1SWKnYyzVi2wNOG4dHYHn+fLfEDrU55h0/EPbCMNjaQx9
 qT+bs1sBqcjhS7UJDb0hm5UVBluqC6wN2KFKTuuQ8lhJl1Z1JkM4JoP5ZMgjdJuPr0h7lESZg3Y
 IN8pTgI38Xb+OBjXK7qybx0cgXQFDpJCLfeunHKOF3OBkEBW1FAA+u0cTTJ62tft/7C30adtT37
 sJrVZBsvTJjQmbSTwBY=
X-Received: by 2002:a05:6122:247:b0:56c:e871:31a8 with SMTP id
 71dfb90a1353d-56fa58cb67fmr12126805e0c.7.1776869653567; Wed, 22 Apr 2026
 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 22 Apr 2026 10:54:02 -0400
X-Gm-Features: AQROBzA8XEtuToWxGxyBHe5a1yJYv68PV56rwgtsreBH0hByXzuFuRAZrs93VZY
Message-ID: <CAMDkj5x-iYL=cDm+L2cZVCCkAN+yGPbMoni7UxfDCir3nWSHhA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] add software ecdsa support
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

On Tue, Apr 21, 2026 at 5:10=E2=80=AFPM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> This series adds the support of ecdsa with software
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
>
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
>
>
>
> Changes in v2:
> - move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
> - rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
> - enhance dependancies for ECDSA_MBEDTLS

s/dependancies/dependencies

Regards,
Raymond


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
> Change in v5:
> - fix ecdsa 521 in the first patch (instead of the 5th patch)
> - mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
> - fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
> - avoid hardcoded value for ecdsa sig and point size
> - check pointer before using them
> - free ecdsa keys when key are not found/used
>
>
> Philippe Reynes (15):
>   ecdsa: fix support of secp521r1
>   mbedtls: enable support of ecc
>   ecdsa: initial support of ecdsa using mbedtls
>   test: lib: ecdsa: add initial test
>   drivers: crypto: add software ecdsa support
>   test: dm: ecdsa.c: clean this test as software ecdsa is now
>     implemented
>   test: py: vboot: prepare integration test for ecdsa
>   test: vboot: add test for ecdsa
>   tools: fit_image_setup_sig: set required_keynode to -1
>   tools: mkimage: pre-load: add support of ecdsa
>   tools: binman: pre-load: add support of ecdsa
>   boot: pre-load: add support of ecdsa
>   tools: preload_check_sign: add support of ecdsa
>   test: py: vboot: prepare test for global signature with ecdsa
>   test: py: vboot: add test for global signature with ecdsa
>
>  boot/image-pre-load.c                         |  53 +-
>  configs/amd_versal2_virt_defconfig            |   3 +
>  configs/qemu_arm64_lwip_defconfig             |   3 +
>  configs/sandbox_defconfig                     |   1 +
>  configs/starfive_visionfive2_defconfig        |   3 +
>  configs/xilinx_versal_net_virt_defconfig      |   3 +
>  configs/xilinx_versal_virt_defconfig          |   3 +
>  configs/xilinx_zynqmp_kria_defconfig          |   3 +
>  configs/xilinx_zynqmp_virt_defconfig          |   3 +
>  drivers/crypto/Makefile                       |   1 +
>  drivers/crypto/ecdsa/Makefile                 |   6 +
>  drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
>  include/crypto/ecdsa-uclass.h                 |  15 +-
>  include/crypto/internal/ecdsa.h               |  39 ++
>  lib/ecdsa/Kconfig                             |   1 +
>  lib/ecdsa/ecdsa-libcrypto.c                   |  92 +++-
>  lib/ecdsa/ecdsa-verify.c                      |  75 ++-
>  lib/fdt-libcrypto.c                           |   2 +-
>  lib/mbedtls/Kconfig                           |  14 +
>  lib/mbedtls/Makefile                          |  19 +-
>  lib/mbedtls/ecdsa.c                           | 146 ++++++
>  lib/mbedtls/mbedtls_def_config.h              |  17 +
>  test/dm/ecdsa.c                               | 107 +++-
>  test/lib/Makefile                             |   1 +
>  test/lib/ecdsa.c                              | 456 ++++++++++++++++++
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
>  tools/binman/etype/pre_load.py                |  78 ++-
>  tools/binman/ftest.py                         |  52 ++
>  tools/binman/test/ecdsa521.pem                |   7 +
>  tools/binman/test/security/pre_load_ecdsa.dts |  22 +
>  .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
>  .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
>  .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
>  tools/image-host.c                            |  93 +++-
>  tools/image-sig-host.c                        |   7 +
>  tools/preload_check_sign.c                    |  30 ++
>  64 files changed, 1877 insertions(+), 136 deletions(-)
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
