Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBA3D64087
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD42583AA4;
	Wed, 17 Dec 2025 08:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABF1t/rS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBF683AAC; Wed, 17 Dec 2025 08:50:42 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E3D83AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso364886a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765957838; x=1766562638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+HQ50ly5zcrjIGKm9HZqK87udeltfqdvjfk30lf9HU=;
 b=ABF1t/rSKrF4+k2oCfMDKGVfXrGbpi2/XHzhBCgpwLiXaCDEFVSWj6kEFS4HGEtcSr
 VCKLCWx03bHEQk63WzZCmPqLTW9+e7OvkYMaPsjMDqBG2mGnve56Lanh9jGNWGaEdKYP
 6s+t7BTew0ADDLYlVF1Be3O2Ch8KC0m3tAGgcmf4KW/OrdGco5Z60RtiibgbT987T3jT
 qL1fDxt7L9pPdaXft0uKtSmCsfnPWbft3mDraY8w67D2uyEqlYdv8eSsTznwHeDmld3C
 Ef9ARXCjY++w95Zg60FjRkGfV1E8SGyo+tSFhEt4MdLNXitlHLeB9Po6NMG2d+qprJs5
 FU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765957838; x=1766562638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+HQ50ly5zcrjIGKm9HZqK87udeltfqdvjfk30lf9HU=;
 b=Sfhd9nLSHvmB3lSfEiVy1DUGScSjpJsOj//8QuVVbs+MA8Y2QPVIiqg/sCLYwv+uq2
 euTO+deHoIok7scwPPBcXs9G+dNgC4Gq6bIy73uSjjpZW43gUiJdnWPndoIdu8mS663/
 cMLBgLdGIb2jp80DORnKYIQ6+gWVBeAcPJ9xyu7yliGYOdj7CRdxBeYnikn7TJKwHFLZ
 nDk3FjbB1znqIyIKTB2RmbrwT9UfFqTMzxtACl40waT+uifIZnQGDU3oNVBD9NGD8wh8
 YrVyUgbmZ+XyKHka+4Iu0gj/BO6tdlpxmWJpengOQrVY2UlwTiYKrK73bO+QmkMd6m/t
 ErUA==
X-Gm-Message-State: AOJu0Ywxn42hc5gQtAVi3uXaarscbr4aKsaTiWny/ktkbVHKWtbpBJh/
 3/yj4xbZ4HMt7A/TWDK+/XXRAlAknLiJvoNaYLBo0wm08Rod6pCMiLfbma6/7Aa3ZjGuaNCoeXW
 ssIZNTqFU+LIUPIPAy4gBqEpLwE+Cc2LOIm1i
X-Gm-Gg: AY/fxX4W+jNezR9ZE3+4qGM03H1wyukJHsD5yD8B7wRQIIGJTA9DNv6dU9QxOES9N/W
 sSeB6r0qLTRxTE4UfDlNLIS+VUuUj+6zS90ONiqoXq270oIWbDz89UFe17rORHZFgg5a1tfKwIh
 vSwEcplKdia0ivdtuDV53agiRMurvH62c86k9EG27AMzXlOlH8+TO0Qt3KhI09UQpY6M5sJkC8/
 PrFmXRO2xEspbxeOQeXMf+uS+tZ4DY27x7RRyI3JuiTND2Xq5hNOd07bEkskYHCvynsWmMv
X-Google-Smtp-Source: AGHT+IFW0D+efwN1rtO/riU04t4RzKVdUCcXAxYPAhBtJ+finTMKFFUgkwZ4slYoEMybEWJ61ly1rxxj+ArIViUteAo=
X-Received: by 2002:a05:6830:1509:b0:7ca:f4cd:db57 with SMTP id
 46e09a7af769-7caf4cddcf6mr5547471a34.17.1765957838158; Tue, 16 Dec 2025
 23:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SCMJ4bK0eQc15zGtn1g9-EOuOucY1z+_AjLwrV6dbY3QQ@mail.gmail.com>
 <bdc886c5-c101-426c-844e-ef5b5eaac120@altera.com>
