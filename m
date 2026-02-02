Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F117E7DF1A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 19:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F2383E76;
	Mon,  2 Feb 2026 20:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m5G3m3Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1155D83EC8; Mon,  2 Feb 2026 20:09:23 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3F083E69
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 20:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-948ba5ccf54so919993241.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 11:09:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770059359; cv=none;
 d=google.com; s=arc-20240605;
 b=VY48LiCaHA5z8GVktNmudevDSFN/LUiF9F/rTNU2n6xxegEj0IyausnBY/0E5rVk67
 YpD07beArulDyQoZaLYhrlmfh97AhcuOWa1w63jycMuPZJ7aohsnigU1VMN5TNL2Ett1
 4mQWbvl+qXDHyam8XONjbQPcwSPpWRZRuepyi4pNsYu6RtOv8kTwL50raaZenS169SZs
 s5zPPcEnGARGIAV5WTWcS4QIlLfdJmAtmDWjFcHeMIuGBqul9s0KTkCGGGJsaAqL29Ew
 YNpqJxas1SXdd3QcB+mRRCKcsNBEatpuyyD/3EPaaTU5bsAK0rjEw8ra5Qo6cjmUOlEE
 ie6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=636Nt5FsDOJsP0UNoOXmTzQFXKcKQyKoU+oMZP4hXZ0=;
 fh=4K556WZTFD9Ha3MgeEZO9JmBFcN0bFURshodY8wtXm4=;
 b=HKJQDB2n6hXOAp1Kc0UtB4TkUoU7BgjlzK5IngCR6cwQjhYDEeDCOv0qxeD4tw/0TB
 txMe5fGlRbG9s9yjuUaqq6JYmiQYBAeL0YPRlwZx1ilcwrKqlwmtJBP8jXQMQ6HLezQo
 Tpz0rbrC03+QSWt2Mf81VX0lElTTZj6oM4Xis86b+RRAU+9TySseX2Xa9F1TNtXNHkta
 z0gELDwaLbu/1qAQwmNYVFaqweEiEmvEour7sqcWY7WOWKT8ZWVC+8xCrPYvvflAkF/X
 S8IseM/PH1NVYIUQqYhBVkdY/IOrP7fM+Nz2Iuo1dcai3d9JLeoJjz4UurnBIqq+btSg
 tFRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770059359; x=1770664159; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=636Nt5FsDOJsP0UNoOXmTzQFXKcKQyKoU+oMZP4hXZ0=;
 b=m5G3m3Dg8E6c1yZxFYhaMiaxzUDmhnb6+OEqvWe2kBbLCMjtXTC+qo33ZQmW5//7r1
 xqZwP7eSEt+8oIQNyQlxZ1c1RMtKSJo3W0hEvdpzVSgZZR5SJLUohRMC1XpCPsml7R9g
 lrcqOIu1ztUW/j5fYghc42/quEvWcsR+U4fgQZXxs1MuYLmo5Not/TjdJN7gS/IVj7eo
 mV1eJAlXHo3uMzjVErdR9yfjLup4CcWnGdZM62IpxpW43Aup51r/0Di2kj5r7qu8nAbF
 /sK5eFSaihO4RIW5DtFZR/06TrLDCxtWzEsyWQWrGUQ1ASPQlbN8zawFGwtZfl1NROTi
 UamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770059359; x=1770664159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=636Nt5FsDOJsP0UNoOXmTzQFXKcKQyKoU+oMZP4hXZ0=;
 b=fkZQvPohHbX3TaAe2DFTOYX3/qT+YAzKeE0NcLUuo5FsWmxv+E7eHAVHwXsCYzg25P
 DLfYYMhEUyPD9YLUbG27HSKEEqdChEr0OV9uNZBeVdEAFLl+yDJ1rS0HMxTeUaVGtJzA
 8DdOq/q+vKbvKcnMeKo4lAXv2sujja7Q70BL8Uel573OQjz8nCkbz7a1MfhihwCqvqjr
 0aJS4OCULO1hG4R8NkWVRnZcgbUJOMD2Yy00DKHBlo+SexLHS9ajuMtgrPuJsjfX/ysW
 xFYymhszi0lzF2HCIxWhpp9YBljzO//KMCGwWfmd6bH4apAEP8S7NAgexhH/2h+Ta/Lf
 eD4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEok0nC185hH6My8rOZJ6Ue0Ba6+N29PpwE5qfFW6Wyq+UhojDBss4+svIdMbade5BDjy+xbg=@lists.denx.de
