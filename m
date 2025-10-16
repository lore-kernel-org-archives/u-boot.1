Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27031CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163FA838D2;
	Thu, 16 Oct 2025 16:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vVkZVPEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C1983771; Thu, 16 Oct 2025 16:30:04 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2513838DD
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 56D141A1445;
 Thu, 16 Oct 2025 14:29:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2B40D6062C;
 Thu, 16 Oct 2025 14:29:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CDBFA102F231D; 
 Thu, 16 Oct 2025 16:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=saf81ct5R0wBAJDoqoNIn+EyfBvjEURNA47eebVL6iY=;
 b=vVkZVPEhSHr1D6HRVUYFjRcHpemCMUwpew8Key+9+kwgXOy0zdx657loNoahvGJY4cSN/S
 0zeCVozldYS+7bpuvOAmcR6Z1pRMCVH4uiYeCk+dCBTKPOJaHGSewQPdGy104bBeyO+CFH
 V1wiFEEjSbNMxVwExnU8CXRN6p+fGW1ixow+dx+hZowGn76FfWgKdRaJ50Lnl9d+05SvrX
 BkOH33vdcBvI1sNf21LVqcRB3TIzNPM5kUOJNvJ7neZAEjAHvwBa8VvmPQ1Jaeba33VSzN
 HzOdQ+U0fVdu148E4INWbimzJKkrXIsW/jb8befpG253v2bZnohP+wwKCiCiYw==
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
Subject: [PATCH 24/24] mtd: rawnand: sunxi_spl: Fix cast to pointer from
 integer warnings
Date: Thu, 16 Oct 2025 16:27:47 +0200
Message-ID: <20251016142752.2627710-25-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016142752.2627710-1-richard.genoud@bootlin.com>
References: <20251016142752.2627710-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix a cast to pointer from integer warning on ARM64

On 64bits platform, the casts done in {read,write}l() give that kind of
warnings:
drivers/mtd/nand/raw/sunxi_nand_spl.c: In function ‘check_value_inner’:
./arch/arm/include/asm/io.h:110:43: warning: cast to pointer from \
integer of different size [-Wint-to-pointer-cast]
  110 | #define __raw_readl(a) (*(volatile unsigned int *)(a))
      |                          ^
[...]
drivers/mtd/nand/raw/sunxi_nand_spl.c:81:27: note: in expansion of \
macro ‘readl’
   81 |                 int val = readl(offset) & expected_bits;

Introduce {read,write}l_nfc inline function to do the right cast and
push the base address (SUNXI_NFC_BASE) into those functions, making the
code more readable.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 97 +++++++++++++++------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 17e6031a9811..8f5057f2841b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -80,11 +80,25 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
 
 #define DEFAULT_TIMEOUT_US	100000
 
