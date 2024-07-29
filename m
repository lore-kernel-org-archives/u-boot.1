Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E32C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238D38887D;
	Mon, 29 Jul 2024 22:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YGikpqFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8918788884; Mon, 29 Jul 2024 22:03:00 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752FB887B9
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so50639861fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722283378; x=1722888178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kkP3fPirEpxKiI+Vo2IKweO4duuuEJET9VA66q0ijCs=;
 b=YGikpqFiZUYUur4+8Dpl4BLM9lP93FpTtmrHW1DKbZfa8sgMJ26UmID/FbZgHZLeXN
 04HuUOjbcwKDTpV+Bx3PFw4h2FKVmhfBuqAgfuLeE8073bebiz2zZsmg9ViOcyVyXTCM
 G4FDEGSfwptvze3WgthGBsJAJTsGfNuzDO4AcXf9dG837jOQfgWvt612xdZElLe99Pjf
 DDW58/YzK3UgdKR3RMSToD+ZIHuUNI9otc/ibFyqOoXXEy9prS4DXn6MQLl3ZlZPqrTe
 OiIwQcE/kEOGKIc2vC6DHfZdkXLCwrdpvbJNsjrqQL2RhyDcTo0YP9/df3wAmQAY9tuA
 Uolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722283378; x=1722888178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkP3fPirEpxKiI+Vo2IKweO4duuuEJET9VA66q0ijCs=;
 b=YsofURfiLIHZG28lkGS9RXOe0MwfOBgc6MvzLFyxrw2Z70R4WDAQ2wQComFAW3ywbu
 8nm6eNDPJfBDp1UEUOWD8LIdXsOeClHbaTniuzaaN+y6RQHoleKdaqmY8ZrY5J4dFOkY
 OaXblIT8H6HQoOnO5XkptyS6jk8arp5W2m+432pMHEKouay3uUQ+nwI2GfrcYPyKQBla
 ud7jigFKrfXnAQvxFunrPYcmOq9Werq/yYAddhBYlJonbVk/b3J0r1IoFFpLjLqJHnX/
 yRUuScIDDubWN3N3f5y4Ig7D+unwPhToh04uvUMuqOtYvJF+akc2oZa/udVsASJgXB66
 TMtQ==
X-Gm-Message-State: AOJu0Yx1UKwR+ngrARoqVqSAnqs0SsWHEC6a8HkuAxC+33l5br2GQ7E3
 +2Rs+h9goYNzVR8kDv3b5bt/W833jtcOoZnmgwUM87aIQxcXm9Q7ItrK9fxy7Ou+5Zdx1lW+kp0
 CNjXwM9jnXiE5suvV+0tdyweG5mQ=
X-Google-Smtp-Source: AGHT+IH25z6mZdekgBCRFznRehxLNJo4znAqRjVVyep9LFmjEZ0iF9TvMAr1O7CqfO4LI6qT2fQJ3J2VRlk8Ikt26ok=
X-Received: by 2002:a2e:9b07:0:b0:2ef:284e:1d07 with SMTP id
 38308e7fff4ca-2f12ecd2952mr60062871fa.13.1722283377164; Mon, 29 Jul 2024
 13:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 29 Jul 2024 21:02:46 +0100
Message-ID: <CALeDE9OztBrRDbj8ScFq6e+0XR_Xivxy1NQAOjrsqdqvzRTZTw@mail.gmail.com>
Subject: Re: [PATCH 00/17] Implement ACPI on aarch64
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, trini@konsulko.com, 
 sjg@chromium.org, bmeng.cn@gmail.com
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

> Based on the existing work done by Simon Glass this series adds
> support for booting aarch64 devices using ACPI only. As target the
> Raspberry Pi4 was used, which is broadly available and allows easy
> testing of the proposed solution.

Rather than just RPi4 support we should add generic qemu support, as
opposed to emulated RPi4 in qemu support as qemu already supports ACPI
on aarch64 for generic SystemReady support with pci/network etc that
way the support is much easier to test in CI.

Also are the ACPI tables you use here compatible with the tianocore
raspberry pi 4 support so users don't end up with weird differences
between firmware?

