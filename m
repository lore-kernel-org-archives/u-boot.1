Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14171C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFEC874F4;
	Tue, 31 Oct 2023 07:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AfO5h6Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D246D87AE0; Tue, 31 Oct 2023 07:30:34 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90FC874CE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031063029epoutp0268748099a73ed5da880ce9770abfdd60~THWsC4efh0935809358epoutp02d
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:30:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031063029epoutp0268748099a73ed5da880ce9770abfdd60~THWsC4efh0935809358epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698733829;
 bh=DrL38SodyKfUM0SUyDurVOTGsNZQb4miEZgUn57zJTI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=AfO5h6Z0+mv8drUZ0WQVkmiFaJJl4TqNdQzDT8WKWU6zVPkn0/tU1RNX5ORU2YKL2
 0ANNnfeWJoqD9rytN5OVvWzf3FjOY3vEqPDqJD5sEN+3EPhhHoidmbXNdmzdmc9kG1
 vk0nC2CmTkI/ebF+j004JBbqIYSaIuySWyJc+UOM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231031063029epcas1p2467524a425abb8df12bfab59a568591d~THWr164fs2115321153epcas1p2F;
 Tue, 31 Oct 2023 06:30:29 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKKyD5Jz5z4x9Py; Tue, 31 Oct
 2023 06:30:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D3.9D.09731.40F90456; Tue, 31 Oct 2023 15:30:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031063028epcas1p1bfa0c6a328bd9e70ee5a950381b26fd1~THWqqVnuZ2658226582epcas1p1J;
 Tue, 31 Oct 2023 06:30:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031063028epsmtrp2f09b1e3e7cbc4856434e6b82c8452615~THWqpmznY3172531725epsmtrp2k;
 Tue, 31 Oct 2023 06:30:28 +0000 (GMT)
X-AuditID: b6c32a36-2ef8ea8000002603-cf-65409f045224
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D3.A3.08755.40F90456; Tue, 31 Oct 2023 15:30:28 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031063028epsmtip1685b0106334b203e73efeeb01064dc4d~THWqeDc6F0677806778epsmtip1t;
 Tue, 31 Oct 2023 06:30:28 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Samuel Holland'" <samuel@sholland.org>, <u-boot@lists.denx.de>,
 "'Jagan Teki'" <jagan@amarulasolutions.com>, "'Andre	Przywara'"
 <andre.przywara@arm.com>
