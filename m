Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D8AEE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133728642E;
	Wed, 23 Aug 2023 09:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="RY8ipl8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A33E8645D; Wed, 23 Aug 2023 09:44:13 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3654580B98
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so140136f8f.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692776650; x=1693381450; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LmEn1+H+4t3EB+mFHcYOcWnoGGgmn8BllpKp3HV4Uj4=;
 b=RY8ipl8+T0LIiCU31fVa5heTTi7wzxjFO6xDwROxlVO6ro9iOWC4srUoz94B9XJiFu
 k8a3d37TtnpovRWLCJ5XrWcSF4PD0f9p4EN7QVIuDq5+iQziEYtZ/bsSdPoZEMzyGtH9
 2lcbnr1zrctrTsFfMOoTjP+ubyRaJBPLLY6/ORdyGy7MfG2LcdgMJ5B6BKchYgbh7QJF
 odLGINhGBNOsC9TERBdmr23pPHIa9+iMPfEqP1hFjyB+SV6bewASGaCLV2N5iKslZBeB
 j3T7VBO3lFs/wJr/lteuFsnNLEwcdMosPNipA1J0vo35PgsZxONAumscj7BgqRwg3kDH
 fmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692776650; x=1693381450;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmEn1+H+4t3EB+mFHcYOcWnoGGgmn8BllpKp3HV4Uj4=;
 b=j+xiWnFnIPh2AfgGHQ9xNbbCzgx8JGpZuyt8VhosPE7SgBvyFU0ZB101JvlgHS59gW
 pNtO0Y1iiydfobO4P6Dgb9OKrj4CnKkle5yXYgmBZ8MpDG7dD64PrHuPYobxYwnogD8L
 zWZgJTJSxLxaVSeLk7RLGgMUzgwbCHMmA6pJcR93L5Fy/1EHhLwVi0OkRMJcikR2tjcg
 47K8PYoUFaL2+YqS7cxjrQz0JGd+Zz81MkrST//E7IeKl3TWeb/GBuQQri0IoMyU6kMu
 lwpOyUh4tKri4lXtWssePB2BYXjVvrQlzDgk82owpmNVXhLCFoRnuBOcqhXCmOn3zWrJ
 IgGw==
X-Gm-Message-State: AOJu0YwVYKtMbDkj8i32k37VXlY3BqIHpFLUePnherqKkb8TxBS1zQ85
 o9Oim6VL/U5+yLPFKr9/06s2YA==
X-Google-Smtp-Source: AGHT+IEqp8QRUqTN0LraGpCUb5qiPFtZfMZLoIYa4miujNX/jNgHylc25U/MCCbjeCMYkNVF3vuorQ==
X-Received: by 2002:a5d:62ce:0:b0:31a:e972:3601 with SMTP id
 o14-20020a5d62ce000000b0031ae9723601mr9479141wrv.54.1692776650441; 
 Wed, 23 Aug 2023 00:44:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a5d484f000000b003197869bcd7sm18270479wrs.13.2023.08.23.00.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:44:09 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 0/8] board: ti: Add support for BeaglePlay
In-Reply-To: <20230822184135.2328409-1-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
Date: Wed, 23 Aug 2023 09:44:09 +0200
Message-ID: <874jkqgq46.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Nishanth,

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> Hi,
>
> Add support for BeaglePlay - rev 4
>
> Full series: https://github.com/nmenon/fix-k3-dt-u-boot/commits/beaglepla=
y-v4.2
>
> Caveats:
> * networking: pending https://lore.kernel.org/all/20230822121350.51324-1-=
rogerq@kernel.org/
> * 32kclk and usb: pending:
>   https://lore.kernel.org/u-boot/20230725185253.2123433-4-nm@ti.com/
>   OR https://github.com/nmenon/fix-k3-dt-u-boot/commit/853b29d63c1ca642be=
316f1afb0fb778610dec46
>   being properly resolved (NOTE: without this patch, wlan is broken in
>   Linux as the 32kclk from SoC is incorrectly supplied to wlan as 25MHz)
> * There seems to be a bug in Linux kernel with sdhci that seems to
>   depend on u-boot initialization of sdhci for functionality.
>
> Changes since V3:
> * GPIO, LEDs, PMIC enabled at u-boot level.
> * eMMC boot fixed in a manner not to break existing SK and other EVM
>   solutions. UDA FS solution similar to commit 5019170970ad
>   ("arch: arm: mach-k3: j721e: add support for UDA FS") introduced.
> * env file for beagleplay introduced to keep things consistent with the
>   behavior expected on BeaglePlay
> * Documentation updates to fixup alt, references, added OpenOCD debug
>   info etc.
> * New patch to ensure env files have priority over header included env
>   variables.
>
> Bootlog:
> emmc with no SD: https://gist.github.com/nmenon/5755228ff424c55245f453454=
8827ab9
> emmc with SD: https://gist.github.com/nmenon/8571dba9e942e77e48e52fe59cf7=
1aac
> SD boot: https://gist.github.com/nmenon/1cc850c37469fe7c86b26842fe0910f8
>
> Baseline: 7e6e40c57233 (origin/next) Merge tag 'v2023.10-rc3' into next
>
> V3: https://lore.kernel.org/all/20230815164440.2713726-1-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/
>
> Nishanth Menon (6):
>   env_default: Allow CONFIG_EXTRA_ENV_TEXT to override
>     CFG_EXTRA_ENV_SETTINGS
>   configs: am62x_evm*: Enable EMMC_BOOT configuration
>   arm: mach-k3: am625: Add support for UDA FS
>   arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
>   board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file
>   doc: board: ti: Add BeaglePlay documentation
>
> Nitin Yadav (1):
>   drivers: mmc: am654_sdhci: Update OTAP/ITAP delay
>
> Robert Nelson (1):
>   arm: dts: Add k3-am625-beagleplay

Using baseline 7e6e40c57233 ("Merge tag 'v2023.10-rc3' into next"), I
could boot all the way to U-boot proper shell.

And the LEDs work for me as well with:

  =3D> led led-0 toggle

So for the whole series:

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
>  arch/arm/dts/Makefile                         |    2 +
>  .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  196 ++
>  arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |   87 +
>  arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
>  arch/arm/mach-k3/am625_init.c                 |    6 +
>  board/ti/am62x/MAINTAINERS                    |    7 +
>  board/ti/am62x/beagleplay.env                 |   23 +
>  board/ti/am62x/beagleplay_a53.config          |   55 +
>  board/ti/am62x/beagleplay_r5.config           |   15 +
>  configs/am62x_evm_a53_defconfig               |    1 +
>  configs/am62x_evm_r5_defconfig                |    1 +
>  doc/board/ti/am62x_beagleplay.rst             |  256 ++
>  doc/board/ti/img/beagleplay_emmc.svg          |  697 ++++++
>  doc/board/ti/k3.rst                           |    1 +
>  drivers/mmc/am654_sdhci.c                     |   14 +-
>  include/env_default.h                         |    6 +-
>  18 files changed, 4315 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
>  create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
>  create mode 100644 board/ti/am62x/beagleplay.env
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>  create mode 100644 doc/board/ti/am62x_beagleplay.rst
>  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
>
> --=20
> 2.40.0
