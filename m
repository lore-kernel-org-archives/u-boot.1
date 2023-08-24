Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E5EC7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 406E98656A;
	Thu, 24 Aug 2023 10:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="O9qAyUwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7B986547; Thu, 24 Aug 2023 10:02:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D06E8656C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso1408215e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692864133; x=1693468933; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1WZ+K087yFsnvZ3STh85fhpvrdMtx7QFasIQT0TFRkI=;
 b=O9qAyUwQh82ucFYYODbVvSVjcY84i42fTyTl6HCvxy2Qlu23HONq8IooEp4c5B1fVb
 MRXfKPWVbZRal8sK96B9EnjYDeva96ysLyjd1V+ARWqVpIPJy7invQg1xQGfJAj+JqpW
 WvjuVopThP5D8RhoHelX/M7xK/KW7Mi6wws0I5LzColCv0UiFbMqTFNtWySHZANVt4Jq
 zraXSoJhfamE6Kv/xzhbF3QCW7bSq6QimYh4l+D1BoQviMSWsFdes37etR9WUrCqld/U
 AsObn0EVAyubx8aNmEe8d2i8NRrOQWHJvEO5KPA+ullXDUVrXatE4pWRt1kUbyvaMolz
 /alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692864133; x=1693468933;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WZ+K087yFsnvZ3STh85fhpvrdMtx7QFasIQT0TFRkI=;
 b=IFLDjSadTGkqe5M0Ro218OKGapmIPEU8V1R/zMXc8+FPRYEKqiqNZgdL5PZ6qnFEPS
 2IFOjZx0eTtujxNUuVpW5E9JlKROrlhvcGJCkbl5GvHCtzWzBPG2qpJwDM6uHJgShAbC
 4GaMFeAJhpQNxJg+3S2gDRFL9l9qnv2r1SIuaRmKeVAaelAtHXuoZlLmTKUwp66sPRRD
 EzFXScbkQ4RvdHTIVFcVSbmxfAPNxTAMxwjSYs+/N3UMoqy85MMvGlB7mCREmtb5oPak
 cob2t2kquoCOuLCp3vGFv0Rt7FDnr72+PwxGcynokKf6KLhNdRJjQdKnM95foAcm/Hjx
 lcKg==
X-Gm-Message-State: AOJu0YziDXvgLWU0v9SEe5grWlqtW1/YcmpGhe5LEcKZLakZ6CmeJjYY
 E6ujuATcGi3xDmb5GGhEWrQ2QA==
X-Google-Smtp-Source: AGHT+IG88T0mzNKnqub8ReNTPlVC+OGwZ7duisfmykmUhhkjh8+GwjaGqQPpfo1DkVprficZAvuKvg==
X-Received: by 2002:a05:600c:1586:b0:401:609f:7f9a with SMTP id
 r6-20020a05600c158600b00401609f7f9amr933428wmf.8.1692864131716; 
 Thu, 24 Aug 2023 01:02:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 i9-20020a05600c290900b003fe26244858sm1810383wmd.46.2023.08.24.01.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:02:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 00/17] board: ti: Add support for BeaglePlay
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
Date: Thu, 24 Aug 2023 10:02:10 +0200
Message-ID: <87o7iwrhq5.fsf@baylibre.com>
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> Add support for BeaglePlay - rev 5
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
> CI loop check: https://github.com/u-boot/u-boot/pull/425 (whenever that
> gets done I guess).
>
> Bootlogs:
> SD Boot: https://gist.github.com/nmenon/c74acb3a895053e05623e886df77c8fe
> eMMC, no SD boot: https://gist.github.com/nmenon/16df3b8fc0e9102f29ebb783=
6b950a08
> eMMC with SD card: https://gist.github.com/nmenon/042dbe7c08589e7bfe1919d=
a1fedc545
>
> Complete code (with the tmp patch) can be found at:
> https://github.com/nmenon/fix-k3-dt-u-boot/tree/beagleplay-v5
>
> Baseline: 97841de68043 (origin/next) Merge branch '2023-08-22-assorted-co=
de-cleanups' into next
>
> Changes since V4:
> * Switched boot from distro_boot to bootstd - AM62 as a start will rely
>   on txt env file.
> * Cleanups around am625_init.c (new patches)
> * Review comment fixups for documentation
> * I have'nt picked up Mattijs's tested by since this is a different
>   approach (bootstd Vs distro_bootcmd)
> * Dropped the sdhci patches AND CFG_EXTRA_ENV_SETTINGS (Instead, we
>   switch entirely to bootstd and move am62x-sk to bootstd along with
>   it).
>
> V4: https://lore.kernel.org/all/20230822184135.2328409-1-nm@ti.com/
> V3: https://lore.kernel.org/all/20230815164440.2713726-1-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/
>
> Nishanth Menon (16):
>   include: configs: ti_armv7_common: Add documentation for protected
>     section
>   include: configs: am62x_evm: Drop unused SDRAM address
>   include: configs: am62x_evm: Wrap distroboot with
>     CONFIG_DISTRO_DEFAULTS
>   board: ti: am62x: am62x.env: Add explicit boot_targets
>   configs: am62x_evm_a53_defconfig: Switch to bootstd
>   include: configs: am62x_evm: Drop distro_bootcmd usage
>   include: env: ti: ti_armv7_common.env: Rename to ti_common.env
>   include: env: ti: ti_common: Add a generic findfdt
>   board: ti: am62x: am62x.env: Use default findfdt
>   arm: mach-k3: am625_init: Use IS_ENABLED()
>   arm: mach-k3: am625_init: Convert rtc_erratumi2327_init to static
>   configs: am62x_evm*: Enable EMMC_BOOT configuration
>   arm: mach-k3: am625: Add support for UDA FS
>   arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
>   board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file
>   doc: board: ti: Add BeaglePlay documentation
>
> Robert Nelson (1):
>   arm: dts: Add k3-am625-beagleplay

