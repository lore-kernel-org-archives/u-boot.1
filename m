Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD9BCF8547
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4DF89001;
	Thu,  3 Oct 2024 00:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nwwSqNbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7046888F82; Thu,  3 Oct 2024 00:55:50 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2659E88FAA
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb2dffcdbbso2954986d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909745; x=1728514545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zlnMqEIqLWpmgQxcQwGIXdUr6bLmZNeyN/3QljV1iIo=;
 b=nwwSqNbwBFBYU91pMfzQYnMb1Zrs/wVLb6UEzSR1/NgI2SRVQHvd0WL/haF9TbPsp9
 8KMn9GV5kLo2zH4Pr3jAtbyJ3pYBi7tbTQOwS6xvLW85iBnHObShufzXcra10Ydad3vE
 tZ5fWYs6rvL+BXqPYep8CfVOrUhn/mRFSzmnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909745; x=1728514545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlnMqEIqLWpmgQxcQwGIXdUr6bLmZNeyN/3QljV1iIo=;
 b=HuHzDGkQ0IVL6XkKMKJYN28du9RhvB7NzTf+u8qoEuHexM3rhUULR3IaZm5LFvpS4R
 aczwrB8F/jc39uDMgxX2cImQyi6nYs6iHbDph0a5zN6ZIRlnxvtE1sYsdSxR7PLTtRBY
 aLTT92TpBT8l0QVNTKZuR5Vc4MECJ/LZuYWur7flqf90bLTpGZBqLxhoWYAxD5cS3p3z
 fyiiKmme62XW7yFsrMFav8nMMR72RQoh7LPXiXjY1fJdEWuL3AKk/gPz58m+bvaIreEt
 k69hugHlZQZ3/cruJiqu5vL+ZV+drby9ocMjiRR/8YN98z4nE0h4j9VsN1jlqIYdp9TB
 DgmA==
X-Gm-Message-State: AOJu0YxlV72AFIsY4IPiHkuGXyCYlw1kVlxq+0lbn01mBsPOCEXzUPIn
 LfuqHhJsjlaNfBXqIU18ZCv8N9NXXD9uHXwMJ3YzZv4PNQzp5cBhwBhIGAX8I2RCiy89SDEaIFr
 iaONG/ZBTxuJMsroMV2vDf9qukUBtU4qhl2J5
X-Google-Smtp-Source: AGHT+IFdSegSPFyUjQcRcpwYN+oa7KnazqfPVC0n1ca2pVwh2hMaDQBblRLseOAAULZpfoF/ftLbx6jl6UxJF7FDKTI=
X-Received: by 2002:a05:6214:469f:b0:6ca:756d:68a8 with SMTP id
 6a1803df08f44-6cb819e0ae6mr54864896d6.15.1727909744958; Wed, 02 Oct 2024
 15:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-26-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:34 -0600
Message-ID: <CAFLszTh-cEBp0-HP5XMONdwSUBepKWNgJSHLJfQ2VYW9FgJq=Q@mail.gmail.com>
Subject: Re: [PATCH v6 25/37] board: emulation: Add QEMU sbsa support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Patrick,

