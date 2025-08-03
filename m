Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B9DC87FCA
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C0D83BB5;
	Sun,  3 Aug 2025 10:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A2gLdvOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AAB83D03; Sun,  3 Aug 2025 10:23:36 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D537183B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3190fbe8536so1972394a91.3
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754209411; x=1754814211;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jLO+eglqOIDomSDRSTgOGq+pWTW6mn2q1/zJQjLypNE=;
 b=A2gLdvOYOCfAuG+XZEamXfWwUjxPtVDhtWYHNPpH4YptcHU/lNhgnbXjduDDebMWko
 N16143sazTYaADasLf2XJs19366sG9MGxN5KVWGQf1E58ASMab+wPOJzWoAygU5dthNr
 OCjg6nuq1POpvnoxFKl+sOsiqfWXWF9nvwAgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754209411; x=1754814211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLO+eglqOIDomSDRSTgOGq+pWTW6mn2q1/zJQjLypNE=;
 b=Fn+2e7IPdA3A+nFptoV+MBzhMRkS9t1o7q1T3QMPavHxS3eODk7aqZTwE4RVHO6ZB3
 QxybZMiZr2ZihCT6PAFy1i0mqMakRnQvaG21hDPW2qEq1/ASJoS2MRe+5IYAvtGtRuLu
 DyIT9KaMuJ8eMJ6W2pypUpV20PXylkogvSOBbyEQkT9klUmwR6juJrh7w8JyIM0GzwVZ
 SXUMcHqGjfZnCqE/fE6lrletjJq2BUu4tZ1VgJal0oHoZYoodP9LBnIR76yqbSwYrqvV
 Gs3/oeSBvcwlpD37aVM5iBowrtrwU53sCv27T5DK+RAKEc58mefaH8WE/g6bAKh5GRPJ
 sz3w==
X-Gm-Message-State: AOJu0YyJzwuHMelayusFsszzWOE5ggPKF99M4q6BX/G5Q9Y/8we/EBhA
 S7SqZHJdmQ5SjFIJ1tOySSiXRCwiAUoqhQmbV1MDg/OwH5FkiOlSYQzmwBHdJSGe5Vpia0x6EzG
 yeZRqFFyT1wHr2StXmKsJZGS22puRlXcx+iqvwZFr9A==
X-Gm-Gg: ASbGncuiC2CdepDrwCLKtXPcW9JxPob1I6XXN/QQEelSK2cIAuMh6VQ/sWrCduLit+L
 Tn6Gda44pgEHhfWeCFXvLBRBUUobgjg4FogzQtc+h+ywnerSC5kjkRs0+tXGHCeOQlGsWW6hg1o
 f0LFCpVgrskaFvY0f9qZAGhoB4SJ6FDUT0KKpxiZQ9Ols+AC7l5vTDOmW71Kj2ql5pYB6+QAuW9
 qX07A==
X-Google-Smtp-Source: AGHT+IHldvyRnKu5Ieo1N3C3dmkF+QQQfTzhvRF7kP1yt/htuu0+T0TIEQoHWroof8EkKbsNlayjYEbFeJVjx+Y1k6U=
X-Received: by 2002:a17:90b:2246:b0:320:fe6d:860a with SMTP id
 98e67ed59e1d1-3211629d087mr9100566a91.18.1754209410916; Sun, 03 Aug 2025
 01:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250711151957.2225373-1-trini@konsulko.com>
In-Reply-To: <20250711151957.2225373-1-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:23:18 +0200
X-Gm-Features: Ac12FXwC3IOXQx8a5C0KvptJolA-_5ax9OueeRRCtZ-MrlZIsfWnRrulFBSaQY8
Message-ID: <CAOf5uwn98ry8sYmVJ6oogqRJcDftxz1Bt2KvOJT70gWLpTyPhw@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: Remove unused lpc32xx_nand_slc driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Fri, Jul 11, 2025 at 5:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> As no platforms use this driver anymore let's go ahead and remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/include/asm/arch-lpc32xx/config.h |  19 -
>  drivers/mtd/nand/raw/Kconfig               |   9 +-
>  drivers/mtd/nand/raw/Makefile              |   1 -
>  drivers/mtd/nand/raw/lpc32xx_nand_slc.c    | 587 ---------------------
>  4 files changed, 2 insertions(+), 614 deletions(-)
>  delete mode 100644 drivers/mtd/nand/raw/lpc32xx_nand_slc.c
>
>
Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>


