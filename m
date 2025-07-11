Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFC0C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 19:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CB4828A2;
	Fri, 11 Jul 2025 21:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dSGGQqvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2023182998; Fri, 11 Jul 2025 21:43:49 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569478277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 21:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-31c38e75dafso2192274a91.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1752263024; x=1752867824;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHQ3tWIVxp7RV9YOslYJfx++UcaBVu1oZak/qYCmzv4=;
 b=dSGGQqvFdOfZkrWTG7fDDYm0QUySNmXAtOJd+FXU9lUKRKix2EK9/gRRdWYyWWlBt9
 xp3ZBgLsDPxoqC+0eIDgozyFS0UrVEKMgZqYaD6FNkzkq1W/lD9iKICeLgiFCRH8f9V5
 aJMNy7dXiuqX3aEpItaQHhlY6TjKi7GywMkzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752263024; x=1752867824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHQ3tWIVxp7RV9YOslYJfx++UcaBVu1oZak/qYCmzv4=;
 b=agHWJQmIvSKMqboEeOQ9V0cJ/u8ZhZaXsJljcUMzGGTv83NrtsYntJ0r6qQ9Oc7QFa
 I0qkDoJCDV96GyukVECjUr5lqyDRt0w2Yp0YHFlEbwW0iyQYa3TyHQaT1y2BS2a6tvJx
 TmRnxMygL7fDKAZ0b1/GE6a9mQgn1mVCTgAgUDzzPwS+jrHzJs11KG+ANKx4r8KPxLu7
 Oh82NqtbeyphWEYedGI8VS3+aVkUUnMtY2DtZU2Y2Wkqz57EqQlT+rP54jIkUVnABaxb
 t3S7NEzjrPx5I65krh8MnQmw1W4QjLzB4uZ5Jc+YsGPBsoE/ah17hlN1VwApIAlyDM4O
 hBJw==
X-Gm-Message-State: AOJu0YzlhOxBuU7CfdbTp57QC721HkFI5V3Ai1RcgzeYqxrh1c8MopFV
 wkWeyQq0Ppi9MGt5XJNtmBuanPCbF6il8Z7k291r1VkOw9HVSeSI4bXL4fLh6h6yTCOfM2g6Zfi
 N2XnptfdbgRICkEgEqBA+9MRdoAj6tJq2v8of6zwqbA==
X-Gm-Gg: ASbGnctuu5r+Bkrt66gMyHLMRHzUemUpylTEssO5sm56mjfYL2bCeNWMuYy5CsnsfbT
 SqfQrhSyV+W3SjD00zLWNXl8VeOlk4BcwRM9CLqcFGuzcDGZiHdGDV1uj49qrqy6qar/v6pcGuJ
 Nr7oCiHj3XqhVvL/Gf4AUEiqukbSv+JnSXOaWzq15ofLmY9JaWe2Ht23uXmbosOuUCa053koH0i
 k2SlK6J
X-Google-Smtp-Source: AGHT+IHSExipuNZxM1+V+GQ1tB2J9gSwbkOhWXU6QsksYf7qpv8d4B5xMIo7quE37O+c9JMZzsVxjnJggqT6IwtdMYg=
X-Received: by 2002:a17:90b:1348:b0:311:ff02:3fcb with SMTP id
 98e67ed59e1d1-31c4ccf3b38mr6858933a91.28.1752263023538; Fri, 11 Jul 2025
 12:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250711151952.2225349-1-trini@konsulko.com>
In-Reply-To: <20250711151952.2225349-1-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 11 Jul 2025 21:43:32 +0200
X-Gm-Features: Ac12FXzrCIxgbByYYmYVyyYAohjsMgK2nmRAB5iaogTlPmQ4CoIcLPaYRFd1UBg
Message-ID: <CAOf5uw=R2nTioRf_iqXKPzVzqCLm9UvB4AekUt_PFMQ8ZHvNeQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: Remove unused mxic_nand driver
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

Hi

