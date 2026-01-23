Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE55ED7236C
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B882683DEA;
	Fri, 23 Jan 2026 12:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aLmcoqEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0313883DDF; Fri, 23 Jan 2026 12:46:42 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42DC783D0F
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E56C04E42216;
 Fri, 23 Jan 2026 11:46:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8B3A6070A;
 Fri, 23 Jan 2026 11:46:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 583E2119A87C4; Fri, 23 Jan 2026 12:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168797; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=yr18b2cKZLcgvedEAep3z/Ae9JU/LlVlZeqajVowZ/U=;
 b=aLmcoqEXNF+OS386WrdeFFE1Q+nFN8qRNVzrXMEIaZn7rdPo9MqM/hmzAoORF0tU6Ybcj1
 ttiJcHAQDkZ+G8b3E+3+qWETYUenl5VJV2vUEZOFDo4QcRl+/Ff/3aPTCn5ucffVpMf/vF
 2XPrBQTdVFHj7thMrHppDPdY1bxwKqw2VFeww5hKVM1T/iQDq2fNVETuD6R07gfwCONxCB
 Mc8FoIiDLKUpRDj7XYcOa7sHX//I53fSmUEP31lpwxLK+DWDppqCidnTAxSPLabkg6aVJS
 Ntkk0W7mVDELRw+pI6FR5bdacK35lHDuTE5WFI+P3sQiE1HtU0mcNc1z8Nk/tA==
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
Subject: [PATCH v3 22/26] mtd: rawnand: sunxi: add support for H6/H616 nand
 controller
Date: Fri, 23 Jan 2026 12:44:57 +0100
Message-ID: <20260123114507.1400918-23-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
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

Introduce H6/H616 NAND controller support for U-Boot

The H616 NAND controller has the same base as A10/A23, with some
differences:
- MDMA is based on chained buffers
- its ECC supports up to 80bit per 1024bytes
- some registers layouts are a bit different, mainly due do the stronger
  ECC.
- it uses USER_DATA_LEN registers along USER_DATA registers.
- it needs a specific clock for ECC and MBUS.

Introduce the basic support, with ECC and scrambling, but without
DMA/MDMA.

Tested on Whatsminer H616 board (with and without scrambling, ECC)

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/Kconfig      |   3 +-
 drivers/mtd/nand/raw/sunxi_nand.c | 104 ++++++++++++++++++++++++++++--
 drivers/mtd/nand/raw/sunxi_nand.h |  32 ++++++++-
 3 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index a93b00cdb7e0..140fd5e7689b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -466,7 +466,8 @@ config NAND_SANDBOX
 config NAND_SUNXI
 	bool "Support for NAND on Allwinner SoCs"
 	default ARCH_SUNXI
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I \
+		|| MACH_SUN50I_H616 || MACH_SUN50I_H6
 	select SYS_NAND_SELF_INIT
 	select SYS_NAND_U_BOOT_LOCATIONS
 	select SPL_NAND_SUPPORT
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index aabfcdfe637f..e46356447477 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -187,6 +187,14 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
 	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
 	       ccm + CCU_NAND0_CLK_CFG);
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	setbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	setbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
+	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
+	       ccm + CCU_NAND1_CLK_CFG);
+#else
 	/* gate on nand clock */
 	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
@@ -194,6 +202,7 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
 #else
 	setbits_le32(ccm + CCU_AHB_GATE0, (1 << AHB_GATE_OFFSET_DMA));
 #endif
+#endif
 }
 
 static int sunxi_nfc_wait_int(struct sunxi_nfc *nfc, u32 flags,
@@ -688,6 +697,53 @@ static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
 	buf[3] = user_data >> 24;
 }
 
