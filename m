Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C1D5CC94
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 09:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E10F833C6;
	Tue, 16 Dec 2025 10:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+Qx9mKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BEA83885; Tue, 16 Dec 2025 10:47:12 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755898334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 10:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso4494333a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765878428; x=1766483228; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oteSm1fItPaW8pUEZ9qr0vjiYWT47S0PenAs4kzCMR8=;
 b=X+Qx9mKsJ6jQ1mpI5/uVLq7BpTu2PinI8ZbIwLWZaBBoaoOOm4k9Tckqpzfdy64o9s
 ktfLEsYeiAyXw8/R6gTsj3f5H5j2ZC6SufdQJNWoU+lolrcxgmrG6+X5q15/hTshs4rK
 z8yBG6ptDAVGTnkW8yGxX0duDSLMwz1E7H+LDp09avf9aPOLk2zQWHYreHP/g9vu5c1V
 AsDJuG+e+u3MkMHZEpBVOZlfRV6cwSoDXmzga2Dp1KqSiTk7lEywBSbfsYkW+0lglgcs
 aq5E/cIhrk69Ez45/Z7w81+TGqvKwmPMfdMnFY6gaHqHNekRdpGyc6U67viqj/ONErRA
 RAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765878428; x=1766483228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oteSm1fItPaW8pUEZ9qr0vjiYWT47S0PenAs4kzCMR8=;
 b=PGBgcO4Q1lDUng7OGTWEjdUDs2CH8+bjtgJKdD6w/RGRrsO5IhR9tdQg5l4jf/26g/
 VBRQYhIEkvswrTu3cRxzzKCm5sG7tLtqFMN0VCzviaIiH2SbJnS/b9oDYeG98W4ZVki4
 MCQBZIluuEZ/wTra1Zv7vTKXsgCEruUtcj9yEag386XT0sVO/FP6XooNa+g05ag8x7c1
 PlgUmSKCDo84APakhWWOJ3fv0gNgMQO8rw+QbD90hufmBrj6EmGMm5RYO98vcJIqNiPA
 HgCtRIPErICCfDz1n02ELsTXVqrE32ijFlByeAvQ0UXBFqnrDUfd+xKWlIQTvyZ0hOmw
 PWZg==
X-Gm-Message-State: AOJu0YyNcQ5AOdnU4rfy2Xj6YMO6woVe9b+G84xxrUk5Q07ICgXSgZk4
 Z3wTQK8+yrnMZ4jI0ce8uOji7pxqsy3nvf864bSXlZ3iDF6Ngz4lu8OQh6u+x9Hnih2VPkKisbB
 dgt2fL0RYcSFyJ7Q6RgAjzyqvbk+9elY=
X-Gm-Gg: AY/fxX6gP14j3U1tEHNOf3u2X2xIpM/h0ERI9Qf4esDa5+Xwbv0e7kVo508V4mAm7hj
 gxZDgtJCHSzhHu31kIXP//HcxxyCtEPrPq/Ym5lnE7c3VbnmYJk7v3E5S9s0toUUY6atcNOHNuJ
 7WcZ4P7DTyEu5moMekxHmpKKtyAtVgBZ0fMQKKyHZKxLC4oGH/57acW3hr46c0fdcQatnkUxksa
 rb+9DxluUD8sgYEwXoakj/MmTWaUgf+PXFuI3+LqLdQ8cPR2EaLoufhxspfiAGip1W+Htf5
X-Google-Smtp-Source: AGHT+IGrF4fYPoZ2co8PcK0rIfFiPl3HQUnoIfeFijQkC1I8ZynDLZXDirN0NlQllFY9HG+p4yXfUXOaOxMBVM1Mjn4=
X-Received: by 2002:a05:6830:65c1:20b0:7c7:1a6:6a09 with SMTP id
 46e09a7af769-7cae80dad02mr5840954a34.17.1765878427993; Tue, 16 Dec 2025
 01:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 16 Dec 2025 17:46:57 +0800
