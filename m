Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D680D7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E4783BC4;
	Fri, 23 Jan 2026 12:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="i+/AxW0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086F983B97; Fri, 23 Jan 2026 12:45:57 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AE583B97
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1EE064E42217;
 Fri, 23 Jan 2026 11:45:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E1C0A6070A;
 Fri, 23 Jan 2026 11:45:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BA647119A87C2; Fri, 23 Jan 2026 12:45:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jBPDxXZfua18FVMwF3JoYxfoUC88kHev/vJgkTbOVG8=;
 b=i+/AxW0ktmCjiYoljGLw29rX5Xl7Aipa32satshnqpqRxI9C3XB7eHsuv1rh0S6UpES2Jx
 0McrjYfUKd2kYVsC6tsnOYiUSVhK8JB3RTVG0kdCM31Zbm34tMUnv7lS1jPStGbIbK8OX8
 4FSXelKsrJC85HBCWX/kE0+plgwaZBHE7CiVaA1wVXBBvgHxuzvzLQWVrvCXXinSz2zagD
 m7mURBB2HLP7CtfiXzyEAlHhq/MukxmXiVMQmsH9ebRk+ofX/XGcuAb/8LX2E4jP0anSnx
 Y89k8kHeIs4z2QKPXolt2Wfmj5sEi+/IK4OGoYTBp7qUFnqaaFpTetGnba/wzA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 06/26] mtd: rawnand: sunxi: merge register definitions for
 sunxi_nand{, _spl}.c
Date: Fri, 23 Jan 2026 12:44:41 +0100
Message-ID: <20260123114507.1400918-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: 8135f19cbf51948415f775f7ae7dec4f36d601fb2f2306672939c5cd4903b17f6bad1ec618b13de8eecb8ddb8d80ad2f5242b0a6cdae5d04651052a379e0e0d2
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

Merge common register definitions from sunxi_nand{,_spl}.c

The Allwinner NAND controller registers where in both files, so let's
just merge all that in a header, it will be easier for maintenance.

NB: the defines are also harmonized with Linux driver

No functional change

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c     | 123 +-------------------
 drivers/mtd/nand/raw/sunxi_nand.h     | 156 ++++++++++++++++++++++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c |  45 +-------
 3 files changed, 158 insertions(+), 166 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/sunxi_nand.h

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index ba2740ed1876..20028d539ac6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -46,128 +46,7 @@
 #include <asm/gpio.h>
 #include <asm/arch/clock.h>
 
