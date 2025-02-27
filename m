Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83628C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 06:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3C580FE1;
	Thu, 27 Feb 2025 07:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V2oWj7pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D3880FE2; Thu, 27 Feb 2025 07:33:49 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723D0801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so989269a91.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740638025; x=1741242825;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ichGUyMqm3KzjLxav62Z9V3zJ1dqxWUU59WYL+fxBb4=;
 b=V2oWj7pN2Yro+8DsqVUyc0yZTdsbextBNw85ubxK9XKzLeNr0OWUpgc7/Sw2RrdoAp
 Gwl/p0/F2ZCxQOwr2s0B+wKe9mLYXKO+83Utp0grQ+vtg7KaSNeKMQf8KyC754Oh6+7+
 uUloeaoE6EfGyMW7+XvnucEEhE3NM/Hndgyc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740638025; x=1741242825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ichGUyMqm3KzjLxav62Z9V3zJ1dqxWUU59WYL+fxBb4=;
 b=Z8C9FzApFA0sQ2qOLQoqVxkVWvFWLHFI7VI4oNud2qPlBmaPdgEXAXVp8kLqgrWchR
 ONThtCRVsQsuAr26yX9Gvd8821Rmb2c45Q99E/qibCNGr4JO1+VMmgJif8X767SLX4SK
 bNVWFMBiejTi6JLyDF6UIEhXpzmfCypli317pc9EIh+jNLdC3LOMlzdTGtyCE6jRjWlW
 8RccJFAzc3juSPawEAK4haplgL4xwHgRA8RUeofsSE9DiQGlcf9Pzf1234RfYIQf7Fy5
 kHKorAhjJpFLdiUR7v0awlEwN/oqb4rb4ySKiy0TtOcNJbBjkTfbi0RMU1Sd4TSquFuH
 uwAQ==
X-Gm-Message-State: AOJu0Yyd8xfv7N2hUGgI/m+mtjKpYIdwUgrRCrqxmIMQ6xOT0/91kaFV
 tuurHmbQTi23DVqU889d20tkyNvJ7IIZ/AB007Yj+lDv+wLPfXpCrg5jI7vuSal7HbtGJFgCHDl
 yveSMQ8qV6qzRmijasgf4Ves+hCCsccuIzAIqFQ==
X-Gm-Gg: ASbGncu8q1fZhf4NvTpspYXfMESlE1Rn1j9leampAB7vBAA1/3s6a8psTi4HvwII/P/
 WksNTIgsPOB5ayhgiP5jnob1Occ62f+BXFTCj1ghm5lqa+xETN4QxXRUBn35+qhEOoV+MkSMmyI
 FYSswD
X-Google-Smtp-Source: AGHT+IFsxQNME/CxQ1J3STidXZgDXaUr/6UTs+6hm7nYMjbnlipSuIttj8wIfiq5J1CRo+L5dYwFzURLocFV37BT3X8=
X-Received: by 2002:a17:90b:2809:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2fe68ae2913mr18368840a91.17.1740638024870; Wed, 26 Feb 2025
 22:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 27 Feb 2025 07:33:33 +0100
X-Gm-Features: AQ5f1JqsRt4-krlbRRvagAyJg5LpmiKNzQP81_XCRNVOV8gu_ARVMvVVP8ybFX4
Message-ID: <CAOf5uwn+OAqHL9SkZsR+YzctT3mNxOh6GXaqdN1i6ByOzVnSAA@mail.gmail.com>
Subject: Re: [resend v3 00/19] Add Cadence NAND Driver support
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

Hi Dinesh

On Wed, Feb 26, 2025 at 5:18=E2=80=AFPM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> This patchset add Cadence NAND driver support for
> Intel Agilex5 devices.
>
> The NAND driver is leveraged from the cadence-nand-controller.c
> from Linux version 6.11.2. U-Boot will support read, write and erase
> NAND with Cadence driver. The driver further enhanced in U-Boot
> to support NAND booting from FSBL and support boot to kernel
> via UBIFS.
>

I have just applied on top of master and they are not applied clean. I
can fix these conflicts by myself this conflicts, but I would
like that when you apply patches you fix warnings like trailing space.

Applying: dt: nand: add cadence nand dt-bindings
Applying: arm: dts: agilex5: Enabled cdns-nand dts setting
Applying: drivers: mtd: nand: Add driver for Cadence Nand
Applying: drivers: mtd: nand: cadence: Add support for read status command
Applying: drivers: mtd: nand: cadence: Add support for readid command
Applying: drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
Applying: drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
Applying: drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATU=
RES
Applying: drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
Applying: drivers: mtd: nand: cadence: Poll for desc complete status
Applying: drivers: mtd: nand: cadence: Use bounce buffer
Applying: drivers: nand: Enabled Kconfig and Makefile for cdns-nand
Applying: configs: nand2_defconfig: Enable configs for nand boot
Applying: drivers: mtd: nand: base: Add support for Hardware ECC for
check bad block
Applying: drivers: mtd: nand: spl: Add support for nand SPL load image
.git/rebase-apply/patch:19: trailing whitespace.
 * Copyright (C) 2024 Intel Corporation <www.intel.com>
