Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70233C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EAB820E3;
	Wed,  2 Apr 2025 00:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k/9ioMK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3797820E2; Wed,  2 Apr 2025 00:52:53 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48B0820A0
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso66316635e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547970; x=1744152770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WIqJLxOXI6YH3zrwGoAYZr+Uf/7IsTl9NmdXc1JUphk=;
 b=k/9ioMK+/wWIYKM4BaWMcHoGTM0iE/veCyCrOkmxoZlWPQh1MF+5+8Nap/eAWrWXc8
 CinfuL2gk8BcfkNIYyFgI9F7iJ4oncPSXsfjRrYPMIXUtSrra2Q8ukSJIEZ3OpZ7n6nl
 FhyOH78a5tuvd+luhaqw2Kl7LXclfqK7pfIK2Usrvh3qE8/D/W1fUf0pQ2IFhyV65Cc1
 3SiYjAdSNbGyTBWv6e3VjnazyIym3j2nmDGD/3q//NvnZkvlWf6ypdrU7Hr9ddnZwKLk
 DxD9rdaJE5U+OXbqreh3uic4JHfDPh4PMrjMGhTn7wqtwQXxnUQQk/reWHhkCQ92TZGT
 /28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547970; x=1744152770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIqJLxOXI6YH3zrwGoAYZr+Uf/7IsTl9NmdXc1JUphk=;
 b=rVpXPD8YadQC4DST3K7F+Lk03sKr+UiBRk+OyqpT4Ce1KLQHb29iirPTYJuC8utg3R
 Si0VLnIntbHT52MfCclZI/UcxlPH0GRAfngPPwPqtwskjsY+w8iLIPRQz/VrXMQvUs42
 QjpEkV323aCkYB/A8e7LzLnEIrQYprkImXLMdR9RUfAR4CmsDW4yHzRIX5iMPT4EqhHr
 yqfBMFLMdRNkcEl5/6+zgamcjVkDsBwor79zjo1iEzgjodkasEs1Jz3+YStKOrtFQ0my
 Ctp73UBADOfauDC46OHH9co2Q6/QTHGF3Oy+kKLK0P95h6mDfC482vt92nL8XiySu5s1
 SHfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY8nEpNEG0i928Pfx29xvqVahYg/iZaYp54SAXFpNX7jj/Ku1EP+2xxlKI0MIml2ft+HC5lRo=@lists.denx.de
X-Gm-Message-State: AOJu0YwMdmmgcv5zJAberJ2B1lLezmF3JIC7SomUuZYtxNk3nOS9izef
 aBJy6/qH651vApg+Hn/K0PJFJDOxaOA2cyYI5xcbTpykRCVdLKD7
X-Gm-Gg: ASbGncu5mdq1+KsHvLAa7Ml92AuQGmqc3FOR//6rQcjXf1BIYCnBqNSokc6ds5GOXen
 bq4Wq8y4zXckX/H6pTuK6H57DafRnVuBJuyZvI/iHyFJyPXphyO21qDPodm4ZHdGXqoVw0xWlFi
 gPex/hnqSyKOahrg1iKo5drEs/rXbPrmXiMHxMwhZd1NPoaYKGbQPS5CBxrFa5aTuSY/qWTJSMF
 7F9Ju5a+ugzCjDZQrFTWY2IuVP5GPPXu7aYLhFSCvmCHoffYbgDaYnalWUyxAQac5nYbGbGtM4Q
 bj0heUhlVPKI1U2TPmn6wNMvgaqM60Sz9BirYSoaRoqkEH2sWPvOjyUlTwNdNb5of3WK5c0Qwgb
 MMZcTYqXCucAaInSk/Qc/wmx2
X-Google-Smtp-Source: AGHT+IFXPrEEa0kZfzZtFzv02ZLhE3QXVs9cXkeGSvDYXxUXWDFBxSbUFpPl3Xrx9qL+i7n3ADLi8g==
X-Received: by 2002:a05:6000:2913:b0:39c:cc7:3c97 with SMTP id
 ffacd0b85a97d-39c29805397mr152666f8f.50.1743547969930; 
 Tue, 01 Apr 2025 15:52:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 12/14] spi: airoha: Add Airoha SPI NAND driver
