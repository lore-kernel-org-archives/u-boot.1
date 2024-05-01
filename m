Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EBAC10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 06:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B62488AE9;
	Wed,  1 May 2024 08:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mO8Lk5hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2C188AEF; Wed,  1 May 2024 08:33:15 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D420888ADD
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 08:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5894c1d954so193103166b.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714545193; x=1715149993; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/n3Httga+0+qDXy92FPbNjnL8Vtw7gcsilrBdOi2VA=;
 b=mO8Lk5hjYBYL/6haGPfbgUEYz6xXazcv/XUyul3m5jOwGZMi/zr98H793QdzeNZ+c+
 2LH3toyWjXRUU5bBH7rS5w1U7VTpCuXA/+UgraB6HCR+oHJY1hR6K6R+EDsOBSw6t7PG
 7x893UkWsE9kgrji3ebCPmIqWLZkEaUULqm0mhxma0zJndGhNwKmnRk3SiHb14hS35pN
 XOJ/eTDwAg8Z3cNEy6jPiRLH+7/IxOcK3nm1q6gNjm6Vw7b2qoHdL3UY3eHfT3wt6MC5
 1tdH4oIsrkaucsY4FlcTNoAPYO1pVllMvFGLx4eClanQezi5XZV1zcvCajE70uHE/q/i
 75og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714545193; x=1715149993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/n3Httga+0+qDXy92FPbNjnL8Vtw7gcsilrBdOi2VA=;
 b=giwCU3A2UcDl5CHbNIRUrid5z9edsYF+N1S5DRbDnDMq+/3CkM4yDkNh6/JP+veIfc
 i6nNJZYXHMSpTsS2/QSFzKUJ3Ai6B0XCub0p975CUc63zf8D0ot5hHTQM8WZkuxKYl1M
 yfk6gJ4gHgPPsdCiO1yAKmcOSs4A7+znhNDWfBCMInq3xzVOKnwFGqGHAPU2ixQI40YQ
 KX5IzpYC/CiKYh1ypUvGZyHs8P3onZdlT8KVsJVHr9PrztJ7FwlQejCnb8wxpOMQFrN0
 zGs+4N1k9lAZP1ZkqsXLJYGW2KPbSxHRJ3kwoERyiUCqBWAmQCZvK6b6ea5gqIDxG33M
 NoBA==
X-Gm-Message-State: AOJu0YyOgnzoN9d379ByGP0ZVUHrRVshTKpgVtdUkpX050ij4gjC9PYi
 TiGnghjmuYvCvZD2Dzae6QBRRkNLfNNoverrIqBsBYPnDei1syWGtIYQjlEUtvZMNLVcQIrIWCQ
 DShAPyXiZ2TyIDn3RoQuvBEYoO2OwWPRm
X-Google-Smtp-Source: AGHT+IGwdR2rcfK4CG6EPvXWN2Q1OBlFw/alpkjsRP6AN5VzsE2TFmcsnc21zBT6idfFChCAasArJJUqV/IgcP1sgb8=
X-Received: by 2002:a50:d5d6:0:b0:572:325a:8515 with SMTP id
 g22-20020a50d5d6000000b00572325a8515mr1116438edj.36.1714545192898; Tue, 30
 Apr 2024 23:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 30 Apr 2024 23:33:01 -0700
Message-ID: <CAJaLiFzo=XeEto0EN_SE+G2iwxyWZ1Lb9AE8LG2sMfdTVhBF6A@mail.gmail.com>
Subject: Re: [PATCH 001/149] global: Make <asm/global_data.h> include
 <asm/u-boot.h>
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

This patch does not apply cleanly on the master branch. Perhaps this
patch series has a dependency on another previous patch? Please see
below at arch/arm/lib/bdinfo.c.

