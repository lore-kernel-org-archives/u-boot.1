Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D1AC43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AC48488D;
	Mon,  6 Jul 2026 14:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBq72YHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFF3848BF; Mon,  6 Jul 2026 14:27:10 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36436846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so1147126a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 05:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783340827; cv=none;
 d=google.com; s=arc-20260327;
 b=mVXRkZF0B5VW2H2PGzfMh0S16D+xfqgG4BPrn6ZyY75V0a/wqPi5TSfBYPMNCEYNX9
 mwfBFHCjQ9wclB+9nsIERCp4TffpylKcLvqxzLYCCkV3uaypyhOGbzk9LhONMQ9sehM+
 d4es1PVMoM+3Yh0Y29qSHjoXShCmzBo4QPTfviGtyntpgHjXTIHnU6ViHbi0TsOzHhF5
 9nAnQSQFB0Cn+JWwzB8OlFeWQa8NnYUdi2pQVo8xJfVTv2tIkhE/m7aDxUvxuO9UZ7eX
 H71FUpKTJ2YsH+zToUdF3+TW56QkbQVwA+RQlfyGkmSav0E9NfV0olYjgFPdP7HSWODe
 LpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YWnG68KlVfgkjK3Q9peDXZ5WvtAHCM2fp9aiY/EpDlw=;
 fh=PtU77wmUiyFw7bUb787RNtJAFAtYNByBlrnmPQy9D9o=;
 b=ml3/VkUE0ooH+7No5CQNQ+SEWmtQR5aurTDhQf/aUaBPVClSR/pFk5r6mrHG03xxCK
 EeUgC0TDFCp45nytTAk1ldSjTF5WYFuh4jjje9v3/SioM4HO6RuvOqvCL6EDdra5nPwA
 w6vrEdr8nhlKSJrB7fZUyuHjuJqutP0BfhF0guum9UL8Lm3LvAZpgoauM4YpEefutuJS
 o2LZQ4MGoYNhk16nrwHdcQTg0MKJWPonJrg3exgJh9JoMlq9fDR8WYgu2vhR2cVywSHE
 TTtvElWjhrBZuy76hBBZLD/XCop9OiivOxKTqBlxxE7ufNKlZItMa9iey0OAFSPs3ux9
 aXWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783340827; x=1783945627; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YWnG68KlVfgkjK3Q9peDXZ5WvtAHCM2fp9aiY/EpDlw=;
 b=hBq72YHTIg8EE057htfiz+uj92Gd9Gxyb7VjBtkWb5W3SObLNQyULjpG8C/h5Pm0n2
 8sHXwMcKnYfcCsXZOWEXbKS8cn5mE4cOUi/8KklRl9w00pzRiLTP1PYkvW5EckrIr+Xg
 gtI7BuPu+FGmDDh9j5AeIyYcYKdcliFAOzWn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340827; x=1783945627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YWnG68KlVfgkjK3Q9peDXZ5WvtAHCM2fp9aiY/EpDlw=;
 b=ccWfVRFt4yuSRi6fJLjlXpkzyZDtYbpJI/ORycLy+P81QyDytmu+b2+LMtbLN0Hs6D
 YnixVSb0uOSPFs/MoeZb6tY8mFuXBMBtmYfvKwyz50bUw3MvaGc0tL0XD6n46/er8T/L
 21FAoJuQAoNOrt5cmQ+fe5l04h+aG0Ondgqj9DIcIyQDlwQc4/vyx1uqHHchYG649VSd
 2/TL3xCrjvaCLFs1xPntP14k/nPIdxmQI/zSLZH0VH35v05xj4a2O2NArJRCOX1otyCu
 9sQgMki5vxJMOC835JxwcylCaxPQJIO6P35UuSfg/smfyD81un0zQh8lISP4L4tY7FIr
 nkaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOC+FqgOShd+QB3nzum6sIV6enpf85Mr3C42dzj8Ue/Ev7Xhg5U9J3LyCJyfuf+Hkf359ZkWU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp6YncO7pgV6rs9au/WrX8BPmZQPNYL0lsRU32NV2Kxo55UYlo
 OL/wGm7aKpf7vEuf4xbRHn3k0kD49XtE+EIK/ZD78gaveCZIu5eUlF+gqoeyQvElT9BWtC/uyjZ
 hSlsX12r0wofxVoPmMCpiVWNXfvsUQUfwFBUb7C6P
