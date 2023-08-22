Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9976FEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 08:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDAE8646E;
	Tue, 22 Aug 2023 10:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N5EZ1K1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C134863C9; Tue, 22 Aug 2023 10:19:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BBD86478
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 10:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692692342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCkujHkLcQ39i4D0MWyLYDZ8AA6I1A0+C6ov1Fuylxs=;
 b=N5EZ1K1xE+xyo3NKwbrkwIA9qKVEyVgYFAGrH9tLbcd8CGXRt4ICUxVNFKcfAWqc2doYqE
 ZiFjG7TGpLQnh8I3s/j2sboeHEVoF6JmUgb56E831AJaU87UYoJe5Q0tzfI57JP/n4S7jc
 a5vlmkodhE6fh9UgsT8a8pGzgsyDgW4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-HTafxjFoP9iwQHO_jlXyJg-1; Tue, 22 Aug 2023 04:19:01 -0400
X-MC-Unique: HTafxjFoP9iwQHO_jlXyJg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a7d4302c71so3685064b6e.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 01:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692692340; x=1693297140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eCkujHkLcQ39i4D0MWyLYDZ8AA6I1A0+C6ov1Fuylxs=;
 b=h98ZDFTl45V9W8PhaWBZ1U0azRrio7iH5Po/D1s12RRNPj/WziSmIYtZZu6IGK1IyT
 iOQlzLSl2VWM4mDbqq4fSahwlMPzoJdquMVql1StfM34b44TXlcS89DwV2JdWTAuwL/h
 vOf0cp3kfH5SnhCe7udFp43vAwERJ+V6drXD+7hX1V+gUOLPdF4crJ+M815tYBAz3suJ
 0N+wlqYggvlUOhRYyXFrsgWr6nQMdl0/NQJGwPVDS+x3LCkXbO0HjbO+0e0eKV16Q3rh
 O4V0HbHKCBqkji7KLs8Avt4IOWh0Wfzw/QutqetvRbbxqhVxRMa6DvoK9y0QwscEEByz
 IvdA==
X-Gm-Message-State: AOJu0YzFxMK2Z65ZNMlEK9pRVp1LGkhvYBrZ+Cp+hoqqnjPYLa2s3DRc
 jZGDxyc/HB/O5eZC8UIMD2qH8HYWk5ye5czF/AUUnWcGQd5P78baGN8+Ou95dLNLGFStvE8cJeL
 Oh0ljMiWJvNAbMg1WFuQCZqyM4C8XtA==
X-Received: by 2002:aca:210f:0:b0:3a7:349d:35e8 with SMTP id
 15-20020aca210f000000b003a7349d35e8mr4951275oiz.14.1692692340374; 
 Tue, 22 Aug 2023 01:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7I8LKt/kfMC8XuZxzcTDNxhaDCvFhpBDEiCF3/+BWBapvDC9JBBjaKUTiLGARb65wA2c14GuLDlAiPCRubc0=
X-Received: by 2002:aca:210f:0:b0:3a7:349d:35e8 with SMTP id
 15-20020aca210f000000b003a7349d35e8mr4951261oiz.14.1692692339984; Tue, 22 Aug
 2023 01:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230321141028.24456-1-hnagalla@ti.com>
In-Reply-To: <20230321141028.24456-1-hnagalla@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 22 Aug 2023 10:18:49 +0200
Message-ID: <CALE0LRse=69tbj8g8m0L7FHu=D1MVtzL_pBN3Vm-2eOv3_HtKQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Introduce initial TI's J784S4 support
To: Hari Nagalla <hnagalla@ti.com>
Cc: trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, 
 jh80.chung@samsung.com, nm@ti.com, afd@ti.com, a-nandan@ti.com, 
 u-boot@lists.denx.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

Hi Hari,

On Tue, Mar 21, 2023 at 3:12=E2=80=AFPM Hari Nagalla <hnagalla@ti.com> wrot=
e:
>
> Hello Everyone!
>
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
>
> The J784S4 SoC device tree patches are taken from kernel patch submission=
s
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.
>
> Here are some of the salient features of the J784S4 automotive grade
> application processor:
>
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
>
> Some highlights of this SoC are:
> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F =
MCUs,
>   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) =
for
>   deep learning and CNN.
> * 3D GPU: Automotive grade IMG BXS-4-64
> * Vision Processing Accelerator (VPAC) with image signal processor and De=
pth
>   and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and on=
e
>   DPI interface.
> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-rol=
e
>   device subsystems, Up to 20 MCANs, among other peripherals.
>
> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> for further details: http://www.ti.com/lit/zip/spruj52
>
> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
> supports the following interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mod=
e
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
>
> Schematics: https://www.ti.com/lit/zip/sprr458
>
> bootlog: https://paste.sr.ht/~hnagalla/f14840abc854519f912923662f1fdc8075=
d92107
>

