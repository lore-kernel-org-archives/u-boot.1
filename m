Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9ACD1D88B
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B0488969;
	Tue, 15 Oct 2024 18:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LNPe8Yph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D1988916; Tue, 15 Oct 2024 18:34:49 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E4E88717
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 18:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e0875f1e9edso4835563276.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729010084; x=1729614884; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4AuGSJsdri3AdkdRePUIqX5AUcxRdlL9zmYRAnS1cU=;
 b=LNPe8YphTNlXUwEb3NsIOn3USSV0krXnj6qckLX5FZ5I3VdrfDx1si9gKM/Y+OTx4Z
 ES+udJ3jk9wHWlyYwLZSUzC6KbvIvvyq/AAaBYIK5v2NZwURHLsJNaOuvB1YyIQg0ePP
 AXPU04a8oMei9FIv8S1eL/Ut4NIzZ8BwPPv9jQzqV4syR4keaB40L9JjGn737h88fZ/9
 JfW3wBxlhtI2kUDbCY24vkozo1I+SmFTXWLhWD8QXmVZayMzrORSMGUqgI8dXG6+3kdi
 rsB4AhtsM9RP3N8xV4Kafq1D1sSDbugnyqAXQwNg+lyfTpo/gvl3H+FdsZDZLRaEaFF4
 yphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729010084; x=1729614884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4AuGSJsdri3AdkdRePUIqX5AUcxRdlL9zmYRAnS1cU=;
 b=dZjqb1cW3UAW+eoqnvXIFiOnGydSiJ/L7IKPZVn38KA5PWvtB8nXSkXdxS38BXWRDC
 bq6eth6Qpa94a0nk5VGYFaQfJh1RzSt+rlW3g6aK5IR8ggUHK9iB3N9XpzLbMjlVi4bu
 PDaGri+oIFTlE3+4o72XHiggMezGSXuWbztRQG86W9ejjHXU6NS9hYUfS+uzbh4tPiXG
 HAQKLm2klovIf6u1OTpqRml7SfvpPqtsSn10CIKnoa0J2C2lOZHz7ZwkJXVDLn+a1c0p
 HievQHV+ESw4UudFtUF4wLEbt2sEN6w5jsQrRx1RRbLJXZdSK7hnlsBwD+oaUWUd/bA6
 tVkA==
X-Gm-Message-State: AOJu0YxsVrj/hvhuCKxSGuVEMw6KGbJQrooineMcBPypMdzPZiyBWQmF
 GkQFFzPO+uNbV8m51vZWGHhrFTcHkKBKBp1o5s+nPxc7IXLX/3qnO+vNQ1x3eSJ3VAoEYlW26zG
 zgX2mI8LfSKjoJU2Zl08pHg03Sas8OrD5Pt3NRzQCzs1k2ndPghE=
X-Google-Smtp-Source: AGHT+IEAoORRoJJpInmfocs9kVG7jdQORe1//8tHw8qzX2fT/PhMt72dVvRCcjB/3NwSpbQmtCNGil+oPGbSLp4s4VM=
X-Received: by 2002:a05:6902:990:b0:e29:10fe:1fc3 with SMTP id
 3f1490d57ef6-e29782ca013mr1118554276.2.1729010084445; Tue, 15 Oct 2024
 09:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
In-Reply-To: <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 15 Oct 2024 18:34:33 +0200
Message-ID: <CALNFmy3GcsOPcJ3Jxg+pXFjMG8gazyOz2wkd5HsX-rEKM3-Usg@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] Implement ACPI on aarch64
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Peter,
On Tue, Oct 15, 2024 at 12:28=E2=80=AFPM Peter Robinson <pbrobinson@gmail.c=
om> wrote:
>
> On Mon, 14 Oct 2024 at 14:12, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Based on the existing work done by Simon Glass this series adds
> > support for booting aarch64 devices using ACPI only.
> > As first target QEMU SBSA support is added, which relies on ACPI
> > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > which is broadly available and allows easy testing of the proposed
> > solution.
> >
> > The series is split into ACPI cleanups and code movements, adding
> > Arm specific ACPI tables and finally SoC and mainboard related
> > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > mandatory ACPI tables are supported, allowing to boot into Linux
> > without errors.
> >
> > The QEMU SBSA support is feature complete and provides the same
> > functionality as the EDK2 implementation.
> >
> > The changes were tested on real hardware as well on QEMU v9.0:
> >
> > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> >                     -pflash secure-world.rom \
> >                     -pflash unsecure-world.rom
> >
> > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72=
 \
