Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCA6D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FE88910E;
	Fri, 18 Oct 2024 01:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ny9hrOtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9A7891BD; Fri, 18 Oct 2024 01:18:26 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD478910E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbf2fc28feso9392886d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207101; x=1729811901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqL1mKr5PoHKQYv9ldtHYkIxRc4SEbEo/VVHRgTKmkM=;
 b=ny9hrOtQRWrGgcyK4vHQQX8ZmuBsg47EEq77IfxwgpfS1eaRsPpqZwuGyasnxUX2QS
 Y1pY+RkqiItD+10I/cQEJ9oA76fTYQcDs4U/zKJMvssuFrLwiOppIOZiCnm6ws18KjMl
 24JczSGzjCAoYIdcUy9SFWym3u8iqvRlMF45c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207101; x=1729811901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqL1mKr5PoHKQYv9ldtHYkIxRc4SEbEo/VVHRgTKmkM=;
 b=HyzKXbToNyO18El/cQB7m73e7c0SKJdEl0zrvwg1law61lBOeCe11aScrv6THjb6i4
 3Kud0fYbpSxbIYBSWH94z+85FE3E5g1nzIEndIDcjDaLitrv6/DSulyKtts2Nwf2Cb3C
 sOQb4VYzkBzCs6JSercmCxMcoWNtDEhhmFX/In3IxH9TLJFyPYBKN5mbfYoTrKukRN8F
 dIsfyzZKOIREk243d3rIjewiL+BRoh6lqezrnx28unckn90fcSbC/4WSkw8tXxQdxuuB
 V3HSZ6jzjdKdTsfNGXY6SA8OWVjTBn/KQNZNaIg/qpQl6mbT8pwC3fGvOySgcW0Pumbl
 Zf4g==
X-Gm-Message-State: AOJu0Yw1gSSMEc2KU2XHdQOGGJXBPhyxvCA3/c35lIq9NYyYBCx3xOPc
 GLSCXfgHUchdfWcPjE1ywB2SLPVPu0aHKJ1gm5LswaivG785d4dac6eqfYcxn2yjuU2cYeMbGjZ
 Km1aP3ul9/GI7DM1d06FsHHNZj/fa7vwW8CdA
X-Google-Smtp-Source: AGHT+IF22x7FMHqrcObI0LHib2OwsCOuaMrhRf7+haF0vZFHHNcVAJluJs+rru+SED9rCfSatDd0xSGX2LXvvVEWGeA=
X-Received: by 2002:a05:6214:4411:b0:6cc:1de6:1287 with SMTP id
 6a1803df08f44-6cde114741dmr9356396d6.0.1729207101045; Thu, 17 Oct 2024
 16:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-26-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:10 -0600
Message-ID: <CAFLszTg3cOc7DnCQTtzoRsNR-9NFdwNDcJMuA4C1pBP-=HgRtg@mail.gmail.com>
Subject: Re: [PATCH v9 25/37] board: emulation: Add QEMU sbsa support
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

On Wed, 16 Oct 2024 at 00:13, Patrick Rudolph
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
> Changelog v8:
> - Use /bits/ 64 in DT
> - Drop flash access helper functions
> - Add cfi-flash to DT
> - Mark secure-flash as no execute
> - Only use defines in DT when it's also used in other files
> Changelog v9:
> - Use interrupt-cells=3
> - Select BLOBLIST
> ---
>  arch/arm/Kconfig                            |   3 +-
>  arch/arm/dts/qemu-sbsa.dts                  | 138 ++++++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  59 +++
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
>  19 files changed, 1565 insertions(+), 7 deletions(-)
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
>

Reviewed-by: Simon Glass <sjg@chromium.org>