Many thanks for this patchset.

There is any plan to rebase all this patchset, fix the comments and
send it again to upstream? I'd be really interested in help on this
patchset.

Thanks,
  Enric

> Changes in v2:
> - Refactored environement scripts to 'j784s4.env' and removed scripts not
>   needed for basic board bootup.
> - Imported the J7874S4 basic device tree files from v6.2 linux kernel.
> - Moved j784s4 clock definitions and clock data into one patch/commit.
> - coalesce board commits into one commit.
>
> Hari Nagalla (10):
>   arm: dts: introduce j784s4 dtbs from linux kernel
>   arm: dts: introduce j784s4 u-boot dtbs
>   arm: K3: Add basic support for J784S4 SoC definition
>   drivers: dma: Add support for J784S4
>   clk: clk-k3: Add support for J784S4 SoC
>   power: domain: ti: Add support for J784S4 SoC
>   ram: k3-ddrss: Add support for J784S4 SoC
>   soc: ti: k3-socinfo: Add entry for J784S4 SoC
>   board: ti: j784s4: Add board support for J784S4 SoC
>   dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC
>
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  | 8757 ++++++++++++++++
>  arch/arm/dts/k3-j784s4-ddr.dtsi               | 8858 +++++++++++++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  135 +
>  arch/arm/dts/k3-j784s4-evm.dts                |  196 +
>  arch/arm/dts/k3-j784s4-main.dtsi              | 1007 ++
>  arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi        |  311 +
>  arch/arm/dts/k3-j784s4-r5-evm.dts             |  209 +
>  arch/arm/dts/k3-j784s4.dtsi                   |  287 +
>  arch/arm/mach-k3/Kconfig                      |   16 +-
>  arch/arm/mach-k3/Makefile                     |    2 +
>  arch/arm/mach-k3/arm64-mmu.c                  |   41 +
>  arch/arm/mach-k3/include/mach/hardware.h      |    4 +
>  .../mach-k3/include/mach/j784s4_hardware.h    |   41 +
>  arch/arm/mach-k3/include/mach/j784s4_spl.h    |   46 +
>  arch/arm/mach-k3/include/mach/spl.h           |    6 +-
>  arch/arm/mach-k3/j784s4/Makefile              |    5 +
>  arch/arm/mach-k3/j784s4/clk-data.c            |  428 +
>  arch/arm/mach-k3/j784s4/dev-data.c            |   97 +
>  arch/arm/mach-k3/j784s4_init.c                |  319 +
>  board/ti/j784s4/Kconfig                       |   61 +
>  board/ti/j784s4/MAINTAINERS                   |    7 +
>  board/ti/j784s4/Makefile                      |    8 +
>  board/ti/j784s4/evm.c                         |  105 +
>  board/ti/j784s4/j784s4.env                    |  108 +
>  configs/j784s4_evm_a72_defconfig              |  213 +
>  configs/j784s4_evm_r5_defconfig               |  179 +
>  drivers/clk/ti/clk-k3.c                       |    6 +
>  drivers/dma/ti/Makefile                       |    1 +
>  drivers/dma/ti/k3-psil-j784s4.c               |  166 +
>  drivers/dma/ti/k3-psil-priv.h                 |    1 +
>  drivers/dma/ti/k3-psil.c                      |    2 +
>  drivers/firmware/ti_sci_static_data.h         |   35 +
>  drivers/power/domain/ti-power-domain.c        |    6 +
>  drivers/ram/Kconfig                           |    2 +-
>  drivers/soc/soc_ti_k3.c                       |    6 +
>  include/configs/j784s4_evm.h                  |   49 +
>  include/dt-bindings/mux/ti-serdes.h           |   62 +
>  include/dt-bindings/pinctrl/k3.h              |    3 +
>  include/k3-clk.h                              |    1 +
>  include/k3-dev.h                              |    1 +
>  41 files changed, 21781 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4.dtsi
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>  create mode 100644 arch/arm/mach-k3/j784s4/Makefile
>  create mode 100644 arch/arm/mach-k3/j784s4/clk-data.c
>  create mode 100644 arch/arm/mach-k3/j784s4/dev-data.c
>  create mode 100644 arch/arm/mach-k3/j784s4_init.c
>  create mode 100644 board/ti/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/MAINTAINERS
>  create mode 100644 board/ti/j784s4/Makefile
>  create mode 100644 board/ti/j784s4/evm.c
>  create mode 100644 board/ti/j784s4/j784s4.env
>  create mode 100644 configs/j784s4_evm_a72_defconfig
>  create mode 100644 configs/j784s4_evm_r5_defconfig
>  create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
>  create mode 100644 include/configs/j784s4_evm.h
>
> --
> 2.17.1
>