> > -smp 4 -m 2G -drive file=3Draspbian.img,format=3Draw,index=3D0 \
> > -dtb bcm2711-rpi-4-b.dtb -nographic
> >
> > Tested against FWTS V24.03.00.
> >
> > Known issues:
> > - The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
> >   USB or ethernet devices!
> > - The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
> >   cache related).
> > - PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
>
> I believe the EDK2 version works by using the generic ACPI PCI driver,
> why wouldn't this use the same driver?
No, it doesn't use pcie_brcmstb, but EDK2 has workarounds for that.
Those are intentionally not done in U-Boot to keep the code as clean
and as minimal as possible.
In addition there's more code in EDK2, like support for reading UEFI
variables and configuring
certain settings. Those additional features aren't implemented here
either. Though they are not required
to boot an OS, which is the main goal of this patch series.

I don't see that those missing features are a *must* implement. It's
not EDK2. If you want to have all those
feature use EDK2 and your good.

>
> Overall given RPi4 has massive limitations I think at the moment it
> should be dropped from the series so it doesn't block the
> generic/qemu/bsa support landing. I feel it will be a support problem
> with having such a reduced functionality device in mainline.
>
Since U-Boot isn't the default boot-loader on RPI and you can still
use U-Boot and a DT to
boot an OS instead of ACPI, I don't see any issue with this. It's just
an additional possible
way to boot the OS. It might be limited to just booting, it might have
bugs, but it's still optional.