On Tue, Apr 30, 2024 at 7:50=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> This follows the example of RISC-V where <asm/global_data.h> includes
> <asm/u-boot.h> directly as "gd" includes a reference to bd_info already
> and so the first must include the second anyhow. We then remove
> <asm/u-boot.h> from all of the places which include references to "gd"
> an so have <asm/global_data.h> already.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  api/api_platform-arm.c                         | 1 -
>  api/api_platform-mips.c                        | 1 -
>  api/api_platform-powerpc.c                     | 1 -
>  arch/arc/include/asm/global_data.h             | 2 ++
>  arch/arm/include/asm/global_data.h             | 1 +
>  arch/arm/lib/bdinfo.c                          | 1 -
>  arch/arm/lib/cache-cp15.c                      | 1 -
>  arch/arm/mach-davinci/cpu.c                    | 1 -
>  arch/arm/mach-davinci/misc.c                   | 1 -
>  arch/arm/mach-davinci/spl.c                    | 1 -
>  arch/arm/mach-imx/ele_ahab.c                   | 1 -
>  arch/arm/mach-imx/mx5/mx53_dram.c              | 1 -
>  arch/arm/mach-mediatek/mt7622/init.c           | 1 -
>  arch/arm/mach-mediatek/mt7981/init.c           | 1 -
>  arch/arm/mach-mediatek/mt7986/init.c           | 1 -
>  arch/arm/mach-mediatek/mt7988/init.c           | 1 -
>  arch/arm/mach-mvebu/armada8k/dram.c            | 1 -
>  arch/arm/mach-mvebu/dram.c                     | 1 -
>  arch/arm/mach-omap2/omap-cache.c               | 1 -
>  arch/arm/mach-omap2/omap3/emif4.c              | 1 -
>  arch/arm/mach-omap2/omap3/sdrc.c               | 1 -
>  arch/arm/mach-owl/soc.c                        | 1 -
>  arch/arm/mach-renesas/memmap-gen3.c            | 1 -
>  arch/arm/mach-renesas/memmap-rzg2l.c           | 1 -
>  arch/arm/mach-socfpga/clock_manager.c          | 1 -
>  arch/arm/mach-socfpga/clock_manager_agilex5.c  | 1 -
>  arch/arm/mach-socfpga/spl_a10.c                | 1 -
>  arch/arm/mach-socfpga/spl_agilex.c             | 1 -
>  arch/arm/mach-socfpga/spl_gen5.c               | 1 -
>  arch/arm/mach-socfpga/spl_n5x.c                | 1 -
>  arch/arm/mach-socfpga/spl_s10.c                | 1 -
>  arch/arm/mach-uniphier/dram_init.c             | 1 -
>  arch/arm/mach-versal-net/clk.c                 | 1 -
>  arch/arm/mach-versal-net/cpu.c                 | 1 -
>  arch/arm/mach-versal/clk.c                     | 1 -
>  arch/arm/mach-versal/cpu.c                     | 1 -
>  arch/arm/mach-zynqmp/clk.c                     | 1 -
>  arch/arm/mach-zynqmp/cpu.c                     | 1 -
>  arch/m68k/include/asm/global_data.h            | 2 ++
>  arch/m68k/lib/bdinfo.c                         | 1 -
>  arch/microblaze/cpu/spl.c                      | 1 -
>  arch/microblaze/include/asm/global_data.h      | 1 +
>  arch/mips/include/asm/global_data.h            | 1 +
>  arch/mips/lib/traps.c                          | 1 -
>  arch/nios2/include/asm/global_data.h           | 1 +
>  arch/powerpc/cpu/mpc83xx/interrupts.c          | 1 -
>  arch/powerpc/cpu/mpc83xx/pcie.c                | 1 -
>  arch/powerpc/cpu/mpc83xx/spd_sdram.c           | 1 -
>  arch/powerpc/cpu/mpc83xx/speed.c               | 1 -
>  arch/powerpc/cpu/mpc85xx/b4860_ids.c           | 1 +
>  arch/powerpc/cpu/mpc85xx/cmd_errata.c          | 1 -
>  arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c | 1 -
>  arch/powerpc/cpu/mpc85xx/p2041_ids.c           | 3 ++-
>  arch/powerpc/cpu/mpc85xx/p2041_serdes.c        | 1 -
>  arch/powerpc/cpu/mpc85xx/p3041_ids.c           | 1 +
>  arch/powerpc/cpu/mpc85xx/p4080_ids.c           | 1 +
>  arch/powerpc/cpu/mpc85xx/p5040_ids.c           | 1 +
>  arch/powerpc/cpu/mpc85xx/speed.c               | 1 -
>  arch/powerpc/cpu/mpc85xx/spl_minimal.c         | 1 -
>  arch/powerpc/cpu/mpc85xx/t1024_ids.c           | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t1024_serdes.c        | 1 -
>  arch/powerpc/cpu/mpc85xx/t1040_ids.c           | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t1040_serdes.c        | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t2080_ids.c           | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t2080_serdes.c        | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t4240_ids.c           | 3 ++-
>  arch/powerpc/cpu/mpc85xx/t4240_serdes.c        | 1 -
>  arch/powerpc/cpu/mpc8xxx/fsl_lbc.c             | 1 -
>  arch/powerpc/cpu/mpc8xxx/fsl_pamu.c            | 4 +++-
>  arch/powerpc/cpu/mpc8xxx/law.c                 | 1 -
>  arch/powerpc/cpu/mpc8xxx/pamu_table.c          | 1 -
>  arch/powerpc/cpu/mpc8xxx/srio.c                | 3 ++-
>  arch/powerpc/include/asm/fsl_liodn.h           | 4 +++-
>  arch/powerpc/include/asm/fsl_portals.h         | 2 ++
>  arch/powerpc/include/asm/global_data.h         | 2 ++
>  arch/powerpc/lib/bdinfo.c                      | 1 -
>  arch/riscv/lib/boot.c                          | 3 ++-
>  arch/sandbox/include/asm/global_data.h         | 1 +
>  arch/sh/include/asm/global_data.h              | 2 ++
>  arch/x86/cpu/coreboot/sdram.c                  | 1 -
>  arch/x86/cpu/efi/payload.c                     | 1 -
>  arch/x86/cpu/efi/sdram.c                       | 1 -
>  arch/x86/cpu/ivybridge/sdram_nop.c             | 1 -
>  arch/x86/cpu/qemu/dram.c                       | 1 -
>  arch/x86/cpu/quark/dram.c                      | 1 -
>  arch/x86/cpu/tangier/sdram.c                   | 1 -
>  arch/x86/include/asm/global_data.h             | 1 +
>  arch/xtensa/include/asm/global_data.h          | 2 ++
>  board/keymile/kmcent2/tlb.c                    | 2 +-
>  board/phytium/pe2201/pe2201.c                  | 1 -
>  board/phytium/pomelo/pomelo.c                  | 1 -
>  board/renesas/falcon/falcon.c                  | 1 -
>  board/renesas/grpeach/grpeach.c                | 1 -
>  common/init/handoff.c                          | 1 -
>  common/spl/spl.c                               | 1 -
>  common/spl/spl_ext.c                           | 1 -
>  common/spl/spl_fat.c                           | 1 -
>  common/spl/spl_mmc.c                           | 1 -
>  common/spl/spl_sata.c                          | 1 -
>  common/spl/spl_usb.c                           | 1 -
>  common/spl/spl_ymodem.c                        | 1 -
>  drivers/clk/altera/clk-agilex5.c               | 1 -
>  include/dm/of.h                                | 1 -
>  include/fsl_errata.h                           | 2 +-
>  104 files changed, 48 insertions(+), 88 deletions(-)
>
> diff --git a/api/api_platform-arm.c b/api/api_platform-arm.c
> index 6cfd9e6cc20c..9afba66c2442 100644
> --- a/api/api_platform-arm.c
> +++ b/api/api_platform-arm.c
> @@ -12,7 +12,6 @@
>  #include <linux/types.h>
>  #include <api_public.h>
>
> -#include <asm/u-boot.h>
>  #include <asm/global_data.h>
>
>  #include "api_private.h"
> diff --git a/api/api_platform-mips.c b/api/api_platform-mips.c
> index e1509663af54..262b35a27779 100644
> --- a/api/api_platform-mips.c
> +++ b/api/api_platform-mips.c
> @@ -9,7 +9,6 @@
>  #include <linux/types.h>
>  #include <api_public.h>
>
> -#include <asm/u-boot.h>
>  #include <asm/global_data.h>
>
>  #include "api_private.h"
> diff --git a/api/api_platform-powerpc.c b/api/api_platform-powerpc.c
> index 847a4a3015b0..3a04a9f691c5 100644
> --- a/api/api_platform-powerpc.c
> +++ b/api/api_platform-powerpc.c
> @@ -12,7 +12,6 @@
>  #include <linux/types.h>
>  #include <api_public.h>
>
> -#include <asm/u-boot.h>
>  #include <asm/global_data.h>
>
>  #include "api_private.h"
> diff --git a/arch/arc/include/asm/global_data.h b/arch/arc/include/asm/gl=
obal_data.h
> index e35a26f1eb14..fd9b7fb5f8db 100644
> --- a/arch/arc/include/asm/global_data.h
> +++ b/arch/arc/include/asm/global_data.h
> @@ -6,6 +6,8 @@
>  #ifndef        __ASM_ARC_GLOBAL_DATA_H
>  #define __ASM_ARC_GLOBAL_DATA_H
>
> +#include <asm/u-boot.h>
> +
>  #ifndef __ASSEMBLY__
>  /* Architecture-specific global data */
>  struct arch_global_data {
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/gl=
obal_data.h
> index 452bcd1b8fd9..45401d5e3c8a 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -12,6 +12,7 @@
>  #include <config.h>
>
>  #include <linux/types.h>
> +#include <asm/u-boot.h>
>
>  /* Architecture-specific global data */
>  struct arch_global_data {
> diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
> index 40255ace4051..7c49462c8eb4 100644
> --- a/arch/arm/lib/bdinfo.c
> +++ b/arch/arm/lib/bdinfo.c
> @@ -9,7 +9,6 @@
>  #include <config.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> -#include <asm/u-boot.h>
>  #include <asm/mach-types.h>
>
>  DECLARE_GLOBAL_DATA_PTR;

Applying the patch spits out error right here, since currently on
master branch, arch/arm/lib/bdinfo.c include statements are:

#include <common.h>
#include <init.h>
#include <asm/global_data.h>
#include <asm/mach-types.h>

All the best,
Tony
