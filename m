Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED58CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC2F89030;
	Sun, 13 Oct 2024 21:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m99jbAuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F0C89035; Sun, 13 Oct 2024 21:34:19 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CB288FEE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbce16d151so18293596d6.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728848055; x=1729452855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B2kBqf9AnmpDKe9DXdUl13D5zIUh9o9UWXtvAK6ns/s=;
 b=m99jbAuIw+Y5SvPXK7ouRo4Kq9rJRRYfaW8mkdER/FYAoFBX9eSGyIZFlzDH2ldBPo
 F8HJ/PMA/T+k4Crd9VLJZga7ZIr+mKr9AtDbuQkD+zHmWNPTsl01LZlx2BiU7KLxNCvp
 Fq7ZlNQyiqcydS+X3UVl6hM47O/JDD/ZCKMDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728848055; x=1729452855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2kBqf9AnmpDKe9DXdUl13D5zIUh9o9UWXtvAK6ns/s=;
 b=VA0rH26mgieb/Plk4TVNhVx6eQyL+IMaVxQUbLnFpUtnaQZu6DGIJ5l3Jtx4eSmc3g
 5P0wRd8ObK+63EL5iFln11zsi+HganOfJnzhSrpMnwnkJyiHTzVRGZyhFiVi4uKBdz7Y
 A5ha3SpxQBOpnpcjR7jKe1Fv3Ji+KhAJnlAkEjsiqjFheuIBfSTnRtObXpDQGBawyLEP
 mEG1KP4mdHvrZ3PdsSBdsMye+N0Zz7b25sqcIsYKMx4X7ZcP4LKhg0zVo1IVvLDoTbiG
 5I/zbTL8ICdQLGefvhI8t+bgDltTj0GL9PznAuQ3ZOg7QKZQiL2a2XAxgm8Q612xoRjX
 V2yw==
X-Gm-Message-State: AOJu0Yw6emLTmelb4dX375Dzh81l04nmUYLJwY3lHyJ3fceDzRbWwlJe
 b/tMogNwpxzXcD0Ct3EnaD0rzX8OcEkmO9iPDH3KB4pkBy4+GZHtx7kGnDCJSkt6kFFUuTTfiUw
 AArpMZL/l3+DoGcdmMdmQ+WSZ/MV76Rgjk++4
X-Google-Smtp-Source: AGHT+IFQ7YxlE/y/KcBuagkEqOck7rF5uRqlFSfSVA1z7VoVnXqZdTdv1OyXt6OI1vmwfUz/sxrup8OHZbcaVFz1l/U=
X-Received: by 2002:a05:6214:2d49:b0:6cc:53a:70ba with SMTP id
 6a1803df08f44-6cc053a70f8mr48042976d6.26.1728848055634; Sun, 13 Oct 2024
 12:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
 <20241011102419.12523-26-patrick.rudolph@9elements.com>
In-Reply-To: <20241011102419.12523-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Oct 2024 13:34:04 -0600
Message-ID: <CAFLszTjpTk0HsQkuhnK1EU2s7Cpft++setEHaWLuXOQqnLZ6oA@mail.gmail.com>
Subject: Re: [PATCH v7 25/37] board: emulation: Add QEMU sbsa support
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

On Fri, 11 Oct 2024 at 04:35, Patrick Rudolph
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
> Changelog v7:
> - Use /bits/ 64 in DT
> - Drop flash access helper functions
> - Add cfi-flash to DT
> - Mark secure-flash as no execute
> - Only use defines in DT when it's also used in other files
> ---
>  arch/arm/Kconfig                            |   3 +-
>  arch/arm/dts/qemu-sbsa.dts                  | 137 ++++++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  58 +++
>  board/emulation/qemu-sbsa/Makefile          |   8 +
>  board/emulation/qemu-sbsa/acpi.c            | 192 ++++++++
>  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
>  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
>  board/emulation/qemu-sbsa/qemu-sbsa.c       | 273 +++++++++++
>  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
>  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
>  board/emulation/qemu-sbsa/smc.c             |  71 +++
>  configs/qemu-arm-sbsa_defconfig             |  10 +
>  doc/board/emulation/index.rst               |   1 +
>  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
>  doc/develop/driver-model/virtio.rst         |   1 +
>  include/configs/qemu-sbsa.h                 |  89 ++++
>  19 files changed, 1563 insertions(+), 7 deletions(-)
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

Reviewed-by: Simon Glass <sjg@chromium.org>