+/*
+ * On H6/H616 the user_data length has to be set in specific registers
+ * before writing.
+ */
+static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
+{
+	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
+
+	/* not all SoCs have this register */
+	if (!nfc->caps->reg_user_data_len)
+		return;
+
+	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
+		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
+}
+
+static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
+					int len, int step)
+{
+	bool found = false;
+	u32 val;
+	int i;
+
+	/* not all SoCs have this register */
+	if (!nfc->caps->reg_user_data_len)
+		return;
+
+	for (i = 0; i < nfc->caps->nuser_data_tab; i++) {
+		if (len == nfc->caps->user_data_len_tab[i]) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_warn(nfc->dev,
+			 "Unsupported length for user data reg: %d\n", len);
+		return;
+	}
+
+	val = readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
+
+	val &= ~NFC_USER_DATA_LEN_MSK(step);
+	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
+	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
+}
+
 static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 				       u8 *data, int data_off,
 				       u8 *oob, int oob_off,
@@ -715,6 +771,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_reset_user_data_len(nfc);
+	sunxi_nfc_set_user_data_len(nfc, 4, 0);
+
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
@@ -855,6 +914,9 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_reset_user_data_len(nfc);
+	sunxi_nfc_set_user_data_len(nfc, 4, 0);
+
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
@@ -1275,7 +1337,6 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nfc *nfc,
 static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc)
 {
-	static const u8 strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -1302,12 +1363,12 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < nfc->caps->nstrengths; i++) {
-		if (ecc->strength <= strengths[i]) {
+		if (ecc->strength <= nfc->caps->ecc_strengths[i]) {
 			/*
 			 * Update ecc->strength value with the actual strength
 			 * that will be used by the ECC engine.
 			 */
-			ecc->strength = strengths[i];
+			ecc->strength = nfc->caps->ecc_strengths[i];
 			break;
 		}
 	}
@@ -1721,9 +1782,22 @@ static int sunxi_nand_probe(struct udevice *dev)
 	return 0;
 }
 
+static const u8 sunxi_ecc_strengths_a10[] = {
+	16, 24, 28, 32, 40, 48, 56, 60, 64
+};
+
+static const u8 sunxi_ecc_strengths_h6[] = {
+	16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80
+};
+
+static const u8 sunxi_user_data_len_h6[] = {
+	0, 4, 8, 12, 16, 20, 24, 28, 32
+};
+
 static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
-	.nstrengths = 9,
+	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
+	.ecc_strengths = sunxi_ecc_strengths_a10,
 	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
 	.reg_user_data = NFC_REG_A10_USER_DATA,
 	.reg_pat_found = NFC_REG_ECC_ST,
@@ -1732,6 +1806,24 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.pat_found_mask = GENMASK(31, 16),
 	.ecc_mode_mask = GENMASK(15, 12),
 	.random_en_mask = BIT(9),
+	.max_ecc_steps = 16,
+};
+
+static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
+	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_h6),
+	.ecc_strengths = sunxi_ecc_strengths_h6,
+	.reg_ecc_err_cnt = NFC_REG_H6_ECC_ERR_CNT,
+	.reg_user_data = NFC_REG_H6_USER_DATA,
+	.reg_user_data_len = NFC_REG_H6_USER_DATA_LEN,
+	.reg_pat_found = NFC_REG_H6_PAT_FOUND,
+	.reg_spare_area = NFC_REG_H6_SPARE_AREA,
+	.reg_pat_id = NFC_REG_H6_PAT_ID,
+	.pat_found_mask = GENMASK(31, 0),
+	.ecc_mode_mask = GENMASK(15, 8),
+	.random_en_mask = BIT(5),
+	.user_data_len_tab = sunxi_user_data_len_h6,
+	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
+	.max_ecc_steps = 32,
 };
 
 static const struct udevice_id sunxi_nand_ids[] = {
@@ -1739,6 +1831,10 @@ static const struct udevice_id sunxi_nand_ids[] = {
 		.compatible = "allwinner,sun4i-a10-nand",
 		.data = (unsigned long)&sunxi_nfc_a10_caps,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-nand-controller",
+		.data = (unsigned long)&sunxi_nfc_h616_caps,
+	},
 	{ }
 };
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 25d18eaa0b81..6ee3ea14ee17 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -44,15 +44,26 @@
 #define NFC_REG_IO_DATA		0x0030
 #define NFC_REG_ECC_CTL		0x0034
 #define NFC_REG_ECC_ST		0x0038
