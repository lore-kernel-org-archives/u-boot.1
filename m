Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817B1C56201
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 14:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05EF83AC5;
	Fri, 20 Feb 2026 15:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="An+nrdKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F2883C39; Fri, 20 Feb 2026 15:59:06 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727F883936
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 15:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-56637565faaso1786518e0c.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 06:59:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771599540; cv=none;
 d=google.com; s=arc-20240605;
 b=X2Sce2dW6Osd5xbz5H1+i/X3jiF8Pt5+nBrsmtGPB1Hx3lSoOyfL4bqE10EN3o399W
 rvriNZIaMusjqbnqh+msLKSWNVNUzmtPi8tF6aUmfsnueFChCalc9iXEZAvPj9t8kQm5
 N5Ge6wO4luldei+ieYaRbSq/cTJiU7Qvi/6INcf/daeYE6e9XdoMN2aUbasdr1GNWQBZ
 A3mpSmudmy8xj42HWX0Id+gld3pSbQMvdFvb5+hyAggwXe4OmV6445KtBvlU5GK9Yq8O
 Z0pg8aCk2VklLWeOF8JZgcQZGVPkIU9+TgZkcpjbEO/4BvLwg3b83DpZreYCIt7oOZI9
 V2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RV0TK/9p/gok8+cl6Sp4djXLdN3xWzgRDGxk3an4Qk0=;
 fh=N2s3+OhRCnJ5yLXeGeQM67cAnkqUx2GyLCvuETsDdzI=;
 b=RHsrQWm6BYsjbmKu1mXNINWF2y3jwQNlHppM74+y3VsUxjOVUigZXKMbesWYCx69jE
 Mntr/AOX1ur95PUonDMFn8uzQxRPOY0tdxuPjpQ87ERPVv0lZPXftEZZ7AxXVel4359m
 l0SzspOVe8sOUuwb5r/PyW95tTo8lL1r3R6dfgSwpUtmNKDLvvgZ0NK85+eXtL66pkQn
 +a1202e/tpj0llcv5l+5juU6pzF7PV7DF0rMX13t0g/rLGMuIs88pD8txQqEv1jgRlEY
 12kgdkpjoC+ik5pkm8pFSzyGYDyIrREia+IKs+4BtZoRq6GE87Fx7xEXIiZq6Jab/KHg
 NTuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771599540; x=1772204340; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RV0TK/9p/gok8+cl6Sp4djXLdN3xWzgRDGxk3an4Qk0=;
 b=An+nrdKZ9mil8Nb3OvCQe95j44GoCKAiq1hEEKpaaC/Wzthm7yPjA37QQIo35Ybt/7
 a2LBWQKSHv6McAc+Ll+90etZVphkXHYorPw/mCqJJXUO584H6LzjaGFD1iMtjR0eyJ6L
 gv/hZ2G98dWRqdAJUHsUG4u011kAVkEt+xWhwuTrwnTmBoS/2uBk3CCLNvJN3493sJ4I
 umubU+72myUaRvZZcbpPg4whPiRUX5LoeG7rsV80j7AF6eCrnTN0b56SxWV28KYh4uZm
 MsSWNS1OEmenCxg0S0v6fi4uFACLPE3yYtePEOOQ7QbmNB/8o5riYFS4diaCf5Oueco/
 VyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771599540; x=1772204340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RV0TK/9p/gok8+cl6Sp4djXLdN3xWzgRDGxk3an4Qk0=;
 b=kSDALULogL6+QSsOaERIiL8hLnd9W7BX9G6uPbsZjt++sa2mzDa6d9QHfEGZ6r2UtY
 YHSVAfTNyqMl793ThqVjfh3vG4X7ldlSMq3QIZi8MqQ3+XchZ/B0Xe84I48CIjDO38qH
 LY04BzPrCHvOJBUsu/gm50JiifmB1l2I5bBUvc/ZO3jeUbCqhfvbcASuprIXqypzWMXW
 msTG66kq4xSkaNYAx371jZs+uyxLkWa28rGfdmgkCexQrDi5mE5t3Lr+ySVj2nLt94ok
 +GLcOqrOG49SOJ5j+2PYDTCPkVxS/ZllHFGqQhlUGvpmqPlRGFYEQYM7Q3UvCL2lNrPZ
 cY7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZm0FKHTd1VH3cjBfdLzqPmjjieNWSOCRTzdSonWhvk8wEtPo2JqMVrskgmAkGm+AjikhUwUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy441ybuwjGkYNzBs9k3igS6F4meGDHbgNd8ZW1902Ab/2EqMse
 76int9x7WQ2s5ckdv2yPC0kC2r9MQqZwW9D2IpykFeqXxlnZoH5nFGvxBCv6qNFpifhHCkC65du
 QVKUddjVUxRaMf7XHH6tgX5s40kXL2sk=