> >   Linux kernel module doesn't support ACPI yet.
> >
> > Maximilian Brune (3):
> >   acpi: x86: Move SPCR and DBG2 into common code
> >   acpi: x86: Write FADT in common code
> >   serial: serial_pl01x: Implement .getinfo() for PL01
> >
> > Patrick Rudolph (32):
> >   acpi: x86: Move MADT to common code
> >   acpi: Fix typo
> >   acpi: Add define for GTDT
> >   arm: acpi: Add generic ACPI methods
> >   acpi: Add fill_madt to acpi_ops
> >   acpi: acpi_table: Bump revisions
> >   acpi: Add ACPITAB for PPTT and GTDT
> >   acpi: acpi_table: Add IORT support
> >   acpi: Move function prototype
> >   acpi_table: Support platforms with unusable RSDT
> >   acpi: Allocate and write ACPI tables
> >   acpi: Add processor device
> >   drivers: usb: Add generic XHCI
> >   drivers: ata: Rename ahci_mvebu
> >   drivers/cpu: Add generic armv8 cpu driver
> >   arm: gic-v3-its: Rename objects
> >   arm: gic-v3-its: Implement of_xlate
> >   arm: lib: Add GICV2 driver
> >   drivers: misc: irq-uclass: Update irq_get_by_index
> >   drivers/arm: Implement acpi_fill_madt
> >   common: Enable BLOBLIST_TABLES on arm
> >   board: emulation: Add QEMU sbsa support
> >   arm: mach-bcm283x: Map the ARM local MMIO as well
> >   arm: bcm283x: Generate ACPI tables
> >   arm: cpu: Add ACPI parking protocol support
> >   armv8: cpu: Enable ACPI parking protocol
> >   arm: Implement read_mpidr on armv7
> >   arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
> >   arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
> >   bloblist: Fix use of uninitialized variable
> >   configs: Add RPI4 ACPI defconfig
> >   CI: Enable qemu_sbsa
> >
> > Simon Glass (2):
> >   arm: mach-bcm283x: Bring in some header files from tianocore
> >   board: raspberrypi: Add ASL files from tianocore
> >
> >  .azure-pipelines.yml                          |   8 +
> >  .gitlab-ci.yml                                |  11 +
> >  MAINTAINERS                                   |   2 +-
> >  arch/arm/Kconfig                              |  11 +-
> >  arch/arm/cpu/armv8/Makefile                   |   1 +
> >  arch/arm/cpu/armv8/acpi_park_v8.S             | 113 ++++
> >  arch/arm/cpu/armv8/start.S                    |  12 +
> >  arch/arm/dts/qemu-sbsa.dts                    | 137 ++++
> >  arch/arm/include/asm/acpi_table.h             | 147 ++++
> >  arch/arm/include/asm/arch-qemu-sbsa/boot0.h   |  34 +
> >  arch/arm/include/asm/system.h                 |   9 +
> >  arch/arm/lib/Makefile                         |   2 +
> >  arch/arm/lib/acpi_table.c                     | 276 ++++++++
> >  arch/arm/lib/gic-v2.c                         |  89 +++
> >  arch/arm/lib/gic-v3-its.c                     | 118 +++-
> >  arch/arm/mach-bcm283x/Kconfig                 |  16 +-
> >  arch/arm/mach-bcm283x/Makefile                |   4 +
> >  arch/arm/mach-bcm283x/bcm2711_acpi.c          | 128 ++++
> >  .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++
> >  .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++
> >  .../include/mach/acpi/bcm2836_gpio.h          |  19 +
> >  .../include/mach/acpi/bcm2836_gpu.h           |  47 ++
> >  .../include/mach/acpi/bcm2836_pwm.h           |  33 +
> >  .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
> >  .../include/mach/acpi/bcm2836_sdio.h          |  21 +
> >  arch/arm/mach-bcm283x/init.c                  |   2 +-
> >  arch/arm/mach-qemu/Kconfig                    |  36 +-
> >  arch/sandbox/dts/test.dts                     |   3 +
> >  arch/sandbox/lib/Makefile                     |   9 +-
> >  arch/sandbox/lib/acpi_table.c                 |  11 +
> >  arch/x86/cpu/apollolake/acpi.c                |  20 +-
> >  arch/x86/cpu/baytrail/acpi.c                  |  17 +-
> >  arch/x86/cpu/intel_common/acpi.c              |  22 +-
> >  arch/x86/cpu/quark/acpi.c                     |  19 +-
> >  arch/x86/cpu/tangier/acpi.c                   |  33 +-
> >  arch/x86/include/asm/acpi_table.h             |  28 +-
> >  arch/x86/lib/acpi_table.c                     | 245 +------
> >  board/emulation/qemu-arm/MAINTAINERS          |   2 +
> >  board/emulation/qemu-sbsa/Kconfig             |  58 ++
> >  board/emulation/qemu-sbsa/Makefile            |   8 +
> >  board/emulation/qemu-sbsa/acpi.c              | 192 ++++++
> >  board/emulation/qemu-sbsa/dsdt.asl            | 483 ++++++++++++++
> >  board/emulation/qemu-sbsa/lowlevel_init.S     |  22 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.c         | 273 ++++++++
> >  board/emulation/qemu-sbsa/qemu-sbsa.env       |  14 +
> >  board/emulation/qemu-sbsa/qemu-sbsa.h         |  38 ++
> >  board/emulation/qemu-sbsa/smc.c               |  71 ++
> >  board/raspberrypi/rpi/.gitignore              |   3 +
> >  board/raspberrypi/rpi/Makefile                |   2 +
> >  board/raspberrypi/rpi/acpitables.h            |  90 +++
> >  board/raspberrypi/rpi/dsdt.asl                | 254 +++++++
> >  board/raspberrypi/rpi/emmc.asl                | 136 ++++
> >  board/raspberrypi/rpi/gpudevs.asl             | 372 +++++++++++
> >  board/raspberrypi/rpi/pci.asl                 | 177 +++++
> >  board/raspberrypi/rpi/pep.asl                 |  90 +++
> >  board/raspberrypi/rpi/rhpx.asl                | 195 ++++++
> >  board/raspberrypi/rpi/rpi.c                   | 183 +++++
> >  board/raspberrypi/rpi/sdhc.asl                | 111 +++
> >  board/raspberrypi/rpi/uart.asl                | 208 ++++++
> >  boot/bootflow.c                               |   8 +-
> >  common/Kconfig                                |   1 +
> >  common/bloblist.c                             |   2 +-
> >  configs/clearfog_defconfig                    |   2 +-
> >  configs/clearfog_gt_8k_defconfig              |   2 +-
> >  configs/clearfog_sata_defconfig               |   2 +-
> >  configs/clearfog_spi_defconfig                |   2 +-
> >  configs/db-88f6820-gp_defconfig               |   2 +-
> >  configs/ds116_defconfig                       |   2 +-
> >  configs/helios4_defconfig                     |   2 +-
> >  configs/mvebu_crb_cn9130_defconfig            |   2 +-
> >  configs/mvebu_db-88f3720_defconfig            |   2 +-
> >  configs/mvebu_db_armada8k_defconfig           |   2 +-
> >  configs/mvebu_db_cn9130_defconfig             |   2 +-
> >  configs/mvebu_espressobin-88f3720_defconfig   |   2 +-
> >  .../mvebu_espressobin_ultra-88f3720_defconfig |   2 +-
> >  configs/mvebu_mcbin-88f8040_defconfig         |   2 +-
> >  configs/mvebu_puzzle-m801-88f8040_defconfig   |   2 +-
> >  configs/n2350_defconfig                       |   2 +-
> >  configs/octeon_nic23_defconfig                |   2 +-
> >  configs/qemu-arm-sbsa_defconfig               |  10 +
> >  configs/rpi_4_acpi_defconfig                  |  10 +
> >  configs/turris_omnia_defconfig                |   2 +-
> >  doc/board/emulation/index.rst                 |   1 +
> >  doc/board/emulation/qemu-sbsa.rst             |  98 +++
> >  doc/develop/driver-model/virtio.rst           |   1 +
> >  drivers/ata/Kconfig                           |  12 +-
> >  drivers/ata/Makefile                          |   2 +-
> >  drivers/ata/{ahci_mvebu.c =3D> ahci_generic.c}  |  17 +-
> >  drivers/core/acpi.c                           |  16 +
> >  drivers/cpu/Kconfig                           |   7 +
> >  drivers/cpu/Makefile                          |   2 +
> >  drivers/cpu/armv8_cpu.c                       | 151 +++++
> >  drivers/cpu/armv8_cpu.h                       |  31 +
> >  drivers/cpu/bcm283x_cpu.c                     | 214 ++++++
> >  drivers/misc/irq-uclass.c                     |  66 +-
> >  drivers/pci/pcie_brcmstb.c                    | 101 +--
> >  drivers/serial/serial_pl01x.c                 |  24 +
> >  drivers/usb/host/Kconfig                      |   8 +
> >  drivers/usb/host/Makefile                     |   1 +
> >  drivers/usb/host/xhci-generic.c               |  75 +++
> >  include/acpi/acpi_table.h                     | 324 ++++++++-
> >  include/acpi/acpigen.h                        |  12 +
> >  include/bloblist.h                            |   1 +
> >  include/configs/qemu-sbsa.h                   |  89 +++
> >  include/dm/acpi.h                             |  26 +
> >  include/irq.h                                 |  14 +
> >  include/serial.h                              |   1 +
> >  lib/Kconfig                                   |  31 +-
> >  lib/acpi/acpi_table.c                         | 630 +++++++++++++++++-
> >  lib/acpi/acpigen.c                            |  11 +
> >  test/dm/acpi.c                                |  43 ++
> >  test/dm/irq.c                                 |  15 +
> >  test/py/tests/test_event_dump.py              |   1 +
> >  113 files changed, 6512 insertions(+), 542 deletions(-)
> >  create mode 100644 arch/arm/cpu/armv8/acpi_park_v8.S
> >  create mode 100644 arch/arm/dts/qemu-sbsa.dts
> >  create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
> >  create mode 100644 arch/arm/lib/acpi_table.c
> >  create mode 100644 arch/arm/lib/gic-v2.c
> >  create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpi=
o.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu=
.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm=
.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdh=
ost.h
> >  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdi=
o.h
> >  create mode 100644 arch/sandbox/lib/acpi_table.c
> >  create mode 100644 board/emulation/qemu-sbsa/Kconfig
> >  create mode 100644 board/emulation/qemu-sbsa/Makefile
> >  create mode 100644 board/emulation/qemu-sbsa/acpi.c
> >  create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
> >  create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
> >  create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
> >  create mode 100644 board/emulation/qemu-sbsa/smc.c
> >  create mode 100644 board/raspberrypi/rpi/.gitignore
> >  create mode 100644 board/raspberrypi/rpi/acpitables.h
> >  create mode 100644 board/raspberrypi/rpi/dsdt.asl
> >  create mode 100644 board/raspberrypi/rpi/emmc.asl
> >  create mode 100644 board/raspberrypi/rpi/gpudevs.asl
> >  create mode 100644 board/raspberrypi/rpi/pci.asl
> >  create mode 100644 board/raspberrypi/rpi/pep.asl
> >  create mode 100644 board/raspberrypi/rpi/rhpx.asl
> >  create mode 100644 board/raspberrypi/rpi/sdhc.asl
> >  create mode 100644 board/raspberrypi/rpi/uart.asl
> >  create mode 100644 configs/qemu-arm-sbsa_defconfig
> >  create mode 100644 configs/rpi_4_acpi_defconfig
> >  create mode 100644 doc/board/emulation/qemu-sbsa.rst
> >  rename drivers/ata/{ahci_mvebu.c =3D> ahci_generic.c} (71%)
> >  create mode 100644 drivers/cpu/armv8_cpu.c
> >  create mode 100644 drivers/cpu/armv8_cpu.h
> >  create mode 100644 drivers/cpu/bcm283x_cpu.c
> >  create mode 100644 drivers/usb/host/xhci-generic.c
> >  create mode 100644 include/configs/qemu-sbsa.h
> >
> > --
> > 2.46.2
> >