-#define NFC_REG_CTL		0x0000
-#define NFC_REG_ST		0x0004
-#define NFC_REG_INT		0x0008
-#define NFC_REG_TIMING_CTL	0x000C
-#define NFC_REG_TIMING_CFG	0x0010
-#define NFC_REG_ADDR_LOW	0x0014
-#define NFC_REG_ADDR_HIGH	0x0018
-#define NFC_REG_SECTOR_NUM	0x001C
-#define NFC_REG_CNT		0x0020
-#define NFC_REG_CMD		0x0024
-#define NFC_REG_RCMD_SET	0x0028
-#define NFC_REG_WCMD_SET	0x002C
-#define NFC_REG_IO_DATA		0x0030
-#define NFC_REG_ECC_CTL		0x0034
-#define NFC_REG_ECC_ST		0x0038
-#define NFC_REG_DEBUG		0x003C
-#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
-#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
-#define NFC_REG_SPARE_AREA	0x00A0
-#define NFC_REG_PAT_ID		0x00A4
-#define NFC_RAM0_BASE		0x0400
-#define NFC_RAM1_BASE		0x0800
-
-/* define bit use in NFC_CTL */
-#define NFC_EN			BIT(0)
-#define NFC_RESET		BIT(1)
-#define NFC_BUS_WIDTH_MSK	BIT(2)
-#define NFC_BUS_WIDTH_8		(0 << 2)
-#define NFC_BUS_WIDTH_16	(1 << 2)
-#define NFC_RB_SEL_MSK		BIT(3)
-#define NFC_RB_SEL(x)		((x) << 3)
-#define NFC_CE_SEL_MSK		(0x7 << 24)
-#define NFC_CE_SEL(x)		((x) << 24)
-#define NFC_CE_CTL		BIT(6)
-#define NFC_PAGE_SHIFT_MSK	(0xf << 8)
-#define NFC_PAGE_SHIFT(x)	(((x) < 10 ? 0 : (x) - 10) << 8)
-#define NFC_SAM			BIT(12)
-#define NFC_RAM_METHOD		BIT(14)
-#define NFC_DEBUG_CTL		BIT(31)
-
-/* define bit use in NFC_ST */
-#define NFC_RB_B2R		BIT(0)
-#define NFC_CMD_INT_FLAG	BIT(1)
-#define NFC_DMA_INT_FLAG	BIT(2)
-#define NFC_CMD_FIFO_STATUS	BIT(3)
-#define NFC_STA			BIT(4)
-#define NFC_NATCH_INT_FLAG	BIT(5)
-#define NFC_RB_STATE(x)		BIT(x + 8)
-
-/* define bit use in NFC_INT */
-#define NFC_B2R_INT_ENABLE	BIT(0)
-#define NFC_CMD_INT_ENABLE	BIT(1)
-#define NFC_DMA_INT_ENABLE	BIT(2)
-#define NFC_INT_MASK		(NFC_B2R_INT_ENABLE | \
-				 NFC_CMD_INT_ENABLE | \
-				 NFC_DMA_INT_ENABLE)
-
-/* define bit use in NFC_TIMING_CTL */
-#define NFC_TIMING_CTL_EDO	BIT(8)
-
-/* define NFC_TIMING_CFG register layout */
-#define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
-	(((tWB) & 0x3) | (((tADL) & 0x3) << 2) |		\
-	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
-	(((tCAD) & 0x7) << 8))
-
-/* define bit use in NFC_CMD */
-#define NFC_CMD_LOW_BYTE_MSK	0xff
-#define NFC_CMD_HIGH_BYTE_MSK	(0xff << 8)
-#define NFC_CMD(x)		(x)
-#define NFC_ADR_NUM_MSK		(0x7 << 16)
-#define NFC_ADR_NUM(x)		(((x) - 1) << 16)
-#define NFC_SEND_ADR		BIT(19)
-#define NFC_ACCESS_DIR		BIT(20)
-#define NFC_DATA_TRANS		BIT(21)
-#define NFC_SEND_CMD1		BIT(22)
-#define NFC_WAIT_FLAG		BIT(23)
-#define NFC_SEND_CMD2		BIT(24)
-#define NFC_SEQ			BIT(25)
-#define NFC_DATA_SWAP_METHOD	BIT(26)
-#define NFC_ROW_AUTO_INC	BIT(27)
-#define NFC_SEND_CMD3		BIT(28)
-#define NFC_SEND_CMD4		BIT(29)
-#define NFC_CMD_TYPE_MSK	(0x3 << 30)
-#define NFC_NORMAL_OP		(0 << 30)
-#define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
-
-/* define bit use in NFC_RCMD_SET */
-#define NFC_READ_CMD_MSK	0xff
-#define NFC_RND_READ_CMD0_MSK	(0xff << 8)
-#define NFC_RND_READ_CMD1_MSK	(0xff << 16)
-
-/* define bit use in NFC_WCMD_SET */
-#define NFC_PROGRAM_CMD_MSK	0xff
-#define NFC_RND_WRITE_CMD_MSK	(0xff << 8)
-#define NFC_READ_CMD0_MSK	(0xff << 16)
-#define NFC_READ_CMD1_MSK	(0xff << 24)
-
-/* define bit use in NFC_ECC_CTL */
-#define NFC_ECC_EN		BIT(0)
-#define NFC_ECC_PIPELINE	BIT(3)
-#define NFC_ECC_EXCEPTION	BIT(4)
-#define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
-#define NFC_ECC_BLOCK_512	(1 << 5)
-#define NFC_RANDOM_EN		BIT(9)
-#define NFC_RANDOM_DIRECTION	BIT(10)
-#define NFC_ECC_MODE_MSK	(0xf << 12)
-#define NFC_ECC_MODE(x)		((x) << 12)
-#define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
-#define NFC_RANDOM_SEED(x)	((x) << 16)
-
-/* define bit use in NFC_ECC_ST */
-#define NFC_ECC_ERR(x)		BIT(x)
-#define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
-#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
-
-#define NFC_DEFAULT_TIMEOUT_MS	1000
-
-#define NFC_SRAM_SIZE		1024
-
-#define NFC_MAX_CS		7
+#include "sunxi_nand.h"
 
 /*
  * Ready/Busy detection type: describes the Ready/Busy detection modes
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
new file mode 100644
index 000000000000..59803ccc9f22
--- /dev/null
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Bootlin, Richard GENOUD
+ *
+ * merged defines from sunxi_nand{,_spl}.c
+ * Containing the following copyrights:
+ * Copyright (C) 2013 Boris BREZILLON <b.brezillon.dev@gmail.com>
+ * Copyright (C) 2015 Roy Spliet <r.spliet@ultimaker.com>
+ * Copyright (c) 2014-2015, Antmicro Ltd <www.antmicro.com>
+ * Copyright (c) 2015, AW-SOM Technologies <www.aw-som.com>
+ * Derived from:
+ *	https://github.com/yuq/sunxi-nfc-mtd
+ *	Copyright (C) 2013 Qiang Yu <yuq825@gmail.com>
+ *
+ *	https://github.com/hno/Allwinner-Info
+ *	Copyright (C) 2013 Henrik Nordström <Henrik Nordström>
+ *
+ *	Copyright (C) 2013 Dmitriy B. <rzk333@gmail.com>
+ *	Copyright (C) 2013 Sergey Lapin <slapin@ossfans.org>
+ *
+ */
+
+#ifndef SUNXI_NAND_H
+#define SUNXI_NAND_H
+
+#include <linux/bitops.h>
+
+#define NFC_REG_CTL		0x0000
+#define NFC_REG_ST		0x0004
+#define NFC_REG_INT		0x0008
+#define NFC_REG_TIMING_CTL	0x000C
+#define NFC_REG_TIMING_CFG	0x0010
+#define NFC_REG_ADDR_LOW	0x0014
+#define NFC_REG_ADDR_HIGH	0x0018
+#define NFC_REG_SECTOR_NUM	0x001C
+#define NFC_REG_CNT		0x0020
+#define NFC_REG_CMD		0x0024
+#define NFC_REG_RCMD_SET	0x0028
+#define NFC_REG_WCMD_SET	0x002C
+#define NFC_REG_IO_DATA		0x0030
+#define NFC_REG_ECC_CTL		0x0034
+#define NFC_REG_ECC_ST		0x0038
+#define NFC_REG_DEBUG		0x003C
+#define NFC_REG_ECC_ERR_CNT(x)	((0x0040 + (x)) & ~0x3)
+#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
+#define NFC_REG_SPARE_AREA	0x00A0
+#define NFC_REG_PAT_ID		0x00A4
+#define NFC_RAM0_BASE		0x0400
+#define NFC_RAM1_BASE		0x0800
+
+/* define bit use in NFC_CTL */
+#define NFC_EN			BIT(0)
+#define NFC_RESET		BIT(1)
+#define NFC_BUS_WIDTH_MSK	BIT(2)
+#define NFC_BUS_WIDTH_8		(0 << 2)
+#define NFC_BUS_WIDTH_16	(1 << 2)
+#define NFC_RB_SEL_MSK		BIT(3)
+#define NFC_RB_SEL(x)		((x) << 3)
+#define NFC_CE_SEL_MSK		(0x7 << 24)
+#define NFC_CE_SEL(x)		((x) << 24)
+#define NFC_CE_CTL		BIT(6)
+#define NFC_PAGE_SHIFT_MSK	(0xf << 8)
+#define NFC_PAGE_SHIFT(x)	(((x) < 10 ? 0 : (x) - 10) << 8)
+#define NFC_PAGE_SIZE(a)	((fls(a) - 11) << 8)
+#define NFC_SAM			BIT(12)
+#define NFC_RAM_METHOD		BIT(14)
+#define NFC_DEBUG_CTL		BIT(31)
+
+/* define bit use in NFC_ST */
+#define NFC_RB_B2R		BIT(0)
+#define NFC_CMD_INT_FLAG	BIT(1)
+#define NFC_DMA_INT_FLAG	BIT(2)
+#define NFC_CMD_FIFO_STATUS	BIT(3)
+#define NFC_STA			BIT(4)
+#define NFC_NATCH_INT_FLAG	BIT(5)
+#define NFC_RB_STATE(x)		BIT((x) + 8)
+
+/* define bit use in NFC_INT */
+#define NFC_B2R_INT_ENABLE	BIT(0)
+#define NFC_CMD_INT_ENABLE	BIT(1)
+#define NFC_DMA_INT_ENABLE	BIT(2)
+#define NFC_INT_MASK		(NFC_B2R_INT_ENABLE | \
+				 NFC_CMD_INT_ENABLE | \
+				 NFC_DMA_INT_ENABLE)
+
+/* define bit use in NFC_TIMING_CTL */
+#define NFC_TIMING_CTL_EDO	BIT(8)
+
+/* define NFC_TIMING_CFG register layout */
+#define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
+	(((tWB) & 0x3) | (((tADL) & 0x3) << 2) |		\
+	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
+	(((tCAD) & 0x7) << 8))
+
+/* define bit use in NFC_CMD */
+#define NFC_CMD_LOW_BYTE_MSK	0xff
+#define NFC_CMD_HIGH_BYTE_MSK	(0xff << 8)
+#define NFC_CMD(x)		(x)
+#define NFC_ADR_NUM_OFFSET	16
+#define NFC_ADR_NUM_MSK		(0x7 << NFC_ADR_NUM_OFFSET)
+#define NFC_ADR_NUM(x)		(((x) - 1) << NFC_ADR_NUM_OFFSET)
+#define NFC_SEND_ADR		BIT(19)
+#define NFC_ACCESS_DIR		BIT(20)
+#define NFC_DATA_TRANS		BIT(21)
+#define NFC_SEND_CMD1		BIT(22)
+#define NFC_WAIT_FLAG		BIT(23)
+#define NFC_SEND_CMD2		BIT(24)
+#define NFC_SEQ			BIT(25)
+#define NFC_DATA_SWAP_METHOD	BIT(26)
+#define NFC_ROW_AUTO_INC	BIT(27)
+#define NFC_SEND_CMD3		BIT(28)
+#define NFC_SEND_CMD4		BIT(29)
+#define NFC_CMD_TYPE_MSK	(0x3 << 30)
+#define NFC_NORMAL_OP		(0 << 30)
+#define NFC_ECC_OP		(1 << 30)
+#define NFC_PAGE_OP		(2 << 30)
+
+/* define bit use in NFC_RCMD_SET */
+#define NFC_READ_CMD_OFFSET	0
+#define NFC_READ_CMD_MSK	(0xff << NFC_READ_CMD_OFFSET)
+#define NFC_RND_READ_CMD0_OFFSET 8
+#define NFC_RND_READ_CMD0_MSK	(0xff << NFC_RND_READ_CMD0_OFFSET)
+#define NFC_RND_READ_CMD1_OFFSET 16
+#define NFC_RND_READ_CMD1_MSK	(0xff << NFC_RND_READ_CMD1_OFFSET)
+
+/* define bit use in NFC_WCMD_SET */
+#define NFC_PROGRAM_CMD_MSK	0xff
+#define NFC_RND_WRITE_CMD_MSK	(0xff << 8)
+#define NFC_READ_CMD0_MSK	(0xff << 16)
+#define NFC_READ_CMD1_MSK	(0xff << 24)
+
+/* define bit use in NFC_ECC_CTL */
+#define NFC_ECC_EN		BIT(0)
+#define NFC_ECC_PIPELINE	BIT(3)
+#define NFC_ECC_EXCEPTION	BIT(4)
+#define NFC_ECC_BLOCK_SIZE_MSK	BIT(5)
+#define NFC_ECC_BLOCK_512	BIT(5)
+#define NFC_RANDOM_EN		BIT(9)
+#define NFC_RANDOM_DIRECTION	BIT(10)
+#define NFC_ECC_MODE_MSK	(0xf << 12)
+#define NFC_ECC_MODE(x)		((x) << 12)
+#define NFC_RANDOM_SEED_MSK	(0x7fff << 16)
+#define NFC_RANDOM_SEED(x)	((x) << 16)
+
+/* define bit use in NFC_ECC_ST */
+#define NFC_ECC_ERR(x)		BIT(x)
+#define NFC_ECC_PAT_FOUND(x)	BIT((x) + 16)
+#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
+
+#define NFC_DEFAULT_TIMEOUT_MS	1000
+
+#define NFC_SRAM_SIZE		1024
+
+#define NFC_MAX_CS		7
+
+#endif
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index ab569d8086a3..909c846e0207 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -13,50 +13,7 @@
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
 