On Fri, Jul 11, 2025 at 5:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> As no platforms use this driver anymore let's go ahead and remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/mtd/nand/raw/Kconfig     |   6 -
>  drivers/mtd/nand/raw/Makefile    |   1 -
>  drivers/mtd/nand/raw/mxic_nand.c | 602 -------------------------------
>  3 files changed, 609 deletions(-)
>  delete mode 100644 drivers/mtd/nand/raw/mxic_nand.c
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 3ca6d1cca812..4b4330302bed 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -550,12 +550,6 @@ config NAND_MXS_USE_MINIMUM_ECC
>
>  endif
>
> -config NAND_MXIC
> -       bool "Macronix raw NAND controller"
> -       select SYS_NAND_SELF_INIT
> -       help
> -         This selects the Macronix raw NAND controller driver.
> -
>  config NAND_ZYNQ
>         bool "Support for Zynq Nand controller"
>         select SPL_SYS_NAND_SELF_INIT
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index 97e874ef769d..5ffd450e8fe7 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -74,7 +74,6 @@ obj-$(CONFIG_NAND_OMAP_GPMC) +=3D omap_gpmc.o
>  obj-$(CONFIG_NAND_OMAP_ELM) +=3D omap_elm.o
>  obj-$(CONFIG_NAND_SANDBOX) +=3D sand_nand.o
>  obj-$(CONFIG_NAND_SUNXI) +=3D sunxi_nand.o
> -obj-$(CONFIG_NAND_MXIC) +=3D mxic_nand.o
>  obj-$(CONFIG_NAND_ZYNQ) +=3D zynq_nand.o
>  obj-$(CONFIG_NAND_STM32_FMC2) +=3D stm32_fmc2_nand.o
>  obj-$(CONFIG_CORTINA_NAND) +=3D cortina_nand.o
> diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic=
_nand.c
> deleted file mode 100644
> index 0e54b5f69389..000000000000
> --- a/drivers/mtd/nand/raw/mxic_nand.c
> +++ /dev/null
> @@ -1,602 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2021 Macronix International Co., Ltd.
> - *
> - * Author:
> - *     Zhengxun Li <zhengxunli@mxic.com.tw>
> - */
> -
> -#include <clk.h>
> -#include <dm.h>
> -#include <malloc.h>
> -#include <nand.h>
> -#include <asm/io.h>
> -#include <asm/arch/hardware.h>
> -#include <dm/device_compat.h>
> -#include <linux/bug.h>
> -#include <linux/errno.h>
> -#include <linux/iopoll.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/rawnand.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/mtd/nand_ecc.h>
> -#include <linux/delay.h>
> -
> -#define HC_CFG                 0x0
> -#define HC_CFG_IF_CFG(x)       ((x) << 27)
> -#define HC_CFG_DUAL_SLAVE      BIT(31)
> -#define HC_CFG_INDIVIDUAL      BIT(30)
> -#define HC_CFG_NIO(x)          (((x) / 4) << 27)
> -#define HC_CFG_TYPE(s, t)      ((t) << (23 + ((s) * 2)))
> -#define HC_CFG_TYPE_SPI_NOR    0
> -#define HC_CFG_TYPE_SPI_NAND   1
> -#define HC_CFG_TYPE_SPI_RAM    2
> -#define HC_CFG_TYPE_RAW_NAND   3
> -#define HC_CFG_SLV_ACT(x)      ((x) << 21)
> -#define HC_CFG_CLK_PH_EN       BIT(20)
> -#define HC_CFG_CLK_POL_INV     BIT(19)
> -#define HC_CFG_BIG_ENDIAN      BIT(18)
> -#define HC_CFG_DATA_PASS       BIT(17)
> -#define HC_CFG_IDLE_SIO_LVL(x) ((x) << 16)
> -#define HC_CFG_MAN_START_EN    BIT(3)
> -#define HC_CFG_MAN_START       BIT(2)
> -#define HC_CFG_MAN_CS_EN       BIT(1)
> -#define HC_CFG_MAN_CS_ASSERT   BIT(0)
> -
> -#define INT_STS                        0x4
> -#define INT_STS_EN             0x8
> -#define INT_SIG_EN             0xc
> -#define INT_STS_ALL            GENMASK(31, 0)
> -#define INT_RDY_PIN            BIT(26)
> -#define INT_RDY_SR             BIT(25)
> -#define INT_LNR_SUSP           BIT(24)
> -#define INT_ECC_ERR            BIT(17)
> -#define INT_CRC_ERR            BIT(16)
> -#define INT_LWR_DIS            BIT(12)
> -#define INT_LRD_DIS            BIT(11)
> -#define INT_SDMA_INT           BIT(10)
> -#define INT_DMA_FINISH         BIT(9)
> -#define INT_RX_NOT_FULL                BIT(3)
> -#define INT_RX_NOT_EMPTY       BIT(2)
> -#define INT_TX_NOT_FULL                BIT(1)
> -#define INT_TX_EMPTY           BIT(0)
> -
> -#define HC_EN                  0x10
> -#define HC_EN_BIT              BIT(0)
> -
> -#define TXD(x)                 (0x14 + ((x) * 4))
> -#define RXD                    0x24
> -
> -#define SS_CTRL(s)             (0x30 + ((s) * 4))
> -#define LRD_CFG                        0x44
> -#define LWR_CFG                        0x80
> -#define RWW_CFG                        0x70
> -#define OP_READ                        BIT(23)
> -#define OP_DUMMY_CYC(x)                ((x) << 17)
> -#define OP_ADDR_BYTES(x)       ((x) << 14)
> -#define OP_CMD_BYTES(x)                (((x) - 1) << 13)
> -#define OP_OCTA_CRC_EN         BIT(12)
> -#define OP_DQS_EN              BIT(11)
> -#define OP_ENHC_EN             BIT(10)
> -#define OP_PREAMBLE_EN         BIT(9)
> -#define OP_DATA_DDR            BIT(8)
> -#define OP_DATA_BUSW(x)                ((x) << 6)
> -#define OP_ADDR_DDR            BIT(5)
> -#define OP_ADDR_BUSW(x)                ((x) << 3)
> -#define OP_CMD_DDR             BIT(2)
> -#define OP_CMD_BUSW(x)         (x)
> -#define OP_BUSW_1              0
> -#define OP_BUSW_2              1
> -#define OP_BUSW_4              2
> -#define OP_BUSW_8              3
> -
> -#define OCTA_CRC               0x38
> -#define OCTA_CRC_IN_EN(s)      BIT(3 + ((s) * 16))
> -#define OCTA_CRC_CHUNK(s, x)   ((fls((x) / 32)) << (1 + ((s) * 16)))
> -#define OCTA_CRC_OUT_EN(s)     BIT(0 + ((s) * 16))
> -
> -#define ONFI_DIN_CNT(s)                (0x3c + (s))
> -
> -#define LRD_CTRL               0x48
> -#define RWW_CTRL               0x74
> -#define LWR_CTRL               0x84
> -#define LMODE_EN               BIT(31)
> -#define LMODE_SLV_ACT(x)       ((x) << 21)
> -#define LMODE_CMD1(x)          ((x) << 8)
> -#define LMODE_CMD0(x)          (x)
> -
> -#define LRD_ADDR               0x4c
> -#define LWR_ADDR               0x88
> -#define LRD_RANGE              0x50
> -#define LWR_RANGE              0x8c
> -
> -#define AXI_SLV_ADDR           0x54
> -
> -#define DMAC_RD_CFG            0x58
> -#define DMAC_WR_CFG            0x94
> -#define DMAC_CFG_PERIPH_EN     BIT(31)
> -#define DMAC_CFG_ALLFLUSH_EN   BIT(30)
> -#define DMAC_CFG_LASTFLUSH_EN  BIT(29)
> -#define DMAC_CFG_QE(x)         (((x) + 1) << 16)
> -#define DMAC_CFG_BURST_LEN(x)  (((x) + 1) << 12)
> -#define DMAC_CFG_BURST_SZ(x)   ((x) << 8)
> -#define DMAC_CFG_DIR_READ      BIT(1)
> -#define DMAC_CFG_START         BIT(0)
> -
> -#define DMAC_RD_CNT            0x5c
> -#define DMAC_WR_CNT            0x98
> -
> -#define SDMA_ADDR              0x60
> -
> -#define DMAM_CFG               0x64
> -#define DMAM_CFG_START         BIT(31)
> -#define DMAM_CFG_CONT          BIT(30)
> -#define DMAM_CFG_SDMA_GAP(x)   (fls((x) / 8192) << 2)
> -#define DMAM_CFG_DIR_READ      BIT(1)
> -#define DMAM_CFG_EN            BIT(0)
> -
> -#define DMAM_CNT               0x68
> -
> -#define LNR_TIMER_TH           0x6c
> -
> -#define RDM_CFG0               0x78
> -#define RDM_CFG0_POLY(x)       (x)
> -
> -#define RDM_CFG1               0x7c
> -#define RDM_CFG1_RDM_EN                BIT(31)
> -#define RDM_CFG1_SEED(x)       (x)
> -
> -#define LWR_SUSP_CTRL          0x90
> -#define LWR_SUSP_CTRL_EN       BIT(31)
> -
> -#define DMAS_CTRL              0x9c
> -#define DMAS_CTRL_EN           BIT(31)
> -#define DMAS_CTRL_DIR_READ     BIT(30)
> -
> -#define DATA_STROB             0xa0
> -#define DATA_STROB_EDO_EN      BIT(2)
> -#define DATA_STROB_INV_POL     BIT(1)
> -#define DATA_STROB_DELAY_2CYC  BIT(0)
> -
> -#define IDLY_CODE(x)           (0xa4 + ((x) * 4))
> -#define IDLY_CODE_VAL(x, v)    ((v) << (((x) % 4) * 8))
> -
> -#define GPIO                   0xc4
> -#define GPIO_PT(x)             BIT(3 + ((x) * 16))
> -#define GPIO_RESET(x)          BIT(2 + ((x) * 16))
> -#define GPIO_HOLDB(x)          BIT(1 + ((x) * 16))
> -#define GPIO_WPB(x)            BIT((x) * 16)
> -
> -#define HC_VER                 0xd0
> -
> -#define HW_TEST(x)             (0xe0 + ((x) * 4))
> -
> -#define MXIC_NFC_MAX_CLK_HZ    50000000
> -#define IRQ_TIMEOUT            1000
> -
> -struct mxic_nand_ctrl {
> -       struct clk *send_clk;
> -       struct clk *send_dly_clk;
> -       void __iomem *regs;
> -       struct nand_chip nand_chip;
> -};
> -
> -/*
> - * struct mxic_nfc_command_format - Defines NAND flash command format
> - * @start_cmd:         First cycle command (Start command)
> - * @end_cmd:           Second cycle command (Last command)
> - * @addr_len:          Number of address cycles required to send the add=
ress
> - * @read:              Direction of command
> - */
> -
> -struct mxic_nfc_command_format {
> -       int start_cmd;
> -       int end_cmd;
> -       u8 addr_len;
> -       bool read;
> -};
> -
> -/*  The NAND flash operations command format */
> -static const struct mxic_nfc_command_format mxic_nand_commands[] =3D {
> -       {NAND_CMD_READ0,        NAND_CMD_READSTART, 5, 1 },
> -       {NAND_CMD_RNDOUT,       NAND_CMD_RNDOUTSTART, 2, 1 },
> -       {NAND_CMD_READID,       NAND_CMD_NONE, 1, 1 },
> -       {NAND_CMD_STATUS,       NAND_CMD_NONE, 0, 1 },
> -       {NAND_CMD_SEQIN,        NAND_CMD_NONE, 5, 0 },
> -       {NAND_CMD_PAGEPROG,     NAND_CMD_NONE, 0, 0 },
> -       {NAND_CMD_CACHEDPROG,   NAND_CMD_NONE, 0, 0 },
> -       {NAND_CMD_RNDIN,        NAND_CMD_NONE, 2, 0 },
> -       {NAND_CMD_ERASE1,       NAND_CMD_NONE, 3, 0 },
> -       {NAND_CMD_ERASE2,       NAND_CMD_NONE, 0, 0 },
> -       {NAND_CMD_RESET,        NAND_CMD_NONE, 0, 0 },
> -       {NAND_CMD_PARAM,        NAND_CMD_NONE, 1, 1 },
> -       {NAND_CMD_GET_FEATURES, NAND_CMD_NONE, 1, 1 },
> -       {NAND_CMD_SET_FEATURES, NAND_CMD_NONE, 1, 0 },
> -       {NAND_CMD_NONE,         NAND_CMD_NONE, 0, 0 },
> -};
> -
> -static int mxic_nfc_clk_enable(struct mxic_nand_ctrl *nfc)
> -{
> -       int ret;
> -
> -       ret =3D clk_prepare_enable(nfc->send_clk);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D clk_prepare_enable(nfc->send_dly_clk);
> -       if (ret)
> -               goto err_send_dly_clk;
> -
> -       return ret;
> -
> -err_send_dly_clk:
> -       clk_disable_unprepare(nfc->send_clk);
> -
> -       return ret;
> -}
> -
> -static void mxic_nfc_clk_disable(struct mxic_nand_ctrl *nfc)
> -{
> -       clk_disable_unprepare(nfc->send_clk);
> -       clk_disable_unprepare(nfc->send_dly_clk);
> -}
> -
> -static void mxic_nfc_set_input_delay(struct mxic_nand_ctrl *nfc, u8 idly=
_code)
> -{
> -       writel(IDLY_CODE_VAL(0, idly_code) |
> -              IDLY_CODE_VAL(1, idly_code) |
> -              IDLY_CODE_VAL(2, idly_code) |
> -              IDLY_CODE_VAL(3, idly_code),
> -              nfc->regs + IDLY_CODE(0));
> -       writel(IDLY_CODE_VAL(4, idly_code) |
> -              IDLY_CODE_VAL(5, idly_code) |
> -              IDLY_CODE_VAL(6, idly_code) |
> -              IDLY_CODE_VAL(7, idly_code),
> -              nfc->regs + IDLY_CODE(1));
> -}
> -
> -static int mxic_nfc_clk_setup(struct mxic_nand_ctrl *nfc, unsigned long =
freq)
> -{
> -       int ret;
> -
> -       ret =3D clk_set_rate(nfc->send_clk, freq);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D clk_set_rate(nfc->send_dly_clk, freq);
> -       if (ret)
> -               return ret;
> -
> -       /*
> -        * A constant delay range from 0x0 ~ 0x1F for input delay,
> -        * the unit is 78 ps, the max input delay is 2.418 ns.
> -        */
> -       mxic_nfc_set_input_delay(nfc, 0xf);
> -
> -       return 0;
> -}
> -
> -static int mxic_nfc_set_freq(struct mxic_nand_ctrl *nfc, unsigned long f=
req)
> -{
> -       int ret;
> -
> -       if (freq > MXIC_NFC_MAX_CLK_HZ)
> -               freq =3D MXIC_NFC_MAX_CLK_HZ;
> -
> -       mxic_nfc_clk_disable(nfc);
> -       ret =3D mxic_nfc_clk_setup(nfc, freq);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D mxic_nfc_clk_enable(nfc);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> -}
> -
> -static void mxic_nfc_hw_init(struct mxic_nand_ctrl *nfc)
> -{
> -       writel(HC_CFG_NIO(8) | HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) |
> -              HC_CFG_SLV_ACT(0) | HC_CFG_MAN_CS_EN |
> -              HC_CFG_IDLE_SIO_LVL(1), nfc->regs + HC_CFG);
> -       writel(INT_STS_ALL, nfc->regs + INT_STS_EN);
> -       writel(INT_RDY_PIN, nfc->regs + INT_SIG_EN);
> -       writel(0x0, nfc->regs + ONFI_DIN_CNT(0));
> -       writel(0, nfc->regs + LRD_CFG);
> -       writel(0, nfc->regs + LRD_CTRL);
> -       writel(0x0, nfc->regs + HC_EN);
> -}
> -
> -static void mxic_nfc_cs_enable(struct mxic_nand_ctrl *nfc)
> -{
> -       writel(readl(nfc->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> -              nfc->regs + HC_CFG);
> -       writel(HC_CFG_MAN_CS_ASSERT | readl(nfc->regs + HC_CFG),
> -              nfc->regs + HC_CFG);
> -}
> -
> -static void mxic_nfc_cs_disable(struct mxic_nand_ctrl *nfc)
> -{
> -       writel(~HC_CFG_MAN_CS_ASSERT & readl(nfc->regs + HC_CFG),
> -              nfc->regs + HC_CFG);
> -}
> -
> -static int mxic_nfc_data_xfer(struct mxic_nand_ctrl *nfc, const void *tx=
buf,
> -                             void *rxbuf, unsigned int len)
> -{
> -       unsigned int pos =3D 0;
> -
> -       while (pos < len) {
> -               unsigned int nbytes =3D len - pos;
> -               u32 data =3D 0xffffffff;
> -               u32 sts;
> -               int ret;
> -
> -               if (nbytes > 4)
> -                       nbytes =3D 4;
> -
> -               if (txbuf)
> -                       memcpy(&data, txbuf + pos, nbytes);
> -
> -               ret =3D readl_poll_timeout(nfc->regs + INT_STS, sts,
> -                                        sts & INT_TX_EMPTY, 1000000);
> -               if (ret)
> -                       return ret;
> -
> -               writel(data, nfc->regs + TXD(nbytes % 4));
> -
> -               ret =3D readl_poll_timeout(nfc->regs + INT_STS, sts,
> -                                        sts & INT_TX_EMPTY, 1000000);
> -               if (ret)
> -                       return ret;
> -
> -               ret =3D readl_poll_timeout(nfc->regs + INT_STS, sts,
> -                                        sts & INT_RX_NOT_EMPTY, 1000000)=
;
> -               if (ret)
> -                       return ret;
> -
> -               data =3D readl(nfc->regs + RXD);
> -               if (rxbuf) {
> -                       data >>=3D (8 * (4 - nbytes));
> -                       memcpy(rxbuf + pos, &data, nbytes);
> -               }
> -
> -               WARN_ON(readl(nfc->regs + INT_STS) & INT_RX_NOT_EMPTY);
> -
> -               pos +=3D nbytes;
> -       }
> -
> -       return 0;
> -}
> -
> -static uint8_t mxic_nfc_read_byte(struct mtd_info *mtd)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct mxic_nand_ctrl *nfc =3D nand_get_controller_data(chip);
> -       u8 data;
> -
> -       writel(0x0, nfc->regs + ONFI_DIN_CNT(0));
> -       writel(OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
> -              OP_READ, nfc->regs + SS_CTRL(0));
> -
> -       mxic_nfc_data_xfer(nfc, NULL, &data, 1);
> -
> -       return data;
> -}
> -
> -static void mxic_nfc_read_buf(struct mtd_info *mtd, uint8_t *rxbuf, int =
rlen)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct mxic_nand_ctrl *nfc =3D nand_get_controller_data(chip);
> -
> -       writel(0x0, nfc->regs + ONFI_DIN_CNT(0));
> -       writel(OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
> -                           OP_READ, nfc->regs + SS_CTRL(0));
> -
> -       mxic_nfc_data_xfer(nfc, NULL, rxbuf, rlen);
> -}
> -
> -static void mxic_nfc_write_buf(struct mtd_info *mtd, const uint8_t *txbu=
f,
> -                              int wlen)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct mxic_nand_ctrl *nfc =3D nand_get_controller_data(chip);
> -
> -       writel(wlen, nfc->regs + ONFI_DIN_CNT(0));
> -       writel(OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F),
> -              nfc->regs + SS_CTRL(0));
> -
> -       mxic_nfc_data_xfer(nfc, txbuf, NULL, wlen);
> -}
> -
> -static void mxic_nfc_cmd_function(struct mtd_info *mtd, unsigned int com=
mand,
> -                                 int column, int page_addr)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct mxic_nand_ctrl *nfc =3D nand_get_controller_data(chip);
> -       const struct mxic_nfc_command_format *cmd =3D NULL;
> -       u32 sts;
> -       u8 index, addr[5];
> -
> -       /* Emulate NAND_CMD_READOOB */
> -       if (command =3D=3D NAND_CMD_READOOB) {
> -               column +=3D mtd->writesize;
> -               command =3D NAND_CMD_READ0;
> -       }
> -
> -       /* Get the command format */
> -       for (index =3D 0; index < ARRAY_SIZE(mxic_nand_commands); index++=
)
> -               if (command =3D=3D mxic_nand_commands[index].start_cmd)
> -                       break;
> -
> -       cmd =3D &mxic_nand_commands[index];
> -
> -       if (!(command =3D=3D NAND_CMD_PAGEPROG ||
> -             command =3D=3D NAND_CMD_CACHEDPROG ||
> -             command =3D=3D NAND_CMD_ERASE2))
> -               mxic_nfc_cs_disable(nfc);
> -
> -       mxic_nfc_cs_enable(nfc);
> -
> -       if (column !=3D -1) {
> -               addr[0] =3D column;
> -               addr[1] =3D column >> 8;
> -
> -               if (page_addr !=3D -1) {
> -                       addr[2] =3D page_addr;
> -                       addr[3] =3D page_addr >> 8;
> -                       addr[4] =3D page_addr >> 16;
> -               }
> -       } else if (page_addr !=3D -1) {
> -               addr[0] =3D page_addr;
> -               addr[1] =3D page_addr >> 8;
> -               addr[2] =3D page_addr >> 16;
> -       }
> -
> -       writel(0, nfc->regs + HC_EN);
> -       writel(HC_EN_BIT, nfc->regs + HC_EN);
> -       writel(OP_CMD_BUSW(OP_BUSW_8) |  OP_DUMMY_CYC(0x3F) | OP_CMD_BYTE=
S(0),
> -              nfc->regs + SS_CTRL(0));
> -
> -       mxic_nfc_data_xfer(nfc, &cmd->start_cmd, NULL, 1);
> -
> -       if (cmd->addr_len) {
> -               writel(OP_ADDR_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
> -                      OP_ADDR_BYTES(cmd->addr_len), nfc->regs + SS_CTRL(=
0));
> -
> -               mxic_nfc_data_xfer(nfc, &addr, NULL, cmd->addr_len);
> -       }
> -
> -       if (cmd->end_cmd !=3D NAND_CMD_NONE) {
> -               writel(0, nfc->regs + HC_EN);
> -               writel(HC_EN_BIT, nfc->regs + HC_EN);
> -               writel(OP_CMD_BUSW(OP_BUSW_8) |  OP_DUMMY_CYC(0x3F) |
> -                      OP_CMD_BYTES(0), nfc->regs + SS_CTRL(0));
> -
> -               mxic_nfc_data_xfer(nfc, &cmd->end_cmd, NULL, 1);
> -       }
> -
> -       readl_poll_timeout(nfc->regs + INT_STS, sts, sts & INT_RDY_PIN,
> -                          1000000);
> -
> -       if (command =3D=3D NAND_CMD_PAGEPROG ||
> -           command =3D=3D NAND_CMD_CACHEDPROG ||
> -           command =3D=3D NAND_CMD_ERASE2 ||
> -           command =3D=3D NAND_CMD_RESET) {
> -               mxic_nfc_cs_disable(nfc);
> -       }
> -}
> -
> -static int mxic_nfc_setup_data_interface(struct mtd_info *mtd, int chipn=
r,
> -                                        const struct nand_data_interface=
 *conf)
