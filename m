Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7605F109879B
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 15:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DEF83D71;
	Fri, 20 Mar 2026 16:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJplmsY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB41A83E36; Fri, 20 Mar 2026 16:26:52 +0100 (CET)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AAC83CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1279eced0b9so1068888c88.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 08:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774020408; cv=none;
 d=google.com; s=arc-20240605;
 b=j2wovb6R3K6+/EZVC448NlzXAmofIGb7MIVg+9YTYAW/xqyQcWFmYv+4e8Dq7bf9mf
 6DgM/Cks7uJPteaco1EqCQ0jXUYZDRf2orlZ2fMDo55WlGp3YPFybhqwkgsyZBYbVNB/
 ShHhTESDt1lSIyn4hbS5rvLfqNJXtynwQ95/gXYLsdB7c8r0xfSkYWSrBnFIO6jpGGWB
 N46wz+3WsgZCQS2LvDF5+LvOeA2QHv3cpBHdoIOE59LWKwYkYtVzWbZh4ON520aJ+irg
 mJIZVijjh+VyqRUecxZzKFfuZ/QQIrwbtyu44hckv822EkSAHF+omxpk2Hiem//QJrOa
 IBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iFigyVIcwgkbUg5co5XMjfFATUrEqAXp3/Z2DLG7qJw=;
 fh=JXrI8gKPurr923CGQytcS6B1kcIMvYsaWfImmqlnhMk=;
 b=DHcDnZvj5q2w1cq2K2OAysitGv7j05yl1beTDQFnPS16qdwPtHYoNZefiEncwL73XR
 Ycd7+ODzSxCY8dFQ4p/kIm0k8a36U2z/n40Hqv1Xjv1hnw4eVfHRLzRZNgCiWE4adYpQ
 niWZ54vlN6DoQ9lf+xyrZxvpFvCPI4Ci3MQgqN/9xR7UubOP1rPtIWjUEF7mU5W7/k5k
 kQRMPfeXZOgIxDavtBVSXWmV3+Nh4co5MtrQ7vXCJEBx6+3rvqlrlwt+KC04kzYZ8gTG
 +D3mSd4v7g6/szn31gqZqBf3kUR6GsBex7wTfctya+L0O2aGgtDJioL0LEWsldr3kGwC
 VZjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774020408; x=1774625208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iFigyVIcwgkbUg5co5XMjfFATUrEqAXp3/Z2DLG7qJw=;
 b=bJplmsY65Laa6zaeplbuakoPBQrJV/9HIUfEWfkPiNJNim46dmeoywDP4nNsRqPwbq
 t4vVwIufGtY3gFaf3UqFRSaB7GPXwKVf6l5Qwswcj+qZM8jjWwMRh17+/xRsvgUNvQuG
 0OZD0o25gXE7TtihkOzvdxUxX5nHoW9LLAJ4svQCrTinam/+S+nKJcmpX2vhPOrAsknr
 0QZH3kslOGcpB7InsR1PQdqTpsJjK2eIEHrQhhOJgdUaQZDqXrE2UbXmMe7VQnWN5SPD
 +uUTbBDcg69G5NqjHkEfdxMlOf66nL3N329VW202XfFg3DWSAJsjjUVcd6HdCIyCEd3k
 ZiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774020408; x=1774625208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFigyVIcwgkbUg5co5XMjfFATUrEqAXp3/Z2DLG7qJw=;
 b=C3+lK3gPkcg/xcFned0lEhzJhxE2lYqUnBIz34MVkyeZzw4G9RXnPkNAUB/5RjqMBo
 1FeYmMm3dnpa8J1VaYxEjfaM0IJILgwRJTwPSPF2OPVDFYabRTkFjLTWqbZEJkkKyiP7
 WyCwd6DA9K0JqLnLKAQGWoGacOh0oRJIzFV65us0pJAjiyTY/Mn3hES4vZ9kl5zhndDL
 o17edfs2A3bgEm5tTJ2fmrR9TWDIoG3KL/UGSokkgDNhYycGftr6dyjL8Qlqb34gokZd
 iD/E6smqYVvY492w6vHiFUuko2CsyFuronF18IhtgkCq0vHyXshMDd6426Kiot0n8RdD
 YkJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX6Yb7GQPsI25TvBq2qsw/TZMLMxFhgV2zPzwHp5sLvUilGHfNNMcR2wHwu7nA4A9ZqCoG580=@lists.denx.de
