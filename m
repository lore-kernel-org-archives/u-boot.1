Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D926CCCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDC4838F8;
	Thu, 16 Oct 2025 16:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IZXDRpQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97846838D5; Thu, 16 Oct 2025 16:30:02 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C036083906
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6E8E64E41117;
 Thu, 16 Oct 2025 14:29:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3EB1B6062C;
 Thu, 16 Oct 2025 14:29:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 618CA102F2320; 
 Thu, 16 Oct 2025 16:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760624995; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Ef7fVDr7nt7CQNEW05gW624gZOZs60g54TJRDnHRSPI=;
 b=IZXDRpQJyRAZzMD6YDP+QsMtNoDMylmOeC8mrYHw7XFaxP9VeVHSLAHvrM9r7OsQ0G4EP0
 DuvRKQW1IiXTSh/LiDUwcr8OEql9DdJTe6HrMxNrOGj9TO2bC3ndKD0KVwzNEiElkIkD/f
 ZYS4EDgDrqkkSdQeZya9fhWX3ZDUtG8TmD8BVi1BvN6k0KjOgdXmCOjhvDFYS6us/Q6aUN
 s3zVvyHIYzq9CnmfxQOiLphFfGEwx5ywtl/anriKCdqhQnDGq/i0r1joiZkHdPcyQYjYvI
 bWXivyHCyNtpiTj2D0yz0Xn+AOxZFto2f9gWJ/8mOoKsWCfOdrfevYIX42RHvA==
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
Subject: [PATCH 23/24] mtd: rawnand: sunxi_spl: add support for H6/H616 nand
 controller
Date: Thu, 16 Oct 2025 16:27:46 +0200
Message-ID: <20251016142752.2627710-24-richard.genoud@bootlin.com>
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

Introduce H6/H616 NAND controller support for SPL

The H616 NAND controller has the same base as A10/A23, with some
differences:
- MDMA is based on chained buffers
- its ECC supports up to 80bit per 1024bytes
- some registers layouts are a bit different, mainly due do the stronger
ECC.
- it uses USER_DATA_LEN registers along USER_DATA registers.
- it needs a specific clock for ECC and MBUS.

For SPL, most of the work was setting the clocks, adding the new
capability structure for H616 and supporting the new USER_DATA_LEN
registers.

Tested on Whatsminer H616 board (with and without scrambling, ECC)

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 board/sunxi/board.c                   | 17 ++++-
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 96 ++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 2929bc17f084..0cb8c4ba9942 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -307,15 +307,30 @@ static void nand_pinmux_setup(void)
 
 static void nand_clock_setup(void)
 {
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	void * const ccm = (void *)SUNXI_CCM_BASE;
+	void * const nand0_clk_cfg = ccm + CCU_NAND0_CLK_CFG;
+#else
 	struct sunxi_ccm_reg *const ccm =
 		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	u32 *nand0_clk_cfg = &ccm->nand0_clk_cfg;
+#endif
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	setbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	setbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	setbits_le32(ccm + CCU_NAND1_CLK_CFG, CCM_NAND_CTRL_ENABLE |
+		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
+#else
 	setbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #if defined CONFIG_MACH_SUN6I || defined CONFIG_MACH_SUN8I || \
     defined CONFIG_MACH_SUN9I || defined CONFIG_MACH_SUN50I
 	setbits_le32(&ccm->ahb_reset0_cfg, (1 << AHB_GATE_OFFSET_NAND0));
 #endif
-	setbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE | AHB_DIV_1);
+#endif
+	setbits_le32(nand0_clk_cfg, CCM_NAND_CTRL_ENABLE |
+		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
 }
 
 void board_nand_init(void)
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 0698db95b9c2..17e6031a9811 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -52,6 +52,10 @@ const uint16_t random_seed[128] = {
 	0x7c57, 0x0fbe, 0x46ce, 0x4939, 0x6b17, 0x37bb, 0x3e91, 0x76db,
 };
 
+static const u8 sunxi_user_data_len_h6[] = {
+	0, 4, 8, 12, 16, 20, 24, 28, 32
+};
+
 __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.has_ecc_block_512 = true,
 	.reg_spare_area = NFC_REG_A10_SPARE_AREA,
@@ -62,6 +66,18 @@ __maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
 	.random_en_mask = BIT(9),
 };
 
