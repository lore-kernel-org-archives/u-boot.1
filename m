Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C105CCD19A
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31567837E2;
	Thu, 16 Oct 2025 16:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kiUQ/eEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937EF837E2; Thu, 16 Oct 2025 16:28:45 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D13283734
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 287301A1433;
 Thu, 16 Oct 2025 14:28:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F07486062C;
 Thu, 16 Oct 2025 14:28:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A64FE102F231C; 
 Thu, 16 Oct 2025 16:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624921; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=JaNehXM9sSsT7Awqn5hloC/yvdkTlU25RDBTZZ/LNUg=;
 b=kiUQ/eElQbvtJDGXQ3zwZKZqtNbIgVI6YrMkgr/pUoIcqmiFKH682AoAvx3klY2+a3KDVb
 6KgX9mGN5g9tV+F8hwHgVxP09Gqg7+PYegydbG+GyOZ81vAO64QiH7L4FRs5f4ryhX41jQ
 DjkMcg3c78gvMjAMsX/rhTwA38LwRmTZZ0Un25BierDK8vs9QV5Xm8rq0eTLXVIwKICY9y
 40x9J5LQRBmGhNropZCumul8U+oQb0JZbiOqAzihafrI33Jwkt/4jdR++pIeano1HBrQeu
 PaT470Tm+E96E4GjHT9QPeNT9Ku7rZg2epxlFEtaae8D/iGeKLSXq7G58yskDA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Anand Gore <anand.gore@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 david regan <dregan@broadcom.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 03/24] mtd: rawnand: sunxi_spl: cosmetic: harmonize register
 defines with non spl file
Date: Thu, 16 Oct 2025 16:27:26 +0200
Message-ID: <20251016142752.2627710-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016142752.2627710-1-richard.genoud@bootlin.com>
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Harmonize registers definition in sunxi_nand{,_spl}.c files

This is a first step to then include the same file from both
sunxi_nand{,_spl}.c files

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 148 ++++++++++++--------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 19091ece632b..3ccf716b99ac 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -14,48 +14,32 @@
 #include <linux/mtd/rawnand.h>
 
 /* registers */
-#define NFC_CTL                    0x00000000
-#define NFC_ST                     0x00000004
-#define NFC_INT                    0x00000008
-#define NFC_TIMING_CTL             0x0000000C
-#define NFC_TIMING_CFG             0x00000010
-#define NFC_ADDR_LOW               0x00000014
-#define NFC_ADDR_HIGH              0x00000018
-#define NFC_SECTOR_NUM             0x0000001C
-#define NFC_CNT                    0x00000020
-#define NFC_CMD                    0x00000024
-#define NFC_RCMD_SET               0x00000028
-#define NFC_WCMD_SET               0x0000002C
-#define NFC_IO_DATA                0x00000030
-#define NFC_ECC_CTL                0x00000034
-#define NFC_ECC_ST                 0x00000038
-#define NFC_DEBUG                  0x0000003C
-#define NFC_ECC_CNT0               0x00000040
-#define NFC_ECC_CNT1               0x00000044
-#define NFC_ECC_CNT2               0x00000048
-#define NFC_ECC_CNT3               0x0000004C
-#define NFC_USER_DATA_BASE         0x00000050
-#define NFC_EFNAND_STATUS          0x00000090
-#define NFC_SPARE_AREA             0x000000A0
-#define NFC_PATTERN_ID             0x000000A4
+#define NFC_REG_CTL                0x00000000
+#define NFC_REG_ST                 0x00000004
+#define NFC_REG_ADDR_LOW           0x00000014
+#define NFC_REG_ADDR_HIGH          0x00000018
+#define NFC_REG_CNT                0x00000020
+#define NFC_REG_CMD                0x00000024
+#define NFC_REG_RCMD_SET           0x00000028
+#define NFC_REG_ECC_CTL            0x00000034
+#define NFC_REG_ECC_ST             0x00000038
+#define NFC_REG_SPARE_AREA         0x000000A0
 #define NFC_RAM0_BASE              0x00000400
 #define NFC_RAM1_BASE              0x00000800
 
-#define NFC_CTL_EN                 (1 << 0)
-#define NFC_CTL_RESET              (1 << 1)
-#define NFC_CTL_RAM_METHOD         (1 << 14)
-#define NFC_CTL_PAGE_SIZE_MASK     (0xf << 8)
-#define NFC_CTL_PAGE_SIZE(a)       ((fls(a) - 11) << 8)
+#define NFC_EN                     (1 << 0)
+#define NFC_RESET                  (1 << 1)
+#define NFC_PAGE_SHIFT_MSK         (0xf << 8)
+#define NFC_PAGE_SIZE(a)           ((fls(a) - 11) << 8)
 
 #define NFC_ECC_EN                 (1 << 0)