X-Gm-Message-State: AOJu0YyPRn8L1b38GMBcsa4ezzkuBlN4SRYktxugY/iyrfEtAb1r2Q6X
 F0T2naHXiBAL6z7cHmX/LYsMnqFuvq8hfGG/9+MW5PPs9jY9qmMT+3t6mMnCht9+RcyrBej9Qqc
 tGruU8ocXrej45GJbe+ek4wQMsvn1YQ8=
X-Gm-Gg: ATEYQzwTRDAzLGxiOyrz4tEEo+tlOyWDdImtRvJNr1JHYFcvgVq+J+FvqdJcd94GPst
 1+FAcF2OiRbBj53RS0rVkzxjDKQGKWyMyL6rlu6/dGJA/uib4U2208dePYvU1KWbM0YlClKnlXr
 /cKAUw5iOFes3ch3rWkFfTLSXEGSn4NKZvotyVl6YdS0ni3AX38n0RK/qhkbneWPbFzx2uJ0Eab
 i3ZUavnOgtGJvxoUWNtFfPszgAU/qcN6glr33Rzx1qOop6AANm8KpksGkzNOK2mnkdJ1dbdES0Q
 dZGyWVjI8avPdUos+bMQ9I5OHZEzQvrYE2l2h++rr46CWJkGYAlLkZz2NHRL/ySp0tvvHK68oJF
 09M69RpGDahQJrvSYVBSULNnZpLU=
X-Received: by 2002:a05:7022:490:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12a7267d891mr1575148c88.9.1774020408252; Fri, 20 Mar 2026
 08:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-4-rs@ti.com>
 <DH7J0W8ZJCDY.27ZGBQPIP4TP5@ti.com>
In-Reply-To: <DH7J0W8ZJCDY.27ZGBQPIP4TP5@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 20 Mar 2026 10:26:21 -0500
X-Gm-Features: AaiRm519qow7aPFQO5dCfZb248FUCJhXDRbPzUx8d7R1JojsF6PIKag7R1GZYDU
Message-ID: <CAOCHtYg3OcqNCP=vNtMDuDauFoUgED0o7t_8vAcPmo3M4Hxzhw@mail.gmail.com>
Subject: Re: [PATCH 3/3] k3-am62-pocketbeagle2: add support for 1GB variant
To: Anshul Dalal <anshuld@ti.com>, Andrei Aldea <andrei@ti.com>
Cc: rs@ti.com, bb@ti.com, nm@ti.com, trini@konsulko.com, afd@ti.com, 
 u-boot@lists.denx.de
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

> > +
> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
> > +     bool "Set the PocketBeagle 2 RAM size instead of detecting it"
> > +     default false
> > +     help
> > +       RAM size is automatically detected through the device revision stored
> > +       in EEPROM. This overrides the detection logic with a fixed value.
>
> With the ability to detect the board type via the EEPROM, is there any
> use to having this option?
>
> IMO we should just let the board boot with runtime detection for DDR
> size everytime. This config option just makes the execution harder to
> understand while providing minimal value.

Phytec also does that with their boards that detect memory sizes, i
think Randolph was trying to mirror that kconfig section..

>
> > +
> > +choice
> > +     prompt "PocketBeagle 2 RAM size"
> > +     depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
> > +     default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
> > +
> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
> > +     bool "512MB RAM"
> > +     help
> > +       Set RAM size fix to 512MB for the PocketBeagle 2.
> > +
> > +config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
> > +     bool "1GB RAM"
> > +     help
> > +       Set RAM size fix to 1GB for the PocketBeagle 2.
> > +
> > +endchoice
> > diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbeagle2/Makefile
> > index 3d42c160716..dd529fe6d75 100644
> > --- a/board/beagle/pocketbeagle2/Makefile
> > +++ b/board/beagle/pocketbeagle2/Makefile
> > @@ -7,3 +7,5 @@
> >  #
> >
> >  obj-y += pocketbeagle2.o
> > +obj-${CONFIG_K3_DDRSS} += ../../phytec/common/k3/k3_ddrss_patch.o
> > +obj-${CONFIG_TI_I2C_BOARD_DETECT} += ../../ti/common/board_detect.o
> > diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
> > index b6768caa34b..1bfc79350b6 100644
> > --- a/board/beagle/pocketbeagle2/pocketbeagle2.c
> > +++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
> > @@ -15,15 +15,123 @@
> >  #include <spl.h>
> >  #include <asm/arch/k3-ddr.h>
> >
> > +#include "../../ti/common/board_detect.h"
> > +#include "pocketbeagle2_ddr.h"
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +static int pocketbeagle2_get_ddr_size(void)
> > +{
> > +     // check config overrides first
> > +     if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
> > +             if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB))
> > +                     return EEPROM_RAM_SIZE_512MB;
> > +             if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
> > +                     return EEPROM_RAM_SIZE_1GB;
> > +     }
> > +
> > +#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
> > +     // dynamically detect the config if we can
> > +     if (!do_board_detect_am6()) {
> > +             struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> > +
> > +             if (strlen(ep->name) > 11 && ep->name[0] == 'P') {
> > +                     /*
> > +                      * POCKETBEAGL2A00 (am6232 512MB)
> > +                      * POCKETBEAGL2A10 (am625 512MB)
> > +                      * POCKETBEAGL2A1I (am625 1GB)
> > +                      */
> > +                     if (!strncmp(&ep->name[11], "2A1I", 4))
> > +                             return EEPROM_RAM_SIZE_1GB;
> > +             }
> > +     }
> > +#endif
> > +
> > +     return EEPROM_RAM_SIZE_512MB;
> > +}
> > +
> >  int dram_init(void)
> >  {
> > -     return fdtdec_setup_mem_size_base();
> > +     if (!IS_ENABLED(CONFIG_CPU_V7R))
>
> I don't have a 1GiB pb2 to test with but I'm assuming the fixed up
> memory nodes get passed from the R5 SPL to A53 SPL and then finally to
> U-Boot as part of fixup_memory_node from k3-ddr.c.

@Andrei Aldea ^ can you help ;)