In-Reply-To: <bdc886c5-c101-426c-844e-ef5b5eaac120@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 17 Dec 2025 15:50:26 +0800
X-Gm-Features: AQt7F2qjJGw0fy3H_d0LP1yTRAe_s5qqa3uLhlGl9Hqnbnw9DRWu11hj0k3_sc8
Message-ID: <CAN7C2SCdBe_ZqT0U89mcEjQki6viQVcg4-VwT93oBkhFMUYUtw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
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

On Wed, Dec 17, 2025 at 3:27=E2=80=AFPM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hi Brian,
>
> On 16/12/2025 5:46 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Hi Alif,
> >
> > I have a question on sdram_arria10.c
> > Why spl_gen5.c requires:
> > static struct bd_info bdata __attribute__ ((section(".data")));
> > with gd->bd =3D &bdata;
> > But on arria10 this is not required, it is done on another file?
> >
> > Thank you,
> > Brian
> >
>
> I found that removing these will cause failure to boot U-Boot SPL after
> trying to reboot from Linux, SPL will keep on looping during DDR
> initialization.
>
> This could be because of the missing board info in the memory, leading
> to a failed initialization as gd->bd is not set up properly after a warm
> reset.
>
> SPL runs from the small OCRAM before DRAM is available. CycloneV has a
> much more limited OCRAM space compared to Arria10.

I am referring to the A10 case here. Maybe you confused my previous questio=
n.
Why I am asking this question is because both A10 and GEN5 aka C5 use
the same soc32.c. Hence, the ECC will require the gd->bd-> to be defined
in order for .size or .start etc to be used.

+       start_addr =3D gd->bd->bi_dram[0].start;
+       size =3D gd->bd->bi_dram[0].size;

So your dynamic means it is well set up before the ECC init uses those
variables?
As I am not finding, gd->bd is not set in the a10_spl.c at least not
really distinct as "=3D"

Thanks,
Brian

