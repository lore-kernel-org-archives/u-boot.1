Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D7C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CCE4888AA;
	Wed, 24 Jul 2024 12:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qbm/VZ0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071D3888E7; Wed, 24 Jul 2024 12:27:48 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCF9888A5
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-260dde65a68so3575176fac.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721816864; x=1722421664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XlJQcsDHbA8KlkzjqyMcGdG4FHUS77/NIg5B8roEwJE=;
 b=Qbm/VZ0DyQ3ygZzNVOc0KmbOKwhFBVoQxE4GyerCImU1k+wciL8GNLKZZzFLWh0J5L
 hub2rTPGPXpinz4dCqBxrUXjKkdDH8lSmINbmBWwNQvt9Flw+SI98VuZE2spk7HWIr+u
 /nUbJ93eWrvE9Qc1DKQ+33Gj+vfCOPoRCV8U3PST2ZJeNF/E+brV7RiUjbG5L2fG9JS7
 EzpntuVJPJdTWAma/b9eQwg2I/CP5EDM4OvblCWVqPSD30cRCRWkyhFu3gSw4LS7OGOu
 3+KigLyxNRWh5TFfPqPgaBiXoCc0NdnDQYfvYyJvKgRG4wBoDmGkBylZnQXgs/mbYIbD
 avLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816864; x=1722421664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XlJQcsDHbA8KlkzjqyMcGdG4FHUS77/NIg5B8roEwJE=;
 b=Mdpm627XFQ7iyr8MC96Xl4lKvCgfzhAMt9luIipOJ+ZdHPskeo2tE2Jf7e4M4ya86s
 zzt6tY7WI/4CsppgpTV2aHrCHBmJTzvKKE6Dkv2E8P86omwr/3QFhcwaOZUj8HK3sVfM
 pWV2QvXUNUgyB/zAdOTGAQL7sr1+mrH3j4+R/PXNpi57jfGnmB0i5sFYJR7BdM1dUcIQ
 U3vQWSTCqXklr+5c152pdGd4i9+0cqdTze7QqycFuL8FSHbRXIYr3uba/F9+bEYs4T0I
 FLAJ0sRx7KELebbKewiRvK/Gaxzwenc1rOd3bBLkJBIWBl4meAzfxUT+GwBP/fZ3Xvai
 QSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl1PulFeKYJTdjkzHScaSDE6ry8bXZbTpMDOE59rzBlK6t7XfBe+iu2PBbZLTiGgIEsaohvp+F1JMM7qMHRnLuaS2WBQ==
X-Gm-Message-State: AOJu0YwjV5pkeOq5j0CXdHlEVoqYD+JjZ9hqETevLWYxUaJiRJjloUPO
 CE52MStFLgactZBzJUOq8YVX73x0gu6f7jT7uBkcsMX8OeGBfN/jTpz7N/FXNITHjyqpn5L20oI
 Eouy8VuOE2T36JsyWq2FbrfCeJ6Q=
X-Google-Smtp-Source: AGHT+IHcf0bonm/DRUS5YJ/+HuzVg89qDsJRxxkAeKVBhYIt5OS8uyZ3rMA2OYPqNtCZ+cBdl3Fxf2zUSVZ1xInNxhA=
X-Received: by 2002:a05:6870:c10f:b0:25e:1532:fa93 with SMTP id
 586e51a60fabf-2648ca4420emr1776498fac.15.1721816864317; Wed, 24 Jul 2024
 03:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 24 Jul 2024 19:27:33 +0900
Message-ID: <CALrBrZ0cgPVpboGKBe=QvxaWhZWLRH9=j3oASniYJvQfCD9xpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] arm: exynos: Enable TRNG for E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,


2024=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) 03:14, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This series enables True Random Number Generator (TRNG) for E850-96
> board. Here is a short breakdown of features implemented in this series:
>
>   1. Load LDFW (Loadable Firmware) on E850-96 board. It's needed to make
>      TRNG SMC commands functional. To do so, add the default eMMC
>      partition table and implement reading and applying LDFW in
>      board_init().
>   2. Add Exynos TRNG driver
>   3. Enable Exynos TRNG driver on E850-96 board. It requires SSS clocks
>      to be enabled, so add those clocks as well.
>
> With this series it's possible to generate random numbers in U-Boot
> (e.g. using 'rng' command). The main reason for RNG enablement on
> E850-96 board -- it's needed for EFI_RNG_PROTOCOL and kaslr, so it's one
> of the requirements to enable EFI boot support on E850-96 board, which
> in turn is needed (among other things) for EBBR spec and SystemReady IR
> certification. With this series it's also possible to use TRNG in Linux
> kernel (which was recently added, see [1] for details), as Linux kernel
> Exynos TRNG driver also relies on LDFW firmware to be loaded in the
> bootloader.
>
> Changes in v3:
>   - Fixed applying the defconfig changes (patch 5/5)
>   - Rebased on top of the most recent U-Boot/master
>
> Changes in v2:
>   - Addressed comments for [PATCH 4/5] rng: Add Exynos TRNG driver
>
> Sam Protsenko (5):
>   board: samsung: e850-96: Add default partitions
>   board: samsung: e850-96: Load LDFW firmware on board init
>   clk: exynos: Add SSS clocks for Exynos850
>   rng: Add Exynos TRNG driver
>   arm: exynos: Enable TRNG on E850-96 board
>
>  arch/arm/dts/exynos850-e850-96-u-boot.dtsi |  11 +
>  arch/arm/mach-exynos/Kconfig               |   2 +
>  board/samsung/e850-96/Makefile             |   4 +-
>  board/samsung/e850-96/e850-96.c            |   6 +-
>  board/samsung/e850-96/e850-96.env          |  26 ++
>  board/samsung/e850-96/fw.c                 | 131 ++++++++++
>  board/samsung/e850-96/fw.h                 |  12 +
>  configs/e850-96_defconfig                  |   1 +
>  drivers/clk/exynos/clk-exynos850.c         |  10 +
>  drivers/rng/Kconfig                        |  13 +
>  drivers/rng/Makefile                       |   1 +
>  drivers/rng/exynos-trng.c                  | 291 +++++++++++++++++++++
>  12 files changed, 504 insertions(+), 4 deletions(-)
>  create mode 100644 board/samsung/e850-96/e850-96.env
>  create mode 100644 board/samsung/e850-96/fw.c
>  create mode 100644 board/samsung/e850-96/fw.h
>  create mode 100644 drivers/rng/exynos-trng.c
>
> --
> 2.39.2
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
