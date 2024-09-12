Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E5EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC31388D2C;
	Thu, 12 Sep 2024 02:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KGLuhevV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F91288D36; Thu, 12 Sep 2024 02:58:51 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6736488D45
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso300926b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102727; x=1726707527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGQQnDMXIok/QPZy6SgSgAbRBhSo3OryX3d4j9w4JlA=;
 b=KGLuhevVIjhJociUqFQSO4pX2X3hBNpT8ewLHFoWDhGyxABMuNSGkm8g4qaNPoV9x1
 URDgKPvmPm/VF1l6dZLLbGA+2pSK8G8VW/oEN0lJ7t5VTqAFZZQehocfnnCmxnFAdjGr
 mJAYueuMLlEg4TNqQr+obO1K7DDY82OPAnjDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102727; x=1726707527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGQQnDMXIok/QPZy6SgSgAbRBhSo3OryX3d4j9w4JlA=;
 b=AZjOMAgJv9GT64F45jv8ZvNdNqF9RfuzPtHq8ZGcSqIhf5of7rsLPzZFmP6FDVZ2Km
 3T173wizXHO9hp9FHBmZnW3bqpXMsIoYsnVJ7reU2QZaQF5ts4+W5TCMHgaVkofL9PK2
 XlWzjlYEiAxx/T/wY2ycUKKT72uaS9ayEW3+NtnadRW8rp4GlXRCgQQ4GQOHw0F4kHvv
 wSoQJDGDxGNol6rA9Wsnkp0BmwcvhJZ4FVtgquGa8Veh7wpNer6WiqO8fGAhbivi72jy
 Oq3RNoQzRJNhIb5GC3Kq8ApobHJCxFwQxh5OX8NEBTbZAmz9U4IKzyCjg8KWcDhLaae+
 lh3Q==
X-Gm-Message-State: AOJu0YyCbLMu0qsVhwmxuAMphF7m9v46Lm1pEV5cac9C7TEauV8OLeEA
 Zjw7LpEeeW6uvXxd59nH1m03mUgbX3NvyRlZu05nNMEasgksPkNUj5+3xC3NUyftc++0Lr6E4aW
 gHgKku+Too9P1uFvtjvskrDaKD4pGuzpwvfyQ
X-Google-Smtp-Source: AGHT+IEgnJLjN15av5hhUJWNYO5cAEJz36nVh/3n+dKCX2Jpt9LmL/tEEzhc04X/zDAwr9HW2EImuwRLMsdpoeBEAuU=
X-Received: by 2002:a05:6a00:218f:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-7192608123fmr1664229b3a.7.1726102726787; Wed, 11 Sep 2024
 17:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-23-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:22 -0600
Message-ID: <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
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

On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
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
>
> ---
>  arch/arm/Kconfig                            |   1 +
>  arch/arm/dts/qemu-sbsa.dts                  |  49 ++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  58 +++
>  board/emulation/qemu-sbsa/Makefile          |   8 +
>  board/emulation/qemu-sbsa/acpi.c            | 235 ++++++++++
>  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
>  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
>  board/emulation/qemu-sbsa/qemu-sbsa.c       | 481 +++++++++++++++++++
>  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
>  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
>  board/emulation/qemu-sbsa/smc.c             |  72 +++
>  configs/qemu-arm-sbsa_defconfig             |  10 +
>  doc/board/emulation/index.rst               |   1 +
>  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
>  doc/develop/driver-model/virtio.rst         |   1 +
>  include/configs/qemu-sbsa.h                 |  98 ++++
>  19 files changed, 1734 insertions(+), 6 deletions(-)
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

Wow there is a lot in this patch!

I don't think this should be in a separate subdir, just using
board/emulation/qemu-arm should be OK?

I see you are setting plat data in the board file...is there not a CPU
driver which can read it from the devicetree or set it based on the
compatible string?

For FDT fixup, can you please use the event and the ofnode interface?
See EVT_FT_FIXUP and bootmeth_vbe_ft_fixup() as an example.

Regards,
Simon