I re-tested v5.

Using baseline 97841de68043 ("Merge branch '2023-08-22-assorted-code-cleanu=
ps' into next")
I could boot all the way to U-boot proper shell.

And the LEDs work for me as well with:

=3D> led led-0 toggle

So for the whole series:

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Note that I did not tried any boot related commands since I mostly work
on Android booting and I have not rebased my wip-branch yet.

>
>  arch/arm/dts/Makefile                         |    2 +
>  .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  195 ++
>  arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |   86 +
>  arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
>  arch/arm/mach-k3/am625_init.c                 |   49 +-
>  board/siemens/iot2050/iot2050.env             |    2 +-
>  board/ti/am62ax/am62ax.env                    |    2 +-
>  board/ti/am62x/MAINTAINERS                    |    7 +
>  board/ti/am62x/am62x.env                      |    7 +-
>  board/ti/am62x/beagleplay.env                 |   18 +
>  board/ti/am62x/beagleplay_a53.config          |   55 +
>  board/ti/am62x/beagleplay_r5.config           |   15 +
>  board/ti/am64x/am64x.env                      |    2 +-
>  board/ti/am65x/am65x.env                      |    2 +-
>  board/ti/j721e/j721e.env                      |    2 +-
>  board/ti/j721s2/j721s2.env                    |    2 +-
>  board/ti/ks2_evm/k2e_evm.env                  |    2 +-
>  board/ti/ks2_evm/k2g_evm.env                  |    2 +-
>  board/ti/ks2_evm/k2hk_evm.env                 |    2 +-
>  board/ti/ks2_evm/k2l_evm.env                  |    2 +-
>  configs/am62x_evm_a53_defconfig               |    6 +-
>  configs/am62x_evm_r5_defconfig                |    1 +
>  doc/board/ti/am62x_beagleplay.rst             |  256 ++
>  doc/board/ti/img/beagleplay_emmc.svg          |  697 ++++++
>  doc/board/ti/k3.rst                           |    1 +
>  include/configs/am62x_evm.h                   |    6 -
>  include/configs/ti_armv7_common.h             |    2 +-
>  .../ti/{ti_armv7_common.env =3D> ti_common.env} |   12 +
>  30 files changed, 4342 insertions(+), 50 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
>  create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
>  create mode 100644 board/ti/am62x/beagleplay.env
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>  create mode 100644 doc/board/ti/am62x_beagleplay.rst
>  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
>  rename include/env/ti/{ti_armv7_common.env =3D> ti_common.env} (71%)
>
> --=20
> 2.40.0