X-Gm-Gg: AZuq6aKQqPEMHPf981jBb8VQeacT6byQduzpRfX75DebiTeqgrg2YW53XIgXSGFDa5M
 BNep7ygSoa0Fov0W1RHkKzx0QsA1FcrM6jnjNVEpdvYSTrxwuLZkgEozHXwtBWSYZf53+u1L/hX
 r7EXsCfHvu8ssbtUha6YPQMNL6PYQttr2Z4Y0bRx/Bln0S3yr0TKHrueu/1UpFkcpMAlSSFiIsp
 xsLttUAeviYZEmvjRloATYUMR997Yptln7ZrY3bXZ1OIMh6kp1Zowz/HPi6bhMqITz+tPuyBv0Q
 9lgRXIUD
X-Received: by 2002:a05:6102:41a8:b0:5fe:f14:e701 with SMTP id
 ada2fe7eead31-5feb307ab47mr29807137.24.1771599539962; Fri, 20 Feb 2026
 06:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 09:58:48 -0500
X-Gm-Features: AaiRm50f5cI-3tJikcsJE87ddlaZeJw_K7FUAytpVRQnoTqyAAugFHF5DfdZ-PI
Message-ID: <CAMDkj5yPfC=sdD8feU-sWVd4ok9D1045C+VVxn7Z5smKSyaikw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] add software ecdsa support
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
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
>
> Philippe Reynes (9):
>   mbedtls: enable support of ecc
>   ecdsa: initial support of ecdsa using mbedtls
>   test: lib: sw_ecdsa: add initial test
>   drivers: crypto: add software ecdsa support
>   ecdsa: fix support of secp521r1
>   test: dm: ecdsa.c: clean this test as software ecdsa is now
>     implemented
>   configs: sandbox: enable the software ecdsa driver
>   test: py: vboot: prepare integration test for ecdsa
>   test: vboot: add test for ecdsa
>
>  configs/amd_versal2_virt_defconfig            |   1 +
>  configs/qemu_arm64_lwip_defconfig             |   1 +
>  configs/sandbox_defconfig                     |   1 +
>  configs/starfive_visionfive2_defconfig        |   1 +
>  configs/xilinx_versal_net_virt_defconfig      |   1 +
>  configs/xilinx_versal_virt_defconfig          |   1 +
>  configs/xilinx_zynqmp_kria_defconfig          |   1 +
>  configs/xilinx_zynqmp_virt_defconfig          |   1 +
>  drivers/crypto/Kconfig                        |   2 +
>  drivers/crypto/Makefile                       |   1 +
>  drivers/crypto/ecdsa/Kconfig                  |   6 +
>  drivers/crypto/ecdsa/Makefile                 |   6 +
>  drivers/crypto/ecdsa/ecdsa-sw.c               |  33 ++
>  include/crypto/internal/sw_ecdsa.h            |  14 +
>  lib/ecdsa/ecdsa-libcrypto.c                   |  21 +-
>  lib/ecdsa/ecdsa-verify.c                      |  24 +-
>  lib/fdt-libcrypto.c                           |   2 +-
>  lib/mbedtls/Kconfig                           |  16 +
>  lib/mbedtls/Makefile                          |  19 +-
>  lib/mbedtls/ecdsa.c                           |  94 ++++
>  lib/mbedtls/mbedtls_def_config.h              |  18 +
>  test/dm/ecdsa.c                               |  18 +-
>  test/lib/Makefile                             |   1 +
>  test/lib/sw_ecdsa.c                           | 465 ++++++++++++++++++
>  test/py/tests/test_fit_ecdsa.py               |   2 +-
>  test/py/tests/test_vboot.py                   | 128 +++--
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
>  tools/image-sig-host.c                        |   2 +-
>  44 files changed, 1062 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/crypto/ecdsa/Kconfig
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>  create mode 100644 include/crypto/internal/sw_ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>  create mode 100644 test/lib/sw_ecdsa.c
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
>
> --
> 2.43.0
>
