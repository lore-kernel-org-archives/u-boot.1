Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9950ECCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE9E83771;
	Thu, 16 Oct 2025 16:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kUqrZrFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A76F83923; Thu, 16 Oct 2025 16:30:01 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63840838B7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 11E664E41117;
 Thu, 16 Oct 2025 14:29:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D43916062C;
 Thu, 16 Oct 2025 14:29:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA39A102F2310; 
 Thu, 16 Oct 2025 16:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624991; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=QRfpE6vvX9vCByxx0K6vQkcc1yR/6mA0IpZ0wwI2thg=;
 b=kUqrZrFl86S1fvJMuOzOZnC/wINT2+d2U4lIfoNB8ex6Ufqe5gyjaTrBzi6aqPFAaNWrOm
 0h+v5A09udknPn9XKFl0I9lXo2AoNwVd+4RkAOjV8VYJl2uFNgxgxiqz9lVX8dnzNW4vQE
 iBUixa9k1zbt1HGDU7hcesCBnQqsbPLBuy9LzGvQJvlyR896WqLz0yFXXBfYjeEEYOvXJj
 Imm311YvfwBAQ2CQrd013HkdNHiBGJbnmrFQRJ0NkbmtVil7pOU3PJqqMw+Z5Tg/Mm0+ck
 +6nDBmiPoCJRvVF9k0Ni39Vaqtw08JQm3lq8C3aoiYDCMwNMfaBwd8D+tM+m1A==
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
Subject: [PATCH 22/24] mtd: rawnand: sunxi: add support for H6/H616 nand
 controller
Date: Thu, 16 Oct 2025 16:27:45 +0200
Message-ID: <20251016142752.2627710-23-richard.genoud@bootlin.com>
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
 drivers/mtd/nand/raw/sunxi_nand.c | 112 ++++++++++++++++++++++++++++--
 drivers/mtd/nand/raw/sunxi_nand.h |  32 ++++++++-
 3 files changed, 139 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 754b99bf3eb6..e4c4d9bcbf63 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -467,7 +467,8 @@ config NAND_SANDBOX
 config NAND_SUNXI
 	bool "Support for NAND on Allwinner SoCs"
 	default ARCH_SUNXI
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I \
+		|| MACH_SUN50I_H616
 	select SYS_NAND_SELF_INIT
 	select SYS_NAND_U_BOOT_LOCATIONS
 	select SPL_NAND_SUPPORT
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 58c895095ce9..c9133cdc8844 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -170,8 +170,14 @@ static inline struct sunxi_nfc *to_sunxi_nfc(struct nand_hw_control *ctrl)
 
 static void sunxi_nfc_set_clk_rate(unsigned long hz)
 {
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	void * const ccm = (void *)SUNXI_CCM_BASE;
+	void * const nand0_clk_cfg = ccm + CCU_NAND0_CLK_CFG;
+#else
 	struct sunxi_ccm_reg *const ccm =
 	(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	u32 *nand0_clk_cfg = &ccm->nand0_clk_cfg;
+#endif
 	int div_m, div_n;
 
 	div_m = (clock_get_pll6() + hz - 1) / hz;
@@ -186,8 +192,16 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
 	/* config mod clock */
 	writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
 	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
-	       &ccm->nand0_clk_cfg);
+	       nand0_clk_cfg);
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	setbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	setbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	writel(CCM_NAND_CTRL_ENABLE | CCM_NAND_CTRL_PLL6 |
+	       CCM_NAND_CTRL_N(div_n) | CCM_NAND_CTRL_M(div_m),
+	       ccm + CCU_NAND1_CLK_CFG);
+#else
 	/* gate on nand clock */
 	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
@@ -195,6 +209,7 @@ static void sunxi_nfc_set_clk_rate(unsigned long hz)
 #else
 	setbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
 #endif
+#endif
 }
 
 static int sunxi_nfc_wait_int(struct sunxi_nfc *nfc, u32 flags,
@@ -689,6 +704,53 @@ static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
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
@@ -716,6 +778,9 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_reset_user_data_len(nfc);
+	sunxi_nfc_set_user_data_len(nfc, 4, 0);
+
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);
@@ -856,6 +921,9 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct mtd_info *mtd,
 	if (ret)
 		return ret;
 
+	sunxi_nfc_reset_user_data_len(nfc);
+	sunxi_nfc_set_user_data_len(nfc, 4, 0);
+
 	sunxi_nfc_randomizer_enable(mtd);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
 	       NFC_ACCESS_DIR | NFC_ECC_OP,
@@ -1276,7 +1344,6 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nfc *nfc,
 static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc)
 {
-	static const u8 strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
@@ -1303,12 +1370,12 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 
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
@@ -1722,9 +1789,22 @@ static int sunxi_nand_probe(struct udevice *dev)
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
@@ -1733,6 +1813,24 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
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
@@ -1740,6 +1838,10 @@ static const struct udevice_id sunxi_nand_ids[] = {
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
index 52200468d343..966b743e2613 100644
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
 
@@ -162,6 +173,9 @@
 
 #define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
 
+#define NFC_USER_DATA_LEN_MSK(step) \
+	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))
+
 #define NFC_DEFAULT_TIMEOUT_MS	1000
 
 #define NFC_SRAM_SIZE		1024
@@ -174,8 +188,10 @@
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
@@ -183,12 +199,21 @@
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
@@ -196,6 +221,9 @@ struct sunxi_nfc_caps {
 	unsigned int ecc_err_mask;
 	unsigned int ecc_mode_mask;
 	unsigned int random_en_mask;
+	const u8 *user_data_len_tab;
+	unsigned int nuser_data_tab;
+	unsigned int max_ecc_steps;
 };
 
 #endif