-#define NFC_ECC_PIPELINE           (1 << 3)
 #define NFC_ECC_EXCEPTION          (1 << 4)
-#define NFC_ECC_BLOCK_SIZE         (1 << 5)
-#define NFC_ECC_RANDOM_EN          (1 << 9)
-#define NFC_ECC_RANDOM_DIRECTION   (1 << 10)
+#define NFC_ECC_BLOCK_512          (1 << 5)
+#define NFC_RANDOM_EN              (1 << 9)
+#define NFC_RANDOM_DIRECTION       (1 << 10)
 
-#define NFC_ADDR_NUM_OFFSET        16
-#define NFC_SEND_ADDR              (1 << 19)
+#define NFC_ADR_NUM_OFFSET         16
+#define NFC_SEND_ADR               (1 << 19)
 #define NFC_ACCESS_DIR             (1 << 20)
 #define NFC_DATA_TRANS             (1 << 21)
 #define NFC_SEND_CMD1              (1 << 22)
@@ -66,17 +50,17 @@
 #define NFC_ROW_AUTO_INC           (1 << 27)
 #define NFC_SEND_CMD3              (1 << 28)
 #define NFC_SEND_CMD4              (1 << 29)
-#define NFC_RAW_CMD                (0 << 30)
-#define NFC_ECC_CMD                (1 << 30)
-#define NFC_PAGE_CMD               (2 << 30)
+#define NFC_NORMAL_OP              (0 << 30)
+#define NFC_ECC_OP                 (1 << 30)
+#define NFC_PAGE_OP                (2 << 30)
 
-#define NFC_ST_CMD_INT_FLAG        (1 << 1)
-#define NFC_ST_DMA_INT_FLAG        (1 << 2)
-#define NFC_ST_CMD_FIFO_STAT       (1 << 3)
+#define NFC_CMD_INT_FLAG           (1 << 1)
+#define NFC_DMA_INT_FLAG           (1 << 2)
+#define NFC_CMD_FIFO_STATUS        (1 << 3)
 
 #define NFC_READ_CMD_OFFSET         0
-#define NFC_RANDOM_READ_CMD0_OFFSET 8
-#define NFC_RANDOM_READ_CMD1_OFFSET 16
+#define NFC_RND_READ_CMD0_OFFSET    8
+#define NFC_RND_READ_CMD1_OFFSET    16
 
 #define NFC_CMD_RNDOUTSTART        0xE0
 #define NFC_CMD_RNDOUT             0x05
@@ -143,8 +127,8 @@ static inline int check_value_negated(int offset, int unexpected_bits,
 
 static int nand_wait_cmd_fifo_empty(void)
 {
-	if (!check_value_negated(SUNXI_NFC_BASE + NFC_ST, NFC_ST_CMD_FIFO_STAT,
-				 DEFAULT_TIMEOUT_US)) {
+	if (!check_value_negated(SUNXI_NFC_BASE + NFC_REG_ST,
+				 NFC_CMD_FIFO_STATUS, DEFAULT_TIMEOUT_US)) {
 		printf("nand: timeout waiting for empty cmd FIFO\n");
 		return -ETIMEDOUT;
 	}
@@ -154,7 +138,7 @@ static int nand_wait_cmd_fifo_empty(void)
 
 static int nand_wait_int(void)
 {
-	if (!check_value(SUNXI_NFC_BASE + NFC_ST, NFC_ST_CMD_INT_FLAG,
+	if (!check_value(SUNXI_NFC_BASE + NFC_REG_ST, NFC_CMD_INT_FLAG,
 			 DEFAULT_TIMEOUT_US)) {
 		printf("nand: timeout waiting for interruption\n");
 		return -ETIMEDOUT;
@@ -171,8 +155,8 @@ static int nand_exec_cmd(u32 cmd)
 	if (ret)
 		return ret;
 
-	writel(NFC_ST_CMD_INT_FLAG, SUNXI_NFC_BASE + NFC_ST);
-	writel(cmd, SUNXI_NFC_BASE + NFC_CMD);
+	writel(NFC_CMD_INT_FLAG, SUNXI_NFC_BASE + NFC_REG_ST);
+	writel(cmd, SUNXI_NFC_BASE + NFC_REG_CMD);
 
 	return nand_wait_int();
 }
@@ -183,13 +167,13 @@ void nand_init(void)
 
 	board_nand_init();
 
-	val = readl(SUNXI_NFC_BASE + NFC_CTL);
+	val = readl(SUNXI_NFC_BASE + NFC_REG_CTL);
 	/* enable and reset CTL */
-	writel(val | NFC_CTL_EN | NFC_CTL_RESET,
-	       SUNXI_NFC_BASE + NFC_CTL);
+	writel(val | NFC_EN | NFC_RESET,
+	       SUNXI_NFC_BASE + NFC_REG_CTL);
 
-	if (!check_value_negated(SUNXI_NFC_BASE + NFC_CTL,
-				 NFC_CTL_RESET, DEFAULT_TIMEOUT_US)) {
+	if (!check_value_negated(SUNXI_NFC_BASE + NFC_REG_CTL,
+				 NFC_RESET, DEFAULT_TIMEOUT_US)) {
 		printf("Couldn't initialize nand\n");
 	}
 
@@ -203,42 +187,42 @@ static void nand_apply_config(const struct nfc_config *conf)
 
 	nand_wait_cmd_fifo_empty();
 
-	val = readl(SUNXI_NFC_BASE + NFC_CTL);
-	val &= ~NFC_CTL_PAGE_SIZE_MASK;
-	writel(val | NFC_CTL_PAGE_SIZE(conf->page_size),
-	       SUNXI_NFC_BASE + NFC_CTL);
-	writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_CNT);
-	writel(conf->page_size, SUNXI_NFC_BASE + NFC_SPARE_AREA);
+	val = readl(SUNXI_NFC_BASE + NFC_REG_CTL);
+	val &= ~NFC_PAGE_SHIFT_MSK;
+	writel(val | NFC_PAGE_SIZE(conf->page_size),
+	       SUNXI_NFC_BASE + NFC_REG_CTL);
+	writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_REG_CNT);
+	writel(conf->page_size, SUNXI_NFC_BASE + NFC_REG_SPARE_AREA);
 }
 
 static int nand_load_page(const struct nfc_config *conf, u32 offs)
 {
 	int page = offs / conf->page_size;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RANDOM_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RANDOM_READ_CMD0_OFFSET) |
+	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
 	       (NFC_CMD_READSTART << NFC_READ_CMD_OFFSET),
-	       SUNXI_NFC_BASE + NFC_RCMD_SET);
-	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_ADDR_LOW);
-	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_ADDR_HIGH);
+	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
+	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
+	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_REG_ADDR_HIGH);
 
