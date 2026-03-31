Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89131109B47A
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 14:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175A984020;
	Tue, 31 Mar 2026 16:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwrMjiPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786EB84035; Tue, 31 Mar 2026 16:42:42 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6977883A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 16:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-953aacb9d78so976082241.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 07:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968158; cv=none;
 d=google.com; s=arc-20240605;
 b=Te11QREPNE9u7UWZu/03lHEse7xFYI32tbHzDd22Rj2dB3Zu4RUpx8LJiABVHo8GnD
 YpvrJAxHr3qfZHRnhN8iRW8j36dlxNIheFlU2/zfKaeJmB5aAntKHm11lf+rdjXs74UD
 nQa/suOFdtX7ihSpW9SwQXyk8WW8ZEypsjzfHsbwpvA0AuwCqZfHHYXy2BETwwrdrKqT
 2Zq/4khsUaiT2XpUr+JqTeWa3keFlOILgbYOyOh/Dear95oYmTaY4OwwWQc14rN0zswA
 mzpurwtI5civZGtvm9ZmdrMh6xc+qgruPdjwUmhdgCnHSsuNpKKuW6ROUi5SYN2SAFL3
 0yJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fyhImL97OpLEG7XTc8aaYK1kIx/vniwk+svoUiRGUGU=;
 fh=6RrXTqkjcat74eThQsuSF0ZJrqXtBY/M60tCamR96m4=;
 b=XrO/Hk6YgNcsNmV+RTuQgGeIKCeg0piWLkKqk/vtH2CSZBy0R+r5AL7bcJ14jMelFc
 x1ilWagKyvO7Mqtx11LOTD6q5bhbwr7Bi6OrBPi7Y9W2nybqKRvpBimnkIKzaVVndwVo
 zDPxXPx4Q/S2UUpcQDotHlvvnfLXNeMjtvpqyE/I126nEwTIMDoj3j2/I3xWT6Sdr9L/
 O/nkuLAqdwxstlcYc5FaAfPozC7CCwko0d1Ler88HgtodxkzCac5yc1my0ChmPRmEsOT
 qTQ0FX7HBH1g3AluhBIlhZEKoV8HBKbr9KeeGZbZyCRWewXp79Eep1EGx3OdHl/iptpV
 c08A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774968158; x=1775572958; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyhImL97OpLEG7XTc8aaYK1kIx/vniwk+svoUiRGUGU=;
 b=QwrMjiPdh+st+OoAzQijJTvk30X2dklrBFV1f9VzelY7v809k0eT8orY8YnpRZjYIq
 2NnvPvf8/yc/e/OqEMWPdTZLyqoSuJ7NHbW3HOP7zqIiKvcWs5Tl5a8RlZqfQYoeC0Lh
 F0pxic01Fn5Z7ol6m8jEmIVhmMQmufaepfhMJLi6v117JWQ1p7DLJQYqvDm+pJAtuXvL
 0MIeeYvzKxWRaPnbpyUaW8NdLS4mOk1YsVkuqUmyYU64k/3WRY/rf2C/RQguF5gzodBU
 gDACHl5C8cNrAI54B+KrSbdqUpe/VpcwDTcW0f7/mFfKJ9xlZxcgnKBQThB+sf89+U8a
 P9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968158; x=1775572958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fyhImL97OpLEG7XTc8aaYK1kIx/vniwk+svoUiRGUGU=;
 b=fKvVwql/CVZbR68xkShlchHTjVl7Q8xcg3txXAON3BQU9B6VPV5qyLACNWzOwYdT+1
 RBse1q2ITfuPU+SvdO/TV/DwuCERIupCXOIG94QXijHiCBk+olG8pVdOpySnMV85uGRL
 4nORmf0B3+IYx0NfrhmDI1GtdJBjjYP0wFQS4f2YeUbVRctHxGF9WewcL4QnEUIteb+h
 Mj03J6NMD8hQanLeTuwmwB6htb8PC0Spsjk+RMhcA+Ln9TO2t5AVIc26qH0moddo9TSj
 7nIzxeGpVLTDvo5BULEO9Huy2o9yjFSS0fDQhAKuyNH36VVyV3Yyas0KqwGR8y6079E7
 Vp4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7mQgt23/3sAHEh6MMI57dc9AjSgicDWamKFVn2O20RgWHm9DxdghaKAk3h2hqyWorVOCyVEU=@lists.denx.de
X-Gm-Message-State: AOJu0YwckslnBF/3y17DofGCZMx026VMvOsrI63NYcnMn8w6pO5dkWKZ
 JX4XuwXVDRBO1dN2tFMFTAKphkgIgEgpPEDsMrzjk6gZrymutIH8KGHFTuXrdZf8K7Hb00BmBGU
 5lHKj86jFtDWy8SRiD4DI7PPokHcWG5I=