X-Gm-Gg: AfdE7clHbCWlNyZyF1pVNYoUs5imbHGpf1/RK96XEY0WcZRLY1OYQ5XcJk9qg/vLDdg
 /oBXU7lyBYEerPy9/qfvPr/qNBrN4icKJyStkX48drPs4PmlmpQ0Pe7RVGdJJuHN0LfHHE1oV1C
 BCql+De69UlCuK+sMPULUoPvSZOfP70rxIbvlk2LTRxI0AKPdaLQU11C0hCTKWUje0KssznasTv
 c9Iyh9WNcPC3oCkKdIBZsCThzawILDNyN7VkFHz6ittDT6J/z2iHODColDIKehlNYCSUcA=
X-Received: by 2002:a05:6402:568d:b0:698:de64:6ab3 with SMTP id
 4fb4d7f45d1cf-69a85b82f23mr153585a12.12.1783340827499; Mon, 06 Jul 2026
 05:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260208212624.3413494-1-festevam@gmail.com>
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jul 2026 06:26:55 -0600
X-Gm-Features: AVVi8CcbfVkTuxCllAXJTUVDm3zvsEDeydgXfCSDvFtJ4ubg6fcJg46g4fH8b70
Message-ID: <CAFLszTgP0wCfQOZ=DJhbdPWC4k8e66XmNtF9cO8z97oqPetdRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ARM: Add RV1103B Omega4 board support
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Fabio,

