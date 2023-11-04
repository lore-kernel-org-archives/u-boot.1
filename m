Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE0C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 23:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A25486903;
	Sun,  5 Nov 2023 00:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="cSNh52Nw";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="JM6GwwGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A92286FFF; Sat,  4 Nov 2023 21:58:53 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5723B86FFC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 6c7a2ec4;
 Sat, 4 Nov 2023 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=s/
 t+uOl+cZQJQxrUxLZS3NGV/dY=; b=cSNh52NwRE7DU48O3LGkyYhdvdRy6F51L6
 iQo6cOc9qR4xLSveI499fMeo/qxDN/EpwpPsjDkeXhx7s+alXu1Aznga0/G1RAKt
 DeVNHTKmiKnA27WacaV+jAn+XAatzqpYsWkls7Dlrv3PkCqi5vmdYSljwCLOdcc5
 pS0cuO3L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 CvnaFhupKqGky8zs/JydTiPHADYTuLizLCM61t+pe9UvM7Gim+F1pwZCzUapJIbd
 HPKyx3coMAgdXEBYuYFBY8C4lzipT4gHiUb5a1QTqn9s5Vfd1J9vMFB+0QkOswOD
 uYGueYMTgPC2cVBZnNVgIyc4wChC4VaPtSXiAH4wBF8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1699131538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9/H229BSPCc8cz0qGFHi1Y1D+fZAAolaJRkUmJtS74=;
 b=JM6GwwGxEucyIOiSKq/YatvXzzmu8wp6MlgLzdHLCJvjF4vwWYtgMN2jUPRxC4ZRgyZJf0
 xzcUc4Ap9D0yIFXZzBrTuVYbBhgvprgjehNG614cNv8hyYoyzPqkJbR7LtMDS9IdnTspE8
 x0KzST0XN6xCjOvCzNUmBLI91huHo/8=
Received: from [192.168.0.2] (host-79-24-2-249.retail.telecomitalia.it
 [79.24.2.249])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 42f334a6
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 4 Nov 2023 20:58:58 +0000 (UTC)
Message-ID: <63a7cd49-9491-6939-48af-62b2fc586cae@kernel-space.org>
Date: Sat, 4 Nov 2023 21:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 01/20] m68k: Remove CONFIG_FSLDMAFEC
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231101162824.3755579-1-trini@konsulko.com>
From: Angelo Dureghello <angelo@kernel-space.org>
Content-Language: en-US
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 05 Nov 2023 00:16:35 +0100
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

Reviewed by: Angelo Dureghello <angelo@kernel-space.org>


Thanks for the cleanup, m68k boards build fine.

fsl_mcdmafec driver is still referenced in arch/m68k/dts/mcf54xx.dtsi,
(from compatible field) but no board is including it.
You can remove the dtsi too if you want.

Regards,
angelo