Cc: "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20231031052246.63019-2-samuel@sholland.org>
Subject: RE: [PATCH 2/2] sunxi: mmc: Move header to the driver directory
Date: Tue, 31 Oct 2023 15:30:28 +0900
Message-ID: <004601da0bc3$bd389060$37a9b120$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGi1+fgLYv+uHW5gT2lcSTpygHqCgIEqumUAdaDtDywsv4qwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmgS7LfIdUg1ezNCxWzPvJaPFl0wQ2
 ix+rvrBaPH/UyWbxdm8nuwOrx9qP91k91sxbw+hx9s4ORo+N73Ywebz6OpcxgDUq2yYjNTEl
 tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLuSQlliTilQKCCx
 uFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj9KqzzAVN
 ORUvzm9jbmCcE9HFyMEhIWAi0XY5rIuRi0NIYAejxKTXZ9ghnE+MEkveTWWBcL4xSpzd2sDY
 xcgJ1jFh5S9WiMReRokjv+ZDOS+Bqg5+ZAOpYhPQk/i/aCEzSEJEYBGjxPKLE9lBEswCyhIH
 /twGszkFLCV6589hArGFBTwkJnxezQJiswioSjyY/QdsEC9Qzbcnx6BsQYmTM5+wQMyRl9j+
 dg4zxEkKEj+fLmMFsUUEnCT6WpcxQ9SISMzubAM7QkJgIodEy6YOVogGF4nP+15C2cISr45v
 YYewpSQ+v9vLBtHQzCixdMlBVginh1HiX8N1NogqY4n9SyczgcKPWUBTYv0ufYiwosTO33MZ
 ITbzSbz72sMKCWJeiY42IYgSFYlLr18ywey6++Q/6wRGpVlIfpuF5LdZSH6YhbBsASPLKkax
 1ILi3PTUYsMCI3h8J+fnbmIEp00tsx2Mk95+0DvEyMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpR
 fnxRaU5q8SFGU2BoT2SWEk3OBybuvJJ4QxNLAxMzI2MTC0MzQyVx3jmPe1OEBNITS1KzU1ML
 Uotg+pg4OKUamPJL1vBZPny1NKxHX3zzLntXxtoFUdq9SeWn7NYJPJXczjuRMeLrsfvAQP03
 RSDv3q9pC08lb0pW+iX1+ay2YVR+q82h+b3LagxLP4Tp+z289b0v1j5hxy33pc+vqas+Ca3n
 FPlw7cWqxUvlsyYf2FfDnny/9sbKtBsfVh3NnvjJWCQrf9f02xMX79Z+vdr+8X7/HWXLmqcf
 bf61afKX7lVMd1L3LfULjvna9+PUbE8jrYlfWVo0/YOtV16x2t4oKRu3yt264tLyxJr70m/v
 ROg9Lzq1vuF1lWfAx4mXVjMo53fU1LF/Ki+5ElD/etmCInazmH6v+nkbZMUZebjn3Ez13rjD
 Zc2X2e+7Iv9fWqLEUpyRaKjFXFScCACM0/neJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnC7LfIdUg2k/hC1WzPvJaPFl0wQ2
 ix+rvrBaPH/UyWbxdm8nuwOrx9qP91k91sxbw+hx9s4ORo+N73Ywebz6OpcxgDWKyyYlNSez
 LLVI3y6BK+P0qrPMBU05FS/Ob2NuYJwT0cXIySEhYCIxYeUv1i5GLg4hgd2MEmfOnGGBSEhJ
 fH46la2LkQPIFpY4fLgYouY5o8SVbZOZQGrYBPQk/i9ayAySEBFYwiix/OwERpAEs4CyxIE/
 t9khOrYzSlzfOYkdJMEpYCnRO38OWLewgIfEhM+rwbaxCKhKPJj9hw3E5gWq+fbkGJQtKHFy
 5hMWkCuYgba1bYSaLy+x/e0cZohDFSR+Pl3GCmKLCDhJ9LUuY4aoEZGY3dnGPIFReBaSSbMQ
 Js1CMmkWko4FjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY0dLcwfj9lUf9A4x
 MnEwHmKU4GBWEuE9bOqQKsSbklhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFq
 EUyWiYNTqoGJt/mz7QIer12BL24k2TVkfNr48nzSqxnMpVxf5acnTDv6n3fDjy+CL/e2vzN/
 db0g6IbFtrP2PX0/PwTorb0w3yp/4zexFduqPZU8mi5/b5rxkkeDv7S7b29/zIerU3Ydfn5t
 Vs6PE59vHVB+a/T84O85PFFvjEINw7Ztlvw6Z4HD4vfuclGyFdycu5fylsUvbMlbyPTUZONH
 zhBWWSsRvTd9Zd7CM1z71kw89u8mx7XIaWJv2sweMslaHGTf57Die8iE3atX3hKtPLnZ2fw4
 95StR9rK2tmW23yYlvs5YmX/qzla116fCnvfkyNX0qq792yn0eQjfFce3HVayjK7aH/StVM/
 D8yetES0Yt7a/FQlluKMREMt5qLiRADGmHZPDAMAAA==
X-CMS-MailID: 20231031063028epcas1p1bfa0c6a328bd9e70ee5a950381b26fd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031052255epcas1p2bf144204549e85a3d5be685ca2b743c2
References: <20231031052246.63019-1-samuel@sholland.org>
 <CGME20231031052255epcas1p2bf144204549e85a3d5be685ca2b743c2@epcas1p2.samsung.com>
 <20231031052246.63019-2-samuel@sholland.org>
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



