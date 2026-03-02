Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20B4EA4E09
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC4683F2D;
	Mon,  2 Mar 2026 15:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M/C4KU4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B532983F30; Mon,  2 Mar 2026 15:36:42 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F9483F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-56a91535e5bso1700363e0c.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772462199; cv=none;
 d=google.com; s=arc-20240605;
 b=f4FuRKEH1CMnuPabpLmubGLQTKI12fQN41lyMFMIf8ZJg2DdZT66jiGwzwYUaINJIm
 S9darSTNehmT3fGpwv6w1pPASDjoC2QHafa6Lj1YeK3sLtBgsCIojpFfunOmOETz3WUr
 PZonAbBB27YvJtDeXtNnNMEJRxWlZkldqSa59lA3tdOhXWw6dRt8w8s0UwBd5eV4MmM3
 cH3KDC6+lxBUB8lv3xdpwAIVuIAXLhuKzWsz82R93N7mEOyJWUIxvqZa1S2Qv3tXL8Kk
 PWtUlD05fkiF3qoFuj6iOqZ0P2nhU8U4oC0QEyez2vCH4EME4uj8Uy+qFGfrPxH9dw33
 BnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rdYAXY0tHqrE4pkxVs5o7f8zFKFe8d2TIriJFZVDnF4=;
 fh=tPwwI4X+LUkETeoS52cf5CpLbPWcVyNq89ADPeomfZQ=;
 b=jkTgfFHYkBaFxVRrxblmJ6l/iwT2lIkTm33lAPqsgMvL2xx3B2qaS6hOv3kiC30Wjq
 5QtiUZwUoDRIX5xCbw7E3iYkFCgatCCkqfyG/oa964p/S8u2mFVJoGkjLN1MSk8zmjGZ
 5hKxd3/0su79ItK2yjt/Zw6XVju6kjmuquqaUw04NTu4QrG2h5+64vy1aqzO+atqNZ8l
 k6aH/NON9wFHEwjazgcF/64dSJyNuC5E1c9rJbRr0HrN6X3U9e67It/WkSm8zhg+XvJy
 m2WhVEWQFhAAcckmIviAb4J1lMmB8GRynJzsq8O5nfQHJFt2VTXeico2urs6w9L5ZwzL
 SX6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772462199; x=1773066999; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdYAXY0tHqrE4pkxVs5o7f8zFKFe8d2TIriJFZVDnF4=;
 b=M/C4KU4MJf4BA33d8Q+F31ZFLP2xTpinqmhcDFjDradEANYyjeaXPxli3m7wvPkFF6
 WkLhB0nhkk6tZUOd6pZKN7NmafCmrMubt+OLqWhKgHVCi1wvUtT7K9OLIiWOtqCAqwCX
 HrW1DwAi8um5ejtyFpYasvTluGKAjxGE2+vuuQje/6eazyhKaFid9GxpbsBU8gDo760p
 lQDIV29jf+T9rK2aIcvdDqltPwaNuUz3DfWO3VnEOxkL1CubT0C19mvXSe/oWZkff7bs
 GzQXcPkuz1m++JlAtH2XDaQONYa4LVR0NiycYcRn1xwI7TfuGTj1LPWltg3pK1BGKtH4
 P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772462199; x=1773066999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rdYAXY0tHqrE4pkxVs5o7f8zFKFe8d2TIriJFZVDnF4=;
 b=M+iZhTN7ajspglnMmpp5TVc361u9aBEqK70RFJ35ql2uIVVDcac1iclSy/KYrfon6O
 7OS+U6g4sxWHHVIs87I4d0OWCIf0d/T545FGHRjrpCe8twj5s8b++mSxBCaCsfTY4XDf
 f8qQrbM3BXbj002Ra5RNNu7gCtDd4EeOmLaJIGnOc50mypSVTSXLS8X//03pyS+WfQTj
 Rzi4dbuJpnTx1QkJDAWqFAoAjK+Z6FSP907sXcfK2zLtfYK+a6JYk8BQdN0N7c2zHAVT
 iUc5e7yooL34AgIV+YrO+0L/wF5yYLLhpc3xwMRfCJHbeGjTR4wIePhR88nui2JtDZwf
 ycTw==
X-Gm-Message-State: AOJu0YybrcPWxbw7Z+mMNPZfMFdCSnXW8PY+/qRx+Q26vvKoCgSBj9Cu
 U/5k083i2zzUXArhCEKZt+uQswGKDR1hS7COjL8DgMRsAHOenoJ0TfcEfabuSnfxKJUJh6ATjb6
 zDcO0PKJNEY6zG+fPx9wZsVaxNyfVbRxt59lA
