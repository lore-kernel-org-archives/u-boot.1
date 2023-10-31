Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D986C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08EB87A40;
	Tue, 31 Oct 2023 06:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="RNLiJBN7";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/4rBpmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D25A87033; Tue, 31 Oct 2023 06:22:55 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFCF87033
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id CA98F32009EF;
 Tue, 31 Oct 2023 01:22:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 31 Oct 2023 01:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698729770; x=
 1698816170; bh=NYbYluojBwiMpWq4ChNzzENNcsfnBczuyYxQWQCuWnA=; b=R
 NLiJBN7/ZUY6HLbum8IR8FAa3XgP09YAWzmYg2eraFXoZF0x+Rlr0fuahWA6ztGv
 /IGEZ8ScnN7xToTZbkNEtjWtv64fdnzIH9prUpAleJ6zQFeUJeiwnu3Q+r1PcBTu
 ivGBNx23aZjsXAyXQ6Z18L/FdiY7PZ4ByaxDswJJeXK4gRv4sXJC+3ij+4GgHaOh
 klLYKKLVpA6bSN/zAC3P/wpkJ2JjHvSKYmQEjiy7U6lwIsvM9qnKB9ndcizqEL56
 smcirn2PDHI6OlfOPfqR7pNkyLGOYRzhfeA3X2L2sdUazQVOX5I6rZ7c0Itp9T78
 WXQf4skHUbtdWwxLAqezw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698729770; x=
 1698816170; bh=NYbYluojBwiMpWq4ChNzzENNcsfnBczuyYxQWQCuWnA=; b=E
 /4rBpmAEKASgT4ihgxURWOqEKSzHFE5wpM7o+5juHJIkI5RNsIr2mCwFd7Ck2CZH
 GS9Nky3Gpgk5AkOzEKB5YSSIn3r9v1uDBxN55c8KiqYpcTiDtBHnR0Su7eixcAnO
 D3TzsUQYVf/EwN3gs8+GqmLzxd3ztkdRBfsGkWY4i3FRal6krTS1duCwt987KWza
 80223xR1OarcypwS835SaILUAEbPy+5uV1ZpNqQRUvJm8ewvCspL65EQvwM5DBxj
 4Fn5uqs8m9SgmPxGp9wGtKXbi3oCq1TwpPuGgLU26v7f0cSc741lqWyJsxcF0cYv
 Pb9QUpgYZG3od9e1teowg==
X-ME-Sender: <xms:Ko9AZdeKg0259niKEj-mWwWB6UziGjam5hQ_NfKr5kHF_mxQLk88-w>
 <xme:Ko9AZbNj6ecdXaa-P_oATLxBZLZFmw95DkUHxmykzg6EARyiikghOLRBbNok1DvIb
 VPfaOT3CpeaOb0hPg>
X-ME-Received: <xmr:Ko9AZWidVojskluVzvcdVxceJByBSxK0PHtcaphYm1Z3kTEgHmQF3QHfweOkyGBsGIc2mhRYIh-dW9kEzwKpFo-KiEfN4hTle3vmo5qHJXu58j55aMMl0NMPqR1z8bxvQPQ-GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepgeelgeekfeevvddvtefgvefhvedvhedtueeltddukeekvddtueei
 leeugfejveefnecuffhomhgrihhnpegrlhhlfihinhhnvghrthgvtghhrdgtohhmnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
 sehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Ko9AZW_hD2_96Ctxkdk1mWtmRqatSxjnUo0PX0By2BS01mFjOyEM3w>
 <xmx:Ko9AZZt65N4KBujYPTPY6FdZDkhOZ1zctsVn8vFYe4DckK9toVLvzA>
 <xmx:Ko9AZVESOh8ACwOKH4W9oOMzVS36V4PyZFCV1lq6J6ZdHj3VT7g9sQ>
 <xmx:Ko9AZTIQO38z8xFCnUsVpqbu_gCBswBfZJjo0IPPUFgVYVXIzxjpOQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:22:49 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] sunxi: mmc: Move header to the driver directory
Date: Tue, 31 Oct 2023 00:22:35 -0500
Message-ID: <20231031052246.63019-2-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031052246.63019-1-samuel@sholland.org>
References: <20231031052246.63019-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The MMC controller driver is (and ought to be) the only user of these
register definitions. Put them in a header next to the driver to remove
the dependency on a specific ARM platform's headers.