> -----Original Message-----
> From: Samuel Holland <samuel@sholland.org>
> Sent: Tuesday, October 31, 2023 2:23 PM
> To: u-boot@lists.denx.de; Jagan Teki <jagan@amarulasolutions.com>; Andre Przywara
> <andre.przywara@arm.com>
> Cc: Samuel Holland <samuel@sholland.org>; Jaehoon Chung <jh80.chung@samsung.com>; Peng Fan
> <peng.fan@nxp.com>
> Subject: [PATCH 2/2] sunxi: mmc: Move header to the driver directory
> 
> The MMC controller driver is (and ought to be) the only user of these
> register definitions. Put them in a header next to the driver to remove
> the dependency on a specific ARM platform's headers.
> 
> Due to the sunxi_mmc_init() prototype, the file was not renamed. None of
> the register definitions were changed.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  arch/arm/include/asm/arch-sunxi/mmc.h | 139 +-------------------------
>  drivers/mmc/sunxi_mmc.c               |   4 +
>  drivers/mmc/sunxi_mmc.h               | 138 +++++++++++++++++++++++++
>  3 files changed, 146 insertions(+), 135 deletions(-)
>  create mode 100644 drivers/mmc/sunxi_mmc.h
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/asm/arch-sunxi/mmc.h
> index 8ed3e0459c9..b8d91b5c64b 100644
> --- a/arch/arm/include/asm/arch-sunxi/mmc.h
> +++ b/arch/arm/include/asm/arch-sunxi/mmc.h
> @@ -1,139 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * (C) Copyright 2007-2011
> - * Allwinner Technology Co., Ltd. <https://protect2.fireeye.com/v1/url?k=4cb2b925-2d39ac0a-4cb3326a-
> 74fe485cbfe7-043aa1e18727af33&q=1&e=c27b74b1-be1d-4124-b8c0-
> 7d4a5f8076a3&u=http%3A%2F%2Fwww.allwinnertech.com%2F>
> - * Aaron <leafy.myeh@allwinnertech.com>
> - *
> - * MMC register definition for allwinner sunxi platform.
> - */
> 
> -#ifndef _SUNXI_MMC_H
> -#define _SUNXI_MMC_H
> -
> -#include <linux/types.h>
> -
> -struct sunxi_mmc {
> -	u32 gctrl;		/* 0x00 global control */
> -	u32 clkcr;		/* 0x04 clock control */
> -	u32 timeout;		/* 0x08 time out */
> -	u32 width;		/* 0x0c bus width */
> -	u32 blksz;		/* 0x10 block size */
> -	u32 bytecnt;		/* 0x14 byte count */
> -	u32 cmd;		/* 0x18 command */
> -	u32 arg;		/* 0x1c argument */
> -	u32 resp0;		/* 0x20 response 0 */
> -	u32 resp1;		/* 0x24 response 1 */
> -	u32 resp2;		/* 0x28 response 2 */
> -	u32 resp3;		/* 0x2c response 3 */
> -	u32 imask;		/* 0x30 interrupt mask */
> -	u32 mint;		/* 0x34 masked interrupt status */
> -	u32 rint;		/* 0x38 raw interrupt status */
> -	u32 status;		/* 0x3c status */
> -	u32 ftrglevel;		/* 0x40 FIFO threshold watermark*/
> -	u32 funcsel;		/* 0x44 function select */
> -	u32 cbcr;		/* 0x48 CIU byte count */
> -	u32 bbcr;		/* 0x4c BIU byte count */
> -	u32 dbgc;		/* 0x50 debug enable */
> -	u32 res0;		/* 0x54 reserved */
> -	u32 a12a;		/* 0x58 Auto command 12 argument */
> -	u32 ntsr;		/* 0x5c	New timing set register */
> -	u32 res1[8];
> -	u32 dmac;		/* 0x80 internal DMA control */
> -	u32 dlba;		/* 0x84 internal DMA descr list base address */
> -	u32 idst;		/* 0x88 internal DMA status */
> -	u32 idie;		/* 0x8c internal DMA interrupt enable */
> -	u32 chda;		/* 0x90 */
> -	u32 cbda;		/* 0x94 */
> -	u32 res2[26];
> -#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) ||
> defined(CONFIG_SUNXI_GEN_NCAT2)
> -	u32 res3[17];
> -	u32 samp_dl;
> -	u32 res4[46];
> -#endif
> -	u32 fifo;		/* 0x100 / 0x200 FIFO access address */
> -};
> -
> -#define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
> -#define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
> -#define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
> -
> -#define SUNXI_MMC_GCTRL_SOFT_RESET	(0x1 << 0)
> -#define SUNXI_MMC_GCTRL_FIFO_RESET	(0x1 << 1)
> -#define SUNXI_MMC_GCTRL_DMA_RESET	(0x1 << 2)
> -#define SUNXI_MMC_GCTRL_RESET		(SUNXI_MMC_GCTRL_SOFT_RESET|\
> -					 SUNXI_MMC_GCTRL_FIFO_RESET|\
> -					 SUNXI_MMC_GCTRL_DMA_RESET)
> -#define SUNXI_MMC_GCTRL_DMA_ENABLE	(0x1 << 5)
> -#define SUNXI_MMC_GCTRL_ACCESS_BY_AHB   (0x1 << 31)
> -
> -#define SUNXI_MMC_CMD_RESP_EXPIRE	(0x1 << 6)
> -#define SUNXI_MMC_CMD_LONG_RESPONSE	(0x1 << 7)
> -#define SUNXI_MMC_CMD_CHK_RESPONSE_CRC	(0x1 << 8)
> -#define SUNXI_MMC_CMD_DATA_EXPIRE	(0x1 << 9)
> -#define SUNXI_MMC_CMD_WRITE		(0x1 << 10)
> -#define SUNXI_MMC_CMD_AUTO_STOP		(0x1 << 12)
> -#define SUNXI_MMC_CMD_WAIT_PRE_OVER	(0x1 << 13)
> -#define SUNXI_MMC_CMD_SEND_INIT_SEQ	(0x1 << 15)
> -#define SUNXI_MMC_CMD_UPCLK_ONLY	(0x1 << 21)
> -#define SUNXI_MMC_CMD_START		(0x1 << 31)
> -
> -#define SUNXI_MMC_RINT_RESP_ERROR		(0x1 << 1)
> -#define SUNXI_MMC_RINT_COMMAND_DONE		(0x1 << 2)
> -#define SUNXI_MMC_RINT_DATA_OVER		(0x1 << 3)
> -#define SUNXI_MMC_RINT_TX_DATA_REQUEST		(0x1 << 4)
> -#define SUNXI_MMC_RINT_RX_DATA_REQUEST		(0x1 << 5)
> -#define SUNXI_MMC_RINT_RESP_CRC_ERROR		(0x1 << 6)
> -#define SUNXI_MMC_RINT_DATA_CRC_ERROR		(0x1 << 7)
> -#define SUNXI_MMC_RINT_RESP_TIMEOUT		(0x1 << 8)
> -#define SUNXI_MMC_RINT_DATA_TIMEOUT		(0x1 << 9)
> -#define SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE	(0x1 << 10)
> -#define SUNXI_MMC_RINT_FIFO_RUN_ERROR		(0x1 << 11)
> -#define SUNXI_MMC_RINT_HARD_WARE_LOCKED		(0x1 << 12)
> -#define SUNXI_MMC_RINT_START_BIT_ERROR		(0x1 << 13)
> -#define SUNXI_MMC_RINT_AUTO_COMMAND_DONE	(0x1 << 14)
> -#define SUNXI_MMC_RINT_END_BIT_ERROR		(0x1 << 15)
> -#define SUNXI_MMC_RINT_SDIO_INTERRUPT		(0x1 << 16)
> -#define SUNXI_MMC_RINT_CARD_INSERT		(0x1 << 30)
> -#define SUNXI_MMC_RINT_CARD_REMOVE		(0x1 << 31)
> -#define SUNXI_MMC_RINT_INTERRUPT_ERROR_BIT      \
> -	(SUNXI_MMC_RINT_RESP_ERROR |		\
> -	 SUNXI_MMC_RINT_RESP_CRC_ERROR |	\
> -	 SUNXI_MMC_RINT_DATA_CRC_ERROR |	\
> -	 SUNXI_MMC_RINT_RESP_TIMEOUT |		\
> -	 SUNXI_MMC_RINT_DATA_TIMEOUT |		\
> -	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE |	\
> -	 SUNXI_MMC_RINT_FIFO_RUN_ERROR |	\
> -	 SUNXI_MMC_RINT_HARD_WARE_LOCKED |	\
> -	 SUNXI_MMC_RINT_START_BIT_ERROR |	\
> -	 SUNXI_MMC_RINT_END_BIT_ERROR) /* 0xbfc2 */
> -#define SUNXI_MMC_RINT_INTERRUPT_DONE_BIT	\
> -	(SUNXI_MMC_RINT_AUTO_COMMAND_DONE |	\
> -	 SUNXI_MMC_RINT_DATA_OVER |		\
> -	 SUNXI_MMC_RINT_COMMAND_DONE |		\
> -	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE)
> -
> -#define SUNXI_MMC_STATUS_RXWL_FLAG		(0x1 << 0)
> -#define SUNXI_MMC_STATUS_TXWL_FLAG		(0x1 << 1)
> -#define SUNXI_MMC_STATUS_FIFO_EMPTY		(0x1 << 2)
> -#define SUNXI_MMC_STATUS_FIFO_FULL		(0x1 << 3)
> -#define SUNXI_MMC_STATUS_CARD_PRESENT		(0x1 << 8)
> -#define SUNXI_MMC_STATUS_CARD_DATA_BUSY		(0x1 << 9)
> -#define SUNXI_MMC_STATUS_DATA_FSM_BUSY		(0x1 << 10)
> -#define SUNXI_MMC_STATUS_FIFO_LEVEL(reg)	(((reg) >> 17) & 0x3fff)
> -
> -#define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
> -
> -#define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
> -#define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
> -#define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
> -
> -#define SUNXI_MMC_IDIE_TXIRQ		(0x1 << 0)
> -#define SUNXI_MMC_IDIE_RXIRQ		(0x1 << 1)
> -
> -#define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
> -#define SUNXI_MMC_COMMON_RESET			(1 << 18)
> -
> -#define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
> +#ifndef _ASM_ARCH_MMC_H_
> +#define _ASM_ARCH_MMC_H_
> 
>  struct mmc *sunxi_mmc_init(int sdc_no);
> -#endif /* _SUNXI_MMC_H */
> +
> +#endif /* _ASM_ARCH_MMC_H_ */
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 7caefa153dc..714706d2411 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -25,10 +25,14 @@
>  #include <asm/io.h>
>  #include <asm/arch/clock.h>
>  #include <asm/arch/cpu.h>
> +#if !CONFIG_IS_ENABLED(DM_MMC)
>  #include <asm/arch/mmc.h>
> +#endif
>  #include <linux/delay.h>
>  #include <sunxi_gpio.h>
> 
> +#include "sunxi_mmc.h"
> +
>  #ifndef CCM_MMC_CTRL_MODE_SEL_NEW
>  #define CCM_MMC_CTRL_MODE_SEL_NEW	0
>  #endif
> diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
> new file mode 100644
> index 00000000000..f4ae5a790c8
> --- /dev/null
> +++ b/drivers/mmc/sunxi_mmc.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2007-2011
> + * Allwinner Technology Co., Ltd. <https://protect2.fireeye.com/v1/url?k=31fd542e-50764101-31fcdf61-
> 74fe485cbfe7-6b37535e8d2e0d96&q=1&e=c27b74b1-be1d-4124-b8c0-
> 7d4a5f8076a3&u=http%3A%2F%2Fwww.allwinnertech.com%2F>
> + * Aaron <leafy.myeh@allwinnertech.com>
> + *
> + * MMC register definition for allwinner sunxi platform.
> + */
> +
> +#ifndef _SUNXI_MMC_H
> +#define _SUNXI_MMC_H
> +
> +#include <linux/types.h>
> +
> +struct sunxi_mmc {
> +	u32 gctrl;		/* 0x00 global control */
> +	u32 clkcr;		/* 0x04 clock control */
> +	u32 timeout;		/* 0x08 time out */
> +	u32 width;		/* 0x0c bus width */
> +	u32 blksz;		/* 0x10 block size */
> +	u32 bytecnt;		/* 0x14 byte count */
> +	u32 cmd;		/* 0x18 command */
> +	u32 arg;		/* 0x1c argument */
> +	u32 resp0;		/* 0x20 response 0 */
> +	u32 resp1;		/* 0x24 response 1 */
> +	u32 resp2;		/* 0x28 response 2 */
> +	u32 resp3;		/* 0x2c response 3 */
> +	u32 imask;		/* 0x30 interrupt mask */
> +	u32 mint;		/* 0x34 masked interrupt status */
> +	u32 rint;		/* 0x38 raw interrupt status */
> +	u32 status;		/* 0x3c status */
> +	u32 ftrglevel;		/* 0x40 FIFO threshold watermark*/
> +	u32 funcsel;		/* 0x44 function select */
> +	u32 cbcr;		/* 0x48 CIU byte count */
> +	u32 bbcr;		/* 0x4c BIU byte count */
> +	u32 dbgc;		/* 0x50 debug enable */
> +	u32 res0;		/* 0x54 reserved */
> +	u32 a12a;		/* 0x58 Auto command 12 argument */
> +	u32 ntsr;		/* 0x5c	New timing set register */
> +	u32 res1[8];
> +	u32 dmac;		/* 0x80 internal DMA control */
> +	u32 dlba;		/* 0x84 internal DMA descr list base address */
> +	u32 idst;		/* 0x88 internal DMA status */
> +	u32 idie;		/* 0x8c internal DMA interrupt enable */
> +	u32 chda;		/* 0x90 */
> +	u32 cbda;		/* 0x94 */
> +	u32 res2[26];
> +#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) ||
> defined(CONFIG_SUNXI_GEN_NCAT2)
> +	u32 res3[17];
> +	u32 samp_dl;
> +	u32 res4[46];
> +#endif
> +	u32 fifo;		/* 0x100 / 0x200 FIFO access address */
> +};
> +
> +#define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
> +#define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
> +#define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
> +
> +#define SUNXI_MMC_GCTRL_SOFT_RESET	(0x1 << 0)
> +#define SUNXI_MMC_GCTRL_FIFO_RESET	(0x1 << 1)
> +#define SUNXI_MMC_GCTRL_DMA_RESET	(0x1 << 2)
> +#define SUNXI_MMC_GCTRL_RESET		(SUNXI_MMC_GCTRL_SOFT_RESET|\
> +					 SUNXI_MMC_GCTRL_FIFO_RESET|\
> +					 SUNXI_MMC_GCTRL_DMA_RESET)
> +#define SUNXI_MMC_GCTRL_DMA_ENABLE	(0x1 << 5)
> +#define SUNXI_MMC_GCTRL_ACCESS_BY_AHB   (0x1 << 31)
> +
> +#define SUNXI_MMC_CMD_RESP_EXPIRE	(0x1 << 6)
> +#define SUNXI_MMC_CMD_LONG_RESPONSE	(0x1 << 7)
> +#define SUNXI_MMC_CMD_CHK_RESPONSE_CRC	(0x1 << 8)
> +#define SUNXI_MMC_CMD_DATA_EXPIRE	(0x1 << 9)
> +#define SUNXI_MMC_CMD_WRITE		(0x1 << 10)
> +#define SUNXI_MMC_CMD_AUTO_STOP		(0x1 << 12)
> +#define SUNXI_MMC_CMD_WAIT_PRE_OVER	(0x1 << 13)
> +#define SUNXI_MMC_CMD_SEND_INIT_SEQ	(0x1 << 15)
> +#define SUNXI_MMC_CMD_UPCLK_ONLY	(0x1 << 21)
> +#define SUNXI_MMC_CMD_START		(0x1 << 31)
> +
> +#define SUNXI_MMC_RINT_RESP_ERROR		(0x1 << 1)
> +#define SUNXI_MMC_RINT_COMMAND_DONE		(0x1 << 2)
> +#define SUNXI_MMC_RINT_DATA_OVER		(0x1 << 3)
> +#define SUNXI_MMC_RINT_TX_DATA_REQUEST		(0x1 << 4)
> +#define SUNXI_MMC_RINT_RX_DATA_REQUEST		(0x1 << 5)
> +#define SUNXI_MMC_RINT_RESP_CRC_ERROR		(0x1 << 6)
> +#define SUNXI_MMC_RINT_DATA_CRC_ERROR		(0x1 << 7)
> +#define SUNXI_MMC_RINT_RESP_TIMEOUT		(0x1 << 8)
> +#define SUNXI_MMC_RINT_DATA_TIMEOUT		(0x1 << 9)
> +#define SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE	(0x1 << 10)
> +#define SUNXI_MMC_RINT_FIFO_RUN_ERROR		(0x1 << 11)
> +#define SUNXI_MMC_RINT_HARD_WARE_LOCKED		(0x1 << 12)
> +#define SUNXI_MMC_RINT_START_BIT_ERROR		(0x1 << 13)
> +#define SUNXI_MMC_RINT_AUTO_COMMAND_DONE	(0x1 << 14)
> +#define SUNXI_MMC_RINT_END_BIT_ERROR		(0x1 << 15)
> +#define SUNXI_MMC_RINT_SDIO_INTERRUPT		(0x1 << 16)
> +#define SUNXI_MMC_RINT_CARD_INSERT		(0x1 << 30)
> +#define SUNXI_MMC_RINT_CARD_REMOVE		(0x1 << 31)
> +#define SUNXI_MMC_RINT_INTERRUPT_ERROR_BIT      \
> +	(SUNXI_MMC_RINT_RESP_ERROR |		\
> +	 SUNXI_MMC_RINT_RESP_CRC_ERROR |	\
> +	 SUNXI_MMC_RINT_DATA_CRC_ERROR |	\
> +	 SUNXI_MMC_RINT_RESP_TIMEOUT |		\
> +	 SUNXI_MMC_RINT_DATA_TIMEOUT |		\
> +	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE |	\
> +	 SUNXI_MMC_RINT_FIFO_RUN_ERROR |	\
> +	 SUNXI_MMC_RINT_HARD_WARE_LOCKED |	\
> +	 SUNXI_MMC_RINT_START_BIT_ERROR |	\
> +	 SUNXI_MMC_RINT_END_BIT_ERROR) /* 0xbfc2 */
> +#define SUNXI_MMC_RINT_INTERRUPT_DONE_BIT	\
> +	(SUNXI_MMC_RINT_AUTO_COMMAND_DONE |	\
> +	 SUNXI_MMC_RINT_DATA_OVER |		\
> +	 SUNXI_MMC_RINT_COMMAND_DONE |		\
> +	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE)
> +
> +#define SUNXI_MMC_STATUS_RXWL_FLAG		(0x1 << 0)
> +#define SUNXI_MMC_STATUS_TXWL_FLAG		(0x1 << 1)
> +#define SUNXI_MMC_STATUS_FIFO_EMPTY		(0x1 << 2)
> +#define SUNXI_MMC_STATUS_FIFO_FULL		(0x1 << 3)
> +#define SUNXI_MMC_STATUS_CARD_PRESENT		(0x1 << 8)
> +#define SUNXI_MMC_STATUS_CARD_DATA_BUSY		(0x1 << 9)
> +#define SUNXI_MMC_STATUS_DATA_FSM_BUSY		(0x1 << 10)
> +#define SUNXI_MMC_STATUS_FIFO_LEVEL(reg)	(((reg) >> 17) & 0x3fff)
> +
> +#define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
> +
> +#define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
> +#define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
> +#define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
> +
> +#define SUNXI_MMC_IDIE_TXIRQ		(0x1 << 0)
> +#define SUNXI_MMC_IDIE_RXIRQ		(0x1 << 1)
> +
> +#define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
> +#define SUNXI_MMC_COMMON_RESET			(1 << 18)
> +
> +#define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
> +
> +#endif /* _SUNXI_MMC_H */
> --
> 2.41.0