X-Gm-Gg: ATEYQzxO9pYHVQWcxzdPaXu0amWvtA1nBDUa1vToLimaFqzXdFls8j8qnZguMqupOqg
 7pHWO9P12MpK3vfnnEwnEIz1tkdPXIsZiQqomTRGFFSOvZaF+PAee8mVgIejqdf8I0zQRtFRXOQ
 Ofx4fgFZE92Aw8SRxRCbaEY9v4XeSdlFsMnpg/GnSHlbSHvOMMWAlihZkmKCPFnrjqBBihaF+aA
 5SVNTWjQ5ySCJ9pj3vURqMPo276a3eEXkgXO3x/DIbX2/WrfP6HXjF7Pmrv+MwsqNqgvLQATL68
 7tkNvSpO
X-Received: by 2002:a05:6102:390e:b0:5fd:f509:c97 with SMTP id
 ada2fe7eead31-5ff323b66d0mr4252142137.18.1772462199125; Mon, 02 Mar 2026
 06:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
 <CAMDkj5w5C8rg1tL2gf7RTd9RtCWwMwCfDqpNRB6up0Y3QWPYSw@mail.gmail.com>
In-Reply-To: <CAMDkj5w5C8rg1tL2gf7RTd9RtCWwMwCfDqpNRB6up0Y3QWPYSw@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 2 Mar 2026 09:36:28 -0500
X-Gm-Features: AaiRm500WlP0yW5N0OU6tsbqeABoIKoNyudYbwoCKVpeH-80DqXsvC55uHxjIHU
Message-ID: <CAMDkj5xBXvza4Sa_pNQ_rsbJdt08uAsgqw9=EL_g3-vUUjWQvg@mail.gmail.com>
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

Hi Tom, Leo and Rick,

Can I get help from you to get this series merged?

Thanks and regards,
Raymond