-/* registers */
-#define NFC_REG_CTL                0x00000000
-#define NFC_REG_ST                 0x00000004
-#define NFC_REG_ADDR_LOW           0x00000014
-#define NFC_REG_ADDR_HIGH          0x00000018
-#define NFC_REG_CNT                0x00000020
-#define NFC_REG_CMD                0x00000024
-#define NFC_REG_RCMD_SET           0x00000028
-#define NFC_REG_ECC_CTL            0x00000034
-#define NFC_REG_ECC_ST             0x00000038
-#define NFC_REG_SPARE_AREA         0x000000A0
-#define NFC_RAM0_BASE              0x00000400
-#define NFC_RAM1_BASE              0x00000800
-
-#define NFC_EN                     (1 << 0)
-#define NFC_RESET                  (1 << 1)
-#define NFC_PAGE_SHIFT_MSK         (0xf << 8)
-#define NFC_PAGE_SIZE(a)           ((fls(a) - 11) << 8)
-
-#define NFC_ECC_EN                 (1 << 0)
-#define NFC_ECC_EXCEPTION          (1 << 4)
-#define NFC_ECC_BLOCK_512          (1 << 5)
-#define NFC_RANDOM_EN              (1 << 9)
-#define NFC_RANDOM_DIRECTION       (1 << 10)
-
-#define NFC_ADR_NUM_OFFSET         16
-#define NFC_SEND_ADR               (1 << 19)
-#define NFC_ACCESS_DIR             (1 << 20)
-#define NFC_DATA_TRANS             (1 << 21)
-#define NFC_SEND_CMD1              (1 << 22)
-#define NFC_WAIT_FLAG              (1 << 23)
-#define NFC_SEND_CMD2              (1 << 24)
-#define NFC_SEQ                    (1 << 25)
-#define NFC_DATA_SWAP_METHOD       (1 << 26)
-#define NFC_ROW_AUTO_INC           (1 << 27)
-#define NFC_SEND_CMD3              (1 << 28)
-#define NFC_SEND_CMD4              (1 << 29)
-#define NFC_NORMAL_OP              (0 << 30)
-#define NFC_ECC_OP                 (1 << 30)
-#define NFC_PAGE_OP                (2 << 30)
-
-#define NFC_CMD_INT_FLAG           (1 << 1)
-#define NFC_DMA_INT_FLAG           (1 << 2)
-#define NFC_CMD_FIFO_STATUS        (1 << 3)
+#include "sunxi_nand.h"
 
 #define NFC_READ_CMD_OFFSET         0
 #define NFC_RND_READ_CMD0_OFFSET    8
-- 
2.47.3

