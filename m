Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B150ECF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DD58921A;
	Thu, 19 Sep 2024 16:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dUnZcWoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEFF89238; Thu, 19 Sep 2024 16:12:23 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC30891F7
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so805001b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755139; x=1727359939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NZoPArjXJ7OUgMpumjTP5xFXUliCOAcli+eZPBfETrw=;
 b=dUnZcWoW9P2JlP3MukpZmQHRh5t/Jk+2DD/TF4+62VkbdAC8wbn5IZ329938tIU4nw
 dlNklMPjkl868GT/6vY6qhOpsqoskwWTcTHwrlhLkf+0I3n0EABIkdRRZC7WT63EraMP
 h0xRWMb2pNEEgqNFWU7vE/r4Yaee0H3FxGxB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755139; x=1727359939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZoPArjXJ7OUgMpumjTP5xFXUliCOAcli+eZPBfETrw=;
 b=LgOGje/DMGWvC07uiOfPQ4iHTJegI1bfGYoyMbLZwZoPy6PXQSbpgb8zBSC/6xSSEh
 PfnUcmZGmQZpp47Ktr9oiTrnPSQv0SRfp2qimJPSo3kMTnByxp3ycO3NIgdrk33CW3X3
 Gb8ZXmfC7QdIdiMuxvMQUVtXY6r7IdUgIBXTv9I2a3/BBVg5dOTZ/2jbPobk3BUKCwCy
 A7xMwzOXZRl1xPzRbpGcotc2Q45DE9Mddfe7zc8y8nKG+2lsh+uTJLGV37k7EnbfdcEI
 NSTZ9/IX+4aDHCq5rLbiWGmLHtjP9PGE96EWEW3jgGhhDHKcXR1uf9PSJyrYkHKW+MjC
 xArg==
X-Gm-Message-State: AOJu0YwaCmBYvdYoAi3RrVwDLO3/qI5bEb1dysAqn6dsAzu41MULeVI0
 er4pgu3AKiche83yLLWaL9WHNqv3r5SFc4/gpSb/ZEE5s497zVkn7a7CdQ0QtiWCw69rQ4mEjvq
 XfftLGd7yL37xJ2A/yzZG/Q6sW9ntihJDXoXe
X-Google-Smtp-Source: AGHT+IE0AJXDi49Sw4AZ0jhSquk1kmTqHkXBVxdOtW897f7+oPlboQ4HeLoajoRVb1HsXIGe7jbwFRpL1LnG995SVfY=
X-Received: by 2002:a05:6a00:2e11:b0:710:bd4b:8b96 with SMTP id
 d2e1a72fcca58-719262077e3mr39719459b3a.28.1726755139161; Thu, 19 Sep 2024
 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-26-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:51 +0200
Message-ID: <CAFLszTjHanW+ACWoJhveaw2G5yRm1acxTWJhcMHKQ2FLxd=xag@mail.gmail.com>
Subject: Re: [PATCH v4 25/35] board: emulation: Add QEMU sbsa support
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

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].
>
> Unlike other Arm based platforms the machine only provides a minimal
> FDT that contains number of CPUs, ammount of memory and machine-version.
> The boot firmware has to provide ACPI tables to the OS.
>
> Add a minimal amount of devicetree nodes to make the board useable within
> U-Boot, provide documentation how to use, enable binman to fabricate both
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
> ---
>  arch/arm/Kconfig                            |   1 +
>  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  58 ++
>  board/emulation/qemu-sbsa/Makefile          |   8 +
>  board/emulation/qemu-sbsa/acpi.c            | 197 +++++++
>  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++
>  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
>  board/emulation/qemu-sbsa/qemu-sbsa.c       | 602 ++++++++++++++++++++
>  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
>  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
>  board/emulation/qemu-sbsa/smc.c             |  72 +++
>  configs/qemu-arm-sbsa_defconfig             |  10 +
>  doc/board/emulation/index.rst               |   1 +
>  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
>  doc/develop/driver-model/virtio.rst         |   1 +
>  include/configs/qemu-sbsa.h                 | 104 ++++
>  19 files changed, 1823 insertions(+), 6 deletions(-)
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

This is quite strange. Why not use the correct DT with the required properties?

Please use lower-case hex.

Can you not use the ofnode API?

Regards,
Simon