> diff --git a/arch/arm/include/asm/arch-lpc32xx/config.h
> b/arch/arm/include/asm/arch-lpc32xx/config.h
> index b2d87524f709..e4005b94b543 100644
> --- a/arch/arm/include/asm/arch-lpc32xx/config.h
> +++ b/arch/arm/include/asm/arch-lpc32xx/config.h
> @@ -17,25 +17,6 @@
>  #define CFG_SYS_BAUDRATE_TABLE \
>                 { 9600, 19200, 38400, 57600, 115200, 230400, 460800 }
>
> -/* NAND */
> -#if defined(CONFIG_NAND_LPC32XX_SLC)
> -#define NAND_LARGE_BLOCK_PAGE_SIZE     0x800
> -#define NAND_SMALL_BLOCK_PAGE_SIZE     0x200
> -
> -#if (CONFIG_SYS_NAND_PAGE_SIZE =3D=3D NAND_LARGE_BLOCK_PAGE_SIZE)
> -#define CFG_SYS_NAND_ECCPOS            { 40, 41, 42, 43, 44, 45, 46, 47,=
 \
> -                                         48, 49, 50, 51, 52, 53, 54, 55,=
 \
> -                                         56, 57, 58, 59, 60, 61, 62, 63,=
 }
> -#elif (CONFIG_SYS_NAND_PAGE_SIZE =3D=3D NAND_SMALL_BLOCK_PAGE_SIZE)
> -#define CFG_SYS_NAND_ECCPOS            { 10, 11, 12, 13, 14, 15, }
> -#else
> -#error "CONFIG_SYS_NAND_PAGE_SIZE set to an invalid value"
> -#endif
> -
> -#define CFG_SYS_NAND_ECCSIZE           0x100
> -#define CFG_SYS_NAND_ECCBYTES  3
> -#endif /* CONFIG_NAND_LPC32XX_SLC */
> -
>  /* NOR Flash */
>
>  /* USB OHCI */
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index c9b4450aafa1..3ca6d1cca812 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -260,11 +260,6 @@ config NAND_LPC32XX_MLC
>         help
>           Enable the LPC32XX MLC NAND controller.
>
> -config NAND_LPC32XX_SLC
> -       bool "Support LPC32XX_SLC controller"
> -       help
> -         Enable the LPC32XX SLC NAND controller.
> -
>  config NAND_OMAP_GPMC
>         bool "Support OMAP GPMC NAND controller"
>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
> @@ -683,7 +678,7 @@ config SYS_NAND_ONFI_DETECTION
>
>  config SYS_NAND_PAGE_SIZE
>         hex "NAND chip page size"
> -       depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
> +       depends on ARCH_SUNXI || NAND_OMAP_GPMC || \
>                 SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
>                 MVEBU_SPL_BOOT_DEVICE_NAND || \
>                 (NAND_ATMEL && SPL_NAND_SUPPORT) || \
> @@ -694,7 +689,7 @@ config SYS_NAND_PAGE_SIZE
>
>  config SYS_NAND_OOBSIZE
>         hex "NAND chip OOB size"
> -       depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
> +       depends on ARCH_SUNXI || NAND_OMAP_GPMC || \
>                 SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
>                 (NAND_ATMEL && SPL_NAND_SUPPORT) ||
> SPL_GENERATE_ATMEL_PMECC_HEADER
>         help
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index 34cba77046a1..97e874ef769d 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -61,7 +61,6 @@ obj-$(CONFIG_NAND_FSL_IFC) +=3D fsl_ifc_nand.o
>  obj-$(CONFIG_NAND_KIRKWOOD) +=3D kirkwood_nand.o
>  obj-$(CONFIG_NAND_KMETER1) +=3D kmeter1_nand.o
>  obj-$(CONFIG_NAND_LPC32XX_MLC) +=3D lpc32xx_nand_mlc.o
> -obj-$(CONFIG_NAND_LPC32XX_SLC) +=3D lpc32xx_nand_slc.o
>  obj-$(CONFIG_NAND_VF610_NFC) +=3D vf610_nfc.o
>  obj-$(CONFIG_NAND_MESON) +=3D meson_nand.o
>  obj-$(CONFIG_NAND_MXC) +=3D mxc_nand.o
> diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
> b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
> deleted file mode 100644
> index 109c31fb4d10..000000000000
> --- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
> +++ /dev/null
> @@ -1,587 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * LPC32xx SLC NAND flash controller driver
> - *
> - * (C) Copyright 2015-2018 Vladimir Zapolskiy <vz@mleia.com>
> - * Copyright (c) 2015 Tyco Fire Protection Products.
> - *
> - * Hardware ECC support original source code
> - * Copyright (C) 2008 by NXP Semiconductors
> - * Author: Kevin Wells
> - */
> -
> -#include <config.h>
> -#include <log.h>
> -#include <nand.h>
> -#include <linux/bug.h>
> -#include <linux/mtd/nand_ecc.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/errno.h>
> -#include <asm/io.h>
> -#include <asm/arch/config.h>
> -#include <asm/arch/clk.h>
> -#include <asm/arch/sys_proto.h>
> -#include <asm/arch/dma.h>
> -#include <asm/arch/cpu.h>
> -#include <linux/printk.h>
> -
> -struct lpc32xx_nand_slc_regs {
> -       u32 data;
> -       u32 addr;
> -       u32 cmd;
> -       u32 stop;
> -       u32 ctrl;
> -       u32 cfg;
> -       u32 stat;
> -       u32 int_stat;
> -       u32 ien;
> -       u32 isr;
> -       u32 icr;
> -       u32 tac;
> -       u32 tc;
> -       u32 ecc;
> -       u32 dma_data;
> -};
> -
> -/* CFG register */
> -#define CFG_CE_LOW             (1 << 5)
> -#define CFG_DMA_ECC            (1 << 4) /* Enable DMA ECC bit */
> -#define CFG_ECC_EN             (1 << 3) /* ECC enable bit */
> -#define CFG_DMA_BURST          (1 << 2) /* DMA burst bit */
> -#define CFG_DMA_DIR            (1 << 1) /* DMA write(0)/read(1) bit */
> -
> -/* CTRL register */
> -#define CTRL_SW_RESET          (1 << 2)
> -#define CTRL_ECC_CLEAR         (1 << 1) /* Reset ECC bit */
> -#define CTRL_DMA_START         (1 << 0) /* Start DMA channel bit */
> -
> -/* STAT register */
> -#define STAT_DMA_FIFO          (1 << 2) /* DMA FIFO has data bit */
> -#define STAT_NAND_READY                (1 << 0)
> -
> -/* INT_STAT register */
> -#define INT_STAT_TC            (1 << 1)
> -#define INT_STAT_RDY           (1 << 0)
> -
> -/* TAC register bits, be aware of overflows */
> -#define TAC_W_RDY(n)           (max_t(uint32_t, (n), 0xF) << 28)
> -#define TAC_W_WIDTH(n)         (max_t(uint32_t, (n), 0xF) << 24)
> -#define TAC_W_HOLD(n)          (max_t(uint32_t, (n), 0xF) << 20)
> -#define TAC_W_SETUP(n)         (max_t(uint32_t, (n), 0xF) << 16)
> -#define TAC_R_RDY(n)           (max_t(uint32_t, (n), 0xF) << 12)
> -#define TAC_R_WIDTH(n)         (max_t(uint32_t, (n), 0xF) << 8)
> -#define TAC_R_HOLD(n)          (max_t(uint32_t, (n), 0xF) << 4)
> -#define TAC_R_SETUP(n)         (max_t(uint32_t, (n), 0xF) << 0)
> -
> -/* NAND ECC Layout for small page NAND devices
> - * Note: For large page devices, the default layouts are used. */
> -static struct nand_ecclayout lpc32xx_nand_oob_16 =3D {
> -       .eccbytes =3D 6,
> -       .eccpos =3D { 10, 11, 12, 13, 14, 15, },
> -       .oobfree =3D {
> -               { .offset =3D 0, .length =3D 4, },
> -               { .offset =3D 6, .length =3D 4, },
> -       }
> -};
> -
> -#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
> -#define ECCSTEPS       (CONFIG_SYS_NAND_PAGE_SIZE / CFG_SYS_NAND_ECCSIZE=
)
> -
> -/*
> - * DMA Descriptors
> - * For Large Block: 17 descriptors =3D ((16 Data and ECC Read) + 1 Spare
> Area)
> - * For Small Block: 5 descriptors =3D ((4 Data and ECC Read) + 1 Spare A=
rea)
> - */
> -static struct lpc32xx_dmac_ll dmalist[ECCSTEPS * 2 + 1];
> -static u32 ecc_buffer[8]; /* MAX ECC size */
> -static unsigned int dmachan =3D (unsigned int)-1; /* Invalid channel */
> -
> -/*
> - * Helper macro for the DMA client (i.e. NAND SLC):
> - * - to write the next DMA linked list item address
> - *   (see arch/include/asm/arch-lpc32xx/dma.h).
> - * - to assign the DMA data register to DMA source or destination addres=
s.
> - * - to assign the ECC register to DMA source or destination address.
> - */
> -#define lpc32xx_dmac_next_lli(x)       ((u32)x)
> -#define lpc32xx_dmac_set_dma_data()
> ((u32)&lpc32xx_nand_slc_regs->dma_data)
> -#define lpc32xx_dmac_set_ecc()         ((u32)&lpc32xx_nand_slc_regs->ecc=
)
> -#endif
> -
> -static struct lpc32xx_nand_slc_regs __iomem *lpc32xx_nand_slc_regs
> -       =3D (struct lpc32xx_nand_slc_regs __iomem *)SLC_NAND_BASE;
> -
> -static void lpc32xx_nand_init(void)
> -{
> -       uint32_t hclk =3D get_hclk_clk_rate();
> -
> -       /* Reset SLC NAND controller */
> -       writel(CTRL_SW_RESET, &lpc32xx_nand_slc_regs->ctrl);
> -
> -       /* 8-bit bus, no DMA, no ECC, ordinary CE signal */
> -       writel(0, &lpc32xx_nand_slc_regs->cfg);
> -
> -       /* Interrupts disabled and cleared */
> -       writel(0, &lpc32xx_nand_slc_regs->ien);
> -       writel(INT_STAT_TC | INT_STAT_RDY,
> -              &lpc32xx_nand_slc_regs->icr);
> -
> -       /* Configure NAND flash timings */
> -       writel(TAC_W_RDY(CFG_LPC32XX_NAND_SLC_WDR_CLKS) |
> -              TAC_W_WIDTH(hclk / CFG_LPC32XX_NAND_SLC_WWIDTH) |
> -              TAC_W_HOLD(hclk / CFG_LPC32XX_NAND_SLC_WHOLD) |
> -              TAC_W_SETUP(hclk / CFG_LPC32XX_NAND_SLC_WSETUP) |
> -              TAC_R_RDY(CFG_LPC32XX_NAND_SLC_RDR_CLKS) |
> -              TAC_R_WIDTH(hclk / CFG_LPC32XX_NAND_SLC_RWIDTH) |
> -              TAC_R_HOLD(hclk / CFG_LPC32XX_NAND_SLC_RHOLD) |
> -              TAC_R_SETUP(hclk / CFG_LPC32XX_NAND_SLC_RSETUP),
> -              &lpc32xx_nand_slc_regs->tac);
> -}
> -
> -static void lpc32xx_nand_cmd_ctrl(struct mtd_info *mtd,
> -                                 int cmd, unsigned int ctrl)
> -{
> -       debug("ctrl: 0x%08x, cmd: 0x%08x\n", ctrl, cmd);
> -
> -       if (ctrl & NAND_NCE)
> -               setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_CE_LOW);
> -       else
> -               clrbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_CE_LOW);
> -
> -       if (cmd =3D=3D NAND_CMD_NONE)
> -               return;
> -
> -       if (ctrl & NAND_CLE)
> -               writel(cmd & 0xFF, &lpc32xx_nand_slc_regs->cmd);
> -       else if (ctrl & NAND_ALE)
> -               writel(cmd & 0xFF, &lpc32xx_nand_slc_regs->addr);
> -}
> -
> -static int lpc32xx_nand_dev_ready(struct mtd_info *mtd)
> -{
> -       return readl(&lpc32xx_nand_slc_regs->stat) & STAT_NAND_READY;
> -}
> -
> -#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
> -/*
> - * Prepares DMA descriptors for NAND RD/WR operations
> - * If the size is < 256 Bytes then it is assumed to be
> - * an OOB transfer
> - */
> -static void lpc32xx_nand_dma_configure(struct nand_chip *chip,
> -                                      const u8 *buffer, int size,
> -                                      int read)
> -{
> -       u32 i, dmasrc, ctrl, ecc_ctrl, oob_ctrl, dmadst;
> -       struct lpc32xx_dmac_ll *dmalist_cur;
> -       struct lpc32xx_dmac_ll *dmalist_cur_ecc;
> -
> -       /*
> -        * CTRL descriptor entry for reading ECC
> -        * Copy Multiple times to sync DMA with Flash Controller
> -        */
> -       ecc_ctrl =3D 0x5 |
> -                       DMAC_CHAN_SRC_BURST_1 |
> -                       DMAC_CHAN_DEST_BURST_1 |
> -                       DMAC_CHAN_SRC_WIDTH_32 |
> -                       DMAC_CHAN_DEST_WIDTH_32 |
> -                       DMAC_CHAN_DEST_AHB1;
> -
> -       /* CTRL descriptor entry for reading/writing Data */
> -       ctrl =3D (CFG_SYS_NAND_ECCSIZE / 4) |
> -                       DMAC_CHAN_SRC_BURST_4 |
> -                       DMAC_CHAN_DEST_BURST_4 |
> -                       DMAC_CHAN_SRC_WIDTH_32 |
> -                       DMAC_CHAN_DEST_WIDTH_32 |
> -                       DMAC_CHAN_DEST_AHB1;
> -
> -       /* CTRL descriptor entry for reading/writing Spare Area */
> -       oob_ctrl =3D (CONFIG_SYS_NAND_OOBSIZE / 4) |
> -                       DMAC_CHAN_SRC_BURST_4 |
> -                       DMAC_CHAN_DEST_BURST_4 |
> -                       DMAC_CHAN_SRC_WIDTH_32 |
> -                       DMAC_CHAN_DEST_WIDTH_32 |
> -                       DMAC_CHAN_DEST_AHB1;
> -
> -       if (read) {
> -               dmasrc =3D lpc32xx_dmac_set_dma_data();
> -               dmadst =3D (u32)buffer;
> -               ctrl |=3D DMAC_CHAN_DEST_AUTOINC;
> -       } else {
> -               dmadst =3D lpc32xx_dmac_set_dma_data();
> -               dmasrc =3D (u32)buffer;
> -               ctrl |=3D DMAC_CHAN_SRC_AUTOINC;
> -       }
> -
> -       /*
> -        * Write Operation Sequence for Small Block NAND
> -        * ----------------------------------------------------------
> -        * 1. X'fer 256 bytes of data from Memory to Flash.
> -        * 2. Copy generated ECC data from Register to Spare Area
> -        * 3. X'fer next 256 bytes of data from Memory to Flash.
> -        * 4. Copy generated ECC data from Register to Spare Area.
> -        * 5. X'fer 16 byets of Spare area from Memory to Flash.
> -        * Read Operation Sequence for Small Block NAND
> -        * ----------------------------------------------------------
> -        * 1. X'fer 256 bytes of data from Flash to Memory.
> -        * 2. Copy generated ECC data from Register to ECC calc Buffer.
> -        * 3. X'fer next 256 bytes of data from Flash to Memory.
> -        * 4. Copy generated ECC data from Register to ECC calc Buffer.
> -        * 5. X'fer 16 bytes of Spare area from Flash to Memory.
> -        * Write Operation Sequence for Large Block NAND
> -        * ----------------------------------------------------------
> -        * 1. Steps(1-4) of Write Operations repeate for four times
> -        * which generates 16 DMA descriptors to X'fer 2048 bytes of
> -        * data & 32 bytes of ECC data.
> -        * 2. X'fer 64 bytes of Spare area from Memory to Flash.
> -        * Read Operation Sequence for Large Block NAND
> -        * ----------------------------------------------------------
> -        * 1. Steps(1-4) of Read Operations repeate for four times
> -        * which generates 16 DMA descriptors to X'fer 2048 bytes of
> -        * data & 32 bytes of ECC data.
> -        * 2. X'fer 64 bytes of Spare area from Flash to Memory.
> -        */
> -
> -       for (i =3D 0; i < size/CFG_SYS_NAND_ECCSIZE; i++) {
> -               dmalist_cur =3D &dmalist[i * 2];
> -               dmalist_cur_ecc =3D &dmalist[(i * 2) + 1];
> -
> -               dmalist_cur->dma_src =3D (read ? (dmasrc) : (dmasrc +
> (i*256)));
> -               dmalist_cur->dma_dest =3D (read ? (dmadst + (i*256)) :
> dmadst);
> -               dmalist_cur->next_lli =3D
> lpc32xx_dmac_next_lli(dmalist_cur_ecc);
> -               dmalist_cur->next_ctrl =3D ctrl;
> -
> -               dmalist_cur_ecc->dma_src =3D lpc32xx_dmac_set_ecc();
> -               dmalist_cur_ecc->dma_dest =3D (u32)&ecc_buffer[i];
> -               dmalist_cur_ecc->next_lli =3D
> -                       lpc32xx_dmac_next_lli(&dmalist[(i * 2) + 2]);
> -               dmalist_cur_ecc->next_ctrl =3D ecc_ctrl;
> -       }
> -
> -       if (i) { /* Data only transfer */
> -               dmalist_cur_ecc =3D &dmalist[(i * 2) - 1];
> -               dmalist_cur_ecc->next_lli =3D 0;
> -               dmalist_cur_ecc->next_ctrl |=3D DMAC_CHAN_INT_TC_EN;
> -               return;
> -       }
> -
> -       /* OOB only transfer */
> -       if (read) {
> -               dmasrc =3D lpc32xx_dmac_set_dma_data();
> -               dmadst =3D (u32)buffer;
> -               oob_ctrl |=3D DMAC_CHAN_DEST_AUTOINC;
> -       } else {
> -               dmadst =3D lpc32xx_dmac_set_dma_data();
> -               dmasrc =3D (u32)buffer;
> -               oob_ctrl |=3D DMAC_CHAN_SRC_AUTOINC;
> -       }
> -
> -       /* Read/ Write Spare Area Data To/From Flash */
> -       dmalist_cur =3D &dmalist[i * 2];
> -       dmalist_cur->dma_src =3D dmasrc;
> -       dmalist_cur->dma_dest =3D dmadst;
> -       dmalist_cur->next_lli =3D 0;
> -       dmalist_cur->next_ctrl =3D (oob_ctrl | DMAC_CHAN_INT_TC_EN);
> -}
> -
> -static void lpc32xx_nand_xfer(struct mtd_info *mtd, const u8 *buf,
> -                             int len, int read)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       u32 config;
> -       int ret;
> -
> -       /* DMA Channel Configuration */
> -       config =3D (read ? DMAC_CHAN_FLOW_D_P2M : DMAC_CHAN_FLOW_D_M2P) |
> -               (read ? DMAC_DEST_PERIP(0) :
> DMAC_DEST_PERIP(DMA_PERID_NAND1)) |
> -               (read ? DMAC_SRC_PERIP(DMA_PERID_NAND1) :
> DMAC_SRC_PERIP(0)) |
> -               DMAC_CHAN_ENABLE;
> -
> -       /* Prepare DMA descriptors */
> -       lpc32xx_nand_dma_configure(chip, buf, len, read);
> -
> -       /* Setup SLC controller and start transfer */
> -       if (read)
> -               setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_DIR);
> -       else  /* NAND_ECC_WRITE */
> -               clrbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_DIR);
> -       setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_DMA_BURST);
> -
> -       /* Write length for new transfers */
> -       if (!((readl(&lpc32xx_nand_slc_regs->stat) & STAT_DMA_FIFO) |
> -             readl(&lpc32xx_nand_slc_regs->tc))) {
> -               int tmp =3D (len !=3D mtd->oobsize) ? mtd->oobsize : 0;
> -               writel(len + tmp, &lpc32xx_nand_slc_regs->tc);
> -       }
> -
> -       setbits_le32(&lpc32xx_nand_slc_regs->ctrl, CTRL_DMA_START);
> -
> -       /* Start DMA transfers */
> -       ret =3D lpc32xx_dma_start_xfer(dmachan, dmalist, config);
> -       if (unlikely(ret < 0))
> -               BUG();
> -
> -       /* Wait for NAND to be ready */
> -       while (!lpc32xx_nand_dev_ready(mtd))
> -               ;
> -
> -       /* Wait till DMA transfer is DONE */
> -       if (lpc32xx_dma_wait_status(dmachan))
> -               pr_err("NAND DMA transfer error!\r\n");
> -
> -       /* Stop DMA & HW ECC */
> -       clrbits_le32(&lpc32xx_nand_slc_regs->ctrl, CTRL_DMA_START);
> -       clrbits_le32(&lpc32xx_nand_slc_regs->cfg,
> -                    CFG_DMA_DIR | CFG_DMA_BURST | CFG_ECC_EN |
> CFG_DMA_ECC);
> -}
> -
> -static u32 slc_ecc_copy_to_buffer(u8 *spare, const u32 *ecc, int count)
> -{
> -       int i;
> -       for (i =3D 0; i < (count * CFG_SYS_NAND_ECCBYTES);
> -            i +=3D CFG_SYS_NAND_ECCBYTES) {
> -               u32 ce =3D ecc[i / CFG_SYS_NAND_ECCBYTES];
> -               ce =3D ~(ce << 2) & 0xFFFFFF;
> -               spare[i+2] =3D (u8)(ce & 0xFF); ce >>=3D 8;
> -               spare[i+1] =3D (u8)(ce & 0xFF); ce >>=3D 8;
> -               spare[i]   =3D (u8)(ce & 0xFF);
> -       }
> -       return 0;
> -}
> -
> -static int lpc32xx_ecc_calculate(struct mtd_info *mtd, const uint8_t *da=
t,
> -                                uint8_t *ecc_code)
> -{
> -       return slc_ecc_copy_to_buffer(ecc_code, ecc_buffer, ECCSTEPS);
> -}
> -
> -/*
> - * Enables and prepares SLC NAND controller
> - * for doing data transfers with H/W ECC enabled.
> - */
> -static void lpc32xx_hwecc_enable(struct mtd_info *mtd, int mode)
> -{
> -       /* Clear ECC */
> -       writel(CTRL_ECC_CLEAR, &lpc32xx_nand_slc_regs->ctrl);
> -
> -       /* Setup SLC controller for H/W ECC operations */
> -       setbits_le32(&lpc32xx_nand_slc_regs->cfg, CFG_ECC_EN |
> CFG_DMA_ECC);
> -}
> -
> -/*
> - * lpc32xx_correct_data - [NAND Interface] Detect and correct bit error(=
s)
> - * mtd:        MTD block structure
> - * dat:        raw data read from the chip
> - * read_ecc:   ECC from the chip
> - * calc_ecc:   the ECC calculated from raw data
> - *
> - * Detect and correct a 1 bit error for 256 byte block
> - */
> -int lpc32xx_correct_data(struct mtd_info *mtd, u_char *dat,
> -                        u_char *read_ecc, u_char *calc_ecc)
> -{
> -       unsigned int i;
> -       int ret1, ret2 =3D 0;
> -       u_char *r =3D read_ecc;
> -       u_char *c =3D calc_ecc;
> -       u16 data_offset =3D 0;
> -
> -       for (i =3D 0 ; i < ECCSTEPS ; i++) {
> -               r +=3D CFG_SYS_NAND_ECCBYTES;
> -               c +=3D CFG_SYS_NAND_ECCBYTES;
> -               data_offset +=3D CFG_SYS_NAND_ECCSIZE;
> -
> -               ret1 =3D nand_correct_data(mtd, dat + data_offset, r, c);
> -               if (ret1 < 0)
> -                       return -EBADMSG;
> -               else
> -                       ret2 +=3D ret1;
> -       }
> -
> -       return ret2;
> -}
> -
> -static void lpc32xx_dma_read_buf(struct mtd_info *mtd, uint8_t *buf, int
> len)
> -{
> -       lpc32xx_nand_xfer(mtd, buf, len, 1);
> -}
> -
> -static void lpc32xx_dma_write_buf(struct mtd_info *mtd, const uint8_t
> *buf,
> -                                 int len)
> -{
> -       lpc32xx_nand_xfer(mtd, buf, len, 0);
> -}
> -
> -/* Reuse the logic from "nand_read_page_hwecc()" */
> -static int lpc32xx_read_page_hwecc(struct mtd_info *mtd, struct nand_chi=
p
> *chip,
> -                               uint8_t *buf, int oob_required, int page)
> -{
> -       int i;
> -       int stat;
> -       uint8_t *p =3D buf;
> -       uint8_t *ecc_calc =3D chip->buffers->ecccalc;
> -       uint8_t *ecc_code =3D chip->buffers->ecccode;
> -       uint32_t *eccpos =3D chip->ecc.layout->eccpos;
> -       unsigned int max_bitflips =3D 0;
> -
> -       /*
> -        * As per the "LPC32x0 and LPC32x0/01 User manual" table 173 note=
s
> -        * and section 9.7, the NAND SLC & DMA allowed single DMA
> transaction
> -        * of a page size using DMA controller scatter/gather mode throug=
h
> -        * linked list; the ECC read is done without any software
> intervention.
> -        */
> -
> -       lpc32xx_hwecc_enable(mtd, NAND_ECC_READ);
> -       lpc32xx_dma_read_buf(mtd, p, chip->ecc.size * chip->ecc.steps);
> -       lpc32xx_ecc_calculate(mtd, p, &ecc_calc[0]);
> -       lpc32xx_dma_read_buf(mtd, chip->oob_poi, mtd->oobsize);
> -
> -       for (i =3D 0; i < chip->ecc.total; i++)
> -               ecc_code[i] =3D chip->oob_poi[eccpos[i]];
> -
> -       stat =3D chip->ecc.correct(mtd, p, &ecc_code[0], &ecc_calc[0]);
> -       if (stat < 0)
> -               mtd->ecc_stats.failed++;
> -       else {
> -               mtd->ecc_stats.corrected +=3D stat;
> -               max_bitflips =3D max_t(unsigned int, max_bitflips, stat);
> -       }
> -
> -       return max_bitflips;
> -}
> -
> -/* Reuse the logic from "nand_write_page_hwecc()" */
> -static int lpc32xx_write_page_hwecc(struct mtd_info *mtd,
> -                                   struct nand_chip *chip,
> -                                   const uint8_t *buf, int oob_required,
> -                                   int page)
> -{
> -       int i;
> -       uint8_t *ecc_calc =3D chip->buffers->ecccalc;
> -       const uint8_t *p =3D buf;
> -       uint32_t *eccpos =3D chip->ecc.layout->eccpos;
> -
> -       /*
> -        * As per the "LPC32x0 and LPC32x0/01 User manual" table 173 note=
s
> -        * and section 9.7, the NAND SLC & DMA allowed single DMA
> transaction
> -        * of a page size using DMA controller scatter/gather mode throug=
h
> -        * linked list; the ECC read is done without any software
> intervention.
> -        */
> -
> -       lpc32xx_hwecc_enable(mtd, NAND_ECC_WRITE);
> -       lpc32xx_dma_write_buf(mtd, p, chip->ecc.size * chip->ecc.steps);
> -       lpc32xx_ecc_calculate(mtd, p, &ecc_calc[0]);
> -
> -       for (i =3D 0; i < chip->ecc.total; i++)
> -               chip->oob_poi[eccpos[i]] =3D ecc_calc[i];
> -
> -       lpc32xx_dma_write_buf(mtd, chip->oob_poi, mtd->oobsize);
> -
> -       return 0;
> -}
> -#else
> -static void lpc32xx_read_buf(struct mtd_info *mtd, uint8_t *buf, int len=
)
> -{
> -       while (len-- > 0)
> -               *buf++ =3D readl(&lpc32xx_nand_slc_regs->data);
> -}
> -
> -static void lpc32xx_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> int len)
> -{
> -       while (len-- > 0)
> -               writel(*buf++, &lpc32xx_nand_slc_regs->data);
> -}
> -#endif
> -
> -static uint8_t lpc32xx_read_byte(struct mtd_info *mtd)
> -{
> -       return readl(&lpc32xx_nand_slc_regs->data);
> -}
> -
> -static void lpc32xx_write_byte(struct mtd_info *mtd, uint8_t byte)
> -{
> -       writel(byte, &lpc32xx_nand_slc_regs->data);
> -}
> -
> -/*
> - * LPC32xx has only one SLC NAND controller, don't utilize
> - * CONFIG_SYS_NAND_SELF_INIT to be able to reuse this function
> - * both in SPL NAND and U-Boot images.
> - */
> -int board_nand_init(struct nand_chip *lpc32xx_chip)
> -{
> -#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
> -       int ret;
> -
> -       /* Acquire a channel for our use */
> -       ret =3D lpc32xx_dma_get_channel();
> -       if (unlikely(ret < 0)) {
> -               pr_info("Unable to get free DMA channel for NAND
> transfers\n");
> -               return -1;
> -       }
> -       dmachan =3D (unsigned int)ret;
> -#endif
> -
> -       lpc32xx_chip->cmd_ctrl  =3D lpc32xx_nand_cmd_ctrl;
> -       lpc32xx_chip->dev_ready =3D lpc32xx_nand_dev_ready;
> -
> -       /*
> -        * The implementation of these functions is quite common, but
> -        * they MUST be defined, because access to data register
> -        * is strictly 32-bit aligned.
> -        */
> -       lpc32xx_chip->read_byte  =3D lpc32xx_read_byte;
> -       lpc32xx_chip->write_byte =3D lpc32xx_write_byte;
> -
> -#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
> -       /* Hardware ECC calculation is supported when DMA driver is
> selected */
> -       lpc32xx_chip->ecc.mode          =3D NAND_ECC_HW;
> -
> -       lpc32xx_chip->read_buf          =3D lpc32xx_dma_read_buf;
> -       lpc32xx_chip->write_buf         =3D lpc32xx_dma_write_buf;
> -
> -       lpc32xx_chip->ecc.calculate     =3D lpc32xx_ecc_calculate;
> -       lpc32xx_chip->ecc.correct       =3D lpc32xx_correct_data;
> -       lpc32xx_chip->ecc.hwctl         =3D lpc32xx_hwecc_enable;
> -       lpc32xx_chip->chip_delay        =3D 2000;
> -
> -       lpc32xx_chip->ecc.read_page     =3D lpc32xx_read_page_hwecc;
> -       lpc32xx_chip->ecc.write_page    =3D lpc32xx_write_page_hwecc;
> -       lpc32xx_chip->options           |=3D NAND_NO_SUBPAGE_WRITE;
> -#else
> -       /*
> -        * Hardware ECC calculation is not supported by the driver,
> -        * because it requires DMA support, see LPC32x0 User Manual,
> -        * note after SLC_ECC register description (UM10326, p.198)
> -        */
> -       lpc32xx_chip->ecc.mode =3D NAND_ECC_SOFT;
> -
> -       /*
> -        * The implementation of these functions is quite common, but
> -        * they MUST be defined, because access to data register
> -        * is strictly 32-bit aligned.
> -        */
> -       lpc32xx_chip->read_buf   =3D lpc32xx_read_buf;
> -       lpc32xx_chip->write_buf  =3D lpc32xx_write_buf;
> -#endif
> -
> -       /*
> -        * These values are predefined
> -        * for both small and large page NAND flash devices.
> -        */
> -       lpc32xx_chip->ecc.size     =3D CFG_SYS_NAND_ECCSIZE;
> -       lpc32xx_chip->ecc.bytes    =3D CFG_SYS_NAND_ECCBYTES;
> -       lpc32xx_chip->ecc.strength =3D 1;
> -
> -       if (CONFIG_SYS_NAND_PAGE_SIZE !=3D NAND_LARGE_BLOCK_PAGE_SIZE)
> -               lpc32xx_chip->ecc.layout =3D &lpc32xx_nand_oob_16;
> -
> -#if defined(CONFIG_SYS_NAND_USE_FLASH_BBT)
> -       lpc32xx_chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> -#endif
> -
> -       /* Initialize NAND interface */
> -       lpc32xx_nand_init();
> -
> -       return 0;
> -}
> --
> 2.43.0
>
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