> The series is split into ACPI cleanups and code movements, adding
> Arm specific ACPI tables and finally SoC and mainboard related
> changes to boot a Linux on the RPi4. Currently only the mandatory
> ACPI tables are supported, allowing to boot into Linux without errors.
>
> The changes were tested on real hardware as well on QEMU v9.0:
>
> qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
> -smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
> -dtb bcm2711-rpi-4-b.dtb -nographic
>
> Please note that the current implementation still requires a DTB to be
> provided to U-Boot and that the DTB is used within U-Boot to load drivers,
> to disable/enable certain hardware blocks in ACPI. The DTB is not passed
> to the OS when using the bootefi cmd.
>
> Tested against FWTS V24.03.00.
>
> Known issues:
> - The QEMU support is currently limited as it doesn't emulate PCI, USB or
>   ethernet devices!
> - The SMP bringup doesn't work on real hardware, but works in QEMU.
> - PCI isn't working on real hardware since the pcie_brcmstb Linux kernel
>   module doesn't support ACPI yet.
>
> Maximilian Brune (3):
>   acpi: x86: Move SPCR and DBG2 into common code
>   acpi: x86: Write FADT in common code
>   serial: serial_pl01x: Implement .getinfo() for PL01
>
> Patrick Rudolph (12):
>   acpi: x86: Move MADT to common code
>   acpi: Fix typo
>   acpi: Add define for GTDT
>   arm: acpi: Add generic ACPI methods
>   acpi: acpi_table: Bump revisions
>   acpi: Add ACPITAB for PPTT and GTDT
>   arm: mach-bcm283x: Map the ARM local MMIO as well
>   arm: bcm283x: Write ACPI tables
>   arm: cpu: Add ACPI parking protocol support
>   arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
>   arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
>   configs: Add RPI4 ACPI defconfig
>
> Simon Glass (2):
>   arm: mach-bcm283x: Bring in some header files from tianocore
>   board: raspberrypi: Add ASL files from tianocore
>
>  arch/arm/cpu/armv8/Makefile                   |   1 +
>  arch/arm/cpu/armv8/parking_protocol_v8.S      | 102 +++++
>  arch/arm/cpu/armv8/start.S                    |   4 +
>  arch/arm/include/asm/acpi_table.h             |  70 ++++
>  arch/arm/lib/Makefile                         |   1 +
>  arch/arm/lib/acpi_table.c                     | 131 ++++++
>  arch/arm/mach-bcm283x/Kconfig                 |   4 +
>  arch/arm/mach-bcm283x/Makefile                |   4 +
>  arch/arm/mach-bcm283x/bcm2711_acpi.c          | 172 ++++++++
>  .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++++
>  .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++++
>  .../include/mach/acpi/bcm2836_gpio.h          |  19 +
>  .../include/mach/acpi/bcm2836_gpu.h           |  47 +++
>  .../include/mach/acpi/bcm2836_pwm.h           |  33 ++
>  .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
>  .../include/mach/acpi/bcm2836_sdio.h          |  21 +
>  arch/arm/mach-bcm283x/init.c                  |  79 +++-
>  arch/sandbox/lib/Makefile                     |   9 +-
>  arch/sandbox/lib/acpi_table.c                 |   7 +
>  arch/x86/cpu/apollolake/acpi.c                |  20 +-
>  arch/x86/cpu/baytrail/acpi.c                  |  17 +-
>  arch/x86/cpu/intel_common/acpi.c              |  20 +-
>  arch/x86/cpu/quark/acpi.c                     |  19 +-
>  arch/x86/cpu/tangier/acpi.c                   |  31 +-
>  arch/x86/include/asm/acpi_table.h             |  26 +-
>  arch/x86/lib/acpi_table.c                     | 243 +-----------
>  board/raspberrypi/rpi/.gitignore              |   3 +
>  board/raspberrypi/rpi/Makefile                |   2 +
>  board/raspberrypi/rpi/acpitables.h            |  91 +++++
>  board/raspberrypi/rpi/dsdt.asl                | 290 ++++++++++++++
>  board/raspberrypi/rpi/emmc.asl                | 136 +++++++
>  board/raspberrypi/rpi/gpudevs.asl             | 372 ++++++++++++++++++
>  board/raspberrypi/rpi/pci.asl                 | 177 +++++++++
>  board/raspberrypi/rpi/pep.asl                 |  90 +++++
>  board/raspberrypi/rpi/rhpx.asl                | 195 +++++++++
>  board/raspberrypi/rpi/rpi.c                   | 182 +++++++++
>  board/raspberrypi/rpi/sdhc.asl                | 111 ++++++
>  board/raspberrypi/rpi/uart.asl                | 208 ++++++++++
>  boot/bootflow.c                               |   8 +-
>  configs/rpi_4_acpi_defconfig                  |  79 ++++
>  drivers/pci/pcie_brcmstb.c                    | 101 +----
>  drivers/serial/serial_pl01x.c                 |  24 ++
>  include/acpi/acpi_table.h                     | 107 +++--
>  include/serial.h                              |   1 +
>  lib/Kconfig                                   |  15 +
>  lib/acpi/acpi_table.c                         | 317 ++++++++++++++-
>  46 files changed, 3414 insertions(+), 472 deletions(-)
>  create mode 100644 arch/arm/cpu/armv8/parking_protocol_v8.S
>  create mode 100644 arch/arm/lib/acpi_table.c
>  create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
>  create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
>  create mode 100644 arch/sandbox/lib/acpi_table.c
>  create mode 100644 board/raspberrypi/rpi/.gitignore
>  create mode 100644 board/raspberrypi/rpi/acpitables.h
>  create mode 100644 board/raspberrypi/rpi/dsdt.asl
>  create mode 100644 board/raspberrypi/rpi/emmc.asl
>  create mode 100644 board/raspberrypi/rpi/gpudevs.asl
>  create mode 100644 board/raspberrypi/rpi/pci.asl
>  create mode 100644 board/raspberrypi/rpi/pep.asl
>  create mode 100644 board/raspberrypi/rpi/rhpx.asl
>  create mode 100644 board/raspberrypi/rpi/sdhc.asl
>  create mode 100644 board/raspberrypi/rpi/uart.asl
>  create mode 100644 configs/rpi_4_acpi_defconfig
>
> --
> 2.45.2
>