-#define NFC_REG_DEBUG		0x003C
+#define NFC_REG_H6_PAT_FOUND	0x003C
 #define NFC_REG_A10_ECC_ERR_CNT	0x0040
+#define NFC_REG_H6_ECC_ERR_CNT	0x0050
 #define NFC_REG_ECC_ERR_CNT(nfc, x)	(((nfc)->caps->reg_ecc_err_cnt + (x)) & ~0x3)
 #define NFC_REG_A10_USER_DATA	0x0050
+#define NFC_REG_H6_USER_DATA	0x0080
+#define NFC_REG_H6_USER_DATA_LEN 0x0070
 #define NFC_REG_USER_DATA(nfc, x)	((nfc)->caps->reg_user_data + ((x) * 4))
+
+/* A USER_DATA_LEN register can hold the length of 8 USER_DATA registers */
+#define NFC_REG_USER_DATA_LEN_CAPACITY 8
+#define NFC_REG_USER_DATA_LEN(nfc, step) \
+	((nfc)->caps->reg_user_data_len + \
+	 ((step) / NFC_REG_USER_DATA_LEN_CAPACITY) * 4)
 #define NFC_REG_SPARE_AREA(nfc) ((nfc)->caps->reg_spare_area)
 #define NFC_REG_A10_SPARE_AREA	0x00A0
-#define NFC_REG_PAT_ID(nfc) ((nfc)->caps->reg_pat_id)
+#define NFC_REG_H6_SPARE_AREA	0x0114
+#define NFC_REG_PAT_ID(nfc)	((nfc)->caps->reg_pat_id)
 #define NFC_REG_A10_PAT_ID	0x00A4
+#define NFC_REG_H6_PAT_ID	0x0118
 #define NFC_RAM0_BASE		0x0400
 #define NFC_RAM1_BASE		0x0800
 
@@ -161,6 +172,9 @@
 
 #define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
 
+#define NFC_USER_DATA_LEN_MSK(step) \
+	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))
+
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
 #define NFC_SRAM_SIZE		1024
@@ -173,8 +187,10 @@
  *
  * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
  * @nstrengths:		Number of element of ECC strengths array
+ * @ecc_strengths:	available ECC strengths array
  * @reg_ecc_err_cnt:	ECC error counter register
  * @reg_user_data:	User data register
+ * @reg_user_data_len:	User data length register
  * @reg_spare_area:	Spare Area Register
  * @reg_pat_id:		Pattern ID Register
  * @reg_pat_found:	Data Pattern Status Register
@@ -182,12 +198,21 @@
  * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
  * @ecc_mode_mask:	ECC_MODE mask in NFC_ECC_CTL register
  * @random_en_mask:	RANDOM_EN mask in NFC_ECC_CTL register
+ * @user_data_len_tab:  Table of lenghts supported by USER_DATA_LEN register
+ *			The table index is the value to set in NFC_USER_DATA_LEN
+ *			registers, and the corresponding value is the number of
+ *			bytes to write
+ * @nuser_data_tab:	Size of @user_data_len_tab
+ * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
+ *			number of user data registers
  */
 struct sunxi_nfc_caps {
 	bool has_ecc_block_512;
 	unsigned int nstrengths;
+	const u8 *ecc_strengths;
 	unsigned int reg_ecc_err_cnt;
 	unsigned int reg_user_data;
+	unsigned int reg_user_data_len;
 	unsigned int reg_spare_area;
 	unsigned int reg_pat_id;
 	unsigned int reg_pat_found;
@@ -195,6 +220,9 @@ struct sunxi_nfc_caps {
 	unsigned int ecc_err_mask;
 	unsigned int ecc_mode_mask;
 	unsigned int random_en_mask;
+	const u8 *user_data_len_tab;
+	unsigned int nuser_data_tab;
+	unsigned int max_ecc_steps;
 };
 
 #endif
-- 
2.47.3