> Could somebody confirm if this is indeed the correct flow? I wanted to
> see if both A53 SPL and U-Boot receive the correct memory size as part
> of their DT.

Sadly while developing this, the DT memory values were not passed
between the R5 SPL and the A53 SPL ( and thus A53 main )..

After thinking about this routine since I came up with it last month,
it might be better to do 2 device-tree's...  So with 512MB default
path, for 1GB, patch ddr timing in R5/SPL and force 1GB device tree.
Then A53/SPL (and main) would have the correct memory size..

Currently, we read the eeprom 3 times, R5 SPL, A53 SPL and A53 main..
(but we only need it really twice, R5 SPL (ddr patch) and the A53 main
(device-tree values patching..)


>
> > +             return fdtdec_setup_mem_size_base();
> > +
> > +     return 0;
> >  }
> >
> > +// logic after this block assumes that there is only 1 DRAM bank currently
> > +#if CONFIG_NR_DRAM_BANKS != 1
> > +#error Unsupported number of DRAM banks!
> > +#endif
> > +
> >  int dram_init_banksize(void)
> >  {
> > -     return fdtdec_setup_memory_banksize();
> > +     u8 ram_size;
> > +
> > +     if (!IS_ENABLED(CONFIG_CPU_V7R))
> > +             return fdtdec_setup_memory_banksize();
> > +
> > +     memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
> > +
> > +     ram_size = pocketbeagle2_get_ddr_size();
> > +     switch (ram_size) {
> > +     case EEPROM_RAM_SIZE_1GB:
> > +             gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> > +             gd->bd->bi_dram[0].size = 0x40000000;
> > +             gd->ram_size = 0x40000000;
> > +             break;
> > +     case EEPROM_RAM_SIZE_512MB:
> > +     default:
> > +             gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> > +             gd->bd->bi_dram[0].size = 0x20000000;
> > +             gd->ram_size = 0x20000000;
>
> We can make use of SZ_512M and SZ_1G macros here.
>
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_K3_DDRSS)
> > +static int update_ddrss_timings(void)
> > +{
> > +     int ret = 0;
> > +     u8 ram_size = 0;
>
> Having a u8 of "ram_size" is confusing, we should  make it explict that
> it's an index into pocketbeagle2_ddrss_data.
>
> > +     struct ddrss *ddr_patch = NULL;
> > +     void *fdt = (void *)gd->fdt_blob;
> > +
> > +     ram_size = pocketbeagle2_get_ddr_size();
> > +     ddr_patch = &pocketbeagle2_ddrss_data[ram_size];
> > +
> > +     if (!ddr_patch)
> > +             return ret;
> > +
> > +     ret = fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
> > +     if (ret) {
> > +             printf("Failed to apply ddrs timings patch: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +int do_board_detect(void)
> > +{
> > +     void *fdt = (void *)gd->fdt_blob;
> > +     u64 start[] = {gd->bd->bi_dram[0].start};
> > +     u64 size[] = {gd->bd->bi_dram[0].size};
> > +     int ret;
> > +
>
> Nit: formatting (done with clang-format)
>
>         -       u64 start[] = {gd->bd->bi_dram[0].start};
>         -       u64 size[] = {gd->bd->bi_dram[0].size};
>         +       u64 start[] = { gd->bd->bi_dram[0].start };
>         +       u64 size[] = { gd->bd->bi_dram[0].size };
>                 ...
>         -       snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFAULT_DEVICE_TREE);
>         +       snprintf(fdtfile, sizeof(fdtfile), "%s.dtb",
>         +                CONFIG_DEFAULT_DEVICE_TREE);
>
>
> > +     dram_init();
> > +     dram_init_banksize();
> > +
> > +     ret = fdt_fixup_memory_banks(fdt, start, size, 1);
> > +     if (ret) {
> > +             printf("Failed to fixup memory banks: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     return update_ddrss_timings();
> >  }
> > +#endif /* CONFIG_K3_DDRSS */
> >
> >  #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
> >  int board_late_init(void)
> > diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
> > new file mode 100644
> > index 00000000000..6d248ce6dfa
> > --- /dev/null
> > +++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
> > @@ -0,0 +1,50 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * DDR override logic for AM625 PocketBeagle 2
> > + * https://www.beagleboard.org/boards/pocketbeagle-2
> > + *
> > + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#ifndef __POCKETBEAGLE2_DDR_H
> > +#define __POCKETBEAGLE2_DDR_H
> > +
> > +#include "../../phytec/common/k3/k3_ddrss_patch.h"
> > +
> > +enum {
> > +     EEPROM_RAM_SIZE_512MB = 0,
> > +     EEPROM_RAM_SIZE_1GB = 1
> > +};
> > +
> > +struct ddr_reg ddr_1gb_ctl_regs[] = {
> > +     { 317, 0x00000101 },
> > +     { 318, 0x1FFF0000 },
> > +};
> > +
> > +struct ddr_reg ddr_1gb_pi_regs[] = {
> > +     { 77, 0x04010100 },
> > +};
> > +
> > +struct ddrss pocketbeagle2_ddrss_data[] = {
> > +     // default configuration
> > +     [EEPROM_RAM_SIZE_512MB] = {
> > +             .ctl_regs = NULL,
> > +             .ctl_regs_num = 0,
> > +             .pi_regs = NULL,
> > +             .pi_regs_num = 0,
> > +             .phy_regs = NULL,
> > +             .phy_regs_num = 0,
> > +     },
> > +
> > +     // industrial configuration
> > +     [EEPROM_RAM_SIZE_1GB] = {
> > +             .ctl_regs = &ddr_1gb_ctl_regs[0],
> > +             .ctl_regs_num = ARRAY_SIZE(ddr_1gb_ctl_regs),
> > +             .pi_regs = &ddr_1gb_pi_regs[0],
> > +             .pi_regs_num = ARRAY_SIZE(ddr_1gb_pi_regs),
> > +             .phy_regs = NULL,
> > +             .phy_regs_num = 0,
> > +     },
> > +};
> > +
> > +#endif /* __POCKETBEAGLE2_DDR_H */
> > diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
> > index e863204cfef..d72f78b932c 100644
> > --- a/configs/am62_pocketbeagle2_r5_defconfig
> > +++ b/configs/am62_pocketbeagle2_r5_defconfig
> > @@ -14,7 +14,7 @@ CONFIG_DM_GPIO=y
> >  CONFIG_SPL_DM_SPI=y
> >  CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-pocketbeagle2"
> >  CONFIG_DM_RESET=y
> > -CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
> > +CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
> >  CONFIG_SPL_MMC=y
> >  CONFIG_SPL_SERIAL=y
> >  CONFIG_SPL_DRIVERS_MISC=y
> > @@ -42,6 +42,7 @@ CONFIG_SPL_SYS_MALLOC=y
> >  CONFIG_SPL_EARLY_BSS=y
> >  CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> >  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
> > +CONFIG_SPL_I2C=y
> >  CONFIG_SPL_DM_MAILBOX=y
> >  CONFIG_SPL_DM_RESET=y
> >  CONFIG_SPL_POWER_DOMAIN=y
> > @@ -73,6 +74,8 @@ CONFIG_SPL_CLK_K3_PLL=y
> >  CONFIG_SPL_CLK_K3=y
> >  CONFIG_TI_SCI_PROTOCOL=y
> >  CONFIG_DA8XX_GPIO=y
> > +CONFIG_DM_I2C=y
> > +CONFIG_SYS_I2C_OMAP24XX=y
> >  CONFIG_DM_MAILBOX=y
> >  CONFIG_K3_SEC_PROXY=y
> >  CONFIG_SPL_MISC=y
>


-- 
Robert Nelson
https://rcn-ee.com/