-	return nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_RAW_CMD |
-			     NFC_SEND_ADDR | NFC_WAIT_FLAG |
-			     ((conf->addr_cycles - 1) << NFC_ADDR_NUM_OFFSET));
+	return nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
+			     NFC_SEND_ADR | NFC_WAIT_FLAG |
+			     ((conf->addr_cycles - 1) << NFC_ADR_NUM_OFFSET));
 }
 
 static int nand_change_column(u16 column)
 {
 	int ret;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RANDOM_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RANDOM_READ_CMD0_OFFSET) |
+	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
 	       (NFC_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
-	       SUNXI_NFC_BASE + NFC_RCMD_SET);
-	writel(column, SUNXI_NFC_BASE + NFC_ADDR_LOW);
+	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
+	writel(column, SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
 
-	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_RAW_CMD |
-			    (1 << NFC_ADDR_NUM_OFFSET) | NFC_SEND_ADDR |
+	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
+			    (1 << NFC_ADR_NUM_OFFSET) | NFC_SEND_ADR |
 			    NFC_CMD_RNDOUT);
 	if (ret)
 		return ret;
@@ -276,16 +260,16 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		u8 *data = dest + data_off;
 
 		/* Clear ECC status and restart ECC engine */
-		writel(0, SUNXI_NFC_BASE + NFC_ECC_ST);
+		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 		writel((rand_seed << 16) | (conf->ecc_strength << 12) |
-		       (conf->randomize ? NFC_ECC_RANDOM_EN : 0) |
-		       (conf->ecc_size == 512 ? NFC_ECC_BLOCK_SIZE : 0) |
+		       (conf->randomize ? NFC_RANDOM_EN : 0) |
+		       (conf->ecc_size == 512 ? NFC_ECC_BLOCK_512 : 0) |
 		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
-		       SUNXI_NFC_BASE + NFC_ECC_CTL);
+		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
 
 		/* Move the data in SRAM */
 		nand_change_column(data_off);
-		writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_CNT);
+		writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_REG_CNT);
 		nand_exec_cmd(NFC_DATA_TRANS);
 
 		/*
@@ -293,10 +277,10 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		 * the data.
 		 */
 		nand_change_column(oob_off);
-		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_CMD);
+		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 
 		/* Get the ECC status */
-		ecc_st = readl(SUNXI_NFC_BASE + NFC_ECC_ST);
+		ecc_st = readl(SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 
 		/* ECC error detected. */
 		if (ecc_st & 0xffff)
@@ -315,8 +299,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			      conf->ecc_size);
 
 		/* Stop the ECC engine */
-		writel(readl(SUNXI_NFC_BASE + NFC_ECC_CTL) & ~NFC_ECC_EN,
-		       SUNXI_NFC_BASE + NFC_ECC_CTL);
+		writel(readl(SUNXI_NFC_BASE + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
+		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
 
 		if (data_off + conf->ecc_size >= len)
 			break;
