Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A1CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F8988DDE;
	Thu, 26 Sep 2024 23:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4qiRhLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF52488DB6; Thu, 26 Sep 2024 23:29:00 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A3588DE9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso8744556d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386137; x=1727990937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jLM6UkduhL9+YP2gLt2qXds62j/91/viDc16iL6XCcg=;
 b=G4qiRhLjx7PG0zPNoOG/BdX3rzrrR+dWPGBTonw5in77q2M8347uAMer+iO8urIWqW
 HyGgFi+jQFDw4Z283AEGqcLKeOyIrKC8X+q1MUNeU4oeG0ubwojCrFL3sp1tHVYWJy0e
 +LnN0w7kMJVo1N+j2snzS5+QOb0DpaV0FalZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386137; x=1727990937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLM6UkduhL9+YP2gLt2qXds62j/91/viDc16iL6XCcg=;
 b=IGAW0f7R1I5jZp5BDIzP0/seb7FzEHIeLPgfatijqFS3vt0GmIIDyEoDnG02Bcw1QN
 xs4b5rxc1t7QVfQGLArkqaEFszdTi9sLdOrfA7cCYzBRIi1KwchaZ6zTLjW+yXL5ELLE
 tuPBHCJnE7elYZNiddZGXmmPfLnV0FBpHerhAP6QGNXAr8h3yx9VAscidiVQHVn9JCrY
 fgkn2limnEFjDMKaA7Mt4AIv3Ft/0C4ENXPjpqA2z+vXc/YdbkJgog7I4/1d3dMUo3gC
 j8HpfB0QuWZ8DKbpZg1EjoeuHjLZfYFc7rWno/IliRNOsJTFO/1H82Tfnpbq+HFnzrGg
 uxKQ==
X-Gm-Message-State: AOJu0YwefBTfFKmYcYRpi+GPb5+Lyfgr+4ueC/Yz+WeX4LvgxB/LBbZa
 N1ozrCpFPOTMgoNRqzIFguLfMKXXOvKhVJHBhq32Uw0E8K9ec1qYjSc2qRdE6MKLiuIAc0LXw1u
 LJXDJTEI0aPpt47DX6Z4zQq94Ad4JjSLrLzUo
X-Google-Smtp-Source: AGHT+IFIjy9D3CDKYWWZ9csIZnODzjQz0qWXVQaajwNDj3BFgFChMkTytn3tfE1pCbWH3jVMu8vQPtMG/5wH1iri4hU=
X-Received: by 2002:ad4:4f47:0:b0:6cb:3bc0:c2c5 with SMTP id
 6a1803df08f44-6cb3bc0c33bmr7935256d6.53.1727386136928; Thu, 26 Sep 2024
 14:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-26-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:28:45 +0200
Message-ID: <CAFLszTgTJAVKb87HEaSCgNqBeC8ThrWS4F9=Q9CzanRAeCHHTw@mail.gmail.com>
Subject: Re: [PATCH v5 25/36] board: emulation: Add QEMU sbsa support
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

On Thu, 26 Sept 2024 at 10:03, Patrick Rudolph
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
> ---
>  arch/arm/Kconfig                            |   3 +-
>  arch/arm/dts/qemu-sbsa.dts                  | 138 ++++++
>  arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  34 ++
>  arch/arm/mach-qemu/Kconfig                  |  36 +-
>  board/emulation/qemu-arm/MAINTAINERS        |   2 +
>  board/emulation/qemu-sbsa/Kconfig           |  59 +++
>  board/emulation/qemu-sbsa/Makefile          |   8 +
>  board/emulation/qemu-sbsa/acpi.c            | 193 ++++++++
>  board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++++++
>  board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
>  board/emulation/qemu-sbsa/qemu-sbsa.c       | 312 +++++++++++++
>  board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
>  board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
>  board/emulation/qemu-sbsa/smc.c             |  72 +++
>  configs/qemu-arm-sbsa_defconfig             |  10 +
>  doc/board/emulation/index.rst               |   1 +
>  doc/board/emulation/qemu-sbsa.rst           |  98 ++++
>  doc/develop/driver-model/virtio.rst         |   1 +
>  include/configs/qemu-sbsa.h                 | 104 +++++
>  19 files changed, 1621 insertions(+), 7 deletions(-)
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

Please check the header order throughout
E.g. board/emulation/qemu-sbsa/qemu-sbsa.c is still incorrect

You should not need to include 'config.h' as kconfig is included by default?

Do you need to add all the CFG items? Are they present in the devicetree?

For Binman the default pad-byte is 0, so you can drop those lines.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