On 01/11/23 5:28 PM, Tom Rini wrote:
> There are no platforms which enable this feature, so remove it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   arch/m68k/include/asm/fsl_mcdmafec.h |  151 --
>   arch/m68k/include/asm/immap.h        |   15 -
>   arch/m68k/lib/fec.c                  |    4 +-
>   drivers/dma/Kconfig                  |    1 -
>   drivers/dma/MCD_dmaApi.c             | 1010 -----------
>   drivers/dma/MCD_tasks.c              | 2413 --------------------------
>   drivers/dma/MCD_tasksInit.c          |  225 ---
>   drivers/dma/Makefile                 |    1 -
>   drivers/net/Kconfig                  |    8 -
>   drivers/net/Makefile                 |    1 -
>   drivers/net/fsl_mcdmafec.c           |  592 -------
>   include/MCD_dma.h                    |  369 ----
>   include/MCD_progCheck.h              |   10 -
>   include/MCD_tasksInit.h              |   43 -
>   14 files changed, 2 insertions(+), 4841 deletions(-)
>   delete mode 100644 arch/m68k/include/asm/fsl_mcdmafec.h
>   delete mode 100644 drivers/dma/MCD_dmaApi.c
>   delete mode 100644 drivers/dma/MCD_tasks.c
>   delete mode 100644 drivers/dma/MCD_tasksInit.c
>   delete mode 100644 drivers/net/fsl_mcdmafec.c
>   delete mode 100644 include/MCD_dma.h
>   delete mode 100644 include/MCD_progCheck.h
>   delete mode 100644 include/MCD_tasksInit.h
> 
> diff --git a/arch/m68k/include/asm/fsl_mcdmafec.h b/arch/m68k/include/asm/fsl_mcdmafec.h
> deleted file mode 100644
> index de6c548fafd7..000000000000
> --- a/arch/m68k/include/asm/fsl_mcdmafec.h
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * fsl_mcdmafec.h -- Multi-channel DMA Fast Ethernet Controller definitions
> - *
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
> - */
> -
> -#ifndef fsl_mcdmafec_h
> -#define fsl_mcdmafec_h
> -
> -/* Re-use of the definitions */
> -#include <asm/fec.h>
> -
> -typedef struct fecdma {
> -	u32 rsvd0;		/* 0x000 */
> -	u32 eir;		/* 0x004 */
> -	u32 eimr;		/* 0x008 */
> -	u32 rsvd1[6];		/* 0x00C - 0x023 */
> -	u32 ecr;		/* 0x024 */
> -	u32 rsvd2[6];		/* 0x028 - 0x03F */
> -	u32 mmfr;		/* 0x040 */
> -	u32 mscr;		/* 0x044 */
> -	u32 rsvd3[7];		/* 0x048 - 0x063 */
> -	u32 mibc;		/* 0x064 */
> -	u32 rsvd4[7];		/* 0x068 - 0x083 */
> -	u32 rcr;		/* 0x084 */
> -	u32 rhr;		/* 0x088 */
> -	u32 rsvd5[14];		/* 0x08C - 0x0C3 */
> -	u32 tcr;		/* 0x0C4 */
> -	u32 rsvd6[7];		/* 0x0C8 - 0x0E3 */
> -	u32 palr;		/* 0x0E4 */
> -	u32 paur;		/* 0x0E8 */
> -	u32 opd;		/* 0x0EC */
> -	u32 rsvd7[10];		/* 0x0F0 - 0x117 */
> -	u32 iaur;		/* 0x118 */
> -	u32 ialr;		/* 0x11C */
> -	u32 gaur;		/* 0x120 */
> -	u32 galr;		/* 0x124 */
> -	u32 rsvd8[7];		/* 0x128 - 0x143 */
> -	u32 tfwr;		/* 0x144 */
> -	u32 rsvd9[14];		/* 0x148 - 0x17F */
> -	u32 fmc;		/* 0x180 */
> -	u32 rfdr;		/* 0x184 */
> -	u32 rfsr;		/* 0x188 */
> -	u32 rfcr;		/* 0x18C */
> -	u32 rlrfp;		/* 0x190 */
> -	u32 rlwfp;		/* 0x194 */
> -	u32 rfar;		/* 0x198 */
> -	u32 rfrp;		/* 0x19C */
> -	u32 rfwp;		/* 0x1A0 */
> -	u32 tfdr;		/* 0x1A4 */
> -	u32 tfsr;		/* 0x1A8 */
> -	u32 tfcr;		/* 0x1AC */
> -	u32 tlrfp;		/* 0x1B0 */
> -	u32 tlwfp;		/* 0x1B4 */
> -	u32 tfar;		/* 0x1B8 */
> -	u32 tfrp;		/* 0x1BC */
> -	u32 tfwp;		/* 0x1C0 */
> -	u32 frst;		/* 0x1C4 */
> -	u32 ctcwr;		/* 0x1C8 */
> -} fecdma_t;
> -
> -struct fec_info_dma {
> -	int index;
> -	u32 iobase;
> -	u32 pinmux;
> -	u32 miibase;
> -	int phy_addr;
> -	int dup_spd;
> -	char *phy_name;
> -	int phyname_init;
> -	cbd_t *rxbd;		/* Rx BD */
> -	cbd_t *txbd;		/* Tx BD */
> -	uint rx_idx;
> -	uint tx_idx;
> -	char *txbuf;
> -	int initialized;
> -	struct fec_info_dma *next;
> -	u16 rx_task;		/* DMA receive Task Number */
> -	u16 tx_task;		/* DMA Transmit Task Number */
> -	u16 rx_pri;		/* DMA Receive Priority */
> -	u16 tx_pri;		/* DMA Transmit Priority */
> -	u16 rx_init;		/* DMA Receive Initiator */
> -	u16 tx_init;		/* DMA Transmit Initiator */
> -	u16 used_tbd_idx;	/* next transmit BD to clean */
> -	u16 clean_tbd_num;	/* the number of available transmit BDs */
> -	int to_loop;
> -	struct mii_dev *bus;
> -};
> -
> -/* Bit definitions and macros for IEVENT */
> -#define FEC_EIR_TXERR		(0x00040000)
> -#define FEC_EIR_RXERR		(0x00020000)
> -#undef FEC_EIR_CLEAR_ALL
> -#define FEC_EIR_CLEAR_ALL	(0xFFFE0000)
> -
> -/* Bit definitions and macros for R_HASH */
> -#define FEC_RHASH_FCE_DC	(0x80000000)
> -#define FEC_RHASH_MULTCAST	(0x40000000)
> -#define FEC_RHASH_HASH(x)	(((x)&0x0000003F)<<24)
> -
> -/* Bit definitions and macros for FEC_TFWR */
> -#undef FEC_TFWR_X_WMRK
> -#undef FEC_TFWR_X_WMRK_64
> -#undef FEC_TFWR_X_WMRK_128
> -#undef FEC_TFWR_X_WMRK_192
> -
> -#define FEC_TFWR_X_WMRK(x)	((x)&0x0F)
> -#define FEC_TFWR_X_WMRK_64	(0x00)
> -#define FEC_TFWR_X_WMRK_128	(0x01)
> -#define FEC_TFWR_X_WMRK_192	(0x02)
> -#define FEC_TFWR_X_WMRK_256	(0x03)
> -#define FEC_TFWR_X_WMRK_320	(0x04)
> -#define FEC_TFWR_X_WMRK_384	(0x05)
> -#define FEC_TFWR_X_WMRK_448	(0x06)
> -#define FEC_TFWR_X_WMRK_512	(0x07)
> -#define FEC_TFWR_X_WMRK_576	(0x08)
> -#define FEC_TFWR_X_WMRK_640	(0x09)
> -#define FEC_TFWR_X_WMRK_704	(0x0A)
> -#define FEC_TFWR_X_WMRK_768	(0x0B)
> -#define FEC_TFWR_X_WMRK_832	(0x0C)
> -#define FEC_TFWR_X_WMRK_896	(0x0D)
> -#define FEC_TFWR_X_WMRK_960	(0x0E)
> -#define FEC_TFWR_X_WMRK_1024	(0x0F)
> -
> -/* FIFO definitions */
> -/* Bit definitions and macros for FSTAT */
> -#define FIFO_STAT_IP		(0x80000000)
> -#define FIFO_STAT_FRAME(x)	(((x)&0x0000000F)<<24)
> -#define FIFO_STAT_FAE		(0x00800000)
> -#define FIFO_STAT_RXW		(0x00400000)
> -#define FIFO_STAT_UF		(0x00200000)
> -#define FIFO_STAT_OF		(0x00100000)
> -#define FIFO_STAT_FR		(0x00080000)
> -#define FIFO_STAT_FULL		(0x00040000)
> -#define FIFO_STAT_ALARM		(0x00020000)
> -#define FIFO_STAT_EMPTY		(0x00010000)
> -
> -/* Bit definitions and macros for FCTRL */
> -#define FIFO_CTRL_WCTL		(0x40000000)
> -#define FIFO_CTRL_WFR		(0x20000000)
> -#define FIFO_CTRL_FRAME		(0x08000000)
> -#define FIFO_CTRL_GR(x)		(((x)&0x00000007)<<24)
> -#define FIFO_CTRL_IPMASK	(0x00800000)
> -#define FIFO_CTRL_FAEMASK	(0x00400000)
> -#define FIFO_CTRL_RXWMASK	(0x00200000)
> -#define FIFO_CTRL_UFMASK	(0x00100000)
> -#define FIFO_CTRL_OFMASK	(0x00080000)
> -
> -#endif				/* fsl_mcdmafec_h */
> diff --git a/arch/m68k/include/asm/immap.h b/arch/m68k/include/asm/immap.h
> index 411b00899c25..b118a9175428 100644
> --- a/arch/m68k/include/asm/immap.h
> +++ b/arch/m68k/include/asm/immap.h
> @@ -314,21 +314,6 @@
>   #include <asm/immap_547x_8x.h>
>   #include <asm/m547x_8x.h>
>   
> -#ifdef CONFIG_FSLDMAFEC
> -#define FEC0_RX_TASK		0
> -#define FEC0_TX_TASK		1
> -#define FEC0_RX_PRIORITY	6
> -#define FEC0_TX_PRIORITY	7
> -#define FEC0_RX_INIT		16
> -#define FEC0_TX_INIT		17
> -#define FEC1_RX_TASK		2
> -#define FEC1_TX_TASK		3
> -#define FEC1_RX_PRIORITY	6
> -#define FEC1_TX_PRIORITY	7
> -#define FEC1_RX_INIT		30
> -#define FEC1_TX_INIT		31
> -#endif
> -
>   #define CFG_SYS_UART_BASE		(MMAP_UART0 + (CFG_SYS_UART_PORT * 0x100))
>   
>   #ifdef CONFIG_SLTTMR
> diff --git a/arch/m68k/lib/fec.c b/arch/m68k/lib/fec.c
> index d6f238e4b347..ac36aec0ed78 100644
> --- a/arch/m68k/lib/fec.c
> +++ b/arch/m68k/lib/fec.c
> @@ -10,7 +10,7 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -#if defined(CONFIG_MCFFEC) || defined(CONFIG_FSLDMAFEC)
> +#if defined(CONFIG_MCFFEC)
>   static int fec_get_node(int fec_idx)
>   {
>   	char fec_alias[5] = {"fec"};
> @@ -77,4 +77,4 @@ int fec_get_mii_base(int fec_idx, u32 *mii_base)
>   	return fec_get_fdt_prop(fec_idx, "mii-base", mii_base);
>   }
>   
> -#endif //CONFIG_MCFFEC || CONFIG_FSLDMAFEC
> +#endif //CONFIG_MCFFEC
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 0af546042119..3c64e8946466 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -87,7 +87,6 @@ endif
>   
>   config DMA_LEGACY
>   	bool "Legacy DMA support"
> -	default y if FSLDMAFEC
>   	help
>   	  Enable legacy DMA support. This does not use driver model and should
>   	  be migrated to the new API.
> diff --git a/drivers/dma/MCD_dmaApi.c b/drivers/dma/MCD_dmaApi.c
> deleted file mode 100644
> index af0e13452200..000000000000
> --- a/drivers/dma/MCD_dmaApi.c
> +++ /dev/null
> @@ -1,1010 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> -/*Main C file for multi-channel DMA API. */
> -
> -#include <common.h>
> -
> -#include <MCD_dma.h>
> -#include <MCD_tasksInit.h>
> -#include <MCD_progCheck.h>
> -
> -/********************************************************************/
> -/* This is an API-internal pointer to the DMA's registers */
> -dmaRegs *MCD_dmaBar;
> -
> -/*
> - * These are the real and model task tables as generated by the
> - * build process
> - */
> -extern TaskTableEntry MCD_realTaskTableSrc[NCHANNELS];
> -extern TaskTableEntry MCD_modelTaskTableSrc[NUMOFVARIANTS];
> -
> -/*
> - * However, this (usually) gets relocated to on-chip SRAM, at which
> - * point we access them as these tables
> - */
> -volatile TaskTableEntry *MCD_taskTable;
> -TaskTableEntry *MCD_modelTaskTable;
> -
> -/*
> - * MCD_chStatus[] is an array of status indicators for remembering
> - * whether a DMA has ever been attempted on each channel, pausing
> - * status, etc.
> - */
> -static int MCD_chStatus[NCHANNELS] = {
> -	MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA,
> -	MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA,
> -	MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA,
> -	MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA, MCD_NO_DMA
> -};
> -
> -/* Prototypes for local functions */
> -static void MCD_memcpy(int *dest, int *src, u32 size);
> -static void MCD_resmActions(int channel);
> -
> -/*
> - * Buffer descriptors used for storage of progress info for single Dmas
> - * Also used as storage for the DMA for CRCs for single DMAs
> - * Otherwise, the DMA does not parse these buffer descriptors
> - */
> -#ifdef MCD_INCLUDE_EU
> -extern MCD_bufDesc MCD_singleBufDescs[NCHANNELS];
> -#else
> -MCD_bufDesc MCD_singleBufDescs[NCHANNELS];
> -#endif
> -MCD_bufDesc *MCD_relocBuffDesc;
> -
> -/* Defines for the debug control register's functions */
> -#define DBG_CTL_COMP1_TASK	(0x00002000)
> -#define DBG_CTL_ENABLE		(DBG_CTL_AUTO_ARM	| \
> -				 DBG_CTL_BREAK		| \
> -				 DBG_CTL_INT_BREAK	| \
> -				 DBG_CTL_COMP1_TASK)
> -#define DBG_CTL_DISABLE		(DBG_CTL_AUTO_ARM	| \
> -				 DBG_CTL_INT_BREAK	| \
> -				 DBG_CTL_COMP1_TASK)
> -#define DBG_KILL_ALL_STAT	(0xFFFFFFFF)
> -
> -/* Offset to context save area where progress info is stored */
> -#define CSAVE_OFFSET		10
> -
> -/* Defines for Byte Swapping */
> -#define MCD_BYTE_SWAP_KILLER	0xFFF8888F
> -#define MCD_NO_BYTE_SWAP_ATALL	0x00040000
> -
> -/* Execution Unit Identifiers */
> -#define MAC			0	/* legacy - not used */
> -#define LUAC			1	/* legacy - not used */
> -#define CRC			2	/* legacy - not used */
> -#define LURC			3	/* Logic Unit with CRC */
> -
> -/* Task Identifiers */
> -#define TASK_CHAINNOEU		0
> -#define TASK_SINGLENOEU		1
> -#ifdef MCD_INCLUDE_EU
> -#define TASK_CHAINEU		2
> -#define TASK_SINGLEEU		3
> -#define TASK_FECRX		4
> -#define TASK_FECTX		5
> -#else
> -#define TASK_CHAINEU		0
> -#define TASK_SINGLEEU		1
> -#define TASK_FECRX		2
> -#define TASK_FECTX		3
> -#endif
> -
> -/*
> - * Structure to remember which variant is on which channel
> - * TBD- need this?
> - */
> -typedef struct MCD_remVariants_struct MCD_remVariant;
> -struct MCD_remVariants_struct {
> -	int remDestRsdIncr[NCHANNELS];	/* -1,0,1 */
> -	int remSrcRsdIncr[NCHANNELS];	/* -1,0,1 */
> -	s16 remDestIncr[NCHANNELS];	/* DestIncr */
> -	s16 remSrcIncr[NCHANNELS];	/* srcIncr */
> -	u32 remXferSize[NCHANNELS];	/* xferSize */
> -};
> -
> -/* Structure to remember the startDma parameters for each channel */
> -MCD_remVariant MCD_remVariants;
> -/********************************************************************/
> -/* Function: MCD_initDma
> - * Purpose:  Initializes the DMA API by setting up a pointer to the DMA
> - *           registers, relocating and creating the appropriate task
> - *           structures, and setting up some global settings
> - * Arguments:
> - *  dmaBarAddr    - pointer to the multichannel DMA registers
> - *  taskTableDest - location to move DMA task code and structs to
> - *  flags         - operational parameters
> - * Return Value:
> - *  MCD_TABLE_UNALIGNED if taskTableDest is not 512-byte aligned
> - *  MCD_OK otherwise
> - */
> -extern u32 MCD_funcDescTab0[];
> -
> -int MCD_initDma(dmaRegs * dmaBarAddr, void *taskTableDest, u32 flags)
> -{
> -	int i;
> -	TaskTableEntry *entryPtr;
> -
> -	/* setup the local pointer to register set */
> -	MCD_dmaBar = dmaBarAddr;
> -
> -	/* do we need to move/create a task table */
> -	if ((flags & MCD_RELOC_TASKS) != 0) {
> -		int fixedSize;
> -		u32 *fixedPtr;
> -		/*int *tablePtr = taskTableDest;TBD */
> -		int varTabsOffset, funcDescTabsOffset, contextSavesOffset;
> -		int taskDescTabsOffset;
> -		int taskTableSize, varTabsSize, funcDescTabsSize,
> -		    contextSavesSize;
> -		int taskDescTabSize;
> -
> -		int i;
> -
> -		/* check if physical address is aligned on 512 byte boundary */
> -		if (((u32) taskTableDest & 0x000001ff) != 0)
> -			return (MCD_TABLE_UNALIGNED);
> -
> -		/* set up local pointer to task Table */
> -		MCD_taskTable = taskTableDest;
> -
> -		/*
> -		 * Create a task table:
> -		 * - compute aligned base offsets for variable tables and
> -		 *   function descriptor tables, then
> -		 * - loop through the task table and setup the pointers
> -		 * - copy over model task table with the the actual task
> -		 *   descriptor tables
> -		 */
> -
> -		taskTableSize = NCHANNELS * sizeof(TaskTableEntry);
> -		/* align variable tables to size */
> -		varTabsOffset = taskTableSize + (u32) taskTableDest;
> -		if ((varTabsOffset & (VAR_TAB_SIZE - 1)) != 0)
> -			varTabsOffset =
> -			    (varTabsOffset + VAR_TAB_SIZE) & (~VAR_TAB_SIZE);
> -		/* align function descriptor tables */
> -		varTabsSize = NCHANNELS * VAR_TAB_SIZE;
> -		funcDescTabsOffset = varTabsOffset + varTabsSize;
> -
> -		if ((funcDescTabsOffset & (FUNCDESC_TAB_SIZE - 1)) != 0)
> -			funcDescTabsOffset =
> -			    (funcDescTabsOffset +
> -			     FUNCDESC_TAB_SIZE) & (~FUNCDESC_TAB_SIZE);
> -
> -		funcDescTabsSize = FUNCDESC_TAB_NUM * FUNCDESC_TAB_SIZE;
> -		contextSavesOffset = funcDescTabsOffset + funcDescTabsSize;
> -		contextSavesSize = (NCHANNELS * CONTEXT_SAVE_SIZE);
> -		fixedSize =
> -		    taskTableSize + varTabsSize + funcDescTabsSize +
> -		    contextSavesSize;
> -
> -		/* zero the thing out */
> -		fixedPtr = (u32 *) taskTableDest;
> -		for (i = 0; i < (fixedSize / 4); i++)
> -			fixedPtr[i] = 0;
> -
> -		entryPtr = (TaskTableEntry *) MCD_taskTable;
> -		/* set up fixed pointers */
> -		for (i = 0; i < NCHANNELS; i++) {
> -			/* update ptr to local value */
> -			entryPtr[i].varTab = (u32) varTabsOffset;
> -			entryPtr[i].FDTandFlags =
> -			    (u32) funcDescTabsOffset | MCD_TT_FLAGS_DEF;
> -			entryPtr[i].contextSaveSpace = (u32) contextSavesOffset;
> -			varTabsOffset += VAR_TAB_SIZE;
> -#ifdef MCD_INCLUDE_EU
> -			/* if not there is only one, just point to the
> -			   same one */
> -			funcDescTabsOffset += FUNCDESC_TAB_SIZE;
> -#endif
> -			contextSavesOffset += CONTEXT_SAVE_SIZE;
> -		}
> -		/* copy over the function descriptor table */
> -		for (i = 0; i < FUNCDESC_TAB_NUM; i++) {
> -			MCD_memcpy((void *)(entryPtr[i].
> -					    FDTandFlags & ~MCD_TT_FLAGS_MASK),
> -				   (void *)MCD_funcDescTab0, FUNCDESC_TAB_SIZE);
> -		}
> -
> -		/* copy model task table to where the context saves stuff
> -		   leaves off */
> -		MCD_modelTaskTable = (TaskTableEntry *) contextSavesOffset;
> -
> -		MCD_memcpy((void *)MCD_modelTaskTable,
> -			   (void *)MCD_modelTaskTableSrc,
> -			   NUMOFVARIANTS * sizeof(TaskTableEntry));
> -
> -		/* point to local version of model task table */
> -		entryPtr = MCD_modelTaskTable;
> -		taskDescTabsOffset = (u32) MCD_modelTaskTable +
> -		    (NUMOFVARIANTS * sizeof(TaskTableEntry));
> -
> -		/* copy actual task code and update TDT ptrs in local
> -		   model task table */
> -		for (i = 0; i < NUMOFVARIANTS; i++) {
> -			taskDescTabSize =
> -			    entryPtr[i].TDTend - entryPtr[i].TDTstart + 4;
> -			MCD_memcpy((void *)taskDescTabsOffset,
> -				   (void *)entryPtr[i].TDTstart,
> -				   taskDescTabSize);
> -			entryPtr[i].TDTstart = (u32) taskDescTabsOffset;
> -			taskDescTabsOffset += taskDescTabSize;
> -			entryPtr[i].TDTend = (u32) taskDescTabsOffset - 4;
> -		}
> -#ifdef MCD_INCLUDE_EU
> -		/* Tack single DMA BDs onto end of code so API controls
> -		   where they are since DMA might write to them */
> -		MCD_relocBuffDesc =
> -		    (MCD_bufDesc *) (entryPtr[NUMOFVARIANTS - 1].TDTend + 4);
> -#else
> -		/* DMA does not touch them so they can be wherever and we
> -		   don't need to waste SRAM on them */
> -		MCD_relocBuffDesc = MCD_singleBufDescs;
> -#endif
> -	} else {
> -		/* point the would-be relocated task tables and the
> -		   buffer descriptors to the ones the linker generated */
> -
> -		if (((u32) MCD_realTaskTableSrc & 0x000001ff) != 0)
> -			return (MCD_TABLE_UNALIGNED);
> -
> -		/* need to add code to make sure that every thing else is
> -		   aligned properly TBD. this is problematic if we init
> -		   more than once or after running tasks, need to add
> -		   variable to see if we have aleady init'd */
> -		entryPtr = MCD_realTaskTableSrc;
> -		for (i = 0; i < NCHANNELS; i++) {
> -			if (((entryPtr[i].varTab & (VAR_TAB_SIZE - 1)) != 0) ||
> -			    ((entryPtr[i].
> -			      FDTandFlags & (FUNCDESC_TAB_SIZE - 1)) != 0))
> -				return (MCD_TABLE_UNALIGNED);
> -		}
> -
> -		MCD_taskTable = MCD_realTaskTableSrc;
> -		MCD_modelTaskTable = MCD_modelTaskTableSrc;
> -		MCD_relocBuffDesc = MCD_singleBufDescs;
> -	}
> -
> -	/* Make all channels as totally inactive, and remember them as such: */
> -
> -	MCD_dmaBar->taskbar = (u32) MCD_taskTable;
> -	for (i = 0; i < NCHANNELS; i++) {
> -		MCD_dmaBar->taskControl[i] = 0x0;
> -		MCD_chStatus[i] = MCD_NO_DMA;
> -	}
> -
> -	/* Set up pausing mechanism to inactive state: */
> -	/* no particular values yet for either comparator registers */
> -	MCD_dmaBar->debugComp1 = 0;
> -	MCD_dmaBar->debugComp2 = 0;
> -	MCD_dmaBar->debugControl = DBG_CTL_DISABLE;
> -	MCD_dmaBar->debugStatus = DBG_KILL_ALL_STAT;
> -
> -	/* enable or disable commbus prefetch, really need an ifdef or
> -	   something to keep from trying to set this in the 8220 */
> -	if ((flags & MCD_COMM_PREFETCH_EN) != 0)
> -		MCD_dmaBar->ptdControl &= ~PTD_CTL_COMM_PREFETCH;
> -	else
> -		MCD_dmaBar->ptdControl |= PTD_CTL_COMM_PREFETCH;
> -
> -	return (MCD_OK);
> -}
> -
> -/*********************** End of MCD_initDma() ***********************/
> -
> -/********************************************************************/
> -/* Function:   MCD_dmaStatus
> - * Purpose:    Returns the status of the DMA on the requested channel
> - * Arguments:  channel - channel number
> - * Returns:    Predefined status indicators
> - */
> -int MCD_dmaStatus(int channel)
> -{
> -	u16 tcrValue;
> -
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	tcrValue = MCD_dmaBar->taskControl[channel];
> -	if ((tcrValue & TASK_CTL_EN) == 0) {	/* nothing running */
> -		/* if last reported with task enabled */
> -		if (MCD_chStatus[channel] == MCD_RUNNING
> -		    || MCD_chStatus[channel] == MCD_IDLE)
> -			MCD_chStatus[channel] = MCD_DONE;
> -	} else {		/* something is running */
> -
> -		/* There are three possibilities: paused, running or idle. */
> -		if (MCD_chStatus[channel] == MCD_RUNNING
> -		    || MCD_chStatus[channel] == MCD_IDLE) {
> -			MCD_dmaBar->ptdDebug = PTD_DBG_TSK_VLD_INIT;
> -			/* This register is selected to know which initiator is
> -			   actually asserted. */
> -			if ((MCD_dmaBar->ptdDebug >> channel) & 0x1)
> -				MCD_chStatus[channel] = MCD_RUNNING;
> -			else
> -				MCD_chStatus[channel] = MCD_IDLE;
> -			/* do not change the status if it is already paused. */
> -		}
> -	}
> -	return MCD_chStatus[channel];
> -}
> -
> -/******************** End of MCD_dmaStatus() ************************/
> -
> -/********************************************************************/
> -/* Function:    MCD_startDma
> - * Ppurpose:    Starts a particular kind of DMA
> - * Arguments:
> - * srcAddr	- the channel on which to run the DMA
> - * srcIncr	- the address to move data from, or buffer-descriptor address
> - * destAddr	- the amount to increment the source address per transfer
> - * destIncr	- the address to move data to
> - * dmaSize	- the amount to increment the destination address per transfer
> - * xferSize	- the number bytes in of each data movement (1, 2, or 4)
> - * initiator	- what device initiates the DMA
> - * priority	- priority of the DMA
> - * flags	- flags describing the DMA
> - * funcDesc	- description of byte swapping, bit swapping, and CRC actions
> - * srcAddrVirt	- virtual buffer descriptor address TBD
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - */
> -
> -int MCD_startDma(int channel, s8 * srcAddr, s16 srcIncr, s8 * destAddr,
> -		 s16 destIncr, u32 dmaSize, u32 xferSize, u32 initiator,
> -		 int priority, u32 flags, u32 funcDesc
> -#ifdef MCD_NEED_ADDR_TRANS
> -		 s8 * srcAddrVirt
> -#endif
> -    )
> -{
> -	int srcRsdIncr, destRsdIncr;
> -	int *cSave;
> -	short xferSizeIncr;
> -	int tcrCount = 0;
> -#ifdef MCD_INCLUDE_EU
> -	u32 *realFuncArray;
> -#endif
> -
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	/* tbd - need to determine the proper response to a bad funcDesc when
> -	   not including EU functions, for now, assign a benign funcDesc, but
> -	   maybe should return an error */
> -#ifndef MCD_INCLUDE_EU
> -	funcDesc = MCD_FUNC_NOEU1;
> -#endif
> -
> -#ifdef MCD_DEBUG
> -	printf("startDma:Setting up params\n");
> -#endif
> -	/* Set us up for task-wise priority.  We don't technically need to do
> -	   this on every start, but since the register involved is in the same
> -	   longword as other registers that users are in control of, setting
> -	   it more than once is probably preferable.  That since the
> -	   documentation doesn't seem to be completely consistent about the
> -	   nature of the PTD control register. */
> -	MCD_dmaBar->ptdControl |= (u16) 0x8000;
> -
> -	/* Not sure what we need to keep here rtm TBD */
> -#if 1
> -	/* Calculate additional parameters to the regular DMA calls. */
> -	srcRsdIncr = srcIncr < 0 ? -1 : (srcIncr > 0 ? 1 : 0);
> -	destRsdIncr = destIncr < 0 ? -1 : (destIncr > 0 ? 1 : 0);
> -
> -	xferSizeIncr = (xferSize & 0xffff) | 0x20000000;
> -
> -	/* Remember for each channel which variant is running. */
> -	MCD_remVariants.remSrcRsdIncr[channel] = srcRsdIncr;
> -	MCD_remVariants.remDestRsdIncr[channel] = destRsdIncr;
> -	MCD_remVariants.remDestIncr[channel] = destIncr;
> -	MCD_remVariants.remSrcIncr[channel] = srcIncr;
> -	MCD_remVariants.remXferSize[channel] = xferSize;
> -#endif
> -
> -	cSave =
> -	    (int *)(MCD_taskTable[channel].contextSaveSpace) + CSAVE_OFFSET +
> -	    CURRBD;
> -
> -#ifdef MCD_INCLUDE_EU
> -	/* may move this to EU specific calls */
> -	realFuncArray =
> -	    (u32 *) (MCD_taskTable[channel].FDTandFlags & 0xffffff00);
> -	/* Modify the LURC's normal and byte-residue-loop functions according
> -	   to parameter. */
> -	realFuncArray[(LURC * 16)] = xferSize == 4 ?
> -	    funcDesc : xferSize == 2 ?
> -	    funcDesc & 0xfffff00f : funcDesc & 0xffff000f;
> -	realFuncArray[(LURC * 16 + 1)] =
> -	    (funcDesc & MCD_BYTE_SWAP_KILLER) | MCD_NO_BYTE_SWAP_ATALL;
> -#endif
> -	/* Write the initiator field in the TCR, and also set the
> -	   initiator-hold bit. Note that,due to a hardware quirk, this could
> -	   collide with an MDE access to the initiator-register file, so we
> -	   have to verify that the write reads back correctly. */
> -
> -	MCD_dmaBar->taskControl[channel] =
> -	    (initiator << 8) | TASK_CTL_HIPRITSKEN | TASK_CTL_HLDINITNUM;
> -
> -	while (((MCD_dmaBar->taskControl[channel] & 0x1fff) !=
> -		((initiator << 8) | TASK_CTL_HIPRITSKEN | TASK_CTL_HLDINITNUM))
> -	       && (tcrCount < 1000)) {
> -		tcrCount++;
> -		/*MCD_dmaBar->ptd_tcr[channel] = (initiator << 8) | 0x0020; */
> -		MCD_dmaBar->taskControl[channel] =
> -		    (initiator << 8) | TASK_CTL_HIPRITSKEN |
> -		    TASK_CTL_HLDINITNUM;
> -	}
> -
> -	MCD_dmaBar->priority[channel] = (u8) priority & PRIORITY_PRI_MASK;
> -	/* should be albe to handle this stuff with only one write to ts reg
> -	   - tbd */
> -	if (channel < 8 && channel >= 0) {
> -		MCD_dmaBar->taskSize0 &= ~(0xf << (7 - channel) * 4);
> -		MCD_dmaBar->taskSize0 |=
> -		    (xferSize & 3) << (((7 - channel) * 4) + 2);
> -		MCD_dmaBar->taskSize0 |= (xferSize & 3) << ((7 - channel) * 4);
> -	} else {
> -		MCD_dmaBar->taskSize1 &= ~(0xf << (15 - channel) * 4);
> -		MCD_dmaBar->taskSize1 |=
> -		    (xferSize & 3) << (((15 - channel) * 4) + 2);
> -		MCD_dmaBar->taskSize1 |= (xferSize & 3) << ((15 - channel) * 4);
> -	}
> -
> -	/* setup task table flags/options which mostly control the line
> -	   buffers */
> -	MCD_taskTable[channel].FDTandFlags &= ~MCD_TT_FLAGS_MASK;
> -	MCD_taskTable[channel].FDTandFlags |= (MCD_TT_FLAGS_MASK & flags);
> -
> -	if (flags & MCD_FECTX_DMA) {
> -		/* TDTStart and TDTEnd */
> -		MCD_taskTable[channel].TDTstart =
> -		    MCD_modelTaskTable[TASK_FECTX].TDTstart;
> -		MCD_taskTable[channel].TDTend =
> -		    MCD_modelTaskTable[TASK_FECTX].TDTend;
> -		MCD_startDmaENetXmit((char *)srcAddr, (char *)srcAddr,
> -				     (char *)destAddr, MCD_taskTable,
> -				     channel);
> -	} else if (flags & MCD_FECRX_DMA) {
> -		/* TDTStart and TDTEnd */
> -		MCD_taskTable[channel].TDTstart =
> -		    MCD_modelTaskTable[TASK_FECRX].TDTstart;
> -		MCD_taskTable[channel].TDTend =
> -		    MCD_modelTaskTable[TASK_FECRX].TDTend;
> -		MCD_startDmaENetRcv((char *)srcAddr, (char *)srcAddr,
> -				    (char *)destAddr, MCD_taskTable,
> -				    channel);
> -	} else if (flags & MCD_SINGLE_DMA) {
> -		/* this buffer descriptor is used for storing off initial
> -		   parameters for later progress query calculation and for the
> -		   DMA to write the resulting checksum. The DMA does not use
> -		   this to determine how to operate, that info is passed with
> -		   the init routine */
> -		MCD_relocBuffDesc[channel].srcAddr = srcAddr;
> -		MCD_relocBuffDesc[channel].destAddr = destAddr;
> -
> -		/* definitely not its final value */
> -		MCD_relocBuffDesc[channel].lastDestAddr = destAddr;
> -
> -		MCD_relocBuffDesc[channel].dmaSize = dmaSize;
> -		MCD_relocBuffDesc[channel].flags = 0;	/* not used */
> -		MCD_relocBuffDesc[channel].csumResult = 0;	/* not used */
> -		MCD_relocBuffDesc[channel].next = 0;	/* not used */
> -
> -		/* Initialize the progress-querying stuff to show no
> -		   progress: */
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[SRCPTR + CSAVE_OFFSET] = (int)srcAddr;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[DESTPTR + CSAVE_OFFSET] = (int)destAddr;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[DCOUNT + CSAVE_OFFSET] = 0;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[CURRBD + CSAVE_OFFSET] =
> -(u32) & (MCD_relocBuffDesc[channel]);
> -		/* tbd - need to keep the user from trying to call the EU
> -		   routine when MCD_INCLUDE_EU is not defined */
> -		if (funcDesc == MCD_FUNC_NOEU1 || funcDesc == MCD_FUNC_NOEU2) {
> -			/* TDTStart and TDTEnd */
> -			MCD_taskTable[channel].TDTstart =
> -			    MCD_modelTaskTable[TASK_SINGLENOEU].TDTstart;
> -			MCD_taskTable[channel].TDTend =
> -			    MCD_modelTaskTable[TASK_SINGLENOEU].TDTend;
> -			MCD_startDmaSingleNoEu((char *)srcAddr, srcIncr,
> -					       (char *)destAddr, destIncr,
> -					       (int)dmaSize, xferSizeIncr,
> -					       flags, (int *)
> -					       &(MCD_relocBuffDesc[channel]),
> -					       cSave, MCD_taskTable, channel);
> -		} else {
> -			/* TDTStart and TDTEnd */
> -			MCD_taskTable[channel].TDTstart =
> -			    MCD_modelTaskTable[TASK_SINGLEEU].TDTstart;
> -			MCD_taskTable[channel].TDTend =
> -			    MCD_modelTaskTable[TASK_SINGLEEU].TDTend;
> -			MCD_startDmaSingleEu((char *)srcAddr, srcIncr,
> -					     (char *)destAddr, destIncr,
> -					     (int)dmaSize, xferSizeIncr,
> -					     flags, (int *)
> -					     &(MCD_relocBuffDesc[channel]),
> -					     cSave, MCD_taskTable, channel);
> -		}
> -	} else {		/* chained DMAS */
> -		/* Initialize the progress-querying stuff to show no
> -		   progress: */
> -#if 1
> -		/* (!defined(MCD_NEED_ADDR_TRANS)) */
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[SRCPTR + CSAVE_OFFSET]
> -		    = (int)((MCD_bufDesc *) srcAddr)->srcAddr;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[DESTPTR + CSAVE_OFFSET]
> -		    = (int)((MCD_bufDesc *) srcAddr)->destAddr;
> -#else
> -		/* if using address translation, need the virtual addr of the
> -		   first buffdesc */
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[SRCPTR + CSAVE_OFFSET]
> -		    = (int)((MCD_bufDesc *) srcAddrVirt)->srcAddr;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[DESTPTR + CSAVE_OFFSET]
> -		    = (int)((MCD_bufDesc *) srcAddrVirt)->destAddr;
> -#endif
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[DCOUNT + CSAVE_OFFSET] = 0;
> -		((volatile int *)MCD_taskTable[channel].
> -		 contextSaveSpace)[CURRBD + CSAVE_OFFSET] = (u32) srcAddr;
> -
> -		if (funcDesc == MCD_FUNC_NOEU1 || funcDesc == MCD_FUNC_NOEU2) {
> -			/*TDTStart and TDTEnd */
> -			MCD_taskTable[channel].TDTstart =
> -			    MCD_modelTaskTable[TASK_CHAINNOEU].TDTstart;
> -			MCD_taskTable[channel].TDTend =
> -			    MCD_modelTaskTable[TASK_CHAINNOEU].TDTend;
> -			MCD_startDmaChainNoEu((int *)srcAddr, srcIncr,
> -					      destIncr, xferSize,
> -					      xferSizeIncr, cSave,
> -					      MCD_taskTable, channel);
> -		} else {
> -			/*TDTStart and TDTEnd */
> -			MCD_taskTable[channel].TDTstart =
> -			    MCD_modelTaskTable[TASK_CHAINEU].TDTstart;
> -			MCD_taskTable[channel].TDTend =
> -			    MCD_modelTaskTable[TASK_CHAINEU].TDTend;
> -			MCD_startDmaChainEu((int *)srcAddr, srcIncr, destIncr,
> -					    xferSize, xferSizeIncr, cSave,
> -					    MCD_taskTable, channel);
> -		}
> -	}
> -	MCD_chStatus[channel] = MCD_IDLE;
> -	return (MCD_OK);
> -}
> -
> -/************************ End of MCD_startDma() *********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_XferProgrQuery
> - * Purpose:     Returns progress of DMA on requested channel
> - * Arguments:   channel - channel to retrieve progress for
> - *              progRep - pointer to user supplied MCD_XferProg struct
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - *
> - * Notes:
> - *  MCD_XferProgrQuery() upon completing or after aborting a DMA, or
> - *  while the DMA is in progress, this function returns the first
> - *  DMA-destination address not (or not yet) used in the DMA. When
> - *  encountering a non-ready buffer descriptor, the information for
> - *  the last completed descriptor is returned.
> - *
> - *  MCD_XferProgQuery() has to avoid the possibility of getting
> - *  partially-updated information in the event that we should happen
> - *  to query DMA progress just as the DMA is updating it. It does that
> - *  by taking advantage of the fact context is not saved frequently for
> - *  the most part. We therefore read it at least twice until we get the
> - *  same information twice in a row.
> - *
> - *  Because a small, but not insignificant, amount of time is required
> - *  to write out the progress-query information, especially upon
> - *  completion of the DMA, it would be wise to guarantee some time lag
> - *  between successive readings of the progress-query information.
> - */
> -
> -/* How many iterations of the loop below to execute to stabilize values */
> -#define STABTIME 0
> -
> -int MCD_XferProgrQuery(int channel, MCD_XferProg * progRep)
> -{
> -	MCD_XferProg prevRep;
> -	int again;		/* true if we are to try again to ge
> -				   consistent results */
> -	int i;			/* used as a time-waste counter */
> -	int destDiffBytes;	/* Total no of bytes that we think actually
> -				   got xfered. */
> -	int numIterations;	/* number of iterations */
> -	int bytesNotXfered;	/* bytes that did not get xfered. */
> -	s8 *LWAlignedInitDestAddr, *LWAlignedCurrDestAddr;
> -	int subModVal, addModVal;	/* Mode values to added and subtracted
> -					   from the final destAddr */
> -
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	/* Read a trial value for the progress-reporting values */
> -	prevRep.lastSrcAddr =
> -	    (s8 *) ((volatile int *)MCD_taskTable[channel].
> -		    contextSaveSpace)[SRCPTR + CSAVE_OFFSET];
> -	prevRep.lastDestAddr =
> -	    (s8 *) ((volatile int *)MCD_taskTable[channel].
> -		    contextSaveSpace)[DESTPTR + CSAVE_OFFSET];
> -	prevRep.dmaSize =
> -	    ((volatile int *)MCD_taskTable[channel].contextSaveSpace)[DCOUNT +
> -								      CSAVE_OFFSET];
> -	prevRep.currBufDesc =
> -	    (MCD_bufDesc *) ((volatile int *)MCD_taskTable[channel].
> -			     contextSaveSpace)[CURRBD + CSAVE_OFFSET];
> -	/* Repeatedly reread those values until they match previous values: */
> -	do {
> -		/* Waste a little bit of time to ensure stability: */
> -		for (i = 0; i < STABTIME; i++) {
> -			/* make sure this loop does something so that it
> -			   doesn't get optimized out */
> -			i += i >> 2;
> -		}
> -		/* Check them again: */
> -		progRep->lastSrcAddr =
> -		    (s8 *) ((volatile int *)MCD_taskTable[channel].
> -			    contextSaveSpace)[SRCPTR + CSAVE_OFFSET];
> -		progRep->lastDestAddr =
> -		    (s8 *) ((volatile int *)MCD_taskTable[channel].
> -			    contextSaveSpace)[DESTPTR + CSAVE_OFFSET];
> -		progRep->dmaSize =
> -		    ((volatile int *)MCD_taskTable[channel].
> -		     contextSaveSpace)[DCOUNT + CSAVE_OFFSET];
> -		progRep->currBufDesc =
> -		    (MCD_bufDesc *) ((volatile int *)MCD_taskTable[channel].
> -				     contextSaveSpace)[CURRBD + CSAVE_OFFSET];
> -		/* See if they match: */
> -		if (prevRep.lastSrcAddr != progRep->lastSrcAddr
> -		    || prevRep.lastDestAddr != progRep->lastDestAddr
> -		    || prevRep.dmaSize != progRep->dmaSize
> -		    || prevRep.currBufDesc != progRep->currBufDesc) {
> -			/* If they don't match, remember previous values and
> -			   try again: */
> -			prevRep.lastSrcAddr = progRep->lastSrcAddr;
> -			prevRep.lastDestAddr = progRep->lastDestAddr;
> -			prevRep.dmaSize = progRep->dmaSize;
> -			prevRep.currBufDesc = progRep->currBufDesc;
> -			again = MCD_TRUE;
> -		} else
> -			again = MCD_FALSE;
> -	} while (again == MCD_TRUE);
> -
> -	/* Update the dCount, srcAddr and destAddr */
> -	/* To calculate dmaCount, we consider destination address. C
> -	   overs M1,P1,Z for destination */
> -	switch (MCD_remVariants.remDestRsdIncr[channel]) {
> -	case MINUS1:
> -		subModVal =
> -		    ((int)progRep->
> -		     lastDestAddr) & ((MCD_remVariants.remXferSize[channel]) -
> -				      1);
> -		addModVal =
> -		    ((int)progRep->currBufDesc->
> -		     destAddr) & ((MCD_remVariants.remXferSize[channel]) - 1);
> -		LWAlignedInitDestAddr =
> -		    (progRep->currBufDesc->destAddr) - addModVal;
> -		LWAlignedCurrDestAddr = (progRep->lastDestAddr) - subModVal;
> -		destDiffBytes = LWAlignedInitDestAddr - LWAlignedCurrDestAddr;
> -		bytesNotXfered =
> -		    (destDiffBytes / MCD_remVariants.remDestIncr[channel]) *
> -		    (MCD_remVariants.remDestIncr[channel]
> -		     + MCD_remVariants.remXferSize[channel]);
> -		progRep->dmaSize =
> -		    destDiffBytes - bytesNotXfered + addModVal - subModVal;
> -		break;
> -	case ZERO:
> -		progRep->lastDestAddr = progRep->currBufDesc->destAddr;
> -		break;
> -	case PLUS1:
> -		/* This value has to be subtracted from the final
> -		   calculated dCount. */
> -		subModVal =
> -		    ((int)progRep->currBufDesc->
> -		     destAddr) & ((MCD_remVariants.remXferSize[channel]) - 1);
> -		/* These bytes are already in lastDestAddr. */
> -		addModVal =
> -		    ((int)progRep->
> -		     lastDestAddr) & ((MCD_remVariants.remXferSize[channel]) -
> -				      1);
> -		LWAlignedInitDestAddr =
> -		    (progRep->currBufDesc->destAddr) - subModVal;
> -		LWAlignedCurrDestAddr = (progRep->lastDestAddr) - addModVal;
> -		destDiffBytes = (progRep->lastDestAddr - LWAlignedInitDestAddr);
> -		numIterations =
> -		    (LWAlignedCurrDestAddr -
> -		     LWAlignedInitDestAddr) /
> -		    MCD_remVariants.remDestIncr[channel];
> -		bytesNotXfered =
> -		    numIterations * (MCD_remVariants.remDestIncr[channel]
> -				     - MCD_remVariants.remXferSize[channel]);
> -		progRep->dmaSize = destDiffBytes - bytesNotXfered - subModVal;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	/* This covers M1,P1,Z for source */
> -	switch (MCD_remVariants.remSrcRsdIncr[channel]) {
> -	case MINUS1:
> -		progRep->lastSrcAddr =
> -		    progRep->currBufDesc->srcAddr +
> -		    (MCD_remVariants.remSrcIncr[channel] *
> -		     (progRep->dmaSize / MCD_remVariants.remXferSize[channel]));
> -		break;
> -	case ZERO:
> -		progRep->lastSrcAddr = progRep->currBufDesc->srcAddr;
> -		break;
> -	case PLUS1:
> -		progRep->lastSrcAddr =
> -		    progRep->currBufDesc->srcAddr +
> -		    (MCD_remVariants.remSrcIncr[channel] *
> -		     (progRep->dmaSize / MCD_remVariants.remXferSize[channel]));
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return (MCD_OK);
> -}
> -
> -/******************* End of MCD_XferProgrQuery() ********************/
> -
> -/********************************************************************/
> -/* MCD_resmActions() does the majority of the actions of a DMA resume.
> - * It is called from MCD_killDma() and MCD_resumeDma().  It has to be
> - * a separate function because the kill function has to negate the task
> - * enable before resuming it, but the resume function has to do nothing
> - * if there is no DMA on that channel (i.e., if the enable bit is 0).
> - */
> -static void MCD_resmActions(int channel)
> -{
> -	MCD_dmaBar->debugControl = DBG_CTL_DISABLE;
> -	MCD_dmaBar->debugStatus = MCD_dmaBar->debugStatus;
> -	/* This register is selected to know which initiator is
> -	   actually asserted. */
> -	MCD_dmaBar->ptdDebug = PTD_DBG_TSK_VLD_INIT;
> -
> -	if ((MCD_dmaBar->ptdDebug >> channel) & 0x1)
> -		MCD_chStatus[channel] = MCD_RUNNING;
> -	else
> -		MCD_chStatus[channel] = MCD_IDLE;
> -}
> -
> -/********************* End of MCD_resmActions() *********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_killDma
> - * Purpose:     Halt the DMA on the requested channel, without any
> - *              intention of resuming the DMA.
> - * Arguments:   channel - requested channel
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - *
> - * Notes:
> - *  A DMA may be killed from any state, including paused state, and it
> - *  always goes to the MCD_HALTED state even if it is killed while in
> - *  the MCD_NO_DMA or MCD_IDLE states.
> - */
> -int MCD_killDma(int channel)
> -{
> -	/* MCD_XferProg progRep; */
> -
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	MCD_dmaBar->taskControl[channel] = 0x0;
> -	MCD_resumeDma(channel);
> -	/*
> -	 * This must be after the write to the TCR so that the task doesn't
> -	 * start up again momentarily, and before the status assignment so
> -	 * as to override whatever MCD_resumeDma() may do to the channel
> -	 * status.
> -	 */
> -	MCD_chStatus[channel] = MCD_HALTED;
> -
> -	/*
> -	 * Update the current buffer descriptor's lastDestAddr field
> -	 *
> -	 * MCD_XferProgrQuery (channel, &progRep);
> -	 * progRep.currBufDesc->lastDestAddr = progRep.lastDestAddr;
> -	 */
> -	return (MCD_OK);
> -}
> -
> -/************************ End of MCD_killDma() **********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_continDma
> - * Purpose:     Continue a DMA which as stopped due to encountering an
> - *              unready buffer descriptor.
> - * Arguments:   channel - channel to continue the DMA on
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - *
> - * Notes:
> - *  This routine does not check to see if there is a task which can
> - *  be continued. Also this routine should not be used with single DMAs.
> - */
> -int MCD_continDma(int channel)
> -{
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	MCD_dmaBar->taskControl[channel] |= TASK_CTL_EN;
> -	MCD_chStatus[channel] = MCD_RUNNING;
> -
> -	return (MCD_OK);
> -}
> -
> -/********************** End of MCD_continDma() **********************/
> -
> -/*********************************************************************
> - * MCD_pauseDma() and MCD_resumeDma() below use the DMA's debug unit
> - * to freeze a task and resume it.  We freeze a task by breakpointing
> - * on the stated task.  That is, not any specific place in the task,
> - * but any time that task executes.  In particular, when that task
> - * executes, we want to freeze that task and only that task.
> - *
> - * The bits of the debug control register influence interrupts vs.
> - * breakpoints as follows:
> - * - Bits 14 and 0 enable or disable debug functions.  If enabled, you
> - *   will get the interrupt but you may or may not get a breakpoint.
> - * - Bits 2 and 1 decide whether you also get a breakpoint in addition
> - *   to an interrupt.
> - *
> - * The debug unit can do these actions in response to either internally
> - * detected breakpoint conditions from the comparators, or in response
> - * to the external breakpoint pin, or both.
> - * - Bits 14 and 1 perform the above-described functions for
> - *   internally-generated conditions, i.e., the debug comparators.
> - * - Bits 0 and 2 perform the above-described functions for external
> - *   conditions, i.e., the breakpoint external pin.
> - *
> - * Note that, although you "always" get the interrupt when you turn
> - * the debug functions, the interrupt can nevertheless, if desired, be
> - * masked by the corresponding bit in the PTD's IMR. Note also that
> - * this means that bits 14 and 0 must enable debug functions before
> - * bits 1 and 2, respectively, have any effect.
> - *
> - * NOTE: It's extremely important to not pause more than one DMA channel
> - *  at a time.
> - ********************************************************************/
> -
> -/********************************************************************/
> -/* Function:    MCD_pauseDma
> - * Purpose:     Pauses the DMA on a given channel (if any DMA is running
> - *              on that channel).
> - * Arguments:   channel
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - */
> -int MCD_pauseDma(int channel)
> -{
> -	/* MCD_XferProg progRep; */
> -
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	if (MCD_dmaBar->taskControl[channel] & TASK_CTL_EN) {
> -		MCD_dmaBar->debugComp1 = channel;
> -		MCD_dmaBar->debugControl =
> -		    DBG_CTL_ENABLE | (1 << (channel + 16));
> -		MCD_chStatus[channel] = MCD_PAUSED;
> -
> -		/*
> -		 * Update the current buffer descriptor's lastDestAddr field
> -		 *
> -		 * MCD_XferProgrQuery (channel, &progRep);
> -		 * progRep.currBufDesc->lastDestAddr = progRep.lastDestAddr;
> -		 */
> -	}
> -	return (MCD_OK);
> -}
> -
> -/************************* End of MCD_pauseDma() ********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_resumeDma
> - * Purpose:     Resumes the DMA on a given channel (if any DMA is
> - *              running on that channel).
> - * Arguments:   channel - channel on which to resume DMA
> - * Returns:     MCD_CHANNEL_INVALID if channel is invalid, else MCD_OK
> - */
> -int MCD_resumeDma(int channel)
> -{
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	if (MCD_dmaBar->taskControl[channel] & TASK_CTL_EN)
> -		MCD_resmActions(channel);
> -
> -	return (MCD_OK);
> -}
> -
> -/************************ End of MCD_resumeDma() ********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_csumQuery
> - * Purpose:     Provide the checksum after performing a non-chained DMA
> - * Arguments:   channel - channel to report on
> - *              csum - pointer to where to write the checksum/CRC
> - * Returns:     MCD_ERROR if the channel is invalid, else MCD_OK
> - *
> - * Notes:
> - *
> - */
> -int MCD_csumQuery(int channel, u32 * csum)
> -{
> -#ifdef MCD_INCLUDE_EU
> -	if ((channel < 0) || (channel >= NCHANNELS))
> -		return (MCD_CHANNEL_INVALID);
> -
> -	*csum = MCD_relocBuffDesc[channel].csumResult;
> -	return (MCD_OK);
> -#else
> -	return (MCD_ERROR);
> -#endif
> -}
> -
> -/*********************** End of MCD_resumeDma() *********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_getCodeSize
> - * Purpose:     Provide the size requirements of the microcoded tasks
> - * Returns:     Size in bytes
> - */
> -int MCD_getCodeSize(void)
> -{
> -#ifdef MCD_INCLUDE_EU
> -	return (0x2b5c);
> -#else
> -	return (0x173c);
> -#endif
> -}
> -
> -/********************** End of MCD_getCodeSize() ********************/
> -
> -/********************************************************************/
> -/* Function:    MCD_getVersion
> - * Purpose:     Provide the version string and number
> - * Arguments:   longVersion - user supplied pointer to a pointer to a char
> - *                    which points to the version string
> - * Returns:     Version number and version string (by reference)
> - */
> -char MCD_versionString[] = "Multi-channel DMA API Alpha v0.3 (2004-04-26)";
> -#define MCD_REV_MAJOR   0x00
> -#define MCD_REV_MINOR   0x03
> -
> -int MCD_getVersion(char **longVersion)
> -{
> -	*longVersion = MCD_versionString;
> -	return ((MCD_REV_MAJOR << 8) | MCD_REV_MINOR);
> -}
> -
> -/********************** End of MCD_getVersion() *********************/
> -
> -/********************************************************************/
> -/* Private version of memcpy()
> - * Note that everything this is used for is longword-aligned.
> - */
> -static void MCD_memcpy(int *dest, int *src, u32 size)
> -{
> -	u32 i;
> -
> -	for (i = 0; i < size; i += sizeof(int), dest++, src++)
> -		*dest = *src;
> -}
> diff --git a/drivers/dma/MCD_tasks.c b/drivers/dma/MCD_tasks.c
> deleted file mode 100644
> index 453d95413da8..000000000000
> --- a/drivers/dma/MCD_tasks.c
> +++ /dev/null
> @@ -1,2413 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> -/* Contains task code and structures for Multi-channel DMA */
> -
> -#include <common.h>
> -
> -#include <MCD_dma.h>
> -
> -u32 MCD_varTab0[];
> -u32 MCD_varTab1[];
> -u32 MCD_varTab2[];
> -u32 MCD_varTab3[];
> -u32 MCD_varTab4[];
> -u32 MCD_varTab5[];
> -u32 MCD_varTab6[];
> -u32 MCD_varTab7[];
> -u32 MCD_varTab8[];
> -u32 MCD_varTab9[];
> -u32 MCD_varTab10[];
> -u32 MCD_varTab11[];
> -u32 MCD_varTab12[];
> -u32 MCD_varTab13[];
> -u32 MCD_varTab14[];
> -u32 MCD_varTab15[];
> -
> -u32 MCD_funcDescTab0[];
> -#ifdef MCD_INCLUDE_EU
> -u32 MCD_funcDescTab1[];
> -u32 MCD_funcDescTab2[];
> -u32 MCD_funcDescTab3[];
> -u32 MCD_funcDescTab4[];
> -u32 MCD_funcDescTab5[];
> -u32 MCD_funcDescTab6[];
> -u32 MCD_funcDescTab7[];
> -u32 MCD_funcDescTab8[];
> -u32 MCD_funcDescTab9[];
> -u32 MCD_funcDescTab10[];
> -u32 MCD_funcDescTab11[];
> -u32 MCD_funcDescTab12[];
> -u32 MCD_funcDescTab13[];
> -u32 MCD_funcDescTab14[];
> -u32 MCD_funcDescTab15[];
> -#endif
> -
> -u32 MCD_contextSave0[];
> -u32 MCD_contextSave1[];
> -u32 MCD_contextSave2[];
> -u32 MCD_contextSave3[];
> -u32 MCD_contextSave4[];
> -u32 MCD_contextSave5[];
> -u32 MCD_contextSave6[];
> -u32 MCD_contextSave7[];
> -u32 MCD_contextSave8[];
> -u32 MCD_contextSave9[];
> -u32 MCD_contextSave10[];
> -u32 MCD_contextSave11[];
> -u32 MCD_contextSave12[];
> -u32 MCD_contextSave13[];
> -u32 MCD_contextSave14[];
> -u32 MCD_contextSave15[];
> -
> -u32 MCD_realTaskTableSrc[] = {
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab0,	/* Task 0 Variable Table */
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave0,	/* Task 0 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab1,	/* Task 1 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab1,	/* Task 1 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave1,	/* Task 1 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab2,	/* Task 2 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab2,	/* Task 2 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave2,	/* Task 2 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab3,	/* Task 3 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab3,	/* Task 3 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave3,	/* Task 3 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab4,	/* Task 4 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab4,	/* Task 4 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave4,	/* Task 4 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab5,	/* Task 5 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab5,	/* Task 5 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave5,	/* Task 5 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab6,	/* Task 6 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab6,	/* Task 6 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave6,	/* Task 6 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab7,	/* Task 7 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab7,	/* Task 7 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave7,	/* Task 7 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab8,	/* Task 8 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab8,	/* Task 8 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave8,	/* Task 8 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab9,	/* Task 9 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab9,	/* Task 9 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave9,	/* Task 9 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab10,	/* Task 10 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab10,	/* Task 10 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave10,	/* Task 10 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab11,	/* Task 11 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab11,	/* Task 11 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave11,	/* Task 11 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab12,	/* Task 12 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab12,	/* Task 12 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave12,	/* Task 12 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab13,	/* Task 13 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab13,	/* Task 13 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave13,	/* Task 13 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab14,	/* Task 14 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab14,	/* Task 14 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave14,	/* Task 14 context save space */
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_varTab15,	/* Task 15 Variable Table */
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_funcDescTab15,	/* Task 15 Fn Desc. Table & Flags */
> -#else
> -	(u32) MCD_funcDescTab0,	/* Task 0 Fn Desc. Table & Flags */
> -#endif
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_contextSave15,	/* Task 15 context save space */
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab0[] = {		/* Task 0 Variable Table */
> -	0x00000000,		/* var[0] */
> -	0x00000000,		/* var[1] */
> -	0x00000000,		/* var[2] */
> -	0x00000000,		/* var[3] */
> -	0x00000000,		/* var[4] */
> -	0x00000000,		/* var[5] */
> -	0x00000000,		/* var[6] */
> -	0x00000000,		/* var[7] */
> -	0x00000000,		/* var[8] */
> -	0x00000000,		/* var[9] */
> -	0x00000000,		/* var[10] */
> -	0x00000000,		/* var[11] */
> -	0x00000000,		/* var[12] */
> -	0x00000000,		/* var[13] */
> -	0x00000000,		/* var[14] */
> -	0x00000000,		/* var[15] */
> -	0x00000000,		/* var[16] */
> -	0x00000000,		/* var[17] */
> -	0x00000000,		/* var[18] */
> -	0x00000000,		/* var[19] */
> -	0x00000000,		/* var[20] */
> -	0x00000000,		/* var[21] */
> -	0x00000000,		/* var[22] */
> -	0x00000000,		/* var[23] */
> -	0xe0000000,		/* inc[0] */
> -	0x20000000,		/* inc[1] */
> -	0x2000ffff,		/* inc[2] */
> -	0x00000000,		/* inc[3] */
> -	0x00000000,		/* inc[4] */
> -	0x00000000,		/* inc[5] */
> -	0x00000000,		/* inc[6] */
> -	0x00000000,		/* inc[7] */
> -};
> -
> -u32 MCD_varTab1[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab2[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab3[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab4[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab5[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab6[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab7[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab8[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab9[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab10[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab11[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab12[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab13[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab14[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_varTab15[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xe0000000,
> -	0x20000000,
> -	0x2000ffff,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_funcDescTab0[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -#ifdef MCD_INCLUDE_EU
> -u32 MCD_funcDescTab1[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab2[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab3[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab4[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab5[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab6[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab7[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab8[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab9[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab10[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab11[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab12[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab13[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab14[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -
> -u32 MCD_funcDescTab15[] = {
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0xa0045670,
> -	0xa0000000,
> -	0xa0000000,
> -	0x20000000,
> -	0x21800000,
> -	0x21e00000,
> -	0x20400000,
> -	0x20500000,
> -	0x205a0000,
> -	0x20a00000,
> -	0x202fa000,
> -	0x202f9000,
> -	0x202ea000,
> -	0x202da000,
> -	0x202e2000,
> -	0x202f2000,
> -};
> -#endif				/*MCD_INCLUDE_EU */
> -
> -u32 MCD_contextSave0[128];	/* Task 0 context save space */
> -u32 MCD_contextSave1[128];	/* Task 1 context save space */
> -u32 MCD_contextSave2[128];	/* Task 2 context save space */
> -u32 MCD_contextSave3[128];	/* Task 3 context save space */
> -u32 MCD_contextSave4[128];	/* Task 4 context save space */
> -u32 MCD_contextSave5[128];	/* Task 5 context save space */
> -u32 MCD_contextSave6[128];	/* Task 6 context save space */
> -u32 MCD_contextSave7[128];	/* Task 7 context save space */
> -u32 MCD_contextSave8[128];	/* Task 8 context save space */
> -u32 MCD_contextSave9[128];	/* Task 9 context save space */
> -u32 MCD_contextSave10[128];	/* Task 10 context save space */
> -u32 MCD_contextSave11[128];	/* Task 11 context save space */
> -u32 MCD_contextSave12[128];	/* Task 12 context save space */
> -u32 MCD_contextSave13[128];	/* Task 13 context save space */
> -u32 MCD_contextSave14[128];	/* Task 14 context save space */
> -u32 MCD_contextSave15[128];	/* Task 15 context save space */
> -
> -u32 MCD_ChainNoEu_TDT[];
> -u32 MCD_SingleNoEu_TDT[];
> -#ifdef MCD_INCLUDE_EU
> -u32 MCD_ChainEu_TDT[];
> -u32 MCD_SingleEu_TDT[];
> -#endif
> -u32 MCD_ENetRcv_TDT[];
> -u32 MCD_ENetXmit_TDT[];
> -
> -u32 MCD_modelTaskTableSrc[] = {
> -	(u32) MCD_ChainNoEu_TDT,
> -	(u32) & ((u8 *) MCD_ChainNoEu_TDT)[0x0000016c],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_SingleNoEu_TDT,
> -	(u32) & ((u8 *) MCD_SingleNoEu_TDT)[0x000000d4],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -#ifdef MCD_INCLUDE_EU
> -	(u32) MCD_ChainEu_TDT,
> -	(u32) & ((u8 *) MCD_ChainEu_TDT)[0x000001b4],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_SingleEu_TDT,
> -	(u32) & ((u8 *) MCD_SingleEu_TDT)[0x00000124],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -#endif
> -	(u32) MCD_ENetRcv_TDT,
> -	(u32) & ((u8 *) MCD_ENetRcv_TDT)[0x0000009c],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	(u32) MCD_ENetXmit_TDT,
> -	(u32) & ((u8 *) MCD_ENetXmit_TDT)[0x000000d0],
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -	0x00000000,
> -};
> -
> -u32 MCD_ChainNoEu_TDT[] = {
> -	0x80004000,
> -	0x8118801b,
> -	0xb8c60018,
> -	0x10002b10,
> -	0x7000000d,
> -	0x018cf89f,
> -	0x6000000a,
> -	0x080cf89f,
> -	0x000001f8,
> -	0x98180364,
> -	0x8118801b,
> -	0xf8c6001a,
> -	0xb8c6601b,
> -	0x10002710,
> -	0x00000f18,
> -	0xb8c6001d,
> -	0x10001310,
> -	0x60000007,
> -	0x014cf88b,
> -	0x98c6001c,
> -	0x00000710,
> -	0x98c70018,
> -	0x10001f10,
> -	0x0000c818,
> -	0x000001f8,
> -	0xc1476018,
> -	0xc003231d,
> -	0x811a601b,
> -	0xc1862102,
> -	0x849be009,
> -	0x03fed7b8,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x1000cb20,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb38,
> -	0x0000c728,
> -	0x000001f8,
> -	0xc1476018,
> -	0xc003241d,
> -	0x811a601b,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x0000d3a0,
> -	0xc1862102,
> -	0x849be009,
> -	0x0bfed7b8,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x1000cb20,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf88f,
> -	0x1000cb38,
> -	0x0000c728,
> -	0x000001f8,
> -	0x8118801b,
> -	0xd8c60018,
> -	0x98c6601c,
> -	0x6000000b,
> -	0x0c8cfc9f,
> -	0x000001f8,
> -	0xa146001e,
> -	0x10000b08,
> -	0x10002050,
> -	0xb8c60018,
> -	0x10002b10,
> -	0x7000000a,
> -	0x080cf89f,
> -	0x6000000d,
> -	0x018cf89f,
> -	0x000001f8,
> -	0x8618801b,
> -	0x7000000e,
> -	0x084cf21f,
> -	0xd8990336,
> -	0x8019801b,
> -	0x040001f8,
> -	0x000001f8,
> -	0x000001f8,
> -};
> -
> -u32 MCD_SingleNoEu_TDT[] = {
> -	0x8198001b,
> -	0x7000000d,
> -	0x080cf81f,
> -	0x8198801b,
> -	0x6000000e,
> -	0x084cf85f,
> -	0x000001f8,
> -	0x8298001b,
> -	0x7000000d,
> -	0x010cf81f,
> -	0x6000000e,
> -	0x018cf81f,
> -	0xc202601b,
> -	0xc002221c,
> -	0x809a601b,
> -	0xc10420c2,
> -	0x839be009,
> -	0x03fed7b8,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000006,
> -	0x088cf889,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf889,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf889,
> -	0x0000cb38,
> -	0x000001f8,
> -	0xc202601b,
> -	0xc002229c,
> -	0x809a601b,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x0000d3a0,
> -	0xc10420c2,
> -	0x839be009,
> -	0x0bfed7b8,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000006,
> -	0x088cf889,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf889,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf889,
> -	0x0000cb38,
> -	0x000001f8,
> -	0xc318022d,
> -	0x8018801b,
> -	0x040001f8,
> -};
> -
> -#ifdef MCD_INCLUDE_EU
> -u32 MCD_ChainEu_TDT[] = {
> -	0x80004000,
> -	0x8198801b,
> -	0xb8c68018,
> -	0x10002f10,
> -	0x7000000d,
> -	0x01ccf89f,
> -	0x6000000a,
> -	0x080cf89f,
> -	0x000001f8,
> -	0x981803a4,
> -	0x8198801b,
> -	0xf8c6801a,
> -	0xb8c6e01b,
> -	0x10002b10,
> -	0x00001318,
> -	0xb8c6801d,
> -	0x10001710,
> -	0x60000007,
> -	0x018cf88c,
> -	0x98c6801c,
> -	0x00000b10,
> -	0x98c78018,
> -	0x10002310,
> -	0x0000c820,
> -	0x000001f8,
> -	0x8698801b,
> -	0x7000000f,
> -	0x084cf2df,
> -	0xd899042d,
> -	0x8019801b,
> -	0x60000003,
> -	0x2cd7c7df,
> -	0xd8990364,
> -	0x8019801b,
> -	0x60000003,
> -	0x2c17c7df,
> -	0x000001f8,
> -	0xc1c7e018,
> -	0xc003a35e,
> -	0x819a601b,
> -	0xc206a142,
> -	0x851be009,
> -	0x63fe0000,
> -	0x0d4cfddf,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000002,
> -	0x004cf81f,
> -	0x1000cb20,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb38,
> -	0x0000c728,
> -	0x000001f8,
> -	0xc1c7e018,
> -	0xc003a49e,
> -	0x819a601b,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x0000d3a0,
> -	0xc206a142,
> -	0x851be009,
> -	0x6bfe0000,
> -	0x0d4cfddf,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000002,
> -	0x004cf81f,
> -	0x1000cb20,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf891,
> -	0x1000cb38,
> -	0x0000c728,
> -	0x000001f8,
> -	0x8198801b,
> -	0xd8c68018,
> -	0x98c6e01c,
> -	0x6000000b,
> -	0x0c8cfc9f,
> -	0x0000cc08,
> -	0xa1c6801e,
> -	0x10000f08,
> -	0x10002458,
> -	0xb8c68018,
> -	0x10002f10,
> -	0x7000000a,
> -	0x080cf89f,
> -	0x6000000d,
> -	0x01ccf89f,
> -	0x000001f8,
> -	0x8698801b,
> -	0x7000000e,
> -	0x084cf25f,
> -	0xd899037f,
> -	0x8019801b,
> -	0x040001f8,
> -	0x000001f8,
> -	0x000001f8,
> -};
> -
> -u32 MCD_SingleEu_TDT[] = {
> -	0x8218001b,
> -	0x7000000d,
> -	0x080cf81f,
> -	0x8218801b,
> -	0x6000000e,
> -	0x084cf85f,
> -	0x000001f8,
> -	0x8318001b,
> -	0x7000000d,
> -	0x014cf81f,
> -	0x6000000e,
> -	0x01ccf81f,
> -	0x8498001b,
> -	0x7000000f,
> -	0x080cf19f,
> -	0xd81882a4,
> -	0x8019001b,
> -	0x60000003,
> -	0x2c97c7df,
> -	0xd818826d,
> -	0x8019001b,
> -	0x60000003,
> -	0x2c17c7df,
> -	0x000001f8,
> -	0xc282e01b,
> -	0xc002a25e,
> -	0x811a601b,
> -	0xc184a102,
> -	0x841be009,
> -	0x63fe0000,
> -	0x0d4cfddf,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000002,
> -	0x004cf99f,
> -	0x70000006,
> -	0x088cf88b,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf88b,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf88b,
> -	0x0000cb38,
> -	0x000001f8,
> -	0xc282e01b,
> -	0xc002a31e,
> -	0x811a601b,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x0000d3a0,
> -	0xc184a102,
> -	0x841be009,
> -	0x6bfe0000,
> -	0x0d4cfddf,
> -	0xda9b001b,
> -	0x9b9be01b,
> -	0x70000002,
> -	0x004cf99f,
> -	0x70000006,
> -	0x088cf88b,
> -	0x1000cb28,
> -	0x70000006,
> -	0x088cf88b,
> -	0x1000cb30,
> -	0x70000006,
> -	0x088cf88b,
> -	0x0000cb38,
> -	0x000001f8,
> -	0x8144801c,
> -	0x0000c008,
> -	0xc398027f,
> -	0x8018801b,
> -	0x040001f8,
> -};
> -#endif
> -u32 MCD_ENetRcv_TDT[] = {
> -	0x80004000,
> -	0x81988000,
> -	0x10000788,
> -	0x6000000a,
> -	0x080cf05f,
> -	0x98180209,
> -	0x81c40004,
> -	0x7000000e,
> -	0x010cf05f,
> -	0x7000000c,
> -	0x01ccf05f,
> -	0x70000004,
> -	0x014cf049,
> -	0x70000004,
> -	0x004cf04a,
> -	0x00000b88,
> -	0xc4030150,
> -	0x8119e012,
> -	0x03e0cf90,
> -	0x81188000,
> -	0x000ac788,
> -	0xc4030000,
> -	0x8199e000,
> -	0x70000004,
> -	0x084cfc8b,
> -	0x60000005,
> -	0x0cccf841,
> -	0x81c60000,
> -	0xc399021b,
> -	0x80198000,
> -	0x00008400,
> -	0x00000f08,
> -	0x81988000,
> -	0x10000788,
> -	0x6000000a,
> -	0x080cf05f,
> -	0xc2188209,
> -	0x80190000,
> -	0x040001f8,
> -	0x000001f8,
> -};
> -
> -u32 MCD_ENetXmit_TDT[] = {
> -	0x80004000,
> -	0x81988000,
> -	0x10000788,
> -	0x6000000a,
> -	0x080cf05f,
> -	0x98180309,
> -	0x80004003,
> -	0x81c60004,
> -	0x7000000e,
> -	0x014cf05f,
> -	0x7000000c,
> -	0x028cf05f,
> -	0x7000000d,
> -	0x018cf05f,
> -	0x70000004,
> -	0x01ccf04d,
> -	0x10000b90,
> -	0x60000004,
> -	0x020cf0a1,
> -	0xc3188312,
> -	0x83c70000,
> -	0x00001f10,
> -	0xc583a3c3,
> -	0x81042325,
> -	0x03e0c798,
> -	0xd8990000,
> -	0x9999e000,
> -	0x000acf98,
> -	0xd8992306,
> -	0x9999e03f,
> -	0x03eac798,
> -	0xd8990000,
> -	0x9999e000,
> -	0x000acf98,
> -	0xd8990000,
> -	0x99832302,
> -	0x0beac798,
> -	0x81988000,
> -	0x6000000b,
> -	0x0c4cfc5f,
> -	0x81c80000,
> -	0xc5190312,
> -	0x80198000,
> -	0x00008400,
> -	0x00000f08,
> -	0x81988000,
> -	0x10000788,
> -	0x6000000a,
> -	0x080cf05f,
> -	0xc2988309,
> -	0x80190000,
> -	0x040001f8,
> -	0x000001f8,
> -};
> -
> -#ifdef MCD_INCLUDE_EU
> -MCD_bufDesc MCD_singleBufDescs[NCHANNELS];
> -#endif
> diff --git a/drivers/dma/MCD_tasksInit.c b/drivers/dma/MCD_tasksInit.c
> deleted file mode 100644
> index 079cd0af3c02..000000000000
> --- a/drivers/dma/MCD_tasksInit.c
> +++ /dev/null
> @@ -1,225 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> -#include <common.h>
> -
> -/* Functions for initializing variable tables of different types of tasks. */
> -
> -/*
> - * Do not edit!
> - */
> -
> -#include <MCD_dma.h>
> -
> -extern dmaRegs *MCD_dmaBar;
> -
> -/* Task 0 */
> -
> -void MCD_startDmaChainNoEu(int *currBD, short srcIncr, short destIncr,
> -			   int xferSize, short xferSizeIncr, int *cSave,
> -			   volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 2, (u32) currBD);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 25, (u32) (0xe000 << 16) | (0xffff & srcIncr));	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 24, (u32) (0xe000 << 16) | (0xffff & destIncr));	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 11, (u32) xferSize);	/* var[11] */
> -	MCD_SET_VAR(taskChan, 26, (u32) (0x2000 << 16) | (0xffff & xferSizeIncr));	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 0, (u32) cSave);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 1, (u32) 0x00000000);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 3, (u32) 0x00000000);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 4, (u32) 0x00000000);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 5, (u32) 0x00000000);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 6, (u32) 0x00000000);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 7, (u32) 0x00000000);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 8, (u32) 0x00000000);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x00000000);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x00000000);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 12, (u32) 0x00000000);	/* var[12] */
> -	MCD_SET_VAR(taskChan, 13, (u32) 0x80000000);	/* var[13] */
> -	MCD_SET_VAR(taskChan, 14, (u32) 0x00000010);	/* var[14] */
> -	MCD_SET_VAR(taskChan, 15, (u32) 0x00000004);	/* var[15] */
> -	MCD_SET_VAR(taskChan, 16, (u32) 0x08000000);	/* var[16] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0x00000000);	/* inc[3] */
> -	MCD_SET_VAR(taskChan, 28, (u32) 0x80000000);	/* inc[4] */
> -	MCD_SET_VAR(taskChan, 29, (u32) 0x80000001);	/* inc[5] */
> -	MCD_SET_VAR(taskChan, 30, (u32) 0x40000000);	/* inc[6] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> -
> -/* Task 1 */
> -
> -void MCD_startDmaSingleNoEu(char *srcAddr, short srcIncr, char *destAddr,
> -			    short destIncr, int dmaSize, short xferSizeIncr,
> -			    int flags, int *currBD, int *cSave,
> -			    volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 7, (u32) srcAddr);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 25, (u32) (0xe000 << 16) | (0xffff & srcIncr));	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 2, (u32) destAddr);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 24, (u32) (0xe000 << 16) | (0xffff & destIncr));	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 3, (u32) dmaSize);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 26, (u32) (0x2000 << 16) | (0xffff & xferSizeIncr));	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 5, (u32) flags);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 1, (u32) currBD);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 0, (u32) cSave);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 4, (u32) 0x00000000);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 6, (u32) 0x00000000);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 8, (u32) 0x00000000);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x00000004);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x08000000);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0x00000000);	/* inc[3] */
> -	MCD_SET_VAR(taskChan, 28, (u32) 0x80000001);	/* inc[4] */
> -	MCD_SET_VAR(taskChan, 29, (u32) 0x40000000);	/* inc[5] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> -
> -/* Task 2 */
> -
> -void MCD_startDmaChainEu(int *currBD, short srcIncr, short destIncr,
> -			 int xferSize, short xferSizeIncr, int *cSave,
> -			 volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 3, (u32) currBD);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 25, (u32) (0xe000 << 16) | (0xffff & srcIncr));	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 24, (u32) (0xe000 << 16) | (0xffff & destIncr));	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 12, (u32) xferSize);	/* var[12] */
> -	MCD_SET_VAR(taskChan, 26, (u32) (0x2000 << 16) | (0xffff & xferSizeIncr));	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 0, (u32) cSave);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 1, (u32) 0x00000000);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 2, (u32) 0x00000000);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 4, (u32) 0x00000000);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 5, (u32) 0x00000000);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 6, (u32) 0x00000000);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 7, (u32) 0x00000000);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 8, (u32) 0x00000000);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x00000000);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x00000000);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 11, (u32) 0x00000000);	/* var[11] */
> -	MCD_SET_VAR(taskChan, 13, (u32) 0x00000000);	/* var[13] */
> -	MCD_SET_VAR(taskChan, 14, (u32) 0x80000000);	/* var[14] */
> -	MCD_SET_VAR(taskChan, 15, (u32) 0x00000010);	/* var[15] */
> -	MCD_SET_VAR(taskChan, 16, (u32) 0x00000001);	/* var[16] */
> -	MCD_SET_VAR(taskChan, 17, (u32) 0x00000004);	/* var[17] */
> -	MCD_SET_VAR(taskChan, 18, (u32) 0x08000000);	/* var[18] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0x00000000);	/* inc[3] */
> -	MCD_SET_VAR(taskChan, 28, (u32) 0x80000000);	/* inc[4] */
> -	MCD_SET_VAR(taskChan, 29, (u32) 0xc0000000);	/* inc[5] */
> -	MCD_SET_VAR(taskChan, 30, (u32) 0x80000001);	/* inc[6] */
> -	MCD_SET_VAR(taskChan, 31, (u32) 0x40000000);	/* inc[7] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> -
> -/* Task 3 */
> -
> -void MCD_startDmaSingleEu(char *srcAddr, short srcIncr, char *destAddr,
> -			  short destIncr, int dmaSize, short xferSizeIncr,
> -			  int flags, int *currBD, int *cSave,
> -			  volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 8, (u32) srcAddr);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 25, (u32) (0xe000 << 16) | (0xffff & srcIncr));	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 3, (u32) destAddr);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 24, (u32) (0xe000 << 16) | (0xffff & destIncr));	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 4, (u32) dmaSize);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 26, (u32) (0x2000 << 16) | (0xffff & xferSizeIncr));	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 6, (u32) flags);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 2, (u32) currBD);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 0, (u32) cSave);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 1, (u32) 0x00000000);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 5, (u32) 0x00000000);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 7, (u32) 0x00000000);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x00000000);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x00000001);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 11, (u32) 0x00000004);	/* var[11] */
> -	MCD_SET_VAR(taskChan, 12, (u32) 0x08000000);	/* var[12] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0x00000000);	/* inc[3] */
> -	MCD_SET_VAR(taskChan, 28, (u32) 0xc0000000);	/* inc[4] */
> -	MCD_SET_VAR(taskChan, 29, (u32) 0x80000000);	/* inc[5] */
> -	MCD_SET_VAR(taskChan, 30, (u32) 0x80000001);	/* inc[6] */
> -	MCD_SET_VAR(taskChan, 31, (u32) 0x40000000);	/* inc[7] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> -
> -/* Task 4 */
> -
> -void MCD_startDmaENetRcv(char *bDBase, char *currBD, char *rcvFifoPtr,
> -			 volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 0, (u32) bDBase);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 3, (u32) currBD);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 6, (u32) rcvFifoPtr);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 1, (u32) 0x00000000);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 2, (u32) 0x00000000);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 4, (u32) 0x00000000);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 5, (u32) 0x00000000);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 7, (u32) 0x00000000);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 8, (u32) 0x00000000);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x0000ffff);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x30000000);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 11, (u32) 0x0fffffff);	/* var[11] */
> -	MCD_SET_VAR(taskChan, 12, (u32) 0x00000008);	/* var[12] */
> -	MCD_SET_VAR(taskChan, 24, (u32) 0x00000000);	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 25, (u32) 0x60000000);	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 26, (u32) 0x20000004);	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0x40000000);	/* inc[3] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> -
> -/* Task 5 */
> -
> -void MCD_startDmaENetXmit(char *bDBase, char *currBD, char *xmitFifoPtr,
> -			  volatile TaskTableEntry * taskTable, int channel)
> -{
> -	volatile TaskTableEntry *taskChan = taskTable + channel;
> -
> -	MCD_SET_VAR(taskChan, 0, (u32) bDBase);	/* var[0] */
> -	MCD_SET_VAR(taskChan, 3, (u32) currBD);	/* var[3] */
> -	MCD_SET_VAR(taskChan, 11, (u32) xmitFifoPtr);	/* var[11] */
> -	MCD_SET_VAR(taskChan, 1, (u32) 0x00000000);	/* var[1] */
> -	MCD_SET_VAR(taskChan, 2, (u32) 0x00000000);	/* var[2] */
> -	MCD_SET_VAR(taskChan, 4, (u32) 0x00000000);	/* var[4] */
> -	MCD_SET_VAR(taskChan, 5, (u32) 0x00000000);	/* var[5] */
> -	MCD_SET_VAR(taskChan, 6, (u32) 0x00000000);	/* var[6] */
> -	MCD_SET_VAR(taskChan, 7, (u32) 0x00000000);	/* var[7] */
> -	MCD_SET_VAR(taskChan, 8, (u32) 0x00000000);	/* var[8] */
> -	MCD_SET_VAR(taskChan, 9, (u32) 0x00000000);	/* var[9] */
> -	MCD_SET_VAR(taskChan, 10, (u32) 0x00000000);	/* var[10] */
> -	MCD_SET_VAR(taskChan, 12, (u32) 0x00000000);	/* var[12] */
> -	MCD_SET_VAR(taskChan, 13, (u32) 0x0000ffff);	/* var[13] */
> -	MCD_SET_VAR(taskChan, 14, (u32) 0xffffffff);	/* var[14] */
> -	MCD_SET_VAR(taskChan, 15, (u32) 0x00000004);	/* var[15] */
> -	MCD_SET_VAR(taskChan, 16, (u32) 0x00000008);	/* var[16] */
> -	MCD_SET_VAR(taskChan, 24, (u32) 0x00000000);	/* inc[0] */
> -	MCD_SET_VAR(taskChan, 25, (u32) 0x60000000);	/* inc[1] */
> -	MCD_SET_VAR(taskChan, 26, (u32) 0x40000000);	/* inc[2] */
> -	MCD_SET_VAR(taskChan, 27, (u32) 0xc000fffc);	/* inc[3] */
> -	MCD_SET_VAR(taskChan, 28, (u32) 0xe0000004);	/* inc[4] */
> -	MCD_SET_VAR(taskChan, 29, (u32) 0x80000000);	/* inc[5] */
> -	MCD_SET_VAR(taskChan, 30, (u32) 0x4000ffff);	/* inc[6] */
> -	MCD_SET_VAR(taskChan, 31, (u32) 0xe0000001);	/* inc[7] */
> -
> -	/* Set the task's Enable bit in its Task Control Register */
> -	MCD_dmaBar->taskControl[channel] |= (u16) 0x8000;
> -}
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a75572fe5dec..48811eaaeb36 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -5,7 +5,6 @@
>   
>   obj-$(CONFIG_DMA) += dma-uclass.o
>   
> -obj-$(CONFIG_FSLDMAFEC) += MCD_tasksInit.o MCD_dmaApi.o MCD_tasks.o
>   obj-$(CONFIG_APBH_DMA) += apbh_dma.o
>   obj-$(CONFIG_BCM6348_IUDMA) += bcm6348-iudma.o
>   obj-$(CONFIG_FSL_DMA) += fsl_dma.o
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 29304fd77759..357111761424 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -471,14 +471,6 @@ config SYS_UNIFY_CACHE
>   	depends on MCFFEC
>   	bool "Invalidate icache during ethernet operations"
>   
> -config FSLDMAFEC
> -        bool "ColdFire DMA Ethernet Support"
> -	select PHYLIB
> -	select SYS_DISCOVER_PHY
> -	help
> -	  This driver supports the network interface units in the
> -	  ColdFire family.
> -
>   config KS8851_MLL
>   	bool "Microchip KS8851-MLL controller driver"
>   	help
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 1d444f5b4a69..c44b4c8300af 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -37,7 +37,6 @@ obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw.o
>   obj-$(CONFIG_FEC_MXC) += fec_mxc.o
>   obj-$(CONFIG_FMAN_ENET) += fm/
>   obj-$(CONFIG_FMAN_ENET) += fsl_mdio.o
> -obj-$(CONFIG_FSLDMAFEC) += fsl_mcdmafec.o mcfmii.o
>   obj-$(CONFIG_FSL_ENETC) += fsl_enetc.o fsl_enetc_mdio.o
>   obj-$(CONFIG_FSL_LS_MDIO) += fsl_ls_mdio.o
>   obj-$(CONFIG_FSL_MC_ENET) += fsl-mc/
> diff --git a/drivers/net/fsl_mcdmafec.c b/drivers/net/fsl_mcdmafec.c
> deleted file mode 100644
> index cc61a1074038..000000000000
> --- a/drivers/net/fsl_mcdmafec.c
> +++ /dev/null
> @@ -1,592 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2000-2004
> - * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> - *
> - * (C) Copyright 2007 Freescale Semiconductor, Inc.
> - * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
> - *
> - * Conversion to DM
> - * (C) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
> - */
> -
> -#include <common.h>
> -#include <env.h>
> -#include <hang.h>
> -#include <malloc.h>
> -#include <command.h>
> -#include <config.h>
> -#include <net.h>
> -#include <miiphy.h>
> -#include <asm/global_data.h>
> -#include <linux/delay.h>
> -#include <linux/mii.h>
> -#include <asm/immap.h>
> -#include <asm/fsl_mcdmafec.h>
> -
> -#include "MCD_dma.h"
> -
> -#undef	ET_DEBUG
> -#undef	MII_DEBUG
> -
> -/* Ethernet Transmit and Receive Buffers */
> -#define DBUF_LENGTH		1520
> -#define PKT_MAXBUF_SIZE		1518
> -#define FIFO_ERRSTAT		(FIFO_STAT_RXW | FIFO_STAT_UF | FIFO_STAT_OF)
> -
> -/* RxBD bits definitions */
> -#define BD_ENET_RX_ERR	(BD_ENET_RX_LG | BD_ENET_RX_NO | BD_ENET_RX_CR | \
> -			 BD_ENET_RX_OV | BD_ENET_RX_TR)
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -static void init_eth_info(struct fec_info_dma *info)
> -{
> -	/* setup Receive and Transmit buffer descriptor */
> -#ifdef CFG_SYS_FEC_BUF_USE_SRAM
> -	static u32 tmp;
> -
> -	if (info->index == 0)
> -		tmp = CFG_SYS_INIT_RAM_ADDR + 0x1000;
> -	else
> -		info->rxbd = (cbd_t *)DBUF_LENGTH;
> -
> -	info->rxbd = (cbd_t *)((u32)info->rxbd + tmp);
> -	tmp = (u32)info->rxbd;
> -	info->txbd =
> -	    (cbd_t *)((u32)info->txbd + tmp +
> -	    (PKTBUFSRX * sizeof(cbd_t)));
> -	tmp = (u32)info->txbd;
> -	info->txbuf =
> -	    (char *)((u32)info->txbuf + tmp +
> -	    (CFG_SYS_TX_ETH_BUFFER * sizeof(cbd_t)));
> -	tmp = (u32)info->txbuf;
> -#else
> -	info->rxbd =
> -	    (cbd_t *)memalign(CONFIG_SYS_CACHELINE_SIZE,
> -			       (PKTBUFSRX * sizeof(cbd_t)));
> -	info->txbd =
> -	    (cbd_t *)memalign(CONFIG_SYS_CACHELINE_SIZE,
> -			       (CFG_SYS_TX_ETH_BUFFER * sizeof(cbd_t)));
> -	info->txbuf =
> -	    (char *)memalign(CONFIG_SYS_CACHELINE_SIZE, DBUF_LENGTH);
> -#endif
> -
> -#ifdef ET_DEBUG
> -	printf("rxbd %x txbd %x\n", (int)info->rxbd, (int)info->txbd);
> -#endif
> -	info->phy_name = (char *)memalign(CONFIG_SYS_CACHELINE_SIZE, 32);
> -}
> -
> -static void fec_halt(struct udevice *dev)
> -{
> -	struct fec_info_dma *info = dev_get_priv(dev);
> -	volatile fecdma_t *fecp = (fecdma_t *)info->iobase;
> -	int counter = 0xffff;
> -
> -	/* issue graceful stop command to the FEC transmitter if necessary */
> -	fecp->tcr |= FEC_TCR_GTS;
> -
> -	/* wait for graceful stop to register */
> -	while ((counter--) && (!(fecp->eir & FEC_EIR_GRA)))
> -		;
> -
> -	/* Disable DMA tasks */
> -	MCD_killDma(info->tx_task);
> -	MCD_killDma(info->rx_task);
> -
> -	/* Disable the Ethernet Controller */
> -	fecp->ecr &= ~FEC_ECR_ETHER_EN;
> -
> -	/* Clear FIFO status registers */
> -	fecp->rfsr &= FIFO_ERRSTAT;
> -	fecp->tfsr &= FIFO_ERRSTAT;
> -
> -	fecp->frst = 0x01000000;
> -
> -	/* Issue a reset command to the FEC chip */
> -	fecp->ecr |= FEC_ECR_RESET;
> -
> -	/* wait at least 20 clock cycles */
> -	mdelay(10);
> -
> -#ifdef ET_DEBUG
> -	printf("Ethernet task stopped\n");
> -#endif
> -}
> -
> -#ifdef ET_DEBUG
> -static void dbg_fec_regs(struct eth_device *dev)
> -{
> -	struct fec_info_dma *info = dev->priv;
> -	volatile fecdma_t *fecp = (fecdma_t *)info->iobase;
> -
> -	printf("=====\n");
> -	printf("ievent       %x - %x\n", (int)&fecp->eir, fecp->eir);
> -	printf("imask        %x - %x\n", (int)&fecp->eimr, fecp->eimr);
> -	printf("ecntrl       %x - %x\n", (int)&fecp->ecr, fecp->ecr);
> -	printf("mii_mframe   %x - %x\n", (int)&fecp->mmfr, fecp->mmfr);
> -	printf("mii_speed    %x - %x\n", (int)&fecp->mscr, fecp->mscr);
> -	printf("mii_ctrlstat %x - %x\n", (int)&fecp->mibc, fecp->mibc);
> -	printf("r_cntrl      %x - %x\n", (int)&fecp->rcr, fecp->rcr);
> -	printf("r hash       %x - %x\n", (int)&fecp->rhr, fecp->rhr);
> -	printf("x_cntrl      %x - %x\n", (int)&fecp->tcr, fecp->tcr);
> -	printf("padr_l       %x - %x\n", (int)&fecp->palr, fecp->palr);
> -	printf("padr_u       %x - %x\n", (int)&fecp->paur, fecp->paur);
> -	printf("op_pause     %x - %x\n", (int)&fecp->opd, fecp->opd);
> -	printf("iadr_u       %x - %x\n", (int)&fecp->iaur, fecp->iaur);
> -	printf("iadr_l       %x - %x\n", (int)&fecp->ialr, fecp->ialr);
> -	printf("gadr_u       %x - %x\n", (int)&fecp->gaur, fecp->gaur);
> -	printf("gadr_l       %x - %x\n", (int)&fecp->galr, fecp->galr);
> -	printf("x_wmrk       %x - %x\n", (int)&fecp->tfwr, fecp->tfwr);
> -	printf("r_fdata      %x - %x\n", (int)&fecp->rfdr, fecp->rfdr);
> -	printf("r_fstat      %x - %x\n", (int)&fecp->rfsr, fecp->rfsr);
> -	printf("r_fctrl      %x - %x\n", (int)&fecp->rfcr, fecp->rfcr);
> -	printf("r_flrfp      %x - %x\n", (int)&fecp->rlrfp, fecp->rlrfp);
> -	printf("r_flwfp      %x - %x\n", (int)&fecp->rlwfp, fecp->rlwfp);
> -	printf("r_frfar      %x - %x\n", (int)&fecp->rfar, fecp->rfar);
> -	printf("r_frfrp      %x - %x\n", (int)&fecp->rfrp, fecp->rfrp);
> -	printf("r_frfwp      %x - %x\n", (int)&fecp->rfwp, fecp->rfwp);
> -	printf("t_fdata      %x - %x\n", (int)&fecp->tfdr, fecp->tfdr);
> -	printf("t_fstat      %x - %x\n", (int)&fecp->tfsr, fecp->tfsr);
> -	printf("t_fctrl      %x - %x\n", (int)&fecp->tfcr, fecp->tfcr);
> -	printf("t_flrfp      %x - %x\n", (int)&fecp->tlrfp, fecp->tlrfp);
> -	printf("t_flwfp      %x - %x\n", (int)&fecp->tlwfp, fecp->tlwfp);
> -	printf("t_ftfar      %x - %x\n", (int)&fecp->tfar, fecp->tfar);
> -	printf("t_ftfrp      %x - %x\n", (int)&fecp->tfrp, fecp->tfrp);
> -	printf("t_ftfwp      %x - %x\n", (int)&fecp->tfwp, fecp->tfwp);
> -	printf("frst         %x - %x\n", (int)&fecp->frst, fecp->frst);
> -	printf("ctcwr        %x - %x\n", (int)&fecp->ctcwr, fecp->ctcwr);
> -}
> -#endif
> -
> -static void set_fec_duplex_speed(volatile fecdma_t *fecp, int dup_spd)
> -{
> -	struct bd_info *bd = gd->bd;
> -
> -	if ((dup_spd >> 16) == FULL) {
> -		/* Set maximum frame length */
> -		fecp->rcr = FEC_RCR_MAX_FL(PKT_MAXBUF_SIZE) | FEC_RCR_MII_MODE |
> -		    FEC_RCR_PROM | 0x100;
> -		fecp->tcr = FEC_TCR_FDEN;
> -	} else {
> -		/* Half duplex mode */
> -		fecp->rcr = FEC_RCR_MAX_FL(PKT_MAXBUF_SIZE) |
> -		    FEC_RCR_MII_MODE | FEC_RCR_DRT;
> -		fecp->tcr &= ~FEC_TCR_FDEN;
> -	}
> -
> -	if ((dup_spd & 0xFFFF) == _100BASET) {
> -#ifdef MII_DEBUG
> -		printf("100Mbps\n");
> -#endif
> -		bd->bi_ethspeed = 100;
> -	} else {
> -#ifdef MII_DEBUG
> -		printf("10Mbps\n");
> -#endif
> -		bd->bi_ethspeed = 10;
> -	}
> -}
> -
> -static void fec_set_hwaddr(volatile fecdma_t *fecp, u8 *mac)
> -{
> -	u8 curr_byte;		/* byte for which to compute the CRC */
> -	int byte;		/* loop - counter */
> -	int bit;		/* loop - counter */
> -	u32 crc = 0xffffffff;	/* initial value */
> -
> -	for (byte = 0; byte < 6; byte++) {
> -		curr_byte = mac[byte];
> -		for (bit = 0; bit < 8; bit++) {
> -			if ((curr_byte & 0x01) ^ (crc & 0x01)) {
> -				crc >>= 1;
> -				crc = crc ^ 0xedb88320;
> -			} else {
> -				crc >>= 1;
> -			}
> -			curr_byte >>= 1;
> -		}
> -	}
> -
> -	crc = crc >> 26;
> -
> -	/* Set individual hash table register */
> -	if (crc >= 32) {
> -		fecp->ialr = (1 << (crc - 32));
> -		fecp->iaur = 0;
> -	} else {
> -		fecp->ialr = 0;
> -		fecp->iaur = (1 << crc);
> -	}
> -
> -	/* Set physical address */
> -	fecp->palr = (mac[0] << 24) + (mac[1] << 16) + (mac[2] << 8) + mac[3];
> -	fecp->paur = (mac[4] << 24) + (mac[5] << 16) + 0x8808;
> -
> -	/* Clear multicast address hash table */
> -	fecp->gaur = 0;
> -	fecp->galr = 0;
> -}
> -
> -static int fec_init(struct udevice *dev)
> -{
> -	struct fec_info_dma *info = dev_get_priv(dev);
> -	volatile fecdma_t *fecp = (fecdma_t *)info->iobase;
> -	int rval, i;
> -	uchar enetaddr[6];
> -
> -#ifdef ET_DEBUG
> -	printf("fec_init: iobase 0x%08x ...\n", info->iobase);
> -#endif
> -
> -	fecpin_setclear(info, 1);
> -	fec_halt(dev);
> -
> -	mii_init();
> -	set_fec_duplex_speed(fecp, info->dup_spd);
> -
> -	/* We use strictly polling mode only */
> -	fecp->eimr = 0;
> -
> -	/* Clear any pending interrupt */
> -	fecp->eir = 0xffffffff;
> -
> -	/* Set station address   */
> -	if (info->index == 0)
> -		rval = eth_env_get_enetaddr("ethaddr", enetaddr);
> -	else
> -		rval = eth_env_get_enetaddr("eth1addr", enetaddr);
> -
> -	if (!rval) {
> -		puts("Please set a valid MAC address\n");
> -		return -EINVAL;
> -	}
> -
> -	fec_set_hwaddr(fecp, enetaddr);
> -
> -	/* Set Opcode/Pause Duration Register */
> -	fecp->opd = 0x00010020;
> -
> -	/* Setup Buffers and Buffer Descriptors */
> -	info->rx_idx = 0;
> -	info->tx_idx = 0;
> -
> -	/* Setup Receiver Buffer Descriptors (13.14.24.18)
> -	 * Settings:     Empty, Wrap */
> -	for (i = 0; i < PKTBUFSRX; i++) {
> -		info->rxbd[i].cbd_sc = BD_ENET_RX_EMPTY;
> -		info->rxbd[i].cbd_datlen = PKTSIZE_ALIGN;
> -		info->rxbd[i].cbd_bufaddr = (uint) net_rx_packets[i];
> -	}
> -	info->rxbd[PKTBUFSRX - 1].cbd_sc |= BD_ENET_RX_WRAP;
> -
> -	/* Setup Ethernet Transmitter Buffer Descriptors (13.14.24.19)
> -	 * Settings:    Last, Tx CRC */
> -	for (i = 0; i < CFG_SYS_TX_ETH_BUFFER; i++) {
> -		info->txbd[i].cbd_sc = 0;
> -		info->txbd[i].cbd_datlen = 0;
> -		info->txbd[i].cbd_bufaddr = (uint) (&info->txbuf[0]);
> -	}
> -	info->txbd[CFG_SYS_TX_ETH_BUFFER - 1].cbd_sc |= BD_ENET_TX_WRAP;
> -
> -	info->used_tbd_idx = 0;
> -	info->clean_tbd_num = CFG_SYS_TX_ETH_BUFFER;
> -
> -	/* Set Rx FIFO alarm and granularity value */
> -	fecp->rfcr = 0x0c000000;
> -	fecp->rfar = 0x0000030c;
> -
> -	/* Set Tx FIFO granularity value */
> -	fecp->tfcr = FIFO_CTRL_FRAME | FIFO_CTRL_GR(6) | 0x00040000;
> -	fecp->tfar = 0x00000080;
> -
> -	fecp->tfwr = 0x2;
> -	fecp->ctcwr = 0x03000000;
> -
> -	/* Enable DMA receive task */
> -	MCD_startDma(info->rx_task,
> -		     (s8 *)info->rxbd,
> -		     0,
> -		     (s8 *)&fecp->rfdr,
> -		     4,
> -		     0,
> -		     4,
> -		     info->rx_init,
> -		     info->rx_pri,
> -		     (MCD_FECRX_DMA | MCD_TT_FLAGS_DEF),
> -		     (MCD_NO_CSUM | MCD_NO_BYTE_SWAP)
> -	    );
> -
> -	/* Enable DMA tx task with no ready buffer descriptors */
> -	MCD_startDma(info->tx_task,
> -		     (s8 *)info->txbd,
> -		     0,
> -		     (s8 *)&fecp->tfdr,
> -		     4,
> -		     0,
> -		     4,
> -		     info->tx_init,
> -		     info->tx_pri,
> -		     (MCD_FECTX_DMA | MCD_TT_FLAGS_DEF),
> -		     (MCD_NO_CSUM | MCD_NO_BYTE_SWAP)
> -	    );
> -
> -	/* Now enable the transmit and receive processing */
> -	fecp->ecr |= FEC_ECR_ETHER_EN;
> -
> -	return 0;
> -}
> -
> -static int mcdmafec_init(struct udevice *dev)
> -{
> -	return fec_init(dev);
> -}
> -
> -static int mcdmafec_send(struct udevice *dev, void *packet, int length)
> -{
> -	struct fec_info_dma *info = dev_get_priv(dev);
> -	cbd_t *p_tbd, *p_used_tbd;
> -	u16 phy_status;
> -
> -	miiphy_read(dev->name, info->phy_addr, MII_BMSR, &phy_status);
> -
> -	/* process all the consumed TBDs */
> -	while (info->clean_tbd_num < CFG_SYS_TX_ETH_BUFFER) {
> -		p_used_tbd = &info->txbd[info->used_tbd_idx];
> -		if (p_used_tbd->cbd_sc & BD_ENET_TX_READY) {
> -#ifdef ET_DEBUG
> -			printf("Cannot clean TBD %d, in use\n",
> -			       info->clean_tbd_num);
> -#endif
> -			return 0;
> -		}
> -
> -		/* clean this buffer descriptor */
> -		if (info->used_tbd_idx == (CFG_SYS_TX_ETH_BUFFER - 1))
> -			p_used_tbd->cbd_sc = BD_ENET_TX_WRAP;
> -		else
> -			p_used_tbd->cbd_sc = 0;
> -
> -		/* update some indeces for a correct handling of TBD ring */
> -		info->clean_tbd_num++;
> -		info->used_tbd_idx = (info->used_tbd_idx + 1)
> -			% CFG_SYS_TX_ETH_BUFFER;
> -	}
> -
> -	/* Check for valid length of data. */
> -	if (length > 1500 || length <= 0)
> -		return -1;
> -
> -	/* Check the number of vacant TxBDs. */
> -	if (info->clean_tbd_num < 1) {
> -		printf("No available TxBDs ...\n");
> -		return -1;
> -	}
> -
> -	/* Get the first TxBD to send the mac header */
> -	p_tbd = &info->txbd[info->tx_idx];
> -	p_tbd->cbd_datlen = length;
> -	p_tbd->cbd_bufaddr = (u32)packet;
> -	p_tbd->cbd_sc |= BD_ENET_TX_LAST | BD_ENET_TX_TC | BD_ENET_TX_READY;
> -	info->tx_idx = (info->tx_idx + 1) % CFG_SYS_TX_ETH_BUFFER;
> -
> -	/* Enable DMA transmit task */
> -	MCD_continDma(info->tx_task);
> -
> -	info->clean_tbd_num -= 1;
> -
> -	/* wait until frame is sent . */
> -	while (p_tbd->cbd_sc & BD_ENET_TX_READY)
> -		udelay(10);
> -
> -	return (int)(info->txbd[info->tx_idx].cbd_sc & BD_ENET_TX_STATS);
> -}
> -
> -static int mcdmafec_recv(struct udevice *dev, int flags, uchar **packetp)
> -{
> -	struct fec_info_dma *info = dev_get_priv(dev);
> -	volatile fecdma_t *fecp = (fecdma_t *)info->iobase;
> -
> -	cbd_t *prbd = &info->rxbd[info->rx_idx];
> -	u32 ievent;
> -	int frame_length, len = 0;
> -
> -	/* Check if any critical events have happened */
> -	ievent = fecp->eir;
> -	if (ievent != 0) {
> -		fecp->eir = ievent;
> -
> -		if (ievent & (FEC_EIR_BABT | FEC_EIR_TXERR | FEC_EIR_RXERR)) {
> -			printf("fec_recv: error\n");
> -			fec_halt(dev);
> -			fec_init(dev);
> -			return 0;
> -		}
> -
> -		if (ievent & FEC_EIR_HBERR) {
> -			/* Heartbeat error */
> -			fecp->tcr |= FEC_TCR_GTS;
> -		}
> -
> -		if (ievent & FEC_EIR_GRA) {
> -			/* Graceful stop complete */
> -			if (fecp->tcr & FEC_TCR_GTS) {
> -				printf("fec_recv: tcr_gts\n");
> -				fec_halt(dev);
> -				fecp->tcr &= ~FEC_TCR_GTS;
> -				fec_init(dev);
> -			}
> -		}
> -	}
> -
> -	if (!(prbd->cbd_sc & BD_ENET_RX_EMPTY)) {
> -		if ((prbd->cbd_sc & BD_ENET_RX_LAST) &&
> -		    !(prbd->cbd_sc & BD_ENET_RX_ERR) &&
> -		    ((prbd->cbd_datlen - 4) > 14)) {
> -			/* Get buffer address and size */
> -			frame_length = prbd->cbd_datlen - 4;
> -
> -			/* Fill the buffer and pass it to upper layers */
> -			net_process_received_packet((uchar *)prbd->cbd_bufaddr,
> -						    frame_length);
> -			len = frame_length;
> -		}
> -
> -		/* Reset buffer descriptor as empty */
> -		if (info->rx_idx == (PKTBUFSRX - 1))
> -			prbd->cbd_sc = (BD_ENET_RX_WRAP | BD_ENET_RX_EMPTY);
> -		else
> -			prbd->cbd_sc = BD_ENET_RX_EMPTY;
> -
> -		prbd->cbd_datlen = PKTSIZE_ALIGN;
> -
> -		/* Now, we have an empty RxBD, restart the DMA receive task */
> -		MCD_continDma(info->rx_task);
> -
> -		/* Increment BD count */
> -		info->rx_idx = (info->rx_idx + 1) % PKTBUFSRX;
> -	}
> -
> -	return len;
> -}
> -
> -static void mcdmafec_halt(struct udevice *dev)
> -{
> -	fec_halt(dev);
> -}
> -
> -static const struct eth_ops mcdmafec_ops = {
> -	.start	= mcdmafec_init,
> -	.send	= mcdmafec_send,
> -	.recv	= mcdmafec_recv,
> -	.stop	= mcdmafec_halt,
> -};
> -
> -/*
> - * Boot sequence, called just after mcffec_of_to_plat,
> - * as DM way, it replaces old mcffec_initialize.
> - */
> -static int mcdmafec_probe(struct udevice *dev)
> -{
> -	struct fec_info_dma *info = dev_get_priv(dev);
> -	struct eth_pdata *pdata = dev_get_plat(dev);
> -	int node = dev_of_offset(dev);
> -	int retval;
> -	const u32 *val;
> -
> -	info->index = dev_seq(dev);
> -	info->iobase = pdata->iobase;
> -	info->miibase = pdata->iobase;
> -	info->phy_addr = -1;
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "rx-task", NULL);
> -	if (val)
> -		info->rx_task = fdt32_to_cpu(*val);
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "tx-task", NULL);
> -	if (val)
> -		info->tx_task = fdt32_to_cpu(*val);
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "rx-prioprity", NULL);
> -	if (val)
> -		info->rx_pri = fdt32_to_cpu(*val);
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "tx-prioprity", NULL);
> -	if (val)
> -		info->tx_pri = fdt32_to_cpu(*val);
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "rx-init", NULL);
> -	if (val)
> -		info->rx_init = fdt32_to_cpu(*val);
> -
> -	val = fdt_getprop(gd->fdt_blob, node, "tx-init", NULL);
> -	if (val)
> -		info->tx_init = fdt32_to_cpu(*val);
> -
> -#ifdef CFG_SYS_FEC_BUF_USE_SRAM
> -	u32 tmp = CFG_SYS_INIT_RAM_ADDR + 0x1000;
> -#endif
> -	init_eth_info(info);
> -
> -#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII)
> -	info->bus = mdio_alloc();
> -	if (!info->bus)
> -		return -ENOMEM;
> -	strlcpy(info->bus->name, dev->name, MDIO_NAME_LEN);
> -	info->bus->read = mcffec_miiphy_read;
> -	info->bus->write = mcffec_miiphy_write;
> -
> -	retval = mdio_register(info->bus);
> -	if (retval < 0)
> -		return retval;
> -#endif
> -
> -	return 0;
> -}
> -
> -static int mcdmafec_remove(struct udevice *dev)
> -{
> -	struct fec_info_dma *priv = dev_get_priv(dev);
> -
> -	mdio_unregister(priv->bus);
> -	mdio_free(priv->bus);
> -
> -	return 0;
> -}
> -
> -/*
> - * Boot sequence, called 1st
> - */
> -static int mcdmafec_of_to_plat(struct udevice *dev)
> -{
> -	struct eth_pdata *pdata = dev_get_plat(dev);
> -	const u32 *val;
> -
> -	pdata->iobase = dev_read_addr(dev);
> -	/* Default to 10Mbit/s */
> -	pdata->max_speed = 10;
> -
> -	val = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "max-speed", NULL);
> -	if (val)
> -		pdata->max_speed = fdt32_to_cpu(*val);
> -
> -	return 0;
> -}
> -
> -static const struct udevice_id mcdmafec_ids[] = {
> -	{ .compatible = "fsl,mcf-dma-fec" },
> -	{ }
> -};
> -
> -U_BOOT_DRIVER(mcffec) = {
> -	.name	= "mcdmafec",
> -	.id	= UCLASS_ETH,
> -	.of_match = mcdmafec_ids,
> -	.of_to_plat = mcdmafec_of_to_plat,
> -	.probe	= mcdmafec_probe,
> -	.remove	= mcdmafec_remove,
> -	.ops	= &mcdmafec_ops,
> -	.priv_auto	= sizeof(struct fec_info_dma),
> -	.plat_auto	= sizeof(struct eth_pdata),
> -};
> diff --git a/include/MCD_dma.h b/include/MCD_dma.h
> deleted file mode 100644
> index 2f16c89044ee..000000000000
> --- a/include/MCD_dma.h
> +++ /dev/null
> @@ -1,369 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> -#ifndef _MCD_API_H
> -#define _MCD_API_H
> -
> -/* Turn Execution Unit tasks ON (#define) or OFF (#undef) */
> -#undef MCD_INCLUDE_EU
> -
> -/* Number of DMA channels */
> -#define NCHANNELS	16
> -
> -/* Total number of variants */
> -#ifdef MCD_INCLUDE_EU
> -#define NUMOFVARIANTS	6
> -#else
> -#define NUMOFVARIANTS	4
> -#endif
> -
> -/* Define sizes of the various tables */
> -#define TASK_TABLE_SIZE		(NCHANNELS*32)
> -#define VAR_TAB_SIZE		(128)
> -#define CONTEXT_SAVE_SIZE	(128)
> -#define FUNCDESC_TAB_SIZE	(256)
> -
> -#ifdef MCD_INCLUDE_EU
> -#define FUNCDESC_TAB_NUM	16
> -#else
> -#define FUNCDESC_TAB_NUM	1
> -#endif
> -
> -#ifndef DEFINESONLY
> -
> -/* Portability typedefs */
> -#if 1
> -#include "common.h"
> -#else
> -#ifndef s32
> -typedef int s32;
> -#endif
> -#ifndef u32
> -typedef unsigned int u32;
> -#endif
> -#ifndef s16
> -typedef short s16;
> -#endif
> -#ifndef u16
> -typedef unsigned short u16;
> -#endif
> -#ifndef s8
> -typedef char s8;
> -#endif
> -#ifndef u8
> -typedef unsigned char u8;
> -#endif
> -#endif
> -
> -/*
> - * These structures represent the internal registers of the
> - * multi-channel DMA
> - */
> -struct dmaRegs_s {
> -	u32 taskbar;		/* task table base address */
> -	u32 currPtr;
> -	u32 endPtr;
> -	u32 varTablePtr;
> -	u16 dma_rsvd0;
> -	u16 ptdControl;		/* ptd control */
> -	u32 intPending;		/* interrupt pending */
> -	u32 intMask;		/* interrupt mask */
> -	u16 taskControl[16];	/* task control */
> -	u8 priority[32];	/* priority */
> -	u32 initiatorMux;	/* initiator mux control */
> -	u32 taskSize0;		/* task size control 0. */
> -	u32 taskSize1;		/* task size control 1. */
> -	u32 dma_rsvd1;		/* reserved */
> -	u32 dma_rsvd2;		/* reserved */
> -	u32 debugComp1;		/* debug comparator 1 */
> -	u32 debugComp2;		/* debug comparator 2 */
> -	u32 debugControl;	/* debug control */
> -	u32 debugStatus;	/* debug status */
> -	u32 ptdDebug;		/* priority task decode debug */
> -	u32 dma_rsvd3[31];	/* reserved */
> -};
> -typedef volatile struct dmaRegs_s dmaRegs;
> -
> -#endif
> -
> -/* PTD contrl reg bits */
> -#define PTD_CTL_TSK_PRI		0x8000
> -#define PTD_CTL_COMM_PREFETCH	0x0001
> -
> -/* Task Control reg bits and field masks */
> -#define TASK_CTL_EN		0x8000
> -#define TASK_CTL_VALID		0x4000
> -#define TASK_CTL_ALWAYS		0x2000
> -#define TASK_CTL_INIT_MASK	0x1f00
> -#define TASK_CTL_ASTRT		0x0080
> -#define TASK_CTL_HIPRITSKEN	0x0040
> -#define TASK_CTL_HLDINITNUM	0x0020
> -#define TASK_CTL_ASTSKNUM_MASK	0x000f
> -
> -/* Priority reg bits and field masks */
> -#define PRIORITY_HLD		0x80
> -#define PRIORITY_PRI_MASK	0x07
> -
> -/* Debug Control reg bits and field masks */
> -#define DBG_CTL_BLOCK_TASKS_MASK	0xffff0000
> -#define DBG_CTL_AUTO_ARM		0x00008000
> -#define DBG_CTL_BREAK			0x00004000
> -#define DBG_CTL_COMP1_TYP_MASK		0x00003800
> -#define DBG_CTL_COMP2_TYP_MASK		0x00000070
> -#define DBG_CTL_EXT_BREAK		0x00000004
> -#define DBG_CTL_INT_BREAK		0x00000002
> -
> -/*
> - * PTD Debug reg selector addresses
> - * This reg must be written with a value to show the contents of
> - * one of the desired internal register.
> - */
> -#define PTD_DBG_REQ		0x00	/* shows the state of 31 initiators */
> -#define PTD_DBG_TSK_VLD_INIT	0x01	/* shows which 16 tasks are valid and
> -					   have initiators asserted */
> -
> -/* General return values */
> -#define MCD_OK			0
> -#define MCD_ERROR		-1
> -#define MCD_TABLE_UNALIGNED	-2
> -#define MCD_CHANNEL_INVALID	-3
> -
> -/* MCD_initDma input flags */
> -#define MCD_RELOC_TASKS		0x00000001
> -#define MCD_NO_RELOC_TASKS	0x00000000
> -#define MCD_COMM_PREFETCH_EN	0x00000002	/* MCF547x/548x ONLY */
> -
> -/*
> - * MCD_dmaStatus Status Values for each channel:
> - * MCD_NO_DMA	- No DMA has been requested since reset
> - * MCD_IDLE	- DMA active, but the initiator is currently inactive
> - * MCD_RUNNING	- DMA active, and the initiator is currently active
> - * MCD_PAUSED	- DMA active but it is currently paused
> - * MCD_HALTED	- the most recent DMA has been killed with MCD_killTask()
> - * MCD_DONE	- the most recent DMA has completed
> - */
> -#define MCD_NO_DMA		1
> -#define MCD_IDLE		2
> -#define MCD_RUNNING		3
> -#define MCD_PAUSED		4
> -#define MCD_HALTED		5
> -#define MCD_DONE		6
> -
> -/* MCD_startDma parameter defines */
> -
> -/* Constants for the funcDesc parameter */
> -/*
> - * MCD_NO_BYTE_SWAP	- to disable byte swapping
> - * MCD_BYTE_REVERSE	- to reverse the bytes of each u32 of the DMAed data
> - * MCD_U16_REVERSE	- to reverse the 16-bit halves of each 32-bit data
> - *			  value being DMAed
> - * MCD_U16_BYTE_REVERSE	- to reverse the byte halves of each 16-bit half of
> - *			  each 32-bit data value DMAed
> - * MCD_NO_BIT_REV	- do not reverse the bits of each byte DMAed
> - * MCD_BIT_REV		- reverse the bits of each byte DMAed
> - * MCD_CRC16		- to perform CRC-16 on DMAed data
> - * MCD_CRCCCITT		- to perform CRC-CCITT on DMAed data
> - * MCD_CRC32		- to perform CRC-32 on DMAed data
> - * MCD_CSUMINET		- to perform internet checksums on DMAed data
> - * MCD_NO_CSUM		- to perform no checksumming
> - */
> -#define MCD_NO_BYTE_SWAP	0x00045670
> -#define MCD_BYTE_REVERSE	0x00076540
> -#define MCD_U16_REVERSE		0x00067450
> -#define MCD_U16_BYTE_REVERSE	0x00054760
> -#define MCD_NO_BIT_REV		0x00000000
> -#define MCD_BIT_REV		0x00088880
> -/* CRCing: */
> -#define MCD_CRC16		0xc0100000
> -#define MCD_CRCCCITT		0xc0200000
> -#define MCD_CRC32		0xc0300000
> -#define MCD_CSUMINET		0xc0400000
> -#define MCD_NO_CSUM		0xa0000000
> -
> -#define MCD_FUNC_NOEU1		(MCD_NO_BYTE_SWAP | MCD_NO_BIT_REV | \
> -				 MCD_NO_CSUM)
> -#define MCD_FUNC_NOEU2		(MCD_NO_BYTE_SWAP | MCD_NO_CSUM)
> -
> -/* Constants for the flags parameter */
> -#define MCD_TT_FLAGS_RL		0x00000001	/* Read line */
> -#define MCD_TT_FLAGS_CW		0x00000002	/* Combine Writes */
> -#define MCD_TT_FLAGS_SP		0x00000004	/* MCF547x/548x ONLY  */
> -#define MCD_TT_FLAGS_MASK	0x000000ff
> -#define MCD_TT_FLAGS_DEF	(MCD_TT_FLAGS_RL | MCD_TT_FLAGS_CW)
> -
> -#define MCD_SINGLE_DMA		0x00000100	/* Unchained DMA */
> -#define MCD_CHAIN_DMA		/* TBD */
> -#define MCD_EU_DMA		/* TBD */
> -#define MCD_FECTX_DMA		0x00001000	/* FEC TX ring DMA */
> -#define MCD_FECRX_DMA		0x00002000	/* FEC RX ring DMA */
> -
> -/* these flags are valid for MCD_startDma and the chained buffer descriptors */
> -/*
> - * MCD_BUF_READY	- indicates that this buf is now under the DMA's ctrl
> - * MCD_WRAP		- to tell the FEC Dmas to wrap to the first BD
> - * MCD_INTERRUPT	- to generate an interrupt after completion of the DMA
> - * MCD_END_FRAME	- tell the DMA to end the frame when transferring
> - *			  last byte of data in buffer
> - * MCD_CRC_RESTART	- to empty out the accumulated checksum prior to
> - *			  performing the DMA
> - */
> -#define MCD_BUF_READY		0x80000000
> -#define MCD_WRAP		0x20000000
> -#define MCD_INTERRUPT		0x10000000
> -#define MCD_END_FRAME		0x08000000
> -#define MCD_CRC_RESTART		0x40000000
> -
> -/* Defines for the FEC buffer descriptor control/status word*/
> -#define MCD_FEC_BUF_READY	0x8000
> -#define MCD_FEC_WRAP		0x2000
> -#define MCD_FEC_INTERRUPT	0x1000
> -#define MCD_FEC_END_FRAME	0x0800
> -
> -/* Defines for general intuitiveness */
> -
> -#define MCD_TRUE		1
> -#define MCD_FALSE		0
> -
> -/* Three different cases for destination and source. */
> -#define MINUS1			-1
> -#define ZERO			0
> -#define PLUS1			1
> -
> -#ifndef DEFINESONLY
> -
> -/* Task Table Entry struct*/
> -typedef struct {
> -	u32 TDTstart;		/* task descriptor table start */
> -	u32 TDTend;		/* task descriptor table end */
> -	u32 varTab;		/* variable table start */
> -	u32 FDTandFlags;	/* function descriptor table start & flags */
> -	volatile u32 descAddrAndStatus;
> -	volatile u32 modifiedVarTab;
> -	u32 contextSaveSpace;	/* context save space start */
> -	u32 literalBases;
> -} TaskTableEntry;
> -
> -/* Chained buffer descriptor:
> - * flags	- flags describing the DMA
> - * csumResult	- checksum performed since last checksum reset
> - * srcAddr	- the address to move data from
> - * destAddr	- the address to move data to
> - * lastDestAddr	- the last address written to
> - * dmaSize	- the no of bytes to xfer independent of the xfer sz
> - * next		- next buffer descriptor in chain
> - * info		- private info about this descriptor;  DMA does not affect it
> - */
> -typedef volatile struct MCD_bufDesc_struct MCD_bufDesc;
> -struct MCD_bufDesc_struct {
> -	u32 flags;
> -	u32 csumResult;
> -	s8 *srcAddr;
> -	s8 *destAddr;
> -	s8 *lastDestAddr;
> -	u32 dmaSize;
> -	MCD_bufDesc *next;
> -	u32 info;
> -};
> -
> -/* Progress Query struct:
> - * lastSrcAddr	- the most-recent or last, post-increment source address
> - * lastDestAddr	- the most-recent or last, post-increment destination address
> - * dmaSize	- the amount of data transferred for the current buffer
> - * currBufDesc	- pointer to the current buffer descriptor being DMAed
> - */
> -
> -typedef volatile struct MCD_XferProg_struct {
> -	s8 *lastSrcAddr;
> -	s8 *lastDestAddr;
> -	u32 dmaSize;
> -	MCD_bufDesc *currBufDesc;
> -} MCD_XferProg;
> -
> -/* FEC buffer descriptor */
> -typedef volatile struct MCD_bufDescFec_struct {
> -	u16 statCtrl;
> -	u16 length;
> -	u32 dataPointer;
> -} MCD_bufDescFec;
> -
> -/*************************************************************************/
> -/* API function Prototypes  - see MCD_dmaApi.c for further notes */
> -
> -/* MCD_startDma starts a particular kind of DMA:
> - * srcAddr	- the channel on which to run the DMA
> - * srcIncr	- the address to move data from, or buffer-descriptor address
> - * destAddr	- the amount to increment the source address per transfer
> - * destIncr	- the address to move data to
> - * dmaSize	- the amount to increment the destination address per transfer
> - * xferSize	- the number bytes in of each data movement (1, 2, or 4)
> - * initiator	- what device initiates the DMA
> - * priority	- priority of the DMA
> - * flags	- flags describing the DMA
> - * funcDesc	- description of byte swapping, bit swapping, and CRC actions
> - */
> -int MCD_startDma(int channel, s8 * srcAddr, s16 srcIncr, s8 * destAddr,
> -		 s16 destIncr, u32 dmaSize, u32 xferSize, u32 initiator,
> -		 int priority, u32 flags, u32 funcDesc);
> -
> -/*
> - * MCD_initDma() initializes the DMA API by setting up a pointer to the DMA
> - * registers, relocating and creating the appropriate task structures, and
> - * setting up some global settings
> - */
> -int MCD_initDma(dmaRegs * sDmaBarAddr, void *taskTableDest, u32 flags);
> -
> -/* MCD_dmaStatus() returns the status of the DMA on the requested channel. */
> -int MCD_dmaStatus(int channel);
> -
> -/* MCD_XferProgrQuery() returns progress of DMA on requested channel */
> -int MCD_XferProgrQuery(int channel, MCD_XferProg * progRep);
> -
> -/*
> - * MCD_killDma() halts the DMA on the requested channel, without any
> - * intention of resuming the DMA.
> - */
> -int MCD_killDma(int channel);
> -
> -/*
> - * MCD_continDma() continues a DMA which as stopped due to encountering an
> - * unready buffer descriptor.
> - */
> -int MCD_continDma(int channel);
> -
> -/*
> - * MCD_pauseDma() pauses the DMA on the given channel ( if any DMA is
> - * running on that channel).
> - */
> -int MCD_pauseDma(int channel);
> -
> -/*
> - * MCD_resumeDma() resumes the DMA on a given channel (if any DMA is
> - * running on that channel).
> - */
> -int MCD_resumeDma(int channel);
> -
> -/* MCD_csumQuery provides the checksum/CRC after performing a non-chained DMA */
> -int MCD_csumQuery(int channel, u32 * csum);
> -
> -/*
> - * MCD_getCodeSize provides the packed size required by the microcoded task
> - * and structures.
> - */
> -int MCD_getCodeSize(void);
> -
> -/*
> - * MCD_getVersion provides a pointer to a version string and returns a
> - * version number.
> - */
> -int MCD_getVersion(char **longVersion);
> -
> -/* macro for setting a location in the variable table */
> -#define MCD_SET_VAR(taskTab,idx,value) ((u32 *)(taskTab)->varTab)[idx] = value
> -/* Note that MCD_SET_VAR() is invoked many times in firing up a DMA function,
> -   so I'm avoiding surrounding it with "do {} while(0)" */
> -
> -#endif				/* DEFINESONLY */
> -
> -#endif				/* _MCD_API_H */
> diff --git a/include/MCD_progCheck.h b/include/MCD_progCheck.h
> deleted file mode 100644
> index 1ec8fbfbd284..000000000000
> --- a/include/MCD_progCheck.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> - /* This file is autogenerated. Do not change */
> -#define CURRBD		4
> -#define DCOUNT		6
> -#define DESTPTR		5
> -#define SRCPTR		7
> diff --git a/include/MCD_tasksInit.h b/include/MCD_tasksInit.h
> deleted file mode 100644
> index 9f582beb51a3..000000000000
> --- a/include/MCD_tasksInit.h
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2004-2007 Freescale Semiconductor, Inc.
> - */
> -
> -#ifndef MCD_TSK_INIT_H
> -#define MCD_TSK_INIT_H 1
> -
> -/*
> - * Do not edit!
> - */
> -
> -/* Task 0 */
> -void MCD_startDmaChainNoEu(int *currBD, short srcIncr, short destIncr,
> -			   int xferSize, short xferSizeIncr, int *cSave,
> -			   volatile TaskTableEntry * taskTable, int channel);
> -
> -/* Task 1 */
> -void MCD_startDmaSingleNoEu(char *srcAddr, short srcIncr, char *destAddr,
> -			    short destIncr, int dmaSize, short xferSizeIncr,
> -			    int flags, int *currBD, int *cSave,
> -			    volatile TaskTableEntry * taskTable, int channel);
> -
> -/* Task 2 */
> -void MCD_startDmaChainEu(int *currBD, short srcIncr, short destIncr,
> -			 int xferSize, short xferSizeIncr, int *cSave,
> -			 volatile TaskTableEntry * taskTable, int channel);
> -
> -/* Task 3 */
> -void MCD_startDmaSingleEu(char *srcAddr, short srcIncr, char *destAddr,
> -			  short destIncr, int dmaSize, short xferSizeIncr,
> -			  int flags, int *currBD, int *cSave,
> -			  volatile TaskTableEntry * taskTable, int channel);
> -
> -/* Task 4 */
> -void MCD_startDmaENetRcv(char *bDBase, char *currBD, char *rcvFifoPtr,
> -			 volatile TaskTableEntry * taskTable, int channel);
> -
> -/* Task 5 */
> -void MCD_startDmaENetXmit(char *bDBase, char *currBD, char *xmitFifoPtr,
> -			  volatile TaskTableEntry * taskTable, int channel);
> -
> -#endif				/* MCD_TSK_INIT_H */

-- 
Angelo Dureghello
w: www.kernel-space.org
e: angelo@kernel-space.org
