Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB0EC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14215888FA;
	Mon, 29 Jul 2024 17:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2mYhZne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621AA888E5; Mon, 29 Jul 2024 17:29:09 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3067788896
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a1dcba8142so233513685a.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266946; x=1722871746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TmT3EAylTEZM05yKD3kX42KYVSirHjKrECrz0R343fM=;
 b=S2mYhZnea9wGpa5k0Cvql3p4CuwsEaRaa4HlvFotV9eAkLeUt3pXA3xMQrHQrQeYBo
 TkyNGf7f0lShDE0Y9rgZGt93TKkxct4UW+dF5n1QbClNhm07DAqc1c/jhI9/B5om+AtY
 C0rHVvT6C/VqabJLFbfCs1BMwhYTmqh8Xf4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266946; x=1722871746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TmT3EAylTEZM05yKD3kX42KYVSirHjKrECrz0R343fM=;
 b=mFp/oHR0vXQ0JKGBGDEl/merE6IHMjenyYkELBMizP1EZbBjw2Xv7ZkuFxhRfwD/0W
 Si17Fo+IujucFms5yuNqwMWF9w9upVthavYWi7S9+8v2RlLg3yQu3PgB8Kh1UyDZsha0
 WI8T8mh7NGjG3Zl3y3CIA8FBsTezGrOkAk/4jX3HQlX8d9Y1l1HOuXl0qDQ61uMeX55L
 8aYyp818B2BTAaMSP9gL/kFuu47Fivn8p16DIdD9ue5ofZkzyXHEDdIIfxEprrG36gfY
 abgZ89lKK9JVbOJY7N93C0U0bc/wrVQ3WwyP63y+kzxEu2pqdS+uNKbnkrAa/pxjHpUn
 dp4A==
X-Gm-Message-State: AOJu0Yx7t0OQls1ajAGVDQNcJ6rhNVcvpQxrLvucy0kvRQKjFjhT5ihU
 8lNZuRqI9ZXQPqQjOjK86fANp0TPH+tYY4dzyYDjC3BTbZTFMeeLZzsXh4YWui5nIH880LQ2rPm
 7lsqq71qoOdnO52d0+9KJtK9Z4JJS3TmEulqsvJCPw92LYgw=
X-Google-Smtp-Source: AGHT+IFQEBUSUvMiEGrBl66T3xI6312icsylf82TCCKegb0B33rc6e/T9xXdjcwUlpXv41frcrR1W3zLYYHLt8iv6vk=
X-Received: by 2002:a05:6214:20ea:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6bb562e1ca6mr156546046d6.6.1722266945975; Mon, 29 Jul 2024
 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:55 -0600
Message-ID: <CAFLszThrM9hqPuP=tvhguR=ENkYTehjzAGCAXcFXn=EseuA8Ug@mail.gmail.com>
Subject: Re: [PATCH 00/17] Implement ACPI on aarch64
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Based on the existing work done by Simon Glass this series adds
> support for booting aarch64 devices using ACPI only. As target the
> Raspberry Pi4 was used, which is broadly available and allows easy
> testing of the proposed solution.
>
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

Thank you for picking this up!

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

Regards,
Simon