On Sun, 8 Feb 2026 at 14:26, Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@nabladev.com>
>
> Hi,
>
> This patch series adds support for the Onion RV1103B Omega4 board.
>
> It covers SPL, SPI NAND boot, and the minimal board devicetree required to
> boot the board.
>
> Upstreaming the RV1103B devicetree in Linux is ongoing, but to avoid blocking
> U-Boot support, this series introduces board-specific devicetrees for now.
>
> Once the Linux RV1103B devicetrees are upstreamed, the OF_UPSTREAM mechanism
> can be enabled.
>
> In v2, the correct SoC name was used: RV1103B instead of RV1103 (Thanks Jonas!),
> the RV1103B dt-bindings, devicetrees, clock and pinctrl drivers have been
> submitted upstream.
>
> The dt-bindings have already been reviewed by the Linux DT maintainer:
>
> https://lore.kernel.org/linux-devicetree/cadee46d-589b-4833-8650-691f7a0f8321@kernel.org/
>
> https://lore.kernel.org/linux-devicetree/a2be67b7-a33a-4d72-b5b7-fa900063b599@kernel.org/
>
> https://lore.kernel.org/linux-devicetree/47561412-cbaa-42c7-b8ab-9cafb7e0f9be@kernel.org/
>
> https://lore.kernel.org/linux-devicetree/20260207-hulking-elegant-ferret-8efcea@quoll/
>
> https://lore.kernel.org/linux-devicetree/20260208-analytic-fine-grouse-e17baa@quoll/
>
> https://lore.kernel.org/linux-devicetree/20260208-pearl-ammonite-of-warranty-2c9212@quoll/
>
> Tested the boot of a 6.6 OpenWRT kernel and also a 6.19-rc8 mainline kernel.
>
> This series has successfully passed through CI.
>
> Elaine Zhang (1):
>   clk: rockchip: Add RV1103B clock driver
>
> Fabio Estevam (4):
>   ARM: dts: Add RV1103B Omega4 support
>   rockchip: spl-boot-order: Add SPI NAND support
>   spl: add SPI NAND support via MTD in SPL
>   omega4-rv1103b: Add the initial support
>
> Xuhui Lin (1):
>   tools: rkcommon: Add RV1103B support
>
> Ye Zhang (1):
>   pinctrl: rockchip: Add RV1103B support
>
>  arch/arm/dts/rv1103b-omega4-u-boot.dtsi       |   10 +
>  arch/arm/dts/rv1103b-omega4.dts               |  105 ++
>  arch/arm/dts/rv1103b-pinctrl.dtsi             |  831 +++++++++++++
>  arch/arm/dts/rv1103b-u-boot.dtsi              |    4 +
>  arch/arm/dts/rv1103b.dtsi                     |  266 ++++
>  .../include/asm/arch-rockchip/cru_rv1103b.h   |  266 ++++
>  .../include/asm/arch-rockchip/grf_rv1103b.h   |   31 +
>  arch/arm/include/asm/arch-rv1103b/boot0.h     |   11 +
>  arch/arm/mach-rockchip/Kconfig                |   14 +
>  arch/arm/mach-rockchip/Makefile               |    1 +
>  arch/arm/mach-rockchip/rv1103b/Kconfig        |   23 +
>  arch/arm/mach-rockchip/rv1103b/Makefile       |   12 +
>  arch/arm/mach-rockchip/rv1103b/boot0.h        |    5 +
>  arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c  |   32 +
>  arch/arm/mach-rockchip/rv1103b/rv1103b.c      |  133 ++
>  .../mach-rockchip/rv1103b/syscon_rv1103b.c    |   19 +
>  arch/arm/mach-rockchip/spl-boot-order.c       |   11 +-
>  board/onion/omega4_rv1103b/Kconfig            |   12 +
>  board/onion/omega4_rv1103b/MAINTAINERS        |    6 +
>  board/onion/omega4_rv1103b/Makefile           |    7 +
>  board/onion/omega4_rv1103b/omega4_rv1103b.c   |   19 +
>  board/onion/omega4_rv1103b/omega4_rv1103b.env |    5 +
>  common/spl/Kconfig                            |   10 +-
>  common/spl/Makefile                           |    1 +
>  common/spl/spl_spi_nand.c                     |   82 ++
>  configs/omega4-rv1103b_defconfig              |   82 ++
>  doc/board/index.rst                           |    1 +
>  doc/board/onion/index.rst                     |    9 +
>  doc/board/onion/omega4-rv1103b.rst            |   56 +
>  drivers/clk/rockchip/Makefile                 |    1 +
>  drivers/clk/rockchip/clk_rv1103b.c            | 1068 +++++++++++++++++
>  drivers/mtd/Makefile                          |    1 +
>  drivers/mtd/nand/Makefile                     |   13 +-
>  drivers/pinctrl/rockchip/Makefile             |    1 +
>  drivers/pinctrl/rockchip/pinctrl-rv1103b.c    |  398 ++++++
>  include/configs/omega4_rv1103b.h              |   11 +
>  include/configs/rv1103b_common.h              |   14 +
>  .../dt-bindings/clock/rockchip,rv1103b-cru.h  |  220 ++++
>  tools/rkcommon.c                              |    1 +
>  39 files changed, 3788 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/dts/rv1103b-omega4-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rv1103b-omega4.dts
>  create mode 100644 arch/arm/dts/rv1103b-pinctrl.dtsi
>  create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rv1103b.dtsi
>  create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103b.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103b.h
>  create mode 100644 arch/arm/include/asm/arch-rv1103b/boot0.h
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/Kconfig
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/Makefile
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/boot0.h
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/clk_rv1103b.c
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/rv1103b.c
>  create mode 100644 arch/arm/mach-rockchip/rv1103b/syscon_rv1103b.c
>  create mode 100644 board/onion/omega4_rv1103b/Kconfig
>  create mode 100644 board/onion/omega4_rv1103b/MAINTAINERS
>  create mode 100644 board/onion/omega4_rv1103b/Makefile
>  create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.c
>  create mode 100644 board/onion/omega4_rv1103b/omega4_rv1103b.env
>  create mode 100644 common/spl/spl_spi_nand.c
>  create mode 100644 configs/omega4-rv1103b_defconfig
>  create mode 100644 doc/board/onion/index.rst
>  create mode 100644 doc/board/onion/omega4-rv1103b.rst
>  create mode 100644 drivers/clk/rockchip/clk_rv1103b.c
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103b.c
>  create mode 100644 include/configs/omega4_rv1103b.h
>  create mode 100644 include/configs/rv1103b_common.h
>  create mode 100644 include/dt-bindings/clock/rockchip,rv1103b-cru.h
>
> --
> 2.34.1
>

I recently got one of these boards and have it running in my lab at a
basic level (boot to prompt, SPI-NAND and MMC).

Are you still planning to send a v3? If not I could handle Jonas's
feedback and send out a v3?

Regards,
Simon