Due to the sunxi_mmc_init() prototype, the file was not renamed. None of
the register definitions were changed.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/include/asm/arch-sunxi/mmc.h | 139 +-------------------------
 drivers/mmc/sunxi_mmc.c               |   4 +
 drivers/mmc/sunxi_mmc.h               | 138 +++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 135 deletions(-)
 create mode 100644 drivers/mmc/sunxi_mmc.h

diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/asm/arch-sunxi/mmc.h
index 8ed3e0459c9..b8d91b5c64b 100644
--- a/arch/arm/include/asm/arch-sunxi/mmc.h
+++ b/arch/arm/include/asm/arch-sunxi/mmc.h
@@ -1,139 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2007-2011
- * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
- * Aaron <leafy.myeh@allwinnertech.com>
- *
- * MMC register definition for allwinner sunxi platform.
- */
 
-#ifndef _SUNXI_MMC_H
-#define _SUNXI_MMC_H
-
-#include <linux/types.h>
-
-struct sunxi_mmc {
-	u32 gctrl;		/* 0x00 global control */
-	u32 clkcr;		/* 0x04 clock control */
-	u32 timeout;		/* 0x08 time out */
-	u32 width;		/* 0x0c bus width */
-	u32 blksz;		/* 0x10 block size */
-	u32 bytecnt;		/* 0x14 byte count */
-	u32 cmd;		/* 0x18 command */
-	u32 arg;		/* 0x1c argument */
-	u32 resp0;		/* 0x20 response 0 */
-	u32 resp1;		/* 0x24 response 1 */
-	u32 resp2;		/* 0x28 response 2 */
-	u32 resp3;		/* 0x2c response 3 */
-	u32 imask;		/* 0x30 interrupt mask */
-	u32 mint;		/* 0x34 masked interrupt status */
-	u32 rint;		/* 0x38 raw interrupt status */
-	u32 status;		/* 0x3c status */
-	u32 ftrglevel;		/* 0x40 FIFO threshold watermark*/
-	u32 funcsel;		/* 0x44 function select */
-	u32 cbcr;		/* 0x48 CIU byte count */
-	u32 bbcr;		/* 0x4c BIU byte count */
-	u32 dbgc;		/* 0x50 debug enable */
-	u32 res0;		/* 0x54 reserved */
-	u32 a12a;		/* 0x58 Auto command 12 argument */
-	u32 ntsr;		/* 0x5c	New timing set register */
-	u32 res1[8];
-	u32 dmac;		/* 0x80 internal DMA control */
-	u32 dlba;		/* 0x84 internal DMA descr list base address */
-	u32 idst;		/* 0x88 internal DMA status */
-	u32 idie;		/* 0x8c internal DMA interrupt enable */
-	u32 chda;		/* 0x90 */
-	u32 cbda;		/* 0x94 */
-	u32 res2[26];
-#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
-	u32 res3[17];
-	u32 samp_dl;
-	u32 res4[46];
-#endif
-	u32 fifo;		/* 0x100 / 0x200 FIFO access address */
-};
-
-#define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
-#define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
-#define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
-
-#define SUNXI_MMC_GCTRL_SOFT_RESET	(0x1 << 0)
-#define SUNXI_MMC_GCTRL_FIFO_RESET	(0x1 << 1)
-#define SUNXI_MMC_GCTRL_DMA_RESET	(0x1 << 2)
-#define SUNXI_MMC_GCTRL_RESET		(SUNXI_MMC_GCTRL_SOFT_RESET|\
-					 SUNXI_MMC_GCTRL_FIFO_RESET|\
-					 SUNXI_MMC_GCTRL_DMA_RESET)
-#define SUNXI_MMC_GCTRL_DMA_ENABLE	(0x1 << 5)
-#define SUNXI_MMC_GCTRL_ACCESS_BY_AHB   (0x1 << 31)
-
-#define SUNXI_MMC_CMD_RESP_EXPIRE	(0x1 << 6)
-#define SUNXI_MMC_CMD_LONG_RESPONSE	(0x1 << 7)
-#define SUNXI_MMC_CMD_CHK_RESPONSE_CRC	(0x1 << 8)
-#define SUNXI_MMC_CMD_DATA_EXPIRE	(0x1 << 9)
-#define SUNXI_MMC_CMD_WRITE		(0x1 << 10)
-#define SUNXI_MMC_CMD_AUTO_STOP		(0x1 << 12)
-#define SUNXI_MMC_CMD_WAIT_PRE_OVER	(0x1 << 13)
-#define SUNXI_MMC_CMD_SEND_INIT_SEQ	(0x1 << 15)
-#define SUNXI_MMC_CMD_UPCLK_ONLY	(0x1 << 21)
-#define SUNXI_MMC_CMD_START		(0x1 << 31)
-
-#define SUNXI_MMC_RINT_RESP_ERROR		(0x1 << 1)
-#define SUNXI_MMC_RINT_COMMAND_DONE		(0x1 << 2)
-#define SUNXI_MMC_RINT_DATA_OVER		(0x1 << 3)
-#define SUNXI_MMC_RINT_TX_DATA_REQUEST		(0x1 << 4)
-#define SUNXI_MMC_RINT_RX_DATA_REQUEST		(0x1 << 5)
-#define SUNXI_MMC_RINT_RESP_CRC_ERROR		(0x1 << 6)
-#define SUNXI_MMC_RINT_DATA_CRC_ERROR		(0x1 << 7)
-#define SUNXI_MMC_RINT_RESP_TIMEOUT		(0x1 << 8)
-#define SUNXI_MMC_RINT_DATA_TIMEOUT		(0x1 << 9)
-#define SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE	(0x1 << 10)
-#define SUNXI_MMC_RINT_FIFO_RUN_ERROR		(0x1 << 11)
-#define SUNXI_MMC_RINT_HARD_WARE_LOCKED		(0x1 << 12)
-#define SUNXI_MMC_RINT_START_BIT_ERROR		(0x1 << 13)
-#define SUNXI_MMC_RINT_AUTO_COMMAND_DONE	(0x1 << 14)
-#define SUNXI_MMC_RINT_END_BIT_ERROR		(0x1 << 15)
-#define SUNXI_MMC_RINT_SDIO_INTERRUPT		(0x1 << 16)
-#define SUNXI_MMC_RINT_CARD_INSERT		(0x1 << 30)
-#define SUNXI_MMC_RINT_CARD_REMOVE		(0x1 << 31)
-#define SUNXI_MMC_RINT_INTERRUPT_ERROR_BIT      \
-	(SUNXI_MMC_RINT_RESP_ERROR |		\
-	 SUNXI_MMC_RINT_RESP_CRC_ERROR |	\
-	 SUNXI_MMC_RINT_DATA_CRC_ERROR |	\
-	 SUNXI_MMC_RINT_RESP_TIMEOUT |		\
-	 SUNXI_MMC_RINT_DATA_TIMEOUT |		\
-	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE |	\
-	 SUNXI_MMC_RINT_FIFO_RUN_ERROR |	\
-	 SUNXI_MMC_RINT_HARD_WARE_LOCKED |	\
-	 SUNXI_MMC_RINT_START_BIT_ERROR |	\
-	 SUNXI_MMC_RINT_END_BIT_ERROR) /* 0xbfc2 */
-#define SUNXI_MMC_RINT_INTERRUPT_DONE_BIT	\
-	(SUNXI_MMC_RINT_AUTO_COMMAND_DONE |	\
-	 SUNXI_MMC_RINT_DATA_OVER |		\
-	 SUNXI_MMC_RINT_COMMAND_DONE |		\
-	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE)
-
-#define SUNXI_MMC_STATUS_RXWL_FLAG		(0x1 << 0)
-#define SUNXI_MMC_STATUS_TXWL_FLAG		(0x1 << 1)
-#define SUNXI_MMC_STATUS_FIFO_EMPTY		(0x1 << 2)
-#define SUNXI_MMC_STATUS_FIFO_FULL		(0x1 << 3)
-#define SUNXI_MMC_STATUS_CARD_PRESENT		(0x1 << 8)
-#define SUNXI_MMC_STATUS_CARD_DATA_BUSY		(0x1 << 9)
-#define SUNXI_MMC_STATUS_DATA_FSM_BUSY		(0x1 << 10)
-#define SUNXI_MMC_STATUS_FIFO_LEVEL(reg)	(((reg) >> 17) & 0x3fff)
-
-#define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
-
-#define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
-#define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
-#define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
-
-#define SUNXI_MMC_IDIE_TXIRQ		(0x1 << 0)
-#define SUNXI_MMC_IDIE_RXIRQ		(0x1 << 1)
-
-#define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
-#define SUNXI_MMC_COMMON_RESET			(1 << 18)
-
-#define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
+#ifndef _ASM_ARCH_MMC_H_
+#define _ASM_ARCH_MMC_H_
 
 struct mmc *sunxi_mmc_init(int sdc_no);