warning: 1 line adds whitespace errors.

Apart of that

pplying: drivers: mtd: nand: Enabled Kconfig and Makefile for SPL_NAND_FRAM=
EWORK
error: patch failed: drivers/mtd/nand/raw/Makefile:3
error: drivers/mtd/nand/raw/Makefile: patch does not apply
Patch failed at 0017 drivers: mtd: nand: Enabled Kconfig and Makefile
for SPL_NAND_FRAMEWORK
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I will review the rest

Michael

> Patch status:
> Have changes: All patches expect Patch 19
>
> Detail changelog can find in commit message.
>
> v1->v2:
> --------
> Patch 1 - 18:
>
> - remove the "this patch is to" commit phrases
>
> Patch 4;
> - minor refactoring of code to match the stable version 6.11.2.
>
> Patch 14:
> - Add maintainer and "#include" mechanism for new variant
>
> Patch 16:
> - leverage the existing nand_spl_load_image
>
> v2->v3:
> --------
> Patch: arm: dts: agilex5: Enabled cdns-nand dts setting
> - Move &nand from uboot.dtsi to socdk.dts
>
> Patch: include: asm: Add support to read/write 64-bit
> - Dropped because redefinition of readsq & writesq
>
> Patch: drivers: mtd: nand: Add driver for Cadence Nand
> - Remove redundant clk_free func
>
> Patch: drivers: mtd: nand: Enabled Kconfig and Makefile for SPL_NAND_FRAM=
EWORK
> - New
>
> Patch: drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
> - New
>
> Patch: configs: nand2_defconfig: Enable configs for nand boot
> - Remove CONFIG_OF_UPSTREAM in order to get correct dts for compilation
>
> Patch: drivers: mtd: nand: base: Add support for Hardware ECC for check b=
ad block
> - Remove copyright
>
> Patch: drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
> - Dropped because SPL NAND have dependency with SYS_NAND_BLOCK_SIZE
>
> History:
> --------
> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.138=
54-1-dinesh.maniyam@intel.com/
> [v2]: https://patchwork.ozlabs.org/project/uboot/cover/20241205092315.250=
60-1-dinesh.maniyam@intel.com/
>
> Dinesh Maniyam (19):
>   dt: nand: add cadence nand dt-bindings
>   arm: dts: agilex5: Enabled cdns-nand dts setting
>   drivers: mtd: nand: Add driver for Cadence Nand
>   drivers: mtd: nand: cadence: Add support for read status command
>   drivers: mtd: nand: cadence: Add support for readid command
>   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
>   drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
>   drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
>   drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
>   drivers: mtd: nand: cadence: Poll for desc complete status
>   drivers: mtd: nand: cadence: Use bounce buffer
>   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
>   configs: nand2_defconfig: Enable configs for nand boot
>   drivers: mtd: nand: base: Add support for Hardware ECC for check bad
>     block
>   drivers: mtd: nand: spl: Add support for nand SPL load image
>   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
>   drivers: mtd: nand: Enabled Kconfig and Makefile for
>     SPL_NAND_FRAMEWORK
>   drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE dependency
>   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
>
>  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |    9 +-
>  arch/arm/dts/socfpga_agilex5_socdk.dts        |   19 +
>  board/intel/agilex5-socdk/MAINTAINERS         |    2 +
>  configs/socfpga_agilex5_nand2_defconfig       |   32 +
>  .../mtd/cadence,nand.yaml                     |   98 +
>  drivers/mtd/nand/raw/Kconfig                  |   26 +-
>  drivers/mtd/nand/raw/Makefile                 |   12 +
>  drivers/mtd/nand/raw/cadence_nand.c           | 2423 +++++++++++++++++
>  drivers/mtd/nand/raw/cadence_spl.c            |   59 +
>  drivers/mtd/nand/raw/nand_base.c              |   69 +-
>  include/cadence-nand.h                        |  529 ++++
>  include/linux/mtd/rawnand.h                   |   12 +
>  13 files changed, 3278 insertions(+), 26 deletions(-)
>  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
>  create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
>  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
>  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
>  create mode 100644 include/cadence-nand.h
>
> --
> 2.19.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