Date: Wed,  2 Apr 2025 00:51:44 +0200
Message-ID: <20250401225156.25790-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Add Airoha SPI NAND driver to permit usage of attached SNAND on the
Airoha AN7581 SoC. While SPI controller supports DMA transation, due to
U-Boot limitation we currently limit it to single command in Manual
mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/spi/Kconfig           |   9 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/airoha_snfi_spi.c | 717 ++++++++++++++++++++++++++++++++++
 3 files changed, 727 insertions(+)
 create mode 100644 drivers/spi/airoha_snfi_spi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 96ea033082b..b7626558d11 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -52,6 +52,15 @@ config SPI_DIRMAP
 
 if DM_SPI
 
+config AIROHA_SNFI_SPI
+	bool "Airoha SPI memory controller driver"
+	depends on SPI_MEM
+	help
+	  Enable the Airoha SPI memory controller driver. This driver is
+	  originally based on the Airoha SNFI IP core. It can only be
+	  used to access SPI memory devices like SPI-NOR or SPI-NAND on
+	  platforms embedding this IP core, like AN7581.
+
 config ALTERA_SPI
 	bool "Altera SPI driver"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 7051e2a00c6..24cc92a7f98 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -19,6 +19,7 @@ obj-y += spi.o
 obj-$(CONFIG_SPI_MEM) += spi-mem-nodm.o
 endif
 
+obj-$(CONFIG_AIROHA_SNFI_SPI) += airoha_snfi_spi.o
 obj-$(CONFIG_ALTERA_SPI) += altera_spi.o
 obj-$(CONFIG_APPLE_SPI) += apple_spi.o
 obj-$(CONFIG_ATH79_SPI) += ath79_spi.o
diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
new file mode 100644
index 00000000000..611a4f32590
--- /dev/null
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ *
+ * Based on spi-airoha-snfi.c on Linux
+ *
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ * Author: Ray Liu <ray.liu@airoha.com>
+ */
+
+#include <asm/unaligned.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/time.h>
+#include <regmap.h>
+#include <spi.h>
+#include <spi-mem.h>
+
+/* SPI */
+#define REG_SPI_CTRL_READ_MODE			0x0000
+#define REG_SPI_CTRL_READ_IDLE_EN		0x0004
+#define REG_SPI_CTRL_SIDLY			0x0008
+#define REG_SPI_CTRL_CSHEXT			0x000c
+#define REG_SPI_CTRL_CSLEXT			0x0010
+
+#define REG_SPI_CTRL_MTX_MODE_TOG		0x0014
+#define SPI_CTRL_MTX_MODE_TOG			GENMASK(3, 0)
+
+#define REG_SPI_CTRL_RDCTL_FSM			0x0018
+#define SPI_CTRL_RDCTL_FSM			GENMASK(3, 0)
+
+#define REG_SPI_CTRL_MACMUX_SEL			0x001c
+
+#define REG_SPI_CTRL_MANUAL_EN			0x0020
+#define SPI_CTRL_MANUAL_EN			BIT(0)
+
+#define REG_SPI_CTRL_OPFIFO_EMPTY		0x0024
+#define SPI_CTRL_OPFIFO_EMPTY			BIT(0)
+
+#define REG_SPI_CTRL_OPFIFO_WDATA		0x0028
+#define SPI_CTRL_OPFIFO_LEN			GENMASK(8, 0)
+#define SPI_CTRL_OPFIFO_OP			GENMASK(13, 9)
+
+#define REG_SPI_CTRL_OPFIFO_FULL		0x002c
+#define SPI_CTRL_OPFIFO_FULL			BIT(0)
+
+#define REG_SPI_CTRL_OPFIFO_WR			0x0030
+#define SPI_CTRL_OPFIFO_WR			BIT(0)
+
+#define REG_SPI_CTRL_DFIFO_FULL			0x0034
+#define SPI_CTRL_DFIFO_FULL			BIT(0)
+
+#define REG_SPI_CTRL_DFIFO_WDATA		0x0038
+#define SPI_CTRL_DFIFO_WDATA			GENMASK(7, 0)
+
+#define REG_SPI_CTRL_DFIFO_EMPTY		0x003c
+#define SPI_CTRL_DFIFO_EMPTY			BIT(0)
+
+#define REG_SPI_CTRL_DFIFO_RD			0x0040
+#define SPI_CTRL_DFIFO_RD			BIT(0)
+
+#define REG_SPI_CTRL_DFIFO_RDATA		0x0044
+#define SPI_CTRL_DFIFO_RDATA			GENMASK(7, 0)
+
+#define REG_SPI_CTRL_DUMMY			0x0080
+#define SPI_CTRL_CTRL_DUMMY			GENMASK(3, 0)
+
+#define REG_SPI_CTRL_PROBE_SEL			0x0088
+#define REG_SPI_CTRL_INTERRUPT			0x0090
+#define REG_SPI_CTRL_INTERRUPT_EN		0x0094
+#define REG_SPI_CTRL_SI_CK_SEL			0x009c
+#define REG_SPI_CTRL_SW_CFGNANDADDR_VAL		0x010c
+#define REG_SPI_CTRL_SW_CFGNANDADDR_EN		0x0110
+#define REG_SPI_CTRL_SFC_STRAP			0x0114
+
+#define REG_SPI_CTRL_NFI2SPI_EN			0x0130
+#define SPI_CTRL_NFI2SPI_EN			BIT(0)
+
+/* NFI2SPI */
+#define REG_SPI_NFI_CNFG			0x0000
+#define SPI_NFI_DMA_MODE			BIT(0)
+#define SPI_NFI_READ_MODE			BIT(1)
+#define SPI_NFI_DMA_BURST_EN			BIT(2)
+#define SPI_NFI_HW_ECC_EN			BIT(8)
+#define SPI_NFI_AUTO_FDM_EN			BIT(9)
+#define SPI_NFI_OPMODE				GENMASK(14, 12)
+
+#define REG_SPI_NFI_PAGEFMT			0x0004
+#define SPI_NFI_PAGE_SIZE			GENMASK(1, 0)
+#define SPI_NFI_SPARE_SIZE			GENMASK(5, 4)
+
+#define REG_SPI_NFI_CON				0x0008
+#define SPI_NFI_FIFO_FLUSH			BIT(0)
+#define SPI_NFI_RST				BIT(1)
+#define SPI_NFI_RD_TRIG				BIT(8)
+#define SPI_NFI_WR_TRIG				BIT(9)
+#define SPI_NFI_SEC_NUM				GENMASK(15, 12)
+
+#define REG_SPI_NFI_INTR_EN			0x0010
+#define SPI_NFI_RD_DONE_EN			BIT(0)
+#define SPI_NFI_WR_DONE_EN			BIT(1)
+#define SPI_NFI_RST_DONE_EN			BIT(2)
+#define SPI_NFI_ERASE_DONE_EN			BIT(3)
+#define SPI_NFI_BUSY_RETURN_EN			BIT(4)
+#define SPI_NFI_ACCESS_LOCK_EN			BIT(5)
+#define SPI_NFI_AHB_DONE_EN			BIT(6)
+#define SPI_NFI_ALL_IRQ_EN					\
+	(SPI_NFI_RD_DONE_EN | SPI_NFI_WR_DONE_EN |		\
+	 SPI_NFI_RST_DONE_EN | SPI_NFI_ERASE_DONE_EN |		\
+	 SPI_NFI_BUSY_RETURN_EN | SPI_NFI_ACCESS_LOCK_EN |	\
+	 SPI_NFI_AHB_DONE_EN)
+
+#define REG_SPI_NFI_INTR			0x0014
+#define SPI_NFI_AHB_DONE			BIT(6)
+
+#define REG_SPI_NFI_CMD				0x0020
+
+#define REG_SPI_NFI_ADDR_NOB			0x0030
+#define SPI_NFI_ROW_ADDR_NOB			GENMASK(6, 4)
+
+#define REG_SPI_NFI_STA				0x0060
+#define REG_SPI_NFI_FIFOSTA			0x0064
+#define REG_SPI_NFI_STRADDR			0x0080
+#define REG_SPI_NFI_FDM0L			0x00a0
+#define REG_SPI_NFI_FDM0M			0x00a4
+#define REG_SPI_NFI_FDM7L			0x00d8
+#define REG_SPI_NFI_FDM7M			0x00dc
+#define REG_SPI_NFI_FIFODATA0			0x0190
+#define REG_SPI_NFI_FIFODATA1			0x0194
+#define REG_SPI_NFI_FIFODATA2			0x0198
+#define REG_SPI_NFI_FIFODATA3			0x019c
+#define REG_SPI_NFI_MASTERSTA			0x0224
+
+#define REG_SPI_NFI_SECCUS_SIZE			0x022c
+#define SPI_NFI_CUS_SEC_SIZE			GENMASK(12, 0)
+#define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
+
+#define REG_SPI_NFI_RD_CTL2			0x0510
+#define REG_SPI_NFI_RD_CTL3			0x0514
+
+#define REG_SPI_NFI_PG_CTL1			0x0524
+#define SPI_NFI_PG_LOAD_CMD			GENMASK(15, 8)
+
+#define REG_SPI_NFI_PG_CTL2			0x0528
+#define REG_SPI_NFI_NOR_PROG_ADDR		0x052c
+#define REG_SPI_NFI_NOR_RD_ADDR			0x0534
+
+#define REG_SPI_NFI_SNF_MISC_CTL		0x0538
+#define SPI_NFI_DATA_READ_WR_MODE		GENMASK(18, 16)
+
+#define REG_SPI_NFI_SNF_MISC_CTL2		0x053c
+#define SPI_NFI_READ_DATA_BYTE_NUM		GENMASK(12, 0)
+#define SPI_NFI_PROG_LOAD_BYTE_NUM		GENMASK(28, 16)
+
+#define REG_SPI_NFI_SNF_STA_CTL1		0x0550
+#define SPI_NFI_READ_FROM_CACHE_DONE		BIT(25)
+#define SPI_NFI_LOAD_TO_CACHE_DONE		BIT(26)
+
+#define REG_SPI_NFI_SNF_STA_CTL2		0x0554
+
+#define REG_SPI_NFI_SNF_NFI_CNFG		0x055c
+#define SPI_NFI_SPI_MODE			BIT(0)
+
+/* SPI NAND Protocol OP */
+#define SPI_NAND_OP_GET_FEATURE			0x0f
+#define SPI_NAND_OP_SET_FEATURE			0x1f
+#define SPI_NAND_OP_PAGE_READ			0x13
+#define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
+#define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_WRITE_ENABLE		0x06
+#define SPI_NAND_OP_WRITE_DISABLE		0x04
+#define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
+#define SPI_NAND_OP_PROGRAM_LOAD_QUAD		0x32
+#define SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE	0x84
+#define SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD	0x34
+#define SPI_NAND_OP_PROGRAM_EXECUTE		0x10
+#define SPI_NAND_OP_READ_ID			0x9f
+#define SPI_NAND_OP_BLOCK_ERASE			0xd8
+#define SPI_NAND_OP_RESET			0xff
+#define SPI_NAND_OP_DIE_SELECT			0xc2
+
+#define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
+#define SPI_MAX_TRANSFER_SIZE			511
+
+enum airoha_snand_mode {
+	SPI_MODE_AUTO,
+	SPI_MODE_MANUAL,
+	SPI_MODE_DMA,
+};
+
+enum airoha_snand_cs {
+	SPI_CHIP_SEL_HIGH,
+	SPI_CHIP_SEL_LOW,
+};
+
+struct airoha_snand_priv {
+	struct regmap *regmap_ctrl;
+	struct regmap *regmap_nfi;
+	struct clk *spi_clk;
+
+	struct {
+		size_t page_size;
+		size_t sec_size;
+		u8 sec_num;
+		u8 spare_size;
+	} nfi_cfg;
+};
+
+static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
+				    u8 op_cmd, int op_len)
+{
+	int err;
+	u32 val;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WDATA,
+			   FIELD_PREP(SPI_CTRL_OPFIFO_LEN, op_len) |
+			   FIELD_PREP(SPI_CTRL_OPFIFO_OP, op_cmd));
+	if (err)
+		return err;
+
+	err = regmap_read_poll_timeout(priv->regmap_ctrl,
+				       REG_SPI_CTRL_OPFIFO_FULL,
+				       val, !(val & SPI_CTRL_OPFIFO_FULL),
+				       0, 250 * USEC_PER_MSEC);
+	if (err)
+		return err;
+
+	err = regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WR,
+			   SPI_CTRL_OPFIFO_WR);
+	if (err)
+		return err;
+
+	return regmap_read_poll_timeout(priv->regmap_ctrl,
+					REG_SPI_CTRL_OPFIFO_EMPTY,
+					val, (val & SPI_CTRL_OPFIFO_EMPTY),
+					0, 250 * USEC_PER_MSEC);
+}
+
+static int airoha_snand_set_cs(struct airoha_snand_priv *priv, u8 cs)
+{
+	return airoha_snand_set_fifo_op(priv, cs, sizeof(cs));
+}
+
+static int airoha_snand_write_data_to_fifo(struct airoha_snand_priv *priv,
+					   const u8 *data, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int err;
+		u32 val;
+
+		/* 1. Wait until dfifo is not full */
+		err = regmap_read_poll_timeout(priv->regmap_ctrl,
+					       REG_SPI_CTRL_DFIFO_FULL, val,
+					       !(val & SPI_CTRL_DFIFO_FULL),
+					       0, 250 * USEC_PER_MSEC);
+		if (err)
+			return err;
+
+		/* 2. Write data to register DFIFO_WDATA */
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_DFIFO_WDATA,
+				   FIELD_PREP(SPI_CTRL_DFIFO_WDATA, data[i]));
+		if (err)
+			return err;
+
+		/* 3. Wait until dfifo is not full */
+		err = regmap_read_poll_timeout(priv->regmap_ctrl,
+					       REG_SPI_CTRL_DFIFO_FULL, val,
+					       !(val & SPI_CTRL_DFIFO_FULL),
+					       0, 250 * USEC_PER_MSEC);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_snand_read_data_from_fifo(struct airoha_snand_priv *priv,
+					    u8 *ptr, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int err;
+		u32 val;
+
+		/* 1. wait until dfifo is not empty */
+		err = regmap_read_poll_timeout(priv->regmap_ctrl,
+					       REG_SPI_CTRL_DFIFO_EMPTY, val,
+					       !(val & SPI_CTRL_DFIFO_EMPTY),
+					       0, 250 * USEC_PER_MSEC);
+		if (err)
+			return err;
+
+		/* 2. read from dfifo to register DFIFO_RDATA */
+		err = regmap_read(priv->regmap_ctrl,
+				  REG_SPI_CTRL_DFIFO_RDATA, &val);
+		if (err)
+			return err;
+
+		ptr[i] = FIELD_GET(SPI_CTRL_DFIFO_RDATA, val);
+		/* 3. enable register DFIFO_RD to read next byte */
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_DFIFO_RD, SPI_CTRL_DFIFO_RD);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
+				 enum airoha_snand_mode mode)
+{
+	int err;
+
+	switch (mode) {
+	case SPI_MODE_MANUAL: {
+		u32 val;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_NFI2SPI_EN, 0);
+		if (err)
+			return err;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_READ_IDLE_EN, 0);
+		if (err)
+			return err;
+
+		err = regmap_read_poll_timeout(priv->regmap_ctrl,
+					       REG_SPI_CTRL_RDCTL_FSM, val,
+					       !(val & SPI_CTRL_RDCTL_FSM),
+					       0, 250 * USEC_PER_MSEC);
+		if (err)
+			return err;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_MTX_MODE_TOG, 9);
+		if (err)
+			return err;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_MANUAL_EN, SPI_CTRL_MANUAL_EN);
+		if (err)
+			return err;
+		break;
+	}
+	case SPI_MODE_DMA:
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_NFI2SPI_EN,
+				   SPI_CTRL_MANUAL_EN);
+		if (err < 0)
+			return err;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_MTX_MODE_TOG, 0x0);
+		if (err < 0)
+			return err;
+
+		err = regmap_write(priv->regmap_ctrl,
+				   REG_SPI_CTRL_MANUAL_EN, 0x0);
+		if (err < 0)
+			return err;
+		break;
+	case SPI_MODE_AUTO:
+	default:
+		break;
+	}
+
+	return regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
+}
+
+static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
+				   const u8 *data, int len)
+{
+	int i, data_len;
+
+	for (i = 0; i < len; i += data_len) {
+		int err;
+
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
+		err = airoha_snand_set_fifo_op(priv, cmd, data_len);
+		if (err)
+			return err;
+
+		err = airoha_snand_write_data_to_fifo(priv, &data[i],
+						      data_len);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_snand_read_data(struct airoha_snand_priv *priv, u8 *data,
+				  int len)
+{
+	int i, data_len;
+
+	for (i = 0; i < len; i += data_len) {
+		int err;
+
+		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
+		err = airoha_snand_set_fifo_op(priv, 0xc, data_len);
+		if (err)
+			return err;
+
+		err = airoha_snand_read_data_from_fifo(priv, &data[i],
+						       data_len);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_snand_nfi_init(struct airoha_snand_priv *priv)
+{
+	int err;
+
+	/* switch to SNFI mode */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_NFI_CNFG,
+			   SPI_NFI_SPI_MODE);
+	if (err)
+		return err;
+
+	/* Enable DMA */
+	return regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_INTR_EN,
+				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
+}
+
+static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
+{
+	int err;
+	u32 val;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		return err;
+
+	/* auto FDM */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				SPI_NFI_AUTO_FDM_EN);
+	if (err)
+		return err;
+
+	/* HW ECC */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				SPI_NFI_HW_ECC_EN);
+	if (err)
+		return err;
+
+	/* DMA Burst */
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+			      SPI_NFI_DMA_BURST_EN);
+	if (err)
+		return err;
+
+	/* page format */
+	switch (priv->nfi_cfg.spare_size) {
+	case 26:
+		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
+		break;
+	case 27:
+		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
+		break;
+	case 28:
+		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
+		break;
+	default:
+		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
+		break;
+	}
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
+				 SPI_NFI_SPARE_SIZE, val);
+	if (err)
+		return err;
+
+	switch (priv->nfi_cfg.page_size) {
+	case 2048:
+		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
+		break;
+	case 4096:
+		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
+		break;
+	default:
+		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
+		break;
+	}
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
+				 SPI_NFI_PAGE_SIZE, val);
+	if (err)
+		return err;
+
+	/* sec num */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		return err;
+
+	/* enable cust sec size */
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+			      SPI_NFI_CUS_SEC_SIZE_EN);
+	if (err)
+		return err;
+
+	/* set cust sec size */
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, priv->nfi_cfg.sec_size);
+	return regmap_update_bits(priv->regmap_nfi,
+				  REG_SPI_NFI_SECCUS_SIZE,
+				  SPI_NFI_CUS_SEC_SIZE, val);
+}
+
+static int airoha_snand_adjust_op_size(struct spi_slave *slave,
+				       struct spi_mem_op *op)
+{
+	size_t max_len;
+
+	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
+	if (max_len >= 160)
+		return -EOPNOTSUPP;
+
+	if (op->data.nbytes > 160 - max_len)
+		op->data.nbytes = 160 - max_len;
+
+	return 0;
+}
+
+static bool airoha_snand_supports_op(struct spi_slave *slave,
+				     const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(slave, op))
+		return false;
+
+	if (op->cmd.buswidth != 1)
+		return false;
+
+	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
+	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
+	       (!op->data.nbytes || op->data.buswidth == 1);
+}
+
+static int airoha_snand_exec_op(struct spi_slave *slave,
+				const struct spi_mem_op *op)
+{
+	u8 data[8], cmd, opcode = op->cmd.opcode;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv;
+	int i, err;
+
+	priv = dev_get_priv(bus);
+
+	/* switch to manual mode */
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err < 0)
+		return err;
+
+	err = airoha_snand_set_cs(priv, SPI_CHIP_SEL_LOW);
+	if (err < 0)
+		return err;
+
+	/* opcode */
+	err = airoha_snand_write_data(priv, 0x8, &opcode, sizeof(opcode));
+	if (err)
+		return err;
+
+	/* addr part */
+	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
+	put_unaligned_be64(op->addr.val, data);
+
+	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
+	     i < ARRAY_SIZE(data); i++) {
+		err = airoha_snand_write_data(priv, cmd, &data[i],
+					      sizeof(data[0]));
+		if (err)
+			return err;
+	}
+
+	/* dummy */
+	data[0] = 0xff;
+	for (i = 0; i < op->dummy.nbytes; i++) {
+		err = airoha_snand_write_data(priv, 0x8, &data[0],
+					      sizeof(data[0]));
+		if (err)
+			return err;
+	}
+
+	/* data */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		err = airoha_snand_read_data(priv, op->data.buf.in,
+					     op->data.nbytes);
+		if (err)
+			return err;
+	} else {
+		err = airoha_snand_write_data(priv, 0x8, op->data.buf.out,
+					      op->data.nbytes);
+		if (err)
+			return err;
+	}
+
+	return airoha_snand_set_cs(priv, SPI_CHIP_SEL_HIGH);
+}
+
+static int airoha_snand_probe(struct udevice *dev)
+{
+	struct airoha_snand_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_ctrl, 0);
+	if (ret) {
+		dev_err(dev, "failed to init spi ctrl regmap\n");
+		return ret;
+	}
+
+	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_nfi, 1);
+	if (ret) {
+		dev_err(dev, "failed to init spi nfi regmap\n");
+		return ret;
+	}
+
+	priv->spi_clk = devm_clk_get(dev, "spi");
+	if (IS_ERR(priv->spi_clk)) {
+		dev_err(dev, "unable to get spi clk\n");
+		return PTR_ERR(priv->regmap_ctrl);
+	}
+	clk_enable(priv->spi_clk);
+
+	return airoha_snand_nfi_init(priv);
+}
+
+static int airoha_snand_nfi_set_speed(struct udevice *bus, uint speed)
+{
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+	int ret;
+
+	ret = clk_set_rate(priv->spi_clk, speed);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int airoha_snand_nfi_set_mode(struct udevice *bus, uint mode)
+{
+	return 0;
+}
+
+static int airoha_snand_nfi_setup(struct spi_slave *slave,
+				  const struct spinand_info *spinand_info)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv;
+	u32 sec_size, sec_num;
+	int pagesize, oobsize;
+
+	priv = dev_get_priv(bus);
+
+	pagesize = spinand_info->memorg.pagesize;
+	oobsize = spinand_info->memorg.oobsize;
+
+	if (pagesize == 2 * 1024)
+		sec_num = 4;
+	else if (pagesize == 4 * 1024)
+		sec_num = 8;
+	else
+		sec_num = 1;
+
+	sec_size = (pagesize + oobsize) / sec_num;
+
+	/* init default value */
+	priv->nfi_cfg.sec_size = sec_size;
+	priv->nfi_cfg.sec_num = sec_num;
+	priv->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
+	priv->nfi_cfg.spare_size = 16;
+
+	return airoha_snand_nfi_config(priv);
+}
+
+static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
+	.adjust_op_size = airoha_snand_adjust_op_size,
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
+static const struct dm_spi_ops airoha_snfi_spi_ops = {
+	.mem_ops = &airoha_snand_mem_ops,
+	.set_speed = airoha_snand_nfi_set_speed,
+	.set_mode = airoha_snand_nfi_set_mode,
+	.setup_for_spinand = airoha_snand_nfi_setup,
+};
+
+static const struct udevice_id airoha_snand_ids[] = {
+	{ .compatible = "airoha,en7581-snand" },
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_snfi_spi) = {
+	.name = "airoha-snfi-spi",
+	.id = UCLASS_SPI,
+	.of_match = airoha_snand_ids,
+	.ops = &airoha_snfi_spi_ops,
+	.priv_auto = sizeof(struct airoha_snand_priv),
+	.probe = airoha_snand_probe,
+};
-- 
2.48.1

