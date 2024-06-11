Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720EC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B293F88691;
	Tue, 11 Jun 2024 15:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S70mycSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 872688869A; Tue, 11 Jun 2024 15:25:43 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DEA88660
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso917146a12.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718112339; x=1718717139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hruz5+LXnDfFejHE6Eew6iO7wo91xwYJ6zMB9FFmoAA=;
 b=S70mycSSA89B4Umqdr4RDHV+yYZ+WLO4+OMWudtyQSbp8HrRwpjHlSQI/S4sqTNjhT
 vtiIoXYJdCB0UxtY1QGFUdSl9UJZS7ArHjmz8kAqmeJkjopJhGBnYHiXi66IgVmei2Sq
 0e4Hl3W9ogfhipjpflIMZnTgFAB7KrTdDY+bNhCt9SXKjzVfU56mCaxX34GSm3iPKe4a
 L78QNBT0FefPg0KVo1xFPUJm5VByzfKNecx+UFtqzR0FkMsxlPqbi4L+SjlBo83tajnZ
 +Oa2sVENg6ek+3vx4N/kI8yy32QUAqd5Oi+q+By/laSyAvQqgpsMAXxF4tvmqoMhQ92a
 jr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718112339; x=1718717139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hruz5+LXnDfFejHE6Eew6iO7wo91xwYJ6zMB9FFmoAA=;
 b=oWTkxVKKV+bU2uUheZa1WkQFZ3d3d2fEz/VpopQDKC6BMBCt9b5iRlP2i64C9Jrpui
 B8Skn9oYvHdqMnMUzv7MfRWZRyk2LMkDXtJlTtME/JKoWIpuJmPiICn+eejVgF7peDgd
 yK76xRBQlRsKROzPipr5AN58oDkamhb5EJDR1DIV7mJ88Lq5Ym5DPWYLXsqyvem4E00X
 2786lopt5KZm2d7+mgV40RbP7J+wR+KZLUElyDMXNTD4wMjtrQmngZveiMEYcshX3etT
 iLsjGMSN5o1iGx2igSJFVzcc/7pnriat8vfUeUcBVVPaSDexgS7zZM7jQNlxhK929Gct
 qJ7Q==
X-Gm-Message-State: AOJu0YyDXbYFMDzFItLKOwwEayw+vqf8v7G9O5PaJLl8K8OqLvp4Syc/
 r/2LxECGyIdPwv4uzBn7PH9uKmoIYzaHdfsWnWkj3q73mcEXrJ6Gwp49mhZQx8hLfqG7hVPhQKR
 Wy1PZqEqBCso7wE8Cr1p5KphYsfNWEPrxGMw/sA==
X-Google-Smtp-Source: AGHT+IHdawUxY7iSzSDYFcGnW53Yr2cPIbcbD5Y+VGQt4vEi9uGfk+bzQb7jNGyiP3UDJGk4iAVbKgc+LV6ip/1Btng=
X-Received: by 2002:a17:902:ea0b:b0:1f6:92f1:b01c with SMTP id
 d9443c01a7336-1f6d03b9604mr157346415ad.69.1718112339436; Tue, 11 Jun 2024
 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 16:25:03 +0300
Message-ID: <CAC_iWjKRk-hYmEYbFbBpSi-t_JWT6GNSkh0TrB6uxzfUT=C-ZA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Arm64 big endian enablement
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com, 
 Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Hi Jiaxun,

On Sun, 19 May 2024 at 15:56, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Hi all,

Apologies for taking time to review, got a lot in my backlog


>
> This series enabled big endian support for arm64, enabled qemu-arm
> board for arm64be and slightly adjusted our Kconfig handling on endianness.
>
> In practical I think most Arm SoCs do support little endian only,
> for those SoCs with big endian support they are usually bi-endian
> and expected bootloader in little endian. The only big-endian only
> Arm SoC I know is a network processor from ZTE ZXIC, I doubt if upstream
> U-Boot will ever support it.
>
> However enabling arm64be can enable us to take more care on big endian
> targets, given that arm64 is the most feature rich arch in U-Boot,
> we can run more test on big endian systems.
>
> Boot tested on qemu.

This is not a nak, but I dont see why we should have the extra
maintenace burden if people don't use it.

I'd like more feedback from the community on whether this is useful or not

Cheers
/Ilias

>
> Please review.
>
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (13):
>       tools/relocate-rela: Fix Big Endian elf64 handling
>       arm: Don't select ARM_ASM_UNIFIED on arm64
>       arm: Fix assembler.h for arm64
>       arm: Introduce CPU_LE/CPU_BE macros
>       arm: Define endian related bits in system.h
>       armv8: Big Endian enablement for compiler and linker
>       arm: Perform byte swap for read and write in io.h
>       armv8: Allow endianness to be setted at reset entry
>       armv8: spin_table: Perform byte swap for jump address
>       lib/crc32: Don't perform byte swap for arm64 crc32b
>       Kconfig: Unify endian support option
>       config: Use CONFIG_SYS_BIG_ENDIAN in code whenever possible
>       qemu-arm: Big endian enablement for arm64
>
>  Makefile                                           |  2 +-
>  arch/Kconfig                                       | 34 ++++++++---
>  arch/arc/include/asm/arc-bcr.h                     | 10 +--
>  arch/arm/Kconfig                                   |  3 +-
>  arch/arm/config.mk                                 | 14 +++++
>  arch/arm/cpu/armv8/Kconfig                         |  9 +++
>  .../arm/cpu/armv8/linux-kernel-image-header-vars.h |  4 +-
>  arch/arm/cpu/armv8/spin_table_v8.S                 |  2 +
>  arch/arm/cpu/armv8/start.S                         | 26 ++++++++
>  arch/arm/cpu/armv8/u-boot-spl.lds                  |  6 ++
>  arch/arm/cpu/armv8/u-boot.lds                      |  4 ++
>  arch/arm/include/asm/assembler.h                   | 25 ++++++++
>  arch/arm/include/asm/io.h                          | 12 ++--
>  arch/arm/include/asm/system.h                      |  3 +
>  arch/arm/lib/elf_aarch64_efi.lds                   |  7 +++
>  arch/mips/Kconfig                                  | 20 +++---
>  arch/mips/mach-ath79/Kconfig                       |  8 +--
>  arch/mips/mach-bmips/Kconfig                       | 20 +++---
>  arch/mips/mach-jz47xx/Kconfig                      |  2 +-
>  arch/mips/mach-mscc/Kconfig                        |  4 +-
>  arch/mips/mach-pic32/Kconfig                       |  2 +-
>  board/emulation/qemu-arm/Kconfig                   |  2 +
>  board/emulation/qemu-arm/MAINTAINERS               |  1 +
>  configs/qemu_arm64be_defconfig                     | 71 ++++++++++++++++++++++
>  doc/board/emulation/qemu-arm.rst                   |  7 ++-
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  2 +-
>  lib/crc32.c                                        |  3 +-
>  scripts/Makefile.build                             |  2 +-
>  scripts/Makefile.lib                               |  3 +-
>  tools/relocate-rela.c                              | 40 +++++++-----
>  30 files changed, 271 insertions(+), 77 deletions(-)
> ---
> base-commit: 3be9f399e911cfc437a37ac826441f1d96da1c9b
> change-id: 20240518-aarch64-be-1ec99cf7f28b
>
> Best regards,
> --
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>