X-Gm-Features: AQt7F2rmG8gjfBkDGivzv0l_kugk3R2ZrwHtG5OI4Sm04_i34dT-udUINbtxfpU
Message-ID: <CAN7C2SCMJ4bK0eQc15zGtn1g9-EOuOucY1z+_AjLwrV6dbY3QQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Alif,

I have a question on sdram_arria10.c
Why spl_gen5.c requires:
static struct bd_info bdata __attribute__ ((section(".data")));
with gd->bd =3D &bdata;
But on arria10 this is not required, it is done on another file?

Thank you,
Brian

On Tue, Dec 16, 2025 at 4:46=E2=80=AFPM <alif.zakuan.yuslaimi@altera.com> w=
rote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
> case.
>
> This scrubbing implementation turns the caches on temporarily,
> then overwrites the whole RAM with zeroes, flushes the caches and turns
> them off again. This provides satisfactory performance.
>
> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
> Preparation for Gen5 uses the same memory initialization function as
> Arria10.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
>  drivers/ddr/altera/Makefile        |  4 +-
>  drivers/ddr/altera/sdram_arria10.c | 25 +++-------
>  drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
>  drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h   | 11 +++++
>  6 files changed, 115 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/ddr/altera/sdram_soc32.c
>  create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl=
_gen5.c
> index df79cfe0f7f..5c78a4c1fea 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -27,6 +27,8 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +static struct bd_info bdata __attribute__ ((section(".data")));
> +
>  u32 spl_boot_device(void)
>  {
>         const u32 bsel =3D readl(socfpga_get_sysmgr_addr() +
> @@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
>         /* enable console uart printing */
>         preloader_console_init();
>
> +       gd->bd =3D &bdata;
> +
>         ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
>         if (ret) {
>                 debug("DRAM init failed: %d\n", ret);
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> index 7ed43965be5..b9e3302d714 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -7,8 +7,8 @@
>  # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>
>  ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_gen5.o sequencer.o
> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_arria10.o
> +obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_soc32.o sdram_gen5.o sequen=
cer.o
> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_soc32.o sdram_arria10.o
>  obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) +=3D sdram_soc64.o sdram_s10.o
>  obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) +=3D sdram_soc64.o sdram_agilex.o
>  obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D sdram_soc64.o sdram_n5x.o
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdra=
m_arria10.c
> index d3305a6c82d..0e3a1d42f34 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -21,9 +21,14 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> +#include <linux/sizes.h>
> +
> +#include "sdram_soc32.h"
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +#define PGTABLE_OFF    0x4000
> +
>  static void sdram_mmr_init(void);
>  static u64 sdram_size_calc(void);
>
> @@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>                   ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>  }
>
> -/* Initialize SDRAM ECC bits to avoid false DBE */
> -static void sdram_init_ecc_bits(u32 size)
> -{
> -       icache_enable();
> -
> -       memset(0, 0, 0x8000);
> -       gd->arch.tlb_addr =3D 0x4000;
> -       gd->arch.tlb_size =3D PGTABLE_SIZE;
> -
> -       dcache_enable();
> -
> -       printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -       memset((void *)0x8000, 0, size - 0x8000);
> -       flush_dcache_all();
> -       printf("DDRCAL: Scrubbing ECC RAM done.\n");
> -       dcache_disable();
> -}
> -
>  /* Function to startup the SDRAM*/
>  static int sdram_startup(void)
>  {
> @@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
>                 puts("FW: Error Configuring Firewall\n");
>
>         if (sdram_is_ecc_enabled())
> -               sdram_init_ecc_bits(gd->ram_size);
> +               sdram_init_ecc_bits();
>
>         return 0;
>  }
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_g=
en5.c
> index 3c79bb11802..7a0a043557b 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright Altera Corporation (C) 2014-2015
>   */
> +#include <cpu_func.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <div64.h>
> @@ -17,8 +18,12 @@
>  #include <asm/bitops.h>
>  #include <asm/io.h>
>  #include <dm/device_compat.h>
> +#include <linux/sizes.h>
>
>  #include "sequencer.h"
> +#include "sdram_soc32.h"
> +
> +#define PGTABLE_OFF    0x4000
>
>  #ifdef CONFIG_XPL_BUILD
>
> @@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct soc=
fpga_sdr_ctrl *sdr_ctrl)
>         return temp;
>  }
>
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +       return !!(readl(&sdr_ctrl->ctrl_cfg) &
> +                 SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
> +}
> +
>  static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>  {
>         struct altera_gen5_sdram_plat *plat =3D dev_get_plat(dev);
> @@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice *d=
ev)
>         sdram_size =3D sdram_calculate_size(sdr_ctrl);
>         debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>
> +       if (sdram_is_ecc_enabled(sdr_ctrl)) {
> +               /* Must set USEECCASDATA to 0 if ECC is enabled */
> +               clrbits_le32(&sdr_ctrl->static_cfg,
> +                            SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
> +               sdram_init_ecc_bits();
> +       }
> +
>         /* Sanity check ensure correct SDRAM size specified */
>         if (get_ram_size(0, sdram_size) !=3D sdram_size) {
>                 puts("SDRAM size check failed!\n");
> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_=
soc32.c
> new file mode 100644
> index 00000000000..b8b42ef8e03
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include "sdram_soc32.h"
> +#include <string.h>
> +#include <linux/sizes.h>
> +#include <cpu_func.h>
> +#include <watchdog.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#if !defined(CONFIG_HW_WATCHDOG)
> +#include <asm/arch/reset_manager.h>
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define PGTABLE_OFF    0x4000
> +
> +/* Initialize SDRAM ECC bits to avoid false DBE */
> +void sdram_init_ecc_bits(void)
> +{
> +       u32 start;
> +       phys_addr_t start_addr;
> +       phys_size_t size, size_init;
> +
> +       start =3D get_timer(0);
> +
> +       start_addr =3D gd->bd->bi_dram[0].start;
> +       size =3D gd->bd->bi_dram[0].size;
> +
> +       printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
> +
> +       memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
> +       gd->arch.tlb_addr =3D start_addr + PGTABLE_OFF;
> +       gd->arch.tlb_size =3D PGTABLE_SIZE;
> +       start_addr +=3D PGTABLE_SIZE + PGTABLE_OFF;
> +       size -=3D PGTABLE_OFF + PGTABLE_SIZE;
> +
> +       dcache_enable();
> +
> +       while (size > 0) {
> +               size_init =3D min((phys_addr_t)SZ_1G, (phys_addr_t)size);
> +               memset((void *)start_addr, 0, size_init);
> +               size -=3D size_init;
> +               start_addr +=3D size_init;
> +
> +#ifdef CONFIG_HW_WATCHDOG
> +               /*
> +                * In case the watchdog is enabled, make sure to
> +                * (re-)configure watchdog so that the defined timeout is
> +                * valid.
> +                */
> +               debug("%s: %d\n", __func__, __LINE__);
> +               hw_watchdog_init();
> +#else
> +               /*
> +                * If the HW watchdog is NOT enabled, make sure it is not
> +                * running, because it is enabled in the preloader and
> +                * causing boot loop if is not handled.
> +                */
> +               debug("%s: %d\n", __func__, __LINE__);
> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +#endif
> +       }
> +
> +       dcache_disable();
> +
> +       printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
> +              (u32)get_timer(start));
> +}
> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_=
soc32.h
> new file mode 100644
> index 00000000000..85a951a5a74
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#ifndef        _SDRAM_SOC32_H_
> +#define        _SDRAM_SOC32_H_
> +
> +void sdram_init_ecc_bits(void);
> +
> +#endif /* _SDRAM_SOC32_H_ */
> --
> 2.43.7
>