X-Gm-Message-State: AOJu0YyoMFWkh5my6sIbZ5vM11W/9enF4GmUlfV2+YOkOKti8M8DH2qA
 T9OZ9a1JlBeMO+A6U2qRawKY3N6A3TwI/Y706U8XDDsXLL0YCbS/fy/7j12MpcTQ5dDouhEKY/h
 6jy2aEE3C1vYlbCsA6AArFNd7RfjtZCo=
X-Gm-Gg: AZuq6aK0hVSZS74RWMQDU1ZdwX96KfjxFFQelynAXfaqRs9rOQCbGvMZhiTbQUtxXqY
 VwQKO7n/ZA3L7igQVEGx0buEvnNvbxET0vSuP3bcBJvy66VM19Aguc7ju/mfEfkJY12yCMXzfep
 yX1ZfKywJ2QC9gH7yxR95JDPvLVuiINDTeTwlwMjxE6zxcI4L3xj7Zo16G2yqJuegEeI5fGdlAI
 46K4t6Vyx2AurJJPNLSszDkKlOMZ8K6VvAPgnwjfqOA+sP41ldr1Khr6HdSnwR8kgWWyjra
X-Received: by 2002:a05:6102:3749:b0:5f1:6c5d:9b28 with SMTP id
 ada2fe7eead31-5f8e24c2019mr4036350137.15.1770059359303; Mon, 02 Feb 2026
 11:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 2 Feb 2026 14:09:09 -0500
X-Gm-Features: AZwV_QhcoHMPVr30dB-OcDid0QKUhHPztCWpGULtlh4SRcy1bju2Jv7vn_7sKDw
Message-ID: <CAMDkj5wmhno4X4ASNwwdqQmi-EnZDq9JWQfAJU+p2pGNK1MW+A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, u-boot@lists.denx.de
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

On Mon, Feb 2, 2026 at 12:05=E2=80=AFPM Philippe Reynes
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
>
> Philippe Reynes (4):
>   mbedtls: enable support of ecc
>   ecdsa: initial support of ecdsa using mbedtls
>   test: lib: sw_ecdsa: add initial test
>   drivers: crypto: add software ecdsa support
>
>  drivers/crypto/Kconfig             |   2 +
>  drivers/crypto/Makefile            |   1 +
>  drivers/crypto/ecdsa/Kconfig       |   6 +
>  drivers/crypto/ecdsa/Makefile      |   6 +
>  drivers/crypto/ecdsa/ecdsa-sw.c    |  33 +++
>  include/crypto/internal/sw_ecdsa.h |  14 +
>  lib/mbedtls/Kconfig                |   8 +
>  lib/mbedtls/Makefile               |  10 +
>  lib/mbedtls/mbedtls_def_config.h   |  18 ++
>  lib/mbedtls/sw_ecdsa.c             |  94 ++++++

Rename it without the "sw_", from the perspective of MbedTLS, HW
acceleration is controlled by `MBEDTLS_ECDSA_###_ALT`, so the
interface itself does not imply SW.

Regards,
Raymond

>  test/lib/Makefile                  |   1 +
>  test/lib/sw_ecdsa.c                | 445 +++++++++++++++++++++++++++++
>  12 files changed, 638 insertions(+)
>  create mode 100644 drivers/crypto/ecdsa/Kconfig
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>  create mode 100644 include/crypto/internal/sw_ecdsa.h
>  create mode 100644 lib/mbedtls/sw_ecdsa.c
>  create mode 100644 test/lib/sw_ecdsa.c
>
> --
> 2.43.0
>