On Wed, 2 Oct 2024 at 03:52, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
>
> Unlike other Arm based platforms the machine only provides a minimal
> FDT that contains number of CPUs, ammount of memory and machine-version.
> The boot firmware has to provide ACPI tables to the OS.
> Due to this design a full DTB is added here as well that allows U-Boot's
> driver to properly function. The DTB is appended at the end of the U-Boot
> image and will be merged with the QEMU provided DTB.
>
> In addition provide documentation how to use, enable binman to fabricate both
> ROMs that are required to boot and add ACPI tables to make it full compatible
> to the EDK2 reference implementation.
>
> The board was tested using Fedora 40 Aarch64 Workstation. It's able
> to boot from USB and AHCI or network.
>
> Tested and found working:
> - serial
> - PCI
> - xHCI
> - Bochs display
> - AHCI
> - network using e1000e
> - CPU init
> - Booting Fedora 40
>
> 1: Server Base System Architecture (SBSA)
> 2: https://www.qemu.org/docs/master/system/arm/sbsa.html
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v3:
> - Add GIC and GIC-ITS to devicetree
> - Select GICv3 driver
> - Drop acpi_fill_madt and use driver model instead
> Changelog v4:
> - Drop CPU platform code
> - Enhance the DT to allow MADT generation from DT
> Changelog v5:
> - Add full DT and place it at the end of U-Boot
> - Merge DT with QEMU's DT
> - Drop DT generation code
> - Fix flash region length
> - Drop enable_caches()
> - Support platforms that do not pass FDT in x0
> Changelog v6:
> - Update header order
> - Drop pad-byte from DT
> - select BINMAN_FDT
> - select E1000_NO_NVM
> - drop config.h include
> - drop a few CFG_ defines that were used for SPL
>
> ---
>  arch/arm/Kconfig                            |   3 +-
>  arch/arm/dts/qemu-sbsa.dts                  | 136 ++++++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  57 +++
>  board/emulation/qemu-sbsa/Makefile          |   8 +
>  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
>  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
>  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
>  board/emulation/qemu-sbsa/qemu-sbsa.c       | 311 +++++++++++++
>  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
>  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
>  board/emulation/qemu-sbsa/smc.c             |  71 +++
>  configs/qemu-arm-sbsa_defconfig             |  10 +
>  doc/board/emulation/index.rst               |   1 +
>  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
>  doc/develop/driver-model/virtio.rst         |   1 +
>  include/configs/qemu-sbsa.h                 |  95 ++++
>  19 files changed, 1605 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/dts/qemu-sbsa.dts
>  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
>  create mode 100644 board/emulation/qemu-sbsa/Kconfig
>  create mode 100644 board/emulation/qemu-sbsa/Makefile
>  create mode 100644 board/emulation/qemu-sbsa/acpi.c
>  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
>  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
>  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
>  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
>  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
>  create mode 100644 board/emulation/qemu-sbsa/smc.c
>  create mode 100644 configs/qemu-arm-sbsa_defconfig
>  create mode 100644 doc/board/emulation/qemu-sbsa.rst
>  create mode 100644 include/configs/qemu-sbsa.h

With the tweaks below:

Reviewed-by: Simon Glass <sjg@chromium.org>

[..]

> diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
> new file mode 100644
> index 0000000000..f743ea3863
> --- /dev/null
> +++ b/arch/arm/dts/qemu-sbsa.dts
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Devicetree with onboard devices for qemu_sbsa-ref for internal use only!
> + * DO NOT PASS TO THE OS!
> + *
> + * As QEMU provides only a minimal devicetree this one is merged with
> + * it and then fixed at runtime.
> + *
> + * Copyright 2024 9elements GmbH
> + */
> +#include "configs/qemu-sbsa.h"
> +
> +/dts-v1/;
> +
> +#define MAKE_PROP(x) (x>>32) (x&0xffffffff)
> +
> +/ {
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       interrupt-parent = <&intc>;
> +       compatible = "linux,sbsa-ref";
> +
> +       binman: binman {
> +               multiple-images;
> +       };
> +
> +       cpus {
> +               /* Filled by fdtdec_board_setup() */
> +       };
> +
> +       memory {
> +               /* Filled by fdtdec_board_setup() */
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               uart0 {
> +                       compatible = "arm,pl011";
> +                       status = "okay";
> +                       reg = <MAKE_PROP(SBSA_UART_BASE_ADDR)

Can you use

reg = /bits 64/ <0x60000000>

instead?

Same for those below.

> +                              MAKE_PROP(SBSA_UART_LENGTH)>;
> +               };
> +
> +               ahci {
> +                       compatible = "generic-ahci";
> +                       status = "okay";
> +                       reg = <MAKE_PROP(SBSA_AHCI_BASE_ADDR)
> +                              MAKE_PROP(SBSA_AHCI_LENGTH)>;
> +               };
> +
> +               xhci {
> +                       compatible = "generic-xhci";
> +                       status = "okay";
> +                       reg = <MAKE_PROP(SBSA_XHCI_BASE_ADDR)
> +                              MAKE_PROP(SBSA_XHCI_LENGTH)>;
> +               };
> +
> +               pci {
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       compatible = "pci-host-ecam-generic";
> +                       device_type = "pci";
> +                       status = "okay";
> +                       reg = <MAKE_PROP(SBSA_PCIE_ECAM_BASE_ADDR)
> +                              MAKE_PROP(SBSA_PCIE_ECAM_LENGTH)>;
> +                       bus-range = <0 0xff>;
> +                       ranges = <0x01000000 0 0
> +                                 MAKE_PROP(SBSA_PIO_BASE_ADDR)
> +                                 MAKE_PROP(SBSA_PIO_LENGTH)>,
> +                                <0x02000000 MAKE_PROP(SBSA_PCIE_MMIO_BASE_ADDR)
> +                                 MAKE_PROP(SBSA_PCIE_MMIO_BASE_ADDR)
> +                                 MAKE_PROP(SBSA_PCIE_MMIO_LENGTH)>,
> +                                <0x43000000 MAKE_PROP(SBSA_PCIE_MMIO_HIGH_BASE_ADDR)
> +                                 MAKE_PROP(SBSA_PCIE_MMIO_HIGH_BASE_ADDR)
> +                                 MAKE_PROP(SBSA_PCIE_MMIO_HIGH_LENGTH)>;
> +               };
> +       };
> +
> +       intc: interrupt-controller {
> +               compatible = "arm,gic-v3";
> +               #interrupt-cells = <1>;
> +               status = "okay";
> +               interrupt-controller;
> +               interrupts = <25>;
> +               reg = <MAKE_PROP(SBSA_GIC_DIST_BASE_ADDR)
> +                       MAKE_PROP(SBSA_GIC_DIST_LENGTH)>,
> +                       <MAKE_PROP(SBSA_GIC_REDIST_BASE_ADDR)
> +                       MAKE_PROP(SBSA_GIC_REDIST_LENGTH)>,
> +                       <0 0 0 0>,
> +                       <MAKE_PROP(SBSA_GIC_HBASE_ADDR)
> +                       MAKE_PROP(SBSA_GIC_HBASE_LENGTH)>,
> +                       <MAKE_PROP(SBSA_GIC_VBASE_ADDR)
> +                       MAKE_PROP(SBSA_GIC_VBASE_LENGTH)>;
> +       };
> +
> +       its {
> +               compatible = "arm,gic-v3-its";
> +               status = "disabled";
> +       };
> +};
> +
> +&binman {
> +       secure-world {
> +               filename = "secure-world.rom";
> +               size = <SBSA_SECURE_FLASH_LENGTH>;
> +
> +               bl1 {
> +                       offset = <0x0>;
> +                       description = "ARM Trusted Firmware BL1";
> +                       filename = "bl1.bin";

We should create a new entry type for this, like atf-bl31 - but that
can come later.

> +                       type = "blob-ext";
> +               };
> +
> +               fip {
> +                       offset = <0x12000>;
> +                       description = "ARM Trusted Firmware FIP";
> +                       filename = "fip.bin";

Normally binman would create the fip, but  for now this is fine.

> +                       type = "blob-ext";
> +               };
> +       };
> +
> +       unsecure-world {
> +               filename = "unsecure-world.rom";
> +               size = <SBSA_FLASH_LENGTH>;
> +
> +               u-boot {
> +               };
> +               u-boot-dtb {
> +                       compress = "lz4";
> +               };
> +       };
> +};

[..]

> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> index 8ac9c94caf..31b94d0467 100644
> --- a/doc/develop/driver-model/virtio.rst
> +++ b/doc/develop/driver-model/virtio.rst
> @@ -34,6 +34,7 @@ The following QEMU targets are supported.
>
>    - qemu_arm_defconfig
>    - qemu_arm64_defconfig
> +  - qemu-arm-sbsa_defconfig
>    - qemu-riscv32_defconfig
>    - qemu-riscv64_defconfig
>    - qemu-x86_defconfig
> diff --git a/include/configs/qemu-sbsa.h b/include/configs/qemu-sbsa.h
> new file mode 100644
> index 0000000000..efc96981d3
> --- /dev/null
> +++ b/include/configs/qemu-sbsa.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 9elements GmbH
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +/* Physical memory map */
> +
> +/* SECURE_FLASH */
> +#define SBSA_SECURE_FLASH_BASE_ADDR    0x00000000
> +#define SBSA_SECURE_FLASH_LENGTH       0x10000000
> +
> +/* FLASH */
> +#define SBSA_FLASH_BASE_ADDR           0x10000000
> +#define SBSA_FLASH_LENGTH              0x10000000
> +
> +/* PERIPH */
> +#define SBSA_PERIPH_BASE_ADDR          0x40000000
> +
> +/* GIC_DIST */
> +#define SBSA_GIC_DIST_BASE_ADDR                0x40060000
> +#define SBSA_GIC_DIST_LENGTH           0x00020000
> +
> +#define SBSA_GIC_VBASE_ADDR            0x2c020000
> +#define SBSA_GIC_VBASE_LENGTH          0x00010000
> +
> +#define SBSA_GIC_HBASE_ADDR            0x2c010000
> +#define SBSA_GIC_HBASE_LENGTH          0x00010000
> +
> +/* GIC_REDIST */
> +#define SBSA_GIC_REDIST_BASE_ADDR      0x40080000
> +#define SBSA_GIC_REDIST_LENGTH         0x04000000
> +
> +/* GIC_ITS */
> +#define SBSA_GIC_ITS_BASE_ADDR         0x44081000
> +
> +/* UART */
> +#define SBSA_UART_BASE_ADDR            0x60000000
> +#define SBSA_UART_LENGTH               0x00001000
> +
> +/* RTC */
> +#define SBSA_RTC_BASE_ADDR             0x60010000
> +
> +/* GPIO */
> +#define SBSA_GPIO_BASE_ADDR            0x60020000
> +
> +/* SMMU */
> +#define SBSA_SMMU_BASE_ADDR            0x60050000
> +
> +/* SATA */
> +#define SBSA_AHCI_BASE_ADDR            0x60100000
> +#define SBSA_AHCI_LENGTH               0x00010000
> +
> +/* xHCI */
> +#define SBSA_XHCI_BASE_ADDR            0x60110000
> +#define SBSA_XHCI_LENGTH               0x00010000
> +
> +/* PIO */
> +#define SBSA_PIO_BASE_ADDR             0x7fff0000
> +#define SBSA_PIO_LENGTH                        0x00010000
> +
> +/* PCIE_MMIO */
> +#define SBSA_PCIE_MMIO_BASE_ADDR       0x80000000
> +#define SBSA_PCIE_MMIO_LENGTH          0x70000000
> +#define SBSA_PCIE_MMIO_END             0xefffffff
> +
> +/* PCIE_ECAM */
> +#define SBSA_PCIE_ECAM_BASE_ADDR       0xf0000000
> +#define SBSA_PCIE_ECAM_LENGTH          0x10000000
> +#define SBSA_PCIE_ECAM_END             0xffffffff
> +
> +/* PCIE_MMIO_HIGH */
> +#ifdef __ACPI__
> +#define SBSA_PCIE_MMIO_HIGH_BASE_ADDR  0x100000000
> +#define SBSA_PCIE_MMIO_HIGH_LENGTH     0xFF00000000
> +#define SBSA_PCIE_MMIO_HIGH_END                0xFFFFFFFFFF
> +#else
> +#define SBSA_PCIE_MMIO_HIGH_BASE_ADDR  0x100000000ULL
> +#define SBSA_PCIE_MMIO_HIGH_LENGTH     0xFF00000000ULL
> +#define SBSA_PCIE_MMIO_HIGH_END                0xFFFFFFFFFFULL
> +#endif
> +
> +/* MEM */
> +#ifdef __ACPI__
> +#define SBSA_MEM_BASE_ADDR             0x10000000000
> +#else
> +#define SBSA_MEM_BASE_ADDR             0x10000000000ULL
> +#endif
> +
> +#define CFG_SYS_INIT_RAM_ADDR          SBSA_MEM_BASE_ADDR
> +#define CFG_SYS_INIT_RAM_SIZE          0x1000000

Can you move these to the file that needs them? We are trying to keep
this file empty.

> +
> +#endif /* __CONFIG_H */
> --
> 2.46.2
>

Regards,
Simon