-#endif /* _SUNXI_MMC_H */
+
+#endif /* _ASM_ARCH_MMC_H_ */
diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 7caefa153dc..714706d2411 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -25,10 +25,14 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/cpu.h>
+#if !CONFIG_IS_ENABLED(DM_MMC)
 #include <asm/arch/mmc.h>
+#endif
 #include <linux/delay.h>
 #include <sunxi_gpio.h>
 
+#include "sunxi_mmc.h"
+
 #ifndef CCM_MMC_CTRL_MODE_SEL_NEW
 #define CCM_MMC_CTRL_MODE_SEL_NEW	0
 #endif
diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
new file mode 100644
index 00000000000..f4ae5a790c8
--- /dev/null
+++ b/drivers/mmc/sunxi_mmc.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2007-2011
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ * Aaron <leafy.myeh@allwinnertech.com>
+ *
+ * MMC register definition for allwinner sunxi platform.
+ */
+
+#ifndef _SUNXI_MMC_H
+#define _SUNXI_MMC_H
+
+#include <linux/types.h>
+
+struct sunxi_mmc {
+	u32 gctrl;		/* 0x00 global control */
+	u32 clkcr;		/* 0x04 clock control */
+	u32 timeout;		/* 0x08 time out */
+	u32 width;		/* 0x0c bus width */
+	u32 blksz;		/* 0x10 block size */
+	u32 bytecnt;		/* 0x14 byte count */
+	u32 cmd;		/* 0x18 command */
+	u32 arg;		/* 0x1c argument */
+	u32 resp0;		/* 0x20 response 0 */
+	u32 resp1;		/* 0x24 response 1 */
+	u32 resp2;		/* 0x28 response 2 */
+	u32 resp3;		/* 0x2c response 3 */
+	u32 imask;		/* 0x30 interrupt mask */
+	u32 mint;		/* 0x34 masked interrupt status */
+	u32 rint;		/* 0x38 raw interrupt status */
+	u32 status;		/* 0x3c status */
+	u32 ftrglevel;		/* 0x40 FIFO threshold watermark*/
+	u32 funcsel;		/* 0x44 function select */
+	u32 cbcr;		/* 0x48 CIU byte count */
+	u32 bbcr;		/* 0x4c BIU byte count */
+	u32 dbgc;		/* 0x50 debug enable */
+	u32 res0;		/* 0x54 reserved */
+	u32 a12a;		/* 0x58 Auto command 12 argument */
+	u32 ntsr;		/* 0x5c	New timing set register */
+	u32 res1[8];
+	u32 dmac;		/* 0x80 internal DMA control */
+	u32 dlba;		/* 0x84 internal DMA descr list base address */
+	u32 idst;		/* 0x88 internal DMA status */
+	u32 idie;		/* 0x8c internal DMA interrupt enable */
+	u32 chda;		/* 0x90 */
+	u32 cbda;		/* 0x94 */
+	u32 res2[26];
+#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
+	u32 res3[17];
+	u32 samp_dl;
+	u32 res4[46];
+#endif
+	u32 fifo;		/* 0x100 / 0x200 FIFO access address */
+};
+
+#define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
+#define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
+#define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
+
+#define SUNXI_MMC_GCTRL_SOFT_RESET	(0x1 << 0)
+#define SUNXI_MMC_GCTRL_FIFO_RESET	(0x1 << 1)
+#define SUNXI_MMC_GCTRL_DMA_RESET	(0x1 << 2)
+#define SUNXI_MMC_GCTRL_RESET		(SUNXI_MMC_GCTRL_SOFT_RESET|\
+					 SUNXI_MMC_GCTRL_FIFO_RESET|\
+					 SUNXI_MMC_GCTRL_DMA_RESET)
+#define SUNXI_MMC_GCTRL_DMA_ENABLE	(0x1 << 5)
+#define SUNXI_MMC_GCTRL_ACCESS_BY_AHB   (0x1 << 31)
+
+#define SUNXI_MMC_CMD_RESP_EXPIRE	(0x1 << 6)
+#define SUNXI_MMC_CMD_LONG_RESPONSE	(0x1 << 7)
+#define SUNXI_MMC_CMD_CHK_RESPONSE_CRC	(0x1 << 8)
+#define SUNXI_MMC_CMD_DATA_EXPIRE	(0x1 << 9)
+#define SUNXI_MMC_CMD_WRITE		(0x1 << 10)
+#define SUNXI_MMC_CMD_AUTO_STOP		(0x1 << 12)
+#define SUNXI_MMC_CMD_WAIT_PRE_OVER	(0x1 << 13)
+#define SUNXI_MMC_CMD_SEND_INIT_SEQ	(0x1 << 15)
+#define SUNXI_MMC_CMD_UPCLK_ONLY	(0x1 << 21)
+#define SUNXI_MMC_CMD_START		(0x1 << 31)
+
+#define SUNXI_MMC_RINT_RESP_ERROR		(0x1 << 1)
+#define SUNXI_MMC_RINT_COMMAND_DONE		(0x1 << 2)
+#define SUNXI_MMC_RINT_DATA_OVER		(0x1 << 3)
+#define SUNXI_MMC_RINT_TX_DATA_REQUEST		(0x1 << 4)
+#define SUNXI_MMC_RINT_RX_DATA_REQUEST		(0x1 << 5)
+#define SUNXI_MMC_RINT_RESP_CRC_ERROR		(0x1 << 6)
+#define SUNXI_MMC_RINT_DATA_CRC_ERROR		(0x1 << 7)
+#define SUNXI_MMC_RINT_RESP_TIMEOUT		(0x1 << 8)
+#define SUNXI_MMC_RINT_DATA_TIMEOUT		(0x1 << 9)
+#define SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE	(0x1 << 10)
+#define SUNXI_MMC_RINT_FIFO_RUN_ERROR		(0x1 << 11)
+#define SUNXI_MMC_RINT_HARD_WARE_LOCKED		(0x1 << 12)
+#define SUNXI_MMC_RINT_START_BIT_ERROR		(0x1 << 13)
+#define SUNXI_MMC_RINT_AUTO_COMMAND_DONE	(0x1 << 14)
+#define SUNXI_MMC_RINT_END_BIT_ERROR		(0x1 << 15)
+#define SUNXI_MMC_RINT_SDIO_INTERRUPT		(0x1 << 16)
+#define SUNXI_MMC_RINT_CARD_INSERT		(0x1 << 30)
+#define SUNXI_MMC_RINT_CARD_REMOVE		(0x1 << 31)
+#define SUNXI_MMC_RINT_INTERRUPT_ERROR_BIT      \
+	(SUNXI_MMC_RINT_RESP_ERROR |		\
+	 SUNXI_MMC_RINT_RESP_CRC_ERROR |	\
+	 SUNXI_MMC_RINT_DATA_CRC_ERROR |	\
+	 SUNXI_MMC_RINT_RESP_TIMEOUT |		\
+	 SUNXI_MMC_RINT_DATA_TIMEOUT |		\
+	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE |	\
+	 SUNXI_MMC_RINT_FIFO_RUN_ERROR |	\
+	 SUNXI_MMC_RINT_HARD_WARE_LOCKED |	\
+	 SUNXI_MMC_RINT_START_BIT_ERROR |	\
+	 SUNXI_MMC_RINT_END_BIT_ERROR) /* 0xbfc2 */
+#define SUNXI_MMC_RINT_INTERRUPT_DONE_BIT	\
+	(SUNXI_MMC_RINT_AUTO_COMMAND_DONE |	\
+	 SUNXI_MMC_RINT_DATA_OVER |		\
+	 SUNXI_MMC_RINT_COMMAND_DONE |		\
+	 SUNXI_MMC_RINT_VOLTAGE_CHANGE_DONE)
+
+#define SUNXI_MMC_STATUS_RXWL_FLAG		(0x1 << 0)
+#define SUNXI_MMC_STATUS_TXWL_FLAG		(0x1 << 1)
+#define SUNXI_MMC_STATUS_FIFO_EMPTY		(0x1 << 2)
+#define SUNXI_MMC_STATUS_FIFO_FULL		(0x1 << 3)
+#define SUNXI_MMC_STATUS_CARD_PRESENT		(0x1 << 8)
+#define SUNXI_MMC_STATUS_CARD_DATA_BUSY		(0x1 << 9)
+#define SUNXI_MMC_STATUS_DATA_FSM_BUSY		(0x1 << 10)
+#define SUNXI_MMC_STATUS_FIFO_LEVEL(reg)	(((reg) >> 17) & 0x3fff)
+
+#define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
+
+#define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
+#define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
+#define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
+
+#define SUNXI_MMC_IDIE_TXIRQ		(0x1 << 0)
+#define SUNXI_MMC_IDIE_RXIRQ		(0x1 << 1)
+
+#define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
+#define SUNXI_MMC_COMMON_RESET			(1 << 18)
+
+#define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
+
+#endif /* _SUNXI_MMC_H */
-- 
2.41.0