> -{
> -       struct nand_chip *chip =3D mtd_to_nand(mtd);
> -       struct mxic_nand_ctrl *nfc =3D nand_get_controller_data(chip);
> -       const struct nand_sdr_timings *sdr;
> -       unsigned long freq;
> -       int ret;
> -
> -       sdr =3D nand_get_sdr_timings(conf);
> -       if (IS_ERR(sdr))
> -               return PTR_ERR(sdr);
> -
> -       if (chipnr =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> -               return 0;
> -
> -       freq =3D 1000000000 / (sdr->tRC_min / 1000);
> -
> -       ret =3D  mxic_nfc_set_freq(nfc, freq);
> -       if (ret)
> -               WARN_ON("Set freq failed\n");
> -
> -       if (sdr->tRC_min < 30000)
> -               writel(DATA_STROB_EDO_EN, nfc->regs + DATA_STROB);
> -
> -       return 0;
> -}
> -
> -/* Dummy implementation: we don't support multiple chips */
> -static void mxic_nfc_select_chip(struct mtd_info *mtd, int chipnr)
> -{
> -       switch (chipnr) {
> -       case -1:
> -       case 0:
> -               break;
> -
> -       default:
> -               BUG();
> -       }
> -}
> -
> -static int mxic_nfc_probe(struct udevice *dev)
> -{
> -       struct mxic_nand_ctrl *nfc =3D dev_get_priv(dev);
> -       struct nand_chip *nand_chip =3D &nfc->nand_chip;
> -       struct mtd_info *mtd;
> -       ofnode child;
> -       int err;
> -
> -       nfc->regs =3D dev_read_addr_ptr(dev);
> -
> -       nfc->send_clk =3D devm_clk_get(dev, "send");
> -       if (IS_ERR(nfc->send_clk))
> -               return PTR_ERR(nfc->send_clk);
> -
> -       nfc->send_dly_clk =3D devm_clk_get(dev, "send_dly");
> -       if (IS_ERR(nfc->send_dly_clk))
> -               return PTR_ERR(nfc->send_dly_clk);
> -
> -       mtd =3D nand_to_mtd(nand_chip);
> -
> -       ofnode_for_each_subnode(child, dev_ofnode(dev))
> -               nand_set_flash_node(nand_chip, child);
> -
> -       nand_set_controller_data(nand_chip, nfc);
> -
> -       nand_chip->select_chip =3D mxic_nfc_select_chip;
> -       nand_chip->setup_data_interface =3D mxic_nfc_setup_data_interface=
;
> -       nand_chip->cmdfunc =3D mxic_nfc_cmd_function;
> -       nand_chip->read_byte =3D mxic_nfc_read_byte;
> -       nand_chip->read_buf =3D mxic_nfc_read_buf;
> -       nand_chip->write_buf =3D mxic_nfc_write_buf;
> -
> -       mxic_nfc_hw_init(nfc);
> -
> -       err =3D nand_scan(mtd, 1);
> -       if (err)
> -               return err;
> -
> -       err =3D nand_register(0, mtd);
> -       if (err) {
> -               dev_err(dev, "Failed to register MTD: %d\n", err);
> -               return err;
> -       }
> -
> -       return 0;
> -}
> -
> -static const struct udevice_id mxic_nfc_of_ids[] =3D {
> -       { .compatible =3D "mxic,multi-itfc-v009-nand-controller" },
> -       { /* Sentinel */ }
> -};
> -
> -U_BOOT_DRIVER(mxic_nfc) =3D {
> -       .name =3D "mxic_nfc",
> -       .id =3D UCLASS_MTD,
> -       .of_match =3D mxic_nfc_of_ids,
> -       .probe =3D mxic_nfc_probe,
> -       .priv_auto =3D sizeof(struct mxic_nand_ctrl),
> -};
> -
> -void board_nand_init(void)
> -{
> -       struct udevice *dev;
> -       int ret;
> -
> -       ret =3D uclass_get_device_by_driver(UCLASS_MTD,
> -                                         DM_DRIVER_GET(mxic_nfc), &dev);
> -       if (ret && ret !=3D -ENODEV)
> -               pr_err("Failed to initialize %s. (error %d)\n", dev->name=
,
> -                      ret);
> -}
> --
> 2.43.0
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

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