X-Gm-Gg: ATEYQzzUmwD7JNfWCVO7eI0bKLIIZ4CAaswdYS6b6OqDLklry9TnjuXZsF4JPaq9LNo
 wVmSFt7Udhf/cBtr6tqQlDOMDrgWJCxb9Qi/gk2zy+1MTD9XWkG6owr70fLoLyH0Z2a/mBrXZID
 GhKKNcna1XV8XFmiOHNyQ6rPtCuyjkx80/ZoBsZY+V9uZConev9Pzj8/TqAa+fHygRMQnQiiPjL
 6LeaF3cDZgTCWJoMJTs8IDvub7W6sX7D3L2gXrDvYx3DhfwBD/iZneSXoO8bu2Jxw3Ny09qM2X3
 WarbP691
X-Received: by 2002:a05:6102:2b85:b0:605:26eb:cc1a with SMTP id
 ada2fe7eead31-60526ebcfa6mr3402741137.29.1774968157864; Tue, 31 Mar 2026
 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 10:42:26 -0400
X-Gm-Features: AQROBzD_u_Ryh2yv9GdLtQhoNPnmM-ruWjG45B0bn6cmY9VuHTaYVs9DrLk_VIU
Message-ID: <CAMDkj5zrHsRbJ+zXwiqvW3fWcQA_G=qxBY4Y3A3hp=WogL=bsw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] add software ecdsa support
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

On Tue, Mar 31, 2026 at 6:00=E2=80=AFAM Philippe Reynes
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
> CONFIG_ECDSA_MBEDTLS=3Dy

Same comment as I placed in V2:
As this series introduces a MbedTLS-only solution, duplicating a
CONFIG_ECDSA_SW is not necessary, you can just use
CONFIG_ECDSA_MBEDTLS when linking with ecdsa-sw.o.

Regards,
Raymond


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
>
> Philippe Reynes (15):
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
>   tools: binman: pre-load: add test for ecdsa
>   boot: pre-load: add support of ecdsa
>   tools: preload_check_sign: add support of ecdsa
>   test: py: vboot: prepare test for glocal signature with ecdsa
>   test: py: vboot: add test for global signature with ecdsa
>
>  boot/image-pre-load.c                         |  48 +-
>  configs/amd_versal2_virt_defconfig            |   1 +
>  configs/qemu_arm64_lwip_defconfig             |   1 +
>  configs/starfive_visionfive2_defconfig        |   1 +
>  configs/xilinx_versal_net_virt_defconfig      |   1 +
>  configs/xilinx_versal_virt_defconfig          |   1 +
>  configs/xilinx_zynqmp_kria_defconfig          |   1 +
>  configs/xilinx_zynqmp_virt_defconfig          |   1 +
>  drivers/crypto/Kconfig                        |   2 +
>  drivers/crypto/Makefile                       |   1 +
>  drivers/crypto/ecdsa/Kconfig                  |   8 +
>  drivers/crypto/ecdsa/Makefile                 |   6 +
>  drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
>  include/crypto/internal/ecdsa.h               |  14 +
>  lib/ecdsa/ecdsa-libcrypto.c                   |  50 +-
>  lib/ecdsa/ecdsa-verify.c                      |  24 +-
>  lib/fdt-libcrypto.c                           |   2 +-
>  lib/mbedtls/Kconfig                           |  16 +
>  lib/mbedtls/Makefile                          |  19 +-
>  lib/mbedtls/ecdsa.c                           | 141 ++++++
>  lib/mbedtls/mbedtls_def_config.h              |  18 +
>  test/dm/ecdsa.c                               |  18 +-
>  test/lib/Makefile                             |   1 +
>  test/lib/ecdsa.c                              | 447 ++++++++++++++++++
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
>  tools/binman/ftest.py                         |  31 ++
>  tools/binman/test/351_pre_load_ecdsa.dts      |  22 +
>  .../test/352_pre_load_ecdsa_invalid_sha.dts   |  22 +
>  .../test/353_pre_load_ecdsa_invalid_algo.dts  |  22 +
>  tools/binman/test/ecdsa521.pem                |   7 +
>  tools/image-host.c                            |  78 ++-
>  tools/image-sig-host.c                        |   2 +-
>  tools/preload_check_sign.c                    |  24 +
>  62 files changed, 1577 insertions(+), 123 deletions(-)
>  create mode 100644 drivers/crypto/ecdsa/Kconfig
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
>  create mode 100644 tools/binman/test/351_pre_load_ecdsa.dts
>  create mode 100644 tools/binman/test/352_pre_load_ecdsa_invalid_sha.dts
>  create mode 100644 tools/binman/test/353_pre_load_ecdsa_invalid_algo.dts
>  create mode 100644 tools/binman/test/ecdsa521.pem
>
> --
> 2.43.0
>
