Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD4C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 08:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5665E87527;
	Fri,  2 Feb 2024 09:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICICfeq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D76B8789B; Fri,  2 Feb 2024 09:03:18 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AF887527
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 09:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d2df857929so757989241.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 00:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706860994; x=1707465794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=INBRw8uDbgIPgHMOfeIrxRogtpBwYSCD+lrDrw7uJBA=;
 b=ICICfeq+n7Y8FPTb/U2ZCd7TKpgkqkAKPeepiDaG/FyNtdSgbW7ZwOO3dnDJtpP+gU
 9n/wAIE0flb1TMC2jgrOcWCJHjh4OXSh3XVe2Gn1cEC1M1Hi7id7R4Rkn1wpHHByVqs0
 GBA+giP1IGRhuQVbk6MhklU2Vp8uBlboHcBcUldARjEeKo4bMDP9LeJy5bSsnnebVAsj
 yJCHDCfS8I387VjkdssRvNVZyykkVpdCfqU6MSUXiE+q/eimNte4n07RG88d/hWoscQ7
 izj+1YYQcIvaJMvMYFTOKVbLoTwzUBuRcRffiaQgf+E3pTDJciZu5z1Ym3ullEXJFOzU
 tQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706860994; x=1707465794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INBRw8uDbgIPgHMOfeIrxRogtpBwYSCD+lrDrw7uJBA=;
 b=PmEMZigrwrZNjEjJml3C3eyfVb+53lrF75LGGQJeAXx2DxUCkvNa8yUlXFL6bzdhIh
 HSh9mvl+lG6MT6AKEtN6v7UFuo2gei0qS0X2XkN0AmvY6LdqJBNgO/0lrPSmZXtf6YVJ
 IZDyxd4RQ0dGUyeATh1ZsgTCCmpZghwN64UtZlszyRL+wJK8fXEfxrOVBmsf8OSftonU
 hdo2YpURP3lfuxEvS+lZ5LNMjc0SpvHjYPmrM5Mxq15+TAl74xw5kO04jT7JALRcPPl+
 WBxCAOt1q0gBkQ/CxZjyupDX/Bd0PytplXErxgc/a2EhQca6p/gbOMXOdoPvJSjucJqm
 CCuw==
X-Gm-Message-State: AOJu0YzkbPZdMMb8WZ1zU7Q2dTWMbk+FBEjovvIKf+dBy70MJfl6Tzhm
 9VcSjgHH5HZcW1wHBWtajiEisyBOb0FMEgSwtufeRxIi4W/u+z8lp7R5kYkUEB0I4Ua8O6w/SJE
 QUvuCCfC6zJ7lEitHD95ZYfSX96ZrlUsGE7ZmyQ==
X-Google-Smtp-Source: AGHT+IH11Q1egfEAlZuL3JgmtwHErJKVJuV9e7ZG9Blmt0WssRPVye6rjl0E+Mm5Fk4NUmTcnJq8iapl4Pb1DqEhW8U=
X-Received: by 2002:a05:6102:11ea:b0:46c:ff85:63c9 with SMTP id
 e10-20020a05610211ea00b0046cff8563c9mr1252801vsg.11.1706860994016; Fri, 02
 Feb 2024 00:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-17-bb@ti.com>
In-Reply-To: <20240201030634.1120963-17-bb@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 13:33:02 +0530
Message-ID: <CAFA6WYNU0OoEYL82F=Yz0koY+JLhQPivrWqUOZB=miAJmD9nRQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Introduce basic support for TI's AM62Px SoC
 family
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Nishanth Menon <nm@ti.com>, 
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
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

Hi Bryan,

On Thu, 1 Feb 2024 at 08:36, Bryan Brattlof <bb@ti.com> wrote:
>
> Hello Again Everyone!
>
> **Note:**  This series depends on the OF_UPSTREAM work from Sumit [0].
> Patch #11 was added to fix some Makefile.spl targets to allow SPL builds
> to complete with the OF_UPSTREAM series.

Thanks for your adoption of OF_UPSTREAM work. As evident from this
series, it would be much easier to maintain U-Boot specific DT pieces
rather than the full SoC specific DT copy from Linux source tree.

-Sumit