On Wed, Feb 25, 2026 at 9:53=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.com=
> wrote:
>
> Hi all,
>
> Any further comments on this series?
>
> Raymond
>
> On Tue, Feb 10, 2026 at 10:15=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.=
com> wrote:
> >
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > This patch series introduces full support for the k1 SoC in SPL for
> > multiple boards.
> >
> > The series enables the board by:
> > 1. Adding the base board definition with device tree.
> > 2. Bringing up essential clock sources and tree.
> > 3. Initializing I2C buses for peripheral communication.
> > 4. Integrating the PMIC driver for power management.
> > 5. Adding regulator drivers for voltage domain control.
> >
> > Change in v2:
> >   - Use read_poll_timeout() in k1 i2c driver.
> >   - Abandon to parse offset and size from Kconfig & Makefile for binman=
.
> >   - Abandon to attach firmware image into the patch set.
> >   - Update the related document and some minor changes.
> >
> > Junhui Liu (1):
> >   clk: spacemit: Add support for K1 SoC
> >
> > Raymond Mao (15):
> >   spacemit: k1: support multi-board infrastructure
> >   spacemit: k1: enable SPL with debug UART
> >   configs: k1: enable early timer support
> >   reset: k1: add SPL support and enable TWSI8 reset
> >   dt-bindings: clock: import k1-syscon from upstream
> >   dts: k1: import dts file from upstream folder
> >   dts: k1: enable clocks in SPL
> >   board: k1: initialize clock and serial devices in SPL
> >   configs: k1: add default option for clock driver in SPL
> >   i2c: k1: add I2C driver support
> >   spacemit: k1: add TLV EEPROM support in SPL
> >   spacemit: k1: Add DDR firmware support to SPL
> >   power: pmic: add support for Spacemit P1 PMIC
> >   power: regulator: add support for Spacemit P1 SoC
> >   board: k1: enable pmic in spl
> >
> >  arch/riscv/Kconfig                            |   10 +-
> >  arch/riscv/cpu/k1/Kconfig                     |    6 +
> >  arch/riscv/dts/Makefile                       |    1 +
> >  arch/riscv/dts/k1-spl.dts                     |  228 +++
> >  arch/riscv/dts/k1.dtsi                        |  666 +++++-
> >  board/spacemit/bananapi-f3/MAINTAINERS        |    6 -
> >  board/spacemit/bananapi-f3/Makefile           |    5 -
> >  board/spacemit/{bananapi-f3 =3D> k1}/Kconfig    |   11 +-
> >  board/spacemit/k1/MAINTAINERS                 |   11 +
> >  board/spacemit/k1/Makefile                    |   27 +
> >  board/spacemit/{bananapi-f3 =3D> k1}/board.c    |    0
> >  board/spacemit/k1/spl.c                       |  347 ++++
> >  board/spacemit/k1/tlv_codes.h                 |   22 +
> >  configs/bananapi-f3_defconfig                 |   24 -
> >  configs/spacemit_k1_defconfig                 |   76 +
> >  doc/board/spacemit/bananapi-f3.rst            |    2 +-
> >  drivers/clk/Kconfig                           |    5 +-
> >  drivers/clk/Makefile                          |    1 +
> >  drivers/clk/spacemit/Kconfig                  |   31 +
> >  drivers/clk/spacemit/Makefile                 |    7 +
> >  drivers/clk/spacemit/clk-k1.c                 | 1795 +++++++++++++++++
> >  drivers/clk/spacemit/clk_common.h             |   79 +
> >  drivers/clk/spacemit/clk_ddn.c                |   93 +
> >  drivers/clk/spacemit/clk_ddn.h                |   53 +
> >  drivers/clk/spacemit/clk_mix.c                |  403 ++++
> >  drivers/clk/spacemit/clk_mix.h                |  224 ++
> >  drivers/clk/spacemit/clk_pll.c                |  157 ++
> >  drivers/clk/spacemit/clk_pll.h                |   81 +
> >  drivers/i2c/Kconfig                           |    7 +
> >  drivers/i2c/Makefile                          |    1 +
> >  drivers/i2c/k1_i2c.c                          |  516 +++++
> >  drivers/i2c/k1_i2c.h                          |   69 +
> >  drivers/power/pmic/Kconfig                    |   17 +
> >  drivers/power/pmic/Makefile                   |    1 +
> >  drivers/power/pmic/pmic_spacemit_p1.c         |   94 +
> >  drivers/power/regulator/Kconfig               |   15 +
> >  drivers/power/regulator/Makefile              |    1 +
> >  .../power/regulator/spacemit_p1_regulator.c   |  460 +++++
> >  drivers/reset/Kconfig                         |    7 +
> >  drivers/reset/Makefile                        |    2 +-
> >  drivers/reset/reset-spacemit-k1.c             |    4 -
> >  include/configs/bananapi-f3.h                 |   13 -
> >  include/configs/k1.h                          |   19 +
> >  .../dt-bindings/clock/spacemit,k1-syscon.h    |  253 +++
> >  include/power/spacemit_p1.h                   |  163 ++
> >  include/soc/spacemit/k1-syscon.h              |  149 ++
> >  46 files changed, 5997 insertions(+), 165 deletions(-)
> >  create mode 100644 arch/riscv/dts/k1-spl.dts
> >  delete mode 100644 board/spacemit/bananapi-f3/MAINTAINERS
> >  delete mode 100644 board/spacemit/bananapi-f3/Makefile
> >  rename board/spacemit/{bananapi-f3 =3D> k1}/Kconfig (63%)
> >  create mode 100644 board/spacemit/k1/MAINTAINERS
> >  create mode 100644 board/spacemit/k1/Makefile
> >  rename board/spacemit/{bananapi-f3 =3D> k1}/board.c (100%)
> >  create mode 100644 board/spacemit/k1/spl.c
> >  create mode 100644 board/spacemit/k1/tlv_codes.h
> >  delete mode 100644 configs/bananapi-f3_defconfig
> >  create mode 100644 configs/spacemit_k1_defconfig
> >  create mode 100644 drivers/clk/spacemit/Kconfig
> >  create mode 100644 drivers/clk/spacemit/Makefile
> >  create mode 100644 drivers/clk/spacemit/clk-k1.c
> >  create mode 100644 drivers/clk/spacemit/clk_common.h
> >  create mode 100644 drivers/clk/spacemit/clk_ddn.c
> >  create mode 100644 drivers/clk/spacemit/clk_ddn.h
> >  create mode 100644 drivers/clk/spacemit/clk_mix.c
> >  create mode 100644 drivers/clk/spacemit/clk_mix.h
> >  create mode 100644 drivers/clk/spacemit/clk_pll.c
> >  create mode 100644 drivers/clk/spacemit/clk_pll.h
> >  create mode 100644 drivers/i2c/k1_i2c.c
> >  create mode 100644 drivers/i2c/k1_i2c.h
> >  create mode 100644 drivers/power/pmic/pmic_spacemit_p1.c
> >  create mode 100644 drivers/power/regulator/spacemit_p1_regulator.c
> >  delete mode 100644 include/configs/bananapi-f3.h
> >  create mode 100644 include/configs/k1.h
> >  create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h
> >  create mode 100644 include/power/spacemit_p1.h
> >  create mode 100644 include/soc/spacemit/k1-syscon.h
> >
> > --
> > 2.25.1
> >
