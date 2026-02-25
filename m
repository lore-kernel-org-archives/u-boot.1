Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA352FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861398403D;
	Wed, 25 Feb 2026 15:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PRdOpcqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF9E8405A; Wed, 25 Feb 2026 15:55:23 +0100 (CET)
Received: from mail-vs1-xe35.google.com (unknown [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC89A83F9A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-5ff14dd9bf8so86363137.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772031211; cv=none;
 d=google.com; s=arc-20240605;
 b=UAwNhK3vOUS5VRIip3x4tX2utnisi1IrCmUVeafgvd8ZGZ0F7QfXRhq5YgFtcAymXa
 5DtJDfEl1t8CrDNNYABqGYTdgIr7zJ3S8G0zzvHn9OV/ZkjAU87SllHt2FL+LgoyWie3
 5FiZomU7GQhKNwoBppEZOzYMkVIcfb/n5KRwqaII9bVybm3dthZelhmc2fbYl/JDYtr/
 AJgMlzTwImkIDTj4Ku72RcuUEaequ5TzT7u8judMppp7KkoKurD9yGR0lodIBGcWL5Qo
 MqN0b5Q3bTEgcb5gTr+Gckt6xb56B/56DfgX1uXjdORn2qsLC9sgnKcgZaExzbqTGUx4
 fUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nmBnwIv9OEzq0E6L0g3w97MGl8txn8PdwnG6WZgsfzo=;
 fh=tPwwI4X+LUkETeoS52cf5CpLbPWcVyNq89ADPeomfZQ=;
 b=HEmWMOdZzpghUah29v8ZEDPIXz8AOeZEeFA7h30ot2+ab+anSp0/zP7nVENawRSKjd
 pE2FBoqecd7zaa2dDo24dKB9w0MprpXQSeQNaaX/QNs5Qj6Nvuil+3Ckn2KbcqWMmRgU
 Bkuf6kpYEy20lqlKHZY99vbagpBIygctTB+tSjJbA8K6ONJE8eW5lILq8AccmGD05L7D
 yR1YGfCuIBBgtG9lnvJjldVGRYjyt8ejPjlCeOi9fpeCsqRfJDZx+eLMw1z5iP53iEJ4
 6lNyLU9SfA6NQ8nHiMK/ZDcDbfa3OyG0hvFpY6LFDByRp7MFMxoQSX3GHqaWn732IQMt
 +2xA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772031211; x=1772636011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmBnwIv9OEzq0E6L0g3w97MGl8txn8PdwnG6WZgsfzo=;
 b=PRdOpcqaKIZAgCO8wjM7cNcBh9fmRUloa1ZyD+dcmF3OmHW3UTCi7MBKKcuBybMWP8
 aQcZ+pNOdtYl42G8Fw7Gh8qQ88676TFh7hzAgWTBjBBCDGteSthWHiTPKWGUkmows4vX
 omv+V8gY7zubR4Thb9WxBrMtBlr1QYmX+mSRTXJVW2jfPe9ba7jupkSJB2gUtXbiYSuw
 EVqRY93zhEQaqwncxDzWiQerRKyt4bV17XDi8QfmtGZZcVBLy3Zuec5LLWOzUMHugCHt
 SEqRbJDygAlo7RBLgaDk6vhzev8bSe1XchrN0XEk5hH7TIn75GujOw2D0kcDOZ5kJYdY
 Cbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772031211; x=1772636011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmBnwIv9OEzq0E6L0g3w97MGl8txn8PdwnG6WZgsfzo=;
 b=RIzorBfhWCXyGxKrxlFaOvubzo2KI2XK5xrTjvfT4ZPBfzJsJ6N7S+IcU1fuj/pFHG
 FYoUOcowq9Y+rjb7AqbNQTO0yoMRtetw4XI05vQv3WDilfrz+2SMqdWCTrjEWSBC83lD
 s5oA3R1Xhp13BALu6QoCpynnhkfXpn/2ui0JWhtZtQDys7EcP9TARW1Ui89+u4i3YClg
 3/IDBxTVI3PyKUfiZlML03i2Ul3ItHXO4IjYA9B1SfA5TbjlWpGlGPy/mXFbjfJ5IBGs
 xwHO5SMbdHDZuc1w1UsZxfOBClh08z4Y2b2JI8HC+GH1S7aUHUIflPASI2tRs5xz7BhT
 V3JQ==
X-Gm-Message-State: AOJu0Yx5ilLoOQqXdXY8RfSJB8mFW3JMqEns2oKbiiRJypN8GfdvMRIG
 VgNEU3JUYmdFHCRjdRI+4YSrt3rTBIff+CHetVo6ibOLvtQ/RYvyW6hEwnAx6s8i9h/Icw8fe0v
 u8tguA2UkSWDvE8tR2ScEYIwxa93jR91k+vhE
X-Gm-Gg: ATEYQzx10MOcLCUB7Qc3PYrdbSAvC4o+WV1G/d/Mz+EOkISre38dVgGvK1qYXxxyjzE
 C0Hz9V0+gaxtGyrHiEYGEBrFwsEXyDE9dtJ2j0vH/I4nUfG0x4SErvi6r4CUOBHG0ALnXoPDc0H
 3dFHgH8CgtynOt2XeVA9/B7u0S+RS5GRhSjY90DZYnROaYuTp7E1UHkxMSw1V9VBiw8FafycmhG
 1BmYeW+/ZOqHSTcnuzDPZ4VtmuLwm7J+5dXbY4CP8pDW4kJqzhuM6xBBJxzzv3dSdP9vDPptVXh
 c0KAk1Yl
X-Received: by 2002:a05:6102:6c6:b0:5fe:626a:a51b with SMTP id
 ada2fe7eead31-5ff13eb4821mr301104137.14.1772031211348; Wed, 25 Feb 2026
 06:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 25 Feb 2026 09:53:20 -0500
X-Gm-Features: AaiRm52_L0y-qNu88yepIDIyflzwWsiinmGrENxr4eGnvy0S38AZx3atEYRQcE8
Message-ID: <CAMDkj5w5C8rg1tL2gf7RTd9RtCWwMwCfDqpNRB6up0Y3QWPYSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add board support for Spacemit K1 SoC in SPL
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com, 
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, 
 hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de, 
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech, 
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org
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

Hi all,

Any further comments on this series?

Raymond

On Tue, Feb 10, 2026 at 10:15=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.co=
m> wrote:
>
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> This patch series introduces full support for the k1 SoC in SPL for
> multiple boards.
>
> The series enables the board by:
> 1. Adding the base board definition with device tree.
> 2. Bringing up essential clock sources and tree.
> 3. Initializing I2C buses for peripheral communication.
> 4. Integrating the PMIC driver for power management.
> 5. Adding regulator drivers for voltage domain control.
>
> Change in v2:
>   - Use read_poll_timeout() in k1 i2c driver.
>   - Abandon to parse offset and size from Kconfig & Makefile for binman.
>   - Abandon to attach firmware image into the patch set.
>   - Update the related document and some minor changes.
>
> Junhui Liu (1):
>   clk: spacemit: Add support for K1 SoC
>
> Raymond Mao (15):
>   spacemit: k1: support multi-board infrastructure
>   spacemit: k1: enable SPL with debug UART
>   configs: k1: enable early timer support
>   reset: k1: add SPL support and enable TWSI8 reset
>   dt-bindings: clock: import k1-syscon from upstream
>   dts: k1: import dts file from upstream folder
>   dts: k1: enable clocks in SPL
>   board: k1: initialize clock and serial devices in SPL
>   configs: k1: add default option for clock driver in SPL
>   i2c: k1: add I2C driver support
>   spacemit: k1: add TLV EEPROM support in SPL
>   spacemit: k1: Add DDR firmware support to SPL
>   power: pmic: add support for Spacemit P1 PMIC
>   power: regulator: add support for Spacemit P1 SoC
>   board: k1: enable pmic in spl
>
>  arch/riscv/Kconfig                            |   10 +-
>  arch/riscv/cpu/k1/Kconfig                     |    6 +
>  arch/riscv/dts/Makefile                       |    1 +
>  arch/riscv/dts/k1-spl.dts                     |  228 +++
>  arch/riscv/dts/k1.dtsi                        |  666 +++++-
>  board/spacemit/bananapi-f3/MAINTAINERS        |    6 -
>  board/spacemit/bananapi-f3/Makefile           |    5 -
>  board/spacemit/{bananapi-f3 =3D> k1}/Kconfig    |   11 +-
>  board/spacemit/k1/MAINTAINERS                 |   11 +
>  board/spacemit/k1/Makefile                    |   27 +
>  board/spacemit/{bananapi-f3 =3D> k1}/board.c    |    0
>  board/spacemit/k1/spl.c                       |  347 ++++
>  board/spacemit/k1/tlv_codes.h                 |   22 +
>  configs/bananapi-f3_defconfig                 |   24 -
>  configs/spacemit_k1_defconfig                 |   76 +
>  doc/board/spacemit/bananapi-f3.rst            |    2 +-
>  drivers/clk/Kconfig                           |    5 +-
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/spacemit/Kconfig                  |   31 +
>  drivers/clk/spacemit/Makefile                 |    7 +
>  drivers/clk/spacemit/clk-k1.c                 | 1795 +++++++++++++++++
>  drivers/clk/spacemit/clk_common.h             |   79 +
>  drivers/clk/spacemit/clk_ddn.c                |   93 +
>  drivers/clk/spacemit/clk_ddn.h                |   53 +
>  drivers/clk/spacemit/clk_mix.c                |  403 ++++
>  drivers/clk/spacemit/clk_mix.h                |  224 ++
>  drivers/clk/spacemit/clk_pll.c                |  157 ++
>  drivers/clk/spacemit/clk_pll.h                |   81 +
>  drivers/i2c/Kconfig                           |    7 +
>  drivers/i2c/Makefile                          |    1 +
>  drivers/i2c/k1_i2c.c                          |  516 +++++
>  drivers/i2c/k1_i2c.h                          |   69 +
>  drivers/power/pmic/Kconfig                    |   17 +
>  drivers/power/pmic/Makefile                   |    1 +
>  drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
>  drivers/power/regulator/Kconfig               |   15 +
>  drivers/power/regulator/Makefile              |    1 +
>  .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
>  drivers/reset/Kconfig                         |    7 +
>  drivers/reset/Makefile                        |    2 +-
>  drivers/reset/reset-spacemit-k1.c             |    4 -
>  include/configs/bananapi-f3.h                 |   13 -
>  include/configs/k1.h                          |   19 +
>  .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
>  include/power/spacemit_p1.h                   |  163 ++
>  include/soc/spacemit/k1-syscon.h              |  149 ++
>  46 files changed, 5997 insertions(+), 165 deletions(-)
>  create mode 100644 arch/riscv/dts/k1-spl.dts
>  delete mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
>  delete mode 100644 board/spacemit/bananapi-f3/Makefile
>  rename board/spacemit/{bananapi-f3 =3D> k1}/Kconfig (63%)
>  create mode 100644 board/spacemit/k1/MAINTAINERS
>  create mode 100644 board/spacemit/k1/Makefile
>  rename board/spacemit/{bananapi-f3 =3D> k1}/board.c (100%)
>  create mode 100644 board/spacemit/k1/spl.c
>  create mode 100644 board/spacemit/k1/tlv_codes.h
>  delete mode 100644 configs/bananapi-f3_defconfig
>  create mode 100644 configs/spacemit_k1_defconfig
>  create mode 100644 drivers/clk/spacemit/Kconfig
>  create mode 100644 drivers/clk/spacemit/Makefile
>  create mode 100644 drivers/clk/spacemit/clk-k1.c
>  create mode 100644 drivers/clk/spacemit/clk_common.h
>  create mode 100644 drivers/clk/spacemit/clk_ddn.c
>  create mode 100644 drivers/clk/spacemit/clk_ddn.h
>  create mode 100644 drivers/clk/spacemit/clk_mix.c
>  create mode 100644 drivers/clk/spacemit/clk_mix.h
>  create mode 100644 drivers/clk/spacemit/clk_pll.c
>  create mode 100644 drivers/clk/spacemit/clk_pll.h
>  create mode 100644 drivers/i2c/k1_i2c.c
>  create mode 100644 drivers/i2c/k1_i2c.h
>  create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
>  create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
>  delete mode 100644 include/configs/bananapi-f3.h
>  create mode 100644 include/configs/k1.h
>  create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h
>  create mode 100644 include/power/spacemit_p1.h
>  create mode 100644 include/soc/spacemit/k1-syscon.h
>
> --
> 2.25.1
>