>
> Due to this memory space limitation, there is no dynamic memory
> allocation in Gen5 SPL, therefore bd_info must be allocated statically.
>
> By declaring bd_info as static and placing it in .data section, we can
> minimize Gen5 SPL OCRAM usage, as well as making the SPL execution much
> more simpler and robust.
>
> Thanks,
> Alif
>
> > On Tue, Dec 16, 2025 at 4:46=E2=80=AFPM <alif.zakuan.yuslaimi@altera.co=
m> wrote:
> >>
> >> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>
> >> The SDRAM must first be rewritten by zeroes if ECC is used to initiali=
ze
> >> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such =
a
> >> case.
> >>
> >> This scrubbing implementation turns the caches on temporarily,
> >> then overwrites the whole RAM with zeroes, flushes the caches and turn=
s
> >> them off again. This provides satisfactory performance.
> >>
> >> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.=
c.
> >> Preparation for Gen5 uses the same memory initialization function as
> >> Arria10.
> >>
> >> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> >> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >> ---
> >>   arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
> >>   drivers/ddr/altera/Makefile        |  4 +-
> >>   drivers/ddr/altera/sdram_arria10.c | 25 +++-------
> >>   drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
> >>   drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++=
++
> >>   drivers/ddr/altera/sdram_soc32.h   | 11 +++++
> >>   6 files changed, 115 insertions(+), 21 deletions(-)
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
> >>
> >> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/=
spl_gen5.c
> >> index df79cfe0f7f..5c78a4c1fea 100644
> >> --- a/arch/arm/mach-socfpga/spl_gen5.c
> >> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> >> @@ -27,6 +27,8 @@
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> +static struct bd_info bdata __attribute__ ((section(".data")));
> >> +
> >>   u32 spl_boot_device(void)
> >>   {
> >>          const u32 bsel =3D readl(socfpga_get_sysmgr_addr() +
> >> @@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
> >>          /* enable console uart printing */
> >>          preloader_console_init();
> >>
> >> +       gd->bd =3D &bdata;
> >> +
> >>          ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
> >>          if (ret) {
> >>                  debug("DRAM init failed: %d\n", ret);
> >> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> >> index 7ed43965be5..b9e3302d714 100644
> >> --- a/drivers/ddr/altera/Makefile
> >> +++ b/drivers/ddr/altera/Makefile
> >> @@ -7,8 +7,8 @@
> >>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
> >>
> >>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> >> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_gen5.o sequencer.o
> >> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_arria10.o
> >> +obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_soc32.o sdram_gen5.o seq=
uencer.o
> >> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_soc32.o sdram_arria10=
.o
> >>   obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) +=3D sdram_soc64.o sdram_s10.=
o
> >>   obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) +=3D sdram_soc64.o sdram_agilex.=
o
> >>   obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D sdram_soc64.o sdram_n5x.o
> >> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/s=
dram_arria10.c
> >> index d3305a6c82d..0e3a1d42f34 100644
> >> --- a/drivers/ddr/altera/sdram_arria10.c
> >> +++ b/drivers/ddr/altera/sdram_arria10.c
> >> @@ -21,9 +21,14 @@
> >>   #include <linux/bitops.h>
> >>   #include <linux/delay.h>
> >>   #include <linux/kernel.h>
> >> +#include <linux/sizes.h>
> >> +
> >> +#include "sdram_soc32.h"
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >> +#define PGTABLE_OFF    0x4000
> >> +
> >>   static void sdram_mmr_init(void);
> >>   static u64 sdram_size_calc(void);
> >>
> >> @@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
> >>                    ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
> >>   }
> >>
> >> -/* Initialize SDRAM ECC bits to avoid false DBE */
> >> -static void sdram_init_ecc_bits(u32 size)
> >> -{
> >> -       icache_enable();
> >> -
> >> -       memset(0, 0, 0x8000);
> >> -       gd->arch.tlb_addr =3D 0x4000;
> >> -       gd->arch.tlb_size =3D PGTABLE_SIZE;
> >> -
> >> -       dcache_enable();
> >> -
> >> -       printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> >> -       memset((void *)0x8000, 0, size - 0x8000);
> >> -       flush_dcache_all();
> >> -       printf("DDRCAL: Scrubbing ECC RAM done.\n");
> >> -       dcache_disable();
> >> -}
> >> -
> >>   /* Function to startup the SDRAM*/
> >>   static int sdram_startup(void)
> >>   {
> >> @@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
> >>                  puts("FW: Error Configuring Firewall\n");
> >>
> >>          if (sdram_is_ecc_enabled())
> >> -               sdram_init_ecc_bits(gd->ram_size);
> >> +               sdram_init_ecc_bits();
> >>
> >>          return 0;
> >>   }
> >> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdra=
m_gen5.c
> >> index 3c79bb11802..7a0a043557b 100644
> >> --- a/drivers/ddr/altera/sdram_gen5.c
> >> +++ b/drivers/ddr/altera/sdram_gen5.c
> >> @@ -2,6 +2,7 @@
> >>   /*
> >>    * Copyright Altera Corporation (C) 2014-2015
> >>    */
> >> +#include <cpu_func.h>
> >>   #include <dm.h>
> >>   #include <errno.h>
> >>   #include <div64.h>
> >> @@ -17,8 +18,12 @@
> >>   #include <asm/bitops.h>
> >>   #include <asm/io.h>
> >>   #include <dm/device_compat.h>
> >> +#include <linux/sizes.h>
> >>
> >>   #include "sequencer.h"
> >> +#include "sdram_soc32.h"
> >> +
> >> +#define PGTABLE_OFF    0x4000
> >>
> >>   #ifdef CONFIG_XPL_BUILD
> >>
> >> @@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct =
socfpga_sdr_ctrl *sdr_ctrl)
> >>          return temp;
> >>   }
> >>
> >> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> >> +{
> >> +       return !!(readl(&sdr_ctrl->ctrl_cfg) &
> >> +                 SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
> >> +}
> >> +
> >>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
> >>   {
> >>          struct altera_gen5_sdram_plat *plat =3D dev_get_plat(dev);
> >> @@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice=
 *dev)
> >>          sdram_size =3D sdram_calculate_size(sdr_ctrl);
> >>          debug("SDRAM: %ld MiB\n", sdram_size >> 20);
> >>
> >> +       if (sdram_is_ecc_enabled(sdr_ctrl)) {
> >> +               /* Must set USEECCASDATA to 0 if ECC is enabled */
> >> +               clrbits_le32(&sdr_ctrl->static_cfg,
> >> +                            SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
> >> +               sdram_init_ecc_bits();
> >> +       }
> >> +
> >>          /* Sanity check ensure correct SDRAM size specified */
> >>          if (get_ram_size(0, sdram_size) !=3D sdram_size) {
> >>                  puts("SDRAM size check failed!\n");
> >> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdr=
am_soc32.c
> >> new file mode 100644
> >> index 00000000000..b8b42ef8e03
> >> --- /dev/null
> >> +++ b/drivers/ddr/altera/sdram_soc32.c
> >> @@ -0,0 +1,74 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> >> + */
> >> +
> >> +#include "sdram_soc32.h"
> >> +#include <string.h>
> >> +#include <linux/sizes.h>
> >> +#include <cpu_func.h>
> >> +#include <watchdog.h>
> >> +#include <wait_bit.h>
> >> +#include <asm/global_data.h>
> >> +#include <asm/system.h>
> >> +#if !defined(CONFIG_HW_WATCHDOG)
> >> +#include <asm/arch/reset_manager.h>
> >> +#endif
> >> +
> >> +DECLARE_GLOBAL_DATA_PTR;
> >> +
> >> +#define PGTABLE_OFF    0x4000
> >> +
> >> +/* Initialize SDRAM ECC bits to avoid false DBE */
> >> +void sdram_init_ecc_bits(void)
> >> +{
> >> +       u32 start;
> >> +       phys_addr_t start_addr;
> >> +       phys_size_t size, size_init;
> >> +
> >> +       start =3D get_timer(0);
> >> +
> >> +       start_addr =3D gd->bd->bi_dram[0].start;
> >> +       size =3D gd->bd->bi_dram[0].size;
> >> +
> >> +       printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
> >> +
> >> +       memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
> >> +       gd->arch.tlb_addr =3D start_addr + PGTABLE_OFF;
> >> +       gd->arch.tlb_size =3D PGTABLE_SIZE;
> >> +       start_addr +=3D PGTABLE_SIZE + PGTABLE_OFF;
> >> +       size -=3D PGTABLE_OFF + PGTABLE_SIZE;
> >> +
> >> +       dcache_enable();
> >> +
> >> +       while (size > 0) {
> >> +               size_init =3D min((phys_addr_t)SZ_1G, (phys_addr_t)siz=
e);
> >> +               memset((void *)start_addr, 0, size_init);
> >> +               size -=3D size_init;
> >> +               start_addr +=3D size_init;
> >> +
> >> +#ifdef CONFIG_HW_WATCHDOG
> >> +               /*
> >> +                * In case the watchdog is enabled, make sure to
> >> +                * (re-)configure watchdog so that the defined timeout=
 is
> >> +                * valid.
> >> +                */
> >> +               debug("%s: %d\n", __func__, __LINE__);
> >> +               hw_watchdog_init();
> >> +#else
> >> +               /*
> >> +                * If the HW watchdog is NOT enabled, make sure it is =
not
> >> +                * running, because it is enabled in the preloader and
> >> +                * causing boot loop if is not handled.
> >> +                */
> >> +               debug("%s: %d\n", __func__, __LINE__);
> >> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> >> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> >> +#endif
> >> +       }
> >> +
> >> +       dcache_disable();
> >> +
> >> +       printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
> >> +              (u32)get_timer(start));
> >> +}
> >> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdr=
am_soc32.h
> >> new file mode 100644
> >> index 00000000000..85a951a5a74
> >> --- /dev/null
> >> +++ b/drivers/ddr/altera/sdram_soc32.h
> >> @@ -0,0 +1,11 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> >> + */
> >> +
> >> +#ifndef        _SDRAM_SOC32_H_
> >> +#define        _SDRAM_SOC32_H_
> >> +
> >> +void sdram_init_ecc_bits(void);
> >> +
> >> +#endif /* _SDRAM_SOC32_H_ */
> >> --
> >> 2.43.7
> >>
>