+__maybe_unused static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
+	.reg_user_data_len = NFC_REG_H6_USER_DATA_LEN,
+	.reg_spare_area = NFC_REG_H6_SPARE_AREA,
+	.reg_pat_found = NFC_REG_H6_PAT_FOUND,
+	.pat_found_mask = GENMASK(31, 0),
+	.ecc_mode_mask = GENMASK(15, 8),
+	.ecc_err_mask = GENMASK(31, 0),
+	.user_data_len_tab = sunxi_user_data_len_h6,
+	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
+	.random_en_mask = BIT(5),
+};
+
 #define DEFAULT_TIMEOUT_US	100000
 
 static int check_value_inner(int offset, int expected_bits,
@@ -197,7 +213,61 @@ static int nand_change_column(u16 column)
 	return 0;
 }
 
-static const int ecc_bytes[] = {32, 46, 54, 60, 74, 88, 102, 110, 116};
+/*
+ * On H6/H616 the user_data length has to be set in specific registers
+ * before writing.
+ */
+static void sunxi_nfc_reset_user_data_len(const struct nfc_config *nfc)
+{
+	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
+
+	/* not all SoCs have this register */
+	if (!NFC_REG_USER_DATA_LEN(nfc, 0))
+		return;
+
+	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
+		writel(0, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, i));
+}
+
+static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
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
+		printf("Unsupported length for user data reg: %d\n", len);
+		return;
+	}
+
+	val = readl(SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+
+	val &= ~NFC_USER_DATA_LEN_MSK(step);
+	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
+	writel(val, SUNXI_NFC_BASE + NFC_REG_USER_DATA_LEN(nfc, step));
+}
+
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+static const int ecc_bytes[] = {
+	32, 46, 54, 60, 74, 82, 88, 96, 102, 110, 116, 124, 130, 138, 144
+};
+#else
+static const int ecc_bytes[] = {
+	32, 46, 54, 60, 74, 88, 102, 110, 116
+};
+#endif
 
 static int nand_read_page(const struct nfc_config *conf, u32 offs,
 			  void *dest, int len)
@@ -247,8 +317,11 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
 		 * the data.
 		 */
 		nand_change_column(oob_off);
-		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 
+		sunxi_nfc_reset_user_data_len(conf);
+		sunxi_nfc_set_user_data_len(conf, 4, 0);
+
+		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);
 		/* Get the ECC status */
 		ecc_st = readl(SUNXI_NFC_BASE + NFC_REG_ECC_ST);
 
@@ -403,7 +476,11 @@ static int nand_detect_config(struct nfc_config *conf, u32 offs, void *dest)
 	if (conf->valid)
 		return 0;
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	conf->caps = &sunxi_nfc_h616_caps;
+#else
 	conf->caps = &sunxi_nfc_a10_caps;
+#endif
 
 	/*
 	 * Modern NANDs are more likely than legacy ones, so we start testing
@@ -504,15 +581,28 @@ unsigned int nand_page_size(void)
 
 void nand_deselect(void)
 {
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	void * const ccm = (void *)SUNXI_CCM_BASE;
+	void * const nand0_clk_cfg = ccm + CCU_NAND0_CLK_CFG;
+#else
 	struct sunxi_ccm_reg *const ccm =
 		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
+	u32 *nand0_clk_cfg = &ccm->nand0_clk_cfg;
+#endif
 
+#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_H6)
+	clrbits_le32(ccm + CCU_H6_NAND_GATE_RESET,
+		     (1 << GATE_SHIFT) | (1 << RESET_SHIFT));
+	clrbits_le32(ccm + CCU_H6_MBUS_GATE, (1 << MBUS_GATE_OFFSET_NAND));
+	clrbits_le32(ccm + CCU_NAND1_CLK_CFG, CCM_NAND_CTRL_ENABLE);
+#else
 	clrbits_le32(&ccm->ahb_gate0, (CLK_GATE_OPEN << AHB_GATE_OFFSET_NAND0));
 #ifdef CONFIG_MACH_SUN9I
 	clrbits_le32(&ccm->ahb_gate1, (1 << AHB_GATE_OFFSET_DMA));
 #else
 	clrbits_le32(&ccm->ahb_gate0, (1 << AHB_GATE_OFFSET_DMA));
 #endif
-	clrbits_le32(&ccm->nand0_clk_cfg, CCM_NAND_CTRL_ENABLE |
+#endif
+	clrbits_le32(nand0_clk_cfg, CCM_NAND_CTRL_ENABLE |
 		     CCM_NAND_CTRL_N(0) | CCM_NAND_CTRL_M(1));
 }