+static inline u32 readl_nfc(u32 offset)
+{
+	void * __iomem base = (void *)(uintptr_t)SUNXI_NFC_BASE;
+
+	return readl(base + offset);
+}
+
+static inline u32 writel_nfc(u32 val, u32 offset)
+{
+	void * __iomem base = (void *)(uintptr_t)SUNXI_NFC_BASE;
+
+	return writel(val, base + offset);
+}
+
 static int check_value_inner(int offset, int expected_bits,
 			     int timeout_us, int negation)
 {
 	do {
-		int val = readl(offset) & expected_bits;
+		int val = readl_nfc(offset) & expected_bits;
 		if (negation ? !val : val)
 			return 1;
 		udelay(1);
@@ -107,8 +121,8 @@ static inline int check_value_negated(int offset, int unexpected_bits,
 
 static int nand_wait_cmd_fifo_empty(void)
 {
-	if (!check_value_negated(SUNXI_NFC_BASE + NFC_REG_ST,
-				 NFC_CMD_FIFO_STATUS, DEFAULT_TIMEOUT_US)) {
+	if (!check_value_negated(NFC_REG_ST, NFC_CMD_FIFO_STATUS,
+				 DEFAULT_TIMEOUT_US)) {
 		printf("nand: timeout waiting for empty cmd FIFO\n");
 		return -ETIMEDOUT;
 	}
@@ -118,7 +132,7 @@ static int nand_wait_cmd_fifo_empty(void)
 
 static int nand_wait_int(void)
 {
-	if (!check_value(SUNXI_NFC_BASE + NFC_REG_ST, NFC_CMD_INT_FLAG,
+	if (!check_value(NFC_REG_ST, NFC_CMD_INT_FLAG,
 			 DEFAULT_TIMEOUT_US)) {
 		printf("nand: timeout waiting for interruption\n");
 		return -ETIMEDOUT;
@@ -135,8 +149,8 @@ static int nand_exec_cmd(u32 cmd)
 	if (ret)
 		return ret;
 
-	writel(NFC_CMD_INT_FLAG, SUNXI_NFC_BASE + NFC_REG_ST);
-	writel(cmd, SUNXI_NFC_BASE + NFC_REG_CMD);
+	writel_nfc(NFC_CMD_INT_FLAG, NFC_REG_ST);
+	writel_nfc(cmd, NFC_REG_CMD);
 
 	return nand_wait_int();
 }
@@ -147,15 +161,12 @@ void nand_init(void)
 
 	board_nand_init();
 
-	val = readl(SUNXI_NFC_BASE + NFC_REG_CTL);
+	val = readl_nfc(NFC_REG_CTL);
 	/* enable and reset CTL */
-	writel(val | NFC_EN | NFC_RESET,
-	       SUNXI_NFC_BASE + NFC_REG_CTL);
+	writel_nfc(val | NFC_EN | NFC_RESET, NFC_REG_CTL);
 
-	if (!check_value_negated(SUNXI_NFC_BASE + NFC_REG_CTL,
-				 NFC_RESET, DEFAULT_TIMEOUT_US)) {
+	if (!check_value_negated(NFC_REG_CTL, NFC_RESET, DEFAULT_TIMEOUT_US))
 		printf("Couldn't initialize nand\n");
-	}
 
 	/* reset NAND */
 	nand_exec_cmd(NFC_SEND_CMD1 | NFC_WAIT_FLAG | NAND_CMD_RESET);
@@ -167,24 +178,23 @@ static void nand_apply_config(const struct nfc_config *conf)
 
 	nand_wait_cmd_fifo_empty();
 
-	val = readl(SUNXI_NFC_BASE + NFC_REG_CTL);
+	val = readl_nfc(NFC_REG_CTL);
 	val &= ~NFC_PAGE_SHIFT_MSK;
-	writel(val | NFC_PAGE_SIZE(conf->page_size),
-	       SUNXI_NFC_BASE + NFC_REG_CTL);
-	writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_REG_CNT);
-	writel(conf->page_size, SUNXI_NFC_BASE + NFC_REG_SPARE_AREA(conf));
+	writel_nfc(val | NFC_PAGE_SIZE(conf->page_size), NFC_REG_CTL);
+	writel_nfc(conf->ecc_size, NFC_REG_CNT);
+	writel_nfc(conf->page_size, NFC_REG_SPARE_AREA(conf));
 }
 
 static int nand_load_page(const struct nfc_config *conf, u32 offs)
 {
 	int page = offs / conf->page_size;
 
-	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NAND_CMD_READSTART << NFC_READ_CMD_OFFSET),
-	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
-	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
-	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_REG_ADDR_HIGH);
+	writel_nfc((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+		   (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+		   (NAND_CMD_READSTART << NFC_READ_CMD_OFFSET),
+		   NFC_REG_RCMD_SET);
+	writel_nfc(((page & 0xFFFF) << 16), NFC_REG_ADDR_LOW);
+	writel_nfc((page >> 16) & 0xFF, NFC_REG_ADDR_HIGH);
 
 	return nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
 			     NFC_SEND_ADR | NFC_WAIT_FLAG |
@@ -195,11 +205,11 @@ static int nand_change_column(u16 column)
 {
 	int ret;
 
-	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NAND_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
-	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
-	writel(column, SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
+	writel_nfc((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+		   (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+		   (NAND_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
+		   NFC_REG_RCMD_SET);
+	writel_nfc(column, NFC_REG_ADDR_LOW);
 
 	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
 			    (1 << NFC_ADR_NUM_OFFSET) | NFC_SEND_ADR |
@@ -226,7 +236,7 @@ static void sunxi_nfc_reset_user_data_len(const struct nfc_config *nfc)
 		return;
 
 	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
-		writel(0, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, i));
+		writel_nfc(0, NFC_REG_USER_DATA_LEN(nfc, i));
 }
 
 static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
@@ -252,11 +262,11 @@ static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
 		return;
 	}
 
-	val = readl(SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+	val = readl_nfc(NFC_REG_USER_DATA_LEN(nfc, step));
 
 	val &= ~NFC_USER_DATA_LEN_MSK(step);
 	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
-	writel(val, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+	writel_nfc(val, NFC_REG_USER_DATA_LEN(nfc, step));
 }
 
 #if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
@@ -298,18 +308,18 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			ecc512_bit = NFC_ECC_BLOCK_512;
 
 		/* Clear ECC status and restart ECC engine */
-		writel(0, SUNXI_NFC_BASE + NFC_REG_ECC_ST);
+		writel_nfc(0, NFC_REG_ECC_ST);
 
-		writel(NFC_RANDOM_SEED(rand_seed) |
-		       NFC_ECC_MODE(conf, conf->ecc_strength) |
-		       (conf->randomize ? NFC_RANDOM_EN(conf) : 0) |
-		       ecc512_bit |
-		       NFC_ECC_EN | NFC_ECC_EXCEPTION,
-		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
+		writel_nfc(NFC_RANDOM_SEED(rand_seed) |
+			   NFC_ECC_MODE(conf, conf->ecc_strength) |
+			   (conf->randomize ? NFC_RANDOM_EN(conf) : 0) |
+			   ecc512_bit |
+			   NFC_ECC_EN | NFC_ECC_EXCEPTION,
+			   NFC_REG_ECC_CTL);
 
 		/* Move the data in SRAM */
 		nand_change_column(data_off);
-		writel(conf->ecc_size, SUNXI_NFC_BASE + NFC_REG_CNT);
+		writel_nfc(conf->ecc_size, NFC_REG_CNT);
 		nand_exec_cmd(NFC_DATA_TRANS);
 
 		/*
@@ -323,7 +333,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 
 		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
-		ecc_st = readl(SUNXI_NFC_BASE + NFC_REG_ECC_ST);
+		ecc_st = readl_nfc(NFC_REG_ECC_ST);
 
 		/* ECC error detected. */
 		if (ecc_st & NFC_ECC_ERR_MSK(conf))
@@ -334,8 +344,7 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		 * (needed for configuration detection).
 		 */
 		if (!i) {
-			pattern_found = readl(SUNXI_NFC_BASE +
-					      conf->caps->reg_pat_found);
+			pattern_found = readl_nfc(conf->caps->reg_pat_found);
 			pattern_found = field_get(NFC_ECC_PAT_FOUND_MSK(conf),
 						  pattern_found);
 			if (pattern_found & NFC_ECC_PAT_FOUND(0))
@@ -348,8 +357,8 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			      conf->ecc_size);
 
 		/* Stop the ECC engine */
-		writel(readl(SUNXI_NFC_BASE + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
-		       SUNXI_NFC_BASE + NFC_REG_ECC_CTL);
+		writel_nfc(readl_nfc(NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
+			   NFC_REG_ECC_CTL);
 
 		if (data_off + conf->ecc_size >= len)
 			break;