>
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
>
> Some highlights of AM62P SoC are:
>
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Dual/Single core variants are provided in the same package to allow HW
>   compatible designs.
>
> * One Device manager Cortex-R5F for system power and resource
>   management, and one Cortex-R5F for Functional Safety or
>   general-purpose usage.
>
> * One 3D GPU up to 50 GLFOPS
>
> * H.264/H.265 Video Encode/Decode.
>
> * Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
>   2x OLDI-SL), DSI, or DPI. Up to 3840x1080 @ 60fps resolution
>
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
>
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
>
> * Dedicated Centralized Hardware Security Module with support for secure
>   boot, debug security and crypto acceleration and trusted execution
>   environment.
>
> * One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
>
> * Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
>   enabling battery powered system design.
>
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here: https://www.ti.com/lit/pdf/spruj83
>
> Proof-of-Life: https://paste.sr.ht/~bryanb/af2ac108a9362549aa326f182e87918d52bf2d71
>
> Currently, while more peripherals are being added in Linux[0], this
> series will only support UART boot.
>
> Thanks for reviewing!
> ~Bryan
>
> Changes from v1: [1]
>  - squashed all clk and lpsc tree updates into a single commit
>  - corrected SOC_K3_AM642 typo with DM firmware Kconfig option
>  - updated RM configs and dma nodes to enable IP that need DMA
>  - added the dtb targets to the dts/Makefile
>  - rebased the series on top of v2024.01-rc1
>  - switched to bootstd rather than use distro boot scripts.
>  - enabled OF_UPSTREAM instead of using the arch/arm/dts directory
>
> [0] https://lore.kernel.org/u-boot/20240110103547.719757-1-sumit.garg@linaro.org/
> [1] https://lore.kernel.org/all/20231012230616.2101992-13-bb@ti.com/
>
> Bryan Brattlof (11):
>   soc: add info to identify the am62p SoC family
>   power: domain: ti: use IS_ENABLED macro
>   arm: mach-k3: am62px: introduce clock and device files for wkup spl
>   ram: k3-ddrss: enable the am62ax's DDR controller for am62px
>   arm: mach-k3: invert logic for split DM firmware config
>   arch: mach-k3: introduce basic files to support the am62px SoC family
>   board: ti: introduce basic board files for the am62px family
>   arm: dts: introduce am62p5 uboot dts files
>   Makefile: remove hardcoded device tree source directory
>   configs: introduce configs needed for the am62px
>   doc: board: ti: introduce am62px documentation
>
> Hari Nagalla (1):
>   firmware: ti_sci_static_data: add static DMA channel data
>
> Vignesh Raghavendra (1):
>   dma: ti: k3-udma: Add DMA PSIL mappings for AM62P and J722S
>
>  Makefile                                      |   18 +-
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi    | 2800 +++++++++++++++++
>  arch/arm/dts/k3-am62p-sk-binman.dtsi          |  173 +
>  arch/arm/dts/k3-am62p5-r5-sk.dts              |  101 +
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |   49 +
>  arch/arm/mach-k3/Kconfig                      |    9 +-
>  arch/arm/mach-k3/Makefile                     |    1 +
>  arch/arm/mach-k3/am62p5_init.c                |  280 ++
>  arch/arm/mach-k3/am62px/Kconfig               |   32 +
>  .../arm/mach-k3/include/mach/am62p_hardware.h |   83 +
>  arch/arm/mach-k3/include/mach/am62p_spl.h     |   49 +
>  arch/arm/mach-k3/include/mach/hardware.h      |    6 +
>  arch/arm/mach-k3/include/mach/spl.h           |    4 +
>  arch/arm/mach-k3/r5/Makefile                  |    1 +
>  arch/arm/mach-k3/r5/am62px/Makefile           |    6 +
>  arch/arm/mach-k3/r5/am62px/clk-data.c         |  325 ++
>  arch/arm/mach-k3/r5/am62px/dev-data.c         |   71 +
>  board/ti/am62px/Kconfig                       |   26 +
>  board/ti/am62px/MAINTAINERS                   |    9 +
>  board/ti/am62px/Makefile                      |    7 +
>  board/ti/am62px/am62px.env                    |   16 +
>  board/ti/am62px/board-cfg.yaml                |   37 +
>  board/ti/am62px/evm.c                         |   29 +
>  board/ti/am62px/pm-cfg.yaml                   |   12 +
>  board/ti/am62px/rm-cfg.yaml                   |  987 ++++++
>  board/ti/am62px/sec-cfg.yaml                  |  378 +++
>  board/ti/am62px/tifs-rm-cfg.yaml              |  879 ++++++
>  configs/am62px_evm_a53_defconfig              |  178 ++
>  configs/am62px_evm_r5_defconfig               |  137 +
>  doc/board/ti/am62px_sk.rst                    |  289 ++
>  doc/board/ti/k3.rst                           |    1 +
>  drivers/clk/ti/clk-k3.c                       |    6 +
>  drivers/dma/ti/Makefile                       |    2 +
>  drivers/dma/ti/k3-psil-am62p.c                |  325 ++
>  drivers/dma/ti/k3-psil-priv.h                 |    1 +
>  drivers/dma/ti/k3-psil.c                      |    4 +
>  drivers/firmware/ti_sci_static_data.h         |    5 +-
>  drivers/power/domain/ti-power-domain.c        |   13 +-
>  drivers/ram/Kconfig                           |    2 +-
>  drivers/soc/soc_ti_k3.c                       |    3 +
>  dts/arch/arm64/ti                             |    1 +
>  include/configs/am62px_evm.h                  |   14 +
>  include/k3-clk.h                              |    1 +
>  include/k3-dev.h                              |    1 +
>  scripts/Makefile.spl                          |   17 +-
>  46 files changed, 7374 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
>  create mode 100644 arch/arm/dts/k3-am62p-sk-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-am62p5-r5-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>  create mode 100644 arch/arm/mach-k3/am62p5_init.c
>  create mode 100644 arch/arm/mach-k3/am62px/Kconfig
>  create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
>  create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h
>  create mode 100644 arch/arm/mach-k3/r5/am62px/Makefile
>  create mode 100644 arch/arm/mach-k3/r5/am62px/clk-data.c
>  create mode 100644 arch/arm/mach-k3/r5/am62px/dev-data.c
>  create mode 100644 board/ti/am62px/Kconfig
>  create mode 100644 board/ti/am62px/MAINTAINERS
>  create mode 100644 board/ti/am62px/Makefile
>  create mode 100644 board/ti/am62px/am62px.env
>  create mode 100644 board/ti/am62px/board-cfg.yaml
>  create mode 100644 board/ti/am62px/evm.c
>  create mode 100644 board/ti/am62px/pm-cfg.yaml
>  create mode 100644 board/ti/am62px/rm-cfg.yaml
>  create mode 100644 board/ti/am62px/sec-cfg.yaml
>  create mode 100644 board/ti/am62px/tifs-rm-cfg.yaml
>  create mode 100644 configs/am62px_evm_a53_defconfig
>  create mode 100644 configs/am62px_evm_r5_defconfig
>  create mode 100644 doc/board/ti/am62px_sk.rst
>  create mode 100644 drivers/dma/ti/k3-psil-am62p.c
>  create mode 120000 dts/arch/arm64/ti
>  create mode 100644 include/configs/am62px_evm.h
>
>
> base-commit: b6d8969bcb94321dfed1399f2eaa8768ba42caaa
> prerequisite-patch-id: a2fa61937f80658611e0a2cdf88a11a6214b3645
> prerequisite-patch-id: 1a31af706136646f62e98e88919802b1379feb39
> prerequisite-patch-id: 54b40f9e042ef51755b4fb33ba6f8c4f6af9c17f
> prerequisite-patch-id: d2199c72fa11aea6e478f5a846f8ad786b0afc38
> prerequisite-patch-id: 00e954105cf966b9527bb6ea11373e3da2d4c26d
> prerequisite-patch-id: bb58fb490183bfd836c492ec18590d9ec3b97457
> prerequisite-patch-id: 99cb64427f3b8b401f32cd1d4cc68cd74aaa8733
> prerequisite-patch-id: c461c9afad63446e824d00017c5faab7860de0e9
> prerequisite-patch-id: fdc8c1c111e6329345f0b5c7609f2751e542d2fa
> prerequisite-patch-id: e07cf9612f806d28af7628573d73fefdd4144e63
> prerequisite-patch-id: 15ee392282a7e0d2b99bcf9cded71f965fc32a5b
> prerequisite-patch-id: 91cdc33aa65dd1d205fb8fea5de2980fe2ab2f62
> --
> 2.43.0
>
